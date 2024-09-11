Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA788EE4987
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 09:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D31198924B;
	Wed, 11 Sep 2024 11:58:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GNrcbgpg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32E338923E; Wed, 11 Sep 2024 11:58:54 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDB5D89245
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 11:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cb6f3a5bcso40870285e9.2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 02:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726048731; x=1726653531; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zoK8FOzTIrKWJpua5WQQxt2OxRail5WV2S9LpE9drIs=;
 b=GNrcbgpgdrMxtZk24+RyjtMThRaE5ykzaeDfEftJnF2pxao5s/A8lHlMxk7p7n9YBY
 bhXv1+IhBpe+Mm3xvH8KGps2OvLlHlkJHMjv37TtlPjcqOjsTl3WGFe2/LSC/B1aHgVc
 2ntC/XLBe1D529a/Aqgn50CupRgYAMhV6GXQg96YWP1d3oceJcb4EpPrjesVH/64J6WE
 B9SpcXQlWDaguSLSXnTNSooPkkIaP2vyDFZjg6beH33Tc9QPnoNkY5EBfY67n0thxWPv
 qQaTyeW53O+yy7DW5rWdgzgyeSQEJkjhsq4BxN8MHSTQvz5oBr6q/pFt/ZzYDVgRFg0y
 mvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726048731; x=1726653531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zoK8FOzTIrKWJpua5WQQxt2OxRail5WV2S9LpE9drIs=;
 b=UdFhPbq/bbwvqJ5K8ZNf1CKU2kRh3x4yAMVQLPAF5WZcXnNlcNzn5TuoW5tuG1Lmy8
 nt8FUD/bkr+Q2xWMgKtIxyfekPHUWknZnAWdsWOvdspCh6U5iCFR+hO6VNxsBkWgNlZJ
 MaTpAw2zvO34xf2H3VFQnw1C/EoV9/YxXAUNM1Dz3okXAM/i2eDgUTxH7WeVIn99/Ba0
 HNIPrh+Se3VlUD+7eQqHzvz4G8WHhAtKXOwcIywQV+6DTmJUJYUcVbSHjFCOo1os/EIK
 ve4ge7fqNGEnnPKNCQeUuySajHvhQPCLQWEe3Sq20dzXjA75NWpDDKT7ihbTng437uDm
 20xw==
X-Gm-Message-State: AOJu0YwnRodZNh3VWolBR8MSuYB3S9LJETT+y0H359lEvUJuR/A1Eyg5
 HIiWjaSDlP3UZPpedU2BHwmARhTPsy7r0Zv0kIPJb+az97GNleEPKW2dWh6yiOmjQrLTuM4knbr
 HH+wKIw==
X-Google-Smtp-Source: AGHT+IFlu8BAH3AAAF9X1Y1edN0/kf1U1Cyof/ivqFo/1aV/uW9xrVSuwRrNq340B2WVBN8RkrVOOg==
X-Received: by 2002:a05:600c:22cf:b0:42c:a8cb:6a5a with SMTP id
 5b1f17b1804b1-42ca8cb6b54mr150224675e9.15.1726048731086; 
 Wed, 11 Sep 2024 02:58:51 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7d92:535d:cd3d:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649bafsm11300507f8f.7.2024.09.11.02.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 02:58:50 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heiko Schocher <hs@denx.de>, Eugen Hristev <eugen.hristev@collabora.com>,
 Tom Rini <trini@konsulko.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Jakub Klama <jakub@conclusive.pl>, Artur Rojek <artur@conclusive.pl>,
 Stefan Roese <sr@denx.de>
Subject: [PATCH v4 03/15] at91: rename mem_init() to at91_mem_init()
Date: Wed, 11 Sep 2024 11:58:16 +0200
Message-Id: <b32f92e70842a33141e9e700c3e93c3e3a1c0e7a.1726048404.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1726048404.git.jerome.forissier@linaro.org>
References: <cover.1726048404.git.jerome.forissier@linaro.org>
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

