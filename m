Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570E4CFA76F
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 12:02:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FA4688B63;
	Fri,  4 Oct 2024 14:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TYMofpr9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A06388B86; Fri,  4 Oct 2024 14:01:58 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F8C788965
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 14:01:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cb1e623d1so20203125e9.0
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 05:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728043315; x=1728648115; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cRg7jjM2E5jytvD98QdgNk4TkKSDLyzn//VDsqRzWAg=;
 b=TYMofpr9slSHAahcxcO/puJVW3UPVzJAT1MtoyMeDfxAR/KM/vuFSzI1YnEOhIibM5
 fib0qKbxy7JY4fWE/6HQS5SXty/hTNTw1Y40FfVNxEu3EFc5kMIcf9fkDiTdUFCuUxIa
 hNP8HtmxtwuMpq1WdjMrj2wnzTAIeX4Qc9SJuLyiLyzDchoosMsmylNtYI0U37o8g6rk
 rCxBDiVjJ/jLzbnhx0zG1TnpJyXBqQb0q0sVQknkVJvdRgRynaevUmQPzhUz3JTqw3Ms
 AYgUrkUDTKTwAQHqIypx1ycr9LyNL3zTZr6OAIMOPlRRMkHn9FiEPBdQGG4dGBS/vPJb
 91+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728043315; x=1728648115;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cRg7jjM2E5jytvD98QdgNk4TkKSDLyzn//VDsqRzWAg=;
 b=f5GZncCeQ/IKZoV15kv/6KGp/QQMHi4Q6M4JJCEc7Mbreh/LsPlXdd2mZqfFpsWWFG
 OiMF8RmvZBxDiHtsTh5wZVr+ddWlKtWQsrIezXrTWzSuw7S+VczP1OW8j3PNEnsPhydw
 aCOmNWX8mbcCU4jYFXaK3XCK2y3hHPCvvhahdkZH+XCLsYmAFtU7xGnJD9HMTl4LN1wP
 FAyEp4pstV+zZCZGQTyNo4DkCvUkHZz+9l/dtqQD+HrA9Nx5wXRePdaaZ2sRRRxXQh9e
 SaqizcHvvIrehwgoICwFYVZENVO4eapwmT5z8DpIgi2ELfabYQJh62kBkrTOySmYPfwS
 wt+w==
X-Gm-Message-State: AOJu0Yz6JIZnrdbZ89CUEIhSA4yn7rmytmnAYfY8rQGTWaLqkoonC7If
 rIpgQ/VOoCANJAzD/RIz/vZQRkjnKnmg7nd+vxy8xuC5TqGYWjFyIjKGcx2d+6Q=
X-Google-Smtp-Source: AGHT+IEIPFX5pbVneBUdR2xrO01KMdwnwQrFt6F3fGr1449Z0x5OfiZXXt6V4ngNG6S5K1HTwyo0tQ==
X-Received: by 2002:adf:ebcb:0:b0:37c:d179:2f72 with SMTP id
 ffacd0b85a97d-37d0e6f2853mr1504415f8f.3.1728043315239; 
 Fri, 04 Oct 2024 05:01:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:c79f:f6d3:6b70:dbe?
 ([2a01:e0a:3cb:7bb0:c79f:f6d3:6b70:dbe])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d0822b970sm3123497f8f.43.2024.10.04.05.01.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 05:01:54 -0700 (PDT)
Message-ID: <6d9bfd36-848a-4c9b-b5cb-929752bf3c7a@linaro.org>
Date: Fri, 4 Oct 2024 14:01:53 +0200
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
 <e9c3ac80-84f0-4900-85fc-b9af4ebc5363@linaro.org>
 <CAC_iWjLS21x3ZOGDnvWWj4y1Hfs_vuw=YnMRZCSAaL42mYYGXg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjLS21x3ZOGDnvWWj4y1Hfs_vuw=YnMRZCSAaL42mYYGXg@mail.gmail.com>
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



On 10/4/24 11:37, Ilias Apalodimas wrote:
> On Fri, 4 Oct 2024 at 11:46, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>>
>>
>> On 10/4/24 08:55, Ilias Apalodimas wrote:
>>> Hi Jerome,
>>>
>>> On Thu, 3 Oct 2024 at 18:23, Jerome Forissier
>>> <jerome.forissier@linaro.org> wrote:
>>>>
>>>> When DSA_SANDBOX is not set, the sandbox tests fail as follows:
>>>>
>>>>  $ ./test/py/test.py --build-dir=$(pwd) -k bootdev_test_any
>>>>  [...]
>>>>  Scanning for bootflows with label '9'
>>>>  [...]
>>>>  Cannot find '9' (err=-19)
>>>>
>>>> This is due to the device list containing two less entries than
>>>> expected. Therefore, look for label '7' when DSA_SANDBOX is disabled.
>>>>
>>>> The actual use case is NET_LWIP=y (to be introduced in later patches)
>>>> which implies DSA_SANDBOX=n for the time being.
>>>>
>>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>> ---
>>>>  test/boot/bootflow.c | 7 +++++--
>>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
>>>> index 6ad63afe90a..c440b8eb778 100644
>>>> --- a/test/boot/bootflow.c
>>>> +++ b/test/boot/bootflow.c
>>>> @@ -109,9 +109,12 @@ static int bootflow_cmd_label(struct unit_test_state *uts)
>>>>          * 8   [   ]      OK  mmc       mmc2.bootdev
>>>>          * 9   [ + ]      OK  mmc       mmc1.bootdev
>>>>          * a   [   ]      OK  mmc       mmc0.bootdev
>>>> +        *
>>>> +        * However with CONFIG_DSA_SANDBOX=n we have two less (dsa-test@0 and
>>>> +        * dsa-test@1).
>>>>          */
>>>> -       ut_assertok(run_command("bootflow scan -lH 9", 0));
>>>> -       ut_assert_nextline("Scanning for bootflows with label '9'");
>>>
>>> Shouldn't this under and #ifdef, IS_ENABLED etc?
>>
>> In theory yes, but we can avoid the conditional by using index 7 which is always
>> valid, i.e., in all configurations we have at least 7 devices (even 8 actually).
> 
> Ok, but I *think* Simon was trying to match the exact out put here,
> not 'at least 7'.
> 
> I think we are better off being strict on this test

No because there are 10 entries according to the comment ("a" hex being
mmc0.bootdev). Simon, what do you suggest?

Thanks,
-- 
Jerome

> 
> Thanks
> /Ilias
>>
>>>
>>>> +       ut_assertok(run_command("bootflow scan -lH 7", 0));
>>>> +       ut_assert_nextline("Scanning for bootflows with label '7'");
>>>>         ut_assert_skip_to_line("(1 bootflow, 1 valid)");
>>>>
>>>>         ut_assertok(run_command("bootflow scan -lH 0", 0));
>>>> --
>>>> 2.40.1
>>>>
