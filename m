Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AA4C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 13:50:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95CFF82991;
	Mon,  5 May 2025 15:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="geaV/Egb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92F7E8212B; Mon,  5 May 2025 15:50:36 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1113C82958
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 15:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3fbaa18b810so1053399b6e.2
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 06:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746453033; x=1747057833; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XOiwWwzCrLzvp/lbIQvsxbUfTEa1yajTIt8MVhz+hk8=;
 b=geaV/EgbXCDZ45n37TRn6TKoVBiIrZtJtJcqy+TUqnh61GU/oKoaPBq6A6OfXomTfy
 e5R6wdvNfxIYN/AriEQ3/9w1BZ9Xhv7eqMzlGInEtUbNS8McYLpLfsXDIjl265ncxahA
 BrBOVAeRlzQno1sryYgcp2idHkxgOinZ/HvO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746453033; x=1747057833;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XOiwWwzCrLzvp/lbIQvsxbUfTEa1yajTIt8MVhz+hk8=;
 b=uOKjomkCONLMu8Bwe9L48t94RRasUx7Wo7Kfno02Z5apEBqa5XuWh146yVujcmKBUm
 zA/9/NljuhamEga0Ts0VYta1W2Vk3vG7ikLyRMv5R+Gu3S8lM4ZomyL9CkPm0Z2FjzD4
 11AZJUHoQ9aOqicewigVvMmwjgXdx58jXIr9vNUaJOPWOolLNbBSdfgUGyuYGnGLn0rJ
 w5FGmwxs0qZakzk61DrnbzpGE0CvUkMeCgyfgrUP0zRd/OGqaINMSey9VuYUmTm/93LP
 R9Aax59aFKCrC1HzILXP1Uo38/JNRXxFFNgmpOyU8BbI7sw15VvWfmBRb5btc1QybQBx
 xixA==
X-Gm-Message-State: AOJu0YyatWHDoSngfYci6tJ4TNYYRDtqsEI+2bKeDJsaHMUKbKymbVum
 vcNInGjEV9ftf2pNKAHlvzkMoiXR0izaOnKxG8W0mwiw4kXQAxhTatArov4eRv2+8NoIwGvBr8k
 gVQ0=
X-Gm-Gg: ASbGnctKUBzNJIj6GskrtImfbKbTSxhnD2EMpS0W5LR8rh4cl9GCcFVDlZ5XkNCNJPC
 IDwvgBs5xqNJzmxg1LWylZDRyWryV4ANN2dr2yDUPA+A5/NGmS5r6qOVcQ5YXFsyoyykKWd4L6V
 ue4tFgHol4657kDdihnv1NAEP/UxQMVhsYkBQ6MZgI0XagLqWHcsi58j58+//DnNxEZoNDgX89u
 2HC8vXXAt8hwXWHLHxG82EAiwuW8dNE8tOKghjVeZ64Ia83GeLups7PaqorxRe+WTmuzAbhbT14
 GIjukxNpy5S05V58tzaclRiKL5yjMyWAT05ZR+Jsmye2C2V4RUdr0vTHZWK5tHqeV3ydHKYZd9y
 ZoA==
X-Google-Smtp-Source: AGHT+IHTY6FwvjEk2QKJgCKJV4At5gjqrkEjIkNMpveHKWWZdQvo3s6QudhImAmubRyp8mjWUw3KOQ==
X-Received: by 2002:a05:6808:1824:b0:401:e921:906c with SMTP id
 5614622812f47-4035a54605dmr4522006b6e.8.1746453032775; 
 Mon, 05 May 2025 06:50:32 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4033dc66fe2sm1877844b6e.36.2025.05.05.06.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 06:50:31 -0700 (PDT)
Date: Mon, 5 May 2025 07:50:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 2/2] global: Convert almost all remaining non-DM_SERIAL
 users
Message-ID: <20250505135030.GL1261075@bill-the-cat>
References: <20250502201226.1369013-1-trini@konsulko.com>
 <20250502201226.1369013-3-trini@konsulko.com>
 <CAJaLiFy-fRjCr+bWbL8VmTjbqno6LZRB764=7mA81qz+OGOXmw@mail.gmail.com>
 <CAJaLiFyksNRAfY-Drh+hWO_XW6Zn4n=ZQo7LdNAkeRAt9RT8_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZlleV/f3e2EpAQ8X"
