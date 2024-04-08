Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F855CD1292
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 18:16:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 193AD88139;
	Mon,  8 Apr 2024 20:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="z9hHZmNA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ADDA8812B; Mon,  8 Apr 2024 20:15:16 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 356FD88148
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 20:15:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0d79=LO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1712600102; bh=YUyX16q5OQhufVtSsXUbfYOwLMOAQ1MWs1bd0rk75wQ=;
 b=z9hHZmNAtegexquyWaPqAY1nSpwZJ7q3kt0Mn10S+PLoHMcB0Ojwy9UyjnlI2SFb6XbFO3KfH
 jdo4/Qx31pPjMrEj26O488kG/eE/4Xy2+3nIPqGi1sxONINn2fdKXgTjygekvyfyaJVuY1t3ABP
 q+lAV4yJ6XG3FVnrxDCc7b/ksIyJpR8H8iq7ouqhfNzA/SdJYJmFd2tiqRk3XxD4nlSArVF3VDj
 0RWnUMMAh4zPi0FrPPkvEnHF9edCPlr3+OZf2NRGpVDj34C1q7gA9I3FIAeEEUjyLJFoAGtsmoV
 oIIjcRcIThhczzAK7aJHud+CUS98NOUcMoZZVpTlhlCA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v2 08/14] clk: rockchip: rk3308: Add dummy support for USB480M
 clock
Date: Mon,  8 Apr 2024 18:14:05 +0000
Message-ID: <20240408181429.3676856-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240408181429.3676856-1-jonas@kwiboo.se>
References: <20240408181429.3676856-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6614342545fff4c2aa5b4a8a
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

Add dummy support for setting parent of USB480M clock.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 drivers/clk/rockchip/clk_rk3308.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3308.c b/drivers/clk/rockchip/clk_rk3308.c
index 7515fc8bb244..c46b58e31626 100644
--- a/drivers/clk/rockchip/clk_rk3308.c
+++ b/drivers/clk/rockchip/clk_rk3308.c
@@ -1085,6 +1085,8 @@ static ulong rk3308_clk_set_rate(struct clk *clk, ulong rate)
 	case SCLK_RTC32K:
 		ret = rk3308_rtc32k_set_clk(priv, clk->id, rate);
 		break;
+	case USB480M:
+		return 0;
 	default:
 		return -ENOENT;
 	}
@@ -1117,6 +1119,8 @@ static int __maybe_unused rk3308_clk_set_parent(struct clk *clk, struct clk *par
 	switch (clk->id) {
 	case SCLK_MAC:
 		return rk3308_mac_set_parent(clk, parent);
+	case USB480M:
+		return 0;
 	default:
 		break;
 	}
-- 
2.43.2

