Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C323CC83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 22:45:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D17F882C84;
	Sat, 12 Jul 2025 00:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="x1coWGdY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3B2381FEE; Sat, 12 Jul 2025 00:45:16 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCEDC82F8F
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 00:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2656=ZZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752273911; bh=P71yp99+qYouvPtrCiNeWTv0mzyIjy/+4ZAZLD/InlM=;
 b=x1coWGdYORRVpNDknWMs4C8tfrSVKY+T1sD4o9+0I8nXyhDOitHXgkWmdwDGVOKiiGaEhJKDq
 3wvOsd9SLhTrgKT5pTkKs3FVKJPFNYrNeRjPju8k/yRt5DDI4p9QVLqTLXn2A1mhG2zxsfafyGi
 mjHafvBdL3e0mCY1m5QsE1kA71Vd4HISPbEqNS75FqN4EKfShFj6pUB9FCR18Rd4veug4Mj/w40
 1uwvv+EkLuLX2JXXtE5vu2m/aL8SG51+TyqzFNjK8GfXDWCSID4tY3C56aWdQjW7L07aZcApPuI
 l2rWNGKs82aCMk4NuIHI3aEoR6eHNwRNq+R0InDq0DOg==
X-Forward-Email-ID: 687193f226dc7c4d2556119c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 4/6] rockchip: clk: clk_rk3576: Add dummy CLK_REF_PCIEx_PHY
 support
Date: Fri, 11 Jul 2025 22:44:34 +0000
Message-ID: <20250711224446.211511-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711224446.211511-1-jonas@kwiboo.se>
References: <20250711224446.211511-1-jonas@kwiboo.se>
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

Add dummy support for the CLK_REF_PCIEx_PHY clocks to allow probe of the
phy-rockchip-naneng-combphy driver on RK3576.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 drivers/clk/rockchip/clk_rk3576.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index e84a0943a940..125b08ee8322 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -2168,6 +2168,8 @@ static ulong rk3576_clk_set_rate(struct clk *clk, ulong rate)
 	case CLK_CPLL_DIV10:
 	case FCLK_DDR_CM0_CORE:
 	case ACLK_PHP_ROOT:
+	case CLK_REF_PCIE0_PHY:
+	case CLK_REF_PCIE1_PHY:
 		ret = 0;
 		break;
 #ifndef CONFIG_SPL_BUILD
-- 
2.49.0

