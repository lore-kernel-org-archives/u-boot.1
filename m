Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BE8CD37AC
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 03:22:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7167084683;
	Thu, 14 May 2026 05:22:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="jW3DLg7k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25AA9846A1; Thu, 14 May 2026 05:22:20 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23B6284676
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 05:22:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6tk789OxGJ1If5oR9DyccGlV7v3Z57afE9yj3HBqSs7XVpIrk3G3Yz7i/XhkTKufnC1X+bA0suEfUlKKb2veEcUW/lUN/pL0A3mBx0+2jxV2hEVI9REAuvYyiTuCWSOc0k8F32eU0yr0wx6f/RYT6JlxaYIlZga+10SLR0E7bH/sG74UmzAOL1SKT0MlJTdhlBy20PEG4pGEHMBbGICt9UZ8tf8LnJ7D9emIkwipmFqjciMAj37vBJ/b8mit0SL736uSXx5896i44PJsROwCBCGy5Ze3O+7ypY5jM9/Id583WrlRkx6jzD/VU23txIkStiX3kDM0ot+eW33wXkGQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5NZvNUFpGkvo4UnpeRifRL9y3e4tH6aPU6yD22T4dQ=;
 b=H2Oje0WgyrcN+XP2URFe85thj/5HRWEVsR1eD89hB+Dif8Oy2yfYpVq4qLIjZ5ibyDYjaSwYnnNT558lCcRnIYGf4BxuLT4dIayiB9ncTGfNh7cGvEl+n9sG9duqw5G1yH9uIIXI55hjcwpgpz0nJCEG72BVtUXHyBrSFkFwSt2UdTrYb0liQDRKarR20rnR4gK9db271mQW8XPNtThv+oUVtRKcrr0pZvRN7n/v7s3gfBvf6d/4SLzrTsTij1fCuGQ77rPx6oR+bO3dCSTQh76hjU6ldj2NiO7VgjQM3dLEqp+lkkL8306BgfsaFPR4XTGHoJsqQsRIBxFICKqZPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5NZvNUFpGkvo4UnpeRifRL9y3e4tH6aPU6yD22T4dQ=;
 b=jW3DLg7kzO4DHw8FDPV52NIADigFtkM1RmnadKdGy8B9gMCMdwW71xR2IiuF9g2vkgcpbEl72k/8I8a+qa5BIW+hUTLimui69SKsjOeVGgj/pFG1VPjZHnZfrK3FA3FxRPSj+qMHKT+eE2Xjxf6+EfbQuNE5CN4WEVPnKXCoNSStjNoQKmenYHQmFa/pfnCcBS5rj9Bv459EW2HF3xByErHanLTCDfBlBQRu5kKcH4XGBeatLWR9BgbRxJYzVKUsnt6BXk5veIPgb2O3om3CLygrcoiodgz6dBSnzLepSUDirp8Oq+5iNbW34e6xmHhYptsmdlOCpU2tqbMJXUZ9NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BN9PR03MB6075.namprd03.prod.outlook.com (2603:10b6:408:118::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 03:22:14 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 03:22:13 +0000
Message-ID: <310fffa8-8196-497f-a292-96c9a70dd672@altera.com>
Date: Thu, 14 May 2026 11:22:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] configs: socfpga: n5x: enable required configs for
 DDR retention
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260428070017.16807-1-chen.huei.lok@altera.com>
 <20260428070017.16807-5-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260428070017.16807-5-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|BN9PR03MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cfb88c8-536d-4c8f-823e-08deb167fddc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003|11063799003|55112099003|4143699003;
