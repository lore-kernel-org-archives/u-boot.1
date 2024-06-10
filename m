Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E66C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 09:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5C32884BD;
	Mon, 10 Jun 2024 11:11:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="agydm4CM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ECCD88468; Mon, 10 Jun 2024 11:11:08 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E34488468
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 11:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A31623F6A3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 09:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718010665;
 bh=dfcHjlGP6BDZ5wCSyETMqpm10KsjlBo8IwjfPUpaAaM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=agydm4CMx5h9421fQDP4/0Lyc+eIFNR2MvqV2HLbLnC1gu8xUMO8gJSRIipin/1Cr
 McAgR1peoBNqDlDL4ghE5pUg9FpIjy9xk2CurZhwK0tX3gqTgWQJw2ncKcamOVK3W/
 dAOTcre34UV8KRUBa4HWRM0DoqAIo/BWSpPCbeo88DLHFCoHd5bE7k66rc/T/iZu/p
 0YdpyDrAGVIYXUrYiPdQeFuMMvRo+mKdu0aiamaSrGYVKZo1rn7eWDiQriw6hkxc0o
 CkqF0WI4sQJD47jOcb1ibIWhbugsK7j5g227N7INg/MEsAFa8Yg90P8Mm7Gi9rIEhy
 Mw7MIh/KAzBfA==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4218447b900so5600545e9.0
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 02:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718010665; x=1718615465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dfcHjlGP6BDZ5wCSyETMqpm10KsjlBo8IwjfPUpaAaM=;
 b=sNbEIrQ1k7tUCK3A8vFZrk9dPu40sQ6tdIRuDWQtZBGACVTjBBv8aiXdrwiYaHlXkg
 KzNaOd58VT1HGlvsqzrej9LJr/O5whk223Bql+ItZvb7/wUWqM6zPq3G0pFhtQrYwhIt
 lRgWIJrtadwR3VFseV6wj+F7XsVVMw4I0olRYC27MahfE+92Y7VYrh5fwT6Sm+Jo6M6y
 OsZmW0ZbmVyBprdeYuqI/3Fo5J9GHlJ7TwtNvWpn2ww4EsbaHEonJH5HTxPvTMVFHGaU
 N+WPl06rrRLmSeVYgmIYzlr+DDHewInalNlVJnMdWEhs3IXqI6BrKverNcb1dj8BoOP1
 5e2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQn/sUJ8yY573FR0CU8XJc2yDyMmAnFfspKIV2lT1AKhp/ToP//uwh+Ib+nA/ec4zRb3g6vhOHt+4vZV7PKR2MyRO/ug==
X-Gm-Message-State: AOJu0YxwDmkCFNTtwEm3vMib3CKkCntXSTL3fZ1SMiZNiJBRlu2jNG4Z
 HVHvpGe9cH3JuECMp8Sbahmz/JJLyqQ3CCWFq+ATXqJliA0VSiCeux1Yzocgluy13h4Us8KU9GB
 QkgrseSyhefglxgmBjsVoo2MpZWQ2RRoH7NhV2KsY9m2pfTi0UyNLblSjCRCCck7XnQw=
X-Received: by 2002:a05:600c:1c99:b0:421:81eb:7d5c with SMTP id
 5b1f17b1804b1-42181eb7f7bmr29400865e9.18.1718010665295; 
 Mon, 10 Jun 2024 02:11:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3XGom25/nUNUzMB6GYXiSRWphhUebmlIYGaVuZD3lsuJ8HKAkSWBnpctaLid/DmOuA+z1UQ==
X-Received: by 2002:a05:600c:1c99:b0:421:81eb:7d5c with SMTP id
 5b1f17b1804b1-42181eb7f7bmr29400655e9.18.1718010664858; 
 Mon, 10 Jun 2024 02:11:04 -0700 (PDT)
