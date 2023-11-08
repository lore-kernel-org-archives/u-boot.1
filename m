Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1027C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 17:10:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 423E087186;
	Wed,  8 Nov 2023 18:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="HB/u3Lt7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84E3A8718B; Wed,  8 Nov 2023 18:10:41 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01CCA87100
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 18:10:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 635C03FADB
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699463438;
 bh=AOrcxlurpGSjvv+2d3YVvIb9n3SYqUDyJ29T54eZKtU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=HB/u3Lt7i5XYe6Bgnl50hh7VtvbALvgrSvL8FZkG328d/jIbktpnQxQT8sTepvDqb
 JSiel7I7/N6qdIX64aEtORnK95zG+5/bPsWgnCElaeXAJz6Ab5wDTWItfpIsrirIBs
 keEnn6s6zerujofWpAP7tvsBNTdhXN9XResAII36EJgWWCsHuespefZBN7n8fvwBkU
 6D5LA5vU8QaFnrDC6/0jgl3Ckmsn8hYhnm3D28X5eJVdAL6GtyQ8d3VmcahByoIx/j
 /+oqIIkgtLJZvXRMYRpVD6A6DpPxSDQI+1CWwQ4mlYgAWf+T90icek++ne+mgyIvfk
 Znz1LFiEgZoUA==
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5b97a03aa53so4114041a12.1
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 09:10:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699463437; x=1700068237;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AOrcxlurpGSjvv+2d3YVvIb9n3SYqUDyJ29T54eZKtU=;
 b=HKFS8fNojfjyD69llSb0kZF1C6LnXKQbSG7+Q3ZAJL/vQ+CfM+U9GM/dUc9LzMYLUL
 zzan6AOO0VFfrxLmvLQ+edt/8bnQphWBdSGOBJVgPO+882kKLbJqieBhHanVKKJq9wNu
 n39Byyo/fYFDAHOdrHLVFX+DrgKyE45/bnX+lT5nWkLLD7btYp4wg6/4xuz0kTLEzxsp
 eNReOTj+2N9bnq/mfGCsw8LjXNDHcZxRaqXKjis3VK50Qo2XyqtUc317y0aLrnlxCLsL
 Omzt9Ib/ve+Bz7Lil3tNkrPPx6ZGJ4ODCJtIVM9rlFPNQ5CC3n5M8ZOtCWFkt8JB6wNC
 yF8A==
X-Gm-Message-State: AOJu0YywMHUAc1feuX79yb2x5wvKXNAt7KTU5LzZtc0AKoEvtIXhV9+g
 G4PQ/vS2T9Q+ZF8G/kAFbK+R249IGMR26DZSEVInFxqzeJjHXA5IC4aDWXKZ4exllEeKy9xXLH8
 Ne1tu1VDXHQ/0KoKveV5GwSyHUtM/BeY=
X-Received: by 2002:a05:6a21:47c1:b0:181:3adf:6309 with SMTP id
 as1-20020a056a2147c100b001813adf6309mr2751690pzc.18.1699463436701; 
 Wed, 08 Nov 2023 09:10:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFF//uDjB9Oisn+q03qjL/rGbA0EJiJdeDbn3SLr6BK6dxbXNn0/P6Kh6J1d/Kp/unaAIdFxw==
X-Received: by 2002:a05:6a21:47c1:b0:181:3adf:6309 with SMTP id
 as1-20020a056a2147c100b001813adf6309mr2751658pzc.18.1699463436192; 
 Wed, 08 Nov 2023 09:10:36 -0800 (PST)
Received: from [192.168.1.244] ([208.115.86.75])
 by smtp.gmail.com with ESMTPSA id
 u8-20020aa78388000000b0068fe5a5a566sm9502717pfm.142.2023.11.08.09.10.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 09:10:35 -0800 (PST)
Message-ID: <c951ec6c-940a-4845-b283-8de03abb7e13@canonical.com>
Date: Wed, 8 Nov 2023 09:10:33 -0800
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
References: <20231107221023.GS6601@bill-the-cat>
 <20231107-flyaway-arguable-0bccc778b256@spud>
 <20231107223837.GU6601@bill-the-cat>
 <20231107-audible-undoing-293506af3890@spud>
 <20231107232305.GW6601@bill-the-cat>
 <20231107-sprinkled-sixtieth-6456baa2c7a3@spud>
 <20231108003449.GF6601@bill-the-cat>
 <91ae75c2-a0d7-4835-8306-777c4d9afdd9@canonical.com>
 <20231108143735.GO6601@bill-the-cat>
 <d39c3c18-99e7-460b-97b8-9f84f523cf11@canonical.com>
 <20231108164427.GQ6601@bill-the-cat>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20231108164427.GQ6601@bill-the-cat>
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

