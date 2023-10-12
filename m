Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D440CDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 04:22:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 774C286D4D;
	Thu, 12 Oct 2023 06:22:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pj3dDzWh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1028186D4D; Thu, 12 Oct 2023 06:22:32 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 703AF86D41
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 06:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4194c3cf04aso3893941cf.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 21:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697084547; x=1697689347; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oxRZKP+OLq9j0otIJl3CQnn6kqgeeWdAxfD7LTxQV2k=;
 b=Pj3dDzWhD7DwBuUfHhfn6Q0jlABw1p+0zTpBne6sRC6/bo1iiO7j+RlfID19BBELnR
 0nH67DShNIrySQPcpAhPmaQ0lJxNcvKI0Ny1Xro1I0jSI/zHCz27QjDODzyru05R26vp
 REy4//M8Iutk4WA5C0ehrJvUMpXSHvvLaCjQC+o28trg4C3osfiriE/jY0r77SyNKfpG
 cJHPpbnOQBLcjTfRed6Rj7qB6qN6M0PbXSYx4Hbq8uTfCG7dpYakYugduYUKac1lziW9
 C4YsweEoXL/ITFwKLZP+HeLc5vWJmmdkjbSNdjZrwhHpamchIk4NG+ToZUB4oQwY6PQy
 06pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697084547; x=1697689347;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oxRZKP+OLq9j0otIJl3CQnn6kqgeeWdAxfD7LTxQV2k=;
 b=aCAPFbyjR8sFUaP0cUnkLl4AgerLLUaV68h9W6VeDQuKmDKE2Gu3UBEt5dJ5Xe8TRM
 TLq7Iu9fdxQQNZGFsMxolkjcJizchoV9yOcMqNwi9lSXWrNiyTsgRfRVbIAecOYvzxm9
 Iup4NanabdaL0gj7UD/5Wz4/QS0KFfupCu56Wpqv7o7QxbyQUI0OZiymNVHgkjdTpl//
 e5N+7r/HIIgSdqNVjaZDAZTWU9YvA4BVq9lZe7vbbNez/akNnVSERj5UvNC60Xh7jCqN
 ItD38TMBepr6vnmYj3hkMFp7NSIHkapIKszX3cyeQAaRP8+6dksbiEZdMyDogq6b7kOM
 5yWg==
X-Gm-Message-State: AOJu0YzakUCzDv/AZIYJ3KP5AFjMG+xMtvt/HEHwGUR7L8lOAOU11mGC
 erGBDG4UxsjLK3lqwWosdVk=
X-Google-Smtp-Source: AGHT+IGu+gjjXnl7M+SAj9NRC3gNSfXpJRouI0qM2A9J9kXu99VdvenQZfIAwHjxwjvmFi+NTmP4AA==
X-Received: by 2002:a05:622a:1b89:b0:417:f27c:3f2f with SMTP id
 bp9-20020a05622a1b8900b00417f27c3f2fmr30193826qtb.44.1697084547069; 
 Wed, 11 Oct 2023 21:22:27 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 cj20-20020a05622a259400b004197079f2f8sm5897792qtb.64.2023.10.11.21.22.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 21:22:26 -0700 (PDT)
Message-ID: <f6c4e6f2-9a9b-2d3f-8fc7-368f823b391f@gmail.com>
Date: Thu, 12 Oct 2023 00:22:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 09/26] spl: Allow enabling SPL_OF_REAL and SPL_OF_PLATDATA
 at the same time
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Heiko Schocher <hs@denx.de>
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-10-seanga2@gmail.com>
 <CAPnjgZ2EaPEQArs73V1Cm1RoaD6YaHVpLUfB6oFYJTQXd=JiMA@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAPnjgZ2EaPEQArs73V1Cm1RoaD6YaHVpLUfB6oFYJTQXd=JiMA@mail.gmail.com>
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

