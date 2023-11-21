Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C60C61D88
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 01:33:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72B71875AB;
	Tue, 21 Nov 2023 02:31:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cPAFVmN4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63943875AB; Tue, 21 Nov 2023 02:31:10 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E372C863FD
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 02:30:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cc703d2633so10670365ad.0
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 17:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700530245; x=1701135045; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P9MLLKtcjwc04FJmiopPsNAWSNVAbA4vr9K4vFjWhQM=;
 b=cPAFVmN4cZWbGnqiLjPUc0Q5+SeAOlmWg9H+/lrp/mMbfqAuv28KhWpfSWO8jb2dPH
 mZhl591u738L0xghn25BdyoIIU7TujnyTTGEuNXkhiQc/L9Id7AM68egehL6mhQ+xlnT
 02ujvk0wPrJM2B8rbz2TrUsRrGj0rNN0jeFfnlE2thyjBxv5+bAkcBZuEXl6VJCtZXKI
 yq/jQArj/uPJjSzVVuvgH1eaaMirymuz2bP+CxwKkGnRpAwpvGwPKHntlZPUjhnB0bXQ
 qHLQj/NcEBqfzPq9GPekZqLvUOHrnVmjjb254f39RixFKXzp4nbBH96B20vGcd59HSXl
 qnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700530245; x=1701135045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P9MLLKtcjwc04FJmiopPsNAWSNVAbA4vr9K4vFjWhQM=;
 b=QNpGcFFP231cfkvgVMGkqUJsg95N8YpcJrH+64AX77Ot90qoIHo6pHTtj+Sb0WosZK
 4TRhODNhQxMo2UqI1TcF7d/CaAqBFZgmauSkqOGTeBailuXnT3lLWBISudWoQ05jP+lR
 MYO25DOgzlsi6lBWqS31RYAjK3YFKKFqfxLG8Zsop9o3+eRWQgT/1Krw1dkQlYQD5o8o
 8j5e61hED4nxHVYpCuYGNaVfw4mTac/MnvjeaGdk/Dpvu7AC7cHxQk7aNsR6f+yQeW9B
 aFaS2i/3sbcmdVyy6EiM7CUD3BjVmU1+q5JTSsWR1f83vmUQJkHwxo2X0xomHi8CZTqZ
 pedw==
X-Gm-Message-State: AOJu0Yxb/gsHdYiYXej7vg9ho5YLeu1iPPnGiWVv1kQAsyXnOAy6MBdz
 vYkm74amAt1ocwhUBoVRUU2t4Q==
X-Google-Smtp-Source: AGHT+IHoZMU/heJg9+uRU2hGGi1995ZhZxPVJfJ32pQKtagZ3ThNaCinWi9i/UFgp+brLwSln4FFfw==
X-Received: by 2002:a17:903:2312:b0:1cf:5854:41fa with SMTP id
 d18-20020a170903231200b001cf585441famr8574408plh.1.1700530244695; 
 Mon, 20 Nov 2023 17:30:44 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:f6af:a59c:7ca:897f])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a170902d38900b001c8a0879805sm3612508pld.206.2023.11.20.17.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 17:30:44 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 06/12] cmd: bootefi: move library interfaces under
 lib/efi_loader
Date: Tue, 21 Nov 2023 10:29:44 +0900
Message-Id: <20231121012950.156539-7-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121012950.156539-1-takahiro.akashi@linaro.org>
References: <20231121012950.156539-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

In the prior commits, interfaces for executing EFI binary and boot manager
were carved out. Move them under efi_loader directory so that they can
be called from other places without depending on bootefi command.

Only efi_selftest-related code will be left in bootefi.c.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 cmd/bootefi.c                | 539 +----------------------------------
 include/efi_loader.h         |  10 +
 lib/efi_loader/efi_bootmgr.c | 529 ++++++++++++++++++++++++++++++++++
 3 files changed, 550 insertions(+), 528 deletions(-)

diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index 7930c99def44..9cf9027bf409 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -7,545 +7,22 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
-#include <common.h>
-#include <bootm.h>
-#include <charset.h>
 #include <command.h>
-#include <dm.h>
+#include <efi.h>
 #include <efi_loader.h>
-#include <efi_selftest.h>
-#include <env.h>
-#include <errno.h>
-#include <image.h>
+#include <exports.h>
 #include <log.h>
 #include <malloc.h>
-#include <asm/global_data.h>
-#include <linux/libfdt.h>
-#include <linux/libfdt_env.h>
 #include <mapmem.h>
-#include <memalign.h>
+#include <vsprintf.h>
 #include <asm-generic/sections.h>
-#include <linux/linkage.h>
+#include <asm/global_data.h>
+#include <linux/string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
 static struct efi_device_path *test_image_path;
 static struct efi_device_path *test_device_path;
