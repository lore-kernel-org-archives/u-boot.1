Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7129C71153
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 19:16:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E06386D35;
	Sun, 10 Sep 2023 21:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A29dRkUH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D1B686CF6; Sun, 10 Sep 2023 21:14:56 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7366986D09
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 21:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-d7b89ae27d3so3240263276.3
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694373287; x=1694978087; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zkeuwnAjaki34eKh8WEWABPbJVSO9jgDWrc66R1N7Co=;
 b=A29dRkUHGIqOFbeN1TTKnm9oU6VVmfC+ourzxKxZZKFTg13jXPMZ9xZFHJ2K2ndmzO
 86zMyRhxbeapg6VCNUWCWFXzlWzugt+SB5P25ENEmZgxxv7vBXrVOKtfkWC4w/u/0IYL
 oc7A9n7+J8ZyshQx/SuaGdAig1YgxRIAaORFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694373287; x=1694978087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zkeuwnAjaki34eKh8WEWABPbJVSO9jgDWrc66R1N7Co=;
 b=bWjuyUr4FVLlrPFrpYiz4x9y2Py8iz8T9nqnZezmr2L36zSkZcv9gcFZVN7CxOq9dC
 GSY3nvLI2gYoafIT6RFhj/0Wj4/m7POB6dzm71fc7UpW0SGuOE+Dpwq4hyapfCPT8eY6
 SqTzPi8Y3yu0jPNsjO9wTHAqaWWhvmRVwvY16EJvlGJ92hiCR79adbDlJ0364QjEjuyV
 1tKDvGIZMnpAGgYoqXkZr2HDFLvvxc5kKnenk5rSpEUGTEaBKmbB+LEM7vtv/K5/9z0w
 yowWnfpydTorRpKdMZM4aJq0iqRFze6TCLoSGtXWNZa6bIqsV04hdNjGnig7FYD1fUOp
 D/Aw==
X-Gm-Message-State: AOJu0YyOkNNYVomknP13dgzdaD43yymAU7r83QND9mTmKoKItEqShRfo
 EVyK8fQ8D8BWkqtqAkvqzgPmT7tZ0IS0l7GZsaZI9Q==
X-Google-Smtp-Source: AGHT+IGAgj8lkbe4MPf/fdu5hYxjhlvwyoU1vISES/mtcAeKSF3/4LcU0YLiY4+S2BLHmZ0e46NTlUBHCxWx0pJ08yM=
X-Received: by 2002:a5b:949:0:b0:d77:94d6:aa6f with SMTP id
 x9-20020a5b0949000000b00d7794d6aa6fmr7059339ybq.15.1694373286993; Sun, 10 Sep
 2023 12:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230906024011.17488-1-takahiro.akashi@linaro.org>
 <20230906024011.17488-7-takahiro.akashi@linaro.org>
In-Reply-To: <20230906024011.17488-7-takahiro.akashi@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 10 Sep 2023 13:13:30 -0600
Message-ID: <CAPnjgZ0udKC6tfT1P9AcZrkv6wx+i0KgXZWBV+st3RbCMkiPZw@mail.gmail.com>
Subject: Re: [RFC 6/6] test: dm: add SCMI pinctrl test
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: u-boot@lists.denx.de, etienne.carriere@st.com, michal.simek@amd.com, 
 linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com
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

Hi AKASHI,

On Tue, 5 Sept 2023 at 20:41, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> In this test, SCMI-based pinmux feature is exercised.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  test/dm/scmi.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/test/dm/scmi.c b/test/dm/scmi.c
> index 423b6ef70b29..ca5a2e9c781e 100644
> --- a/test/dm/scmi.c
> +++ b/test/dm/scmi.c
> @@ -21,6 +21,7 @@
>  #include <scmi_protocols.h>
>  #include <asm/scmi_test.h>
>  #include <dm/device-internal.h>
> +#include <dm/pinctrl.h>
>  #include <dm/test.h>
>  #include <linux/kconfig.h>
>  #include <power/regulator.h>
> @@ -395,3 +396,64 @@ static int dm_test_scmi_voltage_domains(struct unit_test_state *uts)
>         return release_sandbox_scmi_test_devices(uts, dev);
>  }
>  DM_TEST(dm_test_scmi_voltage_domains, UT_TESTF_SCAN_FDT);
> +
> +/*
> + * This part is derived from test/dm/pinmux.c, So
> + *
> + * Copyright (C) 2020 Sean Anderson <seanga2@gmail.com>
> + */
> +
> +static char buf[64];
> +#define test_muxing(selector, expected) do { \
> +       ut_assertok(pinctrl_get_pin_muxing(dev, selector, buf, sizeof(buf))); \
> +       ut_asserteq_str(expected, (char *)&buf); \

Can you instead make this a function?

> +} while (0)
> +
> +#define test_name(selector, expected) do { \
> +       ut_assertok(pinctrl_get_pin_name(dev, selector, buf, sizeof(buf))); \
> +       ut_asserteq_str(expected, (char *)&buf); \
> +} while (0)
> +
> +static int dm_test_scmi_pinmux(struct unit_test_state *uts)
> +{
> +       struct udevice *dev;
> +
> +       ut_assertok(uclass_get_device_by_name(UCLASS_PINCTRL, "protocol@19",
> +                                             &dev));
> +       ut_assertok(pinctrl_select_state(dev, "default"));
> +       test_muxing(0, "<unknown>");

ut_assertok(check_muxing(uts, ...));

> +       test_muxing(1, "<unknown>");
> +       test_muxing(2, "I2S.");
> +       test_muxing(3, "I2S.");
> +       test_muxing(4, "I2S.");
> +       test_muxing(5, "GPIO bias-pull-up.");
> +       test_muxing(6, "GPIO drive-open-drain output-mode output-value.");
> +       test_muxing(7, "GPIO bias-pull-down input-mode.");
> +       test_muxing(8, "GPIO bias-disable.");
> +
> +       ut_assertok(pinctrl_select_state(dev, "alternate"));
> +       test_muxing(0, "I2C drive-open-drain.");
> +       test_muxing(1, "I2C drive-open-drain.");
> +       test_muxing(2, "SPI.");
> +       test_muxing(3, "SPI.");
> +       test_muxing(4, "SPI.");
> +       test_muxing(5, "CS bias-pull-up.");
> +       test_muxing(6, "CS drive-open-drain output-mode output-value.");
> +       test_muxing(7, "GPIO bias-pull-down input-mode.");
> +       test_muxing(8, "GPIO bias-disable.");
> +
> +       ut_assertok(pinctrl_select_state(dev, "0"));
> +       test_muxing(0, "I2C drive-open-drain.");
> +       test_muxing(1, "I2C drive-open-drain.");
> +       test_muxing(2, "I2S.");
> +       test_muxing(3, "I2S.");
> +       test_muxing(4, "I2S.");
> +       test_muxing(5, "GPIO bias-pull-up.");
> +       test_muxing(6, "GPIO drive-open-drain output-mode output-value.");
> +       test_muxing(7, "GPIO bias-pull-down input-mode.");
> +       test_muxing(8, "GPIO bias-disable.");
> +
> +       return 0;
> +}
> +
> +DM_TEST(dm_test_scmi_pinmux, UT_TESTF_SCAN_FDT);
> --
> 2.34.1
>

Regards,
Simon
