Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90825C55ABA
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 10:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28CA980C86;
	Tue,  4 Aug 2026 10:05:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jv9WclHvuZPb; Tue,  4 Aug 2026 10:05:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3272180C7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785837925;
	bh=wSceQqmktLFxfus3bD+ZJkNG1EekJlbcV8xGoQqDjyw=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZJThFdTrdFKLc8wYY9yxG1FPzZeYWTAZanzmrzmY138sGX2cOWJH+dWhGQHs+Ay+G
	 uMiWYGQ5/cwhFWic0+3jqL5TuZ6CPwNAdetmyPBggGLNEg5nn6bVc/qETUfHLOVEqo
	 3hGV8lYkRaYZUMg7HtRDONnVB0ajtG72wuL/ee5j0KC6sz8rJiH2jX7VUxpRIJLg8F
	 1TT60wNFIwQlG4z1ucwst2JYAAZDzSylx8U10l6o4UMXICbpj6xGe7jkDgWVNPqFTI
	 Vs+bueu/qfAVtgoRu73lZ4VGs63QHdqdD2q8zC+EWxm7VY9FtD8+7OqVvaPZw6pzdw
	 q/aSQK7DPllqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3272180C7C;
	Tue,  4 Aug 2026 10:05:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CF2526C
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:05:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 031E660714
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:05:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cFfHy6gR_X23 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 10:05:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B21296062B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B21296062B
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B21296062B
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:05:19 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47f59f25ec4so1591916f8f.2
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 03:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785837917; x=1786442717;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wSceQqmktLFxfus3bD+ZJkNG1EekJlbcV8xGoQqDjyw=;
 b=JYRapjoHbvc/xOJNksYfHYzyFGotFiaZPM5m83pgdszH7H3+oLyBo4IAaj/Fidk4z8
 fSY01kO0xr0X70m6/U5VpJK1NejaIXB4M7akLtSYvYgH0jHbNCP3CO37UHfh7/WKia/c
 d8ueaOmvMraVcnTC2kvqeqDtYKhyapYCFPbGeaUSZNQrZlZ87fU1Wd+CglSbzrOw706P
 X5nrpFjTw+8wemPfEc04Z5ja3cz4TH76yIONfhR08h8vm/ByaAK6U5Cql3QsjMarvNe2
 5z1WPV4KUFuTjhSLK6EXqrLdY53O0VsZ0+MiJ5N+0kzKiQKFGl9LLGzZiJBBMg6uLEQa
 +eOQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpsbn7sbxNOEgom3JJVr6BJ8uTHODKcPpL2GI8jQcQC9QzfIrW6Qj8rPUyd0+jTwzaiuD1OZXQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx8yMlWjPndCWO0iO5tb5RK36Tr1jju+zw9RstSPlKdijCrS22o
 xDoIHWJE+VNhxTIDpn/EZA5wKspeCeAWNUgNZXBzQMKxWO7peImqj1UcoT0FtfgqmbAK4y50KLa
 UlnP/cLI=
X-Gm-Gg: AR+sD12rVz2egsVIsf35ta7ASHkMCWt+G8QYAwGKAlOFiXzwRVKXTXhbPu3zFOrnT2U
 MNGuP4eHlXvCN2xq3RpNV5TSM0o8RJZ1TgGfW4qav0ObRYZtmkGDNiyspEpodsSQuT3YzIgjcSi
 Bz0ka2LAEfg2EzwY9VGABRsZmlhZfBCvNu0H9P8lf4rQYMU0FeuS23g8vjBn0k6zg83kF+kSUJX
 u8y8em7/tc+99S9gOQ/SW0FmIchRG0mGinaa8GoEKEisYCmNVLqRkvx+tUUvyt/kvp0RdQg2mj8
 PlOZOrQoGcX47O4u2tSKJ9QTOPmBeANHiY/xKgAx7NQ51eIHEbSiAFE+pbGKYfAGbmnmeKR+Chr
 F6/TpCjY+4H+faasi69cmnEzSa24YE9hiOWfOvDyWLSKv//sGo42Nb7Qv60IxYsBcCkEdc34jUT
 BFXVOhXceSKUhtwgnFzBvN2ibEpTgDr7scQktQDCksbhVYPTHXbRt+xhYYbjcwmj/SNmjX7MvhB
 FSCYwGqYro0Zj7Lq7m9Pty9XxXRh52ZleA2Ih48R0akuw+n3r9uamp6V4q4ZkD46NT1Agz+plNU
 Zg1+Tu3UMy4=
X-Received: by 2002:a05:6000:4614:b0:478:19e7:22a2 with SMTP id
 ffacd0b85a97d-47fd72c3639mr35763921f8f.25.1785837916874; 
 Tue, 04 Aug 2026 03:05:16 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.pool212171.interbusiness.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd456a5a4sm42189968f8f.20.2026.08.04.03.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 03:05:16 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Tue, 04 Aug 2026 12:05:10 +0200
