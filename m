Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48212C27C43
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 22:22:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E5A7885EB;
	Wed, 29 May 2024 00:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lMoTizkz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6726884DB; Tue, 28 May 2024 19:07:29 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 592A7884B4
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 19:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liujianfeng1994@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f4a52b94c3so9681695ad.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716916045; x=1717520845; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nbDrhOn/cEibKzTEPwwqPd64dCCPLjjxtYfpdyfnyLE=;
 b=lMoTizkz4M2IHetl/4M1DCs6gsvoftnQ+9g+YBBIOh++lUE4/F7HZbrlzC1Q6FFBMs
 f8xb2ORUMzi0uLt47fKW8WygSpj4kZmTv5kVibwDj6YZacihAohtHbCYX0L0xkY+DpXa
 EM1+8ASAVjVgqdAJDy98J2YI/WQca6XbpM8zOjLLfMDZN5sEybLkx321f8/w48mkU8iP
 QBvmydy75SCo1FPaQUIcB0ZoAnOfSbypSh0a4P7LbcuFhzPjx/G4dg0bjIRPk4EueCJP
 bq+KgM6qdmNNEuk4S8dkbB2vhHspqhMwWyOzPIxKi5Ty6FZRuK+onjnMWAPCBDzSs4Oo
 scAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716916045; x=1717520845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nbDrhOn/cEibKzTEPwwqPd64dCCPLjjxtYfpdyfnyLE=;
 b=KUvpBDWNenoL7F9RFps6YGfxYWPkQ6P2HzXr95pDPv//pB+ccUJGwEosRJAYxCPxIy
 QTTD9NLcGN+jw4mZnMNowdAdaT6ECMUEeqsa8p8hNUeBJSnvwlSfWroAjQlTBat8Apgg
 0zjJCooabRFlWDRJcO3NQZjMJZhfsa6YyiUPbnp7JADFHy0AWMjRN2dtjzTx0Sba5zmr
 5E8jjR05VHxNsHRo5skmATGlqmV2SzFhgdf+C5yJ6SwNOKfmQ3V6DCmif6Qr1Ccu619P
 +U31bhCYcovJGm/k7pzD1YKyTTsB9pxS1Xb0VU4CaIEnUiRVnotL3k1dX07aRXby8LPg
 /OKg==
X-Gm-Message-State: AOJu0YyJP/spchvl95V3BIBrpqUZSdw7Sfy59WOsZUUW4Vxno4sK+vfP
 NrNuBOb5nWOaQUabH2CZOR4tfxZjdwLrPzGvi87KmmCzBCCAh9kf0nRLc8r7sUfKvg==
X-Google-Smtp-Source: AGHT+IG5o6UcorurtIl19IPfq8ChwBX0bT5ZGj/MUkR4yue1da9oopwqa8iaarSC7PYDYGZ9tftEhg==
X-Received: by 2002:a17:902:d48f:b0:1f4:bb25:b8c8 with SMTP id
 d9443c01a7336-1f4bb25be54mr43560395ad.27.1716916045483; 
 Tue, 28 May 2024 10:07:25 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f47efff203sm53037705ad.241.2024.05.28.10.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 10:07:25 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: u-boot@lists.denx.de
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joseph Chen <chenjh@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 09/10] rockchip: rk3588: Remove USB3 DRD nodes in
 u-boot.dtsi
Date: Wed, 29 May 2024 01:04:05 +0800
Message-Id: <20240528170406.353616-10-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528170406.353616-1-liujianfeng1994@gmail.com>
References: <20240528170406.353616-1-liujianfeng1994@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 May 2024 00:21:20 +0200
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

After we sync USB3 DRD nodes from v6.10-rc1, these obsolete nodes
can be removed.

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

(no changes since v1)

 arch/arm/dts/rk3588-u-boot.dtsi  | 74 ---------------------------
 arch/arm/dts/rk3588s-u-boot.dtsi | 85 --------------------------------
 2 files changed, 159 deletions(-)

diff --git a/arch/arm/dts/rk3588-u-boot.dtsi b/arch/arm/dts/rk3588-u-boot.dtsi
index 4623580c610..bfe6645c30e 100644
--- a/arch/arm/dts/rk3588-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-u-boot.dtsi
@@ -4,77 +4,3 @@
  */
 
 #include "rk3588s-u-boot.dtsi"
