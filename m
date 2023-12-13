Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE66C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33DC0875FC;
	Wed, 13 Dec 2023 21:19:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CB6MDPI7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDCA3875F5; Wed, 13 Dec 2023 21:19:14 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B55CB877E6
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:19:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-dbcd67d4c29so785725276.3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702498751; x=1703103551; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iI0cYIsLZxGyyP6T2W9fwLTxXsFiE7PalUjif5zY2dY=;
 b=CB6MDPI7US8OubMsLP7oyBOCQ5NXlN6tMNISodOqs2ndaXI5IWaw4MAwd2xhRRHgZ4
 8GzSsTPhBustFpwJGYhoLEYvz+VtlxvqPVxMTERIAxQ1JDZgVMNd/Khyg7p1NrCMiZ4d
 dADwAEpoHxYgjnSQDBu1AOfeMoCyD4R5VtbhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702498751; x=1703103551;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iI0cYIsLZxGyyP6T2W9fwLTxXsFiE7PalUjif5zY2dY=;
 b=Ns98JFE8QTV64wYMq3vcKBFnQxY6MC1UWBuvbbhSBhh7wUaK7obl1Zjv8ALPL5NVJ9
 lDxucqGlMiAF62EfyNHKBcc5XfUKm+VCQz3SybPgaLbj00QuljBWgQYO6ugn/66UDZec
 BHVwagQzMUfOZNp/7jPQgiVgnU0U4niXc06OiQJXgfRZ3pKBs1PTudQ0rhFNJvKUmzjM
 zqcE6xvMSk+FHcKbZizeXa9WI0mHMc6/mfRkeOkeKFZkO/xTpvtCsVu7f9MRbVrjqPnD
 bejjGRQ6l4OzvveYqDjtJ6u3dd+M6+/N7mCXX82n6KA44B/VwrpoUXG2lxg9f7Xhlrer
 Mqeg==
X-Gm-Message-State: AOJu0YyH2cFRYcqKt6l07Ob5lqXaoLlCi4UQ1fZ/l5XTS3lQrAf4vR1t
 70/l17c9mgAhyhFcQguUW+Ex4XAwcKgEn0yjaKs=
X-Google-Smtp-Source: AGHT+IEW4e3AkpXhNLbRki4oFEZ0Gq85ydRqyMjz+tZ/Gz4ypUq/J08a2mKHy0IQ9m5QaebLKkpxDQ==
X-Received: by 2002:a25:903:0:b0:dbc:dbc2:16bd with SMTP id
 3-20020a250903000000b00dbcdbc216bdmr794615ybj.62.1702498751457; 
 Wed, 13 Dec 2023 12:19:11 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d78a-ada8-3cce-fa3d.res6.spectrum.com.
 [2603:6081:7b00:6400:d78a:ada8:3cce:fa3d])
 by smtp.gmail.com with ESMTPSA id
 p135-20020a25d88d000000b00dbccd3a2d02sm826381ybg.55.2023.12.13.12.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 12:19:10 -0800 (PST)
Date: Wed, 13 Dec 2023 15:19:09 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, sean.anderson@seco.com,
 neil.armstrong@linaro.org, heinrich.schuchardt@canonical.com,
 mark.kettenis@xs4all.nl, Peter Robinson <pbrobinson@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 2/2 v2] smbios: Fallback to the default DT if sysinfo
 nodes are missing
Message-ID: <20231213201909.GG2513409@bill-the-cat>
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
 <20231127171058.165777-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2PtQQ81x-SqMs6NKSjMKFGShT65Rrtfc-CDOsdBxgJDQ@mail.gmail.com>
 <CAC_iWjJ52eK-v30T6XC1jHDDLvcuOX0p43PW8UCfakRPxMkQCw@mail.gmail.com>
 <CAPnjgZ2Ubr6kNfn+7bg+F_CV4H_wZMKaPq8F8njSfQNUF02+iA@mail.gmail.com>
 <CAC_iWj+X9Kw=1YOX0bny01JwkzCSyeZ6PB2-r_V-2TisgVG7WQ@mail.gmail.com>
 <20231209184915.GY2513409@bill-the-cat>
 <CAC_iWjKKG50d5QhUZFLUgxqO+VhgE7bC9Tk_SmCR0x4f3zD74g@mail.gmail.com>
 <CAPnjgZ27G=6fDadAiJk_aG9He2ZpyFhhsZDYxUwEp5+0AQatYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RJdNxQ88N76YCsp/"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ27G=6fDadAiJk_aG9He2ZpyFhhsZDYxUwEp5+0AQatYg@mail.gmail.com>
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


