Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A736C4345F
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 18:19:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D862688268;
	Sat, 13 Apr 2024 20:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="PmmEakq7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBAC08826A; Sat, 13 Apr 2024 20:16:20 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A724087CF1
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 20:16:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ef8c=LT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713032158; bh=5RT1jkOUNVYHP3OH6iUXT6capVg6P+XNavLacUGm5tY=;
 b=PmmEakq7VkScekU+gYczbr0B87CrOpaQBlr/jCgke8t+aygbkaMbrPf+J02hOdH2UT1uGX4JT
 vnfi8Hl0zedlv4Tn0Six2CSvgVY259jHCFolaeSOLJo/jsKz3UpxF/bXXTHZ36OTVM+nkT2SaQZ
 2HO9feYa05gXFsgdO7CZEbr5G39P9LtYJ+RoAGb/SWjpD3iYji+cinpIn+J7rWJ2MAugVhYJWOz
 SRdRXRq5qZR7mOaXr50Bc5gIaTm3PxWs6kgFVrQp66EmiS8tfzFMgw2XYZGhq8GsIf56mICrUhT
 H2AEO1+YuUctYiRJBRVuVhKe8z+TNC2u4D2TB3H2eS3Q==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Jagan Teki <jagan@edgeble.ai>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, John Clark <inindev@gmail.com>, Jonas
 Karlman <jonas@kwiboo.se>, Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Elon
 Zhang <zhangzj@rock-chips.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: [PATCH v2 23/23] rockchip: rk3588: Enable use of eMMC HS200 mode on a
 few missed boards
Date: Sat, 13 Apr 2024 18:13:57 +0000
Message-ID: <20240413181425.1384357-24-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240413181425.1384357-1-jonas@kwiboo.se>
References: <20240413181425.1384357-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 661acbdd6fbb975d49a6559c
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

A few RK3588 boards are missing a mmc-hs200 prop to signal that HS200
mode is supported in addition to HS400, this lead to bad performance
reading FIT in SPL and broken MMC write.

Add cap-mmc-highspeed and mmc-hs200-1_8v to affected boards to enable
use of eMMC HS200 mode.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch

All these mmc-hs200 prop overrides may not be needed if the patch "mmc:
Imply HS200 cap with mmc-hs400 prop to match linux" [1] gets applied,
until such time this matches what has been done for all other RK35xx
boards.

[1] https://patchwork.ozlabs.org/patch/1921039/
---
 arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi | 5 +++++
 arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi | 5 +++++
 arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi         | 5 +++++
 arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi        | 5 +++++
 arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi      | 5 +++++
 arch/arm/dts/rk3588-toybrick-x0-u-boot.dtsi      | 5 +++++
 6 files changed, 30 insertions(+)

diff --git a/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi b/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
index dd0058262b7f..fc4b13628b30 100644
--- a/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
@@ -15,6 +15,11 @@
 	};
 };
 
+&sdhci {
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+};
+
 &sdmmc {
 	bus-width = <4>;
 	status = "okay";
diff --git a/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi b/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
index a45b3f5e86ad..a0c62072c34e 100644
--- a/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
@@ -14,3 +14,8 @@
 		u-boot,spl-boot-order = &sdmmc;
 	};
 };
+
+&sdhci {
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+};
diff --git a/arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi b/arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi
index e8566785e965..354e4a8d39e3 100644
--- a/arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi
@@ -10,3 +10,8 @@
 		u-boot,spl-boot-order = "same-as-spl", &sdhci;
 	};
 };
+
+&sdhci {
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+};
diff --git a/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi b/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
index 968385622fa5..7948464ac85f 100644
--- a/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
@@ -11,6 +11,11 @@
 	bootph-some-ram;
 };
 
+&sdhci {
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+};
+
 &sfc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&fspim1_pins>;
diff --git a/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi b/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
index 7b937943a53c..d764135ab661 100644
--- a/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
@@ -4,3 +4,8 @@
  */
 
 #include "rk3588-u-boot.dtsi"
+
+&sdhci {
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+};
diff --git a/arch/arm/dts/rk3588-toybrick-x0-u-boot.dtsi b/arch/arm/dts/rk3588-toybrick-x0-u-boot.dtsi
index 1aeb5410e43e..c5c94b421d1e 100644
--- a/arch/arm/dts/rk3588-toybrick-x0-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-toybrick-x0-u-boot.dtsi
@@ -10,3 +10,8 @@
 		u-boot,spl-boot-order = "same-as-spl", &sdhci;
 	};
 };
+
+&sdhci {
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+};
-- 
2.43.2

