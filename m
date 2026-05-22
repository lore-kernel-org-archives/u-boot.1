Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D2BCD5BAC
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 09:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 888D1847B0;
	Fri, 22 May 2026 11:38:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="DcJxkx0O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A2E7846DD; Fri, 22 May 2026 11:38:10 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87B32846E1
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 11:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/D4PtUzwHEUwUAVXgJsvaJEIUpAk8Hf7WsGT+GIt3ibuwyTMDVvKRaBd/ZE+4Y2+QxyOiyrYWGvSkn9HlgVlqoNJeF8fy+ZFVExg+MJ3VZp6TYCWkKzkocaO49n8tsyNAMIolP+HUdQMNKF7n7cyWOQmieZsIqNifzyXywKdShzaymMvalPrHmDbZbLdGGcMp6+cUA3l6Sh+g4uL2huBIRC2WSNA2SvdLPGUOgsMKVHkHOlbtgCcrmTbwegg6Gp6cIrZalxLgaXE7lHtffWOob3Nl4zv1aUM2qHcuBE1zFi5CuEh5NH1PSOFxknqy6vv5Nf65IrZg9eXkXx3k9eFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOnv4j+qU/VZgLdanFcvwpHTnsK6ei3C7PR6XeJTQ9Q=;
 b=Is2mT37coZ8jpk4MElBdHt4wUehrm0P5R2l9ubk9dOnQKzQQFr6sN8/WMSaF+rzHod6hUYyy4uNyyw7c3kd5yUgcdybgZD4b+Y/+1c4XZS3z1pm+9z5pA06tcktKQ5ybDt+U9hRaySDUhT/xV92BxssL4zB38Y62cYCNghy1lrF2Xdj4ufXZAN8yHY3Qssh5yGCt1qFzU7IMCkYsXQ1qLxpJmIHaDVAaCkeRVob5seJKWYHKsQPjpNBfs5AAQOvFPdIz5dsK8hipgX5JFZX0lId7MwmOmXfDg3I2KjgpC6qda3gQZD5z3BGnJOuApaji2XXBYNRPmKc3irigDMpEfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOnv4j+qU/VZgLdanFcvwpHTnsK6ei3C7PR6XeJTQ9Q=;
 b=DcJxkx0OWqW9RygEcH9WzAk4q/Wuq1G+HRHD6nmpp7K2fR64kBJ+fihkr/VpA4egL4cGm8c9mWBYQAijkmbm3z1AClDAburuGvMJ+PtYdWemYXaKhRADLFPzBfM96xxkhKQ0wJKuGj2gziyYpDO99LV3ok2Iw1Qqf+dRpqGTpK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GV2PR04MB11737.eurprd04.prod.outlook.com (2603:10a6:150:2d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 09:38:06 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 09:38:06 +0000
Message-ID: <513762ed-a842-466c-81a5-94ef1eee9260@cherry.de>
Date: Fri, 22 May 2026 11:38:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Replace ASpeed with N:
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Tom Rini <trini@konsulko.com>
References: <20260521201801.44018-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260521201801.44018-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::13) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GV2PR04MB11737:EE_
X-MS-Office365-Filtering-Correlation-Id: 3614e880-99b5-406b-d702-08deb7e5d3f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: MdktMdP7DT7tetBAQh4c/aSf4gOoz0g22Dp4fKXH586SirKvs5sV/5wIAk32ZOdJUI61Ys3afCDMl+AJ3Das5I7suhPx717pGhO6YnTFFZiMt8OLlRU/fE3InKhhdw/B3jX0zHtJj6mSkzaTfOwz/fSoSZRLRFs5zev2WR6LhXH5xwMOxS1r6JPllrJty1Eu6+0zFK6GAKoXlz5xiW8Uwc7PReNMrYelsb09AcY8l5X/9qUfMvHECsq/jrUS6W9gjfCDyZC1L4oRadci9K7QqJrALNrcrIJT2YM36+MHHB+yYSbSVV0U4IauDjmkbstH3GLdYejkdeHUdcnk6qkPCSp/AHHcWpeUb8RRNmk5cBbLP0si0vGC1IdDk8yHL9T4FnRspf75pv00ZzkbM6SGy9xSX4YV/1ncaTvqT17DyLd8hjCSir0kY65CG81WU+r9GzjxsjZTl+jSn84XnEsvBNy/ta1tdbIozYq0KiC6BHv23YLoek5FnT8+mmvPNslYI6fbwj9MrAG9sF8T1ez9ZTqNo7X5t6Ogmx2MFvgjfqs2oVZYDuSQToY2TlL1fcWZmVqsXwgSTXgSHKuiqsGqfxGtXcQGABBFoh5L/9m81zAsCXzcro388+2Ifbs3PHHOVlmeglQnI8/JjU9rMw8fymGXAgRHiClVUAtxOmwtvL0+DYGwEBp/Akh7Wg4C/3NM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk5LTUFHZkxVc2hkd080U0RrckxEbmx6ekZDK2hzK3pWMm5HUnkyVG9XTTVN?=
 =?utf-8?B?cklQbXJ3by9vdU94cmJ1R0dIbk5GRFphWXB6cmdXb1c0WjdtSXpIZUltUnFI?=
 =?utf-8?B?QmpRSE1Jd0JVVVYvQ0NKWmhZak5Ydk5BazVnbWdoaEtxblpUMFJLVThGZTZY?=
 =?utf-8?B?YnFucFZyV21jNmJ3U2RFSS9RMDlLdm50ZDJWL1JHaU92S2RHOERmeWp4U2ps?=
 =?utf-8?B?WGpWZEcxdWV1ZjduSjJVQTQxUFJCR213YVQyS2h2Qkk1MzFlTWRqdWtrNS84?=
 =?utf-8?B?VUMrRjJoU3hRYUNBaVplOSt3U3BSK2lQbkdTd29jYUVMQ1VWeW15ZkVNcTBP?=
 =?utf-8?B?M0VIc3hSZGltV3VkNnRxandUV1V5UWplZHNpSDNINHJBNXR5b0w1Q3NWMlpG?=
 =?utf-8?B?VXJLTDZ3MmVqUkdhaXcwQjNaczRaMitNYUZ6WVNSWmhVS2NWaHdMNUtKcHdN?=
 =?utf-8?B?RVpmS25WMHp6OUh6TmlwWU40K3REaG9CZlkvTmZpdWRnV2J4SUErQjdkYzdB?=
 =?utf-8?B?aEdodk91WXZIbCtoSlF1L1dwNGR6Rk50UXRTdEQxMjM5ZFlqL20wdXlnb0x0?=
 =?utf-8?B?RTJkd1ZMR3NrcnpvZUk2QmxISVZEM0FNcldad2NCRG9Dei9zbTRVUVgramtR?=
 =?utf-8?B?MTFUYjRZWEJCOURkOVBUV2k3d1RRS21mQnlLYWxPY2Jmbi84K2w4MUtENmIv?=
 =?utf-8?B?VGlmTUgrSU9TOUJPQU1FTUg5bU9vRGxJU2lYb1MyWHlEbG1mWmVYL3BVdFdQ?=
 =?utf-8?B?bStnUU11L09ONExjUWJiTHpjcnRxeE5SSlAzeThQOFd2QmV1U3ZlaElZTHJW?=
 =?utf-8?B?NGtXMUZZWUtUU1NLWnZlTkhtakhlK0NuZGhQenRiVUt4V3BaRms0aWNYSml6?=
 =?utf-8?B?eGRiSHp0ZG90UnJSV09iTlBLNzFKQWl4TEk4WFpQL2RCNjh5bDNIZDJuU21i?=
 =?utf-8?B?OTBRejJzYm95MFlBS3p3a3Y0UjBBV1g1dWVCZ3BCQjhLb3NTVUNLcVphcWJl?=
 =?utf-8?B?ZkpQV2lUQnYxTFVHN0F0VndUSXpPaFVqRm1RWFFOTnJRUWduZ1B4STlZN2ww?=
 =?utf-8?B?MHlNbFRiUTcyMnRoRGkzU1JzaE1VL2lOc3BvaVBQbXJ6akFpM1Vyc3U2dVdh?=
 =?utf-8?B?ZHdBMmNkaXB3MS9weVFxbUdKTEFmVWFQaGc3RHJrSVhQOGFsV3BoNkpmb1N5?=
 =?utf-8?B?QVpkRkRmTzJPSjQrcVQ4NUw5bmlHSVdpc2J2T1dLc1pUWVc3VkNBVStzaUhM?=
 =?utf-8?B?UmRnS3NESzR5OTlaM3pDYXZheWdFaHdVMy9qS0huL21BT0ErdnZCTDBPallm?=
 =?utf-8?B?QitPU1ljSEExaHZ0Mk9PN1d6ajJFSlowLzBuelR4eUQyL2MybkNmYnNNODFy?=
 =?utf-8?B?UjFXcWR1b1VIYkVMVUw4N2tueGlGd3Z3UThqTjhMRjlNQ2FuaVV5eXdsbFJs?=
 =?utf-8?B?ZU9zblFpbnk3Z1hnVEJTdWVIbHprYW5tREZIWGJYdEdHb0hCTHEvMDJ1L3M3?=
 =?utf-8?B?VUJFQm5iNlpkUzI0UjhiVHR5bkhhQ3VMSktWU01GbkVEVi80RURNN2JVUk1S?=
 =?utf-8?B?S2dNQkJ5amFKWjE4YS9NeUZtMEMxWnVUNk81WWQ4eFFzR2JVUVVUZHNnM255?=
 =?utf-8?B?TDBMR0l4T2NFL2FCUjFOam1RRXBlamdqZWk0bStQVkwzSTd1S3RMME50YUdk?=
 =?utf-8?B?Y3BQY0w2ODU0ZHNadUkvOHdlVTU3NFBmSFlqZi82VTNTWVV2YjVxUHJiakRI?=
 =?utf-8?B?M3FLMmNCOXh0TE12Vy9raExydExVazQ2M3hXUE5na3Evc0NIaThOR1hicDh1?=
 =?utf-8?B?UkRidlgxSzJSUVFrVkxiQjJZUjlTWldDdUcvNFdGeHBIUERPa1E1bWo4cUcv?=
 =?utf-8?B?ZW5Fc3lRdGNUY0pCSER3eDY5RTF0WHd1Y09vMkdGUUtuNGl3blYzclZwT05B?=
 =?utf-8?B?UkU2UXBsQzhTWmNwWEhlUUNHTm1CZnZIOXpiUEFFaEd3Tld4OER4UlNiWTJo?=
 =?utf-8?B?SlhWRGp3MThsaWcrVHdqdC9tTGJqSEtKNnAwcldGN0x2MEJsMVIyT0x4UXcr?=
 =?utf-8?B?Vm51WkhuVFVYQVpMdXRZU2lkYzUxVHJGTjQzS240RlpTS3BKZ1lhYmk4cU5z?=
 =?utf-8?B?Q2dKRTA3Q0kwNUF2Rmd1S1pubExDNHFQZkdXeFdYYmxnZmlUZThlT2wvejg3?=
 =?utf-8?B?c2RybXk3MXViRkxMc1ZLYW00UEhPelhQRGRFeFNxM2JyOFpQSXAyN216aXlp?=
 =?utf-8?B?V2Y2c2FIRS9NdHFlWDczYnZDak1rZFFLRzhwbk5uL21FeWxBV05SdmhOZkxG?=
 =?utf-8?B?cytMM1E5T0RzSU1OS0RrOGNsejJzSjIvVW9TVktTcmxtRk45R1NkUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3614e880-99b5-406b-d702-08deb7e5d3f6
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 09:38:06.6661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dotdr/Pcl6dT75Tlw86j8S9YXU59vDuUr9Mtef3fsyRt8d+qipiyswMe/N09wlISkHSmDLX2fhoLIpzqy6bOJ7T0Ss9j1M7QTgx01I5+spg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11737
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

Hi Marek,

On 5/21/26 10:17 PM, Marek Vasut wrote:
> Use N: to match on all aspeed/ast2500 files, drop the large list of
> entries which represent the same set of relevant files and miss a
> few in the process.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
