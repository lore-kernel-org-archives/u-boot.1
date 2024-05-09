Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A94C25B10
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 15:43:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1F96880A1;
	Thu,  9 May 2024 17:43:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="heCP8KRy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70D78880D2; Thu,  9 May 2024 17:43:15 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C1E88806A
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 17:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-792bae4137bso92489985a.3
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 08:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715269392; x=1715874192; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8AIFBANxHFByz2/Ha8s/zmID96foGgRrGk+XERU+EOo=;
 b=heCP8KRylYnPMzRVcYk8mVPlAdDPEGhkL7BBVY/DGV2znZEAFHPZCwvYHmMKoqY66m
 Dfw5US/8UdCSj9eM7IbuLKj4a0GIzc3uTPsQfd2t7hyPjSdUUlXswU1AQbhHdLQOAVpp
 Hi4tlB27DGbl9ybtRCCpdFJjFsKT0hEXN/iwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715269392; x=1715874192;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8AIFBANxHFByz2/Ha8s/zmID96foGgRrGk+XERU+EOo=;
 b=AkcR9nL2JiLo+RQcSyD0rhR6+wevEFCWZU2ysOsLJlnydl9/oJQBypKCyowH7Ji/JP
 fazVG0rpMwgNtLcwNqEU1fGYRZCfAz9Rlwt+ik2Gm49CM28Dl8IGJhl/osPaKCNRjKsg
 NjHnbb52bigPzSlu72Wxbwb4hT/UN49dqfQhe1X8EXXq21qiMajFED/4hKbALZjz8+ZB
 SJ43ow/1oZyiQFVslOeCU1qSQffvS/Q5pRYkq0qCzgw1mA7saKoqC8ALkrrEoR9CmESp
 aWSBOfkGFDF1k0FcIEmZPsmlNB6NPfOiPNGyk2bR+59gH43uIf+nsHzJDXNPX28/qdI5
 nqeA==
X-Gm-Message-State: AOJu0YxPtc1atVbZ+2/nQBREqBCQBp7CaD0fnfn/MFrEGyGGuHCD+gSy
 TBSibdwXEuwBdDktyWruWo391VQPr/Zty2frHey3EW+d/Vd79VWdNhYgtp0+ZzQ=
X-Google-Smtp-Source: AGHT+IENxgYwyLhC12EIfsv+YXX7yRT0ODiBgC5y2mbZdz/6cE+Z5nAHLEQxTx5rS35ip//9ZUNvFw==
X-Received: by 2002:a05:6214:21c6:b0:6a0:af07:107f with SMTP id
 6a1803df08f44-6a1514e29d7mr88983806d6.61.1715269391991; 
 Thu, 09 May 2024 08:43:11 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f194d16sm8054436d6.66.2024.05.09.08.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 08:43:11 -0700 (PDT)
Date: Thu, 9 May 2024 09:43:06 -0600
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
Message-ID: <20240509154306.GL2568172@bill-the-cat>
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-4-raymond.mao@linaro.org>
 <20240507211643.GY2568172@bill-the-cat>
 <CAEfUkULdF1R2c=QEOQHQH+8go7VnXnSBKXh2AVYXQt5LkMXy_w@mail.gmail.com>
 <20240509151133.GJ2568172@bill-the-cat>
 <CAEfUkU+Ax6o8NnL=e3Tm+-75HMbXpa5zqMm5TS3EpqY79GAEXw@mail.gmail.com>
 <20240509153100.GK2568172@bill-the-cat>
 <CAEfUkULtQdPYmSdj0qgRaWsNBQvxSFZP00+u0F57J4K+tLhfyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NJu+hbdJGah7gB2P"
Content-Disposition: inline
In-Reply-To: <CAEfUkULtQdPYmSdj0qgRaWsNBQvxSFZP00+u0F57J4K+tLhfyQ@mail.gmail.com>
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


