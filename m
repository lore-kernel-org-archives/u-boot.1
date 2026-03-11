Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB2CFD88D5
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 00:18:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B06983FAF;
	Wed, 11 Mar 2026 01:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mms9tK6y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A82FD83FAF; Wed, 11 Mar 2026 01:17:47 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0009583FAF
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 01:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d74c1157a4so2492983a34.1
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 17:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773188263; x=1773793063;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/NZ5CBWdwIDMXWtr/ezcROYVUwiWSBLzR8mJKgl17n4=;
 b=mms9tK6yUL7qh6R/iS+ggN4pU0kn5OmQEge2IG224FqVtupVie40HqcnRzguOxgmkY
 UccSNPbqh99gcaicGGRTZIogENy66ver8vVtzHeJapEfBrVdt8Z0sdX/mR+OVPmvnQ/V
 vKJQC9Fi9oCQqrnPI/qVfLYlFZDRyZn4gLPzFj6wE3eyTQ3aI4sbQpKf76cKBuFhLO+p
 3539xOvMvcwQ3lYjD6YAYOvlvwopBMXXz4nQ4fRHBTuob+X8xSf97qZX5oadB0q1dPKC
 aBEEoPiWauzIaKOpzpfP4ySColsL7HYl0ZgVpK03tTgfi7FkrEQkio+PSCIFjkg/fmQB
 /8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773188263; x=1773793063;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/NZ5CBWdwIDMXWtr/ezcROYVUwiWSBLzR8mJKgl17n4=;
 b=q6CnjJWQGxNBJfX7M4sf93nbbUnW+wcohgU5Z7VotpujPxPL7lB5V3fHQZKX4aa046
 TFEw94vXow1i2j39aqhowNjaELLA12prRlwHDyeDbdZWswuOGhqk8TTW6vN/1/aSzmii
 PI77rzcTSqIbth4hqG/E418e0BY44QkeghheHO+oBmTgpCPM2Xgb1bRBnY1xyEwcmOKy
 ZG8/acmznSaf6NHVqJuJ2uXV5e64hjnaw3Mip7uBKeBTY/wIYOaql2XXChAt32qYMFYI
 DxvD2xxzp2+F4NXjKG8vzewwqQxmgCfu2p8fFu2J4hhe57SkNiWqMn2JF3c6t/EXwwb1
 viiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSJxcEhjLYLi1Hr+5H1I9ZcgjP+u2Q0YLB1Lbw4vHqCbl1dWz3cWnP5ItT9wVUqQjdKCRPAVE=@lists.denx.de
X-Gm-Message-State: AOJu0YyhBYPO7lkwj+BP3V7r54F1TuxLRzRVlQbR84rD0BR2hWa0jkHm
 rcI8RUxtpsiNuwsdzfhIQ4rmnOwJm4Co4HJRzdMr23ShsnoTAa0AuZAGpoU0QnlBPd0=
X-Gm-Gg: ATEYQzyrKiNvYIwCL7tzXNyzI5MzkmOCgwuclM4HRDkuXPx7e4maRlYpa5dbgKErYj+
 nXZfyPBWEWUEcS6JZ2SzwCjI3AOqnt7svjaX5BgDWz5FfK7JKxljrk/w3IENBfq2M2vYvmWruYM
 TtF/h2yfsJbwPXhVOEVb/WGlC8KW8DQ2zIDyMEzXKPk518PSDJMG+Y7qf2adXd+n3HLggN16h9R
 PpQF0+cFRo1e7iv5JnxxzzpIjt4lZ8zJ/vMka1v/hIkau26LOU4US7TEH7gWJ5gjO0g7CjYCadN
 RPKufL6ZsPTuuYOLXkdAmIEAiRL+g5qthRfzNagIbMMRZrs6Jc2MVqbdpSGE2wvEimEdTH9Yej5
 b4OQOD9aLEPNN1nPo1C9o4l+Mi+L9E6FgYvrmWM8kuAghctfI2vJQOr3SuqgQEte0chh+xSz5yD
 wlEUPWDsIAyd4QHrzLdp+SNJ9Sc9Mu