The AT91-based platforms have a mem_init() function declared in
arch/arm/mach-at91/include/mach/at91_common.h and implemented in various
places. In preparation of the introduction of the lwIP networking library
which also has a global mem_init() function, rename the AT91 one to
at91_mem_init().

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Heiko Schocher <hs@denx.de>
---
 arch/arm/mach-at91/include/mach/at91_common.h       | 2 +-
 arch/arm/mach-at91/spl_at91.c                       | 2 +-
 arch/arm/mach-at91/spl_atmel.c                      | 2 +-
 board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c     | 2 +-
 board/atmel/at91sam9n12ek/at91sam9n12ek.c           | 2 +-
 board/atmel/at91sam9x5ek/at91sam9x5ek.c             | 2 +-
 board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c     | 2 +-
 board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c | 2 +-
 board/atmel/sama5d2_icp/sama5d2_icp.c               | 2 +-
 board/atmel/sama5d2_xplained/sama5d2_xplained.c     | 2 +-
 board/atmel/sama5d3_xplained/sama5d3_xplained.c     | 2 +-
 board/atmel/sama5d3xek/sama5d3xek.c                 | 2 +-
 board/atmel/sama5d4_xplained/sama5d4_xplained.c     | 2 +-
 board/atmel/sama5d4ek/sama5d4ek.c                   | 2 +-
 board/conclusive/kstr-sama5d27/kstr-sama5d27.c      | 2 +-
 board/gardena/smart-gateway-at91sam/spl.c           | 2 +-
 board/siemens/corvus/board.c                        | 2 +-
 board/siemens/smartweb/smartweb.c                   | 2 +-
 board/siemens/taurus/taurus.c                       | 2 +-
 19 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91_common.h b/arch/arm/mach-at91/include/mach/at91_common.h
index 683e539b1b3..8fec346c1e4 100644
--- a/arch/arm/mach-at91/include/mach/at91_common.h
+++ b/arch/arm/mach-at91/include/mach/at91_common.h
@@ -28,7 +28,7 @@ void at91_pllb_init(u32 pllar);
 void at91_mck_init(u32 mckr);
 void at91_mck_init_down(u32 mckr);
 void at91_pmc_init(void);
-void mem_init(void);
+void at91_mem_init(void);
 void at91_phy_reset(void);
 void at91_sdram_hw_init(void);
 void at91_mck_init(u32 mckr);
diff --git a/arch/arm/mach-at91/spl_at91.c b/arch/arm/mach-at91/spl_at91.c
index cde1700a283..0d1233cd109 100644
--- a/arch/arm/mach-at91/spl_at91.c
+++ b/arch/arm/mach-at91/spl_at91.c
@@ -142,7 +142,7 @@ void board_init_f(ulong dummy)
 	preloader_console_init();
 #endif
 
-	mem_init();
+	at91_mem_init();
 
 	at91_spl_board_init();
 }
diff --git a/arch/arm/mach-at91/spl_atmel.c b/arch/arm/mach-at91/spl_atmel.c
index 62a7df8a195..7bfbadf0483 100644
--- a/arch/arm/mach-at91/spl_atmel.c
+++ b/arch/arm/mach-at91/spl_atmel.c
@@ -134,7 +134,7 @@ void board_init_f(ulong dummy)
 
 	board_early_init_f();
 
