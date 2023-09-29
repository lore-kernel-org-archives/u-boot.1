Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F11E71D3D
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 14:29:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 863A986ED0;
	Fri, 29 Sep 2023 16:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="COAHCUyx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1B8986ED9; Fri, 29 Sep 2023 16:29:29 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F2C1863D3
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 16:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-59f7f2b1036so118250977b3.3
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 07:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695997766; x=1696602566; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TdnhCkGSLMeBLtP6nVpKIATr7HQnRXW3ufeR2fLVmhE=;
 b=COAHCUyxaqTb1mz89mIDEXyPlernGD55b1jaMeIxB7xnm3Y74cvKvKnzOy9QY/S1fe
 Lq4KEQjHG0f02KxsJITG4VMEpB1muxLUtl4m707c5eGoTiUOShPUyGyNoZTHKbL0QIIe
 m3mj3w+8YK7+OYj8nrGAKFfypfjb8EYvWNRN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695997766; x=1696602566;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TdnhCkGSLMeBLtP6nVpKIATr7HQnRXW3ufeR2fLVmhE=;
 b=FPbwhVWcZLPfBt8zn9O4mHpNb9/npOJuqD3lvcQzScKEMeH4DndZcR7R3CCoaJZrJy
 fEmdLYiB9iAxcPh4IekVDUAX3lYMYGSoucXTOO8tFWCbf8nwX40EsyVBFv8bUnoGD5ii
 yg3YfHkStUKRi1QWbp9ZzMAOhmtK0I19y9YsqC0D+i9kJcrU9vK0b9InzXf4NC0LYZYw
 79e+QpGp70PrwenSozpfQtFuo9JVa4/3x/Dr7yW128i+MHOD0KqIYL20o2CD66UK3xxJ
 eqGjpGqMPMK4aXvdp1mN1ZqV4Nuz5C+U3AmBQ5pmVOAmEGGginwo1ucgtBnKVk0OtErK
 jpUQ==
X-Gm-Message-State: AOJu0YzZ+tvKxOMTW2Uu8ZpsxsTVGx56LYP8Uj3ZJpuciSrbEy30mVjz
 1vD555WXSOEKgbFvh7J02CPAmw==
X-Google-Smtp-Source: AGHT+IGIRx4IZj+mWoJ6Sn1hiyX/eLmwD5OHoBU/CaPpvjBcshlx5fcIlt7bL7OmoZgkHH9T9fQbgQ==
X-Received: by 2002:a0d:d84e:0:b0:59f:8288:c44b with SMTP id
 a75-20020a0dd84e000000b0059f8288c44bmr4341949ywe.17.1695997766014; 
 Fri, 29 Sep 2023 07:29:26 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a39b-08c7-b2a8-b94f.res6.spectrum.com.
 [2603:6081:7b00:6400:a39b:8c7:b2a8:b94f])
 by smtp.gmail.com with ESMTPSA id
 n186-20020a0dfdc3000000b0059b547b167esm5496773ywf.98.2023.09.29.07.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 07:29:25 -0700 (PDT)
Date: Fri, 29 Sep 2023 10:29:23 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Chanho Park <chanho61.park@samsung.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] spl: Jump to image at end of board_init_r
Message-ID: <20230929142923.GN305624@bill-the-cat>
References: <20230927214415.2224768-1-jonas@kwiboo.se>
 <b99750c4-973f-48f4-9c3b-166f0e5e832c@gmx.de>
 <20230929115649.GH305624@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E4Uwci/umZ4ifHrf"
Content-Disposition: inline
In-Reply-To: <20230929115649.GH305624@bill-the-cat>
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


