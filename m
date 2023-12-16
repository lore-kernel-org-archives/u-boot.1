Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A772BC41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 22:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D055F87C4A;
	Sat, 16 Dec 2023 23:14:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gJOBW7NR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4078087C5D; Sat, 16 Dec 2023 23:14:28 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C525876C4
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 23:14:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5e4b6353482so11234547b3.1
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 14:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702764865; x=1703369665; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dwx4Jz9D6gpu7/uAXJ75+jJpGmht71u1ybWu7OLjkXw=;
 b=gJOBW7NRSqwldzk20CnW8o+U/9jHlXkiZwLdpfTgy21S/o3/+EScH+g0Qdi7JazWXi
 OTrpZUBrZCNnlQbPX5ssdb2WtgqOUmTa2UR257T9g1EJl6/w0Vsd61By36mlGKQTbMPy
 eTuvEpBylRKA0Ix0AB+wJfBRKzDUXSSrWr3z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702764865; x=1703369665;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dwx4Jz9D6gpu7/uAXJ75+jJpGmht71u1ybWu7OLjkXw=;
 b=wfcWslLPKJPv94Ys9NElqFyjG+vhj/ubOCiR2rn4msjMEujALEmSC6Wqi4QDtZgHH3
 JQF8Fi9zbMIMErjgEx6VYG/Z9s5HED9XVeQKXFx7CBZdR/ITH/tvx4gT1U2k+Bx+CSM6
 HHyzvKzdY3oDqwovc8nzZM6ICfmawO11lz2FfrwcgCJPWk37nIdzwwrROOxSuaBh0d7D
 ZFKLrVgpukcwHTo23lCieIgrc3lVgOejAOxOHa/7NW6e9OKJsjTIE/S9NCdYoKfR1mOY
 FfOlCrRRuenR8ckO26G9i9HS8ARFNYfS55Go1R5pzhGOS/GhIY3wemg80Vnz7h3ENl/W
 eY/Q==
X-Gm-Message-State: AOJu0YwlGWDJxP/eeQoq6DC3oS90TuddJxBMyI/5iW3t4oPzIYU/ONcQ
 TVIWySf/Ji/bQsaArGf5QdOK1xBZ5YuoJ51pFHA=
X-Google-Smtp-Source: AGHT+IE/FNSD/q++U2kiza83RXcVxlS495Vr2KWB7k22qYpctyh4ifVWIYWebogOjSHtOB+a7RnMQA==
X-Received: by 2002:a0d:e2c7:0:b0:5d7:1a33:5ae3 with SMTP id
 l190-20020a0de2c7000000b005d71a335ae3mr9651155ywe.48.1702764864732; 
 Sat, 16 Dec 2023 14:14:24 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c7d6-a760-1f4b-e321.res6.spectrum.com.
 [2603:6081:7b00:6400:c7d6:a760:1f4b:e321])
 by smtp.gmail.com with ESMTPSA id
 e3-20020a0dc203000000b005c5a08c5c15sm7441780ywd.136.2023.12.16.14.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 14:14:23 -0800 (PST)
Date: Sat, 16 Dec 2023 17:14:20 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 3/3] efi: Avoid using dm_scan_other()
Message-ID: <20231216221420.GA2513409@bill-the-cat>
References: <20231112205516.183410-1-sjg@chromium.org>
 <20231112205516.183410-4-sjg@chromium.org>
 <082aeedd-4371-4ba4-a29a-bf0f0730b77b@gmx.de>
 <20231121132110.GQ2513409@bill-the-cat>
 <CAPnjgZ30CjQZ0+DMp2gy0HzrnRsjcY5NMi1YVVRQiN8UG-5oBg@mail.gmail.com>
 <c8f1c7cf-346f-42b4-9652-69476e763d5f@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sOaPDKmLNxbclQ9Z"
Content-Disposition: inline
In-Reply-To: <c8f1c7cf-346f-42b4-9652-69476e763d5f@gmx.de>
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


