Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818AAC197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 09:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEDF58748B;
	Thu, 16 Nov 2023 10:00:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GkAewv0h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39FE787465; Thu, 16 Nov 2023 10:00:05 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7D3987478
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 09:59:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53e751aeb3cso762181a12.2
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 00:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700125191; x=1700729991; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KE2nH/+TRn1RT60G9cDSadRAcNlO/tgTcDfwFVLQiy4=;
 b=GkAewv0hY6FvvtAp78TOsjuk2jtiHiCpH1dJrz3kgnXnlALjQN9yae3cCrNkhOtLk+
 gPx60yrMCab0wfMUjNLG//0e3T6ph54oTkfqZ+Hqnv/jyQjKIELGeMow9g64aEIL2Wa1
 sH/Kgp/B1bvnlHlgbCiW99O5GOfpcto8Yoa/qaN4+gmMXFjTtdfOXTXBYYwFmYtolTdN
 Lb65Cyk+aaOwzEuNkhJysWdDyPWQbv1YNX8xPztFL5sBW6Uh5MRob3j4KApRgF4sC0BM
 WiG6dD0VYqkZmcBJ+W+REzkiistcgN7t5prTfqCf1BAh57uamJBOBy9W/siuz1KiQypp
 0Sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700125191; x=1700729991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KE2nH/+TRn1RT60G9cDSadRAcNlO/tgTcDfwFVLQiy4=;
 b=UsPyaJgzL4san9siFQcGs7QuVQ6AwPjYeH3gPIdsa1GtBTPe9qAZpCVrrDbNC7GY+i
 iCVv/XyXSGzGfz5BRlcaqUvA3t0X2BQ7TIExJjSkU34RLyqgGS6g2Z0uLjy3lep0NFKT
 lBkrtq13q+CbNOK/1zuTYWJejZfHlE5PdywjZ/0SkBrp1/yDs6IXlix+MATUKaZlLkhL
 jJNBuWBnJjMXyHGtOHpul9Q7CGjjicwLqNxMC47YSOjVrNgHPnVputTAiI1jlIr+OECP
 ygJ3J6sbimNjIJFvjfcxqrZDSdoePo4Qgl1OjPB96zH1mmTbWKtZ1DA9iPq/prhrZgc0
 YZyw==
X-Gm-Message-State: AOJu0YyFwf4gHkjff8RZiVuLQlN9DrDB2YDcSXWoTWdgc3jYx+MoD5j+
 hsI51zUC6WwESZWsMLT4hZvmtGdQOTo=
X-Google-Smtp-Source: AGHT+IG6OvaftiQ9RHQ3QWJMiH3UHNR1F8/E4j3SaXBj/Z1JuUzGPuFS5C4owRMT9jrpzF+pXAUN8Q==
X-Received: by 2002:a17:906:b182:b0:9c0:2897:1588 with SMTP id
 w2-20020a170906b18200b009c028971588mr11055777ejy.17.1700125191269; 
 Thu, 16 Nov 2023 00:59:51 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 o21-20020a170906601500b009e655c77a53sm8093259ejj.132.2023.11.16.00.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 00:59:50 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/3] ARM: tegra30: clock: implement PLLD2 support
Date: Thu, 16 Nov 2023 10:59:30 +0200
Message-Id: <20231116085931.411707-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231116085931.411707-1-clamor95@gmail.com>
References: <20231116085931.411707-1-clamor95@gmail.com>
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

