Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA3FC25B79
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 21:35:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A228F883A0;
	Mon, 27 May 2024 23:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lY7SfMv4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0286487F6F; Mon, 27 May 2024 19:02:48 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2172787D1A
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 19:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liujianfeng1994@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f4a52b9589so8285765ad.3
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 10:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716829363; x=1717434163; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d0jQ3+EgWojL7gHPnzw+AElhayXz6a1tVScOba5C05U=;
 b=lY7SfMv44uJqKR+7L6x85UM4FuQV254kdku8kGm9+If5G2ZBstapth8ImVpjZhzOe8
 QmVVDXPcMfBEdhSWxG+fshR1B5jZr4tsesixrcSy7gNO3tCpdJ4F4o7ZJnDHHizkLD8a
 DmKIe0A8NRqZEmmhPPpRJ34MNfz3fDotAIZTu85XZkkgfhfyyEdoY4LMoK96v5KOYI3o
 83O43vDWKniBWDqIac19lIh1PDu1bNbFq3d1sj4cIIUDE6GDg6ajzbuhadZZOof0yLWH
 XA4AlAkcNLOE04XmTEfJm+i48QnqH+JPcnxyBSye4DFc8J41iu29F7D0BdT7XBreosW9
 +jNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716829363; x=1717434163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d0jQ3+EgWojL7gHPnzw+AElhayXz6a1tVScOba5C05U=;
 b=qQdCzG5atqyZcCto9dAtq5/fbEOsXGYE5vs2GQDPRwe2nVWBbH0j/Q6eEUjOVA9QKb
 qpRGSjT2suyCKvgk57TR6QePzs5drSL9uKCtclzPN8rT+veIx9AcyCGyKBMVGmIZTFfb
 sAtruwGP2yLaSiLlKkToy/YRQdHFt9jN7RXFkfwlW5OMxSiiV/G6OsdM7caKr68DLFsQ
 KgZXxIx4wVPe4y6OyrpEbdUbnTRp3X/3yUP1suJ9gI4OQo8OpIiuektTlK2NJVJU2ax2
 lwJ4zQj1cQw3vgrCNhVPTD0clx5BlkYoEnw3IIOi2N+Vhwp5udTPPM7oSeCJJSEUaV/A
 vSWw==
X-Gm-Message-State: AOJu0YyjBYzSPNJtRL6f0dHXv0Q4PIKAik+lCSl8BeJo0/C/NgH5kOdS
 IAomgmZqPkQghrTtN97NSLwsKF7No1E3aIEh/Y7H1OqT+UC4bTIPGxKwdQzt4gg=
X-Google-Smtp-Source: AGHT+IFzUe8EOaZHj6/hPvKnoMA8q8Q4thRpSB3Fxjg7fWLweHuRTzhAWiyinox2132WUPo54faHiA==
X-Received: by 2002:a17:902:d50c:b0:1f4:bb5c:b7bd with SMTP id
 d9443c01a7336-1f4bb5cb9c1mr12254965ad.61.1716829363074; 
 Mon, 27 May 2024 10:02:43 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c757845sm63462095ad.5.2024.05.27.10.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 10:02:42 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: u-boot@lists.denx.de
Cc: Diederik de Haas <didi.debian@cknow.org>, Heiko Stuebner <heiko@sntech.de>,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/7] arm64: dts: rockchip: Fix ordering of nodes on rk3588s
Date: Tue, 28 May 2024 01:02:09 +0800
Message-Id: <20240527170214.283988-3-liujianfeng1994@gmail.com>
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

From: Diederik de Haas <didi.debian@cknow.org>

Fix the ordering of the main nodes by sorting them alphabetically and
then the ones with a memory address sequentially by that address.

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
Link: https://lore.kernel.org/r/20240406172821.34173-1-didi.debian@cknow.org
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: cbb97fe18e299ece1c0074924c630de6a19b320f ]

(cherry picked from commit bbf7c16f2f1208b96349f6f6648b69cfaa1a482b)
Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

(no changes since v1)

 dts/upstream/src/arm64/rockchip/rk3588s.dtsi | 304 +++++++++----------
 1 file changed, 152 insertions(+), 152 deletions(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
index 89d40cff635..ac5bd630f15 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3588s.dtsi
@@ -347,6 +347,11 @@
 		};
 	};
 
