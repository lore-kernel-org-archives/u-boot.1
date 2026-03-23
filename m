Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C710F483F5
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 20:18:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5E4483FED;
	Mon, 23 Mar 2026 21:18:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="suKdm7Gi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46DBA83BE1; Mon, 23 Mar 2026 21:18:07 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A509C83FA7
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 21:18:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-46708149af2so350072b6e.0
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 13:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774297083; x=1774901883;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hhtwf0AJWAoHi2YQd//GPWUG7WSk1J5mIkIbJY7k/z0=;
 b=suKdm7GibTUIMZ6/du2i1G00ev5rzzB+wkQ3Cxd97dgCati09QgKEdHkwXqzLbME+a
 uRo2+/v4foZH0q6DrTWVMLjVXYn2cR+KJaP35fd4h063PROlN5sc27fBFxjVY0BWldYl
 /+RLOK+Tnx7bD+FPjxdTLIiDGDnmTU9AEQq7aqigK2i41X+Ch1HxTkjaFoyyYyOK79t2
 ZB1lZ7uGm6ZTTBXVGYLcXywmxo09B5iU68KubJc/FuBscj14a7MZXAYCnZfpEIy3cagC
 ad3axlZlT8WgpK6f1/Hr0mV60IewqITqR4zu4OEqVWnxANikUHCu5ZHhZffceedbx/R8
 1pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774297083; x=1774901883;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hhtwf0AJWAoHi2YQd//GPWUG7WSk1J5mIkIbJY7k/z0=;
 b=tJqkAdCwXnnaiBof+en7TurpFC/jZ2EBxE+YmlVFrhB8YVVrHzHhnFxhvUQr2ozBzj
 yfmwk0LiJNVBdfUSGYNZecQN3roSav8v7V4PVx+gb0+RTUOyZg8zeMo24eGMqZl4uVs6
 GcwsTBLPj6tLF0ZkfXzDXUbjO9jrqkopILYt2PPO83Vu8YnKgHEsvoXsRtYyodr6PqnD
 VWxfs9RreLq0ZPcsclr0o7jAXg7qS8/5FFMZfLj8mjGbjb0CLRXPBRpI1yIiQN5AZo1D
 ZN6c6qYQ9Bb6TENu+VhDF7rcAR0mbVgtazjPR7245aDlAZG4Z2d7MQjtabB+kiNlwmhJ
 3qCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs+pFfVk3aXrPX8BFxPy48B7ZIMfs0jKP4UOZqFF7Tt8BSbKf/y975RajsvS8C6Ni3e1PB5Rc=@lists.denx.de
X-Gm-Message-State: AOJu0YxO7Xa7lLgkX39CpKGMYoEdfQApxaLUxtiPUOlmEzgWn+smJmAg
 MgRTRq7giAg2OGkyjyaTtULoJJaH4tElXh1AlwgS+b4ZLqt/7HuKQX2+Rfne9bfY3co=
X-Gm-Gg: ATEYQzyeUgVLD+IH0Yvw9TgsHcTYupb3N7PSil+6GgZKOfB2Bn67AWzr+5Z73Hc6kI7
 ZUffp9V3inntNCfZ46+fxzLdjCPRipDQvFIvevBv69dBFWV9c9/+iJhvOfdzQmS0/PeWmRrCjcA
 GScr4pGhj4dT9YTPxTKdMsxIw5b3PAKnUvVueyifZAyM01fCP5tE3N/iNwgZGgBYO3XV11quxdL
 /Qm+UOzWvq/RRKHF7RqAbPgwxEvPd7w8h8F2dy3nOoDYeSOid2b+KJEnfnWpejRBwsidJafjOOF
 WR5BD/J4tF2Sgu3socVMYD5Vg0o3ZWpOo74NAokEhiA2Q3mDlTmTUvD1NjrPJjxqakFzuGWUiD/
 jCGzZ/elEh3U/IfwiKoioxBL3/Roft86OHQ0ErA4oz1W4/EaZ/A0jew0gd+qH5yUPExNW18QHhu
 w8VXa2Ltt874rPI2uh3zX9r2g6uvw=
