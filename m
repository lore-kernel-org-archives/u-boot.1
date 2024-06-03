Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB23DC25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 08:52:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 219D98813A;
	Mon,  3 Jun 2024 10:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="DFwYCDXg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E316888189; Mon,  3 Jun 2024 10:52:27 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20716.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::716])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4EC38813A
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 10:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsAP+AU8YcgbQL0kRVnR7LhakxksqeK+pWhZskaWVh5FSLsVQ3bTZhhCoIeMT5Idjd5dmU2ANTZTouB/o7lF6h9i4LZEPw056nsHTDtCvxcVioY50f2diTrWxuPSkJ9PSifp+552qwqYS6s0oyleYQ7/aixVn9juif8Jn5JU/Lp/aqzdohKJka/Sp4/4nyrFrGaz5zI6R9lS86Antk4mLUMBqG8m7/Bp3mGTucSf5eYFFY5KSx2iQqDKWrC/L3fcf/q15e2472te/ar6RXbRS8UREGm+OdXCZERw7ahEf3/aljgWyurOPXw+o4PR/PNzNNxD95CRuThztdKBG++fMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOF6OlFsEJgyHjDh3QyDoBzSEJneVrHVxsHxlP5ARiI=;
 b=gxExomgfsNH3VY/DTrrtUdoKeyvGDn9r4vZNaNFXLfPD2OTu3GKeL7gzkm/ixXA6qM3HGS3AyKtHN4Swi+cdulngNjMitHf9ovYF2sMxyhWeWtEzAUbI8Ne71IrkdaXMRRh3XmS2ObWU+Mlq7yL3eq60xqFDbZ+IY8b1ZIxBAlrVCo9E9Mml1vko7Mm5XNirpPukNgh2RORNmvEP4ZTDH87bj1RXsWCL9x9p34q2yXzj2mvd9xpVseTMie0O/hAEVUkJzEW8GmsatCNjuqOuugVN3DH3dP6O88dlJSGxordtWwJkjHSDEK4b3WE6LH4qfjT9EbET5Hok6gwZ8Sk/Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOF6OlFsEJgyHjDh3QyDoBzSEJneVrHVxsHxlP5ARiI=;
 b=DFwYCDXgJx3NyMGs+2WyK0u9DPjQXAWioLcJ3pkBniOhsfauOV1Re+4xrFKHWW6tWSTk92tjKJaGCgoPU4JyYhpT5MWVjeaDZB0fXjYlHNuJMMOj530bb1IWtqxJQDUETvBQAlFQpHpHtqKmrW+XsgCkx0Fn/AwvlJTahuA+coM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PA1PR04MB10674.eurprd04.prod.outlook.com (2603:10a6:102:483::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Mon, 3 Jun
 2024 08:52:04 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.018; Mon, 3 Jun 2024
 08:51:45 +0000
Message-ID: <7efa7845-62d7-4b23-8d04-1204fd9a8895@cherry.de>
Date: Mon, 3 Jun 2024 10:51:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/42] mmc: dw_mmc: Extract clock on/off code into a
 separate routine
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
 <20240522233135.26835-7-semen.protsenko@linaro.org>
 <475aea46-a255-4a55-9e1f-29ee028996f5@cherry.de>
 <CAPLW+4kRnT0kHWtU+s9u2oUf6GYs+-BMyr8P3hGcqbPAst_=ww@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAPLW+4kRnT0kHWtU+s9u2oUf6GYs+-BMyr8P3hGcqbPAst_=ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0285.eurprd07.prod.outlook.com
 (2603:10a6:800:130::13) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PA1PR04MB10674:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb2cffc-ff60-4595-51f1-08dc83aa5a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y214NVVmYWloMUQrbENzQThFZlNYZnhuek1oSmhLbTNGU0l1ZFphLyszajdp?=
 =?utf-8?B?ckc4L3hUNGhLQlcwY0QxazFkL0tMdjNSQzNaUTAyUm5LOEVXOVdrZkxqMlY2?=
 =?utf-8?B?UUNQLzZrdnpIckZieGtFT1VoelEvVlRIeVNYbkRPcUlIRDVYWVcvaDF6TFNE?=
 =?utf-8?B?dWM3YzhNY2l4UGQzc01UTzhpRlMxM2Mzd3FLNUI5OERDeGcvMEJLM3pGZWtj?=
 =?utf-8?B?U2RWWmJKLzlIaW9lV09LTXhVUVFOMEdBZmpJdUFEZk1vS2p3Z0RBcXZKSll0?=
 =?utf-8?B?TjdkVHpWZVF0UDZBajdmejdNTmNvQVkzdFNlaHZSdnhpdU1iZFB1cERMU3hJ?=
 =?utf-8?B?MktJYUJHYThSVkFuRlBsRHN0SmJLYTRueWNCQ2taUFhTUHlNWVFTbGV4WUs0?=
 =?utf-8?B?SEUvZS9VWmRKLy9rdm1heHU2RzgyMGdJWG9xNzZlWUFVYWI1cnFQV2trTE1u?=
 =?utf-8?B?dW50TnQ2dnVGdUNEMnBtbU9GY1NaeE83QjkzRGFpUzhvNmk3K0xLRTNQMU9n?=
 =?utf-8?B?bU5na0ZNdzRNSGU4czI4RjdiWUhQbjZ5eGlWRnVpL2pNc0cvcXhIRXRaa3l4?=
 =?utf-8?B?TENpb05HemNGUHE1dDhOSm0ycmlXSXpTV1lFN2sreVhvMFZhSGc1ZWFHRjFR?=
 =?utf-8?B?YTFzVnkreVFSeGdtQlE5RnIyQWNkTmZnZGhzTERaUzVIamR0MThTTjdrR3lZ?=
 =?utf-8?B?blJlTytXRFFwOWFYeGlLQjNEZEJQc1kxVVY5M2QrTmtpTyt1YU1jdFc3VjI3?=
 =?utf-8?B?T3h4YWhlbkd4WkFRVTM3d1h5b25mczYvaS9sREpQeGpGbnJDU05sb1phdmVX?=
 =?utf-8?B?T3d4U2NLU2Z5cjFlRkdCQ1JuOTVYK2hMQ24zM3RPclpGTThSTTJYMXppOU1h?=
 =?utf-8?B?YlRDcnZrSXRVcTJIVjVpWmlTRjBaQ1Y5MXB1a1BXcGdHRHVwWCt6TWFRQ3BT?=
 =?utf-8?B?Q0lvNm93c0p0WGJ6YldMYloxQVdOejUrS3JEZEcwYkVsUy9MZVJ6TnloVU0y?=
 =?utf-8?B?MkwyU2JMWTF6eE5XOTE2ZVRNemJmYnZ0OWdScm9FK2hSU0FoTDF5dVArMmZZ?=
 =?utf-8?B?N3hqV3phSWI3Skg5SG0xczB0TjFGZFlFOTg2NGNHUDhvZ2RwazFGQUExNzVs?=
 =?utf-8?B?ZVJYdS9oYkFJb0RpOXdMdEJvSmVHVVNuMDRxUG84NFp6aVUwNDkyRTk5Wkwv?=
 =?utf-8?B?ZEFEcWR6UURCUlQxelFCT1hCcnRQR0RWRFQyZHplMVBRRDMxMzhaZWJuYTNo?=
 =?utf-8?B?N2N4L21GTG4rWWVSZVdodHo2S3JBQUFDYWtaVUJpM2doWStmQXdEbFgrb0V3?=
 =?utf-8?B?K0hxUklFWG1IZzNLY3NLb1NpMEl2anNaeW9UcHdWN0ZLV25DWFdqTVZOVW1C?=
 =?utf-8?B?dW85VWcyWFlOQ1U0bXg1QmcwbnBldGREcUhWVk41a1J5OUVZYlVYV24wOW5H?=
 =?utf-8?B?UmZtN1p2bXNNb0o1QVZWa0R2NVE3bEcrTC9YZTF1WDZTdzJMb0hYTWZRUmo3?=
 =?utf-8?B?TEJCaUlvbVpRR2RrR0hPVUlRVHRZYkhYL01XZkgxc0VNejZOR0ZHTk5nc3U1?=
 =?utf-8?B?OWErWEhWUkV2UlQ3NmwzQ2JwV05ITkF2TjhSNlc5M3lQTk45SDU5SFRnWUtn?=
 =?utf-8?B?SFVvQUVkRGpxL1hLVTFJRGhwSUJFY0RPTzhkQVRwYTIxOXo0cDFvanJiL1Zr?=
 =?utf-8?B?Q0dPME9WMmdlQXVUV3hBNTRCVEg5ZUJrY3BOMG9LYzZ1VFBPVmNFQ1BnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFNaU3hjMUxWU3IxV3ltTTRHMVFOUFplTmtUUlFza3JVOW1XcXJpN2g1Uy9Q?=
 =?utf-8?B?TW5FbVZRNEVzREZwdEVLMkNZakx4UERadzVpWExlSW1QZ0pHMGhYYzdFSFA0?=
 =?utf-8?B?bzdYNllNTUJlZGRpMGovMExsRFFvUEJjVVdsbVdON3RoZzV6UmhYSGMzUjRQ?=
 =?utf-8?B?d0lTckNkUGVkRFRoblV4NFEvVjlNbnk3TkJ4SzdPd0ZsTHp0NGNrbVRrWDVa?=
 =?utf-8?B?b29YcXBrYkV4UW5MSlJ6N0Y4dzIzcHdJcHp4cy9IU1AwRytmQTFzUmdjbDMy?=
 =?utf-8?B?eFU0OVdUYkk1MGV3VHhqaTVscUxIWEpWMjVIcEZjN25PU3c5alBsWVAvVndK?=
 =?utf-8?B?TFducUxQdGswZWFrdE1zdTV3K3lCVDdyQ3RIUjVSajRoc0x3VHpGVitueGxj?=
 =?utf-8?B?NHk2aW90MjJ6OTA0RFlkeThZb2V5M0JTa3NnTUs4djBQQUhqdHhzL3lTV3d3?=
 =?utf-8?B?RkdoU3A5U2FVWTlGMGsxWEtNbzdCbDE5c2VGREErUTlPaEM5TXRhQTR5Y3N0?=
 =?utf-8?B?RElvcmxzVVZwc05Gb0dXeVFueDlIRkNDei9LV29GMkdYN0JEQVlXL0NsWjFM?=
 =?utf-8?B?NGdURHJXOHdsL1poenZVS2lSV3VYWXZwU08wbTBicWUzL0NJU0J5V3dBUldV?=
 =?utf-8?B?dDFsNEhYNGs2SHpWanpTYlUySmJFNk9XY1BlU0FJaVhnNHR1RXM1MHBwK2dl?=
 =?utf-8?B?NGRrUWF2bTYwK25UWENJTTBOTjlaVy9GR3FlUnpCVkFNSHA5NUFWQ2RvcnlD?=
 =?utf-8?B?SnFIa01sRUg1bCtYQVovdFlxYlJlWEdkSVdxb214eGt3clAxa1hPT2IwSDJt?=
 =?utf-8?B?eTl2Qm5UeEpUVGFSU2UxaVowU21CWkVaY1VzZUE3L3YwSzNPcE5mUFV5OGdK?=
 =?utf-8?B?RzJiaTVNMlFzSDFpSENZWWp3Ylc5UFZOZ2gyeUtUTEhaVVJZRmF2WkxZQWhR?=
 =?utf-8?B?MDdwRW5SbHl4NDJsTVk5NDZ4cDk1VG45NWVBQmpZNzBqS1laWktaWDFhMDVT?=
 =?utf-8?B?cFNpWTJWM1V2bEhSRVhKSld3L0hsSzgveXovMk1XeVA0SHNhTnNIRU9sNW44?=
 =?utf-8?B?cXhEbzAwK2dKbHlINXBaeFQ0bmhCVUxjSk9nVVZycVZveDdyWG5sdUxOTTl3?=
 =?utf-8?B?cTliQkdiOUh1RU9lSnFGcUVscjM1SXh0cDVCdS9wTDY3WW5GU1NHYzlVa2Nv?=
 =?utf-8?B?RlNtbUs4aG5XbHFZVDZISk5ISmsxd29sekd4bHJTMVhDVHVvZUdCQXAzVDc0?=
 =?utf-8?B?N0pxTnpkcjRIVWdiajBPQ0YvYXZhMW9jdUpHaUdFNnVSQTVFZXh2alNFQjhJ?=
 =?utf-8?B?N2hidjVpNFhwalY4dTlUMWdtQm9hNXpIb0J3b3NNV2xDaU1oUnFFZ1c5ZFdk?=
 =?utf-8?B?MFpBWXcrTjN2ZXFmb2hGK1U0Nmp4eVd2R3BLZzV1NklaNDl2QWRDbHVIZ0VW?=
 =?utf-8?B?aW83UUFEcFJ0VWJOeGl0NFBUUENWYWo1Y1lCWFQvc3Z2M0hOWTBGZTc4YUVt?=
 =?utf-8?B?cGRIdEJKcWJyWDVXNVVSdlhLcG5hYzA0ZzErR2RPZENKMUlZVnZWVWx5ZFRa?=
 =?utf-8?B?WnhtV2t2b1pLY0RjdkEveldWWE9DczVhbStGVGpMTzI1V1M5aHlFdzZwbGh2?=
 =?utf-8?B?MWJCTSs4dUIwclRRK0U4dE9VYlR4aDl4UGNoRzZIdDhjemoxVlZTNG9ZQVI4?=
 =?utf-8?B?WHB1aTNob0ZTcXJjZ0x6bGVqU0V1VGIxcExnK1BaNGNIenFIbmZ0aWUwUGxM?=
 =?utf-8?B?R0hqancyQ1IzQWFlZFROVi9KMkZDM2xweWw3VUlHRmphdk5ldk15cFo2Q3lx?=
 =?utf-8?B?ZURBRDF2L041V0ZXdytGSzhrUFBvYXhKN2JWbHBPOXFwVmpNakhNYmlraTVP?=
 =?utf-8?B?dzdubGQyUG9NWjA3RlVyTlhVRElqUm5SOFI1T0tFSndZUVdNcDIyQmsreTZu?=
 =?utf-8?B?M1EweW1DSFpWZzRON25Ka3gzM05QbzN3b1JYdnZmVS85eXhuV3psYXB5MVFx?=
 =?utf-8?B?N0ZjZlE0TnN3MEoyL204SjJ3YnVBbCtubWNmTVN4RDV2TlJ5ZkNNbXJyZ1FD?=
 =?utf-8?B?TWtlZkxBR2pwUm81bEJPWU8vT3BWOVlycjlUNzhyK1B2QWhQdm5qekhveU9l?=
 =?utf-8?B?VStMMEFhN3JnY3kxdjRGS3Q3T21UZExEbVY5cWtxc1NaTmNqSndHcFg0OW5y?=
 =?utf-8?B?ZGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb2cffc-ff60-4595-51f1-08dc83aa5a4c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 08:51:26.5656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wsby6MM/o+uA2iS2HiF5ArP9LNx4/ZNdB8+YgamO1kx7btKAVvhxJ8fNtqocaAj7Rv8JoX4bekT1J9mV5nTPx9KxtOLkFni8bGlBsYtqKfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10674
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

