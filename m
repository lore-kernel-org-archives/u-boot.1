Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B71CD13CF
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 08:39:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A36388CF2;
	Tue,  3 Sep 2024 10:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ykme2GhZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32C2E88C8A; Tue,  3 Sep 2024 10:38:55 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6D7388CAF
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 10:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42c7a384b18so22267085e9.0
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 01:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725352731; x=1725957531; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zoK8FOzTIrKWJpua5WQQxt2OxRail5WV2S9LpE9drIs=;
 b=ykme2GhZ1EwEdPmfHedLj+mU8qncJuVOVfTLr3x2DsnVn6p3ccns3FVZWwwgOgKjQ4
 2GsC8mH/i5NjCG1sOBsDYjkRYGlQS/XSg/P3rvw8pbmwYlx2KScQV/sDGWyk/yO78C4v
 evSFb5BmpYi0l3tze9zCmN9VkC6DIrJqqI4htzRAM7zw0Nj6p219A15onX7FV/GEdTqE
 eAppVNxXrGSBV7dPk2k/XJIBNoA5y5rF7ZKx5MjbX/vjOuA4cDsawGX5vJz1OLGfiSa7
 uHcrlIRwgbjD9cPD8yvJLdexFEH7g+vn33MSdTwXegJ2qe4ezhU+cvTOasBA5Czm5U3O
 TkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725352731; x=1725957531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zoK8FOzTIrKWJpua5WQQxt2OxRail5WV2S9LpE9drIs=;
 b=FWvRgc5Y4CmJ1OqZncjzAKyb5Z5qxhRSoitzAzrSloqTkDDe7WhgMSRVptTJXDXlRd
 mdrt4YwgIQ0UptAXOVPCQNEFWNk6L/9vSBlM81dOulPi0PQdRrY/h7AZ9Rqbsm1hyoso
 n5aQ1dCD2SJW2KnzT37lx21qw5ZTbZErsS4b3Nq+cbCVoXtElfB679ldUsB30r+KcBmm
 UJFqti3kCXtyqaVRZGXqLIRmSqIeZ7ll9Cn+GOLo5JDB+wlhigdL+YxRFh2RcXD7bp/c
 QaKxnj4xXUIaCyaLfgmkobfbRT+/7W8jPBKKill5Y+KbFlYoPBiiuPsuRTCwl0L9blhZ
 2nBA==
X-Gm-Message-State: AOJu0YyuwUgA76CMj+rnLVj/2aXV6tV1WHB3rxkHc0PxgNtmzDael8hX
 mLMNPHt7U3hQEyQ3LRH+1/H0pEdODNMKCP/YW7mk8Hv/YMKUsnAr/+fB8fRMJoe0rdylUg596Mv
 fWqnRRQ==
X-Google-Smtp-Source: AGHT+IFd4gHBD/sjGK8megU4cfKHJjKLgDi9hh34xmGkd5uLbM4zJ2Nct2yzqhmQxyjwnD4FBd/gvw==
X-Received: by 2002:a05:600c:4452:b0:428:1090:cfd4 with SMTP id
 5b1f17b1804b1-42be48faa4emr63848185e9.33.1725352731492; 
 Tue, 03 Sep 2024 01:38:51 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df795asm163103325e9.21.2024.09.03.01.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 01:38:51 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heiko Schocher <hs@denx.de>, Eugen Hristev <eugen.hristev@collabora.com>,
 Tom Rini <trini@konsulko.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Jakub Klama <jakub@conclusive.pl>, Artur Rojek <artur@conclusive.pl>,
 Stefan Roese <sr@denx.de>, Marcin Jabrzyk <marcin@conclusive.pl>
Subject: [PATCH v3 04/16] at91: rename mem_init() to at91_mem_init()
Date: Tue,  3 Sep 2024 10:38:01 +0200
Message-Id: <65899254eef2808c23068dcad1db0c301c9101bc.1725351676.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725351676.git.jerome.forissier@linaro.org>
References: <cover.1725351676.git.jerome.forissier@linaro.org>
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

