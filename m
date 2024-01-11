Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E2BC47073
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 01:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A617087720;
	Thu, 11 Jan 2024 02:15:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lxOsrKdj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0618878E5; Thu, 11 Jan 2024 02:15:55 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8F38807D9
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 02:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-595b208a050so2919625eaf.0
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 17:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704935751; x=1705540551; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tWxTO3KRyhtzT4STYe519l2UXmvMPJoq8DTtwhW/sN4=;
 b=lxOsrKdjyeWdr8d1hP9Yt4Wy4YCKu+oT8brTXLohYdrX+/QyZLg+YgzDhcxPYc9H8l
 XU/IGvUpU+l0eG7voR/qQkQTtR7NWieNqkxnk18VC0c9CXcZ+P7/gHWgfMoY4bRzyFSk
 aUOjV/brD5VyxbXUJyvaLu/7j3JOXbw89vJpItJ1FE9IF5TjkW2Qm2x3cQY2jXZKBdwy
 Ga4nH1bxgOBMFQjaSqPNILUQsDD5OMQqokp2UbE/uOSqfCTNP2pZRdSYzKq5H0bME85M
 iAJJXDJ5AkQhb7BC8GPAD3E/J/uPRXjmlbfKqn9hz3s/ihcJHHd/wTSqXE2V9Y6JJZyg
 svaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704935751; x=1705540551;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tWxTO3KRyhtzT4STYe519l2UXmvMPJoq8DTtwhW/sN4=;
 b=N/GFT2BdWSSYOs21H204Huk8c6g1ctLz2T19Y/z9qMMmjjrnkaTBOc67MMa8pIyJuQ
 PxMp9RCi9x4e7aafbfXfBTYMneUf1od4lU8mYwYlHdnIRvyKmFmtPPQp7tN1zJDnS81K
 xLcITpMpRj4xBVKdL155JDOXCeyGAMIxg/zbWcQ3QdJ5RN1p8UZHoU/VvCPh4xWuIO06
 UEwlzZK49+KGWMVT0cMQNYsO9wqItK6WQJiDOPQKBpNxQ0I/1731AIN6CyxyWNlvpOqk
 6vRlwHeEL9BYl1VE9qoyRtkoxvkpp99AHSbm215Qdjyo4LGItfNhJw1SQDci+PcaTFg/
 oI9g==
X-Gm-Message-State: AOJu0YzPNyPFAwBtHychvpdbwwQ2QkGVVExB851wqmqJUKpNOj38+I34
 964L4sRe1f1Mg+nvYlJIIfrH4W5A/4H52p1UPQzRNdP0MWqaag==
X-Google-Smtp-Source: AGHT+IGmcWHzHlbT9e2MYYynOOeMm1/lOJI8qxvk2zIuRwkenxhnWvfwMsWtccH08FBfm/qjo1W4vb3TSW/ct9jzuQo=
X-Received: by 2002:a05:6359:7206:b0:173:5cd:6094 with SMTP id
 uu6-20020a056359720600b0017305cd6094mr351531rwb.34.1704935751356; Wed, 10 Jan
 2024 17:15:51 -0800 (PST)
MIME-Version: 1.0
References: <20231213031646.28828-1-semen.protsenko@linaro.org>
 <20231213031646.28828-8-semen.protsenko@linaro.org>
 <CALrBrZ2649a21KXCsxTrvuSkX00te723tnwYmNKRCxw0NXhwjQ@mail.gmail.com>
In-Reply-To: <CALrBrZ2649a21KXCsxTrvuSkX00te723tnwYmNKRCxw0NXhwjQ@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 10 Jan 2024 19:15:39 -0600
Message-ID: <CAPLW+4m=RN864fjbm0KKFKdAsz2guRCGv9ahGf=TjQwytq-13A@mail.gmail.com>
Subject: Re: [PATCH 07/13] clk: exynos: Add Samsung clock framework
To: Minkyu Kang <promsoft@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Lukasz Majewski <lukma@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Dec 27, 2023 at 3:12=E2=80=AFAM Minkyu Kang <promsoft@gmail.com> wr=
ote:
>
> Hi,
>
>
> 2023=EB=85=84 12=EC=9B=94 13=EC=9D=BC (=EC=88=98) 12:27, Sam Protsenko <s=
emen.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>>
>> Heavily based on Linux kernel Samsung clock framework, with some changes
>> to accommodate the differences in U-Boot CCF implementation. It's also
>> quite minimal as compared to the Linux version.
>>
>> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>> ---

[snip]

