Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F514E92707
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 14:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DFA486E37;
	Thu,  5 Oct 2023 16:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G5jymaOH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6509786D34; Thu,  5 Oct 2023 16:49:42 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3475586CB7
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 16:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d77ad095f13so1119959276.2
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696517378; x=1697122178; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Cvyy50xflLTOGSuDlAltJDB/jGsjZ9lXulP5+LxpsdA=;
 b=G5jymaOHN6xrQnMHMi2hvLwHFV8nSnnLNtmo5ROXL2QoXGoDoJ+jMomQRDPXlAnvvw
 s+EsY6N8kvl2OOaje49NfqJZXfjMHi+X/blJEkLjLjDB6ELWbqhRj73qSos/L9b5oH2D
 idez820ocAKyv23a24+wVEhrenLfrKR8o6ljw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696517378; x=1697122178;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cvyy50xflLTOGSuDlAltJDB/jGsjZ9lXulP5+LxpsdA=;
 b=hcLmkLtydDmzc2Vnoln16QSdPe49u2tUHLTrzU6JEhu1ArP3A32zS5oXo8mHrnRi7E
 3whQYs4KTfpPWJmFL2SYOkgzlG9Ad3PJXWxld7od5TpPsLKHxOTIZY945yhODHiAeC51
 sqpQQaqnRj7Wshr1elvPeCfqUpNldmXK7wO15OAYXCIYENSDwv/dl5ci9Tstjx/zvtPH
 lKAN/8HhfxlhdSq3JkmM3kiG8rrKUX+9/oWoccdNfT/+UFhi1ZVBUQK+zyWh3lEyXXMe
 VwGFu8bUBdVXa6QT4smi5uAQqM9pGYc7QfZYmT6ArV/npNGRUhKJXYObI/uhmK3Z8MK+
 5CXw==
X-Gm-Message-State: AOJu0YwTuIelS+7mwFXEXUkpElzc+TgwU/46TBCKCTmtDzgn2ljOC2eo
 TcI/vENm8zAUOqDghRpfjGUINw==
X-Google-Smtp-Source: AGHT+IFTUAhWVTls27T54GvTClEx6BtnXSYICpY/taOaz2cjYrBDyCR+SJD6GcqNbLolBrIQqRb2QQ==
X-Received: by 2002:a25:d650:0:b0:bfe:e383:6297 with SMTP id
 n77-20020a25d650000000b00bfee3836297mr5379609ybg.19.1696517377988; 
 Thu, 05 Oct 2023 07:49:37 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-f1fa-53fc-3572-fce8.res6.spectrum.com.
 [2603:6081:7b00:6400:f1fa:53fc:3572:fce8])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a258244000000b00d746487d6f7sm425757ybn.35.2023.10.05.07.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 07:49:37 -0700 (PDT)
Date: Thu, 5 Oct 2023 10:49:35 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org, jonas@kwiboo.se,
 afd@ti.com, bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>, Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH] arm: dts: k3-am625-beagleplay: Fix Boot
Message-ID: <20231005144935.GO8465@bill-the-cat>
References: <20231002150053.2930710-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="t7HVRrbXOL6NvPYN"
Content-Disposition: inline
In-Reply-To: <20231002150053.2930710-1-nm@ti.com>
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


--t7HVRrbXOL6NvPYN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2023 at 10:00:53AM -0500, Nishanth Menon wrote:

> Since commit [1] A53 u-boot proper is broken. This is because nodes
> marked as 'bootph-pre-ram' are not available at u-boot proper before
> relocation.
>=20
> To fix this we mark all nodes in u-boot.dtsi as 'bootph-all'.
>=20
> [1]
> 9e644284ab812 ("dm: core: Report bootph-pre-ram/sram node as pre-reloc af=
ter relocation")
>=20
> Reported-by: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>

Applied to u-boot/master, thanks!

--=20
Tom

--t7HVRrbXOL6NvPYN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUezP8ACgkQFHw5/5Y0
tyzv2Qv/fF6/wDunFcMqHIBZi4p3euVEhxNqSRBRtllH8eey6qDpgVc8ElksonoF
xjWmsZ0bZ9MpARb85gamtzK9DJJkZ64mU1Pq/HbdnoQ19RdOTBc91Ltvg5UV0Il3
t00sd0E4OYS2rI2u1mLz0797RbZ90dzsVzzWAXnSfjSr+q5wJn3+sayCVPoXZRFA
S7H2DGXmI0cQ6N9b6FajZjagSQp3L0V/tjpfnML0x2bLIUMifbezYIYfs1D0pXns
HkHdCayP/QexF3wpMcRRlIuvJDdetAwyR1lAylt5FOvvTdunSSftr+ucDgI0ZB2S
i5ed6lDWwO1AKu/3tvsqOgQyfYNta3YORg3GeGejW1Hh5bL/yhzovy4VBIx6Ys/K
dU7F4i+sJkWA+mt5bXmGO0BwI1dv0Zj4g5UkHCIZXEcHzsJiW3rB3/G8ZkyoOo7e
Pb7KEGLMzFTIzep8k86z7h9MR+VpzKFyQwajhnzzEoe7vuUTknZJKX7jtjY/CB+t
NmPl1qUd
=1tMr
-----END PGP SIGNATURE-----

--t7HVRrbXOL6NvPYN--
