Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24E7C4345F
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 18:15:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D153888047;
	Sat, 13 Apr 2024 20:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="lURTyy9k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D68648800C; Sat, 13 Apr 2024 20:14:52 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50B2783333
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 20:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ef8c=LT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713032078; bh=HPKOhJJ5ZRqb1jsQjU0ZmDL+VyE+QGSIn28TVTHihmI=;
 b=lURTyy9kJSwdU71/wk8vJv3qoeNJJuF5/AQgnSpEnMh7CyuExrOtI4BUTUAL7B+7oAoPWCdUx
 lgQVaj8kXf3DvR08vxf3KxDD+Tm29TpU+6gy/OQHOH9HuBIewl6CFdkbbv3y0QVNYIdoRTtHx8W
 cyZEi6xVNmbteWLZfeG9TA2jzHIrPkAtyvvIGlqPCDOBINHJiwRtjuR7XiVmxwWI9Vg4FFrEugN
 6uHFNeYmT6HVliaT1u6E8GEKVC76V8vtg5E0s2jpGy4L/aXwlL2MsyVJ2qVLsGCXrQxXE3i9h1H
 6zaAmFOzzeOz3XjF6tefTIyaKYmJ09kK26LDMj13ZBSg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 01/23] clk: rockchip: rk356x: Add CLK_USB3OTGx_REF support
Date: Sat, 13 Apr 2024 18:13:35 +0000
Message-ID: <20240413181425.1384357-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240413181425.1384357-1-jonas@kwiboo.se>
References: <20240413181425.1384357-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 661acb8e6fbb975d49a653c5
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

The CLK_USB3OTGx_REF clocks is used as reference clock for USB3 block.

Add simple support to get rate of CLK_USB3OTGx_REF clocks to fix
reference clock period configuration.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 drivers/clk/rockchip/clk_rk3568.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index 57ef27dda893..999f48ea4b4e 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -2417,6 +2417,8 @@ static ulong rk3568_clk_get_rate(struct clk *clk)
 	case BCLK_EMMC:
 		rate = rk3568_emmc_get_bclk(priv);
 		break;
+	case CLK_USB3OTG0_REF:
+	case CLK_USB3OTG1_REF:
 	case TCLK_EMMC:
 		rate = OSC_HZ;
 		break;
@@ -2596,6 +2598,8 @@ static ulong rk3568_clk_set_rate(struct clk *clk, ulong rate)
 	case BCLK_EMMC:
 		ret = rk3568_emmc_set_bclk(priv, rate);
 		break;
+	case CLK_USB3OTG0_REF:
+	case CLK_USB3OTG1_REF:
 	case TCLK_EMMC:
 		ret = OSC_HZ;
 		break;
-- 
2.43.2