-	mem_init();
+	at91_mem_init();
 
 	ret = spl_init();
 	if (ret) {
diff --git a/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c b/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c
index 3bd94d0889d..af486e977e5 100644
--- a/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c
+++ b/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c
@@ -125,7 +125,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
 		      2 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct atmel_mpddrc_config ddr2;
 
diff --git a/board/atmel/at91sam9n12ek/at91sam9n12ek.c b/board/atmel/at91sam9n12ek/at91sam9n12ek.c
index afc0c0520e1..6f9abcbb127 100644
--- a/board/atmel/at91sam9n12ek/at91sam9n12ek.c
+++ b/board/atmel/at91sam9n12ek/at91sam9n12ek.c
@@ -167,7 +167,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
 		      2 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct at91_pmc *pmc = (struct at91_pmc *)ATMEL_BASE_PMC;
 	struct at91_matrix *matrix = (struct at91_matrix *)ATMEL_BASE_MATRIX;
diff --git a/board/atmel/at91sam9x5ek/at91sam9x5ek.c b/board/atmel/at91sam9x5ek/at91sam9x5ek.c
index e5688c6cf13..f52b9a97731 100644
--- a/board/atmel/at91sam9x5ek/at91sam9x5ek.c
+++ b/board/atmel/at91sam9x5ek/at91sam9x5ek.c
@@ -181,7 +181,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
 		      2 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct at91_pmc *pmc = (struct at91_pmc *)ATMEL_BASE_PMC;
 	struct at91_matrix *matrix = (struct at91_matrix *)ATMEL_BASE_MATRIX;
diff --git a/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c b/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c
index 36995a927cf..cb3cd7ac9ae 100644
--- a/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c
+++ b/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c
@@ -146,7 +146,7 @@ static void ddrc_conf(struct atmel_mpddrc_config *ddrc)
 		      (8 << ATMEL_MPDDRC_TPR2_TFAW_OFFSET));
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct at91_pmc *pmc = (struct at91_pmc *)ATMEL_BASE_PMC;
 	struct atmel_mpddr *mpddrc = (struct atmel_mpddr *)ATMEL_BASE_MPDDRC;
diff --git a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
index c775d593e58..15cbd0daa6f 100644
--- a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
+++ b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
@@ -208,7 +208,7 @@ static void ddrc_conf(struct atmel_mpddrc_config *ddrc)
 	ddrc->cal_mr4 |= ATMEL_MPDDRC_CAL_MR4_MR4R(0xFFFE);
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct at91_pmc *pmc = (struct at91_pmc *)ATMEL_BASE_PMC;
 	struct atmel_mpddr *mpddrc = (struct atmel_mpddr *)ATMEL_BASE_MPDDRC;
diff --git a/board/atmel/sama5d2_icp/sama5d2_icp.c b/board/atmel/sama5d2_icp/sama5d2_icp.c
index 986da01639f..6f0d578abf7 100644
--- a/board/atmel/sama5d2_icp/sama5d2_icp.c
+++ b/board/atmel/sama5d2_icp/sama5d2_icp.c
@@ -180,7 +180,7 @@ static void ddrc_conf(struct atmel_mpddrc_config *ddrc)
 		      (7 << ATMEL_MPDDRC_TPR2_TFAW_OFFSET));
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct at91_pmc *pmc = (struct at91_pmc *)ATMEL_BASE_PMC;
 	struct atmel_mpddr *mpddrc = (struct atmel_mpddr *)ATMEL_BASE_MPDDRC;
diff --git a/board/atmel/sama5d2_xplained/sama5d2_xplained.c b/board/atmel/sama5d2_xplained/sama5d2_xplained.c
index c8a8eb49826..d104736fa7c 100644
--- a/board/atmel/sama5d2_xplained/sama5d2_xplained.c
+++ b/board/atmel/sama5d2_xplained/sama5d2_xplained.c
@@ -146,7 +146,7 @@ static void ddrc_conf(struct atmel_mpddrc_config *ddrc)
 		      7 << ATMEL_MPDDRC_TPR2_TFAW_OFFSET);
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct at91_pmc *pmc = (struct at91_pmc *)ATMEL_BASE_PMC;
 	struct atmel_mpddr *mpddrc = (struct atmel_mpddr *)ATMEL_BASE_MPDDRC;
diff --git a/board/atmel/sama5d3_xplained/sama5d3_xplained.c b/board/atmel/sama5d3_xplained/sama5d3_xplained.c
index 54cc3c4d900..f98322fb540 100644
--- a/board/atmel/sama5d3_xplained/sama5d3_xplained.c
+++ b/board/atmel/sama5d3_xplained/sama5d3_xplained.c
@@ -175,7 +175,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
 		      8 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct atmel_mpddrc_config ddr2;
 
diff --git a/board/atmel/sama5d3xek/sama5d3xek.c b/board/atmel/sama5d3xek/sama5d3xek.c
index f2e1242fcb0..28079a81517 100644
--- a/board/atmel/sama5d3xek/sama5d3xek.c
+++ b/board/atmel/sama5d3xek/sama5d3xek.c
@@ -241,7 +241,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
 		      8 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct atmel_mpddrc_config ddr2;
 
