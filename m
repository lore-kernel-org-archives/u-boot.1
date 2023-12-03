Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731C8C4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 21:50:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1D6E87646;
	Sun,  3 Dec 2023 22:49:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="ou0RYZuE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BD5487646; Sun,  3 Dec 2023 22:49:59 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB18187622
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 22:49:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c9f166581dso15248901fa.2
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 13:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1701640195; x=1702244995;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wOWRMT9Wom2rCZvtVJ3G50s9Dz2cWMlzHMRlXl0E0Tk=;
 b=ou0RYZuECl1reiRRqPncEBXpoIuw3lhPN3z5NiW3iQ7KI57sXKmDPbGGxi4msDpV3J
 oeZW6HBQj3tenaOUiwo8p1RmyNwhy0eF30Ew2hey7xWSpE2U9c4n1HzyDEU79IKPHJ2T
 WqRdULwr1pYhS51N90PA1M77O+dEpLXJvSjuQ1k8NJmCJ6q6jTLHgm2iqvw3pAHG3eN4
 eOme7w3jd/5Ydthq3WRYLJkLfLw7GfX3ETcZVKEEB1vwBr8NBFecBNrj4d0AdX3IsYPj
 LNdCetGxZCCrUo4/U9cmyrhuT51NV79an/GcFzrTY+rM4k/zcRx6K07KHAsUGKYnDlMG
 /60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701640195; x=1702244995;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wOWRMT9Wom2rCZvtVJ3G50s9Dz2cWMlzHMRlXl0E0Tk=;
 b=EJnzloiwVLAcIFPNozNEM1t1YzQ9jBogIO+bz4QMdwEeUo/teDuMm3uIMBxHTuXy8I
 MXDX0Pd5JLpoCvPGyX2LsYp6m+OUmbygYAmaBpxvid1xVFNp6AXw+4kgydLU6nhkJF/I
 6s5lYqeyTM33cKJqH4uQTlJVMzkw+eXhmY8+RIB94tNAIU+CahM2kE8H7p/yAOFy9F96
 zDix8ZoqK7nTQR1e0utVyFGZzOvb72/NBuoXK2isft5e0LGAYkUEO3Nflyex5WhwKCqd
 AtUS2NHNdOTMan+TA83099ZmKLyvuIXjp1hRrwdFzIgBB8Klu5gnyilhC5FrqvkZNgZE
 2Xhg==
X-Gm-Message-State: AOJu0YzmvI66Rw71wZ8fLt8ZGLwqnuSDZk1p62/bb4mxyOXOHeOOHiqT
 WPtIIe41tYzqP1JNAZEIFWvMQsQ20Rb4iduj1yGwishp
X-Google-Smtp-Source: AGHT+IEuNvCHTOJMPvJdoYhNuBhcjNLoyJ2B03Q9MBLqWVCTfusXrxUIZDKv93vpB4sceU5aPhoYjA==
X-Received: by 2002:a2e:87d9:0:b0:2ca:3ea:fe05 with SMTP id
 v25-20020a2e87d9000000b002ca03eafe05mr157566ljj.98.1701640195546; 
 Sun, 03 Dec 2023 13:49:55 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com.
 [209.85.208.51]) by smtp.gmail.com with ESMTPSA id
 my18-20020a1709065a5200b009f28db2b702sm4514596ejc.209.2023.12.03.13.49.55
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 13:49:55 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-54c7744a93fso1913328a12.2
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 13:49:55 -0800 (PST)
X-Received: by 2002:a50:d5c3:0:b0:54a:8e8c:80ac with SMTP id
 g3-20020a50d5c3000000b0054a8e8c80acmr3074567edj.30.1701640194803; Sun, 03 Dec
 2023 13:49:54 -0800 (PST)
MIME-Version: 1.0
References: <20231126220836.374956-1-i@shantur.com>
 <20231126220836.374956-4-i@shantur.com>
 <CAPnjgZ2W2maVN14usKHHdyTKyzriP_=iJYpYBvycRxR5zDZW2g@mail.gmail.com>
 <CAHc5_t3fMFntuQ+VLOb9RQ7CBCy7mtsEFEKZ1bWzDAu3mCVEHw@mail.gmail.com>
 <CAPnjgZ3YQb5Tva44HOv+SLx58XBJqqZwhFMxrfxrMY71bjpMLg@mail.gmail.com>
