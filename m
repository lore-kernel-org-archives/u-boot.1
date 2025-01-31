Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB760C0218A
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 00:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1772080C96;
	Fri, 31 Jan 2025 01:09:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TaYo1Da4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E12180EB6; Fri, 31 Jan 2025 01:09:28 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 763B9809D0
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 01:09:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5f88a93dceeso472002eaf.2
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 16:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738282164; x=1738886964; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6u5VpI0X0lBm5km5Jmixg4Ldk8/xSC6TUk2I2p7b3fE=;
 b=TaYo1Da4yZy/5aS/Oyj9/IjJeFJ7NgtJbj/zoNoOrkvHQ/i6SyFCyh0id4WuV4ZVY5
 IzV8mUkRNmfTe1pTz+9GXwyeyskmTUShpqMEPonlhOB2NORAN/qRXipU9BiikwY4hyIW
 opMyEikBbaok3/zesOzenyruEW7/pd48vsd8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738282164; x=1738886964;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6u5VpI0X0lBm5km5Jmixg4Ldk8/xSC6TUk2I2p7b3fE=;
 b=TBV5uVoUI7upXLepaNfO4kV5X/cOu1bey22oa8a2fuzma5HXRjqqV5gSAbddWwhZlr
 WIae324dgCQXC/UO8PeBLTWoXpErEJI1tN01tzX+d1mV9Y1aQpXBAOcf5CmohgOrkDQj
 PHtEMd2Jt4rAo/F8mxqEKRfKdAdKdexXl6LUFE0n84C0m/yb9QBrlx67RLD0xQ0VYoyP
 AZYaSxVZrC9VJEmHBY0fY9vEDNNa/BRw3+ySlKZOuYpESKHzRS7LorUEbifVyO2HzPfC
 cjtJwQwCHSu6PwKCLaXnsNLu6bdPVbfSZUzizcXbAapkPRtzylvMzJdqGpE4spICcUUk
 T/Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmyabJ/FANH8mag7eX0uG4FbBE2iqzR+D3Nppa0Ptir3WBVHQJenMTsRhp1eu396DCXbuNb+k=@lists.denx.de
X-Gm-Message-State: AOJu0YycygpUd4AboP63Txj0xqEYH+4er2ncQtJblfliX/mCe0CCH54g
 0xVGbnfQgPz2DwdDgIjmzhU28cEc5sz1yhnZlKnG7oMhUjXuj7SgaeSiJ3lYeso=
X-Gm-Gg: ASbGncuGHaIUjpNISJ7nuzaxGFZ8ywz0OT/9YSXiMs8eBcX987YuvNAwe9kWPkjPwtJ
 bdjhjCOOWgPABx6m2TGOog9RUGgQGhmnOEgdDDnU/iubFh77QgHEKT6TTjyMpzOUmOgsHajwGYn
 Km5z+3W4ADJQy0Zf1+hdaIIeb0uLirySO3u/8u1JZL/CtvRoxhZT4qO78+5/oQYo8FZJu3x8TxM
 4IuMSf7TcKScXTPPmPg7skUNOoPgHpuvTe9Ovu3TS6NXWSrmGZGzxIKwE3lfiihrk01xT42cUx/
 /r8A8uHuti49ZJY=
X-Google-Smtp-Source: AGHT+IHSxlISNsHCtrgH40ZMKI2To8cB6MxvxjKMGfiqGfVw+PXEh31LOEqYl3n8+k0WU7/aFoaRiw==
X-Received: by 2002:a05:6870:548b:b0:29e:f61:3b62 with SMTP id
 586e51a60fabf-2b32ef75268mr5510998fac.7.1738282164121; 
 Thu, 30 Jan 2025 16:09:24 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f33355d4dasm522769b6e.27.2025.01.30.16.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 16:09:23 -0800 (PST)
Date: Thu, 30 Jan 2025 18:09:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: Re: [PATCH 01/19] mbedtls: Add SHA symbols for VPL
Message-ID: <20250131000920.GM1233568@bill-the-cat>
References: <20250126184333.4058848-1-sjg@chromium.org>
 <20250126184333.4058848-2-sjg@chromium.org>
 <CAEfUkUJPVLGCoThrP3ZcLwY283FYm2CcU52XDEmguKj0mKSc3Q@mail.gmail.com>
 <20250130195540.GL1233568@bill-the-cat>
 <CAEfUkU+E9qkHo_dhEFffYj_uhrk0OFezQEchNU=yDuE2beMEXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vsfgX1gQ32kNmzSi"
Content-Disposition: inline
In-Reply-To: <CAEfUkU+E9qkHo_dhEFffYj_uhrk0OFezQEchNU=yDuE2beMEXw@mail.gmail.com>
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


