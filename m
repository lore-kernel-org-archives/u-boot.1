Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C263C7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 14:26:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3ED082E05;
	Mon, 23 Jun 2025 16:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ncxhrVZ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EF3582E25; Mon, 23 Jun 2025 16:26:42 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CF5A82DA1
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 16:26:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a4ef2c2ef3so3319499f8f.2
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 07:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750688799; x=1751293599; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=45I5iEf1I7u/nojMMvUJJw3vtf8w5u0L14yHOLesybo=;
 b=ncxhrVZ+LqCgo006dy5+YwgEe8p3Yo+j1YHAuIbAPJP5wEFWP/uaBlzL/o8Gab5OWR
 Bji7U3dlXsNd6PBIMQkP+lcdEMRCdY+5uqQqZGL5tTgrUpkGMRL5f1B1UPeZzitV7c6f
 vS+H1ibOsVS+mP/EkOKvPPCsOEpM/PTeL3MViByyir9qdnRexFigCHnhwHNTicXYOuju
 5uwScscjV7iXcR3ViJVSscGVdfDe+F1K0WcVO4UpT0+hZ8+PBqn7QnqTk9J26v29pLyc
 W3N+9tjamnVe88juKUSDqKb0gUDH23vuPsafzXnLu3OYagd+7a5rToozpsCFQFXIVdx9
 ILOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750688799; x=1751293599;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=45I5iEf1I7u/nojMMvUJJw3vtf8w5u0L14yHOLesybo=;
 b=cv/jf0iEwaG/JKPGxu+oC0CaTJW1XqTTVXoQYuwe1ILcDi8F0WJogSnxF+FN7H100P
 +q7p08CqVABXEHJXYN5otKVEJebtfwuFpU30I3mjUGNvn0Wm3y/NZ3Fx3zCuqrazdJ5H
 cHcb3aDvpK1nbAqRm72UsyfXwFIxnX2zaRP/xiJUVtlE90obYEFyCmWH/6+qf7O89+O0
 lRoC5sAylZS7apsO9Z/VBeumbkVHIgUDAcz8rdYjOqVpxmFSVOuNlsiRgw17hdAtltco
 rNrgNkxPlkGLmGoyZRkq8hvxK8LYkVaRarlNdL6alfMHmk1GRLgh7IFDf1ied2OhjZho
 fkAg==
X-Gm-Message-State: AOJu0Yx81p3tbgx9uuyv5C4caKbmvBdig3sfqHhn6T46oPH+F8IPXP01
 iruLQdhmWDdeGJF04rQ20eAVbG00y3fRPFi3NYkSLsCUJ0yHXZP9bC29Pjy5BHeup5I=
X-Gm-Gg: ASbGncvQKKoMcYOqge078KUDgwvuRByGA/QleqFp0uO03O+yDqNprnb+LB8c9BEw/Fa
 DU+roilVxWnJxSCRhpRBtY5/QnN0/IoeTW3GOmoOEcOefcilWhT1rxhpiTznLuENFd2Oaoitxwq
 Y1DHhJUxY+jakmsWnmtL56uzkp+7sxXXtKqdYcrfSq2A7B9U5Y9t1Yh83s2SIGP+Mf3kZ/PaQ41
 hOrTvdyHRyUuAqELWfLE7+4ik+ZI2/T0vZ0PlM3EB0UT6D07NXmjCdJR5YVcLfLNqgcLs9DFIsl
 vv6O8siLHNhN1+0131+aX3ZteEXmW2jNQ6bhls03hoAnEFjyOV0oFCXIGVeMTqgCSQzn5h7h1oe
 TJ+4niK8Qx63oivZTUPwe3JBUDke3nNR2qowxG6JGmw==
