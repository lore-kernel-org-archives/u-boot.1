Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CAEC3600B
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 02:20:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6EAA809A4;
	Fri, 28 Mar 2025 03:20:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cy5gmiZB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB56281D3B; Thu, 27 Mar 2025 15:19:13 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B4D1806FC
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 15:19:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-60208b7a6d6so344388eaf.1
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743085150; x=1743689950; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EBnewPaYcukbRF7XMl9WnaDPlYbVM07ET31mo9lOzog=;
 b=cy5gmiZB3PivjKxj9njSeDwDfOanzjoYLjagIHnP/+QGd35mCjPGpNQIrdYRHOGueK
 9DxyVwr5qLzgxo9WL1780vxSft1ptQh/Y9qVRmhraTPMiNLTvKDuR9coKv/SLmXKnwh+
 Tv+M0K+sDxchAuxC5ZojH6NADcW0bf128gR+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743085150; x=1743689950;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EBnewPaYcukbRF7XMl9WnaDPlYbVM07ET31mo9lOzog=;
 b=eEzEsJRlVfs0lW3GjrEghpgrBBD4SpaoV5wNKTRKiGJCTz8zPbri+QaV5QKggxqTsH
 VcU1ogXZWnjzzM6HO9h6XKGxmBmLjsSB1JIcQHkLI8Y9WD//+ZWWTmv7sa7I7N7a8hB2
 +4WdJBOHPorb8Xt9hVeZ7Zq03IsShNIyr/bt5z74bsbkUQqOnMQXwe/yYzuJIh/E7YvA
 8I19jp3KQDaHsOMPIUgj781DsJ3wjD1Q3ZGRuDvsWkolWOKkH2whhXJM5A17W8BuDRmV
 gqUi1C1/b+TtOsDUxWTENL0czenOmGj0Mrxu99iYQHGguqIOb/tBIrYjukTEOJ4Tie0h
 12iQ==
X-Gm-Message-State: AOJu0YxW7B20rZMXvL3dmvS1U1WaVA54iAVpp8Cm8BBDMr3VE0Hp0Q9O
 KptAC7vpk9N0+Sm3JSvPjQCjgPf+o0DKwtTzXPOSJq5zL1DZpMqSJQl7VKaoR4A=
X-Gm-Gg: ASbGncsHARL/du4XGFIsJv9yQKN/Xec8PFHeCLnW/JQH1pD8tESgbD96qjf+PgksN/E
 OnPGvrTTKpU5qdiDI/EWwWs2dlWL2c8SiQw1qRgmiZWm6ond9+e+CUkMjP0l1KiNTKObBeF2/3A
 gzsxVhfS8M5KKK6PoJ+vZqobD3htpGcvOVgeNIx/J8xj7EpvwBplNfrRAj/DvtnoLuLUlexaZdr
 CJHaZzx0/edsG0bHVlNJBZvVC4FJADmnUk9VQZg7A0XvaezKHk+jn0Vh+dwXbi49yQfo0xEBium
 ya1N4IBCE4hV4aGIfkjhIfLsF/fZL8cw4s6XX9JcFdNrQtzAPu5+/vod9ghEPzPTfkraN5swasi
 KCCId5sZa2h/mgAf3
X-Google-Smtp-Source: AGHT+IFNYoOHrLXEnnGykEdB8krqK5tM8ALfFOuxajwB12SGed2rhjYJuiIRO20MH6/5AgqHhgQ4bA==
X-Received: by 2002:a05:6820:4586:b0:5fd:b60:ce94 with SMTP id
 006d021491bc7-602785699b7mr1833899eaf.2.1743085150066; 
 Thu, 27 Mar 2025 07:19:10 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60273571f99sm453209eaf.30.2025.03.27.07.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 07:19:09 -0700 (PDT)
Date: Thu, 27 Mar 2025 08:19:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Anton Bambura <jenneron@protonmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>, Janne Grunau <j@jannau.net>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Masahiro Yamada <masahiroy@kernel.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul Kocialkowski <contact@paulk.fr>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Weinberger <richard@nod.at>, Rick Chen <rick@andestech.com>,
 Sam Edwards <CFSworks@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Trevor Woerner <twoerner@gmail.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH v4 00/29] arm: Support building as an EFI app
