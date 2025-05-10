Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297D8C3ABC9
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BEE182B33;
	Sat, 10 May 2025 15:07:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VfzsjFHG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C04C826AA; Sat, 10 May 2025 15:07:19 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EC9682B33
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ad1b94382b8so418257866b.0
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746882435; x=1747487235; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B3/ssMtj008KDVYEcnCSTkSXxLKBsmQ7Psch13RSRUk=;
 b=VfzsjFHGuXhHpD47W2LCxh7s8lDq5tA1bM2zjRScCP1xsLycCHpXfinmbsfe8SACMY
 epaUghKG31ZpPHgS6DS3GunjpqFgao5mwTK77q0ec1wiSZh4JHneufQEEhFA3US8TEZX
 MSSsE4pDyk5CKCMXda05CYpVTzgn0yapbhFXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746882435; x=1747487235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B3/ssMtj008KDVYEcnCSTkSXxLKBsmQ7Psch13RSRUk=;
 b=kFoEhLuWirIk46TaAXCsh7/0yojl1b3O5xuKn1HsUnFDj7N5lozwjQl85NGZWH8ZHT
 6f0+8luNfLYZMkjQShUg9QTvi9X6vtackPC43bdQjr//xf3Bux4wHAm6sJuJGFlpO20C
 f2dE05D7Hrzaqi6PFGB3PoKGgmcptOn8R8SXXYYrsh3eOpHZiiD4Ygqn6oaErG7hd85g
 jKTk71iqcMdNW4FkVdof19XTSb2w6rCrfaoSOyeclMEktAiDBrbGixKsXpJbsMyTj755
 xPRe2jmmZZrpKBcNmFu4kinSIFIoYDefpeL480FQTqn48N/sp2eJrgkL3vtuVkTy/xc4
 yQEA==
X-Gm-Message-State: AOJu0YwhW0hB36X5mnRPjfvZt9qmzlFqi4EMCxSREHVseV2vKPnfDU81
 CXHM58VYK4t5f+tolODcfQXmkbJNnfgfLEiM1nsP9R2n/paDy5L8+Z0T/C5llCM8bI2L/6ylp6J
 ZEiBcxyl7LQ==
X-Gm-Gg: ASbGncueB3086DechOsEbnjYDfo0q8TATxsz8QPp63/ndpPh6tbnopHoEkyuOVVq8fN
 Izj1jprJSnDyRLIkTij9nXVTXeYEJxc2IQ49LVoihKisJ/eF+cYJjJuSQCms8N9UgRtQL17+01+
 IDHF1gk9ihKcRy7Y3Lu9RRYWWQ2N0eS8U8vC79WANnFRV8vBzmuGIk0YG5w++Kkk7OpuG7dS8R5
 xICvZ98o5I7RGeJqOIGTsYXqq3tcNQ7Wtl/q5/no8P3A7pvQddln9e/OH+QJRbdAK1PjeAQxt8e
 sDlS7qXVR5NwuPk6GMkgffPF+GLae1JqTvHqAzZ9+0UrMno=
X-Google-Smtp-Source: AGHT+IEJmk4ViT1yjxz7psiguu9yiWEjXK+sWB6OLrWx32Iyc8ST4AXD4unB+suNl9uvrUFx7GBMQw==
X-Received: by 2002:a17:907:1808:b0:ad2:2e5c:89c5 with SMTP id
 a640c23a62f3a-ad22e5c94fbmr370330366b.20.1746882435401; 
 Sat, 10 May 2025 06:07:15 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad24085b44fsm52272966b.149.2025.05.10.06.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:07:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Richard Weinberger <richard@nod.at>, Tom Rini <trini@konsulko.com>,
 Uma Shankar <uma.shankar@samsung.com>,
 =?UTF-8?q?=C5=81ukasz=20Majewski?= <l.majewski@samsung.com>
Subject: [PATCH v3 10/10] ext4: Check for overflow when allocating tables
Date: Sat, 10 May 2025 15:06:16 +0200
Message-ID: <20250510130642.1575114-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510130642.1575114-1-sjg@chromium.org>
References: <20250510130642.1575114-1-sjg@chromium.org>
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

An overflow could cause too little memory to be allocated, thus
potentially causing undefined behaviour. Add a check for overflow.

Since blk_bmaps and inode_bmaps use the same size, share the variable.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Use Linux macros instead of gcc built-ins

 fs/ext4/ext4_write.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index a48d1fd26be..a9a53214dce 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -607,6 +607,7 @@ int ext4fs_init(void)
 	int i;
 	uint32_t real_free_blocks = 0;
 	struct ext_filesystem *fs = get_fs();
+	size_t alloc_size;
 
 	/* check for a reasonable block size, no more than 64K */
 	if (LOG2_BLOCK_SIZE(ext4fs_root) > 16)
@@ -643,7 +644,9 @@ int ext4fs_init(void)
 	}
 
 	/* load all the available bitmap block of the partition */
-	fs->blk_bmaps = zalloc(fs->no_blkgrp * sizeof(char *));
+	if (check_mul_overflow(fs->no_blkgrp, sizeof(char *), &alloc_size))
+		goto fail;
+	fs->blk_bmaps = zalloc(alloc_size);
 	if (!fs->blk_bmaps)
 		goto fail;
 	for (i = 0; i < fs->no_blkgrp; i++) {
@@ -663,7 +666,7 @@ int ext4fs_init(void)
 	}
 
 	/* load all the available inode bitmap of the partition */
-	fs->inode_bmaps = zalloc(fs->no_blkgrp * sizeof(unsigned char *));
+	fs->inode_bmaps = zalloc(alloc_size);
 	if (!fs->inode_bmaps)
 		goto fail;
 	for (i = 0; i < fs->no_blkgrp; i++) {
-- 
2.43.0

