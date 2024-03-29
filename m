Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50317CD1283
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 19:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 231B08824C;
	Fri, 29 Mar 2024 20:02:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="cqHi7D9F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B80C8824C; Fri, 29 Mar 2024 20:02:54 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37E0988260
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 20:02:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=52ff=LE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711738960; bh=HuLdI8xUBdVV49xwinD0ozgY9RZuy2jRLjiCJ9MG51w=;
 b=cqHi7D9FdGCZS2415DBjhw9p2/dO82hMy4Q8uzKOfqRUN6buthZTC5+bO+fnIuJjp/IDS9Cwe
 Jj5cOgftJWKfDWKfp2rVXUfUyuAkyDGC8/wZ6BI9A43FGen6eeiL10u4nQ+KOZL6jAwWV6+DPCz
 i1xRZjd/JXTTy/122D8sNx0nh5PvMigdBUnxz/7ObP3rW4VyQFvijlBnCMnSFZjsGTtocLn0Ier
 dsjIN3DEOaBafsK7/pEh5kXRuzQN1F8WlPVNVO1NsqjBZLMxChlYFleVUGQavb0HKX2mTXRSbJf
 g4eEY1haM2WEuFd7CxwKqVWibN44/8d8GnHSA1/P/2Fw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 02/19] clk: rockchip: rk3588: Add REF_CLK_USB3OTGx support
Date: Fri, 29 Mar 2024 19:01:43 +0000
Message-ID: <20240329190224.3613471-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240329190224.3613471-1-jonas@kwiboo.se>
References: <20240329190224.3613471-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6607104fc77850cc7d0ca060
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

