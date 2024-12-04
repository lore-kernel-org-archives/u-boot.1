Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A75E77170
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 16:32:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C88E896E3;
	Wed,  4 Dec 2024 17:32:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mhQxctMM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB58E8930D; Wed,  4 Dec 2024 11:56:17 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE00789349
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 11:56:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ffc86948dcso67653051fa.2
 for <u-boot@lists.denx.de>; Wed, 04 Dec 2024 02:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733309775; x=1733914575; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5girLjutQKociw9dXSZzOyhdrXN7qyJj0t20VkIKPxs=;
 b=mhQxctMMTW3CJv16qNRdaeDYKbrLGH2SZIhZfup9NSnYSp0eLh6swDaH7C4OZlTjok
 1VKTRDD/R/+JN360XIdr65ZPqJ3qeqGur851AP4QhHKOeElhGLtbyCAvq3BoFlGxHZ2t
 Q8ux4DsXaFcBIHOT476OqbKEWOh5uIGhKXXRgluuKboyIc5jMlCZOEyHjZXaME/4ilxj
 jaKFk/cFAQIG1VxpRL+P0Ud8q4wjF1+S210XxQToILjfRlv7aH+CBOHll1ekns9fipxG
 k0/4xsFnP5mHaOmLB59ynvI/tZxkBBlpNHJp9moTQlCaWc/fMl6xVaYRL8uOReB8tQpK
 z1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733309775; x=1733914575;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5girLjutQKociw9dXSZzOyhdrXN7qyJj0t20VkIKPxs=;
 b=ZPAo14TJo5inLobolw5Xl44AcPYJPmFqAhapd+4V+78sahYghvXIcLXV1Kv9JYZO52
 ++t67wxP/QgmHRLLwc3byIYZWiFPolK2zNfjWg6V2Cufl389pElen6ORKlZG0K2shoU6
 i1sxj+pb1wdl/nteBK0ie3sjRRYWMLfUrqDj1wV3FuP8UjafQEUBrXKb1i2QqSTAyj0c
 kbS5fdmv1yjv5QnLSJuzshlWvRchdXowNJJeXKkeK5lPW0ohigHxPgqIFFCPND3KUvJA
 1UosFDzn9MHMQynzCwFke30oEH6tvoLopuh/YaqlUbTdAhldZeShHnSAb6AeCCljaQrH
 sGvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzhB4256pac+pZ/nNIDlD6hg3s8qgpFGGLgLOTu5yT7hSr4SB86yVIGRYXvxL7tIXz1Nmz07I=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4HO2BGwzzaw/OrOoop7dw0iCYZpOhtgi9Y92vP0BCaitPGArZ
 1jsib8pMORM0WFM3HwqdIGq46hMzlaHt2m/zDjwM6iAGDlAlYxfa/LOoNR3qcl4GPwZtvo2NaNU
 mEXkt8o2F9ZysP/R1eON1Wxncbrs=
X-Gm-Gg: ASbGncvzBsCyUZP+IOfaoU5zFgM7ZfDD6sBsqGHfWtT9tbWbfb1zoDhCIebkBx7L1WL
 EBBm+uklETucVbCFOOHDNPRx6HutLFwqY5Jor30xRo33CCd8Ust7FCCZYKnkEgXeUqw==
X-Google-Smtp-Source: AGHT+IFmlD2K+ypPgYO8FkNGSCxFCtZ5pQjzcZ32tb6rk2vYsiiO4Z/d+H0EyN31AuRP9p+laSozOWfaYUUk9vigxxQ=
X-Received: by 2002:a2e:a54d:0:b0:2ff:b6df:ce0a with SMTP id
 38308e7fff4ca-30009c9c884mr45240691fa.28.1733309774589; Wed, 04 Dec 2024
 02:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20241203030430.26089-1-hal.feng@starfivetech.com>
 <20241203030430.26089-6-hal.feng@starfivetech.com>
 <CANV2PTOxKz33x4vNioD0rqkTCGTKhdbNHo6eJFrCxn5yq6SX0Q@mail.gmail.com>
 <ZQ2PR01MB13072E932737DD9D65E3A250E637A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
