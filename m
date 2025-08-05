Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACCAC87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 11:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C9A683403;
	Tue,  5 Aug 2025 13:25:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HzDteR9F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9D4583321; Tue,  5 Aug 2025 13:24:52 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36DF083403
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 13:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so47396205e9.3
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 04:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754393071; x=1754997871; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lo9bIupYWPAxmkVEta2YeYfOk+MRjnFOlUTbuMn/y54=;
 b=HzDteR9Fs/+cPyqf9q5U0EE9cUzwaVBVXjRjL3qAXnNgcZUi7G/Xw9AoAVt81DYItJ
 607mVRbboG+gSx1LxCWvs9aOdnHjgK++byn84S+vV75/zaGPwqTqKGktLk8peutHbwT/
 fD6nw8cacg3OYESE1cuQaE2YJA5bjknKIMcmetEHpP099Di9V7gnlVN1PY5MeT7AuwOj
 PVaQuMnom3Y0d05GX4A84wRirlLhfZ3vnXQA7vzlWEWQGcE7oz9FyxEp825Jzm6EvymD
 4xzxvB9yZuE/CLJKJzqdEKlsWr2VFoXBlep3oWaM+z1OSSXoKqmHheNv9ZLe9KghGMqR
 27dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754393071; x=1754997871;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lo9bIupYWPAxmkVEta2YeYfOk+MRjnFOlUTbuMn/y54=;
 b=MiuC8NGsrcOpFhhmXxieySmXAagG3CkvHk1c7Anc7KHgAyrNmBqo+EBZTTborq/Rh8
 I874WgDqNLzQJhJwe+arn3/O6LtnQzZa3BpIO6krHAtAeaZO9EppR8OEHG0wJJ7Vjjv5
 cuEt5rdneWiHq34FpElfMCTo+KDge3b9NfCq9qXqYHbEC1nOxntMzRe3k21wx5x0J1uJ
 e3X/GZU0rctrU8MmIpYs+4Da1AEFF4xwrimn3c8ucgN3YcjBpSHcX9eaWQjm/+7aECi7
 wJ/lpXLvJoRxwahu26/bKTFcYRqvgwcklaoDEzNQXq2OTAVIrWjSK90YA0yZrU05msfj
 wBgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB3Et0+ginl6SSJeqpOaQiaX0tfOQOcQroeu7Kg5QjQ7tm6+z4RWv2m/0RF1SDyIFbDeR2FjU=@lists.denx.de
X-Gm-Message-State: AOJu0YxGLjHjnliWc3O12MEUY+Z6XfoZkzG9cYSZYZd6t5xptLY6nU0X
 7AHX//R8LJkPaTzCvTEvPdzP01khRg/ZUvL6dv8nui3W/A5KkAJ7Nc/HGp18M0zeF30=
X-Gm-Gg: ASbGncsaXPf7p1FtYrDSqWpSsxfGRRUy3PuTxRC1Wr2F7cvFr2hXEdvtkYBZUmmAoCz
 +Q92mV3yGcwGRj4QHXyCSzoHfaYFiiRu5cG+7DdGu8T/w1zGEBo6uG6Q7i1GlxQZHMcqYD3O8oN
 /RfXK0OdNs1v7UNf92TFeh0mi2aP7jLNaRPkvJrJ0DSjrrD+O/GvWSmXXR+ad+YAwbbuKM/LoY5
 TUw5XO/UFfvRWkZvvJep6UfEZZdUFnl5NMeBq77oSEgUoqtpbt2UXci/PXmxzCFbstBU3AqfqGs
 k4yfIxzFueHtwfB66wpxVlhbupLLu0q0QqlIzs6VDuOu7BG0Ctv9WnR3WXymRZIxZ+Y3FT0znpR
 Tfq9CdW3glgSjCEtHrPVJu+BYq7L6ePJ5aBVxTBLJ6rI7EeRJwH5GGXhzmDzIjuj6hXwSCZK7Lh
 lQVARD3yyGH+j/
X-Google-Smtp-Source: AGHT+IErTBwcK3/9nG2g3qNCc30y7sRz+z39fGETtRWUqTIDv5EO7nHMqvxmT/lTxrTnozAOlGrx/w==
X-Received: by 2002:a05:6000:2011:b0:3b7:8da6:1bb4 with SMTP id
 ffacd0b85a97d-3b8d94d07c6mr8588755f8f.58.1754393070561; 
 Tue, 05 Aug 2025 04:24:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35?
 ([2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c469093sm19005224f8f.51.2025.08.05.04.24.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 04:24:30 -0700 (PDT)
Message-ID: <b08feb33-3667-4810-a384-3d5451f09b07@linaro.org>
Date: Tue, 5 Aug 2025 12:24:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fec_mxc: Set error code on error exit
To: Fabio Estevam <festevam@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250804-fec_mxc-v1-1-1ed9b5df2828@linaro.org>
 <CAOMZO5DdypLP+YMagDm5Xa6Jk2+a-8qb69QtGsgfgdtHc-m3MA@mail.gmail.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <CAOMZO5DdypLP+YMagDm5Xa6Jk2+a-8qb69QtGsgfgdtHc-m3MA@mail.gmail.com>
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

On 04/08/2025 21:36, Fabio Estevam wrote:
> On Mon, Aug 4, 2025 at 12:44 PM Andrew Goodbody
> <andrew.goodbody@linaro.org> wrote:
>>
>> In fecmxc_probe if a timeout is detected when resetting the chip no
>> error code is set before taking the error exit. This could lead to a
>> silent failure. Instead set an error code.
>>
>> This issue was found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   drivers/net/fec_mxc.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
>> index 54b08482b91..ccd5589318e 100644
>> --- a/drivers/net/fec_mxc.c
>> +++ b/drivers/net/fec_mxc.c
>> @@ -1344,6 +1344,7 @@ static int fecmxc_probe(struct udevice *dev)
>>          while (readl(&priv->eth->ecntrl) & FEC_ECNTRL_RESET) {
>>                  if (get_timer(start) > (CONFIG_SYS_HZ * 5)) {
>>                          printf("FEC MXC: Timeout resetting chip\n");
>> +                       ret = -ENODEV;
> 
> 'return -ETIMEDOUT;' would be a more appropriate error in the case of a timeout.

Thanks. V2 sent.

Andrew
