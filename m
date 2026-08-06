Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E043EC56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 12:54:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2226E405F3;
	Thu,  6 Aug 2026 12:54:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XzjjqEY2Ov3U; Thu,  6 Aug 2026 12:54:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E7559405D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786020891;
	bh=C2wsP7LBfONltSRA1jqzDgy8AtNRx3zxcny2ZiK5f6s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aJlvg6XVkDz6o/AWk7esTPhvUx7fDuTdpuoCdNbpIiu7Qn433U80/ztIDBAVkAHAp
	 Xqv9FBHfUJb+PhnmkZ3g3zMvKlxRq38zg3QcvknZyvyMGalJUeIScExF6XPYffGOqz
	 VvPuhjCKCkHAraRJcdWFZe9hkONnhAy7R6jOrmcgcFTqa70+gM4egyLXpuucsxZ71b
	 gHFsoOJk6dsktBAsmzDDVtTOuWCHRP+kRlX0peMdztqLn7qPyH9io/x4qDlMqzF9Ug
	 9m+7DvJXO971e6OHZgRytAeDEJALqb/+7Hx6DagTsr+deAnKQUUg00fkEO8DUz51jc
	 jr/Ujd0Ik2sCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7559405D0;
	Thu,  6 Aug 2026 12:54:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 35041218
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:54:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1BAFD40278
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:54:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dzQvHFd_SSD5 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 12:54:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 89A6B40159
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 89A6B40159
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 89A6B40159
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:54:47 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso14424625e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 05:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786020885; x=1786625685;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C2wsP7LBfONltSRA1jqzDgy8AtNRx3zxcny2ZiK5f6s=;
 b=XQkHhyobJfoyUcyNBf8goju2b6JUHbctkAKrheaZSMv3MzZmHO6JoMCuR+uZlduecR
 0krPNPeokhJeNYukr47lpNcQwSoLVRgvm9kTmTjFihPRmpk3rlRWorwEgyTZrWP2/V4A
 SuDUPcsRUVbZDs8eSo475gFPchQj9JLU1gDomygwuIb7KaSu7t3oHNDEJhJkMbeiTXvv
 FTmHgC/E+uvln4z2GSQeIA2wPDjmqTxklJPWmkw6fVx7n21Z4GmV20ouT5bHZX6Bg3kQ
 neDRN3KsWkmGzfXlcMnpI3s6XTfCvOGjfcV4UstxJ711q6D2YY/BijYWdf0GkSqzOz8m
 gsfw==
X-Forwarded-Encrypted: i=1;
 AHgh+RprGeorMM+qfBJP9kZXVtyOzkfgaZVCJDiWXGPCF4Z1q9qGIMKE86X4ob9B2A+WyeT6BTi+za8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzViPVnZDX2v4T3Ku5FvgHAd0X4y1vKx/kN9SCfi2L3omhMUccL
 P2Hob6XUihyZ8V63wDdBv1IMOU4K+2OT0hKWLKrgFG5clWhtFqQ2F/VvxokEwZUbt/Q=
X-Gm-Gg: AR+sD1132WKKLsASJps4x5abaroNCWsbjknNOAnd736KqvGtKEUBhUTh4icTenhWVFG
 kYbzJIH0Rv412wRfmr82G7pkfnbU9tm2yytS6RSimiToYAyke749BEjwoi/PzVYsk568DqM3uxi
 3G2OsGpu9EgqOjt35A+eAucitfTsgR7EnQvJTpE78YMx2Es1SeWVkxnHzto58/s+FQ8kBnYyQhf
 6lcMUgdmOwOHm1mMPFATIngKo1CtiZPtqJ+jv//DcUlQ2E0yn2T1MNlJ04GdOgmtHn5vf7gnpVA
 M9ZusCIl52L5vePNEGSvOYXy6CxuAKnIUHZdWEaW/ZMFCNuAmjqBOqbL60R8kdyj67wDVnpcVtP
 Yenb6uKshKfFMP03Nr1ciaZqxWNQySACpKLYwVGCHE0PiC7Dxg3hERgjiw9s4g5xrmsBOvhNbXR
 VdQ/tzF4uyE3hFXPqiAKEmqtV81RDpazbUzrwS5gjDeLLmUV7zYZSnesRxLjvnMxiZLFhtvB/oQ
 0os5+WAAnIPklF1phT2qDPNoXVmX16K4BTALM0QqHUCtHmtmJOdogBwNnQrgqYgNKwdDXAcsgQM
 VMclFg==
X-Received: by 2002:a05:600c:840f:b0:496:bffb:fb7b with SMTP id
 5b1f17b1804b1-4994e7c0446mr181599335e9.10.1786020885233; 
 Thu, 06 Aug 2026 05:54:45 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.retail.telecomitalia.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499542133f0sm69292995e9.5.2026.08.06.05.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 05:54:44 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 06 Aug 2026 14:54:36 +0200
Subject: [PATCH v6 2/3] usb: mtu3: support the upstream devicetree binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-ccaione-upstream-mtu3-spl-gadget-v6-2-66e133a4bf1a@baylibre.com>
References: <20260806-ccaione-upstream-mtu3-spl-gadget-v6-0-66e133a4bf1a@baylibre.com>
In-Reply-To: <20260806-ccaione-upstream-mtu3-spl-gadget-v6-0-66e133a4bf1a@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@denx.de>, 
 Julien Masson <jmasson@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786020885; x=1786625685;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C2wsP7LBfONltSRA1jqzDgy8AtNRx3zxcny2ZiK5f6s=;
 b=J7HFc35JxonmaQdEvI6+QGcti6S/kqK1Gqg8PYdmQvlFKPTdx2M8jg2pvZh2kqiumE
 uHkqMmxcKpbt4BHGi7YxDVupNMBz0rpp76oduhxCekDXuhHxqwb11GlnlUYlbQuNJkHy
 oIH27TJkljoPVoqTxixrk0G3W/1tD0jKkCjtoguXWG1SFX0Rvp6qIHCoToHlmZJ3l27Q
 2UB47dLxPqUxxrWwkhi3YrviYJj+VnuejnlDsLWZNgYNvo0AYAM5qEiO+WReqNjAVat0
 BWR/T1AMQKw8nOA+kD9c0nuUUvEPaZ6mKlg/KUOsUdUUO9VzGtbnTfaKxvZ9bcY3DSvL
 ZqHg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=J7HFc35J
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

