Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA84CCD5BAC
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 09:02:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 649958460E;
	Fri, 22 May 2026 11:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ijCtiO6a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2028846AD; Fri, 22 May 2026 11:02:28 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D7E7841D7
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 11:02:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E4FD83F46D
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 09:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779440545;
 bh=cxYwyDgl0x/FoETYAzeZpaX/ZOhWXqgYtJbbbShOl+M=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=ijCtiO6apNI/w5aR9/skfhtTAOB/y70CC/bZWf/CSws19wOSpsH+eT79PYzk8rkzx
 GW8KZjqFrUnVJHsWKQBWAGHStoaXPVf50cccy4TXpQCFvcq4F4kPc1k4vHxiYMbbI6
 g+RIvX4AIIBolO/abvpemc3kH+EOAwN5w7UcxH9U2gzD15xmOLcn498zpe8G9afl4A
 hIoFpz7u8zQLeLCJ6XZOl1QhP3cZvsVqWwdIyiIQsjJKlbpHqehcVFOa9itsrx8N/6
 52iFbORskjabXp5Cx2Qw1b2w74GNLz9mvoR3461M1dJTeVXCBPoJ3TFPuONmY9iAOh
 vaHgmMoiyeOnGdXWJwPYcO5rvUJMoZIPuMu1zGgqMFA/7N+VSH3kPheBOOL7xw6YzP
 FDen4fguWJCGOMmmsJZbYVb9VX439QWNIV0NarkZKNjcm8mHOFgRBx4qmKQpKAQH/F
 WuOQlEAdQRA9GFYqb8MS/j5w0WgF74zo6p2qBpKvchbLhy+LSHV62vXqIV6RN6USXx
 aZuvwA6cNAtG2sQlz4DvTxV4nBG8+rCTs5itg7qT7hBVGrxtnKoQ3sf70ZeG90g2U1
 OrlhhvTjrPazkqnpCFtIjtwWsWCCAmSzbSEjzm2jGeSrbn+NiC091GhJKWw4kUvNaP
 NHN8LJ4RHeZZckKwRdP8pRPo=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48fd33b4921so46480535e9.2
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 02:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779440545; x=1780045345;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cxYwyDgl0x/FoETYAzeZpaX/ZOhWXqgYtJbbbShOl+M=;
 b=lMntsCmrlynZQghV8/H0B03qZwSkOl6fodnCdiTrCnqfqPs2HTjmOndZE4/WoXP7In
 zzSCuF9YEYJOrMG/uB9Ha4Gf05pF/0hbTdRg7PDrlVuWYpir+pPCIVDWqhGr7p5dgVdY
 UEYK+kWUEp9m1/3ILfXNztJ+qfr5gpzj9vrXpl/bVsHwyZJV+EmN00fSgrOd6WILah7r
 Nsnmf9aRgjLTLe46z3jt9ac9TEWL02ds9s0CxTibYMf/zEUteGg6l/orwgwLmU6pGm6C
 JrGsCtBbB37GN176RFVPnPwEuP6mzoprSsMZaHGJRIcaU/6taQmHhVqnP4SH/QyaV35e
 ql1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9FqNAwNPObnaGuF/ATaaJKAKnzJp5tmMKGrA4YuQDWjgCg9tI6kteLeX9mlQi9fBRM1x5bah8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx19DwGum+KRctWl1sFCcuM+IkykK3k4LcdL+InUXBWODcTPa+R
 kVk8ZC74ToSWdWw0hznJ+Dv+qJGMT4E1ZTp0qAx5sma3bJ0IScVreaYeJWxg7l95Frh35RPB/I+
 eV5F1sOSD5+LWbQ2BpTg8pZQzKyCjXp7JPoBo5fq+IzW0Y8tHBpZcO23dVTdFjQI1tfXH6EEIkr
 kzhWc=