In-Reply-To: <CAPnjgZ3YQb5Tva44HOv+SLx58XBJqqZwhFMxrfxrMY71bjpMLg@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Sun, 3 Dec 2023 21:49:43 +0000
X-Gmail-Original-Message-ID: <CAHc5_t2pEzVLH7aD_md5PVkpj_LC_U70EK-Q-1Yrc+P45NqVcw@mail.gmail.com>
Message-ID: <CAHc5_t2pEzVLH7aD_md5PVkpj_LC_U70EK-Q-1Yrc+P45NqVcw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] defconfig: rockpro64: Enable SF EFI var store
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>
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

Hi Simon,

On Sun, Dec 3, 2023 at 5:44=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Shantur,
>
> On Sat, 2 Dec 2023 at 16:12, Shantur Rathore <i@shantur.com> wrote:
> >
> > Hi Simon,
> >
> > On Fri, Dec 1, 2023 at 6:44=E2=80=AFPM Simon Glass <sjg@chromium.org> w=
rote:
> > >
> > > Hi Shantur,
> > >
> > > On Sun, 26 Nov 2023 at 15:09, Shantur Rathore <i@shantur.com> wrote:
> > > >
> > > > RockPro64 uses SPI Flash for storing env, also use it store
> > > > EFI variables.
> > > >
> > > > Signed-off-by: Shantur Rathore <i@shantur.com>
> > > > ---
> > > >
> > > >  configs/rockpro64-rk3399_defconfig | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64=
-rk3399_defconfig
> > > > index 4cd6b76665..f550f2ae43 100644
> > > > --- a/configs/rockpro64-rk3399_defconfig
> > > > +++ b/configs/rockpro64-rk3399_defconfig
> > > > @@ -8,6 +8,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> > > >  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x300000
> > > >  CONFIG_ENV_SIZE=3D0x8000
> > > >  CONFIG_ENV_OFFSET=3D0x3F8000
> > > > +CONFIG_EFI_VARIABLE_SF_STORE=3Dy
> > > > +CONFIG_EFI_VARIABLE_SF_OFFSET=3D0x7D0000
> > >
> > > Can we use this offset in binman when creating the SPI-flash image?
> >
> > Unless I missed something, binman is used when something is bundled
> > with a u-boot image.
> > This is similar to ENV_OFFSET letting u-boot know where it can write
> > the EFI variables.
> > I didn't see ENV_OFFSET referred in rk3399-u-boot.dtsi or
> > rk3399-rockpro64-u-boot.dtsi
> >
> > Please correct me if I am wrong.
>
> Well, this is what I see in arch/arm/dts/rk3399-u-boot.dtsi :
>
> #if defined(CONFIG_ROCKCHIP_SPI_IMAGE) && defined(CONFIG_HAS_ROM)
> &binman {
>    multiple-images;
>    rom {
>       filename =3D "u-boot.rom";
>       size =3D <0x400000>;
>       pad-byte =3D <0xff>;
>
>       mkimage {
>          args =3D "-n rk3399 -T rkspi";
>          u-boot-spl {
>          };
>       };
>       u-boot-img {
>          offset =3D <0x40000>;
>       };
>       u-boot {
>          offset =3D <0x300000>;
>       };
>       fdtmap {
>       };
>    };
> };
> #endif /* CONFIG_ROCKCHIP_SPI_IMAGE && CONFIG_HAS_ROM */
>
> So it looks like 0x3f8000 fits in there somewhere.
>

Thanks for clarifying. Now I see how ENV space is declared as used by u-boo=
t.


> In fact, I wonder if we should add something like:
>
> u-boot-env {
>    offset =3D <CONFIG_ENV_OFFSET>;
> };
>
> so the environment gets filled into the SPI flash when we write the image=
?
>

Do we want to reset the environment to default on every u-boot update?
I believe this would overwrite the environment space isn't it.

> I suppose we could also add the EFI variable store, although that
> would require adding a new entry type to binman.
>

I am not sure about this but surely EFI vars can be moved to a location
just after the u-boot environment and increase the u-boot image size.

Would you still need an entry in dts?
