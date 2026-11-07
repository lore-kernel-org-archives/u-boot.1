Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3D9606A333
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ygvdXHLc;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=MsNxgaGX
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C0AC608DC;
	Sat,  7 Nov 2026 14:33:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id poiNf73o3McE; Sat,  7 Nov 2026 14:33:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AFD20607DA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062007;
	b=N/DBiAnTpFyz5PSP/fFkcYEQu52974Oili14s9/rr/eXgpWwVXsyx8T3G35rHekrvh8R
	 lSgBulbkXoKI8n1W2B46Xca+FGh2puFmIwmbMd7kH6gK6przvPuybClT8twDcPzRBmpnD
	 5cWgQRNAK0yXsqnsESGp8AhOH14CUXihvS1pDulhl9sJPYs+D5WR/HsdE2VdVBaOHZpUu
	 BSxp0axyIDRvGca1ctb46d4KjRgeLbP1Zno9ksk8ClfiyaHzXi5LrveYGK6sQQPwhXskE
	 pxmsnDGxL7Sw2Oyr1ewwXFgg0vcQhDHOZRMkJgxqJZ8nyCkuSZicKJvMKBaBDFW82sw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062007;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3IIbAtDGnH/sencc33nqYq044lgrBpfFVd5EVu+OwDg=;
	b=sECQgXslys3QoSrBFcLTugxV47IL0tztw5Sv2d5etSPpenuV88ymaVZSGhY3eyhvxyyr
	 SXpvjf25fiUIfQHlGlTpWlmqhrmyl/c4IgB9LaI6nrnYPWrJJEuG+ZLYutIDezwUkCmxA
	 fLlziKY+3xjnSz0K/T6IJB2eC6CSmpviwtghoCvdJDSE7E0K1AEaOLi3uBcig3E4aaa/3
	 et5M0qzbN4eI/EFrRQ1Zfk72ZB0M/PTaJUGWrg3h+FohXpMWi3QCF6iX5L3nz1gLMzkTj
	 ew6goc1xpe4mLEoJzxjfGD9Cw8JyByyzvDhI51kb11Bc9a5yJtWOC3KMcf99f0f3mxA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062007;
	bh=3IIbAtDGnH/sencc33nqYq044lgrBpfFVd5EVu+OwDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ygvdXHLcQeQ9Aq8/NnYIh3iJ/iHuMPRRBYnhve1rMXpqfiq8plqVBzb6kY4A5xRdL
	 I9yIVCNAu8JrR8mqIWRoaV6MzXdbmg1ZODE0T+6VtZ8Brzhhbper9Zm3R3tXk3+EHz
	 AzFIGIzuJQ5mm20jZvBI6ZYRJo/jfsaZZY4V5hQb6NcYusDoH+xyvAMLm34WmX9zDk
	 HgCKq2Zgp4I8ZDGiw0YpitIUz03UvTtQ15YTHHHBJk3FBOiTZrnTyMe3giawCZURSr
	 HJNkPVhEMj2iudMArokrupQOS+N11NtSpeLaD/yvHM8B36QewByVsNQiOkQPoGdh9C
	 JIvoGMjTdSseg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFD20607DA;
	Sat,  7 Nov 2026 14:33:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5377834D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 45232400E5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r9BBZQWRF1bG for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D97314009B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=MsNxgaGX
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D97314009B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:18 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so17190065e9.1
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794061996; x=1794666796;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3IIbAtDGnH/sencc33nqYq044lgrBpfFVd5EVu+OwDg=;
 b=MsNxgaGXhxEkXoWI5e0pxbjlmEqz3W9l/S7wI7RokNfuqMM38zUgk327QeYLAdc0Xy
 pNqw/srmFs6H6qrBxgddS3K22cTdmwQcqUphKp+NUbbA3eMZv4oCyXII1JgD6fvkDhYn
 DzoTkEyIRjES3btJ0qBkaA9pOKq6uPG2eXc/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794061996; x=1794666796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3IIbAtDGnH/sencc33nqYq044lgrBpfFVd5EVu+OwDg=;
 b=qHMYYu9xdc582+fB/6q+QHemRvuc8CSchSXK+GP/Pyb9MRrp+2DDPI41Xr1lNaVD5y
 lPiPukgwG2TIw/pN6QeNKnhAaMGeC5BLfj28ebnFZjI9RfcsxQuxqUsTESWciMFfjKQ1
 hhInRlNs25ios7VfA1pZxo8Cpn4mW+/49j9qNDSjfpHMespiOanw/oFHyfHjuOn4PsWt
 42hjavGfinRTxQjxbxl+cIUcJUJjHU33HU/MXa411rnqbxf9zauIz+7pBihl5V37yMa7
 eDYpWA1VD18DyMK+renhfTrFSwdeRaDXUSOXasmpy9O46AC8CpIZLfOU0c7/japaGGIX
 SerQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlXr93MOby8q00Icks5BYVNAd7CdfoeLL4JJzzQepOLTMYAchzhEt97J3D8ESLYdAdHhIvKvQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8i0NxasoiRDh5av9iNBEw4lakFHp1REfDMUw9Wo7WIweJGAN69
 nFYmyJewYl0q05bMHH5KL7bShq770VVdvcm/or7oCNFxyoKTGA/QWcoYR2/WZLdM3Ug=
