Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AB1C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 07:18:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12411882BC;
	Tue, 30 Apr 2024 09:18:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SNSYNQWM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95762886FD; Tue, 30 Apr 2024 09:18:04 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13F7E88280
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 09:18:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 783A9410A6
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 07:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714461480;
 bh=9MaBTxduwKhVR7tV3lGTAOZ3Di9SeQd+UYcTcHx+rTc=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=SNSYNQWMlGRsNdVJxA5I45h1GBw9eZAFqdwSH2Rvv1yG57QiF/gie5mvoPAm1Yr1H
 mofhZT7I4n+NSFhRbQPnfwqteKR7h1kF2xH/KTQ4e8viobF9zRwmm3vjA8qjStJbRz
 3UY0oKulu/xwcNL+Q5t5nZwQXKTdGvU1k2MK5ZahSs4OXYkYwoB6jofXTJZa1Xqnoy
 Ym7qqF29JRgmGcGMtFrWOX3wkLKzT5eDmJ8IblWFCYKrVKYjjH3V3QfLLfxwJBMyEJ
 Wj8g6DLS29AGxmpp11EqNcsdVhKN4FtYRgBtzp47HMsnN+bMTMP0QhdZRsTNqFOkbg
 o6DU2UG/0JtOA==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-34d7861a1f4so309738f8f.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 00:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714461480; x=1715066280;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9MaBTxduwKhVR7tV3lGTAOZ3Di9SeQd+UYcTcHx+rTc=;
 b=BfS2Sr8LE2n4A1nBcyQwJPSQiMgHYFsjlroET1qx0qHhRUNBkXSaKrZBmBmpBDnjPw
 9RcxdqiT1IPl/ERQmU0aRFXujfqlTMLZRytcUiQHvypNwn+s11eHNkv3D5ZwfyYlBMSt
 hHCVhAKwR+dHyh3EWxPQlSiXAgHuub94/dqo5knhvER5BGryGcoGUMWmleqOxIcCVMIg
 fL9MQaMP4FpUDG4wHP5STZnnxnXjalouz0q45Hz/AvxNjoqZsie+0MlCRQT3GCSEIL1n
 Ye8Hrof2x1Cc05m2a6Sl5QrONg52TGnuGhZPKzuNq9PSa9HSNCWvFADQxasYyfnQiHI3
 5B2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXKXdOYmTcRWWJUgoZY93IQB9hyGHKKKgYQ8EXqDox6zXcdqToDkivTL5lH7MKzBIg49Qt8t9GnlYrNRr8kFWG9vmT4g==
X-Gm-Message-State: AOJu0YxKELrqoAt8/xtC0/tlIzDnnT3s2lZjEHvHRfivNlnVdPJ0EADo
 Ky8H1NeLVYl++IPivfiVDXd8wso648CeJ/02ycorkWG2FqUo93bIb6XORyD+D5Cq9US8g8pmUnb
 lWExuLUZSgGgmfk007zgCp2CtJoirgLk4Ozd+MRgK2vP7B3GQ9fsARRt0oROc3HBpBrs=
X-Received: by 2002:a05:6000:a85:b0:343:7b6b:dcc6 with SMTP id
 dh5-20020a0560000a8500b003437b6bdcc6mr6738523wrb.30.1714461479987; 
 Tue, 30 Apr 2024 00:17:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJjt8Gj/Cy1yKkLxnE9TrTLlShrraNEw5i4uRmSemxoiPydnYM9TEEMGnNHjOG3yplegI3Hw==
X-Received: by 2002:a05:6000:a85:b0:343:7b6b:dcc6 with SMTP id
 dh5-20020a0560000a8500b003437b6bdcc6mr6738507wrb.30.1714461479527; 
 Tue, 30 Apr 2024 00:17:59 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a056000109100b0034c85919609sm8983079wrw.41.2024.04.30.00.17.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 00:17:58 -0700 (PDT)
