Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E94EC48BF5
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 00:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EEBB86DBD;
	Sat, 17 Feb 2024 01:23:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="k4RPDK7V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26F2B87C78; Sat, 17 Feb 2024 01:23:45 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CA5D8718A
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 01:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4c2a=J2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1708129398; bh=abvZupxA3JSi84oHFt9dyCrzPF4YPHzYG9ezj1dKhes=;
 b=k4RPDK7V56bSThrdr6leHJN05S9EctFzXEaG8ABQIvPHcg8Jm4k9tGd/0XJlrIoq32N4AzhSa
 ylk5Dp/zV+5Ga3m6Z1dLEZLfSqGy1RwxoFkb8Ttu/IDuzY2RiHGXrKaVHUqZbU2kIqf1kmGHwjK
 dSF3azofJqeCNN0O1mJMpWrrujBuOyUqa2Q7dw/ZX67NPVqSBvbaH2JhqRn1KGskIb5HuccOGJm
 lRCMXGQD/Jbwq6I2XfW9VwlG0gn5ucEQwvYDRKSfJ++71kYCBTH4I5F+hN088TOPrClvVUMqxMC
 8pu24xvrcS4a55WrmRYbMs2vJzmDO+Fj22kt1bhpE5XA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Tianling Shen <cnsztl@gmail.com>, David Bauer <mail@david-bauer.net>, Loic
 Devulder <ldevulder@suse.com>, "Chen-Yu Tsai" <wens@csie.org>, Jonas
 Karlman <jonas@kwiboo.se>, "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2 01/15] rockchip: rk3328: Update default u-boot,
 spl-boot-order prop
Date: Sat, 17 Feb 2024 00:22:27 +0000
Message-ID: <20240217002304.2141064-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217002304.2141064-1-jonas@kwiboo.se>
References: <20240217002304.2141064-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65cffc74bb96cee8b5411e8c
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

Change to use a common FIT load order, same-as-spl > SD-card > eMMC on
RK3328 boards. Only EVB and Radxa ROCK Pi E is affected by this change.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
---
v2:
- No change
- Collect r-b tag
---
 arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi      | 6 ------
 arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi           | 5 -----
 arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi | 5 -----
 arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi     | 5 -----
 arch/arm/dts/rk3328-roc-cc-u-boot.dtsi               | 5 +----
 arch/arm/dts/rk3328-rock64-u-boot.dtsi               | 5 +----
 arch/arm/dts/rk3328-u-boot.dtsi                      | 2 +-
 7 files changed, 3 insertions(+), 30 deletions(-)

diff --git a/arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi b/arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
index f8adb9e5e1ff..1dc3c022c504 100644
--- a/arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
@@ -1,9 +1,3 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 #include "rk3328-nanopi-r2c-u-boot.dtsi"
-
-/ {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
-	};
-};
diff --git a/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi b/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
index 78d37ab47558..d969b008775e 100644
--- a/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
@@ -6,11 +6,6 @@
 
 #include "rk3328-u-boot.dtsi"
 #include "rk3328-sdram-ddr4-666.dtsi"
-/ {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
-	};
-};
 
 &gpio0 {
 	bootph-pre-ram;
diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi b/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
index ebe33e48cb9c..5aaa5ccb15c1 100644
--- a/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
@@ -6,11 +6,6 @@
 
 #include "rk3328-u-boot.dtsi"
 #include "rk3328-sdram-lpddr3-666.dtsi"
-/ {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
-	};
-};
 
 &gpio0 {
 	bootph-pre-ram;
diff --git a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi b/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
index 637c70adf194..6d3db86dce6a 100644
--- a/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
@@ -6,11 +6,6 @@
 
 #include "rk3328-u-boot.dtsi"
 #include "rk3328-sdram-ddr4-666.dtsi"
-/ {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
-	};
-};
 
 &gpio0 {
 	bootph-pre-ram;
diff --git a/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi b/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
index 2062f34bf825..8bc2f134f8f4 100644
--- a/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
@@ -5,11 +5,8 @@
 
 #include "rk3328-u-boot.dtsi"
 #include "rk3328-sdram-ddr4-666.dtsi"
-/ {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
-	};
 
+/ {
 	smbios {
 		compatible = "u-boot,sysinfo-smbios";
 
diff --git a/arch/arm/dts/rk3328-rock64-u-boot.dtsi b/arch/arm/dts/rk3328-rock64-u-boot.dtsi
index 6904515b9693..bfe506fd2249 100644
--- a/arch/arm/dts/rk3328-rock64-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-rock64-u-boot.dtsi
@@ -5,11 +5,8 @@
 
 #include "rk3328-u-boot.dtsi"
 #include "rk3328-sdram-lpddr3-1600.dtsi"
-/ {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
-	};
 
+/ {
 	smbios {
 		compatible = "u-boot,sysinfo-smbios";
 
diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
index a9f2536de2a2..a12be7876db0 100644
--- a/arch/arm/dts/rk3328-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-u-boot.dtsi
@@ -13,7 +13,7 @@
 	};
 
 	chosen {
-		u-boot,spl-boot-order = &emmc, &sdmmc;
+		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
 	};
 
 	dmc: dmc {
-- 
2.43.0

