Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741E1C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 12:50:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D049180F03;
	Wed, 23 Apr 2025 14:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RPyyjptu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61A3180FDA; Wed, 23 Apr 2025 14:50:09 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19AA680944
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 14:50:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C3CF43F2A8
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 12:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745412605;
 bh=qWbcIPeF3FvIfpmE53AD9DTP36lV5XBYWFdV6vd0wMU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=RPyyjptunLsYvNsF7K5x7U1zfkXy2Ef3Cn3/doEA9t7Np4coivUg8QvKpUGW66XVy
 lWMTJAjNwt64Qdc4TfBkENmezcB3FTYLtFiJYjEzuAIG+w2P5LECGTCVb4dpQPcw8O
 5x1khvzMexBKolv0wzccTCjo1DPsgHzxbyevXeFzHkRnMzeUrNx7KTCcKrb9IaTc4F
 4u+zQZGJOEgkJr9WPGytVd8/UlBTdWY0BWUcok6pxnqz5ysz7j+8OK397v/5HSdqrW
 9qO5wRIjlviBdnV3W12a+nJZVgCM/QUvBatBleBZ72hHgeoyZb8dkoj01+1d48E57n
 o89c/KoylnARw==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43e9a3d2977so46594485e9.1
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 05:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745412605; x=1746017405;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qWbcIPeF3FvIfpmE53AD9DTP36lV5XBYWFdV6vd0wMU=;
 b=dszonRGQiOu9huIhMfFHPMcCfYFZ5UAjSpWE5QCJOALnVrkoqo4fgpFY1MwJBtKKGW
 Y5puzs4lX1/YmGa2CBo6lQmahZHLdAi7fZ2TCqSEssHhrMizNQN4+oamOIneLBeM/xtG
 w31TFf0wcOiwQN751nUYDPpq9w3JOg8gE1k307MIuETOFeuTyGBmbuZ+FedAs08+9Cfb
 KMNlTSJgJ0qfUhgYHaloDfe6v9ysPX1yEab8niwfBmTjU2U9b3zUJvNfZ4q1wxF5tMkZ
 9s2Y7dyaNNNifEZYRnfEKOYO+1osWxvxaGO34UNGOIDthlg8hwcxbN1pHlzXRQOaUbK7
 4fvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRcGK1qAampJFq1328D/FadYX58Ht3LKbM1jy8pF5y4RrgmOkNevHnYarSTXrmoj6KXbIcicY=@lists.denx.de
X-Gm-Message-State: AOJu0Yzbld49JHw94/o3yNJvM1pZA2gwBsFlvVeC5cbUSa6yTUqnAJz+
 gosVjqOGk9Wh7ZeRce6mctHGH79eeTFF+zTOsOts6S5ugq2cdJw29UtFFX/g1Eg6RPzZKD0APBJ
 r00oYFtsBWJrtxdWzpvU/IT5NUHILPgJmyE8rNrnQatVcN0RxJnjaVMmkrA7vUjxPpLs=
X-Gm-Gg: ASbGncuVlqUyNLzcSNFts7LVjlkOAbQQGiF6BvU5uRZeg4nOxTULWd4F+GMeOfMV4HI
 LVq9u7IspmAY3eDjZTHv7x+VBe1ESuO8alhgoXrf9C4/JgvTFmUQOvnv7QHkcXFIe7Wh9GhskNB
 cg9fgngtDVFkKanadowbglOWoSxy36cnaBs+dHMVJfLGUbgRlOQmoaoUJ423eJNbRr1NHF3a0L0
 iywVeujswzrtHnyGAMingZ4GMN93v9xOHcbWLgheY2hn/+M/KR9D4/lVkbvUCIfmMhr+hITQpvI
 wV4q1bmJrwfNzXyOjyj+F0bABNHn9x5bpL93XPrWEk50d2ptDAwZnRNQRBvSCKtRDYCFi2uY6k3
 Ae9o7vhPz
