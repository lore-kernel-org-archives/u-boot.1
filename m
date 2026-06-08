Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EFACD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:50:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EB12846E6;
	Mon,  8 Jun 2026 15:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ABctcfCL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 456D184704; Mon,  8 Jun 2026 15:50:20 +0200 (CEST)
Received: from mail-m83132.xmail.ntesmail.com (mail-m83132.xmail.ntesmail.com
 [156.224.83.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BBA7846B1
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from smtpclient.apple (unknown [59.56.83.5])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4187a3e8d;
 Mon, 8 Jun 2026 21:50:10 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
Message-Id: <DB96B10B-2B76-45FA-94EA-02CC5624169D@rock-chips.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v1] rockchip: MAINTAINERS: upstream devicetree update
Date: Mon, 8 Jun 2026 21:49:59 +0800
In-Reply-To: <ce82a3ab-0d89-4b1e-a598-b79f69e7ba5a@gmail.com>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 jagan@edgeble.ai, jonas@kwiboo.se, frattaroli.nicolas@gmail.com,
 tom@tom-fitzhenry.me.uk, ehristev@kernel.org,
 =?utf-8?B?6ZmI5YGl5rSq?= <chenjh@rock-chips.com>,
 =?utf-8?B?5byg5b+X5p2w?= <zhangzj@rock-chips.com>, jjriek@verizon.net,
 u-boot@lists.denx.de, andyshrk@163.com, me@0upti.me, zhihong@nzhnb.com,
 jiehui.he@foxmail.com, maximmosk4@gmail.com, gajjar04akash@gmail.com,
 jagan@amarulasolutions.com, Tianling Shen <cnsztl@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>, nick@khadas.com,
 matwey.kornilov@gmail.com, Chen-Yu Tsai <wens@csie.org>,
 mail@david-bauer.net, jacobe.zang@wesion.com
To: Johan Jonker <jbx6244@gmail.com>
References: <ce82a3ab-0d89-4b1e-a598-b79f69e7ba5a@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-HM-Tid: 0a9ea77f7c1909cckunm1860caf2350624
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSk9LVh9NS09OGE5PSBlLTlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlOQlVOTVVDSFVOWVdZFhoPEhUdFFlBWU9LSFVKS0lPT0
 9IVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=ABctcfCLeB0SfQ2N4pdDYQF6gqT+EZckzoIteQp60d2t5aaKNrSLhB1jdwYItiuBDGKGXuy8jsQNtWGVK6+z02Vpv+iBLLFrObrjNNbSELDcdOylq62B6RuT8aTDIATtGe05d2Ew7pjvfaM2z76XK/3Dzfl4TCmo+MxrQEZNrrs=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=C92lkgWoXcn2odBIDXXZhQWlZsvk6wxPpggGj1PW6co=;
 h=date:mime-version:subject:message-id:from;
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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



> 2026=E5=B9=B45=E6=9C=8818=E6=97=A5 07:24=EF=BC=8CJohan Jonker =
<jbx6244@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Most Rockchip boards are now using the upstream device tree.
> Some MAINTAINERS files still contain a reference to
> no longer available files. Update and where possible
> streamline with '*' ending.
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Reviewed-by: Kever Yang <kever.yang@rock-chips.com =
<mailto:kever.yang@rock-chips.com>>

Thanks,
- Kever
> ---
> .../neural-compute-module-6/MAINTAINERS       |  8 +---
> board/hardkernel/odroid_m1/MAINTAINERS        |  3 +-
> board/khadas/khadas-edge2-rk3588s/MAINTAINERS |  2 +-
> board/pine64/quartz64_rk3566/MAINTAINERS      | 21 ++--------
> board/pine64/quartzpro64-rk3588/MAINTAINERS   |  3 +-
> board/radxa/rock5a-rk3588s/MAINTAINERS        |  3 +-
> board/rockchip/evb_rk3328/MAINTAINERS         | 14 ++-----
> board/rockchip/evb_rk3399/MAINTAINERS         |  7 +---
> board/rockchip/evb_rk3568/MAINTAINERS         | 38 +++++++------------
> board/rockchip/evb_rk3588/MAINTAINERS         | 21 ++++------
> board/rockchip/toybrick_rk3588/MAINTAINERS    |  3 +-
> board/turing/turing-rk1-rk3588/MAINTAINERS    |  4 +-
> .../orangepi-5-ultra-rk3588/MAINTAINERS       |  2 +-
> 13 files changed, 37 insertions(+), 92 deletions(-)
>=20
> diff --git a/board/edgeble/neural-compute-module-6/MAINTAINERS =
b/board/edgeble/neural-compute-module-6/MAINTAINERS
> index 42e5df506bf3..97d8c96ae628 100644
> --- a/board/edgeble/neural-compute-module-6/MAINTAINERS
> +++ b/board/edgeble/neural-compute-module-6/MAINTAINERS
> @@ -5,9 +5,5 @@ F:	board/edgeble/neural-compute-module-6
> F:	include/configs/neural-compute-module-6.h
> F:	configs/neu6a-io-rk3588_defconfig
> F:	configs/neu6b-io-rk3588_defconfig
> -F:	arch/arm/dts/rk3588-edgeble-neu6a.dtsi
> -F:	arch/arm/dts/rk3588-edgeble-neu6a-io.dts
> -F:	arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
> -F:	arch/arm/dts/rk3588-edgeble-neu6b.dtsi
> -F:	arch/arm/dts/rk3588-edgeble-neu6b-io.dts
> -F:	arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
> +F:	arch/arm/dts/rk3588-edgeble-neu6a-io*
> +F:	arch/arm/dts/rk3588-edgeble-neu6b-io*
> diff --git a/board/hardkernel/odroid_m1/MAINTAINERS =
b/board/hardkernel/odroid_m1/MAINTAINERS
> index 165d2d96741d..8686a552d1c6 100644
> --- a/board/hardkernel/odroid_m1/MAINTAINERS
> +++ b/board/hardkernel/odroid_m1/MAINTAINERS
> @@ -4,5 +4,4 @@ S:	Maintained
> F:	board/hardkernel/odroid_m1/
> F:	include/configs/odroid_m1.h
> F:	configs/odroid-m1-rk3568_defconfig
> -F:	arch/arm/dts/rk3568-odroid-m1.dts
> -F:	arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi
> +F:	arch/arm/dts/rk3568-odroid-m1*
> diff --git a/board/khadas/khadas-edge2-rk3588s/MAINTAINERS =
b/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
> index 3f16923b0f25..c43f469589dd 100644
> --- a/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
> +++ b/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
> @@ -3,4 +3,4 @@ M:	Jacobe Zang <jacobe.zang@wesion.com>
> S:	Maintained
> F:	configs/khadas-edge2-rk3588s_defconfig
> F:	include/configs/khadas-edge2-rk3588s.h
> -F:	dts/upstream/src/arm64/rockchip/rk3588s-khadas-edge2.dts
> \ No newline at end of file
> +F:	arch/arm/dts/rk3588s-khadas-edge2*
> diff --git a/board/pine64/quartz64_rk3566/MAINTAINERS =
b/board/pine64/quartz64_rk3566/MAINTAINERS
> index 37b8c1eb78b6..955cb5de0300 100644
> --- a/board/pine64/quartz64_rk3566/MAINTAINERS
> +++ b/board/pine64/quartz64_rk3566/MAINTAINERS
> @@ -9,26 +9,11 @@ F:	configs/quartz64-b-rk3566_defconfig
> F:	configs/soquartz-blade-rk3566_defconfig
> F:	configs/soquartz-cm4-rk3566_defconfig
> F:	configs/soquartz-model-a-rk3566_defconfig
> -F:	arch/arm/dts/rk3566-quartz64-a.dts
> -F:	arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
> -F:	arch/arm/dts/rk3566-quartz64-b.dts
> -F:	arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi
> -F:	arch/arm/dts/rk3566-soquartz.dtsi
> -F:	arch/arm/dts/rk3566-soquartz-u-boot.dtsi
> -F:	arch/arm/dts/rk3566-soquartz-blade.dts
> -F:	arch/arm/dts/rk3566-soquartz-blade-u-boot.dtsi
> -F:	arch/arm/dts/rk3566-soquartz-cm4.dts
> -F:	arch/arm/dts/rk3566-soquartz-cm4-u-boot.dtsi
> -F:	arch/arm/dts/rk3566-soquartz-model-a.dts
> -F:	arch/arm/dts/rk3566-soquartz-model-a-u-boot.dtsi
> +F:	arch/arm/dts/rk3566-quartz64*
> +F:	arch/arm/dts/rk3566-soquartz*
>=20
> PINETAB2-RK3566
> M:	Jonas Karlman <jonas@kwiboo.se>
> S:	Maintained
> F:	configs/pinetab2-rk3566_defconfig
> -F:	arch/arm/dts/rk3566-pinetab2.dtsi
> -F:	arch/arm/dts/rk3566-pinetab2-u-boot.dtsi
> -F:	arch/arm/dts/rk3566-pinetab2-v0.1.dts
> -F:	arch/arm/dts/rk3566-pinetab2-v0.1-u-boot.dtsi
> -F:	arch/arm/dts/rk3566-pinetab2-v2.0.dts
> -F:	arch/arm/dts/rk3566-pinetab2-v2.0-u-boot.dtsi
> +F:	arch/arm/dts/rk3566-pinetab2*
> diff --git a/board/pine64/quartzpro64-rk3588/MAINTAINERS =
b/board/pine64/quartzpro64-rk3588/MAINTAINERS
> index a7e944b74781..ff3500a32fc0 100644
> --- a/board/pine64/quartzpro64-rk3588/MAINTAINERS
> +++ b/board/pine64/quartzpro64-rk3588/MAINTAINERS
> @@ -4,5 +4,4 @@ S:	Maintained
> F:	board/pine64/quartzpro64-rk3588
> F:	include/configs/quartzpro64-rk3588.h
> F:	configs/quartzpro64-rk3588_defconfig
> -F:	arch/arm/dts/rk3588-quartzpro64.dts
> -F:	arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
> +F:	arch/arm/dts/rk3588-quartzpro64*
> diff --git a/board/radxa/rock5a-rk3588s/MAINTAINERS =
b/board/radxa/rock5a-rk3588s/MAINTAINERS
> index afc9bf5706c9..d4cd82139d51 100644
> --- a/board/radxa/rock5a-rk3588s/MAINTAINERS
> +++ b/board/radxa/rock5a-rk3588s/MAINTAINERS
> @@ -5,5 +5,4 @@ S:	Maintained
> F:	board/radxa/rock5a-rk3588s
> F:	include/configs/rock5a-rk3588s.h
> F:	configs/rock5a-rk3588s_defconfig
> -F:	arch/arm/dts/rk3588s-rock-5a.dts
> -F:	arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
> +F:	arch/arm/dts/rk3588s-rock-5a*
> diff --git a/board/rockchip/evb_rk3328/MAINTAINERS =
b/board/rockchip/evb_rk3328/MAINTAINERS
> index 8c9b42fe2bbf..d8748c1c2a26 100644
> --- a/board/rockchip/evb_rk3328/MAINTAINERS
> +++ b/board/rockchip/evb_rk3328/MAINTAINERS
> @@ -4,8 +4,7 @@ S:      Maintained
> F:      board/rockchip/evb_rk3328
> F:      include/configs/evb_rk3328.h
> F:      configs/evb-rk3328_defconfig
> -F:      arch/arm/dts/rk3328-evb.dts
> -F:      arch/arm/dts/rk3328-evb-u-boot.dtsi
> +F:      arch/arm/dts/rk3328-evb*
>=20
> GENERIC-RK3328
> M:	Jonas Karlman <jonas@kwiboo.se>
> @@ -17,14 +16,12 @@ NANOPI-R2C-RK3328
> M:      Tianling Shen <cnsztl@gmail.com>
> S:      Maintained
> F:      configs/nanopi-r2c-rk3328_defconfig
> -F:      arch/arm/dts/rk3328-nanopi-r2c.dts
> F:      arch/arm/dts/rk3328-nanopi-r2c-u-boot.dtsi
>=20
> NANOPI-R2C-PLUS-RK3328
> M:      Tianling Shen <cnsztl@gmail.com>
> S:      Maintained
> F:      configs/nanopi-r2c-plus-rk3328_defconfig
> -F:      arch/arm/dts/rk3328-nanopi-r2c-plus.dts
> F:      arch/arm/dts/rk3328-nanopi-r2c-plus-u-boot.dtsi
>=20
> NANOPI-R2S-RK3328
> @@ -32,7 +29,6 @@ M:      David Bauer <mail@david-bauer.net>
> S:      Maintained
> F:      configs/nanopi-r2s-rk3328_defconfig
> F:      arch/arm/dts/rk3328-nanopi-r2s-u-boot.dtsi
> -F:      arch/arm/dts/rk3328-nanopi-r2s.dts
>=20
> NANOPI-R2S-PLUS-RK3328
> M:      Jonas Karlman <jonas@kwiboo.se>
> @@ -44,14 +40,12 @@ ORANGEPI-R1-PLUS-RK3328
> M:      Tianling Shen <cnsztl@gmail.com>
> S:      Maintained
> F:      configs/orangepi-r1-plus-rk3328_defconfig
> -F:      arch/arm/dts/rk3328-orangepi-r1-plus.dts
> F:      arch/arm/dts/rk3328-orangepi-r1-plus-u-boot.dtsi
>=20
> ORANGEPI-R1-PLUS-LTS-RK3328
> M:      Tianling Shen <cnsztl@gmail.com>
> S:      Maintained
> F:      configs/orangepi-r1-plus-lts-rk3328_defconfig
> -F:      arch/arm/dts/rk3328-orangepi-r1-plus-lts.dts
> F:      arch/arm/dts/rk3328-orangepi-r1-plus-lts-u-boot.dtsi
>=20
> ROC-RK3328-CC
> @@ -60,16 +54,14 @@ M:      Chen-Yu Tsai <wens@csie.org>
> R:      Jonas Karlman <jonas@kwiboo.se>
> S:      Maintained
> F:      configs/roc-cc-rk3328_defconfig
> -F:      arch/arm/dts/rk3328-roc-cc.dts
> -F:      arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
> +F:      arch/arm/dts/rk3328-roc-cc*
>=20
> ROCK64-RK3328
> M:      Matwey V. Kornilov <matwey.kornilov@gmail.com>
> R:      Jonas Karlman <jonas@kwiboo.se>
> S:      Maintained
> F:      configs/rock64-rk3328_defconfig
> -F:      arch/arm/dts/rk3328-rock64.dts
> -F:      arch/arm/dts/rk3328-rock64-u-boot.dtsi
> +F:      arch/arm/dts/rk3328-rock64*
>=20
> ROCKPIE-RK3328
> M:      Banglang Huang <banglang.huang@foxmail.com>
> diff --git a/board/rockchip/evb_rk3399/MAINTAINERS =
b/board/rockchip/evb_rk3399/MAINTAINERS
> index 8319db2e976c..860dd0287597 100644
> --- a/board/rockchip/evb_rk3399/MAINTAINERS
> +++ b/board/rockchip/evb_rk3399/MAINTAINERS
> @@ -24,9 +24,7 @@ KHADAS-EDGE
> M:	Nick Xie <nick@khadas.com>
> S:	Maintained
> F:	configs/khadas-edge-rk3399_defconfig
> -F:	arch/arm/dts/rk3399-khadas-edge.dts
> -F:	arch/arm/dts/rk3399-khadas-edge.dtsi
> -F:	arch/arm/dts/rk3399-khadas-edge-u-boot.dtsi
> +F:	arch/arm/dts/rk3399-khadas-edge*
>=20
> KHADAS-EDGE-CAPTAIN
> M:	Nick Xie <nick@khadas.com>
> @@ -56,8 +54,7 @@ NANOPI-M4
> M:	Jagan Teki <jagan@amarulasolutions.com>
> S:	Maintained
> F:	configs/nanopi-m4-rk3399_defconfig
> -F:	arch/arm/dts/rk3399-nanopi-m4.dts
> -F:	arch/arm/dts/rk3399-nanopi-m4-u-boot.dtsi
> +F:	arch/arm/dts/rk3399-nanopi-m4*
>=20
> NANOPI-M4-2GB
> M:	Jagan Teki <jagan@amarulasolutions.com>
> diff --git a/board/rockchip/evb_rk3568/MAINTAINERS =
b/board/rockchip/evb_rk3568/MAINTAINERS
> index 030cdbe6f3db..7e17a6a987a5 100644
> --- a/board/rockchip/evb_rk3568/MAINTAINERS
> +++ b/board/rockchip/evb_rk3568/MAINTAINERS
> @@ -2,8 +2,7 @@ BANANAPI-BPI-R2-PRO
> M:	Frank Wunderlich <frank-w@public-files.de>
> S:	Maintained
> F:	configs/bpi-r2-pro-rk3568_defconfig
> -F:	arch/arm/dts/rk3568-bpi-r2-pro.dts
> -F:	arch/arm/dts/rk3568-bpi-r2-pro-u-boot.dtsi
> +F:	arch/arm/dts/rk3568-bpi-r2-pro*
>=20
> EVB-RK3568
> M:	Joseph Chen <chenjh@rock-chips.com>
> @@ -11,78 +10,67 @@ S:	Maintained
> F:	board/rockchip/evb_rk3568
> F:	include/configs/evb_rk3568.h
> F:	configs/evb-rk3568_defconfig
> -F:	arch/arm/dts/rk3568-evb-u-boot.dtsi
> -F:	arch/arm/dts/rk3568-evb.dts
> +F:	arch/arm/dts/rk3568-evb*
>=20
> FASTRHINO-R66S-RK3568
> M:	Tianling Shen <cnsztl@gmail.com>
> R:	Jonas Karlman <jonas@kwiboo.se>
> S:	Maintained
> F:	configs/fastrhino-r66s-rk3568_defconfig
> -F:	arch/arm/dts/rk3568-fastrhino-r66s-u-boot.dtsi
> +F:	arch/arm/dts/rk3568-fastrhino-r66s*
>=20
> GENERIC-RK3568
> M:	Jonas Karlman <jonas@kwiboo.se>
> S:	Maintained
> F:	configs/generic-rk3568_defconfig
> -F:	arch/arm/dts/rk3568-generic.dts
> -F:	arch/arm/dts/rk3568-generic-u-boot.dtsi
> +F:	arch/arm/dts/rk3568-generic*
>=20
> LUBANCAT-2
> M:	Andy Yan <andyshrk@163.com>
> S:	Maintained
> F:	configs/lubancat-2-rk3568_defconfig
> -F:	arch/arm/dts/rk3568-lubancat-2.dts
> -F:	arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi
> +F:	arch/arm/dts/rk3568-lubancat-2*
>=20
> NANOPI-R3S
> M:	Tianling Shen <cnsztl@gmail.com>
> R:	Jonas Karlman <jonas@kwiboo.se>
> S:	Maintained
> F:	configs/nanopi-r3s-rk3566_defconfig
> -F:	arch/arm/dts/rk3566-nanopi-r3s-u-boot.dtsi
> +F:	arch/arm/dts/rk3566-nanopi-r3s*
>=20
> NANOPI-R5C
> M:	Tianling Shen <cnsztl@gmail.com>
> R:	Jonas Karlman <jonas@kwiboo.se>
> S:	Maintained
> F:	configs/nanopi-r5c-rk3568_defconfig
> -F:	arch/arm/dts/rk3568-nanopi-r5c.dts
> -F:	arch/arm/dts/rk3568-nanopi-r5c-u-boot.dtsi
> +F:	arch/arm/dts/rk3568-nanopi-r5c*
>=20
> NANOPI-R5S
> M:	Tianling Shen <cnsztl@gmail.com>
> R:	Jonas Karlman <jonas@kwiboo.se>
> S:	Maintained
> F:	configs/nanopi-r5s-rk3568_defconfig
> -F:	arch/arm/dts/rk3568-nanopi-r5s.dts
> -F:	arch/arm/dts/rk3568-nanopi-r5s.dtsi
> -F:	arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> +F:	arch/arm/dts/rk3568-nanopi-r5s*
>=20
> RADXA-CM3-IO
> M:	Jagan Teki <jagan@amarulasolutions.com>
> R:	Jonas Karlman <jonas@kwiboo.se>
> S:	Maintained
> F:	configs/radxa-cm3-io-rk3566_defconfig
> -F:	arch/arm/dts/rk3566-radxa-cm3.dtsi
> -F:	arch/arm/dts/rk3566-radxa-cm3-io.dts
> -F:	arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
> +F:	arch/arm/dts/rk3566-radxa-cm3-io*
>=20
> RADXA-E25
> M:	Jonas Karlman <jonas@kwiboo.se>
> S:	Maintained
> F:	configs/radxa-e25-rk3568_defconfig
> -F:	arch/arm/dts/rk3568-radxa-cm3i.dtsi
> -F:	arch/arm/dts/rk3568-radxa-e25.dts
> -F:	arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
> +F:	arch/arm/dts/rk3568-radxa-e25*
>=20
> ROCK-3A
> M:	Akash Gajjar <gajjar04akash@gmail.com>
> R:	Jonas Karlman <jonas@kwiboo.se>
> S:	Maintained
> F:	configs/rock-3a-rk3568_defconfig
> -F:	arch/arm/dts/rk3568-rock-3a.dts
> -F:	arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
> +F:	arch/arm/dts/rk3568-rock-3a*
>=20
> ROCK-3B
> M:	Jonas Karlman <jonas@kwiboo.se>
> @@ -94,11 +82,11 @@ ROCK-3C
> M:	Jonas Karlman <jonas@kwiboo.se>
> M:	Maxim Moskalets <maximmosk4@gmail.com>
> S:	Maintained
> -F:	arch/arm/dts/rk3566-rock-3c-u-boot.dtsi
> +F:	arch/arm/dts/rk3566-rock-3c*
> F:	configs/rock-3c-rk3566_defconfig
>=20
> LCKFB-TaishanPi
> M:	Jiehui He <jiehui.he@foxmail.com>
> S:	Maintained
> F:	configs/lckfb-tspi-rk3566_defconfig
> -F:	arch/arm/dts/rk3566-lckfb-tspi-u-boot.dtsi
> +F:	arch/arm/dts/rk3566-lckfb-tspi*
> diff --git a/board/rockchip/evb_rk3588/MAINTAINERS =
b/board/rockchip/evb_rk3588/MAINTAINERS
> index 8b11db43f5f6..b64dd4947ee2 100644
> --- a/board/rockchip/evb_rk3588/MAINTAINERS
> +++ b/board/rockchip/evb_rk3588/MAINTAINERS
> @@ -2,16 +2,13 @@ COOLPI-4B-RK3588S
> M:	Andy Yan <andyshrk@163.com>
> S:	Maintained
> F:	configs/coolpi-4b-rk3588s_defconfig
> -F:	arch/arm/dts/rk3588s-coolpi-4b.dts
> -F:	arch/arm/dts/rk3588s-coolpi-u-boot.dtsi
> +F:	arch/arm/dts/rk3588s-coolpi-4b*
>=20
> COOLPI-CM5-EVB-RK3588
> M:	Andy Yan <andyshrk@163.com>
> S:	Maintained
> F:	configs/coolpi-cm5-evb-rk3588_defconfig
> -F:	arch/arm/dts/rk3588-coolpi-cm5.dtsi
> -F:	arch/arm/dts/rk3588-coolpi-cm5-evb.dts
> -F:	arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi
> +F:	arch/arm/dts/rk3588-coolpi-cm5-evb*
>=20
> EVB-RK3588
> M:	Kever Yang <kever.yang@rock-chips.com>
> @@ -19,15 +16,13 @@ S:	Maintained
> F:	board/rockchip/evb_rk3588
> F:	include/configs/evb_rk3588.h
> F:	configs/evb-rk3588_defconfig
> -F:	arch/arm/dts/rk3588-evb1-v10.dts
> -F:	arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi
> +F:	arch/arm/dts/rk3588-evb1-v10*
>=20
> GENERIC-RK3588
> M:	Jonas Karlman <jonas@kwiboo.se>
> S:	Maintained
> F:	configs/generic-rk3588_defconfig
> -F:	arch/arm/dts/rk3588-generic.dts
> -F:	arch/arm/dts/rk3588-generic-u-boot.dtsi
> +F:	arch/arm/dts/rk3588-generic*
>=20
> MNT-REFORM2-RK3588
> M:	Peter Robinson <pbrobinson@gmail.com>
> @@ -38,24 +33,22 @@ ORANGEPI-5-RK3588
> M:	Jonas Karlman <jonas@kwiboo.se>
> S:	Maintained
> F:	configs/orangepi-5-rk3588s_defconfig
> -F:	arch/arm/dts/rk3588s-orangepi-5.dts
> F:	arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi
>=20
> ORANGEPI-5-MAX-RK3588
> M:	Ilya Katsnelson <me@0upti.me>
> S:	Maintained
> F:	configs/orangepi-5-max-rk3588_defconfig
> -F:	arch/arm/dts/rk3588-orangepi-5-max-u-boot.dtsi
> +F:	arch/arm/dts/rk3588-orangepi-5-max*
>=20
> ORANGEPI-5-PLUS-RK3588
> M:	Jonas Karlman <jonas@kwiboo.se>
> S:	Maintained
> F:	configs/orangepi-5-plus-rk3588_defconfig
> -F:	arch/arm/dts/rk3588-orangepi-5-plus.dts
> -F:	arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
> +F:	arch/arm/dts/rk3588-orangepi-5-plus*
>=20
> ORANGEPI-5-RK3588-ULTRA
> M:	Niu Zhihong <zhihong@nzhnb.com>
> S:	Maintained
> F:	configs/orangepi-5-ultra-rk3588_defconfig
> -F:	arch/arm/dts/rk3588-orangepi-5-ultra-u-boot.dtsi
> +F:	arch/arm/dts/rk3588-orangepi-5-ultra*
> diff --git a/board/rockchip/toybrick_rk3588/MAINTAINERS =
b/board/rockchip/toybrick_rk3588/MAINTAINERS
> index cd4401c24f30..e2c76f80e9b8 100644
> --- a/board/rockchip/toybrick_rk3588/MAINTAINERS
> +++ b/board/rockchip/toybrick_rk3588/MAINTAINERS
> @@ -4,5 +4,4 @@ S:	Maintained
> F:	board/rockchip/toybrick_rk3588
> F:	include/configs/toybrick_rk3588.h
> F:	configs/toybrick-rk3588_defconfig
> -F:	arch/arm/dts/rk3588-toybrick-x0.dts
> -F:	arch/arm/dts/rk3588-toybrick-x0-u-boot.dtsi
> +F:	arch/arm/dts/rk3588-toybrick-x0*
> diff --git a/board/turing/turing-rk1-rk3588/MAINTAINERS =
b/board/turing/turing-rk1-rk3588/MAINTAINERS
> index 4f313732fa13..973ac68836cb 100644
> --- a/board/turing/turing-rk1-rk3588/MAINTAINERS
> +++ b/board/turing/turing-rk1-rk3588/MAINTAINERS
> @@ -4,6 +4,4 @@ S:	Maintained
> F:	board/turing/turing-rk1-rk3588
> F:	include/configs/turing-rk1-rk3588.h
> F:	configs/turing-rk1-rk3588_defconfig
> -F:	arch/arm/dts/rk3588-turing-rk1.dts
> -F:	arch/arm/dts/rk3588-turing-rk1.dtsi
> -F:	arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
> +F:	arch/arm/dts/rk3588-turing-rk1*
> diff --git a/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS =
b/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
> index be9c93f6b9d9..79981aa43f13 100644
> --- a/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
> +++ b/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
> @@ -3,4 +3,4 @@ M:	Niu Zhihong <zhihong@nzhnb.com>
> S:	Maintained
> F:	board/xunlong/orangepi-5-rk3588-ultra
> F:	configs/orangepi-5-ultra-rk3588_defconfig
> -F:	arch/arm/dts/rk3588-orangepi-5-ultra.dts
> +F:	arch/arm/dts/rk3588-orangepi-5-ultra*
> --
> 2.39.5
>=20
>=20
>=20