Message-ID: <7138128e-1e48-42a0-8114-2d4cdde25ce0@canonical.com>
Date: Tue, 30 Apr 2024 09:17:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] board: add support for Milk-V Mars CM
To: E Shattow <lucent@gmail.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Shengyu Qu <wiagn233@outlook.com>,
 Shiji Yang <yangshiji66@outlook.com>, Seung-Woo Kim
 <sw0312.kim@samsung.com>, u-boot@lists.denx.de,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
References: <20240415115035.46199-1-heinrich.schuchardt@canonical.com>
 <20240415115035.46199-3-heinrich.schuchardt@canonical.com>
 <CAJM55Z9gVQom+jKzcLZ4jVKLS3MbGNpx1hx6dEWjgpY7Xmy5aA@mail.gmail.com>
 <CANV2PTO1EAkgf_4Uo6cqes=DMD=juGJaB17eLymJL4tCLerwvw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CANV2PTO1EAkgf_4Uo6cqes=DMD=juGJaB17eLymJL4tCLerwvw@mail.gmail.com>
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

On 30.04.24 00:46, E Shattow wrote:
> On Sun, Apr 28, 2024 at 9:13 AM Emil Renner Berthing
> <emil.renner.berthing@canonical.com> wrote:
>>
>> Heinrich Schuchardt wrote:
>>> We already support the VisionFive 2 and the Milk-V Mars board by
>>> patching the VisionFive 2 device tree. With this patch the same
>>> is done for the Milk-V Mars CM.
>>
>> Hi Heinrich.
>>
>> Thanks for the patch. As far as I can tell the Milk-V documentation[1] is
>> pretty consistent in calling the version without eMMC "Milk-V Mars CM Lite"
>> and the version with eMMC just "Milk-V Mars CM". So I'd prefer the model,
>> compatible and filenames suggested below.
>>
>> [1]: https://milkv.io/docs/mars/compute-module/introduction#design-philosophy
>>
> 
> Are there any actual differences that need representation in the dtb
> file for downstream OS different from Milk-V Mars to Milk-V Mars CM
> (or CM Lite)?
> 
> I did find this vendor repo commit "kernel: dts reconfig sdio0 for
> SDCard version"
> https://github.com/milkv-mars/mars-buildroot-sdk/commit/042ea06598995db99ddbbbb252ee439c42b9c1a9
> but it does not seem necessary in mainline Linux, SD Card is working
> without changes.
> 
> It was necessary for U-Boot and the Mars CM Lite with SD Card to apply
> s/GPIO62/GPIO22/ as in the vendor commit "u-boot: configure sdio0 as
> mars-cm sdcard version"
> https://github.com/milkv-mars/mars-buildroot-sdk/commit/880a249518f72ecf1e2947dfeb2c66e5035fce90

This is what is patched in fdt_fixup_marc().

> 
> Then also there is some mention about PMIC and renamed i2c reference,
> already obsolete. That's all, is there more to it? Possibly a dtb for
> Mars is enough to also be used on Mars CM and Mars Lite?

Looking at the schematics the biggest difference between the Mars and 
the Mars CM (Lite) is on the USB side. The Mars board has USB 3.0 via a 
PCIe lane and a VIA VL805/806 while the Mars CM has USB directly via the 
SoC.

To add USB support for the Mars CM we will need an adapted device-tree.

Best regards

