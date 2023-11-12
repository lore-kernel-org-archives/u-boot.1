Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28B2C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 14:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9A4B87129;
	Sun, 12 Nov 2023 15:53:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="U1TXj37N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E88578716C; Sun, 12 Nov 2023 15:53:12 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80C9C86F68
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 15:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d4dd=G2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1699800781;
 bh=kf7cwuEhW1j30XFYNLnUC2h9JO5tc6kbffEl0zTKi9Q=;
 b=U1TXj37Np+gwMGptnCQFv1dgpZNj5ASYLJO7inaEuKhmhuuQfRiom4IQc1xokgeKWuLfWIqJF
 CHHIsk9GX9WvwPLgvdutCLHTv6qwdIYtMhhlevxNtmLRbHVDZJCe0tWxL4fDqo+sKVj1CvhixDk
 xuaWDKUWn6FjUqQIq6OiZ+9QuLk1mys506c46TfGuAE3sRJVGRsM9T/4zyFJhdVtvK4rkZ9dTmy
 UXla4tjmEWqbueSOnsc3C/XzO1pJV3WwpMIN7bBT5p07epOacpv0xaRqgjy5XqEPnDsHRFD0K21
 k/7sNouId1VFtSbHx60hMsZXT4OtquJoWFJTfYC/Katw==
Message-ID: <8f25cd25-e090-46b4-8088-0103cf79862b@kwiboo.se>
Date: Sun, 12 Nov 2023 15:52:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: rockpro64: Enable SPI command and full BOOTSTD
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Shantur Rathore <i@shantur.com>, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, u-boot@lists.denx.de
References: <20231111001329.537704-1-i@shantur.com>
 <d1e624f3-d761-4822-bcb4-f81ab4d78663@kwiboo.se>
 <CABEcMwVD_Hs5aMJZaF_Ym785yrLsw6KBxnB_E4KCD=nJASR6YQ@mail.gmail.com>
 <e1fec775-6806-4fe2-af44-f930ebb62932@kwiboo.se>
 <CAPnjgZ18x+j11doAJtEg93ueL+ayC2HqtRm+BeG9XSNkWx-9Hw@mail.gmail.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAPnjgZ18x+j11doAJtEg93ueL+ayC2HqtRm+BeG9XSNkWx-9Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6550e6ccea828730b5a5f6e2
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

On 2023-11-12 15:22, Simon Glass wrote:
> Hi Jonas,
> 
> On Sun, 12 Nov 2023 at 05:50, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi Shantur,
>>
>> On 2023-11-12 13:34, Shantur Rathore wrote:
>>> Hi Jonas,
>>>
>>>> The CMD_SPI is not used to interact with the SPI flash.
>>>>
>>>> CMD_SF is already enabled and you can use "sf probe" and any other sf
>>>> related action to interact with the SPI flash on this board.
>>>>
>>>
>>> You are right, this is not needed, thanks for correcting me.
>>> I will update my patch.
>>>
>>>> What is the reasoning behind enabling full bootstd commands? Especially
>>>> why just this board need it enabled by default.
>>>>
>>>> Standard boot is already fully functional, it just does not have full
>>>> features commands enabled by default.
>>>
>>> By default standard boot only allows you to boot from the first
>>> available boot device.
>>> This board supports SDCard, NVME (via PCIe port), USB and network boot
>>> and with BOOTSTD_FULL we can choose what to exactly boot.
>>> The boot_targets environment variable only allows you to choose which
>>> device to boot, not which boot method / flow to use.
>>> We have ample space in SPI Flash, so why not let it have the full
>>> potential of U-Boot by default.
>>
>> You can control boot targets using the boot_targets env var and boot
>> methods using the bootmeths env var.
>>
>> https://docs.u-boot.org/en/latest/develop/bootstd.html#controlling-ordering
>>
>> For normal generic use the full bootstd commands should not be needed,
>> do you have special scripting requirements that require access to full
>> bootstd commands?
>>
>> All rockchip boards use standard boot, this only enables full commands
>> for one particular board, why is this board special? Or is there merit
>> to imply enable of full commands for all rockchip boards?
> 
> I suppose we do this in a lot of cases, where we enable commands and
> other features on various boards. So I don't have any objection to
> this. Certainly it is a pain to use bootstd for development and
> debugging of booting if you cannot use the full command set.

I have no particular objection either, I just want to understand the
need, and if this is something we should apply to more boards.

For RK35xx family of devices I have tried to ensure all boards have
similar commands and features enabled, at least for the features the
board support. So my thought now is if we should imply this Kconfig
option for ROCKCHIP_RK3568 and ROCKCHIP_RK3588.

Use of different features is also rather annoying for a distro that
wants to support a broad range of devices of a soc family, and U-Boot
for boards of the same soc family behave differently.

Regards,
Jonas

> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Regards,
> Simon
> 
>>
>> Regards,
>> Jonas
>>
>>>
>>> Kind regards,
>>> Shantur
>>>
>>> On Sun, Nov 12, 2023 at 10:39 AM Jonas Karlman <jonas@kwiboo.se> wrote:
>>>>
>>>> On 2023-11-11 01:13, Shantur Rathore wrote:
>>>>> RockPro64 has a 16MB onboard SPI chip and current u-boot takes
>>>>> around 2MB, we can enable more features.
>>>>> Updating config to enable SPI commands and full BootSTD support.
>>>>> ---
>>>>>  configs/rockpro64-rk3399_defconfig | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
>>>>> index 4cd6b76665..cad0b8a5d7 100644
>>>>> --- a/configs/rockpro64-rk3399_defconfig
>>>>> +++ b/configs/rockpro64-rk3399_defconfig
>>>>> @@ -46,10 +46,12 @@ CONFIG_CMD_BOOTZ=y
>>>>>  CONFIG_CMD_GPT=y
>>>>>  CONFIG_CMD_MMC=y
>>>>>  CONFIG_CMD_PCI=y
>>>>> +CONFIG_CMD_SPI=y
>>>>
>>>> The CMD_SPI is not used to interact with the SPI flash.
>>>>
>>>> CMD_SF is already enabled and you can use "sf probe" and any other sf
>>>> related action to interact with the SPI flash on this board.
>>>>
>>>>>  CONFIG_CMD_USB=y
>>>>>  # CONFIG_CMD_SETEXPR is not set
>>>>>  CONFIG_CMD_TIME=y
>>>>>  CONFIG_CMD_BOOTSTAGE=y
>>>>> +CONFIG_BOOTSTD_FULL=y
>>>>
>>>> What is the reasoning behind enabling full bootstd commands? Especially
>>>> why just this board need it enabled by default.
>>>>
>>>> Standard boot is already fully functional, it just does not have full
>>>> features commands enabled by default.
>>>>
>>>> Regards,
>>>> Jonas
>>>>
>>>>>  CONFIG_SPL_OF_CONTROL=y
>>>>>  CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>>>>>  CONFIG_ENV_IS_IN_SPI_FLASH=y
>>>>
>>

