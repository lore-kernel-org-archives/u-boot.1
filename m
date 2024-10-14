Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00338D18157
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 23:07:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 410FB89211;
	Tue, 15 Oct 2024 01:07:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QlOHO89/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DC0E89211; Tue, 15 Oct 2024 01:07:35 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC4B388DFD
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 01:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b11704601cso396857585a.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 16:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728947251; x=1729552051; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v6W5bwYF+kp4ZHMp7cqrN3C+GBQxlKrFH/Dg0hznR1c=;
 b=QlOHO89/O6wgfoxyXqnueld/YDwOFpsATR0gpY1WM+yzQAv91ZtiLN14Ajips1vQ3t
 2r5+xDVyv8xnED5I6UDiaTyXHuj9HrD+kdCSVZwqAB7t/W20DNayCibfnkoW/pYoDZOD
 /MG8KfMR0SXSO7kGpc0Z/ypoSRkRwn2vu8NnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728947251; x=1729552051;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6W5bwYF+kp4ZHMp7cqrN3C+GBQxlKrFH/Dg0hznR1c=;
 b=sdbByF/tey2F17VgB20AIFgr3xEeKLxtn94PVBMePpWvfk0XcThxKBgq0+MNpXzsQT
 y7ryiWW+WwNtOEYi4f4G4ZhM4bqELqaf/lpAKRa3E9ZwcUkHSwhuNHh//6LbWurwxCA4
 LFAQSTxcHoNcqBMeG7b/M2gzw/sg79vfHXLb4TZPQEVgWWkUog6Rf7394RSE0dmvDAgU
 1hA+5YR3YmeQyiV5065xcvm6oKoB8CGD4gtIHjroS4uSB77A4rdKWs7oWIr2gRGcxWzr
 bHODYk5n18t5VUM4eqG1Bwfo9qAtztO5/NJEgBajl5e4eVbgH0P9CsonhD5U2zHmpsbx
 6h1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyqhySLswfctMpOqsme/yzqtMrj/MTZSkfqB6f52ItEfog/52w5zXxMWJ10Umbs9qf7uOD9pw=@lists.denx.de
X-Gm-Message-State: AOJu0YwkxeysyF/Z4oxR1ve976nSWdtbzCiZVaxBvBezZP1KZf1K4zO5
 ptOKIijYjpTCuogfM3KkNeupd7xj8a8irMncOADaXaq7tN8xDB26wvXQFPbNfbo8/0V6mG/g9+7
 MdnM=
X-Google-Smtp-Source: AGHT+IFCrV7FPF0Cme1ZpLOYeIBBmNqa2mUcPYkHRkdj8lY9EcjaT9TyYx5jDpBVZn/nDYQF/T8kOQ==
X-Received: by 2002:a05:620a:1922:b0:7a9:aeb3:4b22 with SMTP id
 af79cd13be357-7b120faa814mr1869297285a.6.1728947251404; 
 Mon, 14 Oct 2024 16:07:31 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1363b3f1asm4003885a.118.2024.10.14.16.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 16:07:30 -0700 (PDT)
Date: Mon, 14 Oct 2024 17:07:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v3 03/15] efi: memory: use the lmb API's for allocating
 and freeing memory
Message-ID: <20241014230725.GH53053@bill-the-cat>
References: <20241013105522.391414-4-sughosh.ganu@linaro.org>
 <CAFLszTiov914NOS9_5UU4oLi0fCQ84a-Et82BeSEJbts4MEOVQ@mail.gmail.com>
 <20241014155642.GO53053@bill-the-cat>
 <CAFLszThVP_OgyTt_ksJ1_7HAHT+K-wcixWB+k+fmzAjh6+5Bmg@mail.gmail.com>
 <20241014210453.GU53053@bill-the-cat>
 <CAFLszTgm=t=y1kj7Ju5Ls7nf0ghLCqRppVnY7yorD6v1hoeN1g@mail.gmail.com>
 <20241014212718.GZ53053@bill-the-cat>
 <CAFLszTiW_N-DvivnC_Fq4LWv+H+S2h8A-8o5dXPtGMsii1ToxQ@mail.gmail.com>
 <20241014214841.GD53053@bill-the-cat>
 <CAFLszThxdPd7ty2=X66ZRWopzE0R1ChhdRZzah5tYLS+FvZ-Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XUrbc5xVkWoFxETt"
