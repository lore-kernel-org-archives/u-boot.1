Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4B3D6D227
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 18:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F3D489288;
	Wed, 27 Nov 2024 19:54:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fvNCwEmv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DD3989251; Wed, 27 Nov 2024 19:54:53 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8505B89326
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 19:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-46689dba2fbso373111cf.2
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 10:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732733689; x=1733338489; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ENm0yl7Bfda2qSwqo/xx/luRLbb2jp/xK/bxfTFZBO0=;
 b=fvNCwEmvoeF/AHSWnRebNoJkym92UI7cNmrOsjhJk7+0SErfmb5XlkXccv3bjSEt6z
 +jsL/AgBzmlZ0rTCc6cyakHVVaPs6mxRFTnzYksbsRw5/3QeGVfHt0+sjJZcLmU6aByc
 M8Ve2YHemOS09uu0E8ImK+zQD/If9kmaAzhig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732733689; x=1733338489;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ENm0yl7Bfda2qSwqo/xx/luRLbb2jp/xK/bxfTFZBO0=;
 b=rXBGpVx921kI3utqHBNZQM0c604ro1H9mFa/BZjbuLqnpJGcApH92CFo1QiV5qXXlm
 AtJ94PC4YjWDZTI6Siim1vuj8uGHDf5HW9y+xWalcHI7SXicqsps/yn85NfwOmAQ1SkQ
 2PKqiMatwLGIiOKII49+Xm2jt8kERpN2GkivdQYQifJXATwFYQT2SYFE68k9MtbeXW1l
 uhLjZ9kEJ5X8l2gVjcdKBaEVWMVDDoz5ue6tAoy2WsqmlFKWWphuHvljdwAS60lS1iyr
 kxqp1EUsFL43hltTBGZDlqP2qMmGzJjgXke6Tq0E9oXkui7+utaQnywTbXFiBgBojNPs
 bLoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdjN6wfQsSTJmxZsqrXOBiSsUQZOdP6RAKxQEKpLrWnp7VDJq+AcQ/2f0OBZCMuIbGRtEFzag=@lists.denx.de
X-Gm-Message-State: AOJu0Yxcli3CtiEM3CXS+9sTgn1iliu5t9VoA3MOB+2OfCXxQ/mFXtBS
 vc/C9KPWaAVJ+7fXgCxcpx/XcsUKdH4jzCtG14UkQjdZwQR29dFYrjt7iSNxkR8=
X-Gm-Gg: ASbGncuRooLXglEzdc2Yb0R5vKBJKvX3KvpVG1sd3IurmtkOb6GTWOI+RVX2gbQxyz3
 RecNcAIuKuqVK7nsBM3DVDhsvFVcd+Rffr0OGMUhU90S4afbrf1mgEpiaCJAqR7XE5yZCwM71P4
 N5rsrHRtnrum596cnfnYWrxpHWy5o1uE5q92LxdffSiWCKcOcF/vfeffSuH4Kw/lmRfVqjtCfR8
 mDO/1O83QJ5rMEYnoKb+Z2RCLWpQ3zj7sgcam7xPcCh5j1c2A==
X-Google-Smtp-Source: AGHT+IE2KNHiG5LxGe1wLPb1rNsemzs5R80r8/Zisr/lIMjpRBw6Ej/v5ZcP+GnzBTAqC18sDlXIMA==
X-Received: by 2002:ac8:5a49:0:b0:466:ac9e:8269 with SMTP id
 d75a77b69052e-466b3646867mr71007711cf.39.1732733689340; 
 Wed, 27 Nov 2024 10:54:49 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466b0a61144sm15319341cf.27.2024.11.27.10.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 10:54:47 -0800 (PST)
Date: Wed, 27 Nov 2024 12:54:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 U-Boot-Denx <u-boot@lists.denx.de>, David Regan <dregan@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: Re: Pull request for u-boot-nand-20241126 External
Message-ID: <20241127185444.GB3600562@bill-the-cat>
References: <CAOf5uwkTusCYYEBTQ6xN3SyFg0z3mujVG+SRx9X8kB9E1nWMcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R3nbbc/SFcya+GRh"
Content-Disposition: inline
In-Reply-To: <CAOf5uwkTusCYYEBTQ6xN3SyFg0z3mujVG+SRx9X8kB9E1nWMcQ@mail.gmail.com>
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


--R3nbbc/SFcya+GRh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 11:12:46AM +0100, Michael Nazzareno Trimarchi wrote:

> Hi Tom
>=20
> The following changes since commit 3881c6b90350b0b04085ad46ef64989b43967e=
ef:
>=20
>   configs: Resync with savedefconfig (2024-11-26 08:17:35 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-nand-flash.git
> mike/u-boot-nand-20241126
>=20
> for you to fetch changes up to 5b70f26fed5aee9820530fd818f041d1779a4911:
>=20
>   mtd: rawnand: brcmnand: update log level messages (2024-11-26 21:14:44 =
+0100)
>=20
> Description comes from David Regan, that include a nice summary.
>=20
> Remove device specific nand driver files as they are now replaced
> by a common driver bcmbca_nand.c
>=20
> Make use of OF_UPSTREAM which uses Linux dts.
>=20
> Implement a minimal set of defconfig options to enable basic NAND
> functionality. Tested on:
> 47622
> 63146
> 63158
> 63178
> 6813
>=20
> Set parameter_page_big_endian to zero for bcmbca.
>=20
> Update log level messages so that more critical messages can be logged
> to console and help the troubleshooting with field devices.
>=20
> The patches pass the pipeline CI:
> https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/23=
584
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--R3nbbc/SFcya+GRh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdHavQACgkQFHw5/5Y0
tywXtAwAg0orSeF91IHl3y2/svrxo96GhldTChpNiBOfVA4EQ8aiHIX8E2oA4Gxh
fejPswX+o/9Q8QHGyvMQr3nehR3+hSTaRNhqlhCXOwkDFRjPKTjG4Zbgu7LJ5Orj
g4NSw27UzKfSzWrHgHaDKnXqjjUKBa/KSW/2vgvlbKXV9FR+vAVAUzN+USVYjzYj
pFWq3FidVSOoamgV8/O8O3n3i3YEwrx2xbBf7lXIVT7J202W4SJwepGt0u/r2npd
V5tTTWzUKhJ//AoGXmcQVxzKh9MOnvKF/81jH2QAw/NxOdO6KAl5Rnv1UrF2Lpfb
DP7uhkTDXFT66salfJlTSVOY2rZhPuluoXscM7KajbhEly+SFNYAnCIeiSjmA2lb
diHx6Hre7b/HlAJen3DDzJpkqT9dHyreefB0YemGxAF04v7YkCH5DCJSrChefq4Q
wbwaF4MhfXS22+if+lu8oocyU54WQKVLs4bF5Vgr2xw9gyqbr7JlxuZMaaMFFgQM
QRRRUVbr
=RV/h
-----END PGP SIGNATURE-----

--R3nbbc/SFcya+GRh--
