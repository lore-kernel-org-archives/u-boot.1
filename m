Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A835EE74ACA
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:41:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2684896A7;
	Tue,  3 Dec 2024 20:40:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bFU8FyM8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBD408948B; Tue,  3 Dec 2024 14:07:16 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 763FF8852D
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 14:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4349e4e252dso51268495e9.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 05:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733231234; x=1733836034; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RumeMSZMnw7fA4g3z9SkQehUwMyPziINxD1Jzdjhr2A=;
 b=bFU8FyM8po4h+5uyBOfFjphCUNhZCy5ZERABSDja7T0XIl3aTM7FjpD+LF9IQC53SS
 a2ElFAGzPhMmi0xuJsRGxCdyhL4PxWhE7QqlN4mE4+W3XXVCw5lAjqAn+aQpy0uCBDO4
 1irmk1sK/5nvfPT455fwmwdhFfrVm0Y54e2clUR/pXqSUkcqTW6oTlqzaP5nfdwb2J70
 5GOlm7B8zoIujPdceKIbwtIEviVAjixaLGJJDMLl3Q7gdl7RuX79tx0TrWbdPyUrqsnI
 9VeRsPRRTZrU/VVrTbGhCE5TC0gTnGsr6nasUlUBV4RnNXl2u5eMgVAARu06Qf8jVQoR
 PrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733231234; x=1733836034;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RumeMSZMnw7fA4g3z9SkQehUwMyPziINxD1Jzdjhr2A=;
 b=nkCVDLTNatQPYnC4K/LPKX6CMqu/EvD1cPABgih7ItR0X0VUUbURP+5Hs1N3HqQHz9
 27GMQPHL6C3qAdhjYeDfcjOyTKKvBcKdMdDcu35rsVsGDtXBQAiDRPFcnwPvGCXwdqgu
 /Niz5onMx8sdOisy/8dJ58bkEH+CwV24NeHXJk3ByD2KqTxIzRGFJ1bDr+fko9K4pR5c
 0MTRRQHDZqVX8rFgalPmIEaI6fR5weldR8uyVrqeHEEiOnGsF2N/7n5eKe+04O8t53to
 2VleV037KL5PnKySWwUeNW4OQGQJekdjETChOX4PxtYBA3IUXwAoV7TZTfaumH5cbJT8
 nrMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgN8Gt9VCsSWxnkXn8OIudaehGc3uZArzYf67aH4fh0xiWl/BkxvOziR/8b+NS4D765MvJ30A=@lists.denx.de
X-Gm-Message-State: AOJu0YxRki4e3qHc1a5RH4L72356zDpNO0MD22bBQVmswiHrF+hQUdmr
 yvVDP2nbnICXFTL1kmqx4znMPjAOf+DnyvWvoHeJxiYJKdZNgmsK5MhhJSzwU68=
X-Gm-Gg: ASbGncsz1hHkE8xDZePeUyXEQ3MnTIIE+v+LzGh3J+LIsQkVMoI8jhviipxoizBF4T8
 2umVpeysTVVvUatVzX4qOVwU1jKloHJNihqkaqpecMeNrUQcnwmDypaP1VYb9QodxOns/ZUqHEI
 9FuKk60pOyWWr1uEWfDJnJGD4Rr7g2VoGrTHbpOHtK7IM08Ch3WxuGQpOF/P+dGjqSWVQO80Yla
 rzO1E5YzmU3h+K6bqQpW72cP9NyPUe5B2LqU1QGgVtdce5usoWHzBdtMQ==
X-Google-Smtp-Source: AGHT+IFDvA9R8u9wDE0wRfkjWslpy+5OtpW6Rkcar9mYLHN4bNjLdCcTfcq1cXtWHr7PpgEoNyrgdQ==
X-Received: by 2002:a05:600c:35cb:b0:434:a196:636e with SMTP id
 5b1f17b1804b1-434d09b67c2mr24890725e9.10.1733231233829; 
 Tue, 03 Dec 2024 05:07:13 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa74fec9sm219482265e9.6.2024.12.03.05.07.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 05:07:13 -0800 (PST)
Message-ID: <fa5ff70d-1b78-4901-ad33-f0cb163ac5d2@linaro.org>
Date: Tue, 3 Dec 2024 13:07:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: spi-nor: Enable mt35xu512aba_fixups for all
 mt35xx flashes
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "j-humphreys@ti.com" <j-humphreys@ti.com>
Cc: "Simek, Michal" <michal.simek@amd.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "vigneshr@ti.com" <vigneshr@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>,
 "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "william.zhang@broadcom.com" <william.zhang@broadcom.com>,
 "stefan_b@posteo.net" <stefan_b@posteo.net>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>,
 "p-mantena@ti.com" <p-mantena@ti.com>, "git (AMD-Xilinx)" <git@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>
