Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2737CF649D
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 10:11:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E0A388DD1;
	Mon, 30 Sep 2024 12:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Qy/xlQJh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1969788DD1; Mon, 30 Sep 2024 12:11:39 +0200 (CEST)
Received: from mail-m25497.xmail.ntesmail.com (mail-m25497.xmail.ntesmail.com
 [103.129.254.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70C6988DA1
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 12:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Qy/xlQJhZkS4b4ep4MTftgP4G2QoZzVb3xmkv+Vu+am3s8m2AYaAsVQxShFEeC/RmUOc4tcpKWyVCpbo/3Qtp8mcZ2NKYmvciSwleAyLr5pyUYjfdZn82YsSh03OvcrSjGQlJM/CU1mOBW2k8bv8mffDdCLWSsFbB+axoqO+39M=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=piof78mm4JiDdUxoV/sTiNJr590WG0TqzyYNZw+g28k=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id F199C280993;
 Mon, 30 Sep 2024 18:11:22 +0800 (CST)
Message-ID: <5041bde8-fb1e-4c97-9c71-2007008ad3d0@rock-chips.com>
Date: Mon, 30 Sep 2024 18:11:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] rockchip: Skip serial pinctrl at pre-reloc phase
To: Quentin Schulz <quentin.schulz@cherry.de>, Jonas Karlman
 <jonas@kwiboo.se>, Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240805084350.3895788-1-jonas@kwiboo.se>
 <6df6a6df-f8fc-44c3-9688-6f2ccbd8888d@cherry.de>
 <ea4c0f12-bf49-405a-afdb-3312e1eb8c95@kwiboo.se>
 <4bdb19d3-db99-4456-b7db-a96153a3f7dd@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <4bdb19d3-db99-4456-b7db-a96153a3f7dd@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUIZGFZCTUoYGU1CSB9OTklWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a924269ce5209d3kunmf199c280993
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pww6PBw4HDIdTSMuCDdLNUgd
 QxcKC0pVSlVKTElMTUJKS0NIQklJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKS0pOSTcG
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

On 2024/8/12 18:44, Quentin Schulz wrote:
> Hi Jonas,
>
> On 8/5/24 2:22 PM, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 2024-08-05 12:23, Quentin Schulz wrote:
>>> Hi Jonas,
>>>
>>> On 8/5/24 10:43 AM, Jonas Karlman wrote:
>>>> UART pinctrl for serial is typically applied multiple times:
>>>> - in external TPL or in TPL for DEBUG_UART in board_debug_uart_init()
>>>> - in SPL for DEBUG_UART in board_debug_uart_init()
>>>> - in SPL using pinctrl from DT
>>>> - in pre-reloc phase using pinctrl from DT
>>>> - after relocation using pinctrl from DT
>>>>
>>>> This series change bootph props for the UART pinctrl to not include 
>>>> them
>>>> in pre-reloc phase to save some boot time:
>>>>
>>>
>>> NACK. I feel like this is a hack for vendor trees only.
>>
>> I disagree, this just relaxes the bootph props currently enforced by
>> <soc>-u-boot.dtsi files. For boards that has special need they can
>> still add bootph-all or the bootph-some-ram prop to restore prior
>> behavior.

The pinctrl setting for the same module for multi times is obviously not 
a good idea,

and for SPL, it used to work without pinctrl which is simple and fast 
and enough for use.

Because in most case, people use the UART and storage with is the same 
as the bootrom

used, so the IO has been already been initialized.

This change works for most of the boards and for  different design can 
customize for its

usage, them the patch is acceptable, this is different default setting 
instead of hack.


Thanks,

- Kever

>>
>> Also please do not associate me with any vendor, I am a hobbyist :-)
>>
>
> Non-upstream = vendor for me :)
>
>>>
>>> 1) The Device Tree represents the hardware. We need the mux at all 
>>> times.
>>
>> I do not think this changes the the description of the hardware in any
>> way. The bootph props is currently already more of a representation of
>> how software should behave than hardware.
>>
>> In general for Rockchip use of the bootph-some-ram prop (pre-relocation
>> phase) does not fully make any sense, since we already have full SDRAM
>> in SPL.
>>
>> If we where to fully follow the dtschema description for the bootph
>> props, for Rockchip they should probably map to something like:
>>
>> TPL:
>> - bootph-pre-sram: Enable this node when SRAM is not available.
>> - bootph-pre-ram: Enable this node in the phase that sets up SDRAM.
>>
>> SPL:
>> - bootph-some-ram: Enable this node in the phase that is run after SDRAM
>>                     is working but before all of it is available.
>>
>> U-Boot pre-reloc:
>> - no prop mapping, we have all SDRAM and can use all devices, ideally
>>    for Rockchip we should just do bare minimum to relocate without
>>    loading any driver and then move to main post-reloc phase.
>>
>> Instead they map to the different U-Boot software stages:
>> - bootph-pre-sram: TPL
>> - bootph-pre-ram: SPL
>> - bootph-some-ram: U-Boot pre-reloc
>>
>>> 2) This breaks users who want to have no serial in TPL/SPL but in 
>>> proper
>>> (where you want it as soon as possible I assume, thus pre-reloc).
>>
>> Do you know of any such user/board? Adding the bootph-some-ram or
>> bootph-all prop can easily be done in <board>-u-boot.dtsi for such
>> user/board to restore current behavior.
>>
>
> Yes, Lukasz in Cc has a device that is doing that, he'll be fixing a 
> few things related to that soon (tm).
>
> I would suggest to have one commit that basically moves bootph-all to 
> all boards which currently include the -u-boot.dtsi where bootph-all 
> is, and add bootph-pre-sram+pre-ram to -u-boot.dtsi. 0-sum change and 
> then on a per-board basis remove this bootph-all? Basically, I'm not 
> sure this is a sane default to have. For non-upstreamed boards, they 
> can figure this out whenever they contribute. For upstreamed boards, I 
> would aim at not possibly breaking stuff in the name of optimization?
>
> The issue I believe is that you wouldn't be able to tell if there are 
> users today since this should be a Kconfig symbol selection 
> (SPL/TPL_SERIAL for example).
>
> We could start having #ifdefs in -u-boot.dtsi for when 
> $(SPL_TPL_)SERIAL is enabled if we wanted too. Not sure it's a 
> welcomed added complexity though.
>
>>> 3) This likely also means if BL31 is configured to output on a 
>>> different
>>> UART mux of the same controller for some reason (I've seen weird 
>>> stuff),
>>> now U-Boot proper pre-reloc will not output anything as well.
>>
>> Same as for 2), adding the bootph-some-ram or bootph-all can and should
>> be done at board level for boards that have special, or weird,
>> requirements.
>>
>
> It's just super weird to me to enter some corner cases because it 
> works in most cases today and is bringing ~100ms boot time decrease.
>
>> It is also possible to add board specific code that call
>> debug_uart_init() early if you want to ensure pinmux without adding the
>> unnecessary delay that use of pinctrl in pre-reloc brings.
>>
>>>
>>> Adding Lukasz in Cc who's trying to fix U-Boot so that this is possible
>>> on PX30 (therefore, not just a theoretical use case I'm bringing up 
>>> ;) ).
>>>
>>>> - Radxa ROCK Pi S (RK3308): ~80 ms
>>>> - Radxa ZERO 3W (RK3566): ~120 ms
>>>> - Radxa ROCK 5B (RK3588): ~150 ms
>>>>
>>>> Similar change has already been applied for RK3328 and RK3399 boards.
>>>>
>>>
>>> Then I believe this was a mistake.
>>
>> My wording may have been misleading, when we added broad use of 
>> pinctrl props
>> to SPL for rk3328/rk3399 we limited so that the uart pinctrl group 
>> was only
>> enabled for TPL/SPL and not pre-reloc phase, because also including 
>> it at
>> pre-reloc added 200-300 ms in extra boot time.
>>
>> This series tries to apply same findings on remaining Rockchip aarch64
>> boards.
>>
>
> What I'm complaining about in this patch series applies as well to the 
> patches that are already merged if the intent and result are the same.
>
>>>
>>>> The change for PX30 has not been runtime tested, and only include 
>>>> change
>>>> for uart2, not uart0 and uart5 used on two of the supported px30 
>>>> boards.
>>>>
>>>
>>> This means we have uart2 pinctrl at all stages even though we make no
>>> use of it?
>>
>> Yes, in my opinion the px30-u-boot.dtsi include lots of nodes that seem
>> very board specific, some that probably should move to board specific
>> u-boot.dtsi files.
>>
>
> That I would welcome.
>
>>>
>>> I'm starting to wonder if this optimization isn't orthogonal to having
>>> as much support as possible via an <soc>-u-boot.dtsi which was done to
>>> make bring-up and maintenance easier. If you're really after
>>> optimization AND we keep the pinctrl for the debug uart (thus, not
>>> breaking 2) above), then what we want is cleaning up the default
>>> px30-u-boot.dtsi and move bootph properties to the board DTS instead?
>>
>> Agree, for other aarch64 socs I have already tried to cleanup
>> <soc>-u-boot.dtsi to only contain what more than 70-80% of all supported
>> boards may need. For rk3399 bob and kevin even use /delete-property/ to
>> remove some of the common boothp props because all other rk3399 boards
>> benefited from those common boothp props.
>>
>> I have no px30 board and the only rk3326 board I do have does not
>> include the px30-u-boot.dtsi, so I will not try to do any cleanup of
>> that file.
>>
>
> Understood, this falls on someone else's shoulders then :)
>
>>>
>>> I was a bit against this "turn-key" solution wrt u-boot DT for
>>> rk3568/rk3588 but we went ahead, are we changing our mind now? Just to
>>> know what exactly is the direction we are planning to take.
>>
>> Please elaborate, I do not understand what you mean by this.
>>
>
> I looked a bit and could only find:
> https://lore.kernel.org/u-boot/9d7063f9-c1c9-681c-480b-4c88895e6ccf@theobroma-systems.com/ 
>
>
> This doesn't really match what I remembered of an "argument" I believe 
> I had with Kever about putting stuff **I** didn't need for my boards 
> in <soc>-u-boot.dtsi of which the answer was "I prefer to have 
> something that works with minimal work than something that is 
> optimized and require more work for newer boards". But cannot find it 
> anymore, so maybe it was all in my head :)
>
> Cheers,
> Quentin
