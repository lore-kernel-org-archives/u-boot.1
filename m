Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5460C5AC67
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 13:40:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 292316068D;
	Sat,  8 Aug 2026 13:40:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YBjn15ERPFgH; Sat,  8 Aug 2026 13:40:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9E124606B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786196416;
	bh=DEh7ASgcEpEzqaHl0oxI3DesY2d738waXDUrnD+w6eA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cyriLF2Sc7zvkMmVCT55IhZ0NzOtFs5Znob2+eFmYdWNYkjN8rlx+Da/23adk9kwk
	 uCitX232qodxVlGyL+Nswo7IUGp01F3JozeZ+sJJish/yBixtmPJEkrvL1+3OLDD2X
	 VhchEIWo4vkaK3G8iIQmTU5dtSqBZqdMuXfOUfTpGTo+8S/gB+ba6yH1AP2/YH6ClR
	 pMbgH548j4R4XhB26etrQz9aYBwySfxIKk4NPxLoiXO7IRtw88qkV6k+IFu/1Zgiri
	 3L2Kjyb0Bmip0tGE0KnN+MJUNXT4S13k8ScmDG7umhqpcHXtCLYcnUmFFB786tRsJG
	 UGrSjzM4vQgCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E124606B9;
	Sat,  8 Aug 2026 13:40:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8ED7C1AF
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:40:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 747DE40594
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:40:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l2yuaQH4yV98 for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 13:40:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9D7C640596
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9D7C640596
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9D7C640596
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:40:12 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4807df69172so774641f8f.1
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 06:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786196410; x=1786801210;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DEh7ASgcEpEzqaHl0oxI3DesY2d738waXDUrnD+w6eA=;
 b=ffRTkCrdFnFd+Tww3CkaDSXubqDoqTWVQGB5mBUSyiXuWe6HqiYnB705iPd9xXqf38
 1w7rLqM3ox49TsLX9z5cDwnLF+SAIVSF+fQRAkMVXA3O+SKtW1Vcb+lA+C45p4Or2MNS
 lIZfhWQgtVva8arLK10hRmUU2dEEqU5Q72bh73auIz6cB7mz8mQdecmCy6a5l8T+tt2f
 sgXpBnEgA6MqAluMRmKUbkyCwP+90rPXxppoFSFyewiU/5c+Je9suHocUk3a2WfaJwTR
 jT1vyGuaj3jetip4iM38y1qPJykkZu85McxBgeAyNjkKnonBNbfQALb1wyHSQ7dQlKfl
 EUuQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNEohNF87cjgp26L16f4fNcbM5FteIrZd1c+RQzljg5YY9PcO2gVvp/R2zePJDxLgYta7VPuo=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzZNExH0NlcDcjjCNm/4ywg9Um9NYK2XfeHmtw3Jgd6VIRU4YNb
 Or9Bnho3yInCMcShdvXVFEqL6EYxc9/J5EmdneJVeR7yKGHyJFxYuzk85jMRBMoj6ok=
X-Gm-Gg: AR+sD13mBDLavT7MnynJ0kJJIwxJ7fMDnO9BVnAzVyBMIqAhsnh45WQ3ukjP+ab9fdA
 58YCuoLtf63rd3jWnup88z3HiLxVRSw6VN+XexUY7QPKcOo7q0Fz/u9QubbgnNX4LH3Ly7TjnN2
 LLOOc6KAGLlDLofcgsvG8XCmF24TJJdgWRneB2qcbV/ag6Nr1VN7uz8i+w5wF9CequTzkUP/8nN
 d5gIKi7B9E0bPoQldenVaJq9vz1kIrgQybVFkgzOYI6k6Dd/fp1x7f4/LnWS8bMLZTBy6eypKPL
 L6mnZKa3AYOMEmDfXgOZzdwPIiH4A/IAAZ4I+i9afavzC1tWbDPZ31CWv1KNiKAVe16mKBuimSD
 JSTBgs2yFraVEdcX9glCaT5zosZYavgscGWQcORKHt9sjjPVzN3DDJqqPLBkUqB2xkX/hhyESTY
 BrPF8nm8/ESf0WLos2RkisOK3gqtOP/idYrPoBnynbfmnzDsRB6CT4aqMOAjK2sFjgNCWcSoBRx
 NXTKgsG8/DPWnKjFCHsMjV/88mFTf0cJczdV8tX
X-Received: by 2002:a05:6000:609:b0:47f:853c:ad7b with SMTP id
 ffacd0b85a97d-48131962d3emr7200820f8f.9.1786196410320; 
 Sat, 08 Aug 2026 06:40:10 -0700 (PDT)
Received: from [127.0.0.1] (static-226232.rol.raiffeisen.net.
 [195.254.226.232]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021506cbsm15587361f8f.14.2026.08.08.06.40.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 06:40:09 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sat, 08 Aug 2026 15:39:59 +0200
Subject: [PATCH v7 2/3] usb: mtu3: support the upstream devicetree binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-ccaione-upstream-mtu3-spl-gadget-v7-2-ed659a79a918@baylibre.com>
References: <20260808-ccaione-upstream-mtu3-spl-gadget-v7-0-ed659a79a918@baylibre.com>
In-Reply-To: <20260808-ccaione-upstream-mtu3-spl-gadget-v7-0-ed659a79a918@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786196410; x=1786801210;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DEh7ASgcEpEzqaHl0oxI3DesY2d738waXDUrnD+w6eA=;
 b=k5jsST3FIjUOxLBCJHNIYQyCpOw8ttI8ELEhLpFbNuRulqDA8goMOXe3zazBxemzt5
 0/TBBSx3OmaesSdcvFqI7QJ9tqa+OT9y+i6ZjIVYT1qg6TZ+CPOsn4FuFE4HicelWH9K
 NybKh7MQmPG1JV7Twr37GRKr4s72TbzR18gk3FBal/UWcmZPwk2GpNA8TkIs2RMtsIvV
 o8/d+4eigGKsshDHUcM89UNa0nYoTjUlY66niuzdk8UmEfHqEOcKmvfapB1Pk++t1rnA
 1XseNGyHUOTW04kcmM7YCVrbOMPj7xriW13Y2rbB8OGYemXhxF1magZYJcJPkwLzbKuL
 h+Hg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=k5jsST3F
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

Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8183-pumpkin.dts  |   4 -
 arch/arm/dts/mt8183.dtsi         |  17 +--
 arch/arm/dts/mt8512-bm1-emmc.dts |   6 +-
 arch/arm/dts/mt8512.dtsi         |  19 +---
 drivers/usb/mtu3/mtu3.h          |  12 ++-
 drivers/usb/mtu3/mtu3_core.c     |   4 +-
 drivers/usb/mtu3/mtu3_host.c     |  11 +-
 drivers/usb/mtu3/mtu3_hw_regs.h  |  11 +-
 drivers/usb/mtu3/mtu3_plat.c     | 227 ++++++++++++++++++++++++++++-----------
 9 files changed, 192 insertions(+), 119 deletions(-)

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
index 26fee141f6e..ec920eaf166 100644
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
+		dev_err(parent, "failed to bind peripheral mode: %d\n", ret);
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
+		dev_err(parent, "failed to bind host mode: %d\n", ret);
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

-- 
2.55.0

