Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFF0D3B7E2
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 15:52:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2757D8391B;
	Mon,  8 Dec 2025 16:52:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v5HQf6J+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 222C5838FA; Mon,  8 Dec 2025 16:52:44 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E93E883946
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 16:52:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-477b198f4bcso40249495e9.3
 for <u-boot@lists.denx.de>; Mon, 08 Dec 2025 07:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765209160; x=1765813960; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z+U+qUoIjmbWosziEaEwTuVikwASJhY4WJxSwfh7vAA=;
 b=v5HQf6J+aDKTdvhhYYagfp90HUUmvIKoOoikCpsKIAaA1Y+m4QXsKm/kMtLU9hv5ri
 qHsy2ks1XyKUH9VbUlBHLIAXRSK6gCrVOka7TFg9JDu5wpREXvZJNqZAQaMoBgMPQdXC
 9riVVbAYdIdF0xYsEq3UVswSczSrvnBm0qSl4W5pVK3if8Ojyg7KIO7XstMYwlhy6h9I
 PCsoKHvQA5fWTJUpuZsF/Kuwz+DT/8Lz9ANNDp0sJsIa0Y8ivrRgBrzkDtvD5gDd0E+X
 NWuGWvFLq0UXZHcRGB/4BYMEvqzI1cEifkVwN97FDfU0pHA/+VNdTryScry4sj/H0g7q
 t2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765209160; x=1765813960;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z+U+qUoIjmbWosziEaEwTuVikwASJhY4WJxSwfh7vAA=;
 b=G4W0loRcSS4ETloeUyb8X8wKy897IvFcAVJuGHSv/BX15JCzHJc8dgY2HaSCwcAFgP
 AFXQuNHQPM1BX6UTzdA9/jakxZFo17LUb1IEE+5p0ntGT9fkaB2SVzwvUqQsyQxVyW+f
 Nev37aDj9vdcWjRjj8ERLUPYbMrVgRA81bbiUQJSDJVZLyjZdzkD432hHdhRk9S/BZg+
 JPhMzesBLOzRxbk/1aymasfJYvibakiIjoRqyWcpIiOqqTuwxJcwHYVdXtT9qgqR3mgS
 D7EzcjULgvd+D7viJfygGLWWhJjZL2LpUT9QOoWA8NvDIkYan79nCCmsMp9bshPDypD/
 YDzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp76p/G4zfqxoOWqzAxbVuk7MApYS2DIoqhRgFKaikGYVQjy6G7CTIIkvF5blLZ2U0XqNSl+k=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3rhAcnw/fEMglB2IL4P29Zo5bJSHB5eCPrqv+4Do+FmOJeXgm
 rWAlRkOkqGBv1gpLzHY9G7drmJTKWqCtVegn3ElbXSEnnqdX86GpCInyghw/SQDDhaA=
X-Gm-Gg: ASbGncugrKf910dHAPESyRfhiFapwz9HT7cvKgrE6o+soiTWEjFXLT7ARxzXgF7nLSv
 r1zcgSJPiaoqAVwFXTe0tAfJqLdiwtH+dArvu62DlUWkuSWpY5D89E9S3UnLZ/uZODG9e7R/Qt2
 Zccdzb+UQOM2IY3VJuc0L0Tt10CjZ5Sbl7OaMS6b97OdmDHPtxOi3nOYbeHctr7+rWWtO9Ad5aZ
 r7rIAZt22THMJgnRmXbBNVhANZ+vvWuYcJpcaICv2XyXGyHCx5Iyu1cziFBRa0N4IAfERyTuTG2
 m0RvPQdv0tTbHt8U6t5PH2p+t97Qbq3jJ8/WpqR1PWxaD7vieofzPjIhLVxXao+kHb2HLOgHp4/
 QD6C8vr8g15liZB7Pn5uAA6F1gTRksVI7jLQQgwrbz8n1x5s26iRu+Ft6w6qqTgApLKTp2Pm3/Y
 fdHVvQMUMjuRUKM4Z1kUTmFm5mYp6Pyny/w2ZTtFXxxWimBx0FZLElVI9you0MRXVcmw==
X-Google-Smtp-Source: AGHT+IFAREMPLzCeKSlkXrGjy30VsaELjoPE24MaChQRUp2Kt5qcwYoe2Q6ED16o1sGjpoVJKneYrA==
X-Received: by 2002:a05:600c:3491:b0:477:a1a2:d829 with SMTP id
 5b1f17b1804b1-47939e04045mr73324895e9.13.1765209160302; 
 Mon, 08 Dec 2025 07:52:40 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:f7b:b001:fd05:11bc:5c24:a865?
 ([2a0a:ef40:f7b:b001:fd05:11bc:5c24:a865])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4793093ac44sm254781225e9.8.2025.12.08.07.52.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Dec 2025 07:52:39 -0800 (PST)
