Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F60EF9B5F5
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 09:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A01C18352B;
	Wed, 22 Apr 2026 11:29:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="FVkRcGzN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72D0F83FFA; Wed, 22 Apr 2026 11:29:05 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D63C3801A9
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 11:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4kP26e8rsJ4Q9Jy/ive5EBnFvIg7NPGPbmNaOMUSyHqfE152eClK/mDl7A/VtSiRrHZXgxhL9K/eAhYF0896LIuBVGnoEnTdKS+RF3h2LFDUnMaTyRssEG57c3Z+MMmZQ8XqXsjdDb7kAnbsBEOVFDHrCSy7Su+cuHALvH0gDNSSyySlN+F1UXFIO2iK+2/dJ1ZNmH/wvxdwuUx1LB4jkebu+Nr0eDDWMZdrBlIhiqqn7tC3Iur/cKzwUUo6gBgsiJC9tf7RQChaJpvWe17QPoHnUAfWj2Yfivf9YIMLO7MC5Jc7NndHnXlg5J8FOAkpW3pHZZLlc4GMZCr+DWVgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUfb+C2MvgdG0J7moXu1KkKCAoJdnNXPGR1ZM62POGU=;
 b=OoE1zAvJvE7FLFULAEVl5v2qpzlUWlL5DvrN7l9A+YsDaG7KmdAwELkakDLgdj5OE12aawY4cslJUA+FmZnye0IYNWI+6xfPnOQfhAZ/kg8MBENDniiHtqjruAXg9CU77gdR3yc+TmcbvjhNA7DHnZXqhtXjM3JfH88UvzV9jPto79l24IfK1jwmDJbBO2qV5zCrCDWg7hshAB44AFaU5LdZ0QWLlDGpuCPMQe9YDHlgJ/hoB0lxZNOdJzGKUSjznWTWC5Sn5YQsKaOp+HbQJ3Zk+Zj/9ByQcq6a8q+m7ZOfR0ZdqcFhZa8NU+Gj4vAUCfEy0vHobKCvNKUmnBhQhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUfb+C2MvgdG0J7moXu1KkKCAoJdnNXPGR1ZM62POGU=;
 b=FVkRcGzNaSI+hKPVZx8ZRD9Hc2xzZ4vLbCVJt5E/2/t1sQ4P++LuOSLlMzcEr7W1LE6bT2aOLAomSwQuTTBRhwaaYG59LF7X4YlHcAFU5QLNyjZptWTgKkBpqtiAUpI3amuZTl04TqW4Dt6clvUNFMlHlQCtXtGCRa5uGKYiBcYgiZ3hqKUP1uKZ+2b6Q4GWSNc6rr/qqZ7pXinOgrY4QmVpojV8sNr9aGB44YbNzBczFaRaGUpbcjkztRFwRC8jMqgXalQMg1auEYNSWIdn7SsSTPX7PohK7tmayJPqm9Wgxdzcwv3p/a1BT0nm1zlXc18LwNGyKVFwFsHZN1JyNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BN9PR03MB6108.namprd03.prod.outlook.com (2603:10b6:408:11d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 09:28:58 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 09:28:58 +0000
Message-ID: <97de1a16-c88b-45ab-a698-2a97655d518c@altera.com>
Date: Wed, 22 Apr 2026 17:28:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/8] arch: arm: dts: n5x : Switch to using upstream
 Linux DT config
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260318031708.9418-1-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260318031708.9418-1-chen.huei.lok@altera.com>
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|BN9PR03MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: bfac16bc-d56b-479e-008f-08dea05194b1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|8096899003|55112099003;
X-Microsoft-Antispam-Message-Info: d3MNuKHWlvDg/8sQezhAIHnRkw/r+Yu2zLsD4uz5QMNCZhkW+5weqRsyH1moeG8uJCwI5OEIQYf4kaS4RnHltlPUNX881wYSkZsZFKGh6qB2u4efZC9X3CNR0yx2yCd4jn3PTWZD+OohXA6g4sgSAF8gfSzha+T38rCwF1815onTOXlaMbMpcQCnt2VhGG+K+AhclSErYg462ud4PhsdtqWWdtpfBTFFIeeYS5cofOYsV6ZRSJFKrG/xaZiOlj4n3fXx2xq2fAMSYLy0uROuV0MhXw+V70cUa1K8FJG1I3sNHSqyi0Ckke4S0StyZBicYv0ccTUQmlvzgKNYy+XJlTw9SoEV7CnDihliPnsVmNR/AVtcd85xE5aAz4YUh6S3uxvwPk3kAelr6tgday+1COF2J8Wk8dyVmBlAKmQ0WbvfTrGXrAsS4/iNc9j1E/ulRShet9W2Y6luEDr9Qc9cdkMS4zcwf/Yb3GLpCbMOaODUT3srXCBRbb9YGK0U1zZoZDKN9Fky+GJ9rxT4ZwxcNVF0xZbcNOFy6ZtEGNoNHmBRNDnilQGz39NVCigCj1N6Gzbcqv298ZUAtp4Wz07xq7vo5F06Q3mKUsYJfinFZ+W0zAj+nyfkd+r3ztuxs3TSm8db63ItJEeeho/55C4TsAzAhVilo2bbLrmAv/BwkYX6wFo6aiNYkj1AC9tIX3M3TCYyTBhDLbP/yY7jLBl8rgzAzxY3is2HMkYOZQ6V5s4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(8096899003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkN1UlByUzlISmYrM3ErK2hTWFVEalZzUEg2M0d2bEEwUnF2UUtrWHJDbEVY?=
 =?utf-8?B?UllHaVVhVWR3VUMvd21xMWJVNitHQ3U4WTZxQ3dxQThFWmxsbTRJYVlmclpU?=
 =?utf-8?B?SVBUQjkzTUVBRVpIV1B6SUFMZlBSS0tyODZUT1Q2UU5xS1pFUTZMS2lQVlRT?=
 =?utf-8?B?amVpRFY5UjFYVzlLM0F4cnVRaGRPNDNVQTJzdEpxTzR0K2pCek1MTDluQm83?=
 =?utf-8?B?QnpkNGhjU3pKNVZra3NIU1dlZ0x6cjZES09xcHEyZzIzL3Qwa0xQQ1hacXE3?=
 =?utf-8?B?eHNYeXd0OE5RbDM3UVZFdk85Qk9wQ2JlM0xaVlJLeE9FY2lsTXkraHpDYVgv?=
 =?utf-8?B?MXFjRzlWOWUvKzlZNTJIZ0lCc0taQzQyYWpDMENGTjB6SkUxTHRKRTdzbFJx?=
 =?utf-8?B?OCtpa01RT2hXVHcvSmpXakFPdzFzT0FWZjhvamkrU1Vlemk1ak5UcWdlYmh6?=
 =?utf-8?B?T1E4UVh1UWIrUVlmay9jREI1VUEvcUR3cnh0bnlKMU9VdHNkV1ZRQ2cxMENz?=
 =?utf-8?B?alZiaWRGbGJyeTA2alg5dFkyM003S1IyS0NYK3lYQnVwSDZuSmNSbnZkamV0?=
 =?utf-8?B?VDNkNDlVY3pSVURVSVgzeVRBOFJUbzhGRDdJY2NVRUxQWUhUQkk5U1FYL0pl?=
 =?utf-8?B?RDlQS1RjcGtRYk1vb3AxeVM5N1BUK0hqNVU2MGJTb0o4dUdKakZJK3hDRnc2?=
 =?utf-8?B?ZXV3ZE85TU9kTDVueFcxTHJ5OGIzeUc2RDlXckcxUmRiMWZOR2lmRmVINjV3?=
 =?utf-8?B?WitqKzJkZ0tuT1V5emFKWDM4bCtWZlhBSTBhRHJVL0lHanhHZTdIQWVGQ1RL?=
 =?utf-8?B?RXI0NzBpdVpOdytyeWpvTHp4MUhHL0pkZFJTUWZZcDVITXpTdVQ2SFAzOUds?=
 =?utf-8?B?OGU4QndBYkZsVXlKQ2p3LzVxMWpNaVA4dW94WStMYmJ4MGJVVFJReVUrY2Fo?=
 =?utf-8?B?TEYyR0psckpJRjlEUGRMeU9SNmhTZkVJZy9SWTgyUGp6YXZpK1hvYnp6Wmg4?=
 =?utf-8?B?SkhiYlk4cTgyZi9DZEI5dmVacEdPVm5BVlNHdjFOOUR3Z0dsMnRhb3pXMkdz?=
 =?utf-8?B?RDQ3cy9PMFJTVlcvSDRhNkZTdDJFVTBsREVzK1RvUCs3bTZCM1JQbmphalNu?=
 =?utf-8?B?bHVLK0kvb1p5K2N3VnJGRDV1UHBFNTEzRzlBazZGNlJ2d0Nxc0lZK1RaUmhY?=
 =?utf-8?B?alRFeVJtb0ZGcllMRGN1RFFUK0NPbDRwODBEd1dzUHpwazg2NWliemVwM2hU?=
 =?utf-8?B?czUrK28vUE9pTlo4NlRvN0Z3ekozNElXMGRoQWNPMStpaDZxVmUzYXZyd3hO?=
 =?utf-8?B?WWkwOGNQQ015QktvZUhiVWpHOE1aM3lFU3NSV29VNXdnZXE0cUJVTFl1bHBp?=
 =?utf-8?B?YjltR2Nka3FvRm5IWmh1L0R6Q3haWksyWDJUZlFsbm5Bcjc4N0VLODFjRnlQ?=
 =?utf-8?B?WHlhcGVKTWxiR08vSFpFQ3NwVDUxLzVCanFmMFpVT3B5ZWVDclMwcUQ3RVd1?=
 =?utf-8?B?RTVDWWphR2NJWW1BTEpDakpJdnR5Z3d6V0ZrY0poaWhhVGk1THFuL1RCT3hy?=
 =?utf-8?B?V3VuRHlLeHlaWTdvZDFHYXhaMHlhTHRUcCt5dldtMzV5Q3phOUwzTE9hZXE5?=
 =?utf-8?B?SWhPSURDZGRVcGd5M2NmUzVFREsrWERxTVIzeDU4aEVPcDB3RXRIVGdia1Fm?=
 =?utf-8?B?UnNvODB1MlV0alJIRm9rSklFU1FIamJaVzd1WUFaV0Ira1JJTkNsSFhUTXlo?=
 =?utf-8?B?aXRKU0kvaFZ1QmVaWVhMU09zSWFUUGE2UEo3L3NoRDFrUGo3N2dNTGVlTzhy?=
 =?utf-8?B?eVE3VEZ6MUdGS3d6SjkycmhQUXl6L3RTeDQyRFc1aFBTRkN0KzRVSEx5clIr?=
 =?utf-8?B?WDdNeENydlBWSmllQ1dtdjJwcHQxUUZFcEZ1ajRwbTRoYmFBYkRwejZJaFJB?=
 =?utf-8?B?YXpEeG11M2xLYU0rN0psS1ZNVm0yOWRWK0hQU3JPc3NGc2l3VUwzY3FMZXpF?=
 =?utf-8?B?U2lmMFZEQlorcTg0eWdIM2lnbFBGR3NjTit6dGtzVTg2dFJoMkNGS0dSTlpC?=
 =?utf-8?B?WlNpcTFDYXd4VTFET0YxbExIbHFGczIxeXFQN2NvTGh6NXBGVnU0VHo3c2NV?=
 =?utf-8?B?cnlTdHpmNmh0OHlZTkcrYjExZUtzcUt0eGJmRVpTODhxSVllb2xwaStEZmtu?=
 =?utf-8?B?QW8xQnNvdHV6UEgvUU9kOVd3dmxVM0xQQjRnTzZidFVyWHBvSG1qL0dXZW1Z?=
 =?utf-8?B?czhPYlBIVTFhaHQ3em51MnhBRkg2KzFWczFTb1YrdS9uejljaDVwMjNhSzJ5?=
 =?utf-8?B?cG5OWlZKSzQrYm51YmtCVkZLRUduR1pTR2VIYlhZUWRYVWRydEZSSDhwL3NB?=
 =?utf-8?Q?0S23PEigagCWizL8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfac16bc-d56b-479e-008f-08dea05194b1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:28:58.4181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5ksehTdXg36Y2xjluCsvx6ppxF4TF2NOlNuDP4SuhBw+9dSAP+ewmEZHDUIBJB+mC4griM83+OdxaH0kflugbRrBbKaO5KbKocdsANkHtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6108
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Lok,


On 18/3/2026 11:17 am, Chen Huei Lok wrote:
> Migrate the legacy n5x platform to use the upstream Linux device tree
> configuration. This helps reduce maintenance overhead and aligns U-Boot
> with the Linux kernel's DTS hierarchy and naming conventions.
>
> This change improves consistency between U-Boot and Linux by removing
> custom/legacy DTS handling and instead relying on the standardized
> definitions provided by the upstream Linux DTS.
>
> Signed-off-by: Chen Huei Lok<chen.huei.lok@altera.com>
> ---
>   arch/arm/dts/Makefile                      |   1 -
>   arch/arm/dts/socfpga_n5x-u-boot.dtsi       |  18 ++-
>   arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi |  20 +++-
>   arch/arm/dts/socfpga_n5x_socdk.dts         | 122 ---------------------
>   configs/socfpga_n5x_defconfig              |   3 +-
>   5 files changed, 33 insertions(+), 131 deletions(-)
>   delete mode 100644 arch/arm/dts/socfpga_n5x_socdk.dts
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 82ad3035308..3c62b784ffe 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -469,7 +469,6 @@ dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
>   	socfpga_cyclone5_socrates.dtb			\
>   	socfpga_cyclone5_sr1500.dtb			\
>   	socfpga_cyclone5_vining_fpga.dtb		\
> -	socfpga_n5x_socdk.dtb				\
>   	socfpga_stratix10_socdk.dtb
>
>   dtb-$(CONFIG_TARGET_DRA7XX_EVM) += dra72-evm.dtb dra7-evm.dtb	\
> diff --git a/arch/arm/dts/socfpga_n5x-u-boot.dtsi b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
> index 326ba722a25..477af977f78 100644
> --- a/arch/arm/dts/socfpga_n5x-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
> @@ -10,7 +10,13 @@
>   #include <dt-bindings/clock/n5x-clock.h>
>
>   /{
> -	memory {
> +	aliases {
> +		spi0 = &qspi;
> +		i2c0 = &i2c1;
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
>   		#address-cells = <2>;
>   		#size-cells = <2>;
>   		bootph-all;
> @@ -121,6 +127,15 @@
>
>   &qspi {
>   	bootph-all;
> +	compatible = "cdns,qspi-nor";
> +	flash0: flash@0 {
> +	};
> +};
> +
> +&flash0 {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "jedec,spi-nor";


upstream DTS has this compatible defined, so the overrides is redundant.


>   };
>
>   &rst {
> @@ -200,7 +215,6 @@
>
>   &usb0 {
>   	clocks = <&clkmgr N5X_USB_CLK>;
> -	disable-over-current;
>   	bootph-all;
>   };
>
> diff --git a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
> index bc2fb91dfb5..f013ed49cd3 100644
> --- a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
> @@ -8,12 +8,11 @@
>   #include "socfpga_n5x-u-boot.dtsi"
>
>   /{
> -	aliases {
> -		spi0 = &qspi;
> -		i2c0 = &i2c1;
> +	chosen {
> +		u-boot,spl-boot-order = &mmc;
>   	};
>
> -	memory {
> +	memory@0 {
>   		/*
>   		 * Memory type: DDR4 (non-interleaving mode)
>   		 * 16GB
> @@ -38,10 +37,21 @@
>   };
>
>   &flash0 {
> -	compatible = "jedec,spi-nor";
> +	reg = <0>;
>   	spi-tx-bus-width = <4>;
>   	spi-rx-bus-width = <4>;
> +	spi-max-frequency = <100000000>;
>   	bootph-all;
> +
> +	m25p,fast-read;
> +	cdns,page-size = <256>;
> +	cdns,block-size = <16>;
> +	cdns,read-delay = <1>;
> +	cdns,tshsl-ns = <50>;
> +	cdns,tsd2d-ns = <50>;
> +	cdns,tchsh-ns = <4>;
> +	cdns,tslch-ns = <4>;
> +	/delete-property/ cdns,read-delay;


This is contradictory. Setting a property and then deleting it in the 
same board overlay is nonsensical.

The intent is unclear, if read-delay should not be set, don't add it; if 
it should be set, don't delete it.


Best regards,

Tien Fong
