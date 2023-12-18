Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D7AC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 18:02:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8E47870B5;
	Mon, 18 Dec 2023 19:02:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1702922571;
	bh=RqFhPSVrspqCzB0/EjtzJ32RWvHmh7+alDtcBjuWdyQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=H+4AAta8Mo8WapD2Ad9IG3JT6bWNwXNfRhiV3vsZz7CuJaHZm0fsWhHh8HA9ToZ5l
	 8m2xoC9FCmihdTsFOu5+n+CjAWjVzq4tsnlV97ibHniEnOsabTg0TPveE2BSSZeoF7
	 6xlPqVKVKuBTJCp25N8oZw7wtxAYu9Jwz5ExPPzZcjuD3WDSKu9Ct1hZVjXDj1qXqW
	 qa67uZDLO71YcA8KK1W2Z3BS+QHiJjWr9Hy60twpMeL0HmP4HnPZjNiRe+9ZTS5AAy
	 EvM/ShHH/I0tpDoXCp7qsvQ6ymXHTqkyCz4dqvhIo300TJ1Yr/hgLB5yoxDX3MM7NH
	 NFAMtHQqHACZA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E16C4807A7;
 Mon, 18 Dec 2023 19:02:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1702922570;
 bh=RqFhPSVrspqCzB0/EjtzJ32RWvHmh7+alDtcBjuWdyQ=;
 h=From:To:Cc:Subject:Date:From;
 b=uLwMTHng0ISurRVd63PRDkJBudhlDEQTSicdpOEYycnmlIvXDip04GxTEIgBNr1Kl
 AN5PUreFMhms6El94CzK04rhPny80D9qDm7ZnvUwgh+9nQiWqsUXM4a6+z4bqLxf2M
 NLmtaR8FgkCb3j60EKmgk6QWd3PVAcJRNg4rmXxFnPP2lFwp6knz2B/9LzkNjxXqpw
 1IKNjAQDgqNpjPsXY4t+qbMBp0WpfzUOJm74wnvnBKdfItTZnPxi/E4rO2EkjYEJ/M
 mKyEozOiExeALaUhNJnELiViR5LiXoBb2j5eNRfldfUVaRcua4njH8Rq2XgOSwBSWy
 6TAcOvZltY7jQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH] ARM: dts: imx: Power off display output on Data Modul i.MX8M
 Mini/Plus eDM SBC
Date: Mon, 18 Dec 2023 19:02:14 +0100
Message-ID: <20231218180226.37685-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Turn display connector power off on boot and reboot to prevent any
bogus start up sequence of any panel potentially attached to the
display connector.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Stefano Babic <sbabic@denx.de>
---
 .../dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi | 49 +++++++++++++++++++
 .../dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi | 48 ++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi b/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi
index 144c42b2103..a235e088fa4 100644
--- a/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi
@@ -77,10 +77,59 @@
 
 &gpio2 {
 	bootph-pre-ram;
+
+	dsi-reset-hog {
+		bootph-pre-ram;
+		gpio-hog;
+		output-high;
+		gpios = <2 GPIO_ACTIVE_LOW>;
+		line-name = "DSI_RESET_1V8#";
+	};
+
+
+	dsi-irq-hog {
+		bootph-pre-ram;
+		gpio-hog;
+		input;
+		gpios = <3 GPIO_ACTIVE_LOW>;
+		line-name = "DSI_IRQ_1V8#";
+	};
+
+	graphics-prsnt-hog {
+		bootph-pre-ram;
+		gpio-hog;
+		input;
+		gpios = <7 GPIO_ACTIVE_LOW>;
+		line-name = "GRAPHICS_PRSNT_1V8#";
+	};
 };
 
 &gpio3 {
 	bootph-pre-ram;
+
+	bl-enable-hog {
+		bootph-pre-ram;
+		gpio-hog;
+		output-low;
+		gpios = <0 GPIO_ACTIVE_HIGH>;
+		line-name = "BL_ENABLE_1V8";
+	};
+
+	tft-enable-hog {
+		bootph-pre-ram;
+		gpio-hog;
+		output-low;
+		gpios = <6 GPIO_ACTIVE_HIGH>;
+		line-name = "TFT_ENABLE_1V8";
+	};
+
+	graphics-gpio0-hog {
+		bootph-pre-ram;
+		gpio-hog;
+		input;
+		gpios = <7 GPIO_ACTIVE_HIGH>;
+		line-name = "GRAPHICS_GPIO0_1V8";
+	};
 };
 
 &gpio4 {
diff --git a/arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi b/arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi
index eafe9b9308c..a2b5976b6bd 100644
--- a/arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi
@@ -67,10 +67,58 @@
 
 &gpio3 {
 	bootph-pre-ram;
+
+	bl-enable-hog {
+		bootph-pre-ram;
+		gpio-hog;
+		output-low;
+		gpios = <0 GPIO_ACTIVE_HIGH>;
+		line-name = "BL_ENABLE_1V8";
+	};
+
+	tft-enable-hog {
+		bootph-pre-ram;
+		gpio-hog;
+		output-low;
+		gpios = <6 GPIO_ACTIVE_HIGH>;
+		line-name = "TFT_ENABLE_1V8";
+	};
+
+	graphics-gpio0-hog {
+		bootph-pre-ram;
+		gpio-hog;
+		input;
+		gpios = <7 GPIO_ACTIVE_HIGH>;
+		line-name = "GRAPHICS_GPIO0_1V8";
+	};
 };
 
 &gpio4 {
 	bootph-pre-ram;
+
+	dsi-reset-hog {
+		bootph-pre-ram;
+		gpio-hog;
+		output-high;
+		gpios = <0 GPIO_ACTIVE_LOW>;
+		line-name = "DSI_RESET_1V8#";
+	};
+
+	graphics-prsnt-hog {
+		bootph-pre-ram;
+		gpio-hog;
+		input;
+		gpios = <18 GPIO_ACTIVE_LOW>;
+		line-name = "GRAPHICS_PRSNT_1V8#";
+	};
+
+	dsi-irq-hog {
+		bootph-pre-ram;
+		gpio-hog;
+		input;
+		gpios = <19 GPIO_ACTIVE_LOW>;
+		line-name = "DSI_IRQ_1V8#";
+	};
 };
 
 &gpio5 {
-- 
2.43.0

