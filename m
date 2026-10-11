Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09599CA9ED1
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 20:12:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 418D640606;
	Sun, 11 Oct 2026 20:12:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O1XP4i9zHjcY; Sun, 11 Oct 2026 20:12:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 284A34060E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791749575;
	b=B/CW6yPq74XTcIXYCgTk3zxce2Yld/TFnjhKpxSEbCdhG78mPgNlbcrjOPVccaYvw2zZ
	 FETJ9UAQmETNud1/ayWBocU31WJGv+nvMbq3JyfMzW5X7Z6Zwb+76D5jn5CpNoQ0HxCss
	 9fvYryOeWIxf4k5963VwKldDb8GGlVoQyn3C85QX+jAc28vipSf0nFlEyCRepF03OhKWz
	 bMOm7HrIABCjiYqfwnSPA+/NLrs/v36VhoS7fPu2ficbzWfcoP/uLCTrlPbvdiPAU9nV9
	 WimGcfe2YXzXMfwCLPmyss9+EOBmUZl6MatyHAzzTi+J5e2fIsM0UYcn+nMGI/pcx2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791749575;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=kLE4yJx/nqHo6eyU2j1qSXRTb9qfaoPiyPxJ8/eVZIA=;
	b=XL+rrRup2qubN7jq3r5L27Jcq5RAGTUJpvB5nqsCHT1tHGzKNXGO4sUHLbg3F6ZzWC08
	 33dMFbmL9tGcifd7yo9tNLUPIS1EP0KnlDQm/VyAUybhm+e5OL1C5fRuo9uQA8SUDEdP4
	 qeShJ5FY6SL7rhWrv3k/4tUPffYNrWiYBniZhaMp4cprjWHWH2M44t1OVXFh5ppGeAn+k
	 l7mgC18JW7jzYUd7hc+RJU4HgAIUyLLZmHHatyB3waLNuSzNHQDnjyRg/FxfjuhqVT8xy
	 oDmQVZaiH8hK3IvDB4QWhmp/eff9e6UyUYcZre4LrA3Tt9CI5n/rIgzc5DL6NHrihcg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791749575;
	bh=kLE4yJx/nqHo6eyU2j1qSXRTb9qfaoPiyPxJ8/eVZIA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ic2DkiWxH4PM8ZhL7Ody23+sVmTX+IXwCR89UTMbsodmQRLwy4OJm65z828At2fus
	 +inm6kQH7fbBleWE+8c/ThuPf2poodXR+CbzVA3hni00OC/2yZKHM6ZvKmEJxnklQt
	 ywyLMfVNNE7GzXTRveAvw/umH7Yy5VtirvgKwktQW42GeL80cnhmJXC78FWTGQLV10
	 kJgaOP6EJL6yHoYF0OZ7GC8dBTRHyZHQAlNYv1Tsp7qL9ykmQDKZDrrPCG+YtqYIGj
	 WRXF/w+LM6SAlMq6j585QjH/ao3UjvrZ+KzbILk8sqDdwWtwGDnFEvXw53zIsrPKSj
	 QvZ0Wdqut/lkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 284A34060E;
	Sun, 11 Oct 2026 20:12:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CF87ADE0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C15A54008B
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sPj0il473xO2 for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 19:35:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 28AA140075
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791747351;
 b=m2yRlsgxC7Swc7T+/SRbT5tawz8MC8QzWCLCaPQ/cOtYSJJ7y1RnioIA84+gT/VMV0lw
 q0I3GPRG/q/3DBKk5CFGi/L3AZjWBZGL8Orh+MaDZzd56O6fPPspu5Ni9bJ1ee73le9bT
 q5bILfY2TdzsBlxFwLMMS2ImOp0Zu6RNBfr9HwHf5H0OeYsn4N6eYYqqtWRgBO/FT2X76
 j38xZASPbAGeAGLb0SNaH81ejnVhsYFauWCrMTWmFt5pN143s40mccG5gnNWMcmKzAHhN
 ps2cIlvfxzzy5y6vp/am7ctE4Ot0VjfCASXubgcInZaCN0cpY8UeZaMVEJ3+oJ++LkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791747351;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=kLE4yJx/nqHo6eyU2j1qSXRTb9qfaoPiyPxJ8/eVZIA=;
 b=PpE5jLoMAa7OplD1PItSa5eGZUW0yjirXjkAb70kq40QpExex+1k5cygxsIH8GoW3KfY
 NnAmjLQMb+UFPVbzZEBAZARdWa30pqLRuNyvtEVzigqzeWYdjsaXrqdfUpmfJDgW7Srpd
 Y/S6WA11kRaK1rId3Yp0axfwdzZ7ELv7faa/Kh7WZ+55UOxqTjC6dvqrJoey1iZPJFSEG
 RGV6/p8LJavNCSFt/IyI6gDMWK3jGQppOWv6IIPaFpdxpXfA49RJwEdI63EGIoYoJLa8J
 MsWsyqiECMf2eXfG79HbNSOIezlxzhfGW1WamicrJlDxSwbuZxj/0Sy1n9U4RTwwcpA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=hL5nPjf8; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=hL5nPjf8
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 28AA140075
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7070541199;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52B97C2BCFA;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791747349;
 bh=+z2ntvJzhdMQQBd7DY8LCLdU+MgCxaNQzMCzDYITTYQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=hL5nPjf8ZzbO33jIDW4H6xyv6wfPRSx+4a5I2K1npIZm7AoxmI1lc8wlrJdr/6yDl
 LV4x0vSq9S+4788wEZFai+D15GgeGCf8s7nlbI5NXvoNWssH60Gl5alW0YUjZ6o/ow
 8auKJ6gUpn63/MerBOQX5GNuo/ZcfC1FJyu4vjOJLcn4CdGL2JaS+eDiQocWUak3oI
 zc9KxjvFh0xIoSuIeT2+O/K8G94kku7kv0k6uuIbrB8O/7dAonEr7l/lzaqemEYGpg
 oZIKy8NlLROGvjYJkBi6sqQXpzwkeGsamuDA18rDxDWihlXzHqZhgesamYZfCeIGIl
 7E9DMfAP1YhRQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 371BCCA9ECF;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sun, 11 Oct 2026 21:35:44 +0200
