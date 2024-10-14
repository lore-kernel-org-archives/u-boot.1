Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424A0D1813A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 18:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BDA988FED;
	Mon, 14 Oct 2024 20:23:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l+4Wu3rL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A95A588F91; Mon, 14 Oct 2024 20:23:53 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8158389003
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 20:23:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-45f05f87ca5so26269331cf.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 11:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728930230; x=1729535030; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ijME8SxAN1kB9FK1Zc7vgctnGzCBJ9z5SH2Mc756JiU=;
 b=l+4Wu3rL77xorD1ybFgIPqbYKlH9xokVhsTH79wF0wt48kI6a/yKBjGnxfBy1oJyBC
 mPCXEPckcH17GAMF+3w9wci7ubBQX8UtBDd53JSpk8Hbzi+Fbpn9wGUVRpOv9X1kAtgc
 QtQvuf+im52dQrC3X2j8ZLEJHBDAobaAINZ6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728930230; x=1729535030;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ijME8SxAN1kB9FK1Zc7vgctnGzCBJ9z5SH2Mc756JiU=;
 b=skJ5BpYnXX3oZGlUA1xTgphW01gx5DWTgCITK39BQk+XAR6Xc68yR7VLNcQHpwkKsa
 xw2Q0Y3bTzESEibty+XGCEZ5epCyAg4YQDzEPi0kMNtApI358+xQ6EHHP0GZexKaIqcr
 h7OPXEj4n3qbXcXOhgBF3m0QtOazGoU3FXS7aNXIESUx6z7Iq/gR2RTy4Pyeq0kSk8i6
 3Z4n5127EFVkSah6kNfUlCBItdNbTDTIioSVDUlA/s4gjkI5dg6wecdj19gF5v4Elyx1
 /LQpH9hZBDqTO+mbTyT0YderLYGY6O1LgbEBZ7gquHjoJ8y7VukhdquomQLvA/nrEK2f
 YtNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUovJNW6svFF2dwjQSbYdgVj0o+nWe0MBMDJUDGZMNSY268iDi1as1Q9htBbZimXQk7QvMhYPE=@lists.denx.de
X-Gm-Message-State: AOJu0YzTyUjoaqCigQlhReQKh8ZoAM/351zgUOZnnxOl8RLyJBkAV3+O
 o0Pe0J7kQI2vElOzSj2FBvFuQBh5VCg5i805zdi8CbIhaRqXFbQqs4OSdWrW9Yk=
X-Google-Smtp-Source: AGHT+IHFsEfW/W7vu3+TpmerJmCTjN0X2mA7/T5TtWlssH9K38d8AAe012SvavNT3Asgi6jFpwIyjw==
X-Received: by 2002:a05:6214:311c:b0:6c7:cd75:51fd with SMTP id
 6a1803df08f44-6cbf00f3b34mr157767696d6.52.1728930230288; 
 Mon, 14 Oct 2024 11:23:50 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe85aa56dsm47754536d6.26.2024.10.14.11.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 11:23:49 -0700 (PDT)
Date: Mon, 14 Oct 2024 12:23:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Devarsh Thakkar <devarsht@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, jonas@kwiboo.se, richard@nod.at,
 raymond.mao@linaro.org, u-kumar1@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH] boardf: Modify DRAM message
Message-ID: <20241014182346.GT53053@bill-the-cat>
References: <20241010070909.288313-1-n-francis@ti.com>
 <CAFLszTjJ1GJNd5Fn8U2O5WSnKMn99XW_pGLmejkYy_PBfxSEGg@mail.gmail.com>
 <f194f14a-c7c3-4aed-b4b8-f093f64c7b69@ti.com>
 <31aeb96d-55b1-4587-b212-2632ae4cc124@ti.com>
 <20241014142717.GJ53053@bill-the-cat>
 <eef0f5e5-1a54-015b-259c-c8eea4a54d6a@ti.com>
 <20241014153510.GN53053@bill-the-cat>
 <4e3c3044-2601-4093-a422-898b183a173a@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cqRRpK6XakEfsipg"
Content-Disposition: inline
In-Reply-To: <4e3c3044-2601-4093-a422-898b183a173a@cherry.de>
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


