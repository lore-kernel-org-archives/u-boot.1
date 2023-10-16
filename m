Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7C7CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 06:47:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 224178477A;
	Mon, 16 Oct 2023 08:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UNla7tw0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF86286DB3; Mon, 16 Oct 2023 08:47:10 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7B5386D2D
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 08:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c5c91bec75so26083685ad.3
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 23:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697438811; x=1698043611; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iAmFUGgEnR04lMoIFR98JXoRfIMyvt0aJ08PywRnLXU=;
 b=UNla7tw0hZ9ESUAJmU4pProgivs4StZ5YAmWTT8guiKWSld1Fcb17ofpZ4nQMr5UPY
 dljy95GdUcCpK9K8uubH3zGvDkTdzZsa9804hbb22sPmzhUI3V6FT4vH2CablNAfrH3O
 KaFUe6fYTAJCViUXg5BnHKSVb07HkzvU32g5NH58KNB3d4OV4WiW7dOofuNOWiUOR4Wo
 lnTDuzm/+689lIdQRHQ5N5bpnTK8cEUcaLPYAbe2m/QocCSftSATE9SiyydU5s/BPhOX
 nPH7Z6pJNHDUBOtY2MtMw+90xaPzwH6EcRypB/wWmscgMMTJW0X9Qfe5rrtfMzETbowo
 /7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697438811; x=1698043611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iAmFUGgEnR04lMoIFR98JXoRfIMyvt0aJ08PywRnLXU=;
 b=DwmgkDp4jI/VTRxwhjp0I6xWjTFCpkRRx1qikMnN3h/KrsEdg1XRF0Va4Tog9oUo0V
 gbMuBYAMz4i04wdjSky/c6bqwGiVz21dr+q6swZteD5Kkhe+2F0TlFI8u4tD1fQ2FRHs
 DQrg+U58l/Uf+5pXobvbHyUGFdF4+I8DaPJPNFeHe8+z2cHhT2TPlDCvH1kn//suTKFh
 IumVJ6n3WV6FWzF5peP/JMpqHU40c0CyPi4oRsclt4cRml1LHRAt1O1zi0pKdcGt+5lj
 w8WeRWSsDF7Zn5DL3rXflUfLlLMFa+S5VY/jjmZx9Gkru7qOIhaQf8zEtMeh4S+Dakc4
 BW8g==
X-Gm-Message-State: AOJu0YweLYhwQrPJlJk2ukmMPldQr5heYzgvGnlv05xD1ykIhhpDqyz2
 bKBqy680XgvGFFYDz9QUxOtdxIpfywBs5/rGZoU=
X-Google-Smtp-Source: AGHT+IFswMpXdlGO63ADfXHzwuq0ksnHJyYmN+1EW1b3R4TZNBdBKHT9DsLAizDrvL/qx9OksLaidw==
X-Received: by 2002:a17:902:b48b:b0:1c4:4462:f1bd with SMTP id
 y11-20020a170902b48b00b001c44462f1bdmr24988052plr.35.1697438810714; 
 Sun, 15 Oct 2023 23:46:50 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 b2-20020a170902650200b001b898595be7sm7904538plk.291.2023.10.15.23.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:46:50 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v7 4/9] efi_loader: create default file boot option
Date: Mon, 16 Oct 2023 15:45:21 +0900
Message-Id: <20231016064526.2410856-5-masahisa.kojima@linaro.org>
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

