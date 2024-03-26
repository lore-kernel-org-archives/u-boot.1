Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115D3C6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 12:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75DFB87FD7;
	Tue, 26 Mar 2024 13:20:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ltYdk9to";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03A2187D84; Tue, 26 Mar 2024 13:20:06 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18D0588019
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 13:19:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-29d51cdde7eso1604224a91.0
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 05:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711455596; x=1712060396; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nq18QJmEx6F55gDs1peeX1rJ1mPue5t/li1g5Ar9CEU=;
 b=ltYdk9toUVF4q8kEZOJaSvPFy2p+agFFxmO1K8JYBdJ7tfqp7V7JCk8rDSXqktDfgi
 5iPT+LUy7tEsic42A3vn6gvGY+E7osDGOJRKxH5mJQF5jXnAQm0Xf3uRUsoG9v8P1I+j
 vaJqiEivMHp1zgV0m7RBVy7HDC3Nz2tBub1RVHk8Xsl6BYzoK3YZoHdxIWBtgUt1iNGC
 MYPK1WO71kaNZdHWpwMiowhClD7ltL7JSqML9/cO7vXIxrRn76paVauTbflR5K/jl2r9
 TuPsvuVMT2BfoHNAHborWkm8zsCXvRr2/2a+vbMSZnOrRizqYo7puRPCBc4fW6as6bB2
 lJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711455596; x=1712060396;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nq18QJmEx6F55gDs1peeX1rJ1mPue5t/li1g5Ar9CEU=;
 b=l7npXj521LNZ00y4GKbps13H7i6F/fIirLnZL6nGS9Tit1trOzJpK+arxSUZmCVX5Y
 ycjmBtuWFhsibQu10FuF8Bf4rzDL30/U8gTqttS3FnYxb0n2OcZNsWIgXC8LZ3GK3OPG
 R+KN4lE9eOsooEZtAtJHskIAXdgtboSWiYcX9zM/WRyq4yCZIlgRpN4/B2tXZo0mX87z
 guH0eyu7bceMVonpkPwZwX4dontNGelTVXKmOzl54qwb0Nhz1UYNE1jd0H2tc4mxMUbZ
 QlgyltNvPXm1z6Y/pU3rXIwG/gXJ3lCUZFcEbJ5fk8sIZQqZ55tXveQUS4tYK1JvRanI
 /b2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOLQbJl7zGQ9IrBXUlBh7J/TeeHPpCcpgRQjP1VISIExp+42Fp8hmK/IGlL3yveWHhlHM2TQJk6B8FKTNJBulzQPFk3w==
X-Gm-Message-State: AOJu0YympUdpP22vKGAHVjpNa4V8jUtTAUQmLpkzkPNBiQGVOyYuyAGV
 +3GVglNgmWBUO56BrYEoWYt2Z/2Ic048f0jzQ/HUTr4HoOfP5J8/
X-Google-Smtp-Source: AGHT+IE28avcBDmkJPY5Ihcyz/IId4Uce3yAu4GazMXNy+qVmLC8QFYR5C6tL5y4BjIP90X0mMxT8Q==
X-Received: by 2002:a17:90a:bd91:b0:296:db75:c240 with SMTP id
 z17-20020a17090abd9100b00296db75c240mr8602021pjr.1.1711455596419; 
 Tue, 26 Mar 2024 05:19:56 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:ebca:2207:7ede:8032])
 by smtp.gmail.com with ESMTPSA id
 qc2-20020a17090b288200b002a08cce28b5sm888174pjb.48.2024.03.26.05.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 05:19:55 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: festevam@gmail.com
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, hiago.franco@toradex.com,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH] imx8: Add a default reset_cpu() implementation
Date: Tue, 26 Mar 2024 09:19:49 -0300
Message-Id: <20240326121949.1915850-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Add a weak default reset_cpu() implementation just like
it is done on arch/arm/mach-imx/cpu.c.

This allows the removal of the empty reset_cpu() in several
board files.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/mach-imx/imx8/cpu.c                          |  4 ++++
 board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c | 11 -----------
 board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c |  8 --------
 board/congatec/cgtqmx8/cgtqmx8.c                      |  7 -------
 board/freescale/imx8qm_mek/imx8qm_mek.c               |  8 --------
 board/freescale/imx8qxp_mek/imx8qxp_mek.c             |  8 --------
 board/toradex/apalis-imx8/apalis-imx8.c               |  8 --------
 board/toradex/colibri-imx8x/colibri-imx8x.c           |  8 --------
 8 files changed, 4 insertions(+), 58 deletions(-)

