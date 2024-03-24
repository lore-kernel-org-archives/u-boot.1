Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6845C47DD9
	for <u-boot@archiver.kernel.org>; Sun, 24 Mar 2024 21:23:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3613487DDF;
	Sun, 24 Mar 2024 22:23:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Bd9cMAfN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8360587DDF; Sun, 24 Mar 2024 22:23:57 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E79687DC7
 for <u-boot@lists.denx.de>; Sun, 24 Mar 2024 22:23:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5b6e=K7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1711315422;
 bh=i1dl3jhwb4ucfFkH5geSiJVr8bdXXjGPYOgK5TNenzE=;
 b=Bd9cMAfNtkzZMTpI/fNjP13c/wDxWGI3R3P2YRT2+XGXB/+06cuyKI5ttXS16uYjwZAFmIJcx
 wXclG8N+gFWYtfwcHlLwSIYeGDYbSGZX4SunP6xFJIwHEit5BDdt6nKWv7PwH6iEedoyoHxe3W2
 bdXk/DLh7KANA0YUdFakTFgXzF1fDshKf7/i//55Rt9qhIN+llMoEq1khMd8dG4poQxtF1tT8Nv
 GBDjTQ3XirsSeGmvDnPwbeSjVVXPYuVTYYzq0lh6Z1ASsvCqL1T9q5sJ1xYNZXi6/a1l3e6vK3t
 z5gl5XLgtk3JbDKVkBcF1Mnj8jFYaNJdc4MBdA/YPw2g==
Message-ID: <dc60db5b-a030-41e4-8cfe-f909dd89badf@kwiboo.se>
Date: Sun, 24 Mar 2024 22:23:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] rockchip: spl: Add SPI NOR flash to boot_devices
 array
To: Dragan Simic <dsimic@manjaro.org>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Christopher Obbard <chris.obbard@collabora.com>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
References: <20240322205027.3860170-1-jonas@kwiboo.se>
 <20240322205027.3860170-4-jonas@kwiboo.se>
 <69ac8183dcf1cc54f51d21b823c1abfa@manjaro.org>
 <955522b3-344d-4f11-8ea3-d24cbc9f7f7a@kwiboo.se>
 <9ae8cf4a7aefef78dd1f546fb3290825@manjaro.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <9ae8cf4a7aefef78dd1f546fb3290825@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 660099de8d8bf52291f8389a
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

