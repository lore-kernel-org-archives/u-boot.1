Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F866CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:31:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 156DD80E18;
	Sun, 11 Oct 2026 22:31:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ihdG_IHv1xYm; Sun, 11 Oct 2026 22:31:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5913680D7B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757913;
	b=MXBhfNCO7F3TEMxH7JETbUqdBOp5/X5zdTU11omIabsQP/un4ae1YcDNYsjeD7Iyfjqt
	 VHjjUq5EgjmTWp4W6LQZabb3roNPT3gOeaZTXg7xoe1fA55QyImV0fCNpgSIE8dGj+LqU
	 H9me65UULKBviM8LKfvkzoM/VqekY7602XZMJ6jsXHc5azy1kC4ACfUH5eQhP394/pKPT
	 d5XaTjwiN8v5PNZShp/rjPvf1fH+8PJHst37kyZyp3T9IsdRuwciNN4FWLIUGybHce+5U
	 qOzHaVSywC5Y4zRvNp6hfDGaVccBknTLcwxDNuVWa5dBTapeNOY+j0ynmLA1NWvM7Pg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757913;
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
	bh=vmjBn9P5DaVIlGPrcX4WY3N1rUhPWaCJQW6DUA8Xqik=;
	b=LJNGj+4aEFZSTCWA63xpampyLFHrtEmC9JbKo+eCq73TPr/FjYXHuegS1zy9mL6iMgaN
	 qAtJL0leElvwmAh+NQLl1YFDmUY+UgQz0+cllp96BUdAOU2SfiOq06magRg3UC0ZyXcir
	 RIrtmcIGkiWW6lLZqQ/GMGuB98tRTVBw6EtGxRJ6SH81q2QEDFNI/dXKDjAtkGPy2XZ3e
	 eCCiVM/4fxDh6cbYzNbxcMKO3+IDqOtjN9GKa+lBvw/8pCxBybwKEBufAlXpU9U4oFKzj
	 j1ennNEuRPt4bYkH6dDKcxUGVJqoElHY6rEw/y2Mq01+jfStEk80uxxeXCtWXRlCTNA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b="fwToTns/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757913;
	bh=vmjBn9P5DaVIlGPrcX4WY3N1rUhPWaCJQW6DUA8Xqik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hXIgIAa5yhX2dktQT5GGYv60jfdD7Rr8xJSQWTUzQ0ySef4UMRVlMIkPg7VgQXjmw
	 NQhuQzuRkE0jhzDrcn1v9Ay9jqcKpKULSRY0MdbN617SRWTzV4fTTNH3n3Kep7G6T6
	 uBN3q67y7Nkbtsii728ZXIuHpNzowsFxn5hCBmRGWyKgvEg9+2V00OHxNkHa5Z4mTr
	 ZQzp9MLOhf7TZWLL9evd6FUpLr09x9LwofggIiDxEPM6Bu2ekXtLZsTm/4Z/Gteomf
	 KgicGLQzcyebDOFM2qupskDKgA1pQSwkNDBprHMXRoEH0CZ8/BZ7EKIcE1RYGas7H0
	 gTU6DlnPtEDpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5913680D7B;
	Sun, 11 Oct 2026 22:31:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E29AA75
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C835480E15
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GlzemGyq82XM for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:31:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0D35780CEC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757911;
 b=Qs0GUrC1Xh/Ryekhj3zZyR8xzsTVfEhv+I62cuDBreDHGkEq5Nvatj5gGnttlJoR9tpK
 iI3On74jOWrhEKbnhnTsz4Mc3Ymb+ks9VrIPhCeazSvr6Z5TWkvVt1LMueT0jfkuiSh4u
 /wC6W+AMrvkeoo0xuio5Tfqt//GxIqyRvtcIKPuac5echVq/veH4SI02XanOQVurbGxY9
 TdMdyE0N03qIpQBFvDcnnSeZMQuJdVUO91R2fbMdSL+uS+/HtUn5f75sJruLEfOQ/e7HN
 dFnqPbT4bVqnI8Ezt1gG3peRYCAoV6R1I9BElxCGsEIDt1C3cBdK2h81BdYH2sbU1bw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757911;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=vmjBn9P5DaVIlGPrcX4WY3N1rUhPWaCJQW6DUA8Xqik=;
 b=YQecNGF5hFDiJwOaddzl7LbU8efIL5cLRlog81cfwb326J3F/JRowrCAHH0YvVk4eetf
 QjJRl5maVznsaVYSfvVj9nzhcvdr7slmkp/A8LmIl3+y24LHzhm4biaf5xPOAFRImRyxg
 uoxLxSEmyIfyLfQD9eE3l2HQa8SQjxchosb7uk1TkVNXTLwOSeSM7esrUZWmRGA9h+Ult
 +kny5agmnLCGvDUwYh14Wam2k1xSDYETfL8ouy8QfRHpt/E3IZrsiwI+j6inNKBgANQQc
 fJ/4ZdqwDCRszYXPPxQ9BGBXNmuPSexQD7F5K3KKYiS6jzRitODKcqcA+uJvNlMnt7w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b="fwToTns/"; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=fwToTns/
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0D35780CEC
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757910; bh=vmjBn9P5DaVIlGPrcX4WY3N1rUhPWaCJQW6DUA8Xqik=;
 b=fwToTns/jM1vV5zOVZm4HnltbM59sZGgADHx1VrmioxiCCqGvYiHIHWk7gGd2lYQoTyrK4ZXa
 VgX4fFa1voWt+oznUJENEe3FHYVVeVW7mHyhZAJ7IGVgRL+hlGFYGcp4DeZWtSrBdLw9hbrZDdl
 T2j62v8c9BsQCueSmi5FZF5PyrRjdpjFl0O3sKz+yCByul3W9AVWBDty1NIsGxxWeQZ/7HcEl85
 YUla6B1GWQy2QglVyyBSkHFsxRUJ2I7Iv4vxPAC+r5qF8QTtn/r95f/3kyTZO1hMhYME+TNLtw1
 unWC+yfWldHUyb1q5ju6ui3IHq09/o5OxfMGwWQv2ojQ==
