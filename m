Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C16D17131
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 20:21:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD44788DC8;
	Mon, 21 Oct 2024 22:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eLZAjCwX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBD5288DC8; Mon, 21 Oct 2024 22:21:06 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A8F588CC9
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 22:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-460ace055d8so28419341cf.1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729542061; x=1730146861; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WCOuBSqaIaPhdPdWxVub/yBB6/SmbHmt9KPjrE4KBl4=;
 b=eLZAjCwX/DMv5gNNx8du+rhuunMScAmdUdL0KAr3qGraUbbeLRbkNCBtnUFLP1ulcX
 hGVGoQ90k1+KC/I7jAjafi8I9eVIMu83tzJlJ3AWpLt4tusAirIRG2wFstnsaJ5pb3Uk
 bg3jZ74ehoLACV6d82mF4X6E4as7qnYIJId6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729542061; x=1730146861;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WCOuBSqaIaPhdPdWxVub/yBB6/SmbHmt9KPjrE4KBl4=;
 b=W7tSVtOl1r5uDqqjaVZt+Gg4S3JBdBez+JicYqUCFT/P2UiJ1VF91rjlukWBDOmRKk
 EEegWE3IE4d7jvucA4wUjm/7UW3bkIVRpBYTal8dERyln5llpp8MpahArPc+v8/WsNsZ
 5/30IL6QmnHS5/867Sx8K6K44fiOa60bvlDt+UK2EA/TR9bE00z6iwCFwUcDtl/I1C9D
 AFE4FN4Nux+iPfF6b8D2N6/CXyCoqjCsvVONqziSYKKYuPh6k9ZK80Hkw1mk3SgyzRAC
 2PBPHjJ8/87ugHUTHDDOpX6hpOvevW0HVSUs6H+e9UfbkJCj+oZlRSST9/ilyuqewgxT
 qg0g==
X-Gm-Message-State: AOJu0YxJtvYxyUyv/updEZkfepegWoLrRusbFTk3Z4NwFlwgf1M+NoAk
 JHoae6fxMqiV0goHMFHe4rvj0JDFqR0ryBOYoeseK6EhB8cnDXSvhg/Kl3SqY7k=
X-Google-Smtp-Source: AGHT+IFib/7FBpTK6qYuOqWiK+T+C3HleFZQzPhZ5AD7Z4VLgBRS74AO07einPxp0R9M5XNTX1Xy4w==
X-Received: by 2002:ac8:7c87:0:b0:461:189:5f35 with SMTP id
 d75a77b69052e-461018960femr2511541cf.25.1729542061392; 
 Mon, 21 Oct 2024 13:21:01 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3c6398bsm21668751cf.30.2024.10.21.13.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 13:21:00 -0700 (PDT)
Date: Mon, 21 Oct 2024 14:20:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Devarsh Thakkar <devarsht@ti.com>, Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, bb@ti.com, sjg@chromium.org, agust@denx.de,
 praneeth@ti.com, nm@ti.com, vigneshr@ti.com, s-jain1@ti.com,
 r-donadkar@ti.com, j-humphreys@ti.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de, akashi.tkhro@gmail.com,
 mkorpershoek@baylibre.com, eajames@linux.ibm.com,
 caleb.connolly@linaro.org, quentin.schulz@cherry.de,
 martinstolpe@gmail.com, iivanov@suse.de, n-jain1@ti.com
Subject: Re: [PATCH 0/3] Simple-framebuffer node related updates
Message-ID: <20241021202056.GU4959@bill-the-cat>
References: <20240925151354.480704-1-devarsht@ti.com>
 <66434f62-e7e6-5414-cc5e-64f516288795@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Mdf++2g/qwDBvMsK"
Content-Disposition: inline
In-Reply-To: <66434f62-e7e6-5414-cc5e-64f516288795@ti.com>
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


--Mdf++2g/qwDBvMsK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 08:47:55PM +0530, Devarsh Thakkar wrote:
> Gentle reminder.
>=20
> Hi Tom, Bryan,
>=20
> On 25/09/24 20:43, Devarsh Thakkar wrote:
> > This series fixes some compilation issues related to FDT_SIMPLEFB
> > and VIDEO and along with that enables support for dynamic simplefb
> > node enablement for AM62x platform.
> >=20
> > Devarsh Thakkar (3):
> >   boot/Kconfig: Add Video Kconfig as dependency for FDT_SIMPLEFB
> >   boot: fdt_simplefb: Remove conditional compilation checks for VIDEO
> >     Kconfig
> >   board: ti: am62x: evm: Update simple-framebuffer node in device-tree
> >=20
>=20
>=20
> Is it possible to pull in this series for -next branch ? It is already
> carrying a R-B for first two patches and last one was peer reviewed infor=
mally
> too [1].
>=20
> [1]:
> https://lore.kernel.org/all/CAPHZmLZopucK5uMwENuF83pRMLYR2A5sC7fes4-1JXE4=
jX7=3Drw@mail.gmail.com/

Anatolij, do you have time to pick up some patches for v2025.01? Thanks.

--=20
Tom

--Mdf++2g/qwDBvMsK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcWt58ACgkQFHw5/5Y0
tyxbogv/Vw/Yk8iqfb9n1W0Jkr8YNGiLP5DNanBGek07NiNg8hjzcqB4yVCKg928
X31cYiLl27mz6AyWUxqc9P+U4qAONHo4idUhD8jPxD+u6xm6x6TIqVhiSFIIj7YE
Be2gsBdlm47ydJapkDpgI3zYTAxDHE3kgZkap56CUzUdFL6I16ReZSaef1sdkYY8
8cvjeuHurHT439Smn1F5HLUp6ZrFp0n3FwMp3wEAQKCKWXaWyVWvankd2A22200d
6VX4nL4aCYSDKPi9oviITqzh17G6Nme2rWFdSUeVINyISljHqCaHON8bNN3h9ASu
2NVB4MtW3U1Btep3cryQSdUqJIyacy7JqO862OO0/ywhi125yDFbZ4guaYHM0ZPg
HJZvnoH1p1PN+6Fo16WbdqZ3EfFMX1/tLSAQxjAGkv6WpLgeRVCRKhAnMSmdWKXw
DTF4Sg22eHYK/q8t40+a+gMPqgjcdgalzjvT/vKVUgTpFuzGE1FdpU10LhMq9K96
I04ioSZK
=HBJv
-----END PGP SIGNATURE-----

--Mdf++2g/qwDBvMsK--
