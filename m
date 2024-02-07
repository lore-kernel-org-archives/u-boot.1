Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0C0C4828F
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 15:45:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 991EF87D09;
	Wed,  7 Feb 2024 16:45:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fmcm/GUW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D126B87C8F; Wed,  7 Feb 2024 16:45:11 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B25487D09
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 16:45:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3bd4e6a7cb0so489844b6e.3
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 07:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707320708; x=1707925508; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Xv8CHS3OzGIJS1bK84mi1TEE5jX9tZClknTpeA/C3kc=;
 b=Fmcm/GUW6Mulpj9IfRC/mF3nXDsEXpUN8StIuqsZl1vs9+v2TkYsDpH2jOMcpsBsls
 YVC0BAyqtSGkFHMtPjLlLGa/l3PLTqkx4FGLUJhgFZ8qABiUhtmT7/uZ0lfwB7WbTZte
 9uJZwFsKsToBQvIZyrEk0Z6BMx3Ky/4viHAKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707320708; x=1707925508;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xv8CHS3OzGIJS1bK84mi1TEE5jX9tZClknTpeA/C3kc=;
 b=Q9gD0+UdFaH59FqhgwhCyJPzizceqOHYcBAlkELNMd6mN5uyz1J2x5hAc9gEUvXKI2
 SnalFgZ5ESoZjeS4/8wEWZ8R75QhCFRS7I4vA0zhSTLjBSWmE8HL0cSrPSdEpBkdcRBy
 O3QRn+Bj2X5BlVLZyEDR43w+jTjfCI99f4rC0C2RFhCnVjuZ4PhrdyMkrWe9/ihyLV6Q
 I5uPDmdXIZzcUDg8nZM2uKvtO5+2DHoXPWc3OLJbv2Og/8wSuvEHYk3SDvN/URdbLFoX
 PprmNaKFSyAlBHDah9PxAs89FrO7MZMUq2l86iTs++AXRgLP7w6FntOt/tv3a6RrjFp1
 Nsgw==
X-Gm-Message-State: AOJu0Ywh+ZbczItRRBY+gXR3i70f/32X8v6yMxO8yC3cigplVRFSexXN
 tibpm0Cm4HTW5iyvZgPXx2E0hFyKxCqzOM+UbLe7JxI902X+/7YGocXyGDMfi5CyJ7UUaZb/B8U
 o
X-Google-Smtp-Source: AGHT+IHACyNq6QkiZkWd4k3lGRLzpuCeogK2A7JP0Ub33KFVpNwJaxdGf5Lc/ey1R1U0Dl+WvwcFfA==
X-Received: by 2002:a05:6808:4492:b0:3bf:e41d:143d with SMTP id
 eq18-20020a056808449200b003bfe41d143dmr6168392oib.27.1707320708090; 
 Wed, 07 Feb 2024 07:45:08 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWvQs8mOwWr7myfAVNlbKkCJQ/arptPJPmmUCcZlKryG/k4DljPSLca6H0dXR6LdcJVn0YVgKFk12ME7StSu9xltzxGAyM3KEBLkGzQ4EFqYsaYun6A4VdEgRd3mxO6elTNW1CQd0H9YBfrEgglCNj8CRvMMVFw1XoJJv60bl4QTf1EvQQx69LTdhv/9XR/AxbuMy2D0LWpteeIU3RG+rDBD7kjRWFLXw==
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 t3-20020a05622a148300b0042c1ce79b4bsm623907qtx.50.2024.02.07.07.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 07:45:07 -0800 (PST)
Date: Wed, 7 Feb 2024 10:45:05 -0500
From: Tom Rini <trini@konsulko.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, srk@ti.com,
 r-gunasekaran@ti.com, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH v4] dma: ti: k3-udma: Use ring_idx to pair k3 nav rings
Message-ID: <20240207154505.GD1152441@bill-the-cat>
References: <20240130061804.2342672-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vakKsfw/ZUn2ZyoZ"
Content-Disposition: inline
In-Reply-To: <20240130061804.2342672-1-danishanwar@ti.com>
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


--vakKsfw/ZUn2ZyoZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 11:48:04AM +0530, MD Danish Anwar wrote:

> Use ring_idx to pair rings. ring_idx will be same as tx flow_id for all
> non-negative flow_ids. For negative flow_ids, ring_idx will be tchan->id
> added with bchan_cnt.
>=20
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/dma/ti/k3-udma.c?h=3Dv6.8-rc2#n1686
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--vakKsfw/ZUn2ZyoZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXDpYEACgkQFHw5/5Y0
tyzvYwv9EXOjrZ0gbum/VWIbM13MpkmHkB+VgN5qujBVNrjMGfHELt/gALN1bty9
eyhzsWZ+xq8ghXo3VPXgJ1kTcF4x49qZ724G7cXfsPJhaI/gznT88uiVw9SbQ9sc
O/oZulCecVXg6se8bQQ/vOYMvVwDjVav8kOkGPCnHfvgbcR92QIMdtXF4YiXpjfB
tfYHsh2nisdV1VS85L5x7zDlfyWpy+yYU1xxsZcfcMGIbVNLdXD3hbPO148RnLhP
tq0eBPY2GH8lXzfEDK3slIGjMPchpk2/zvbS2vngoZDGUGp8coK1Vse9ha2yE2cT
qMUBy6aLjjFtx/kw0zsMgVoQPr4CVBM7/sN4jsxrZBmOgku/53PFh5DmYFakFWE+
A4Ng/wTkk5o4DoRU4EcLvGUIeaGDmxd9hYSYVsZPM9UhRg4jtIu1EYe9k+iIRbD9
IKcxXNKRa2yH/Rr/VWD4wNMabG4OTuQN05UtSPrPnmJ+KxsLHzR79vpzeIcuT+VA
k+R7C2n1
=CnBW
-----END PGP SIGNATURE-----

--vakKsfw/ZUn2ZyoZ--
