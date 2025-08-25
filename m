Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F83CA0EFA
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 13:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADBEB82FC7;
	Mon, 25 Aug 2025 15:55:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="BBG+Kpmc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7C5A82DA1; Mon, 25 Aug 2025 15:55:44 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C10E082FC7
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:55:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2214EC994D; Mon, 25 Aug 2025 15:55:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1756130142; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=FdzlvFWRCOK0BeqgM33kDI6bQHpuvTmLQHif9qMvfaw=;
 b=BBG+KpmcsLjRfRiOd8kNUXqoX9Y+NGB90Q6zvGro4HK6vxu9zxFLY65HI3UcvK+ifj7zHZ
 PuCiK/qTQksoiFYxvoaKMC8MEhBOAkQhe4O8h+R6SEslvj3x7+sQO5btfBaBev4Jo2cjT2
 8SAbJ+5YFWkMqNsrGZI+Xwakluzhw18uPy0xc2gw7zAaIp5TTNDTvaNhO05f80bjLYgKeO
 sSJDFZwtB1HnQpe72QkbWHs1G5ETfU2Q11mSiEtVRPw9CTo3Z0yv6DlcUt7AIji3Qg5t1H
 QxMRU4QDo8ZhBcSVkGW+uEJdQSdOXSs5ZL8f6BOmm8k/09MGjezkL396UxVugg==
From: Frieder Schrempf <frieder@fris.de>
To: Fabio Estevam <festevam@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Subject: [PATCH 04/11] imx: kontron-sl-mx6ul: Enable second ethernet interface
Date: Mon, 25 Aug 2025 15:54:28 +0200
Message-ID: <20250825135504.193004-5-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825135504.193004-1-frieder@fris.de>
References: <20250825135504.193004-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This ensures both interfaces can be used in U-Boot and both MAC addresses
are exported to the Linux kernel devicetree.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm/dts/imx6ul-kontron-bl-common-u-boot.dtsi | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/imx6ul-kontron-bl-common-u-boot.dtsi b/arch/arm/dts/imx6ul-kontron-bl-common-u-boot.dtsi
index 39cc6d05d3f..042bda7462a 100644
--- a/arch/arm/dts/imx6ul-kontron-bl-common-u-boot.dtsi
+++ b/arch/arm/dts/imx6ul-kontron-bl-common-u-boot.dtsi
@@ -30,9 +30,6 @@
  * in Linux we can't assign the shared reset GPIO to the PHYs, as this
  * would cause Linux to reset both PHYs every time one of them gets
  * reinitialized.
- *
- * Also we disable the second ethernet as it currently doesn't work with
- * the devicetree setup in U-Boot.
  */
 
 &fec1 {
@@ -53,11 +50,16 @@
 			clocks = <&clks IMX6UL_CLK_ENET_REF>;
 			clock-names = "rmii-ref";
 		};
+
+		ethphy2: ethernet-phy@2 {
+			reg = <2>;
+			micrel,led-mode = <0>;
+			clocks = <&clks IMX6UL_CLK_ENET2_REF>;
+			clock-names = "rmii-ref";
+		};
 	};
 };
 
 &fec2 {
-	status = "disabled";
-	/delete-property/ phy-handle;
 	/delete-node/ mdio;
 };
-- 
2.50.1

