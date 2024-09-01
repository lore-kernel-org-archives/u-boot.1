Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6422DCA101E
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:29:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A435088C75;
	Mon,  2 Sep 2024 00:27:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f9eVhV5P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1584588C61; Mon,  2 Sep 2024 00:27:11 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F24848690D
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-82a274dd17eso111700239f.1
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229627; x=1725834427; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D2ejuTar1cAx6biF/I6FLO/wUmQVNzLhvafQ+vxl1h8=;
 b=f9eVhV5P8W24j89HZEAQDJKqwCP/9VqwXTMONB1IPN+oD3bNdfppSqiWtnh4uRc+1T
 JYjYFWThJVPMLaJ6d30LDwycf+gpLawkMc8Yrb+Gl2BoEywjPHuTTIcjmeNtKHyBba6r
 oa7VBXoWa+dLYHVwNcqWh51OIR6yrhjR7cdw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229627; x=1725834427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D2ejuTar1cAx6biF/I6FLO/wUmQVNzLhvafQ+vxl1h8=;
 b=WHmJP9Hy/XWFsTlrGNW11uJseYR5hXgmA1IKYOG2jvg9BvtcigHDkcE0lg3fhALYUQ
 bndAXgx805v7eQH2OlDWcnm4pfg7YJ+2uT/yl10XuBgb2j7SDM+tN7P/IzeVqsFK2xmZ
 VDaQmnIiFpykGdus7tq1FzXP4gnzQsgrn3DKO9xmeuf2OjzKL0mk+28Xx4mQ/bbhkjyo
 nePqgIotnir1vMZHizUKE2Ae4SVHKzxvpBRA1SYiMXu1j9sRjXuf5cNpE/Bzr9Qzdtmt
 ZtSz+b1ASJu+Xxx9B/L7kMPpn+mEJ3wcGgiXY6UohjRVcQDK1V4XDAXpKC2aQHdr2Vw6
 8gKQ==
X-Gm-Message-State: AOJu0Yyh56b6Ce8NdOxboW4V1iHbRYUPhJNNt3LEGfShRY3j9zehE1K5
 K/YKNOioR0+XYGwd2xF+UQQ0qhJC4WeT2XS/7dt59Qck3tyqhl1sBTgS4UneFoEktO+mgvmAkCQ
 =
X-Google-Smtp-Source: AGHT+IG1wyMfGT/3iXuAZJ0ls+CCPv768oekSZFp9fMLS7RrCEDY7tsPJ9uo3L6a9ZMVhNImavlCpg==
X-Received: by 2002:a05:6602:1513:b0:82a:3851:b687 with SMTP id
 ca18e2360f4ac-82a3851b7c8mr526772339f.16.1725229627435; 
 Sun, 01 Sep 2024 15:27:07 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a4c099asm215751839f.48.2024.09.01.15.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:27:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v4 17/23] mmc: Use map_sysmem() with buffers in the mmc command
Date: Sun,  1 Sep 2024 16:26:28 -0600
Message-Id: <20240901222634.460873-18-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901222634.460873-1-sjg@chromium.org>
References: <20240901222634.460873-1-sjg@chromium.org>
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

The current implementation casts an address to a pointer. Make it more
sandbox-friendly by using map_sysmem().

Rename the variable to 'ptr' since it is a pointer, not an address.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/mmc.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/cmd/mmc.c b/cmd/mmc.c
index ff7b8e555ba..8aa7b7d906b 100644
--- a/cmd/mmc.c
+++ b/cmd/mmc.c
@@ -8,6 +8,7 @@
 #include <command.h>
 #include <console.h>
 #include <display_options.h>
+#include <mapmem.h>
 #include <memalign.h>
 #include <mmc.h>
 #include <part.h>
@@ -349,12 +350,12 @@ static int do_mmc_read(struct cmd_tbl *cmdtp, int flag,
 {
 	struct mmc *mmc;
 	u32 blk, cnt, n;
-	void *addr;
+	void *ptr;
 
 	if (argc != 4)
 		return CMD_RET_USAGE;
 
-	addr = (void *)hextoul(argv[1], NULL);
+	ptr = map_sysmem(hextoul(argv[1], NULL), 0);
 	blk = hextoul(argv[2], NULL);
 	cnt = hextoul(argv[3], NULL);
 
@@ -365,8 +366,9 @@ static int do_mmc_read(struct cmd_tbl *cmdtp, int flag,
 	printf("MMC read: dev # %d, block # %d, count %d ... ",
 	       curr_device, blk, cnt);
 
-	n = blk_dread(mmc_get_blk_desc(mmc), blk, cnt, addr);
+	n = blk_dread(mmc_get_blk_desc(mmc), blk, cnt, ptr);
 	printf("%d blocks read: %s\n", n, (n == cnt) ? "OK" : "ERROR");
+	unmap_sysmem(ptr);
 
 	return (n == cnt) ? CMD_RET_SUCCESS : CMD_RET_FAILURE;
 }
@@ -442,12 +444,12 @@ static int do_mmc_write(struct cmd_tbl *cmdtp, int flag,
 {
 	struct mmc *mmc;
 	u32 blk, cnt, n;
-	void *addr;
+	void *ptr;
 
 	if (argc != 4)
 		return CMD_RET_USAGE;
 
-	addr = (void *)hextoul(argv[1], NULL);
+	ptr = map_sysmem(hextoul(argv[1], NULL), 0);
 	blk = hextoul(argv[2], NULL);
 	cnt = hextoul(argv[3], NULL);
 
@@ -462,8 +464,9 @@ static int do_mmc_write(struct cmd_tbl *cmdtp, int flag,
 		printf("Error: card is write protected!\n");
 		return CMD_RET_FAILURE;
 	}
-	n = blk_dwrite(mmc_get_blk_desc(mmc), blk, cnt, addr);
+	n = blk_dwrite(mmc_get_blk_desc(mmc), blk, cnt, ptr);
 	printf("%d blocks written: %s\n", n, (n == cnt) ? "OK" : "ERROR");
+	unmap_sysmem(ptr);
 
 	return (n == cnt) ? CMD_RET_SUCCESS : CMD_RET_FAILURE;
 }
-- 
2.34.1

