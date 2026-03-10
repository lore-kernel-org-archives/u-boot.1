Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8EDFCC9A4
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 01:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A53D283981;
	Tue, 10 Mar 2026 02:02:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="CZqrDpUp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EC54839DF; Tue, 10 Mar 2026 02:02:30 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E174280050
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 02:02:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2964=BK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1773104545;
 bh=CQETkcFzGfr2sDUDXRGj/0AfE1UzR09lFYqOrwNt4Xk=;
 b=CZqrDpUpSBG4H8SdvyxLWxhRpROwIc47eRU49Y76Gsc3ceWX0xmSa9U9MI5BRZtfcQ2wQjfOU
 NzNbLpGckL25+uj3qA0jlH/1vU2C9sCG7I7VHfx/EUPLUL8nmsW2NLCI7r1HJWICWwF8+DhTug+
 dNeCopV5qgAkb3wTYBKTvMq6xJdsjh2f4pke6imZtf0s9smgmXNS6N5QPuLXXhuh9bAVZv7VGGG
 uW7adYMaQ46HJCA4F3MoJu7KegUsmsDCLbQMKfaKDYXas6vvltmtyXnH67Lw12yg7ON/DxznPXJ
 3B2nRnj/0cKLI3At3G7eT8jebTYXgl/5wjMKkBu6EfqQ==
X-Forward-Email-ID: 69af6d9e1f0f38c7406f71a5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.6.49
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.denx.de
Subject: [PATCH] clk: rockchip: rk3576: Add CLK_REF_USB3OTGx support
Date: Tue, 10 Mar 2026 01:02:13 +0000
Message-ID: <20260310010217.611910-1-jonas@kwiboo.se>
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

The CLK_REF_USB3OTGx clocks are used as reference clocks for the two
DWC3 blocks.

Add simple support to get rate of CLK_REF_USB3OTGx clocks to fix
reference clock period configuration.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
This fixes the ref_clk issue on RK3528 that is also fixed by "usb: dwc3:
core: Use IS_ERR_VALUE() for ref_clk rate check" [1].

[1] https://lore.kernel.org/u-boot/20260209201415.303190-1-jonas@kwiboo.se/
---
 drivers/clk/rockchip/clk_rk3576.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index 125b08ee8322..59bdfea74258 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -1989,6 +1989,8 @@ static ulong rk3576_clk_get_rate(struct clk *clk)
 	case HCLK_SDIO:
 		rate = rk3576_mmc_get_clk(priv, clk->id);
 		break;
+	case CLK_REF_USB3OTG0:
+	case CLK_REF_USB3OTG1:
 	case TCLK_EMMC:
 	case TCLK_WDT0:
 		rate = OSC_HZ;
@@ -2153,6 +2155,8 @@ static ulong rk3576_clk_set_rate(struct clk *clk, ulong rate)
 	case HCLK_SDIO:
 		ret = rk3576_mmc_set_clk(priv, clk->id, rate);
 		break;
+	case CLK_REF_USB3OTG0:
+	case CLK_REF_USB3OTG1:
 	case TCLK_EMMC:
 	case TCLK_WDT0:
 		ret = OSC_HZ;
-- 
2.53.0

