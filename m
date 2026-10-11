Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA32CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:31:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38F4D80CBA;
	Sun, 11 Oct 2026 22:31:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yJBKJ9ZqtPi7; Sun, 11 Oct 2026 22:31:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5214080DE7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757899;
	b=rgwoK+cmlgBizNyIdePm5xTIoXZvC1SvQoLGZIwYv1yL71FWDeKHd9XtnrNtEvqXixHM
	 5uTqnUiem52/UoL4ZVZ9WYbEygwCdqMYFYmTbL57EfkrDhnFnKCT56q52pyv2b5P+z4rN
	 iHtYIaLXgejZNxgnnZEJg2IPHRQOUH94EkSppdUlq1HCOJkD3zPo88iq5hD36uwuLRLDE
	 ZeqyYjwSQvobNgFBfDy3gqMZ8N14GchL10/fHSS1a0CvuAKlFFp9yqXOqeGOsOfCZiykI
	 Hdk348ShYx80Ak8Y/MpEZy5j/g9l1Vi3GsINLe7Is6ZfFC2JRlC3+fZFrpXMQH8Ig+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757899;
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
	bh=gBwRhEhYsBFo9RCwqQPDyYVD/SQ4d/bDVhmriNckAkM=;
	b=dlNAWzkA7wCtGJAMiyf6D1yd9BJywOffib2idiFmxzoC+2mN3jqXMPYPhWGNJKS+/G81
	 8+MQaVq8bRzC4ZVYR5dgVpNPFnbPk0vjb8Ma409PHA3dztavmrsciYsnXQaGvH3oIEaDK
	 q/nnFc0ehNI5OADaPMN3O+LAY3r8pVEzz9BA/a64t9hiapb98TKyjxIcDti2qNe82jFlv
	 z1Kh20VWjsbH83KJ7BAUReo1jCEH/NHMimd58ihSfQi566zFzyIBD5xLRVpvWohRHgTsi
	 wX1HM0g1VHt+Z/ULq7SLK6j6CAM6my5IJVALNxfvs4T+Ie5jfOdZLJq79sgh6JLRIDg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=j5sC+VBD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757899;
	bh=gBwRhEhYsBFo9RCwqQPDyYVD/SQ4d/bDVhmriNckAkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yEv/FwncCWubXcH2O0B4twrfrscLrRSB9mAQmBVknVS4oTPFizUIIo+ztdTpJzO9H
	 bTYzF3Yn57lBaXtgbkj9BuZ62HFi8Ebe2Zhi06vAvSVmmU9mQwjYtls/PNlEUbVop8
	 J6JsgcTCJFD1urcwQIjoKKSdbhkRcCnvrZUqzpflsuD2kD+9UjCp4aXGw+wm++lXec
	 fEamg7Y0MuS7nT5qc8jl+tpZC4AJX+kd52y3oPRGzHyuTC677GknfzCvPJmxznx6ZY
	 J9HZ3onPVme7Xbn9mzMb2qUYKLMpJqlFkUUWKpX4gzIRBNAG9XdArLouJHftuzsCoO
	 J8Y26PD9kfKLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5214080DE7;
	Sun, 11 Oct 2026 22:31:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9AA471DE
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C91D80DDE
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jx4mMzzplpkk for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:31:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DFA5980CBA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757896;
 b=FNFmBV7yqQe7MD3RnOJI2vIwfnCD9934VBjSIWJYC8q6aZAaVZNpa9IuobXWQNLE/tEV
 wu0mu04VF1BRBTKrW4N6lOy2UTK16qAd/ks82vrbOZDC6sU9bn7hTkqf6p+sYiGIdAGmb
 VQF9q+Y/g9WprP8gjiLDIjEGpenwVPEMcW11vRzUTB2sW57KRLhxy7dDPCAarOg19Ipm2
 Kzm0Bt50VtcuMbqHBUoDlNmOJtOFxN/RiyLRlp1rCsXYasWuHCOxlpw12lMY0si4mkeKR
 TDQC6h3o57vfOEhdfRtcOk7YBJZ9WAPFdnaxy97kwSvDRk9uP9HmMF7kDkb+IQ1svjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757896;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=gBwRhEhYsBFo9RCwqQPDyYVD/SQ4d/bDVhmriNckAkM=;
 b=Irjmb7MwCEVaEpggBenbCiq+mjO0EUj088/tGTqwQz1tbc66C2/jy6h2TlgrXf777e2Z
 BWib96bRHLXLWKihNKQ4q7RZpLorFTmCy+1K6+clCEHeFUv+oyIPmouSg8khUkqiBj28R
 uaLhRrK1TftLSKezK++LE/oX+dj/ufSeA+XfiDDe0eK6u96EYAW9Cr9fkIH+7tkz2POqB
 RncNA/XlptAhhAZB/PRkxhDTXBAExPOqDbBBL6Tu6rA6+3YErhK3zWjU4F0YuWIZWIzGH
 B84kcjwo+PauTOyTyQu1YgI6d3iLF8GbeSNcVNDp6wRwHz6qYy5oZzCCtAK1Zp9Gvfw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=j5sC+VBD; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=j5sC+VBD
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DFA5980CBA
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757895; bh=gBwRhEhYsBFo9RCwqQPDyYVD/SQ4d/bDVhmriNckAkM=;
 b=j5sC+VBDpKLfu+omtc8ltvGzWeBA+uC7UAAJECMt5gJaN2pQy4cbYnmIMqrXDvvKs6GN5wKAQ
 jQnXcj6oyxqb/SMjLNApPJPOzP4fXQ8cwDL9wq42qjkfnKLeIcSmmyZg3XZLIr/HBPhQtACDdyZ
 5PEoNte2i9pwOsyc+dI/kjXTRyhEJnk5vxOJ2hF1wqY5SHetAHdLiq+x1/XUfKkbqmW6wPf5WEU
 2WnkbzC8m0XKpUPCDA5SnQFQZqbpyn2Gycks+b2kP7twYxS3HEiB3lfTUNhEh+oFYBUn/gSdSgY
 1n7T4x5mcUZAJQsuSin4kzNxqLOBo+3eguv5g62GGycw==
