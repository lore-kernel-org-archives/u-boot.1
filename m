Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F35FC47073
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 06:03:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C1F6877EC;
	Tue,  9 Jan 2024 07:03:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jt5XDwEc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74D99876FF; Tue,  9 Jan 2024 07:03:09 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4038877F1
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 07:03:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbSAFcFK5XqTYDhEOb9SSPPAT+JYELR//pEIAUZwvJ6knThb4dUGrZcyJ7ZNEvmlHUNcrIkVDpkAJtXOOgQ70+gdwkl684HHUUu4Mab2frhNFvVU6LVQ/Kph1H7ZQ44PRtZXo96LMSkbrYxl+Ey3YxXkcAfMKWG6LGLNoRxRD417dk4NUZb5ioA1woRflw2NXChJfirY51AExLJJxpjv4I5U6abV5SAsMUjXowKU0Hq/FRZIBD6hK0SyhMJu8K0j35MppH3ev3HM/QBMcoCNNcOmU7j0r3Vvbo7hFZ+xzBNdcAUw74YJ+BmVM68oAaasKDy7lyGwRacPx3xzRo3Hsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MLZ7E8GKDthGfc1HAwFF4QeJHsF7YEMjJAUVBRyLTQ=;
 b=nOegEjISTTiP0XcFcHWM1tWKpRkt/ek6kG0WXk1BcxVSqjz5jzc+6ve/m3kzPD1hTqExlJ+nBhZQbKTFiJ15T1tRiCjEs55B3Z1vJUgTOr3znsgTLMCja8VFY4cseS9C60MlTb0ep2z/GKMlFcwadiro8n47ubek8uWJioMuj6apW7bfw9vNL6GBSm0xSxNfQleLIja+DTAJPOG6qwIz9g1GrvAd5ZltKz0r4ZR/6kw2QzLkhRSXR/5GaCoDiqHmI9IxJ/UcDtHGoZZAG1gO2jt3dpkMxbnnlrYVf54ZHcerr1TZqQzGqxLZAuVITlOwZH+wqAW7D0ahrqbI3Xy8sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MLZ7E8GKDthGfc1HAwFF4QeJHsF7YEMjJAUVBRyLTQ=;
 b=jt5XDwEcnbJ971tTK2egF6XvulJs+0eiW8Dhpikjwig29jaVYfakAIyHcIYEznJdJSM6dWNc5gg4luahkFamoA5hbui1a60xNh+CRpA3WFHbKeHUsKi70MvwhnclavXVmHYuNJg0LxAdMLQBBV75xIh2jHZHAw+BmcObEloXhx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9694.eurprd04.prod.outlook.com (2603:10a6:10:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 06:03:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 06:03:03 +0000
Message-ID: <4ce97973-f68d-0eee-5133-efc8689dee19@oss.nxp.com>
Date: Tue, 9 Jan 2024 14:02:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 0/4] Add imx93-var-som support
To: Mathieu Othacehe <othacehe@gnu.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240108092416.23591-1-othacehe@gnu.org>
From: Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20240108092416.23591-1-othacehe@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU0PR04MB9694:EE_
X-MS-Office365-Filtering-Correlation-Id: 023dd9d3-15a4-4873-4d12-08dc10d8a412
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9yK7ytF7pN6If6WE5ypYV5AKrCQh1LYu7lq3mGIbi3gYiYC4F23C/2OpzopqcyT3YrWeVidwpzHaSc4148e2lo0VG822GgNgGzIE8D8BYtLceQhCVNzZM3Q9581KQPN7nU3KcrzPGn7tioVaNuyELfrQf25Sd9pGNWOqy/SxippCUkVbgHI1mxVD/ACR4c5qr5LDjpPJuZaLAL5uSN94ZA2kx20SjQiu34EoDXTZA2UFHDpKD3YA/UfLSVqqlUu9BqTKhYJPE8L27YBFB9XSZmISUs36HZzSH+3sNTzgfUbLXNk6H+bQ/xae62YOUofHlvJ76MIc1Kdk2/ZsK1lOxw/VC6DeamEls7/GSn1HjgvKMVpU/yOugsIZhsnG27VGLbzNJ/3+kD4Nl/BSvFUt8wVVFksqcXaz8HWOQ0krd0e4fKCkJyMJLQK/vBgwUaRn41vYT1/36XYMb9gs1OMeIoHib7wpqqCWLLrvSZ969xFd0FoogUSRlhxKUDeUO4KU02KsC9fCeMnCfKUFnhw6fh3AyxbDswNHhb8DUNZycIv4O93FRVxl+a2vJk838d46njMm0diQrPCZaGSFb8rlbHefSEGS7fgLIuBhSllqv0dRZHDaItAZP+83pFnAH6AgL0hQ24E042zvoXkEnz3Icw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(66556008)(53546011)(66476007)(478600001)(66946007)(86362001)(31696002)(6486002)(83380400001)(26005)(2616005)(5660300002)(2906002)(6506007)(6512007)(6666004)(966005)(44832011)(38100700002)(41300700001)(110136005)(316002)(8676002)(8936002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmphSG16WHNyaUZGZ1BjSm9iemFsZWYzOTBiWUVyMmFaOTJUMVMvUXFEMnJ6?=
 =?utf-8?B?YlhTa3Ivakp0enZ1aTFZU3R4c0l5M2NBcE9CL3pwNnVJUWxNazFNOVM1V0Ro?=
 =?utf-8?B?WUVlVDBZR0FOOW42NW1Ec2EvNDkrV0FTYlpBNy9QV05aMkNqY0pSejdLTFNp?=
 =?utf-8?B?OEhFQll1RzJSVldyUElyay9VODU2V010K0Z4ajNKY0pBZU1TUTB2VmV6Tk5I?=
 =?utf-8?B?TWhxbVRNLzV5ZWdJbGQ2SmxTNzNZVG94Mjg2Sm9qWWF4YVBjY2RONGFsTXFW?=
 =?utf-8?B?c1RzREJpT0VQNks2S1BBMFR1SWJHbUFQYlk5Q3BWZVBna3ppTkxxQXY5aUpS?=
 =?utf-8?B?T1RPbFdveWJsOUE4dDl0WEh4cUh2eGJHVGxrKzM4NTV5MzlPVm9IR1BaUjNS?=
 =?utf-8?B?bGVFTnJEbDJIbElQK0FnVTlWSEsvUy9tZ3NLcjFQWi9nRTRtMGlaS0dmcnVx?=
 =?utf-8?B?MXNweDVSUW94S0prZGRwc2htd2hKNC96OVo3VzNBQkU1SVp0Q3c4Y29kWnEr?=
 =?utf-8?B?NHN6NVFxVUgzOVhOZlh0ZThXOTJMa1FCWFFYN1diZEhlOElIZkk3Wjc0WHVM?=
 =?utf-8?B?aFRyaTZXdlZYTHNEOHdtVEgvaEFySG9mSHlVMDVGcm5hY0pKeDFRUkVqam9T?=
 =?utf-8?B?MjNZTFdia3JJaXMzODZpTjRGNGJKdnMrSGUzZHB3RTU3dmI1UE5oNXJBME5V?=
 =?utf-8?B?MlpaOFMwd1hrVVFSaEUzVFJEVUt6N2VFdmlWRTEzWEpqQlRGK3NjbDRDMGJa?=
 =?utf-8?B?SW5uMlZwbmE3NDRCQzBnT0MrV2tuV0FqZWVHbnh6bXM1L0V1MmFJenRRdVNB?=
 =?utf-8?B?Qjhvc09ZZGY1azFjR21obGpqbWpMTXhwaVJhSkNnbEZOQ3FJd2wwZmpjZkgw?=
 =?utf-8?B?NjVDK2pkTWMxRDRBZE9jK2pSbXRISTRzNnIwVEIrY3BRMTlicFJaZWk3UXVF?=
 =?utf-8?B?RjJBVWFIclZySkxPRjdyWi9ybW9YTDEyOWVLTmQ4ZlZqMXh6ZkxsZGo5bXZh?=
 =?utf-8?B?bWhTR3c0SERhc0h2ZEpSSHR0K3p6SVFtMFl4Q2xESlExRHQ5M2JTSWNUajZh?=
 =?utf-8?B?aXRiR0dlaEw3N0lKTnZ2RlhTV2wrTVZ2L2w0MTNLMEVIWXFjeVdLWU52b2tG?=
 =?utf-8?B?TUx4WDVwWDdMWVBxWmdQVjZnQ3gxVUw0VS9DSnFGK0JWU01BeHlhc1JLeHVj?=
 =?utf-8?B?V1VxSWVvQlU5ZkVOTm1iVHVOSHlIc09DUzlLMzNNdUd2emJGcHFlNy82UFRv?=
 =?utf-8?B?VnpQeW5pcVpDN3FGaFFsSnBObWxPZ21oVVlIL1ppSk1SMG9EblAzUk9jQ3ZK?=
 =?utf-8?B?bzI2R0hpVkFreTJRb3YzSlNVckR6alQ0MERQVzEzUEVUZUtVTmRVeUp0MC80?=
 =?utf-8?B?a3dGaUUxTTNrVCszMzk1VE9abEw4cHlCZDF2YW5Rb0ljTUNoTVFwb0RRN2lU?=
 =?utf-8?B?bXZrcWJ4M09MOEhwV0lORUJZMWVsNVIzaCtxbGt6QkNUdTBYUXdEai9vUUU2?=
 =?utf-8?B?MXJVUjl5OFpQK1FBYy9SS3R5U0J0TEVpMnZhNm53b0RZUTBiN0pmMzVjUWtX?=
 =?utf-8?B?U2FhZ3RMcGpEcmpDTzhsMzFYd2RSbUh1emVVVkVSWkEyallQK2IvVTBkd1Ay?=
 =?utf-8?B?NEU2ZTkyMFI2c0VKejVoZklJRjdib0xZZUxEdVlIcmw3aGlqMFlHVjdrR2hC?=
 =?utf-8?B?bnVuanBLZW9kUnVGTTIreWJOelRIU2gxZmVKUlE3MWcyM2NiK1hnOUJnZ1g0?=
 =?utf-8?B?SlJhMjY5eWZ6QkpxeVpkejVjM1RmMkhhMFVYTHVaVmQ2dmVMWm93dUh4RGdE?=
 =?utf-8?B?a2FWblhKWUE1R2J4ZHdVZTl2QTdJRjZ2dFVpT3cyQXFUam5sYzc2cVgzT0xs?=
 =?utf-8?B?ZFRTOGJRb0Y3THBSakIrcWt0WUJaS3lzUXU1ell3dEZONk9KMEVzdnlQSG5E?=
 =?utf-8?B?VGRrQzRqbmFTSVZOUFJ6M2F1Rk5vUWF0a2FzdmtRR3FrT3Z6NllLV2pwbjhG?=
 =?utf-8?B?TXU5Q3M3TWhCalduZkh5TkY0RkdiSExDYjlsOFhka2NQeW5yeURhaklaSmZ3?=
 =?utf-8?B?Q3ZsSGZhbWh5cXlCQlJYQlVVVnlsNU14QTBaNzZ3WlhNSnZaMnEyVjJCc3dN?=
 =?utf-8?Q?uHReQxxpAdVkl1eCSPbqpbITN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023dd9d3-15a4-4873-4d12-08dc10d8a412
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 06:03:03.6776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8oWX78SVDv/vE0KcVApN6O5CSSjuNol0Hcth6DhEbN2jaPEk6YrFQ3ABJpqvOmRLRZD2VquWloqxg/zxRG/S7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9694
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

Thanks for working on the binman for i.MX9.

On 1/8/2024 5:24 PM, Mathieu Othacehe wrote:
> Hello,
> 
> This v6 fixes CI checks on IMX9 by allowing binman to keep working even though
> some binary blobs are absent.
> 
> Thanks,
> 
> Mathieu
> 
> v5: https://lists.denx.de/pipermail/u-boot/2024-January/542579.html
> 
> Mathieu Othacehe (4):
>    spl: binman: Disable u_boot_any symbols for i.MX93 boards
>    mach-imx: Add i.MX93 binman support.
>    imx9: imx93_evk: Add binman support.
>    Add imx93-var-som support


The patchset looks good to me.

Reviewed-by: Peng Fan <peng.fan@nxp.com>

> 
>   arch/arm/dts/Makefile                         |    3 +-
>   arch/arm/dts/imx93-11x11-evk-u-boot.dtsi      |    2 +
>   arch/arm/dts/imx93-u-boot.dtsi                |   88 +
>   .../dts/imx93-var-som-symphony-u-boot.dtsi    |  266 +++
>   arch/arm/dts/imx93-var-som-symphony.dts       |  305 ++++
>   arch/arm/dts/imx93-var-som.dtsi               |  111 ++
>   arch/arm/include/asm/arch-imx9/clock.h        |    1 +
>   arch/arm/mach-imx/Makefile                    |   27 +-
>   arch/arm/mach-imx/imx9/Kconfig                |    8 +
>   arch/arm/mach-imx/imx9/container.cfg          |   10 +
>   arch/arm/mach-imx/imx9/imximage.cfg           |   10 +
>   board/variscite/common/eth.c                  |   58 +
>   board/variscite/common/eth.h                  |   12 +
>   board/variscite/common/imx9_eeprom.c          |  190 +++
>   board/variscite/common/imx9_eeprom.h          |   83 +
>   board/variscite/common/mmc.c                  |   47 +
>   board/variscite/imx93_var_som/Kconfig         |   12 +
>   board/variscite/imx93_var_som/MAINTAINERS     |    7 +
>   board/variscite/imx93_var_som/Makefile        |   17 +
>   board/variscite/imx93_var_som/imx93_var_som.c |  126 ++
>   .../variscite/imx93_var_som/imx93_var_som.env |   99 ++
>   .../variscite/imx93_var_som/lpddr4x_timing.c  | 1488 +++++++++++++++++
>   board/variscite/imx93_var_som/spl.c           |  143 ++
>   common/spl/Kconfig                            |    2 +-
>   common/spl/Kconfig.tpl                        |    2 +-
>   common/spl/Kconfig.vpl                        |    2 +-
>   configs/imx93_11x11_evk_defconfig             |    2 +
>   configs/imx93_11x11_evk_ld_defconfig          |    2 +
>   configs/imx93_var_som_defconfig               |  156 ++
>   doc/board/nxp/imx93_11x11_evk.rst             |   68 +
>   doc/board/nxp/index.rst                       |    1 +
>   doc/board/variscite/imx93_var_som.rst         |   68 +
>   doc/board/variscite/index.rst                 |    1 +
>   include/configs/imx93_var_som.h               |   48 +
>   tools/imx9_image.sh                           |   31 +
>   35 files changed, 3491 insertions(+), 5 deletions(-)
>   create mode 100644 arch/arm/dts/imx93-u-boot.dtsi
>   create mode 100644 arch/arm/dts/imx93-var-som-symphony-u-boot.dtsi
>   create mode 100644 arch/arm/dts/imx93-var-som-symphony.dts
>   create mode 100644 arch/arm/dts/imx93-var-som.dtsi
>   create mode 100644 arch/arm/mach-imx/imx9/container.cfg
>   create mode 100644 arch/arm/mach-imx/imx9/imximage.cfg
>   create mode 100644 board/variscite/common/eth.c
>   create mode 100644 board/variscite/common/eth.h
>   create mode 100644 board/variscite/common/imx9_eeprom.c
>   create mode 100644 board/variscite/common/imx9_eeprom.h
>   create mode 100644 board/variscite/common/mmc.c
>   create mode 100644 board/variscite/imx93_var_som/Kconfig
>   create mode 100644 board/variscite/imx93_var_som/MAINTAINERS
>   create mode 100644 board/variscite/imx93_var_som/Makefile
>   create mode 100644 board/variscite/imx93_var_som/imx93_var_som.c
>   create mode 100644 board/variscite/imx93_var_som/imx93_var_som.env
>   create mode 100644 board/variscite/imx93_var_som/lpddr4x_timing.c
>   create mode 100644 board/variscite/imx93_var_som/spl.c
>   create mode 100644 configs/imx93_var_som_defconfig
>   create mode 100644 doc/board/nxp/imx93_11x11_evk.rst
>   create mode 100644 doc/board/variscite/imx93_var_som.rst
>   create mode 100644 include/configs/imx93_var_som.h
>   create mode 100755 tools/imx9_image.sh
> 