X-Received: by 2002:a05:6808:bd1:b0:467:880:7441 with SMTP id
 5614622812f47-467e5d83ff6mr7380468b6e.18.1774297083177; 
 Mon, 23 Mar 2026 13:18:03 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:964:f712:dbc7:4119])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c148a5ca4sm11077540fac.3.2026.03.23.13.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:18:02 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 23 Mar 2026 15:16:52 -0500
Subject: [PATCH v3 1/6] clk: mediatek: mt8189: add some VLP clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-mtk-mt8391-initial-support-v3-1-19dd92f4543f@baylibre.com>
References: <20260323-mtk-mt8391-initial-support-v3-0-19dd92f4543f@baylibre.com>
In-Reply-To: <20260323-mtk-mt8391-initial-support-v3-0-19dd92f4543f@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lukasz Majewski <lukma@denx.de>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13473;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=MgzsXJ7NkyacqTASVMiDbxKgnMWvoWfOg8NWM8Bv5jM=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpwZ/QB5qg1nHf2hquluRgnzgFAeM++CsMTMzR+
 kexONwMvB+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacGf0BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AMx4IAJzlrzzZtb4OukqFBCN+n9AkDi/e9EeptRoyCdL
 xkOvODcLGlIgo3qADzLNR/hbjQGYmooS0zK3fkRBlLRNAtwKW2me2SsE0Y5zvDXrA3SOVc7gyY+
 MLMEiTFOY+Htm6ebb1g4YUeMuk5K1UADR1BmlnJE6X3ZhcrCOAWNcQna4sQRN8C9GVLjzMovHgC
 t/4M1WMlcJLUH/4YBlM0fyke80DnradpMYZtYcOVOanVEAtHbXj+UV71zcH6UM8UYzqOKej7Xs+
 Fm+YRUXNyejZPLh/RlnyyzQtdpnyEy/iz1XA3jFGRH+LRGB3TtLonSc1jpZtkgzekwDllZNGIIK
 eTOQ=
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
index fec908728c0..9e640059f11 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -287,12 +287,16 @@ enum {
 	CLK_PAD_CLK32K,
 	CLK_PAD_CLK26M,
 	CLK_PAD_ULPOSC,
+	CLK_PAD_CLK13M,
+	CLK_PAD_AUD_ADC_EXT,
 };
 
 static ulong ext_clock_rates[] = {
 	[CLK_PAD_CLK32K] = 32000,
 	[CLK_PAD_CLK26M] = 26 * MHZ,
 	[CLK_PAD_ULPOSC] = 260 * MHZ,
+	[CLK_PAD_CLK13M] = 13 * MHZ,
+	[CLK_PAD_AUD_ADC_EXT] = 260 * MHZ,
 };
 
 #define MT8189_PLL_FMAX		(3800UL * MHZ)
@@ -1637,6 +1641,258 @@ static const struct mtk_gate mminfra_config_clks[] = {
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
 	.ext_clk_rates = ext_clock_rates,
@@ -1659,6 +1915,17 @@ static const struct mtk_clk_tree mt8189_topckgen_clk_tree = {
 	.num_gates = ARRAY_SIZE(top_gates),
 };
 
+static const struct mtk_clk_tree mt8189_vlpckgen_clk_tree = {
+	.ext_clk_rates = ext_clock_rates,
+	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
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
@@ -1669,6 +1936,11 @@ static const struct udevice_id mt8189_topckgen_compat[] = {
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
@@ -1683,12 +1955,14 @@ GATE_CLK_DATA(perao_clks);
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
 
@@ -1702,6 +1976,11 @@ static int mt8189_topckgen_probe(struct udevice *dev)
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
@@ -1733,6 +2012,16 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
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

