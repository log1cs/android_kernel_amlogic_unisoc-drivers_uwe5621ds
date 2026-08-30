KERNEL_SRC ?= /lib/modules/$(shell uname -r)/build
M ?= $(shell pwd)

ifeq ($(O),)
out_dir := .
else
out_dir := $(O)
endif

DRIVER_KOS := BSP/uwe5621_bsp_sdio.ko WIFI/sprdwl_ng.ko

modules modules_install clean:
	$(MAKE) -C $(KERNEL_SRC) M=$(M)/BSP CFG_AML_WIFI_DEVICE_UWE5621=y $(@)
	$(MAKE) -C $(KERNEL_SRC) M=$(M)/WIFI CFG_AML_WIFI_DEVICE_UWE5621=y $(@)
	for ko in $(DRIVER_KOS); do \
		if [ -e $(out_dir)/$(M)/$$ko ]; then \
			ln -sf $(out_dir)/$(M)/$$ko $(out_dir)/$(M)/$$(basename $$ko); \
		fi; \
	done
