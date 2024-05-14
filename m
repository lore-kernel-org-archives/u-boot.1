Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67C8C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 12:49:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AE0A880C5;
	Tue, 14 May 2024 14:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hPl6Ji5H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07B9388229; Tue, 14 May 2024 14:49:55 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD508880A7
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 14:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 358F63F5F4
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 12:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1715690991;
 bh=5LNW3YinwCj1wphN8T6bicb+LhDXBk0J66bJoiGaLG0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=hPl6Ji5HfTRnGU7Dd2xMvBrVhb5ku+3BauhvlX8IjkR7FLjmEtuupuR3NlUqEobbw
 2VraQeRSh78PP34b1RcoH7CyoKul8xU2/EO/TVCNq2NhJWc+SyXFWLfGAkBptVlGqY
 sixjKvLmVUFNuji32uRtnNYfecLFKiR68t0y/A4U44s/tgu2YR/ANzGJ01BzqjOd0W
 PJv+BbpDxxvsIq0RuPYS58NYrfSerIVdLJsa6Daix/m1fXhAtyQiuZkwg2Fu9w9DkE
 iImWYG1bFXUSvOXSkpsaLH2EIgsQnkX+NKNKZ6ZTk/cScq4jSgT1GXmCNEwOLd2ACv
 Od80yYcL+tEAQ==
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a599dbd2b6aso321828066b.2
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 05:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715690990; x=1716295790;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5LNW3YinwCj1wphN8T6bicb+LhDXBk0J66bJoiGaLG0=;
 b=E/zkCs7ArGgOG63f7LPds7FoePIKw+YJj05zOX/qS1EouoLIY0RBlk4+Iv74qTBDib
 9QOTAvINxd6JBNfavXF+PZye1nu3aSRuOR9/JQ7fvfUsqQQRhk+9zR2BrOsmSC1YZ0I7
 gza3e++KWQBiVrBsWl8NzgBUT89Zk0bqjr7FAsoyb/8mQoLucIRVw/NppOzy+b4yCqyo
 lsJIZdEOM94y2Cznfwu9/Bv2w3VSUFaLS/BtGlegPe4fwoBef5pz3MgwRYeQDIdlUGsk
 FTaOyz6pnbEqJOOr+MUv8N5O5qsk8AwRp0jAF8dR0kQxuO2mk9i8sSApYCC+Oz3A2YNr
 tjmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP8U5uCqICW1C8FLxFQgS78MH18u4EQKEZ6/x8M5Xza7NqiEE8RILktsulLvoVeaK/5ipzLv+EPNljxIwZ9OfLT9entw==
X-Gm-Message-State: AOJu0YxF4dqS73S8z+chsnhy5z0EWnpLMcb9YQ3ZY62As5uHRgcLul0O
 O97dkkkOdxUAyYMo1WQScBamItTjflgkB4TkN4p5CfBbuPQw35qn62sqX12rD0EPAyEg9rBLhvc
 yfdtZCBfQD9APu98uVc4DqiKe8xrgUtbtLyx8qIvY7nUyuTxnOChIHvn/xClmVDlrUqI=
X-Received: by 2002:a17:906:560a:b0:a59:ca7e:e24 with SMTP id
 a640c23a62f3a-a5a2d641767mr846686666b.53.1715690990265; 
 Tue, 14 May 2024 05:49:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtXsTVjroPL5izuFMYudcv00gGIqp1NBRresk+CoCN2KtSmmNF2eUcHqvsyS8szZpiANkfVw==
X-Received: by 2002:a17:906:560a:b0:a59:ca7e:e24 with SMTP id
 a640c23a62f3a-a5a2d641767mr846685266b.53.1715690989834; 
 Tue, 14 May 2024 05:49:49 -0700 (PDT)
Received: from [10.55.2.71] ([149.11.192.251])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b17d10sm717034166b.198.2024.05.14.05.49.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 05:49:49 -0700 (PDT)
Message-ID: <a17e0a7e-8269-4d1d-aaaa-a944655b90f4@canonical.com>
Date: Tue, 14 May 2024 14:49:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 02/14] efi_loader: library function efi_dp_merge
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
 <20240426141321.232236-3-heinrich.schuchardt@canonical.com>
 <CAC_iWjKg9NDKnoNa-V+H+5OOJe2uYsHb0vXM0+-QdCxUctiksg@mail.gmail.com>
 <aac7887b-b123-4006-bbcd-4549e8e44a54@canonical.com>
 <CAC_iWjL4umEBcEkZtjeWgfnrHV3oB3qECD0xYAY6qjphKb4umg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjL4umEBcEkZtjeWgfnrHV3oB3qECD0xYAY6qjphKb4umg@mail.gmail.com>
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

