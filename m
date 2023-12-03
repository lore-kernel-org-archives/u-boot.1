Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F4AC4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 17:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D82D28763C;
	Sun,  3 Dec 2023 18:44:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iWDH89r6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D41387636; Sun,  3 Dec 2023 18:44:25 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C4D78753C
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 18:44:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a1a0fedd3a1so271837366b.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 09:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701625463; x=1702230263; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n0QbySo+gl7v0OI4rhF5N2r2moy416q1K+xXlAKn5DM=;
 b=iWDH89r6rpa8fjHTZFiYaXA9zZHfU9ra04MyVY/Pqh8OJ9qtbgBeNcYcQOH13Ma+C3
 BdqYbY2KgewUjdamPH44C/Pkc+K8e9hq13hOjUKr3qV/byuc4EkG+b3gf/18vUJHO+FW
 NFpZ3bAzL0oVHgXJVaO5yTqL2mZvs2LlqvkK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701625463; x=1702230263;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n0QbySo+gl7v0OI4rhF5N2r2moy416q1K+xXlAKn5DM=;
 b=QVg0JgLapRiqslSzfJO2M/RB4CxaFmz4ov7iymhKGIxzkKtlN9xFwnbhEqsuizbIKR
 XnlfkqY1+ghc0zRvjeIl98rqv7jn6iJf1xBqwSAT4F0RgOm3QARVQxhTXDIRZ0FEhaek
 njGsbTebmLyc2CgeGxkiNpQC8sApXEbi6pf/JVOHXXqGDo79GhN6z6D4gIoXAt/laWpq
 51PusU8fI6JfMyFrP2d/KmnNw7UFf/qyoiWa5mEyMZKDujknY+c/WiLJwHTrrQ99sNEq
 etDGSS+NTBsCCjGiNiZmn8f2qBFXSh1AXTeNwnjRtzEg4oNRsnIKQfkGFU+2Zp+rucBf
 9Lpg==
X-Gm-Message-State: AOJu0YyyZrswF2QclLd3rcXOCKUmENDJCgE0ViwZszigiKE4cwROf7Zo
 24WojI9jWZ1MHWQWmD7p+k9i65xqOK2MDLwUj6vc8A==
X-Google-Smtp-Source: AGHT+IF2Hrsw/8Jjei/zH8ZTuKFua3zhGAh+M8pX5Hemk9cDBplNfj618x3ryZQHlMsiyLk98Eexj8y9GpTOWmJ0uvs=
X-Received: by 2002:a17:906:205:b0:a0c:c09f:65fe with SMTP id
 5-20020a170906020500b00a0cc09f65femr4126208ejd.38.1701625462651; Sun, 03 Dec
 2023 09:44:22 -0800 (PST)
MIME-Version: 1.0
References: <20231126220836.374956-1-i@shantur.com>
 <20231126220836.374956-4-i@shantur.com>
 <CAPnjgZ2W2maVN14usKHHdyTKyzriP_=iJYpYBvycRxR5zDZW2g@mail.gmail.com>
 <CAHc5_t3fMFntuQ+VLOb9RQ7CBCy7mtsEFEKZ1bWzDAu3mCVEHw@mail.gmail.com>
In-Reply-To: <CAHc5_t3fMFntuQ+VLOb9RQ7CBCy7mtsEFEKZ1bWzDAu3mCVEHw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 3 Dec 2023 10:44:11 -0700
Message-ID: <CAPnjgZ3YQb5Tva44HOv+SLx58XBJqqZwhFMxrfxrMY71bjpMLg@mail.gmail.com>
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

On Sat, 2 Dec 2023 at 16:12, Shantur Rathore <i@shantur.com> wrote:
>
> Hi Simon,
>
> On Fri, Dec 1, 2023 at 6:44=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > Hi Shantur,
> >
> > On Sun, 26 Nov 2023 at 15:09, Shantur Rathore <i@shantur.com> wrote:
> > >
> > > RockPro64 uses SPI Flash for storing env, also use it store
> > > EFI variables.
> > >
> > > Signed-off-by: Shantur Rathore <i@shantur.com>
> > > ---
> > >
> > >  configs/rockpro64-rk3399_defconfig | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-r=
k3399_defconfig
> > > index 4cd6b76665..f550f2ae43 100644
> > > --- a/configs/rockpro64-rk3399_defconfig
> > > +++ b/configs/rockpro64-rk3399_defconfig
> > > @@ -8,6 +8,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> > >  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x300000
> > >  CONFIG_ENV_SIZE=3D0x8000
> > >  CONFIG_ENV_OFFSET=3D0x3F8000
> > > +CONFIG_EFI_VARIABLE_SF_STORE=3Dy
> > > +CONFIG_EFI_VARIABLE_SF_OFFSET=3D0x7D0000
> >
> > Can we use this offset in binman when creating the SPI-flash image?
>
> Unless I missed something, binman is used when something is bundled
> with a u-boot image.
> This is similar to ENV_OFFSET letting u-boot know where it can write
> the EFI variables.
> I didn't see ENV_OFFSET referred in rk3399-u-boot.dtsi or
> rk3399-rockpro64-u-boot.dtsi
>
> Please correct me if I am wrong.

Well, this is what I see in arch/arm/dts/rk3399-u-boot.dtsi :

#if defined(CONFIG_ROCKCHIP_SPI_IMAGE) && defined(CONFIG_HAS_ROM)
&binman {
   multiple-images;
   rom {
      filename =3D "u-boot.rom";
      size =3D <0x400000>;
      pad-byte =3D <0xff>;

      mkimage {
         args =3D "-n rk3399 -T rkspi";
         u-boot-spl {
         };
      };
      u-boot-img {
         offset =3D <0x40000>;
      };
      u-boot {
         offset =3D <0x300000>;
      };
      fdtmap {
      };
   };
};
#endif /* CONFIG_ROCKCHIP_SPI_IMAGE && CONFIG_HAS_ROM */

So it looks like 0x3f8000 fits in there somewhere.

In fact, I wonder if we should add something like:

u-boot-env {
   offset =3D <CONFIG_ENV_OFFSET>;
};

so the environment gets filled into the SPI flash when we write the image?

I suppose we could also add the EFI variable store, although that
would require adding a new entry type to binman.

Regards,
Simon
