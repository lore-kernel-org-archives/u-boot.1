Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071CECDB482
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 10:26:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EA6B871E4;
	Thu, 19 Oct 2023 12:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HthQ8ctK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C0E9871E2; Thu, 19 Oct 2023 12:26:09 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe13::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6026C871E6
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 12:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViczAWJlCBvhSNII/ajfqYzq6SGPxoBNfY6ocl6z6SvYGEjCXAea6J3XbU36mFR2p7me5I+9kPRGeJvbjk+gwhtwF2n6S73C3KOCvUKzzdQDXtOP/bmtLu1PwuFxV6mdcBKqXTnbr4lb9TmpNeKjFoXuhZAN3bEa21Vy3TVxdpQ7MbOIXRpVM5o1eTdBJYTgSXMfBCdmBtd7TEdCEBKLzP61tZi/Bbtrs3sBcTobcKPf1S7jbZ1NrHzuLCbutNvKBanouovrukBfb1j9WxqZ8ZnM7gqViTcQ22RsR/THBzVn0RblIiynqEdSLvI98oFtY5pcPgeMoyVv6LHnTnNphA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMQR7U/eDbHh0N8tDizyXs++vgc0IPIduPEWDBFkIis=;
 b=QUZm1S6XKu7FEyfLhywJP9xktMTKbF2ERoF375QvsK5IqfGbxMOvDxZ+Ic/HSumBzeHYPiveL9dFeSdAqvt3PGN3S4TtQfiUIEiVsH4fYNXHBVFnFc4fJ5O25kJ0YkKOMORuzkUzzr7Q8D94Etvgu8dp/7+J24u+JKH05xImgOpmDoXvc2NwEriMxKTbqHLaaHitpPlmAOq8rJhQaMtWxL63NyCdvIQyiq6hWOgzBBd3Oz9CDIPXRtBUqxupsQ/kId0LyAUsc1kLqOupSJMINnWCkG0bh8P6Ft74mZkDlMAXM5iV48x1ZrFe0ll+wXV7eFxDpMgz3IIWjNt5iAHMzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMQR7U/eDbHh0N8tDizyXs++vgc0IPIduPEWDBFkIis=;
 b=HthQ8ctKWYNySLMjf5DHfg3ndEKCsqI1Z6i3VUOeKgYc7d5PBME+AX5DMTqeU6RvlkhO3jURqy9A/z5TNnzJX0sxTOQkYPBT4xx9vGnAH8DdaSvKBU7camUiWk00iB/03LW+mAZmghmKkPesXwZqMVmFJYCKTLgqFVizlb6aqrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB9728.eurprd04.prod.outlook.com (2603:10a6:10:4e3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 10:26:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b9ee:e067:5935:4965]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b9ee:e067:5935:4965%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 10:26:04 +0000
