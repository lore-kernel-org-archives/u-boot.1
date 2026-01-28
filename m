Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE2ED3F081
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 15:50:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A742683FFF;
	Wed, 28 Jan 2026 16:50:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BVCzJn7M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E314384008; Wed, 28 Jan 2026 16:50:36 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DCC383FFE
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 16:50:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-45f10d7eb81so3351b6e.3
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 07:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769615432; x=1770220232; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PdRxJzh/9J575kIBgcEPMfgg+stijqiE2HD1MFKRe+E=;
 b=BVCzJn7M2vezmcQQQn9egoraOWhe8aAqFomDjWO0/c/1kqmd+G9oNf3esAfBodZYaC
 R6/I44Bj6toTvkqqyAJ5RPS+T9xTx/nI57CrIk1DkrTh31pHZ1q8btos9jwB0D3r60+g
 kNN66pAezh1tqT+BtbabCn16BMB1fEqSPhiU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769615432; x=1770220232;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PdRxJzh/9J575kIBgcEPMfgg+stijqiE2HD1MFKRe+E=;
 b=S3Ch3HuOTy0rsPkfQwvy4H7BXZ3L507R6s10Ze6h6pxjegZbheLd5fYjkFKOXHS58l
 VSme6Le7HS/Vz6a5gCVoZvZ+zZzYQw+erUZ/85AA2Z5+EVZU/5BUADmx5CVdB82f3feW
 EdxOiJje+geClNEKDVWAAtiZHSLuH2SPhGf1+Us+O/0UxhsRa5JYufiq1i7VdMKCxXBK
 Vgju19RvsMQnqGfFdJLu6HhGJY2eIP28pUG/ZYj6wpF8BMf9pTuGn4++K5qzlRLHL1lY
 Pg5d/wS/7ZQ5TWOZJckW+F31qlGI5A+dxqodxNbOq9MDA3eH56udkMD17NnmpmqjS6Hc
 ERSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnYU/FnmFko60vnIxBsKLqp79NENqeDRgvLIdeNIhU3pFnQCWWd5k0UvLzpmEVz85rh891AwM=@lists.denx.de
X-Gm-Message-State: AOJu0YzlpyZgG8lxIZkD9YMTxEyzzp3Bsk5wCHvGhy3NrrnXyDjGCH8p
 I1IY4/Df6mV2oIVPUraVBDuzWYUkKQWHfVCxZFkRvrgjDUV8CZ9ZPyE2sbeSgGEYWkI=
X-Gm-Gg: AZuq6aLxpnmjDMxs5WvlTjptM5UdhHvlHCzealGD3/OzSpZZky1+9L+I2/S//bVas5F
 L3+aE4g450ujDPc/AVkDPtWOBgX2tY497ryu/yZZyxg6/YqC0Yw4orovupLfauzvDyV6/2G4x6k
 JKAz1kVDmR5emxO7lIdLU3loKPBE3C2tbvEbqYxqgwD+h93VWzD7xo+9JcDsIJ0p7eX9Itbti6c
 Y6kSEk5buwCBGJwXQYaudRLiBO4tYbu1do8T3HGX7SH51decdnDrSoUWV0ZIlb3jpUHTP7l7QZJ
 VnGRhVamEO12dBLj026h9hot0+PYZp4b38Vd7w9hR0QKAH/grpGJfz4DpknF5K2BaaxPgWvr4f0
 kF07FD4dsbmM/Fh01lWV1UiS4/Kz2Ee3C8td9sWUsnlSuWNYMvqpoNrB3QGKPrnXD+/jzlB8KYc
 fDQgSAD1Y6ubAHNSMNTyF0/a7pAdarG6UCThgUZ/LJxEG9JrbNeHU4JO26h3HUA0Nm1Ct5Sa3Zi
 ZLMWk4MrsMq+jWr5JcQHrwpR7odtMZ9CuheNotRShklg2frPw==
X-Received: by 2002:a05:6808:150a:b0:45e:f1a4:2b90 with SMTP id
 5614622812f47-45efc4852bemr3199642b6e.1.1769615432028; 
 Wed, 28 Jan 2026 07:50:32 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4095751ea47sm1958042fac.15.2026.01.28.07.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 07:50:31 -0800 (PST)
Date: Wed, 28 Jan 2026 09:50:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: "Padhi, Beleswar" <b-padhi@ti.com>, sean.anderson@seco.com,
 ilias.apalodimas@linaro.org, malysagreg@gmail.com,
 sughosh.ganu@linaro.org, philip.molloy@analog.com,
 marek.vasut+renesas@mailbox.org, james.hilliard1@gmail.com,
 anshuld@ti.com, afd@ti.com, nm@ti.com, vigneshr@ti.com,
 n-francis@ti.com, u-kumar1@ti.com, bb@ti.com, praneeth@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v4] tools: fit_image: Fallback to 8-byte alignment for
 flat_dt images
Message-ID: <20260128155028.GK3416603@bill-the-cat>
References: <20260128141834.2322865-1-b-padhi@ti.com>
 <71adda09-1f3b-48f7-aaed-845e6a30b6ca@mailbox.org>
 <139a01e9-c395-47f0-a09d-1c591c178bf9@ti.com>
 <3be6cbf5-9a54-424a-9a8e-f43867cb5a3a@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u/bxLcjahzPIx7cb"
