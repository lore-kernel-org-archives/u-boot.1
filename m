Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C6EC48297
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 00:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12DF387CCE;
	Wed,  7 Feb 2024 01:03:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="KECIwwot";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61C7A87CBF; Wed,  7 Feb 2024 01:03:50 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6647E86F34
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 01:03:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4f0f=JQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1707264193; bh=3XDoas5mLt5Vm4rGn8kDcS1kZ2YBIfx4EqpOTT8uQBA=;
 b=KECIwwot/TdrW0qJmIWpSd0jP9H5+cWebHhA4GFahYhMLmEy84WJXJi72bEaPk/Oex2fVE8yP
 WGj87uUXJhoEz8miIqibChimvfCFY8Ge/HNd9I6uTjfRhioZIbKntPLo+Bys+/w46L8ZXtdrYQL
 MELBWg6V0Ri2X/dExUbYOuXHTfkRLCzj7U2SBw7gSwfs+QMWPPxbjFgAXm/lejwz6oBva/9HEr9
 d7CqCjuKSXmtHSPGgmZ320m/7DF5kIW4cUbkWwFuTejA5FlfspHXq2TXQwp4VJSxOq5EpxxR9Aj
 OEHJlBZ2UMBKXKhx5XvWklKcy5U8dDFfy9QijcBx5rHw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Tianling Shen <cnsztl@gmail.com>, David Bauer <mail@david-bauer.net>, Loic
 Devulder <ldevulder@suse.com>, "Chen-Yu Tsai" <wens@csie.org>, Jonas
 Karlman <jonas@kwiboo.se>, "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH 01/15] rockchip: rk3328: Update default u-boot,
 spl-boot-order prop
Date: Wed,  7 Feb 2024 00:02:30 +0000
Message-ID: <20240207000301.3270722-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207000301.3270722-1-jonas@kwiboo.se>
References: <20240207000301.3270722-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65c2c8bfd5b31093c56fbf30
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

