Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75736C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 19:30:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A88FE87582;
	Tue, 21 Nov 2023 20:30:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="oqewcRQU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0B6C87582; Tue, 21 Nov 2023 20:30:40 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B018D86BFA
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 20:30:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 13A4A40614
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 19:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700595038;
 bh=bvD4BeVz9+LtBwbOT8WzQtlpbiKpIX2h1DtaJdOTHYo=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=oqewcRQUwtt3vPEWMnsNj+qjsXL+n67btZeSi7AEcTqyZPsi8oEYzxzbw9ekgaM8N
 xPWcd87E/PiEK3NOeFi8AJKNIelhHD1LZvQlNsRrKBzePDn0fQuE/XCf3YLYumnw6M
 1JePxduYklovU4uJ0RGcfhIvLc32jvJELTOMIT9fMtZBrJgA7ZjUOLDQf/LbR2WyOX
 Io1GmxGh7JLBiEAZqvjJIxTUmnVLD3WgDDfEPqo6kwkck6hOBsCMIsK91xcW4Q/rGk
 S1o9rVmoXkDhKxGcKm+1fJGxZpcF83dAeqCAxNehlRbJtuQt4vHHd4ttUn7AVIuDGK
 /Wr+BLbM3LwKg==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40845fe2d1cso21926415e9.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 11:30:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700595037; x=1701199837;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bvD4BeVz9+LtBwbOT8WzQtlpbiKpIX2h1DtaJdOTHYo=;
 b=DcR/68LPOzzYvTizgwHcLdS5ccEhViVLGep3spGWm7+OMZbZCbHh4+nWQpgLe6jIOR
 0h0mLIBCcwhx77XH2wmJ8uqamh5VHeYv4DwsUgY16aUW3lFVfrrZixZ+yztS34/Q1qfm
 D46jPT/xf7p+52hEUv7EeE2NZAiVwiDeHRaZd9grJpvde2v1wkEZ9jq7N2Y9LwO+cce5
 VaL4f2bzlagz7CHFPwixRyRul+KjvFD/e/8y1gFR5fWuRN0JTzBPyWtu6L8TggGvb2v0
 TMkKNZPJQy5wG+Z/lno37OTtq2g/0re4zV072fujDe19QCX/GdfnxoxskoGGTGU0dpeg
 No6g==
X-Gm-Message-State: AOJu0YxZBlOmDk0ST70AnBWEc8ipgMTJR4SxYODtjOFr6y+bcUMxd1+b
 kJ7U8wdJK4QPqKWz+y4WIOY4V2DTRAIIcsV1/fh/IVdNd3ShLjEINgfUejmxFL7CkSao6zDGdrQ
 GqZwiMDaUdN6ZLT54UXIhg6gLoU/Fq2w=
X-Received: by 2002:a05:600c:310f:b0:40b:2979:52ad with SMTP id
 g15-20020a05600c310f00b0040b297952admr230973wmo.41.1700595037569; 
 Tue, 21 Nov 2023 11:30:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFJjSpdkhO+x1PYNmBehMYZrMGqD6e+WBk9SgKKtAik/Krc4Trr+jVja7IkepJgU7fOO+VTA==
X-Received: by 2002:a05:600c:310f:b0:40b:2979:52ad with SMTP id
 g15-20020a05600c310f00b0040b297952admr230954wmo.41.1700595037119; 
 Tue, 21 Nov 2023 11:30:37 -0800 (PST)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 u25-20020a7bcb19000000b00405391f485fsm17669737wmj.41.2023.11.21.11.30.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Nov 2023 11:30:36 -0800 (PST)
Message-ID: <28fdf7b8-8e6f-47c9-81f5-9b95acccc3ab@canonical.com>
Date: Tue, 21 Nov 2023 20:30:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] acpi: Kconfig symbol CONFIG_QFW_ACPI
To: Tom Rini <trini@konsulko.com>
Cc: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Miao Yan <yanmiaobest@gmail.com>, Asherah Connor <ashe@kivikakk.ee>,
 u-boot@lists.denx.de
References: <20231121152740.24783-1-heinrich.schuchardt@canonical.com>
 <20231121152740.24783-2-heinrich.schuchardt@canonical.com>
 <20231121190000.GA2513409@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20231121190000.GA2513409@bill-the-cat>
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

On 11/21/23 20:00, Tom Rini wrote:
> On Tue, Nov 21, 2023 at 04:27:34PM +0100, Heinrich Schuchardt wrote:
> 
>> We have two implementations of write_acpi_tables(). One for writing ACPI
>> tables based on ACPI_WRITER() entries another based on copying tables from
>> QEMU.
>>
>> Create a symbol CONFIG_QFW_ACPI that signifies copying ACPI tables from
>> QEMU and use it consistently.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v2:
>> 	new patch
>> ---
>>   drivers/misc/Kconfig   | 7 +++++++
>>   drivers/misc/qfw.c     | 4 ++--
>>   lib/acpi/Makefile      | 2 +-
>>   lib/acpi/acpi_writer.c | 4 ++--
>>   4 files changed, 12 insertions(+), 5 deletions(-)
> 
> I still feel like this is a weird direction to go in and that:
>> diff --git a/lib/acpi/acpi_writer.c b/lib/acpi/acpi_writer.c
>> index 946f90e8e7..9b9fdc190b 100644
>> --- a/lib/acpi/acpi_writer.c
>> +++ b/lib/acpi/acpi_writer.c
>> @@ -48,7 +48,7 @@ int acpi_write_one(struct acpi_ctx *ctx, const struct acpi_writer *entry)
>>   	return 0;
>>   }
>>   
>> -#ifndef CONFIG_QEMU
>> +#ifndef CONFIG_QFW_ACPI
>>   static int acpi_write_all(struct acpi_ctx *ctx)
>>   {
>>   	const struct acpi_writer *writer =
>> @@ -115,7 +115,7 @@ ulong acpi_get_rsdp_addr(void)
>>   
>>   	return map_to_sysmem(gd->acpi_ctx->rsdp);
>>   }
>> -#endif /* QEMU */
>> +#endif /* QFW_ACPI */
>>   
>>   void acpi_setup_ctx(struct acpi_ctx *ctx, ulong start)
>>   {
> 
> Will need to be tweaked later on still with some other symbol to denote
> "ACPI tables were passed along on real hardware by $mechanism". But we
> can cross that when we come to it.
> 

QFW is only about QEMU. What I did here is separating the transfer of 
ACPI tables from QEMU from the code co-used by the sandbox. Do you think 
this is wrong?

Probably when booting U-Boot via Coreboot we should be able to copy ACPI 
tables. But this will not involve QFW. Is there any code, yet, where 
U-Boot is picking up ACPI tables from Coreboot?

In this case you would not set symbol CONFIG_GENERATE_ACPI_TABLES. Do we 
really need yet another symbol?

Best regards

Heinrich
