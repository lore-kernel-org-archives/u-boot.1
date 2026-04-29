Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2660DFF8875
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 19:42:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57213848A9;
	Wed, 29 Apr 2026 21:42:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bSCXq/zg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A5FA848B9; Wed, 29 Apr 2026 21:42:14 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ADD5848A2
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 21:42:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 61FA56015B;
 Wed, 29 Apr 2026 19:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08AFC19425;
 Wed, 29 Apr 2026 19:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777491730;
 bh=hklisgrTPkfIAJnn/udCbotXl3+bQaW64k1kUu2UyrQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bSCXq/zghhamAsaTnIgAA7xLq1I6YmWCp2oMmkgDxSHafzVCp/jYEv/OXA2p3Cqqe
 kqFaKm26PG+v/MewRn+hddvdftS2Tu6vf8GoH+LLyE9GgFmOFAcKeblsjD6dLGzDdY
 LPcO2ziHUCe+rWk9MqQE0Bq1Ucud1w9aC+XKYkXDwdRrWd6eD0ed2tN+hVidUxxmEC
 tGn7lQ5Wy9GubbuB3YDFff7NL97npwEaDWwAcrnDqkcQ7fw9H63TV3k1CKdnpXua3Y
 2Ys/tTWmdH6Xgi4qNxhiTz9EhEx/xMLDtbzmbS0MnKwlDo+pr1cbbra6TBapZNN4yg
 Dnhic0uTBr5AA==
Date: Wed, 29 Apr 2026 20:42:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: u-boot@lists.denx.de, uboot@riscstar.com, u-boot-spacemit@groups.io,
 raymond.mao@riscstar.com, rick@andestech.com, ycliang@andestech.com,
 trini@konsulko.com, lukma@denx.de, hs@nabladev.com,
 jh80.chung@samsung.com, peng.fan@nxp.com, xypron.glpk@gmx.de,
 randolph@andestech.com, dlan@gentoo.org, junhui.liu@pigmoral.tech,
 neil.armstrong@linaro.org, quentin.schulz@cherry.de, samuel@sholland.org
Subject: Re: [PATCH 16/16] spacemit: k1: rename device tree prefix from "k1-"
 to "k1_"
Message-ID: <20260429-doorbell-envision-46acf9988b40@spud>
References: <20260422143112.1329478-1-raymondmaoca@gmail.com>
 <20260422143112.1329478-17-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+w9DBN4lt+v13/WV"
Content-Disposition: inline
In-Reply-To: <20260422143112.1329478-17-raymondmaoca@gmail.com>
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


--+w9DBN4lt+v13/WV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 10:31:12AM -0400, Raymond Mao wrote:
> From: Raymond Mao <raymond.mao@riscstar.com>
>=20
> This change replaces the hyphen ("-") in the DTS prefix with an
> underscore ("_") for consistency with other prefixes in the
> Spacemit K1 SoC platform.

Doesn't this inconsistency only exist because you added files that made
it inconsistent? Using hyphens is the norm anyway, right?