Content-Disposition: inline
In-Reply-To: <3be6cbf5-9a54-424a-9a8e-f43867cb5a3a@mailbox.org>
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


--u/bxLcjahzPIx7cb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 04:42:47PM +0100, Marek Vasut wrote:
> On 1/28/26 4:26 PM, Padhi, Beleswar wrote:
> >=20
> > On 1/28/2026 8:26 PM, Marek Vasut wrote:
> > > On 1/28/26 3:18 PM, Beleswar Padhi wrote:
> > > > From: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > >=20
> > > Please drop this , it isnt needed.
> > >=20
> > > > When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
> > > > packed inside the multidtb.fit FIT image. While the individual DTBs
> > > > and the FIT image start address are 8-byte aligned, the DTBs embedd=
ed
> > > > within the FIT image are not guaranteed to maintain 8-byte alignmen=
t.
> > > >=20
> > > > This misalignment causes -FDT_ERR_ALIGNMENT failure in
> > > > setup_multi_dtb_fit() when locating the next available DTB within t=
he
> > > > FIT blob and setting gd->fdt_blob, because of the recent libfdt
> > > > hardening since commit 0535e46d55d7 ("scripts/dtc: Update to upstre=
am
> > > > version v1.7.2-35-g52f07dcca47c")
> > > >=20
> > > > To fix this, check the image type when extracting
> > >=20
> > > "extracting" ? This code changes mkimage, so not "extracting" but
> > > "packing" (into fitImage), right ?
> >=20
> >=20
> > Well the function name is fit_extract_data(). It is documented as
> > extracting
> > all the data properties of a node to the end of the fit. So just keeping
> > the
> > same terminology. Its obviously not in the same context as extracting d=
ata
> > out of a FIT image to consume information...
>=20
> ... check the image type when moving image data at the end of the tree ...
> or something like that ?
>=20
> > > > FIT image data and
> > > > set the alignment size to 8 bytes (if not already) only for flat_dt
> > > > images. This ensures correct alignment for device tree blobs as per=
 the
> > > > DT spec, while also allowing different alignment sizes for other im=
age
> > > > types within the FIT.
> > >=20
> > > [...]
> > >=20
> > > > diff --git a/tools/fit_image.c b/tools/fit_image.c
> > > > index e865f65a400..f842c845771 100644
> > > > --- a/tools/fit_image.c
> > > > +++ b/tools/fit_image.c
> > > > @@ -682,9 +682,17 @@ static int fit_extract_data(struct
> > > > image_tool_params *params, const char *fname)
> > > > =A0=A0=A0=A0=A0 for (node =3D fdt_first_subnode(fdt, images);
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 node >=3D 0;
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 node =3D fdt_next_subnode(fdt, node)=
) {
> > > > -=A0=A0=A0=A0=A0=A0=A0 const char *data;
> > > > +=A0=A0=A0=A0=A0=A0=A0 const char *data, *type;
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 int len;
> > > > =A0 +=A0=A0=A0=A0=A0=A0=A0 /* Fallback to 8-byte alignment for DTBs=
 if unaligned */
> > > > +=A0=A0=A0=A0=A0=A0=A0 type =3D fdt_getprop(fdt, node, FIT_TYPE_PRO=
P, &len);
> > > > +=A0=A0=A0=A0=A0=A0=A0 if (type &&
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 len =3D=3D sizeof("flat_dt") &&
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 !memcmp(type, "flat_dt", len) &&
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 align_size & 0x7)
> > >=20
> > > What will be the resulting alignment if align_size =3D 0x1f ? 8 right
> > > ? I think it should be 0x20 .
> >=20
> >=20
> > I thought we agreed on resetting align_size to 8 if its not already ali=
gned
> > (regardless if < or > 8) in v3 version of this patch[0]. Do we really
> > have to
> > align the align_size var itself? It seems like a overkill to me...
> Maybe simply call round_up(8) on the align_size , to align to the next
> 8-byte aligned offset , but somewhat respect user wishes ?
>=20
> But looking at this code one more time , look at the calloc() in this
> function, I think you might also have to allocate a bit more memory to
> really hold all the newly aligned DTs, right ?
>=20
> Also, don't you need to align the buf_ptr as well ? Consider a scenario
> where the fitImage contains two images, one ends at 4-byte aligned addres=
s,
> followed by a DT. The users passes -B 4 to mkimage, and I think buf_ptr
> would then be 4-byte aligned, so will the DT, no ?

I'm confused. Where did we go from "default should be 8 not 4, for
device trees" to "take what the user passed, make sure is 8b aligned" ?
If the user tells us to do something, we should do it, and they can
suffer the potential consequences. If the user doesn't tell us to do
something, we should pick a reasonable default.

--=20
Tom

--u/bxLcjahzPIx7cb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXowOgAKCRAr4qD1Cr/k
CpVRAP9Z2eOlnzvq8gFdyJrnol9VQ4hu2Tl+n9Y/67Ms9V9y6wD/S/sKrW0dutSJ
SiFm+F22xMGF3upCxE6vtPXOPFMymgw=
=1c+H
-----END PGP SIGNATURE-----

--u/bxLcjahzPIx7cb--
