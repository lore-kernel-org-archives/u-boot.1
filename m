Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62222C4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 07:26:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C31F187CBF;
	Wed,  7 Feb 2024 08:26:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="Pk1FGwhC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E3E387CCB; Wed,  7 Feb 2024 08:26:50 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B6F587C8D
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 08:26:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707290807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/GlN4Y1V7HyFz+02Qb4V+fTqCbnfm5Y3nnWSUrMqhKU=;
 b=Pk1FGwhCi7JmkJ/IGLnURXTgIIX1scIBviifFYbWKWGFRRkUaL7yuppPyFpjgsxhpCcZP9
 WCQUYYLs9u7it6gf84Z5dp1hklEHTjPLIexNadHL5JuZnOLvdncwMmr2BeFQ0vnEZk8mnP
 t1rHYrVN4dvL5WC+RKnPIfTVbihDW4aaXZfwBSWkKacphVERZ96c3ZaKVDfne/468kYw23
 JMaw9awQmCKxbzvKxgaXtqeEwJh0VO++AKu9Roj65aHn5Ew9JmZsvZ2XsU/6KEhNepFAK/
 rVipOuBt14UC7hzuW71bfOIQdsDoVBvgsfDSuL6bBUQRgSDxoNAhtDMP/bm6aA==
Date: Wed, 07 Feb 2024 08:26:45 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de, Kever Yang
 <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 10/15] rng: rockchip: Use same compatible as linux
In-Reply-To: <9c8e247b-e827-4c0d-953c-4cbab061bb24@gmx.de>
References: <20240207000301.3270722-1-jonas@kwiboo.se>
 <20240207000301.3270722-11-jonas@kwiboo.se>
 <9c8e247b-e827-4c0d-953c-4cbab061bb24@gmx.de>
Message-ID: <3aee86337f0621c628b2c174c03087fb@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Heinrich,

On 2024-02-07 08:12, Heinrich Schuchardt wrote:
> On 2/7/24 01:02, Jonas Karlman wrote:
>> Replace the rockchip,cryptov1-rng compatible with compatibles used in
>> the linux device tree for RK3288, RK3328 and RK3399 to ease sync of 
>> SoC
>> device tree from linux.
>> 
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> 
> It is strange that U-Boot only uses the random number generation while
> Linux only seems to use the crypto algorithm acceleration.
> 
> U-Boot has some crypto accelerator drivers in drivers/crypto/. But here
> we only make use of modular exponentiation (see struct mod_exp_ops). We
> could improve on crypto acceleration.

Pleas, let's keep in mind that using crypto accelerators doesn't
always result in improved performance;  it all depends on the
workload and on the particular SoC.  For example, performing
crypto operations on small chunks of data may be much faster when
performed on a CPU core.  Another example is that some crypto IP
cores don't use the available CPU caches at all, which inevitably
slows them down.

Though, crypto IP cores are quite often more power-efficient vs.
performing the same crypto operations on a CPU core, which seems
to be the main reason why they get included in a number of SoCs.
Of course, this power efficiency becomes noticeable only when
offloading crypto operations performed on large chunks of data,
or when offloading for sizable amounts of time.

> The current change looks good to me.
> 
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> 
>> ---
>>   arch/arm/dts/rk3328-u-boot.dtsi |  2 +-
>>   arch/arm/dts/rk3399-u-boot.dtsi |  2 +-
>>   drivers/rng/rockchip_rng.c      | 10 +++++++++-
>>   3 files changed, 11 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/arm/dts/rk3328-u-boot.dtsi 
>> b/arch/arm/dts/rk3328-u-boot.dtsi
>> index e087b02893c1..d805c2f394f8 100644
>> --- a/arch/arm/dts/rk3328-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3328-u-boot.dtsi
>> @@ -28,7 +28,7 @@
>>   	};
>> 
>>   	rng: rng@ff060000 {
>> -		compatible = "rockchip,cryptov1-rng";
>> +		compatible = "rockchip,rk3328-crypto";
>>   		reg = <0x0 0xff060000 0x0 0x4000>;
>>   		status = "okay";
>>   	};
>> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi 
>> b/arch/arm/dts/rk3399-u-boot.dtsi
>> index 3423b882c437..87b173e59579 100644
>> --- a/arch/arm/dts/rk3399-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
>> @@ -30,7 +30,7 @@
>>   	};
>> 
>>   	rng: rng@ff8b8000 {
>> -		compatible = "rockchip,cryptov1-rng";
>> +		compatible = "rockchip,rk3399-crypto";
>>   		reg = <0x0 0xff8b8000 0x0 0x1000>;
>>   		status = "okay";
>>   	};
>> diff --git a/drivers/rng/rockchip_rng.c b/drivers/rng/rockchip_rng.c
>> index 705b424cf3dd..e82b5572fec5 100644
>> --- a/drivers/rng/rockchip_rng.c
>> +++ b/drivers/rng/rockchip_rng.c
>> @@ -302,7 +302,15 @@ static const struct dm_rng_ops rockchip_rng_ops = 
>> {
>> 
>>   static const struct udevice_id rockchip_rng_match[] = {
>>   	{
>> -		.compatible = "rockchip,cryptov1-rng",
>> +		.compatible = "rockchip,rk3288-crypto",
>> +		.data = (ulong)&rk_cryptov1_soc_data,
>> +	},
>> +	{
>> +		.compatible = "rockchip,rk3328-crypto",
>> +		.data = (ulong)&rk_cryptov1_soc_data,
>> +	},
>> +	{
>> +		.compatible = "rockchip,rk3399-crypto",
>>   		.data = (ulong)&rk_cryptov1_soc_data,
>>   	},
>>   	{
