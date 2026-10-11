Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0333CA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:30:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6AA9B80CA9;
	Sun, 11 Oct 2026 22:30:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pe70PqiSdAGS; Sun, 11 Oct 2026 22:30:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8828780CD8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757802;
	b=ntFmAK0P66Ph/P2Nz3jLnWDM2FeBaFwsUGHl7oJE3ynNjP/p4WUKJ7yECT8vVwKMZg3S
	 CHuXR1uiJNjmO+dQK7QZD0ROU5S9cXEhQe9ZQdoWCn+dFV7tT5J+13ibh7Bdu8ZRQk9ln
	 XSYS92RO3ump3W26sdSYCxCukblbMtQsGVXcKsPz/So95XPE4zvD9LjuiUF0DEmx8PqXb
	 vzFhoaYZt7GFr6DIRZhJQ/vfFV/qtRTCnJiTgY18GFIRZUPwCC6SJdp9b5LDggC0pQuHf
	 EiixD62sje8Otk6k2ZuAzBl+0eSfBz0STyy3GzgGV6H5kE2QmqmHYbmOuQMzPQR6iAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757802;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=r7rvxbp14IzayKE8k4CtMUqSilAxssEVNlnvIdKnibY=;
	b=o9VNC0I3gXC22+Bf5zcldmZwVhRVljcfpF35a5rMUqWVpARVRLMYs9SJ2rmeFDvjlmyV
	 MTXU3EBE+nrCTUxkWMEU9ATuUcTVCTGDzBlpU2eOSoTFMqNYh+upMQxwqncXAWyigj/w6
	 qVSnjKC3CyS6o4yz3coTCWXa9N1ao00Ja6jxdT3CGFGnPxbFZvHVGB62dL6UB03cc8IRp
	 QM5F2YaJeDpwmsY2oleygANY7zv/O41DJuSWiFMHLRlxkYuTkY2wdlbR/2YBeHUtZX5/3
	 GU/+1a/grhkjEr9sxCub1sAWdNn8qdl6+BGS1mFzpiFCzXRU+OZQlEc22jT2moThcDg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=aJJgLNv+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757802;
	bh=r7rvxbp14IzayKE8k4CtMUqSilAxssEVNlnvIdKnibY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dm1zGvNc5zpUeBpnjQP3XC9Gy2NPsEVXsFyMmcsxzQp/ke46iAnvzxyQe2AMvw2Sa
	 68BezZsHY5tNbO7PEm03Twn7tg/WTJEJfPdaJZX/Ocld9qQzpsZdDcKxH5uUyVHXyG
	 +rP7GW4SLcuWUxCDvf1MClhfPjX6nfT3z8elQyvb9RSdjNLGbxA3zcNTKLiAvLZlvK
	 kA6Y2mmdwNl5PkLAmz2ZQuN4KTy6HwAcVdBqzCQZBamA4VTLHoD+dLctYcn1o54Vsb
	 zZsaCYL5w1cM3wWsjrAUSGpeUBZZAtGWEHqKHOWhXA2CXYoY3mEGMJic/QstoRc2r1
	 9YITvH6yiblhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8828780CD8;
	Sun, 11 Oct 2026 22:30:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F863D5E
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4486480CCB
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rx48J6RT2kbG for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:30:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0395280A88
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757800;
 b=rdrA+hg3bYVx3tlP80bgr+ARCKNnD8b/K3vm56TJoCp35HOKQW1WIKqktbHX11ERudWP
 rRvkcccObXAXGFZddmnNuovZur4UX+0GHEtaGyLWKVtwLKQnu/+FvcZANGWsr6BdUQQiw
 uWKeFlNH9PNGEYRb0AD9ihgxwl1iOQmssE/Zc2RGhIRSoIFuiXT98q1ULwE8AT3iLJN1q
 eOktzmYjvUJadsIjeEXmfQSYywxln9j886ICazLQG+Q+RwH3euwpqRXL7rgxico0gFJFj
 oTqJHxRPB+uPtuavw8mR5pZMqsv81Iz8bMA/BmoW5kPkyXbacz4DoWi9ZImb9IVMdtA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757800;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=r7rvxbp14IzayKE8k4CtMUqSilAxssEVNlnvIdKnibY=;
 b=nXnK7pjeP/W6TqVlTgU8I0ejXGsnaiaT3HOD2Nh7DJpZ4QXnpEK+QD5vwpiT6YT2A7TL
 7AbROWqOgdqSb/2s1wxvtj3F5+1qKHZdjHfm9RUimsWUu0Slo45k9Pp43nEYOVMcE3kMe
 ERLGGBXVdkCyeKuhFwLDM/j8cHRuJjEQl9aGqHas6Oui9JivPMpENZOTTvQxJcJ1u8WOI
 vO/qOn+VQ8MC5b+5/OfG3OTeX46hb+s3dCzNvz8DZ6J2cdz5MvQmfomzdG3nszLxsIs4L
 DSFq/v8vJzwEAPlfVP+t9px6EPLz7b52PgTsf3aN1II8CMahqy6kg9KWiT6UV6PRauA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=aJJgLNv+; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=aJJgLNv+
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0395280A88
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757799; bh=r7rvxbp14IzayKE8k4CtMUqSilAxssEVNlnvIdKnibY=;
 b=aJJgLNv+0UNgVLci8eJQROSbMMvpmInsMMjw+j7J57VF3R7EKstzKhRy4xgOwlM1DoCIJl9GI
 h2R5sWYeZwJ6Qo8l2YdpwFSId0jaFDVZ23wqtiPM30S+J/ZL+4in3htk9KU6tawaqIDkWayWEVr
 C3M8fvPNkUG6BTDBRpXX+6Bh5Zs42Cu55fcwYA8PO2VzCXpb2w2rIdXP+Ht7SL7z7015iZMU1gE
 lvU2xcQroMS2vM0b3itconvaMx0A5IRohnbn5RMtSYBWOozwqJAX1jPQynSn94rO9F9+hi7Tj7n
 kvyY5wtrDSZ0Fu2AiRXCj6JVUulT2DALzDDdCn+YyGwQ==
