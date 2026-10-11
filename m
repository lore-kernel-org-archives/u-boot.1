Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CCFCA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:31:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 004B080DC5;
	Sun, 11 Oct 2026 22:31:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EOdwSf7D2YJd; Sun, 11 Oct 2026 22:31:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3DCDC80D5E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757891;
	b=Rs8M51d352mCpes4RZ1buNFSqpthZxygDwMBq2TviwKxytxJvGB1UiI6jlhFWh/zman/
	 qbrkFhNsD0zD8vFuhDPyvgYzR6RFK55dnG3RQu0FWbjwikeR5IOozNALBvIfEUXIARNP+
	 x9mbF301C07z1GndC1kIN4ss5TNxBB0S7IgnLkvOecUMSIylfGm5xmZXSVx0OokKpUUMo
	 yy6jrRJEd1BUCuvB1pmBbs5r7xjdJul01GuCiMr9UzvsF9NlJY7bPDV0ri+1qCw72ceWJ
	 II2aEZPaOmLQfOFI/ReTHuI0BsCvdnP7WbueAaOShuHG800IbZetPIuO4mgNbU65zXg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757891;
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
	bh=xwbfzu8ExEUcQByCk1HTCPVXT8lWvRudq8MKAIktMsA=;
	b=EAfpCt+LJq42TVKDhhthyJIv4bDpStkHMRZtl8xnjp9BCUD4Q/S2iOlsWbtM07LH6tG2
	 yF+ghVyuCY4AgArzMXm8AzXIQtciTK71dmkEZwJnyeteangaNUzU4PaDOljYdFswxWReO
	 9vvjni3cFwUzYDWYejMQzaXxdOtJ95HOTItt9oDJEbxcYoWO71PdSDasX2CZxt/ivXMI/
	 H/EyP7WT56Uj/cyl77FjVwbh8iYWTmyD092FxX+snkzx627jHP4vKooVSOCyxipwLSui8
	 fvOmnP5yXIO1Wjkm0KebIpxCzwou8X1D0NNOdB0NM0HzAsHI0c+YD9ex5zdKHMkXwxQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=MDj0UjR2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757891;
	bh=xwbfzu8ExEUcQByCk1HTCPVXT8lWvRudq8MKAIktMsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K29/HQEFjVJ9rLTMCXHoearOweiC8ebLSYxrLDFcvsrD8IitYNDZiYyDzrIFMno4e
	 eZWTdDx7VRSnGZYJCzcwzab4fRH+A32+JqcISMp4u6VxVmi373QLcJ4RfRqQ5e46vZ
	 RTaX7YXYgcox6MefjjAc7rqpAdbr1614N45mqWNJI6lCCyNs40Kw/xhpG03lnsC52k
	 Qww9LdWb7B4KdRzCkq2W4jEiWUzr0OK5pGVUiiv9l5K6l2N3cBQkjBYjEGcyiAX3Wh
	 S3xqmh63f3z0mJOK953soaXshB6tSRUqWXJfpl2ArkndL3JgDbkw/Cej2mT/CeAaAE
	 IUpptEMpELMmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DCDC80D5E;
	Sun, 11 Oct 2026 22:31:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D4CDFDE0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B99DC80DC5
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IAmTW04B6VbQ for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:31:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A78AD80D23
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757888;
 b=sGgQylQl8uKqWE2QSgkbyXbfKMq0AWK3D4HVHch311Cdq1wp56V+aDVlAg2kqNd+Xp2S
 7OXjY1tBkvUVQ3WIpa/7sMB5GtCloPuY1jYYHhOC2AzIwzYCpYpDGNckqSsmvOSHL7xnV
 zupvS+Ml/pTbt4mVmxshtR82189+1Nzbkc1EgupCHSvsdgb3i22NikPu1R7/smfBN7Gii
 yttToEyGrp0T1ydbartiEoDpdK5zU1anR2eYdCX4M+HGKAP2RIKjRJMOb0zQKzAz0MYef
 Jam+erMnGNqx1jrJXV/Obi31sOu1VaNUAU+ONIK6PZz1QPiNzYLT4KDsu4ljstq0YZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757888;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=xwbfzu8ExEUcQByCk1HTCPVXT8lWvRudq8MKAIktMsA=;
 b=PIPPI2o3nRbisuGqPppPlkzl2gC7PXnosrXegRSeGvmzBxQ2LHVng+3j/bPcJLc3a9tP
 hmpf3bBP/iew9idDGOQfCvWy1EnG/fM1qy3rhutO60FPXknis/XrfNNhvcwK1A9P3NnqR
 EcM2tik0BndJZP6LomBN0pLdML7FRvUSH304i3Rn/Lj+JzfJwZorawj92y+52bJkPqsil
 UVxhIyw2o1W/Tj1HWTEnM8OrWKvnMUWpjH2BZ0j+a7ED/rn8Iyx/p8ZLdHvqaZZ53FtxM
 uF+NmDjeEpbPOsYsF9eDPMPafE/NhfKNdTDdRIM5iu0Ux+ltf4A+31iYtBXDvnntmdw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=MDj0UjR2; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=MDj0UjR2
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A78AD80D23
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757888; bh=xwbfzu8ExEUcQByCk1HTCPVXT8lWvRudq8MKAIktMsA=;
 b=MDj0UjR2Q2ERnkVnIp+2R3nA0e4FIvcw1PBiThdI00hN2DaPSPwemtw+2Ac2S3pgTNLisYVFE
 yS6AQTxPogx5OxyQliXLnnaJkz8RKZPLYoTDW9MbJxuWKVMpygXmVEJ9xnrDWg+OlvyT/NLqeoD
 kMFNQapuXSqoDPgMpr7FtO65bK3BWDIJhqJzC2gy8b3mgVscRS03Kd9QjYIkBoIaP54xaOq6yfx
 w0A4KcrbJ21PXzhW3ds0t6qoyxlOQJ2RDtqorXU8JGKAAJDF7mPegqYVjR8uJbk73w4Ja8xmoQo
 vyt60lRiVmu0T7x0/lug0j0pZ5jBD9sG3e7DacJcxoPg==
X-Forward-Email-ID: 6acc0e3a4548822a24c175d3
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
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
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 30/37] clk: rockchip: rk3576: Align BPLL entry in PLL table
Date: Sun, 11 Oct 2026 22:29:05 +0000
Message-ID: <20261011222930.1085075-31-jonas@kwiboo.se>
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

Keep the BPLL entry formatted in a similar way matching the other PLL
entries for consistency.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Split from "rk3576: Fix trivial clock configuration errors"
---
 drivers/clk/rockchip/clk_rk3576.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index ce97997c73ea..75b705ffba2f 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -44,8 +44,7 @@ static struct rockchip_pll_rate_table rk3576_24m_pll_rates[] = {
 
 static struct rockchip_pll_clock rk3576_pll_clks[] = {
 	[BPLL] = PLL(pll_rk3588, PLL_BPLL, RK3576_PLL_CON(0),
-		      RK3576_BPLL_MODE_CON0, 0, 15, 0,
-		      rk3576_24m_pll_rates),
+		     RK3576_BPLL_MODE_CON0, 0, 15, 0, rk3576_24m_pll_rates),
 	[LPLL] = PLL(pll_rk3588, PLL_LPLL, RK3576_LPLL_CON(16),
 		     RK3576_LPLL_MODE_CON0, 0, 15, 0, rk3576_24m_pll_rates),
 	[VPLL] = PLL(pll_rk3588, PLL_VPLL, RK3576_PLL_CON(88),
-- 
2.55.0

