Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC34C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 16:46:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 346EA82BB4;
	Wed, 30 Apr 2025 18:46:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1746031581;
	bh=yXfLKbDrqz0OnCmdoV1Df7wq3C5fQJodwn2nxHEJMBo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=w3bKZ1N+xEDScSby7Aletj8Ddjl24PuVFGc9JwJqzmqF15G+FOorB3F4sdOtWWa3T
	 ZvJHujfXw5VnbJ392nHcfafa62MSysOiUzXyEKS3qsiWv10H6so9/sxZb7wFAjhqjA
	 ZVG65pgZNAexKRdVnXgbKiWfFWBP5MwH72qbuYMVosCtJDnYXL2xvyDdGw9UDT/AXG
	 8tVC3C2n+969y2TiLSgKY2OE11nEqyARAFLr47Hjf7uCxyPYEHvj09WcSHf3392ama
	 Nzym5A1XBAWXJSu4TpUMhnOqBqMWVNsE1fXkhug7kFdiFFENXzjSxYAW20Zyd1/daX
	 1Sw6OxcLeduqw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1B7382BF6; Wed, 30 Apr 2025 18:46:20 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA8028215E
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="LAob0bkz"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 723BA1026CEB3; 
 Wed, 30 Apr 2025 18:46:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1746031578; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=yXfLKbDrqz0OnCmdoV1Df7wq3C5fQJodwn2nxHEJMBo=;
 b=LAob0bkzzAhNphIwWxpz98ZLBM6bMS+23QRdCxWxcMlTTqk6WDNN/UKZuMlJtKAAn9RPO3
 E/6Bt9HalF/+EmEUSnm6Np3TpwF1/PDCYAbV4vxkNtLVB9s68UC2Ebk4uEEmfKjZD4o/ML
 2uSFIYN9Ni+KaVPRjYmrJmmReeEiYn5iYlRc9r1kX9ensbLRoBySRh2tbrXrkn6p5MsdA3
 KO19iQ/5qbJ4+oF0MKDN+tf6XCUV1DeAhXwwE2EGQKIHFzEEsaBz6H+j2ckFeeajwBnas2
 6n/MQvZFSLu3CJz3Roah+VPOMfGMox6jzvLILtMjSKwwV4TwrtX2RhJSj2CSbg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] fs: exfat: Use strncpy() and bail on too long filenames
Date: Wed, 30 Apr 2025 18:45:51 +0200
Message-ID: <20250430164559.27095-1-marex@denx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

In case the filename is too long, longer than PATH_MAX - 1, it
would overflow dirs->dirname array. Add missing check and also
use strncpy() to prevent the overflow in any case.

Fixes CID 550305:  Security best practices violations  (STRING_OVERFLOW)

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 fs/exfat/io.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/io.c b/fs/exfat/io.c
index c56f5675987..77cd2dfb6dc 100644
--- a/fs/exfat/io.c
+++ b/fs/exfat/io.c
@@ -720,6 +720,9 @@ int exfat_fs_opendir(const char *filename, struct fs_dir_stream **dirsp)
 	struct exfat_node *dnode;
 	int err;
 
+	if (strlen(filename) >= PATH_MAX)
+		return -ENAMETOOLONG;
+
 	err = exfat_lookup_realpath(&ctxt.ef, &dnode, filename);
 	if (err)
 		return err;
@@ -736,7 +739,7 @@ int exfat_fs_opendir(const char *filename, struct fs_dir_stream **dirsp)
 	if (!dirs)
 		return -ENOMEM;
 
-	strcpy(dirs->dirname, filename);
+	strncpy(dirs->dirname, filename, PATH_MAX - 1);
 	dirs->offset = -1;
 
 	*dirsp = &dirs->fs_dirs;
-- 
2.47.2

