Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EDDC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 10:35:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E328F82B07;
	Mon, 14 Jul 2025 12:35:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="RMdCOuzz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1169282CFA; Mon, 14 Jul 2025 12:35:21 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B920805D7
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 12:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TH/Ou/EjArZUO1TVBzYBhUCCIoZBfsJam0x3i8OkyFa9LFNmogS2hmu1oY7SzG04ypXL3gIYl2fu3nb6hoG9B7wvxTMzBa1V+jkpWvjT9GcPvK+0+36SrOHIEkkFZ5svVtC9GwCeMgcfkES68PeH7tEL+7Z/d9t8If4gJdpA9iQg7VYgaPv2wRELRA/AKveJfY1ky6Wh+AC8HqIc3Gv4w6Qp8FrNttyKeFPNdRj0EHJdJS2OWH2pNnsA8HZBZcLHVXrj71Uj+aJb8dnhr5h5cAKuY+YLb/8Ouz4UWEy6axZVXG3VCAgP+Xsp0k2/fKKjmjYyB8IH/rVBXe9B744jBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/So+Vkv7iD7/M92T4HqvL2jtT1OaLxWdWiMpcwBcCzU=;
 b=tFsZI079UptUT84wmexUf6+ipxmV4Iwm4K9B13fVWbb5Lmqm7AW1DLQriYzCZFj81E3NZ0QCCeM8NIdkovBTrd737CIs2Io8DtVgEjj/imo+WiT1RCoPcBBOnOSP6Lqsj6Gaq0/l45ZAtPLzl3/g+HOA0ANGUGZbvsO1whH+loCW/IzbgDqa1/tcfW3kc/zHORwIeHln+tKNtBOI94sXqRMhE2HJ2+m+sxH3CLm7nqmXgN4blIzwTQ+v7LMQVYdMmC0uqMyI5/wW04QNECHl2lLxxzfbbQCLUZ9Ny/qEiPKVSSAm+emrqAGBi+KW9J3puJp2cU8IdGt4XLGnbleWHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/So+Vkv7iD7/M92T4HqvL2jtT1OaLxWdWiMpcwBcCzU=;
 b=RMdCOuzz6MxRxEVlDPeAbQ+64rr+AAMcjzul0U2p78curArKBaQeHtRrQedIIYzS3wSf1wOdHIhcKEKBdGseDXym+hr0yZ0zhqbZ/WuAYm2BwKWTHPyvfJA1PcrAdfyXCc+QHwF1aCzX2wlTNCWkJS0Z8ktYGecQVozbUdjoIzo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI2PR04MB10980.eurprd04.prod.outlook.com (2603:10a6:800:274::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 10:35:15 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 10:35:15 +0000
Message-ID: <f3ff27e4-106b-411d-89f0-82e7e78fff77@cherry.de>
Date: Mon, 14 Jul 2025 12:35:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] clk: clk-cdce9xx.c: Change from u32 to ulong for
 addresses
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
References: <20250702010535.19250-1-trini@konsulko.com>
 <20250702010535.19250-2-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250702010535.19250-2-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0074.eurprd03.prod.outlook.com
 (2603:10a6:803:50::45) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI2PR04MB10980:EE_
