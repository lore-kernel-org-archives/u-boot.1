Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E4EC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 15:25:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE60C871D4;
	Wed,  8 Nov 2023 16:25:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="C0Fav5Dr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E853871CD; Wed,  8 Nov 2023 16:25:30 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDC8A871D4
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 16:25:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4B27D40C50
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 15:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699457127;
 bh=kft3sf+nnK7VBnDZ+gJv9cjVk+9ntCpNUNzIWw1qMY8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=C0Fav5DrCVlZd3DXK/8N5goDfSFjNR9W7LwTSMI0nKXfrAweR52SPpCYEQZUhhE+L
 qD/EHQI4ya2C5dCl/KJJDcOlPUeOXlOgjX0RI3BdioOyrWB6V9A8T1m16veVGpWYw8
 vjDd/H9HUc2JypuBHWjYnSCCxNEoKIGNVl97k9oX9+diGoHczYzhX+AcG/5mMHzPnL
 9TskHpEhUVeC6COvo7qpduy0Af4XgCU5mMoO2J21zVNIS1BJzInldBRLLbXWoxjpxh
 7VKfRS70WCKfX672ANbW1QLgOmK/WAXFo5nII3LrmDQ91Zorrrx4l33BbwLfmkB5QH
 Ltk35cmH76G3A==
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1cc3ad55c75so48159715ad.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 07:25:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699457126; x=1700061926;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kft3sf+nnK7VBnDZ+gJv9cjVk+9ntCpNUNzIWw1qMY8=;
 b=Xv8oXphzEK0B78pXBITvXzOP+iQxo7zO1eqycvPGCbTNuqFH0E7Ue0LMy4Pn6NDx5D
 dJXNzESEfUJT3VAzgqrdHcCORyymdzLlsZ11/WBbHE1d/jtLIw4jbmpACoNG1WuN3UDr
 T4P7DSIo3OeiZ0eXx2oGlDoCB92JylQ0cnCJBPRcwFyMmvmdlFAIujqqlOUNYskgl7s+
 BmgCwgpdW9A/d1BBO4OfKE9X1TpBeDephU5IBWP7wiZ4a8UxawLEWCt6QCBrJ/YmjWGz
 tkA4dfZeZ9ctkKLwYStNv/jeH6jfsYWL9r8O1kQ2hFSLgwaKXoU1s0WIym3QmoD/a/1C
 qjig==
X-Gm-Message-State: AOJu0YzetR7KCydBQCsgzuDT1ZJc+MzyMSSKtTanvdIQmgoNNrSgOxjm
 r6oPwdGySGUdAx1ZoRZ8XoyDeFsjCxz33i8pttuWDQ6kD3af6cnQ2jOM7A7ROTMUGF9GpYQRs/B
 cGuePA6zSiKzmpiezAE01NBou07lWtfE=
X-Received: by 2002:a17:902:e752:b0:1c6:2ae1:dc28 with SMTP id
 p18-20020a170902e75200b001c62ae1dc28mr2084286plf.36.1699457125802; 
 Wed, 08 Nov 2023 07:25:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVxxvj2Vg1Hb46rAWaaeE9OLbxiG0Bdq2iGrGUbYXbRhli3+gQbxb3BYkDroEiHny1ZfIl2Q==
X-Received: by 2002:a17:902:e752:b0:1c6:2ae1:dc28 with SMTP id
 p18-20020a170902e75200b001c62ae1dc28mr2084261plf.36.1699457125405; 
 Wed, 08 Nov 2023 07:25:25 -0800 (PST)
Received: from [172.20.5.50] ([4.28.11.157]) by smtp.gmail.com with ESMTPSA id
 z19-20020a1709028f9300b001c9c47d6cb9sm1899535plo.99.2023.11.08.07.25.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 07:25:24 -0800 (PST)
