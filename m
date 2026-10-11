Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62256CA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:31:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3092780D8C;
	Sun, 11 Oct 2026 22:31:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zM_sRfGbwznw; Sun, 11 Oct 2026 22:31:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8741680D05
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757887;
	b=InAWAFw5dLYVVW9Wjp1sEPZ7x2jf5gS2/eoZxx8ilM+L2zccQ51UX7onkZDhABw9cFms
	 TWBAgwuCW8MpFbNeX9L8TO5JDqch6zjQTW7AT3g/wH6ZLO+rYxD4LpCa2S3yvcf8rV/YI
	 9b8gU8EhPrvuqftNaVcxurCHPu9JtYjjC0fxkGpZGJSJq0Pytcg1RqvwyUtLmGU755JB/
	 hhHj4ApeEmndCuKYg+//fFTDX4zP0zWFfnbej/zq1jYuqCistd49PkfXosXTniLRwbAfo
	 oZyu7ehnaySMSVl4+E1+3j0qmYWNu2Pzx8SCSUT+LJaY5LTF3SdQF24xteOEutvUAYA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757887;
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
	bh=d3N/u8GbXX91AaMZGr3qgZbysMsdAjkHo2PVZyTb7Qw=;
	b=ml/Q4gb2PVLEb7IPMvYKPs5G4GkcV9IICVPR0h+MROXTWUmCKVfikOONaoLlZFIdDXTf
	 PRTCQm3BRPeq2bN/pbn13hD36J5Maip/JRtt4nuUdKhxMO+xyLD/e/HT5+cHNomWDv1V9
	 3nUhFD+v7jjP8lbr8YS368vhtsOaqcliOSrPWj4m4AM4W5myTMwMocsWau9rewjkFZTnX
	 Y7fUlQcHpfTuCG2/E8fbxag2aXjcbzYF9SOCwC/9IEjYnu89ZPJCEOeOkc28Fc8Zrqjzr
	 XH3IvUciRnS+lo+V44fYC2v7DbcF2n4i85giha1Pwz/Hg2ntpauEfXFvoC7u08mDsCg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=sFZ+yczy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757887;
	bh=d3N/u8GbXX91AaMZGr3qgZbysMsdAjkHo2PVZyTb7Qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D1QJBjKfEKtHqaO4NAO4JgIyczd5gfu1w+fMbi+g7LUTghTJyo+jok1iKRSZ2RnYl
	 6ahpw0WADExz2UOwu6djpfgZ2mBQo1nWAEVN9of2t/A5mhqCS7vvmpVaItr8toPFr1
	 9YXTj3Q9ZyH26fkxwOYdO3gKWfXJocEtpWSRGlvVk5FnIH/F1J3PxOI5K8DTjo67p2
	 hbVC5nftOgv2+lEmYEvjWELw3BrnWxSmqtrxAMwMFviNP1tt40dTs10ZacwLADB4oY
	 MZdXAAQJD+zYJ6LSbFyusYGoZ6+XCa4mTtcniXqZtqWzgG+DpTOY8w5LXABo4JnQJ6
	 Z+mGYVc5QMWdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8741680D05;
	Sun, 11 Oct 2026 22:31:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 151731DE
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 06BD880C88
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qitQ4gUT5pXj for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:31:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5CBFE80DC0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757885;
 b=tVBWRKd2g2/KJ/06t93W+tAYvRpnXQ0Pa/IGEtqSWY/2HV3roSeEJJ3OCEWOMwaJADtn
 qW6N1RJCzBKCnkOChKK1uU9sIpnt/qL3g3eyTul3Lig7pNzdzfdyuVi2M/Xy4ktRfdrXV
 wpBw8FP5jFeB+qzmvPnCIFl6ovJED9F9oviPpfr6L9NbOKNfl8tb5mO8MerJPBx+p/EMS
 Y4cmxj+faFqnRS+ETxmbZlx/mxfFGdc7Stdy6UZ9n5xW6Rvx0d8SEIGZcb4NtsV0BsXCP
 1S00fw7L8m0fsrz1mN1eCAHSdSZGSg4wHY+23a88pJWd0T4J8XUsJexqgBGPoQDz7tQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757885;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=d3N/u8GbXX91AaMZGr3qgZbysMsdAjkHo2PVZyTb7Qw=;
 b=BAxZr3ieEEW8gYt1E+YmLDCRvaOHdZqfi1Y1ifuJ5FFi/rbTOm16NBXJJziTU0iyv9BK
 C/BcznbXiO1xnCu47XzkjQieEHvMSScggrILRsxjPpEp9rdtxOKROnKlmdv605W58kiN5
 Atspe77Di0ws5UVjxNTg5EhWEJFaUh8aaQkrpQiBUvUdr/EdtBPqs3ycvNVO/EC7+hX5p
 kOdiAcfhCihEkqNo9pzQw61+WCvlLhA1w3a/MRSJ4pbEOeBVUq+eOjDztw7aqZwZpjOaO
 rV7jJX/ruvp4c+uJgNj4DIyqdvpUwOkpyEOubP9wxxHNm4wxLNWjAJAfngGiL34m7oA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=sFZ+yczy; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=sFZ+yczy
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5CBFE80DC0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757884; bh=d3N/u8GbXX91AaMZGr3qgZbysMsdAjkHo2PVZyTb7Qw=;
 b=sFZ+yczyQJMjtjOAP0vFz8GUuYbD2rxPZi+622K0Vn9jNgM/I14OIjmm28tv30xTO3CtLXZzi
 8clIoI0MonvQByfMibxvbAw2n5SndbKB3XwioNXJyakVXmBElMEYj8cw0CIpxOJiAODjnYmut9l
 4FWMCWw9jNUfsg+zJePsEnHntaX+kjkJaT+ZDhmYBNoaKKS+KCtRGWrKA2Pivk4t76A2guDpbtJ
 6RKw5d5NBaY0qpd2tlRL/bT+vDX8Ox22Ul1RoWjwA4ObX85xovNjmklOA70XoO8lp+InrwWlEqe
 f/k3snLOj4M2CWFlEHuvrdG7QFmwOFsvecrRlvSs5ATg==
