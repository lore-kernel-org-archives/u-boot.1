Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B77C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 15:15:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFBDF87E13;
	Mon, 11 Mar 2024 16:15:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OuawAKXU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97B2987DD5; Mon, 11 Mar 2024 16:15:21 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E544887E13
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 16:15:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-788598094c4so114576685a.0
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 08:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710170117; x=1710774917; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UzEzQf9Mqe9kYQK6FN1wgphRCx/Pb+GJYr6DbfGm3ng=;
 b=OuawAKXU1aAJTRbMwZOdEQEEWdQwg5HKmc8T0FfTaJ7yOYkaeDP3/pYbutoWH3gztK
 hsgVJUBH09qfppfOgUygyG55XPvbUned16ng6hZ8zLOHpq91Cgf9VHvPkT0WRCBa+CVa
 OHPicFTtGqNou2TZCoODUMB8cxo3rSwNmVgUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710170118; x=1710774918;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UzEzQf9Mqe9kYQK6FN1wgphRCx/Pb+GJYr6DbfGm3ng=;
 b=AWEO5dKaW4JgUm3EZHRW3LAGiuyVfdAiwwqFpEgEh75+iTfc5/KkFPee3HemcnYyOF
 Su/9Vm0BpfAcJtCR1QDvO8mQ/ftOIcBWRgXPewYuPvt03qGK3CXtrO0lsxm5AjrNDUAX
 Zwlt68dFVKRhP6iI8dKp45QYLrBKdl2V3AWye+wBOVefKa0Cz1YB8iWa5qTr8oqv/HJa
 11xVPV2PYAkmFnB6AtlEaV1koYI2vVLylfYF4b1sRkNV/pxuzbGw1tnC74rS+FZJu42O
 ieYeqGCPWIMUPPTZhA/TKSWfwiJ2N0KsFm2+JgL1V18jvfuYgmlgUwYeiLUWwdKuQ1hC
 L+7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5h0eTOhVAOuFMA0xRyAPDI1HxQuwqKEGvQHdUKok1gX/voqzJA7IiUT6YhetL73BITRhEillK5873Qn+OLcqDsThHgg==
X-Gm-Message-State: AOJu0Yx29rsKwKPVv8xZN1xkg0h2mr9qj/Mqgb2Tyh3Ms1bHzRVfI8+F
 Gs1dCajed64UerSGqr8MKDiFLSTK/+wksHNsjJ+HhTzpVGOPjDfEEk6S9g6cW/yhdP8evbbCbP/
 b
X-Google-Smtp-Source: AGHT+IFXwq2lZDDOOa4GOzCPHQDiMV1abiW+W+nwx8M/9B+PvBuisHzavvj5GL+z7ZYZC35MMvy1eQ==
X-Received: by 2002:a05:620a:a82:b0:788:5b6d:eabe with SMTP id
 v2-20020a05620a0a8200b007885b6deabemr827155qkg.42.1710170117708; 
 Mon, 11 Mar 2024 08:15:17 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 y9-20020ae9f409000000b007885e3275e9sm2580323qkl.132.2024.03.11.08.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 08:15:17 -0700 (PDT)
Date: Mon, 11 Mar 2024 11:15:15 -0400
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Love Kumar <love.kumar@amd.com>,
 Angelo Dureghello <angelo@kernel-space.org>, u-boot@lists.denx.de,
 git@xilinx.com, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v3] test/py: reset: Add a test for reset command
Message-ID: <20240311151515.GZ1523872@bill-the-cat>
References: <20240307001053.GE1523872@bill-the-cat>
 <c05a25ca-d4b7-1179-cf46-645bc4cdba89@kernel-space.org>
 <c0bbe63d-adee-456f-bcf8-44579aa2593a@amd.com>
 <20240307125525.GF1523872@bill-the-cat>
 <553992bb-c159-d9b9-6e9d-b762ea55da79@kernel-space.org>
 <cf96e2a6-9e49-4058-8bfc-f31b3d028190@amd.com>
 <20240311143938.GV1523872@bill-the-cat>
 <9e3f916a-7e5b-4ec8-abe4-c2cead1df557@amd.com>
 <20240311150908.GX1523872@bill-the-cat>
 <3c44793c-a557-40e5-b367-15619e9d03f2@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xdnZkpGHVhNzUEAM"
