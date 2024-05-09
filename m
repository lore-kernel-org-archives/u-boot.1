Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A68C10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 15:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 863208814E;
	Thu,  9 May 2024 17:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ruAh/SwQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DA7588140; Thu,  9 May 2024 17:11:43 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C95987DEA
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 17:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-792bd1f5b28so76887485a.2
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 08:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715267500; x=1715872300; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=em/Vr59VRTWOEMtKo+XCUJZ3uWwwuy+3iCHiV0a3A80=;
 b=ruAh/SwQ9DhWPqzJstIUxh1eIwv1OeV0YtfCZD27QqI8oQerTpJgjMc+WlOJf1Ln1u
 90C4P7verCRl60oilRiJu0mz0OfhPkQEpwBXMcaCvodFubwh9H6Ay1ZZvq9yq3i8emny
 tswrgi3ZoGJcHgSiOd3Vy089P3Td5oUmu1W8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715267500; x=1715872300;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=em/Vr59VRTWOEMtKo+XCUJZ3uWwwuy+3iCHiV0a3A80=;
 b=XPIw7twQr0xMOsljclVyPJuXkZHUvPEt2HMVY2kpAzyNzNnIEpLqeLUW78IevDUtwB
 2OGljHI38AnYTWVj7NHoeO1e3W7loWWgFAR+YDth36IEzdzPoplzRilHRghINHc3kbF9
 fnf17Bgab4X92LftH1TsuUYr0Yy02OTu4DNECu5H4EcW91hVaLJxb4an8IZRtZ5+QbU2
 f054//P8PiQT2sPNYNsntxLkcb+cbIKtqIjKaXVe/AyyD9yD0PAl7X4Fp6dcYdwxDRWd
 +N0ZyjmWUW6+96TFdCL3x0E5bMb6DdwQTrUXMKccrPZXplE4AWnbH+ctbfsBBo4VMDrR
 p4rg==
X-Gm-Message-State: AOJu0Yy7uqrgMfGIVpXb1H7K1GZ2WwtCfqkq8IAOd/Fea8a+WZg88riC
 C3YvkSQBX5CIqCEJHMmXVFjILQU3j6lY/mNwgrN6y7B9l43l64DCbMi0KkmtvE0=
X-Google-Smtp-Source: AGHT+IHP8GGMCIQ6KasI5533HYkrZ/9SGwyjttn2+l7egVLuTVUglRB0EYWTqkdytwhAF1N/C/j0Ig==
X-Received: by 2002:a05:620a:13d0:b0:792:c330:5da7 with SMTP id
 af79cd13be357-792c3305fbemr101023585a.76.1715267499812; 
 Thu, 09 May 2024 08:11:39 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf2a11e8sm76342685a.58.2024.05.09.08.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 08:11:39 -0700 (PDT)
Date: Thu, 9 May 2024 09:11:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Andrew Davis <afd@ti.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Sergei Antonov <saproj@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: Re: [PATCH v2 03/28] mbedtls: add mbedtls into the build system
Message-ID: <20240509151133.GJ2568172@bill-the-cat>
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-4-raymond.mao@linaro.org>
 <20240507211643.GY2568172@bill-the-cat>
 <CAEfUkULdF1R2c=QEOQHQH+8go7VnXnSBKXh2AVYXQt5LkMXy_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qIyZz/t92SpLiCp1"
Content-Disposition: inline
In-Reply-To: <CAEfUkULdF1R2c=QEOQHQH+8go7VnXnSBKXh2AVYXQt5LkMXy_w@mail.gmail.com>
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


--qIyZz/t92SpLiCp1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 11:04:07AM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Tue, 7 May 2024 at 17:16, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Tue, May 07, 2024 at 10:50:45AM -0700, Raymond Mao wrote:
> >
> > > Port mbedtls with dummy libc header files.
> > > Add mbedtls default config header file.
> > > Optimize mbedtls default config by disabling unused features to
> > > reduce the target size.
> > > Add mbedtls kbuild makefile.
> > > Add Kconfig and mbedtls config submenu.
> > [snip]
> > > diff --git a/include/stdio.h b/include/stdio.h
> > > index 3241e2d493f..874279c60dd 100644
> > > --- a/include/stdio.h
> > > +++ b/include/stdio.h
> > > @@ -3,6 +3,7 @@
> > >
> > >  #include <stdarg.h>
> > >  #include <linux/compiler.h>
> > > +#include <vsprintf.h>
> > >
> > >  /* stdin */
> > >  int getchar(void);
> >
> > Is this really needed? I know our include structure is a bit odd. Should
> > we perhaps look at moving a prototype or two around to be more broadly
> > compatible?
> >
> Then we need to move  prototypes of snprintf, _vprintf, putc_outstr and
> printf_info from tiny-printf to stdio.h. Is this good for you?

I don't quite follow you but yes, please work it up for review at least
as I'm not too thrilled with adding <vsprintf.h> to <stdio.h> after the
work I did removing <common.h> showed some fun around those headers as
well, and I'd like to sort it out correctly.  Thanks.

--=20
Tom

--qIyZz/t92SpLiCp1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY855sACgkQFHw5/5Y0
tyxBaAv+MFXoLAk4etisJqtPOVHDj7u444SmspII6SZbIUfE2/fJloqPdFwL1Btl
8Wc6wNBiTbxXQmN9HlAAzjnuUqkO/uGzSL9rkErE+7sDGf/wQekzAPqar7RLYoun
7+VJLe/UIjHK4Ep+fhcI7rLQZfDASJPQeF91lvUA/f8is0q8Ks0WHKZ0uWxreGhs
v2kJd3I6xfe1ogvQpZ9XpyDibnSB+NW0bVH7gwspOq5ji64XkWRvjj+jTxIwbZw+
Fg72WQqDysi6enc2MED/STBJN63dlonaHtjT2P82dRGl0bmq8HcIgMB2hs6Jusjh
/r8XudcFoba0nU1A75ru5kNbTy3ODkmkdi12//8Wxg8aImRuaILQMisKIGdmG980
BhBYQn4Pot1mzG6G93wxStagXRyyL9OOnw13MdH4n35XsEaA0hzypJKDSM7kgmyL
uWwyrWwVi3T1lhpFjeXktwFmChM4ZQx5FyvbMCBiKC9aVKs7DM2SQ1Iuk/mz2DUo
hKoAXuUA
=NgwB
-----END PGP SIGNATURE-----

--qIyZz/t92SpLiCp1--
