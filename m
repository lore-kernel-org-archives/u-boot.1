Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B6CEE20A6
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 14:28:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BC1A838FA;
	Fri,  6 Feb 2026 15:28:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OmtELN/Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6EA083A64; Fri,  6 Feb 2026 15:28:28 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77492836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 15:28:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d1872504cbso1764856a34.0
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 06:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770388105; x=1770992905; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zbXxBT8QIVCQ2HHKX0tUU9jUg46JqZmohfWtFMADM68=;
 b=OmtELN/Q4bGzH2mLu+aoH7sUsNjJwb6JQjKH2eG2IwLJ1KpmyJJ05T30/tVEMpnCuz
 nywzSq6ubTRkcFlXiJHBnqvwgE/xiSTKpUUyCY+48Ln8Tg9zExH4ds3RfuVDHI65My9y
 w0S4PzR2EGMFuzYwbSYg9Rj3hjzuFkn6hGSOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770388105; x=1770992905;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zbXxBT8QIVCQ2HHKX0tUU9jUg46JqZmohfWtFMADM68=;
 b=GDLr8U5zjVrFkdHPCcv10kY0MnvS2cXmL8O02u3hYiPsT7SDXnQ+kL4zxrGBCHDK4j
 q99Eft0BPiNmaAiKLYA0VsIrUuLxPVL76qX0RW4slTlpnG0fXIkHJn3XcBWn6idsVsnD
 HeqwC6xsuPukIlHBbBX6aJ/W+hJylWhYOWDemeFODFbU4GyLfuOZOvNs2Fz6xffKz6ja
 Eom+9RMDeea5KLQEZLhRMu6brggCyV0zgyRkz/OpVbRmAVLCtF9TtYhhTpWtZgesdc8H
 wV8c8PjDtz/5fpL3+rgqi0spiFFum15jAVLNmhbd/PLA1PfZFWP40etpjjUN7+5kGfBo
 YZwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo3wuLdVQYgJZWV1oVB/1UCWGX0X9qeKVpZLU4aWMgK/+I6yKF6Ye7ANNzrjlQq2DJjFxdBFI=@lists.denx.de
X-Gm-Message-State: AOJu0YzZX81BFx7qqUjmlXtieiUmn7/Ve3iIEHBrbtGioLBaHqvJQKnT
 CyZj9WYopQHvb5MR6I9mN4P+KpNMgtKS7nJV9N7PCUBAD1qAUVCIb0dLSsWM1WWDjJ4=
X-Gm-Gg: AZuq6aJXptHMaWpma+2WwcFCVIjy8qa4HKM//8YATKpdw84ewnSlmKIOjnhyCGDeZo+
 CgA6+bDU6MjJlbXcd0+oQESeNvmo2EUR/zOqJZ+tWpKdE4SH89ftKKkjlX1NYUK/tI5r2xVX4fb
 yqHqUXzJisHEUpw9UnKH8pH28eFfZia1/ek6vV/QmTP7iPqH0KzvWojEGjgO/GR0IjF4ZQKEAiW
 4x7VBTbR0masltU8EXDHyWrLjFg0ds5Av4npX9lzj2pMlafCJm02gJr7s8AA1pe2HpeFV6hzZoJ
 gCxjzeKCzpB5sMFhOEpmh73U2E/pnhgyO2rK1dqTjUj72nOwyPAZv71aUdzeCS5DRGZ9uQoIaig
 CUo63xYwlBOFsMO/osI422lWfhur0jPUjj3+ZUOM5y51jtuUL8Hfx9eLbQaRLcC4CZ2ZpEhdTmj
 pyrLZy/cta7x+n4yb9qzWSrhMlsXZcJvnkIkt5GturWy0OZzU+WD9T8a0G+fBfi0t9CCZ+NGf3k
 jm25QMP2m8QIV6j4Y9/ZtgVLzhp41aaZ0p4YuM=
X-Received: by 2002:a05:6830:2b10:b0:7d1:86cd:5de3 with SMTP id
 46e09a7af769-7d4633f8fbbmr1628734a34.14.1770388104556; 
 Fri, 06 Feb 2026 06:28:24 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d46470df08sm1778257a34.8.2026.02.06.06.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 06:28:23 -0800 (PST)
