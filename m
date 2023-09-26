Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19501E7E635
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 13:41:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56ECB86D8E;
	Tue, 26 Sep 2023 15:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XsZ7b4oO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1F9486D8F; Tue, 26 Sep 2023 15:41:55 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCCE186D7B
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 15:41:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-59f6492b415so66860647b3.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 06:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695735712; x=1696340512; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZWhLFcxBn3lvfNV/6iRfMh6CT+CJ68/3fFoPWCqLUZQ=;
 b=XsZ7b4oO8fLiKrwywlCeuLSJ/6R1jsptIptE+wPjrXhHc9PXYHCUjhGeX2ctzJ/5Ws
 VyKay55Ntwp1gNi38lJzBs+KmILdqg0bWimtGk91fCxd3b1zawqHwHM93pTYM5CB3uLI
 u27FPdJZ0oLKotovXCM1PN44ahnYEuAiIWr9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695735712; x=1696340512;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZWhLFcxBn3lvfNV/6iRfMh6CT+CJ68/3fFoPWCqLUZQ=;
 b=VJkk+Rbr6HuqhhabK9WNrY0S/BwxXfbQpy3cwsD559kY6iB1Hlrp3fRhv36O74RGbz
 TaCRw6hfHSyatliVvzi6WYPwMxLmiauVsYXsJdBLXboE3olmZQzB0Ky+t3atRtu8+/i5
 2eVQ8sAW7rC4qiGp1vipQo4JhGVRNt1BxCTUqXYISl3f4aR+ePbMwb8eCgex4Yjn1gRr
 bwSinnbW/LKMMgZPU4wNmzKQzTn1yuL4nwvBbRtrLQPs2JPHYS5IFrGvAYjaw4fJlE0a
 ooERlZQVTblC4PBoeb3bDJ5F8ujHudCPuMlBjux7vT4LtWD88ONtxd29AkvaPZlng0ig
 /21g==
X-Gm-Message-State: AOJu0YzrNfFD7lo6RlWsESagmFbxGuXPZOa5DZzzcSZjomr+2b9rSHKl
 hkj+bX0if9NrUW5/2vRu+eIQsQ==
X-Google-Smtp-Source: AGHT+IEI07bT+jb4Rm+h25Kdp8hUbUfLwpNLYun8zMAUShMN2Ns6nTeJ4OgLX8bcJN5ROCMlqHMyNg==
X-Received: by 2002:a81:6d07:0:b0:59f:6404:89b5 with SMTP id
 i7-20020a816d07000000b0059f640489b5mr1907134ywc.9.1695735712530; 
 Tue, 26 Sep 2023 06:41:52 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a080-e51b-f064-cf67.res6.spectrum.com.
 [2603:6081:7b00:6400:a080:e51b:f064:cf67])
 by smtp.gmail.com with ESMTPSA id
 x9-20020a814a09000000b00589c103d00asm3000357ywa.79.2023.09.26.06.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 06:41:52 -0700 (PDT)
Date: Tue, 26 Sep 2023 09:41:49 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@google.com>
Cc: Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 joe.hershberger@ni.com, rfried.dev@gmail.com, goldsimon@gmx.de
Subject: Re: [PATCHv10 01/15] submodule: add lwIP as git submodule
Message-ID: <20230926134149.GS305624@bill-the-cat>
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
 <20230926094124.7024-2-maxim.uvarov@linaro.org>
 <CAPnjgZ2OV8ug3+3ji8nEnK7cwONu7KFa2zSyP5urKWUkQvMqJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fG7aboCgMwSNAfSS"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2OV8ug3+3ji8nEnK7cwONu7KFa2zSyP5urKWUkQvMqJA@mail.gmail.com>
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


--fG7aboCgMwSNAfSS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 05:37:25AM -0600, Simon Glass wrote:
> Hi Maxim,
>=20
> On Tue, 26 Sept 2023 at 03:43, Maxim Uvarov <maxim.uvarov@linaro.org> wro=
te:
> >
> > add external lwIP library as a git submodule.
> > Use STABLE-2_2_0_RELEASE tag.
> >
> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > ---
> >  .gitmodules            | 3 +++
> >  net/lwip/lwip-external | 1 +
> >  2 files changed, 4 insertions(+)
> >  create mode 100644 .gitmodules
> >  create mode 160000 net/lwip/lwip-external

Do you have comments on the rest of the series?

--=20
Tom

--fG7aboCgMwSNAfSS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUS35oACgkQFHw5/5Y0
tyydQgv+MdCPDpqxwpVOgAXtNytux1U9MyIwkZnoWLztUretqatA7h9+L3y10Jup
NPRwGq0cUe8wXAhrsCWpEYeFICoAwlLiBFAaV4ASPtMGtHSAxO6GXgv+7EgzH+bA
u4Rp07a2+2opwJ7PoBP2PMAOvfUqpb1b88evB1MLgqPCqquEomwUvJuixUlVzpuj
s5liXmBRNhgHldDXLE558kOuxIhJOW6s3O56rVPJjrGMGNyAM8Du3KfK+cMuPjO+
bmuvz52F0EAsJYVO7zs+NaYRNrqAfjjgtoDE0/Y0uamD2vpTB0V6PMpfI/Y/+Qr3
U7YyqeZRCJzYmN/5Vsabf4KIeWV/OI/aBIE3CzAiMp3WOqSr0Gx4BeUAsKl15FIc
CYZ5GjBR0m+0E4vq2IMU/xs1n5t5MKbNOmmf/YV8K2BGR6pWJHwxWpa2m1vjJ+f0
Q6ieHHUx35dub9comQZJKe3jYnZ4dcFWKmGahJ0FZPvOAD/j9pdqpR+rhoytGCLW
jW+prW7D
=2FT8
-----END PGP SIGNATURE-----

--fG7aboCgMwSNAfSS--
