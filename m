Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5CCCD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 11:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F6DF84881;
	Mon,  1 Jun 2026 13:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FDSpseNz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCDFC84884; Mon,  1 Jun 2026 13:59:21 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45FFE8487F
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 13:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwV4II3npE+HhGOgGdebaAwYCFqJrLylwJiTuPeBIIJVIH1QLvtG0AoP6wuS5Sev9afmXU77NR6UT7Er5T+01x5JYEnKSStIxmoCEpBicuYIIMUz5sbCTKR9STEqXWP3cRzQ2OXBUtpAjVX6yEqAE+qR9CHv0HcmYNrIOjEMYCiZfQQyMCFLjbssGCuJ8Otm6j0pPRFQgRGlxtqLhqhDT0zViLNmmBVhHAj6GQyTZcAKrg3laiKzu+hVltZHQdMuXJgiRdT939dkDX+Lg10EjmUxGxDIwVIW+AAOUnEQ1I5MvglrVMFGlozI0FTkN1GAUIGC+wYGTL6sKwjv5sOsIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tu1YlxkCD2lAzCNhUh7Ef/w0g/LcW1aRFcfdEWg75+c=;
 b=ltY3qtaoy6SKXTh/0pATKdoFWrWXDfWh5MY+5cKN+uYBXUFB0s1AIsmWI37X8w5h6MOv5A2n8xO5hOgsGjKm/tgFe9vgqWnXJ7+KciuczjYdZD0+utIHSllRG6wsLN+JUEwkFA+v+s33FG2EfDjPTpSA/zNsDJq414V591AdVRFpwFit316FrgJLynZGsdR8HLbje4VZVH7mRrhk1hnPliEFUPPUmPun1A/kyGWuQoTZ0XZa8N3LNRLjF4XXUVAXpwjJd3e1P3Y86sqDjzsBAQjZztsM/dVEU2QEfwStc8bx9ofJfLq+UFANKcri+qAYTKb6W5SlGpcYFvorejToSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tu1YlxkCD2lAzCNhUh7Ef/w0g/LcW1aRFcfdEWg75+c=;
 b=FDSpseNzKcJo9PKwAS3YBGsaUtohwTQlUyftoPuZADH1Eji8lHmf2kaAJRwO3nFjhQgnUxOk/LY6XJxQ4m4Xihiw4x7F7r8wXE2ui/lfr7iXXBx2tmw4zUS5qae1uY0PQp+d+odvDY9OohQIDIkkrDCWzSyuHdDnfr0rtbdCwWI=
Received: from BN9PR03CA0737.namprd03.prod.outlook.com (2603:10b6:408:110::22)
 by SJ0PR10MB4575.namprd10.prod.outlook.com (2603:10b6:a03:2da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 11:59:13 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:110:cafe::c) by BN9PR03CA0737.outlook.office365.com
 (2603:10b6:408:110::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 11:59:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 11:59:12 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 06:59:12 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 06:59:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 1 Jun 2026 06:59:12 -0500
Received: from [10.24.50.20] (moteen-ubuntu-desk.dhcp.ti.com [10.24.50.20])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 651BxAVh967510;
 Mon, 1 Jun 2026 06:59:10 -0500
Message-ID: <fed224e6-4e0a-499d-beb6-bb7c644a0b8f@ti.com>
Date: Mon, 1 Jun 2026 17:29:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] BeaglePlay: enable IT66121 HDMI bridge and video
 stack
To: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>, <u-boot@lists.denx.de>
CC: <jd@ti.com>, <trini@konsulko.com>, <sjg@chromium.org>
References: <20260421132103.30033-1-ssrane_b23@ee.vjti.ac.in>
 <20260421132103.30033-3-ssrane_b23@ee.vjti.ac.in>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <20260421132103.30033-3-ssrane_b23@ee.vjti.ac.in>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|SJ0PR10MB4575:EE_
