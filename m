Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2D0C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:29:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7861E88BC7;
	Thu, 15 Aug 2024 22:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IP6mDgy/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2480888B5A; Thu, 15 Aug 2024 22:26:04 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38FB288B96
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-81f94ce2272so59028239f.2
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753556; x=1724358356; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kx1/WQXJunFXxjE4QfYrutj0xGpEqKwfA9DEAUPEqHw=;
 b=IP6mDgy/mGXp6YxUt+kOJy5pRmEbFZliqdSxEJBU19P4e0lGpc0/u23wEL+FG/sMDi
 OwZTMdDaaeHd6S78t9ErsctGZYBQKkYxTpxNgkuGcvp82BSvHLJqNPjh5KDLYH2wXfqB
 l/GQE1usmoundwJuAtfc91WM+59DUCp6ZLgqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753556; x=1724358356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kx1/WQXJunFXxjE4QfYrutj0xGpEqKwfA9DEAUPEqHw=;
 b=KkdB461QDH8vZcu5WkIIbp8J7Ec7ou9/KpoWqEC18U6Yq5iHbd2klpKE4571+pi8xU
 ySDvrYgzn6POp18QOqXj+Y/qMEbtjNpXRmCw5gya7W62CAv4UvCBHOsnzwMFzq6HaQ+J
 zSYMD4OBRJwi/NoOjUJ7F5YAeBHhZNDgu+LkADRjEZnM7VkbgquBRi/zJXcxGJ6ri3SN
 QRHk2EKr6UyP0G5QCI4SD7KKUGsuieJoD/QiIqb9yjbVCup8qfQHTcRGkV3/LV4ai5eg
 HYhJxQGc2132FX7uyqc3bBFQuBZVcO9EpMKjZ0gHDT1zsCLYj0Sbq3rxQxxcxmOEZZ+D
 Il4g==
X-Gm-Message-State: AOJu0Yy8HPeB8RGdG0ro4hbLNyBfXXakWNNTnZ4LJo73xVpkSpQcZeYu
 Kc44r338/8uzEKNfpA9kOdFGGSudve6llliaXTjV9SnGAiZmB69WXpNpJyJ9G9ClKf1M0RQUN4e
 2iw==
X-Google-Smtp-Source: AGHT+IEI9+EleHsUqNt4iOuQQV+r+voM1lCX4TEstRJUOwJqNOMqqdlAC6oYM0koi6sKzZi1oRNW0A==
X-Received: by 2002:a05:6e02:1fc6:b0:39d:2524:ecc7 with SMTP id
 e9e14a558f8ab-39d26d6dc1fmr9221105ab.23.1723753556458; 
 Thu, 15 Aug 2024 13:25:56 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ed5db5bsm8014235ab.64.2024.08.15.13.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:25:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 18/24] mmc: Use map_sysmem() with buffers in the mmc command
Date: Thu, 15 Aug 2024 14:25:29 -0600
Message-Id: <20240815202535.767869-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815202535.767869-1-sjg@chromium.org>
References: <20240815202535.767869-1-sjg@chromium.org>
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
index 7244a90f4dc..ff7ca3b371e 100644
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
 	printf("\nMMC read: dev # %d, block # %d, count %d ... ",
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

