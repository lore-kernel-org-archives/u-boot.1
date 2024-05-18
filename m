Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A53C25B75
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 15:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0B7D886B6;
	Sat, 18 May 2024 17:03:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="QQkt22my";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB9398863A; Sat, 18 May 2024 14:03:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3BE08863F
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 14:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716033793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X+jXXQZMI1fxMzfH2RtOxhkJ6mhbrGBwCuD3fHOuOi4=;
 b=QQkt22myLImG2PEwA1Hr3FvQ5hKuU92KkCjL4qJIVvS02ALhfSGdlsLM9HBiRwjLEktc81
 cyiV2PGVwusFl3v5fgziA52lCC191MsuyHBdF+55BZjGyMsC0lIrB+G59X4zMDRiZI9u33
 z348zQUd2U6oBlLWy1N5N1gjbMQxnUk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-W0NiJ5zaO8e0mNN3WRTgqw-1; Sat, 18 May 2024 08:03:11 -0400
X-MC-Unique: W0NiJ5zaO8e0mNN3WRTgqw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42024ca94d0so21982875e9.1
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 05:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716033790; x=1716638590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X+jXXQZMI1fxMzfH2RtOxhkJ6mhbrGBwCuD3fHOuOi4=;
 b=WGcyM+yuHCc5/19QzO6ljT3ooiku7+Zp6PPc/sq6PAT46LPeo+lhIre5ATHlKPhRWL
 VXhxYj9cxJXLgkCdof81WhMHukQnz0WrU+enfpReHuSU7XvvNdZD2PPw6U1dcO2uwpMu
 PcQibfjiaRouzv9NT+FTYnG0cW+RTMvM+DucEZx0b6bIY0IlG9/w15Wyx93NHMfOwegI
 TM73ktwGsUqA8cZ5X5s3PEdmihQM8wB3+4/N3Jeu15vZ6VCtHEyfZxb+0UpCmjnTcqT6
 BysjA7UTyC3UmK9w7MRZIoLaGZOY57GjIM3gGEP4nxGj4P8mfcLjEqbeJrml18tY6Q8k
 +zYA==
X-Gm-Message-State: AOJu0YxwemTWmdesuwKaE2F32JWqC9o+WtMd9MGi11/+GUTlkgQV1hYo
 C20SENe4Bw6JthzOogPMSJacORBCyOzwwAyjP2ZpLi64bLVARf429x/l0NQjLuGlu3lkvdQ/wuv
 MkbVJ9kUYwB9AAfN8QDflz4kH3B8ZH17usm7MFRB//z0MdGSqYpxdhqk0hJ86A8+SZcMc7okCGb
 xdMlL6wda3JBEPEV4U+xsQKUJKM+Futc+vKg==
X-Received: by 2002:adf:ebc9:0:b0:351:d7e6:56d5 with SMTP id
 ffacd0b85a97d-351d7e6577amr5870522f8f.71.1716033790145; 
 Sat, 18 May 2024 05:03:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXI2gbbXv0cv96Ko7gtFgjU8TbhApNbQNP0Gu1tW9vEDDLIOVCKHXCrACIE6WxGhVPEd+DvA==
X-Received: by 2002:adf:ebc9:0:b0:351:d7e6:56d5 with SMTP id
 ffacd0b85a97d-351d7e6577amr5870485f8f.71.1716033789558; 
 Sat, 18 May 2024 05:03:09 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b79bc83sm23998446f8f.16.2024.05.18.05.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 05:03:09 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [RESEND PATCH 4/4] omap3: igep0x00: Migrate to use upstream DT
Date: Sat, 18 May 2024 14:02:32 +0200
Message-ID: <20240518120254.204138-5-javierm@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240518120254.204138-1-javierm@redhat.com>
References: <20240518120254.204138-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Sat, 18 May 2024 17:03:12 +0200
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

Enable OF_UPSTREAM to use upstream DT and add a ti/omap/ prefix to the
DEFAULT_DEVICE_TREE config option.