--E4Uwci/umZ4ifHrf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 07:56:49AM -0400, Tom Rini wrote:
> On Fri, Sep 29, 2023 at 02:57:42AM +0200, Heinrich Schuchardt wrote:
> > On 9/27/23 23:44, Jonas Karlman wrote:
> > > spl_board_prepare_for_boot() is not called before jumping/invoking at=
f,
> > > optee, opensbi or linux images.
> > >=20
> > > Jump to image at the end of board_init_r() to fix this.
> > >=20
> > > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > > ---
> > > This patch have dependencies on the following patches:
> > >=20
> > > spl: add __noreturn attribute to spl_invoke_opensbi function
> > > https://patchwork.ozlabs.org/patch/1827057/
> > >=20
> > > spl: add __noreturn attribute to spl_invoke_atf function
> > > https://patchwork.ozlabs.org/patch/1831366/
> > >=20
> > > spl: Drop the switch() statement for OS selection
> > > from the "spl: Preparation for Universal Payload" series
> > > https://patchwork.ozlabs.org/patch/1839731/
> > > ---
> > >   common/spl/spl.c | 12 +++++++-----
> > >   1 file changed, 7 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > > index f7608f14e365..79c39820262a 100644
> > > --- a/common/spl/spl.c
> > > +++ b/common/spl/spl.c
> > > @@ -647,6 +647,8 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
> > >   		BOOT_DEVICE_NONE,
> > >   		BOOT_DEVICE_NONE,
> > >   	};
> > > +	typedef void __noreturn (*jump_to_image_t)(struct spl_image_info *);
> > > +	jump_to_image_t jump_to_image =3D &jump_to_image_no_args;
> > >   	struct spl_image_info spl_image;
> > >   	int ret, os;
> > >=20
> > > @@ -735,20 +737,20 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
> > >   	} else if (CONFIG_IS_ENABLED(ATF) && os =3D=3D IH_OS_ARM_TRUSTED_F=
IRMWARE) {
> > >   		debug("Jumping to U-Boot via ARM Trusted Firmware\n");
> > >   		spl_fixup_fdt(spl_image_fdt_addr(&spl_image));
> > > -		spl_invoke_atf(&spl_image);
> > > +		jump_to_image =3D &spl_invoke_atf;
> > >   	} else if (CONFIG_IS_ENABLED(OPTEE_IMAGE) && os =3D=3D IH_OS_TEE) {
> > >   		debug("Jumping to U-Boot via OP-TEE\n");
> > >   		spl_board_prepare_for_optee(spl_image_fdt_addr(&spl_image));
> > > -		jump_to_image_optee(&spl_image);
> > > +		jump_to_image =3D &jump_to_image_optee;
> > >   	} else if (CONFIG_IS_ENABLED(OPENSBI) && os =3D=3D IH_OS_OPENSBI) {
> > >   		debug("Jumping to U-Boot via RISC-V OpenSBI\n");
> > > -		spl_invoke_opensbi(&spl_image);
> > > +		jump_to_image =3D &spl_invoke_opensbi;
> > >   	} else if (CONFIG_IS_ENABLED(OS_BOOT) && os =3D=3D IH_OS_LINUX) {
> > >   		debug("Jumping to Linux\n");
> > >   		if (IS_ENABLED(CONFIG_SPL_OS_BOOT))
> > >   			spl_fixup_fdt((void *)SPL_PAYLOAD_ARGS_ADDR);
> > >   		spl_board_prepare_for_linux();
> > > -		jump_to_image_linux(&spl_image);
> > > +		jump_to_image =3D &jump_to_image_linux;
> > >   	} else {
> > >   		debug("Unsupported OS image.. Jumping nevertheless..\n");
> > >   	}
> > > @@ -788,7 +790,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
> > >   	}
> > >=20
> > >   	spl_board_prepare_for_boot();
> > > -	jump_to_image_no_args(&spl_image);
> > > +	jump_to_image(&spl_image);
> > >   }
> > >=20
> > >   /*
> >=20
> > In SPL we are fighting for every byte of binary size.
> >=20
> > What is the impact of this change on the code size?
> >=20
> > I would expect that your increasing it; especially if only one of the
> > CONFIG_OPTIONS is enabled.
> >=20
> > If so, NAK to this patch despite all elegance.
>=20
> We aren't _that_ strict, no.  And a very quick peek shows that this
> seems fine overall.  Since you raised the question I'll do a quick
> world build but socfpga_agilex_vab (as a config I had size change
> results for in front of me for something else) shrank by 4 bytes with
> just the prerequsites and this patch applied.

Yes, this generally is a small shrink or a small growth and fine.

--=20
Tom

--E4Uwci/umZ4ifHrf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUW30AACgkQFHw5/5Y0
tyy4Ewv8CLb58lxcolidpXFOh7r7g6/PywWQD8OVcaH7YtXdP49fTTM20tENqlFM
RarnMJIrcKaEaHoeGks4BGOz7v61yJqmNGBLaiPqIWpAEocAvhDzF9qS2J+KFl5r
aYtbXc0563dnqXNc5/ugQqWqabDO2GGTgWpOjvNo5+u4rO3PXIy7uGRvxojUMIcj
al3fug0MsHbc8njd8H6xZ+6pbMSU9YYOgVJhCTTV3Ctc4kcHVVNB/DZbleKq9HCz
kUUyiVmCGaZus+BZjmZEu7JC6fpdngyeGczKoFSxCjGKssvloclZod9ZgRS7JogX
veoF24Vz/v61jUENCG85VMtc8HGUgzVjgpcDc7E03DmOGSQK5VTEdHMN53BmP6qt
L+DMLkgzT099ObYJRup2rhLNrad68aFh+95Ii7DqaXU48FKYTXQZz68tG1CDlYpy
LDEQkfb0HXEQme0AAyph69mbf+pJY9p0yJwaY0m0RSgwZIdzFJuud/SdNjHWIbFr
XtrKLxkp
=1Hy0
-----END PGP SIGNATURE-----

--E4Uwci/umZ4ifHrf--
