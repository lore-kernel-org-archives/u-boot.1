Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31CDCD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 08:52:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E87D8484C;
	Wed, 10 Jun 2026 10:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Pr2YYrbL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54DB284869; Wed, 10 Jun 2026 10:52:21 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B8384841
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 10:52:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7wQMzfqXgl2Lp/iYC/6H6+18VcRj85MQREpDTARnlBR2u2mLcLtoikgMb0PB9E62mHythiIboRzjKJ5QrK8OKtHD7wvMt7+r1Y6PQJZe2dorflKZj8VWNjkp2zdVuYffj8fip2aO2ESICBraEJzfFxKyh15oqKQ2BsVl3PyE3uTrwoW7HLr8RIm6BBh+ryMD4T6uTP3GlUZKxAathQhTJ1xU+NQZFzfqb8Ji90t/DlgTu+anFKErxb0rzmYtgHH7Py/kRmNfPcP6a627ncSeUYMbpRuI9rwY+u4Fb4GjuWqqrx6z+2yhYjEkcHI5Da4Oo9RfjYrkWk0Zmk33FnGig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0BctfnippuX37BIXnu2TzVK8PnGo6L4P4fq1HkG7dM=;
 b=eGPp5ltyy72DfgaYYI/H4Mz2Kib0HtslTvrao1G+c3PqjInR1e27TQAyM+sE6cwEAB6nivfAHndXxoJaLOcRnmhjQc3+u7vp4rwCJKoVcAFH1Y29dXSZxo2Ou0yJzjaVBtGYs0JlzHnNpHvSAi0KdCtU6L5QZNSMtFbokFGNrWH4f5oFHLjKTqGj19E6iYA/ewMdbC/stHHXTlZ/4fRlDdfN4Pf+6wwfE8OeTGGaqDZHZM+RmxDmRtZh4gViavJ7/+9wcWfuUJQTXKphAasYgzNkV0H3jS2wnXX9MejMYqujT/Yp354aLOHKnI534rWnJ5r6wbUQVQ80awlap4bZkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0BctfnippuX37BIXnu2TzVK8PnGo6L4P4fq1HkG7dM=;
 b=Pr2YYrbLEpGv7bw97tNORuCugfAo0R4wllc0kxM9y9yuPTZmKyE9Gtt+0wYwa7tMtacsBDtb6pekq2KBsm7cxJxF+R1h307DTP9dMVIBNTjuCE3r2ffr1BLNSYHJn/kfAXcDbRBCSzrNIo8+Q4lZVMVrqR52fERv1T3IxLMP6AWtEMDm4FCTdbhhpNWg8ebVbnbJrnqAx9HkKq6PQmUG1cA3iy237Tok+NQt36esrvZvxvfIrSSCUINkBjoeA+/SJwT97dgTUKYsYSZM4zWFQeo3c9+w/X97B0U3RDsKgUo0ruNClWH/IOEcFZq2guacndLntLFHZPrU8ia9t5ITNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by SA1PR03MB6324.namprd03.prod.outlook.com (2603:10b6:806:1b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 08:52:16 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 08:52:16 +0000
Message-ID: <efba333c-a51c-4d62-836d-f2a6d8a716e2@altera.com>
Date: Wed, 10 Jun 2026 16:52:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] mmc: socfpga_dw_mmc: Exclude S10 from legacy
 clkmgr address retrieval
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>
References: <20260605015503.11709-1-alif.zakuan.yuslaimi@altera.com>
 <20260605015503.11709-9-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260605015503.11709-9-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|SA1PR03MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 932cdd17-64f8-4078-93a8-08dec6cd92b3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|7416014|55112099003|22082099003|18002099003|6133799003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 61LoWhV0NWUpDEgrAfvCym5UduoRcC8WXyIYSJqEBOad7dQ+ceG4Gh3giadO+zYbJPsh8mqrzmf+WH1ngVAPe2G4h/VxSAwhJ5zmfsX/055pD7gpjMFeKBz/V7b2ytsbxKgnfAuI/TyYslSx4lNHEX/GP2ByZ4m1tv2xEwWLOQGLL4siuwzWJiVM9q0ERCTC0XggMqVBCcv5U/RxoMHXvJol+TBEWzLUjxevL2yuVIvuWK/TAKBvlFBUtgL10X76uT6POFUfm9Y1+/XcqRLebHXgeIfI0DC+z5y6mDUPdFLUb/TlUxCkgT1yozR4XeuggPC3Q3j/jmZm+oNPhtaBpDj1OaB082MSvoz1Jkbqhhi410O4/H96+pW+STFz1PpG0iEryZ4wCNSg6PKzdSzeLJ3MGT5Wxvn8QqwbtgZPOO5atCjkpsukizFNrYL1tYT4MVVOfY8sdLugJvqFPf0YQD4RoFCAnT6Au7I/TQbKXyeXDNtD2iaA0S4MiY9cI7Pm9550ZXJ5p+liz6Zntf5aeeZsR4m7hGS5Os1zgV4zkAcC0P8TRxBZ724401eN8pHqh5xsRtvmRcJWEVo+UVVdawmmh+tOO2MpJSTQ/UpB2D1m/7rMc0Z6GyarVf9Q5Ax/D6DEp8cgthc0TirO2nxQE09DmsSx2yPAVHfXd/ZgC4m4MpnQ7Ts+90usucT//deg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(7416014)(55112099003)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTVyeUhUQ2hCVDZoMmd5QnV3enBRNEtueUFQNUZJbjZSZ0pvZ2Ezbm0vN3Ja?=
 =?utf-8?B?bWtMbUtpd2RFc21TaUsrbkxZZVYxLzlkOFp1RkNnYUJ5R3YzT3IvckQ2SFJT?=
 =?utf-8?B?WnRCTTBjZUdMNE9scXl4SWJTYXh0TDBVY1dxVklSMWpvUjkzVU13RmxseDF5?=
 =?utf-8?B?VHFMNWhTa0s5V3ZwdlhyRkJORUVTV0M5T1NWeW9PQlZLSWZadWg5WXY4QU10?=
 =?utf-8?B?aHB3Qnl2Z09EQXBWY2FZbFhYbGk0bmMydVhIWjZ2SmN6Z3cyR244VFgxT3Vw?=
 =?utf-8?B?VC84M2N5dXlidFg2aFFvQ21WdVpVYnVFeGhDRmxrWWgzZFUyZ1Q5bkMrOFRW?=
 =?utf-8?B?Ri9aM05TS2E0a3JsSEk2eWR0VU1XZThVNEEwMm1Cd0JPbDVHeUFqSXRPVkhh?=
 =?utf-8?B?aGc0WkkzV1ZRb3pWKzQ0WDlxTHJPL3A2L3BnUGQ2bmRVQW9WWWs1dVkxK1d1?=
 =?utf-8?B?NFdVQ2JSMmlscStHSWpBbHZxSVl5bzNyK3VYdm84M3hMWlVqa015QUg5MS84?=
 =?utf-8?B?N2wzYUUvclFQakRoT24reE9vTEJQMTYxbm95aGNtMDFtNmJGcVVTNWJTZmhs?=
 =?utf-8?B?Z2ZKaTZUZTR0ZnFjYWh2aGY5ZEdnRmNFRTUvaDYvYk9YeHQrZjQ4d2x6Vlc3?=
 =?utf-8?B?UzFVbENVUGZ4ci96U1NMVSs2VmxXdXUyK0VOYXNxdHFmRm1RellSR1E5Rzcz?=
 =?utf-8?B?MGNwSlR0S2Z4dnNXaVBTMjRJRzY2UUp0UXMwdnV3Y2lQaHFGNVU5MGRHL0ta?=
 =?utf-8?B?VnVMR3N6ZzBCUGJLQWhPcUI1QmFzWUdWVEtYRGpRd0I3YmhwbndIQzkxdVN5?=
 =?utf-8?B?YXNrWUp2VGFxcXJqLzdBcnppZWh3SGE2ZlJBV29zWW02dHlsNXBia1I3UUFm?=
 =?utf-8?B?SENTZ1gyV0JPWnNTS2V6V1dUZXVYTEhZOXI2ZFJ0YkNBcXorelV6WWc0V2xE?=
 =?utf-8?B?WFVuTlY1WXRWZHZ5cjhTWXhQZHBoZWdScGNJYm9BQWhxQXVDYmtZcTllaWhH?=
 =?utf-8?B?S1FxZ2hYNUJEZVVuNWdBdVJwbmQyaThHd0w3NjdNTGFEMG83bWFtTFUxejNP?=
 =?utf-8?B?TUNJV0ZjYW1tc2NQS1k0azhqMDNhNXpPRWVDckQrV3JVZEd3dlJNYzkxVjZO?=
 =?utf-8?B?OUUyUmFBK1RSUkh5Q2tSYm56QWU1Nmdld0t1bUNDYTRQYVZlL0VzNmpNbnpU?=
 =?utf-8?B?Ukl5TzRXWmdoeUpWNm9vbDJzWldXd2lVM0g3K0pIK0QvenF1eUtZUHg3Uk5k?=
 =?utf-8?B?cS9CRHZsenZGY3ptWnBybllsck4yRVQwbVMxTFdKejdvcmNoL1B0NUlNQzVV?=
 =?utf-8?B?aTg1RlFBTWplRFFhOSt5MURDS3I2a3JMcVBTMW1UbkluZEh3eE9zcVcxQlJa?=
 =?utf-8?B?dkZNVHlsOWxnVklnU0d1clRRT28zcENocVN6aTB5aXpFb1poMGFsNGFZckx1?=
 =?utf-8?B?ZFo0NjErbGZLTmhWZkxYS0twWjZ1dTlPMGQ2VnJkeG52czZPNk81RnViMndT?=
 =?utf-8?B?WjJ3elZZZlkyY2RDbmNOODVQUnhaeGt0RGRKNjNJM01nUWp6RDZDNVF6cmVX?=
 =?utf-8?B?ZmpjNXY4ZHQxaVQyQ1NpaFFCYWZHQVArVHhLZFBpeENaYjR1clM1Q2M0UXVw?=
 =?utf-8?B?TkErRW9yQURXem5FeXNQbEgvbWovb3Bvc0ZOS1lTRUhyQksyVmRXbG13OWlz?=
 =?utf-8?B?T3ZadmFvaEVmcTF6ZjRzVEFoMkxzRTU2ZkhoQ2xjSERJSDFrakVKaVBNczRu?=
 =?utf-8?B?ME9ON1ZzaERoYjNSdUY3VnZLQ2xvUDdwRVViSUQrOUFqOGJLbEZCV1gra1gy?=
 =?utf-8?B?Q1ZPQWtNcGVVd1EwN2VwVmpVM0szZmlPeUIzQndWa2p1VnBqcnZsZHpadUQ1?=
 =?utf-8?B?dEdMM2YzSzhoU05OUnJVYmFXVjBLZEt2SkxXMDBFbFhWN1NUYjZzWWNjYkZ3?=
 =?utf-8?B?SzQ0bEhyVVlVcTNjSlhqL2t1M3RoU2VJdTNlMENEZFkzOEZqYVZZUk92SWs3?=
 =?utf-8?B?Q2IreXpQaVdUUWNXMkxjOTlYSTM3YTI1R3VHMHVaR1lzS3FQZFhCeGZPVURW?=
 =?utf-8?B?NlAxUjlJSFJrZC8xWjVoeC94UDBoUHN3RVFtdzBZeUhzN0x4ZW5NQ0dDQ3VW?=
 =?utf-8?B?L0J2WjVQYld6RWVyYUI3N0c5Rm0vQ0hiRjZ1QWZlMnNDcVZjNk1PRG5NWHoy?=
 =?utf-8?B?cVhOUkFaeUkxMGYySklwOTJGQWhOTmtpOGh1RlQ1WTNwajNMTzRXbkZabEpq?=
 =?utf-8?B?UFNjN2N5M0JoaG9hZ0ZxaHVoL1NObXhXT2JnQ3d6TGk5dTEzdjBKaDZCR3M4?=
 =?utf-8?B?dUpYeE5VOWt2eEVNamljRHJjbFR4SGdCbkhiUVhNVVNYMFBPeVBrVjh1R2Ny?=
 =?utf-8?Q?jS+VzXxWqmyl/CfA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 932cdd17-64f8-4078-93a8-08dec6cd92b3
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 08:52:16.7039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEYDKNOsbq42+R8vjpFmUl4oejf33cEINzYyzyATL1b5DMenp+buG/Dhqlb7z2/5Y/b6p43AV73xykzkIt9/sUE2CBgpak1Ud1v1eJhZcJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6324
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

