Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03264C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 11:51:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 307AF88500;
	Tue, 30 Apr 2024 13:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="wCdDuHdf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4771188727; Tue, 30 Apr 2024 13:51:02 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD0C988116
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 13:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 20C223F2D0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 11:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714477858;
 bh=gDZk6Sv5qxOpXrcK2ZkpelDcvJCfVeGqJR2jkY8ZeUk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=wCdDuHdfFiPTi9AsUNs8LT5lMQhXccRYuXAm825T4oaQLefEagtTgtrys1xBBNpve
 sC4Y7seV4Y5+vq+bhAotKBD9te+MQXeLWpVGBxswzYYHDG5TiCrY14esM92d2YWnoW
 yanck4VSiBi6LwZkQiX0JOPExRJ8ALO6rN+jm9lOGS9o2j7tH9umSjR+VWxZYuA5HI
 JR1SaiVcQ5A9fPOtKeMEeB9o7gVaVtvxw+M4+av1e5bz2Lxex9tnKzlL7cHzlypyFP
 eAZ9+rHCFYaNLFbSravqf7YsCOyyKFxBaM7kfuakHlap7xXtsK8P/WyJkfE9lWzepj
 40mPSbZdWsmaw==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-34da8f1bf7cso125670f8f.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 04:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714477856; x=1715082656;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gDZk6Sv5qxOpXrcK2ZkpelDcvJCfVeGqJR2jkY8ZeUk=;
 b=cjBNYIbaMygo9a+JisRPpRaxSncdTad6GBSS0K2UizEN3Ikq2F42qpE9yke86Z4Rr4
 Jli1PxOy5hJcdxZS3fIQ/GL0ZDDphLFN+cyyFiXxkATy6wYy2Efm54Lbk55/Kkw4sfsS
 utC2S12GE3M5CwBJNS3ie7aJ8xNslyy0bQ/82TkspYnQgWXA32bQD0rj6hjzecHgKCLC
 d7qvMSP7D4HDdWrkx+hoi959UF2Q49KODP8/9FCQEZczJDQFrhUiEOe6RIfSsz8Z84Da
 FTC7iQ90zvaqyqXN3Vp+3/nFfeOxrm09zngaDZKi6nOKfD4/FHbkcSxLwJYNGfIoTLQg
 y/OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMdqaHDYVLZvDVcMpme+6dhHxDLSY8pFsn/856sz/5V6yI/g8yyscVUCFgxezXDmihkrqw51DLZUCMtWQcDCteV99F+Q==
X-Gm-Message-State: AOJu0YxSKFMZmmT6k2R2hpu+GHwR05mfL6JSqqgv+O4CK3ZOspThzRDY
 mKmgSiJHshy5O9y+zpSuQXTlZTHIHC+WkRmA2CQo/sxOYftZzEEP9GoVDszkHPV6ge1DIEqJ1wW
 dxJ9MCJwiOzZf86T0aHNxa5SVJE5T851nHfKzjHGwqHUZNlz7ClWRMong5pC9/FIyW68=
X-Received: by 2002:a05:6000:707:b0:34c:e62a:db70 with SMTP id
 bs7-20020a056000070700b0034ce62adb70mr8866608wrb.67.1714477856679; 
 Tue, 30 Apr 2024 04:50:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMaIG3VDXaAuc228IT01VhHaqOmepzIIiBB91zzDPDwO/8wZe3x1fYhxK/w4EwniihOtiFuw==
X-Received: by 2002:a05:6000:707:b0:34c:e62a:db70 with SMTP id
 bs7-20020a056000070700b0034ce62adb70mr8866571wrb.67.1714477856181; 
 Tue, 30 Apr 2024 04:50:56 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 a12-20020a056000050c00b00349ac818326sm31956509wrf.43.2024.04.30.04.50.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 04:50:55 -0700 (PDT)
Message-ID: <29993227-e6fd-49be-b872-5458166626f8@canonical.com>
Date: Tue, 30 Apr 2024 13:50:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] board: add support for Milk-V Mars CM
To: E Shattow <lucent@gmail.com>, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Shengyu Qu <wiagn233@outlook.com>,
 Shiji Yang <yangshiji66@outlook.com>, Seung-Woo Kim
 <sw0312.kim@samsung.com>, u-boot@lists.denx.de,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
References: <20240415115035.46199-1-heinrich.schuchardt@canonical.com>
 <20240415115035.46199-3-heinrich.schuchardt@canonical.com>
 <CAJM55Z9gVQom+jKzcLZ4jVKLS3MbGNpx1hx6dEWjgpY7Xmy5aA@mail.gmail.com>
 <CANV2PTO1EAkgf_4Uo6cqes=DMD=juGJaB17eLymJL4tCLerwvw@mail.gmail.com>
 <7138128e-1e48-42a0-8114-2d4cdde25ce0@canonical.com>
 <CANV2PTPci_WVDnerZ1QxPYSio869XiRq21E-pezeD03X3teqEw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CANV2PTPci_WVDnerZ1QxPYSio869XiRq21E-pezeD03X3teqEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 30.04.24 11:59, E Shattow wrote:
