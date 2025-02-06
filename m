Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418AFC02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 23:22:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB42080F1C;
	Fri,  7 Feb 2025 00:22:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y7HWykn6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C00B80F30; Fri,  7 Feb 2025 00:22:17 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C965E80F1A
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 00:22:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2fa1d9fb990so1203099a91.2
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 15:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738884133; x=1739488933; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OQUjyKLtA6IPRWS+xhuJPpi2YydaQqXLka4vtogv0JM=;
 b=Y7HWykn66VdGxc/NK/fgbv2BNxzR0jd7vh5SXlA0zZjhgebYe+BCcPVt9EGEJn+6sI
 SrgyISVh3SwXwSL12v/HoDeSO8DWSPxiTljqUEULxR9v4WXi3HM3PI+9dzEZKNlgQxDS
 Q9eKKt1A2TkgfDLhOTn1wcLzgKFrBxmi7Z1vM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738884133; x=1739488933;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQUjyKLtA6IPRWS+xhuJPpi2YydaQqXLka4vtogv0JM=;
 b=dAo2fLnRDgOe8SjPa91cz3t8T0prgAmZ01KFon8LmXnSJCo6vipJzpuXLEQVaG3D6a
 Lmt4BgJVwdU/n4xfoghD55oezWbHiJ3lW64RnqXY8fM5OfBV4WE2fQNcf6MVSm3c2/Gb
 Dyk69vJSD1DWhmfFRw6/eDIu9LEQnz1sddgfQmVPEfsEouzrh9+dG6h8zl7nxPLce5DT
 D+xls5odFGYjznOfwMjIE9OPlCHndKLLgsnWahdN06fl17K7KIUxdkQY0UwT6CaDrcxv
 57I3+ALbZH4xXJlOPLjGEsQOGx2/vSgJ+ho5YVU3qWVj/LayqTLwU/KN/kjbemEXODNk
 smGQ==
X-Gm-Message-State: AOJu0Yy870WWXVU0v3H3ylAh3EyPeIEJQ6M6hLn95JCWZI5nAjZnarrr
 8sboFEvBbHRlof0khF1Dm/Ok9geMJsfPTFq0wbvlwEym9oG6uQ3HZYl0B2Ogp18=
X-Gm-Gg: ASbGnctdQJTk4qSZDUv/1dLt/NdVdAbc/PP9EWAoChYEeTVRd/jRax1N8nQvDxI7hea
 hUavpUERzNCrk/t+HatBcYzSgh9L8tCtNvf8hb9zO3GL61dIG9A8oLgMpJoNUu4zEJQooUDXcL6
 ILfz04Keqx7azsiBMwanISgZ3MdDa1OKSrSxXB96/FWkOFuM4JdgVyrtNGnEoMt2u6aczJWF2sL
 L7xI5MyjKYpUlDLRJ0pJPA2PHeNZrXeOvNfVCv+2Jh5ODKy1e1XctU/QQPiXxJN4e1uvFXv4M9X
 Qq1Mrdzh55p9JuY=
X-Google-Smtp-Source: AGHT+IGY9Q4kMzM0BBduiE2wo43k+AtmMisIfrzkTm9Dhu8FprU9Cfb+Q03RpawlpazEwYS70UmDfw==
X-Received: by 2002:a17:90b:38c3:b0:2ee:ab29:1482 with SMTP id
 98e67ed59e1d1-2fa24271b9dmr1751726a91.16.1738884130608; 
 Thu, 06 Feb 2025 15:22:10 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3687c7b6sm18242935ad.196.2025.02.06.15.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 15:22:09 -0800 (PST)
Date: Thu, 6 Feb 2025 17:22:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH 21/32] efi: arm: Drop exception code when running as an
 EFI app
Message-ID: <20250206232206.GP1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-22-sjg@chromium.org>
 <20250203200937.GL1233568@bill-the-cat>
 <CAFLszTgO-nErzRg4FnM3rGCeHgfsAKCui3p9OhqP1YipyyN3=A@mail.gmail.com>
 <20250204020008.GB1233568@bill-the-cat>
 <CAFLszThqpfGF1pgAy4GP0Yt+jZsKdYwC0bRcnnsy0WduAYBEXw@mail.gmail.com>
 <20250206170745.GG1233568@bill-the-cat>
 <CAFLszTiJ_zB4_dCJNjOAbXtfBmM2KxbHXxiw4gpRMMsJdOM2hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WKnYgoYJtA5a2A1u"
Content-Disposition: inline
In-Reply-To: <CAFLszTiJ_zB4_dCJNjOAbXtfBmM2KxbHXxiw4gpRMMsJdOM2hg@mail.gmail.com>
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


--WKnYgoYJtA5a2A1u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 02:27:13PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 6 Feb 2025 at 10:08, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Feb 06, 2025 at 05:33:06AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 3 Feb 2025 at 19:00, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Feb 03, 2025 at 05:38:52PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 3 Feb 2025 at 13:09, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Mon, Feb 03, 2025 at 10:42:14AM -0700, Simon Glass wrote:
> > > > > >
> > > > > > > This code cannot be used since EFI is in charge of managing e=
xceptions.
> > > > > > > Drop it.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > >  arch/arm/cpu/armv8/Makefile | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > Why is SPL on in this case?
> > > > >
> > > > > SPL is enabled by a specific Kconfig option, which seems to have
> > > > > exceptions but not exception levels. That seemed to match what th=
e EFI
> > > > > app wants, for now.
> > > >
> > > > OK, so why aren't you turning off SPL? You're not using SPL at all,
> > > > right?
> > >
> > > Not using SPL, but using the same code as SPL happens to use.
> >
> > But is CONFIG_SPL enabled, or not? It shouldn't be if I follow you.
>=20
> No, it isn't enabled. But we do want that exceptions.o both for the
> EFI app and for whatever boards use SPL.

Um. Isn't that the opposite of what your commit message says? And the
Makefile snippet today is:
ifdef CONFIG_XPL_BUILD
obj-$(CONFIG_ARMV8_SPL_EXCEPTION_VECTORS) +=3D exceptions.o
else
obj-y   +=3D exceptions.o
obj-y   +=3D exception_level.o
endif

--=20
Tom

--WKnYgoYJtA5a2A1u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmelRB4ACgkQFHw5/5Y0
tyx16gv8CMQRKAsaArr8o4A0S9mrjVk0UCE+JcafOQh2hd3xlAwIJAxcGg5nnDoG
aqKU8QUaxxN88Swgbag/SpkulWgfv6ubGiEg00fBIkAsLm12WG9Agdq4OYsai3CM
pf9c1dXaEYRFc2ke3qg939TggfQrBbXdf4B/sq4CqGtpHWCZUfx/ulj4yGZr1LPP
ykMOVhvrlkt/7ANbrTNSswGDGnq7syw+hpw232xgs3rhvqNMD+Zkjve/gZl1DP6W
4ZLvKG2BHxG2XEkHXyKsmmUbvZN1D1sfvJDEi672cv0HMNX5tBXx+h34RrZLIYu+
uWBu9WgwBJ9B/TSpQ1+B4RXcTsrTBBZF0Vk131eR2h5C4u8S4TvfneM5W29235iQ
zOSv8M75GJlRsOlPDcM2fzuiCk6An+Obzofk0N1p2W5hsi/vrHUb8b+fK0hD2Kwu
5o2YKLWoVJ+pacabw6qyl/YvNnA5lpG7KJtct5ipVN3iosmSgl2g0XEaZ0AaVQvG
+wR4lCb/
=omWP
-----END PGP SIGNATURE-----

--WKnYgoYJtA5a2A1u--
