Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF40C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 22:22:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4AAF885B8;
	Wed, 29 May 2024 00:21:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hk+4kZgs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23A42884DB; Tue, 28 May 2024 19:05:39 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82AD38844E
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 19:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liujianfeng1994@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f44b594deeso8374775ad.2
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716915935; x=1717520735; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rdDGxKvX8y5aiwHVL+lBr4AUEiFgTcJO/jf3j+HTazc=;
 b=Hk+4kZgsWbcinrT6yJE3UwnXYtHXjjq3vl9CM2jRykNGFzI8xCFiL9eMPm6vjEtpf+
 GsCpXJL4lt8vqO2o7irMn7L8XlUxu7wHHpUiqm3eQZM7GzOQ43K7Gcle9ltxdre/T29l
 y66qMESNnusb1TjhMIsHwmMe+XD/v2D336Zg28ZhT4lrL6qHsNU3OF4Bm8oJbmnMuSKM
 eZQkzjlq/DpKnNjg7GgiZVSH22gozqeVsldsKR+GXxjeh1cCyeyxbDRCE51hAdGUPWmT
 ddyIriDNs4Pi8AjS5jgUsIVoT1Ed5vE9rZcJup72pyAdg5x0VUIkvEiw9AtkWMoNLoZ7
 uxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716915935; x=1717520735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rdDGxKvX8y5aiwHVL+lBr4AUEiFgTcJO/jf3j+HTazc=;
 b=S0XuXvIEJ+Q/nc80+lQxBA+9Cjln/oN2/Ef3eRy3q70FmnXKel5HcyeM7cSu604Bqx
 3iRVUjldYLVELjIprozy9WCTyz0FeOthL8bX1Ct04Coeqh/OXcu09hMqffeMGqT6qs7j
 +A5rVjz3uej/0jnKoEatw3jF+85C/02hZZb1eL68dO39IhRLnTyuYDuBrZ+qY4VbWNEr
 5ZRFv+3Lk9Y7Hv3NbsYw4kDAUFqqYcItorvz4UaubiQWk9EUqpOcw94jGNfYDFHHx9BW
 dkPOt3G0TtAYOuBHoEbW3XKNf8mFlMnJfv83N+VjtGyFa3wScvcaos2EHX8G7oLdNs+I
 LVxA==
X-Gm-Message-State: AOJu0Yz2Xi9M+XoMHmwXG+OxIs50R30pq9rXd42IwZplnE0A91SdgIXk
 Pk/iA4+boPB+ULmSPsgKu7sqNXAxgxzoaXrFbC23mpKxtyEvOrVIO5mVfGlkvhRK4w==
X-Google-Smtp-Source: AGHT+IFOJEh4lp96LaW78LI4X2WnW1GU+QR5hBgNy4mBMCqGsj1Ht/sLI6cc94Pjv2960XrgN+Nu7Q==
X-Received: by 2002:a17:903:246:b0:1ea:5ac0:ce46 with SMTP id
 d9443c01a7336-1f4498ef90bmr131804595ad.66.1716915934574; 
 Tue, 28 May 2024 10:05:34 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f47efff203sm53037705ad.241.2024.05.28.10.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 10:05:34 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: u-boot@lists.denx.de
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, Jianfeng Liu <liujianfeng1994@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Kever Yang <kever.yang@rock-chips.com>, Niklas Cassel <cassel@kernel.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 05/10] arm64: dts: rockchip: add USBDP phys on rk3588
Date: Wed, 29 May 2024 01:04:01 +0800
Message-Id: <20240528170406.353616-6-liujianfeng1994@gmail.com>
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

From: Sebastian Reichel <sebastian.reichel@collabora.com>

Add both USB3-DisplayPort PHYs to RK3588 SoC DT.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20240408225109.128953-7-sebastian.reichel@collabora.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: e18e5e8188f2671abf63abe7db5f21555705130f ]

