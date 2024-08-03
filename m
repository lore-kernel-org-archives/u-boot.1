Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8ECC52D6D
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 11:14:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1E6288CC9;
	Sat,  3 Aug 2024 13:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eW+r4rD9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FE2788CD5; Sat,  3 Aug 2024 13:13:12 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA98688C6D
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 13:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4280b3a7efaso61412175e9.0
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 04:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722683590; x=1723288390; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4Teuf3wh+jlnCCK3oJoJu0GluEUeNIQxEgMImDcPcQk=;
 b=eW+r4rD9sCPU/4YcD/i/Esx2kPCvdoS0nPzu2f7KkBHmoI8ZY9Dn3sqGcJnXp8zzMH
 3qwxeV01Pcmk78fpQadYiZ21XLcTtXSNcWy+5FGxQ0ddKuj0MJgsLoGeJm/MhQ2NF1S5
 byM/yBBbmlWXNbOr69rB2AaQ6y2qK1xugGL702A9UTT0R3LNYUfZEm/5s/33IyR+gkPp
 fmDSsvb65iIcDyfHgJePvyTFck4pYzF7dl8KOSyVWzfB7W2+LmD3o2v4blVROgISc89E
 OW2Qk/RHrP1k4W71YRJcFE7pYutGBWvSFkGudCO1pf3DqkEvcLT2Fp3dpSe0Qgl6VSub
 Rdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722683590; x=1723288390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Teuf3wh+jlnCCK3oJoJu0GluEUeNIQxEgMImDcPcQk=;
 b=J2Np5SI/VGCwtgtl0L2I4OPvBL+wCb2AzFE6T1CeqlNOf5ee+b54Jkw9pkHLiPl83T
 uqy/w8qlX4WzY29yzPyrEOi6BTS2FguIY9yJwbrbZRPsXx+9hgmUkuQsoxkzONplJXke
 uHN9iLp8uW1ZKjOt0IHMVLvgVMnHEalK4m/pmM5ZpeQh2Hp4cakAOV6ky7pyDsc7lMIV
 Yd/bN/hqyH+zGaE9am38jZhxfnRN1YVGvnP3xLx6nzOyzOcmHkY/blYomLxqtfn3BPvt
 Lib0KfU7uokrU7SOJPOo3plxLhVQhCB0OhJq7p6LuotaBFHiY+K7qLbx1fLGE7S2aYgE
 +TPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz3e4SeBWkODOxY7OAQ4FbqHXsU6yQvHhYVUBzO1nerN94mM0f0+m6U1c+4lHxMMQX6aVlmP4A+mj8jqi9xcDZxXUyaQ==
X-Gm-Message-State: AOJu0YyB9wYCbSF2Umn19CSS3KnsjXiH9CX0yyImZxE4lUNlwyYMgw1P
 lhJOUpD7DGwcN8LK8HbhwuSHird4skIK9LI4mpWeRMmHFlDaxrzdxTR4zA==
X-Google-Smtp-Source: AGHT+IEgY67WpgAI2aALxECDHqxJuL3P/aVE/LDaqXNVnx4qYfY9vfgIVKkXL3JM5C/lSuNYaNMreQ==
X-Received: by 2002:adf:a3d7:0:b0:368:4ed7:2acb with SMTP id
 ffacd0b85a97d-36bbc0c6b33mr3486882f8f.5.1722683590009; 
 Sat, 03 Aug 2024 04:13:10 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428e6d648a0sm63835655e9.10.2024.08.03.04.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 04:13:09 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 7/8] clk: mediatek: mt7622: add missing clock PERIBUS_SEL
 clock
Date: Sat,  3 Aug 2024 10:43:25 +0200
Message-ID: <20240803084329.1688-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803084329.1688-1-ansuelsmth@gmail.com>
References: <20240803084329.1688-1-ansuelsmth@gmail.com>
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

Add missing PERIBUS_SEL clock to match upstream linux clk ID order. Also
convert pericfg to mux + gate implementation as now we have also mux on
top of gates.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7622.c      | 22 +++++++++-
 include/dt-bindings/clock/mt7622-clk.h | 59 +++++++++++++-------------
 2 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 5df62e64c9a..23b9787612a 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -422,6 +422,18 @@ static const struct mtk_gate infra_cgs[] = {
 };
 
 /* pericfg */
