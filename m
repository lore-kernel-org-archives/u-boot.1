Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FC1EE0ADC
	for <u-boot@archiver.kernel.org>; Sat,  7 Feb 2026 14:18:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE3E683693;
	Sat,  7 Feb 2026 15:17:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WbRMD7lp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C32C83A64; Sat,  7 Feb 2026 15:17:58 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7D6D83642
 for <u-boot@lists.denx.de>; Sat,  7 Feb 2026 15:17:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d44b2df00aso808278a34.3
 for <u-boot@lists.denx.de>; Sat, 07 Feb 2026 06:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770473874; x=1771078674; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Qmo3ia++PzKyq4vNqYkmukyKFazY/0ztksQZxBir+jc=;
 b=WbRMD7lprUDJAABIKgnPA7wbIR5b+y+0Y3aBMkXQkZDijZJcfKyQZM0ZtCB+o2+uwm
 2cmZ/Uz8sxNp8V+TBiSBf0ty2v+bl3EmQzUysr2Nyx+nR2G8R7XLQsvQ7PZn2d4D1gXF
 e1BV/6Xr1END9DtnkQ0VgOqPrLu6jjUVCkrTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770473874; x=1771078674;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qmo3ia++PzKyq4vNqYkmukyKFazY/0ztksQZxBir+jc=;
 b=vdpiPDflCbJP8KGxy00IX7Chfb5fx3C5MvZWONVtH8doQdMBkKCzHswY5aMai2ehpy
 S+j4zsE6y+MduG/OnixgmZxw6N9BZrgr0Qp19p1KI3erRvrjrE5I74dgiy/wIRPMDOQd
 91qSJiOOy7sgJwSybHFWXES+Rqs3N2RxT1GiuOlSrY0abiHRB0YB1bZHDzL7/TpH0w1c
 BEtXlGBVlpVjFVwHA1DzF3qfm3LYLdFubxtujnd7XB+eXj7S+d2xIUqKJi8UiZD8AhAY
 xckfh0XxA0CHMJfLhK35VtZXBYKRkDV7BLDF7ZbNjtO3wNNTFRtZV3qUX8ZoH69zTpzK
 cI5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl+vDdgoGRu9hd8izoUq7CpKsIXA8t7Kf14I/tR0XvXiiAFkx0hzegQRb1u/CIpvTTVO8jxZw=@lists.denx.de
X-Gm-Message-State: AOJu0Yyo2L9jHTuwFovlcdLD26SzSkf8MzjOg4G/zgwOGDXu0oFWUfG8
 oOMauaNHeo+A9xpKZdWg0BRiLfLu2C/SAj/LofcN0KIbCFa7NCcXQAMztn8rSdEBtEg=
X-Gm-Gg: AZuq6aIf9KqcWEcEWow+H6Z4cEyP3eP62Ket/aeYZEq7kA2zxHjtFERWoI4foaH9yXr
 UKo/gUBrBl2o3h11qP/OJyjQUcCps4EjSGr5FeU0Ei8Mc5zu/B+T6m/xHTdEZ8wea0/hkLWoQCW
 2n9Xbl4d2/iyTfzbFQbeiT5KFkc1vr2wb9g9DOtXiikB2QjYKQ9OOqhIAU9jw2RnRndvdapZCSW
 L4Fpem5G3BgZetdLtspmHFplUI6jjvQOWkwd/0qGJlikJNKy+rh2FlA6XVCPxiNCTEY8IpWQfGB
 xlAdUZfOrkdGxohvEiR2gK+YKaU0cO8So0e3aRUA/YkOWA3STaxKgymKhDWWMuL5thV5/JbP+aC
 v4DeiN/NhUibRfsOQZBaiLVDEXtWGHJqvCSfXoLPiOFtSLdRudVwLB7Re04YjEggfa9E5+xPKR7
 j4UoyuTQWFtWq20Ool4Yjk5e3+NcL83GcnWaHVnDZEkJaIL8rlfRNLq9muC8GbkrQxcZuy4wFNF
 eoYUMImLKWDL5Yi0aHUPoLPe7BAJOVMyJcDlSM=
