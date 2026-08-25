Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92118C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 23:03:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77C9860712;
	Tue, 25 Aug 2026 23:03:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U2p_FguQJ3ew; Tue, 25 Aug 2026 23:03:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787698985;
	bh=4uuh23QBhGC3s8+5twgD6K/ugRiBvidz7IiSnTSt4K0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nNmIXJLls2aD3CPs57NNZSNEItwh0T6o/ENeC9hUcFOdDfvA786H4kSikxC4/A0Hp
	 rPVl4HhI47Luo60Yn0cJ3HQwxnQIlmnqCwadUOyzKDS7Cex2atHHK3kFESS9Ixx2XL
	 Db8XZlrshzGYOKQbgCXEGRjrDWtUjOZX8I3cC1Oo2M/JEJY/x1KlcLtAZC1bkfgqux
	 RjgRAwVEu7wKc670wkFWXP+AkyEJ3ht42a8E10R9lFiVBIBYaAoNGKQoNGR7zehfZz
	 C4PTrosuMTcSaBUI1aerjh2GLPeH/lu6SRaEr+sghUtuRYCwNya48RkF7xsZYLUUdL
	 ytW9EGWm5d/9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C3C7606F6;
	Tue, 25 Aug 2026 23:03:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A1B43C3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 23:03:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 57B4440055
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 23:03:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yy-n8eQAqdOt for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 23:03:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::231; helo=mail-oi1-x231.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=UuopXmHj
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8BB734000B
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 23:03:02 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4a43c2a126fso231200b6e.3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787698981; x=1788303781;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4uuh23QBhGC3s8+5twgD6K/ugRiBvidz7IiSnTSt4K0=;
 b=UuopXmHj5CAgthsBJNjveVlgeYcmjxZXFl9AfHm3+QDSAhvsU6w3iLF1/8CGR/MEAf
 rtAiiyeiNmR5hOdestVdbKpcXs8U8UIpHQzacJjeQMBzNRErONEjOYjNlqIqYHaK+UOU
 +F33DW2qMPX0Frw+qKIMfRfcsP/VG04tMqbRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787698981; x=1788303781;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4uuh23QBhGC3s8+5twgD6K/ugRiBvidz7IiSnTSt4K0=;
 b=n4E34gmf/y5Rrxzt9SxchgMeRkSXK4BvQ88q5NUwjQpZV/oze/L3ntpWh0A5fUjHjx
 S5Kqmq2VjcwgQHmOn6ZKAf4Dh2lAYawf+jvyH7OUQ73hTIiy0a9VKoECkXbAFhsM4AbE
 uufLkefzt/fvfB24sW1+Ihy80o9PrVig+scApYE+ILlgixdKm08rOPRXR4HhzCWADsBo
 6QNGZtVgIFeCY6pFgEZpW9TdEReb0LpGarwWvgFefg/6OvAKdGxBmOpddgOd1sBcIspU
 8t8tA1M2rWdNxcj/5iS+L7Oplm6hbcTOtqkfZvh1SMq6rby7vBR8yHmJKmm98oY2Bi56
 cJrA==
X-Gm-Message-State: AFuF++lzPFFKNc2smH4jvm1AmFdpDB9Yf+R7362dlH4l/p/dcp69oDZ9
 7GXF2IgIQv2nhLv5AjphumcYrcFloF1EX0dtbq7vssv3b7ri2sk5M8u+sQAM7e5sE3QEJlKw8+Z
 m8YXWhGwKecVy
