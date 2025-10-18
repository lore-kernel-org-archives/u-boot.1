Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF6ACCD195
	for <u-boot@archiver.kernel.org>; Sat, 18 Oct 2025 13:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CA5F83893;
	Sat, 18 Oct 2025 15:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="mU0BGn0V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3066D83796; Sat, 18 Oct 2025 10:47:43 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAA41836D1
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 10:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id A312C22DCC;
 Sat, 18 Oct 2025 10:47:40 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O7McwrjfPzrp; Sat, 18 Oct 2025 10:47:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760777259; bh=p1Tl/3SnDBRgLhdvuQxMErJt+Dq5t5HuvE5fNrn0TPQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=mU0BGn0Vl77tEos+FLh+ZYs6OaAFlONFQrXLWMNpBYFz3bIxSLq/KVFmiQavJLVg4
 y2us04ptslfwUrbnf4s013UTNL8g/KiX5C/kY9dObzU7TXyZ65/Mx6HVarpMX+6FsU
 w6e3hH4JLtJDKffCBzmfXG6+lI8/cpjDp1LK3l5rUhLGJSlwW4jSYzMGrH21kG69gU
 5ByUxeMccRFwFbMqu6p8MUPK1ZzPeiog4iIyeHfhywTo/NW+deO+5zcgHNgPil9Z9+
 yXXmesxyRBPM3ew8leMGvDgydJ6qWFZeewJ9u01JoybUxlWGMVg6pqnyK1N2F4+6TU
 obUxfC9/pWWuQ==
MIME-Version: 1.0
Date: Sat, 18 Oct 2025 08:47:39 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: Tom Rini <trini@konsulko.com>
Cc: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] armv8: implement workaround for broken CNTFRQ_EL0 value
In-Reply-To: <20251017204040.GI6688@bill-the-cat>
References: <20251017-armv8-broken-cntfrq-v2-1-1e043cbb657e@disroot.org>
 <20251017204040.GI6688@bill-the-cat>
Message-ID: <6f255efa155cb13b67510a39b4f321f0@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 18 Oct 2025 15:53:45 +0200
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

On 2025-10-17 20:40, Tom Rini wrote:
> On Fri, Oct 17, 2025 at 08:49:47PM +0530, Kaustabh Chakraborty wrote:
> 
>> In devices where the U-Boot is used as a secondary bootloader, we rely
>> on the device's primary bootloader to implement CNTFRQ_EL0. However,
>> this reliance may lead to a non-functional timer in broken firmware.
>> 
>> For instance, some versions of Samsung's S-Boot don't implement it. 
>> It's
>> also not possible to set it in the U-Boot, because it's booted in a 
>> lower
>> exception level. CNTFRQ_EL0 is reported to be 0.
>> 
>> Use gd->arch.timer_rate_hz to override the queried value if set. This
>> setting needs to be done in the board file, preferrably in 
>> timer_init().
>> 
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> ---
>> Changes in v2:
>> - Switched to using gd->arch.timer_rate_hz instead of a new config
>>   option (Ahmad Fatoum)
>> - Link to v1: 
>> https://lore.kernel.org/r/20251014-armv8-broken-cntfrq-v1-1-b63f9c69ffcb@disroot.org
>> ---
>>  arch/arm/cpu/armv8/generic_timer.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/arch/arm/cpu/armv8/generic_timer.c 
>> b/arch/arm/cpu/armv8/generic_timer.c
>> index 
>> 1de7ec596fc7cbbc3e78a241f163bc0a4fcad6b6..1bc72ed26ca31af8e8e72008ed7885cbde23b076 
>> 100644
>> --- a/arch/arm/cpu/armv8/generic_timer.c
>> +++ b/arch/arm/cpu/armv8/generic_timer.c
>> @@ -19,6 +19,10 @@ DECLARE_GLOBAL_DATA_PTR;
>>  unsigned long notrace get_tbclk(void)
>>  {
>>  	unsigned long cntfrq;
>> +
>> +	if (gd->arch.timer_rate_hz)
>> +		return gd->arch.timer_rate_hz;
>> +
>>  	asm volatile("mrs %0, cntfrq_el0" : "=r" (cntfrq));
>>  	return cntfrq;
>>  }
> 
> This would impact coreprimevelte (as it's the only ARM64 platform to 
> set
> gd->arch.timer_rate_hz) but as it's also a Samsung platform it's likely
> in the same broken situation your platforms are.

I guess coreprimevelte is a a bit too old to have that issue. Either 
way,
it would be fine as the frequency is set to 26MHz [1], which is the 
timer
frequency of that device [2].

[1] 
https://elixir.bootlin.com/u-boot/v2025.10/source/arch/arm/mach-mmp/board.c#L31
[2] 
https://github.com/LegoLivesMatter/android_kernel_samsung_coreprimevelte/blob/android-5.1/arch/arm64/boot/dts/pxa1908.dtsi#L91

> 
> --
> Tom
