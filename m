Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6F2606A323
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oGbwEzzl;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ShxX3M39
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CF3581288;
	Wed, 11 Nov 2026 09:09:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TY01EEbBv3GL; Wed, 11 Nov 2026 09:09:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C8F078128C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794388158;
	b=X2BGv465cuECJYS1RYCqkaiRLYEfzh6Eky7+JkYKAlmLH0t3B/YL8wyDO55dnm2Un/Jt
	 7Cp5lwW5d73GXM2L3DzUn0vKWMbMTv5GqRW0Heycx+69HZIXi9EGcphOsKOBAaGV9rKEz
	 Ird/QxarMhTrQMsi1pLCtHkYtSbhZIik5a7qZz2GLK1V28eF1rLRUFonqpv9+LeLCKNYV
	 97+sPZGJbVxaD5Y/g3HbUZVOMm7ZGzMSUywC1HeU+IAfPqsHPthbBB+x0l4ukWRT85kYA
	 vWfo61tR0kcc1uOCgZohwoooZHb8wAKl1yf7/bI/i4dg9p0SmEgqUPyojzkjULB2xvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794388158;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fYh+YsZMWMqV22IdxizfyeKg/dnAL40FUIGO7L0Ompo=;
	b=GrBW0dNjXNlPzoe7LeGtWx+aIN9OwSxySiF/377G1p4en9nsPJKBO/Yb+WFtE3FnSrRW
	 BdYFcFqtkGaV8h9rlDTWN8KIpdLopqFDY6FtConcEZbfoVi3CfvcYwT5BWkCngcQzA3zp
	 UgBccCDgM07+UbYfE7jq+aHgt/9E/W1VBYbWBvp7DnpNdJtWV7i8vti+noSdBOUc+elze
	 /3BZm3cXbyHb5KdyY/ybD04YZEEqFkp7TQGejRj5cXpNR72YeLciS6FIiXZlZhA0vuQuJ
	 uJr2DBJCm4FxtJNKDmH90nT36hVm3YNlGsyofpowZ9SLn103q9x1bg2nA2r7TzX0p1g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794388158;
	bh=fYh+YsZMWMqV22IdxizfyeKg/dnAL40FUIGO7L0Ompo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oGbwEzzlXaS/e7EDXGTMsG1Lx+qP1lxhutFqEEP7SntnITNdfWXIZOtD6TZL6vxIu
	 oNQ9g8MbXm2NAv6aEreaSK42uq+YkGkTX2RXkC8nAkAL6ExeDYdMw1bnwjRGYlxn7b
	 fsJOPuAR+GzunG0tWfaVp9cdlc0uX0ceN31pI9REFQpj2rJ1XG9yfa82niBaxI7L8k
	 eKaPgd7pD8z7a5dnNvEm2ZWOdig9bUSEaQu9qtFC2k5Usp6H3OIFPW2Ere49ySZh0y
	 uJ1Or0j3Jub5eeO2S/EU/IP76bWCEz796Le//36qfkJD3h1/Wg+PD4namuGR6ddFWh
	 bXxOF/IwK2wOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8F078128C;
	Wed, 11 Nov 2026 09:09:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F0A5C17CC
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:09:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E49EE40318
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:09:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VlzgRfYaAH-5 for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 09:09:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5F89E40070
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::f2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2c; helo=mail-qv1-xf2c.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=ShxX3M39
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F89E40070
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:09:13 +0000 (UTC)
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-91eb7d147b0so13229956d6.3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 01:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794388153; x=1794992953;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fYh+YsZMWMqV22IdxizfyeKg/dnAL40FUIGO7L0Ompo=;
 b=ShxX3M39YZJm7c+51VUPP9keIbrLtdy8CQIUnjtjucggny0R/Lo6raIbU1pzl2wYM5
 OLIpYOFzan8goLRuPTmFAVaMOD+lnrxU7pT+JOac8AuPwfEp9160/ZH1NsqsJLWWND0H
 488ColYTp6BxvvUVJHy2FcsPIACBcuAFDgGftR5cFhpPLecmAbMpO/X0cyxEpw5YgUQC
 ovVkCX4nkikDz/KzNVk7vhdOQSN8Q/wPgHncHACpJ7DAU5yXRLlARvRukjWV5KFNDVPf
 OoDM5jbLv9/xGfmOum9vcDjf86D8VAIHS7TQVgO58nCK3VrK0Qf0Pojqp0aoXOFdG6fY
 G2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794388153; x=1794992953;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fYh+YsZMWMqV22IdxizfyeKg/dnAL40FUIGO7L0Ompo=;
 b=EARnBTweL9JUh0Vl6CUxnvpvpFOjtiLfs4oDWqCdIFv3UFJlTxv8CiD7tUejRdoK+a
 htylNA6KJMTNbNdb6owe/TFEECnSZ7sH1cQ1fo7270c2SZgnht0F0Ikh2mc0iLr+9AFG
 2no82k7xzqZMvssl0MD2S27t3oauQn16A3feYBtoqIUw4EJBYqjXcDGCVaPr70wUws4g
 GUMAlfk3b6B4HTb3bMuuzl+NiDHU/iehsWcA1QgU/MzHN5VmVbvNa1nDNd2EM4KDPEkQ
 gyoPrMWsT5Q4H1fApezYzKpbbxvq5NxNPI2JIUlvk8JQMTw2b5RSw1N2jGIZTFZIHArt
 vI8g==
