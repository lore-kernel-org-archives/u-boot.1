Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299EFD44141
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 11:02:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4F8E89547;
	Tue, 19 Nov 2024 12:01:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="F+ZSlI1Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9086789562; Tue, 19 Nov 2024 12:01:58 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83B9089538
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 12:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 15A7F3F2B1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 11:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732014116;
 bh=8vqGvoeFt0BIoTgR3FlQv/2dCtX8R28LhamALXw/M1U=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=F+ZSlI1YViojD6dcFOFddexI5BxVX7Ei25DWmigz75zxejzs5LC+5sXX3ngMJXCB+
 EmiTPMLRkBCipcwNbxgTbOAiMlXmIFfnvX4qfK2sAIqD7k4SAEYZs+MKBo6d0Gg2zC
 xJkP/0KLTxYyy80An4QwsJNC1ILRpUUAgtB2PHZfDDh6KocZz37OmJUURYZCDKMyKI
 J4Ocl5WBZiAPRd3QWpyuxV6UnzCM3Rq4LIFGxxtuDKjgH2k8bVQJvrTDJ9cX6Zm159
 WPNQCgFP1rLHTDv//Ma3AFyXpZ4g/WJeCoFwCbtTdZSYHgs228HnYEc5nrAnvjLVw6
 1OqmTWcuOIPRw==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4317391101aso22301865e9.2
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 03:01:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732014115; x=1732618915;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8vqGvoeFt0BIoTgR3FlQv/2dCtX8R28LhamALXw/M1U=;
 b=Vrhf0SGlQNWogbTXqbX2hZTdAMlzNyXEOeZQVX2wrML1DkG44HJeIVVOuRVFmjZMVt
 U7cXCM4EEDRis3nOGlzUsD12nrDCIPqmL6+2ktuBdDy09rwjkvFVv6VMFUOos6+CKyQk
 YCjM18J8Umk7nUkUx4bFVX3YNR49WQA0jie4hn5tN5BtlRa9UuOjEHfI5IgZFVW3dgu5
 RGRNSpKIEfYRLkyBlt5s7k68qJyqloRGTbQ2GCqL0Qrqo11Ikmq/Prk8E/OaDlWsy3rE
 nRqGCUDNO4zzdw/QJEaWRAxlfRSixEGB094gk4rngoQacEBPUPpqs4NctQ46kjGKHoMq
 PLfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfqkNvTw5jK2hkoAcXi3M8usoW4neD6oSwuDSsOqUprEzg+OMMcp7P7PIJBjMEcKGoSvt+wBY=@lists.denx.de
X-Gm-Message-State: AOJu0YwPyAXOikKDz4GsDFH+xva+FQVu5a8C0+FLmXUIICTziLzvTYdA
 of317DFRBZ1JsFpPL/ekCp6Juk/XA4eVQ4uHqK20nNJpLpc5iUaiTpsrCE9hdyquIJA0pq+9XYH
 gzHKhOtM54TBQX3yGt8iCFDvPH0TCF9Jvpkz3qHdw16jZY4aPhPpMJLz6e/AZUVzaMT8=
X-Received: by 2002:a05:600c:3acf:b0:431:50cb:2398 with SMTP id
 5b1f17b1804b1-432ebcd4989mr80283115e9.2.1732014115359; 
 Tue, 19 Nov 2024 03:01:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGqr5sDHmggdC+gCUMtEWJ2NO4yJWcw7dpsHvlS+Z0h/XsoNw7jeZfvFtQen3FwAKW7WivvA==
X-Received: by 2002:a05:600c:3acf:b0:431:50cb:2398 with SMTP id
 5b1f17b1804b1-432ebcd4989mr80282805e9.2.1732014114862; 
 Tue, 19 Nov 2024 03:01:54 -0800 (PST)
Received: from [192.168.103.101]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3824946166bsm5280687f8f.85.2024.11.19.03.01.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 03:01:54 -0800 (PST)
Message-ID: <1d1dfec4-0549-4094-82a2-463310241a95@canonical.com>
Date: Tue, 19 Nov 2024 12:01:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/14] efi_loader: device_path: add efi_dp_from_ipv4
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Adriano Cordova <adrianox@gmail.com>, joe.hershberger@ni.com,
 rfried.dev@gmail.com, jerome.forissier@linaro.org, u-boot@lists.denx.de
