Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3C7C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:48:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BCB4878E1;
	Tue, 26 Dec 2023 10:47:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wr9Yt1/4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76A758786E; Tue, 26 Dec 2023 10:47:20 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F62A878CD
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:47:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6d9b2c8e2a4so770182b3a.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584036; x=1704188836; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qib+tmzKc4kZUS4n1JJkDDecSz52lJ4TNNuuJIFbfnY=;
 b=Wr9Yt1/4xgME0UkmmfbnIvKzKuC6HEmMCD0VSPzQqX4uOVqRmh7QTkM9AlmXuN8AE6
 6KCXdcLup8mhO58HLDIWT/XcR/FCJteCZwZ8PKrD+Iw6H1OZJNU9UcuvdH/m7ZimgkwF
 7EiSbl3/8zhuj2IFM2GBf4UcMCAEC1qmC5dd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584036; x=1704188836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qib+tmzKc4kZUS4n1JJkDDecSz52lJ4TNNuuJIFbfnY=;
 b=KjBj5TG3yVIyIJaItMlzncAOaJFetFJ/M18kzZm9VfKt9+pJHOZioA6XteLpshL74B
 0XWceNORFpvveQX5Z2P+OFJTTzXFScvKfhVb2gDXdA/cu/q0l00VY4l0uRRKLXRw0pc5
 RdYjJjiiba/+X0ZdlPAzFFmJtG1Hfij7ySjbouUhoFAlv56ANcxtmFMRaFtWM+PX6sfC
 M2C0zLrBETkwpcPzqM2y9VyecFNW86gKJhW5NFywuhRJh3KHBU/a4EbK3XGrhoVX7W4o
 29uYhmRi2R0Ahg4RV1VQ3HWY+q2GCeFLWmUDqoZ5Boo5BIpTmvnpE6tI6UtmxPPkmJsY
 lMYg==
X-Gm-Message-State: AOJu0Yz2ek50a37A6PzXmC8wiRoyy386RgVW4IdElYFT0jyyH6R9hv8q
 NUP8gyTdYInTjckpijhEnpefuHGl4TxmbZMd6Yhd8/Dpxrcj
X-Google-Smtp-Source: AGHT+IFEZIvKEfcLeGt7D3DKj2+QgfxUFISPh/2OsBNMhHmqz+hPRruBlZmzwLj3pk9Kt/nrQdvPlsFhPpLfBJotfSU=
X-Received: by 2002:a05:6a00:1943:b0:6d9:dfee:cf7f with SMTP id
 s3-20020a056a00194300b006d9dfeecf7fmr1008070pfk.21.1703584035756; Tue, 26 Dec
 2023 01:47:15 -0800 (PST)
MIME-Version: 1.0
References: <20231218023842.281336-1-takahiro.akashi@linaro.org>
 <20231218023842.281336-4-takahiro.akashi@linaro.org>
 <CAPnjgZ0qw7j3TCMN+xH6ONaWvUyRvkWpsZJd2PQWHYBhZkTD6g@mail.gmail.com>
 <ZYDhClYupQxNJ++a@octopus>
 <CAPnjgZ222JWVWws04Tk93QommHXY6=qJFfiQfosYs5FG4JVGrA@mail.gmail.com>
 <CD73D0D7-1040-4AD9-B5CD-741146DE0C34@gmx.de>
In-Reply-To: <CD73D0D7-1040-4AD9-B5CD-741146DE0C34@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:47:03 +0000
Message-ID: <CAFLszTi2k3CyfbybPuNCKTFZoVUiZy++Ma0BoUrYTj5dUWFh_w@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] net: tftp: remove explicit efi configuration
 dependency
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, trini@konsulko.com, 
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
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

Hi Heinrich,

On Wed, Dec 20, 2023 at 9:17=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
>
>
> Am 20. Dezember 2023 05:46:16 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >Hi,
> >
> >On Mon, 18 Dec 2023 at 17:17, AKASHI Takahiro
> ><takahiro.akashi@linaro.org> wrote:
> >>
> >> Hi Simon,
> >>
> >> On Mon, Dec 18, 2023 at 08:01:46AM -0700, Simon Glass wrote:
> >> > Hi AKASHI,
> >> >
> >> > On Sun, 17 Dec 2023 at 19:39, AKASHI Takahiro
> >> > <takahiro.akashi@linaro.org> wrote:
> >> > >
> >> > > Now it is clear that the feature actually depends on efi interface=
s,
> >> > > not "bootefi" command. efi_set_bootdev() will automatically be nul=
lified
> >> > > if necessary efi component is disabled.
> >> > >
> >> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >> > > ---
> >> > >  net/tftp.c | 10 ++++------
> >> > >  1 file changed, 4 insertions(+), 6 deletions(-)
> >> > >
> >> >
> >> > I have the same comment here as the 'fs' patch.
> >> >
> >> > > diff --git a/net/tftp.c b/net/tftp.c
> >> > > index 88e71e67de35..2e335413492b 100644
> >> > > --- a/net/tftp.c
> >> > > +++ b/net/tftp.c
> >> > > @@ -302,12 +302,10 @@ static void tftp_complete(void)
> >> > >                         time_start * 1000, "/s");
> >> > >         }
> >> > >         puts("\ndone\n");
> >> > > -       if (IS_ENABLED(CONFIG_CMD_BOOTEFI)) {
> >> >
> >> > Shouldn't this depend on your new CONFIG? What happens if EFI_LOADER
> >> > is not enabled?
> >>
> >> The trick is in efi_loader.h.
> >> If EFI_LOADER (more specifically CONFIG_EFI_BINARY_EXEC) is not define=
d,
> >> this function gets voided.  See patch#1 in this version.
> >>
> >> I took this approach in order not to make users much worried about
> >> what config be used as they are not familiar with UEFI implementation.
> >
> >OK, but we really need to delete this function, so what is the plan
> >for that? The info that EFI needs should be passed to the bootefi()
> >function, not set in a global.
>
> Hello Simon,
>
> Bootstd is not the only way to boot. Please, do not forget the shell.
>
> The user loads a file with tftpboot. At some later moment the user execut=
es bootefi.
>
> We need a place where we store the device from which the image was loaded=
.

Yes, agreed. See my other reply on that.

>
> In future we might have a register of loaded files. But that is beyond th=
e scope of this patch series.

I believe we could just record the device and partition number (which
is itself a device these days, I suppose). Then for EFI can do the
translation at the start of the bootm cmd if not using bootstd.

Reviewed-by: Simon Glass <sjg@chromium.org>

>
> Best regards
>
> Heinrich
>
> >
> >
> >>
> >> -Takahiro Akashi
> >>
> >> > > -               if (!tftp_put_active)
> >> > > -                       efi_set_bootdev("Net", "", tftp_filename,
> >> > > -                                       map_sysmem(tftp_load_addr,=
 0),
> >> > > -                                       net_boot_file_size);
> >> > > -       }
> >> > > +       if (!tftp_put_active)
> >> > > +               efi_set_bootdev("Net", "", tftp_filename,
> >> > > +                               map_sysmem(tftp_load_addr, 0),
> >> > > +                               net_boot_file_size);
> >> > >         net_set_state(NETLOOP_SUCCESS);
> >> > >  }
> >> > >
> >> > > --
> >> > > 2.34.1
> >
> >Regards,

Regards,
Simon
