Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EC1C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 23:47:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA8DA8847E;
	Fri, 17 May 2024 01:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715903274;
	bh=ZYf2OMFdtMJ9n0iWBDn6vJaysrAe8miBtmG01x23INk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lgCWdMOiH1PL6sdcNjSjtVXMXyjmnK/bvUjQcdARQJYhS0/+LKUZAQuA/qNt/bFDi
	 75gLTIhjE69lwWXc2Vv4oc74DjQq8cWmE+zhoTTf4OBYJJzw8u8zaBRGFyzOdYp1Zo
	 jck3804zAC1cLAHeiu9Nm7bF3fsJqExFZPo2bPP6/kmUi/khqvZOeQrhatwXYRuDwd
	 TOFHSCi3h4MhVz0h/4eW0+WgGFBpNZgUVuata/D5Y9VKZ+QNhYBCgPgjILPyziFVp6
	 KCMGV6aR8riS0I+q1AGMScgMKEEyzzGCD8k7/gHtwSayrnkHzueHL9jR7UGY4NutRS
	 mnzJLmZSKefqw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 28B6688453;
 Fri, 17 May 2024 01:47:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715903272;
 bh=ZYf2OMFdtMJ9n0iWBDn6vJaysrAe8miBtmG01x23INk=;
 h=From:To:Cc:Subject:Date:From;
 b=hrqQngZcEwNs7/F4NIx9ztHAj4Rk+P0/7+PwI6DqQG6mQppboGRGM6JRwjTrilPL3
 v7zW2QkmIf644ot0I6kibgL0PHwq6bAgiT+M/yGbL2z/5eUwi58Yd7E/6TxN2f3/mw
 sRCXrDOmIn+H9xVnT7ONd71ptdv/GsSDJupdL7r9Exy59WB6qG3ec0P/XKG/xrUTZk
 Cg5CemLw0gRwQoLnl0JdOjFUn6FVmMRH2G5AQUSoo2VLcHmVhK0YYTTbo7DyTzju8I
 O1M55NT1dQouHxQjU+Mk9BAXDVYsCrPhGWkR9HooyrZq65XtqfkHhwynY6BnUKokCL
 4hEed9YTiK/cA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: dts: stm32: Add generic SoM compatible to STM32MP15xx DH
 electronics DHSOM
Date: Fri, 17 May 2024 01:47:04 +0200
Message-ID: <20240516234737.201250-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

Add generic SoM compatible string into machine compatible string
for all STM32MP15xx based DH electronics DHSOM. This way, common
board code can match on this compatible. No functional change.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp15xx-dhcom-drc02.dts       | 4 +++-
 arch/arm/dts/stm32mp15xx-dhcom-pdk2.dts        | 4 +++-
 arch/arm/dts/stm32mp15xx-dhcom-picoitx.dts     | 4 +++-
 arch/arm/dts/stm32mp15xx-dhcor-avenger96.dts   | 4 +++-
 arch/arm/dts/stm32mp15xx-dhcor-drc-compact.dts | 4 +++-
 arch/arm/dts/stm32mp15xx-dhcor-testbench.dts   | 4 +++-
 6 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/stm32mp15xx-dhcom-drc02.dts b/arch/arm/dts/stm32mp15xx-dhcom-drc02.dts
index 1ef9ac29cea..90625bf6b60 100644
--- a/arch/arm/dts/stm32mp15xx-dhcom-drc02.dts
+++ b/arch/arm/dts/stm32mp15xx-dhcom-drc02.dts
@@ -11,5 +11,7 @@
 
 / {
 	model = "DH Electronics STM32MP15xx DHCOM DRC02";
-	compatible = "dh,stm32mp15xx-dhcom-drc02", "st,stm32mp1xx";
+	compatible = "dh,stm32mp15xx-dhcom-drc02",
+		     "dh,stm32mp15xx-dhcom-som",
+		     "st,stm32mp1xx";
 };
