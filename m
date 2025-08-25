Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF2DC8303F
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 22:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B108D828A2;
	Tue, 26 Aug 2025 00:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a9pwJLQr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47F43830A0; Tue, 26 Aug 2025 00:57:31 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26A7F803F5
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-30cce5da315so1390090fac.0
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756162648; x=1756767448; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DHKhbtwV+MheYvoa3e7kx5NIvDUKFGcI7pXj5FNvuPU=;
 b=a9pwJLQr/UpjJdn0DSFwAvPHpZigjJXDEgVhys0Wp7OT5DbFmGCHBQfM9yq2pwEgJG
 of6VH6ociZS92daTJk+3d4Ej+2gXHhvH2IXZgRnzyWsRuyMF5qvUfdOu/GffhQZijuaG
 I/mhVrAWE6LRTS602/DZUNJHCPrq00/WPKMs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756162648; x=1756767448;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DHKhbtwV+MheYvoa3e7kx5NIvDUKFGcI7pXj5FNvuPU=;
 b=eB5iRufvmmqk0Z7NMS7bfO1Mp2W/hO1pLZu9zN6LkAIiciL2x8D1jzlepRx57sPcd3
 yWIi23DM9ykglfSzFvFac63r5wiV2ZRvuMBhADpMA8ZHMaSFWuoetqD2gasK2Ho+9QFY
 Am/Pw49QTqRIRI08EIXmk26gqC2Oe69DMQdScfNxGA84kHWuiyiSY1xYcpcPMpAzt6QM
 TGoWQrKyGkM4qiyg5p9ffk4sUNwTeG1DDB37UAAwO7CGWh/PJagmxDwzWaM+zotsBkkL
 JfTtScUglHcmEI9XZwj07TOMlsgwOokWOOYHIUeVYX2ty/4Cj3omNyWy2hfjUwYgPtOJ
 FuQA==
X-Gm-Message-State: AOJu0YwctDhGQ8d7hRAGb6+nYeHEmCqDZJ3nqdgBh9Pq2TC3Vh9hPHv9
 GwNfNl/suXDaMP8Ln6mi2lMFcJotQRRKmfWHg16PblrNsmvsSkosOPrjEm2EdHuauu4=
X-Gm-Gg: ASbGnctAc8kGMJIdfWsZzrlTHmfWfI1wqN9Wydk6yz8wXceu4NqvF3yhVagrGkXfpkn
 3TImHxOpEZUI6Ab+0qZRepDbXyJiwf1CzzB/y8GvSL0+HcCbbTP7RpDrY/R30JYMzETZJ8Tk5Hs
 16L/RlMSLnMGnGphTk0q/zEEBPycz136mb8TNTL5RpFy6PQOfs3x/rcZdujJ+Tt+RFTMyoleJYz
 eT3cUy6hTVJeT5fCn2klYvQwVp8fIuadWjGLvTQ72UX9cl/esvYVcqSH9b4dbLqvGVvQWjuNrRg
 /pdHFg1bvyZAwbGc3JZVNotgrxAYJKQnRBX0b3xK02iYiBZvK15sg2d7FCStUXRUIsRo+jCK2zP
 Gy87UXaJIggHGXAWbTEU3dYfKe4JKMiA2gcsJoaEV6woKbvRM9h5NmoaK
X-Google-Smtp-Source: AGHT+IEiJ622OMpxS9TFSlniUAHoVXkc/RIHb5dU/kJGsXFCZiuYpTbEBZc48qVipeX896Gz1bMPNw==
X-Received: by 2002:a05:6870:610a:b0:30c:46a2:fdf4 with SMTP id
 586e51a60fabf-314dcb54a00mr6265650fac.17.1756162647854; 
 Mon, 25 Aug 2025 15:57:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-314f7ca65e1sm2044386fac.21.2025.08.25.15.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:57:27 -0700 (PDT)
Date: Mon, 25 Aug 2025 16:57:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH 3/7] doc: make pdfdocs: Add pip install pytest to the
 list of needed steps
Message-ID: <20250825225725.GZ124814@bill-the-cat>
References: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
 <20250825224459.682403-4-adrianocarvalho.pt@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a5aOXCoQHPnRQUOi"
Content-Disposition: inline
In-Reply-To: <20250825224459.682403-4-adrianocarvalho.pt@gmail.com>
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


--a5aOXCoQHPnRQUOi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 11:44:46PM +0100, Adriano Carvalho wrote:

> If I don't install pytest, this is what I get with docker.io/trini/u-boot=
-gitlab-ci-runner:jammy-20250714-25Jul2025:
>=20
> uboot@35c89b9ab70e:~/u-boot$ make pdfdocs
> [...]
> WARNING: autodoc: failed to import module 'test_bind'; the following exce=
ption was raised:
> No module named 'pytest' [autodoc.import_object]
> WARNING: autodoc: failed to import module 'test_bootmenu'; the following =
exception was raised:
> No module named 'pytest' [autodoc.import_object]
> WARNING: autodoc: failed to import module 'test_bootstage'; the following=
 exception was raised:
> No module named 'pytest' [autodoc.import_object]
> WARNING: autodoc: failed to import module 'test_button'; the following ex=
ception was raised:
> No module named 'pytest' [autodoc.import_object]
> WARNING: autodoc: failed to import module 'test_efi_loader'; the followin=
g exception was raised:
> No module named 'pytest' [autodoc.import_object]
> WARNING: autodoc: failed to import module 'test_net'; the following excep=
tion was raised:
> No module named 'pytest' [autodoc.import_object]
> WARNING: autodoc: failed to import module 'test_net_boot'; the following =
exception was raised:
> No module named 'pytest' [autodoc.import_object]
> [...]
> build finished with problems, 7 warnings (with warnings treated as errors=
).
> make[1]: *** [doc/Makefile:84: latexdocs] Error 1
> make: *** [Makefile:2686: pdfdocs] Error 2
>=20
> NOTE: This won't completely fix the pdfdocs target. See next commit(s).
>=20
> Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>

This should instead say to install test/py/requirements.txt and it is a
requirement for all doc targets.

--=20
Tom

--a5aOXCoQHPnRQUOi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKzqVAAKCRAr4qD1Cr/k
Cl0IAQCn4lVkN1nJGvzGfKBTjqdBOqe6NLFmQ88H+MRh1eUlYwEA5fG6zQayNoQM
jLHLLvNjv6Zp8V89yh33F2fjrLD/rQ0=
=RWTZ
-----END PGP SIGNATURE-----

--a5aOXCoQHPnRQUOi--
