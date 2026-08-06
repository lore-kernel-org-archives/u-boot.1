Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2837CC55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 12:54:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B020560784;
	Thu,  6 Aug 2026 12:54:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PJ8fljqkQ3ed; Thu,  6 Aug 2026 12:54:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 91DC16072E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786020889;
	bh=7u5uybsn2VzIoL950lU8ZAjWvMuIgLMobD3kdTkDIgo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hRApIeqOTjfsb++ZDFqoO1bWGPsfT83kYa9SlbwtJfjvCZWymsz7f+ZrTj6tWpTRr
	 cDWeZzrpcZDlYaMunYpaeP0iSWY/3bmvyB2LAwYdu8vT3yVgp4XDvRpIwqzT52btnB
	 D4VFR6xDJIvixksnh6qeflogAXn5s6YvqshNphObeFmJJ15jhpPyhTxYW0NGom7GBX
	 IQavryuU76QseM/l8OEHVUgicz0TNXL1i6wIJvhs3hBpV5yKwidwxRhqfNVR+E0sNY
	 ID/xCgJErDZA58m5pjhpR/s57e/r0ilmyc8yxriaVMrf8v56m2mO4BR1tnZaJGsguv
	 jF19kfS/l4foQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91DC16072E;
	Thu,  6 Aug 2026 12:54:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6816D397
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:54:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5A02680DFD
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:54:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MGFR6u8kdanC for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 12:54:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3B60C80DF6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3B60C80DF6
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3B60C80DF6
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:54:46 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so13298625e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 05:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786020884; x=1786625684;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7u5uybsn2VzIoL950lU8ZAjWvMuIgLMobD3kdTkDIgo=;
 b=Pekua+C0L1iFqu+FNDUOqLXLUICTU3vF97UC/p6fpAOKF6ePfT8BVeDaBscZMHNBGu
 GPfTMLe448rETfPAPCiA506WkDPzfR9xvrm0osONiKNHd4IOCwx7YYVF4IL4u0Xz3VZq
 xNmPGPUhWrYjGusoLMSYBn8930mJsTaY7TKGC9FSl+XIx9xMqG/fx/FeiMbkcZyF6Vj0
 dybRUUwA5UBcY4GdcsUrhIF9x2qAJi+N2XqqzYROaMLqQgqkxzxMg2pRezxv1nQMushH
 pVp1sHH1jrAB9z1wY11ZbwTfZy4QyUVLjq85gZFHeXZkPYqtefLGU0EfW4gQBjgZ60R1
 3D9g==
X-Forwarded-Encrypted: i=1;
 AHgh+RonVbuFglSlckub018LNzSHXy7HTlUgh/yVRN2X01WP25CxqNq42oAVU3CGn7l3lzupJXKd7Ds=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwkVIjiF1uenqnRU6gr4/AxSIVmwRsvnW2FmxrDRAANMYeXs2Ap
 /UPI6X/WDlR9IRgkVTw51dU1BBwpSMwEHPMuilSBs47hw9eejrIarbLSH7+qXjW2iKM=
X-Gm-Gg: AR+sD10pCyQPXAYDQ/QW7XBZUnzjxmAgVGkO7GE1OksI/Q9C8OhglXIJnUFoJELnCm9
 IL9ODmkcr2XYV8JFJTYkLMWlKP8KmITexhX2KMg1WQz/4j1AwrYYMBfvDHbqksG7fS/9XH1/Bde
 869lba5ujmDtCY8KGt4nFBmtdmY9WyBTwwRFqepATmJZawWQLuPrXC1Jg59V8ehiZU1H1hosF6L
 YQOR4V8h4dLSv7jUyMsjSpoq/emKUWD3psH5rlLyCgWgCMRgWzDrq4b8IMf3MdMplrPCquT6Edf
 IyYmi1Gsk703YS+RqwGPsh5utWJjN5xToyhVKrAlCLScyIBUQgnoslYoTmxUg77DNszYM22AgL4
 epoPRgPGq8ZgidgPng0V2nvBC+LWTW+qS/VQQ8ylr4o8t4qIqVYsP02hof9TtfeC1EdjwPixLkh
 M75QUJSILq0ExqDEbmYQfZicWl1xsCFMvBhdQTHgoqKF8a8V3lyGXN1Y+WZYPLkZjkHwLWDW/8m
 N3/xoowWu3vhoxhXDt4NGEK3UphZlgwArLqhmdii9vd4GjRMc+LAZJeja9DclLUgRins2ge0m8B
 MQdjRw==
X-Received: by 2002:a05:600c:3226:b0:490:e5c1:b8bf with SMTP id
 5b1f17b1804b1-4994e7ce0dcmr134360405e9.13.1786020884140; 
 Thu, 06 Aug 2026 05:54:44 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.retail.telecomitalia.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499542133f0sm69292995e9.5.2026.08.06.05.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 05:54:43 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 06 Aug 2026 14:54:35 +0200
Subject: [PATCH v6 1/3] doc: usb: remove obsolete MediaTek MTU3 bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-ccaione-upstream-mtu3-spl-gadget-v6-1-66e133a4bf1a@baylibre.com>
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
 d=baylibre.com; s=google; t=1786020884; x=1786625684;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7u5uybsn2VzIoL950lU8ZAjWvMuIgLMobD3kdTkDIgo=;
 b=Ka4tgIRjWreNHLS0X5L6vLszhow5SbBG6h9fOlPb+cgVkRxYKwqJNnJtmnA859H8Ex
 qr9CMHua+2NYSJIr9B/Py63vGM0QY4k5pxNl4ivx2vZ1RYKdvdVHOuSVYCK2AWJ7BP5s
 vUfkbSnacoCMLDDpUT0dGDxkdqTldtFUTeNEC4jc3SVrQX3TmHIofXj9ZxG++mmgaB5/
 b1Xu6WSEelkguMd57PCyOhQeEgQsOqGbwDHYAF4RMGyEkx3HeOuGOe5A8WeytCtT5ocn
 kmWA2rSdGBs7aMoNQUPe89zj3P0e3Zzb+wVt18F02U4guljKxS1r8wHfthKpUqS7cxHl
 IikQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Ka4tgIRj
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

