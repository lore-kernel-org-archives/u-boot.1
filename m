Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6103EC27C77
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 14:56:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4697188A35;
	Fri, 14 Jun 2024 16:55:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Udoiw6gk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89A1F88A35; Fri, 14 Jun 2024 16:55:09 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 678D1889AA
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 16:55:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6f855b2499cso1175042a34.1
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 07:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718376906; x=1718981706; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8UEsgb2hNxoaZ5wR+InFO5N2F4ClOTxF2FD9CGVn348=;
 b=Udoiw6gkg+qEsVAVu3Yhd/7S/SK+QQm5PjAnK8lxfLCplrfkIol9mQ37JhtgcNHKyt
 gaK0sCWF6WuCk45fLRXpAhMblDihht7e4/GycmTbWvRMNrDjtacvq9nB+TnxWfqsBgYz
 nIYzzorisI+A0GxjzBjJYjPbnnvB7CuLRPC6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718376906; x=1718981706;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8UEsgb2hNxoaZ5wR+InFO5N2F4ClOTxF2FD9CGVn348=;
 b=LO1cEFutSYPsLvaIniZ0cy3xmw+gF76X8M5Bjs7kKdt7GfXcP1lKg5684NVnATeC7r
 yTa5oUzywJl3PuAZqFEAR3ePOwVuervMse+lzEIsvAk//KwVEfVFTtyaKOHdSwHjxXH0
 88W3I5hwyJLrICiHqGlJaqv3EY7wuaEjNFutoMo8C0B1+JFkVMLPR35wW9NWtlTYoy/J
 SKf+iVT7Ry6GrE3L4i/gFVi0AwwVcPiHY8UmBereiqI9pvOIKZ6YEr4Jx8pkL8IyWHCf
 InYeh16xMJ9OCkVSBRrsMAVhos3ars2ydAlvm/pYGDhQnYewWyo+Cj3WfD+tyEH5x+tl
 gGQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU235lDUg2cw9cSv1FPn7gBhWZeqbJ6pF8Betua3syKCmv5vJBLJRLSp1EZMTChnor03zdk9Azkhe9munEjy/WBD9dAQ==
X-Gm-Message-State: AOJu0YxXzKO+2bNeSheLOXyFn865WcU7JVcVbGEdd9f+GOoieLeOaXB6
 QCUvDsZ5JnFgSnRN6gb/J3iI1xpmAummCZZ3MdFmEi1pwMgjqop74rVXahMDeDM=
X-Google-Smtp-Source: AGHT+IGxcq7+nORM4wjuSeVpQprtxbGS6wDsb9ArHFgxLPjbDazZCKC2tEF4IJvrcC6jBD6UkLyeYw==
X-Received: by 2002:a05:6870:e3d3:b0:254:b9d5:a31d with SMTP id
 586e51a60fabf-2584294f1d8mr3136244fac.30.1718376906025; 
 Fri, 14 Jun 2024 07:55:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6fb5b1b2de9sm617230a34.29.2024.06.14.07.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 07:55:05 -0700 (PDT)
Date: Fri, 14 Jun 2024 08:55:03 -0600
From: Tom Rini <trini@konsulko.com>
To: "Limaye, Aniket" <a-limaye@ti.com>
Cc: "Kumar, Udit" <u-kumar1@ti.com>, u-boot@lists.denx.de, n-francis@ti.com,
 m-chawdhry@ti.com, nm@ti.com
Subject: Re: [PATCH 1/6] arm: dts: k3-j7200-r5: Add the pmic node in R5 dt
Message-ID: <20240614145503.GQ68077@bill-the-cat>
References: <20240531130823.646311-1-a-limaye@ti.com>
 <20240531130823.646311-2-a-limaye@ti.com>
 <ace9596b-4fa6-4eb6-9ef8-35a545a2a022@ti.com>
 <30131b07-9368-46b7-b526-55c3af0a9c28@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2eAts+hIxNBRSciR"
Content-Disposition: inline
In-Reply-To: <30131b07-9368-46b7-b526-55c3af0a9c28@ti.com>
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


--2eAts+hIxNBRSciR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 10:24:30PM +0530, Limaye, Aniket wrote:
>=20
>=20
> On 5/31/2024 7:25 PM, Kumar, Udit wrote:
> >=20
> > On 5/31/2024 6:38 PM, Aniket Limaye wrote:
> > > Add bootph-pre-ram property to the buck node in the pmic needed for
> > > ESM error event handling.
> > >=20
> > > Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> > > ---
> > > =A0 arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 9 +++++++++
> > > =A0 1 file changed, 9 insertions(+)
> > >=20
> > > diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> > > b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> > > index fb7e2e50239..78d07ff4e70 100644
> > > --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> > > +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> > > @@ -96,3 +96,12 @@
> > > =A0 &mcu_udmap {
> > > =A0=A0=A0=A0=A0 ti,sci =3D <&dm_tifs>;
> > > =A0 };
> > > +
> > > +&tps659414 {
> > > +=A0=A0=A0 regulators {
> > > +=A0=A0=A0=A0=A0=A0=A0 bucka1: buck1 {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bootph-pre-ram;
> > > +=A0=A0=A0=A0=A0=A0=A0 };
> >=20
> >=20
> > why not to add this in kernel DT
>=20
> Manorit has already posted a series to kernel to add bootph- properties
> across platforms... Specifically the patch here [0] addresses this.
>=20
> Once that is merged, and goes through the rebasing tree in u-boot we will
> need to send patches to remove the bootph properties from the -u-boot and
> -r5 files. Until then we need this patch for the ESM to work. Else we can
> wait till the kernel dt patches make it through to u-boot for me to roll =
out
> a v2.

Yes, we'll wait until we can get this all in via OF_UPSTREAM.

--=20
Tom

--2eAts+hIxNBRSciR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZsWcQACgkQFHw5/5Y0
tywKywv/cZ1huQEt2BYI6VnjHl4glvY/O976m3K975YpBIdOrzUu81QCrJztfd5P
swkXGEM53HfmoNixG7FdjCQLY23+67NbHuZfRq4OvQd3aGlXTpYTFvagLwyKzET+
COZqn/rXPaK7A0kHQfCDjzBWJA+PWzCTbekAK9rzxh+xmZt5t6bBAKYUS6nqDEAu
PNIZEd+WZnOcjPgh0IXnNS07whZP4oEVJQe7b5oMEN2v90i3xErSBMp0RPChrBpB
roYnhqXZgj8NIugCcULPy6O7dWfs0Wjuj6lG3z/+1V1VZ1NQAtYQe/PiMjcweEOI
Hblb/WSnswpftDBRmvGDKkqQ+1vT1r5jXWlRoA2WC3FBENODuSUdp6TO+xyNA3v7
wwiRfBMmIhIz0LGqaKxgyx3dVpPfbljg7idWPxB1ihw1C6sP7zcCd3iIshMSr0Oj
SMWsl38aagUpm2nLUM5VcWprXmu3659tOxiu45PfFciDyD2g+fyE5Vq0Rqq2sz3m
76pYuDMo
=jgDz
-----END PGP SIGNATURE-----

--2eAts+hIxNBRSciR--
