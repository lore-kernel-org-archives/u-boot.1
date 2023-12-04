Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F789C07E97
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:44:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA618878CC;
	Mon,  4 Dec 2023 01:44:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CU9Mw8V3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BB66877E9; Mon,  4 Dec 2023 01:44:43 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 199528786E
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:44:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-548f853fc9eso5130598a12.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701650680; x=1702255480; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QMz96HfKom6jcWoSQIPG8B8pyhGeiO2Y48HU7T2VXGY=;
 b=CU9Mw8V3zKTaFQutWLSVeMYEA2qmiiwkRAKsQufD5SNENXyzeDD25dE4FieDb66ML9
 com6aXNQy0zHBIJkcf9d4GGbAekLrSFVNpayHYDwrPaIpXhOV8++EA3iF93mLvlG7Y98
 282F0irroCl+dyHQM5N6czMLYIXkilLfimMfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701650680; x=1702255480;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QMz96HfKom6jcWoSQIPG8B8pyhGeiO2Y48HU7T2VXGY=;
 b=uXBPUgz+xy8Dc6dR+0/0xjxsSHulTkjiEx5iHuAHAvWtexa888+6zyGFqHyYUt8ixt
 LyCP1sLqwx1ryQnknsIi5XeefY956b2zbM++FgWsdLO0NaBdS4/ka4YfjTwT4EuZ3RMt
 Y3fG8DVya1Jcl5V5CPNa4cBfW4fOzJq/AkNmRSp++59TN3mpl/LZ3Z6V5m5coiIMcf8m
 /tOo6+srw1xezwsJp15BTbE9t7A7xI2zCGcsQhvFZb8PTBlwxoknWQ0vbDKwd4hWSeZ/
 nXBSagZE5lXI/pvecUAvuSl7EJ81sXFGRgUZxWKbpfbv1cQ+fVDn19Uigz4k/Flv3nx8
 d7Ew==
X-Gm-Message-State: AOJu0YwbcJRjzsyMyG3QdtNkFKURoi2T0o3TUzqP9Jf9qhwXCNcW+E/+
 UJJjdptWkfKIsW+4Sj6RdogyeJ7n0f5hghLeUOQgbg==
X-Google-Smtp-Source: AGHT+IE9/59QzkrWG08hBdDkv2rXUpVdDE4r3SoiFkPsyuU4svNDJcauvq6UBgBCODeEtbkxJWnVLtjigoxAgV6xEX4=
X-Received: by 2002:a17:906:2789:b0:a19:d40a:d25d with SMTP id
 j9-20020a170906278900b00a19d40ad25dmr1493385ejc.297.1701650680389; Sun, 03
 Dec 2023 16:44:40 -0800 (PST)
MIME-Version: 1.0
References: <20231126220836.374956-1-i@shantur.com>
 <20231126220836.374956-4-i@shantur.com>
 <CAPnjgZ2W2maVN14usKHHdyTKyzriP_=iJYpYBvycRxR5zDZW2g@mail.gmail.com>
 <CAHc5_t3fMFntuQ+VLOb9RQ7CBCy7mtsEFEKZ1bWzDAu3mCVEHw@mail.gmail.com>
 <CAPnjgZ3YQb5Tva44HOv+SLx58XBJqqZwhFMxrfxrMY71bjpMLg@mail.gmail.com>
 <CAHc5_t2pEzVLH7aD_md5PVkpj_LC_U70EK-Q-1Yrc+P45NqVcw@mail.gmail.com>
In-Reply-To: <CAHc5_t2pEzVLH7aD_md5PVkpj_LC_U70EK-Q-1Yrc+P45NqVcw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 3 Dec 2023 17:44:23 -0700
Message-ID: <CAPnjgZ2Fs7-Q=agGAng64iuarSPkfEDCZjpMpgyykwP4=ZYjMg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] defconfig: rockpro64: Enable SF EFI var store
To: Shantur Rathore <i@shantur.com>
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

Hi Shantur,