On 11/8/23 08:44, Tom Rini wrote:
> On Wed, Nov 08, 2023 at 07:25:22AM -0800, Heinrich Schuchardt wrote:
>> On 11/8/23 06:37, Tom Rini wrote:
>>> On Wed, Nov 08, 2023 at 06:23:37AM -0800, Heinrich Schuchardt wrote:
>>>> On 11/7/23 16:34, Tom Rini wrote:
>>>>> On Wed, Nov 08, 2023 at 12:29:03AM +0000, Conor Dooley wrote:
>>>>>> On Tue, Nov 07, 2023 at 06:23:05PM -0500, Tom Rini wrote:
>>>>> [snip]
>>>>>>> Thanks. Setting aside Simon's follow-up, this is what I was looking for.
>>>>>>> We might have to wait for Heinrich to return from the conference to have
>>>>>>> time to look at how to utilize the above and see what we can do from
>>>>>>> there.
>>>>>>
>>>>>> I did read that, but I don't think most of it is relevant to the binding
>>>>>> itself. His five things were:
>>>>>> | - U-Boot models hardware (and other things) as devices in driver model [1]
>>>>>>
>>>>>> This I think should be satisfied. The Zkr CSR is a property of the CPU,
>>>>>> and shouldn't have its own DT node IMO. Is it problematic for U-Boot to
>>>>>> populate multiple devices for its driver model based on one DT node?
>>>>
>>>> Devices in U-Boot are bound on the basis of a compatible string. All RISC-V
>>>> CPU nodes have a compatible string 'riscv' but that does not provide any
>>>> information about the existence of the Zkr extension. That information is in
>>>> the 'riscv,isa-extensions' property of the cpu nodes (see
>>>> Documentation/devicetree/bindings/riscv/cpus.yaml).
>>>>
>>>>>> I know in Linux that I can create devices using something like
>>>>>> platform_device_register(), does U-Boot have a similar facility?
>>>>
>>>> This is what the U_BOOT_DRVINFO() macro in my driver does and which Simon
>>>> discourages.
>>>
>>> My current thoughts are that in this case we could use U_BOOT_DRVINFO()
>>> like today and then have riscv_zkr_probe() be what checks the
>>> riscv,isa-extensions property for an appropriate match? This would mean
>>> we don't need any new nodes/compatibles/etc, and possibly not need any
>>> bootph- properties added either? I assume we don't need the RNG so early
>>> as for that to be an issue.
>>>
>>
>> The presence of the Zkr extension in the device-tree 'riscv,isa-extensions'
>> property does not indicate if the machine mode firmware has enabled access
>> in supervisor mode via the mseccfg.sseed flag. This is why my driver tries
>> to read the seed register and checks if an exception occurs.
> 
> This I think is a question for Cody or someone else in the RISC-V
> community? If just checking the property isn't sufficient, what is? Or,
> what's the best / most reliable way? I don't know and I'll let the
> RISC-V community sort that out instead of making incorrect assumptions
> myself.
> 
>> Additionally checking the device-tree would increase code size. Is it really
>> needed?
> 
> I mean, it depends? My biggest issue right now is that in-tree I don't
> see any RISC-V targets that select any of the RISCV_ISA options so I
> can't evaluate what platforms grow by how much where. We shouldn't be
> talking about kilobytes of change, so no, I don't think somehow checking
> the device tree for this is out of bounds. But it comes back to what I
> just asked above, first. We need the correct and expected way to check
> for this feature to be known, then we decide how to handle that.

Hardware with the Zkr extension is yet to hit the market. Please, run 
upstream QEMU (commit 2f32dcabc2f0 or later) with -cpu rv64,zkr=on to 
see the device-tree entry. A patch for OpenSBI to enable mseccfg.sseed 
is pending.

> 
>> We may have multiple RNG drivers enabled on the same device, e.g. TPM, Zkr,
>> virtio-rng. In several code locations we try to use the first RNG device
>> (not the first successfully probed RNG device). This is why
>>
>> [PATCH 1/1] rng: detect RISC-V Zkr RNG device in bind method
>> https://lore.kernel.org/u-boot/20231104065107.23623-1-heinrich.schuchardt@canonical.com/
>>
>> moves the detection from probe() to bind(). The patch further corrects the
>> return code if the RNG device is not available.
> 
> Sounds like we have some other general issues to sort out too then.
> Filing an issue on
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/ would be
> good so it doesn't get forgotten.
> 

Here is the issue:

Missing function to find first successfully probed device for a uclass
https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/8

Best regards

Heinrich