Content-Disposition: inline
In-Reply-To: <3c44793c-a557-40e5-b367-15619e9d03f2@amd.com>
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


--xdnZkpGHVhNzUEAM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 04:14:04PM +0100, Michal Simek wrote:
>=20
>=20
> On 3/11/24 16:09, Tom Rini wrote:
> > On Mon, Mar 11, 2024 at 03:52:57PM +0100, Michal Simek wrote:
> > >=20
> > >=20
> > > On 3/11/24 15:39, Tom Rini wrote:
> > > > On Mon, Mar 11, 2024 at 02:40:59PM +0530, Love Kumar wrote:
> > > > > Hi,
> > > > >=20
> > > > > On 11/03/24 2:11 pm, Angelo Dureghello wrote:
> > > > > > Hi,
> > > > > >=20
> > > > > > jfyi,
> > > > > >=20
> > > > > > reset support added in qemu
> > > > > > merged as commit d3c79c3974.
> > > > > >=20
> > > > > > Regards,
> > > > > > angelo
> > > > > >=20
> > > > > The other issue was with echo commands:
> > > > > =3D> echo $modeboot
> > > > > $modeboot
> > > > >=20
> > > > > =3D> echo $?
> > > > > $?
> > > > >=20
> > > > > Does HUSH shell is enabled by default for this?
> > > >=20
> > > > It is not, so at least the saveenv test needs to depend on HUSH_PAR=
SER
> > > > too.
> > >=20
> > > Based on logs on this platform echo $? doesn't return any value.
> > > There is any config for it which is not enabled for this platform.
> > > Do you know which Kconfig symbol it is?
> > >=20
> > > Depending on HUSH is likely big hammer but I was not able to find tha=
t exact
> > > Kconfig symbol just for $?
> >=20
> > Well, if we don't have the hush parser we have a much more limited
> > parser enabled and I bet that's why (I think there's no variable
> > expansion).
>=20
> ok. Then this test should be limited to HUSH too based on how it is writt=
en.
> I think it should be okish limitation and if someone wants to test it on
> systems without HUSH enabled it should just update it. If is fine for you?

Yup, sounds good. And I'll take the next iteration of this test patch
when I also grab the patch I posted to cherry-pick the missing reset
functionality in our QEMU.

--=20
Tom

--xdnZkpGHVhNzUEAM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXvIAMACgkQFHw5/5Y0
tyzI9wv/UIE0rCsts5tQIOadC4vefakY+vM2qgcPAhcXWwlXtKOPNupCADPpKlDZ
ML5gp6o3fsQgIMWCKLQHjFKNmP1mI4SU7EqW9jLJfuj2dANvXqGnfyVTdZu7xa/S
hsJTYptA6PTPvxDf1xnIpFRD34FPf4iT2zE34GTFOMTP+WRsK0X2844fnYZ/zwkP
qPy+t23u0aa7UakupiNG1oowURVzUkxEOf8vIBvnE9mNJGEeuL8EKDCdwNxd6/AO
XUBuMEbLeIJ1n47PnsYjGoUx44uLwL6xrw8mMt1A1ctmRJ69gkBzmPmTVQi+dpwQ
Q1xf+EkDvEc2Hpuk9p1A46LSFz9b/rR4kyu03124Uzf1oWtLOyYC/dnTUl1/z0D1
s/X2ZP4+W0WB85AOYegRiSZPwugmG1eCloRn0Hqs39V0od1tcWD8OLtbixrSFdXU
zVul3NHf2PkA2YLxKTK07RnE2pJWtyUJFzijn38MR6p/U6dSJqXSaniK3IH3R2uS
842Q9mGA
=hDyM
-----END PGP SIGNATURE-----

--xdnZkpGHVhNzUEAM--