Subject: [PATCH v5] usb: mtu3: support the upstream devicetree binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-ccaione-upstream-mtu3-spl-gadget-v5-1-5c3b6ec44eb5@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XPQW6DMBAF0KtEXncqe2ygZNV7VFmMzUBchYBsg
 xJF3L0m3aAqC7r80tf7Mw8ROXiO4nh4iMCzj3645lC8HYQ707Vj8E3OAiWWslIVOEe5wjCNMQW
 mHvo0aYjjBTpqOk5ApBtdO2pkSSIzY+DW354TX6ffHCf7zS6t7to4+5iGcH/eMKu194+5WYGCo
 iLN2EhCKz8t3S/eBn53Qy/WxRm35scOE7NZtWX+wpRYFPULU29MlDtMnc1aubY1xqoS8YVptib
 uMA1IqCtVt8axI7Z/zGVZfgAzDL9u4QEAAA==
X-Change-ID: 20260717-ccaione-upstream-mtu3-spl-gadget-aa3d39cad06a
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785837917; x=1786442717;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wSceQqmktLFxfus3bD+ZJkNG1EekJlbcV8xGoQqDjyw=;
 b=C8QqZmyjiVlzHV9tKtAWvvSrvsEgFlWiIU+lDTQnNORwQhMDQV2gc8bmSX3LLxj/nz
 dTJ3XQ/cDICYTSQYZIABSUWHufVeCvsV4ZuPjfMQyiq9qKOwIK/hb3K0qbBIVRWsXyYn
 2d3PpborapoLki3AK5trVzRCdBgbwqb9+4+8xnDsKfwDFosc+e8AnVf3DtqrPUsU5r57
 55bydmsUBKNOJs7Atw1tHnwbsHgSzkkEc3QrP8WUlcUxpiTlO/nqjW13hUkt2/8hg3LF
 aJtLVLomgkaKYVfyLAsOoJEpJtKKmLAW+gcy4+jpWygHkoyi3QlQNkODrA6Zf+iHpyfu
 7U7A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=C8QqZmyj
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The MTU3 glue driver expects a synthetic mediatek,ssusb child that
combines the device and xHCI register windows. Upstream devicetrees
instead put the device resources on the controller node and describe the
xHCI window with a standard child node, so U-Boot cannot use an upstream
topology.

Switch to the upstream layout. The controller owns the shared resources
and the device MAC, with the device register offsets relative to it as in
Linux. The gadget role binds as a node-less internal device, while the
host role binds to an enabled xHCI child and uses its own clocks,
supplies and register window. dr_mode selects the role and defaults to
otg, and the Kconfig choice constrains which role the build provides.
The legacy child layout is rejected explicitly so its combined register
window cannot be mistaken for the device MAC.

Convert the in-tree MT8183 and MT8512 devicetrees in the same commit so
neither platform is left without USB. MT8512 stays peripheral-only
because its xHCI host interrupt is not documented and the
mediatek,mtk-xhci binding requires it.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Changes in v5:
- Use separate device-MAC and xHCI register resources
- Bind the gadget as an internal device without reusing the controller node
- Bind host mode to an enabled standard xHCI child and consume its resources
- Honor dr_mode, including its default of otg
- Reject the legacy combined-register child layout explicitly
- Enable address translation for an SPL host build
- Keep MT8512 peripheral-only until its host clock and interrupt are known
- Convert the in-tree devicetrees and update the binding documentation
- Keep the driver and devicetree conversion in one bisectable patch
- Link to v4: https://patch.msgid.link/20260722-ccaione-upstream-mtu3-spl-gadget-v4-0-9719f4cecaeb@baylibre.com

Changes in v4:
- Describe mediatek,ssusb as a legacy U-Boot-only binding
- Fix the MAC resource error and remove redundant ofnode initialization
- Convert the MT8183 devicetree to the upstream MTU3 binding
- Link to v3: https://patch.msgid.link/20260720-ccaione-upstream-mtu3-spl-gadget-v3-1-91cff44b1622@baylibre.com

Changes in v3:
- Remove the temporary platform data and derive the binding during probe
- Use dev_read_addr_name() for the MAC resource
- Link to v2: https://patch.msgid.link/20260718-ccaione-upstream-mtu3-spl-gadget-v2-1-7f69ca462559@baylibre.com

Changes in v2:
- Removed typecast horror
- Added platform storage to pass around legacy flags and device
- Link to v1: https://patch.msgid.link/20260717-ccaione-upstream-mtu3-spl-gadget-v1-1-57a3e2d0a2b0@baylibre.com
---
 arch/arm/dts/mt8183-pumpkin.dts                |   4 -
 arch/arm/dts/mt8183.dtsi                       |  17 +-
 arch/arm/dts/mt8512-bm1-emmc.dts               |   6 +-
 arch/arm/dts/mt8512.dtsi                       |  19 +--
 doc/device-tree-bindings/usb/mediatek,mtu3.txt |  93 ++++------
 drivers/usb/mtu3/Kconfig                       |   1 +
 drivers/usb/mtu3/mtu3.h                        |  12 +-
 drivers/usb/mtu3/mtu3_core.c                   |   4 +-
 drivers/usb/mtu3/mtu3_host.c                   |  11 +-
 drivers/usb/mtu3/mtu3_hw_regs.h                |  11 +-
 drivers/usb/mtu3/mtu3_plat.c                   | 227 ++++++++++++++++++-------
 11 files changed, 222 insertions(+), 183 deletions(-)

