Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACA2E7716A
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 11:40:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C67168008A;
	Sat, 14 Dec 2024 12:40:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LaWSxxI1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E86680092; Sat, 14 Dec 2024 12:40:26 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB8BD8004E
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 12:40:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=leon.anavi@konsulko.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5d3e9a88793so4176201a12.1
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 03:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734176423; x=1734781223; darn=lists.denx.de;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jtbHit0CgsxtSzs8oD50vzGvtmR5d7VtQ2iIgUuXHPg=;
 b=LaWSxxI1BOpohYq5dw0LcxiLaSAvBrgPc+kdXJgsTlV3tl3qY952qSKXJ3FYbFS7h2
 +JcbCmZjnaCzNvyQyD2tvS5y97qrvSWcWZdxEeti+lq7GC8hvd3i36QyFZsbH/muc+Md
 P2ZEfCHDO09Bn/LAD8HHefpn//+RwV0fN+XCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734176423; x=1734781223;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jtbHit0CgsxtSzs8oD50vzGvtmR5d7VtQ2iIgUuXHPg=;
 b=pfuGDZ+bNoD35nBpPO1PWx3iB9GfAgzSgmzM6rsqXRAkezsD+XteL3F+ZuWh2cy+oh
 eKDGK1ywtEmpTQNiO+p5ZyzHgtrvNOocUXCc0PRAj8SXdz2LHqRp/Zf2p5G5q/lO1sg2
 6BlkpIgImsOcyN5IN5ipxgXmbDPXz3g+0YbW6cK2y8Fflk23EGq80EzLYKr907BorK19
 yxt1etaXJ6c2Cwsdn8U0qGPwmX7URP0O+ZuE85WflQ130sa8oB9+WCNUdNAXw6zrXgC/
 Vs5incTJzo497kc4x57aZhMVQCrPrhN9CJS8YlDmqw6JsaYRMBpNM5D65aQ667A7ZT7Q
 msdA==
X-Gm-Message-State: AOJu0YwmNjB80SO9xMuR3jpukHIzF0tgffbhdphGz8vwDGDXYVwQCz+H
 rpuPhoDqvZaadt7mqMCme9BW6fn2Fq8neZRHhe4gYiiCw8Sy9lbLZI6QkV4DPVs=
X-Gm-Gg: ASbGncvSzdY2hDTSbKXOSVAgx8tZOEWHRsffJBDxssSppjOmGQK4YP29pHMtUaRc51o
 LCTQkNxUzDY53LwNP9AX4ExzUS2/U811FHMO38G3LM70QZe0pECH++LOa1QZW4bJOehZex6LrgE
 Cul2BtwtuLKVXcgNpBpWUTXMgRGL8KORiZOn9kmln6i+CqPrLvqak4NrqKPYiXaZOS43yg68Mnb
 WrU4k3/X2efrim7bMMneNrQfLAt/OJV4LQb4/HS9FDCyO1o1IQzNmapo13zP5Ti
X-Google-Smtp-Source: AGHT+IFKmIppGsLUF4MjefRO/GT4mhZShGA1bWq2/bFbuS3iXO3KX0kW0JVcdhYI8q2y+bBJTq535Q==
X-Received: by 2002:a05:6402:518a:b0:5d0:e50b:899e with SMTP id
 4fb4d7f45d1cf-5d63c2eb98emr4888300a12.4.1734176423024; 
 Sat, 14 Dec 2024 03:40:23 -0800 (PST)
Received: from [192.168.5.161] ([46.55.231.62])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d652ab50desm924287a12.3.2024.12.14.03.40.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2024 03:40:22 -0800 (PST)
Message-ID: <18f9039d-4bac-4e16-9f0c-e34cff8b0774@konsulko.com>
Date: Sat, 14 Dec 2024 13:40:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] sunxi: board: simplify early PMIC setup conditions
To: Andre Przywara <andre.przywara@arm.com>,
 linux-sunxi <linux-sunxi@lists.linux.dev>
Cc: u-boot@lists.denx.de, lhristov@gmail.com
References: <CALtQ3O2jF6sEvofpZ+FtJgmgTKZvNRuohnwEtPz4ES0WqtxU5g@mail.gmail.com>
 <20241211215327.26dc369a@minigeek.lan>
 <e77f6b37-7d50-4f3d-9bed-6d3e39effb4c@konsulko.com>
 <20241214021950.5013865a@minigeek.lan>
