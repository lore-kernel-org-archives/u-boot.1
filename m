Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57151D13C2E
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 15:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8F0283B27;
	Mon, 26 Jan 2026 16:18:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HJNktN0J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F20A183C29; Mon, 26 Jan 2026 16:18:37 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF73C83B0B
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 16:18:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-45c719bb855so2674248b6e.1
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 07:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769440714; x=1770045514; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Fk4aWTa0o+1XKbnXgahVZkno8veHcDvyx0nHfSMog2g=;
 b=HJNktN0Jpfd4KE6mqvQrVaKPN+GOxKSbCuGp+bEKI3zNkOC43vS9zSM17w9vG6STtF
 H6wHJghKjr6CBrHOlcilChZNhvdjycCi+t28esd7ZbZcDe11Dzj5INusPYGi8Lf964PI
 aGV/AcJLgz++4/2iqMzeeH9su2GDDo0Tt++dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769440714; x=1770045514;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fk4aWTa0o+1XKbnXgahVZkno8veHcDvyx0nHfSMog2g=;
 b=GZPDS8o+Tu3EBaRG+4ZJCwGYrzVOuEp9zGD0Wu1cpbliOgROmHu938vSCe+pncuU/A
 YjaHmKn08vbUk2B9qWEZoipp+xQlrk8KqImSClml54Tp3fwV1+rKlJcE3vd7QQqBxgSS
 YAsXW80HxU2jifgdmXsyNCmLQ7SI7WicbQGHYs+SEP8b0YLuYLC7hJPopZTjpp9o0gb5
 4jk03XEyWF/i8bLJGfvw2b1edDNAuUfcDNACXgYab7Mrlb5I9REW9fjK+6PVAETc8cjv
 Z/ZuReZglZaAG13cuoo1I++zoBjAexNuqKZSwkKQmTiwVxGzTQFNfCmnbW68pN1ka10y
 6zcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbxpPQYcWx4H/2d2Ds0hQpIA9+OcX/vUp1NqqhRUK9ikP/k5mrDTQwjxqAC14LzjQhJJbKOfk=@lists.denx.de
X-Gm-Message-State: AOJu0YznGGTxG1Cqx9SUwoMyOwwVI9xUrLrrOIzet9KBl7wCN/ZboWhl
 HHb/5700tlTR08RwDctwXc0C2hr/kM4sgwPU8o6F2VLrntXyeO/rQrIQKWwVC9A0yNwEV32zaiI
 LEBDbawY=
X-Gm-Gg: AZuq6aLrpCnPIWF/L+Fi79lB8tkDS8qc3WycHOetqS5t/EtK4JnAqk+TaFk2hqf2OjP
 Odiml+xW0hChPkcn64o8ZzPNk/x6lZRNq+nuCyan16yrD73Too5ZKudy44rreiHn47qxthG4DMx
 fix9geqqv4CJ+gJEwH8g29pokf74owpEHFe6hCbeOUWpQ/LEZeRQJSL5H09FjrUZd3ZOl+96YAs
 zhBimu71vPt8qOUVTp9fVRfFd9SUEsCiuX7U+gQ2PMgpSbQA7PsyskJyLBN6iNyjiuklOxuNX1m
 u3ORCPWj/rMCUBvwB+mpWo0Gl5IT+WM+3XfmDIrdXZYGW+w/UHqQHNTolgi0oPcRLVB6SM8AKe1
 Xa3NQETvD1HAbME6lWLiJpuiMcNF4+FPHl3CMm5aN/deni9Qfv2eegYVGYsJNslw3u7g1uOebKn
 pwja/gZj+biaN46znUxS18FJfuGos+Re784JVvKorKU7KxAhuNlE6XWUy2VcaEk/E/6D3mfz/Ql
 GG1oK4CdGlSlxHERQuoH8E4sdDWlRr39vuAKp4=
X-Received: by 2002:a05:6808:bd6:b0:44f:e912:eaa3 with SMTP id
 5614622812f47-45ed99cfa89mr1999131b6e.32.1769440714348; 
 Mon, 26 Jan 2026 07:18:34 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45eb42530e9sm6203328b6e.16.2026.01.26.07.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 07:18:33 -0800 (PST)
