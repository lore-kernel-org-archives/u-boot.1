Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66822C36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 07:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9558480AE1;
	Mon, 28 Apr 2025 09:28:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c0AtF4kR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 543AF80BAD; Mon, 28 Apr 2025 09:28:41 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6EF6803CC
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 09:28:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ac3b12e8518so756786266b.0
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 00:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745825318; x=1746430118; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jw0A0Bu8AarKKY1qV0Mq0D10MUbbwwpjzUxIvKxn51Q=;
 b=c0AtF4kR/o+5WPNc+Mk122og5eA4PgSTOJTVz4FCkSZ6RytbZwK7YNNvRvlei2Qzok
 Q+bFbx4oTMyEu4iecYHLfGAA0MnhpxdsDk1LrROZCb0W8HQCqzeZYChsXtG7/5z6DW6h
 tqAxMgd5bSbnyqwW+gYoevpwwtQG02zBLrfaLI2PczbczBoCO3n97QRanqueMWa3vo3O
 GYOhljwGGKDxJYcwGFHGRPlMRpzqCPlRvCwy89UhvuZeRNc75L0+ETQ5z3mf+1M4wCMl
 UNc6hQrELkmp8FaS/hQqc2FNQ3KPFfCQyDo+vxH6xSPG/4o75KxLIxCGKuxjA2rbR4jH
 sv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825318; x=1746430118;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jw0A0Bu8AarKKY1qV0Mq0D10MUbbwwpjzUxIvKxn51Q=;
 b=qhgnUQNPLZuDfT2uDK5fqQUeYBkWewRaJlhtOnwCnP53b280ohDMANRW+3+GbMu6Qt
 GYYWsTLHRvn69N6rQoSARR3E5JQBCinPSfMIK/qOwiVBCvi5NUkNQvyocV4u2mNQ/gN7
 hyVai2pXnW7K+VPvCvnJYSKaSgGS7ZIGSi+YjKR0q9lXWUXYb85lYFeisdZNORQ/Ir0R
 8nE3B9t1c/Cx26HYI8b6ZdFisG2kFAXZHNp5yNkZmU+oQ6ldOxREcftQnzwgk0XXg2I5
 eR2OeqA5j+no9ciZjP9FqV7rwYcBkocYGcr8G+EYO5/kh/UZ2Ih1ynZezjjETgk7zLBj
 u+8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV39oMYbL2IJWFsBt0B2BQr7D6bsKc042nNTaA5Y5AaXl9GprLmKA1ySvXB6WuowVeBOSihwO8=@lists.denx.de
X-Gm-Message-State: AOJu0YybFdkDAWejt+TQWjXrxzIH85lknSl7jHKDqnNPG97NjdAPu+bn
 Hi2gau7j2xpUqqm6AMTH2+CG1pVlaGRRs7SuufvqFDtSjw05b7Y+mScYwRuBOmx8iBHnXKGAemb
 C
X-Gm-Gg: ASbGncsvo6a2MYilbxYnAQEHXjET0q0KU9uN8Xqp9p5PDVOqOLkw8TtdNvZp4qXlzBK
 9lDJyJ+xYntIOleBovcxIzKqcR/SB6gixQhxA8Q3YTk9QOYDIIhhaz6lY6LFR0YFsBxJq9E0sOP
 Hw3s7QsdCwVQFRSZqLkE/AjLvysodPk5SIrokpkHdiZn8M8FrdAMUnkVcTbvmA1CY2eHkGUHrgD
 FBaEW4unBXPcKjD13pn2gFvQSznB6bEpt8wexZEbmJ5pUwMCUypa7VO48exfB673fYtH00zXxrQ
 SwmHivWqoK60du80l1DPR6HxPnh++CTcdT77JR/GQXCndEwU
X-Google-Smtp-Source: AGHT+IH+MYybtjbgMya9NEzA1sTbZdOlGwPAH7qy/+KIjvjD8Qg3ZXKTvvCikvRHPUxuN7a4BV2a6g==
X-Received: by 2002:a17:907:9721:b0:aca:a686:8558 with SMTP id
 a640c23a62f3a-ace848c02demr566895766b.6.1745825318311; 
 Mon, 28 Apr 2025 00:28:38 -0700 (PDT)
Received: from [192.168.0.32] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6e41c6b1sm584050866b.14.2025.04.28.00.28.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 00:28:38 -0700 (PDT)
Message-ID: <1a6877ef-175d-4faf-a9c0-fccb23316bd6@linaro.org>
Date: Mon, 28 Apr 2025 10:28:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] ARM: dts: at91: sam9x60-curiosity: Enable watchdog
 node
To: Zixun LI <admin@hifiphile.com>
Cc: Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>,
 u-boot@lists.denx.de
References: <20250417-wdt-v2-0-49939de473e1@hifiphile.com>
 <20250417-wdt-v2-8-49939de473e1@hifiphile.com>
 <119e31f2-72a8-4826-9c92-4db928a1020c@linaro.org>
 <CA+Gyqeb+_LNGi0qa7S9M1E4LjJPe=O3anf9AFVrm3cOcZB83Tw@mail.gmail.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <CA+Gyqeb+_LNGi0qa7S9M1E4LjJPe=O3anf9AFVrm3cOcZB83Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 4/25/25 16:50, Zixun LI wrote:
> On Fri, Apr 25, 2025 at 12:51 PM Eugen Hristev <eugen.hristev@linaro.org> wrote:
>>
>> This 'timeout-sec' property is not in Linux DT. Any reason for adding it
>> ? is the default different in U-boot ?
>>
> 
> The timeout initialization is different in Linux, where the driver's
> default value (16s) is taken during probing. On U-Boot without
> <timeout-sec> the timeout is set to default value of 60s.

You could change the default to match Linux, or, move the timeout-sec=16
to sam9x60-u-boot.dtsi file

> 
> Since at91_wdt's maximum timeout is 16s, any higher value will be clamped
> to 16s in the driver. I think it will make some confusion if the logs says
> watchdog has 60s timeout but reset happens earlier:
> 
> WDT:   Started watchdog@ffffff80 with servicing every 1000ms (60s timeout)
> 
> What do you think, should we add a warning for the actual timeout ?

No, one of the options above is better I think

> 
>> I would add the support for sam9x60 as a single patch, this one and
>> previous (patch 5) which adds the registers definition.
> 
> Which prefix should I use, arm:at91:wdt or watchdog: at91sam9_wdt ?

This would be driver support so I think watchdog: at91sam9_wdt

