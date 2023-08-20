Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7EFEE49A4
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 17:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF60E86354;
	Sun, 20 Aug 2023 19:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gJwHYVfO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3717F865DE; Sun, 20 Aug 2023 19:59:21 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B4458631F
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 19:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-d7484cfdc11so987644276.1
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 10:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692554357; x=1693159157;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e8p8u3On+FeW3Jb8P2+QJwGsFwPIEAL9qUxyvDtoM7I=;
 b=gJwHYVfOvgHN5QZqmiJ9VmAojOQDhK+x5v00Ori4OUOcgBHuJgh16DKeyhX+xwp7aU
 QdKYT/7KBOCNYLr7iRAMH5BCDu/t5eUt3bcg0uzxPkWLmRpZ0ALOsathA8Ny+X3rjzrj
 SM9wj+pM6ceJzECJ3jwUvpqF1WRusoGkFYnSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692554357; x=1693159157;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e8p8u3On+FeW3Jb8P2+QJwGsFwPIEAL9qUxyvDtoM7I=;
 b=IP8mq077vmbIgqy4WBU60GOS1p1cf2BhjGww0JEnzttbHuM5XESkRYo7houSneXLcL
 TAsyuJ5kmxSePIEcVMM94F/mdvnS80g5YUR0inPs8T2lMbk9EspD1Iplue3clQR453GE
 xspe1E9Wen+gmJR+zkOe/cpW7l0jorckANZ79tIlMtdu16ADvOtyDJ8pXIkjbgmsTsiJ
 THkPYGlwlUZVJ8ptm2wkCghZ/m2HqeMl05G8LkCbfDzYJxzKnqYRmRNgz8ffnMQRNur/
 vVNwXglbcgzNYk0Ago8HUtlZVLaBXtIcr/qt1HTWRU5qoN2STMjglcmkuracmaiuSA8+
 jLpQ==
X-Gm-Message-State: AOJu0Ywx4VsHzzUlce9tcH22nt/sybbfSCqsuswq9gITS9UG3uND4IYO
 s1JELWfoEZFWtLFsGLOGuH8KKQ==
X-Google-Smtp-Source: AGHT+IGWwfHzKnmuoUSIFUlGC/T2r7LxGtYtUeUy9srE2n//NRHuy5ZoRADpUOWWM5pROUP8F7HjdQ==
X-Received: by 2002:a25:9783:0:b0:d16:f35b:a35f with SMTP id
 i3-20020a259783000000b00d16f35ba35fmr4334655ybo.40.1692554357291; 
 Sun, 20 Aug 2023 10:59:17 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2d48-63ba-cc6c-366e.res6.spectrum.com.
 [2603:6081:7b00:6400:2d48:63ba:cc6c:366e])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a259f0a000000b00d6a91f4c46asm1478386ybq.42.2023.08.20.10.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 10:59:16 -0700 (PDT)
Date: Sun, 20 Aug 2023 13:59:15 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, "Andrew F. Davis" <afd@ti.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Mingkai Hu <mingkai.hu@nxp.com>, Andre Przywara <andre.przywara@arm.com>,
 Mario Six <mario.six@gdsys.cc>
Subject: Re: Dropping CONFIG_SCSI
Message-ID: <20230820175915.GR1515023@bill-the-cat>
References: <CAPnjgZ2jMCpQbBGUx5ZnX1cDNJy3G8+HDMzk92CSwRVCE8TDjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uLjRIXSpeWTKZ2kK"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2jMCpQbBGUx5ZnX1cDNJy3G8+HDMzk92CSwRVCE8TDjA@mail.gmail.com>
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


--uLjRIXSpeWTKZ2kK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 20, 2023 at 11:49:21AM -0600, Simon Glass wrote:
> Hi,
>=20
> The deadline has passed for the non-driver model SCSI code. The boards
> below still have this enabled:
>=20
> $ ./tools/moveconfig.py -f SCSI ~DM_SCSI
> controlcenterdc am57xx_hs_evm_usb ls1088ardb_sdcard_qspi_SECURE_BOOT
> ls1046ardb_sdcard_SECURE_BOOT ls1021atsn_qspi ls1021atsn_sdcard
> highbank ls1021atwr_sdcard_ifc_SECURE_BOOT
>=20
> Please can you take a look at migration?

Looking at am57xx_hs_evm_usb this is just a case where one of the
configs is out of sync with the rest as am57xx_evm and am57xx_hs_evm set
DM_SCSI.  Andrew, it might be worth looking at dropping
am57xx_hs_evm_usb specifically and adding a config fragment under
board/ti/am57xx/ for just the (I assume) SPL via USB case. And
dra7xx_evm can mirror that as well.

--=20
Tom

--uLjRIXSpeWTKZ2kK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTiVG8ACgkQFHw5/5Y0
tywgzwv9EkFBShRvIm2CoEZ9wwfNtvH+U77EOdXjeBLUy503Ar6Mf0s+e+NhXrpT
jkigJdT1MuzROGY+Kt0EuD+RzagUAeGLSDf/7i3B7Ay5vKz5fMhhXk3g3jVPZH4x
WjTWOBcRl59jhrlDVcT9OZbnzB3GQDsbZpHzi6TeyUA4K56diPJlCSVoRtam4Rq3
wbAayiq8rGEOT2fhWAkH3I5HhuomlR1DhxtHwlT3svHYnt/wD8NUr6zWlweF9/b0
vhtwvUwfPhgfEUsKQqIoaEZ7gUFyPb9JqPQDpf4ZKrIqMKl2t5TpG0tQztF6DbCW
Af+zI9ULEmct1cl/TTpE2SUB+/8TXB56ls7LHehDibt5XveSH/z9DrC9vO8Tt3fG
DWjJStgtJxOz7cg4MOqUVqDpllOObISY09Fzpo2UAwVF5KuHIYDKkFaEi1v8gQ7c
dCrQDMoO0Urm5z7jkW6TTInH35xMxgLS8s37OMDQFq4S8pqWmd5c6Z/sbeOk3ZA9
pJJmVew+
=DndX
-----END PGP SIGNATURE-----

--uLjRIXSpeWTKZ2kK--