--RJdNxQ88N76YCsp/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 12:50:03PM -0700, Simon Glass wrote:
> Hi Ilias,
>=20
> On Mon, 11 Dec 2023 at 00:49, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Tom,
> >
> > On Sat, 9 Dec 2023 at 20:49, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Dec 06, 2023 at 06:03:14PM +0200, Ilias Apalodimas wrote:
> > > > Hi Simon,
> > > >
> > > > On Sat, 2 Dec 2023 at 20:28, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Ilias,
> > > > >
> > > > > On Wed, 29 Nov 2023 at 23:50, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > >> > Changes since v1:
> > > > > >> > - Tokenize the DT node entry and use the appropriate value i=
nstead of
> > > > > >> >   the entire string
> > > > > >> > - Removed Peters tested/reviewed-by tags due to the above
> > > > > >> >  lib/smbios.c | 94 +++++++++++++++++++++++++++++++++++++++++=
++++++++---
> > > > > >> >  1 file changed, 90 insertions(+), 4 deletions(-)
> > > > > >> >
> > > > > >>
> > > > > >> Can this be put behind a Kconfig? It adds quite a bit of code =
which
> > > > > >> punishes those boards which do the right thing.
> > > > > >
> > > > > >
> > > > > > Sure but OTOH the code increase should be really minimal. But I=
 don't mind I can add a Kconfig
> > > > > >
> > > > > >>
> > > > > >> > +
> > > > > >> > +       dt_str =3D ofnode_read_string(ofnode_root(), nprop->=
dt_str);
> > > > > >>
> > > > > >> Could this use ofnode_read_string_index() ?
> > > > > >
> > > > > >
> > > > > > Maybe, I'll have a look and change it if that works
> > > >
> > > > Unless I am missing something this doesn't work.
> > > > This is designed to return a string index from a DT property that's=
 defined as
> > > > foo_property =3D "value1", "value2" isn't it?
> > > >
> > > > The code above is trying to read an existing property (e.g compatib=
le)
> > > > and get the string after the comma delimiter.
> > > > Perhaps I should add this in drivers/core/ofnode.c instead?
> > > >
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > >>
> > > > > >> Any chance of a test for this code?
> > > > > >
> > > > > >
> > > > > > Sure, but any suggestions on where to add the test?
> > > > > > SMBIOS tables are populated on OS booting, do we have a test so=
mewhere that boots an OS?
> > > > >
> > > > > They are written on startup, right? They should certainly be in p=
lace
> > > > > before U-Boot enters the command line.
> > > >
> > > > Not always.  I am not sure if x86 does that, but on the rest of the
> > > > architectures, they are only initialized when the efi smbios code
> > > > runs. Wasn't this something you were trying to change?
> > >
> > > One of those things I keep repeating is that we don't know for sure w=
hat
> > > the right values here are until we load the DT the OS _will_ use. It's
> > > quite valid to start U-Boot and pass it a generic "good enough" DT at
> > > run time until U-Boot can see (GPIOs, EEPROM, whatever) what it's on =
and
> > > what the real DT to load before passing to the OS is. Since U-Boot
> > > doesn't need SMBIOS tables itself, we should make these "late" not
> > > "early".
> >
> > Fair enough, we can defer the init and testing of those late, just
> > before we are about to boot. But this is irrelevant to what this patch
> > does, can we get the fallback mechanism in first, assuming everyone is
> > ok with the patch now?
> >
>=20
> I would like this behind a Kconfig. Making it the default means people
> are going to start relying on (in user space) and then discover later
> that it is wrong.

What do you mean wrong, exactly?

--=20
Tom

--RJdNxQ88N76YCsp/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV6Eb0ACgkQFHw5/5Y0
tyyXzgwAq897A0ZKrfsPLGQ86CLKJg8RnCjHB4ITSs4T+zq8qhlO/GTGKJ9aF70Q
DeBQKoxu+suCWD9oB7gPWjYPCu07YC1GYQZF64XqyN69aNeme5gFeDPLdEWw41xP
xN0rJFfR+YfKSkxMkRrV6b10XzPdLT4PZKTIg+HAdrqBz64snV/757PhkF4vaixw
WA78waDu26Z1PvDhBdvpb33J0eNNq4rJ38P6g3DhHdyxPy02o+S+AQVBmpmQPqjO
SsPnE2sFmtRqbYmqGrziFxayplUpx4+cNoi/C8rlYkIPTVWZWq8riS9j/5pUCiSP
O1tS+hhNkuvURHS/nOdSkkHURvamEr6eaaa1oFGJNlVXUS8HNI6y7HKnWpwk+pKv
VndjJlka5gLBaqrKN39fGVEwojOix9tJzQmI0Y8QeEOcgWylev6MTanqrUJykcVE
AhV510niCAPuL1Yv6e56tLGGHvBiQb5RXYf6fG+Vba8JHhRF+MWGb3FFKgwLN8rn
I0/q+bT+
=bgpF
-----END PGP SIGNATURE-----

--RJdNxQ88N76YCsp/--
