Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77329CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:30:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30AC980C76;
	Sun, 11 Oct 2026 22:30:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Lcxl-0hDyQv; Sun, 11 Oct 2026 22:30:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 70A3180CB6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757820;
	b=HfscHZHUMcdPH5FV7+buEQ1wYpjVnclcRsfY97XMVbyEx+MV6kOaUNEnu8aeUzoY3Xhk
	 CBO5s5+IoIjhNYeQCWt2ReOfy5kkEFZLxLOwppHL8phsFPt29pTI7V3VDFfCpqg4B1t9O
	 ZFunTgE9uL+yxl4OMn0TMGoT1bkU8kv8HF0xsEYW+UBXO9W7bN9U/7sXMss61eTkMVVuP
	 i7ZYx2/K2C9maV71463yU6mW3sDK/mvEADaHPaFk6hTeJEPf2eoG6yE3P9G/QcXGZ1wr6
	 /sZGIld5qplPrFPYU6QMyCWvkWs4BLSWVbr/jTYEJgDgw4+z+Jtxjg2L1lW6UakafmQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757820;
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
	bh=Uojnn8LRNPBlwDmyV2MgR/eVXuVxIyaQd6WytXlvMhE=;
	b=KO0noGDHeS7g1YMGBJEhzRGHBozInhWutgPB0li5Dc5pw6gPYrXRk6WAyPMcWtW9ysuf
	 Jm6RwcZY98TvtTEkoBDrUto3NB5eLFOacEYVvjRo5hEzkc1M95tX5qhcEMcVe/ABIGgfC
	 Y+ZLWX7jhzVRuzTKkE0+ZEIXafJpsR8okxlt53aCEgWipJw3DsubgQ4EPCERukye29D+J
	 eqODh4G+ddy8vFGb9Dqg1sOFbmQZwcvCOKAdFqK5eLBZ1xjat9yxCnGTxgyPmtxrO3zRH
	 yjrj221yOTYtxNY6hWKmjwUUSflP7wcEQOWNqVNH/fRVC12cTg6UsDtd6dNYx75TqOg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=sCLKdP8K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757820;
	bh=Uojnn8LRNPBlwDmyV2MgR/eVXuVxIyaQd6WytXlvMhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W17PZ7WKqyTqaNWdxLN8dAw3zHCB/MhAaRTbt4SXw9uxHv9u5uZps3qq7/KloA6H1
	 Ipz7WIdq9ulD9VB/tdLPkFsL+W64dXQyI+k9L8tQtztcwENDbGr/BfxDahKYFLypDq
	 s0uzFlxRfpnWu3rd2kQ5Kr2ljYg6lzVymeNs1I0lVlfNUYroHa0/y4nxClLdaUlQqd
	 Vqo2pyNq+JIVgUjQk3KCCxFlkXwZwPHh96a+VxUubYPLHQyrGFXbuHL74A4lBQY5JG
	 0Vrs9Zwwsz7Ffgfab0OpwDjkRuuTZj7jWka9DGatFkGKxyoqJlnbC4pQVUhIlnbHLp
	 04uPpDg0JcQbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70A3180CB6;
	Sun, 11 Oct 2026 22:30:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BA177DE0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A06CC80D1F
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x6umuKbUMD3C for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:30:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DF3FC80CF0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757817;
 b=NcLYZGCX3dwiEJ5/1Xq+XwGfW2Nilor/YaEK2XhJElsrrBPc47cGqQmHm2KSDsut0QQx
 x+u+PwiYhjGEN6bEwz/DrdlYMYOE7fQxUWmcmpncGVLgOeSj10h2g2mefwSX+xyFXxKdc
 1MQC2dz/vD9zrMBE7Vl+9pzkMgjFGTMUSyaiWHahAybrMrKkc0t7SbW9LaeN4qdirfjvn
 LYwwQCJnpwCHfFQFTDELAJe3MX/12qDzklLWekFxsIJRCiPinrBeNw/2dREHvNCGl4uj8
 RJOaG8Rn/FHRptePeiugbm9ZEGUrapFjMUEt6z/oZJLOaMpIUmNIQ0ho75Ki8xEuipg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757817;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=Uojnn8LRNPBlwDmyV2MgR/eVXuVxIyaQd6WytXlvMhE=;
 b=mkj9k0Ak1nKXQx8Rbl6IuS02ELnRTgVnAciFvg95hy8hBc1D+dL6dQScPnYZO1tK1dxC
 vz+yHChl9UFWAQNLyNjTEN0vbBaZfOhnGfpH+be2zeEPpPAeOkRrBE06XKntb/phQTvhS
 RGiOJ8TJ/P117/H0DUZkKT52oLTO0UfC578LxgNUQzzBtRa//N2SSjTFGfGokbDxorO/H
 /yAXklGFCb23YE8VhfBXrhjw5dtNurILayLlSrGUz+t6usqC5uH+ZCkuK1q6Y+DYDkjuw
 ZcYU4SUlEatchqj2f9aS/Re9qvb8bxUgRx2JyxGB0rY9HIAMLxhd6lwOkZLC9UwZSrA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=sCLKdP8K; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=sCLKdP8K
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DF3FC80CF0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757814; bh=Uojnn8LRNPBlwDmyV2MgR/eVXuVxIyaQd6WytXlvMhE=;
 b=sCLKdP8K/gPGVcJ1fRzeHbKwJMmzJkVcIlKfQYOD39ywd9LOzPKGNaNm8gVz9Gqt6fXRffvSz
 /hupplH1Rpu3CQNO5YLz7NfImE/NLhWI043BFvGPSg1Lx52zsrKTZbd9ZMuoQRVOsDgt1n2CDOT
 1RmGuGnbvgH8XSOds0q3zJbN9t1zSvbg8BkdK3xgQaUd6IHv0/3B0TqGFgnpK0+5bKFpQJK8fwc
 I7T+8oQQhUGOMDdyI2Rzzgp/HiB6xohWeEoiBckJtS37B52BsFxcAuRHvlk8RxtlIKPPnGv2+Xa
 aQyOg61kqvntAIvZjMMqEa/F+a/Z+pNXc7xlZYCLs4FQ==
X-Forward-Email-ID: 6acc0df14548822a24c17389
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 09/37] clk: rockchip: rk3568: Use PWM0 divider shift
Date: Sun, 11 Oct 2026 22:28:44 +0000
Message-ID: <20261011222930.1085075-10-jonas@kwiboo.se>
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

Use CLK_PWM0_DIV_SHIFT rather than CLK_PWM0_SEL_SHIFT when writing
the PWM0 divider and the oscillator was selected as parent.

This has no behavior change, shifting zero by either constant still
result in same zero value.

Fixes: 4a262feba3a5 ("rockchip: rk3568: add clock driver")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- Split from "rk3568: Fix trivial clock configuration errors"
- Add fixes tag
- Collect r-b tag
---
 drivers/clk/rockchip/clk_rk3568.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index 88bbfb68cac6..398f76488470 100644
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
2.55.0

