Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E589C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 09:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 982C882E52;
	Tue, 12 Aug 2025 11:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Yb/JwTNQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9103682EB8; Tue, 12 Aug 2025 11:17:51 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 525A982E37
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 11:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-458b885d6eeso33486695e9.3
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 02:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754990269; x=1755595069; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=btr7nWumw6ZOAn3LzoF9n8u6URpndVqVeIP3ycuaBTo=;
 b=Yb/JwTNQlyketV3yHG4UOYCO9Mdne45jiWcx5mQtG6liZfExqhLKBnCiIm4L0zgNdm
 6zqjMtRCNNPqjTLOhn4wpxgIqGOoQsvBn36CCZjQHenJVcXxHF17hY10OSfbpugPJzPf
 J08E6lwGkuLXFewgJ+6U2itMp7JhkDq3bOGkrj3qmRhtquiHvuxVBRwSVyaT9Nt89t0P
 zae95PN/+xHFo8HwX+3xNsfNh+zzxAlOOVoqLyVCerKu92iDtCYd8l5Bsz4Wx4m5zNNy
 pHPzwcw+UdVP7oqTHXrcNo5SGlsq9jM3Gfrq3/Jv/w+1GcNuM0odru25e0P/A20ACe/B
 qGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754990269; x=1755595069;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=btr7nWumw6ZOAn3LzoF9n8u6URpndVqVeIP3ycuaBTo=;
 b=QzjLE7XBSvP8yPUPIjw1qYnBoe2EsokzdbTiMyhceVQhlPG5v8MNsXKtRSS1bPL9O1
 OitydR0FLhV69i7F0uPUCaUOXJkqTkArMa+QhQVHF0vF1AGnUcF0pI6hZG2OAxhUR4Up
 +GLCMyNCnGr/K+E9ns7L8qPkwn+f6VrNpuFwTN2V34Teq5LxwwYWdM8MBDtLpzh32YRH
 2o7YjtXMAYwQC7s53DKQXhYC3WiYJnHcBFsIbRROBm4+F24b2Dr11osMjFdKxuWdLOar
 iLq/bMxWr/t3KhehWaZDjtxwa1+FXf2YPYkcQaiyeC6JJCxAUhe+faDIb1W8F+GDPOmu
 pOfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+eR1/xuhCjxm+JtNV7qQyP64/KA+10IcUllxuW/wmm64QDtkkP3P7HRBJqT8QcdRQi8QTtB4=@lists.denx.de
X-Gm-Message-State: AOJu0YzAFN74nda8zlrZiLkwqIJ7IOo6OSFUAH8Khhhkioaoo3xd1ixJ
 0S3KsjTFlDCTGXA6rKu23f8vg85xpJJw00kpCxiRLsnRbgoOQQ+foX5dH+zYRw7mY78=
X-Gm-Gg: ASbGncsB4BcU65QPU/G2yt55eiyv/3f70KvZAOGt9FUxaMHFaRnNokZ/xj7x/EFdZoN
 1x4c6fe9mTMjpFqy/DK4s6xk6i65G6YBuD3gUBDbTuP+hON8JgOfOxgh77SwPFEKql2q/1AFKHc
 zmQMAz+grdZ8FTRE85F2ycS3+17+sRdHnGfuOgMKEUkjWbdG3kmm7FpJAcy0hYtINcdotsHTNxi
 nc9TSLBSt4I1nVFrZfevJBRGCNEMqiypeO6dEa7EHf0LcbgqQfUr56vYVug9k/9TguDHkDBgeC7
 giHZ2CEWE8sh2VFt/+eUmmdbczNTVcj3482ozRhTbo4sxlePgFc+Xb7tAgELIXfSkRH1wQoxS2c
 nZBMn5EtyoMterH18xpPoYfcDzEv7GpqZIaZboKTny6v+GDhSx2USYXxhNRbb4N6iRs56xidoW8
 h1ng==
X-Google-Smtp-Source: AGHT+IHsvxVSNxMPgymnOlzT8chSYIfeROTvhAej3uACAPaZttXMHVndmfu1M/Ax5gFfjYfo8IKJVw==
X-Received: by 2002:a05:6000:1886:b0:3b8:ff3a:86c2 with SMTP id
 ffacd0b85a97d-3b911007b55mr2081660f8f.37.1754990268674; 
 Tue, 12 Aug 2025 02:17:48 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:97a2:1bc7:9f2e:6519?
 ([2a0a:ef40:f9e:3c01:97a2:1bc7:9f2e:6519])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b90a64318fsm8432035f8f.21.2025.08.12.02.17.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 02:17:48 -0700 (PDT)
Message-ID: <2d6457b8-c637-4531-8f56-e2aea320a319@linaro.org>
Date: Tue, 12 Aug 2025 10:17:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Seeking advice on API return type inconsistency
To: Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
References: <f5c94319-8ef8-459d-88b2-836702779cfb@linaro.org>
 <e10a39e4-9606-4ae4-86dd-11de4b39b5ed@cherry.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <e10a39e4-9606-4ae4-86dd-11de4b39b5ed@cherry.de>
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

On 11/08/2025 17:36, Quentin Schulz wrote:
> Hi Andrew,
> 
> On 8/11/25 5:24 PM, Andrew Goodbody wrote:
>> Hi,
>>
>> I was wondering what people's thoughts were on API return types. In 
>> particular there is this and other examples in include/clk-uclass.h
>>
>> /**
>>   * get_rate() - Get current clock rate.
>>   * @clk:    The clock to query.
>>   *
>>   * This returns the current rate of a clock. If the clock is 
>> disabled, it
>>   * returns the rate at which the clock would run if it was enabled. The
>>   * following pseudo-code should hold::
>>   *
>>   *   disable(clk)
>>   *   rate = get_rate(clk)
>>   *   enable(clk)
>>   *   assert(get_rate(clk) == rate)
>>   *
>>   * Return:
>>   * * The rate of @clk
>>   * * -%ENOSYS if this function is not implemented for @clk
>>   * * -%ENOENT if @clk->id is invalid. Prefer using an assert instead, 
>> and doing
>>   *   this check in request().
>>   * * Another negative error value (such as %EIO or %ECOMM) if the 
>> rate could
>>   *   not be determined due to a bus error.
>>   */
>> ulong get_rate(struct clk *clk);
>>
>>
>> get_rate is declared as returning a ulong but the description says 
>> that it can return negative errors. A simple test of the return value 
>> for being less than 0 will always fail so errors can go undetected. 
>> Casting to a signed type seems less than ideal.
>>
>> What is the best way to deal with this? Cast to a signed or update the 
>> API to be signed or...?
>>
> 
> Note that clk_get_rate() in the kernel has the same function signature 
> so I would refrain from changing the type otherwise we'll have some 
> "funny" bugs to handle considering it isn't that uncommon to import 
> drivers almost as-is from the Linux kernel.

Ah yes. The difference being that the kernel does not seem to attempt to 
push an error code through this API, you get a rate or you get 0.

> You have get_rate, clk_get_rate and clk_ops.get_rate that should I 
> believe share the same signature?
> 
> This for sure isn't helping you but I also couldn't come up with 
> something the 5min I thought about it :/

Thanks for looking anyway.

Andrew

> Cheers,
> Quentin