X-Received: by 2002:a9d:73ca:0:b0:7cf:e3f3:437 with SMTP id
 46e09a7af769-7d46448201amr2395599a34.22.1770473874180; 
 Sat, 07 Feb 2026 06:17:54 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4646fb56dsm3970554a34.3.2026.02.07.06.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 06:17:53 -0800 (PST)
Date: Sat, 7 Feb 2026 08:17:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Ye Li <ye.li@oss.nxp.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 vigneshr@ti.com, b-padhi@ti.com, n-francis@ti.com, nm@ti.com,
 afd@ti.com, u-kumar1@ti.com, i-sihag@ti.com,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>
Subject: Re: [REGRESSION] scripts/dtc: Update to upstream version
 v1.7.2-35-g52f07dcca47c
Message-ID: <20260207141750.GB2603314@bill-the-cat>
References: <20251202193310.149861-1-marek.vasut+renesas@mailbox.org>
 <DFJ950O0QM0D.380U0N16ZO19E@ti.com>
 <DFJ9947VLHEL.PCDIJCRU24BS@ti.com>
 <20260108141233.GQ3416603@bill-the-cat>
 <939a9696-27fa-45a1-b428-feffe21ac6d5@oss.nxp.com>
 <20260206142821.GS2603314@bill-the-cat>
 <8da74e3b-4b71-46a2-8a60-7d75705f35cb@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5hMe/90Pzzg+juM8"
Content-Disposition: inline
In-Reply-To: <8da74e3b-4b71-46a2-8a60-7d75705f35cb@oss.nxp.com>
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


--5hMe/90Pzzg+juM8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 07, 2026 at 12:24:30PM +0800, Ye Li wrote:
>=20
>=20
> On 2/6/2026 10:28 PM, Tom Rini wrote:
> > On Fri, Feb 06, 2026 at 05:11:20PM +0800, Ye Li wrote:
> > > Hi Tom, Marek,
> > >=20
> > > On 1/8/2026 10:12 PM, Tom Rini wrote:
> > > > On Thu, Jan 08, 2026 at 07:21:10PM +0530, Anshul Dalal wrote:
> > > > > CC+: TI folks
> > > > >=20
> > > > > On Thu Jan 8, 2026 at 7:15 PM IST, Anshul Dalal wrote:
> > > > > > Hi all,
> > > > > >=20
> > > > > > On Wed Dec 3, 2025 at 1:02 AM IST, Marek Vasut wrote:
> > > > > > > Synchronize local copy of DTC with Linux 6.17 . This includes=
 the
> > > > > > > following picked and squashed commits from Linux kernel. The =
squash
> > > > > > > was necessary, since the DTC here contains changes which were=
 also
> > > > > > > part of DTC in Linux alraedy, and the squash helped resolve t=
hose
> > > > > > > without going back and forth with the changes.
> > > > > > >=20
> > > > > > > The following commits from Linux are picked:
> > > > > > >=20
> > > > > > > 8f324cd712df7 # scripts/dtc: consolidate include path options=
 in Makefile
