Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA77C0219E
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 09:31:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 180CA80842;
	Wed, 12 Feb 2025 10:31:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="t+PYVQ/4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1631680BAA; Wed, 12 Feb 2025 10:31:11 +0100 (CET)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1093A807C0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 10:31:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.alibaba.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hsiangkao@linux.alibaba.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1739352665; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=E8WMrc8CQSyxiS+r52TioZQT/liBI0SbkCd2WU6UocE=;
 b=t+PYVQ/4Va/Y9RN3S6awcV7DLT03RekgAp2MV7kIc7yLjAFcE2XjgPUPO5oyPA57WTTAaK37e0ypCKvowjgvbMrnymUIV4wRby6SFyaiJjtUSXgM6XU0pJfIxZegqBf8lNxWZ+Nau8vXEd/0kCz+8fUFr4NgEyQNQ01uO4KUtDo=
Received: from
 x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0WPJidS-_1739352658 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 12 Feb 2025 17:31:02 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: linux-erofs@lists.ozlabs.org, Jonathan Bar Or <jonathanbaror@gmail.com>,
 Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] fs/erofs: fix an integer overflow in symlink resolution
Date: Wed, 12 Feb 2025 17:30:57 +0800
Message-ID: <20250212093057.3975104-1-hsiangkao@linux.alibaba.com>
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
 fs/erofs/fs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/erofs/fs.c b/fs/erofs/fs.c
index 7bd2e8fcfc..64a6c8cad8 100644
--- a/fs/erofs/fs.c
+++ b/fs/erofs/fs.c
@@ -63,6 +63,9 @@ static int erofs_readlink(struct erofs_inode *vi)
 	char *target;
 	int err;
 
+	if (len >= SIZE_MAX)
+		return -EFSCORRUPTED;
+
 	target = malloc(len + 1);
 	if (!target)
 		return -ENOMEM;
-- 
2.43.5

