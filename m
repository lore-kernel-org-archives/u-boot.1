Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CE7C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 12:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A458487867;
	Fri, 22 Dec 2023 13:32:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TLCXvjJ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E79638781E; Fri, 22 Dec 2023 13:32:50 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29A6D87867
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:32:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-67f9fac086bso809836d6.3
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 04:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703248366; x=1703853166; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gVUUtAwnY8/qK4ZEUaU1ql4Issw0AJeCgX4pNp8ltdE=;
 b=TLCXvjJ3qUfeD2Crvz/cjpNGukT0X5HuyTYxRse2VxEzTtaA1JGGuMloWJDcT1DfnR
 XIJowAFM/OMVZUd7Ndy1rP5lymNBC1Mdavzet5PZLs/ParuzuJovWEMPa8wbQRHiDko4
 BjGTIsZAYwTVgHAjq9+3el8O1EqyxlBtvoeaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703248366; x=1703853166;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gVUUtAwnY8/qK4ZEUaU1ql4Issw0AJeCgX4pNp8ltdE=;
 b=tnJNnO1nnwcdLEucXI9eKwarPUyxQBW/bQjGzrTepbakBUw5FJZt24s0Sr2rn6TufO
 eYa1+MR+ZzYQbTuU6fgHOJKQf5pHscxRsakIKrLaTIFlU6n3LHLSEtpPnjpC/dpAC2qT
 6OU4EHr1Wply2w3Bv8q+2l4dh57JGKVq9258EtYhueb+ApMIGQaq9pRk9/8gu9zLs19S
 cKBAfXMEIuLdjAajs1PLriuzI8y882tci9mNUClidreVegr2QOw7ppLYEkotxz92deh3
 DCCzZrbSecql4SgTMBIykgIWr7sgm7NLDmkIuLkUvr262yaNGzm+PEtKcNJp5dBc0KRV
 W2pQ==
X-Gm-Message-State: AOJu0YwlvSEn5hl0xZ/6QQpCWlioEeoak7hWbKaJE5nI99b3cafZjff/
 agaMXqPIBDxqtgL9aNuyjAInXRy7nEAH4A==
X-Google-Smtp-Source: AGHT+IGDRZ1pL4ermC+dSJ9/s43zxgK+qoBZKrZlN03vStgmwS+GlvfxnjwkF6bXJVvE5x4Mne7Y7A==
X-Received: by 2002:a05:6214:487:b0:67f:8d92:a39a with SMTP id
 pt7-20020a056214048700b0067f8d92a39amr2051770qvb.126.1703248365641; 
 Fri, 22 Dec 2023 04:32:45 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a6f1-1968-9d2f-89bf.res6.spectrum.com.
 [2603:6081:7b00:6400:a6f1:1968:9d2f:89bf])
 by smtp.gmail.com with ESMTPSA id
 m18-20020ad44492000000b0067aa94409e9sm1345148qvt.18.2023.12.22.04.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 04:32:45 -0800 (PST)
Date: Fri, 22 Dec 2023 07:32:42 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, sjg@chromium.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor@kernel.org, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
 marex@denx.de
Subject: Re: [PATCH v2 3/8] scripts/Makefile.lib: Statically define
 *-u-boot.dtsi files location
Message-ID: <20231222123242.GZ2513409@bill-the-cat>
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <20231222061208.3009970-4-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CFDs/D2CTQnANg7m"
Content-Disposition: inline
In-Reply-To: <20231222061208.3009970-4-sumit.garg@linaro.org>
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


--CFDs/D2CTQnANg7m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 11:42:03AM +0530, Sumit Garg wrote:

> Allow u-boot to build DTB from a different directory tree such that
> *-u-boot.dtsi files can be included from a common location. Currently
> that location is arch/$(ARCH)/dts/, so statically define that common
> location.
>=20
> This is needed for platform owners to start building DTB files from
> devicetree-rebasing directory but still being able to include
> *-u-boot.dtsi files.
>=20
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--CFDs/D2CTQnANg7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWFgeoACgkQFHw5/5Y0
tywEMgv4uC9987GJbtB7efic6d+GvG433htoTTrq+uHML5BCIcCr60ZMqyUFrtn/
oPW+gLMr21nqoxQiua+CNtKpZrpj+zBOqaAkj6pSY6I64geX3BO1GVOuwv+zpeye
j/7ObDFDHlbNwQ5IcoptYe03W2oDsKn2U4mMsJCBobXHJoAO6/wmT+3BXHnfq6vf
SmS/7zeD1XSX4+RV9FaQPBFgiCqugKlSAZiKI8ehpE4TNL51ayMoYy8EdH7UODm+
XT4NxhwQTxfa7Np+LkiPMbk5/VLFo2WP8Lfxsy9E2H2atZdMvD3H6NVdZhsiFQTu
suOcdm8UmE1GxQmPqFv0rauJZjKbu5MnTbYXTg28axvCNL4GnEqaYjJ1wHmbgxjY
PF/Qgd2i4bymdafI7nohq6nOa0p3mYgEB9mXR7Geg0MCzPjq+fuS4KKzecH78p+N
GcBq6124bgMjqzQ/btfy/LB4+KhDfnlFgOMEmTlMMrsKLfmJuceXYNSQDlF3ZbAI
4hSM6dQ=
=tt/W
-----END PGP SIGNATURE-----

--CFDs/D2CTQnANg7m--
