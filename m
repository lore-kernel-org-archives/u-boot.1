Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C93EE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 05:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 987EB86BAE;
	Mon, 11 Sep 2023 07:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iHgM0nFf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A21AC86D00; Mon, 11 Sep 2023 07:47:17 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFBA486B9A
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 07:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c0efe0c4acso6720865ad.0
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 22:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694411233; x=1695016033; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G9Q4Bs12U3FqANLPD9t/ZokoMOBIsa0llD1MH4A31bk=;
 b=iHgM0nFf2YGO4mvydF8D6vBJtk9N20BzEP1oQZd0Cd2vimi1qnsTogx7ZgsnMBjfRv
 iru39uKoE2pChBrTxzIxTZU2rgZ48M5P+JKZrfVnTQWAPZ/TW9s4oeOdLKkhuInhwORR
 7CGYysCpQjVzd0ogah5RF0DlCuv8Tx8366j7c550XzioKALzET9rZwK5zsmR0Fpfq7Tf
 u64GYmFLXIZbAcjlEY3eANzDl3fR8S7K3U4WQOB9CDQLgRNYJ6IBHg46IyF6c69cYsP9
 pnFyRgx5nSNww+Mo5OHYp3Mg2iCsdXtOpQVwfJdkSYz5r64XJJQ4iiQZFE6d8nWUh27X
 4mXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694411233; x=1695016033;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G9Q4Bs12U3FqANLPD9t/ZokoMOBIsa0llD1MH4A31bk=;
 b=sYHTyrHjQdWVF4ybA9pOwt+i0oXt5dFgPNTCHZ+Q9ByvAm9Gr3fuCvAs93Yxw8dpw9
 DiKR3ZQhxxYzhEUmpPQOIZGkdrJqWBhIp65LuuBiOMogJybOtqnfCfamiAta/himZJi3
 7Dt5c2ZNMeGqn/hsGyb/Bt4JT+m2uSNPOEDQMUVnjdHxy2SynmRwYJuzmlfcEbJzT+++
 jMJ4B4Dv+47FCPH7B8PzeoxjhtgdMK0zvyKIsSNT/PwyhyiS3U0GiMJ8qfAMJfBdqSt+
 OSEkaXcoaYbHfJ0K8vpOjHc/pYYZebkIXHB7C7d9NSRq0CEKilkYY7KTqSP47FCr68Dx
 6CXA==
X-Gm-Message-State: AOJu0YxzDogUvCyhavbBWKx4jMBcHUZRVzRhJqc3hsG6u1FtiiLT0wMy
 zRNrncpeS0K0r2pE09nXoxJ8Nw==
X-Google-Smtp-Source: AGHT+IEdeta0nfBWEZQZ+frYLrfcnhCAJXZOUW14CCZsFuSxA5rQYj0y18O0Q9CgIbfRgiy2pr0XEA==
X-Received: by 2002:a17:902:d48d:b0:1c2:c60:8388 with SMTP id
 c13-20020a170902d48d00b001c20c608388mr11218812plg.6.1694411232922; 
 Sun, 10 Sep 2023 22:47:12 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:91f5:5d19:aad:686c])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a170902e88200b001b246dcffb7sm5476518plg.300.2023.09.10.22.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 22:47:12 -0700 (PDT)
Date: Mon, 11 Sep 2023 14:47:08 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, etienne.carriere@st.com, michal.simek@amd.com,
 linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com
Subject: Re: [RFC 6/6] test: dm: add SCMI pinctrl test
Message-ID: <ZP6p3PCaUKvZyViH@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 etienne.carriere@st.com, michal.simek@amd.com,
 linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com
References: <20230906024011.17488-1-takahiro.akashi@linaro.org>
 <20230906024011.17488-7-takahiro.akashi@linaro.org>
 <CAPnjgZ0udKC6tfT1P9AcZrkv6wx+i0KgXZWBV+st3RbCMkiPZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0udKC6tfT1P9AcZrkv6wx+i0KgXZWBV+st3RbCMkiPZw@mail.gmail.com>
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

