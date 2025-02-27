Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D399EC282C1
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 17:12:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49F9081277;
	Thu, 27 Feb 2025 18:12:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IuRxL8gv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19B9A812C3; Thu, 27 Feb 2025 18:12:10 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF3A3811C1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 18:12:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aaedd529ba1so129851766b.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 09:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740676327; x=1741281127; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yQHDby/uXZLGardrGWdQR0Vbute0Hbf9OqyCLVxZbAo=;
 b=IuRxL8gvC/rJYmvz6DinPyaA/hD/Gi5QF93AoQwqjRmj5XItZ5mpHuMJ6BiRHzRU+A
 8gDYvTNpRtwWRMHE9I/7EGBpLd88NSufSDYcZPWgiMfenHCjDDHna7RmxTLN1JtIsMYf
 MUyOmWi/aVPaUcWNypCTbrEDbFWKE/418J/LuwQAY7VZ9nwzKR8YJgt/imWo0SbozXSS
 Tf3Yrs4kWykeMy7GVcIUDUtsb8q8l+x1fNfGbJuNt4LroHvgS2gbHkzGoR71pWL/7WDc
 3L/nlRXRa8i7um0fcCMXyNXsPzNrc3arulQ6OnZVxH8l+Js3ob6DDDkr51RmAttC49b9
 A+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740676327; x=1741281127;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yQHDby/uXZLGardrGWdQR0Vbute0Hbf9OqyCLVxZbAo=;
 b=AGbpK0qt5KqWEEtbE2M2dn8rH9FGlmiv2BGdVrzUIl6E25/WlzXKWhiDzN31aGmlCV
 NfR6hLIJKgVBPbU0weFC7RVRBUHA2ocDVUazvzLJm8CH63UOWpEtcNXoRMtF0eHlk4bK
 T60jOcysR0nf0a5ooyfxD6KCE4eZnVRLRE3W6AeHqgQJpCQNuxavvGPTYjwZ8IensHMG
 W9wHMSM1qEHuT5zZoaKEAp00KVi/lwDlwsGo3hjZ2Lu6sWnXpzV5LHIrEBx60lDd2mw6
 VcgWk4TsRcMd7YLmHgZkKq3yXF2ol29mlxHwkMN3xZWElvNu/tXgTTAOJA+RWOWUK4gq
 IOvA==
X-Gm-Message-State: AOJu0Yx0UFfWuJ6KMp1CKkiWJq7imnEpN1IM89e1Lxflx8nVmyWSue1m
 GgORvlyCTZh+ALbinSNI3pnmb1AK60iy5KiLrw7Zeet5Jx1gTqbddU8rpsI93eg=
X-Gm-Gg: ASbGncvTdORi6qScSlibjJRU+AMxkuLv+SQl2cZnAkFWc5r4tVfQIJZeRGvKguhC9WW
 Ag4d0KoNm0mFCyRvIbgIeyWd3S7nXincu4j7gmhWg2kzefZXPVFZnuVC6/A1wh+Z26RV87q7ze3
 MrQQxxWjNVIMvzOrrhBXWf9V67ThQmWkxi2wYX6cKzyIscdd+0uKAOnM0uR9vRuHvbSl8BdF0PK
 WR9la0Bf51qZlh5HZZNo9BU1cbAFd0yRHZ5jQ/oqLFuyngxkBmL7S307nq0a+CjU4efycThTsnf
 jHxNWr8433wwA4JZnx+5m3S21CrTj6s1JuqbbronxWDpOWfyoQ6KpcGtlobQyawKeaqQoA7TNni
 tgYwDTg==