On 5/6/2026 9:55 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Excluding Stratix10 from legacy implementation of retrieving clkmgr base
> address as Stratix10's clock driver is already following clock driver model
> and is supporting enable/disable APIs.
>
> The legacy devices' clock driver will continue to be refactored to support
> driver model which enables us to support enable/disable APIs for all these
> devices.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>
> (no changes since v1)
>
>   drivers/mmc/socfpga_dw_mmc.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/socfpga_dw_mmc.c b/drivers/mmc/socfpga_dw_mmc.c
> index c8da6ead0ea..b12212e02dd 100644
> --- a/drivers/mmc/socfpga_dw_mmc.c
> +++ b/drivers/mmc/socfpga_dw_mmc.c
> @@ -59,7 +59,8 @@ static int socfpga_dwmci_clksel(struct dwmci_host *host)
>   			 ((priv->drvsel & 0x7) << SYSMGR_SDMMC_DRVSEL_SHIFT);
>   
>   	if (!IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) &&
> -	    !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX7M)) {
> +	    !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX7M) &&
> +	    !IS_ENABLED(CONFIG_ARCH_SOCFPGA_STRATIX10)) {
>   		/* Disable SDMMC clock. */
>   		clrbits_le32(socfpga_get_clkmgr_addr() + CLKMGR_PERPLL_EN,
>   			     CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK);
> @@ -96,7 +97,8 @@ static int socfpga_dwmci_clksel(struct dwmci_host *host)
>   #endif
>   
>   	if (!IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) &&
> -	    !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX7M)) {
> +	    !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX7M) &&
> +	    !IS_ENABLED(CONFIG_ARCH_SOCFPGA_STRATIX10)) {
>   		/* Enable SDMMC clock */
>   		setbits_le32(socfpga_get_clkmgr_addr() + CLKMGR_PERPLL_EN,
>   			     CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK);


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

