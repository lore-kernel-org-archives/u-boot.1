Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F98C606E276
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 22:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VKy2tXiJ;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=Dr60RruG
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF91540AEF;
	Wed, 11 Nov 2026 22:35:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id adR7mskLW_wr; Wed, 11 Nov 2026 22:35:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3ED9040C78
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794436520;
	b=io92uOFRF+b2lg38iORR/3D1zKxQpOhE+WsEhad3kMkx1WihF0+L0N7oyQfVZR8w1uK8
	 qVkvpbvGXmLLqOSdOJcxtWNT1DtMU93rWaFcegQAufu9O44Kov41WdnPRYs46rIq7fUAV
	 Po+kmnxnLsVPKcT6pygyFR6M3qbZMb6cjZG4lenmoloxmK7rDxC083rLMqPMuQc/XxWok
	 iQYA/jgvOAYRNHAgNPU2CnDHlCPrsmPaFFyahPFam7PtaoGpdg4muGwsNQWqugVku/4IY
	 kG1YNAevpvFzeuhbeSnoT0sJBbyeUlmnjxWGZZvThOk7G66qHRQwzc4jYszzxulpNQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794436520;
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
	bh=CnFER3oBOTQTLtNBhVADpy/wfq97t283VEK1mSwVvxM=;
	b=JVRexaBsKasFbmZJVyr46Aq4O4CqZn6ri/U6lmafGadOGNxw+E+JZVkYzhtfZAKhtawu
	 vNVpCEiyasRc4W/Rzoqn43dMq1WjQ6cE8PD5JC22UDKtrZI7dhsCnMv0FSnT9lx0XKNTj
	 2Vpjwt2Mp4CDRGtgpHYkAfL+s5da3blTXfIBcFSiIVcG/AHTKpdewz/pQQlQ8aUOL/A6Q
	 TlBvBgQh6/14+kzejEUZGIyAKPeckJGI2RdS1UsssAViN5XFzZunK8wjzDI/M+vAppkYT
	 tqjgZIG7x9uxLD/9sE1jstPN2PUbtVd9P2+q8SE+GS0t54wFamjXmisITNrA2WdDD1g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=Dr60RruG;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794436520;
	bh=CnFER3oBOTQTLtNBhVADpy/wfq97t283VEK1mSwVvxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VKy2tXiJ82JBTbns+ZB+pHTAevSBmSR3dWf0YETrunBv4I1/sCCu7D9w8ItPWiF/D
	 END3YyryruJSOmyynBKFavjF/zIlEyae9TOIXPLB/N8u1B/qgNQTB4GFNQZQsueKYv
	 pIZwtzAdQVqqGtRziFb+DG9VZurQ7+cIuOW8TEklQ7VijD5mCh7VRM089w4o1lkW+l
	 ib4GZCefNSxTjYbVz4k3QDIyanZjo0NS/igqSPTum4fgEvDJE+9aD9WFncanX3oLx3
	 Y8qOhYUiVJZ9nzXdUTWHr+6AuPcWQRV/73yJDBSReSsDu2FcDhdXE/Y4Bc6eHzTnky
	 uz9q+rPliP84Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3ED9040C78;
	Wed, 11 Nov 2026 22:35:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DE9BAF22
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:35:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9681340C78
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:35:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 540j1z0aFn36 for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 22:35:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8C60940B1A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=33c1=jb=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=Dr60RruG
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C60940B1A
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794436516; bh=CnFER3oBOTQTLtNBhVADpy/wfq97t283VEK1mSwVvxM=;
 b=Dr60RruGztji/txSBIv8XYldiBQDSMA08vyVLlBkXoKC51XyJHFOvDKWlPkh0y3/i285dgpVh
 1LpzdY/jAb5AOPOJD6RWBgwG3FveGzibCipjS2g2pflJ3pbC7xoO26ohU5EOnkMyaYSPwTYTomA
 B24lKpP2b7AFHloK9ay6H9CWHVkX+Ohput5fJ6qslaze8k6UvrMynUeVjm2H70X7EacwouMlCGe
 bK7f9P1O1ibCgrIN/y9sdKLJU8bt4895RZ/88aBW2xf3jevJSEWQzbNnVZqGdvba0E1L6kkMmVS
 CDlgUNCxlEvIj5KmSmT2tN5FTsRyqAC9SpAgvrkDc4VA==
X-Forward-Email-ID: 6af4eda24e7b1f439360f03e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.19.18
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 1/4] clk: rockchip: rk3568: Use correct clock id for GPLL
Date: Wed, 11 Nov 2026 22:35:00 +0000
Message-ID: <20261111223505.158852-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261111223505.158852-1-jonas@kwiboo.se>
References: <20261111223505.158852-1-jonas@kwiboo.se>
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The GPLL entry incorrectly uses PLL_HPLL. Use PLL_GPLL to match the
PLL represented by this entry.

Fixes: 4a262feba3a5 ("rockchip: rk3568: add clock driver")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v3:
- No change
Changes in v2:
- Split from "rk3568: Fix trivial clock configuration errors"
- Add fixes tag
- Collect r-b tag
---
 drivers/clk/rockchip/clk_rk3568.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index 181917cf92a9..38c5d62493bc 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -77,7 +77,7 @@ static struct rockchip_pll_clock rk3568_pll_clks[] = {
 		     RK3568_MODE_CON, 2, 10, 0, NULL),
 	[CPLL] = PLL(pll_rk3328, PLL_CPLL, RK3568_PLL_CON(24),
 		     RK3568_MODE_CON, 4, 10, 0, rk3568_pll_rates),
-	[GPLL] = PLL(pll_rk3328, PLL_HPLL, RK3568_PLL_CON(16),
+	[GPLL] = PLL(pll_rk3328, PLL_GPLL, RK3568_PLL_CON(16),
 		     RK3568_MODE_CON, 6, 10, 0, rk3568_pll_rates),
 	[NPLL] = PLL(pll_rk3328, PLL_NPLL, RK3568_PLL_CON(32),
 		     RK3568_MODE_CON, 10, 10, 0, rk3568_pll_rates),
-- 
2.56.1

