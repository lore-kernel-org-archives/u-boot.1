Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB4BD3E775
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 21:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE7F18913F;
	Tue,  5 Nov 2024 22:52:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="MgrJ5uwr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75D0F8917B; Tue,  5 Nov 2024 22:52:28 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DB5088E43
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 22:52:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dc50=SB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1730843536; bh=gXM4BCquzKsV7fbNsJX3E2Iz+z7WM+dih6AsO2C9E+g=;
 b=MgrJ5uwrqwkWawR+2is+8HsMAg/+9seJbxarg62KmQV2Sf9Mzz4yNmKQcj9mB+o0PDeh14jEt
 FvwRg5WXOtDdTQIMdjrJIl0M2dlyIGq6T9Rx/PfL/F02M1n9wJCTE9TC8PofLAUa/xqoddBifTM
 kPoK7in4AVvZmznuVPh8S7vQfiFwn0erI5gzUI638v12Znmpzy7zO0JhDf+BCr/7bqHC72crgs/
 UOys7vddL7zoe5+NuVzOOx+96ew0Jl1JaouFSbHOTwF9iEVtQH/z47YMRjz8i7Uj50sjuhrTlCd
 SaFxdMfOP65uk9zlZMJ1GXZKF7wjuq0YQHuRVFYC8SiQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 01/11] rockchip: rk3288-miqi: Sort u-boot.dtsi nodes
 alphabetically
Date: Tue,  5 Nov 2024 21:51:37 +0000
Message-ID: <20241105215202.1491441-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241105215202.1491441-1-jonas@kwiboo.se>
References: <20241105215202.1491441-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 672a938e059db14dd83d7ad6
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

Sort the nodes in rk3288-miqi-u-boot.dtsi in alphabetical order.

This has no intended change to board DT, this only rearrange nodes in
preparation for future changes.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3288-miqi-u-boot.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/rk3288-miqi-u-boot.dtsi b/arch/arm/dts/rk3288-miqi-u-boot.dtsi
index 43cb48bd032d..ca839390ce74 100644
--- a/arch/arm/dts/rk3288-miqi-u-boot.dtsi
+++ b/arch/arm/dts/rk3288-miqi-u-boot.dtsi
@@ -25,11 +25,11 @@
 	rockchip,sdram-params = <0x30B25564 0x627 3 666000000 3 9 1>;
 };
 
-&pinctrl {
+&emmc {
 	bootph-all;
 };
 
-&uart2 {
+&pinctrl {
 	bootph-all;
 };
 
@@ -37,10 +37,6 @@
 	bootph-all;
 };
 
-&emmc {
-	bootph-all;
-};
-
 &sdmmc_bus4 {
 	bootph-pre-ram;
 };
@@ -56,3 +52,7 @@
 &sdmmc_pwr {
 	bootph-pre-ram;
 };
+
+&uart2 {
+	bootph-all;
+};
-- 
2.46.2

