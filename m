Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1174BC43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 11:31:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36AE384CF2;
	Tue, 14 Jul 2026 13:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ohi5fTpA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1752484CF9; Tue, 14 Jul 2026 13:31:44 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF8AD84CEB
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 13:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=it4JPQoTEVFEFOrf8KUPVimVX0RqbJY4mDqILSwViYIQhQ0L3FKCbQxoI8AKmulrCDoSox71cWk3tBu5OKNyY6QHZ9zPKZGULwmmmpvRFukauqDhg8IMPaXtVcqW/50ue6f9k+OsnymcLbwFDUdZlvJTgjMikRJ2c9dYa8GY6JR5e3IuriLvhORisotP49GLRvnbXgVqd8tOo/trJvx+h6w/pVOm7ODJVj9XtE1GQsyaBmUlwoBxusrNfnSHJ8RgQLdp6QsgIwZuUsDIh9Xei9o2SpG1GZ8/Qzd5NCSmVXY4AkqpxfCwZ5moxxpvx4s4nw8lBsib1Ci4ohJBTw7B5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afk4GC5lD1c9gtfID1445cPU2gYl/w/O/574hDV9oF8=;
 b=VXr1PB3AkftdeiG6yMaPTr9a03dMjzqoH+EG8SSwew2aGdh1kAkdmonlhvms2chlzr2PRnd5LjA1MiK9vYgDLAk18ICd3E7hoPWqwpz0JxdOba2XfNFIxGenVbANGfivbTDqtSjyqzIClxWMcqqdAXMrz0Vhwb6vgAudedtJa4bIFKnFmY4MAxaAmxa9YnQ1WxDFFU5IPc/bX7Qi4WpPh7IEQNqqq/VUEnh/tfDPXn9O08L+Cu5I34sVWH6FWSGcVLbrkm7xlymtX70XlnuR/CeL/BcKtFyfSrwPhZJLgDmSqqLIZMjh/07ZnEG1g5lOQsU0raM/fj3hjAD80sMaKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afk4GC5lD1c9gtfID1445cPU2gYl/w/O/574hDV9oF8=;
 b=ohi5fTpAlHaTQgcoTwd7HhRMh8vrCwusfO3Ap9hGVZwe9oWdxXz36lejbq2xuGC6z058AI0IYnvRdRbFUkKKGNStgX0ylaeRhRLGhGbB8ZBxhKnZ9DGaNYhqELtVf5TNHbK43osyv6tGiP9JhgvrR1Y2bUP/rc3c6Xq4G6jBMu4Lsa2u9qcoRKmtxHGBE+3buQGMupkRUqWfdPbqpJdpQ8yQOmmmjff8ANa2vBwGWdk7WyNN9mbeGjQsUx8voEFHwveJ7OpiIsxZeq7J2dJUFNu8uW5f4Lmgw2Jct7buvm/F2wmHJ36L5jR/MdZy2Mwjgy54eO0fCOERPSo4XYzi3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA6PR03MB7781.namprd03.prod.outlook.com (2603:10b6:806:43f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 11:31:38 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 11:31:37 +0000
Message-ID: <5d021e22-d1be-4b8a-b6c8-9a2812a5a151@altera.com>
Date: Tue, 14 Jul 2026 17:01:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] mmc: fix mmc_bwrite() ignoring host get_b_max()
 callback
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Jens Wiklander <jenswi@kernel.org>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Yanir Levin <yanir.levin@tandemg.com>, Eran Moshe
 <emoshe@gsitechnology.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>,
 Jimmy Durand Wesolowski <jimmy.wesolowski@mobileye.com>,
 Iulian Banaga <iulianeugen.banaga@mobileye.com>, Peng Fan <peng.fan@nxp.com>
