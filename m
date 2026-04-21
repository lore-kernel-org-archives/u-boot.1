Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BADF327CD
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 09:26:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C14CF843C0;
	Tue, 21 Apr 2026 11:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="kcYQPnyd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77FD58444D; Tue, 21 Apr 2026 11:26:10 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 496B98439E
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 11:26:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MO93/3+fmuZJ2IicXKQFQFNyvPnxFMLmyaOnZFFsRfJsTBWNnejCrT2KuUlrju0X3OEKR7AFxtMFm5um19Kt5so3r0UBUX+IH+u5rmqNxABWgiRlEBN+6aSkdD63nm5EO9BnMa6Qm9GEG75YPbbGSUlAnRTblq6omAAJ9rq7iQuGvFwCGz0PFiH4hMsdbJngLIkiSDnYwtJWJVFkCSvpgm4fOCIyWRPoK1LyPSatBPFopJhFgtHCe2ElBr/RUWNPAgvE13iCg04VepJwlMsAebuIUhURpo7OOWHrjJ1lPYqpv6plEmB0FvmDcjDUTeRDkdyUUp+4QJ2w0wyo7ZgXLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/GVRLl/RP3wnuiQyxkEfo1dOU4L33qNZf79lVm9AI0=;
 b=SaFNNl/0JIkpKzrRbtCD0AHw1QBVsx/6N2rPKYatQd9zRuxRoHZ8GI0B2F8KLtGyhW+o00zpwb866oyTLQalJKpeEsR0W+bnPr2WKZkj10wETlY8rT7cLr80vomzSpUBhwBUG9y2iAD5XLTsflhdCzYdQbhR4k6goPfOWURegg5UKd5vn0IWBOfzGUjCc9BaTK/ViW0uNO2U2AP+1YTHk7F7fHsYBXtKQ7Kl7odJP2LsNdHbJuostlR22OC515cYbHjTz2POY6MZ/SHhda8ztRxhF/YkUomKh1JOGulNgrNKkslLfkEzka3uxIHgP6ezfQMGycKJ1wZ6EDRKiJlBWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/GVRLl/RP3wnuiQyxkEfo1dOU4L33qNZf79lVm9AI0=;
 b=kcYQPnydLnDe6qV18tyBnSM40Lun2nFDS1hyI82Eavr28hmkCxwLN/nzS/dNymSlwDtX5vpzAhAI4BPAol+gM7Uk/bsTOsFqjxD3NsDDxAmAa0RmW8kmMIwOasUedBmHeLHogsiSmCd74IudAq+BB6zSsjQIOrGaNElAqnb0r1yKZbsH7tsuZirhnqvHlYLfJPI8OlzTjnTwmrrvSVLcYrYaaxhXBfUi3TsBv3YAIXYZxxDN95dWT84ipymBN3TYo6CZWuEieBSqMzR+CRAXKcvZlI6JtS7drKU5d+ST7L/rYSpfkVfy60KkUdgpoxP8/zX3wld6zdxuPnowACVHKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by SA0PR03MB5641.namprd03.prod.outlook.com (2603:10b6:806:b0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 09:26:02 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 09:26:02 +0000
Message-ID: <59456182-5ab3-4558-9586-c3333e7d5dfb@altera.com>
Date: Tue, 21 Apr 2026 17:25:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] arch: arm: dts: stratix10: Switch to using
 upstream Linux DT config
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <20260403022513.9446-1-alif.zakuan.yuslaimi@altera.com>
 <20260403022513.9446-2-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260403022513.9446-2-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|SA0PR03MB5641:EE_
