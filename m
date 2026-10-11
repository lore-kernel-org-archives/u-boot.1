Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD45CA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:30:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B96880CB0;
	Sun, 11 Oct 2026 22:30:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jLtnAX2So4p0; Sun, 11 Oct 2026 22:30:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CDF8E80C6E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757812;
	b=jxhQ+zmU/8XPSo+7+9Pwh+l8gAI7t7b4fatvWbqyKn6wpwP+uLayQXNqWVTXSouAxVWn
	 1//md8eR2VEvy0mkc4Xr9MPLtXdR6b9MBaoPmGZExi6+6NMN9fA18Y45+s0w0R72g4ZTc
	 LIo2Wws1mvenCYJYjOz32/Es/bBFpLakb+iovhq+ED529Xe7BI7Zu6kyzCWwCU9QOyi7Q
	 9v0PXF/cFpDJvn5B7uXpi+jo6ECdNY6MZuu7Q5Wn62+j8pEmdOYgymnzu0C1coKwkqKo2
	 97WFLgjhl7slHrYUr1P96XFSFGLMIyqa8UD2V2+vxgrhxntMvLtvc/9mSdI/B1iVOGQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757812;
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
	bh=5W+PgQFD4Y14mQAjDeCSTjAsdZtEIjiXbr8PeWwfS9w=;
	b=Kjo50WMSRLJ4zlsPCzr3D3j4SIVU4oB6bK6XdPoJchC3qxC0/hRZ+850AcUef4lRW7xA
	 97fOXh8lU8C4AkI6vw/vSsVnV3HOhO1tQ2T6bE7vHtF4TXWgxjGp6ZvjgtgQlBTiT36tQ
	 +6xMectxKne9n1mrMyx3K2DkscVL7oq+hE67izkHPYbS09+thFoHc0ST76CzdCzX4ArVB
	 iSd9bI9gkXiuIrHSYTRB7KHlkqhVF+xw73qDppTY50UR9r4AsvuE8BfNEgqnjn5hr3Wm3
	 VXvdTFhqHZ4kTMS0jG9ktY01bzmhEFT7TBAp+gjJ4g9Cy2h1ySdPkLrotJ4yGa+gZ2Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=HmYi9ZTR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757812;
	bh=5W+PgQFD4Y14mQAjDeCSTjAsdZtEIjiXbr8PeWwfS9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DsDSAhC1czbIrplFbE7Dt6bW47n9QyP1S4aq1HBWihqOdUszisPGzGI6/Vehd39vR
	 okffRjo6bEn5lWX/PPayMuXsKxd+Pmup5Fbolc3rv34t6nQ8uIffnrwVmYfCHSekqX
	 DaGsA5Rpu2+85T+AqhcrE+TMDsXfntZJt4zOrLZdrdZRgVw9kFDvfrznQOavXy6jLc
	 RZmXYrvEM7Y9ZqlPCfV1zzG9G7oxIgJACwycaQpfdSQM7RIkCW+OVZyFEJ4e5dYJlI
	 Fk8fkqVX6vFG8k+z1lRx2xmH2CZIpj7z5mAped3e2H2AcuuKL74UFlsT0ABZliYLa6
	 iZEQzBAdG9SIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CDF8E80C6E;
	Sun, 11 Oct 2026 22:30:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 87B3B194
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6D5AE80CE9
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S0UbLL9UlrDd for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:30:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9052B80CB1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757809;
 b=YuH/JjBAqentk5TkzjXL52oTx3gP7322gTGLjz+y1nM8ajTpKLv/eX0bF7ESlmPT+BtP
 F/RwnJ951SOPi3EKcS1lCUt28Mwihy/jmVsO9YAHNuvA4Um8a3ZgMPe1aS9UzUX89OyO8
 5dfbeuQJWxAUgGiT8/bBVSFtKiTEMZa/q2Rw24N/nQ/M1qVWrC1G+yE7PrsxouibebzfS
 h5404Q6OscARQugQncUllCF5eHD+1tkQGBJzlbLrKeUaUVma+R8ruF1JbGyWgYqOwbc8t
 57kc4rfSqeNP5ru9Er7Y90fSSyA7LevDIVMsT91eYwNuvrXIlS9nypCoUtviOWQvrbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757809;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=5W+PgQFD4Y14mQAjDeCSTjAsdZtEIjiXbr8PeWwfS9w=;
 b=BmIioj6zLCP8MQwvyDGTQm2CMYPYLV5lumffNZ+HY0az+zBtmbz7E+cU+H761D1ZjcPK
 cL3JxqFa2LpKYSRkg0DGAppdU/RkLxT/H5QknV8z8nrVnv69/jwWu4ie0jKxeXgbuARJR
 pr1dqrZwxNWioJbewjmNci5x2Luob4TVAfLNZ4z+HNohwPi1mKUp2sVgjXGLB8/8YWW8J
 s2ogaR9U4+RJYGbt9mXb6o+0NY8cD9zwc5QhMA/iayo2gzEB1LIrL6Jg/4OQmWU94AoJD
 SckFN50a/hqNjQtslS9P6Zqa0Klg8Mearn1HLYt3oXvcLwYzE6Ehw1HzUekWzXHETsQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=HmYi9ZTR; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=HmYi9ZTR
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9052B80CB1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757808; bh=5W+PgQFD4Y14mQAjDeCSTjAsdZtEIjiXbr8PeWwfS9w=;
 b=HmYi9ZTRE9lBNg3Q5tugAAu8+89Zs5TJrHRxoftWwnXxF+nvMi8oA1CaYI7hD9YL3wOyoIkUJ
 WsQ6SzyGiESYovVG0rUe83PRj6sIm63Uiyxc1gAfL2/A4COTr6CBXucrpQtEZ9Rr5OgVaKmh+w9
 kFBbcysGZ6kFclcvhpvfbB/1iv0iPh2FcBL8/6wq3L+ZS8M4IsBIvNgubUSBboIMJJ9/58UOCKE
 berpkIBbKXhV9Y6Gh1hAHo+LrgGdaCW9hOGunqOrwiXP290LqXAZ1SDju4G5xqZrE+a7sLwiyNr
 O6r/VeDFyBdAHK45vsMQRbnqmQl8qXzBpmLbGU1cIrOA==
X-Forward-Email-ID: 6acc0ded4548822a24c1736d
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
Subject: [PATCH v2 08/37] clk: rockchip: rk3568: Fix PWM0 parent selection mask
Date: Sun, 11 Oct 2026 22:28:43 +0000
Message-ID: <20261011222930.1085075-9-jonas@kwiboo.se>
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

The CLK_PWM0 divider mask is used twice, leaving the parent selection
unchanged. Change to use the intended CLK_PWM0 parent selection mask.

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
index 86881728667a..88bbfb68cac6 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -299,7 +299,7 @@ static ulong rk3568_pwm_set_pmuclk(struct rk3568_pmuclk_priv *priv,
 			src_clk_div = DIV_ROUND_UP(priv->ppll_hz, rate);
 			assert(src_clk_div - 1 <= 127);
 			rk_clrsetreg(&pmucru->pmu_clksel_con[6],
-				     CLK_PWM0_DIV_MASK | CLK_PWM0_DIV_MASK,
+				     CLK_PWM0_SEL_MASK | CLK_PWM0_DIV_MASK,
 				     (CLK_PWM0_SEL_PPLL << CLK_PWM0_SEL_SHIFT) |
 				     (src_clk_div - 1) << CLK_PWM0_DIV_SHIFT);
 		}
-- 
2.55.0

