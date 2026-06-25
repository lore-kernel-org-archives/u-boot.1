Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7C5CDE008
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 11:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DDD484704;
	Thu, 25 Jun 2026 13:26:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="EUFQkXj0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7350B84894; Thu, 25 Jun 2026 13:26:49 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55A088460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 13:26:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 04A163F6ED
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 11:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782386807;
 bh=M2O1gr96cya+YbH6z9cRN1RX32bK1wLRlISNO08qfDg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=EUFQkXj0ZluD7cIt0rghjKIlohexQ+IQwVkj8yu5Mgt6p2D2k9K20CLydKd1Mi4vr
 d6b9yfyY/MZnPB52uYIqV6vY9mNPbPAxCPvivdgs0DqW1DkZfDfMmQnNKzpkb9R5II
 rztPMEKMzJsEi11LIIwIKDQcPW4YGUk+4hzkena+StiA3B285B22PL1InfnFhOWaZJ
 gHxup8zuRfa2b57gHI/3POz42XMcqmbI2o7Z94dlIImzmihs24F6uQMr0gJXGFGp9G
 8+igMdfp3yYFt/vUbBl/nW96OFn74KCbI4B2Uq9JfGaLr8cDKhBcxUn8HAb8V0EX5P
 blwnfL8KKpixEEnrPIiYa4KJp53zjqYFCyQYRtDB9QdGvwSaxLBUSNLVLR/POOfKgD
 tripFIyjX+/0+T6NR2TDiwf4/Rt/btXd0hXJiN2Bi2PQqbGq2hEA0IC1k6YNwPyZFm
 gU7zLU1lAypKcyDfvLbH8md/1X8wbtuzpKvotkXYmyJxdBsDL8Wj//y1zgCuG3ETFK
 G+c+lXt3b2Uq84m8y0Ol/zhPoa22PeKEOKEVGOtdT2buup00/b8ek8SNSLXgNekeu7
 ysFrQgUO9YPkT3RMzLFDMI8VyA4NyuYgR9XjgtO/VPHImU5mg6vWNpcnPiPj1xO6JP
 2J6ki7nAntQx5zKwvPTA0hvU=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490ace40f13so9444545e9.3
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 04:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782386806; x=1782991606;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M2O1gr96cya+YbH6z9cRN1RX32bK1wLRlISNO08qfDg=;
 b=UdX/CILnYxkoy6o/qgD8s/def71s1wnMmTfRf2rgS6IVUQ6OebyZqjf1XicPgMeVTV
 ZrYKC6ZkkqGD4MQuKDw4t0Eevke2Fd2U1H1FxssSCVa/WNItTczTLcHs0jHXNyKClZHY
 p6AV0ZRl1FukOieRADZeyUPRgksmw6HsUAXd1aBFE8wHfVau9KE7tbYZio8W2UqoHx38
 yLnkqj6XtYAQGgCqhVI4GXXhMDL1940w8gk9+Kw7U6GJCDv2H9HhJ2UONWO/uZBHxqKJ
 9QpOLB6WLhPb92D1aOB2bPUtC3VgZoQVH7NPjKqXi9OqMj/64OWlGenJv0BD8t3dVzra
 8xZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/6Y9RtK8zsf1tW1H0L/BgDPC5qw0sSuzQ9Dhf+xElEwsSNeSD8cKbc2FV68uipvGbEQJp2nIE=@lists.denx.de
X-Gm-Message-State: AOJu0YxfQcU6CxRf3YYGQAlxog/Ys62Igt1A51tMi2N0BDiQpzbKqndw
 a8ojks9ZlK9VPGVBpCWw4/3okKVMRhD/WlqpCFGcCOm+cpq4WhDD2L/GFi35c6qAh1oHd8TxXmS
 loXfT9OoQfc3a+KMGHzWkPCo/WylPgKO+H/WwP6hafzr4yhLnwq65Fo9hNLbRa+lIHyqeRKU=