On 4/26/24 17:47, Ilias Apalodimas wrote:
> Hi Heinrich
> 
> On Fri, 26 Apr 2024 at 17:53, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 26.04.24 16:30, Ilias Apalodimas wrote:
>>> Hi Heinrich,
>>>
>>> On Fri, 26 Apr 2024 at 17:13, Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> Provide a function to append a device_path to a list of device paths
>>>> that is separated by final end nodes.
>>>>
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> ---
>>>>    include/efi_loader.h             |  3 +++
>>>>    lib/efi_loader/efi_device_path.c | 31 +++++++++++++++++++++++++++++++
>>>>    2 files changed, 34 insertions(+)
>>>>
>>>> diff --git a/include/efi_loader.h b/include/efi_loader.h
>>>> index 9600941aa32..a7d7b8324f1 100644
>>>> --- a/include/efi_loader.h
>>>> +++ b/include/efi_loader.h
>>>> @@ -944,6 +944,9 @@ struct efi_load_option {
>>>>
>>>>    struct efi_device_path *efi_dp_from_lo(struct efi_load_option *lo,
>>>>                                          const efi_guid_t *guid);
>>>> +struct efi_device_path *efi_dp_merge(const struct efi_device_path *dp1,
>>>> +                                    efi_uintn_t *size,
>>>> +                                    const struct efi_device_path *dp2);
>>>>    struct efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
>>>>                                         const struct efi_device_path *dp2,
>>>>                                         bool split_end_node);
>>>> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
>>>> index 46aa59b9e40..16cbe41d32f 100644
>>>> --- a/lib/efi_loader/efi_device_path.c
>>>> +++ b/lib/efi_loader/efi_device_path.c
>>>> @@ -270,6 +270,37 @@ struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp)
>>>>           return ndp;
>>>>    }
>>>>
>>>> +/**
>>>> + * efi_dp_merge() - Concatenate two device paths separated by final end node
>>>> + *
>>>> + * @dp1:       first device path
>>>> + * @size:      pointer to length of @dp1, total size on return
>>>> + * @dp2:       second device path
>>>> + *
>>>> + * Return:     concatenated device path or NULL
>>>> + */
>>>> +struct efi_device_path *efi_dp_merge(const struct efi_device_path *dp1,
>>>> +                                    efi_uintn_t *size,
>>>> +                                    const struct efi_device_path *dp2)
>>>> +{
>>>> +       efi_uintn_t len, len1, len2;
>>>> +       struct efi_device_path *dp;
>>>> +       u8 *p;
>>>> +
>>>> +       len1 = *size;
>>>> +       len2 = efi_dp_size(dp2) + sizeof(END);
>>>> +       len = len1 + len2;
>>>> +       dp = efi_alloc(len);
>>>> +       if (!dp)
>>>> +               return NULL;
>>>> +       memcpy(dp, dp1, len1);
>>>> +       p = (u8 *)dp + len1;
>>>> +       memcpy(p, dp2, len2);
>>>> +       *size = len;
>>>
>>> Can't we just use efi_dp_concat()?
>>
>> efi_dp_concat cannot be used to put a device-path end-node in between
>> two device-paths that are concatenated. We need that separator in the
>> load options.
> 
> I am not sure I am following you. It's been a few years so please bear
> with me until I manage to re-read that code and page it back to
> memory.
> 
> What I remember though is that the format of the DP looks like this:
> 
> Loaded image DP - end node - initrd GUID DP (without and end node) -
> initrd - end of device path.
> So to jump from the special initrd GUID to the actual DP that contains
> the initrd you need to do an efi_dp_next(). Also, efi_dp_concat() will
> inject an end node with a DEVICE_PATH_SUB_TYPE_END type if the third
> argument is 'true'.
> 
> What am I missing?

Let us assume

dp1 = /vmlinux/endnode/initrd/endnode
dp2 = /dtb/endnode

and we invoke dp_concat(dp1, dp2, true):

sz1 is calculated via the efi_dp_size() function which looks for the 
*first* device-path end node.

sz1 = efi_dp_size(dp1) = sizeof(/vmlinux)

sz1 will not include initrd and its endnode.

So dp_concat(/vmlinux/endnode/initrd/endnode, /dtb/endnode, true)
will return:

/vmlinux/endnode/dtb/endnode

but in our boot option we want

/vmlinux/endnode/initrd/endnode/dtb/endnode

I introduced an new function efi_dp_merge().
Instead we could change the arguments to:


* @sz1:
* * 0 to concatenate
* * 1 to concatenate with end node added as separator
* * size of dp1 excluding last end node to concatenate with end node as
*   separator in case dp1 contains an end node
struct
efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
                                const struct efi_device_path *dp2,
                                size_t sz1)

and replace

sz1 = efi_dp_size(dp1);

by

if (sz1 < sizeof(struct efi_device_path)
	sz1 = efi_dp_size(dp1);

Best regards

Heinrich

> 
> Thanks
> /Ilias
> 
>>
>> Best regards
>>
>> Heinrich
>>
>>>
>>> Thanks
>>> /Ilias
>>>> +
>>>> +       return dp;
>>>> +}
>>>> +
>>>>    /**
>>>>     * efi_dp_concat() - Concatenate two device paths and add and terminate them
>>>>     *                   with an end node.
>>>> --
>>>> 2.43.0
>>>>
>>

