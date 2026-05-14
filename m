Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0409ACD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 05:27:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3955080F0E;
	Thu, 14 May 2026 07:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="F4SBMB5x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F5098341A; Thu, 14 May 2026 07:27:30 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1BFF8056B
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 07:27:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1PQ1G+EhvLm3Thov9Ep+u4A4hF8YjhDTobHwXs8OQ2VTjjIlhKcFawXI56u73yG7/WE3ZPb3fobHS+cw4uqtbvQ/PJj01Hdn/aCjhqKdMa/TP79v9XrTEmwwWBJWc15Pnjwo+q51lb/B+v1IMvtChUBrhWxVdlSX8hmk9ExEzZUMktzan/57wHSe1+/Ppej7tyAgzUZ+CoHgIBzVb5/FSYk3bXAC409iQa3nm/ocgcmowHlFXcDH15XFUVbFm9j6VGP+3fyZmEA+rWVEt/EguDLJ+8sjdmZd/69sHTIvOEJrVDUzREtrFNKbtl65C0ap6ie+fOguQStperOqTmy4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3Jmsnlteo04RBTZe+qw08OOMvrZ9z4En+j6LanBkSM=;
 b=Cndf9/FQA4cvAyFWwpqEH9GqY224JXdjh6oJ58vaxRKaVXU8JFLNHX3Jy1JJ7gh7leGrZdxX0pkmMzxBEfn9rUf8r5Dm9DN5Ipl9vccrDU0818DjR9+5JTsvwJqzFLxuKQTwGMZURVJbEs8R5EZpFPs3p1QFyTTmzMcGLz+jMiLCppDGLBQF1OqNNdcTqqiNQ8H3X8FRMNGnmA/C6nxdZdUn3IS/oqNOnvXNJCKyVYMXDuQQy5x9rF9VWdLQgfF0auxHJeVdu1/u1UPy32INtO+47MX3KXokxqRXQ76QC47ISQjDog52w3la5neyZk1JnbEgnhpGM/kjkZOhMUX8aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=groups.io smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3Jmsnlteo04RBTZe+qw08OOMvrZ9z4En+j6LanBkSM=;
 b=F4SBMB5xK+pd8e1I2zKSb+4fxUgkhSYinCMZGiR7HDIX0vHjIuIrUHDsIT3v9AhOY05u6b8AhgftLF+2v3mnWJ2zMocji8mW9k2/DD4lzVB1xrR8OY9Ya0cKtCE1Z8q3KAV/u5i4AwqKNPxCLsDqsnjyvf3E6SEOtc20VFX36TE=
Received: from SJ0PR03CA0143.namprd03.prod.outlook.com (2603:10b6:a03:33c::28)
 by DM4PR10MB6111.namprd10.prod.outlook.com (2603:10b6:8:bf::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Thu, 14 May 2026 05:27:22 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:33c:cafe::5a) by SJ0PR03CA0143.outlook.office365.com
 (2603:10b6:a03:33c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Thu,
 14 May 2026 05:27:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 05:27:22 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 00:27:20 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 00:27:20 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 14 May 2026 00:27:20 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.72.233])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64E5RJjT1010153;
 Thu, 14 May 2026 00:27:20 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 May 2026 10:57:18 +0530
Message-ID: <DII5FZA8ENCM.3KT0XC9C90X2D@ti.com>
Subject: Re: [PATCH] phy: Kconfig: use bool instead of tristate
From: Anshul Dalal <anshuld@ti.com>
To: David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@kernel.org>, "Nobuhiro
 Iwamatsu" <iwamatsu@nigauri.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, "Philipp
 Tomsich" <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>
CC: Julien Stephan <jstephan@baylibre.com>, <u-boot@lists.denx.de>,
 <u-boot-qcom@groups.io>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260513-phy-kconfig-no-tristate-v1-1-c4cbee0c1831@baylibre.com>
