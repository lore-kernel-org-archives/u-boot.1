Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AC5CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 20:33:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB1C0836EE;
	Wed,  1 Oct 2025 22:31:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FpIK5SI4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4B23837B9; Wed,  1 Oct 2025 22:31:07 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2B76836A7
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 22:31:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-35ba7c71bfdso221092fac.3
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 13:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759350664; x=1759955464; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=FnUY7RO3eAq4kNNLLnI20xxORO6Iz+JnjH+UVkgFK6Q=;
 b=FpIK5SI4FCClf4KJPkbqZGeZXXBXrxHr18X/Ma1yK0zz/LVgTkRz4zh8jlJ7TbFmDw
 uAeYurucXryZOKurj5hbH0vsOvadmhA6COIxLF2RcCgdHreUOYvNDz2Pm0JtTKxVgQ1Y
 qw3Eh1RVPcG0qqtr8T74n6FPHIFMMd7KhCLoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759350664; x=1759955464;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FnUY7RO3eAq4kNNLLnI20xxORO6Iz+JnjH+UVkgFK6Q=;
 b=jWlFPgHgZTQNEMr8nHRBaki5MGO1oFX0NYYSUr12zdHBR4CowgCNhUp1Z/h7y1vrab
 19OA9I35vj++Oi2G43vnQDRGWuGMp//8xaqCf/8AxBrz83gWh5dHGrx+5OeSO7eAVz6C
 9fYLzJ4KUAoFNoTCJ3qw/8fmDCH3df98Tn3X4ZM+qYefQJLw+znypai0LxzG+67Dcy74
 2s1wPjLa+GQvzs2dHtsw5ygHrQlx38mPf+3dIi8Qmx6s/5TbuWuewuqxlQ0HYTzllHgp
 3rEvQcsxcBnzR85Jyn0MW1MQ0WlrFjQTE/4eB+dqTvbyri9qcHfqMFsxD9nEOk6LD0UB
 SmnA==
X-Gm-Message-State: AOJu0Yzw/XQWiOsDranmBObDeEkGcQF2t6bF3xO3dz8FxYrcKd7wPn/7
 fZu5xbsRFuRVPwjW1OVMUp3lZuvpFRsIYoIlDTxVRvTrdP4/xFpWaedu/BPo5jcWNx3nRw9WJWZ
 vGxm70X4=
X-Gm-Gg: ASbGncs8tTKH2G6O2i3ujl71kwiv98I/bRJO5fT+Al6Q2L9/tk2XkKZGXaCYZfJH6F1
 GNjCqCSe1Cghbfy1tGrQ3g11TTkGsoXxKzFcfxTsqoQkggC/8Qxjaz2BL8gCKenT56WvBNcxAdI
 ycV1+49BlPEIme57WYm7GSpea7YXHU1dhgtJxyGv8aq+n/mhfdCgVelXuaj39SAGPCPEvdP9aKP
 eNtRq6Lq2y1fMmS6/L6tTVIlKvUF4G5CvBTFUnj104kgG1kupfnxfanb6aH2AzFw0uji28CwldF
 eXT/aW2PGLQJo4+OXP21CFLrNwlOg9B3dleLjq598ffeXuwKOh1FOcWm8sye7PJzKHVYLGKtOJ3
 G2+E1UAdCP5RdBOzj7Zk42ZqZ7TwSVety9DWrA2JC0VN6N/DIDjK5KA/CvSiSBv6yUwOiRtjUMR
 Tb7wTng6c=
X-Google-Smtp-Source: AGHT+IGFzJi98kNHZdfZW5qkeH3Y/WgUufDr5Wi+SOqqv/9GM/mnlTbGEzNWI2MO7r8PTl4eHkq0Qw==
X-Received: by 2002:a05:6870:a9a5:b0:395:4428:a07 with SMTP id
 586e51a60fabf-39bb2221841mr2847345fac.39.1759350664449; 
 Wed, 01 Oct 2025 13:31:04 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ab794bd04esm224715fac.10.2025.10.01.13.31.03
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 13:31:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] fs: Rework filesystem guards for xPL phases
Date: Wed,  1 Oct 2025 14:31:03 -0600
Message-ID: <20251001203103.2828593-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

When adding filesystems to the table in fs/fs.c we need to use
CONFIG_IS_ENABLED(FS_xxx) so that we only include references to a given
filesystem when CONFIG_FS_xxx or CONFIG_SPL_FS_xxx or similar are
enabled. Update the filesystems which weren't doing this to follow that
pattern.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 fs/fs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/fs.c b/fs/fs.c
index 2650328b3585..c7706d9af859 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -316,8 +316,7 @@ static struct fstype_info fstypes[] = {
 	},
 #endif
 #endif
-#ifndef CONFIG_XPL_BUILD
-#ifdef CONFIG_FS_BTRFS
+#if CONFIG_IS_ENABLED(FS_BTRFS)
 	{
 		.fstype = FS_TYPE_BTRFS,
 		.name = "btrfs",
@@ -337,7 +336,6 @@ static struct fstype_info fstypes[] = {
 		.rename = fs_rename_unsupported,
 	},
 #endif
-#endif
 #if CONFIG_IS_ENABLED(FS_SQUASHFS)
 	{
 		.fstype = FS_TYPE_SQUASHFS,
@@ -360,7 +358,7 @@ static struct fstype_info fstypes[] = {
 		.rename = fs_rename_unsupported,
 	},
 #endif
-#if IS_ENABLED(CONFIG_FS_EROFS)
+#if CONFIG_IS_ENABLED(FS_EROFS)
 	{
 		.fstype = FS_TYPE_EROFS,
 		.name = "erofs",
@@ -382,7 +380,7 @@ static struct fstype_info fstypes[] = {
 		.rename = fs_rename_unsupported,
 	},
 #endif
-#if IS_ENABLED(CONFIG_FS_EXFAT)
+#if CONFIG_IS_ENABLED(FS_EXFAT)
 	{
 		.fstype = FS_TYPE_EXFAT,
 		.name = "exfat",
-- 
2.43.0

