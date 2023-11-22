Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16212C61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 14:28:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A1D887562;
	Wed, 22 Nov 2023 15:28:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jvr/mZdH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E75F986F42; Wed, 22 Nov 2023 15:28:07 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F661875CA
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 15:28:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5c8c26cf056so54242687b3.1
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 06:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700663281; x=1701268081; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pztlqwrdgS1Ml6iZ3nvJvgeXXZy2OYY10hyD/59ddQk=;
 b=Jvr/mZdH5jDalojpTIF3ZYHcu+F/h7EM3pmvI1paSrOMOeAQc7nYLDDiVyaEcOmleY
 A54TwquLMfpFw2deEo7lGUlzZ6DeZAFodqzvaT0eJAbLG9e5KmFs9+e6I6sworgUkEPF
 Ns98kBrShagWlAcLTA32D3krTdYe9XbbzCSDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700663281; x=1701268081;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pztlqwrdgS1Ml6iZ3nvJvgeXXZy2OYY10hyD/59ddQk=;
 b=WCDMH5SPcOz5JiOtMwEbm21BcUghzK5MnSp9Vuu28JyOOqLkjgvx9lz2jIw1jjwQqu
 pBf48fSCQN1VWbMH1yFcs820kbZp2IJqUiwVOttln777wteRhI08JVHFvRUuDmfJ3A7K
 BPRpPmTJKUBFEdD3per1UYglPrM1Oo4DriC2sEmXbxbIRI2BQawPRYK9vqCpYQW1M8jj
 KFXZsEXDWfNm3+C+QgEohYkQ2Of9dLMWyMu5qac4yawp259QEUbuDFITb/2m2NbTXrj9
 VfXgqvqtCdpO9WVhqXi71qs36Pf9lEY5ttl5uHBwprySTvq2fBlV7xc27X3lqJdNttnd
 LCYQ==
X-Gm-Message-State: AOJu0YzsBQbadJX2LTgq84yQXBVlK6QlED9KU3NDc49xSL7xuYcTVC+z
 fl2liv1BmX+zZcaLnu/axUTF2g==
X-Google-Smtp-Source: AGHT+IHe5n6Tl9MxG5FYh6PEYE6/cu3Vq2M8FoColn2/frPy890DNpB2vzZABFRMvZypUjtIT7tuMA==
X-Received: by 2002:a0d:d181:0:b0:5c9:7da2:9670 with SMTP id
 t123-20020a0dd181000000b005c97da29670mr2138270ywd.33.1700663281289; 
 Wed, 22 Nov 2023 06:28:01 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a0dfc04000000b005845e6f9b50sm3741731ywf.113.2023.11.22.06.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 06:28:00 -0800 (PST)
Date: Wed, 22 Nov 2023 09:27:58 -0500
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
Message-ID: <20231122142758.GU2513409@bill-the-cat>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <CAFA6WYPe8_onKNYzAVr9RHVbwUZCTiEkDizwnfL6QRsqii-JUg@mail.gmail.com>
 <20231122140100.GT2513409@bill-the-cat>
 <CAFA6WYNoz-Pqn38FpKLj9eJxX6B019HvQoukdCma3S=+O6tOCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LjOHRGYcC4uww1sW"
Content-Disposition: inline
In-Reply-To: <CAFA6WYNoz-Pqn38FpKLj9eJxX6B019HvQoukdCma3S=+O6tOCg@mail.gmail.com>
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


