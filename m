Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C5AC48BC4
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 13:28:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3D5F87DF2;
	Thu, 15 Feb 2024 14:28:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="BJCl9bT1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B753587DD0; Thu, 15 Feb 2024 13:06:08 +0100 (CET)
Received: from mx0a-00176a03.pphosted.com (mx0a-00176a03.pphosted.com
 [67.231.149.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C5FE87D6D
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 13:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ian.ray@gehealthcare.com
Received: from pps.filterd (m0048274.ppops.net [127.0.0.1])
 by m0048274.ppops.net-00176a03. (8.17.1.24/8.17.1.24) with ESMTP id
 41FBNdfU016700
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 07:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 gehealthcare.com; h=date:from:to:cc:subject:message-id
 :references:mime-version:content-type:in-reply-to; s=outbound;
 bh=BwBTZFQQGL8mL/LYCLNwoB1+d2t0/wt6S5OOIzdvaS0=; b=BJCl9bT1p7UV
 K/NVq/RYvMNr9LXNqnUeCeMDb1+PiKAdJuGVCe4djC+RO3DQXNjR0xlI2p2uohLn
 dfddjqNbrPBu103Fk+Eu9k1on1VtYF+XOHfZzB6Se7g8uB37UZEtARktgg3qFBVj
 9s8lbFpvcWnhiRYP84QEE4YI4RRP+gzvL2ZDrBt8G1OTqFIrJhOy06swIrzByVzU
 NgLwA/OijiYOnNDt9DK8FW479mqn27ZUNU4qTKxXqwr5wRe0qaURwY83suiMGXpS
 m59YBusI+uO2YtpZuROubnb4Tlf2ECmKmVQqZhc8OrPNh8cblscu1pCLs4sOnADI
 s9QBh2q68Q==
Date: Thu, 15 Feb 2024 14:05:18 +0200
From: Ian Ray <ian.ray@gehealthcare.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, ian.ray@ge.com, martyn.welch@collabora.com,
 u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Subject: Re: EXT: [PATCH 1/5] msc_sm2s_imx8mp: Convert to DM_SERIAL
Message-ID: <Zc39_kXIbw0LsCvd@de2cfed78370>
References: <20240213114342.2728075-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213114342.2728075-1-festevam@gmail.com>
X-Proofpoint-ORIG-GUID: _7csO9Hk7dk0BamR-QNwyRBQY522WNLD
X-Proofpoint-GUID: _7csO9Hk7dk0BamR-QNwyRBQY522WNLD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_11,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150097
X-Mailman-Approved-At: Thu, 15 Feb 2024 14:28:40 +0100
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

On Tue, Feb 13, 2024 at 08:43:38AM -0300, Fabio Estevam wrote:
> 
> From: Fabio Estevam <festevam@denx.de>
> 
> The conversion to DM_SERIAL is mandatory, so do the conversion.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Ian Ray <ian.ray@gehealthcare.com> 

> ---
>  arch/arm/dts/imx8mp-msc-sm2s-u-boot.dtsi | 8 ++++++++
>  board/msc/sm2s_imx8mp/spl.c              | 9 ---------
>  configs/msc_sm2s_imx8mp_defconfig        | 1 +
>  include/configs/msc_sm2s_imx8mp.h        | 2 --
>  4 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/dts/imx8mp-msc-sm2s-u-boot.dtsi b/arch/arm/dts/imx8mp-msc-sm2s-u-boot.dtsi
> index c398a743f7..1a7b530d9f 100644
> --- a/arch/arm/dts/imx8mp-msc-sm2s-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mp-msc-sm2s-u-boot.dtsi
> @@ -63,3 +63,11 @@
>  &pmic {
>  	bootph-pre-ram;
>  };
> +
> +&uart2 {
> +	bootph-pre-ram;
> +};
> +
> +&pinctrl_uart2 {
> +	bootph-pre-ram;
> +};
> diff --git a/board/msc/sm2s_imx8mp/spl.c b/board/msc/sm2s_imx8mp/spl.c
> index fed0fbcba1..ed7a1b7d3d 100644
> --- a/board/msc/sm2s_imx8mp/spl.c
> +++ b/board/msc/sm2s_imx8mp/spl.c
> @@ -168,13 +168,6 @@ static const iomux_v3_cfg_t wdog_pads[] = {
>  	MX8MP_PAD_GPIO1_IO02__WDOG1_WDOG_B  | MUX_PAD_CTRL(WDOG_PAD_CTRL),
>  };
>  
> -#define UART_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_FSEL1)
> -
> -static const iomux_v3_cfg_t ser0_pads[] = {
> -	MX8MP_PAD_UART2_RXD__UART2_DCE_RX | MUX_PAD_CTRL(UART_PAD_CTRL),
> -	MX8MP_PAD_UART2_TXD__UART2_DCE_TX | MUX_PAD_CTRL(UART_PAD_CTRL),
> -};
> -
>  int board_early_init_f(void)
>  {
>  	struct wdog_regs *wdog = (struct wdog_regs *)WDOG1_BASE_ADDR;
> @@ -182,8 +175,6 @@ int board_early_init_f(void)
>  	imx_iomux_v3_setup_multiple_pads(wdog_pads, ARRAY_SIZE(wdog_pads));
>  	set_wdog_reset(wdog);
>  
> -	imx_iomux_v3_setup_multiple_pads(ser0_pads, ARRAY_SIZE(ser0_pads));
> -
>  	return 0;
>  }
>  
> diff --git a/configs/msc_sm2s_imx8mp_defconfig b/configs/msc_sm2s_imx8mp_defconfig
> index bf1052db6f..9c27a72f8a 100644
> --- a/configs/msc_sm2s_imx8mp_defconfig
> +++ b/configs/msc_sm2s_imx8mp_defconfig
> @@ -97,6 +97,7 @@ CONFIG_SPL_PMIC_RN5T567=y
>  CONFIG_DM_REGULATOR=y
>  CONFIG_DM_REGULATOR_FIXED=y
>  CONFIG_DM_REGULATOR_GPIO=y
> +CONFIG_DM_SERIAL=y
>  CONFIG_MXC_UART=y
>  CONFIG_SYSRESET=y
>  CONFIG_SPL_SYSRESET=y
> diff --git a/include/configs/msc_sm2s_imx8mp.h b/include/configs/msc_sm2s_imx8mp.h
> index c1c1fd5a78..3c7d96cb3c 100644
> --- a/include/configs/msc_sm2s_imx8mp.h
> +++ b/include/configs/msc_sm2s_imx8mp.h
> @@ -55,8 +55,6 @@
>  #define PHYS_SDRAM_2			0xc0000000
>  #define PHYS_SDRAM_2_SIZE		0x0
>  
> -#define CFG_MXC_UART_BASE		UART2_BASE_ADDR
> -
>  #define CFG_SYS_FSL_USDHC_NUM	2
>  #define CFG_SYS_FSL_ESDHC_ADDR	0
>  
> -- 
> 2.34.1
> 
> 