X-Google-Smtp-Source: AGHT+IHx74hvTiaghumN4OCW20yuVkVWgBzDMDeVUNWarqtqgjjDoisMTOo22ExvdN/VcxfNWmRpQA==
X-Received: by 2002:a05:6000:2c13:b0:3a4:f744:e01b with SMTP id
 ffacd0b85a97d-3a6d12e5c98mr10385051f8f.39.1750688798824; 
 Mon, 23 Jun 2025 07:26:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:f95b:5bbb:67a7:dbd5?
 ([2a01:e0a:3cb:7bb0:f95b:5bbb:67a7:dbd5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f1d868sm9559095f8f.44.2025.06.23.07.26.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 07:26:38 -0700 (PDT)
Message-ID: <547a6154-4a73-43b6-9e4d-a0a391cada90@linaro.org>
Date: Mon, 23 Jun 2025 16:26:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mbedtls: Introduce subset of compiler-rt from LLVM
To: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sumit Garg <sumit.garg@kernel.org>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>, Peter Robinson <pbrobinson@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>
References: <20250620151021.2711542-1-raymond.mao@linaro.org>
 <20250620171957.GL216500@bill-the-cat>
 <CAEfUkU+BaZxHSk9DUhF0D-1fmZYXBkiY8Bb6YEOzU0s+SMi4zA@mail.gmail.com>
 <20250620190013.GN216500@bill-the-cat>
 <CAEfUkUJ+oXKdi6pWmNHpU_E7g-Vi37Q-x=W9ZY-UN486k2uizw@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAEfUkUJ+oXKdi6pWmNHpU_E7g-Vi37Q-x=W9ZY-UN486k2uizw@mail.gmail.com>
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

Hi Raymond,

On 6/20/25 21:08, Raymond Mao wrote:
> Hi Tom,
> 
> On Fri, 20 Jun 2025 at 15:00, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Fri, Jun 20, 2025 at 02:00:09PM -0400, Raymond Mao wrote:
>>> Hi Tom,
>>>
>>> On Fri, 20 Jun 2025 at 13:20, Tom Rini <trini@konsulko.com> wrote:
>>>>
>>>> On Fri, Jun 20, 2025 at 08:10:08AM -0700, Raymond Mao wrote:
>>>>> Introduce the implementation of udivti3 and udivmodti4 from LLVM
>>>>> compiler-rt builtins for building MbedTLS bignum module via Clang.
>>>>>
>>>>> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>>>>> ---
>>>>>  lib/mbedtls/port/compiler-rt/LICENSE.TXT      | 311 ++++++++++++++++++
>>>>>  lib/mbedtls/port/compiler-rt/README.txt       |  11 +
>>>>>  .../compiler-rt/lib/builtins/int_endianness.h | 114 +++++++
>>>>>  .../port/compiler-rt/lib/builtins/int_lib.h   | 171 ++++++++++
>>>>>  .../port/compiler-rt/lib/builtins/int_types.h | 276 ++++++++++++++++
>>>>>  .../port/compiler-rt/lib/builtins/int_util.h  |  47 +++
>>>>>  .../compiler-rt/lib/builtins/udivmodti4.c     | 158 +++++++++
>>>>>  .../port/compiler-rt/lib/builtins/udivti3.c   |  23 ++
>>>>>  8 files changed, 1111 insertions(+)
>>>>>  create mode 100644 lib/mbedtls/port/compiler-rt/LICENSE.TXT
>>>>>  create mode 100644 lib/mbedtls/port/compiler-rt/README.txt
>>>>>  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/int_endianness.h
>>>>>  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/int_lib.h
>>>>>  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/int_types.h
>>>>>  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/int_util.h
>>>>>  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/udivmodti4.c
>>>>>  create mode 100644 lib/mbedtls/port/compiler-rt/lib/builtins/udivti3.c
>>>>>
>>>>> diff --git a/lib/mbedtls/port/compiler-rt/LICENSE.TXT b/lib/mbedtls/port/compiler-rt/LICENSE.TXT
>>>>> new file mode 100644
>>>>> index 00000000000..5a79a1b9d5c
>>>>> --- /dev/null
>>>>> +++ b/lib/mbedtls/port/compiler-rt/LICENSE.TXT
>>>>> @@ -0,0 +1,311 @@
>>>>> +==============================================================================
>>>>> +The LLVM Project is under the Apache License v2.0 with LLVM Exceptions:
>>>>> +==============================================================================
>>>>> +
>>>>> +                                 Apache License
>>>>> +                           Version 2.0, January 2004
>>>>> +                        http://www.apache.org/licenses/
>>>>
>>>> I don't know that this is compatible for us. Looking at
>>>> https://www.apache.org/licenses/GPL-compatibility.html it talks about
>>>> how you can use it with GPLv3 (which we are *NOT*) but not GPLv2.
>>>>
>>> My bad didn't realize Apache 2.0 is not compatible with GPLv2...
>>> I am not sure but it seems that this incompatibility does not even
>>> allow static linking into a GPLv2 project.
>>> Then, how to make it possible to use LLVM? Can we upgrade to GPLv2+?
>>
>> However the linux kernel people do it, we can do it too. And perhaps
>> that's part of what's motivating LLVM to be able to disable these
>> intrinsics that we don't actually need?
>>
> OP-TEE did the same thing, it is GPLv2 too.

No. optee_os is (mostly) BSD-2-Clause. Only the test suite (optee_test)
is GPLv2.

I too did not realize that Apache 2.0 was not compatible with GPLv2.
Otherwise I would not have suggested this option for U-Boot. Sorry about
that.

Regards,
-- 
Jerome

-- 
Jerome

> 
> Raymond
> 
> 
>> --
>> Tom
