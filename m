Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013A7C3DA44
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 12:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFF1488775;
	Mon,  8 Jul 2024 14:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GyCSopKo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CEDC886AF; Mon,  8 Jul 2024 09:52:38 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F272988650
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 09:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-kochidanadu@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4687qJV4082381;
 Mon, 8 Jul 2024 02:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720425139;
 bh=GRsJpNmhQ3/6vQsAkm6809WrPrOlHXXnohhY5mU+Fzg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=GyCSopKoPQyQdDgwXlR/FZYyhwH+HplzLigSBMVBluwXNaRmpy1rTdhATM8yNZfmg
 l2d/ekIAAnZcFFVRIEE9ZGAp4xQcMdEziv6U/ja5yxO7+i309hXHUBWgNqDw5XHqTj
 WNWAPvMixpp2sTpSyUT0EQdih24a9+N3Yp1oAoSQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4687qJws041425
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Jul 2024 02:52:19 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jul 2024 02:52:19 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jul 2024 02:52:19 -0500
Received: from localhost (scaria-hp-zbook-15-g5.dhcp.ti.com [172.24.31.134])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4687qHQQ116020;
 Mon, 8 Jul 2024 02:52:18 -0500
From: Scaria Kochidanadu <s-kochidanadu@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <sjg@chromium.org>, <mkorpershoek@baylibre.com>,
 <abdellatif.elkhlifi@arm.com>, <sumit.garg@linaro.org>,
 <neil.armstrong@linaro.org>, <caleb.connolly@linaro.org>,
 <semen.protsenko@linaro.org>, <marek.vasut+renesas@mailbox.org>,
 <nathan.morrison@timesys.com>, <s-kochidanadu@ti.com>,
 <devarsht@ti.com>, <j-luthra@ti.com>, <vigneshr@ti.com>,
 <praneeth@ti.com>, <nm@ti.com>, <khasim@ti.com>, <rogerq@kernel.org>,
 <francesco.dolcini@toradex.com>, <afd@ti.com>, <jan.kiszka@siemens.com>
Subject: [PATCH 4/6] arm: dts: k3-am625-sk-u-boot.dtsi: Add sound driver nodes
Date: Mon, 8 Jul 2024 13:22:05 +0530
Message-ID: <20240708075207.37207-5-s-kochidanadu@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240708075207.37207-1-s-kochidanadu@ti.com>
References: <20240708075207.37207-1-s-kochidanadu@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Mon, 08 Jul 2024 14:24:51 +0200
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

Update the am625-sk-u-boot device tree to incorporate the sound card and
sound drivers: MCASP and TLV320AIC3106 Codec

Signed-off-by: Scaria Kochidanadu <s-kochidanadu@ti.com>
---
 arch/arm/dts/k3-am625-sk-u-boot.dtsi | 85 ++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
index fa778b0ff4..74c273d940 100644
--- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
@@ -10,6 +10,91 @@
 	chosen {
 		tick-timer = &main_timer0;
 	};
+
+	tlv320_mclk: clk-0 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <12288000>;
+	};
+
+	codec_audio: sound {
+		compatible = "simple-audio-card";
+		ti,codec = <&tlv320aic3106>;
+		simple-audio-card,name = "AM62x-SKEVM";
+		simple-audio-card,widgets =
+		"Headphone",    "Headphone Jack",
+		"Line",         "Line In",
+		"Microphone",   "Microphone Jack";
+		simple-audio-card,routing =
+		"Headphone Jack",       "HPLOUT",
+		"Headphone Jack",       "HPROUT",
+		"LINE1L",               "Line In",
+		"LINE1R",               "Line In",
+		"MIC3R",                "Microphone Jack",
+		"Microphone Jack",      "Mic Bias";
+		simple-audio-card,format = "dsp_b";
+		simple-audio-card,bitclock-master = <&sound_master>;
+		simple-audio-card,frame-master = <&sound_master>;
+		simple-audio-card,bitclock-inversion;
+
+		simple-audio-card,cpu {
+		sound-dai = <&mcasp1>;
+		};
+
+		sound_master: simple-audio-card,codec {
+		sound-dai = <&tlv320aic3106>;
+		clocks = <&tlv320_mclk>;
+		};
+	};
+};
+
+&mcasp1 {
+	status = "okay";
+	#sound-dai-cells = <0>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcasp1_pins_default>;
+
+	op-mode = <0>;          /* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+
+	ti,i2s-epll-clock-frequency = <96000000>;
+	ti,i2s-sampling-rate = <48000>;
+	ti,i2s-bits-per-sample = <16>;
+	ti,i2s-channels = <2>;
+	ti,i2s-lr-clk-framesize = <256>;
+	ti,i2s-bit-clk-framesize = <32>;
+	ti,i2s-id = <0>;
+
+	serial-dir = <
+	       1 0 2 0
+	       0 0 0 0
+	       0 0 0 0
+	       0 0 0 0
+	>;              /* 0: INACTIVE, 1: TX, 2: RX */
+	tx-num-evt = <0>;
+	rx-num-evt = <0>;
+};
+
+&main_i2c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c1_pins_default>;
+	clock-frequency = <100000>;
+
+	tlv320aic3106: audio-codec@1b {
+		#sound-dai-cells = <0>;
+		compatible = "ti,tlv320aic3106";
+		reg = <0x1b>;
+		ai3x-micbias-vg = <1>;  /* 2.0V */
+		ai3x-ocmv = <1>;
+
+		/* Regulators */
+		AVDD-supply = <&vcc_3v3_sys>;
+		IOVDD-supply = <&vcc_3v3_sys>;
+		DRVDD-supply = <&vcc_3v3_sys>;
+		DVDD-supply = <&vcc_1v8>;
+	};
 };
 
 &main_timer0 {
-- 
2.34.1