--sOaPDKmLNxbclQ9Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 09:57:41PM +0100, Heinrich Schuchardt wrote:
> On 12/16/23 21:46, Simon Glass wrote:
> > Hi,
> >=20
> > On Tue, 21 Nov 2023 at 06:21, Tom Rini <trini@konsulko.com> wrote:
> > >=20
> > > On Tue, Nov 21, 2023 at 01:18:09PM +0100, Heinrich Schuchardt wrote:
> > > > On 11/12/23 21:55, Simon Glass wrote:
> > > > > This function is defined by bootstd so using it precludes using t=
hat
> > > > > feature. Use the board_early_init_r() feature instead.
> > > > >=20
> > > > > This requires moving quite a lot of code into the board directory=
, butt
> > > > > this is the normal place for code called by board_early_init_r()
> > > > >=20
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >=20
> > > > > Changes in v2:
> > > > > - Drop duplicate acpi_xsdt patch
> > > > > - Put the board_early_init_r code into board/
> > > > >=20
> > > > >    board/efi/efi-x86_app/Makefile  |   5 +
> > > > >    board/efi/efi-x86_app/efi_app.c | 205 ++++++++++++++++++++++++=
++++++++
> > > >=20
> > > > Our target should be to enable building the EFI app on all architec=
tures.
> > > >=20
> > > > Only x86 specific code should be added to board/efi/efi-x86_app/efi=
_app.c.
> > >=20
> > > A later enhancement to make U-Boot as an EFI app more generic would be
> > > good, but outside the scope of this patch which is moving generic code
> > > out from "lib" and in to "board".
>=20
> I cannot see that this patch is moving any code our of lib/.
>=20
> But why should we move generic code into board?
>=20
> >=20
> > This patch was marked as old /archived in patchwork so has been
> > forgotten. I have marked it new and non-archived in the hope that it
> > can be applied to -master soon.
>=20
> There is nothing x86 specific about the code. Generic code should be in
> lib/. Please, provide a new version of the patch.

It's not generic EFI code, it's generic "U-Boot as EFI application" code
and so the whole "board" needs a bit of a clean and re-work as we all
agree that there shouldn't be anything architecture specific about it,
only building the binary for the correct architecture. However, we just
aren't well structured to support that right now. Where on the list of
priorities does that have to fall rather than just allowing for
functionality to be tested / used? There's not yet IIRC efi-arm64_app
but what we have today (and would have had with Simon's patch) should
have just built and worked.

--=20
Tom

--sOaPDKmLNxbclQ9Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV+ITkACgkQFHw5/5Y0
tyyJXAv6Ah+Q0BdlfStbcsQzdiljyaUS15NnJGUBJh5yfQYwopE2xuDOcS6eJgO2
ZWL4GtFLd5U9oIR3C7s8imru6MnNuqSBP+TRQtfnlpSD15Le0XPdvmaCnTzvHRPm
r6zlqog3YNZqQY1OqXZpPQmJ0oFqL5tU3uv35Mxn+3QNdTlHDOuCmKaXLlZ68R2M
m/4bkrHbBSFnFn4GmjKgCgvxwDBure3LRQN7yx7SxP7BTKoiia0ngAAHbm0mRQ8H
Xax0QlwSi0Jcoc+baplVLKAp+qKl9MMWXqftSBQTkgsRC5oK1ZHr83MuJMyrS0+R
uemndHahP0/vZHuhYrI1evZbvQTqI1XEzdFiYjs4Rkp8F60sfz1iFqaGj2/qi+8O
NSe7hDMltJFiLlhwdyJqGbEzwXsKCryXES0T8dslUrqgNPRoUL6tHtqRJX12a0Rb
wviRfIRwjZzxRVLNxjOu5NnX5fx9QQukFOwy4fprN5autmeTowr8OFr4nyDsCYW6
/T3e5gIY
=qON0
-----END PGP SIGNATURE-----

--sOaPDKmLNxbclQ9Z--
