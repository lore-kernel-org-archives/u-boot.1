Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B23AC25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 14:16:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E82AD88481;
	Tue,  4 Jun 2024 16:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TuAw4Bzc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C59FF8849D; Tue,  4 Jun 2024 16:16:36 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BD1988481
 for <U-Boot@lists.denx.de>; Tue,  4 Jun 2024 16:16:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6f906f52a4aso3396749a34.3
 for <U-Boot@lists.denx.de>; Tue, 04 Jun 2024 07:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717510593; x=1718115393; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VXfkaL4u1BZvkzpS6hSYxRsM9kyaU32b3i4Mdb7utvE=;
 b=TuAw4Bzc1Kh4jUhoZjOLRbWOCePebUnSGA7WODlRkAQEWCLw1uAedSTCcgMJOEmdGx
 THd7YzTeYd1W72gAQR6EcaKT9IqRRl7ej8X7jDKuxB8gQ1xFOFmqddSp0ni4KkJJ6okZ
 K9vOIjQ78wD7G//hIKlFGEwCnYyJYX8dDVt8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717510593; x=1718115393;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VXfkaL4u1BZvkzpS6hSYxRsM9kyaU32b3i4Mdb7utvE=;
 b=Hr+xhMEIObAEsIKUtybyCAkW6EYDpjpMCCwaP1JkBEYwlljS+lhIL0fCNSkeodpD6i
 wnF7zq3Y9zBJyc35dSYhsB4tr6o+LTvQqXTEJ0WXCw1xwLwAwGifvfNIXWN7IQG0Tn+S
 f6hlHOnxc3uXg5kqWTHTCeqsyps97Cp1yOLmq7z18+l2ykLp5Y9FSm2LoPFmj4++NCy5
 8p98NL/B+UubrsoNZTz9EfS6NGA0TKkWpBCKXJXtPJ4CeqdFXePzEf9qaI/84M2/qE7s
 qcnvMxwD943jb1FigN3XWCDWyrr86XaYK7bofSKppqqSNxMlzESuVqHqDj6URfVDatf5
 dOFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8LrIWjq/OPPFIRZWnmQzwdCcXo8ZCbzYJ9Nge5XaUh56aB9ZnZcEtJDL/5QBPNMEzpc66VbcvM/SJvjnf4440IELpnA==
X-Gm-Message-State: AOJu0YxjXwO6k1XSqSR6crYUcodFfNYd4H4LgycDo+OEC69mhcPYdM/u
 R94g5OzZ8R7MeP2Pz23ocZxCjoTGmJVwsK+lJzewNhwbjFVpDby6Pg4D4Xh192I=
X-Google-Smtp-Source: AGHT+IFxdYquhpt5GPcD0a2PWmujnc0A0tvFKcBdtgt0Lg6+YNMfMlO0/vch5nhj2pTySbOj2SUniw==
X-Received: by 2002:a05:6830:348b:b0:6f9:3982:d33b with SMTP id
 46e09a7af769-6f93982d6e7mr2380086a34.10.1717510592819; 
 Tue, 04 Jun 2024 07:16:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f91059cc97sm1958050a34.63.2024.06.04.07.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 07:16:32 -0700 (PDT)
Date: Tue, 4 Jun 2024 08:16:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: "Brunham, Kalen" <kalen.brunham@intel.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Message-ID: <20240604141630.GK68077@bill-the-cat>
References: <DM4PR11MB529668DA50F05F26AAD229F0E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521181534.GD2568172@bill-the-cat>
 <d5887c6d-fc80-4f89-be51-db9b8da3863f@app.fastmail.com>
 <20240527160708.GJ2568172@bill-the-cat>
 <DM4PR11MB52966C57EFE2BE722B9E8DC1E3F32@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240531160258.GN3714513@bill-the-cat>
 <DM4PR11MB5296624D138053E9457054B8E3FE2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240603172322.GA68077@bill-the-cat>
 <DM4PR11MB5296E1D83E3AC318389107E3E3F82@DM4PR11MB5296.namprd11.prod.outlook.com>
 <9a189d18-c748-4fe5-a3ce-9f0f7a5225ee@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iqZjillVLLPZTvHs"
Content-Disposition: inline
In-Reply-To: <9a189d18-c748-4fe5-a3ce-9f0f7a5225ee@gmx.de>
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


