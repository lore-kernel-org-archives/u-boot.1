Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E3FC4167B
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 14:23:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A01278721C;
	Wed,  8 Nov 2023 15:23:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pQoyC7s7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E46A286FB2; Wed,  8 Nov 2023 15:23:47 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7437E87447
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 15:23:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2709F40C53
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 14:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699453423;
 bh=4pEGwhwGDaJk7BRnW0El90tBo6vAInDEkcyBl1VtjkI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=pQoyC7s7ALlNkmaEHfhpNBksCnoGuapAXOd0RgTZ6IW6fv9yN+d9VFbgyAxtLULN3
 SZAlCSmIEYsV7GzCJ/dRQwkNF7nUxvd7P4UMsFZiwlykGRTL8jGU5AsT5Ow2kLngcr
 M+nJOjcdrHuAmYF8ddcK9KPPl26WKMKic3ByLUrsqHOEC6AqumyGSeJ+x8es+rU5VI
 GVGGU51LT+TzrvKUW+GyYblFLsEaSYiXr1T32O6442XUhFzPpiovV27cl0tGd0f8YR
 2mcK6jSdhS3OhfaXPvkZix86I6z0fPF/oP1Hlq0hrS0awqwLl2IWW1UqqSW/VN2g7M
 LFshVXHyCUBTw==
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5b7bf1c206fso4150667a12.2
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 06:23:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699453422; x=1700058222;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4pEGwhwGDaJk7BRnW0El90tBo6vAInDEkcyBl1VtjkI=;
 b=ladyMmr6UojRg+L7t8W0ELeSj96IkFLTqCy+bhDFQQXAw9lcmXag8yU8rYQ7I7Txph
 fETNXd833fgCphNlK4GotVB+RVGj0UcPz2zG5nxnD4TRNVHdM2caAQmm5hrOjP3BKCNQ
 AGfwLLItj29L4xOYasGuj83bM1WmSDsYpjXWxDeQ6Z/iF11ot7RCfeqCabzHe1uzdNqu
 KDWNOut2IgVxjhvQVIS/iPSGjrhxWKlTy/cPbLp74Df03q2qOBZnRQLmqKryod6L4Jan
 Go4qS963O5JgI3+Hhq542DtKcAwKqgStpc+ihc6+MHutGzPCvo1dEdSP8QGnRWoKlTO2
 PClQ==
X-Gm-Message-State: AOJu0Ywz97jEJJUTKfE+ZpRMHzYiE5XdxJlOE4kXKGfFecAl26jD8L7C
 DhO5PUvEL3/GxfNSrJQw4iCixugem0s3yQOb1ib1rLjEr2K9xIlXQKh6Sbxla+ZLrz6P9ATQxWE
 E8MElpmunwfwwu6HnEOUefD9ii1iSUCY=
X-Received: by 2002:a05:6a21:7783:b0:129:3bb4:77f1 with SMTP id
 bd3-20020a056a21778300b001293bb477f1mr2174316pzc.0.1699453421642; 
 Wed, 08 Nov 2023 06:23:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFjSyt8GaXKB0YRVpK9uv+N5Z55ZCjyPKE/0rgbCunRxmGXA2023/kgdPSL73u8jEBWhkRDA==
X-Received: by 2002:a05:6a21:7783:b0:129:3bb4:77f1 with SMTP id
 bd3-20020a056a21778300b001293bb477f1mr2174292pzc.0.1699453421207; 
 Wed, 08 Nov 2023 06:23:41 -0800 (PST)
Received: from [172.20.5.50] ([4.28.11.157]) by smtp.gmail.com with ESMTPSA id
 s12-20020a056a00194c00b00690daae925bsm9004401pfk.51.2023.11.08.06.23.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 06:23:39 -0800 (PST)
Message-ID: <91ae75c2-a0d7-4835-8306-777c4d9afdd9@canonical.com>
Date: Wed, 8 Nov 2023 06:23:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
Content-Language: en-US, de-DE
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Simon Glass <sjg@chromium.org>,
 Andre Przywara <andre.przywara@arm.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Anup Patel <apatel@ventanamicro.com>,
 Xiang W <merlew4n6@gmail.com>, Chanho Park <chanho61.park@samsung.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, palmer@dabbelt.com,
 Tom Rini <trini@konsulko.com>
