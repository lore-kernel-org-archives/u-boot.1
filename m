Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9536CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 23:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 027A286C3E;
	Mon, 16 Oct 2023 01:53:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Mekc6FVE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D203868AE; Mon, 16 Oct 2023 01:51:16 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BB4886B71
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 01:50:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c9daca2b85so28349915ad.1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 16:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697413839; x=1698018639; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=94LsV6NL1ZNFhkqVQDSTT44O3isY0X8vZDJ6qg+lBCo=;
 b=Mekc6FVEgSX7y49Kylw8NyCvS5GAO2wtXKjEYtXUuLdYSgU0dAUf4s1Qn+m43bNEk+
 l4l63NKJMff9PEyYqP5D3ErYTXeM+hBIXdZLQhWOMM+DZWStMB3203LvKGQnQriRP67b
 aE6VpzyxkEB7yo37tNYEUASmjTb54PeC/J78WmwD8QqcmnA4fm2MROHS9w74iXwe9dnN
 rw6TIrNRZ3qM4gWY5gYeAVP6cJOcTwfZiRwTNReWm1qmspU+htYSe9jttflGJK4ZBOOY
 kfGwE/6AGKQMV6tR+4XDhpBjpG72klPCmJM9KDgbzxKQQ7ZkOt7ag2O614+PH+fWKu2y
 bkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697413839; x=1698018639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=94LsV6NL1ZNFhkqVQDSTT44O3isY0X8vZDJ6qg+lBCo=;
 b=FEt4IOiqqyUSJxGmVBURHgKbeIX/0GcH/Cka3VGJVhpF3eRTCeRa+Z1ypZioKqQFq3
 dgMksNoKtgmgh4APfyVI79UbNba0NxjylNDCVi8vhyGjUFGgEA2uuemdB2lpjRfIg5m/
 JMTYolaY+WBbNyZZEZN9R5ZhI3VXuCXj+QgbWg5/TyTuXuq3bhYpV/a0RJSAcoEyu4/o
 2wS7rWXqb/uGUzVXII9fv0emFvNWdPhjsGo8cnA9AfYAi/O6gPS3WU1Y9pksvk5ZpV+A
 mj3TXDStSjuiehwCatSwWJF9Zgce9plabAp9VFwCveCmPWDahLe/ULHmiM+zAnMBkWJy
 ElJw==
X-Gm-Message-State: AOJu0Yw+UgESqSDTV6OQzoZOzERZdY/g3abAeiK0yJ73iRu9OSWSv1z1
 n0wQbJBnGbfJB8Cob00AH4HODEqv1sDnrmkD3RQ=
X-Google-Smtp-Source: AGHT+IHk+AlyKkHhNCymwqwYRBGU+L9G8m4TdWhinzrNhYmYbaiRNkH+qPmirnnXjnpDBURWRhWjCQ==
X-Received: by 2002:a17:902:fac7:b0:1c9:dece:4c4c with SMTP id
 ld7-20020a170902fac700b001c9dece4c4cmr7899388plb.15.1697413839397; 
 Sun, 15 Oct 2023 16:50:39 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 f9-20020a170902ce8900b001c75a07f62esm7219635plg.34.2023.10.15.16.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 16:50:38 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v6 4/9] efi_loader: create default file boot option
Date: Mon, 16 Oct 2023 08:49:02 +0900
Message-Id: <20231015234907.2362717-5-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231015234907.2362717-1-masahisa.kojima@linaro.org>
References: <20231015234907.2362717-1-masahisa.kojima@linaro.org>
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

Current efibootmgr automatically creates the
boot options of all disks and partitions installing
EFI_SIMPLE_FILE_SYSTEM_PROTOCOL.
Some of the automatically created boot options are
useless if the disk and partition does not have
the default file(e.g. EFI/BOOT/BOOTAA64.EFI).

This commit only creates the boot option if the disk and
partition have the default file so that system can directly
boot from it.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 lib/efi_loader/efi_bootmgr.c | 53 +++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index a40762c74c..a197127cdd 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -355,20 +355,21 @@ error:
  */
 static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boot_option *opt,
 						      efi_handle_t *volume_handles,
