Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D51CC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:43:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D5F088518;
	Tue, 28 May 2024 16:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="IECBsEyU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEFA088544; Tue, 28 May 2024 16:43:22 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FB1B88511
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 32DA03FE69
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 14:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1716907391;
 bh=DK/9LxDeIDuS4ru83BjcxMmuU7IUkU0CGJmVl8peNak=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=IECBsEyU0YmdzQpWA6D74sGZrlHgVtzSHVt19fTInzKpjTWjKPxle4vlBLSF5kRSo
 /CC4fR/gTTq5F+1fsDlqNqlh6JHJGShOgmCiVgKAwEQASRxeAmVWnQnOx0JrRWhF+O
 od6vjxIkt868W0daQ+Qpo2dYAvKrLlLnmuaRwLvMTZGjm28lgFXVQk5JP2S5kAGzjT
 IcRG8wBAZt/zkWwsL4MWlAKqzCfbZiq31WskpbFwAhySdZGYXGfvo2l245YcQlNjFS
 s/t8++z4S6n6PJJ3Q/F0xGK3Vgbh5HX5ATWvyBgMgCQlk1fe42lyjrli782WFuGNm+
 3LK6jnADTA+iw==
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-579fd68b42aso139381a12.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716907385; x=1717512185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DK/9LxDeIDuS4ru83BjcxMmuU7IUkU0CGJmVl8peNak=;
 b=ZzVv36FO9WHNvt8Dum9dOkoxUSZyqDp7c/FXgQ7q8odqlW2p7S0DXLoCLVIDDgaYO6
 3C8PIAyyEhhetBxWDOjOlT3o8Z3tQRWStvXYujzdTmpaAEWvBwyjxAO6ZLvHandhi6o3
 E8CprONZz675xA7bzNQn/tNH4muQBIp7lAKgKjlm7fPk4IwA5w5lOQrgednqyDOkICag
 OCvf+98+qtq/VXC/VfSfFETJCYAi+C2rT6dtvxRaDxHDQ0jqJKoxwXwmyl3Se3DHMIQn
 4sCKlkwhiLUyT+MlAPhQuUWVSoHRuTTwD2wUZ1rdshFBs+0sbHRRYyRl2HaEXfglgOCI
 lAbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFZ3Dletm2Eg4E1kLf57yF/UDsgy+8bFOHTd3FQURyAgkNcx09iAYxEpQ/kJYgj35ecJBnOknNm0EUqf3YsaRfrQil2A==
X-Gm-Message-State: AOJu0YypviPPojADgdTl3uSy9FXiQb3p5Sro89wErvm4USDj6PSfM7SO
 smmXHTA3Cem/BjKyb7CqgzMQY+1mUflDgmrjyHDGdHke53+TGl0A1ixGW2wxhrWjwHFHUpe3II8
 FDMWxcoT9nLt5LR0crCHFTM2u2AnG8ddt5mNAJufzAhj4sqomtGWb2e3OU9BJTu93sbs=
X-Received: by 2002:a50:9b44:0:b0:572:9c4c:2503 with SMTP id
 4fb4d7f45d1cf-57851a4eb8cmr7646585a12.38.1716907385697; 
 Tue, 28 May 2024 07:43:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES9S/kMfoNCies7UtDwb96LoqI8tAURlUaHzxmwdVI8wVUn6blDXN9dvjEaAAWG5fZfldBKA==
X-Received: by 2002:a50:9b44:0:b0:572:9c4c:2503 with SMTP id
 4fb4d7f45d1cf-57851a4eb8cmr7646568a12.38.1716907385238; 
 Tue, 28 May 2024 07:43:05 -0700 (PDT)
Received: from workstation5.. ([2a00:20:d00b:f75d:fdbe:9c2a:66b:5f2b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578f47126f0sm4914986a12.91.2024.05.28.07.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:43:04 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/8] cmd: eficonfig: add support for setting fdt
Date: Tue, 28 May 2024 16:42:46 +0200
Message-ID: <20240528144252.179247-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
References: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
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
---
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

