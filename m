Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A492C19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 17:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 531108120C;
	Thu, 27 Feb 2025 18:05:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LPJZLX7t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FE258120C; Thu, 27 Feb 2025 18:05:05 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBE18812C3
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 18:05:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22349dc31bcso22483095ad.3
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 09:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740675885; x=1741280685; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V2yZOxCwPvlpEjmk9/n95vKYijsLHLfmSiYpmjgHpsQ=;
 b=LPJZLX7tGvb/aWurydaSkpEMK53MdrQo8lRuchJW/akAXivXjE4GASGvZ1M1NGGZhG
 aIIKxupEaBhTcz1fRb9n3Neyi2o0LvQSjDwuXpeHM2WnwuHrfubnCfhFnWAz5pMW2Ohc
 BQnh6N682L+yJvmJnbgevgOpqVU0o+lOcG8gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740675885; x=1741280685;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V2yZOxCwPvlpEjmk9/n95vKYijsLHLfmSiYpmjgHpsQ=;
 b=ijJKcKDI2XqkACU1oddyOil4PTgfH7l8c0HMWEXiU4YqGGi5LGAJQL1Ku3hSjKRcty
 Apy5H8amQnOuez1fq41G5A3ToxPO+Oo0N5g7A7cBbn91YIQkYMTDlsGqsNXrMb/p8BG4
 TiOcM8+IO/aXc7BTUA5b9SdMnVRPtogECowaRtiZTxKt9ERGF4epcbaIThz/zqlRCj7s
 18ZlLjqlHQj/rIa7vw42AemmFuaLIlMF7tsZ6h54yy7n7L3FkMIMV6Xg6dsjj0nt7cZB
 04Ns/9WBTsoInjKr2Q5/cllKv1SArA15bpXlExooFjDXCz2K4k2t4mWddbHD4QNhi02B
 ihdQ==
X-Gm-Message-State: AOJu0YyZNHIAe44iFqFhTT8D9Nr/axvbGi7yGYyieLWcUF1k5m1DqK7z
 0NYCdXn1B5tXyECKpPvFio87P+GcybwvbxQ4oUAqPuVe80kEXgLg2PcgNp6sW6I=
X-Gm-Gg: ASbGncsy0TUBGm3bo2YqzL8WCiJekNioNiiXzZt4kesUvJL/VYXHKiWmdFSbu9wdrpZ
 ixt7970/bOhvIsOwO/2QJYKN/s4XC2caBJ9e0Un01Z/tVGXjTmk6z1isXxP62U/ziAx6x3kOVJJ
 b9ReZ0i6b3D5bAVWRzRl+GVIx16U3uQV/kPnBnnInWvOXAoiQlcROKfnlCstKt5/imFI1zXQENv
 jLh7pnKx6ffqNPrwbd9E7J/ytmFZnRH7aBl3sQm3HtJKTqtzqCPCBRHWSyDzHRF6too4OXXYh3n
 mO4OchrZVjBHqNwTufsTk6yB
X-Google-Smtp-Source: AGHT+IG9eslQbBtkbJhbasE0ofrgDiHK84aZmPMwsUt8ow4gT+YhyThIYvlHAn4wb0MVaTCGZcU6AA==
X-Received: by 2002:a17:902:d582:b0:223:4d7e:e52c with SMTP id
 d9443c01a7336-2234d7ee938mr62453285ad.5.1740675885294; 
 Thu, 27 Feb 2025 09:04:45 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9d7fsm17546765ad.70.2025.02.27.09.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 09:04:44 -0800 (PST)
Date: Thu, 27 Feb 2025 11:04:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: Re: [PATCH 0/7] binman: Check code-coverage requirements
Message-ID: <20250227170441.GF2640854@bill-the-cat>
References: <20250225200635.3781149-1-sjg@chromium.org>
 <20250225210645.GA2640854@bill-the-cat>
 <CAFLszTig7O=Eyx+C0xAsxkJi+rP_ghXgXBxUwN47GZLxg-KFwA@mail.gmail.com>
 <20250225213152.GB2640854@bill-the-cat>
 <CAFLszTicCUoW7qqy8qDwQ5a_9HuwwLExQsFdAuYRnXG5-J_NYQ@mail.gmail.com>
 <20250225215306.GD2640854@bill-the-cat>
 <CAFLszTgen=t-SCrwE7nPOjUTGHO7smNZ5CSvxWR=4KhE8DJ=DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sRKDZV4W2f7kdTk1"
