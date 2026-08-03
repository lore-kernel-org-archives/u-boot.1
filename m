Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2172C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:10:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B50DE80BFB;
	Mon,  3 Aug 2026 19:10:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XR6QUiVLbYz2; Mon,  3 Aug 2026 19:10:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ABE3E80BFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785784201;
	bh=2JM+1ZWHjMRbQmGBt+qLa1Qk3VvIm6FczvUuayX1TbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wYIgPsoIhXZMbAOiOuPHfa81fly6JZXpaohMdR74immb8R69y7gQFK0e+tTduraxm
	 jNRvgN7HMNPwGinVzSaqtVc9RUqmSwEa+btzZrPxoANASe1cYXE5an9gcRkny24tnr
	 6PCG/BTMjjtuyaIuyYAfCBi0A+L5gFAAFUFcZN8nvdzjDkAnXsH3U+2TC1RZkHODYC
	 oD3RKZdZ8U9kdAruS1UMK0F5sgjGWkctbvJdhDsWMyl8QrwqLOybOeXLvhslLGKNWK
	 e2tEycmK9WkIksxCTtaO2iUWJEnXb6mvZdiEQLx7eavoWySPWmqtrdhAgN4wE5WWzR
	 NaXltRApBrkQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABE3E80BFF;
	Mon,  3 Aug 2026 19:10:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 878D92CE
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:10:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6CBC580BF5
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:10:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v6PPfkay2oQb for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:09:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a02:6ea0:d71e::9;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eb25=f5=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 69A3080BDF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 69A3080BDF
Received: from smtp.forwardemail.net (smtp.forwardemail.net
 [IPv6:2a02:6ea0:d71e::9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 69A3080BDF
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:09:59 +0000 (UTC)
X-Forward-Email-ID: 6a70e783ae1ce3dd2fb7e596
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.13.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 3/6] adc: rockchip-saradc: Add driver data for RK3506
Date: Mon,  3 Aug 2026 19:09:41 +0000
Message-ID: <20260803190946.2259514-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803190946.2259514-1-jonas@kwiboo.se>
References: <20260803190946.2259514-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785784198; bh=2JM+1ZWHjMRbQmGBt+qLa1Qk3VvIm6FczvUuayX1TbU=;
 b=jQ8vgMnTt9lofhznOpO9VaQZDDcIj/mp36Jg2cVlbceASJtppE6cM5+VdpqVU9TSEw+gqh9uF
 pSyWzy3IfE4J0RNdNuHVcBTh27ZnDmFUUh02M8fGsCdizD7061A6GImI9B/MypFWG9RiFwA564p
 tuyQG6qgcbKkDYo4RwZuRq9wFtUWYc4ZdXU5dtn+KXfgTNxVYGVPQ0X69Msfv8Rod9BBdPQT6Il
 cQZ4fpTUip9Z5pfbm43Hr60WuB4UmJfL35czWX3HTssJ8MkkhqR/5F7UQ1DL21liUfZwIvwEvIb
 sB7ti5IoqYw2nhgKcndyPYMogYQUixNIjAcdceuYLkNA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=jQ8vgMnT
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

Current rockchip,rk3528-saradc fallback instruct the driver to use a
1 GHz clock rate. However, the CLK_SARADC used on RK3506 can only be
configured to use a 32 KHz, 400 KHz or 1.5-24 GHz rate.

Add driver data for rockchip,rk3506-saradc that request use of a 1.5 GHz
clock rate, to avoid clock divider overflow in the RK3506 clock driver.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/adc/rockchip-saradc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/adc/rockchip-saradc.c b/drivers/adc/rockchip-saradc.c
index 1515951403c9..50861b61eea4 100644
--- a/drivers/adc/rockchip-saradc.c
+++ b/drivers/adc/rockchip-saradc.c
@@ -339,6 +339,14 @@ static const struct rockchip_saradc_data rk3399_saradc_data = {
 	.stop = rockchip_saradc_stop_v1,
 };
 
+static const struct rockchip_saradc_data rk3506_saradc_data = {
+	.num_bits = 10,
+	.num_channels = 4,
+	.clk_rate = 1500000,
+	.channel_data = rockchip_saradc_channel_data_v2,
+	.start_channel = rockchip_saradc_start_channel_v2,
+};
+
 static const struct rockchip_saradc_data rk3528_saradc_data = {
 	.num_bits = 10,
 	.num_channels = 4,
@@ -362,6 +370,8 @@ static const struct udevice_id rockchip_saradc_ids[] = {
 	  .data = (ulong)&rk3066_tsadc_data },
 	{ .compatible = "rockchip,rk3399-saradc",
 	  .data = (ulong)&rk3399_saradc_data },
+	{ .compatible = "rockchip,rk3506-saradc",
+	  .data = (ulong)&rk3506_saradc_data },
 	{ .compatible = "rockchip,rk3528-saradc",
 	  .data = (ulong)&rk3528_saradc_data },
 	{ .compatible = "rockchip,rk3588-saradc",
-- 
2.54.0

