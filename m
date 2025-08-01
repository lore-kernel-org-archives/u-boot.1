Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFC8C87FCA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 20:44:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C04B883B87;
	Fri,  1 Aug 2025 22:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ilV1QjQu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FFDB83B7E; Fri,  1 Aug 2025 22:44:04 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B2B783B85
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 22:44:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=984e=2O=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1754081040; bh=2aCTkpQAm5nhOCYxLupFdemw1mrwky0trBrWD7r7LL4=;
 b=ilV1QjQuCKcrsxAKXCIFnqFtSzjz9RlzbC8yoCeE6GzDdcdZofVwYA23IOyHmr9nFQaY+bSxC
 qUy0Zuf7ppWAQK4mUa1Eqz7WkBbUm89o7GL8fV7IQKwLsi0hYcSwdIZoyGJq64iX/XwUgPAsdti
 2lP4SBMoyOETNkVLFcP8jg6lsJYZTCqYBLjgR3Mp4L2m3xAYFI4NTxoc5MaNjZmvcPHEPAYp6Yy
 EP9gHu12vCgaWjdZJ8OjJxpzAcfsf7j29h3VU3yKM789WbQuyYbCjWYxO3u2yBx8Ki9jORvgVWH
 aPFFkljjrP7Kf3IgDhBG5hOsPTOLE332edIjhJfcHIDA==
X-Forward-Email-ID: 688d2709f149f34f87aecb4d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.8
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
Subject: [PATCH v3 1/3] rockchip: clk: clk_rk3576: Add dummy CLK_REF_PCIEx_PHY
 support
Date: Fri,  1 Aug 2025 20:43:37 +0000
Message-ID: <20250801204345.2603723-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801204345.2603723-1-jonas@kwiboo.se>
References: <20250801204345.2603723-1-jonas@kwiboo.se>
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
v3: No change
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
2.50.1

