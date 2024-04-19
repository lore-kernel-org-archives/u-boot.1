Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDD3C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:58:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94E1188788;
	Fri, 19 Apr 2024 14:58:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="cdcPvLE3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ED9E887FB; Fri, 19 Apr 2024 14:58:11 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34FBA87DEA
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2a78c2e253aso1673216a91.3
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 05:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713531488; x=1714136288; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=esImVBLLsAxANA2aeoxrH8h+Tcbb8oQtd7lGWLX8KX8=;
 b=cdcPvLE3r3HK9kf37BXZrUZ9LRk6QmqQm4xGTmkR3T+XZDsnn4F5dFXVJyyRHWTIif
 rljL9A9QPqiLhVo77B8cwnC4oDnUKvrfwnR2XNdJcDA87crEa/PAo2RwnEt6YuZqyiVY
 YZg8/SdgSbLTiOsCKcACPwV8Xka6BrPnKn54Y/f0GBuKVx23fNBzble5N6QIL/Q9ArYs
 WjNYN7nAt+VUcV8RxlS91Bpj8mXWC5JqgEHp1zmP6aQnfItDPhyaEVSes98Rcnu0TX9u
 LX9p+Rtk+fjjimN8DIWH/WDgf4cnacaQucYn4/DOcNYwcuYyX34A9PrVyOgr+GV6KJcn
 QeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713531488; x=1714136288;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=esImVBLLsAxANA2aeoxrH8h+Tcbb8oQtd7lGWLX8KX8=;
 b=uHyK0x5rcgTGxpVXoumjKrYAV4GAbyZw7aX9sFTT2mXdvfB2pTeDa/5csJaw2qtgHb
 nRKzs9rx0YS6qGyUG2R6rPrGnWWhTdHiDWzf1AY7qHj0oQl/AIndrQr4kwSjBu8YBZWv
 w5iTibuuGnY4kljiVb2Si1Q0fyrzMjqDgmOg6w2+TVig8adomDdPhuhr7q4XqwfobFl3
 VhiDtYhvMOy7dVz9erRq8aNbna3VLtwxn4DfEILq4cMmAbbVHtW0xuoYka0ceuZ1ib5M
 8SD3soGwA7JiTTtPKKEsncMIsfubNwtkfg74DWY5PozMAUVCUjhzjzXbS0IdBPq09r6G
 Tlhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX9ihcBgwmzgR/T4bh+QVQhsekEIYDs8jLqcCWZ2sKYnTK9WT6BgNzJVYdMd2ODkkm2Xi+WFCfPetPSRIz/Juhhr/Byw==
X-Gm-Message-State: AOJu0YylhJUIbZcEvd0+13Bj1LhJn4lpU8xgSkiegLijMCSMaeHU8xo9
 5NQWfTIGQtjXXgCn8pjgcR0+gwZAWZFUMwK8BR/7E6ipcaz6JT/J9VEZFRN1SaRWMxz44XuAWB2
 0DW8WpRGFDHfC4JDn9FNnyEJQBtMCoOYVLp+cAg==
X-Google-Smtp-Source: AGHT+IHh6jY152K01wRhhwlR70jA2owAQgylzongBVTFVmn1C4aYaueRmlEFouKULZvUvApPpGxgd+zzyG3g96seO0g=
X-Received: by 2002:a17:90a:688d:b0:2a2:9b37:367a with SMTP id
 a13-20020a17090a688d00b002a29b37367amr1970503pjd.39.1713531487515; Fri, 19
 Apr 2024 05:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240418091435.18232-1-robert.marko@sartura.hr>
 <20240418091435.18232-2-robert.marko@sartura.hr>
 <63fec346-81d4-4846-bddb-615887505fc9@linaro.org>
