Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EADC87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 09:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0DE1844AE;
	Thu,  7 Aug 2025 11:27:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IywDIay3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F424844B4; Thu,  7 Aug 2025 11:27:20 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50E34843E3
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 11:26:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b8de193b60so354663f8f.0
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 02:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754558782; x=1755163582; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gNlBdVQ+sVV7Hdu75VuXsfXJtcJdlM3xhzvFArgcbe0=;
 b=IywDIay3vc4B9AD2kJ/7UiNbe2zxrDIFi4IZxugL5ep8V0ICScaMStFDO3L/BmWaFk
 0mtUOtzVso2/3Wnd0Cj+S0AuWoB2Yebt63lih7EsWjHIYgSmFuRwwJX/4LOKw85BpajC
 hyV2oWaxiUNJXKxzbuquQYmhuv5in+aWiwUT4flejmi3P0hS1JoZ+ZXrn/hc5b41YN5T
 jdqN76z4eZm1uNnNIgnw7ChayhH+4kCSH8O0zNn3GrAiaG2z9RXWyY9xaQAL7yv52BpR
 zRWqEo0nzKxgSwHamf5ZWhC7qfJKWd27Cw8nXKxGPcR55yKhTyMsZV7XsGatEsBqSUpk
 5VBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754558782; x=1755163582;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gNlBdVQ+sVV7Hdu75VuXsfXJtcJdlM3xhzvFArgcbe0=;
 b=PQOkVKre/dWlWXl9hUnNgky2ArxIKLD3uVe5JgX6hIgeMqmfTAoNlO3GiGGt5ukN9V
 mvojgowPBsqz6OJAty3swziE0J4nK27KRfVnvKELDNKZtcCzHv1PW26G9Fhd8/0MfPUB
 6p6VEF6xtuv8dcYsaa7gzlzp1CPvFwvkPP+7lcyudzOeH1HcGDQcq6zDiPwnkmw3q1+Z
 XV47jVOM/w3XXSaGZPfUO2WvjzlebsdvXQ30KLEnXOAqFj4e9WSzogMPbowcRZbNOVMC
 o1z/PvNXWg9wvqG3DTdmUWW4R20X17Mff5FT4L44EEiyNiYHzpJBSa2bqUiYsR84QLI9
 lhYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDDd7zrFimuCb/CtuIRAVfFCYOVeQfk246H+lnp/HgPM5TjOY69omGcdnJhZVcvDS5lntCZwI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8E93589siVvwcqvYRYfPlpIq2xb4Bvd2wdX5WnI43pL6es7Kg
 tTUgIR6X9eA4B1w/3IkgtiRRQr0Ug5ybjNjJFjEDtxqR2PxyH4LR2CIUyAf+pfc/weMnqQM6phX
 w6KpA
X-Gm-Gg: ASbGncsC5vIGhDQJRd89q/ak9l3e94gHWqAxmYiak7VE/bat9oTErHebFhhjhHMxnaB
 3bmX2sb19l689fdZuAMl40UWLFZgT+tsm+xxVf9A4P4ZlE40Tkh6LqZ21Zkd1UlVjczhG5jE0HY
 lhHsko6/0mpm4/fHhV4tNXxV24mLJ5kK+Z9BYNdnAN38TVkCe44SGs93/F5s+x0RWEqcEdFx0Uw
 0ZNqLXaOqNNmLEGkbi4e+xyETuXtaEJbgeh4anDj+/vOfZY9vV45YtARVdPkB/Dev7kC4hjmKX9
 ZuhuCAwkJeqSh/y1QAs/yppbvIWQMlaAojxH7g+yeQ7w6HGJPEQV1vOoCFtyH8lzzbszSGX7DN+
 1uLTRtDybykVrevGOAwTuAYeD9lRb7oc2BEN/2h4lp/6L506VdmYBD8ZotYNooBmH1klein5u1I
 v6Zg==
X-Google-Smtp-Source: AGHT+IEGAJBVN3goHUy/Nnk2mbhdxOCOJ1HbZVtxiC45jYdwLnAoIQoghXX2rDbdH9gMdjS+vYBGxw==
X-Received: by 2002:a05:6000:1acd:b0:3b4:990b:9ee7 with SMTP id
 ffacd0b85a97d-3b8f41b2ed4mr5361318f8f.22.1754558782371; 
 Thu, 07 Aug 2025 02:26:22 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf?
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3b9386sm26081067f8f.18.2025.08.07.02.26.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 02:26:21 -0700 (PDT)
Message-ID: <f4412516-2ebb-457c-916b-1a8f1f14783f@linaro.org>
Date: Thu, 7 Aug 2025 10:26:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: nexell: Cannot test unsigned to be negative
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Stefan Bosch <stefan_b@posteo.net>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250807-pinctrl_nexell-v1-1-6f49a0656510@linaro.org>
 <CAOf5uwme53zTzVLe08NrFRqVudNYAXouJ2ggvxCjx49iksm6Pw@mail.gmail.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <CAOf5uwme53zTzVLe08NrFRqVudNYAXouJ2ggvxCjx49iksm6Pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 07/08/2025 10:19, Michael Nazzareno Trimarchi wrote:
> Hi Andrew
> 
> On Thu, Aug 7, 2025 at 11:17 AM Andrew Goodbody 
> <andrew.goodbody@linaro.org <mailto:andrew.goodbody@linaro.org>> wrote:
> 
>     In s5pxx18_pinctrl_set_state testing count to be negative will always
>     fail as count is unsigned despite receiving the return value of a
>     function that returns an int. Change count and idx to be of type int to
>     allow the test to work as expected and remove the need for any implicit
>     casts. Also change pin to be u32 which is what all called functions
>     expect.
> 
>     This issue was found by Smatch.
> 
> 
> Nice to have the link to the tool. Is it possible to have it on CI?
> 
> Michael

Hi Michael,

I intend to look at what needs to be done to add it to CI once I have 
gone through my current list of issues. So yes I very much hope to have 
it running in CI.

Andrew

>     Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org
>     <mailto:andrew.goodbody@linaro.org>>
>     ---
>       drivers/pinctrl/nexell/pinctrl-s5pxx18.c | 3 ++-
>       1 file changed, 2 insertions(+), 1 deletion(-)
> 
>     diff --git a/drivers/pinctrl/nexell/pinctrl-s5pxx18.c b/drivers/
>     pinctrl/nexell/pinctrl-s5pxx18.c
>     index e7d0994f29e..a6ae5764fbc 100644
>     --- a/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
>     +++ b/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
>     @@ -130,7 +130,8 @@ static int is_pin_alive(const char *name)
>       static int s5pxx18_pinctrl_set_state(struct udevice *dev,
>                                           struct udevice *config)
>       {
>     -       unsigned int count, idx, pin;
>     +       u32 pin;
>     +       int count, idx;
>              unsigned int pinfunc, pinpud, pindrv;
>              unsigned long reg;
>              const char *name;
> 
>     ---
>     base-commit: 3526f990b77fca1c933f1d8b24eb9385010a05bf
>     change-id: 20250807-pinctrl_nexell-bc6669ff52e9
> 
>     Best regards,
>     -- 
>     Andrew Goodbody <andrew.goodbody@linaro.org
>     <mailto:andrew.goodbody@linaro.org>>
> 
> 
> 
> -- 
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com <mailto:michael@amarulasolutions.com>
> __________________________________
> 
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com <mailto:info@amarulasolutions.com>
> www.amarulasolutions.com <http://www.amarulasolutions.com>