Content-Language: en-US
From: Leon Anavi <leon.anavi@konsulko.com>
In-Reply-To: <20241214021950.5013865a@minigeek.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Andre,

On 14.12.24 г. 4:19 ч., Andre Przywara wrote:
> On Thu, 12 Dec 2024 11:19:06 +0200
> Leon Anavi<leon.anavi@konsulko.com> wrote:
>
> Hi Leon,
>
>> On 11.12.24 г. 23:53 ч., Andre Przywara wrote:
>>> On Mon, 9 Dec 2024 23:08:19 +0200
>>> Leon Anavi<leon.anavi@konsulko.com> wrote:
>>>
>>> Hi Leon,
>>>
>>> thanks for the report!
>>>   
>>>> Commit ffb0294 from 12 November 2023 that simplifies early PMIC setup
>>>> conditions causes issues on Cubieboard 4 and Merrii A80 Optimus with
>>>> Allwinner A80 SoC (sun9i). The commit was introduced with U-Boot 2024.01
>>>> (rc3) and remains as of today. Because of it both of these boards hang at:
>>>>
>>>> Starting kernel ...
>>> That's odd, how do you boot the kernel, exactly?
>>> I just tried mainline U-Boot (via FEL), with:
>>> => setenv bootargs "console=ttyS0,115200n8 earlycon"
>>> => bootz $kernel_addr_r $ramdisk_addr_r:300000 $fdtcontroladdr
>>>
>>> and it booted fine to the prompt, on a Cubieboard 4 (CC-A80 v1.2).
>>> Kernel was some 6.11-rc6 I just had lying around.
>>>
>>> I also compared the code before and after that patch, the only
>>> difference is the order at which DCDC5 gets programmed: before it's
>>> after DCDC4, with the patch it's right after DCDC1.
>>> The rest looked the same.
>>> Booting ffb0294~1 and ffb0294~0 also worked for me, without issues.
>>> So can you please describe how you test that, exactly?
>> I built core-image-base using the Yocto Project and OpenEmbedded as well Starting kernel ...
>> as the meta-sunxi BSP layer. The U-Boot version depends on the Yocto
>> release. For Scarthgap it is with U-Boot 2024.01 and for the ongoing
>> development in the master branches the U-Boot version is 2024.10. The
>> Linux kernel version is 6.6.28. I experienced the same issue with both
>> U-Boot versions on Merrii A80 Optimus and Lazar (his email is CC)
>> confirmed the same results on Cubieboard 4. The boot sequence for the
>> boards in meta-sunxi is through boot.scr generated from the following
>> boot.cmd:
>> https://github.com/linux-sunxi/meta-sunxi/blob/master/recipes-bsp/u-boot/files/arm/boot.cmd
>>
>> In a nutshell, the issue can be reproduced with the following scenario
>> in U-Boot:
>>
>> setenv bootargs console=ttyS0,115200 console=tty1 root=/dev/mmcblk0p2
>> rootwait panic=10
> So I tried with an SD card now, and I think I see what you mean now.
> I was a bit confused first why it would hang for you after "Starting
> kernel ...", but I guess it actually doesn't: can you add "earlycon" to your
> command line and confirm that the kernel boots, but hangs while waiting
> for the secondary cores?
> I am still scratching my head how this commit would affect this
> behaviour, but this change here seems to fix it for me:
>
> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> index 29a329f41a2..d7c46eec615 100644
> --- a/board/sunxi/board.c
> +++ b/board/sunxi/board.c
> @@ -582,7 +582,6 @@ void sunxi_board_init(void)
>   
>   #ifdef CONFIG_AXP_DCDC1_VOLT
>   	power_failed |= axp_set_dcdc1(CONFIG_AXP_DCDC1_VOLT);
> -	power_failed |= axp_set_dcdc5(CONFIG_AXP_DCDC5_VOLT);
>   #endif
>   #ifdef CONFIG_AXP_DCDC2_VOLT
>   	power_failed |= axp_set_dcdc2(CONFIG_AXP_DCDC2_VOLT);
> @@ -591,6 +590,9 @@ void sunxi_board_init(void)
>   #ifdef CONFIG_AXP_DCDC4_VOLT
>   	power_failed |= axp_set_dcdc4(CONFIG_AXP_DCDC4_VOLT);
>   #endif
> +#ifdef CONFIG_AXP_DCDC5_VOLT
> +	power_failed |= axp_set_dcdc5(CONFIG_AXP_DCDC5_VOLT);
> +#endif
>   
>   #ifdef CONFIG_AXP_ALDO1_VOLT
>   	power_failed |= axp_set_aldo1(CONFIG_AXP_ALDO1_VOLT);
>
> Can you confirm this?


