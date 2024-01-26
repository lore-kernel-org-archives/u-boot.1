Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD334C47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 22:16:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8589B87D63;
	Fri, 26 Jan 2024 23:15:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="dhBu5zuT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C65A87D48; Fri, 26 Jan 2024 23:15:58 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32C1087D71
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 23:15:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0bb9=JF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1706307344; bh=/jcC2SVHJc41UO1z6JS5UDK91wxGSnEKE2NWcun8/4Y=;
 b=dhBu5zuTMA1sYFeR2a8d5SsSXiHDHxJ2PwvRI5sBW0QUgGtmcSD/lnjFcTvPh5xxm5OfZmIP9
 AloT90l7fErP5ZPFjzK+Tawl+FNT78WP6FLsoOPC1SzZr1OLXlfu54XR+2BNXDY6ir+W691fct4
 TMhF2Fj+p6/g9XVc65UTevOu82065dtmnwetQvf5eKrXX0gotxQoVpuWul6qr6nQk28/liNJm/n
 Sc4Gt+MpkngZ5D83u25ggz6+Y4gb2up0qUL3aMmF2R8WnUr4IKlDQ91IGZqXUNy9+7n0Rc/wwIU
 lL9HWTnudUwwm2QCHwhm/7YBmqqOOYFOjr2/9Kle+g2Q==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Joshua Riek <jjriek@verizon.net>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 7/7] rockchip: rk35xx: Remove unnecessary status props
Date: Fri, 26 Jan 2024 22:14:55 +0000
Message-ID: <20240126221508.4093334-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126221508.4093334-1-jonas@kwiboo.se>
References: <20240126221508.4093334-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65b42f100365e20062645654
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

Remove unnecessary status props from rk35xx u-boot.dtsi files, regular
device tree files or default value already enable the affected nodes.

Also reorder bootph-pre-ram and clock-frequency props alphabetically in
rk3588s-u-boot.dtsi uart2 node.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk356x-u-boot.dtsi            | 7 -------
 arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi | 1 -
 arch/arm/dts/rk3588s-u-boot.dtsi           | 7 +------
 3 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
index cacd45348a49..d347080577d9 100644
--- a/arch/arm/dts/rk356x-u-boot.dtsi
+++ b/arch/arm/dts/rk356x-u-boot.dtsi
@@ -19,7 +19,6 @@
 	dmc: dmc {
 		compatible = "rockchip,rk3568-dmc";
 		bootph-all;
-		status = "okay";
 	};
 
 	otp: nvmem@fe38c000 {
@@ -27,7 +26,6 @@
 		reg = <0x0 0xfe38c000 0x0 0x4000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-		status = "okay";
 
 		cpu_id: id@a {
 			reg = <0x0a 0x10>;
@@ -37,27 +35,22 @@
 
 &xin24m {
 	bootph-all;
-	status = "okay";
 };
 
 &cru {
 	bootph-all;
-	status = "okay";
 };
 
 &pmucru {
 	bootph-all;
-	status = "okay";
 };
 
 &grf {
 	bootph-all;
-	status = "okay";
 };
 
 &pmugrf {
 	bootph-all;
-	status = "okay";
 };
 
 &pinctrl {
diff --git a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
index e791b572b6bf..471508a9ed74 100644
--- a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
@@ -15,5 +15,4 @@
 &uart9 {
 	bootph-pre-ram;
 	clock-frequency = <24000000>;
-	status = "okay";
 };
diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
index 945b2d62a75e..bf3b1ea8a3c6 100644
--- a/arch/arm/dts/rk3588s-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-u-boot.dtsi
@@ -17,7 +17,6 @@
 	dmc {
 		compatible = "rockchip,rk3588-dmc";
 		bootph-all;
-		status = "okay";
 	};
 
 	usb_host0_xhci: usb@fc000000 {
@@ -165,17 +164,14 @@
 
 &xin24m {
 	bootph-all;
-	status = "okay";
 };
 
 &cru {
 	bootph-pre-ram;
-	status = "okay";
 };
 
 &sys_grf {
 	bootph-pre-ram;
-	status = "okay";
 };
 
 &pmu1grf {
@@ -217,9 +213,8 @@
 };
 
 &uart2 {
-	clock-frequency = <24000000>;
 	bootph-pre-ram;
-	status = "okay";
+	clock-frequency = <24000000>;
 };
 
 &uart2m0_xfer {
-- 
2.43.0

