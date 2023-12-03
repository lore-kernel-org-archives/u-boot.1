Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA71C4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 21:31:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D84358753C;
	Sun,  3 Dec 2023 22:31:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NVJQZC/U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EEAC876AC; Sun,  3 Dec 2023 22:31:18 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D34887539
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 22:31:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-da41acaea52so2057480276.3
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 13:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701639075; x=1702243875; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Aki/hKz5oXHayt4BN+UFsG99zLoSg8H/Vq7Lt8sJ74k=;
 b=NVJQZC/UbCvNVOHe6WnisCDxAQPChZspRtMroXPnRFqzdeq8Ga/IEKVCQLXBBxqvSD
 b4jEw3XXKkYJvHdx2ZEB3XTLNKAzvawIuHzo+ctp8RZ+FOGLnKmF53CzQmkSVc6XRFuH
 ghYxl6cO9HR8XWi/BttyjLfBZ1byzJmyJKEm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701639075; x=1702243875;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aki/hKz5oXHayt4BN+UFsG99zLoSg8H/Vq7Lt8sJ74k=;
 b=g40iJtrpyZX+nrgEfhNVBREYBZY/5dAiaXl2z1X3vO4SGgSrmt3yYNY0rB5CC+2VDg
 HfrybXGbUf0z+YdlrDRRzvhV0c8/jRyOU92j+oP8gSkL5JB+VTDLQruPrEj48L6Flbgz
 WCCrxXeFGXs2p4ouW8sKtp7VkrL1b/UUEaF8e6SFsGIrKkojsSSCQGJLyuf7wacOiEzG
 CgNThK6Ky/MendWjbztJuOlD8cmWiaId7MFGJV1dFWlvj1X5O812LRn5h+z+V/bI8xHn
 oe6k/bKkyxAuUVnegH7PDKqokilzME1P1Iq7QLzciuE0IGHU7Zfu6SuNgwY52Nd/x5ZL
 9d4w==
X-Gm-Message-State: AOJu0Yyp50BEa6kCe3igLep1h57IjcH9aByl33EV4qV9rsdu9gDDK9yR
 lOoQ57nCgjZsu1sQndsdb0iljA==
X-Google-Smtp-Source: AGHT+IFig4K2GnSG1CjSuUAsoS6tkDBd63rbqyEhrOswJxRxXjGEFQoxQ4s80QbRLDrjqCojt1SgMw==
X-Received: by 2002:a05:690c:82e:b0:5d7:1940:7d7f with SMTP id
 by14-20020a05690c082e00b005d719407d7fmr1977176ywb.86.1701639074776; 
 Sun, 03 Dec 2023 13:31:14 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d911-24f0-9d18-22cd.res6.spectrum.com.
 [2603:6081:7b00:6400:d911:24f0:9d18:22cd])
 by smtp.gmail.com with ESMTPSA id
 z143-20020a0dd795000000b005af5bb5e840sm1443625ywd.34.2023.12.03.13.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 13:31:12 -0800 (PST)
Date: Sun, 3 Dec 2023 16:31:09 -0500
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Hector Martin <marcan@marcan.st>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PULL] u-boot-usb/master
Message-ID: <20231203213109.GU2513409@bill-the-cat>
References: <20231202062552.415353-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8cqjXh+rnv6ZCcx1"
Content-Disposition: inline
In-Reply-To: <20231202062552.415353-1-marex@denx.de>
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


--8cqjXh+rnv6ZCcx1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 02, 2023 at 07:25:14AM +0100, Marek Vasut wrote:

> The following changes since commit 43f2873fa98b1da6eb56d756315c7bd7db63db=
27:
>=20
>   MAINTAINERS: Step up as co-maintainer of Tegra SOC platform (2023-11-28=
 11:23:02 -0500)
>=20
> are available in the Git repository at:
>=20
>   git://source.denx.de/u-boot-usb.git master
>=20
> for you to fetch changes up to 493e0e2577bfe11b3065a30a6f5c827f95c1df94:
>=20
>   usb: USB_XHCI_PCI depends on PCI (2023-12-01 16:01:59 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--8cqjXh+rnv6ZCcx1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVs85oACgkQFHw5/5Y0
tyw1pAwAsRMvN0L4nra4ILw2+xoGOt0dO2QJFk/yKW/4DYS6mctoiya+WkPgoPHX
/Q9NHY+UuLoTiKnpPV+R1SxxsI6UFr10DMkuVuuDl4cnZhzan2oNZA48mVlP4N+D
j1SzkZHgIiLlEs1wvYGf/JT3kd4SVn5AhdaKiN762tFcuNHUxxyiViet5iEhDvi5
s/rV7Z/vuGaQQ4zvmNYb5FgVJ3DOC0dnLQ5mDyngppyOoUzQZVS0KKIgMEhY5KE1
/9+CWmQ/VMWnxmCFVxKHq9Q2WrMuvXDbjSc7zSdZL74e+dVTKmLhigeexxXFmKuI
h24gpCMlJq7gtlJAM1RxQ84lKuvTaCF0IhIHg2B7Q0z61EVTSxWVff8/8COQ6qRl
CkKnDP6OCnv/kPM1nUUz5I0YafuXWVt7soa6RMVY8vUw0d184SQNctKvVycctnP5
YlyRTR+OtyTOyLPSU4EPGXfOeAKTJW7JK3HZ3sKrfWBjV1t6sawUPZBi0scsfWnQ
yzPVQV4Y
=MQar
-----END PGP SIGNATURE-----

--8cqjXh+rnv6ZCcx1--