Content-Disposition: inline
In-Reply-To: <CAJaLiFyksNRAfY-Drh+hWO_XW6Zn4n=ZQo7LdNAkeRAt9RT8_w@mail.gmail.com>
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


--ZlleV/f3e2EpAQ8X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 04, 2025 at 03:42:24PM -0700, Tony Dinh wrote:
> On Sun, May 4, 2025 at 3:37=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wrot=
e:
> >
> > Hi Tom,
> >
> > On Fri, May 2, 2025 at 1:12=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> > >
> > > This converts almost all of the remaining non-DM_SERIAL users to enab=
le
> > > DM_SERIAL. These are platforms where there have long been other SoC
> > > boards that have switched and so it's been a matter of inertia keeping
> > > these from being converted. Do so now.
> > >
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> >
> > The Kirkwood boards (not sure about the others) also need to have
> > CONFIG_SYS_NS16550 enabled after we removed CONFIG_SYS_NS16550_SERIAL
> > and CONFIG_SYS_NS16550_REG_SIZE.
> >
> > Here was the patch:
> > https://lists.denx.de/pipermail/u-boot/2023-January/507221.html
> >
> > [PATCH] arm: kirkwood: Use CONFIG_SYS_NS16550 with DM_SERIAL for Kirkwo=
od boards
> >     arm: kirkwood: Use CONFIG_SYS_NS16550 with DM_SERIAL for Kirkwood b=
oards
> >     CONFIG_SYS_NS16550 is required when DM_SERIAL is enabled for
> > Kirkwood boards.
> >
> > diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kc=
onfig
> > index 45cc9326368..b19ed2c6b3e 100644
> > --- a/arch/arm/mach-kirkwood/Kconfig
> > +++ b/arch/arm/mach-kirkwood/Kconfig
> > @@ -15,6 +15,7 @@ config SHEEVA_88SV131
> >  config KIRKWOOD_COMMON
> >         bool
> >         select DM_SERIAL
> > +       select SYS_NS16550
> >
> >  config HAS_CUSTOM_SYS_INIT_SP_ADDR
> >          bool "Use a custom location for the initial stack pointer addr=
ess"
> >
> > So we need to either add SYS_NS16550 to each of these defconfigs
> > below, or select KIRKWOOD_COMMON for each of these boards in
> > arch/arm/mach-kirkwood/Kconfig:
> >
> > SBx81LIFKW_defconfig
> > SBx81LIFXCAT_defconfig
> > d2net_v2_defconfig
> > dns325_defconfig
> > guruplug_defconfig
> > ib62x0_defconfig
> > inetspace_v2_defconfig
> > nas220_defconfig
> > net2big_v2_defconfig
> > netspace_lite_v2_defconfig
> > netspace_max_v2_defconfig
> > netspace_mini_v2_defconfig
> > netspace_v2_defconfig

Ah OK, thanks. Can you please prepare a patch to select KIRKWOOD_COMMON
for these?

[snip]=20
> BTW, I will submit a separate patch for the DS109.

OK, great.

--=20
Tom

--ZlleV/f3e2EpAQ8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgYwiYACgkQFHw5/5Y0
tyzjmwv+O0KC4GZaWadq/ovyUlnvImCUVySZfCSge+FcqL3E8ZErc7aVQN1kbvbJ
ECMNKaTLou2GZUbmhiGXAcNQ7+QSsdf4z3TV6Zc4OLc9wolT3x3osPjIbefTHxgf
iHQ6nhqV+a9hw0U4qCGChEPv3nWPe0p94Z2wwtbOqlVZ9L0WEVrHfpbLWja94GTj
vWUAD2iV+qY81MEdG0dqy1VTmP+RsVfdocMCwWWJH6cXIwSOD8Ja9jcEVx0VphFH
FsJVIlyYX4stS4WZFEnb5PcRGGaJ2JQiX2fHhrETyg7BQc2/jxxTuCVDUD7/7XDC
ud3sasaz8YlDOeTNfp//ZU1ZPjZYN/RPMlRxsWm6SqDrCo+c+HiJcv1FWyMMjrJd
LJHQrqWuS73CsR/jNmZXySHFXTjUygNd5s6ski6i5cGP8K/1qmSi0XUfchHyMjD9
4QA87m9lpEHhcV6GaMAguE1wMoIFnaP2yW0Cv2SIYABCu4kJY0LyMtyUYcZbBKTv
Vc6LeSBX
=Hj0o
-----END PGP SIGNATURE-----

--ZlleV/f3e2EpAQ8X--
