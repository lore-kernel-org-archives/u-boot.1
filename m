Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3DDC3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 16:24:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4C9B80107;
	Fri, 16 May 2025 18:24:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P4TEdPNK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E29068059D; Fri, 16 May 2025 18:24:31 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4D918006D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 18:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-70a2c0e7fbbso24706237b3.2
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 09:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747412668; x=1748017468; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pvA7dtW/KiiFB43E6AHz7IeGC3yI1cZLf18zuKE6UhA=;
 b=P4TEdPNKdLN01YtUyIJnhSViHaSKRFwcsGlahPPRWLq8CqfgOmAmvtH/cigby+vHfI
 8RGxlNVnA2LElTBePeawWtixnxIQEy4VL+ConAZJ36TftmwI/t76MtiLiUfOgPuuISZa
 Z4g+Th6lmIbNZu6d5A4W3RnICr8H954cU/fthyEvbM33b2OfKN7Hwb9QmJaYSWsiQVTY
 fl+KbHDhPFAHw+Jmz/Jawuxs7h3bwPYwEPYVfwFM2cbTRI2HQb+zDH+Dg8TrPYV9bSa6
 P1wy2C1KCGQl5MpuYiFAzZ1/jnj5p92P4Js2RrQwjzxuTaoNz/0KwCcyf47K4RL13SZB
 fI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747412668; x=1748017468;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pvA7dtW/KiiFB43E6AHz7IeGC3yI1cZLf18zuKE6UhA=;
 b=n337zXREEH/EB3Q4ztXZCEl2+syZx2Frs4Lezyz1wIK5T28+Gx/TaKshyC4bMJBW1v
 TfSxtUZHqkNZDzDeRqO+tGRufQwfhZbz8EySBMh6nznUuGMUV9INFJNLej92zBD6OzpJ
 l08SU6zhgWYpu5vBnnsrD5T7c3MvXSCLyAphW6rBGm5sJhefFPaNb85xAS5jVKTFGHx3
 U4vNdI+rEZD10MqBTxuFQDU/cZbzaA3AyBbdeTodBxcocRrMByhyCDO9LRlU6Skyt27c
 UUsOQAyK/M/hh6286kExVt2atBCmdF1uXbtUgr4eDJD84V5m4QTsWh1WV3QvlpFaiQG2
 OyKg==
X-Gm-Message-State: AOJu0YzFvY2OrpgWe9rKginuIPqZLoOxmurbZmheYfnPP7hkCPbp98mr
 sKZvkw1wZxZ8YQa24Ubw+c7HLa8rtuw4hDNJ1a8fFKiZqQTh6/F4uorbV9fUr34yH/sc7WDsals
 YNLpcqsAsITo4fnMArYah4cL6gqePZhZWv0HbYtk=
X-Gm-Gg: ASbGncvEIl8KS3TM15z3oTIyKyS5i5rVJofcmBXTpck9xxTCn8hj3wNqBX7HDqniKJh
 VxV++X9j8nRaG+YYPKOKP6fwzigALV/csWTUg//6YHbrK3AfHh8CyzbabWvzRxzjZznjrf7csTm
 rvRfwc5OA3M3sDrv3eA5KFrhliNxES4uBMUyhwe9aBha4=
X-Google-Smtp-Source: AGHT+IEgfXoGvQXhE+dwal/CdkldssTt8x+OW83ZMEeFjhLuJpxdpWQ1MZj57YA8et1jGUY4oVophuvsEVJhs+JCgBo=
X-Received: by 2002:a05:690c:3390:b0:70a:192d:122 with SMTP id
 00721157ae682-70cab0c30eamr44645787b3.30.1747412668270; Fri, 16 May 2025
 09:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250516125053.25457-1-ant.v.moryakov@gmail.com>
 <CAFLszTg03voPKR3Ojv_H5CvV2u8X4y9XqXL9Vh33_LRwFPz5pA@mail.gmail.com>
