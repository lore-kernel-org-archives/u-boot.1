Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC120C61CE7
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 09:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C68BB82977;
	Wed,  4 Jun 2025 11:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G7c/ZL6G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CF2B82AA7; Wed,  4 Jun 2025 11:51:07 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F1A281FEE
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 11:51:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-450dd065828so34724845e9.2
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 02:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749030664; x=1749635464; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Id4+QDyny8yAg4+AOUYwkDArGVJ40YVvlQ+IIZTmFrQ=;
 b=G7c/ZL6GWsVs0RaNKcHaHA1FXm5BymfszRlxgqZW978xUHSdtseiKzLZn14VcQ/juL
 1V92YFmxep8RMb1+RwsJ+XkF74ZZSeFMmEIFMeeaLjU/DbjprU57fM2FfOVb8bYkmJno
 RetDuBUqTfOCgYMmHK8fildgrsl68C+YAYYrUUe4vPEggKZBOXnK5YiAD2S6ekrn/9cT
 LYn8qRvYLA2V67UpkPYV55X1d3HNyv76uh/Fk0FCsSaMI6vn+D48WYTY5tXiLkUjk66Q
 6hVcgwf2VqrMkAYerdVL++ce8CPJifuJudCMFnw3p1hh/fI/4yX7KdGN4CzcVAs5673+
 CznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749030664; x=1749635464;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Id4+QDyny8yAg4+AOUYwkDArGVJ40YVvlQ+IIZTmFrQ=;
 b=ax9hMpM0KTupskY3y/5M2JPeFNuHbx3rUG0Oztt9LwZb2UUrRTfejupWwtZU6vyJTO
 0rNTi15OH3RgyFmEWTxN6amH1X+yo5MzlBOV2BzUwkCn2NM2miocdUDltu+3xfpSb/Hx
 CFJOOSYK/UgvfLFbdi0Z6Q2nXfJTq0LbBdO1nfOGmNomZnYbM2gKNe+iPv2klC12Vr26
 F36oMX6KHW5a9esEHQgnT7oaRwV5ZPmAbPCKEDsy6hPbCxUS7yiYxRVVYxnbHbbqnvga
 XJUi2whJ7xReyP45IaioGL7GKeKhs2+OHQCcFBvzpNcWjMemx8IVO5x+tTNihME8N83W
 g7ZQ==
X-Gm-Message-State: AOJu0YxTy+F75SffcqxegAgXSXXKNNzBhH2W+NMs2gOhDX4UgJ5tOJWa
 uUx6ok3LUzVxd5qPHejDfA9GdVBaEVGomAbM8P/ySReP+PTMV8G20NzwsyyYImcgerg=
X-Gm-Gg: ASbGncuy8fP22uVrisXaFB5qoQH1MxuMM0Sri1AMLryuoTL/75FjBnBjRp6yIRJZCfc
 wFdCEbxEcV8fR0wL9q4AnsjuGq2PfOIKESWCg/vOKVXyHbzR2XI/WMSsMyWXW6oUGyqN6bvMmYf
 keeFPYq1cVJblNCBKkwY8cMknZWpwR7DCShl0tSsZtZim23ztXMsqO2rlvZ3r7GAYpefhmDCzen
 W4cS9qxubWDDN24fWm3Ba/XwEkGnTESr6CvaNmxYwBYoCvHpeLRLvzPMH9UODrsoCRJ1UlF06Xy
 B81ZKLDsoPK37Hr2IAASq7a6dRMBroVNhEVG7uHdKuN0bNcaQGM0lUKLqu0zdyp/09TioQ==
X-Google-Smtp-Source: AGHT+IFhCFjcU6ZcUr3zNmJnPtIsjVpOD8VoqP1eaHFQqZgopNIpsmiOB4mVrSs8jGXmdMazoNS97w==
X-Received: by 2002:a05:600c:1c96:b0:450:d019:263 with SMTP id
 5b1f17b1804b1-451f0b0f5a1mr18733965e9.18.1749030663608; 
 Wed, 04 Jun 2025 02:51:03 -0700 (PDT)
