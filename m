Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1DFD216AD
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 14:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 725068837D;
	Tue, 15 Oct 2024 16:16:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OhwyqKhy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1546C88387; Tue, 15 Oct 2024 16:16:46 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24D0C87F19
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 16:16:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cbe700dcc3so41968686d6.3
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 07:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729001802; x=1729606602; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JwghM59ba/0hJ3UzaxyIqz6My7MFik4Q1y6mOAOQsVU=;
 b=OhwyqKhyi97UUAnKXLch4y1DAKO3tuz7Nnls+elhhGdT1Z0tGHfbFdxzOnigbP02WG
 LevTVF+Zdp/TKTAQySQppON84W0Ccyjb6+DmC3LbH/WOK1PKgILnggu4uE1Gzkfi1ByL
 Mc/7IIDWvQ9lkM7hJME8mtpLYabQ/0dH+86Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001802; x=1729606602;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JwghM59ba/0hJ3UzaxyIqz6My7MFik4Q1y6mOAOQsVU=;
 b=cGMXww51Jf+BHoogrbJDdF/y8ozefObGmDyuTI2Qm0RLsJbvkWKwAmzOatoFP1T627
 Xd4BCW8Pytevxw6vc8ehLJ96umvsT1M+NnSo9P9Z3z6ktqYh+sTFHNRQGuyyOvMMN4DH
 rbATPWC/QWzwQKlDjSL0DFPYWTetuh2xKXOvr/YEFh9OOjIGO5KnUh9RLaHd9YgjCkr6
 4BqmP7JojrI3gt21mFmBg7eiod8Reg+x5ublbGfxtwwhVQeovDF4Lpb0FyEA1JLusHIW
 Ltd5tRAIAEAtRiLrLr6fni8shcTTRM/NKapfDQZdyoHH7zHhDE91Tf/iolcmPgl8qgtg
 AKOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp1CejUijqP6DV2iocHNzTqqpxVEnHVoLail0qvN8Cdxm/OiJePP5449KukABsVOsz3i/YDQc=@lists.denx.de
X-Gm-Message-State: AOJu0Yzxg/ntX3rpYJBGXXxgGUTKopNKa8puveb3OCUK0Hk3lfRYRxgl
 zy+Mh8mnFG0wADVstuGvu0XUnErtfaPlTSQAmjhACdqr0UYKy9CVI4P1v8yu0Tc=
X-Google-Smtp-Source: AGHT+IECYZ8jEOyNjfOo7v2ntBHyh3jZeaYenWNDpB+i/bm1yRYvi1SkFqWa6aL3zndnpAJKjepmTg==
X-Received: by 2002:a05:6214:311c:b0:6cb:ef96:c79e with SMTP id
 6a1803df08f44-6cc2b919931mr7009476d6.34.1729001801862; 
 Tue, 15 Oct 2024 07:16:41 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc2290fa66sm7017986d6.26.2024.10.15.07.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:16:40 -0700 (PDT)
Date: Tue, 15 Oct 2024 08:16:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH v6 12/12] test: efi: boot: Add a test for the efi bootmeth
Message-ID: <20241015141636.GL53053@bill-the-cat>
References: <20240926220226.1265965-9-sjg@chromium.org>
 <20240926220226.1265965-13-sjg@chromium.org>
 <20241011223227.GA630742@bill-the-cat>
 <CAFLszTgoxND_qi8WzdgC8-mQLf0e14Mt=KgXy=bqWkqo4svG9Q@mail.gmail.com>
 <20241014035122.GE53053@bill-the-cat>
 <CAFLszTiVsoTdKiKmPVugc9cLk-A+XM2EdiPUE0AFK=g8RPx+0g@mail.gmail.com>
 <20241014211150.GX53053@bill-the-cat>
 <87cyk1hdne.fsf@bloch.sibelius.xs4all.nl>
 <23757cf3-c27a-498d-9e66-59261f060102@gmx.de>
 <CAFLszTikKJ29TEzCQHBL1JfYz4b+O0eVps2Aa9_pMuwHBZgByA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FD3Otjqrw2jlZ1ok"
Content-Disposition: inline
In-Reply-To: <CAFLszTikKJ29TEzCQHBL1JfYz4b+O0eVps2Aa9_pMuwHBZgByA@mail.gmail.com>
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


