Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA4CC04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 13:08:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BD3E88223;
	Tue, 14 May 2024 15:08:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qs4fhe0o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9D6A88223; Tue, 14 May 2024 15:08:32 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8AC088308
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 15:08:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3CAFE41204
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 13:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1715692109;
 bh=0hnD9518iHuiHD5Ay7kNO3cgPp9sM1HxY1VIeCs9RJQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=qs4fhe0oLaB4dK3aMUUn3wrwgtgbHwUEdA3mjxTipZpIAeOMn1kKUPXy5JaVAXtqK
 Uhux6k+XxJgnhXBoxZeidE9GufG7E0vFlTOM9Sjhy5zTCsJMCokhdLuRkh4YHNXF/k
 VGFMqVbnqPyhn0uAA29Fq/Xx61xcPEVKujg73ob6v6MJhUVEFr1IWFYqnSeHkrd+mq
 Jp48EZAqltYtXbJozbZoAkDUvVmKjZDtZ6QfHYDOR0pyKs1DJDNIpQaw4ALSMbGKYJ
 DCxkpPgVzX8j3kiMVbnA1xltXvRhBLp93qYln57K4uJqrvSw1K8PVYqKmI8SYSCjbK
 UjFWSAXA6Tyhw==
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a59ad2436f8so349287966b.2
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 06:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715692108; x=1716296908;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0hnD9518iHuiHD5Ay7kNO3cgPp9sM1HxY1VIeCs9RJQ=;
 b=aWqwbRigqmVuvOVCOD44zTZw52uNgmNQOJgBGQED4HqIrObrREXnPDF49Nrv1Y8/+1
 jhLrThOr//OWCY36gy5Q2VJtL4hmoko0Ado/3ytsGqUXAqAiOyPiaIukJ1CHKwBWiIo2
 dE0stccymcpFjfVNw5pikRrggC3BX2suOuM7NCJdRrIrANQ/7ID7h9rTk2Lfwddy1RqM
 P+JQguRfg13khfWckGhR0vP2Kd97dWC/9qUCrbr7xNNj5jfZejKG+o8zX89ovwo0KEC0
 UH0RF6tyNrvIL+uwWPB7OfcOC2j/o4fgN88DkA4ewyWaBrbtnsFxSe7w2iG6hGR6Meno
 PaBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUbjIHqv0QjdcakAvmRE8p6Goj4fg6ng2r9KiXZy0cH00tZ4aq54X84xwRImbq6UB/gSQSHNXVTc2i7WuEfyUBkrUJzQ==
X-Gm-Message-State: AOJu0YyTPA7A1maZDbq37VgDRHIvQYJRV6Ili7/EoD+w6DoT+9pj6rIe
 IGGOhu8B/idzTC459+Ye9YB3xy08aRZMuaerHnRGLUXHCgdXV8W3mT0q/4YPX3Gd4d2u3Q3lN3x
 6jqbyEg3DzfL3XSkaxdcmIeP7JSNWjKQaRX/dnvL7sm1NvaiAmosuUXGGuNjPWiIK3ts=
X-Received: by 2002:a17:906:fada:b0:a59:cb29:3fb5 with SMTP id
 a640c23a62f3a-a5a2d572af8mr813716166b.20.1715692108505; 
 Tue, 14 May 2024 06:08:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS1v00DvQegzvcaKxdFKh/sEo2ieC9DxtEfA8B198hjVCrrO50M/rD5GjJCknt1aeF3PwIJQ==
X-Received: by 2002:a17:906:fada:b0:a59:cb29:3fb5 with SMTP id
 a640c23a62f3a-a5a2d572af8mr813714266b.20.1715692108089; 
 Tue, 14 May 2024 06:08:28 -0700 (PDT)
Received: from [10.55.2.71] ([149.11.192.251])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a691870absm263817266b.124.2024.05.14.06.08.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 06:08:27 -0700 (PDT)
Message-ID: <4b2fa591-40da-4a4c-ab0e-8d168545195c@canonical.com>
Date: Tue, 14 May 2024 15:08:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 02/14] efi_loader: library function efi_dp_merge
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, trini@konsulko.com,
 i@shantur.com, bmeng@tinylab.org, akashi.tkhro@gmail.com,
 kojima.masahisa@socionext.com, raymond.mao@linaro.org, kettenis@openbsd.org,
 jmcosta944@gmail.com, u-boot@lists.denx.de
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
 <20240426141321.232236-3-heinrich.schuchardt@canonical.com>
 <CAC_iWjKg9NDKnoNa-V+H+5OOJe2uYsHb0vXM0+-QdCxUctiksg@mail.gmail.com>
 <aac7887b-b123-4006-bbcd-4549e8e44a54@canonical.com>
 <CAC_iWjL4umEBcEkZtjeWgfnrHV3oB3qECD0xYAY6qjphKb4umg@mail.gmail.com>
 <a17e0a7e-8269-4d1d-aaaa-a944655b90f4@canonical.com>
 <87ikzgft2q.fsf@bloch.sibelius.xs4all.nl>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <87ikzgft2q.fsf@bloch.sibelius.xs4all.nl>
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