-static struct efi_device_path *bootefi_image_path;
-static struct efi_device_path *bootefi_device_path;
-static void *image_addr;
-static size_t image_size;
-
-/**
- * efi_get_image_parameters() - return image parameters
- *
- * @img_addr:		address of loaded image in memory
- * @img_size:		size of loaded image
- */
-void efi_get_image_parameters(void **img_addr, size_t *img_size)
-{
-	*img_addr = image_addr;
-	*img_size = image_size;
-}
-
-/**
- * efi_clear_bootdev() - clear boot device
- */
-static void efi_clear_bootdev(void)
-{
-	efi_free_pool(bootefi_device_path);
-	efi_free_pool(bootefi_image_path);
-	bootefi_device_path = NULL;
-	bootefi_image_path = NULL;
-	image_addr = NULL;
-	image_size = 0;
-}
-
-/**
- * efi_set_bootdev() - set boot device
- *
- * This function is called when a file is loaded, e.g. via the 'load' command.
- * We use the path to this file to inform the UEFI binary about the boot device.
- *
- * @dev:		device, e.g. "MMC"
- * @devnr:		number of the device, e.g. "1:2"
- * @path:		path to file loaded
- * @buffer:		buffer with file loaded
- * @buffer_size:	size of file loaded
- */
-void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
-		     void *buffer, size_t buffer_size)
-{
-	struct efi_device_path *device, *image;
-	efi_status_t ret;
-
-	log_debug("dev=%s, devnr=%s, path=%s, buffer=%p, size=%zx\n", dev,
-		  devnr, path, buffer, buffer_size);
-
-	/* Forget overwritten image */
-	if (buffer + buffer_size >= image_addr &&
-	    image_addr + image_size >= buffer)
-		efi_clear_bootdev();
-
-	/* Remember only PE-COFF and FIT images */
-	if (efi_check_pe(buffer, buffer_size, NULL) != EFI_SUCCESS) {
-		if (IS_ENABLED(CONFIG_FIT) &&
-		    !fit_check_format(buffer, IMAGE_SIZE_INVAL)) {
-			/*
-			 * FIT images of type EFI_OS are started via command
-			 * bootm. We should not use their boot device with the
-			 * bootefi command.
-			 */
-			buffer = 0;
-			buffer_size = 0;
-		} else {
-			log_debug("- not remembering image\n");
-			return;
-		}
-	}
-
-	/* efi_set_bootdev() is typically called repeatedly, recover memory */
-	efi_clear_bootdev();
-
-	image_addr = buffer;
-	image_size = buffer_size;
-
-	ret = efi_dp_from_name(dev, devnr, path, &device, &image);
-	if (ret == EFI_SUCCESS) {
-		bootefi_device_path = device;
-		if (image) {
-			/* FIXME: image should not contain device */
-			struct efi_device_path *image_tmp = image;
-
-			efi_dp_split_file_path(image, &device, &image);
-			efi_free_pool(image_tmp);
-		}
-		bootefi_image_path = image;
-		log_debug("- boot device %pD\n", device);
-		if (image)
-			log_debug("- image %pD\n", image);
-	} else {
-		log_debug("- efi_dp_from_name() failed, err=%lx\n", ret);
-		efi_clear_bootdev();
-	}
-}
-
-/**
- * efi_env_set_load_options() - set load options from environment variable
- *
- * @handle:		the image handle
- * @env_var:		name of the environment variable
- * @load_options:	pointer to load options (output)
- * Return:		status code
- */
-static efi_status_t efi_env_set_load_options(efi_handle_t handle,
-					     const char *env_var,
-					     u16 **load_options)
-{
-	const char *env = env_get(env_var);
-	size_t size;
-	u16 *pos;
-	efi_status_t ret;
-
-	*load_options = NULL;
-	if (!env)
-		return EFI_SUCCESS;
-	size = sizeof(u16) * (utf8_utf16_strlen(env) + 1);
-	pos = calloc(size, 1);
-	if (!pos)
-		return EFI_OUT_OF_RESOURCES;
-	*load_options = pos;
-	utf8_utf16_strcpy(&pos, env);
-	ret = efi_set_load_options(handle, size, *load_options);
-	if (ret != EFI_SUCCESS) {
-		free(*load_options);
-		*load_options = NULL;
-	}
-	return ret;
-}
-
-#if !CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE)
-
-/**
- * copy_fdt() - Copy the device tree to a new location available to EFI
- *
- * The FDT is copied to a suitable location within the EFI memory map.
- * Additional 12 KiB are added to the space in case the device tree needs to be
- * expanded later with fdt_open_into().
- *
- * @fdtp:	On entry a pointer to the flattened device tree.
- *		On exit a pointer to the copy of the flattened device tree.
- *		FDT start
- * Return:	status code
- */
-static efi_status_t copy_fdt(void **fdtp)
-{
-	unsigned long fdt_ram_start = -1L, fdt_pages;
-	efi_status_t ret = 0;
-	void *fdt, *new_fdt;
-	u64 new_fdt_addr;
-	uint fdt_size;
-	int i;
-
-	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
-		u64 ram_start = gd->bd->bi_dram[i].start;
-		u64 ram_size = gd->bd->bi_dram[i].size;
-
-		if (!ram_size)
-			continue;
-
-		if (ram_start < fdt_ram_start)
-			fdt_ram_start = ram_start;
-	}
-
-	/*
-	 * Give us at least 12 KiB of breathing room in case the device tree
-	 * needs to be expanded later.
-	 */
-	fdt = *fdtp;
-	fdt_pages = efi_size_in_pages(fdt_totalsize(fdt) + 0x3000);
-	fdt_size = fdt_pages << EFI_PAGE_SHIFT;
-
-	ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
-				 EFI_ACPI_RECLAIM_MEMORY, fdt_pages,
-				 &new_fdt_addr);
-	if (ret != EFI_SUCCESS) {
-		log_err("ERROR: Failed to reserve space for FDT\n");
-		goto done;
-	}
-	new_fdt = (void *)(uintptr_t)new_fdt_addr;
-	memcpy(new_fdt, fdt, fdt_totalsize(fdt));
-	fdt_set_totalsize(new_fdt, fdt_size);
-
-	*fdtp = (void *)(uintptr_t)new_fdt_addr;
-done:
-	return ret;
-}
-
-/**
- * get_config_table() - get configuration table
- *
- * @guid:	GUID of the configuration table
- * Return:	pointer to configuration table or NULL
- */
-static void *get_config_table(const efi_guid_t *guid)
-{
-	size_t i;
-
-	for (i = 0; i < systab.nr_tables; i++) {
-		if (!guidcmp(guid, &systab.tables[i].guid))
-			return systab.tables[i].table;
-	}
-	return NULL;
-}
-
-#endif /* !CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE) */
-
-/**
- * efi_install_fdt() - install device tree
- *
- * If fdt is not EFI_FDT_USE_INTERNAL, the device tree located at that memory
- * address will will be installed as configuration table, otherwise the device
- * tree located at the address indicated by environment variable fdt_addr or as
- * fallback fdtcontroladdr will be used.
- *
- * On architectures using ACPI tables device trees shall not be installed as
- * configuration table.
- *
- * @fdt:	address of device tree or EFI_FDT_USE_INTERNAL to use the
- *		the hardware device tree as indicated by environment variable
- *		fdt_addr or as fallback the internal device tree as indicated by
- *		the environment variable fdtcontroladdr
- * Return:	status code
- */
-efi_status_t efi_install_fdt(void *fdt)
-{
-	/*
-	 * The EBBR spec requires that we have either an FDT or an ACPI table
-	 * but not both.
-	 */
-#if CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE)
-	if (fdt) {
-		log_warning("WARNING: Can't have ACPI table and device tree - ignoring DT.\n");
-		return EFI_SUCCESS;
-	}
-#else
-	struct bootm_headers img = { 0 };
-	efi_status_t ret;
-
-	if (fdt == EFI_FDT_USE_INTERNAL) {
-		const char *fdt_opt;
-		uintptr_t fdt_addr;
-
-		/* Look for device tree that is already installed */
-		if (get_config_table(&efi_guid_fdt))
-			return EFI_SUCCESS;
-		/* Check if there is a hardware device tree */
-		fdt_opt = env_get("fdt_addr");
-		/* Use our own device tree as fallback */
-		if (!fdt_opt) {
-			fdt_opt = env_get("fdtcontroladdr");
-			if (!fdt_opt) {
-				log_err("ERROR: need device tree\n");
-				return EFI_NOT_FOUND;
-			}
-		}
-		fdt_addr = hextoul(fdt_opt, NULL);
-		if (!fdt_addr) {
-			log_err("ERROR: invalid $fdt_addr or $fdtcontroladdr\n");
-			return EFI_LOAD_ERROR;
-		}
-		fdt = map_sysmem(fdt_addr, 0);
-	}
-
-	/* Install device tree */
-	if (fdt_check_header(fdt)) {
-		log_err("ERROR: invalid device tree\n");
-		return EFI_LOAD_ERROR;
-	}
-
-	/* Prepare device tree for payload */
-	ret = copy_fdt(&fdt);
-	if (ret) {
-		log_err("ERROR: out of memory\n");
-		return EFI_OUT_OF_RESOURCES;
-	}
-
-	if (image_setup_libfdt(&img, fdt, 0, NULL)) {
-		log_err("ERROR: failed to process device tree\n");
-		return EFI_LOAD_ERROR;
-	}
-
-	/* Create memory reservations as indicated by the device tree */
-	efi_carve_out_dt_rsv(fdt);
-
-	efi_try_purge_kaslr_seed(fdt);
-
-	if (CONFIG_IS_ENABLED(EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
-		ret = efi_tcg2_measure_dtb(fdt);
-		if (ret == EFI_SECURITY_VIOLATION) {
-			log_err("ERROR: failed to measure DTB\n");
-			return ret;
-		}
-	}
-
-	/* Install device tree as UEFI table */
-	ret = efi_install_configuration_table(&efi_guid_fdt, fdt);
-	if (ret != EFI_SUCCESS) {
-		log_err("ERROR: failed to install device tree\n");
-		return ret;
-	}
-#endif /* GENERATE_ACPI_TABLE */
-
-	return EFI_SUCCESS;
-}
-
-/**
- * do_bootefi_exec() - execute EFI binary
- *
- * The image indicated by @handle is started. When it returns the allocated
- * memory for the @load_options is freed.
- *
- * @handle:		handle of loaded image
- * @load_options:	load options
- * Return:		status code
- *
- * Load the EFI binary into a newly assigned memory unwinding the relocation
- * information, install the loaded image protocol, and call the binary.
- */
-static efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options)
-{
-	efi_status_t ret;
-	efi_uintn_t exit_data_size = 0;
-	u16 *exit_data = NULL;
-	struct efi_event *evt;
-
-	/* On ARM switch from EL3 or secure mode to EL2 or non-secure mode */
-	switch_to_non_secure_mode();
-
-	/*
-	 * The UEFI standard requires that the watchdog timer is set to five
-	 * minutes when invoking an EFI boot option.
-	 *
-	 * Unified Extensible Firmware Interface (UEFI), version 2.7 Errata A
-	 * 7.5. Miscellaneous Boot Services - EFI_BOOT_SERVICES.SetWatchdogTimer
-	 */
-	ret = efi_set_watchdog(300);
-	if (ret != EFI_SUCCESS) {
-		log_err("ERROR: Failed to set watchdog timer\n");
-		goto out;
-	}
-
-	/* Call our payload! */
-	ret = EFI_CALL(efi_start_image(handle, &exit_data_size, &exit_data));
-	if (ret != EFI_SUCCESS) {
-		log_err("## Application failed, r = %lu\n",
-			ret & ~EFI_ERROR_MASK);
-		if (exit_data) {
-			log_err("## %ls\n", exit_data);
-			efi_free_pool(exit_data);
-		}
-	}
-
-	efi_restore_gd();
-
-out:
-	free(load_options);
-
-	if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
-		if (efi_initrd_deregister() != EFI_SUCCESS)
-			log_err("Failed to remove loadfile2 for initrd\n");
-	}
-
-	/* Notify EFI_EVENT_GROUP_RETURN_TO_EFIBOOTMGR event group. */
-	list_for_each_entry(evt, &efi_events, link) {
-		if (evt->group &&
-		    !guidcmp(evt->group,
-			     &efi_guid_event_group_return_to_efibootmgr)) {
-			efi_signal_event(evt);
-			EFI_CALL(systab.boottime->close_event(evt));
-			break;
-		}
-	}
-
-	/* Control is returned to U-Boot, disable EFI watchdog */
-	efi_set_watchdog(0);
-
-	return ret;
-}
-
-/**
- * efi_bootmgr_run() - execute EFI boot manager
- * fdt:	Flat device tree
- *
- * Invoke EFI boot manager and execute a binary depending on
- * boot options. If @fdt is not NULL, it will be passed to
- * the executed binary.
- *
- * Return:	status code
- */
-static efi_status_t efi_bootmgr_run(void *fdt)
-{
-	efi_handle_t handle;
-	void *load_options;
-	efi_status_t ret;
-
-	/* Initialize EFI drivers */
-	ret = efi_init_obj_list();
-	if (ret != EFI_SUCCESS) {
-		log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
-			ret & ~EFI_ERROR_MASK);
-		return CMD_RET_FAILURE;
-	}
-
-	ret = efi_install_fdt(fdt);
-	if (ret != EFI_SUCCESS)
-		return ret;
-
-	ret = efi_bootmgr_load(&handle, &load_options);
-	if (ret != EFI_SUCCESS) {
-		log_notice("EFI boot manager: Cannot load any image\n");
-		return ret;
-	}
-
-	return do_bootefi_exec(handle, load_options);
-}
-
-/**
- * efi_run_image() - run loaded UEFI image
- *
- * @source_buffer:	memory address of the UEFI image
- * @source_size:	size of the UEFI image
- * Return:		status code
- */
-efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
-{
-	efi_handle_t mem_handle = NULL, handle;
-	struct efi_device_path *file_path = NULL;
-	struct efi_device_path *msg_path;
-	efi_status_t ret, ret2;
-	u16 *load_options;
-
-	if (!bootefi_device_path || !bootefi_image_path) {
-		log_debug("Not loaded from disk\n");
-		/*
-		 * Special case for efi payload not loaded from disk,
-		 * such as 'bootefi hello' or for example payload
-		 * loaded directly into memory via JTAG, etc:
-		 */
-		file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
-					    (uintptr_t)source_buffer,
-					    source_size);
-		/*
-		 * Make sure that device for device_path exist
-		 * in load_image(). Otherwise, shell and grub will fail.
-		 */
-		ret = efi_install_multiple_protocol_interfaces(&mem_handle,
-							       &efi_guid_device_path,
-							       file_path, NULL);
-		if (ret != EFI_SUCCESS)
-			goto out;
-		msg_path = file_path;
-	} else {
-		file_path = efi_dp_append(bootefi_device_path,
-					  bootefi_image_path);
-		msg_path = bootefi_image_path;
-		log_debug("Loaded from disk\n");
-	}
-
-	log_info("Booting %pD\n", msg_path);
-
-	ret = EFI_CALL(efi_load_image(false, efi_root, file_path, source_buffer,
-				      source_size, &handle));
-	if (ret != EFI_SUCCESS) {
-		log_err("Loading image failed\n");
-		goto out;
-	}
-
-	/* Transfer environment variable as load options */
-	ret = efi_env_set_load_options(handle, "bootargs", &load_options);
-	if (ret != EFI_SUCCESS)
-		goto out;
-
-	ret = do_bootefi_exec(handle, load_options);
-
-out:
-	ret2 = efi_uninstall_multiple_protocol_interfaces(mem_handle,
-							  &efi_guid_device_path,
-							  file_path, NULL);
-	efi_free_pool(file_path);
-	return (ret != EFI_SUCCESS) ? ret : ret2;
-}
-
-/**
- * efi_binary_run() - run loaded UEFI image
- *
- * @image:	memory address of the UEFI image
- * @size:	size of the UEFI image
- *
- * Execute an EFI binary image loaded at @image.
- * @size may be zero if the binary is loaded with U-Boot load command.
- *
- * Return:	status code
- */
-static efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
-{
-	efi_status_t ret;
-
-	/* Initialize EFI drivers */
-	ret = efi_init_obj_list();
-	if (ret != EFI_SUCCESS) {
-		log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
-			ret & ~EFI_ERROR_MASK);
-		return ret;
-	}
-
-	ret = efi_install_fdt(fdt);
-	if (ret != EFI_SUCCESS)
-		return ret;
-
-	return efi_run_image(image, size);
-}
 
 static efi_status_t bootefi_run_prepare(const char *load_options_path,
 		struct efi_device_path *device_path,
@@ -658,6 +135,8 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 	char *p;
 	void *fdt, *image_buf;
 	unsigned long addr, size;
+	void *image_addr;
+	size_t image_size;
 
 	if (argc < 2)
 		return CMD_RET_USAGE;
@@ -709,6 +188,7 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 	    !strcmp(argv[1], "hello")) {
 		image_buf = __efi_helloworld_begin;
 		size = __efi_helloworld_end - __efi_helloworld_begin;
+		/* TODO: not sure calling clear function is necessary */
 		efi_clear_bootdev();
 	} else {
 		addr = strtoul(argv[1], NULL, 16);
@@ -724,6 +204,9 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 				return CMD_RET_USAGE;
 			efi_clear_bootdev();
 		} else {
+			/* Image should be already loaded */
+			efi_get_image_parameters(&image_addr, &image_size);
+
 			if (image_buf != image_addr) {
 				log_err("No UEFI binary known at %s\n",
 					argv[1]);
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 44436d346286..34e7fbbf1840 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -90,6 +90,8 @@ efi_status_t efi_add_runtime_mmio(void *mmio_ptr, u64 len);
  * back to u-boot world
  */
 void efi_restore_gd(void);
+/* Call this to unset the current device name */
+void efi_clear_bootdev(void);
 /* Call this to set the current device name */
 void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
 		     void *buffer, size_t buffer_size);
@@ -114,6 +116,7 @@ static inline efi_status_t efi_add_runtime_mmio(void *mmio_ptr, u64 len)
 
 /* No loader configured, stub out EFI_ENTRY */
 static inline void efi_restore_gd(void) { }
+static inline void efi_clear_bootdev(void) { }
 static inline void efi_set_bootdev(const char *dev, const char *devnr,
 				   const char *path, void *buffer,
 				   size_t buffer_size) { }
@@ -527,14 +530,21 @@ efi_status_t efi_bootmgr_get_unused_bootoption(u16 *buf,
 efi_status_t efi_bootmgr_update_media_device_boot_option(void);
 /* Delete selected boot option */
 efi_status_t efi_bootmgr_delete_boot_option(u16 boot_index);
+/* Invoke EFI boot manager */
+efi_status_t efi_bootmgr_run(void *fdt);
 /* search the boot option index in BootOrder */
 bool efi_search_bootorder(u16 *bootorder, efi_uintn_t num, u32 target, u32 *index);
 /* Set up console modes */
 void efi_setup_console_size(void);
+/* Set up load options from environment variable */
+efi_status_t efi_env_set_load_options(efi_handle_t handle, const char *env_var,
+				      u16 **load_options);
 /* Install device tree */
 efi_status_t efi_install_fdt(void *fdt);
 /* Run loaded UEFI image */
 efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size);
+/* Run loaded UEFI image with given fdt */
+efi_status_t efi_binary_run(void *image, size_t size, void *fdt);
 /* Initialize variable services */
 efi_status_t efi_init_variables(void);
 /* Notify ExitBootServices() is called */
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 48153bd5ffbb..e910f1bb2a23 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -3,6 +3,8 @@
  *  EFI boot manager
  *
  *  Copyright (c) 2017 Rob Clark
+ *  For the code moved from cmd/bootefi.c
+ *  Copyright (c) 2016 Alexander Graf
  */
 
 #define LOG_CATEGORY LOGC_EFI
@@ -20,6 +22,17 @@
 #include <efi_variable.h>
 #include <asm/unaligned.h>
 
+/* TODO: temporarily added here; clean up later */
+#include <bootm.h>
+#include <efi_selftest.h>
+#include <env.h>
+#include <mapmem.h>
+#include <asm/global_data.h>
+#include <linux/libfdt.h>
+#include <linux/libfdt_env.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
 static const struct efi_boot_services *bs;
 static const struct efi_runtime_services *rs;
 
@@ -1115,3 +1128,519 @@ out:
 		return EFI_SUCCESS;
 	return ret;
 }
