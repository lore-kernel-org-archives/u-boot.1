Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED80D1A426
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 22:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DB04893D1;
	Sat, 12 Oct 2024 00:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bbhEDwVZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A2D7893FE; Sat, 12 Oct 2024 00:18:21 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C45B2893CC
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 00:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6cbe53a68b5so15114626d6.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 15:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728685097; x=1729289897; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1FdHFACASQ9xQx7gN34qamm7v18dyQxLNlAYn58LipU=;
 b=bbhEDwVZjxlZ9GwfqLvclksCTgB1qygckfeglXtHhP1qJ7/G7X9suz6JvHNyPK30Vo
 Ywf4/lmcXwgPaqJGPw4L928Y9rDhWclN7PvDl0px+9M9PvSNSsjt0IWTT/LQ9H9/J9Qy
 Fihbju3hC1VwJxR+Rf9wSc8f5L/H9KaxGWjY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728685097; x=1729289897;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1FdHFACASQ9xQx7gN34qamm7v18dyQxLNlAYn58LipU=;
 b=lYSRrTMR+JuKIQRIF7V3/S//Q4s45aJ2lAkY48A76qNkACptVBju7VeU3H++qoYZp6
 22FmSL3GXXxv5JBw1NVdulJwaL7hzk1VOu9IK7TW06fCpY+rFlVyGN5qdj4AKUwWXjRB
 Btc2U2Ti9ySTUdSfVTCGHm0lnrJTbg6jcU2Z94Jtzd7EtvWOGj++y84XGq//OTmiVjJX
 HEi8Hi9IzPKyRgNBdbXpfAIjY68UXYfmGM1ovmSBTw0B39ECLJ83A+USE3djpyi+8z5Z
 57tdgL9JkgpWkSAL86H6ndfSMLgqhSAogQlfPtfeVBtypV8BdqEYv8B9mEfvHH1QWYRe
 54jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJF7fzgztcYRipqdydIFbho9pvY9A2y6YqJCbJ21csfqpJJBd446xJ+pCxuPGqV7duwbygSi8=@lists.denx.de
X-Gm-Message-State: AOJu0YwrJH2eCwR94OdUxP5LYV1RrygPfxQy3txYGqhtohaBZSBQSIiB
 qtOvjm4ByxCpx7mXlcFmM2PuxSOHnPs97BJ8lFXY8N0ekHhDY7+kAu38bQ3oulMK/7jpTMxidPE
 OnjPRjAtAg6R1PJXeMaY1i/lImGXhIScdCJjK
X-Google-Smtp-Source: AGHT+IFeFMr3PTY9J4Bj/NciRTRN5GPN1scFwJyOOyUCB7C7WmvPC6z5cXtHc++gYRGonw8Mh0zFZ6B+nrIFrbbSsGM=
X-Received: by 2002:a05:6214:3b8a:b0:6c3:5833:260f with SMTP id
 6a1803df08f44-6cbf00ef202mr46601096d6.39.1728685097633; Fri, 11 Oct 2024
 15:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-9-sjg@chromium.org>
 <08596845-c0b1-4557-9993-cde57420560d@gmx.de>
In-Reply-To: <08596845-c0b1-4557-9993-cde57420560d@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 11 Oct 2024 16:18:07 -0600
Message-ID: <CAFLszTiGHhU3LgUu7bv-oYd3b-4Y5-OY=LZhTGcQ4vvpu80r2w@mail.gmail.com>
Subject: Re: [PATCH v6 08/12] efi_loader: Disable ANSI output for tests
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Mon, 30 Sept 2024 at 17:44, Heinrich Schuchardt <xypron.glpk@gmx.de> wro=
te:
>
> On 26.09.24 23:59, Simon Glass wrote:
> > We don't want ANSI characters written in tests since it is a pain to
> > check the output with ut_assert_nextline() et al.
> >
> > Provide a way to tests to request that ANSI characters not be sent.
> >
> > Add a proper function comment while we are here, to encourage others.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> Please, consider prior review before resubmitting patches.

I'm just coming back to this and trying one more time to resolve this probl=
em.

>
> As responded to all prior submissions:
>
> We want to test the code running on actual machines.
> We don't want to have sandbox code everywhere.

Who is 'we'? U-Boot features have to be designed for testing. It is
not a black box. We can and do have special code for sandbox in
U-Boot. We also have the ability to adjust how real boards run in
tests, e.g. collecting console output. The whole sandbox construct is
designed for testing and development.

>
> I cannot see any test that is not passing due to the current behavior.

This series includes a test which fails due to the unwanted ANSI
output. It is the last patch in this series.

>
> The size serial console is just requested once in the live-time of the
> U-Boot session.

When I use test.py with EFI it seems to happen quite a lot.

>
> You have bunches of options in your upcoming tests. Neither of these
> requires the suggested patch:
>
> * You can set stdout=3Dvidconsole,serial and let the vidconsole provide a
> screen size.

Do you mean manually change the default console and rebuild U-Boot?
That is not really relevant to the problem here, since I often
generally run tests without a video console.

