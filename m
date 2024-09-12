Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624E4EEEC13
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 05:11:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B47989161;
	Fri, 13 Sep 2024 07:11:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w6wM0ic5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 693E788FCB; Thu, 12 Sep 2024 15:44:36 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B50788D57
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 15:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c26815e174so1213363a12.0
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 06:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726148674; x=1726753474; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e0WPQ550hPvLa3SioZTPL/OqGGzpHJ/ygLGNjAmw5WY=;
 b=w6wM0ic5IsIA/ySrtvgHiWA674VOJEt98xK3vOA4wWqWVquM472cw85hReBxvZpkf9
 yv9K/HbGcn0Akxlie6wgsOnwoSIHsS8dBHnvhKnUsco7CsgWLiYQBBV0tKJpzfJZYpjx
 o7HuiJB8s2HH5X1YPQao8PcAC8CuJOMTwzx9rzsHMZ2wheic+yCdjC8yZiVJMmHWhAQe
 2tOWWx0Mmv5Xwhnw1B5SwH7vGCAIivWB517o+dS16etlqp2x3ggk5kPZ9FTG0/Af9M6a
 PpXiKfcld6o1x83sDihw3RVJoxrpx/YvsRWemeM9V2bSNXuqQkH3XZWjrUsC/F+558wc
 Etzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726148674; x=1726753474;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e0WPQ550hPvLa3SioZTPL/OqGGzpHJ/ygLGNjAmw5WY=;
 b=wNL+dYGH2HwfR/fx/8o75lV8Lu3UdJHBP9KR4cPvPlxXTSdRLXsVDc+pkf/Bt9si1F
 hBn+BzE562vu/duyBiegYLQMQ0Zc2/U54gFZnw/oBcUOXvuNsrbKRieemq5F/KKcI2Bg
 u8+QJqCL4MyrBpNNpEOiZsqsCQSDaW69LqEXCyXc0ZCUIi38TC6PODjjRSQhWgPvI+yh
 whsa0a5/Ea1wrxjM/1CJywFPdkXOYTxJf/zwxJOVajbcYAnfpHeGEnMkystj4Q8bFWPA
 4SvR84OTDJkJmJOJmlzWgaRcsNa3FqVJWtNXiSK3ow2aUF/I0lR/vqxS/Biw6ObwpYJH
 OEUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5HUrAEQpnzdN9fvLOFBTwfSag/oAIKEBNNgs6LTjESkGec8bMa0y7qnxUC0eLQMPBhusupEQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyPvzkYdVubNozlXNncs+5gFLoUdSX1BMqvMoJ0GS5Porpuquuw
 EFB+GMLonj6mW6dCgL3gKg5QsTs+8puM5mHWtGIjnKDps781mItAlOaIo6duGNM=
X-Google-Smtp-Source: AGHT+IFCarWuFX2J+iMEmRL4oR48oInss3hgjVqa/ghF9D7Lh6IeHPziCD1v6Nwu8Qh2jF1dLEODaw==
X-Received: by 2002:a05:6402:380e:b0:5c3:cd88:a0a with SMTP id
 4fb4d7f45d1cf-5c413e1ed2bmr2409997a12.18.1726148672987; 
 Thu, 12 Sep 2024 06:44:32 -0700 (PDT)
Received: from [192.168.0.157] ([82.76.204.5])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd52167sm6624438a12.55.2024.09.12.06.44.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 06:44:32 -0700 (PDT)
Message-ID: <20f9807c-ab8e-4cea-9a2b-446dea1adb85@linaro.org>
Date: Thu, 12 Sep 2024 14:44:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mtd: spi-nor-core: allow overriding 4-byte OPCODE
 support
To: Robert Marko <robert.marko@sartura.hr>,
 Tudor Ambarus <tudor.ambarus@gmail.com>
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, trini@konsulko.com,
 u-boot@lists.denx.de
References: <20240425143627.54648-1-robert.marko@sartura.hr>
 <c399216d-34d1-435e-96a7-6716f9f2c32c@gmail.com>
 <CA+HBbNGSZ3enyCF9cT8_1qJYt7TndDKJ-OYYe4EaS6_BTPnbRw@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CA+HBbNGSZ3enyCF9cT8_1qJYt7TndDKJ-OYYe4EaS6_BTPnbRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Sep 2024 07:11:16 +0200
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



On 9/12/24 11:07 AM, Robert Marko wrote:
> On Tue, Sep 10, 2024 at 9:55 AM Tudor Ambarus <tudor.ambarus@gmail.com> wrote:
>>
>> Hiya,
>>
>> Please specify which linux commit this patch follows. It helps reviewers
>> and gives credit to the linux author.
> 
> Hi,
> There isn't a specific Linux commit for this as far as I can tell.

How about the following:
548ed6847f53 ("mtd: spi-nor: Add the SNOR_F_4B_OPCODES flag")
