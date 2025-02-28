Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78165C282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 13:09:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4F5C81110;
	Fri, 28 Feb 2025 14:09:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VEoCdP3Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1AB681113; Fri, 28 Feb 2025 14:09:36 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7020A810ED
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 14:09:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so325220466b.2
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 05:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740748146; x=1741352946; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J4NFyWPJcF2psPjOJ6dn4w7obmeArJhzQRPd684UOxg=;
 b=VEoCdP3ZCL8e3KI5+SjI97MadsRVe9n/OFFapV/eWU40h+G6VU2o+/7AajpC8WhTMk
 aP6yyPV+9RBX2w2vnuII07b2E+JNr1C1kezi5eqTlzlFRLxenctNQ1VJAUtrFcJ21gUB
 CLIk90c0KqO7wV/uFQz42Hzi1EFKbnGE0Aee/KB0/JyvES2uhPjrNcIEUEqc117FUM39
 h2RwGupZ0oDeVbELrlkGDg2kG5Ic8b1ftfG1CPhv1+gThRlmW2nD4YYaEZhC0dU3fifc
 yIqnMemVZ0AIEjR/e6J/OZw7e7cQgAFt1mEUsNgS4/D/93gi6e8aw4fZt9w1h+wL94e4
 ewQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740748146; x=1741352946;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J4NFyWPJcF2psPjOJ6dn4w7obmeArJhzQRPd684UOxg=;
 b=sn3OP0G7FHKYg4+wfZDAqmJ751T7Pqej0p6kOG1C8gn0lpTufLzJQK/DCefFv8+kTD
 phcP678D7HiQR2JQsVjm6gANCkWDiaFsxmRcRHNI85dFxUGDOB41OcGFojhTIdA7LX6z
 G56bfLkGN/OEJif6lxUJjcXXovJBic0+Bw7LqVE6kTXDiJSupNOyOXr+9eTGrd1E8u14
 J5gv+seh05YeW+t3GP8TU0k2pU/VzHUU+j1I8b0+eOK+VCi/kw3gmQAavSzCI0mvTfTB
 rn9bFoTW9fLxkOF2hlWWXup2aqC34eSBjjMDW5yuY14KufH3srNNfmOBpslOdjHa43a1
 V7aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL5OZolcjKm7Fv7jlfmez91pdJySnkFW+MbE5p7s1YpY/HQCjL73UWGc3nNz5lHOnzvIJr958=@lists.denx.de
X-Gm-Message-State: AOJu0YwhlbOWz9krwgpRORkp9+R19A6zzY7qn9JhHD2tuGznoP2ehd5g
 Pr/GJMhvfueBW0QDwj0xRH+FNhjKWXAGEsPAdte/I4/UeskgLfVj+glYnxBjXeXsbzyKp7vPyMd
 owac=
X-Gm-Gg: ASbGncuJkrSj4/VXT0uM++fTrXyBsySgqJIGsQltKlYasFitPSBHGguVK56/+s37trm
 QAp2Jraulg35aW847VEjEltfegdz7jfesIncsNH9GTbJprcHOguDdGyuS8H4qzK6Ds4eaogsz27
 1BRPL4S+WzGK0aDj6q1RRFIHKZYexlQ3928FqU9fhIUDpxcdqnuSraTvyv7VHzvCvFGLLj834uL
 8xd53KtXSS33PQKKVjbR7tMJn8nNzS89K9nB0Dnw7hx/PYikYARv0CHZK1ntOB6ptPGUEQGeM2m
 CGQ3+5y2ksNLlsHNeyUI/6NdEiZOgXhElxuI5yC1CXJA9hs5SWqYCxQDkv1adPevkirv6j7BANU
 wu33CDg==
