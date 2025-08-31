Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48456CA0FE8
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 16:53:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B782839D6;
	Sun, 31 Aug 2025 18:51:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="iyjkAEoU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A2C8839E2; Sun, 31 Aug 2025 18:51:37 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBB10839B1
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 18:51:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b2fe=3M=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1756659093; bh=2aXhbH2/T3Q6TZB4AyatyBekyzA3U4EaVNZ6rWzj8rY=;
 b=iyjkAEoUhXugQqV3y8FJIQdqsI83T4l2hYpVY9Th85T3oq2RfgHkydmylF8ZSJBFMxLpUjaIw
 mv2NrYIzDloaJOqA+WAuHBT83Gl7sFpRVHD2RydhbS5mZ87c7mtHODzfY88KZjWMVnGo+2Z3RXv
 fKHxahz8KWgFwl4n3AdFaeBllse7JugMfXA/rcDOw/7LmeHOV993FMWULHkZi26lH4uaAyabu++
 4uvLaA4Vqs+ZC1aprm8PxsrGjs9UKv3/G3C/QIX+A4lGEBUU037DvdnspPXGwVQwqigWh3G7j7y
 KiLcoetoyHmuR1QyTG0epaXAiMZPt343m67rEip00Mwg==
X-Forward-Email-ID: 68b47d927f68b507ca9c3bb6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.2.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 18/18] arm: dts: rockchip: Include OTP in U-Boot pre-reloc
 phase for RK3326
Date: Sun, 31 Aug 2025 16:49:35 +0000
Message-ID: <20250831165001.2749711-19-jonas@kwiboo.se>
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

Update rk3326-u-boot.dtsi to include OTP in U-Boot pre-reloc phase for
checkboard() to be able to read information about the running SoC model
and variant from OTP and print it during boot:

  U-Boot 2025.07 (Jul 13 2025 - 10:07:16 +0000)

  Model: ODROID-GO Super
  SoC:   RK3326
  DRAM:  1 GiB (total 1022 MiB)

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 arch/arm/dts/rk3326-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/rk3326-u-boot.dtsi b/arch/arm/dts/rk3326-u-boot.dtsi
index be1dd4f91c1b..6503a9382b9c 100644
--- a/arch/arm/dts/rk3326-u-boot.dtsi
+++ b/arch/arm/dts/rk3326-u-boot.dtsi
@@ -61,6 +61,10 @@
 	bootph-all;
 };
 
+&otp {
+	bootph-some-ram;
+};
+
 &pcfg_pull_none {
 	bootph-all;
 };
-- 
2.51.0

