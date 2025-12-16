Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22984D609D2
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 17:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C5388392C;
	Tue, 16 Dec 2025 18:57:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="IvuQmTh1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 314A083979; Tue, 16 Dec 2025 18:57:27 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54D218334F
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 18:57:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8106=6X=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1765907843;
 bh=efIU7GE9RwwSSchZxM1k+LC1w8TmeY3HNf0l9UeHQiQ=;
 b=IvuQmTh1Q0tj8mQU8UAOMRgA+R0Z7ZYjB+Pl/S1HTfK+Yb0rR7tx8dOIWp3POLzse3frX/qkT
 /qvl/I3TjgJgDs/WMA5a0jAkDrZpsrj1eHw2krH0Su41dt5e/115tpj2AAZeMojELQcivsmyFco
 1PSPz3+pBytVkj/j7rHTl9D46PPddwDtENPGCUjmG9x0bSHYeNb9UcFgFPVO9X1CkE/lz3GpR2F
 nr369X3Sqo5iGbR8LFjT5spaG0L5j6bJpgepMZwaWohrVJtEflxQUWsjMuhjgzy7lF+twvszKrm
 LEJenZQJE3zTS6FnCpspIKgjPYJc2X6KUSWnoNmmV92g==
X-Forward-Email-ID: 69419d7ffc3bc9a5657d3ea9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.0.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <f5f29e68-aa8f-4534-bc3c-d50b02f0e495@kwiboo.se>
Date: Tue, 16 Dec 2025 18:57:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] rockchip: make rksd the default format for SPI
 images
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, Xuhui Lin <xuhui.lin@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20251216-rockchip-more-template-v2-0-6372e27fc689@cherry.de>
 <20251216-rockchip-more-template-v2-2-6372e27fc689@cherry.de>
 <b729be6e-3091-4aa1-af7b-266a94bbcc66@kwiboo.se>
 <7286807c-3846-4b15-bf20-deaae13d25ce@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <7286807c-3846-4b15-bf20-deaae13d25ce@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 12/16/2025 5:35 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 12/16/25 5:11 PM, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 12/16/2025 12:26 PM, Quentin Schulz wrote:
>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>
>>> I believe (hope) that the new SoCs should now have this fixed and not
>>> require the "hack" implemented in rkspi format which almost doubles the
>>> size of TPL+SPL (idbloader.img).
>>>
>>> It's known to be fixed on RK3566/RK3568, RK3576 and RK3588(S) (according
>>> to the DTS setting the mkimage format for the SPI's idbloader.img to
>>> rksd explicitly).
>>>
>>> Since I do not have any board with a bootable SPI flash except on RK3399
>>> where this work-around is required, I simply invert the logic by having
>>> rkspi explicitly set for all SoCs that didn't and remove rksd from SoCs
>>> that did. It doesn't mean that the SoC actually requires rkspi format,
>>> just that it's been the case until now (maybe because nobody tested).
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>> ---
>>>   arch/arm/dts/px30-u-boot.dtsi     | 12 ++++++++++++
>>>   arch/arm/dts/rk3036-u-boot.dtsi   | 13 +++++++++++++
>>>   arch/arm/dts/rk3066a-u-boot.dtsi  | 12 ++++++++++++
>>>   arch/arm/dts/rk3128-u-boot.dtsi   | 12 ++++++++++++
>>>   arch/arm/dts/rk3188-u-boot.dtsi   | 12 ++++++++++++
>>>   arch/arm/dts/rk322x-u-boot.dtsi   | 12 ++++++++++++
>>>   arch/arm/dts/rk3288-u-boot.dtsi   | 12 ++++++++++++
>>>   arch/arm/dts/rk3308-u-boot.dtsi   | 12 ++++++++++++
>>>   arch/arm/dts/rk3326-u-boot.dtsi   |  1 -
>>>   arch/arm/dts/rk3328-u-boot.dtsi   |  1 -
>>>   arch/arm/dts/rk3368-u-boot.dtsi   | 12 ++++++++++++
>>>   arch/arm/dts/rk3399-u-boot.dtsi   | 12 ++++++++++++
>>>   arch/arm/dts/rk3528-u-boot.dtsi   | 12 ++++++++++++
>>>   arch/arm/dts/rk356x-u-boot.dtsi   |  1 -
>>>   arch/arm/dts/rk3576-u-boot.dtsi   |  1 -
>>>   arch/arm/dts/rk3588s-u-boot.dtsi  |  1 -
>>>   arch/arm/dts/rockchip-u-boot.dtsi |  1 -
>>>   arch/arm/dts/rv1108-u-boot.dtsi   | 12 ++++++++++++
>>>   arch/arm/dts/rv1126-u-boot.dtsi   | 12 ++++++++++++
>>>   19 files changed, 157 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/arm/dts/px30-u-boot.dtsi b/arch/arm/dts/px30-u-boot.dtsi
>>> index 2f726b0aaba..7385de7d6ae 100644
>>> --- a/arch/arm/dts/px30-u-boot.dtsi
>>> +++ b/arch/arm/dts/px30-u-boot.dtsi
>>> @@ -27,6 +27,18 @@
>>>   	};
>>>   };
>>>   
>>> +#ifdef CONFIG_SPL
>>> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
>>> +&binman {
>>> +	simple-bin-spi {
>>> +		mkimage {
>>> +			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
>>> +		};
>>> +	};
>>> +};
>>> +#endif
>>> +#endif
>>
>> This is probably wrong, rk3326 use rksd format.
>>
> 
> Yes, in v1 I said[1] they probably are the same, but I cannot test it so 
> I leave it as it is today. This patch does NOT aim at fixing anything, 
> it is simply inverting the logic such that for any *newly* supported 
> SoC, the default will be rksd format for SPI booting, and not rkspi. For 
> current support, nothing is changed in this commit, if it currently uses 
> rkspi (as is the default if unspecified in SoC DTSI), then it'll 
> explicitly specify rkspi in the SoC DTSI now that rksd will be the 
> default. If it is using the wrong format, it already is and thus can be 
> changed in a separate commit. This is intended to be a zero-sum change!