X-Received: by 2002:a05:6830:6c17:b0:7d7:45eb:4e22 with SMTP id
 46e09a7af769-7d76a7a4e3fmr583611a34.26.1773188263580; 
 Tue, 10 Mar 2026 17:17:43 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:82ac:f3fe:2e5f:ec03])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae6a361sm466304a34.20.2026.03.10.17.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 17:17:43 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 10 Mar 2026 19:16:50 -0500
Subject: [PATCH v2 1/6] clk: mediatek: mt8189: add some VLP clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-mtk-mt8391-initial-support-v2-1-1dc862d58532@baylibre.com>
References: <20260310-mtk-mt8391-initial-support-v2-0-1dc862d58532@baylibre.com>
In-Reply-To: <20260310-mtk-mt8391-initial-support-v2-0-1dc862d58532@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lukasz Majewski <lukma@denx.de>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13482;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=5pYWG4v2hRG0wM/VR8S3LNAAOAxdAX9qdJ0fS52YlNg=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsLR+7RSsiaY7uuoxAlZ0nK9W7odztf27tmVlS
 6SwS+fz0u+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabC0fhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AJCkH/jX56KDe6R9y/l3tHUqttTq8qxYZYWmv91udkk+
 RDXRO1zqDrdo78VXSZhVuGosuN7ChfjIDtPfPo80Sc5yTrsibiPsWsZImgye84yNpLdzfpTL16o
 9Qq/rGz5PF/lL/DAGfjDIfSgwC+B3kMXB+Oahm/dt+lrM7huj6vLoOdpgAesg2OU/4+K1ALE/UD
 cHqCTFeMIR16awpe30jKt2Kcv2+gbdIhaxsr1vPXtbLrlJLhhBFLZfk5cddH4c5dIxJasuz1ruA
 DhjPh8TH2Biyzvan8LA5U3rsSshV8+97LCm4HQH8XNYUWU6Nl4ZSVkYnI5r50PeXUHMUgrwk699
 ofaQ=
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

Add some VLP clocks needed by the PMIC on MT8189 and similar SoCs.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8189.c | 289 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 289 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index 4779735a1cf..39a74180d11 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -286,11 +286,15 @@
 #define CLK_PAD_CLK32K			0
 #define CLK_PAD_CLK26M			1
 #define CLK_PAD_ULPOSC			2
+#define CLK_PAD_CLK13M			3
+#define CLK_PAD_AUD_ADC_EXT		4
 
 static ulong pad_clks[] = {
 	[CLK_PAD_CLK32K] = 32000,
 	[CLK_PAD_CLK26M] = 26 * MHZ,
 	[CLK_PAD_ULPOSC] = 260 * MHZ,
+	[CLK_PAD_CLK13M] = 13 * MHZ,
+	[CLK_PAD_AUD_ADC_EXT] = 260 * MHZ,
 };
 
 #define MT8189_PLL_FMAX		(3800UL * MHZ)
@@ -1635,6 +1639,258 @@ static const struct mtk_gate mminfra_config_clks[] = {
 	GATE_MMINFRA_CONFIG1(CLK_MMINFRA_GCE_26M, CLK_TOP_MMINFRA_SEL, 17),
 };
 