Date: Fri, 6 Feb 2026 08:28:21 -0600
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
Message-ID: <20260206142821.GS2603314@bill-the-cat>
References: <20251202193310.149861-1-marek.vasut+renesas@mailbox.org>
 <DFJ950O0QM0D.380U0N16ZO19E@ti.com>
 <DFJ9947VLHEL.PCDIJCRU24BS@ti.com>
 <20260108141233.GQ3416603@bill-the-cat>
 <939a9696-27fa-45a1-b428-feffe21ac6d5@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I4jnuG7v51M1YlV0"
Content-Disposition: inline
In-Reply-To: <939a9696-27fa-45a1-b428-feffe21ac6d5@oss.nxp.com>
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


--I4jnuG7v51M1YlV0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 06, 2026 at 05:11:20PM +0800, Ye Li wrote:
> Hi Tom, Marek,
>=20
> On 1/8/2026 10:12 PM, Tom Rini wrote:
> > On Thu, Jan 08, 2026 at 07:21:10PM +0530, Anshul Dalal wrote:
> > > CC+: TI folks
> > >=20
> > > On Thu Jan 8, 2026 at 7:15 PM IST, Anshul Dalal wrote:
> > > > Hi all,
> > > >=20
> > > > On Wed Dec 3, 2025 at 1:02 AM IST, Marek Vasut wrote:
> > > > > Synchronize local copy of DTC with Linux 6.17 . This includes the
> > > > > following picked and squashed commits from Linux kernel. The squa=
sh
> > > > > was necessary, since the DTC here contains changes which were also
> > > > > part of DTC in Linux alraedy, and the squash helped resolve those
> > > > > without going back and forth with the changes.
> > > > >=20
> > > > > The following commits from Linux are picked:
> > > > >=20
> > > > > 8f324cd712df7 # scripts/dtc: consolidate include path options in =
Makefile
> > > > > b5b3d9b63b0ee # scripts/dtc: Add yamltree.c to dtc sources
> > > > > 7d97a76f226d6 # scripts/dtc: Update to upstream version v1.4.7-14=
-gc86da84d30e4
> > > > > ea6f243be74e5 # scripts/dtc: Update to upstream version v1.4.7-57=
-gf267e674d145
> > > > > 02d435d4eccd8 # scripts/dtc: Update to upstream version v1.5.0-23=
-g87963ee20693
> > > > > 6e321b7637396 # scripts/dtc: Update to upstream version v1.5.0-30=
-g702c1b6c0e73
> > > > > 9f19ec91a7a35 # scripts/dtc: dtx_diff - add color output support
> > > > > 8287d642f38d1 # scripts/dtc: Update to upstream version v1.5.1-22=
-gc40aeb60b47a
> > > > > 4c52deef9225d # scripts/dtc: Revert "yamltree: Ensure consistent =
bracketing of properties with phandles"
> > > > > 5d3827e1452ed # scripts/dtc: Remove unused makefile fragments
> > > > > 40dd266887654 # scripts/dtc: Update to upstream version v1.6.0-2-=
g87a656ae5ff9
> > > > > 8d4cf6b6acb59 # scripts/dtc: use pkg-config to include <yaml.h> i=
n non-standard path
> > > > > b9bf9ace5ae90 # scripts/dtc: Update to upstream version v1.6.0-11=
-g9d7888cbf19c
> > > > > 69a883b6f5ac0 # scripts/dtc: dtx_diff - make help text formatting=
 consistent
> > > > > 8f829108b8aed # scripts/dtc: only append to HOST_EXTRACFLAGS inst=
ead of overwriting
> > > > > b39b4342ac495 # scripts/dtc: Update to upstream version v1.6.0-31=
-gcbca977ea121
> > > > > 93c6424c486b3 # scripts: dtc: Fetch fdtoverlay.c from external DT=
C project
> > > > > 0dd574a1d75c3 # scripts/dtc: Update to upstream version v1.6.0-51=
-g183df9e9c2b9
> > > > > ec38b5df8a231 # scripts: dtc: Build fdtoverlay tool
> > > > > a0c8c431411f5 # scripts: dtc: Remove the unused fdtdump.c file
> > > > > e7dc653d4e890 # scripts/dtc: Add missing fdtoverlay to gitignore
> > > > > d2bf5d2e3f09c # scripts/dtc: Update to upstream version v1.6.1-19=
-g0a3a9d3449c8
> > > > > a60878f5532d0 # scripts/dtc: dtx_diff: remove broken example from=
 help text
