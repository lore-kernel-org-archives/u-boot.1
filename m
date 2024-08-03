Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB758C3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 11:11:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58AE488C89;
	Sat,  3 Aug 2024 13:10:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hPs/WpxQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EC3B88C6A; Sat,  3 Aug 2024 13:10:42 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E73488BCD
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 13:10:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-426526d30aaso59837715e9.0
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 04:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722683439; x=1723288239; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qzmzCEsza4EfBkcU9b6yOm6CctEuT3rcR/67BRZ99Uk=;
 b=hPs/WpxQAJSkBW5kYSOj5Agh/4rTrbgex6ccYJLlpNAuW5/v8mPRWvF8tUs+1Ra107
 BAOWQqb2+uDkBVdXYAIVi+dfCTaTRjGEEYc3Ncl0s6IkHsc5k61Qctfe1FkPDxNbv3aE
 kh14hRDTpDsIGFh+NZZHL484QUxFjhO638Fka8XqDKPbhQ/wXCYb+AhMivdq5tb2TONw
 qHhZhFrEFdyYWkqlVFqE3MfJ7CJkWbjMyFf1BqP5YSk/z+TOMOFSI9Jlmuik1MhLWQRC
 sr1ckv+p3ceQMUmzmCXc9IQB2ix3U6niheaP125xtYiFse+ipbeOZ6jH9zDh1aVR52UA
 7JIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722683439; x=1723288239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qzmzCEsza4EfBkcU9b6yOm6CctEuT3rcR/67BRZ99Uk=;
 b=VsgCq+8N0K78WukoS/PyzNNIoPxYRPSc9XXeX168wqNcJjiFVlHJHUkouATd6jNfHB
 rVaVDNRo9c6BRi5k+6aCMPY0ASodAt6vy+X6mAqywX5RJwTkUGtgf4RER+Izyf2kxSj5
 amwz1Syh8++7FxnwcCwk7mb7WEfsczBfXdBO/QZwEKoJBHpT9Wfm4UqOkyTXEpHwWOUh
 pP8YmDr2lsYPTsQtO+FEJSCtXvgVSjvn77ZgT8KcupbUTFmY6eThxCeWBky3JhFLF7IU
 Oszj4TQ8Tq05Fh5a2dHTDmwVepGSQSPP1pYmxoyEBvXxnfiHZLcc28G/HLHyl6jVTOdo
 XL1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMC694wNnwg56SNr6JaKA5EmAHohTa1cZpwF2EOz70voIsY1NNs+2VEDjmhT7QjW0d6St2J+V+0XFLqcwA3s1fO09aQg==
X-Gm-Message-State: AOJu0YyGayQnHgPZzru9AJVIX3JYbQtqgul6ZseLqDIv0o6F85t0XH6m
 rJgJ1Rtjdq6hSg+LrzFRGiYWK2oEbfpvvkZCf2G+CKON45YLP/iRCtXQOw==
X-Google-Smtp-Source: AGHT+IGKDM+RjshxPeiIuqr/SSjl2FKhOs3UX4uJ9GPGayYCna7zDziplhQVPWgAhM5FSQpoCSwenw==
X-Received: by 2002:a05:6000:108a:b0:368:4def:921f with SMTP id
 ffacd0b85a97d-36bbc0cdab1mr4918527f8f.11.1722683438448; 
 Sat, 03 Aug 2024 04:10:38 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0dc9asm4085699f8f.15.2024.08.03.04.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 04:10:38 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 03/15] clk: mediatek: mt7986: rename 66M_MCK to SYSAXI_D2
Date: Sat,  3 Aug 2024 10:40:36 +0200
Message-ID: <20240803084050.449-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803084050.449-1-ansuelsmth@gmail.com>
References: <20240803084050.449-1-ansuelsmth@gmail.com>
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

Upstream kernel linux clock include use SYSAXI_D2 instead of 66M_MCK.
Rename this clock to the upstream kernel in preparation for support of
OF_UPSTREAM.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7986.c      | 20 ++++++++++----------
 include/dt-bindings/clock/mt7986-clk.h |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index 67ed1768046..72300d80884 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -309,7 +309,7 @@ static const struct mtk_fixed_factor infra_fixed_divs[] = {
 	TOP_FACTOR(CK_INFRA_I2C, "infra_i2c", CK_TOP_I2C_SEL, 1, 1),
 	TOP_FACTOR(CK_INFRA_ISPI1, "infra_ispi1", CK_TOP_SPINFI_SEL, 1, 1),
 	TOP_FACTOR(CK_INFRA_PWM, "infra_pwm", CK_TOP_PWM_SEL, 1, 1),
-	TOP_FACTOR(CK_INFRA_66M_MCK, "infra_66m_mck", CK_TOP_SYSAXI_SEL, 1, 2),
+	TOP_FACTOR(CK_INFRA_SYSAXI_D2, "infra_sysaxi_d2", CK_TOP_SYSAXI_SEL, 1, 2),
 	TOP_FACTOR(CK_INFRA_CK_F32K, "infra_ck_f32k", CK_TOP_CB_RTC_32P7K, 1,
 		   1),
 	TOP_FACTOR(CK_INFRA_PCIE_CK, "infra_pcie", CK_TOP_PEXTP_TL_SEL, 1, 1),
@@ -365,7 +365,7 @@ static const int infra_spi1_parents[] = { CK_INFRA_I2C, CK_INFRA_ISPI1 };
 
 static const int infra_pwm_bsel_parents[] = { CK_INFRA_CK_F32K,
 					      CK_INFRA_CK_F26M,
-					      CK_INFRA_66M_MCK, CK_INFRA_PWM };
+					      CK_INFRA_SYSAXI_D2, CK_INFRA_PWM };
 
 static const int infra_pcie_parents[] = { CK_INFRA_CK_F32K, CK_INFRA_CK_F26M,
 					  -1, CK_INFRA_PCIE_CK };
