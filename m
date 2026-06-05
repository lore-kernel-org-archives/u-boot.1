Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5860DCD6E7E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 19:21:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DFC38499C;
	Fri,  5 Jun 2026 21:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Gr3z92X/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C070849C6; Fri,  5 Jun 2026 21:21:41 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A11584995
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 21:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4854d5cc708so1475779b6e.2
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 12:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780687298; x=1781292098; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Br6JCJkcb236RQeb0+7Fc7JKSRyOsaDvzsqfutb2H2c=;
 b=Gr3z92X/ajUDjDu4q1GqrhwR8Rcfis9vYp+WuCB527eiH7Dutqk7ElTTz1PVpDnEOW
 J5Te1OSlqAleQJbCMvT8EbwZxlHtjmgRfiM3DcN7ZsKj5ZiPl0SSIxuyqLa+DLSY1ueQ
 /r+e7HG+J4RQZBjKGcCGPZ7tMPbPiPLBOroUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780687298; x=1781292098;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Br6JCJkcb236RQeb0+7Fc7JKSRyOsaDvzsqfutb2H2c=;
 b=H1u3SuPjNjHXbdYqk+uS0rSoHVsLeL7WQyn0aOwANbgg4EFwW3sCYNEI3zERtsawrh
 cVSBQ1Go7VTXaYBK8WiovjhLSuyeKzC9f66MH2BFSXp1Aw9HW9j3uKM+rMR1SetpGyAc
 eCReoZONs+VIvBNh/km2VZ9H0Z40XTp5rmoDqQaLLbduQ7p225hSqAotpav97yVmrdic
 Koqe8Q6xcM4lWhhzRF5raf5isPSZKqGPD8X9fEsxdhrKhZNtVz6/KwoLS1WDMpG5LiXy
 SiIFLSXg2qnChYpvEU8Z4ez8FtzeKISZiUAisZkAiYtXhTmYE1XN9+qgJEDyfcu5j3C/
 E7Lg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+VUz6qsQzr0eubUo6yDUcGJZiovds6TQrJmlI/AThGJvhMQJs3N/Ns5zPIySPTSoIQcfsdOks=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9jRz8/6jU/UGBGN+qzh0NrlBXl5Fd4lDDQg7VtXX8Ctpm3egs
 YLO+8Zf0/w6POWFmX70n6/AOfEaVXbH5/sDRIMu0BcR8/Xi8CioL3Gy1xjlcG6IDbG4=
X-Gm-Gg: Acq92OEfGKu9AOBU2rMYV/udIbPd+pDv6YgWTquJJTafEj5uHv4WQEO1FF4d62elHot
 rv9lSrj8o61xk+vPiGkZV3f61IbusQcroA1G2q/6v43idm6wFH7Vz2njLSJAQRhzVyH9QXWV0FY
 rOj75WX+U3mSyXJ5nG4SJkkr2+NgRFQxzSC6G7Ednh+2G8SJy0uY5o5Y6aC9Cou/q2GdJuhCt6X
 m4YPsdbqV64qwpk72aN/2jeM50kk9gmVb439Fu9KOaXj6uusnHy3gasb25YUNIrtL2HlFK3e2jr
 dL4J8kxo4iwqvjgc90BloLdeP7b+o3RZ8O3hULvW+qkqWR26xMcjyrhPE06vaG2g1k6P4UwlHsV
 T8qfLbkGw33kZtVQVcCdQk93kEhex+Dq1ob2+GwY6ejh5qj6mRtf5Kiz3ce9G0iOauHyXUZUCt/
 JVGTr5YHbKTlMOsO1MsCFfZMUH5PJ6A//64/nyU0dda8BXTg1DzDhsc1KRkEODtGHa5n5Z+BUDa
 p4aLxTj2O/QXYVPaLXcPWIkOEqNz9NYzQfeuIIBzI3tlj/F94jEnm/AhGGsYg==
X-Received: by 2002:a05:6808:3095:b0:486:87e4:bdb with SMTP id
 5614622812f47-4868de4511amr2971277b6e.23.1780687297963; 
 Fri, 05 Jun 2026 12:21:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b5a5a64sm7487633b6e.4.2026.06.05.12.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 12:21:37 -0700 (PDT)
Date: Fri, 5 Jun 2026 13:21:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1] doc: clean up README.rockchip
Message-ID: <20260605192135.GA382693@bill-the-cat>
References: <e1a0fa32-5418-4f66-98ae-f0e85451dcd2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Pbx6DSrN8AG5eRET"
Content-Disposition: inline
In-Reply-To: <e1a0fa32-5418-4f66-98ae-f0e85451dcd2@gmail.com>
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


--Pbx6DSrN8AG5eRET
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2026 at 07:45:45PM +0200, Johan Jonker wrote:

> Clean up README.rockchip for info that's already in
> rockchip.rst or no longer applicable for the subjects:
>=20
> Prerequisites
> Building
> Writing
> Booting (except for rk3036/rk3188)
> Using fastboot on rk3288
> Booting from SPI
> Future work
> Development Notes
> Device tree and driver model
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  doc/README.rockchip | 563 --------------------------------------------
>  1 file changed, 563 deletions(-)

This is good. What's left to move to rST at this point so we could
delete the file outright? Thanks!

--=20
Tom

--Pbx6DSrN8AG5eRET
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaiMhuwAKCRAr4qD1Cr/k
CihJAQDgoz1lRLighrpS0hd8BkRwJ4ED25+S6K5gi+k65cHmFwD8DEfqfWTYVop6
qaj6G7PuVDOm+ogP8v1w1d4l4yffoQ0=
=qUa1
-----END PGP SIGNATURE-----

--Pbx6DSrN8AG5eRET--
