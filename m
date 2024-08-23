Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75947C52D7C
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1AAE88AA9;
	Fri, 23 Aug 2024 15:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w6ZqfldB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7F5688915; Fri, 23 Aug 2024 15:49:17 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1F7388965
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42ab99fb45dso20767685e9.1
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724420954; x=1725025754; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8UxEwYmmxaI0ImhWCNG5rhD8GmJXXPCHlorBsPBG8Ok=;
 b=w6ZqfldB1YuKhnt0/N0aGYHqgcmfTqe92NkaUiraWv3s7emsUUHpzBrEre/dy8kSrX
 NiEXb8tpS35YzZpgLCvbViTXy6gsELHoroSJdp57qZ9I8pfk0vRTeKr0SCFxWynHWTzM
 +YPm+wGVj+fDAQg5fQoVzX9KZqhB9pHb2dwNJBrHVW7yrAbSgukv/q4d/Aa7PMzuLlKO
 EQqdMO0cE3lZhdEtx+X+ZtnO04Q5U+G0D7ejdwtvWdpS6EUWSeq9JoPOLlr11g36cqM7
 sBRcjwS9vOLs32E1wKBr5XfE3nMxNUUoEAucGjzf94Xc3Qnz7JsmpD4eA7KCIFQ4GML5
 qyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724420954; x=1725025754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8UxEwYmmxaI0ImhWCNG5rhD8GmJXXPCHlorBsPBG8Ok=;
 b=ndBOCZcMuWG+0U6psGUeGigQVV7e7TLvwKEQ0xSELTmvYVx3W0dtc4VWN9xrPDMA4J
 lxKKpg8OWn6CF3Rjwra/nVIlfvbEQHsK5N52xaskG+ViYx6gD51yzKFMv/Mj8aAZzSw0
 YrH3lnOvlZbe1Hl/FQzy1UPGtM12cb0ZzxAC6hQAIVFg63mfkEhu46YAzyBIunb0KuRV
 pQAV63/kaoj3x/uyp4YDlZYnyUGHDQLJcHkiYrEU+Z5M+HoFrxWqDroV8RnnSXD2bnOQ
 uQNog1+vXi/LZgOEqUdrEX/Qq+quujZe2H8qGMhr2uoO/GnRQUaDTYJyKC9mZVhoEggk
 KdPA==
X-Gm-Message-State: AOJu0Yw0yeFEAtMVPHsZ1XuGj8dsVrMXBWN0yq8YyIOzUp8CYeQpH9FD
 3u+UwlMSCYNOW1DDagd4+ze5W9IfidwJl4XIWkLvCZxKnxdt6Nj9zw8rX0JwRktZbAIQvfuqnWS
 q9O78ZKQ0
X-Google-Smtp-Source: AGHT+IH0ziUPlxCQwTtV7NnKhT8jtZox3yFKgjTkS+tu0vHpFg9eTiw2QAE2AJFlzDI8FcmN0qlmOA==
X-Received: by 2002:adf:a458:0:b0:368:7943:8b1f with SMTP id
 ffacd0b85a97d-373118c8a0fmr1739832f8f.43.1724420954099; 
 Fri, 23 Aug 2024 06:49:14 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:49:13 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>, Tom Rini <trini@konsulko.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Jakub Klama <jakub@conclusive.pl>, Artur Rojek <artur@conclusive.pl>,
 Stefan Roese <sr@denx.de>, Heiko Schocher <hs@denx.de>,
 Marcin Jabrzyk <marcin@conclusive.pl>
Subject: [PATCH v9 03/37] at91: rename mem_init() to at91_mem_init()
Date: Fri, 23 Aug 2024 15:48:07 +0200
Message-Id: <c98f33e9fccf18aeae1c67afa255b8f7d48e31bb.1724419624.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
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

