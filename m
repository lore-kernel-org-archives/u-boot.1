Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5ED7CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 14:54:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09F4086E54;
	Thu, 12 Oct 2023 16:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HlCDDcl0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CB0B86C9E; Thu, 12 Oct 2023 16:52:54 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D09EB86E4F
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 16:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a7af45084eso13939827b3.0
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 07:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697122331; x=1697727131; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CR97kRwfH7GOcEjzAJtkyyHnDsO7nbMFl8wEftX1IG8=;
 b=HlCDDcl0vhaqr7bzPr6clT5DjDBNZ4pSt4TEqOogKSRhxyOBgu5y5fYEVm/1qdM1RW
 mNYFoHfn74bbowHF7VxNlf6sgvtof1Eki+tR85kFd6oKCFtxZdosguydYH/M0aLR45Qo
 ZkS0aG9dpz1uf0FMdG2h9heAlmvH4y68m5EvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697122331; x=1697727131;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CR97kRwfH7GOcEjzAJtkyyHnDsO7nbMFl8wEftX1IG8=;
 b=QikGLqn3Hdugbs5CY06eNpVhzzgmSwKzTfsCTXAn3TbwYlxBO4/3y1mpx4qdJre/tM
 G3oe5a3AiU4e3sZBRC6oinPNrqMhYKIkMJXNDLt0lKqq7fCJ24ZBHqS8yx7/O3VLzfpC
 1ZE6ZGTZpRnOB5JjBDXbMsnB44xXMS4/7YX88LePrXW+Jdyajp/lFsemjhu2mJsDwM5+
 DMAIWbaZvm7BgIDqEdpg2qV3DHautNZ8cn0KimR0sodco8qr21gOkahfxnC099MitaMY
 b74EHwHJx8YXyz1n3MCI7D2+P1NICNyBH4LrmbFsVrmUJ6PqhTlscjOk8S2lTiCz8sbl
 69iA==
X-Gm-Message-State: AOJu0YyJ4rmO/s0Q4pe6mwL+hU2lVmVkEU/i6xkezlSObalpxs5AJ2qN
 SCpe0IkzXykZ4mL9b5joz6jkkQ==
X-Google-Smtp-Source: AGHT+IFYoLoIEdfpywQpWTNwDdCSIsknbqRMcx92QqyFhYnkTPFHL/HRmAMbKn/XkfpYtIuX3zdN6g==
X-Received: by 2002:a81:5e08:0:b0:579:f5c2:b16e with SMTP id
 s8-20020a815e08000000b00579f5c2b16emr30268392ywb.31.1697122331193; 
 Thu, 12 Oct 2023 07:52:11 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a81dd0a000000b0058ddb62f99bsm10598ywn.38.2023.10.12.07.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 07:52:10 -0700 (PDT)
Date: Thu, 12 Oct 2023 10:52:08 -0400
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 12/26] fs: Compile in sandbox filesystem in SPL if it is
 enabled
Message-ID: <20231012145208.GM3119521@bill-the-cat>
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-13-seanga2@gmail.com>
 <d1014630-c1fd-4443-9a2e-c7ae2d029bf2@gmx.de>
 <1cd1d618-ed29-2678-bca3-817c2ce18fba@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l/+qsYHurui9TXEa"
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


--l/+qsYHurui9TXEa
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

And, yes I just said one thing, but on the other hand, if we don't need
this for tests in SPL then fixing fs/fs.c instead is indeed better.

--=20
Tom

--l/+qsYHurui9TXEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUoCBgACgkQFHw5/5Y0
tywkzQv4910eglhejQNCnvUddle6VRLY65/TRJN0w76gvjgQedlUnTS/RwpgJyvS
VA4/HxgzA/fjIGgD3BgVviNGWf+ateD9V/NMUpJahAWAC09QQkm7S6xoQeGSmu5P
EKagVMnO88FDwdf96OLCEgxSDSdrvIWyyjVi0Pz7vXq/bW9pD6hwQu6KJIaoWEd4
XwlcvPUvGX6ri/BmTQDTgWwbFqUmf8SGIYiCtLdKo59gpNT0vJSkNJA0MNytfcfp
Mal4t/V3owkHxrX05O1RdLrYBDGHCwF2RMpYurgGOI1J36xNITnbaCyWuVKC0xgr
RWO3GsWsHO9hvMPmdLHGdzzABBj5DBfYl+9PKMsJZZSe+OQB8v4dWM7fb5V/FmgC
dK7O2nsy5vAEJHC12urgLprH5x4SAFSCngfxdosMu/7F7RcRNtfwfC7Iwrj6tF2M
TC9KXtCyd4SGxV++wbCI890bqJl+FJiLe89O+WKG12w7sUTAQg1bLfZaCSzWWlAG
8dfVvGE=
=a7e9
-----END PGP SIGNATURE-----

--l/+qsYHurui9TXEa--
