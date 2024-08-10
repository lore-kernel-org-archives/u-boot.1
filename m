Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31A9C3DA4A
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 12:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CB5F887E8;
	Sat, 10 Aug 2024 14:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="phYkJFby";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94D9888847; Sat, 10 Aug 2024 14:57:52 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F5C68875C
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 14:57:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-428243f928cso19626765e9.3
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 05:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1723294670; x=1723899470;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pZ1eqmlaiBya62v7vhi2fDX/7qoSLSpvv/QLAmyq1v4=;
 b=phYkJFbygv7F277U7HnbpRwG2V8wwrYnKHyh5+7nQ+8bRppQWm4J7a6YOIopymbKRE
 l0uZYP6HS5/xRo2rG/UoF+hZgipzbOK41x6yy4Ur6ImlE5bnNRZJpsob68g/yVyZYDzH
 YBT+Prh5FNswkiKjvAYI33EcAIvfvPJCi5xPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723294670; x=1723899470;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pZ1eqmlaiBya62v7vhi2fDX/7qoSLSpvv/QLAmyq1v4=;
 b=dltifGYWFxQKHfqMrHTQLyTNujvDzIloTo5w5pjoUauZMmOLdf0HyESETnYmkvGykh
 v+Sjusfi5i3D8NctjMzRppLMGHS3ApanDwYuFP2BrcS80S+dcXJ3bmr9gef+Rf+tTgZD
 RH+Mpcnt9HFXg2JM0cLvmm+yfk1LLEH2jtBhC2K5rRqtE8+eYwbvCgeqE0P/nu4M5efm
 B9Kaf/Sjb3TVVffHoewJZJ5q8B2zPf4OdS877HJmtxZthKjYZd5uplp4jUwSWTgJ72G5
 ANP7GDtOXN9NmcYBxrstHz1Ciq9GBHxW9rJWTzbNYFT4wYbFcE6L2cE6vuHbsNn2UPWM
 TV7A==
X-Gm-Message-State: AOJu0YzrB6oFbGSpZUALkXUx6MGYECplBDpUaVktdGiw8xcnB04vrHvM
 K23Rfu4q/QDQJVUjtTm7gcMH/hCwSwF2Ws+Qf9FpyhsyK8lI+lKyYpiwZ9sAQhg=
X-Google-Smtp-Source: AGHT+IEba6ZvPHugv+vv5IsVWQBqnU5vbZEbhABCuV15CnqxxXqvwDqz1DPCOTR7xofBN7XiBGp8KA==
X-Received: by 2002:a05:600c:a41:b0:428:d83:eb6b with SMTP id
 5b1f17b1804b1-429c3a1a133mr37730175e9.15.1723294669498; 
 Sat, 10 Aug 2024 05:57:49 -0700 (PDT)
Received: from panicking.amarulasolutions.com ([109.53.83.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c93708asm2270877f8f.29.2024.08.10.05.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 05:57:48 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Heiko Schocher <hs@denx.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Alexander Dahl <ada@thorsis.com>
Subject: [PATCH V2] ubifs: Call ubifs_iput when ubifs_iget is used
Date: Sat, 10 Aug 2024 14:57:44 +0200
Message-ID: <20240810125745.1793642-1-michael@amarulasolutions.com>
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
V1->V2:
	- fix compilation problem on super.c
RFC->V1:
	- Heiko gives more points to address on the patch and review it
	- Alexander Dahl test on top of his own series reported in the
	  commit message
	- add leak on super.c file too from Heiko
---
 fs/ubifs/super.c | 1 +
 fs/ubifs/ubifs.c | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index d8d78a2d3d..7eb2f764a2 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2321,6 +2321,7 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
 		goto out_umount;
 	}
 #else
+	ubifs_iput(root);
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