+	display_subsystem: display-subsystem {
+		compatible = "rockchip,display-subsystem";
+		ports = <&vop_out>;
+	};
+
 	firmware {
 		optee: optee {
 			compatible = "linaro,optee-tz";
@@ -394,11 +399,6 @@
 		#clock-cells = <0>;
 	};
 
-	display_subsystem: display-subsystem {
-		compatible = "rockchip,display-subsystem";
-		ports = <&vop_out>;
-	};
-
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
@@ -436,6 +436,62 @@
 		};
 	};
 
+	gpu: gpu@fb000000 {
+		compatible = "rockchip,rk3588-mali", "arm,mali-valhall-csf";
+		reg = <0x0 0xfb000000 0x0 0x200000>;
+		#cooling-cells = <2>;
+		assigned-clocks = <&scmi_clk SCMI_CLK_GPU>;
+		assigned-clock-rates = <200000000>;
+		clocks = <&cru CLK_GPU>, <&cru CLK_GPU_COREGROUP>,
+			 <&cru CLK_GPU_STACKS>;
+		clock-names = "core", "coregroup", "stacks";
+		dynamic-power-coefficient = <2982>;
+		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "job", "mmu", "gpu";
+		operating-points-v2 = <&gpu_opp_table>;
+		power-domains = <&power RK3588_PD_GPU>;
+		status = "disabled";
+
+		gpu_opp_table: opp-table {
+			compatible = "operating-points-v2";
+
+			opp-300000000 {
+				opp-hz = /bits/ 64 <300000000>;
+				opp-microvolt = <675000 675000 850000>;
+			};
+			opp-400000000 {
+				opp-hz = /bits/ 64 <400000000>;
+				opp-microvolt = <675000 675000 850000>;
+			};
+			opp-500000000 {
+				opp-hz = /bits/ 64 <500000000>;
+				opp-microvolt = <675000 675000 850000>;
+			};
+			opp-600000000 {
+				opp-hz = /bits/ 64 <600000000>;
+				opp-microvolt = <675000 675000 850000>;
+			};
+			opp-700000000 {
+				opp-hz = /bits/ 64 <700000000>;
+				opp-microvolt = <700000 700000 850000>;
+			};
+			opp-800000000 {
+				opp-hz = /bits/ 64 <800000000>;
+				opp-microvolt = <750000 750000 850000>;
+			};
+			opp-900000000 {
+				opp-hz = /bits/ 64 <900000000>;
+				opp-microvolt = <800000 800000 850000>;
+			};
+			opp-1000000000 {
+				opp-hz = /bits/ 64 <1000000000>;
+				opp-microvolt = <850000 850000 850000>;
+			};
+		};
+	};
+
 	usb_host0_ehci: usb@fc800000 {
 		compatible = "rockchip,rk3588-ehci", "generic-ehci";
 		reg = <0x0 0xfc800000 0x0 0x40000>;
@@ -501,62 +557,6 @@
 		status = "disabled";
 	};
 
