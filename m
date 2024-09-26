Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F9DCDE02E
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 18:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B06A88D63;
	Thu, 26 Sep 2024 20:31:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0D2088C94; Thu, 26 Sep 2024 20:31:33 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD17B889DA
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 20:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 6221F1F0004F
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 18:31:27 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 3DFA4A6013C; Thu, 26 Sep 2024 18:31:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id 051CDA6012B;
 Thu, 26 Sep 2024 18:31:22 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Jonas Karlman <jonas@kwiboo.se>,
 Chris Morgan <macromorgan@hotmail.com>, Tim Lunn <tim@feathertop.org>,
 Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 1/4] rockchip: rk3399-roc-pc: Hook sysreset gpio to enable
 full reset
Date: Thu, 26 Sep 2024 20:31:08 +0200
Message-ID: <20240926183111.1324284-1-paulk@sys-base.io>
X-Mailer: git-send-email 2.46.2
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

From: Paul Kocialkowski <contact@paulk.fr>

The reset mechanism used by Linux to reset the SoC is known to only
partially reset the logic. A mechanism is implemented in
rk3399_force_power_on_reset to use a GPIO connected to the PMIC's
over-temperature (OTP) reset pin, which fully resets all logic.

Hook the associated GPIO where the function expects it to enable this
reset mechanism and avoid any possible side-effect of partially-reset
units.

Without this patch, reading from the micro sd slot fails after a reset.
With this mechanism, U-Boot is able to boot from it reliably.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/dts/rk3399-roc-pc-u-boot.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
index aecf7dbe383c..883d399a06a3 100644
--- a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
@@ -7,6 +7,10 @@
 #include "rk3399-sdram-lpddr4-100.dtsi"
 
 / {
+	config {
+		sysreset-gpio = <&gpio1 RK_PA6 GPIO_ACTIVE_HIGH>;
+	};
+
 	vcc_hub_en: vcc_hub_en-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -36,6 +40,10 @@
 	bootph-pre-ram;
 };
 
+&gpio1 {
+	bootph-pre-ram;
+};
+
 &spi1 {
 	flash@0 {
 		bootph-pre-ram;
-- 
2.46.2

