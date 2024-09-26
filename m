Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64546CEBF60
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 23:22:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA45088F89;
	Fri, 27 Sep 2024 01:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Lt3gulZ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E83A88F85; Fri, 27 Sep 2024 01:22:39 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 196E688F85
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 01:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7acb0499ffeso132111385a.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 16:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727392956; x=1727997756; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rUwbDWB2ZXNHVy6SFl2DnVE0nhTgRLWDzyhTmu7dNAA=;
 b=Lt3gulZ/dMRM1tWdmf2MEuPZ++wRPvUp5bPc68FiRtVuZs8hXIT2+rfRM6WmJPcVWB
 UBnR61x/afNPVZQ3tlMX7ZTPhdiKW5FMJjrReoZohzur2nv7DLH9MxzGNLwfZ43eLdDC
 ZMK8TGDGRVkSRNwiarqiJmWCWc9R1JvQhfQkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727392956; x=1727997756;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rUwbDWB2ZXNHVy6SFl2DnVE0nhTgRLWDzyhTmu7dNAA=;
 b=Y0g3b1NkYEJE/EvqB3iPbUdOIkP3PDOhgyHXe71kJlLISVYH3ripgPH4FKFbl4X2vA
 dhHxYEEBT0WrSFXcGTU43ueGd2A9aD/nFkqdMCgYxtN/TX/UL7jpHrDwSqtuuSKhp7vh
 cnnvLxmTWKz9IpLGcm5izTAzaF4Ou3Fagyouua1Ht0KeYPeWwp94exSMRVbb0gt4VXVz
 hK2mdY1Sm3xrJb6KXp9cbRTWjlQobgALtfwzcESTsu+kfiNzquzpnSUy/hA2DdpPBjwb
 8SSRRhuQeJ0z6nOlwYp7Z1UJGGIqEgYWAqPf9kLMy3u0NLWLgj6soWmRHFqfrRTf71k8
 37sw==
X-Gm-Message-State: AOJu0YwjkZX4y8b2Fj0OB65PRc/oyXZOPX8lS7h37E9xdb+/lGoK/5Jd
 idoa/0m9fuaI2XAQsLVnvXWRizeNAE2Y3QA0PHaCCoPMK4D+nzmoZOU6efK5ziY=
X-Google-Smtp-Source: AGHT+IGjEKgfURbzi4YSIrFjgdhM8rGVWQT7H1MxbqclK2cEToGVKlHwcjo/2P6h3VDaYhV6s9fztw==
X-Received: by 2002:a05:620a:19a3:b0:7a9:ad47:edc1 with SMTP id
 af79cd13be357-7ae37856f1fmr196679985a.34.1727392955890; 
 Thu, 26 Sep 2024 16:22:35 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae377bc78csm34755885a.19.2024.09.26.16.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 16:22:35 -0700 (PDT)
Date: Thu, 26 Sep 2024 17:22:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Devarsh Thakkar <devarsht@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 11/19] spl: Support jumping to VPL from TPL
Message-ID: <20240926232232.GM4252@bill-the-cat>
References: <20240925125622.197915-1-sjg@chromium.org>
 <20240925125622.197915-12-sjg@chromium.org>
 <20240926040710.GI4252@bill-the-cat>
 <CAFLszTjEpHJE4Zf9hZ_5HQw8adouQ9et3Y+y7LcDe1YKj6ah+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="loRsvXOnAGJqXwzj"
Content-Disposition: inline
In-Reply-To: <CAFLszTjEpHJE4Zf9hZ_5HQw8adouQ9et3Y+y7LcDe1YKj6ah+w@mail.gmail.com>
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


--loRsvXOnAGJqXwzj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 11:33:52PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 26 Sept 2024 at 06:07, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Sep 25, 2024 at 02:55:37PM +0200, Simon Glass wrote:
> > > Use spl_get_image_pos() to obtain the image position to jump to. Add
> > > the symbols used for VPL so that the correct image can be loaded.
> > >
> > > Use the functions provided for accessing these symbols and add a few
> > > comments too.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  common/spl/spl.c | 22 ++++++++++++++++------
> > >  1 file changed, 16 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > > index d01e9861f88..623e486c210 100644
> > > --- a/common/spl/spl.c
> > > +++ b/common/spl/spl.c
> > > @@ -50,15 +50,19 @@ u32 *boot_params_ptr =3D NULL;
> > >
> > >  #if CONFIG_IS_ENABLED(BINMAN_UBOOT_SYMBOLS)
> > >  /* See spl.h for information about this */
> > > +#if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD) && !defi=
ned(CONFIG_VPL_BUILD)
> > >  binman_sym_declare(ulong, u_boot_any, image_pos);
> > >  binman_sym_declare(ulong, u_boot_any, size);
> > > +#endif
> > >
> > > -#ifdef CONFIG_TPL
> > > +#if defined(CONFIG_TPL)
> > > +/* TPL jumps straight to SPL */
> > >  binman_sym_declare(ulong, u_boot_spl_any, image_pos);
> > >  binman_sym_declare(ulong, u_boot_spl_any, size);
> > >  #endif
> > >
> > >  #ifdef CONFIG_VPL
> > > +/* TPL jumps to VPL */
> > >  binman_sym_declare(ulong, u_boot_vpl_any, image_pos);
> > >  binman_sym_declare(ulong, u_boot_vpl_any, size);
> > >  #endif
> >
> > So I see on a64-olinuxino and others a size reduction here, as those
> > symbols aren't included now. Do we have something in the tooling to
> > ensure that we aren't now referencing / dereferencing invalid links?
>=20
> Yes I noticed that on some other boards. I dug into it a bit and
> decided that the symbol was being declared when it didn't need to be.
> If the symbol were used but not declared, we get an error.

OK, thanks.

--=20
Tom

--loRsvXOnAGJqXwzj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb17LgACgkQFHw5/5Y0
tyzt0Av/e7va91LuPDA8pJHFwzwu+/+mJPJGGT0k6zEvgIZcdQVAAEO0SlpCg860
GvPsqfzbutwIdIgzMoA+drriWbSVSmxf9naTiVH/hCyfgbhT+561NRc8IcWAP2lM
+mCCwgORisdv3NmmazSFpF4JgSDBpvAYVmHVDbZmpFS9CfRuSo6axa/5mIdM4CFM
cQX7jREUkiYwFIMAkn+JAkTgwZCL0f05RtjE40Mocaf2Eb8NY0TqT9jXQ7Gny4mP
c1ePlgkeVRvwrPTrskVFjL+ovdc3o4QyBaz8uOQFGUI6apKf3y4zxS4BxxIfbBfh
8nPu2zzazI/OtJIGhdAJWuXm8BFDa/s6YxRlASHJyW1BiWGQDqg0nt6gNE5SEcy/
CW4/O/yJ9Vrq6WSdkcBvNov31DpVno+Mwk4LpUeBm8WM6p2O1DqDF4+slx76XeHu
v5Y7JI2QIijUnGbwFVZCzxeoCXT51v17enkYvssT09BhYMOk+X5we/Vnq0k4to0z
aHtrSpUW
=usKx
-----END PGP SIGNATURE-----

--loRsvXOnAGJqXwzj--
