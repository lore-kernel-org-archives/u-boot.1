Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EECE7D0D2
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 07:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E459D86AD8;
	Fri, 22 Sep 2023 09:12:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TQHD7E55";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64D5A86290; Fri, 22 Sep 2023 09:12:38 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26D1586ABC
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 09:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-565334377d0so1382229a12.2
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 00:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695366754; x=1695971554; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ag4HbjQShb+hlyKp86pMPzIu0x8BUceT+MpXVkEcvXk=;
 b=TQHD7E559xT7EjLXHnCH4YFHMhO5rj32wa6niR9B55k3c15DPfX98QJoH396tlmL+o
 +BfC3Pcjat+wW1K5Cw2RR2m9tX8Scmc5HUxxv2EpJRxAAUqUZ6JGjG7JNJbxtDvqqKDj
 xz1XdUjdhudOhL9uAQPELSRhL3l35TogLI3EW/hzDESoxfpBLIOd4auQuATLwEGjXh6t
 bwQ3ffvLp3aTCvl7Lu+HbqU3psatN5y9U3cLDNz0Ra6iBHwXNItyVRA2JbJB+hA6w2zW
 QofMSYXp+01TZtQhtJZtcWTLcZOuX7LIxHkMpTZST38ZGtIzLbm9v450m6wrc4uoZ+Ss
 ow9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695366754; x=1695971554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ag4HbjQShb+hlyKp86pMPzIu0x8BUceT+MpXVkEcvXk=;
 b=N4mf27a/XBHOW5NhRsgw9C35yPfI6AsgscCdR7j9S7WtjNKO0VFRlt/baDF0B8wfRR
 S/3BdYfNna9sJFC4a32Nh3DgaKhJhT9JtrHhTt2DEA9VKYZ6oVTJkU9gha7+P5vC9Kgx
 541pJHA5UFqb90GcIZLNbcUKH1Tne13HvFI2wzEKDkDyzgH/pH1BPtP9hwX2SxxBKCPT
 u5db0IX1YbE9/wewG2Gr1SrWLgDmSJySRB0PbM82HDmrqgeXr+MATP3bIdUuKLiQ9LcB
 l1shDrfZcXh+Zyvci2jTu3OWzgo3B803sgGZxGEPVcK06lqaiTKZZtkJQnKt4GdBWKH6
 9Obg==
X-Gm-Message-State: AOJu0Yzef/BrHXbAjhVdGmwPo1pbR67xgC/7TAbCBn6oYSscKzULg9P2
 Ru9QVDIJG9QbWWSagzz47iZrHwrTiHZVHbdEze4=
X-Google-Smtp-Source: AGHT+IFOzg40nXPUkmg0nth0q5K3dbY+oVJBlVd+JpmRCo6X6EhZKrE+ih60XdD5oYhbnGe84+aBHg==
X-Received: by 2002:a05:6a20:a126:b0:14d:f41c:435a with SMTP id
 q38-20020a056a20a12600b0014df41c435amr8447667pzk.39.1695366754323; 
 Fri, 22 Sep 2023 00:12:34 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 lj8-20020a17090b344800b0026b4decfe59sm2589015pjb.31.2023.09.22.00.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 00:12:33 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v4 8/8] efi_loader: create BlockIo device boot option
Date: Fri, 22 Sep 2023 16:11:19 +0900
Message-Id: <20230922071119.1439482-9-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922071119.1439482-1-masahisa.kojima@linaro.org>
References: <20230922071119.1439482-1-masahisa.kojima@linaro.org>
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

Current efibootmgr automatically creates the boot options
of all the disks and partitions installing
SIMPLE_FILE_SYSTEM_PROTOCOL. These boot options are created
to load and start the default file(e.g. EFI/BOOT/BOOTAA64.EFI).

Now efibootmgr can scan the BlockIo device and try to boot
with the default file on the fly, this commit creates the
boot options only for the BlockIo devices exluding the logical
partition.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 include/efi_loader.h             |  1 +
 lib/efi_loader/efi_bootmgr.c     | 47 +++++++++++++++++++++-----------
 lib/efi_loader/efi_device_path.c | 20 ++++++++++++++
 3 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index c4207edc91..cc292f0553 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -932,6 +932,7 @@ struct efi_device_path *efi_dp_from_lo(struct efi_load_option *lo,
 struct efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
 				      const struct efi_device_path *dp2);
 struct efi_device_path *search_gpt_dp_node(struct efi_device_path *device_path);
+struct efi_device_path *efi_search_file_path_dp_node(struct efi_device_path *device_path);
 efi_status_t efi_deserialize_load_option(struct efi_load_option *lo, u8 *data,
 					 efi_uintn_t *size);
 unsigned long efi_serialize_load_option(struct efi_load_option *lo, u8 **data);
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 4991056946..b55d651d1b 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -387,7 +387,6 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
 	}
 
 	if (lo.attributes & LOAD_OPTION_ACTIVE) {
-		struct efi_device_path *file_path;
 		u32 attributes;
 
 		log_debug("trying to load \"%ls\" from %pD\n", lo.label,
@@ -405,11 +404,14 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
 						lo.file_path,
 					lo.label, handle);
 			}
