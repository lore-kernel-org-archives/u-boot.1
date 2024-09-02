Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0750CCA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 15:21:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4120588AD2;
	Mon,  2 Sep 2024 17:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gcIoaqQo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FDFB88B49; Mon,  2 Sep 2024 17:21:11 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAE6588861
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 17:21:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a86a37208b2so502554766b.0
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 08:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725290468; x=1725895268; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i9pfx2H9uPAIL/Uo4WyeGS0F27UqV3nvha+5vC0dmIY=;
 b=gcIoaqQomIL6cmIaeZf4tnzkmkX8K6Ryo2M4BcRKktIYRi9ewrhsLYsj5RAXbomahe
 qti3DiEt9JH+gXuz0dZFjaLLHgbgmkEvAt2cmNmwQv51ERReEKAguY2RJ7XAwJU7FA3x
 PFAf54/ohBtBINTQhOa5E2oy17Z4VbT5bd34TdFCA/SFBez6uLealiCBdLWTBvVw9FD0
 dlS19vyTBZ4Hauo5tm0R7MGXWWYfEQ5rvyiVRwGo50dcvIZZZor0zEEYpApbKhj0zsun
 MWN8CvPypifW+kcjCRbWp/4K2HACBDEN7Bl89DDnOc4SYKryc6zPVfxy06Qaec+KWoLj
 f6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725290468; x=1725895268;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i9pfx2H9uPAIL/Uo4WyeGS0F27UqV3nvha+5vC0dmIY=;
 b=Kwxoa2WKEztMtvhfI4HqrsFqGy4L7DVhLGo08YDQtu6Lz90d7nG57FwgrZFt+egv2/
 I+6IfdsTjsACQaliyQE4HOo3jvsjwh62uTwp+dn/mlsd2KdosGRnlhwwYRqGF61x/U5I
 I9/dpdNPLoZfoxAOVTL5CTO0Bm7ZRBx0FKDIP7sawSEnrJw4ziNi6+oul47GomGHQObq
 cgQu1b25S3uduew2UsOb8ENrSiDgH2BLTlXfMEPU+1G+A5RbT+qafBTNbBEyUGuaPyti
 5A6yM/QRmo//ePWzlku1anEMue/UFirmdiCV8z6oXHctsI1v1jiKxjPf0Hbny7YlynRW
 eq7g==
X-Gm-Message-State: AOJu0Yx560X90ucWjZ9u+oPew4fD7+F6dLYFwDGfabBHejJ8d/C7mmqP
 kIT3cVye2P7IbduZ8jkyXwGM3euonEMxgfsp/mQowc/lEz91rxx6S2EIzbXQl1E=
X-Google-Smtp-Source: AGHT+IGEGsBcCERMcx0q7o0VbBYCVmWBohMsd4VzMkRX0+KNsKBs/qSjuCnhHxgvQreZVDyPLjMICw==
X-Received: by 2002:a17:907:94c2:b0:a77:c95e:9b1c with SMTP id
 a640c23a62f3a-a897f84bb8cmr1265940466b.27.1725290467958; 
 Mon, 02 Sep 2024 08:21:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9?
 ([2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a898919670asm578354866b.140.2024.09.02.08.21.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2024 08:21:07 -0700 (PDT)
Message-ID: <e2a3445f-00ba-4261-84f2-8d061ad6710e@linaro.org>
Date: Mon, 2 Sep 2024 17:21:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] Makefile: detect HOST_ARCH properly when
 CROSS_COMPILE is multi-word
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>
References: <cover.1725012294.git.jerome.forissier@linaro.org>
 <e2f0809aa4b9d81cf1709a6b82d803a21ea1fac7.1725012294.git.jerome.forissier@linaro.org>
 <CAFLszTgPCkaSrfzcT1i=4pH-VS4mqBfOa2Tw6Ow02J=rc+V3aw@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAFLszTgPCkaSrfzcT1i=4pH-VS4mqBfOa2Tw6Ow02J=rc+V3aw@mail.gmail.com>
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



On 9/1/24 22:09, Simon Glass wrote:
> Hi Jerome,
> 
> On Fri, 30 Aug 2024 at 04:17, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> When CROSS_COMPILE contains multiple words, HOST_ARCH is not properly
>> detected and the sandbox build fail. It typically happens when using
>> ccache. For example:
>>
>>  $ make sandbox_defconfig
>>  $ make CROSS_COMPILE="ccache x86_64-linux-gnu-" \
>>         CC="ccache x86_64-linux-gnu-gcc"
>>  [...]
>>  In file included from boot/bootmeth_efi.c:16:
>>  include/efi_default_filename.h:33:2: error: #error Unsupported UEFI architecture
>>     33 | #error Unsupported UEFI architecture
>>        |  ^~~~~
>>
>> A similar error occurs when the build is done via buildman and
>> ~/.buildman contains:
>>
>>   [toolchain-wrapper]
>>   wrapper = ccache
>>
>> Fix the issue by considering only the last word in $(CROSS_COMPILE).
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> ---
>>  Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> This patch[1] seems to fix the problem you mention, for the CC part at least.

No, it fails with buildman:

$ git log --oneline -n 1
454b2b2e6ed (HEAD) efi: Use the same filename for all sandbox builds
jerome@builder:~/work/u-boot ((454b2b2e6ed...))$ ./tools/buildman/buildman sandbox_noinst
Building current source for 1 boards (1 thread, 24 jobs per thread)
   sandbox:  +   sandbox_noinst
+arch/sandbox/lib/reloc_sandbox_efi.c:10:15: error: operator '==' has no left operand
+   10 | #if HOST_ARCH == HOST_ARCH_X86_64
+      |               ^~
[...]

> For the CROSS_COMPILE bit, why is it valid to use a cross compiler on sandbox?

Why not? "CROSS_COMPILE=x86_64-linux-gnu-" should result in x86_64-linux-gnu-gcc
being used which is equivalent to gcc on a x86_64 system.
 
>>
>> diff --git a/Makefile b/Makefile
>> index f90e48f58a..dc7bdd7942 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -21,7 +21,7 @@ include include/host_arch.h
>>  ifeq ("", "$(CROSS_COMPILE)")
>>    MK_ARCH="${shell uname -m}"
>>  else
>> -  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
>> +  MK_ARCH="${shell echo ${lastword $(CROSS_COMPILE)} | sed -n 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
>>  endif
>>  unexport HOST_ARCH
>>  ifeq ("x86_64", $(MK_ARCH))
>> --
>> 2.40.1
>>
> 
> Regards,
> Simon
> 
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20240815202424.766778-9-sjg@chromium.org/


Thanks,
-- 
Jerome
