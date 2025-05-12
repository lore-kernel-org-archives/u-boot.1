Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FC4C3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 22:31:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A162280C83;
	Tue, 13 May 2025 00:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZvoHridZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A6D38294C; Tue, 13 May 2025 00:31:06 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA8DE80AE0
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 00:31:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3f7f7b70aebso3830630b6e.2
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 15:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747089062; x=1747693862; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=50XDZnGQHPdAQjQZc/sPntxfRMK+sukl55o/x70kojQ=;
 b=ZvoHridZtwVWi90XgjHTJSRyhuh4ycVIqogaOan5c7b1RJfO3l0mw4zgwiEWCNzHoV
 FWa5TJXZpvM5K03olRIVyqqZf/om2vW+0e4mLryLXq7VWpqLFLSbUvMoYw03j4yYSg/L
 suBAxhCh5QHzvWl3M4OKzKt1iip5XM8buk77Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747089062; x=1747693862;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=50XDZnGQHPdAQjQZc/sPntxfRMK+sukl55o/x70kojQ=;
 b=PNFIQ7B3PJTFCpgEBY2Ygf4SK6hoUh5fha9Jb8I23Bi+EKhWoJ/whZRUHQDQLk2L+W
 vLyDQ6Z4WxzzmtOHPt/ki9BdIWl09sslDniVKQ8PBq0xaRj/ENbggeNdoYiZZs7hQSWX
 Jx79vFmlLF02FuG91p/AbVB3IQR4pCmcWRpevyyIofpyOEKBq71U0mapH0ot1ZUaTYzL
 Bw8Kkq1oivHRhkIacfRe1/YCbGHZ/aJeSk5YyFrvnyUG3UvU9V0xl0RiTi45XIMeuAnS
 zon7E10eWULQlxScuExiSQlkC6UQ8q2d8GbsqCT0wTwLv4Z917Y+Gvi50UKwDHisI6P4
 RaOg==
X-Gm-Message-State: AOJu0YzFci0O8N+rnzEym7peoiQLa0kimHoYRzbqLvCaklOAgDNE3x7t
 MsOTtKY24eirxIk4DLzbJZVoZV0vR+z8e61N9bJvaom/bI6hJv01BsyNe+tny3g=
X-Gm-Gg: ASbGncsAAaA3L+gOihps0IqTtBqSttTOS59/Iimb3Q6gt/w48UAaLxNdRffBn3LE5TV
 wGSGY583Z/A26wY9iZ/qitCMdjME8TtWevUSU7oAS78H8oUSygiyzlEPMebXh57FinLkUure/zt
 aH8BNbgQsAgoDBALJJ4CiXvwkqcGqUDjj2K243Ig9StOGdtoQukDsPGUi+6yIPpAsyWMhGfliyx
 Ids7F/7ukGa0/4D9awaOAlaSdjINIWcxkDQyAE8aSoJzYG1I54kEJef6ezDJRV5zfE9U8Mp2dXP
 7sCFVie178Z7lZb55JHDfkDTCzHIgXPjyUoqHLs444gYdrZoagkSRq4pGS2CT55AvfBhIuCmcl3
 kQv83f7B64NRfHdIcRo/xRKA=
X-Google-Smtp-Source: AGHT+IG7YZRPLEVBpxrlwh86cy/nMTqRAtA1EeDD7/tKMolYrwmLj5ZKyrqxLw+f/zi0NpDg8jbyBg==
X-Received: by 2002:a05:6808:3195:b0:401:e949:6374 with SMTP id
 5614622812f47-4037fdef301mr9176768b6e.16.1747089062561; 
 Mon, 12 May 2025 15:31:02 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-403802d3a1asm1719121b6e.20.2025.05.12.15.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 15:31:01 -0700 (PDT)
Date: Mon, 12 May 2025 16:30:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jonas Karlman <jonas@kwiboo.se>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Eddie James <eajames@linux.ibm.com>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 0/3] booti: Remove the SYS_BOOTM_LEN limit for booti
Message-ID: <20250512223058.GT603748@bill-the-cat>
References: <20250501131858.2160756-1-sjg@chromium.org>
 <20250505181421.GI5430@bill-the-cat>
 <CAFLszTgp0Y-yJVwE_ZBKKOXrqra6nRZqE-phPgQhA9Et99qcDg@mail.gmail.com>
 <20250506163229.GY5430@bill-the-cat>
 <CAFLszTg0YCntmLZ6EHXkWsJDhf0cCQyCHhCNzK31j+GHfBUz3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wnHMZQ4P0rn+1Xgv"
Content-Disposition: inline
In-Reply-To: <CAFLszTg0YCntmLZ6EHXkWsJDhf0cCQyCHhCNzK31j+GHfBUz3A@mail.gmail.com>
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