> On Tue, Apr 30, 2024 at 12:18 AM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 30.04.24 00:46, E Shattow wrote:
>>> On Sun, Apr 28, 2024 at 9:13 AM Emil Renner Berthing
>>> <emil.renner.berthing@canonical.com> wrote:
>>>>
>>>> Heinrich Schuchardt wrote:
>>>>> We already support the VisionFive 2 and the Milk-V Mars board by
>>>>> patching the VisionFive 2 device tree. With this patch the same
>>>>> is done for the Milk-V Mars CM.
>>>>
>>>> Hi Heinrich.
>>>>
>>>> Thanks for the patch. As far as I can tell the Milk-V documentation[1] is
>>>> pretty consistent in calling the version without eMMC "Milk-V Mars CM Lite"
>>>> and the version with eMMC just "Milk-V Mars CM". So I'd prefer the model,
>>>> compatible and filenames suggested below.
>>>>
>>>> [1]: https://milkv.io/docs/mars/compute-module/introduction#design-philosophy
>>>>
>>>
>>> Are there any actual differences that need representation in the dtb
>>> file for downstream OS different from Milk-V Mars to Milk-V Mars CM
>>> (or CM Lite)?
>>>
>>> I did find this vendor repo commit "kernel: dts reconfig sdio0 for
>>> SDCard version"
>>> https://github.com/milkv-mars/mars-buildroot-sdk/commit/042ea06598995db99ddbbbb252ee439c42b9c1a9
>>> but it does not seem necessary in mainline Linux, SD Card is working
>>> without changes.
>>>
>>> It was necessary for U-Boot and the Mars CM Lite with SD Card to apply
>>> s/GPIO62/GPIO22/ as in the vendor commit "u-boot: configure sdio0 as
>>> mars-cm sdcard version"
>>> https://github.com/milkv-mars/mars-buildroot-sdk/commit/880a249518f72ecf1e2947dfeb2c66e5035fce90
>>
>> This is what is patched in fdt_fixup_marc().
> 
> That's the Mars fixup with a conditional for the s/GPIO62/GPIO22/ of
> CM Lite;  which Linux seems not to mind either way so long as this was
> done at the U-Boot phase, it is functional for eMMC/SD mmc access with
> unmodified visionfive2 1.3b dtb (GPIO62 pinmux) from Linux.
> 
> It is not clear to me why in vendor U-Boot this is s/GPIO62/GPIO22/
> but in vendor Linux kernel this is s/GPIO62/GPIO24/ ? It seems not
> needed (in Linux).

According to the schematics GPIO22 is connected to SD_PWR_ON on the the 
low speed connector both on the Mars CM and the Mars CM Lite. GPIO62 is 
connected to SDMMC_RST_N on the eMMC. Both the SD-card and the eMMC are 
connected to SDI0. This is why only one of them can be usable.

GPIO024 is used for the MIPI camera interface.

I guess unless you reset the SD-card or eMMC GPIO062 and GPI022 are not 
used and this is why Linux is working in both configurations.

> 
>>
>>>
>>> Then also there is some mention about PMIC and renamed i2c reference,
>>> already obsolete. That's all, is there more to it? Possibly a dtb for
>>> Mars is enough to also be used on Mars CM and Mars Lite?
>>
>> Looking at the schematics the biggest difference between the Mars and
>> the Mars CM (Lite) is on the USB side. The Mars board has USB 3.0 via a
>> PCIe lane and a VIA VL805/806 while the Mars CM has USB directly via the
>> SoC.
>>
>> To add USB support for the Mars CM we will need an adapted device-tree.
> 
> Mars also needs this direct-to-SoC USB support, as its USB ports are a
> mix of VL805 and directly via the SoC. This can be the same for Mars
> and Mars CM/Lite.

The schematics say:

"One USB Controller only, supports either USB 2.0 or USB 3.0."

This sounds to me like you cannot have both in functional state.

Maybe Minda or Hal know more?

Best regards

Heinrich

