Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A44C4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 11:36:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82A5187CAC;
	Tue,  6 Feb 2024 12:36:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q56kr16D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 949C687CAE; Tue,  6 Feb 2024 12:36:12 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5942487968
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 12:36:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWTkM7ggtqF5E2oJ0qY+KIrJIJzabolH4ICO2dJA+7y6brS2iHLYMJUl09iOGVOpZ4fGXWrkfYNONX3156Q5MSa9MfquASTEJR6QTPVGIXbVdKeRPQx2wtYqqBpD8YgZvyKWGUIzoNaAme5VyrpDSfyCxUyY9oWVnUTVqjZC3B0ytv4Y2HMmvlllHENxHR+leWy8FdrUYlHRHu2Xt2U47clSkSNrodERf/C5ooSVdv1V2XFcftneyuRd9ESny0BreLQs78KqivHBQItmZUKDpWZSj7iYy1VRSdg5o8kNfZGlcU8BPr8L6uEoOiT6D4+LOy2BoY7zb3O0xlcsXk+xqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ye4Ej8lfIGLlu8MAWVNJ4Q2+MbbG10W7vEh8deovlE=;
 b=ML8cIeIWxNsZVZdxrudvUYn0fTaJzcoQvKP/Tb8Jdh2k5af6RZU7dJJnE3FKXDJ+1o7IBcH6tCxPEOfOWaPR1WaKYPHGicH6ZG0Bp2NPdhPyqvgRIUTBbgxpXPObanWQopS/tfL8g1QUxdQaErRjpNYnpq6jV3bBz3iCTpW14YNDmbBxiZ5dzbsS0DUgI6H+QrLcC/Z/0mhNoWKfg/cnImVYrJuDvpPIl5PTMoHRks4kt6wtTvmGibvIwKFO6MmEvV+MIkfYCjk1LhfLZKJa4B7l7bf4D8qmNJgwYEz8rVMT3/j8UVOZaLWLQoM92eAyOYy8oE7eR38g0XTlBbiQng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ye4Ej8lfIGLlu8MAWVNJ4Q2+MbbG10W7vEh8deovlE=;
 b=Q56kr16D4Txo9snPHIdYViMDiDi4IhuwrcRu56dO49HH6TMOx/63flELMKKmQGw0duzy3g5wio3Fhv58x3XOoElcDKceCoqhH8FSgwEGJZnLU/WOtPMlI7Axc/s7fi9GIl3AiCc6/QuBd2VyhyLjdW8qC1GBXH8uPbgGKA0+j+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 11:36:07 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 11:36:07 +0000
Message-ID: <e9d131b1-efe2-48cc-a2bb-9584dbe8bc6c@amd.com>
Date: Tue, 6 Feb 2024 12:36:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Fix kr260 clock wiring
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Harini Katakam <harini.katakam@amd.com>,
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
 Neal Frager <neal.frager@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Tom Rini <trini@konsulko.com>
