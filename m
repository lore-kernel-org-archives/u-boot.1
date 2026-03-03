Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165ABEDA693
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 15:54:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9375D83F63;
	Tue,  3 Mar 2026 16:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LNwTLDK0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DB0183F64; Tue,  3 Mar 2026 16:54:11 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 043DA839DF
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 16:54:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-463a0e14abfso4702990b6e.2
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 07:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772553248; x=1773158048; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hf/HlvEXMVgVjvD+9vuhTY62aKIIML1BoUsk1RZUE1U=;
 b=LNwTLDK0HtBs6JB4c7IUYi9hZBPBMBr614ND1ssITg2F7sZrUYKUt6ziEFShm//aGP
 Qt//6R/6hzDnfi2sDZ/6uFbYJhpGFUHE6554sHLdXx8FTzs8g/mgLwzF8V0B7V9EbeHc
 3m3SFcCbe5dPL+Uy1KESsHBZfUls+Q5NWE+t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772553248; x=1773158048;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hf/HlvEXMVgVjvD+9vuhTY62aKIIML1BoUsk1RZUE1U=;
 b=WiWf8uJQxQOHYJ1qDJV743nsnX3loLJPbg0efxPVnJUmdYhPPD7lzFu3XIxK4wvtAo
 A3P8nUc255KODTyvw8PgaPgqz4tbJ9GlNEMfPMbbxdmsBmqukujOi2dVUM13D9auW/31
 uXvDhfEIDARq5MJdgZKlD8D/0SjGLgOao74BOwAXcunUk0GruK9FLj+okb/33nhsnCVu
 J8JzFrCi8kz3dml2N3xuM+kDjWk1/1csemDTmjmCMpC9lxWPhuRiMDWyiBa9D32BAfgs
 eSbgc3bECe5EPbSXCNHUb3S+PT6mUfZIkFJq9U86xFF4pVO8ysQlmQbohy73s0l68aKV
 C9dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwbQgUImL5NNsnDv015SNGEnKIRlgIIBr37+pO7bImIoHKsRF3yZRfOQwSSPpHT30Oj2ZiqoE=@lists.denx.de
X-Gm-Message-State: AOJu0YxIwxs1LvY4cY7Q77CzbMHorIq9vjEdKqaiKrzyE+XaiFpyUxX+
 SU26Ggar/jXAJxQNbxm/+rHPPfdvD+aV7y64VDCdBw95Bw1kwrVASJS6HoVpfjR+FCQ=
X-Gm-Gg: ATEYQzxuMDFla5YPIaGXJ0xoG/nW/GdHqzeUmdVksGHp+mm2KfGcOWgHjArzIVtV3O7
 KQj83EACd8dE6s/0cUfxkG4ckX/uLSPxXU2tMZzuhUlfeOKvVcVIKdhsO0ZoKEjaAC8J85ICzR1
 TLDUg39yWXAgg9m6ZX2kcGCdAH8T1uNmMfiojRIs3PgfbBq4YgROg35nDKQC7e18PfoJmJv04uK
 WUweq9g3BxDiGnPuxO/g7HinrNDALQFpriybxANbSaFaslVqPVSgULYlIaILBTwEhAjfsviw86p
 d+pxdx0MJobLGfYMlSn2ItjLaruHRbMk6JXLfc7kWw3Calui10ZXXUAAoq9wSmYtQtRst4Qfc9k
 iPN3ooM23aAmbEMwuNBsPM23EXPakpk1bTK3isCrPwDkeWRrm5IHYzDRY8eIjA4Wl78DpkQ+JUe
 SiZV38gxuSoR+seTj8UXEM0Rz9AG+MroyBrOik2bJxtgM53FQybYxbIPkLVC67SMczGcFUdKgJR
 HRBCBMVD2fUe89i6kYLvAKEK8wxA4KrJf+G3xPgmwxJn6vEKjU=
X-Received: by 2002:a05:6808:ec9:b0:45c:a040:e53c with SMTP id
 5614622812f47-464beb41ac0mr8835043b6e.32.1772553247668; 
 Tue, 03 Mar 2026 07:54:07 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb60e6absm9932768b6e.19.2026.03.03.07.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 07:54:07 -0800 (PST)
Date: Tue, 3 Mar 2026 09:54:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>, u-boot@lists.denx.de
Subject: Re: [PATCH] FIT: Address Secure Boot Bypass for Signed FIT Images
Message-ID: <20260303155405.GP1388590@bill-the-cat>
References: <20260302220937.3682128-1-trini@konsulko.com>
 <1c8f8282-7ec9-440e-bfbe-2494f5ea69c8@pengutronix.de>
 <CAFLszTjSxQ5Q2HGEqiRVH5VnG1M8++F=MVWWrSJg6HuTmzckFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Dh9wjWMOfIg9edzu"
Content-Disposition: inline
In-Reply-To: <CAFLszTjSxQ5Q2HGEqiRVH5VnG1M8++F=MVWWrSJg6HuTmzckFw@mail.gmail.com>
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


--Dh9wjWMOfIg9edzu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2026 at 06:32:50AM -0700, Simon Glass wrote:
> Hi,
>=20
> On Tue, 3 Mar 2026 at 01:09, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >
> > Hello Tom,
> >
> > On 3/2/26 23:09, Tom Rini wrote:
> > > There is a flaw in how U-Boot verifies and generates signatures for F=
IT
> > > images. To prevent mix and match style attacks, it is recommended to
> > > use signed configurations. How this is supposed to work is documented=
 in
> > > doc/usage/fit/signature.rst.
> > >
> > > Crucially, the `hashed-nodes` property of the `signature` node contai=
ns
> > > which nodes of the FIT device tree were hashed as part of the signatu=
re
> > > and should be verified. However, this property itself is not part of =
the
> > > hash and can therefore be modified by an attacker. Furthermore, the
> > > signature only contains the name of each node and not the path in the
> > > device tree to the node.
> > >
> > > This patch reworks the code to address this specific oversight.
> >
> > Do I understand correctly that this is a breaking change
> > for FIT with signed configurations?
> >
> > - New U-Boot hashes more than intended for old FIT
> > - Old U-Boot hashes less than intended for new FIT
>=20
> Yes, that's right.
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> I can see how this works. Please see nit below.

I did fail to run this past checkpatch.pl and will fixup when applying,
thanks.

--=20
Tom

--Dh9wjWMOfIg9edzu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaacEHAAKCRAr4qD1Cr/k
CnG9AP46k58ait26WjQ6aeD5qSMe6pzZ3KII2XxJ0qb0Lf4sNgD/Qy1TuwERT5Qk
/YErK1TjwH/G60Ky/N9Sj1tiXtldkAE=
=TAn3
-----END PGP SIGNATURE-----

--Dh9wjWMOfIg9edzu--
