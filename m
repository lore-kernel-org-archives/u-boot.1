Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC66C61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 08:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 621B382BD9;
	Thu, 12 Jun 2025 10:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gFLVFjvA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A7AA82C79; Thu, 12 Jun 2025 10:28:38 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BD1D82BD9
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 10:28:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5C007629E5;
 Thu, 12 Jun 2025 08:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE2EC4CEEA;
 Thu, 12 Jun 2025 08:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749716913;
 bh=AtwfU0iubxMBda1vZg2eA07LURtgVijGGVGCeAcUzJU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gFLVFjvAlTU7ZHrHgTOjfZC2jxXjdMVfiW8yMMMLgpPaE7mAZXvH5R8PIaxFX3Jgz
 7YQy9EtIH1Rf1MAZ0u9giOAoXyqguem2HT6f5TZDzo6VcUqz/fD5mT94gYhLFzACTr
 MVCLN73FtH5xfrxCQCfQ3J9MpMfloMUxbnIlqTKVAsLPu4PXvvuPFKlIUNbDTUz6+Q
 a1ZEMGcuAGmJjsnQ3Y5X/RiIlsG2XOMUEh+dzj0XBGn7/LTgL21FTl/jtZ0oCPiiPr
 CU5ej6CLlimJ+ZRSmUg0YwMPLQ8EgPfCfAqMPfHl2f41/ytcD7aWZ1g7zw/t1S2wiu
 bEezULZbplI4w==
Date: Thu, 12 Jun 2025 13:58:26 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sbabic@nabladev.com, festevam@gmail.com, trini@konsulko.com,
 u-boot@lists.denx.de, uboot-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] imx91: Drop OF_UPSTREAM
Message-ID: <aEqPqrQZAg-4ryju@sumit-X1>
References: <20250612021356.4228-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612021356.4228-1-peng.fan@oss.nxp.com>
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

Hi Peng,

It seems in all your previous postings touching dts/upstream, you never
CCed me which is the case in this one too. Please run
scripts/get_maintainer.pl for your further postings.

On Thu, Jun 12, 2025 at 10:13:56AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX91 device tree still not landed in linux kernel, so drop OF_UPSTREAM
> and move the device tree files to arch/arm/dts
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../arm/dts}/imx91-11x11-evk.dts                |  0
>  .../freescale => arch/arm/dts}/imx91-pinfunc.h  |  0
>  .../arm64/freescale => arch/arm/dts}/imx91.dtsi | 17 -----------------

It is really unfortunate that this DT landed in dts/upstream without
anything in upstream kernel. Direct patching of dts/upstream is not
allowed but you should only be able to do cherry picking as described
here [1].

FWIW:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

[1] https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing

-Sumit

