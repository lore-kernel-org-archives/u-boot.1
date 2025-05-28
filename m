Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B38CC5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 17:43:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32B0182A39;
	Wed, 28 May 2025 19:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P4u1pKGW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 604A882AAF; Wed, 28 May 2025 19:43:22 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 299F08070C
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 19:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-72c40235c34so37278a34.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748454199; x=1749058999; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mGqQ6ICMRPE5utcIdLf78OMTW94vJFnNSO/VAYVGt0Q=;
 b=P4u1pKGWK2QW6TGa/MTUfwxjzImM8wkcIlEhtoYF79hpwpqNQIWKt4IbqhOd3wT2TG
 a5gQbUXLsXvIRe5j4Gk5AproFkhuDbuf45Srobi5wCHW8bPevmPQnHRUs+qxdSaw9wM1
 NLtzqGJP4OhjDhGvjuWhhzc5BapQdWGS6QvTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748454199; x=1749058999;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mGqQ6ICMRPE5utcIdLf78OMTW94vJFnNSO/VAYVGt0Q=;
 b=OU18L5i4tEUiUpjUNbq2XtJ6xhFWrSooQpGegHgAlgqI5JtXXGnjpGK1FG5H//FQDx
 vFmbdTxSSRVnm+iUuFguAdAY25zOYGZv+8WWVxMHtXe+x6UYaqS4bjccXuIfkikXrFWO
 +8mAHWFgtM+X+NRStO7woH2Y+npe+u6Uu1sW4UVD1YRcMlfoMx/rP/OkxsHm23jJDoa8
 bIILNl0nwX4u/4KCbm17g8cJu3F9YHjC2zgsgnVQ1YrDvY9wVRJq44TJrmDumW+NukrN
 JXqu4K/3eeZHylBWK0E4JT7MR7+cjc9/ibFotus4y1PrRHYZj2MS3csHLUBwuZ4o2+hU
 zqfQ==
X-Gm-Message-State: AOJu0Yyxu4kqUuHvg+WdWTdjRXOmobArH8CF5zoATNdrRWDHSK0aDIpw
 fOpz63+Y9RrpQRgrrF3uPnfPpHOIOInkcXD17PBuu+jvQC8J06kiyTePCTrEd9AIQ6M=
X-Gm-Gg: ASbGncsDMDHF/MgHdiSJ8+wmg2JzWIB1Q1ZvCLNGSYJvBAljTwkwraOjIi987Ycn1sg
 XsZY8HlXHoDG8FObJuW60OJuILaAe1PkIJu2FdotPMftzsvMslW3ek0+Mq1fiUn6pe73VuHj29N
 j9p79i8lE6obYicfzAkXP8hp0iUE+L90//TKLx4VjOJAHwtfrmNyB2z6k1djeUUwOtoqxZQOVSD
 yfJ97EnuSf0Ryb0Et9Y770dLLw6/qndttCiy+OL2lYk738FDSttio0fLxc1VCGos5pkSfninuMh
 wgL2YR6ERdzt2oxVVSuecczzEHqADoMMQa/0eCTaEcmF4jQ+vv/QdUhLFORFyGlQeuXvlN8WACl
 bbTQsDX/eRgkm
X-Google-Smtp-Source: AGHT+IEp0mWC5oCbdfAGfB4rGgJs0TIAPNI8XpEfQ5rRkoOvp+dRLqjc+eV5GEIkaS0+CZIBCqoqlA==
X-Received: by 2002:a05:6830:4885:b0:731:d1e5:7c5d with SMTP id
 46e09a7af769-7355cf2bdc0mr11010864a34.9.1748454198647; 
 Wed, 28 May 2025 10:43:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-735a53dc6e6sm180242a34.42.2025.05.28.10.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 10:43:17 -0700 (PDT)
Date: Wed, 28 May 2025 11:43:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [PATCH 00/27] x86: efi: Various app improvements to support
 bootstd
