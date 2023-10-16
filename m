Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6BBCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 06:48:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60F7386ECA;
	Mon, 16 Oct 2023 08:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CzPV9jxC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66F7186B79; Mon, 16 Oct 2023 08:47:21 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE55B869D1
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 08:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5ac865d1358so1419874a12.3
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 23:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697438816; x=1698043616; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZXMf5UfRwHPQlXmTbVkSjKS7ARR6qG8bcLjzqlF2Al8=;
 b=CzPV9jxC1rR1WOtTYPCXp0dQjq5z5kx4ZRrNUKgKiNBKhRTq40qcqTi8rRrtpFGAZ1
 ycc8bg0N2IEOYyEqTg/0AhIh07ZPM1EpeDWkZcQC9npwL2YdwizWpcRybxVV0lKrT8sF
 676tiaCJXHsuZR4MlAS3w+btwyeRGcRWkKY/NYDfWzEk0lLQuCtGnNzdqMruvRmlOM1Y
 EumzmFHhz5/7r9felxtKVfnQ96haQMVG0OQVZEkVYwLsWy2WTFQSjM3t/5fOUKlXW3pL
 YGgarRwiFhufHkyvL8l0oMKeQhj4JgqbbetikNWnHGMFhKVCsV7UflnLSQqNaziqFnRT
 AFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697438816; x=1698043616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZXMf5UfRwHPQlXmTbVkSjKS7ARR6qG8bcLjzqlF2Al8=;
 b=FF+w0EWFNWkXfc8Pg44cT/+FpdlToefZDpbEOkHVjOGavH/e9K2mvo0Q68D45+ui3y
 GKqab9KuLImmQ3chdpTtIKQzm3CmaS8ev8b+wpW/Z4OGpwGtwVWQ39bzbM7hYgTxfpQm
 sp72IM86tRtucJUSlc2a371JV1aGhTagDTfJcLVyDwSeKZfYNCg91/DHfhF/p4NOF7Px
 DQx4vHb8e9hHF8KgQuStPKCiPOHXIHR2a9btBmNDvQujrcQkyiRaytmbQhOJECZ1XpE4
 XamTEqm7ckuaai9z77/ybmE+lNyv1H7oRGF+NQL4c0OLD746HoqRHIZB8rkoSxIm8Cnt
 zckg==
X-Gm-Message-State: AOJu0YwDwG8MN8GIY8MaN3y527Rz30irx9lnXirGYEk5bVeIy4Y6Q3cG
 6Da+9QYwjFQTr9bOFfatpEnqI5yXzqAiO7Cng/Y=
X-Google-Smtp-Source: AGHT+IG54EDK02APERv9b1FzwGF2OtpmEjYq65RtTE3zKcPjf7irQr5jtMwqpLubQUNVd0VKEScOMQ==
X-Received: by 2002:a17:90a:bf16:b0:27d:198:fcc2 with SMTP id
 c22-20020a17090abf1600b0027d0198fcc2mr11571586pjs.33.1697438816212; 
 Sun, 15 Oct 2023 23:46:56 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 iy6-20020a170903130600b001c877f27d1fsm7737299plb.11.2023.10.15.23.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:46:55 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v7 5/9] efi_loader: support boot from URI device path
Date: Mon, 16 Oct 2023 15:45:22 +0900
Message-Id: <20231016064526.2410856-6-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016064526.2410856-1-masahisa.kojima@linaro.org>
References: <20231016064526.2410856-1-masahisa.kojima@linaro.org>
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

This supports to boot from the URI device path.
When user selects the URI device path, bootmgr downloads
the file using wget into the address specified by loadaddr
env variable.
If the file is .iso or .img file, mount the image with blkmap
then try to boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
Since boot option indicating the default file is automatically
created when new disk is detected, system can boot by selecting
the automatically created blkmap boot option.
If the file is PE-COFF file, load and start the downloaded file.

