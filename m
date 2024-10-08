Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05306CED27C
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 08:50:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52C0D88AC2;
	Tue,  8 Oct 2024 10:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="awNAHItm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CF1188DAA; Tue,  8 Oct 2024 10:50:07 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 534E488B6C
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 10:50:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2faccccbca7so44811421fa.2
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 01:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728377401; x=1728982201; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rIoY14yTlilEKOSAKUmHpAjKRBmho5TCkeMVUypHK20=;
 b=awNAHItmF1QyQpQZWOZa+ezvOPRvZ+8ay+gTlMmp4sdz/pmLJr5F/G1oiclKCWBQZy
 jV1U1fJ6I5vzJt1uKYf1CODK9syv0rJCYdBaQwnUOb1ODt8oOmz/QRu3SSy7ldcOZESr
 vzLm0agvc9UxygfURzAR04k37q/fZ3lWq8ZzBEr79Ox+v7keZ3ZGi+wJ/55oNgJ5/mqK
 E5wYK4YYBcPOBVyN9rzqXFROFhg9SYorHf5WVYfu0VCsX8hT8SxnF8j4gXX5q5qtRmCy
 Ym2LHhFZ7Nz1HQfcZwtIel/oVGSHf7zBzknZC2tt00XI4HFbniioOfkP1qHyYPH5Kbyl
 5+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728377401; x=1728982201;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rIoY14yTlilEKOSAKUmHpAjKRBmho5TCkeMVUypHK20=;
 b=wzM+Squxdxer2EvK1vbV3HYJNJfOyI+sEr5o8wn0GLAyjxOxuP+BaFy5z17KO7LQC5
 rKyjtngqXCg8ForsSa9U9gyrDijLDW8u1aTsUt2VhzWOYXaM47rOLDjSnZCXzqGe9Esz
 /p8ovRqmpMtbdqj5b+UUBwiLTh4rMNngwrLG7/Z0uBUQT5KddubI6gXRuXPPQICs4tYe
 u+1eza1qvNzO6FkkrCesvrn/HgEn1ek4uJCrgtLdBp4gqxV+DHWxm98cwQaw+6mnmKqj
 eJb5Qpsq3qcBMzprPSIME+BdmReb7atZNlLGLTXIFBjREtavoZbwL/YNlvX47kXRHSLH
 LGDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqnv8NzRxnEZEJCSj2KCDAsBFFI0Wga6Gb5a5qbmW8vll0hnOO6ZPsk9H23HTECOduhD8bWTM=@lists.denx.de
X-Gm-Message-State: AOJu0YxnwObI5EbOvH1eCWsHqp/+v64PnnZ+NqrCDi+/N5KWVHq+/ObE
 DfIpZpbMVtPNAN6PLQSDgx2j/Dte2YNDvcdDo2cg3ZRFhEvqPFqqs19peBmGne8=
X-Google-Smtp-Source: AGHT+IED7yMdDri1VoAiM5BarNbhMSxjcuoDsmr/HF306Znz1ozqtt3KOYwvV4HSgKY3cXsx1/Z+qA==
X-Received: by 2002:a05:651c:19a2:b0:2fa:f5f1:2542 with SMTP id
 38308e7fff4ca-2faf5f12921mr56536701fa.12.1728377401221; 
 Tue, 08 Oct 2024 01:50:01 -0700 (PDT)
Received: from [10.100.0.2] ([194.15.111.159])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c8e05a92c3sm4085337a12.25.2024.10.08.01.50.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 01:50:00 -0700 (PDT)
Message-ID: <57897981-74d1-4fda-bc86-057a4291d455@linaro.org>
Date: Tue, 8 Oct 2024 10:49:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/29] test: boot: fix bootflow_cmd_label for when
 DSA_SANDBOX is disabled
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <2e8206d8bbd7d3140cf2734ca9b3fcd12ced4f14.1727968902.git.jerome.forissier@linaro.org>
 <CAC_iWjLTVV=QpfgGMTSJ205JGRzNDkBuJeO9GwEW4D4PhrJWrw@mail.gmail.com>
 <e9c3ac80-84f0-4900-85fc-b9af4ebc5363@linaro.org>
 <CAC_iWjLS21x3ZOGDnvWWj4y1Hfs_vuw=YnMRZCSAaL42mYYGXg@mail.gmail.com>
 <6d9bfd36-848a-4c9b-b5cb-929752bf3c7a@linaro.org>
 <CAFLszTjGMeLky3xHAAn=52EsyayM7Ungb8ZD5f8gbobQ1zR8Ug@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAFLszTjGMeLky3xHAAn=52EsyayM7Ungb8ZD5f8gbobQ1zR8Ug@mail.gmail.com>
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



