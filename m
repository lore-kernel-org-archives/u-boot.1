Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F03C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 20:17:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9371A82E67;
	Thu, 26 Jun 2025 22:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="HFL8yzHy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEAC682E34; Thu, 26 Jun 2025 18:20:40 +0200 (CEST)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF6FC82E08
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 18:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.gantois@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8BEA844284;
 Thu, 26 Jun 2025 16:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1750954836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bsgvRaOxs84LNCXb8RdPb4aAhtJGgvSjW7uuU3Pmf98=;
 b=HFL8yzHyHUvqGHvN7C6FG/stUFnsOV9RKMwvwnC8Or+3MIlpkB6jbEPtbu8A90XNnKupvQ
 fAQYCMDsV+qbzRPxT7zBFAH1FoHoduOv/K6oWAm+ezZAdcMI/7JrLpK1IbEylDTqvHsg9g
 SsztWJWvd+s8tBIjV8G1CKkGXWKl7idts1Y5TjZegui1lD+VIF39APudA7ScqhrQ5ZyCTO
 qey5CWuY1iflcRe3LrbBpdvUf+Z1KHthkMCbGdpphO9VpAOM5kKim5hXNNMCfcaJqTTzJB
 jT1nRk8wOYshFsLdedzKr4BKc36Pvf4bjL/hp5NY8NkEuJhNs/sVRz3TjrkWAQ==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Thu, 26 Jun 2025 18:20:25 +0200
Subject: [PATCH 2/2] board: ti: am33xx: Add Ethernet support for Beaglebone
 Green Eco
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-bbge-ethernet-v1-2-5b544fb1898f@bootlin.com>
References: <20250626-bbge-ethernet-v1-0-5b544fb1898f@bootlin.com>
In-Reply-To: <20250626-bbge-ethernet-v1-0-5b544fb1898f@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: "Bajjuri, Praneeth" <praneeth@ti.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Miguel Gazquez <miguel.gazquez@bootlin.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeigecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeftohhmrghinhcuifgrnhhtohhishcuoehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepkeelieefteelffeuheevtdetkefhfffhteffkefgtefhkeevudeutdeugfffheegnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudefngdpmhgrihhlfhhrohhmpehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepjhhovgdrhhgvrhhshhgsvghrghgvrhesnhhirdgtohhmpdhrtghpthhtohepthhhohhmrghsrdgsohhnnhgvfhhilhhlvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehrfhhrihgvugdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdprhgtphhtthhopehmihhguhgvlhdrghgriihquhgvi
 iessghoohhtlhhinhdrtghomhdprhgtphhtthhopehprhgrnhgvvghthhesthhirdgtohhmpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtoheprhhomhgrihhnrdhgrghnthhoihhssegsohhothhlihhnrdgtohhm
X-GND-Sasl: romain.gantois@bootlin.com
X-Mailman-Approved-At: Thu, 26 Jun 2025 22:17:29 +0200
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

Currently, the Ethernet interface of the BBGE board isn't properly
supported.

To support this interface, describe the MAC<->PHY RGMII link and the
DP83867 PHY in the BBGE device tree. Enable the DP83867 PHY driver in
U-Boot Proper and mux the relevant RGMII lines.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 arch/arm/dts/am335x-bonegreen-eco.dts | 19 +++++++++++++++++++
 board/ti/am335x/mux.c                 |  3 +++
 configs/am335x_evm_defconfig          |  1 +
 3 files changed, 23 insertions(+)

diff --git a/arch/arm/dts/am335x-bonegreen-eco.dts b/arch/arm/dts/am335x-bonegreen-eco.dts
index f3363d1ebccccead39b82ce40f1f80022b399201..1e9d7fed3fd46f35cd4f92783ffeb81bd878d055 100644
--- a/arch/arm/dts/am335x-bonegreen-eco.dts
+++ b/arch/arm/dts/am335x-bonegreen-eco.dts
@@ -7,6 +7,7 @@
 #include "am33xx.dtsi"
 #include "am335x-bone-common.dtsi"
 #include "am335x-bonegreen-common.dtsi"
+#include <dt-bindings/net/ti-dp83867.h>
 
 / {
 	model = "TI AM335x BeagleBone Green Eco";
@@ -25,6 +26,24 @@
 	interrupt-names = "mc";
 };
 
+&cpsw_emac0 {
+	phy-mode = "rgmii-id";
+	phy-handle = <&dp83867_0>;
+};
+
+&davinci_mdio {
+	/delete-node/ ethernet-phy@0;
+
+	dp83867_0: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_50_NS>;
+		ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_50_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_8_B_NIB>;
+		ti,min-output-impedance;
+		ti,dp83867-rxctrl-strap-quirk;
+	};
+};
+
 &baseboard_eeprom {
 	/delete-property/ vcc-supply;
 };
diff --git a/board/ti/am335x/mux.c b/board/ti/am335x/mux.c
index 960de15398f8173bf8a5d55beb3536f97465c38d..4daa59697b17e230ac21ce4c38633b2545ac7788 100644
--- a/board/ti/am335x/mux.c
+++ b/board/ti/am335x/mux.c
@@ -408,6 +408,9 @@ void enable_board_pin_mux(void)
 
 			if (subtype_id == 'L')
 				configure_module_pin_mux(spi0_pin_mux);
+		} else if (board_is_bbge()) {
+			/* Beaglebone Green Eco pinmux */
+			configure_module_pin_mux(rgmii1_pin_mux);
 		} else {
 			/* Beaglebone LT pinmux */
 			configure_module_pin_mux(mii1_pin_mux);
diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index 674ad6c06ee75ba3def2397602891c84adee876f..7cd0ffa4dfa8322b78f4a148ed98dd6240f9a8c0 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -91,6 +91,7 @@ CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_PHY_ATHEROS=y
 CONFIG_PHY_SMSC=y
+CONFIG_PHY_TI_DP83867=y
 CONFIG_PHY_GIGE=y
 CONFIG_MII=y
 CONFIG_DRIVER_TI_CPSW=y

-- 
2.49.0