--wnHMZQ4P0rn+1Xgv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 01:25:57PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 6 May 2025 at 18:32, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, May 06, 2025 at 03:24:21PM +0200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 5 May 2025 at 20:14, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, May 01, 2025 at 07:18:32AM -0600, Simon Glass wrote:
> > > >
> > > > > This series restores the original behaviour of extlinux booting l=
inux
> > > > > 'Image' files, which is to ignore CONFIG_SYS_BOOTM_LEN and instea=
d uses
> > > > > a limit of 10x the compressed size.
> > > > >
> > > > > It also adds RISC-V support, since it uses a similar format to AR=
M64.
> > > > >
> > > > > Future work should integrate the code in 'booti' into main 'bootm'
> > > > > logic.
> > > >
> > > > I don't like "in the future we'll remove duplicated code".
> > >
> > > Small series, fixes a problem, can be made larger but then it isn't a=
 bug-fix.
> >
> > Which is why yes, this should have been instead of the however-many-part
> > "PXE" series, and then fixups on top, a series to address this problem.
> > Then other series to address other problems.
>=20
> The whole effort is addressing problems, although it depends on your
> definition of 'problem'.
>=20
> I'm quite happy with the approach I have taken here, incremental
> improvement towards a long-term goal. It doesn't need to be constantly
> rebased into out-of-tree code. People can only test what is in-tree.
>=20
> >
> > > > I also don't
> > > > like not seeing that what we really need to do, in all cases (not j=
ust
> > > > booti) handle decompression like we do for FIT images, and ask LMB =
to
> > > > give us a space to use.
> > >
> > > See bootm_load_os() which does already do this.
> >
> > Yes, that's what I was asking you to look at. I assume you're even
> > specifically pointing to commit 69544c4fd8b1 ("bootm: Support
> > kernel_noload with compression") which you and I did together.
>=20
> I seldom look at the commits that produced the code, but yes.
>=20
> >
> > > > A problem is that CONFIG_SYS_BOOTM_LEN was never
> > > > intended to be the limit on *decompression* as it's the limit on wh=
at
> > > > we're loading to memory from disk. That's what getting me unhappy w=
ith
> > > > this part of the series.
> > >
> > > From what I can tell, that was introduced 11 years ago by this commit:
> > >
> > > 081cc197472 (HEAD) bootm: Export bootm_decomp_image()
> > >
> > > I suppose the idea is that BOOTM is supposed to be a limit on the
> > > image being loaded, so it is compressed, then the limit needs to apply
> > > to the size of the uncompressed image, to maintain parity. Otherwise
> > > there would be no limit at all, since it is pretty easy to devise an
> > > 100-byte image which expands to fill all available memory.
> > >
> > > Using 10x the uncompressed size doesn't fill me with the joys of spri=
ng, TBH.
> >
> > Yes, it's a matter of heuristics, and also why we have things like lmb
> > to check and make sure we don't overwrite ourselves. I do not recall if
> > the 10x used there, or the 4x we used for kernel_noload FIT
> > decompression, was based on checking what the compression factor the
> > available algorithms get on typical kernel images or not. That would be
> > another improvement area, sure.
>=20
> That commit you pointed to does not actually pass the lmb_alloced()'d
> size to image_decomp(), so it isn't perfect.
>=20
> I would much rather use the BOOTM limit everywhere, including as the
> maximum uncompressed size of images. That is what it is for, as I
> understand it. Users would be quite surprised if the limit were
> ignored in certain circumstances.

Yes. I believe you misunderstand the limit, and the reports that we (and
distributions, etc) get when users have a problem would re-enforce that
too.

--=20
Tom

--wnHMZQ4P0rn+1Xgv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgidp4ACgkQFHw5/5Y0
tywAFQwApXyxQxlc7Htxsh72M95fWQ8yNlqPxnMaDzCfUzm9dnwX3NVT5YOxqCeR
k/2M+BEKW0NVc7p64uquRtO/MYz6ahq51MrSUFdGfe/ITwpZb/9KLWg6FLDN/ySA
j9qp0/3EdtPscoQ8QN8I6YLwpieiBpfLdC3+8M5HPwddn/gT6xR6tbRv/pFCaEui
H9u+IcTBKu/qWLdHglI66HQN3ikkTM0d2QN0hYqeOHpT8aaKDgwcmG22/IIiAu3/
F9WlWQn8uH68PKsSt9r6T8aVAr92bUygdrYhFaRj5MZJ8qnHXODYql4qabCgPrdC
TkHZ5+Mce/9GeNc9JsTIlptIPAD+4RZQpaXezHS8dJhVCR4M4UGWGXvZFEbTgCik
oXp1HvLtpOnVXvJSZ2wgBPZkLwieYHvZq+Gd0oFKiGgU+N/1oe7OASo2rGWx+pwZ
ZHI0Fe/PAMPPvnEVoFeQJSp0MIgCR7w4wtpEf9Bo7eT8aJsCB7QoeNgwH2QZ889V
SODIMMXE
=ioRW
-----END PGP SIGNATURE-----

--wnHMZQ4P0rn+1Xgv--
