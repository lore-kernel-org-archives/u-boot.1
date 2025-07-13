Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5461C83F1A
	for <u-boot@archiver.kernel.org>; Sun, 13 Jul 2025 23:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D4BD82FAB;
	Mon, 14 Jul 2025 01:35:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ERYSxWuS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F37F82F03; Mon, 14 Jul 2025 01:34:59 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A8DC81FEE
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 01:34:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=afea=Z3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752449687; bh=wDJ0PQzzndLki5eIZKxrDGeOhryh1WapsbhcZPD7tf4=;
 b=ERYSxWuSB6xmdfSzj2jIZO5PmXUpHDLDsp/Yb7fY/JILgWTAWvw+tc6R5IATMT+OhaeWHt1I9
 invjn2ml3Qk5E5BXs1j0f1F4gYK4M2aKdihw+HqM0Ib7C24YF1XSVzV9lHob7FNGbo3wkh1XQXa
 X4iEclW6znUPN5ImwCp/mTKSR78onapCbGI5qBbiZMPh+XPSu2TX10ATD/xejU4CxGJu/c1D4YE
 3rj6bxN36Eugg/IKnbf/sKv35xqm+zW6MO/fygx6g6ySxOrMoWmt4RykuyW425/+gjd0H44Kiob
 4UGiWo9yGDdnb1A2MSYiie14stjyeWsupnrDtye3G7OQ==
X-Forward-Email-ID: 687442955c59ddd2f404fdcb
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 02/17] rockchip: odroid-go2: Remove cru assigned-clocks
 override
Date: Sun, 13 Jul 2025 23:33:50 +0000
Message-ID: <20250713233429.1376172-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250713233429.1376172-1-jonas@kwiboo.se>
References: <20250713233429.1376172-1-jonas@kwiboo.se>
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

Remove the cru assigned-clocks override now that SCLK_GPU is supported
by the clock driver.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
index a0ab8b69f2e4..f37daa893c79 100644
--- a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
+++ b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
@@ -32,18 +32,8 @@
 	};
 };
 
-/* U-Boot clk driver for px30 cannot set GPU_CLK */
 &cru {
 	bootph-all;
-	assigned-clocks = <&cru PLL_NPLL>,
-		<&cru ACLK_BUS_PRE>, <&cru ACLK_PERI_PRE>,
-		<&cru HCLK_BUS_PRE>, <&cru HCLK_PERI_PRE>,
-		<&cru PCLK_BUS_PRE>, <&cru PLL_CPLL>;
-
-	assigned-clock-rates = <1188000000>,
-		<200000000>, <200000000>,
-		<150000000>, <150000000>,
-		<100000000>, <17000000>;
 };
 
 &gpio0 {
-- 
2.49.0

