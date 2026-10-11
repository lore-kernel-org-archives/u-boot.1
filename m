Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0ED4CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:32:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB19380CD8;
	Sun, 11 Oct 2026 22:32:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AmGN7MQiC1gj; Sun, 11 Oct 2026 22:32:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0C66D80CE0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757974;
	b=XFyPoQiIFMk5VvJRpKVvIGRIa4kd4spmLs5kBr52oX64B+z4qHpWVn4xqbqELJ03Q1qS
	 In3zsjEeKlHkLHkV7TkOVuj5TV/8de+CLim8xpu3q0SqfjPot5aoYaf+1mTejdnlXU0Ic
	 kT9zFYXk3UKrnD80PkoTcJYsBbP7B99ktfTaLqEtl5pvZzdf5dxBXpUkK/oRcy2p+dfgp
	 D6XYh2YBWv5KawPZlMn+SjhTotjwKxhy8YVJcGitjI3t5McWGC4QX5ZStFLD2VZ7PEqhw
	 6B20mfS89CbQjRB/a9fSOwyQE7/GLpL7+OabyRZ0lHXYNq0ZRXk4yqHRXeIr1dCIgYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757974;
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
	bh=niZwPfFLGLOaeEfqx1KLelMNL0OoEU2Sax4urTCRsDg=;
	b=NTUrMnQq2LgIYOvgdvtDI1Kp8TdlgYPRffa5Q5zBpCUjjS/h5ic8BXY4Lppc5UtkrZJt
	 PufukuDBQT5ChZ0K8Qg/eKVVITEomygjpZyock0mMVA2dqAiQGEWKiLX0IDJtmKpmLMYJ
	 RQcD1pvj1J3PyhTHky9QH56Qpu8UUjppEgoT8Hi/rMPfDmzUenJqz0kJ83dnrZD1Xqv7U
	 LtapbI79s0WW6ROpszyeqZvR4CuX/Ao/9W00/6BOIj98vH3Hzaxs3Clst25PIMZaU5DmR
	 f5npn4vS6FPwbqf6abz16zLJSHs+VuBhp+XIOBqUTAvmO3IgVYLsSWLKIEqh+nmRm2A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=EQ6TVcoB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757974;
	bh=niZwPfFLGLOaeEfqx1KLelMNL0OoEU2Sax4urTCRsDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R5n+pCweSqmeTY15ECetsndI3XJeRSfuy4fGilLdwVVWuYn0QgVKm9jlpg/SLKyc8
	 w2yVWPpMLROS8LzW6FpX0A5VbWFYrJXU8+tgPXNHnyij45an+exuZ+4REog7k9ckHl
	 NwJ6wofP2YWJ3Gk8P/5HiVFPz24GEYbcpz5doBwEhsFg+T+XnDk6BVlbH4ke++et2y
	 /hUdcHDmKkEy4UOLpqFzslC5IjEjK9lF2FF/MGXWhyOtyYIAV6KWoYA3JyjK5B03tX
	 kaoneGhYzPeulJXzx40c65d4HWT/UCECeGvs0ZzlrYf7yLUb3ImYPc9RDnx2oRwzAY
	 /pxG9Ad6Goitw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C66D80CE0;
	Sun, 11 Oct 2026 22:32:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 96D7175
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:32:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 88B5680BE5
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:32:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9zbKYaWQVQRW for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:32:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DA0CD80B7D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757972;
 b=mbj6yLBH+MrVe0Gq8A0jEmdC+B5WZMdAk73eQFrUQcXvztlZDdoVM+PbYkuXuIFWKiE2
 2rW28sqtQMeqOrSMM+YCUu3HFX7iai0faXV28mF4y40LZONVJ5Tl06wyC57ePYYqyvRF3
 UQ7B1Awhw4rNtcmMDeU63asTk6wDcXTg/oFWBJSupF/ftoSRDolzj8lww90N9UR5PGv+Q
 EDRQ+gwUWFKpF10zzDFbrkh8vQCTDUeoQ2pC81fCy/PbZc5OEgzu061QO3a+HWp9B8IhU
 w8zkH7JWea2nkaKXIfuGCGcC0ettiTeIjeJDKyICsTCk6ET4V/7/wSfeARYgyro129Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757972;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=niZwPfFLGLOaeEfqx1KLelMNL0OoEU2Sax4urTCRsDg=;
 b=b7Mbz/yhkBXFt5bPuhz5ZEgLN1rMIHHM3ZDGqkpbtEPC4qfBN6mbDlr9ZdE+ZbtSaPzS
 aGftcbOQ395px0RlqWgVN3jHE8jQVGSZrj/stQO0pVuR8P/DAWjHGKcLW5df4SVJalvyb
 zUB2hF9DIsARl6487bExH32TSwaWlidDmKHeT2xjrHn9l/YM5nOwOWzi+uWFSGV34lhuG
 IwMDFXznlGr74R28RK89fYoKzA31P4MddkBFjeaSBg/Gvlh0OD7XJO+JqM3aNj5GkCkWS
 RrRlhW/gwekQAu7oZTiULbAXsv9rwzCtL7LUOSWhqr7C/u+dqZ0Al9926NRb19GaKfw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=EQ6TVcoB; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=EQ6TVcoB
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DA0CD80B7D
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757971; bh=niZwPfFLGLOaeEfqx1KLelMNL0OoEU2Sax4urTCRsDg=;
 b=EQ6TVcoB7q583I1bafzdKt9kNg9blSztHGYYui+DS3GtpHwWcJzP8RFz10aWORHnaGDtGfXD8
 P2htP+CiX4buYZJpBw/NhmcgTG/2sTArdgX6+iNeNxgUNqu1Oei39cKKGHmtXqpr21WjFc/eq1y
 j+Ifc8fussipmzV4vCp851sYdXI7XtcQfYtYDFeidqo3O1suo1M+4e9EBG/ZfuXsHJLvnp6nvmw
 dnh9d5Q371Y9PCnQ0Ef4ir+ssyWN6SroIZ5nUbDrnJGc9c+p5FhmbOYaqlRM3c4vgqi9lJIVE2X
 WV7Yx2bTApYNmveX3wTuJiktSirChrtqcefuYUF031xQ==
