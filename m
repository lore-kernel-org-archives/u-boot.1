Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18A5CA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:31:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8368E80CD8;
	Sun, 11 Oct 2026 22:31:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AfXvHIiM8eGl; Sun, 11 Oct 2026 22:31:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C1E7B80E03
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757909;
	b=GzowNxWldqNwW/4m3mwegnTGv1gTfWJBjXUj2PfvEvRzAkPgxmOwd3jEvnVZkUzGzbFT
	 S3os1ola40+XTZfoqMUoSx1MU3Q4cY0fH+B0HKAs5vYvTHIyLIBSHqOVGdtwWqTgJm3Od
	 jWtLd3HYB96jmMsNkAr/tfqtdCoDVdYDw4BhRicd/KtVIYql4kGQSkUJAoNILb4C724B0
	 t7Nj73CUxVV3mlPZIkfXO81oMralmqmY44yk8Dg0upXkcsXHUq5TlrIXbGhPpS/V0iZzB
	 obw2Q9k4DgsUNmdGGRZgS5Y4TcC3wQOVx/ZjjlWr+IYOd9a4NJl0ZPJnrNTuUn+tTnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757909;
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
	bh=BHMzhBw08TLqft11hUMkLOeghvs7yvVOI+91nozrtGE=;
	b=IW3AijIy5RMb+TJrtC43SeHRQ2sptz/Jwkjb9rEHP+r8Cw+FfEbkor2YNqjePg2cFzIg
	 LWjLw2iHf7GlLSbyQiwe7I9lpgKmsjHINKtOeEchsmSu7I+okZJgkoamoxaLVOy1b4CjU
	 GjTPUvbp/PH+QRHCZ09VXGJgMdF0zYW+uZ+cQJZWHrEOx6bUcCvMJgvqS9Z/2wS+JjVJ9
	 6LflqG3Pf23kF5VHLxOisIDss3Fl3I1G1/oiIJu+HJ5lq8jBzwxAziEnEKeme5lN4rX2C
	 YiplowWEjCjcVKG3SrZ/bVOm66f1+F12Q9382uSru4sqA10ZOpRi+vb6kHKK4/C8c3Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=k52ZJk78;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757908;
	bh=BHMzhBw08TLqft11hUMkLOeghvs7yvVOI+91nozrtGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cVm/n8ZeQ3QRCOw9DWg+PLVNGIZfGzndsxPpSpe/T++9zjvyA8jNO5boCZjdtoEdu
	 6ZSyDp+SIKTz5AZ+l4U6OXkp2FO2IyFnh97WTlrbuf+ye9pI44clNdhjr+PgWrr3mh
	 XAaFAy6aVC1npnSZCSWx+gSMeU1ty2KjlovsypY9RuBJOjUK2Iuebd4Xm92zRqlNLR
	 ZKim9+LUk5tWCpzoGPXGX9SQtdcocKjr5/RVZTonkD3Ba9Sdpd4w/cgH6quffEvQGd
	 gQJB+lJ0h8B6vLwr4bICKVDQkZlr3j4LSFkxUe486xFV1+O53l+bNbyiVBk3AOowPA
	 LKkAkhGoNYHkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1E7B80E03;
	Sun, 11 Oct 2026 22:31:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C9D981DE
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BBC3D80D48
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4avuNEWawyiA for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:31:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F13AC80D50
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757906;
 b=mxsnWPt7UUuu0HiazbCLsPjEZP/Mk1DSxKeceydXn79fC+fpQd2zD4EynPLgHs80OWB5
 Pnys2nFTJYaMQaRZbywVTWlgNkNadUYCVKpKbhl0lfDdOT/DRSysW+8ZpIpTPzwnFV+uB
 LR2PhdxQf1kWS0mnOpujtgxnyYr+a7+94AaKmm885dbXONGGCrWO8OTeRfjzm7CZ6vZBu
 QVOuPDKwhZJY4931U0RAzYEy77NfeeDiDMLa9dWvD/+9o2gDZQ4/VDf4r5zQnozEAm9TA
 6EjBrZkNsCWe3ifAFSNHDiyXYOoLTi5bmfUc+VkVTsAXmqEO6eYBsecy9DSMAeQ3qqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757906;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=BHMzhBw08TLqft11hUMkLOeghvs7yvVOI+91nozrtGE=;
 b=jI7gg2EszqdbT3e9xMetDv8wHWt/B3gDmX5k7URmoqFug7dCMk94Ru8mzCMRHOziAaJD
 /ZWbERWp1SGlwlqMzLyERizLXFduaNtH8vOm+yglWE4VGJrw1p9ANlfE7AQit1S1pzdbZ
 AYvTOuzFc2H5Jvf7ptXUYcovLA/zF7QX5vBE/RGI0zMKc+dn2q3oQx4PIsvRAxEFyCDjK
 hnNxbUnafsrtWVwA6pjI2wz3G78iHvhwjWqGma7+12uHzNoe+WFtti7ACubKXuJBz+LUI
 5ahedN/aZw4PUc0Y3uQWw6Je1HgzfDsreaC5O352tvUD57y0LqAp4/QNVaIGYhrGelQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=k52ZJk78; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=k52ZJk78
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F13AC80D50
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757905; bh=BHMzhBw08TLqft11hUMkLOeghvs7yvVOI+91nozrtGE=;
 b=k52ZJk78xCG/jvbzY31NNTTlOv70quDz/12KXi0KyITd2GST7xKNRFdKHTssLrdOs1KwKOUH/
 U4uL91tGfPAokA2YIlrZWBZ+9bOqURH5Z4ZBNm+pChdpleYM8Kns0pXGF5UGKYagihuA0cMCpZK
 Ml3m1Pplm/qYuMkFu8gTHMlxsUuYLazML11ljU63qt6cw/S+/CAnira2fMxayBSRQRbYPdKJOJ1
 ilI8VNO1sBknALDs5fFV8bTnbs9BMab/09geraFIePMXl+Pk0OTytqrZ3IppeiXDtN7WZgPHaJQ
 G2jAit2uBpOdTx+LIQ/ErP2qie6Cnb2VpXOEV/dltSgA==
X-Forward-Email-ID: 6acc0e4f4548822a24c1767d
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
Subject: [PATCH v2 36/37] clk: rockchip: rk3588: Drop unused GRF syscon lookup
Date: Sun, 11 Oct 2026 22:29:11 +0000
Message-ID: <20261011222930.1085075-37-jonas@kwiboo.se>
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

The RK3588 clock driver lookup and stores a reference to the GRF regs.
However, the grf field is never dereferenced and struct rk3588_grf is
not defined in any header, let's drop it.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
v2: Collect r-b tag
---
 arch/arm/include/asm/arch-rockchip/cru_rk3588.h | 1 -
 drivers/clk/rockchip/clk_rk3588.c               | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
index 39295adeb38a..85cc17840436 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
@@ -41,7 +41,6 @@ struct rk3588_clk_info {
 
 struct rk3588_clk_priv {
 	struct rk3588_cru *cru;
-	struct rk3588_grf *grf;
 	ulong ppll_hz;
 	ulong gpll_hz;
 	ulong cpll_hz;
diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index 662ff44397ac..9e26ca669fc5 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -1977,10 +1977,6 @@ static int rk3588_clk_probe(struct udevice *dev)
 	}
 #endif
 
-	priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
-	if (IS_ERR(priv->grf))
-		return PTR_ERR(priv->grf);
-
 	rk3588_clk_init(priv);
 
 	/* Process 'assigned-{clocks/clock-parents/clock-rates}' properties */
-- 
2.55.0