References: <20231106204608.GJ496310@bill-the-cat>
 <CAPnjgZ28HskiFDBDa=s_k6=WNoPfWu88bAaYCY7ew8dcYXW=aQ@mail.gmail.com>
 <20231107193025.GN6601@bill-the-cat>
 <CAL_JsqKkjPyVUxjANC3_rOkEAyNUBY_mXf27N6U++KTpujYYLQ@mail.gmail.com>
 <20231107221023.GS6601@bill-the-cat>
 <20231107-flyaway-arguable-0bccc778b256@spud>
 <20231107223837.GU6601@bill-the-cat>
 <20231107-audible-undoing-293506af3890@spud>
 <20231107232305.GW6601@bill-the-cat>
 <20231107-sprinkled-sixtieth-6456baa2c7a3@spud>
 <20231108003449.GF6601@bill-the-cat>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20231108003449.GF6601@bill-the-cat>
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

On 11/7/23 16:34, Tom Rini wrote:
> On Wed, Nov 08, 2023 at 12:29:03AM +0000, Conor Dooley wrote:
>> On Tue, Nov 07, 2023 at 06:23:05PM -0500, Tom Rini wrote:
> [snip]
>>> Thanks. Setting aside Simon's follow-up, this is what I was looking for.
>>> We might have to wait for Heinrich to return from the conference to have
>>> time to look at how to utilize the above and see what we can do from
>>> there.
>>
>> I did read that, but I don't think most of it is relevant to the binding
>> itself. His five things were:
>> | - U-Boot models hardware (and other things) as devices in driver model [1]
>>
>> This I think should be satisfied. The Zkr CSR is a property of the CPU,
>> and shouldn't have its own DT node IMO. Is it problematic for U-Boot to
>> populate multiple devices for its driver model based on one DT node?

Devices in U-Boot are bound on the basis of a compatible string. All 
RISC-V CPU nodes have a compatible string 'riscv' but that does not 
provide any information about the existence of the Zkr extension. That 
information is in the 'riscv,isa-extensions' property of the cpu nodes 
(see Documentation/devicetree/bindings/riscv/cpus.yaml).

>> I know in Linux that I can create devices using something like
>> platform_device_register(), does U-Boot have a similar facility?

This is what the U_BOOT_DRVINFO() macro in my driver does and which 
Simon discourages.

The discussion boils down to whether U-Boot can force every M-mode 
firmware invoking it to provide a compatible string for Zkr if the 
extension is provided (or to be more restrictive if mseccfg.sseed is set 
to 1).

I would prefer to avoid duplicate encoding of RISC-V extensions in the 
device-tree.

>> https://elixir.bootlin.com/linux/latest/source/drivers/base/platform.c#L767
>>
>> | - U-Boot requires devices to be in the devicetree, with very limited
>> | exceptions [2]
>>
>> | - Where multiple devices exist in a uclass, it is desirable to be able
>> | to number them [3]
>>
>> I'm not sure really how this one ties in. Do you need a number for each
>> CPU that supports Zkr, since a system may be heterogeneous? I think that
>> how you treat things like that is beyond communicating support via DT
>> though, IMO the job of the DT is just to tell U-Boot on which CPUs it
>> can access the seed CSR.

U-Boot only uses a single hart. It is for this specific hart that we 
need to find out if the seed register provided by the Zkr extension is 
readable. The register is only readable if additionally the 
mseccfg.sseed bit is set by machine mode firmware.

Thus any additional device-tree node related to the Zkr extension would 
have to be provided per Zkr enabled 'cpu' device-tree node.

Best regards

Heinrich

>>
>> | - Similarly it is useful to be able select a particular device, e.g.
>> | with a phandle [4]
>>
>> I suppose a phandle to the CPU would work in this case.
>>
>> | - U-Boot uses devicetree for configuration as it has no userspace
> 
> I mean, the reason I was setting aside Simon's question is that in my
> mind, we (U-Boot) need to think about what we're declaring as a MUST
> because the constant feedback that we get is "No, why does that need to
> get added to DT? Can't you just use ... ?". So I do find your answers
> above enlightening in that regard.
> 

