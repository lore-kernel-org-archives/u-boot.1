Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43ED4C83F1A
	for <u-boot@archiver.kernel.org>; Sun, 13 Jul 2025 23:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E193E82F14;
	Mon, 14 Jul 2025 01:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="rKeDSQkr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C779082E37; Mon, 14 Jul 2025 01:34:55 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7468C805D7
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 01:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=afea=Z3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752449686; bh=KdT76BXxW4K0fU3GF/iEuEyhr0xlfISvR9MS5yGIiAc=;
 b=rKeDSQkrxtp7SHhwGPzkdzRkmHv4aFPwYUhr6qYAK68H+mAzlyNnGva/jUXMisx/DUrs/Uwmw
 ggubHJwN/NWtWUDPT5mU+uy1HspXncu7YMu4LB2BbD6sq0DVfOFWLylDjWM+I4ViYrnzboes/NY
 cGukKA7O49bYdln4g9yITmd4tkhZSan+FwHYKAJR0UEYp+NltKGHk3u8iuHAlqJwdrYaMx6apGT
 M6Yi1eX/08HUSmigrcd8Fpr2PIkIdRF3AqJTvpVMBENaVUBVC8g7i11owamqkopAaa2kNhQbDmo
 1sw4WljlKasAlvOd4OBza+Aqbvads7H0DuK0a3Ol2CiA==
X-Forward-Email-ID: 687442925c59ddd2f404fd9d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 01/17] clk: px30: Allow use of GPU and WIFI_PMU in
 assigned-clocks
Date: Sun, 13 Jul 2025 23:33:49 +0000
Message-ID: <20250713233429.1376172-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250713233429.1376172-1-jonas@kwiboo.se>
References: <20250713233429.1376172-1-jonas@kwiboo.se>
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

Add dummy implementation of set_rate for SCLK_GPU and SCLK_WIFI_PMU to
allow use of dts/upstream assigned-clocks in cru and pmucru nodes.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_px30.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/rockchip/clk_px30.c b/drivers/clk/rockchip/clk_px30.c
index ad7e1c0f2460..b5054e84c326 100644
--- a/drivers/clk/rockchip/clk_px30.c
+++ b/drivers/clk/rockchip/clk_px30.c
@@ -1360,6 +1360,9 @@ static ulong px30_clk_set_rate(struct clk *clk, ulong rate)
 	case SCLK_GMAC_RMII:
 		ret = px30_mac_set_speed_clk(priv, rate);
 		break;
+	/* Might occur in cru assigned-clocks, can be ignored here */
+	case SCLK_GPU:
+		break;
 #endif
 	default:
 		return -ENOENT;
@@ -1726,6 +1729,9 @@ static ulong px30_pmuclk_set_rate(struct clk *clk, ulong rate)
 	case SCLK_UART0_PMU:
 		ret = px30_pmu_uart0_set_clk(priv, rate);
 		break;
+	/* Might occur in pmucru assigned-clocks, can be ignored here */
+	case SCLK_WIFI_PMU:
+		break;
 	default:
 		return -ENOENT;
 	}
-- 
2.49.0