--iqZjillVLLPZTvHs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 07:57:38AM +0200, Heinrich Schuchardt wrote:
> On 6/4/24 05:34, Brunham, Kalen wrote:
> > Hi Tom/Heinrich,
> >=20
> > I have https://github.com/u-boot/u-boot/pull/574 that has a proposed ch=
ange. It is currently failing clang sandbox, which looks a little strange a=
nd I'm looking into it. Please let me know if you have any feedback on the =
general strategy.
> >=20
> > Thanks,
> > -Kalen
> >=20
> > -----Original Message-----
> > From: Tom Rini <trini@konsulko.com>
> > Sent: Monday, June 3, 2024 1:23 PM
> > To: Brunham, Kalen <kalen.brunham@intel.com>
> > Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>; Heinrich Schuchardt <xypron.=
glpk@gmx.de>; Ilias Apalodimas <ilias.apalodimas@linaro.org>; U-Boot@lists.=
denx.de
> > Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0
> >=20
> > On Sun, Jun 02, 2024 at 12:16:38AM +0000, Brunham, Kalen wrote:
> > > Thanks Tom.
> > >=20
> > > Can you suggest who is the existing owner of this code I could work w=
ith?
> >=20
> > You should CC Heinrich for sure once you have things working.
> >=20
> > >=20
> > > -----Original Message-----
> > > From: Tom Rini <trini@konsulko.com>
> > > Sent: Friday, May 31, 2024 12:03 PM
> > > To: Brunham, Kalen <kalen.brunham@intel.com>
> > > Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>; Heinrich Schuchardt <xypro=
n.glpk@gmx.de>; Ilias Apalodimas <ilias.apalodimas@linaro.org>; U-Boot@list=
s.denx.de
> > > Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0
> > >=20
> > > On Thu, May 30, 2024 at 02:53:17PM +0000, Brunham, Kalen wrote:
> > >=20
> > > > Hi Tom,
> > > >=20
> > > > What are next steps on this change?
> > > >=20
> > > > I'm committed to the idea of EFI apps opposed to examples/standalon=
e.
> > > > EFI currently requires block devices which is not enabled when only=
 using flash.
> > > >=20
> > > > Should config BLK be updated to include DM_SPI_FLASH?
>=20
> The UEFI implementation should not depend on DM_SPI_FLASH.
>=20
> You could make BLK manually selectable again instead:
>=20
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index 6ad18889f61..1f0e1010f0e 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -1,5 +1,5 @@
>  config BLK
> -       bool # "Support block devices"
> +       bool "Support block devices"
>=20
> Cf. 0417b8523c47 ("blk: Hide the BLK and SPL_LEGACY_BLOCK options")

They're hidden on purpose because most things should select them, not
depend on them. If EFI_LOADER is making its own virtual block devices,
it should be select'ing it not depending on it. There's a few other
places getting this backwards I see.

--=20
Tom

--iqZjillVLLPZTvHs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZfIbQACgkQFHw5/5Y0
tywaFwv+LpjhKUQcMDDrEGqsWh58kXF5Bl2iZNmg3UE4pI+iV5/vRRDgnmUbeNh0
uvR2DSWZ4z2InBKKubzrNXxVJtfsMtmmjC4gY5kU0n+0Tmsx3XPjhHHet+8A70Hy
SQ+fC7+d6jqt62kyGTj5mP+F6uoxnj9RwUDjZ3dG3JpI6COKdM5DJTRBSeRBFLm7
42ui3nU0bd8YhTGE/qbfBFg6Xn/r7dChO2+w/lwZ1yXswwcjp7M9HAIhUAxByHeF
fe0vPPnOfWsvKW4ItlDb0Jgb1/0pZOWPc8ELk+jTd1PgU2YLo2DEsRxgNn+8RGmb
ivpoT7QBFenkJ4heC7uuj7a8zJvSJ7+SBJ9tDlXOu1H/0i9orNlOyKeZwVyiGh91
rK/Mxe07S/xSHpgSEPilCe1uPFrfrZ4+AkJcpdIzayZyeJSiuIQSludd8U6M19Da
TNijVOxSfkb3kMCQIEDyim/O1pqgzysK/bEnYPKxoIhX/vPDHhdHict1HLYJ1lxo
CLkTeEy+
=7RBO
-----END PGP SIGNATURE-----

--iqZjillVLLPZTvHs--