X-Gm-Gg: AYBFou0M6iADpA5SMmYIobmCpVpAgg59z0Y6CdAVSryum+LGeNX3jeCGkvxuZgpcVHe
 NNVL0IIvDWo0jvvDFQGEyCghvy3VriVhNLQ0/UH0XLlV3o7KAFXLshP5Tj8ZNmxj+5EXNynQt1o
 9cfey8aWMv93xNBcB6cCtx6dQTd5IWfbx1usW+L/YErm1EqkOxmpFeEqYfUn3L8fKpGhm/c61Mx
 V3mJNiARrHAg+fbXTuuI5Psh4QOrtzViITOBJGt9ISKvaFlrzxJ6vRndp3PBNnpV+/6LnVqNmbs
 Xju+DHpfrBoR9lS7H044tnm4+XNWPcHVXpIeSxKBa8rwmSYssdekd21WY7g7sZHVBZrDGg71Cnu
 gdX+1sBga1/GN48WOOSMf+drSKONKsDoz4aiig2PSrIUUQeqgigF3LYgRmaEzaD0UTNqavioT79
 IiusSr4CmCrwbnyqiLTnA1n/1drqsyrV0IISBDi5SLTG6V/rR9q+BIbie89mH5181LSDjrF0l/T
 gm8m0C8l261f0LSKFLywjBu4pFXA0lUWW3978sba8upashBHaU7bmXAulGeWaCKTJE/rXb9NOXS
 qMdzfvjV2ePUTtpY8mMaIs04fDPICSKaVBuM/DZ3fcM+3n1CvU1hsBFSu7kQ36d5gC21kzPRe5b
 U9LlifikQE2mQeiugpNvWbl2lpOWlY5PNA3MiRPuZNScRSp14HjSQ/vGX3OBRLW3BYepoi2fQxt
 7yLK8K5LRM1AhPYqEl1vG9jEAJqIA=
X-Received: by 2002:a05:600c:620c:b0:4a1:813f:2a60 with SMTP id
 5b1f17b1804b1-4b6dea6881fmr96794695e9.11.1794061996385; 
 Sat, 07 Nov 2026 06:33:16 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:15 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 15/35] arm64: dts: st: support Engicam
 MicroGEA-STM32MP257D-RMM board
Date: Sat,  7 Nov 2026 15:32:05 +0100
Message-ID: <20261107143241.2236511-16-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Support for Engicam MicroGEA-STM32MP257D-RMM board with:

 - 8 GB eMMC Flash
 - 2 GB LPDDR4 DRAM
 - CAN
 - LEDs
 - LCD panel with touchscreen
 - Micro SD card connector
 - Audio codec
 - Buzzer

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-16-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: bc7b07bda4e0dbb70c8cac0532691c39602390b8 ]