X-MS-Office365-Filtering-Correlation-Id: e15b8395-0c13-4525-c1df-08ddc2c21ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkZyK3pkdFpKSDM4eDFqcnJzK1F1RkVlUGcvTENjbkd2UDE3NmVJMHg0L2g1?=
 =?utf-8?B?VHoybE1heEY3NjRESVV2NUt1MUhIaWNCMVVVWUFlNHVrbkcxK3g4aXFTMEkr?=
 =?utf-8?B?VFNKM0paUHo5YTBYQmVhdSsxZFJRRHQ2ZEFHK2FBd0ZyUjcyWFJKVE1PckZL?=
 =?utf-8?B?Y29hVWtsTC9aa2liTHFrMmd0anZqR25xZnc4N2hwYW44YVZzdm1hVW94NDk3?=
 =?utf-8?B?Rjg3cFZwb295S0Ywc1h6ckVzeERzZU5MTEtMUGhjQ1NORVBzWUFYZy9GanZ6?=
 =?utf-8?B?aXljRzdyYkx4R1c4WVJJcGthRDFJclVHKzBFdDVpclBLTUZoSGlmaFpQSFpV?=
 =?utf-8?B?NW1ndkpTcmdYL0E4Q2oxZ0JHSjdoRlNFRE5wV1ZrSkFuQjVrUE0vL3N3Wisv?=
 =?utf-8?B?RjR6R3BWdGduU09UQW1qT3o4UzB1UVVMeUl0bU94R2k5QjVBTUJla1NVNTF6?=
 =?utf-8?B?RUVPS012V3piVjdoUVg2S2lNR0Mxb3phbUkzYkNCaFkvK2VENjRoYW5BNTU2?=
 =?utf-8?B?c0MzZW1wNWxpV3l5cVFocjNvMVVVRGVoSStKUjVrbkdaUWZZMWMxZS9xZDVj?=
 =?utf-8?B?SnhHcERiRm5uYThNbmVMMFIvd0pMeWRnbThSMkpUNFlNK0Y5Tm5aOC9xTUc0?=
 =?utf-8?B?ckR3a3ZScUFaeFlMNDJyS1c4dmZxam5uTm8xYlJXODJQRllUWDJ2TU0wMGhK?=
 =?utf-8?B?VFRsTzN3enErSjFMTVJ3NUpKZ3k0YjZqZTFRQm1VczVEWkpGcXBoVWs1bGk4?=
 =?utf-8?B?SjVHOHQvQUNDSFBWaVl5UUtwRWpJRE1Zc3k3SXZ1YU9wa1hKVnZabnpDNGNY?=
 =?utf-8?B?enJheUdNb3N1QWo3dHRkY044T0hmZno0dFhyaTVRVXdvSk01MHBzUWRBTkRY?=
 =?utf-8?B?SzBRTHIxaXdtNEdYTFJCZ3RMU21Ea3BkY0pNQjRxeTc4VE1TTTZrS1R6TlU4?=
 =?utf-8?B?SHBJWUlFbVdkc2JZL0NZSWNrUzRDUFB1c09uSWpWbTIzUm1HdUVkOXBydXZu?=
 =?utf-8?B?YjlGSmcvZFFBUGw5bUhPbllQbGZtd1l2YVJJQm14TVJBUXlUaUJDSEZkTUpi?=
 =?utf-8?B?NGptSk5CQmJTcE9YQTFHdkFSRmNzU2FrQVlTOE1GZzVKcHV2bVpPRnBkUFVy?=
 =?utf-8?B?NzBhZ1dMQTdsYVRJQktJUHEzN0c2WVZxS1JDWFdwbThCelhKWFFjd0RHTTJo?=
 =?utf-8?B?bUxCT0NkSVl5KzFhMEw3UGovUGo0U1FXTC8xSzk0Wmx3TFE3R1NBZmM3L1Vj?=
 =?utf-8?B?ZXk5QjUzUk1HMjVQd2tqNktkSElvK1FWcEgwRS9UTkhOM2YzdWs3R1lJdHJT?=
 =?utf-8?B?NFdrK2ZmenlvRVdkcDFtVFpYY2xFci82V3dEV2tNZ2dEV08yZXhxODY1bytZ?=
 =?utf-8?B?U0VadzFJVDFyNDBMQU9hdHlrYnpTazQwZDZzclRmNzhudnVGb2Y3a0ViWnpO?=
 =?utf-8?B?UkVzb0oxUDh5OE1XN21MMGEzT2RUbStrd3BKYWlJUVByNnVVUXN3emhQYVdH?=
 =?utf-8?B?UE1aem1ESXJHT3lQbXU5V295TU0xcVdkdmozaDRxRmRaVkF0SmhpR0ptL2xW?=
 =?utf-8?B?a1ZBU0ZKdkZROVBVeEx1aTkyQnpaUVVBOWVGckJzblBNb3BCRzJnbW5xeGIz?=
 =?utf-8?B?VmIvWWFTQ1hLRE52czVDUDZhbU9ObitKUE1WY2VsWitpemhTMUlmTHI1cU03?=
 =?utf-8?B?TkVIc0VBK0ZkNjVjK09XUm1hL1RWdGY4d0ZWKzdENis5WWVGNlJsMjNkTmNr?=
 =?utf-8?B?WFdJdFVqSGtCUk9WejQwYkpoMGJaYW16NUF2cXduVEdGWGtHKzk1a2p3bzdO?=
 =?utf-8?B?eWo3ZWtWbUkwVFBHSHVKMUpuckQwUUxZUXNYNWxtNmVrbkdnYnlKR0hYcUhx?=
 =?utf-8?B?Qyt1bDFYeEtuS3A4cXpibHlqRlhzOTVNNzBZY3lVSVRPekYzRUduRjBmbWJB?=
 =?utf-8?Q?RKTqSywM89M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3ZZaHRKZUV3ZnIvdTVqWGpiV0UwOS9Sc0FueXJkT1l4M01BK2hHQUROOTNG?=
 =?utf-8?B?T29LSXd3SnJxelFDclFaTU5WL1JPTSt1eDFYa05FYnNDVlNkWmN3MWpIVFNx?=
 =?utf-8?B?MmlCZEMwNmRYMURjZzlPVy9sb0xKYjdyaEsyUkN4TTdlWWVTZ25SV2c3SFc2?=
 =?utf-8?B?MWJQYVFBUGszTlBzNDJxN3RkT3R0SDV4ODRrY29TRzUvNUx1Y2FGRGE4aENR?=
 =?utf-8?B?cG1kQjVScWpRcVdqY0hnaVdvSWoxcEhRcm5rNnZLd0x3Y2Q4UHYveHNGRldX?=
 =?utf-8?B?Mm8raUd6NnhMdUZ4Q29UaVdVNHh2NDllRVdIZVlocUdTQkljaW91KzhlVlBj?=
 =?utf-8?B?cjhXTlQwTHVYQXJML09XRGlod2pNd2czVEFZaHdBMDF4NjJraUdCMzBBS1lv?=
 =?utf-8?B?cUtFVFRvUE5KelVuUFVYVnY4VWZhTW5ySnZmSGRsc1Rzb0R2SnRjL09pZGVK?=
 =?utf-8?B?VUdEcXl4TFpST2tuV2N3WVJZWHFlYkpONnAvRnR5ekIxQ25rMGRmZmoyS0FG?=
 =?utf-8?B?aE9iaTZrNys2a3l1SjhhV3BnaG5tZXByeS9MNklzQWI4Zkpvdm5icXdmMDBr?=
 =?utf-8?B?aFFuR2RYbmZnZEhubE9CZnVaWjk4YmI2L2d5MEZRVXNSeFRlM3pVY0Vpdzhu?=
 =?utf-8?B?RFcxdXBmOFdWbDYxTDJUSVp4QkNETTI1VTFTN2k0eXZURVVoaytuZlZNRkNi?=
 =?utf-8?B?NUo5bDNaZVhnWENEcWpCc3NZOHdreDVmcjVYVEtScU5OTDl2OUxDeEpQbDhN?=
 =?utf-8?B?V2hkQUJPbTIrY3g1SVlRQnF2dlF2eGFtZGlaNmxEb1hsaExWa3lNam1ZS2hO?=
 =?utf-8?B?bFpNSWlUNG93Y0xIbWNFYjJxbGZGMHEwYXhJb2NIWEd1SVFZbzVJT1FuS0dO?=
 =?utf-8?B?ZTRUV1pyZDhjeUMzWUZzZGl2MFJhWG43NWprWVRLcGRRZXNaajZRQ1hGaUtZ?=
 =?utf-8?B?U09qbWwrWTVrdkVkSW80d3h3TlpncE80dkphQTZVK01JYWtlTG94bU81YzV6?=
 =?utf-8?B?Z3BDTEpyTWdRWng5Z21YMCtUZ3poT0pTRzlSMjYvVGFXWVB6Y3ZFT3B2cC9O?=
 =?utf-8?B?NDFTMHdtang4SGRNWVhaMWlOTTBIUzZTcG54SlNTRlNoYkJ0US84aExBbnlY?=
 =?utf-8?B?eTV0emlZbDNrTUIvVjQyZEtCckRPeE5WNTJ6OXB0SnYvTGMvUXZET3AyUlRP?=
 =?utf-8?B?Tk4vOURhS211MXJkemRGZGdrTDV0ekM0d2d6bUtQOGpzZFBGWFV5Y1I3RzNk?=
 =?utf-8?B?S3JlaEVyZnlJZWc0Y0FyeTN0a1doTE84T0gvalAzWXArbHo0OVphRmJjTitr?=
 =?utf-8?B?UXRZanl3S3BwcVZveUVWajlveVp4cFpZeFpqdVlvS3pPOGlTZldxbGE0SXdE?=
 =?utf-8?B?RFlnZFBjVkxNMUphSitFaDFEQ21EUmxZeTdOTmtJbUFSTVpLZkJJTitUZDRH?=
 =?utf-8?B?VytqbHRtL05zaVVXUjdUYnVkWFE0bkVnRHYxczBvR1hyR2NTYnNXbTZjaFMz?=
 =?utf-8?B?RjBpdHliMkxJUWZnS2xlYUMwREFPZVBpcEltSTJvbzRpSkdRVzc1MmhSekJz?=
 =?utf-8?B?Z1JuMS9jQm5sTi9rbXNhWlJKb2J1a2ViWVhZL1pxTVVSZ2FRMUVPbkR0b1JC?=
 =?utf-8?B?aUlFSGdsdTY2alNEUG1RNS9qZElhRVA0dmt5bXc1YzVGMENycnU5TkQranA5?=
 =?utf-8?B?RVJZMXFnR2RsRjU1U2hCQkkwS0pyLzhJT3prOWdTdEdpdm5XNURIbWJFc1c5?=
 =?utf-8?B?V2pnYTZiT081OS9neEtkaTJiR3FDNFFVYUR5RXdsWG9DaFUzaG1adWhGNXp6?=
 =?utf-8?B?cnhOTlFZaVk3V0JhYldITCthRjZzMGd4cjduaXdnUy9heUFSZ2FWSE5sYW9T?=
 =?utf-8?B?dkdzUVBUTHFWOGVhMVRxUW02V2UzYjcyRlF5aHgydHd5anFTdGR5bWJENW9j?=
 =?utf-8?B?Z2g4cjdtNXpzZHN5TzBEZ3lhbVJFUXJkQmlrTUtVZE5SM0NYM1ZCckNDY2F0?=
 =?utf-8?B?dG1DNW1PNmNybGlUN1JCRGIyRHd6SXVhVk1WUEZlNlpSYlpIK3RQdlRxQm4z?=
 =?utf-8?B?NVJFZmFaRlZBRU95WThSMXd2NTBuSVJObHlxWnZaTThQZVo4VmQyV3k1MHdl?=
 =?utf-8?B?V1RVNlFUekpON0Y0T25mN0RSSVJodEtZbE41NERNcjQ0R0U5blpZZzFkNXI3?=
 =?utf-8?B?TGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e15b8395-0c13-4525-c1df-08ddc2c21ef8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 10:35:15.6987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pHVM0CKuutvNoiZaKChh4iMrwt24ce5s5KpT6DzdciJNqpGKghApUd8IjBowlKS63EEjvrvHDSnvN0rJuyYf/LX/0SbdRxARRJ8gADCOg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10980
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

