Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64ED0C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 08:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4CA086FFE;
	Wed, 20 Dec 2023 09:43:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mDfwDfha";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D294586FFE; Wed, 20 Dec 2023 09:43:38 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F275B8761C
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 09:43:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d337dc9697so44074045ad.3
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 00:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703061813; x=1703666613; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DmGgBfSQr7vKFYTwf/qAKZkof3bWieFVSPdJmkpTVMg=;
 b=mDfwDfharR3d/lawt6n0pnQ5AZjEatmOLAkeCb13uyiWuwZPZrm7Rh9uuK69PjIYNK
 X3Qx0oNpl+aDra+WTtPZuFDpoZOE8dpXMHQTjJbzHq++rC8VljLRE6/ljYABhvlsrSrW
 Gm2Y6FfUaF80WcweOLq3vGWYBZx2j7S917I4b+rr384RjZzJa1nqPYnfkHBjWf6mg6Lo
 8g9et98a6rxgMhvhKBU/SLdXY18gqipvWpzagm/Hx5y82Z4Ov8AfBBlDv7gGNkrgBT16
 s40wMYKaKgJF2JJMIqoyWSrL1feg/MaUB3ycQQ4frP80YDWZT+p7E8dIhcy+WAg2u27V
 blag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703061813; x=1703666613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DmGgBfSQr7vKFYTwf/qAKZkof3bWieFVSPdJmkpTVMg=;
 b=IhN1KbSMU8n/B82TyLB+eT1GjF4hXBF+eMDqbD2JSyppBo5Nq6nzl/YjLRaHuqiBQ8
 dK8+dYOBtc0d/cGTnh5rmS793aZAlUYgigsChGxCviZVZec0P8MyXVGuPeOAzIvJfIvo
 6MtQNej/lTFmcTQBEFZTfVq8GvxV5rJ79eUUXcD/IDaNmuyS3awNedevRW+2Ye38x/8K
 ZBnR909Sx8Qs6on+EExEJDUpgp8e3C1JZf/2ye4aVa92dISuj9SEiMCHXDRfCxvz68+D
 cAIlzZ5B+pLXyT7Y2M/GHFP+bXjHu83r2B2ZNAuvTXcRbrhX7kfvGgssiPP5uv/aAX9Z
 Ewyg==
X-Gm-Message-State: AOJu0YzP9zmKBoJr2bEVh8fp/TSG0KmU1zjB8mhuG6sJV3MfJd9HvJq3
 EF7UAKe1y7ZTgS/alsSPxhPURTiMQCKAhi1wVXo=
X-Google-Smtp-Source: AGHT+IHlIMI3Xjzen0gF+0kR0HYnJrDjYQNc7TL/bNANvM5vqdfkqBzVToKneaHNa0MdNrhWRiBHwA==
X-Received: by 2002:a17:902:7ec1:b0:1d0:6297:150a with SMTP id
 p1-20020a1709027ec100b001d06297150amr16662788plb.47.1703061813451; 
 Wed, 20 Dec 2023 00:43:33 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 z3-20020a170902834300b001d1d1ef8be5sm22409694pln.173.2023.12.20.00.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 00:43:32 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH 2/2] efi_loader: auto-generate removable media boot option
 first
Date: Wed, 20 Dec 2023 17:41:32 +0900
Message-Id: <20231220084133.435240-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220084133.435240-1-masahisa.kojima@linaro.org>
References: <20231220084133.435240-1-masahisa.kojima@linaro.org>
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
 lib/efi_loader/efi_bootmgr.c | 37 ++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 636f01e2eb..6b02abcf0d 100644
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
 
@@ -810,12 +813,20 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
 		struct efi_device_path *short_dp;
 		struct efi_block_io *blkio;
 
+		if (num >= *count) {
+			ret = EFI_INVALID_PARAMETER;
+			goto out;
+		}
+
 		ret = efi_search_protocol(handles[i], &efi_block_io_guid, &handler);
 		blkio = handler->protocol_interface;
 
 		if (blkio->media->logical_partition)
 			continue;
 
+		if (removable != (blkio->media->removable_media != 0))
+			continue;
+
 		ret = efi_search_protocol(handles[i], &efi_guid_device_path, &handler);
 		if (ret != EFI_SUCCESS)
 			continue;
@@ -1105,7 +1116,7 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
 {
 	u32 i;
 	efi_status_t ret;
-	efi_uintn_t count;
+	efi_uintn_t count, num, total;
 	efi_handle_t *handles = NULL;
 	struct eficonfig_media_boot_option *opt = NULL;
 
@@ -1122,22 +1133,32 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
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
 
@@ -1166,7 +1187,7 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
 
 out:
 	if (opt) {
-		for (i = 0; i < count; i++)
+		for (i = 0; i < total; i++)
 			free(opt[i].lo);
 	}
 	free(opt);
-- 
2.34.1