Received: from [192.168.1.221] ([5.30.189.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009758esm21295984f8f.75.2025.06.04.02.51.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 02:51:03 -0700 (PDT)
Message-ID: <dd3a3cad-75df-43b7-862f-a51cacda3de6@linaro.org>
Date: Wed, 4 Jun 2025 12:51:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: atmel: reliably generate disconnect by
 disabling controller instead of toggling PULLD_DIS
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mihai Sain <Mihai.Sain@microchip.com>
Cc: u-boot@lists.denx.de
References: <20250602-pullup-v1-1-edcde5a050dd@hifiphile.com>
 <87iklbuddu.fsf@kernel.org>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <87iklbuddu.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
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



On 6/4/25 11:20, Mattijs Korpershoek wrote:
> Hi Zixun,
> 
> Thank you for the patch.
> 
> On Mon, Jun 02, 2025 at 17:45, Zixun LI <admin@hifiphile.com> wrote:
> 
> I'm surprised that checkpatch.pl does not catch this, but the subject
> (title) is too long (it should be less than 70 chars):
> https://docs.u-boot.org/en/latest/develop/sending_patches.html#commit-message-conventions
> 
>> Contrary to the datasheet, setting both DETACH and PULLD_DIS bits to 1
>> does not always drive the DP and DM lines to high-impedance. This
>> prevents the host from reliably detecting a USB disconnect and subsequent
>> reconnect.
>>
>> The symptom is that the first gadget command (e.g., dhcp) succeeds, while
>> subsequent commands (e.g., nfs) fail.
>>
>> Disabling and re-enabling the controller entirely, instead of toggling the
>> PULLD_DIS bit, reliably generates a disconnect event.
>>
>> The Linux driver works correctly because gadget_disconnect/gadget_connect
>> are always followed by gadget_udc_start/gadget_udc_stop. In U-Boot
>> pullup() is used solely.
>>
>> This behavior has been observed on the SAM9X60-Curiosity and
>> AT91SAM9G25-EK boards and has been reported to Microchip.
> 
> I'm not against this, but the driver supports multiple gadget
> families according to the compatible.
> 
> I'm wondering if this issue is reproduced on other atmel
> boards that are supported in U-Boot.
> 
> Eugen, have you noticed the above limitation on a different
> board family that you maintain?

I have not seen this before, or don't remember about it.

Adding Mihai from Microchip team to see if we can get more info, whether
this is a general gadget thing or it's specific to these chipsets. If it
was reported to Microchip it would be interesting to see the response.

Eugen

> 
> If this issue is chip specific, I think we should test for compatible in
> usba_udc_pullup() to only use USBA_ENABLE/USBA_DISABLE for this
> particular compatible (microchip,sam9x60-udc).
> 
>>
>> Signed-off-by: Zixun LI <admin@hifiphile.com>
>> ---
>>  drivers/usb/gadget/atmel_usba_udc.c | 9 ++-------
>>  1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
>> index f9326f0a7e7d913bcf201ba3e4aeca9a099e7be7..a38e70957402fb3ade3de611d73e29b990d00703 100644
>> --- a/drivers/usb/gadget/atmel_usba_udc.c
>> +++ b/drivers/usb/gadget/atmel_usba_udc.c
>> @@ -521,16 +521,11 @@ usba_udc_set_selfpowered(struct usb_gadget *gadget, int is_selfpowered)
>>  static int usba_udc_pullup(struct usb_gadget *gadget, int is_on)
>>  {
>>  	struct usba_udc *udc = to_usba_udc(gadget);
>> -	u32 ctrl;
>> -
>> -	ctrl = usba_readl(udc, CTRL);
>>  
>>  	if (is_on)
>> -		ctrl &= ~USBA_DETACH;
>> +		usba_writel(udc, CTRL, USBA_ENABLE_MASK);
> 
> Could we add a comment in the function as well? Something similar to
> what's in the commit message:
> 
> /* Some chips don't reliably drive DP/DM lines to high impedance when
>  * using the DETACH/PULLD_DIS bits.
>  * To ensure a reliable disconnect, power cycle the controller instead
>  */
> 
> Feel free to rephrase your preference.
> 
>>  	else
>> -		ctrl |= USBA_DETACH;
>> -
>> -	usba_writel(udc, CTRL, ctrl);
>> +		usba_writel(udc, CTRL, USBA_DISABLE_MASK);
>>  
>>  	return 0;
>>  }
>>
>> ---
>> base-commit: 4d3b5c679bc9d5c6cbbeedcc1e4a186f1cc35541
>> change-id: 20250602-pullup-83c5540db5cd
>>
>> Best regards,
>> -- 
>> Zixun LI <admin@hifiphile.com>

