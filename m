Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF23C4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 08:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBB5D87CE6;
	Wed,  7 Feb 2024 09:26:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="AkyW33qh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12C4B87CE6; Wed,  7 Feb 2024 09:26:52 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 675C987CCB
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 09:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4f0f=JQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1707294400;
 bh=uDs2jJuu64PO34QSl1DWCycjWHH8gTPjLhPra4pbstk=;
 b=AkyW33qh97V7UjBOQaLlTrRqI7CWqxHqGKoWmtfqFVP/39nGrE2UKuMwa583DCajsMwvlSolI
 m3JJ6Pylkx+uC4T9R4v/JMmgH2FSDuu5g25Wma3YyAp8OzYnEjyyuNrwN60WuF1lPSosrxYxDZw
 UZwHBXIx1r3xtS2e6nRM0n/WnzZt2G5kMJ/nU/d7f08RiiJNG0uZ+rRLv3eutnhQmGHAJS9rixA
 QLGln/f7p9cgZB3MGjb5e4uVrdO5qpn5R1x2klJ+T2VVAcg75Q9LVz4ka0ZQkHUo/rlbjwwBa7N
 PML63RpeBPx9VJBxeIL0X++kSexjLgosR43XUW/YYgiQ==
Message-ID: <14414289-410e-485d-837e-51bd3c720043@kwiboo.se>
Date: Wed, 7 Feb 2024 09:26:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] rng: rockchip: Use same compatible as linux
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>, Simon
 Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom
 Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20240207000301.3270722-1-jonas@kwiboo.se>
 <20240207000301.3270722-11-jonas@kwiboo.se>
 <9c8e247b-e827-4c0d-953c-4cbab061bb24@gmx.de>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <9c8e247b-e827-4c0d-953c-4cbab061bb24@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65c33ec03d20fd1d3b220aec
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

On 2024-02-07 08:12, Heinrich Schuchardt wrote:
> On 2/7/24 01:02, Jonas Karlman wrote:
>> Replace the rockchip,cryptov1-rng compatible with compatibles used in
>> the linux device tree for RK3288, RK3328 and RK3399 to ease sync of SoC
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

I believe kaslrseed was the main intended use case of this driver in
U-Boot, and the TRNG feature of crypto hw block can serve that purpose.

Regards,
Jonas

> 
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
>> diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
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
>> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
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
>> @@ -302,7 +302,15 @@ static const struct dm_rng_ops rockchip_rng_ops = {
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
> 

