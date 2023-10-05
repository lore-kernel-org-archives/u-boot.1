Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45983E92705
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 14:49:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B806F86D05;
	Thu,  5 Oct 2023 16:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jVfcMHX5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3079C86CB7; Thu,  5 Oct 2023 16:49:27 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A883886D05
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 16:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-59f1dff5298so12509327b3.3
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696517357; x=1697122157; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QENklI1xjayfOZIhbHC33rtEWEmkkJrw+GHSU/nOYo8=;
 b=jVfcMHX52zjR3tWQHKf7Uy9GuDwz992C4phM1rp6cUqVwTlFJFknBk77RuB+uej4u1
 LwlO9Oi9rhjkWFwD97weZfUAIqe36XetvXIUqcJgZq311x7FYnoKSxlmVGIeqDrIBZa+
 /GZCpL42DX7CWSOx6xnixSH+EuqtbWtKaX6hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696517357; x=1697122157;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QENklI1xjayfOZIhbHC33rtEWEmkkJrw+GHSU/nOYo8=;
 b=DGF2uiy+x4yKbGt/7g/cxHEOLDCbTQ7TI8z4DiYzeQYpDdeT3bSo6VcMwPDm62w88T
 MjtT0Ai9LOyTAG+M6b+yY0TCYVU0uzqmH+5+yz55ak0myYkewu4Oco9aXGDFDIOG3aK7
 p4JlLZ6j7EQ4dOJMEkuoGhG/JnOhE977cHoX7X65O/TcTSNQoAu0yDTu12qX9dvokUWn
 RAJkok75o1OA/9kLXjwNIY6j2jt+UnuyI7aD7cEoq7sRMTw6QMJ+qSiPH3+LFSHV8n6m
 tlx6KaqBV3+5DecWA88NeF1zHofstJBL7OsNcJuZ/g6OVdJ7uQ5VXsO7oZJIN4R8h7Jo
 ja7w==
X-Gm-Message-State: AOJu0YzYwEHVuMxZIkMG8riH3WK0Vovv4TbJSmvi9A4HLclvhuYgSzDm
 qKR3ID6Rbm6+ks8VGoz9VKDK7ACyXqvimaAuwKAZ3A==
X-Google-Smtp-Source: AGHT+IHsLOeNa5ZmF/gauZ329i/YEcYPoTZl6iA3kr1/LLgxbLc2ghGljTWVaUbXRWY/cJVorvhfHg==
X-Received: by 2002:a0d:e888:0:b0:595:9770:6914 with SMTP id
 r130-20020a0de888000000b0059597706914mr5212233ywe.35.1696517357394; 
 Thu, 05 Oct 2023 07:49:17 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-f1fa-53fc-3572-fce8.res6.spectrum.com.
 [2603:6081:7b00:6400:f1fa:53fc:3572:fce8])
 by smtp.gmail.com with ESMTPSA id
 d203-20020a814fd4000000b005922c29c025sm538288ywb.108.2023.10.05.07.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 07:49:16 -0700 (PDT)
Date: Thu, 5 Oct 2023 10:49:15 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 03/25] autoboot: Correct dependencies on CMDLINE
Message-ID: <20231005144915.GK8465@bill-the-cat>
References: <20230924203953.1829820-1-sjg@chromium.org>
 <20230924203953.1829820-4-sjg@chromium.org>
 <20230925003959.GO305624@bill-the-cat>
 <CAPnjgZ1Mxf_1G0-q0mLTehO2gZriaKWH7VfW5J9H_g-Y3u16_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5JlPu7M/LvGkUi7D"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1Mxf_1G0-q0mLTehO2gZriaKWH7VfW5J9H_g-Y3u16_A@mail.gmail.com>
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


--5JlPu7M/LvGkUi7D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2023 at 08:11:11PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 24 Sept 2023 at 18:40, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Sep 24, 2023 at 02:39:21PM -0600, Simon Glass wrote:
> >
> > > Make AUTOBOOT depend on CMDLINE since it is mostly meaningless withou=
t it.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  boot/Kconfig | 23 ++++++++++++++---------
> > >  1 file changed, 14 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > index f74ac7e9cc72..41ec2c34bf74 100644
> > > --- a/boot/Kconfig
> > > +++ b/boot/Kconfig
> > > @@ -1167,14 +1167,16 @@ menu "Autoboot options"
> > >
> > >  config AUTOBOOT
> > >       bool "Autoboot"
> > > +     depends on CMDLINE
> > >       default y
> > >       help
> > >         This enables the autoboot.  See doc/README.autoboot for detai=
l.
> >
> > This is fine and correct.
> >
> > > +if AUTOBOOT
> > > +
> > >  config BOOTDELAY
> > >       int "delay in seconds before automatically booting"
> > >       default 2
> > > -     depends on AUTOBOOT
> > [snip]
> > > @@ -1322,6 +1324,9 @@ config AUTOBOOT_STOP_STR_SHA256
> > >         includes a ":", the portion prior to the ":" will be treated
> > >         as a salt value.
> > >
> > > +endif  # AUTOBOOT_KEYED
> > > +endif  # AUTOBOOT
> >
> > So it's ~200 lines, yes, hiding this under an if, or perhaps a menu
> > makes sense, however...
> >
> > >  config AUTOBOOT_USE_MENUKEY
> > >       bool "Allow a specify key to run a menu from the environment"
> > >       depends on !AUTOBOOT_KEYED
> >
> > It looks like there's more stuff to move under a menu/if here?
>=20
> Well this depends on !AUTOBOOT_KEYED so can't be in the 'if
> AUTOBOOT_KEYED'. But yes I can create a new 'if !AUTOBOOT_KEYED' for
> these two items. Normally we want 2-3 options to warrant an 'if', so I
> don't see this as a strong case.

Well, sometimes it seems like we abuse the "if" mechanic too.  It's not
short-hand for "avoid saying depends on" a few times, it's "hide these
things until we turn on another feature".=20

But right here it looks like AUTOBOOT_USE_MENUKEY still needs to be
under "if AUTOBOOT" yes?

--=20
Tom

--5JlPu7M/LvGkUi7D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUezOsACgkQFHw5/5Y0
tyxTfAwApZKK+uk1iFV3cS2C7IVZzHMl/8jsNRkSAYRnWkd9LqLjxkcghDfo3Qj3
+6aVYiVv2fpAVIGQDLA5aXEb04lCDkYLrR3048rtXCIY7JDl471/8MPNz5L0Ljhf
XXi20d7dpwFaQZl/4D2y+vqYVzdOe5Be3wxCMP9FEA9mL7XHYmPP/TvtPe88DaQD
35AQ86egDbQnSDm/6aCwimsYQVQFHf5v2tpZljmCVx5os8a5/u2G0Jl8W7XkXhcy
Kfu/GqNUTnGXkXznkhAi3oluBFWcMYBxAm3sBWf72k6NmPzTTXIQFJK/wF4DVmmm
Jh0h+Hb2+6O82BRD4dyNRuTKxWZFS23CeItJgmT7lsiImiA7ajcPPdREQQJClRcf
s5Iez+j0ykxXQdBH7PngouEFyur7YIA8GXGlsRkQtJlBXvu7TW/sldNEF90GtwxM
kQa2KhOaf0T6CNq+UPznWMASFNmc1bVfrISop0SfLkCYVdjVIi4iCIUWKktGqBDN
Qp/6l2h2
=cL3F
-----END PGP SIGNATURE-----

--5JlPu7M/LvGkUi7D--
