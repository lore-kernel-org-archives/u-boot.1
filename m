Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B02CD128A
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 20:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6EE9882DF;
	Sun, 31 Mar 2024 22:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="OgsUen06";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7B0187FC0; Sun, 31 Mar 2024 22:30:51 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82691882AF
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3892=LG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711917036; bh=BvRJz7oeLBlWiE/R9n8rDYPGRppUDQScTvCIKtQ/PCo=;
 b=OgsUen06/CzJuXrzcrqvMY9ptd99JgnghRSqsTBKC+SKVHzutCGxGK/h9SIB5NUv6iLn1Wbva
 Po1OqOVjVB++P6QforMZTTlkcZWltAYUoyXY1153poCMhqSvtGNNfoR86UfW9cw72g+zH/FZN05
 5L67jOK/mEnF8jkwUenpuIDySDkmFnSKu8mKzYufeR5Gf3PNl+89NvpA0Gz2EX0Sa5lrE55ZNtI
 ICVwBvCnhUW+hdgWnTo1k81tXq/symMXV+qBx7KGid+Li2eYaaC2QuTfEhdQfbsaYwg+k0jPVNM
 vF6XZut9HupTnmqJNfAzCj+4qIp72OaF5Vmro8zqJ+Cg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 14/31] clk: rockchip: rk3399: Add SCLK_USB3OTGx_REF support
Date: Sun, 31 Mar 2024 20:28:20 +0000
Message-ID: <20240331202921.262323-15-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240331202921.262323-1-jonas@kwiboo.se>
References: <20240331202921.262323-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6609c7ea8fc6b45ed44f735e
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

The SCLK_USB3OTGx_REF clocks is used as reference clock for USB3 block.

Add simple support to get rate of SCLK_USB3OTGx_REF clocks to fix
reference clock period configuration.

Also replace use of 24000000 with the OSC_HZ constant.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_rk3399.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
index 29b01abeca06..6408c5d0aa6a 100644
--- a/drivers/clk/rockchip/clk_rk3399.c
+++ b/drivers/clk/rockchip/clk_rk3399.c
@@ -956,7 +956,9 @@ static ulong rk3399_clk_get_rate(struct clk *clk)
 	case SCLK_UART1:
 	case SCLK_UART2:
 	case SCLK_UART3:
-		return 24000000;
+	case SCLK_USB3OTG0_REF:
+	case SCLK_USB3OTG1_REF:
+		return OSC_HZ;
 	case PCLK_HDMI_CTRL:
 		break;
 	case DCLK_VOP0:
-- 
2.43.2