X-Forward-Email-ID: 6acc0e534548822a24c17699
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Lukasz Majewski <lukma@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 37/37] adc: rockchip-saradc: Use 3 MHz clock rate for RK3528
Date: Sun, 11 Oct 2026 22:29:12 +0000
Message-ID: <20261011222930.1085075-38-jonas@kwiboo.se>
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

The RK3528 CLK_SARADC divider field stores the divisor minus one.
Its three bits encode divisors 1-8, allowing rates of 24, 12, 8, 6,
4.8, 4, ~3.43 or 3 MHz from the 24 MHz oscillator.

When the driver requests 1 MHz rate, the required divisor of 24 is
encoded as 23. This value is truncated to 7 in the three-bit field,
selecting a divisor of 8 and producing a 3 MHz clock.

Request 3 MHz explicitly to match the rate already used after value
truncation.

Fixes: 6ef723af18b9 ("adc: rockchip-saradc: Add support for RK3528")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 drivers/adc/rockchip-saradc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/adc/rockchip-saradc.c b/drivers/adc/rockchip-saradc.c
index 1515951403c9..15fd6b66d304 100644
--- a/drivers/adc/rockchip-saradc.c
+++ b/drivers/adc/rockchip-saradc.c
@@ -342,7 +342,7 @@ static const struct rockchip_saradc_data rk3399_saradc_data = {
 static const struct rockchip_saradc_data rk3528_saradc_data = {
 	.num_bits = 10,
 	.num_channels = 4,
-	.clk_rate = 1000000,
+	.clk_rate = 3000000,
 	.channel_data = rockchip_saradc_channel_data_v2,
 	.start_channel = rockchip_saradc_start_channel_v2,
 };
-- 
2.55.0

