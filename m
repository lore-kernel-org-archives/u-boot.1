Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240B5C7115C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 13:27:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97C5C82E05;
	Wed, 25 Jun 2025 15:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="xqk8Gzgm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8078082E08; Wed, 25 Jun 2025 15:27:47 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56A7382DF2
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 15:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e82278e3889so1109917276.2
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 06:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1750858060; x=1751462860;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQ7wo/irFKITKJvv6DNY5QGaP3zZIy9PGgA3ub0epS0=;
 b=xqk8GzgmnudittzEzSbjzIgvRODraMi1Fme6hnaQvnblYNCMCx0Gx+kSD+Eg8E2V4K
 zTLZM87/aRpB1/50XXGYzobC4P+lwfljWudJSCDr+SxgoF0G2BeNpNWWM3VJYDUL+2eg
 KLwSPdG2PmikcoNBHcZDL3GoH6GEP8TyXd2zjLn4T+88kONOqtBElO+vW6jeUntlQAQO
 +rQj0ICD9cve549oDpyDrTBCNlIFewqTog/n14gUAwoodyeQGpypxdHT58LPSCUd3Id5
 X/Xr0WcgD2Gkx9YF2Q6ffdvah74kSDGMQKKYvvIsY3KjMFrTaMw9rKL9tlhjTl1a6kcq
 qTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750858060; x=1751462860;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IQ7wo/irFKITKJvv6DNY5QGaP3zZIy9PGgA3ub0epS0=;
 b=BGh2XZO7PEF/x/IiId0DVZzjXx+/G/ZWeSOyYkYM8j30qjdGetW0jLuvASPAmzQf2+
 elE1cMj63g2XbourN3xIBXdKFk9Ko4P9wTa90BXD1A+9EZEhhILif3Q0UppFvd1et5Q1
 3i1hp4vvVoK/tDVl25oiDYj5S1UHgEa1lPZzUVl6DBrNJAkep0f1hbE0YLt/FhhIzYRi
 5Up1knXt8efsoTHbJ5Xqm0lZEB05rjwJvEcoXvH8U/Kz6TBILATetV/iG4S1azlom49G
 zo7CrAAiZSBTOk1LURBZ806O/bPboqHNi7w49EjR8u6G3AoeYVLqDswf+GC42q6vVgiN
 19Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9Xn8G3dDTxyXogRZ5AhQDr/uAdg69f+FjilYLB/7pSycr2cEQl4jZfn8FNC5wnWMNUerEw5k=@lists.denx.de
X-Gm-Message-State: AOJu0Yzv/IsdosuQtUyZhGbdEu35efQJ0AuxIAN2WYFxqcH3+m2QRB/E
 261wDAy9ddZjdNRKqKizTdOhlramljnDdJZpmw62v962ezAHXFU8c0uUb7A8FunyDKDeeP0IyoN
 Jj1CRSASt+HH3ndX58yOxciHITtBmH9cJgm5Xw4uc
X-Gm-Gg: ASbGncuGK5EcaQkVRT0DJZ4v3CPQMApHoZg6arFyCJUaoftPOk2OOHoh4GEkOGokbHx
 L6GokA+SPuf56WSJZNwvtOTyHqm/K2GkvTzWkmCvyZVTsuTLjsxWWYA8EMRSjMuO1olQ2MYZA+3
 8QeExb2bPDH08BNW5262P5FB5Agxbyg2FA0wYcXqxeXK/s
X-Google-Smtp-Source: AGHT+IFNwYuaI3Y6BfupKHKZSu3Qq4xICfOsnfG1hizm+K+kPGMfbmIKVah7frAu0Fg1lkGWVTbLerofzfwFHQFtheE=
X-Received: by 2002:a05:6902:e0d:b0:e85:fba9:30d0 with SMTP id
 3f1490d57ef6-e86017379bdmr3897609276.2.1750858060078; Wed, 25 Jun 2025
 06:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250610045054.1038235-1-mikhail.kshevetskiy@iopsys.eu>
 <20250610095632.1085431-1-mikhail.kshevetskiy@iopsys.eu>
 <20250610095632.1085431-2-mikhail.kshevetskiy@iopsys.eu>
 <38f5d078-3328-4bdb-9c95-4fb5fe89ddc2@gmx.de>
In-Reply-To: <38f5d078-3328-4bdb-9c95-4fb5fe89ddc2@gmx.de>
From: Michal Simek <monstr@monstr.eu>
Date: Wed, 25 Jun 2025 15:27:28 +0200
X-Gm-Features: Ac12FXxCcrchoz15HKYw_a8baS711PeOJkLavVdlA-xoTCXmXl5mBwc9AD4J4Is
Message-ID: <CAHTX3dKdeM=NyjBJVRrZTLiuV3FuoyfvoLvGG8pPgA24o5g9qA@mail.gmail.com>
Subject: Re: [BUG] [PATCH v5 1/3] common/spl: fix potential out of buffer
 access in spl_fit_get_image_name function
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Sam Edwards <cfsworks@gmail.com>,
 Anshul Dalal <anshuld@ti.com>, 
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>, 
 Hal Feng <hal.feng@starfivetech.com>, Minda Chen <minda.chen@starfivetech.com>,
 E Shattow <lucent@gmail.com>
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

