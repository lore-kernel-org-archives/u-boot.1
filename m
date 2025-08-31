Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E71DCA0FE8
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 16:50:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 703CC83929;
	Sun, 31 Aug 2025 18:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="K0EaGszs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2998883937; Sun, 31 Aug 2025 18:50:35 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0B0A83930
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 18:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b2fe=3M=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1756659031; bh=6Xd9DuAFFpN/79F1f5ODz9e6OHcq6/hWNwKUTBkDhzQ=;
 b=K0EaGszsVJ1rgnFaoanrR82VFpPQUP9DwykA2g4wzl6UiMFUkSFhbuvHp6ReDPLknne7xviTB
 8rcLQSUT0qvFi7vpN4c50Jh79+lqxQ4TvIf8uVFgfazJRsqqazLkJe18jiPD3pDOjfiEC0F6Sfz
 aOqcUyytFwTxxB36/omLeDC2bzmPfWedEzvgCz1yWqoZ0B2Mqbi2+2Ley7Ttcb4TTcJKhTSD8Z9
 8tA6DgcD1OE0oCpVGKM+XTJDwJOVXmrJDMRZ1BcRdCQG5MxrBVqOjHV6mfvVaGnTaKZ4bV2nHuL
 6DFCiICSoS+ecGeeddjg0KY96fJreldP/h/dJsir3QGw==
X-Forward-Email-ID: 68b47d557f68b507ca9c39cc
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.2.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 02/18] rockchip: odroid-go2: Remove cru assigned-clocks
 override
Date: Sun, 31 Aug 2025 16:49:19 +0000
Message-ID: <20250831165001.2749711-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250831165001.2749711-1-jonas@kwiboo.se>
References: <20250831165001.2749711-1-jonas@kwiboo.se>
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
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2: Collect r-b tags
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
2.51.0