--cqRRpK6XakEfsipg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 07:23:09PM +0200, Quentin Schulz wrote:
> Hi all,
>=20
> On 10/14/24 5:35 PM, Tom Rini wrote:
> > On Mon, Oct 14, 2024 at 08:59:39PM +0530, Devarsh Thakkar wrote:
> > > Hi,
> > >=20
> > > On 14/10/24 19:57, Tom Rini wrote:
> > > > On Mon, Oct 14, 2024 at 10:10:43AM +0530, Neha Malcom Francis wrote:
> > > > > Hi Andrew
> > > > >=20
> > > > > On 11/10/24 01:59, Andrew Davis wrote:
> > > > > > On 10/10/24 1:50 PM, Simon Glass wrote:
> > > > > > > Hi Neha,
> > > > > > >=20
> > > > > > > On Thu, 10 Oct 2024 at 01:09, Neha Malcom Francis <n-francis@=
ti.com> wrote:
> > > > > > > >=20
> > > > > > > > The message "DRAM:=A0 2 GiB (effective 32 GiB)" can be a li=
ttle confusing,
> > > > > > > > modify the message to show exactly what is meant:
> > > > > > > >=20
> > > > > > > > "DRAM:=A0 2 GiB (available for U-Boot out of total 32 GiB)"
> > > > > > > >=20
> > > > > > > > Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> > > > > > > > ---
> > > > > > > >  =A0 common/board_f.c | 2 +-
> > > > > > > >  =A0 1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > >=20
> > > > > > > > diff --git a/common/board_f.c b/common/board_f.c
> > > > > > > > index 154675d0e40..b7add8f7d3d 100644
> > > > > > > > --- a/common/board_f.c
> > > > > > > > +++ b/common/board_f.c
> > > > > > > > @@ -254,7 +254,7 @@ static int show_dram_config(void)
> > > > > > > >=20
> > > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0 print_size(gd->ram_size, "");
> > > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0 if (!sizes_near(gd->ram_size, siz=
e)) {
> > > > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printf(" (effec=
tive ");
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printf(" (avail=
able for U-Boot out of total ");
> > > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 print_siz=
e(size, ")");
> > > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0 board_add_ram_info(0);
> > > > > > > > --=20
> > > > > > > > 2.34.1
> > > > > > > >=20
> > > > > > >=20
> > > > > > > I've forgotten why the first number can be so much lower than=
 the
> > > > > > > second. What is causing that?
> > > > > > >=20
> > > > > > > This is quite a long string...could we say "(total 32 GiB)" ?=
 Then
> > > > > > > perhaps add something to doc/ to talk about the banner that U=
-Boot
> > > > > > > prints?
> > > > > > >=20
> > > > > >=20
> > > > > > Why not just only print the total number? The amount available =
to
> > > > > > U-Boot seems like an internal detail, I'd guess most folks just=
 what
> > > > > > to see at a glance how much DDR was detected on their system.
> > > > > >=20
> > > > >=20
> > > Knowing how much u-boot is using might help someone who is working on=
 some
> > > memory map related stuff or if they want to stop at u-boot prompt and=
 tweak
> > > environment variables related to memory map (e.g. load address for ke=
rnel,
> > > dtb, load bitmap to DDR etc). Overall I personally don't see much har=
m on
> > > keeping both the information (DDR available to u-boot and total avail=
able
> > > DDR). If the word effective is confusing than the print can be made m=
ore
> > > verbose as being intended in this patch-set or by following the sugge=
stions
> > > given by Simon and Udit.
> >=20
> > U-Boot isn't "using" 2GiB however. And in fact the command Simon is
> > working on to dump the memory table and what's where, as far as U-Boot
> > knows, would be helpful in that case.
> >=20
>=20
> "Available" and "Total" would be matching the terms used by "free" in Lin=
ux
> for example.
>=20
> I still think both are valuable pieces of information (what's populated a=
nd
> what is usable by U-Boot AFAIR).

Yes, and that won't change the binary size much, thanks.

--=20
Tom

--cqRRpK6XakEfsipg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNYbIACgkQFHw5/5Y0
tyzyMQv/SE1rfZ0BbB7HNYTmYSijHIU+QzM3jibPAnogj3xa0rjhIfgIsfFLaZqH
NDOF2Xo2/MAzvMbcCGdUVTe+Tf76mSOd8LVKVv3loJvhMgoXTWkj9Zusf+bca1dY
zGw3S0IQHRI3a/4jQ7PMB7oauanhch+sMZuLvKxQkcviIKfYgzfhZfbRN1vG8za7
CwAbKzRrxawRVpaCJNYBLSr4BGajGSyqFEvXh58NExdFJtFVuF6dAY8CYuYjR4C1
rGQ/u6XbZ5RIZl06ix2c7PMr0eDm+2rPUAJQqm+iDyjEo3lQqLMyTCgfn9EHZfp0
weg6nlpMDBIT+X++Var+IgNVXgICQm58wz8/gl22IMf2dvydJLWmn5+GfTp7osi1
YVjhn7RgM4IYBIX957lMByQPhW9rlduLdfk51XEObj0//rlH0elNYGYT8ieYC1g8
mKkhQRIscyu56rJJxizk8wAaPDWjRsNSge389MkQHvsD388xRvlyqsqas7l9Tc8z
/uoE37kG
=x0VE
-----END PGP SIGNATURE-----

--cqRRpK6XakEfsipg--