X-MS-Office365-Filtering-Correlation-Id: d93b8239-9bfd-464e-c022-08de9f880151
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: QliHO+zcS8U/vt5pF3g1gZaz4bDydUEyi6zu2o7HZMNtnFJog3dHfhw7U6cMqFGLY0IJkNQjxM8ZAKDAViJD/7gPKvgFJjuSouk01bXWzVgP0J5I7RTEomXTlr33OPS/yQG+xoreH2emY20oGfbWDZiXXTCPhYfNIKbT+CAzOh4XedhUEV/wsjN2qfsgkuRLFW8nCF/LbkbRgOzuiiHcvwXHmCJLoEOUHrq2QDCEl6z6VQoYv0IRx6oQZ2PBHP1TE6O/wsU3x0MS+x/K9rAqEu4J852DxTzaLoN/PQ1Sclaj6o0S0OldZN2h6rfcOyvpDPGPB83mDoURb1psM1kMeTr8OM3DLW4ecxp4Y28IgL6rWAiaXpr5D9odKwk+YE3ePznsmnw0tvK3EjtSYhsmrLDKscaqjnqiSiq5socD42UI+aKFkQrpOYWzgHsmKNUsY6bXeF+XPwG5AloCBhHkOaQzpOwhnid/yJOz+RZelAmGO8wjUPX93V217cJg/BPbC1gV790VGdf/62GTPTIvVW+LjPthlsV6/uXIyc2NlgZryrX5jOztk1g1cyOwa/hD8P1aOwcGyGxJa2idsbprS8eumJrrx74j8y4csGLEYPza2zfuE0cht/giJ4JY49/rQU5ftCzoSfbHfyNIPjitbfrajfeUau7LKnUigpeP6A+tb1/Yke6Ug0rbkbDy+Zeg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHlBQ0lVWTdlcS84RWRPTkxuTzJsYmVkME11dmpVOUJGbGlxVE5NU05vWEN4?=
 =?utf-8?B?elovUTJNTVlrTS8vbnNQbVhHZmcwczY5ZUpCRGhrVlFSTjJmTGx3dW43ZjV5?=
 =?utf-8?B?UEtmWW15M0pDYXpJVUZxUEl0QXZ1amgwODM3ZWdDUXo3OTBwSDR5WTZHK1Y1?=
 =?utf-8?B?NzJLcStoZDY3L3ZJZzlpOGwyUGNielVrMEx6ODJFc0l0N1lqelorT3psMjdV?=
 =?utf-8?B?VU9wdzdrNitDcUZKY2tGRSt3ZWhVSndHQ2JHWklSYVl6R21ra1h5SmV6UnBP?=
 =?utf-8?B?TVc5SUphL3ZmU3ZNL2twOEw4Nk5lanBseEZMemE2RkZMcWJJYURyaFcxbmV2?=
 =?utf-8?B?Mm1HRVZTL090NUNUWVN4NnlYWXlHZERXTDZ4YVdpL2YxNTdRR2MwdzY3QlZv?=
 =?utf-8?B?V2VQRGxHYjBJSGlnaVVEK1hyRkVsdk4xS3BwSEcvUDc1K2swV212QjZlNDFi?=
 =?utf-8?B?VTNab253ckFTRHd5bnJIdThGVTlrVjhtZXE4OWtDbFlkQ21rZFNmd1FMNFdm?=
 =?utf-8?B?STFUdXR4QTdwb00vU1ppN0R2UUJPbWFqS2lLbW9iNWhRUkNZWm5oTlpOZGF4?=
 =?utf-8?B?dE1FQ2UwUE5qb3l5TVo5ZEIzVXMyVGJyRFJna3lsYlc1bkhQaUI3dEhycVp1?=
 =?utf-8?B?dG44OE0wdXBnQ21FbGRSYTFscnFHaVlTTlJFeG5lZGFRWGFMNDR2dzcwUytX?=
 =?utf-8?B?MGNXanFjYjZhdzdYVjZQRFk1NW1KMXFIcEZoekNpakl3MDdiWHBYVEhtZklz?=
 =?utf-8?B?S0pVc1lUQVN1dHZteEJNSjY5d0lPMzR4d3VQUllYSHFOMlVKZ3pjN3BwM29a?=
 =?utf-8?B?UjVacExFK3phQkZZYXBjSDIvSVJxYWJOeHhtVTdwQW5FK3N3T1VFNEVUdXA5?=
 =?utf-8?B?ZHpmamRqVUdKY0Y1RHFyeFdyWXBwUDdhdEw2Rnk1b2Q0VFc3Umc4Z2JsdFVX?=
 =?utf-8?B?Sk1FeDdNRmE4U3dvZ2NNWVpEbTJXU1l6dS9vaUo2cGMxdkQ4MXZpMzcvN1Ju?=
 =?utf-8?B?M3FqREpSNk9NRWJrSk9iUU5RWUZobHNhY0Y2NmxFWi9mL0gvcjVXU2t6Mit4?=
 =?utf-8?B?aFN1S1NTNWxjSThTb1F3dkZUTW5wbFNOaEpGZUdCaXBVNE1YTit3dXVTRjdx?=
 =?utf-8?B?TTMrcFJnQW5QOVNJOXl4Z1BDdjFqb01wdkpTbnFMcllKZE0yYjBnTFl4eWkw?=
 =?utf-8?B?aDdxMlV2L0FBUFRzbkkzc21JY1lCSitsMlZIeXRHenVCTXVIU01tZTBLZ3Bx?=
 =?utf-8?B?VDVlVkFKZEZGTEd3R2FxcG92M2J0WDBMT3NKblZUSTJLVWxzakw0TWc4ZHJV?=
 =?utf-8?B?NjRiYmg1U0NrQlFUdXBqekJuc3dhemlZWDVYb2hyaE1Oai9EMkp5NmhseUVE?=
 =?utf-8?B?Y2FOQVd2RDN6Y2wvNnlFZ1pHWU1zQUpaL213SHhWM2JZMjcvc0Q5dGNLRC9s?=
 =?utf-8?B?cXgvSFhrSW9kM1FTdUliZCtwdjdqWUxqN3FGSzBGUDhtWGNyc01reFlhc2Nj?=
 =?utf-8?B?OE1uRk9yQlFMa1QzVW5POFgzdmFLNTU2R1k0WkxwREVkM3lXdnpQL0wzS2lL?=
 =?utf-8?B?ZlRJV3Ivb081cUlYeXVEYTVTQ2c2dGE5SEZ1YUdUeFpZd0EwL2kybGNNeWdp?=
 =?utf-8?B?cnZYMTBrcEJKQkJwS3ZsU1B1Qms0blBrOFIzNEpXakdIdm5GdlZvWVgzTDdj?=
 =?utf-8?B?d2tiS2NCOEM3UDNjdFA0a3dYc1FUaWJzUWU5M1U2eVRJYmZPTkdhR2lpTDR6?=
 =?utf-8?B?NUdOS3lwRXpPS0V6c0h1STFFZkFkci8rczZxYk4xWjNyNCtjUnVFQmwvQzRv?=
 =?utf-8?B?Qys3NkhJbkk1a29oaDluYWVPRkRuS284cVNQNHpDckJCTXkzcXdGR1NHWUpX?=
 =?utf-8?B?ay9aQkRzRXRxM01na1lFd0tCWDFBOURHcUlXTTNtS3R2Q1FnVnQwVE0veXQr?=
 =?utf-8?B?WU5La0NDYTNPQVhhWndwdUEzTThqcTM4d2dYbERZMzZuazlRMUF1eTIxMXp2?=
 =?utf-8?B?YW9TYVd0YzRzUURRcjA1QWRnK29TRjB1U1NBMGkrVGJzZHF6K2JFWmhOTEsv?=
 =?utf-8?B?Sm5hencyMEVCUVQ0NzlKMkZMc3ZaY1VINjVDeWhQRjl6MjVNUklvZ2U4Ykhz?=
 =?utf-8?B?VmZ4ZldqNVQ4T3pqNlFjcmtYakN5MVJOQnM3NWRVYVA5d1Flbm1yU1N2N1ov?=
 =?utf-8?B?V2g5TFhqMzJqNGFOZlpEaG5sWlZVdENkMno4a0VmeStQL3hYN09XSTF2RlU5?=
 =?utf-8?B?TWRCZDZWMmJaTmJCMEpVWXY5S3BRandOYjc0eGlCR0tMR201OEY5dXF0VnB2?=
 =?utf-8?B?emZ2eHZoQ05HNDZuRE9ycG1aTnpNdWN2c2RGUlp3a3pVT1hKdWg5ay9Lcm1K?=
 =?utf-8?Q?O7vUhp1vER36rzgM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93b8239-9bfd-464e-c022-08de9f880151
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 09:26:02.4322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSEoeKLajegpfZthcueiLsb0m+/N8d+67mOJbFL/mhBPgdPz7ejRsvuwLSxJinx9mwY9BGsqokPKTloCTd7ePz6TJ06XF5nX/RqMS+5up9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5641
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