Message-ID: <43eee0e8-0b9a-67fd-d18c-4b26a7ca2171@oss.nxp.com>
Date: Thu, 19 Oct 2023 18:25:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] imx8mp_evk: Convert to DM_PMIC
To: Fabio Estevam <festevam@gmail.com>, sbabic@denx.de
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, Fabio Estevam <festevam@denx.de>
References: <20231018191742.1303779-1-festevam@gmail.com>
From: Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20231018191742.1303779-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB9728:EE_
X-MS-Office365-Filtering-Correlation-Id: e32ad80e-2bd0-4303-5192-08dbd08dcc56
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPPhkjY6ZJl7Mwcrc9htrK1ALMbsIYww5dk9hpFAgKLhh4PbpfAMSIngyfOy0WWkyuZ/DL8yC5FjJ8NNRq+iPsbsCIQAdfDwV9I71DGsGyOdIV8RKTjL0DskvO5DEYbIibrDy3vyMJVS94ukdrpnMuM/Qgs8c82aj/uuxV+cDOgByF/gMe6SwkfMFnWgo1hS1N6eo9fdew9jnFGKHZxU2dTHMGJcafmjKSlzSqyCXzZaArg+VSWw+6IWL5WFKppBoPUXFNiGJaX+BWOxmnZedKEt7+aCiw0pWMe3cdco/YALkfp/J5qdYu0D0ajSayfUiD1jBIY4GnNzOx9Aa8RgcXJIyW24UZoYTgiYvExOhA57Hl31z/T0c1PMOj//A3YTZhL3kGmUckwL1yz+7pVBCZw8Bz/NZSE4KfHv4H3TNC/ik9T+GDgS5Pl9jfI3k4upjIxTJrzpiWEtqBx6eE52GlMwWwDfOcUD1Qd8OIVUert8ssNNyWzwxI0zAz3Ns/HcMrRUqLl7rhBNmrWWBIJyjVCWFwNyplkFghZxaDoiuRLAuYiSKXB0j05/J797e/7O41y/i7spNJPdYOz63owE1mcVCZ/GQByg28gAAevAH8wg+v/AkM1KBQCZOKWuV616xgMO1mPIUGG2kTslesq1aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(31686004)(38100700002)(478600001)(83380400001)(6486002)(6512007)(5660300002)(4326008)(66946007)(66476007)(86362001)(2906002)(66556008)(6506007)(6666004)(8936002)(41300700001)(44832011)(53546011)(31696002)(26005)(2616005)(316002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1J6dUFJcEFLR1AxcHFVSloyTmRCdVhLUXFhem1vUXMrMFovV2ZOL0xPZk9k?=
 =?utf-8?B?aVc4dnlTZnNIcHNwZndzUWZXTUpNSVltem9UTVRKeEVMc0ZnZUNVYnIrOW5Z?=
 =?utf-8?B?ZGxKa3BGK0NVdGp1dWZiVG5HYTduWW5xcUJwRmdlcFRqQmNvU0g2Nm9peEpS?=
 =?utf-8?B?ZlZtdXUyVXVGbFpCQTNiclhXM0FvTC9NOXY1dE0xNnJsbGthWmU3MzRFcUxr?=
 =?utf-8?B?TVVaYi8xQ1RnZ2RibXlaVjZQZDdSMDRjZklERFJkVjFOYkJmaFk4VTU0TzhI?=
 =?utf-8?B?RzM1akhoOFoyT1FtOHhLQmgyYWtwaUQzQ1dieW80ejAvTW0xMnVmK3NMK2ti?=
 =?utf-8?B?WTEvKy9TeVpCRkp3NE8yeHgrdlhBWlR4Z3dVT2VNOU5tcEUvSWo0MzljMk1V?=
 =?utf-8?B?cHFhQUdnenN3b3pPVVhCTnprd3lCMzdDeDNVNzM2dzJPa29KQXY5S1JxaDZV?=
 =?utf-8?B?OUhRL0h3NjdreDBDeDhwendMTEhvenpsOVNlTktRLzRRdXF6eUhpb0dseGtX?=
 =?utf-8?B?UzRzQ1NLa0FwQ2xwVkhhck95dm5XYXUxZ1ZRazF0MGFPOUxxV004NjhIYTh0?=
 =?utf-8?B?ZXk2cnA2YjNYRUF3NVlUdTZVNTBCcVdDZnRpendxKzNRUlhEcUpoQmx4MUtH?=
 =?utf-8?B?N3NiTW5NZmdpdWtnSSsvT05LUko1T3VoTzQwUXN2YVhtUmpicEZZYzV2WERx?=
 =?utf-8?B?Z09UZGFDV05VZ0grT0dVR1IxQkRYMTY2N1ltVXlma3FqSkE3VCtxdmlCT1Z4?=
 =?utf-8?B?NHpmOE54UlNTc1pJQlhTS1BSc0RueDd4RTQzR3A5ak9kZTNYZ2Z1ditFOUFy?=
 =?utf-8?B?aDBlY1lmV3d2WDdPUnBDb25HM0dwUzlIRVBzemFBTlgzaXlvZjE0ZFR4MXNQ?=
 =?utf-8?B?TUp6RkkwdFBaeTdsMm9YdHBnOS9GcFB3cTlEb3NrbFRwWXNCTTlUWW0wUnM1?=
 =?utf-8?B?N004cHZRS1Y0NkFoY1VkdnU4VkVmM0RFZG1SVFlCRmpHWmcvZTJySC8wSGVN?=
 =?utf-8?B?cGZoY1hSQWRkWjdpME0rNHYxemtEdStzelAxRGc4eGVRcEcxRnY4Y1Z0YnJE?=
 =?utf-8?B?dnQxV0pxRUIvMXlIQzYzRkUvcXFhS29hVGMzWmJ6VWJJZEdwcmVyd1RteERV?=
 =?utf-8?B?bVlOcDFGMnF0TEZqMTdsUm4yYURVZnBrb3VJQklaNzFuQXRDaTQwQkJ1ZjV6?=
 =?utf-8?B?aTNCbnRPZWE3eWUrdkw3UFBCVGE5bVJ0S3o2d1dhTG8zcVJ1MUtONHJTQlMx?=
 =?utf-8?B?ZEtnZmtDVm1xNWhseE9XNXV5NE1CZStYRXNKNHZSdk50YytsbFNoY2NBME5n?=
 =?utf-8?B?SlVUYXJNdWtvNkFJNmpSVGNpYUdkbVRhb0lUVnNncTUrcno4c0FUL0Zjbk45?=
 =?utf-8?B?cmwyZ1RpLzRVTFIzN1Q2Tzg3ejdNdmF5S292VlgxclhmMnk2WDQxcEZhZnNL?=
 =?utf-8?B?aU0xVXJlZjRrRG9YWjVJYTFDcWlwNllMcUQ1TFArVWhrZ3UrNnNCbFdxTmVt?=
 =?utf-8?B?b2FPYnZCekNVc2hOR3RDdjFOWHY0aXc1dE0wUzJYVmw3a3NEOTdXMVVWUlZs?=
 =?utf-8?B?bG0yVVNxN1Izd3Brb1hOYk5BOThreWduMkRYb3pIamhBTFNqVUpXR1p6eUpC?=
 =?utf-8?B?RzRYbmF3VHRidURObmtTaG9lM3RzSXpVOStLQ1JrNWN5dlY3cnh0MWVTWFZY?=
 =?utf-8?B?QnlzYmpjR2dvSmR1VzhEdmEycGtjYXpZYzhpNStPZTlwcTFHYTIwbnFJeHRi?=
 =?utf-8?B?QjFEYjI1RWdGczA3TE90cXZsMVZRSnJaUk1GVDJ5UDZJMVRibFJLbUJ2V1Rz?=
 =?utf-8?B?MW0yd3dTRzd6NmxBWjNMNjU0WHMwVzJ1Qml4VC9uYUVoRzBFUEg5cVQrS0lZ?=
 =?utf-8?B?Nytuc2FtU3ZnczhLQ0s1WnI2cGUyaHgrVVJwTnhCSDRSVXBXUXNuUHkvVk9k?=
 =?utf-8?B?SVdiYzZPMTk5elo3VE1Md21JcFFydHR3d1k4b0pFMmgyTTBrRjFTL050ckFC?=
 =?utf-8?B?b3pQaGwzWng3RVZOdzlXWTdQTWRsV0t0VkF4OFc0RHcxamNkdm1QeGhNendt?=
 =?utf-8?B?V1dUWW82bUwvdWdVZHBWaW1iTmNSNXFEcGdjTXFHcndFcEdHaFN2QlZONnhr?=
 =?utf-8?Q?Sy/hgbePzK8hc77XvNG+inrKi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32ad80e-2bd0-4303-5192-08dbd08dcc56
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:26:04.5519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3w/LjCC+YzYS/HlZzaXWNe9QvpNdHXA8zfpkvNiMlncZXz56Jev4J49Bs/h8e4AD3KoLYsK02HNhAOx7/iB/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9728
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



