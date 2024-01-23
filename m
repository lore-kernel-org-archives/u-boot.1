Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C1DC47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 09:29:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8510187994;
	Tue, 23 Jan 2024 10:29:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A90FC87994; Tue, 23 Jan 2024 10:29:38 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 25A4187701
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 10:29:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.05,214,1701097200"; 
 d="asc'?scan'208";a="195327754"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 23 Jan 2024 18:29:33 +0900
Received: from [10.226.92.252] (unknown [10.226.92.252])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0B045400F737;
 Tue, 23 Jan 2024 18:29:31 +0900 (JST)
Message-ID: <2e8156d5-f43c-4c7d-9898-a64476d7ad3b@bp.renesas.com>
Date: Tue, 23 Jan 2024 09:29:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: renesas: Drop include common.h
Content-Language: en-GB
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>
References: <20240121173211.273726-1-marek.vasut+renesas@mailbox.org>
 <20240121173211.273726-3-marek.vasut+renesas@mailbox.org>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <20240121173211.273726-3-marek.vasut+renesas@mailbox.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------OFlEu7EMos50NGQrAQjvzjkq"
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------OFlEu7EMos50NGQrAQjvzjkq
Content-Type: multipart/mixed; boundary="------------s1bmefSc0ATPmrcd07lxToKp";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>
Message-ID: <2e8156d5-f43c-4c7d-9898-a64476d7ad3b@bp.renesas.com>
Subject: Re: [PATCH 3/3] ARM: renesas: Drop include common.h
References: <20240121173211.273726-1-marek.vasut+renesas@mailbox.org>
 <20240121173211.273726-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240121173211.273726-3-marek.vasut+renesas@mailbox.org>

--------------s1bmefSc0ATPmrcd07lxToKp
Content-Type: multipart/mixed; boundary="------------X4kFModoN3Vgee9kVl4m80UP"

