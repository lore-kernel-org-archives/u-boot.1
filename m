Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6EEC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BC528886C;
	Tue, 30 Jul 2024 16:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="sJrbprA2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F7A08886C; Tue, 30 Jul 2024 16:52:29 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41FA5888A7
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=18d8=O7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722351142; bh=XPApG9WM8NUX+An6baJyUIhtrX0mImynaLj/WS/h4fM=;
 b=sJrbprA2MyqMT9xlJYifMYflbk/tqj+OCWsRRZgfpPICMDZMzMOe7mz0kC1SrN1MgJCWmas3M
 /kdSiwXqMeygVr/z3x2RVTRpo7a0+DYeH/fgAXlXOxlrFQkEO2JKa1CaPF+M96F2V6IokfLwTQ0
 TCxJ5LDpnMLglJ4VOcJKGsTwzHAkzHn0E4EQzn91bDQX3u11V9bsqXZ4F9MmXtXMwMJ4cGZL15Y
 5jUzlpT9oUa6OU6Or51mUPETElkcR5eFfQdki7JrJJLMFCgRuJZpi4ApoT0659AvbGtlEuB4DRs
 W/L6U/kAzl4GE65Pki1B48sn30ApiKv6wwygKluzzpxg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 7/8] rockchip: rk3308-rock-pi-s: Remove unnecessary u-boot
 dtsi overrides
Date: Tue, 30 Jul 2024 14:51:47 +0000
Message-ID: <20240730145148.849245-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730145148.849245-1-jonas@kwiboo.se>
References: <20240730145148.849245-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66a8fe2288a51d097cb1562e
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

With the emmc and uart0 DT nodes updated to v6.11-rc1 in dts/upstream
there is no longer any need to keep overrides in board u-boot dtsi.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi b/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi
index a6fb8b12da38..ff5bab316a34 100644
--- a/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi
+++ b/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi
@@ -4,17 +4,6 @@
  */
 #include "rk3308-u-boot.dtsi"
 
-&emmc {
-	cap-sd-highspeed;
-	pinctrl-names = "default";
-	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus4>;
-};
-
-&emmc_bus4 {
-	bootph-pre-ram;
-	bootph-some-ram;
-};
-
 &u2phy_otg {
 	/delete-property/ phy-supply;
 };
@@ -24,14 +13,6 @@
 	clock-frequency = <24000000>;
 };
 
-&uart0_cts {
-	bootph-all;
-};
-
-&uart0_rts {
-	bootph-all;
-};
-
 &uart0_xfer {
 	bootph-all;
 };
-- 
2.45.2