--LjOHRGYcC4uww1sW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 07:44:09PM +0530, Sumit Garg wrote:
> On Wed, 22 Nov 2023 at 19:31, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Nov 22, 2023 at 11:51:29AM +0530, Sumit Garg wrote:
> > > Hi Caleb,
> > >
> > > On Tue, 21 Nov 2023 at 22:39, Caleb Connolly <caleb.connolly@linaro.o=
rg> wrote:
> > [snip]
> > > > =3D=3D DT loading =3D=3D
> > > >
> > > > Previously, boards used the FDT blob embedded into U-Boot (via
> > > > OF_SEPARATE). However, most Qualcomm boards run U-Boot as a seconda=
ry
> > > > bootloader, so we can instead rely on the first-stage bootloader to
> > > > populate some useful FDT properties for us (notably the /memory nod=
e and
> > > > KASLR seed) and fetch the DTB that it provides. Combined with the m=
emory
> > > > map changes above, this let's us entirely avoid configuring the mem=
ory
> > > > map explicitly.
> > >
> > > Since with this change, we don't need to embed FDT blob in the u-boot
> > > binary, so I was thinking if we really need to import DTs from Linux
> > > for different platforms and then play a catchup game?
> > >
> > > IMO, the build command would look like following if we import
> > > pre-built FDT blob from Linux:
> > >
> > > - Build u-boot::
> > >
> > >        $ export CROSS_COMPILE=3D<aarch64 toolchain prefix>
> > >        $ make qcom_defconfig
> > >        $ make
> > >
> > > - gzip u-boot::
> > >
> > >        gzip u-boot-nodtb.bin
> > >
> > > - Append dtb to gzipped u-boot::
> > >
> > >         cat u-boot-nodtb.bin.gz
> > > <linux-tree>/arch/arm64/boot/dts/qcom/your-board.dtb >
> > > u-boot-nodtb.bin.gz-dtb
> > >
> > > This would avoid the maintenance burden to keep DT in sync with that
> > > of Linux. And since DT bindings in Linux are backwards compatible, we
> > > can say u-boot should work with DTB picked up from any Linux kernel
> > > stable release.
> >
> > I guess one question I have is, are we being passed the device tree
> > (since we're acting like the Linux Kernel)
>=20
> Yeah that is the case here, see patch #1 in this series regarding how
> FDT address is being retrieved from previous stage bootloader (ABL on
> sdm845 and qcs404 SoCs).

That's what I thought.

> > or knowing that we have the
> > dtb attached to the end of us and making use of the old kernel appended
> > dtb option? We're fine in for example the rpi_arm64 case of just being
> > given a device tree from the previous stage and not needing one in-tree.
>=20
> That's good to know and we can replicate that for Qcom platforms which
> are chainloaded and don't need an embedded DT.

So yes, moving these towards the direction of rpi_arm64 and specifically
using imply OF_HAS_PRIOR_STAGE or select OF_HAS_PRIOR_STAGE (force that
the dtb must be provided to us) sounds like the right direction to take
these platforms.

--=20
Tom

--LjOHRGYcC4uww1sW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeD+sACgkQFHw5/5Y0
tyyyNAv+NGPf+5779K0tmFYOtL+PhXnOhjtWyiLFbJdbENKJ/TvbWdqWs5/bk78B
v4+a503kweBrYxJ/VE3yLgsFVwy6fpPCDA6Tg7/ao85putSV+5StZ2IWxUNZnNwJ
4DfWFQWMBiiiiVBBfJV3TNTp0IS+CqaF513MCjkWHm79tRBwO6eoZp5mR/TYUGhP
vh4jBCHSxc0QZdjfQHhxnw+JxcHZnl8yuqOZ/rQkIXhu/vyC+IRneaGyFEZksCOH
a0B+d+XzhbaZHRgxnd11ZGF2PU4uuLg9vzwLubya1RfquY+n0HVE7No9jqJR1k7E
YPfcFspMLLnaYWvCyHGxxrfjNTNThqJDxNRd94k0WD5z12S+0KhDLA+Rz+nasWtm
5hodF8d73+3l43anpky5Y7sv53eBkqxiO5EHrAAjHwHRvZA6ypi9UNulOpvyN4Px
8hIkoxR4ZUaJrvQCuWowbhChLqrHRY17iElUs9Pf6nXikSdH8zKC30FhLCKXPeC6
6vL4WwL6
=67qW
-----END PGP SIGNATURE-----

--LjOHRGYcC4uww1sW--
