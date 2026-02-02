Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA5EE73158
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 12:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD51083E76;
	Mon,  2 Feb 2026 13:42:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ESTjXw15";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1DFE83E1E; Mon,  2 Feb 2026 13:42:02 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E8AD83E76
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 13:42:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43596062728so3346203f8f.1
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 04:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770036119; x=1770640919;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3DmM3Ub08vve46EZTmx9zgN4irgtawQR9zpNQSGIMog=;
 b=ESTjXw15sud0RVGBp7Bz+k0krW5d1zibaovvb8FL8etTiI65JBAuMe1LK9FymSbGR4
 1uUo5eZdjYMu0v6+WszYVel5rBh/ms8AQuViibwGIIu/230gaBh0x9D5wWc9TPHWIdxI
 O0t6q07O4/7vrb6gYUwNzjgB91GBcOyIhaCGgUykfcdaogygx1oV2CC8E34m7OUKclHo
 pNMD5a4v0UR2aJZ6KMj7zlUOLREjTjUaHA7s9+oq7NyTYqwqkVHu7T/955gSM/ESxwdC
 bduXkiHIjPAsobIGD2yEUYi9FKLpqrP2Cyw7RBVWeLm4sxsi9pC/ctL4Udgd9oKW7tny
 6PfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770036119; x=1770640919;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3DmM3Ub08vve46EZTmx9zgN4irgtawQR9zpNQSGIMog=;
 b=fnAloPUbIuqih8sutQXgcynFCXJZ4N2HZbVZYtjD19NGJzLcuY1A8CjLhVNBPsaEJb
 eETPGsDVzHqZMpmlyN8qCQWTfhWhsMvHbpjyY/5VV8QeUCMUU37dpeIj+6MnBzxHwcWx
 9x1OZFxj4f3oYnPuzvDoGoeXNQFQkQf1gGfyBf5RQOy/M1yMbWlVMU2rwoWeRtQPuhNu
 DL1mzuoQYy/YOG2yncPL62xpkDtG0g7qg1F34OWU3lVkyrVIVEht5LHk8xxeeLrze6io
 37TeNVDxb9Z1TswxYGv/fdsxwS8wT0242hYY7GMd+AyXnkUCHIJ+xqix0ZN/yx6oQBBW
 0Qww==
X-Gm-Message-State: AOJu0YwjhYt446arwfYHwXbfOMcOA+sLrGTtriaIWeirPtFTe+FrS5Mz
 WJrqkFd9W76Od9S2v8m+e6zjlYQDilxQTE/oKIP+wVxEFgoeakRT0RNlBcZlwXeg9n4=
X-Gm-Gg: AZuq6aIy5O3NWZj4EQAAYM9c0J5PYTOsFtusoQalGCLdtOmPgpNBSSkxG7umal7jtWK
 71UCldMimC1r12L+tKjDMCGDxeXKI554iQu7qEf2+QYD4E/wBnRXJBj0FOATUilubFbWXZzf3AZ
 CwbDIyszbWsp1hYaTOqvrZUNal6nmpdN0xF9GRheAGbrCRggLnhigLRCSezH16KQ5u1bBKmCizl
 JZDxjs1A1N6GhsQUrgtIRXRslIt0W0Drm/8jX3jfpWi5m9MtJ+pcpQpBQXJv7nmOz/JiLPTaytI
 A403Xfn/VzffqEdIrWrYoS2m9WQGQyp20WyRlduwAu2IPnPxdodviAGjkob5Yg+X3y5jlhY+YKA
 FQRHH2gn9TNWTanlp5/+HuEaQow0caHss8QDRclpoP6hjZcESLemfP8IyIywgiRvCtIXrIWZ1fS
 C3JIKpPS0ON+0e9H1kMTVrCsOC8dOham2AcFJHQlUAlhmGNrLcIbgoYUg8ST0xbPha9GWwONoja
 sAGz1rGXg==
