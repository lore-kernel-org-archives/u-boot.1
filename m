Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66325C4167D
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 20:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 844D98724E;
	Thu,  9 Nov 2023 21:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BvwRDxS+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C249287516; Thu,  9 Nov 2023 21:28:33 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 086D88714C
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 21:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6846240C4E
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 20:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699561709;
 bh=Wb+T+48+PniqZ8iGmRQwE7RIDHHlHbu29eyJ1TYeLn8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=BvwRDxS+1I2A5F5rDvf7h5FUC4zKW5RlrRjciFM8Xi2X4NViNwqmAj/0lQh5YNOtL
 DrV/p5MNjk1zqd5L/Cf4UVEep6s1XGWkpi9nx2NwX/Ubpt+lvAxKA4DihgXBILRGZ6
 Nuw3qW0XWYo6CWwC5YQwqSMijagoFd4HxLdP7W8G7LvQ6te5a+1xPn38PxzHRhXJJQ
 sHg+MN3H0hVSLlehVf7kb4XDXLcig49ytx5oqhAAEbpgadST9mz3OfRr8Fsyl30GRq
 u2roNphN9ttEde86UZ+nkk8+6UHFQA7MqCDD8dzlMJ4xh4SO5EF/F9m9jLOO3/JeSs
 gDGbnoifVmYhA==
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-35945043e33so17495685ab.1
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 12:28:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699561708; x=1700166508;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wb+T+48+PniqZ8iGmRQwE7RIDHHlHbu29eyJ1TYeLn8=;
 b=rDn3c+NAka/ZxfiRAH2XtBdjSxeJisWaLekRBb3EWya5cb4RC6ox6LRv1bqhOptxJ9
 kEbXJ39PujlTVS2qs0w+eSSYH7nnulB9L1Lb/iV/iPUepVxS7md2s32vZEAWOmmAQgXr
 MWKApEdofRFlA+wxMcCpazg0rVXJ723N5m3VAI+qVA4j8kNJR2yBrP+p3lgRevmXALG5
 8j0p5w48gs/iCey9BdrLGWgAyMn6EgtmrEpjfqbz/sZ5M94QcfjCNjHjLtXP/jRVJ7Dr
 pUYSkcA4nRtgzWW7coziuSiYLYPdmT+eTsVrb7mfMv1bA76m1VtCQYaul1lolPQ4PnHp
 0StA==
X-Gm-Message-State: AOJu0YzcWI3LYAonkKGjVR/9vgdIrKSeJ0Zauq80JLQPiQ8iT2JkJWU5
 JXB50pu/uCfXpcypWTcd/2xCn/LSwjbRcX2xoPnju3kS1oR/rfnUvjUSMZ7JpPtW7Vw1b7Dr+/o
 gXGAVfHR5/+PRXAz3CirGiyna7gGaBJM=
X-Received: by 2002:a05:6e02:338b:b0:34f:dfb5:8e8 with SMTP id
 bn11-20020a056e02338b00b0034fdfb508e8mr429663ilb.14.1699561708061; 
 Thu, 09 Nov 2023 12:28:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFonNIE/mYZhGGsNt6/B2fJ6XdwaF476MlNVH62DgrO9Rbr0to5qTO98rkW4evmCZcs61JICA==
X-Received: by 2002:a05:6e02:338b:b0:34f:dfb5:8e8 with SMTP id
 bn11-20020a056e02338b00b0034fdfb508e8mr429639ilb.14.1699561707706; 
 Thu, 09 Nov 2023 12:28:27 -0800 (PST)
Received: from [10.21.210.240] ([65.132.165.41])
 by smtp.gmail.com with ESMTPSA id
 g2-20020a02cd02000000b004571b2f5940sm4157782jaq.82.2023.11.09.12.28.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 12:28:27 -0800 (PST)
Message-ID: <9525398a-1326-470e-9894-afb160cde2e6@canonical.com>
Date: Thu, 9 Nov 2023 12:28:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi: move acpi_get_rsdp_addr() to acpi/acpi_table.h
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
References: <20231109172302.54324-1-heinrich.schuchardt@canonical.com>
 <20231109192419.GH6601@bill-the-cat>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20231109192419.GH6601@bill-the-cat>
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

On 11/9/23 11:24, Tom Rini wrote:
> On Thu, Nov 09, 2023 at 09:23:02AM -0800, Heinrich Schuchardt wrote:
> 
>> Function acpi_get_rsdp_addr() is needed on all architectures which
>> write ACPI tables. Move the definition from the x86 include to an
>> architecture independent one.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   arch/x86/include/asm/acpi_table.h | 9 ---------
>>   drivers/misc/qfw.c                | 1 +
>>   include/acpi/acpi_table.h         | 9 +++++++++
>>   3 files changed, 10 insertions(+), 9 deletions(-)
> 
> My question here is, does this work right on non-x86? I know you can
> have ACPI without UEFI on x86, but elsewhere doesn't the location have
> to be provided in some manner by UEFI? I know I'm thinking that's the
> case with SMBIOS (with a few exception).
> 
> I'm assuming you're doing something here with qemu and its qfw interface
> and risc-v.
> 

Hello Tom,

yes, I want to enable ACPI passthrough on QEMU RISC-V. There will be 
more patches needed. But the current change seemed obvious looking at 
the code so I did not want to pile up more patches first.

Do you know what the status of ACPI passthrough is on ARM?

Best regards

Heinrich
