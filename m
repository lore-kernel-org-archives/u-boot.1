Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7510EC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:14:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D34388667;
	Fri, 26 Apr 2024 16:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hfaEOeZd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F94D8860F; Fri, 26 Apr 2024 16:13:55 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C089885C1
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E9A163FE60
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 14:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714140831;
 bh=aSURsQK7vhNefALFMTx/kvOabbE3mUsH8XfwRCIhoY4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=hfaEOeZdKrwuuD3DvFuLPsyXzqjojZvPxWXoSw3Xrc3NEqKgM9EqjYSA8P+JuOduN
 jzjrFe+bv8TXeGcE0Wy/cwCr61GeM3DBctoRRYymDMFdd1DKeeIOhHTSRvtbgPVIVC
 0INER+INLp7GFqQ8pPXwYhD19Ejdn1sb+dX28vDLi9u5IJ5XWbRAGdfoDcpkNTOTqk
 NZN65RMtWqF0JZZu2Q4iDunFajqozFk7+ecatl+ARxZWkNDGT9CID0nQJozPhKKGOC
 +v25h4z+IP7sH/MIYFTzpUx3dDeN5VJl2SmbebraQ+01dU8mFMYMYGJbWUCQz3gmxW
 yfi2Yy1kMebjA==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-34b08e09bc4so1132480f8f.1
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 07:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714140830; x=1714745630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aSURsQK7vhNefALFMTx/kvOabbE3mUsH8XfwRCIhoY4=;
 b=vAIv20uxic3SNMqxaEZDFzzX7LFrrCASwnOhP1jB6LwG1Ft8SMKGtVK49RAqj8szOM
 HRbGPCa8UEjtxy6WaEifzISpA1BoNZOdVM7SgBTv5JJFVBh8bJ6uOpbWGhh8TV1hDHSQ
 owQ5sVctoBoU7+XqqyTCBX+Gp7vm22lbGIqtaYnTGtdLhACZuit0q110K0jQgM83x/ZU
 uhk33rxiOlJmBsUglWx3nWl/aZuAxs+QxsXCMcWUF32fA/XZek/Zp5YFwOnvQaLdu2g9
 ni1V3LKv2C1b6k8cZLX5fz5+FIMLQfs4XK1tMHkHIyY+Ue5fxPlJg2OLj8TdkSs0XHp7
 7YRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn+04i44BWtZHLJWA8XvGGyTqWrbiuAbcbbOwmBcL+i5dUWOl38rjNtSOxbcTNvCU/IYynWvZ8YlQdx4b84MJsTHP/gg==
X-Gm-Message-State: AOJu0YzyEwLQTVAI6mx+caRFWQl0ibqj9puQ5scQOiRVGScxlysLtC18
 DMrrtqXRSER5X6ys3s2Ihh/W67wB8jsI1mDvVRhkVcgBl8keLJlcQejp6cHSZS5/GESNbXrgvBk
 TdW1b/pF/Sqkl5ORsiaZkOxP1F4DTxLYmnUcOLw4+CTgnqw8YJsNlO0CbLGEvisKpICM=
X-Received: by 2002:adf:f4c8:0:b0:349:ca9b:545a with SMTP id
 h8-20020adff4c8000000b00349ca9b545amr2362035wrp.29.1714140830411; 
 Fri, 26 Apr 2024 07:13:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEuOSE1SY1kO9Lf0DzPPiI5nLQVhS9o6Dscz7b90aK6edeQwK/gUE5fgNJdY+BdXKfDPdjDw==
X-Received: by 2002:adf:f4c8:0:b0:349:ca9b:545a with SMTP id
 h8-20020adff4c8000000b00349ca9b545amr2362014wrp.29.1714140830039; 
 Fri, 26 Apr 2024 07:13:50 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 s20-20020adfa294000000b003455e5d2569sm1460593wra.0.2024.04.26.07.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 07:13:49 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 04/14] cmd: eficonfig: add support for setting fdt
Date: Fri, 26 Apr 2024 16:13:11 +0200
Message-ID: <20240426141321.232236-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
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
 cmd/eficonfig.c | 68 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 5 deletions(-)

diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
index 1c57e66040b..d314051ee58 100644
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
@@ -1394,21 +1399,39 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
 	struct efi_device_path *final_dp = NULL;
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
 
@@ -1424,6 +1447,12 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
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
@@ -1456,13 +1485,20 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
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
@@ -1484,11 +1520,23 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
 			ret = EFI_OUT_OF_RESOURCES;
 			goto out;
 		}
-		initrd_dp = efi_dp_concat((const struct efi_device_path *)&id_dp,
+		initrd_dp = efi_dp_concat((const struct efi_device_path *)&initrd_prefix,
 					  dp);
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
+				       dp);
+		efi_free_pool(dp);
+	}
+
 	dp = eficonfig_create_device_path(bo->file_info.dp_volume, bo->file_info.current_path);
 	if (!dp) {
 		ret = EFI_OUT_OF_RESOURCES;
@@ -1505,6 +1553,13 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
 			goto out;
 		}
 	}
+	if (fdt_dp) {
+		final_dp = efi_dp_merge(final_dp, &final_dp_size, fdt_dp);
+		if (!final_dp) {
+			ret = EFI_OUT_OF_RESOURCES;
+			goto out;
+		}
+	}
 
 	if (utf16_utf8_strlen(bo->optional_data)) {
 		len = utf16_utf8_strlen(bo->optional_data) + 1;
@@ -1522,9 +1577,12 @@ out:
 	free(bo->description);
 	free(bo->file_info.current_path);
 	free(bo->initrd_info.current_path);
+	free(bo->fdt_info.current_path);
 	efi_free_pool(device_dp);
 	efi_free_pool(initrd_device_dp);
 	efi_free_pool(initrd_dp);
+	efi_free_pool(fdt_device_dp);
+	efi_free_pool(fdt_dp);
 	efi_free_pool(final_dp);
 
 	return ret;
-- 
2.43.0

