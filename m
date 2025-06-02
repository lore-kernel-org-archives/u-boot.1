Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F497C5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 15:01:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A14A80F9C;
	Mon,  2 Jun 2025 17:01:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LLq+qQBw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99A92811AC; Mon,  2 Jun 2025 17:01:39 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42F34800D7
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 17:01:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a50956e5d3so1060479f8f.1
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 08:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748876496; x=1749481296; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8aJGjCv2Pof7v5Hmuah+Ie95i1o6wmVQlWQFlSL9JfY=;
 b=LLq+qQBwnbuyMZwUwx0d1qGiMR3Frs1boiSDNeKuaiDVAYNTJmh86bnNQKWGSG2EBm
 Uvexu6MaDmmDEig5lxgAvLAOQeF+oNIDe3M3QoJSxcjiBtb15sk7BWO2cST1e0Qt029B
 MlojnAxZ3Dcplc6R2caluwMSPPbRTCKeqenaZtxBF1mr3Ylqv3xQ0TdKPDuAhR+xXQgq
 0f171rVAjtfZtDpMwYE+qEaU/7rQCM0j/L6A3SWTLvyAq1ad63MZcS5wvlCdOdNfyVYI
 zaiZHYxgeou0o+UGX7enSqYRdOWcKWrvv+UI6l2uKPUSYdlh7vFlax8MVpc6sCM+LQ3t
 BNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748876496; x=1749481296;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8aJGjCv2Pof7v5Hmuah+Ie95i1o6wmVQlWQFlSL9JfY=;
 b=h+KhXxmbH2OA+Jw6QOcmbDYTM2HiLiGBUSbhkXyk5lWsyhv5DC7MHXMkLEvy3kxjmG
 bWzha03YEqaQrNVhkYKb74ODKIWZGypPtILlrceRM+jP1wWEd5FE8AjRW5SwCuwWnsoJ
 kf8TXWloEQJ3A+dYWGzQuepJx+TGyI70i8WEwfM6TG1I7or6AuVEEBBFYKKnsU9Cz8jR
 RkibZleiyHRDlyoP/pca8Ebfz6dlMaLw0/MlTJydfGYGasyKvgScUWQMU2bJ534jaOXS
 shi3w2ZYQ1KmtOqmWXX4pjI7M88qv3j+HUtw7ttrdAeTUZrgB2RKzmOweyiHhL7LY0uP
 8yPA==
X-Gm-Message-State: AOJu0YxHOqlOuxVINKkmIOcBqxfAPvZbTlZNMnCs3ggCBhu8EMbDhalI
 Iz44LEiqIkkPXaaTZ7qOHIJNKg4JPm0CdDU6SVCq/qCARhIdf/rmZxGzzKkA5ouZ9ss=
X-Gm-Gg: ASbGncvunGGA4jLB9fqyfPojhHObl49Ps3g9MpqbbBAPbll3trjBUPuxB5zZpPQPNWe
 IYgggmkoyXZMZCbVWo4FH+Vx2aOtgCUbHXqx508jyS0LvoPrbdtaDTXHElALjXIWDnw3c+A+ZJs
 3cZHdzVVeFPcrVdSBJJT66XvSidkOrYg7UZn+yOGQJJ1bDFPPPGj7gdPiG41JRlE4Afnh8EVwlv
 4jpjD0K9+lQG/M5wAXS8RihbL0gU+OkvgCExViF3K0eEWQh/CCSF45tOvwwWtVEvz1bDBRGaOBI
 nBjq27XwGSv+j+0TGBgaSVSEAko2VdiUMHWWXDU4A215NpuRXWEmm0sErJiEEbGFS4ATNugBz2E
 8o2llO79idCVTBsREEZoJ
X-Google-Smtp-Source: AGHT+IFpEWgU8hhC7BYy2NlB1WKrkokE9JI+T48kk/n0wp/wZTS7vNTbqE8ABEQyyi7kGRXUJtg8WA==
X-Received: by 2002:a05:6000:1a8b:b0:3a4:e4ee:4c7b with SMTP id
 ffacd0b85a97d-3a4f7a4d5acmr9875406f8f.15.1748876495880; 
 Mon, 02 Jun 2025 08:01:35 -0700 (PDT)
