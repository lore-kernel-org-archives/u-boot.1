Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49886E77188
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 13:59:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E31480786;
	Tue, 24 Dec 2024 14:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RFbRNDRC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ADF58074B; Tue, 24 Dec 2024 01:49:47 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFAF880725
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 01:49:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nvbolhuis@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d3e829ff44so10435202a12.0
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 16:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735001384; x=1735606184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0QjP64FceWH7Jt5233QOfbNxtRE3NZshgOVTlXI2Fl4=;
 b=RFbRNDRClumri2OtFzpxBqNCNC79hhLYralGB7VfP3NBIS3osb5vti/ZP6toA3TAY0
 RX7wP2uXuqL6FilPLCpoS1dpKfdxDUTRInePalPd+2L2CRsyncSNawh3D7D3Q9rtuXqd
 FD3ZRND0RPHyGlpnRICtKIjovjAXXtxG1cz583Lt50rV13Q0OIpNPHGu6IX9EH39Nxij
 gybiPqCiWX/pirbQlyQQG1ImAs3Cjjf76RWT1FbZPpZrwA02PqIfLxt0dAstyHRuSAuA
 W5sINnamGWVLcX5hY+XBHbId+njE4FGbCpCRteVNiiljsB00AHtx+iq4mceLrd3U7tEo
 AWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735001384; x=1735606184;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0QjP64FceWH7Jt5233QOfbNxtRE3NZshgOVTlXI2Fl4=;
 b=YZieqBTZE55esNfmsxLzQY7Sb2LmFLuJQO93qikjA62G8/AiRMv7woim20jMBByVg3
 kY8XKa7a4we4x1xDitOjWk2H3wVzLuOXf+kJH66tpSIz+Sj2o+9Ol2lLKvefTTjB/0nf
 xlBQ3LrkHYlDriPhJzjL5yPrOX2h1Yn9HDLgKe/IdDy4kkXFY/I+vlllrP4KxaBWSnKA
 fUQcvRQKX9Wz7zaHQW4ZfOdepOPy58Jrqym9C6SrT2hKzNS7kzrmavasD8C3IPdkMDFa
 X7yN5CI/aLgDc5CCHJyUckqXFX4IOWhrebmmQxeB/UsGJkAWEGwp00Ajd8wIEwsUYj4A
 R8Vg==
X-Gm-Message-State: AOJu0YwDkQNvKPq9sMZh5H57A+MidgiZe5XJga/Ub04B8RnFiUpLTw4M
 A8Cl7gvnYs1lWKTlajDDLq+K8j/vW4naG8uP75UzNKrnE7TUwcOUnISnzg==
X-Gm-Gg: ASbGncuOQaUKNFxC7ShEhiJw3LbA/wY9jAb/GBhlOwZ5Xd9l80dBzIjZWwoqsDp+Eau
 ES6VR+/gMhZ8yXEC21B/9640V8oJIFWDs1oeizGfOdOumFrgJfumqvokaISAPJ+KiPRhQDfkvBk
 Jvjz5GpLUbkbzPBtL6FHltQkrLb+Q50AF0bKY7xt4r9LyXVx6SAdrQkM51qTmi0i76h2qt0JJbR
 uyqI1pQYYCPQsygoDUYafFtCdfSq3Hdk3JXYqAha+2exPCzvSM/xJ5lH245nJkWzoMTnmg+QNk1
 QIkbMSsPBgEfGD4pveH1
X-Google-Smtp-Source: AGHT+IHJD67sE5p+KAl6DDSI/0oiQDZ/8NRaqZaKX7Rw3SLsiT9ZT77g9p456GXHeaIBk7M7YTyQEg==
X-Received: by 2002:a17:907:2d93:b0:aa6:7c8e:808c with SMTP id
 a640c23a62f3a-aac3367569dmr1475003466b.17.1735001383716; 
 Mon, 23 Dec 2024 16:49:43 -0800 (PST)
Received: from localhost.localdomain (77-165-185-46.fixed.kpn.net.
 [77.165.185.46]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e89887csm580590166b.80.2024.12.23.16.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2024 16:49:42 -0800 (PST)
From: nvbolhuis@gmail.com
To: u-boot@lists.denx.de
Cc: Norbert van Bolhuis <nvbolhuis@gmail.com>
Subject: [PATCH] squashfs: Fix sqfs_inode_size() for xattr related
 SQFS_LSYMLINK_TYPE
Date: Tue, 24 Dec 2024 01:49:04 +0100
Message-ID: <20241224004925.468050-1-nvbolhuis@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Dec 2024 14:59:49 +0100
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

From: Norbert van Bolhuis <nvbolhuis@gmail.com>

A squashfs filesystem with extended attributes (xattrs) may have
inodes of type SQFS_LSYMLINK_TYPE. This might cause u-boot to fail to
handle the filesystem since it assumes a SYMLINK_TYPE and LSYMLINK_TYPE
inode are the same size. This is wrong, see:
https://github.com/plougher/squashfs-tools/blob/master/squashfs-tools/read_fs.c#L421

Using the mksquashfs '-no-xattrs' argument is probably best, but the
mksquashfs '-xattrs' argument is the default.
This patch fixes squashfs image handling by making sure parsing the
uncompressed inode_table (with sqfs_find_inode) succeeeds. The only change
needed is correctly determining the size of a SQFS_LSYMLINK_TYPE inode.

Signed-off-by: Norbert van Bolhuis <nvbolhuis@gmail.com>
---
 fs/squashfs/sqfs_inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/squashfs/sqfs_inode.c b/fs/squashfs/sqfs_inode.c
index bb3ccd37e3..ce9a8ff8e2 100644
--- a/fs/squashfs/sqfs_inode.c
+++ b/fs/squashfs/sqfs_inode.c
@@ -19,7 +19,9 @@
 
 int sqfs_inode_size(struct squashfs_base_inode *inode, u32 blk_size)
 {
-	switch (get_unaligned_le16(&inode->inode_type)) {
+	u16 inode_type = get_unaligned_le16(&inode->inode_type);
+
+	switch (inode_type) {
 	case SQFS_DIR_TYPE:
 		return sizeof(struct squashfs_dir_inode);
 
@@ -87,7 +89,7 @@ int sqfs_inode_size(struct squashfs_base_inode *inode, u32 blk_size)
 		    get_unaligned_le32(&symlink->symlink_size), &size))
 			return -EINVAL;
 
-		return size;
+		return (inode_type == SQFS_SYMLINK_TYPE) ? size : size + sizeof(u32);
 	}
 
 	case SQFS_BLKDEV_TYPE:
-- 
2.47.1

