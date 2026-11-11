Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E51D606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 23:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SLqDAvro;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=BKIXu7to
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1862340B00;
	Wed, 11 Nov 2026 23:13:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oQa5vIMd345F; Wed, 11 Nov 2026 23:13:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 589E440A5C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794438807;
	b=YQ+lMWtsYT17cOWE67IZqICME20G9EusTC5kcQkoj/APxD1pCtiYb+gRcnxaRcanvbR8
	 30ShnBzYra5FtjPL8/X+g4/k5gkuEu70bthrxmjdHhCx27OxJIqee+JWuKFEJB/lsdrmQ
	 g8OCmeKlY9CZtSxDthhHp+OvAYyixU0eLf5qmke4SxTLxjfIHN4x4X42+/L1iCJURAF6W
	 GcpAvRk+FhnVIaSkypTC+WoyaAkyAeVfTDbbmm/2/vJ74l7I1lOV1k1WS1bKJNLDkBGXm
	 w4fZWDx7z4h8a02R/mLSJwUWEMu5fO2UFiCEVktU8LsDA9XsKXA3GoN8rJV2FP9UKnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794438807;
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
	bh=NNATsiMoP+gEK4ZEmyo+Jr8l/rQgIpqLSKXdXfcdFzY=;
	b=qg8CzZVaatfT8aSVlYDC8lupIWN1ZfTg1UV2JDyA/Nh8vFGH+aoew/d1+O/9PMO6nZ3S
	 T5Vnp7q9532/3voUmr++35mpLadE38jvlXPj38Jcwr+Mxt+1iGut/xfSEWTohCwxE2esc
	 M72AiTlD7QKVuvOQvmKOcXOz/q8lRbkd7T0rKGSF183oI1Do6THz/BuUk+CYOApVyp6Dq
	 TdJm3cWT+nC1Z3xBoYvqNPnV58ya6YoVmAtbY4+pL0CMV/+7V/XdbBAsB3YjxraowLftK
	 GQ2V8XZSrEr9FFRezXbcGBeRgxVG+P31veFewQuoPmVlvtdVW4/3EJ5Rn89LpPAkwnQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=BKIXu7to;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794438807;
	bh=NNATsiMoP+gEK4ZEmyo+Jr8l/rQgIpqLSKXdXfcdFzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SLqDAvroySaNx9Q9rMsPxQpLGjZ7lUjxt5xxXywG2GUTOSucBFn3yardOcYj1JHT8
	 HWzdqZt9ILm4mLLYmyHhbLN9Ck/2qDilBgz2Rwg7pf2ndf9loVQ4kLptTbGPdoQ/Rd
	 z9gh7PAmvtLtd3uOylk4ix24kF8seA9OcgqXw78HzsSPhqSgZDle6W3S5CHCS7cx8v
	 nXtTRkQzm4VigDplj+cKXV8UTjIFFLQCQiHDmjLpeEOsrGndtj8ly6np1Ces3va+E6
	 j3tv/EFNjQBwon6dAKG688vMBiJZ1mDdYOyZHJoIUfVWhr9ditI3zjQeYglb0j/cyQ
	 1Gls4idMlK7yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 589E440A5C;
	Wed, 11 Nov 2026 23:13:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B87DDE09
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A953140A5C
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L7X2nZ0EwM6d for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 23:13:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 14A56408E4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=33c1=jb=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=BKIXu7to
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 14A56408E4
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794438804; bh=NNATsiMoP+gEK4ZEmyo+Jr8l/rQgIpqLSKXdXfcdFzY=;
 b=BKIXu7to4fEWaa+gMlrOulKtGaaMoYSVDT1nu9Qfcx/QFJSl39jdDQDv1Vo2kzs8gWO8VZ6Th
 8JNO12m7uXuq1hM9DJ1PxxtlqosOD8NUUGWBA8ts3YIL4MolEcbvK83WbOM6KKQeX0LilPFdcG/
 rVTKfTlhX6jrx7xmvenC1lMBnYPr91R7SUrnFCwZE24eDoxZgNhmZ9rmloBAiw6dt44wcQY57tx
 xuI+NRfdYFibMgAqn9iBOaVfSjm0u31m9kz9THqtmoY/vStRsIQdvMzdYUc+GyXr85QE/g9xrV3
 iHLFoNy255WTXeENo+OF33yaSZS8Hfpdzbqvdqm55wbw==
X-Forward-Email-ID: 6af4f692f53292d6859f3420
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
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
Subject: [PATCH v3 8/8] clk: rockchip: rk3588: Use SPLL_HZ constant
Date: Wed, 11 Nov 2026 23:12:49 +0000
Message-ID: <20261111231251.160051-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261111231251.160051-1-jonas@kwiboo.se>
References: <20261111231251.160051-1-jonas@kwiboo.se>
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

The SPLL rate is set to SPLL_HZ (702 MHz) in SPL phase.

Replace '702 * MHz' with use of the SPLL_HZ constant for consistency.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v3:
- No change
Changes in v2:
- Update commit message
- Collect r-b tag
---
 drivers/clk/rockchip/clk_rk3588.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index eb589732e0ff..9d67bf20fd95 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -777,7 +777,7 @@ static ulong rk3588_mmc_get_clk(struct rk3588_clk_priv *priv, ulong clk_id)
 		sel = (con & DCLK_DECOM_SEL_MASK) >>
 		      DCLK_DECOM_SEL_SHIFT;
 		if (sel == DCLK_DECOM_SEL_SPLL)
-			prate = 702 * MHz;
+			prate = SPLL_HZ;
 		else
 			prate = priv->gpll_hz;
 		return DIV_TO_RATE(prate, div);
@@ -817,9 +817,9 @@ static ulong rk3588_mmc_set_clk(struct rk3588_clk_priv *priv,
 		}
 		break;
 	case DCLK_DECOM:
-		if (!(702 * MHz % rate)) {
+		if (!(SPLL_HZ % rate)) {
 			src_clk = DCLK_DECOM_SEL_SPLL;
-			div = DIV_ROUND_UP(702 * MHz, rate);
+			div = DIV_ROUND_UP(SPLL_HZ, rate);
 		} else {
 			src_clk = DCLK_DECOM_SEL_GPLL;
 			div = DIV_ROUND_UP(priv->gpll_hz, rate);
@@ -942,7 +942,7 @@ static ulong rk3588_aclk_vop_get_clk(struct rk3588_clk_priv *priv, ulong clk_id)
 		else if (sel == ACLK_VOP_ROOT_SEL_NPLL)
 			parent = priv->npll_hz;
 		else
-			parent = 702 * MHz;
+			parent = SPLL_HZ;
 		return DIV_TO_RATE(parent, div);
 	case ACLK_VOP_LOW_ROOT:
 		con = readl(&cru->clksel_con[110]);
-- 
2.56.1

