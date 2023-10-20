Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144ADC0032E
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 16:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BE92874F1;
	Fri, 20 Oct 2023 18:54:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WOtF3Ku5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 649B087441; Fri, 20 Oct 2023 18:54:35 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46508874F9
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 18:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a7d9d357faso11395677b3.0
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 09:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697820871; x=1698425671; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0BDk4lRCcqBEwk7E+TZp0ovWbVx1ktF9URD2pmRs5nM=;
 b=WOtF3Ku5TPmqQ913SHnBAhUzuIjyj+9D4vETMeguo6LCHwT+yfepyHGgD1tXvNbQ6s
 YFfppd5Eng/E3DPWEnCaOLKJ+Dp30jlDwvzvJxnrJiv7fzFgFvFBF6E0jRSBR+NI1OMF
 aq9M54/fDtCcWaj7QpvZ568M8Fr01uRfWy7Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697820871; x=1698425671;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0BDk4lRCcqBEwk7E+TZp0ovWbVx1ktF9URD2pmRs5nM=;
 b=XI+m60LGzKxrUr15bHrw7IfeFJCjspAnD5xMzDbSYyMwjo3wcWOot3z62NvxlGI9na
 fvi6DOHJb5EHEFo6IhIG7M8yEVJpbxabPo75F347Gj9oMPvuUI1uJAyCfU/77ScdSfN6
 lzK0cKXQykK4WE1CWdZRioKIpxD94X7i13rRCdxUiUMMMJs/FyEZndx17ukJr9B3gw8E
 cGzBvWUipCXBMgxhHMXDELvazxlUb0kFySxzZayEB3Tcv86nqiGB1BYFZeQ+k+lDApI+
 M/l/iO9Y1/jzVnAeyQXmR7i5+WtglElKiUmv9sl9g5K61Kc0flQOiVxZtBQQlo3ZjmkO
 f7SQ==
X-Gm-Message-State: AOJu0YznZhwOwdWqv2p3enKtJP0HWkIwdBopxtUIYPLjBvNitYZzCwTk
 k8l9MByO4FSEtKeWcJyA8DCnyA==
X-Google-Smtp-Source: AGHT+IEStq20f/qlR6tpoC5j4ukutcXzq9AnemH+Z4F0++BR1HCLmdluNM5sB1Fejh3o4RElYs2nSA==
X-Received: by 2002:a0d:ea8d:0:b0:5a7:a989:b85c with SMTP id
 t135-20020a0dea8d000000b005a7a989b85cmr2605553ywe.16.1697820871685; 
 Fri, 20 Oct 2023 09:54:31 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 p2-20020a0dff02000000b005a7a4e3816esm809200ywf.89.2023.10.20.09.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 09:54:31 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:54:29 -0400
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <sr@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Chris Packham <judge.packham@gmail.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: Please pull u-boot-marvell/master
Message-ID: <20231020165429.GL3119521@bill-the-cat>
References: <f84925f4-9c3f-4901-902c-49bb10a10765@denx.de>
 <20231020144545.GJ3119521@bill-the-cat>
 <1571d7c5-30f4-4ec1-9ad9-f1312ea965d4@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="L9Xyq1dvrlHsFuQL"
Content-Disposition: inline
In-Reply-To: <1571d7c5-30f4-4ec1-9ad9-f1312ea965d4@denx.de>
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


--L9Xyq1dvrlHsFuQL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 06:44:58PM +0200, Stefan Roese wrote:
> Hi Tom,
>=20
> On 10/20/23 16:45, Tom Rini wrote:
> > On Fri, Oct 20, 2023 at 02:51:08PM +0200, Stefan Roese wrote:
> >=20
> > > Hi Tom,
> > >=20
> > > please pull this next small batch of Marvell related patches:
> > >=20
> > > ----------------------------------------------------------------
> > > - kirkwood: Pogo v4: Enable LTO (Tony)
> > > - mvebu: AC5/AC5X: use fixed page table size (Chris)
> > > ----------------------------------------------------------------
> >=20
> > Given Marc's request, can you please either respin this with a revert of
> > 6cdf6b7a340d or I'll do that later, and drop the AC5 commit from here
> > instead.  Thanks.
>=20
> I'm just now leaving for a longer weekend trip and will be back mid
> of next week. Then I can take care of this, sure.

OK, I'll just drop the mvebu patch today and we'll put in a revert soon.

--=20
Tom

--L9Xyq1dvrlHsFuQL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUysMIACgkQFHw5/5Y0
tyzfzAv7BE6F3EXy8dCq/uXV2+Fmfj4teb13mm4lbMj1fTKOjRcQf2e6vd+teaPc
9RfcK4SYNfNUQ2ibDAmHJQG7chINMIOuntnachQPIJwiJyD7TfkGhAH93U1OUJ59
66wo534vYiRO6g3S/4TVqlOtouA9jdLTAecgjEGcdtd8wHAbZZCKKeJ3w57/b6k4
VwrVkA3MO9mmkcrNyqYCFceo/ShS75s1OQwIjeZib987y1px8K82LNcNF2D1KTvP
DeH/uLViGfjBxmybzi57AyFUh3mIa99mp8eBNGUAWfVGfrHiab3PcbxanGc6xSjq
dhcSI+t6MaCif9hyK7DDukhdG1aUrXzHRFiyTDYNWbm6VR9BL70pdD+58UL94Tja
xqZUhxFVvikVp0cMVPkzXxyEMDSYiOE7MuMv/4LthJs31ORQ2/9kiJE5PYS9P6Vn
o7bUT+mYzODU0wsllJc01UP4JJTfH79KGYEGBw8IF7MAcngfIKW2J/c7nDurDmsG
5rwg7dCq
=kRLu
-----END PGP SIGNATURE-----

--L9Xyq1dvrlHsFuQL--
