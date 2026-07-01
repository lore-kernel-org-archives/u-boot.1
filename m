Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DBFC43327
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 13:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C08B184BB2;
	Wed,  1 Jul 2026 15:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="eSHhNEmn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8544B84BB9; Wed,  1 Jul 2026 15:28:56 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70D5884B92
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 15:28:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 046B83FA67
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782912534;
 bh=3QUc/eZgd0oA4lnu+EbUR9UXb36JKB+yvk3c+sR1qYo=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=eSHhNEmnxFoAZRs1eZVwT8miXqlEfJSmZPi1YCSmJYT7vpNmFP2urTuvUlCYLNWQA
 jj+LUvO8Ki6vpFmQuXPRuF/uFgab75V7HvxRjOvgkfudVS2fdb4DDgOIK5lmoL317t
 SWAj3Y1IDJ6nWCE7lVOtYc/heZEi2fXi3mOrrR/5DnbQdEgpc1Gflll7GCTvcUMHH3
 M5NsWRoxMzi6kU0Fcsr/LSHZ+wooQiFlpyBm3udOOhhK8QoLRHzOyBvOYmHCM7fd/z
 jP4uCJAUEcmGbFQKezn2raJBZUhrfT9bMjjMqTXdwIDD5C42X+wFMudlIUgIxYQ0yB
 Gcl4mLCJbSDXVkBMwab/QMAj7vY87KmylhA/fwgV2ELUCklcbYJcc+QacXYmdWKPs4
 /slGRNLFHZ+z/Y54j+0nh2ZdI0HKqYI+LefvlKG1H14Vver5ytawYOaWCya2oeufHS
 ByNfZMGiHUgxsoLAqfIT/nWDAGsu+0Ez7mP9OlZKGydX45V1bDvj9846cqbk3IAnxn
 ZERN8262/St8aw6bvfrF4hDe26zHvO8D/6v8sUXeXhnz5tPlvis5JDIXZdl5aKtPs3
 T5uu6mW43py+R/xXOoSU+6lYFVjZ8TRUATywlgWLhEnKn9EZHYVneIgRtqa3gCvzpW
 45Xh37TS/AGt/2Sww4o2n38E=
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-474170b59dfso523871f8f.3
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 06:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782912533; x=1783517333;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3QUc/eZgd0oA4lnu+EbUR9UXb36JKB+yvk3c+sR1qYo=;
 b=S5DBOTwAUzIUe+11lhYDk3VOySBH43UYimPSb1TzqNM8ItZOPDl+rncsWY76/wYLeN
 woAuwW3kGsKIM7/DF3KXMJtCed51r6hniwkuv2pTCgK6XuuCDMgC6Vx/ilE5l8Jv5E/Y
 IcGEixvVoeTW+B8h4GeXHfoahvUotRng1yoQoPDcFABt437+7Ij3gwjRc19y2VqtEk6c
 6hPkv4X3oTk+P8jfNjDKlE/o9jjrzyfS7pn5/+/VyJZ64oElEp3SYhh9upPqjMIRi+z6
 Qv0CMP2oBkKLZ9fQUcREFJuPGK6E2NvncbYZ/xWdqHdmh4GJ4uYguWuWzcF9dh2h8PCi
 D2vg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpj+1NIf4Gk3LjIevm8FAKg0MDynsYOj5TBi0jcFox8APheb7CZDzPgzlAUp2yO4VAlQvHX0Tw=@lists.denx.de
X-Gm-Message-State: AOJu0YzCyOBbacYwJ3p8S1BOJHG26EO+/Bd9dx2MMY122U4BWv3ebCUo
 /dT69GIdfXp7YTBlLM7ukCEWJATGUoVZtwaMAEq99IzKIakc3xyu2vwEdABpnlCAUJeV+PJ4RpR
 y95wdS3hcvExsFy2xNlLCojwygauNwSPhdwdBELhcSjyea9Su3wMEV497veUEuFqtlZ5J4CmWAQ
 5D298=
X-Gm-Gg: AfdE7cmQhBipuLxkbNXSfPlMrzjMBw7aB+6JbsK4MU29Zj5EJMzFmq/qd8MdzpRVj5H
 97o5xeyXEmfZS53bTeWmmC/3w4irf4tJpiVxjqATCwdJo0K/0JfrgYXvYM5EMT7s9odqSmZd0/b
 4rBeNZS9cwRU4mfk4hQlYjO6o9rZF+lBrhF4GZFrNu9oxQmdcn1RV+EO2zHYmCojpkHMMG+N3Rf
 UNs0NOnxchg07wLEfui+0l/U8+CQtYMDkhwqtEFZRBiHQ5pRWWRwHrVH9Qg+7CIUBq1EZ3CqWiG
 chz7iyexqILOVdbB9KkwthYYUe+oXexut27XDQ3Z9LY0YZiRFK9J60YeVK9iXN8F6fO35geU1UQ
 ebdFlF84XelAGjQERzajHms5fjqXpm+jF68kQE1Zr+f2xBeYlbsI2Q3so3DMZDFC3Bqhq9Vp8Vx
 /nVbqu1/nVrPgC7T8FsKGD7oMqbQBHNkZP/g==
X-Received: by 2002:a05:6000:40c8:b0:475:f0f0:9f00 with SMTP id
 ffacd0b85a97d-47759f0fccamr2878458f8f.55.1782912533524; 
 Wed, 01 Jul 2026 06:28:53 -0700 (PDT)
X-Received: by 2002:a05:6000:40c8:b0:475:f0f0:9f00 with SMTP id
 ffacd0b85a97d-47759f0fccamr2878403f8f.55.1782912533135; 
 Wed, 01 Jul 2026 06:28:53 -0700 (PDT)
Received: from ?IPV6:2a02:3035:62b:1f48:a6af:3a48:9d50:5eca?
 ([2a02:3035:62b:1f48:a6af:3a48:9d50:5eca])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4756636ce7esm18487308f8f.23.2026.07.01.06.28.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 06:28:52 -0700 (PDT)
Message-ID: <9c41ab58-dc9c-4cff-9914-96e32db02351@canonical.com>
Date: Wed, 1 Jul 2026 15:28:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] efi_loader: add ACPI table dump EFI app
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de
References: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
 <20260628082810.175862-12-heinrich.schuchardt@canonical.com>
 <CAFLszTjSeUs=iysEo5-ty+utMR4mJnW4BQjWPiTGB4QndnP_zQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTjSeUs=iysEo5-ty+utMR4mJnW4BQjWPiTGB4QndnP_zQ@mail.gmail.com>
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

On 7/1/26 14:01, Simon Glass wrote:
> Hi Heinrich,
> 
> On 2026-06-28T08:27:58, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>> efi_loader: add ACPI table dump EFI app
>>
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
>> This matches the output of the Linux acpidump -b command.
>> [...]
>>
>> lib/efi_loader/Makefile   |   3 +-
>>   lib/efi_loader/acpidump.c | 566 ++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 568 insertions(+), 1 deletion(-)
> 
> Did you see my comments on v2?
> 
> Regards,
> Simon

I thought the v3 change covered them all.

What did I miss?

Best regards

Heinrich
