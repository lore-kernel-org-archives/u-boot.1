Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA2BC27C53
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 11:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F255388361;
	Wed,  5 Jun 2024 13:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="M/WfDevn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37A6188361; Wed,  5 Jun 2024 13:03:26 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 227F28833C
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 13:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d3b1=NH=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1717585387;
 bh=KHb0u/5v7yuEt75nB98MEzmLKrNfWFHkadUGLrqhg28=;
 b=M/WfDevnw7nSUXqLLWFL6dkrfipN3IU53UKSRExAjoGR57OHBXyXXuyJ0f6/FgCZuXlYSSNFV
 zc6LeXmho4XeGHv5upu/9MZ7HMJ5khpOON9HSODwlRY5e1fzkWA2jglt2cEymJp4WGCVB1EVjBI
 3r2xopqX/BBjhF9e1+FvD2IUP37pu1oLV+SgEwwm1MKcTwhvwNkstANsQ9byHevBLU/2FnZGaA3
 zGc/Qo8QWihk1+x8MSdYvK4GgFn7eAWi9neepk1Fxp3KYKbTiqjs2Ll1u+kq37PIE2d/FtO0xaF
 WYrQiygEqSR+/BLSlHZ36NSF+youGpwhS/suviz2BYeg==
Message-ID: <f88179b1-816c-473c-9e7c-2e83d7341c15@kwiboo.se>
Date: Wed, 5 Jun 2024 13:03:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] power: regulator: Handle autoset in
 regulators_enable_boot_on()
To: Simon Glass <sjg@chromium.org>
Cc: "U-Boot Mailing List" <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Eugen Hristev <eugen.hristev@collabora.com>, Jaehoon
 Chung <jh80.chung@samsung.com>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <l.majewski@samsung.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-5-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240605032521.1142768-5-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 666045e9c6f01aa23fe0401c
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Simon,

On 2024-06-05 05:25, Simon Glass wrote:
> With a recent change, regulators_enable_boot_on() returns an error if a
> regulator is already set. Check for and handle this situation.

I am guessing this is being hit because of the call in veyron_init() ?

regulators_enable_boot_on() is also called for rockchip boards in the
rockchip common boards.c board_init().

Maybe the call to regulators_enable_boot_on() in veyron_init() could
be dropped?

> 
> Fixes: d99fb64a98a power: regulator: Only run autoset once for each regulator
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

> ---
> 
>  drivers/power/regulator/regulator-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
> index 77d101f262e..d9e1fb68295 100644
> --- a/drivers/power/regulator/regulator-uclass.c
> +++ b/drivers/power/regulator/regulator-uclass.c
> @@ -518,7 +518,7 @@ int regulators_enable_boot_on(bool verbose)
>  	     dev;
>  	     uclass_next_device(&dev)) {
>  		ret = regulator_autoset(dev);
> -		if (ret == -EMEDIUMTYPE) {
> +		if (ret == -EMEDIUMTYPE || ret == -EALREADY) {
>  			ret = 0;
>  			continue;
>  		}

