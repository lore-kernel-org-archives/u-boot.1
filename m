Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52333CE8E8B
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 15:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5709E8901C;
	Thu, 24 Oct 2024 17:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6128088FAF; Thu, 24 Oct 2024 17:26:16 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id A502689017
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 17:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.11,229,1725289200"; d="scan'208";a="226888030"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 25 Oct 2024 00:26:06 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.183])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3296540065A3;
 Fri, 25 Oct 2024 00:25:53 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 14/14] arm64: dts: renesas: rzg2l: Set Ethernet PVDD to 1.8V
Date: Thu, 24 Oct 2024 16:24:48 +0100
Message-Id: <20241024152448.102-15-paul.barker.ct@bp.renesas.com>
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

On the RZ/G2L & RZ/V2L SMARC SOMs, the RGMII interface between the SoC
and the Ethernet PHY operates at 1.8V.

The power supply for this interface may be correctly configured in
u-boot, but the kernel should not be relying on this. Now that the
RZ/G2L pinctrl driver supports configuring the Ethernet power supply
voltage, we can simply specify the desired voltage in the device tree.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/20240625200316.4282-8-paul.barker.ct@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

[ upstream commit: 96a3f525708120379013d9d3265663c07ceb38d5 ]

(cherry picked from commit c535103b52a1edf50309dcbd1948d56520e84a1e)
---
 .../src/arm64/renesas/rzg2l-smarc-som.dtsi     | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/dts/upstream/src/arm64/renesas/rzg2l-smarc-som.dtsi b/dts/upstream/src/arm64/renesas/rzg2l-smarc-som.dtsi
index 2b5e037ea9fa..83f5642d0d35 100644
--- a/dts/upstream/src/arm64/renesas/rzg2l-smarc-som.dtsi
+++ b/dts/upstream/src/arm64/renesas/rzg2l-smarc-som.dtsi
@@ -182,6 +182,7 @@
 	eth0_pins: eth0 {
 		txc {
 			pinmux = <RZG2L_PORT_PINMUX(20, 0, 1)>; /* ET0_TXC */
+			power-source = <1800>;
 			output-enable;
 		};
 
@@ -199,14 +200,19 @@
 				 <RZG2L_PORT_PINMUX(25, 0, 1)>, /* ET0_RXD0 */
 				 <RZG2L_PORT_PINMUX(25, 1, 1)>, /* ET0_RXD1 */
 				 <RZG2L_PORT_PINMUX(26, 0, 1)>, /* ET0_RXD2 */
-				 <RZG2L_PORT_PINMUX(26, 1, 1)>, /* ET0_RXD3 */
-				 <RZG2L_PORT_PINMUX(1, 0, 1)>;  /* IRQ2 */
+				 <RZG2L_PORT_PINMUX(26, 1, 1)>; /* ET0_RXD3 */
+			power-source = <1800>;
+		};
+
+		irq {
+			pinmux = <RZG2L_PORT_PINMUX(1, 0, 1)>;  /* IRQ2 */
 		};
 	};
 
 	eth1_pins: eth1 {
 		txc {
 			pinmux = <RZG2L_PORT_PINMUX(29, 0, 1)>; /* ET1_TXC */
+			power-source = <1800>;
 			output-enable;
 		};
 
@@ -224,8 +230,12 @@
 				 <RZG2L_PORT_PINMUX(34, 1, 1)>, /* ET1_RXD0 */
 				 <RZG2L_PORT_PINMUX(35, 0, 1)>, /* ET1_RXD1 */
 				 <RZG2L_PORT_PINMUX(35, 1, 1)>, /* ET1_RXD2 */
-				 <RZG2L_PORT_PINMUX(36, 0, 1)>, /* ET1_RXD3 */
-				 <RZG2L_PORT_PINMUX(1, 1, 1)>;  /* IRQ3 */
+				 <RZG2L_PORT_PINMUX(36, 0, 1)>; /* ET1_RXD3 */
+			power-source = <1800>;
+		};
+
+		irq {
+			pinmux = <RZG2L_PORT_PINMUX(1, 1, 1)>;  /* IRQ3 */
 		};
 	};
 
-- 
2.43.0

