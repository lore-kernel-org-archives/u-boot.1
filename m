Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF755C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 05:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38C0287B29;
	Thu, 26 Oct 2023 07:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YlkaZ5PL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59C6687AFF; Thu, 26 Oct 2023 07:31:40 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECFFD87B09
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6bcbfecf314so118416b3a.1
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 22:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698298291; x=1698903091; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i0QWNGDWZWqFlbHbgmjf3Qu/D22Ot8nFYw5l5+ss66E=;
 b=YlkaZ5PLi7NOC+m34BCvp1ebs5cJQV0dMI8pKl0M72Wyne/J6No59N/jzs50iT/jCX
 DojGEI7O3eqd9BxroCH5PEIwO9sA852dVNGXw3pnU5vDo+J6uonv+yfPcq6pwUqDeERR
 qGQYNxMJlRmoJ76St5/n7X79gS074lCWM4mHDDiRyWDQISXUVnBvPbtLgfiBYg4B0KrP
 ebBaFl5dPRufGHH4vROjYvXMnlcHoUVDE7AtvQGSpHpWb4rGGDKm2Fg3b+f6reNuMsCu
 i1jLhFCaZ3hUxWcak6OPLp2Fa7+Pt/OMYEtJ77LdrcB8XXC07lMDqRgAVjx+IioyRkmd
 7uFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698298291; x=1698903091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i0QWNGDWZWqFlbHbgmjf3Qu/D22Ot8nFYw5l5+ss66E=;
 b=DU/V2uv70pyD9gVZUjGev8IT3mEhxC3sKCv0nXaobhZ/4b+jssLE0i7/HEKHoaeISY
 pYieIcNouQjqdn2nCfY1dI25JEYTJ4QL6Vw9O/Ep433tr8AvxpQcAWT3s9CXCwqzR4Zf
 msXFDsUGPSvL/fz17gM/eOY53le3T7Zr89rebBCzxUdSQw2g6XZ8S3hjDSqZADM+QGOg
 qNYCOnHlMTdHBj+RJ0urVr6/RKsuNd77T4Ttfzi/xtUW4PkV6XuNnWdv0Febec0H0hlw
 +cpD/DTtlN4JbLto0ZtFBC8PQhmN0LW5s3Pre0ApvuIUOseGXDi9LDnwKeNQWx5XVQlf
 FKOA==
X-Gm-Message-State: AOJu0YxRX6NmWe7+S6bI/axhAKkIchsTemRw6G4H8gQyoCHdS+cucHF2
 lblV4DMw71dC16GPkQEq+DJevHydotA8u8BCyK12Mw==
X-Google-Smtp-Source: AGHT+IGPKjwbSd3sn2Deoi9sixXxBeiNoLHQONOUhLo+0Yq9PQubm7WC8iTWWeNfgWbBJVuaQn1rCA==
X-Received: by 2002:a05:6a00:80ee:b0:68a:6cbe:35a7 with SMTP id
 ei46-20020a056a0080ee00b0068a6cbe35a7mr16957006pfb.2.1698298290977; 
 Wed, 25 Oct 2023 22:31:30 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:bca9:3af7:89e9:80b7])
 by smtp.gmail.com with ESMTPSA id
 fa13-20020a056a002d0d00b006c06804cd39sm440715pfb.153.2023.10.25.22.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 22:31:30 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: jbx6244@gmail.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 05/13] cmd: bootefi: move library interfaces under lib/efi_loader
Date: Thu, 26 Oct 2023 14:30:44 +0900
Message-Id: <20231026053052.622453-6-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026053052.622453-1-takahiro.akashi@linaro.org>
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
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

In the prior commits, interfaces for executing EFI binary or boot manager
were carved out. Move them under efi_loader directory so that they can
be called from other places without depending on bootefi command.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 cmd/bootefi.c                | 546 ++---------------------------------
 include/efi_loader.h         |  10 +
 lib/efi_loader/efi_bootmgr.c | 517 +++++++++++++++++++++++++++++++++
 3 files changed, 551 insertions(+), 522 deletions(-)

diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index 8b0bd07f1ff8..9cf9027bf409 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -7,531 +7,22 @@
 
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
+static struct efi_device_path *test_image_path;
+static struct efi_device_path *test_device_path;
 
 static efi_status_t bootefi_run_prepare(const char *load_options_path,
 		struct efi_device_path *device_path,
@@ -574,23 +65,26 @@ static efi_status_t bootefi_test_prepare
 	efi_status_t ret;
 
 	/* Construct a dummy device path */
-	bootefi_device_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE, 0, 0);
-	if (!bootefi_device_path)
+	test_device_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE, 0, 0);
+	if (!test_device_path)
 		return EFI_OUT_OF_RESOURCES;
 
-	bootefi_image_path = efi_dp_from_file(NULL, path);
-	if (!bootefi_image_path) {
+	test_image_path = efi_dp_from_file(NULL, path);
+	if (!test_image_path) {
 		ret = EFI_OUT_OF_RESOURCES;
 		goto failure;
 	}
 
-	ret = bootefi_run_prepare(load_options_path, bootefi_device_path,
-				  bootefi_image_path, image_objp,
+	ret = bootefi_run_prepare(load_options_path, test_device_path,
+				  test_image_path, image_objp,
 				  loaded_image_infop);
 	if (ret == EFI_SUCCESS)
 		return ret;
 
 failure:
+	efi_free_pool(test_device_path);
+	efi_free_pool(test_image_path);
+	/* TODO: not sure calling clear function is necessary */
 	efi_clear_bootdev();
 	return ret;
 }
@@ -615,6 +109,8 @@ static int do_efi_selftest(void)
 	ret = EFI_CALL(efi_selftest(&image_obj->header, &systab));
 	efi_restore_gd();
 	free(loaded_image_info->load_options);
+	efi_free_pool(test_device_path);
+	efi_free_pool(test_image_path);
 	if (ret != EFI_SUCCESS)
 		efi_delete_handle(&image_obj->header);
 	else
@@ -639,6 +135,8 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 	char *p;
 	void *fdt, *image_buf;
 	unsigned long addr, size;
+	void *image_addr;
+	size_t image_size;
 
 	if (argc < 2)
 		return CMD_RET_USAGE;
@@ -690,6 +188,7 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
 	    !strcmp(argv[1], "hello")) {
 		image_buf = __efi_helloworld_begin;
 		size = __efi_helloworld_end - __efi_helloworld_begin;
+		/* TODO: not sure calling clear function is necessary */
 		efi_clear_bootdev();
 	} else {
 		addr = strtoul(argv[1], NULL, 16);
@@ -705,6 +204,9 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
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
index 48d4999e56a9..031a8f76846a 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -91,6 +91,8 @@ efi_status_t efi_add_runtime_mmio(void *mmio_ptr, u64 len);
  * back to u-boot world
  */
 void efi_restore_gd(void);
+/* Call this to unset the current device name */
+void efi_clear_bootdev(void);
 /* Call this to set the current device name */
 void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
 		     void *buffer, size_t buffer_size);
@@ -115,6 +117,7 @@ static inline efi_status_t efi_add_runtime_mmio(void *mmio_ptr, u64 len)
 
 /* No loader configured, stub out EFI_ENTRY */
 static inline void efi_restore_gd(void) { }
+static inline void efi_clear_bootdev(void) { }
 static inline void efi_set_bootdev(const char *dev, const char *devnr,
 				   const char *path, void *buffer,
 				   size_t buffer_size) { }
@@ -526,14 +529,21 @@ efi_status_t efi_bootmgr_get_unused_bootoption(u16 *buf,
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
index a40762c74c83..cc8d88b4b025 100644
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
@@ -16,6 +18,17 @@
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
 
@@ -729,3 +742,507 @@ out:
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

