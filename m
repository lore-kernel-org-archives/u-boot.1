Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40238CCD183
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 11:14:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DECF83885;
	Sun, 19 Oct 2025 13:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="0AzKtK6t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 712FE838A0; Sun, 19 Oct 2025 13:14:10 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B9778382E
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 13:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=7ec7=44=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1760872446;
 bh=ecDJ8JvKQ91D9uWnWL7PO86XVAmtHvls+uDhBe+qpAA=;
 b=0AzKtK6t9czun1wP+EIuIIEkwXXt2p3xB6cW6PYWNEoFkptA9bb2D0tuF53vCQyfZebNk3Zh+
 Yu469ef7JRKdFiRS6+a60JZjei36KUUYgM7xm5PV4ZmL4OfFxuI/tx24HWQ9dpCclS63sRNHWLs
 sSm9wrFqdsjPGtz4VzEdnnaEJiWBmhCtoCOAOGkrcO3Awstc7JQlWI0LlQ7c4daIF1dthTygJST
 GhpzyqQjQVRa9Gtb/TsdYxyNv4FWneV0hL/9de8RU2GI5BblFX61WUO+m75kQ+e/mmJcHihzOuy
 FP4k42ZP5oC86a9qa68oEJ0XdS5M5fadzAzithEgKrvw==
X-Forward-Email-ID: 68f4c7fa981316ada651c58a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.3.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] rockchip: rk3528-radxa-e20c: Drop eMMC HS200 prop from board
 u-boot.dtsi
Date: Sun, 19 Oct 2025 11:13:54 +0000
Message-ID: <20251019111357.723242-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
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

The commit f8cb3fde935e ("arm: dts: rockchip: Fix eMMC write on RK3528")
added a missing mmc-hs200-1_8v prop to boart u-boot.dtsi.

Remove this boart u-boot.dtsi mmc-hs200-1_8v prop now that the board dt
from dts/upstream after the v6.17-dts sync includes this prop.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
index 16c47e6b9a9e..3e2fbd81da17 100644
--- a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
+++ b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
@@ -2,10 +2,6 @@
 
 #include "rk3528-u-boot.dtsi"
 
-&sdhci {
-	mmc-hs200-1_8v;
-};
-
 &vdd_arm {
 	regulator-init-microvolt = <953000>;
 };
-- 
2.51.0

