Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AC8CDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 14:52:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D91F86E14;
	Thu, 12 Oct 2023 16:51:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ou3AFYEc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80E6986E0E; Thu, 12 Oct 2023 16:51:46 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00DA986E39
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 16:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d9a4c0d89f7so1133690276.1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 07:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697122257; x=1697727057; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/CyVqx27Hazbx+sDxk7djjarqeDHThLbBNKfA0JXbvU=;
 b=Ou3AFYEcuo83nXV5bzY8Z639oE3jJNM4AUomZyzVBgT1z3TolZRo38UprQTTHn1CHZ
 tS4dHpSOCmOObWKWslLHklDBAeuUs/4gRV4x9gZ2YQ1oHFzx2B1ncIM23/tKa0oB1br8
 qjxkXfKmce4RWrQ+iCTFHU+eDpbZ9W60wRNy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697122257; x=1697727057;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/CyVqx27Hazbx+sDxk7djjarqeDHThLbBNKfA0JXbvU=;
 b=m41YzD14TDUHDDXILIF0NJyBxnTAbCfuUYDF7k14HmhTy21RZMV/6Fj7FWgKNBXCnU
 Jg7qbqt9wV0B+QvrsKXv/zoHoGY0y+i55Si6zPOOJWRjcnST/t6Gn7tKH3ZQ0UX70KG0
 LrOZnD+1WWKf9+tY/s9Veil0KQFkYSTT2qrxLeZ4nDHPkL35k9MSkSRCywifpafsgrw/
 oLmkxUPegZGPqyavF4dCkZ84o1UGeOrdiAakamhpkTMy02h62MXp8HQBvtAZ/Am+KrAx
 QhzNyF8ockyfucSVJ5OXgis2dYohFDy1SeHX0sskJpyJjSVXMwmtyffTQ1gyoeYlQ54v
 iAew==
X-Gm-Message-State: AOJu0YzK6gP4L3AB2YJyEYkGESgW63DdoDH35j6O0K3MRKBxayuyP5ae
 gxlJcTpNPO+/DNS0JwyNGk+26w==
X-Google-Smtp-Source: AGHT+IF07/3qbeXq54fiH+ymXMoZLctNLomoxG4k7eYq619gVtTgJBq22ZwhKGyk6Zqhl/BPSqd5Vg==
X-Received: by 2002:a5b:343:0:b0:d42:d029:ff99 with SMTP id
 q3-20020a5b0343000000b00d42d029ff99mr21116891ybp.55.1697122257131; 
 Thu, 12 Oct 2023 07:50:57 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 j4-20020a25fb04000000b00d818ced8939sm10329ybe.1.2023.10.12.07.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 07:50:56 -0700 (PDT)
Date: Thu, 12 Oct 2023 10:50:54 -0400
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 12/26] fs: Compile in sandbox filesystem in SPL if it is
 enabled
Message-ID: <20231012145054.GL3119521@bill-the-cat>
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-13-seanga2@gmail.com>
 <d1014630-c1fd-4443-9a2e-c7ae2d029bf2@gmx.de>
 <1cd1d618-ed29-2678-bca3-817c2ce18fba@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J0qtQCux27IL726f"
Content-Disposition: inline
In-Reply-To: <1cd1d618-ed29-2678-bca3-817c2ce18fba@gmail.com>
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


--J0qtQCux27IL726f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 10:15:45AM -0400, Sean Anderson wrote:
> On 10/12/23 02:39, Heinrich Schuchardt wrote:
> > On 10/12/23 03:56, Sean Anderson wrote:
> > > fs.c thinks that the sandbox filesystem is available if SANDBOX is en=
abled,
> > > but it is not in SPL. Compile it in SPL to avoid linker errors.
> > >=20
> > > Signed-off-by: Sean Anderson <seanga2@gmail.com>
> > > ---
> > >=20
> > > =A0 fs/Makefile | 1 +
> > > =A0 1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/fs/Makefile b/fs/Makefile
> > > index 4bed2ff2d99..592c7542bde 100644
> > > --- a/fs/Makefile
> > > +++ b/fs/Makefile
> > > @@ -9,6 +9,7 @@ obj-$(CONFIG_FS_LOADER) +=3D fs.o
> > > =A0 obj-$(CONFIG_SPL_FS_FAT) +=3D fat/
> > > =A0 obj-$(CONFIG_SPL_FS_EXT4) +=3D ext4/
> > > =A0 obj-$(CONFIG_SPL_FS_CBFS) +=3D cbfs/
> > > +obj-$(CONFIG_SANDBOX) +=3D sandbox/
> >=20
> > Why wouldn't you use CONFIG_SANDBOX_SPL here?
>=20
> Because that's what the check is in fs.c. Maybe it should be
> CONFIG_IS_ENABLED(SANDBOX) in there.

"CONFIG_SANDBOX_SPL" is not "CONFIG_SPL_SANDBOX", so CONFIG_IS_ENABLED
doesn't work.  I would suggest that fs/Makefile needs a bit of cleaning
to make use of obj-$(CONFIG_$(SPL_)_... logic instead of ifdef
CONFIG_SPL_BUILD, but I think Simon dislikes that form.  We could just
move the existing line outside of the SPL/else conditional.

--=20
Tom

--J0qtQCux27IL726f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUoB8sACgkQFHw5/5Y0
tyy9Hgv4lHRFknZImoVsNtgctXptJfnWWcuFdzrgxjhYOhP+gDACBI2ixnBPysBU
OKmO0WyDOb5X6PfKksFsP3LG+jGNxrlyedqOv8rME+wMIeAYd4WVB/XhgIPhuc6U
6+hIkrNTVOixzQZU97982WrOlE/GQKbL5RRC1LGY7fisklQuY2H/DRZ6RNrd8OBo
PnXS8u0s7ODcqq/BCRE3MfAfl3d42RhAgh2dKKG2vY6aNtgrQKbfCS5lmglIC28Q
pfTzHjOY5/vb5W/2TFUwhif5Cy8Qfox/0rIwq1ox+ch7/9+c1vQzohsN6qRg1onv
GciL7uDW8SsoPB82H16WNbddzfixXrW/0cK+y656ZtLTNUTTZSRdRKe3tJjMBcns
g2npZE2jMZqE4RTSss5lzCWXOUqTxjEhg4ZkG4wJbeMbVrKkJZEMQZOs0IPSud4U
4Zmf2xBCxd4Om7Uj4RM4ssoRnkjv71KysEtznpCdSiy5I6ug+09P4uE+4UB7bLSV
wkSSZ10=
=RH4Z
-----END PGP SIGNATURE-----

--J0qtQCux27IL726f--
