Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81204CD4850
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 18:29:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99EB986B70;
	Fri, 22 Sep 2023 20:29:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NnlKfOPq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92BF486B53; Fri, 22 Sep 2023 20:29:06 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC27286B40
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 20:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d86574d9bcaso214306276.2
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695407341; x=1696012141; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=51Tn8YIKEM8K7KY3B+ZHrFUAwUJ/h6XDFl7EssZzOkM=;
 b=NnlKfOPqa94ivCDq08LssErFWDER1833g58m2uiRKo/N9Eb3NofwFyVtvw4AoecCUX
 VyaxlZmzGFMkJtZiwzx2Kifs8ccWaqg6I8AuIxZ6coiFMRX4ViqhYoxdH4aG4gfpPfnn
 feYKId+o6sc1Ot9ZLc0HF5WU6P/lC26mub5t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695407341; x=1696012141;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=51Tn8YIKEM8K7KY3B+ZHrFUAwUJ/h6XDFl7EssZzOkM=;
 b=hfnt23dGEJtKtYFPoMiLog49sCgtTdZYlwHeJaK/aMZWYNuMVVyVkv0rd2220p15f/
 pGAIZ5Upvz8WxtaECu5djMzYAedjWMXTUNztqdXOq+tnEfYHI8S8uxjKfbdzynU54pL0
 lJttzGWEXVyVQ2v7SPkMCdyYqHFlxVsuO2kwI9ydBuN5XG+Iyugtp9JFzeP6K66loQ95
 SclUCYwqwu2IzHZ0wLttXzn2wf36tRPYm2rmVFL4voAmFm21uONxg4cJcvueGbhTo9y0
 82WW6liLgLBONaufanbRQaq0fTpc2EGfAExuDYVCUt0DdLRMn0SyT7RqHaEGm0EUOrI6
 hSXQ==
X-Gm-Message-State: AOJu0YwZTUOs+OkCQs9Mv28A5QbG3/PZt4qALjoQ7FLlc7NmWZFX47F0
 ts10e2mX2Rq+3oBN5owkvyGST6XSfYNiQEqS1vXoSw==
X-Google-Smtp-Source: AGHT+IESi8X9B1gIoacXTeOnMxTVGhZJf18dfIZmUwE14m3zfeYZBaBuxkxIZ4kM10T43W6Ad0V6+HT1QqTeC/mfTkg=
X-Received: by 2002:a25:903:0:b0:bc9:92c9:7fd1 with SMTP id
 3-20020a250903000000b00bc992c97fd1mr92446ybj.3.1695407341307; Fri, 22 Sep
 2023 11:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230906024011.17488-1-takahiro.akashi@linaro.org>
 <20230906024011.17488-7-takahiro.akashi@linaro.org>
 <CAPnjgZ0udKC6tfT1P9AcZrkv6wx+i0KgXZWBV+st3RbCMkiPZw@mail.gmail.com>
 <ZP6p3PCaUKvZyViH@octopus>
In-Reply-To: <ZP6p3PCaUKvZyViH@octopus>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Sep 2023 12:27:26 -0600
Message-ID: <CAPnjgZ3wOxG6jJeiH975TMa1RTsGSRgkhpYRy=ee61D2BN9j0A@mail.gmail.com>
Subject: Re: [RFC 6/6] test: dm: add SCMI pinctrl test
To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 etienne.carriere@st.com, michal.simek@amd.com, linus.walleij@linaro.org, 
 Oleksii_Moisieiev@epam.com
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

Hi,

