Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FFEC25B75
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 01:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CD5B884EA;
	Fri, 24 May 2024 03:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z2hosl5N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 169A888565; Fri, 24 May 2024 03:48:49 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE0358854B
 for <U-Boot@lists.denx.de>; Fri, 24 May 2024 03:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6a8691d736cso19071936d6.0
 for <U-Boot@lists.denx.de>; Thu, 23 May 2024 18:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716515325; x=1717120125; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x5pBbJm2OJs0yR19IGEiFhltVn/o0khVx9cxAAbExXc=;
 b=Z2hosl5NGrt8yltiOKtxZ22UcYLHbI+Fx3iqh7WiLtntHiURGASwdY2ozYgfk89kPN
 RHH1K43m29+ooxl58bHKVZpUsUjkvt9dGNXVaeivF3Mf2mYdFS6QWDvcL4uF5b5qt/M8
 /y/G+lTaEwNwZSoWBD1CsDd7JkomRWUldW05U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716515325; x=1717120125;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x5pBbJm2OJs0yR19IGEiFhltVn/o0khVx9cxAAbExXc=;
 b=w5QbdPgkq7OiQEeWgrTqvK0Pk9MVz0VzwgOcRNGt4lKcZli99t0ZUCdko3DWgdrSfI
 GsmRZopMkdJFnoqTo92qJN09IrdbGz5CfiNxoV5w2oLOcRvQ4hdmFRMrWkbXapxW6BBl
 8ZXD2keS+Z6wL/r+cIo1sDAaTnVPNSZXTnyMqnYJjHhY4nOq8/bv81RJuFzJi6DdccqT
 FfuXMg8TTLJOzLK6pAVxXFEdSWDtc5P7g002d18kxEQHSRcmdX4eLswOwqd/C+TCA0Yo
 MBo2wn92Mg/XSduj8AShn5OpsBSGcFz3uMmBx/Hw+JpJzJ0Rw3Bh4SM6iy0gLsaGenOf
 5Xqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJtKxjdjGgmd9D0JGV991IR5+wtr6K/fWWK9T7NoCLulhgO4ocB3n6nGCSowwY+bVXmkPixni7Y9gkdxP48NvX3emIlA==
X-Gm-Message-State: AOJu0Yz8phKe/CLLhdLH6QLhp5RgaHCc/XgTjwwjzVFnNDaUCwZDYtgB
 nNG0o/DhM7nNVx4TbVJHE0tITNgSrvBdkEqN2GHzwxFVracp3lR5gPLHzF97+4E=
X-Google-Smtp-Source: AGHT+IGmdj5U8XPKr1mzqL0GTMBG/NZc9Cu1BZRRWnmjdc/MrZraQWKi6RJO69666uV7TRwEcmx/Pw==
X-Received: by 2002:a05:6214:5010:b0:6a0:f0eb:1679 with SMTP id
 6a1803df08f44-6ab8f33c6b4mr68185136d6.8.1716515325225; 
 Thu, 23 May 2024 18:48:45 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ac070c8792sm2490636d6.11.2024.05.23.18.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 18:48:44 -0700 (PDT)
Date: Thu, 23 May 2024 19:48:42 -0600
From: Tom Rini <trini@konsulko.com>
To: "Brunham, Kalen" <kalen.brunham@intel.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Message-ID: <20240524014842.GW2568172@bill-the-cat>
References: <20240521164659.GZ2568172@bill-the-cat>
 <DM4PR11MB529668DA50F05F26AAD229F0E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521181534.GD2568172@bill-the-cat>
 <DM4PR11MB5296769279BCDD505F614E6BE3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521234624.GF2568172@bill-the-cat>
 <DM4PR11MB5296918A0447369D6B27891DE3EB2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240522143908.GI2568172@bill-the-cat>
 <DM4PR11MB52968E794BE8B0A882A519A6E3EB2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240523153239.GS2568172@bill-the-cat>
 <DM4PR11MB5296B8B0051B23A2AD03544CE3F42@DM4PR11MB5296.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="47Y1gwoULuECYVht"
Content-Disposition: inline
In-Reply-To: <DM4PR11MB5296B8B0051B23A2AD03544CE3F42@DM4PR11MB5296.namprd11.prod.outlook.com>
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


--47Y1gwoULuECYVht
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 04:01:31PM +0000, Brunham, Kalen wrote:

> I can see that efi_device_path.c and efi_disk.c both #include blk.h.=20

OK, yes. But what I'm asking of Heinrich is, can we easily and cleanly
make that support conditional? Or is there some underlying requirement
at play here?

>=20
> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>=20
> Sent: Thursday, May 23, 2024 11:33 AM
> To: Brunham, Kalen <kalen.brunham@intel.com>; Heinrich Schuchardt <xypron=
=2Eglpk@gmx.de>
> Cc: U-Boot@lists.denx.de
> Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0
>=20
> On Wed, May 22, 2024 at 05:22:24PM +0000, Brunham, Kalen wrote:
>=20
> > Hi Tom,
> >=20
> > BLK is currently a dependency for EFI_LOADER as shown in the snippet fr=
om lib/efi_loader/Kconfig below. Perhaps the question is why EFI_LOADER req=
uires a block device? If I remove this depends on BLK line, then I can enab=
le EFI and successfully simulate the EFI hello world on my test design.=20
> >=20
> >=20
> > config EFI_LOADER
> > 	bool "Support running UEFI applications"
> > 	depends on OF_LIBFDT && ( \
> > 		ARM && (SYS_CPU =3D arm1136 || \
> > 			SYS_CPU =3D arm1176 || \
> > 			SYS_CPU =3D armv7   || \
> > 			SYS_CPU =3D armv8)  || \
> > 		X86 || RISCV || SANDBOX)
> > 	# We need EFI_STUB_64BIT to be set on x86_64 with EFI_STUB
> > 	depends on !EFI_STUB || !X86_64 || EFI_STUB_64BIT
> > 	# We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
> > 	depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
> > 	depends on BLK
> > 	depends on !EFI_APP
> > 	default y if !ARM || SYS_CPU =3D armv7 || SYS_CPU =3D armv8
>=20
> Do you recall why this is Heinrich?
>=20
> --=20
> Tom

--=20
Tom

--47Y1gwoULuECYVht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZP8fYACgkQFHw5/5Y0
tyxvHwv/REoGV7/X6bPDgGCvBcqRIkhbk7ZRaqczERSFszhAcFbyiYrP2+DrtU9m
OqyG7MXQOzYpKxUSnPxvxP6AgCyIdXaBMNn4DHo2ix7R+n2IscCVdJkL5DeUCEek
pMTMyLmKZ9F7uxSjgomM04qT2KFM0GPNjY24rOC0idhnczpDZ/LhEihYY0XmfyB5
9b76PkeZf3GAwoqK3Ump9w9OFmDiebnm4h0Ov3m/QNBHBw/fY+l3WWk3oUGZPjzl
sQUpy/n89eDpG8dCyprhaFo1ZAq3/mgmetVmIHZs79jd014XS+voMRFZdWGhwzkb
cSJjl9E52lZWV2zj1peatBYPVXdQT6CAqipaECBhxmRvuVcINERDhqc9lGaTn6Zz
T9jJQH92TyDy0hFvTGUZeh4uJzFP1nvIOjyf0NJuk34Fcr76STv/4ZjiGWkDWAtL
3Ico+QyaiXHQU77rThZfPxYKsSgoID8oMEvVxuQXs/WzPsfeSw8wx9ntxIqp/uLB
xR3NOq0L
=3EaU
-----END PGP SIGNATURE-----

--47Y1gwoULuECYVht--
