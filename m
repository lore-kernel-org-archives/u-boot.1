Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD210D78785
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 14:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C43980077;
	Fri, 19 Dec 2025 15:29:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P0cH9uGh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43D7A803F5; Fri, 19 Dec 2025 15:29:37 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4351A80050
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 15:29:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 382D760008;
 Fri, 19 Dec 2025 14:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91117C4CEF1;
 Fri, 19 Dec 2025 14:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766154573;
 bh=D9HRnLGdZbWS42Q//0jkN45P3wjlAjxwIkLKhKVAfYk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=P0cH9uGhedgtUvBEpuDp/lywIGO16gTuU+mwuUwgFaRMSe94p/9K5UH1GfHHbMLfx
 hFAofcGoHA3aULqw91RMUzeATZ3KA4hwjLom/ROWggC6TFZU9v34F6aP4XENmrLnDc
 8Zhy7p5zw8nI6Izl1c3q/jt/MBoSwzErD3Y1CAbaTE1UgLlB1/F/AalIrXhLhZPBAZ
 eX6h3WmaCcT3XCtV1UcmSNmV79gdzwhTbXxRyUtO95TPuMMVuF1DhgCLjGDwPuD86x
 bbsuse/xZJj882Pdy16sEkhfmucoHBb4CGrUUNCoPzcoMPgU+MdzZpCwzLMZMDoZQa
 o3gYkBAL6l2ow==
Date: Fri, 19 Dec 2025 19:59:24 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, alexeymin@postmarketos.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [RESEND v2 4/6] configs: ipq9574: Enable fastboot support
Message-ID: <aUVhRIWmfRHPnhRV@sumit-xelite>
References: <20251218061557.1999367-1-varadarajan.narayanan@oss.qualcomm.com>
 <20251218061557.1999367-5-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218061557.1999367-5-varadarajan.narayanan@oss.qualcomm.com>
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

On Thu, Dec 18, 2025 at 11:45:55AM +0530, Varadarajan Narayanan wrote:
> Enable relevant configs like USB PHY, gadget, fastboot,
> fastboot MMC support etc. to enable fastboot flashing
> of IPQ9574 based boards.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>  configs/qcom_ipq9574_mmc_defconfig | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/configs/qcom_ipq9574_mmc_defconfig b/configs/qcom_ipq9574_mmc_defconfig
> index 6592d9de39d..ac534738994 100644
> --- a/configs/qcom_ipq9574_mmc_defconfig
> +++ b/configs/qcom_ipq9574_mmc_defconfig
> @@ -45,7 +45,7 @@ CONFIG_DWC_ETH_QOS=y
>  CONFIG_DWC_ETH_QOS_QCOM=y
>  CONFIG_RGMII=y
>  CONFIG_PHY=y
> -CONFIG_PHY_QCOM_QMP_UFS=y

Any reason to drop this?

> +CONFIG_PHY_QCOM_QMP_USB=y
>  CONFIG_PHY_QCOM_QUSB2=y
>  CONFIG_PINCTRL=y
>  CONFIG_PINCONF=y
> @@ -54,3 +54,23 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
>  CONFIG_MSM_SERIAL=y
>  CONFIG_MSM_GENI_SERIAL=y
>  CONFIG_SOC_QCOM=y
> +CONFIG_USB=y
> +CONFIG_USB_GADGET=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_CMD_USB=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GADGET=y
> +CONFIG_MISC=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_FUNCTION_FASTBOOT=y
> +CONFIG_FASTBOOT=y
> +CONFIG_CMD_FASTBOOT=y
> +CONFIG_FASTBOOT_BUF_ADDR=y
> +CONFIG_FASTBOOT_BUF_SIZE=y
> +CONFIG_FASTBOOT_FLASH=y
> +CONFIG_FASTBOOT_FLASH_MMC=y
> +CONFIG_FASTBOOT_FLASH_MMC_DEV=0

> +CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
> +CONFIG_USB_GADGET_PRODUCT_NUM=0xd00d

You should rather try to update following for fastboot:

$ git grep -nr ARCH_QCOM drivers/usb/gadget/Kconfig
drivers/usb/gadget/Kconfig:64:  default 0x18d1 if ARCH_QCOM
drivers/usb/gadget/Kconfig:92:  default 0x4ee0 if ARCH_QCOM

> +CONFIG_FASTBOOT_BUF_ADDR=0x50000000
> +CONFIG_FASTBOOT_BUF_SIZE=0x4000000

-Sumit

> -- 
> 2.34.1
> 
