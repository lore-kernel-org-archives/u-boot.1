Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419FCC3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:58:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 730D888C91;
	Fri,  2 Aug 2024 21:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U9c7mQsa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0484288C7C; Fri,  2 Aug 2024 21:56:48 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 627AC88C4B
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ef2fccca2cso96638561fa.1
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628603; x=1723233403; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v45ol0xFzUxmdQ9yY+pUZ/NYy6q1B0GoQgn+8RgX7EE=;
 b=U9c7mQsaG4saJ3lpd4qfe5Gt0BOqx0P4UCZGfGCcgvE93WRE5Mbl26HyZwFEPlaaQN
 luFYH3Stpa4EgKy49vU7AOAXuh+s6kfCR84dHXu7nnyjH6hokUXMtHplZHYRgCD6PwNe
 QXiwIcs1msLpZrqbOO3Phx/er1KRPYOs2vqweu/wv98+GJ9PJveI7iwkiuwvfDYuBCpH
 4ltLBu7dvB32HJbOR3flbNUbp0MfBS8sNH8JSSMTmy/og9Wft/iCHe51600eZUuD/Zi9
 Z+2YZmxuTf5yUHmjSWzQWRLik4ilTDBH5buU8tKgf0sWlK3C2UoeDBnA13ACRMbrrvQh
 aPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628603; x=1723233403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v45ol0xFzUxmdQ9yY+pUZ/NYy6q1B0GoQgn+8RgX7EE=;
 b=s4yjp9KzKdoub1c4XvNbagPbe/vJCgdicR3C+0M96vgI5ndiCaMBayMlkF5jip6c/s
 Epu/nvEByHH8I51ddNZa3rWOLjdPsm1f0isylkERvIfZnu5wBXglzXNgkM6tNZjTI9YD
 KXOqOB0ooV/tvniQGArst6AoQwRpOLLe2tNcwfPzgQ31FUEBLyTTtABPSG+s0NGQ88BG
 rLTh68fAAIDA0Ptfg4tGJyWsmTPjWU0szs7OvJ7c7M99F8fiuoDH4x6/4n42axWrCJGk
 yUY8cM6cGa8U4iWUN1yOvY5kq+9bvjxuPBHceFFU7uJsqAZ33NmCsvWJAS3czE0s23vi
 iTYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmyKfnlYqNd9r2FkEUqOv1IfOe1r6bgnLXFtp9AVsndW/TB7/K1VL/dJWS6/SP+azAN1m0G4o6qva5sPVA85n2YLNTxQ==
X-Gm-Message-State: AOJu0YzzPNgg2kO9/4aOsE5iksETdOJJZt91D/L9DT7lBKsm6vogwXGS
 LxIIbRbQZSrdOKoTPYvGaj2sHlYAN76w11xRa4sK9jIoMnzCsmLj
X-Google-Smtp-Source: AGHT+IFxwCRh+IczLyNud/ZQ3xEHVp/glmhcImA0bOHjdbfND8jNLch1D5Uxd4dbBLoj04gisSqy1g==
X-Received: by 2002:a2e:954f:0:b0:2ef:18b7:4408 with SMTP id
 38308e7fff4ca-2f15aa834a2mr31547851fa.5.1722628603038; 
 Fri, 02 Aug 2024 12:56:43 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428e6e01d0asm43350485e9.16.2024.08.02.12.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:56:42 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Crispin John <john@phrozen.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH 09/14] clk: mediatek: mt7981: implement sgmii0/1 clock
Date: Fri,  2 Aug 2024 15:53:10 +0200
Message-ID: <20240802135326.25303-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802135326.25303-1-ansuelsmth@gmail.com>
References: <20240802135326.25303-1-ansuelsmth@gmail.com>
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

Implement missing sgmii0/1 clock and update the compatible the DTS to
match upstream kernel linux and in preparation for OF_UPSTREAM support
since the ethernet node define these additional clocks.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/mt7981.dtsi          |  4 +-
 drivers/clk/mediatek/clk-mt7981.c | 68 +++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/mt7981.dtsi b/arch/arm/dts/mt7981.dtsi