For boards of most of the SoCs that you flip to add use of rkspi in
<soc>-u-boot.dtsi do not have any defconfig or implied/selected value
for ROCKCHIP_SPI_IMAGE and are also missing necessary
BROM_BOOTSOURCE_SPI* mapping in boot_devices.

To me this zero-sum change is just adding lots of unnecessary/unconfirmed
lines to <soc>-u-boot.dtsi files that is not going to be included anyway,
adding the rkspi to socs that regardless have broken SPI flash boot
support make little sense to me.

I would rather you just flip for the socs that have working or at least
a possibility of working SPI flash boot.

Currently this is following socs, based on U-Boot code, Kconfig and
Linux DTs.

- px30/rk3326
- rk3288
- rk3308
- rk3328
- rk3368
- rk3399
- rk3528
- rk3568
- rk3576
- rk3588
- rv1126

Adding the possible correct use of rkspi/rksd gives a false sense that
SPI flash is expected to work for the other socs.

> 
> [1] 
> https://lore.kernel.org/u-boot/5f45b4ed-d01e-41f8-a05e-c617039228e0@cherry.de/
> 
>> Also seeing how the rk3308 has a later model number than PX30/RK3326
>> I would guess that this also applies to RK3308.
>>
> 
> /me shrugs. Not tested, won't guess, not worth it.

I have been told that this 2k for each 4k page read bug should have been
fixed sometime after rk3399, so far this has been true based on my
observation, especially for socs using sfc/fspi controller.
Unfortunately I have no reference to provide.

> 
> [...]
> 
>>> diff --git a/arch/arm/dts/rk3528-u-boot.dtsi b/arch/arm/dts/rk3528-u-boot.dtsi
>>> index a18d33b3d36..f21d76b0e6e 100644
>>> --- a/arch/arm/dts/rk3528-u-boot.dtsi
>>> +++ b/arch/arm/dts/rk3528-u-boot.dtsi
>>> @@ -30,6 +30,18 @@
>>>   	};
>>>   };
>>>   
>>> +#ifdef CONFIG_SPL
>>> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
>>> +&binman {
>>> +	simple-bin-spi {
>>> +		mkimage {
>>> +			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
>>> +		};
>>> +	};
>>> +};
>>> +#endif
>>> +#endif
>>
>> This is wrong, please drop for rk3528. I have commits pending for adding
>> proper SPI flash boot support on RK3528 once the E24C model lands in
>> upstream linux, see commits at [1].
>>
> 
> Maybe it is wrong, but it is the **current** value. If this series is 
> merged after your (yet-to-be-sent?) series, you'll need to rebase to 
> remove the args line. If it's the other way around, I'll rebase like I 
> did for this one after the RAMBoot series got merged and remove the args 
> line (see what I did for rk3576 between v1 and v2), no biggie :)

What you are adding for rk3528 is wrong, and SPI flash boot is currently
not enabled/working for any in-tree rk3528 board, because of this I
intentionally left out use of rksd in rk3528-u-boot.dtsi until SPI flash
boot could be confirmed working.

Can you please provide a fix commit as part of this series in case you
insist on flipping current state 100% in this commit?

Regards,
Jonas

> 
> Cheers,
> Quentin