diff --git a/arch/arm/mach-imx/imx8/cpu.c b/arch/arm/mach-imx/imx8/cpu.c
index 0b91e448a5d..6e643188f40 100644
--- a/arch/arm/mach-imx/imx8/cpu.c
+++ b/arch/arm/mach-imx/imx8/cpu.c
@@ -84,6 +84,10 @@ static char *get_reset_cause(void)
 	}
 }
 
+__weak void reset_cpu(void)
+{
+}
+
 int arch_cpu_init(void)
 {
 #if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_RECOVER_DATA_SECTION)
diff --git a/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c b/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
index 8b4d73052eb..56b7bdb57c9 100644
--- a/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
+++ b/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
@@ -136,17 +136,6 @@ void detail_board_ddr_info(void)
 	puts("\nDDR    ");
 }
 
-/*
- * Board specific reset that is system reset.
- */
-void reset_cpu(void)
-{
-	puts("SCI reboot request");
-
-	while (1)
-		putc('.');
-}
-
 #ifdef CONFIG_OF_BOARD_SETUP
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
diff --git a/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c b/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c
index 206ce7d5c13..7f766a688bb 100644
--- a/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c
+++ b/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c
@@ -112,14 +112,6 @@ int board_init(void)
 	return 0;
 }
 
-/*
- * Board specific reset that is system reset.
- */
-void reset_cpu(void)
-{
-	/* TODO */
-}
-
 int board_mmc_get_env_dev(int devno)
 {
 	return devno;
diff --git a/board/congatec/cgtqmx8/cgtqmx8.c b/board/congatec/cgtqmx8/cgtqmx8.c
index 26189ff66f5..3b01354bb6b 100644
--- a/board/congatec/cgtqmx8/cgtqmx8.c
+++ b/board/congatec/cgtqmx8/cgtqmx8.c
@@ -371,13 +371,6 @@ void detail_board_ddr_info(void)
 	puts("\nDDR    ");
 }
 
-/*
- * Board specific reset that is system reset.
- */
-void reset_cpu(void)
-{
-	/* TODO */
-}
 
 #ifdef CONFIG_OF_BOARD_SETUP
 int ft_board_setup(void *blob, struct bd_info *bd)
diff --git a/board/freescale/imx8qm_mek/imx8qm_mek.c b/board/freescale/imx8qm_mek/imx8qm_mek.c
index d96d1d07bb1..2b209c8886f 100644
--- a/board/freescale/imx8qm_mek/imx8qm_mek.c
+++ b/board/freescale/imx8qm_mek/imx8qm_mek.c
@@ -102,14 +102,6 @@ int board_init(void)
 	return 0;
 }
 
-/*
- * Board specific reset that is system reset.
- */
-void reset_cpu(void)
-{
-	/* TODO */
-}
-
 #ifdef CONFIG_OF_BOARD_SETUP
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
diff --git a/board/freescale/imx8qxp_mek/imx8qxp_mek.c b/board/freescale/imx8qxp_mek/imx8qxp_mek.c
index 516cefd2f24..833bee55462 100644
--- a/board/freescale/imx8qxp_mek/imx8qxp_mek.c
+++ b/board/freescale/imx8qxp_mek/imx8qxp_mek.c
@@ -126,14 +126,6 @@ int board_init(void)
 	return 0;
 }
 
-/*
- * Board specific reset that is system reset.
- */
-void reset_cpu(void)
-{
-	/* TODO */
-}
-
 #ifdef CONFIG_OF_BOARD_SETUP
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
diff --git a/board/toradex/apalis-imx8/apalis-imx8.c b/board/toradex/apalis-imx8/apalis-imx8.c
index 49719f2f553..0f993e644d7 100644
--- a/board/toradex/apalis-imx8/apalis-imx8.c
+++ b/board/toradex/apalis-imx8/apalis-imx8.c
@@ -291,14 +291,6 @@ int board_init(void)
 	return 0;
 }
 
-/*
- * Board specific reset that is system reset.
- */
-void reset_cpu(void)
-{
-	/* TODO */
-}
-
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
diff --git a/board/toradex/colibri-imx8x/colibri-imx8x.c b/board/toradex/colibri-imx8x/colibri-imx8x.c
index 6fc8076163c..a507d666c07 100644
--- a/board/toradex/colibri-imx8x/colibri-imx8x.c
+++ b/board/toradex/colibri-imx8x/colibri-imx8x.c
@@ -140,14 +140,6 @@ int board_init(void)
 	return 0;
 }
 
-/*
- * Board specific reset that is system reset.
- */
-void reset_cpu(void)
-{
-	/* TODO */
-}
-
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
-- 
2.34.1

