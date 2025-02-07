Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E10BC02199
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 15:57:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E95B801BE;
	Fri,  7 Feb 2025 16:57:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NUagLK+8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2170B80737; Fri,  7 Feb 2025 16:57:05 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9316580141
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 16:57:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b6e9db19c8so187794385a.3
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 07:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738943821; x=1739548621; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pVuTtTwOmpBQT2nybFSi/wHgjiTWigVMiPv169E3ulU=;
 b=NUagLK+8+PLuebSKhm2Ts4RN9ggb5uD5al4u/hf282U4edwTBCjTHkpd2kVcs4rTTA
 Hd5rjDtZtiYZrmCXE47ktcuOGIaNHpmt006y5pKrrpsHhYa6NSaphPfHZQfVlBgDBsb/
 c5Q2tRVO8hYYu3yYNLnDDRe9DeYPYSRr3ydEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738943821; x=1739548621;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pVuTtTwOmpBQT2nybFSi/wHgjiTWigVMiPv169E3ulU=;
 b=XEqRuVcUcbUv4SS5gjmN1k5/7MtNk62B1rro63VNyV122dsVtTXvP2ieEYO1UYE+Zl
 rwTocPs8h4Bbrdh7QDq79TL8CjG/LGJNwE2go+I3mpt+OlaSCczvhIAt0BgCIA2eumQv
 ybA0lFvJa9GoVtCeTKXh1x34yk/2eDZfYuj79+xTo6bj53T1bIBtgsJgR/U0nrLgnRh0
 cRx2/GnUxTQ2HjMLYZinYf0ty6y+scAX8i0IO/OstZzcWu7wiY8T9mlJ4LxrVU9w11/S
 e5HkW951Nek5Kc1b9TPhFjAqSSQjazc20CQ75GDBwAZVDRpmmx8ePV7VFZWwrSOoSApW
 d6KA==
X-Gm-Message-State: AOJu0YwPh7hskyjErdi0H4wGNjG0kuz91xpXcgJqdkLoFvQ5r4skcs4N
 2FXg8S90IZZENCsPOpz5kPK+vGI4SK1qIVhS8uqlRrJ6hQv+Ea+VoKIYuAj+2lGFnF3mmC7bEQu
 zNuE=
X-Gm-Gg: ASbGnctLtOJPUOgoNROF/zMwetezTXELOKQ4BlEuDIRNSL4Kk7HnrocI7cN/HSJwcxr
 5Nr2eL2JyMbWkGT202IfAIj2bAqHfVLC4VuS9bu5zEd7r7L2/Z9rvKaSF4RUVrWHLrc71z2Lio2
 K+lKt1YdPhuYcBJxNIplpCdHIDW5Qw1K3PZIKL0vKkmOwH4rYtI8CbSNxoAVG88pFJVwgd3OXkc
 EhW0n2892HaD6qfJ8yMJJT21O99T6HZwzUhtF3Igqgwdy8WVDVivPxkxQd7C5l264nj+k8FcD/j
 g5S5gbR/CFQ7Tvw=
X-Google-Smtp-Source: AGHT+IEOgDanFlkdEw1kOH2VfwqgXqp0l+2KmFFLWvr3CTmAZ6rhPLeYHZ3G2Z/MKDicO6YZEh7I6A==
X-Received: by 2002:a05:620a:448c:b0:7b6:e888:6b0e with SMTP id
 af79cd13be357-7c047bf6419mr476889185a.2.1738943821164; 
 Fri, 07 Feb 2025 07:57:01 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c041d6628bsm207688685a.0.2025.02.07.07.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 07:57:00 -0800 (PST)
Date: Fri, 7 Feb 2025 09:56:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <monstr@monstr.eu>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [GIT PULL] amd/xilinx patches for v2025.04-rc2
Message-ID: <20250207155657.GY1233568@bill-the-cat>
References: <08076b31-b5e6-4321-af5f-0d59b559e21f@monstr.eu>
 <20250206233300.GS1233568@bill-the-cat>
 <b7675cc7-a058-4340-8858-935bc24152cb@monstr.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tVO94/wkDNEUF6iZ"
Content-Disposition: inline
In-Reply-To: <b7675cc7-a058-4340-8858-935bc24152cb@monstr.eu>
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


--tVO94/wkDNEUF6iZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2025 at 07:27:43AM +0100, Michal Simek wrote:
>=20
>=20
> On 2/7/25 00:33, Tom Rini wrote:
> > On Thu, Feb 06, 2025 at 08:57:41AM +0100, Michal Simek wrote:
> >=20
> > > Hi Tom,
> > >=20
> > > please pull these patches to your tree. Nothing really significant th=
ere.
> > > Some binman fixes which were not spot before and switching our platfo=
rm to
> > > LWIP to have cover it better.
> > >=20
> > > Thanks,
> > > Michal
> > >=20
> > >=20
> > > The following changes since commit 97c125e6bb441a8062bdd28e82f17b1da1=
224416:
> > >=20
> > >    Gitlab: Add results.xml to the list of artifacts as well. (2025-02=
-04
> > > 11:57:36 -0600)
> > >=20
> > > are available in the Git repository at:
> > >=20
> > >    git@source.denx.de:u-boot/custodians/u-boot-microblaze.git
> > > tags/xilinx-for-v2025.04-rc2
> >=20
> > Please note that if change your .git/config to something like:
> > 	url =3D https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
> > 	pushurl =3D git@source.denx.de:u-boot/custodians/u-boot-microblaze.git
> >=20
> > for this remote I can then use "b4 pr" to apply these.
>=20
> done. Did you switch to it?

I'm not exclusively using b4, but it's made the "acknowledge applying
patches" part of my workflow significantly easier and copy/paste of
message-id out of patchwork isn't really more work than making a bundle
to download. I still use patchwork for other parts of my flow however
such as reviewing patches for feedback.

--=20
Tom

--tVO94/wkDNEUF6iZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmemLUkACgkQFHw5/5Y0
tyysBQv9HkAXXfAq55qGDin2R4PAI6F7pSJt7qqHMy2RBTufH2XaJStKzsH2faRW
Ov2EEv0urnvd9RYQ0Thc31n7rKAHY4L/7vJ3kwXHJe93VTGP/iH5wpafxh2Fc+UA
OTxg5wEqq2ZxoAnMuiGGfx3Ypm+0WkrmqRPvkaLykMJjEpnLBmsQiq+lHQHxa7eb
9n/AxK/VPDD/WcWUIsmQO8AWPauXyEmkJIksh9hTLYYYg6B8f+BR5dmDCX4YQFJB
+fiQS175l1SIYuupj0hnAad7hiRWITSAaF92+wQjIpYnpb0eQXyLQtgZKYjITLZ7
YG3airAYXuiZST5hGzwlHPnSdAmJGvjyRAqG9zA9+wnyIbGWDYtYXL1vQWAoIyit
hrfFjwK6AzVcGvv+HZcpobPq8hqSOINDUkXdFoe6qwbytVjTTO5wrvRgSazjnb+d
+HsT0viislTI2T/g+YYX3cWLoatD/gTlktep1hYdGvtjp+lWJ2IIjpylNdl8RnOy
00R+aM9I
=mSBB
-----END PGP SIGNATURE-----

--tVO94/wkDNEUF6iZ--