Yes, thank you. Excellent work! I confirm this solution works. I have 
just tested it on Merrii A80 Optimus board. I applied your patch on top 
of U-Boot 2024.10.

> This fix looks easily mainline-able, as it just restores the old
> initialisation order, but I still would like to know why the other
> order hangs. Will try to do some experiments.

OK. In the mean time I will contribute your patch to meta-sunxi BSP 
layer so that it can be used for the existing U-Boot versions in images 
for sun9i machines built using the Yocto project and OpenEmbedded. This 
is obviously a far better solution than reverting commit ffb0294.
Thanks,
Leon

>
> Cheers,
> Andre
>
>
>> load mmc 0:1 ${fdt_addr_r} ${fdtfile}
>> load mmc 0:1 ${kernel_addr_r} zImage
>> bootz ${kernel_addr_r} - ${fdt_addr_r}
>>
>> Merrii A80 Optimus board boots fine if I revert commit ffb0294.
>> However, if commit ffb0294 is present in U-Boot the board hangs. Here
>> is the log: U-Boot 2024.10-dirty (Oct 07 2024 - 14:54:35 +0000)
>> Allwinner Technology CPU: Allwinner A80 (SUN9I) Model: Merrii A80
>> Optimus Board DRAM: 2 GiB Core: 62 devices, 18 uclasses, devicetree:
>> separate WDT: Not starting watchdog@6000ca0 WDT: Not starting
>> watchdog@8001000 MMC: sunxi_set_reset: (RST#0) unhandled
>> sunxi_set_reset: (RST#2) unhandled sunxi_set_reset: (RST#1) unhandled
>> mmc@1c0f000: 0, mmc@1c10000: 2, mmc@1c11000: 1 Loading Environment
>> from FAT... Unable to read "uboot.env" frommmc0:1... In:
>> serial@7000000 Out: serial@7000000 Err: serial@7000000 Net: No
>> ethernet found. Hit any key to stop autoboot: 0 => setenv bootargs
>> console=ttyS0,115200 console=tty1 root=/dev/mmcblk0p2 rootwait
>> panic=10 => load mmc 0:1 ${fdt_addr_r} ${fdtfile} 24443 bytes read in
>> 3 ms (7.8 MiB/s) => load mmc 0:1 ${kernel_addr_r} zImage 5397992
>> bytes read in 236 ms (21.8 MiB/s) => bootz ${kernel_addr_r} -
>> ${fdt_addr_r} Kernel image @ 0x22000000 [ 0x000000 - 0x525de8 ] ##
>> Flattened Device Tree blob at 23000000 Booting using the fdt blob at
>> 0x23000000 Working FDT set to 23000000 Loading Device Tree to
>> 29ff7000, end 29ffff7a ... OK Working FDT set to 29ff7000 Starting
>> kernel ... Please note that U-Boot is marked with suffix "-dirty"
>> because of the patches applied by u-boot_%.bbappend from Yocto/OE
>> layer meta-sunxi but these patches are for other boards and don't
>> touch the file board/sunxi/board.c. Am I missing something as a
>> configuration that can make the board boot the same way without
>> hanging when commit ffb0294 is present?Best regards, Leon
>>
>>> Please also note we fixed d75fa8c80dcfa in U-Boot (DCDC4/5 typo),
>>> and dd36ad71ad6 in the kernel (DCDC5 constraints in the DT).
>>>
>>> Cheers,
>>> Andre
>>>   
>>>> Older U-Boot versions without this commit work fine. As a temporary
>>>> solution I reverted commit ffb0294 and this way the boards boot
>>>> successfully. I tested this work around on Merrii A80 Optimus with
>>>> several U-Boot versions, including with U-Boot 2024.10.
>>>   
>>>> Lazar, a friend who owns Cubieboard 4, also tested and confirmed
>>>> his board boots with U-Boot 2024.10 if this commit has been
>>>> reverted.
>>>>
>>>> How to fix this? Is there a known configuration that can be added
>>>> to Merrii_A80_Optimus_defconfig and Cubieboard4_defconfig to avoid
>>>> hanging with the existing source code from commit ffb0294 ?
>>>>
>>>> Best regards,
>>>> Leon
