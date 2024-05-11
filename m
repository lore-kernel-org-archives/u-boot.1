Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A613CC25B10
	for <u-boot@archiver.kernel.org>; Sat, 11 May 2024 01:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B31E488027;
	Sat, 11 May 2024 03:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JEyrsbmz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1A4D8803A; Sat, 11 May 2024 03:44:33 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EC0287FEE
 for <u-boot@lists.denx.de>; Sat, 11 May 2024 03:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6a077a861e7so17791426d6.2
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 18:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715391870; x=1715996670; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NBWerHbVJ9b4/Ewjbzy4q6EABQgBt7+j4eWMYgr9Z4c=;
 b=JEyrsbmzcng7Wtf/0sxjka4zpphDkOXe1VMhDvDIlHBC43uP27pecQLM98HPt8FqJW
 PnC0KlPZIE/XH3SKGQY/Ko/jHjfetmuNVbffingQGt9O2Sl3/FCVNXhYlXHa3zUwyRCB
 y44eYRhxCWwziUPSF2k35cYithSlkM7NCC2DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715391870; x=1715996670;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NBWerHbVJ9b4/Ewjbzy4q6EABQgBt7+j4eWMYgr9Z4c=;
 b=YpJ441zWyolPyaTND1NTD910SbtBj9sksCNrgCbfg+EYqIWO6yGZBVhl4zQztU82tI
 OBUkL3QTvcxRkfQHuSralztj/7Pn7MpipJH/xRSjLY4BAG8YRGD8x0NTqUTvJsS6pfOo
 ZSLj/2aW69J/ucatLWpz3rRKWB9ObCJglnIAhDNADfQ5LcanR+pyA8ZIqBrIaEhdHoKZ
 kTu/Tug0H3XsT6SS8pr8LiESi66XYlbPskPuy5YhmgSL7WZaQFhia6eJTNp8P9IhctTI
 vITQ04OxOxS+i9DALgAHPEI8uHlMzo661RMuG1npNJVAv03I+H36tBS2Hua8vJdgwAPr
 Vb+A==
X-Gm-Message-State: AOJu0YxjVSFIPCjMuaLwpH0WL4ozPUvnFIz7u4oXTRK5MI590g2qDmIF
 2K+eNCdrkczVje7GDevJsm1lfEhznkxFg5cRAwPgdIWuwhwwhuRyBRe/6wwG6CI=
X-Google-Smtp-Source: AGHT+IFfacxCLlO0UolKWK1Ba8Jmg52HWvn2eiOUIleJwjdUQPZG8d67gjcD/XCL4ChNdRpJ85ebJw==
X-Received: by 2002:a05:6214:3a09:b0:6a0:84f8:6b85 with SMTP id
 6a1803df08f44-6a16823d998mr50397296d6.53.1715391869904; 
 Fri, 10 May 2024 18:44:29 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f194c88sm22092606d6.65.2024.05.10.18.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 18:44:28 -0700 (PDT)
Date: Fri, 10 May 2024 19:44:23 -0600
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
Message-ID: <20240511014423.GA2568172@bill-the-cat>
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-4-raymond.mao@linaro.org>
 <20240507211643.GY2568172@bill-the-cat>
 <CAEfUkULdF1R2c=QEOQHQH+8go7VnXnSBKXh2AVYXQt5LkMXy_w@mail.gmail.com>
 <20240509151133.GJ2568172@bill-the-cat>
 <CAEfUkU+Ax6o8NnL=e3Tm+-75HMbXpa5zqMm5TS3EpqY79GAEXw@mail.gmail.com>
 <20240509153100.GK2568172@bill-the-cat>
 <CAEfUkULtQdPYmSdj0qgRaWsNBQvxSFZP00+u0F57J4K+tLhfyQ@mail.gmail.com>
 <20240509154306.GL2568172@bill-the-cat>
 <CAEfUkULvHMqdD4ZaF7kXthoBvvEFb5DZEUgw5UyoWf1xoU8HLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rdib+oFRns8d3znl"
Content-Disposition: inline
In-Reply-To: <CAEfUkULvHMqdD4ZaF7kXthoBvvEFb5DZEUgw5UyoWf1xoU8HLQ@mail.gmail.com>
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