>  arch/arm/mach-imx/imx9/Kconfig                  |  1 -
>  configs/imx91_11x11_evk_defconfig               |  2 +-
>  configs/imx91_11x11_evk_inline_ecc_defconfig    |  2 +-
>  6 files changed, 2 insertions(+), 20 deletions(-)
>  rename {dts/upstream/src/arm64/freescale => arch/arm/dts}/imx91-11x11-evk.dts (100%)
>  rename {dts/upstream/src/arm64/freescale => arch/arm/dts}/imx91-pinfunc.h (100%)
>  rename {dts/upstream/src/arm64/freescale => arch/arm/dts}/imx91.dtsi (79%)
> 
> diff --git a/dts/upstream/src/arm64/freescale/imx91-11x11-evk.dts b/arch/arm/dts/imx91-11x11-evk.dts
> similarity index 100%
> rename from dts/upstream/src/arm64/freescale/imx91-11x11-evk.dts
> rename to arch/arm/dts/imx91-11x11-evk.dts
> diff --git a/dts/upstream/src/arm64/freescale/imx91-pinfunc.h b/arch/arm/dts/imx91-pinfunc.h
> similarity index 100%
> rename from dts/upstream/src/arm64/freescale/imx91-pinfunc.h
> rename to arch/arm/dts/imx91-pinfunc.h
> diff --git a/dts/upstream/src/arm64/freescale/imx91.dtsi b/arch/arm/dts/imx91.dtsi
> similarity index 79%
> rename from dts/upstream/src/arm64/freescale/imx91.dtsi
> rename to arch/arm/dts/imx91.dtsi
> index be923e5076a..9963f0bb5ce 100644
> --- a/dts/upstream/src/arm64/freescale/imx91.dtsi
> +++ b/arch/arm/dts/imx91.dtsi
> @@ -7,7 +7,6 @@
>  #include "imx93.dtsi"
>  
>  /delete-node/ &A55_1;
> -/delete-node/ &cm33;
>  /delete-node/ &mlmix;
>  /delete-node/ &mu1;
>  /delete-node/ &mu2;
> @@ -41,18 +40,6 @@
>  	assigned-clock-rates = <100000000>, <250000000>;
>  };
>  
> -&i3c1 {
> -	clocks = <&clk IMX93_CLK_BUS_AON>,
> -			<&clk IMX93_CLK_I3C1_GATE>,
> -			<&clk IMX93_CLK_DUMMY>;
> -};
> -
> -&i3c2 {
> -	clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
> -			<&clk IMX93_CLK_I3C2_GATE>,
> -			<&clk IMX93_CLK_DUMMY>;
> -};
> -
>  &iomuxc {
>  	compatible = "fsl,imx91-iomuxc";
>  };
> @@ -61,10 +48,6 @@
>  	status = "disabled";
>  };
>  
> -&{/soc@0/ddr-pmu@4e300dc0} {
> -	compatible = "fsl,imx91-ddr-pmu", "fsl,imx93-ddr-pmu";
> -};
> -
>  &{/thermal-zones/cpu-thermal/cooling-maps/map0} {
>  	cooling-device = <&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>  };
> diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
> index e6cafdcd813..280d255c086 100644
> --- a/arch/arm/mach-imx/imx9/Kconfig
> +++ b/arch/arm/mach-imx/imx9/Kconfig
> @@ -43,7 +43,6 @@ config TARGET_IMX91_11X11_EVK
>  	bool "imx91_11x11_evk"
>  	select OF_BOARD_FIXUP
>  	select IMX91
> -	imply OF_UPSTREAM
>  	imply BOOTSTD_FULL
>  	imply BOOTSTD_BOOTCOMMAND
>  
> diff --git a/configs/imx91_11x11_evk_defconfig b/configs/imx91_11x11_evk_defconfig
> index 810a8a8c012..a57c1fd01f5 100644
> --- a/configs/imx91_11x11_evk_defconfig
> +++ b/configs/imx91_11x11_evk_defconfig
> @@ -11,7 +11,7 @@ CONFIG_ENV_SIZE=0x4000
>  CONFIG_ENV_OFFSET=0x700000
>  CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="freescale/imx91-11x11-evk"
> +CONFIG_DEFAULT_DEVICE_TREE="imx91-11x11-evk"
>  CONFIG_TARGET_IMX91_11X11_EVK=y
>  CONFIG_OF_LIBFDT_OVERLAY=y
>  CONFIG_SYS_MONITOR_LEN=524288
> diff --git a/configs/imx91_11x11_evk_inline_ecc_defconfig b/configs/imx91_11x11_evk_inline_ecc_defconfig
> index f330ea694f7..0533acaaa6b 100644
> --- a/configs/imx91_11x11_evk_inline_ecc_defconfig
> +++ b/configs/imx91_11x11_evk_inline_ecc_defconfig
> @@ -11,7 +11,7 @@ CONFIG_ENV_SIZE=0x4000
>  CONFIG_ENV_OFFSET=0x700000
>  CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="freescale/imx91-11x11-evk"
> +CONFIG_DEFAULT_DEVICE_TREE="imx91-11x11-evk"
>  CONFIG_TARGET_IMX91_11X11_EVK=y
>  CONFIG_OF_LIBFDT_OVERLAY=y
>  CONFIG_SYS_MONITOR_LEN=524288
> -- 
> 2.35.3
> 
