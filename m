Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC46C369A8
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 12:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87F3B83FC9;
	Fri, 11 Apr 2025 14:05:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="tCUMwiE8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C001C83FCD; Fri, 11 Apr 2025 14:05:52 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FDC283FC0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 14:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EA6C63FFF4
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 12:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744373149;
 bh=W4Yd2NYa4wbwJ2lplz6MtKCQOog2vajlL6K+0EjxzS0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=tCUMwiE8vNEiSAW9Bxcs7YR1qHBuaum0W4x2m5GZnbYXZrPgXwD35ggvWXlzk6/3N
 i8at1HAUGZfr9FiskNdiabfRQQbIG3dkafslZXgmwTbC/lXmJfd5C3WvU2eQw6Bn9C
 nLCXQ8G/lIBD4y/3UvgfMdXLLwhdzk0psiU1XzLtpXKv5K2di+pGtig2xP6LyPCrwH
 QpbxJNG79a/kOgRCC+RBBSy9ZxvyqFElDsJKFUNZzv4E2XXSLIWXgXVWw6G4Az9Jvs
 1ZSqNOPcZYOhtkY4OWdbUpe0zDcN01QumnTJhtx90+qy2zOkqeXXFVDKnpY41QoqLb
 wGNYwd5wQWDQg==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39131f2bbe5so762324f8f.3
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 05:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744373149; x=1744977949;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W4Yd2NYa4wbwJ2lplz6MtKCQOog2vajlL6K+0EjxzS0=;
 b=NjDUPbKsOJMc9ujwsLHaAcovzYnJoH6cOJAkqXtfoh9pfOP/4PYHuaLvhr7AbYZ6Tb
 cj5ih/6Sduc5rQ1NaXF96ib5oZ8oY8IlCMYSxzqSkvVi9wlQrO+0MBWrIVcM4IyDqfcD
 oGoaxli7C6ZmFM1BTtfH98nm8EifYi8q/Izexk7E+Y9EX162hBZ9zHOYBvqhb8pMMTQ6
 bmXYOUjIYjroHs/XdVnpkGJCEizjoIxJ0rvu4wYc2ge/NU6V7b+AThuE7cw+jvI9Vci7
 FfZEjsbkvZk7D8THcdXZf85yS5spiOHxKP39llIB7+KqotZhhjPkCmRsRRFc/VdqKFk2
 zEJA==
X-Gm-Message-State: AOJu0YzcsmmFPjnKxCO2MlCcg3rZoIcB0iXc5P+MN9jrwRLmpp0wDv1J
 aV4Jj88mIxdV/x01oYEiE0T5ZBxl/mWbDrJPeDC8/67y6hg2/ayDG0nlYivydpo+uZRwKMTpkFI
 fSI6iisB3hxHPmOLCK/4DXM7zjQZuxz/b9/RWhxVzQJjMM+Y8VTqJ6K9xr6Uwmv+Yd8WUX2TDq/
 I=
X-Gm-Gg: ASbGncuJKHDIfT6uSRNEQmShASxIG107Dzj4WOSJawD1FiXVX+TCde7FCkV/uPz47Wc
 8mGhebV/4SDbgQbfNzGhpCCxb/35agLt2f5aiG8fKtEKCcAlXRZqbdMiqE7g/XvCKIlOHYVdZQx
 zjR9vCKCCx6Y4YVIgYaR3PBppI1l/bA5MyhqScM6AYxzxIVM8YArUyuK9/U86DHG7fBoHkj/Pnq
 gNmcIgyK6eSSjViqzDM1JuzJHYTUuYUnHCnzvtZlPIIzYJh/zb370HS/jvjY3lf629KU/rSTImN
 cFH+ndnoQP8u/v3BPoVmMO0GQsH0wJXQ0snwWVeV1+nU66GbLP15Uf/OlQv3+gnUo/lqjVAMRyj
 HCg==
X-Received: by 2002:a05:6000:18a2:b0:38f:503a:d93f with SMTP id
 ffacd0b85a97d-39eaaec7db5mr2105292f8f.40.1744373149375; 
 Fri, 11 Apr 2025 05:05:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyjQqjLnzE29r3POrzAg/j3r6c0AbxLWP1kcjR4nPkOoXBWqc6pfeb79909HJgR7L7Hv3OOw==
X-Received: by 2002:a05:6000:18a2:b0:38f:503a:d93f with SMTP id
 ffacd0b85a97d-39eaaec7db5mr2105227f8f.40.1744373148707; 
 Fri, 11 Apr 2025 05:05:48 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:5240:2e3a:39af:9096:2e68?
 ([2a02:3035:6e0:5240:2e3a:39af:9096:2e68])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf445772sm1822271f8f.91.2025.04.11.05.05.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 05:05:48 -0700 (PDT)
Message-ID: <fc25a873-94fe-466d-bb9c-d38edf39f8bd@canonical.com>
Date: Fri, 11 Apr 2025 14:05:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_selftest: check executing in EL2
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
References: <20250411053256.17332-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjL+L4ad1hfz1a5J2ozUPEwmwkZSZRuU3_mb-Qz4LG3KKg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjL+L4ad1hfz1a5J2ozUPEwmwkZSZRuU3_mb-Qz4LG3KKg@mail.gmail.com>
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

On 4/11/25 12:00, Ilias Apalodimas wrote:
> Hi Heinrich,
> 
> [...]
> 
>> +
>> +/**
>> + * current_exception_level()
>> + *
>> + * Return:     current exception level, 0 - 3
>> + */
>> +static unsigned int current_exception_level(void)
>> +{
>> +       unsigned long el;
>> +
>> +       asm volatile (
>> +               "MRS %0, CurrentEL"
>> +               : "=r" (el) : : );
>> +
>> +       return (el >> 2) & 0x3;
>> +}
>> +
> 
> We have an identical function in arch/arm/include/asm/system.h, can we
> use that? It's static inline so you may be able to just include the
> header file directly. Also, that function adds a 'cc,' which tells the
> compiler that the instruction might change the condition code flags. I
> don't remember if this is needed, but it doesn't hurt to have it.

The function current_el() in arch/arm/include/asm/system.h is already 
used in switch_to_non_secure_mode() when determining if U-Boot should 
switch the exception state. Including the same function both in the code 
under test and in the test should be avoided.

https://developer.arm.com/documentation/ddi0597/2025-03/Base-Instructions/MRS--Move-Special-register-to-general-purpose-register-
does not describe any side effects when reading the CurrentEL flags?

Best regards

Heinrich

> 
> 
>> +/**
>> + * execute() - execute test
>> + *
>> + * Check that the exception level is not EL3.
>> + */
>> +static int execute(void)
>> +{
>> +       unsigned int el = current_exception_level();
>> +
>> +       efi_st_printf("Exception level EL%u\n", el);
>> +       if (el != 1 && el != 2) {
>> +               efi_st_error("EL1 or EL2 expected");
>> +               return EFI_ST_FAILURE;
>> +       }
>> +
>> +       return EFI_ST_SUCCESS;
>> +}
>> +
>> +EFI_UNIT_TEST(el) = {
>> +       .name = "exception level",
>> +       .phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
>> +       .execute = execute,
>> +};
>> --
>> 2.48.1
>>
> 
> Other than that LGTM
> 
> /Ilias

