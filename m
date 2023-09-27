Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90403E810AD
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 09:38:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14B6386DD2;
	Wed, 27 Sep 2023 11:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w8pVuwRg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B518086DD0; Wed, 27 Sep 2023 11:38:04 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78B448074B
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 11:38:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6c0a42a469dso6534290a34.2
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 02:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695807481; x=1696412281; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bqGQkHQBf5az5rpJBiealCZjI9dpuG5ZGnOopq89qXU=;
 b=w8pVuwRgvMFQBnzvNX+fjJm/ZtFms5obZr62yuhdayKxmaTlPkFIpuaAF2nDS8g/4D
 8FwbnqtIaDgP3r+7d52pBjljI69cBnjCc1oWfgVl0U1W/5d7PK9sxUGbYdvTGiwdr03R
 jcJXZzhrIRfGfnnSay9e+243jqMymC9HkS5fl6CWk8GUbyq8eSnmCcPdzDp9tGFJaXAm
 HgukGkuDJByjZXI/MbCH59frJCG4E5h4pRDMPoQWJ7JWIxwJpxlHrOswWOLJpH9Fd5i6
 Ipu3F3CEKd9adXRRB0FoUMcinFsFUwECtyVnUvUSqVrLEvqjkag1Rsp+3q5hUey6oldO
 pLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695807481; x=1696412281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bqGQkHQBf5az5rpJBiealCZjI9dpuG5ZGnOopq89qXU=;
 b=V+Rdhq2zaP/V1uqaVD1ZPdClvklFXZzUPOkhD6OeDMrB0VfgwzfTwAt9lT3wHn4aUP
 s7dqaX+bbsXOMrRsIyE7G1PN0fE4QaNWdVA5qfJmJIVn6iDGRdU2flRyBno5/9u13dXb
 AecatFGrzatPxEAmvGLsgbM9shfhtcrCG70qF/LZWEppmYr1aya39Dprmnk04zG44ada
 VOtPEHTSyMkUjXWfPVwphG6Bo8/RR0IhKT1DmGj0W435clTHMynxY2WBbYG2M93wTEeU
 jOUeWYZZr/Qzi0HHsnBvlclxuKGxlNyjb3mRC8jK7bLMFgJEhUz0pg7M6IBi3NJGjwvj
 nxaQ==
X-Gm-Message-State: AOJu0YzlcM2N+ja43uJm+hHZdgQavvTfezyNcXjSA3m1auqSvNH4X/7F
 kYVk2mOegt4j6RVLneUeokTNjXTITtxx8mD3kug=
X-Google-Smtp-Source: AGHT+IEnpUNtIO2SbuemA/R6CnfhJ2QEiLKQzF+kp9jSVVwjmoCY721T6c2pO5BirYQLp2PzeLbA8g==
X-Received: by 2002:a05:6830:12ce:b0:6b9:696d:716a with SMTP id
 a14-20020a05683012ce00b006b9696d716amr1602852otq.18.1695807480661; 
 Wed, 27 Sep 2023 02:38:00 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 j17-20020a62e911000000b0068be7119e55sm11384890pfh.122.2023.09.27.02.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 02:37:59 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v5 7/7] efi_loader: create BlockIo device boot option
Date: Wed, 27 Sep 2023 18:36:31 +0900
Message-Id: <20230927093631.1595494-8-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927093631.1595494-1-masahisa.kojima@linaro.org>
References: <20230927093631.1595494-1-masahisa.kojima@linaro.org>
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
 lib/efi_loader/efi_bootmgr.c     | 50 ++++++++++++++++++++++----------
 lib/efi_loader/efi_device_path.c | 20 +++++++++++++
 3 files changed, 55 insertions(+), 16 deletions(-)

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
index a5030d50c0..2da80428b4 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -387,7 +387,6 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
 	}
 
 	if (lo.attributes & LOAD_OPTION_ACTIVE) {
-		struct efi_device_path *file_path;
 		u32 attributes;
 
 		log_debug("trying to load \"%ls\" from %pD\n", lo.label,
@@ -407,11 +406,17 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
 			} else {
 				ret = EFI_LOAD_ERROR;
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
+			if (h)
+				ret = load_default_file_from_blk_dev(h->dev, handle);
+			else
+				ret = EFI_LOAD_ERROR;
 		}
 		if (ret != EFI_SUCCESS) {
 			log_warning("Loading %ls '%ls' failed\n",
@@ -551,13 +556,13 @@ error:
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
@@ -565,6 +570,16 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
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
@@ -598,16 +613,18 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
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
@@ -837,8 +854,7 @@ efi_status_t efi_bootmgr_delete_boot_option(u16 boot_index)
 /**
  * efi_bootmgr_update_media_device_boot_option() - generate the media device boot option
  *
- * This function enumerates all devices supporting EFI_SIMPLE_FILE_SYSTEM_PROTOCOL
- * and generate the bootmenu entries.
+ * This function enumerates all BlockIo devices and add the boot option for it.
  * This function also provide the BOOT#### variable maintenance for
  * the media device entries.
  * - Automatically create the BOOT#### variable for the newly detected device,
@@ -858,7 +874,7 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
 	struct eficonfig_media_boot_option *opt = NULL;
 
 	ret = efi_locate_handle_buffer_int(BY_PROTOCOL,
-					   &efi_simple_file_system_protocol_guid,
+					   &efi_block_io_guid,
 					   NULL, &count,
 					   (efi_handle_t **)&volume_handles);
 	if (ret != EFI_SUCCESS)
@@ -870,8 +886,7 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
 		goto out;
 	}
 
-	/* enumerate all devices supporting EFI_SIMPLE_FILE_SYSTEM_PROTOCOL */
-	ret = efi_bootmgr_enumerate_boot_option(opt, volume_handles, count);
+	ret = efi_bootmgr_enumerate_boot_option(opt, volume_handles, &count);
 	if (ret != EFI_SUCCESS)
 		goto out;
 
@@ -890,6 +905,9 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
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