Date: Mon, 26 Jan 2026 09:18:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>, marek.vasut@mailbox.org,
 u-boot@lists.denx.de, sjg@chromium.org,
 Fabio Estevam <festevam@nabladev.com>
Subject: Re: [PATCH] arm: spl: Fix DTB offset after binman symbol table
Message-ID: <20260126151831.GT3416603@bill-the-cat>
References: <20260123161907.392211-1-festevam@gmail.com>
 <20260123201202.GO3416603@bill-the-cat>
 <CAOMZO5DVFO=A6g1CWOrRbqy4VNgL+VcUw0Q5pgELXm30puGz4w@mail.gmail.com>
 <CAC_iWjJ5gVzOP_6cgxEbUJn8a=KRj=-wEFy=Do7Dp8oqH3V+Dg@mail.gmail.com>
 <CAOMZO5D5awN11z8Hxwr4+tunqvhH8fYbUJvU6McES=edi2OR4Q@mail.gmail.com>
 <CAC_iWj+BYi5mhE9+NUWTgByKZiH6E-XYt64G2JBdHRT4XY=bOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2JMD/4pxUBMqdj1j"
Content-Disposition: inline
In-Reply-To: <CAC_iWj+BYi5mhE9+NUWTgByKZiH6E-XYt64G2JBdHRT4XY=bOA@mail.gmail.com>
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


--2JMD/4pxUBMqdj1j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 05:12:56PM +0200, Ilias Apalodimas wrote:
> On Mon, 26 Jan 2026 at 14:45, Fabio Estevam <festevam@gmail.com> wrote:
> >
> > Hi Ilias,
> >
> > On Mon, Jan 26, 2026 at 3:29=E2=80=AFAM Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> >
> > > Fabio can you please try this
> > > diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
> > > index d780a5060774..af9f3a3c39c0 100644
> > > --- a/arch/arm/cpu/u-boot-spl.lds
> > > +++ b/arch/arm/cpu/u-boot-spl.lds
> > > @@ -51,8 +51,8 @@ SECTIONS
> > >                 __rel_dyn_start =3D .;
> > >                 *(.rel*)
> > >                 __rel_dyn_end =3D .;
> > > -               . =3D ALIGN(8);
> > >         }
> > > +       . =3D ALIGN(8);
> > >
> > >         _image_binary_end =3D .;
> > >         _end =3D .;
> >
> > Yes, this works. This is a partial revert of 8b0ebe054bb3.
>=20
> Yea, i don't want to apply this, just verify what I am seeing.
> So, Tom the bss size doesn't have to be 8b aligned (look below). It's
> worth noting that we  do have some implicit assumptions in our asm
> that rel{a}.dyn must be 4b/8b aligned in armv7/v8 respectively, but
> that's not what's happening here.
>=20
> We want _image_binary_end to still be 8b aligned etc. Since ALIGN()
> has been moved into the dyn section, we now create a section for .dyn
> in SPL that was previously empty. This new section also gets copied by
> objcopy. That section will be 0 or 4 bytes depending on the alignment
> of the preceding code. That's what blows up on Fabios set up.
>=20
> We can probably apply the patch you suggested, but we need comments in
> the linker script + an update to the commit message

What should the commit message say? I'm loathe to add big comments at
least to the linker scripts because while we hit this on armv7 it's
another case of needing to modify most of the linker scripts. But a "/*
Ensure alignmnet for device tree appending */" is fine, esp since git
blame will point out the real details in the commit message. And since
you mentioned on IRC maybe being able to turn Fabio's hexdump in to a
build time check, we really need that too.

--=20
Tom

--2JMD/4pxUBMqdj1j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXeFwAAKCRAr4qD1Cr/k
CuHmAQC37wy6OW/RuR+Uy3PiTBYYXckXHJkNfbyR/Y0xq9Y/QgD/ROoDtxSgpPct
4JszFzp9aVvuLiij4jbm9szQV0jcygA=
=tSY0
-----END PGP SIGNATURE-----

--2JMD/4pxUBMqdj1j--
