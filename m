Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EE6CD4F48
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 08:04:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B38B083FEE;
	Mon, 18 May 2026 10:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sc+zEChH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED83884664; Mon, 18 May 2026 10:04:11 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1A5083AA9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 10:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso21047155e9.0
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 01:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779091449; x=1779696249; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uy/idly42kVMJVVnQuouSrmMtXGNt/cLGbamR2yqOsc=;
 b=sc+zEChHVoC853CBPN3Gx5lKUzVlb7X+5amvXFJ6wlAbe8Ge7c0FPb7GP8Muriml5K
 3RUw3QkiJIZuPkdfKhbo44F9+ec8jXoMa+xfVGmBJ9dq9+1VfgQPTJ2iE9Qg9HpsE62F
 K22aW4AF6ntQqnm/1ES/fiIKZZeJNoYLfuv3W+o/s8eiTWnJ1kBmyO6ZGCUPm9WbMcmn
 iVi1iTKrIlbDtX+c4eQ5JFJ5fFzLZEWThNOTkkblMYGCV1EBZf4dDHlfZECkXc8LK3wr
 4KXlebH8194l9HtFzPGCn0xOpBHACm+xTJZlqNqetTQGsApws6eEwlAN0p94MqOTwU1N
 jE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779091449; x=1779696249;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uy/idly42kVMJVVnQuouSrmMtXGNt/cLGbamR2yqOsc=;
 b=Bwg1OYcoXeC3aPngF9RXqheUUIc8F30cy7Ue2NJOnJAkFA1WCAqGXzX7v3CbW/sj/P
 MsIVzggzPd3SFuuw1k39r3RXPngc38ejBg/ddXXy4K0cZgNe3CWnNE43pijzUzyj+3fb
 pzjzW2OU+zIkjCp1p8bx8cBE+IUToBtAbx/BNc/QRbzEoqgBsWKe0edHzPWFEDS5WxuA
 Ho48y0hh0fLULXdyKXH4Rs5BFkcId0uSDn5b5A933utfC0zItmzST4GHeN0YzYdSxcws
 PY/WSy9LYGm83wHT8gVStqMeul6BFis+APTyneHMWmyFLwbQvsPafRc/gfPRso+Wvb0x
 URuQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Te7oL4vyWA9WDHOp1nu4favdPfvHtJk4OLGPixJ8WDNaEqS+xozvvO6nMDNZII7uu4jCC6Cg=@lists.denx.de
X-Gm-Message-State: AOJu0Yzr4oYI6B76qxO8PoJ6JGeVf0cmH0wjzak+OCzHhFhm3+eyUbF/
 dCvXYsM7pxlJ2xwZyfi1rOeWkUof6w7v6VgkxRUToNbUzmvBQ560IdWffEYaFranSU8=
X-Gm-Gg: Acq92OEcrcgUMV1GxUIC6NOFojS1BhykQM9/7TLSikUwCR08Xc0i+yd/rdLwwPuOZ+0
 XO2lhM3B2xrYQdK/3epfC8Jv5x1xSVydw3msw1i1g/WWF6Yq3frezwcIYotkIxOkbpAt5LVjKTm
 +szQVlerCg0YXaR71c4G6Fy648Z88jNQpo0/gxWpEZA/3N6StGwfJAoNUOWknzLT4Nin8cHZQG0
 VsuakHt+ndIpUbZ+7Zavt1hYN2oEoUqLTSXswct7uYAL4x4fxI72f7hXmsrEaKhBPMlXfhfLHLx
 geZOvgD3NGWFGDH9wjN+Ral71NMptkCEcxQpTCduvkS/QuyxvfMYXJ6GDhOinLU6nlOVe2c+zkl
 g2ooNmqViRrkukbkbal3o9XEELWcnkQvpTMxVF/+DSIs5H1OCiFTtq43rQWBWrL2Hh3wwSv4hiC
 HOjTKAwn21QhDw9mTzSW8LvIrrO8zhtZdiLOsLMX2b9fhD+ZCA963G7SOFd9B+RQbjYQ==