diff --git a/arch/arm/dts/mt8183-pumpkin.dts b/arch/arm/dts/mt8183-pumpkin.dts
index 470a7693997..623561b6a63 100644
--- a/arch/arm/dts/mt8183-pumpkin.dts
+++ b/arch/arm/dts/mt8183-pumpkin.dts
@@ -88,10 +88,6 @@
 };
 
 &usb {
-	status = "okay";
-};
-
-&ssusb {
 	mediatek,force-vbus;
 	maximum-speed = "high-speed";
 	dr_mode = "peripheral";
diff --git a/arch/arm/dts/mt8183.dtsi b/arch/arm/dts/mt8183.dtsi
index 294aa2b8979..323a88a7ac9 100644
--- a/arch/arm/dts/mt8183.dtsi
+++ b/arch/arm/dts/mt8183.dtsi
@@ -236,9 +236,9 @@
 			};
 		};
 
-		usb: usb@11200000 {
+		usb: usb@11201000 {
 			compatible ="mediatek,mt8183-mtu3", "mediatek,mtu3";
-			reg = <0 0x11200000 0 0x3e00>,
+			reg = <0 0x11201000 0 0x2e00>,
 			      <0 0x11203e00 0 0x0100>;
 			reg-names = "mac", "ippc";
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_LOW>;
@@ -251,16 +251,9 @@
 			ranges;
 			status = "disabled";
 
-			ssusb: ssusb@11200000 {
-				compatible = "mediatek,ssusb";
-				reg = <0 0x11200000 0 0x3e00>;
-				reg-names = "mac";
-				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_LOW>;
-				status = "disabled";
-			};
-
-			usb_host: xhci@11200000 {
-				compatible = "mediatek,mtk-xhci";
+			usb_host: usb@11200000 {
+				compatible = "mediatek,mt8183-xhci",
+					     "mediatek,mtk-xhci";
 				reg = <0 0x11200000 0 0x1000>;
 				reg-names = "mac";
 				interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_LOW>;
diff --git a/arch/arm/dts/mt8512-bm1-emmc.dts b/arch/arm/dts/mt8512-bm1-emmc.dts
index 12511b5fed4..13d3f804cb4 100644
--- a/arch/arm/dts/mt8512-bm1-emmc.dts
+++ b/arch/arm/dts/mt8512-bm1-emmc.dts
@@ -114,13 +114,9 @@
 		};
 };
 
-&ssusb {
+&usb3 {
 	dr_mode = "peripheral";
 	maximum-speed = "high-speed";
-	status = "okay";
-};
-
-&usb3 {
 	vbus-supply = <&usb_p0_vbus>;
 	status = "okay";
 };
diff --git a/arch/arm/dts/mt8512.dtsi b/arch/arm/dts/mt8512.dtsi
index bdb84f8ef00..eb0a09826f9 100644
--- a/arch/arm/dts/mt8512.dtsi
+++ b/arch/arm/dts/mt8512.dtsi
@@ -101,27 +101,18 @@
 		status = "disabled";
 	};
 
-	usb3: usb@11213e00 {
+	usb3: usb@11211000 {
 		compatible = "mediatek,mt8512-mtu3", "mediatek,mtu3";
-		reg = <0x11213e00 0x0100>;
-		reg-names = "ippc";
+		reg = <0x11211000 0x2e00>,
+		      <0x11213e00 0x0100>;
+		reg-names = "mac", "ippc";
+		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_LOW>;
 		phys = <&u2port0 PHY_TYPE_USB2>, <&u2port1 PHY_TYPE_USB2>;
 		clocks = <&infracfg CLK_INFRA_USB_SYS>,
 			 <&topckgen CLK_TOP_SSUSB_TOP_CK_EN>,
 			 <&infracfg CLK_INFRA_ICUSB>;
 		clock-names = "sys_ck", "ref_ck", "mcu_ck";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
 		status = "disabled";
-
-		ssusb: usb@11210000 {
-			compatible = "mediatek,ssusb";
-			reg = <0x11210000 0x3e00>;
-			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_LOW>;
-			reg-names = "mac";
-			status = "disabled";
-		};
 	};
 
 	u3phy: usb-phy@11cc0000 {
diff --git a/doc/device-tree-bindings/usb/mediatek,mtu3.txt b/doc/device-tree-bindings/usb/mediatek,mtu3.txt
index ab877bfa89f..c0f077c8c8e 100644
--- a/doc/device-tree-bindings/usb/mediatek,mtu3.txt
+++ b/doc/device-tree-bindings/usb/mediatek,mtu3.txt
@@ -1,79 +1,44 @@
-The device node for Mediatek USB3 DRD controller
+MediaTek USB3 DRD controller
+============================
 
-Required properties:
- - compatible : should be "mediatek,<soc-model>-mtu3", "mediatek,mtu3",
-	soc-model is the name of SoC, such as mt8512 etc,
-	when using "mediatek,mtu3" compatible string, you need SoC specific
-	ones in addition, one of:
-	- "mediatek,mt8512-mtu3"
- - reg : specifies physical base address and size of the registers
- - reg-names: should be
-	- "ippc" : IP Port Control
- - power-domains : a phandle to USB power domain node to control USB's MTCMOS
- - clocks : a list of phandle + clock-specifier pairs, one for each
-	entry in clock-names
- - clock-names : must contain "sys_ck" for clock of controller,
-	the following clocks are optional:
-	"ref_ck", "mcu_ck", "dma_ck" and "xhci_ck";
- - phys : list of all the USB PHYs on this HCD
- - #address-cells, #size-cells : used for sub-nodes with 'reg' property
- - ranges : allows valid 1:1 translation between child's address space and
-	parent's address space
+U-Boot follows the upstream MediaTek MTU3 binding described in:
 
-Optional properties:
- - vusb33-supply : regulator of USB AVDD3.3v
- - vbus-supply : regulator of VBUS 5v, needed when supports host mode.
+  dts/upstream/Bindings/usb/mediatek,mtu3.yaml
 
-Sub-nodes:
-Required properties:
- - compatible : should be "mediatek,ssusb"
- - reg : specifies physical base address and size of the registers
- - reg-names: should be
-	- "mac" : SSUSB MAC, include xHCI and device
- - interrupts : interrupt used by xHCI or device
- - dr_mode : should be one of "host" or "peripheral",
-	see : usb/generic.txt
+The controller node owns the device MAC and IP Port Control resources and the
+device interrupt. The "mac" resource starts at the device MAC register block;
+it does not include the preceding xHCI register block. The dr_mode property
+selects the controller role, while CONFIG_USB_MTU3_GADGET and
+CONFIG_USB_MTU3_HOST select the role supported by the U-Boot build.
 
-Optional properties:
- - pinctrl-names : a pinctrl state named "default" is optional
- - pinctrl-0 : pin control group
-	See: pinctrl/pinctrl-bindings.txt
+U-Boot additionally supports the "mediatek,mt8512-mtu3" compatible using the
+same property layout. It also supports the optional boolean property
+"mediatek,force-vbus" to force VBUS valid in device mode. These U-Boot
+extensions are not part of the upstream schema, so dt-validate flags them.
 
- - device mode:
-   - maximum-speed : valid arguments are "full-speed", "high-speed",
-	"super-speed" and "super-speed-plus",
-	see: usb/generic.txt
-   - mediatek,force-vbus : force vbus as valid by SW
-
- - host mode (dr_mode is "host"):
-   - mediatek,u3p-dis-msk : mask to disable u3ports, bit0 for u3port0,
-	bit1 for u3port1, ... etc;
+The legacy U-Boot-only "mediatek,ssusb" child layout is not supported. In host
+mode U-Boot binds its host role to an enabled standard MediaTek xHCI child,
+whose "mac" resource describes the separate xHCI register block. MT8512 host
+mode is not described because its xHCI host interrupt is not documented, and
+the mediatek,mtk-xhci binding requires it; the host clock itself is available
+as CLK_INFRA_USB_XHCI.
 
 Example:
-usb3: usb@11213e00 {
+
+usb3: usb@11211000 {
 	compatible = "mediatek,mt8512-mtu3", "mediatek,mtu3";
-	reg = <0x11213e00 0x0100>;
-	reg-names = "ippc";
+	reg = <0x11211000 0x2e00>,
+	      <0x11213e00 0x0100>;
+	reg-names = "mac", "ippc";
+	interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_LOW>;
 	phys = <&u2port0 PHY_TYPE_USB2>, <&u2port1 PHY_TYPE_USB2>;
-	power-domains = <&scpsys MT8512_POWER_DOMAIN_USB>;
 	clocks = <&infracfg CLK_INFRA_USB_SYS>,
 		 <&topckgen CLK_TOP_SSUSB_TOP_CK_EN>,
 		 <&infracfg CLK_INFRA_ICUSB>;
 	clock-names = "sys_ck", "ref_ck", "mcu_ck";
-	vusb33-supply = <reg_3p3v>;
+	dr_mode = "peripheral";
+	maximum-speed = "high-speed";
+	mediatek,force-vbus;
 	vbus-supply = <&usb_p0_vbus>;
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges;
-	status = "disabled";
-
-	ssusb: usb@11210000 {
-		compatible = "mediatek,ssusb";
-		reg = <0x11210000 0x3e00>;
-		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_LOW>;
-		reg-names = "mac";
-		dr_mode = "peripheral";
-		maximum-speed = "high-speed";
-		status = "disabled";
-	};
+	status = "okay";
 };
diff --git a/drivers/usb/mtu3/Kconfig b/drivers/usb/mtu3/Kconfig
index 5ec498ec953..22f93385d1d 100644
--- a/drivers/usb/mtu3/Kconfig
+++ b/drivers/usb/mtu3/Kconfig
@@ -22,6 +22,7 @@ choice
 config USB_MTU3_HOST
 	bool "Host only mode"
 	depends on USB_XHCI_HCD
+	select SPL_OF_TRANSLATE if SPL_USB_HOST
 	help
 	  Select this when you want to use MTU3 in host mode only,
 	  thereby the gadget feature will be regressed.
diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index 8a7ae83ee99..7afccd7208a 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -137,15 +137,13 @@ enum mtu3_dr_force_mode {
 };
 
 /**
- * @mac_base: register base address of MAC, include xHCI and device
+ * @mac_base: register base address of the device MAC
  * @ippc_base: register base address of IP Power and Clock interface (IPPC)
  * @vusb33_supply: usb3.3V shared by device/host IP
  * @vbus_supply: vbus 5v of OTG port
  * @clks: optional clocks, include "sys_ck", "ref_ck", "mcu_ck",
  *		"dma_ck" and "xhci_ck"
  * @phys: phys used
- * @dr_mode: works in which mode:
- *		host only, device only or dual-role mode
  */
 struct ssusb_mtk {
 	struct udevice *dev;
@@ -158,13 +156,14 @@ struct ssusb_mtk {
 	struct udevice *vbus_supply;
 	struct clk_bulk clks;
 	struct phy_bulk phys;
-	/* otg */
-	enum usb_dr_mode dr_mode;
 };
 
 /**
  * @ctrl: xHCI controller, needs to come first in this struct!
  * @hcd: xHCI's register base address
+ * @vusb33_supply: regulator from the xHCI child node
+ * @vbus_supply: regulator from the xHCI child node or its MTU3 parent
+ * @clks: clocks from the xHCI child node
  * @u2_ports: number of usb2 host ports
  * @u3_ports: number of usb3 host ports
  * @u3p_dis_msk: mask of disabling usb3 ports, for example, bit0==1 to
@@ -176,6 +175,9 @@ struct mtu3_host {
 	void __iomem *ippc_base;
 	struct ssusb_mtk *ssusb;
 	struct udevice *dev;
+	struct udevice *vusb33_supply;
+	struct udevice *vbus_supply;
+	struct clk_bulk clks;
 	u32 u2_ports;
 	u32 u3_ports;
 	u32 u3p_dis_msk;
diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index 2f5cc9b1480..3a1f8ff404f 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -802,8 +802,8 @@ int ssusb_gadget_init(struct ssusb_mtk *ssusb)
 	mtu->ippc_base = ssusb->ippc_base;
 	mtu->mac_base = ssusb->mac_base;
 	mtu->ssusb = ssusb;
-	mtu->max_speed = usb_get_maximum_speed(dev_ofnode(dev));
-	mtu->force_vbus = dev_read_bool(dev, "mediatek,force-vbus");
+	mtu->max_speed = usb_get_maximum_speed(dev_ofnode(ssusb->dev));
+	mtu->force_vbus = dev_read_bool(ssusb->dev, "mediatek,force-vbus");
 
 	ret = mtu3_hw_init(mtu);
 	if (ret) {
diff --git a/drivers/usb/mtu3/mtu3_host.c b/drivers/usb/mtu3/mtu3_host.c
index 8001fc2d9bd..f1675065c54 100644
--- a/drivers/usb/mtu3/mtu3_host.c
+++ b/drivers/usb/mtu3/mtu3_host.c
@@ -110,11 +110,11 @@ int ssusb_host_init(struct ssusb_mtk *ssusb)
 	int ret;
 
 	u3h->ssusb = ssusb;
-	u3h->hcd = ssusb->mac_base;
 	u3h->ippc_base = ssusb->ippc_base;
 
 	/* optional property, ignore the error */
-	dev_read_u32(dev, "mediatek,u3p-dis-msk", &u3h->u3p_dis_msk);
+	dev_read_u32(ssusb->dev, "mediatek,u3p-dis-msk",
+		     &u3h->u3p_dis_msk);
 
 	host_ports_num_get(u3h);
 	ret = ssusb_host_enable(u3h);
@@ -123,12 +123,6 @@ int ssusb_host_init(struct ssusb_mtk *ssusb)
 
 	ssusb_set_force_mode(ssusb, MTU3_DR_FORCE_HOST);
 
-	ret = regulator_set_enable(ssusb->vbus_supply, true);
-	if (ret < 0 && ret != -ENOSYS) {
-		dev_err(dev, "failed to enable vbus %d!\n", ret);
-		return ret;
-	}
-
 	dev_info(dev, "%s done...\n", __func__);
 
 	return 0;
@@ -136,6 +130,5 @@ int ssusb_host_init(struct ssusb_mtk *ssusb)
 
 void ssusb_host_exit(struct ssusb_mtk *ssusb)
 {
-	regulator_set_enable(ssusb->vbus_supply, false);
 	ssusb_host_disable(ssusb->u3h);
 }
diff --git a/drivers/usb/mtu3/mtu3_hw_regs.h b/drivers/usb/mtu3/mtu3_hw_regs.h
index 9c2a7e1f466..2ac72953e34 100644
--- a/drivers/usb/mtu3/mtu3_hw_regs.h
+++ b/drivers/usb/mtu3/mtu3_hw_regs.h
@@ -11,12 +11,11 @@
 #define _SSUSB_HW_REGS_H_
 
 /* segment offset of MAC register */
-#define SSUSB_XCHI_BASE		0x0000
-#define SSUSB_DEV_BASE		0x1000
-#define SSUSB_EPCTL_CSR_BASE	0x1800
-#define SSUSB_USB3_MAC_CSR_BASE	0x2400
-#define SSUSB_USB3_SYS_CSR_BASE	0x2400
-#define SSUSB_USB2_CSR_BASE	0x3400
+#define SSUSB_DEV_BASE		0x0000
+#define SSUSB_EPCTL_CSR_BASE	0x0800
+#define SSUSB_USB3_MAC_CSR_BASE	0x1400
+#define SSUSB_USB3_SYS_CSR_BASE	0x1400
+#define SSUSB_USB2_CSR_BASE	0x2400
 
 /* IPPC register in Infra */
 #define SSUSB_SIFSLV_IPPC_BASE	0x0000
diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index 26fee141f6e..6957e3c2d33 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -135,7 +135,6 @@ static void ssusb_ip_sw_reset(struct ssusb_mtk *ssusb)
 
 static int get_ssusb_rscs(struct udevice *dev, struct ssusb_mtk *ssusb)
 {
-	struct udevice *child;
 	int ret;
 
 	ret = device_get_supply_regulator(dev, "vusb33-supply",
@@ -154,37 +153,20 @@ static int get_ssusb_rscs(struct udevice *dev, struct ssusb_mtk *ssusb)
 		return ret;
 	}
 
-	ssusb->ippc_base = devfdt_remap_addr_name(dev, "ippc");
+	ssusb->ippc_base = dev_remap_addr_name(dev, "ippc");
 	if (!ssusb->ippc_base) {
 		dev_err(dev, "error mapping memory for ippc\n");
 		return -ENODEV;
 	}
 
-	ret = device_find_first_child(dev, &child);
-	if (ret || !child) {
-		dev_err(dev, "failed to get child %d!\n", ret);
-		return ret;
-	}
-
-	ssusb->mac_base = devfdt_remap_addr_name(child, "mac");
+	ssusb->mac_base = dev_remap_addr_name(dev, "mac");
 	if (!ssusb->mac_base) {
 		dev_err(dev, "error mapping memory for mac\n");
 		return -ENODEV;
 	}
 
-	ssusb->dr_mode = usb_get_dr_mode(dev_ofnode(child));
-
-	if (ssusb->dr_mode == USB_DR_MODE_UNKNOWN ||
-		ssusb->dr_mode == USB_DR_MODE_OTG)
-		ssusb->dr_mode = USB_DR_MODE_PERIPHERAL;
-
-	if (IS_ENABLED(CONFIG_USB_MTU3_GADGET))
-		ssusb->dr_mode = USB_DR_MODE_PERIPHERAL;
-	else if (IS_ENABLED(CONFIG_USB_MTU3_HOST))
-		ssusb->dr_mode = USB_DR_MODE_HOST;
-
-	dev_info(dev, "dr_mode: %d, ippc: 0x%p, mac: 0x%p\n",
-		 ssusb->dr_mode, ssusb->ippc_base, ssusb->mac_base);
+	dev_info(dev, "ippc: 0x%p, mac: 0x%p\n",
+		 ssusb->ippc_base, ssusb->mac_base);
 
 	return 0;
 }
@@ -217,11 +199,6 @@ static int mtu3_remove(struct udevice *dev)
 	return 0;
 }
 
-static const struct udevice_id ssusb_of_match[] = {
-	{.compatible = "mediatek,ssusb",},
-	{},
-};
-
 #if CONFIG_IS_ENABLED(DM_USB_GADGET)
 static int mtu3_gadget_probe(struct udevice *dev)
 {
@@ -257,16 +234,90 @@ static const struct usb_gadget_generic_ops mtu3_gadget_ops = {
 U_BOOT_DRIVER(mtu3_peripheral) = {
 	.name = "mtu3-peripheral",
 	.id = UCLASS_USB_GADGET_GENERIC,
-	.of_match = ssusb_of_match,
 	.ops = &mtu3_gadget_ops,
 	.probe = mtu3_gadget_probe,
 	.remove = mtu3_gadget_remove,
 	.priv_auto	= sizeof(struct mtu3),
 };
+
+static int mtu3_bind_gadget(struct udevice *parent)
+{
+	struct udevice *dev;
+	int ret;
+
+	/* Node-less device: name it after the controller for diagnostics. */
+	ret = device_bind_driver(parent, "mtu3-peripheral",
+				 ofnode_get_name(dev_ofnode(parent)), &dev);
+	if (ret)
+		dev_err(parent, "failed to bind peripheral mode\n");
+
+	return ret;
+}
+#else
+static int mtu3_bind_gadget(struct udevice *parent)
+{
+	return -ENODEV;
+}
 #endif
 
 #if defined(CONFIG_SPL_USB_HOST) || \
 	(!defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_HOST))
+static int mtu3_host_rscs_init(struct mtu3_host *u3h)
+{
+	struct ssusb_mtk *ssusb = u3h->ssusb;
+	int ret;
+
+	ret = clk_get_bulk(u3h->dev, &u3h->clks);
+	if (ret) {
+		dev_err(u3h->dev, "failed to get clocks %d!\n", ret);
+		return ret;
+	}
+
+	ret = device_get_supply_regulator(u3h->dev, "vusb33-supply",
+					  &u3h->vusb33_supply);
+	if (ret)
+		dev_dbg(u3h->dev, "can't get optional vusb33 %d\n", ret);
+
+	ret = device_get_supply_regulator(u3h->dev, "vbus-supply",
+					  &u3h->vbus_supply);
+	if (ret) {
+		dev_dbg(u3h->dev, "can't get optional vbus regulator %d\n",
+			ret);
+		u3h->vbus_supply = ssusb->vbus_supply;
+	}
+
+	ret = regulator_set_enable_if_allowed(u3h->vusb33_supply, true);
+	if (ret && ret != -ENOSYS) {
+		dev_err(u3h->dev, "failed to enable vusb33 %d!\n", ret);
+		return ret;
+	}
+
+	ret = regulator_set_enable_if_allowed(u3h->vbus_supply, true);
+	if (ret && ret != -ENOSYS) {
+		dev_err(u3h->dev, "failed to enable vbus %d!\n", ret);
+		goto vbus_err;
+	}
+
+	ret = clk_enable_bulk(&u3h->clks);
+	if (ret)
+		goto clks_err;
+
+	return 0;
+
+clks_err:
+	regulator_set_enable_if_allowed(u3h->vbus_supply, false);
+vbus_err:
+	regulator_set_enable_if_allowed(u3h->vusb33_supply, false);
+	return ret;
+}
+
+static void mtu3_host_rscs_exit(struct mtu3_host *u3h)
+{
+	clk_disable_bulk(&u3h->clks);
+	regulator_set_enable_if_allowed(u3h->vbus_supply, false);
+	regulator_set_enable_if_allowed(u3h->vusb33_supply, false);
+}
+
 static int mtu3_host_probe(struct udevice *dev)
 {
 	struct ssusb_mtk *ssusb = dev_to_ssusb(dev->parent);
@@ -276,15 +327,36 @@ static int mtu3_host_probe(struct udevice *dev)
 
 	u3h->dev = dev;
 	ssusb->u3h = u3h;
-	rc = ssusb_host_init(ssusb);
+	u3h->ssusb = ssusb;
+	u3h->hcd = dev_remap_addr_name(dev, "mac");
+	if (!u3h->hcd) {
+		dev_err(dev, "error mapping memory for xHCI mac\n");
+		return -ENODEV;
+	}
+
+	rc = mtu3_host_rscs_init(u3h);
 	if (rc)
 		return rc;
 
+	rc = ssusb_host_init(ssusb);
+	if (rc)
+		goto rscs_err;
+
 	u3h->ctrl.quirks = XHCI_MTK_HOST;
 	hcor = (struct xhci_hcor *)((uintptr_t)u3h->hcd +
 			HC_LENGTH(xhci_readl(&u3h->hcd->cr_capbase)));
 
-	return xhci_register(dev, u3h->hcd, hcor);
+	rc = xhci_register(dev, u3h->hcd, hcor);
+	if (rc)
+		goto host_err;
+
+	return 0;
+
+host_err:
+	ssusb_host_exit(ssusb);
+rscs_err:
+	mtu3_host_rscs_exit(u3h);
+	return rc;
 }
 
 static int mtu3_host_remove(struct udevice *dev)
@@ -293,68 +365,99 @@ static int mtu3_host_remove(struct udevice *dev)
 
 	xhci_deregister(dev);
 	ssusb_host_exit(u3h->ssusb);
+	mtu3_host_rscs_exit(u3h);
 	return 0;
 }
 
 U_BOOT_DRIVER(mtu3_host) = {
 	.name = "mtu3-host",
 	.id = UCLASS_USB,
-	.of_match = ssusb_of_match,
 	.probe = mtu3_host_probe,
 	.remove = mtu3_host_remove,
 	.priv_auto	= sizeof(struct mtu3_host),
 	.ops = &xhci_usb_ops,
 	.flags = DM_FLAG_ALLOC_PRIV_DMA,
 };
-#endif
 
-static int mtu3_glue_bind(struct udevice *parent)
+static int mtu3_bind_host(struct udevice *parent)
 {
 	struct udevice *dev;
-	enum usb_dr_mode dr_mode;
-	const char *driver;
 	const char *name;
 	ofnode node;
 	int ret;
 
-	node = ofnode_by_compatible(dev_ofnode(parent), "mediatek,ssusb");
-	if (!ofnode_valid(node))
+	ofnode_for_each_subnode(node, dev_ofnode(parent)) {
+		if (ofnode_is_enabled(node) &&
+		    ofnode_device_is_compatible(node, "mediatek,mtk-xhci"))
+			break;
+	}
+	if (!ofnode_valid(node)) {
+		dev_err(parent, "failed to find enabled xHCI child node\n");
 		return -ENODEV;
+	}
 
 	name = ofnode_get_name(node);
-	dr_mode = usb_get_dr_mode(node);
+	ret = device_bind_driver_to_node(parent, "mtu3-host", name, node,
+					 &dev);
+	if (ret)
+		dev_err(parent, "failed to bind host mode\n");
+
+	return ret;
+}
+#else
+static int mtu3_bind_host(struct udevice *parent)
+{
+	return -ENODEV;
+}
+#endif
+
+static int mtu3_glue_bind(struct udevice *parent)
+{
+	enum usb_dr_mode dr_mode;
+	ofnode node;
+
+	/* Reject the old layout before misinterpreting its register offsets. */
+	ofnode_for_each_subnode(node, dev_ofnode(parent)) {
+		if (ofnode_device_is_compatible(node, "mediatek,ssusb")) {
+			dev_err(parent,
+				"legacy mediatek,ssusb child is unsupported\n");
+			/* Only -ENODEV keeps the failure contained to USB. */
+			return -ENODEV;
+		}
+	}
+
+	dr_mode = usb_get_dr_mode(dev_ofnode(parent));
+	if (dr_mode == USB_DR_MODE_UNKNOWN) {
+		/* Absent defaults to otg, an unparsable value is an error. */
+		if (dev_read_string(parent, "dr_mode")) {
+			dev_err(parent, "invalid dr_mode\n");
+			return -ENODEV;
+		}
+
+		dr_mode = USB_DR_MODE_OTG;
+	}
 
 	switch (dr_mode) {
-#if CONFIG_IS_ENABLED(DM_USB_GADGET)
 	case USB_DR_MODE_PERIPHERAL:
-	case USB_DR_MODE_OTG:
-		dev_dbg(parent, "%s: dr_mode: peripheral\n", __func__);
-		driver = "mtu3-peripheral";
+		if (IS_ENABLED(CONFIG_USB_MTU3_GADGET))
+			return mtu3_bind_gadget(parent);
 		break;
-#endif
-
-#if defined(CONFIG_SPL_USB_HOST) || \
-	(!defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_HOST))
 	case USB_DR_MODE_HOST:
-		dev_dbg(parent, "%s: dr_mode: host\n", __func__);
-		driver = "mtu3-host";
+		if (IS_ENABLED(CONFIG_USB_MTU3_HOST))
+			return mtu3_bind_host(parent);
+		break;
+	case USB_DR_MODE_OTG:
+		if (IS_ENABLED(CONFIG_USB_MTU3_GADGET))
+			return mtu3_bind_gadget(parent);
+		if (IS_ENABLED(CONFIG_USB_MTU3_HOST))
+			return mtu3_bind_host(parent);
 		break;
-#endif
 	default:
-		dev_err(parent, "%s: unsupported dr_mode %d\n",
-			__func__, dr_mode);
-		return -ENODEV;
-	};
-
-	dev_dbg(parent, "%s: node name: %s, driver %s, dr_mode %d\n",
-		__func__, name, driver, dr_mode);
-
-	ret = device_bind_driver_to_node(parent, driver, name, node, &dev);
-	if (ret)
-		dev_err(parent, "%s: not able to bind usb device mode\n",
-			__func__);
+		break;
+	}
 
-	return ret;
+	dev_err(parent, "dr_mode %d is unsupported by this build\n", dr_mode);
+	return -ENODEV;
 }
 
 static const struct udevice_id mtu3_of_match[] = {

---
base-commit: d0c49353a648e135f269a2953dc9326505ba87de
change-id: 20260717-ccaione-upstream-mtu3-spl-gadget-aa3d39cad06a

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