On Sun, 3 Dec 2023 at 14:49, Shantur Rathore <i@shantur.com> wrote:
>
> Hi Simon,
>
> On Sun, Dec 3, 2023 at 5:44=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > Hi Shantur,
> >
> > On Sat, 2 Dec 2023 at 16:12, Shantur Rathore <i@shantur.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Fri, Dec 1, 2023 at 6:44=E2=80=AFPM Simon Glass <sjg@chromium.org>=
 wrote:
> > > >
> > > > Hi Shantur,
> > > >
> > > > On Sun, 26 Nov 2023 at 15:09, Shantur Rathore <i@shantur.com> wrote=
:
> > > > >
> > > > > RockPro64 uses SPI Flash for storing env, also use it store
> > > > > EFI variables.
> > > > >
> > > > > Signed-off-by: Shantur Rathore <i@shantur.com>
> > > > > ---
> > > > >
> > > > >  configs/rockpro64-rk3399_defconfig | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro=
64-rk3399_defconfig
> > > > > index 4cd6b76665..f550f2ae43 100644
> > > > > --- a/configs/rockpro64-rk3399_defconfig
> > > > > +++ b/configs/rockpro64-rk3399_defconfig
> > > > > @@ -8,6 +8,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> > > > >  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x300000
> > > > >  CONFIG_ENV_SIZE=3D0x8000
> > > > >  CONFIG_ENV_OFFSET=3D0x3F8000
> > > > > +CONFIG_EFI_VARIABLE_SF_STORE=3Dy
> > > > > +CONFIG_EFI_VARIABLE_SF_OFFSET=3D0x7D0000
> > > >
> > > > Can we use this offset in binman when creating the SPI-flash image?
> > >
> > > Unless I missed something, binman is used when something is bundled
> > > with a u-boot image.
> > > This is similar to ENV_OFFSET letting u-boot know where it can write
> > > the EFI variables.
> > > I didn't see ENV_OFFSET referred in rk3399-u-boot.dtsi or
> > > rk3399-rockpro64-u-boot.dtsi
> > >
> > > Please correct me if I am wrong.
> >
> > Well, this is what I see in arch/arm/dts/rk3399-u-boot.dtsi :
> >
> > #if defined(CONFIG_ROCKCHIP_SPI_IMAGE) && defined(CONFIG_HAS_ROM)
> > &binman {
> >    multiple-images;
> >    rom {
> >       filename =3D "u-boot.rom";
> >       size =3D <0x400000>;
> >       pad-byte =3D <0xff>;
> >
> >       mkimage {
> >          args =3D "-n rk3399 -T rkspi";
> >          u-boot-spl {
> >          };
> >       };
> >       u-boot-img {
> >          offset =3D <0x40000>;
> >       };
> >       u-boot {
> >          offset =3D <0x300000>;
> >       };
> >       fdtmap {
> >       };
> >    };
> > };
> > #endif /* CONFIG_ROCKCHIP_SPI_IMAGE && CONFIG_HAS_ROM */
> >
> > So it looks like 0x3f8000 fits in there somewhere.
> >
>
> Thanks for clarifying. Now I see how ENV space is declared as used by u-b=
oot.
>
>
> > In fact, I wonder if we should add something like:
> >
> > u-boot-env {
> >    offset =3D <CONFIG_ENV_OFFSET>;
> > };
> >
> > so the environment gets filled into the SPI flash when we write the ima=
ge?
> >
>
> Do we want to reset the environment to default on every u-boot update?
> I believe this would overwrite the environment space isn't it.

It depends on how the update is done. If the image written is smaller
than the full size of the SPI flash and the environment is at the end
of it, then it would be preserved.

But in fact the u-boot.rom file is 0x400000 bytes (4MB) so I don't see
how that would work. So we might as well add the environment in?

>
> > I suppose we could also add the EFI variable store, although that
> > would require adding a new entry type to binman.
> >
>
> I am not sure about this but surely EFI vars can be moved to a location
> just after the u-boot environment and increase the u-boot image size.

Yes.

>
> Would you still need an entry in dts?

My point was really just that the binman description should contain
the full layout of the flash. Otherwise someone might adjust something
such that the environment overlays U-Boot code, etc.

Regards,
Simon