Hi Tom,

=C3=BAt 24. 6. 2025 v 14:59 odes=C3=ADlatel Heinrich Schuchardt
<xypron.glpk@gmx.de> napsal:
>
> On 10.06.25 11:56, Mikhail Kshevetskiy wrote:
> > The current code have two issues:
> > 1) ineffective NULL pointer check
> >
> >       str =3D strchr(str, '\0') + 1
> >       if (!str || ...
> >
> >     The str here will never be NULL (because we add 1 to result of strc=
hr())
> >
> > 2) strchr() may go out of the buffer for the special forms of name vari=
able.
> >     It's better use memchr() function here.
> >
> >     According to the code the property is a sequence of C-string like
> >     shown below:
> >
> >       'h', 'e', 'l', 'l', 'o', '\0', 'w', 'o', 'r', 'l', 'd', '\0', '!'=
, '\0'
> >
> >     index is the string number we are interested, so
> >
> >       index =3D 0   =3D>  "hello",
> >       index =3D 1   =3D>  "world",
> >       index =3D 2   =3D>  "!"
> >
> >     The issue will arrise if last string for some reason have no termin=
ating
> >     '\0' character. This can happen for damaged or specially crafted dt=
b.
> >
> > Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> > ---
> >   common/spl/spl_fit.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> > index 86506d6905c..ab277bb2baa 100644
> > --- a/common/spl/spl_fit.c
> > +++ b/common/spl/spl_fit.c
> > @@ -86,11 +86,12 @@ static int spl_fit_get_image_name(const struct spl_=
fit_info *ctx,
> >
> >       str =3D name;
> >       for (i =3D 0; i < index; i++) {
> > -             str =3D strchr(str, '\0') + 1;
> > -             if (!str || (str - name >=3D len)) {
> > +             str =3D memchr(str, '\0', name + len - str);
> > +             if (!str) {
> >                       found =3D false;
> >                       break;
> >               }
> > +             str++;
> >       }
> >
> >       if (!found && CONFIG_IS_ENABLED(SYSINFO) && !sysinfo_get(&sysinfo=
)) {
>
> Since this patch (commit 3704b888a4cabac8) on the Milk-V Mars board I
> see a message "cannot find image node ''" and on some builds I have seen
> boot failures.
>
> With your patch and some debug messages:
>
> U-Boot SPL 2025.07-rc4-00017-g3704b888a4ca-dirty (Jun 24 2025 - 14:45:11
> +0200)
> DDR version: dc2e84f0.
> Trying to boot from MMC2
> spl_fit_get_image_name(): index =3D 0, name =3D 'opensbi' len =3D 8
> spl_fit_get_image_name(): outname =3D 'opensbi'
> spl_fit_get_image_name(): index =3D 0, name =3D 'uboot' len =3D 6
> spl_fit_get_image_name(): outname =3D 'uboot'
> spl_fit_get_image_name(): index =3D 0, name =3D 'fdt-2' len =3D 6
> spl_fit_get_image_name(): outname =3D 'fdt-2'
> spl_fit_get_image_name(): index =3D 0, name =3D 'uboot' len =3D 6
> spl_fit_get_image_name(): outname =3D 'uboot'
> spl_fit_get_image_name(): index =3D 0, name =3D 'uboot' len =3D 6
> spl_fit_get_image_name(): outname =3D 'uboot'
> spl_fit_get_image_name(): index =3D 1, name =3D 'uboot' len =3D 6
> spl_fit_get_image_name(): outname =3D ''
> cannot find image node '': -1
>
>
> Before that patch:
>
> U-Boot SPL 2025.07-rc4-00017-g3704b888a4ca-dirty (Jun 24 2025 - 14:34:50
> +0200)
> DDR version: dc2e84f0.
> Trying to boot from MMC2
> spl_fit_get_image_name(): index =3D 0, name =3D 'opensbi' len =3D 8
> spl_fit_get_image_name(): outname =3D 'opensbi'
> spl_fit_get_image_name(): index =3D 0, name =3D 'uboot' len =3D 6
> spl_fit_get_image_name(): outname =3D 'uboot'
> spl_fit_get_image_name(): index =3D 0, name =3D 'fdt-2' len =3D 6
> spl_fit_get_image_name(): outname =3D 'fdt-2'
> spl_fit_get_image_name(): index =3D 0, name =3D 'uboot' len =3D 6
> spl_fit_get_image_name(): outname =3D 'uboot'
> spl_fit_get_image_name(): index =3D 0, name =3D 'uboot' len =3D 6
> spl_fit_get_image_name(): outname =3D 'uboot'
> spl_fit_get_image_name(): index =3D 1, name =3D 'uboot' len =3D 6
> no string for index 1
>
>
> With your patch spl_fit_get_image_name() does not detect that there is
> no property at index 1 and does not return -E2BIG. Instead it signals
> the property is an empty string and returns 0 which is not expected.
>

I also see random chars printed on the console on SOM with SPL flow.
This patch should be reverted.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