X-Received: by 2002:a05:600c:cc4:b0:440:6a1a:d89f with SMTP id
 5b1f17b1804b1-4406ab6c569mr189469545e9.4.1745412605382; 
 Wed, 23 Apr 2025 05:50:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJSXKPC93ZRWfjazcHXSEJBBbAzsLVxsTkkUhUCTwiydrtso3BFKmBvuTK+wYzshllJGXFLA==
X-Received: by 2002:a05:600c:cc4:b0:440:6a1a:d89f with SMTP id
 5b1f17b1804b1-4406ab6c569mr189469185e9.4.1745412604860; 
 Wed, 23 Apr 2025 05:50:04 -0700 (PDT)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d17a36sm25195205e9.3.2025.04.23.05.50.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 05:50:04 -0700 (PDT)
Message-ID: <785ae15f-62c0-45e3-ae7e-6b56c4a3c3d6@canonical.com>
Date: Wed, 23 Apr 2025 14:50:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 7/8] efi_loader: create EFI BOOTDEV
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-8-heinrich.schuchardt@canonical.com>
 <CAFLszTiUL=zOtK3=yu_XpW_x=iKtBCFNqZ65Q+qv=AAPQMjUBw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTiUL=zOtK3=yu_XpW_x=iKtBCFNqZ65Q+qv=AAPQMjUBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 23.04.25 14:28, Simon Glass wrote:
