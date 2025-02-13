Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA515C021A4
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 11:29:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02A3B80C77;
	Thu, 13 Feb 2025 12:29:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KkN8CNDf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EC2980C7E; Thu, 13 Feb 2025 12:29:03 +0100 (CET)
Received: from out30-124.freemail.mail.aliyun.com
 (out30-124.freemail.mail.aliyun.com [115.124.30.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32E8A80A55
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 12:28:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.alibaba.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hsiangkao@linux.alibaba.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1739446136; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=kv8BMoJpbxc9jojR7+5+zseML6qOiINst/GRSJcHC18=;
 b=KkN8CNDfoXl+0h5E9krDEhRv4sKGT/PcXLGB/3FzY5JnOjaBAo5d555kTjvOFgurCTRm0GSHxypPkcxUcoWjhg2YZmNLixrH0yrNbpSY2aw5veBqLEWDsZYZjZ3h8zICRXxl19wEEWhPFzs0mUsZg7Lh/z+KhcQ93lr+sTrsVRw=
Received: from
 x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0WPNMGBb_1739446129 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 13 Feb 2025 19:28:53 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: linux-erofs@lists.ozlabs.org, Jonathan Bar Or <jonathanbaror@gmail.com>,
 Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2] fs/erofs: fix an integer overflow in symlink resolution
Date: Thu, 13 Feb 2025 19:28:47 +0800
Message-ID: <20250213112847.1848317-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

See the original report [1], otherwise len + 1 will be overflowed.

Note that EROFS archive can record arbitary symlink sizes in principle,
so we don't assume a short number like 4096.

[1] https://lore.kernel.org/r/20250210164151.GN1233568@bill-the-cat
Fixes: 830613f8f5bb ("fs/erofs: add erofs filesystem support")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2:
 - use __builtin_add_overflow as Jonathan suggested.

 fs/erofs/fs.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/fs.c b/fs/erofs/fs.c
index 7bd2e8fcfc..dcdc883e34 100644
--- a/fs/erofs/fs.c
+++ b/fs/erofs/fs.c
@@ -59,16 +59,19 @@ struct erofs_dir_stream {
 
 static int erofs_readlink(struct erofs_inode *vi)
 {
-	size_t len = vi->i_size;
+	size_t alloc_size;
 	char *target;
 	int err;
 
-	target = malloc(len + 1);
+	if (__builtin_add_overflow(vi->i_size, 1, &alloc_size))
+		return -EFSCORRUPTED;
+
+	target = malloc(alloc_size);
 	if (!target)
 		return -ENOMEM;
-	target[len] = '\0';
+	target[vi->i_size] = '\0';
 
-	err = erofs_pread(vi, target, len, 0);
+	err = erofs_pread(vi, target, vi->i_size, 0);
 	if (err)
 		goto err_out;
 
-- 
2.43.5