+
+static struct efi_device_path *bootefi_image_path;
+static struct efi_device_path *bootefi_device_path;
+static void *image_addr;
+static size_t image_size;
+
+/**
+ * efi_get_image_parameters() - return image parameters
+ *
+ * @img_addr:		address of loaded image in memory
+ * @img_size:		size of loaded image
+ */
+void efi_get_image_parameters(void **img_addr, size_t *img_size)
+{
+	*img_addr = image_addr;
+	*img_size = image_size;
+}
+
+/**
+ * efi_clear_bootdev() - clear boot device
+ */
+void efi_clear_bootdev(void)
+{
+	efi_free_pool(bootefi_device_path);
+	efi_free_pool(bootefi_image_path);
+	bootefi_device_path = NULL;
+	bootefi_image_path = NULL;
+	image_addr = NULL;
+	image_size = 0;
+}
+
+/**
+ * efi_set_bootdev() - set boot device
+ *
+ * This function is called when a file is loaded, e.g. via the 'load' command.
+ * We use the path to this file to inform the UEFI binary about the boot device.
+ *
+ * @dev:		device, e.g. "MMC"
+ * @devnr:		number of the device, e.g. "1:2"
+ * @path:		path to file loaded
+ * @buffer:		buffer with file loaded
+ * @buffer_size:	size of file loaded
+ */
+void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
+		     void *buffer, size_t buffer_size)
+{
+	struct efi_device_path *device, *image;
+	efi_status_t ret;
+
+	log_debug("dev=%s, devnr=%s, path=%s, buffer=%p, size=%zx\n", dev,
+		  devnr, path, buffer, buffer_size);
+
+	/* Forget overwritten image */
+	if (buffer + buffer_size >= image_addr &&
+	    image_addr + image_size >= buffer)
+		efi_clear_bootdev();
+
+	/* Remember only PE-COFF and FIT images */
+	if (efi_check_pe(buffer, buffer_size, NULL) != EFI_SUCCESS) {
+		if (IS_ENABLED(CONFIG_FIT) &&
+		    !fit_check_format(buffer, IMAGE_SIZE_INVAL)) {
+			/*
+			 * FIT images of type EFI_OS are started via command
+			 * bootm. We should not use their boot device with the
+			 * bootefi command.
+			 */
+			buffer = 0;
+			buffer_size = 0;
+		} else {
+			log_debug("- not remembering image\n");
+			return;
+		}
+	}
+
+	/* efi_set_bootdev() is typically called repeatedly, recover memory */
+	efi_clear_bootdev();
+
+	image_addr = buffer;
+	image_size = buffer_size;
+
+	ret = efi_dp_from_name(dev, devnr, path, &device, &image);
+	if (ret == EFI_SUCCESS) {
+		bootefi_device_path = device;
+		if (image) {
+			/* FIXME: image should not contain device */
+			struct efi_device_path *image_tmp = image;
+
+			efi_dp_split_file_path(image, &device, &image);
+			efi_free_pool(image_tmp);
+		}
+		bootefi_image_path = image;
+		log_debug("- boot device %pD\n", device);
+		if (image)
+			log_debug("- image %pD\n", image);
+	} else {
+		log_debug("- efi_dp_from_name() failed, err=%lx\n", ret);
+		efi_clear_bootdev();
+	}
+}
+
+/**
+ * efi_env_set_load_options() - set load options from environment variable
+ *
+ * @handle:		the image handle
+ * @env_var:		name of the environment variable
+ * @load_options:	pointer to load options (output)
+ * Return:		status code
+ */
+efi_status_t efi_env_set_load_options(efi_handle_t handle,
+				      const char *env_var,
+				      u16 **load_options)
+{
+	const char *env = env_get(env_var);
+	size_t size;
+	u16 *pos;
+	efi_status_t ret;
+
+	*load_options = NULL;
+	if (!env)
+		return EFI_SUCCESS;
+	size = sizeof(u16) * (utf8_utf16_strlen(env) + 1);
+	pos = calloc(size, 1);
+	if (!pos)
+		return EFI_OUT_OF_RESOURCES;
+	*load_options = pos;
+	utf8_utf16_strcpy(&pos, env);
+	ret = efi_set_load_options(handle, size, *load_options);
+	if (ret != EFI_SUCCESS) {
+		free(*load_options);
+		*load_options = NULL;
+	}
+	return ret;
+}
+
+#if !CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE)
+
+/**
+ * copy_fdt() - Copy the device tree to a new location available to EFI
+ *
+ * The FDT is copied to a suitable location within the EFI memory map.
+ * Additional 12 KiB are added to the space in case the device tree needs to be
+ * expanded later with fdt_open_into().
+ *
+ * @fdtp:	On entry a pointer to the flattened device tree.
+ *		On exit a pointer to the copy of the flattened device tree.
+ *		FDT start
+ * Return:	status code
+ */
+static efi_status_t copy_fdt(void **fdtp)
+{
+	unsigned long fdt_ram_start = -1L, fdt_pages;
+	efi_status_t ret = 0;
+	void *fdt, *new_fdt;
+	u64 new_fdt_addr;
+	uint fdt_size;
+	int i;
+
+	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+		u64 ram_start = gd->bd->bi_dram[i].start;
+		u64 ram_size = gd->bd->bi_dram[i].size;
+
+		if (!ram_size)
+			continue;
+
+		if (ram_start < fdt_ram_start)
+			fdt_ram_start = ram_start;
+	}
+
+	/*
+	 * Give us at least 12 KiB of breathing room in case the device tree
+	 * needs to be expanded later.
+	 */
+	fdt = *fdtp;
+	fdt_pages = efi_size_in_pages(fdt_totalsize(fdt) + 0x3000);
+	fdt_size = fdt_pages << EFI_PAGE_SHIFT;
+
+	ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
+				 EFI_ACPI_RECLAIM_MEMORY, fdt_pages,
+				 &new_fdt_addr);
+	if (ret != EFI_SUCCESS) {
+		log_err("ERROR: Failed to reserve space for FDT\n");
+		goto done;
+	}
+	new_fdt = (void *)(uintptr_t)new_fdt_addr;
+	memcpy(new_fdt, fdt, fdt_totalsize(fdt));
+	fdt_set_totalsize(new_fdt, fdt_size);
+
+	*fdtp = (void *)(uintptr_t)new_fdt_addr;
+done:
+	return ret;
+}
+
+/**
+ * get_config_table() - get configuration table
+ *
+ * @guid:	GUID of the configuration table
+ * Return:	pointer to configuration table or NULL
+ */
+static void *get_config_table(const efi_guid_t *guid)
+{
+	size_t i;
+
+	for (i = 0; i < systab.nr_tables; i++) {
+		if (!guidcmp(guid, &systab.tables[i].guid))
+			return systab.tables[i].table;
+	}
+	return NULL;
+}
+
+#endif /* !CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE) */
+
+/**
+ * efi_install_fdt() - install device tree
+ *
+ * If fdt is not EFI_FDT_USE_INTERNAL, the device tree located at that memory
+ * address will be installed as configuration table, otherwise the device
+ * tree located at the address indicated by environment variable fdt_addr or as
+ * fallback fdtcontroladdr will be used.
+ *
+ * On architectures using ACPI tables device trees shall not be installed as
+ * configuration table.
+ *
+ * @fdt:	address of device tree or EFI_FDT_USE_INTERNAL to use
+ *		the hardware device tree as indicated by environment variable
+ *		fdt_addr or as fallback the internal device tree as indicated by
+ *		the environment variable fdtcontroladdr
+ * Return:	status code
+ */
+efi_status_t efi_install_fdt(void *fdt)
+{
+	/*
+	 * The EBBR spec requires that we have either an FDT or an ACPI table
+	 * but not both.
+	 */
+#if CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE)
+	if (fdt) {
+		log_warning("WARNING: Can't have ACPI table and device tree - ignoring DT.\n");
+		return EFI_SUCCESS;
+	}
+#else
+	struct bootm_headers img = { 0 };
+	efi_status_t ret;
+
+	if (fdt == EFI_FDT_USE_INTERNAL) {
+		const char *fdt_opt;
+		uintptr_t fdt_addr;
+
+		/* Look for device tree that is already installed */
+		if (get_config_table(&efi_guid_fdt))
+			return EFI_SUCCESS;
+		/* Check if there is a hardware device tree */
+		fdt_opt = env_get("fdt_addr");
+		/* Use our own device tree as fallback */
+		if (!fdt_opt) {
+			fdt_opt = env_get("fdtcontroladdr");
+			if (!fdt_opt) {
+				log_err("ERROR: need device tree\n");
+				return EFI_NOT_FOUND;
+			}
+		}
+		fdt_addr = hextoul(fdt_opt, NULL);
+		if (!fdt_addr) {
+			log_err("ERROR: invalid $fdt_addr or $fdtcontroladdr\n");
+			return EFI_LOAD_ERROR;
+		}
+		fdt = map_sysmem(fdt_addr, 0);
+	}
+
+	/* Install device tree */
+	if (fdt_check_header(fdt)) {
+		log_err("ERROR: invalid device tree\n");
+		return EFI_LOAD_ERROR;
+	}
+
+	/* Prepare device tree for payload */
+	ret = copy_fdt(&fdt);
+	if (ret) {
+		log_err("ERROR: out of memory\n");
+		return EFI_OUT_OF_RESOURCES;
+	}
+
+	if (image_setup_libfdt(&img, fdt, 0, NULL)) {
+		log_err("ERROR: failed to process device tree\n");
+		return EFI_LOAD_ERROR;
+	}
+
+	/* Create memory reservations as indicated by the device tree */
+	efi_carve_out_dt_rsv(fdt);
+
+	efi_try_purge_kaslr_seed(fdt);
+
+	if (CONFIG_IS_ENABLED(EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
+		ret = efi_tcg2_measure_dtb(fdt);
+		if (ret == EFI_SECURITY_VIOLATION) {
+			log_err("ERROR: failed to measure DTB\n");
+			return ret;
+		}
+	}
+
+	/* Install device tree as UEFI table */
+	ret = efi_install_configuration_table(&efi_guid_fdt, fdt);
+	if (ret != EFI_SUCCESS) {
+		log_err("ERROR: failed to install device tree\n");
+		return ret;
+	}
+#endif /* GENERATE_ACPI_TABLE */
+
+	return EFI_SUCCESS;
+}
+
+/**
+ * do_bootefi_exec() - execute EFI binary
+ *
+ * The image indicated by @handle is started. When it returns the allocated
+ * memory for the @load_options is freed.
+ *
+ * @handle:		handle of loaded image
+ * @load_options:	load options
+ * Return:		status code
+ *
+ * Load the EFI binary into a newly assigned memory unwinding the relocation
+ * information, install the loaded image protocol, and call the binary.
+ */
+static efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options)
+{
+	efi_status_t ret;
+	efi_uintn_t exit_data_size = 0;
+	u16 *exit_data = NULL;
+	struct efi_event *evt;
+
+	/* On ARM switch from EL3 or secure mode to EL2 or non-secure mode */
+	switch_to_non_secure_mode();
+
+	/*
+	 * The UEFI standard requires that the watchdog timer is set to five
+	 * minutes when invoking an EFI boot option.
+	 *
+	 * Unified Extensible Firmware Interface (UEFI), version 2.7 Errata A
+	 * 7.5. Miscellaneous Boot Services - EFI_BOOT_SERVICES.SetWatchdogTimer
+	 */
+	ret = efi_set_watchdog(300);
+	if (ret != EFI_SUCCESS) {
+		log_err("ERROR: Failed to set watchdog timer\n");
+		goto out;
+	}
+
+	/* Call our payload! */
+	ret = EFI_CALL(efi_start_image(handle, &exit_data_size, &exit_data));
+	if (ret != EFI_SUCCESS) {
+		log_err("## Application failed, r = %lu\n",
+			ret & ~EFI_ERROR_MASK);
+		if (exit_data) {
+			log_err("## %ls\n", exit_data);
+			efi_free_pool(exit_data);
+		}
+	}
+
+	efi_restore_gd();
+
+out:
+	free(load_options);
+
+	if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
+		if (efi_initrd_deregister() != EFI_SUCCESS)
+			log_err("Failed to remove loadfile2 for initrd\n");
+	}
+
+	/* Notify EFI_EVENT_GROUP_RETURN_TO_EFIBOOTMGR event group. */
+	list_for_each_entry(evt, &efi_events, link) {
+		if (evt->group &&
+		    !guidcmp(evt->group,
+			     &efi_guid_event_group_return_to_efibootmgr)) {
+			efi_signal_event(evt);
+			EFI_CALL(systab.boottime->close_event(evt));
+			break;
+		}
+	}
+
+	/* Control is returned to U-Boot, disable EFI watchdog */
+	efi_set_watchdog(0);
+
+	return ret;
+}
+
+/**
+ * efi_bootmgr_run() - execute EFI boot manager
+ * fdt:	Flat device tree
+ *
+ * Invoke EFI boot manager and execute a binary depending on
+ * boot options. If @fdt is not NULL, it will be passed to
+ * the executed binary.
+ *
+ * Return:	status code
+ */
+efi_status_t efi_bootmgr_run(void *fdt)
+{
+	efi_handle_t handle;
+	void *load_options;
+	efi_status_t ret;
+
+	/* Initialize EFI drivers */
+	ret = efi_init_obj_list();
+	if (ret != EFI_SUCCESS) {
+		log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
+			ret & ~EFI_ERROR_MASK);
+		return CMD_RET_FAILURE;
+	}
+
+	ret = efi_install_fdt(fdt);
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	ret = efi_bootmgr_load(&handle, &load_options);
+	if (ret != EFI_SUCCESS) {
+		log_notice("EFI boot manager: Cannot load any image\n");
+		return ret;
+	}
+
+	return do_bootefi_exec(handle, load_options);
+}
+
+/**
+ * efi_run_image() - run loaded UEFI image
+ *
+ * @source_buffer:	memory address of the UEFI image
+ * @source_size:	size of the UEFI image
+ * Return:		status code
+ */
+efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
+{
+	efi_handle_t mem_handle = NULL, handle;
+	struct efi_device_path *file_path = NULL;
+	struct efi_device_path *msg_path;
+	efi_status_t ret, ret2;
+	u16 *load_options;
+
+	if (!bootefi_device_path || !bootefi_image_path) {
+		log_debug("Not loaded from disk\n");
+		/*
+		 * Special case for efi payload not loaded from disk,
+		 * such as 'bootefi hello' or for example payload
+		 * loaded directly into memory via JTAG, etc:
+		 */
+		file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
+					    (uintptr_t)source_buffer,
+					    source_size);
+		/*
+		 * Make sure that device for device_path exist
+		 * in load_image(). Otherwise, shell and grub will fail.
+		 */
+		ret = efi_install_multiple_protocol_interfaces(&mem_handle,
+							       &efi_guid_device_path,
+							       file_path, NULL);
+		if (ret != EFI_SUCCESS)
+			goto out;
+		msg_path = file_path;
+	} else {
+		file_path = efi_dp_append(bootefi_device_path,
+					  bootefi_image_path);
+		msg_path = bootefi_image_path;
+		log_debug("Loaded from disk\n");
+	}
+
+	log_info("Booting %pD\n", msg_path);
+
+	ret = EFI_CALL(efi_load_image(false, efi_root, file_path, source_buffer,
+				      source_size, &handle));
+	if (ret != EFI_SUCCESS) {
+		log_err("Loading image failed\n");
+		goto out;
+	}
+
+	/* Transfer environment variable as load options */
+	ret = efi_env_set_load_options(handle, "bootargs", &load_options);
+	if (ret != EFI_SUCCESS)
+		goto out;
+
+	ret = do_bootefi_exec(handle, load_options);
+
+out:
+	ret2 = efi_uninstall_multiple_protocol_interfaces(mem_handle,
+							  &efi_guid_device_path,
+							  file_path, NULL);
+	efi_free_pool(file_path);
+	return (ret != EFI_SUCCESS) ? ret : ret2;
+}
+
+/**
+ * efi_binary_run() - run loaded UEFI image
+ *
+ * @image:	memory address of the UEFI image
+ * @size:	size of the UEFI image
+ *
+ * Execute an EFI binary image loaded at @image.
+ * @size may be zero if the binary is loaded with U-Boot load command.
+ *
+ * Return:	status code
+ */
+efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
+{
+	efi_status_t ret;
+
+	/* Initialize EFI drivers */
+	ret = efi_init_obj_list();
+	if (ret != EFI_SUCCESS) {
+		log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
+			ret & ~EFI_ERROR_MASK);
+		return -1;
+	}
+
+	ret = efi_install_fdt(fdt);
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	return efi_run_image(image, size);
+}
-- 
2.34.1

