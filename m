Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5538DCE7AF1
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 09:30:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 930168870D;
	Fri,  6 Sep 2024 11:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FmjRUC7a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65C5388B11; Fri,  6 Sep 2024 11:30:49 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 574DD87FCD
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 11:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a7aa086b077so182734466b.0
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 02:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725615047; x=1726219847; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4Ss7javkAySbBOd7DM+jWCdVbS5cEgrZA3VGcJ08eMs=;
 b=FmjRUC7a94HqKMzjfWk2o6yLPmr6Kr4iyP8JbdJeLIsdFqRuP0WnxctjmgyCVFx1p5
 GE1ISg1F2Ho2a2KQsiPFxiv9Wqbua3pZXZS+sYPQdPvaUk5X3dRBPVbAegA2XeWLWeGz
 8jT6XoUInq9xA1/siZx7NHGGjvgBzFCQH76r4eoF7Ok9SHQV9MY2qDhpqZsPjBrqFbw7
 B3vBTdfqkAD4YjjmkYkCijIQetc8KEn2Z0dqT71bpWoRHjfyAnmlP+j/dEDwWOtG3oo2
 dxifOu3nfKfzdJjHQ6SuI0w52yZTtxBzCkp/RCKdh+QTNZJdOcw4SeymK+tuDED/ksxs
 /utA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725615047; x=1726219847;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4Ss7javkAySbBOd7DM+jWCdVbS5cEgrZA3VGcJ08eMs=;
 b=H4KYWfzZZelmFKcOho4cWiLR3IWeijNs9uhOIFlOE0L+QzpOfqdl3lBBvSkiQjy/wU
 sOX898Jnv1D3cGSP+bPCidy5WnjPpixEKAy5X5U5wgJ10Wq3ERtlwmTcM87Aawh/bzBH
 ts8QQ2qEg8zd9AwTjMjeEp1yhinOP0C/arl0RVLgUaA/FipWsg94aBRJzXsYoGjI1t+K
 NVXRTqcS1NPTmD2ApzZuItCekmOuei+/2aAYE4cCHfwUMPO0jrnjXLTdCCCgxi/uMU29
 hc7oI+Bjryl76t9XotrjrFvr5S3/4GPQM470pRP11TUT/vsC559ZGKJfGyv6RH4FWWDS
 BtvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWENnhHeA+U/JqKfpJx2JpFaBLi2s/qymqmXWEjl+BeZEutY4MYH9f9pTKowxA/8X3g9Y7tpm0=@lists.denx.de
X-Gm-Message-State: AOJu0YwxQWjBu4gT+i4ZDzmyM4PkeLKxwzXaVdIyjUM/VLf0onls93N4
 zzYPkRwRWPdD1UquW0OzCc50/lG/v29piQf7X+bTMOj+XqnXwugPN/1VKB+mtPo=
X-Google-Smtp-Source: AGHT+IGBGO/fBoMqgKoZITZ8Wm1tWDbF9D+cdsy9BS4qha4p7s5tIOq9pz/yKeRYzpC6wesYT45SqQ==
X-Received: by 2002:a17:907:36c7:b0:a86:ab90:6af6 with SMTP id
 a640c23a62f3a-a8a885f9ca6mr136175066b.16.1725615046475; 
 Fri, 06 Sep 2024 02:30:46 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::1450? ([2a02:8109:aa0d:be00::1450])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a93843af8sm37075766b.223.2024.09.06.02.30.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 02:30:46 -0700 (PDT)
Message-ID: <c3cfb727-1c55-4249-bc84-835d3a2428b7@linaro.org>
Date: Fri, 6 Sep 2024 11:30:44 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] cmd: fdt: use U-Boot's FDT by default
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de
References: <20240831164639.2298097-1-caleb.connolly@linaro.org>
 <CANV2PTM+wevfK7w15j-=a2oakPMMXpTdr7ntzBfkc3jbbv+veg@mail.gmail.com>
 <feff5299-6378-4de9-867d-808c23625af4@linaro.org>
 <CAFLszTiZ75zK2L8=5E9dXOHXqEybh7O=OsQiW5hkJ9xoPiWT4Q@mail.gmail.com>
 <96798312-858e-40e9-b174-a850da8de6e9@linaro.org>
 <20240903192938.GN2479150@bill-the-cat>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240903192938.GN2479150@bill-the-cat>
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



