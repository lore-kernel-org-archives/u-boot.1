Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80591CFA751
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 08:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B61F189049;
	Fri,  4 Oct 2024 10:46:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lnF5YEq/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76BD78901A; Fri,  4 Oct 2024 10:46:22 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7262F88FF6
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 10:46:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a8d6ac24a3bso361943566b.1
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 01:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728031580; x=1728636380; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CQ16gVhb3HIidM80/qilUBvKaqJNtukuuR/NjSxp7U0=;
 b=lnF5YEq/wFNDM0aRrpvKzVESTmHAU8TbkgmqYzAjfCgA/KommeoJXMym+eaXn9ZIL3
 mxRm/ErpIvfEpuOQQWnssjLHo9vTwxGi3hkBazOI3pHwTAUQ1QrKf1u/urAABzaK9Qif
 cgsoG/02Z09rCuoC4L+ASGQGlc/W/e7Wh6Obyjkypcr17cohk6mlJzWCe6MMCKwUalRw
 g8uutEtLASD5V5Pw4bhOfihih35Nd22EZ0F/9PBvbdc6vHjJIIlHDjv0KcIb6bIVeC0l
 1QLe0mFWowjsLZ7K1qFQDkhC4DXGQyDJmn48TuTUAGyneom77NrfbJitVLMXgYYJTfuW
 aVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728031580; x=1728636380;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CQ16gVhb3HIidM80/qilUBvKaqJNtukuuR/NjSxp7U0=;
 b=dp1lMHRrZJT3C9wXnv6QlO2+AztjLyg1SgQQHhYipemsFpb+EU28lBz6iFcsMQce0V
 xOS+MTrX4DI5bU793CRMo+MyttUE9/CW76thJWEQ518wmkgtyPq1A98KUlqRd8b//j95
 uyyQiR6dzGa1iJwHngaP9oSpiT/LAZ9UQePPNKb3DY1ndj9i9QY1IRTfgAeOOo9bIkbF
 rWQsAJOVTvhKTC+uv5YFOlnEb7uSvRCPX7mRdhtpKXKRvIHQ7zrHJ1GcjcqiSgNaIP6e
 f05jBXB7C9OjRY7RykZGx7iruvN+sekeNcXZcjG9s7ajYoZSD+k++BeIzm1ggLiWhBEL
 O6/g==
X-Gm-Message-State: AOJu0Yw64YYPwn1NySQ0p3PzPre9XW5hsmtGrrQQWiz7WZJE4QmHpuju
 fHc7fxiUqlg6Y5DP7IOxjw0GNG6ypRCKZZNBWe1cC+JY/cYYerUcLA2NI1SniJk=
X-Google-Smtp-Source: AGHT+IFD/PLOvZuRg0AJsonfVSSZbINxc0BEO9S7FztMBjnGzpAVDaNO1D9WkkjTEPfRFvi6iyuvSQ==
X-Received: by 2002:a17:907:7e9c:b0:a8d:2afc:c06a with SMTP id
 a640c23a62f3a-a991cf73a2fmr159294466b.19.1728031579752; 
 Fri, 04 Oct 2024 01:46:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:c79f:f6d3:6b70:dbe?
 ([2a01:e0a:3cb:7bb0:c79f:f6d3:6b70:dbe])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99104c231fsm193302866b.197.2024.10.04.01.46.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 01:46:19 -0700 (PDT)
Message-ID: <e9c3ac80-84f0-4900-85fc-b9af4ebc5363@linaro.org>
Date: Fri, 4 Oct 2024 10:46:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/29] test: boot: fix bootflow_cmd_label for when
 DSA_SANDBOX is disabled
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>, Anton Antonov <Anton.Antonov@arm.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <2e8206d8bbd7d3140cf2734ca9b3fcd12ced4f14.1727968902.git.jerome.forissier@linaro.org>
 <CAC_iWjLTVV=QpfgGMTSJ205JGRzNDkBuJeO9GwEW4D4PhrJWrw@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjLTVV=QpfgGMTSJ205JGRzNDkBuJeO9GwEW4D4PhrJWrw@mail.gmail.com>
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



On 10/4/24 08:55, Ilias Apalodimas wrote:
> Hi Jerome,
> 
> On Thu, 3 Oct 2024 at 18:23, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> When DSA_SANDBOX is not set, the sandbox tests fail as follows:
>>
>>  $ ./test/py/test.py --build-dir=$(pwd) -k bootdev_test_any
>>  [...]
>>  Scanning for bootflows with label '9'
>>  [...]
>>  Cannot find '9' (err=-19)
>>
>> This is due to the device list containing two less entries than
>> expected. Therefore, look for label '7' when DSA_SANDBOX is disabled.
>>
>> The actual use case is NET_LWIP=y (to be introduced in later patches)
>> which implies DSA_SANDBOX=n for the time being.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  test/boot/bootflow.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
>> index 6ad63afe90a..c440b8eb778 100644
>> --- a/test/boot/bootflow.c
>> +++ b/test/boot/bootflow.c
>> @@ -109,9 +109,12 @@ static int bootflow_cmd_label(struct unit_test_state *uts)
>>          * 8   [   ]      OK  mmc       mmc2.bootdev
>>          * 9   [ + ]      OK  mmc       mmc1.bootdev
>>          * a   [   ]      OK  mmc       mmc0.bootdev
>> +        *
>> +        * However with CONFIG_DSA_SANDBOX=n we have two less (dsa-test@0 and
>> +        * dsa-test@1).
>>          */
>> -       ut_assertok(run_command("bootflow scan -lH 9", 0));
>> -       ut_assert_nextline("Scanning for bootflows with label '9'");
> 
> Shouldn't this under and #ifdef, IS_ENABLED etc?

In theory yes, but we can avoid the conditional by using index 7 which is always
valid, i.e., in all configurations we have at least 7 devices (even 8 actually).

> 
>> +       ut_assertok(run_command("bootflow scan -lH 7", 0));
>> +       ut_assert_nextline("Scanning for bootflows with label '7'");
>>         ut_assert_skip_to_line("(1 bootflow, 1 valid)");
>>
>>         ut_assertok(run_command("bootflow scan -lH 0", 0));
>> --
>> 2.40.1
>>
