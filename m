Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6921AE80ABE
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 11:56:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0563486EBC;
	Fri, 29 Sep 2023 13:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LI7q/af9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A69386EBE; Fri, 29 Sep 2023 13:56:56 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E99EC86EA4
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 13:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d86574d9bcaso13009407276.2
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 04:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695988612; x=1696593412; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p25RXEvWTUZwakaPTazkCGR2m5fHlUeM3CtZnuybxYg=;
 b=LI7q/af98K7MMujA27RCmWWeS+Vwx1+qTgkOklsmPvsx9z86ApP0nXf+Tj05mhqLhU
 RN+mgms+LZiTWlSpLCOeO8jvi/cYXbJuM/3MTYIHB5r7dqZ6zXg1PH/DFSNelYxtovHU
 z9pWcxxhozTmCSorreIfRW0B+OfsI6KRsVQCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695988612; x=1696593412;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p25RXEvWTUZwakaPTazkCGR2m5fHlUeM3CtZnuybxYg=;
 b=MMXfYBeLmLFzlXMu9Iu8Uz7TE47ud3ZPmcTzSKsI+F5FzUA6enpnNc6XF6Bm4rHWIS
 /wXhHv7827TrFxD0wte6Pacs8hW0iZAs5fMsPo5PyXIIIYob9J7DiWJ+VYHUAMRIPJRH
 J/i9ZZsEt+4GIjjrazyMARzNjH+s4pPtxPgqbgUJlt2gPewo5CXLt3IvhwhRN+tYLUlR
 rmeZ+cIu8My+ZlQb8KQpTeUgWG0JhQUzbLYVWyELwE6chNKWZHENQrq/TO5fMBYYeQ/Z
 WKnMyz/RV/8MiIpOQ2NXoeydVRO7LDMchbm2mDRjQimU6hsdq6OT37JwEoUEV7T1YySE
 vuTQ==
X-Gm-Message-State: AOJu0YzxwmeT6REPWpq3DU9ZZPMntw3BWb7IovrZs5dRJFDc9a5GT9Fw
 u8wJrQ9XhNOT/PRX6QJceZBGKw==
X-Google-Smtp-Source: AGHT+IEfKfqdcLLndc/6dOF0TSe4Ks0cODssKLu/XvSNbUvYB2WY1l6+fQDscx2S8AcakwVnNnqxjA==
X-Received: by 2002:a25:320e:0:b0:d86:5938:ac41 with SMTP id
 y14-20020a25320e000000b00d865938ac41mr3831597yby.5.1695988612494; 
 Fri, 29 Sep 2023 04:56:52 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a39b-08c7-b2a8-b94f.res6.spectrum.com.
 [2603:6081:7b00:6400:a39b:8c7:b2a8:b94f])
 by smtp.gmail.com with ESMTPSA id
 b23-20020a253417000000b00d13b72fae3esm4989737yba.2.2023.09.29.04.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 04:56:51 -0700 (PDT)
Date: Fri, 29 Sep 2023 07:56:49 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Chanho Park <chanho61.park@samsung.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] spl: Jump to image at end of board_init_r
Message-ID: <20230929115649.GH305624@bill-the-cat>
References: <20230927214415.2224768-1-jonas@kwiboo.se>
 <b99750c4-973f-48f4-9c3b-166f0e5e832c@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="C4htM0N0wb3QYvMH"
Content-Disposition: inline
In-Reply-To: <b99750c4-973f-48f4-9c3b-166f0e5e832c@gmx.de>
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


