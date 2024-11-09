Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A794D5E374
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 21:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C23B989327;
	Sat,  9 Nov 2024 22:04:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="k4b1fFKi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAF4089234; Sat,  9 Nov 2024 22:04:55 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71AB189304
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 22:04:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f1ff=SF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1731186288; bh=gqDj1dgwTX2WxRAImg6JVrMslprVn2oGfbLHE8E53+w=;
 b=k4b1fFKiBEoeLOiobTejhGnT90QXHujML88xt5/usXI33OfB56I5kl95DwShhhqDsMFnIkzcA
 zwaqo+7vTcUtGhjLHr0ym1hGYPhB4FIfpKRzqhrpbwlLT4+dKGtvGGEReWJeV5M1XbhtfAC9cav
 vs99XPqbD96KCbBA+ywaUubfXSaoedplxJ/nBd/4VKN2Vb/WuKaiQC5FHvSLYokR4ZSFvt238CD
 7Hg7EOIgfAv4jFBBLXGvuhrjF3sdNLs7qMagFj7mR1TflMsArQd0ZAc0Q+h9M/uFmrQFhdp2y1T
 23kgkwMzpQ/X+XQRRV7xIVcFpCObmeIhNsM6k8tkcRGg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 2/4] rockchip: clk: rk3288: Drop use of SCLK_MAC_PLL
Date: Sat,  9 Nov 2024 21:04:10 +0000
Message-ID: <20241109210427.884888-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241109210427.884888-1-jonas@kwiboo.se>
References: <20241109210427.884888-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 672fce6febcd1468e2815be2
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

The SCLK_MAC_PLL id is not exported or referenced upstream. It is also
not referenced in vendor U-Boot or vendor kernel 4.4, 4.19, 5.10 or 6.1.

Relax the check for parent id SCLK_MAC_PLL when using internal clock
source for gmac to allow use of clock/rk3288-cru.h from dts/upstream.

All in-tree and upstream rk3288 DTs use an external clock as parent,
so no functional change to boards is expected with this change.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch to keep code for use of gmac internal clock source
---
 drivers/clk/rockchip/clk_rk3288.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3288.c b/drivers/clk/rockchip/clk_rk3288.c
index 43c44fadbe7a..a4ff1c41abb8 100644
--- a/drivers/clk/rockchip/clk_rk3288.c
+++ b/drivers/clk/rockchip/clk_rk3288.c
@@ -903,11 +903,11 @@ static int __maybe_unused rk3288_gmac_set_parent(struct clk *clk, struct clk *pa
 	int ret;
 
 	/*
-	 * If the requested parent is in the same clock-controller and
-	 * the id is SCLK_MAC_PLL ("mac_pll_src"), switch to the internal
-	 * clock.
+	 * If the requested parent is in the same clock-controller the
+	 * likely parent is the unexported SCLK_MAC_PLL ("mac_pll_src"),
+	 * switch to the internal clock.
 	 */
-	if ((parent->dev == clk->dev) && (parent->id == SCLK_MAC_PLL)) {
+	if (parent->dev == clk->dev) {
 		debug("%s: switching GAMC to SCLK_MAC_PLL\n", __func__);
 		rk_clrsetreg(&cru->cru_clksel_con[21], RMII_EXTCLK_MASK, 0);
 		return 0;
-- 
2.46.2