That way, a DTS from the upstream dts/upstream/src/ directory is used
instead of the arch/$(ARCH)/dts/ directory. These in turn are removed.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 arch/arm/dts/Makefile                   |   3 -
 arch/arm/dts/omap3-igep.dtsi            | 247 ----------------------
 arch/arm/dts/omap3-igep0020-common.dtsi | 261 ------------------------
 arch/arm/dts/omap3-igep0020.dts         |  47 -----
 configs/igep00x0_defconfig              |   3 +-
 5 files changed, 2 insertions(+), 559 deletions(-)
 delete mode 100644 arch/arm/dts/omap3-igep.dtsi
 delete mode 100644 arch/arm/dts/omap3-igep0020-common.dtsi
 delete mode 100644 arch/arm/dts/omap3-igep0020.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index a5c82ebf7a5f..a9bd4921718e 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1030,9 +1030,6 @@ dtb-$(CONFIG_TARGET_OMAP3_BEAGLE) += \
 
 dtb-$(CONFIG_TARGET_DEVKIT8000) += omap3-devkit8000.dtb
 
-dtb-$(CONFIG_TARGET_OMAP3_IGEP00X0) += \
-	omap3-igep0020.dtb
-
 dtb-$(CONFIG_TARGET_OMAP4_PANDA) += \
 	omap4-panda.dtb \
 	omap4-panda-es.dtb
