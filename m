Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543F2C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 08:36:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83E2288122;
	Fri, 14 Jun 2024 10:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="I7t+dL6q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC187880AD; Fri, 14 Jun 2024 10:36:44 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20707.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::707])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D554688122
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 10:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f51hvAzD6DXf9qQeTIYUhZIUJcOYgrk6IJ6qPq1L3JtuoiRP+MSBbSmnm68F4O+pgNsYi1JwBW2fy153A0Gml57dw0ForsBC4avV7lQvVXvuGFyxyUTF8J40h53RRcKEitZ9hOukQ5teR1iECP5DNWguw5EE390se05tq4fot0/l1O+A9ssAql2qGS/La8Ta/HDhESY7sCz2KW7bFUk+a4WAHka51R3wq+ZI1NW3IOKEsaPmdyY/ZoH0/l4b3avnxLXFXthT7fSZ4ftz6i0Yi7jKnmxZ8b1khsFQNB0Lh6RaDZoDtM8M0hJQ257WYgPbHUdYStNPDL+D9CZ5ye5IEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vE6Lmmn3Cc+WGp+rKK4y526r+wgT4PXgYnS3nJ0Cpbc=;
 b=N6fg6UMcSek5cpG/ta4kHoQrFyaMe64TjMNjtGEy+CiY930jhVi9UKTWIdKCg1HQ+n+QD+MjKuBPInYcIjzzQmtvTk08G1iIzn6AQr+hRNOuPRpSa0kbTWxP2lWyCxcsEHFAIXE9V3n0yBQpD6LGLIBh9dlGToal7c1qosUCd18pQtJWMXq8QVZyqE5MkA8Tf4VWAAhblr04iDdK0ltbcR4p/auRQOGOc0cqDrexAh9lQlNBq0ly8WguvEWRjBvSnPnQckipGAdrAsMkW5MtMUMFhd8CqpVx059NvwQDxzRYkDmQR7eqzU0biLOlSb8pRYPwdW5JLEh8w6UIcXwWBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vE6Lmmn3Cc+WGp+rKK4y526r+wgT4PXgYnS3nJ0Cpbc=;
 b=I7t+dL6q5GymLmPfWFgWFBQKnB6Z31Q5EhdCOhulyrEwK+6JHLTHyT4DEbo+KyF7l97deu8LqLPdD+cHV2+jdax0zjaeh+V6lHUmDPaVidkis2W4hJzsL3hOiWAlTFfnWzJJx/6l6C1HNnRVxiUcGKy6WD7I0Ims4sjkPNTDZ9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AS8PR04MB8278.eurprd04.prod.outlook.com (2603:10a6:20b:3ff::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 08:36:40 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 08:36:39 +0000
Message-ID: <b68b1b5b-6858-4d1e-b341-22c7bda05359@cherry.de>
Date: Fri, 14 Jun 2024 10:36:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drivers: bootcount: Add support for ANY filesystem
To: Vasileios Amoiridis <vassilisamir@gmail.com>, trini@konsulko.com,
 hs@denx.de, pro@denx.de
Cc: vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
References: <20240613220212.37078-1-vassilisamir@gmail.com>
 <20240613220212.37078-2-vassilisamir@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240613220212.37078-2-vassilisamir@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0028.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::23) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AS8PR04MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: 629e856c-ff5f-411b-dead-08dc8c4d1c74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|366011|376009|1800799019;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3FBMGZKekpZcXdHVVFBWFA0K1FyR0J0cjhNM2QxUVlETzFob0svNlBkNzlB?=
 =?utf-8?B?cGdrNHlXN3BYVnN1UXFEOWJ2Q2d0WGNBU29ta3FYZTFpenJDa0NuZFcyN2Rs?=
 =?utf-8?B?MS9EM3lnRVduVXFaUzlta2R6VWp2ZU1vOU9KdmFyZ0pHQnQzMWhXMWNQSW44?=
 =?utf-8?B?c3ZBVCtKNnRHWnR5TXBraE5kMnVFcnUwS2Y4Nms3QjBXeDhmQUVaaHhKSHda?=
 =?utf-8?B?cEd5cXR0QlJ2eE9nbEpncG1mM3ljZlJYdGtkSHhKbFhIVzRsRGZ6SUY3VzRE?=
 =?utf-8?B?Y0RUMWxWZllJRDdzbzlQT0ZpS1FzdXFPOHdsSE5pTkZQK0pQLzA0SUxDTkxn?=
 =?utf-8?B?eExGZ3hLVnBLbDRFM2hNMXdubWZHYm12SjBkM014NzRpb05nN25wMXNJWThG?=
 =?utf-8?B?Q0pyRzI2Q0NTdDRkaWtuRjI4N2JXQ1FrME5WL3hDWjQvTzExckZFNzZOa0Ra?=
 =?utf-8?B?MUQ1d1lIdjlXSkx4bldycWJ1d2s0TVZIYmpma0JvMVlFNEJIdHZ0T2pIZkpP?=
 =?utf-8?B?dWtySkpEUHVic2F1QWZwc25qNm1FM2pmRlZRcGZpeFBTRW5XU1p6Z0FnWDFk?=
 =?utf-8?B?dlVDVFVWY1A2S0RIbEczWDBLb2FEaTN5dzVpbFFTV3lQNUo0SXo0YmRBc1JL?=
 =?utf-8?B?d3plclM5NUNJSTdZZHAvSGlYSFpncU4zS3p5KzhmY3BDUG5xME1lR05qSi80?=
 =?utf-8?B?b3J3RHM2SWtCNjRIY3ZtTUY4YjFFSHhSYjUzS0lyRkQzOFFhQ2lmbW0wdmh2?=
 =?utf-8?B?YkhYc0JGOURTK1NQamE4VXN1a2V4VUJ5MVg5d1Q3WEpldGZKQjdJbVE1NnBO?=
 =?utf-8?B?WlNEVVJRY0NMaStGUlJVYjRDNTVRa0ZXV3NyZTdkUEptTWZoRWh2ZC9Sa0xC?=
 =?utf-8?B?RWNnNVVmRUhZakc4bVF3ckdTNkFkR1VwdFc3U3FaaDRMREE0bjAvZTF3M3gv?=
 =?utf-8?B?OXpXTlhucllua1ZqOXNJSmdzUjdIT2tVMTd2WS9SOVdpbk9hS3ovZ08yQzF6?=
 =?utf-8?B?S3pxeGE5WjFoTW1WM3BGM0g3Y3JVOEoxT1g4ZzNoV2FCa2VBVTNMWW5ycDRK?=
 =?utf-8?B?YVRpT083WVpPaVRPeEVWNmhiSHYrdHpwbUpqT2JtSmxudmZ1SElmcU40OGtj?=
 =?utf-8?B?cW9EOGZwNS96bGlmNzBDSW9xSFFGdFBoU1ZTL3BnRDhmZGVQY2FDM0xrMGV4?=
 =?utf-8?B?ZlFkcTZuWGc0U0FEWGJkZ2gwWmZHWG16dFZDZ0M2dFVhTEFTQXNWSWVZRXhE?=
 =?utf-8?B?bFhsZXl3Nkh0dXYreENDNUhVbmxSb3hGVXFjZm9kQ2dWU280bVk4NEswZW9U?=
 =?utf-8?B?VEcvemVGZjhlWEd0dHZmV0ZEUTJQMEcyc2d2d05wRnluV01NUHdHOG5ZL3Rs?=
 =?utf-8?B?VmRiZ2Z3MDlLRU5tQ1RlSm1XWlhTUWFWdHVqSFN5dG1HV2pNSjNORWZFSlE3?=
 =?utf-8?B?N3FtZWdyL1pyMTRGYi9HOEpNWVF3WkhlZ3JkTW5tNDlPMGVuWEx3WmVUMVh6?=
 =?utf-8?B?R1c3V0lTWThuZFRWSkR2T0xyNCtENmJiYmpTeWUvcm9jbXU2YzZyb0xhTG5H?=
 =?utf-8?B?V3R2cVNkaEVuN1hJSmE4NXFlajFVaDJJZ1p0YnVFbllwbVJzZ0VnU01YUzcr?=
 =?utf-8?B?YS9EVW4yK2p2S25RV1d3NXl2ZHdWWGM5WlZSL1crcHlpSjhVOEdFeXMyUkk4?=
 =?utf-8?B?c3ZYQThrL0wwZElrMDh2MU5WTTZMMlFMOHhINnpHVElOY1ArSXdjQ3lUMWJi?=
 =?utf-8?Q?9D+6/8VU09MwIdMT7w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230035)(366011)(376009)(1800799019); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1pSNDltUVJFN2VYWFA4TzlmMUFxeTRhUUkycGV3a0s4M0ZvUHZIVUU3RE5p?=
 =?utf-8?B?MG5vSUx5eUVXRFN6QzlUTTUvWkhsQklQYlhKTmZXYjV6aHI1cU9ORnEwUHd1?=
 =?utf-8?B?ZUczMWJVZTNadkY1My9LUVpuTm5wdUNvRjVzdlFqRTg5cmJycG1IK3NGMmxx?=
 =?utf-8?B?OUxxc3VGTG1jRDI5YnhnVzZ3dW12eE9WNjhzTVhRL1MxMEdlaU00dU12K25z?=
 =?utf-8?B?Q0RNL2Z4YWQ5TWM4SDFyWjBOZ09nN1FoOTh3a0xnWU5KeXBwK1hqYktMalBN?=
 =?utf-8?B?UFRLb2RrUFNzSnQ1bWo3cWRpM2NsejkwTzNFdlRTajV4ekdBZjUyZ3I4NjEr?=
 =?utf-8?B?L2gwR1BtbkQvaHFIUUdJQlJjWU9kOFJwWmw0ZVVLQTFld0xOTHBiejRHZ3NZ?=
 =?utf-8?B?L01RdjgrWjk4ckNxOVVLVGoyZ0lTZFdBMzk2UGVLU3pLY3Uxd0laWk03RTdJ?=
 =?utf-8?B?T2FYS09jUThBcW9pQmhuT1VGVGUzcUZhbmpDZXh1SkNsM010a29TT3c5Y0Uy?=
 =?utf-8?B?eU1EMmdtemxJUnFwUXliSEhNNlE4elRqeW1CV3lobzVDOU1laFd2Qm9Yb0pq?=
 =?utf-8?B?RCtnNW1wWlFTSTBib3VMQlJ2UnQySlc0NVNYUWpRZ25vTnVYSER1Y0NGMDI5?=
 =?utf-8?B?UGRaMVZka2ZsUE1qdUZyVFRQM3VJanJWTW56dWdNcXNMMVVuU2h3MEFYbVk1?=
 =?utf-8?B?Ym1pMDh0SzhzazE4aDNUQk5NdG1MSXk2UTJEa1JOb2dMSE1NaWJUelhoMVhV?=
 =?utf-8?B?MkpCWGVaNFVOSjVzYmtWOUFzcUxyTmkvQm9WUlQ5TFI3bTAxU2JrSVZXSWhS?=
 =?utf-8?B?TlR1Q21Ia1hSZ2s1elRVa1Z2aE5FSVdFbGtpdENlSzVoR0srZWlCSmhoUm9U?=
 =?utf-8?B?L2lNaXBqaUY0dzFoWml6OFYvS1pwSDNNVVZ2clRBSmdlRFdTU1hlR1Bjekor?=
 =?utf-8?B?akhvLzU0enlrMW14VGRqc05KWms4RFYwUTFPcXo1dWpML2hIMG9FSUNaeUhV?=
 =?utf-8?B?YjkvSnlWZmZyTWdkV3lMaGtXcE1rQ1ZpNW9YR1BFcWVvTlU4K1BSQzhtdmo4?=
 =?utf-8?B?bkJWWCtHRXhJV09ZMWV3MnVMNjhIMlgyK1pVQU5LaXdGQTZhVDQrUWdOM1dW?=
 =?utf-8?B?RGZiMnpSdjRXUTBkekNqMmRKblJOcDQrRmVZZ2tUUzN0aWlZUHNZNFluUSsx?=
 =?utf-8?B?Zm5rOFJySWtaSXlvL3pMUzRWSThDVnEvQXM1OW14WTZRalhKWUp5cVFOejU2?=
 =?utf-8?B?bHk1L29pV0NobENXMTJyR3NRTHQ5eDRJMTlEaHlIUUtudG8wU2tNWDhNd3Bp?=
 =?utf-8?B?TUwyWEYvTW5uWVovbWJ1RmRpOVlDeUJ3Z0huOEs1cmhuWE1wRE1vSXZCV0JS?=
 =?utf-8?B?WWZ2VXFNakNGM1RkVDZtUUFkc2J1MXAvd1NRdnVtM0o2d0tOdXBPMnBzTnlJ?=
 =?utf-8?B?Y0J2d1ZreUZhK2IwWjlOZzNuQWJuYVh3RjRJNFFMZzdWQkV6QVdYRkx5b3B3?=
 =?utf-8?B?M2l5WGkyUnBmSXZKb1BwM1VwWGU0R2NPSGVyeUJmUWpJWUdsKzJxdXpJY05R?=
 =?utf-8?B?Z0Q2Y0s2M2RCcFl1VlFEZktnTGJOY05WMnZSTlZQZnIreDVOYTZlTnJUUWJT?=
 =?utf-8?B?ZUNmV3doUGJjODljZXpITWhTZnJGQWRKejhaODhROExpT2d5amEvQkxmVTJ4?=
 =?utf-8?B?czRQckl3WTB6WHNmNENYWmFqNUpqak9HLzVWdUxRalE1Y0QrQWo2Y2E2TWtC?=
 =?utf-8?B?YkxyclYxVTNCaDU1TmFvTytBbE8rMER5NG5heUJZNVVJNTczK3NFbFhWdVpi?=
 =?utf-8?B?bUdiRHZVc21TbnlubC94azBEUDhveTI5aFkrMVdlYVd1akdRaEYrWks2OFF0?=
 =?utf-8?B?NWU2RTZtQ2xNcExzRGh5WURKRFNkT2JVMWZnWW1pNmsvSU9yeG95VFRTeko3?=
 =?utf-8?B?WGlSTW5LTUdXV1FQOUtLWUtXU2kvWkwvQmp1RVhKdmMvWmJsbVRsMUpsMUZB?=
 =?utf-8?B?cjZtdlo2aEJORU5zKzFXNS9GZmpIc1VSWk54akRYS2QzNTY3b1dXaUNqeGVk?=
 =?utf-8?B?TzZCanhkam1hZjlNSlRQaHhoZWRFN2IxdWRlT2tmV2ZSeWtEUlFEM0RGRjZW?=
 =?utf-8?B?aUdYejl3YWwvenliU29XWXJ2M1pubmJYS3BxSmpHNHBHZlAybTl4eCtMU3hl?=
 =?utf-8?B?VlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 629e856c-ff5f-411b-dead-08dc8c4d1c74
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 08:36:39.8609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hQjPswdQI04VZHZFcYqIUMDIaHWjV2eVppebuv57lV9jS3M/g8YDPE6WyQ/KktGj+9d8Bz+Vl9wxQs515J5qDTHJkVp6VmEiE8RlOdkkyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8278
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

