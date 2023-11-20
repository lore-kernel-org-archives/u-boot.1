Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6F8C197A0
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 12:34:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41B288709F;
	Mon, 20 Nov 2023 13:34:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pfaVy3BH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 944E98754D; Mon, 20 Nov 2023 13:34:27 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9871587040
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 13:34:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E25DE3F6E6
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 12:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700483664;
 bh=zw27MviPBkawig3gxOzfaOZUudoZcO6mjxRl01x3v68=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=pfaVy3BHt7jzwcgUr4E4yzIpRC51i1w/7Ev1lnK76yCW/HMMg1h0yEsLRj4uy/KjA
 1vIyW/HN/DcfMJsxY0isjCICnKMWxUzY2RzEx2tpu4wEaQduDiZp464aKumOtZWcOy
 bWO6LWaroaJAvGDiWXinOIOBrD0Tkaw7EmhJwDhirATG+Q36OkZKKjfKp/n09kD+HD
 44Gg8lPaZOjjgRMEsbKUpgL7JHohdDSf3WVZBPNIpktYWVHhnP8mtk7uXn6wZgWmzA
 6iY1f8mvRtH0a5CpXkgm2HaVAN3/xP6fEYngJrX3ZsKkBzQeGedceUiFHxQh/jVh3K
 xnHPtebnqeqLQ==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40a5290e259so12855095e9.2
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 04:34:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700483664; x=1701088464;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zw27MviPBkawig3gxOzfaOZUudoZcO6mjxRl01x3v68=;
 b=Iq0HbckTtqWTVMmID7sJtxIZ3qQ07kJWrDxcZqb8YAwkCvN5pneYTzqj8InpuVwHtc
 wAQudpzH8iSS/9kyisuosCxVucRyM2jlotCht2lxjXuYWGV2SLzU199IWKycZK6dMklm
 W6szpUtxCGh9W0DEbaM6OAobCW8tklfS5vosqAxHTzr+DUfDFanS0lUfrbPBYefmK4eX
 s9Lta62vqi0aMwn7SeDpyfzB5RnTpsi64A0IxRrOm6nejzNAfsSH6e0UKyB2VcqVq0BT
 rZ/53hxUatok7BVXqA5JZs6QLDQUFxYGD1n6G/rXX+37InEQk9FXKK/+JbdGlbU8UGtK
 PySw==
X-Gm-Message-State: AOJu0YyW8OE+HXI21cLTUT8qH1YiHQIxVSQTQgI//pcV6ucE2Vdweb1b
 9Ks8K/bWJNzxWvbFlH9WjEYu2mUJCdh6OcP+kBQvpCGBeKPyeSedBq/GsABE8ccSoxaluBcHlPg
 CRL9YKX57OYknSSMHh6gbYb0EcFVA2yHlgCyWkQc=
X-Received: by 2002:a05:600c:4e8f:b0:405:1bbd:aa9c with SMTP id
 f15-20020a05600c4e8f00b004051bbdaa9cmr6488678wmq.34.1700483664545; 
 Mon, 20 Nov 2023 04:34:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGK2johG59g0XQJ5MzwvP76xJGDIGo94sRI0H3IGylEyqMOxqN3gKjI9hPYntvu19XLD3izeA==
X-Received: by 2002:a05:600c:4e8f:b0:405:1bbd:aa9c with SMTP id
 f15-20020a05600c4e8f00b004051bbdaa9cmr6488659wmq.34.1700483664100; 
 Mon, 20 Nov 2023 04:34:24 -0800 (PST)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 v6-20020a05600c470600b0040a5290dceesm13534756wmo.0.2023.11.20.04.34.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 04:34:23 -0800 (PST)
Message-ID: <2817b1b3-d26f-4ebd-a170-8fbaea89b5b7@canonical.com>
Date: Mon, 20 Nov 2023 13:34:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cmd: acpi: fix acpi list command
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
References: <20231118225248.105229-1-heinrich.schuchardt@canonical.com>
 <20231118225248.105229-3-heinrich.schuchardt@canonical.com>
 <ZVtCzUlhBv59DdLY@smile.fi.intel.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <ZVtCzUlhBv59DdLY@smile.fi.intel.com>
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

On 11/20/23 12:28, Andy Shevchenko wrote:
> On Sat, Nov 18, 2023 at 11:52:48PM +0100, Heinrich Schuchardt wrote:
>> ACPI tables may comprise either RSDT, XSDT, or both. The current code fails
>> to check the presence of the RSDT table before accessing it. This leads to
>> an exception if the RSDT table is not provided.
>>
>> The XSDT table takes precedence over the RSDT table.
>>
>> The return values of list_rsdt() and list_rsdp() are always zero and not
>> checked. Remove the return values.
>>
>> Addresses in the XSDT table are 64-bit. Adjust the output accordingly.
>>
>> As the RSDT table has to be ignored if the XSDT command is present there is
>> no need to compare the tables in a display command. Anyway the
>> specification does not require that the sequence of addresses in the RSDT
>> and XSDT table are the same.
>>
>> The FACS table header does not provide revision information. Correct the
>> description of dump_hdr().
>>
>> Adjust the ACPI test to match the changed output format of the 'acpi list'
>> command.
> 
> (Side question: Do you use --histogram when preparing patches? if no, try it.)

Thanks for reviewing.

No I don't use --histogram.

Without --histogram:
  2 files changed, 45 insertions(+), 40 deletions(-)

With --histogram:
  2 files changed, 54 insertions(+), 49 deletions(-)

The histogram algorithms finds less commonalities. Why should I prefer this?

> 
> ...
> 
> 
>> +		if (rsdp->xsdt_address) {
>> +			if (!xsdt->entry[i])
>> +				break;
>> +			hdr = map_sysmem(xsdt->entry[i], 0);
>> +		} else {
>> +			if (!rsdt->entry[i])
>> +				break;
>> +			hdr = map_sysmem(rsdt->entry[i], 0);
>> +		}
> 
> With a help of temporary variable this can be rewritten as
> 
> 		tmp = 0; // or NULL, I haven't checked the type.

The type would have to be u64. An assignment would not be needed here as 
none of the code paths below uses it.

Best regards

Heinrich

> 
> 		if (rsdp->xsdt_address)
> 			tmp = xsdt->entry[i];
> 		else
> 			tmp = rsdt->entry[i];
> 
> 		if (!tmp)
> 			break;
> 
> 		hdr = map_sysmem(tmp, 0);
> 
> 