In-Reply-To: <ZQ2PR01MB13072E932737DD9D65E3A250E637A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
From: E Shattow <lucent@gmail.com>
Date: Wed, 4 Dec 2024 02:56:03 -0800
Message-ID: <CANV2PTOCZ9OmAf4LJeGTazJjP6weghhhkmGtJAyFOSukAGdPPA@mail.gmail.com>
Subject: Re: [PATCH v7 05/12] riscv: dts: jh7110: Move common code to the new
 jh7110-common-u-boot.dtsi
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>, 
 Bo Gan <ganboing@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Minda Chen <minda.chen@starfivetech.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 04 Dec 2024 17:31:58 +0100
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

On Tue, Dec 3, 2024 at 10:52=E2=80=AFPM Hal Feng <hal.feng@starfivetech.com=
> wrote:
>
> > On 04.12.24 03:16, E Shattow wrote:
> > On Mon, Dec 2, 2024 at 7:06=E2=80=AFPM Hal Feng <hal.feng@starfivetech.=
com>
> > wrote:
> > >
> > > To support JH7110 based boards besides v1.3B, add a common dtsi and
> > > add common code to it.
> > >
> > > Tested-by: Anand Moon <linux.amoon@gmail.com>
> > > Tested-by: E Shattow <lucent@gmail.com>
> > > Reviewed-by: E Shattow <lucent@gmail.com>
> > > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > > ---
> > >  arch/riscv/dts/jh7110-common-u-boot.dtsi      | 142
> > ++++++++++++++++++
> > >  ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi | 138 +---------------=
-
> > >  2 files changed, 143 insertions(+), 137 deletions(-)  create mode
> > > 100644 arch/riscv/dts/jh7110-common-u-boot.dtsi
> > >
> > > diff --git a/arch/riscv/dts/jh7110-common-u-boot.dtsi
> > > b/arch/riscv/dts/jh7110-common-u-boot.dtsi
> > > new file mode 100644
> > > index 0000000000..7953459e67
> > > --- /dev/null
> > > +++ b/arch/riscv/dts/jh7110-common-u-boot.dtsi
> > > @@ -0,0 +1,142 @@
> > > +// SPDX-License-Identifier: GPL-2.0 OR MIT
> > > +/*
> > > + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> > > + */
> > > +
> > > +#include "binman.dtsi"
> > > +#include "jh7110-u-boot.dtsi"
> > > +/ {
> > > +       aliases {
> > > +               spi0 =3D &qspi;
> > > +       };
> > > +
> > > +       chosen {
> > > +               bootph-pre-ram;
> > > +       };
> > > +
> > > +       firmware {
> > > +               spi0 =3D &qspi;
> > > +               bootph-pre-ram;
> > > +       };
> > > +
> > > +       config {
> > > +               bootph-pre-ram;
> > > +               u-boot,spl-payload-offset =3D <0x100000>;
> > > +       };
> > > +
> > > +       memory@40000000 {
> > > +               bootph-pre-ram;
> > > +       };
> > > +};
> > > +
> > > +&uart0 {
> > > +       bootph-pre-ram;
> > > +       reg-offset =3D <0>;
> > > +       current-speed =3D <115200>;
> > > +       clock-frequency =3D <24000000>;
> > > +};
> > > +
> > > +&mmc0 {
> > > +       bootph-pre-ram;
> > > +};
> > > +
> > > +&mmc1 {
> > > +       bootph-pre-ram;
> > > +};
> > > +
> > > +&qspi {
> > > +       bootph-pre-ram;
> >
> > > +       spi-max-frequency =3D <250000000>;
> >
> > Drop this line spi-max-frequency 250Mhz. The driver expects spi-max-
> > frequency in any sub-node, and not here?
>
> Yes, this property is used in sub-node, we can drop this later.
>
> >
> > > +
> > > +       flash@0 {
> > > +               bootph-pre-ram;
> >
> > > +               /delete-property/ cdns,read-delay;
> >
> > Drop this line /delete-property/ because it is a problem for the parser=
 if we
> > need to re-define 'cdns,read-delay' later in dts files downstream of jh=
7110-
> > common-u-boot.dtsi
> >
> > If you want drivers/spi/cadence_qspi.c:spi_calibration() to do this wor=
k then it
> > needs to be the same upstream. In my testing on 4GB
> > Star64 the calibration (via /delete-property/ cdns,read-delay) method w=
ith
> > spi-max-frequency less than exactly 49.8MHz results in a failure to wri=
te SPI-
> > NOR correctly. When spi-max-frequency is approximately 25MHz up to
> > 49.799999MHz and written with a known good tool then the boot may be
> > successful but "Main section boot fail,use backup section"
> > or other errors on boot after using that unstable configuration of U-Bo=
ot to
> > write U-Boot image to the SPI-NOR. No problems writing and boot during
> > testing with spi-max-frequency 49.8MHz up to 100MHz (not tested above
> > 100MHz).
> >
> > The upstream dts has spi-max-frequency 12MHz which is not successful wi=
th
> > any of the read-delay values I tested: 0 1 2 3 4 5
> >
> > > +               spi-max-frequency =3D <100000000>;
> >
> > Why 12MHz upstream and 100MHz here? Something is wrong but I do not
> > know is it U-Boot or Linux?
> >
> > Success:
> > +             /delete-property/ cdns,read-delay;
> > +             spi-max-frequency =3D <100000000>;
> >
> > Success:
> > +             cdns,read-delay =3D <2>;
> > -             /delete-property/ cdns,read-delay;
> > +             spi-max-frequency =3D <100000000>;
> >
> > Failure:
> > +             cdns,read-delay =3D <2>;
> > +             spi-max-frequency =3D <50000000>;
> >
> > The actual fix is going to need testing Linux and U-Boot on all the boa=
rds I do
> > not have access to.
> >
> > For the moment we can:
> > -             /delete-property/ cdns,read-delay;
> > +             cdns,read-delay =3D <2>;
> > +             spi-max-frequency =3D <100000000>;
> >
> > or do nothing (but yes please drop that 250Mhz line it is non-op I thin=
k).
> >
> > What do you think?  Or else we discuss here and follow with patches in =
future
> > to fix the mess. I really do not want any /delete-property/ to be in dt=
si but I
> > don't know why it is so different between U-Boot and Linux and cannot
> > personally test all the possible boards to verify a change.
>
> I don't know the cause of this problem either. But all properties added i=
n this
> patch already existed in U-Boot DT before. I tried my best to keep the U-=
Boot
> DT the same as the one before OF_UPSTREAM applied.
>
> I tested and found that the qspi flash can work successfully in Linux and=
 U-Boot
> with the settings you suggested above.
>
> cdns,read-delay =3D <2>;
> spi-max-frequency =3D <100000000>;

Good report on testing Linux and U-Boot, thank you Hal.

>
> If /delete-property/ is really not suitable to exist in this dtsi, we can=
 modify as
> above in U-Boot and upstream this change to Liunx. After this change is a=
ccepted
> by Linux, I will drop these two properties in U-Boot.
>
> Best regards,
> Hal

Yes let's do that. So long as it all works on VF2 1.2a, VF 1.3b, Mars,
and Star64. I have tested Star64. You have tested I guess VF2 1.3b?
And if we miss some, it's okay even if there is a problem for some
board we did not test, the workaround is easy in u-boot specific dtsi
per-board because we have avoided '/delete-property/' in the common
dtsi.

-E
