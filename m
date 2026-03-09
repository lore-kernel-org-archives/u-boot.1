Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E83FCA192
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 21:31:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2E4584020;
	Mon,  9 Mar 2026 22:29:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="McVHJ/oo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AE3E83A8C; Mon,  9 Mar 2026 22:29:41 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85DF283F6D
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 22:29:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-466ebbf7ff7so647508b6e.1
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 14:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773091773; x=1773696573;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ApFQPn96l/rdg9920o3tBS0di25EyoFJ1Acgg0Di0zw=;
 b=McVHJ/oo3N6K7c5S4IDmUK58rdtlYSUqsAzCNCoyhJ5uObH1Szulq3329xmI3jvMDT
 ZYK6uf7iDXhhoe0YQWs/e5iQPIZcLEefV6FrA4ps5eOUtyl+tKXCKW5+husdYErjdLBe
 wk3YYHW08e2nBHE2s+V85NIpWiqD5vzxTqO1hyxRuJjpTEpnamKe4JJXg69EkNXSIgUo
 Ti6oSCDwCeja1T0Dqy4/RQ2Yh6kWHcBzV+a1vY5wEjUhaKNFWJooFR9LNOhUbwbxUBcm
 ZVRUULuvwQBedsxw94KWrMejSEsUff83yZ7YWCa3pfYnjSK3EZi377l0gFS6OYj7YvHC
 GRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773091773; x=1773696573;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ApFQPn96l/rdg9920o3tBS0di25EyoFJ1Acgg0Di0zw=;
 b=RlEQdKhMGrg8TYgJ/o+q7QOG0qAPfnKmGbEwuZtl03GJn5V+hnFl39bgzWl918NgO8
 Ow2Mb1DyMOtUwVFv9S8/VX6wLht3guqPZO4A9q+2B2+b0ViYTmnMnw0fCnTvO8O4igTo
 ptLOFDu3jEKAV2wlGwkkwH+mWXnnpgCBmwjdBcNsCE7MbqXNWguygFPO2SonOfrIAxu9
 wxKfSJf/g+0V80SGy+5Os+nc84Grz5HTiE0WrWB98Gq/BLGqR1Cy/b3xc2UmcgOzUk0A
 avlb7bf5xEQiPcseruVhe1I+2SY4jiYxVFiSoGbDOwCFC+6to8oDRhMmlzz7XrMSFznf
 KNjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3nGsw51DwPMdYiFW8u+tf4FuOY5zXWJu6h3ThkcjI8n2D/C5Q5q4uqnM3lGs8Eq3S4kFEd/A=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4d4wLAj7RJW+5UnEjQ5/5guhV9bD69oYkK63hCEmUp9/fEM7S
 meQNML8S8HfYpNb4AGWegjNoZsQTIyVGA/320R1kEoesMeLBiB88J8RIhjan1hUaUPs3sHZD7tz
 nqUs/
X-Gm-Gg: ATEYQzw7x0d9WgB7rzixcvPiVwgJPy96jb6G59SHW3mFIwhmdH3sPV4diPNbXxkTd0/
 XF2GLvPdKIhmjygdCG7nSfoK4wi7sx9feg3QfCU0ZGtCSkyLtpoFt8t8I5S+WhVvCeX/H/NE2t+
 GgqQHn7oPLgJMgPLKrW1aVixNSXP++amDL0B2OLbZ8YKk7/pUKfFRfBk/E8y78h8miuFD/vGRK4
 X55DTk7i9FbCZhRPSvKMTucM3wuG5FTdeZl8d1AnrCN7rp71JEZLT9HAd7FZYbd6/BnpCoqKYSt
 JxXKI2IvpWotFZA2ET+VDlbdzURbq8kc3ujyaPFf2Ddk6sXwekp3+NRo6qzjA5u0E2qo539xO7t
 syIV2mM76OrhxC5dXtSe3bsFszDQde82yoazjdsnj1ZGo2pFftjAT7M+yBDwTIrhsVF7ENtcmV8
 iYxqaBoWIM2xgdThkc/rlgHK9/nQ==
X-Received: by 2002:a05:6808:f94:b0:467:3f4:9073 with SMTP id
 5614622812f47-46703f4f85dmr2914999b6e.16.1773091772583; 
 Mon, 09 Mar 2026 14:29:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:77:c35f:9c1b:c75f])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41756b47f0asm826221fac.8.2026.03.09.14.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 14:29:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 09 Mar 2026 16:27:47 -0500
Subject: [PATCH v2 12/13] clk: mediatek: remove CLK_PARENT_MIXED flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-clk-mtk-unify-mux-parents-v2-12-b084ea74b99d@baylibre.com>
References: <20260309-clk-mtk-unify-mux-parents-v2-0-b084ea74b99d@baylibre.com>
In-Reply-To: <20260309-clk-mtk-unify-mux-parents-v2-0-b084ea74b99d@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=101521;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=F8QV6Pm8hMZU4AH3vQmbju7YFLXYSL4AS9Qyt3DP2Cc=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBprzudWy441sqLCtwcX/4cu7LeTbih2msdWjuz/
 OexGS0VJluJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaa87nRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AtlAH/0mYoAzaesyszzVKR5RcRxYxS1M9THD1+u+SLXz
 zylpbHzt3Ok4zHz/ddICxD360SdAUEHSQvdvF7oQUqq9WHBXbWuNCNY4mxwY1F+ktpekyOqirQo
 4yuLbJNni20AdUx0ikdDRU23Mug9EoeitbiNUIrc4/9Samagh9SPEhMRSATLGmFFT/DkmCXfZoy
 yG3eZ/WrrVulvNMsKG3L4kGX3pDytRvgxX7FAPRYjAoFaThRrRvwAsA9LSIMb1hVgsqjvXYC7wz
 UF2+yAGDjaTfxrSKoKeU9hYuMv0voKWfGDWVV24kk70tydSB43TvjS+iWXdU/SpXNeo3VSt6w//
 /1lU=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Remove CLK_PARENT_MIXED and all dead code paths related to it.

All mux clocks have been converted to use struct mtk_parent (the
parent_flags field of the parent/parent_flags union). Use of this
struct was indicated by CLK_PARENT_MIXED. Now, this is always the case
and we can drop the flag and the union. All MUX_MIXED* macros are
change to use the equivalent MUX* macros since we no longer need to
set the flag.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c |  79 +++++++------
 drivers/clk/mediatek/clk-mt7623.c | 147 ++++++++++++------------
 drivers/clk/mediatek/clk-mt7629.c |  71 ++++++------
 drivers/clk/mediatek/clk-mt7981.c |   9 +-
 drivers/clk/mediatek/clk-mt7986.c |  10 +-
 drivers/clk/mediatek/clk-mt7987.c |   8 +-
 drivers/clk/mediatek/clk-mt7988.c |   9 +-
 drivers/clk/mediatek/clk-mt8183.c |  84 +++++++-------
 drivers/clk/mediatek/clk-mt8188.c | 182 +++++++++++++++---------------
 drivers/clk/mediatek/clk-mt8189.c |  12 +-
 drivers/clk/mediatek/clk-mt8195.c | 232 +++++++++++++++++++-------------------
 drivers/clk/mediatek/clk-mt8365.c |  86 +++++++-------
 drivers/clk/mediatek/clk-mt8512.c |  90 +++++++--------
 drivers/clk/mediatek/clk-mt8516.c |  86 +++++++-------
 drivers/clk/mediatek/clk-mt8518.c | 118 +++++++++----------
 drivers/clk/mediatek/clk-mtk.c    |  66 +++--------
 drivers/clk/mediatek/clk-mtk.h    |  62 +---------
 17 files changed, 632 insertions(+), 719 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 0207646ff78..e9a3f8ef0ba 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -330,60 +330,59 @@ static const struct mtk_parent apll1_ck_parents[] = {
 
 static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_0 */
-	MUX_GATE_MIXED(CLK_TOP_AXI_SEL, axi_parents, 0x40, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_MEM_SEL, mem_parents, 0x40, 8, 1, 15),
-	MUX_GATE_MIXED(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x40, 16, 1, 23),
-	MUX_GATE_MIXED(CLK_TOP_ETH_SEL, eth_parents, 0x40, 24, 3, 31),
+	MUX_GATE(CLK_TOP_AXI_SEL, axi_parents, 0x40, 0, 3, 7),
+	MUX_GATE(CLK_TOP_MEM_SEL, mem_parents, 0x40, 8, 1, 15),
+	MUX_GATE(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x40, 16, 1, 23),
+	MUX_GATE(CLK_TOP_ETH_SEL, eth_parents, 0x40, 24, 3, 31),
 
 	/* CLK_CFG_1 */
-	MUX_GATE_MIXED(CLK_TOP_PWM_SEL, pwm_parents, 0x50, 0, 2, 7),
-	MUX_GATE_MIXED(CLK_TOP_F10M_REF_SEL, f10m_ref_parents, 0x50, 8, 1, 15),
-	MUX_GATE_MIXED(CLK_TOP_NFI_INFRA_SEL, nfi_infra_parents, 0x50, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_FLASH_SEL, flash_parents, 0x50, 24, 3, 31),
+	MUX_GATE(CLK_TOP_PWM_SEL, pwm_parents, 0x50, 0, 2, 7),
+	MUX_GATE(CLK_TOP_F10M_REF_SEL, f10m_ref_parents, 0x50, 8, 1, 15),
+	MUX_GATE(CLK_TOP_NFI_INFRA_SEL, nfi_infra_parents, 0x50, 16, 4, 23),
+	MUX_GATE(CLK_TOP_FLASH_SEL, flash_parents, 0x50, 24, 3, 31),
 
 	/* CLK_CFG_2 */
-	MUX_GATE_MIXED(CLK_TOP_UART_SEL, uart_parents, 0x60, 0, 1, 7),
-	MUX_GATE_MIXED(CLK_TOP_SPI0_SEL, spi0_parents, 0x60, 8, 3, 15),
-	MUX_GATE_MIXED(CLK_TOP_SPI1_SEL, spi1_parents, 0x60, 16, 3, 23),
-	MUX_GATE_MIXED(CLK_TOP_MSDC50_0_SEL, uart_parents, 0x60, 24, 3, 31),
+	MUX_GATE(CLK_TOP_UART_SEL, uart_parents, 0x60, 0, 1, 7),
+	MUX_GATE(CLK_TOP_SPI0_SEL, spi0_parents, 0x60, 8, 3, 15),
+	MUX_GATE(CLK_TOP_SPI1_SEL, spi1_parents, 0x60, 16, 3, 23),
+	MUX_GATE(CLK_TOP_MSDC50_0_SEL, uart_parents, 0x60, 24, 3, 31),
 
 	/* CLK_CFG_3 */
-	MUX_GATE_MIXED(CLK_TOP_MSDC30_0_SEL, msdc30_0_parents, 0x70, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_MSDC30_1_SEL, msdc30_0_parents, 0x70, 8, 3, 15),
-	MUX_GATE_MIXED(CLK_TOP_A1SYS_HP_SEL, a1sys_hp_parents, 0x70, 16, 3, 23),
-	MUX_GATE_MIXED(CLK_TOP_A2SYS_HP_SEL, a1sys_hp_parents, 0x70, 24, 3, 31),
+	MUX_GATE(CLK_TOP_MSDC30_0_SEL, msdc30_0_parents, 0x70, 0, 3, 7),
+	MUX_GATE(CLK_TOP_MSDC30_1_SEL, msdc30_0_parents, 0x70, 8, 3, 15),
+	MUX_GATE(CLK_TOP_A1SYS_HP_SEL, a1sys_hp_parents, 0x70, 16, 3, 23),
+	MUX_GATE(CLK_TOP_A2SYS_HP_SEL, a1sys_hp_parents, 0x70, 24, 3, 31),
 
 	/* CLK_CFG_4 */
-	MUX_GATE_MIXED(CLK_TOP_INTDIR_SEL, intdir_parents, 0x80, 0, 2, 7),
-	MUX_GATE_MIXED(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents, 0x80, 8, 2, 15),
-	MUX_GATE_MIXED(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x80, 16, 3, 23),
-	MUX_GATE_MIXED(CLK_TOP_SCP_SEL, ddrphycfg_parents, 0x80, 24, 2, 31),
+	MUX_GATE(CLK_TOP_INTDIR_SEL, intdir_parents, 0x80, 0, 2, 7),
+	MUX_GATE(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents, 0x80, 8, 2, 15),
+	MUX_GATE(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x80, 16, 3, 23),
+	MUX_GATE(CLK_TOP_SCP_SEL, ddrphycfg_parents, 0x80, 24, 2, 31),
 
 	/* CLK_CFG_5 */
-	MUX_GATE_MIXED(CLK_TOP_ATB_SEL, atb_parents, 0x90, 0, 2, 7),
-	MUX_GATE_MIXED_FLAGS(CLK_TOP_HIF_SEL, eth_parents, 0x90, 8, 3, 15,
-			     CLK_MUX_DOMAIN_SCPSYS),
-	MUX_GATE_MIXED(CLK_TOP_AUDIO_SEL, audio_parents, 0x90, 16, 2, 23),
-	MUX_GATE_MIXED(CLK_TOP_U2_SEL, usb20_parents, 0x90, 24, 2, 31),
+	MUX_GATE(CLK_TOP_ATB_SEL, atb_parents, 0x90, 0, 2, 7),
+	MUX_GATE_FLAGS(CLK_TOP_HIF_SEL, eth_parents, 0x90, 8, 3, 15, CLK_MUX_DOMAIN_SCPSYS),
+	MUX_GATE(CLK_TOP_AUDIO_SEL, audio_parents, 0x90, 16, 2, 23),
+	MUX_GATE(CLK_TOP_U2_SEL, usb20_parents, 0x90, 24, 2, 31),
 
 	/* CLK_CFG_6 */
-	MUX_GATE_MIXED(CLK_TOP_AUD1_SEL, aud1_parents, 0xA0, 0, 1, 7),
-	MUX_GATE_MIXED(CLK_TOP_AUD2_SEL, aud1_parents, 0xA0, 8, 1, 15),
-	MUX_GATE_MIXED(CLK_TOP_IRRX_SEL, f10m_ref_parents, 0xA0, 16, 1, 23),
-	MUX_GATE_MIXED(CLK_TOP_IRTX_SEL, f10m_ref_parents, 0xA0, 24, 1, 31),
+	MUX_GATE(CLK_TOP_AUD1_SEL, aud1_parents, 0xA0, 0, 1, 7),
+	MUX_GATE(CLK_TOP_AUD2_SEL, aud1_parents, 0xA0, 8, 1, 15),
+	MUX_GATE(CLK_TOP_IRRX_SEL, f10m_ref_parents, 0xA0, 16, 1, 23),
+	MUX_GATE(CLK_TOP_IRTX_SEL, f10m_ref_parents, 0xA0, 24, 1, 31),
 
 	/* CLK_CFG_7 */
-	MUX_GATE_MIXED(CLK_TOP_ASM_L_SEL, asm_l_parents, 0xB0, 0, 2, 7),
-	MUX_GATE_MIXED(CLK_TOP_ASM_M_SEL, asm_l_parents, 0xB0, 8, 2, 15),
-	MUX_GATE_MIXED(CLK_TOP_ASM_H_SEL, asm_l_parents, 0xB0, 16, 2, 23),
+	MUX_GATE(CLK_TOP_ASM_L_SEL, asm_l_parents, 0xB0, 0, 2, 7),
+	MUX_GATE(CLK_TOP_ASM_M_SEL, asm_l_parents, 0xB0, 8, 2, 15),
+	MUX_GATE(CLK_TOP_ASM_H_SEL, asm_l_parents, 0xB0, 16, 2, 23),
 
 	/* CLK_AUDDIV_0 */
-	MUX_MIXED(CLK_TOP_APLL1_SEL, apll1_ck_parents, 0x120, 6, 1),
-	MUX_MIXED(CLK_TOP_APLL2_SEL, apll1_ck_parents, 0x120, 7, 1),
-	MUX_MIXED(CLK_TOP_I2S0_MCK_SEL, apll1_ck_parents, 0x120, 8, 1),
-	MUX_MIXED(CLK_TOP_I2S1_MCK_SEL, apll1_ck_parents, 0x120, 9, 1),
-	MUX_MIXED(CLK_TOP_I2S2_MCK_SEL, apll1_ck_parents, 0x120, 10, 1),
-	MUX_MIXED(CLK_TOP_I2S3_MCK_SEL, apll1_ck_parents, 0x120, 161, 1),
+	MUX(CLK_TOP_APLL1_SEL, apll1_ck_parents, 0x120, 6, 1),
+	MUX(CLK_TOP_APLL2_SEL, apll1_ck_parents, 0x120, 7, 1),
+	MUX(CLK_TOP_I2S0_MCK_SEL, apll1_ck_parents, 0x120, 8, 1),
+	MUX(CLK_TOP_I2S1_MCK_SEL, apll1_ck_parents, 0x120, 9, 1),
+	MUX(CLK_TOP_I2S2_MCK_SEL, apll1_ck_parents, 0x120, 10, 1),
+	MUX(CLK_TOP_I2S3_MCK_SEL, apll1_ck_parents, 0x120, 161, 1),
 };
 
 /* infracfg */
