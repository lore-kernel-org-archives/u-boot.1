Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601FDC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 06:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B66E6883A3;
	Mon, 22 Apr 2024 08:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="hp/N3TrZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B801883AD; Mon, 22 Apr 2024 08:31:05 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2F2388329
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 08:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fac=L3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713767446; bh=sNbIJLKq+CcKXZXkCxiXAd15VNfPotgs5vMtL6/j+pk=;
 b=hp/N3TrZXEX7+kmGZX/wPBgKlJmAUtewfSdjVdJP6dwjeieZ7dtWYH4/GhO9COBxbRToRqyXO
 TG4JwRxBNwnnG+ufbuczAYZNZF5fb4EIENkBVx3YilirUO3P4DKJ5P0tT+ZKi6eR/qkDn9Pkhiy
 Rmwn2wMDXOu6+0yf52x6jYEI98SpAaXKvFwlmkgZuIkWLnani0m1h02d2KUoggSGjDwGqYa/R5h
 FPSkahFBA6lg9Q5RE1RnFM3b9c5mR5MiDO96IHGYAw5C9n8UIv1ltmNFhF6JTdyFkj12gLWBpYn
 uNMJQm8Yr165dv3zleF6oGR1WNCLJvZJmw1FfL18fuJQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andyshrk@163.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>, u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 18/28] rockchip: rk3588-coolpi: Fix .dtb-file entries in
 Makefile
Date: Mon, 22 Apr 2024 06:28:55 +0000
Message-ID: <20240422062936.681359-19-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422062936.681359-1-jonas@kwiboo.se>
References: <20240422062936.681359-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 6626041534ba165ad44743e1
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

Fix CoolPi 4 Model B and CoolPi CM5 EVB .dtb-file entries in Makefile.

Fixes: 3e15dee38d45 ("board: rockchip: Add support for rk3588 based Cool Pi CM5 EVB")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
---
v3: New patch, split from rk3588-coolpi documentation patch
v3: Collect r-b tag
---
 arch/arm/dts/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index b1c9c6222e5d..313ef34f5cb7 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -167,8 +167,8 @@ dtb-$(CONFIG_ROCKCHIP_RK3568) += \
 	rk3568-rock-3a.dtb
 
 dtb-$(CONFIG_ROCKCHIP_RK3588) += \
-	rk3588s-coolpi-4b.dts \
-	rk3588-coolpi-cm5-evb.dts \
+	rk3588s-coolpi-4b.dtb \
+	rk3588-coolpi-cm5-evb.dtb \
 	rk3588-edgeble-neu6a-io.dtb \
 	rk3588-edgeble-neu6b-io.dtb \
 	rk3588-evb1-v10.dtb \
-- 
2.43.2

