Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3894C5AC67
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 13:40:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B34F80DC7;
	Sat,  8 Aug 2026 13:40:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x0Wk-E1oUjeq; Sat,  8 Aug 2026 13:40:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8496780DCB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786196415;
	bh=h46GueYSqcTW/EHorMqLrVzrZ0EJPJPZpBilWcmxHPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gUgtty1RVOMQhGNuFh56JoUM4gScx8erhgrLjEYaSb2wUhxhMujqU4UCIhjiPtw9v
	 he8LiAVd462i5steQz34cRrXpK2U2rLwEfW3f9y4Ba/4dA40rXA2tjklBuXv8wwdpc
	 OARz+/JVjCMR7YiG0/fLVi/2rCtAJASrtryrdnwFydny6bhHGlVj654wW6NVPif8Xn
	 8P0Ufw7Z2yFrDp7CAqKwz65y1H9BHXCjin2xNTRPJwj08xQdr3Bs5IFIvZh2YGmiMQ
	 Jtt48VNt5ncjsJW68NIjxbQiowkbU8TU/zQ4ASWAd6AgRP0Cp6abiA9O+oSbrt1DkI
	 LjDxRZ1Ph7W0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8496780DCB;
	Sat,  8 Aug 2026 13:40:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 04863282
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:40:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EA78640597
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:40:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h3P9ALNhIG-V for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 13:40:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5657140594
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5657140594
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5657140594
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 13:40:11 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-480033bdcf4so180535f8f.2
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 06:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786196409; x=1786801209;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h46GueYSqcTW/EHorMqLrVzrZ0EJPJPZpBilWcmxHPQ=;
 b=aQvvIa2IrA+XoTIcX6OeHabLHKSy6Wup8ZGgt+TJapv0vQDvhPiwQ1dToLN959S5df
 voW36jFSrx3OzKZfyynbN/Sw99GCFbPbS/JEftGDDoSb9hMruHb/zgi6rTsbAzS2pxmO
 7SKeXvKXoCGFs8Yb1FylJvkp2nIR20SJtKXCoRXGiNX1Fm9bEuZItTDth6yRXwOvznvI
 wpGP2o/UauHdOEOikwLAuhMLNGsitbVv3vLtaVgUTzaR9IwNZnfVNNLajW4suBssXjLA
 HC4WWy4a0vS6lrqbFLaZYnCUqxVTftMwAAlL/WVuxc8HAcJF1Iy09ai03U8um9zwBPxt
 NftQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqaaaax7BrZbl7vphWZ+R2zQgRyCcuU90t+bmIpE0ml7YQ4OFNFzc8/NEZrzgA87U+qtPUQ4fc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwMdNoIYN4unLVvw8pIk7VRcUQiKEtUWd8qGJQ9Yhj3g3LX+8m9
 K108r+hXwli4+5mWSYPtSvO4UOpVPBWpPuf5dMqzDfT/EyjLrtDobAvh8UA2BMaIhAc=
X-Gm-Gg: AR+sD11rM862scUrqM8gYfB3e3ieK2bVqEM55zK3Vusk2DGgfJfZP5Dr7tns6T4sPku
 4l5RzfYMTqKWALp2XOjvJ04oBceJSNDxDisX3s1nd2XBGAf0XOpiY6zlezuIBIrCud/qkNNHrvP
 TKQDRc9yqDRL6ohUuDbxUSyf0mK9PYYBGpnZ/fX68/XV8V07X6x2MGOtEd1j/FjsJTsDrO92VVA
 Mt8Gwc4aOscNWPoqY1pk9yO7VK+7IGUTAs6mkJ7g0sAJCAkbECVfU3mZIIL52BAi7WPRbYRLQmw
 SwaEZDd4tLSJp6DIeWtvxKDupjTjahq4ud3lO+gs3P4lwmcJfrJuHUEEwZ7dg9Chp5Lwa1hqWuQ
 RP9X+tsVJp+nuZRjMRqQ3y8MbFYcqMYyHPsrpJnAOYgaV1/wMBnzY9MltV05eGMwEZw4L5Nc2w4
 l7ibiXyuUCM1uNna6iSN6VhDPwtzGYsexc0+NBSRVDUQ81b1+bi1+oyhFfP06TCaA4OkUBsYhY9
 s/V6lkOZ+Nhm0pctDPlj31BZjTXboOyExTwMobyZQ==