Message-ID: <fd494719-1152-44c7-9de8-0e9a370c659b@linaro.org>
Date: Mon, 8 Dec 2025 15:52:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] clk: Return value calculated by ERR_PTR
To: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Ye Li <ye.li@nxp.com>, Michael Trimarchi <michael@amarulasolutions.com>
References: <20251121-clk_uclass_fix-v2-0-74f4ea10e194@linaro.org>
 <176503025989.2523567.16347058613411695182.b4-ty@konsulko.com>
 <20251208153226.moktyjv3irmjlg6q@lingo>
 <20251208153852.GP303283@bill-the-cat>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20251208153852.GP303283@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 08/12/2025 15:38, Tom Rini wrote:
> On Mon, Dec 08, 2025 at 09:32:26AM -0600, Nishanth Menon wrote:
>> On 08:10-20251206, Tom Rini wrote:
>>> On Fri, 21 Nov 2025 17:34:30 +0000, Andrew Goodbody wrote:
>>>
>>>> Smatch reported an error where a value calculated by ERR_PTR was not
>>>> used. Fixing this to return the generated value led to a test failure
>>>> which meant updating the sandbox clock code so that it would still cause
>>>> the tests to pass with the above correction.
>>>> Debugging this problem led to a SIGSEGV which is addressed in 1/3.
>>>> Possible memory leaks noticed are addressed in 3/3.
>>>>
>>>> [...]
>>>
>>> Applied to u-boot/next, thanks!
>>>
>>> [1/3] clk: Prevent SIGSEGV on debug
>>>        commit: 1c0a46e2918a1ddf42f51449e45077513dd52417
>>> [2/3] clk: Return value calculated by ERR_PTR
>>>        commit: fe780310cfa8bf5a093894b5cd7fe85c6b02fd91
>>
>> This commit seems to have broken TI platforms in next branch.
>>
>> u-boot$ git bisect log
>> git bisect start
>> # status: waiting for both good and bad commits
>> # bad: [bc1819331ece7aa4e7d0573c9cdacdb8efbdb067] Merge patch series "clk: Return value calculated by ERR_PTR"
>> git bisect bad bc1819331ece7aa4e7d0573c9cdacdb8efbdb067
>> # status: waiting for good commit(s), bad commit known
>> # good: [384d3785df4dbe452f9fbb4bd9c9c9e986cdc205] Merge patch series "led: remove unused legacy LED code"
>> git bisect good 384d3785df4dbe452f9fbb4bd9c9c9e986cdc205
>> # good: [1e8eff6d7a9ad2c605185e5b3d8c22ccd26733dc] board: ti: CAT24C256WI-GT3 require min. 5ms delay (tWR) between write/read
>> git bisect good 1e8eff6d7a9ad2c605185e5b3d8c22ccd26733dc
>> # good: [1165e8efcba0ab3efd1ea4ff956d26746fc386b0] reboot-mode: Correct macro name from U_BOOT_DEVICE to U_BOOT_DRVINFO
>> git bisect good 1165e8efcba0ab3efd1ea4ff956d26746fc386b0
>> # bad: [fe780310cfa8bf5a093894b5cd7fe85c6b02fd91] clk: Return value calculated by ERR_PTR
>> git bisect bad fe780310cfa8bf5a093894b5cd7fe85c6b02fd91
>> # good: [1c0a46e2918a1ddf42f51449e45077513dd52417] clk: Prevent SIGSEGV on debug
>> git bisect good 1c0a46e2918a1ddf42f51449e45077513dd52417
>> # first bad commit: [fe780310cfa8bf5a093894b5cd7fe85c6b02fd91] clk: Return value calculated by ERR_PTR
>>
>> Confirmed by reverting the commit. Looks like
>> 9ed8fafbcde3425d8817ec5953edd428c7508153 revert is needed again?
> 
> Interesting, OK. What Andrew did in commit
> fe780310cfa8bf5a093894b5cd7fe85c6b02fd91 is more complex than before and
> there's two stanzas there. Our lab is current being re-worked again
> right now so I can't test on the K3 platforms I have, but can you please
> see which of the two changes in clk-uclass.c is the one that breaks
> these platforms? Thanks!
What is the breakage please? I did put this series through CI and the 
only issues were due to lack of disk space, so not related to the patches.

Andrew