Message-ID: <20250327141905.GQ93000@bill-the-cat>
References: <20250215032254.4121030-1-sjg@chromium.org>
 <20250221204531.GS1233568@bill-the-cat>
 <CAFLszTj3kyGwC-EY+s5g5T0dBN+7Bg3i8crySiqzGirTAFX-nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="78KdKppTO8F+DxXd"
Content-Disposition: inline
In-Reply-To: <CAFLszTj3kyGwC-EY+s5g5T0dBN+7Bg3i8crySiqzGirTAFX-nA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Fri, 28 Mar 2025 03:20:27 +0100
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


--78KdKppTO8F+DxXd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 07:36:06AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 21 Feb 2025 at 13:45, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Feb 14, 2025 at 08:22:21PM -0700, Simon Glass wrote:
> >
> > > The original x86 EFI-app was written back in 2015, about a year before
> > > the EFI-loader was introduced. At that point, ARM mostly used U-Boot =
and
> > > FIT (Flat Image Tree).
> > >
> > > Today, sadly, there are a few efforts to re-invent FIT poorly, to cat=
er
> > > to more primitive boot-environments than U-Boot. One justification for
> > > this re-invetion has been that EDK2 did not support FIT.
> > >
> > > EDK2 does now support FIT but only for the firmware stage. Even then,
> > > vendors tend to use their own forks, so any new features are slow to
> > > make it into the market.
> > >
> > > EDK2 also supports the ext4 filesystem, but many devices don't include
> > > that feature, so most distros make use of FAT for storing their boot
> > > files. Since FAT is not journalled, it is not particularly reliable in
> > > the face of reset, power failure, etc.
> > >
> > > As an interim measure, we can use U-Boot as an EFI app running on top=
 of
> > > whatever EDK2 fork is in use. This allows use of modern features such=
 as
> > > FIT and filesystems other than FAT. So far this only supports x86, but
> > > recent ARM laptops are making use of EFI too.
> > >
> > > So this series adds an EFI app for 64-bit ARM.
> > >
> > > Note: Since U-Boot does not support EFI's GOP 'blt-only' mode, the
> > > vidconsole does not operate, but it can still be used, since EDK2
> > > handles drawing instead of U-Boot. As a result, the U-Boot logo is not
> > > shown.
> >
> > You did miss some of the tags I provided against v3, fwiw.
>=20
> I see this is marked as 'deferred' in patchwork. I'm going to apply it
> to my tree.
>=20
> If you like, I could do a pull request against -next with the EFI-app upd=
ates.

Yes, I marked it as deferred as this was not based on next to start
with. If you would like to see progress on this, please start by
rebasing, addressing the outstanding feedback on and posting the
pre-requisite patches you applied to your own tree.

--=20
Tom

--78KdKppTO8F+DxXd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmflXlkACgkQFHw5/5Y0
tyxXpwwAsnnMGNOHwp/0R5UIKpghRyR5Ni7VR3b+p4U4CbHgYXVx81h3UetjxPlN
RDTr8gAz95DvT79tV21XCTlzxEV8QCYA0hS+pbbHyHe/FRaVm2SLlKebe+4UFLcI
fNtQavu+pDFPPzJbXab8WM1ikWAOE2cbgWscLzhfedEyvEK4aAdCZEMLR+z4UuFX
rYLDlCDYnpmkHlj6FOTEE3T7lfSrWo+3nGvwNK6py5STQesZX3sZIs33WQxS9dsa
7gwVlxO5+adgqPs5A8yaiZcRhwYh8hzyzBy8oAjAKOwTK0OscP3Di0SHvUfUi3WD
zvU39XcxRZl1bpTencSj0l9pDtexPgjhgT1fyEfo5OiPCKn45KI8hnKVmUialXLN
wOuJvJ0kKYlRrk3K2UO+ndc3ucln5xrysmmJDD54YnyxYM0SQAeJ2KguOMGQsNBj
abWCt9HI/+gPv9WzL7v2ffSTJ9IXan/sETEWgKm1AhJ9gBQaIZpSf83OdSsAn0bn
zx0n6vAs
=gFct
-----END PGP SIGNATURE-----

--78KdKppTO8F+DxXd--