X-Gm-Gg: Acq92OFFW29wtMubMM3lu39CHmRgiCNig6ZUzMJGCRSOMpA5T5vZJl+wsysJNG3cGtP
 zckQhp6Itrh/91G35nWGY0YZWEaJbaRg7/xoZB92kNJ0qlxG1LIKe4En7yzZp3BGS1Y6kcGvG7O
 HuwN51YwLQwS4JIspOnGJI1RBgy10vwJQ3N7qXbWBBZVhkRiN06wKEDh7ADlghf+QZNbJ7eX3LR
 2QcOfNq3H1NMf9YBDTdkFJMAlk7mge2bC5h3NftV0oSsMfA2LJ8RpcywPKbcTVHvovWItR/ZTKD
 Z47U+rOSYNDqG/sooUAFNbtCsXIpqKbCYksbLLIp0jMxZtFnpsejS07H5TOQTtXx5c5iRbRh82X
 3IPMrMKwdPLq/JY0/EPS/IoGotNLWh15pBVNXwcgqn8ASR8KIqV9wd+R6hF5jo/GpBqBKKvQuWs
 Ex3sfHoFYCT8EzVFDzEKC23mFKbTrvRlhIIFu0rcBVwVgRHPMEHD3AVxGds925SUMLKV1kEfk=
X-Received: by 2002:a05:600c:4f0b:b0:489:1ba8:5bf0 with SMTP id
 5b1f17b1804b1-490426c5b05mr33389005e9.21.1779440544893; 
 Fri, 22 May 2026 02:02:24 -0700 (PDT)
X-Received: by 2002:a05:600c:4f0b:b0:489:1ba8:5bf0 with SMTP id
 5b1f17b1804b1-490426c5b05mr33388225e9.21.1779440544239; 
 Fri, 22 May 2026 02:02:24 -0700 (PDT)
Received: from [192.168.103.104]
 (dynamic-046-114-111-011.46.114.pool.telefonica.de. [46.114.111.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454ea134sm33633375e9.8.2026.05.22.02.02.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 02:02:23 -0700 (PDT)
Message-ID: <07c2d6e1-5c29-4587-b7cd-1f006a8752a0@canonical.com>
Date: Fri, 22 May 2026 11:02:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] efi_selftest: add ACPI configuration table test
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260521185025.30857-1-heinrich.schuchardt@canonical.com>
 <20260521185025.30857-3-heinrich.schuchardt@canonical.com>
 <CAC_iWjKxnCoMwF8W0aqdtja4=6chomCHQM774un7vsqA_iYXYw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjKxnCoMwF8W0aqdtja4=6chomCHQM774un7vsqA_iYXYw@mail.gmail.com>
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

On 5/22/26 09:10, Ilias Apalodimas wrote:
> Hi Heinrich,
> 
> [....]
> 
>> --- /dev/null
>> +++ b/lib/efi_selftest/efi_selftest_acpi.c
>> @@ -0,0 +1,75 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * efi_selftest_acpi
>> + *
>> + * Copyright 2026, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> + *
>> + * Check ACPI configuration table availability and root table presence.
>> + */
>> +
>> +#include <efi_selftest.h>
>> +#include <acpi/acpi_table.h>
>> +
>> +static const efi_guid_t acpi2_guid = EFI_ACPI_TABLE_GUID;
>> +static const efi_guid_t acpi1_guid = EFI_GUID_EFI_ACPI1;
>> +
>> +/**
>> + * efi_st_acpi_execute() - execute ACPI selftest
>> + *
>> + * Return: status code
>> + */
>> +static int efi_st_acpi_execute(void)
>> +{
>> +       struct acpi_rsdp *rsdp;
>> +       struct acpi_table_header *table;
>> +       u32 rsdt_addr32;
>> +       u64 xsdt_addr64;
>> +       uintptr_t rsdt_addr;
>> +       uintptr_t xsdt_addr;
>> +
>> +       rsdp = efi_st_get_config_table(&acpi2_guid);
>> +       if (!rsdp)
>> +               rsdp = efi_st_get_config_table(&acpi1_guid);
> 
> Isn't having both RSDT and XSDT a valid case?
> IOW the test looks fine, but wouldn't it be better to check for both
> unconditionally?

Yes, if pointers to both tables exist, we probably should check both 
signatures.

Best regards

Heinrich
