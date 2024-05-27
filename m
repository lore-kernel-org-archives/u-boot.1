Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A95DC25B79
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 21:35:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C38E6883C2;
	Mon, 27 May 2024 23:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Knr0O1zr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D961B87EAC; Mon, 27 May 2024 19:03:02 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6394887D1A
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 19:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liujianfeng1994@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f47db642c2so12149485ad.2
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 10:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716829379; x=1717434179; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c4vJzACfbiJZHdQP7H9vPKPNXAzfWW/kvykuYXcWDi4=;
 b=Knr0O1zr0LV8968mkQgdagas0F0uW07vgYlUxRQKXr0c3HCNZ2ErpHh28WxTD/fB1I
 feEDczMl+uJDjJr8cYI0JfBD96lwt5z1cv7xznorhtQcGAKfMSbVVulRoeRq1EfioKXf
 QHT31cQ10k+yfaCDj0sVViBpYLdW53x0/xkv+J/OFSgRGroz1vNZg/c8EzFTqabX2j4w
 aIr79vjaLW8fCmfgVIiEb/QeS6ROkzUG7V4W9REWN/X5sKS41doFU+4evN3bCzTneagb
 luqqIUD/FDr1HEMo7uJ3IvCi3NdP01WVUigZWfDp1thT7BFVvCBlpSR7ueAxg12p8ZDE
 dpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716829379; x=1717434179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c4vJzACfbiJZHdQP7H9vPKPNXAzfWW/kvykuYXcWDi4=;
 b=uxEL+NLsiuEixaHSRiOYg0Bwt3pb9/2b3SLrHHLi9OQ8skEX7tf0ILdz6tyXwBZvxW
 ANZMh0mtemJw/jIZSl0L7uMZ+aAcgWyOJORkSCHcCVBQdZbKCwGj5vfLTD4cTlV8aIzr
 msk0yJSs9GQ3+Nz53lz8yxbNCZ4+wMVn9K2iO/fJU5/mIV+YZzQTOxqaLniMykM5ZqHy
 s2rxjs3+R+ojy0mJVMhYNLMpm6TzbniJI5s2r6N49Uvi9DXwRa8mZJ/ZcSOnsbfU8fmX
 Vewwg5tBEBbW5AQzPEtwsw0IrUbujl0tIxvjXaifbli2xCAVKJwCW9X3Loz3TC9iPmLc
 +zuw==
X-Gm-Message-State: AOJu0Ywf1YHhFKZJRTJG5YGEwlV9wjsHT+EQzkyXRj1wQ/Xd+R0tkT/d
 StzVxSEE853+7JxBIbcunvSFUZw3QBYO6eUyMQJbtxf1FYnzM498faVaKIs4mrI=
X-Google-Smtp-Source: AGHT+IF1E2/bf1DLyNwDWgOAWaxIdo15V3MnJekh1avTVoVLKU1z84AAs64NA4VtVjdcrFAGkLn+hw==
X-Received: by 2002:a17:902:c408:b0:1f3:1ea5:7e0f with SMTP id
 d9443c01a7336-1f4486e5e80mr118655855ad.3.1716829378392; 
 Mon, 27 May 2024 10:02:58 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c757845sm63462095ad.5.2024.05.27.10.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 10:02:57 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: u-boot@lists.denx.de
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, Jianfeng Liu <liujianfeng1994@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 5/7] arm64: dts: rockchip: add USB3 DRD controllers on
 rk3588
Date: Tue, 28 May 2024 01:02:12 +0800
Message-Id: <20240527170214.283988-6-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527170214.283988-1-liujianfeng1994@gmail.com>
References: <20240527170214.283988-1-liujianfeng1994@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 27 May 2024 23:34:36 +0200
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

Add both USB3 dual-role controllers to the RK3588 devicetree.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20240408225109.128953-8-sebastian.reichel@collabora.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 33f393a2a990e16f56931ca708295f31d2b44415 ]

(cherry picked from commit c7ed588e14f7dd04a92fb55f12680f94c7b14edf)
Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

(no changes since v1)

 dts/upstream/src/arm64/rockchip/rk3588.dtsi  | 20 ++++++++++++++++++
 dts/upstream/src/arm64/rockchip/rk3588s.dtsi | 22 ++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3588.dtsi b/dts/upstream/src/arm64/rockchip/rk3588.dtsi
index 4fdd047c9eb..5984016b5f9 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3588.dtsi
@@ -7,6 +7,26 @@
 #include "rk3588-pinctrl.dtsi"
 
 / {
+	usb_host1_xhci: usb@fc400000 {
+		compatible = "rockchip,rk3588-dwc3", "snps,dwc3";
+		reg = <0x0 0xfc400000 0x0 0x400000>;
+		interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru REF_CLK_USB3OTG1>, <&cru SUSPEND_CLK_USB3OTG1>,
+			 <&cru ACLK_USB3OTG1>;
+		clock-names = "ref_clk", "suspend_clk", "bus_clk";
+		dr_mode = "otg";
+		phys = <&u2phy1_otg>, <&usbdp_phy1 PHY_TYPE_USB3>;
+		phy-names = "usb2-phy", "usb3-phy";
+		phy_type = "utmi_wide";
+		power-domains = <&power RK3588_PD_USB>;
+		resets = <&cru SRST_A_USB3OTG1>;
+		snps,dis_enblslpm_quirk;
+		snps,dis-u2-freeclk-exists-quirk;
+		snps,dis-del-phy-power-chg-quirk;
+		snps,dis-tx-ipgap-linecheck-quirk;
+		status = "disabled";
+	};
+
 	pcie30_phy_grf: syscon@fd5b8000 {
 		compatible = "rockchip,rk3588-pcie3-phy-grf", "syscon";
 		reg = <0x0 0xfd5b8000 0x0 0x10000>;
diff --git a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
index 8314a4ace31..94157cdfd5c 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
@@ -492,6 +492,28 @@
 		};
 	};
 
+	usb_host0_xhci: usb@fc000000 {
+		compatible = "rockchip,rk3588-dwc3", "snps,dwc3";
+		reg = <0x0 0xfc000000 0x0 0x400000>;
+		interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru REF_CLK_USB3OTG0>, <&cru SUSPEND_CLK_USB3OTG0>,
+			 <&cru ACLK_USB3OTG0>;
+		clock-names = "ref_clk", "suspend_clk", "bus_clk";
+		dr_mode = "otg";
+		phys = <&u2phy0_otg>, <&usbdp_phy0 PHY_TYPE_USB3>;
+		phy-names = "usb2-phy", "usb3-phy";
+		phy_type = "utmi_wide";
+		power-domains = <&power RK3588_PD_USB>;
+		resets = <&cru SRST_A_USB3OTG0>;
+		snps,dis_enblslpm_quirk;
+		snps,dis-u1-entry-quirk;
+		snps,dis-u2-entry-quirk;
+		snps,dis-u2-freeclk-exists-quirk;
+		snps,dis-del-phy-power-chg-quirk;
+		snps,dis-tx-ipgap-linecheck-quirk;
+		status = "disabled";
+	};
+
 	usb_host0_ehci: usb@fc800000 {
 		compatible = "rockchip,rk3588-ehci", "generic-ehci";
 		reg = <0x0 0xfc800000 0x0 0x40000>;
-- 
2.34.1