On Sun, Sep 10, 2023 at 01:13:30PM -0600, Simon Glass wrote:
> Hi AKASHI,
> 
> On Tue, 5 Sept 2023 at 20:41, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > In this test, SCMI-based pinmux feature is exercised.
> >
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  test/dm/scmi.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >
> > diff --git a/test/dm/scmi.c b/test/dm/scmi.c
> > index 423b6ef70b29..ca5a2e9c781e 100644
> > --- a/test/dm/scmi.c
> > +++ b/test/dm/scmi.c
> > @@ -21,6 +21,7 @@
> >  #include <scmi_protocols.h>
> >  #include <asm/scmi_test.h>
> >  #include <dm/device-internal.h>
> > +#include <dm/pinctrl.h>
> >  #include <dm/test.h>
> >  #include <linux/kconfig.h>
> >  #include <power/regulator.h>
> > @@ -395,3 +396,64 @@ static int dm_test_scmi_voltage_domains(struct unit_test_state *uts)
> >         return release_sandbox_scmi_test_devices(uts, dev);
> >  }
> >  DM_TEST(dm_test_scmi_voltage_domains, UT_TESTF_SCAN_FDT);
> > +
> > +/*
> > + * This part is derived from test/dm/pinmux.c, So
> > + *
> > + * Copyright (C) 2020 Sean Anderson <seanga2@gmail.com>
> > + */
> > +
> > +static char buf[64];
> > +#define test_muxing(selector, expected) do { \
> > +       ut_assertok(pinctrl_get_pin_muxing(dev, selector, buf, sizeof(buf))); \
> > +       ut_asserteq_str(expected, (char *)&buf); \
> 
> Can you instead make this a function?

Sure, but please note that the whole scheme was borrowed
from test/dm/pinmux.c.

> > +} while (0)
> > +
> > +#define test_name(selector, expected) do { \
> > +       ut_assertok(pinctrl_get_pin_name(dev, selector, buf, sizeof(buf))); \
> > +       ut_asserteq_str(expected, (char *)&buf); \
> > +} while (0)
> > +
> > +static int dm_test_scmi_pinmux(struct unit_test_state *uts)
> > +{
> > +       struct udevice *dev;
> > +
> > +       ut_assertok(uclass_get_device_by_name(UCLASS_PINCTRL, "protocol@19",
> > +                                             &dev));
> > +       ut_assertok(pinctrl_select_state(dev, "default"));
> > +       test_muxing(0, "<unknown>");
> 
> ut_assertok(check_muxing(uts, ...));

Assertion for

> > +       test_muxing(1, "<unknown>");
> > +       test_muxing(2, "I2S.");
> > +       test_muxing(3, "I2S.");
> > +       test_muxing(4, "I2S.");
> > +       test_muxing(5, "GPIO bias-pull-up.");
> > +       test_muxing(6, "GPIO drive-open-drain output-mode output-value.");
> > +       test_muxing(7, "GPIO bias-pull-down input-mode.");
> > +       test_muxing(8, "GPIO bias-disable.");

this chunk of code?
It is not clear to me what is the advantage, though.

-Takahiro Akashi

> > +
> > +       ut_assertok(pinctrl_select_state(dev, "alternate"));
> > +       test_muxing(0, "I2C drive-open-drain.");
> > +       test_muxing(1, "I2C drive-open-drain.");
> > +       test_muxing(2, "SPI.");
> > +       test_muxing(3, "SPI.");
> > +       test_muxing(4, "SPI.");
> > +       test_muxing(5, "CS bias-pull-up.");
> > +       test_muxing(6, "CS drive-open-drain output-mode output-value.");
> > +       test_muxing(7, "GPIO bias-pull-down input-mode.");
> > +       test_muxing(8, "GPIO bias-disable.");
> > +
> > +       ut_assertok(pinctrl_select_state(dev, "0"));
> > +       test_muxing(0, "I2C drive-open-drain.");
> > +       test_muxing(1, "I2C drive-open-drain.");
> > +       test_muxing(2, "I2S.");
> > +       test_muxing(3, "I2S.");
> > +       test_muxing(4, "I2S.");
> > +       test_muxing(5, "GPIO bias-pull-up.");
> > +       test_muxing(6, "GPIO drive-open-drain output-mode output-value.");
> > +       test_muxing(7, "GPIO bias-pull-down input-mode.");
> > +       test_muxing(8, "GPIO bias-disable.");
> > +
> > +       return 0;
> > +}
> > +
> > +DM_TEST(dm_test_scmi_pinmux, UT_TESTF_SCAN_FDT);
> > --
> > 2.34.1
> >
> 
> Regards,
> Simon