On 2024-03-24 21:58, Dragan Simic wrote:
> On 2024-03-24 18:28, Jonas Karlman wrote:
>> On 2024-03-24 17:52, Dragan Simic wrote:
>>> Please see my comments below.
>>>
>>> On 2024-03-22 21:50, Jonas Karlman wrote:
>>>> Add missing boot source id <-> device tree node path mapping for SPI
>>>> NOR
>>>> flash on PX30, RK3288, RK3308, RK3368 and RV1126.
>>>>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> ---
>>>> v2:
>>>> - New patch
>>>> ---
>>>>  arch/arm/mach-rockchip/px30/px30.c     | 1 +
>>>>  arch/arm/mach-rockchip/rk3288/rk3288.c | 1 +
>>>>  arch/arm/mach-rockchip/rk3308/rk3308.c | 1 +
>>>>  arch/arm/mach-rockchip/rk3368/rk3368.c | 1 +
>>>>  arch/arm/mach-rockchip/rv1126/rv1126.c | 1 +
>>>>  5 files changed, 5 insertions(+)
>>>>
>>>> diff --git a/arch/arm/mach-rockchip/px30/px30.c
>>>> b/arch/arm/mach-rockchip/px30/px30.c
>>>> index b4f655fa4b3e..2ec3289d75b7 100644
>>>> --- a/arch/arm/mach-rockchip/px30/px30.c
>>>> +++ b/arch/arm/mach-rockchip/px30/px30.c
>>>> @@ -19,6 +19,7 @@
>>>>
>>>>  const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>>>>  	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff390000",
>>>> +	[BROM_BOOTSOURCE_SPINOR] = "/spi@ff3a0000/flash@0",
>>>
>>> AFAICT, no PX30-based board contains an SPI chip, but making this
>>> future-proof perhaps shouldn't hurt.
>>
>> The rk3326-odroid-go2 variant of PX30 has a jedec,spi-nor node.
> 
> Ah, I see, I missed that.  Thanks for the clarification.
> 
>>>>  	[BROM_BOOTSOURCE_SD] = "/mmc@ff370000",
>>>>  };
>>>>
>>>> diff --git a/arch/arm/mach-rockchip/rk3288/rk3288.c
>>>> b/arch/arm/mach-rockchip/rk3288/rk3288.c
>>>> index c77c56c1dab5..70cf50029121 100644
>>>> --- a/arch/arm/mach-rockchip/rk3288/rk3288.c
>>>> +++ b/arch/arm/mach-rockchip/rk3288/rk3288.c
>>>> @@ -28,6 +28,7 @@ DECLARE_GLOBAL_DATA_PTR;
>>>>
>>>>  const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>>>>  	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff0f0000",
>>>> +	[BROM_BOOTSOURCE_SPINOR] = "/spi@ff130000/flash@0",
>>>
>>> Using spi2 for a flash chip applies to some RK3288-based boards, but
>>> AFAICT not to all of them.  For example, arch/arm/dts/rk3288-evb.dtsi
>>> uses spi0 for a flash chip, which in turn translates to
>>> /spi@ff110000/flash@0.  The same also applies to
>>> arch/arm/dts/rk3288-firefly.dtsi, for example.
>>
>> The RK3288 TRM explicitly mention that it can boot from SPI2 CS0.
>>
>> Also I can only find jedec,spi-nor reference in rk3288-phycore-som.dtsi
>> and rk3288-veyron.dtsi, nothing in rk3288-evb.dtsi or 
>> rk3288-firefly.dtsi.
> 
> Oh, I see now, you're right.  I've checked the Firefly-RK3288 schematic
> and it just exposes the spi0 interface on one of its expansion headers.
> 
>>>>  	[BROM_BOOTSOURCE_SD] = "/mmc@ff0c0000",
>>>>  };
>>>>
>>>> diff --git a/arch/arm/mach-rockchip/rk3308/rk3308.c
>>>> b/arch/arm/mach-rockchip/rk3308/rk3308.c
>>>> index 27a748327e31..b3ffabc5449a 100644
>>>> --- a/arch/arm/mach-rockchip/rk3308/rk3308.c
>>>> +++ b/arch/arm/mach-rockchip/rk3308/rk3308.c
>>>> @@ -141,6 +141,7 @@ enum {
>>>>
>>>>  const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>>>>  	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff490000",
>>>> +	[BROM_BOOTSOURCE_SPINOR] = "/spi@ff4c0000/flash@0",
>>>
>>> AFAICT, no RK3308-based board contains an SPI chip, and I'm not really
>>> sure where does /spi@ff4c0000/flash@0 come from.
>>
>> RK3308 TRM mention that it can boot from the SFC. And yes there is no
>> upstream board that currently have a jedec,spi-nor node, it however
>> have the sfc (spi@ff4c0000) node so this adds correct node path.
> 
> Hmm, I see no sfc node in any of the arch/arm/dts/rk3308* files?
> Maybe I'm missing something, but there's also no "ff4c0000" string
> in the entire arch/arm/dts directory.

The rk3308 DTs in U-Boot is very outdated so the sfc node cannot be
found in current master branch.

The sfc node is part of linux upstream DT, should also match in
dts/upstream in next branch and after the rk3308 DT sync series [1].

rockchip: rk3308: Sync DT with linux v6.8 and update defconfigs:
[1] https://patchwork.ozlabs.org/cover/1912830/

Regards,
Jonas