-	gpu: gpu@fb000000 {
-		compatible = "rockchip,rk3588-mali", "arm,mali-valhall-csf";
-		reg = <0x0 0xfb000000 0x0 0x200000>;
-		#cooling-cells = <2>;
-		assigned-clocks = <&scmi_clk SCMI_CLK_GPU>;
-		assigned-clock-rates = <200000000>;
-		clocks = <&cru CLK_GPU>, <&cru CLK_GPU_COREGROUP>,
-			 <&cru CLK_GPU_STACKS>;
-		clock-names = "core", "coregroup", "stacks";
-		dynamic-power-coefficient = <2982>;
-		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH 0>,
-			     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH 0>,
-			     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH 0>;
-		interrupt-names = "job", "mmu", "gpu";
-		operating-points-v2 = <&gpu_opp_table>;
-		power-domains = <&power RK3588_PD_GPU>;
-		status = "disabled";
-
-		gpu_opp_table: opp-table {
-			compatible = "operating-points-v2";
-
-			opp-300000000 {
-				opp-hz = /bits/ 64 <300000000>;
-				opp-microvolt = <675000 675000 850000>;
-			};
-			opp-400000000 {
-				opp-hz = /bits/ 64 <400000000>;
-				opp-microvolt = <675000 675000 850000>;
-			};
-			opp-500000000 {
-				opp-hz = /bits/ 64 <500000000>;
-				opp-microvolt = <675000 675000 850000>;
-			};
-			opp-600000000 {
-				opp-hz = /bits/ 64 <600000000>;
-				opp-microvolt = <675000 675000 850000>;
-			};
-			opp-700000000 {
-				opp-hz = /bits/ 64 <700000000>;
-				opp-microvolt = <700000 700000 850000>;
-			};
-			opp-800000000 {
-				opp-hz = /bits/ 64 <800000000>;
-				opp-microvolt = <750000 750000 850000>;
-			};
-			opp-900000000 {
-				opp-hz = /bits/ 64 <900000000>;
-				opp-microvolt = <800000 800000 850000>;
-			};
-			opp-1000000000 {
-				opp-hz = /bits/ 64 <1000000000>;
-				opp-microvolt = <850000 850000 850000>;
-			};
-		};
-	};
-
 	pmu1grf: syscon@fd58a000 {
 		compatible = "rockchip,rk3588-pmugrf", "syscon", "simple-mfd";
 		reg = <0x0 0xfd58a000 0x0 0x10000>;
@@ -702,74 +702,6 @@
 		status = "disabled";
 	};
 
-	vop: vop@fdd90000 {
-		compatible = "rockchip,rk3588-vop";
-		reg = <0x0 0xfdd90000 0x0 0x4200>, <0x0 0xfdd95000 0x0 0x1000>;
-		reg-names = "vop", "gamma-lut";
-		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH 0>;
-		clocks = <&cru ACLK_VOP>,
-			 <&cru HCLK_VOP>,
-			 <&cru DCLK_VOP0>,
-			 <&cru DCLK_VOP1>,
-			 <&cru DCLK_VOP2>,
-			 <&cru DCLK_VOP3>,
-			 <&cru PCLK_VOP_ROOT>;
-		clock-names = "aclk",
-			      "hclk",
-			      "dclk_vp0",
-			      "dclk_vp1",
-			      "dclk_vp2",
-			      "dclk_vp3",
-			      "pclk_vop";
-		iommus = <&vop_mmu>;
-		power-domains = <&power RK3588_PD_VOP>;
-		rockchip,grf = <&sys_grf>;
-		rockchip,vop-grf = <&vop_grf>;
-		rockchip,vo1-grf = <&vo1_grf>;
-		rockchip,pmu = <&pmu>;
-		status = "disabled";
-
-		vop_out: ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			vp0: port@0 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0>;
-			};
-
-			vp1: port@1 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <1>;
-			};
-
-			vp2: port@2 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <2>;
-			};
-
-			vp3: port@3 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <3>;
-			};
-		};
-	};
-
-	vop_mmu: iommu@fdd97e00 {
-		compatible = "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
-		reg = <0x0 0xfdd97e00 0x0 0x100>, <0x0 0xfdd97f00 0x0 0x100>;
-		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH 0>;
-		clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>;
-		clock-names = "aclk", "iface";
-		#iommu-cells = <0>;
-		power-domains = <&power RK3588_PD_VOP>;
-		status = "disabled";
-	};
-
 	uart0: serial@fd890000 {
 		compatible = "rockchip,rk3588-uart", "snps,dw-apb-uart";
 		reg = <0x0 0xfd890000 0x0 0x100>;
@@ -1140,6 +1072,87 @@
 		};
 	};
 
