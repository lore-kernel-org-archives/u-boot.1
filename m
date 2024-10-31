Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130FFD767F2
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 18:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E1F5892AA;
	Thu, 31 Oct 2024 19:11:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VnDUGM5D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 984E488BBE; Thu, 31 Oct 2024 19:11:08 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76191892AA
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 19:11:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6e3cdbc25a0so12810477b3.2
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 11:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730398265; x=1731003065; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jUI5nkTd5bm3QA9qRZRETVzlVT5KQq7JNsmxsv7e1fU=;
 b=VnDUGM5DOMXhnucZP7Kw672TK1PIHwFxMEjUeGpDgnzhmn/cdmRiEYROKTzDqyWSvM
 bdN0YSd6k+RIscMJnmMCflnX0HCZ+5qYW1xsPqAE5kOvgojuExXWYJh7mmlbHE8iuLoi
 LVRe4WolGOBOpPP9cWLUUiMSosC/25Ja9T8Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730398265; x=1731003065;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jUI5nkTd5bm3QA9qRZRETVzlVT5KQq7JNsmxsv7e1fU=;
 b=oOD2ii6h5PIhAOoV5u8u9umh7iagFjWUEV+yCoHB8E4OPnVzEKBXWGTnLD4c1FeYIv
 +cNTDbQKoJH2USzW8MrUPaFyqE/ILOCgmYcRFbMwcWajIlHPIxM1zOlPQIyfcP0Cb/iq
 yTUAF2reGjiEniEZhYxXGIeS+awnQ6kTJrzIKcFceuTfUq5Yawm2n79/oUnaqRvN2ljw
 BJzAYQZPLGA2RJmGNtbd3rNKPY7psD4rumWULJPpfrZU2PFVwa3vDGHgoBBXgHmEBnQZ
 XRh+q6k0gjn9qauWTkrFUMCt3zGhpLvo/ANl6qazzPdJlgxzOOwuf3TOzn+OHLBRTYHz
 i1iA==
X-Gm-Message-State: AOJu0YyCg1CvNOVGFjgKLVbocppmJ0SeOTFy5Cqe5NX9KQqast/33w9B
 JtoH/cJGIPb0WnPpxH3oBPRlE0v3lHTltO1JmoXX+5DMau9sHTa24QPwm+8VlUk8LfPj+SGF/X6
 27A4=
X-Google-Smtp-Source: AGHT+IHjnfGDni40d2qtTEs+JZ6x5LD5lZsG4mihIA+BzalKmUnYJmt2jwS2Gk/5iM4+Z7uDJn703w==
X-Received: by 2002:a05:690c:7448:b0:6e2:2c72:3aaf with SMTP id
 00721157ae682-6ea64bdcd0emr10655507b3.31.1730398264979; 
 Thu, 31 Oct 2024 11:11:04 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad0a004asm9979521cf.23.2024.10.31.11.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 11:11:03 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:11:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] test/cmd/mem_copy.c: Use CONFIG_SYS_LOAD_ADDR for base
Message-ID: <20241031181100.GW2558755@bill-the-cat>
References: <20241030003649.3506474-1-trini@konsulko.com>
 <CAFLszTgPA0vGCWLw3m_KHVCs7=hCouOGhSeZAx3XxWBHtP7oFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QS3xHEHPMndXmNwT"
Content-Disposition: inline
In-Reply-To: <CAFLszTgPA0vGCWLw3m_KHVCs7=hCouOGhSeZAx3XxWBHtP7oFg@mail.gmail.com>
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


--QS3xHEHPMndXmNwT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 06:51:52PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 30 Oct 2024 at 01:36, Tom Rini <trini@konsulko.com> wrote:
> >
> > When reading/writing to memory we cannot assume that a base address of
> > 0x0 is correct and functional. So use CONFIG_SYS_LOAD_ADDR as the base
> > from which we add a bit more padding and being our tests.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> >  test/cmd/mem_copy.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/test/cmd/mem_copy.c b/test/cmd/mem_copy.c
> > index 1ba0cebbbe04..67eca328777a 100644
> > --- a/test/cmd/mem_copy.c
> > +++ b/test/cmd/mem_copy.c
> > @@ -21,7 +21,7 @@ struct param {
> >  static int do_test(struct unit_test_state *uts,
> >                    const char *suffix, int d, int s, int count)
> >  {
> > -       const long addr =3D 0x1000;
> > +       const long addr =3D CONFIG_SYS_LOAD_ADDR + 0x1000;
>=20
> CFG_SYS_SDRAM_BASE would be better here, since it is the start of
> memory (0 on sandbox and most boards).

Why do we want start of memory? CONFIG_SYS_LOAD_ADDR is the address for
where it's safe to load things to memory and fiddle with them.

--=20
Tom

--QS3xHEHPMndXmNwT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcjyDQACgkQFHw5/5Y0
tyz3yAv/fHLW2rh8o+7THK1lTFr+pOBxeIzOKScy6sWtE+KtV5Rlu7wGvy2UHaFc
FxypMa5mC/xl1hBNn4Xv/+vSEhgHJdQG5eepYxwWztJ1rwj0as9ilIXsfB5WYwOv
oKfUYos52xXPGbMAlVtP8XAzc1+aptxUaVKuKpOBJTB1SnV87Eoou82uTumVGBqb
YlhFIQv1XmKPya3mbMY6oawgAUCi4Kmu3xUao8kluZilTMu+r2ZAo+oQbrbeOua8
FvahnB5dGD9i1xKTMZ6/L2tJU3h5wmkjee7v7RARFkteO8B/COcj+yrF/10AMLJi
/hqfiB9pzjOo2TEvmiW2LUWukvcxo7Z75TVdq83ZDzO90Uw24uv4s28LJeqp6u45
Xt2FrxTI2lPAi/I3DeeuYujdt0bKvelGMxnXFmVGaNwy1DLpLgB+o9iB7Jq9ZoU1
0msXYhE3OTus5ktz9mcFi4A3VK4XLgFJRu/15KIUdtMkJ2howAwUCWQmf7qN3vo5
y4O1uZoj
=FJ4N
-----END PGP SIGNATURE-----

--QS3xHEHPMndXmNwT--
