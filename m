Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55B6C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 15:02:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C3A287049;
	Sun, 12 Nov 2023 16:02:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="UtvPwefJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10A82870E1; Sun, 12 Nov 2023 16:01:59 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4819786F68
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 16:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d4dd=G2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1699801310;
 bh=XfsNmGVEVWv/WncOVoMaXd7CE55stGUsDnX9Wxhadck=;
 b=UtvPwefJ+rCDwaEzzCvweV527qvHM5Rk7Eo7otmMyjAnxzdnEf2tO9G/yGo+qLsaQmVCjkrVt
 0ClrhhDNnNqS74QPBsBEp55itQjGhS1v28J0149bkU1MSUbfaRu+NjoKXmbnkflOGWHs5ZgZngC
 RdNa1EnrCwVOM+MR6dJsPDUOzPsQ0t2nQD6ptuI/CkRptVa8JcdICwJN7P9fPGdxxgwmjg3EPZO
 vtsT5AXQQvKrD4BnCx3WY7TePFe8K+iWc5zFCkORPHt/N87YIU09uxf2+4Mv3ERPQ6LFHOEUBK5
 bkS3iRRuGfAryAFvVRXgVCiUvgqt6V7BHRHRxsNnRliA==
Message-ID: <ebcb92c8-f710-490a-a3a3-a97a52118608@kwiboo.se>
Date: Sun, 12 Nov 2023 16:01:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: rockpro64: Enable SPI command and full BOOTSTD
Content-Language: en-US
To: Shantur Rathore <i@shantur.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 u-boot@lists.denx.de
References: <20231111001329.537704-1-i@shantur.com>
 <d1e624f3-d761-4822-bcb4-f81ab4d78663@kwiboo.se>
 <CABEcMwVD_Hs5aMJZaF_Ym785yrLsw6KBxnB_E4KCD=nJASR6YQ@mail.gmail.com>
 <e1fec775-6806-4fe2-af44-f930ebb62932@kwiboo.se>
 <CABEcMwVgnRYd3bSRTY3sUsa=igTsQroEMxCtVjO8ApidigMHHQ@mail.gmail.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CABEcMwVgnRYd3bSRTY3sUsa=igTsQroEMxCtVjO8ApidigMHHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6550e8dd8469ac5b6adf71ef
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

Hi Shantur,

On 2023-11-12 15:21, Shantur Rathore wrote:
> Hey Jonas,
> 
>> For normal generic use the full bootstd commands should not be needed,
>> do you have special scripting requirements that require access to full
>> bootstd commands?
>>
>> All rockchip boards use standard boot, this only enables full commands
>> for one particular board, why is this board special? Or
> 
> This board isn't special.
> 
>> is there merit
>> to imply enable of full commands for all rockchip boards?
> 
> Maybe not only on rockchip boards but all boards.
> 
> Do we need full commands in general ? - Maybe not
> 
> Then why did you need to enable full commands ?
> Bootstd works when the distro used is supporting it. In my case when I
> installed the distro (Armbian), EFI was installed to
> /boot/efi/EFI/debian by default instead of /boot/efi/EFI/boot as
> expected by Bootstd.
> Bootstd couldn't find the EFI and failed to boot. In this scenario
> there is no way to figure out what's going on, what bootmethods /
> bootflows is bootstd able to find or try to manually boot some.
> To be able to support the smallest bit of debugging you end up
> building U-Boot from scratch to enable bootstd full for bootstd info
> commands.
> All other commands in U-boot by default come with options to display
> more information ( for ex. nvme info, nvme detail, usb tree, usb info,
> usb dev, fatinfo and many more ) then why is bootstd restricted?
> Thus, in my opinion we should enable BOOTSTD_FULL for users to be able
> to see more information.
> Restricting might be beneficial for end user devices but atleast
> development devices like RockPro64 should come with BOOTSTD_FULL by
> default.

Thanks for clarifying the need! And I also see the benefit of having
full feature commands enabled.

For RK35xx family of devices I have tried to ensure all boards have same
features and sounds like something like below could benefit all rk
boards, or at least for ROCKCHIP_RK3568 and ROCKCHIP_RK3588 boards.


diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c39ae40335a0..07e93a9c7ad5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1987,6 +1987,7 @@ config ARCH_ROCKCHIP
        imply CMD_DM
        imply DEBUG_UART_BOARD_INIT
        imply BOOTSTD_DEFAULTS
+       imply BOOTSTD_FULL if BOOTSTD_DEFAULTS
        imply FAT_WRITE
        imply SARADC_ROCKCHIP
        imply SPL_SYSRESET


Regards,
Jonas

> 
> Kind regards,
> Shantur
> 
> On Sun, Nov 12, 2023 at 12:50 PM Jonas Karlman <jonas@kwiboo.se> wrote:
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

