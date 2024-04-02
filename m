Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E777CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 13:07:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6504988118;
	Tue,  2 Apr 2024 15:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oz9QR4+R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A98F88132; Tue,  2 Apr 2024 15:07:08 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65B8387EB4
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 15:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvvaREcIUbAfr1QsaojembgIVl/vLYlZJ2RXPko4YaGxqM+Hdf9VidwjGCzYCgdqshb59pXbxJh5d8i/fFwc23IVgoCZawJPeagyVkdFBiy1p5a9fWslkiBPAMVI8TFTeK2ZEiTbW2BXxaclYCvhGeuOjbg9HX3ldfKhMhfpT7zXuOCyY4l2Hj0pV7VQlENeN8v3pTm2h0AFr9nqiN9tNbmmOLiaAyvRm7T+XZnns495qvogRYYNQOZAqpRmxWTIiC2qhmRyNZRSR9zLbWwSQ/bMypMCTK9fl7R3RsMcoDNdk2jOgoDBiHnzByzTJfvYho7bMmFpzrz86/8cQpn69A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26A+BWfnzfpEw3/tKta/YUZmDKk5MWdN2p4sEZwpxk8=;
 b=XyLi9t34xHBrRbDTSu4ltn/zPRUAOQaT06ovc9SdttENOvImzaC83R496jQoWuzDSlaseBN8ShTVJo3xBfnPo+tfADPhWStSkM9cyDNWTIgeRT8Gyv864WYbjZwabzt8ukclN6y4OZ+gM22F4DxcGSnlMzYXWaxrg8AFY9thnzMjiU3xLpbXZE5+4Q39+gZRy230V39/yTFk2AQFLWgkSeCHc5RCV07Zc67H6gb2HVfekKymcHuCPNX8fldW7aCWcNpNsG2IvZdy5RcQxr7/n/dyfV/GYL+hvPem/QR0SKahxjAEcdc4hpuTsuf9kyg663IIZ1wMm+5eJrDMPt8W2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26A+BWfnzfpEw3/tKta/YUZmDKk5MWdN2p4sEZwpxk8=;
 b=oz9QR4+RER7+m32Elr9YKeYiA7ZOJ3q3xiu+p+N5zdGGSHH1sN+EzuljCKprkW6Jpz/9jIXYKP4c1YMxV7T9UGH/ANdEbNAov77FVbDp3XkbUXIlIBeNRlvmfejVIYnygeHYRb7wf6QRgtAOQjexEweAFx+0MWJS5T7p0C4uTdI=
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:07:03 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 13:07:03 +0000
Message-ID: <a220c97e-f278-4dd3-a308-fec87dbb3998@amd.com>
Date: Tue, 2 Apr 2024 15:06:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Describe DisplayPort connector for Kria
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Vishal Sagar <vishal.sagar@amd.com>,
 Harini Katakam <harini.katakam@amd.com>,
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
 Neal Frager <neal.frager@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>
