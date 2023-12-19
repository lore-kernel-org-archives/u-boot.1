Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A858CC46CCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 17:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D094087767;
	Tue, 19 Dec 2023 18:46:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ya0DEpt+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76F9A877CD; Tue, 19 Dec 2023 18:46:41 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B2938781A
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 18:46:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-db4364ecd6aso2495138276.2
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 09:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703007998; x=1703612798; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BTRL/IsORySqb37UefQYvxQGG/7ofY/cYLih1QFxyVo=;
 b=Ya0DEpt+CLfXmfDALJqjcrbrHNeMTxv+0gYmytkodu3csqCopDFYxtfmfhIrAW2+jH
 IQ7LdSroVuZ8HGMnQr7s0Ez7PKlSxlHx9ZlF+0H75dyzLX/VOJ21Al2DsRvoZNiVn1TW
 RoYPkzjpia+qCl25kQEcndo/7M+nbUkSOElY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703007998; x=1703612798;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BTRL/IsORySqb37UefQYvxQGG/7ofY/cYLih1QFxyVo=;
 b=FL9DA0ccT0J19MLLbPzCsucLvPtMx656QwC3gWvVwfGdLKceyUNxLgf+mLt2fcvLNN
 UZWUj5SsFfEEBDWQ9/ZI+taWk/dGE64CNeFEpgI6ItKEyipNOdjrWg3JXoqCAc/FAfd8
 PGoMVRy5aJKG5W0KPDNUTZHdFo1N89XLQ2eoSL3d283019cVayiLTWRAXlt5DfNSA8RN
 H9TxiFGpw/YXOxK3PKths7Vw8I7Y9JXDpmR9N3vetqKwqtLJlkkGXhN+TWbUUAYNoOcn
 U7e6TAoETNbMgPnCicoQwftht5ce/Kpdi9vEzK4Y4yGfdtoBNndpyWeBWZB15I+jY0mn
 DJkg==
X-Gm-Message-State: AOJu0YzYUlv1bz84bR25KE6Nk2YAcgxcgsKJLOiQSwbOcJzAw/g8XNpG
 hR6wMJxMAbMb/1Qq7Ia4GAN5O91a7z+J2OWsvDY=
X-Google-Smtp-Source: AGHT+IEQTJza/2i37vSZXhLDgEH7xbinc4xaIDVlH0ITk3WxsCY02dVLhUSwZ5bd4goWvzhYNkaaZg==
X-Received: by 2002:a25:4185:0:b0:dbd:97e8:39c2 with SMTP id
 o127-20020a254185000000b00dbd97e839c2mr120117yba.116.1703007997755; 
 Tue, 19 Dec 2023 09:46:37 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 e65-20020a256944000000b00dbccc57e9c8sm752567ybc.56.2023.12.19.09.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 09:46:37 -0800 (PST)
Date: Tue, 19 Dec 2023 12:46:35 -0500
From: Tom Rini <trini@konsulko.com>
To: Etienne Carriere <etienne.carriere@foss.st.com>
Cc: u-boot@lists.denx.de, Jens Wiklander <jens.wiklander@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH 2/2] tee: optee: don't enumerate services if there ain't
 any
Message-ID: <20231219174635.GE2513409@bill-the-cat>
References: <20231129123753.1906956-1-etienne.carriere@foss.st.com>
 <20231129123753.1906956-2-etienne.carriere@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J8ygGBUtjayMa1Q+"
Content-Disposition: inline
In-Reply-To: <20231129123753.1906956-2-etienne.carriere@foss.st.com>
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


--J8ygGBUtjayMa1Q+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 01:37:53PM +0100, Etienne Carriere wrote:

> Change optee driver service enumeration to not enumerate (and
> allocate a zero sized shared memory buffer) when OP-TEE
> reports that there is no service to enumerate.
>=20
> This change fixes an existing issue that occurs when the such zero
> sized shared memory buffer allocated from malloc() has a physical
> address of offset 0 of a physical 4kB page. In such case, OP-TEE
> secure world refuses to register the zero-sized shared memory
> area and makes U-Boot optee service enumeration to fail.
>=20
> Fixes: 94ccfb78a4d6 ("drivers: tee: optee: discover OP-TEE services")
> Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

Applied to u-boot/next, thanks!

--=20
Tom

--J8ygGBUtjayMa1Q+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWB1vsACgkQFHw5/5Y0
tyyBagv8CP924Rt5++xdhJpokNuuMwTnVDBeQ/60y1tuZDgOx57PfLA5qE/OxLMO
35F0gniZj+EM/B6Dr27lgTqeBJsIyGUpjvEjUmnSItKbMtZlFdP1p/k6Ju+t6Otg
bcAcaTMAjFAMnYPaxTmwx0ogST2SDR3ixYBqPYhsKXWylkJIKGjpwZ8FnsTTT7AU
t4coOTWDajmUIpnyKNJN7bQX6gFKAChvJbE0VSw3EFJY4TducIAbx4wfkExxvK7R
k+gftvxVC6y5Losg1YTBwxcz2rAX3M4X3BV8ZSGcLrGmDr/3JcspkEC0ZFh19e73
oLMHHCMM2FAyWQxRwTMPr5XpUcxjsSB5qkmcVwU11+9t3vSQJ+QdyKvEyWE5fzSo
G4piC1iMs9YjPiBRe3+SEkEOyq8v4mu8N/bCVmiFV3ivv82QcKPL0yZaWqs0CS+N
ecVStv/kC2RoeJgkZDydJbg1mwJ/LhIYnSDxta1EL859MYmIRnFwsojfrYQIl5lS
mqQSSJGd
=YbDH
-----END PGP SIGNATURE-----

--J8ygGBUtjayMa1Q+--
