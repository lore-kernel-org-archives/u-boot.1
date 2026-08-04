Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8E2C55ABA
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 21:45:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B206780D63;
	Tue,  4 Aug 2026 21:45:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iUIo_-4bqv6g; Tue,  4 Aug 2026 21:45:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 298AC80D4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785879906;
	bh=r6FKjqCu8g4PfkjoLsZ91EhLhEcfbJVy1+VoqIXh7Rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SbDCTu3aHtJK+y4XFbhAGYO88yKTN45k9YbezLOh9AMEM2k8DCa0lKnz7Xog6WZ56
	 omWoNVyUMT9bAq4a7ahPh1RvKdAdltowDf/I+AvIRcFVofk2TMLaHfHA02KBe0qyBQ
	 OlXTDRoViCqjNWzj+P5zcWUsbxl59g2qWNUh1RdapTqrPySUXIzSIR8A0jvqGmzN0l
	 zo/vCXPuOx4eDuaKjsxuCMIBYp0ePFVI8exDuA0z42Dgt0V3yotpqOjJns/NtIyBnI
	 czUl3AT9Zj21DAtY40B6UWGgxMiUmXIKVh4y1ZIC0L74gzeJ+ZxYbTQKUzZ9ebymMG
	 NVNV8XDMwIT1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 298AC80D4F;
	Tue,  4 Aug 2026 21:45:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EE4FF2FA
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DFAAC4059E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:45:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XVCmeFMo5d3W for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 21:45:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=1695=f6=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D7B4F40571
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D7B4F40571
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7B4F40571
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:45:02 +0000 (UTC)
X-Forward-Email-ID: 6a725d5b96269bde08304530
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.5
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 04/10] clk: rockchip: rk3568: Use fixed PMU CRU base address
 for PLL access
Date: Tue,  4 Aug 2026 21:44:33 +0000
Message-ID: <20260804214442.2592597-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804214442.2592597-1-jonas@kwiboo.se>
References: <20260804214442.2592597-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785879902; bh=r6FKjqCu8g4PfkjoLsZ91EhLhEcfbJVy1+VoqIXh7Rg=;
 b=LYJWsnpwZfaTZv2gyDiDsjfkTk2yOXpQcRR1H623rzboUjsE4I2gfqBpYK8IRuHWJuvU2uUM2
 zD5MQbnvu7cSZh8CWG1g/baRpzALbM9cKZVfE96lxpKfhHH+W9fO8NGKhqUJL/S9NAL01rynzbA
 HF+5z0FRPfnDMfOz+TeMrNlc/LSzDbuUNeMtXL0M713FU7PuLvWPTkPoYZO+PioPI0wD4PGdeBc
 wjSky0AoJPfFB2Lo0rdRk519l8AMz7P+d4BTzgExYnp2n1otVUwM6B44fBOlLK2QabDsXzxvxQL
 70tKMTZkjO/Lh9e5ne9WfRGSKkKeBc6pdP62kMbIIwjA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=LYJWsnpw
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

The RK3568 PMU PLL helpers lookup the PMU CRU udevice before accessing
PMU PLL regs. This may trigger a full PMU clock driver probe to get the
PMU CRU base address from the clock driver private data, something that
can take several ms.

Change to use the RK3568 specific PMU CRU base address consant directly
to simplify and remove the unneeded complexity of using runtime lookup
in SoC specific code.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_rk3568.c | 34 +++++--------------------------
 1 file changed, 5 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index 5a05f1b4de00..eaf51728520a 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -94,44 +94,20 @@ static ulong
 rk3568_pmu_pll_set_rate(struct rk3568_clk_priv *priv,
 			ulong pll_id, ulong rate)
 {
-	struct udevice *pmucru_dev;
-	struct rk3568_pmuclk_priv *pmu_priv;
-	int ret;
-
-	ret = uclass_get_device_by_driver(UCLASS_CLK,
-					  DM_DRIVER_GET(rockchip_rk3568_pmucru),
-					  &pmucru_dev);
-	if (ret) {
-		printf("%s: could not find pmucru device\n", __func__);
-		return ret;
-	}
-	pmu_priv = dev_get_priv(pmucru_dev);
-
-	rockchip_pll_set_rate(&rk3568_pll_clks[pll_id],
-			      pmu_priv->pmucru, pll_id, rate);
+	static void * const pmu_cru_base = (void *)RK3568_PMU_CRU_BASE;
 
-	return 0;
+	return rockchip_pll_set_rate(&rk3568_pll_clks[pll_id],
+				     pmu_cru_base, pll_id, rate);
 }
 #endif
 
 static ulong rk3568_pmu_pll_get_rate(struct rk3568_clk_priv *priv,
 				     ulong pll_id)
 {
-	struct udevice *pmucru_dev;
-	struct rk3568_pmuclk_priv *pmu_priv;
-	int ret;
-
-	ret = uclass_get_device_by_driver(UCLASS_CLK,
-					  DM_DRIVER_GET(rockchip_rk3568_pmucru),
-					  &pmucru_dev);
-	if (ret) {
-		printf("%s: could not find pmucru device\n", __func__);
-		return ret;
-	}
-	pmu_priv = dev_get_priv(pmucru_dev);
+	static void * const pmu_cru_base = (void *)RK3568_PMU_CRU_BASE;
 
 	return rockchip_pll_get_rate(&rk3568_pll_clks[pll_id],
-				      pmu_priv->pmucru, pll_id);
+				     pmu_cru_base, pll_id);
 }
 
 /*
-- 
2.54.0