--FD3Otjqrw2jlZ1ok
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 07:25:55AM -0600, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Tue, 15 Oct 2024 at 05:36, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
> >
> > On 15.10.24 12:19, Mark Kettenis wrote:
> > >> Date: Mon, 14 Oct 2024 15:11:50 -0600
> > >> From: Tom Rini <trini@konsulko.com>
> > >>
> > >> On Mon, Oct 14, 2024 at 01:13:41PM -0600, Simon Glass wrote:
> > >>
> > >> [snip]
> > >>> Or perhaps just have a way to turn it off? I first sent this patch
> > >>> last November. It is just wrong to generate output like this which =
we
> > >>> don't want. There isn't even a test for it, so just add a way to
> > >>> disable it, and be done!
> > >>
> > >> I don't know that it's unwanted. As I'm trying to get Heinrich to
> > >> explain, _why_ does efi_setup_console_size need to exist, and do wha=
t it
> > >> does? This isn't the case of color-coding the output of tests as they
> > >> happen, there must be a reason we care about knowing the console siz=
e.
> > >> At that point we can figure out if the right answer is:
> > >> - Don't generate that check on serial ports, it's somewhere between
> > >>    misleading to wrong.
> > >> - text-based tests just need to expect and skip it because there's a
> > >>    good reason to need to know the console size and not just assume
> > >>    80x24.
> > >> - Something else we won't know until it's clearly explained why we do
> > >>    this.
> > >
> > > Sadly this is a misfeature of UEFI.  The EFI_SIMPLE_TEXT_OUTPUT_PROTO=
COL
> > > is required if console devices are supported by the UEFI
> > > implementation, and is built around the concept of "text mode" with a
> > > fixed number of character rows and columns.  That pretty much assumes
> > > there is some sort of terminal emulator on the other end.  And this is
> > > pretty much incompatible with anything that just want to log serial
> > > output.
> > >
> > > I think it is possible to do better though.  Instead of calling
> > > efi_setup_console_size() in efi_init_obj_list(), we could postpone
> > > this until the application makes a call that requires us to know the
> > > size.  This would mean that a simple EFI application that just uses
> > > EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.OutputString() (such as the Hello
> > > world EFI application or the OpenBSD EFI bootloader) wouldn't have to
> > > do the size query.
> >
> > The implementation of EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.OutputString()
> > needs to know the output size to update the cursor position in
> >
> >    EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.MODE.CursorColumn
> >    EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.MODE.CursorRow
> >
> > The EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL is passed to the entry point of any
> > EFI application via the system table.
> >
> > We could delay the invocation of efi_setup_console_size() to the launch
> > of the first EFI application (efi_start_image()).

This discussion I believe should continue as it does sound like we can
be a bit better about when we do this required series of events.

> That's a start, but I think the right answer here is to use my flag
> and in efi_setup_console_size() don't call query_console_serial() if
> the flag is set. Then the default (80x25) will be returned, which is
> fine for the test which is the subject of this series.

No, your series, like other tests that already exist and have this
escape code printed, should just swallow the escape sequence if it shows
up because, sadly, there is reason for it. I wonder if we should have
some test _for_ this sequence, or otherwise make sure we see it when we
should see it?

--=20
Tom

--FD3Otjqrw2jlZ1ok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcOeUEACgkQFHw5/5Y0
tyztXAwAgTWW36GKlrfkV84tbGT5Q+ipcaN5JRbBJTM108l/m6f6EVIBq7Dwav/W
kxMFdtphPxbMBsv+DZVfDbbwUwwARJz+8NSEy0wmeDdbN5RvAP8TwNV+0xtom6XF
nBjvxHnVK/ELelNxx6IyUuQAqC0XtmPRzCzFeg/SdfGg36htT32EFt8MG+br8kM6
IW4o24x7AAtjUaDsWcarkqHT5cH8xgIIEsiUbUMerT/KYboVn+O9ET+NTvMqoon2
xFEY5o9DgW6hAMAVSKs+yS5CrmDYMEOKCwjSFliCVkeSw642Twxf0k4Rb4j3GXs0
XmXTQb+b50ZlAl7c+s0kobZnuGwmEXKCM8O2dUc++ANwZHa1SeWWl3nqiqOVcWZL
CMqYDP6+Lop0bEl+1kKPt9UImMYSq/zM/f8gqfNJIK5atbnsC3+XHT74yU6s5kCK
aJXabuYo9We8fbtfGVNYUWXvtfdSuU8T7LQFO+luTUCsmj42rsEkB60XVWn6eJKA
3KpLXIGl
=duK0
-----END PGP SIGNATURE-----

--FD3Otjqrw2jlZ1ok--