X-Gm-Message-State: APuU4Z+6SSZ31cKguizRTRjyQfz3Loa8FEQDNLLBr9/TZFOPGsdTd+SE
 3Ew6uxWDcwzvyUtc5UaCAIHVveJ7HBysWm8DbPfn9trxuP0bY8VyYjW76pfVDLpRloxjt+EbprI
 h1iP0YRT0Q1gxlnRCZe+ubhrEYGprQZg=
X-Gm-Gg: AYBFou3m2eUbWU6lqMFAsMwEQ3J3Xv5ha0AftgiemWVhir+k99paYv0AsfvpR2iYFMX
 5BthOQCyDk5Zn01JG1G8yCfaAfyiptAg5n3gt5It0mT1zaLFsMbqy4KqpjyZRJHfdX8GHhjqUQ8
 oHyejYYOCaBlwFLWsXq4jf2buvA0iwN9QyUMXuPvdbJ9lPmRiPqsZzB1xykUvBPBojRPslaVtWv
 AR6pBDYYTXJz2Ho333QVPiseKExNZsYpSWP9obxBxNeleturBldAMQP6eIaJaXdffBRpi6JU4ec
 lbrdng0GVEa4Hvaba4b2eMVg+YjjRlnr1EtKihoaRTUQ7YibLChCeJ3YokcVacsZF5aAE7BpA5p
 WboL91EmP+mheAZTXqc8IPt09TPsihaIMMRRKfO35GY0oV1RyUO5mIIv0fxBaHUgizDUb+yzBrH
 zdTHlzjql9En0C2Wv9S+b1E1l0P9XIjeXVI48Fk63YSdy5ugnC4HJqEfMVbhZT9qDp6hNtDugs0
 y/XUvKd1qUq+L/7Df/z3fkG5iPyqxu+xdI=
X-Received: by 2002:a05:6214:5782:b0:91e:c720:1710 with SMTP id
 6a1803df08f44-91f04173095mr26866806d6.40.1794388152401; Wed, 11 Nov 2026
 01:09:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104093101.500696-1-nguyenanhgiau1008@gmail.com>
 <CAKXvu5i3EKRKTB_LCZB8xb1a0OjD-nGWqnUWnQ-d1xtjimkY9Q@mail.gmail.com>
In-Reply-To: <CAKXvu5i3EKRKTB_LCZB8xb1a0OjD-nGWqnUWnQ-d1xtjimkY9Q@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 11 Nov 2026 09:09:00 +0000
X-Gm-Features: AclHuK91LG70BSyiDCQxHmuJxsNywgHCDSGjQoveeVOX-uGcKQi2cPq_ofOjpsU
Message-ID: <CALeDE9NyuBreWZngqOn+9-_BHEfpNTMfdh775y=WsPbBNWcz4Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] i2c: bcm2835: Add new BCM2835/BCM2711 I2C
 controller driver
To: =?UTF-8?B?R2nDoHUgTmd1eeG7hW4gQW5o?= <nguyenanhgiau1008@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Matthias Brugger <mbrugger@suse.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Gi=C3=A0u,

It's on my backlog, sorry I've had limited time of late, but I should
do it in the next few days.

Peter

