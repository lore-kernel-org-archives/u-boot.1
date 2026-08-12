Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3C8C5AD5A
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 10:50:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DDE5811F4;
	Wed, 12 Aug 2026 10:50:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TUrW98XNnaMV; Wed, 12 Aug 2026 10:50:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B92D4811DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786531823;
	bh=IYdMPyb8seix06lLNYez2WCqFAYsBFqaTbyKrXv0eCU=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=U50VfhfFYKByfViR1yjrtRg+6UIPR8uq62BBgJ02sKv2zk6AN9XCnZAY77eamKWDh
	 9mxt95LSaOkUoOoYpEK70z60NXqezu44tEQ9iRYWzy0RqUol6dcryjo6DRyCxJv6XG
	 D2VQWbPFh6AEJAKQZA7/OyhoLy7SIL4bXLh6zl3xt8NJTvMLOS8BzMWtu3QxS2dG95
	 BNass3gMmopuxerLaDeIgC2zhx0quE3eHHfLeQhcelpkZfy1jJSOUYL3joG40hmWds
	 aaW1ILaleDvZfPvPOYALG8ZGVgQkA/8ETI9dUYCRbpUuDHBXnitFkrdApP5rFijRug
	 jWD8ferOGBwPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B92D4811DC;
	Wed, 12 Aug 2026 10:50:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6972E3A4
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 10:50:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 52D5940852
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 10:50:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4zgaK-tOs9Nt for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 10:50:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.13;
 helo=smtp-190d.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6F7F54084B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F7F54084B
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch
 [185.125.25.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F7F54084B
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 10:50:20 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hKlFR428xz10N;
 Wed, 12 Aug 2026 12:33:15 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hKlFQ3nMfzdHH; Wed, 12 Aug 2026 12:33:14 +0200 (CEST)
Message-ID: <ca0eef0e-4e4e-49f9-82bc-d498d54ddd3c@0leil.net>
Date: Wed, 12 Aug 2026 12:33:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] adc: rockchip-saradc: Add driver data for RK3506
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-4-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20260803190946.2259514-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786530795;
 bh=IYdMPyb8seix06lLNYez2WCqFAYsBFqaTbyKrXv0eCU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BG7NRrL+3RFJFX1JDIEQssGZEtifTOvC4SGWr+bykZ249u0/QyHeNRdFgYhdlnlj2
 5vP/aJsnPb1gMo+3G80ZUSavgCdoE8tb4uJajbUbnpT0nj4oEslSCGXkHLN4602uA6
 EGbBbZcpYz8uUFbKQgEFXHXtbgTOVMPN2Js1CoPu8Ek9GPYLSal9dUFqKMRUyhjCZt
 jM/vm/bduqPWOcSI9LDiaIBv+n4Lrfql89ihcSZinix6zBuzdeuJsYhdKUMJk9E1T5
 uVLtlb2rpVoOsXvIQ8zOw3Dc7kkTv0bkKVOfZXvAthmO2sUrONHsMn4csCqR71kSQc
 mEUvpObB3CTnw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=BG7NRrL+
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 8/3/26 9:09 PM, Jonas Karlman wrote:
> Current rockchip,rk3528-saradc fallback instruct the driver to use a

There is no rk3506 DTSI available either in Linux kernel or U-Boot, so 
this fallback technically doesn't even exist and we don't have an issue 
(yet). Just say that none of the the v2 SARADC data match what the 
RK3506 can do (due to the divider and parent clocks not being able to 
achieve the requested 1MHz). Please simply rename the commit title to 
reflect you're adding support for the SARADC found on the RK3506.

> 1 GHz clock rate. However, the CLK_SARADC used on RK3506 can only be
> configured to use a 32 KHz, 400 KHz or 1.5-24 GHz rate.
> 
This is quite misleading. The parent clocks are 32KHz, 400KHz or 24MHz. 
The divider is between 1 and 16.

This means that 1MHz is not achievable with the dividers and we need to 
aim for something else. Please reword the commit log to reflect this. 
I'm also not sure where people got 32KHz, 400KHz and 24MHz but it's 
what's specified in the Linux kernel, so fine with me :)

> Add driver data for rockchip,rk3506-saradc that request use of a 1.5 GHz
> clock rate, to avoid clock divider overflow in the RK3506 clock driver.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/adc/rockchip-saradc.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/adc/rockchip-saradc.c b/drivers/adc/rockchip-saradc.c
> index 1515951403c9..50861b61eea4 100644
> --- a/drivers/adc/rockchip-saradc.c
> +++ b/drivers/adc/rockchip-saradc.c
> @@ -339,6 +339,14 @@ static const struct rockchip_saradc_data rk3399_saradc_data = {
>   	.stop = rockchip_saradc_stop_v1,
>   };
>   
> +static const struct rockchip_saradc_data rk3506_saradc_data = {
> +	.num_bits = 10,

It has 12 bits according to the TRM.

Cheers,
Quentin