X-Forward-Email-ID: 6acc0e4c4548822a24c17662
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
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
Subject: [PATCH v2 35/37] clk: rockchip: rk3568: Drop unused GRF syscon lookup
Date: Sun, 11 Oct 2026 22:29:10 +0000
Message-ID: <20261011222930.1085075-36-jonas@kwiboo.se>
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

The RK3568 clock driver lookup and stores a reference to the GRF regs.
However, the grf field is never dereferenced, let's drop it.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
v2: Collect r-b tag
---
 arch/arm/include/asm/arch-rockchip/cru_rk3568.h | 1 -
 drivers/clk/rockchip/clk_rk3568.c               | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3568.h b/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
index 9c7ddd751f72..d72f241d0150 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
@@ -44,7 +44,6 @@ struct rk3568_pmuclk_priv {
 
 struct rk3568_clk_priv {
 	struct rk3568_cru *cru;
-	struct rk3568_grf *grf;
 	ulong ppll_hz;
 	ulong hpll_hz;
 	ulong gpll_hz;
diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index 940b824103cc..9f3e9322161e 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -2907,10 +2907,6 @@ static int rk3568_clk_probe(struct udevice *dev)
 	struct rk3568_clk_priv *priv = dev_get_priv(dev);
 	int ret;
 
-	priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
-	if (IS_ERR(priv->grf))
-		return PTR_ERR(priv->grf);
-
 	rk3568_clk_init(priv);
 
 	/* Process 'assigned-{clocks/clock-parents/clock-rates}' properties */
-- 
2.55.0

