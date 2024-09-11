Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26BAEE4983
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 09:44:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42458885A5;
	Wed, 11 Sep 2024 11:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qvRZDH4Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AE278922F; Wed, 11 Sep 2024 11:44:25 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D84E088549
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 11:44:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-536748c7e9aso766997e87.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 02:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726047862; x=1726652662; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HD+XtklTeGu7bVc6uQeKUd5hWNcasyvSjGlbQI2T958=;
 b=qvRZDH4Z0/Dam3Qx2flMdNDvkYL/70/Wz44TEZYB4AnLxqOFVXBUSseu1IXX7oJaCU
 b7ubcDprjvQUOB+8yZD7zRJgBARiiZTpXtA/ijzAlS0a/F3RWZqQdsDPO5GOT1nsV36F
 FHRDE4SEGB2uL70P9qXmbLaJl3omIkusAKkzY9zHsrPkzvugqwCVwQullrnMXQlPkU/k
 +SNzpcybIeB7jKMfunoFslaEka1x/0bSZdk5PelRPGurI/e50jYcX1JMCZZCfb4hDDHr
 qfae77eUyeq0FRsjxKTlDE97h+b5TPQ/mlGq5TSatGcRcvUjfp5sb9TtaC4zJATCC0Vc
 QBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726047862; x=1726652662;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HD+XtklTeGu7bVc6uQeKUd5hWNcasyvSjGlbQI2T958=;
 b=hD3jTjq6EnSoD2IwSliw9jK9BEmbHuvdfQC+bD6xMbPqY6Ci3l4u8m0oEs5F8lU3rf
 Tvdhix1V/Csg/6zgbp6G8wgRjhZ4ob9BmQyM+9W9jQsUZEcktVVUQAPfrICqDHWBi4nz
 /560r3fbxbIVCTiGzz5QMR+umeB0FxbFqUK+Ji3GNSgL36XB1j+xLPxxJgGMeAEgem8m
 Gdv0tJr6ZiQECsvtrfnpM+zcXLQgHMqM8pEsplys6JR9yzEKQtwWB/bOO6hkhgOxunxA
 cjarmdekEBUvKEWmVuzuMMW77lQC3rdUlICfeEM1JyFaDLaivcpbkznSPOVs+Yzz8V7A
 8umw==
X-Gm-Message-State: AOJu0YzdrKMmbcb0HTNsjcrJ4vtG/Wzq24cc/1u8rxJXa9zS14H9zCOB
 qoYOOJTWoWXivcJAixegBNarN0BKZ/pmPs3HR5iJmg/lMBEd8LrsVP58jiByldA=
