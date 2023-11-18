Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3E2C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:34:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7482B87006;
	Sat, 18 Nov 2023 18:34:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SF9AjgRH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C2D48701D; Sat, 18 Nov 2023 18:34:18 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E90386FF7
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1F9CA3F87E
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 17:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700328847;
 bh=9GVCZG4VYN+FVpYv+tS/xerKyokiRxGJC0dLk5J8FBU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=SF9AjgRHgvmCVcPpEITAB8tz/p671qTsgbiljlkq67IZEYPjsNRXoiTJC+SWOm2yX
 ol7MLHUU2/phiPsv0F6RfESjN18nW8WtoT6Yo0kHQyL8RRn9XjefA7AyevULvjb3Pg
 lP3gVur2PhORZJsM3kTg16l8rgNOO9Ex/iBczQAjJSsSp6hsD/FvTz8jJqibn8ZtRD
 0qe+kVmuWiI1900r2lSbDMGX8l0ZAHMYOAJ06cV+vX0fJqfigDHgicWcq5Vag8AAXg
 ksCGBuKfIIhx/tUuOd7U1i1KsO0lSfORgQKJWxDjqq+rzc0NR6LYDIfUZFouCWlEEO
 fmRVyr/J6P7TA==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-408597a1ae3so4022595e9.0
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:34:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700328846; x=1700933646;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9GVCZG4VYN+FVpYv+tS/xerKyokiRxGJC0dLk5J8FBU=;
 b=crK93sFr1pamR10STPnkxtpFro+d7FgAiwF6+xPid+wcqXxXdYO6xu7VxYh4Zviwn9
 Un9rtIsNG09ijD0W041gxifk5+LhFFuejmeKiMthsj1JGINQVf4T2LuY1mK4bJx0dSli
 avUIruP8nux/R8ZFSnmxPbYaoKxXBNUfdbFMtbmM2GqDuT25PRMwONxfyT683lnxaxWs
 KhIDr8NPZwqJFBhxUu+11LYkqmvbr2bKM1r2RVKcBQLdxrzhJpAZH3Lef9LkcjdV9zAM
 toePVVv/ThxIayFgc3NmNYvmaQNcZ/SoGwtZInFnMTBl/ZzkrP0aTr7pbr6pPhc8fgql
 LNoQ==
X-Gm-Message-State: AOJu0Yy0neknijhfVwV+uuscmbMazrRiL7yS7YKLeHxyk8U3RdNKwEU0
 YeTUEVDff9mgqVVaIOgWJbK3RpHd2n+6BkOJplldXcv7gu3RIXiIQAiCIvkSXfi8a25TiWfa9EG
 e2to1exOFCDhDGCKRXEzVTTXM7ngBRNw=
X-Received: by 2002:a05:600c:4445:b0:40a:392c:5b79 with SMTP id
 v5-20020a05600c444500b0040a392c5b79mr2157408wmn.14.1700328846257; 
 Sat, 18 Nov 2023 09:34:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdsF32hLdd3CUQS0NZ76c/B3Bcw+yh/O/hMUkfzEe+QrCFRX2gP0Z8gz1shStg65F5yOrnQA==
X-Received: by 2002:a05:600c:4445:b0:40a:392c:5b79 with SMTP id
 v5-20020a05600c444500b0040a392c5b79mr2157395wmn.14.1700328845764; 
 Sat, 18 Nov 2023 09:34:05 -0800 (PST)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 v6-20020a05600c470600b0040a5290dceesm7213755wmo.0.2023.11.18.09.34.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 09:34:05 -0800 (PST)
Message-ID: <3dd07df2-a261-47e6-9627-34e4529584c4@canonical.com>
Date: Sat, 18 Nov 2023 18:34:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_loader: create memory reservations in ACPI case
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20231116092928.21633-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ27mmK9BYE=rbGKGe9=xvZdG9reU659n-0D_wRfNemX5Q@mail.gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ27mmK9BYE=rbGKGe9=xvZdG9reU659n-0D_wRfNemX5Q@mail.gmail.com>
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

On 11/18/23 18:10, Simon Glass wrote:
> Hi Heinrich,
> 
> On Thu, 16 Nov 2023 at 02:29, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> ACPI tables cannot convey memory reservations for least ARM and RISC-V.
>> x86 uses the BIOS E820 table for this purpose. We cannot simply ignore the
>> device-tree when booting via ACPI.
> 
> Why is that? I had thought that we had to use one or the other. Isn't
> the devicetree irrelevant when booting with ACPI, so we can just drop
> it?

Linux Documentation/arch/arm64/acpi_object_usage.rst, line 718f 
describes the mechanism to convey memory information as follows:

"For arm64, we will only support UEFI for booting with ACPI, hence the 
UEFI GetMemoryMap() boot service is the only mechanism that will be used."

With the patch we tell the UEFI sub-system which memory areas are 
reserved (e.g. for TF-A on ARM or for OpenSBI on RISC-V). This 
information is inferred from the device-tree. The operating system will 
collect this information by calling GetMemoryMap() immediately before 
ExitBootServices().

Without the patch Linux on RISC-V using ACPI crashed when illegally 
accessing the memory reserved for OpenSBI.

Best regards

Heinrich

> 
>> We have to assign EfiReservedMemory
>> according to the prior stage device-tree ($fdtaddr) or as fallback the
>> control device-tree ($fdtcontroladdr).
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   cmd/bootefi.c           | 25 ++++++++++---------------
>>   lib/efi_loader/Makefile |  2 --
>>   2 files changed, 10 insertions(+), 17 deletions(-)
>>
> 
> The code looks fine, but I would like to better understand why this is needed.
> 
> Regards,
> Simon