On Wed, 11 Nov 2026 at 03:05, Gi=C3=A0u Nguy=E1=BB=85n Anh
<nguyenanhgiau1008@gmail.com> wrote:
>
> Hi Simon and Peter,
>
> Could you please take a moment to review my patches?
> Your feedback is greatly appreciated.
>
> Thank you! Regards
> --------------------------------------------------------
> Giau Nguyen
> --------------------------------------------------------
> Phone: (+84) 387 915 996
>
>
> On Wed, Nov 4, 2026 at 4:31=E2=80=AFPM Giau Nguyen <nguyenanhgiau1008@gma=
il.com> wrote:
>>
>> Mainline U-Boot currently lacks an I2C controller driver for the
>> Broadcom BCM2711 SoC (Raspberry Pi 4).
>>
>> This commit adds a new DM-compliant I2C driver for Broadcom
>> BCM2835/BCM2711 SoCs, based on the Linux kernel's i2c-bcm2835.c
>> (Linux commit 32a0a94aa09e ("i2c: Switch back to struct
>> platform_driver::remove()")). The driver is polling based.
>>
>> The driver dynamically queries the actual VPU core clock rate from
>> the VideoCore firmware via mailbox property messages to calculate
>> the CDIV clock divider, ensuring accurate I2C timing and baud rates
>> on BCM2711.
>>
>> To query the clock, add bcm2835_get_clock_rate() to mach-bcm283x and
>> reuse it from bcm2835_get_mmc_clock(). The existing fallback to the
>> maximum clock rate when the firmware reports a rate of 0 is kept for
>> the MMC case.
>>
>> Tested on a Raspberry Pi 4 Model B with a UPS HAT carrying an INA219
>> power monitor (I2C bus 1, address 0x42), using the 'i2c dev', 'i2c probe=
',
>> 'i2c write' and 'i2c read' commands to configure the sensor and read bac=
k
>> its current register.
>>
>> Signed-off-by: Giau Nguyen <nguyenanhgiau1008@gmail.com>
>> Reviewed-by: Heiko Schocher <hs@nabladev.com>
>> ---
>>
>> Notes:
>>     v4:
>>      - Split defconfig changes into a separate patch.
>>      - Reused bcm2835_get_clock_rate() in bcm2835_get_mmc_clock(), keepi=
ng
>>        the fallback to GET_MAX_CLOCK_RATE when the firmware reports a ra=
te
>>        of 0. Define and declare it before bcm2835_get_mmc_clock() in msg=
.c
>>        and msg.h.
>>      - Added 'depends on ARCH_BCM283X' to Kconfig.
>>      - Dropped unsupported I2C_M_IGNORE_NAK flag handling.
>>      - Removed redundant !curr_msg check in polling loop.
>>      - Replaced printf() with dev_err() in probe().
>>      - Dropped redundant set_rate() call in probe(), the uclass already =
sets
>>        the bus speed from 'clock-frequency'. Check for a zero core clock
>>        rate in probe() instead, as bcm2835_get_clock_rate() no longer
>>        rejects it.
>>      - Fix #include order, .compatible formatting and copyright header.
>>
>>     v3:
>>      - Added the Linux commit ID to the commit message.
>>      - Fixed alphabetical sorting of CONFIG_SYS_I2C_BCM2835 in
>>        drivers/i2c/Makefile.
>>      - Added Reviewed-by tag from Heiko.
>>
>>     v2:
>>      - Clarified commit message: U-Boot mainline currently lacks BCM2711=
 I2C
>>        driver.
>>      - Fixed line endings and code formatting per checkpatch.pl.
>>      - Converted register offsets to 'struct bcm2835_i2c_regs' abstracti=
on.
>>      - Removed 'bcm2835_i2c_readl/writel' wrappers in favor of standard
>>        readl/writel.
>>      - Moved mailbox clock querying to bcm2835_get_clock_rate() in
>>        mach-bcm283x.
>>      - Sorted drivers/i2c/Kconfig and Makefile alphabetically.
>>      - Removed 'Assisted by AI' tag.
>>
>>  MAINTAINERS                              |   1 +
>>  arch/arm/mach-bcm283x/include/mach/msg.h |   9 +
>>  arch/arm/mach-bcm283x/msg.c              |  29 +-
>>  drivers/i2c/Kconfig                      |  11 +
>>  drivers/i2c/Makefile                     |   1 +
>>  drivers/i2c/i2c-bcm2835.c                | 359 +++++++++++++++++++++++
>>  6 files changed, 402 insertions(+), 8 deletions(-)
>>  create mode 100644 drivers/i2c/i2c-bcm2835.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d273603ac64..53bf76964de 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -277,6 +277,7 @@ S:  Maintained
>>  F:     arch/arm/mach-bcm283x/
>>  F:     board/raspberrypi/
>>  F:     drivers/gpio/bcm2835_gpio.c
>> +F:     drivers/i2c/i2c-bcm2835.c
>>  F:     drivers/mmc/bcm2835_sdhci.c
>>  F:     drivers/mmc/bcm2835_sdhost.c
>>  F:     drivers/serial/serial_bcm283x_mu.c
>> diff --git a/arch/arm/mach-bcm283x/include/mach/msg.h b/arch/arm/mach-bc=
m283x/include/mach/msg.h
>> index e54da86e353..ca8cc8826da 100644
>> --- a/arch/arm/mach-bcm283x/include/mach/msg.h
>> +++ b/arch/arm/mach-bcm283x/include/mach/msg.h
>> @@ -14,6 +14,15 @@
>>   */
>>  int bcm2835_power_on_module(u32 module);
>>
>> +/**
>> + * bcm2835_get_clock_rate() - get the current rate of a clock
>> + *
>> + * @clock_id: ID of clock to get frequency for (BCM2835_MBOX_CLOCK_ID_.=
..)
>> + * @rate: Returns the clock rate in Hz (may be 0 if the clock is not ru=
nning)
>> + * Return: 0 if OK, -EIO on error
>> + */
>> +int bcm2835_get_clock_rate(u32 clock_id, ulong *rate);
>> +
>>  /**
>>   * bcm2835_get_mmc_clock() - get the frequency of the MMC clock
>>   *
>> diff --git a/arch/arm/mach-bcm283x/msg.c b/arch/arm/mach-bcm283x/msg.c
>> index 05e1a02e80f..d1b85bdac24 100644
>> --- a/arch/arm/mach-bcm283x/msg.c
>> +++ b/arch/arm/mach-bcm283x/msg.c
>> @@ -77,15 +77,10 @@ int bcm2835_power_on_module(u32 module)
>>         return 0;
>>  }
>>
>> -int bcm2835_get_mmc_clock(u32 clock_id)
>> +int bcm2835_get_clock_rate(u32 clock_id, ulong *rate)
>>  {
>>         ALLOC_CACHE_ALIGN_BUFFER(struct msg_get_clock_rate, msg_clk, 1);
>>         int ret;
>> -       u32 clock_rate =3D 0;
>> -
>> -       ret =3D bcm2835_power_on_module(BCM2835_MBOX_POWER_DEVID_SDHCI);
>> -       if (ret)
>> -               return ret;
>>
>>         BCM2835_MBOX_INIT_HDR(msg_clk);
>>         BCM2835_MBOX_INIT_TAG(&msg_clk->get_clock_rate, GET_CLOCK_RATE);
>> @@ -93,11 +88,29 @@ int bcm2835_get_mmc_clock(u32 clock_id)
>>
>>         ret =3D bcm2835_mbox_call_prop(BCM2835_MBOX_PROP_CHAN, &msg_clk-=
>hdr);
>>         if (ret) {
>> -               printf("bcm2835: Could not query eMMC clock rate\n");
>> +               printf("bcm2835: Could not query clock rate for clock %u=
\n",
>> +                      clock_id);
>>                 return -EIO;
>>         }
>>
>> -       clock_rate =3D msg_clk->get_clock_rate.body.resp.rate_hz;
>> +       *rate =3D msg_clk->get_clock_rate.body.resp.rate_hz;
>> +
>> +       return 0;
>> +}
>> +
>> +int bcm2835_get_mmc_clock(u32 clock_id)
>> +{
>> +       ALLOC_CACHE_ALIGN_BUFFER(struct msg_get_clock_rate, msg_clk, 1);
>> +       ulong clock_rate;
>> +       int ret;
>> +
>> +       ret =3D bcm2835_power_on_module(BCM2835_MBOX_POWER_DEVID_SDHCI);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret =3D bcm2835_get_clock_rate(clock_id, &clock_rate);
>> +       if (ret)
>> +               return ret;
>>
>>         if (clock_rate =3D=3D 0) {
>>                 BCM2835_MBOX_INIT_HDR(msg_clk);
>> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
>> index 0b5225fd3f5..77f71cd28ca 100644
>> --- a/drivers/i2c/Kconfig
>> +++ b/drivers/i2c/Kconfig
>> @@ -171,6 +171,17 @@ config SYS_I2C_AT91
>>           i2c-gpio driver unless your system can cope with this limitati=
on.
>>           Binding info: doc/device-tree-bindings/i2c/i2c-at91.txt
>>
>> +config SYS_I2C_BCM2835
>> +       bool "BCM2835 I2C controller"
>> +       depends on DM_I2C
>> +       depends on ARCH_BCM283X
>> +       help
>> +         Enable support for the Broadcom BCM2835/BCM2711 I2C controller=
.
>> +         This driver provides standard I2C support for Raspberry Pi
>> +         devices, including the newer Raspberry Pi 4. It dynamically
>> +         calculates the clock divider based on the VPU core clock
>> +         queried via the firmware mailbox.
>> +
>>  config SYS_I2C_IPROC
>>         bool "Broadcom I2C driver"
>>         depends on DM_I2C
>> diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
>> index 79e6a298808..207449f0f20 100644
>> --- a/drivers/i2c/Makefile
>> +++ b/drivers/i2c/Makefile
>> @@ -15,6 +15,7 @@ obj-$(CONFIG_SYS_I2C_ADI) +=3D adi_i2c.o
>>  obj-$(CONFIG_SYS_I2C_ASPEED) +=3D ast_i2c.o
>>  obj-$(CONFIG_SYS_I2C_AST2600) +=3D ast2600_i2c.o
>>  obj-$(CONFIG_SYS_I2C_AT91) +=3D at91_i2c.o
>> +obj-$(CONFIG_SYS_I2C_BCM2835) +=3D i2c-bcm2835.o
>>  obj-$(CONFIG_SYS_I2C_CADENCE) +=3D i2c-cdns.o
>>  obj-$(CONFIG_SYS_I2C_CA) +=3D i2c-cortina.o
>>  obj-$(CONFIG_SYS_I2C_DAVINCI) +=3D davinci_i2c.o
>> diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c
>> new file mode 100644
>> index 00000000000..58bc3ce944c
>> --- /dev/null
>> +++ b/drivers/i2c/i2c-bcm2835.c
>> @@ -0,0 +1,359 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * BCM2835 I2C controller driver
>> + * Copyright (C) 2026 Giau Nguyen <nguyenanhgiau1008@gmail.com>
>> + *
>> + * Based on Linux driver: drivers/i2c/busses/i2c-bcm2835.c
>> + */
>> +
>> +#include <dm.h>
>> +#include <i2c.h>
>> +#include <time.h>
>> +#include <log.h>
>> +#include <asm/io.h>
>> +#include <asm/arch/mbox.h>
>> +#include <asm/arch/msg.h>
>> +#include <dm/device_compat.h>
>> +#include <linux/bitops.h>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/kernel.h>
>> +#include <linux/types.h>
>> +
>> +#define BCM2835_I2C_C_READ     BIT(0)
>> +#define BCM2835_I2C_C_CLEAR    BIT(4) /* bits 4 and 5 both clear */
>> +#define BCM2835_I2C_C_ST       BIT(7)
>> +#define BCM2835_I2C_C_INTD     BIT(8)
>> +#define BCM2835_I2C_C_INTT     BIT(9)
>> +#define BCM2835_I2C_C_INTR     BIT(10)
>> +#define BCM2835_I2C_C_I2CEN    BIT(15)
>> +
>> +#define BCM2835_I2C_S_TA       BIT(0)
>> +#define BCM2835_I2C_S_DONE     BIT(1)
>> +#define BCM2835_I2C_S_TXW      BIT(2)
>> +#define BCM2835_I2C_S_RXR      BIT(3)
>> +#define BCM2835_I2C_S_TXD      BIT(4)
>> +#define BCM2835_I2C_S_RXD      BIT(5)
>> +#define BCM2835_I2C_S_TXE      BIT(6)
>> +#define BCM2835_I2C_S_RXF      BIT(7)
>> +#define BCM2835_I2C_S_ERR      BIT(8)
>> +#define BCM2835_I2C_S_CLKT     BIT(9)
>> +#define BCM2835_I2C_S_LEN      BIT(10) /* Fake bit for SW error reporti=
ng */
>> +
>> +#define BCM2835_I2C_FEDL_SHIFT 16
>> +#define BCM2835_I2C_REDL_SHIFT 0
>> +
>> +#define BCM2835_I2C_CDIV_MIN   0x0002
>> +#define BCM2835_I2C_CDIV_MAX   0xFFFE
>> +
>> +#define BCM2835_I2C_CLKT_TOUT_MS 35
>> +#define BCM2835_I2C_XFER_TIMEOUT_MS 1000
>> +
>> +struct bcm2835_i2c_regs {
>> +       u32 c;
>> +       u32 s;
>> +       u32 dlen;
>> +       u32 a;
>> +       u32 fifo;
>> +       u32 div;
>> +       u32 del;
>> +       u32 clkt;
>> +};
>> +
>> +struct bcm2835_i2c_priv {
>> +       struct bcm2835_i2c_regs __iomem *regs;
>> +       ulong input_rate;
>> +       size_t msg_buf_remaining;
>> +       u8 *msg_buf;
>> +       struct i2c_msg *curr_msg;
>> +       int msg_err;
>> +       int num_msgs;
>> +};
>> +
>> +static void bcm2835_fill_txfifo(struct bcm2835_i2c_priv *i2c_dev)
>> +{
>> +       struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev->regs;
>> +
>> +       while (i2c_dev->msg_buf_remaining) {
>> +               if (!(readl(&regs->s) & BCM2835_I2C_S_TXD))
>> +                       break;
>> +
>> +               writel(*i2c_dev->msg_buf, &regs->fifo);
>> +               i2c_dev->msg_buf++;
>> +               i2c_dev->msg_buf_remaining--;
>> +       }
>> +}
>> +
>> +static void bcm2835_drain_rxfifo(struct bcm2835_i2c_priv *i2c_dev)
>> +{
>> +       struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev->regs;
>> +
>> +       while (i2c_dev->msg_buf_remaining) {
>> +               if (!(readl(&regs->s) & BCM2835_I2C_S_RXD))
>> +                       break;
>> +
>> +               *i2c_dev->msg_buf =3D readl(&regs->fifo);
>> +               i2c_dev->msg_buf++;
>> +               i2c_dev->msg_buf_remaining--;
>> +       }
>> +}
>> +
>> +static int bcm2835_i2c_calc_divider(unsigned long rate,
>> +                                   unsigned long parent_rate)
>> +{
>> +       int divider =3D DIV_ROUND_UP(parent_rate, rate);
>> +
>> +       /*
>> +        * Per the datasheet, the register is always interpreted as an e=
ven
>> +        * number, by rounding down. In other words, the LSB is ignored.=
 So,
>> +        * if the LSB is set, increment the divider to avoid any issue.
>> +        */
>> +       if (divider & 1)
>> +               divider++;
>> +
>> +       if (divider < BCM2835_I2C_CDIV_MIN ||
>> +           divider > BCM2835_I2C_CDIV_MAX)
>> +               return -EINVAL;
>> +
>> +       return divider;
>> +}
>> +
>> +static int bcm2835_i2c_set_rate(struct udevice *bus, unsigned int rate)
>> +{
>> +       struct bcm2835_i2c_priv *i2c_dev =3D dev_get_priv(bus);
>> +       struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev->regs;
>> +       ulong parent_rate =3D i2c_dev->input_rate;
>> +       u32 redl, fedl;
>> +       u32 clk_tout;
>> +       int divider;
>> +
>> +       if (!rate || !parent_rate)
>> +               return -EINVAL;
>> +
>> +       divider =3D bcm2835_i2c_calc_divider(rate, parent_rate);
>> +       if (divider < 0)
>> +               return divider;
>> +
>> +       writel(divider, &regs->div);
>> +
>> +       /*
>> +        * Number of core clocks to wait after falling edge before
>> +        * outputting the next data bit. Note that both FEDL and REDL
>> +        * can't be greater than CDIV/2.
>> +        */
>> +       fedl =3D max_t(u32, divider / 16, 1);
>> +
>> +       /*
>> +        * Number of core clocks to wait after rising edge before
>> +        * sampling the next incoming data bit.
>> +        */
>> +       redl =3D max_t(u32, divider / 4, 1);
>> +
>> +       writel((fedl << BCM2835_I2C_FEDL_SHIFT) |
>> +              (redl << BCM2835_I2C_REDL_SHIFT), &regs->del);
>> +
>> +       /*
>> +        * Set the clock stretch timeout.
>> +        */
>> +       if (rate > 0xffff * 1000 / BCM2835_I2C_CLKT_TOUT_MS)
>> +               clk_tout =3D 0xffff;
>> +       else
>> +               clk_tout =3D BCM2835_I2C_CLKT_TOUT_MS * rate / 1000;
>> +
>> +       writel(clk_tout, &regs->clkt);
>> +
>> +       return 0;
>> +}
>> +
>> +static void bcm2835_i2c_start_transfer(struct bcm2835_i2c_priv *i2c_dev=
)
>> +{
>> +       struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev->regs;
>> +       u32 c =3D BCM2835_I2C_C_ST | BCM2835_I2C_C_I2CEN;
>> +       struct i2c_msg *msg =3D i2c_dev->curr_msg;
>> +       bool last_msg =3D (i2c_dev->num_msgs =3D=3D 1);
>> +
>> +       if (!i2c_dev->num_msgs)
>> +               return;
>> +
>> +       i2c_dev->num_msgs--;
>> +       i2c_dev->msg_buf =3D msg->buf;
>> +       i2c_dev->msg_buf_remaining =3D msg->len;
>> +
>> +       if (msg->flags & I2C_M_RD)
>> +               c |=3D BCM2835_I2C_C_READ;
>> +       else
>> +               c |=3D BCM2835_I2C_C_INTT;
>> +
>> +       if (last_msg)
>> +               c |=3D BCM2835_I2C_C_INTD;
>> +
>> +       writel(msg->addr, &regs->a);
>> +       writel(msg->len, &regs->dlen);
>> +       writel(c, &regs->c);
>> +}
>> +
>> +static void bcm2835_i2c_finish_transfer(struct bcm2835_i2c_priv *i2c_de=
v)
>> +{
>> +       i2c_dev->curr_msg =3D NULL;
>> +       i2c_dev->num_msgs =3D 0;
>> +       i2c_dev->msg_buf =3D NULL;
>> +       i2c_dev->msg_buf_remaining =3D 0;
>> +}
>> +
>> +static int bcm2835_i2c_xfer(struct udevice *dev, struct i2c_msg *msgs, =
int count)
>> +{
>> +       struct bcm2835_i2c_priv *i2c_dev =3D dev_get_priv(dev);
>> +       struct bcm2835_i2c_regs __iomem *regs =3D i2c_dev->regs;
>> +       bool done =3D false;
>> +       ulong start;
>> +       int i;
>> +       u32 val, err;
>> +       int ret =3D 0;
>> +
>> +       if (!msgs || count <=3D 0)
>> +               return -EINVAL;
>> +
>> +       for (i =3D 0; i < count; i++) {
>> +               if (msgs[i].flags & I2C_M_TEN)
>> +                       return -EOPNOTSUPP;
>> +               if (msgs[i].flags & I2C_M_RD) {
>> +                       if (i < count - 1) {
>> +                               dev_err(dev, "read message must be last\=
n");
>> +                               return -EOPNOTSUPP;
>> +                       }
>> +               }
>> +               if (msgs[i].len > 0xffff)
>> +                       return -EINVAL;
>> +       }
>> +
>> +       /* Clear stale status and FIFO state before starting a new trans=
action. */
>> +       writel(BCM2835_I2C_C_CLEAR, &regs->c);
>> +       writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR | BCM2835_I2C_S_DO=
NE,
>> +              &regs->s);
>> +
>> +       i2c_dev->curr_msg =3D msgs;
>> +       i2c_dev->num_msgs =3D count;
>> +       i2c_dev->msg_err =3D 0;
>> +
>> +       bcm2835_i2c_start_transfer(i2c_dev);
>> +       start =3D get_timer(0);
>> +       while (get_timer(start) < BCM2835_I2C_XFER_TIMEOUT_MS) {
>> +               val =3D readl(&regs->s);
>> +
>> +               err =3D val & (BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR);
>> +               if (err && !(val & BCM2835_I2C_S_TA))
>> +                       i2c_dev->msg_err =3D err;
>> +
>> +               if (val & BCM2835_I2C_S_DONE) {
>> +                       if (i2c_dev->curr_msg->flags & I2C_M_RD) {
>> +                               bcm2835_drain_rxfifo(i2c_dev);
>> +                               val =3D readl(&regs->s);
>> +                       }
>> +
>> +                       if ((val & BCM2835_I2C_S_RXD) ||
>> +                           i2c_dev->msg_buf_remaining)
>> +                               i2c_dev->msg_err =3D BCM2835_I2C_S_LEN;
>> +                       done =3D true;
>> +                       break;
>> +               }
>> +
>> +               if (val & BCM2835_I2C_S_TXW) {
>> +                       if (!i2c_dev->msg_buf_remaining) {
>> +                               i2c_dev->msg_err =3D val | BCM2835_I2C_S=
_LEN;
>> +                               break;
>> +                       }
>> +
>> +                       bcm2835_fill_txfifo(i2c_dev);
>> +
>> +                       if (i2c_dev->num_msgs > 0 && !i2c_dev->msg_buf_r=
emaining) {
>> +                               i2c_dev->curr_msg++;
>> +                               bcm2835_i2c_start_transfer(i2c_dev);
>> +                       }
>> +               }
>> +
>> +               if (val & BCM2835_I2C_S_RXR) {
>> +                       if (!i2c_dev->msg_buf_remaining) {
>> +                               i2c_dev->msg_err =3D val | BCM2835_I2C_S=
_LEN;
>> +                               break;
>> +                       }
>> +
>> +                       bcm2835_drain_rxfifo(i2c_dev);
>> +               }
>> +               udelay(1);
>> +       }
>> +
>> +       if (!done) {
>> +               val =3D readl(&regs->s);
>> +               dev_err(dev, "transfer timeout: status=3D%08x remaining=
=3D%zu\n",
>> +                       val, i2c_dev->msg_buf_remaining);
>> +               ret =3D -ETIMEDOUT;
>> +       }
>> +
>> +       /* Always abort/reset the controller and clear W1C status bits. =
*/
>> +       writel(BCM2835_I2C_C_CLEAR, &regs->c);
>> +       writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR | BCM2835_I2C_S_DO=
NE,
>> +              &regs->s);
>> +
>> +       bcm2835_i2c_finish_transfer(i2c_dev);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (!i2c_dev->msg_err)
>> +               return 0;
>> +
>> +       if (i2c_dev->msg_err & BCM2835_I2C_S_ERR)
>> +               return -EREMOTEIO;
>> +
>> +       return -EIO;
>> +}
>> +
>> +static const struct dm_i2c_ops bcm2835_i2c_ops =3D {
>> +       .xfer          =3D bcm2835_i2c_xfer,
>> +       .set_bus_speed =3D bcm2835_i2c_set_rate,
>> +};
>> +
>> +static const struct udevice_id bcm2835_i2c_ids[] =3D {
>> +       { .compatible =3D "brcm,bcm2711-i2c" },
>> +       { .compatible =3D "brcm,bcm2835-i2c" },
>> +       { }
>> +};
>> +
>> +static int bcm2835_i2c_probe(struct udevice *bus)
>> +{
>> +       struct bcm2835_i2c_priv *priv =3D dev_get_priv(bus);
>> +       struct bcm2835_i2c_regs __iomem *regs;
>> +       int ret;
>> +
>> +       priv->regs =3D dev_read_addr_ptr(bus);
>> +       if (!priv->regs) {
>> +               dev_err(bus, "cannot get base address\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       regs =3D priv->regs;
>> +
>> +       ret =3D bcm2835_get_clock_rate(BCM2835_MBOX_CLOCK_ID_CORE, &priv=
->input_rate);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (!priv->input_rate) {
>> +               dev_err(bus, "invalid core clock rate\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       /* clear FIFO + status */
>> +       writel(BCM2835_I2C_C_CLEAR, &regs->c);
>> +       writel(BCM2835_I2C_S_CLKT | BCM2835_I2C_S_ERR | BCM2835_I2C_S_DO=
NE,
>> +              &regs->s);
>> +
>> +       return 0;
>> +}
>> +
>> +U_BOOT_DRIVER(bcm2835_i2c) =3D {
>> +       .name       =3D "bcm2835_i2c",
>> +       .id         =3D UCLASS_I2C,
>> +       .of_match   =3D bcm2835_i2c_ids,
>> +       .probe      =3D bcm2835_i2c_probe,
>> +       .priv_auto  =3D sizeof(struct bcm2835_i2c_priv),
>> +       .ops        =3D &bcm2835_i2c_ops,
>> +};
>> --
>> 2.34.1
>>