On 10/7/24 17:23, Simon Glass wrote:
> Hi Jerome,
> 
> On Fri, 4 Oct 2024 at 06:01, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>>
>>
>> On 10/4/24 11:37, Ilias Apalodimas wrote:
>>> On Fri, 4 Oct 2024 at 11:46, Jerome Forissier
>>> <jerome.forissier@linaro.org> wrote:
>>>>
>>>>
>>>>
>>>> On 10/4/24 08:55, Ilias Apalodimas wrote:
>>>>> Hi Jerome,
>>>>>
>>>>> On Thu, 3 Oct 2024 at 18:23, Jerome Forissier
>>>>> <jerome.forissier@linaro.org> wrote:
>>>>>>
>>>>>> When DSA_SANDBOX is not set, the sandbox tests fail as follows:
>>>>>>
>>>>>>  $ ./test/py/test.py --build-dir=$(pwd) -k bootdev_test_any
>>>>>>  [...]
>>>>>>  Scanning for bootflows with label '9'
>>>>>>  [...]
>>>>>>  Cannot find '9' (err=-19)
>>>>>>
>>>>>> This is due to the device list containing two less entries than
>>>>>> expected. Therefore, look for label '7' when DSA_SANDBOX is disabled.
>>>>>>
>>>>>> The actual use case is NET_LWIP=y (to be introduced in later patches)
>>>>>> which implies DSA_SANDBOX=n for the time being.
>>>>>>
>>>>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>>>> ---
>>>>>>  test/boot/bootflow.c | 7 +++++--
>>>>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
>>>>>> index 6ad63afe90a..c440b8eb778 100644
>>>>>> --- a/test/boot/bootflow.c
>>>>>> +++ b/test/boot/bootflow.c
>>>>>> @@ -109,9 +109,12 @@ static int bootflow_cmd_label(struct unit_test_state *uts)
>>>>>>          * 8   [   ]      OK  mmc       mmc2.bootdev
>>>>>>          * 9   [ + ]      OK  mmc       mmc1.bootdev
>>>>>>          * a   [   ]      OK  mmc       mmc0.bootdev
>>>>>> +        *
>>>>>> +        * However with CONFIG_DSA_SANDBOX=n we have two less (dsa-test@0 and
>>>>>> +        * dsa-test@1).
>>>>>>          */
>>>>>> -       ut_assertok(run_command("bootflow scan -lH 9", 0));
>>>>>> -       ut_assert_nextline("Scanning for bootflows with label '9'");
>>>>>
>>>>> Shouldn't this under and #ifdef, IS_ENABLED etc?
>>>>
>>>> In theory yes, but we can avoid the conditional by using index 7 which is always
>>>> valid, i.e., in all configurations we have at least 7 devices (even 8 actually).
>>>
>>> Ok, but I *think* Simon was trying to match the exact out put here,
>>> not 'at least 7'.
>>>
>>> I think we are better off being strict on this test
>>
>> No because there are 10 entries according to the comment ("a" hex being
>> mmc0.bootdev). Simon, what do you suggest?
> 
> I don't think this is a huge deal.
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

Unfortunately this patch breaks the default config (NET=y and therefore
DSA_SANDBOX=y):

=> ut bootstd bootflow_cmd_label
Test: bootflow_cmd_label: bootflow.c
Scanning for bootflows with label 'mmc1'
Seq  Method       State   Uclass    Part  Name                      Filename
---  -----------  ------  --------  ----  ------------------------  ----------------
Scanning bootdev 'mmc1.bootdev':
  0  extlinux     ready   mmc          1  mmc1.bootdev.part_1       /extlinux/extlinux.conf
No more bootdevs
---  -----------  ------  --------  ----  ------------------------  ----------------
(1 bootflow, 1 valid)
Scanning for bootflows with label '0'
Seq  Method       State   Uclass    Part  Name                      Filename
---  -----------  ------  --------  ----  ------------------------  ----------------
---  -----------  ------  --------  ----  ------------------------  ----------------
(0 bootflows, 0 valid)
Scanning for bootflows with label '7'
Seq  Method       State   Uclass    Part  Name                      Filename
---  -----------  ------  --------  ----  ------------------------  ----------------
---  -----------  ------  --------  ----  ------------------------  ----------------
(0 bootflows, 0 valid)
test/boot/bootflow.c:118, bootflow_cmd_label(): console:
Expected '(1 bootflow, 1 valid)',
     got to '(0 bootflows, 0 valid)'
[...]


So for v12 I'll do what Ilias suggested:

-       ut_assertok(run_command("bootflow scan -lH 9", 0));
-       ut_assert_nextline("Scanning for bootflows with label '9'");
+       if (CONFIG_IS_ENABLED(DSA_SANDBOX)) {
+               ut_assertok(run_command("bootflow scan -lH 9", 0));
+               ut_assert_nextline("Scanning for bootflows with label '9'");
+       } else {
+               ut_assertok(run_command("bootflow scan -lH 7", 0));
+               ut_assert_nextline("Scanning for bootflows with label '7'");
+       }
        ut_assert_skip_to_line("(1 bootflow, 1 valid)");


Tested OK with DSA_SANDBOX=y as well as DSA_SANDBOX=n.

 
> BTW, 'fewer', not 'less', if you can count them

Sure :)


Thanks,
-- 
Jerome