X-Google-Smtp-Source: AGHT+IEqGzVFUaYvwmstlrRwcEvE7qcbMqlohNgBlMR1zJ9Av+9cyM3pbGC1MNjWmRrtXP5CLYyxnQ==
X-Received: by 2002:a17:907:1c0c:b0:ab7:eda3:3612 with SMTP id
 a640c23a62f3a-abf2687e933mr365362566b.50.1740748146346; 
 Fri, 28 Feb 2025 05:09:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:c779:ac28:4c86:118c?
 ([2a01:e0a:3cb:7bb0:c779:ac28:4c86:118c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c7c0faasm290405866b.179.2025.02.28.05.09.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 05:09:05 -0800 (PST)
Message-ID: <0b4ea41e-2198-4924-a272-94eef4588bd4@linaro.org>
Date: Fri, 28 Feb 2025 14:09:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] test: lib: add initjmp() test
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>, u-boot@lists.denx.de
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <6eb03993def0d868874fa3fca05e1d08ddc6afd6.1740499185.git.jerome.forissier@linaro.org>
 <7a3a4ed0-7622-4a6c-bbc6-f60dd9cd134a@gmx.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <7a3a4ed0-7622-4a6c-bbc6-f60dd9cd134a@gmx.de>
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



On 2/28/25 14:04, Heinrich Schuchardt wrote:
> On 25.02.25 17:34, Jerome Forissier wrote:
>> Test the initjmp() function when HAVE_INITJMP is set.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>   test/lib/Makefile  |  1 +
>>   test/lib/initjmp.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 73 insertions(+)
>>   create mode 100644 test/lib/initjmp.c
>>
>> diff --git a/test/lib/Makefile b/test/lib/Makefile
>> index 0e4cb8e3dfd..bf04685dae1 100644
>> --- a/test/lib/Makefile
>> +++ b/test/lib/Makefile
>> @@ -14,6 +14,7 @@ obj-y += hexdump.o
>>   obj-$(CONFIG_SANDBOX) += kconfig.o
>>   obj-y += lmb.o
>>   obj-$(CONFIG_HAVE_SETJMP) += longjmp.o
>> +obj-$(CONFIG_HAVE_INITJMP) += initjmp.o
>>   obj-$(CONFIG_CONSOLE_RECORD) += test_print.o
>>   obj-$(CONFIG_SSCANF) += sscanf.o
>>   obj-$(CONFIG_$(PHASE_)STRTO) += str.o
>> diff --git a/test/lib/initjmp.c b/test/lib/initjmp.c
>> new file mode 100644
>> index 00000000000..52bbda8cc60
>> --- /dev/null
>> +++ b/test/lib/initjmp.c
>> @@ -0,0 +1,72 @@
>> +// SPDX-License-Identifier: GPL-2.0+
> 
> GPL-2.0-or-later

Ack.

Thanks,
-- 
Jerome

> 
> Best regards
> 
> Heinrich
> 
>> +/*
>> + * Copyright 2025 Linaro Limited
>> + *
>> + * Unit test for initjmp()
>> + */
>> +
>> +#include <compiler.h>
>> +#include <asm/setjmp.h>
>> +#include <stdbool.h>
>> +#include <test/lib.h>
>> +#include <test/ut.h>
>> +#include <vsprintf.h>
>> +
>> +static bool ep_entered;
>> +static jmp_buf return_buf;
>> +
>> +static void __noreturn entrypoint(void)
>> +{
>> +    ep_entered = true;
>> +
>> +    /* Jump back to the main routine */
>> +    longjmp(return_buf, 1);
>> +
>> +    /* Not reached */
>> +    panic("longjmp failed\n");
>> +}
>> +
>> +static int lib_initjmp(struct unit_test_state *uts)
>> +{
>> +    int ret;
>> +    void *stack;
>> +    jmp_buf buf;
>> +    int stack_sz = 1024;
>> +
>> +    ep_entered = false;
>> +
>> +    stack = malloc(stack_sz);
>> +    ut_assertnonnull(stack);
>> +
>> +    ut_assert(!ep_entered);
>> +
>> +    /*
>> +     * Prepare return_buf so that entrypoint may jump back just after the
>> +     * if()
>> +     */
>> +    if (!setjmp(return_buf)) {
>> +        /* return_buf initialized, entrypoint not yet called */
>> +
>> +        /*
>> +         * Prepare another jump buffer to jump into entrypoint with the
>> +         * given stack
>> +         */
>> +        ret = initjmp(buf, entrypoint, stack + stack_sz);
>> +        ut_assertok(ret);
>> +
>> +        /* Jump into entrypoint */
>> +        longjmp(buf, 1);
>> +        /*
>> +         * Not reached since entrypoint is expected to branch after
>> +         * the if()
>> +         */
>> +        ut_assert(false);
>> +    }
>> +
>> +    ut_assert(ep_entered);
>> +
>> +    free(stack);
>> +
>> +    return 0;
>> +}
>> +LIB_TEST(lib_initjmp, 0);
> 
