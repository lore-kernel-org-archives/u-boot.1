Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87974E77199
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 15:03:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFA8D8036B;
	Wed,  8 Jan 2025 16:03:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K5hntRpH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97B0A803DC; Wed,  8 Jan 2025 16:03:54 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 794348001F
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 16:03:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aaf3c3c104fso724584666b.1
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 07:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736348632; x=1736953432; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gb/SbbjkP/9CfgPhrvKfgxLhQaIkSYXQtlcCcgQhkS0=;
 b=K5hntRpHpItWpy3HiEQijBvWIkEgsrCbqqKPjS6iviOW+M1vzO8h8mT9CCjBGns1ss
 F7W2LJlOxFY2NoVMxRadnghvudMMhcLx/4JXpqm4s+UxnVxiVzr/FnNI3uqDhI5ejbsk
 c1nPZlfVgXxEhoY+O5LlvvN4tXWXjcA4d0ThzgS7OmiZWH3yNgIyV8He7hcLY7P4gZ4d
 iaGpLYjRl10I/5FbY5+3tgOYplp5eYGzjkI2/QxNHJToTVHP3PiYy6ziZtJZeRTE4xw2
 YsKeyIE3xGLTGZ1zVBl6K62/a1B5/I0L4/XdvobiqzlqrCrBvUio4MMlnNdWB4TpOohU
 MiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736348632; x=1736953432;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gb/SbbjkP/9CfgPhrvKfgxLhQaIkSYXQtlcCcgQhkS0=;
 b=rOsB4QLiSmqlSBBWms4InRc6KJelAWJSJj1UmzBXF9nwqy3tbxM77lgiYb1Mjkz9sp
 7+Z+KH7qkOfI/uDrJ9kdNMkAKgZD2azfbJcb1Dd7XtHqfvpY77ZaST7WGbaiIt3+EC6e
 FK02Ih1NkHr87kXCAsti/+SYDcIfCOKc1CvXTusPxBaVk6V+b5bnHXMgYPuoxHlZk25i
 EIW0i9Nuk1tVFdDBI/s0o9Sh0OiS9bTNMYIpIBKyR/FpobivkPb8h6A4HQi62UBY192d
 pG48mCWKAolv7krFChE68hs3DxP8VoH38rFE2JOl5zcvP8XKDMAcMpz1Ozx88tXlyg8Z
 6x/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtFGKH/Z8SFVbFlnEe7ZuzTI8GEIeOgidqW43N4JlHY9AX5P9BX6N68Pa2xM7TkcOxpEAJYnA=@lists.denx.de
X-Gm-Message-State: AOJu0YyTg/8zTQP4SUE/okUB70iIzns2QxjcqZ6GgXt694cZrq2HES9e
 GXLOQYVOyCbPHFK5Q/7UuOzpZkwMyYQvECHYv0/oFvR6tv0t6qGZmQT/8bUQZLs=
X-Gm-Gg: ASbGncvMdcaK7HLy+gf/dGG3kN8w0lo0N3fIpIxGNGvHUGiR7mfB5I8PtrAZUkYdx0Z
 NgO+U01iu3sWTmilsD+fha9NTRNsWLEedqQ+eesCVLf9Evdvt89fN1Z38GjACNko2w9/Qn1nugt
 +Qz+REHk+U7xU8R8wuYm5cvRpEpbKnJ0yBY8gOBicxsx4Q7NUQvMqHgyZoQKCSRPMW1Vuu4p7dS
 0R2pyxTliTWk2rkAhzuBU2Ycd7nvym7c7fS8CN7W8cKukxgM5QgNOBV6WOFWEem6VPsVeaWtaKr
 fkp5TajCiqt+KVHurVZPmirB409DRhaTzG6OJhQ=
X-Google-Smtp-Source: AGHT+IExHkXM1+XA7nYZeSmTOBat2uOhb87GCY9hrJXI7l35ySbj6akJGj7duPXjdUWQWa8iavIAgA==
X-Received: by 2002:a17:907:6d20:b0:aa6:800a:1291 with SMTP id
 a640c23a62f3a-ab2ab167fb7mr236078666b.7.1736348631514; 
 Wed, 08 Jan 2025 07:03:51 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e8954bfsm2532289466b.60.2025.01.08.07.03.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 07:03:50 -0800 (PST)
Message-ID: <1c39aea0-a4ef-4465-bf09-fb58ec7a2050@linaro.org>
Date: Wed, 8 Jan 2025 16:03:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] mach-snapdragon: fetch serial# from SMEM
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Mario Six <mario.six@gdsys.cc>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
 <20241124-b4-modernise-smem-v1-14-b7852c11b67c@linaro.org>
 <CAFLszThinPHnJ5BRDMGFMuOyYBmvP93+fBzBzbEPuX2vEoJG3w@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszThinPHnJ5BRDMGFMuOyYBmvP93+fBzBzbEPuX2vEoJG3w@mail.gmail.com>
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



On 07/01/2025 16:32, Simon Glass wrote:
> Hi Caleb,
> 
> On Sun, 24 Nov 2024 at 12:18, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> If available, otherwise fall back to cmdline.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>  arch/arm/mach-snapdragon/board.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Thoughts below
> 
>> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
>> index 269d39e4f6e1..dbac8aa2709a 100644
>> --- a/arch/arm/mach-snapdragon/board.c
>> +++ b/arch/arm/mach-snapdragon/board.c
>> @@ -30,8 +30,9 @@
>>  #include <malloc.h>
>>  #include <fdt_support.h>
>>  #include <usb.h>
>>  #include <sort.h>
>> +#include <soc/qcom/smem.h>
>>  #include <time.h>
>>
>>  #include "qcom-priv.h"
>>
>> @@ -198,11 +199,16 @@ static const char *get_cmdline(void)
>>  }
>>
>>  void qcom_set_serialno(void)
>>  {
>> -       const char *cmdline = get_cmdline();
>> +       const char *cmdline;
>>         char serial[32];
>>
>> +       if (!qcom_socinfo_init())
> 
> Hmmm that function should return an error code, i.e. 0 on success.
> Does Linux use a boot interface here?

the name of this function isn't great, what it actually does it retrieve
the serial number from smem and set serial#, returning 0 on success
(meaning the serial number is set, so we have nothing else to do).
> 
>> +               return;
> 
> Shouldn't this return an error?
> 
>> +
>> +       cmdline = get_cmdline();
>> +
> 
> drop blank line
> 
>>         if (!cmdline) {
>>                 log_debug("Failed to get bootargs\n");
> 
> Shouldn't this be an error? If not, please add a comment.

bootargs are only available when we're chainloading from ABL (something
we can't easily detect at runtime). I would eventually like to drop this
and rely on smem only ideally. But that's quite unrelated to this series.
> 
>>                 return;
>>         }
>> @@ -353,8 +359,11 @@ int board_late_init(void)
>>
>>         /* By default copy U-Boots FDT, it will be used as a fallback */
>>         memcpy((void *)addr, (void *)gd->fdt_blob, fdt32_to_cpu(fdt_blob->totalsize));
>>
>> +       /* Initialise SMEM if it wasn't done already */
>> +       qcom_smem_init();
>> +
>>         configure_env();
>>         qcom_late_init();
>>
>>         /* Configure the dfu_string for capsule updates */
>>
>> --
>> 2.47.0
>>
> 
> Regards,
> Simon

-- 
// Caleb (they/them)

