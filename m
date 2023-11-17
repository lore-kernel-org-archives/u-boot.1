Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC31FC072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 14:53:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24E8686FF7;
	Fri, 17 Nov 2023 15:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G2ea7iOI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA8C286FEF; Fri, 17 Nov 2023 15:53:03 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E7EB86F56
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 15:53:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5c59fe8b07bso15765747b3.2
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 06:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700232780; x=1700837580; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yqJQo90aaQqbpmCjIp7jpEeg3rXtfLzyFTba85eO1NY=;
 b=G2ea7iOIqiPx6HWD/ynDLkupQOcuomcEm6//cM/Yn9eFPRndFB0DbHlFoVQOVgHlgG
 HRinLYQO+zPGIJ/JBciDjoNp7DN1a7UY4dR110stxjSDSujxhV9xhWBpP8DuO3yF1D7K
 bgcB3UPB/k5PEi69AdsD7gllqcY9Cuv8eulFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700232780; x=1700837580;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yqJQo90aaQqbpmCjIp7jpEeg3rXtfLzyFTba85eO1NY=;
 b=nZqU3pWyWlUyxqT8D0dd0fSUTULoNbzSsH/xv90NygfqVIfQJnkXI0pC3IBbxtjuct
 /I6dwrDrAKmkylIQub1zkPbvpK56o/dfM7DmQcvJVARq2B9NvC/Xs/K0e0cweIiLmvD/
 U8ffWHFVuflG83mIZ45N9/y8BVXcDtkozUPfZfNgKZT2sfPqz0WvQb1wm4UYUCTKrQLn
 Top96XygOcObTNaNs0QhyZOI6z/K8qZ4KLe29m+ul61+jCiDLwIUIeuSbUfPGLSIxPMK
 LPmjGkQrNU2rwQLWr8y7M9Z/Pcesi957w/ZiM7iOx+7nACbAFdOn/wiwgQVOkro1LTNk
 NeBQ==
X-Gm-Message-State: AOJu0YwOJa7rqrQzB/gd9j6ia2qncnDr5DfiFVOM3qwtIPR055RYHBzp
 r4d++4zu8uvL7UGBD4xbFzlXty0In289khBzzV08pw==
X-Google-Smtp-Source: AGHT+IHLXUAOiwHu0IhpT/aEF9gQ3yoOQckpSbNDnr56gcw+1C36T1WasmREzn4egdabNWUgOenA3Q==
X-Received: by 2002:a05:690c:b09:b0:5c6:3c93:cf1a with SMTP id
 cj9-20020a05690c0b0900b005c63c93cf1amr2635442ywb.17.1700232779973; 
 Fri, 17 Nov 2023 06:52:59 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a0cee68000000b0065afbb39b2dsm681853qvs.47.2023.11.17.06.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 06:52:59 -0800 (PST)
Date: Fri, 17 Nov 2023 09:52:57 -0500
From: Tom Rini <trini@konsulko.com>
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, sbabic@denx.de, aford@beaconembedded.com,
 festevam@gmail.com, nm@ti.com
Subject: Re: [PATCH] arm64: imx: imx8mp-beacon: Add support for 4GB Variant
Message-ID: <20231117145257.GH170968@bill-the-cat>
References: <20231117013153.4299-1-aford173@gmail.com>
 <20231117144144.GG170968@bill-the-cat>
 <CAHCN7xKiEMTBnXmiVTtp6M3Zwb_vOxgmaQhS=VtA4760bnUELA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ODvawLcHD6ZHhp1S"
Content-Disposition: inline
In-Reply-To: <CAHCN7xKiEMTBnXmiVTtp6M3Zwb_vOxgmaQhS=VtA4760bnUELA@mail.gmail.com>
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


--ODvawLcHD6ZHhp1S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 08:48:00AM -0600, Adam Ford wrote:
> On Fri, Nov 17, 2023 at 8:41=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Thu, Nov 16, 2023 at 07:31:53PM -0600, Adam Ford wrote:
> >
> > > A new variant of the i.MX8MP System-on-module from Beacon is
> > > available which contains 4GB of RAM vs 6GB.  The memory
> > > timings are slightly different, so a different config is necessary
> > > to build the different timing file.
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > Might this be a case for using config fragments instead?
>=20
> I didn't realize U-Boot was supporting that.  I'll submit a V2 with
> the defconfig option removed.  Is there an example you can direct me
> to that does this already?

The beagleplay boards are currently handled via config fragments as well
as a few asus platforms (grouper, transformer-t30). I just now noticed
the latter places the fragments in a configs subdirectory which is nice
I think when there's going to be a number of fragments, but not required.

>=20
> thanks!
>=20
> adam
> > See doc/develop/board_best_practices.rst
> >
> > --
> > Tom

--=20
Tom

--ODvawLcHD6ZHhp1S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXfkMACgkQFHw5/5Y0
tyySngwArpZLVCFM78+tMipCIS+4fkPpcTWM2tN20v6nrCb3LXShtplsVoP2MpkE
S+/580k2XohFMfo6jnZeLFtNneYANFVAU6/1BjYglFTKAYi40CUwaQu1jLdxvsTR
jlHDtov3cTJJc2D3hWFwC5gx3ZIKVi330MhmirUjtHvxvFcI8nmdBGyGWvFypxrL
OHYxyclko6DeNkOsrYSAa3U7htuq4oY1BHIYpZzDwkzX7MZ+dumZGw1gpph/70bD
V1QixxZmMBvXRqoR0QQ2MPSwmCxjL24N+AZ6/Cs01m8ofzyJqyEnd5gRi8n7WEH9
CkKzZmfCj7dG5Hb5SCvuND6TzUU0geSPDws5hZEBE0FTBVSz78J5Rx5ETm2yU3uR
M/Tv/Y/WTExqChxfv2AkKKjZfocLfR9pD2IZBrrqH/LV8QSEpt47qfap58zKpPmn
49h+o2bPzLFk4nHKgtdiOnKQo78TJBNZzvWotPQEH/sis33AjsCGLs+0HBcAY8X8
LBpRf6Ly
=ry2k
-----END PGP SIGNATURE-----

--ODvawLcHD6ZHhp1S--
