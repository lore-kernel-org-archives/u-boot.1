Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6305BC19F2E
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 15:39:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3634807EE;
	Wed, 26 Feb 2025 16:39:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BBYJzZdW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDE5380FBC; Wed, 26 Feb 2025 16:39:36 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89606805C3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 16:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4720fb0229fso64828161cf.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 07:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740584373; x=1741189173; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bIq1t0nAz+oY8ZzLph6v9BnmbshtDly9CieXDQ9w5yI=;
 b=BBYJzZdWoFY2sdK2kxOapyvqW35jq6BYVsTX3MWoCMWKj6TbAepT3AnZYIdLb2tSYd
 q/Pt29pU950exNz2/bw41n4pcOOmfDe6yfOcvJG721+pbvqRurvQ/2F2Vwzq2M6diHNe
 UxjWFFBzutfkmYW35nrUWq1QVhDxgkABCEp+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740584373; x=1741189173;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bIq1t0nAz+oY8ZzLph6v9BnmbshtDly9CieXDQ9w5yI=;
 b=UWfy5zOgFqil01vMm1M+HtFWqIQykcKNS9TYK2hosqql3Fxs7bEZb/7CHE8mmVHE4r
 2L6i3Vr5EwC058h56mwYyT/Sa6uUMADMIJdIOvdKNg2Df24e/KR4xsJ6cLsfRmy4LtnO
 jKBsuuIQsHhCuLzeUgD4WnpZPnlb+oe8uQHAkVkHuRRmDjGFZMOWw/NROzIma4Ef0Qu+
 PVdxD5cTUsKlO3HGUnK1OBhNddFyTBg3+FrqXFH+wdynQPfZIXXG6h9KF7yRk04bLo/i
 JFiTKus6hTAXTBuGD25pm9ldlaMa9VfhRFk5sq98PRBF6xwoErBGTvw97NjArqA0Ix4Y
 zNBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVETwkT4J00cKNtQ9B9D8HlTDhMH5osRKv2Tr0/8bKWjpdrqlDzz0/U+fR3J2wRVusfdP3wIvI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9K6AJ7dC71JzcF1YnjPXd3vSgFELh+YfqzeD5YsyBpTBe5NrV
 QKaLOPXnc66H39KpajpK7lIutdCL9NjM5xP9+AnaAyb1+hzq/IZ/XG9dLk2EHwA=
X-Gm-Gg: ASbGncsyiE28/EJuBJIowhy4eAyeP3PNT7g63b4BfxgPbXsTp+KazRteoLInZ+rEewl
 KWOePuyRr3ziEmnhni5+nvEhQjcnCN42S0V4+qTUgJkEJQILHu2NkwZc6EeYeB7quURdY9HJW1j
 T/uz+TGEmyfGvuZYPN2bDuCZeO2cghK6/rdyO634hxQQmjjg1dyxA2BV6/pvcNPUJeoazk8mhCY
 hWD9IstRzG9xhUK/6RF/OwbMT4PGlOBr9mgYjs3LToiG/4q6JyInVDqwxdu9UQ3bb16a5XcX3hG
 qrJ1Q0hemMjXBNpC8ITpgKYB
X-Google-Smtp-Source: AGHT+IEvSoAtZ2RHnXggaceS5j1gMN4zhJ1jzk5RLAmCx3tulJjb8vrFGYGqe29FKQC2gAMjoVp0gg==
X-Received: by 2002:a05:622a:51:b0:472:8e8:fdf0 with SMTP id
 d75a77b69052e-4722485f05fmr279249941cf.30.1740584373425; 
 Wed, 26 Feb 2025 07:39:33 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47377e15b90sm25279601cf.30.2025.02.26.07.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 07:39:32 -0800 (PST)
Date: Wed, 26 Feb 2025 09:39:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: Re: [PATCH v2 1/3] mbedtls: fix incorrect kconfig dependencies on
 mbedtls
Message-ID: <20250226153929.GK2640854@bill-the-cat>
References: <20250203220825.707590-1-raymond.mao@linaro.org>
 <CAC_iWjLYqUucPThnuYPP_Pr19BQfQPMv4AY5XHDnJ8Pi_=hfhw@mail.gmail.com>
 <CAEfUkU+292wu7gdbj-BJoj9oWdt0SuUOeHtF3hv_uOyvjG20DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZaGsdeTPFpCq++IS"
Content-Disposition: inline
In-Reply-To: <CAEfUkU+292wu7gdbj-BJoj9oWdt0SuUOeHtF3hv_uOyvjG20DQ@mail.gmail.com>
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


--ZaGsdeTPFpCq++IS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 10:25:22AM -0500, Raymond Mao wrote:

> Hi Tom,
>=20
> Is it able to merge this series for the upcoming release?
> This series includes the hotfix for the building failures when
> WGET_HTTPS,NET_LWIP and MBEDTLS_LIB are selected.
> But it is rebased on one of Simon's patch:
> '[PATCH 01/19] mbedtls: Add SHA symbols for VPL'
> https://lore.kernel.org/u-boot/20250126184333.4058848-2-sjg@chromium.org/

No, sorry, I did not realize you intended this for the v2025.04 release,
I though it was for v2025.07. If this is something we need for the
release then please rebase on top of current master, thanks.

--=20
Tom

--ZaGsdeTPFpCq++IS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme/Na0ACgkQFHw5/5Y0
tyzZZwv/cdGtzpfyAJ4uLi9zE54ftj1yFiOVcnOoT5zhNrJPMS+LHayjPp0203a8
8pWWTXaN2Mv7GlHnE8gxHkSvTKvaNZHjNki8oldnnR3JA9R1S+ngx6OGQeoiCMA1
nmr5kgIesaTXl74f2OmhVwMrFibcp6b5gV/uNGy06UVFbjHS0aKdBwe9rfpyziao
vv6RAphfOSrGCJzHjNVcNfKEtrdoukjp/nd2BA/AMAZHwzdL2VxJBxjCIEKwjA2d
Or+GwSUlrBPwmTBEZFXwrxNI368mxLgxLRlRvAkYALNlN3v+HBXvQRq2nltTZUVo
jSq/q3EXTXAE1EHpqCGnHm/edLGSp5StXWlQ4pnFJ9PHp4bPhM2NxPfpBWOBiMqM
6KPDioBHYMIyB7LopaKx+5zk9hHz4294wF8K2I6SwaIXX5EXjedNLNyAi4C8VX5A
+XwSyGX29EJi866/exZ4NF/0l7lW4vpIT+RElsNHPkX3xJC+1kZD0huUc95W104s
F/AdimjZ
=8LPL
-----END PGP SIGNATURE-----

--ZaGsdeTPFpCq++IS--