Content-Disposition: inline
In-Reply-To: <CAFLszTgen=t-SCrwE7nPOjUTGHO7smNZ5CSvxWR=4KhE8DJ=DA@mail.gmail.com>
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


--sRKDZV4W2f7kdTk1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 09:25:25AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 25 Feb 2025 at 14:53, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Feb 25, 2025 at 02:44:12PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 25 Feb 2025 at 14:31, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Feb 25, 2025 at 02:26:39PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 25 Feb 2025 at 14:06, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Feb 25, 2025 at 01:06:25PM -0700, Simon Glass wrote:
> > > > > >
> > > > > > > This series adds a cover-coverage check to CI for Binman. The=
 iMX8 tests
> > > > > > > are still not completed, so a work-around is included for tho=
se.
> > > > > > >
> > > > > > > A few fixes are included for some other problems.
> > > > > > >
> > > > > > >
> > > > > > > Jiaxun Yang (1):
> > > > > > >   binman: Workaround lz4 cli padding in test cases
> > > > > > >
> > > > > > > Simon Glass (6):
> > > > > > >   binman: Exclude dist-packages and site-packages
> > > > > > >   binman: Drop GetRootSkipAtStart()
> > > > > > >   binman: fit: Drop unused code
> > > > > > >   binman: Drop algo check in CheckSetHashValue()
> > > > > > >   binman: Workaround missing test coverage
> > > > > > >   CI: Run code-coverage test for Binman
> > > > > >
> > > > > > While we likely need Jiaxun's fix in order to be able to update=
 to
> > > > > > Ubuntu 24.04, the series itself doesn't apply to -next, please =
rebase if
> > > > > > you intend for this to be in mainline, thanks.
> > > > >
> > > > > OK, would you able to pick this series up?
> > > > >
> > > > > https://patchwork.ozlabs.org/project/uboot/list/?series=3D444576
> > > >
> > > > It also doesn't apply. You should really put together a PR, against
> > > > next.
> > >
> > > Oh, it needs another patch anyway. I'll send a v2. Once that is in I
> > > can rework this one.
> >
> > Again, it would be helpful if you would send a PR and always base your
> > patches on the appropriate upstream branch.
>=20
> I understand that, and I'm happy to rebase / resend when you are ready
> to apply. I'd like to keep the diff as small as we can. But I don't
> think it should hold up reviews, otherwise we're just going to diverge
> further. When you reject patches for your tree I typically apply them
> to my tree in the hope that they might find favour in future.

I think you've got this backwards still.

> For the skip-at-start series I sent a series, which you have seen.

Yes, and what blocked them to start with is they defaulted to your tree
and not mainline.

> Speaking of patches, the PXE series seems to have got lost. It is
> 'changes requested' but I'm not sure what changes are needed.

The changes requested was that it breaks lwIP + tftp. You asked that I
ignore that since it wasn't failing in public CI, I said it was failing
in my CI. I then noticed that it should have failed in public CI (and
likely was on Azure, but that's often overloaded enough I cancel runs
when I see failures elsewhere). So I then fixed public CI so that the
lwIP platforms there too should fail.

> I also just found the membuf thing was never applied.

Was that the one where Rasmus asked you to do it differently?

--=20
Tom

--sRKDZV4W2f7kdTk1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfAmykACgkQFHw5/5Y0
tyytFQv/aKadMrk3yFZIi19WmeTPtynCBSk5Q2SQmE63RY2ucuBg9SRHz+jZttkl
GoGaxOkWj29KTxVvV139RnUJ/StPCdvXTQKk9b2aeyfqzQ4k3+e0xiLnQ90UrHlH
5T5N35SvIEShjgT8KqWZLX40BhHAOZkrFFMN0tBs14qL8ra8wCloqdLYHon6UQjM
1ycVxrPSzNe0qmY6zkdW97yLvEwsEGfgcDl+HifXyOQ1r8kK7MT1uOQ6iNb8fhUu
+UbSwDyK64xMuYUTvV5OhjR79aW4mdMj9LghnySIDmj9RkjLaEDHxSC48mbqfZq4
hWm2Nu78BgABOTlcMkDs+D1KjcgAtZJHz3RzbxACgreetLRMod5RvannnQR19+ug
7+FTuhjeymj5Ap71XIZgiDTG0XLuqN5hJN6aJS+19g/1sAXkMzI+Ym+BFu2sussf
WjHi00QsrUahyEsU/CzMDCjcvjRK0C2pOtJSVuqebtss4PZWWNom6MusDrKO1/kY
jpKTAP3k
=ebIB
-----END PGP SIGNATURE-----

--sRKDZV4W2f7kdTk1--
