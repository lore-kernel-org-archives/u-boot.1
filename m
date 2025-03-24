Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F34CC36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 13:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4856805C3;
	Mon, 24 Mar 2025 14:36:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uLWIicRG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8766B805D7; Mon, 24 Mar 2025 14:36:47 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C52680548
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 14:36:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso30307255e9.1
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 06:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742823403; x=1743428203;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=3SPuYj2Ysc1IbKshK1bcbJk5OrOP21NNdDaIhJpCBwA=;
 b=uLWIicRGF7SgOBTkotKEqYYejZEzniLGUjypuQWM7iDjOMe1gdqJCovLPXGvd+rsP+
 ge0hO9Pd1OjpSWn6VHLioAj0n0/Ul4ovXsdYp1DZ3MhrOD+Lec5CEbMIeAkcDncdH8yT
 09sqGTRZI371k+4Q7cTPqsDsdWmKWJ6xYuOEb9rhgiJ60Q+F6pvySdSGz9RjYFEs78Q3
 +suka6uKda1aFX5xMZEg0DQDdAoqZqXGBmDZFV7DQKZG0lV7VIMruJvFu9HvejO3l/Nt
 gs+aQPiqnGoO9ohAvDKdVX6jQMMn9nskoQTtV5E2CkodeXQ5fw1azSNgecpKi8h6nox7
 m/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742823403; x=1743428203;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3SPuYj2Ysc1IbKshK1bcbJk5OrOP21NNdDaIhJpCBwA=;
 b=hdPQF7AqBkbtHM1Lwtsi+1U+R3atd7GNHNTYcioMyljJfMI+vyQAMc3FIb7FtWp+IA
 +O/zUlB6X5kFFzX9gwe5rBYgsKQpv15YOAcBHVs3lDGOxiqkiYOcvw1i1G5JcgLlks80
 4Xs8mycXvaWxG5WJw//t+ul1jvV22QAoJ1gDKNzOmumMRC8guge8/EVArYQbLw2tNtuC
 U8xwlLbzmuDXYUAl9HR47uZls+ktF3ADG4OfOtLoZcKefLQ1KF0l/5n4hrsGTKMheetg
 PJEqB0YuYTXIhkzMNWNw6YnxaM3HNNh05ndS/TWZvMeij3h2PHcfckTP97P1Vzh7Vg/M
 Mr9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuZarDzpLIqQSjnw1nH/XkovYp/2sgbUeEhY1uENQ4d3sd2eqrgdY4Y6tPZxw6MX4YMkcBmwM=@lists.denx.de
X-Gm-Message-State: AOJu0YxfgnHrkVN+Xz/ZKeK7Yd3TkFu/XUpigv3vl5g+iYhtU8YHrit4
 QVInSFFxokocYyjLlkjLQbhE7TOPDb7lepAobd9aeeAItsXpetcra4A7R7Af+M4=
X-Gm-Gg: ASbGncuHDy380lmuQK/uMKb9aT3DUKy/HCoIpYylnqnGWCG87SoUOmpyECS9w7hZ7Ws
 t5JFkgjEeDwfGieRKy/rar36h74OviQFytf8TzV3wet1HOmJL9pDJfReQX5cUTsll/x8xnv4Hpr
 CjnmzPaNN2incnQvleGokvlVI4vLQrS9jkjRNx/4V7uP2xFl6SKs8DQiG/LURF1zc0iPDkdqqXm
 +d7F1/t5iTrUlCVV4TgX1Ajpgj/Rli7nodtfXmYSXdTKNbbLpGvgTCTVgkNCTlqrkwJGFNM3xES
 r/iLxQprYwjbUpKM+PSboE46JFWqcHsuwAtIK8oa6hLTF4K8NquETPUuEqYZfj0i