--C4htM0N0wb3QYvMH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 02:57:42AM +0200, Heinrich Schuchardt wrote:
> On 9/27/23 23:44, Jonas Karlman wrote:
> > spl_board_prepare_for_boot() is not called before jumping/invoking atf,
> > optee, opensbi or linux images.
> >=20
> > Jump to image at the end of board_init_r() to fix this.
> >=20
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > ---
> > This patch have dependencies on the following patches:
> >=20
> > spl: add __noreturn attribute to spl_invoke_opensbi function
> > https://patchwork.ozlabs.org/patch/1827057/
> >=20
> > spl: add __noreturn attribute to spl_invoke_atf function
> > https://patchwork.ozlabs.org/patch/1831366/
> >=20
> > spl: Drop the switch() statement for OS selection
> > from the "spl: Preparation for Universal Payload" series
> > https://patchwork.ozlabs.org/patch/1839731/
> > ---
> >   common/spl/spl.c | 12 +++++++-----
> >   1 file changed, 7 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > index f7608f14e365..79c39820262a 100644
> > --- a/common/spl/spl.c
> > +++ b/common/spl/spl.c
> > @@ -647,6 +647,8 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
> >   		BOOT_DEVICE_NONE,
> >   		BOOT_DEVICE_NONE,
> >   	};
> > +	typedef void __noreturn (*jump_to_image_t)(struct spl_image_info *);
> > +	jump_to_image_t jump_to_image =3D &jump_to_image_no_args;
> >   	struct spl_image_info spl_image;
> >   	int ret, os;
> >=20
> > @@ -735,20 +737,20 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
> >   	} else if (CONFIG_IS_ENABLED(ATF) && os =3D=3D IH_OS_ARM_TRUSTED_FIR=
MWARE) {
> >   		debug("Jumping to U-Boot via ARM Trusted Firmware\n");
> >   		spl_fixup_fdt(spl_image_fdt_addr(&spl_image));
> > -		spl_invoke_atf(&spl_image);
> > +		jump_to_image =3D &spl_invoke_atf;
> >   	} else if (CONFIG_IS_ENABLED(OPTEE_IMAGE) && os =3D=3D IH_OS_TEE) {
> >   		debug("Jumping to U-Boot via OP-TEE\n");
> >   		spl_board_prepare_for_optee(spl_image_fdt_addr(&spl_image));
> > -		jump_to_image_optee(&spl_image);
> > +		jump_to_image =3D &jump_to_image_optee;
> >   	} else if (CONFIG_IS_ENABLED(OPENSBI) && os =3D=3D IH_OS_OPENSBI) {
> >   		debug("Jumping to U-Boot via RISC-V OpenSBI\n");
> > -		spl_invoke_opensbi(&spl_image);
> > +		jump_to_image =3D &spl_invoke_opensbi;
> >   	} else if (CONFIG_IS_ENABLED(OS_BOOT) && os =3D=3D IH_OS_LINUX) {
> >   		debug("Jumping to Linux\n");
> >   		if (IS_ENABLED(CONFIG_SPL_OS_BOOT))
> >   			spl_fixup_fdt((void *)SPL_PAYLOAD_ARGS_ADDR);
> >   		spl_board_prepare_for_linux();
> > -		jump_to_image_linux(&spl_image);
> > +		jump_to_image =3D &jump_to_image_linux;
> >   	} else {
> >   		debug("Unsupported OS image.. Jumping nevertheless..\n");
> >   	}
> > @@ -788,7 +790,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
> >   	}
> >=20
> >   	spl_board_prepare_for_boot();
> > -	jump_to_image_no_args(&spl_image);
> > +	jump_to_image(&spl_image);
> >   }
> >=20
> >   /*
>=20
> In SPL we are fighting for every byte of binary size.
>=20
> What is the impact of this change on the code size?
>=20
> I would expect that your increasing it; especially if only one of the
> CONFIG_OPTIONS is enabled.
>=20
> If so, NAK to this patch despite all elegance.

We aren't _that_ strict, no.  And a very quick peek shows that this
seems fine overall.  Since you raised the question I'll do a quick
world build but socfpga_agilex_vab (as a config I had size change
results for in front of me for something else) shrank by 4 bytes with
just the prerequsites and this patch applied.

--=20
Tom

--C4htM0N0wb3QYvMH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUWu3cACgkQFHw5/5Y0
tywQ2gwAp1iNOLs5JLBma3jJQFsBZ/J5xDu/PIrm9usDXM8EDlGf+12ihBtnXGke
3LKhrmv33YhTQKBAV3dUtETvyJJ9qr7N7c9k0cFISjoyqHGYf0DM8jOFa1P2deMZ
tM+0V2k4Bve8eR6Cs8wv8i1fUgC/1NwAOMWga7vZ15BBOHAaZA5DCEQWsGyM6yjN
uJRjKnTdEKeH1v1jfGJVtVdgDsAXWre+DXwuuakAV+Mu4O4mERPl9p6Ri1o1LiZ2
b4Qy8gJ/jGPKypoaUDWIUdVWdoG1Nvn7wcFNNgdzCz9MQlJ/Ei7b9fl7PHMQUP7a
OJaXTAJGdh2jpelRdCD+8av1fyAmXELr3IEzmdBDBUSvL3ILZPqzCcNBYULKht0F
G4P2S1wRuKyvh+MMqzWpWMGTAFWGrUbKKfN607MEYgPodoCNZrUY4mdkuUUUNn/o
nLX8oTttlRsKbe+zDrWZN3SIde/PceaDYbHBX38+lGau/sk6rmD42GMKZrPVKhca
xW9Yd8X7
=45q0
-----END PGP SIGNATURE-----

--C4htM0N0wb3QYvMH--
