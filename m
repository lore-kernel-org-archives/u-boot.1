Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B289C021B0
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 112878110C;
	Wed, 19 Feb 2025 14:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="TPYGoR+G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FCAA809A4; Wed, 19 Feb 2025 11:17:08 +0100 (CET)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD41F800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 11:17:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=joaomarcos.costa@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF7B51F764;
 Wed, 19 Feb 2025 10:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1739960220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rhs8VrNYLvL+ZCVESIr5ql6WCmdRLV6JhJY91t162EI=;
 b=TPYGoR+Gu0fFRfz0aA10ax45meQ387UvBNwus78xupjOVK0n4dLM79sO8N4RC3Vfkx6J6/
 Ze3OyS8Qr9Z3MXxlnX4x6WWKBrw/fA5PSh7EOgfH8KRi2+LdzRwdlbpqtVd/ei3rOYb3Mq
 b7KiUZxqNSkWiaxdvrZ+rkIoHPU1IOBxR+ap193so+6uef+PhdL2SARdmuOoEEko5UKThJ
 6F8s+OpfPFOyAVu7FoxnU/MVVbmetY60SSZMSh+ESVv27qIunEJ2PO35xLS7tZ5WqpCS+c
 zzm3fFH9c8nTLj1MCjfGdx+A7TMaYkRXqTPFW+8crUR/WXk5G5NspN00Z3Hopw==
From: joaomarcos.costa@bootlin.com
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
 jonathanbaror@gmail.com, Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Subject: [PATCH] fs/squashfs: fix potential integer overflows
Date: Wed, 19 Feb 2025 11:16:33 +0100
Message-ID: <20250219101633.1655153-1-joaomarcos.costa@bootlin.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeifeelkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepjhhorghomhgrrhgtohhsrdgtohhsthgrsegsohhothhlihhnrdgtohhmnecuggftrfgrthhtvghrnhepkedtvdeigfevgfeliedvgedtffdvfedtueeugfehkeevgfdvhfdtfeefudevudetnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemhegvugehmeeisgdtudemkedvjedvmegsvgguleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemhegvugehmeeisgdtudemkedvjedvmegsvgguledphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepjhhorghomhgrrhgtohhsrdgtohhsthgrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhess
 ghoohhtlhhinhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhgsrghrohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhorghomhgrrhgtohhsrdgtohhsthgrsegsohhothhlihhnrdgtohhm
X-GND-Sasl: joaomarcos.costa@bootlin.com
X-Mailman-Approved-At: Wed, 19 Feb 2025 14:04:13 +0100
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

From: Joao Marcos Costa <joaomarcos.costa@bootlin.com>

The length of buffers used to read inode tables, directory tables, and
reading a file are calculated as: number of blocks * block size, and
such plain multiplication is prone to overflowing (thus unsafe).

Replace it by __builtin_mul_overflow, i.e. safe math.

Signed-off-by: Joao Marcos Costa <joaomarcos.costa@bootlin.com>
---
 fs/squashfs/sqfs.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index b9314019b1b..8fac6c6c5a9 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -719,6 +719,7 @@ static int sqfs_read_inode_table(unsigned char **inode_table)
 	u32 src_len, dest_offset = 0;
 	unsigned long dest_len = 0;
 	bool compressed;
+	size_t buf_size;
 
 	table_size = get_unaligned_le64(&sblk->directory_table_start) -
 		get_unaligned_le64(&sblk->inode_table_start);
@@ -728,7 +729,10 @@ static int sqfs_read_inode_table(unsigned char **inode_table)
 				  sblk->directory_table_start, &table_offset);
 
 	/* Allocate a proper sized buffer (itb) to store the inode table */
-	itb = malloc_cache_aligned(n_blks * ctxt.cur_dev->blksz);
+	if (__builtin_mul_overflow(n_blks, ctxt.cur_dev->blksz, &buf_size))
+		return -EINVAL;
+
+	itb = malloc_cache_aligned(buf_size);
 	if (!itb)
 		return -ENOMEM;
 
@@ -806,6 +810,7 @@ static int sqfs_read_directory_table(unsigned char **dir_table, u32 **pos_list)
 	u32 src_len, dest_offset = 0;
 	unsigned long dest_len = 0;
 	bool compressed;
+	size_t buf_size;
 
 	*dir_table = NULL;
 	*pos_list = NULL;
@@ -818,7 +823,10 @@ static int sqfs_read_directory_table(unsigned char **dir_table, u32 **pos_list)
 				  sblk->fragment_table_start, &table_offset);
 
 	/* Allocate a proper sized buffer (dtb) to store the directory table */
-	dtb = malloc_cache_aligned(n_blks * ctxt.cur_dev->blksz);
+	if (__builtin_mul_overflow(n_blks, ctxt.cur_dev->blksz, &buf_size))
+		return -EINVAL;
+
+	dtb = malloc_cache_aligned(buf_size);
 	if (!dtb)
 		return -ENOMEM;
 
@@ -1369,6 +1377,7 @@ static int sqfs_read_nest(const char *filename, void *buf, loff_t offset,
 	unsigned long dest_len;
 	struct fs_dirent *dent;
 	unsigned char *ipos;
+	size_t buf_size;
 
 	*actread = 0;
 
@@ -1573,7 +1582,10 @@ static int sqfs_read_nest(const char *filename, void *buf, loff_t offset,
 	table_offset = frag_entry.start - (start * ctxt.cur_dev->blksz);
 	n_blks = DIV_ROUND_UP(table_size + table_offset, ctxt.cur_dev->blksz);
 
-	fragment = malloc_cache_aligned(n_blks * ctxt.cur_dev->blksz);
+	if (__builtin_mul_overflow(n_blks, ctxt.cur_dev->blksz, &buf_size))
+		return -EINVAL;
+
+	fragment = malloc_cache_aligned(buf_size);
 
 	if (!fragment) {
 		ret = -ENOMEM;
-- 
2.47.0

