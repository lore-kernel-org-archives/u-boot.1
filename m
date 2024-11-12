Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725C5D42BA3
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 15:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD4828915D;
	Tue, 12 Nov 2024 16:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zvdEQQnk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FFB38915D; Tue, 12 Nov 2024 16:59:07 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 125CD8910B
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 16:59:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4316cce103dso73446975e9.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 07:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731427144; x=1732031944; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dy3oGJEQM5cXoDAwYVo/hFYFRod8PLS9B80FdKxZLpw=;
 b=zvdEQQnkgKAlBhXIr31HL24tAg9yYm1WfiKTVBnaTl8XbncbfYks0ckkB9/HEk5uln
 19ns5VCvn8/74Es84py6fNRAu0GwdrC6r5nJmeb/+kW6mK5s3nJRJbDrkj7CHNQfXMYS
 y5ZI4PFue/epFyAK6jLgQPn77nM2mVPrEO8OJ+s+NSfM/o7HJ15kqHSGoVRaeFj3odcB
 yQVeteSIWK1XljVvSgEl6HQKAFM3PvvvSoZbVGn1gi5mPklDyBe+pvw6X8l6gKKC9MQw
 SKaQjEnJ5T7/LrbiP/EEIz8GvTwyFNVAuuOHz+9e0DlS7k0J6FnMFNavxwx09nIIOUmg
 iePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731427144; x=1732031944;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dy3oGJEQM5cXoDAwYVo/hFYFRod8PLS9B80FdKxZLpw=;
 b=hbDdrtyJg9RWcEvUoAavTcRFz8Z+Fc8O03MY+Qcp4Ltriarj8IIbr+rCEw8Qghq9HK
 D+bipjQPOALaDuO+2XRF7If0ODAGjbYKIZnMIIzHlCJaOhiGolDfZMF8ymkEamG9Gh1M
 CsgD2OQJeJ81g5ZTjlk+iCrfBr7p+beF8TNc6XVtGiiEE7bT4rxcg8YdEj5TskG56Rub
 2PbKI7qcdcIFTDYL+Gfoq2obsaopbj5XvxyPso59CLvuFWngjsohgN+J6UYTY2lWEHCM
 EFd/ojvsp7+FrAI62lOGtanc+a/fOGumE2yLuzIolsEX7jrYp0Fp87hwZX7hAct+E/DE
 qO2g==
X-Gm-Message-State: AOJu0YxHihCepllm8af8Y0xJqoB4YLfUVvguWNYaP3B4wuIORZjodmIk
 bO76+iavz4Hrnu+HPUYWoNDpkCeCK4RQxFOthHZUC0vLwjxusDOITLkQUgVRK8E=
X-Google-Smtp-Source: AGHT+IESBSjzWoUq107TsTy1FAyxBDpEyUJm4yTIPU2vTrTd73ye8rwqWLPCF1mJd6h3Qa2JK4GB/g==
X-Received: by 2002:a05:600c:34c8:b0:431:604d:b22 with SMTP id
 5b1f17b1804b1-432b750acc4mr184411425e9.16.1731427136306; 
 Tue, 12 Nov 2024 07:58:56 -0800 (PST)
Received: from [192.168.0.187] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381fc0f5f91sm7268727f8f.62.2024.11.12.07.58.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 07:58:56 -0800 (PST)
Message-ID: <fc0f7532-c260-4b6d-b8aa-5ce2ff2deb6f@linaro.org>
Date: Tue, 12 Nov 2024 17:58:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] gpio: at91: Implement GPIOF_FUNC in get_function()
To: Zixun LI <admin@hifiphile.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
References: <20241018202715.283011-1-admin@hifiphile.com>
 <2637a7bd-fdc6-4102-80c1-43d0d058cd97@linaro.org>
 <CA+Gyqebjmuiwn0UyUEJK0vh7wimTkGXPeVCrf7feYxzFLF_Oxw@mail.gmail.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <CA+Gyqebjmuiwn0UyUEJK0vh7wimTkGXPeVCrf7feYxzFLF_Oxw@mail.gmail.com>
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



On 11/12/24 17:57, Zixun LI wrote:
> Hello,
> 
> 
> On Tue, Nov 12, 2024 at 2:13 PM Eugen Hristev <eugen.hristev@linaro.org> wrote:
>>
>>
>>> +static bool at91_get_port_pio(struct at91_port *at91_port, int offset)
>>
>> The name get_port_pio is a bit confusing, can you rename it to something
>> more meaningful, like maybe is_periph_func or something ?
> 
> How about at91_is_port_pio_active, more inline to the datasheet.


I am not sure. It appears confusing to me.
The pin is either in GPIO or peripheral function mode.
Being 'PIO active' appears to be something different, or common to both
options.
What does the datasheet say exactly ?