On 03/09/2024 20:29, Tom Rini wrote:
> On Mon, Sep 02, 2024 at 03:07:44PM +0200, Caleb Connolly wrote:
>> Hi Simon,
>>
>> On 01/09/2024 21:10, Simon Glass wrote:
>>> Hi Caleb,
>>>
>>> On Sun, 1 Sept 2024 at 08:21, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 31/08/2024 23:22, E Shattow wrote:
>>>>> Hi Caleb, the problem here is hidden conditional behavior.
>>>>>
>>>>> On Sat, Aug 31, 2024 at 9:56 AM Caleb Connolly
>>>>> <caleb.connolly@linaro.org> wrote:
>>>>>>
>>>>>> When using the FDT command to inspect an arbitrary FDT in memory, it
>>>>>> will always be necessary to explicitly set the FDT address. However it
>>>>>> is also quite likely that the command is being used to inspect U-Boot's
>>>>>> own FDT. Simplify that common workflow of running "fdt addr -c" to get
>>>>>> the control address and set it by just making $fdtcontroladdr the
>>>>>> default FDT if there isn't one.
>>>>>>
>>>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>>>>> ---
>>>>>>    cmd/fdt.c | 9 +++++++++
>>>>>>    1 file changed, 9 insertions(+)
>>>>>>
>>>>>> diff --git a/cmd/fdt.c b/cmd/fdt.c
>>>>>> index d16b141ce32d..8909706e2483 100644
>>>>>> --- a/cmd/fdt.c
>>>>>> +++ b/cmd/fdt.c
>>>>>> @@ -276,8 +276,17 @@ static int do_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>>>>>
>>>>>>                   return CMD_RET_SUCCESS;
>>>>>>           }
>>>>>>
>>>>>> +       /* Try using U-Boot's FDT by default */
>>>>>> +       if (!working_fdt) {
>>>>>> +               struct fdt_header *addr;
>>>>>> +
>>>>>> +               addr = (void *)env_get_hex("fdtcontroladdr", 0);
>>>>>> +               if (addr && fdt_check_header(&addr))
>>>>>> +                       set_working_fdt_addr((phys_addr_t)addr);
>>>>>> +       }
>>>>>> +
>>>>>>           if (!working_fdt) {
>>>>>>                   puts("No FDT memory address configured. Please configure\n"
>>>>>>                        "the FDT address via \"fdt addr <address>\" command.\n"
>>>>>>                        "Aborting!\n");
>>>>>> --
>>>>>> 2.46.0
>>>>>>
>>>>>
>>>>> The use of `fdt` command in the default action might be depended on by
>>>>> some userspace script as a success/fail result. I don't imagine what
>>>>> that might possibly be, just that the logic of scripts in u-boot
>>>>> depend on that pattern of use.
> 
> I don't think anything depends on "fdt addr" returning 1 if nothing is
> set.
> 
>>>> I'm not sure what the rule is about breaking changes in the CLI, I do
>>>> think this is not a realistic concern here though. Maybe Tom or Simon
>>>> can weigh in?
>>>>>
>>>>> Secondly there would need to be a warning to the user that some hidden
>>>>> conditional action is being applied? i.e. "No valid FDT address is
>>>>> configured to $fdt_addr_r or $fdt_addr so now configuring to use
>>>>> $fdtcontroladdr instead." or however you would phrase that.
>>>>
>>>> Since I call set_working_fdt_addr() it prints a message telling you that
>>>> the fdt address was set on the first call.
> 
> Yes, but it's not obvious as-is where that address came from / why,
> since today that happens because you're passing that to the command.
> 
>>>>> Otherwise I agree improvement to the fdt is welcome and my memory of
>>>>> first using this command is that it has not-sensible defaults but I
>>>>> then assumed it was designed this way because of possible use in
>>>>> U-Boot scripts.
>>>
>>> Definitely a useful feature, but how about adding a flag which sets
>>> the working fdt to the control one? That would make it less painful
>>> than using -c, and will keep existing cases running.
>>
>> Surely we have to /have/ some usecases to justify this??
> 
> Well, "fdt" the command was introduced back when Linux started taking
> device trees on PowerPC platforms, so there wasn't some default to look
> at. U-Boot isn't standardized on "fdtaddr" or "fdt_addr_r" or "fdt_addr"
> as where the device tree for the OS is, only that "fdtcontroladdr" is
> ours. So yes, I would also prefer a new flag to automatically set the
> working address to fdtcontroladdr. But I assume there's a good reason to
> not just do like other platforms have historically and fdt addr ... as
> needed before other commands? Or is this really just for interactive
> development?

My original justification was so we could add a boot menu option on 
phones that just did "fdt print /chosen bootargs" (to dump the cmdline 
args set by Qualcomm's bootloader). I originally had "fdt addr 
$fdtcontroladdr" in preboot but it felt a bit hacky, but maybe that was 
the right approach
> 

-- 
// Caleb (they/them)
