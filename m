Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C549D2F7F9
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 07:22:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93F4988C3D;
	Thu, 17 Oct 2024 09:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5710D88D5B; Thu, 17 Oct 2024 09:22:33 +0200 (CEST)
Received: from smtprelay04.ispgateway.de (smtprelay04.ispgateway.de
 [80.67.31.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C72188BEF
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 09:22:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=LW@KARO-electronics.de
Received: from [89.1.81.74] (helo=karo-electronics.de)
 by smtprelay04.ispgateway.de with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98)
 (envelope-from <LW@KARO-electronics.de>) id 1t1Kq4-000000007bW-0RIR;
 Thu, 17 Oct 2024 09:22:28 +0200
Date: Thu, 17 Oct 2024 09:22:27 +0200
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Aniket Limaye <a-limaye@ti.com>
Cc: <u-boot@lists.denx.de>, <trini@konsulko.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>
Subject: Re: [PATCH 6/6] DONOTMERGE: For testing only
Message-ID: <20241017092227.724ad2cf@karo-electronics.de>
In-Reply-To: <20241017062911.2241167-7-a-limaye@ti.com>
References: <20241017062911.2241167-1-a-limaye@ti.com>
 <20241017062911.2241167-7-a-limaye@ti.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kb21haW5mYWN0b3J5LWt1bmRlLmRl
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

Hi,

On Thu, 17 Oct 2024 11:59:13 +0530 Aniket Limaye wrote:
> From: Reid Tonking <reidt@ti.com>
>=20
> This just provides some useful print outs and the proper config to
> test the functionality. For J7200 boards that do not have efuse
> burned in, the hardcoded 760000 is needed in the vd_data, since
> it would be populated otherwise
>=20
> Signed-off-by: Reid Tonking <reidt@ti.com>
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> ---
>  arch/arm/mach-k3/j721e/j721e_init.c | 9 +++++++++
>  configs/j7200_evm_r5_defconfig      | 2 +-
>  drivers/misc/k3_avs.c               | 4 +++-
>  3 files changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/mach-k3/j721e/j721e_init.c b/arch/arm/mach-k3/j721e=
/j721e_init.c
> index 0620759c36c..19865f7dd40 100644
> --- a/arch/arm/mach-k3/j721e/j721e_init.c
> +++ b/arch/arm/mach-k3/j721e/j721e_init.c
> @@ -152,6 +152,8 @@ int fix_freq(const void *fdt)
>  {
>  		int node, ret;
>  		u32 opp_low_freq[3];
> +		int len;
> +		const u32 *reg;
> =20
>  		node =3D fdt_node_offset_by_compatible(fdt, -1, "ti,am654-rproc");
>  			if (node < 0) {
> @@ -159,6 +161,11 @@ int fix_freq(const void *fdt)
>  				return node;
>  			}
> =20
> +		/* check freqs */
> +		reg =3D fdt_getprop(fdt, node, "assigned-clock-rates", &len);
> +		printf("OPP_NOM: arm_clk:%d | gtc_clk:%d | msmc_clk:%d\n",
> +				fdt32_to_cpu(reg[0]), fdt32_to_cpu(reg[1]), fdt32_to_cpu(reg[2]));
> +
>  		/* j7200 opp low values according to data sheet */
>  		opp_low_freq[0] =3D cpu_to_fdt32(1000000000); /* 202-2 -> A72SS0_CORE0=
_0_ARM_CLK */
>  		opp_low_freq[1] =3D cpu_to_fdt32(200000000); /* 61-1 -> GTC0_GTC_CLK */
> @@ -170,6 +177,8 @@ int fix_freq(const void *fdt)
>  				printf("%s: Can not set value\n", __func__);
>  				return ret;
>  			}
> +		printf("OPP_LOW: arm_clk:%d | gtc_clk:%d | msmc_clk:%d\n",
> +				fdt32_to_cpu(opp_low_freq[0]), fdt32_to_cpu(opp_low_freq[1]), fdt32_=
to_cpu(opp_low_freq[2]));
> =20
>  		return 0;
>  }
> diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defcon=
fig
> index 7d43d8d702a..6fdf34c9644 100644
> --- a/configs/j7200_evm_r5_defconfig
> +++ b/configs/j7200_evm_r5_defconfig
> @@ -103,7 +103,7 @@ CONFIG_K3_SEC_PROXY=3Dy
>  CONFIG_FS_LOADER=3Dy
>  CONFIG_SPL_FS_LOADER=3Dy
>  CONFIG_K3_AVS0=3Dy
> -# CONFIG_K3_OPP_LOW is not set
> +CONFIG_K3_OPP_LOW=3Dy
>  CONFIG_SUPPORT_EMMC_BOOT=3Dy
>  CONFIG_SPL_MMC_HS400_SUPPORT=3Dy
>  CONFIG_MMC_SDHCI=3Dy
> diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
> index 932b355a5c1..e93aa267d51 100644
> --- a/drivers/misc/k3_avs.c
> +++ b/drivers/misc/k3_avs.c
> @@ -121,6 +121,8 @@ static int k3_avs_program_voltage(struct k3_avs_privd=
ata *priv,
>  	if (!vd->supply)
>  		return -ENODEV;
> =20
> +  printf("Program voltage: opp_id:%d | opp_volt:%d\n", opp_id, volt);
> +
buggy indentation.


Lothar Wa=C3=9Fmann