In-Reply-To: <20260513-phy-kconfig-no-tristate-v1-1-c4cbee0c1831@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|DM4PR10MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: b9a6f1dd-b93d-40f0-1ace-08deb17979e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|921020|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HIurztE8eoOl/UBxUvt4QZdxE3vKoqyNl/OL+cZLrfhxzw4p82iWetLcMT/RuZ7nG3eMjwTPNc7TbtrEsB4tpxXtjl4Qib33Y7I4SuO9uwJoeKfg+jSHyLC3AX4hUP1NFmbRmI3MGStA3CecuMrKk/uFavBWvwaCNQAxYMKEc6ttzNzz06zgpfvmyrbctYSy2fNVqWjdcjJhRAD6zuow8ze9aAIFexG1+vawr/7atzGsij7/tJK8KHwoOvZtE16ldPVJtoxqcuSlu7cqu4rDdW6jJ7VZHBX3s5fTx+8w7MnLsGcJPs+xeYlQymhYBtWhIBR9ORvb4aJx2nMO9XSjCWe7wSlp9625ILTq4shPNlIxIGv1K11YMmp0r6niq5VAKD1rslNvNpdkzcnA5oETK5naQ58qQ6zwnmXPW9hDKO3MwIcwZlNOeJ5ITuc6XCOdGJ1Dc1N3n5jC8URLkxcpAREaWHO/iQSrBViAFVTl/cuGfrIWVET55fPaR/JpU5X0k9IxhkW76Jrveatkm/jyyaZ5mNfNIABNyVo1Ia1SYcH+5FC7JjDQJxyJ6IQqKTLDF9Sy2paSS2Ykw8BmmsYOE5GIMExD+xQj4ZytZarlsIhkump94TS1xwvCDaCJeSvCxGXvl2be6CpdZeDU9dH/lzmOyTzc+Fyk24I/q3dCeZFggLoIS8df4vHYDjZWDRdsOFCnAnPZtOD6M6EWhOjHW0hHHVT/7yz2uMKlkA3L0/CwUyQVV3VphVdQSUn6zs3jkBpWRo/c5L/TlB6VqVcasg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(921020)(3023799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vF1DSMszZwwrMn4lRc4JXSs7RdQF07EGUp6RQsmehmxv2qBZ06FtTMpGiycmXqE/ftWgfBNsaQFe+GY3Q9a/AQqJ7jU8ie+nUn10JtXRjJvkJ8tlLz+2U9c46qfR7bR1ZukBSSmainDsocRtTojHnm8bmL+CQ6fhRF7AeppRY1wlrz8wb2wYM15f/q9DwrR8R9/LLD1Wq5YI5VdBm9x7OWLgLUqKAc4QCyI6o02f76x9zDrRrw3/aKBPEY6OaTqM1ffmYCRV/1A3t+QcvbuU9yjwW//X/MWV1QuhK8cC12n5hc7VuSu3E7YhN8/QIUHRtzWho91PRKs0FFDZgDi4geAm1srF/Jbs9gy1Ev48wa07jqH/ehVvZOEw+8yR9SZoH2dkMyqKvvMXPLF1CHfzNZZIAjAtv6KpUYf32HVfv1H001ztykuNm6/HlXTl+f7s
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 05:27:22.6027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a6f1dd-b93d-40f0-1ace-08deb17979e3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6111
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

On Wed May 13, 2026 at 7:41 PM IST, David Lechner wrote:
> Change all uses of tristate in the PHY Kconfigs to bool. U-Boot does
> not support modules, so tristate does not make sense here.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Thanks for the fix David, I see the same issue is repeated at other
places outside of PHY:

	% find . -name Kconfig | xargs -I {} grep -HPn '^\ttristate' {} | wc -l
	47

Let me know if you would be interested in doing a treewide cleanup
otherwise I can take this up.

Reviewed-by: Anshul Dalal <anshuld@ti.com>

Thanks,
Anshul

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
> =20
>  config PHY_DA8XX_USB
> -	tristate "TI DA8xx USB PHY Driver"
> +	bool "TI DA8xx USB PHY Driver"
>  	depends on PHY && ARCH_DAVINCI
>  	help
>  	  Enable this to support the USB PHY on DA8xx SoCs.
> @@ -138,7 +138,7 @@ config SPL_PIPE3_PHY
>  	  and omap5
> =20
>  config AM654_PHY
> -	tristate "TI AM654 SERDES support"
> +	bool "TI AM654 SERDES support"
>  	depends on PHY && ARCH_K3
>  	select REGMAP
>  	select SYSCON
> @@ -155,7 +155,7 @@ config STI_USB_PHY
>  	  STiH407 SoC families.
> =20
>  config PHY_RCAR_GEN2
> -	tristate "Renesas R-Car Gen2 USB PHY"
> +	bool "Renesas R-Car Gen2 USB PHY"
>  	depends on PHY && RCAR_GEN2
>  	help
>  	  Support for the Renesas R-Car Gen2 USB PHY. This driver operates the
> @@ -163,7 +163,7 @@ config PHY_RCAR_GEN2
>  	  allows configuring the module multiplexing.
> =20
>  config PHY_RCAR_GEN3
> -	tristate "Renesas R-Car Gen3 USB PHY"
> +	bool "Renesas R-Car Gen3 USB PHY"
>  	depends on PHY && CLK && DM_REGULATOR && (RCAR_GEN3 || RZG2L)
>  	default y if (RCAR_GEN3 || RZG2L)
>  	help
> @@ -171,7 +171,7 @@ config PHY_RCAR_GEN3
>  	  PHY connected to EHCI USB module and controls USB OTG operation.
> =20
>  config PHY_STM32_USBPHYC
> -	tristate "STMicroelectronics STM32 SoC USB HS PHY driver"
> +	bool "STMicroelectronics STM32 SoC USB HS PHY driver"
>  	depends on PHY && ARCH_STM32MP
>  	help
>  	  Enable this to support the High-Speed USB transceiver that is part of
> @@ -283,7 +283,7 @@ config PHY_MTK_TPHY
>  	  so you can easily distinguish them by banks layout.
> =20
>  config PHY_MTK_UFS
> -	tristate "MediaTek UFS M-PHY driver"
> +	bool "MediaTek UFS M-PHY driver"
>  	depends on ARCH_MEDIATEK
>  	depends on PHY
>  	help
> @@ -337,7 +337,7 @@ config PHY_IMX8M_PCIE
>  	  This PHY is found on i.MX8M devices supporting PCIe.
> =20
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
> =20
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
> =20
>  config PHY_QCOM_IPQ4019_USB
> -	tristate "Qualcomm IPQ4019 USB PHY driver"
> +	bool "Qualcomm IPQ4019 USB PHY driver"
>  	depends on PHY && ARCH_IPQ40XX
>  	help
>  	  Support for the USB PHY-s on Qualcomm IPQ40xx SoC-s.
> @@ -21,26 +21,26 @@ config PHY_QCOM_QMP_COMBO
>  	  PHY (USB3 + DisplayPort). Currently only USB3 mode is supported.
> =20
>  config PHY_QCOM_QMP_PCIE
> -	tristate "Qualcomm QMP PCIe PHY driver"
> +	bool "Qualcomm QMP PCIe PHY driver"
>  	depends on PHY && ARCH_SNAPDRAGON
>  	help
>  	  Enable this to support the PCIe QMP PHY on various Qualcomm chipsets.
> =20
>  config PHY_QCOM_QMP_UFS
> -	tristate "Qualcomm QMP UFS PHY driver"
> +	bool "Qualcomm QMP UFS PHY driver"
>  	depends on PHY && ARCH_SNAPDRAGON
>  	help
>  	  Enable this to support the UFS QMP PHY on various Qualcomm chipsets.
> =20
>  config PHY_QCOM_QUSB2
> -	tristate "Qualcomm USB QUSB2 PHY driver"
> +	bool "Qualcomm USB QUSB2 PHY driver"
>  	depends on PHY && ARCH_SNAPDRAGON
>  	help
>  	  Enable this to support the Super-Speed USB transceiver on various
>  	  Qualcomm chipsets.
> =20
>  config PHY_QCOM_USB_SNPS_FEMTO_V2
> -	tristate "Qualcomm SNPS FEMTO USB HS PHY v2"
> +	bool "Qualcomm SNPS FEMTO USB HS PHY v2"
>  	depends on PHY && ARCH_SNAPDRAGON
>  	help
>  	  Enable this to support the Qualcomm Synopsys DesignWare Core 7nm
> @@ -48,7 +48,7 @@ config PHY_QCOM_USB_SNPS_FEMTO_V2
>  	  is usually paired with Synopsys DWC3 USB IPs on MSM SOCs.
> =20
>  config PHY_QCOM_SNPS_EUSB2
> -	tristate "Qualcomm Synopsys eUSB2 High-Speed PHY"
> +	bool "Qualcomm Synopsys eUSB2 High-Speed PHY"
>  	depends on PHY && ARCH_SNAPDRAGON
>  	help
>  	  Enable this to support the Qualcomm Synopsys DesignWare eUSB2
> @@ -56,7 +56,7 @@ config PHY_QCOM_SNPS_EUSB2
>  	  is usually paired with Synopsys DWC3 USB IPs on MSM SOCs.
> =20
>  config PHY_QCOM_USB_HS_28NM
> -	tristate "Qualcomm 28nm High-Speed PHY"
> +	bool "Qualcomm 28nm High-Speed PHY"
>  	depends on PHY && ARCH_SNAPDRAGON
>  	help
>  	  Enable this to support the Qualcomm Synopsys DesignWare Core 28nm
> @@ -65,7 +65,7 @@ config PHY_QCOM_USB_HS_28NM
>  	  IPs on MSM SOCs.
> =20
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
> =20
>  config PHY_R8A779F0_ETHERNET_SERDES
> -	tristate "Renesas R-Car S4-8 Ethernet SERDES driver"
> +	bool "Renesas R-Car S4-8 Ethernet SERDES driver"
>  	depends on RCAR_64 && PHY
>  	help
>  	  Support for Ethernet SERDES found on Renesas R-Car S4-8 SoCs.
> =20
>  config PHY_R8A78000_ETHERNET_PCS
> -	tristate "Renesas R-Car X5H Ethernet PCS driver"
> +	bool "Renesas R-Car X5H Ethernet PCS driver"
>  	depends on RCAR_64 && PHY
>  	help
>  	  Support for Ethernet PCS found on Renesas R-Car X5H SoCs.
> =20
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
> =20
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
> -- =20
> David Lechner <dlechner@baylibre.com>