References: <c8738cb9951c73c6c00a4ce8d0025fb372372346.1711036494.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <c8738cb9951c73c6c00a4ce8d0025fb372372346.1711036494.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0020.eurprd02.prod.outlook.com
 (2603:10a6:803:14::33) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB7836:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HNUEqW9kyfpeRnX+BOUWmuFt5mrerdZyoH75HP7xkgG5Kz9WbOPgwOk6xYsSet+BKMJWRovhjO89vE7j0qW905f3q1RJVy6s2zroB6ZH2UwMrCipkcP+aaUPo5hkkPLBWZa7RJo40tmHHlXWqmcZq+YCf++Ii0qjmayDYOz+PBXssv+J2ADvYQ6e/gHHX9Yncn6X75Q460e+bVx7qI8r8zUNkcc/VE3qX+VQUt1li7+7AQWf6eveo0ps1oO+sqVNP3qiprMl6Ko7vKRogwguPoavb4leeSyXqgGIHg3/8/lwkrJELVNTOamfSFtPnwH2OlxyNKp0mtLjAFn12y4hnZjY8Z7KfTjSZiggOees0KErrI3hafR2BVd7wzxGG2lHRzWnNqYNjL5ecAV7QHbFvseooPSVNTeDyEcOVzVEawzdYQZ4v1LYa4b478TpN83lzjJ5cbRzBg2NzoJe5YmaZxZKS7l8a4OfVrBAoZueC5xr9JT7jcnqkOH3U7QoSsIa8lFVkWrtWFw18T0ieTUltxfPXOon4fWZ40ZsCi42opBy3AA8zM96voOhuoydRwJjqA6DIEHOmMc7YS8OLiY6eEvYvoJ9EPBp0sJMWn7+O1iSmJxwS/YS6Lr1/K+ruh6cskG2so6KfJcvJ8c0JNoDdWXJsoUdNLfa/o3/iq2BkP8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG5xbVAvZWdQeFY4SnRwWVJsenV3OElwSHBCU0hCcXlCc1Nya1pzNzVsaE5n?=
 =?utf-8?B?VkF2NC9HVnZBZVJzR3pLcVJyMWdpV3Y1VGF4c2dhdWR2c3RRMHBvYzZuVCtK?=
 =?utf-8?B?aWlvSmdSeTByc2cvMG5VWGhESTE0azdOQXdmSVJkc2FQRUNTNkY3aEZ2SmxK?=
 =?utf-8?B?ekttODhmQTNtWnJqbmZVZFVFTC9DMG02Vlk4SGJBNTVQcjI5Q3N2T3VSU3NJ?=
 =?utf-8?B?RWlmQWVYR05mR2EvbzZ6NnFHTmpWdks3QmNTdXV1UTRyUDROQjZqblNwWWdn?=
 =?utf-8?B?aGQvek5SMkZPaE1zUWFJMTNvODY3NGVLa1BEKzBWUmM4SkpDdEExdXEvaVU1?=
 =?utf-8?B?SGg1M2M0U3VQR1dERkFmKzZSaWtsTERQVzJvTldGeHc0citlUXNwaWRyNDZu?=
 =?utf-8?B?SHJkOFk3Q3M3TEV1cXN0d2pWbDVCMmova2NjMk9ya29aY3VPQ0VwOUErazB1?=
 =?utf-8?B?VDVNUGE3RzY4bit3am1uSHRsY2Y0c0l6Y3YrT2NWZXhPYzNTMXd4WUZ3ZjVa?=
 =?utf-8?B?T0xTSHEwZ0xUWktnRWdYRElqMEJKTHQ4RHhBaGtabER1aWZCVXN6aSs1eWRE?=
 =?utf-8?B?ZVN3Y2JqNm9xVTVRdDVXdjZiQXhXRzlyaU9KUGxla3psbHVNa2lFT09uWUdu?=
 =?utf-8?B?a0k1WFZMSjhzZG1HR1Vnd2UvVFFRMlpya05qcGlmcHF6THd3QlZZeFltSnFx?=
 =?utf-8?B?RUJwM2FNVGxueWEyQUJXOFZuanFjZjhZakI0OEljeC9wN3A5Q21vbWxXQUIr?=
 =?utf-8?B?Nkw2cGxwZnJ3eW5xbW1iQmp2WkdrZ2t1MU5CSnV2M3F0S2MwMDlLckRWUldR?=
 =?utf-8?B?NHFTeEZFQi9HYjIycWVKK1lKcW1yU0RYeHk4NEY3WXBKZFc2eUZqcDI2eVRX?=
 =?utf-8?B?eWhPeVdoN1k1YzlzZGI2Zmk0WHJEMnQ4VHVyeUplVVFjWmJ5eEtHdHBhMm9R?=
 =?utf-8?B?cTFrS2kvQU0wdTNZRWdJMHl2eHd4dWdrUitDdmJVeEx0S05qSkJ2ZFgzTkpK?=
 =?utf-8?B?RXpMajdGQXU2ckNYNGwrdThZK25zZ0l0UHlxQWt6MTg5Qmhyakd0blhQQnZC?=
 =?utf-8?B?WHVsb1B3OEpwanpkcWZHV1hBQWRYeHZxZWw1L0VrYVJIR08ybzQ4eVAxOTRS?=
 =?utf-8?B?bU84bWQ2SlZ0WGJjdkxtd0FLR3NqMXA4M1RaNmlkeGp5QWVzVHphdzZZdi8v?=
 =?utf-8?B?WDlhZWUvTUs2R3o2U1hmRElXazFiT3IzVkdBQ2MyR0hkZTVqdjI5MDh6YVdJ?=
 =?utf-8?B?YUJ5YnNWUFBSNlRHU3pxeXA0Yjc2aUF2b2xRUWNtSWZlVFU5eXorR0ExN1Iy?=
 =?utf-8?B?SzNQNVJNUzMyeTBNb3YxNGg2aUIvNmlLbFBHQ3lGbm50SEdMdFdRSjNPSzNo?=
 =?utf-8?B?cHMvazdHeXJiM0Y1Z0E0NjI4bkxGS2F0QklPM25xWm4vQmc0aDRmRGpDRlR0?=
 =?utf-8?B?SEVDUzAvaXl2Yko3ZGYweUx0eHJjWFJUYnRLcUVJZHUrYnNEcEtrNW9rODlj?=
 =?utf-8?B?ckpseit3V1oxdDFuVngvVklUbzF4VGNkbWNYdmpiZ2hkRHdmTGc0b0d4TVZ5?=
 =?utf-8?B?VC9ZYXhRT2hVNGd6dkR1bk9pZHB3cUpYKzlHRW5ZQk0xaU12aGhPR0l4MWpG?=
 =?utf-8?B?Rlo2ZU1uak5TOHNyNnIwOUhtUUhmanVBMWRVZjF2dTBVYVRPQXBMb01jVzNk?=
 =?utf-8?B?VWhrRjkwQ042YzVQWTRCRWp2U2I1TENjWEkrdmY4TWhMQ1pyZ0JCZGRMRFM4?=
 =?utf-8?B?Q2RRN2Z4disraHdBWnRxNkpLOVExYnlVbW5iQXh2NHpYN1FZUno1RmY5OUZ2?=
 =?utf-8?B?dWs3cEJzc0VMTXR0bEw2c1VicWM3TG5sVElnSEt1QkpPUEFyb0p1MldjdnV4?=
 =?utf-8?B?cG9wWUVLQklyNjFKSjdVRjZNQkJ1SnA5aU1qSjhDWmNleFN5T3R5dkhvcHMx?=
 =?utf-8?B?clRNOWZONi9PWHZJWG0xNHpsRGU1MG8wMERTVDhQaGRuY3Y5UGZvLzRmUER1?=
 =?utf-8?B?ODBFYUdXZlFZaDRvSnZqWHZONzQzNkpRLzVBQlJpaW9VOFBLbWRGN1B2SEhh?=
 =?utf-8?B?MTEwNno4cThwT1dhaWhXSzcrdllDZkxkS2ZCSEFncVdtNXJtZ3dqRmkrZlo1?=
 =?utf-8?Q?JxyyfNzkdncJryz2quBmSZPTE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d1d8d6-cc55-4d4a-606f-08dc5315ca67
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:07:03.7779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7Uw3Ihf0HabqsN8hYY8B9lCWnHY1hMWIr+2WvBkgwWSIV+1vrtDhvvqZhpaZmSo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836
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