Hi Tom,

On 7/2/25 3:05 AM, Tom Rini wrote:
> For 32/64bit correctness, we need to use ulong and not u32 for casting
> for addresses.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Sean Anderson <seanga2@gmail.com>
> ---
>   drivers/clk/clk-cdce9xx.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/clk-cdce9xx.c b/drivers/clk/clk-cdce9xx.c
> index e5f74e714d54..afb997c06be5 100644
> --- a/drivers/clk/clk-cdce9xx.c
> +++ b/drivers/clk/clk-cdce9xx.c
> @@ -103,7 +103,7 @@ static int cdce9xx_clk_probe(struct udevice *dev)
>   	u32 val;
>   	struct clk clk;
>   
> -	val = (u32)dev_read_addr_ptr(dev);
> +	val = (ulong)dev_read_addr_ptr(dev);

The output would be stored in a u32 anyway so not sure this actually 
helps (see type of val in the git context above).

>   
>   	ret = i2c_get_chip(dev->parent, val, 1, &data->i2c);
>   	if (ret) {
> @@ -226,10 +226,10 @@ static ulong cdce9xx_clk_set_rate(struct clk *clk, ulong rate)
>   }
>   
>   static const struct udevice_id cdce9xx_clk_of_match[] = {
> -	{ .compatible = "ti,cdce913", .data = (u32)&cdce913_chip_info },
> -	{ .compatible = "ti,cdce925", .data = (u32)&cdce925_chip_info },
> -	{ .compatible = "ti,cdce937", .data = (u32)&cdce937_chip_info },
> -	{ .compatible = "ti,cdce949", .data = (u32)&cdce949_chip_info },
> +	{ .compatible = "ti,cdce913", .data = (ulong)&cdce913_chip_info },
> +	{ .compatible = "ti,cdce925", .data = (ulong)&cdce925_chip_info },
> +	{ .compatible = "ti,cdce937", .data = (ulong)&cdce937_chip_info },
> +	{ .compatible = "ti,cdce949", .data = (ulong)&cdce949_chip_info },

Just get rid of the cast I guess? udevice_id.data being a ulong already 
the compiler should perform the cast in any case and this improves 
readability?

Cheers,
Quentin
