Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3D9C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A9D4889E2;
	Sun, 11 Aug 2024 16:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hBRS95vy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F303F88A13; Sun, 11 Aug 2024 16:52:48 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB553889E3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-39b4eadbaa7so11836835ab.2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387965; x=1723992765; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kx1/WQXJunFXxjE4QfYrutj0xGpEqKwfA9DEAUPEqHw=;
 b=hBRS95vyVhTuX3SXiQKvxjjtkvVj4m79GZQ7gJY+09vriKsmBreHYy1HTM+aD9TdC7
 dL4lwLc1quBwq9p/gV4xxGBFOAyIsW8nPb7ZI7GGvs/LNFqgRv4L6VkYEWfhKoBSaM3s
 JJRXhflaUdfwef7h54miVsCvW0Qd9vhWEHbUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387965; x=1723992765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kx1/WQXJunFXxjE4QfYrutj0xGpEqKwfA9DEAUPEqHw=;
 b=gqSONjqDa5i0gHDQtkley26zpcEZdk4VEHthb4bvKCMOVViHNRSpUdXZ2WRG6pfaW8
 XY+oAOuXJ3oRvTZIZqBT4LtrtyzfE7gf1MHpUqfd3NJTVjjl0rGL2AIhMN4gnvXeEgJ3
 6Vw58E5EDmKRSrxK3DTAE8n9B2CXRzIvnPurmCEg4Aw90PStNnevEO61Lj8yM93OnKKv
 6drH3pxtrh4100kvFQVhjq8gK0SVTPqFWio7s9+H4rnCJm9UoyBd7ulBw8gGV+HJodJy
 WCQ8zEozHiNu/DSdgtFivKH7mYQ4IAjxfymcGb7r4WxPg3m1v7iTPdOTuprunHuVBQWf
 dcFw==
X-Gm-Message-State: AOJu0Ywk/W3dLvCajmb+Hn5hMZczEAjjQY5ms4+jMbgAsX6dsuDKBspo
 T6Gi0kRPQ842EXL5KEe2R7V0jyLMYXZTHcp/fJiBZ24yeS3nnqqOOeQaj72OxNgSydNcBcymjkE
 =
X-Google-Smtp-Source: AGHT+IFrYT5e2nR1kgcsI1ZTmsvnoaqi0gz+GVh8nszM/LtQdjXZeYoCMz8w6fTUMoWN8gw6QP1DNA==
X-Received: by 2002:a05:6e02:160f:b0:380:f340:ad66 with SMTP id
 e9e14a558f8ab-39b7a46a4acmr103718815ab.26.1723387965477; 
 Sun, 11 Aug 2024 07:52:45 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 18/40] mmc: Use map_sysmem() with buffers in the mmc command
Date: Sun, 11 Aug 2024 08:51:47 -0600
Message-Id: <20240811145209.4191404-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