X-Received: by 2002:a05:600c:4fc9:b0:489:1c1f:35df with SMTP id
 5b1f17b1804b1-48fe60e58ecmr194372355e9.10.1779091447893; 
 Mon, 18 May 2026 01:04:07 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fea52a0bfsm111640955e9.0.2026.05.18.01.04.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 01:04:07 -0700 (PDT)
Message-ID: <88fbf22d-f5ef-46c6-affa-ba4f2b0eaf55@linaro.org>
Date: Mon, 18 May 2026 10:04:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: Kconfig: use bool instead of tristate
Content-Language: en-US
To: David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20260513-phy-kconfig-no-tristate-v1-1-c4cbee0c1831@baylibre.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260513-phy-kconfig-no-tristate-v1-1-c4cbee0c1831@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 13/05/2026 16:11, David Lechner wrote:
> Change all uses of tristate in the PHY Kconfigs to bool. U-Boot does
> not support modules, so tristate does not make sense here.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  drivers/phy/Kconfig          | 14 +++++++-------
>  drivers/phy/cadence/Kconfig  |  4 ++--
>  drivers/phy/qcom/Kconfig     | 16 ++++++++--------
>  drivers/phy/renesas/Kconfig  |  6 +++---
>  drivers/phy/rockchip/Kconfig |  2 +-
>  drivers/phy/ti/Kconfig       |  2 +-
>  6 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 5c8ec2b146f..eafa82fe494 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -114,7 +114,7 @@ config BCM_SR_PCIE_PHY
>  	  If unsure, say N.
>  
>  config PHY_DA8XX_USB
> -	tristate "TI DA8xx USB PHY Driver"
> +	bool "TI DA8xx USB PHY Driver"
>  	depends on PHY && ARCH_DAVINCI
>  	help
>  	  Enable this to support the USB PHY on DA8xx SoCs.
> @@ -138,7 +138,7 @@ config SPL_PIPE3_PHY
>  	  and omap5
>  
>  config AM654_PHY
> -	tristate "TI AM654 SERDES support"
> +	bool "TI AM654 SERDES support"
>  	depends on PHY && ARCH_K3
>  	select REGMAP
>  	select SYSCON
> @@ -155,7 +155,7 @@ config STI_USB_PHY
>  	  STiH407 SoC families.
>  
>  config PHY_RCAR_GEN2
> -	tristate "Renesas R-Car Gen2 USB PHY"
> +	bool "Renesas R-Car Gen2 USB PHY"
>  	depends on PHY && RCAR_GEN2
>  	help
>  	  Support for the Renesas R-Car Gen2 USB PHY. This driver operates the
> @@ -163,7 +163,7 @@ config PHY_RCAR_GEN2
>  	  allows configuring the module multiplexing.
>  
>  config PHY_RCAR_GEN3
> -	tristate "Renesas R-Car Gen3 USB PHY"
> +	bool "Renesas R-Car Gen3 USB PHY"
>  	depends on PHY && CLK && DM_REGULATOR && (RCAR_GEN3 || RZG2L)
>  	default y if (RCAR_GEN3 || RZG2L)
>  	help
> @@ -171,7 +171,7 @@ config PHY_RCAR_GEN3
>  	  PHY connected to EHCI USB module and controls USB OTG operation.
>  
>  config PHY_STM32_USBPHYC
> -	tristate "STMicroelectronics STM32 SoC USB HS PHY driver"
> +	bool "STMicroelectronics STM32 SoC USB HS PHY driver"
>  	depends on PHY && ARCH_STM32MP
>  	help
>  	  Enable this to support the High-Speed USB transceiver that is part of
> @@ -283,7 +283,7 @@ config PHY_MTK_TPHY
>  	  so you can easily distinguish them by banks layout.
>  
>  config PHY_MTK_UFS
> -	tristate "MediaTek UFS M-PHY driver"
> +	bool "MediaTek UFS M-PHY driver"
>  	depends on ARCH_MEDIATEK
>  	depends on PHY
>  	help
> @@ -337,7 +337,7 @@ config PHY_IMX8M_PCIE
>  	  This PHY is found on i.MX8M devices supporting PCIe.
>  
>  config PHY_XILINX_ZYNQMP
> -	tristate "Xilinx ZynqMP PHY driver"
> +	bool "Xilinx ZynqMP PHY driver"
>  	depends on PHY && ARCH_ZYNQMP
>  	help
>  	  Enable this to support ZynqMP High Speed Gigabit Transceiver
> diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
> index 8c0ab80fbbc..f5f096889fe 100644
> --- a/drivers/phy/cadence/Kconfig
> +++ b/drivers/phy/cadence/Kconfig
> @@ -1,11 +1,11 @@
>  config PHY_CADENCE_SIERRA
> -	tristate "Cadence Sierra PHY Driver"
> +	bool "Cadence Sierra PHY Driver"
>  	depends on DM_RESET
>  	help
>  	  Enable this to support the Cadence Sierra PHY driver
>  
>  config PHY_CADENCE_TORRENT
> -	tristate "Cadence Torrent PHY Driver"
> +	bool "Cadence Torrent PHY Driver"
>  	depends on DM_RESET
>  	help
>  	  Enable this to support the Cadence Torrent PHY driver
> diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
> index 49f830abf01..7094903d869 100644
> --- a/drivers/phy/qcom/Kconfig
> +++ b/drivers/phy/qcom/Kconfig
> @@ -7,7 +7,7 @@ config MSM8916_USB_PHY
>  	  This PHY is found on qualcomm dragonboard410c development board.
>  
>  config PHY_QCOM_IPQ4019_USB
> -	tristate "Qualcomm IPQ4019 USB PHY driver"
> +	bool "Qualcomm IPQ4019 USB PHY driver"
>  	depends on PHY && ARCH_IPQ40XX
>  	help
>  	  Support for the USB PHY-s on Qualcomm IPQ40xx SoC-s.
> @@ -21,26 +21,26 @@ config PHY_QCOM_QMP_COMBO
>  	  PHY (USB3 + DisplayPort). Currently only USB3 mode is supported.
>  
>  config PHY_QCOM_QMP_PCIE
> -	tristate "Qualcomm QMP PCIe PHY driver"
> +	bool "Qualcomm QMP PCIe PHY driver"
>  	depends on PHY && ARCH_SNAPDRAGON
>  	help
>  	  Enable this to support the PCIe QMP PHY on various Qualcomm chipsets.
>  
>  config PHY_QCOM_QMP_UFS
> -	tristate "Qualcomm QMP UFS PHY driver"
> +	bool "Qualcomm QMP UFS PHY driver"
>  	depends on PHY && ARCH_SNAPDRAGON
>  	help
>  	  Enable this to support the UFS QMP PHY on various Qualcomm chipsets.
>  
>  config PHY_QCOM_QUSB2
> -	tristate "Qualcomm USB QUSB2 PHY driver"
> +	bool "Qualcomm USB QUSB2 PHY driver"
>  	depends on PHY && ARCH_SNAPDRAGON
>  	help
>  	  Enable this to support the Super-Speed USB transceiver on various
>  	  Qualcomm chipsets.
>  
>  config PHY_QCOM_USB_SNPS_FEMTO_V2
> -	tristate "Qualcomm SNPS FEMTO USB HS PHY v2"
> +	bool "Qualcomm SNPS FEMTO USB HS PHY v2"
>  	depends on PHY && ARCH_SNAPDRAGON
>  	help
>  	  Enable this to support the Qualcomm Synopsys DesignWare Core 7nm
> @@ -48,7 +48,7 @@ config PHY_QCOM_USB_SNPS_FEMTO_V2
>  	  is usually paired with Synopsys DWC3 USB IPs on MSM SOCs.
>  
>  config PHY_QCOM_SNPS_EUSB2
> -	tristate "Qualcomm Synopsys eUSB2 High-Speed PHY"
> +	bool "Qualcomm Synopsys eUSB2 High-Speed PHY"
>  	depends on PHY && ARCH_SNAPDRAGON
>  	help
>  	  Enable this to support the Qualcomm Synopsys DesignWare eUSB2
> @@ -56,7 +56,7 @@ config PHY_QCOM_SNPS_EUSB2
>  	  is usually paired with Synopsys DWC3 USB IPs on MSM SOCs.
>  
>  config PHY_QCOM_USB_HS_28NM
> -	tristate "Qualcomm 28nm High-Speed PHY"
> +	bool "Qualcomm 28nm High-Speed PHY"
>  	depends on PHY && ARCH_SNAPDRAGON
>  	help
>  	  Enable this to support the Qualcomm Synopsys DesignWare Core 28nm
> @@ -65,7 +65,7 @@ config PHY_QCOM_USB_HS_28NM
>  	  IPs on MSM SOCs.
>  
>  config PHY_QCOM_USB_SS
> -	tristate "Qualcomm USB Super-Speed PHY driver"
> +	bool "Qualcomm USB Super-Speed PHY driver"
>  	depends on PHY && ARCH_SNAPDRAGON
>  	help
>  	  Enable this to support the Super-Speed USB transceiver on various
> diff --git a/drivers/phy/renesas/Kconfig b/drivers/phy/renesas/Kconfig
> index affbee0500c..3358d454e59 100644
> --- a/drivers/phy/renesas/Kconfig
> +++ b/drivers/phy/renesas/Kconfig
> @@ -3,19 +3,19 @@
>  # Phy drivers for Renesas platforms
>  
>  config PHY_R8A779F0_ETHERNET_SERDES
> -	tristate "Renesas R-Car S4-8 Ethernet SERDES driver"
> +	bool "Renesas R-Car S4-8 Ethernet SERDES driver"
>  	depends on RCAR_64 && PHY
>  	help
>  	  Support for Ethernet SERDES found on Renesas R-Car S4-8 SoCs.
>  
>  config PHY_R8A78000_ETHERNET_PCS
> -	tristate "Renesas R-Car X5H Ethernet PCS driver"
> +	bool "Renesas R-Car X5H Ethernet PCS driver"
>  	depends on RCAR_64 && PHY
>  	help
>  	  Support for Ethernet PCS found on Renesas R-Car X5H SoCs.
>  
>  config PHY_R8A78000_MP_PHY
> -	tristate "Renesas R-Car X5H Multi-Protocol PHY driver"
> +	bool "Renesas R-Car X5H Multi-Protocol PHY driver"
>  	depends on RCAR_64 && PHY
>  	help
>  	  Support for Multi-Protocol PHY on Renesas R-Car X5H SoCs.
> diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
> index 80128335d52..6f3d7ebe29e 100644
> --- a/drivers/phy/rockchip/Kconfig
> +++ b/drivers/phy/rockchip/Kconfig
> @@ -49,7 +49,7 @@ config PHY_ROCKCHIP_SNPS_PCIE3
>  	  also be able splited into multiple combinations of lanes.
>  
>  config PHY_ROCKCHIP_USBDP
> -	tristate "Rockchip USBDP COMBO PHY Driver"
> +	bool "Rockchip USBDP COMBO PHY Driver"
>  	depends on ARCH_ROCKCHIP
>  	select PHY
>  	help
> diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
> index df750b26d66..fe96eb6806f 100644
> --- a/drivers/phy/ti/Kconfig
> +++ b/drivers/phy/ti/Kconfig
> @@ -1,5 +1,5 @@
>  config PHY_J721E_WIZ
> -	tristate "TI J721E WIZ (SERDES Wrapper) support"
> +	bool "TI J721E WIZ (SERDES Wrapper) support"
>  	depends on ARCH_K3
>  	help
>  	  This option enables support for WIZ module present in TI's J721E
> 
> ---
> base-commit: e3e651c480c46b332f16a7555b97c6c6fd640a40
> change-id: 20260513-phy-kconfig-no-tristate-61bc2d324149
> 
> Best regards,
> --  
> David Lechner <dlechner@baylibre.com>
> 

-- 
// Casey (she/her)

