Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D55CD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 17:09:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DE3C84837;
	Wed, 27 May 2026 19:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k5j1qQwk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E77884851; Wed, 27 May 2026 19:09:55 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F3A284704
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 19:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4854d5cc708so3984936b6e.2
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 10:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779901792; x=1780506592; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H9ap0FyY3rCcGLQt7FbZPmzd0EV+JoLaJlfy8W520Pg=;
 b=k5j1qQwk2aPyYSxrprVU7k/+R7Y1Vu7IITwcwdF5mBJzbQ7KmvDv/XltgDzeblWvhh
 nZ+44tvzjOnnWWI49RGoLPuJWAkD0hIIo+Ysb7YiZu81yU0Rw9LjJMtqbvFVs1reVdqN
 2rmlyHnOBEDmuYEq/b3J/hZ3BMnl7NGCYXPKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779901792; x=1780506592;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H9ap0FyY3rCcGLQt7FbZPmzd0EV+JoLaJlfy8W520Pg=;
 b=tI2L2QYefan74fgCLdX0UB1oasLVxpWrRzYAqzlSeq8UGnwrgCe77klizOOtmh/C2c
 zKMQv2ocLSUNS6DM6ONpIN5ftpmzrs0eqtCmMP87lkYkRsICozc1Q2XNvekO24HOpGlE
 w+6ANTi8ieeLjDyfkfqIhBC7o+WoAn/2RT7CUPXlVuwpY32++qsMnZJ59u3kUgYP5QLm
 5042Ngs9nuSzeaEz/R56wnWLkj2M8upzdITk1ZlymMVEjtyzXvzIkS39C4C5KIRjL4wA
 ae+b8dHSE11wcJ0nxkogqgeGFYwde1JLyvDMAob/js5dyPK5wEPMyBtlMitl0hHgMpep
 2L9g==
X-Gm-Message-State: AOJu0YxdKAWckPV1yzFYZGn0Xl+pQsifoY0/f9mAsQtVhd38JppmAphN
 WtPC1pwu8nZudN0M+NrjhWGr/SvrX3zWFgDYyK13SItp/t0hcpGZ/bqPZDg6PrXE3pM=
X-Gm-Gg: Acq92OGL6SYeKCpgH5MKqCzCBky7Vjhz79f0cMSzU88+2PgLTm20VBqd6rq6AkKnuyB
 IFD9KYEhyAzOxnB4bxoUf1zEfwbnZ6OuBddA+UxQ8EmV2cCxzhGOSLQwvAkLPI+9aZQDmiQbrru
 CTuOzuM8zXmjewrc2L0lQof1/Ljb6ACkCX4YO0tvXvYp3IQTwPHuVrBC0B4pv3RmJTaf6jpxu6p
 fyYW+r3zVpVn9rk8w/YXJRnviVWpzi7ofPdsLXGS9opf8MdeNwbrcggouZPEsbZ9HCgRjqEnXol
 T8IThmXQvbC8U4zuTWBR49UfMrDs/y98haTgd7WCy/SS+DOz4Jd1+0Aa1WTUlGyxEb/PgebGbEy
 +Qrbv6CIwad2QFWjFT7yvq8CVqbIA+ZsFOrUGCyWwrXLwMu8kPnRU6W9uxUnF/0pvHpGwxeWqQU
 foSxOddUPa2j7cRs8NiQzyXOFIASrWJj+EcOGKDHIHhyLvfBhAaWF5b5wqP+BFkn0Fmb28Qy1nw
 eNg6jaYTCUSpJlh9cvJq9ro/X16dbZRVwFdflEQmIkmjaQwSMAmRqZb
X-Received: by 2002:a05:6808:c1cb:b0:479:ff59:dcec with SMTP id
 5614622812f47-4854a4502bbmr15044347b6e.32.1779901792085; 
 Wed, 27 May 2026 10:09:52 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43b635e373fsm17048053fac.8.2026.05.27.10.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 10:09:51 -0700 (PDT)
Date: Wed, 27 May 2026 11:09:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Adam Lackorzynski <adam@l4re.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Christian =?iso-8859-1?Q?P=F6tzsch?= <christian.poetzsch@kernkonzept.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 04/13] blk: Use hex indices for the device name
Message-ID: <20260527170949.GH1858239@bill-the-cat>
References: <20260527161033.3273795-1-sjg@chromium.org>
 <20260527161033.3273795-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TcY+r0o9E20JuPGq"
Content-Disposition: inline
In-Reply-To: <20260527161033.3273795-5-sjg@chromium.org>
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


--TcY+r0o9E20JuPGq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 10:10:14AM -0600, Simon Glass wrote:

> It is confusing to use decimal values in device names. For example, with
> virtio:
>=20
>   =3D> dm tree
>   ...
>   pci           5  [ + ]   pci_bridge_drv        |   |-- pci_0:1.5
>     virtio        5  [ + ]   virtio-pci.m          |   |   `-- virtio-pci=
=2Em#5
>    blk           0  [ + ]   virtio-blk            |   |       |-- virtio-=
blk#5
>    partition     0  [ + ]   blk_partition         |   |       |   |-- vir=
tio-blk#5:1
>    partition     1  [ + ]   blk_partition         |   |       |   |-- vir=
tio-blk#5:14
>    partition     2  [ + ]   blk_partition         |   |       |   |-- vir=
tio-blk#5:15
>    partition     3  [ + ]   blk_partition         |   |       |   `-- vir=
tio-blk#5:16
>    bootdev       2  [ + ]   virtio_bootdev        |   |       `-- virtio-=
blk#5.bootdev
>    pci           6  [ + ]   pci_bridge_drv        |   |-- pci_0:1.6
>    ...
>   =3D> ls virtio 0:14
>   ** Invalid partition 20 **
>   Couldn't find partition virtio 0:14
>=20
> Fix this by using hex for both the block-device number and the partition.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--TcY+r0o9E20JuPGq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahclWQAKCRAr4qD1Cr/k
Ch4WAQCJj0lBguhA3pc6qP2Ss+Uc5jFuJxBduCATC9NhlvwhvgD+N0llcaIfCtaj
awIOVLjlnXntA8oVG9HhjkUq4Dl4wwY=
=kpMP
-----END PGP SIGNATURE-----

--TcY+r0o9E20JuPGq--
