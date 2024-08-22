Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5449C3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 13:59:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D416688B36;
	Thu, 22 Aug 2024 15:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KnupWNVe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69670889C1; Thu, 22 Aug 2024 15:58:23 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AC2688A66
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-39d3cd4fa49so2795945ab.1
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724335100; x=1724939900; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YEqbRmEjNbFAc4akbTOA2582DDQIDIBjqvjFWV0bMB0=;
 b=KnupWNVeFR4mlS0MJ/gaQJSmpR9+zyTOV1O+HT+jFk3OJ6E20Ms5dG0hUQPv2JTTyV
 CMHdUfi9bwzhrDTc024oeS/hPQGJLfV2OUGYOKjfvw2L4mrcRey2HE0FmN2UN7iTkxy3
 3CgIB4v39DhtTonLDFHvEXwS0v8zAXZqpfBfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724335100; x=1724939900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YEqbRmEjNbFAc4akbTOA2582DDQIDIBjqvjFWV0bMB0=;
 b=gCgORBcXsHYmjfZ2ir5elPJjGG7TgldD2au1VIENHYuG6wbsDDljapShynTLb6b9kZ
 NKUbmK9iCGn8nsv2MB+PJYwzM5npaYvV61sBsb5ln/IkTgHO8Zfea8rDDI+ackkJq0No
 9FkbcArmmosB4z8R8fEQXRtsWzH3ronjzg9eA6jCAnuxEkFNwCWlSVpU7q+O/ERFT4Ts
 pGdWvJeZvOEM5tFS2Yuu1kmkQ2AjJo4LrSuXSPzel53kbSnmRQsDvmeuLtSkPOe3yyCb
 lL5wiTdwhxd+iuKCzZy2Pw0RSmqy0/u6505/HGCy87hPhr0KTg8fTNqz58BovOG1Gyp7
 CxDw==
X-Gm-Message-State: AOJu0Yx4S6N4WEHamdkURciijDHmO3Kuxycwn2Zb/HVqCxfXZWuFBWeC
 mUbZNnRkBxOQfMAa4/ZsL/nkRviUxRxINk4s23T124p9pwxF2FqPt4pkfHh7XUzQyU9pkFLN0+I
 =
X-Google-Smtp-Source: AGHT+IG+EkrUdbPNZD117rAwlsZOzyyQjxGLYh3og3YMuoGu1ORLzoFuBqN6xl2zhFL4QZK37HnOyg==
X-Received: by 2002:a92:cd83:0:b0:39b:3244:a355 with SMTP id
 e9e14a558f8ab-39d7284fecbmr24395385ab.11.1724335099939; 
 Thu, 22 Aug 2024 06:58:19 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e747eesm6793275ab.29.2024.08.22.06.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:58:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 06/19] mmc: Drop the blank line before accesses
Date: Thu, 22 Aug 2024 07:57:51 -0600
Message-Id: <20240822135804.2375959-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822135804.2375959-1-sjg@chromium.org>
References: <20240822135804.2375959-1-sjg@chromium.org>
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

(no changes since v1)

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

