Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D173C54EE3
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 12:11:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E772588AFB;
	Wed, 28 Aug 2024 14:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="smx6SlBJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54349888A3; Wed, 28 Aug 2024 14:10:48 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2173288A3E
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 14:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37189d8e637so3860185f8f.3
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 05:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724847045; x=1725451845; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sDBcEVogIBVBSmglcRAffFeYWv3UMkJZDLIS/N29gaM=;
 b=smx6SlBJ9B0wvnk7+1xj/ndvBwh2UU7fIqEwpi+6kdkIUjovVwK/mSh3zaOGAzMMa3
 0k8lUePbGYI6oA/Hvdesapw1Hoqj2qjnw2nWbFZbYoWN3DqcvxIrM6T+RGIwYhiX263z
 ayayJ8TQ/PDrVIgZYieTp9UNKDR1p24djkL1rpGRPZ/7npiwQkoX58Z3R3x+waO2cerV
 iXGIpWWTDUon+zq3pCI85/RzhUiXu14PAXmCfzak4GV4OGrSYKB+uUvXZCry22tfE1Gq
 Bp9A+xZbJojtbtHtYXZXOVvJZIBuhdr5gUvxSSQMjGPXFbBgtWZKfYropGCx5lTkPZsi
 bkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724847045; x=1725451845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sDBcEVogIBVBSmglcRAffFeYWv3UMkJZDLIS/N29gaM=;
 b=t9xxx0eN84qnWveTxi80uOIF6HraVw+vs70IiCcz90TcFylbSGw2Yix+Zqf9+Phy6C
 /BtC+Etps0u+s0G03E+QJLugvalJKslZgY9FLhNG4C+m5s925WuXfSA09LgQgSQHSAPY
 YT7E3fYA11VncRjJGJ9gqdciztFpJd9/0OocWb75rosgDC4j6j+PIl+wgVzmC8+oeI4z
 72g//wh067vVSRadAjPLTnM/y6rCoJ2d016XjhX/LVaFzO3VNKpa1GMetciPenJnhLl5
 mixvQKnAIJ3w8snv4oRN9d1oBrvqYz5LOAIr6Hbnp/KbjX2khNXGrjEp97n4wOst5CVP
 yLwA==
X-Gm-Message-State: AOJu0Yw9zhhTA1Omf3kCfvRy/zMRq4YX5oy9R2BQTt3GS6l8lLYffoOI
 62zbKZ/QpgaSdPCme2NmHVvV2vXI4K3TB5ybomGH0B2pBNiAXVOAz4BvAu5iLhG3n1oA66OPu32
 u5B4+gg==
X-Google-Smtp-Source: AGHT+IFZUYDsYik9bkzS74f75GQbdlmupznQuRoQtfK+wsxrSzsnlwqIbtMOft0B8zoO7JpSzCeQig==
X-Received: by 2002:a05:6000:8b:b0:362:8ec2:53d6 with SMTP id
 ffacd0b85a97d-373118ef032mr11249606f8f.61.1724847045328; 
 Wed, 28 Aug 2024 05:10:45 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:8ac3:aada:f033:985a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba639687csm19470365e9.8.2024.08.28.05.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 05:10:45 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>, Tom Rini <trini@konsulko.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Jakub Klama <jakub@conclusive.pl>, Artur Rojek <artur@conclusive.pl>,
 Stefan Roese <sr@denx.de>, Heiko Schocher <hs@denx.de>,
 Marcin Jabrzyk <marcin@conclusive.pl>
Subject: [PATCH 03/13] at91: rename mem_init() to at91_mem_init()
Date: Wed, 28 Aug 2024 14:10:26 +0200
Message-Id: <7f010d834c665c15888b7738a0ad16334fa03443.1724846454.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724846454.git.jerome.forissier@linaro.org>
References: <cover.1724846454.git.jerome.forissier@linaro.org>
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

THe AT91-based platforms have a mem_init() function declared in
arch/arm/mach-at91/include/mach/at91_common.h and implemented in various
places. In preparation of the introduction of the lwIP networking library
which also has a global mem_init() function, rename the AT91 one to
at91_mem_init().

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
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
index 683e539b1b..8fec346c1e 100644
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
index cde1700a28..0d1233cd10 100644
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
index 62a7df8a19..7bfbadf048 100644
--- a/arch/arm/mach-at91/spl_atmel.c
+++ b/arch/arm/mach-at91/spl_atmel.c
@@ -134,7 +134,7 @@ void board_init_f(ulong dummy)
 
 	board_early_init_f();
 
-	mem_init();
+	at91_mem_init();
 
 	ret = spl_init();
 	if (ret) {
diff --git a/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c b/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c
index 3bd94d0889..af486e977e 100644
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
index afc0c0520e..6f9abcbb12 100644
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
index e5688c6cf1..f52b9a9773 100644
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
index 36995a927c..cb3cd7ac9a 100644
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
index c775d593e5..15cbd0daa6 100644
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
index 986da01639..6f0d578abf 100644
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
index c8a8eb4982..d104736fa7 100644
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
index 54cc3c4d90..f98322fb54 100644
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
index f2e1242fcb..28079a8151 100644
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
index 09ca16ca88..f9112fc532 100644
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
index 1f8b85f061..0bdc6adbdc 100644
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
index 64282ae9dc..37750137ad 100644
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
index fb3ec48f9c..db9ba88188 100644
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
index 7d73d1f2b3..cd27fc1cc3 100644
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
index 946fbc3f22..e9e4bc348c 100644
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
index bda12a9770..3764ab48ab 100644
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

