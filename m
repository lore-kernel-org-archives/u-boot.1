Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C61FD216A9
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 13:56:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9C86882BE;
	Tue, 15 Oct 2024 15:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GITBzIO8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 785B3883D4; Tue, 15 Oct 2024 15:56:17 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F6FE87DC7
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 15:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b115d0d7f8so384164385a.0
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729000574; x=1729605374; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0kxysnn7+QpAWB3xWEAU/XogkeVVJXf3blL+D2bfmXw=;
 b=GITBzIO89DwX7Cg8Z9xf6GHucdXTx8biMHKlP9nmjAtKEME4c856wHjSDHjp5aGZFS
 aif2qoMI/e8NQlMKr4nSVamn/pMPvneUw5mlSH7/k2frmQKp96qqdpYdSreWxWrAy0K/
 9MeEYQGFZf/86wSJLvCJQI59RDXy6z6WHBXPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729000574; x=1729605374;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0kxysnn7+QpAWB3xWEAU/XogkeVVJXf3blL+D2bfmXw=;
 b=WwqkyLe8Tdq5PqBx98w+ZJdflp1k3sO2TtDHiwEEn4rGd+dAp5OrR9wof/X348TiSa
 6ItRylNRwf1Uh44jGAnq+g43CCPSkj86f76dQPEbMmi+0LzCSc1NwNw6/9MKgRqRDXDF
 6LXpjMhjUQg11RxncKfwMTg/bHtzjm4OCOOhrTOdYd91HjNr3SA4Hi4BFAXILnjXvEaQ
 +XPZC489R2re1sdmFtUrhLgzXxZIhDE7hLx8yt9pI6RdIG7QYq2jKG9iT2irttaEFOEj
 BYhP3yB0cKk6oTpAz4KeELQoruRrmkrcWz8da4qO9BBlTcJfMC4fVpSQ2/nr3GCvdowG
 NDAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeBAFG0i1CI/3CZNNJSCIl4vMDCk3V5Vo284HFEytg+W3rJypR/Qjnl5GTr3ovx24yvIO6yqY=@lists.denx.de
X-Gm-Message-State: AOJu0YzfW9K2U70E8x/IO0YKNZe2d5IzbxT1uw3nL6baOBlp3hQQEIWo
 sAx+E9+g8oE+t0zeAnV4O/vqOAVpCz89mR3+fjbqUVQ5dBvYiG20xb2r7SuacJw=
X-Google-Smtp-Source: AGHT+IE5WFMb1jwGXpHVSFu/Qn/zPkl81cH/TrQMmOj+baSXdz6JNGPCAvOgCLVUHw6+rz4Z00xbWw==
X-Received: by 2002:a05:620a:1788:b0:7a9:a9be:2fc4 with SMTP id
 af79cd13be357-7b11a3c5a95mr2716690385a.29.1729000573972; 
 Tue, 15 Oct 2024 06:56:13 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b136164da6sm74533285a.16.2024.10.15.06.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:56:12 -0700 (PDT)
Date: Tue, 15 Oct 2024 07:56:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: Re: [PATCH 6/6] cmd: Add a command to show the memory map
Message-ID: <20241015135608.GK53053@bill-the-cat>
References: <20241009015020.25817-7-sjg@chromium.org>
 <CAC_iWjKh7_OKKMi9K6eMaiYUN-Nxf+ZQ0NuW9BYzK3u4F0Krcg@mail.gmail.com>
 <CAFLszTjBQaoF9g0nky5mAA429gzA8QvzjxHxooDaRo1=BB+stg@mail.gmail.com>
 <20241009223907.GN14210@bill-the-cat>
 <CAC_iWjK8Bb16aLAKtmYB0Aof4CJP-AAdsMTEYvnFeMeXaiWM9w@mail.gmail.com>
 <CAFLszThoXsWuPu=b+FT0wuURR1rxTE6RWZhUhET9mHbQ+j63ZA@mail.gmail.com>
 <CAC_iWjKKqsJh7yUv-kRe5WiGA02c4YU4Yj83UXVXjki+CO9X1Q@mail.gmail.com>
 <CAFLszTi_CqDY2+RMRo+hJLsCtn6vQHHoeBvT8g-czL7OQAXw0g@mail.gmail.com>
 <20241014210707.GW53053@bill-the-cat>
 <CAFLszTigkFprX5KH3po9h+XqJ9-6_qcyCgM466srHgXMdGwoSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0sKucGAu0oNzdISt"
