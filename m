Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BD5C43602
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 08:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F13E84CB3;
	Thu,  2 Jul 2026 10:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KQb92qNd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D315584CC5; Thu,  2 Jul 2026 10:57:43 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D533C84CA3
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 245B03F979
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 08:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782982661;
 bh=ZZxkewHLNGm5w5ObRacgcdK1BLEXMPoYOwToJkUUDF8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=KQb92qNdL5LDkmYEDwIIfxRCVYtYKv1yBrZ1v9SBw0ZCXBwEPDw4FGxMyrOYsBTd7
 X38v8T1BXaaQpOcWMO+KhB1KvJop/fiCqeI/07zuTd5CFXrEsSzCygkBIIqAxt3jMy
 4dY+FMaaE2S8V3pzwAoV+OJb0UxwTzSG9Agvu/rdYfo4sQMY/dX8b3iaMxTDlJft0V
 iEK9QLeuVyQKcgX0D56AMHVY0QRoUpPvCaU108Zw/O1GIFQlvKXv2nYcQiJ9vYZ4Dc
 DJaCCdZ1UoCCb42Rs46CQW6h8jYjzhIZGnEHC68LsHpbTxE2v2JDRNcLo8y9H8r8a4
 2dDxXBk4gSbtAlDL3PTv0XOS2/CXxNihj5034LNJpX6DatGQzw+GoJD6L2eQr6vRRs
 kvx6nBUz/ed6IM6wDqhV7o1cQ3ULlW+Qr29Zcvus4kYM5k59DmiYfcKmhTWp6WXrrN
 L5f0K4lsb4ZRq28X+VJIcKovOk22yQzC5jdVWvT7tKKo41jNoR6LeRuq18E1RZXYmF
 PVs1Amy2iyUZkR30Sjmct2C/mvfAtercvUc/3i22i93t9ofFOIQLJrV3g252q20Sf0
 SiQ4AUb2mcypRWXXt89y/VqnYacwZfsevCFSvAQjm0JUzUbeTOGZEVZPHt7bXzXmbY
 jJ1UCCrEcVtEaVkVSUZ7BXoE=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493bb6a4336so14699365e9.3
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 01:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782982660; x=1783587460;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZZxkewHLNGm5w5ObRacgcdK1BLEXMPoYOwToJkUUDF8=;
 b=ACsbOllJoJbW/WvIQVDoB1DA/L5Lo5A5KJZHZfvSANBHj8AtQdWHmi82zQchUbZ/bX
 DBFp7toBmniQjjf0FQWZUVejYj4TRudVNYme5KzJ5Zlz97ya4kOwdFptIWuIK3CBR2yP
 Ifud/iZAm0dFlZ0pUXajeLV6YpWGknAsowYQs1bEPIm50CK5RgSOCU+hPWj4Is0y1kvB
 tmV5xlwgEqRR1qlhRKDcSuxDCJ9TavBKoBUKBIEyWBUUkqN33GiPxBxNNoFDgi31KpXg
 z7n3B0LH6b8Ap17SzmSn3WYNirOok9E7SCOhx9RBjWt5smb9qgz/nMDQzig7sa0yJkJr
 bWRw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8iIAMeM/cF1PhJNA1duIYNCG1++2Rm/GmUvelKzKlfmfM0UDGvf3pJNoSFCV1iqRCUuWypiKw=@lists.denx.de
X-Gm-Message-State: AOJu0YyhWBCo7bPMtZY03u+JRnSkaN9yMVch4tLN39VSertgk31Z2IBH
 e96k80v4lZbS9DzveTHMBKQuYFitwCDreqxh6J2EQwSYRWhuM/H/TESBYklHfTyf+8ANE398N9X
 SS7GjefX2OLAmlSJz6mFkpj31B00+zzcAwz8ddtv0gx/GGaMj+4ObL4NIlQxiu3VzW3/oMgY=