> > > > > 8b739d8658a9b # scripts/dtc: Call pkg-config POSIXly correct
> > > > > b6eeafa67df00 # scripts/dtc: Update to upstream version v1.6.1-63=
-g55778a03df61
> > > > > f96cc4c787588 # scripts/dtc: Update to upstream version v1.6.1-66=
-gabbd523bae6e
> > > > > 09ab9c092ef2b # scripts/dtc: Update to upstream version v1.7.0-93=
-g1df7b047fe43
> > > > > ded8a5a498f2d # scripts/dtc: Update to upstream version v1.7.0-95=
-gbcd02b523429
> > > > > ee6ff6fca7e71 # scripts/dtc: Update to upstream version v1.7.2-35=
-g52f07dcca47c
> > > > >=20
> > > > > This also includes forward port of U-Boot commit
> > > > > e8c2d25845c7 ("libfdt: Revert 6dcb8ba4 from upstream libfdt")
> > > > > to avoid binary size growth.
> > > > >=20
> > > > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > > > ---
> > > > > Cc: Adriano Cordova <adrianox@gmail.com>
> > > > > Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
> > > > > Cc: Christian Marangi <ansuelsmth@gmail.com>
> > > > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > > > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> > > > > Cc: Sam Edwards <cfsworks@gmail.com>
> > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > Cc: u-boot@lists.denx.de
> > > >=20
> > > > We observed several boot failures on K3 platforms since the additio=
n of
> > > > this patch at the R5 SPL stage, the issue seems to be the newly add=
ed
> > > > check for alignment in fdt_check_header in scripts/dtc/libfdt/fdt.c=
:95
> > > > but the binaries generated don't have 8-byte aligned FDTs.
> > > >=20
> > > > I have been able to reproduce the issue on AM62p EVM with a clean
> > > > working directory (this is important since any minor change to the
> > > > SPL binary size such as by the added "-dirty" tag could make the ad=
dress
> > > > aligned) and GCC 13.3[1].
> > > >=20
> > > > Are we ensuring the fdt present in the SPL binary is properly align=
ed?
> >=20
> > Yes, the device tree must be 8-byte aligned, this is a requirement of
> > the device tree spec itself that we had been lax over until now.
> We found iMX95/iMX94 EVK boards are broken after this fdt lib update. The
> root cause is default value of CONFIG_SPL_OF_LIBFDT_ASSUME_MASK is 0xff. =
In
> this update, fdt_check_node_offset_ is changed as below to check the
> CONFIG_SPL_OF_LIBFDT_ASSUME_MASK. When it is 0xff, fdt_check_node_offset_
> will skip offset check.
>=20
>=20
>  int fdt_check_node_offset_(const void *fdt, int offset)
>  {
> -	if ((offset < 0) || (offset % FDT_TAGSIZE)
> -	    || (fdt_next_tag(fdt, offset, &offset) !=3D FDT_BEGIN_NODE))
> +	if (!can_assume(VALID_INPUT)
> +	    && ((offset < 0) || (offset % FDT_TAGSIZE)))
> +		return -FDT_ERR_BADOFFSET;
> +
> +	if (fdt_next_tag(fdt, offset, &offset) !=3D FDT_BEGIN_NODE)
>  		return -FDT_ERR_BADOFFSET;
>=20
> This cause a problem to SCMI agent uclass driver. In scmi_bind_protocols
> function, a ofnode_null() is used when creating scmi-base.0 device to bind
> with driver. This null node which has offset value -1 can successfully pa=
ss
> the fdt_check_node_offset_, so causes crash in
> device_probe()->dev_power_domain_on() when finding power-domains phandle.

Thanks for the analysis.

> I notice the default value of CONFIG_OF_LIBFDT_ASSUME_MASK used by u-boot=
 is
> 0. So why does SPL have different default value? Should we change the SPL
> default value to 0 to align with u-boot? Otherwise, any idea for fix.

In SPL we must assume a perfect device tree has been passed to us, both
for design reasons (it's not a user interactively, we built it, or it
came from some other firmware stack) as well as practical (performing
the sanity tests would grow all platforms by several kilobytes and
overflow size constraints). I think the SCMI code needs to be reworked,
in short.

--=20
Tom

--I4jnuG7v51M1YlV0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYX6egAKCRAr4qD1Cr/k
CuohAPwKki36ngyunx1GsZ0IzLNPYoLcQkGZAdYxPrGEOMLHUQD9GoVn4kGzud4y
lEs1C7OuzrBx/PFNrU1XPYekY5MeUQA=
=HeVb
-----END PGP SIGNATURE-----

--I4jnuG7v51M1YlV0--
