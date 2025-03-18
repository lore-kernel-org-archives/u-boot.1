Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7F6C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 01:14:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9347A811DF;
	Tue, 18 Mar 2025 02:14:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UGHbKOE/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C54BF811DF; Tue, 18 Mar 2025 02:14:53 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6038B81877
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 02:14:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6f754678c29so56228787b3.0
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 18:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742260490; x=1742865290; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lytH1CuvZubzqc1GZ1HpbSorFPEkxpqXdTxy6/d7DJQ=;
 b=UGHbKOE/ZdYJClkPE//iFnua7z1q91rXxBRpkdFFT6+DkOsvihMGK/oeKVxMpFazj7
 vJPEfrJRuny1pZQHt+QcLIwtmsKAkoyFMWRngzHoU8veilJGDDinoXrlMhnVvX7shglY
 jeGTK4dCAhxXvpbjJzAXdmdlhW8UB9cU+VzTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742260490; x=1742865290;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lytH1CuvZubzqc1GZ1HpbSorFPEkxpqXdTxy6/d7DJQ=;
 b=WidVpq4IWPfEo+z1WBzjSLPP0v6WsOjRoYk6mxqzzOfPsaW0ZjhQNJlZ+MgN/nAaBk
 pSSHLwiRjFp24totA4I31OevPd2AmXg0elFdgelaeJPKQTVZzbhuT4SscrldAIIlC2ZL
 DS6oo3UYxNKgFAYprjdakuhsF1/tg7HvMDt15nE0AQKPysCh3u+tAY5CsKJddT4e2w5I
 YYIZ3xqos02PLdlJdJD6zcyuEMT1Zrlpcajo6lymZRJQIcliQjzEKYKyQpkLHXowDI+T
 pC193qGz8k/ms2bXJZRHLcfQ7MevITu7/rpnzHoZSlE8phrrPQ2A2sQOcQ+do3zaAqan
 ziEA==
X-Gm-Message-State: AOJu0YzP8wvYF6nqhZXg6WzKoBl2qg/1DmEO97w1ygGpNDuocuSLcVrZ
 5OL8xOteWirsnO6aLT27QG0HvTf04Ai9nIhtgZJ/s0WMiP5n50zG1cR3syCvdwY=
X-Gm-Gg: ASbGncuUeD0jpkUnePMaxBvyO5Z4uqKPhgAuhXREwmr6D3fOarLfud/YxQpNaDrnfLU
 51EMgICvtLxVFDvm2Abgsy+hGsakp4xh1BJIHR3xi0xCHM1TNrw3QJU051iNgEIRjhj+sKNT1D3
 5SPbvB5cA0gFZb/nw3AJ0zEFdieOxczN141z0Wq8igRyH9ZJo55Xmswh9uUfSsq1ZxrGA+VNwB4
 E0yQhgTKqbOw/n143mgy7gJ8rD0zb+V+JQWVp5OjaniJkINUPl0rAjUouDH/EaXw+12EBOh+gu9
 j28lHX4UtQORN7eu6hjT8/tZzak41kD+0V2scvPaUzuujw==
X-Google-Smtp-Source: AGHT+IGkxx/p1Ulqlbfe/S6fJM2xUEYPqih6DKgZZRGXCIORhZAZ6cB5gEQODW2BNwdwRWL8vPwGCg==
X-Received: by 2002:a05:690c:3513:b0:6fd:4485:9255 with SMTP id
 00721157ae682-6ff460cea30mr172970637b3.24.1742260490206; 
 Mon, 17 Mar 2025 18:14:50 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6ff32871649sm24129247b3.34.2025.03.17.18.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 18:14:49 -0700 (PDT)
Date: Mon, 17 Mar 2025 19:14:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: Re: Pull request for u-boot-nand-next External
Message-ID: <20250318011447.GV2640854@bill-the-cat>
References: <CAOf5uwkfa9c7Z=CRorRKxku55G==CDvUpmChm8U+Hfmy6HNOfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+rix7N/ZDDbucD8/"
Content-Disposition: inline
In-Reply-To: <CAOf5uwkfa9c7Z=CRorRKxku55G==CDvUpmChm8U+Hfmy6HNOfw@mail.gmail.com>
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


--+rix7N/ZDDbucD8/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 06:53:00PM +0100, Michael Nazzareno Trimarchi wrote:

> The following changes since commit 15d6518c942f0da13f9a7ceeadbd925c3317ec=
8d:
>=20
>   ARM: dts: imx: Drop bogus regulator extras on DH i.MX6 DHCOM DRC02
> (2025-03-13 15:22:48 -0600)
>=20
> are available in the Git repository at:
>=20
>   git://source.denx.de:u-boot/custodians/u-boot-nand-flash.git nand-next
>=20
> for you to fetch changes up to 448d27f6adf6de576860fdb9c3c4ecbe51819e33:
>=20
>   mtd: rawnand: meson: always use OOB bytes during write (2025-03-16
> 14:02:05 +0100)
>=20
> This merge request add support for cadence raw nand driver for agilex boa=
rd
> and
> add a fix to meson driver
>=20
> The patches pass the pipeline CI:
> https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/25=
178
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--+rix7N/ZDDbucD8/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfYyQAACgkQFHw5/5Y0
tyxY/Av+MLbubJPSxJfPANAEQimsqDVrXdBfXYd45UwFxhXVcMBUMqfeOKug1y9A
eFmpd+rM5R/rxoq1fiTsizs+PteP6bYcaqYsO1rGs+yFB4U5PQWxibXQFLhHNiQ/
gGiZmFJ5B7kJrS2/16GAo6kYZZy/9CtF/xNPgWU1nwBkQwb3D6/k3/Au8KB5el8x
1P0cEl8fxwQrJstY/lu5/KFMAoSi8LnsErZNgcttnobh05zVoCyNH2cMITwVFMC3
fVGqj+n5S6ByAXJUdDYtXKv3+u8j1CrgkM4dcbzFBV2tAnm5ktmLvmOva7I8ERde
EpZmDuderRKsWnJnTZih9rjESyE6iezS2tZLs+vxDAimadKmqv9ge3TGLx5sttVY
rAkaJhddrDZ77T0GJy6zcXpSnHETn+j7DNiGJMKodlV5X2G4Z796OPIWPyHSxPRc
UDw1W0aSdXSPKegts6St/U2I0n3gsLU0fi3BXvgmpwY/mzfmxjcNka8AGj/vH8Vb
+3/QCyxC
=JKJ1
-----END PGP SIGNATURE-----

--+rix7N/ZDDbucD8/--
