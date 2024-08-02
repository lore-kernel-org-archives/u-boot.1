Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCA9C3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 22:59:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44F0288C6F;
	Sat,  3 Aug 2024 00:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="wBAYQq2C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06AC188C81; Sat,  3 Aug 2024 00:57:51 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13E2988C04
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 00:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5651=PC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722639461; bh=6+ZwgT4kJw4mxJ8WuuLh2kvdaraLxPlf/Grfqkzwm/o=;
 b=wBAYQq2CYdAXO/Hmv7q6yyeaswgITODAUv2cbgX9n06Yx8taI9rMwN1x92iRvjJFFNxhhg/V3
 RxHEsJxlRXFt6Sw1RMtgNgR1xO8TnYWgR0/9vLC3jAc+MLMsrWdAV/0p5okVXl/pwzqW+PoX098
 nszhKXKTIiMEserv29Qsbcet/5mZ46IEV3Ko3EazCK0RCxSRPl0+uBCWaVQ4+pPiOgkf4r4Umol
 nciiApRUaJf3lTaZ6lTK9KYIQFYkQXWVf29zRtCyUPK1yOoq2pW+n+m8rtYz1XpSVqKQLUfOBgK
 TmsYzwdZCy/lL1+2yGiK2zFiz83djCgXpHPJiY6asH0A==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 10/10] rockchip: gpio: Add missing gpio aliases
Date: Fri,  2 Aug 2024 22:56:52 +0000
Message-ID: <20240802225705.2640999-11-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802225705.2640999-1-jonas@kwiboo.se>
References: <20240802225705.2640999-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66ad646316ac7a56c917af2a
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

Add aliases for gpio controllers to soc u-boot dtsi files that are
missing aliases in soc dtsi files to ensure dev_seq() return the
expected number when a gpio controller is included in SPL.

Also drop the aliases from rk3288-u-boot.dtsi, they are already part of
rk3288.dtsi.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 arch/arm/dts/px30-u-boot.dtsi    | 4 ++++
 arch/arm/dts/rk3066a-u-boot.dtsi | 7 +++++++
 arch/arm/dts/rk3288-u-boot.dtsi  | 9 ---------
 arch/arm/dts/rk3xxx-u-boot.dtsi  | 7 +++++++
 arch/arm/dts/rv1108-u-boot.dtsi  | 9 +++++++++
 arch/arm/dts/rv1126-u-boot.dtsi  | 8 ++++++++
 6 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/arch/arm/dts/px30-u-boot.dtsi b/arch/arm/dts/px30-u-boot.dtsi
index abc6b49e6663..3dc70d4e432b 100644
--- a/arch/arm/dts/px30-u-boot.dtsi
+++ b/arch/arm/dts/px30-u-boot.dtsi
@@ -7,6 +7,10 @@
 
 / {
 	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
 		mmc0 = &emmc;
 		mmc1 = &sdmmc;
 	};
diff --git a/arch/arm/dts/rk3066a-u-boot.dtsi b/arch/arm/dts/rk3066a-u-boot.dtsi
index 35b52d6fb7f3..60d18d2daeac 100644
--- a/arch/arm/dts/rk3066a-u-boot.dtsi
+++ b/arch/arm/dts/rk3066a-u-boot.dtsi
@@ -3,6 +3,13 @@
 #include "rockchip-u-boot.dtsi"
 #include "rk3xxx-u-boot.dtsi"
 
+/ {
+	aliases {
+		gpio4 = &gpio4;
+		gpio6 = &gpio6;
+	};
+};
+
 &gpio0 {
 	gpio-ranges = <&pinctrl 0 0 32>;
 };
diff --git a/arch/arm/dts/rk3288-u-boot.dtsi b/arch/arm/dts/rk3288-u-boot.dtsi
index 0f8053a8b690..379d9413adee 100644
--- a/arch/arm/dts/rk3288-u-boot.dtsi
+++ b/arch/arm/dts/rk3288-u-boot.dtsi
@@ -7,15 +7,6 @@
 
 / {
 	aliases {
-		gpio0 = &gpio0;
-		gpio1 = &gpio1;
-		gpio2 = &gpio2;
-		gpio3 = &gpio3;
-		gpio4 = &gpio4;
-		gpio5 = &gpio5;
-		gpio6 = &gpio6;
-		gpio7 = &gpio7;
-		gpio8 = &gpio8;
 		mmc0 = &emmc;
 		mmc1 = &sdmmc;
 		mmc2 = &sdio0;
diff --git a/arch/arm/dts/rk3xxx-u-boot.dtsi b/arch/arm/dts/rk3xxx-u-boot.dtsi
index 6af6a451ea78..097407ca72dc 100644
--- a/arch/arm/dts/rk3xxx-u-boot.dtsi
+++ b/arch/arm/dts/rk3xxx-u-boot.dtsi
@@ -1,6 +1,13 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 
 / {
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+	};
+
 	noc: syscon@10128000 {
 		compatible = "rockchip,rk3188-noc", "syscon";
 		reg = <0x10128000 0x2000>;
diff --git a/arch/arm/dts/rv1108-u-boot.dtsi b/arch/arm/dts/rv1108-u-boot.dtsi
index f772d618bd1d..58711e8b2f8a 100644
--- a/arch/arm/dts/rv1108-u-boot.dtsi
+++ b/arch/arm/dts/rv1108-u-boot.dtsi
@@ -5,6 +5,15 @@
 
 #include "rockchip-u-boot.dtsi"
 
+/ {
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+	};
+};
+
 &gpio0 {
 	gpio-ranges = <&pinctrl 0 0 32>;
 };
diff --git a/arch/arm/dts/rv1126-u-boot.dtsi b/arch/arm/dts/rv1126-u-boot.dtsi
index 3e6df1e433db..05b5f5260dd5 100644
--- a/arch/arm/dts/rv1126-u-boot.dtsi
+++ b/arch/arm/dts/rv1126-u-boot.dtsi
@@ -6,6 +6,14 @@
 #include "rockchip-u-boot.dtsi"
 
 / {
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+		gpio4 = &gpio4;
+	};
+
 	chosen {
 		u-boot,spl-boot-order = \
 			"same-as-spl", &emmc, &sdmmc;
-- 
2.45.2