In-Reply-To: <CAFLszTg03voPKR3Ojv_H5CvV2u8X4y9XqXL9Vh33_LRwFPz5pA@mail.gmail.com>
From: Anton Moryakov <ant.v.moryakov@gmail.com>
Date: Fri, 16 May 2025 19:24:17 +0300
X-Gm-Features: AX0GCFv9gLhH6-38aZF5SzOxoI8erkyVxWJw8ziJSRCm8ck6azVYqn1HAeEV-44
Message-ID: <CAHb2+K52-EuZ5D4MxYgdDiw6OuWoa8rFa2f2K5pkKpQg1NhVLw@mail.gmail.com>
Subject: Re: [PATCH] drivers: spi: fix deref ater null.might in spi-uclass.c
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

I can then leave only
+       if (!dev) {
+               ret =3D -ENODEV;
+               goto err;
+       }
+
but make it higher
How do you like this option?


=D0=BF=D1=82, 16 =D0=BC=D0=B0=D1=8F 2025=E2=80=AF=D0=B3. =D0=B2 19:20, Simo=
n Glass <sjg@chromium.org>:

> Hi,
>
> On Fri, 16 May 2025 at 14:51, <ant.v.moryakov@gmail.com> wrote:
> >
> > From: Anton Moryakov <ant.v.moryakov@gmail.com>
> >
> > The static analyzer (Svace) reported
> > After having been compared to a NULL value at spi-uclass.c:465,
> > pointer 'dev' is passed as 1st parameter in call to function
> 'dev_get_flags'
> > at spi-uclass.c:469, where it is dereferenced at device.h:240.
> >
> > Correct explained:
> > 1. Added dev && !device_active(dev) check before calling device_active(=
)
> > 2. Added explicit if (!dev) check with ret =3D -ENODEV setting
> > 3. Protected logging in error block with if(dev) check
> >
> > Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
> > ---
> >  drivers/spi/spi-uclass.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
> > index d6049753740..52b79223f96 100644
> > --- a/drivers/spi/spi-uclass.c
> > +++ b/drivers/spi/spi-uclass.c
> > @@ -345,7 +345,7 @@ int spi_get_bus_and_cs(int busnum, int cs, struct
> udevice **busp,
> >                 return ret;
> >         }
> >
> > -       if (!device_active(dev)) {
> > +       if (dev && !device_active(dev)) {
> >                 struct spi_slave *slave;
> >
> >                 ret =3D device_probe(dev);
> > @@ -355,6 +355,11 @@ int spi_get_bus_and_cs(int busnum, int cs, struct
> udevice **busp,
> >                 slave->dev =3D dev;
> >         }
> >
> > +       if (!dev) {
> > +               ret =3D -ENODEV;
> > +               goto err;
> > +       }
> > +
> >         slave =3D dev_get_parent_priv(dev);
> >         bus_data =3D dev_get_uclass_priv(bus);
> >
> > @@ -373,8 +378,11 @@ int spi_get_bus_and_cs(int busnum, int cs, struct
> udevice **busp,
> >         return 0;
> >
> >  err:
> > -       log_debug("%s: Error path, device '%s'\n", __func__, dev->name)=
;
> > -
> > +       if(dev)
> > +               log_debug("%s: Error path, device '%s'\n", __func__,
> dev->name);
> > +       else
> > +               log_debug("%s: Error path, NULL device\n", __func__);
> > +
> >         return ret;
> >  }
> >
> > --
> > 2.30.2
> >
>
> You are not allowed to pass NULL as dev to driver model functions. So
> the bug here is in the SPI code.
>
> There is a code-size cost to checking arguments and we tend to be
> reluctant to pay it in U-Boot, where code size is often critical.
>
> We do have assert() but it is fairly intrusive and people seldom
> enable it. If you have a better way, please suggest it!
>
> Regards,
> Simon
>
