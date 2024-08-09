Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5081C52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 17:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67B01889B8;
	Fri,  9 Aug 2024 19:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="euzbP8gC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51F0D887D4; Fri,  9 Aug 2024 19:58:29 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C8F888C12
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 19:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-75abb359fa5so332966a12.0
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 10:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723226305; x=1723831105; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oGUrDnTwrcMx5T4AkcOUzaeEMCwhNRsAsjcfeTuEWO4=;
 b=euzbP8gCQYN5fM84si7TXt2zAyBGFTvu7Tq5GcUEGojqu2rDERS3xi7vs+VOlR/kiu
 t3Y7bulDNPEetsOl1ppRL1retPxiDYtxOAEFhJvheH2nsQk+MZV3Gx/XHU3C3g+NqHqL
 WcqsNQI6hUj6j1+bmEonrr59a908QGal0LS6Odf53eIZTWr6LCehTG31ubb2anwyOLZC
 SJiVYAPgcVSgVLP0f/cZz3I0gcWcgyVN9qku/K+F1Wk8M5dvcQBBtOTv9ZV9vP359QpS
 BbXd0rS5Vmj3gGTJu1bKCBT6zsCZJU1SDGrLnHPrZkg/f5UCg/qXKGRP5IsOVXqwsX+G
 Y6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723226305; x=1723831105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oGUrDnTwrcMx5T4AkcOUzaeEMCwhNRsAsjcfeTuEWO4=;
 b=K5h1d2IKdEP0hohnyqfgkWb4szrmAstU24KTi5I+bdasOLUiLZdpH4Xt++KfeSTWwP
 Rjtx6W254W9V6wyaLCINgyXUYzNm27c+4iX2BHQnJMKMW2TMaM9BNILxYzQ2M7LxO/Oq
 CmRPF9Qvu+gAxYt+pNfWujrnV7Fm7wNWFF0KBsuOZplZVVc/ekcPsYDmwbBk1csbQhnI
 ZnIAOFu78tNmsN4gbk4yRkxl+YOckzViPrW6l9enEkqeqOY4AqOLEE1W/wqP48scPkVC
 CM+oAjOf1hnvwxukM23y4nsKlA/bUj6UmL56blNKOe4r/CNursjUK19pxxVPGwWMsV/7
 v7kQ==
X-Gm-Message-State: AOJu0YzkXlgpgUdjBjnHS5dIP/h6MoIHYmt6P8gveIF1yZOzYusSMXfL
 k9DMVLhVG/qRZ+QTgMXjm1cZezWVGF8GaHG20Xbruxfm7HgLnhRl/pVHIg==
X-Google-Smtp-Source: AGHT+IHwzTRb2+2EqGd7weXibhAP9BjQYLAOQX+ZaU+gKqoFdpDbEcQ4zg1lgoEQlxF159F3w19W7g==
X-Received: by 2002:a17:902:f548:b0:200:ab8d:f808 with SMTP id
 d9443c01a7336-200ae59b8f1mr14709105ad.5.1723226305529; 
 Fri, 09 Aug 2024 10:58:25 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:c7cd:c377:d374:237c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-200bb7e8ad2sm467395ad.11.2024.08.09.10.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 10:58:25 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: Markus.Niebel@tq-group.com
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/2] tqma6: Do not print the board name twice
Date: Fri,  9 Aug 2024 14:58:09 -0300
Message-Id: <20240809175809.612183-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809175809.612183-1-festevam@gmail.com>
References: <20240809175809.612183-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Currently, the devicetree model as well as the board variant name
are shown:
...    
Model: TQ TQMa6S/DL on MBa6x
Board: TQMa6DL on a MBa6x
...
    
Unselect the CONFIG_DISPLAY_BOARDINFO option so that the
board name is printed only once in board_late_init() instead.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 board/tq/tqma6/tqma6.c             | 5 -----
 configs/tqma6dl_mba6_mmc_defconfig | 1 +
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/board/tq/tqma6/tqma6.c b/board/tq/tqma6/tqma6.c
index 02a2022c3c84..445ce987b683 100644
--- a/board/tq/tqma6/tqma6.c
+++ b/board/tq/tqma6/tqma6.c
@@ -230,11 +230,6 @@ int board_late_init(void)
 
 	tqma6_bb_board_late_init();
 
-	return 0;
-}
-
-int checkboard(void)
-{
 	printf("Board: %s on a %s\n", tqma6_get_boardname(),
 	       tqma6_bb_get_boardname());
 	return 0;
diff --git a/configs/tqma6dl_mba6_mmc_defconfig b/configs/tqma6dl_mba6_mmc_defconfig
index be891d24537f..d0c5db65177c 100644
--- a/configs/tqma6dl_mba6_mmc_defconfig
+++ b/configs/tqma6dl_mba6_mmc_defconfig
@@ -17,6 +17,7 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run mmcboot; run netboot; run panicboot"
 CONFIG_DEFAULT_FDT_FILE="imx6dl-mba6x.dtb"
 CONFIG_SYS_PBSIZE=532
+# CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_BOOTZ=y
-- 
2.34.1