On 10/19/2023 3:17 AM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Currently, the imx8mp_evk uses the non-DM code to initialize the PMIC.
> 
> Convert to DM_PMIC, which is the recommended way to access the PMIC.
> 
> While at it, fix multi-line comments style.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

> ---
>   arch/arm/dts/imx8mp-evk-u-boot.dtsi | 18 ++++++++++-
>   board/freescale/imx8mp_evk/spl.c    | 50 +++++++++++++++--------------
>   configs/imx8mp_evk_defconfig        | 12 +++----
>   3 files changed, 47 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/arm/dts/imx8mp-evk-u-boot.dtsi b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
> index 9ed62f1bb02d..0bf489b46248 100644
> --- a/arch/arm/dts/imx8mp-evk-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
> @@ -13,6 +13,22 @@
>   	};
>   };
>   
> +&pinctrl_i2c1 {
> +	bootph-all;
> +};
> +
> +&pinctrl_pmic {
> +	bootph-all;
> +};
> +
> +&{/soc@0/bus@30800000/i2c@30a20000/pmic@25} {
> +	bootph-all;
> +};
> +
> +&{/soc@0/bus@30800000/i2c@30a20000/pmic@25/regulators} {
> +	bootph-all;
> +};
> +
>   &reg_usdhc2_vmmc {
>   	u-boot,off-on-delay-us = <20000>;
>   };
> @@ -66,7 +82,7 @@
>   };
>   
>   &i2c1 {
> -	bootph-pre-ram;
> +	bootph-all;
>   };
>   
>   &i2c2 {
> diff --git a/board/freescale/imx8mp_evk/spl.c b/board/freescale/imx8mp_evk/spl.c
> index 246826a0d482..9dd2cbc799c3 100644
> --- a/board/freescale/imx8mp_evk/spl.c
> +++ b/board/freescale/imx8mp_evk/spl.c
> @@ -67,40 +67,44 @@ struct i2c_pads_info i2c_pad_info1 = {
>   	},
>   };
>   
> -#if CONFIG_IS_ENABLED(POWER_LEGACY)
> -#define I2C_PMIC	0
> +#if CONFIG_IS_ENABLED(DM_PMIC_PCA9450)
>   int power_init_board(void)
>   {
> -	struct pmic *p;
> +	struct udevice *dev;
>   	int ret;
>   
> -	ret = power_pca9450_init(I2C_PMIC, 0x25);
> -	if (ret)
> -		printf("power init failed");
> -	p = pmic_get("PCA9450");
> -	pmic_probe(p);
> +	ret = pmic_get("pmic@25", &dev);
> +	if (ret == -ENODEV) {
> +		puts("No pmic@25\n");
> +		return 0;
> +	}
> +	if (ret < 0)
> +		return ret;
>   
>   	/* BUCKxOUT_DVS0/1 control BUCK123 output */
> -	pmic_reg_write(p, PCA9450_BUCK123_DVS, 0x29);
> +	pmic_reg_write(dev, PCA9450_BUCK123_DVS, 0x29);
>   
>   	/*
> -	 * increase VDD_SOC to typical value 0.95V before first
> -	 * DRAM access, set DVS1 to 0.85v for suspend.
> +	 * Increase VDD_SOC to typical value 0.95V before first
> +	 * DRAM access, set DVS1 to 0.85V for suspend.
>   	 * Enable DVS control through PMIC_STBY_REQ and
>   	 * set B1_ENMODE=1 (ON by PMIC_ON_REQ=H)
>   	 */
> -#ifdef CONFIG_IMX8M_VDD_SOC_850MV
> -	/* set DVS0 to 0.85v for special case*/
> -	pmic_reg_write(p, PCA9450_BUCK1OUT_DVS0, 0x14);
> -#else
> -	pmic_reg_write(p, PCA9450_BUCK1OUT_DVS0, 0x1C);
> -#endif
> -	pmic_reg_write(p, PCA9450_BUCK1OUT_DVS1, 0x14);
> -	pmic_reg_write(p, PCA9450_BUCK1CTRL, 0x59);
> +	if (CONFIG_IS_ENABLED(IMX8M_VDD_SOC_850MV))
> +		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x14);
> +	else
> +		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x1C);
>   
> -	/* Kernel uses OD/OD freq for SOC */
> -	/* To avoid timing risk from SOC to ARM,increase VDD_ARM to OD voltage 0.95v */
> -	pmic_reg_write(p, PCA9450_BUCK2OUT_DVS0, 0x1C);
> +	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x14);
> +	pmic_reg_write(dev, PCA9450_BUCK1CTRL, 0x59);
> +
> +	/*
> +	 * Kernel uses OD/OD freq for SOC.
> +	 * To avoid timing risk from SOC to ARM,increase VDD_ARM to OD
> +	 * voltage 0.95V.
> +	 */
> +
> +	pmic_reg_write(dev, PCA9450_BUCK2OUT_DVS0, 0x1C);
>   
>   	return 0;
>   }
> @@ -135,8 +139,6 @@ void board_init_f(ulong dummy)
>   
>   	enable_tzc380();
>   
> -	setup_i2c(0, CONFIG_SYS_I2C_SPEED, 0x7f, &i2c_pad_info1);
> -
>   	power_init_board();
>   
>   	/* DDR initialization */
> diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
> index 820dc36e9cdd..0675f0f4f41b 100644
> --- a/configs/imx8mp_evk_defconfig
> +++ b/configs/imx8mp_evk_defconfig
> @@ -7,9 +7,6 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
>   CONFIG_SPL_LIBGENERIC_SUPPORT=y
>   CONFIG_ENV_SIZE=0x1000
>   CONFIG_ENV_OFFSET=0x400000
> -CONFIG_SYS_I2C_MXC_I2C1=y
> -CONFIG_SYS_I2C_MXC_I2C2=y
> -CONFIG_SYS_I2C_MXC_I2C3=y
>   CONFIG_DM_GPIO=y
>   CONFIG_DEFAULT_DEVICE_TREE="imx8mp-evk"
>   CONFIG_SPL_TEXT_BASE=0x920000
> @@ -88,8 +85,6 @@ CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
>   CONFIG_MXC_GPIO=y
>   CONFIG_DM_PCA953X=y
>   CONFIG_DM_I2C=y
> -# CONFIG_SPL_DM_I2C is not set
> -CONFIG_SPL_SYS_I2C_LEGACY=y
>   CONFIG_LED=y
>   CONFIG_LED_GPIO=y
>   CONFIG_SUPPORT_EMMC_BOOT=y
> @@ -110,15 +105,16 @@ CONFIG_PHY_IMX8MQ_USB=y
>   CONFIG_PINCTRL=y
>   CONFIG_SPL_PINCTRL=y
>   CONFIG_PINCTRL_IMX8M=y
> -CONFIG_SPL_POWER_LEGACY=y
>   CONFIG_POWER_DOMAIN=y
>   CONFIG_IMX8M_POWER_DOMAIN=y
>   CONFIG_IMX8MP_HSIOMIX_BLKCTRL=y
> -CONFIG_POWER_PCA9450=y
> +CONFIG_DM_PMIC=y
> +CONFIG_DM_PMIC_PCA9450=y
> +CONFIG_SPL_DM_PMIC_PCA9450=y
>   CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_PCA9450=y
>   CONFIG_DM_REGULATOR_FIXED=y
>   CONFIG_DM_REGULATOR_GPIO=y
> -CONFIG_SPL_POWER_I2C=y
>   CONFIG_DM_SERIAL=y
>   CONFIG_MXC_UART=y
>   CONFIG_SYSRESET=y