Message-ID: <d39c3c18-99e7-460b-97b8-9f84f523cf11@canonical.com>
Date: Wed, 8 Nov 2023 07:25:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
To: Tom Rini <trini@konsulko.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Anup Patel <apatel@ventanamicro.com>, Xiang W <merlew4n6@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, palmer@dabbelt.com
References: <20231107193025.GN6601@bill-the-cat>
 <CAL_JsqKkjPyVUxjANC3_rOkEAyNUBY_mXf27N6U++KTpujYYLQ@mail.gmail.com>
 <20231107221023.GS6601@bill-the-cat>
 <20231107-flyaway-arguable-0bccc778b256@spud>
 <20231107223837.GU6601@bill-the-cat>
 <20231107-audible-undoing-293506af3890@spud>
 <20231107232305.GW6601@bill-the-cat>
 <20231107-sprinkled-sixtieth-6456baa2c7a3@spud>
 <20231108003449.GF6601@bill-the-cat>
 <91ae75c2-a0d7-4835-8306-777c4d9afdd9@canonical.com>
 <20231108143735.GO6601@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20231108143735.GO6601@bill-the-cat>
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

On 11/8/23 06:37, Tom Rini wrote:
> On Wed, Nov 08, 2023 at 06:23:37AM -0800, Heinrich Schuchardt wrote:
>> On 11/7/23 16:34, Tom Rini wrote:
>>> On Wed, Nov 08, 2023 at 12:29:03AM +0000, Conor Dooley wrote:
>>>> On Tue, Nov 07, 2023 at 06:23:05PM -0500, Tom Rini wrote:
>>> [snip]
>>>>> Thanks. Setting aside Simon's follow-up, this is what I was looking for.
>>>>> We might have to wait for Heinrich to return from the conference to have
>>>>> time to look at how to utilize the above and see what we can do from
>>>>> there.
>>>>
>>>> I did read that, but I don't think most of it is relevant to the binding
>>>> itself. His five things were:
>>>> | - U-Boot models hardware (and other things) as devices in driver model [1]
>>>>
>>>> This I think should be satisfied. The Zkr CSR is a property of the CPU,
>>>> and shouldn't have its own DT node IMO. Is it problematic for U-Boot to
>>>> populate multiple devices for its driver model based on one DT node?
>>
>> Devices in U-Boot are bound on the basis of a compatible string. All RISC-V
>> CPU nodes have a compatible string 'riscv' but that does not provide any
>> information about the existence of the Zkr extension. That information is in
>> the 'riscv,isa-extensions' property of the cpu nodes (see
>> Documentation/devicetree/bindings/riscv/cpus.yaml).
>>
>>>> I know in Linux that I can create devices using something like
>>>> platform_device_register(), does U-Boot have a similar facility?
>>
>> This is what the U_BOOT_DRVINFO() macro in my driver does and which Simon
>> discourages.
> 
> My current thoughts are that in this case we could use U_BOOT_DRVINFO()
> like today and then have riscv_zkr_probe() be what checks the
> riscv,isa-extensions property for an appropriate match? This would mean
> we don't need any new nodes/compatibles/etc, and possibly not need any
> bootph- properties added either? I assume we don't need the RNG so early
> as for that to be an issue.
> 

The presence of the Zkr extension in the device-tree 
'riscv,isa-extensions' property does not indicate if the machine mode 
firmware has enabled access in supervisor mode via the mseccfg.sseed 
flag. This is why my driver tries to read the seed register and checks 
if an exception occurs.

Additionally checking the device-tree would increase code size. Is it 
really needed?

We may have multiple RNG drivers enabled on the same device, e.g. TPM, 
Zkr, virtio-rng. In several code locations we try to use the first RNG 
device (not the first successfully probed RNG device). This is why

[PATCH 1/1] rng: detect RISC-V Zkr RNG device in bind method
https://lore.kernel.org/u-boot/20231104065107.23623-1-heinrich.schuchardt@canonical.com/

moves the detection from probe() to bind(). The patch further corrects 
the return code if the RNG device is not available.

Best regards

Heinrich