The buffer used to download the ISO image file must be
reserved to avoid the unintended access to the image.
For PE-COFF file case, this memory reservation is done
in LoadImage Boot Service.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 include/efi_loader.h          |   2 +
 lib/efi_loader/Kconfig        |   9 ++
 lib/efi_loader/efi_bootmgr.c  | 198 ++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_dt_fixup.c |   2 +-
 4 files changed, 210 insertions(+), 1 deletion(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index e24410505f..106006127b 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -554,6 +554,8 @@ void efi_runtime_detach(void);
 /* efi_convert_pointer() - convert pointer to virtual address */
 efi_status_t EFIAPI efi_convert_pointer(efi_uintn_t debug_disposition,
 					void **address);
+/* add reserved memory to memory map */
+void efi_reserve_memory(u64 addr, u64 size, bool nomap);
 /* Carve out DT reserved memory ranges */
 void efi_carve_out_dt_rsv(void *fdt);
 /* Purge unused kaslr-seed */
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index d20aaab6db..5d99206dc3 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -479,4 +479,13 @@ config EFI_RISCV_BOOT_PROTOCOL
 	  replace the transfer via the device-tree. The latter is not
 	  possible on systems using ACPI.
 
+config EFI_HTTP_BOOT
+	bool "EFI HTTP Boot support"
+	depends on CMD_DNS
+	depends on CMD_WGET
+	depends on BLKMAP
+	help
+	  Enabling this option adds EFI HTTP Boot support. It allows to
+	  directly boot from network.
+
 endif
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index c8cf1c5506..c90b68f783 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -7,10 +7,14 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
+#include <blk.h>
+#include <blkmap.h>
 #include <common.h>
 #include <charset.h>
+#include <dm.h>
 #include <log.h>
 #include <malloc.h>
+#include <net.h>
 #include <efi_default_filename.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
@@ -168,6 +172,192 @@ out:
 	return ret;
 }
 