References: <e87ae94979c6efc909740bb1a569505042e4f876.1706626255.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <e87ae94979c6efc909740bb1a569505042e4f876.1706626255.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0073.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::26) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DM6PR12MB4497:EE_
X-MS-Office365-Filtering-Correlation-Id: 390e6928-c30a-4cf1-28d9-08dc2707ced4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JWT5JZeH6ILjkh/nMJYsDZHaJ7+YSVvqNkj12ixKbuPeVPJPubhRJBZMzQEOpXv9Lu2RHnesry0gymlbvatfxQD9Xb90vQLQFn+mvMOZpFS6TEcthDEIbO9WhqD7T4Ym0bCLlP5EwWqbECbj8O4RhbtERxxw0dfp9L5BWwyvR02f4QSmN8fqofsgiSpyKUVOpsRtdl6BSZRo5tBy5TazoPG20ko683moOoEwqO9yGLpSZCU1rgTzBjpa87A8Nx6Mo7Nz7A2ntXZdF5g7wUD0WUtahntRA3LgchbN8kNpcc6EJ4Ehjz/8Z+06IvK8ZvBZad3YCKyN6DCTq1egmv+ZASwMecDnbvtolMenYQrY9JPX83VJ0p3sAAWJksof+JkcQ8uhjmPynvyTuusaHfePceHyBvFPffe1hqLfyv4+SlY1r1XpvCa/QgSV6htpunUoghFnlWwArkvCWGt0EZi63F2httGohjApZVmQhJS7d5Wz/ZJnUiNCVN6MdO5fIBArfNHI7t5AcDrJawK3QzFfkS0nhxDtPCqYh93HXD6kAbZxJanLJtqeB/1En11WmFV5CoZ49rIA3Ait6EO/GKeohOGHLbvkTYC6DZiHH4d6F46cACi+NYlpQUT7L5pmjy4C5ccBO5ep2aW9bufiXMCUuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39860400002)(376002)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(86362001)(26005)(83380400001)(2616005)(478600001)(38100700002)(6666004)(4326008)(8936002)(66556008)(66476007)(54906003)(8676002)(5660300002)(2906002)(66946007)(316002)(6506007)(44832011)(6512007)(53546011)(6486002)(31696002)(36756003)(31686004)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGFhOHVhWHNMd2lyQlBwblh1RFJ4WUhXcnRuM2EyTlQxYk9qK1Rza1AyZ0tj?=
 =?utf-8?B?TXhxVDZQWUo4OUpWVEJoNG9raFNTdzJ4WTZmWUN2SjJ0KzJVb3RsK2h0d3kv?=
 =?utf-8?B?bDNXMUltMVo0bDhFb1o5eTNXT3dTRy9RVnRaRTJxM0FFR1Z5bnFCVDVzSjZ6?=
 =?utf-8?B?SEQ5Ti9vSk1sTS94NE52SWdyc2g2ekxwckc4NXNkSHkrYmFkMzFVelA3a1hj?=
 =?utf-8?B?Z1JkSE1mUjl4T2oxeFRjaSt6a3Raei9jbjBNRkxaTUp4UjE2cjNvdXhBT29J?=
 =?utf-8?B?SDhwUEFKNUJ1WWptMHd0eG52alkxcFR6clJ1dS9SQmRsNWFtaUU0clJraklB?=
 =?utf-8?B?MkN3UzVtdTNVbmk5dHo1SDN4RENSalltL3dzV1pFVGs1dTJMejFzT3QzYlJl?=
 =?utf-8?B?Yk0xU0U2Y3p6c2hBZ0NnZk9kRHg4cCtCd1FwLytqTXplNm1hVkdqTG1DSWNR?=
 =?utf-8?B?SlhmMVl0WjJLZlBzZ0grMHBVQ0poYlY4NzFqM3dvSDR0aHJvSVowRkM2Z1ln?=
 =?utf-8?B?am80dVFMZFBBbG9CNFY1enMzRGhPVXNlYi9rZmpCdVArVDE5M0d0bVF6SWhS?=
 =?utf-8?B?UTRnd0RvOGdMR09KdDhZVEpKSmp2N0RPL3RtakNMSFhUS2QxT0hVcTZab0RJ?=
 =?utf-8?B?WW9HY2tOU1Z4djBKditDWGJ4NWZMc29CUFY3RW93ZGxkK21yZzNHNHY2bWd0?=
 =?utf-8?B?bDFvaHFsajYxRkJIb0FybGxrOXNsMjc5UkxlY1ZXVUFob2QyVnFYclJpMW5F?=
 =?utf-8?B?SlJ0bmFvL1kySVJDZFBaUE1mOVJqUUxlMHdyZG1qZTdFUzFPcUNlM20yLzZ4?=
 =?utf-8?B?MnVHM1ZJUGhIUWc5WCtKN0NSWTQ0QTB3UUdkbVhUYWtxVXpwdGw0TDZYWU1z?=
 =?utf-8?B?elUrdGtGNmFjVi9LcHlsMitSUzJsMVJETTU3dTJ1cVY5azRLb3MzR2h6dU5v?=
 =?utf-8?B?ZlpNNmdwbnBGcXQxTFBwdU10SWU1MGQrcmdzQVVKR0VHQk0yeEhRdHZaNkFH?=
 =?utf-8?B?Y3NvUk9xajdkUnhMWnVWS1Mra2dFTmVxYk1IbjBtenJjaWE3RHdtcUZNdTln?=
 =?utf-8?B?ZGFUTGExNVE2MnVoWExQcUVSOUtsUVhOUHpiZEJpK05LamwxRmp3RjhpOFBM?=
 =?utf-8?B?anY1aEVZSzg5Q0pUM0w1U1JGZFdtK3ljdy9jV3R0V3EzVUdmQzBnOXFTNWRX?=
 =?utf-8?B?dzdMNVFFb045MkVvbTVPb1NKN0h3d2M5bzMvVk5Xa08yTTJ5S2k2bTNWckFR?=
 =?utf-8?B?MHU2QndPMytDZlZWQXFXQ2p4MkVjbVYvaVFJcG5jLzZrZkxyYVVXajRhYUNF?=
 =?utf-8?B?U1hXY0FVYnFrMG1YV3hmR0FvY2RzOFdsRkJEbWIrbUJWdXZBY0pOcWIzY1Fy?=
 =?utf-8?B?R3RnSWJUOXdnbnFuTUJEMGUyNmFueVV0U1g0M1BuekFFRnJWMzFQMUdvTm5k?=
 =?utf-8?B?UUdFelFzOXNNM0w2TGhOQ3RBQ0VEWGkrbkdpU3I1VHVlVGFFcjdnRHBXWXNz?=
 =?utf-8?B?TFE2TnV4MGx5czZpYVc2bnZQV3FyY1AzWk01QUFwQ2lWU0p1UlNUc2dTOUFF?=
 =?utf-8?B?ZDV6eTVxSC92V3dvTGxrZjdsN1RzampKcjBFM2JSajJHSnFqdE9ITVJQZDlW?=
 =?utf-8?B?R1RKcVAyNWV6OTg2TUVka1hNV1dDb2JEeG5qS3JRMjdSYjVLcEpYVkMrSnJu?=
 =?utf-8?B?NWpmbXc5Y0E0T3VOSHRDVm1XRFJRVEFPcVBsMWJYRUVWQ052bTU4RGdxN1ll?=
 =?utf-8?B?SVJqdmNvQkE1WGZJcVdEbzZVNU1KL0hkZWNFeWNKMXBsWnhaNWZsZXlRYllW?=
 =?utf-8?B?TVBtTnM3WlpJczB2dVUxcG5IbWErem4xOTlES2JLS212YUdZU1V4b1JIR0Nt?=
 =?utf-8?B?SnorUnJ3ampQdXB3QnB0ZzZxZUhUakZqbUZOWExuNnJEYm9KRWl5NVpnSDJT?=
 =?utf-8?B?L1U1MnZwcXluUzNIQnJYSzNNSWlNeHQ0dDloQ0pFZERua3hYWWs3VzNmQUps?=
 =?utf-8?B?dGlKUHlXTHZ0TUVKSEJDZDN5ZXp6Q3Rib1hlaWY3Z0ZNUWZsYzBrWU9VZmxQ?=
 =?utf-8?B?N09BcTdJS08wb2h1L1FCSTJIeC8vSklVSDhmQWlKQjhia2d4TGRjVENVcWVC?=
 =?utf-8?Q?ZcrSMIc7Z9sMrxgKOwNZNrhMo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 390e6928-c30a-4cf1-28d9-08dc2707ced4
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 11:36:07.0453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ds3zDheMoh+PS2AWrrIfFyJighRtsGhlLwrv1iRTtUHaONoVAGN6Jkw1/Ag2rRIF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4497
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



