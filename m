Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F931CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 12:42:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C60A86F21;
	Wed, 18 Oct 2023 14:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bVa9qWha";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F223586F8A; Wed, 18 Oct 2023 14:42:13 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62E5F86ED5
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 14:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5a7c95b8d14so86345287b3.3
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697632929; x=1698237729; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6USxvaNx4XtQzzHPoIaUV+yJWGkQuNa7/MjkzQ7tXbM=;
 b=bVa9qWhava/g9FcZ4hT+wIbGmG3bDEsYBLYjXSh2QmHsOsJviiBv5bR+5CogsVD2pb
 KBkyZCg4wYijXiCC3AvYAQaq4/0PVgnToQ3N3RQWdpBgfQyfYJs781Z5BQ2fwW1fpZI6
 FLg9eafI27N9WQ3DPH0sORLju3PqF52NwY81A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697632929; x=1698237729;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6USxvaNx4XtQzzHPoIaUV+yJWGkQuNa7/MjkzQ7tXbM=;
 b=EdzllRdD5+5Gz9a6s29Ig450dRYZtXX8Uplhbj5Blkthv/hk08FfbDESKBLyqBfyH8
 jIb0NxZqfweNXPpTyAw+lTYIaosFefRgwpMxVvjxgPsJGaryER860+iqiaNTl8Cf9/kn
 qTVAPXiAD6gMWftoNAZjiUnFM43NVm1aOhL0m5GMozzCvavaZJmwY6XhVkl8gMJ2vBF6
 zeY8TsgA8zdLt2yhOGZEzWt50juK5GaAa/DMXoGQGjvTYF597QvXQfXF6eM9GNMP9CgL
 p57S7eazy+P2VeFDBbHMX5BwUZ9dTG8iz9opJdSzoHzZePqUaO+GcKl4dQf7PKgmz15Q
 TogA==
X-Gm-Message-State: AOJu0Yx7npB3+n+WmsvvjdEFGqfkxpNvWPyOuiddzkttWPFq+oJgqRvP
 Z1eZ0MD8+/1G0vR87wDaFDm+3bk+m4aVVNmjm3hkng==
X-Google-Smtp-Source: AGHT+IGZ3KmCFui2+r39ovqkcDk5qJCCZy8NVSNbJKgWjqC/tdStK8tm+OQlSJZvG5/K4LiP2ft0gg==
X-Received: by 2002:a0d:d74c:0:b0:5a7:c01d:268 with SMTP id
 z73-20020a0dd74c000000b005a7c01d0268mr5382284ywd.18.1697632929113; 
 Wed, 18 Oct 2023 05:42:09 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 v186-20020a0dd3c3000000b0057736c436f1sm1441502ywd.141.2023.10.18.05.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 05:42:08 -0700 (PDT)
Date: Wed, 18 Oct 2023 08:42:06 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v3 19/32] video: Dont require the font command
Message-ID: <20231018124206.GP3119521@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-20-sjg@chromium.org>
 <20231017140741.GA3119521@bill-the-cat>
 <CAPnjgZ2HkabXgrx6yMEZnM4fFiU7UyYRt0qCHecRd_K_ALjuSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GWx1mH/cSnbo44+p"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2HkabXgrx6yMEZnM4fFiU7UyYRt0qCHecRd_K_ALjuSg@mail.gmail.com>
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


--GWx1mH/cSnbo44+p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 09:31:29PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 17 Oct 2023 at 08:07, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 16, 2023 at 04:28:10PM -0600, Simon Glass wrote:
> > > While it is nice to have the font command, using 'select' makes it
> > > impossible to build the console code without it. Change this to use
> > > 'imply' instead.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  drivers/video/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > > index ab927641bb7a..21ea5c860cca 100644
> > > --- a/drivers/video/Kconfig
> > > +++ b/drivers/video/Kconfig
> > > @@ -180,7 +180,7 @@ config CONSOLE_ROTATION
> > >
> > >  config CONSOLE_TRUETYPE
> > >       bool "Support a console that uses TrueType fonts"
> > > -     select CMD_SELECT_FONT
> > > +     imply CMD_SELECT_FONT
> > >       help
> > >         TrueTrype fonts can provide outline-drawing capability rather=
 than
> > >         needing to provide a bitmap for each font and size that is ne=
eded.
> >
> > This is one of those cases where "if CMDLINE" makes sense to add
> > somewhere.
>=20
> Maybe, if you can explain it a bit more. I want boards to be able to
> enable or disable this command, independently of whether truetype
> fonts are supported. Using 'select' here seems quite inflexible.

Ah, OK.  Checking the command itself, we should drop the select here and
make CMD_SELECT_FONT default y if CONSOLE_TRUETYPE (and drop the default
n line it has).

--=20
Tom

--GWx1mH/cSnbo44+p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUv0p4ACgkQFHw5/5Y0
tywp5Qv9H8GLSTyQ11L4+3EoWEbDSUnL+BVFLQ+5kIeycmneU6IG0WdMYEt0Lcg+
oPlPgXyvayBIlwdSSM48NzccC3O1mEBH566ahG/A+PTicbvn86rdPWp91dMlT5Cc
i7JV8vm0ViILjB60JwvVoufjtEHPLRDiC6lcY00TQ4GhdUPBdQnANCd+Ya0p1OMF
K3QIMC9JvTFip02Fq1YaxEozgpgot0peRYu8N2HkgBsIJo5vr0pHii5FKbY8e0Ka
PwObBTGg8WCKrX3fqT+3u7xG8SV7K2CYp7TsrARWoDX2xczWoBXA8ThhMMMEFgFj
nb7nDkQ7+SuPOfI0sNz+CsBubVckSJEMu4uYN3YQ5UbrxjIe6LHBg5veYDtsnaPK
cm/s2yoSrDTblVYzyshiBNKk0r0/S69P+wCqd3yBDYQPc5HUN4gfTQUaciN+1ENF
samVoKcpx8LqaqJlReiXpcsZ/iyiRSXKndw/iHB1VG9B4LkkwZ9PFWj2zuBmPXsy
mdzNjydV
=W+sr
-----END PGP SIGNATURE-----

--GWx1mH/cSnbo44+p--