+/**
+ * mount_image() - mount the image with blkmap
+ *
+ * @lo_label:	u16 label string of load option
+ * @image_addr:	image address
+ * @image_size:	image size
+ * Return:	pointer to the UCLASS_BLK udevice, NULL if failed
+ */
+static struct udevice *mount_image(u16 *lo_label, ulong image_addr, int image_size)
+{
+	int err;
+	struct blkmap *bm;
+	struct udevice *bm_dev;
+	char *label = NULL, *p;
+
+	label = efi_alloc(utf16_utf8_strlen(lo_label) + 1);
+	if (!label)
+		return NULL;
+
+	p = label;
+	utf16_utf8_strcpy(&p, lo_label);
+	err = blkmap_create_ramdisk(label, image_addr, image_size, &bm_dev);
+	if (err) {
+		efi_free_pool(label);
+		return NULL;
+	}
+	bm = dev_get_plat(bm_dev);
+
+	efi_free_pool(label);
+
+	return bm->blk;
+}
+
+/**
+ * load_mounted_image() - load mounted image with default file
+ *
+ * @devnum:	target blkmap device
+ * @handle:	pointer to handle for newly installed image
+ * Return:	status code
+ */
+static efi_status_t load_mounted_image(int devnum, efi_handle_t *handle)
+{
+	u32 i;
+	u16 *bm_label, *p;
+	char device_name[12];
+	u16 *bootorder = NULL;
+	efi_uintn_t num, size;
+	void *load_option = NULL;
+	struct efi_load_option lo;
+	u16 varname[] = u"Boot####";
+	efi_status_t ret = EFI_NOT_FOUND;
+
+	snprintf(device_name, 12, "blkmap %d", devnum);
+	bm_label = calloc(1, (strlen(device_name) + 1) * sizeof(u16));
+	if (!bm_label)
+		return EFI_OUT_OF_RESOURCES;
+
+	p = bm_label;
+	utf8_utf16_strcpy(&p, device_name);
+
+	bootorder = efi_get_var(u"BootOrder", &efi_global_variable_guid, &size);
+	if (!bootorder)
+		goto out;
+
+	num = size / sizeof(u16);
+	for (i = 0; i < num; i++) {
+		efi_create_indexed_name(varname, sizeof(varname), "Boot",
+					bootorder[i]);
+		load_option = efi_get_var(varname, &efi_global_variable_guid, &size);
+		if (!load_option)
+			continue;
+
+		ret = efi_deserialize_load_option(&lo, load_option, &size);
+		if (ret != EFI_SUCCESS) {
+			free(load_option);
+			continue;
+		}
+
+		/* check whether the label indicates the target blkmap device */
+		if (u16_strncmp(bm_label, lo.label, u16_strlen(bm_label))) {
+			free(load_option);
+			continue;
+		}
+
+		/* check whether the boot option is automatically generated */
+		if (guidcmp(lo.optional_data, &efi_guid_bootmenu_auto_generated)) {
+			free(load_option);
+			continue;
+		}
+
+		ret = EFI_CALL(efi_load_image(true, efi_root, lo.file_path,
+					      NULL, 0, handle));
+		free(load_option);
+		goto out;
+	}
+
+	if (i == num)
+		ret = EFI_NOT_FOUND;
+out:
+	free(bm_label);
+	free(bootorder);
+
+	return ret;
+}
+
+/**
+ * try_load_from_uri_path() - Handle the URI device path
+ *
+ * @uridp:	uri device path
+ * @lo_label:	label of load option
+ * @handle:	pointer to handle for newly installed image
+ * Return:	status code
+ */
+static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
+					   u16 *lo_label,
+					   efi_handle_t *handle)
+{
+	char *s;
+	int err;
+	int uri_len;
+	u32 image_size;
+	efi_status_t ret;
+	ulong image_addr;
+
+	s = env_get("loadaddr");
+	if (!s) {
+		log_err("Error: loadaddr is not set\n");
+		return EFI_INVALID_PARAMETER;
+	}
+	image_addr = hextoul(s, NULL);
+	err = wget_with_dns(image_addr, uridp->uri);
+	if (err < 0)
+		return EFI_INVALID_PARAMETER;
+	image_size = env_get_hex("filesize", 0);
+	if (!image_size)
+		return EFI_INVALID_PARAMETER;
+
+	/*
+	 * If the file extension is ".iso" or ".img", mount it and try to load
+	 * the default file.
+	 * If the file is PE-COFF image, load the downloaded file.
+	 */
+	uri_len = strlen(uridp->uri);
+	if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
+	    !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
+		struct udevice *blk;
+		struct blk_desc *desc;
+
+		blk = mount_image(lo_label, image_addr, image_size);
+		if (!blk)
+			return EFI_LOAD_ERROR;
+
+		/*
+		 * When the new disk is detected, boot option is automatically
+		 * created if it has a default file.
+		 * Let's load the automatically created boot option.
+		 */
+		desc = dev_get_uclass_plat(blk);
+		ret = load_mounted_image(desc->devnum, handle);
+		if (ret != EFI_SUCCESS)
+			return ret;
+
+		/* whole ramdisk must be reserved */
+		efi_reserve_memory(image_addr, image_size, true);
+	} else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
+		efi_handle_t mem_handle = NULL;
+		struct efi_device_path *file_path;
+
+		file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
+					    (uintptr_t)image_addr, image_size);
+		ret = efi_install_multiple_protocol_interfaces(
+			&mem_handle, &efi_guid_device_path, file_path, NULL);
+		if (ret != EFI_SUCCESS)
+			return ret;
+
+		ret = EFI_CALL(efi_load_image(false, efi_root, file_path,
+					      (void *)image_addr, image_size,
+					      handle));
+	} else {
+		log_err("Error: file type is not supported\n");
+		return EFI_UNSUPPORTED;
+	}
+
+	return ret;
+}
+
 /**
  * try_load_entry() - try to load image for boot option
  *
@@ -211,6 +401,14 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
 		if (EFI_DP_TYPE(lo.file_path, MEDIA_DEVICE, FILE_PATH)) {
 			/* file_path doesn't contain a device path */
 			ret = try_load_from_short_path(lo.file_path, handle);
+		} else if (EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE, MSG_URI)) {
+			if (IS_ENABLED(CONFIG_EFI_HTTP_BOOT))
+				ret = try_load_from_uri_path(
+					(struct efi_device_path_uri *)
+						lo.file_path,
+					lo.label, handle);
+			else
+				ret = EFI_LOAD_ERROR;
 		} else {
 			file_path = expand_media_path(lo.file_path);
 			ret = EFI_CALL(efi_load_image(true, efi_root, file_path,
diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup.c
index 838023c78f..edc515b9ff 100644
--- a/lib/efi_loader/efi_dt_fixup.c
+++ b/lib/efi_loader/efi_dt_fixup.c
@@ -22,7 +22,7 @@ const efi_guid_t efi_guid_dt_fixup_protocol = EFI_DT_FIXUP_PROTOCOL_GUID;
  * @nomap:	indicates that the memory range shall not be accessed by the
  *		UEFI payload
  */
-static void efi_reserve_memory(u64 addr, u64 size, bool nomap)
+void efi_reserve_memory(u64 addr, u64 size, bool nomap)
 {
 	int type;
 	efi_uintn_t ret;
-- 
2.34.1