Hi Sam,

On 5/30/24 2:06 AM, Sam Protsenko wrote:
> On Thu, May 23, 2024 at 9:36 AM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Sam,
>>
> 
> Hi Quentin,
> 
> Thanks for reviewing this series! My answers are below (inline).
> 
>> On 5/23/24 1:30 AM, Sam Protsenko wrote:
>>> Extract clock control code into a separate routine to avoid code
>>> duplication in dwmci_setup_bus().
>>>
>>> No functional change.
>>>
>>
>> There are some differences though.
>>
> 
> With everything discussed below, I guess it still can be argued that
> this patch doesn't change the functionality of the driver? Depends on
> definition though. Please let me know if you don't like this bit and
> I'll remove it in v2.
> 
> [snip]
> 
>>> @@ -439,35 +461,19 @@ static int dwmci_setup_bus(struct dwmci_host *host, u32 freq)
>>>        else
>>>                div = DIV_ROUND_UP(sclk, 2 * freq);
>>>
>>> -     dwmci_writel(host, DWMCI_CLKENA, 0);
>>> +     /* Disable clock */
>>>        dwmci_writel(host, DWMCI_CLKSRC, 0);
>>> +     ret = dwmci_control_clken(host, false);
>>
>> Here, CLKENA and CLKSRC are swapped. The kernel still calls CLKENA
>> before CLKSRC, is this really safe? (I have no documentation so cannot
>> tell). E.g., we could have CLKSRC register be a way to select the clock
>> parent/source, 0 could be 24MHz crystal for example, so switching to
>> this new parent before disabling the clock output would likely result in
>> glitches?
>>
> 
> Yes, you are right. In fact, Exynos850 TRM specifically mentions this.
> Here is how TRM describes the whole procedure for "CIU Update":
> 
> 8<------------------------------------------------------------->8
> To prevent a clock glitch, ensure that software stops the clock when
> it updates the clock divider and clock source registers.
> 
> Software uses the following sequence to update the clock divider settings:
> 1. Disables the clock.
> 2. Updates the clock divider and/or the clock source registers.
> 3, Enables the clock.
> 
> Code Sample to Update CIU:
> 
> // Disable clock
> while (rSTATUS & (1 << 9));
> rCLKENA = 0x0;
> rCMD = 0x80202000; // inform CIU
> while (rCMD & 0x80000000);
> 
> // Update divider and source
> rCLKDIV = clock_divider;
> rCLKSRC = clock_source;
> 
> // Enable clock
> while (rSTATUS & (1 << 9));
> rCLKENA= 0x1;
> rCMD = 0x80202000; // inform CIU
> while (rCMD & 0x80000000);
> 8<------------------------------------------------------------->8
> 
> It's an overlook on my part. And although CLKSRC reset value is 0x0
> and it's only being written with 0x0 in the driver, it still has to be
> fixed. I'll move CLKSRC modification below CLKDIV to make it look like
> TRM suggests.
> 

