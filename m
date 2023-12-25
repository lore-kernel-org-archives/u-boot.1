Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1121C3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 04:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44390877DA;
	Mon, 25 Dec 2023 05:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bgaXePCa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 191E3877FC; Mon, 25 Dec 2023 05:45:47 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC01A877DA
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 05:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d408d0bb87so24809495ad.0
 for <u-boot@lists.denx.de>; Sun, 24 Dec 2023 20:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703479542; x=1704084342; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOtwZXIJ0EGfMVXsfrD6wt75lYzzN7mvK9tS/JxaOqY=;
 b=bgaXePCaB44BFno8Q3aAEIep9Me+SkgALeMbJNTup4xiKbJsj79GE394ZsYIE7aa5k
 Lhqcd9hBY2Wxgy6srcr60ULUB5T+PoK3TiLRgWxvhN9DIrXfFsYoNyU4HjeVdcdlJpQK
 dfz4O3QamJizDPdjv9FATVixcAegPlWAnHeZA63znxMtFi4SpQevo6jagBX0QwUqvv8G
 BneSuGJ8Ms9RNTs4bpd7qmEPvlysCk8IwuzjMFX7OT0SJzsMX0STbdnxtBa7j5WFh6k0
 sB9Qlt1zngLo6Ij+geYVYPxwFjUhXs3klNHykhBCEZKM8aXJWoKHbkHcrgumS454F08n
 F+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703479542; x=1704084342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OOtwZXIJ0EGfMVXsfrD6wt75lYzzN7mvK9tS/JxaOqY=;
 b=ZAmPhN8x9Yz9s3VrZQCG6Y71DDL3H1aURG7yZrAor9+75zIuze5KtMqc3UH9sx1jdu
 KErmekr8fumF3wX7xMKfp7SQeG8DKVya0bBoXnaFMTtvjeBJsc0mg2BecSbf8Ievk4lv
 z3qYEOnP3N0i8gccTZG/6sZOi0+985+INeT9jxBuMsAdJ1k95BkcYv7IxJb03jVhw88I
 mInvxpqbJ7ohyO+Tb1vnJHt4ufH7Y8o8XONbuZ7+LIMKgdr6BSR1XfIErFeyoWTJanxO
 Aa07o4QQ4CO/E9EThpAF9vzE4k96XEefIVmgLO60wtG43GpBfeLO/ea3ZJIjhzYMe1bu
 wEzA==
X-Gm-Message-State: AOJu0Yx7h0GFO5JNvYJQxjc6XdzT9cgL3XYds94/UVXHTJOaE2LXc1XV
 sN0NSmK3heeeeuNkd3yAI/aq01dpH86m0V0T2AL0WtRtDGA=
X-Google-Smtp-Source: AGHT+IF4ksdkEwGTOD+aZEzUjZchoMiunOy1M2qPI8zjc7HdBWRCrG5kNd05bHcA4/g/BIMMmCoowA==
X-Received: by 2002:a17:902:ce85:b0:1d3:b3b7:5db0 with SMTP id
 f5-20020a170902ce8500b001d3b3b75db0mr6851253plg.4.1703479542408; 
 Sun, 24 Dec 2023 20:45:42 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 z3-20020a170902ee0300b001d3e3a86dccsm7285018plb.84.2023.12.24.20.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Dec 2023 20:45:41 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH 1/3] efi_loader: remove unused members from struct efi_disk_obj
Date: Mon, 25 Dec 2023 13:43:54 +0900
Message-Id: <20231225044356.626900-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231225044356.626900-1-masahisa.kojima@linaro.org>
References: <20231225044356.626900-1-masahisa.kojima@linaro.org>
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

part and dev_index in struct efi_disk_obj are not used,
let's remove it.

This commit also removes the invalid structure comment
for @dev, it does not exist.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 lib/efi_loader/efi_disk.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index f0d76113b0..a2f8b531a3 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -32,20 +32,15 @@ const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
  *
  * @header:	EFI object header
  * @ops:	EFI disk I/O protocol interface
- * @dev_index:	device index of block device
  * @media:	block I/O media information
  * @dp:		device path to the block device
- * @part:	partition
  * @volume:	simple file system protocol of the partition
- * @dev:	associated DM device
  */
 struct efi_disk_obj {
 	struct efi_object header;
 	struct efi_block_io ops;
-	int dev_index;
 	struct efi_block_io_media media;
 	struct efi_device_path *dp;
-	unsigned int part;
 	struct efi_simple_file_system_protocol *volume;
 };
 
@@ -383,7 +378,6 @@ static int efi_fs_exists(struct blk_desc *desc, int part)
  * @parent:		parent handle
  * @dp_parent:		parent device path
  * @desc:		internal block device
- * @dev_index:		device index for block device
  * @part_info:		partition info
  * @part:		partition
  * @disk:		pointer to receive the created handle
@@ -394,7 +388,6 @@ static efi_status_t efi_disk_add_dev(
 				efi_handle_t parent,
 				struct efi_device_path *dp_parent,
 				struct blk_desc *desc,
-				int dev_index,
 				struct disk_partition *part_info,
 				unsigned int part,
 				struct efi_disk_obj **disk,
@@ -456,7 +449,6 @@ static efi_status_t efi_disk_add_dev(
 		diskobj->dp = efi_dp_from_part(desc, part);
 		diskobj->media.last_block = desc->lba - 1;
 	}
-	diskobj->part = part;
 
 	/*
 	 * Install the device path and the block IO protocol.
@@ -499,7 +491,6 @@ static efi_status_t efi_disk_add_dev(
 			goto error;
 	}
 	diskobj->ops = block_io_disk_template;
-	diskobj->dev_index = dev_index;
 
 	/* Fill in EFI IO Media info (for read/write callbacks) */
 	diskobj->media.removable_media = desc->removable;
@@ -519,7 +510,7 @@ static efi_status_t efi_disk_add_dev(
 
 	EFI_PRINT("BlockIO: part %u, present %d, logical %d, removable %d"
 		  ", last_block %llu\n",
-		  diskobj->part,
+		  part,
 		  diskobj->media.media_present,
 		  diskobj->media.logical_partition,
 		  diskobj->media.removable_media,
@@ -566,7 +557,7 @@ static int efi_disk_create_raw(struct udevice *dev, efi_handle_t agent_handle)
 	diskid = desc->devnum;
 
 	ret = efi_disk_add_dev(NULL, NULL, desc,
-			       diskid, NULL, 0, &disk, agent_handle);
+			       NULL, 0, &disk, agent_handle);
 	if (ret != EFI_SUCCESS) {
 		if (ret == EFI_NOT_READY) {
 			log_notice("Disk %s not ready\n", dev->name);
@@ -627,7 +618,7 @@ static int efi_disk_create_part(struct udevice *dev, efi_handle_t agent_handle)
 		return -1;
 	dp_parent = (struct efi_device_path *)handler->protocol_interface;
 
-	ret = efi_disk_add_dev(parent, dp_parent, desc, diskid,
+	ret = efi_disk_add_dev(parent, dp_parent, desc,
 			       info, part, &disk, agent_handle);
 	if (ret != EFI_SUCCESS) {
 		log_err("Adding partition for %s failed\n", dev->name);
-- 
2.34.1

