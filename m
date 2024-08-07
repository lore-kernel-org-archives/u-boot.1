Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48907C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 15:42:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79F288883D;
	Wed,  7 Aug 2024 17:42:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nY2myEfm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B42E688BFA; Wed,  7 Aug 2024 17:42:17 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 651F9886E2
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 17:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-368313809a4so652376f8f.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 08:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1723045335; x=1723650135;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XWVHr3cU02XGS8NAJ72d6SkFPnZM0SxHjP1Ytfc7gq8=;
 b=nY2myEfmA74KiuDldcw3b53dyyMqUTiPMHkPNXEv8YszzhFZ1SGQz1sHRuySzxyUty
 CWx76SdPAn7ggQU/8TIqwlOzf8tXfcXvCFLxXjtDGEUlPwTVv9acA7aOwvPDQ4fQ3U7d
 PNJVMfpMqxBm//YOSX9uO+QK+3oc9/l9Optac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723045335; x=1723650135;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XWVHr3cU02XGS8NAJ72d6SkFPnZM0SxHjP1Ytfc7gq8=;
 b=QzxX30nfMfLwmrUVeIVqHMI5HFLEJmunARIDw7pD0bKHeouYgTFctPjVq1x/bkGgLD
 k5WLPqeRdfQNPFvmzlEQYCplF99hKaeVhwa3RLtON5cACJDx7dDQ7HmRUBfxFAFJV+QW
 OkMTvXlP9D5LpD9ivEd7VNJz+lt5XvbpRvhDuzFEVO2QBwnu590FgwqbIrlOelnADuga
 C3poeXN5TKvLBkUeIwSmYFP59khv9qOp7KylR24ajs460SAy7xcvsrsqg4ihUqEDsF3O
 Yvjst4d0RRnwEBvQXD4ijV6obYl1IjCPN+YQpgCq6zOJjTYgAtexsdNih6jHhwFgQVrB
 WXIg==
X-Gm-Message-State: AOJu0YwBRKoLphoGK7RUm0JbyuDXx/To6JC2antnmLH1F66ot7BT//58
 I39McpZ/gtNKBQKEFb8PwamIqhZuEv0wvusx+Jdfl2El6FytTFxXM4aSF9nofk0=
X-Google-Smtp-Source: AGHT+IGr+aUvC9WD5NmJEBKLiLZVOKYfwXQavXAgevmPmp810W86weXqZmQ3srXnXfhrRwozb2NuhA==
X-Received: by 2002:a5d:4901:0:b0:367:40eb:a3c3 with SMTP id
 ffacd0b85a97d-36bf0f2839cmr1870350f8f.34.1723045334651; 
 Wed, 07 Aug 2024 08:42:14 -0700 (PDT)
Received: from panicking.amarulasolutions.com ([109.53.83.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0cc63sm16432748f8f.5.2024.08.07.08.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 08:42:14 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Heiko Schocher <hs@denx.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Alexander Dahl <ada@thorsis.com>
Subject: [PATCH] ubifs: Call ubifs_iput when ubifs_iget is used
Date: Wed,  7 Aug 2024 17:42:10 +0200
Message-ID: <20240807154210.1224130-1-michael@amarulasolutions.com>
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

The inode should be freed after a reference is get to avoid
memory leak

Tested-by: Alexander Dahl <ada@thorsis.com>
Link: https://lore.kernel.org/u-boot/b698ec3e-d857-6512-8cc9-4edcab0a41b9@denx.de/T/#t
Link: https://lore.kernel.org/all/8f3a7059-6330-f332-8e9f-729b853e001e@denx.de/T/
Co-Developed-by: Heiko Schocher <hs@denx.de>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
RFC=>V1:
	- Heiko gives more points to address on the patch and review it
	- Alexander Dahl test on top of his own series reported in the
	  commit message
	- add leak on super.c file too from Heiko
---
 fs/ubifs/super.c | 1 +
 fs/ubifs/ubifs.c | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index d8d78a2d3d..7721e168fb 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2321,6 +2321,7 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
 		goto out_umount;
 	}
 #else
+	ubifs_iput(inode);
 	sb->s_root = NULL;
 #endif
 
diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
index 048730db7f..6acd6c3776 100644
--- a/fs/ubifs/ubifs.c
+++ b/fs/ubifs/ubifs.c
@@ -319,9 +319,7 @@ static int filldir(struct ubifs_info *c, const char *name, int namlen,
 	}
 	ctime_r((time_t *)&inode->i_mtime, filetime);
 	printf("%9lld  %24.24s  ", inode->i_size, filetime);
-#ifndef __UBOOT__
 	ubifs_iput(inode);
-#endif
 
 	printf("%s\n", name);
 
@@ -557,6 +555,7 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
 
 			/* We have some sort of symlink recursion, bail out */
 			if (symlink_count++ > 8) {
+				ubifs_iput(inode);
 				printf("Symlink recursion, aborting\n");
 				return 0;
 			}
@@ -568,6 +567,7 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
 				 * the leading slash */
 				next = name = link_name + 1;
 				root_inum = 1;
+				ubifs_iput(inode);
 				continue;
 			}
 			/* Relative to cur dir */
@@ -575,6 +575,7 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
 					link_name, next == NULL ? "" : next);
 			memcpy(symlinkpath, buf, sizeof(buf));
 			next = name = symlinkpath;
+			ubifs_iput(inode);
 			continue;
 		}
 
@@ -583,8 +584,10 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
 		 */
 
 		/* Found the node!  */
-		if (!next || *next == '\0')
+		if (!next || *next == '\0') {
+			ubifs_iput(inode);
 			return inum;
+		}
 
 		root_inum = inum;
 		name = next;
-- 
2.43.0