Content-Disposition: inline
In-Reply-To: <CAFLszThxdPd7ty2=X66ZRWopzE0R1ChhdRZzah5tYLS+FvZ-Jg@mail.gmail.com>
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


--XUrbc5xVkWoFxETt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 03:55:05PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 14 Oct 2024 at 15:48, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 14, 2024 at 03:35:12PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 14 Oct 2024 at 15:27, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Oct 14, 2024 at 03:13:01PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 14 Oct 2024 at 15:04, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Mon, Oct 14, 2024 at 01:13:17PM -0600, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Mon, 14 Oct 2024 at 09:56, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Mon, Oct 14, 2024 at 09:50:37AM -0600, Simon Glass wrote:
> > > > > > > > > Hi Sughosh,
> > > > > > > > >
> > > > > > > > > On Sun, 13 Oct 2024 at 04:55, Sughosh Ganu <sughosh.ganu@=
linaro.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Use the LMB API's for allocating and freeing up memory.=
 With this, the
> > > > > > > > > > LMB module becomes the common backend for managing non =
U-Boot image
> > > > > > > > > > memory that might be requested by other modules.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > > > > > ---
> > > > > > > > > > Changes since V2:
> > > > > > > > > > * Use map_to_sysmem() to get the user-visible address t=
o be shared
> > > > > > > > > >   with the lmb API's for sandbox.
> > > > > > > > > >
> > > > > > > > > >  lib/efi_loader/Kconfig      |  1 +
> > > > > > > > > >  lib/efi_loader/efi_memory.c | 77 +++++++++++----------=
----------------
> > > > > > > > > >  2 files changed, 24 insertions(+), 54 deletions(-)
> > > > > > > > >
> > > > > > > > > When efi_init_obj() is called, it should be able to add t=
he lmb memory
> > > > > > > > > to its own tables. There is no need to worry about lmb af=
ter that,
> > > >
> > > > Saying "There is no need to worry about lmb after that" is not true.
> > > > Invoking the "env" command for example will have efi_init_obj() be
> > > > called, among the others that Heinrich listed. And to possibly refu=
te
> > > > a next issue, that is intentional so that efivars, the standard
> > > > mechanism used by an OS to talk with the firmware can be available =
to
> > > > U-Boot, if I recall things correctly.
> > > >
> > > > My understanding of your assumption is that you believe that once t=
he
> > > > EFI_LOADER subsystem has started work on a payload we're just a few=
 call
> > > > chains away from the OS being started and runtime services aside U-=
Boot
> > > > being done.
> > > >
> > > > My understanding of how things are used today is that this is incor=
rect.
> > >
> > > What I am getting at is that once we have called that function we know
> > > we are booting an EFI app or using an EFI feature in preparation for
> > > doing so. Let's start there. Is that correct?
> >
> > No, it is not correct.
>=20
> Can you give me a code link?

env_set() -> env_do_env_set() -> do_env_set_efi() -> efi_init_obj_list()

--=20
Tom

--XUrbc5xVkWoFxETt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNpCkACgkQFHw5/5Y0
tywUwwv/XB4yM/GGqNpWbl1rDa9oQGhg8YaqwYw6DimRersbqW174im4LZsb66iu
jS2dAz5ZFpzmds9B9yKDCMuMT16LhFM9Z6eaBa+CXB5q1i+PklHRhe3kXVV+Ed3j
vnSG3qqGchkF8/thPew3+Vv9/CYC25eg2IGWJtrPor6XLSC58mnf8wMiR8M8fs2c
6oXnrT9RiZmtPNakGHg4vzHRME1cI1yiwNsgSAHYj/PKFqBEOrvPdV8iKTpoE+2n
Y++Had+TZnGd3apH+M4DkI8Y14JRlLjDT0QSsPUVdH1cTPyzuD939gl/qH+8Jq3+
K5JiNYtBMHiqjHLgM5JsW69St2nj20fioGtMacTn01rrE8ZCV9YTnMiBA/Jdk5fg
R/QrDodslnRFLJ9s0nNQ+vdMZ/353zaUE7aUzOZcBTjwz0i6I4I5t2pafLg6zijP
JE5mdHFySIY62YCrRZORoEncrzNBpsXIghEHjZUb6xal+He/gbSAM3v6Czy2/6Sv
FJmMbb8l
=jLOH
-----END PGP SIGNATURE-----

--XUrbc5xVkWoFxETt--
