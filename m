Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0BAE6BF2F
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 18:11:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B2D384523;
	Fri, 30 Jan 2026 19:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Xw71R8tt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4080D8452D; Fri, 30 Jan 2026 19:10:58 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03517844C0
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 19:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-79274e0e56bso24817667b3.0
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 10:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769796655; x=1770401455; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6JZDzRTljtGypfYP6cZSu4Ps3UyRacUAm1+j/k+MC74=;
 b=Xw71R8ttAxdEod2jWxXf3E0i1glWxaO8X5EJ/QI240A/tWOflBx/UgB3PgOUtUhvz5
 AYd14GhYlRtds4N50pROSyrWWpRygLutkXFmCaPkuMSfMNSBh48UkAQxJpN4xi7MqfCj
 SwxWf5iee4CdQHqL0iaBiK7kkwCobeBGfzSEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769796655; x=1770401455;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6JZDzRTljtGypfYP6cZSu4Ps3UyRacUAm1+j/k+MC74=;
 b=tcEyYFxvKhf6r+YiauFTBAlgP16lMsSHNYaYAkSxCe1yyE/bebHO1jS0cIBVBfV0T8
 6nAASvsyrIH6osbmkn4YhRho9qeFSHbH/4w8V/r2jMDHgZTN1ZX0wex+wRLr2lbzv1X0
 TlavtFxeOxR8QQENYqmucfLnh3mYJaMvvZiAJAwymlfz9MGtVpgwHUYbD/cqhjunzOG6
 1iIHgc0t4a4V7/IspAWbamoJVoNbLcJqtUPVNpCr9HhNxyN4WtVl25oYMF9HbugkVWem
 JC22PH+GvamHDa2exYamwrgt6MT1p9HKwtvT3E8ntbaEwUcXE7X/zowMmxxbm0ST0f6R
 2hnA==
X-Gm-Message-State: AOJu0YyX456SS/0wVSQbUHt+tVUzE94BHR1U7kJhNmUS5Nb4gIrWWwAW
 xeVqVdECQepf1LbeWQVWCVXjlMYWlplYMzxdMC1wMOCLlXlOEgudLFgEinlSI7/yLBsPAf6V1uV
 hIx9E8sk=
X-Gm-Gg: AZuq6aKQALWgJ2AsTm6vdkEXEh2IX9/qXXuZP4GeQV6rQRywonba6MqFGNnc0LvQw5a
 lDgpPm37yIQvAVgKuNEAX9VCk1q9zpBhKXz38ala2Kgw7JJqEUCBSK+MdHCwcjCn/+GvVGl0al7
 a+PPCXvdffIYQwuhuvl01O8R4AxiVKuuh7LERWIpDaxRP+rnm+eE6HinOJQwCOF4cOM2s38riAz
 D9fklXG+3y3Heg//HXGM3hrDwKy/tqt31GxUyEA5zBHoyB4rW8lmCb13xLqyfFxTPufkD3ZkPnr
 YkzRRxvDqcEpfWEtghstjm2blzFQMvJJ8NWu6tBMRmsxnAxZrLqiHI9y9LYhNqJ+ZTEoP6cs7Qq
 14m3FA0eMZ3S/SQcAwfaF7E5aDDzy7x1+d7WgKj0UiYz1Rfs3BTBO3bWc6INQkAAg9faTBdvKBK
 UkGRqPZq3HJ8sM68uJSjFHjEXG8jTkOcyzyBjBXXaE1IZb3HHWbVLjx9Pc6Tjzqe01jMoUAjBrb
 GduhDCG8K4rnUDjhke0P9yit0V9bwKzX+a08Pw=
X-Received: by 2002:a05:690c:399:b0:787:cad1:bdb2 with SMTP id
 00721157ae682-7949e060c04mr28929737b3.69.1769796654498; 
 Fri, 30 Jan 2026 10:10:54 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-794828a9be2sm38420787b3.33.2026.01.30.10.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 10:10:53 -0800 (PST)
Date: Fri, 30 Jan 2026 12:10:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1] Fix unbootable ARMv7 devices
Message-ID: <20260130181051.GA2603314@bill-the-cat>
References: <20260130031217.998002-1-briansune@gmail.com>
 <20260130145528.GA2421612@bill-the-cat>
 <CAN7C2SCixc3Ug+MsfMj5wnJVVPQSa3QS7frkXvj90LsY09ehQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xncNK1Jj2hGtwpUR"
Content-Disposition: inline
In-Reply-To: <CAN7C2SCixc3Ug+MsfMj5wnJVVPQSa3QS7frkXvj90LsY09ehQg@mail.gmail.com>
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


