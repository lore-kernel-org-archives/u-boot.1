Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97142CA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:30:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A09880C7A;
	Sun, 11 Oct 2026 22:29:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WMzErgB-4lSS; Sun, 11 Oct 2026 22:29:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7D63F80CA9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757798;
	b=cJhb6QPCBlhahVfyag1rTqCs8l1qNkHZFsHidc1JU/iutFWjU76mdoHxzhcFEz0uXElQ
	 wOLv2dvSLdv4CRAO2SaDYe7emSzZ/I0VNj4yZ4v5AEl4G/X4H8Fv0IfoJvzFfKidEetUr
	 f2Vs101j+h5OIw2SGmXfAfNNXtOEh7uNqcEyHrmw5i4ARRNSb9hII/VqXPh3tKvpAHb/n
	 LaymV7a1597nFbhK2xJ3tj9Z0Gh9+2akGeJnqlUd0NFJOz+928wIAJpNAWuhTa9nuFmnK
	 cUujr0zUK4tKmSkNftt7zNBB6mL+Xsdjba7cFHn66NtgoF8ZgM2fxs8gS38CSfLEe3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757798;
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
	bh=BIbpgEdS9V9aMWa1cmhapS4R/S0dUMI163qoHVhQHrU=;
	b=kDRufGkZS6uTIJ/OrPbyQ1/BC0yLQSo99YwfJT/qjKMsrN6ovvgNOE+M9+vipu1I0XC0
	 2FclFC+6x4jSi8+UPbevvSMQBZWk55ebdJ5r/lKpkoew3PHt4oG575+0g7Nc+eUjp7Hn+
	 P1oINCVuzIotxsnC8qMRvHhY+tDAGBDfn6YW+npiH4y/fWNR2vJoiQiCsTkSGEH0iRms2
	 K/L9E79UboVk0aKGCkf7lRTbCP1+lv/LfgG742rdYrSZo0l/NvRgyoYbMb2Qz69OlckGN
	 nXdBhTjyV7oXv0ziVG//7SCkQrX8BinoCjQ/FfjxHzM6zuBscZgPx3Of3q86uKAOo4w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=YuH+RlSo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757798;
	bh=BIbpgEdS9V9aMWa1cmhapS4R/S0dUMI163qoHVhQHrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PkSD6v3RgkOcJTmav7HnQ3XE8KG0VJ0Mb1HakjR3A1PPXmwXYqp3LKQ6P/p2ZVfb9
	 jjWgrWGGEBd217/XJG7VMUAxaQfiaJaJFDSqGUNLPpKxZ96D8al9OKT/RL/5ogagLi
	 zvKYkdYFxICoN8twDmbu3BPM90DsO/2/qwn7I6yQ23h0i4mx+FRH6PDHj50tyUTqnb
	 jQ7wK7kMAWWKciPyTMck7ptdbVOgJ/dj35MqGpGGZjpYtbCjugWkx0Dcqy06d3Oesp
	 rgE8NuTUyG0ABz2FatECNdypmnte6ecajk+KpMKZuO4Y6ZDC1cM77OzDRCbbplRNIy
	 M/1Njl3hLfC3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D63F80CA9;
	Sun, 11 Oct 2026 22:29:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 55CA9D5E
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:29:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 18FC380C92
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:29:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a1boFzcGhdu8 for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:29:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 56DB580C66
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757795;
 b=BF6H6+Di9G2BuzDTR2+F2oOT5ZngyOxgfBzUySRa3GRhTCVsWsyb205u+39EjOghY/K9
 CgYpAjFiFfK6pIEZc36J9Nd3XcbjzUvmIkpRcLgIQKMmX0ExQmjsohTK/nQ2WIF2F/WCt
 WUdlJOEJw4Z93rGVuCG3yftBdCfOVXUHujsiuDg0GYNMYgiRnBYtnu/Q8OPzfGFk5+hko
 HJpMPdDLN2VlaD8RCBSHGz3hBlLDN040GhMRqOkHpxMmpf1o7D+6yAimAGfKndeY47Ie+
 bvBlOhB+pTR02H3VK3PPSrwyfLKvDU5neG7XkTIYwQ7ZmaimuFIs4dTB1B2emqcTS0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757795;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=BIbpgEdS9V9aMWa1cmhapS4R/S0dUMI163qoHVhQHrU=;
 b=LlAUrO82uwPbgA+PgQiTu8Esc0Bm074dm/W4JuwX8eTHN1Dbb1d5iC7txn2sIsVmnN8D
 2KDFfuzM4IydAlSON9iyxjnmjqyXY7F8eMwdMhZMqJS1ODcQn7/y9wre17QO8DkdKRzjV
 DH+GKlDzTCu3iw+gveXn/tsdNSKfNP69bTej66QyKHE3Z+9cOxRrSeEdnKR7KkdjiMrOO
 ++u3QJQ9VeR4uDhBM5+pJXBzu10rL3PfZhvCeo7rXb0vi2n9eZmmiac93jsKYcwKQseoY
 LqjWMQU5fnvWVm1ghnl+na+rw0fuCGrMmqDSAlrFqRBFila5ppqdvWFVKoP6e7xFJuw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=YuH+RlSo; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=YuH+RlSo
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56DB580C66
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757793; bh=BIbpgEdS9V9aMWa1cmhapS4R/S0dUMI163qoHVhQHrU=;
 b=YuH+RlSoMbjB5lAIowQdjFLQeyFzGsOgRpTrIPqTc/QUQeRQ2HsusCDpe9N6rHXW2eg0w8h1k
 JfQEX7FQZ+VEeZJURYoynNsi/BWWAkEx4onvjOM/sPpiFkRnJnY1rql4Ue4lUtrPDZMk+uuLQI/
 xUpmmyFCi7Km03pwoTbu1kkLuUX+3MxuTooIgq4XDwItZEN3KKsKJ4YpcmpgAOW63D9aiWuRQpc
 z5ZE2Tmf0HFYcGwMCYYnHgVQYGpZl5ZLlCcpXB966BLy3VmGssAGk6q2a07QWtPJ+tMvS+5wAzl
 yIzDhBC6WbqaV1UlF9k6wSwgRIZEn4YpYij0g2vy4mhA==