+static const struct mtk_parent vlp_26m_oscd10_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_OSC_D10),
+};
+
+static const struct mtk_parent vlp_vadsp_vowpll_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_VOWPLL),
+};
+
+static const struct mtk_parent vlp_sspm_ulposc_parents[] = {
+	EXT_PARENT(CLK_PAD_ULPOSC),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D5_D2),
+	TOP_PARENT(CLK_TOP_OSC_D10),
+};
+
+static const struct mtk_parent vlp_aud_adc_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_VOWPLL),
+	EXT_PARENT(CLK_PAD_AUD_ADC_EXT),
+	TOP_PARENT(CLK_TOP_OSC_D10),
+};
+
+static const struct mtk_parent vlp_scp_iic_spi_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
+	TOP_PARENT(CLK_TOP_OSC_D10),
+};
+
+static const struct mtk_parent vlp_vadsp_uarthub_b_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_OSC_D10),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D2),
+};
+
+static const struct mtk_parent vlp_axi_kp_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_OSC_D10),
+	TOP_PARENT(CLK_TOP_OSC_D2),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D2),
+};
+
+static const struct mtk_parent vlp_sspm_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_OSC_D10),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D2),
+	EXT_PARENT(CLK_PAD_ULPOSC),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+};
+
+static const struct mtk_parent vlp_pwm_vlp_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_OSC_D4),
+	EXT_PARENT(CLK_PAD_CLK32K),
+	TOP_PARENT(CLK_TOP_OSC_D10),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D8),
+};
+
+static const struct mtk_parent vlp_pwrap_ulposc_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_OSC_D10),
+	TOP_PARENT(CLK_TOP_OSC_D7),
+	TOP_PARENT(CLK_TOP_OSC_D8),
+	TOP_PARENT(CLK_TOP_OSC_D16),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D8),
+};
+
+static const struct mtk_parent vlp_vadsp_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_OSC_D20),
+	TOP_PARENT(CLK_TOP_OSC_D10),
+	TOP_PARENT(CLK_TOP_OSC_D2),
+	EXT_PARENT(CLK_PAD_ULPOSC),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4_D2),
+};
+
+static const struct mtk_parent vlp_scp_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D4),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D3),
+	TOP_PARENT(CLK_TOP_MAINPLL_D3),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6),
+	APMIXED_PARENT(CLK_APMIXED_APLL1),
+	TOP_PARENT(CLK_TOP_MAINPLL_D4),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7),
+	TOP_PARENT(CLK_TOP_OSC_D10),
+};
+
+static const struct mtk_parent vlp_spmi_p_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_F26M_CK_D2),
+	TOP_PARENT(CLK_TOP_OSC_D8),
+	TOP_PARENT(CLK_TOP_OSC_D10),
+	TOP_PARENT(CLK_TOP_OSC_D16),
+	TOP_PARENT(CLK_TOP_OSC_D7),
+	EXT_PARENT(CLK_PAD_CLK32K),
+	TOP_PARENT(CLK_TOP_MAINPLL_D7_D8),
+	TOP_PARENT(CLK_TOP_MAINPLL_D6_D8),
+	TOP_PARENT(CLK_TOP_MAINPLL_D5_D8),
+};
+
+static const struct mtk_parent vlp_camtg_parents[] = {
+	EXT_PARENT(CLK_PAD_CLK26M),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D8),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D4),
+	TOP_PARENT(CLK_TOP_OSC_D16),
+	TOP_PARENT(CLK_TOP_OSC_D20),
+	TOP_PARENT(CLK_TOP_OSC_D10),
+	TOP_PARENT(CLK_TOP_UNIVPLL_D6_D16),
+	TOP_PARENT(CLK_TOP_TVDPLL1_D16),
+	TOP_PARENT(CLK_TOP_F26M_CK_D2),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D10),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D16),
+	TOP_PARENT(CLK_TOP_UNIVPLL_192M_D32),
+};
+
+static const struct mtk_composite vlp_ck_muxes[] = {
+	/* VLP_CLK_CFG_0 */
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_SCP_SEL, vlp_scp_parents,
+			     0x008, 0x00c, 0x010, 0, 4, 7, 0x04, 0),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_PWRAP_ULPOSC_SEL, vlp_pwrap_ulposc_parents,
+			0x008, 0x00c, 0x010, 8, 3, 0x04, 1),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SPMI_P_MST_SEL, vlp_spmi_p_parents,
+			0x008, 0x00c, 0x010, 16, 4, 0x04, 2),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_DVFSRC_SEL, vlp_26m_oscd10_parents,
+			0x008, 0x00c, 0x010, 24, 1, 0x04, 3),
+	/* VLP_CLK_CFG_1 */
+	MUX_CLR_SET_UPD(CLK_VLP_CK_PWM_VLP_SEL, vlp_pwm_vlp_parents,
+			0x014, 0x018, 0x01c, 0, 3, 0x04, 4),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_AXI_VLP_SEL, vlp_axi_kp_parents,
+			0x014, 0x018, 0x01c, 8, 3, 0x04, 5),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SYSTIMER_26M_SEL, vlp_26m_oscd10_parents,
+			0x014, 0x018, 0x01c, 16, 1, 0x04, 6),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SSPM_SEL, vlp_sspm_parents,
+			0x014, 0x018, 0x01c, 24, 3, 0x04, 7),
+	/* VLP_CLK_CFG_2 */
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SSPM_F26M_SEL, vlp_26m_oscd10_parents,
+			0x020, 0x024, 0x028, 0, 1, 0x04, 8),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SRCK_SEL, vlp_26m_oscd10_parents,
+			0x020, 0x024, 0x028, 8, 1, 0x04, 9),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SCP_SPI_SEL, vlp_scp_iic_spi_parents,
+			0x020, 0x024, 0x028, 16, 2, 0x04, 10),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SCP_IIC_SEL, vlp_scp_iic_spi_parents,
+			0x020, 0x024, 0x028, 24, 2, 0x04, 11),
+	/* VLP_CLK_CFG_3 */
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SCP_SPI_HIGH_SPD_SEL,
+			vlp_scp_iic_spi_parents,
+			0x02c, 0x030, 0x034, 0, 2, 0x04, 12),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SCP_IIC_HIGH_SPD_SEL,
+			vlp_scp_iic_spi_parents,
+			0x02c, 0x030, 0x034, 8, 2, 0x04, 13),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_SSPM_ULPOSC_SEL, vlp_sspm_ulposc_parents,
+			0x02c, 0x030, 0x034, 16, 2, 0x04, 14),
+	MUX_CLR_SET_UPD(CLK_VLP_CK_APXGPT_26M_SEL, vlp_26m_oscd10_parents,
+			0x02c, 0x030, 0x034, 24, 1, 0x04, 15),
+	/* VLP_CLK_CFG_4 */
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_VADSP_SEL, vlp_vadsp_parents,
+			     0x038, 0x03c, 0x040, 0, 3, 7, 0x04, 16),
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_VADSP_VOWPLL_SEL,
+			     vlp_vadsp_vowpll_parents,
+			     0x038, 0x03c, 0x040, 8, 1, 15, 0x04, 17),
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_VADSP_UARTHUB_BCLK_SEL,
+			     vlp_vadsp_uarthub_b_parents,
+			     0x038, 0x03c, 0x040, 16, 2, 23, 0x04, 18),
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_CAMTG0_SEL, vlp_camtg_parents,
+			     0x038, 0x03c, 0x040, 24, 4, 31, 0x04, 19),
+	/* VLP_CLK_CFG_5 */
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_CAMTG1_SEL, vlp_camtg_parents,
+			     0x044, 0x048, 0x04c, 0, 4, 7, 0x04, 20),
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_CAMTG2_SEL, vlp_camtg_parents,
+			     0x044, 0x048, 0x04c, 8, 4, 15, 0x04, 21),
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_AUD_ADC_SEL, vlp_aud_adc_parents,
+			     0x044, 0x048, 0x04c, 16, 2, 23, 0x04, 22),
+	MUX_GATE_CLR_SET_UPD(CLK_VLP_CK_KP_IRQ_GEN_SEL, vlp_axi_kp_parents,
+			     0x044, 0x048, 0x04c, 24, 3, 31, 0x04, 23),
+};
+
+static const struct mtk_gate_regs vlp_ck_gate_regs = {
+	.set_ofs = 0x1f4,
+	.clr_ofs = 0x1f8,
+	.sta_ofs = 0x1f0,
+};
+
+#define GATE_VLP_CK(id, parent, shift, flags) \
+	GATE_FLAGS(id, parent, &vlp_ck_gate_regs, shift, flags | CLK_GATE_NO_SETCLR_INV)
+
+#define GATE_VLP_CK_EXT(id, parent, shift) \
+	GATE_VLP_CK(id, parent, shift, CLK_PARENT_EXT)
+
+#define GATE_VLP_CK_TOP(id, parent, shift) \
+	GATE_VLP_CK(id, parent, shift, CLK_PARENT_TOPCKGEN)
+
+static const struct mtk_gate vlp_ck_gates[] = {
+	GATE_VLP_CK_EXT(CLK_VLP_CK_VADSYS_VLP_26M_EN, CLK_PAD_CLK26M, 1),
+	GATE_VLP_CK_EXT(CLK_VLP_CK_SEJ_13M_EN, CLK_PAD_CLK13M, 4),
+	GATE_VLP_CK_EXT(CLK_VLP_CK_SEJ_26M_EN, CLK_PAD_CLK26M, 5),
+	GATE_VLP_CK_TOP(CLK_VLP_CK_FMIPI_CSI_UP26M_CK_EN, CLK_TOP_OSC_D10, 11),
+};
+
+static const struct mtk_gate_regs vlpcfg_ao_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x4,
+	.sta_ofs = 0x4,
+};
+
+/*
+ * REVISIT: this is currently the only clock tree using the infrasys ops so we
+ * are using it instead of introducing a new parent in the core code. Instead,
+ * we should eventually rework the core code to do a better job of supporting
+ * arbitrary parent trees.
+ */
+#define CLK_PARENT_VLP_CK CLK_PARENT_INFRASYS
+
+#define GATE_VLPCFG_AO(id, parent, shift, flags) \
+	GATE_FLAGS(id, parent, &vlpcfg_ao_regs, shift, flags | CLK_GATE_NO_SETCLR_INV)
+
+#define GATE_VLPCFG_AO_EXT(id, parent, shift) \
+	GATE_VLPCFG_AO(id, parent, shift, CLK_PARENT_EXT)
+
+#define GATE_VLPCFG_AO_TOP(id, parent, shift) \
+	GATE_VLPCFG_AO(id, parent, shift, CLK_PARENT_TOPCKGEN)
+
+#define GATE_VLPCFG_AO_VLP(id, parent, shift) \
+	GATE_VLPCFG_AO(id, parent, shift, CLK_PARENT_VLP_CK)
+
+static const struct mtk_gate vlpcfg_ao_clks[] = {
+	GATE_VLPCFG_AO_VLP(CLK_VLPCFG_REG_SCP, CLK_VLP_CK_SCP_SEL, 28),
+	GATE_VLPCFG_AO_EXT(CLK_VLPCFG_REG_RG_R_APXGPT_26M, CLK_PAD_CLK26M, 24),
+	GATE_VLPCFG_AO_EXT(CLK_VLPCFG_REG_DPMSRCK_TEST, CLK_PAD_CLK26M, 23),
+	GATE_VLPCFG_AO_VLP(CLK_VLPCFG_REG_RG_DPMSRRTC_TEST, CLK_PAD_CLK32K, 22),
+	GATE_VLPCFG_AO_VLP(CLK_VLPCFG_REG_DPMSRULP_TEST, CLK_TOP_OSC_D10, 21),
+	GATE_VLPCFG_AO_VLP(CLK_VLPCFG_REG_SPMI_P_MST, CLK_VLP_CK_SPMI_P_MST_SEL, 20),
+	GATE_VLPCFG_AO_EXT(CLK_VLPCFG_REG_SPMI_P_MST_32K, CLK_PAD_CLK32K, 18),
+	GATE_VLPCFG_AO_VLP(CLK_VLPCFG_REG_PMIF_SPMI_P_SYS, CLK_VLP_CK_PWRAP_ULPOSC_SEL, 13),
+	GATE_VLPCFG_AO_VLP(CLK_VLPCFG_REG_PMIF_SPMI_P_TMR, CLK_VLP_CK_PWRAP_ULPOSC_SEL, 12),
+	GATE_VLPCFG_AO_VLP(CLK_VLPCFG_REG_PMIF_SPMI_M_SYS, CLK_VLP_CK_PWRAP_ULPOSC_SEL, 11),
+	GATE_VLPCFG_AO_VLP(CLK_VLPCFG_REG_PMIF_SPMI_M_TMR, CLK_VLP_CK_PWRAP_ULPOSC_SEL, 10),
+	GATE_VLPCFG_AO_VLP(CLK_VLPCFG_REG_DVFSRC, CLK_VLP_CK_DVFSRC_SEL, 9),
+	GATE_VLPCFG_AO_VLP(CLK_VLPCFG_REG_PWM_VLP, CLK_VLP_CK_PWM_VLP_SEL, 8),
+	GATE_VLPCFG_AO_VLP(CLK_VLPCFG_REG_SRCK, CLK_VLP_CK_SRCK_SEL, 7),
+	GATE_VLPCFG_AO_VLP(CLK_VLPCFG_REG_SSPM_F26M, CLK_VLP_CK_SSPM_F26M_SEL, 4),
+	GATE_VLPCFG_AO_EXT(CLK_VLPCFG_REG_SSPM_F32K, CLK_PAD_CLK32K, 3),
+	GATE_VLPCFG_AO_VLP(CLK_VLPCFG_REG_SSPM_ULPOSC, CLK_VLP_CK_SSPM_ULPOSC_SEL, 2),
+	GATE_VLPCFG_AO_EXT(CLK_VLPCFG_REG_VLP_32K_COM, CLK_PAD_CLK32K, 1),
+	GATE_VLPCFG_AO_EXT(CLK_VLPCFG_REG_VLP_26M_COM, CLK_PAD_CLK26M, 0),
+};
+
 static const struct mtk_clk_tree mt8189_apmixedsys_clk_tree = {
 	.pll_parent = EXT_PARENT(CLK_PAD_CLK26M),
 	.ext_clk_rates = pad_clks,
@@ -1657,6 +1913,17 @@ static const struct mtk_clk_tree mt8189_topckgen_clk_tree = {
 	.num_gates = ARRAY_SIZE(top_gates),
 };
 
+static const struct mtk_clk_tree mt8189_vlpckgen_clk_tree = {
+	.ext_clk_rates = pad_clks,
+	.num_ext_clks = ARRAY_SIZE(pad_clks),
+	.muxes_offs = CLK_VLP_CK_SCP_SEL,
+	.gates_offs = CLK_VLP_CK_VADSYS_VLP_26M_EN,
+	.muxes = vlp_ck_muxes,
+	.gates = vlp_ck_gates,
+	.num_muxes = ARRAY_SIZE(vlp_ck_muxes),
+	.num_gates = ARRAY_SIZE(vlp_ck_gates),
+};
+
 static const struct udevice_id mt8189_apmixed[] = {
 	{ .compatible = "mediatek,mt8189-apmixedsys", },
 	{ }
@@ -1667,6 +1934,11 @@ static const struct udevice_id mt8189_topckgen_compat[] = {
 	{ }
 };
 
+static const struct udevice_id mt8189_vlpckgen[] = {
+	{ .compatible = "mediatek,mt8189-vlpckgen", },
+	{ }
+};
+
 struct mt8189_gate_clk_data {
 	const struct mtk_gate *gates;
 	int num_gates;
@@ -1681,12 +1953,14 @@ GATE_CLK_DATA(perao_clks);
 GATE_CLK_DATA(imp_clks);
 GATE_CLK_DATA(mm_clks);
 GATE_CLK_DATA(mminfra_config_clks);
+GATE_CLK_DATA(vlpcfg_ao_clks);
 
 static const struct udevice_id of_match_mt8189_clk_gate[] = {
 	{ .compatible = "mediatek,mt8189-peri-ao", .data = (ulong)&perao_clks_data },
 	{ .compatible = "mediatek,mt8189-iic-wrap", .data = (ulong)&imp_clks_data },
 	{ .compatible = "mediatek,mt8189-dispsys", .data = (ulong)&mm_clks_data },
 	{ .compatible = "mediatek,mt8189-mm-infra", .data = (ulong)&mminfra_config_clks_data },
+	{ .compatible = "mediatek,mt8189-vlpcfg-ao", .data = (ulong)&vlpcfg_ao_clks_data },
 	{ }
 };
 
@@ -1700,6 +1974,11 @@ static int mt8189_topckgen_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt8189_topckgen_clk_tree);
 }
 
+static int mt8189_infrasys_probe(struct udevice *dev)
+{
+	return mtk_common_clk_infrasys_init(dev, &mt8189_vlpckgen_clk_tree);
+}
+
 static int mt8189_clk_gate_probe(struct udevice *dev)
 {
 	struct mt8189_gate_clk_data *data;
@@ -1731,6 +2010,16 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
+U_BOOT_DRIVER(mtk_clk_vlpckgen) = {
+	.name = "mt8189-vlpckgen",
+	.id = UCLASS_CLK,
+	.of_match = mt8189_vlpckgen,
+	.probe = mt8189_infrasys_probe,
+	.priv_auto = sizeof(struct mtk_clk_priv),
+	.ops = &mtk_clk_infrasys_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
+
 U_BOOT_DRIVER(mtk_clk_gate) = {
 	.name = "mt8189-gate-clk",
 	.id = UCLASS_CLK,

-- 
2.43.0

