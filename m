Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A83EE57DF
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 13:21:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DA8A86D9C;
	Mon, 11 Sep 2023 15:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Q0ADj49W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43C3086DBD; Mon, 11 Sep 2023 15:21:26 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B98B86CC4
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 15:21:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BDLKFJ000661;
 Mon, 11 Sep 2023 08:21:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694438480;
 bh=Gx2D2PfZj3wGRgQVDNhLYGkvGxhcl6fRx0OUw/zkxM4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Q0ADj49Wc7kS2nyYtDINcjgQRwvWac+nL5XEXy/D6Lb8pswaiRoKPV2PBlULxbkTe
 JkaZMQS4S6hOBS6qlaAHCeg/sYvdEzunk27q3eBNnsLN1SnHjjNGMJXJ6J3+LVG8wD
 DPIEKzTqkK2LPVTLwl5JxGzM5jEikLTE9TdVUpzM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BDLKl0030233
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 11 Sep 2023 08:21:20 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 08:21:20 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 08:21:20 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BDLK0E016245;
 Mon, 11 Sep 2023 08:21:20 -0500
Date: Mon, 11 Sep 2023 08:21:20 -0500
From: Nishanth Menon <nm@ti.com>
To: Udit Kumar <u-kumar1@ti.com>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>,
 <n-francis@ti.com>, <a-nandan@ti.com>
Subject: Re: [PATCH] config: j7200: removed not needed power config
Message-ID: <20230911132120.otpxghrp27gtdr3a@filled>
References: <20230911111946.749270-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230911111946.749270-1-u-kumar1@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 16:49-20230911, Udit Kumar wrote:
> For J7200, R5/SPL TI_SCI_POWER_DOMAIN should be
> disabled as DM is a separate binary like other
> SOC of J7* family.
> 
> Fixes: 02dff65efe7 (configs: j7200_evm_r5: Add initial support)
> 
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
> Boot logs
> https://gist.github.com/uditkumarti/04f053efa73eae8be53666d9a31033c2
> 
>  configs/j7200_evm_r5_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
> index 6d240b16cb..9e744ba434 100644
> --- a/configs/j7200_evm_r5_defconfig
> +++ b/configs/j7200_evm_r5_defconfig
> @@ -126,7 +126,6 @@ CONFIG_SPL_PINCTRL=y
>  # CONFIG_SPL_PINCTRL_GENERIC is not set
>  CONFIG_PINCTRL_SINGLE=y
>  CONFIG_POWER_DOMAIN=y
> -CONFIG_TI_SCI_POWER_DOMAIN=y
>  CONFIG_TI_POWER_DOMAIN=y
>  CONFIG_DM_PMIC=y
>  CONFIG_PMIC_TPS65941=y
> -- 
> 2.34.1
> 

And maybe expand this patch so that it contains something like the
following to prevent this from coming back again elsewhere?

diff --git a/drivers/clk/ti/Kconfig b/drivers/clk/ti/Kconfig
index fbcdefd889ae..aff1ba5ab43b 100644
--- a/drivers/clk/ti/Kconfig
+++ b/drivers/clk/ti/Kconfig
@@ -36,7 +36,7 @@ config CLK_TI_MUX
 
 config CLK_TI_SCI
 	bool "TI System Control Interface (TI SCI) clock driver"
-	depends on CLK && TI_SCI_PROTOCOL && OF_CONTROL
+	depends on CLK && TI_SCI_PROTOCOL && OF_CONTROL && !CLK_K3
 	help
 	  This enables the clock driver support over TI System Control Interface
 	  available on some new TI's SoCs. If you wish to use clock resources
@@ -44,24 +44,24 @@ config CLK_TI_SCI
 
 config CLK_K3_PLL
 	bool "PLL clock support for K3 SoC family of devices"
-	depends on CLK && LIB_RATIONAL
+	depends on CLK && LIB_RATIONAL && !CLK_TI_SCI
 	help
 	  Enables PLL clock support for K3 SoC family of devices.
 
 config SPL_CLK_K3_PLL
 	bool "PLL clock support for K3 SoC family of devices"
-	depends on CLK && LIB_RATIONAL && SPL
+	depends on CLK && LIB_RATIONAL && SPL && !CLK_TI_SCI
 	help
 	  Enables PLL clock support for K3 SoC family of devices.
 
 config CLK_K3
 	bool "Clock support for K3 SoC family of devices"
-	depends on CLK
+	depends on CLK && !CLK_TI_SCI
 	help
 	  Enables the clock translation layer from DT to device clocks.
 
 config SPL_CLK_K3
 	bool "Clock support for K3 SoC family of devices"
-	depends on CLK && SPL
+	depends on CLK && SPL && !CLK_TI_SCI
 	help
 	  Enables the clock translation layer from DT to device clocks.
diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index 411c210756a3..9625764b304b 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -92,14 +92,14 @@ config TEGRA186_POWER_DOMAIN
 
 config TI_SCI_POWER_DOMAIN
 	bool "Enable the TI SCI-based power domain driver"
-	depends on POWER_DOMAIN && TI_SCI_PROTOCOL
+	depends on POWER_DOMAIN && TI_SCI_PROTOCOL && !TI_POWER_DOMAIN
 	help
 	  Generic power domain implementation for TI devices implementing the
 	  TI SCI protocol.
 
 config TI_POWER_DOMAIN
 	bool "Enable the TI K3 Power domain driver"
-	depends on POWER_DOMAIN && ARCH_K3
+	depends on POWER_DOMAIN && ARCH_K3 && !TI_SCI_POWER_DOMAIN
 	help
 	  Generic power domain implementation for TI K3 devices.
 
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