@@ -396,7 +395,7 @@ static const struct mtk_parent infra_mux1_parents[] = {
 };
 
 static const struct mtk_composite infra_muxes[] = {
-	MUX_MIXED(CLK_INFRA_MUX1_SEL, infra_mux1_parents, 0x000, 2, 2),
+	MUX(CLK_INFRA_MUX1_SEL, infra_mux1_parents, 0x000, 2, 2),
 };
 
 static const struct mtk_gate_regs infra_cg_regs = {
@@ -429,7 +428,7 @@ static const struct mtk_parent peribus_ck_parents[] = {
 };
 
 static const struct mtk_composite peri_muxes[] = {
-	MUX_MIXED(CLK_PERIBUS_SEL, peribus_ck_parents, 0x05c, 0, 1),
+	MUX(CLK_PERIBUS_SEL, peribus_ck_parents, 0x05c, 0, 1),
 };
 
 static const struct mtk_gate_regs peri0_cg_regs = {
diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index 9bb2a1af734..9e1522d4615 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -697,77 +697,74 @@ static const struct mtk_parent aud_src_parents[] = {
 };
 
 static const struct mtk_composite top_muxes[] = {
-	MUX_GATE_MIXED(CLK_TOP_AXI_SEL, axi_parents, 0x40, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_MEM_SEL, mem_parents, 0x40, 8, 1, 15),
-	MUX_GATE_MIXED(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x40, 16, 1, 23),
-	MUX_GATE_MIXED_FLAGS(CLK_TOP_MM_SEL, mm_parents, 0x40, 24, 3, 31,
-			     CLK_MUX_DOMAIN_SCPSYS),
-
-	MUX_GATE_MIXED(CLK_TOP_PWM_SEL, pwm_parents, 0x50, 0, 2, 7),
-	MUX_GATE_MIXED(CLK_TOP_VDEC_SEL, vdec_parents, 0x50, 8, 4, 15),
-	MUX_GATE_MIXED_FLAGS(CLK_TOP_MFG_SEL, mfg_parents, 0x50, 16, 3, 23,
-			     CLK_MUX_DOMAIN_SCPSYS),
-	MUX_GATE_MIXED(CLK_TOP_CAMTG_SEL, camtg_parents, 0x50, 24, 3, 31),
-
-	MUX_GATE_MIXED(CLK_TOP_UART_SEL, uart_parents, 0x60, 0, 1, 7),
-	MUX_GATE_MIXED(CLK_TOP_SPI0_SEL, spi_parents, 0x60, 8, 3, 15),
-	MUX_GATE_MIXED(CLK_TOP_USB20_SEL, usb20_parents, 0x60, 16, 2, 23),
-	MUX_GATE_MIXED(CLK_TOP_MSDC30_0_SEL, msdc30_parents, 0x60, 24, 3, 31),
-
-	MUX_GATE_MIXED(CLK_TOP_MSDC30_1_SEL, msdc30_parents, 0x70, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_MSDC30_2_SEL, msdc30_parents, 0x70, 8, 3, 15),
-	MUX_GATE_MIXED(CLK_TOP_AUDIO_SEL, msdc30_parents, 0x70, 16, 1, 23),
-	MUX_GATE_MIXED(CLK_TOP_AUDINTBUS_SEL, aud_intbus_parents, 0x70, 24, 3, 31),
-
-	MUX_GATE_MIXED(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x80, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_SCP_SEL, scp_parents, 0x80, 8, 2, 15),
-	MUX_GATE_MIXED(CLK_TOP_DPI0_SEL, dpi0_tve_parents, 0x80, 16, 3, 23),
-	MUX_GATE_MIXED(CLK_TOP_DPI1_SEL, dpi1_parents, 0x80, 24, 2, 31),
-
-	MUX_GATE_MIXED(CLK_TOP_TVE_SEL, dpi0_tve_parents, 0x90, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_HDMI_SEL, hdmi_parents, 0x90, 8, 2, 15),
-	MUX_GATE_MIXED(CLK_TOP_APLL_SEL, apll_parents, 0x90, 16, 3, 23),
-
-	MUX_GATE_MIXED(CLK_TOP_RTC_SEL, rtc_parents, 0xA0, 0, 2, 7),
-	MUX_GATE_MIXED(CLK_TOP_NFI2X_SEL, nfi2x_parents, 0xA0, 8, 3, 15),
-	MUX_GATE_MIXED(CLK_TOP_EMMC_HCLK_SEL, emmc_hclk_parents, 0xA0, 24, 2, 31),
-
-	MUX_GATE_MIXED(CLK_TOP_FLASH_SEL, flash_parents, 0xB0, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_DI_SEL, di_parents, 0xB0, 8, 2, 15),
-	MUX_GATE_MIXED(CLK_TOP_NR_SEL, nr_osd_parents, 0xB0, 16, 3, 23),
-	MUX_GATE_MIXED(CLK_TOP_OSD_SEL, nr_osd_parents, 0xB0, 24, 3, 31),
-
-	MUX_GATE_MIXED(CLK_TOP_HDMIRX_BIST_SEL, hdmirx_bist_parents, 0xC0, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_INTDIR_SEL, intdir_parents, 0xC0, 8, 2, 15),
-	MUX_GATE_MIXED(CLK_TOP_ASM_I_SEL, asm_parents, 0xC0, 16, 2, 23),
-	MUX_GATE_MIXED(CLK_TOP_ASM_M_SEL, asm_parents, 0xC0, 24, 3, 31),
-
-	MUX_GATE_MIXED(CLK_TOP_ASM_H_SEL, asm_parents, 0xD0, 0, 2, 7),
-	MUX_GATE_MIXED(CLK_TOP_MS_CARD_SEL, ms_card_parents, 0xD0, 16, 2, 23),
-	MUX_GATE_MIXED_FLAGS(CLK_TOP_ETHIF_SEL, ethif_parents, 0xD0, 24, 3, 31,
-			     CLK_MUX_DOMAIN_SCPSYS),
-
-	MUX_GATE_MIXED(CLK_TOP_HDMIRX26_24_SEL, hdmirx_parents, 0xE0, 0, 1, 7),
-	MUX_GATE_MIXED(CLK_TOP_MSDC30_3_SEL, msdc30_parents, 0xE0, 8, 3, 15),
-	MUX_GATE_MIXED(CLK_TOP_CMSYS_SEL, cmsys_parents, 0xE0, 16, 4, 23),
-
-	MUX_GATE_MIXED(CLK_TOP_SPI1_SEL, spi_parents, 0xE0, 24, 3, 31),
-	MUX_GATE_MIXED(CLK_TOP_SPI2_SEL, spi_parents, 0xF0, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_8BDAC_SEL, clk_8bdac_parents, 0xF0, 8, 2, 15),
-	MUX_GATE_MIXED(CLK_TOP_AUD2DVD_SEL, aud2dvd_parents, 0xF0, 16, 1, 23),
-
-	MUX_MIXED(CLK_TOP_PADMCLK_SEL, padmclk_parents, 0x100, 0, 3),
-
-	MUX_MIXED(CLK_TOP_AUD_MUX1_SEL, aud_mux_parents, 0x12c, 0, 3),
-	MUX_MIXED(CLK_TOP_AUD_MUX2_SEL, aud_mux_parents, 0x12c, 3, 3),
-	MUX_MIXED(CLK_TOP_AUDPLL_MUX_SEL, aud_mux_parents, 0x12c, 6, 3),
-
-	MUX_GATE_MIXED(CLK_TOP_AUD_K1_SRC_SEL, aud_src_parents, 0x12c, 15, 1, 23),
-	MUX_GATE_MIXED(CLK_TOP_AUD_K2_SRC_SEL, aud_src_parents, 0x12c, 16, 1, 24),
-	MUX_GATE_MIXED(CLK_TOP_AUD_K3_SRC_SEL, aud_src_parents, 0x12c, 17, 1, 25),
-	MUX_GATE_MIXED(CLK_TOP_AUD_K4_SRC_SEL, aud_src_parents, 0x12c, 18, 1, 26),
-	MUX_GATE_MIXED(CLK_TOP_AUD_K5_SRC_SEL, aud_src_parents, 0x12c, 19, 1, 27),
-	MUX_GATE_MIXED(CLK_TOP_AUD_K6_SRC_SEL, aud_src_parents, 0x12c, 20, 1, 28),
+	MUX_GATE(CLK_TOP_AXI_SEL, axi_parents, 0x40, 0, 3, 7),
+	MUX_GATE(CLK_TOP_MEM_SEL, mem_parents, 0x40, 8, 1, 15),
+	MUX_GATE(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x40, 16, 1, 23),
+	MUX_GATE_FLAGS(CLK_TOP_MM_SEL, mm_parents, 0x40, 24, 3, 31, CLK_MUX_DOMAIN_SCPSYS),
+
+	MUX_GATE(CLK_TOP_PWM_SEL, pwm_parents, 0x50, 0, 2, 7),
+	MUX_GATE(CLK_TOP_VDEC_SEL, vdec_parents, 0x50, 8, 4, 15),
+	MUX_GATE_FLAGS(CLK_TOP_MFG_SEL, mfg_parents, 0x50, 16, 3, 23, CLK_MUX_DOMAIN_SCPSYS),
+	MUX_GATE(CLK_TOP_CAMTG_SEL, camtg_parents, 0x50, 24, 3, 31),
+
+	MUX_GATE(CLK_TOP_UART_SEL, uart_parents, 0x60, 0, 1, 7),
+	MUX_GATE(CLK_TOP_SPI0_SEL, spi_parents, 0x60, 8, 3, 15),
+	MUX_GATE(CLK_TOP_USB20_SEL, usb20_parents, 0x60, 16, 2, 23),
+	MUX_GATE(CLK_TOP_MSDC30_0_SEL, msdc30_parents, 0x60, 24, 3, 31),
+
+	MUX_GATE(CLK_TOP_MSDC30_1_SEL, msdc30_parents, 0x70, 0, 3, 7),
+	MUX_GATE(CLK_TOP_MSDC30_2_SEL, msdc30_parents, 0x70, 8, 3, 15),
+	MUX_GATE(CLK_TOP_AUDIO_SEL, msdc30_parents, 0x70, 16, 1, 23),
+	MUX_GATE(CLK_TOP_AUDINTBUS_SEL, aud_intbus_parents, 0x70, 24, 3, 31),
+
+	MUX_GATE(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x80, 0, 4, 7),
+	MUX_GATE(CLK_TOP_SCP_SEL, scp_parents, 0x80, 8, 2, 15),
+	MUX_GATE(CLK_TOP_DPI0_SEL, dpi0_tve_parents, 0x80, 16, 3, 23),
+	MUX_GATE(CLK_TOP_DPI1_SEL, dpi1_parents, 0x80, 24, 2, 31),
+
+	MUX_GATE(CLK_TOP_TVE_SEL, dpi0_tve_parents, 0x90, 0, 3, 7),
+	MUX_GATE(CLK_TOP_HDMI_SEL, hdmi_parents, 0x90, 8, 2, 15),
+	MUX_GATE(CLK_TOP_APLL_SEL, apll_parents, 0x90, 16, 3, 23),
+
+	MUX_GATE(CLK_TOP_RTC_SEL, rtc_parents, 0xA0, 0, 2, 7),
+	MUX_GATE(CLK_TOP_NFI2X_SEL, nfi2x_parents, 0xA0, 8, 3, 15),
+	MUX_GATE(CLK_TOP_EMMC_HCLK_SEL, emmc_hclk_parents, 0xA0, 24, 2, 31),
+
+	MUX_GATE(CLK_TOP_FLASH_SEL, flash_parents, 0xB0, 0, 3, 7),
+	MUX_GATE(CLK_TOP_DI_SEL, di_parents, 0xB0, 8, 2, 15),
+	MUX_GATE(CLK_TOP_NR_SEL, nr_osd_parents, 0xB0, 16, 3, 23),
+	MUX_GATE(CLK_TOP_OSD_SEL, nr_osd_parents, 0xB0, 24, 3, 31),
+
+	MUX_GATE(CLK_TOP_HDMIRX_BIST_SEL, hdmirx_bist_parents, 0xC0, 0, 3, 7),
+	MUX_GATE(CLK_TOP_INTDIR_SEL, intdir_parents, 0xC0, 8, 2, 15),
+	MUX_GATE(CLK_TOP_ASM_I_SEL, asm_parents, 0xC0, 16, 2, 23),
+	MUX_GATE(CLK_TOP_ASM_M_SEL, asm_parents, 0xC0, 24, 3, 31),
+
+	MUX_GATE(CLK_TOP_ASM_H_SEL, asm_parents, 0xD0, 0, 2, 7),
+	MUX_GATE(CLK_TOP_MS_CARD_SEL, ms_card_parents, 0xD0, 16, 2, 23),
+	MUX_GATE_FLAGS(CLK_TOP_ETHIF_SEL, ethif_parents, 0xD0, 24, 3, 31, CLK_MUX_DOMAIN_SCPSYS),
+
+	MUX_GATE(CLK_TOP_HDMIRX26_24_SEL, hdmirx_parents, 0xE0, 0, 1, 7),
+	MUX_GATE(CLK_TOP_MSDC30_3_SEL, msdc30_parents, 0xE0, 8, 3, 15),
+	MUX_GATE(CLK_TOP_CMSYS_SEL, cmsys_parents, 0xE0, 16, 4, 23),
+
+	MUX_GATE(CLK_TOP_SPI1_SEL, spi_parents, 0xE0, 24, 3, 31),
+	MUX_GATE(CLK_TOP_SPI2_SEL, spi_parents, 0xF0, 0, 3, 7),
+	MUX_GATE(CLK_TOP_8BDAC_SEL, clk_8bdac_parents, 0xF0, 8, 2, 15),
+	MUX_GATE(CLK_TOP_AUD2DVD_SEL, aud2dvd_parents, 0xF0, 16, 1, 23),
+
+	MUX(CLK_TOP_PADMCLK_SEL, padmclk_parents, 0x100, 0, 3),
+
+	MUX(CLK_TOP_AUD_MUX1_SEL, aud_mux_parents, 0x12c, 0, 3),
+	MUX(CLK_TOP_AUD_MUX2_SEL, aud_mux_parents, 0x12c, 3, 3),
+	MUX(CLK_TOP_AUDPLL_MUX_SEL, aud_mux_parents, 0x12c, 6, 3),
+
+	MUX_GATE(CLK_TOP_AUD_K1_SRC_SEL, aud_src_parents, 0x12c, 15, 1, 23),
+	MUX_GATE(CLK_TOP_AUD_K2_SRC_SEL, aud_src_parents, 0x12c, 16, 1, 24),
+	MUX_GATE(CLK_TOP_AUD_K3_SRC_SEL, aud_src_parents, 0x12c, 17, 1, 25),
+	MUX_GATE(CLK_TOP_AUD_K4_SRC_SEL, aud_src_parents, 0x12c, 18, 1, 26),
+	MUX_GATE(CLK_TOP_AUD_K5_SRC_SEL, aud_src_parents, 0x12c, 19, 1, 27),
+	MUX_GATE(CLK_TOP_AUD_K6_SRC_SEL, aud_src_parents, 0x12c, 20, 1, 28),
 };
 
 /* infracfg */
@@ -872,10 +869,10 @@ static const struct mtk_parent uart_ck_sel_parents[] = {
 };
 
 static const struct mtk_composite peri_muxes[] = {
-	MUX_MIXED(CLK_PERI_UART0_SEL, uart_ck_sel_parents, 0x40C, 0, 1),
-	MUX_MIXED(CLK_PERI_UART1_SEL, uart_ck_sel_parents, 0x40C, 1, 1),
-	MUX_MIXED(CLK_PERI_UART2_SEL, uart_ck_sel_parents, 0x40C, 2, 1),
-	MUX_MIXED(CLK_PERI_UART3_SEL, uart_ck_sel_parents, 0x40C, 3, 1),
+	MUX(CLK_PERI_UART0_SEL, uart_ck_sel_parents, 0x40C, 0, 1),
+	MUX(CLK_PERI_UART1_SEL, uart_ck_sel_parents, 0x40C, 1, 1),
+	MUX(CLK_PERI_UART2_SEL, uart_ck_sel_parents, 0x40C, 2, 1),
+	MUX(CLK_PERI_UART3_SEL, uart_ck_sel_parents, 0x40C, 3, 1),
 };
 
 static const struct mtk_gate_regs peri0_cg_regs = {
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index c675104d573..42670269d3e 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -365,58 +365,57 @@ static const struct mtk_parent gpt10m_parents[] = {
 
 static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_0 */
-	MUX_GATE_MIXED(CLK_TOP_AXI_SEL, axi_parents, 0x40, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_MEM_SEL, mem_parents, 0x40, 8, 1, 15),
-	MUX_GATE_MIXED(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x40, 16, 1, 23),
-	MUX_GATE_MIXED(CLK_TOP_ETH_SEL, eth_parents, 0x40, 24, 3, 31),
+	MUX_GATE(CLK_TOP_AXI_SEL, axi_parents, 0x40, 0, 3, 7),
+	MUX_GATE(CLK_TOP_MEM_SEL, mem_parents, 0x40, 8, 1, 15),
+	MUX_GATE(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x40, 16, 1, 23),
+	MUX_GATE(CLK_TOP_ETH_SEL, eth_parents, 0x40, 24, 3, 31),
 
 	/* CLK_CFG_1 */
-	MUX_GATE_MIXED(CLK_TOP_PWM_SEL, pwm_parents, 0x50, 0, 2, 7),
-	MUX_GATE_MIXED(CLK_TOP_F10M_REF_SEL, irrx_parents, 0x50, 8, 1, 15),
-	MUX_GATE_MIXED(CLK_TOP_NFI_INFRA_SEL, nfi_infra_parents, 0x50, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_FLASH_SEL, flash_parents, 0x50, 24, 3, 31),
+	MUX_GATE(CLK_TOP_PWM_SEL, pwm_parents, 0x50, 0, 2, 7),
+	MUX_GATE(CLK_TOP_F10M_REF_SEL, irrx_parents, 0x50, 8, 1, 15),
+	MUX_GATE(CLK_TOP_NFI_INFRA_SEL, nfi_infra_parents, 0x50, 16, 4, 23),
+	MUX_GATE(CLK_TOP_FLASH_SEL, flash_parents, 0x50, 24, 3, 31),
 
 	/* CLK_CFG_2 */
-	MUX_GATE_MIXED(CLK_TOP_UART_SEL, uart_parents, 0x60, 0, 1, 7),
-	MUX_GATE_MIXED(CLK_TOP_SPI0_SEL, spi0_parents, 0x60, 8, 3, 15),
-	MUX_GATE_MIXED(CLK_TOP_SPI1_SEL, spi1_parents, 0x60, 16, 3, 23),
-	MUX_GATE_MIXED(CLK_TOP_MSDC50_0_SEL, uart_parents, 0x60, 24, 3, 31),
+	MUX_GATE(CLK_TOP_UART_SEL, uart_parents, 0x60, 0, 1, 7),
+	MUX_GATE(CLK_TOP_SPI0_SEL, spi0_parents, 0x60, 8, 3, 15),
+	MUX_GATE(CLK_TOP_SPI1_SEL, spi1_parents, 0x60, 16, 3, 23),
+	MUX_GATE(CLK_TOP_MSDC50_0_SEL, uart_parents, 0x60, 24, 3, 31),
 
 	/* CLK_CFG_3 */
-	MUX_GATE_MIXED(CLK_TOP_MSDC30_0_SEL, msdc30_0_parents, 0x70, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_MSDC30_1_SEL, msdc30_1_parents, 0x70, 8, 3, 15),
-	MUX_GATE_MIXED(CLK_TOP_AP2WBMCU_SEL, ap2wbmcu_parents, 0x70, 16, 3, 23),
-	MUX_GATE_MIXED(CLK_TOP_AP2WBHIF_SEL, ap2wbmcu_parents, 0x70, 24, 3, 31),
+	MUX_GATE(CLK_TOP_MSDC30_0_SEL, msdc30_0_parents, 0x70, 0, 3, 7),
+	MUX_GATE(CLK_TOP_MSDC30_1_SEL, msdc30_1_parents, 0x70, 8, 3, 15),
+	MUX_GATE(CLK_TOP_AP2WBMCU_SEL, ap2wbmcu_parents, 0x70, 16, 3, 23),
+	MUX_GATE(CLK_TOP_AP2WBHIF_SEL, ap2wbmcu_parents, 0x70, 24, 3, 31),
 
 	/* CLK_CFG_4 */
-	MUX_GATE_MIXED(CLK_TOP_AUDIO_SEL, audio_parents, 0x80, 0, 2, 7),
-	MUX_GATE_MIXED(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents, 0x80, 8, 2, 15),
-	MUX_GATE_MIXED(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x80, 16, 3, 23),
-	MUX_GATE_MIXED(CLK_TOP_SCP_SEL, scp_parents, 0x80, 24, 2, 31),
+	MUX_GATE(CLK_TOP_AUDIO_SEL, audio_parents, 0x80, 0, 2, 7),
+	MUX_GATE(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents, 0x80, 8, 2, 15),
+	MUX_GATE(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x80, 16, 3, 23),
+	MUX_GATE(CLK_TOP_SCP_SEL, scp_parents, 0x80, 24, 2, 31),
 
 	/* CLK_CFG_5 */
-	MUX_GATE_MIXED(CLK_TOP_ATB_SEL, atb_parents, 0x90, 0, 2, 7),
-	MUX_GATE_MIXED_FLAGS(CLK_TOP_HIF_SEL, hif_parents, 0x90, 8, 3, 15,
-			     CLK_MUX_DOMAIN_SCPSYS),
-	MUX_GATE_MIXED(CLK_TOP_SATA_SEL, sata_parents, 0x90, 16, 1, 23),
-	MUX_GATE_MIXED(CLK_TOP_U2_SEL, usb20_parents, 0x90, 24, 2, 31),
+	MUX_GATE(CLK_TOP_ATB_SEL, atb_parents, 0x90, 0, 2, 7),
+	MUX_GATE_FLAGS(CLK_TOP_HIF_SEL, hif_parents, 0x90, 8, 3, 15, CLK_MUX_DOMAIN_SCPSYS),
+	MUX_GATE(CLK_TOP_SATA_SEL, sata_parents, 0x90, 16, 1, 23),
+	MUX_GATE(CLK_TOP_U2_SEL, usb20_parents, 0x90, 24, 2, 31),
 
 	/* CLK_CFG_6 */
-	MUX_GATE_MIXED(CLK_TOP_AUD1_SEL, aud1_parents, 0xA0, 0, 1, 7),
-	MUX_GATE_MIXED(CLK_TOP_AUD2_SEL, aud1_parents, 0xA0, 8, 1, 15),
-	MUX_GATE_MIXED(CLK_TOP_IRRX_SEL, irrx_parents, 0xA0, 16, 1, 23),
-	MUX_GATE_MIXED(CLK_TOP_IRTX_SEL, irrx_parents, 0xA0, 24, 1, 31),
+	MUX_GATE(CLK_TOP_AUD1_SEL, aud1_parents, 0xA0, 0, 1, 7),
+	MUX_GATE(CLK_TOP_AUD2_SEL, aud1_parents, 0xA0, 8, 1, 15),
+	MUX_GATE(CLK_TOP_IRRX_SEL, irrx_parents, 0xA0, 16, 1, 23),
+	MUX_GATE(CLK_TOP_IRTX_SEL, irrx_parents, 0xA0, 24, 1, 31),
 
 	/* CLK_CFG_7 */
-	MUX_GATE_MIXED(CLK_TOP_SATA_MCU_SEL, scp_parents, 0xB0, 0, 2, 7),
-	MUX_GATE_MIXED(CLK_TOP_PCIE0_MCU_SEL, scp_parents, 0xB0, 8, 2, 15),
-	MUX_GATE_MIXED(CLK_TOP_PCIE1_MCU_SEL, scp_parents, 0xB0, 16, 2, 23),
-	MUX_GATE_MIXED(CLK_TOP_SSUSB_MCU_SEL, scp_parents, 0xB0, 24, 2, 31),
+	MUX_GATE(CLK_TOP_SATA_MCU_SEL, scp_parents, 0xB0, 0, 2, 7),
+	MUX_GATE(CLK_TOP_PCIE0_MCU_SEL, scp_parents, 0xB0, 8, 2, 15),
+	MUX_GATE(CLK_TOP_PCIE1_MCU_SEL, scp_parents, 0xB0, 16, 2, 23),
+	MUX_GATE(CLK_TOP_SSUSB_MCU_SEL, scp_parents, 0xB0, 24, 2, 31),
 
 	/* CLK_CFG_8 */
-	MUX_GATE_MIXED(CLK_TOP_CRYPTO_SEL, crypto_parents, 0xC0, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_SGMII_REF_1_SEL, sgmii_ref_1_parents, 0xC0, 8, 1, 15),
-	MUX_GATE_MIXED(CLK_TOP_10M_SEL, gpt10m_parents, 0xC0, 16, 1, 23),
+	MUX_GATE(CLK_TOP_CRYPTO_SEL, crypto_parents, 0xC0, 0, 3, 7),
+	MUX_GATE(CLK_TOP_SGMII_REF_1_SEL, sgmii_ref_1_parents, 0xC0, 8, 1, 15),
+	MUX_GATE(CLK_TOP_10M_SEL, gpt10m_parents, 0xC0, 16, 1, 23),
 };
 
 /* infracfg */
diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index cdd9b9e4092..685abd844f2 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -336,9 +336,9 @@ static const struct mtk_parent usb_frmcnt_parents[] = {
 		.upd_shift = _upd, .mux_shift = _shift,                        \
 		.mux_mask = BIT(_width) - 1, .gate_reg = _mux_ofs,             \
 		.gate_shift = _gate,					       \
-		.parent_flags = _parents,				       \
+		.parent = _parents,					       \
 		.num_parents = ARRAY_SIZE(_parents),                           \
-		.flags = CLK_MUX_SETCLR_UPD | CLK_PARENT_MIXED,		       \
+		.flags = CLK_MUX_SETCLR_UPD,				       \
 	}
 
 /* TOPCKGEN MUX_GATE */
@@ -458,8 +458,9 @@ static const struct mtk_parent infra_pcie_parents[] = {
 		.mux_set_reg = (_reg) + 0x0, .mux_clr_reg = (_reg) + 0x4,      \
 		.mux_shift = _shift, .mux_mask = BIT(_width) - 1,              \
 		.gate_shift = -1, .upd_shift = -1,			       \
-		.parent_flags = _parents, .num_parents = ARRAY_SIZE(_parents), \
-		.flags = CLK_MUX_SETCLR_UPD | CLK_PARENT_MIXED,                \
+		.parent = _parents,					       \
+		.num_parents = ARRAY_SIZE(_parents),			       \
+		.flags = CLK_MUX_SETCLR_UPD,				       \
 	}
 
 /* INFRA MUX */
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index 65d4142fa63..ed65aa81a21 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -229,9 +229,10 @@ static const struct mtk_parent da_u2_refsel_parents[] = {
 		.mux_clr_reg = _mux_clr_ofs, .upd_reg = _upd_ofs,              \
 		.upd_shift = _upd, .mux_shift = _shift,                        \
 		.mux_mask = BIT(_width) - 1, .gate_reg = _mux_ofs,             \
-		.gate_shift = _gate, .parent_flags = _parents,                 \
+		.gate_shift = _gate,                                           \
+		.parent = _parents,                                            \
 		.num_parents = ARRAY_SIZE(_parents),                           \
-		.flags = CLK_MUX_SETCLR_UPD | CLK_PARENT_MIXED,                \
+		.flags = CLK_MUX_SETCLR_UPD,                                   \
 	}
 
 /* TOPCKGEN MUX_GATE */
@@ -365,8 +366,9 @@ static const struct mtk_parent infra_pcie_parents[] = {
 		.mux_set_reg = (_reg) + 0x0, .mux_clr_reg = (_reg) + 0x4,      \
 		.mux_shift = _shift, .mux_mask = BIT(_width) - 1,              \
 		.gate_shift = -1, .upd_shift = -1,			       \
-		.parent_flags = _parents, .num_parents = ARRAY_SIZE(_parents), \
-		.flags = CLK_MUX_SETCLR_UPD | CLK_PARENT_MIXED,                \
+		.parent = _parents,					       \
+		.num_parents = ARRAY_SIZE(_parents),			       \
+		.flags = CLK_MUX_SETCLR_UPD,				       \
 	}
 
 /* INFRA MUX */
diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index 5ae76a2c47a..2fdd0fd20c9 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -339,9 +339,9 @@ static const struct mtk_parent emmc_200m_parents[] = {
 		.upd_reg = (_upd_ofs), .upd_shift = (_upd),                    \
 		.mux_shift = (_shift), .mux_mask = BIT(_width) - 1,            \
 		.gate_reg = (_mux_ofs), .gate_shift = (_gate),                 \
-		.parent_flags = (_parents),                                    \
+		.parent = (_parents),                                          \
 		.num_parents = ARRAY_SIZE(_parents),                           \
-		.flags = CLK_MUX_SETCLR_UPD | CLK_PARENT_MIXED,                \
+		.flags = CLK_MUX_SETCLR_UPD,                                   \
 	}
 
 /* TOPCKGEN MUX_GATE */
@@ -545,9 +545,9 @@ static const struct mtk_parent infra_pcie_gfmux_tl_ck_o_p1_parents[] = {
 		.mux_clr_reg = (_reg) + 0x4, .mux_set_reg = (_reg) + 0x0,      \
 		.mux_shift = (_shift), .mux_mask = BIT(_width) - 1,            \
 		.gate_shift = -1, .upd_shift = -1,                             \
-		.parent_flags = (_parents),				       \
+		.parent = (_parents),					       \
 		.num_parents = ARRAY_SIZE(_parents),			       \
-		.flags = CLK_MUX_SETCLR_UPD | CLK_PARENT_MIXED,		       \
+		.flags = CLK_MUX_SETCLR_UPD,				       \
 	}
 
 /* INFRA MUX */
diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 38a5c20035d..f951a6fc58d 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -281,9 +281,10 @@ static const struct mtk_parent eth_mii_parents[] = {
 		.mux_clr_reg = _mux_clr_ofs, .upd_reg = _upd_ofs,              \
 		.upd_shift = _upd, .mux_shift = _shift,                        \
 		.mux_mask = BIT(_width) - 1, .gate_reg = _mux_ofs,             \
-		.gate_shift = _gate, .parent_flags = _parents,                 \
+		.gate_shift = _gate,					       \
+		.parent = _parents,					       \
 		.num_parents = ARRAY_SIZE(_parents),                           \
-		.flags = CLK_MUX_SETCLR_UPD | CLK_PARENT_MIXED,                \
+		.flags = CLK_MUX_SETCLR_UPD,				       \
 	}
 
 /* TOPCKGEN MUX_GATE */
@@ -509,10 +510,10 @@ static const struct mtk_parent infra_pcie_gfmux_tl_ck_o_p3_parents[] = {
 		.id = _id, .mux_reg = _reg + 0x8, .mux_set_reg = _reg + 0x0,   \
 		.mux_clr_reg = _reg + 0x4, .mux_shift = _shift,                \
 		.mux_mask = BIT(_width) - 1,				       \
-		.parent_flags = _parents,				       \
+		.parent = _parents,					       \
 		.gate_shift = -1, .upd_shift = -1,			       \
 		.num_parents = ARRAY_SIZE(_parents),                           \
-		.flags = CLK_MUX_SETCLR_UPD | CLK_PARENT_MIXED,		       \
+		.flags = CLK_MUX_SETCLR_UPD,				       \
 	}
 
 /* INFRA MUX */
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index d98614d8da6..54e31efd2ea 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -542,58 +542,58 @@ static const struct mtk_parent aud_2_parents[] = {
 
 static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_0 */
-	MUX_MIXED(CLK_TOP_MUX_AXI, axi_parents, 0x40, 0, 2),
-	MUX_MIXED(CLK_TOP_MUX_MM, mm_parents, 0x40, 8, 3),
-	MUX_MIXED(CLK_TOP_MUX_IMG, img_parents, 0x40, 16, 3),
-	MUX_MIXED(CLK_TOP_MUX_CAM, cam_parents, 0x40, 24, 4),
+	MUX(CLK_TOP_MUX_AXI, axi_parents, 0x40, 0, 2),
+	MUX(CLK_TOP_MUX_MM, mm_parents, 0x40, 8, 3),
+	MUX(CLK_TOP_MUX_IMG, img_parents, 0x40, 16, 3),
+	MUX(CLK_TOP_MUX_CAM, cam_parents, 0x40, 24, 4),
 	/* CLK_CFG_1 */
-	MUX_MIXED(CLK_TOP_MUX_DSP, dsp_parents, 0x50, 0, 4),
-	MUX_MIXED(CLK_TOP_MUX_DSP1, dsp1_parents, 0x50, 8, 4),
-	MUX_MIXED(CLK_TOP_MUX_DSP2, dsp2_parents, 0x50, 16, 4),
-	MUX_MIXED(CLK_TOP_MUX_IPU_IF, ipu_if_parents, 0x50, 24, 4),
+	MUX(CLK_TOP_MUX_DSP, dsp_parents, 0x50, 0, 4),
+	MUX(CLK_TOP_MUX_DSP1, dsp1_parents, 0x50, 8, 4),
+	MUX(CLK_TOP_MUX_DSP2, dsp2_parents, 0x50, 16, 4),
+	MUX(CLK_TOP_MUX_IPU_IF, ipu_if_parents, 0x50, 24, 4),
 	/* CLK_CFG_2 */
-	MUX_MIXED(CLK_TOP_MUX_MFG, mfg_parents, 0x60, 0, 2),
-	MUX_MIXED(CLK_TOP_MUX_F52M_MFG, f52m_mfg_parents, 0x60, 8, 2),
-	MUX_MIXED(CLK_TOP_MUX_CAMTG, camtg_parents, 0x60, 16, 3),
-	MUX_MIXED(CLK_TOP_MUX_CAMTG2, camtg2_parents, 0x60, 24, 3),
+	MUX(CLK_TOP_MUX_MFG, mfg_parents, 0x60, 0, 2),
+	MUX(CLK_TOP_MUX_F52M_MFG, f52m_mfg_parents, 0x60, 8, 2),
+	MUX(CLK_TOP_MUX_CAMTG, camtg_parents, 0x60, 16, 3),
+	MUX(CLK_TOP_MUX_CAMTG2, camtg2_parents, 0x60, 24, 3),
 	/* CLK_CFG_3 */
-	MUX_MIXED(CLK_TOP_MUX_CAMTG3, camtg3_parents, 0x70, 0, 3),
-	MUX_MIXED(CLK_TOP_MUX_CAMTG4, camtg4_parents, 0x70, 8, 3),
-	MUX_MIXED(CLK_TOP_MUX_UART, uart_parents, 0x70, 16, 1),
-	MUX_MIXED(CLK_TOP_MUX_SPI, spi_parents, 0x70, 24, 2),
+	MUX(CLK_TOP_MUX_CAMTG3, camtg3_parents, 0x70, 0, 3),
+	MUX(CLK_TOP_MUX_CAMTG4, camtg4_parents, 0x70, 8, 3),
+	MUX(CLK_TOP_MUX_UART, uart_parents, 0x70, 16, 1),
+	MUX(CLK_TOP_MUX_SPI, spi_parents, 0x70, 24, 2),
 	/* CLK_CFG_4 */
-	MUX_MIXED(CLK_TOP_MUX_MSDC50_0_HCLK, msdc50_hclk_parents, 0x80, 0, 2),
-	MUX_MIXED(CLK_TOP_MUX_MSDC50_0, msdc50_0_parents, 0x80, 8, 3),
-	MUX_MIXED(CLK_TOP_MUX_MSDC30_1, msdc30_1_parents, 0x80, 16, 3),
-	MUX_MIXED(CLK_TOP_MUX_MSDC30_2, msdc30_2_parents, 0x80, 24, 3),
+	MUX(CLK_TOP_MUX_MSDC50_0_HCLK, msdc50_hclk_parents, 0x80, 0, 2),
+	MUX(CLK_TOP_MUX_MSDC50_0, msdc50_0_parents, 0x80, 8, 3),
+	MUX(CLK_TOP_MUX_MSDC30_1, msdc30_1_parents, 0x80, 16, 3),
+	MUX(CLK_TOP_MUX_MSDC30_2, msdc30_2_parents, 0x80, 24, 3),
 	/* CLK_CFG_5 */
-	MUX_MIXED(CLK_TOP_MUX_AUDIO, audio_parents, 0x90, 0, 2),
-	MUX_MIXED(CLK_TOP_MUX_AUD_INTBUS, aud_intbus_parents, 0x90, 8, 2),
-	MUX_MIXED(CLK_TOP_MUX_PMICSPI, pmicspi_parents, 0x90, 16, 2),
-	MUX_MIXED(CLK_TOP_MUX_FPWRAP_ULPOSC, fpwrap_ulposc_parents, 0x90, 24, 2),
+	MUX(CLK_TOP_MUX_AUDIO, audio_parents, 0x90, 0, 2),
+	MUX(CLK_TOP_MUX_AUD_INTBUS, aud_intbus_parents, 0x90, 8, 2),
+	MUX(CLK_TOP_MUX_PMICSPI, pmicspi_parents, 0x90, 16, 2),
+	MUX(CLK_TOP_MUX_FPWRAP_ULPOSC, fpwrap_ulposc_parents, 0x90, 24, 2),
 	/* CLK_CFG_6 */
-	MUX_MIXED(CLK_TOP_MUX_ATB, atb_parents, 0xa0, 0, 2),
-	MUX_MIXED(CLK_TOP_MUX_SSPM, sspm_parents, 0xa0, 8, 3),
-	MUX_MIXED(CLK_TOP_MUX_DPI0, dpi0_parents, 0xa0, 16, 4),
-	MUX_MIXED(CLK_TOP_MUX_SCAM, scam_parents, 0xa0, 24, 1),
+	MUX(CLK_TOP_MUX_ATB, atb_parents, 0xa0, 0, 2),
+	MUX(CLK_TOP_MUX_SSPM, sspm_parents, 0xa0, 8, 3),
+	MUX(CLK_TOP_MUX_DPI0, dpi0_parents, 0xa0, 16, 4),
+	MUX(CLK_TOP_MUX_SCAM, scam_parents, 0xa0, 24, 1),
 	/* CLK_CFG_7 */
-	MUX_MIXED(CLK_TOP_MUX_DISP_PWM, disppwm_parents, 0xb0, 0, 3),
-	MUX_MIXED(CLK_TOP_MUX_USB_TOP, usb_top_parents, 0xb0, 8, 2),
-	MUX_MIXED(CLK_TOP_MUX_SSUSB_TOP_XHCI, ssusb_top_xhci_parents, 0xb0, 16, 2),
-	MUX_MIXED(CLK_TOP_MUX_SPM, spm_parents, 0xb0, 24, 1),
+	MUX(CLK_TOP_MUX_DISP_PWM, disppwm_parents, 0xb0, 0, 3),
+	MUX(CLK_TOP_MUX_USB_TOP, usb_top_parents, 0xb0, 8, 2),
+	MUX(CLK_TOP_MUX_SSUSB_TOP_XHCI, ssusb_top_xhci_parents, 0xb0, 16, 2),
+	MUX(CLK_TOP_MUX_SPM, spm_parents, 0xb0, 24, 1),
 	/* CLK_CFG_8 */
-	MUX_MIXED(CLK_TOP_MUX_I2C, i2c_parents, 0xc0, 0, 2),
-	MUX_MIXED(CLK_TOP_MUX_SCP, scp_parents, 0xc0, 8, 3),
-	MUX_MIXED(CLK_TOP_MUX_SENINF, seninf_parents, 0xc0, 16, 2),
-	MUX_MIXED(CLK_TOP_MUX_DXCC, dxcc_parents, 0xc0, 24, 2),
+	MUX(CLK_TOP_MUX_I2C, i2c_parents, 0xc0, 0, 2),
+	MUX(CLK_TOP_MUX_SCP, scp_parents, 0xc0, 8, 3),
+	MUX(CLK_TOP_MUX_SENINF, seninf_parents, 0xc0, 16, 2),
+	MUX(CLK_TOP_MUX_DXCC, dxcc_parents, 0xc0, 24, 2),
 	/* CLK_CFG_9 */
-	MUX_MIXED(CLK_TOP_MUX_AUD_ENG1, aud_engen1_parents, 0xd0, 0, 2),
-	MUX_MIXED(CLK_TOP_MUX_AUD_ENG2, aud_engen2_parents, 0xd0, 8, 2),
-	MUX_MIXED(CLK_TOP_MUX_FAES_UFSFDE, faes_ufsfde_parents, 0xd0, 16, 3),
-	MUX_MIXED(CLK_TOP_MUX_FUFS, fufs_parents, 0xd0, 24, 2),
+	MUX(CLK_TOP_MUX_AUD_ENG1, aud_engen1_parents, 0xd0, 0, 2),
+	MUX(CLK_TOP_MUX_AUD_ENG2, aud_engen2_parents, 0xd0, 8, 2),
+	MUX(CLK_TOP_MUX_FAES_UFSFDE, faes_ufsfde_parents, 0xd0, 16, 3),
+	MUX(CLK_TOP_MUX_FUFS, fufs_parents, 0xd0, 24, 2),
 	/* CLK_CFG_10 */
-	MUX_MIXED(CLK_TOP_MUX_AUD_1, aud_1_parents, 0xe0, 0, 1),
-	MUX_MIXED(CLK_TOP_MUX_AUD_2, aud_2_parents, 0xe0, 8, 1),
+	MUX(CLK_TOP_MUX_AUD_1, aud_1_parents, 0xe0, 0, 1),
+	MUX(CLK_TOP_MUX_AUD_2, aud_2_parents, 0xe0, 8, 1),
 };
 
 static const struct mtk_clk_tree mt8183_clk_tree = {
diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index 1db5350763e..706390b6c6c 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -1027,119 +1027,119 @@ static const struct mtk_parent srck_parents[] = {
 
 static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_0 */
-	MUX_GATE_MIXED(CLK_TOP_AXI, axi_parents, 0x020, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_SPM, spm_parents, 0x020, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_SCP, scp_parents, 0x020, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_BUS_AXIMEM, bus_aximem_parents, 0x020, 24, 4, 31),
+	MUX_GATE(CLK_TOP_AXI, axi_parents, 0x020, 0, 4, 7),
+	MUX_GATE(CLK_TOP_SPM, spm_parents, 0x020, 8, 4, 15),
+	MUX_GATE(CLK_TOP_SCP, scp_parents, 0x020, 16, 4, 23),
+	MUX_GATE(CLK_TOP_BUS_AXIMEM, bus_aximem_parents, 0x020, 24, 4, 31),
 	/* CLK_CFG_1 */
-	MUX_GATE_MIXED(CLK_TOP_VPP, vpp_parents, 0x02C, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_ETHDR, ethdr_parents, 0x02C, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_IPE, ipe_parents, 0x02C, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_CAM, cam_parents, 0x02C, 24, 4, 31),
+	MUX_GATE(CLK_TOP_VPP, vpp_parents, 0x02C, 0, 4, 7),
+	MUX_GATE(CLK_TOP_ETHDR, ethdr_parents, 0x02C, 8, 4, 15),
+	MUX_GATE(CLK_TOP_IPE, ipe_parents, 0x02C, 16, 4, 23),
+	MUX_GATE(CLK_TOP_CAM, cam_parents, 0x02C, 24, 4, 31),
 	/* CLK_CFG_2 */
-	MUX_GATE_MIXED(CLK_TOP_CCU, ccu_parents, 0x038, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_CCU_AHB, ccu_ahb_parents, 0x038, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_IMG, img_parents, 0x038, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_CAMTM, camtm_parents, 0x038, 24, 4, 31),
+	MUX_GATE(CLK_TOP_CCU, ccu_parents, 0x038, 0, 4, 7),
+	MUX_GATE(CLK_TOP_CCU_AHB, ccu_ahb_parents, 0x038, 8, 4, 15),
+	MUX_GATE(CLK_TOP_IMG, img_parents, 0x038, 16, 4, 23),
+	MUX_GATE(CLK_TOP_CAMTM, camtm_parents, 0x038, 24, 4, 31),
 	/* CLK_CFG_3 */
-	MUX_GATE_MIXED(CLK_TOP_DSP, dsp_parents, 0x044, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_DSP1, dsp1_parents, 0x044, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_DSP2, dsp2_parents, 0x044, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_DSP3, dsp3_parents, 0x044, 24, 4, 31),
+	MUX_GATE(CLK_TOP_DSP, dsp_parents, 0x044, 0, 4, 7),
+	MUX_GATE(CLK_TOP_DSP1, dsp1_parents, 0x044, 8, 4, 15),
+	MUX_GATE(CLK_TOP_DSP2, dsp2_parents, 0x044, 16, 4, 23),
+	MUX_GATE(CLK_TOP_DSP3, dsp3_parents, 0x044, 24, 4, 31),
 	/* CLK_CFG_4 */
-	MUX_GATE_MIXED(CLK_TOP_DSP4, dsp4_parents, 0x050, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_DSP5, dsp5_parents, 0x050, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_DSP6, dsp6_parents, 0x050, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_DSP7, dsp7_parents, 0x050, 24, 4, 31),
+	MUX_GATE(CLK_TOP_DSP4, dsp4_parents, 0x050, 0, 4, 7),
+	MUX_GATE(CLK_TOP_DSP5, dsp5_parents, 0x050, 8, 4, 15),
+	MUX_GATE(CLK_TOP_DSP6, dsp6_parents, 0x050, 16, 4, 23),
+	MUX_GATE(CLK_TOP_DSP7, dsp7_parents, 0x050, 24, 4, 31),
 	/* CLK_CFG_5 */
-	MUX_GATE_MIXED(CLK_TOP_MFG_CORE_TMP, mfg_core_tmp_parents, 0x05C, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_CAMTG, camtg_parents, 0x05C, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_CAMTG2, camtg2_parents, 0x05C, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_CAMTG3, camtg3_parents, 0x05C, 24, 4, 31),
+	MUX_GATE(CLK_TOP_MFG_CORE_TMP, mfg_core_tmp_parents, 0x05C, 0, 4, 7),
+	MUX_GATE(CLK_TOP_CAMTG, camtg_parents, 0x05C, 8, 4, 15),
+	MUX_GATE(CLK_TOP_CAMTG2, camtg2_parents, 0x05C, 16, 4, 23),
+	MUX_GATE(CLK_TOP_CAMTG3, camtg3_parents, 0x05C, 24, 4, 31),
 	/* CLK_CFG_6 */
-	MUX_GATE_MIXED(CLK_TOP_UART, uart_parents, 0x068, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_SPI, spi_parents, 0x068, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_MSDC50_0_HCLK, msdc5hclk_parents, 0x068, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_MSDC50_0, msdc50_0_parents, 0x068, 24, 4, 31),
+	MUX_GATE(CLK_TOP_UART, uart_parents, 0x068, 0, 4, 7),
+	MUX_GATE(CLK_TOP_SPI, spi_parents, 0x068, 8, 4, 15),
+	MUX_GATE(CLK_TOP_MSDC50_0_HCLK, msdc5hclk_parents, 0x068, 16, 4, 23),
+	MUX_GATE(CLK_TOP_MSDC50_0, msdc50_0_parents, 0x068, 24, 4, 31),
 	/* CLK_CFG_7 */
-	MUX_GATE_MIXED(CLK_TOP_MSDC30_1, msdc30_1_parents, 0x074, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_MSDC30_2, msdc30_2_parents, 0x074, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_INTDIR, intdir_parents, 0x074, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_AUD_INTBUS, aud_intbus_parents, 0x074, 24, 4, 31),
+	MUX_GATE(CLK_TOP_MSDC30_1, msdc30_1_parents, 0x074, 0, 4, 7),
+	MUX_GATE(CLK_TOP_MSDC30_2, msdc30_2_parents, 0x074, 8, 4, 15),
+	MUX_GATE(CLK_TOP_INTDIR, intdir_parents, 0x074, 16, 4, 23),
+	MUX_GATE(CLK_TOP_AUD_INTBUS, aud_intbus_parents, 0x074, 24, 4, 31),
 	/* CLK_CFG_8 */
-	MUX_GATE_MIXED(CLK_TOP_AUDIO_H, audio_h_parents, 0x080, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_PWRAP_ULPOSC, pwrap_ulposc_parents, 0x080, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_ATB, atb_parents, 0x080, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_SSPM, sspm_parents, 0x080, 24, 4, 31),
+	MUX_GATE(CLK_TOP_AUDIO_H, audio_h_parents, 0x080, 0, 4, 7),
+	MUX_GATE(CLK_TOP_PWRAP_ULPOSC, pwrap_ulposc_parents, 0x080, 8, 4, 15),
+	MUX_GATE(CLK_TOP_ATB, atb_parents, 0x080, 16, 4, 23),
+	MUX_GATE(CLK_TOP_SSPM, sspm_parents, 0x080, 24, 4, 31),
 	/* CLK_CFG_9 */
-	MUX_GATE_MIXED(CLK_TOP_DP, dp_parents, 0x08C, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_EDP, edp_parents, 0x08C, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_DPI, dpi_parents, 0x08C, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_DISP_PWM0, disp_pwm0_parents, 0x08C, 24, 4, 31),
+	MUX_GATE(CLK_TOP_DP, dp_parents, 0x08C, 0, 4, 7),
+	MUX_GATE(CLK_TOP_EDP, edp_parents, 0x08C, 8, 4, 15),
+	MUX_GATE(CLK_TOP_DPI, dpi_parents, 0x08C, 16, 4, 23),
+	MUX_GATE(CLK_TOP_DISP_PWM0, disp_pwm0_parents, 0x08C, 24, 4, 31),
 	/* CLK_CFG_10 */
-	MUX_GATE_MIXED(CLK_TOP_DISP_PWM1, disp_pwm1_parents, 0x098, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_USB_TOP, usb_parents, 0x098, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_SSUSB_XHCI, ssusb_xhci_parents, 0x098, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_USB_TOP_2P, usb_2p_parents, 0x098, 24, 4, 31),
+	MUX_GATE(CLK_TOP_DISP_PWM1, disp_pwm1_parents, 0x098, 0, 4, 7),
+	MUX_GATE(CLK_TOP_USB_TOP, usb_parents, 0x098, 8, 4, 15),
+	MUX_GATE(CLK_TOP_SSUSB_XHCI, ssusb_xhci_parents, 0x098, 16, 4, 23),
+	MUX_GATE(CLK_TOP_USB_TOP_2P, usb_2p_parents, 0x098, 24, 4, 31),
 	/* CLK_CFG_11 */
-	MUX_GATE_MIXED(CLK_TOP_SSUSB_XHCI_2P, ssusb_xhci_2p_parents, 0x0A4, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_USB_TOP_3P, usb_3p_parents, 0x0A4, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_SSUSB_XHCI_3P, ssusb_xhci_3p_parents, 0x0A4, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_I2C, i2c_parents, 0x0A4, 24, 4, 31),
+	MUX_GATE(CLK_TOP_SSUSB_XHCI_2P, ssusb_xhci_2p_parents, 0x0A4, 0, 4, 7),
+	MUX_GATE(CLK_TOP_USB_TOP_3P, usb_3p_parents, 0x0A4, 8, 4, 15),
+	MUX_GATE(CLK_TOP_SSUSB_XHCI_3P, ssusb_xhci_3p_parents, 0x0A4, 16, 4, 23),
+	MUX_GATE(CLK_TOP_I2C, i2c_parents, 0x0A4, 24, 4, 31),
 	/* CLK_CFG_12 */
-	MUX_GATE_MIXED(CLK_TOP_SENINF, seninf_parents, 0x0B0, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_SENINF1, seninf1_parents, 0x0B0, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_GCPU, gcpu_parents, 0x0B0, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_VENC, venc_parents, 0x0B0, 24, 4, 31),
+	MUX_GATE(CLK_TOP_SENINF, seninf_parents, 0x0B0, 0, 4, 7),
+	MUX_GATE(CLK_TOP_SENINF1, seninf1_parents, 0x0B0, 8, 4, 15),
+	MUX_GATE(CLK_TOP_GCPU, gcpu_parents, 0x0B0, 16, 4, 23),
+	MUX_GATE(CLK_TOP_VENC, venc_parents, 0x0B0, 24, 4, 31),
 	/* CLK_CFG_13 */
-	MUX_GATE_MIXED(CLK_TOP_VDEC, vdec_parents, 0x0BC, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_PWM, pwm_parents, 0x0BC, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_MCUPM, mcupm_parents, 0x0BC, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_SPMI_P_MST, spmi_p_mst_parents, 0x0BC, 24, 4, 31),
+	MUX_GATE(CLK_TOP_VDEC, vdec_parents, 0x0BC, 0, 4, 7),
+	MUX_GATE(CLK_TOP_PWM, pwm_parents, 0x0BC, 8, 4, 15),
+	MUX_GATE(CLK_TOP_MCUPM, mcupm_parents, 0x0BC, 16, 4, 23),
+	MUX_GATE(CLK_TOP_SPMI_P_MST, spmi_p_mst_parents, 0x0BC, 24, 4, 31),
 	/* CLK_CFG_14 */
-	MUX_GATE_MIXED(CLK_TOP_SPMI_M_MST, spmi_m_mst_parents, 0x0C8, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_DVFSRC, dvfsrc_parents, 0x0C8, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_TL, tl_parents, 0x0C8, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_AES_MSDCFDE, aes_msdcfde_parents, 0x0C8, 24, 4, 31),
+	MUX_GATE(CLK_TOP_SPMI_M_MST, spmi_m_mst_parents, 0x0C8, 0, 4, 7),
+	MUX_GATE(CLK_TOP_DVFSRC, dvfsrc_parents, 0x0C8, 8, 4, 15),
+	MUX_GATE(CLK_TOP_TL, tl_parents, 0x0C8, 16, 4, 23),
+	MUX_GATE(CLK_TOP_AES_MSDCFDE, aes_msdcfde_parents, 0x0C8, 24, 4, 31),
 	/* CLK_CFG_15 */
-	MUX_GATE_MIXED(CLK_TOP_DSI_OCC, dsi_occ_parents, 0x0D4, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_WPE_VPP, wpe_vpp_parents, 0x0D4, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_HDCP, hdcp_parents, 0x0D4, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_HDCP_24M, hdcp_24m_parents, 0x0D4, 24, 4, 31),
+	MUX_GATE(CLK_TOP_DSI_OCC, dsi_occ_parents, 0x0D4, 0, 4, 7),
+	MUX_GATE(CLK_TOP_WPE_VPP, wpe_vpp_parents, 0x0D4, 8, 4, 15),
+	MUX_GATE(CLK_TOP_HDCP, hdcp_parents, 0x0D4, 16, 4, 23),
+	MUX_GATE(CLK_TOP_HDCP_24M, hdcp_24m_parents, 0x0D4, 24, 4, 31),
 	/* CLK_CFG_16 */
-	MUX_GATE_MIXED(CLK_TOP_HDMI_APB, hdmi_apb_parents, 0x0E0, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_SNPS_ETH_250M, snps_eth_250m_parents, 0x0E0, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_SNPS_ETH_62P4M_PTP, snps_eth_62p4m_ptp_parents, 0x0E0, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_SNPS_ETH_50M_RMII, snps_eth_50m_rmii_parents, 0x0E0, 24, 4, 31),
+	MUX_GATE(CLK_TOP_HDMI_APB, hdmi_apb_parents, 0x0E0, 0, 4, 7),
+	MUX_GATE(CLK_TOP_SNPS_ETH_250M, snps_eth_250m_parents, 0x0E0, 8, 4, 15),
+	MUX_GATE(CLK_TOP_SNPS_ETH_62P4M_PTP, snps_eth_62p4m_ptp_parents, 0x0E0, 16, 4, 23),
+	MUX_GATE(CLK_TOP_SNPS_ETH_50M_RMII, snps_eth_50m_rmii_parents, 0x0E0, 24, 4, 31),
 	/* CLK_CFG_17 */
-	MUX_GATE_MIXED(CLK_TOP_ADSP, adsp_parents, 0x0EC, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_AUDIO_LOCAL_BUS, audio_local_bus_parents, 0x0EC, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_ASM_H, asm_h_parents, 0x0EC, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_ASM_L, asm_l_parents, 0x0EC, 24, 4, 31),
+	MUX_GATE(CLK_TOP_ADSP, adsp_parents, 0x0EC, 0, 4, 7),
+	MUX_GATE(CLK_TOP_AUDIO_LOCAL_BUS, audio_local_bus_parents, 0x0EC, 8, 4, 15),
+	MUX_GATE(CLK_TOP_ASM_H, asm_h_parents, 0x0EC, 16, 4, 23),
+	MUX_GATE(CLK_TOP_ASM_L, asm_l_parents, 0x0EC, 24, 4, 31),
 	/* CLK_CFG_18 */
-	MUX_GATE_MIXED(CLK_TOP_APLL1, apll1_parents, 0x0F8, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_APLL2, apll2_parents, 0x0F8, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_APLL3, apll3_parents, 0x0F8, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_APLL4, apll4_parents, 0x0F8, 24, 4, 31),
+	MUX_GATE(CLK_TOP_APLL1, apll1_parents, 0x0F8, 0, 4, 7),
+	MUX_GATE(CLK_TOP_APLL2, apll2_parents, 0x0F8, 8, 4, 15),
+	MUX_GATE(CLK_TOP_APLL3, apll3_parents, 0x0F8, 16, 4, 23),
+	MUX_GATE(CLK_TOP_APLL4, apll4_parents, 0x0F8, 24, 4, 31),
 	/* CLK_CFG_19 */
-	MUX_GATE_MIXED(CLK_TOP_APLL5, apll5_parents, 0x0104, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_I2SO1, i2so1_parents, 0x0104, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_I2SO2, i2so2_parents, 0x0104, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_I2SI1, i2si1_parents, 0x0104, 24, 4, 31),
+	MUX_GATE(CLK_TOP_APLL5, apll5_parents, 0x0104, 0, 4, 7),
+	MUX_GATE(CLK_TOP_I2SO1, i2so1_parents, 0x0104, 8, 4, 15),
+	MUX_GATE(CLK_TOP_I2SO2, i2so2_parents, 0x0104, 16, 4, 23),
+	MUX_GATE(CLK_TOP_I2SI1, i2si1_parents, 0x0104, 24, 4, 31),
 	/* CLK_CFG_20 */
-	MUX_GATE_MIXED(CLK_TOP_I2SI2, i2si2_parents, 0x0110, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_DPTX, dptx_parents, 0x0110, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_AUD_IEC, aud_iec_parents, 0x0110, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_A1SYS_HP, a1sys_hp_parents, 0x0110, 24, 4, 31),
+	MUX_GATE(CLK_TOP_I2SI2, i2si2_parents, 0x0110, 0, 4, 7),
+	MUX_GATE(CLK_TOP_DPTX, dptx_parents, 0x0110, 8, 4, 15),
+	MUX_GATE(CLK_TOP_AUD_IEC, aud_iec_parents, 0x0110, 16, 4, 23),
+	MUX_GATE(CLK_TOP_A1SYS_HP, a1sys_hp_parents, 0x0110, 24, 4, 31),
 	/* CLK_CFG_21 */
-	MUX_GATE_MIXED(CLK_TOP_A2SYS, a2sys_parents, 0x011C, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_A3SYS, a3sys_parents, 0x011C, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_A4SYS, a4sys_parents, 0x011C, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_ECC, ecc_parents, 0x011C, 24, 4, 31),
+	MUX_GATE(CLK_TOP_A2SYS, a2sys_parents, 0x011C, 0, 4, 7),
+	MUX_GATE(CLK_TOP_A3SYS, a3sys_parents, 0x011C, 8, 4, 15),
+	MUX_GATE(CLK_TOP_A4SYS, a4sys_parents, 0x011C, 16, 4, 23),
+	MUX_GATE(CLK_TOP_ECC, ecc_parents, 0x011C, 24, 4, 31),
 	/* CLK_CFG_22 */
-	MUX_GATE_MIXED(CLK_TOP_SPINOR, spinor_parents, 0x0128, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_ULPOSC, ulposc_parents, 0x0128, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_SRCK, srck_parents, 0x0128, 16, 4, 23),
+	MUX_GATE(CLK_TOP_SPINOR, spinor_parents, 0x0128, 0, 4, 7),
+	MUX_GATE(CLK_TOP_ULPOSC, ulposc_parents, 0x0128, 8, 4, 15),
+	MUX_GATE(CLK_TOP_SRCK, srck_parents, 0x0128, 16, 4, 23),
 };
 
 static const int mt8188_id_top_offs_map[] = {
diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index 89453ff872d..bce54c9a45f 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -1107,16 +1107,16 @@ static const struct mtk_parent ecc_parents[] = {
 
 #define MUX_CLR_SET_UPD(_id, _parents, _mux_ofs, _mux_set_ofs, _mux_clr_ofs,	\
 			_shift, _width,	_upd_ofs, _upd)				\
-	MUX_MIXED_CLR_SET_UPD_FLAGS(_id, _parents, _mux_ofs, _mux_set_ofs,	\
-				    _mux_clr_ofs, _shift, _width, -1, _upd_ofs,	\
-				    _upd, CLK_MUX_SETCLR_UPD)
+	MUX_CLR_SET_UPD_FLAGS(_id, _parents, _mux_ofs, _mux_set_ofs,		\
+			     _mux_clr_ofs, _shift, _width, -1, _upd_ofs,	\
+			     _upd, CLK_MUX_SETCLR_UPD)
 
 #define MUX_GATE_CLR_SET_UPD(_id, _parents, _mux_ofs, _mux_set_ofs,		\
 			      _mux_clr_ofs, _shift, _width, _gate, _upd_ofs,	\
 			      _upd)						\
-	MUX_MIXED_CLR_SET_UPD_FLAGS(_id, _parents, _mux_ofs, _mux_set_ofs,	\
-				   _mux_clr_ofs, _shift, _width, _gate,		\
-				   _upd_ofs, _upd, CLK_MUX_SETCLR_UPD)
+	MUX_CLR_SET_UPD_FLAGS(_id, _parents, _mux_ofs, _mux_set_ofs,		\
+			      _mux_clr_ofs, _shift, _width, _gate,		\
+			      _upd_ofs, _upd, CLK_MUX_SETCLR_UPD)
 
 const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_0 */
diff --git a/drivers/clk/mediatek/clk-mt8195.c b/drivers/clk/mediatek/clk-mt8195.c
index c709d61af94..fc7b9ff1d8d 100644
--- a/drivers/clk/mediatek/clk-mt8195.c
+++ b/drivers/clk/mediatek/clk-mt8195.c
@@ -961,160 +961,160 @@ static const struct mtk_parent srck_parents[] = {
 
 static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_0 */
-	MUX_GATE_MIXED(CLK_TOP_AXI, axi_parents, 0x020, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_SPM, spm_parents, 0x020, 8, 2, 15),
-	MUX_GATE_MIXED(CLK_TOP_SCP, scp_parents, 0x020, 16, 3, 23),
-	MUX_GATE_MIXED(CLK_TOP_BUS_AXIMEM, bus_aximem_parents, 0x020, 24, 3, 31),
+	MUX_GATE(CLK_TOP_AXI, axi_parents, 0x020, 0, 3, 7),
+	MUX_GATE(CLK_TOP_SPM, spm_parents, 0x020, 8, 2, 15),
+	MUX_GATE(CLK_TOP_SCP, scp_parents, 0x020, 16, 3, 23),
+	MUX_GATE(CLK_TOP_BUS_AXIMEM, bus_aximem_parents, 0x020, 24, 3, 31),
 	/* CLK_CFG_1 */
-	MUX_GATE_MIXED(CLK_TOP_VPP, vpp_parents, 0x02C, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_ETHDR, ethdr_parents, 0x02C, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_IPE, ipe_parents, 0x02C, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_CAM, cam_parents, 0x02C, 24, 4, 31),
+	MUX_GATE(CLK_TOP_VPP, vpp_parents, 0x02C, 0, 4, 7),
+	MUX_GATE(CLK_TOP_ETHDR, ethdr_parents, 0x02C, 8, 4, 15),
+	MUX_GATE(CLK_TOP_IPE, ipe_parents, 0x02C, 16, 4, 23),
+	MUX_GATE(CLK_TOP_CAM, cam_parents, 0x02C, 24, 4, 31),
 	/* CLK_CFG_2 */
-	MUX_GATE_MIXED(CLK_TOP_CCU, ccu_parents, 0x038, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_IMG, img_parents, 0x038, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_CAMTM, camtm_parents, 0x038, 16, 2, 23),
-	MUX_GATE_MIXED(CLK_TOP_DSP, dsp_parents, 0x038, 24, 3, 31),
+	MUX_GATE(CLK_TOP_CCU, ccu_parents, 0x038, 0, 4, 7),
+	MUX_GATE(CLK_TOP_IMG, img_parents, 0x038, 8, 4, 15),
+	MUX_GATE(CLK_TOP_CAMTM, camtm_parents, 0x038, 16, 2, 23),
+	MUX_GATE(CLK_TOP_DSP, dsp_parents, 0x038, 24, 3, 31),
 	/* CLK_CFG_3 */
-	MUX_GATE_MIXED(CLK_TOP_DSP1, dsp1_parents, 0x044, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_DSP2, dsp1_parents, 0x044, 8, 3, 15),
-	MUX_GATE_MIXED(CLK_TOP_DSP3, dsp1_parents, 0x044, 16, 3, 23),
-	MUX_GATE_MIXED(CLK_TOP_DSP4, dsp2_parents, 0x044, 24, 3, 31),
+	MUX_GATE(CLK_TOP_DSP1, dsp1_parents, 0x044, 0, 3, 7),
+	MUX_GATE(CLK_TOP_DSP2, dsp1_parents, 0x044, 8, 3, 15),
+	MUX_GATE(CLK_TOP_DSP3, dsp1_parents, 0x044, 16, 3, 23),
+	MUX_GATE(CLK_TOP_DSP4, dsp2_parents, 0x044, 24, 3, 31),
 	/* CLK_CFG_4 */
-	MUX_GATE_MIXED(CLK_TOP_DSP5, dsp2_parents, 0x050, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_DSP6, dsp2_parents, 0x050, 8, 3, 15),
-	MUX_GATE_MIXED(CLK_TOP_DSP7, dsp_parents, 0x050, 16, 3, 23),
-	MUX_GATE_MIXED(CLK_TOP_IPU_IF, ipu_if_parents, 0x050, 24, 3, 31),
+	MUX_GATE(CLK_TOP_DSP5, dsp2_parents, 0x050, 0, 3, 7),
+	MUX_GATE(CLK_TOP_DSP6, dsp2_parents, 0x050, 8, 3, 15),
+	MUX_GATE(CLK_TOP_DSP7, dsp_parents, 0x050, 16, 3, 23),
+	MUX_GATE(CLK_TOP_IPU_IF, ipu_if_parents, 0x050, 24, 3, 31),
 	/* CLK_CFG_5 */
-	MUX_GATE_MIXED(CLK_TOP_MFG_CORE_TMP, mfg_parents, 0x05C, 0, 2, 7),
-	MUX_GATE_MIXED(CLK_TOP_CAMTG, camtg_parents, 0x05C, 8, 3, 15),
-	MUX_GATE_MIXED(CLK_TOP_CAMTG2, camtg_parents, 0x05C, 16, 3, 23),
-	MUX_GATE_MIXED(CLK_TOP_CAMTG3, camtg_parents, 0x05C, 24, 3, 31),
+	MUX_GATE(CLK_TOP_MFG_CORE_TMP, mfg_parents, 0x05C, 0, 2, 7),
+	MUX_GATE(CLK_TOP_CAMTG, camtg_parents, 0x05C, 8, 3, 15),
+	MUX_GATE(CLK_TOP_CAMTG2, camtg_parents, 0x05C, 16, 3, 23),
+	MUX_GATE(CLK_TOP_CAMTG3, camtg_parents, 0x05C, 24, 3, 31),
 	/* CLK_CFG_6 */
-	MUX_GATE_MIXED(CLK_TOP_CAMTG4, camtg_parents, 0x068, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_CAMTG5, camtg_parents, 0x068, 8, 3, 15),
-	MUX_GATE_MIXED(CLK_TOP_UART, uart_parents, 0x068, 16, 1, 23),
-	MUX_GATE_MIXED(CLK_TOP_SPI, spi_parents, 0x068, 24, 3, 31),
+	MUX_GATE(CLK_TOP_CAMTG4, camtg_parents, 0x068, 0, 3, 7),
+	MUX_GATE(CLK_TOP_CAMTG5, camtg_parents, 0x068, 8, 3, 15),
+	MUX_GATE(CLK_TOP_UART, uart_parents, 0x068, 16, 1, 23),
+	MUX_GATE(CLK_TOP_SPI, spi_parents, 0x068, 24, 3, 31),
 	/* CLK_CFG_7 */
-	MUX_GATE_MIXED(CLK_TOP_SPIS, spis_parents, 0x074, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_MSDC50_0_HCLK, msdc50_0_h_parents, 0x074, 8, 2, 15),
-	MUX_GATE_MIXED(CLK_TOP_MSDC50_0, msdc50_0_parents, 0x074, 16, 3, 23),
-	MUX_GATE_MIXED(CLK_TOP_MSDC30_1, msdc30_parents, 0x074, 24, 3, 31),
+	MUX_GATE(CLK_TOP_SPIS, spis_parents, 0x074, 0, 3, 7),
+	MUX_GATE(CLK_TOP_MSDC50_0_HCLK, msdc50_0_h_parents, 0x074, 8, 2, 15),
+	MUX_GATE(CLK_TOP_MSDC50_0, msdc50_0_parents, 0x074, 16, 3, 23),
+	MUX_GATE(CLK_TOP_MSDC30_1, msdc30_parents, 0x074, 24, 3, 31),
 	/* CLK_CFG_8 */
-	MUX_GATE_MIXED(CLK_TOP_MSDC30_2, msdc30_parents, 0x080, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_INTDIR, intdir_parents, 0x080, 8, 2, 15),
-	MUX_GATE_MIXED(CLK_TOP_AUD_INTBUS, aud_intbus_parents, 0x080, 16, 2, 23),
-	MUX_GATE_MIXED(CLK_TOP_AUDIO_H, audio_h_parents, 0x080, 24, 2, 31),
+	MUX_GATE(CLK_TOP_MSDC30_2, msdc30_parents, 0x080, 0, 3, 7),
+	MUX_GATE(CLK_TOP_INTDIR, intdir_parents, 0x080, 8, 2, 15),
+	MUX_GATE(CLK_TOP_AUD_INTBUS, aud_intbus_parents, 0x080, 16, 2, 23),
+	MUX_GATE(CLK_TOP_AUDIO_H, audio_h_parents, 0x080, 24, 2, 31),
 	/* CLK_CFG_9 */
-	MUX_GATE_MIXED(CLK_TOP_PWRAP_ULPOSC, pwrap_ulposc_parents, 0x08C, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_ATB, atb_parents, 0x08C, 8, 2, 15),
-	MUX_GATE_MIXED(CLK_TOP_PWRMCU, pwrmcu_parents, 0x08C, 16, 3, 23),
-	MUX_GATE_MIXED(CLK_TOP_DP, dp_parents, 0x08C, 24, 4, 31),
+	MUX_GATE(CLK_TOP_PWRAP_ULPOSC, pwrap_ulposc_parents, 0x08C, 0, 3, 7),
+	MUX_GATE(CLK_TOP_ATB, atb_parents, 0x08C, 8, 2, 15),
+	MUX_GATE(CLK_TOP_PWRMCU, pwrmcu_parents, 0x08C, 16, 3, 23),
+	MUX_GATE(CLK_TOP_DP, dp_parents, 0x08C, 24, 4, 31),
 	/* CLK_CFG_10 */
-	MUX_GATE_MIXED(CLK_TOP_EDP, dp_parents, 0x098, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_DPI, dp_parents, 0x098, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_DISP_PWM0, disp_pwm_parents, 0x098, 16, 3, 23),
-	MUX_GATE_MIXED(CLK_TOP_DISP_PWM1, disp_pwm_parents, 0x098, 24, 3, 31),
+	MUX_GATE(CLK_TOP_EDP, dp_parents, 0x098, 0, 4, 7),
+	MUX_GATE(CLK_TOP_DPI, dp_parents, 0x098, 8, 4, 15),
+	MUX_GATE(CLK_TOP_DISP_PWM0, disp_pwm_parents, 0x098, 16, 3, 23),
+	MUX_GATE(CLK_TOP_DISP_PWM1, disp_pwm_parents, 0x098, 24, 3, 31),
 	/* CLK_CFG_11 */
-	MUX_GATE_MIXED(CLK_TOP_USB_TOP, usb_parents, 0x0A4, 0, 2, 7),
-	MUX_GATE_MIXED(CLK_TOP_SSUSB_XHCI, usb_parents, 0x0A4, 8, 2, 15),
-	MUX_GATE_MIXED(CLK_TOP_USB_TOP_1P, usb_parents, 0x0A4, 16, 2, 23),
-	MUX_GATE_MIXED(CLK_TOP_SSUSB_XHCI_1P, usb_parents, 0x0A4, 24, 2, 31),
+	MUX_GATE(CLK_TOP_USB_TOP, usb_parents, 0x0A4, 0, 2, 7),
+	MUX_GATE(CLK_TOP_SSUSB_XHCI, usb_parents, 0x0A4, 8, 2, 15),
+	MUX_GATE(CLK_TOP_USB_TOP_1P, usb_parents, 0x0A4, 16, 2, 23),
+	MUX_GATE(CLK_TOP_SSUSB_XHCI_1P, usb_parents, 0x0A4, 24, 2, 31),
 	/* CLK_CFG_12 */
-	MUX_GATE_MIXED(CLK_TOP_USB_TOP_2P, usb_parents, 0x0B0, 0, 2, 7),
-	MUX_GATE_MIXED(CLK_TOP_SSUSB_XHCI_2P, usb_parents, 0x0B0, 8, 2, 15),
-	MUX_GATE_MIXED(CLK_TOP_USB_TOP_3P, usb_parents, 0x0B0, 16, 2, 23),
-	MUX_GATE_MIXED(CLK_TOP_SSUSB_XHCI_3P, usb_parents, 0x0B0, 24, 2, 31),
+	MUX_GATE(CLK_TOP_USB_TOP_2P, usb_parents, 0x0B0, 0, 2, 7),
+	MUX_GATE(CLK_TOP_SSUSB_XHCI_2P, usb_parents, 0x0B0, 8, 2, 15),
+	MUX_GATE(CLK_TOP_USB_TOP_3P, usb_parents, 0x0B0, 16, 2, 23),
+	MUX_GATE(CLK_TOP_SSUSB_XHCI_3P, usb_parents, 0x0B0, 24, 2, 31),
 	/* CLK_CFG_13 */
-	MUX_GATE_MIXED(CLK_TOP_I2C, i2c_parents, 0x0BC, 0, 2, 7),
-	MUX_GATE_MIXED(CLK_TOP_SENINF, seninf_parents, 0x0BC, 8, 3, 15),
-	MUX_GATE_MIXED(CLK_TOP_SENINF1, seninf_parents, 0x0BC, 16, 3, 23),
-	MUX_GATE_MIXED(CLK_TOP_SENINF2, seninf_parents, 0x0BC, 24, 3, 31),
+	MUX_GATE(CLK_TOP_I2C, i2c_parents, 0x0BC, 0, 2, 7),
+	MUX_GATE(CLK_TOP_SENINF, seninf_parents, 0x0BC, 8, 3, 15),
+	MUX_GATE(CLK_TOP_SENINF1, seninf_parents, 0x0BC, 16, 3, 23),
+	MUX_GATE(CLK_TOP_SENINF2, seninf_parents, 0x0BC, 24, 3, 31),
 	/* CLK_CFG_14 */
-	MUX_GATE_MIXED(CLK_TOP_SENINF3, seninf_parents, 0x0C8, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_GCPU, gcpu_parents, 0x0C8, 8, 3, 15),
-	MUX_GATE_MIXED(CLK_TOP_DXCC, dxcc_parents, 0x0C8, 16, 2, 23),
-	MUX_GATE_MIXED(CLK_TOP_DPMAIF_MAIN, dpmaif_parents, 0x0C8, 24, 3, 31),
+	MUX_GATE(CLK_TOP_SENINF3, seninf_parents, 0x0C8, 0, 3, 7),
+	MUX_GATE(CLK_TOP_GCPU, gcpu_parents, 0x0C8, 8, 3, 15),
+	MUX_GATE(CLK_TOP_DXCC, dxcc_parents, 0x0C8, 16, 2, 23),
+	MUX_GATE(CLK_TOP_DPMAIF_MAIN, dpmaif_parents, 0x0C8, 24, 3, 31),
 	/* CLK_CFG_15 */
-	MUX_GATE_MIXED(CLK_TOP_AES_UFSFDE, aes_fde_parents, 0x0D4, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_UFS, ufs_parents, 0x0D4, 8, 3, 15),
-	MUX_GATE_MIXED(CLK_TOP_UFS_TICK1US, ufs_tick1us_parents, 0x0D4, 16, 1, 23),
-	MUX_GATE_MIXED(CLK_TOP_UFS_MP_SAP_CFG, ufs_mp_sap_parents, 0x0D4, 24, 1, 31),
+	MUX_GATE(CLK_TOP_AES_UFSFDE, aes_fde_parents, 0x0D4, 0, 3, 7),
+	MUX_GATE(CLK_TOP_UFS, ufs_parents, 0x0D4, 8, 3, 15),
+	MUX_GATE(CLK_TOP_UFS_TICK1US, ufs_tick1us_parents, 0x0D4, 16, 1, 23),
+	MUX_GATE(CLK_TOP_UFS_MP_SAP_CFG, ufs_mp_sap_parents, 0x0D4, 24, 1, 31),
 	/* CLK_CFG_16 */
-	MUX_GATE_MIXED(CLK_TOP_VENC, venc_parents, 0x0E0, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_VDEC, vdec_parents, 0x0E0, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_PWM, pwm_parents, 0x0E0, 16, 1, 23),
-	MUX_GATE_MIXED(CLK_TOP_MCUPM, mcupm_parents, 0x0E0, 24, 2, 31),
+	MUX_GATE(CLK_TOP_VENC, venc_parents, 0x0E0, 0, 4, 7),
+	MUX_GATE(CLK_TOP_VDEC, vdec_parents, 0x0E0, 8, 4, 15),
+	MUX_GATE(CLK_TOP_PWM, pwm_parents, 0x0E0, 16, 1, 23),
+	MUX_GATE(CLK_TOP_MCUPM, mcupm_parents, 0x0E0, 24, 2, 31),
 	/* CLK_CFG_17 */
-	MUX_GATE_MIXED(CLK_TOP_SPMI_P_MST, spmi_parents, 0x0EC, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_SPMI_M_MST, spmi_parents, 0x0EC, 8, 4, 15),
-	MUX_GATE_MIXED(CLK_TOP_DVFSRC, dvfsrc_parents, 0x0EC, 16, 2, 23),
-	MUX_GATE_MIXED(CLK_TOP_TL, tl_parents, 0x0EC, 24, 2, 31),
+	MUX_GATE(CLK_TOP_SPMI_P_MST, spmi_parents, 0x0EC, 0, 4, 7),
+	MUX_GATE(CLK_TOP_SPMI_M_MST, spmi_parents, 0x0EC, 8, 4, 15),
+	MUX_GATE(CLK_TOP_DVFSRC, dvfsrc_parents, 0x0EC, 16, 2, 23),
+	MUX_GATE(CLK_TOP_TL, tl_parents, 0x0EC, 24, 2, 31),
 	/* CLK_CFG_18 */
-	MUX_GATE_MIXED(CLK_TOP_TL_P1, tl_parents, 0x0F8, 0, 2, 7),
-	MUX_GATE_MIXED(CLK_TOP_AES_MSDCFDE, aes_fde_parents, 0x0F8, 8, 3, 15),
-	MUX_GATE_MIXED(CLK_TOP_DSI_OCC, dsi_occ_parents, 0x0F8, 16, 2, 23),
-	MUX_GATE_MIXED(CLK_TOP_WPE_VPP, wpe_vpp_parents, 0x0F8, 24, 4, 31),
+	MUX_GATE(CLK_TOP_TL_P1, tl_parents, 0x0F8, 0, 2, 7),
+	MUX_GATE(CLK_TOP_AES_MSDCFDE, aes_fde_parents, 0x0F8, 8, 3, 15),
+	MUX_GATE(CLK_TOP_DSI_OCC, dsi_occ_parents, 0x0F8, 16, 2, 23),
+	MUX_GATE(CLK_TOP_WPE_VPP, wpe_vpp_parents, 0x0F8, 24, 4, 31),
 	/* CLK_CFG_19 */
-	MUX_GATE_MIXED(CLK_TOP_HDCP, hdcp_parents, 0x0104, 0, 2, 7),
-	MUX_GATE_MIXED(CLK_TOP_HDCP_24M, hdcp_24m_parents, 0x0104, 8, 2, 15),
-	MUX_GATE_MIXED(CLK_TOP_HD20_DACR_REF_CLK, hd20_dacr_ref_parents, 0x0104, 16, 2, 23),
-	MUX_GATE_MIXED(CLK_TOP_HD20_HDCP_CCLK, hd20_hdcp_c_parents, 0x0104, 24, 2, 31),
+	MUX_GATE(CLK_TOP_HDCP, hdcp_parents, 0x0104, 0, 2, 7),
+	MUX_GATE(CLK_TOP_HDCP_24M, hdcp_24m_parents, 0x0104, 8, 2, 15),
+	MUX_GATE(CLK_TOP_HD20_DACR_REF_CLK, hd20_dacr_ref_parents, 0x0104, 16, 2, 23),
+	MUX_GATE(CLK_TOP_HD20_HDCP_CCLK, hd20_hdcp_c_parents, 0x0104, 24, 2, 31),
 	/* CLK_CFG_20 */
-	MUX_GATE_MIXED(CLK_TOP_HDMI_XTAL, hdmi_xtal_parents, 0x0110, 0, 1, 7),
-	MUX_GATE_MIXED(CLK_TOP_HDMI_APB, hdmi_apb_parents, 0x0110, 8, 2, 15),
-	MUX_GATE_MIXED(CLK_TOP_SNPS_ETH_250M, snps_eth_250m_parents, 0x0110, 16, 1, 23),
-	MUX_GATE_MIXED(CLK_TOP_SNPS_ETH_62P4M_PTP, snps_eth_62p4m_ptp_parents, 0x0110, 24, 2, 31),
+	MUX_GATE(CLK_TOP_HDMI_XTAL, hdmi_xtal_parents, 0x0110, 0, 1, 7),
+	MUX_GATE(CLK_TOP_HDMI_APB, hdmi_apb_parents, 0x0110, 8, 2, 15),
+	MUX_GATE(CLK_TOP_SNPS_ETH_250M, snps_eth_250m_parents, 0x0110, 16, 1, 23),
+	MUX_GATE(CLK_TOP_SNPS_ETH_62P4M_PTP, snps_eth_62p4m_ptp_parents, 0x0110, 24, 2, 31),
 	/* CLK_CFG_21 */
-	MUX_GATE_MIXED(CLK_TOP_SNPS_ETH_50M_RMII, snps_eth_50m_rmii_parents, 0x011C, 0, 1, 7),
-	MUX_GATE_MIXED(CLK_TOP_DGI_OUT, dgi_out_parents, 0x011C, 8, 3, 15),
-	MUX_GATE_MIXED(CLK_TOP_NNA0, nna_parents, 0x011C, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_NNA1, nna_parents, 0x011C, 24, 4, 31),
+	MUX_GATE(CLK_TOP_SNPS_ETH_50M_RMII, snps_eth_50m_rmii_parents, 0x011C, 0, 1, 7),
+	MUX_GATE(CLK_TOP_DGI_OUT, dgi_out_parents, 0x011C, 8, 3, 15),
+	MUX_GATE(CLK_TOP_NNA0, nna_parents, 0x011C, 16, 4, 23),
+	MUX_GATE(CLK_TOP_NNA1, nna_parents, 0x011C, 24, 4, 31),
 	/* CLK_CFG_22 */
-	MUX_GATE_MIXED(CLK_TOP_ADSP, adsp_parents, 0x0128, 0, 4, 7),
-	MUX_GATE_MIXED(CLK_TOP_ASM_H, asm_parents, 0x0128, 8, 2, 15),
-	MUX_GATE_MIXED(CLK_TOP_ASM_M, asm_parents, 0x0128, 16, 2, 23),
-	MUX_GATE_MIXED(CLK_TOP_ASM_L, asm_parents, 0x0128, 24, 2, 31),
+	MUX_GATE(CLK_TOP_ADSP, adsp_parents, 0x0128, 0, 4, 7),
+	MUX_GATE(CLK_TOP_ASM_H, asm_parents, 0x0128, 8, 2, 15),
+	MUX_GATE(CLK_TOP_ASM_M, asm_parents, 0x0128, 16, 2, 23),
+	MUX_GATE(CLK_TOP_ASM_L, asm_parents, 0x0128, 24, 2, 31),
 	/* CLK_CFG_23 */
-	MUX_GATE_MIXED(CLK_TOP_APLL1, apll1_parents, 0x0134, 0, 1, 7),
-	MUX_GATE_MIXED(CLK_TOP_APLL2, apll2_parents, 0x0134, 8, 1, 15),
-	MUX_GATE_MIXED(CLK_TOP_APLL3, apll3_parents, 0x0134, 16, 1, 23),
-	MUX_GATE_MIXED(CLK_TOP_APLL4, apll4_parents, 0x0134, 24, 1, 31),
+	MUX_GATE(CLK_TOP_APLL1, apll1_parents, 0x0134, 0, 1, 7),
+	MUX_GATE(CLK_TOP_APLL2, apll2_parents, 0x0134, 8, 1, 15),
+	MUX_GATE(CLK_TOP_APLL3, apll3_parents, 0x0134, 16, 1, 23),
+	MUX_GATE(CLK_TOP_APLL4, apll4_parents, 0x0134, 24, 1, 31),
 	/*
 	 * CLK_CFG_24
 	 * i2so4_mck is not used in MT8195.
 	 */
-	MUX_GATE_MIXED(CLK_TOP_APLL5, apll5_parents, 0x0140, 0, 1, 7),
-	MUX_GATE_MIXED(CLK_TOP_I2SO1_MCK, i2s_parents, 0x0140, 8, 3, 15),
-	MUX_GATE_MIXED(CLK_TOP_I2SO2_MCK, i2s_parents, 0x0140, 16, 3, 23),
+	MUX_GATE(CLK_TOP_APLL5, apll5_parents, 0x0140, 0, 1, 7),
+	MUX_GATE(CLK_TOP_I2SO1_MCK, i2s_parents, 0x0140, 8, 3, 15),
+	MUX_GATE(CLK_TOP_I2SO2_MCK, i2s_parents, 0x0140, 16, 3, 23),
 	/*
 	 * CLK_CFG_25
 	 * i2so5_mck and i2si4_mck are not used in MT8195.
 	 */
-	MUX_GATE_MIXED(CLK_TOP_I2SI1_MCK, i2s_parents, 0x014C, 8, 3, 15),
-	MUX_GATE_MIXED(CLK_TOP_I2SI2_MCK, i2s_parents, 0x014C, 16, 3, 23),
+	MUX_GATE(CLK_TOP_I2SI1_MCK, i2s_parents, 0x014C, 8, 3, 15),
+	MUX_GATE(CLK_TOP_I2SI2_MCK, i2s_parents, 0x014C, 16, 3, 23),
 	/*
 	 * CLK_CFG_26
 	 * i2si5_mck is not used in MT8195.
 	 */
-	MUX_GATE_MIXED(CLK_TOP_DPTX_MCK, i2s_parents, 0x0158, 8, 3, 15),
-	MUX_GATE_MIXED(CLK_TOP_AUD_IEC_CLK, i2s_parents, 0x0158, 16, 3, 23),
-	MUX_GATE_MIXED(CLK_TOP_A1SYS_HP, a1sys_hp_parents, 0x0158, 24, 1, 31),
+	MUX_GATE(CLK_TOP_DPTX_MCK, i2s_parents, 0x0158, 8, 3, 15),
+	MUX_GATE(CLK_TOP_AUD_IEC_CLK, i2s_parents, 0x0158, 16, 3, 23),
+	MUX_GATE(CLK_TOP_A1SYS_HP, a1sys_hp_parents, 0x0158, 24, 1, 31),
 	/* CLK_CFG_27 */
-	MUX_GATE_MIXED(CLK_TOP_A2SYS_HF, a2sys_parents, 0x0164, 0, 1, 7),
-	MUX_GATE_MIXED(CLK_TOP_A3SYS_HF, a3sys_parents, 0x0164, 8, 3, 15),
-	MUX_GATE_MIXED(CLK_TOP_A4SYS_HF, a3sys_parents, 0x0164, 16, 3, 23),
-	MUX_GATE_MIXED(CLK_TOP_SPINFI_BCLK, spinfi_b_parents, 0x0164, 24, 3, 31),
+	MUX_GATE(CLK_TOP_A2SYS_HF, a2sys_parents, 0x0164, 0, 1, 7),
+	MUX_GATE(CLK_TOP_A3SYS_HF, a3sys_parents, 0x0164, 8, 3, 15),
+	MUX_GATE(CLK_TOP_A4SYS_HF, a3sys_parents, 0x0164, 16, 3, 23),
+	MUX_GATE(CLK_TOP_SPINFI_BCLK, spinfi_b_parents, 0x0164, 24, 3, 31),
 	/* CLK_CFG_28 */
-	MUX_GATE_MIXED(CLK_TOP_NFI1X, nfi1x_parents, 0x0170, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_ECC, ecc_parents, 0x0170, 8, 3, 15),
-	MUX_GATE_MIXED(CLK_TOP_AUDIO_LOCAL_BUS, audio_local_bus_parents, 0x0170, 16, 4, 23),
-	MUX_GATE_MIXED(CLK_TOP_SPINOR, spinor_parents, 0x0170, 24, 2, 31),
+	MUX_GATE(CLK_TOP_NFI1X, nfi1x_parents, 0x0170, 0, 3, 7),
+	MUX_GATE(CLK_TOP_ECC, ecc_parents, 0x0170, 8, 3, 15),
+	MUX_GATE(CLK_TOP_AUDIO_LOCAL_BUS, audio_local_bus_parents, 0x0170, 16, 4, 23),
+	MUX_GATE(CLK_TOP_SPINOR, spinor_parents, 0x0170, 24, 2, 31),
 	/* CLK_CFG_29 */
-	MUX_GATE_MIXED(CLK_TOP_DVIO_DGI_REF, dvio_dgi_ref_parents, 0x017C, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_ULPOSC, ulposc_parents, 0x017C, 8, 2, 15),
-	MUX_GATE_MIXED(CLK_TOP_ULPOSC_CORE, ulposc_core_parents, 0x017C, 16, 2, 23),
-	MUX_GATE_MIXED(CLK_TOP_SRCK, srck_parents, 0x017C, 24, 1, 31),
+	MUX_GATE(CLK_TOP_DVIO_DGI_REF, dvio_dgi_ref_parents, 0x017C, 0, 3, 7),
+	MUX_GATE(CLK_TOP_ULPOSC, ulposc_parents, 0x017C, 8, 2, 15),
+	MUX_GATE(CLK_TOP_ULPOSC_CORE, ulposc_core_parents, 0x017C, 16, 2, 23),
+	MUX_GATE(CLK_TOP_SRCK, srck_parents, 0x017C, 24, 1, 31),
 };
 
 static const struct mtk_gate_regs top0_cg_regs = {
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 41dd2479c5a..c6803090f35 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -586,59 +586,59 @@ static const struct mtk_parent apu_parents[] = {
 
 static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_0 */
-	MUX_GATE_MIXED(CLK_TOP_AXI_SEL, axi_parents, 0x040, 0, 2, 7),
-	MUX_GATE_MIXED(CLK_TOP_MEM_SEL, mem_parents, 0x040, 8, 2, 15),
-	MUX_GATE_MIXED(CLK_TOP_MM_SEL, mm_parents, 0x040, 16, 3, 23),
-	MUX_GATE_MIXED(CLK_TOP_SCP_SEL, scp_parents, 0x040, 24, 3, 31),
+	MUX_GATE(CLK_TOP_AXI_SEL, axi_parents, 0x040, 0, 2, 7),
+	MUX_GATE(CLK_TOP_MEM_SEL, mem_parents, 0x040, 8, 2, 15),
+	MUX_GATE(CLK_TOP_MM_SEL, mm_parents, 0x040, 16, 3, 23),
+	MUX_GATE(CLK_TOP_SCP_SEL, scp_parents, 0x040, 24, 3, 31),
 	/* CLK_CFG_1 */
-	MUX_GATE_MIXED(CLK_TOP_MFG_SEL, mfg_parents, 0x050, 0, 2, 7),
-	MUX_GATE_MIXED(CLK_TOP_ATB_SEL, atb_parents, 0x050, 8, 2, 15),
-	MUX_GATE_MIXED(CLK_TOP_CAMTG_SEL, camtg_parents, 0x050, 16, 3, 23),
-	MUX_GATE_MIXED(CLK_TOP_CAMTG1_SEL, camtg_parents, 0x050, 24, 3, 31),
+	MUX_GATE(CLK_TOP_MFG_SEL, mfg_parents, 0x050, 0, 2, 7),
+	MUX_GATE(CLK_TOP_ATB_SEL, atb_parents, 0x050, 8, 2, 15),
+	MUX_GATE(CLK_TOP_CAMTG_SEL, camtg_parents, 0x050, 16, 3, 23),
+	MUX_GATE(CLK_TOP_CAMTG1_SEL, camtg_parents, 0x050, 24, 3, 31),
 	/* CLK_CFG_2 */
-	MUX_GATE_MIXED(CLK_TOP_UART_SEL, uart_parents, 0x060, 0, 1, 7),
-	MUX_GATE_MIXED(CLK_TOP_SPI_SEL, spi_parents, 0x060, 8, 2, 15),
-	MUX_GATE_MIXED(CLK_TOP_MSDC50_0_HC_SEL, msdc50_0_hc_parents, 0x060, 16, 2, 23),
-	MUX_GATE_MIXED(CLK_TOP_MSDC2_2_HC_SEL, msdc50_0_hc_parents, 0x060, 24, 2, 31),
+	MUX_GATE(CLK_TOP_UART_SEL, uart_parents, 0x060, 0, 1, 7),
+	MUX_GATE(CLK_TOP_SPI_SEL, spi_parents, 0x060, 8, 2, 15),
+	MUX_GATE(CLK_TOP_MSDC50_0_HC_SEL, msdc50_0_hc_parents, 0x060, 16, 2, 23),
+	MUX_GATE(CLK_TOP_MSDC2_2_HC_SEL, msdc50_0_hc_parents, 0x060, 24, 2, 31),
 	/* CLK_CFG_3 */
-	MUX_GATE_MIXED(CLK_TOP_MSDC50_0_SEL, msdc50_0_parents, 0x070, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_MSDC50_2_SEL, msdc50_2_parents, 0x070, 8, 3, 15),
-	MUX_GATE_MIXED(CLK_TOP_MSDC30_1_SEL, msdc30_1_parents, 0x070, 16, 3, 23),
-	MUX_GATE_MIXED(CLK_TOP_AUDIO_SEL, audio_parents, 0x070, 24, 2, 31),
+	MUX_GATE(CLK_TOP_MSDC50_0_SEL, msdc50_0_parents, 0x070, 0, 3, 7),
+	MUX_GATE(CLK_TOP_MSDC50_2_SEL, msdc50_2_parents, 0x070, 8, 3, 15),
+	MUX_GATE(CLK_TOP_MSDC30_1_SEL, msdc30_1_parents, 0x070, 16, 3, 23),
+	MUX_GATE(CLK_TOP_AUDIO_SEL, audio_parents, 0x070, 24, 2, 31),
 	/* CLK_CFG_4 */
-	MUX_GATE_MIXED(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents, 0x080, 0, 2, 7),
-	MUX_GATE_MIXED(CLK_TOP_AUD_1_SEL, aud_1_parents, 0x080, 8, 1, 15),
-	MUX_GATE_MIXED(CLK_TOP_AUD_2_SEL, aud_2_parents, 0x080, 16, 1, 23),
-	MUX_GATE_MIXED(CLK_TOP_AUD_ENGEN1_SEL, aud_engen1_parents, 0x080, 24, 2, 31),
+	MUX_GATE(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents, 0x080, 0, 2, 7),
+	MUX_GATE(CLK_TOP_AUD_1_SEL, aud_1_parents, 0x080, 8, 1, 15),
+	MUX_GATE(CLK_TOP_AUD_2_SEL, aud_2_parents, 0x080, 16, 1, 23),
+	MUX_GATE(CLK_TOP_AUD_ENGEN1_SEL, aud_engen1_parents, 0x080, 24, 2, 31),
 	/* CLK_CFG_5 */
-	MUX_GATE_MIXED(CLK_TOP_AUD_ENGEN2_SEL, aud_engen2_parents, 0x090, 0, 2, 7),
-	MUX_GATE_MIXED(CLK_TOP_AUD_SPDIF_SEL, aud_spdif_parents, 0x090, 8, 1, 15),
-	MUX_GATE_MIXED(CLK_TOP_DISP_PWM_SEL, disp_pwm_parents, 0x090, 16, 2, 23),
+	MUX_GATE(CLK_TOP_AUD_ENGEN2_SEL, aud_engen2_parents, 0x090, 0, 2, 7),
+	MUX_GATE(CLK_TOP_AUD_SPDIF_SEL, aud_spdif_parents, 0x090, 8, 1, 15),
+	MUX_GATE(CLK_TOP_DISP_PWM_SEL, disp_pwm_parents, 0x090, 16, 2, 23),
 	/* CLK_CFG_6 */
-	MUX_GATE_MIXED(CLK_TOP_DXCC_SEL, dxcc_parents, 0x0a0, 0, 2, 7),
-	MUX_GATE_MIXED(CLK_TOP_SSUSB_SYS_SEL, ssusb_sys_parents, 0x0a0, 8, 2, 15),
-	MUX_GATE_MIXED(CLK_TOP_SSUSB_XHCI_SEL, ssusb_sys_parents, 0x0a0, 16, 2, 23),
-	MUX_GATE_MIXED(CLK_TOP_SPM_SEL, spm_parents, 0x0a0, 24, 1, 31),
+	MUX_GATE(CLK_TOP_DXCC_SEL, dxcc_parents, 0x0a0, 0, 2, 7),
+	MUX_GATE(CLK_TOP_SSUSB_SYS_SEL, ssusb_sys_parents, 0x0a0, 8, 2, 15),
+	MUX_GATE(CLK_TOP_SSUSB_XHCI_SEL, ssusb_sys_parents, 0x0a0, 16, 2, 23),
+	MUX_GATE(CLK_TOP_SPM_SEL, spm_parents, 0x0a0, 24, 1, 31),
 	/* CLK_CFG_7 */
-	MUX_GATE_MIXED(CLK_TOP_I2C_SEL, i2c_parents, 0x0b0, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_PWM_SEL, pwm_parents, 0x0b0, 8, 2, 15),
-	MUX_GATE_MIXED(CLK_TOP_SENIF_SEL, senif_parents, 0x0b0, 16, 2, 23),
-	MUX_GATE_MIXED(CLK_TOP_AES_FDE_SEL, aes_fde_parents, 0x0b0, 24, 3, 31),
+	MUX_GATE(CLK_TOP_I2C_SEL, i2c_parents, 0x0b0, 0, 3, 7),
+	MUX_GATE(CLK_TOP_PWM_SEL, pwm_parents, 0x0b0, 8, 2, 15),
+	MUX_GATE(CLK_TOP_SENIF_SEL, senif_parents, 0x0b0, 16, 2, 23),
+	MUX_GATE(CLK_TOP_AES_FDE_SEL, aes_fde_parents, 0x0b0, 24, 3, 31),
 	/* CLK_CFG_8 */
-	MUX_GATE_MIXED(CLK_TOP_CAMTM_SEL, senif_parents, 0x0c0, 0, 2, 7),
-	MUX_GATE_MIXED(CLK_TOP_DPI0_SEL, dpi0_parents, 0x0c0, 8, 3, 15),
-	MUX_GATE_MIXED(CLK_TOP_DPI1_SEL, dpi0_parents, 0x0c0, 16, 3, 23),
-	MUX_GATE_MIXED(CLK_TOP_DSP_SEL, dsp_parents, 0x0c0, 24, 3, 31),
+	MUX_GATE(CLK_TOP_CAMTM_SEL, senif_parents, 0x0c0, 0, 2, 7),
+	MUX_GATE(CLK_TOP_DPI0_SEL, dpi0_parents, 0x0c0, 8, 3, 15),
+	MUX_GATE(CLK_TOP_DPI1_SEL, dpi0_parents, 0x0c0, 16, 3, 23),
+	MUX_GATE(CLK_TOP_DSP_SEL, dsp_parents, 0x0c0, 24, 3, 31),
 	/* CLK_CFG_9 */
-	MUX_GATE_MIXED(CLK_TOP_NFI2X_SEL, nfi2x_parents, 0x0d0, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_NFIECC_SEL, nfiecc_parents, 0x0d0, 8, 3, 15),
-	MUX_GATE_MIXED(CLK_TOP_ECC_SEL, ecc_parents, 0x0d0, 16, 3, 23),
-	MUX_GATE_MIXED(CLK_TOP_ETH_SEL, eth_parents, 0x0d0, 24, 3, 31),
+	MUX_GATE(CLK_TOP_NFI2X_SEL, nfi2x_parents, 0x0d0, 0, 3, 7),
+	MUX_GATE(CLK_TOP_NFIECC_SEL, nfiecc_parents, 0x0d0, 8, 3, 15),
+	MUX_GATE(CLK_TOP_ECC_SEL, ecc_parents, 0x0d0, 16, 3, 23),
+	MUX_GATE(CLK_TOP_ETH_SEL, eth_parents, 0x0d0, 24, 3, 31),
 	/* CLK_CFG_10 */
-	MUX_GATE_MIXED(CLK_TOP_GCPU_SEL, gcpu_parents, 0x0e0, 0, 3, 7),
-	MUX_GATE_MIXED(CLK_TOP_GCPU_CPM_SEL, gcpu_cpm_parents, 0x0e0, 8, 2, 15),
-	MUX_GATE_MIXED(CLK_TOP_APU_SEL, apu_parents, 0x0e0, 16, 3, 23),
-	MUX_GATE_MIXED(CLK_TOP_APU_IF_SEL, apu_parents, 0x0e0, 24, 3, 31),
+	MUX_GATE(CLK_TOP_GCPU_SEL, gcpu_parents, 0x0e0, 0, 3, 7),
+	MUX_GATE(CLK_TOP_GCPU_CPM_SEL, gcpu_cpm_parents, 0x0e0, 8, 2, 15),
+	MUX_GATE(CLK_TOP_APU_SEL, apu_parents, 0x0e0, 16, 3, 23),
+	MUX_GATE(CLK_TOP_APU_IF_SEL, apu_parents, 0x0e0, 24, 3, 31),
 };
 
 /* topckgen cg */
diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index 0ea600b577a..de0d3eae7ee 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -450,150 +450,150 @@ static const struct mtk_parent occ_182m_parents[] = {
 
 static const struct mtk_composite top_muxes[] = {
 	/* CLK_CFG_0 */
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_AXI_SEL, axi_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_AXI_SEL, axi_parents,
 			      0x040, 0x044, 0x048, 0, 3, 7,
 			      0x4, 0, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_MEM_SEL, mem_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_MEM_SEL, mem_parents,
 			      0x040, 0x044, 0x048, 8, 2, 15,
 			      0x4, 1, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_UART_SEL, uart_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_UART_SEL, uart_parents,
 			      0x040, 0x044, 0x048, 16, 1, 23,
 			      0x4, 2, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_SPI_SEL, spi_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_SPI_SEL, spi_parents,
 			      0x040, 0x044, 0x048, 24, 3, 31,
 			      0x4, 3, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_1 */
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_SPIS_SEL, spis_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_SPIS_SEL, spis_parents,
 			      0x050, 0x054, 0x058, 0, 3, 7,
 			      0x4, 4, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_HC_SEL, msdc50_0_hc_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_HC_SEL, msdc50_0_hc_parents,
 			      0x050, 0x054, 0x058, 8, 2, 15,
 			      0x4, 5, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC2_2_HC_SEL, msdc50_0_hc_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC2_2_HC_SEL, msdc50_0_hc_parents,
 			      0x050, 0x054, 0x058, 16, 2, 23,
 			      0x4, 6, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_SEL, msdc50_0_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_SEL, msdc50_0_parents,
 			      0x050, 0x054, 0x058, 24, 3, 31,
 			      0x4, 7, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_2 */
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_2_SEL, msdc50_2_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_2_SEL, msdc50_2_parents,
 			      0x060, 0x064, 0x068, 0, 3, 7,
 			      0x4, 8, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC30_1_SEL, msdc50_0_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC30_1_SEL, msdc50_0_parents,
 			      0x060, 0x064, 0x068, 8, 3, 15,
 			      0x4, 9, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_AUDIO_SEL, audio_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_AUDIO_SEL, audio_parents,
 			      0x060, 0x064, 0x068, 16, 2, 23,
 			      0x4, 10, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents,
 			      0x060, 0x064, 0x068, 24, 3, 31,
 			      0x4, 11, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_3 */
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_HAPLL1_SEL, hapll1_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_HAPLL1_SEL, hapll1_parents,
 			      0x070, 0x074, 0x078, 0, 3, 7,
 			      0x4, 12, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_HAPLL2_SEL, hapll2_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_HAPLL2_SEL, hapll2_parents,
 			      0x070, 0x074, 0x078, 8, 3, 15,
 			      0x4, 13, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_A2SYS_SEL, hapll1_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_A2SYS_SEL, hapll1_parents,
 			      0x070, 0x074, 0x078, 16, 3, 23,
 			      0x4, 14, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_A1SYS_SEL, hapll2_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_A1SYS_SEL, hapll2_parents,
 			      0x070, 0x074, 0x078, 24, 3, 31,
 			      0x4, 15, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_4 */
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_ASM_L_SEL, asm_l_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_ASM_L_SEL, asm_l_parents,
 			      0x080, 0x084, 0x088, 0, 2, 7,
 			      0x4, 16, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_ASM_M_SEL, asm_l_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_ASM_M_SEL, asm_l_parents,
 			      0x080, 0x084, 0x088, 8, 2, 15,
 			      0x4, 17, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_ASM_H_SEL, asm_l_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_ASM_H_SEL, asm_l_parents,
 			      0x080, 0x084, 0x088, 16, 2, 23,
 			      0x4, 18, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_AUD_SPDIF_SEL, aud_spdif_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_AUD_SPDIF_SEL, aud_spdif_parents,
 			      0x080, 0x084, 0x088, 24, 2, 31,
 			      0x4, 19, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_5 */
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_AUD_1_SEL, aud_1_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_AUD_1_SEL, aud_1_parents,
 			      0x090, 0x094, 0x098, 0, 1, 7,
 			      0x4, 20, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_AUD_2_SEL, aud_2_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_AUD_2_SEL, aud_2_parents,
 			      0x090, 0x094, 0x098, 8, 1, 15,
 			      0x4, 21, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_SSUSB_SYS_SEL, ssusb_sys_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_SSUSB_SYS_SEL, ssusb_sys_parents,
 			      0x090, 0x094, 0x098, 16, 2, 23,
 			      0x4, 22, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_SSUSB_XHCI_SEL, ssusb_sys_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_SSUSB_XHCI_SEL, ssusb_sys_parents,
 			      0x090, 0x094, 0x098, 24, 2, 31,
 			      0x4, 23, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_6 */
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_SPM_SEL, spm_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_SPM_SEL, spm_parents,
 			      0x0a0, 0x0a4, 0x0a8, 0, 1, 7,
 			      0x4, 24, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_I2C_SEL, i2c_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_I2C_SEL, i2c_parents,
 			      0x0a0, 0x0a4, 0x0a8, 8, 3, 15,
 			      0x4, 25, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_PWM_SEL, pwm_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_PWM_SEL, pwm_parents,
 			      0x0a0, 0x0a4, 0x0a8, 16, 3, 23,
 			      0x4, 26, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_DSP_SEL, dsp_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_DSP_SEL, dsp_parents,
 			      0x0a0, 0x0a4, 0x0a8, 24, 3, 31,
 			      0x4, 27, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_7 */
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_NFI2X_SEL, nfi2x_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_NFI2X_SEL, nfi2x_parents,
 			      0x0b0, 0x0b4, 0x0b8, 0, 3, 7,
 			      0x4, 28, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_SPINFI_SEL, spinfi_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_SPINFI_SEL, spinfi_parents,
 			      0x0b0, 0x0b4, 0x0b8, 8, 3, 15,
 			      0x4, 29, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_ECC_SEL, ecc_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_ECC_SEL, ecc_parents,
 			      0x0b0, 0x0b4, 0x0b8, 16, 2, 23,
 			      0x4, 30, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_GCPU_SEL, gcpu_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_GCPU_SEL, gcpu_parents,
 			      0x0b0, 0x0b4, 0x0b8, 24, 3, 31,
 			      0x4, 31, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_8 */
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_GCPU_CPM_SEL, gcpu_cpm_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_GCPU_CPM_SEL, gcpu_cpm_parents,
 			      0x0c0, 0x0c4, 0x0c8, 0, 2, 7,
 			      0x8, 0, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_MBIST_DIAG_SEL, mbist_diag_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_MBIST_DIAG_SEL, mbist_diag_parents,
 			      0x0c0, 0x0c4, 0x0c8, 8, 1, 15,
 			      0x8, 1, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_IP0_NNA_SEL, ip0_nna_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_IP0_NNA_SEL, ip0_nna_parents,
 			      0x0c0, 0x0c4, 0x0c8, 16, 3, 23,
 			      0x8, 2, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_IP1_NNA_SEL, ip0_nna_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_IP1_NNA_SEL, ip0_nna_parents,
 			      0x0c0, 0x0c4, 0x0c8, 24, 3, 31,
 			      0x8, 3, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_9 */
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_IP2_WFST_SEL, ip2_wfst_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_IP2_WFST_SEL, ip2_wfst_parents,
 			      0x0d0, 0x0d4, 0x0d8, 0, 3, 7,
 			      0x8, 4, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_SFLASH_SEL, sflash_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_SFLASH_SEL, sflash_parents,
 			      0x0d0, 0x0d4, 0x0d8, 8, 3, 15,
 			      0x8, 5, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_SRAM_SEL, sram_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_SRAM_SEL, sram_parents,
 			      0x0d0, 0x0d4, 0x0d8, 16, 3, 23,
 			      0x8, 6, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_MM_SEL, mm_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_MM_SEL, mm_parents,
 			      0x0d0, 0x0d4, 0x0d8, 24, 3, 31,
 			      0x8, 7, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_10 */
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_DPI0_SEL, dpi0_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_DPI0_SEL, dpi0_parents,
 			      0x0e0, 0x0e4, 0x0e8, 0, 3, 7,
 			      0x8, 8, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_DBG_ATCLK_SEL, dbg_atclk_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_DBG_ATCLK_SEL, dbg_atclk_parents,
 			      0x0e0, 0x0e4, 0x0e8, 8, 2, 15,
 			      0x8, 9, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_OCC_104M_SEL, occ_104m_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_OCC_104M_SEL, occ_104m_parents,
 			      0x0e0, 0x0e4, 0x0e8, 16, 1, 23,
 			      0x8, 10, CLK_MUX_SETCLR_UPD),
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_OCC_68M_SEL, occ_68m_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_OCC_68M_SEL, occ_68m_parents,
 			      0x0e0, 0x0e4, 0x0e8, 24, 1, 31,
 			      0x8, 11, CLK_MUX_SETCLR_UPD),
 	/* CLK_CFG_11 */
-	MUX_MIXED_CLR_SET_UPD_FLAGS(CLK_TOP_OCC_182M_SEL, occ_182m_parents,
+	MUX_CLR_SET_UPD_FLAGS(CLK_TOP_OCC_182M_SEL, occ_182m_parents,
 			      0x0ec, 0x0f0, 0x0f4, 0, 2, 7,
 			      0x8, 12, CLK_MUX_SETCLR_UPD),
 };
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index bf62a4aa3a4..6b30ea9ce4a 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -495,53 +495,53 @@ static const struct mtk_parent nfiecc_parents[] = {
 
 static const struct mtk_composite top_muxes[] = {
 	/* CLK_MUX_SEL0 */
-	MUX_MIXED(CLK_TOP_UART0_SEL, uart0_parents, 0x000, 0, 1),
-	MUX_MIXED(CLK_TOP_GFMUX_EMI1X_SEL, gfmux_emi1x_parents, 0x000, 1, 1),
-	MUX_MIXED(CLK_TOP_EMI_DDRPHY_SEL, emi_ddrphy_parents, 0x000, 2, 1),
-	MUX_MIXED(CLK_TOP_AHB_INFRA_SEL, ahb_infra_parents, 0x000, 4, 4),
-	MUX_MIXED(CLK_TOP_CSW_MUX_MFG_SEL, csw_mux_mfg_parents, 0x000, 8, 3),
-	MUX_MIXED(CLK_TOP_MSDC0_SEL, msdc0_parents, 0x000, 11, 3),
-	MUX_MIXED(CLK_TOP_PWM_MM_SEL, pwm_mm_parents, 0x000, 18, 1),
-	MUX_MIXED(CLK_TOP_UART1_SEL, uart1_parents, 0x000, 19, 1),
-	MUX_MIXED(CLK_TOP_MSDC1_SEL, msdc1_parents, 0x000, 20, 3),
-	MUX_MIXED(CLK_TOP_SPM_52M_SEL, spm_52m_parents, 0x000, 23, 1),
-	MUX_MIXED(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x000, 24, 2),
-	MUX_MIXED(CLK_TOP_QAXI_AUD26M_SEL, qaxi_aud26m_parents, 0x000, 26, 1),
-	MUX_MIXED(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents, 0x000, 27, 3),
+	MUX(CLK_TOP_UART0_SEL, uart0_parents, 0x000, 0, 1),
+	MUX(CLK_TOP_GFMUX_EMI1X_SEL, gfmux_emi1x_parents, 0x000, 1, 1),
+	MUX(CLK_TOP_EMI_DDRPHY_SEL, emi_ddrphy_parents, 0x000, 2, 1),
+	MUX(CLK_TOP_AHB_INFRA_SEL, ahb_infra_parents, 0x000, 4, 4),
+	MUX(CLK_TOP_CSW_MUX_MFG_SEL, csw_mux_mfg_parents, 0x000, 8, 3),
+	MUX(CLK_TOP_MSDC0_SEL, msdc0_parents, 0x000, 11, 3),
+	MUX(CLK_TOP_PWM_MM_SEL, pwm_mm_parents, 0x000, 18, 1),
+	MUX(CLK_TOP_UART1_SEL, uart1_parents, 0x000, 19, 1),
+	MUX(CLK_TOP_MSDC1_SEL, msdc1_parents, 0x000, 20, 3),
+	MUX(CLK_TOP_SPM_52M_SEL, spm_52m_parents, 0x000, 23, 1),
+	MUX(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x000, 24, 2),
+	MUX(CLK_TOP_QAXI_AUD26M_SEL, qaxi_aud26m_parents, 0x000, 26, 1),
+	MUX(CLK_TOP_AUD_INTBUS_SEL, aud_intbus_parents, 0x000, 27, 3),
 	/* CLK_MUX_SEL1 */
-	MUX_MIXED(CLK_TOP_NFI2X_PAD_SEL, nfi2x_pad_parents, 0x004, 0, 7),
-	MUX_MIXED(CLK_TOP_NFI1X_PAD_SEL, nfi1x_pad_parents, 0x004, 7, 1),
-	MUX_MIXED(CLK_TOP_MFG_MM_SEL, mfg_mm_parents, 0x004, 8, 6),
-	MUX_MIXED(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x004, 15, 1),
-	MUX_MIXED(CLK_TOP_USB_78M_SEL, usb_78m_parents, 0x004, 20, 3),
+	MUX(CLK_TOP_NFI2X_PAD_SEL, nfi2x_pad_parents, 0x004, 0, 7),
+	MUX(CLK_TOP_NFI1X_PAD_SEL, nfi1x_pad_parents, 0x004, 7, 1),
+	MUX(CLK_TOP_MFG_MM_SEL, mfg_mm_parents, 0x004, 8, 6),
+	MUX(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x004, 15, 1),
+	MUX(CLK_TOP_USB_78M_SEL, usb_78m_parents, 0x004, 20, 3),
 	/* CLK_MUX_SEL8 */
-	MUX_MIXED(CLK_TOP_SPINOR_SEL, spinor_parents, 0x040, 0, 3),
-	MUX_MIXED(CLK_TOP_MSDC2_SEL, msdc2_parents, 0x040, 3, 3),
-	MUX_MIXED(CLK_TOP_ETH_SEL, eth_parents, 0x040, 6, 3),
-	MUX_MIXED(CLK_TOP_AXI_MFG_IN_SEL, axi_mfg_in_parents, 0x040, 18, 2),
-	MUX_MIXED(CLK_TOP_SLOW_MFG_SEL, slow_mfg_parents, 0x040, 20, 2),
-	MUX_MIXED(CLK_TOP_AUD1_SEL, aud1_parents, 0x040, 22, 1),
-	MUX_MIXED(CLK_TOP_AUD2_SEL, aud2_parents, 0x040, 23, 1),
-	MUX_MIXED(CLK_TOP_AUD_ENGEN1_SEL, aud_engen1_parents, 0x040, 24, 2),
-	MUX_MIXED(CLK_TOP_AUD_ENGEN2_SEL, aud_engen2_parents, 0x040, 26, 2),
-	MUX_MIXED(CLK_TOP_I2C_SEL, i2c_parents, 0x040, 28, 2),
+	MUX(CLK_TOP_SPINOR_SEL, spinor_parents, 0x040, 0, 3),
+	MUX(CLK_TOP_MSDC2_SEL, msdc2_parents, 0x040, 3, 3),
+	MUX(CLK_TOP_ETH_SEL, eth_parents, 0x040, 6, 3),
+	MUX(CLK_TOP_AXI_MFG_IN_SEL, axi_mfg_in_parents, 0x040, 18, 2),
+	MUX(CLK_TOP_SLOW_MFG_SEL, slow_mfg_parents, 0x040, 20, 2),
+	MUX(CLK_TOP_AUD1_SEL, aud1_parents, 0x040, 22, 1),
+	MUX(CLK_TOP_AUD2_SEL, aud2_parents, 0x040, 23, 1),
+	MUX(CLK_TOP_AUD_ENGEN1_SEL, aud_engen1_parents, 0x040, 24, 2),
+	MUX(CLK_TOP_AUD_ENGEN2_SEL, aud_engen2_parents, 0x040, 26, 2),
+	MUX(CLK_TOP_I2C_SEL, i2c_parents, 0x040, 28, 2),
 	/* CLK_MUX_SEL9 */
-	MUX_MIXED(CLK_TOP_AUD_I2S0_M_SEL, aud_i2s0_m_parents, 0x044, 12, 1),
-	MUX_MIXED(CLK_TOP_AUD_I2S1_M_SEL, aud_i2s0_m_parents, 0x044, 13, 1),
-	MUX_MIXED(CLK_TOP_AUD_I2S2_M_SEL, aud_i2s0_m_parents, 0x044, 14, 1),
-	MUX_MIXED(CLK_TOP_AUD_I2S3_M_SEL, aud_i2s0_m_parents, 0x044, 15, 1),
-	MUX_MIXED(CLK_TOP_AUD_I2S4_M_SEL, aud_i2s0_m_parents, 0x044, 16, 1),
-	MUX_MIXED(CLK_TOP_AUD_I2S5_M_SEL, aud_i2s0_m_parents, 0x044, 17, 1),
-	MUX_MIXED(CLK_TOP_AUD_SPDIF_B_SEL, aud_i2s0_m_parents, 0x044, 18, 1),
+	MUX(CLK_TOP_AUD_I2S0_M_SEL, aud_i2s0_m_parents, 0x044, 12, 1),
+	MUX(CLK_TOP_AUD_I2S1_M_SEL, aud_i2s0_m_parents, 0x044, 13, 1),
+	MUX(CLK_TOP_AUD_I2S2_M_SEL, aud_i2s0_m_parents, 0x044, 14, 1),
+	MUX(CLK_TOP_AUD_I2S3_M_SEL, aud_i2s0_m_parents, 0x044, 15, 1),
+	MUX(CLK_TOP_AUD_I2S4_M_SEL, aud_i2s0_m_parents, 0x044, 16, 1),
+	MUX(CLK_TOP_AUD_I2S5_M_SEL, aud_i2s0_m_parents, 0x044, 17, 1),
+	MUX(CLK_TOP_AUD_SPDIF_B_SEL, aud_i2s0_m_parents, 0x044, 18, 1),
 	/* CLK_MUX_SEL13 */
-	MUX_MIXED(CLK_TOP_PWM_SEL, pwm_parents, 0x07c, 0, 1),
-	MUX_MIXED(CLK_TOP_SPI_SEL, spi_parents, 0x07c, 1, 2),
-	MUX_MIXED(CLK_TOP_AUD_SPDIFIN_SEL, aud_spdifin_parents, 0x07c, 3, 1),
-	MUX_MIXED(CLK_TOP_UART2_SEL, uart2_parents, 0x07c, 4, 1),
-	MUX_MIXED(CLK_TOP_BSI_SEL, bsi_parents, 0x07c, 5, 2),
-	MUX_MIXED(CLK_TOP_DBG_ATCLK_SEL, dbg_atclk_parents, 0x07c, 7, 3),
-	MUX_MIXED(CLK_TOP_CSW_NFIECC_SEL, csw_nfiecc_parents, 0x07c, 10, 3),
-	MUX_MIXED(CLK_TOP_NFIECC_SEL, nfiecc_parents, 0x07c, 13, 3),
+	MUX(CLK_TOP_PWM_SEL, pwm_parents, 0x07c, 0, 1),
+	MUX(CLK_TOP_SPI_SEL, spi_parents, 0x07c, 1, 2),
+	MUX(CLK_TOP_AUD_SPDIFIN_SEL, aud_spdifin_parents, 0x07c, 3, 1),
+	MUX(CLK_TOP_UART2_SEL, uart2_parents, 0x07c, 4, 1),
+	MUX(CLK_TOP_BSI_SEL, bsi_parents, 0x07c, 5, 2),
+	MUX(CLK_TOP_DBG_ATCLK_SEL, dbg_atclk_parents, 0x07c, 7, 3),
+	MUX(CLK_TOP_CSW_NFIECC_SEL, csw_nfiecc_parents, 0x07c, 10, 3),
+	MUX(CLK_TOP_NFIECC_SEL, nfiecc_parents, 0x07c, 13, 3),
 };
 
 static const struct mtk_gate_regs top0_cg_regs = {
diff --git a/drivers/clk/mediatek/clk-mt8518.c b/drivers/clk/mediatek/clk-mt8518.c
index 482d1346da5..34fa5a127d5 100644
--- a/drivers/clk/mediatek/clk-mt8518.c
+++ b/drivers/clk/mediatek/clk-mt8518.c
@@ -1182,77 +1182,77 @@ static const struct mtk_parent disp_dpi_ck_parents[] = {
 
 static const struct mtk_composite top_muxes[] = {
 	/* CLK_MUX_SEL0 */
-	MUX_MIXED(CLK_TOP_UART0_SEL, uart0_parents, 0x000, 0, 1),
-	MUX_MIXED(CLK_TOP_EMI1X_SEL, emi1x_parents, 0x000, 1, 1),
-	MUX_MIXED(CLK_TOP_EMI_DDRPHY_SEL, emi_ddrphy_parents, 0x000, 2, 1),
-	MUX_MIXED(CLK_TOP_MSDC1_SEL, msdc1_parents, 0x000, 4, 8),
-	MUX_MIXED(CLK_TOP_PWM_MM_SEL, pwm_mm_parents, 0x000, 18, 1),
-	MUX_MIXED(CLK_TOP_UART1_SEL, uart0_parents, 0x000, 19, 1),
-	MUX_MIXED(CLK_TOP_SPM_52M_SEL, uart0_parents, 0x000, 22, 1),
-	MUX_MIXED(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x000, 23, 3),
+	MUX(CLK_TOP_UART0_SEL, uart0_parents, 0x000, 0, 1),
+	MUX(CLK_TOP_EMI1X_SEL, emi1x_parents, 0x000, 1, 1),
+	MUX(CLK_TOP_EMI_DDRPHY_SEL, emi_ddrphy_parents, 0x000, 2, 1),
+	MUX(CLK_TOP_MSDC1_SEL, msdc1_parents, 0x000, 4, 8),
+	MUX(CLK_TOP_PWM_MM_SEL, pwm_mm_parents, 0x000, 18, 1),
+	MUX(CLK_TOP_UART1_SEL, uart0_parents, 0x000, 19, 1),
+	MUX(CLK_TOP_SPM_52M_SEL, uart0_parents, 0x000, 22, 1),
+	MUX(CLK_TOP_PMICSPI_SEL, pmicspi_parents, 0x000, 23, 3),
 	/* CLK_MUX_SEL1 */
-	MUX_MIXED(CLK_TOP_NFI2X_SEL, nfi2x_parents, 0x004, 0, 3),
-	MUX_MIXED(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x004, 15, 1),
-	MUX_MIXED(CLK_TOP_SMI_SEL, smi_parents, 0x004, 16, 4),
-	MUX_MIXED(CLK_TOP_USB_SEL, usb_parents, 0x004, 20, 3),
+	MUX(CLK_TOP_NFI2X_SEL, nfi2x_parents, 0x004, 0, 3),
+	MUX(CLK_TOP_DDRPHYCFG_SEL, ddrphycfg_parents, 0x004, 15, 1),
+	MUX(CLK_TOP_SMI_SEL, smi_parents, 0x004, 16, 4),
+	MUX(CLK_TOP_USB_SEL, usb_parents, 0x004, 20, 3),
 	/* CLK_MUX_SEL8 */
-	MUX_MIXED(CLK_TOP_SPINOR_SEL, spinor_parents, 0x040, 0, 3),
-	MUX_MIXED(CLK_TOP_ETH_SEL, eth_parents, 0x040, 6, 3),
-	MUX_MIXED(CLK_TOP_AUD1_SEL, aud1_parents, 0x040, 22, 1),
-	MUX_MIXED(CLK_TOP_AUD2_SEL, aud2_parents, 0x040, 23, 1),
-	MUX_MIXED(CLK_TOP_I2C_SEL, i2c_parents, 0x040, 28, 3),
+	MUX(CLK_TOP_SPINOR_SEL, spinor_parents, 0x040, 0, 3),
+	MUX(CLK_TOP_ETH_SEL, eth_parents, 0x040, 6, 3),
+	MUX(CLK_TOP_AUD1_SEL, aud1_parents, 0x040, 22, 1),
+	MUX(CLK_TOP_AUD2_SEL, aud2_parents, 0x040, 23, 1),
+	MUX(CLK_TOP_I2C_SEL, i2c_parents, 0x040, 28, 3),
 	/* CLK_SEL_9 */
-	MUX_MIXED(CLK_TOP_AUD_I2S0_M_SEL, aud_i2s0_m_parents, 0x044, 12, 1),
-	MUX_MIXED(CLK_TOP_AUD_I2S3_M_SEL, aud_i2s0_m_parents, 0x044, 15, 1),
-	MUX_MIXED(CLK_TOP_AUD_I2S4_M_SEL, aud_i2s0_m_parents, 0x044, 16, 1),
-	MUX_MIXED(CLK_TOP_AUD_I2S6_M_SEL, aud_i2s0_m_parents, 0x044, 18, 1),
+	MUX(CLK_TOP_AUD_I2S0_M_SEL, aud_i2s0_m_parents, 0x044, 12, 1),
+	MUX(CLK_TOP_AUD_I2S3_M_SEL, aud_i2s0_m_parents, 0x044, 15, 1),
+	MUX(CLK_TOP_AUD_I2S4_M_SEL, aud_i2s0_m_parents, 0x044, 16, 1),
+	MUX(CLK_TOP_AUD_I2S6_M_SEL, aud_i2s0_m_parents, 0x044, 18, 1),
 	/* CLK_MUX_SEL13 */
-	MUX_MIXED(CLK_TOP_PWM_SEL, pwm_mm_parents, 0x07c, 0, 1),
-	MUX_MIXED(CLK_TOP_AUD_SPDIFIN_SEL, aud_spdifin_parents, 0x07c, 2, 2),
-	MUX_MIXED(CLK_TOP_UART2_SEL, uart0_parents, 0x07c, 4, 1),
-	MUX_MIXED(CLK_TOP_DBG_ATCLK_SEL, dbg_atclk_parents, 0x07c, 7, 3),
-	MUX_MIXED(CLK_TOP_PNG_SYS_SEL, png_sys_parents, 0x07c, 16, 3),
-	MUX_MIXED(CLK_TOP_SEJ_13M_SEL, sej_13m_parents, 0x07c, 22, 1),
+	MUX(CLK_TOP_PWM_SEL, pwm_mm_parents, 0x07c, 0, 1),
+	MUX(CLK_TOP_AUD_SPDIFIN_SEL, aud_spdifin_parents, 0x07c, 2, 2),
+	MUX(CLK_TOP_UART2_SEL, uart0_parents, 0x07c, 4, 1),
+	MUX(CLK_TOP_DBG_ATCLK_SEL, dbg_atclk_parents, 0x07c, 7, 3),
+	MUX(CLK_TOP_PNG_SYS_SEL, png_sys_parents, 0x07c, 16, 3),
+	MUX(CLK_TOP_SEJ_13M_SEL, sej_13m_parents, 0x07c, 22, 1),
 	/* CLK_MUX_SEL14 */
-	MUX_MIXED(CLK_TOP_IMGRZ_SYS_SEL, imgrz_sys_parents, 0xc0, 0, 3),
-	MUX_MIXED(CLK_TOP_GRAPH_ECLK_SEL, graph_eclk_parents, 0xc0, 8, 4),
-	MUX_MIXED(CLK_TOP_FDBI_SEL, fdbi_parents, 0xc0, 12, 4),
-	MUX_MIXED(CLK_TOP_FAUDIO_SEL, faudio_parents, 0xc0, 16, 2),
-	MUX_MIXED(CLK_TOP_FA2SYS_SEL, fa2sys_parents, 0xc0, 24, 3),
-	MUX_MIXED(CLK_TOP_FA1SYS_SEL, fa1sys_parents, 0xc0, 27, 3),
-	MUX_MIXED(CLK_TOP_FASM_M_SEL, fasm_m_parents, 0xc0, 30, 2),
+	MUX(CLK_TOP_IMGRZ_SYS_SEL, imgrz_sys_parents, 0xc0, 0, 3),
+	MUX(CLK_TOP_GRAPH_ECLK_SEL, graph_eclk_parents, 0xc0, 8, 4),
+	MUX(CLK_TOP_FDBI_SEL, fdbi_parents, 0xc0, 12, 4),
+	MUX(CLK_TOP_FAUDIO_SEL, faudio_parents, 0xc0, 16, 2),
+	MUX(CLK_TOP_FA2SYS_SEL, fa2sys_parents, 0xc0, 24, 3),
+	MUX(CLK_TOP_FA1SYS_SEL, fa1sys_parents, 0xc0, 27, 3),
+	MUX(CLK_TOP_FASM_M_SEL, fasm_m_parents, 0xc0, 30, 2),
 	/* CLK_MUX_SEL15 */
-	MUX_MIXED(CLK_TOP_FASM_H_SEL, fasm_m_parents, 0xC4, 0, 2),
-	MUX_MIXED(CLK_TOP_FASM_L_SEL, fasm_m_parents, 0xC4, 2, 2),
-	MUX_MIXED(CLK_TOP_FECC_CK_SEL, fecc_ck_parents, 0xC4, 18, 6),
-	MUX_MIXED(CLK_TOP_PE2_MAC_SEL, pe2_mac_parents, 0xC4, 24, 3),
-	MUX_MIXED(CLK_TOP_CMSYS_SEL, cmsys_parents, 0xC4, 28, 3),
+	MUX(CLK_TOP_FASM_H_SEL, fasm_m_parents, 0xC4, 0, 2),
+	MUX(CLK_TOP_FASM_L_SEL, fasm_m_parents, 0xC4, 2, 2),
+	MUX(CLK_TOP_FECC_CK_SEL, fecc_ck_parents, 0xC4, 18, 6),
+	MUX(CLK_TOP_PE2_MAC_SEL, pe2_mac_parents, 0xC4, 24, 3),
+	MUX(CLK_TOP_CMSYS_SEL, cmsys_parents, 0xC4, 28, 3),
 	/* CLK_MUX_SEL16 */
-	MUX_MIXED(CLK_TOP_GCPU_SEL, gcpu_parents, 0xC8, 0, 3),
-	MUX_MIXED(CLK_TOP_SPIS_CK_SEL, spis_ck_parents, 0xC8, 4, 8),
+	MUX(CLK_TOP_GCPU_SEL, gcpu_parents, 0xC8, 0, 3),
+	MUX(CLK_TOP_SPIS_CK_SEL, spis_ck_parents, 0xC8, 4, 8),
 	/* CLK_MUX_SEL17 */
-	MUX_MIXED(CLK_TOP_APLL1_REF_SEL, apll1_ref_parents, 0xCC, 6, 3),
-	MUX_MIXED(CLK_TOP_APLL2_REF_SEL, apll1_ref_parents, 0xCC, 9, 3),
-	MUX_MIXED(CLK_TOP_INT_32K_SEL, int_32k_parents, 0xCC, 12, 1),
-	MUX_MIXED(CLK_TOP_APLL1_SRC_SEL, apll1_src_parents, 0xCC, 13, 2),
-	MUX_MIXED(CLK_TOP_APLL2_SRC_SEL, apll2_src_parents, 0xCC, 15, 2),
+	MUX(CLK_TOP_APLL1_REF_SEL, apll1_ref_parents, 0xCC, 6, 3),
+	MUX(CLK_TOP_APLL2_REF_SEL, apll1_ref_parents, 0xCC, 9, 3),
+	MUX(CLK_TOP_INT_32K_SEL, int_32k_parents, 0xCC, 12, 1),
+	MUX(CLK_TOP_APLL1_SRC_SEL, apll1_src_parents, 0xCC, 13, 2),
+	MUX(CLK_TOP_APLL2_SRC_SEL, apll2_src_parents, 0xCC, 15, 2),
 	/* CLK_MUX_SEL19 */
-	MUX_MIXED(CLK_TOP_FAUD_INTBUS_SEL, faud_intbus_parents, 0xD4, 8, 8),
-	MUX_MIXED(CLK_TOP_AXIBUS_SEL, axibus_parents, 0xD4, 24, 8),
+	MUX(CLK_TOP_FAUD_INTBUS_SEL, faud_intbus_parents, 0xD4, 8, 8),
+	MUX(CLK_TOP_AXIBUS_SEL, axibus_parents, 0xD4, 24, 8),
 	/* CLK_MUX_SEL21 */
-	MUX_MIXED(CLK_TOP_HAPLL1_SEL, hapll1_parents, 0xDC, 0, 4),
-	MUX_MIXED(CLK_TOP_HAPLL2_SEL, hapll2_parents, 0xDC, 4, 4),
-	MUX_MIXED(CLK_TOP_SPINFI_SEL, spinfi_parents, 0xDC, 8, 4),
+	MUX(CLK_TOP_HAPLL1_SEL, hapll1_parents, 0xDC, 0, 4),
+	MUX(CLK_TOP_HAPLL2_SEL, hapll2_parents, 0xDC, 4, 4),
+	MUX(CLK_TOP_SPINFI_SEL, spinfi_parents, 0xDC, 8, 4),
 	/* CLK_MUX_SEL22 */
-	MUX_MIXED(CLK_TOP_MSDC0_SEL, msdc0_parents, 0xF4, 0, 8),
-	MUX_MIXED(CLK_TOP_MSDC0_CLK50_SEL, msdc0_clk50_parents, 0xF4, 8, 6),
-	MUX_MIXED(CLK_TOP_MSDC2_SEL, msdc2_parents, 0xF4, 15, 8),
-	MUX_MIXED(CLK_TOP_MSDC2_CLK50_SEL, msdc0_clk50_parents, 0xF4, 23, 6),
+	MUX(CLK_TOP_MSDC0_SEL, msdc0_parents, 0xF4, 0, 8),
+	MUX(CLK_TOP_MSDC0_CLK50_SEL, msdc0_clk50_parents, 0xF4, 8, 6),
+	MUX(CLK_TOP_MSDC2_SEL, msdc2_parents, 0xF4, 15, 8),
+	MUX(CLK_TOP_MSDC2_CLK50_SEL, msdc0_clk50_parents, 0xF4, 23, 6),
 	/* CLK_MUX_SEL23 */
-	MUX_MIXED(CLK_TOP_DISP_DPI_CK_SEL, disp_dpi_ck_parents, 0xF8, 0, 6),
-	MUX_MIXED(CLK_TOP_SPI1_SEL, spis_ck_parents, 0xF8, 6, 8),
-	MUX_MIXED(CLK_TOP_SPI2_SEL, spis_ck_parents, 0xF8, 14, 8),
-	MUX_MIXED(CLK_TOP_SPI3_SEL, spis_ck_parents, 0xF8, 22, 8),
+	MUX(CLK_TOP_DISP_DPI_CK_SEL, disp_dpi_ck_parents, 0xF8, 0, 6),
+	MUX(CLK_TOP_SPI1_SEL, spis_ck_parents, 0xF8, 6, 8),
+	MUX(CLK_TOP_SPI2_SEL, spis_ck_parents, 0xF8, 14, 8),
+	MUX(CLK_TOP_SPI3_SEL, spis_ck_parents, 0xF8, 22, 8),
 };
 
 static const struct mtk_gate_regs top0_cg_regs = {
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 30439ae7d93..ddf4ac755bb 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -259,22 +259,15 @@ static int mtk_clk_mux_set_parent(void __iomem *base, u32 parent,
 {
 	u32 val, index = 0;
 
-	if (mux->flags & CLK_PARENT_MIXED) {
-		/*
-		 * Assume parent_type in clk_tree to be always set with
-		 * CLK_PARENT_MIXED implementation. If it's not, assume
-		 * not parent clk ID clash is possible.
-		 */
-		while (mux->parent_flags[index].id != parent ||
-		       (parent_type && (mux->parent_flags[index].flags & CLK_PARENT_MASK) !=
-			parent_type))
-			if (++index == mux->num_parents)
-				return -EINVAL;
-	} else {
-		while (mux->parent[index] != parent)
-			if (++index == mux->num_parents)
-				return -EINVAL;
-	}
+	/*
+	 * Assume parent_type in clk_tree to be always set. If it's not, assume
+	 * parent clk ID clash is not possible.
+	 */
+	while (mux->parent[index].id != parent ||
+	       (parent_type && (mux->parent[index].flags & CLK_PARENT_MASK) !=
+		parent_type))
+		if (++index == mux->num_parents)
+			return -EINVAL;
 
 	if (mux->flags & CLK_MUX_SETCLR_UPD) {
 		val = (mux->mux_mask << mux->mux_shift);
@@ -350,9 +343,6 @@ static void mtk_clk_print_parent(const char *prefix, int parent, u32 flags)
 	case CLK_PARENT_EXT:
 		parent_type_str = "ext";
 		break;
-	case CLK_PARENT_MIXED:
-		parent_type_str = "mixed";
-		break;
 	default:
 		parent_type_str = "default";
 		break;
@@ -381,18 +371,14 @@ static void mtk_clk_print_mux_parents(struct mtk_clk_priv *priv,
 
 	/* Print parents separated by "/" and selected parent enclosed in "*"s */
 	for (i = 0; i < mux->num_parents; i++) {
+		const struct mtk_parent *parent = &mux->parent[i];
+
 		if (i == selected) {
 			printf("%s", prefix);
 			prefix = "*";
 		}
 
-		if (mux->flags & CLK_PARENT_MIXED) {
-			const struct mtk_parent *parent = &mux->parent_flags[i];
-
-			mtk_clk_print_parent(prefix, parent->id, parent->flags);
-		} else {
-			mtk_clk_print_parent(prefix, mux->parent[i], mux->flags);
-		}
+		mtk_clk_print_parent(prefix, parent->id, parent->flags);
 
 		prefix = "/";
 
@@ -719,23 +705,15 @@ static ulong mtk_topckgen_get_mux_rate(struct clk *clk, u32 off)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_composite *mux = &priv->tree->muxes[off];
+	const struct mtk_parent *parent;
 	u32 index;
 
 	index = readl(priv->base + mux->mux_reg);
 	index &= mux->mux_mask << mux->mux_shift;
 	index = index >> mux->mux_shift;
+	parent = &mux->parent[index];
 
-	/*
-	 * Parents can be either from APMIXED or TOPCKGEN,
-	 * inspect the mtk_parent struct to check the source
-	 */
-	if (mux->flags & CLK_PARENT_MIXED) {
-		const struct mtk_parent *parent = &mux->parent_flags[index];
-
-		return mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
-	}
-
-	return mtk_find_parent_rate(priv, clk, mux->parent[index], mux->flags);
+	return mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
 }
 
 static ulong mtk_topckgen_get_rate(struct clk *clk)
@@ -985,23 +963,15 @@ static ulong mtk_infrasys_get_mux_rate(struct clk *clk, u32 off)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct mtk_composite *mux = &priv->tree->muxes[off];
+	const struct mtk_parent *parent;
 	u32 index;
 
 	index = readl(priv->base + mux->mux_reg);
 	index &= mux->mux_mask << mux->mux_shift;
 	index = index >> mux->mux_shift;
+	parent = &mux->parent[index];
 
-	/*
-	 * Parents can be either from TOPCKGEN or INFRACFG,
-	 * inspect the mtk_parent struct to check the source
-	 */
-	if (mux->flags & CLK_PARENT_MIXED) {
-		const struct mtk_parent *parent = &mux->parent_flags[index];
-
-		return mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
-	}
-
-	return mtk_find_parent_rate(priv, clk, mux->parent[index], mux->flags);
+	return mtk_find_parent_rate(priv, clk, parent->id, parent->flags);
 }
 
 static ulong mtk_infrasys_get_rate(struct clk *clk)
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 2d67cf15f47..10a0723de47 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -29,12 +29,7 @@
 #define CLK_PARENT_INFRASYS		BIT(6)
 #define CLK_PARENT_XTAL			BIT(7)
 #define CLK_PARENT_EXT			BIT(8)
-/*
- * For CLK_PARENT_MIXED to correctly work, is required to
- * define in clk_tree flags the clk type using the alias.
- */
-#define CLK_PARENT_MIXED		BIT(9)
-#define CLK_PARENT_MASK			GENMASK(9, 4)
+#define CLK_PARENT_MASK			GENMASK(8, 4)
 
 #define ETHSYS_HIFSYS_RST_CTRL_OFS	0x34
 
@@ -133,8 +128,7 @@ struct mtk_parent {
  * struct mtk_composite - aggregate clock of mux, divider and gate clocks
  *
  * @id:			unmapped ID of clocks
- * @parent:		unmapped ID of parent clocks
- * @parent_flags:	table of parent clocks with flags
+ * @parent:		array of parent clocks
  * @mux_reg:		hardware-specific mux register
  * @gate_reg:		hardware-specific gate register
  * @mux_mask:		mask to the mux bit field
@@ -145,10 +139,7 @@ struct mtk_parent {
  */
 struct mtk_composite {
 	const int id;
-	union {
-		const int *parent;
-		const struct mtk_parent *parent_flags;
-	};
+	const struct mtk_parent *parent;
 	u32 mux_reg;
 	u32 mux_set_reg;
 	u32 mux_clr_reg;
@@ -178,35 +169,6 @@ struct mtk_composite {
 #define MUX_GATE(_id, _parents, _reg, _shift, _width, _gate)		\
 	MUX_GATE_FLAGS(_id, _parents, _reg, _shift, _width, _gate, 0)
 
-#define MUX_GATE_MIXED_FLAGS(_id, _parents, _reg, _shift, _width, _gate,\
-			     _flags) {					\
-		.id = _id,						\
-		.mux_reg = _reg,					\
-		.mux_shift = _shift,					\
-		.mux_mask = BIT(_width) - 1,				\
-		.gate_reg = _reg,					\
-		.gate_shift = _gate,					\
-		.parent_flags = _parents,				\
-		.num_parents = ARRAY_SIZE(_parents),			\
-		.flags = (_flags) | CLK_PARENT_MIXED,			\
-	}
-
-#define MUX_GATE_MIXED(_id, _parents, _reg, _shift, _width, _gate)	\
-	MUX_GATE_MIXED_FLAGS(_id, _parents, _reg, _shift, _width, _gate, 0)
-
-#define MUX_MIXED_FLAGS(_id, _parents, _reg, _shift, _width, _flags) {	\
-		.id = _id,						\
-		.mux_reg = _reg,					\
-		.mux_shift = _shift,					\
-		.mux_mask = BIT(_width) - 1,				\
-		.gate_shift = -1,					\
-		.parent_flags = _parents,				\
-		.num_parents = ARRAY_SIZE(_parents),			\
-		.flags = CLK_PARENT_MIXED | (_flags),			\
-	}
-#define MUX_MIXED(_id, _parents, _reg, _shift, _width)			\
-	MUX_MIXED_FLAGS(_id, _parents, _reg, _shift, _width, 0)
-
 #define MUX_FLAGS(_id, _parents, _reg, _shift, _width, _flags) {	\
 		.id = _id,						\
 		.mux_reg = _reg,					\
@@ -238,24 +200,6 @@ struct mtk_composite {
 		.flags = _flags,					\
 	}
 
-#define MUX_MIXED_CLR_SET_UPD_FLAGS(_id, _parents, _mux_ofs, _mux_set_ofs,\
-				    _mux_clr_ofs, _shift, _width, _gate,\
-				    _upd_ofs, _upd, _flags) {		\
-		.id = _id,						\
-		.mux_reg = _mux_ofs,					\
-		.mux_set_reg = _mux_set_ofs,				\
-		.mux_clr_reg = _mux_clr_ofs,				\
-		.upd_reg = _upd_ofs,					\
-		.upd_shift = _upd,					\
-		.mux_shift = _shift,					\
-		.mux_mask = BIT(_width) - 1,				\
-		.gate_reg = _mux_ofs,					\
-		.gate_shift = _gate,					\
-		.parent_flags = _parents,				\
-		.num_parents = ARRAY_SIZE(_parents),			\
-		.flags = CLK_PARENT_MIXED | (_flags),			\
-	}
-
 struct mtk_gate_regs {
 	u32 sta_ofs;
 	u32 clr_ofs;

-- 
2.43.0