On 1/30/24 15:51, Michal Simek wrote:
> kr260 revA/revA01 is using discrete oscilator for DP (27MHz) and si5332 for
> other clocks but clocks are different compare to kv260 that's why fix it to
> aligned with the latest schematics.
> 
> On the other handle kr260 revB/revA03 also contains 74.25 MHz discrete
> clock chip for SLVC-EC output which is not defined.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 14 ++++++++++----
>   arch/arm/dts/zynqmp-sck-kr-g-revB.dtso |  6 ++++++
>   2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> index 39ca98a9d47f..afcf8a8ee6ba 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> @@ -25,16 +25,22 @@
>   		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
>   	};
>   
> +	clk_27: clock0 { /* u86 - DP */
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <27000000>;
> +	};
> +
>   	clk_125: si5332-0 { /* u17 - GEM0/1 */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <125000000>;
>   	};
>   
> -	clk_27: si5332-1 { /* u17 - DP */
> +	clk_74: si5332-5 { /* u17 - SLVC-EC */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
> -		clock-frequency = <27000000>;
> +		clock-frequency = <74250000>;
>   	};
>   
>   	clk_26: si5332-2 { /* u17 - USB */
> @@ -49,13 +55,13 @@
>   		clock-frequency = <156250000>;
>   	};
>   
> -	clk_25_0: si5332-4 { /* u17 - GEM2 */
> +	clk_25_0: si5332-1 { /* u17 - GEM2 */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <25000000>;
>   	};
>   
> -	clk_25_1: si5332-5 { /* u17 - GEM3 */
> +	clk_25_1: si5332-4 { /* u17 - GEM3 */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <25000000>;
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> index 21187396326b..24be5dd84e19 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> @@ -60,6 +60,12 @@
>   		#clock-cells = <0>;
>   		clock-frequency = <25000000>;
>   	};
> +
> +	clk_74: clock6 { /* u88 - SLVC-EC */
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <74250000>;
> +	};
>   };
>   
>   &i2c1 { /* I2C_SCK C26/C27 - MIO from SOM */

Applied.
M
