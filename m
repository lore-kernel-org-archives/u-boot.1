Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13CACE8E8B
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 15:27:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6B3989070;
	Thu, 24 Oct 2024 17:26:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B8B188FE4; Thu, 24 Oct 2024 17:26:02 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id D8C3388F48
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 17:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.11,229,1725289200"; d="scan'208";a="222903837"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 25 Oct 2024 00:25:53 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.183])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 02C37400388C;
 Fri, 25 Oct 2024 00:25:49 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 13/14] arm64: dts: renesas: rzg2l: Enable Ethernet TXC output
Date: Thu, 24 Oct 2024 16:24:47 +0100
Message-Id: <20241024152448.102-14-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
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

Configure ET0_TXC and ET1_TXC as outputs on the Renesas RZ/[GV]2L SMARC
SoMs, as per RGMII specification.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/20240625200316.4282-5-paul.barker.ct@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

[ upstream commit: 41c934da488d3a5a79148ead3b5c5eecac1b1d5d ]

(cherry picked from commit 11cbf7bc3124f3d5267ea6aef8e4ba6d6b4f589e)
---
 .../src/arm64/renesas/rzg2l-smarc-som.dtsi    | 76 +++++++++++--------
 1 file changed, 44 insertions(+), 32 deletions(-)

diff --git a/dts/upstream/src/arm64/renesas/rzg2l-smarc-som.dtsi b/dts/upstream/src/arm64/renesas/rzg2l-smarc-som.dtsi
index 4409c47239b9..2b5e037ea9fa 100644
--- a/dts/upstream/src/arm64/renesas/rzg2l-smarc-som.dtsi
+++ b/dts/upstream/src/arm64/renesas/rzg2l-smarc-som.dtsi
@@ -180,41 +180,53 @@
 	};
 
 	eth0_pins: eth0 {
-		pinmux = <RZG2L_PORT_PINMUX(28, 1, 1)>, /* ET0_LINKSTA */
-			 <RZG2L_PORT_PINMUX(27, 1, 1)>, /* ET0_MDC */
-			 <RZG2L_PORT_PINMUX(28, 0, 1)>, /* ET0_MDIO */
-			 <RZG2L_PORT_PINMUX(20, 0, 1)>, /* ET0_TXC */
-			 <RZG2L_PORT_PINMUX(20, 1, 1)>, /* ET0_TX_CTL */
-			 <RZG2L_PORT_PINMUX(20, 2, 1)>, /* ET0_TXD0 */
-			 <RZG2L_PORT_PINMUX(21, 0, 1)>, /* ET0_TXD1 */
-			 <RZG2L_PORT_PINMUX(21, 1, 1)>, /* ET0_TXD2 */
-			 <RZG2L_PORT_PINMUX(22, 0, 1)>, /* ET0_TXD3 */
-			 <RZG2L_PORT_PINMUX(24, 0, 1)>, /* ET0_RXC */
-			 <RZG2L_PORT_PINMUX(24, 1, 1)>, /* ET0_RX_CTL */
-			 <RZG2L_PORT_PINMUX(25, 0, 1)>, /* ET0_RXD0 */
-			 <RZG2L_PORT_PINMUX(25, 1, 1)>, /* ET0_RXD1 */
-			 <RZG2L_PORT_PINMUX(26, 0, 1)>, /* ET0_RXD2 */
-			 <RZG2L_PORT_PINMUX(26, 1, 1)>, /* ET0_RXD3 */
-			 <RZG2L_PORT_PINMUX(1, 0, 1)>;  /* IRQ2 */
+		txc {
+			pinmux = <RZG2L_PORT_PINMUX(20, 0, 1)>; /* ET0_TXC */
+			output-enable;
+		};
+
+		mux {
+			pinmux = <RZG2L_PORT_PINMUX(28, 1, 1)>, /* ET0_LINKSTA */
+				 <RZG2L_PORT_PINMUX(27, 1, 1)>, /* ET0_MDC */
+				 <RZG2L_PORT_PINMUX(28, 0, 1)>, /* ET0_MDIO */
+				 <RZG2L_PORT_PINMUX(20, 1, 1)>, /* ET0_TX_CTL */
+				 <RZG2L_PORT_PINMUX(20, 2, 1)>, /* ET0_TXD0 */
+				 <RZG2L_PORT_PINMUX(21, 0, 1)>, /* ET0_TXD1 */
+				 <RZG2L_PORT_PINMUX(21, 1, 1)>, /* ET0_TXD2 */
+				 <RZG2L_PORT_PINMUX(22, 0, 1)>, /* ET0_TXD3 */
+				 <RZG2L_PORT_PINMUX(24, 0, 1)>, /* ET0_RXC */
+				 <RZG2L_PORT_PINMUX(24, 1, 1)>, /* ET0_RX_CTL */
+				 <RZG2L_PORT_PINMUX(25, 0, 1)>, /* ET0_RXD0 */
+				 <RZG2L_PORT_PINMUX(25, 1, 1)>, /* ET0_RXD1 */
+				 <RZG2L_PORT_PINMUX(26, 0, 1)>, /* ET0_RXD2 */
+				 <RZG2L_PORT_PINMUX(26, 1, 1)>, /* ET0_RXD3 */
+				 <RZG2L_PORT_PINMUX(1, 0, 1)>;  /* IRQ2 */
+		};
 	};
 
 	eth1_pins: eth1 {
-		pinmux = <RZG2L_PORT_PINMUX(37, 2, 1)>, /* ET1_LINKSTA */
-			 <RZG2L_PORT_PINMUX(37, 0, 1)>, /* ET1_MDC */
-			 <RZG2L_PORT_PINMUX(37, 1, 1)>, /* ET1_MDIO */
-			 <RZG2L_PORT_PINMUX(29, 0, 1)>, /* ET1_TXC */
-			 <RZG2L_PORT_PINMUX(29, 1, 1)>, /* ET1_TX_CTL */
-			 <RZG2L_PORT_PINMUX(30, 0, 1)>, /* ET1_TXD0 */
-			 <RZG2L_PORT_PINMUX(30, 1, 1)>, /* ET1_TXD1 */
-			 <RZG2L_PORT_PINMUX(31, 0, 1)>, /* ET1_TXD2 */
-			 <RZG2L_PORT_PINMUX(31, 1, 1)>, /* ET1_TXD3 */
-			 <RZG2L_PORT_PINMUX(33, 1, 1)>, /* ET1_RXC */
-			 <RZG2L_PORT_PINMUX(34, 0, 1)>, /* ET1_RX_CTL */
-			 <RZG2L_PORT_PINMUX(34, 1, 1)>, /* ET1_RXD0 */
-			 <RZG2L_PORT_PINMUX(35, 0, 1)>, /* ET1_RXD1 */
-			 <RZG2L_PORT_PINMUX(35, 1, 1)>, /* ET1_RXD2 */
-			 <RZG2L_PORT_PINMUX(36, 0, 1)>, /* ET1_RXD3 */
-			 <RZG2L_PORT_PINMUX(1, 1, 1)>;  /* IRQ3 */
+		txc {
+			pinmux = <RZG2L_PORT_PINMUX(29, 0, 1)>; /* ET1_TXC */
+			output-enable;
+		};
+
+		mux {
+			pinmux = <RZG2L_PORT_PINMUX(37, 2, 1)>, /* ET1_LINKSTA */
+				 <RZG2L_PORT_PINMUX(37, 0, 1)>, /* ET1_MDC */
+				 <RZG2L_PORT_PINMUX(37, 1, 1)>, /* ET1_MDIO */
+				 <RZG2L_PORT_PINMUX(29, 1, 1)>, /* ET1_TX_CTL */
+				 <RZG2L_PORT_PINMUX(30, 0, 1)>, /* ET1_TXD0 */
+				 <RZG2L_PORT_PINMUX(30, 1, 1)>, /* ET1_TXD1 */
+				 <RZG2L_PORT_PINMUX(31, 0, 1)>, /* ET1_TXD2 */
+				 <RZG2L_PORT_PINMUX(31, 1, 1)>, /* ET1_TXD3 */
+				 <RZG2L_PORT_PINMUX(33, 1, 1)>, /* ET1_RXC */
+				 <RZG2L_PORT_PINMUX(34, 0, 1)>, /* ET1_RX_CTL */
+				 <RZG2L_PORT_PINMUX(34, 1, 1)>, /* ET1_RXD0 */
+				 <RZG2L_PORT_PINMUX(35, 0, 1)>, /* ET1_RXD1 */
+				 <RZG2L_PORT_PINMUX(35, 1, 1)>, /* ET1_RXD2 */
+				 <RZG2L_PORT_PINMUX(36, 0, 1)>, /* ET1_RXD3 */
+				 <RZG2L_PORT_PINMUX(1, 1, 1)>;  /* IRQ3 */
+		};
 	};
 
 	gpio-sd0-pwr-en-hog {
-- 
2.43.0