--xncNK1Jj2hGtwpUR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 31, 2026 at 12:50:17AM +0800, Sune Brian wrote:
> On Fri, Jan 30, 2026 at 10:55=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Fri, Jan 30, 2026 at 11:12:17AM +0800, Brian Sune wrote:
> >
> > > The linker script u-boot-spl.lds now
> > > is no longer aligned and -nodtb.bin ending shows
> > > the zeros are not 8 byte aligned. This result in
> > > the Makefile.xpl simply think the previous file
> > > is aligned and do not zero pad. simply fix the
> > > data align to 8 can ensure the -nodtb.bin is aligned,
> > > hence, the formation of u-boot-spl.bin properly align.
> > >
> > > Signed-off-by: Brian Sune <briansune@gmail.com>
> > > ---
> > >  arch/arm/cpu/u-boot-spl.lds | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > This fixes your problem in that it results in the device tree being
> > aligned still, but doesn't solve the underlying problem of why there
>=20
> No it is not 4 extra bytes but 4 bytes short on the latest master commits.
>=20
> > were 4 extra bytes. Can you please try:

Yes, we're off by 4 bytes. Sometimes in one direction, sometimes in the
other. I believe in either case it's because of not accounting for a
non-empty section correctly.

> > diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
> > index c578c3ebf821..5f807323f856 100644
> > --- a/arch/arm/cpu/u-boot-spl.lds
> > +++ b/arch/arm/cpu/u-boot-spl.lds
> > @@ -31,16 +31,16 @@ SECTIONS
> >                 *(.data*)
> >         }
> >
> > -       . =3D ALIGN(4);
> > -       __u_boot_list : {
> > -               KEEP(*(SORT(__u_boot_list*)));
> > -       }
> > -
> >         . =3D ALIGN(4);
> >         .binman_sym_table : {
> >                 __binman_sym_start =3D .;
> >                 KEEP(*(SORT(.binman_sym*)));
> >                 __binman_sym_end =3D .;
> > +       }
> > +
> > +       . =3D ALIGN(4);
> > +       __u_boot_list : {
> > +               KEEP(*(SORT(__u_boot_list*)));
> >                 . =3D ALIGN(8);
> >         }
> >
>=20
> This patch will create the same result but the actual problem
> never caused by the -pad.bin.
>=20
> The bss size is 8 byte aligned hence it will not be the issue from
> first place at Makefile.xpl as it will not create any zero pad.

Right, the pad file is created the correct size.

> The issue here is that the nodtb size itself size is never 8 byte
> aligned at the end result in short or long cases while the
> Makefile.xpl only creates extra zero based on the bss size rather than
> the nodtb size.

Yes, the nodtb isn't aligned, but it's supposed to be.

The ASSERT statements we have mean that the ELF object is correct, but
when we transform it, we're breaking it.

> Then they simply join nodtb + pad + bss but from first place nodtb
> is not sized correctly at the end aka 8 byte sized.
>=20
> Any method that can make the end back to 8 byte size of the nodtb
> should do the job.

It's a two-part problem. The file has to be aligned, and we have to
place the dtb at where __bss_end (in the case of SPL_SEPARATE_BSS=3Dn) is
at run-time.

> > As the problem ends up being that when both of these are true:
> > - .binman_sym_table is empty of actual .binman_sym* symbols
> > - The inner '. =3D ALIGN(8);' increments the linker counter from the
> >   previous '. =3D ALIGN(4);' (in other words we were not already 8b
> >   aligned).
>=20
> So what you are suggesting is that the section of  binman_sym_table
> is empty so the ALIGN(8) just simply cannot do its 8 byte alignment job.

Not quite. When we say "ALIGN(8)" we advance the linkers program counter
but that's not the same as saying "add bytes of 0x0 until we reach the
counter".

> And reversing the order makes sure it will always ALIGN end with 8.
> But does "__u_boot_list" result in an empty case? If not then this
> indeed do what I also wanted to.
>=20
> I intended not to change any ordering to fix the issue.
>=20
> Brian
>=20
> >
> > The linker sets the type for this section to "NOBITS" which in turn
> > means that when we later call objcopy to create u-boot-spl-nodtb.bin we
> > get a mismatch between our expected size and actual size for creating
> > the -pad.bin file.

Which is what I'm explaining here. We have to make sure the last section
before the BSS is something that will never be empty. That's what makes
sure that the final ALIGN does what we expect.

--=20
Tom

--xncNK1Jj2hGtwpUR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXz0KAAKCRAr4qD1Cr/k
CpkLAP9KOEXxRvNsZ+HQTBF9O2/Mqo4PqSkMJNK3+cww0VJscQD/dgXl7z13fnxr
EvrKqyPjfEUG2IDEYKCu6myIZJzifg4=
=nrOr
-----END PGP SIGNATURE-----

--xncNK1Jj2hGtwpUR--