Hi Alif,

On 3/4/2026 10:25 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Migrate the legacy Stratix10 platform to use the upstream Linux device tree
> configuration. This helps reduce maintenance overhead and aligns U-Boot
> with the Linux kernel's DTS hierarchy and naming conventions.
>
> This change improves consistency between U-Boot and Linux by removing
> custom/legacy DTS handling and instead relying on the standardized
> definitions provided by the upstream Linux DTS.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> # Conflicts:
> #	configs/socfpga_stratix10_defconfig
> ---
>   arch/arm/dts/Makefile                         |   3 +-
>   arch/arm/dts/socfpga_stratix10-u-boot.dtsi    | 158 +++++++
>   arch/arm/dts/socfpga_stratix10.dtsi           | 430 ------------------
>   .../dts/socfpga_stratix10_socdk-u-boot.dtsi   | 149 +++++-
>   arch/arm/dts/socfpga_stratix10_socdk.dts      | 143 ------
>   configs/socfpga_stratix10_defconfig           |   3 +-
>   6 files changed, 292 insertions(+), 594 deletions(-)
>   delete mode 100644 arch/arm/dts/socfpga_stratix10.dtsi
>   delete mode 100644 arch/arm/dts/socfpga_stratix10_socdk.dts
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index d90e02ca4e5..91da88481fa 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -460,8 +460,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
>   	socfpga_cyclone5_vining_fpga.dtb		\
>   	socfpga_cyclone5_ac501soc.dtb			\
>   	socfpga_cyclone5_ac550soc.dtb			\
> -	socfpga_n5x_socdk.dtb				\
> -	socfpga_stratix10_socdk.dtb
> +	socfpga_n5x_socdk.dtb
>   
>   dtb-$(CONFIG_TARGET_DRA7XX_EVM) += dra72-evm.dtb dra7-evm.dtb	\
>   	dra72-evm-revc.dtb dra71-evm.dtb dra76-evm.dtb
> diff --git a/arch/arm/dts/socfpga_stratix10-u-boot.dtsi b/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
> index 3e3a3780469..a3b4c0564f9 100644
> --- a/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
> @@ -3,6 +3,164 @@
>    * U-Boot additions
>    *
>    * Copyright (C) 2020 Intel Corporation <www.intel.com>
> + * Copyright (C) 2026 Altera Corporation <www.altera.com>
>    */
>   
>   #include "socfpga_soc64_fit-u-boot.dtsi"
> +
> +/{
> +	aliases {
> +		spi0 = &qspi;
> +		i2c0 = &i2c1;
> +		freeze_br0 = &freeze_controller;
> +	};
> +


[...]


> +&spi1 {
> +	compatible = "intel,stratix10-spi",
> +		     "snps,dw-apb-ssi-4.00a", "snps,dw-apb-ssi";
> +};
> +
> +&binman {
> +	/delete-node/ kernel;


  Duplicate /delete-node/ kernel in binman: both 
socfpga_stratix10-u-boot.dtsi and the board-level dtsi emit this node 
deletion.

[...]


>
> +	board-4 {
> +		description = "board_4";
> +		firmware = "atf";
> +		loadables = "uboot";
> +		fdt = "fdt-0";
> +		signature {
> +			algo = "crc32";
> +			key-name-hint = "dev";
> +			sign-images = "atf", "uboot", "fdt-0";
> +		};
> +	};
> +};
> +
> +&binman {
> +	/delete-node/ kernel;


  Duplicate /delete-node/ kernel in binman: both 
socfpga_stratix10-u-boot.dtsi and the board-level dtsi emit this node 
deletion.


Best regards,

Tien Fong

