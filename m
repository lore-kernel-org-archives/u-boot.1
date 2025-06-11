Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490BAC61CE7
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 08:59:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6E7C82C44;
	Wed, 11 Jun 2025 10:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2F6882BAA; Wed, 11 Jun 2025 10:59:46 +0200 (CEST)
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::190d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D2CD80050
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 10:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bHKNc0qVRzrZ9;
 Wed, 11 Jun 2025 10:59:44 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4bHKNb0KDyzrsY; Wed, 11 Jun 2025 10:59:43 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 11 Jun 2025 10:59:31 +0200
Subject: [PATCH 1/3] arm64: dts: rockchip: add basic mdio node to px30
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-ringneck-mdio-v1-1-529a40a0f966@cherry.de>
References: <20250611-ringneck-mdio-v1-0-529a40a0f966@cherry.de>
In-Reply-To: <20250611-ringneck-mdio-v1-0-529a40a0f966@cherry.de>
To: Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Klaus Goger <klaus.goger@cherry.de>
Cc: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
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

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Using snps,reset-* properties for handling the phy-reset is deprecated
and instead a real phy node should be defined that then contains the
reset-gpios handling.

To facilitate this, add the core mdio node under the px30's gmac, similar
to how the other Rockchip socs already do this.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Link: https://lore.kernel.org/r/20250514150745.2437804-2-heiko@sntech.de
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: ede4837a504ca7e5811217060aa8300b8d0cf7f2 ]

(cherry picked from commit cb54a264ecdb9e95b1529e4542e157cb9acded30)
---
 dts/upstream/src/arm64/rockchip/px30.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/px30.dtsi b/dts/upstream/src/arm64/rockchip/px30.dtsi
index 9137dd76e72cedb0cfbf1995032e5852cab80f96..feabdadfa440f96c0134a0bb05e64a0c7b5adf2e 100644
--- a/dts/upstream/src/arm64/rockchip/px30.dtsi
+++ b/dts/upstream/src/arm64/rockchip/px30.dtsi
@@ -985,6 +985,12 @@
 		resets = <&cru SRST_GMAC_A>;
 		reset-names = "stmmaceth";
 		status = "disabled";
+
+		mdio: mdio {
+			compatible = "snps,dwmac-mdio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
 	};
 
 	sdmmc: mmc@ff370000 {

-- 
2.49.0