-
-/ {
-	usb_host1_xhci: usb@fc400000 {
-		compatible = "rockchip,rk3588-dwc3", "snps,dwc3";
-		reg = <0x0 0xfc400000 0x0 0x400000>;
-		interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH 0>;
-		clocks = <&cru REF_CLK_USB3OTG1>, <&cru SUSPEND_CLK_USB3OTG1>,
-			 <&cru ACLK_USB3OTG1>;
-		clock-names = "ref_clk", "suspend_clk", "bus_clk";
-		dr_mode = "otg";
-		phys = <&u2phy1_otg>, <&usbdp_phy1 PHY_TYPE_USB3>;
-		phy-names = "usb2-phy", "usb3-phy";
-		phy_type = "utmi_wide";
-		power-domains = <&power RK3588_PD_USB>;
-		resets = <&cru SRST_A_USB3OTG1>;
-		snps,dis_enblslpm_quirk;
-		snps,dis-u2-freeclk-exists-quirk;
-		snps,dis-del-phy-power-chg-quirk;
-		snps,dis-tx-ipgap-linecheck-quirk;
-		status = "disabled";
-	};
-
-	usbdpphy1_grf: syscon@fd5cc000 {
-		compatible = "rockchip,rk3588-usbdpphy-grf", "syscon";
-		reg = <0x0 0xfd5cc000 0x0 0x4000>;
-	};
-
-	usb2phy1_grf: syscon@fd5d4000 {
-		compatible = "rockchip,rk3588-usb2phy-grf", "syscon", "simple-mfd";
-		reg = <0x0 0xfd5d4000 0x0 0x4000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		u2phy1: usb2phy@4000 {
-			compatible = "rockchip,rk3588-usb2phy";
-			reg = <0x4000 0x10>;
-			#clock-cells = <0>;
-			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
-			clock-names = "phyclk";
-			clock-output-names = "usb480m_phy1";
-			interrupts = <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH 0>;
-			resets = <&cru SRST_OTGPHY_U3_1>, <&cru SRST_P_USB2PHY_U3_1_GRF0>;
-			reset-names = "phy", "apb";
-			status = "disabled";
-
-			u2phy1_otg: otg-port {
-				#phy-cells = <0>;
-				status = "disabled";
-			};
-		};
-	};
-
-	usbdp_phy1: phy@fed90000 {
-		compatible = "rockchip,rk3588-usbdp-phy";
-		reg = <0x0 0xfed90000 0x0 0x10000>;
-		#phy-cells = <1>;
-		clocks = <&cru CLK_USBDPPHY_MIPIDCPPHY_REF>,
-			 <&cru CLK_USBDP_PHY1_IMMORTAL>,
-			 <&cru PCLK_USBDPPHY1>,
-			 <&u2phy1>;
-		clock-names = "refclk", "immortal", "pclk", "utmi";
-		resets = <&cru SRST_USBDP_COMBO_PHY1_INIT>,
-			 <&cru SRST_USBDP_COMBO_PHY1_CMN>,
-			 <&cru SRST_USBDP_COMBO_PHY1_LANE>,
-			 <&cru SRST_USBDP_COMBO_PHY1_PCS>,
-			 <&cru SRST_P_USBDPPHY1>;
-		reset-names = "init", "cmn", "lane", "pcs_apb", "pma_apb";
-		rockchip,u2phy-grf = <&usb2phy1_grf>;
-		rockchip,usb-grf = <&usb_grf>;
-		rockchip,usbdpphy-grf = <&usbdpphy1_grf>;
-		rockchip,vo-grf = <&vo0_grf>;
-		status = "disabled";
-	};
-};
diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
index e9d38d5c83b..09d8b311cec 100644
--- a/arch/arm/dts/rk3588s-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-u-boot.dtsi
@@ -19,95 +19,10 @@
 		bootph-all;
 	};
 