(cherry picked from commit 5110caca9865718616cf7093ed4a9a1bc54780db)
Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

(no changes since v1)

 dts/upstream/src/arm64/rockchip/rk3588.dtsi  | 52 ++++++++++++++++
 dts/upstream/src/arm64/rockchip/rk3588s.dtsi | 63 ++++++++++++++++++++
 2 files changed, 115 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3588.dtsi b/dts/upstream/src/arm64/rockchip/rk3588.dtsi
index 5519c1430cb..4fdd047c9eb 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3588.dtsi
@@ -17,6 +17,36 @@
 		reg = <0x0 0xfd5c0000 0x0 0x100>;
 	};
 
+	usbdpphy1_grf: syscon@fd5cc000 {
+		compatible = "rockchip,rk3588-usbdpphy-grf", "syscon";
+		reg = <0x0 0xfd5cc000 0x0 0x4000>;
+	};
+
+	usb2phy1_grf: syscon@fd5d4000 {
+		compatible = "rockchip,rk3588-usb2phy-grf", "syscon", "simple-mfd";
+		reg = <0x0 0xfd5d4000 0x0 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		u2phy1: usb2phy@4000 {
+			compatible = "rockchip,rk3588-usb2phy";
+			reg = <0x4000 0x10>;
+			#clock-cells = <0>;
+			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
+			clock-names = "phyclk";
+			clock-output-names = "usb480m_phy1";
+			interrupts = <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH 0>;
+			resets = <&cru SRST_OTGPHY_U3_1>, <&cru SRST_P_USB2PHY_U3_1_GRF0>;
+			reset-names = "phy", "apb";
+			status = "disabled";
+
+			u2phy1_otg: otg-port {
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+		};
+	};
+
 	i2s8_8ch: i2s@fddc8000 {
 		compatible = "rockchip,rk3588-i2s-tdm";
 		reg = <0x0 0xfddc8000 0x0 0x1000>;
@@ -310,6 +340,28 @@
 		};
 	};
 
+	usbdp_phy1: phy@fed90000 {
+		compatible = "rockchip,rk3588-usbdp-phy";
+		reg = <0x0 0xfed90000 0x0 0x10000>;
+		#phy-cells = <1>;
+		clocks = <&cru CLK_USBDPPHY_MIPIDCPPHY_REF>,
+			 <&cru CLK_USBDP_PHY1_IMMORTAL>,
+			 <&cru PCLK_USBDPPHY1>,
+			 <&u2phy1>;
+		clock-names = "refclk", "immortal", "pclk", "utmi";
+		resets = <&cru SRST_USBDP_COMBO_PHY1_INIT>,
+			 <&cru SRST_USBDP_COMBO_PHY1_CMN>,
+			 <&cru SRST_USBDP_COMBO_PHY1_LANE>,
+			 <&cru SRST_USBDP_COMBO_PHY1_PCS>,
+			 <&cru SRST_P_USBDPPHY1>;
+		reset-names = "init", "cmn", "lane", "pcs_apb", "pma_apb";
+		rockchip,u2phy-grf = <&usb2phy1_grf>;
+		rockchip,usb-grf = <&usb_grf>;
+		rockchip,usbdpphy-grf = <&usbdpphy1_grf>;
+		rockchip,vo-grf = <&vo0_grf>;
+		status = "disabled";
+	};
+
 	combphy1_ps: phy@fee10000 {
 		compatible = "rockchip,rk3588-naneng-combphy";
 		reg = <0x0 0xfee10000 0x0 0x100>;
diff --git a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
index 58d12969b7e..9063c0bb0f0 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
@@ -572,12 +572,23 @@
 		reg = <0x0 0xfd5a4000 0x0 0x2000>;
 	};
 
