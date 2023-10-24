Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7470AC25B48
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 23:21:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A65B8879FA;
	Wed, 25 Oct 2023 01:18:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ST245Wyy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7CD887994; Wed, 25 Oct 2023 01:16:48 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18835874BF
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a7fb84f6ceso48846567b3.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698189397; x=1698794197; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xtcO4ySBfShvXP3cW/hMfzDsdfHVOc2izBOP/EdNt+c=;
 b=ST245WyyGWhAqX5J5L79GT4HASJK9sFMDKomTRZF7p44TGauFYlQxpBNiio1pEzA5I
 uQtHuINi6RkHIWvMgJf+storryYHEb8GryL1lFuH3KwyNr1hybCBB02GNauDNGNkTYCR
 TxT3SLFdaGUl6jGdKddY7qw/ZSn3pA2K+LRj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698189397; x=1698794197;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xtcO4ySBfShvXP3cW/hMfzDsdfHVOc2izBOP/EdNt+c=;
 b=aGtLtlWCeb0UAlK6uOlT6wDDzCwN59aiXucnFD+w/sCrnsU3PkSWa3UPLA5RXf5UL6
 c+AuM6bHKTyCeHKoK9KjwXogA5CMxbV4CFg4FlYpBfGEqhIDVzPDW/msFIS8QvcbWkT+
 hju64ABhS7ndF/6IGp/gtePSFCLb7r8UXDUIy6tebJyW2dLGMIyKmOfgkHg+YGfOey0m
 1Nw6mPhEF6+XNpXX9fNrFiqC1yYc1QZiBz3k0vErR28Thj/zJJ80oWy6KDC4WM9Enozb
 3ZPcpL2N4/WZr4dgY4mE8BQJMxCZQJxs9QsQawx3Ibqr0HUhyRqzisPk1RCStnXHERAC
 fMuQ==
X-Gm-Message-State: AOJu0Yy7rSeLx4/ILypVTV4SL9N89fawnEy1vaDpyDqVcVuINR6X+/bv
 CrrDbzDCUyHEKgEnpJloqPeRfw==
X-Google-Smtp-Source: AGHT+IFPR7lLv4anq8c+tIQHVhwu/Ai/IP1q7WefZVbMuB+3I/oh+2fFD8AuZ+oK1rzj3k00JkE67g==
X-Received: by 2002:a0d:e84d:0:b0:5a7:d938:c5e2 with SMTP id
 r74-20020a0de84d000000b005a7d938c5e2mr13664295ywe.14.1698189397184; 
 Tue, 24 Oct 2023 16:16:37 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 m203-20020a0dcad4000000b005a7db2a0dddsm4484002ywd.3.2023.10.24.16.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 16:16:36 -0700 (PDT)
Date: Tue, 24 Oct 2023 19:16:34 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Gendin <agendin@matrox.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Nikhil M Jain <n-jain1@ti.com>,
 Rick Chen <rick@andestech.com>, Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH] mbr: Test tweaks
Message-ID: <20231024231634.GY496310@bill-the-cat>
References: <20231016225059.712261-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UyaFBNXzDQi+WBWa"
Content-Disposition: inline
In-Reply-To: <20231016225059.712261-1-sjg@chromium.org>
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


--UyaFBNXzDQi+WBWa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 04:50:46PM -0600, Simon Glass wrote:

> Rather than do another review on [1] I thought it better to add a patch
> showing changes. This is intended to be squashed in, if acceptable.
>=20
> With the patch as is, various bootstd tests fail. This is because the
> test adds a new mmc6 device. There is nothing really wrong with adding
> new devices, but it does require quite a few tests to be updated. It is
> simpler to have mmc6 disabled by default, then just enable it for the
> one test that uses it.
>=20
> This patch does that and undoes the changes to blk.c and bootdev.c
>=20
> [1] https://patchwork.ozlabs.org/project/uboot/patch/ZSNWVGTjPEt2jXn5@alg=
-gentoo/
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>


I've folded this in to the original patch while applying.

--=20
Tom

--UyaFBNXzDQi+WBWa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4UFIACgkQFHw5/5Y0
tyyxxwv/Rvreyazg32o+m/CZtdoX14XBQqx4v9FLZ3HAN9Re6qKb/hnuTHUDUZid
qUYFfk9+Lfkm4CJOQr3iUwqlQhWj1+3qddr6tvBlpAwMuZ9WFXrJzaqEa04fHoMc
7Xea4R+D+xNvaN2bqWfxP74wNvmKKhmCPXk8aTHIaOy5OrYWnB+o51xOSK+E67u5
rn/4lpItx88m3DTkMJUBWmQvJHLcAYCdB3CxDNMgzovCV++SWfsu9NpHdORM1Fzs
8R4y/ojp4U9GIx//BuCs/HfrCmtWL/iUlNXRv0h0xtSjysY0iElhZXgvErJyBe3n
wB6e2Tv2VQWL3jmPgD/EPoxZi/H8CaJp/10BXdN7j/j17DwKm3/jAmB/xg1i0kGI
UBKwbpRS+Gtw9obzy4C9TuMC0QEtJYxq8cSLlZtzfE1sVWG5OnUXs7MvVxtEvOcj
ok01CwtTQY9B+w4fWJArBrAbxmzzP2d0Tc64qB0SshYsHvz8XA5qwzicveie8UXl
HoE7JIDr
=mrLB
-----END PGP SIGNATURE-----

--UyaFBNXzDQi+WBWa--
