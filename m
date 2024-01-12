Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560C6C4707B
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 00:22:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6A9387969;
	Fri, 12 Jan 2024 01:21:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L+VgyGnm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32EE1878B1; Fri, 12 Jan 2024 01:21:43 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBA8587956
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 01:21:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3bbd1f9e0b8so4852674b6e.0
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 16:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705018897; x=1705623697; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vvsc+JgHfocrcstT4VTrcXZxfvOCdybE19o+51syb7g=;
 b=L+VgyGnmfXftJ1luXkg8io0QoGwwlioG+ut6PoMU6SOb9cMNlPrPdK+lcA3C2EXuzg
 gzM+rLR3e0YUSxhsAWdZQCjH9Csoda5QSBNl8Xe+VzRoUgbpsZ0IzL0HBuhoSliwFHo4
 gfXZolo8mL+1qeOMGa0Sg5kDpQXqDtViPwfJ6kYtd/JUnjevVVCXTcN752wAD91rIKC4
 BBVZdVdtkC+Jborb9QZiK8nn2x9VjuAzVlRdxl3AivrD0M3leH/RG2ITQl3G5G/wFyRH
 WH45oZvmbQZ+ZXPHYTtYi58zK87zjX19N7w9duBPpEr9YCeaYxKjdw+lvh06YcGeSARg
 9bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705018897; x=1705623697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vvsc+JgHfocrcstT4VTrcXZxfvOCdybE19o+51syb7g=;
 b=vXz1gWOzbXCmtarZcOnnf0EK6FN8gYUMz7xTbWgD033lF2sQI1jSTzn6Sl6yXgyQGO
 69YZjY3los0FsjlwuuZwXtkVoBVg8JDTmu/QFslDQcpMEVMIXiMwlkXQ3QyGxm7UOYKE
 +/9xbiZdqyU0I8dPFBOYWiEj43o3wF4BsZL7wilD2qo7kKwmnyKTqSbSw+pn3v5zJj/b
 eFqExdqJ+X/TJpSlGfjGE0W6Qgx4jAIpKBAAi7GW8N74/gEk+G317VwZZZkqIw76JDPB
 Flo1RiC1KwQpU+0rSLSiVsKWXgLfRKvQIq4asEtF3en4v/LG2cwhbQn9IQ/7FlmeJj4+
 2/ig==
X-Gm-Message-State: AOJu0Yyj3AJm2a2EgRkTwtcao7NjMVZbnkiZ5c6cIyxpezrt6D+UWJwH
 2FpqfOSrFa5/xjnCTjGH8M8bjddO3DIv0KAKSGsqhbKmpfA=
X-Google-Smtp-Source: AGHT+IFQ2rCUpKTPpqSt10PMccwJLvD12lfY/SgIfyCoheAVEDUhBMfXsmrXYZ7YanhT2sho8XGpFQ==
X-Received: by 2002:a05:6358:6117:b0:175:9261:c2e2 with SMTP id
 23-20020a056358611700b001759261c2e2mr692565rws.51.1705018897191; 
 Thu, 11 Jan 2024 16:21:37 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 sf15-20020a17090b51cf00b0028e023be116sm332993pjb.49.2024.01.11.16.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 16:21:36 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v3 3/3] efi_loader: auto-generate removable media boot option
 first
Date: Fri, 12 Jan 2024 09:19:23 +0900
Message-Id: <20240112001923.976414-4-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112001923.976414-1-masahisa.kojima@linaro.org>
References: <20240112001923.976414-1-masahisa.kojima@linaro.org>
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
 lib/efi_loader/efi_bootmgr.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index c2b8da89e6..9befe001e7 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -787,16 +787,19 @@ error:
  * efi_bootmgr_enumerate_boot_options() - enumerate the possible bootable media
  *
  * @opt:		pointer to the media boot option structure
+ * @index:		index of the opt array to store the boot option
  * @handles:		pointer to block device handles
  * @count:		On entry number of handles to block devices.
  *			On exit number of boot options.
+ * @removable:		flag to parse removable only
  * Return:		status code
  */
 static efi_status_t
 efi_bootmgr_enumerate_boot_options(struct eficonfig_media_boot_option *opt,
-				   efi_handle_t *handles, efi_uintn_t *count)
+				   efi_uintn_t index, efi_handle_t *handles,
+				   efi_uintn_t *count, bool removable)
 {
-	u32 i, num = 0;
+	u32 i, num = index;
 	struct efi_handler *handler;
 	efi_status_t ret = EFI_SUCCESS;
 
@@ -816,6 +819,9 @@ efi_bootmgr_enumerate_boot_options(struct eficonfig_media_boot_option *opt,
 		if (blkio->media->logical_partition)
 			continue;
 
+		if (removable != (blkio->media->removable_media != 0))
+			continue;
+
 		ret = efi_search_protocol(handles[i], &efi_guid_device_path, &handler);
 		if (ret != EFI_SUCCESS)
 			continue;
@@ -857,6 +863,9 @@ efi_bootmgr_enumerate_boot_options(struct eficonfig_media_boot_option *opt,
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
 
-	ret = efi_bootmgr_enumerate_boot_options(opt, handles, &count);
+	/* parse removable block io followed by fixed block io */
+	num = count;
+	ret = efi_bootmgr_enumerate_boot_options(opt, 0, handles, &num, true);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
+	total = num;
+	num = count;
+	ret = efi_bootmgr_enumerate_boot_options(opt, total, handles, &num, false);
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