+	vo0_grf: syscon@fd5a6000 {
+		compatible = "rockchip,rk3588-vo-grf", "syscon";
+		reg = <0x0 0xfd5a6000 0x0 0x2000>;
+		clocks = <&cru PCLK_VO0GRF>;
+	};
+
 	vo1_grf: syscon@fd5a8000 {
 		compatible = "rockchip,rk3588-vo-grf", "syscon";
 		reg = <0x0 0xfd5a8000 0x0 0x100>;
 		clocks = <&cru PCLK_VO1GRF>;
 	};
 
+	usb_grf: syscon@fd5ac000 {
+		compatible = "rockchip,rk3588-usb-grf", "syscon";
+		reg = <0x0 0xfd5ac000 0x0 0x4000>;
+	};
+
 	php_grf: syscon@fd5b0000 {
 		compatible = "rockchip,rk3588-php-grf", "syscon";
 		reg = <0x0 0xfd5b0000 0x0 0x1000>;
@@ -593,6 +604,36 @@
 		reg = <0x0 0xfd5c4000 0x0 0x100>;
 	};
 
+	usbdpphy0_grf: syscon@fd5c8000 {
+		compatible = "rockchip,rk3588-usbdpphy-grf", "syscon";
+		reg = <0x0 0xfd5c8000 0x0 0x4000>;
+	};
+
+	usb2phy0_grf: syscon@fd5d0000 {
+		compatible = "rockchip,rk3588-usb2phy-grf", "syscon", "simple-mfd";
+		reg = <0x0 0xfd5d0000 0x0 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		u2phy0: usb2phy@0 {
+			compatible = "rockchip,rk3588-usb2phy";
+			reg = <0x0 0x10>;
+			#clock-cells = <0>;
+			clocks = <&cru CLK_USB2PHY_HDPTXRXPHY_REF>;
+			clock-names = "phyclk";
+			clock-output-names = "usb480m_phy0";
+			interrupts = <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH 0>;
+			resets = <&cru SRST_OTGPHY_U3_0>, <&cru SRST_P_USB2PHY_U3_0_GRF0>;
+			reset-names = "phy", "apb";
+			status = "disabled";
+
+			u2phy0_otg: otg-port {
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+		};
+	};
+
 	usb2phy2_grf: syscon@fd5d8000 {
 		compatible = "rockchip,rk3588-usb2phy-grf", "syscon", "simple-mfd";
 		reg = <0x0 0xfd5d8000 0x0 0x4000>;
@@ -2449,6 +2490,28 @@
 		status = "disabled";
 	};
 
+	usbdp_phy0: phy@fed80000 {
+		compatible = "rockchip,rk3588-usbdp-phy";
+		reg = <0x0 0xfed80000 0x0 0x10000>;
+		#phy-cells = <1>;
+		clocks = <&cru CLK_USBDPPHY_MIPIDCPPHY_REF>,
+			 <&cru CLK_USBDP_PHY0_IMMORTAL>,
+			 <&cru PCLK_USBDPPHY0>,
+			 <&u2phy0>;
+		clock-names = "refclk", "immortal", "pclk", "utmi";
+		resets = <&cru SRST_USBDP_COMBO_PHY0_INIT>,
+			 <&cru SRST_USBDP_COMBO_PHY0_CMN>,
+			 <&cru SRST_USBDP_COMBO_PHY0_LANE>,
+			 <&cru SRST_USBDP_COMBO_PHY0_PCS>,
+			 <&cru SRST_P_USBDPPHY0>;
+		reset-names = "init", "cmn", "lane", "pcs_apb", "pma_apb";
+		rockchip,u2phy-grf = <&usb2phy0_grf>;
+		rockchip,usb-grf = <&usb_grf>;
+		rockchip,usbdpphy-grf = <&usbdpphy0_grf>;
+		rockchip,vo-grf = <&vo0_grf>;
+		status = "disabled";
+	};
+
 	combphy0_ps: phy@fee00000 {
 		compatible = "rockchip,rk3588-naneng-combphy";
 		reg = <0x0 0xfee00000 0x0 0x100>;
-- 
2.34.1