References: <20241118210908.51196-1-adrianox@gmail.com>
 <20241118210908.51196-4-adrianox@gmail.com>
 <eed3b936-a54d-4881-8f2e-534bcef34535@canonical.com>
 <CAC_iWjKYyZq5DCMdaZoa8K9ySLYwqxjWaySepep6hamLdVBK9A@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjKYyZq5DCMdaZoa8K9ySLYwqxjWaySepep6hamLdVBK9A@mail.gmail.com>
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

On 19.11.24 11:34, Ilias Apalodimas wrote:
> On Tue, 19 Nov 2024 at 11:50, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 18.11.24 22:08, Adriano Cordova wrote:
>>> Add efi_dp_from_ipv4 to form a device path from an ipv4 address.
>>>
>>> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
>>> ---
>>>
>>> Changes in v4:
>>> - Fixed memcpy mistake
>>>
>>> Changes in v3:
>>> - Removed some unnecessary void* casts.
>>> - Changed sizeof(struct efi_device_path_ipv4) to sizeof(*ipv4dp)
>>>     in efi_dp_from_ipv4.
>>>
>>>    lib/efi_loader/efi_device_path.c | 38 ++++++++++++++++++++++++++++++++
>>>    1 file changed, 38 insertions(+)
>>>
>>> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
>>> index ee387e1dfd..cdeea4791f 100644
>>> --- a/lib/efi_loader/efi_device_path.c
>>> +++ b/lib/efi_loader/efi_device_path.c
>>> @@ -974,6 +974,44 @@ struct efi_device_path __maybe_unused *efi_dp_from_eth(void)
>>>        return start;
>>>    }
>>>
>>
>> A function description is missing.
>>
>>> +struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
>>> +                                      struct efi_ipv4_address *mask,
>>> +                                      struct efi_ipv4_address *srv)
>>> +{
>>> +     struct efi_device_path *dp1, *dp2;
>>> +     efi_uintn_t ipv4dp_len;
>>> +     struct efi_device_path_ipv4 *ipv4dp;
>>> +     char *pos;
>>> +
>>> +     ipv4dp_len = sizeof(*ipv4dp);
>>> +     ipv4dp = efi_alloc(ipv4dp_len + sizeof(END));
>>
>> ipv4dp is a small structure and is freed below.
>> Allocating it on the stack would reduce the code size.
>>
>>> +     if (!ipv4dp) {
>>> +             log_err("Out of memory\n");
>>
>> Writing messages inside a protocol implementation should be avoided.
>>
>>> +             return NULL;
>>> +     }
>>> +
>>> +     ipv4dp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
>>> +     ipv4dp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_IPV4;
>>> +     ipv4dp->dp.length = ipv4dp_len;
>>> +     ipv4dp->protocol = 6;
>>> +     if (ip)
>>> +             memcpy(&ipv4dp->local_ip_address, ip, sizeof(*ip));
>>> +     if (mask)
>>> +             memcpy(&ipv4dp->subnet_mask, mask, sizeof(*mask));
>>> +     if (srv)
>>> +             memcpy(&ipv4dp->remote_ip_address, srv, sizeof(*srv));
>>> +     pos = (void *)(uintptr_t)ipv4dp + ipv4dp_len;
>>
>> Here you
>>
>> 1 - convert ipv4dp to uintptr_t
>> 2 - convert the uintptr_t value to void *
>> 3 - add an offset to the void * value
>>
>> In the C standard adding an offset to a void * value results in
>> undefined behavior. Unfortunately U-Boot code uses it a lot.
> 
> It's a known support gcc extension that treats void* similar to char*.
> Do you think it's worth changing all of the call sites we have?

No, I don't request this. But as pos is already char*, we should not use 
void* here.

Best regards

Heinrich

>>
>> pos = (char *)ipv4dp + ipv4dp_len;
>>
>> is all it takes to have a defined behavior here.
>>
>> Best regards
>>
>> Heinrich
>>
>>> +     memcpy(pos, &END, sizeof(END));
>>> +
>>> +     dp1 = efi_dp_from_eth();
>>> +     dp2 = efi_dp_concat(dp1, (const struct efi_device_path *)ipv4dp, 0);
>>> +
>>> +     efi_free_pool(ipv4dp);
>>> +     efi_free_pool(dp1);
>>> +
>>> +     return dp2;
>>> +}
>>> +
>>>    /* Construct a device-path for memory-mapped image */
>>>    struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
>>>                                        uint64_t start_address,
>>

