Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73451CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 04:27:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 554D186DE8;
	Mon, 16 Oct 2023 06:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O14pn0bH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 751BA8657B; Mon, 16 Oct 2023 06:25:21 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B36086958
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 06:24:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5a9bc2ec556so1628209a12.0
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 21:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697430273; x=1698035073; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iAmFUGgEnR04lMoIFR98JXoRfIMyvt0aJ08PywRnLXU=;
 b=O14pn0bH477aWMlLHky3UJt+GV/1oHWvIyXy3sVwwAVR0q3pQGZwkCkhy0Zj2Horen
 MX1N7nb9SKZqi4KfHtwrSpCdjErKp1i7IFAjvdNm4E/2uzwdM4zxqdi03hWGoYZzh65l
 Q+Rl7MTVpnaGtX0CYk63V3gIFnxDqADRcmFHlNLxd5HgY7vwI1sKlQeESqowvI+2biw0
 PL8gO+ehPhglgBs5BvVCRW1RJ11SNEoLkZi+ZFhqtN2sNJaK5EfcEwaDPnRts1ZFrYpI
 UVv63iXrA9wbGvlIiyPzx0gY2YXrcugPmPJXQz84VdcbFlF+YLZaHi76dwgVXsltChit
 Vq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697430273; x=1698035073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iAmFUGgEnR04lMoIFR98JXoRfIMyvt0aJ08PywRnLXU=;
 b=oLMjmos72wt1sHczVWdiOzmE+zgvotwR9Hegi7lMZwhZIxJlfbT2pr0EjdW8pZnc+d
 FNpFRHahCKcTnoOK3exBCm6wwNZ3vl1VNcWfWNa7SKNjqnV7LovYVp3cM2eRvphxOOON
 CPFVj4EFYGIdoq5DaRp1YiDDKigytOBrSwbiYCqY+HNbzTGagEBLDE/pPRBGrDWvRykK
 +IhnKvqH1zA5+fNLYSY35ris1aAtqInut27Hentf8v3PPoVTsKH84V659dywijzNEvfC
 cpE26+BOwBL4F/BX4rkjefQlxIZuZ474dRlxFi0TwZ5jczXgIP1yGBasUCAN+Qj3gNup
 /gCg==
X-Gm-Message-State: AOJu0YzTEXrurNan8qWvtQL8J+IE1S0rdHGo0ppYNY4jolZPx07pk1ib
 o4g6ejLjRt+etwLoP66GmjCcoX1IlqidQNUCqQo=
X-Google-Smtp-Source: AGHT+IGnohaLXhJj5YXYpE0kIwJ2U3OlOM+/QYKBAPxJksyObg9Q7OL79FzfPRRWgUitk5aGubq6CQ==
X-Received: by 2002:a05:6a20:7485:b0:161:536d:a13b with SMTP id
 p5-20020a056a20748500b00161536da13bmr32847899pzd.18.1697430273118; 
 Sun, 15 Oct 2023 21:24:33 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ee8600b001c6187f2875sm7459722pld.225.2023.10.15.21.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 21:24:32 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [RESEND PATCH v6 4/9] efi_loader: create default file boot option
Date: Mon, 16 Oct 2023 13:23:03 +0900
Message-Id: <20231016042309.2386387-5-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016042309.2386387-1-masahisa.kojima@linaro.org>
References: <20231016042309.2386387-1-masahisa.kojima@linaro.org>
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
 lib/efi_loader/efi_bootmgr.c | 86 ++++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 23 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index a40762c74c..c8cf1c5506 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -355,40 +355,70 @@ error:
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
+		struct efi_device_path *device_path, *full_path, *dp, *fp;
 		struct efi_device_path *short_dp;
+		struct efi_file_handle *root, *f;
+		struct efi_simple_file_system_protocol *file_system;
+		u16 *default_file_path = NULL;
 
-		ret = efi_search_protocol(volume_handles[i], &efi_guid_device_path, &handler);
+		ret = efi_search_protocol(volume_handles[i],
+					  &efi_guid_device_path, &handler);
 		if (ret != EFI_SUCCESS)
 			continue;
-		ret = efi_protocol_open(handler, (void **)&device_path,
-					efi_root, NULL, EFI_OPEN_PROTOCOL_GET_PROTOCOL);
+
+		device_path = handler->protocol_interface;
+		full_path = efi_dp_from_file(device_path,
+					     "/EFI/BOOT/" BOOTEFI_NAME);
+
+		/* check whether the partition or disk have the default file */
+		ret = efi_dp_split_file_path(full_path, &dp, &fp);
+		if (ret != EFI_SUCCESS || !fp)
+			goto next_entry;
+
+		default_file_path = efi_dp_str(fp);
+		if (!default_file_path)
+			goto next_entry;
+
+		ret = efi_search_protocol(volume_handles[i],
+					  &efi_simple_file_system_protocol_guid,
+					  &handler);
 		if (ret != EFI_SUCCESS)
-			continue;
+			goto next_entry;
+
+		file_system = handler->protocol_interface;
+		ret = EFI_CALL(file_system->open_volume(file_system, &root));
+		if (ret != EFI_SUCCESS)
+			goto next_entry;
+
+		ret = EFI_CALL(root->open(root, &f, default_file_path,
+					  EFI_FILE_MODE_READ, 0));
+		if (ret != EFI_SUCCESS)
+			goto next_entry;
+
+		EFI_CALL(f->close(f));
 
 		ret = efi_disk_get_device_name(volume_handles[i], buf, BOOTMENU_DEVICE_NAME_MAX);
 		if (ret != EFI_SUCCESS)
-			continue;
+			goto next_entry;
 
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
@@ -396,24 +426,35 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
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
+			efi_free_pool(dp);
+			efi_free_pool(fp);
+			efi_free_pool(default_file_path);
+			return EFI_OUT_OF_RESOURCES;
 		}
 		/* set the guid */
-		optional_data = (char *)opt[i].lo + (opt[i].size - u16_strsize(u"1234567"));
+		optional_data = (char *)opt[num].lo + (opt[num].size - u16_strsize(u"1234567"));
 		memcpy(optional_data, &efi_guid_bootmenu_auto_generated, sizeof(efi_guid_t));
+		num++;
+
+next_entry:
+		efi_free_pool(full_path);
+		efi_free_pool(dp);
+		efi_free_pool(fp);
+		efi_free_pool(default_file_path);
 	}
 
-out:
-	return ret;
+	*count = num;
+
+	return EFI_SUCCESS;
 }
 
 /**
@@ -642,7 +683,7 @@ efi_status_t efi_bootmgr_delete_boot_option(u16 boot_index)
  * efi_bootmgr_update_media_device_boot_option() - generate the media device boot option
  *
  * This function enumerates all devices supporting EFI_SIMPLE_FILE_SYSTEM_PROTOCOL
- * and generate the bootmenu entries.
+ * and create the boot option with default file if the file exists.
  * This function also provide the BOOT#### variable maintenance for
  * the media device entries.
  * - Automatically create the BOOT#### variable for the newly detected device,
@@ -674,8 +715,7 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
 		goto out;
 	}
 
-	/* enumerate all devices supporting EFI_SIMPLE_FILE_SYSTEM_PROTOCOL */
-	ret = efi_bootmgr_enumerate_boot_option(opt, volume_handles, count);
+	ret = efi_bootmgr_enumerate_boot_option(opt, volume_handles, &count);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
-- 
2.34.1