-	usb_host0_xhci: usb@fc000000 {
-		compatible = "rockchip,rk3588-dwc3", "snps,dwc3";
-		reg = <0x0 0xfc000000 0x0 0x400000>;
-		interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH 0>;
-		clocks = <&cru REF_CLK_USB3OTG0>, <&cru SUSPEND_CLK_USB3OTG0>,
-			 <&cru ACLK_USB3OTG0>;
-		clock-names = "ref_clk", "suspend_clk", "bus_clk";
-		dr_mode = "otg";
-		phys = <&u2phy0_otg>, <&usbdp_phy0 PHY_TYPE_USB3>;
-		phy-names = "usb2-phy", "usb3-phy";
-		phy_type = "utmi_wide";
-		power-domains = <&power RK3588_PD_USB>;
-		resets = <&cru SRST_A_USB3OTG0>;
-		snps,dis_enblslpm_quirk;
-		snps,dis-u1-entry-quirk;
-		snps,dis-u2-entry-quirk;
-		snps,dis-u2-freeclk-exists-quirk;
-		snps,dis-del-phy-power-chg-quirk;
-		snps,dis-tx-ipgap-linecheck-quirk;
-		status = "disabled";
-	};
-
-	vo0_grf: syscon@fd5a6000 {
-		compatible = "rockchip,rk3588-vo-grf", "syscon";
-		reg = <0x0 0xfd5a6000 0x0 0x2000>;
-		clocks = <&cru PCLK_VO0GRF>;
-	};
-
-	usb_grf: syscon@fd5ac000 {
-		compatible = "rockchip,rk3588-usb-grf", "syscon";
-		reg = <0x0 0xfd5ac000 0x0 0x4000>;
-	};
-
-	usbdpphy0_grf: syscon@fd5c8000 {
-		compatible = "rockchip,rk3588-usbdpphy-grf", "syscon";
-		reg = <0x0 0xfd5c8000 0x0 0x4000>;
-	};
-
-	usb2phy0_grf: syscon@fd5d0000 {
-		compatible = "rockchip,rk3588-usb2phy-grf", "syscon", "simple-mfd";
-		reg = <0x0 0xfd5d0000 0x0 0x4000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		u2phy0: usb2phy@0 {
-			compatible = "rockchip,rk3588-usb2phy";
-			reg = <0x0 0x10>;
-			#clock-cells = <0>;
-			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
-			clock-names = "phyclk";
-			clock-output-names = "usb480m_phy0";
-			interrupts = <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH 0>;
-			resets = <&cru SRST_OTGPHY_U3_0>, <&cru SRST_P_USB2PHY_U3_0_GRF0>;
-			reset-names = "phy", "apb";
-			status = "disabled";
-
-			u2phy0_otg: otg-port {
-				#phy-cells = <0>;
-				status = "disabled";
-			};
-		};
-	};
-
 	rng: rng@fe378000 {
 		compatible = "rockchip,trngv1";
 		reg = <0x0 0xfe378000 0x0 0x200>;
 	};
-
-	usbdp_phy0: phy@fed80000 {
-		compatible = "rockchip,rk3588-usbdp-phy";
-		reg = <0x0 0xfed80000 0x0 0x10000>;
-		#phy-cells = <1>;
-		clocks = <&cru CLK_USBDPPHY_MIPIDCPPHY_REF>,
-			 <&cru CLK_USBDP_PHY0_IMMORTAL>,
-			 <&cru PCLK_USBDPPHY0>,
-			 <&u2phy0>;
-		clock-names = "refclk", "immortal", "pclk", "utmi";
-		resets = <&cru SRST_USBDP_COMBO_PHY0_INIT>,
-			 <&cru SRST_USBDP_COMBO_PHY0_CMN>,
-			 <&cru SRST_USBDP_COMBO_PHY0_LANE>,
-			 <&cru SRST_USBDP_COMBO_PHY0_PCS>,
-			 <&cru SRST_P_USBDPPHY0>;
-		reset-names = "init", "cmn", "lane", "pcs_apb", "pma_apb";
-		rockchip,u2phy-grf = <&usb2phy0_grf>;
-		rockchip,usb-grf = <&usb_grf>;
-		rockchip,usbdpphy-grf = <&usbdpphy0_grf>;
-		rockchip,vo-grf = <&vo0_grf>;
-		status = "disabled";
-	};
 };
 
 #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
-- 
2.34.1