> 
> See this photo from
> https://milkv.io/docs/mars/getting-started/bootloader what highlights
> this direct SoC USB port of Milk-V Mars:
> https://milkv.io/assets/images/mars-usb-port-a-b48fe1ff1003539d42bf5e1dde1725a3.jpg
> 
> The over-current errata
> https://doc-en.rvspace.org/VisionFive2/DG_USB/JH7110_SDK/usb_overcurrent_debug.html
> suggests "please modify the above settings during the U-Boot phase".
> 
> -E
> 
>>
>> Best regards
>>
>> Heinrich
>>>
>>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>>> ---
>>>>>    board/starfive/visionfive2/spl.c              | 27 ++++++++++++++++++-
>>>>>    .../visionfive2/starfive_visionfive2.c        | 11 +++++++-
>>>>>    2 files changed, 36 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
>>>>> index 45848db6d8b..bb0f28d7aad 100644
>>>>> --- a/board/starfive/visionfive2/spl.c
>>>>> +++ b/board/starfive/visionfive2/spl.c
>>>>> @@ -129,6 +129,29 @@ void spl_fdt_fixup_mars(void *fdt)
>>>>>         }
>>>>>    }
>>>>>
>>>>> +void spl_fdt_fixup_marc(void *fdt)
>>>>> +{
>>>>> +     const char *compat;
>>>>> +     const char *model;
>>>>> +
>>>>> +     spl_fdt_fixup_mars(fdt);
>>>>> +
>>>>> +     if (!get_mmc_size_from_eeprom()) {
>>>>> +             int offset;
>>>>> +
>>>>> +             model = "Milk-V Mars CM SDCard";
>>>>
>>>> "Milk-V Mars CM Lite"
>>>>
>>>>> +             compat = "milkv,mars-cm-sdcard\0starfive,jh7110";
>>>>
>>>> "milkv,mars-cm-lite\0starfive,jh7110"
>>>>
>>>>> +
>>>>> +             offset = fdt_path_offset(fdt, "/soc/pinctrl/mmc0-pins/mmc0-pins-rest");
>>>>> +             fdt_setprop_u32(fdt, offset, "pinmux", 0xff130016);
>>>>> +     } else {
>>>>> +             model = "Milk-V Mars CM eMMC";
>>>>
>>>> "Milk-V Mars CM"
>>>>
>>>>> +             compat = "milkv,mars-cm-emmc\0starfive,jh7110";
>>>>
>>>> "milkv,mars-cm\0starfive,jh7110"
>>>>
>>>>> +     }
>>>>> +     fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeof(compat));
>>>>> +     fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model", model);
>>>>> +}
>>>>> +
>>>>>    void spl_fdt_fixup_version_a(void *fdt)
>>>>>    {
>>>>>         static const char compat[] = "starfive,visionfive-2-v1.2a\0starfive,jh7110";
>>>>> @@ -236,7 +259,9 @@ void spl_perform_fixups(struct spl_image_info *spl_image)
>>>>>                 pr_err("Can't read EEPROM\n");
>>>>>                 return;
>>>>>         }
>>>>> -     if (!strncmp(product_id, "MARS", 4)) {
>>>>> +     if (!strncmp(product_id, "MARC", 4)) {
>>>>> +             spl_fdt_fixup_marc(spl_image->fdt_addr);
>>>>> +     } else if (!strncmp(product_id, "MARS", 4)) {
>>>>>                 spl_fdt_fixup_mars(spl_image->fdt_addr);
>>>>>         } else if (!strncmp(product_id, "VF7110", 6)) {
>>>>>                 version = get_pcb_revision_from_eeprom();
>>>>> diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
>>>>> index a86bca533b2..be6ca85b030 100644
>>>>> --- a/board/starfive/visionfive2/starfive_visionfive2.c
>>>>> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
>>>>> @@ -17,6 +17,10 @@
>>>>>    DECLARE_GLOBAL_DATA_PTR;
>>>>>    #define JH7110_L2_PREFETCHER_BASE_ADDR               0x2030000
>>>>>    #define JH7110_L2_PREFETCHER_HART_OFFSET     0x2000
>>>>> +#define FDTFILE_MILK_V_MARC_SD \
>>>>> +     "starfive/jh7110-milkv-mars-cm-sdcard.dtb"
>>>>
>>>> "starfive/jh7110-milkv-mars-cm-lite.dtb"
>>>>
>>>>> +#define FDTFILE_MILK_V_MARC_MMC \
>>>>> +     "starfive/jh7110-milkv-mars-cm-emmc.dtb"
>>>>
>>>> "starfive/jh7110-milkv-mars-cm.dtb"
>>>>
>>>>>    #define FDTFILE_MILK_V_MARS \
>>>>>         "starfive/jh7110-milkv-mars.dtb"
>>>>>    #define FDTFILE_VISIONFIVE2_1_2A \
>>>>> @@ -61,7 +65,12 @@ static void set_fdtfile(void)
>>>>>                 log_err("Can't read EEPROM\n");
>>>>>                 return;
>>>>>         }
>>>>> -     if (!strncmp(product_id, "MARS", 4)) {
>>>>> +     if (!strncmp(product_id, "MARC", 4)) {
>>>>> +             if (get_mmc_size_from_eeprom())
>>>>> +                     fdtfile = FDTFILE_MILK_V_MARC_MMC;
>>>>> +             else
>>>>> +                     fdtfile = FDTFILE_MILK_V_MARC_SD;
>>>>> +     } else if (!strncmp(product_id, "MARS", 4)) {
>>>>>                 fdtfile = FDTFILE_MILK_V_MARS;
>>>>>         } else if (!strncmp(product_id, "VF7110", 6)) {
>>>>>                 version = get_pcb_revision_from_eeprom();
>>>>> --
>>>>> 2.43.0
>>>>>
>>>>>
>>

