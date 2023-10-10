Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DEACD80A6
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 11:13:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D12D86679;
	Tue, 10 Oct 2023 13:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF44B86679; Tue, 10 Oct 2023 13:13:22 +0200 (CEST)
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B36BC86667
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 13:13:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel@ziswiler.com
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MgMDo-1rBg4R2XG2-00NlSH; 
 Tue, 10 Oct 2023 13:13:10 +0200
From: Marcel Ziswiler <marcel@ziswiler.com>
To: u-boot@lists.denx.de
Cc: Nishanth Menon <nm@ti.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1] arm: dts: k3-am625-verdin: fix boot
Date: Tue, 10 Oct 2023 13:13:04 +0200
Message-Id: <20231010111304.200307-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LsZ+afvzPylphtjpmlas9ngJt1+bd02+EvBfIuQnfRiYYuC9R6y
 W991JgerbIv03jS+arN02ASkejIly593Ee95KMtrJnjxdKB2faIE7jqdA99DUJR1YvavhG1
 nHH2okqOg5M/i49UVzWOoXQJmzl/L2kvLvgk4DWZxBEsx1sU9FZ3Ik1OP/DBZmNNPk2saDm
 8uRFanC6X43o2Plg5AemA==
UI-OutboundReport: notjunk:1;M01:P0:JA9dnnJwzFw=;lHpqr18aN9PS12WIqZS02I0IGAj
 /FEYO6lbAgoLjzG9O/3oYdokwLBhDYgGkx7NsZBPdB5g7J7T1zbPL5MMziSw/OKSx1Nqq+Hs1
 SMGeoYQXiOBxxtIW1WTKlOvGaO/KVjMSs/diqr6yFIMsL+0RK1pBgUgat3jjjj74uJX9vfikP
 O4iFBJ/Br7NZjXpx0kIa89jbapq4sQAjulgXRDhLS6fPSvu4G84wNrmULgZI1bkJt3ud5bemz
 jJIHI4KLEkv/7BIFqfFzSf2Z2nHcgUht28pMp5Y7lK1R9zJNYNhv8tbFQuX2BjA4pg8Ij7qFA
 xIKfxN97vT40RGenB0xkxSaGFc7NngnqWvTvmbdk/AZiia/eVmZXiy80Vvzwd7vzJzQgcJoy9
 MSY+U0kz2Ut8stwMGj7jVkDBbvoCVegWRN2xoSOC5ZHibdgxGYpx/zZoEAL8PqH+RSrUG7v30
 wZfNbVEkdnoIRCDNiLWx40Aans7Pwzdm3LMsHjo5hrQwZz4Zai6N9kJ3X6QvCcPEiHYjJYWK2
 lxKPoHWwkHnzmk0SkNRyBZdISdfiN2MrY7JRpCjme7gGu5/tgUL34BeQIC876QpKeiH91wlQj
 f69juMWHsa13YbSpHI/GhHvzPZ4HxoHf/1DjraJ2sBaAAOEboqtht/NlX8F448ieDp9mrpNFp
 uriGtsFjWBH4RRM3V3j2ec4lcq+rxeWiaQxI01/K5Mb15fpnbauduJYE0Euj9F682XG6PUCk6
 rvTAJf9ozKYhtBbXVi1eLc04oZK3pi9xKjG2ptS1Jyooc78hJLACeRNqTpJPb4MXhEdmnV4OY
 ECFzZxC3WWvxRy6ZYTdAnuSQNfpIuQ/gZ+01lLYkQbKxt6nk0rxGNaOUnD32+zEncMSZJLjof
 ucowfN1oJ1WvAeA==
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

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

A53 U-Boot proper got broken because nodes marked as 'bootph-pre-ram'
are no longer available in U-Boot proper before relocation.

Fix this by marking all nodes in u-boot.dtsi as 'bootph-all'.

Fixes: 9e644284ab812 ("dm: core: Report bootph-pre-ram/sram node as pre-reloc after relocation")
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 .../dts/k3-am625-verdin-wifi-dev-u-boot.dtsi  | 72 +++++++++----------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
index 5d564603eb2..afa24d07a4c 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
@@ -17,49 +17,49 @@
 	};
 
 	memory@80000000 {
-		bootph-pre-ram;
+		bootph-all;
 	};
 };
 
 &cbass_main {
-	bootph-pre-ram;
+	bootph-all;
 
 	timer@2400000 {
 		clock-frequency = <25000000>;
-		bootph-pre-ram;
+		bootph-all;
 	};
 };
 
 &cbass_mcu {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &cbass_wakeup {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &chipid {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &cpsw3g {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &cpsw3g_phy0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &cpsw3g_phy1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &cpsw_port1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &cpsw_port2 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 /* MDIO, shared by Verdin ETH_1 (On-module PHY) and Verdin ETH_2_RGMII */
@@ -67,40 +67,40 @@
 	/delete-property/ assigned-clocks;
 	/delete-property/ assigned-clock-parents;
 	/delete-property/ assigned-clock-rates;
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &dmsc {
-	bootph-pre-ram;
+	bootph-all;
 
 	k3_sysreset: sysreset-controller {
 		compatible = "ti,sci-sysreset";
-		bootph-pre-ram;
+		bootph-all;
 	};
 };
 
 &dmss {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &fss {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &k3_clks {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &k3_pds {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &k3_reset {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &main_gpio0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 /* On-module I2C - PMIC_I2C */
@@ -130,53 +130,53 @@
 };
 
 &main_pmx0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 /* Verdin UART_3, used as the Linux console */
 &main_uart0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 /* Verdin UART_1 */
 &main_uart1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &mcu_pmx0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pinctrl_ctrl_sleep_moci {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pinctrl_i2c0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pinctrl_i2c1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pinctrl_sdhci0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pinctrl_uart0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pinctrl_uart1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pinctrl_wkup_uart0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &sdhci0 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &sdhci2 {
@@ -184,18 +184,18 @@
 };
 
 &secure_proxy_main {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &verdin_ctrl_sleep_moci {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &wkup_conf {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 /* Verdin UART_2 */
 &wkup_uart0 {
-	bootph-pre-ram;
+	bootph-all;
 };
-- 
2.36.1