X-Received: by 2002:a5d:588b:0:b0:435:932e:f924 with SMTP id
 ffacd0b85a97d-435f428ad7cmr18882955f8f.2.1770036119500; 
 Mon, 02 Feb 2026 04:41:59 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-1bf9-06eb-939c-90d1.rev.sfr.net.
 [2a02:842a:d52e:6101:1bf9:6eb:939c:90d1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee562sm43593588f8f.18.2026.02.02.04.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 04:41:59 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 02 Feb 2026 13:41:51 +0100
Subject: [PATCH v2 3/5] clk: mediatek: mt8188: add missing fixed clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-mt8188-fix-clock-v2-3-b39bddfcac66@baylibre.com>
References: <20260202-mt8188-fix-clock-v2-0-b39bddfcac66@baylibre.com>
In-Reply-To: <20260202-mt8188-fix-clock-v2-0-b39bddfcac66@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

CLK_TOP_CLK13M was missing, add it.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8188.c | 391 +++++++++++++++++++-------------------
 1 file changed, 196 insertions(+), 195 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index f306cce1f5b..c0f68c41d6e 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -98,6 +98,7 @@ static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FIXED_CLK0(CLK_TOP_466M_FMEM, 533000000),
 	FIXED_CLK0(CLK_TOP_PEXTP_PIPE, 250000000),
 	FIXED_CLK0(CLK_TOP_DSI_PHY, 500000000),
+	FIXED_CLK0(CLK_TOP_CLK13M, 130000000),
 	FIXED_CLK0(CLK_TOP_CLK26M, 260000000),
 	FIXED_CLK0(CLK_TOP_CLK32K, 32000),
 };
