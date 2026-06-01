Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C93CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 11:55:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41DBB84884;
	Mon,  1 Jun 2026 13:55:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RzK0VuiN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 488A48488A; Mon,  1 Jun 2026 13:55:36 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A89018487F
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 13:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYydZYvRdkXzD9aOyvbqw843M4OR4fCKvmlmkbYRygUguNVmqBbUtcpMZrmeOmgxsJbrHffzTZPE/hUf6Wl4pSZQstXNvSBkntrSdjkTESs6TvR8oRZFfWgTgrU0fFz58UD7EuAFuPFVL24qL88V6VWhHg+ufHF+5Scwyix2Zdd70Xa017YuIxRXVorbcOn/sf00VHvjFcSA8yGl3E8DrEg9X6MlQ6jCYq5vwJNC1c0ytMe5kzf+gDJI1PIgmNHGji3FcTG5vWb7XjpCv7Qs/AjpGhCuMKXnP6V12Yuw0kHr7sNkuxuYw7yvFlrSOhVROLuP9YPJNkoerWdZwpIrTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXnjBNXyFLTwoLWuV3Gi62uy0/rt/9IpydERBOUOFf8=;
 b=YdP14ePEzrl50n1LIZuLqvo4Od/awRKyMaOrtFxuXFb0SjgMjmGJ6H5iY696Rsq4OhYh1yFV5/+qWgUM7jgGD0D6KXQGgGSX7LV6rJKOtI53gwFav3iRhj78S61gWMKZqaLtANv/JWoy2vwFsiM/veFTezp9ESVP3Owdn4SNj0UUNHym+1JOGDH/o9iRQS8aCzyf2hoDPdY+sFlh361RJVpZS2332FpAXGC+k3upxy3Zfl/Q0pYx4boF1ptC7rANEyk9rZw9j1ATbfPm5guRgQZtHOfqH1aCoN0UOAZ2cYm1hopepBx7vAc102IMiKc/FtfcZJIYQ5S6tHuSD8JCzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXnjBNXyFLTwoLWuV3Gi62uy0/rt/9IpydERBOUOFf8=;
 b=RzK0VuiNkxG4rirbX0P5Q4Y4towlqv8BiNljhtIkO1bNPvZZWiGd+kAqgVVb1SgmzCXzDhrLnDX5xAdatsmCphz0N/NnHb4c09vWNi6uJpKta8RQyU/YXO8sVSxs4Tnrm9h1s+jgKgp8QGz9jESDCYUo7OPTdW47M0yrN/ziG/c=
Received: from BN9PR03CA0971.namprd03.prod.outlook.com (2603:10b6:408:109::16)
 by CO1PR10MB4466.namprd10.prod.outlook.com (2603:10b6:303:9b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 11:55:29 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:109:cafe::18) by BN9PR03CA0971.outlook.office365.com
 (2603:10b6:408:109::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.15 via Frontend Transport; Mon, 1
 Jun 2026 11:55:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 11:55:27 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 06:55:17 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 06:55:17 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 1 Jun 2026 06:55:16 -0500
Received: from [10.24.50.20] (moteen-ubuntu-desk.dhcp.ti.com [10.24.50.20])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 651BtEAI1502697;
 Mon, 1 Jun 2026 06:55:15 -0500
Message-ID: <7801f00a-a790-43e7-a1e4-1005383fddee@ti.com>
Date: Mon, 1 Jun 2026 17:25:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] BeaglePlay: enable IT66121 HDMI bridge and video
 stack
To: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>, <u-boot@lists.denx.de>
CC: <jd@ti.com>, <tl@ti.com>, <trini@konsulko.com>, <sjg@chromium.org>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|CO1PR10MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c920f2e-c0da-4553-d162-08debfd4ac4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 97ktb8oVaTOjOXUXDFPjQTh8FfsIXeW1Rw/+/sNO3hJQC7lhjVnZdc+1DffW7YThQB6Uh1uz7pZXSyX12Ihm1QxdVEg4aFRNnUnxS9jDcNwhPogAe+FOLEbblBP8R7rtNLwzkX1O9cGSVnoi/m8KuaTu+eYGCUMDlTVLatxlBAwwxfOzPCTN+0Dwjdes8h9x0Ye6IjIgJLqu17PwnLN8rDAKt76aoBSInz3GxwD072IARXja6x62mX5mKY3M7+wqO0ztW02N33WxuLHI8afGvOR54sYy9TkDL2CfRI95sVVjpMgWpXWTseDlZ8mFGrySsY009H6BhVql9aL219SxMghQ1muEdw2QKfBdioE+hqkE2OwrvIq7Ykl409spSPIqYLfWF0u1g7siKGLgn08GqQMj0/iv9m3XfW4mpIwf5K7f+yxJlixt1hHK2cVLZhMa4ugxeLTvLnN9jjdTLQ2ZoqzsZAX9JsS5svpMcbkRyowxEYmvhktDFPd5OPP2g1J2CRTYseP/7xTT/yRfz44wydcS9nXex1yG9O0NiVDrDeb86NYoaKDxfjMH7wBCQlls7SiHVbEyqOLzcgCJWn4089WxmMYP/3RLyknzNNsfo7X4FtKXq1aYIE2+PS9QqIjv7fylycyeqcAa5Qi3wa/V6QNaq1yeUe2mTUSCd7K4H96QC4s3TBu8DAzDUK/lhXT42MjuYRDIvDBEZenscRKu7xuhwqy3YldgDS1c+9Zv3xY0i18iXgih6NA5untqhr6D
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cejsPhu3LAJbwpfG0yq/kVctTn7yEnstaX7QnGX9I+RL7MVb7NQ+tG9ENZFKquEuQCd+8dIhr9XBtOowUuwmyOJFf4bI6GnYXtMfGO5kLLUziGIb9PTGRTVmD+Hvy2HYDW5khNSgYh/lAb+ysPFDvy8Ed54ZE+yWVvCCD4l7UHdyTDp+2wsjPf0OQLhZ0g3HYiUY/rhxc+bFYpIowB0fD/o/OVD9utSAmJ9cOnNN7N+EWwX9RE8NSiyvlxtcRV+uy1oVuGe//5lYnrsyyOr2XQZRwT4glCinBmS/VmEWXrJZerr4kGP3sm8HaCUG7cLi7NWjfMW2jzVMMojBiqCQUVa0Z00HUVm0UpMNQCP9CYGdE5FQ2AjWRQFkDupdjYJDFXrSdTYp7+9DzBtBQVR2czum4ScIMqYiKx/8IZe4nubB6FSVFaCScTt+U5XS1PaK
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:55:27.6577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c920f2e-c0da-4553-d162-08debfd4ac4b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4466
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