@@ -447,8 +447,8 @@ static const struct mtk_gate_regs infra_2_cg_regs = {
 
 static const struct mtk_gate infracfg_ao_gates[] = {
 	/* INFRA0 */
-	GATE_INFRA0(CK_INFRA_GPT_STA, "infra_gpt_sta", CK_INFRA_66M_MCK, 0),
-	GATE_INFRA0(CK_INFRA_PWM_HCK, "infra_pwm_hck", CK_INFRA_66M_MCK, 1),
+	GATE_INFRA0(CK_INFRA_GPT_STA, "infra_gpt_sta", CK_INFRA_SYSAXI_D2, 0),
+	GATE_INFRA0(CK_INFRA_PWM_HCK, "infra_pwm_hck", CK_INFRA_SYSAXI_D2, 1),
 	GATE_INFRA0(CK_INFRA_PWM_STA, "infra_pwm_sta", CK_INFRA_PWM_BCK, 2),
 	GATE_INFRA0(CK_INFRA_PWM1_CK, "infra_pwm1", CK_INFRA_PWM_CK1, 3),
 	GATE_INFRA0(CK_INFRA_PWM2_CK, "infra_pwm2", CK_INFRA_PWM_CK2, 4),
@@ -463,9 +463,9 @@ static const struct mtk_gate infracfg_ao_gates[] = {
 		    13),
 	GATE_INFRA0(CK_INFRA_DRAMC_26M_CK, "infra_dramc_26m", CK_INFRA_CK_F26M,
 		    14),
-	GATE_INFRA0(CK_INFRA_DBG_CK, "infra_dbg", CK_INFRA_66M_MCK, 15),
-	GATE_INFRA0(CK_INFRA_AP_DMA_CK, "infra_ap_dma", CK_INFRA_66M_MCK, 16),
-	GATE_INFRA0(CK_INFRA_SEJ_CK, "infra_sej", CK_INFRA_66M_MCK, 24),
+	GATE_INFRA0(CK_INFRA_DBG_CK, "infra_dbg", CK_INFRA_SYSAXI_D2, 15),
+	GATE_INFRA0(CK_INFRA_AP_DMA_CK, "infra_ap_dma", CK_INFRA_SYSAXI_D2, 16),
+	GATE_INFRA0(CK_INFRA_SEJ_CK, "infra_sej", CK_INFRA_SYSAXI_D2, 24),
 	GATE_INFRA0(CK_INFRA_SEJ_13M_CK, "infra_sej_13m", CK_INFRA_CK_F26M, 25),
 	GATE_INFRA0(CK_INFRA_TRNG_CK, "infra_trng", CK_INFRA_HD_133M, 26),
 	/* INFRA1 */
@@ -477,12 +477,12 @@ static const struct mtk_gate infracfg_ao_gates[] = {
 	GATE_INFRA1(CK_INFRA_NFI1_CK, "infra_nfi1", CK_INFRA_NFI_CK, 8),
 	GATE_INFRA1(CK_INFRA_SPINFI1_CK, "infra_spinfi1", CK_INFRA_SPINFI_CK,
 		    9),
-	GATE_INFRA1(CK_INFRA_NFI_HCK_CK, "infra_nfi_hck", CK_INFRA_66M_MCK, 10),
+	GATE_INFRA1(CK_INFRA_NFI_HCK_CK, "infra_nfi_hck", CK_INFRA_SYSAXI_D2, 10),
 	GATE_INFRA1(CK_INFRA_SPI0_CK, "infra_spi0", CK_INFRA_MUX_SPI0, 11),
 	GATE_INFRA1(CK_INFRA_SPI1_CK, "infra_spi1", CK_INFRA_MUX_SPI1, 12),
-	GATE_INFRA1(CK_INFRA_SPI0_HCK_CK, "infra_spi0_hck", CK_INFRA_66M_MCK,
+	GATE_INFRA1(CK_INFRA_SPI0_HCK_CK, "infra_spi0_hck", CK_INFRA_SYSAXI_D2,
 		    13),
-	GATE_INFRA1(CK_INFRA_SPI1_HCK_CK, "infra_spi1_hck", CK_INFRA_66M_MCK,
+	GATE_INFRA1(CK_INFRA_SPI1_HCK_CK, "infra_spi1_hck", CK_INFRA_SYSAXI_D2,
 		    14),
 	GATE_INFRA1(CK_INFRA_FRTC_CK, "infra_frtc", CK_INFRA_RTC_32K, 15),
 	GATE_INFRA1(CK_INFRA_MSDC_CK, "infra_msdc", CK_INFRA_FMSDC_CK, 16),
diff --git a/include/dt-bindings/clock/mt7986-clk.h b/include/dt-bindings/clock/mt7986-clk.h
index 30720f9fb42..f45ef7afcc6 100644
--- a/include/dt-bindings/clock/mt7986-clk.h
+++ b/include/dt-bindings/clock/mt7986-clk.h
@@ -16,7 +16,7 @@
 #define CK_INFRA_I2C			3
 #define CK_INFRA_ISPI1			4
 #define CK_INFRA_PWM			5
-#define CK_INFRA_66M_MCK		6
+#define CK_INFRA_SYSAXI_D2		6
 #define CK_INFRA_CK_F32K		7
 #define CK_INFRA_PCIE_CK		8
 #define CK_INFRA_PWM_BCK		9
-- 
2.45.2