> > > > > > > b5b3d9b63b0ee # scripts/dtc: Add yamltree.c to dtc sources
> > > > > > > 7d97a76f226d6 # scripts/dtc: Update to upstream version v1.4.=
7-14-gc86da84d30e4
> > > > > > > ea6f243be74e5 # scripts/dtc: Update to upstream version v1.4.=
7-57-gf267e674d145
> > > > > > > 02d435d4eccd8 # scripts/dtc: Update to upstream version v1.5.=
0-23-g87963ee20693
> > > > > > > 6e321b7637396 # scripts/dtc: Update to upstream version v1.5.=
0-30-g702c1b6c0e73
> > > > > > > 9f19ec91a7a35 # scripts/dtc: dtx_diff - add color output supp=
ort
> > > > > > > 8287d642f38d1 # scripts/dtc: Update to upstream version v1.5.=
1-22-gc40aeb60b47a
> > > > > > > 4c52deef9225d # scripts/dtc: Revert "yamltree: Ensure consist=
ent bracketing of properties with phandles"
> > > > > > > 5d3827e1452ed # scripts/dtc: Remove unused makefile fragments
> > > > > > > 40dd266887654 # scripts/dtc: Update to upstream version v1.6.=
0-2-g87a656ae5ff9
> > > > > > > 8d4cf6b6acb59 # scripts/dtc: use pkg-config to include <yaml.=
h> in non-standard path
> > > > > > > b9bf9ace5ae90 # scripts/dtc: Update to upstream version v1.6.=
0-11-g9d7888cbf19c
> > > > > > > 69a883b6f5ac0 # scripts/dtc: dtx_diff - make help text format=
ting consistent
> > > > > > > 8f829108b8aed # scripts/dtc: only append to HOST_EXTRACFLAGS =
instead of overwriting
> > > > > > > b39b4342ac495 # scripts/dtc: Update to upstream version v1.6.=
0-31-gcbca977ea121
> > > > > > > 93c6424c486b3 # scripts: dtc: Fetch fdtoverlay.c from externa=
l DTC project
> > > > > > > 0dd574a1d75c3 # scripts/dtc: Update to upstream version v1.6.=
0-51-g183df9e9c2b9
> > > > > > > ec38b5df8a231 # scripts: dtc: Build fdtoverlay tool
> > > > > > > a0c8c431411f5 # scripts: dtc: Remove the unused fdtdump.c file
> > > > > > > e7dc653d4e890 # scripts/dtc: Add missing fdtoverlay to gitign=
ore
> > > > > > > d2bf5d2e3f09c # scripts/dtc: Update to upstream version v1.6.=
1-19-g0a3a9d3449c8
> > > > > > > a60878f5532d0 # scripts/dtc: dtx_diff: remove broken example =
=66rom help text
> > > > > > > 8b739d8658a9b # scripts/dtc: Call pkg-config POSIXly correct
> > > > > > > b6eeafa67df00 # scripts/dtc: Update to upstream version v1.6.=
1-63-g55778a03df61
> > > > > > > f96cc4c787588 # scripts/dtc: Update to upstream version v1.6.=
1-66-gabbd523bae6e
> > > > > > > 09ab9c092ef2b # scripts/dtc: Update to upstream version v1.7.=
0-93-g1df7b047fe43
> > > > > > > ded8a5a498f2d # scripts/dtc: Update to upstream version v1.7.=
0-95-gbcd02b523429
> > > > > > > ee6ff6fca7e71 # scripts/dtc: Update to upstream version v1.7.=
2-35-g52f07dcca47c
> > > > > > >=20
> > > > > > > This also includes forward port of U-Boot commit
> > > > > > > e8c2d25845c7 ("libfdt: Revert 6dcb8ba4 from upstream libfdt")
> > > > > > > to avoid binary size growth.
> > > > > > >=20
> > > > > > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > > > > > ---
> > > > > > > Cc: Adriano Cordova <adrianox@gmail.com>
> > > > > > > Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
> > > > > > > Cc: Christian Marangi <ansuelsmth@gmail.com>
> > > > > > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > > > > > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > > > Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> > > > > > > Cc: Sam Edwards <cfsworks@gmail.com>
> > > > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > > > Cc: u-boot@lists.denx.de
> > > > > >=20
> > > > > > We observed several boot failures on K3 platforms since the add=
ition of
> > > > > > this patch at the R5 SPL stage, the issue seems to be the newly=
 added