X-Microsoft-Antispam-Message-Info: jFv4mSiBoLTgknXhVcDAESjGhUiAVPsIqexBREJ4joVYw/uFSAwVbr09b3oj+EB23zKB2xbqsXuZB95pQ4yQDJkA4cspThLEDOKsdRWdfatLzcyCjd2Ap6zbXaSIGrYMPrwc8Ixq9Ec5hA8koiftEPc0jlAjk3dKzeKS/nJgtgHd+xlLo3ipp1WjS/iwsIrXemzVey221QZzUzmCRKggr0wlheiJCirLHAMx6MhlMIRlNCHSx/+shBqt1Ggd14rENNZq+V3fAGog/jQx4W4pgRvVT/jvooKEAuYVepamr26GDQBoimqjwAzKaqwqIO6aYOPA+497Jqkcak0kctGFfSE7Qk/NR2EFaTv0KJTi+rrXuNegKMTKk/lUdOKIIz74nSNCy6TUghXDZDJPaa/9ajZuW5v48EK7tzDt6cvdZ8KLkNVhbkBtvOtLn+9yllRJ58IXT8DFzRqAZWnoRhX4ccu66Q2dZZn7/2/0Hdec2euAq2RTfskrZF/s7qiyN8asag8ZBwgRN6JLmu4Qpl/ftfYofd/S+aQdQVj0j2/claEI9+OCVGHHpD4xfhGdcXwOWsC/bLE1cZi8ST6bI3m811657JZpj+5lfMRUCpKl7hfXWPKF7JSrs7XjwsObAsxyAtVAdxH65CqNRqDGaGS5pevVhPz2HMQYHgXphN8anNUHRZcW0hqjFQJyo4kXdiVw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(11063799003)(55112099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTJqbnY5WXpjTTBIN3hKR2RYNjF0NTdCSXFxUk9DSTJ2d1FseWdObUtKRW5a?=
 =?utf-8?B?dHYzUmppeExvakNRRWpEcFVEaGE4WDl4d1pUZEtyYUNyWTNwc1RMTFQ5MzRy?=
 =?utf-8?B?V0prTmpCZitWWVExU00wY3FKZTZBeDY3citQbC9MZEZsZXpsVnMvYXhvNFAy?=
 =?utf-8?B?YnJPQk50OEVPclZySUVJWEdqS3dQdksrV0V2Qm5nb1BRR043MTc3VmNPbEtj?=
 =?utf-8?B?N2JQSVUzRjZMQm0xcGV3QmM0SHRhNGZrbTQ3Q0FMRmpIeHBCdmxRSDlaWmda?=
 =?utf-8?B?TEtkVWViN0JPVlh0MWRpUmNRN0dCWG9qM0FGZHhIaDJ5enpXazB2Mm1xVHpV?=
 =?utf-8?B?NnFHbW8yczk4bEVhNVUzQ2E4Q0RIc2Y1YnFPKzg0Nm5NTWM2UUFEVUphMG1t?=
 =?utf-8?B?Q0M4TGVCeFFEVnVmL1ViZ1kzbkpwK2RESE9wbU9KZVhZSFhCREdvVHpuYXpQ?=
 =?utf-8?B?MWFlNFVRSXUwTlVoZE5VY0kvK0FUcVREcWF5d3NsSW43WVVScThsVDA1Njdw?=
 =?utf-8?B?dXIrdjNrVFd5KzNNUlErUU15a0kvUHNPU0h4dmlQejAxU05LeFRzZE5ESUd4?=
 =?utf-8?B?bXlrVk1GOW5PWkQ1SWh3SEpXRzk2MU03K0dmQVN3b1hWRWxuRC8vQjVzbklV?=
 =?utf-8?B?d0JYUU1oQmdXSGhaYkFETzlVR1E0Y2I0Y1pDQzVkSnNob0dhVFBNejdRaDJP?=
 =?utf-8?B?VGw3YnZmQ0NkUzJlTkxGMkpZT0pEV2FEaUIvb3ZTV3dYVWRtTm1ZT1FuYWdu?=
 =?utf-8?B?R3lTdGNJQk5ZY1pLREljcXJzaW9lbkYrMGFGTU53ckhPQ29oSFRZQXZ5bWND?=
 =?utf-8?B?ZlcyZWpCM242cFAzMU9JWjFQSlVLYThNdS9iaEtJejBBN3F6YXA1OE1VYTZN?=
 =?utf-8?B?ZTlCcWcwaTcxcUwyVlEyL3Z3QnlXUlc1VUNFc0ZQRkNtWDkyMmpDSlpJMUJz?=
 =?utf-8?B?Z0JwTFl1TlZ1TzdUWlRBbXMweTM2TE0xZjliS1E0S0p5bWEwbnV5U216dUlB?=
 =?utf-8?B?VnozaTVzRDBKdGR3RDc2U1NOY3hMMGJKK3d4akdVT29RYlJyN3YwSTlTdW80?=
 =?utf-8?B?UUJGNFk3bDIybm53U0QxdW1sQ2tBcWRXakJRYzN6UFZZNWR2TzFxci93cCtj?=
 =?utf-8?B?RU9nRm9IRG11MXhZVC8xcGNUbFJNR1pHKzUvWjlCNXFTdi9KOFEzd09vbDV4?=
 =?utf-8?B?Z1JuMnlWQnNrTE5HZUNmaTNZN3BNTWE2QmtleXZxajlGcnRBWXFQOWg3WDYx?=
 =?utf-8?B?YnpyMXBVblB6QTVZQkE1KzVXRjVpTTdJS3pidEg3ZTRqTTlHc3J3Y0VsZGtH?=
 =?utf-8?B?TlRXTlhQNS8zNTA5TDluLzg5Z0lDdldrMXRBM05UNkdEZzFKakFodGhBbGt4?=
 =?utf-8?B?NkZzVkErVTQzbnkxUkRuSndlZW14ckdFSVdMVW5mNDFMNFlsZWx5R0kyeXE1?=
 =?utf-8?B?Mng5dU9vNm1xaGVaMEtBZ05mSTBIb256TGhEYjRuVHF1d0xPdkptVi9qK2hu?=
 =?utf-8?B?N0paYk5iOE5IVUE3TXJmQ3ZBZUl1M0lDazAzeDhpRVc0NGt2Rm1iMmtOV2hN?=
 =?utf-8?B?cVNnb3pLUW96YkUwUnJHYzdxZmpOakVZQmhqMlh4Mm1Jc1Q4VDlwYi95Q01x?=
 =?utf-8?B?dDB4dlg4NU16Z1Y4ZXRHWFJoNitQd3h0b01GK0NpYTBYUGlJOWl0OU5QYm92?=
 =?utf-8?B?dDVTOXFZR04zbE9wWExSSERHQ3pZS3VmbTRVWVFMVnpKZnRUZGQ0Z05xZGNR?=
 =?utf-8?B?a3U5UUhsazJXR0ZPTWUrOFgwYm5PTGUzdnJmaFZLWW5pQkdaRjJjWFlXelNo?=
 =?utf-8?B?WFZNRHVucUxiRVlFZlBvcnVmbS9hYzRyQi9EbTZHaUVTQk9JOWoyVEplcDJ1?=
 =?utf-8?B?VjhSbUwycElXYlkwYitmdGhISFZsbW1SWG1xT0huU1Y0QWk1NXFLRXFMOG53?=
 =?utf-8?B?cXMyNDl4WC9sZVJJYjJaRE42UUlzb3hLcEdzWmxPK1haN2V2NkhlM1Vqci95?=
 =?utf-8?B?SFllMk1QMUo1OTdweTNaVldlVFE5L0pJL3pubHhVYmxqVW5CaEcvY2dITW1M?=
 =?utf-8?B?azdEaHZ6TSt6UkZvNVljZEtCejloRUsrMy9RNXluV0J0SDA0WnlLN0phZDN0?=
 =?utf-8?B?bjB1MEJGSXp5Sm1TbGR5R3pEYnhpSk9nL1lEK3VlQS8vT0lEaHR3ZGhySWlx?=
 =?utf-8?B?dDQxMkorQm9CVXBQNWdIMjJyQUdRcFBxSFN4UkZQck95QjlUcFVuQlZLVHEy?=
 =?utf-8?B?VHNOUU9LRnE2QUNhTWRqU3d3dmFmeWRIeXZoeHhkNVFMWTZ3R3lJZDlBWklG?=
 =?utf-8?B?d2xVeHJRQXlkckY3cWR3Snk4YklwN01DUzdUTVo1TUNXSWFpdDFzYWZaWVA5?=
 =?utf-8?Q?tsFOXl+jQtXPZGiw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfb88c8-536d-4c8f-823e-08deb167fddc
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 03:22:13.7922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNuFpHj18eK5duhypwDdiq9uxMaJGjqqCVkLK1vzlnfvAd0VJU8lgzqset3SVRykF0U7Yklu761Pyw6TAjefsU6BmKaWUPo3V21W22znjJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6075
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


On 28/4/2026 3:00 pm, Chen Huei Lok wrote:
> Enable required configs to support DDR retention. Including generic
> firmware loader for loading backup calibration data, and SHA384/512
> checking.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>   configs/socfpga_n5x_defconfig | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
> index b6df9946ef3..273e74c6499 100644
> --- a/configs/socfpga_n5x_defconfig
> +++ b/configs/socfpga_n5x_defconfig
> @@ -90,4 +90,8 @@ CONFIG_WDT=y
>   # CONFIG_SPL_USE_TINY_PRINTF is not set
>   CONFIG_PANIC_HANG=y
>   CONFIG_SPL_CRC32=y
> +CONFIG_SHA512_ALGO=y
> +CONFIG_SHA384=y
> +CONFIG_FS_LOADER=y
> +CONFIG_SPL_ENV_SUPPORT=y
>   # CONFIG_TOOLS_MKEFICAPSULE is not set


Please document the rationale for introducing DDR retention and describe

how HA384/SHA512, FS_LOADER, and CONFIG_SPL_ENV_SUPPORT are adapted to 
support DDR retention (e.g., required init/order changes, state handoff, 
buffer placement, and

failure modes).

It appears FS_LOADER may be missing pieces needed for DDR retention 
(such as handling retained memory regions or re-init sequencing).

Consider restructuring this as a series that first enables DDR retention 
for N5X, then adds the required support in FS_LOADER and SPL env 
handling in follow-up patches.


Best regards,

Tien Fong