X-Gm-Gg: AfdE7cm/4dOrKGuLfl9vl4QLdpfLFagIfZ93SXaWTO9EYOvdSIBYy8FVOUnhVw3vkLu
 wDht109vELhQ5WyN5WKTJd9koyYqUwVebqNd4pUO20u/lApVtLnxRlyqTZbYb+4khf3lgttV9UE
 QBj57ykLjEp+gnuoR91mnakBsgTBI129H14QogpF+GaACsw34Vgwx7kx1PL+OeEYEv9IqlVVwML
 Phsi/ygBiiH/kRRv8nmPt+V6/DPXHnAboJfCoUrH8drVeSMFdaoO1Bp06slDjPn1pJWhuRnJJ6h
 2naxlsQwrjqmbTavHrfkhqZJrAAoqP1FxljyCW8SVCloevrNBhl4bumx7evbJ7QO1E++TVAT8Ez
 yvnrYRNkUj0LxabT5X7RofdhLgqiPXLb/hEpvx3xt6OZCV6rFtRE0Kz3OaiZ3a2SOIx9j0PZ0Uv
 xPhA9ABGKhrpG8YcBRnkmFQuIFHUykalI=
X-Received: by 2002:a05:600d:c:b0:493:aa28:38ad with SMTP id
 5b1f17b1804b1-493c2b4442emr53887195e9.10.1782982660699; 
 Thu, 02 Jul 2026 01:57:40 -0700 (PDT)
X-Received: by 2002:a05:600d:c:b0:493:aa28:38ad with SMTP id
 5b1f17b1804b1-493c2b4442emr53886865e9.10.1782982660253; 
 Thu, 02 Jul 2026 01:57:40 -0700 (PDT)
Received: from ?IPV6:2a02:3035:601:211c:b85b:1021:c955:d2d?
 ([2a02:3035:601:211c:b85b:1021:c955:d2d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c6381e4fsm36077915e9.8.2026.07.02.01.57.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 01:57:39 -0700 (PDT)
Message-ID: <406c87e1-7f0a-47da-a3c6-6fae80c63a31@canonical.com>
Date: Thu, 2 Jul 2026 10:57:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] efi_loader: add ACPI table dump EFI app
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>, u-boot@lists.denx.de
References: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
 <20260628082810.175862-12-heinrich.schuchardt@canonical.com>
 <CAC_iWjJkZ7zegZCbhgZB0VLCf6CF=mtP7PzYmx6rF3+tetoM5Q@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjJkZ7zegZCbhgZB0VLCf6CF=mtP7PzYmx6rF3+tetoM5Q@mail.gmail.com>
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

On 7/2/26 10:48, Ilias Apalodimas wrote:
> Heinrich,
> 
> Didn't I have a tested-by and acked-by tag on this?

I did not keep such tags as there is a change to what you tested and 
acknowledged. See log below.

Best regards

Heinrich

> 
> Cheers
> /Ilias
> 
> On Sun, 28 Jun 2026 at 11:28, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>> Provide an EFI binary that can dump all ACPI tables to files
>> <table_name>.dat. These can then be further analyzed by decompiling
>> with iasl.
>>
>> The DSDT and FACS tables are identified via FADT.
>>
>> The following commands are provided:
>>
>> * check - parse ACPI table list\r\n", do_check
>> * write - save one file per ACPI table\r\n", do_write
>>
>> The file names are constructed from:
>>
>> * 4 character ACPI table name
>> * number if there are multiple ACPI tables of the same type
>> * '.dat' extension
>>
>> This matches the output of the Linux `acpidump -b` command.
>>
>> Signed-off-by: Heinrich Schuchardt<heinrich.schuchardt@canonical.com>
>> ---
>> v3:
>>          extend the commit message
>>          reformat with clang-format
>>          roll in u32_to_utf16_dec()
>>          in add_tables() check against max_tables
>> v2:
>>          Check checksums.
>>          Check both RSDT and XSDT if both exist.