@@ -1143,180 +1144,180 @@ static const struct mtk_composite top_muxes[] = {
 };
 
 static const int mt8188_id_offs_map[] = {
-	87, /* CLK_TOP_AXI */
-	88, /* CLK_TOP_SPM */
-	89, /* CLK_TOP_SCP */
-	90, /* CLK_TOP_BUS_AXIMEM */
-	91, /* CLK_TOP_VPP */
-	92, /* CLK_TOP_ETHDR */
-	93, /* CLK_TOP_IPE */
-	94, /* CLK_TOP_CAM */
-	95, /* CLK_TOP_CCU */
-	96, /* CLK_TOP_CCU_AHB */
-	97, /* CLK_TOP_IMG */
-	98, /* CLK_TOP_CAMTM */
-	99, /* CLK_TOP_DSP */
-	100, /* CLK_TOP_DSP1 */
-	101, /* CLK_TOP_DSP2 */
-	102, /* CLK_TOP_DSP3 */
-	103, /* CLK_TOP_DSP4 */
-	104, /* CLK_TOP_DSP5 */
-	105, /* CLK_TOP_DSP6 */
-	106, /* CLK_TOP_DSP7 */
-	107, /* CLK_TOP_MFG_CORE_TMP */
-	108, /* CLK_TOP_CAMTG */
-	109, /* CLK_TOP_CAMTG2 */
-	110, /* CLK_TOP_CAMTG3 */
-	111, /* CLK_TOP_UART */
-	112, /* CLK_TOP_SPI */
-	113, /* CLK_TOP_MSDC50_0_HCLK */
-	114, /* CLK_TOP_MSDC50_0 */
-	115, /* CLK_TOP_MSDC30_1 */
-	116, /* CLK_TOP_MSDC30_2 */
-	117, /* CLK_TOP_INTDIR */
-	118, /* CLK_TOP_AUD_INTBUS */
-	119, /* CLK_TOP_AUDIO_H */
-	120, /* CLK_TOP_PWRAP_ULPOSC */
-	121, /* CLK_TOP_ATB */
-	122, /* CLK_TOP_SSPM */
-	123, /* CLK_TOP_DP */
-	124, /* CLK_TOP_EDP */
-	125, /* CLK_TOP_DPI */
-	126, /* CLK_TOP_DISP_PWM0 */
-	127, /* CLK_TOP_DISP_PWM1 */
-	128, /* CLK_TOP_USB_TOP */
-	129, /* CLK_TOP_SSUSB_XHCI */
-	130, /* CLK_TOP_USB_TOP_2P */
-	131, /* CLK_TOP_SSUSB_XHCI_2P */
-	132, /* CLK_TOP_USB_TOP_3P */
-	133, /* CLK_TOP_SSUSB_XHCI_3P */
-	134, /* CLK_TOP_I2C */
-	135, /* CLK_TOP_SENINF */
-	136, /* CLK_TOP_SENINF1 */
-	137, /* CLK_TOP_GCPU */
-	138, /* CLK_TOP_VENC */
-	139, /* CLK_TOP_VDEC */
-	140, /* CLK_TOP_PWM */
-	141, /* CLK_TOP_MCUPM */
-	142, /* CLK_TOP_SPMI_P_MST */
-	143, /* CLK_TOP_SPMI_M_MST */
-	144, /* CLK_TOP_DVFSRC */
-	145, /* CLK_TOP_TL */
-	146, /* CLK_TOP_AES_MSDCFDE */
-	147, /* CLK_TOP_DSI_OCC */
-	148, /* CLK_TOP_WPE_VPP */
-	149, /* CLK_TOP_HDCP */
-	150, /* CLK_TOP_HDCP_24M */
-	151, /* CLK_TOP_HDMI_APB */
-	152, /* CLK_TOP_SNPS_ETH_250M */
-	153, /* CLK_TOP_SNPS_ETH_62P4M_PTP */
-	154, /* CLK_TOP_SNPS_ETH_50M_RMII */
-	155, /* CLK_TOP_ADSP */
-	156, /* CLK_TOP_AUDIO_LOCAL_BUS */
-	157, /* CLK_TOP_ASM_H */
-	158, /* CLK_TOP_ASM_L */
-	159, /* CLK_TOP_APLL1 */
-	160, /* CLK_TOP_APLL2 */
-	161, /* CLK_TOP_APLL3 */
-	162, /* CLK_TOP_APLL4 */
-	163, /* CLK_TOP_APLL5 */
-	164, /* CLK_TOP_I2SO1 */
-	165, /* CLK_TOP_I2SO2 */
-	166, /* CLK_TOP_I2SI1 */
-	167, /* CLK_TOP_I2SI2 */
-	168, /* CLK_TOP_DPTX */
-	169, /* CLK_TOP_AUD_IEC */
-	170, /* CLK_TOP_A1SYS_HP */
-	171, /* CLK_TOP_A2SYS */
-	172, /* CLK_TOP_A3SYS */
-	173, /* CLK_TOP_A4SYS */
-	174, /* CLK_TOP_ECC */
-	175, /* CLK_TOP_SPINOR */
-	176, /* CLK_TOP_ULPOSC */
-	177, /* CLK_TOP_SRCK */
+	88, /* CLK_TOP_AXI */
+	89, /* CLK_TOP_SPM */
+	90, /* CLK_TOP_SCP */
+	91, /* CLK_TOP_BUS_AXIMEM */
+	92, /* CLK_TOP_VPP */
+	93, /* CLK_TOP_ETHDR */
+	94, /* CLK_TOP_IPE */
+	95, /* CLK_TOP_CAM */
+	96, /* CLK_TOP_CCU */
+	97, /* CLK_TOP_CCU_AHB */
+	98, /* CLK_TOP_IMG */
+	99, /* CLK_TOP_CAMTM */
+	100, /* CLK_TOP_DSP */
+	101, /* CLK_TOP_DSP1 */
+	102, /* CLK_TOP_DSP2 */
+	103, /* CLK_TOP_DSP3 */
+	104, /* CLK_TOP_DSP4 */
+	105, /* CLK_TOP_DSP5 */
+	106, /* CLK_TOP_DSP6 */
+	107, /* CLK_TOP_DSP7 */
+	108, /* CLK_TOP_MFG_CORE_TMP */
+	109, /* CLK_TOP_CAMTG */
+	110, /* CLK_TOP_CAMTG2 */
+	111, /* CLK_TOP_CAMTG3 */
+	112, /* CLK_TOP_UART */
+	113, /* CLK_TOP_SPI */
+	114, /* CLK_TOP_MSDC50_0_HCLK */
+	115, /* CLK_TOP_MSDC50_0 */
+	116, /* CLK_TOP_MSDC30_1 */
+	117, /* CLK_TOP_MSDC30_2 */
+	118, /* CLK_TOP_INTDIR */
+	119, /* CLK_TOP_AUD_INTBUS */
+	120, /* CLK_TOP_AUDIO_H */
+	121, /* CLK_TOP_PWRAP_ULPOSC */
+	122, /* CLK_TOP_ATB */
+	123, /* CLK_TOP_SSPM */
+	124, /* CLK_TOP_DP */
+	125, /* CLK_TOP_EDP */
+	126, /* CLK_TOP_DPI */
+	127, /* CLK_TOP_DISP_PWM0 */
+	128, /* CLK_TOP_DISP_PWM1 */
+	129, /* CLK_TOP_USB_TOP */
+	130, /* CLK_TOP_SSUSB_XHCI */
+	131, /* CLK_TOP_USB_TOP_2P */
+	132, /* CLK_TOP_SSUSB_XHCI_2P */
+	133, /* CLK_TOP_USB_TOP_3P */
+	134, /* CLK_TOP_SSUSB_XHCI_3P */
+	135, /* CLK_TOP_I2C */
+	136, /* CLK_TOP_SENINF */
+	137, /* CLK_TOP_SENINF1 */
+	138, /* CLK_TOP_GCPU */
+	139, /* CLK_TOP_VENC */
+	140, /* CLK_TOP_VDEC */
+	141, /* CLK_TOP_PWM */
+	142, /* CLK_TOP_MCUPM */
+	143, /* CLK_TOP_SPMI_P_MST */
+	144, /* CLK_TOP_SPMI_M_MST */
+	145, /* CLK_TOP_DVFSRC */
+	146, /* CLK_TOP_TL */
+	147, /* CLK_TOP_AES_MSDCFDE */
+	148, /* CLK_TOP_DSI_OCC */
+	149, /* CLK_TOP_WPE_VPP */
+	150, /* CLK_TOP_HDCP */
+	151, /* CLK_TOP_HDCP_24M */
+	152, /* CLK_TOP_HDMI_APB */
+	153, /* CLK_TOP_SNPS_ETH_250M */
+	154, /* CLK_TOP_SNPS_ETH_62P4M_PTP */
+	155, /* CLK_TOP_SNPS_ETH_50M_RMII */
+	156, /* CLK_TOP_ADSP */
+	157, /* CLK_TOP_AUDIO_LOCAL_BUS */
+	158, /* CLK_TOP_ASM_H */
+	159, /* CLK_TOP_ASM_L */
+	160, /* CLK_TOP_APLL1 */
+	161, /* CLK_TOP_APLL2 */
+	162, /* CLK_TOP_APLL3 */
+	163, /* CLK_TOP_APLL4 */
+	164, /* CLK_TOP_APLL5 */
+	165, /* CLK_TOP_I2SO1 */
+	166, /* CLK_TOP_I2SO2 */
+	167, /* CLK_TOP_I2SI1 */
+	168, /* CLK_TOP_I2SI2 */
+	169, /* CLK_TOP_DPTX */
+	170, /* CLK_TOP_AUD_IEC */
+	171, /* CLK_TOP_A1SYS_HP */
+	172, /* CLK_TOP_A2SYS */
+	173, /* CLK_TOP_A3SYS */
+	174, /* CLK_TOP_A4SYS */
+	175, /* CLK_TOP_ECC */
+	176, /* CLK_TOP_SPINOR */
+	177, /* CLK_TOP_ULPOSC */
+	178, /* CLK_TOP_SRCK */
 	-1, /* CLK_TOP_MFG_CK_FAST_REF */
-	8, /* CLK_TOP_MAINPLL_D3 */
-	9, /* CLK_TOP_MAINPLL_D4 */
-	10, /* CLK_TOP_MAINPLL_D4_D2 */
-	11, /* CLK_TOP_MAINPLL_D4_D4 */
-	12, /* CLK_TOP_MAINPLL_D4_D8 */
-	13, /* CLK_TOP_MAINPLL_D5 */
-	14, /* CLK_TOP_MAINPLL_D5_D2 */
-	15, /* CLK_TOP_MAINPLL_D5_D4 */
-	16, /* CLK_TOP_MAINPLL_D5_D8 */
-	17, /* CLK_TOP_MAINPLL_D6 */
-	18, /* CLK_TOP_MAINPLL_D6_D2 */
-	19, /* CLK_TOP_MAINPLL_D6_D4 */
-	20, /* CLK_TOP_MAINPLL_D6_D8 */
-	21, /* CLK_TOP_MAINPLL_D7 */
-	22, /* CLK_TOP_MAINPLL_D7_D2 */
-	23, /* CLK_TOP_MAINPLL_D7_D4 */
-	24, /* CLK_TOP_MAINPLL_D7_D8 */
-	25, /* CLK_TOP_MAINPLL_D9 */
-	26, /* CLK_TOP_UNIVPLL_D2 */
-	27, /* CLK_TOP_UNIVPLL_D3 */
-	28, /* CLK_TOP_UNIVPLL_D4 */
-	29, /* CLK_TOP_UNIVPLL_D4_D2 */
-	30, /* CLK_TOP_UNIVPLL_D4_D4 */
-	31, /* CLK_TOP_UNIVPLL_D4_D8 */
-	32, /* CLK_TOP_UNIVPLL_D5 */
-	33, /* CLK_TOP_UNIVPLL_D5_D2 */
-	34, /* CLK_TOP_UNIVPLL_D5_D4 */
-	35, /* CLK_TOP_UNIVPLL_D5_D8 */
-	36, /* CLK_TOP_UNIVPLL_D6 */
-	37, /* CLK_TOP_UNIVPLL_D6_D2 */
-	38, /* CLK_TOP_UNIVPLL_D6_D4 */
-	39, /* CLK_TOP_UNIVPLL_D6_D8 */
-	40, /* CLK_TOP_UNIVPLL_D7 */
-	41, /* CLK_TOP_UNIVPLL_192M */
-	42, /* CLK_TOP_UNIVPLL_192M_D4 */
-	43, /* CLK_TOP_UNIVPLL_192M_D8 */
-	44, /* CLK_TOP_UNIVPLL_192M_D10 */
-	45, /* CLK_TOP_UNIVPLL_192M_D16 */
-	46, /* CLK_TOP_UNIVPLL_192M_D32 */
-	47, /* CLK_TOP_APLL1_D3 */
-	48, /* CLK_TOP_APLL1_D4 */
-	49, /* CLK_TOP_APLL2_D3 */
-	50, /* CLK_TOP_APLL2_D4 */
-	51, /* CLK_TOP_APLL3_D4 */
-	52, /* CLK_TOP_APLL4_D4 */
-	53, /* CLK_TOP_APLL5_D4 */
-	54, /* CLK_TOP_MMPLL_D4 */
-	55, /* CLK_TOP_MMPLL_D4_D2 */
-	56, /* CLK_TOP_MMPLL_D5 */
-	57, /* CLK_TOP_MMPLL_D5_D2 */
-	58, /* CLK_TOP_MMPLL_D5_D4 */
-	59, /* CLK_TOP_MMPLL_D6 */
-	60, /* CLK_TOP_MMPLL_D6_D2 */
-	61, /* CLK_TOP_MMPLL_D7 */
+	9, /* CLK_TOP_MAINPLL_D3 */
+	10, /* CLK_TOP_MAINPLL_D4 */
+	11, /* CLK_TOP_MAINPLL_D4_D2 */
+	12, /* CLK_TOP_MAINPLL_D4_D4 */
+	13, /* CLK_TOP_MAINPLL_D4_D8 */
+	14, /* CLK_TOP_MAINPLL_D5 */
+	15, /* CLK_TOP_MAINPLL_D5_D2 */
+	16, /* CLK_TOP_MAINPLL_D5_D4 */
+	17, /* CLK_TOP_MAINPLL_D5_D8 */
+	18, /* CLK_TOP_MAINPLL_D6 */
+	19, /* CLK_TOP_MAINPLL_D6_D2 */
+	20, /* CLK_TOP_MAINPLL_D6_D4 */
+	21, /* CLK_TOP_MAINPLL_D6_D8 */
+	22, /* CLK_TOP_MAINPLL_D7 */
+	23, /* CLK_TOP_MAINPLL_D7_D2 */
+	24, /* CLK_TOP_MAINPLL_D7_D4 */
+	25, /* CLK_TOP_MAINPLL_D7_D8 */
+	26, /* CLK_TOP_MAINPLL_D9 */
+	27, /* CLK_TOP_UNIVPLL_D2 */
+	28, /* CLK_TOP_UNIVPLL_D3 */
+	29, /* CLK_TOP_UNIVPLL_D4 */
+	30, /* CLK_TOP_UNIVPLL_D4_D2 */
+	31, /* CLK_TOP_UNIVPLL_D4_D4 */
+	32, /* CLK_TOP_UNIVPLL_D4_D8 */
+	33, /* CLK_TOP_UNIVPLL_D5 */
+	34, /* CLK_TOP_UNIVPLL_D5_D2 */
+	35, /* CLK_TOP_UNIVPLL_D5_D4 */
+	36, /* CLK_TOP_UNIVPLL_D5_D8 */
+	37, /* CLK_TOP_UNIVPLL_D6 */
+	38, /* CLK_TOP_UNIVPLL_D6_D2 */
+	39, /* CLK_TOP_UNIVPLL_D6_D4 */
+	40, /* CLK_TOP_UNIVPLL_D6_D8 */
+	41, /* CLK_TOP_UNIVPLL_D7 */
+	42, /* CLK_TOP_UNIVPLL_192M */
+	43, /* CLK_TOP_UNIVPLL_192M_D4 */
+	44, /* CLK_TOP_UNIVPLL_192M_D8 */
+	45, /* CLK_TOP_UNIVPLL_192M_D10 */
+	46, /* CLK_TOP_UNIVPLL_192M_D16 */
+	47, /* CLK_TOP_UNIVPLL_192M_D32 */
+	48, /* CLK_TOP_APLL1_D3 */
+	49, /* CLK_TOP_APLL1_D4 */
+	50, /* CLK_TOP_APLL2_D3 */
+	51, /* CLK_TOP_APLL2_D4 */
+	52, /* CLK_TOP_APLL3_D4 */
+	53, /* CLK_TOP_APLL4_D4 */
+	54, /* CLK_TOP_APLL5_D4 */
+	55, /* CLK_TOP_MMPLL_D4 */
+	56, /* CLK_TOP_MMPLL_D4_D2 */
+	57, /* CLK_TOP_MMPLL_D5 */
+	58, /* CLK_TOP_MMPLL_D5_D2 */
+	59, /* CLK_TOP_MMPLL_D5_D4 */
+	60, /* CLK_TOP_MMPLL_D6 */
+	61, /* CLK_TOP_MMPLL_D6_D2 */
+	62, /* CLK_TOP_MMPLL_D7 */
 	62, /* CLK_TOP_MMPLL_D9 */
 	-1, /* CLK_TOP_TVDPLL1 */
-	63, /* CLK_TOP_TVDPLL1_D2 */
-	64, /* CLK_TOP_TVDPLL1_D4 */
-	65, /* CLK_TOP_TVDPLL1_D8 */
-	66, /* CLK_TOP_TVDPLL1_D16 */
+	64, /* CLK_TOP_TVDPLL1_D2 */
+	65, /* CLK_TOP_TVDPLL1_D4 */
+	66, /* CLK_TOP_TVDPLL1_D8 */
+	67, /* CLK_TOP_TVDPLL1_D16 */
 	-1, /* CLK_TOP_TVDPLL2 */
-	67, /* CLK_TOP_TVDPLL2_D2 */
-	68, /* CLK_TOP_TVDPLL2_D4 */
-	69, /* CLK_TOP_TVDPLL2_D8 */
-	70, /* CLK_TOP_TVDPLL2_D16 */
-	72, /* CLK_TOP_MSDCPLL_D2 */
-	73, /* CLK_TOP_MSDCPLL_D16 */
+	68, /* CLK_TOP_TVDPLL2_D2 */
+	69, /* CLK_TOP_TVDPLL2_D4 */
+	70, /* CLK_TOP_TVDPLL2_D8 */
+	71, /* CLK_TOP_TVDPLL2_D16 */
+	73, /* CLK_TOP_MSDCPLL_D2 */
+	74, /* CLK_TOP_MSDCPLL_D16 */
 	-1, /* CLK_TOP_ETHPLL */
-	74, /* CLK_TOP_ETHPLL_D2 */
-	75, /* CLK_TOP_ETHPLL_D4 */
-	76, /* CLK_TOP_ETHPLL_D8 */
-	77, /* CLK_TOP_ETHPLL_D10 */
-	78, /* CLK_TOP_ADSPPLL_D2 */
-	79, /* CLK_TOP_ADSPPLL_D4 */
-	80, /* CLK_TOP_ADSPPLL_D8 */
+	75, /* CLK_TOP_ETHPLL_D2 */
+	76, /* CLK_TOP_ETHPLL_D4 */
+	77, /* CLK_TOP_ETHPLL_D8 */
+	78, /* CLK_TOP_ETHPLL_D10 */
+	79, /* CLK_TOP_ADSPPLL_D2 */
+	80, /* CLK_TOP_ADSPPLL_D4 */
+	81, /* CLK_TOP_ADSPPLL_D8 */
 	0,  /* CLK_TOP_ULPOSC1 */
-	81, /* CLK_TOP_ULPOSC1_D2 */
-	82, /* CLK_TOP_ULPOSC1_D4 */
-	83, /* CLK_TOP_ULPOSC1_D8 */
-	84, /* CLK_TOP_ULPOSC1_D7 */
-	85, /* CLK_TOP_ULPOSC1_D10 */
-	86, /* CLK_TOP_ULPOSC1_D16 */
+	82, /* CLK_TOP_ULPOSC1_D2 */
+	83, /* CLK_TOP_ULPOSC1_D4 */
+	84, /* CLK_TOP_ULPOSC1_D8 */
+	85, /* CLK_TOP_ULPOSC1_D7 */
+	86, /* CLK_TOP_ULPOSC1_D10 */
+	87, /* CLK_TOP_ULPOSC1_D16 */
 	1, /* CLK_TOP_MPHONE_SLAVE_BCK */
 	2, /* CLK_TOP_PAD_FPC */
 	3, /* CLK_TOP_466M_FMEM */
@@ -1328,33 +1329,33 @@ static const int mt8188_id_offs_map[] = {
 	-1, /* CLK_TOP_APLL12_CK_DIV3 */
 	-1, /* CLK_TOP_APLL12_CK_DIV4 */
 	-1, /* CLK_TOP_APLL12_CK_DIV9 */
-	187, /* CLK_TOP_CFGREG_CLOCK_EN_VPP0 */
-	188, /* CLK_TOP_CFGREG_CLOCK_EN_VPP1 */
-	189, /* CLK_TOP_CFGREG_CLOCK_EN_VDO0 */
-	190, /* CLK_TOP_CFGREG_CLOCK_EN_VDO1 */
-	191, /* CLK_TOP_CFGREG_CLOCK_ISP_AXI_GALS */
-	192, /* CLK_TOP_CFGREG_F26M_VPP0 */
-	193, /* CLK_TOP_CFGREG_F26M_VPP1 */
-	194, /* CLK_TOP_CFGREG_F26M_VDO0 */
-	195, /* CLK_TOP_CFGREG_F26M_VDO1 */
-	196, /* CLK_TOP_CFGREG_AUD_F26M_AUD */
-	197, /* CLK_TOP_CFGREG_UNIPLL_SES */
-	198, /* CLK_TOP_CFGREG_F_PCIE_PHY_REF */
-	199, /* CLK_TOP_SSUSB_TOP_REF */
-	200, /* CLK_TOP_SSUSB_PHY_REF */
-	201, /* CLK_TOP_SSUSB_TOP_P1_REF */
-	202, /* CLK_TOP_SSUSB_PHY_P1_REF */
-	203, /* CLK_TOP_SSUSB_TOP_P2_REF */
-	204, /* CLK_TOP_SSUSB_PHY_P2_REF */
-	205, /* CLK_TOP_SSUSB_TOP_P3_REF */
-	223, /* CLK_TOP_SSUSB_PHY_P3_REF */
+	188, /* CLK_TOP_CFGREG_CLOCK_EN_VPP0 */
+	189, /* CLK_TOP_CFGREG_CLOCK_EN_VPP1 */
+	190, /* CLK_TOP_CFGREG_CLOCK_EN_VDO0 */
+	191, /* CLK_TOP_CFGREG_CLOCK_EN_VDO1 */
+	192, /* CLK_TOP_CFGREG_CLOCK_ISP_AXI_GALS */
+	193, /* CLK_TOP_CFGREG_F26M_VPP0 */
+	194, /* CLK_TOP_CFGREG_F26M_VPP1 */
+	195, /* CLK_TOP_CFGREG_F26M_VDO0 */
+	196, /* CLK_TOP_CFGREG_F26M_VDO1 */
+	197, /* CLK_TOP_CFGREG_AUD_F26M_AUD */
+	198, /* CLK_TOP_CFGREG_UNIPLL_SES */
+	199, /* CLK_TOP_CFGREG_F_PCIE_PHY_REF */
+	200, /* CLK_TOP_SSUSB_TOP_REF */
+	201, /* CLK_TOP_SSUSB_PHY_REF */
+	202, /* CLK_TOP_SSUSB_TOP_P1_REF */
+	203, /* CLK_TOP_SSUSB_PHY_P1_REF */
+	204, /* CLK_TOP_SSUSB_TOP_P2_REF */
+	205, /* CLK_TOP_SSUSB_PHY_P2_REF */
+	206, /* CLK_TOP_SSUSB_TOP_P3_REF */
+	207, /* CLK_TOP_SSUSB_PHY_P3_REF */
 	-1, /* CLK_TOP_NR_CLK */
 	-1, /* CLK_TOP_ADSPPLL */
-	-1, /* CLK_TOP_CLK13M */
-	6, /* CLK_TOP_CLK26M */
-	7, /* CLK_TOP_CLK32K */
+	6, /* CLK_TOP_CLK13M */
+	7, /* CLK_TOP_CLK26M */
+	8, /* CLK_TOP_CLK32K */
 	-1, /* CLK_TOP_IMGPLL */
-	71, /* CLK_TOP_MSDCPLL */
+	72, /* CLK_TOP_MSDCPLL */
 	-1, /* CLK_TOP_ULPOSC1_CK1 */
 	-1, /* CLK_TOP_ULPOSC_CK1 */
 };
@@ -1417,9 +1418,9 @@ static const struct mtk_clk_tree mt8188_topckgen_clk_tree = {
 	.xtal2_rate = 26 * MHZ,
 	.id_offs_map = mt8188_id_offs_map,
 	.id_offs_map_size = ARRAY_SIZE(mt8188_id_offs_map),
-	.fdivs_offs = 8, /* CLK_TOP_MAINPLL_D3 */
-	.muxes_offs = 87, /* CLK_TOP_AXI */
-	.gates_offs = 187, /* CLK_TOP_CFGREG_CLOCK_EN_VPP0 */
+	.fdivs_offs = 9, /* CLK_TOP_MAINPLL_D3 */
+	.muxes_offs = 88, /* CLK_TOP_AXI */
+	.gates_offs = 188, /* CLK_TOP_CFGREG_CLOCK_EN_VPP0 */
 	.fclks = top_fixed_clks,
 	.fdivs = top_fixed_divs,
 	.muxes = top_muxes,

-- 
2.52.0