References: <20241129102248.670635-1-venkatesh.abbarapu@amd.com>
 <c4a9d8b7-9dfc-4317-b061-e6dd887d7efc@linaro.org>
 <SA1PR12MB869712C44446C58C024B436498362@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <SA1PR12MB869712C44446C58C024B436498362@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 03 Dec 2024 20:40:44 +0100
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



On 12/3/24 11:48 AM, Abbarapu, Venkatesh wrote:
> 
> 
>> -----Original Message-----
>> From: Tudor Ambarus <tudor.ambarus@linaro.org>
>> Sent: Tuesday, December 3, 2024 4:08 PM
>> To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>; u-boot@lists.denx.de;
>> j-humphreys@ti.com
>> Cc: Simek, Michal <michal.simek@amd.com>; jagan@amarulasolutions.com;
>> vigneshr@ti.com; u-kumar1@ti.com; trini@konsulko.com; seanga2@gmail.com;
>> caleb.connolly@linaro.org; sjg@chromium.org; william.zhang@broadcom.com;
>> stefan_b@posteo.net; quentin.schulz@cherry.de; Takahiro.Kuwano@infineon.com;
>> p-mantena@ti.com; git (AMD-Xilinx) <git@amd.com>; Ashok Reddy Soma
>> <ashok.reddy.soma@amd.com>
>> Subject: Re: [PATCH v2] mtd: spi-nor: Enable mt35xu512aba_fixups for all mt35xx
>> flashes
>>
>>
>>
>> On 11/29/24 10:22 AM, Venkatesh Yadav Abbarapu wrote:
>>> Enable mt35xu512aba_fixups for all mt35 series flashes to work in DTR
>>> mode, and return after nor->fixups is updated, otherwise
>>
>> what DTR mode, 8D-8D-8D you mean?
> Yes...correct
>>
>>> it will get overwritten with macronix_octal_fixups.
>>> This flash works in DTR mode only if CONFIG_SPI_FLASH_MT35XU is
>>> enabled and SPI_NOR_OCTAL_DTR_READ flag is set in id table.
>>>
>>> Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
>>> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>>> ---
>>> Changes in v2:
>>> - Removed the SPI_XFER_SET_DDR flag.
>>> ---
>>>  drivers/mtd/spi/spi-nor-core.c | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mtd/spi/spi-nor-core.c
>>> b/drivers/mtd/spi/spi-nor-core.c index ec841fb13b..96f749f7a8 100644
>>> --- a/drivers/mtd/spi/spi-nor-core.c
>>> +++ b/drivers/mtd/spi/spi-nor-core.c
>>> @@ -4404,8 +4404,13 @@ void spi_nor_set_fixups(struct spi_nor *nor)
>>> #endif
>>>
>>>  #ifdef CONFIG_SPI_FLASH_MT35XU
>>> -	if (!strcmp(nor->info->name, "mt35xu512aba"))
>>> +	if (!strcmp(nor->info->name, "mt35xu512aba") ||
>>> +	    !strcmp(nor->info->name, "mt35xl512aba") ||
>>> +	    !strcmp(nor->info->name, "mt35xu01g") ||
>>> +	    !strcmp(nor->info->name, "mt35xu02g")) {
>>>  		nor->fixups = &mt35xu512aba_fixups;
>>> +		return;
>>> +	}
>>
>> this looks buggy. mt35xu512aba supports octal mode and I see that before your
>> patch nor->fixups was set to either mt35xu512aba_fixups or macronix_octal_fixups
>> depending on CONFIG_SPI_FLASH_MT35XU and SPI_FLASH_MACRONIX. Why
>> is it fine to remove macronix_octal_fixups for mt35xu512aba?
> https://github.com/u-boot/u-boot/blob/master/drivers/mtd/spi/spi-nor-ids.c#L360 the mt35xu512aba supports SPI_NOR_OCTAL_DTR_READ.
> Both the configs CONFIG_SPI_FLASH_MT35XU and SPI_FLASH_MACRONIX are enabled in our build and without return it will get overwritten with macronix_octal_fixups.
> 
I got that, but you didn't answer my question. Your patch changes
functionality for mt35xu512aba. If the code is wrong for mt35xu512aba,
fix that first, don't change functionality for mt35xu512aba on the fly.

