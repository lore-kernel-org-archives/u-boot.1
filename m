Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F697CDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 12:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD4BC86BE0;
	Mon, 16 Oct 2023 14:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697460672;
	bh=tY5N9O6vqGP/DBk23Oa9V72u0Wqgel6/CON0zYlNd6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=johBetnfSv7M765FneYF9KfzZcXOED8kgzArMTdRwOCQ67a5pKucg1TPnPJLOjcdu
	 vpzmgbBHqlitX6t/0tk1WX8lFgNbNVY2E4g0AD4jAvITHNZsgBwgEuiqMXrbVTuBEH
	 yvFJ+8Sm4bA+AJDmEyIcOPvcsG5MQweWEjs9Yx7KdczWKUOKmaQg0SIvjA8p0A54at
	 eMZAX9kPK9GfCrf0UXLYObcs8HjKQ3zbfw/CBCB3ubM9VtD2Lg9EQjuH0R6LvWjV4D
	 rlNmeiuq55I/1Tj6y0tZf4aF6udUKTnEUzGTPyd9gDrpZy0mVlvFIYu8pBXqXo0IwC
	 llW8iHe3veaUA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0246986BF2;
 Mon, 16 Oct 2023 14:51:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697460663;
 bh=tY5N9O6vqGP/DBk23Oa9V72u0Wqgel6/CON0zYlNd6E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LHiF6oE9xbFYU6lywl+jI/pPUz6GrfoRdbOT2DpWrwm2nCwL3gD450zl2V3J4G7+m
 8uzQtN8aEoro+LhRpU9Pw7ySJigABbaIloo6zbuW3EwLdFKtW4BcfD6ZsSTj+mLdov
 yQRaxS+J1fyPfrhjqzURcMs1ZnZ4Z7o9oSPUzTR6DyFFUEFGcwb1R3nh5VV80QGogO
 l1aWrXvPS/HPStItRMV4Cbg2Qm7qteISUJgU7dJbTqS5HeSkJxJP7YU/PgFU2Ir3OW
 eHOhqhs0Z/824JPv54AbQ2caq/W2agrlCdzvYecNnmqtShDOazgSCpUnGMpxUDVXmY
 tMkyYWnLD6iFQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 u-boot@dh-electronics.com
Subject: [PATCH v2 7/7] arm64: dts: imx8mp: Describe M24C32-D write-lockable
 page in DH i.MX8MP DHCOM DT
Date: Mon, 16 Oct 2023 14:50:08 +0200
Message-ID: <20231016125019.21583-7-marex@denx.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016125019.21583-1-marex@denx.de>
References: <20231016125019.21583-1-marex@denx.de>
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

The i.MX8MP DHCOM SoM production rev.200 is populated with M24C32-D
EEPROMs which have Additional Write lockable page at separate I2C
address. Describe the page in DT to make it available.

Disable the additional page in rev.100 SoM DTO as those devices
contain EEPROM without an Additional Write lockable page.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@dh-electronics.com
---
V2: Rebase and collect the patches in one series
---
 arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts |  8 ++++++++
 arch/arm/dts/imx8mp-dhcom-som.dtsi               | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts b/arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts
index 5d9a00c9429..0e5d329b149 100644
--- a/arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts
+++ b/arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts
@@ -24,6 +24,14 @@
 	pagesize = <16>;
 };
 
+&eeprom0wl {
+	status = "disabled";
+};
+
+&eeprom1wl {
+	status = "disabled";
+};
+
 &ethphy0f { /* SMSC LAN8740Ai */
 	pinctrl-0 = <&pinctrl_ethphy0 &pinctrl_ioexp>;
 	reset-gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/dts/imx8mp-dhcom-som.dtsi b/arch/arm/dts/imx8mp-dhcom-som.dtsi
index ea2a567447a..b504d36818b 100644
--- a/arch/arm/dts/imx8mp-dhcom-som.dtsi
+++ b/arch/arm/dts/imx8mp-dhcom-som.dtsi
@@ -392,6 +392,18 @@
 		reg = <0x53>;
 	};
 
+	eeprom0wl: eeprom@58 {
+		compatible = "atmel,24c32d-wl";	/* M24C32-D WL page of 0x50 */
+		pagesize = <32>;
+		reg = <0x58>;
+	};
+
+	eeprom1wl: eeprom@5b {
+		compatible = "atmel,24c32d-wl";	/* M24C32-D WL page of 0x53 */
+		pagesize = <32>;
+		reg = <0x5b>;
+	};
+
 	ioexp: gpio@74 {
 		compatible = "nxp,pca9539";
 		reg = <0x74>;
-- 
2.42.0

