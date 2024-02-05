Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F755C48295
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 13:25:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ED5286F8E;
	Mon,  5 Feb 2024 14:25:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="MkSfO34s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B810875E9; Mon,  5 Feb 2024 14:25:14 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85C6086DBD
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 14:25:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4887=JP=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1707139482;
 bh=eMbTiPRCTQK2LhGC9K5HW4Rk6NUjfvFgdm2Y9Qtq4UM=;
 b=MkSfO34sPV0V4WRFDKfORv1G/ZFS590PWKWzueTgViY3F9a9RU1L/gsQT3t3/ihf2wRdjkrP1
 o4WyKoRA+O3CWRwzSiRGE5dVyQUdsceR8wWL+dgqtlx3iK3UikvOkX7T4ou6xulJStFsDn4V8Vi
 J12H3WX/XhuKmoaWYE+YMlM3Jzuzu7vVVfQbG5bDyNmWtpGuvEj6cJsRmeBdKsdaI9EK1GYnDg7
 yC1vZbyyuBoTpv9u0H/Z6GZlV3Hupb5mRTzNd7ltQ1Oq+DVsJJX17YE4AIg+d/JkdY4QvvGgowd
 gDNLZjD5vThC2suB274xZ81nimQg1sRF6l0vpbST55OA==
Message-ID: <b889d4e3-f507-4520-a02e-212f4ce9c7c7@kwiboo.se>
Date: Mon, 5 Feb 2024 14:24:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] rockchip: rk35xx: Remove use of eMMC DDR52 mode
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Kever Yang
 <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, Philipp
 Tomsich <philipp.tomsich@vrull.eu>, Nicolas Frattaroli
 <frattaroli.nicolas@gmail.com>, Tom Rini <trini@konsulko.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Andy Yan <andyshrk@163.com>, Tianling Shen
 <cnsztl@gmail.com>, Akash Gajjar <gajjar04akash@gmail.com>, Eugen Hristev
 <eugen.hristev@collabora.com>, Joshua Riek <jjriek@verizon.net>
Cc: Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
References: <20240204205312.2342868-1-jonas@kwiboo.se>
 <20240204205312.2342868-2-jonas@kwiboo.se>
 <3ec22d95-ee0d-4a0b-8c0e-90067ba0dc32@theobroma-systems.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <3ec22d95-ee0d-4a0b-8c0e-90067ba0dc32@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65c0e199a7f28028f81d0223
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

Hi Quentin,

On 2024-02-05 10:40, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 2/4/24 21:53, Jonas Karlman wrote:
>> Testing has shown that writing to eMMC using DDR52 mode does not seem to
>> work on RK356x and RK3588 boards.
>>
>> A simple test of writing a single block to e.g. sector 0x4000 fails:
>>
>>    # Rescan using DDR52 mode
>>    => mmc rescan 4
>>
>>    # Write a single block to sector 0x4000 fails with ERROR
>>    => mmc write 20000000 4000 1
>>
>> With the MMC_SPEED_MODE_SET Kconfig option enabled.
>>
>> Fix this by removing the mmc-ddr-1_8v prop from sdhci nodes in affected
>> board u-boot.dtsi files.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> Changes in v2:
>> - Update commit message
>>
>> Link to v1: https://patchwork.ozlabs.org/patch/1891695/
>> ---
>>   arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi   | 1 -
>>   arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi   | 1 -
>>   arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi | 1 -
>>   arch/arm/dts/rk3566-soquartz-u-boot.dtsi     | 1 -
>>   arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi   | 1 -
>>   arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi   | 1 -
>>   arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi    | 1 -
>>   arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi    | 1 -
>>   arch/arm/dts/rk3568-rock-3a-u-boot.dtsi      | 1 -
>>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi      | 1 -
>>   arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi   | 1 -
>>   arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi     | 1 -
>>   12 files changed, 12 deletions(-)
>>
>> diff --git a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
>> index 11976fd3a6e0..930d660868bb 100644
>> --- a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
>> @@ -8,7 +8,6 @@
>>   
>>   &sdhci {
>>   	cap-mmc-highspeed;
> 
> Shouldn't we also remove cap-mmc-highspeed?
> 
> I assume this is for MMC_HS? Which we discovered doesn't work reliably?

Writing in lower speeds on RK356x does work better then on RK3588,
however HS200 still seem to be more reliable overall and give more speed.

For RK3588 they could possible be removed, but since reading does work
and similar issue also existed in the fallback MMC legacy mode, I did
not see that cleanup as important, or maybe more correctly it did not
cross my mind to also remove these props :-), the fully broken ddr52
felt more important.

> 
> Since it could be in a different patch if you wanted to, for the changes 
> in this patch:

Agree, a possible cleanup of cap-mmc-highspeed props could be done in a
separate patch.

Alternatively any missing and appropriate modes currently in u-boot.dtsi
should be added to linux DT and they can then be synced back to U-Boot
and any override/addition dropped from u-boot.dtsi files.

Regards,
Jonas

> 
> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> Thanks,
> Quentin

