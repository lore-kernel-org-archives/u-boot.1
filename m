Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE02CDB475
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 18:43:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DD7186CFD;
	Wed, 11 Oct 2023 20:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FAak0a07";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21D2A86CE5; Wed, 11 Oct 2023 20:36:52 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3155386CD0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-d9a3d737d66so127364276.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049390; x=1697654190; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ziaeae+R+t4M6AbSpuLq8M14w9GOsrnkD/DOJQyV6HA=;
 b=FAak0a079R2Lzm89EpjDyTumQNqyQ6suM1Lq1Idb2cWG5BxjMNycEZWtHVr1vmWzuZ
 T2WfrpfvcT1ah0telaI5ciefAicIA60DJr3+4DLj837l657ZdBGX332ao1FyU85uRMYr
 YZLqql0agymLzokLprpD2TCpS82jH0niyxNLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049390; x=1697654190;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ziaeae+R+t4M6AbSpuLq8M14w9GOsrnkD/DOJQyV6HA=;
 b=JEQ98xBEe8sd8RILvc1bPRI36DPTS6ucHzOZp4Brf+Yag0cBK4KDLke4ieWpIrvDI5
 Ah54LTaU8sQ0STFkANXpQ1vhcbHK+he68EEZDf+c9pCyx2rv3wVaAVMNJic0+AeLbVSr
 C6Yg//FzLKhQWwEnz5No0rb88tZD1L9Td5uLE6akBnTlAq51XVHKgUuUMGCJ1nas7bB1
 d33CTA+AW4Td5QZbySNkJ+p0sih8jtxYas5g43OVOg3VVyPfYaqk7rc/sTV4oI9Fhcdx
 921W2efGuBEClhvC0P2iVxw3Gd11MnYN+cpmjiLA6d7kpLGeqwMNQboDRdojozGXjZgs
 4TYA==
X-Gm-Message-State: AOJu0YxltxkmKZdQ6Ojf3Y5Cfe/8JFLoDbCxCSdBdBh6akhtMDjJ6nin
 PYb7q2uVzHtlihVahJKd+B/kjA==
X-Google-Smtp-Source: AGHT+IFKB+J3fgtOXYGYWqACDD4VBuaL9SW/FkezHBGiTR6IU3l+ufHlcxf0vFvgXhzZoSOYXHDAvQ==
X-Received: by 2002:a25:8906:0:b0:d9a:b843:89af with SMTP id
 e6-20020a258906000000b00d9ab84389afmr224572ybl.38.1697049389885; 
 Wed, 11 Oct 2023 11:36:29 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 b63-20020a253442000000b00d9a4f3bdffbsm1469296yba.11.2023.10.11.11.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:36:29 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:36:27 -0400
From: Tom Rini <trini@konsulko.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, m-chawdhry@ti.com,
 sjg@chromium.org, jonas@kwiboo.se, afd@ti.com, bb@ti.com,
 praneeth@ti.com, Roger Quadros <rogerq@kernel.org>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Subject: Re: [PATCH] arm: dts: k3-am65-iot2050: Fix boot
Message-ID: <20231011183627.GH3119521@bill-the-cat>
References: <3376a0eb-57f4-416a-b4b8-86cee769d6eb@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fdtlOIf0tw4PSyVf"
Content-Disposition: inline
In-Reply-To: <3376a0eb-57f4-416a-b4b8-86cee769d6eb@siemens.com>
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


--fdtlOIf0tw4PSyVf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2023 at 06:37:17AM +0200, Jan Kiszka wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> Since commit [1] A53 u-boot proper is broken. This is because nodes
> marked as 'bootph-pre-ram' are not available at u-boot proper before
> relocation.
>=20
> To fix this we mark all nodes in u-boot.dtsi as 'bootph-all'.
>=20
> [1] 9e644284ab812 ("dm: core: Report bootph-pre-ram/sram node as pre-relo=
c after relocation")
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> Reviewed-by: Nishanth Menon <nm@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--fdtlOIf0tw4PSyVf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm6ysACgkQFHw5/5Y0
tywYdAv8D1E/jp0avcxt3m9AlMJg//QKldPb9GQeByWl1ObuLwdVv3rgjwUxSmF2
dj5sBIVGQJseMGHbiCIlFmANKZ0EGQlfK5F5mABeNPys1dK5RP0yuMNxGTTmLuy7
0ja+gtPTh4CZkuNXiZ6jmr9Mact4Q77It5M7k9mVjP6cXI+Xm0HVKVcYk5/KvhnQ
hcm6rSw+X3u09fbJ6xwwi+4KLNFYF0Vlp4XQg1Xfylu/r6J+YeyBq/08Hs66Ck3i
+inN2dAwlJF7VM1znwLjw4/ZL5DN++LvIEtKwAe1iwYgJ35yBNnHlO0OB0A7o1WY
dKkmegLCvNp9AchcXclcL+Jm6siGqdNUNC4+dTbpn/V3IkshCiHl0G0uuPatoyFR
06uvJPej+lQiTzKlAkYgwa+nqZ+qlvrA8qrtTIolkcmw7V9kvBXFh3nQLxhN27Wi
QQJOTALgOwU9XA6/deJchXGVujwFjdDseG/7pL8H+rvFaLljles7SJ7yrCKmm2AB
cxq9eMg7
=7Vds
-----END PGP SIGNATURE-----

--fdtlOIf0tw4PSyVf--
