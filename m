Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BB9606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 22:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BRiL3MsW;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=jozhjGQ9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F20840D66;
	Wed, 11 Nov 2026 22:35:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6XdDTG-6uHfM; Wed, 11 Nov 2026 22:35:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A6C7640D26
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794436530;
	b=qCp0m29MBAKRdXaWB9+FrOyaom/PX6z9LreIQrBXI6qz3FDUK9VGSt3rvcIy82NCn0oG
	 fvoodHJhbQBrmLsG5x8lEDPL8rZccucQEYr3W+SephkY7d64jmb5jU9YmbWndks7TygO7
	 hyAqlFk5jnDyknNJayvVGph+noQ6+dmLCPICZH4uDXoMstsaywwfbhZzAIOTiYjOzuzBc
	 AG3OYgGDoJgmPhEK56PgvEwdgcV94KEiQ8WxwyI+jzQYPWwaRyn3tz8QVb5HD8D7S6nKH
	 JOAebLknlfxbB96jAr9ELZjQtp4i2bpghvEL467zWRWqmZSOottCoBhN8hPhjpznh7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794436530;
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
	bh=gnp5Wx2GMawwKRFJtRNa18WVAgCYxLDwYxKNnwnOV7c=;
	b=YUNN/vwoNg8hugKY51cTjL0QU0JD55ZXcxQrLqJ62zSofKo1qQZqyUOF4R6B5rEnqnlc
	 5tcVqgmlhpCMWjkm8DYbX7A65XO+tWuYKS4bOMDkWLsguKxSi910+VX4+UqD7WUy1P9TR
	 zG+2s9gqWk2xwGKe4Fq37lOZ7s0DD9KaEVXTleO28ERMTJKBoktG9NlkkfyXm2Pp8EK0Z
	 Cua9R7gnEhKx2jBWbG6yvmdnHThAMrZ0TzGZ+RwM4+jFvSIgwBx2NkyHJcBG0G/GATahx
	 UhUcqVCczKCvl/Z/p/9nCNX67AkU3T4EMEeciVJ2MBRBgfsim4cCOBTa8zmxQSjdZCA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=jozhjGQ9;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794436530;
	bh=gnp5Wx2GMawwKRFJtRNa18WVAgCYxLDwYxKNnwnOV7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BRiL3MsWK++lcedgSd7+nHP/RX+m4IkD+gyKfq8m8HSJcNjD7iFTevsJwQfuYIYmW
	 +PNRuzHMtKqG9B/I/O2LaosODknQ1TwK45CeqMX3GSSHbSHTVrj1mT4mWPWVbhAAq0
	 eDXMLZpeqG4mLs2XJ9Id7AdSUqiRlHNC/96xaKxJtDaeBvEpf2GlmGhp5Den9ZD7HZ
	 JA87mA1WM/heWR95Y3zi8kr0m3fcL3rJhEtnRSK6vD4VArQIeVH0gBpUFdrGsRio4D
	 6Ubz2jxqSCgZHyFSSDbitzr21C7ly23gFerH98Z6sMu5Jbh7SDou4TVgM83DwS4PJK
	 JhItzjPNcpJHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6C7640D26;
	Wed, 11 Nov 2026 22:35:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 199A170B
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:35:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B57B40D6D
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:35:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N9AhA_6-HFzL for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 22:35:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6386C40D26
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
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=jozhjGQ9
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6386C40D26
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794436528; bh=gnp5Wx2GMawwKRFJtRNa18WVAgCYxLDwYxKNnwnOV7c=;
 b=jozhjGQ9aOyCFKWjiXKzrmBDuUOk8M8TJouRFA4HG2bb2Q9myBPqprwioX7BNk08PauH2jxR4
 EzqowpF+MXt1uCwOac/ZFKlUbV5yhwaYxcGqjgz/3KMNfyCM9IYXR0xvYI5gqOTVTkb0QAOvdVk
 dHo7LYSVSELz8uyUbYku1qxtt8Kc08p2sKXUNNw1lBy2NUTO5O9M5SJVaTjTKWX0Cgwi0+dCPm3
 uyQtjlZaCQg4S8BzBBzwluM+YTGpkj2mCEohMohrGpQZX0Do2Dm9fi6KtsBuWXO4LlptQ0xgGAU
 Tik2RFkZhECktiVnZh5WxInCDCsspgUHLBuVUg5Jx0yQ==
X-Forward-Email-ID: 6af4edab4e7b1f439360f089
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.19.18
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 4/4] clk: rockchip: rk3568: Use correct PLL rate for
 CLK_MAC0_2TOP
Date: Wed, 11 Nov 2026 22:35:03 +0000
Message-ID: <20261111223505.158852-5-jonas@kwiboo.se>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use the PPLL rate instead of HPLL rate when the PPLL is parent of the
CLK_MAC0_2TOP clock.

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
index a52b6a890292..4a8a65efc345 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -1889,7 +1889,7 @@ static ulong rk3568_gmac_src_get_clk(struct rk3568_clk_priv *priv,
 	case CLK_MAC0_2TOP_SEL_25M:
 		return 25 * MHz;
 	case CLK_MAC0_2TOP_SEL_PPLL:
-		return rk3568_pmu_pll_get_rate(priv, HPLL);
+		return rk3568_pmu_pll_get_rate(priv, PPLL);
 	default:
 		return -ENOENT;
 	}
-- 
2.56.1