diff --git a/board/atmel/sama5d4_xplained/sama5d4_xplained.c b/board/atmel/sama5d4_xplained/sama5d4_xplained.c
index 09ca16ca88c..f9112fc5321 100644
--- a/board/atmel/sama5d4_xplained/sama5d4_xplained.c
+++ b/board/atmel/sama5d4_xplained/sama5d4_xplained.c
@@ -184,7 +184,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
 		      8 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct atmel_mpddrc_config ddr2;
 
diff --git a/board/atmel/sama5d4ek/sama5d4ek.c b/board/atmel/sama5d4ek/sama5d4ek.c
index 1f8b85f0614..0bdc6adbdc8 100644
--- a/board/atmel/sama5d4ek/sama5d4ek.c
+++ b/board/atmel/sama5d4ek/sama5d4ek.c
@@ -169,7 +169,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
 		      8 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct atmel_mpddrc_config ddr2;
 	const struct atmel_mpddr *mpddr = (struct atmel_mpddr *)ATMEL_BASE_MPDDRC;
diff --git a/board/conclusive/kstr-sama5d27/kstr-sama5d27.c b/board/conclusive/kstr-sama5d27/kstr-sama5d27.c
index 64282ae9dc7..37750137ad9 100644
--- a/board/conclusive/kstr-sama5d27/kstr-sama5d27.c
+++ b/board/conclusive/kstr-sama5d27/kstr-sama5d27.c
@@ -182,7 +182,7 @@ static void ddrc_conf(struct atmel_mpddrc_config *ddrc)
 		      (8 << ATMEL_MPDDRC_TPR2_TFAW_OFFSET));
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct at91_pmc *pmc = (struct at91_pmc *)ATMEL_BASE_PMC;
 	struct atmel_mpddr *mpddrc = (struct atmel_mpddr *)ATMEL_BASE_MPDDRC;
diff --git a/board/gardena/smart-gateway-at91sam/spl.c b/board/gardena/smart-gateway-at91sam/spl.c
index fb3ec48f9c5..db9ba881884 100644
--- a/board/gardena/smart-gateway-at91sam/spl.c
+++ b/board/gardena/smart-gateway-at91sam/spl.c
@@ -110,7 +110,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
 		      2 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct at91_matrix *matrix = (struct at91_matrix *)ATMEL_BASE_MATRIX;
 	struct at91_pmc *pmc = (struct at91_pmc *)ATMEL_BASE_PMC;
diff --git a/board/siemens/corvus/board.c b/board/siemens/corvus/board.c
index 7d73d1f2b36..cd27fc1cc37 100644
--- a/board/siemens/corvus/board.c
+++ b/board/siemens/corvus/board.c
@@ -187,7 +187,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
 		      2 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct atmel_mpddrc_config ddr2;
 
diff --git a/board/siemens/smartweb/smartweb.c b/board/siemens/smartweb/smartweb.c
index 946fbc3f229..e9e4bc348cb 100644
--- a/board/siemens/smartweb/smartweb.c
+++ b/board/siemens/smartweb/smartweb.c
@@ -238,7 +238,7 @@ void at91_spl_board_init(void)
 			 | AT91_SDRAMC_TRP_VAL(2) | AT91_SDRAMC_TRCD_VAL(2) \
 			 | AT91_SDRAMC_TRAS_VAL(5) | AT91_SDRAMC_TXSR_VAL(8))
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct at91_matrix *ma = (struct at91_matrix *)ATMEL_BASE_MATRIX;
 	struct at91_port *port = (struct at91_port *)ATMEL_BASE_PIOC;
diff --git a/board/siemens/taurus/taurus.c b/board/siemens/taurus/taurus.c
index bda12a97708..3764ab48ab3 100644
--- a/board/siemens/taurus/taurus.c
+++ b/board/siemens/taurus/taurus.c
@@ -177,7 +177,7 @@ void sdramc_configure(unsigned int mask)
 	sdramc_initialize(ATMEL_BASE_CS1, &setting);
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	unsigned int ram_size = 0;
 
-- 
2.40.1

