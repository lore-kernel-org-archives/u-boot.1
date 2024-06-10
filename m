Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF593C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 13:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D59C188511;
	Mon, 10 Jun 2024 15:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38B418854A; Mon, 10 Jun 2024 15:14:03 +0200 (CEST)
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch
 [84.16.66.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5D808852A
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 15:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VyXLv2pTWzJ3K;
 Mon, 10 Jun 2024 15:13:59 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VyXLt4l8XzGWN; Mon, 10 Jun 2024 15:13:58 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 10 Jun 2024 15:13:32 +0200
Subject: [PATCH next v3 2/8] arm64: dts: rockchip: move uart2 pinmux to
 dtsi on rk3588-tiger
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-tiger-v3-2-2b4731f95757@cherry.de>
References: <20240610-tiger-v3-0-2b4731f95757@cherry.de>
In-Reply-To: <20240610-tiger-v3-0-2b4731f95757@cherry.de>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Klaus Goger <klaus.goger@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Stuebner <heiko@sntech.de>, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14-dev-a6ee3
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

The association of uart2 to the q7-uart pins is part of the module
itself and not the baseboard used. Therefore move the pinctrl over
to the tiger dtsi.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Link: https://lore.kernel.org/r/20240422143356.2596414-1-heiko@sntech.de
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 5adbad5c464a708a87cf5ade1bfe2ca947bb2f82 ]

(cherry picked from commit f8314a4fbc00a3d651a7e9b4d9462d10c6c02a12)
---
 dts/upstream/src/arm64/rockchip/rk3588-tiger-haikou.dts | 1 -
 dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi       | 5 +++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3588-tiger-haikou.dts b/dts/upstream/src/arm64/rockchip/rk3588-tiger-haikou.dts
index d672198c6b6..9bdd14799ef 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588-tiger-haikou.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3588-tiger-haikou.dts
@@ -231,7 +231,6 @@
 };
 
 &uart2 {
-	pinctrl-0 = <&uart2m2_xfer>;
 	status = "okay";
 };
 
diff --git a/dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi b/dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi
index 72fe696b003..4984e36a8c2 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi
@@ -688,6 +688,11 @@
 	status = "okay";
 };
 
+/* Routed to UART0 on the Q7 connector */
+&uart2 {
+	pinctrl-0 = <&uart2m2_xfer>;
+};
+
 /* Mule-ATtiny UPDI */
 &uart4 {
 	pinctrl-0 = <&uart4m2_xfer>;

-- 
2.45.2