PLLD2 is a simple clock (controlled by 2 registers) and appears starting
from T30. Primary use of PLLD2 is as main HDMI clock parent.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/include/asm/arch-tegra/clk_rst.h        | 3 +--
 arch/arm/include/asm/arch-tegra30/clock-tables.h | 2 +-
 arch/arm/mach-tegra/clock.c                      | 3 +++
 arch/arm/mach-tegra/tegra30/clock.c              | 7 +++++++
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/arch-tegra/clk_rst.h b/arch/arm/include/asm/arch-tegra/clk_rst.h
index 2359e142fb..04910d594e 100644
--- a/arch/arm/include/asm/arch-tegra/clk_rst.h
+++ b/arch/arm/include/asm/arch-tegra/clk_rst.h
@@ -174,8 +174,7 @@ struct clk_rst_ctlr {
 	uint crc_audio_sync_clk_i2s4;	/* _AUDIO_SYNC_CLK_I2S4_0, 0x4B0 */
 	uint crc_audio_sync_clk_spdif;	/* _AUDIO_SYNC_CLK_SPDIF_0, 0x4B4 */
 
-	uint crc_plld2_base;		/* _PLLD2_BASE_0, 0x4B8 */
-	uint crc_plld2_misc;		/* _PLLD2_MISC_0, 0x4BC */
+	struct clk_pll_simple plld2;	/* _PLLD2_BASE_0, 0x4B8 */
 	uint crc_utmip_pll_cfg3;	/* _UTMIP_PLL_CFG3_0, 0x4C0 */
 	uint crc_pllrefe_base;		/* _PLLREFE_BASE_0, 0x4C4 */
 	uint crc_pllrefe_misc;		/* _PLLREFE_MISC_0, 0x4C8 */
diff --git a/arch/arm/include/asm/arch-tegra30/clock-tables.h b/arch/arm/include/asm/arch-tegra30/clock-tables.h
index 6c899ff64c..5ebcbc2c9a 100644
--- a/arch/arm/include/asm/arch-tegra30/clock-tables.h
+++ b/arch/arm/include/asm/arch-tegra30/clock-tables.h
@@ -23,6 +23,7 @@ enum clock_id {
 	CLOCK_ID_XCPU = CLOCK_ID_FIRST_SIMPLE,
 	CLOCK_ID_EPCI,
 	CLOCK_ID_SFROM32KHZ,
+	CLOCK_ID_DISPLAY2,
 
 	/* These are the base clocks (inputs to the Tegra SOC) */
 	CLOCK_ID_32KHZ,
@@ -30,7 +31,6 @@ enum clock_id {
 	CLOCK_ID_CLK_M,
 
 	CLOCK_ID_COUNT,	/* number of PLLs */
-	CLOCK_ID_DISPLAY2,	/* Tegra3, placeholder */
 	CLOCK_ID_NONE = -1,
 };
 
diff --git a/arch/arm/mach-tegra/clock.c b/arch/arm/mach-tegra/clock.c
index 7f31630a23..575da2bdb5 100644
--- a/arch/arm/mach-tegra/clock.c
+++ b/arch/arm/mach-tegra/clock.c
@@ -768,6 +768,9 @@ void clock_init(void)
 	pll_rate[CLOCK_ID_SFROM32KHZ] = 32768;
 	pll_rate[CLOCK_ID_OSC] = clock_get_rate(CLOCK_ID_OSC);
 	pll_rate[CLOCK_ID_CLK_M] = clock_get_rate(CLOCK_ID_CLK_M);
+#ifndef CONFIG_TEGRA20
+	pll_rate[CLOCK_ID_DISPLAY2] = clock_get_rate(CLOCK_ID_DISPLAY2);
+#endif
 
 	debug("Osc = %d\n", pll_rate[CLOCK_ID_OSC]);
 	debug("CLKM = %d\n", pll_rate[CLOCK_ID_CLK_M]);
diff --git a/arch/arm/mach-tegra/tegra30/clock.c b/arch/arm/mach-tegra/tegra30/clock.c
index 7bbe70921f..0af8cde8c6 100644
--- a/arch/arm/mach-tegra/tegra30/clock.c
+++ b/arch/arm/mach-tegra/tegra30/clock.c
@@ -438,6 +438,8 @@ struct clk_pll_info tegra_pll_info_table[CLOCK_ID_PLL_COUNT] = {
 	  .lock_ena = 9,  .lock_det = 11, .kcp_shift = 6, .kcp_mask = 3, .kvco_shift = 0, .kvco_mask = 1 },	/* PLLE */
 	{ .m_shift = 0, .m_mask = 0x0F, .n_shift = 8, .n_mask = 0x3FF, .p_shift = 20, .p_mask = 0x07,
 	  .lock_ena = 18, .lock_det = 27, .kcp_shift = 8, .kcp_mask = 0xF, .kvco_shift = 4, .kvco_mask = 0xF },	/* PLLS (RESERVED) */
+	{ .m_shift = 0, .m_mask = 0x1F, .n_shift = 8, .n_mask = 0x3FF, .p_shift = 20, .p_mask = 0x07,
+	  .lock_ena = 22, .lock_det = 27, .kcp_shift = 8, .kcp_mask = 0xF, .kvco_shift = 4, .kvco_mask = 0xF },	/* PLLD2 */
 };
 
 /*
@@ -654,6 +656,9 @@ enum clock_id clk_id_to_pll_id(int clk_id)
 	case TEGRA30_CLK_PLL_D:
 	case TEGRA30_CLK_PLL_D_OUT0:
 		return CLOCK_ID_DISPLAY;
+	case TEGRA30_CLK_PLL_D2:
+	case TEGRA30_CLK_PLL_D2_OUT0:
+		return CLOCK_ID_DISPLAY2;
 	case TEGRA30_CLK_PLL_X:
 		return CLOCK_ID_XCPU;
 	case TEGRA30_CLK_PLL_E:
@@ -881,6 +886,8 @@ struct clk_pll_simple *clock_get_simple_pll(enum clock_id clkid)
 	case CLOCK_ID_EPCI:
 	case CLOCK_ID_SFROM32KHZ:
 		return &clkrst->crc_pll_simple[clkid - CLOCK_ID_FIRST_SIMPLE];
+	case CLOCK_ID_DISPLAY2:
+		return &clkrst->plld2;
 	default:
 		return NULL;
 	}
-- 
2.40.1

