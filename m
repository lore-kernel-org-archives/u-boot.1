Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC7AC3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 20:48:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E702B88791;
	Mon, 29 Jul 2024 22:48:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Eku3JV6M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DEF888875; Mon, 29 Jul 2024 22:48:00 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33DC0885F5
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 22:47:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-260e1b5576aso2746841fac.1
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 13:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722286077; x=1722890877; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Vk5qrmPuAIN/2dKT69nmcwqEj4nYelEAYjC8j0oW2ss=;
 b=Eku3JV6MJw8Sv9CPd3/0CFgkaxtr1L4zzVi2lB9gwIva83G+U6mYhSOEeDUyZCN+Y1
 xzPdWHJi6UEtRm1TGizwrS9vJuUrMDWWAh+sbbjnvSAWyXafPdrS+eE0Aj1WPGBrVZHP
 XjlUUtxrKTU+DnFWkCSFB1aAuOa1gvq91u/zU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722286077; x=1722890877;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vk5qrmPuAIN/2dKT69nmcwqEj4nYelEAYjC8j0oW2ss=;
 b=gYEW3qQzq2U8hbNudJG66MwEx+TdWlGF/1CtneMG0ZyD46WtDgDC0wCUDIaQ5qnl8M
 hYhreCu+JKzj6ACMeAeB27W8IZ84sgMXy0SuvtZNaDNZz0JsPVXzXreG1LBv8VWxF7sy
 d8kmmUg8Xph1yFduuAMqJVltdlRrEBXDE2vsRVMUhYK7uEM2tuIagBSyB+TpneM7TPLv
 k/xsDVM+Op51kCFgYeFhcDvBVNMKwFR6yiD7jCHFGjRDj8IBKJjoDeiFHboTU8okYwx6
 GdpcQln0Dw2EihcW5S2zJxPR1/9/d349J2BA7VVD7d1F3cF98uaI+ZrkrBguDebn8/B5
 yHwQ==
X-Gm-Message-State: AOJu0YzqyFLYoCjX+Qh1dAgzigZ5btjdLurv03XIWIk8fDWgm2eTgMQp
 lKzPsH9eq38s6p37Q7v/c/YPMfP/CffYtzH2SSdgmXORqGFoPoFS2Drozu9LNwc=
X-Google-Smtp-Source: AGHT+IE1lXOObcPt/q4ToPVfkNHhaJZWheP2GV2kS8wVxCzer/Jp7PGqDWiOXkcDIp1P6u7aB9CZMg==
X-Received: by 2002:a05:6870:15d5:b0:261:6c0:8a26 with SMTP id
 586e51a60fabf-267d4d16660mr9271569fac.4.1722286076903; 
 Mon, 29 Jul 2024 13:47:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2653e640030sm1957350fac.16.2024.07.29.13.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 13:47:56 -0700 (PDT)
Date: Mon, 29 Jul 2024 14:47:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
 Govindaraji Sivanantham <Govindaraji.Sivanantham@in.bosch.com>,
 Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>,
 Heiko Schocher <hs@denx.de>, Felix Brack <fb@ltec.ch>,
 Marcin Niestroj <m.niestroj@grinn-global.com>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH 1/3] omap: Use spl_soc_init instead of spl_board_init
Message-ID: <20240729204752.GR989285@bill-the-cat>
References: <20240729204439.429900-1-paulk@sys-base.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PIDZ2uKLyylGaEUv"
Content-Disposition: inline
In-Reply-To: <20240729204439.429900-1-paulk@sys-base.io>
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


--PIDZ2uKLyylGaEUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 10:44:37PM +0200, Paul Kocialkowski wrote:

> Both spl_board_init and spl_soc_init are available as ways to run
> specific code in the SPL's board_init_r. Use the former for init
> code that is specific to the SoC and leave spl_board_init available
> for boards to use.
>=20
> Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--PIDZ2uKLyylGaEUv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAman//UACgkQFHw5/5Y0
tyyUvgv+Mqqp8TFZsYicA7ZjzTwd2eUYnmCQBwrbw+RNx9lICMjYDwEIi/jFhAuA
8s+YqUQj/F2CLMhnWe7kJFUN5cUJuPFB1TVq9X262Bk/61PMbnQ/oJ9foRI6NRob
pyYMDj4LWo+pj4DO4huvVIao+KTeB/eEuoTKRzyMwO9H+QxHRiqIkuOd32R9jGua
AU7OPzknkozx/UX6e0BkeMeA7meHspqWe+wh410kms9lgG8zUCAQ+nlKM1CW24BY
GEYL8ejt1AOs9xZ4ZwiVK+Wtf881OcYsplsf9HSxMRT6di2IU6mVddaueTFPjGt4
h3D3EjLCGHiJSOC6bs7dfaX1HprGW7kDyt0hbQd/20uGFWJ0sYWvNNJX55anNTaV
zecUfK+qctnWsfwz4fOmlCa2JBI4jKUyqLDRg88eXdcHb4LS4WQB0pKSmiYZ0F6v
cFaX6nkk3WkyUnCUNoVfxXacIMTwtCWmM56ccvVmArmiMpofNWdiBj0RI0UeE6fs
EAzMR6hu
=u5gd
-----END PGP SIGNATURE-----

--PIDZ2uKLyylGaEUv--