index be0d42bc997..1be1b797b3e 100644
--- a/arch/arm/dts/mt7981.dtsi
+++ b/arch/arm/dts/mt7981.dtsi
@@ -244,14 +244,14 @@
 	};
 
 	sgmiisys0: syscon@10060000 {
-		compatible = "mediatek,mt7986-sgmiisys", "syscon";
+		compatible = "mediatek,mt7981-sgmiisys_0", "syscon";
 		reg = <0x10060000 0x1000>;
 		pn_swap;
 		#clock-cells = <1>;
 	};
 
 	sgmiisys1: syscon@10070000 {
-		compatible = "mediatek,mt7986-sgmiisys", "syscon";
+		compatible = "mediatek,mt7981-sgmiisys_1", "syscon";
 		reg = <0x10070000 0x1000>;
 		#clock-cells = <1>;
 	};
diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 8b2e667c049..ac1d93e162f 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -629,6 +629,74 @@ U_BOOT_DRIVER(mtk_clk_infracfg_ao) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
+/* sgmiisys */
+static const struct mtk_gate_regs sgmii_cg_regs = {
+	.set_ofs = 0xe4,
+	.clr_ofs = 0xe4,
+	.sta_ofs = 0xe4,
+};
+
+#define GATE_SGMII(_id, _name, _parent, _shift)                                \
+	{                                                                      \
+		.id = _id, .parent = _parent, .regs = &sgmii_cg_regs,          \
+		.shift = _shift,                                               \
+		.flags = CLK_GATE_NO_SETCLR_INV | CLK_PARENT_TOPCKGEN,         \
+	}
+
+static const struct mtk_gate sgmii0_cgs[] = {
+	GATE_SGMII(CK_SGM0_TX_EN, "sgm0_tx_en", CK_TOP_USB_TX250M, 2),
+	GATE_SGMII(CK_SGM0_RX_EN, "sgm0_rx_en", CK_TOP_USB_EQ_RX250M, 3),
+	GATE_SGMII(CK_SGM0_CK0_EN, "sgm0_ck0_en", CK_TOP_USB_LN0_CK, 4),
+	GATE_SGMII(CK_SGM0_CDR_CK0_EN, "sgm0_cdr_ck0_en", CK_TOP_USB_CDR_CK, 5),
+};
+
+static int mt7981_sgmii0sys_probe(struct udevice *dev)
+{
+	return mtk_common_clk_gate_init(dev, &mt7981_topckgen_clk_tree,
+					sgmii0_cgs);
+}
+
+static const struct udevice_id mt7981_sgmii0sys_compat[] = {
+	{ .compatible = "mediatek,mt7981-sgmiisys_0", },
+	{}
+};
+
+U_BOOT_DRIVER(mtk_clk_sgmii0sys) = {
+	.name = "mt7981-clock-sgmii0sys",
+	.id = UCLASS_CLK,
+	.of_match = mt7981_sgmii0sys_compat,
+	.probe = mt7981_sgmii0sys_probe,
+	.priv_auto = sizeof(struct mtk_cg_priv),
+	.ops = &mtk_clk_gate_ops,
+};
+
+static const struct mtk_gate sgmii1_cgs[] = {
+	GATE_SGMII(CK_SGM1_TX_EN, "sgm1_tx_en", CK_TOP_USB_TX250M, 2),
+	GATE_SGMII(CK_SGM1_RX_EN, "sgm1_rx_en", CK_TOP_USB_EQ_RX250M, 3),
+	GATE_SGMII(CK_SGM1_CK1_EN, "sgm1_ck1_en", CK_TOP_USB_LN0_CK, 4),
+	GATE_SGMII(CK_SGM1_CDR_CK1_EN, "sgm1_cdr_ck1_en", CK_TOP_USB_CDR_CK, 5),
+};
+
+static int mt7981_sgmii1sys_probe(struct udevice *dev)
+{
+	return mtk_common_clk_gate_init(dev, &mt7981_topckgen_clk_tree,
+					sgmii1_cgs);
+}
+
+static const struct udevice_id mt7981_sgmii1sys_compat[] = {
+	{ .compatible = "mediatek,mt7981-sgmiisys_1", },
+	{}
+};
+
+U_BOOT_DRIVER(mtk_clk_sgmii1sys) = {
+	.name = "mt7981-clock-sgmii1sys",
+	.id = UCLASS_CLK,
+	.of_match = mt7981_sgmii1sys_compat,
+	.probe = mt7981_sgmii1sys_probe,
+	.priv_auto = sizeof(struct mtk_cg_priv),
+	.ops = &mtk_clk_gate_ops,
+};
+
 /* ethsys */
 static const struct mtk_gate_regs eth_cg_regs = {
 	.set_ofs = 0x30,
-- 
2.45.2