-						      efi_status_t count)
+						      efi_uintn_t *count)
 {
-	u32 i;
+	u32 i, num = 0;
 	struct efi_handler *handler;
 	efi_status_t ret = EFI_SUCCESS;
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < *count; i++) {
 		u16 *p;
 		u16 dev_name[BOOTMENU_DEVICE_NAME_MAX];
 		char *optional_data;
 		struct efi_load_option lo;
 		char buf[BOOTMENU_DEVICE_NAME_MAX];
-		struct efi_device_path *device_path;
+		struct efi_device_path *device_path, *full_path;
 		struct efi_device_path *short_dp;
+		efi_handle_t image_handle;
 
 		ret = efi_search_protocol(volume_handles[i], &efi_guid_device_path, &handler);
 		if (ret != EFI_SUCCESS)
@@ -378,17 +379,27 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
 		if (ret != EFI_SUCCESS)
 			continue;
 
+		/* check whether the partition or disk have the default file */
+		full_path = efi_dp_from_file(device_path,
+					     "/EFI/BOOT/" BOOTEFI_NAME);
+		ret = EFI_CALL(efi_load_image(true, efi_root, full_path, NULL,
+					      0, &image_handle));
+		if (ret != EFI_SUCCESS)
+			goto next;
+		ret = EFI_CALL(efi_unload_image(image_handle));
+		if (ret != EFI_SUCCESS)
+			goto next;
+
 		ret = efi_disk_get_device_name(volume_handles[i], buf, BOOTMENU_DEVICE_NAME_MAX);
 		if (ret != EFI_SUCCESS)
-			continue;
+			goto next;
 
 		p = dev_name;
 		utf8_utf16_strncpy(&p, buf, strlen(buf));
 
 		/* prefer to short form device path */
-		short_dp = efi_dp_shorten(device_path);
-		if (short_dp)
-			device_path = short_dp;
+		short_dp = efi_dp_shorten(full_path);
+		device_path = short_dp ? short_dp : full_path;
 
 		lo.label = dev_name;
 		lo.attributes = LOAD_OPTION_ACTIVE;
@@ -396,24 +407,29 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
 		lo.file_path_length = efi_dp_size(device_path) + sizeof(END);
 		/*
 		 * Set the dedicated guid to optional_data, it is used to identify
-		 * the boot option that automatically generated by the bootmenu.
+		 * the boot option that automatically generated by the efibootmgr.
 		 * efi_serialize_load_option() expects optional_data is null-terminated
 		 * utf8 string, so set the "1234567" string to allocate enough space
 		 * to store guid, instead of realloc the load_option.
 		 */
 		lo.optional_data = "1234567";
-		opt[i].size = efi_serialize_load_option(&lo, (u8 **)&opt[i].lo);
-		if (!opt[i].size) {
-			ret = EFI_OUT_OF_RESOURCES;
-			goto out;
+		opt[num].size = efi_serialize_load_option(&lo, (u8 **)&opt[num].lo);
+		if (!opt[num].size) {
+			efi_free_pool(full_path);
+			return EFI_OUT_OF_RESOURCES;
 		}
 		/* set the guid */
-		optional_data = (char *)opt[i].lo + (opt[i].size - u16_strsize(u"1234567"));
+		optional_data = (char *)opt[num].lo + (opt[num].size - u16_strsize(u"1234567"));
 		memcpy(optional_data, &efi_guid_bootmenu_auto_generated, sizeof(efi_guid_t));
+		num++;
+
+next:
+		efi_free_pool(full_path);
 	}
 
-out:
-	return ret;
+	*count = num;
+
+	return EFI_SUCCESS;
 }
 
 /**
@@ -642,7 +658,7 @@ efi_status_t efi_bootmgr_delete_boot_option(u16 boot_index)
  * efi_bootmgr_update_media_device_boot_option() - generate the media device boot option
  *
  * This function enumerates all devices supporting EFI_SIMPLE_FILE_SYSTEM_PROTOCOL
- * and generate the bootmenu entries.
+ * and create the boot option with default file if the file exists.
  * This function also provide the BOOT#### variable maintenance for
  * the media device entries.
  * - Automatically create the BOOT#### variable for the newly detected device,
@@ -674,8 +690,7 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
 		goto out;
 	}
 
-	/* enumerate all devices supporting EFI_SIMPLE_FILE_SYSTEM_PROTOCOL */
-	ret = efi_bootmgr_enumerate_boot_option(opt, volume_handles, count);
+	ret = efi_bootmgr_enumerate_boot_option(opt, volume_handles, &count);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
-- 
2.34.1