X-Gm-Gg: AR+sD13IfZQiu8qJfBVKnGe3dmiQ9LYpVgAGoKXPPOe485HyU8BlfwcFpw70+EgqM4f
 CfKOHsNJP5tYwQPVO8j8AjbNPkxayZw37ahx/2rtpQjDNdk4melp0AcufWkV8k2HSDEOErZmux5
 qWSvqOI0J2TiovqTOETZ9Jfo7FUzgFaBuGzaDbj8DdldoigkU3VeeD/q8Y0cOVM15LPUrwYce1s
 a86jhFotekF56Nl1c1RAA6BwlVsad0VePPyG3BKOUNerfTAPcqtbT9G8uQzfv/46x2q6vcBiPvp
 klpyy9iQTI3AqJ64GdTh/lhd6f7cKZiRdWd2WV07S5d2hsFJN6lpgIm2siSy8rSIYe40uE3dCQw
 0zta/Go2kBqNwkJ97+5T0kY8WnpoNQo1j1o7l6tuYbiu8lP4Pkq/6iPwPIVtN4UYGrURowivjYO
 UFj8Tk1D5wU/U9ORaume9xyVN2fvTeZ6uOQwFsfhwN+u1/a6S4bOmXPdrkpIhQ8wHoXlHXjPKOo
 e7pbEIl79j8x8sm01Fw2l3hcVOirrseYkn/8/dT9zE1F7fTDOxOj7tJZqPBGO2vzjAEuzUUl1Om
 puNJWoby5wnMPdPAgXLP
X-Received: by 2002:a05:6808:1b21:b0:490:b586:1459 with SMTP id
 5614622812f47-4b3668888d1mr3119244b6e.2.1787698981176; 
 Tue, 25 Aug 2026 16:03:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b36ab73bfdsm213514b6e.16.2026.08.25.16.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 16:03:00 -0700 (PDT)
Date: Tue, 25 Aug 2026 17:02:57 -0600
From: Tom Rini <trini@konsulko.com>
To: AK Sharma <maskachoska@yahoo.com>
Cc: u-boot@lists.u-boot-project.org, Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v1 00/12] mips: add EcoNet/Airoha EN75xx (EN7512/EN7528)
 SoC support
Message-ID: <20260825230257.GI523975@bill-the-cat>
References: <20260825224330.713151-1-maskachoska.ref@yahoo.com>
 <20260825224330.713151-1-maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XH2hLZ7wS+fHPcCD"
Content-Disposition: inline
In-Reply-To: <20260825224330.713151-1-maskachoska@yahoo.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--XH2hLZ7wS+fHPcCD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 04:11:55AM +0530, AK Sharma wrote:

> This series adds U-Boot support for the EcoNet/Airoha EN75xx MIPS SoC
> family: the big-endian MIPS34Kc EN7512/EN7521 and the little-endian
> MIPS1004Kc EN7528, used in many GPON/XPON ONT home gateways. It extends
> the existing Airoha SNFI SPI-NAND and GDM Ethernet drivers.
>=20
> It brings up the SoC (TPL/SPL, cache/CM init), and adds the UART, the
> EN75 BMT SPI-NAND bad-block mapping, weak bootm decompression hooks for
> the coherent CM, and Ethernet. Reference boards for the EN7512 and EN7528
> are included, plus the EN7528 R3-hook boot variant.
>=20
> The DDR calibration stage is a vendor artifact and is not shipped
> in-tree. The reference board packages it as a binman "blob-ext"; build
> those configs with BINMAN_ALLOW_MISSING=3D1 and supply the blob to run
> (see arch/mips/mach-en75xx/README.ddr-blob). A native DDR-init
> implementation is a known TODO.
>=20
> Tested on a Nokia G-2425G-A (EN7528, MT29F2G01 SPI-NAND): boots to the
> prompt with correct 256 MiB DRAM, working Ethernet/TFTP and SPI-NAND.

I am glad to see this effort. I am, after reviewing a few of the
patches, worried that this is still too much of a vendor port rather
than re-working the vendor port to match upstream best practices.
Perhaps one thing that would help is to keep in mind what the minimum
set of additions required are, to get a good amount of functionality.
And then follow-up patches once the core is in. Thanks.

--=20
Tom

--XH2hLZ7wS+fHPcCD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao4fIQAKCRAr4qD1Cr/k
CjjMAQDETqw63xt1P3KuN6NuLYeEw039XZKLkKzQs8Do2VC3AQD+JcsZOM8+hvp7
sJJJ1FDr+Ekkao2LqslOIgxC/xsx4As=
=M7iz
-----END PGP SIGNATURE-----

--XH2hLZ7wS+fHPcCD--
