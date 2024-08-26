Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE02C5472E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 18:18:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01F57889C5;
	Mon, 26 Aug 2024 20:18:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mrtPoZPQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9A3988966; Mon, 26 Aug 2024 20:18:33 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84D5988A82
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 20:18:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-70942ebcc29so4284616a34.0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 11:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724696310; x=1725301110; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iyogZvfra/akdjbJmuehEIDepg73NK5yG9BFZ5hJ6SI=;
 b=mrtPoZPQ0c5mZJDAmQeShM1aFTp3Yc3S9/OejUI2b7Bgu3hEbWJBNI4gaOnRfUzhIj
 0pF85/Kvu5WeKKdoa9jFeOO2p8d13c8eIeriwi6i/hWdF9FKPBzypcdXC4FK7FvKf8ws
 UnX0rVfrRHNY4jkiwubkM5rsa0KGSPPNUCaVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724696310; x=1725301110;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iyogZvfra/akdjbJmuehEIDepg73NK5yG9BFZ5hJ6SI=;
 b=seOTsf5epibTk0maNylWnvNkk0M2yvz+KPp4ESWQPX91BBo+HBkKOhLZhl4Gk0CxTG
 UhKn+EANAusskJ4Nv0p/e1rvSjBYhiReR6K0G7/eh8YsSmEisvFc68sp5WbP9fKau7AR
 NobzqDJtL5sYaplQyjst/LxXLiC37acTtnRetBY8xAeCr3gAizmuhgbCwxe0lDTuOt06
 RQmzkYIzsx/wtFBNoNyzmvTI+B7ruzEpowhhP0A7X5Z/AQzWFABFx3CR1ywmE7u1KWqj
 TS5xXQmKJj43lOgnEHRTfizROOapJDuFtOLbypousBURIQpfzP2dFpeJk6VXbApTgedp
 KMaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzA7Oc8NnvU9Ml6CmybDc5u7wngteYoPe56hvaEzCtTneNEGYtabS8L+l6mGOke/WFqeBc0+8=@lists.denx.de
X-Gm-Message-State: AOJu0YwZr9Pd5aeIocHDTYT6U4k6L7bGqcQyyt+sqvLWGSR/2RLahNJ/
 6ZXW5t9R1TwE0MwnwMPlHWTURBwz0mZeiD7iicGRUE5sWTZ6uBnYsVms6xiExTg=
X-Google-Smtp-Source: AGHT+IFBNmAMBIo/FEPZQmEdwW0IUju5Hsg29A57J5uYzEJ1TuwRZXzZ+33W2/Gwrw+xBRbpxtBcbA==
X-Received: by 2002:a05:6808:2129:b0:3d9:e1fd:5660 with SMTP id
 5614622812f47-3de2a8ec9bamr12691336b6e.31.1724696310138; 
 Mon, 26 Aug 2024 11:18:30 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fdfc82d1sm45742201cf.4.2024.08.26.11.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 11:18:29 -0700 (PDT)
Date: Mon, 26 Aug 2024 12:18:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v4 10/14] efi_loader: Disable ANSI output for tests
Message-ID: <20240826181826.GI2479150@bill-the-cat>
References: <20240815202424.766778-1-sjg@chromium.org>
 <20240815202424.766778-11-sjg@chromium.org>
 <CAC_iWjJARSNuFRE4x85fNMkT68NnB74bCZe6ryKm2Rp5axTJEg@mail.gmail.com>
 <CAFLszTjwstB4PdPR4Rf0FpJDJuSQkSw=9-nZTkSNedLv5iaKyg@mail.gmail.com>
 <ba46d2c2-38ac-411a-a48c-429295cf6efb@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q+/DDJpkWsx9kvE7"
Content-Disposition: inline
In-Reply-To: <ba46d2c2-38ac-411a-a48c-429295cf6efb@gmx.de>
X-Clacks-Overhead: GNU Terry Pratchett
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