X-MS-Office365-Filtering-Correlation-Id: c8dbc9b9-cc3c-4737-ca26-08debfd5329b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: 2TpJNegIbFIAadt2YazvZtnK/swC3LcGygmDg2Bw5eHQYc+ix0ym0I7U2QyrWV1S7+gFwUir1RkBf7xjpPYi0R/bOKz/eE4oXPQaALm2mI2dwRq8XRGOM2J5x4Q6iI3LfFhGWCRc0EwbZJ4/YQVsA8ewl2ulmcBkm0NCEwDvX8SGmWYCCnnIsJdB0eM0Uxa4lhkAlE3hThlFyITbdLeRZNRJHPuW4oRo5WmfEJ6GKtuhRGSuAvYOTxGr57yCmy70zoDwkyjRqah5tph7LWexjR/w/ps6bKFPHuEjnBW1gNcZWpuZk6hs49XXd/ZksPrtrNIpkPp78c4JpQHDOXmyQJVOJMYPN89Wn0XIaukzbxUzcmD6Hqw4Kk0fecasNLhyV5IDY2DbNMpp4NrQHE7WEpYgIAS9KwX94xOkGApittoQepzkCuj9G5Nk2lFyrZjEB9oaP5Mkk3oxsb2AXovnl5RthpTVP656+E/pQu7pGxEMXqou1Hk0WtRBVLbeUQ8VMviHgxxbnkhWRSGaG+g1Wdm5rFO28Z7AdZZ35wAfzAiZYrDCF+2SvJOhIkCg++N61PZm2nfwF0zZc8/xFXhSkEdJJGMFlI39Yce0O46Wjm/Tq6p/p7VGEFdxaniHoGlSVcrmCAsJbHA+UMPOddPmVrfltaR6ZyvUDFHqiKJLJKqw3vd/ipfsd7W9c3IzePvgZZKjCnGywv9ZhKiqKNig8t6KiY3oGbTPNw54NbEh1HloZGTVGsAkRy2wkt8UIhyZ
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RvGOmdY38NQgJ12YLTsJwnpzMYQtisJv5NrAhrvB3p1HK5GnH3+tHnzKewZUL8BMvVDB6nNUD5q5kkNwQBJELky984OKa2NW6BXba1BOgnyBUz3sctIXuNra5mbRbD/9izH8WJL8D+db7CrpyrQStjjfMo4QRWEyv0pfY1BbV6WtFn42a5d6WgFsyEPvxJvqaZJbuo59Aiy5vW/P3VjMcakkhvIarhKwtPRYQJlIHsX7mqyl2f91QTAA2KSUtQ5DmNFVpy/zql9U2h/bCsltIKs1O8b/PJ9o0jE/ZUFHQmP1SGBai4/73SJDtW5lsbhqk4BWHB+HTC2KndJQD8hItNUw3B60yRQhrTx6uN2w0J9Di8YnQ59zpJ9Qde3rBr05BCoiUA9opWLL0VcxHMGw+O+52CT/8hcZqfLycMGXoPL54HnA1rMTRCnpsBZPQBc4
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:59:12.9980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8dbc9b9-cc3c-4737-ca26-08debfd5329b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4575
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

Hey Shaurya,

On 21/04/26 18:51, Shaurya Rane wrote:
> Bring in DTS bootph-all tags for the DSS, I2C2, HDMI bridge and
> pinmux nodes, plus defconfig options for TIDSS, VIDEO_BRIDGE_ITE_IT66121,
> BMP and splash screen support.
>
> Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> Changes in v3:
>   - No functional changes; carry Reviewed-by tag from Simon Glass.
>
> Changes in v2:
>   - Split out of the original patch; add bootph-all DT fragments
>     alongside the defconfig options enabling TIDSS, the IT66121
>     bridge driver, and splash-screen/BMP support.
>
>   arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 42 ++++++++++++++++++++
>   configs/am62x_beagleplay_a53_defconfig       | 13 ++++++
>   2 files changed, 55 insertions(+)
>
> diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> index 2a4f0e45365..b1ba62c20ad 100644
> --- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> @@ -322,3 +322,45 @@
>   &cpsw_port2 {
>   	status = "disabled";
>   };
> +
> +/* ===== Display / HDMI support for U-Boot splash screen ===== */
> +
> +&main_pmx0 {
> +	bootph-all;

I don't think that you have to mention bootph-all in the parent node 
here as it is implied by the subnode(s) already below.

Refer [0] for more context.

> +
> +	dss0_pins_default {
> +		bootph-all;
> +	};
> +
> +	hdmi_gpio_pins_default {
> +		bootph-all;
> +	};
> +
> +	i2c2_1v8_pins_default {
> +		bootph-all;
> +	};
> +};
> +
> +&dss {
> +	bootph-all;
> +};
> +
> +&dss_ports {
> +	bootph-all;
> +
> +	port@1 {
> +		bootph-all;
> +	};
> +};
> +
> +&main_i2c2 {
> +	bootph-all;
> +
> +	bridge-hdmi@4c {
> +		bootph-all;
> +	};
> +};
> +
> +&main_gpio0 {
> +	bootph-all;
> +};
> diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
> index c9bc7cd8d39..bb4be38537c 100644
> --- a/configs/am62x_beagleplay_a53_defconfig
> +++ b/configs/am62x_beagleplay_a53_defconfig
> @@ -121,6 +121,19 @@ CONFIG_EXT4_WRITE=y
>   CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
>   CONFIG_LZO=y
>   CONFIG_EFI_SET_TIME=y
> +CONFIG_DM_VIDEO=y
> +CONFIG_VIDEO=y
> +CONFIG_VIDEO_TIDSS=y
> +CONFIG_VIDEO_BRIDGE=y
> +CONFIG_VIDEO_BRIDGE_ITE_IT66121=y
> +CONFIG_BACKLIGHT_GPIO=y
> +CONFIG_SYS_WHITE_ON_BLACK=y
> +CONFIG_BMP=y
> +CONFIG_CMD_BMP=y
> +CONFIG_SPLASH_SCREEN=y
> +CONFIG_SPLASH_SCREEN_ALIGN=y
> +CONFIG_VIDEO_LOGO=y
> +CONFIG_I2C_EDID=y

Nitpick: This should come in alphabetical order, I think.

[0] https://lore.kernel.org/all/20250516114148.3862114-1-m-shah@ti.com/ 
for more context

Regards,
Moteen

>   
>   #include <configs/k3_efi_capsule.config>
>   #include <configs/am62x_a53_usbdfu.config>