X-Google-Smtp-Source: AGHT+IGbEHnuKYlSKbpW8np60cCatuCojf1xJvKwDWEkFOqXGOka3TBUpl9hiqPNuko//wpobT3eeA==
X-Received: by 2002:a05:6512:3c88:b0:52c:e012:efad with SMTP id
 2adb3069b0e04-53673a63416mr1720731e87.12.1726047861828; 
 Wed, 11 Sep 2024 02:44:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:1a64:5ef:379f:729a?
 ([2a01:e0a:3cb:7bb0:1a64:5ef:379f:729a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c73c00sm591124466b.101.2024.09.11.02.44.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 02:44:21 -0700 (PDT)
Message-ID: <f06b0774-d47c-4414-9974-89d2ebbf1902@linaro.org>
Date: Wed, 11 Sep 2024 11:44:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/16] Makefile: detect HOST_ARCH properly when
 CROSS_COMPILE is multi-word
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sumit Garg
 <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Bryan Brattlof <bb@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>
References: <cover.1725351676.git.jerome.forissier@linaro.org>
 <a5617c0cb57624d004c4b4f42861822016edb2e9.1725351676.git.jerome.forissier@linaro.org>
 <CAFLszTgr9fEmdx9No2yh-1tiVW4P1qb+mWFJ=Zk6Om_d_CFuXQ@mail.gmail.com>
 <72a8df61-16b2-4d73-a1e5-db0ef1d5cd07@linaro.org>
 <CAFLszTifWxDMmW=G_4w2f5bHU-FOg5nsmd4_EeOhwVSMzHzXFQ@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAFLszTifWxDMmW=G_4w2f5bHU-FOg5nsmd4_EeOhwVSMzHzXFQ@mail.gmail.com>
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

Hi Simon,

TL;DR: I am dropping this patch in v4.

On 9/10/24 20:44, Simon Glass wrote:
> Hi Jerome,
> 
> On Fri, 6 Sept 2024 at 09:10, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Hello Simon,
>>
>> On 9/6/24 17:02, Simon Glass wrote:
>>> Hi Jerome,
>>>
>>> On Tue, 3 Sept 2024 at 02:38, Jerome Forissier
>>> <jerome.forissier@linaro.org> wrote:
>>>>
>>>> When CROSS_COMPILE contains multiple words, HOST_ARCH is not properly
>>>> detected and the sandbox build fail. It typically happens when using
>>>> ccache. For example:
>>>>
>>>>  $ make sandbox_defconfig
>>>>  $ make CROSS_COMPILE="ccache x86_64-linux-gnu-" \
>>>>         CC="ccache x86_64-linux-gnu-gcc"
>>>>  [...]
>>>>  In file included from boot/bootmeth_efi.c:16:
>>>>  include/efi_default_filename.h:33:2: error: #error Unsupported UEFI architecture
>>>>     33 | #error Unsupported UEFI architecture
>>>>        |  ^~~~~

As you mentioned in your reply to this patch in v2 [1], this is not
a valid use case (CROSS_COMPILE should not be set for sandbox).

[1] http://patchwork.ozlabs.org/project/uboot/patch/e2f0809aa4b9d81cf1709a6b82d803a21ea1fac7.1725012294.git.jerome.forissier@linaro.org/#3377679

>>>>
>>>> A similar error occurs when the build is done via buildman and
>>>> ~/.buildman contains:
>>>>
>>>>   [toolchain-wrapper]
>>>>   wrapper = ccache


This problem is still present in -next though (which does have your
patch "buildman: Support building within a Python venv" [2]).

It is my patch "buildman/toolchain.py: do not set CROSS_COMPILE for
sandbox" [3] that solves the problem.

[2] https://patchwork.ozlabs.org/project/uboot/patch/20240815195746.749042-2-sjg@chromium.org/
[3] http://patchwork.ozlabs.org/project/uboot/patch/f4defe07f87f6c9761b401d435da03460b3b0947.1725351676.git.jerome.forissier@linaro.org/

So all in all this patch is not needed.

Regards,
-- 
Jerome

>>>> Fix the issue by considering only the last word in $(CROSS_COMPILE).
>>>>
>>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
>>>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
>>>> ---
>>>>  Makefile | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/Makefile b/Makefile
>>>> index f90e48f58a5..dc7bdd79420 100644
>>>> --- a/Makefile
>>>> +++ b/Makefile
>>>> @@ -21,7 +21,7 @@ include include/host_arch.h
>>>>  ifeq ("", "$(CROSS_COMPILE)")
>>>>    MK_ARCH="${shell uname -m}"
>>>>  else
>>>> -  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
>>>> +  MK_ARCH="${shell echo ${lastword $(CROSS_COMPILE)} | sed -n 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
>>>>  endif
>>>>  unexport HOST_ARCH
>>>>  ifeq ("x86_64", $(MK_ARCH))
>>>> --
>>>> 2.40.1
>>>>
>>>
>>> I've lost track of this, but did you pull in [1] first?
>>
>> Oops! No I didn't :-/ In fact I could not find the reference to the patch
>> in your initial email, then I forgot about it.
>> Would you like me to resend the whole series as v4 with your patch included?
> 
> I just want to know that there is still a problem, with my patch. So
> yes please try it and update the commit messages as needed for the two
> affected patches.
> 
> Regards,
> Simon
> 
> 
>>
>>>
>>> Regards,
>>> Simon
>>>
>>> [1] https://patchwork.ozlabs.org/project/uboot/patch/20240815195746.749042-2-sjg@chromium.org/
>>
>> Thanks,
>> --
>> Jerome
