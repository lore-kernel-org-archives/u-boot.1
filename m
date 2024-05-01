Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4B7C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 19:24:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EE9A882E5;
	Wed,  1 May 2024 21:24:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="KkvzfuqA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6CB8882DF; Wed,  1 May 2024 21:24:13 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C95D8831B
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 21:24:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=373c=MF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1714591443;
 bh=us679qFuDKKFSRb8WbiLPr6zAsx+9cqsF4nUj/zylzs=;
 b=KkvzfuqAoPUPts0tF0XtL53Mfc2F0zYrw5Whe7R3fixzidrGC8jHr2OFH2xksfLCn+FMMinke
 DL0Y9ltaNuX4SruX3HJ5DxKTwi9KNdrNq7ISFBW4cnNDNVnXjdrTHe3mBnHHeNJ1u7hdpbqQ28B
 sZ9wO3FNDO/FwJQUB5E/qA4Oh7D0IHhjpOZeaQ3wV+TdVBcaZzXYRVW7L4Y5SCmGKlJlUGzV4pC
 rScYKbY2MZQ0RasPA23PylGjXP2DK/I4Ucws4zHIPXQ8AfrriIsskgyYwcx6MtD8DaxuXgP3gFS
 atmeDMiIbhTfVetMygL9LTJYN7G4ReTUIHkQOyPzh4oQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: [PATCH] clk: rockchip: rk3328: Add SCLK_USB3OTG_REF support
Date: Wed,  1 May 2024 19:23:50 +0000
Message-ID: <20240501192352.962891-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 663296ce1762e4071b82040c
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

The SCLK_USB3OTG_REF clocks is used as reference clock for USB3 block.

Add simple support to get rate of SCLK_USB3OTG_REF clocks to fix
reference clock period configuration.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
This has been runtime tested on a Rock64 and NanoPi R2S Plus.
---
 drivers/clk/rockchip/clk_rk3328.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3328.c b/drivers/clk/rockchip/clk_rk3328.c
index 87075ec71340..314b903eaa03 100644
--- a/drivers/clk/rockchip/clk_rk3328.c
+++ b/drivers/clk/rockchip/clk_rk3328.c
@@ -706,6 +706,9 @@ static ulong rk3328_clk_get_rate(struct clk *clk)
 	case PCLK_HDMIPHY:
 		rate = rk3328_hdmiphy_get_clk(priv->cru);
 		break;
+	case SCLK_USB3OTG_REF:
+		rate = OSC_HZ;
+		break;
 	default:
 		return -ENOENT;
 	}
@@ -780,6 +783,7 @@ static ulong rk3328_clk_set_rate(struct clk *clk, ulong rate)
 	case PCLK_DDR:
 	case ACLK_GMAC:
 	case PCLK_GMAC:
+	case SCLK_USB3OTG_REF:
 	case SCLK_USB3OTG_SUSPEND:
 	case USB480M:
 		return 0;
-- 
2.43.2