Content-Disposition: inline
In-Reply-To: <CAFLszTigkFprX5KH3po9h+XqJ9-6_qcyCgM466srHgXMdGwoSg@mail.gmail.com>
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


--0sKucGAu0oNzdISt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 06:49:00AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 14 Oct 2024 at 15:07, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 14, 2024 at 01:13:25PM -0600, Simon Glass wrote:
> > > Hi Ilias,
> > >
> > > On Thu, 10 Oct 2024 at 09:27, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > >
> > > > On Thu, 10 Oct 2024 at 18:10, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Thu, 10 Oct 2024 at 06:02, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > On Thu, 10 Oct 2024 at 01:39, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Wed, Oct 09, 2024 at 03:14:25PM -0600, Simon Glass wrote:
> > > > > > > > Hi Ilias,
> > > > > > > >
> > > > > > > > On Wed, 9 Oct 2024 at 04:41, Ilias Apalodimas
> > > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > Hi Simon,
> > > > > > > > >
> > > > > > > > > We already have a mem info command, which is pretty usele=
ss. Can't we
> > > > > > > > > reuse that ?
> > > > > > > >
> > > > > > > > I am not too keen on using that as 'info' is pretty vague. =
We could
> > > > > > > > perhaps create a 'mem' command with 'info' as one subcomman=
d and 'map'
> > > > > > > > as another?
> > > > > > >
> > > > > > > Are we talking about "meminfo" which literally only prints gd=
->ram_size?
> > > > > > > If so, I don't think it's worth worrying about enhancing that.
> > > > > >
> > > > > > Yes, that's the one
> > > > >
> > > > > So, you mean to just delete that command and make it show the mem=
ory
> > > > > map instead? Or show the memory size at the top, before the memory
> > > > > map?
> > > >
> > > > I meant the latter, but if you and Tom agree that we should leave it
> > > > as is, I don't mind adding a new command. I assume that the list ab=
ove
> > > > is non exhaustive, so in the future we could expand it with lmb
> > > > reservations etc?
> > >
> > > I sent v2 with that done. The lmb reservations aren't that useful as
> > > there are no names attached.
> >
> > I disagree with names being needed to be useful in this dump.
>=20
> I'd like to show where the kernel, FDT and ramdisk are, with actual
> names for them.

That's fine, but I don't see what that has to do with showing the LMBs
that we know of as a starting point. Again, an LMB is not an image.

--=20
Tom

--0sKucGAu0oNzdISt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcOdHAACgkQFHw5/5Y0
tyxJbwv/Vs1BdfMMVB7AkB07LfVMnARVsXAMAWnMxMPu89QSrBHfOn12z3ccihC1
GJ0hynI/ndtduVUKYvj/UOSE0xWpBPT8KJ/8OAUIjStefzEXO6efCoXEra0frAOM
kp/QMlM3/j/waEBdeGW8ErdtDCaNlSUBYe/g5gwRtA1OqraBOAJHF1jZPV6Y25VQ
U+XYIM8X/8VN/2UBM8mH6jBbGBmud4/Q8Kd0YOA9p0tvTcvRrgxnThqMdUxhStSn
3/Ow/5bzad+eiQ4+47xbZ5ZzgBsAKeyWhMcY2cmPH3nLv1CqSA4wYvisiTXRHf7L
csSoaSQV1cA9D8Ooe2Vnqxeg543wtc/o2Gva+bWytBPI3/ccGoh71wyR94BqD6/w
7vPmVTw/st7QMiads0+5ta65xXjgBTRedi/QD72/3mVRVLjomR3nVTAbkDA1IYG3
IeKQnkPE90p5f4oNWnLy0+VB6AevLz+m5t588muP21QQCKfCKXwMyHPEk9HIp5K/
iDDBy9bp
=E0XI
-----END PGP SIGNATURE-----

--0sKucGAu0oNzdISt--
