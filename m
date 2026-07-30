Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2A6C55165
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:13:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06BC481013;
	Thu, 30 Jul 2026 14:13:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DsTaNYdQPG5d; Thu, 30 Jul 2026 14:13:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 086BA81149
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785420826;
	bh=ClF+kUZcjzUb2wnvzr3rnRNWchI9NytJORRWJhOTRs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uHtQD9F1ULt62odJa9cA81yHfbXjcTOHsehZ6PwcWAp/YhcfgJfHV2YWI9/6gcTFG
	 5Qi0bOcF4oi6hQG1CScQYVnqVNVLIcUTHRRMfCakQ3vD/I9EkFne6pa0rr+I5tV8sX
	 Fk+Q2IZBv8xCYFm1EeF9UMtrOb5IZvNYaxRBZmR50Sd7ydOZjKBOTHrC+OTwBAqt4t
	 yjSkyLvvotrJBBBIBju9tQovjcaLNDt8vRp1O5N5YwqrnOryjq/sITpp7Jh1A4UfmY
	 t+S2hGrq5VbPPC1EgtG+p+R6re08oqFy9dQlu8bKMTUDOmC02+UoWqgukzQP64S2Uv
	 WBr/BdH9Wc2og==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 086BA81149;
	Thu, 30 Jul 2026 14:13:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F36742D
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 66D798100F
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uelh7a_tJsmU for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:13:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4E91780FDD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E91780FDD
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4E91780FDD
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:40 +0000 (UTC)
X-Forward-Email-ID: 6a6b5c13a254ae338c091897
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.12.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 13/15] clk: rockchip: rk3506: Fix trivial clock configuration
 errors
Date: Thu, 30 Jul 2026 14:13:02 +0000
Message-ID: <20260730141308.1218014-14-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730141308.1218014-1-jonas@kwiboo.se>
References: <20260730141308.1218014-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785420819; bh=ClF+kUZcjzUb2wnvzr3rnRNWchI9NytJORRWJhOTRs0=;
 b=gElCJZIpHExfg9m71vkHOfV8vbBDvn/UaLgkThnduC7EATrk4bYmPPKUBvWYJESIhObtuPahD
 TdWmY5Nvlli0OrSeOAObnJqMZmwzOQgfhiWQecn9Rq4GnJGOhWFY8/fFVFrN6p/77nybTX61Zrr
 YASDgn7xBdng3N65aehhjc6Y+zc+2ngE5Wf/jfjpJhkivcasWQqToTnUPHeBZwKL/ZBhvplZJfQ
 7yTvnMANNWWxWq4onBO5GshEfUr1NDZfoplYB67g3eZ+A8TXkyHfYRP9E+QkaalJiAOnulJEpLj
 klDCjRSP+55Gsqj81Ijg37Rgp3wCsoZup1TfJZ4njZnQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=gElCJZIp
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The RK3506 clock driver has a few trivial copy-paste mistakes in its
clock handling.

Fix the trivial clock configuration error:
- stop CLK_I2Cx from falling through into CLK_I2C2

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_rk3506.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3506.c b/drivers/clk/rockchip/clk_rk3506.c
index 38066c5c3e3c..457082eea87b 100644
--- a/drivers/clk/rockchip/clk_rk3506.c
+++ b/drivers/clk/rockchip/clk_rk3506.c
@@ -537,10 +537,12 @@ static ulong rk3506_i2c_get_rate(struct rk3506_clk_priv *priv, ulong clk_id)
 		con = readl(RK3506_CLKSEL_CON(32));
 		sel = FIELD_GET(CLK_I2C0_SEL_MASK, con);
 		div = FIELD_GET(CLK_I2C0_DIV_MASK, con);
+		break;
 	case CLK_I2C1:
 		con = readl(RK3506_CLKSEL_CON(32));
 		sel = FIELD_GET(CLK_I2C1_SEL_MASK, con);
 		div = FIELD_GET(CLK_I2C1_DIV_MASK, con);
+		break;
 	case CLK_I2C2:
 		con = readl(RK3506_CLKSEL_CON(33));
 		sel = FIELD_GET(CLK_I2C2_SEL_MASK, con);
-- 
2.54.0

