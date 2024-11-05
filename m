Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6241D3E775
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 21:52:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EE9A891CE;
	Tue,  5 Nov 2024 22:52:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="KtLtX5dd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA9B6891CE; Tue,  5 Nov 2024 22:52:33 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DB90891D7
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 22:52:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dc50=SB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1730843542; bh=3uRGLaTOB8hbmN4MaKNUZqrgnEo2v/aC8OvDD1DfOMw=;
 b=KtLtX5ddjx5mSEizbwyiRI0X+LbsODulZHEOYMnQ0YmpGyr2qx7JqyNUYNGN3z+EiGOTjHXe7
 kD8+d/bY3Wh+koUHndPH1VDPX5GlD0Oy0Iz/2PyFN+yzzIemwfAYAi8NL8Sg2PVtl3lAts4dqGI
 EvHkGXoTeXvzwoLrP9sWFNrp8SmeUDiphrD6CqtnxBPljBRyn+lMoucCR62Zdf8fQemw2kkXikD
 uSeVX3VkVmOkjri9GuVa6qfTpTSMTozZoOXQ+Hm9D8/aEA2Fw3ln5HzsJtQxGS6SEHJQfSBSmvn
 MHkCCCgXos03l9aNWPR8PHxbEIzxlPQBZl85C7el3gig==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 02/11] rockchip: rk3288-miqi: Remove unused work led node from
 xPL
Date: Tue,  5 Nov 2024 21:51:38 +0000
Message-ID: <20241105215202.1491441-3-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 672a9392059db14dd83d7ae8
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

The work led is not used in xPL on rk3288-miqi, remove bootph props from
the work led node to exclude it from xPL control FDT.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3288-miqi-u-boot.dtsi | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/dts/rk3288-miqi-u-boot.dtsi b/arch/arm/dts/rk3288-miqi-u-boot.dtsi
index ca839390ce74..721d02086939 100644
--- a/arch/arm/dts/rk3288-miqi-u-boot.dtsi
+++ b/arch/arm/dts/rk3288-miqi-u-boot.dtsi
@@ -4,15 +4,6 @@
  */
 
 #include "rk3288-u-boot.dtsi"
-/ {
-	leds {
-		bootph-all;
-
-		work {
-			bootph-all;
-		};
-	};
-};
 
 &dmc {
 	rockchip,pctl-timing = <0x29a 0xc8 0x1f8 0x42 0x4e 0x4 0xea 0xa
-- 
2.46.2

