Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CC3D16271
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 14:02:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFE45890F2;
	Mon, 14 Oct 2024 16:02:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mPrBnqS4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A14F3890F4; Mon, 14 Oct 2024 16:02:27 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 455EF88CB9
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 16:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4603aced3a5so36046041cf.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 07:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728914544; x=1729519344; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CRg3px5Vm4PCD3AGLY3YI9272buzsF7rb9/f8u0K7ME=;
 b=mPrBnqS496gnXWxy8rL9VoleuEdRHV1cpvL4uao44DLW6LeNbspo+ru6FNNxw56PKY
 cRCQGqP0DNgjfGh+Xj1y3NTCTlO+0reszS3rf6pEI9GNPJ5n3jv+F5dmWF2yLbF6r7BR
 rEj+TnGKAp4ecXjtBQEH+rD3OoAtAmQiCQCw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728914544; x=1729519344;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CRg3px5Vm4PCD3AGLY3YI9272buzsF7rb9/f8u0K7ME=;
 b=vWwbsFQTJpIIxzc7ylowet+gwDyRD1cP84EWzkLaiZPBH/lKc10rpklyR6OMLBUxNn
 WPRognSGeM10jjjKkQ0YsZzOXOYrCTWg2Jo/t4mFUe1kfYTRPYBFHCUUfiSgQ62Wjb7v
 EKTDIlIYvt0BZQdmbjBYB0UurXQSWzkZ5W8Eqa5NynqlLrnmiMOIgZb9Zt9Pr6c+Cx7s
 S/Awa0drDRl39s/k7UscMkuodpCjimvsvvt62oSm9sA8zLfDlH1p++dEv4bbyFgQbRjv
 9K5ZvmitZdV12qQuH8f9K42GUpQDWMaY3WuTH2BDfB/B7itLCY80ZP6n92FQ9QP8eZiH
 s2VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV96lKHEB9RW1qk0vmAc8nub1kq93jZAMnaxzHatFjBebeY3eu0fSXd8qtelpt7qtqQ9xi5zWU=@lists.denx.de
X-Gm-Message-State: AOJu0Yxo6xJB46H/8nUfyY0p190d1M41KX8W8TcHGZEZLOIUK4wi22Q5
 c7OQ3Jqto/S0V4xZuhR+mgraQDSFUapWVaof7WBv7OL27rgGP0QEnYELj1rcW0xP48Wq7ToDuU4
 dp+M=
X-Google-Smtp-Source: AGHT+IHK+kOTgWX0R2Y0tnK+9I1V3NhCOCv5wJELJdzKyItVQ+PvA8TIYd/VMKaPMUg7NfRm9GfOBw==
X-Received: by 2002:ac8:5708:0:b0:454:f384:41e7 with SMTP id
 d75a77b69052e-4604bb94ef0mr163044181cf.8.1728914543576; 
 Mon, 14 Oct 2024 07:02:23 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4604288204csm44827061cf.61.2024.10.14.07.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 07:02:23 -0700 (PDT)
Date: Mon, 14 Oct 2024 08:02:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: Pull request: u-boot-sunxi/master for 2025.01
Message-ID: <20241014140219.GG53053@bill-the-cat>
References: <20241013234531.9990-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="44WtwmuqlpcUvbQr"
Content-Disposition: inline
In-Reply-To: <20241013234531.9990-1-andre.przywara@arm.com>
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


--44WtwmuqlpcUvbQr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 12:45:31AM +0100, Andre Przywara wrote:

> Hi Tom,
>=20
> please pull the first sunxi changes for this cycle:
>=20
> This switches all boards with the Allwinner H616/H618/H313/H700 SoCs over=
 to
> use OF_UPSTREAM. We are doing it for this SoC family only since the DTs
> between the U-Boot and the kernel repo are exactly identical, whereas oth=
er
> families have one compatibility fix in U-Boot to allow booting older kern=
els.
> Other will follow if this plays out well.
>=20
> The biggest chunk otherwise is adding support for an Anbernic game consol=
e,
> using the H700 SoC. For that we need to enhance the DRAM support code, and
> pick two DT commits from the mainline kernel/DT rebasing repo, followed
> by the defconfig patch.
>=20
> On top of that two small fixes for the old Allwinner A80.
>=20
> Gitlab CI passed, and I booted that briefly on some boards, including an
> H616 and an H618 one (with LPDDR4).
>=20
> Thanks,
> Andre
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The following changes since commit f8efc68b30e29360f7a419fe4968432179d736=
8b:
>=20
>   Merge patch series "spi-nor: Add parallel and stacked memories support"=
 (2024-10-09 09:02:22 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sunxi.git master
>=20
> for you to fetch changes up to 2f7ab49644ed38b6e3fe5eb6cd3f7e3f683fc6a7:
>=20
>   sunxi: Add support for Anbernic RG35XX-2024 (2024-10-10 00:43:51 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--44WtwmuqlpcUvbQr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNJGsACgkQFHw5/5Y0
tywZ0wv8DtDEROcCim1F8RhF11fDbOgU2pBqr7nLU/2iy7qGrEn0EWwSglkcdF1c
MnrVGwAro5X9OQ5VNyUdVcXH8cf+8X/R8NiJfaaLvuU81fSYfBwbmVMLNsXPi/w+
8lPQPwPS2teCDqKEq+zOLYJE+/38myNNt77SRzx9Hf/XZzCvNfMTKTP9XfPkICDa
mDmsf/It68C81RpS/hwaCxXrSlKEECjt6fh5R9CO4AJmnnsprqANQxoTP0+S2sJ1
zVfVaKwXb1YbZ0oA69zWsmOBag0kjQPHZ2yFEnbedyP5/StyCgnf3c8z5Aq0RlJk
srGKpK0y/nfyC9C1r2co+gMbB8U0E330P0/pvCQs2xwKMQtdsP7xuskl9VXGCoQU
ZSeJLf/1KPfH8jFVdPvfY0KU43r5AijjljrnymVRDxDB1lS9rfoDAHiDeUzo6Dov
4HO1HXH2Bss23p5eRxLitdJvZWAl5GAVOmq1lgCYbh/cSkhEpbx83huUOnZhCTQZ
Va0ceY12
=hXGb
-----END PGP SIGNATURE-----

--44WtwmuqlpcUvbQr--
