Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F4AC10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 15:31:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEFDB87F19;
	Thu,  9 May 2024 17:31:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F7PoKzgG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 021D6880A1; Thu,  9 May 2024 17:31:10 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7024087EF7
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 17:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-69b5a87505cso5304216d6.2
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 08:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715268666; x=1715873466; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VZUEdv+dLYLdz66vpLkL+yCdcz2CfJajzLe3fr/HGwQ=;
 b=F7PoKzgGY/WzbS+0p08SZRZOXs2UQsrISuusoCHeF0RfjP/DvZv4DnCVt/oRYlpMeU
 ioDNCyBPd/XbojjHP5gnQehhZUCBrukbtmaqlpr8JNBGj00JIyGhYEUTzH7bzBK+MIHK
 S0d1lQ1V9Z8/vXXiC9nD+XpkHW47N+J4FZsok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715268666; x=1715873466;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VZUEdv+dLYLdz66vpLkL+yCdcz2CfJajzLe3fr/HGwQ=;
 b=USSnVxudEqfaqMs0MhAHQ+hX1pDWutAm2eZE6DCfbN1cLB7uG4zmeXXlwqcrV1ZGm+
 kPUz+orgtSlq9XBveVIQzc+uH/au5TB5znH/SnYJSbitHWLH6h917j8VC15mq0D/Esan
 3D+dUr849onb+w0StmwIpozzFDeKhBXW8GDy3dPt7AeqBeAbXm+qUoZSUCw25Bn7zd0L
 Ta31CVydbaE+BSX+ncuWr7xi4ndiRF8jmZKewal5s7DfSQZm3G5WCWQ5XuXD4yiRbGrI
 CHcekASGutCuFlVUpLt2758j+CAAO9drpGNHF2HfgmNXd2rJdo8bq8CKNa8KqcfITLZF
 uXBg==
X-Gm-Message-State: AOJu0YxzJeGReSv5KfYVIRJJBbwKSHTskZmGeuGCt4CLrzP89YWBp/4a
 Gq5hwpq2FN79aPe8Dk5NtrDraZI2kovk0GKlb8+LkR2vF+fB5kEWkkNylgZedhQ=
X-Google-Smtp-Source: AGHT+IEgzPHH0QAQrfmjzBF/I4DKGXIENTIt1Zd+y+h82mWlFtjjYTEcVPW/ABhaibTyunJtpl9RYw==
X-Received: by 2002:a05:6214:19e5:b0:6a0:c990:223e with SMTP id
 6a1803df08f44-6a151442ae9mr74105226d6.23.1715268665725; 
 Thu, 09 May 2024 08:31:05 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1ff95bsm7943706d6.137.2024.05.09.08.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 08:31:05 -0700 (PDT)
Date: Thu, 9 May 2024 09:31:00 -0600
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
Message-ID: <20240509153100.GK2568172@bill-the-cat>
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-4-raymond.mao@linaro.org>
 <20240507211643.GY2568172@bill-the-cat>
 <CAEfUkULdF1R2c=QEOQHQH+8go7VnXnSBKXh2AVYXQt5LkMXy_w@mail.gmail.com>
 <20240509151133.GJ2568172@bill-the-cat>
 <CAEfUkU+Ax6o8NnL=e3Tm+-75HMbXpa5zqMm5TS3EpqY79GAEXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="93kpxuPftO6aWQIB"
Content-Disposition: inline
In-Reply-To: <CAEfUkU+Ax6o8NnL=e3Tm+-75HMbXpa5zqMm5TS3EpqY79GAEXw@mail.gmail.com>
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


--93kpxuPftO6aWQIB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 11:23:11AM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Thu, 9 May 2024 at 11:11, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Thu, May 09, 2024 at 11:04:07AM -0400, Raymond Mao wrote:
> > > Hi Tom,
> > >
> > > On Tue, 7 May 2024 at 17:16, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > > On Tue, May 07, 2024 at 10:50:45AM -0700, Raymond Mao wrote:
> > > >
> > > > > Port mbedtls with dummy libc header files.
> > > > > Add mbedtls default config header file.
> > > > > Optimize mbedtls default config by disabling unused features to
> > > > > reduce the target size.
> > > > > Add mbedtls kbuild makefile.
> > > > > Add Kconfig and mbedtls config submenu.
> > > > [snip]
> > > > > diff --git a/include/stdio.h b/include/stdio.h
> > > > > index 3241e2d493f..874279c60dd 100644
> > > > > --- a/include/stdio.h
> > > > > +++ b/include/stdio.h
> > > > > @@ -3,6 +3,7 @@
> > > > >
> > > > >  #include <stdarg.h>
> > > > >  #include <linux/compiler.h>
> > > > > +#include <vsprintf.h>
> > > > >
> > > > >  /* stdin */
> > > > >  int getchar(void);
> > > >
> > > > Is this really needed? I know our include structure is a bit odd.
> > Should
> > > > we perhaps look at moving a prototype or two around to be more broa=
dly
> > > > compatible?
> > > >
> > > Then we need to move  prototypes of snprintf, _vprintf, putc_outstr a=
nd
> > > printf_info from tiny-printf to stdio.h. Is this good for you?
> >
> > I don't quite follow you but yes, please work it up for review at least
> > as I'm not too thrilled with adding <vsprintf.h> to <stdio.h> after the
> > work I did removing <common.h> showed some fun around those headers as
> > well, and I'd like to sort it out correctly.  Thanks.
> >
> > When MbedTLS native codes include <stdio.h>, they expect to have a
> prototype
> 'snprintf', that is the reason why I hijacked <stdio.h> as we are not goi=
ng
> to
> change MbedTLS native codes.
> I mean in v3, I can move 'snprintf' related stuff to <stdio.h> so that we
> don't
> need to include <vsprintf.h>.

Yes, I would suggest doing a branch where you just make that change to
stdio.h and see what the build fall out is on -next. I would not be
surprised if it requires a bit of work. It's work that needs to be done
and is worth doing, but might be... large.

--=20
Tom

--93kpxuPftO6aWQIB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY87CoACgkQFHw5/5Y0
tyzGmwwAnOxJ+pCp7H3QiOCNZIcHg6E7eMQnwIJDeIb/0BYEz9zYlnwWf/QALqAP
umfmWPWtPB8l03/NL0Ok4MNjHWEGDJq8cVD+Js1A7LNHosF0laqf4S6X05hIKsUK
K37XDOuUH48LLe+hrx87x0E5EKz41PuYMsFI/n7g4cQ+/987IaLLP3lfA0sQ3tOF
Lx/WU0Q07O+gRuhfRItpNU7lapQL18m+i1kFtbTnLNlJcgJKYeFh6E9DExkKpxgR
/2xOH1lM5j4NpiKMSD1qlvXPT1lip8rrOXpx3MESYX60Dnx4UWa+Tj0ncHCX5Acv
zv+51GHSBjWzv7HvMJTkl6Ejr6ZXVSWkRus9/oSe/qxeHxA6wXO6GWlh+cW2bMu/
+ZJC/xsqxZgs2jty9bF3qZm+9m2jiDXof+6o5lzBx+eTZeek0CdOcCv4bTWAyIcn
0gl6oLl7a6YhOKumn9kDWGawI26kElPe4dot3zmjbNaS/Ctps6ByCDE7AEkP2Uda
w1Ld++I7
=Lo1Z
-----END PGP SIGNATURE-----

--93kpxuPftO6aWQIB--
