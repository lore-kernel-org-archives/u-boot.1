Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC5ECD4F3D
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 15:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43A68846F2;
	Wed, 20 May 2026 17:08:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hsPGxsC5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4198846F2; Wed, 20 May 2026 17:08:05 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E004846B0
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 17:08:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-448528f4e69so3464843f8f.3
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 08:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779289682; x=1779894482; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0vy9+UFOZv8ksmjkmpMrBTofq+qCNt9Fm75diIPTzlA=;
 b=hsPGxsC51hXWLWF/ePr2JYrRQoJAJHUqEiDmJai74Zc/YYThgWBRo8qEGZnxuNAP47
 9ChZGwNv9Sza1tNGdBZcl1KnpT+a0VVwJ8wrN0iItiK3bxV6az/GCHiJ8+T2/RjUfHy7
 4fjoIeCRGZxROkhjp4G2yCzLC2TgafRYhxRcK5RNylMncXRtrM4UYi00qv7Db7hR8seK
 eBs9Euwg9ciRTOmoC+RXcPwmkImTl1Dug7a7MZwyeq7qwM4j1ZxWmnMpekthKrZqydCa
 9BclGF5dOY45dmFnknZG5UOMuz0WfTdKmmVXyuGO60DRDVJV9EB24esTRnclGFQSUo3+
 6rFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779289682; x=1779894482;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0vy9+UFOZv8ksmjkmpMrBTofq+qCNt9Fm75diIPTzlA=;
 b=X2T6rQ5RNP6ENR4RRgQa2aO+UnXHLknZvkVOsLx5dEFzQXGw6DUSeGL5LsDvApIKgx
 wsdR7cQaWz57XG8eaO9vGJ4nq4sDpvcBtqyzb0HhJ+S1jId1nmU42NhGzixLjSyFNYwk
 zT7tJQNRm8X8PlACM8b4wT+YLQeUckOjPP8yI2kr/zfyTJijump8Ifo886t8MImiJNtS
 gw9PR8uRhiuft5Gvy92zxxYMCm0YiEkMrhgsuEE6hOTA1zxFIXvJt3YhY6bwkc8SVpr9
 BQipyeYAz8Sizo4MdH1EMiVWLGnsrW+FUVkaAJWMJIzw5wL0BXs0ro/xNJrvbgPwHm/u
 hFCQ==
X-Gm-Message-State: AOJu0Yysohjp3o/Suh7kUopMGFLVbXABHKuletcO2+nLsrz/53M/G0F1
 MCjGehWcmOGQec8B34NjUSKthsP58d6NUvO/LDQVhUpMkv7YiqtyYlBNPq1gY4n4FeA=
X-Gm-Gg: Acq92OF3FEQ26QEEoTG2vcjtYcPMa96KrRuKg4xTrGSPUKn6Uou9rcItihzirCXM/eJ
 Gy+jlYVNEIorj1qVADy3rsRbrGnefPA2w4x+4dXjpbDZBNsKgtoyw0KwXi1Nsgo2X99mw4LmoVB
 IgkoiG2kiG2lY2HVaTjIbuhqhU1QRIHmhCCZ+Dikvs04Lko8hFtiFNTfLzJJ7hhdaV4OuKbOG2k
 cGlKQMe6YybrV40aqmzliWAL8/NMXSDDZJUQ3R9b88gDs7qMnS9oOU+xh5RMI+x8MIpS3vQeBFR
 yZ4rM5eQwTeOAX5amc6pTlNUU1kfdLvv7W4nUghPeQJsF0pAI/q7rmv2xW7htaBfPtMpAgDoKGm
 +bzMU8NCOo2SLSe3wJy4F/Mzd9vRmrZI3px2B7ufkAzHSyhOBlRTKwFEAuK0CkOIduuhVm0qB3z
 8Bey8z8ultbaKE0s5AIe/WkNwAS3esWrzZQEu9Jrug5AlTra+tl6jAEJw2lqw/hVl1Cg==
X-Received: by 2002:a05:6000:2401:b0:43d:7275:c1eb with SMTP id
 ffacd0b85a97d-45e5c5dadeamr39892798f8f.39.1779289681701; 
 Wed, 20 May 2026 08:08:01 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3acf7sm55426859f8f.12.2026.05.20.08.08.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 08:08:01 -0700 (PDT)
Message-ID: <e13fe55d-1f43-4c07-a92a-045b0db9cf38@linaro.org>
Date: Wed, 20 May 2026 17:08:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board/qualcomm: use bootflow for default boot
Content-Language: en-US
To: "Ricardo de Araujo (Salveti)" <ricardo.salveti@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, sumit.garg@kernel.org
References: <20260514205759.3553253-1-ricardo.salveti@oss.qualcomm.com>
 <ae4eec1e-1c5b-42d3-a26f-3911b1a2839d@linaro.org>
 <CAA_5yov+8_G2FUQ-QrKBtykt_vwZPdU-KGEzzmguYBJsUveqeQ@mail.gmail.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <CAA_5yov+8_G2FUQ-QrKBtykt_vwZPdU-KGEzzmguYBJsUveqeQ@mail.gmail.com>
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



On 18/05/2026 21:15, Ricardo de Araujo (Salveti) wrote:
> On Mon, May 18, 2026 at 4:59 AM Casey Connolly
> <casey.connolly@linaro.org> wrote:
>>
>> Hi Ricardo,
>>
>> On 14/05/2026 22:57, Ricardo Salveti wrote:
>>> The Qualcomm default environment currently boots only with
>>> 'bootefi bootmgr'. This bypasses the standard boot flow used to
>>> discover extlinux and script boot entries, which are commonly used
>>> for FIT-based Linux boots.
>>
>> We intentionally don't support these alternative boot methods upstream
>> as they aren't standardised or supported by typical distros. There are
>> also plenty of inconsistencies in Linux userspace depending on if SMBIOS
>> (DMI data) is provide or not as well as EFI runtime services.
>>
>> Could you explain a bit more why you want to support extlinux and custom
>> scripts?
> 
> My main use case is for the target to automatically find and load fit
> images by default (based on the config used), which is a quite common
> use case for embedded distributions and products (see that it is also
> enabled by default on several other platforms in u-boot).

That's understandable, and yeah I'm aware that embedded distros have and
continue to use this approach. I'm kinda wary of (and should have
disabled) bootflow, the code for it is a challenge to understand and it
has caused me headaches in the past. But aside from that, the default
environments we ship upstream are the ones that are actively maintained
and used, for qcom that's EFI.

I'd love it if we /did/ actually directly have users of upstream U-Boot,
but as it stands today anyone shipping it will be making some
customisations to it.

In any case, the other reason I'm wary to use any other boot methods by
default is because as I mentioned we don't support them upstream, and I
don't want to have to care if a change breaks FIT booting (for example).

> 
> As u-boot provides support for bootflow, supporting several mechanisms
> which are probed at runtime (including EFI boot), I believe it is a
> better default as it supports a wider range of use cases.

In general supporting more usecases is better, but when it's something
like how to boot the OS I do think it's much better to push folks
towards standardising and EFI is that standard.

Just because products and embedded distros today use other boot methods
doesn't necessarily mean it's a good thing and to me at least it's clear
that we should just switch to EFI...

There's no reason not to adopt something like UKI, or even to write an
EFI app that implements FIT booting.... But yeah, it's easy enough to
carry a patch or point to a custom .env file if need-be.

Sorry I'm not more helpful here.

> 
> Thanks,
> 
> Ricardo

-- 
// Casey (she/her)

