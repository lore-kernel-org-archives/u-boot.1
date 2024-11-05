Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFB4D2B944
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 658698917B;
	Tue,  5 Nov 2024 17:01:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="GINGGNWG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D97688900E; Tue,  5 Nov 2024 17:01:22 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F5488917B
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:01:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dc50=SB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1730822472; bh=Hto4GzUqhCV8+NmS9M6WdrMBQcYZ3866JLLMISfZ6/4=;
 b=GINGGNWGOKiFvct7Ch1HejTk3Oq0016yhQ4GLt0eYwaLCVoGFNkdaRksiU4Osr2tXSm9BaI20
 JN1WmWrY4nQywB5M6QPUZfzoJJMYvMgqNoD1o2ytvtKPHDBmGyyM6R7BOQcoIA6xyXP6B+13IX/
 oVf8YAJBqSOPfIWZP830OWEDVEmjbth8Z+de+u/Ejf3p/woMkYTovhrkJE8ncoeoNJLiiEIHPkX
 dsUXE64OKrjyhemzL6feACOyrKmml0Hl9MpTM6Edh0ovUPl7dKgJ4xZsEH94jyW6a54cxRi6C8H
 PA4hPnv4lG5Bg5A03Q/43Ac9E+ebvGvQfHO32u6Me7aA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 02/13] rockchip: rk3288-tinker: Sort u-boot.dtsi nodes
 alphabetically
Date: Tue,  5 Nov 2024 16:00:25 +0000
Message-ID: <20241105160054.1373319-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241105160054.1373319-1-jonas@kwiboo.se>
References: <20241105160054.1373319-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 672a4145ff3e144e4725e0b0
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

Sort the nodes in rk3288-tinker u-boot.dtsi files in alphabetical order.

This has no intended change to board DTs and only rearrange nodes in
preparation for future changes.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3288-tinker-s-u-boot.dtsi |  8 ++---
 arch/arm/dts/rk3288-tinker-u-boot.dtsi   | 44 ++++++++++++------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/dts/rk3288-tinker-s-u-boot.dtsi b/arch/arm/dts/rk3288-tinker-s-u-boot.dtsi
index b4c5483146ab..a782f2f9804a 100644
--- a/arch/arm/dts/rk3288-tinker-s-u-boot.dtsi
+++ b/arch/arm/dts/rk3288-tinker-s-u-boot.dtsi
@@ -17,18 +17,18 @@
 	bootph-pre-ram;
 };
 
-&emmc_clk {
+&emmc_bus8 {
 	bootph-pre-ram;
 };
 
-&emmc_cmd {
+&emmc_clk {
 	bootph-pre-ram;
 };
 
-&emmc_pwr {
+&emmc_cmd {
 	bootph-pre-ram;
 };
 
-&emmc_bus8 {
+&emmc_pwr {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/rk3288-tinker-u-boot.dtsi b/arch/arm/dts/rk3288-tinker-u-boot.dtsi
index 0cf1b696d168..032dac221c24 100644
--- a/arch/arm/dts/rk3288-tinker-u-boot.dtsi
+++ b/arch/arm/dts/rk3288-tinker-u-boot.dtsi
@@ -17,6 +17,10 @@
 	rockchip,sdram-params = <0x20d266a4 0x5b6 2 533000000 6 9 0>;
 };
 
+&gpio7 {
+	bootph-pre-ram;
+};
+
 &i2c2 {
 	m24c08@50 {
 		compatible = "at,24c08", "i2c-eeprom";
@@ -24,31 +28,15 @@
 	};
 };
 
-&pinctrl {
-	bootph-all;
-};
-
-&uart2 {
-	bootph-all;
-};
-
-&uart2_xfer {
-	bootph-all;
-};
-
-&sdmmc {
-	bootph-pre-ram;
-};
-
-&gpio7 {
+&pcfg_pull_none {
 	bootph-pre-ram;
 };
 
-&vcc_sd {
+&pcfg_pull_none_drv_8ma {
 	bootph-pre-ram;
 };
 
-&pcfg_pull_none_drv_8ma {
+&pcfg_pull_up {
 	bootph-pre-ram;
 };
 
@@ -56,11 +44,11 @@
 	bootph-pre-ram;
 };
 
-&pcfg_pull_none {
-	bootph-pre-ram;
+&pinctrl {
+	bootph-all;
 };
 
-&pcfg_pull_up {
+&sdmmc {
 	bootph-pre-ram;
 };
 
@@ -83,3 +71,15 @@
 &sdmmc_pwr {
 	bootph-pre-ram;
 };
+
+&uart2 {
+	bootph-all;
+};
+
+&uart2_xfer {
+	bootph-all;
+};
+
+&vcc_sd {
+	bootph-pre-ram;
+};
-- 
2.46.2

