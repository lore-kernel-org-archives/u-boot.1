Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D75C87FC3
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 17:08:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5E3388CA1;
	Thu, 29 Aug 2024 19:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XLaOum4c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 635D288CD2; Thu, 29 Aug 2024 19:07:57 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12A0788C60
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 19:07:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6bf825d779eso4914586d6.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 10:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724951274; x=1725556074; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vc1YhGK05MtHrMC/WzMdtfJ/isKFExyLQeSHCneXWsA=;
 b=XLaOum4cG/mORTq7/x01gD/7Ocg5OrsJRChKu9JDB4gfnqC7DWRVQDAID/AanUBIYs
 9B6hw3T3DvV5/Fza7856rQv6gqMOZ5DoM+o1ftxRPE2PUa3+Jgsb+6R4FFIG2f3e+spQ
 AU4EzWHzFBgGoXHWsjs/Rvmi1IcfqcSMfY1+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724951274; x=1725556074;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vc1YhGK05MtHrMC/WzMdtfJ/isKFExyLQeSHCneXWsA=;
 b=t6u9ECbIpPdyIyq9IvoxIYpLmT88UOEqDS6d+shtHIFzNbB+sI6vcxIXFn0t+J2jkF
 djXN2AACvSJifQW8raFtaHBggeuIFtpbF/dVQD1OVQav/8yaMAIDJFP3+1jFNmgDdnzk
 MxnE96jnQ/sQMjnx6FXYb1O7sbJ52YwXKdmbt8MBDFqIJ2cYqioWFy/UztLllUSw1STk
 G2gemJ4B9UJzcVebXhCOpyVslC8ZI8/t5WHP+sGZMMNe1UxojEkCnDgePQZuMoq3CjzK
 oy12sImxBMpCNCl3Tb3cAJyHSckTa3AHL+SLt24J1XMRSfQlGtNEHeedAYVs5hU4ujw6
 w5mQ==
X-Gm-Message-State: AOJu0Yzg7DLCf63A1BzdsI1w6DzmCJBSzj8p5RfX7eLZgu+7cz3UFNlR
 2RSU45QY5+UEWkE0E+VfvW/ROJw+0u3lLbNf0g1KIOsp4Es+Yjy+TJeNFEJJYcw=
X-Google-Smtp-Source: AGHT+IGsg4Wk4cQbAubDIMh6iPO9AilaO2SZRQiWE3AyLlvSxYTqBvNbjzoNbhPSbC0H0HiCCJif1A==
X-Received: by 2002:a05:6214:5d93:b0:6bf:aa45:d1f7 with SMTP id
 6a1803df08f44-6c33e623067mr32339796d6.27.1724951273757; 
 Thu, 29 Aug 2024 10:07:53 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c340c3ef08sm6820726d6.60.2024.08.29.10.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 10:07:53 -0700 (PDT)
Date: Thu, 29 Aug 2024 11:07:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20240829
Message-ID: <20240829170432.GI2479150@bill-the-cat>
References: <20240829125124.3339348-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Mw5n0VYIOBSWIJCj"
Content-Disposition: inline
In-Reply-To: <20240829125124.3339348-1-festevam@gmail.com>
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


--Mw5n0VYIOBSWIJCj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 09:51:24AM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/master, thanks.
>=20
> The following changes since commit ee2af844ba1b27b2e959c4e649e4b769fbeb40=
74:
>=20
>   Merge tag 'efi-2024-10-rc4' of https://source.denx.de/u-boot/custodians=
/u-boot-efi (2024-08-24 14:03:28 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20240829
>=20
> for you to fetch changes up to aec0015a52d3faf723fec9ed9fe1d1af0b89e996:
>=20
>   mach-imx: do not use if_changed more than once per target (2024-08-29 0=
8:34:46 -0300)
>=20
> u-boot-imx-master-20240829

Applied to u-boot/master, thanks!

--=20
Tom

--Mw5n0VYIOBSWIJCj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbQqtUACgkQFHw5/5Y0
tyyOzAv/QVor1CJKALjQlBWqzeyjKEY7dtB90gTE8TFeVoLuZ5SzpKfLUTAT7uxI
414qEXylmLNuvROy7akMd0/8Lpmu/3VNCnyHstZTV0Ra4OB/34b8XkhOQ6oWXc9s
Q3yH7NBmdRXoHoAcKW/fl/6eHqUt/h3Fv1hh6pW+SI+MnNJ8d+C+iOXCaW503UmS
q/3H5aH0ZFM1dcPCflpc97M/4pZ6jW7flHGYlCVMQP8GrFz17Ex5iNMe2EMXBeVS
hbDA9n+kjBNrp0kt4eYo+OJxNA9Mh/uh5bKYTiSRM2izS23OU5aTBP5OjM736yqy
nwB8MxuuP9riVC0uw5R11tTVZAdxx0A5OPZtmmbAV+gnRttE2yxVFb1P9vzpBbIt
MaKtKTUmYCjlWO3P1injXQNGZwiP13EXbPUtqfnm3C+rSTsPHqRnahdCTu3bydsJ
wjUZWOzbsASVm9OMfwTfXOQmOCYN6LordivjhAv1z7h5QyYBgKZyLMhyPP314wma
HrekBtw4
=PMqj
-----END PGP SIGNATURE-----

--Mw5n0VYIOBSWIJCj--