+static const int peribus_ck_parents[] = {
+	CLK_TOP_SYSPLL1_D8,
+	CLK_TOP_SYSPLL1_D4,
+};
+
+#define PERI_MUX(_id, _parents, _reg, _shift, _width) \
+	MUX_FLAGS(_id, _parents, _reg, _shift, _width, CLK_PARENT_TOPCKGEN)
+
+static const struct mtk_composite peri_muxes[] = {
+	PERI_MUX(CLK_PERIBUS_SEL, peribus_ck_parents, 0x05c, 0, 1),
+};
+
 static const struct mtk_gate_regs peri0_cg_regs = {
 	.set_ofs = 0x8,
 	.clr_ofs = 0x10,
@@ -602,6 +614,14 @@ static const struct mtk_clk_tree mt7622_infra_clk_tree = {
 	.gates = infra_cgs,
 };
 
+static const struct mtk_clk_tree mt7622_peri_clk_tree = {
+	.xtal_rate = 25 * MHZ,
+	.muxes_offs = CLK_PERIBUS_SEL,
+	.gates_offs = CLK_PERI_THERM_PD,
+	.muxes = peri_muxes,
+	.gates = peri_cgs,
+};
+
 static const struct mtk_clk_tree mt7622_clk_tree = {
 	.xtal_rate = 25 * MHZ,
 	.fdivs_offs = CLK_TOP_TO_USB3_SYS,
@@ -658,7 +678,7 @@ static int mt7622_infracfg_probe(struct udevice *dev)
 
 static int mt7622_pericfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7622_clk_tree, peri_cgs);
+	return mtk_common_clk_infrasys_init(dev, &mt7622_peri_clk_tree);
 }
 
 static int mt7622_pciesys_probe(struct udevice *dev)
diff --git a/include/dt-bindings/clock/mt7622-clk.h b/include/dt-bindings/clock/mt7622-clk.h
index 4b6501c1020..cd11a1c901e 100644
--- a/include/dt-bindings/clock/mt7622-clk.h
+++ b/include/dt-bindings/clock/mt7622-clk.h
@@ -130,35 +130,36 @@
 
 /* PERICFG */
 
-#define CLK_PERI_THERM_PD		0
-#define CLK_PERI_PWM1_PD		1
-#define CLK_PERI_PWM2_PD		2
-#define CLK_PERI_PWM3_PD		3
-#define CLK_PERI_PWM4_PD		4
-#define CLK_PERI_PWM5_PD		5
-#define CLK_PERI_PWM6_PD		6
-#define CLK_PERI_PWM7_PD		7
-#define CLK_PERI_PWM_PD			8
-#define CLK_PERI_AP_DMA_PD		9
-#define CLK_PERI_MSDC30_0_PD		10
-#define CLK_PERI_MSDC30_1_PD		11
-#define CLK_PERI_UART0_PD		12
-#define CLK_PERI_UART1_PD		13
-#define CLK_PERI_UART2_PD		14
-#define CLK_PERI_UART3_PD		15
-#define CLK_PERI_UART4_PD		16
-#define CLK_PERI_BTIF_PD		17
-#define CLK_PERI_I2C0_PD		18
-#define CLK_PERI_I2C1_PD		19
-#define CLK_PERI_I2C2_PD		20
-#define CLK_PERI_SPI1_PD		21
-#define CLK_PERI_AUXADC_PD		22
-#define CLK_PERI_SPI0_PD		23
-#define CLK_PERI_SNFI_PD		24
-#define CLK_PERI_NFI_PD			25
-#define CLK_PERI_NFIECC_PD		26
-#define CLK_PERI_FLASH_PD		27
-#define CLK_PERI_IRTX_PD		28
+#define CLK_PERIBUS_SEL			0
+#define CLK_PERI_THERM_PD		1
+#define CLK_PERI_PWM1_PD		2
+#define CLK_PERI_PWM2_PD		3
+#define CLK_PERI_PWM3_PD		4
+#define CLK_PERI_PWM4_PD		5
+#define CLK_PERI_PWM5_PD		6
+#define CLK_PERI_PWM6_PD		7
+#define CLK_PERI_PWM7_PD		8
+#define CLK_PERI_PWM_PD			9
+#define CLK_PERI_AP_DMA_PD		10
+#define CLK_PERI_MSDC30_0_PD		11
+#define CLK_PERI_MSDC30_1_PD		12
+#define CLK_PERI_UART0_PD		13
+#define CLK_PERI_UART1_PD		14
+#define CLK_PERI_UART2_PD		15
+#define CLK_PERI_UART3_PD		16
+#define CLK_PERI_UART4_PD		17
+#define CLK_PERI_BTIF_PD		18
+#define CLK_PERI_I2C0_PD		19
+#define CLK_PERI_I2C1_PD		20
+#define CLK_PERI_I2C2_PD		21
+#define CLK_PERI_SPI1_PD		22
+#define CLK_PERI_AUXADC_PD		23
+#define CLK_PERI_SPI0_PD		24
+#define CLK_PERI_SNFI_PD		25
+#define CLK_PERI_NFI_PD			26
+#define CLK_PERI_NFIECC_PD		27
+#define CLK_PERI_FLASH_PD		28
+#define CLK_PERI_IRTX_PD		29
 
 /* APMIXEDSYS */
 
-- 
2.45.2

