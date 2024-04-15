Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F85C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 07:35:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9169C88155;
	Mon, 15 Apr 2024 09:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="amuUKYFm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 825D688157; Mon, 15 Apr 2024 09:35:06 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47C498813C
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 09:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6eb7b6f92d4so557924a34.0
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 00:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713166498; x=1713771298; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=48i//kDbHCOowsPNhSZXl5Dn4U8GaQP6nb6xfKgjNBg=;
 b=amuUKYFmPagdEHHHGo2uX86gHS72tSwykv6YctbDTu1uWih0ebc/p3tfmVA21DM2aU
 uz18SLebV/2BoDY4oXellcgCx3Me4ySjajc8Jp69UEkDfYaWzKiZaz2XxvoI0UUzvyCb
 Y2Uht4IeJQWQI7hrFFKEUQ90D37rR4zg+SEZr5H1+kh9/E4HGg1rm0UARvbTWnGtiADE
 e614Xc5xTdutiUAjCxjxZazUF/ZUS9cxe2OEz+d4IZciW7PHzHTTRvweqqJZZpEYo1KD
 cKyjS0LKOqwQZAgqSVD5UN5b/ORmygNWN5T2j8Kkb3T2sPipcwsyreKXjf+IFccOMpCA
 h3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713166498; x=1713771298;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=48i//kDbHCOowsPNhSZXl5Dn4U8GaQP6nb6xfKgjNBg=;
 b=M6ZTMLnLrTdJA2G+s0VT8MI278b+Qq8M5W6C2TK9XP/29bC7qrk2IYzp9nKGAf8D7N
 nBAwXITXcL9AlU3NADefDji7IfqPkZwqIvmwlJdpH8I/EIa8er6ZxIzfi03VtQe4LK63
 H5aTwUxsbtJXaBXeAaBf9HVxTNQvZ5iFpNKU11KvrHYJpMy+ORrE/tbfZrn3G3yrLoX9
 Xh/nucQnA1FGP0g2XPEnGcCybWIYbe4ydoRiLROLkeyPJD5oLjyHO+jZhMWspXl/Di/y
 GmTqkiW1ZNTd6fYZ7cDWud+o7MNyzqGAWoeujO6/2rMdEbaABWl94nKNbb7bC18dDzXS
 WNPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm+xTq9fVIwM/D1LgsUASUrIrR9nCgq4En2TIAfAsH9ia1yfPydO7dZ6wsEVGMa9rJSs7gFAC0fz0/loF7Bx++EXqJnw==
X-Gm-Message-State: AOJu0YyUIXpqHPccCdKmvj0G7/SSOpBbzqi/5VGwjDWduxLnVIsztdMZ
 CJarkG3HMbdIwA071qajpw4hrj11LtE8RKsn0HvujSI0IQbRhGYm
X-Google-Smtp-Source: AGHT+IEmab5bwsyd329CX9Tx3muGqGUFe2idQLscTSuwPy+ikravdkITu3pHoexpZEyZlRaEKr3DAQ==
X-Received: by 2002:a05:6870:b48a:b0:22a:9f1c:a1e9 with SMTP id
 y10-20020a056870b48a00b0022a9f1ca1e9mr10384296oap.35.1713166497907; 
 Mon, 15 Apr 2024 00:34:57 -0700 (PDT)
Received: from [192.168.0.8] (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 b22-20020a056a000cd600b006ead792b6f2sm6655774pfv.1.2024.04.15.00.34.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 00:34:57 -0700 (PDT)
Message-ID: <69687d59-bcb9-45e4-b0d3-b69c49282b47@gmail.com>
Date: Mon, 15 Apr 2024 16:34:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mtd: spi-nor-core: Rework default_init() to take
 flash_parameter
To: Tudor Ambarus <tudor.ambarus@linaro.org>, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, pratyush@kernel.org,
 d-gole@ti.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <cover.1713154967.git.Takahiro.Kuwano@infineon.com>
 <9db9fb39e655b514c21952e0a5005572510ad3ec.1713154967.git.Takahiro.Kuwano@infineon.com>
 <377037b3-1bf2-492b-bb88-de233d8b373c@linaro.org>
 <7149031f-b359-4218-9a52-e4ab0ea16c4c@gmail.com>
 <86a321ed-2ee9-44f8-abbd-7f147420212e@linaro.org>
Content-Language: en-US
From: Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <86a321ed-2ee9-44f8-abbd-7f147420212e@linaro.org>
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

On 4/15/2024 4:27 PM, Tudor Ambarus wrote:
> 
> 
> On 4/15/24 08:09, Takahiro Kuwano wrote:
>> Hi Tudor,
> 
> Hi!
> 
>>
>> On 4/15/2024 3:47 PM, Tudor Ambarus wrote:
>>>
>>>
>>> On 4/15/24 05:33, tkuw584924@gmail.com wrote:
>>>> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>>>>
>>>> default_init() fixup hook should be used to initialize flash parameters
>>>> when its information is not provided in SFDP. To support that case, it
>>>> needs to take flash_parameter structure like as other hooks.
>>>>
>>>> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>>>> ---
>>>
>>> I'd like to get rid of the default_init hook, let's not extend it if
>>> possible. Can you use the late_init hook instead?
>>>
>> It looks easy to migrate from default_init to late_init so I will do it.
>> Could you provide the links to related discussion in Linux MTD side so that
>> I can summarize it in commit message?
>>
> 
> I can't, I don't remember if I brought this up or when, but I can
> explain why.
> 
> default_init() is wrong, it contributes to the maze of initializing
> flash parameters. We'd like to get rid of it because the flash
> parameters that it initializes are not really used at SFDP parsing time,
> thus they can be initialized later.
> 
> Ideally we want SFDP to initialize all the flash parameters. If (when)
> SFDP tables are wrong, we fix them with the post_sfdp/bfpt hooks, to
> emphasize that SFDP is indeed wrong. When there are parameters that are
> not covered by SFDP, we initialize them in late_init() - these
> parameters have nothing to do with SFDP and they are not needed earlier.
> With this we'll have a clearer view of who initializes what.
> 
> Feel free to use this in the commit message if you think it helps.
> Cheers,
> ta

Of course it helps!

