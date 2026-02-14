Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF892EF5852
	for <u-boot@archiver.kernel.org>; Sat, 14 Feb 2026 18:54:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE5CC83BE1;
	Sat, 14 Feb 2026 19:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mm7BzXdU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1161D83C14; Sat, 14 Feb 2026 19:54:16 +0100 (CET)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 951F983BC9
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 19:54:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7d1890f5cafso685984a34.1
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 10:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771095252; x=1771700052; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o/z9WfW4DlG/Ut10kg/IzdSvh3WLvl5k8gu4YXk7iNs=;
 b=mm7BzXdU1sJWF4QxjIFtsXo3ZjHyV2cXMNZvOg4+cYJ8kkFDreTnSs/tsHsTYzri2W
 q2tT0sM+Kheo9TtDl4QHjYWXmCSjMB15InvIwJnhIvGz+pfNmpCkFH5dUUXMufGFq+Kx
 4C0MH/0com2UGaxhjTwGwD9K4CE/oeX61jbgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771095252; x=1771700052;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o/z9WfW4DlG/Ut10kg/IzdSvh3WLvl5k8gu4YXk7iNs=;
 b=geQKvorsXCoEWqa7ziquWIEPxBd+4ecx6AmS3F7z4ooHNcuioohc23LtBjcd9N7Oyk
 RL+JJpKgnsyJX4zPUTozS59d9afsHZJe4l4d9iaP+EzCuxEY1/VaM+oeB2FOspz8jm45
 qC0wkxNclnRw0YaUHs7h6KbjHepIwkaooetZ1QKvWprUM3kLi7IxD2cVWRwzipp00i/u
 iD3DPRDmOFGjw495aWfS7Zw97VDXbKit8xGryhNRLaKBobopaDSxWnXGe3JZ8BJ0MXcV
 0LZrp04YFucEVLCp0K2SSjkcIGTuEWSKc4LSE50lMlWPA1OrGl95b/4D+Oj1FwV436KF
 wzQw==
X-Gm-Message-State: AOJu0YwdzV+LXTZpMY50VUNhTuxVCuUP46fKx3Vg4H8EeeFeaoNuOP1Z
 5IgYj5GESzRZGDQQLvXMLu9rqNunAh16gc6+1b94dOOwrae2KENoz360bxdPy4PRKNs=
X-Gm-Gg: AZuq6aIVey2ANvi83EEMBI2SZ2yIQvyZ4+51cUm14kGIPHX8DMcvTuDATcpZBgyxrzU
 DIjk5NaybeC0IzgIJ9o439joz1xQlr+ns+Dal8rCTq1MFvb6Ag4Vx8rbY6mBD3D9s53ILuFv/tq
 K8Yi8O/VuuUsudXC9i9TAHAz1v6RCQqN30otUcZZB3MywRT+jh5Er8rAp5egqV284kZfLNjhLdw
 p/0gPiQEIS583SysGHpRAkGP/8I2c2Vnu6X3/rHhqM4K/+gj13ED1/XTgggXUCyn9Rtcx0lP+5a
 USPL76vL4X+D3lIWySzW8Ifabuu3kWMVwDcid+yo8uyOoC3wsBR0rS9LwSqnF0/yk/VTx7fYGBx
 f8cyPj9zjBAXtOTZnW3lZJmpH/FFOHUawicfaoV3mUG9xmlhq3oSqXWqDmSm4Rxhacwgd6wCzKj
 nwCaYgimhH9WO4ychwP+XZ3FxA/GW8QD9QulJXRxgnX98tObN67O+ka/Buh2RuEZ50hN04iKYCn
 2FP6qQ7tZO8/TmPddWaHcSf1Sg8/YnfIap0bAsQHMo2lhGmemE=
X-Received: by 2002:a05:6830:6208:b0:7d1:91c9:9e70 with SMTP id
 46e09a7af769-7d4d0a8d518mr2073431a34.6.1771095252319; 
 Sat, 14 Feb 2026 10:54:12 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a754b162sm8696644a34.12.2026.02.14.10.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Feb 2026 10:54:11 -0800 (PST)