X-Google-Smtp-Source: AGHT+IHoLJb2hp4rhm5rgIrPYUU3NjmCq6z5agBYhIWrkrzy9v8AdwEVPR7LY2oXrIPb3QICw1Z47g==
X-Received: by 2002:a05:600c:1e07:b0:43c:f61e:6ea8 with SMTP id
 5b1f17b1804b1-43d509e3b14mr124391685e9.2.1742823402536; 
 Mon, 24 Mar 2025 06:36:42 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9a3a10sm10868592f8f.28.2025.03.24.06.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 06:36:42 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: neil.armstrong@linaro.org, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>, Felipe Balbi
 <felipe.balbi@linux.intel.com>, Lukasz Majewski <lukma@denx.de>, Thinh
 Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Fix match_ep callback for NXP UUU tool
In-Reply-To: <8214b374-b268-489c-b80e-61b0780f72e5@linaro.org>
References: <20250319220805.219001-1-marex@denx.de>
 <8214b374-b268-489c-b80e-61b0780f72e5@linaro.org>
Date: Mon, 24 Mar 2025 14:36:41 +0100
Message-ID: <87jz8eeeja.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Neil,

On lun., mars 24, 2025 at 10:20, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> On 19/03/2025 23:07, Marek Vasut wrote:
>> The UUU tool excepts the interrupt-in endpoint to be ep1in, otherwise
>> it crashes. This is a result of the previous hard-coded EP setup in
>> drivers/usb/gadget/epautoconf.c which did special-case EP allocation
>> for SPL builds, and which was since converted to this callback, but
>> without the special-case EP allocation in SPL part.
>> 
>> This reinstates the SPL part in an isolated manner, only for NXP iMX
>> SoCs, only for SPL builds, and only for the ep1in interrupt-in endpoint.
>> 
>> Fixes: 1918b8010c32 ("usb: dwc3: gadget: Convert epautoconf workaround to match_ep callback")
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
>> Cc: Lukasz Majewski <lukma@denx.de>
>> Cc: Marek Vasut <marex@denx.de>
>> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>> Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>> NOTE: This should go into master as a bugfix.
>> ---
>>   drivers/usb/dwc3/gadget.c | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index e5a383407a2..477ecd02098 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -1631,8 +1631,25 @@ usb_ep *dwc3_gadget_match_ep(struct usb_gadget *gadget,
>>   		return dwc3_find_ep(gadget, "ep1in");
>>   	if (usb_endpoint_is_bulk_out(desc))
>>   		return dwc3_find_ep(gadget, "ep2out");
>> -	if (usb_endpoint_is_int_in(desc))
>> +	if (usb_endpoint_is_int_in(desc)) {
>> +		/*
>> +		 * Special workaround for NXP UUU tool in SPL.
>> +		 *
>> +		 * The tool excepts the interrupt-in endpoint to be ep1in,
>
> Small nit: expects

Argh, I missed this :( The code already landed in master:
https://source.denx.de/u-boot/u-boot/-/commit/0916053ebc566245b06d0a179533f6622b6ad392

If we have to modify this again we can fixup the comment typo at the
same time.

Thanks for catching it!

>
>> +		 * otherwise it crashes. This is a result of the previous
>> +		 * hard-coded EP setup in drivers/usb/gadget/epautoconf.c
>> +		 * which did special-case EP allocation for SPL builds,
>> +		 * and which was since converted to this callback, but
>> +		 * without the special-case EP allocation in SPL part.
>> +		 *
>> +		 * This reinstates the SPL part in an isolated manner,
>> +		 * only for NXP iMX SoCs, only for SPL builds, and only
>> +		 * for the ep1in interrupt-in endpoint.
>> +		 */
>> +		if (IS_ENABLED(CONFIG_MACH_IMX) && IS_ENABLED(CONFIG_XPL_BUILD))
>> +			return dwc3_find_ep(gadget, "ep1in");
>>   		return dwc3_find_ep(gadget, "ep3in");
>> +	}
>>   
>>   	return NULL;
>>   }