> * You can add the ANSI sequence to your ut_assert_nextline() statement.

Yes, that is feasible, but very strange and brittle. I'll give this a
try for the next version.

> * You can filter out ANSI codes in the test framework.

Do you mean in the assert_nextline() functions, or in Python?

> * You can run an EFI command like 'printenv -e' before the command that
> you actually want to test.

How do I inject that command when running test.py?

I appreciate you taking the time to list some options. But the
approach here is just not right, unfortunately.

Here is another example. When I run EFI tests (e.g. test.py with '-k
efi') I get something like this after the tests finish:

^[[36;90R^[[36;90R^[[36;90R^[[36;90R^[[36;90R^[[36;90R^[[36;90R^[[36;90R^[[=
36;90R^[[36;90R^[[36;90R^[[36;90R=E2=9C=98

I have to clear it from my console, before I can do anything else. If
I press 'enter' I get:

bash: syntax error near unexpected token `;'

I really don't want this output. The problem is not about filtering
it, it is about not generating it in the first place. You can see this
appearing in CI also.

No other subsystem generates ANSI characters when U-Boot starts. Why
are we creating this problem in the EFI implementation?

So please, I very-much want to have a way to stop this output from
being generated, not to filter it afterwards. As above, we should
design U-Boot for easy testing, not treat it as a black box. Please do
seriously consider this as I believe this is an important testing
principle being violated here.

Regards,
Simon


>
> Best regards
>
> Heinrich
>
> > ---
> >
> > (no changes since v1)
> >
> >   include/efi_loader.h         | 21 ++++++++++++++++++++-
> >   lib/efi_loader/efi_console.c | 26 +++++++++++++++++---------
> >   2 files changed, 37 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index f84852e384f..82b90ee0f1d 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -531,8 +531,27 @@ efi_status_t efi_bootmgr_delete_boot_option(u16 bo=
ot_index);
> >   efi_status_t efi_bootmgr_run(void *fdt);
> >   /* search the boot option index in BootOrder */
> >   bool efi_search_bootorder(u16 *bootorder, efi_uintn_t num, u32 target=
, u32 *index);
> > -/* Set up console modes */
> > +
> > +/**
> > + * efi_setup_console_size() - update the mode table.
> > + *
> > + * By default the only mode available is 80x25. If the console has at =
least 50
> > + * lines, enable mode 80x50. If we can query the console size and it i=
s neither
> > + * 80x25 nor 80x50, set it as an additional mode.
> > + */
> >   void efi_setup_console_size(void);
> > +
> > +/**
> > + * efi_console_set_ansi() - Set whether ANSI characters should be emit=
ted
> > + *
> > + * These characters mess up tests which use ut_assert_nextline(). Call=
 this
> > + * function to tell efi_loader not to emit these characters when start=
ing up the
> > + * terminal
> > + *
> > + * @allow_ansi: Allow emitting ANSI characters
> > + */
> > +void efi_console_set_ansi(bool allow_ansi);
> > +
> >   /* Set up load options from environment variable */
> >   efi_status_t efi_env_set_load_options(efi_handle_t handle, const char=
 *env_var,
> >                                     u16 **load_options);
> > diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.=
c
> > index cea50c748aa..569fc9199bc 100644
> > --- a/lib/efi_loader/efi_console.c
> > +++ b/lib/efi_loader/efi_console.c
> > @@ -30,6 +30,17 @@ struct cout_mode {
> >
> >   __maybe_unused static struct efi_object uart_obj;
> >
> > +/*
> > + * suppress emission of ANSI codes for use by unit tests. Leave it as =
0 for the
> > + * default behaviour
> > + */
> > +static bool no_ansi;
> > +
> > +void efi_console_set_ansi(bool allow_ansi)
> > +{
> > +     no_ansi =3D !allow_ansi;
> > +}
> > +
> >   static struct cout_mode efi_cout_modes[] =3D {
> >       /* EFI Mode 0 is 80x25 and always present */
> >       {
> > @@ -348,13 +359,6 @@ static int __maybe_unused query_vidconsole(int *ro=
ws, int *cols)
> >       return 0;
> >   }
> >
> > -/**
> > - * efi_setup_console_size() - update the mode table.
> > - *
> > - * By default the only mode available is 80x25. If the console has at =
least 50
> > - * lines, enable mode 80x50. If we can query the console size and it i=
s neither
> > - * 80x25 nor 80x50, set it as an additional mode.
> > - */
> >   void efi_setup_console_size(void)
> >   {
> >       int rows =3D 25, cols =3D 80;
> > @@ -362,8 +366,12 @@ void efi_setup_console_size(void)
> >
> >       if (IS_ENABLED(CONFIG_VIDEO))
> >               ret =3D query_vidconsole(&rows, &cols);
> > -     if (ret)
> > -             ret =3D query_console_serial(&rows, &cols);
> > +     if (ret) {
> > +             if (no_ansi)
> > +                     ret =3D 0;
> > +             else
> > +                     ret =3D query_console_serial(&rows, &cols);
> > +     }
> >       if (ret)
> >               return;
> >
>
