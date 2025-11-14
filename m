Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5E1CE7B05
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 12:44:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7009840CF;
	Fri, 14 Nov 2025 13:44:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="khHE5EVI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BCFE840D4; Fri, 14 Nov 2025 13:44:28 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0337E8382A
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 13:44:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-343ff854297so852974a91.1
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 04:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763124264; x=1763729064; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+0VGfZZh0MotiDLWhWoSUlRMMPFQ36uXP1dX1YvGQVc=;
 b=khHE5EVI0KSb8Irj8230vkd9/C2/OPxeuZOOk6OPPL9XSvnhT7WA3/3XD898s+HvZs
 8AeDih3Pua5AnifNios8ScjpophDVoj3y71R5c8jT+NNewU5t8b7kM35Oi1CKoaxmf62
 +RXEFekQOf3QuM/Tr8uUE4BnwPyG+fXM8xpGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763124264; x=1763729064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+0VGfZZh0MotiDLWhWoSUlRMMPFQ36uXP1dX1YvGQVc=;
 b=cNnfGFgjZ+IQkjkxvHt605L49OFKiqQdZ/0R9pRnXyKPv1tjzkk8A3Yi0DB6yt2s+Q
 u8Gzu9ZaOrDnxH3mmBrpNob7bNeOpN36dcNOw/+xwK7nk+/Z3eYWtlRo2lMSpHbiiw/D
 mx3Dw1g+SCu9wx50oKnEhJGHANlFmAKSzl9GdRudTXCxA9VpL0yFyB2sXFIFLfzjWxGw
 xFu/f2B7UopnIl1cMRibWL91/shUZl4tSRqInago2os+NwjL0I2U4pJDtlpaKNgOynAO
 jy98tBlM+6bNug1wdR3PCG76K7iwixddCzPMyjALkyXeSVECtEx/VvrQPJa8Xe0r55je
 HzHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpxQmWlFLbhKwQaJN0BH6N4zyYv9kgW6/2vBYv2+1n/C+CX3m4xkQHFuzcDgJY1OAxfCXUAjA=@lists.denx.de
X-Gm-Message-State: AOJu0Yxjf3DaV04DMx2x0YoGmrgbn73SMzolKi+B59iKTU4pqbQn8iY1
 b2juCbSetqcg9BcTGVzgTb9JSBD5ZEdWCZETdPBqiAQJJy6DBjwyiQDv1+lQMLZgfdIJdeAkYSY
 xOEPhPh8v7kuDglmjV4rJzj1wIsmxznwfIY+5N5wS
X-Gm-Gg: ASbGncsX4d3Q4EnVzYeIk5GAkjOi/onuaXCdK2X3SFl0+WopZHqnwpLIOAmcmykwAOl
 Kmst7w30pMuRa9lDL+wNs9G9dlP0TkOBipkoWqcCJosY+wAr79dWrqXDWalbpkZdF/hifvURSDB
 GbGV0g+83Q5PTxeyUGxX5cDKfT4jR1iy/Bvlwl3/hZhmtcDNcIF79+YO1S0LF4g/DGfrx9W+hbb
 uU9uBlyMXaS8oFZJ0UobJuohsrHsrpCEtnbHZtGe3SejhqwJEYI/aXLKwKbkbv5meYqgM1bDVQK
 ypBFecHZ+RN5fZg=
X-Google-Smtp-Source: AGHT+IH4Mjfea+MghP4YAaWJvJ9Z9geKiBT8LmRZd4cMmIK2CHDS9mFyAbdsfwrk2ta6Gh4KrjYAYJ2eruz5w26556E=
X-Received: by 2002:a17:90b:224e:b0:340:2a59:45c6 with SMTP id
 98e67ed59e1d1-343f9e9492amr3488609a91.4.1763124264445; Fri, 14 Nov 2025
 04:44:24 -0800 (PST)
MIME-Version: 1.0
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
 <20251109101010.306268-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251109101010.306268-4-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Nov 2025 05:44:04 -0700
X-Gm-Features: AWmQ_bmAAOeP1rbAZCG53BNyH3JHE2wuvlwe1GzqAVOmYyYT5bd8wEvMfpu4UY8
Message-ID: <CAFLszTh5TVjtyq3BiALxT1qUPwyEkgd0OE6jY4ikD+ty0G70tQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] test: cmd/bdinfo: make no flash assumption
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Harrison Mutai <harrison.mutai@arm.com>, Peng Fan <peng.fan@nxp.com>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Rick Chen <rick@andestech.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On Sun, 9 Nov 2025 at 03:10, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The location and size of flash is device-dependent. Do not make any
> assumption about the location and size.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/cmd/bdinfo.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
> index 09f44ee41ed..214b237152b 100644
> --- a/test/cmd/bdinfo.c
> +++ b/test/cmd/bdinfo.c
> @@ -161,9 +161,9 @@ static int bdinfo_test_all(struct unit_test_state *uts)
>         ut_assertok(bdinfo_check_mem(uts));
>
>         /* CONFIG_SYS_HAS_SRAM testing not supported */
> -       ut_assertok(test_num_l(uts, "flashstart", 0));
> -       ut_assertok(test_num_l(uts, "flashsize", 0));
> -       ut_assertok(test_num_l(uts, "flashoffset", 0));
> +       ut_check_console_linen(uts, "flashstart");
> +       ut_check_console_linen(uts, "flashsize");
> +       ut_check_console_linen(uts, "flashoffset");
>         ut_assert_nextline("baudrate    = %lu bps",
>                            env_get_ulong("baudrate", 10, 1234));
>         ut_assertok(test_num_l(uts, "relocaddr", gd->relocaddr));
> --
> 2.51.0
>

Shouldn't we check the actual value, then?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