X-Google-Smtp-Source: AGHT+IGUycYSpU1wUQnzQbQPpfoyDE/Nl/ZyEgAGJTX6tk8zwIDLXJJIfNQp8108CVdrLARPD98ulg==
X-Received: by 2002:a05:6402:34d5:b0:5e0:82a0:50ce with SMTP id
 4fb4d7f45d1cf-5e44ba424d9mr29240750a12.27.1740676327098; 
 Thu, 27 Feb 2025 09:12:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:a4a3:25fd:919c:f316?
 ([2a01:e0a:3cb:7bb0:a4a3:25fd:919c:f316])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c7bb85asm149570366b.162.2025.02.27.09.12.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 09:12:06 -0800 (PST)
Message-ID: <9bc38835-8050-4b6c-acb3-3f2d3db08e6c@linaro.org>
Date: Thu, 27 Feb 2025 18:12:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] test: dm: add test for spawn and wait commands
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <2f17fd7ec21b59218d5bf88f045c13db08f906ca.1740499185.git.jerome.forissier@linaro.org>
 <CAFLszTi_p4PFNkSFk+yMLaQoSUe6pVXvGiD2UX08Ka2j0jyS1Q@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAFLszTi_p4PFNkSFk+yMLaQoSUe6pVXvGiD2UX08Ka2j0jyS1Q@mail.gmail.com>
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

On 2/27/25 17:25, Simon Glass wrote:
> Hi Jerome,
> 
> On Tue, 25 Feb 2025 at 09:35, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Test the spawn and wait commands.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  test/cmd/Makefile |  1 +
>>  test/cmd/spawn.c  | 33 +++++++++++++++++++++++++++++++++
>>  2 files changed, 34 insertions(+)
>>  create mode 100644 test/cmd/spawn.c
>>
>> diff --git a/test/cmd/Makefile b/test/cmd/Makefile
>> index d8a5e77402d..cf47f04851c 100644
>> --- a/test/cmd/Makefile
>> +++ b/test/cmd/Makefile
>> @@ -39,3 +39,4 @@ obj-$(CONFIG_CMD_WGET) += wget.o
>>  endif
>>  obj-$(CONFIG_ARM_FFA_TRANSPORT) += armffa.o
>>  endif
>> +obj-$(CONFIG_CMD_SPAWN) += spawn.o
>> diff --git a/test/cmd/spawn.c b/test/cmd/spawn.c
>> new file mode 100644
>> index 00000000000..5e0770858c0
>> --- /dev/null
>> +++ b/test/cmd/spawn.c
>> @@ -0,0 +1,33 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Tests for spawn and wait commands
>> + *
>> + * Copyright 2025, Linaro Ltd.
>> + */
>> +
>> +#include <command.h>
>> +#include <dm.h>
>> +#include <dm/test.h>
>> +#include <test/test.h>
>> +#include <test/ut.h>
>> +
>> +static int dm_test_cmd_spawn(struct unit_test_state *uts)
>> +{
>> +       ut_assertok(run_command("wait; spawn sleep 2; setenv j ${job_id}; "
>> +                               "spawn setenv spawned true; "
>> +                               "setenv jj ${job_id}; wait; "
>> +                               "echo ${j} ${jj} ${spawned}", 0));
>> +       console_record_readline(uts->actual_str, sizeof(uts->actual_str));
>> +       ut_asserteq_ptr(uts->actual_str,
>> +                       strstr(uts->actual_str, "1 2 true"));
>> +
>> +       ut_assertok(run_command("spawn true; wait; setenv t $?; spawn false; "
>> +                               "wait; setenv f $?; wait; echo $t $f $?", 0));
>> +       console_record_readline(uts->actual_str, sizeof(uts->actual_str));
>> +       ut_asserteq_ptr(uts->actual_str,
>> +                       strstr(uts->actual_str, "0 1 0"));
>> +       ut_assert_console_end();
>> +
>> +       return 0;
>> +}
>> +DM_TEST(dm_test_cmd_spawn, UTF_CONSOLE);
>> --
>> 2.43.0
>>
> 
> This doesn't look like a DM test as it doesn't use devices. Could it
> be a CMD test?

Absolutely. In fact I started from a copy of test/cmd/hash.c, which is
not a DM test either is it?

Regards,
-- 
Jerome