Did you mean "move CLKENA before CLKSRC"? Because if the clock is 
disabled, I don't think the order in which the parent clock and its 
divider are set matters?

> Linux kernel implementation also doesn't follow the sequence
> recommended in TRM as you can see, but it works fine because CLKSRC is
> always written to 0 there (and it's also 0 at reset time).
> 

OK, so wrong logic but it works because we essentially never change 
CLKSRC so it's virtually a no-op and thus there are no change to the 
parent clock when the clock is enabled, resulting in no glitch. Not sure 
we should ignore the improper logic though? What are you suggesting we 
do here?

>>> +     if (ret)
>>> +             return ret;
>>>
>>> +     /* Set clock to desired speed */
>>>        dwmci_writel(host, DWMCI_CLKDIV, div);
>>
>> Same here, CLKDIV is set now after the CIU is informed, is this an
>> issue? We may want to set the clock speed before we enable the clock
>> again. Right now it's setting the desired speed while disabled, inform
>> the CIU, enable the clock, inform the CIU. This now does, disable the
>> clock, inform the CIU, set the desired speed, enable the clock, inform
>> the CIU. We may need to wait for the clock to stabilize before enabling
>> it? Again, just making guesses, no documentation for me here :/
>>
> 
> In this case, my implementation is following TRM (as described above).
> After CLKDIV modification my code informs CIU again, inside of the
> dwmci_control_clken() call.
> 
> Just to be thorough, here is what TRM says about DWMCI_CMD_UPD_CLK (bit 21):
> 
> 8<------------------------------------------------------------->8
> ...Following are the register values transferred into the card clock domain:
> * CLKDIV
> * CLKSRC
> * CLKENA
> 8<------------------------------------------------------------->8
> 
> So you are right that each time this bit is set all 3 values are being
> transferred to CIU. But because that bit is set two times (before and
> after updating CLKDIV/CLKSRC) -- it's ok. And also this way is
> recommended in TRM, as stated above.
> 

Hopefully there aren't other implementations than Exynos 850's that need 
to do something else :)

Aside from the improper logic, looks good to me, can you please add this 
information to the commit log so it's not lost in the mailing list :) ?

Thanks,
Quentin