--------------X4kFModoN3Vgee9kVl4m80UP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 21/01/2024 17:31, Marek Vasut wrote:
> The header file is not necessary in either of those files,
> remove it as common.h is going away.
>=20
> Include missing asm/arch/rmobile.h in board/renesas/rcar-common/v3-comm=
on.c
> to prevent build failure of r8a77970_eagle r8a779a0_falcon r8a77980_v3h=
sk
> and r8a77970_v3msk .
>=20
> Include missing asm/u-boot.h in falcon.c and grpeach.c to fix build fai=
lure
> due to missing definition of struct bd_info . Include errno.h in grpeac=
h.c
> to fix build error due to missing definition of EINVAL.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>  board/renesas/alt/alt.c               | 1 -
>  board/renesas/alt/alt_spl.c           | 1 -
>  board/renesas/alt/qos.c               | 1 -
>  board/renesas/blanche/blanche.c       | 1 -
>  board/renesas/blanche/qos.c           | 1 -
>  board/renesas/draak/draak.c           | 1 -
>  board/renesas/falcon/falcon.c         | 2 +-
>  board/renesas/gose/gose.c             | 1 -
>  board/renesas/gose/gose_spl.c         | 1 -
>  board/renesas/gose/qos.c              | 1 -
>  board/renesas/grpeach/grpeach.c       | 3 ++-
>  board/renesas/koelsch/koelsch.c       | 1 -
>  board/renesas/koelsch/koelsch_spl.c   | 1 -
>  board/renesas/koelsch/qos.c           | 1 -
>  board/renesas/lager/lager.c           | 1 -
>  board/renesas/lager/lager_spl.c       | 1 -
>  board/renesas/lager/qos.c             | 1 -
>  board/renesas/porter/porter.c         | 1 -
>  board/renesas/porter/porter_spl.c     | 1 -
>  board/renesas/porter/qos.c            | 1 -
>  board/renesas/r2dplus/r2dplus.c       | 1 -
>  board/renesas/rcar-common/common.c    | 1 -
>  board/renesas/rcar-common/gen3-spl.c  | 1 -
>  board/renesas/rcar-common/v3-common.c | 2 +-
>  board/renesas/salvator-x/salvator-x.c | 1 -
>  board/renesas/silk/qos.c              | 1 -
>  board/renesas/silk/silk.c             | 1 -
>  board/renesas/silk/silk_spl.c         | 1 -
>  board/renesas/spider/spider.c         | 1 -
>  board/renesas/stout/cpld.c            | 1 -
>  board/renesas/stout/qos.c             | 1 -
>  board/renesas/stout/stout.c           | 1 -
>  board/renesas/stout/stout_spl.c       | 1 -
>  board/renesas/ulcb/cpld.c             | 1 -
>  board/renesas/ulcb/ulcb.c             | 1 -
>  board/renesas/v3hsk/cpld.c            | 1 -
>  board/renesas/v3msk/cpld.c            | 1 -
>  board/renesas/whitehawk/whitehawk.c   | 1 -
>  38 files changed, 4 insertions(+), 38 deletions(-)
>=20
> diff --git a/board/renesas/alt/alt.c b/board/renesas/alt/alt.c
> index 85fbaf0b28b..be77cade01b 100644
> --- a/board/renesas/alt/alt.c
> +++ b/board/renesas/alt/alt.c
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2014, 2015 Renesas Electronics Corporation
>   */
> =20
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <env.h>
>  #include <hang.h>
> diff --git a/board/renesas/alt/alt_spl.c b/board/renesas/alt/alt_spl.c
> index cdaa04e4f4c..fc9dac55e6a 100644
> --- a/board/renesas/alt/alt_spl.c
> +++ b/board/renesas/alt/alt_spl.c
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
>   */
> =20
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <init.h>
>  #include <malloc.h>
> diff --git a/board/renesas/alt/qos.c b/board/renesas/alt/qos.c
> index 2f657505ceb..38dfa647e81 100644
> --- a/board/renesas/alt/qos.c
> +++ b/board/renesas/alt/qos.c
> @@ -6,7 +6,6 @@
>   *
>   */
> =20
> -#include <common.h>
>  #include <asm/processor.h>
>  #include <asm/mach-types.h>
>  #include <asm/io.h>
> diff --git a/board/renesas/blanche/blanche.c b/board/renesas/blanche/bl=
anche.c
> index 8e1ae29e221..c6ecea2afcf 100644
> --- a/board/renesas/blanche/blanche.c
> +++ b/board/renesas/blanche/blanche.c
> @@ -6,7 +6,6 @@
>   * Copyright (C) 2016 Renesas Electronics Corporation
>   */
> =20
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <init.h>
>  #include <net.h>
> diff --git a/board/renesas/blanche/qos.c b/board/renesas/blanche/qos.c
> index e3ad83ee0c2..3134b36a443 100644
> --- a/board/renesas/blanche/qos.c
> +++ b/board/renesas/blanche/qos.c
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2016 Renesas Electronics Corporation
>   */
> =20
> -#include <common.h>
>  #include <asm/processor.h>
>  #include <asm/mach-types.h>
>  #include <asm/io.h>
> diff --git a/board/renesas/draak/draak.c b/board/renesas/draak/draak.c
> index 1ed72d34a74..06a3a832984 100644
> --- a/board/renesas/draak/draak.c
> +++ b/board/renesas/draak/draak.c
> @@ -6,7 +6,6 @@
>   * Copyright (C) 2017 Marek Vasut <marek.vasut+renesas@gmail.com>
>   */
> =20
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <hang.h>
>  #include <init.h>
> diff --git a/board/renesas/falcon/falcon.c b/board/renesas/falcon/falco=
n.c
> index 0aa0f1afcbf..cd86bb3108c 100644
> --- a/board/renesas/falcon/falcon.c
> +++ b/board/renesas/falcon/falcon.c
> @@ -6,7 +6,6 @@
>   * Copyright (C) 2020 Renesas Electronics Corp.
>   */
> =20
> -#include <common.h>
>  #include <asm/arch/rmobile.h>
>  #include <asm/arch/sys_proto.h>
>  #include <asm/global_data.h>
> @@ -15,6 +14,7 @@
>  #include <asm/processor.h>
>  #include <linux/errno.h>
>  #include <asm/system.h>
> +#include <asm/u-boot.h>
> =20
>  DECLARE_GLOBAL_DATA_PTR;
> =20
> diff --git a/board/renesas/gose/gose.c b/board/renesas/gose/gose.c
> index 2d1435acff6..6edbdac3ded 100644
> --- a/board/renesas/gose/gose.c
> +++ b/board/renesas/gose/gose.c
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2014 Renesas Electronics Corporation
>   */
> =20
> -#include <common.h>
>  #include <clock_legacy.h>
>  #include <cpu_func.h>
>  #include <env.h>
> diff --git a/board/renesas/gose/gose_spl.c b/board/renesas/gose/gose_sp=
l.c
> index c0bf7204439..87126a0fc15 100644
> --- a/board/renesas/gose/gose_spl.c
> +++ b/board/renesas/gose/gose_spl.c
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
>   */
> =20
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <init.h>
>  #include <malloc.h>
> diff --git a/board/renesas/gose/qos.c b/board/renesas/gose/qos.c
> index 1c4ebfc6a8a..9944df76759 100644
> --- a/board/renesas/gose/qos.c
> +++ b/board/renesas/gose/qos.c
> @@ -6,7 +6,6 @@
>   * Copyright (C) 2014 Renesas Electronics Corporation
>   */
> =20
> -#include <common.h>
>  #include <asm/processor.h>
>  #include <asm/mach-types.h>
>  #include <asm/io.h>
> diff --git a/board/renesas/grpeach/grpeach.c b/board/renesas/grpeach/gr=
peach.c
> index f609e4f0728..c475c3f50ab 100644
> --- a/board/renesas/grpeach/grpeach.c
> +++ b/board/renesas/grpeach/grpeach.c
> @@ -4,12 +4,13 @@
>   * Copyright (C) Chris Brandt
>   */
> =20
> -#include <common.h>
>  #include <cpu_func.h>
> +#include <errno.h>
>  #include <init.h>
>  #include <asm/global_data.h>
>  #include <asm/io.h>
>  #include <asm/arch/sys_proto.h>
> +#include <asm/u-boot.h>
> =20
>  #define RZA1_WDT_BASE	0xfcfe0000
>  #define WTCSR		0x00
> diff --git a/board/renesas/koelsch/koelsch.c b/board/renesas/koelsch/ko=
elsch.c
> index c3ebcd3e39f..ee5597ad3d9 100644
> --- a/board/renesas/koelsch/koelsch.c
> +++ b/board/renesas/koelsch/koelsch.c
> @@ -6,7 +6,6 @@
>   *
>   */
> =20
> -#include <common.h>
>  #include <clock_legacy.h>
>  #include <cpu_func.h>
>  #include <env.h>
> diff --git a/board/renesas/koelsch/koelsch_spl.c b/board/renesas/koelsc=
h/koelsch_spl.c
> index b377f707158..7581920f577 100644
> --- a/board/renesas/koelsch/koelsch_spl.c
> +++ b/board/renesas/koelsch/koelsch_spl.c
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
>   */
> =20
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <init.h>
>  #include <malloc.h>
> diff --git a/board/renesas/koelsch/qos.c b/board/renesas/koelsch/qos.c
> index f884e5fe650..70cd117ba6b 100644
> --- a/board/renesas/koelsch/qos.c
> +++ b/board/renesas/koelsch/qos.c
> @@ -6,7 +6,6 @@
>   *
>   */
> =20
> -#include <common.h>
>  #include <asm/processor.h>
>  #include <asm/mach-types.h>
>  #include <asm/io.h>
> diff --git a/board/renesas/lager/lager.c b/board/renesas/lager/lager.c
> index 1437875cfa7..0daad0b1e6d 100644
> --- a/board/renesas/lager/lager.c
> +++ b/board/renesas/lager/lager.c
> @@ -7,7 +7,6 @@
>   * Copyright (C) 2013 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.=
com>
>   */
> =20
> -#include <common.h>
>  #include <clock_legacy.h>
>  #include <cpu_func.h>
>  #include <env.h>
> diff --git a/board/renesas/lager/lager_spl.c b/board/renesas/lager/lage=
r_spl.c
> index d3d397e8f0a..df3e240599a 100644
> --- a/board/renesas/lager/lager_spl.c
> +++ b/board/renesas/lager/lager_spl.c
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
>   */
> =20
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <init.h>
>  #include <malloc.h>
> diff --git a/board/renesas/lager/qos.c b/board/renesas/lager/qos.c
> index f01ca2fac71..ddc831c0c21 100644
> --- a/board/renesas/lager/qos.c
> +++ b/board/renesas/lager/qos.c
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2013,2014 Renesas Electronics Corporation
>   */
> =20
> -#include <common.h>
>  #include <asm/processor.h>
>  #include <asm/mach-types.h>
>  #include <asm/io.h>
> diff --git a/board/renesas/porter/porter.c b/board/renesas/porter/porte=
r.c
> index db1fb4b035f..2e6051addb1 100644
> --- a/board/renesas/porter/porter.c
> +++ b/board/renesas/porter/porter.c
> @@ -6,7 +6,6 @@
>   * Copyright (C) 2015 Cogent Embedded, Inc.
>   */
> =20
> -#include <common.h>
>  #include <clock_legacy.h>
>  #include <cpu_func.h>
>  #include <env.h>
> diff --git a/board/renesas/porter/porter_spl.c b/board/renesas/porter/p=
orter_spl.c
> index 8595770c364..039fc7b719e 100644
> --- a/board/renesas/porter/porter_spl.c
> +++ b/board/renesas/porter/porter_spl.c
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
>   */
> =20
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <init.h>
>  #include <malloc.h>
> diff --git a/board/renesas/porter/qos.c b/board/renesas/porter/qos.c
> index bca54f7f74c..e4d8f3dfafe 100644
> --- a/board/renesas/porter/qos.c
> +++ b/board/renesas/porter/qos.c
> @@ -7,7 +7,6 @@
>   *
>   */
> =20
> -#include <common.h>
>  #include <asm/processor.h>
>  #include <asm/mach-types.h>
>  #include <asm/io.h>
> diff --git a/board/renesas/r2dplus/r2dplus.c b/board/renesas/r2dplus/r2=
dplus.c
> index 4b9959a4326..78b8cb4ac34 100644
> --- a/board/renesas/r2dplus/r2dplus.c
> +++ b/board/renesas/r2dplus/r2dplus.c
> @@ -4,7 +4,6 @@
>   * Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>   */
> =20
> -#include <common.h>
>  #include <ide.h>
>  #include <init.h>
>  #include <net.h>
> diff --git a/board/renesas/rcar-common/common.c b/board/renesas/rcar-co=
mmon/common.c
> index ed3f093bf3c..66eb6a2002c 100644
> --- a/board/renesas/rcar-common/common.c
> +++ b/board/renesas/rcar-common/common.c
> @@ -7,7 +7,6 @@
>   * Copyright (C) 2015 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>   */
> =20
> -#include <common.h>
>  #include <dm.h>
>  #include <fdt_support.h>
>  #include <hang.h>
> diff --git a/board/renesas/rcar-common/gen3-spl.c b/board/renesas/rcar-=
common/gen3-spl.c
> index b02a946a21d..44a20cef2df 100644
> --- a/board/renesas/rcar-common/gen3-spl.c
> +++ b/board/renesas/rcar-common/gen3-spl.c
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2019 Marek Vasut <marek.vasut@gmail.com>
>   */
> =20
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <image.h>
>  #include <init.h>
> diff --git a/board/renesas/rcar-common/v3-common.c b/board/renesas/rcar=
-common/v3-common.c
> index 7c6202ea499..26c589d03e9 100644
> --- a/board/renesas/rcar-common/v3-common.c
> +++ b/board/renesas/rcar-common/v3-common.c
> @@ -3,8 +3,8 @@
>   * Copyright (C) 2017-2023 Marek Vasut <marek.vasut+renesas@mailbox.or=
g>
>   */
> =20
> -#include <common.h>
>  #include <clock_legacy.h>
> +#include <asm/arch/rmobile.h>
>  #include <asm/io.h>
> =20
>  #define CPGWPR  0xE6150900
> diff --git a/board/renesas/salvator-x/salvator-x.c b/board/renesas/salv=
ator-x/salvator-x.c
> index 939b48ee300..d8312ddb8a9 100644
> --- a/board/renesas/salvator-x/salvator-x.c
> +++ b/board/renesas/salvator-x/salvator-x.c
> @@ -7,7 +7,6 @@
>   * Copyright (C) 2015 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>   */
> =20
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <image.h>
>  #include <init.h>
> diff --git a/board/renesas/silk/qos.c b/board/renesas/silk/qos.c
> index 43a29898657..bdd76461b6a 100644
> --- a/board/renesas/silk/qos.c
> +++ b/board/renesas/silk/qos.c
> @@ -7,7 +7,6 @@
>   *
>   */
> =20
> -#include <common.h>
>  #include <asm/processor.h>
>  #include <asm/mach-types.h>
>  #include <asm/io.h>
> diff --git a/board/renesas/silk/silk.c b/board/renesas/silk/silk.c
> index 6ecebfe814d..18ff7591228 100644
> --- a/board/renesas/silk/silk.c
> +++ b/board/renesas/silk/silk.c
> @@ -6,7 +6,6 @@
>   * Copyright (C) 2015 Cogent Embedded, Inc.
>   */
> =20
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <env.h>
>  #include <hang.h>
> diff --git a/board/renesas/silk/silk_spl.c b/board/renesas/silk/silk_sp=
l.c
> index afb9f85ffc2..b899442c25a 100644
> --- a/board/renesas/silk/silk_spl.c
> +++ b/board/renesas/silk/silk_spl.c
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
>   */
> =20
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <init.h>
>  #include <malloc.h>
> diff --git a/board/renesas/spider/spider.c b/board/renesas/spider/spide=
r.c
> index fd83a72229e..1eb75a6397f 100644
> --- a/board/renesas/spider/spider.c
> +++ b/board/renesas/spider/spider.c
> @@ -6,7 +6,6 @@
>   * Copyright (C) 2021 Renesas Electronics Corp.
>   */
> =20
> -#include <common.h>
>  #include <asm/arch/rmobile.h>
>  #include <asm/arch/sys_proto.h>
>  #include <asm/global_data.h>
> diff --git a/board/renesas/stout/cpld.c b/board/renesas/stout/cpld.c
> index b7c75f5aa65..f5bb549b7c0 100644
> --- a/board/renesas/stout/cpld.c
> +++ b/board/renesas/stout/cpld.c
> @@ -7,7 +7,6 @@
>   * Copyright (C) 2015 Cogent Embedded, Inc.
>   */
> =20
> -#include <common.h>
>  #include <command.h>
>  #include <cpu_func.h>
>  #include <asm/io.h>
> diff --git a/board/renesas/stout/qos.c b/board/renesas/stout/qos.c
> index c2f0b853871..9030ba7f61f 100644
> --- a/board/renesas/stout/qos.c
> +++ b/board/renesas/stout/qos.c
> @@ -7,7 +7,6 @@
>   * Copyright (C) 2015 Cogent Embedded, Inc.
>   */
> =20
> -#include <common.h>
>  #include <asm/processor.h>
>  #include <asm/mach-types.h>
>  #include <asm/io.h>
> diff --git a/board/renesas/stout/stout.c b/board/renesas/stout/stout.c
> index f069eccde97..131deac1c7a 100644
> --- a/board/renesas/stout/stout.c
> +++ b/board/renesas/stout/stout.c
> @@ -8,7 +8,6 @@
>   * Copyright (C) 2015 Cogent Embedded, Inc.
>   */
> =20
> -#include <common.h>
>  #include <clock_legacy.h>
>  #include <env.h>
>  #include <init.h>
> diff --git a/board/renesas/stout/stout_spl.c b/board/renesas/stout/stou=
t_spl.c
> index c37c0557132..8ec02168106 100644
> --- a/board/renesas/stout/stout_spl.c
> +++ b/board/renesas/stout/stout_spl.c
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
>   */
> =20
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <init.h>
>  #include <malloc.h>
> diff --git a/board/renesas/ulcb/cpld.c b/board/renesas/ulcb/cpld.c
> index 0c060a5323d..e72e45e3fb4 100644
> --- a/board/renesas/ulcb/cpld.c
> +++ b/board/renesas/ulcb/cpld.c
> @@ -6,7 +6,6 @@
>   * Copyright (C) 2017 Cogent Embedded, Inc.
>   */
> =20
> -#include <common.h>
>  #include <command.h>
>  #include <asm/gpio.h>
>  #include <asm/io.h>
> diff --git a/board/renesas/ulcb/ulcb.c b/board/renesas/ulcb/ulcb.c
> index 1477750f921..b2a16b03513 100644
> --- a/board/renesas/ulcb/ulcb.c
> +++ b/board/renesas/ulcb/ulcb.c
> @@ -6,7 +6,6 @@
>   * Copyright (C) 2017 Renesas Electronics Corporation
>   */
> =20
> -#include <common.h>
>  #include <image.h>
>  #include <init.h>
>  #include <malloc.h>
> diff --git a/board/renesas/v3hsk/cpld.c b/board/renesas/v3hsk/cpld.c
> index 6016f6daef9..1272aec7302 100644
> --- a/board/renesas/v3hsk/cpld.c
> +++ b/board/renesas/v3hsk/cpld.c
> @@ -7,7 +7,6 @@
>   *
>   */
> =20
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <i2c.h>
> diff --git a/board/renesas/v3msk/cpld.c b/board/renesas/v3msk/cpld.c
> index aed616ac859..260755ac746 100644
> --- a/board/renesas/v3msk/cpld.c
> +++ b/board/renesas/v3msk/cpld.c
> @@ -7,7 +7,6 @@
>   *
>   */
> =20
> -#include <common.h>
>  #include <asm/gpio.h>
>  #include <asm/io.h>
>  #include <dm.h>
> diff --git a/board/renesas/whitehawk/whitehawk.c b/board/renesas/whiteh=
awk/whitehawk.c
> index 32284b2ecc0..3423ebd2995 100644
> --- a/board/renesas/whitehawk/whitehawk.c
> +++ b/board/renesas/whitehawk/whitehawk.c
> @@ -6,7 +6,6 @@
>   * Copyright (C) 2021 Renesas Electronics Corp.
>   */
> =20
> -#include <common.h>
>  #include <asm/arch/rmobile.h>
>  #include <asm/arch/sys_proto.h>
>  #include <asm/global_data.h>

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>

