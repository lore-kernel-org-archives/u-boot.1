Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B3DC04FF6
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 06:30:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F147488342;
	Mon, 22 Apr 2024 08:30:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="VKphceQO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2379588336; Mon, 22 Apr 2024 08:30:08 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59B6388330
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 08:30:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fac=L3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713767390; bh=VrPXU6QrH7mn5qv5PatrKTyea5uf0FvaAaPy22u7F8Y=;
 b=VKphceQOO9IztX3GsX6ycx8EkRd7CMON49k61cJGJaCcO+WHTigJeI84UypK4ziPadObsKTll
 Yh4fGObM+pFThcIN0gb05Pbn7O2KJ1q+PZurOhg25c5H/EWz/cl4xOU8mUdEvTYELA/2mkCElhI
 mcEtKw4RySV8nSywHYlE7lfDjNT/y8ql+cLDiUyalOlx8Ubs4GgaU6cA+TQDWzbMwEOmsk5LV0J
 E6qTg1gX60+qb1y4wc2rmv3gZowGNk2FSh/z5m3vpIwlXzyO1ly9bCTZrlGTzIzq8Suw8C9Fiwf
 6q1L1YFYeX3a6BlLuIHq2d6UUQwionFMaXLMjE/LIqFw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>, u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 02/28] clk: rockchip: rk3588: Add REF_CLK_USB3OTGx support
Date: Mon, 22 Apr 2024 06:28:39 +0000
Message-ID: <20240422062936.681359-3-jonas@kwiboo.se>
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
 149.28.215.223
X-ForwardEmail-ID: 662603dd34ba165ad447427e
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

The REF_CLK_USB3OTGx clocks is used as reference clock for USB3 block.

Add simple support to get rate of REF_CLK_USB3OTGx clocks to fix
reference clock period configuration.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Acked-by: Sean Anderson <seanga2@gmail.com>
---
v3: Collect a-b tag
v2: Collect r-b tag
---
 drivers/clk/rockchip/clk_rk3588.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index 8f33843179b0..4c611a390499 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -1569,6 +1569,9 @@ static ulong rk3588_clk_get_rate(struct clk *clk)
 	case DCLK_DECOM:
 		rate = rk3588_mmc_get_clk(priv, clk->id);
 		break;
+	case REF_CLK_USB3OTG0:
+	case REF_CLK_USB3OTG1:
+	case REF_CLK_USB3OTG2:
 	case TMCLK_EMMC:
 	case TCLK_WDT0:
 		rate = OSC_HZ;
@@ -1734,6 +1737,9 @@ static ulong rk3588_clk_set_rate(struct clk *clk, ulong rate)
 	case DCLK_DECOM:
 		ret = rk3588_mmc_set_clk(priv, clk->id, rate);
 		break;
+	case REF_CLK_USB3OTG0:
+	case REF_CLK_USB3OTG1:
+	case REF_CLK_USB3OTG2:
 	case TMCLK_EMMC:
 	case TCLK_WDT0:
 		ret = OSC_HZ;
-- 
2.43.2