On 3/21/24 16:54, Michal Simek wrote:
> From: Vishal Sagar <vishal.sagar@amd.com>
> 
> Add a device tree node to describe the DisplayPort connector, and
> connect it to the DPSUB output.
> 
> The patch was tested on kv260-revB/rev2 and also kr260-revB.
> 
> Signed-off-by: Vishal Sagar <vishal.sagar@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 20 ++++++++++++++++++++
>   arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 20 ++++++++++++++++++++
>   2 files changed, 40 insertions(+)
> 
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> index 6c29f6574134..0a0cbd2b69ae 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> @@ -66,6 +66,18 @@
>   		#clock-cells = <0>;
>   		clock-frequency = <74250000>;
>   	};
> +
> +	dpcon {
> +		compatible = "dp-connector";
> +		label = "P11";
> +		type = "full-size";
> +
> +		port {
> +			dpcon_in: endpoint {
> +				remote-endpoint = <&dpsub_dp_out>;
> +			};
> +		};
> +	};
>   };
>   
>   &i2c1 { /* I2C_SCK C26/C27 - MIO from SOM */
> @@ -130,6 +142,14 @@
>   	phy-names = "dp-phy0";
>   	phys = <&psgtr 1 PHY_TYPE_DP 0 1>;
>   	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
> +
> +	ports {
> +		port@5 {
> +			dpsub_dp_out: endpoint {
> +				remote-endpoint = <&dpcon_in>;
> +			};
> +		};
> +	};
>   };
>   
>   &zynqmp_dpdma {
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> index a4b4465d2038..a449c1161b1e 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> @@ -63,6 +63,18 @@
>   		#clock-cells = <0>;
>   		clock-frequency = <27000000>;
>   	};
> +
> +	dpcon {
> +		compatible = "dp-connector";
> +		label = "P11";
> +		type = "full-size";
> +
> +		port {
> +			dpcon_in: endpoint {
> +				remote-endpoint = <&dpsub_dp_out>;
> +			};
> +		};
> +	};
>   };
>   
>   &i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
> @@ -97,6 +109,14 @@
>   	phy-names = "dp-phy0", "dp-phy1";
>   	phys = <&psgtr 1 PHY_TYPE_DP 0 0>, <&psgtr 0 PHY_TYPE_DP 1 0>;
>   	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
> +
> +	ports {
> +		port@5 {
> +			dpsub_dp_out: endpoint {
> +				remote-endpoint = <&dpcon_in>;
> +			};
> +		};
> +	};
>   };
>   
>   &zynqmp_dpdma {

Applied.
M
