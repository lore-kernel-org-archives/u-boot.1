Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B29E748E6
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 20:42:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 660F986BB6;
	Sat, 30 Sep 2023 22:42:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j80jqXTD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E7918706B; Sat, 30 Sep 2023 22:42:53 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE1AA86BAD
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 22:42:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7740aa4b545so1024724485a.3
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 13:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696106569; x=1696711369; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HjuYjLVlZMjUzvJQUzAGw6bmEnrK+2wpLwWkgaN4LuY=;
 b=j80jqXTDYQbSoiLVb3/yMmDZoYRT7IdS/TejWNOGydiMObxKgx+9qcI2/361jebEEI
 tLpFQB5dUN9b5kvjdpZM02aKxyb4sYAFi6HM/w1t6WpAj1HGYiTc5XA+WuxToIhUabQE
 pDfaZyzuj2GYORDYEutQG+M5P28KJggkJeUjVqvKbbQqCCUkRcAOwFEgjr1Bmy22V2y5
 E2hmoyUxTiE4cpfqHO3ckYv7wcyH636xN63rZgPO3Yzbf0MJZGrYiAFhj3V9i0i93COH
 nkqahzVV2N/jJfxFq4o9gcaHT+55sQpz+6oPziarhR7RPkkWA2b8Y+WliGNKvW810F0y
 +jBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696106569; x=1696711369;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HjuYjLVlZMjUzvJQUzAGw6bmEnrK+2wpLwWkgaN4LuY=;
 b=MUZdb7mW8jvgQwoVhgz5RTzwMSOecYvap5OY8E9lH5aXv2/u70Y0qoiLgzwhvINSOO
 O3PM4E9wdIO1CDzgRiELw+utQbr/co4l8/aISLQb2S+9xK1FywER63QyPv7xLmkgQq/n
 6PUr0vX0vxLyKKlzGJ6/vOsLLGF2ONRfXmQ3AaFnw8ZWvKlUdPGoecyVh+hz6lyvwzN6
 OvYDuKlXjRPOKpaR3bsPeCUJx/8gQA3oFSeArUatj53HzOs9oesJEbBAlfZAQolFK+oH
 yfT1mcDptMrvqB3yYIvnwhXfVfJqFPK1USIAe9+N9PlY7HMMDWQexsqfvU1pPcinchxI
 +5EA==
X-Gm-Message-State: AOJu0YyFf7qhpNaekRop/5RRRcb088G61f8vUqoLln0UwZM040HZ5V0s
 8ez9UVNL1OVtk6yrPBWGTbn24do4Ivc=
X-Google-Smtp-Source: AGHT+IHbELgAEGmT7bXxDhWLGBxSF8g5FSPjBOKZyXR1bWIXGn/b1wBs8+CmiHG9FgUnJTORDnw+LA==
X-Received: by 2002:a05:620a:953:b0:766:fe28:35a3 with SMTP id
 w19-20020a05620a095300b00766fe2835a3mr7476690qkw.32.1696106569191; 
 Sat, 30 Sep 2023 13:42:49 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 j30-20020a05620a001e00b0076d74da4481sm4637063qki.23.2023.09.30.13.42.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Sep 2023 13:42:48 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Mikhail Ilin <ilin.mikhail.ol@gmail.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH] Revert "fs: ext4: check the minimal partition size to mount"
Date: Sat, 30 Sep 2023 16:42:46 -0400
Message-Id: <20230930204246.515254-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
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

This check breaks small partitions (under 1024 blocks) because part_length
is in units of part.blksz and not bytes. Given the purpose of this
function, we really want to make sure the partition is SUPERBLOCK_START +
SUPERBLOCK_SIZE (2048) bytes so we can call ext4_read_superblock without
error.

The obvious solution is to convert callers from things like

	ext4fs_mount(part_info.size)

to

	ext4fs_mount(part_info.size * part_info.blksz);

However, I'm not really a fan of the bloat that would cause, especially
since the error is now suppressed. I think the best course of action here
is to just revert the patch.

This reverts commit 9905cae65e03335aefcb1ebfab5b7ee62d89f64e.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 fs/ext4/ext4_common.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
index 9a9c520e22c..f50de7c089e 100644
--- a/fs/ext4/ext4_common.c
+++ b/fs/ext4/ext4_common.c
@@ -2373,10 +2373,6 @@ int ext4fs_mount(unsigned part_length)
 	struct ext2_data *data;
 	int status;
 	struct ext_filesystem *fs = get_fs();
-
-	if (part_length < SUPERBLOCK_SIZE)
-		return 0;
-
 	data = zalloc(SUPERBLOCK_SIZE);
 	if (!data)
 		return 0;
-- 
2.37.1

