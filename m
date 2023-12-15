Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48871C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 22:48:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3322B87BE7;
	Fri, 15 Dec 2023 23:48:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uKUiFHmX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41D6F87BE1; Fri, 15 Dec 2023 23:48:17 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 940DA87C3C
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 23:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-425f5964ce1so9039141cf.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 14:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702680493; x=1703285293; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XYIx9+3MTjvF2Z5Dn7IJpZEGsVWYs+IRc4HUEx1COWk=;
 b=uKUiFHmXMPYEXR81GVwxgZMo/fxORUXY9hfgDlCUzGct1gQ8nYcJS+H4R1+LH82pOi
 3+hlzVoRtXDfUPGTvpLwIRWP4u2aaCs+2yHnPllZd/1RWnpi2SL6zRravy4kQLKO0UXo
 +Z3xN0SQFMvrwt0ANhjnJvQ2kLOp5TMoHciwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702680493; x=1703285293;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XYIx9+3MTjvF2Z5Dn7IJpZEGsVWYs+IRc4HUEx1COWk=;
 b=hUNvxfTLCPuIgB6ZJaVmxSWVw8szGSo81JB3NoA89pyQeX+E1aOBCv+ri8jDoe9QSn
 A1fajOVSSVnAuOKNPweXTcW2AIBp31OVkobCfbon6skVPuM/7qyKmrJPJoa3TtRALal9
 bfT331JKDK5Sc7eMYab+EXO6UStNDkJxcIrhLIIvOetOo5vgmVlplKqjP8lgB0u90Y34
 6OiSeB/MDtEQzsZzMVQgBLDgxuEY439K/76+luoNvsnuaiYijzsn0QLZNHuc7+Zd9CCC
 Ihtl0jFLkf3J7GYvsyxNeVquMxzzKwHpiAP0RiXFnxtWsipwYdtYoWaav9bWgYVYksNG
 dO8A==
X-Gm-Message-State: AOJu0YxAj3Duh4EBc2JXglyRuUK7wpJAnifHmZFkP14Ptuf0H0YqTTpU
 Lpdxfkx4y20oU8Hp83qIiclUIA==
X-Google-Smtp-Source: AGHT+IE9ZUQfkLj+3PTgKLFaJ4kWckdWaIQjA3e1Uj2wyhqe43TvAOtDDKePHlrJ1Co1Klc0ONZEjQ==
X-Received: by 2002:a05:622a:118d:b0:425:4043:50e0 with SMTP id
 m13-20020a05622a118d00b00425404350e0mr15723658qtk.111.1702680493408; 
 Fri, 15 Dec 2023 14:48:13 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4efc-63ef-4955-a8ab.res6.spectrum.com.
 [2603:6081:7b00:6400:4efc:63ef:4955:a8ab])
 by smtp.gmail.com with ESMTPSA id
 r5-20020ac87945000000b00423ea1b31b3sm6994029qtt.66.2023.12.15.14.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 14:48:12 -0800 (PST)
Date: Fri, 15 Dec 2023 17:48:11 -0500
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 Simon Glass <sjg@chromium.org>, Apurva Nandan <a-nandan@ti.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/4] arm: mach-k3: Remove non-cached memory map areas
Message-ID: <20231215224811.GF2513409@bill-the-cat>
References: <20231128170528.407707-1-afd@ti.com>
 <20231128170528.407707-4-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1DxUNulrWRRtAg12"
Content-Disposition: inline
In-Reply-To: <20231128170528.407707-4-afd@ti.com>
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


--1DxUNulrWRRtAg12
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 11:05:27AM -0600, Andrew Davis wrote:

> All normal memory areas should be mapped as such.
>=20
> We added these un-cached holes in our memory map to hack around the
> remoteproc driver missing the proper cache maintenance operations.
>=20
> The problem is having these non-cached memory map areas causes stability
> issues later in system operation due to the nature of the K3 coherency
> architecture. Plus these are board specific carveouts and instead
> should have been added at the board level, not here in the SoC common
> code area.
>=20
> Remove these non-cached memory map areas.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Nishanth Menon <nm@ti.com>
> Tested-by: Nishanth Menon <nm@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--1DxUNulrWRRtAg12
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV816sACgkQFHw5/5Y0
tyyrvAv9H4C7KQTvAyz0ccl3Q8nNR8VWdy8dx2ewI1W5f22t40eWVoTmRp/6aTGS
ZDrLRZ7s34soCu9ydPkBt2DEEMGEOONdnXLlemthb6tPMLwfFAbMI2PyYfoEXy89
lJSyGPRQLylnTyMFyMmeAbTFOBfZhY4dZJ9bmvVw8Wk0ZJz0Iuq8iSDFggFSfZXN
1lNAlF5Pmrptea8LAmm4ddUyIsUPvhimSPGLZwKkICsG7acC9Didoz8QCAbeNugs
I5NZhIIzCKdCS2SRa3cMQZYCcIajZx5Psi7Y8UuNyzL+rI2b2PShEQI0kPJneG63
/QafmUahJ9F94TEhJuCOrxrRxEG/mWJ4H+GvFbmw3Iwx+j4m3hSWk5OKMzeIjOuH
xtS5LlBI1ZZTPbk0Q7tPD92Bvlel3CA18+QHyiy+g2PKju6I7ZndZeRKfCxQ0myi
qMfuYhqpmbNqlZS9VAMzHSpxPp/A8ognpdNGr+vbs8axwcjzPq+8V1oERVTcvOHL
lltzzGPA
=JjLa
-----END PGP SIGNATURE-----

--1DxUNulrWRRtAg12--
