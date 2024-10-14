Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFDAD18151
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 21:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0514F8907F;
	Mon, 14 Oct 2024 23:42:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ej5CYINj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DAC48918F; Mon, 14 Oct 2024 23:42:44 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 238098907F
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 23:42:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cbd092f7f0so32647266d6.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 14:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728942161; x=1729546961; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mAQYUgZxPMTao16t2BJhD2lvMNgc3oN3mcIARUrB42M=;
 b=Ej5CYINjJB4VzUuWxI6B0tb6P941QyxlO8c3dDvQj6Zs0JgFGPA5eQ8zRH4LLaBH5U
 eYVo9rnx5uzuinYrBWkKuXIR9mwBoKN3h9EU+ZpUvm22hBs6Y7HktMAZ11TGObIVBfRc
 ebgVA0REgUJvlA+77zDXQB/l7EdBehHtYwRc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728942161; x=1729546961;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAQYUgZxPMTao16t2BJhD2lvMNgc3oN3mcIARUrB42M=;
 b=E+X6N1gVxMuh/jnAPlZAbRqHPmwhkF3pRNEE+y+wOVD3vyERNy6KWfXfZ55rnWXCI9
 77HFAmxHLtLHN72bAjD2norD50hk28SzR+EvVcEQAeWYFBVpLqV3g0uo3DSKDCXHZlqZ
 bcYizrSiELZ7OnVfZs0q6f4G1SgKCafEXLN4nwcvteLbcVz/G5pPQI4k7/CCs5l5vIR+
 zqYwcmaohNLAGXAEMIuzXiHSib9M4zttVIxCn2j4zGbZx0HrP441AQfGuFR6LF8VcVRy
 cqiGooYajdq4KyYCR/4h3Zp6Ph+s12k1zRnL+7HNu9zQlH4ePMhuXQSn7bWQFcgt4Ck7
 4mdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlzqN2tc+EAVKvOUL6FejjQRf+KxjJqrSg2wtA+nMo46N5v3Q1J56D59EQU+g8iheVyBNMNsE=@lists.denx.de
X-Gm-Message-State: AOJu0YzuGjYu1gghKKCfKMIwnowgM5cI5FFOrdfxLpw8GzomMsI/4aT+
 b3TSyw2j5ZdZhOP/cDDumdcri9riJ6obl36Wrwj1fEeeuNnNi3zRzoim4fnQcik=
X-Google-Smtp-Source: AGHT+IFf3znUhfPWjN1D1XH1tgDVekO5Z4Kdo2eZkJpJ0tjvQo1doqLaYSwTRtMqax4pGSfuvz/2IQ==
X-Received: by 2002:a05:6214:2f13:b0:6cb:5f28:6b73 with SMTP id
 6a1803df08f44-6cbf000026dmr179117126d6.9.1728942160985; 
 Mon, 14 Oct 2024 14:42:40 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe85b7a03sm49989666d6.38.2024.10.14.14.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 14:42:39 -0700 (PDT)
Date: Mon, 14 Oct 2024 15:42:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: Re: [PATCH v4 4/5] efi: Reserve some memory for initial use
Message-ID: <20241014214236.GB53053@bill-the-cat>
References: <20241011212126.747741-1-sjg@chromium.org>
 <20241011212126.747741-5-sjg@chromium.org>
 <71ECC011-77EC-4308-AFE5-0E301BC27F84@gmx.de>
 <20241012012716.GE14210@bill-the-cat>
 <CAC_iWjL_YQ24ZecbN7oC-37PRR6iuUiiui-a0VPqSSVRunepdQ@mail.gmail.com>
 <CAFLszTjzHBtR8vzk0wT-nNiwbsotqskVhVEX0ibh-Uea1+Da6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dH5hcAESIiZ5T6CT"
Content-Disposition: inline
In-Reply-To: <CAFLszTjzHBtR8vzk0wT-nNiwbsotqskVhVEX0ibh-Uea1+Da6Q@mail.gmail.com>
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


--dH5hcAESIiZ5T6CT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 02:19:56PM -0600, Simon Glass wrote:
> Hi,
>=20
> On Fri, 11 Oct 2024 at 23:47, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Tom
> >
> > On Sat, 12 Oct 2024 at 04:27, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Oct 12, 2024 at 12:01:54AM +0200, Heinrich Schuchardt wrote:
> > > >
> > > >
> > > > Am 11. Oktober 2024 23:21:25 MESZ schrieb Simon Glass <sjg@chromium=
=2Eorg>:
> > > > >The 'point of cooperation' is where U-Boot starts allowing EFI to =
use
> > > > >memory outside of the U-Boot region. Until that point, it is desir=
able
> > > > >to keep more below U-Boot free for loading images.
> > > > >
> > > > >Reserve a small region for this purpose.
> > > >
> > > > Your commit message provides no clue why this should be needed.
>=20
> Yes, I hadn't realised that people didn't understand what I was
> getting at. Tom asked the same question on irc.
>=20
> It allows us to separate the lmb allocations from the EFI allocations,
> so we don't need to have them both in sync. We use lmb for loading
> images, then EFI takes over and does what it likes, respecting the
> existing lmb reservations.

But, again, LMB is not for loading of images. It's for dealing with
memory reservations of various types.

--=20
Tom

--dH5hcAESIiZ5T6CT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNkEcACgkQFHw5/5Y0
tyx8gwv/aSsPyD0NT0k6iJzBVF8PB+4R51NcVknXy7pPhvuxQv700rT6N/Q7k7ZB
HV24y6EmJBkAbrG+ekHUvKDAMnZAOmL9Sp9QXJ9CpCiiyPo5/NB1j6eT77V1J4fa
kyrxMKYhcnhEAQe1mRqx9X3mvI917wikwvgwfI8uJTgaq8s7TI8Nam/3YRUxQqte
ihb3fSy4c4o+uaaNHQTpIteEuUIIN8H5UcfjVkW0PaiTn6VN/to2HW0+6OUtf0U3
yLY9ubf9RH0p/4VOa1Xa7GsBX7DPyGa0Keb1OuM93Ufh7NviIrU85clfZaZ4+GM9
vzpIrywMklGk2gFAxJUjcNuRjSABt2r6KZKG1U1+sU1g5+ocswXYyT4fkGXGPLFq
FmqKRk0xQuyO0D7CHbiGoUtQEx23HavZyBoyNAAOHUQpTe/co5ycTregYgQfDJbr
3Ba9kG/w9EXIHvXiSRXf29n/4F6w775INgxJRHhwpNey1drsS7Ll5M7HuFFjjTGS
25ruUwJ7
=k+ff
-----END PGP SIGNATURE-----

--dH5hcAESIiZ5T6CT--