X-Received: by 2002:a05:6000:29ce:b0:47f:93be:dabd with SMTP id
 ffacd0b85a97d-47fec634beemr32537234f8f.28.1786196408977; 
 Sat, 08 Aug 2026 06:40:08 -0700 (PDT)
Received: from [127.0.0.1] (static-226232.rol.raiffeisen.net.
 [195.254.226.232]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021506cbsm15587361f8f.14.2026.08.08.06.40.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 06:40:08 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sat, 08 Aug 2026 15:39:58 +0200
Subject: [PATCH v7 1/3] doc: usb: remove obsolete MediaTek MTU3 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-ccaione-upstream-mtu3-spl-gadget-v7-1-ed659a79a918@baylibre.com>
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
 d=baylibre.com; s=google; t=1786196409; x=1786801209;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h46GueYSqcTW/EHorMqLrVzrZ0EJPJPZpBilWcmxHPQ=;
 b=bqm3TEzySyYO+03mZ00E6K0f0Q6F5NOsS8ZxXR0SMW9PlThhs13njPotlssiFz7ZV9
 gMsB0vcmrb8IxxACny6SDkivJiIyZGIkVzoacOg6dtQpxLtKBKoTVlsXCQHtsCDlWqPZ
 dX7zcRyfSnNkWmpv3+Qy9EYQwLes0AXReQaixBa3u1OaFQCSQcXlK/DLDvkXSaGUOJpd
 XxL7AuSy/Kima3GvnlE1ztdMH/zQgXlTuwppAjV70Ma+KO1rmJ6rax4Fku92rIBDdetJ
 29E/oETHtJfFHBnl67DcNQ+/meDvmntnIDugxi6bOTcchpPy7uClDIbubSBEINUu5YS7
 /spg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=bqm3TEzy
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

The MediaTek MTU3 and xHCI text bindings describe legacy U-Boot layouts
which have been superseded by the canonical Linux schemas. Those schemas
are already synchronized into `dts/upstream/Bindings/usb`.

Remove the duplicate text bindings so new devicetrees and driver changes
use the maintained YAML definitions.

Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 doc/device-tree-bindings/usb/mediatek,mtk-xhci.txt | 46 -------------
 doc/device-tree-bindings/usb/mediatek,mtu3.txt     | 79 ----------------------
 2 files changed, 125 deletions(-)

diff --git a/doc/device-tree-bindings/usb/mediatek,mtk-xhci.txt b/doc/device-tree-bindings/usb/mediatek,mtk-xhci.txt
deleted file mode 100644
index e26e9618eb9..00000000000
--- a/doc/device-tree-bindings/usb/mediatek,mtk-xhci.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-MediaTek xHCI
-
-The device node for USB3 host controller on MediaTek SoCs.
-
-Required properties:
- - compatible : should be one of
-	"mediatek,mtk-xhci"
-	"mediatek,mt8195-xhci"
- - reg : specifies physical base address and size of the registers
- - reg-names: should be "mac" for xHCI MAC and "ippc" for IP port control
- - power-domains : a phandle to USB power domain node to control USB's
-	MTCMOS
- - vusb33-supply : regulator of USB avdd3.3v
-
- - clocks : a list of phandle + clock-specifier pairs, one for each
-	entry in clock-names
- - clock-names : must contain
-	"sys_ck": controller clock used by normal mode,
-	the following ones are optional:
-	"ref_ck": reference clock used by low power mode etc,
-	"mcu_ck": mcu_bus clock for register access,
-	"dma_ck": dma_bus clock for data transfer by DMA,
-	"xhci_ck": controller clock
-
- - phys : list of all the USB PHYs on this HCD
- - phy-names: name specifier for the USB PHY
-
-Optional properties:
- - vbus-supply : reference to the VBUS regulator;
- - mediatek,u3p-dis-msk : mask to disable u3ports, bit0 for u3port0,
-	bit1 for u3port1, ... etc;
- - mediatek,u2p-dis-msk : mask to disable u2ports, bit0 for u2port0,
-	bit1 for u2port1, ... etc;
-
-Example:
-xhci: usb@1a0c0000 {
-	compatible = "mediatek,mt7629-xhci", "mediatek,mtk-xhci";
-	reg = <0x1a0c0000 0x1000>, <0x1a0c3e00 0x0100>;
-	reg-names = "mac", "ippc";
-	power-domains = <&scpsys MT7629_POWER_DOMAIN_HIF1>;
-	clocks = <&ssusbsys CLK_SSUSB_SYS_EN>, <&ssusbsys CLK_SSUSB_REF_EN>,
-		 <&ssusbsys CLK_SSUSB_MCU_EN>, <&ssusbsys CLK_SSUSB_DMA_EN>;
-	clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck";
-	phys = <&u2port0 PHY_TYPE_USB2>, <&u3port0 PHY_TYPE_USB3>;
-	status = "disabled";
-};
diff --git a/doc/device-tree-bindings/usb/mediatek,mtu3.txt b/doc/device-tree-bindings/usb/mediatek,mtu3.txt
deleted file mode 100644
index ab877bfa89f..00000000000
--- a/doc/device-tree-bindings/usb/mediatek,mtu3.txt
+++ /dev/null
@@ -1,79 +0,0 @@
-The device node for Mediatek USB3 DRD controller
-
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
-
-Optional properties:
- - vusb33-supply : regulator of USB AVDD3.3v
- - vbus-supply : regulator of VBUS 5v, needed when supports host mode.
-
-Sub-nodes:
-Required properties:
- - compatible : should be "mediatek,ssusb"
- - reg : specifies physical base address and size of the registers
- - reg-names: should be
-	- "mac" : SSUSB MAC, include xHCI and device
- - interrupts : interrupt used by xHCI or device
- - dr_mode : should be one of "host" or "peripheral",
-	see : usb/generic.txt
-
-Optional properties:
- - pinctrl-names : a pinctrl state named "default" is optional
- - pinctrl-0 : pin control group
-	See: pinctrl/pinctrl-bindings.txt
-
- - device mode:
-   - maximum-speed : valid arguments are "full-speed", "high-speed",
-	"super-speed" and "super-speed-plus",
-	see: usb/generic.txt
-   - mediatek,force-vbus : force vbus as valid by SW
-
- - host mode (dr_mode is "host"):
-   - mediatek,u3p-dis-msk : mask to disable u3ports, bit0 for u3port0,
-	bit1 for u3port1, ... etc;
-
-Example:
-usb3: usb@11213e00 {
-	compatible = "mediatek,mt8512-mtu3", "mediatek,mtu3";
-	reg = <0x11213e00 0x0100>;
-	reg-names = "ippc";
-	phys = <&u2port0 PHY_TYPE_USB2>, <&u2port1 PHY_TYPE_USB2>;
-	power-domains = <&scpsys MT8512_POWER_DOMAIN_USB>;
-	clocks = <&infracfg CLK_INFRA_USB_SYS>,
-		 <&topckgen CLK_TOP_SSUSB_TOP_CK_EN>,
-		 <&infracfg CLK_INFRA_ICUSB>;
-	clock-names = "sys_ck", "ref_ck", "mcu_ck";
-	vusb33-supply = <reg_3p3v>;
-	vbus-supply = <&usb_p0_vbus>;
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
-};

-- 
2.55.0