On Sun, 10 Sept 2023 at 23:47, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> On Sun, Sep 10, 2023 at 01:13:30PM -0600, Simon Glass wrote:
> > Hi AKASHI,
> >
> > On Tue, 5 Sept 2023 at 20:41, AKASHI Takahiro
> > <takahiro.akashi@linaro.org> wrote:
> > >
> > > In this test, SCMI-based pinmux feature is exercised.
> > >
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > ---
> > >  test/dm/scmi.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 62 insertions(+)
> > >
> > > diff --git a/test/dm/scmi.c b/test/dm/scmi.c
> > > index 423b6ef70b29..ca5a2e9c781e 100644
> > > --- a/test/dm/scmi.c
> > > +++ b/test/dm/scmi.c
> > > @@ -21,6 +21,7 @@
> > >  #include <scmi_protocols.h>
> > >  #include <asm/scmi_test.h>
> > >  #include <dm/device-internal.h>
> > > +#include <dm/pinctrl.h>
> > >  #include <dm/test.h>
> > >  #include <linux/kconfig.h>
> > >  #include <power/regulator.h>
> > > @@ -395,3 +396,64 @@ static int dm_test_scmi_voltage_domains(struct unit_test_state *uts)
> > >         return release_sandbox_scmi_test_devices(uts, dev);
> > >  }
> > >  DM_TEST(dm_test_scmi_voltage_domains, UT_TESTF_SCAN_FDT);
> > > +
> > > +/*
> > > + * This part is derived from test/dm/pinmux.c, So
> > > + *
> > > + * Copyright (C) 2020 Sean Anderson <seanga2@gmail.com>
> > > + */
> > > +
> > > +static char buf[64];
> > > +#define test_muxing(selector, expected) do { \
> > > +       ut_assertok(pinctrl_get_pin_muxing(dev, selector, buf, sizeof(buf))); \
> > > +       ut_asserteq_str(expected, (char *)&buf); \
> >
> > Can you instead make this a function?
>
> Sure, but please note that the whole scheme was borrowed
> from test/dm/pinmux.c.

I'm not sure if it is needed there, either. It is pretty ugly.

>
> > > +} while (0)
> > > +
> > > +#define test_name(selector, expected) do { \
> > > +       ut_assertok(pinctrl_get_pin_name(dev, selector, buf, sizeof(buf))); \
> > > +       ut_asserteq_str(expected, (char *)&buf); \
> > > +} while (0)
> > > +
> > > +static int dm_test_scmi_pinmux(struct unit_test_state *uts)
> > > +{
> > > +       struct udevice *dev;
> > > +
> > > +       ut_assertok(uclass_get_device_by_name(UCLASS_PINCTRL, "protocol@19",
> > > +                                             &dev));
> > > +       ut_assertok(pinctrl_select_state(dev, "default"));
> > > +       test_muxing(0, "<unknown>");
> >
> > ut_assertok(check_muxing(uts, ...));
>
> Assertion for
>
> > > +       test_muxing(1, "<unknown>");
> > > +       test_muxing(2, "I2S.");
> > > +       test_muxing(3, "I2S.");
> > > +       test_muxing(4, "I2S.");
> > > +       test_muxing(5, "GPIO bias-pull-up.");
> > > +       test_muxing(6, "GPIO drive-open-drain output-mode output-value.");
> > > +       test_muxing(7, "GPIO bias-pull-down input-mode.");
> > > +       test_muxing(8, "GPIO bias-disable.");
>
> this chunk of code?
> It is not clear to me what is the advantage, though.

Avoiding macros, which are not needed.

>
> -Takahiro Akashi
>
> > > +
> > > +       ut_assertok(pinctrl_select_state(dev, "alternate"));
> > > +       test_muxing(0, "I2C drive-open-drain.");
> > > +       test_muxing(1, "I2C drive-open-drain.");
> > > +       test_muxing(2, "SPI.");
> > > +       test_muxing(3, "SPI.");
> > > +       test_muxing(4, "SPI.");
> > > +       test_muxing(5, "CS bias-pull-up.");
> > > +       test_muxing(6, "CS drive-open-drain output-mode output-value.");
> > > +       test_muxing(7, "GPIO bias-pull-down input-mode.");
> > > +       test_muxing(8, "GPIO bias-disable.");
> > > +
> > > +       ut_assertok(pinctrl_select_state(dev, "0"));
> > > +       test_muxing(0, "I2C drive-open-drain.");
> > > +       test_muxing(1, "I2C drive-open-drain.");
> > > +       test_muxing(2, "I2S.");
> > > +       test_muxing(3, "I2S.");
> > > +       test_muxing(4, "I2S.");
> > > +       test_muxing(5, "GPIO bias-pull-up.");
> > > +       test_muxing(6, "GPIO drive-open-drain output-mode output-value.");
> > > +       test_muxing(7, "GPIO bias-pull-down input-mode.");
> > > +       test_muxing(8, "GPIO bias-disable.");
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +DM_TEST(dm_test_scmi_pinmux, UT_TESTF_SCAN_FDT);
> > > --
> > > 2.34.1
> > >
> >
> > Regards,
> > Simon

Regards,
Simon