--q+/DDJpkWsx9kvE7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 08:16:45PM +0200, Heinrich Schuchardt wrote:
> On 8/26/24 19:57, Simon Glass wrote:
> > Hi Ilias,
> >=20
> > On Mon, 26 Aug 2024 at 05:47, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >=20
> > > Hi Simon,
> > >=20
> > > On Thu, 15 Aug 2024 at 23:24, Simon Glass <sjg@chromium.org> wrote:
> > > >=20
> > > > We don't want ANSI characters written in tests since it is a pain to
> > > > check the output with ut_assert_nextline() et al.
> > > >=20
> > > > Provide a way to tests to request that ANSI characters not be sent.
> > > >=20
> > > > Add a proper function comment while we are here, to encourage other=
s.
> > > >=20
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >=20
> > > > (no changes since v1)
> > > >=20
> > > >   include/efi_loader.h         | 21 ++++++++++++++++++++-
> > > >   lib/efi_loader/efi_console.c | 26 +++++++++++++++++---------
> > > >   2 files changed, 37 insertions(+), 10 deletions(-)
> > > >=20
> > > > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > > > index f84852e384f..82b90ee0f1d 100644
> > > > --- a/include/efi_loader.h
> > > > +++ b/include/efi_loader.h
> > > > @@ -531,8 +531,27 @@ efi_status_t efi_bootmgr_delete_boot_option(u1=
6 boot_index);
> > > >   efi_status_t efi_bootmgr_run(void *fdt);
> > > >   /* search the boot option index in BootOrder */
> > > >   bool efi_search_bootorder(u16 *bootorder, efi_uintn_t num, u32 ta=
rget, u32 *index);
> > > > -/* Set up console modes */
> > > > +
> > > > +/**
> > > > + * efi_setup_console_size() - update the mode table.
> > > > + *
> > > > + * By default the only mode available is 80x25. If the console has=
 at least 50
> > > > + * lines, enable mode 80x50. If we can query the console size and =
it is neither
> > > > + * 80x25 nor 80x50, set it as an additional mode.
> > > > + */
> > > >   void efi_setup_console_size(void);
> > > > +
> > > > +/**
> > > > + * efi_console_set_ansi() - Set whether ANSI characters should be =
emitted
> > > > + *
> > > > + * These characters mess up tests which use ut_assert_nextline(). =
Call this
> > > > + * function to tell efi_loader not to emit these characters when s=
tarting up the
> > > > + * terminal
> > > > + *
> > > > + * @allow_ansi: Allow emitting ANSI characters
> > > > + */
> > > > +void efi_console_set_ansi(bool allow_ansi);
> > > > +
> > > >   /* Set up load options from environment variable */
> > > >   efi_status_t efi_env_set_load_options(efi_handle_t handle, const =
char *env_var,
> > > >                                        u16 **load_options);
> > > > diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_cons=
ole.c
> > > > index cea50c748aa..569fc9199bc 100644
> > > > --- a/lib/efi_loader/efi_console.c
> > > > +++ b/lib/efi_loader/efi_console.c
> > > > @@ -30,6 +30,17 @@ struct cout_mode {
> > > >=20
> > > >   __maybe_unused static struct efi_object uart_obj;
> > > >=20
> > > > +/*
> > > > + * suppress emission of ANSI codes for use by unit tests. Leave it=
 as 0 for the
> > > > + * default behaviour
> > > > + */
> > > > +static bool no_ansi;
> > > > +
> > > > +void efi_console_set_ansi(bool allow_ansi)
> > > > +{
> > > > +       no_ansi =3D !allow_ansi;
> > > > +}
> > > > +
> > > >   static struct cout_mode efi_cout_modes[] =3D {
> > > >          /* EFI Mode 0 is 80x25 and always present */
> > > >          {
> > > > @@ -348,13 +359,6 @@ static int __maybe_unused query_vidconsole(int=
 *rows, int *cols)
> > > >          return 0;
> > > >   }
> > > >=20
> > > > -/**
> > > > - * efi_setup_console_size() - update the mode table.
> > > > - *
> > > > - * By default the only mode available is 80x25. If the console has=
 at least 50
> > > > - * lines, enable mode 80x50. If we can query the console size and =
it is neither
> > > > - * 80x25 nor 80x50, set it as an additional mode.
> > > > - */
> > > >   void efi_setup_console_size(void)
> > > >   {
> > > >          int rows =3D 25, cols =3D 80;
> > > > @@ -362,8 +366,12 @@ void efi_setup_console_size(void)
> > > >=20
> > > >          if (IS_ENABLED(CONFIG_VIDEO))
> > > >                  ret =3D query_vidconsole(&rows, &cols);
> > > > -       if (ret)
> > > > -               ret =3D query_console_serial(&rows, &cols);
> > > > +       if (ret) {
> > > > +               if (no_ansi)
> > >=20
> > > What are you trying to do here? The function you are skipping just
> > > queries the number of columns and rows. The defaults on the function
> > > are 80x25, so the setup will continue
> >=20
> > Well, the query works by sending out some ANSI characters to the
> > terminal, then checking the result. In a unit test, these characters
> > are captured and the unit test fails when ut_assert_nextline() gets
> > unexpected output.
>=20
> We should be able to compile U-Boot with all tests enabled such that it
> is still usable on real hardware.

Please keep in mind "real hardware" is where this is the biggest problem
today. I don't run a bunch of the EFI tests on real hardware because the
ANSI stuff leads to spurious failures, and so it's best to just turn
that off rather than re-run the test and see if it passes the next time.

--=20
Tom

--q+/DDJpkWsx9kvE7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbMxuwACgkQFHw5/5Y0
tyxrjwwAicwtMBKzGZEfGoHZWbjP+54XTIWuGnvPvSiWwq4htpFZIa9oyDtxAH3n
SUUDE54MWc88/zdisDT6pVJpGILCcvHkRxAH2J1/y+5iVqJc+IkA0DiWP+F541pL
s151N2khI3b5VPt5QQUlyQwrr9usrMVGxgikSaNMvkqHH84UUr7UDd+6Po2ZGlLS
QVNWYbmPHqMgPBU9NdaVMnSBw/tupaENMDae/QmIWzKajhgGEZGZfnUnpnnFl7rF
WfAIudq0BHlS5ZYgNh2bAHAomIcI4BzbBxPDq2TauZTjjGzG53OsmvwRFr8viw0P
RTHx/QmyMX9yYUtcseFjpdTBAoBliyLFc/tMlgXTMMDB2/nZDN8io3thB8z9XBnC
p/TWYu7lQ26+4AKBeJs4W2w95fuSXQey/lcj3p3XAN8jK5shkvMgi0dqg/LLzEW7
DclcSGOEmknZst/MB+p9EV+y1VLuWwatsDsXfjK3sC9VdvKLjvg3+hMyHIoB/Qbj
nw98A1r3
=PZ3V
-----END PGP SIGNATURE-----

--q+/DDJpkWsx9kvE7--