On 10/11/23 23:41, Simon Glass wrote:
> Hi Sean,
> 
> On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
>>
>> Sandbox unit tests in U-Boot proper load a test device tree to have some
>> devices to work with. In order to do the same in SPL, we must enable
>> SPL_OF_REAL. However, we already have SPL_OF_PLATDATA enabled. When
>> generating platdata from a devicetree, it is expected that we will not need
>> devicetree access functions (even though SPL_OF_CONTROL is enabled). This
>> expectation does not hold for sandbox, so allow user control of
>> SPL_OF_REAL.
>>
>> There are several places in the tree where conditions involving OF_PLATDATA
>> or OF_REAL no longer function correctly when both of these options can be
>> selected at the same time. Adjust these conditions accordingly.
>>
>> Signed-off-by: Sean Anderson <seanga2@gmail.com>
>> ---
>>
>>   drivers/core/Makefile               | 1 +
>>   drivers/i2c/i2c-emul-uclass.c       | 2 +-
>>   drivers/serial/sandbox.c            | 2 +-
>>   drivers/sysreset/sysreset_sandbox.c | 2 +-
>>   dts/Kconfig                         | 8 +++++---
>>   test/test-main.c                    | 2 +-
>>   6 files changed, 10 insertions(+), 7 deletions(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> with a due sense of foreboding
> 
> I wonder whether this might create confusion?

Yeah, I was a bit worried about that as well.

>>
>> diff --git a/drivers/core/Makefile b/drivers/core/Makefile
>> index bce0a3f65cb..acbd2bf2cef 100644
>> --- a/drivers/core/Makefile
>> +++ b/drivers/core/Makefile
>> @@ -15,6 +15,7 @@ obj-$(CONFIG_$(SPL_)OF_LIVE) += of_access.o of_addr.o
>>   ifndef CONFIG_DM_DEV_READ_INLINE
>>   obj-$(CONFIG_OF_CONTROL) += read.o
>>   endif
>> +obj-$(CONFIG_$(SPL_)OF_PLATDATA) += read.o
>>   obj-$(CONFIG_OF_CONTROL) += of_extra.o ofnode.o read_extra.o
>>
>>   ccflags-$(CONFIG_DM_DEBUG) += -DDEBUG
>> diff --git a/drivers/i2c/i2c-emul-uclass.c b/drivers/i2c/i2c-emul-uclass.c
>> index 1107cf309fc..d421ddfcbe2 100644
>> --- a/drivers/i2c/i2c-emul-uclass.c
>> +++ b/drivers/i2c/i2c-emul-uclass.c
>> @@ -46,7 +46,7 @@ int i2c_emul_find(struct udevice *dev, struct udevice **emulp)
>>          struct udevice *emul;
>>          int ret;
>>
>> -       if (!CONFIG_IS_ENABLED(OF_PLATDATA)) {
>> +       if (CONFIG_IS_ENABLED(OF_REAL)) {
>>                  ret = uclass_find_device_by_phandle(UCLASS_I2C_EMUL, dev,
>>                                                      "sandbox,emul", &emul);
>>          } else {
>> diff --git a/drivers/serial/sandbox.c b/drivers/serial/sandbox.c
>> index f4003811ee7..f6ac3d22852 100644
>> --- a/drivers/serial/sandbox.c
>> +++ b/drivers/serial/sandbox.c
>> @@ -280,7 +280,7 @@ U_BOOT_DRIVER(sandbox_serial) = {
>>          .flags = DM_FLAG_PRE_RELOC,
>>   };
>>
>> -#if CONFIG_IS_ENABLED(OF_REAL)
>> +#if CONFIG_IS_ENABLED(OF_REAL) && !CONFIG_IS_ENABLED(OF_PLATDATA)
>>   static const struct sandbox_serial_plat platdata_non_fdt = {
>>          .colour = -1,
>>   };
>> diff --git a/drivers/sysreset/sysreset_sandbox.c b/drivers/sysreset/sysreset_sandbox.c
>> index 3750c60b9b9..f485a135299 100644
>> --- a/drivers/sysreset/sysreset_sandbox.c
>> +++ b/drivers/sysreset/sysreset_sandbox.c
>> @@ -132,7 +132,7 @@ U_BOOT_DRIVER(warm_sysreset_sandbox) = {
>>          .ops            = &sandbox_warm_sysreset_ops,
>>   };
>>
>> -#if CONFIG_IS_ENABLED(OF_REAL)
>> +#if CONFIG_IS_ENABLED(OF_REAL) && !CONFIG_IS_ENABLED(OF_PLATDATA)
>>   /* This is here in case we don't have a device tree */
>>   U_BOOT_DRVINFO(sysreset_sandbox_non_fdt) = {
>>          .name = "sysreset_sandbox",
>> diff --git a/dts/Kconfig b/dts/Kconfig
>> index 9152f5885e9..c6fb193ca89 100644
>> --- a/dts/Kconfig
>> +++ b/dts/Kconfig
>> @@ -410,12 +410,14 @@ config SPL_OF_PLATDATA
>>            declarations for each node. See of-plat.txt for more information.
>>
>>   config SPL_OF_REAL
>> -       bool
>> +       bool "Support a real devicetree in SPL"
> 
> To avoid the user doing something silly, I wonder if it would be
> better to keep this option hidden, but enable it for sandbox_spl via
> Kconfig?

So

	visible if SANDBOX

?

>> +       depends on SPL_OF_CONTROL
>> +       select SPL_OF_LIBFDT
>>          help
>>            Indicates that a real devicetree is available which can be accessed
>>            at runtime. This means that dev_read_...() functions can be used to
>> -         read data from the devicetree for each device. This is true if
>> -         SPL_OF_CONTROL is enabled and not SPL_OF_PLATDATA
>> +         read data from the devicetree for each device. You do not need to
>> +         enable this option if you have enabled SPL_OF_PLATDATA.
>>
>>   if SPL_OF_PLATDATA
>>
>> diff --git a/test/test-main.c b/test/test-main.c
>> index edb20bc4b9c..b7015d9f38d 100644
>> --- a/test/test-main.c
>> +++ b/test/test-main.c
>> @@ -303,7 +303,7 @@ static int test_pre_run(struct unit_test_state *uts, struct unit_test *test)
>>          if (test->flags & UT_TESTF_PROBE_TEST)
>>                  ut_assertok(do_autoprobe(uts));
>>
>> -       if (!CONFIG_IS_ENABLED(OF_PLATDATA) &&
>> +       if (CONFIG_IS_ENABLED(OF_REAL) &&
>>              (test->flags & UT_TESTF_SCAN_FDT)) {
>>                  /*
>>                   * only set this if we know the ethernet uclass will be created
>> --
>> 2.37.1
>>
> 
> Regards,
> Simon

