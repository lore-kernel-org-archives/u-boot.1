Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6641AC87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 23:54:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 546FE832BF;
	Thu, 31 Jul 2025 01:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="uZTBIAdE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9911B8323A; Thu, 31 Jul 2025 01:54:08 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE17B83280
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 01:54:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5dd1=2M=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753919642; bh=nRxqX/nUpmlXSORdlLs9RIJA9qZtXjGoVyZEAqyTev0=;
 b=uZTBIAdEyj5qudQmLJ73G8tCTAgu3gnSWhPoC4ZBE2o5Lae2V0NAJePhSd4Zy1GGKDZvrM4SA
 xxDD4WOHOR4Zd2pKzajfpNsTvDfgcscW8cOQDen2OZCeAGPaVFS3o7n3vR7MD49pV9sqL9Rj1Oo
 XrJEa4hh8F36IVg8oNZH/vm8gygxlArr4dGDN8SCtdZR7xGHF0pKnYjzfPxtdHs4u7XjMRNiqYB
 ExJz6vsSuEdK7oycr3k0auiI4wn9CW7zAOzYTY242n8Az5rYcsdKi1WBuparFbpUVDYKHpQ1+0w
 O+k/XeN9y3sRREyZpHRDqPSurGIPJA3SbcljymBEklBw==
X-Forward-Email-ID: 688ab0741851584377f6212e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 5/8] rockchip: clk: clk_rk3528: Add dummy
 CLK_REF_PCIE_INNER_PHY support
Date: Wed, 30 Jul 2025 23:52:46 +0000
Message-ID: <20250730235301.1774089-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730235301.1774089-1-jonas@kwiboo.se>
References: <20250730235301.1774089-1-jonas@kwiboo.se>
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

Add dummy support for the CLK_REF_PCIE_INNER_PHY clock to allow probe of
the phy-rockchip-naneng-combphy driver on RK3528.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_rk3528.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk_rk3528.c b/drivers/clk/rockchip/clk_rk3528.c
index 06f20895accf..d58557ff56de 100644
--- a/drivers/clk/rockchip/clk_rk3528.c
+++ b/drivers/clk/rockchip/clk_rk3528.c
@@ -1535,6 +1535,7 @@ static ulong rk3528_clk_set_rate(struct clk *clk, ulong rate)
 	/* Might occur in cru assigned-clocks, can be ignored here */
 	case ACLK_BUS_VOPGL_ROOT:
 	case BCLK_EMMC:
+	case CLK_REF_PCIE_INNER_PHY:
 	case XIN_OSC0_DIV:
 		ret = 0;
 		break;
-- 
2.50.1