Received: from workstation5.. ([2a00:20:43:88b5:6b2b:e162:4c45:5c4c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42183c08f49sm41059465e9.6.2024.06.10.02.11.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 02:11:04 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 2/9] cmd: eficonfig: add support for setting fdt
Date: Mon, 10 Jun 2024 11:10:50 +0200
Message-ID: <20240610091057.64463-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240610091057.64463-1-heinrich.schuchardt@canonical.com>
References: <20240610091057.64463-1-heinrich.schuchardt@canonical.com>
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

We already support creating a load option where the device-path
field contains the concatenation of the binary device-path and
optionally the device path of the initrd which we expose via the
EFI_LOAD_FILE2_PROTOCOL.

Allow to append another device-path pointing to the device-tree
identified by the device-tree GUID.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
v3:
	No change
v2:
	Carve out a function efi_load_option_dp_join() which we can
	use both for the eficonfig and the efidebug command.
	Rename variables id_dp, final_dp_size.
---
 cmd/eficonfig.c             | 79 ++++++++++++++++++++++++++++---------
 include/efi_loader.h        | 14 +++++++
 lib/efi_loader/efi_helper.c | 44 +++++++++++++++++++++
 3 files changed, 119 insertions(+), 18 deletions(-)

diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
index b13d9a3d2d9..a12df1e7d59 100644
--- a/cmd/eficonfig.c
+++ b/cmd/eficonfig.c
@@ -62,6 +62,7 @@ struct eficonfig_filepath_info {
 struct eficonfig_boot_option {
 	struct eficonfig_select_file_info file_info;
 	struct eficonfig_select_file_info initrd_info;
+	struct eficonfig_select_file_info fdt_info;
 	unsigned int boot_index;
 	u16 *description;
 	u16 *optional_data;
@@ -1308,6 +1309,10 @@ static efi_status_t eficonfig_show_boot_option(struct eficonfig_boot_option *bo,
 	if (ret != EFI_SUCCESS)
 		goto out;
 
+	ret = prepare_file_selection_entry(efi_menu, "Fdt File: ", &bo->fdt_info);
+	if (ret != EFI_SUCCESS)
+		goto out;
+
 	ret = create_boot_option_entry(efi_menu, "Optional Data: ", bo->optional_data,
 				       eficonfig_boot_add_optional_data, bo);
 	if (ret != EFI_SUCCESS)
@@ -1388,27 +1393,44 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
 	efi_status_t ret;
 	char *tmp = NULL, *p;
 	struct efi_load_option lo = {0};
-	efi_uintn_t final_dp_size;
+	efi_uintn_t dp_size;
 	struct efi_device_path *dp = NULL;
 	efi_uintn_t size = load_option_size;
-	struct efi_device_path *final_dp = NULL;
 	struct efi_device_path *device_dp = NULL;
 	struct efi_device_path *initrd_dp = NULL;
+	struct efi_device_path *fdt_dp = NULL;
 	struct efi_device_path *initrd_device_dp = NULL;
+	struct efi_device_path *fdt_device_dp = NULL;
 
-	const struct efi_initrd_dp id_dp = {
+	const struct efi_initrd_dp initrd_prefix = {
 		.vendor = {
 			{
 			DEVICE_PATH_TYPE_MEDIA_DEVICE,
 			DEVICE_PATH_SUB_TYPE_VENDOR_PATH,
-			sizeof(id_dp.vendor),
+			sizeof(initrd_prefix.vendor),
 			},
 			EFI_INITRD_MEDIA_GUID,
 		},
 		.end = {
 			DEVICE_PATH_TYPE_END,
 			DEVICE_PATH_SUB_TYPE_END,
-			sizeof(id_dp.end),
+			sizeof(initrd_prefix.end),
+		}
+	};
+
+	const struct efi_initrd_dp fdt_prefix = {
+		.vendor = {
+			{
+			DEVICE_PATH_TYPE_MEDIA_DEVICE,
+			DEVICE_PATH_SUB_TYPE_VENDOR_PATH,
+			sizeof(fdt_prefix.vendor),
+			},
+			EFI_FDT_GUID,
+		},
+		.end = {
+			DEVICE_PATH_TYPE_END,
+			DEVICE_PATH_SUB_TYPE_END,
+			sizeof(initrd_prefix.end),
 		}
 	};
 
@@ -1424,6 +1446,12 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
 		goto out;
 	}
 
+	bo->fdt_info.current_path = calloc(1, EFICONFIG_FILE_PATH_BUF_SIZE);
+	if (!bo->fdt_info.current_path) {
+		ret =  EFI_OUT_OF_RESOURCES;
+		goto out;
+	}
+
 	bo->description = calloc(1, EFICONFIG_DESCRIPTION_MAX * sizeof(u16));
 	if (!bo->description) {
 		ret =  EFI_OUT_OF_RESOURCES;
@@ -1456,13 +1484,20 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
 		if (lo.file_path)
 			fill_file_info(lo.file_path, &bo->file_info, device_dp);
 
-		/* Initrd file path(optional) is placed at second instance. */
+		/* Initrd file path (optional) is placed at second instance. */
 		initrd_dp = efi_dp_from_lo(&lo, &efi_lf2_initrd_guid);
 		if (initrd_dp) {
 			fill_file_info(initrd_dp, &bo->initrd_info, initrd_device_dp);
 			efi_free_pool(initrd_dp);
 		}
 
+		/* Fdt file path (optional) is placed as third instance. */
+		fdt_dp = efi_dp_from_lo(&lo, &efi_guid_fdt);
+		if (fdt_dp) {
+			fill_file_info(fdt_dp, &bo->fdt_info, fdt_device_dp);
+			efi_free_pool(fdt_dp);
+		}
+
 		if (size > 0)
 			memcpy(bo->optional_data, lo.optional_data, size);
 	}
@@ -1484,26 +1519,31 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
 			ret = EFI_OUT_OF_RESOURCES;
 			goto out;
 		}
-		initrd_dp = efi_dp_concat((const struct efi_device_path *)&id_dp,
+		initrd_dp = efi_dp_concat((const struct efi_device_path *)&initrd_prefix,
 					  dp, 0);
 		efi_free_pool(dp);
 	}
 
+	if (bo->fdt_info.dp_volume) {
+		dp = eficonfig_create_device_path(bo->fdt_info.dp_volume,
+						  bo->fdt_info.current_path);
+		if (!dp) {
+			ret = EFI_OUT_OF_RESOURCES;
+			goto out;
+		}
+		fdt_dp = efi_dp_concat((const struct efi_device_path *)&fdt_prefix,
+				       dp, 0);
+		efi_free_pool(dp);
+	}
+
 	dp = eficonfig_create_device_path(bo->file_info.dp_volume, bo->file_info.current_path);
 	if (!dp) {
 		ret = EFI_OUT_OF_RESOURCES;
 		goto out;
 	}
-	final_dp_size = efi_dp_size(dp) + sizeof(END);
-	if (initrd_dp) {
-		final_dp = efi_dp_concat(dp, initrd_dp, 1);
-		final_dp_size += efi_dp_size(initrd_dp) + sizeof(END);
-	} else {
-		final_dp = efi_dp_dup(dp);
-	}
-	efi_free_pool(dp);
 
-	if (!final_dp)
+	ret = efi_load_option_dp_join(&dp, &dp_size, initrd_dp, fdt_dp);
+	if (ret != EFI_SUCCESS)
 		goto out;
 
 	if (utf16_utf8_strlen(bo->optional_data)) {
@@ -1515,17 +1555,20 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
 		utf16_utf8_strncpy(&p, bo->optional_data, u16_strlen(bo->optional_data));
 	}
 
-	ret = eficonfig_set_boot_option(varname, final_dp, final_dp_size, bo->description, tmp);
+	ret = eficonfig_set_boot_option(varname, dp, dp_size, bo->description, tmp);
 out:
 	free(tmp);
 	free(bo->optional_data);
 	free(bo->description);
 	free(bo->file_info.current_path);
 	free(bo->initrd_info.current_path);
+	free(bo->fdt_info.current_path);
 	efi_free_pool(device_dp);
 	efi_free_pool(initrd_device_dp);
 	efi_free_pool(initrd_dp);
-	efi_free_pool(final_dp);
+	efi_free_pool(fdt_device_dp);
+	efi_free_pool(fdt_dp);
+	efi_free_pool(dp);
 
 	return ret;
 }
diff --git a/include/efi_loader.h b/include/efi_loader.h
index ddf2e41a95c..1236eecff0f 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -1185,4 +1185,18 @@ efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int
  */
 void efi_add_known_memory(void);
 
+/**
+ * efi_load_option_dp_join() - join device-paths for load option
+ *
+ * @dp:		in: binary device-path, out: joined device-path
+ * @dp_size:	size of joined device-path
+ * @initrd_dp:	initrd device-path or NULL
+ * @fdt_dp:	device-tree device-path or NULL
+ * Return:	status_code
+ */
+efi_status_t efi_load_option_dp_join(struct efi_device_path **dp,
+				     size_t *dp_size,
+				     struct efi_device_path *initrd_dp,
+				     struct efi_device_path *fdt_dp);
+
 #endif /* _EFI_LOADER_H */
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index 73d0279e843..348612c3dad 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -99,6 +99,50 @@ err:
 	return NULL;
 }
 
+/**
+ * efi_load_option_dp_join() - join device-paths for load option
+ *
+ * @dp:		in: binary device-path, out: joined device-path
+ * @dp_size:	size of joined device-path
+ * @initrd_dp:	initrd device-path or NULL
+ * @fdt_dp:	device-tree device-path or NULL
+ * Return:	status_code
+ */
+efi_status_t efi_load_option_dp_join(struct efi_device_path **dp,
+				     size_t *dp_size,
+				     struct efi_device_path *initrd_dp,
+				     struct efi_device_path *fdt_dp)
+{
+	if (!dp)
+		return EFI_INVALID_PARAMETER;
+
+	*dp_size = efi_dp_size(*dp);
+
+	if (initrd_dp) {
+		struct efi_device_path *tmp_dp = *dp;
+
+		*dp = efi_dp_concat(tmp_dp, initrd_dp, *dp_size);
+		efi_free_pool(tmp_dp);
+		if (!*dp)
+			return EFI_OUT_OF_RESOURCES;
+		*dp_size += efi_dp_size(initrd_dp) + sizeof(END);
+	}
+
+	if (fdt_dp) {
+		struct efi_device_path *tmp_dp = *dp;
+
+		*dp = efi_dp_concat(tmp_dp, fdt_dp, *dp_size);
+		efi_free_pool(tmp_dp);
+		if (!dp)
+			return EFI_OUT_OF_RESOURCES;
+		*dp_size += efi_dp_size(fdt_dp) + sizeof(END);
+	}
+
+	*dp_size += sizeof(END);
+
+	return EFI_SUCCESS;
+}
+
 const struct guid_to_hash_map {
 	efi_guid_t guid;
 	const char algo[32];
-- 
2.43.0