> > > > > > check for alignment in fdt_check_header in scripts/dtc/libfdt/f=
dt.c:95
> > > > > > but the binaries generated don't have 8-byte aligned FDTs.
> > > > > >=20
> > > > > > I have been able to reproduce the issue on AM62p EVM with a cle=
an
> > > > > > working directory (this is important since any minor change to =
the
> > > > > > SPL binary size such as by the added "-dirty" tag could make th=
e address
> > > > > > aligned) and GCC 13.3[1].
> > > > > >=20
> > > > > > Are we ensuring the fdt present in the SPL binary is properly a=
ligned?
> > > >=20
> > > > Yes, the device tree must be 8-byte aligned, this is a requirement =
of
> > > > the device tree spec itself that we had been lax over until now.
> > > We found iMX95/iMX94 EVK boards are broken after this fdt lib update.=
 The
> > > root cause is default value of CONFIG_SPL_OF_LIBFDT_ASSUME_MASK is 0x=
ff. In
> > > this update, fdt_check_node_offset_ is changed as below to check the
> > > CONFIG_SPL_OF_LIBFDT_ASSUME_MASK. When it is 0xff, fdt_check_node_off=
set_
> > > will skip offset check.
> > >=20
> > >=20
> > >   int fdt_check_node_offset_(const void *fdt, int offset)
> > >   {
> > > -	if ((offset < 0) || (offset % FDT_TAGSIZE)
> > > -	    || (fdt_next_tag(fdt, offset, &offset) !=3D FDT_BEGIN_NODE))
> > > +	if (!can_assume(VALID_INPUT)
> > > +	    && ((offset < 0) || (offset % FDT_TAGSIZE)))
> > > +		return -FDT_ERR_BADOFFSET;
> > > +
> > > +	if (fdt_next_tag(fdt, offset, &offset) !=3D FDT_BEGIN_NODE)
> > >   		return -FDT_ERR_BADOFFSET;
> > >=20
> > > This cause a problem to SCMI agent uclass driver. In scmi_bind_protoc=
ols
> > > function, a ofnode_null() is used when creating scmi-base.0 device to=
 bind
> > > with driver. This null node which has offset value -1 can successfull=
y pass
> > > the fdt_check_node_offset_, so causes crash in
> > > device_probe()->dev_power_domain_on() when finding power-domains phan=
dle.
> >=20
> > Thanks for the analysis.
> >=20
> > > I notice the default value of CONFIG_OF_LIBFDT_ASSUME_MASK used by u-=
boot is
> > > 0. So why does SPL have different default value? Should we change the=
 SPL
> > > default value to 0 to align with u-boot? Otherwise, any idea for fix.
> >=20
> > In SPL we must assume a perfect device tree has been passed to us, both
> > for design reasons (it's not a user interactively, we built it, or it
> > came from some other firmware stack) as well as practical (performing
> > the sanity tests would grow all platforms by several kilobytes and
> > overflow size constraints). I think the SCMI code needs to be reworked,
> > in short.
> >=20
> Thanks for explanation. It is reasonable to have 0xff as default for SPL.
> For SCMI, because its base protocol(0x10) is mandatory, there is no dts n=
ode
> for this protocol. So SCMI agent uclass driver dynamically creates a devi=
ce
> for base protocol with null node. See commit (7eb4eb541c1 firmware: scmi:
> install base protocol to SCMI agent). This implementation seems also prop=
er.
> Do you think if we should set CONFIG_SPL_OF_LIBFDT_ASSUME_MASK to 0 when
> SCMI is used?

It's also a massive hit on boot time and I know that will be a
regression on some SCMI using platforms. So no, we need to figure out
hwo to rework the code.

--=20
Tom

--5hMe/90Pzzg+juM8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYdJiQAKCRAr4qD1Cr/k
CgFyAQDPZf9u/KApXwAilrW7pSWGJ42rQykO14WxITpnzaRdlwEAsX4qCz2UWvtq
SbAo6Vs2vo0NrrAS+Zh93jrQGYHWJwo=
=YAXz
-----END PGP SIGNATURE-----

--5hMe/90Pzzg+juM8--