>> diff --git a/drivers/clk/exynos/clk-pll.h b/drivers/clk/exynos/clk-pll.h
>> new file mode 100644
>> index 000000000000..3b477369aeb8
>> --- /dev/null
>> +++ b/drivers/clk/exynos/clk-pll.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * Copyright (C) 2016 Samsung Electronics
>> + * Copyright (C) 2023 Linaro Ltd.
>> + *
>> + * Authors:
>> + *   Thomas Abraham <thomas.ab@exynos.com>
>> + *   Sam Protsenko <semen.protsenko@linaro.org>
>> + *
>> + * Common Clock Framework support for all PLL's in Samsung platforms.
>> + */
>> +
>> +#ifndef __EXYNOS_CLK_PLL_H
>> +#define __EXYNOS_CLK_PLL_H
>> +
>> +#include <linux/clk-provider.h>
>> +
>> +enum samsung_pll_type {
>> +       pll_0822x,
>> +       pll_0831x,
>
>
> why don't you modify to uppercase?
>

That code was basically copied over from Linux kernel (from
drivers/clk/samsung/clk-pll.h file). I'm trying to keep it as close to
the original as possible, to ease any possible backporting in future.
Although kernel coding style indeed tends to stick to uppercase in
enums, in my opinion the backporting/compatibility concern outweighs
the style one. Hope it's ok with you if I keep it as is in v2?

>>
>> +};
>> +
>> +#endif /* __EXYNOS_CLK_PLL_H */
>> diff --git a/drivers/clk/exynos/clk.c b/drivers/clk/exynos/clk.c
>> new file mode 100644
>> index 000000000000..430767f072d8
>> --- /dev/null
>> +++ b/drivers/clk/exynos/clk.c
>> @@ -0,0 +1,121 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2023 Linaro Ltd.
>> + * Sam Protsenko <semen.protsenko@linaro.org>
>> + *
>> + * This file includes utility functions to register clocks to common
>> + * clock framework for Samsung platforms.
>> + */
>> +
>> +#include <dm.h>
>> +#include "clk.h"
>> +
>> +void samsung_clk_register_mux(void __iomem *base,
>> +                             const struct samsung_mux_clock *clk_list,
>> +                             unsigned int nr_clk)
>> +{
>> +       unsigned int cnt;
>> +
>> +       for (cnt =3D 0; cnt < nr_clk; cnt++) {
>> +               struct clk *clk;
>> +               const struct samsung_mux_clock *m;
>
>
> wouldn't it be better if use a more meaningful name like mux?
>

My reasoning for choosing the name that short in this case was because
of super-short scope (3 lines of code), and OTOH this variable is
massively used during that scope, like this:

        clk =3D clk_register_mux(NULL, m->name, m->parent_names,
                m->num_parents, m->flags, base + m->offset, m->shift,
                m->width, m->mux_flags);

Hope it makes sense. If you still prefer 'mux', please let me know and
I'll use it in v2.

>>
>> +
>> +               m =3D &clk_list[cnt];
>
>
> Is there any possibility that the value is null or wrong (e.g. overflow)
>

I decided to keep it with no error handling because I didn't feel like
it would bring much value. Because this code is supposed to be used
via samsung_cmu_register_one(), and the CMU structure passed to that
function is usually going to be defined in this idiomatic way (as can
be seen in clk-exynos850.c driver):

        static const struct samsung_clk_group top_cmu_clks[] =3D {
                { S_CLK_PLL, top_pure_pll_clks, ARRAY_SIZE(top_pure_pll_clk=
s) },
                { S_CLK_MUX, top_pure_mux_clks, ARRAY_SIZE(top_pure_mux_clk=
s) },
                 ...

and the corresponding clocks structures are also defined like this:

        static const struct samsung_mux_clock top_pure_mux_clks[] =3D {
                MUX(CLK_MOUT_SHARED0_PLL, "mout_shared0_pll",
mout_shared0_pll_p,
                    PLL_CON0_PLL_SHARED0, 4, 1),
                MUX(CLK_MOUT_SHARED1_PLL, "mout_shared1_pll",
mout_shared1_pll_p,
                    PLL_CON0_PLL_SHARED1, 4, 1),
                ...

I'd say the odds for messing this up are next to none, because of
using ARRAY_SIZE() and clock macros like MUX(). Especially because the
example is already set in clk-exynos850 driver and I assume everybody
would just use it as a template, which usually happens. So after
exploring the alternative approach (with added error handling) I felt
it was unjustifiable cluttered comparing to the more concise version
present in this series, at least in this particular code. Also, that
code resembles its kernel counterpart, where the clock pointer isn't
checked as well.

I'm not even sure how to handle possible errors here, as it's the
critical platform code. So maybe letting it just crash is not a bad
decision too. But if you have a strong opinion on this one, please let
me know how you would like me to handle that.

>> +               clk =3D clk_register_mux(NULL, m->name, m->parent_names,
>> +                       m->num_parents, m->flags, base + m->offset, m->s=
hift,
>> +                       m->width, m->mux_flags);
>> +               clk_dm(m->id, clk);
>> +       }
>>> +}

[snip]
