Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24459C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 06:30:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5CB687876;
	Tue, 26 Dec 2023 07:30:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="el4Bzf/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ECDB874CC; Tue, 26 Dec 2023 07:30:36 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1519887852
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 07:30:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3bbb9f39e30so84117b6e.3
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 22:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703572232; x=1704177032; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ZoGUBhmva+pKMScAdXfCrlEl8CcJBZ2lyTChBOAbeg=;
 b=el4Bzf/fp0eyzeksYekHnaSflPzgc9Bqdq4QHGeXOpZKYdLLPMBkQZUc6n9xj0VT45
 w4O0gRKhKJIIWy4T4+YjpD/jvtSv8nOb4EdzBKrrFDok3DeYvqOXJrdjy307stM9O4Sc
 OTKBf/e4+2TdEpigDxZPE60o9PT1er+8i2zDtxJG1eCg/9b2xjAyWJjb5aBr94CfqGaR
 jscVA9hKrgeGqW2IBqexD3hoLhIHPNOqjtD5ZVz2R14lvYxMwXzze9dS1QS7tqJfbzzt
 AeTV1sE5rwXgMUVzMejP+OSVWQmvQEFoTERJ9UZBAJNP+jZNPrI7xdhdYvht17rQSH5B
 M6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703572232; x=1704177032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ZoGUBhmva+pKMScAdXfCrlEl8CcJBZ2lyTChBOAbeg=;
 b=IeOHi7xzmt4lZK93t/oTBDGHKFHnQU1/TzbTycc+MeDsgiW+ui/p9mtumc3f1jiDox
 sMPpyOrsuiukZwGcxlrFHPC3m3sup/c6c8Ir4xMl7CrDaCDtzRYAmlFB+7Dhj60tQXi8
 mDhWXA7ZsVbj+9bgupktLN/fadwdJZzpU4nhhjewMdg4EC8uvZ1DNej/IVqakUaMn/8D
 GSRwoEBF3aAZZ+XjfqClcKwulT0tZ9F31MTKlz3jYLvG0Vz/J3tMA1sVZcP5cszdVcaQ
 ROf+pMhYl22ZnZYScDeY2zqjE+CutKr9NxmMj/+w5yYHA0w6AxaRZlmu221W1PKOwfL2
 ztig==
X-Gm-Message-State: AOJu0YwunAldAmCW2Rm9l6Zej56u5agg97vr8DThUbsp2GrzIZpkaORc
 2A0MX/LehxHCxGFu7HCAA6CNnEDyIbZonfPVw+QNoOs9y9c=
X-Google-Smtp-Source: AGHT+IFQc2neVy+5lmPLMUAT8a0N0hkC1jWkCU0NFT5xN93v5qjfCGwPVEpLVKNl1Eq+LreDV+gOqQ==
X-Received: by 2002:a05:6808:444a:b0:3bb:b9e6:a156 with SMTP id
 ep10-20020a056808444a00b003bbb9e6a156mr564298oib.6.1703572231840; 
 Mon, 25 Dec 2023 22:30:31 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 o6-20020a056a001b4600b006d98e42d5desm6636989pfv.193.2023.12.25.22.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 22:30:30 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v2 2/2] efi_loader: auto-generate removable media boot option
 first
Date: Tue, 26 Dec 2023 15:28:20 +0900
Message-Id: <20231226062820.722358-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231226062820.722358-1-masahisa.kojima@linaro.org>
References: <20231226062820.722358-1-masahisa.kojima@linaro.org>
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

This commit auto-generates the boot option for removable
block io devices followed by fixed block io devices.
This is what EDK II reference implementation does.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 lib/efi_loader/efi_bootmgr.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 747f75ee82..a146428a65 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -584,7 +584,6 @@ static efi_status_t try_load_from_media(struct efi_device_path *file_path,
 	efi_status_t ret = EFI_SUCCESS;
 	struct efi_device_path *rem, *dp = NULL;
 	struct efi_device_path *final_dp = file_path;
-
 	h = efi_dp_find_obj(file_path, &efi_block_io_guid, &rem);
 	if (h) {
 		if (rem->type == DEVICE_PATH_TYPE_END) {
@@ -788,15 +787,19 @@ error:
  * efi_bootmgr_enumerate_boot_option() - enumerate the possible bootable media
  *
  * @opt:		pointer to the media boot option structure
+ * @index:		index of the opt array to store the boot option
  * @handles:		pointer to the efi handles
  * @count:		number of efi handle
+ * @removable:		flag to parse removable only
  * Return:		status code
  */
 static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boot_option *opt,
+						      efi_uintn_t index,
 						      efi_handle_t *handles,
-						      efi_uintn_t *count)
+						      efi_uintn_t *count,
+						      bool removable)
 {
-	u32 i, num = 0;
+	u32 i, num = index;
 	struct efi_handler *handler;
 	efi_status_t ret = EFI_SUCCESS;
 
@@ -816,6 +819,9 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
 		if (blkio->media->logical_partition)
 			continue;
 
+		if (removable != (blkio->media->removable_media != 0))
+			continue;
+
 		ret = efi_search_protocol(handles[i], &efi_guid_device_path, &handler);
 		if (ret != EFI_SUCCESS)
 			continue;
@@ -857,6 +863,9 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
 		optional_data = (char *)opt[num].lo + (opt[num].size - u16_strsize(u"1234567"));
 		memcpy(optional_data, &efi_guid_bootmenu_auto_generated, sizeof(efi_guid_t));
 		num++;
+
+		if (num >= *count)
+			break;
 	}
 
 out:
@@ -1105,7 +1114,7 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
 {
 	u32 i;
 	efi_status_t ret;
-	efi_uintn_t count;
+	efi_uintn_t count, num, total;
 	efi_handle_t *handles = NULL;
 	struct eficonfig_media_boot_option *opt = NULL;
 
@@ -1122,22 +1131,32 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
 		goto out;
 	}
 
-	ret = efi_bootmgr_enumerate_boot_option(opt, handles, &count);
+	/* parse removable block io followed by fixed block io */
+	num = count;
+	ret = efi_bootmgr_enumerate_boot_option(opt, 0, handles, &num, true);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
+	total = num;
+	num = count;
+	ret = efi_bootmgr_enumerate_boot_option(opt, total, handles, &num, false);
+	if (ret != EFI_SUCCESS)
+		goto out;
+
+	total = num;
+
 	/*
 	 * System hardware configuration may vary depending on the user setup.
 	 * The boot option is automatically added by the bootmenu.
 	 * If the device is not attached to the system, the boot option needs
 	 * to be deleted.
 	 */
-	ret = efi_bootmgr_delete_invalid_boot_option(opt, count);
+	ret = efi_bootmgr_delete_invalid_boot_option(opt, total);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
 	/* add non-existent boot option */
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < total; i++) {
 		u32 boot_index;
 		u16 var_name[9];
 
@@ -1166,7 +1185,7 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
 
 out:
 	if (opt) {
-		for (i = 0; i < count; i++)
+		for (i = 0; i < total; i++)
 			free(opt[i].lo);
 	}
 	free(opt);
-- 
2.34.1