--vsfgX1gQ32kNmzSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 04:49:36PM -0500, Raymond Mao wrote:
> Hi Tom,
>=20
> On Thu, 30 Jan 2025 at 14:55, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Jan 27, 2025 at 10:23:12AM -0500, Raymond Mao wrote:
> > > Hi Simon,
> > >
> > >
> > > On Sun, 26 Jan 2025 at 13:43, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Add some symbols for supporting SHA1 etc. for VPL.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >  lib/mbedtls/Kconfig | 40 ++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 40 insertions(+)
> > > >
> > > > diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> > > > index 78167ffa252..81274786106 100644
> > > > --- a/lib/mbedtls/Kconfig
> > > > +++ b/lib/mbedtls/Kconfig
> > > > @@ -112,6 +112,46 @@ config SPL_MD5_LEGACY
> > > >
> > > >  endif # SPL
> > > >
> > > > +if VPL
> > > > +
> > > > +config VPL_SHA1_LEGACY
> > > > +       bool "Enable SHA1 support in VPL with legacy crypto library"
> > > > +       depends on LEGACY_CRYPTO_BASIC && VPL_SHA1
> > > > +       help
> > > > +         This option enables support of hashing using SHA1 algorit=
hm
> > > > +         with legacy crypto library.
> > > > +
> > > > +config VPL_SHA256_LEGACY
> > > > +       bool "Enable SHA256 support in VPL with legacy crypto libra=
ry"
> > > > +       depends on LEGACY_CRYPTO_BASIC && VPL_SHA256
> > > > +       help
> > > > +         This option enables support of hashing using SHA256 algor=
ithm
> > > > +         with legacy crypto library.
> > > > +
> > > > +config VPL_SHA512_LEGACY
> > > > +       bool "Enable SHA512 support in VPL with legacy crypto libra=
ry"
> > > > +       depends on LEGACY_CRYPTO_BASIC && VPL_SHA512
> > > > +       help
> > > > +         This option enables support of hashing using SHA512 algor=
ithm
> > > > +         with legacy crypto library.
> > > > +
> > > > +config VPL_SHA384_LEGACY
> > > > +       bool "Enable SHA384 support in VPL with legacy crypto libra=
ry"
> > > > +       depends on LEGACY_CRYPTO_BASIC && VPL_SHA384
> > > > +       select VPL_SHA512_LEGACY
> > > > +       help
> > > > +         This option enables support of hashing using SHA384 algor=
ithm
> > > > +         with legacy crypto library.
> > > > +
> > > > +config VPL_MD5_LEGACY
> > > > +       bool "Enable MD5 support in VPL with legacy crypto library"
> > > > +       depends on LEGACY_CRYPTO_BASIC && VPL_MD5
> > > > +       help
> > > > +         This option enables support of hashing using MD5 algorithm
> > > > +         with legacy crypto library.
> > > > +
> > > > +endif # VPL
> > > > +
> > >
> > > Do you mind rebasing this patch on top of my series below?
> > > https://lore.kernel.org/u-boot/20250127151657.648255-1-raymond.mao@li=
naro.org/
> > >
> > > My one has refactored the entire mbedtls kconfig submenu, makefile and
> > > default config file to adapt with XPL, so that users can have
> > > independent config options in both U-Boot proper and XPLs.
> >
> > Actually, can you work on top of this one please Raymond? I tried yours
> > out now and it results in ~4KiB growth so something isn't right there,
> > but Simon's is fine atm. Thanks!
> >
> The reason is that I set MbedTLS crypto as default when MBEDTLS_LIB is
> selected, which sounds more logically reasonable.
> If users enable MBEDTLS_LIB_CRYPTO_ALT at the same time with
> MBEDTLS_LIB, which means using U-Boot legacy crypto as MbedTLS
> alternatives, the growth should be gone.
>=20
> Do you want me to select MBEDTLS_LIB_CRYPTO_ALT for qemu or should we
> leave this for the user to determine?

No, I guess you're right, that's fine. Still better to do this on top of
Simon's series however please, thanks.

--=20
Tom

--vsfgX1gQ32kNmzSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmecFKwACgkQFHw5/5Y0
tyw1hQwAtfVi5O2jUS9ffxLQHWUlAoSbxe0DfQMRu+UGRh+YIrJ7yPFmVlZ/AwGa
JoKPSan57i56a7AU5Gs2MKxR4abZbGL5FRyOmMPNUaXS+jTpzgJCb0vrxMxFnCXc
mgmf3jpXoAYIbcRm/npEEzf1KBE5dozdgGw1DJMykWxsnexM8Ru4SjvqxO8bZa5E
kydYpDuOGk8oVONiU2mKnbSrw6Gi61Z6UTbG+BKA05nG2giKxmsTOEJUm4enE5fb
+1AlocaKwLkTOqRD/d1u6ceZhUEsxVngSfVkvGSqCc+91aq1GHeVNKOfoKGMf507
LCBFSPs6KCQrLA/USO9LA0VgLcxYdAn4PLWHRmcaOZJMp9gnkTwO1w8jF016ixNZ
g0mwPhnOqd6d53dHioVOWTGbLWAIjYafBrKmVThrrV+T3CMxL5YylBtQF8EXdTxZ
LYFgQjmmog7RgzXYDXD7D0C7VxGtZM0eNym8NhgYz8FptN/a7GsQ9qbR0zFoavYd
D5B1MSbs
=2/oh
-----END PGP SIGNATURE-----

--vsfgX1gQ32kNmzSi--
