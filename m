Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925FCC41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 19:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E4C587A7F;
	Sat, 16 Dec 2023 20:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Fxu5A6JE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC40487B59; Sat, 16 Dec 2023 20:23:06 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6E7B87720
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 20:23:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from [172.25.0.170] (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 03CB0413C5; 
 Sat, 16 Dec 2023 19:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702754584;
 bh=ZWMYaYROxzdV0ku/69FzvSGf67onMYYCWgGygjUukW4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Fxu5A6JEcHThjpCo/hgXntTEPJzlj/pLI0oZ3Gri4f1OG37qQQp1AWf9YCbjJN4IA
 J0dVaZGTqp5MzOhA0jT8/avoYJ2hVlqRxw/j8oCQ6wqWh6tvW4PFYiB7LW8h/NwuuL
 ayoDzce3zevADpXUUk6JtkojOq5zk8OHhYMzkpgHGllG/3qwoIS5ols2zCcLGnT8xY
 95noSAZfF7DGFO/CFW4fOpg9ykKGrNAVk3vDk/0E5D8QdeIeFQ1XAzT3jIHJ9Q//RA
 91fFX4/TLPiqNm8KxcAlRCqtr2zVFN43BTXi6JEIYn5D4G7NWHdl8wCiLNxhbhtmfj
 OMi0L+dIurZrg==
Message-ID: <05b45f95-f760-49ee-9888-39ff913177a6@canonical.com>
Date: Sat, 16 Dec 2023 20:23:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] arrm: add ACPI fields to global data
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Bin Meng <bmeng.cn@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20231215133245.7923-1-heinrich.schuchardt@canonical.com>
 <20231215133245.7923-4-heinrich.schuchardt@canonical.com>
 <CAPnjgZ23cv=i+9_vuM3EaQ2-vUhEvzcd7Dynowd41M5hsSGHrA@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ23cv=i+9_vuM3EaQ2-vUhEvzcd7Dynowd41M5hsSGHrA@mail.gmail.com>
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

On 12/16/23 19:46, Simon Glass wrote:
> Hi Heinrich,
> 
> On Fri, 15 Dec 2023 at 06:32, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Add fields for the location of ACPI tables to the global data.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v2:
>>          new patch
>> ---
>>   arch/arm/include/asm/global_data.h | 4 ++++
>>   1 file changed, 4 insertions(+)
> 
> These need to be #ifdefed as they affect global_data size,
> particularly in SPL. In fact, we have a problem there.

Why would it be problematic to have more unused fields in global data?

Best regards

Heinrich

> 
>>
>> diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
>> index 75bd9d56f8..9505399bb1 100644
>> --- a/arch/arm/include/asm/global_data.h
>> +++ b/arch/arm/include/asm/global_data.h
>> @@ -19,6 +19,10 @@ struct arch_global_data {
>>   #if defined(CONFIG_FSL_ESDHC) || defined(CONFIG_FSL_ESDHC_IMX)
>>          u32 sdhc_clk;
>>   #endif
>> +       ulong table_start;              /* Start address of ACPI tables */
>> +       ulong table_end;                /* End address of ACPI tables */
>> +       ulong table_start_high;         /* Start address of high ACPI tables */
>> +       ulong table_end_high;           /* End address of high ACPI tables */
>>
>>   #if defined(CONFIG_FSL_ESDHC)
>>          u32 sdhc_per_clk;
>> --
>> 2.40.1
>>
> 
> Regards,
> Simon

