Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267A2C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 13:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B8B488563;
	Mon, 10 Jun 2024 15:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98CA388556; Mon, 10 Jun 2024 15:14:03 +0200 (CEST)
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch
 [84.16.66.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 959668852D
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 15:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VyXLw272CzGXs;
 Mon, 10 Jun 2024 15:14:00 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VyXLv4BqRzGv9; Mon, 10 Jun 2024 15:13:59 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 10 Jun 2024 15:13:33 +0200
Subject: [PATCH next v3 3/8] arm64: dts: rockchip: correct gpio_pwrctrl1
 typos on rk3588(s) boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-tiger-v3-3-2b4731f95757@cherry.de>
References: <20240610-tiger-v3-0-2b4731f95757@cherry.de>
In-Reply-To: <20240610-tiger-v3-0-2b4731f95757@cherry.de>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Klaus Goger <klaus.goger@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Jing Luo <jing@jing.rocks>, Heiko Stuebner <heiko@sntech.de>
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

From: Jing Luo <jing@jing.rocks>

gpio_pwrctrl2 gets duplicated by both rk806_dvs1_null and rk806_dvs2_null
gpio_pwrctrl1 is unset. This typo appears in multiple files. Let's fix them.

Note: I haven't had the chance to test them all because I don't own all
of these boards (obviously). Please test if it's needed.

Signed-off-by: Jing Luo <jing@jing.rocks>
Link: https://lore.kernel.org/r/20240420130355.639406-1-jing@jing.rocks
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: d7f2039e5321636069baa77ef2f1e5d22cb69a88 ]

(cherry picked from commit cb2b6d1d19ed10fcaec5f5859c08a3355d1c66e0)
---
 dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5.dtsi           | 2 +-
 dts/upstream/src/arm64/rockchip/rk3588-edgeble-neu6a-common.dtsi | 2 +-
 dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts                | 2 +-
 dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi                | 2 +-
 dts/upstream/src/arm64/rockchip/rk3588-turing-rk1.dtsi           | 2 +-
 dts/upstream/src/arm64/rockchip/rk3588s-coolpi-4b.dts            | 2 +-
 dts/upstream/src/arm64/rockchip/rk3588s-indiedroid-nova.dts      | 2 +-
 dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dts           | 2 +-
 dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts              | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5.dtsi b/dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5.dtsi
index 94ecb9b4f98..170501a879d 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5.dtsi
@@ -357,7 +357,7 @@
 		vcca-supply = <&vcc5v0_sys>;
 
 		rk806_dvs1_null: dvs1-null-pins {
-			pins = "gpio_pwrctrl2";
+			pins = "gpio_pwrctrl1";
 			function = "pin_fun0";
 		};
 
diff --git a/dts/upstream/src/arm64/rockchip/rk3588-edgeble-neu6a-common.dtsi b/dts/upstream/src/arm64/rockchip/rk3588-edgeble-neu6a-common.dtsi
index c0d4a15323e..d9bf67525e8 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588-edgeble-neu6a-common.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3588-edgeble-neu6a-common.dtsi
@@ -182,7 +182,7 @@
 		#gpio-cells = <2>;
 
 		rk806_dvs1_null: dvs1-null-pins {
-			pins = "gpio_pwrctrl2";
+			pins = "gpio_pwrctrl1";
 			function = "pin_fun0";
 		};
 
diff --git a/dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts b/dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts
index 39d65002add..7d7303f8ecb 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3588-jaguar.dts
@@ -452,7 +452,7 @@
 		vcca-supply = <&vcc5v0_sys>;
 
 		rk806_dvs1_null: dvs1-null-pins {
-			pins = "gpio_pwrctrl2";
+			pins = "gpio_pwrctrl1";
 			function = "pin_fun0";
 		};
 
diff --git a/dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi b/dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi
index 4984e36a8c2..29f8e536de1 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3588-tiger.dtsi
@@ -401,7 +401,7 @@
 		vcca-supply = <&vcc5v0_sys>;
 
 		rk806_dvs1_null: dvs1-null-pins {
-			pins = "gpio_pwrctrl2";
+			pins = "gpio_pwrctrl1";
 			function = "pin_fun0";
 		};
 
diff --git a/dts/upstream/src/arm64/rockchip/rk3588-turing-rk1.dtsi b/dts/upstream/src/arm64/rockchip/rk3588-turing-rk1.dtsi
index dc08da518a7..6b9206ce4a0 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588-turing-rk1.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3588-turing-rk1.dtsi
@@ -318,7 +318,7 @@
 		#gpio-cells = <2>;
 
 		rk806_dvs1_null: dvs1-null-pins {
-			pins = "gpio_pwrctrl2";
+			pins = "gpio_pwrctrl1";
 			function = "pin_fun0";
 		};
 
diff --git a/dts/upstream/src/arm64/rockchip/rk3588s-coolpi-4b.dts b/dts/upstream/src/arm64/rockchip/rk3588s-coolpi-4b.dts
index e037bf9db75..7f4d7bb9a07 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588s-coolpi-4b.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3588s-coolpi-4b.dts
@@ -479,7 +479,7 @@
 		vcca-supply = <&vcc5v0_sys>;
 
 		rk806_dvs1_null: dvs1-null-pins {
-			pins = "gpio_pwrctrl2";
+			pins = "gpio_pwrctrl1";
 			function = "pin_fun0";
 		};
 
diff --git a/dts/upstream/src/arm64/rockchip/rk3588s-indiedroid-nova.dts b/dts/upstream/src/arm64/rockchip/rk3588s-indiedroid-nova.dts
index ce8119cbb82..a5b76e24ceb 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588s-indiedroid-nova.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3588s-indiedroid-nova.dts
@@ -528,7 +528,7 @@
 		vcca-supply = <&vcc5v0_sys>;
 
 		rk806_dvs1_null: dvs1-null-pins {
-			pins = "gpio_pwrctrl2";
+			pins = "gpio_pwrctrl1";
 			function = "pin_fun0";
 		};
 
diff --git a/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dts b/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dts
index 25de4362af3..73700d77eed 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5.dts
@@ -336,7 +336,7 @@
 		#gpio-cells = <2>;
 
 		rk806_dvs1_null: dvs1-null-pins {
-			pins = "gpio_pwrctrl2";
+			pins = "gpio_pwrctrl1";
 			function = "pin_fun0";
 		};
 
diff --git a/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts b/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts
index 00afb90d4eb..5c99636a1d0 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3588s-rock-5a.dts
@@ -414,7 +414,7 @@
 		#gpio-cells = <2>;
 
 		rk806_dvs1_null: dvs1-null-pins {
-			pins = "gpio_pwrctrl2";
+			pins = "gpio_pwrctrl1";
 			function = "pin_fun0";
 		};
 

-- 
2.45.2