diff --git a/arch/arm/dts/omap3-igep.dtsi b/arch/arm/dts/omap3-igep.dtsi
deleted file mode 100644
index 219202610463..000000000000
--- a/arch/arm/dts/omap3-igep.dtsi
+++ /dev/null
@@ -1,247 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Common device tree for IGEP boards based on AM/DM37x
- *
- * Copyright (C) 2012 Javier Martinez Canillas <javier@dowhile0.org>
- * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo@gmail.com>
- */
-/dts-v1/;
-
-#include "omap36xx.dtsi"
-
-/ {
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x80000000 0x20000000>; /* 512 MB */
-	};
-
-	chosen {
-		stdout-path = &uart3;
-	};
-
-	sound {
-		compatible = "ti,omap-twl4030";
-		ti,model = "igep2";
-		ti,mcbsp = <&mcbsp2>;
-	};
-
-	vdd33: regulator-vdd33 {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd33";
-		regulator-always-on;
-	};
-
-};
-
-&omap3_pmx_core {
-	gpmc_pins: pinmux_gpmc_pins {
-		pinctrl-single,pins = <
-			/* OneNAND seems to require PIN_INPUT on clock. */
-                        OMAP3_CORE1_IOPAD(0x20be, PIN_INPUT | MUX_MODE0)        /* gpmc_clk.gpmc_clk */
-		>;
-	};
-
-	uart1_pins: pinmux_uart1_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2182, PIN_INPUT | MUX_MODE0)	/* uart1_rx.uart1_rx */
-			OMAP3_CORE1_IOPAD(0x217c, PIN_OUTPUT | MUX_MODE0)	/* uart1_tx.uart1_tx */
-		>;
-	};
-
-	uart3_pins: pinmux_uart3_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | MUX_MODE0)	/* uart3_rx.uart3_rx */
-			OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)	/* uart3_tx.uart3_tx */
-		>;
-	};
-
-	mcbsp2_pins: pinmux_mcbsp2_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x213c, PIN_INPUT | MUX_MODE0)	/* mcbsp2_fsx.mcbsp2_fsx */
-			OMAP3_CORE1_IOPAD(0x213e, PIN_INPUT | MUX_MODE0)	/* mcbsp2_clkx.mcbsp2_clkx */
-			OMAP3_CORE1_IOPAD(0x2140, PIN_INPUT | MUX_MODE0)	/* mcbsp2_dr.mcbsp2.dr */
-			OMAP3_CORE1_IOPAD(0x2142, PIN_OUTPUT | MUX_MODE0)	/* mcbsp2_dx.mcbsp2_dx */
-		>;
-	};
-
-	mmc1_pins: pinmux_mmc1_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2144, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
-			OMAP3_CORE1_IOPAD(0x2146, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd.sdmmc1_cmd */
-			OMAP3_CORE1_IOPAD(0x2148, PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc1_dat0.sdmmc1_dat0 */
-			OMAP3_CORE1_IOPAD(0x214a, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat1.sdmmc1_dat1 */
-			OMAP3_CORE1_IOPAD(0x214c, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat2.sdmmc1_dat2 */
-			OMAP3_CORE1_IOPAD(0x214e, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat3.sdmmc1_dat3 */
-		>;
-	};
-
-	mmc2_pins: pinmux_mmc2_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2158, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_clk.sdmmc2_clk */
-			OMAP3_CORE1_IOPAD(0x215a, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_cmd.sdmmc2_cmd */
-			OMAP3_CORE1_IOPAD(0x215c, PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat0.sdmmc2_dat0 */
-			OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat1.sdmmc2_dat1 */
-			OMAP3_CORE1_IOPAD(0x2160, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat2.sdmmc2_dat2 */
-			OMAP3_CORE1_IOPAD(0x2162, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat3.sdmmc2_dat3 */
-		>;
-	};
-
-	i2c1_pins: pinmux_i2c1_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21ba, PIN_INPUT | MUX_MODE0)	/* i2c1_scl.i2c1_scl */
-			OMAP3_CORE1_IOPAD(0x21bc, PIN_INPUT | MUX_MODE0)	/* i2c1_sda.i2c1_sda */
-		>;
-	};
-
-	i2c3_pins: pinmux_i2c3_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21c2, PIN_INPUT | MUX_MODE0)	/* i2c3_scl.i2c3_scl */
-			OMAP3_CORE1_IOPAD(0x21c4, PIN_INPUT | MUX_MODE0)	/* i2c3_sda.i2c3_sda */
-		>;
-	};
-};
-
-&gpmc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&gpmc_pins>;
-
-	nand@0,0 {
-		compatible = "ti,omap2-nand";
-		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
-		interrupt-parent = <&gpmc>;
-		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
-			     <1 IRQ_TYPE_NONE>;	/* termcount */
-		linux,mtd-name = "micron,mt29c4g96maz";
-		nand-bus-width = <16>;
-		gpmc,device-width = <2>;
-		ti,nand-ecc-opt = "bch8";
-
-		gpmc,sync-clk-ps = <0>;
-		gpmc,cs-on-ns = <0>;
-		gpmc,cs-rd-off-ns = <44>;
-		gpmc,cs-wr-off-ns = <44>;
-		gpmc,adv-on-ns = <6>;
-		gpmc,adv-rd-off-ns = <34>;
-		gpmc,adv-wr-off-ns = <44>;
-		gpmc,we-off-ns = <40>;
-		gpmc,oe-off-ns = <54>;
-		gpmc,access-ns = <64>;
-		gpmc,rd-cycle-ns = <82>;
-		gpmc,wr-cycle-ns = <82>;
-		gpmc,wr-access-ns = <40>;
-		gpmc,wr-data-mux-bus-ns = <0>;
-
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		status = "okay";
-	};
-
-	onenand@0,0 {
-		compatible = "ti,omap2-onenand";
-		reg = <0 0 0x20000>;	/* CS0, offset 0, IO size 128K */
-
-		gpmc,sync-read;
-		gpmc,sync-write;
-		gpmc,burst-length = <16>;
-		gpmc,burst-wrap;
-		gpmc,burst-read;
-		gpmc,burst-write;
-		gpmc,device-width = <2>; /* GPMC_DEVWIDTH_16BIT */
-		gpmc,mux-add-data = <2>; /* GPMC_MUX_AD */
-		gpmc,cs-on-ns = <0>;
-		gpmc,cs-rd-off-ns = <96>;
-		gpmc,cs-wr-off-ns = <96>;
-		gpmc,adv-on-ns = <0>;
-		gpmc,adv-rd-off-ns = <12>;
-		gpmc,adv-wr-off-ns = <12>;
-		gpmc,oe-on-ns = <18>;
-		gpmc,oe-off-ns = <96>;
-		gpmc,we-on-ns = <0>;
-		gpmc,we-off-ns = <96>;
-		gpmc,rd-cycle-ns = <114>;
-		gpmc,wr-cycle-ns = <114>;
-		gpmc,access-ns = <90>;
-		gpmc,page-burst-access-ns = <12>;
-		gpmc,bus-turnaround-ns = <0>;
-		gpmc,cycle2cycle-delay-ns = <0>;
-		gpmc,wait-monitoring-ns = <0>;
-		gpmc,clk-activation-ns = <6>;
-		gpmc,wr-data-mux-bus-ns = <30>;
-		gpmc,wr-access-ns = <90>;
-		gpmc,sync-clk-ps = <12000>;
-
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		status = "disabled";
-	};
-};
-
-&i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
-	clock-frequency = <2600000>;
-
-	twl: twl@48 {
-		reg = <0x48>;
-		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
-		interrupt-parent = <&intc>;
-
-		twl_audio: audio {
-			compatible = "ti,twl4030-audio";
-			codec {
-			};
-		};
-	};
-};
-
-#include "twl4030.dtsi"
-#include "twl4030_omap3.dtsi"
-
-&i2c3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c3_pins>;
-};
-
-&mcbsp2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mcbsp2_pins>;
-	status = "okay";
-};
-
-&mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins>;
-	vmmc-supply = <&vmmc1>;
-	vmmc_aux-supply = <&vsim>;
-	bus-width = <4>;
-	cd-gpios = <&twl_gpio 0 GPIO_ACTIVE_LOW>;
-};
-
-&mmc3 {
-	status = "disabled";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pins>;
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart3_pins>;
-};
-
-&twl_gpio {
-	ti,use-leds;
-};
-
-&usb_otg_hs {
-	interface-type = <0>;
-	usb-phy = <&usb2_phy>;
-	phys = <&usb2_phy>;
-	phy-names = "usb2-phy";
-	mode = <3>;
-	power = <50>;
-};
diff --git a/arch/arm/dts/omap3-igep0020-common.dtsi b/arch/arm/dts/omap3-igep0020-common.dtsi
deleted file mode 100644
index 73d8f471b9ec..000000000000
--- a/arch/arm/dts/omap3-igep0020-common.dtsi
+++ /dev/null
@@ -1,261 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Common Device Tree Source for IGEPv2
- *
- * Copyright (C) 2014 Javier Martinez Canillas <javier@dowhile0.org>
- * Copyright (C) 2014 Enric Balletbo i Serra <eballetbo@gmail.com>
- */
-
-#include "omap3-igep.dtsi"
-#include "omap-gpmc-smsc9221.dtsi"
-
-/ {
-
-	leds {
-		pinctrl-names = "default";
-		pinctrl-0 = <&leds_pins>;
-		compatible = "gpio-leds";
-
-		boot {
-			 label = "omap3:green:boot";
-			 gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
-			 default-state = "on";
-		};
-
-		user0 {
-			 label = "omap3:red:user0";
-			 gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
-			 default-state = "off";
-		};
-
-		user1 {
-			 label = "omap3:red:user1";
-			 gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
-			 default-state = "off";
-		};
-
-		user2 {
-			label = "omap3:green:user1";
-			gpios = <&twl_gpio 19 GPIO_ACTIVE_LOW>;
-		};
-	};
-
-	/* HS USB Port 1 Power */
-	hsusb1_power: hsusb1_power_reg {
-		compatible = "regulator-fixed";
-		regulator-name = "hsusb1_vbus";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&twl_gpio 18 GPIO_ACTIVE_LOW>;	/* GPIO LEDA */
-		startup-delay-us = <70000>;
-	};
-
-	/* HS USB Host PHY on PORT 1 */
-	hsusb1_phy: hsusb1_phy {
-		compatible = "usb-nop-xceiv";
-		reset-gpios = <&gpio1 24 GPIO_ACTIVE_LOW>; /* gpio_24 */
-		vcc-supply = <&hsusb1_power>;
-		#phy-cells = <0>;
-	};
-
-	tfp410: encoder {
-		compatible = "ti,tfp410";
-		powerdown-gpios = <&gpio6 10 GPIO_ACTIVE_LOW>; /* gpio_170 */
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-
-				tfp410_in: endpoint {
-					remote-endpoint = <&dpi_out>;
-				};
-			};
-
-			port@1 {
-				reg = <1>;
-
-				tfp410_out: endpoint {
-					remote-endpoint = <&dvi_connector_in>;
-				};
-			};
-		};
-	};
-
-	dvi0: connector {
-		compatible = "dvi-connector";
-		label = "dvi";
-
-		digital;
-
-		ddc-i2c-bus = <&i2c3>;
-
-		port {
-			dvi_connector_in: endpoint {
-				remote-endpoint = <&tfp410_out>;
-			};
-		};
-	};
-};
-
-&omap3_pmx_core {
-	pinctrl-names = "default";
-	pinctrl-0 = <
-		&tfp410_pins
-		&dss_dpi_pins
-	>;
-
-	tfp410_pins: pinmux_tfp410_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21c6, PIN_OUTPUT | MUX_MODE4)   /* hdq_sio.gpio_170 */
-		>;
-	};
-
-	dss_dpi_pins: pinmux_dss_dpi_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x20d4, PIN_OUTPUT | MUX_MODE0)   /* dss_pclk.dss_pclk */
-			OMAP3_CORE1_IOPAD(0x20d6, PIN_OUTPUT | MUX_MODE0)   /* dss_hsync.dss_hsync */
-			OMAP3_CORE1_IOPAD(0x20d8, PIN_OUTPUT | MUX_MODE0)   /* dss_vsync.dss_vsync */
-			OMAP3_CORE1_IOPAD(0x20da, PIN_OUTPUT | MUX_MODE0)   /* dss_acbias.dss_acbias */
-			OMAP3_CORE1_IOPAD(0x20dc, PIN_OUTPUT | MUX_MODE0)   /* dss_data0.dss_data0 */
-			OMAP3_CORE1_IOPAD(0x20de, PIN_OUTPUT | MUX_MODE0)   /* dss_data1.dss_data1 */
-			OMAP3_CORE1_IOPAD(0x20e0, PIN_OUTPUT | MUX_MODE0)   /* dss_data2.dss_data2 */
-			OMAP3_CORE1_IOPAD(0x20e2, PIN_OUTPUT | MUX_MODE0)   /* dss_data3.dss_data3 */
-			OMAP3_CORE1_IOPAD(0x20e4, PIN_OUTPUT | MUX_MODE0)   /* dss_data4.dss_data4 */
-			OMAP3_CORE1_IOPAD(0x20e6, PIN_OUTPUT | MUX_MODE0)   /* dss_data5.dss_data5 */
-			OMAP3_CORE1_IOPAD(0x20e8, PIN_OUTPUT | MUX_MODE0)   /* dss_data6.dss_data6 */
-			OMAP3_CORE1_IOPAD(0x20ea, PIN_OUTPUT | MUX_MODE0)   /* dss_data7.dss_data7 */
-			OMAP3_CORE1_IOPAD(0x20ec, PIN_OUTPUT | MUX_MODE0)   /* dss_data8.dss_data8 */
-			OMAP3_CORE1_IOPAD(0x20ee, PIN_OUTPUT | MUX_MODE0)   /* dss_data9.dss_data9 */
-			OMAP3_CORE1_IOPAD(0x20f0, PIN_OUTPUT | MUX_MODE0)   /* dss_data10.dss_data10 */
-			OMAP3_CORE1_IOPAD(0x20f2, PIN_OUTPUT | MUX_MODE0)   /* dss_data11.dss_data11 */
-			OMAP3_CORE1_IOPAD(0x20f4, PIN_OUTPUT | MUX_MODE0)   /* dss_data12.dss_data12 */
-			OMAP3_CORE1_IOPAD(0x20f6, PIN_OUTPUT | MUX_MODE0)   /* dss_data13.dss_data13 */
-			OMAP3_CORE1_IOPAD(0x20f8, PIN_OUTPUT | MUX_MODE0)   /* dss_data14.dss_data14 */
-			OMAP3_CORE1_IOPAD(0x20fa, PIN_OUTPUT | MUX_MODE0)   /* dss_data15.dss_data15 */
-			OMAP3_CORE1_IOPAD(0x20fc, PIN_OUTPUT | MUX_MODE0)   /* dss_data16.dss_data16 */
-			OMAP3_CORE1_IOPAD(0x20fe, PIN_OUTPUT | MUX_MODE0)   /* dss_data17.dss_data17 */
-			OMAP3_CORE1_IOPAD(0x2100, PIN_OUTPUT | MUX_MODE0)   /* dss_data18.dss_data18 */
-			OMAP3_CORE1_IOPAD(0x2102, PIN_OUTPUT | MUX_MODE0)   /* dss_data19.dss_data19 */
-			OMAP3_CORE1_IOPAD(0x2104, PIN_OUTPUT | MUX_MODE0)   /* dss_data20.dss_data20 */
-			OMAP3_CORE1_IOPAD(0x2106, PIN_OUTPUT | MUX_MODE0)   /* dss_data21.dss_data21 */
-			OMAP3_CORE1_IOPAD(0x2108, PIN_OUTPUT | MUX_MODE0)   /* dss_data22.dss_data22 */
-			OMAP3_CORE1_IOPAD(0x210a, PIN_OUTPUT | MUX_MODE0)   /* dss_data23.dss_data23 */
-		>;
-	};
-
-	uart2_pins: pinmux_uart2_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2174, PIN_INPUT | MUX_MODE0)	/* uart2_cts.uart2_cts */
-			OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT | MUX_MODE0)	/* uart2_rts .uart2_rts*/
-			OMAP3_CORE1_IOPAD(0x2178, PIN_OUTPUT | MUX_MODE0)	/* uart2_tx.uart2_tx */
-			OMAP3_CORE1_IOPAD(0x217a, PIN_INPUT | MUX_MODE0)	/* uart2_rx.uart2_rx */
-		>;
-	};
-
-	smsc9221_pins: pinmux_smsc9221_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21d2, PIN_INPUT | MUX_MODE4)	/* mcspi1_cs2.gpio_176 */
-		>;
-	};
-};
-
-&omap3_pmx_core2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <
-		&hsusbb1_pins
-	>;
-
-	hsusbb1_pins: pinmux_hsusbb1_pins {
-		pinctrl-single,pins = <
-			OMAP3630_CORE2_IOPAD(0x25da, PIN_OUTPUT | MUX_MODE3)		/* etk_ctl.hsusb1_clk */
-			OMAP3630_CORE2_IOPAD(0x25d8, PIN_OUTPUT | MUX_MODE3)		/* etk_clk.hsusb1_stp */
-			OMAP3630_CORE2_IOPAD(0x25ec, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d8.hsusb1_dir */
-			OMAP3630_CORE2_IOPAD(0x25ee, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d9.hsusb1_nxt */
-			OMAP3630_CORE2_IOPAD(0x25dc, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d0.hsusb1_data0 */
-			OMAP3630_CORE2_IOPAD(0x25de, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d1.hsusb1_data1 */
-			OMAP3630_CORE2_IOPAD(0x25e0, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d2.hsusb1_data2 */
-			OMAP3630_CORE2_IOPAD(0x25e2, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d3.hsusb1_data7 */
-			OMAP3630_CORE2_IOPAD(0x25e4, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d4.hsusb1_data4 */
-			OMAP3630_CORE2_IOPAD(0x25e6, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d5.hsusb1_data5 */
-			OMAP3630_CORE2_IOPAD(0x25e8, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d6.hsusb1_data6 */
-			OMAP3630_CORE2_IOPAD(0x25ea, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d7.hsusb1_data3 */
-		>;
-	};
-
-	leds_pins: pinmux_leds_pins {
-		pinctrl-single,pins = <
-			OMAP3630_CORE2_IOPAD(0x25f4, PIN_OUTPUT | MUX_MODE4) /* etk_d12.gpio_26 */
-			OMAP3630_CORE2_IOPAD(0x25f6, PIN_OUTPUT | MUX_MODE4) /* etk_d13.gpio_27 */
-			OMAP3630_CORE2_IOPAD(0x25f8, PIN_OUTPUT | MUX_MODE4) /* etk_d14.gpio_28 */
-		>;
-	};
-
-	mmc1_wp_pins: pinmux_mmc1_cd_pins {
-		pinctrl-single,pins = <
-			OMAP3630_CORE2_IOPAD(0x25fa, PIN_INPUT | MUX_MODE4)   /* etk_d15.gpio_29 */
-		>;
-	};
-};
-
-&i2c3 {
-	clock-frequency = <100000>;
-
-	/*
-	 * Display monitor features are burnt in the EEPROM
-	 * as EDID data.
-	 */
-	eeprom@50 {
-		compatible = "ti,eeprom";
-		reg = <0x50>;
-	};
-};
-
-&gpmc {
-	ranges = <0 0 0x30000000 0x01000000>,	/* CS0: 16MB for NAND */
-		 <5 0 0x2c000000 0x01000000>;	/* CS5: 16MB for ethernet */
-
-	ethernet@gpmc {
-		pinctrl-names = "default";
-		pinctrl-0 = <&smsc9221_pins>;
-		reg = <5 0 0xff>;
-		interrupt-parent = <&gpio6>;
-		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
-	};
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart2_pins>;
-};
-
-&usbhshost {
-	port1-mode = "ehci-phy";
-};
-
-&usbhsehci {
-	phys = <&hsusb1_phy>;
-};
-
-&vpll2 {
-	/* Needed for DSS */
-	regulator-name = "vdds_dsi";
-};
-
-&dss {
-	status = "okay";
-
-	port {
-		dpi_out: endpoint {
-			remote-endpoint = <&tfp410_in>;
-			data-lines = <24>;
-		};
-	};
-};
-
-&mmc1 {
-	pinctrl-0 = <&mmc1_pins &mmc1_wp_pins>;
-	wp-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;	/* gpio_29 */
-};
diff --git a/arch/arm/dts/omap3-igep0020.dts b/arch/arm/dts/omap3-igep0020.dts
deleted file mode 100644
index cf3ac847431e..000000000000
--- a/arch/arm/dts/omap3-igep0020.dts
+++ /dev/null
@@ -1,47 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Device Tree Source for IGEPv2 Rev. C (TI OMAP AM/DM37x)
- *
- * Copyright (C) 2012 Javier Martinez Canillas <javier@dowhile0.org>
- * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo@gmail.com>
- */
-
-#include "omap3-igep0020-common.dtsi"
-
-/ {
-	model = "IGEPv2 Rev. C (TI OMAP AM/DM37x)";
-	compatible = "isee,omap3-igep0020", "ti,omap36xx", "ti,omap3";
-
-	vmmcsdio_fixed: fixedregulator-mmcsdio {
-		compatible = "regulator-fixed";
-		regulator-name = "vmmcsdio_fixed";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	mmc2_pwrseq: mmc2_pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&gpio5 11 GPIO_ACTIVE_LOW>,	/* gpio_139 - RESET_N_W */
-			      <&gpio5 10 GPIO_ACTIVE_LOW>;	/* gpio_138 - WIFI_PDN */
-	};
-};
-
-&omap3_pmx_core {
-	lbee1usjyc_pins: pinmux_lbee1usjyc_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2166, PIN_OUTPUT | MUX_MODE4)	/* sdmmc2_dat5.gpio_137 - RESET_N_W */
-			OMAP3_CORE1_IOPAD(0x2168, PIN_OUTPUT | MUX_MODE4)	/* sdmmc2_dat6.gpio_138 - WIFI_PDN */
-			OMAP3_CORE1_IOPAD(0x216a, PIN_OUTPUT | MUX_MODE4)	/* sdmmc2_dat7.gpio_139 - RST_N_B */
-		>;
-	};
-};
-
-/* On board Wifi module */
-&mmc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_pins &lbee1usjyc_pins>;
-	vmmc-supply = <&vmmcsdio_fixed>;
-	mmc-pwrseq = <&mmc2_pwrseq>;
-	bus-width = <4>;
-	non-removable;
-};
diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
index c1b873a17efb..87fd2797eace 100644
--- a/configs/igep00x0_defconfig
+++ b/configs/igep00x0_defconfig
@@ -8,7 +8,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4020ff00
 CONFIG_ENV_SIZE=0x8000
-CONFIG_DEFAULT_DEVICE_TREE="omap3-igep0020"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/omap3-igep0020"
 CONFIG_SPL_TEXT_BASE=0x40200000
 CONFIG_TARGET_OMAP3_IGEP00X0=y
 CONFIG_SYS_MONITOR_LEN=262144
@@ -56,6 +56,7 @@ CONFIG_CMD_UBI=y
 CONFIG_SPL_PARTITION_UUIDS=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="clocks clock-names interrupt-parent"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_UBI=y
-- 
2.45.0