--rdib+oFRns8d3znl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 09:09:13PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Thu, 9 May 2024 at 11:43, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Thu, May 09, 2024 at 11:36:37AM -0400, Raymond Mao wrote:
> > > Hi Tom,
> > >
> > > On Thu, 9 May 2024 at 11:31, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > > On Thu, May 09, 2024 at 11:23:11AM -0400, Raymond Mao wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 9 May 2024 at 11:11, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > > On Thu, May 09, 2024 at 11:04:07AM -0400, Raymond Mao wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Tue, 7 May 2024 at 17:16, Tom Rini <trini@konsulko.com>
> > wrote:
> > > > > > >
> > > > > > > > On Tue, May 07, 2024 at 10:50:45AM -0700, Raymond Mao wrote:
> > > > > > > >
> > > > > > > > > Port mbedtls with dummy libc header files.
> > > > > > > > > Add mbedtls default config header file.
> > > > > > > > > Optimize mbedtls default config by disabling unused featu=
res
> > to
> > > > > > > > > reduce the target size.
> > > > > > > > > Add mbedtls kbuild makefile.
> > > > > > > > > Add Kconfig and mbedtls config submenu.
> > > > > > > > [snip]
> > > > > > > > > diff --git a/include/stdio.h b/include/stdio.h
> > > > > > > > > index 3241e2d493f..874279c60dd 100644
> > > > > > > > > --- a/include/stdio.h
> > > > > > > > > +++ b/include/stdio.h
> > > > > > > > > @@ -3,6 +3,7 @@
> > > > > > > > >
> > > > > > > > >  #include <stdarg.h>
> > > > > > > > >  #include <linux/compiler.h>
> > > > > > > > > +#include <vsprintf.h>
> > > > > > > > >
> > > > > > > > >  /* stdin */
> > > > > > > > >  int getchar(void);
> > > > > > > >
> > > > > > > > Is this really needed? I know our include structure is a bit
> > odd.
> > > > > > Should
> > > > > > > > we perhaps look at moving a prototype or two around to be m=
ore
> > > > broadly
> > > > > > > > compatible?
> > > > > > > >
> > > > > > > Then we need to move  prototypes of snprintf, _vprintf,
> > putc_outstr
> > > > and
> > > > > > > printf_info from tiny-printf to stdio.h. Is this good for you?
> > > > > >
> > > > > > I don't quite follow you but yes, please work it up for review =
at
> > least
> > > > > > as I'm not too thrilled with adding <vsprintf.h> to <stdio.h>
> > after the
> > > > > > work I did removing <common.h> showed some fun around those
> > headers as
> > > > > > well, and I'd like to sort it out correctly.  Thanks.
> > > > > >
> > > > > > When MbedTLS native codes include <stdio.h>, they expect to hav=
e a
> > > > > prototype
> > > > > 'snprintf', that is the reason why I hijacked <stdio.h> as we are=
 not
> > > > going
> > > > > to
> > > > > change MbedTLS native codes.
> > > > > I mean in v3, I can move 'snprintf' related stuff to <stdio.h> so
> > that we
> > > > > don't
> > > > > need to include <vsprintf.h>.
> > > >
> > > > Yes, I would suggest doing a branch where you just make that change=
 to
> > > > stdio.h and see what the build fall out is on -next. I would not be
> > > > surprised if it requires a bit of work. It's work that needs to be =
done
> > > > and is worth doing, but might be... large.
> > > >
> > > > Yes, I can do this before posting v3.
> > > If it affects too much, it would prefer to just keep the <vsprintf.h>
> > > though...
> >
> > No, if it effects too much I'll just have to do a series to move things
> > around. Which I will do, soon, if needed.
> >
> > I made a patch to move snprintf to stdio.h, please see the last commit =
=66rom
> https://github.com/u-boot/u-boot/pull/533
>=20
> If you are fine with it, I will include it into the prerequisite series v=
2.

Yes, please clean that up and send it as part of the clean-up series,
thanks.

--=20
Tom

--rdib+oFRns8d3znl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY+zXMACgkQFHw5/5Y0
tywSKAv+N9X7mz6n8ZkqdGbAQNyr24PZ3h29wNV2laM016kwbr3g3GddTG3ghnC/
w4k5+6RumUaEno2O3wpwH05SnImSchwWQ6vn414SuD4ghFaLNra+PXDqUn8jvZ5X
rtp+sq9+VheXMtyYrw6yXNNOe2JpLiMvxyHv5Ka9J0RT3V6mXTt1+vQTbVA49dBC
+wggXcse4CpsED7OfYJA2RWTBigV2NoXlBq60q4k9DYuThSQGdR10WrqDc6hbgAO
PxpyMXpZvsqhNXbfFHT6HBmogG8+4R/w2005ai3kwT7TRJGGXOc0nFXo2tWMG/kh
9dH2pqVkhe/sEs1ygfFuXiuOFm/8l9Iy5hA0qECZbfSNuHYDrjl/kIgpFy/EBzLx
yG5qRJcBHLWONN9ruySMCJIzXOx/ghQ1EyVDhjpo1U5qvW8V+jo1No92OSt3LqiR
aQ0coR/FcKOR6IEkMBGVdQs760GsgNOPqgF6yGQeu8Kqhqsy19k8Xuab7mbrO+oY
hufoRPvl
=MzIp
-----END PGP SIGNATURE-----

--rdib+oFRns8d3znl--