Message-ID: <20250528174315.GF100073@bill-the-cat>
References: <20250528082520.152391-1-sjg@chromium.org>
 <20250528140929.GR100073@bill-the-cat>
 <CAFLszTiVtyAsdqLNaGrs11TuugAhTp0Rru30=yNJoAa2RyU6YA@mail.gmail.com>
 <20250528150123.GY100073@bill-the-cat>
 <CAFLszTgVE+WLjsf4cWgaCDQD47adR2RTNNNJAqPMRS7pyzWcTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JGZAJIefEt/0qNW5"
Content-Disposition: inline
In-Reply-To: <CAFLszTgVE+WLjsf4cWgaCDQD47adR2RTNNNJAqPMRS7pyzWcTw@mail.gmail.com>
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


--JGZAJIefEt/0qNW5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 04:20:19PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 28 May 2025 at 16:01, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, May 28, 2025 at 03:25:32PM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 28 May 2025 at 15:09, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, May 28, 2025 at 02:24:26AM -0600, Simon Glass wrote:
> > > >
> > > > > This series makes a number of improvements to the EFI app. Mostly=
 it
> > > > > applies to x86 but the ARM version will share some improvements.
> > > > >
> > > > > The main updates are:
> > > > > - Improve linker scripts and options to detect missing symbols and
> > > > >   remove unused code
> > > > > - Enable bootstd and provide a default which can find an extlinux=
 OS on
> > > > >   EFI media
> > > > > - Make the 32/64-bit apps more similar in terms of features and l=
ink
> > > > >   script
> > > >
> > > > So I give a little, and say Yes to you despite technical misgivings=
, and
> > > > you post yet another big series that's based on your tree with alre=
ady
> > > > rejected changes in it. I do not feel that you are working in good
> > > > faith. Please stop, and work in good faith.
> > >
> > > What specifically would you like me to do for the EFI app?
> >
> > Well, the three patches you posted and Heinrich accepted were a start.
> > You need to build on that, in mainline. As again, the concept was fine,
> > the introduction of more technical debt to deal with later was not.
>=20
> Yes, I'm doing that. I said to Heinrich that I'd wait to see what
> happened with those three patches and then do some more. They are in
> CI so I'll post them soon.
>=20
> But I also mentioned to Heinrich that I don't think I am the right
> person to undertake all the refactoring work - moving EFI-loader code
> out to lib/efi etc. I'm not a maintainer for lib/efi_loader and my
> track record of getting patches in there is not good. We have the
> U-Boot versus EFI memory-allocation problem and my ideas for that have
> already been rejected. So at the moment I'm not planning to go that
> much further in your tree, unless there is somehow a future meeting of
> the minds. Perhaps Heinrich or Linaro will be able to work on it and
> then we can re-unify things down the track?

If you are unable to work with other custodians then yes, you will have
to wait for someone else to do the work. Since you have so many other
things in progress, it would probably benefit them if you focused on
that instead.

--=20
Tom

--JGZAJIefEt/0qNW5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg3Sy8ACgkQFHw5/5Y0
tyweFgwAj8w61WzTIDnnOIehaf+rYySWcqgBNmrTbBjHRyygBy4/rdU4PJ+c1qLX
2VukEw9i/jbA4m8X82Sx2BHqfAfxMvQamufUFByo56ByeTGqYgdeYlyQnxCzT/9Q
RnyfL93QnLU5y1avR6OgYXK5UH+VyUZnyzOeIV6V4/GtZEhV7aUh7Tmm04aPfT5B
F77gt8syUTdJ+CMazkh/tGyGb1/uIhP4YtxDnN3X4h+MJnwsMi4zhNfQo/5QvU+t
1vz6MMkBGDgiVrOfX8K4+i0DP0TZnv0Lpf++Nv0F01TqObgveRk6rBpOAnDGbpza
XetjvMQ8VW5UMF0S3muaAUiIpd+YkMjE8qsgXnJJo6X7PWI7rb/uLzC/wSFbLA1E
cRJABreQ9pQGoC/SG0sbKVeddGZrQbgihp8VY4GSNN5UnQOVlqwofgYHV73mfJpe
iFOGYZIzFu82Zmf+NYt/z3Utk+ZXPCDvFoQ2g8OQYh/mnjeITe1BDN65p+XQ+O4E
uSkNfROk
=hQYf
-----END PGP SIGNATURE-----

--JGZAJIefEt/0qNW5--