Hi Vasileios,

On 6/14/24 12:02 AM, Vasileios Amoiridis wrote:
> Add support to save boot count variable in ANY filesystem. Tested with
> FAT and EXT.
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Heiko Schocher <hs@denx.de>
> Reviewed-by: Philip Oberfichtner <pro@denx.de>
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>   doc/README.bootcount                          | 12 +++----
>   drivers/bootcount/Kconfig                     | 36 +++++++++----------
>   drivers/bootcount/Makefile                    |  2 +-
>   .../{bootcount_ext.c => bootcount_fs.c}       | 12 +++----
>   4 files changed, 31 insertions(+), 31 deletions(-)
>   rename drivers/bootcount/{bootcount_ext.c => bootcount_fs.c} (81%)
> 
> diff --git a/doc/README.bootcount b/doc/README.bootcount
> index f6c5f82f98..0f4ffb6828 100644
> --- a/doc/README.bootcount
> +++ b/doc/README.bootcount
> @@ -23,15 +23,15 @@ It is the responsibility of some application code (typically a Linux
>   application) to reset the variable "bootcount" to 0 when the system booted
>   successfully, thus allowing for more boot cycles.
>   
> -CONFIG_BOOTCOUNT_EXT
> +CONFIG_BOOTCOUNT_FS
>   --------------------
>   
> -This adds support for maintaining boot count in a file on an EXT filesystem.
> -The file to use is defined by:
> +This adds support for maintaining boot count in a file on a filesystem.
> +Supported filesystems are FAT and EXT. The file to use is defined by:
>   
> -CONFIG_SYS_BOOTCOUNT_EXT_INTERFACE
> -CONFIG_SYS_BOOTCOUNT_EXT_DEVPART
> -CONFIG_SYS_BOOTCOUNT_EXT_NAME
> +CONFIG_SYS_BOOTCOUNT_FS_INTERFACE
> +CONFIG_SYS_BOOTCOUNT_FS_DEVPART
> +CONFIG_SYS_BOOTCOUNT_FS_NAME
>   
>   The format of the file is:
>   
> diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
> index 3c56253b1e..fbf3c56b41 100644
> --- a/drivers/bootcount/Kconfig
> +++ b/drivers/bootcount/Kconfig
> @@ -25,13 +25,13 @@ config BOOTCOUNT_GENERIC
>   	    Set to the address where the bootcount and bootcount magic
>   	    will be stored.
>   
> -config BOOTCOUNT_EXT
> -	bool "Boot counter on EXT filesystem"
> -	depends on FS_EXT4
> -	select EXT4_WRITE
> +config BOOTCOUNT_FS
> +	bool "Boot counter on a filesystem"
>   	help
> -	  Add support for maintaining boot count in a file on an EXT
> -	  filesystem.
> +	  Add support for maintaining boot count in a file on a filesystem.
> +	  This requires that you have enabled write support for the filesystem
> +	  that you will be used by the partition that you configure this feature
> +	  for.
>   

Some English issue here I think, I can suggest:

"""
This requires that write support for the filesystem maintaining the boot 
count file is enabled.
"""

I think this kind of change can be made while applying the patch, so if 
I were you I wouldn't send a v4 just for that unless the maintainer asks 
you to.

Looking good to me otherwise,
Cheers,
Quentin