Date: Sat, 14 Feb 2026 12:54:09 -0600
From: Tom Rini <trini@konsulko.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Cc: u-boot@lists.denx.de, Brian Sune <briansune@gmail.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 "Maniyam, Dinesh" <dinesh.maniyam@altera.com>,
 "Lok, Chen Huei" <chen.huei.lok@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Re: Pull request: SoCFPGA changes for u-boot-socfpga-next-20260213
Message-ID: <20260214185409.GS2747538@bill-the-cat>
References: <LV8PR03MB81379CE3BDF36A06DC1D517BA761A@LV8PR03MB8137.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JMuwLT19TjSOJbgS"
Content-Disposition: inline
In-Reply-To: <LV8PR03MB81379CE3BDF36A06DC1D517BA761A@LV8PR03MB8137.namprd03.prod.outlook.com>
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


--JMuwLT19TjSOJbgS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 14, 2026 at 04:45:41AM +0000, Chee, Tien Fong wrote:

> Dear Tom,
>=20
> This pull request updates SoCFPGA platforms with DDR improvements, new bo=
ard support, Agilex5 enhancements and general cleanup across the codebase.
> DDR and memory handling
>=20
>   *
> Add DRAM size checking support for Arria10.
>   *
> Widen MEM_TOTAL_CAPACITY mask handling in IOSSM mailbox driver.
>   *
> Assign unit address to memory node for improved memory representation and=
 consistency.
>=20
> Agilex / Agilex5 updates
>=20
>   *
> Restore multi-DTB support for NAND boot and fix NAND clock handling.
>   *
> Enable SD card UHS mode and eMMC HS200/HS400 mode support on Agilex5.
>   *
> Fix DT property naming conventions for Agilex5.
>   *
> Exclude AGILEX_L4_SYS_FREE_CLK from clock enable/disable operations to av=
oid unintended clock control.
>=20
> New board support
>=20
>   *
> Add support for CoreCourse Cyclone V boards:
>      *
> AC501
>      *
> AC550
> Including device trees, QTS configuration, defconfigs and maintainers ent=
ries.
>=20
> Fixes and cleanup
>=20
>   *
> Fix GEN5 handoff script path.
>   *
> Remove incorrect CONFIG_SPL_LDSCRIPT settings.
>   *
> Replace legacy TARGET namespace and perform related cleanup across SoCFPG=
A code.
>   *
> General Kconfig, build and SoCFPGA maintenance updates.
>=20
> Overall this pull request improves platform robustness, adds new board co=
verage and cleans up legacy configuration usage across the SoCFPGA U-Boot c=
odebase.
> Thanks.
>=20
> Best regards,
> Tien Fong
>=20
> The following changes since commit f9ffeec4bdcf1da655a0ffea482062adde78fe=
e8:
>=20
>   board: toradex: Make A53 get RAM size from DT in K3 boards (2026-02-12 =
08:12:09 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-socfpga.git tags/u-boot=
-socfpga-next-20260213
>=20
> for you to fetch changes up to 4b567f8e252e27f6dafdfe22de1bad147595e33b:
>=20
>   Replace TARGET namespace and cleanup properly (2026-02-13 20:35:09 +080=
0)
>=20

Please note that I had to fix the Kconfig entries for the two new
platforms as they were referring to the old symbols and so didn't build
(and failed in CI, in that harder to spot manner). I am also concerned
it looks like there's a few places in the code rerferring to the old
symbol names and not the new ones. That said, applied to u-boot/next,
thanks!

--=20
Tom

--JMuwLT19TjSOJbgS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZDEzgAKCRAr4qD1Cr/k
CpX3AP9Z6fuzJs1TQBzou5ry/rYmpD+oqJmc2Qde4ygoxYU92wEAk361qIYXu195
Vr2Q3dK33yQw4RgvmfHyWrAz75v5Qwg=
=yGUb
-----END PGP SIGNATURE-----

--JMuwLT19TjSOJbgS--
