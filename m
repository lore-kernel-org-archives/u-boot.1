Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74062C3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 17:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EC168862E;
	Mon,  5 Aug 2024 19:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Jh6gFJU5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D1BA888E0; Mon,  5 Aug 2024 19:31:47 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F5D984374
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 19:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4280c55e488so28135e9.0
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 10:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1722879104; x=1723483904;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ktgXlDlEjCcUyhaDHt8nNhOUApOeRteEGHLaZCR3Xeg=;
 b=Jh6gFJU5l1ceQ+qZxm53WawQBhGla/Ucc0GxTV5vPPDK9nj0xXaN2gbGfX4V64hvsD
 tulV0mQtlU9PjcKvmVOuowD4lbL4aiM2QNMtHuTl1p1vOotTF+CMWYyzCH6I4c+3gkQ2
 FI8B+p1rkPLltXqvaFMQjn+H5R/egmNY9f0Tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722879104; x=1723483904;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ktgXlDlEjCcUyhaDHt8nNhOUApOeRteEGHLaZCR3Xeg=;
 b=UWZ697xRpC33ZWeuNl2YAACZSjvPMjvP85jAmtLBi6pE/31CLXpBlfKsfBvfExoSIS
 QTrPLF8nRIOA9QhgO70TLAuKQalImUD5HR6rcaZCIJXAxAVvKNmnaR7C+/m3TyG9HMaY
 cfkb5pgEci5q1Ip5O+PIJY6sSX7Sq229KWyao5iHNQsiWfEdJuZf8VzeLlVsClBD5T9/
 mnhnT86/voYBUku207iciUCPmLvHhpZtoFSPLGe3N6eozZKMYhqCRgdeyavuXdP8Z1mL
 aMfwhWw0hhHKoxjmkO2cNWnnEjIVHLOvUOpbF4flsRy4BUsoLWhdw67FbhAXarcBKAd8
 vq5Q==
X-Gm-Message-State: AOJu0YywkjxhdmXg4Yl56JjJagBu+Rby28rNr7ijrZpvG2lwWRXkTl4k
 MT4NQ+WBY8V7euCH5s/I0oPi4LNjY+7YpTQEnjWAGipMQc3GayQiSPA1tvitGi0=
X-Google-Smtp-Source: AGHT+IFo0Ykgp800gylOfXZ05FOmCmjODwmNr7XlZ268mYx8ISdnMwiXbJkdpi1rYJyVke/oiVMrrQ==
X-Received: by 2002:a05:600c:1385:b0:426:676a:c4d1 with SMTP id
 5b1f17b1804b1-428e699a8dbmr105214105e9.8.1722879104419; 
 Mon, 05 Aug 2024 10:31:44 -0700 (PDT)
Received: from panicking.amarulasolutions.com ([109.53.83.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6dfbc3bsm148388595e9.11.2024.08.05.10.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 10:31:44 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Heiko Schocher <hs@denx.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [RFC PATCH] ubifs: Call ubifs_iput when ubifs_iget is used
Date: Mon,  5 Aug 2024 19:31:40 +0200
Message-ID: <20240805173140.84453-1-michael@amarulasolutions.com>
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

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 fs/ubifs/ubifs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

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

