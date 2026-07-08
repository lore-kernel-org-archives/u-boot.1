Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41361C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 04:37:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE405838D7;
	Wed,  8 Jul 2026 06:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="YADBmNZU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11F1684A0B; Wed,  8 Jul 2026 06:37:39 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ECFF80087
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 06:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEHrkfXOGQTxjRJqnaF2h0or/AxzktH9YnUBmRIeoBHa7Qjd4zZeaZJk4Rnu7jtghV06hhO+GtDsKVmMQRueAeK6A7YJHmZY95krGkMsCJAsbiX53XKguBpDfS/upIgJrYBNdrXDMOuVaZG2mEdcv8j4119gcnAELGLLU6nq8FWuTC2p11V2MLsaP2oVuqlVZ4zBYlBt418TSnGaccpbM7r+e5WwhDucycosmDUrzIxQ0CmtIovF4N9ZiTJfOkduuhj2RYCHVt6r8R0GddhTTDnWHy5cSKImjRcA0eXLSspPh/h1kyrieQieEhFanvHZH3ismuG85v4TBe3K/z67yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LCBx8hLsvMrlFbLdZSeCNRQiJvBQafK2+1yNG0io4Q=;
 b=ZFiPfdqh9hA2aM7Y34yCjTmk9CQhTdNtu8HZH4T0Phd2AhRzLy8uu/e/lAW3VvVORytIyAEpwg32XSY7tyhIp3y7LjRD3Gh8IKEkveBjfU/dI2VKBrHb9f7/eIayIXF+lK8MzYDakFSNtUDUBUNPq6rxgpC2Y7fWFf8qGQMKa64kqpDK36DIY40UciQ9f0Julr4npcPKHCI0BE4X/GsyS8suAe66Bx5eNas/jAAE+tMFT9L1c03HmHzXnDepD+h5rsAqQasJGC/0Ofz1YYlAi4pRr+Hcu2bqwXG4HneGMlzhxtjYOKQwB9mxHBdvd5AypzT+7Q5H9Euq2jvaqZVYLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LCBx8hLsvMrlFbLdZSeCNRQiJvBQafK2+1yNG0io4Q=;
 b=YADBmNZU9SGAQ9OZQcDffZeguH3hUrhCN/0xluNQ6YihwqVn7yRTnAwb5i85Bya9uvV8pzUR+DWXtwLmPuIKBvdCrmtuoI7F0RNEyStWjheKpoL178iSeRBsVJuxEpdaY4SRtApBgUKyE7SZoCsIJ7bK2FGrWPK3mjG0HcDkOSIqe7xj+PlZDDCp/DJD3K8/TqA/iIjwyaLSpB284dSRHCiZH+HouoomqmSOfGIsUFfSdQ1ovzNU+66OGPRJQ3yNrVzGpM1w0DgYLLSnX3tSmYcyty62l+6H4yankC6qfUIZN4XLDdHGMwX3izYjsMzSOozMzJY5fDOjTWlcseEVIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by LV4PR03MB8355.namprd03.prod.outlook.com (2603:10b6:408:2da::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 8 Jul
 2026 04:37:34 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 04:37:34 +0000
Message-ID: <b1eebf61-2262-48a2-aa9a-4b79a2903a97@altera.com>
Date: Wed, 8 Jul 2026 12:37:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] configs: socfpga: n5x: enable ISSI QSPI
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Abdul Rahim Ahmad Syazili <ahmad.syazili.abdul.rahim@altera.com>
References: <20260623020221.32362-1-chen.huei.lok@altera.com>
 <20260623020221.32362-5-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260623020221.32362-5-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|LV4PR03MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: 351779a8-f0c6-4164-85b1-08dedcaaa153
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: KBZtPnz0H0KFaBshotCFez9J71KOl2tGJeVaF0wi0El5KYMbNqD1hPgWyC6ReAbJvVHfSdLX+ha7ozyyVLYeEgQyflZTfJDJHhMtfBmAdZl+HXbV32N9UqRvVYTiqec0nR/X328mOR+MaFdotWcPxkFM7Rk5L2xF3KmK4TaflRYpopeLJzuLGZbxgirF/Gzv1F+f87bF2agoJm0eNi3udqkPLhlqlg2GJnCOtteFf3DJ/4PANIf5iqxSXd0zYjC3TVQpDGA7ChW0R8E6NfnjiLOE52PLVlXiXJzVrIUY6I3fv5ezH/RZ14ZLOj7mGaduUpZ0zcoVf/TzFoscR/+OF+2+JwxqiFOT/bJAxrnFdNARThZgO52PfEOFtY+uBdMqht6Cz/6CNRh4dhMbo60I67zyVnNxUwwiKGIYTO2xX/8TBK/HwEVbRT/+4vK6aVgoWZOeQ7IZ7xq5Dvsh0ZjxmqDdKhV32ZCrIiXUtSthDUv7nRDAKy8HYBmTg8D1VLGC3hTRibEr+2G+6tBY+e2htyui6KDpN0AMHq7Zw4nOMXWZgBpDgVH/ToM9DNLIf4whBkZjUd/Ye+4kTtpFGt2lUNfAe64xDgMNeVmCgFHOMDdfwOajXDkvlctAHdiJH+2lNWJDAITGchuPWOdJENCbdIPeQwDYZTJJuP4qmU96Ftc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0MwNmZPM1JJK3c1eXM3OU5FMm9XSmNVeVozWDBNQlFBS3NjMDc0VWJ4SlU0?=
 =?utf-8?B?cmxsb3NXTFhXVTF5MWorNnBzcWdEN0gyWGszL1JlT2ZnUjNLMWNUZDJHVUJ6?=
 =?utf-8?B?VFZ5NmdPTzU2blJYeWQ3OU9RTlc1TEUrajV3MHVHMXpYTU1pV1h0b3dCbTlK?=
 =?utf-8?B?bXR4cXNQajkxQ0lxU0V2V05CQVBKMWpXNmIvOGdFanNSa3U4S0gwOTZhNXlM?=
 =?utf-8?B?SFJkODcyRVdteHp1NlF4eXNsbXVFc2lWd1E0NnlTYzdvL0Z1Rml3bGVSOVYx?=
 =?utf-8?B?eUJYYWk5WDhmVmZ6eThBbHRnUFFpQ0JzZDV1WVBjbUxCeDA1L0RHbWp5U05T?=
 =?utf-8?B?NDV2VDdOMVVIcDlIVEZVcFV3TGY5dCs4UTlPRFJTYTBTS0g4Rk1OSUF5ZHEz?=
 =?utf-8?B?RkpYaWlJNStQclcvK2RRZjQ5aExQS3F1UU5oSE9mOHZnR3R0aEE1Yk0rZm9n?=
 =?utf-8?B?Tm1UVDJLZW5memtOcS9xanFEZTdXRFM2ZVBpSHNBS2lvYmkvYndpa3Z4eVA2?=
 =?utf-8?B?LzRqNlVSQnlxRUk4WTUvNGxEZEtqeDJMYitHYTB1bTBHR0hnYVk5MDM4bnVY?=
 =?utf-8?B?TnNhbi91L2o5K0JMRTl0eERBeTVIWUR5QlZka05oSzF3Sno1U1ZWNGpEeWti?=
 =?utf-8?B?Mm1zdHZxMDl2ZWRaUjlTdkZ5dS85Q0ZucS9mTm5hMlMxWGEwZU1VMk56SG1O?=
 =?utf-8?B?OUE5d2Z1aEZxTTFnVmpVV2hNVzJCLzVncWFpZy95VjJQVWp3MmtxZFBmMmlp?=
 =?utf-8?B?VDZxK1krenpNMUNLSEZMZkdaanBldnVhTEh2UzZoenpWVWNrTWI3YjY3VmJC?=
 =?utf-8?B?MUVYUnBtY2ZDS1djdnVWK3l2eHFiQVk1RzhKN05PZ293TFRrMHBjNjBsWmk2?=
 =?utf-8?B?L1dGT0JIc2xvcTFkbnlrK2pxL29sYmg3Qzk0dkR4MjNTS0dXN2pUdTFvL29G?=
 =?utf-8?B?Y3c4a01UQ1VEU1B0QW1zbGdtQmdORXNLRHM3MGpPMTRIMnJNUnBCUlZZdHVr?=
 =?utf-8?B?L2NoNWVUYkRJVTB2ZmMxRkNLYm1EWmVEUEYzRmpiNFlwM1VDUVdSUHhWQmNU?=
 =?utf-8?B?VTlSUU1OL1JOSUkrRVBwTWJNK0oxOUFJOFZOazhMbGwwWEtwMFI4WHp2NWF5?=
 =?utf-8?B?Z1cvSDVMdENkcU9WNVRTeThLSU05YXMzd2E4VEhTcVo0NGNKaGdVQTBSNjIx?=
 =?utf-8?B?ZC9EK3FuU3dGV3dySDBTS1ZuU3BHVlhQZHFaYy9rYmJuQjNYQTVmUzFvcUZH?=
 =?utf-8?B?RUcvMGVwdVpERW9NcWJYa3JsQUR3dVZxcFQzWmVmMW1qdjY0b0g1T1FQZDRU?=
 =?utf-8?B?RVNnV3k0K01yOFZXdUNyQWljdlVzS2RDdFZmTHZlTGlKWXRXSEJTTDlWT3lP?=
 =?utf-8?B?ZXAyVmhoaGhVMmJ3TC9Xc2g2aExiYVBBVVdNdytmSUVlNUpnMUV4dXNueVJ1?=
 =?utf-8?B?RW51VGJiY2NWN0dya0YrQVZQbzdaR0lqTHozODhuWTNrWDV0UWZVZXV4ejJT?=
 =?utf-8?B?d3VlL1lxMzlob25NSGR2VDZZZmVldEFSMGxZdnNyWEFRUS8xQXIxVGIyNG9m?=
 =?utf-8?B?MndBRDFnd0RkWU1zM3VMK0VHT2JRVjFtd2c2a05tWUNyU3REUThZTGhpVjN5?=
 =?utf-8?B?Qnh5dkNKakVYQnp5dndCV2EzY3g2QzFOaHIwWC93U1RidDdIZG5IZXdaYi94?=
 =?utf-8?B?aGVSakQ2eDN4RjNrNm1LZTdjbHZ6ek9XU2Z0ODBXeTZXaTZleDRRbld2V09D?=
 =?utf-8?B?UEMzd3dPWlM4ODlWRlZvU3NoWWtKV3hicDhCUkxZNktKcVY5blBodUpub2Fy?=
 =?utf-8?B?cHllTVNoMTVaelFHMGttMWRSdjhqdGVxOUlPSCtkSHFNSW5FMGpnazdCTURQ?=
 =?utf-8?B?MVJsU201UlFqeFVYOFU4Sk9OeVVpU0d3Y3E2N3hiakdxN05ORDl5REpDSjJv?=
 =?utf-8?B?SGlZOGt2MC80V1VuSk1pY05JUnJJSDdsR01ISlpUTFFKZy9yYXIyNE9FZlVh?=
 =?utf-8?B?bjBWWThwY3dBaE80K29WcG5ta1U1SlN3d2xDSjY0dWF3Nk56R0tKNE5DdVJ3?=
 =?utf-8?B?NWJ5RFh3WGJsMDVhMGN0SVU4K0RIYnUzTDlqN0cwbkZYV0pqR3BydHRNYVpN?=
 =?utf-8?B?NnVxbzQyZjQxWGRTNUY3cnNTUFNCb0VKeTVyaTA5TTY1UW9ScWpaNmR1ekZP?=
 =?utf-8?B?VnpDTU9HT2RDWWdHVzc2bDNiY3p4VE42MDA0T25HRWVsVWFaUDNDNHh6QzRN?=
 =?utf-8?B?YzhRUE15TDBhWUI4Q0lQdGk4RGkyWENYdmlKU1FvdHJ6N1cxZ2JUUW96Ymkz?=
 =?utf-8?B?MFp5WU9PM3NkRE14U1VMSmVKZTZvQWQ0NDVPNm1NL3F6TlRoSCsvTGRHbWpK?=
 =?utf-8?Q?chDQAtjUaxMb1jMQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 351779a8-f0c6-4164-85b1-08dedcaaa153
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 04:37:34.5979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUGUmwpDdtopz3mDmglcKCsemgnKd1RwpBu/L1jpnmu132S5cBfq8iV3m+fAT5cfVGCmdS+mHbMOr5DLTG0FLb+3BsCy0nWALRBzlhul3PA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8355
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

On 23/6/2026 10:02 am, Chen Huei Lok wrote:
> Enable ISSI SPI flash support in the N5X device.
>
> Signed-off-by: Abdul Rahim Ahmad Syazili <ahmad.syazili.abdul.rahim@altera.com>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>
> Changes in v3:
> - Renumber from 5/8 to 4/7 following the removal of the DDR retention
>    patch from this series
> - Fix CONFIG_SPI_FLASH_ISSI position: correctly placed before
>    CONFIG_SPI_FLASH_SPANSION per canonical savedefconfig ordering
>
>   configs/socfpga_n5x_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
> index 9159fa0c859..fc988ed3da2 100644
> --- a/configs/socfpga_n5x_defconfig
> +++ b/configs/socfpga_n5x_defconfig
> @@ -71,6 +71,7 @@ CONFIG_DM_I2C=y
>   CONFIG_SYS_I2C_DW=y
>   CONFIG_SYS_MMC_MAX_BLK_COUNT=256
>   CONFIG_MMC_DW=y
> +CONFIG_SPI_FLASH_ISSI=y
>   CONFIG_SPI_FLASH_SPANSION=y
>   CONFIG_SPI_FLASH_STMICRO=y
>   CONFIG_ETH_DESIGNWARE=y


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

