Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C96BCDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 15:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A04984704;
	Thu, 25 Jun 2026 17:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="j9tuxKJH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61AAD847C8; Thu, 25 Jun 2026 17:23:46 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B23238460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 17:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 49CF03F97C
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 15:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782401023;
 bh=KzxFiUp95hhgRsNZnopP9BC7eCnCTsmgzq2HiTr1eXI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=j9tuxKJHgnmldq/ioUl2qd8aC2VZyfdmofaGLHMKK343u7q7pJpaDUzgh/De5oVsS
 PO8O/Cc+YGJiD2lcHszNATzyRNuYWjx33mNEzveolcVID5A6ncFy+tmPXUPml3TtK8
 gvHShLDxMo8LH8EfK5BmQj77EdjJK8HnjXQkyHK5Yev3sSXjOh/6THEJq5x50ArOxJ
 1QZFhigoSYcpAahAtLx19jJmeMAXbUTDT+y29dEG9IixARaBbsDuATwqz8QSRPM1Et
 CT0Zmb8AwvRIrlUmboxBw26QbkI52LHXwrRCGAfvyvr3HC850hbm8uTyNmrQ2QiQih
 R+BdDPUkeFJuArnn6FzdTwn3gDw/BdbaHPf2IEgnNZ1NCNU7VKcC2h5mqicHjfEEAO
 4an3v8dPS8lemVSqtSrf1AJrPqCSSz8PIswQgEIYRuy8aeFvZNNORtbeB6UsCcToSl
 hCs2+WTIe5vnRkm60RkMYJWluDyZRu4t9StMqM9v+NbPsfxsxypoobQsC7Duz42lFT
 D055u5O7N2G30B4cL0yzKgAO3zGtX5VGfC01PtUMg9q0OKZK9MwOTDB4hr+HE/RD9X
 pCNcD8pPSol0x7sONGqWo7GiAa8zXNN2vVtrS3R/rBM4bdadUZVda2RpgCMCUFW2wS
 4gmSSMhKMg3qF9Myik+QpLMM=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49221de4ed4so18947305e9.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 08:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782401023; x=1783005823;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KzxFiUp95hhgRsNZnopP9BC7eCnCTsmgzq2HiTr1eXI=;
 b=X3JQH5IzXUgLelkhSE7eGw9FHibPIQ7V5m6v5Vi+qQp2aXpzGR4Ji3lNURuwkmeNvD
 4t1GUUtACYQSB7F0BSvIk6BBUePyg+Fxd7ItrQ2fIbbTDEedVzpJPBxBZsV0K2azNvxf
 vr/FO8Xg+dPLQgKdQCAftWj2uuss10/zJImylJ024icl6oEztpipHEOf8UXh/a8IptMb
 ijAJhiqdNB9AhWRUZv2CA7tBzIPAYl211mt+jUnwMC667U1Sci8cUXieJXurkcG8UHJc
 ykjKrteDXWe9fY9b+/gr79yb656JCtsMGi5JkLwjW7ywEOfnwM9GJFZEG5j2YfB4vuSS
 8AuQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp7px6UyihZpd0uGiX7I8Ik2pN3FebbmcRfkEL2asWl4gT0O1qw+yhf3G8LtbzTguyxIDdbjBQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2tZziFtc4+uc/a7Zo3K4VHCwZ5nCV0HIO5U4BeSjwSjq8UUXl
 +gAf24tXOSWiTZtlwJ1evb2tceg/aERQTDZrvnXAYPaAjPAZhtdxWCqa1ePCCXjDR7PUXI+lAux
 HRZCcewztoClxuxWw9P/+bZIfdwWdmB2xknaZ2we08L+YIFukELFbaZNVcHV30Spfq5HsujM=
X-Gm-Gg: AfdE7ckucbWQDYU/nG4E5gjngZrTYGGOW0YhaSJORpZFFnN227ZHMUQBxbvqZRDUxrE
 WrnOT339AzTY6SetzEKS+9O2nIwvej9CdhmaFgvd1T7qY5+KILSaf929a/5o4fo8j8oO+MMp8X6
 rZ1eAjP8MFHRvdroNBRNRuNcFkqoFjfKEoHrsYpkH7udYa5lKgwgenNd2rdupl328H+Qf+XOYmW
 8ySDnzPwYskw8BS/238igdmao+khuEhi6n8EGh0l5LeMH9DgNF2oF1aBkM9x3KTgFJTbGnpdnVD
 PemQwgPJEM5a7e4E+bj+PC821MLw2LXrZFAybRtUxVbHTts33Ek1NA+IfLAzvrak2EoWnFT7o/J
 IcxJy1haREhr1Gd+7gce3y5dfwrh4gVw5jR2GZsBex9JR2QoWfZ3yjz3cDyg5QnnrTlgd9TkQgL
 Ngv+HfT/vQaD1n61fMuZoenitHg6g8jbc=