X-Forward-Email-ID: 6acc0ddf4548822a24c172fe
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
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>,
 Jagan Teki <jagan@edgeble.ai>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 04/37] clk: rockchip: pll: Always write the k parameter
Date: Sun, 11 Oct 2026 22:28:39 +0000
Message-ID: <20261011222930.1085075-5-jonas@kwiboo.se>
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

The k parameter supplies the fractional part of an rk3588-style PLL
rate. When changing from a fractional rate to an integer rate, the
k value is left unchanged, leaving the old fractional part active.

Always write k to the register, including zero, so integer rates clear
any prior fractional part. This also matches how Linux configures these
PLLs.

Fixes: b851c006a150 ("clk: rockchip: pll: Add pll_rk3588 type for rk3588")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- Update commit message
- Add fixes tag
- Collect r-b tag
---
 drivers/clk/rockchip/clk_pll.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index 5de930e41dce..6664fe3921b8 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -490,11 +490,9 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 		     RK3588_PLLCON1_S_MASK),
 		     (rate->p << RK3588_PLLCON1_P_SHIFT |
 		     rate->s << RK3588_PLLCON1_S_SHIFT));
-	if (rate->k) {
-		rk_clrsetreg(base + pll->con_offset + RK3588_PLLCON(2),
-			     RK3588_PLLCON2_K_MASK,
-			     rate->k << RK3588_PLLCON2_K_SHIFT);
-	}
+	rk_clrsetreg(base + pll->con_offset + RK3588_PLLCON(2),
+		     RK3588_PLLCON2_K_MASK,
+		     rate->k << RK3588_PLLCON2_K_SHIFT);
 	/* Power up */
 	rk_clrreg(base + pll->con_offset + RK3588_PLLCON(1),
 		  RK3588_PLLCON1_PWRDOWN);
-- 
2.55.0