(cherry picked from commit 435db86022032d69ff48f5e0aae57169d700b02f)
---

(no changes since v1)

 .../st/stm32mp257d-engicam-microgea-rmm.dts   | 319 ++++++++++++++++++
 1 file changed, 319 insertions(+)
 create mode 100644 dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts

diff --git a/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts b/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts
new file mode 100644
index 000000000000..f5af0913bf1b
--- /dev/null
+++ b/dts/upstream/src/arm64/st/stm32mp257d-engicam-microgea-rmm.dts
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ * Copyright (C) 2026 Engicam srl
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+#include "stm32mp257-engicam-microgea.dtsi"
+
+/ {
+	model = "Engicam MicroGEA STM32MP257D RMM Board";
+	compatible = "engicam,microgea-stm32mp257d-rmm",
+		     "engicam,microgea-stm32mp257", "st,stm32mp257";
+
+	aliases {
+		mmc0 = &sdmmc1;
+		mmc1 = &sdmmc2;
+		serial0 = &usart2;
+		serial1 = &usart1;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		brightness-levels = <0 100>;
+		num-interpolated-steps = <100>;
+		default-brightness-level = <85>;
+		pwms = <&pwm2 0 100000 0>;
+	};
+
+	buzzer {
+		compatible = "pwm-beeper";
+		pwms = <&pwm4 0 1000000 0>;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		framebuffer {
+			compatible = "simple-framebuffer";
+			clocks = <&rcc CK_BUS_LTDC>, <&rcc CK_KER_LTDC>;
+			lcd-supply = <&reg_3v3>;
+			status = "disabled";
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			gpios = <&gpioh 2 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			status = "okay";
+		};
+
+		led-1 {
+			gpios = <&gpioh 6 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			status = "okay";
+		};
+	};
+
+	mclk: clock-mclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
+
+	reg_1v8: regulator-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_ext_pwr: regulator-ext-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "ext-pwr";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpiog 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	sound {
+		compatible = "audio-graph-card";
+		label = "STM32MP25-RMM";
+		widgets = "Headphone", "Headphone Jack",
+			  "Microphone", "Microphone Jack";
+		routing = "Headphone Jack", "HP_OUT",
+			  "MIC_IN", "Microphone Jack",
+			  "Microphone Jack", "Mic Bias";
+		dais = <&sai1a_port &sai1b_port>;
+		status = "okay";
+	};
+};
+
+&arm_wdt {
+	timeout-sec = <32>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-1 = <&i2c1_sleep_pins_a>;
+	i2c-scl-rising-time-ns = <185>;
+	i2c-scl-falling-time-ns = <20>;
+	status = "okay";
+	/* spare dmas for other usage */
+	/delete-property/dmas;
+	/delete-property/dma-names;
+
+	touchscreen@38 {
+		compatible = "edt,edt-ft5306";
+		reg = <0x38>;
+		interrupt-parent = <&gpiob>;
+		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpiod 1 GPIO_ACTIVE_LOW>;
+		touchscreen-size-x = <480>;
+		touchscreen-size-y = <854>;
+	};
+};
+
+&i2c2 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-1 = <&i2c2_sleep_pins_a>;
+	i2c-scl-rising-time-ns = <185>;
+	i2c-scl-falling-time-ns = <20>;
+	status = "okay";
+	/* spare dmas for other usage */
+	/delete-property/dmas;
+	/delete-property/dma-names;
+
+	sgtl5000: codec@a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		#sound-dai-cells = <0>;
+		clocks = <&mclk>;
+
+		VDDA-supply = <&reg_3v3>;
+		VDDIO-supply = <&reg_3v3>;
+		VDDD-supply = <&reg_1v8>;
+
+		sgtl5000_port: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			sgtl5000_tx_endpoint: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&sai1a_endpoint>;
+				frame-master = <&sgtl5000_tx_endpoint>;
+				bitclock-master = <&sgtl5000_tx_endpoint>;
+			};
+
+			sgtl5000_rx_endpoint: endpoint@1 {
+				reg = <1>;
+				remote-endpoint = <&sai1b_endpoint>;
+				frame-master = <&sgtl5000_rx_endpoint>;
+				bitclock-master = <&sgtl5000_rx_endpoint>;
+			};
+		};
+	};
+};
+
+&ltdc {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&ltdc_pins_a>;
+	pinctrl-1 = <&ltdc_sleep_pins_a>;
+	status = "okay";
+
+	port {
+		ltdc_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
+};
+
+&m_can1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&m_can1_pins_a>;
+	pinctrl-1 = <&m_can1_sleep_pins_a>;
+	status = "okay";
+};
+
+&sai1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sai1a_pins_a>, <&sai1b_pins_a>;
+	pinctrl-1 = <&sai1a_sleep_pins_a>, <&sai1b_sleep_pins_a>;
+	status = "okay";
+};
+
+&sai1a {
+	dma-names = "tx";
+	status = "okay";
+
+	sai1a_port: port {
+		sai1a_endpoint: endpoint {
+			remote-endpoint = <&sgtl5000_tx_endpoint>;
+			dai-format = "i2s";
+			mclk-fs = <512>;
+		};
+	};
+};
+
+&sai1b {
+	dma-names = "rx";
+	st,sync = <&sai1a 2>;
+	clocks = <&rcc CK_KER_SAI1>;
+	clock-names = "sai_ck";
+	status = "okay";
+
+	sai1b_port: port {
+		sai1b_endpoint: endpoint {
+			remote-endpoint = <&sgtl5000_rx_endpoint>;
+			dai-format = "i2s";
+			mclk-fs = <512>;
+		};
+	};
+};
+
+/* MicroSD */
+&sdmmc1 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc1_b4_pins_a>;
+	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
+	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
+	broken-cd;
+	disable-wp;
+	st,neg-edge;
+	bus-width = <4>;
+	vmmc-supply = <&scmi_v3v3>;
+	vqmmc-supply = <&scmi_vddio1>;
+	no-1-8-v;
+	status = "okay";
+};
+
+&spi1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&spi1_pins_a>;
+	pinctrl-1 = <&spi1_sleep_pins_a>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cs-gpios = <&gpioh 8 GPIO_ACTIVE_LOW>, <&gpioh 3 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	display: display@0 {
+		compatible = "rocktech,rk050hr345-ct106a", "ilitek,ili9806e";
+		reg = <0>;
+		vdd-supply = <&reg_3v3>;
+		spi-max-frequency = <10000000>;
+		reset-gpios = <&gpiob 6 GPIO_ACTIVE_LOW>;
+		backlight = <&backlight>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&ltdc_out>;
+			};
+		};
+	};
+};
+
+&timers2 {
+	status = "okay";
+
+	pwm2: pwm {
+		pinctrl-0 = <&pwm2_pins_a>;
+		pinctrl-1 = <&pwm2_sleep_pins_a>;
+		pinctrl-names = "default", "sleep";
+		status = "okay";
+	};
+};
+
+&timers4 {
+	status = "okay";
+
+	pwm4: pwm {
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&pwm4_pins_a>;
+		pinctrl-1 = <&pwm4_sleep_pins_a>;
+		status = "okay";
+	};
+};
+
+&usart1 {
+	pinctrl-names = "default", "idle", "sleep";
+	pinctrl-0 = <&usart1_pins_b>;
+	pinctrl-1 = <&usart1_idle_pins_b>;
+	pinctrl-2 = <&usart1_sleep_pins_b>;
+	/delete-property/ dmas;
+	/delete-property/ dma-names;
+	status = "okay";
+};
+
+&usart2 {
+	pinctrl-names = "default", "idle", "sleep";
+	pinctrl-0 = <&usart2_pins_a>;
+	pinctrl-1 = <&usart2_idle_pins_a>;
+	pinctrl-2 = <&usart2_sleep_pins_a>;
+	/delete-property/ dmas;
+	/delete-property/ dma-names;
+	status = "okay";
+};
-- 
2.43.0

