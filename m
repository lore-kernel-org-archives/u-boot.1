Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F5DCDB47E
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B9E186E7A;
	Wed, 11 Oct 2023 21:04:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ioLA2aoO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC3D186C33; Wed, 11 Oct 2023 20:40:20 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B514F86D01
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:38:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5a7c08b7744so1841837b3.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049489; x=1697654289; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b/AbnGp7BKZTL8cW9eZ1p+l6gNgko5Nr8znLh5CNfBE=;
 b=ioLA2aoObS80n3gxvKVtxUDHuCd+s3Zq0cFSrGdj2/3Plmc8MJtg5US5lYUNqpze17
 g+dFzOqWeOCg/shq9Ek6+vI3G22gFIWxb4qPHlfOqLdYZvdTiM+v+y8sKQqCC7ASs5qd
 ZIiyQzL1b3rt7XXgQCCWdS0XVMa4XsxxKAccA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049489; x=1697654289;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b/AbnGp7BKZTL8cW9eZ1p+l6gNgko5Nr8znLh5CNfBE=;
 b=l3fVVMthmwTqlNOtd/jIoyETsnQCdmZ/1QUxGnx9MpPluwAdtUL1VtiQAAZSnzPXcF
 fIMyKbGCgbS+vXv/QDQxyfBh0KoLKw5GcSlSH9SVVs30NuAOIwzmtBok8vvcXby/TwTj
 2OvrGyqQTBXOUQG8aVsHmeH84SedwfqE8POfDddNlkowexmFzB25yq8S2Tj9Y2zLNqjG
 YlGM5KNLjDrloT1rp3X1aeT1LqtiNI3tRRPYD+EN+nxQQ/5F975kOXarevDccxvyFq25
 ru2d4P9XBffC1l4wOlLChr7JMcc9KdXTKDIXS3eb8oqNqzMnlGw4VvBrpIpXrJVONJTO
 1icw==
X-Gm-Message-State: AOJu0YyF/5gEqvJhQhzbYoFTSpn4B6kZ2aXZhmWXM8p48l01upI3O5DW
 5hJJ6dEle+E+lSYgSqVUQEhFyA==
X-Google-Smtp-Source: AGHT+IE2OOEsIBZN4CIHsfhSO/h0JBPkjAZww6vUTDPx3QC9lSmWRUDWkES4VolLtLbWv7rOyGqyrA==
X-Received: by 2002:a05:690c:d87:b0:5a5:7ed:cf80 with SMTP id
 da7-20020a05690c0d8700b005a507edcf80mr25905843ywb.23.1697049489282; 
 Wed, 11 Oct 2023 11:38:09 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 w19-20020a814913000000b005a7bb193b37sm1529861ywa.27.2023.10.11.11.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:38:08 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:38:06 -0400
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Ramon Fried <rfried.dev@gmail.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] misc: fs_loader: Fix alignment of fs_loader driver
Message-ID: <20231011183806.GC3119521@bill-the-cat>
References: <20230930204546.515776-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6OVcIYPmbxzBF4nP"
Content-Disposition: inline
In-Reply-To: <20230930204546.515776-1-seanga2@gmail.com>
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


--6OVcIYPmbxzBF4nP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 30, 2023 at 04:45:46PM -0400, Sean Anderson wrote:

> DM_DRIVER_GET will redeclare the fs_loader driver without the correct
> alignment. This causes GCC to use the default section alignment of 32
> bytes. This in turn creates a gap in the linker list due to the padding
> required to achieve the correct alignment, corrupting all further entries.
> Use DM_DRIVER_REF instead, which doesn't redeclare anything.
>=20
> Fixes: 0998a20cfc6 ("misc: fs_loader: Add function to get the chosen load=
er")
> Signed-off-by: Sean Anderson <seanga2@gmail.com>

Applied to u-boot/master, thanks!

--=20
Tom

--6OVcIYPmbxzBF4nP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm644ACgkQFHw5/5Y0
tyx/Cwv6A5YgCSRszS/3tK2Nuettj5OWL2eifqdjklORV6zEZ/uPyykG0+R4r/8d
OAOUqBOu3E56FbRFZm/86WgU8G5YW7hCLWj78M6D0zN3piE4oWpTp2J+2hx908kH
aTUptexiNZY0J8khxY1dkgsxog10Ec1DU/Zg7BHJlyqw81FMcQb3DmJji5WvQWC9
9IXhxM5VCaiNlYlc9NsBXiB4nakauZPw0HNxjp1emn6r7+R6MmQD+Phm5PaYYOMM
SAQgi+Xg3fWeavODHbQcr81irXX2Txlzgwf9uENvbgaNXkmqjgOUe/KYVvl+ES2G
7IgNPGuUZHyHyjxBvQt9fh9wxuujlBLCuC96o52VYPq+O6dw77Av8TeHkgn8LsIt
agBlVhCSC5hG+OFl0uQ+fwgAEqKk+L72sRgnxZ9jUCZ+bsB0ylUiN2ArBQfm95cY
g0/dFJtc781VYXv6EJcp0EDgxJyP8wcfhEQvlPaUQrhnRbKX2ElJPUlW/9wlvOpS
9whqn3rK
=zOL6
-----END PGP SIGNATURE-----

--6OVcIYPmbxzBF4nP--