X-Forward-Email-ID: 6acc0de34548822a24c1731d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 05/37] clk: rockchip: pll: Use PLL_FIXED_MODE flag on
 RK3588/RK3576 PPLL
Date: Sun, 11 Oct 2026 22:28:40 +0000
Message-ID: <20261011222930.1085075-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011222930.1085075-1-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The PPLL on RK3588 and RK3576 has no PLL mode register and cannot switch
between slow, deep slow or normal mode.

Extend ROCKCHIP_PLL_FIXED_MODE support to the pll_rk3588 type and mark
both PPLLs with this flag. Skip mode register writes when changing rates
and treat the PLLs as operating in normal mode when reading rates.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- Update comment in clock.h header
- Update commit message
- Collect r-b tag
---
 arch/arm/include/asm/arch-rockchip/clock.h |  2 +-
 drivers/clk/rockchip/clk_pll.c             | 21 +++++++++++++--------
 drivers/clk/rockchip/clk_rk3576.c          |  3 ++-
 drivers/clk/rockchip/clk_rk3588.c          |  3 ++-
 4 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/include/asm/arch-rockchip/clock.h
index 8d3819778eb1..43b63f72703d 100644
--- a/arch/arm/include/asm/arch-rockchip/clock.h
+++ b/arch/arm/include/asm/arch-rockchip/clock.h
@@ -19,7 +19,7 @@ struct udevice;
  * PLL flags
  */
 #define ROCKCHIP_PLL_SYNC_RATE		BIT(0)