Subject: [PATCH v2 2/9] clk: rockchip: rk3399: add the clocks the DSI and
 VOP paths need
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-b4-pinephone-pro-defconfig-v2-2-6b7be35fbee7@protonmail.com>
References: <20261011-b4-pinephone-pro-defconfig-v2-0-6b7be35fbee7@protonmail.com>
In-Reply-To: <20261011-b4-pinephone-pro-defconfig-v2-0-6b7be35fbee7@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>, David Heidelberg <david@ixit.cz>, 
 Ondrej Jirman <megi@xff.cz>, Tom Rini <trini@konsulko.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791747347; l=2340;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=WGZarjKqFfQaJpAXbo2NZOkBnnapWO5KF62gMGVIbbU=;
 b=n7Xhs7hPa1UA/OQrwfRiW3rvwDkz7H7SkkcJHWwD+rujvRi2rcw8RPYI06tX37y7+8EOfY9Xb
 4nTmcLc6AHhD8SVPo3nesBXJJh9BXFHQlP8Z4/QzKuUWR5J0T/N9QmN
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sun, 11 Oct 2026 20:12:50 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Handle SCLK_DPHY_PLL (fixed 24MHz), set_rate for ACLK_VOP0 and
HCLK_VOP0. Add enable/disable for SCLK_DPHY_TX0_CFG and
PCLK_VIO_GRF.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 drivers/clk/rockchip/clk_rk3399.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
index 6e87db18be0..0ddd1f20176 100644
--- a/drivers/clk/rockchip/clk_rk3399.c
+++ b/drivers/clk/rockchip/clk_rk3399.c
@@ -1001,6 +1001,8 @@ static ulong rk3399_clk_get_rate(struct clk *clk)
 	case PCLK_WDT:
 		rate = rk3399_alive_get_clk(priv->cru);
 		break;
+	case SCLK_DPHY_PLL:
+		return 24000000;
 	default:
 		log_debug("Unknown clock %lu\n", clk->id);
 		return -ENOENT;
@@ -1064,6 +1066,8 @@ static ulong rk3399_clk_set_rate(struct clk *clk, ulong rate)
 	case DCLK_VOP1:
 		ret = rk3399_vop_set_clk(priv->cru, clk->id, rate);
 		break;
+	case ACLK_VOP0:
+	case HCLK_VOP0:
 	case ACLK_VOP1:
 	case HCLK_VOP1:
 	case HCLK_SD:
@@ -1168,6 +1172,11 @@ static int __maybe_unused rk3399_clk_set_parent(struct clk *clk,
 		return rk3399_gmac_set_parent(clk, parent);
 	case SCLK_PCIEPHY_REF:
 		return rk3399_pciephy_set_parent(clk, parent);
+	case DCLK_VOP1_DIV:
+	case DCLK_VOP0_DIV:
+	case DCLK_VOP1:
+	case DCLK_VOP0:
+		return 0;
 	}
 
 	debug("%s: unsupported clk %ld\n", __func__, clk->id);
@@ -1261,6 +1270,12 @@ static int rk3399_clk_enable(struct clk *clk)
 		if (readl(&priv->cru->clksel_con[18]) & BIT(10))
 			rk_clrreg(&priv->cru->clkgate_con[12], BIT(6));
 		break;
+	case SCLK_DPHY_TX0_CFG:
+		rk_clrreg(&priv->cru->clkgate_con[21], BIT(1));
+		break;
+	case PCLK_VIO_GRF:
+		rk_clrreg(&priv->cru->clkgate_con[29], BIT(12));
+		break;
 	default:
 		debug("%s: unsupported clk %ld\n", __func__, clk->id);
 		return -ENOENT;
@@ -1356,6 +1371,12 @@ static int rk3399_clk_disable(struct clk *clk)
 		if (readl(&priv->cru->clksel_con[18]) & BIT(10))
 			rk_setreg(&priv->cru->clkgate_con[12], BIT(6));
 		break;
+	case SCLK_DPHY_TX0_CFG:
+		rk_setreg(&priv->cru->clkgate_con[21], BIT(1));
+		break;
+	case PCLK_VIO_GRF:
+		rk_setreg(&priv->cru->clkgate_con[29], BIT(12));
+		break;
 	default:
 		debug("%s: unsupported clk %ld\n", __func__, clk->id);
 		return -ENOENT;

-- 
2.55.0