-		} else {
-			file_path = expand_media_path(lo.file_path);
-			ret = EFI_CALL(efi_load_image(true, efi_root, file_path,
+		} else if (efi_search_file_path_dp_node(lo.file_path)) {
+			ret = EFI_CALL(efi_load_image(true, efi_root, lo.file_path,
 						      NULL, 0, handle));
-			efi_free_pool(file_path);
+		} else {
+			efi_handle_t h;
+
+			h = efi_dp_find_obj(lo.file_path, &efi_block_io_guid, NULL);
+			ret = load_default_file_from_blk_dev(h->dev, handle);
 		}
 		if (ret != EFI_SUCCESS) {
 			log_warning("Loading %ls '%ls' failed\n",
@@ -549,13 +551,13 @@ error:
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
@@ -563,6 +565,16 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
 		char buf[BOOTMENU_DEVICE_NAME_MAX];
 		struct efi_device_path *device_path;
 		struct efi_device_path *short_dp;
+		struct efi_block_io *blkio;
+
+		ret = efi_search_protocol(volume_handles[i], &efi_block_io_guid, &handler);
+		blkio = handler->protocol_interface;
+		/*
+		 * The logical partition is excluded since the bootmgr tries to
+		 * boot with the default file by scanning the default file on the fly.
+		 */
+		if (blkio->media->logical_partition)
+			continue;
 
 		ret = efi_search_protocol(volume_handles[i], &efi_guid_device_path, &handler);
 		if (ret != EFI_SUCCESS)
@@ -596,16 +608,18 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
 		 * to store guid, instead of realloc the load_option.
 		 */
 		lo.optional_data = "1234567";
-		opt[i].size = efi_serialize_load_option(&lo, (u8 **)&opt[i].lo);
-		if (!opt[i].size) {
+		opt[num].size = efi_serialize_load_option(&lo, (u8 **)&opt[num].lo);
+		if (!opt[num].size) {
 			ret = EFI_OUT_OF_RESOURCES;
 			goto out;
 		}
 		/* set the guid */
-		optional_data = (char *)opt[i].lo + (opt[i].size - u16_strsize(u"1234567"));
+		optional_data = (char *)opt[num].lo + (opt[num].size - u16_strsize(u"1234567"));
 		memcpy(optional_data, &efi_guid_bootmenu_auto_generated, sizeof(efi_guid_t));
+		num++;
 	}
 
+	*count = num;
 out:
 	return ret;
 }
@@ -835,8 +849,7 @@ efi_status_t efi_bootmgr_delete_boot_option(u16 boot_index)
 /**
  * efi_bootmgr_update_media_device_boot_option() - generate the media device boot option
  *
- * This function enumerates all devices supporting EFI_SIMPLE_FILE_SYSTEM_PROTOCOL
- * and generate the bootmenu entries.
+ * This function enumerates all BlockIo devices and add the boot option for it.
  * This function also provide the BOOT#### variable maintenance for
  * the media device entries.
  * - Automatically create the BOOT#### variable for the newly detected device,
@@ -856,7 +869,7 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
 	struct eficonfig_media_boot_option *opt = NULL;
 
 	ret = efi_locate_handle_buffer_int(BY_PROTOCOL,
-					   &efi_simple_file_system_protocol_guid,
+					   &efi_block_io_guid,
 					   NULL, &count,
 					   (efi_handle_t **)&volume_handles);
 	if (ret != EFI_SUCCESS)
@@ -868,8 +881,7 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
 		goto out;
 	}
 
-	/* enumerate all devices supporting EFI_SIMPLE_FILE_SYSTEM_PROTOCOL */
-	ret = efi_bootmgr_enumerate_boot_option(opt, volume_handles, count);
+	ret = efi_bootmgr_enumerate_boot_option(opt, volume_handles, &count);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
@@ -888,6 +900,9 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
 		u32 boot_index;
 		u16 var_name[9];
 
+		if (!opt[i].size)
+			continue;
+
 		if (!opt[i].exist) {
 			ret = efi_bootmgr_get_unused_bootoption(var_name, sizeof(var_name),
 								&boot_index);
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index ed7214f3a3..a34ef3da68 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -1219,3 +1219,23 @@ struct efi_device_path *search_gpt_dp_node(struct efi_device_path *device_path)
 
 	return NULL;
 }
+
+/**
+ * efi_search_file_path_dp_node() - search file_path device path node
+ *
+ * @device_path:	device path
+ *
+ * Return:	pointer to the DEVICE_PATH_SUB_TYPE_FILE_PATH device path node
+ */
+struct efi_device_path *efi_search_file_path_dp_node(struct efi_device_path *device_path)
+{
+	struct efi_device_path *dp = device_path;
+
+	while (dp) {
+		if (EFI_DP_TYPE(dp, MEDIA_DEVICE, FILE_PATH))
+			return dp;
+		dp = efi_dp_next(dp);
+	}
+
+	return NULL;
+}
-- 
2.34.1

