Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172C2CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:31:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D15D980D64;
	Sun, 11 Oct 2026 22:31:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ctglcMcQuEMA; Sun, 11 Oct 2026 22:31:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2F34180CEB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757868;
	b=N9iUFz0j/2Rif07aVnQjyQrAO4vbIS1aU/sLlKTUlBfyqwt5RuAGawLI3efUrwVKIGZU
	 5KJn6TkGxSBuvw0G8CBd4TV3ElOgRwefonO2CUX2n44nr7xvoElwCTcP6ffF+TReNaVVk
	 eildI9D+ARTU8J7oeti/Gq1reYay+rn4QRQ/o2bipNE3Bho0U5cJraFxa6N6Vk0og2sTd
	 kX2MqtB60BV/0XGbs3G8NCoUMv9iaWPrWPqMXSpGJktzyQBCMjPIkcP1xtESlHfQkVCgl
	 XxhfCPrTEXtCnNzA3oTwPqU29LSNRIu8ttfI9IvvIMcXOnJOBYBfPsmm5NhdxODBgDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757868;
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
	bh=QkfgFe9fuBeTXST0rssiMEz2Ef/Dctyz3ISKoEVNAeo=;
	b=IGWKagE+tn8CpTKileBv1LtCxamzT0PK7exn9e3XzAa/7O0/QKiz2/GQ4XPSi/1guLG3
	 Rkhoof/jo0vN5tBq83aYPTV+x5ZXIW812p+H2cdBuWK6BX235oTCiRB30UkjlueYFASoP
	 JGbBwbjbov0oVQ/m26j1J4mHbriZMuZKQyiAjxSPtI0kZiwLM6aVd4wq16SJkNVwBTP/l
	 yATg7SfepUDUvqbase0FlBiwQ6VjARotE/G9VBw+5+MoNUhYtaX0zeUVcxMdwRkHsqq8d
	 Ey9UDkBOIJEfByLV7a/tnf+FEW8kPFl7aoOP8+cx2xDZM42AZ3dMrEbykAmzmzgO0Ug==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=eJbXbwCB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757868;
	bh=QkfgFe9fuBeTXST0rssiMEz2Ef/Dctyz3ISKoEVNAeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c9dWFC6JUuebVVNepSEGbgO0UOb1GL0J+esHXUWpvhEjQ+Bi6Qnz/kD4ozy9Dq7bE
	 RY2BZ130/LqEWYWmjFXftHVMqKPtEr4aHb+K9NeHWK5Ha8hE8hEwfuEji6QY//O2i9
	 PMp2frrMZZXFqSFQ4PuRtRErCBpUoDCKS2MsIZnw9aYMKKAzlxhOOzDw6CoWA+8dIE
	 OoVN7Pu74dgjMN6xMGVcDqfQ35mG7AETOFoEy7SZUKJ5Uxy/0FD6pOfdKlIohC0tGD
	 W7vB7HD7soN7IoCe4jvFiL3BxcOZObMauIsMXk2N1okxN3JxspM2s+t/EAYMPuXehb
	 L6EXf2GKHLOHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F34180CEB;
	Sun, 11 Oct 2026 22:31:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 62BAC194
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5491780D64
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7HKQ2nKLNA_s for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:31:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B063980CD8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757865;
 b=lYF11iuQ5ggpy1iSyfczrn5lOo8zMpb1y4C5lwXC288ZYCoiiq0p4QhINr3s1EDk2Lhe
 ztoUvbXRMKYXxPalYonnn6/WprAeppaLvpAxGqAVwjfeZZsCV/9v9vP4XewVxEem9onq2
 rXtNd9CyL7zHJkDryo3nUqnLcTBbcbhqT5AOzsoJJRwz3ZY3/6wYOz2viDBwj0NNCgWhf
 iqY4XJLL4eLVnTBW/bs+oCmdrDX7LpONalXvRY0TwAdeygjlwYRaBIk5HvNm4v1E7Bnza
 +oMqyPyQTzmH4il14ACkmg/2hj4tA2T2h8pRx3Z4EXUU68ZQNpD7Dxr0QedwRZlXO6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757865;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=QkfgFe9fuBeTXST0rssiMEz2Ef/Dctyz3ISKoEVNAeo=;
 b=aTjM0Fsn4JvxdTckYzRzrcU2L5byKyp7eKNsJcOYAoymhL/P35ORZWbuO1OKV3b1Es+F
 /o+Zgzx443BOTpTANj0OfLdKpx5yjMd9n9Nu/B8TXQ9viDpuaMwzTlsnTpB+vrPoOa9ju
 mayFVXlJRSecA3GD5e2veH/CyIIOGMYN9rie4+CiOCJpWZKQMrbI73DK5VwMBe85ZoKg9
 O4kQCV1yl1cGPPlJEDg3gnIN4HhQu6FxDAwDxGtTyvTRItH+yQCdWlvasxqV+tV+9KENC
 Cny+dXxTQ7wdMQo4WyO1KyGEqyCjcadLWGJXOw00MQtcjvrQQyCdJzCTySIIFzzdh8w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=eJbXbwCB; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=eJbXbwCB
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B063980CD8
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757864; bh=QkfgFe9fuBeTXST0rssiMEz2Ef/Dctyz3ISKoEVNAeo=;
 b=eJbXbwCBmn4l63bG5rYQtReNy5yhAlMKTdsgiKzOQbAWjK2Zg1PknLAG60m1pCp2FWn54AYL1
 pZlI+7vneRIg6Pcj2KqxiRzhm8Nxu8LufNwahyqwVz2if0zb600hYHtTNOssjOvBfwjNkNW1Mbz
 1Wyo6DGrrP/dtVehQMezbZ1HyOot7IUFhw4zEwXLTWG+Af6Mj4ZF6xJt1xSP1F/hNQ3A4FXlv3Y
 Kh7dluUhOXurQNy54tunTM1Gpan7w4OkPwALrWwmA4IhlOno0vfeyB0EnLsCiUCk21iLoDNkr29
 6B9j5B1wDKVbpycvzqhXOCbphuufXMQB9VsLTXtr/ZIA==
X-Forward-Email-ID: 6acc0e1f4548822a24c174f2
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
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 22/37] clk: rockchip: rk3576: Fix CLK_I2C8 rate change
Date: Sun, 11 Oct 2026 22:28:57 +0000
Message-ID: <20261011222930.1085075-23-jonas@kwiboo.se>
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

Add missing break to prevent rate change of CLK_I2C8 to fall through
and also affect the CLK_I2C9 rate.

Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Split from "rk3576: Fix trivial clock configuration errors"
- Add fixes tag
---
 drivers/clk/rockchip/clk_rk3576.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index 314a543895a3..04b0f6b13ed3 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -469,6 +469,7 @@ static ulong rk3576_i2c_set_clk(struct rk3576_clk_priv *priv, ulong clk_id,
 	case CLK_I2C8:
 		rk_clrsetreg(&cru->clksel_con[57], CLK_I2C8_SEL_MASK,
 			     src_clk << CLK_I2C8_SEL_SHIFT);
+		break;
 	case CLK_I2C9:
 		rk_clrsetreg(&cru->clksel_con[58], CLK_I2C9_SEL_MASK,
 			     src_clk << CLK_I2C9_SEL_SHIFT);
-- 
2.55.0

