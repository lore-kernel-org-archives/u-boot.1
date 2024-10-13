Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E5DCF258E
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 21:54:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 288FF89069;
	Sun, 13 Oct 2024 23:54:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d/m49AKa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FEFC89067; Sun, 13 Oct 2024 23:54:53 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64A9989095
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 23:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7afcf96affaso187701785a.0
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 14:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728856489; x=1729461289; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Bl7XYIw8xzlpK7+SxMi0CskUfTLXVnlo94fTabUQTO0=;
 b=d/m49AKaBbHqQZfgbSD7QJds+rTrUdUcIi19E+oyb3/MoeoJedx3mZ0R0Gad5Nct3E
 Lgz4QcOteogab7PlSBBR2xd6we0XGzESaUL8Dm2rjFyPBsZa9QIIBYBo1IbXpe2ERVb+
 CMD74rAdxpmlVEETIDOpUeu7bre19DM9OxdVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728856489; x=1729461289;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bl7XYIw8xzlpK7+SxMi0CskUfTLXVnlo94fTabUQTO0=;
 b=iC01tqYNMMeqVYjIOQtbXfVaBYIzGH+HDA/AOraBl4zGEu158LtjShEd/iI+A2UmKy
 9h3QIza6mCtjta8FJ4pdUzVxyUTfWaFR2YgyMQpbtn6pZQGv3PapFx74EdJJiIatWY+s
 h5bBnxSgwSrYkx+2aM+YckKisbd6Es9XWoF30+UpMAHpmAQZwWKa+jBWL3kiVLVjwNz+
 Fhzb0oVRzzGnSnfP7ElMt5pdgr7ENryUnoKTEULXXM35xX3c2QfEPuDTAfBxPUyajAJF
 fpYrXRkT+NzNNOiglNy3IKpvBxZ6OiG+prDAWV73yUDPFqBe3DlOmrxWtW73zENphZIB
 r13A==
X-Gm-Message-State: AOJu0Yz2Yfj3glqAJBvpbjTwtsU5irTaVpC3OYGhJ4NyRGL+9xSFzV1Q
 oNqZMUJPHcqFffvgCm2laHRDxeJNyAJNwliGO1pOQcrIk2LWZd+Ke3oNYil06to=
X-Google-Smtp-Source: AGHT+IF/rZPcr6Mw4nF+xvpOxkz6j6mm4/nHvzaGm92cQX7TpaF7K8oVXD4+nPfNMz+eal1Vm26WbA==
X-Received: by 2002:a05:620a:4509:b0:7a9:b9c6:ab4d with SMTP id
 af79cd13be357-7b11a3a9c83mr1661272685a.51.1728856489103; 
 Sun, 13 Oct 2024 14:54:49 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1148c7732sm355888785a.5.2024.10.13.14.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 14:54:47 -0700 (PDT)
Date: Sun, 13 Oct 2024 15:54:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Please pull u-boot-tegra staging
Message-ID: <20241013215444.GA53053@bill-the-cat>
References: <20241013155604.87584-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="72N+JhggWRliUnuQ"
Content-Disposition: inline
In-Reply-To: <20241013155604.87584-1-clamor95@gmail.com>
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


--72N+JhggWRliUnuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 06:55:58PM +0300, Svyatoslav Ryhel wrote:

> Dear Tom,
>=20
> The following changes since commit 93b9cd792089e536f2bfa85d9903fd4798209f=
76:
>=20
>   mtd: simplify CONFIG_DM_SPI_FLASH dependencies (2024-10-09 14:52:44 -06=
00)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging
>=20
> for you to fetch changes up to 711fcd3bdad52ba058e8ca3cf1673bf1b8299be2:
>=20
>   video: panel: add Sharp LQ101R1SX01 MIPI DSI panel driver (2024-10-13 1=
7:33:46 +0300)
>=20

Please note that I made a few fixes before pushing this out. One of
these was a merge problem, but another set were whitespace problems
checkpatch.pl noted and the finally a small mistake of mis-naming the
apalis-tk1 env file (which is a - and not _ like the rest of the
platforms from the vendor).

Applied to u-boot/master, thanks!

--=20
Tom

--72N+JhggWRliUnuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcMQaEACgkQFHw5/5Y0
tywBbAv9EIWYQvppjj4Odk9jgkuLv3wfhoFaf6TJMp3jaF+twwtOSy7gItv1vPCg
u/cEv4El1ZtzS6n8a7jAFeqFUDs8Ew/W3Mft3y9ONFA++kp2RJEJ35L+MrCYSWB7
O4q8BuYjFw+AWBtKmOZsdgYssK/k+jQirluuevn08Q46jBsFBNCNXKPNfrY6Emce
bY19DelT8HEyoUsb5G7526yGGuYbmHQB14xs/dlQRHxTKB5Fg35vKME1x67eDCfc
FediSwzmQ14HhhnUfmasDXebv3NQvaa7JXxNhv/4LvW8+Xxs50uwA4lcGPLDqI/Z
H70D/20hR9n+OzC8HhbFOodIUJ+kkqeS4twZbvGrNa3MSycufkglS8sw3Q6GokSP
PC2dnkn2f82Pf8lva6+106bdUO+eFbQECBz/nFgWmMRRqvDO0fBr8/FT/gOpe9sR
cBqHgyLNrveyHmG9/PPnwMzsumfQrL8fVfMY3j8Yf5bMgCN3nLlONaE6/d0bs62v
xhNMDAuX
=LdvR
-----END PGP SIGNATURE-----

--72N+JhggWRliUnuQ--