X-Forward-Email-ID: 6acc0e454548822a24c17626
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 33/37] clk: rockchip: rk3528: Align PPLL entry in PLL table
Date: Sun, 11 Oct 2026 22:29:08 +0000
Message-ID: <20261011222930.1085075-34-jonas@kwiboo.se>
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

Keep the PPLL entry formatted in a similar way matching the other PLL
entries for consistency.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- Split from "rk3528: Fix trivial clock configuration errors"
- Collect r-b tag
---
 drivers/clk/rockchip/clk_rk3528.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3528.c b/drivers/clk/rockchip/clk_rk3528.c
index 82a1b6e85b5b..83e302dbc3c4 100644
--- a/drivers/clk/rockchip/clk_rk3528.c
+++ b/drivers/clk/rockchip/clk_rk3528.c
@@ -72,7 +72,8 @@ static struct rockchip_pll_clock rk3528_pll_clks[] = {
 		     RK3528_MODE_CON, 4, 10, 0, rk3528_pll_rates),
 
 	[PPLL] = PLL(pll_rk3328, PLL_PPLL, RK3528_PCIE_PLL_CON(32),
-		     RK3528_MODE_CON, 6, 10, ROCKCHIP_PLL_FIXED_MODE, rk3528_pll_rates),
+		     RK3528_MODE_CON, 6, 10, ROCKCHIP_PLL_FIXED_MODE,
+		     rk3528_pll_rates),
 
 	[DPLL] = PLL(pll_rk3328, PLL_DPLL, RK3528_DDRPHY_PLL_CON(16),
 		     RK3528_DDRPHY_MODE_CON, 0, 10, 0, rk3528_pll_rates),
-- 
2.55.0

