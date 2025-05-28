Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A388C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 19:48:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0BF8833FC;
	Wed, 28 May 2025 21:48:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kOmUrkeY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA2338344C; Wed, 28 May 2025 21:48:50 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 779B2833D0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 21:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-747abb3cd0bso375755b3a.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 12:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748461727; x=1749066527; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AMiqpkXirJso6EnDP1A0HAw7DKfoNljq6WlxiF1zWsU=;
 b=kOmUrkeYzZeG0PPPfgm/GrzJ8ncHxwGbPievBu3UPp/2do4cGON2NEdyavYH2ShjSz
 pvDMHXHgVNLH7LtzZp4foGXz2K5sAuaE5nH1pfAnyBB+CAQ55XEQRBSeJMTqdnqKfjC7
 GXqR0nAaZCYZTzs7syGnbACfIXPpPE1Mt7aYDkac46hXVK1eMG/6ML5mUPkkStP027hc
 SDQNM4Zsm40xXNYdmAsiPPPm0fgiIR76IH5yW8lJuJyxZOIYC3l68cKu3Du/U2QV1AcP
 +99HMf44JbaDS8pglnLJRLuarxYyEUwcP8YYGS7gYc/B1eYrzHCHe1uLnp/kGRzBRixI
 nFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748461727; x=1749066527;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AMiqpkXirJso6EnDP1A0HAw7DKfoNljq6WlxiF1zWsU=;
 b=oxoCRYiesNkXC0AHcm8RSdFbRV+FnZagb0C74M1YZX8r6Wr76RZLW91nNGkHIdETw2
 tu+MKFS2pfTAydMFDW6OHZfKRaTtlr/NOQ7pvpITL+65LZpowMmvt5pNz30BQtMVOEnj
 Zoi2arTdHRx0MYWmBQNm1KHqJA5pzorKSpg5EQx74hCgmf0EEZ2849DUyuKkfbvlfg8m
 Q0uJ9++LXwIwthT1Un9xBUiwc5NXHN9ugcuSFixLWy+CLfwPKwSUVqaxw+AZbGzhzTga
 mZ9YUkaJVoy7zwhhMs3xIAGR4Jtl0vFgj5aXh1/XbAkLaev736tAvhuqWWWwxEmqLheQ
 KMFg==
X-Gm-Message-State: AOJu0YxkdvZYr3IJ5swUEPHGXDKhYolSZpBdCixd/b5/Z8xNgW61CIeU
 2Pqtkwhs0+d1vKWgBfvLI07r53Z7KdM0tGQPkZQn39Xg4TDBRxQ7oQfs
X-Gm-Gg: ASbGncsOUGjuXJAdwCGTAVq2LwLEt0hFm3dbeYJeyNHaZqgM4F9rgCrxJ/iNusClZqo
 Kei2PtfK85MEuwe87bVweJjK0+7NPv9c9HG5q9C00uH/9zus0/g6An0WbsNJvyGciXoV6h+UA0Z
 fnWE25KnpBBWq7aM1pVbCn/atn7MHZE0XqsdhAcwwbRY6P44BHfduwOW/JG6vES8c/Z7ZNo6Fo0
 djMJZym/jVAPEL5gzbpBpzju1rv7aphpd/JQC2JymVdhxWXJzSrjRfY02YiEibNo3jujJ7QOGDl
 aB3yea1UiAy15HHvNXI6rqDE/xI65Y/64UOPA3qD1DHzCQkOz+FaI4kzWTrUDYlizyHeG8xJ9gH
 U1pOq+7eF3OGLtrdyM1OZV+Wi8MrxYFgEbtTrWfs=
X-Google-Smtp-Source: AGHT+IH10ExZKd65ln5+xYjgl0W8AQg7MN3Dny/HCj4WX3DvlCO0VqKbziYJLpUdrx+V93uM1fLRCg==
X-Received: by 2002:a17:90b:2786:b0:311:a5ab:3d47 with SMTP id
 98e67ed59e1d1-31214e2651amr1192971a91.1.1748461726928; 
 Wed, 28 May 2025 12:48:46 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3121ba3e5c7sm14306a91.45.2025.05.28.12.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 12:48:46 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tony Dinh <mibodhi@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH] ext4fs: Fix: Read outside partition error (take 2)
Date: Wed, 28 May 2025 12:48:39 -0700
Message-Id: <20250528194839.1206-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.5
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

Use lbaint_t for blknr to avoid overflow in ext4fs_read_file().

Background:

blknr (block number) used in ext4fs_read_file() could be increased to a
very large value and causes a wrap around at 32 bit signed integer max,
thus becomes negative. This results in an out-of-normal range for sector
number (during the assignment delayed_start = blknr) where delayed_start
sector is typed uint64 lbaint_t. This causes the "Read outside partition"
error.

Looks like we also have this overflown problem in ext4_write.c that needs
to be addressed.

This patch was tested on the Synology DS116 (Armada 385) board, and a
4TB Seagate HDD.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 fs/ext4/ext4fs.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
index 1727da2dc6d..3d68d6c6394 100644
--- a/fs/ext4/ext4fs.c
+++ b/fs/ext4/ext4fs.c
@@ -101,17 +101,21 @@ int ext4fs_read_file(struct ext2fs_node *node, loff_t pos,
 	blockcnt = lldiv(((len + pos) + blocksize - 1), blocksize);
 
 	for (i = lldiv(pos, blocksize); i < blockcnt; i++) {
-		long int blknr;
+		lbaint_t blknr;
+		long blknr_and_status;
 		int blockoff = pos - (blocksize * i);
 		int blockend = blocksize;
 		int skipfirst = 0;
-		blknr = read_allocated_block(&node->inode, i, &cache);
-		if (blknr < 0) {
+		blknr_and_status = read_allocated_block(&node->inode, i, &cache);
+		if (blknr_and_status < 0) {
 			ext_cache_fini(&cache);
 			return -1;
 		}
 
-		blknr = blknr << log2_fs_blocksize;
+		/* Block number could becomes very large when CONFIG_SYS_64BIT_LBA is enabled
+		 * and wrap around at max long int
+		 */
+		blknr = (lbaint_t)blknr_and_status << log2_fs_blocksize;
 
 		/* Last block.  */
 		if (i == blockcnt - 1) {
-- 
2.39.5

base-commit: e04d137231f2e9e14708a32448c879125b8e308f
branch: master