X-Gm-Gg: AfdE7clImee60TkX7yh7nicXUxmf5oM9bm/tsFHF55iSGQaovDVdts2XAlqKMgdgB0G
 DAD7JbI5fg34jGb7/hJxG4IXOO2BwMOLqzs5Pv59dwuYrW4FjC240KiQWXDDMveO25YTgjp21eQ
 GUAjjwfQwB5EKmG2fwEuxH4l5bL/pYupyjiZfIVIgE6AhEoUBs0kpBtxMe0Tg4LiIq4z73anBnT
 e1XZRLndSl4c3F8pc8668ttB+L9+Wo6N9t/w11vPhXqfiBTvm1shP648pMaFLKcsSKDYOGYxZB8
 BYcHyY1T7bpCgWRgBXRuS+celLBXyAny2MCCmfFUDXFjI4koe1WnODmXM7jy+K9TzZvmBMl6ki3
 cz1rwO615Eu+HazU1ELxuc4NPY98ugHkb+vrdNNSm/Cm1UKLtsuQsX9p5H3c/IIfBkOkoskQ50P
 AXheduh53bp/TWDvC27ivHCSJHaSQ2hf4=
X-Received: by 2002:a05:600c:8b4b:b0:490:ba0a:1178 with SMTP id
 5b1f17b1804b1-4926688974amr26196915e9.28.1782386806476; 
 Thu, 25 Jun 2026 04:26:46 -0700 (PDT)
X-Received: by 2002:a05:600c:8b4b:b0:490:ba0a:1178 with SMTP id
 5b1f17b1804b1-4926688974amr26196465e9.28.1782386806068; 
 Thu, 25 Jun 2026 04:26:46 -0700 (PDT)
Received: from ?IPV6:2a02:3035:680:3cd0:3c05:30a:d738:8c39?
 ([2a02:3035:680:3cd0:3c05:30a:d738:8c39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492660adaecsm58889515e9.5.2026.06.25.04.26.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2026 04:26:45 -0700 (PDT)
Message-ID: <e262d779-4854-4360-8d9a-a91ff76b5347@canonical.com>
Date: Thu, 25 Jun 2026 13:26:43 +0200
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
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTiu0HSZ4JJ7ggMMAk4oe0-h=Xq-Wnw=hqwGr80wBdrGXQ@mail.gmail.com>
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

On 6/25/26 10:52, Simon Glass wrote:
> Hi Heinrich,
> 
> On 2026-06-21T08:19:04, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>> efi_selftest: add ACPI configuration table test
>>
>> The new unit test checks if ACPI tables are available.
>>
>> If yes, it checks if the RSDP correctly points to the RSDT or XSDT.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>
>> lib/efi_selftest/Makefile            |   1 +
>>   lib/efi_selftest/efi_selftest_acpi.c | 138 +++++++++++++++++++++++++++++++++++
>>   2 files changed, 139 insertions(+)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
>> diff --git a/lib/efi_selftest/efi_selftest_acpi.c b/lib/efi_selftest/efi_selftest_acpi.c
>> @@ -0,0 +1,138 @@
>> +     if (!checksum_ok(rsdp, 20)) {
>> +             efi_st_error("Invalid RSDP checksum\n");
>> +             return EFI_ST_FAILURE;
>> +     }
> 
> Please avoid the magic 20 - how about offsetof(struct acpi_rsdp,
> length) or a named constant?
> 
> Regards,
> Simon

Thank you for reviewing.

20 is not an offset. It is the length of the ACPI 1.0 RSDP header.

Below is the precedent that Bin and you have been setting:

arch/x86/lib/acpi.c:18: if (table_compute_checksum((void *)rsdp, 20) != 0)
drivers/misc/qfw_acpi.c:310:    rsdp->checksum = 
table_compute_checksum(rsdp, 20);
lib/acpi/base.c:36:     rsdp->checksum = table_compute_checksum(rsdp, 20);
test/dm/acpi.c:371:     ut_assertok(table_compute_checksum(rsdp, 20));

Best regards

Heinrich
