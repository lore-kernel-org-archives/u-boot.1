Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708ED606A331
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 22:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=K2Gk5cT2;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=hDh1vpNW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47DC181399;
	Wed, 11 Nov 2026 22:32:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hhJJM17bukSj; Wed, 11 Nov 2026 22:32:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 926FB81701
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794436320;
	b=n+6C+z47KIJ4YNRt3s+a7d/VlQKWOj6H0PcBuhZ035xQ6mJCogWaVo8Q80Lj9DADuIW/
	 RVGxShD8/1pbQNS7jyBigphzBxu49gPiaVzfCXb2F5zY3TRc7sDyIRURadYWpi/h+upwH
	 DoTHfC9htOCgCqfLKYMI2VpJSGOwp0yntS93KTz1UHl7Rptdwk0IEmN+kvqKdyx2iqqbV
	 2w03FW9J962eM4SaVcbn+B6hTrUnGYrtPIPLyAGgB6OsjSCpWE5WHy0YqgZc0siRC0PmB
	 kzzOq9vfjho0SdaIiPGNkSYysRH3rD8Fsw/Wq+2M8P/IzIYikqv6majRj1g6GkApUEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794436320;
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
	bh=x3LBPwBq324kVGUej//9WaooemfPJMf5oNw7DCkjkFk=;
	b=M8hZGnWB9RjsJMVYJ1sk/ECsywuN88W90dNPceiyGtST4ZOWkkpoY3eho+5TjLah1z98
	 DwHx1sQyvak0VZtp83IzO0EXm3ACKYH0OGXq/svgMSfjp3adAybKNTaHSxANTCW0QImRL
	 EORAF7darD319jyezIiwWdzt4V2Ty1UoI/regdLFYhvekf7EMeKrHwRMpdycYt1BjX/EQ
	 +q6Gr5M1tQEmvXhqZMPcSSuGEF3HKMW+q+AnYl/X8xRGmngZToTMQjMOf+Bs2UqtFhE1U
	 11Cw4tWoyRntfewMMLrbilGLHrv+z6fcdy9Mu/aAb80ChxTIvuc19sIz5f5THJEWRVg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794436320;
	bh=x3LBPwBq324kVGUej//9WaooemfPJMf5oNw7DCkjkFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K2Gk5cT2Bn3vIeNOTHRP/QevWHgHe7El3G/HlJK2VXmBpRlqmV39JAvkgSJs59FBo
	 FUzWiHCzsqodb0LU5h7Ppsm++1lk+AiVGx+vmDxUAMi1pb4mkpRZ8yBnx+jDZWUzLG
	 z5vh8voYb1slwLf5ZAwRQus01znQD0AoghvWDv1RWH8rAG1ab0pIkbQR+J1vpK8pFH
	 brYE/zO7kEFxSVli+ATzKD50zZCTht3XhWxOxl5+6r73iMwAMBeYxWszcABQ/Fg1Bb
	 UlC9268RAjgqtF1EymwBp+Ouh0dFbNC1KK4ZPHV/Pghf3YJ34M9Tpzojwx01jsWj15
	 +L5T9QZmjXxig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 926FB81701;
	Wed, 11 Nov 2026 22:32:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 06A0FEC3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:31:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DFF1E40B15
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:31:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zYhDSczsFey0 for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 22:31:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7867C40AE6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=33c1=jb=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=hDh1vpNW
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7867C40AE6
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794436314; bh=x3LBPwBq324kVGUej//9WaooemfPJMf5oNw7DCkjkFk=;
 b=hDh1vpNWk8Z7AlfDj1ZUsi2kD1uF3/cACsW5GBs8RxBYcFCWpbENdagGHLKSr1oN0jdiVdE+w
 JwEJSXCwuYtHKkT1sw+tjWnJQemQN3FxALDHWBIfTvyTwjMikPqQRvSF8Hgwh6eSidmiBrbvGKb
 BA/pBTn57k/4b0mjWkOG3384x/Mg/Nmu2YKcMMrO2//P4Tf1F18cKyTby9cyqK7cA2rHcMVNizN
 ijdnvN634KakRLrvfOtY9FknzDEu/tgMjWrMiv1uWUEY7ugGiPlMS4QkTkeyujIuwSZw5Eust9U
 RlsihHt/INCkueX+jw0KBn9c0YUdBp4Lqxbgcep0bo3w==
X-Forward-Email-ID: 6af4ecd9eab6e8cc0ce8c096
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.19.18
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 3/3] clk: rockchip: rk3528: Align PPLL entry in PLL table
Date: Wed, 11 Nov 2026 22:31:41 +0000
Message-ID: <20261111223142.158361-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261111223142.158361-1-jonas@kwiboo.se>
References: <20261111223142.158361-1-jonas@kwiboo.se>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Keep the PPLL entry formatted in a similar way matching the other PLL
entries for consistency.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v3:
- No change
Changes in v2:
- Split from "rk3528: Fix trivial clock configuration errors"
- Collect r-b tag
---
 drivers/clk/rockchip/clk_rk3528.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3528.c b/drivers/clk/rockchip/clk_rk3528.c
index f7e85bf26731..976ef0e0a919 100644
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
2.56.1

