Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F5DC61D9B
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 14:01:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C2F2875C0;
	Wed, 22 Nov 2023 15:01:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s7/Fq682";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8329D86E95; Wed, 22 Nov 2023 15:01:08 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88CE887253
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 15:01:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-daef74513e1so6203330276.2
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 06:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700661663; x=1701266463; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=h4qaXzLDmImL2J3oEd1DFAxj7cles3aXjvA78e/CEo0=;
 b=s7/Fq682P1PMGnFxjH14ID0R8m9yaqUUJBkOKFfwVoUVPzckoiyvvU8qJjdt9Jtopc
 3UWJYQO/8jr+gyQInjIT+G+7Y8en+IM3Gu/pxFXsVD+d8smVr9P4wgL8iKeVk797tqu2
 99nUIHrc1EcOaOaKzjhXmlyAw3vRvIILMJdmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700661663; x=1701266463;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4qaXzLDmImL2J3oEd1DFAxj7cles3aXjvA78e/CEo0=;
 b=GS1Y8Y1yw5EafzYbnZ/NFinwTrRZUxonkSU6VXPCD3jTVh7LwFlyl+QkcMj3uza3PP
 srrxd4XUteGaM8LE64dM8wEWSc1MuCWJ/k9eHzorM7pvsg+IYVp4s+oakRbKIAOJdJU3
 odUb/Y4Izt671tk7ir/yoCO/wuShwjIrsHH9NseiDkDQN/JZJFGlmho7L8LqxEOEilGK
 A9gTlUACnkht9ozGQJkxAKUIEkHm1GvgnYkWLC1NVLEKp7KFpaIrPs97HG0hrBLBTwKE
 ydIszN1RLrqM7q2oSx6vJZ5Rjkb4fp6U3jJW0c9uyMrLYx+hiIBRTxAYaiPEtOQyBP+/
 Jd0g==
X-Gm-Message-State: AOJu0YwwmJ2lpwxQqf1pCZ48uUSHEEssvNMJOOgdFZoiacA3qvsjx3H2
 gMun+2B1M/2i3F8xoLOdH64GiQ==
X-Google-Smtp-Source: AGHT+IGj1yFohGq3wFWQdd6uXol142+sokL0l8pdtGuCBOSb2XDGGJKc4cHBua8C94z3h899dTEmSw==
X-Received: by 2002:a25:4251:0:b0:da0:c49a:5103 with SMTP id
 p78-20020a254251000000b00da0c49a5103mr1925127yba.47.1700661663251; 
 Wed, 22 Nov 2023 06:01:03 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 o184-20020a2541c1000000b00d72176bdc5csm1387033yba.40.2023.11.22.06.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 06:01:02 -0800 (PST)
Date: Wed, 22 Nov 2023 09:01:00 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
Message-ID: <20231122140100.GT2513409@bill-the-cat>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <CAFA6WYPe8_onKNYzAVr9RHVbwUZCTiEkDizwnfL6QRsqii-JUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5ddeilKSPd8yJRW0"
Content-Disposition: inline
In-Reply-To: <CAFA6WYPe8_onKNYzAVr9RHVbwUZCTiEkDizwnfL6QRsqii-JUg@mail.gmail.com>
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


--5ddeilKSPd8yJRW0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 11:51:29AM +0530, Sumit Garg wrote:
> Hi Caleb,
>=20
> On Tue, 21 Nov 2023 at 22:39, Caleb Connolly <caleb.connolly@linaro.org> =
wrote:
[snip]
> > =3D=3D DT loading =3D=3D
> >
> > Previously, boards used the FDT blob embedded into U-Boot (via
> > OF_SEPARATE). However, most Qualcomm boards run U-Boot as a secondary
> > bootloader, so we can instead rely on the first-stage bootloader to
> > populate some useful FDT properties for us (notably the /memory node and
> > KASLR seed) and fetch the DTB that it provides. Combined with the memory
> > map changes above, this let's us entirely avoid configuring the memory
> > map explicitly.
>=20
> Since with this change, we don't need to embed FDT blob in the u-boot
> binary, so I was thinking if we really need to import DTs from Linux
> for different platforms and then play a catchup game?
>=20
> IMO, the build command would look like following if we import
> pre-built FDT blob from Linux:
>=20
> - Build u-boot::
>=20
>        $ export CROSS_COMPILE=3D<aarch64 toolchain prefix>
>        $ make qcom_defconfig
>        $ make
>=20
> - gzip u-boot::
>=20
>        gzip u-boot-nodtb.bin
>=20
> - Append dtb to gzipped u-boot::
>=20
>         cat u-boot-nodtb.bin.gz
> <linux-tree>/arch/arm64/boot/dts/qcom/your-board.dtb >
> u-boot-nodtb.bin.gz-dtb
>=20
> This would avoid the maintenance burden to keep DT in sync with that
> of Linux. And since DT bindings in Linux are backwards compatible, we
> can say u-boot should work with DTB picked up from any Linux kernel
> stable release.

I guess one question I have is, are we being passed the device tree
(since we're acting like the Linux Kernel) or knowing that we have the
dtb attached to the end of us and making use of the old kernel appended
dtb option? We're fine in for example the rpi_arm64 case of just being
given a device tree from the previous stage and not needing one in-tree.

--=20
Tom

--5ddeilKSPd8yJRW0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeCZwACgkQFHw5/5Y0
tyzBCgv/YJfd5XcdYYh6IdyjOZLyKGYsUUbjelWacQBZNKxRLVLExBwyNv6JAmol
Fm7ULfQFVxlsflUDGTQKJnUVTfoq2JfAHYvACmMLLlMb9xVMRGQsGZSgVWqo05kR
iSioqtIwh/RMOYjTLC6q0O46SzjHZu+L5/XalC3bl2EmKfilMsSLREysHjIlR4Zf
6a+YXbn2yQZmnI+/Yhr5rHoW5noh6Pm08vBMKFV5urLUkY5ClDitBBP/8Qb1gY7K
fIAVXKwyULR2mPLhTsIE6NyApi8c+bnWVIcKKrhA0CgMDXpPdJW9z9ZX+w/c1yVY
7UV0mDqYPLWBDqcXlMmNNCLVZ+LZZK9Nu8k8lPpf1/rcxDwDQw/eapqpZnxQAwFF
IWrsIuxneqLcxZ7UiMqFuyB1tIPV+ns7RiibpTTmd0Je2Yl4+fzEZHJcIOWdUsy+
4sDVv+yQvUEwoCeznFSRffhSMfoIW9SzUSLGT44zV8KBsmqS8GE+m2FJ6FeMY93Q
Dphzx22M
=Smjf
-----END PGP SIGNATURE-----

--5ddeilKSPd8yJRW0--