diff --git a/arch/arm/dts/stm32mp15xx-dhcom-pdk2.dts b/arch/arm/dts/stm32mp15xx-dhcom-pdk2.dts
index e2e01e2146c..b2e450aa13b 100644
--- a/arch/arm/dts/stm32mp15xx-dhcom-pdk2.dts
+++ b/arch/arm/dts/stm32mp15xx-dhcom-pdk2.dts
@@ -11,5 +11,7 @@
 
 / {
 	model = "STMicroelectronics STM32MP15xx DHCOM Premium Developer Kit (2)";
-	compatible = "dh,stm32mp15xx-dhcom-pdk2", "st,stm32mp15x";
+	compatible = "dh,stm32mp15xx-dhcom-pdk2",
+		     "dh,stm32mp15xx-dhcom-som",
+		     "st,stm32mp15x";
 };
diff --git a/arch/arm/dts/stm32mp15xx-dhcom-picoitx.dts b/arch/arm/dts/stm32mp15xx-dhcom-picoitx.dts
index 06770b47873..3e908102f61 100644
--- a/arch/arm/dts/stm32mp15xx-dhcom-picoitx.dts
+++ b/arch/arm/dts/stm32mp15xx-dhcom-picoitx.dts
@@ -11,5 +11,7 @@
 
 / {
 	model = "DH Electronics STM32MP15xx DHCOM PicoITX";
-	compatible = "dh,stm32mp15xx-dhcom-picoitx", "st,stm32mp1xx";
+	compatible = "dh,stm32mp15xx-dhcom-picoitx",
+		     "dh,stm32mp15xx-dhcom-som",
+		     "st,stm32mp1xx";
 };
diff --git a/arch/arm/dts/stm32mp15xx-dhcor-avenger96.dts b/arch/arm/dts/stm32mp15xx-dhcor-avenger96.dts
index 76ac5a873c1..dd8fcecbca5 100644
--- a/arch/arm/dts/stm32mp15xx-dhcor-avenger96.dts
+++ b/arch/arm/dts/stm32mp15xx-dhcor-avenger96.dts
@@ -14,5 +14,7 @@
 
 / {
 	model = "Arrow Electronics STM32MP15xx Avenger96 board";
-	compatible = "arrow,stm32mp15xx-avenger96", "st,stm32mp15x";
+	compatible = "arrow,stm32mp15xx-avenger96",
+		     "dh,stm32mp15xx-dhcor-som",
+		     "st,stm32mp15x";
 };
diff --git a/arch/arm/dts/stm32mp15xx-dhcor-drc-compact.dts b/arch/arm/dts/stm32mp15xx-dhcor-drc-compact.dts
index 77dd944ff53..c1f99c1685e 100644
--- a/arch/arm/dts/stm32mp15xx-dhcor-drc-compact.dts
+++ b/arch/arm/dts/stm32mp15xx-dhcor-drc-compact.dts
@@ -12,5 +12,7 @@
 
 / {
 	model = "DH electronics STM32MP15xx DHCOR DRC Compact";
-	compatible = "dh,stm32mp15xx-dhcor-drc-compact", "st,stm32mp1xx";
+	compatible = "dh,stm32mp15xx-dhcor-drc-compact",
+		     "dh,stm32mp15xx-dhcor-som",
+		     "st,stm32mp1xx";
 };
diff --git a/arch/arm/dts/stm32mp15xx-dhcor-testbench.dts b/arch/arm/dts/stm32mp15xx-dhcor-testbench.dts
index c9163e1c028..5fdd762ddbf 100644
--- a/arch/arm/dts/stm32mp15xx-dhcor-testbench.dts
+++ b/arch/arm/dts/stm32mp15xx-dhcor-testbench.dts
@@ -9,7 +9,9 @@
 
 / {
 	model = "DH electronics STM32MP15xx DHCOR Testbench";
-	compatible = "dh,stm32mp15xx-dhcor-testbench", "st,stm32mp1xx";
+	compatible = "dh,stm32mp15xx-dhcor-testbench",
+		     "dh,stm32mp15xx-dhcor-som",
+		     "st,stm32mp1xx";
 
 	aliases {
 		ethernet0 = &ethernet0;
-- 
2.43.0