>=20
> Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> ---
>  arch/riscv/dts/Makefile                                   | 2 +-
>  arch/riscv/dts/{k1-bananapi-f3.dts =3D> k1_bananapi-f3.dts} | 2 +-
>  arch/riscv/dts/{k1-muse-pi-pro.dts =3D> k1_muse-pi-pro.dts} | 0
>  arch/riscv/dts/{k1-pinctrl.dtsi =3D> k1_pinctrl.dtsi}       | 0
>  arch/riscv/dts/{k1-spl.dts =3D> k1_spl.dts}                 | 0
>  board/spacemit/k1/spl.c                                   | 2 +-
>  configs/spacemit_k1_defconfig                             | 4 ++--
>  7 files changed, 5 insertions(+), 5 deletions(-)
>  rename arch/riscv/dts/{k1-bananapi-f3.dts =3D> k1_bananapi-f3.dts} (99%)
>  rename arch/riscv/dts/{k1-muse-pi-pro.dts =3D> k1_muse-pi-pro.dts} (100%)
>  rename arch/riscv/dts/{k1-pinctrl.dtsi =3D> k1_pinctrl.dtsi} (100%)
>  rename arch/riscv/dts/{k1-spl.dts =3D> k1_spl.dts} (100%)
>=20
> diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
> index 22b62e25d4d..3827ff72215 100644
> --- a/arch/riscv/dts/Makefile
> +++ b/arch/riscv/dts/Makefile
> @@ -9,7 +9,7 @@ dtb-$(CONFIG_TARGET_LICHEERV_NANO) +=3D sg2002-licheerv-n=
ano-b.dtb
>  dtb-$(CONFIG_TARGET_QEMU_VIRT) +=3D qemu-virt32.dtb qemu-virt64.dtb
>  dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) +=3D openpiton-riscv64.dtb
>  dtb-$(CONFIG_TARGET_SIPEED_MAIX) +=3D k210-maix-bit.dtb
> -dtb-$(CONFIG_TARGET_SPACEMIT_K1) +=3D k1-bananapi-f3.dtb k1-muse-pi-pro.=
dtb k1-spl.dtb
> +dtb-$(CONFIG_TARGET_SPACEMIT_K1) +=3D k1_bananapi-f3.dtb k1_muse-pi-pro.=
dtb k1_spl.dtb
>  dtb-$(CONFIG_TARGET_XILINX_MBV) +=3D xilinx-mbv32.dtb
>  dtb-$(CONFIG_TARGET_XILINX_MBV) +=3D xilinx-mbv64.dtb
>  dtb-$(CONFIG_TARGET_XILINX_MBV) +=3D xilinx-binman.dtb
> diff --git a/arch/riscv/dts/k1-bananapi-f3.dts b/arch/riscv/dts/k1_banana=
pi-f3.dts
> similarity index 99%
> rename from arch/riscv/dts/k1-bananapi-f3.dts
> rename to arch/riscv/dts/k1_bananapi-f3.dts
> index ea11029c182..bcb5be5f1bc 100644
> --- a/arch/riscv/dts/k1-bananapi-f3.dts
> +++ b/arch/riscv/dts/k1_bananapi-f3.dts
> @@ -5,7 +5,7 @@
> =20
>  #include "k1.dtsi"
>  #include "binman.dtsi"
> -#include "k1-pinctrl.dtsi"
> +#include "k1_pinctrl.dtsi"
> =20
>  / {
>  	model =3D "Banana Pi BPI-F3";
> diff --git a/arch/riscv/dts/k1-muse-pi-pro.dts b/arch/riscv/dts/k1_muse-p=
i-pro.dts
> similarity index 100%
> rename from arch/riscv/dts/k1-muse-pi-pro.dts
> rename to arch/riscv/dts/k1_muse-pi-pro.dts
> diff --git a/arch/riscv/dts/k1-pinctrl.dtsi b/arch/riscv/dts/k1_pinctrl.d=
tsi
> similarity index 100%
> rename from arch/riscv/dts/k1-pinctrl.dtsi
> rename to arch/riscv/dts/k1_pinctrl.dtsi
> diff --git a/arch/riscv/dts/k1-spl.dts b/arch/riscv/dts/k1_spl.dts
> similarity index 100%
> rename from arch/riscv/dts/k1-spl.dts
> rename to arch/riscv/dts/k1_spl.dts
> diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
> index 2556dfe047a..b8e1327dc57 100644
> --- a/board/spacemit/k1/spl.c
> +++ b/board/spacemit/k1/spl.c
> @@ -374,7 +374,7 @@ int board_fit_config_name_match(const char *name)
> =20
>  	memset(fdt_name, 0, I2C_BUF_SIZE);
>  	if (!strncmp(product_name, "k1-x_", 5)) {
> -		snprintf(fdt_name, I2C_BUF_SIZE, "%s-%s", "k1",
> +		snprintf(fdt_name, I2C_BUF_SIZE, "%s_%s", "k1",
>  			 &product_name[5]);
>  	}
>  	for (i =3D 0; i < I2C_BUF_SIZE; i++) {
> diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
> index 13f055cdf53..ddd0c959c12 100644
> --- a/configs/spacemit_k1_defconfig
> +++ b/configs/spacemit_k1_defconfig
> @@ -3,8 +3,8 @@ CONFIG_SYS_MALLOC_LEN=3D0x1000000
>  CONFIG_NR_DRAM_BANKS=3D2
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x1000000
> -CONFIG_DEFAULT_DEVICE_TREE=3D"k1-spl"
> -CONFIG_OF_LIST=3D"k1-bananapi-f3 k1-muse-pi-pro"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"k1_spl"
> +CONFIG_OF_LIST=3D"k1_bananapi-f3 k1_muse-pi-pro"
>  CONFIG_SPL=3Dy
>  CONFIG_SPL_TEXT_BASE=3D0xc0801000
>  CONFIG_SPL_MAX_SIZE=3D0x33000
> --=20
> 2.25.1
>=20

--+w9DBN4lt+v13/WV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCafJfDAAKCRB4tDGHoIJi
0sDbAP40ugu9lrzWGlzP3kjACQ4GeIiWhoQEUXI4zfsymPRgPgD/f763cxDVGzw6
/HcT6c2+v/lNx3MTut1XnDj+KkFGVwA=
=FtX8
-----END PGP SIGNATURE-----

--+w9DBN4lt+v13/WV--