X-Forward-Email-ID: 6acc0e344548822a24c1759a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>
Cc: Lukasz Majewski <lukma@nabladev.com>, u-boot@lists.u-boot-project.org,
 Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 28/37] clk: rockchip: rk3576: Remove unused BPLL register
 macro
Date: Sun, 11 Oct 2026 22:29:03 +0000
Message-ID: <20261011222930.1085075-29-jonas@kwiboo.se>
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

The BPLL con registers are located in the main CRU and not in the
BIGCORE CRU.

Remove the unused and incorrect RK3576_BPLL_CON macro.

Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Split from "rk3576: Fix trivial clock configuration errors"
- Add fixes tag
---
 arch/arm/include/asm/arch-rockchip/cru_rk3576.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
index 380151e0f8d5..12257797445e 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
@@ -140,7 +140,6 @@ struct pll_rate_table {
 #define RK3576_CCI_CLKGATE_CON(x)	((x) * 0x4 + RK3576_CCI_CRU_BASE + 0x800)
 #define RK3576_CCI_SOFTRST_CON(x)	((x) * 0x4 + RK3576_CCI_CRU_BASE + 0xa00)
 
-#define RK3576_BPLL_CON(x)		((x) * 0x4 + RK3576_BIGCORE_CRU_BASE)
 #define RK3576_BIGCORE_CLKSEL_CON(x)	((x) * 0x4 + RK3576_BIGCORE_CRU_BASE + 0x300)
 #define RK3576_BIGCORE_CLKGATE_CON(x)	((x) * 0x4 + RK3576_BIGCORE_CRU_BASE + 0x800)
 #define RK3576_BIGCORE_SOFTRST_CON(x)	((x) * 0x4 + RK3576_BIGCORE_CRU_BASE + 0xa00)
-- 
2.55.0