Received: from [192.168.1.65] (bba-217-165-38-73.alshamil.net.ae.
 [217.165.38.73]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73fbcsm15096111f8f.48.2025.06.02.08.01.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 08:01:35 -0700 (PDT)
Message-ID: <3ccfcf04-f6e7-4510-ba18-637275384cb7@linaro.org>
Date: Mon, 2 Jun 2025 18:01:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] atmel: Remove local <dt-bindings/pinctrl/at91.h>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Mihai Sain <mihai.sain@microchip.com>
References: <20250528000118.3002916-1-trini@konsulko.com>
 <72a265ca-d5e7-40ca-b05f-5a3cf8f0f0c8@linaro.org>
 <20250602145716.GX100073@bill-the-cat>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250602145716.GX100073@bill-the-cat>
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



On 6/2/25 17:57, Tom Rini wrote:
> On Mon, Jun 02, 2025 at 03:04:54PM +0300, Eugen Hristev wrote:
>>
>>
>> On 5/28/25 03:01, Tom Rini wrote:
>>> We have this binding file in both include/dt-bindings/ and
>>> dts/upstream/include/dt-bindings. These files are identical save for the
>>> fact that we do not have commit adb2424d0d05 ("dt-bindings: clock: add
>>> clock definitions for Ralink SoCs") from the kernel applied. However,
>>> this change is rather important and should not have been omitted here
>>> most likely. Remove our local copy to get in sync with upstream now.
>>>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>> Cc: Eugen Hristev <eugen.hristev@linaro.org>
>>> Cc: Mihai Sain <mihai.sain@microchip.com>
>>>
>>> The full kernel commit log is at
>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0b3292852863215825f88905b9dbafc3101e1d7e
>>> and so this sounds very important. Please let me know if this should go
>>> in master for v2025.07 (or Eugen, please pick it and send a PR). Thanks!
>>
>> Hi Tom,
>>
>> I do not see the connection with the Ralink SoCs. Maybe wrong commit
>> referenced ?
> 
> Erm, the kernel link for me is "pinctrl: at91: Enable slewrate by
> default on SAM9X60".

The link is good, I ment the commit message above.
> 
>> Anyway, on the slewrate bits, as of today we have DIS==0 and ENA==1 and
>> the driver treats them the same way. Hence DTs with DIS flag will have
>> the bit erased in the register
>>
>> With the kernel bindings file, DIS==1 and ENA==0, but the driver still
>> considers DIS==0 and ENA==1 , so the DTs that have DIS as flags will get
>> the bit written in the register.
>>
>> If we also port the driver patch then the driver will also consider
>> DIS==1 and ENA==0 , so the DTs with DIS flag will get the bit written in
>> the register.
>>
>> So there is an important change by changing the bits values, as the
>> register eventually ends up with a different value.
>> The driver patch apparently just interprets the DIS/ENA bits
>> differently, but the end result is the same
>>
>> Please correct me if my logic is wrong.
>>
>> I would also believe testing on the sam9x60 would be required for the
>> slew rate change. From what I remember back then, slew rate change was
>> not needed in Uboot, but I might be wrong.
> 
> So, there's I guess two parts to all of this. First, yes it would be
> good to test this change on real hardware and make sure things work as
> expected. Second, yes, it looks like we need to make the parallel change
> in drivers/pinctrl/pinctrl-at91.c (to match what the kernel did at the
> time too) and we can't just remove the old binding file we need to
> update them at the same time (since long term we need to remove all of
> the old kernel dts stuff).  The final thing is that it really is
> important to get them in sync as it's valid to pass our device tree to
> the kernel to use. Can you take care of the changes here?  I don't have
> hardware to test on, thanks.

I do not have any sam9x60 based board . This would have to be tested by
Mihai or someone from Microchip team.

So your patch would be good, then another patch for the pinctrl driver
to port the changes from Linux . This can be done by Mihai or the team,
if they want, otherwise I will do it, but it has to be tested anyway by
someone . Especially the hardware with slew rates, like the SD card.

Eugen

> 

