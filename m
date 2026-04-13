Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C79F34C4E
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 13:49:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC28384239;
	Mon, 13 Apr 2026 15:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NYRUP7Nu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B0FE83DC9; Mon, 13 Apr 2026 14:39:52 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CC5A839D5
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 14:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1B87D6132D;
 Mon, 13 Apr 2026 12:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B9DC2BCAF;
 Mon, 13 Apr 2026 12:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776083988;
 bh=tNO3C0lYFc7dP/Jruyk6n08lwjOHJbeZTK3LUbzu03c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NYRUP7NuypF+94Eo7YpbUaWPjAx1UpxPRQ4z69kxCuWc37A+HF4pr0iwoFiSIlsX9
 h0WlRj4F+dGq5dfNK5eZZKz3R/zPPecGGMFHgnc9M0CH7vmJFHlPdSt6bp0qsRuoTN
 i3ibkFVZ8KZ0wt/gtfcocdTsYDYTCWePZjVDeLEvD3gWYzaMud7Q4z+jfoCKrHILS5
 Pta6ek0+7VU/1OGadPkb/fpUx980EhX/sb5qVFn3W0uUd9O0TmUw3wdROWHFMxQS5M
 LzTRvHrJcQz2sXQQewou3TEMGlDENwpn+owhsp+ukGMZCLgJKT19TdSYI6a1y6Gzl5
 l5ET3GhlRHJlA==
Date: Mon, 13 Apr 2026 18:09:32 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Javier Tia <javier.tia@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Dhruva Gole <d-gole@ti.com>, Richard Genoud <richard.genoud@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH 3/4] drivers: phy: qcom: Add UFS PHY support for SPL
Message-ID: <adzkBMFuvjfxVQth@sumit-xelite>
References: <20260409-spl_ufs_only-v1-0-f7e0e243d805@oss.qualcomm.com>
 <20260409-spl_ufs_only-v1-3-f7e0e243d805@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409-spl_ufs_only-v1-3-f7e0e243d805@oss.qualcomm.com>
X-Mailman-Approved-At: Mon, 13 Apr 2026 15:49:01 +0200
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

On Thu, Apr 09, 2026 at 08:13:33PM +0530, Balaji Selvanathan wrote:
> Enable Qualcomm QMP UFS PHY driver for SPL. This is required for
> UFS boot support in SPL on Qualcomm platforms.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  drivers/phy/qcom/Kconfig  | 7 +++++++
>  drivers/phy/qcom/Makefile | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
> index 0dd69f7ffd0..e5541fd3edc 100644
> --- a/drivers/phy/qcom/Kconfig
> +++ b/drivers/phy/qcom/Kconfig
> @@ -24,6 +24,13 @@ config PHY_QCOM_QMP_UFS
>  	help
>  	  Enable this to support the UFS QMP PHY on various Qualcomm chipsets.
>  
> +config SPL_PHY_QCOM_QMP_UFS
> +	bool "Qualcomm QMP UFS PHY driver in SPL"
> +	depends on SPL_PHY && ARCH_SNAPDRAGON
> +	help
> +	  Enable this to support the UFS QMP PHY in SPL on various Qualcomm chipsets.
> +	  This is required for UFS boot support in SPL.
> +
>  config PHY_QCOM_QUSB2
>  	tristate "Qualcomm USB QUSB2 PHY driver"
>  	depends on PHY && ARCH_SNAPDRAGON
> diff --git a/drivers/phy/qcom/Makefile b/drivers/phy/qcom/Makefile
> index 1c4e7d8d391..a91c5377ac4 100644
> --- a/drivers/phy/qcom/Makefile
> +++ b/drivers/phy/qcom/Makefile
> @@ -1,7 +1,7 @@
>  obj-$(CONFIG_PHY_QCOM_IPQ4019_USB) += phy-qcom-ipq4019-usb.o
>  obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
>  obj-$(CONFIG_PHY_QCOM_QMP_PCIE) += phy-qcom-qmp-pcie.o
> -obj-$(CONFIG_PHY_QCOM_QMP_UFS) += phy-qcom-qmp-ufs.o
> +obj-$(CONFIG_$(PHASE_)PHY_QCOM_QMP_UFS) += phy-qcom-qmp-ufs.o
>  obj-$(CONFIG_PHY_QCOM_QUSB2) += phy-qcom-qusb2.o
>  obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2) += phy-qcom-snps-femto-v2.o
>  obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2) += phy-qcom-snps-eusb2.o
> 
> -- 
> 2.34.1
> 