-/* normal mode only. now only for pll_rk3036, pll_rk3328 type */
+/* normal mode only. */
 #define ROCKCHIP_PLL_FIXED_MODE		BIT(1)
 
 enum {
diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index 6664fe3921b8..a2b16543e811 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -462,9 +462,11 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 	if (pll_id == 3)
 		rk_clrsetreg(base + 0x84c, 0x1 << 1, 0x1 << 1);
 
-	rk_clrsetreg(base + pll->mode_offset,
-		     pll->mode_mask << pll->mode_shift,
-		     RKCLK_PLL_MODE_SLOW << pll->mode_shift);
+	if (!(pll->pll_flags & ROCKCHIP_PLL_FIXED_MODE)) {
+		rk_clrsetreg(base + pll->mode_offset,
+			     pll->mode_mask << pll->mode_shift,
+			     RKCLK_PLL_MODE_SLOW << pll->mode_shift);
+	}
 	if (pll_id == 0)
 		rk_clrsetreg(base + RK3588_B0PLL_CLKSEL_CON(0),
 			     pll->mode_mask << 6,
@@ -504,8 +506,11 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 		debug("%s: wait pll lock, pll_id=%ld\n", __func__, pll_id);
 	}
 
-	rk_clrsetreg(base + pll->mode_offset, pll->mode_mask << pll->mode_shift,
-		     RKCLK_PLL_MODE_NORMAL << pll->mode_shift);
+	if (!(pll->pll_flags & ROCKCHIP_PLL_FIXED_MODE)) {
+		rk_clrsetreg(base + pll->mode_offset,
+			     pll->mode_mask << pll->mode_shift,
+			     RKCLK_PLL_MODE_NORMAL << pll->mode_shift);
+	}
 	if (pll_id == 0) {
 		rk_clrsetreg(base + RK3588_B0PLL_CLKSEL_CON(0),
 			     pll->mode_mask << 6,
@@ -566,10 +571,10 @@ static ulong rk3588_pll_get_rate(struct rockchip_pll_clock *pll,
 
 	con = readl(base + pll->mode_offset);
 	shift = pll->mode_shift;
-	if (pll_id == 8)
-		mode = RKCLK_PLL_MODE_NORMAL;
-	else
+	if (!(pll->pll_flags & ROCKCHIP_PLL_FIXED_MODE))
 		mode = (con & (pll->mode_mask << shift)) >> shift;
+	else
+		mode = RKCLK_PLL_MODE_NORMAL;
 	switch (mode) {
 	case RKCLK_PLL_MODE_SLOW:
 		return OSC_HZ;
diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index db8ce25852fd..92bde425b0ee 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -57,7 +57,8 @@ static struct rockchip_pll_clock rk3576_pll_clks[] = {
 	[GPLL] = PLL(pll_rk3588, PLL_GPLL, RK3576_PLL_CON(112),
 		     RK3576_MODE_CON0, 2, 15, 0, rk3576_24m_pll_rates),
 	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3576_PMU_PLL_CON(128),
-		     RK3576_MODE_CON0, 10, 15, 0, rk3576_24m_pll_rates),
+		     RK3576_MODE_CON0, 10, 15, ROCKCHIP_PLL_FIXED_MODE,
+		     rk3576_24m_pll_rates),
 };
 
 #ifdef CONFIG_SPL_BUILD
diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index be401a9faeec..b9fd4bec311b 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -62,7 +62,8 @@ static struct rockchip_pll_clock rk3588_pll_clks[] = {
 	[NPLL] = PLL(pll_rk3588, PLL_NPLL, RK3588_PLL_CON(120),
 		     RK3588_MODE_CON0, 0, 15, 0, rk3588_pll_rates),
 	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PMU_PLL_CON(128),
-		     RK3588_MODE_CON0, 10, 15, 0, rk3588_pll_rates),
+		     RK3588_MODE_CON0, 10, 15, ROCKCHIP_PLL_FIXED_MODE,
+		     rk3588_pll_rates),
 #ifdef CONFIG_XPL_BUILD
 	/*
 	 * The SPLL is part of the SBUSCRU, not the main CRU and as
-- 
2.55.0

