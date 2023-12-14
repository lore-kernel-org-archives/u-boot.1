Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA1CC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 14:39:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D19A187A71;
	Thu, 14 Dec 2023 15:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Tiv4bAU2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB50B87A80; Thu, 14 Dec 2023 15:39:30 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6596F87A2A
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 15:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-dafe04717baso7694673276.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 06:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702564766; x=1703169566; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RC/3sgl8MBaMXRcc7zZVC5lCyGp4NBPMZV3JZs1CRMc=;
 b=Tiv4bAU2G1GGMVR57TsI6JNGm/QL9TLpA/TbO0kGaVxhTpTtQ9w3vZlef+zyVU1fL5
 4TrqzVbBsL+CbaMUtmYaSztan+glhrpy1gEQxRAK9j9Z6i49tuUKhyZl0lKHaS13aT0J
 10kzFPcCnWplRoTvrQj0Dzomug2CWTu0gpvlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702564766; x=1703169566;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RC/3sgl8MBaMXRcc7zZVC5lCyGp4NBPMZV3JZs1CRMc=;
 b=D0Mo3imRTp4OLLjDn3T4MY5n57uLbmr7eK2SNIDFCD04Ly/nGJy/pudKsi4dPyv8pa
 0WATRUgmvlV3aNUDR+74ly737l7aRQ2Sy0LxP4TC2ob/S59sb7gdsjF/+JmAVgGVRcjV
 24O/9S2qXfEvmvMggPzdxNyN1CjngI2fYFreEHIq2sGRKhji/SDhrOwRKKoaJcB7wkVh
 c27o1TZzjqrZPlXZ7IiiFf91HBJIrvFprEmjhaU+MtvG4myjjqJ44r00FjHdlFCS9z6E
 JGqbSSMZ4sDfsxn3r/PPhNr9usoesPqMDsKqaDCz9q5Krl2/uX/gszR8aEl+gPxDSsjq
 AFeQ==
X-Gm-Message-State: AOJu0YyY3bq7hS9C/FBwPWfFUOaDJY4FCr8fx9nULNnVJCOEC92cf3uX
 vQmpmQzIvpOvj5gKRA9iEqojru7YbUrvPINuX5E=
X-Google-Smtp-Source: AGHT+IGb6xS/wbHd0Ye9A6dp0kCCkJf5IOY4AREtgs4ghsPCroDRT8hqONHTWYDPy2/2JECYJRtG3A==
X-Received: by 2002:a25:ae1b:0:b0:dbc:daeb:70ff with SMTP id
 a27-20020a25ae1b000000b00dbcdaeb70ffmr1398268ybj.68.1702564766069; 
 Thu, 14 Dec 2023 06:39:26 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 cj9-20020a056902188900b00dbcd9bb4bbasm949461ybb.58.2023.12.14.06.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 06:39:25 -0800 (PST)
Date: Thu, 14 Dec 2023 09:39:23 -0500
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Rick Jian-Zhi =?utf-8?B?Q2hlbijpmbPlu7rlv5cp?= <rick@andestech.com>
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20231214143923.GB2513409@bill-the-cat>
References: <KL1PR03MB6059E8E8F10CAE683A330D1FA58DA@KL1PR03MB6059.apcprd03.prod.outlook.com>
 <20231214121902.GW2513409@bill-the-cat>
 <ZXr5FhMwRT4gpwsK@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pGEXChzw5qbHBeVt"
Content-Disposition: inline
In-Reply-To: <ZXr5FhMwRT4gpwsK@swlinux02>
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


--pGEXChzw5qbHBeVt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 08:46:14PM +0800, Leo Liang wrote:
> Hi Tom,
>=20
> On Thu, Dec 14, 2023 at 07:19:02AM -0500, Tom Rini wrote:
> > On Thu, Dec 14, 2023 at 10:38:07AM +0800, Leo Yu-Chi Liang(=E6=A2=81=E8=
=82=B2=E9=BD=8A) wrote:
> >=20
> > > Hi Tom,
> > >=20
> > > The following changes since commit 20d0464300c25db673cfb5e4539aa37676=
06d151:
> > >=20
> > >   Merge tag 'u-boot-imx-20231212' of https://gitlab.denx.de/u-boot/cu=
stodians/u-boot-imx (2023-12-12 16:33:57 -0500)
> > >=20
> > > are available in the Git repository at:
> > >=20
> > >   https://source.denx.de/u-boot/custodians/u-boot-riscv.git=20
> > >=20
> > > for you to fetch changes up to 8c785ddb7ae8d675faf558c81a29938cb0ec2b=
35:
> > >=20
> > >   riscv: sifive: unmatched: migrate to text environment (2023-12-13 1=
6:19:43 +0800)
> > >=20
> > > CI result shows no issue: https://source.denx.de/u-boot/custodians/u-=
boot-riscv/-/pipelines/18889
> > > ----------------------------------------------------------------
> > > - VisionFive2: Enable CONFIG_SYSRESET
> > > - StarFive: Modify starfive timer driver
> > > - AMD/Xilinx: Add MicroBlaze V support
> > > - Unmatched: Migrate to text environment
> > > ----------------------------------------------------------------
> >=20
> > Are all of these really appropriate for a release less than a month away
> > or should I take this to -next? Thanks.
>=20
> Ah! You're right!
> I think merging to -next seems to be more appropriate!
> Thanks for the reminder!
>=20

OK. It'll be easiest then if you wait until I've merged the next -rc
in to next and rebase this PR on top of that.

--=20
Tom

--pGEXChzw5qbHBeVt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV7E5sACgkQFHw5/5Y0
tyzTZwwAoKTDRYhxGlbqzglJhP8X/CUcFScZOohAMOY/ZHpFmBmD7Q6EpZZwD2Or
Fr1dVzVd/KZ9Aw8Ij3cSfgrmSPHawQp8G5WcIYK4wT71PJM2YuALnEalcBWKFZNs
2QF+IORuuOT5x4xzI6ADgIud34ykW1lHITqOpRVJ7WTkY4MUzhSegf8Tjqn+ys3G
pb5WfL+OZ9/Z1aIiCOc8GNzTTSPYFxpmbzKlCTN4wTQ/dsoyhzBJWLk8+ZPHUDLA
WGRfb9NYJblvr8hBOrPXn3Xz9500ReQVDewj+T13NQfPtpJXG+RWSF6LO1k8kuBs
kUF+lNX2VkZb2Xa6Exc+hFjrmBZbLvcRr1hQ/3InTyQ9Xfa9dI+a5rOSBgdcFQL0
AqyV7qM1n+8n6ykY0Ghk3zDwEfoZ9yi1XFYH1mgAc2tC3GVtWF1ZYNHvCoybu3EV
4B7XI/cgDDf+CIley2Ncz6JGhJl0yd3l2zq7HAlLxmoqSyyyDcTFyWROeeIzW2cj
FffIN36U
=/89v
-----END PGP SIGNATURE-----

--pGEXChzw5qbHBeVt--