> Hi Heinrich,
> 
> On Mon, 21 Apr 2025 at 10:26, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Create a bootdev device for the EFI boot manager.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   include/dm/uclass-id.h       |   1 +
>>   lib/efi_loader/Makefile      |   1 +
>>   lib/efi_loader/efi_bootdev.c | 102 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 104 insertions(+)
>>   create mode 100644 lib/efi_loader/efi_bootdev.c
>>
>> diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
>> index 270088ad94f..d0795c13d14 100644
>> --- a/include/dm/uclass-id.h
>> +++ b/include/dm/uclass-id.h
>> @@ -59,6 +59,7 @@ enum uclass_id {
>>          UCLASS_ECDSA,           /* Elliptic curve cryptographic device */
>>          UCLASS_EFI_LOADER,      /* Devices created by UEFI applications */
>>          UCLASS_EFI_MEDIA,       /* Devices provided by UEFI firmware */
>> +       UCLASS_EFI_BOOT_MGR,    /* EFI boot manager */
>>          UCLASS_ETH,             /* Ethernet device */
>>          UCLASS_ETH_PHY,         /* Ethernet PHY device */
>>          UCLASS_EXTCON,          /* External Connector Class */
>> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
>> index ab50a69e48b..c37f05d70e4 100644
>> --- a/lib/efi_loader/Makefile
>> +++ b/lib/efi_loader/Makefile
>> @@ -25,6 +25,7 @@ apps-$(CONFIG_BOOTEFI_TESTAPP_COMPILE) += testapp
>>   obj-$(CONFIG_CMD_BOOTEFI_HELLO) += helloworld_efi.o
>>   obj-$(CONFIG_EFI_BOOTMGR) += efi_bootmgr.o
>>   obj-$(CONFIG_EFI_BINARY_EXEC) += efi_bootbin.o
>> +obj-$(CONFIG_BOOTMETH_EFI_BOOTMGR) += efi_bootdev.o
>>   obj-y += efi_boottime.o
>>   obj-y += efi_helper.o
>>   obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += efi_capsule.o
>> diff --git a/lib/efi_loader/efi_bootdev.c b/lib/efi_loader/efi_bootdev.c
>> new file mode 100644
>> index 00000000000..066df9462c8
>> --- /dev/null
>> +++ b/lib/efi_loader/efi_bootdev.c
>> @@ -0,0 +1,102 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Bootdev for boot manager
>> + *
>> + * Copyright 2025, Heinrich Schuchardt <xypron.glpk@gmx.de>
>> + */
>> +
>> +#define LOG_CATEGORY UCLASS_BOOTSTD
>> +
>> +#include <bootdev.h>
>> +#include <bootflow.h>
>> +#include <dm.h>
>> +#include <dm/lists.h>
>> +
>> +static int efi_get_bootflow(struct udevice *dev, struct bootflow_iter *iter,
>> +                           struct bootflow *bflow)
>> +{
>> +       int ret;
>> +
>> +       ret = strcmp(iter->method->name, "efi_mgr");
>> +       if (!ret)
>> +               bflow->state = BOOTFLOWST_READY;
>> +
>> +       return ret;
>> +}
>> +
>> +struct bootdev_ops efi_bootdev_ops = {
>> +       .get_bootflow   = efi_get_bootflow,
>> +};
>> +
>> +static int efi_bootdev_bind(struct udevice *dev)
>> +{
>> +       struct bootdev_uc_plat *ucp = dev_get_uclass_plat(dev);
>> +
>> +       ucp->prio = BOOTDEVP_6_EFI;
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct udevice_id efi_bootdev_ids[] = {
>> +       { .compatible = "u-boot,bootdev-efi" },
>> +       { }
>> +};
>> +
>> +U_BOOT_DRIVER(efi_bootdev) = {
>> +       .name           = "efi_bootdev",
>> +       .id             = UCLASS_BOOTDEV,
>> +       .ops            = &efi_bootdev_ops,
>> +       .bind           = efi_bootdev_bind,
>> +       .of_match       = efi_bootdev_ids,
>> +};
>> +
>> +/**
>> + * efi_bootdev_hunt() - find devices used by EFI boot manager
>> + *
>> + * Invoke all hunters that have not been invoked by now.
>> + * This should only be the network hunter.
>> + *
>> + * @info:      info structure describing this hunter
>> + * @show:      true to show information from the hunter
>> + *
>> + * Return:     0 if device found, -EINVAL otherwise
>> + */
>> +static int efi_bootdev_hunt(struct bootdev_hunter *info, bool show)
>> +{
>> +       return bootdev_hunt(NULL, 0);
> 
> This recursive calling of hunting is very strange. Since bootmgr seems
> to need all the hunting to be done, you could move this line to
> somewhere in bootmgr.

Thank you Simon for reviewing.

I added patch 5/8 to avoid infinite recursion.

Maybe we should move this to efi_init_obj_list() because in the 
eficonfig and and efidebug command we also assume that all boot devices 
have been hunted down. If a device has not been probed you cannot create 
a boot option for it.

> 
>> +}
>> +
>> +BOOTDEV_HUNTER(efi_bootdev_hunt) = {
>> +       .prio           = BOOTDEVP_6_EFI,
>> +       .uclass         = UCLASS_EFI_BOOT_MGR,
>> +       .hunt           = efi_bootdev_hunt,
>> +       .drv            = DM_DRIVER_REF(efi_bootdev),
>> +};
>> +
>> +static int efi_bootdev_create(void)
>> +{
>> +       int ret;
>> +       struct udevice *dev_mgr;
>> +       struct udevice *dev;
>> +
>> +       ret = device_bind_driver(gd->dm_root, "efimgr",
>> +                                "efimgr", &dev_mgr);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = device_bind_driver(dev_mgr, "efi_bootdev",
>> +                                "efimgr.bootdev", &dev);
>> +       return ret;
>> +}
>> +
>> +EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_R, efi_bootdev_create);
>> +
>> +U_BOOT_DRIVER(efimgr) = {
>> +       .name           = "efimgr",
>> +       .id             = UCLASS_EFI_BOOT_MGR,
>> +};
>> +
>> +UCLASS_DRIVER(efimgr) = {
>> +       .id             = UCLASS_EFI_BOOT_MGR,
>> +       .name           = "efimgr",
>> +};
>> --
>> 2.48.1
>>
> 
> I am not seeing any tests in this series. At least we should update
> the bootflow_efi() test or add something similar.

I have not looked into the tests because I first wanted to have feedback 
if the general direction is ok.

Unfortunately most bootstd tests are checking console output line by 
line instead of functional tests which makes them fail now.

The bootstd tests should better have been written in a way that would 
allow running them on real boards without making assumptions about the 
board.

Best regards

Heinrich
