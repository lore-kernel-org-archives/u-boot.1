Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBDECDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 10:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A068E871FC;
	Thu, 19 Oct 2023 12:28:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="B0ptSX0+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C5EE871E4; Thu, 19 Oct 2023 12:28:41 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49BA187205
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 12:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOgCmrPuJjxpQEhci7o6sTh9wsx5GJEELZR+Y7C103hcTbSvYb3enn74REqN1IWepkU9R8hfAFd7f5857bvdbHSixiWQsGZgUwi/Jr6wxnBqA3oGfkD1dMmgY3Kyhr8y6INihLeLdPoMJUI9GI51lAelSFKu5Fm+uwsoV9WTO60cGbX6m5bde6om+mtLM/vxqfL9kKvm1GM4/CIOveqfeEuRirOCgS21CoxpPr35GUIsx+ifWGJztH3ewwbX3SaU4KIlPLhmT45RtOOt+HgcWF37ek8dllMFOBwEORts+bXcEc+jBKdwpxHf6gabO9BpfF0SpxGnI5VX2Ym62shuxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xE/6TazBmgQPTqE4TrkxhaNowHplmzJgC/Fd3hmpSkA=;
 b=df8v7fnPWKYDlZY5WYIt/lb+nsa9Qy+/pKJdIbgYSD8uSIccU/nRmeUPO9Lui4yZ1BXgzxva6EazJCIgK2SsWn2hIx1pS2Wbx6MNC7WzTKyho8kLz0Xszl08EgpdI0C7iND7sJefZqGzYP1TBCB2QLRq6CP+TZsUm93lN6TS1hIle675HAXi29sm+JdUwU3Q+PuRR+1sB+4t2E3mX2igBRraWp7hM8CTMgngIgxGkZDr89C91vyq4/1aI7Ld3o4n3fXv8qNLVcSWdvtdMn8RKkOuUSU+HfPIMuC3i+0LiH5lzGSEEWfKWdZrB55pbEF3groKg1r9bPKTdhw/5Phb3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xE/6TazBmgQPTqE4TrkxhaNowHplmzJgC/Fd3hmpSkA=;
 b=B0ptSX0+NgN6lhwbnsx5215hz5AxXjoYO4tAWWGqJgMzus7l5aLHxgYyx3fwjaiUBVURentg0AhGFCSWRZFy3LoPCTtovkLml7tDATCLGwvYBKQIUJw5Wv2IgDM3zjPLXVd/1tvFxt6HBtywoVsgWRSoU+IkcCmSU2sT0krDYxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB10011.eurprd04.prod.outlook.com (2603:10a6:10:4c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.22; Thu, 19 Oct
 2023 10:28:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b9ee:e067:5935:4965]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b9ee:e067:5935:4965%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 10:28:31 +0000
