Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C531C4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 23:19:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4C3288348;
	Mon, 22 Apr 2024 01:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713741553;
	bh=tTGky+sweKCxCwum/51kWPFM3El8KJporZoNYofW5rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T9ZCsYlMa6EzajkAtQsll5FX7x2oAJzsmW8HMNJJTdrDJtFOrY7ftG/YDY9L8raF6
	 GTJm55GLsLfWYEOPIgAItRaMW0L6fD/SRcy2evfSB0VGPUlIcX8H4x5ywiP/qaZnaQ
	 9vQUCI68JF7qGSmbGNvWeJuqTU9qdeMQMP/rnfykfIXU0N60+0nkkFCsHxYAKypnbw
	 2p9aWiMGZn7K/DDklqgz7b1ZEMKLpMPP0YBYgfp03AGXkmXWxTm8cLkmXwdkC2Puhi
	 5Cxd46sD8fZm3cDMVE/shYkGapv9bbRLOeC6VACYGjj/JWg/7aFNiGHfYkJBCNT0rD
	 IbCvyAxc+GBtg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8B47A88310;
 Mon, 22 Apr 2024 01:19:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713741548;
 bh=tTGky+sweKCxCwum/51kWPFM3El8KJporZoNYofW5rw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RwosACj7Jl/u9Gdw+f6sQ2dko3heOmCq6ukETuBCox8LnVXIH/XH+K9i7g2z+K4y/
 fPify82BtK5UEUkDNTVzrwH/pmN/L8dO0T2IMqF48o69M5pPmWbJpeHCt53elb1EwW
 SkRcmnGfAlDGLkaCYL665v8b2wYlx6mD5z2LcYkeRLLiBMIuGaTLYjy/PFV+EuBDWk
 aIsXSE3wCWYh2l3l+fQ9P+TxORr+8bXPdfjBqJ1pPbfjC+xwUjo6MQlQmwD9UMEU7P
 DonJxthgA7CpcQyH34NKaqZEx+YPZUsOjw7o3A4DpkQfpTPl9Sv5zEgtVszLsL1jGe
 GVv+BqBU95Olw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 05/19] ARM: dts: stm32: Add alternate pinmux for MP13 I2C5 pins
Date: Mon, 22 Apr 2024 01:16:51 +0200
Message-ID: <20240421231849.194648-5-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240421231849.194648-1-marex@denx.de>
References: <20240421231849.194648-1-marex@denx.de>
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

Add another mux option for I2C5 pins, this is used on
DH electronics STM32MP13xx DHCOR DHSBC board.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp13-pinctrl.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/dts/stm32mp13-pinctrl.dtsi b/arch/arm/dts/stm32mp13-pinctrl.dtsi
index 899f0f98e1a..cfbae71efc7 100644
--- a/arch/arm/dts/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/dts/stm32mp13-pinctrl.dtsi
@@ -151,6 +151,23 @@
 		};
 	};
 
+	i2c5_pins_b: i2c5-1 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 1, AF4)>, /* I2C5_SCL */
+				 <STM32_PINMUX('E', 13, AF4)>; /* I2C5_SDA */
+			bias-disable;
+			drive-open-drain;
+			slew-rate = <0>;
+		};
+	};
+
+	i2c5_sleep_pins_b: i2c5-sleep-1 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 1, ANALOG)>, /* I2C5_SCL */
+				 <STM32_PINMUX('E', 13, ANALOG)>; /* I2C5_SDA */
+		};
+	};
+
 	mcp23017_pins_a: mcp23017-0 {
 		pins {
 			pinmux = <STM32_PINMUX('G', 12, GPIO)>;
-- 
2.43.0

