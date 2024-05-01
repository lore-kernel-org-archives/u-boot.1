Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FB1C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 16:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B93E888B15;
	Wed,  1 May 2024 18:23:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="c1F4ZLfA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B9D388B0D; Wed,  1 May 2024 18:23:58 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76BEB88B4D
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 18:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=373c=MF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1714580611; bh=Y5awLWJQqk/iDuZ4MKTg4qwh54svK36EadJrpeEvuTE=;
 b=c1F4ZLfAzlznOSZjfVxdJlfl/6ta0jxQfo/VcyMo+1VpwXT6h6IxWWpY3MejE4rY9wwPW5R3L
 IDUmhD1I72KOPQYASUgF4qOV2IjffCtTlhuBuQ6UD88y8ARPyc+PGxd7F06jGOAQQSOrLe8C8jZ
 Pyar/+KevdhQUhJ86HWB4iX2xH+QAs1caVC5fNLOTBBZ4ZsuMbPkWtyvFc/Fyh5ZUIItgWXg2lL
 9hSlv1mWrVncRkeh8G2rHKmP9Oe/6OjpXtvIJgQRFBfQpziDkpiF/hOKxehqkV5IeI39X8TdQGL
 XQy0FZu2xsyr17c02BoYycHlGyCrWY+EunG3j1dI7pBQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>, Christopher Obbard <chris.obbard@collabora.com>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v2 04/22] clk: rockchip: rk3399: Add SCLK_USB3OTGx_REF support
Date: Wed,  1 May 2024 16:22:21 +0000
Message-ID: <20240501162308.875193-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240501162308.875193-1-jonas@kwiboo.se>
References: <20240501162308.875193-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66326c813e72fadc559db9d3
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
Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2: Collect r-b tags
---
 drivers/clk/rockchip/clk_rk3399.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
index 0b3223611a32..67b2c05ec9ed 100644
--- a/drivers/clk/rockchip/clk_rk3399.c
+++ b/drivers/clk/rockchip/clk_rk3399.c
@@ -976,7 +976,9 @@ static ulong rk3399_clk_get_rate(struct clk *clk)
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

