Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82695C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 16:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0184880DB;
	Tue, 28 May 2024 18:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cvmHw/ji";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AA5888349; Tue, 28 May 2024 18:59:21 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 051548704E
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 18:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 844F1400F8
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1716915558;
 bh=pmuaDO6zjTM4TnFL8LIIZne+W8so2M9m4beWkpbdOfk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=cvmHw/jiS58wM1Ok5cQnLvdPZfpkRusmqSgpgf5EMl4MbE+BVEgl4TN+MceCBsWiB
 bUBfBQhhceW9/ugwuT+whid5W6c7kOplmkaI3Cc5aTlxkmiYqEYfCqzS8hx1/Ik/zc
 yBzkEms0PBWzE4sq6FgqZ3FiiLaSinC5VUFJJSAGnV5INXDUof6Zjx/6JqDpKckPv/
 0SoR3z6CLuqlSieBGvF+1k/xocadG+JN76jA+dPVivCRvZrgcipLe7DSAqnO7nWqbO
 ypzGrtF/dDwM51GRYnNdV2FZka/XLmWhbBC/9n8rw893Stlq0Kc/CWALvTRQGKRmNa
 2lAbarXGZKmcw==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-354f28306dfso817319f8f.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 09:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716915558; x=1717520358;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pmuaDO6zjTM4TnFL8LIIZne+W8so2M9m4beWkpbdOfk=;
 b=EC3QJQtKhqh3PKAFKMadfZQLO6RZ6uvMG2iFOFHrQkqQRuq7MDyGZv4i5sOTwm3Sw4
 XtlP/FFdU0ZStb8GcrlsBYphn4TDJPi91UWC9lGSw3cg0Jd2M3IDHVUX8xde1dtvj7gx
 1k2x7WbvzchjHOrBGEFxE8HPSsggTCHrKxMN9iA1RxEptYjzHwbCsPQxTLQTxtR3+TMz
 nlFf5XCyBOwgQtuXcS1P0+ZN80zBYeyRBw2ieAXata1neMcnrIg9TcU8pQqrAnxWK7km
 Udbo9UxEWZ9QLbsiaXFKm4toE7X0p8CZdT47re3+hBA2oaD337ivOHhAt+SV2PBw0BDP
 E2YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaHMdyzqkQ/cBPQFJLm+DjqoDVL2HCr5q2eJd7HCtGD24QY2aGN0z8R6v+hY2d2Ns0xgzw/7hS7NrTWh9RbkEnzrMbww==
X-Gm-Message-State: AOJu0YxWLqP0VBIjILbsDkOk1DD+mOa2F2qe1rm/40BglMWU4aILWmeZ
 byE+R4JY+u85fV1s6ENRPggmavABau7rMY8H03fYxD0y/lmaHAZM1qdyf+iShI+XXc7TetJyAzD
 g9E3FzDMaqwxZCEZL6mo7K7taVhydSRZKelc43MHU7lbiHuQYY961HaapCuldxqBuEc0=
X-Received: by 2002:adf:fe92:0:b0:34c:fd82:6b03 with SMTP id
 ffacd0b85a97d-35526c380bemr9325304f8f.19.1716915558033; 
 Tue, 28 May 2024 09:59:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzZbRMj0q/iVusa34EUClrjfObRgV1JV2vVyfa1NqACroeANyT5EQhfS/OiMESWLWcDCAvKA==
X-Received: by 2002:adf:fe92:0:b0:34c:fd82:6b03 with SMTP id
 ffacd0b85a97d-35526c380bemr9325289f8f.19.1716915557584; 
 Tue, 28 May 2024 09:59:17 -0700 (PDT)
Received: from ?IPV6:2a00:20:d00b:f75d:fdbe:9c2a:66b:5f2b?
 ([2a00:20:d00b:f75d:fdbe:9c2a:66b:5f2b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a090c20sm12147404f8f.62.2024.05.28.09.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 09:59:16 -0700 (PDT)
Message-ID: <ea4d7ee9-811b-4713-9fc1-f5084d8c2d05@canonical.com>
Date: Tue, 28 May 2024 18:59:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] efi_loader: allow concatenation with contained end
 node
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, Bin Meng
 <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
References: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
 <20240528144252.179247-2-heinrich.schuchardt@canonical.com>
 <CAC_iWjJFiSrPZveDDhX7wW9J-gBiTCUw2jXpw9MG_+K3nsGaEA@mail.gmail.com>
 <9bcf8dff-1c67-477c-b425-cbb79f5ecfc3@canonical.com>
 <CAC_iWjLwRsgWK33q76rwqg0ovE4h80SHZTjjUqPUsPMgdh7SbQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjLwRsgWK33q76rwqg0ovE4h80SHZTjjUqPUsPMgdh7SbQ@mail.gmail.com>
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

On 28.05.24 18:18, Ilias Apalodimas wrote:
> [...]
> 
>>>> -               unsigned sz2 = efi_dp_size(dp2);
>>>> +               size_t sz1;
>>>> +               size_t sz2 = efi_dp_size(dp2);
>>>>                   void *p;
>>>>
>>>> +               if (split_end_node < sizeof(struct efi_device_path))
>>>
>>> Can we be more explicit here pls? Someone might misuse this in the future
>>> split_end_node < =1 ? And we can document we can use values up to
>>> sizeof(struct efi_device_path) if we ever need extra functionality
>>
>> size_t split_end_node cannot be negative.
>>
>> The case split_end_node == 0 is handled below. What are you missing?
> 
> someone misusing it and passing a value of '3' for example and print
> an error if the value is
> 1 < value < sizeof(struct efi_device_path)

I would like to avoid over-engineering. How about

-               if (split_end_node < sizeof(struct efi_device_path))
+               if (split_end_node < 2)

and changing the function description to refer to >= 2?

Best regards

Heinrich

> 
> Thanks
> /Ilias
>>
>> Best regards
>>
>> Heinrich
>>
>>>
>>>> +                       sz1 = efi_dp_size(dp1);
>>>> +               else
>>>> +                       sz1 = split_end_node;
>>>> +
>>>>                   if (split_end_node)
>>>>                           end_size = 2 * sizeof(END);
>>>>                   else
>>>> diff --git a/lib/efi_loader/efi_device_path_utilities.c b/lib/efi_loader/efi_device_path_utilities.c
>>>> index c95dbfa9b5f..ac250bbfcc9 100644
>>>> --- a/lib/efi_loader/efi_device_path_utilities.c
>>>> +++ b/lib/efi_loader/efi_device_path_utilities.c
>>>> @@ -76,7 +76,7 @@ static struct efi_device_path * EFIAPI append_device_path(
>>>>           const struct efi_device_path *src2)
>>>>    {
>>>>           EFI_ENTRY("%pD, %pD", src1, src2);
>>>> -       return EFI_EXIT(efi_dp_concat(src1, src2, false));
>>>> +       return EFI_EXIT(efi_dp_concat(src1, src2, 0));
>>>>    }
>>>>
>>>>    /*
>>>> --
>>>> 2.43.0
>>>>
>>>
>>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>