References: <20260713-mmc-fix-v2-0-b0ba3b4a8d97@nxp.com>
 <20260713-mmc-fix-v2-4-b0ba3b4a8d97@nxp.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20260713-mmc-fix-v2-4-b0ba3b4a8d97@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0054.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::19) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA6PR03MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: 96d4f4d6-2ee2-4d4b-32d3-08dee19b7756
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|366016|376014|18002099003|22082099003|3023799007|6133799003|56012099006|4143699003|11063799006|55112099003;
X-Microsoft-Antispam-Message-Info: f4XsP5piDbAPhnEMn8/qbq3m87GexwLUIuFSBV/VpjOilbRMHt2xJkh6Nd+JiS2eLr8ENo/OCkEOTUR1pcgm1TPU/QX52LDfNCDymt0uXbPdzX/LawrLOok2zNTWdsigD8Q7iK1ORacNRl+Jc/e+QoAd4Xvgqa7hjlC8WHhHRUZTDmbHmjHoilc3aHbk3BTV5O/wft/MORk9RIs+WxoHbv1rMO7ipj/mDiN/x/Q7JxID8sFuSu5vhsvH2W+Pqd+hoI+X3GZmtXJpHz/O1mld/S1Ph/kwbg9PyYGp8A8LUjHkbVc9qy44QAWQYo1gwKw1Eqy9H/+HGtC1+R5OZQKYDwgISKLaSz2u4/R+xuEwgfc7E6X1oBlSIVcLlKtI9cAUZz3hsnpsIbUWJhn24MfHasAc7sq9OUfId7f7L1J1jq07PPYTu6bEB2cPV6h4Pa0wsYeVBK94cGtXKlPxhc1TIFt7vFd1ihGgbOZ+aY4XixduTCpVZnifih0rQjIrwstakzahqc0zIAnrmBmwjVaQYZDRTTdwaqkcmFn36I7WEu/A/fbvHqpsA6ERtKwZL5274pO7wHO12ezQFoAQAooTIp+F7nnA8CBh98mj7/Zfx/9xJ+j5NpzBkJ8MltniwVxuekphXXXJ0wWRUiJ3JEtOtBwwJ52j5aVewBxedYzHvyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(18002099003)(22082099003)(3023799007)(6133799003)(56012099006)(4143699003)(11063799006)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXR3YlN4bzRKR1poNnRMRnVxdjFWYkZ3eFVBcHlVdEFaclYzd0NaN2dRV0xk?=
 =?utf-8?B?dm9TbVJOLzg3NzFjSXBocklkb3BRbXMvNlVqdlZyUFF0YnVKWFBVWTZxdEg1?=
 =?utf-8?B?QWpxdTdJckMreENhYjVEN2hONHVVakZjdEIvcTI3VjMxck5UME55TXNpZStD?=
 =?utf-8?B?UFFhREZkNnhnbXVhZjRZbnBzU2NmSU84VlRzdy9iV09HUVBoZDZSU0RRQzk0?=
 =?utf-8?B?bk5IYlZXVENBU0hTQkYrTXJqQUZqWEJ1MGM3TFNjYzYwbG54cFl5YklsQUVL?=
 =?utf-8?B?M3hhbWtzU1RaemxkSUszQTJ4RW1CdndnT1VHckxnWmR4WUxWQU1NMWpJV0o2?=
 =?utf-8?B?NmtxYjNsQTNjcjZZMlkxSmsreWVQU0lCOEhZd1NYNmJQQnl4bHpmaTBHaWhK?=
 =?utf-8?B?T1J0dDA3bFlBRGdxT0xaelJtVTl4SklMTXp4U1ZPRFpGWUpJTk1ENGV1V0Vs?=
 =?utf-8?B?eCtHZkgvQ004UDJwTjVrdEZMQ0wrTlZoR3BjM29KMHdsS0F0dzAvRmFhNHVq?=
 =?utf-8?B?K0ZxSHRiOFJxeDZ2Sm5QdEVkdjVCMjdZbGpKeWZ2dmppMW8vQVFJL0Z0Wkhm?=
 =?utf-8?B?OUdWMjNjQjhxdDlaaGZZRm1aSEdDSDdJNFFkQVRrMllrRzJ2SS9mLzFvb0Iw?=
 =?utf-8?B?SFd2UlV5Q2NWU0dJZ00wYVlka3BRakdoR1VDRGtJTkNxenhxbTNBd1JhVmlm?=
 =?utf-8?B?NFJZaWIwaFlFcnBxRHJnL2RsVXdBeHNpZmZtbEQzZU1VbE9BNGhoU2xOcnc4?=
 =?utf-8?B?UmtxNkhsSjN4NTV0VE50WThNbWVDcEtHVVhhZnZ0c3daSm9jMzdPR1FEZlJk?=
 =?utf-8?B?elhHUFNXeEVqcCtRZkkyUTc4azVqNTZlSytXYnZXWVJNY1Yyb3F0ZW9XMElo?=
 =?utf-8?B?RDhEaFFvWnVXdTVLTlJhUnFaVTUwOU8wWUVpNm9PL2pzbUFwQ2xrZ1Z1emhD?=
 =?utf-8?B?cjJoL29lSWNnUnUveG9ERmg1a3pVaTRwWG9IYmV0WXVJcHBKT1gvbmt5dWI2?=
 =?utf-8?B?by9qRTlaVERQeWl2blhQRDZ6SFhVaE5YbEVvZ2tpdDFDNi8yRWs2YVZIbGN5?=
 =?utf-8?B?Z05NWUsrNlNEc3RMQk9aclRtSDlZTndjWHVrckFaa3Z2aVRUMWFoRUVYZTc2?=
 =?utf-8?B?d2VlRDhoTHlJTU5rL2s3bnQxYWNqZUVMMjJXUmNQNmtIcVJhY3VnT1JReloz?=
 =?utf-8?B?OGw3ckpNQ05sa0dTbVNwdlJHSDRnYmx4azA1L09zM2tvcTVTN0N0bDk1VHNq?=
 =?utf-8?B?alAvcGpDaVdyblAwaU5HVFNNOGVKNlQ0dWZzaWwwTzc5RW85MStoN1ErRisw?=
 =?utf-8?B?RjNlM0JRNWJTcFROQisxM0FwQnA1WkFLNW0zWGhKbUh3QXJUeHJsMVR1WnZh?=
 =?utf-8?B?TDJlNGdnM3lTMWtlQ1ViTEJUTUcvR21sYVU1cVFNN2RnbVkyTDJteDlHeEdz?=
 =?utf-8?B?TUJzRjUvZnNoQkQvUUhiWFBPV0hSRlFrUkQxWVRCM2RjSVQ1SDZoOVlwV0gx?=
 =?utf-8?B?TjJBN0lWNmtHL1JObndaQ20renpocmlPZ3JpQjJidXAyNy8wWEtzWW43U2d3?=
 =?utf-8?B?b1NUdEZBQ3lvR2FMNnJyNStJaGN1Q1p3ZWswdWQzdEMzWU9WeXdHaEdzdnZN?=
 =?utf-8?B?eDJUeGg5ZE9hUFh6UFRaSWRjdm9jbnpuTnlrNnZyRFlNUlJVQTZoL0NXN08x?=
 =?utf-8?B?WmtEMWF5WE5adko5ZFFFZWpyUWZBaDYzbDVrVGVpSG1KNnlVdHF5MXdkTWlw?=
 =?utf-8?B?Qk8yRmIwOHRxQTZMSmEwanEySDVrQWVsMmVxTm1rWGdnYUNKQ1h4VzVEUjZn?=
 =?utf-8?B?d3E0R0hBR1FRdS9hZjg5WmpwREQ1N21hcThGLzN4dWNFdkZSVGxCT0EvN2h4?=
 =?utf-8?B?SWtKa0VDUmNTQkdVajlUZFRoRW1YOUtUR0wyaWVDNGFrNFFPcFhTN0V6QzlI?=
 =?utf-8?B?dzVoY2taa1F0YVJBdENHM0EyV0RhUTlxN3g1YXZCaWlNVk4zVkUwd3RlUFRw?=
 =?utf-8?B?NDlCdmhDaUdkZGd6enRnMkVQQXJ6NmVlYzloSE5KQUFVMzB0THFrbit3UUlj?=
 =?utf-8?B?QzV4bHF0QWs0aU1PUURVOHJsOFhBdlUyR3VER2FGV2trRk1CbmZHUGhuMS9Q?=
 =?utf-8?B?VDZQc2ZiUDd6TWN3RVo3QlZhU0hVTW1jc21wU2U0NW9YdjRMRzNaS3RYb2Iz?=
 =?utf-8?B?UTVtMDBWNXhmV1gzSWxSOXdOVWFyUXJ3VWxoZElqall2WFB2TERkQ3d1Qm9Z?=
 =?utf-8?B?Z1pPNG42OFdsQS9pQUZidDdhT2tmak0wTnlzbk5RRlAxd2hUQVNvQ0x1K1dI?=
 =?utf-8?B?OFFZRXRreUs0TDA4K3k4c1FqclNDVXhOc1lNaTVnUFY1MW0wVndnTlJQSUVx?=
 =?utf-8?Q?YaiLapF+9BkW3ccA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d4f4d6-2ee2-4d4b-32d3-08dee19b7756
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 11:31:37.5454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S3/H3uyYNL4aR0ee2mmLy1SSUdCSqBILrq13QHsGV7uSwvwgswY+O+0H8EQ6FLxgHvi8PzAG+TaTkjScCjbzohsaR788iEg1+Q2zvAx2qwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7781
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


On 7/13/2026 7:02 PM, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> mmc_bwrite() uses mmc->cfg->b_max directly to limit per-transfer block
> count. The read path (mmc_bread()) correctly calls mmc_get_b_max()
> which dispatches to the host driver get_b_max() callback. This callback
> allows host drivers to enforce DMA boundary constraints based on the
> buffer address.
>
> Fix mmc_bwrite() to use mmc_get_b_max() to match the read path. This
> requires removing the static qualifier from the non-DM mmc_get_b_max()
> and adding its declaration to mmc_private.h.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>


Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

