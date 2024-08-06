Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094BCC49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3056488A85;
	Tue,  6 Aug 2024 14:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HC3oh98Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6187688A7B; Tue,  6 Aug 2024 14:59:44 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE05D88A28
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-39b3754468eso1964255ab.2
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949174; x=1723553974; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kx1/WQXJunFXxjE4QfYrutj0xGpEqKwfA9DEAUPEqHw=;
 b=HC3oh98ZTVKVNhIZCGWlWqPhViR0gh9Q2qofowJlkYt6UpJdWKBNDzuCqmC6VMqGne
 uAxOZNkn8FaDY9dVdMp9XwmCwRCuaMO2m5iIT7+DuLYhI0XdoJ/5dIHH0EH9vs4oYEy4
 xCb/6R1TaRAVy7/tv8AZ7prVBVy/MqNZvKvKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949174; x=1723553974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kx1/WQXJunFXxjE4QfYrutj0xGpEqKwfA9DEAUPEqHw=;
 b=qTa9g/B0My48IQb/GRBAMKnQeoToLxeV+FAEEc1FoNWT+S6mRrkjmGu7rn4HkSDVsO
 bSESwfNfx0SCT8wmck94DoMyMaErIYuoQMJk7WIzvSyVTxESIO0p6XaZUO55+HsYnIPB
 rOH6QKvBSyIiTieFFAD+rLkMY5e+mpnxuijd8W6/Zs6E+c6lIRv4L+YV5GQ/MpElZR5j
 WWa6xItcyQ6JcV9GzR0CMWA6hfDNdzlwpI0+ao/t7nR/4HDn/Gvnx1ImINQHXHJP5t9l
 tQ4/0dY5aPXJ5bhT8qnx5yCjMnl9xDomrTaX8OnuO9NIhpUvO+oN5/KE8KjIQNaAz7zP
 Ukmg==
X-Gm-Message-State: AOJu0YxOj3VZEsvPlgRdMtynY7TvnDk8Qpyi76RkZjR9vR/3iY2Ns6a3
 7bz/HQAEK9dkSh0wn9nuED1HsrJB/NMJcZnvrRhCagICJNoUDNitGw5V0kjw3cXJh1mOpc/teqo
 =
X-Google-Smtp-Source: AGHT+IE21yDAMsWzDIS/QWQzE3Lj1bDJ1/pGtLmF2YJVTkVbjNJTugWpqAbzm2HDl/904/8wYVhShg==
X-Received: by 2002:a92:c70b:0:b0:39b:320e:f805 with SMTP id
 e9e14a558f8ab-39b320ef91cmr104419185ab.18.1722949174309; 
 Tue, 06 Aug 2024 05:59:34 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 18/39] mmc: Use map_sysmem() with buffers in the mmc command
Date: Tue,  6 Aug 2024 06:58:29 -0600
Message-Id: <20240806125850.2316956-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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

