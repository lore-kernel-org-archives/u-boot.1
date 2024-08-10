Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890AEC3DA7F
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 20:52:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DB578891E;
	Sat, 10 Aug 2024 22:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y3HlAJc8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86AAA88914; Sat, 10 Aug 2024 22:52:34 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97410888C2
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 22:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-81f9339e534so110154139f.3
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 13:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723323146; x=1723927946; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VM4IfJjVdzGsAoOd7J03TO5hZsSt8+a1MfHxZDs/Iik=;
 b=Y3HlAJc85+cxWnti1JGS+n068bR0suAsfG4oaHg7fCn1PERObC59qMxvMtYAtqadD3
 f97ehhAnfuhaWKa9G2HDZefAMu+/tcl+Gv5VZF5i3z9NdgjpBPXNZAc1/QapNcxBMFqh
 YjS1n+Vp+MmRXxF7Xdd3WiClF193pMZEnIPJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723323146; x=1723927946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VM4IfJjVdzGsAoOd7J03TO5hZsSt8+a1MfHxZDs/Iik=;
 b=q+JGk947MchyEVV4SnJF6s9a2c4O5JfEdxeKLdgcClBHDjks1Su3NWdmMc0Rn5ICzX
 IORw6ezjR9CN72Ba8pdVy1TasOpJcIA8mVAaQXfqj9Mu8hxFltTNo9jkm2fPtoYvUOde
 1J6G++Y8XsNHWgyalrMXDD4+bVVwTn9RcZWWT7YeCh4fzVQMWCpx9YNPbUXbiCSsVfcR
 FpkGljcfb3VT7pBhjFL5nYNJki3o/mqSfCV/4PySwa+7LLmNxRjC1FgrPo9zgNDBUfWG
 W3ERp70MEP+l39PFkHYPDn/nRvaK2b1UmjqbJEyBYjcBAG/UavDIiky7n8xFk5VWsCvy
 8m5Q==
X-Gm-Message-State: AOJu0Yy2mL4bUK/UmHocV1yZRK0Gl9ZvTlQI5wjJKOg4flRgfPbkDBcz
 Q6cKrq0cRaZJxoht+Cji0NMi8EvT+vqnC5/1ei36QfkVBHKN7C37FYHZyn65XIVoBTjM+q/NzPA
 =
X-Google-Smtp-Source: AGHT+IE6ZcfenyME9N2vgSnq2sSUPt2OoN13BkzStBGB94R33fjI9tw4OdXAKuPXDcxfrgTj6fbFGA==
X-Received: by 2002:a05:6602:3fc3:b0:81f:880d:ec18 with SMTP id
 ca18e2360f4ac-8225ee694fdmr735229739f.3.1723323146190; 
 Sat, 10 Aug 2024 13:52:26 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82266f56333sm82893139f.0.2024.08.10.13.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 13:52:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Fabio Estevam <festevam@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 06/21] mmc: Drop the blank line before accesses
Date: Sat, 10 Aug 2024 14:51:50 -0600
Message-Id: <20240810205205.3403177-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810205205.3403177-1-sjg@chromium.org>
References: <20240810205205.3403177-1-sjg@chromium.org>
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

Several mmc subcommand print a blank line before starting and after
finishing. It isn't necessary to do both, so drop the first one.

It is questionable whether these command should produce any output at
all, but leave it for now.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/mmc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/cmd/mmc.c b/cmd/mmc.c
index 7244a90f4dc..ff7b8e555ba 100644
--- a/cmd/mmc.c
+++ b/cmd/mmc.c
@@ -238,7 +238,7 @@ static int do_mmcrpmb_read(struct cmd_tbl *cmdtp, int flag,
 	if (argc == 5)
 		key_addr = (void *)hextoul(argv[4], NULL);
 
-	printf("\nMMC RPMB read: dev # %d, block # %d, count %d ... ",
+	printf("MMC RPMB read: dev # %d, block # %d, count %d ... ",
 	       curr_device, blk, cnt);
 	n =  mmc_rpmb_read(mmc, addr, blk, cnt, key_addr);
 
@@ -265,7 +265,7 @@ static int do_mmcrpmb_write(struct cmd_tbl *cmdtp, int flag,
 	cnt = hextoul(argv[3], NULL);
 	key_addr = (void *)hextoul(argv[4], NULL);
 
-	printf("\nMMC RPMB write: dev # %d, block # %d, count %d ... ",
+	printf("MMC RPMB write: dev # %d, block # %d, count %d ... ",
 	       curr_device, blk, cnt);
 	n =  mmc_rpmb_write(mmc, addr, blk, cnt, key_addr);
 
@@ -362,7 +362,7 @@ static int do_mmc_read(struct cmd_tbl *cmdtp, int flag,
 	if (!mmc)
 		return CMD_RET_FAILURE;
 
-	printf("\nMMC read: dev # %d, block # %d, count %d ... ",
+	printf("MMC read: dev # %d, block # %d, count %d ... ",
 	       curr_device, blk, cnt);
 
 	n = blk_dread(mmc_get_blk_desc(mmc), blk, cnt, addr);
@@ -411,7 +411,7 @@ static int do_mmc_sparse_write(struct cmd_tbl *cmdtp, int flag,
 	if (!mmc)
 		return CMD_RET_FAILURE;
 
-	printf("\nMMC Sparse write: dev # %d, block # %d ... ",
+	printf("MMC Sparse write: dev # %d, block # %d ... ",
 	       curr_device, blk);
 
 	if (mmc_getwp(mmc) == 1) {
@@ -455,7 +455,7 @@ static int do_mmc_write(struct cmd_tbl *cmdtp, int flag,
 	if (!mmc)
 		return CMD_RET_FAILURE;
 
-	printf("\nMMC write: dev # %d, block # %d, count %d ... ",
+	printf("MMC write: dev # %d, block # %d, count %d ... ",
 	       curr_device, blk, cnt);
 
 	if (mmc_getwp(mmc) == 1) {
@@ -484,7 +484,7 @@ static int do_mmc_erase(struct cmd_tbl *cmdtp, int flag,
 	if (!mmc)
 		return CMD_RET_FAILURE;
 
-	printf("\nMMC erase: dev # %d, block # %d, count %d ... ",
+	printf("MMC erase: dev # %d, block # %d, count %d ... ",
 	       curr_device, blk, cnt);
 
 	if (mmc_getwp(mmc) == 1) {
-- 
2.34.1