In-Reply-To: <63fec346-81d4-4846-bddb-615887505fc9@linaro.org>
From: Robert Marko <robert.marko@sartura.hr>
Date: Fri, 19 Apr 2024 14:57:56 +0200
Message-ID: <CA+HBbNFYxbdX7POZCDYCoeSDgTfRFjshkZcruEt16yePRKwH0g@mail.gmail.com>
Subject: Re: [PATCH 2/3] mach-ipq40xx: import GPIO header from mach-snapgradon
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@linaro.org, 
 u-boot@lists.denx.de, j.beck@linefinity.com
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

On Thu, Apr 18, 2024 at 1:02=E2=80=AFPM Caleb Connolly
<caleb.connolly@linaro.org> wrote:
>
> Hi Robert,
>
> On 18/04/2024 10:14, Robert Marko wrote:
> > Pinctrl driver was refactored and moved, but the required header that
> > it depends on was not included.
>
> Thanks for these patches!
>
> I'm a bit worried about duplicating this header file, we could probably
> move it to the main include directory instead?

Hi Caleb,
That works for me as its a straight copy from mach-snapdragon.

>
> Alternatively, do you think it would be sensible to combine
> mach-snapdragon with mach-ipq40xx ?
>
> I received some patches a while ago from some Qualcomm engineers trying
> to introduce support for newer IPQ SoCs, where they also seem to want to
> build U-Boot as 32-bit (something I guess ipq40xx may also do?).

If it's possible, I would prefer to keep mach-ipq40xx separate and
probably convert it
to mach-ipq later since I would also love to see some newer SoC-s as well.
While Snapdragon and IPQ40xx are similar currently they will diverge for su=
re.

I dont understand why Qualcomm still insists on building the stock
U-Boot in ARMv7 32-bit
compatibility mode for all of the Cortex-A53 based IPQ807x/60xx/50xx and so=
 on.

Regards,
Robert

>
> I'm easy either way, just want to get a better understanding of this.
>
> Kind regards,
> >
> > Fixes: 24d2908e987a ("pinctrl: qcom: move ipq4019 driver from mach-ipq4=
0xx")
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >  arch/arm/mach-ipq40xx/include/mach/gpio.h | 37 +++++++++++++++++++----
> >  1 file changed, 31 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/mach-ipq40xx/include/mach/gpio.h b/arch/arm/mach-=
ipq40xx/include/mach/gpio.h
> > index a45747c0fe..53c6ae0649 100644
> > --- a/arch/arm/mach-ipq40xx/include/mach/gpio.h
> > +++ b/arch/arm/mach-ipq40xx/include/mach/gpio.h
> > @@ -1,10 +1,35 @@
> >  /* SPDX-License-Identifier: GPL-2.0+ */
> >  /*
> > - * Empty gpio.h
> > + * Qualcomm common pin control data.
> >   *
> > - * This file must stay as arch/arm/include/asm/gpio.h requires it.
> > - *
> > - * Copyright (c) 2019 Sartura Ltd.
> > - *
> > - * Author: Robert Marko <robert.marko@sartura.hr>
> > + * Copyright (C) 2023 Linaro Ltd.
> >   */
> > +#ifndef _QCOM_GPIO_H_
> > +#define _QCOM_GPIO_H_
> > +
> > +#include <asm/types.h>
> > +#include <stdbool.h>
> > +
> > +struct msm_pin_data {
> > +     int pin_count;
> > +     const unsigned int *pin_offsets;
> > +     /* Index of first special pin, these are ignored for now */
> > +     unsigned int special_pins_start;
> > +};
> > +
> > +static inline u32 qcom_pin_offset(const unsigned int *offs, unsigned i=
nt selector)
> > +{
> > +     u32 out =3D (selector * 0x1000);
> > +
> > +     if (offs)
> > +             return out + offs[selector];
> > +
> > +     return out;
> > +}
> > +
> > +static inline bool qcom_is_special_pin(const struct msm_pin_data *pind=
ata, unsigned int pin)
> > +{
> > +     return pindata->special_pins_start && pin >=3D pindata->special_p=
ins_start;
> > +}
> > +
> > +#endif /* _QCOM_GPIO_H_ */
>
> --
> // Caleb (they/them)



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
