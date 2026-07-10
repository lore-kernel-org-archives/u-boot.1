Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FF7C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 10:05:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C8F484A0A;
	Fri, 10 Jul 2026 12:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="lPy7pmqb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A227284119; Fri, 10 Jul 2026 12:05:35 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D31D8341A
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 12:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4682=FE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1783677932; bh=PlQH9QBlCeh7zHkRaIe3kyBKB6pjHmopHyfACL0Ytj8=;
 b=lPy7pmqbwhXnIEOx5KXW3X14MlkG7ucTnzzx/e8zX9PToBrooEBcSN5HJacltQAZcSwpwvqBk
 kf9Wiqpm4KHqS+4Ei04AoRn/Ry6NOOIHkZEGrACxAMbJMn1xo57RLgs7X6TpgHjkxkQLvFiF7To
 LgKeoF+g8Yk2MSqrijcHgm1fdSE9G3m2hW8bFydvd1rM37kjN3PrOa9SSrsrwCu06/05viEAjRn
 15Ac9GTYbyN+CQWcI114Z4CZd3LhWTZnIfKm6je66lK9UeVEXq5B5LRh7PYct3L6DB4ICdAO+Ku
 79YTHcOo0dUBTqVfzTYBNyXcTOqQZVg522tkK1/Oqvww==
X-Forward-Email-ID: 6a50c3e828378fa077a3951f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 1/7] arm64: dts: rockchip: Add watchdog node for RK3528
Date: Fri, 10 Jul 2026 10:05:13 +0000
Message-ID: <20260710100521.3677247-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710100521.3677247-1-jonas@kwiboo.se>
References: <20260710100521.3677247-1-jonas@kwiboo.se>
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

Add the node describing the watchdog on the RK3528 SoC.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patch.msgid.link/20260506092804.3320931-1-heiko@sntech.de

[ upstream commit: eb24b60553e0692cbbec2863ca31d2a56bff098d ]

(cherry picked from commit 87fa1af25f01c71bd8cfc51920b3a6d51d38abe5)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 dts/upstream/src/arm64/rockchip/rk3528.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3528.dtsi b/dts/upstream/src/arm64/rockchip/rk3528.dtsi
index 806b8109f67d..77d314716b43 100644
--- a/dts/upstream/src/arm64/rockchip/rk3528.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3528.dtsi
@@ -983,6 +983,14 @@
 			status = "disabled";
 		};
 
+		wdt: watchdog@ffac0000 {
+			compatible = "rockchip,rk3528-wdt", "snps,dw-wdt";
+			reg = <0x0 0xffac0000 0x0 0x100>;
+			clocks = <&cru TCLK_WDT_NS>, <&cru PCLK_WDT_NS>;
+			clock-names = "tclk", "pclk";
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		saradc: adc@ffae0000 {
 			compatible = "rockchip,rk3528-saradc";
 			reg = <0x0 0xffae0000 0x0 0x10000>;
-- 
2.54.0

