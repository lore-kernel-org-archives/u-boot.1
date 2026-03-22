Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC6AD58CA3
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 21:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43BF483BE1;
	Sun, 22 Mar 2026 22:40:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="PqgvxyuI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D713283FED; Sun, 22 Mar 2026 22:40:22 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F55A82BF2
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 22:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8acd=BX=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1774215619;
 bh=tpCVLVgL4aNwZ2D/z+Hu7xvTXjRZg3qMNWTudxLzp2g=;
 b=PqgvxyuIlJUJsPed50jqmYh4ZocYLzPd2KtofNYaS2IxORBNG7kCRRDP1kR/YL8t4J7ABdzgI
 Ggm0naiJuF7M54CN7s+cPgHsUkpOlOZE2H01h0QXP1XXmebJC8pKwgpqB8etF7KvGU3N6MJG3VC
 eSfz74dCFWE3iirBvlb7s17SdNcM69PivwHaODM/BlJQHn2SyZ764P5x5pbd1zVpTzC3drkp63f
 t3XeEuqwEXQCUOUgwLtbZ3HJHsqouaCVvd3ZAMDeYoijmmzWFB6TP+Puqdq5EY7/iFuss6bnWUq
 kTu1NqVzolGzeWho24vY2Jd3yEIM5s4g6fjKo5MHHcuw==
X-Forward-Email-ID: 69c061be01dbcaee716a1a0e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.6.53
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Stefan Roese <stefan.roese@mailbox.org>,
	Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.denx.de
Subject: [PATCH] watchdog: designware: Fix probe when clk_enable return ENOSYS
Date: Sun, 22 Mar 2026 21:39:55 +0000
Message-ID: <20260322213955.1348690-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.53.0
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

Rockchip SoCs typically reset with all (or most) clocks ungated. Because
of this, U-Boot clock drivers for Rockchip typically do not implement
the optional clk-uclass enable/disable ops.

Normal driver model behavior is to return -ENOSYS when an uclass ops
is not implemented.

Ignore -ENOSYS to allow the designware watchdog driver to be probed on
platforms that do not implement the clk-uclass enable/disable ops, e.g.
Rockchip RK3308.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/watchdog/designware_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/designware_wdt.c b/drivers/watchdog/designware_wdt.c
index bd9d7105366..91228de5e8e 100644
--- a/drivers/watchdog/designware_wdt.c
+++ b/drivers/watchdog/designware_wdt.c
@@ -122,7 +122,7 @@ static int designware_wdt_probe(struct udevice *dev)
 		return ret;
 
 	ret = clk_enable(&clk);
-	if (ret)
+	if (ret && ret != -ENOSYS)
 		return ret;
 
 	priv->clk_khz = clk_get_rate(&clk) / 1000;
-- 
2.53.0