On 5/14/24 14:58, Mark Kettenis wrote:
>> Date: Tue, 14 May 2024 14:49:47 +0200
>> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> 
> Hi Heinrich,
> 
>> On 4/26/24 17:47, Ilias Apalodimas wrote:
>>> Hi Heinrich
>>>
>>> On Fri, 26 Apr 2024 at 17:53, Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> On 26.04.24 16:30, Ilias Apalodimas wrote:
>>>>> Hi Heinrich,
>>>>>
>>>>> On Fri, 26 Apr 2024 at 17:13, Heinrich Schuchardt
>>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>>
>>>>>> Provide a function to append a device_path to a list of device paths
>>>>>> that is separated by final end nodes.
>>>>>>
>>>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>>>> ---
>>>>>>     include/efi_loader.h             |  3 +++
>>>>>>     lib/efi_loader/efi_device_path.c | 31 +++++++++++++++++++++++++++++++
>>>>>>     2 files changed, 34 insertions(+)
>>>>>>
>>>>>> diff --git a/include/efi_loader.h b/include/efi_loader.h
>>>>>> index 9600941aa32..a7d7b8324f1 100644
>>>>>> --- a/include/efi_loader.h
>>>>>> +++ b/include/efi_loader.h
>>>>>> @@ -944,6 +944,9 @@ struct efi_load_option {
>>>>>>
>>>>>>     struct efi_device_path *efi_dp_from_lo(struct efi_load_option *lo,
>>>>>>                                           const efi_guid_t *guid);
>>>>>> +struct efi_device_path *efi_dp_merge(const struct efi_device_path *dp1,
>>>>>> +                                    efi_uintn_t *size,
>>>>>> +                                    const struct efi_device_path *dp2);
>>>>>>     struct efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
>>>>>>                                          const struct efi_device_path *dp2,
>>>>>>                                          bool split_end_node);
>>>>>> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
>>>>>> index 46aa59b9e40..16cbe41d32f 100644
>>>>>> --- a/lib/efi_loader/efi_device_path.c
>>>>>> +++ b/lib/efi_loader/efi_device_path.c
>>>>>> @@ -270,6 +270,37 @@ struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp)
>>>>>>            return ndp;
>>>>>>     }
>>>>>>
>>>>>> +/**
>>>>>> + * efi_dp_merge() - Concatenate two device paths separated by final end node
>>>>>> + *
>>>>>> + * @dp1:       first device path
>>>>>> + * @size:      pointer to length of @dp1, total size on return
>>>>>> + * @dp2:       second device path
>>>>>> + *
>>>>>> + * Return:     concatenated device path or NULL
>>>>>> + */
>>>>>> +struct efi_device_path *efi_dp_merge(const struct efi_device_path *dp1,
>>>>>> +                                    efi_uintn_t *size,
>>>>>> +                                    const struct efi_device_path *dp2)
>>>>>> +{
>>>>>> +       efi_uintn_t len, len1, len2;
>>>>>> +       struct efi_device_path *dp;
>>>>>> +       u8 *p;
>>>>>> +
>>>>>> +       len1 = *size;
>>>>>> +       len2 = efi_dp_size(dp2) + sizeof(END);
>>>>>> +       len = len1 + len2;
>>>>>> +       dp = efi_alloc(len);
>>>>>> +       if (!dp)
>>>>>> +               return NULL;
>>>>>> +       memcpy(dp, dp1, len1);
>>>>>> +       p = (u8 *)dp + len1;
>>>>>> +       memcpy(p, dp2, len2);
>>>>>> +       *size = len;
>>>>>
>>>>> Can't we just use efi_dp_concat()?
>>>>
>>>> efi_dp_concat cannot be used to put a device-path end-node in between
>>>> two device-paths that are concatenated. We need that separator in the
>>>> load options.
>>>
>>> I am not sure I am following you. It's been a few years so please bear
>>> with me until I manage to re-read that code and page it back to
>>> memory.
>>>
>>> What I remember though is that the format of the DP looks like this:
>>>
>>> Loaded image DP - end node - initrd GUID DP (without and end node) -
>>> initrd - end of device path.
>>> So to jump from the special initrd GUID to the actual DP that contains
>>> the initrd you need to do an efi_dp_next(). Also, efi_dp_concat() will
>>> inject an end node with a DEVICE_PATH_SUB_TYPE_END type if the third
>>> argument is 'true'.
>>>
>>> What am I missing?
>>
>> Let us assume
>>
>> dp1 = /vmlinux/endnode/initrd/endnode
>> dp2 = /dtb/endnode
>>
>> and we invoke dp_concat(dp1, dp2, true):
>>
>> sz1 is calculated via the efi_dp_size() function which looks for the
>> *first* device-path end node.
>>
>> sz1 = efi_dp_size(dp1) = sizeof(/vmlinux)
>>
>> sz1 will not include initrd and its endnode.
>>
>> So dp_concat(/vmlinux/endnode/initrd/endnode, /dtb/endnode, true)
>> will return:
>>
>> /vmlinux/endnode/dtb/endnode
>>
>> but in our boot option we want
>>
>> /vmlinux/endnode/initrd/endnode/dtb/endnode
> 
> That makes me realize a potential flaw with the design of this boot
> option.  The concept of an initrd is Linux-specific, but the concept
> of loading a DTB to pass along to an EFI image far less so.  So how
> would this work if I want to only pass the DTB?  Would that be:
> 
> /vmlinux/endnode/endnode/dtb/endnode

Hello Mark,

We have a VenMedia() device path node with specific GUIDs for initrd and 
dtb prefixed to these paths. See patch 03/14.

We don't rely on the position. So in your case:

/vmlinux/endnode/dtb/endnode

where the device path 'dtb' would consist of multiple nodes, e.g.:

VenMedia(EFI_FDT_GUID)/HD(1,GPT, ...)/\dir\filename.dtb

Best regards

Heinrich

> 
> ?