Message-ID: <7e721a39-180b-e7e5-34df-78b1a90647c9@oss.nxp.com>
Date: Thu, 19 Oct 2023 18:28:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4] imx8mp-evk: Add USB0 OTG support
To: Fabio Estevam <festevam@gmail.com>, sbabic@denx.de
Cc: marex@denx.de, peng.fan@nxp.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
References: <20231016002437.641898-1-festevam@gmail.com>
From: Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20231016002437.641898-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB10011:EE_
X-MS-Office365-Filtering-Correlation-Id: 599478a6-e3d2-48a6-7559-08dbd08e23d8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oJdThOgBhYdnOehxTGk/PuYOzK+kgan5dmBC0iWyRa6ERCI4QRpLE02F+lLgKky2aJQbkXkpEyX5j8Xm7xZl0mF0ztfZ/klUpy69ZYJ/1ylDchuDyUJ5j6pZFgzix+Bi+QvjAABQqvTeb17mO3qWOLoWEiZjuu5TvHEZOVDMsn4cwj4USyI2+uKmV2dEnrsA2YZPndmQFyKrwYMpnTWmD19PyoxdrxEtJbdD7OroHM/sJlOwdxobyf6N5Oggl5eNZijLDd0104XN2QsihrQE9w5lYYC5xyQ5XX0v0JQL3GKyKFd+2Pxq8JoaA+eq0WURdWTPoWbshmOHB+pXxUv3y6iQJBiePiXv7BZshetcq195RPFIJXmC2cRewN9xUvx56iUFJT/7Z3IgEn/ZVfvKiGiRls4pvnwHQZs7ANfGGaQXPrwSOR0ROy3rjjYMceR6fuVtAnIy55IYb/sdKA+qovb26agsGl3ctIhj39QfvFmvLRFvmxOfEgojImxd4ICFrB6flEkGh3GFlRfSTe8rBCOVfPY1JjxVjIgABxSRFGRwtLz3WdL+4C1jec1rXMvaGfdNZOJat2TMj2Y5on6D/HV/mBq4sd40ai6brofndTvgBvSbS99lTDUbWiZ2vZ0kJL0+2YhglOV55heqPkff0kgDdo6biT1cxRXFiWJhXWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(478600001)(6486002)(6666004)(316002)(66556008)(66946007)(66476007)(86362001)(31696002)(38100700002)(8936002)(44832011)(5660300002)(41300700001)(8676002)(2906002)(4326008)(6512007)(31686004)(2616005)(6506007)(83380400001)(26005)(53546011)(32563001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3ZCeUdGeVVmd0dlVmdzWDBQYis3TFE5TkxvemtINHBKU2hHdExhK01jVFVs?=
 =?utf-8?B?MkhNV25FSmZ4bGY5T1lKellEQ0FQTzNYRkVEWC9OTWhFU0dvWW1rWGxFdXQx?=
 =?utf-8?B?ZVRmMHpTZWh6bzh0VmFnN3VjOTBvRDNvUHc1MERqN1pEdTNYMWE3UGJUd3Rz?=
 =?utf-8?B?WWJiTUN2VkxKZlVjSWdublhXcElsbjByNS9NdHQ2czhLVEZpd1Fzd3ZBeG1y?=
 =?utf-8?B?bE9tRlNJNHpJdDEyWWtsUG5tbWxET2xwNDBuajlyYTk0QjdINjRUcmlQbm5Q?=
 =?utf-8?B?SHNvYjRjSnRRS2VFNWR6QjFhTW4vR1lybXJnSHV0UEp3bWlPdTJ6OHZBMDZ2?=
 =?utf-8?B?dUhBSUhPeVBQVW9iZVBlTGVNSUVvU3kwU05LVVZCSzVCdXAvVXVPVFVUejB4?=
 =?utf-8?B?ZjFrQTY0R2c5RnRYRkp2TEl2YlR6NUVKQnhxNkxPSGhvRS9YclVPeC9iVkVK?=
 =?utf-8?B?WTlMV1Z3MU1JdElXSWVmR2VlQmkvN0hUWWJ1SjF0NSt1emxjWHI1NUc0TWVM?=
 =?utf-8?B?K2JSTWx6VCtVMHcxbFA2UmZaT2RIckRUeEFTRDNndmNFUVNqUTZJWloyaG5Q?=
 =?utf-8?B?NkkwS0Y5NjVscjFYTnhBSTNyYUhSQTdKU3NSc3JhbkdSblN1VXB6NnU4czlu?=
 =?utf-8?B?SHpLZHloTmZYNFNRSXoweGNuMmFBaTdvRUs4UlI1SFRibGsrSElJeFNmazBB?=
 =?utf-8?B?L1U0dm15NUVJcTNSRWd3encwWWsrblhLZW5ZcU5SSmRCcTdPcHVXb1plK094?=
 =?utf-8?B?ZTB4S3ZIYmpFKzh2QktOSDFWc1NsZ21iSU9JVk9pWmFMdG51dGdIOElncGFv?=
 =?utf-8?B?Q2VmT0lnajF6V0lLdExCSDlHaFcrNTk3bnhCY0VvRm1uS3Mxb3pZK2R3T0FB?=
 =?utf-8?B?c3l5dTFOMmtGUlVuaE1BK2thMWN0SGdvYkZNelU5ME03Uy9LQUJnYVl3SVlu?=
 =?utf-8?B?ZVR4b1UrWm9MeStsWkVGMnFWcklkTFAzZ3FSRHIxYys3V0lRYzhibVVhQndB?=
 =?utf-8?B?UW9FWnB2SmNKVmhNenIvOVB0azA0aG50ZStlM2RIMWtxaDgwVEFDSk1oU1pi?=
 =?utf-8?B?Z1o1TFNGbnNyTUE1bVJnQmFVSXZmQldhUjQ5Ky9PWXNmRExJMEV4QlRMOEpv?=
 =?utf-8?B?aFNuSUN6VDM1R3pFMHRPSTVqamwreG1FNjBKcTA2UG13UEtqK3Y5T2kxL2d3?=
 =?utf-8?B?ZzFibkxoa1hGL3hhclZTUXBVV2ZYZ3BqTnlEQlB6bmVJU1FGejE3cjV5RnBZ?=
 =?utf-8?B?VGZvT0RlOXhqUVplV0M1eURaM2hzbFNlZzdHUUUwZ2R6VVVnWXowcVcyd3dN?=
 =?utf-8?B?VDVXWXA3a05Ud0pyZHpqVjMvbThxdUJPaU55bkFzLzMrN2lJOUhSdFl5SGdK?=
 =?utf-8?B?QTY3WE44ckFWL21aczBacHZaNkN1TCtMOU9JSldqR0d6SVp4Y29ndzNiM1Vy?=
 =?utf-8?B?bXBQc0UxWDRLQnJSREhabllCSVlVQjlEWWt0THR5NHhicll5ZzRDb0VMeGpk?=
 =?utf-8?B?c2Y5dU1uRVJFeXlnWmhOYlM2aWd5eXMwSlRIazJtbUREUUlTS2pmc3dJeEU4?=
 =?utf-8?B?WFQyaUFzQW4rRVc3MDlmb2pkVVhHZHBtT1FZOXlwWnMxYzVmUXBNKzJEQzkx?=
 =?utf-8?B?Umdaci9rbGNtdFIrUjBKeHpDS0RmbCt6V29QNHFRdXYrYngxMXFLS2pnOS9L?=
 =?utf-8?B?akpUVk9OMThmZ3Y0QVMvZitlMWl5OCtZRkd3OGcyV0QxYVVRdEFIbE9oQk5Y?=
 =?utf-8?B?OGVEL2VZbExaU1RGL3U2U1pzYkhvR2M5bTVacGcyb3gzYzRCOW1sMExTSzRt?=
 =?utf-8?B?cHRLOHFYbjY0OFlJOU1oUFd0bGlOTkZ0T1VxamFmN1piMFNoVmFaZmZoYmdt?=
 =?utf-8?B?TXpHOTVUWXZwL3lhNjY0R1l4alJmcGY5c211Q0FXR3FQK1Y5bjVDeUpQOW1p?=
 =?utf-8?B?TDlqV3Rwd2tkT2RYaFk4SHZLUURNcWNROTR0S1V5emZoWml2UkN5NkJFandM?=
 =?utf-8?B?aHM1ZTc1RVEzUTBTdnlzS2ZqdG5hczMzZzZicWtNOEEzcVZOaXRpMGZ3WHRw?=
 =?utf-8?B?NlExR2poNll4UXgyNHJCZWpnKzRTOU4wWnA4a21HRDVMeFdha2hzRmdML2Uz?=
 =?utf-8?Q?0U508gJV0+EHMBUhI2eqmW0NW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599478a6-e3d2-48a6-7559-08dbd08e23d8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:28:31.1445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uUFhZfw6LBSX1uKpfgNr5GqIcdmuSTqp0d5k6dH5P7aT7LKxYqbE4V0dHccMi0+2XA4CBXuk2fdthnL7jvdHiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10011
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



On 10/16/2023 8:24 AM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Add USB0 OTG support.
> 
> Currently, the USB0 OTG nodes are not enabled in the Linux kernel
> devicetree.
> 
> For this reason, enable the USB0 OTG nodes inside imx8mp-evk-u-boot.dtsi
> for now.
> 
> Also select several useful options such as USB gadget and fastboot.
> 
> Tested by running "ums 0 mmc 2".
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Reviewed-by: Marek Vasut <marex@denx.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

> ---
> Changes since v3:
> - Fixed the alphabetical order once again.
> 
>   arch/arm/dts/imx8mp-evk-u-boot.dtsi | 13 ++++++++++++
>   configs/imx8mp_evk_defconfig        | 31 +++++++++++++++++++++++++++++
>   2 files changed, 44 insertions(+)
> 
> diff --git a/arch/arm/dts/imx8mp-evk-u-boot.dtsi b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
> index 6784ed2e7c92..f4fd2432ca8f 100644
> --- a/arch/arm/dts/imx8mp-evk-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
> @@ -111,6 +111,19 @@
>   	bootph-pre-ram;
>   };
>   
> +&usb_dwc3_0 {
> +	dr_mode = "peripheral";
> +	status = "okay";
> +};
> +
> +&usb3_0 {
> +	status = "okay";
> +};
> +
> +&usb3_phy0 {
> +	status = "okay";
> +};
> +
>   &usdhc1 {
>   	bootph-pre-ram;
>   };
> diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
> index 14c749f44308..820dc36e9cdd 100644
> --- a/configs/imx8mp_evk_defconfig
> +++ b/configs/imx8mp_evk_defconfig
> @@ -59,6 +59,9 @@ CONFIG_CMD_FUSE=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_USB_SDP=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_REGULATOR=y
>   CONFIG_CMD_EXT4_WRITE=y
> @@ -74,6 +77,14 @@ CONFIG_ETHPRIME="eth1"
>   CONFIG_SPL_DM=y
>   CONFIG_CLK_COMPOSITE_CCF=y
>   CONFIG_CLK_IMX8MP=y
> +CONFIG_USB_FUNCTION_FASTBOOT=y
> +CONFIG_FASTBOOT_BUF_ADDR=0x42800000
> +CONFIG_FASTBOOT_BUF_SIZE=0x20000000
> +CONFIG_FASTBOOT_FLASH=y
> +CONFIG_FASTBOOT_UUU_SUPPORT=y
> +CONFIG_FASTBOOT_FLASH_MMC_DEV=2
> +CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=y
> +CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
>   CONFIG_MXC_GPIO=y
>   CONFIG_DM_PCA953X=y
>   CONFIG_DM_I2C=y
> @@ -94,10 +105,15 @@ CONFIG_DWC_ETH_QOS=y
>   CONFIG_DWC_ETH_QOS_IMX=y
>   CONFIG_FEC_MXC=y
>   CONFIG_MII=y
> +CONFIG_PHY=y
> +CONFIG_PHY_IMX8MQ_USB=y
>   CONFIG_PINCTRL=y
>   CONFIG_SPL_PINCTRL=y
>   CONFIG_PINCTRL_IMX8M=y
>   CONFIG_SPL_POWER_LEGACY=y
> +CONFIG_POWER_DOMAIN=y
> +CONFIG_IMX8M_POWER_DOMAIN=y
> +CONFIG_IMX8MP_HSIOMIX_BLKCTRL=y
>   CONFIG_POWER_PCA9450=y
>   CONFIG_DM_REGULATOR=y
>   CONFIG_DM_REGULATOR_FIXED=y
> @@ -109,4 +125,19 @@ CONFIG_SYSRESET=y
>   CONFIG_SPL_SYSRESET=y
>   CONFIG_SYSRESET_PSCI=y
>   CONFIG_SYSRESET_WATCHDOG=y
> +CONFIG_USB=y
> +# CONFIG_SPL_DM_USB is not set
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_DWC3=y
> +CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
> +CONFIG_USB_EHCI_HCD=y
> +# CONFIG_USB_EHCI_MX7 is not set
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_MANUFACTURER="FSL"
> +CONFIG_USB_GADGET_VENDOR_NUM=0x0525
> +CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
> +CONFIG_SDP_LOADADDR=0x0
>   CONFIG_IMX_WATCHDOG=y