+	av1d: video-codec@fdc70000 {
+		compatible = "rockchip,rk3588-av1-vpu";
+		reg = <0x0 0xfdc70000 0x0 0x800>;
+		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "vdpu";
+		assigned-clocks = <&cru ACLK_AV1>, <&cru PCLK_AV1>;
+		assigned-clock-rates = <400000000>, <400000000>;
+		clocks = <&cru ACLK_AV1>, <&cru PCLK_AV1>;
+		clock-names = "aclk", "hclk";
+		power-domains = <&power RK3588_PD_AV1>;
+		resets = <&cru SRST_A_AV1>, <&cru SRST_P_AV1>, <&cru SRST_A_AV1_BIU>, <&cru SRST_P_AV1_BIU>;
+	};
+
+	vop: vop@fdd90000 {
+		compatible = "rockchip,rk3588-vop";
+		reg = <0x0 0xfdd90000 0x0 0x4200>, <0x0 0xfdd95000 0x0 0x1000>;
+		reg-names = "vop", "gamma-lut";
+		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru ACLK_VOP>,
+			 <&cru HCLK_VOP>,
+			 <&cru DCLK_VOP0>,
+			 <&cru DCLK_VOP1>,
+			 <&cru DCLK_VOP2>,
+			 <&cru DCLK_VOP3>,
+			 <&cru PCLK_VOP_ROOT>;
+		clock-names = "aclk",
+			      "hclk",
+			      "dclk_vp0",
+			      "dclk_vp1",
+			      "dclk_vp2",
+			      "dclk_vp3",
+			      "pclk_vop";
+		iommus = <&vop_mmu>;
+		power-domains = <&power RK3588_PD_VOP>;
+		rockchip,grf = <&sys_grf>;
+		rockchip,vop-grf = <&vop_grf>;
+		rockchip,vo1-grf = <&vo1_grf>;
+		rockchip,pmu = <&pmu>;
+		status = "disabled";
+
+		vop_out: ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			vp0: port@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;
+			};
+
+			vp1: port@1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <1>;
+			};
+
+			vp2: port@2 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <2>;
+			};
+
+			vp3: port@3 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <3>;
+			};
+		};
+	};
+
+	vop_mmu: iommu@fdd97e00 {
+		compatible = "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
+		reg = <0x0 0xfdd97e00 0x0 0x100>, <0x0 0xfdd97f00 0x0 0x100>;
+		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>;
+		clock-names = "aclk", "iface";
+		#iommu-cells = <0>;
+		power-domains = <&power RK3588_PD_VOP>;
+		status = "disabled";
+	};
+
 	i2s4_8ch: i2s@fddc0000 {
 		compatible = "rockchip,rk3588-i2s-tdm";
 		reg = <0x0 0xfddc0000 0x0 0x1000>;
@@ -1431,6 +1444,16 @@
 		reg = <0x0 0xfdf82200 0x0 0x20>;
 	};
 
+	dfi: dfi@fe060000 {
+		reg = <0x00 0xfe060000 0x00 0x10000>;
+		compatible = "rockchip,rk3588-dfi";
+		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH 0>;
+		rockchip,pmu = <&pmu1grf>;
+	};
+
 	pcie2x1l1: pcie@fe180000 {
 		compatible = "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
 		bus-range = <0x30 0x3f>;
@@ -1533,16 +1556,6 @@
 		};
 	};
 
-	dfi: dfi@fe060000 {
-		reg = <0x00 0xfe060000 0x00 0x10000>;
-		compatible = "rockchip,rk3588-dfi";
-		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH 0>,
-			     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH 0>,
-			     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH 0>,
-			     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH 0>;
-		rockchip,pmu = <&pmu1grf>;
-	};
-
 	gmac1: ethernet@fe1c0000 {
 		compatible = "rockchip,rk3588-gmac", "snps,dwmac-4.20a";
 		reg = <0x0 0xfe1c0000 0x0 0x10000>;
@@ -2543,19 +2556,6 @@
 			#interrupt-cells = <2>;
 		};
 	};
-
-	av1d: video-codec@fdc70000 {
-		compatible = "rockchip,rk3588-av1-vpu";
-		reg = <0x0 0xfdc70000 0x0 0x800>;
-		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH 0>;
-		interrupt-names = "vdpu";
-		assigned-clocks = <&cru ACLK_AV1>, <&cru PCLK_AV1>;
-		assigned-clock-rates = <400000000>, <400000000>;
-		clocks = <&cru ACLK_AV1>, <&cru PCLK_AV1>;
-		clock-names = "aclk", "hclk";
-		power-domains = <&power RK3588_PD_AV1>;
-		resets = <&cru SRST_A_AV1>, <&cru SRST_P_AV1>, <&cru SRST_A_AV1_BIU>, <&cru SRST_P_AV1_BIU>;
-	};
 };
 
 #include "rk3588s-pinctrl.dtsi"
-- 
2.34.1