--------------X4kFModoN3Vgee9kVl4m80UP
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBGS4BNsBEADEc28TO+aryCgRIuhxWAviuJl+f2TcZ1JeeaMzRLgSXKuXzkiI
g6JIVfNvThjwJaBmb7+/5+D7kDLJuutu9MFfOzTS0QOQWppwIPgbfktvMvwwsq3m
7e9Qb+S1LVeV0/ldZfuzgzAzHFDwmzryfIyt2JEbsBsGTq/QE+7hvLAe8R9xofIn
z6/IndiiTYhNCNf06nFPR4Y5ZDZPGb9aw5Jisqh+OSxtc0BFHDSV8/35yWM/JLQ1
Ja8AOHw1kP9KO+iE9rHMt0+7lH3mN1GBabxH26EdgFfPShsi14qmziLOuUlGLuwO
ApIYqvdtCs+zlMA8PsiJIMuxizZ6qCLur3r2b+/YXoJjuFDcax9M+Pr0D7rZX0Hk
6PW3dtvDQHfspwLY0FIlXbbtCfCqGLe47VaS7lvG0XeMlo3dUEsf707Q2h0+G1tm
wyeuWSPEzZQq/KI7JIFlxr3N/3VCdGa9qVf/40QF0BXPfJdcwTEzmPlYetRgA11W
bglw8DxWBv24a2gWeUkwBWFScR3QV4FAwVjmlCqrkw9dy/JtrFf4pwDoqSFUcofB
95u6qlz/PC+ho9uvUo5uIwJyz3J5BIgfkMAPYcHNZZ5QrpI3mdwf66im1TOKKTuf
3Sz/GKc14qAIQhxuUWrgAKTexBJYJmzDT0Mj4ISjlr9K6VXrQwTuj2zC4QARAQAB
zStQYXVsIEJhcmtlciA8cGF1bC5iYXJrZXIuY3RAYnAucmVuZXNhcy5jb20+wsGU
BBMBCgA+FiEE9KKf333+FIzPGaxOJ/SzRZ8AIlcFAmS4BNsCGwEFCQPCZwAFCwkI
BwIGFQoJCAsCBBYCAwECHgECF4AACgkQJ/SzRZ8AIlfxaQ/8CM36qjfad7eBfwja
cI1LlH1NwbSJ239rE0X7hU/5yra72egr3T5AUuYTt9ECNQ8Ld03BYhbC6hPki5rb
OlFM2hEPUQYeohcJ4Na5iIFpTxoIuC49Hp2ce6ikvt9Hc4O2FAntabg+9hE8WA4f
QWW+Qo5ve5OJ0sGylzu0mRZ2I3mTaDsxuDkXOICF5ggSdjT+rcd/pRVOugImjpZv
/jzSgUfKV2wcZ8vVK0616K21tyPiRjYtDQjJAKff8gBY6ZvP5REPl+fYNvZm1y4l
hsVupGHL3aV+BKooMsKRZIMTiKJCIy6YFKHOcgWFG62cuRrFDf4r54MJuUGzyeoF
1XNFzbe1ySoRfU/HrEuBNqC+1CEBiduumh89BitfDNh6ecWVLw24fjsF1Ke6vYpU
lK9/yGLV26lXYEN4uEJ9i6PjgJ+Q8fubizCVXVDPxmWSZIoJg8EspZ+Max03Lk3e
flWQ0E3l6/VHmsFgkvqhjNlzFRrj/k86IKdOi0FOd0xtKh1p34rQ8S/4uUN9XCVj
KtmyLfQgqPVEC6MKv7yFbextPoDUrFAzEgi4OBdqDJjPbdU9wUjONxuWJRrzRFcr
nTIG7oC4dae0p1rs5uTlaSIKpB2yulaJLKjnNstAj9G9Evf4SE2PKH4l4Jlo/Hu1
wOUqmCLRo3vFbn7xvfr1u0Z+oMTOOARkuAhwEgorBgEEAZdVAQUBAQdAcuNbK3VT
WrRYypisnnzLAguqvKX3Vc1OpNE4f8pOcgMDAQgHwsF2BBgBCgAgFiEE9KKf333+
FIzPGaxOJ/SzRZ8AIlcFAmS4CHACGwwACgkQJ/SzRZ8AIlc90BAAr0hmx8XU9KCj
g4nJqfavlmKUZetoX5RB9g3hkpDlvjdQZX6lenw3yUzPj53eoiDKzsM03Tak/KFU
FXGeq7UtPOfXMyIh5UZVdHQRxC4sIBMLKumBfC7LM6XeSegtaGEX8vSzjQICIbaI
roF2qVUOTMGal2mvcYEvmObC08bUZuMd4nxLnHGiej2t85+9F3Y7GAKsA25EXbbm
ziUg8IVXw3TojPNrNoQ3if2Z9NfKBhv0/s7x/3WhhIzOht+rAyZaaW+31btDrX4+
Y1XLAzg9DAfuqkL6knHDMd9tEuK6m2xCOAeZazXaNeOTjQ/XqCHmZ+691VhmAHCI
7Z7EBPh++TjEqn4ZH+4KPn6XD52+ruWXGbJP29zc+3bwQ+ZADfUaL3ADj69ySxzm
bO24USHBAg+BhZAZMBkbkygbTen/umT6tBxG91krqbKlDdc8mhGonBN6i+nz8qv1
6MdC5P1rDbo834rxNLvoFMSLCcpjoafiprl9qk0wQLq48WGphs9DX7V75ZAU5Lt6
yA+je8i799EZJsVlB933Gpj688H4csaZqEMBjq7vMvI+a5MnLCGcjwRhsUfogpRb
AWTx9ddVau4MJgEHzB7UU/VFyP2vku7XPj6mgSfSHyNVf2hqxwISQ8eZLoyxauOD
Y61QMX6YFL170ylToSFjH627h6TzlUDOMwRkuAiAFgkrBgEEAdpHDwEBB0Bibkmu
Sf7yECzrkBmjD6VGWNVxTdiqb2RuAfGFY9RjRsLB7QQYAQoAIBYhBPSin999/hSM
zxmsTif0s0WfACJXBQJkuAiAAhsCAIEJECf0s0WfACJXdiAEGRYIAB0WIQSiu8gv
1Xr0fIw/aoLbaV4Vf/JGvQUCZLgIgAAKCRDbaV4Vf/JGvZP9AQCwV06n3DZvuce3
/BtzG5zqUuf6Kp2Esgr2FrD4fKVbogD/ZHpXfi9ELdH/JTSVyujaTqhuxQ5B7UzV
CUIb1qbg1APIEA/+IaLJIBySehy8dHDZQXit/XQYeROQLTT9PvyM35rZVMGH6VG8
Zb23BPCJ3N0ISOtVdG402lSP0ilP/zSyQAbJN6F0o2tiPd558lPerFd/KpbCIp8N
kYaLlHWIDiN2AE3c6sfCiCPMtXOR7HCeQapGQBS/IMh1qYHffuzuEy7tbrMvjdra
VN9Rqtp7PSuRTbO3jAhm0Oe4lDCAK4zyZfjwiZGxnj9s1dyEbxYB2GhTOgkiX/96
Nw+m/ShaKqTM7o3pNUEs9J3oHeGZFCCaZBv97ctqrYhnNB4kzCxAaZ6K9HAAmcKe
WT2q4JdYzwB6vEeHnvxl7M0Dj9pUTMujW77Qh5IkUQLYZ2XQYnKAV2WI90B0R1p9
bXP+jqqkaNCrxKHV1tYOB6037CziGcZmiDneiTlM765MTLJLlHNqlXxDCzRwEazU
y9dNzITjVT0qhc6th8/vqN9dqvQaAGa13u86Gbv4XPYdE+5MXPM/fTgkKaPBYcIV
QMvLfoZxyaTk4nzNbBxwwEEHrvTcWDdWxGNtkWRZw0+U5JpXCOi9kBCtFrJ701UG
UFs56zWndQUS/2xDyGk8GObGBSRLCwsXsKsF6hSX5aKXHyrAAxEUEscRaAmzd6O3
ZyZGVsEsOuGCLkekUMF/5dwOhEDXrY42VR/ZxdDTY99dznQkwTt4o7FOmkY=3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------X4kFModoN3Vgee9kVl4m80UP--

--------------s1bmefSc0ATPmrcd07lxToKp--

--------------OFlEu7EMos50NGQrAQjvzjkq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZa+G+wUDAAAAAAAKCRDbaV4Vf/JGvSa5
AQDtiK58k6dqYXbW21gnKVbdxXFgE6cQa4cdlz5XBCTcrAD8Dl8c0bIyhNt0EjqC9PjA7nMDmJm2
+pxfA7Y6PmR92gQ=
=m6i0
-----END PGP SIGNATURE-----

--------------OFlEu7EMos50NGQrAQjvzjkq--