X-Received: by 2002:a05:600c:c118:b0:492:6881:1114 with SMTP id
 5b1f17b1804b1-49268811131mr14282805e9.0.1782401022793; 
 Thu, 25 Jun 2026 08:23:42 -0700 (PDT)
X-Received: by 2002:a05:600c:c118:b0:492:6881:1114 with SMTP id
 5b1f17b1804b1-49268811131mr14282425e9.0.1782401022457; 
 Thu, 25 Jun 2026 08:23:42 -0700 (PDT)
Received: from ?IPV6:2a02:3035:680:3cd0:eb7a:e4f7:31a:bcfb?
 ([2a02:3035:680:3cd0:eb7a:e4f7:31a:bcfb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492690a1a85sm6988145e9.15.2026.06.25.08.23.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2026 08:23:41 -0700 (PDT)
Message-ID: <fa63ad61-57e8-4302-a3f9-a3dd86d07db3@canonical.com>
Date: Thu, 25 Jun 2026 17:23:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] efi_selftest: add ACPI configuration table test
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
 <20260621081915.19154-3-heinrich.schuchardt@canonical.com>
 <CAFLszTiu0HSZ4JJ7ggMMAk4oe0-h=Xq-Wnw=hqwGr80wBdrGXQ@mail.gmail.com>
 <e262d779-4854-4360-8d9a-a91ff76b5347@canonical.com>
 <CAFLszTj7D-q5QtKTDX07t529wS+hfUUjEq2vK+6rJF9psC8KGw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTj7D-q5QtKTDX07t529wS+hfUUjEq2vK+6rJF9psC8KGw@mail.gmail.com>
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

On 6/25/26 16:55, Simon Glass wrote:
> Hi Heinrich,
> 
> On Thu, 25 Jun 2026 at 12:26, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 6/25/26 10:52, Simon Glass wrote:
>>> Hi Heinrich,
>>>
>>> On 2026-06-21T08:19:04, Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>> efi_selftest: add ACPI configuration table test
>>>>
>>>> The new unit test checks if ACPI tables are available.
>>>>
>>>> If yes, it checks if the RSDP correctly points to the RSDT or XSDT.
>>>>
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>>
>>>> lib/efi_selftest/Makefile            |   1 +
>>>>    lib/efi_selftest/efi_selftest_acpi.c | 138 +++++++++++++++++++++++++++++++++++
>>>>    2 files changed, 139 insertions(+)
>>>
>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>
>>>> diff --git a/lib/efi_selftest/efi_selftest_acpi.c b/lib/efi_selftest/efi_selftest_acpi.c
>>>> @@ -0,0 +1,138 @@
>>>> +     if (!checksum_ok(rsdp, 20)) {
>>>> +             efi_st_error("Invalid RSDP checksum\n");
>>>> +             return EFI_ST_FAILURE;
>>>> +     }
>>>
>>> Please avoid the magic 20 - how about offsetof(struct acpi_rsdp,
>>> length) or a named constant?
>>>
>>> Regards,
>>> Simon
>>
>> Thank you for reviewing.
>>
>> 20 is not an offset. It is the length of the ACPI 1.0 RSDP header.
> 
> ...which is the offset of the length field. See the struct:
> 
> struct __packed acpi_rsdp {
>     char signature[8];   /* RSDP signature */
>     u8 checksum;      /* Checksum of the first 20 bytes */
>     char oem_id[6];      /* OEM ID */
>     u8 revision;      /* 0 for ACPI 1.0, others 2 */
>     u32 rsdt_address;   /* Physical address of RSDT (32 bits) */
>     u32 length;      /* Total RSDP length (incl. extended part) */
>     u64 xsdt_address;   /* Physical address of XSDT (64 bits) */
>     u8 ext_checksum;   /* Checksum of the whole table */
>     u8 reserved[3];
> };
> 
> The original struct ended with rsdt_address as the final field. Then
> they added a length and some more information. So the offset of
> 'length' is actually what you want.
> 
> My failure to use offsetof() was probably just that I didn't know it
> existed, or perhaps because some of the code came from coreboot.

The field length does not exist in ACPI 1.0. So it does not make any 
sense to relate to it for calculating the checksum field.

> 
>>
>> Below is the precedent that Bin and you have been setting:
>>
>> arch/x86/lib/acpi.c:18: if (table_compute_checksum((void *)rsdp, 20) != 0)
>> drivers/misc/qfw_acpi.c:310:    rsdp->checksum =
>> table_compute_checksum(rsdp, 20);
>> lib/acpi/base.c:36:     rsdp->checksum = table_compute_checksum(rsdp, 20);
>> test/dm/acpi.c:371:     ut_assertok(table_compute_checksum(rsdp, 20));
> 
> Yes, this is quite common. How about declaring a constant for it?

That is beyond the scope of this series. It has enough patches.

Let's do it separately.

Best regards

Heinrich