--NJu+hbdJGah7gB2P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 11:36:37AM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Thu, 9 May 2024 at 11:31, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Thu, May 09, 2024 at 11:23:11AM -0400, Raymond Mao wrote:
> > > Hi Tom,
> > >
> > > On Thu, 9 May 2024 at 11:11, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > > On Thu, May 09, 2024 at 11:04:07AM -0400, Raymond Mao wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 7 May 2024 at 17:16, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > > On Tue, May 07, 2024 at 10:50:45AM -0700, Raymond Mao wrote:
> > > > > >
> > > > > > > Port mbedtls with dummy libc header files.
> > > > > > > Add mbedtls default config header file.
> > > > > > > Optimize mbedtls default config by disabling unused features =
to
> > > > > > > reduce the target size.
> > > > > > > Add mbedtls kbuild makefile.
> > > > > > > Add Kconfig and mbedtls config submenu.
> > > > > > [snip]
> > > > > > > diff --git a/include/stdio.h b/include/stdio.h
> > > > > > > index 3241e2d493f..874279c60dd 100644
> > > > > > > --- a/include/stdio.h
> > > > > > > +++ b/include/stdio.h
> > > > > > > @@ -3,6 +3,7 @@
> > > > > > >
> > > > > > >  #include <stdarg.h>
> > > > > > >  #include <linux/compiler.h>
> > > > > > > +#include <vsprintf.h>
> > > > > > >
> > > > > > >  /* stdin */
> > > > > > >  int getchar(void);
> > > > > >
> > > > > > Is this really needed? I know our include structure is a bit od=
d.
> > > > Should
> > > > > > we perhaps look at moving a prototype or two around to be more
> > broadly
> > > > > > compatible?
> > > > > >
> > > > > Then we need to move  prototypes of snprintf, _vprintf, putc_outs=
tr
> > and
> > > > > printf_info from tiny-printf to stdio.h. Is this good for you?
> > > >
> > > > I don't quite follow you but yes, please work it up for review at l=
east
> > > > as I'm not too thrilled with adding <vsprintf.h> to <stdio.h> after=
 the
> > > > work I did removing <common.h> showed some fun around those headers=
 as
> > > > well, and I'd like to sort it out correctly.  Thanks.
> > > >
> > > > When MbedTLS native codes include <stdio.h>, they expect to have a
> > > prototype
> > > 'snprintf', that is the reason why I hijacked <stdio.h> as we are not
> > going
> > > to
> > > change MbedTLS native codes.
> > > I mean in v3, I can move 'snprintf' related stuff to <stdio.h> so tha=
t we
> > > don't
> > > need to include <vsprintf.h>.
> >
> > Yes, I would suggest doing a branch where you just make that change to
> > stdio.h and see what the build fall out is on -next. I would not be
> > surprised if it requires a bit of work. It's work that needs to be done
> > and is worth doing, but might be... large.
> >
> > Yes, I can do this before posting v3.
> If it affects too much, it would prefer to just keep the <vsprintf.h>
> though...

No, if it effects too much I'll just have to do a series to move things
around. Which I will do, soon, if needed.

--=20
Tom

--NJu+hbdJGah7gB2P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY87wMACgkQFHw5/5Y0
tyxwGgwAupeh4OK6WYwjdeBHqB0xE0h0ik3c86DLMYMlOryvFqBrU+Q4Bbxu2a02
aRU2QMfMMDeTqNCBd3PxvY7NyeUaQVQI2emj8rQRvIie+rY8gtvWPtZRVoWTXPOr
wZdSwjIhBl3UBc/uWlhqD1j51xcNFWolAx7+e4CiIXmNQt7ZkP3a/osRvqYQWSSj
vx3zcQuFCgo9VNbAUhGRx72cj5n4Cr/NuegYW0NAPGLCUjc6BcPD8mf80McUUbPz
27Wbf0Xxs0jPuipE7LQSVZlmS8/c8Siiq50uMI3LzhpzV0JT3379hFOldQI+wmYH
HGpo3yg2QwVZGGnN/CQjD7csOXz4Nms09qh7C30nrE5KUsdMn+WvP7h9mxYbKLEE
PjOThndEgdokKy1HHsmHUqxnvpgSm+NagvIoyQIP4AQwk3qQ0Tubd7da9/0eCR7e
qrILaAJXRCfXQPTbRCMqBbFpelNIP9Hryi+EfD3DjY94QLO01QyApZ/21XWIPaHI
QYKACfXk
=eYgr
-----END PGP SIGNATURE-----

--NJu+hbdJGah7gB2P--