Heinrich
> 
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>> ---
>>>   board/starfive/visionfive2/spl.c              | 27 ++++++++++++++++++-
>>>   .../visionfive2/starfive_visionfive2.c        | 11 +++++++-
>>>   2 files changed, 36 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
>>> index 45848db6d8b..bb0f28d7aad 100644
>>> --- a/board/starfive/visionfive2/spl.c
>>> +++ b/board/starfive/visionfive2/spl.c
>>> @@ -129,6 +129,29 @@ void spl_fdt_fixup_mars(void *fdt)
>>>        }
>>>   }
>>>
>>> +void spl_fdt_fixup_marc(void *fdt)
>>> +{
>>> +     const char *compat;
>>> +     const char *model;
>>> +
>>> +     spl_fdt_fixup_mars(fdt);
>>> +
>>> +     if (!get_mmc_size_from_eeprom()) {
>>> +             int offset;
>>> +
>>> +             model = "Milk-V Mars CM SDCard";
>>
>> "Milk-V Mars CM Lite"
>>
>>> +             compat = "milkv,mars-cm-sdcard\0starfive,jh7110";
>>
>> "milkv,mars-cm-lite\0starfive,jh7110"
>>
>>> +
>>> +             offset = fdt_path_offset(fdt, "/soc/pinctrl/mmc0-pins/mmc0-pins-rest");
>>> +             fdt_setprop_u32(fdt, offset, "pinmux", 0xff130016);
>>> +     } else {
>>> +             model = "Milk-V Mars CM eMMC";
>>
>> "Milk-V Mars CM"
>>
>>> +             compat = "milkv,mars-cm-emmc\0starfive,jh7110";
>>
>> "milkv,mars-cm\0starfive,jh7110"
>>
>>> +     }
>>> +     fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeof(compat));
>>> +     fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model", model);
>>> +}
>>> +
>>>   void spl_fdt_fixup_version_a(void *fdt)
>>>   {
>>>        static const char compat[] = "starfive,visionfive-2-v1.2a\0starfive,jh7110";
>>> @@ -236,7 +259,9 @@ void spl_perform_fixups(struct spl_image_info *spl_image)
>>>                pr_err("Can't read EEPROM\n");
>>>                return;
>>>        }
>>> -     if (!strncmp(product_id, "MARS", 4)) {
>>> +     if (!strncmp(product_id, "MARC", 4)) {
>>> +             spl_fdt_fixup_marc(spl_image->fdt_addr);
>>> +     } else if (!strncmp(product_id, "MARS", 4)) {
>>>                spl_fdt_fixup_mars(spl_image->fdt_addr);
>>>        } else if (!strncmp(product_id, "VF7110", 6)) {
>>>                version = get_pcb_revision_from_eeprom();
>>> diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
>>> index a86bca533b2..be6ca85b030 100644
>>> --- a/board/starfive/visionfive2/starfive_visionfive2.c
>>> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
>>> @@ -17,6 +17,10 @@
>>>   DECLARE_GLOBAL_DATA_PTR;
>>>   #define JH7110_L2_PREFETCHER_BASE_ADDR               0x2030000
>>>   #define JH7110_L2_PREFETCHER_HART_OFFSET     0x2000
>>> +#define FDTFILE_MILK_V_MARC_SD \
>>> +     "starfive/jh7110-milkv-mars-cm-sdcard.dtb"
>>
>> "starfive/jh7110-milkv-mars-cm-lite.dtb"
>>
>>> +#define FDTFILE_MILK_V_MARC_MMC \
>>> +     "starfive/jh7110-milkv-mars-cm-emmc.dtb"
>>
>> "starfive/jh7110-milkv-mars-cm.dtb"
>>
>>>   #define FDTFILE_MILK_V_MARS \
>>>        "starfive/jh7110-milkv-mars.dtb"
>>>   #define FDTFILE_VISIONFIVE2_1_2A \
>>> @@ -61,7 +65,12 @@ static void set_fdtfile(void)
>>>                log_err("Can't read EEPROM\n");
>>>                return;
>>>        }
>>> -     if (!strncmp(product_id, "MARS", 4)) {
>>> +     if (!strncmp(product_id, "MARC", 4)) {
>>> +             if (get_mmc_size_from_eeprom())
>>> +                     fdtfile = FDTFILE_MILK_V_MARC_MMC;
>>> +             else
>>> +                     fdtfile = FDTFILE_MILK_V_MARC_SD;
>>> +     } else if (!strncmp(product_id, "MARS", 4)) {
>>>                fdtfile = FDTFILE_MILK_V_MARS;
>>>        } else if (!strncmp(product_id, "VF7110", 6)) {
>>>                version = get_pcb_revision_from_eeprom();
>>> --
>>> 2.43.0
>>>
>>>

