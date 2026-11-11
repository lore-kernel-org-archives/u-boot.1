Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EC1606A33D
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 22:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=n9PNgqgq;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=i3WzllLF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE0A540D48;
	Wed, 11 Nov 2026 22:35:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Dd8120Sn0fs; Wed, 11 Nov 2026 22:35:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 222F640B51
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794436525;
	b=dQRlOnwvrQWvUGuUa6xxCvxiBjOpK/8G8iTSU1RBZtFL6YgdfQAnfq2ZmTJnBrnSLfME
	 UbZ//Nkw6JKgtz/62903KDGsfUD/+03FB3EIv8eh6PFrzeaMT8Vxp4WQ0YJHmTEIKg+7C
	 po6VtujCcoKjnWFuWc9YqvAChpInsI9T6jI7yRGuymAC2E1+nKMLfkMF6kVMwdwr56247
	 +aZFOoyk2+p8y96aAM67aGjBggUAJsb7397TxoI0L+siRX2EsAIDaXVoF5KvW3TclcJQJ
	 hyY3Taay58zgQplhSJ29t6R/bahzjMUoCfenNfWWRJzbMoMZXuoOp9d0SUtiTgUZmrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794436525;
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
	bh=r+6uz3fh6iNEh7zvuwELpx+0yQiC7I+BZxJBEtLO8A0=;
	b=k7jzM4Llb2fCGyVgCc5suAVGMvomZzHLgLpgHGk0bz31QaqOMD0FS/PL8v+REy6aeQts
	 eb6L9snA65+58F9YJfY0ad2Jp8mJCrSM7AcoakVzo0bFXpFfDqzpRhJaqPsrDY+vmnSST
	 +ACEuIwOBcSC6+GObFo0TGDoMhMXrZ+LHhuImqeVkxitwhbkXuGKUZJlT2McUzBqiKNJD
	 0WHM8wEJySRfg8l2z8wutwnpvouoox1VFLZILqCkhdnj+dOGiphXj9ETixHz2ey4H7XdE
	 lOp8qL6WKecpIyBklfDEaQn3V61sGwn0y8+2/Xlefow4vDs9wi93nGLVrgGXvhQbSAQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=i3WzllLF;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794436525;
	bh=r+6uz3fh6iNEh7zvuwELpx+0yQiC7I+BZxJBEtLO8A0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n9PNgqgqjnxVDBPRMYnGCAMSEEjj2abTzMRK5seLhfjkTdjn6jjnHlw6yBAtM3HMQ
	 Qna7WwTubpNNY9PCx9DoJytScpIQXsQ9NhbRtwzHnBCHro/+4RH0hKJGWmu+Cjy27P
	 hNsZTYhaVEtwRDks0ufO8jlYXgG+bcnzicTwTGMJNOYCc7hMMl17G4MlgM5mcMopj9
	 Qt9Dqwo2RnCyMmfwWPDpHvx+cQDrBhZKRt7WI5l1YHi2z5c4jz4g6Yxx4HW7opU45L
	 f//cR/qZ6uq3fpIZqscqS8AwpQr+Qt53myoFxiEpihWlk8IGdcvoJ+uDNqEtadVEmg
	 Vu57GK4JEbsMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 222F640B51;
	Wed, 11 Nov 2026 22:35:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5057270B
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:35:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 408C240D26
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:35:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6WfEpLn6dwWt for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 22:35:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6F06940D1C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=33c1=jb=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=i3WzllLF
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F06940D1C
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794436521; bh=r+6uz3fh6iNEh7zvuwELpx+0yQiC7I+BZxJBEtLO8A0=;
 b=i3WzllLFKO9SNsxizRVozQ8qbmh8ell+FgA3XYe+PgubDxVLsCVJpXhdF4tP2hjMvWReEVWyV
 CHvaJJk9EI989H/AYQAxzF/0hWBcnL/XrFDsZvjVhShVFHaDshKG6F6fC3KaYQCTh6WLvG5AXzk
 DIDFWYsvUTsFelii4BXTwlkYjkZ+rBxhq/cndAORIhZLW7GsUp+CLWtVK6kyv70WKiyuZSbDy5T
 QRcJHXcRAEjmCbs8jDZ1hn607ZVnIDzfuz0n813jSC4Oyhc0mqNiIdll05FDDm040AcROS1o1dt
 p+Pu46MT+62IHXB2z1OyV8NTNzVbvDmhwZhQdiTYf0fA==
X-Forward-Email-ID: 6af4eda84e7b1f439360f070
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
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
Subject: [PATCH v3 3/4] clk: rockchip: rk3568: Use PWM0 divider shift
Date: Wed, 11 Nov 2026 22:35:02 +0000
Message-ID: <20261111223505.158852-4-jonas@kwiboo.se>
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

Use CLK_PWM0_DIV_SHIFT rather than CLK_PWM0_SEL_SHIFT when writing
the PWM0 divider and the oscillator was selected as parent.

This has no behavior change, shifting zero by either constant still
result in same zero value.

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
index 3651aac0ad33..a52b6a890292 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -294,7 +294,7 @@ static ulong rk3568_pwm_set_pmuclk(struct rk3568_pmuclk_priv *priv,
 				     CLK_PWM0_SEL_MASK | CLK_PWM0_DIV_MASK,
 				     (CLK_PWM0_SEL_XIN24M <<
 				      CLK_PWM0_SEL_SHIFT) |
-				     0 << CLK_PWM0_SEL_SHIFT);
+				     0 << CLK_PWM0_DIV_SHIFT);
 		} else {
 			src_clk_div = DIV_ROUND_UP(priv->ppll_hz, rate);
 			assert(src_clk_div - 1 <= 127);
-- 
2.56.1

