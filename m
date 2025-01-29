Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785A3C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 16:55:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B56A080A09;
	Wed, 29 Jan 2025 17:55:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="YdejYeQ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CE8180A37; Wed, 29 Jan 2025 17:55:33 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35F2480843
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 17:55:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wd3FFBiMoQ6pYbmWrjnLoAWvnnoRLsjJOYn/sm2peXA98gttrKqFdyEs1zMgW4W5/dNy/A200d3F1dstOnh89Mhk/bgThm0SwYtLC+frwfqJtqJwzdlMQtOOMHBtC6MA/runo1618MRSLbuwE1pTmHXZfrH/HgfU6hwap9oH6BaOUIFN6VS9mNcxJbr1yHpMjZH/fgTFlLBRkCjbVbYzc68NgNYF0jWeRVcg0AzrD61XqooXYA/CeUOO4QVNyQNB0wvu9a/35+lkAF0P3k2SEkr0Y2lUeWEm56Vm+T+cPAT2kBUYVgVERZOL/RwBJyGk+YPz/6V6lgTIAdUqAGkNOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWl/WHPB7q+pdNR5sUDxIK5kvcnC55u7uKP30++rrlE=;
 b=fsv4Sx03STxT+VeE5PIB1WQbpoT11m9GbGNs6JGuTGZPdDqevEOqdHXXxHctRhYopMv05/Lq46AafsITZ+b4Nf2a8OwrJODfOnDaFwSsdJT4czHqwWLaqCXlVk2J6Hs2THokT00TZ+kS1udc9W73bBh9UsgFc/wXahpSZ9yKLKDRgnnoL/88+zXyKBo5aIyT/V2N5mG5lOVbrIoz8UFzDmydrGFAOdYpLnCrPjsHHQi0Ou6+seUQH8HaPZu2U12idhNPuypAtoh1KYf0yZ+vgKa5nobij+sVqBgxUfQKRcgk7fySVGAcIzpk7bvNDYF+BNhKX8zwvgg64MXa+QKdSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWl/WHPB7q+pdNR5sUDxIK5kvcnC55u7uKP30++rrlE=;
 b=YdejYeQ4cZudxQW1Pr6d+nOxewjEj+9c3GQ2TvcQJLBgcuCmgE4LVG3YwNbtXp2EwvSJZFTfaUJKboxzlA9xaEw2JlkFCN45jNm1kZnC57G8VqjD9BLCOeOzuUYtDwAVtxZ6Jc1AJzdpl0WMjcNZMe1XHjF05+mxSNNqSrv/Erk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB11010.eurprd04.prod.outlook.com (2603:10a6:102:490::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 16:55:29 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 16:55:29 +0000
Message-ID: <2f64df49-3da1-46cb-acfa-c5dd15e530d9@cherry.de>
Date: Wed, 29 Jan 2025 17:55:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] ARM: renesas: Simplify board Makefiles
To: Marek Vasut <marek.vasut@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250118111621.362188-1-marek.vasut+renesas@mailbox.org>
 <20250118111621.362188-2-marek.vasut+renesas@mailbox.org>
 <3bf8432b-619c-4834-8d0c-c91f45a8f167@cherry.de>
 <cb34f827-0c8f-41a4-849f-52c8ba85bd1b@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <cb34f827-0c8f-41a4-849f-52c8ba85bd1b@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0132.eurprd07.prod.outlook.com
 (2603:10a6:802:16::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB11010:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c0c1340-e220-4434-12f6-08dd4085bc30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|10070799003|366016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzlKNThlOFF3a05aZDhrZzBtT3dQek9XazZVUmFuYlAwc2Y3Z2ZoazBoSWwr?=
 =?utf-8?B?SUlIU3hDMEZjS0pqTFZMc2NNVmN4R050aUxuTGt1RE9IM1VNeTlqajdFYlV2?=
 =?utf-8?B?K2crYWo4bm9rMlZLSGZFenhnbTIxekNYVXlHVkpham5rWFRKRk1BNjBRVzY5?=
 =?utf-8?B?VFRESnBnaytuTTZjNUxIdndPUUZlTWtxbEVJN25hdTBuU1hvL0x1Y2o0eFpN?=
 =?utf-8?B?ckpBaGVreGVLL05vOGZMRzhuRTZoUzAwNzRSMXFNR3Y1clVXYjRqU0lJQ3hI?=
 =?utf-8?B?SVdWbURQeWZoSFIvR1Y0aEluWmpENXVvUVU0Q1pTeWRmZGlMWGJmNmxXb1ph?=
 =?utf-8?B?aDVic0RaWktOdG5YVUQ3NUt5S242UEJsajlHNG1NSVYxUytlb3NOMk1ZTjBI?=
 =?utf-8?B?OHdKMmgyQnJvZjI1L3lPR0NOSHUvR1pFME11dTMvbkJjTGdQYjFlZWR4bzJ4?=
 =?utf-8?B?OUVYUE81SlhEaXh4RmRlK25jT0hBRkZwb0dDa0k0VjR6Y25JUTBYMFNtYVVZ?=
 =?utf-8?B?RmIveDF4aFI4a1JFNlJKVWlJTDFDUFV3N1NubHVBb1puc3k0Y1ZTWitEM09w?=
 =?utf-8?B?eGpwWXVmeDhTMDlEK3F3c1ZaNmFPVHRFTjdHTzJmVy9iSlVCbEQyZVkvOFNk?=
 =?utf-8?B?d2VJaVNtYzlTQkU4VThhK1B5T0NiSE1FdHFIZFhTN09YdTNWT1h4aThyNDhq?=
 =?utf-8?B?ZkliYUZqNndxSlZ4N3ZucS9lTUVRSlVIWHFNblpEckY2ay9PKzFVNTY4aUdu?=
 =?utf-8?B?ZGxQZjlzb3BKVUxCZm82VEhSNytpd1lDMHZlWkh6Z09XVUhlV0x4ODVmQ2U4?=
 =?utf-8?B?Ui95ZXAxbFNHcWp5dm1HdER3VHRVRi82dlRoMUJkTmg4Qi9xTDl2NVlLUTFp?=
 =?utf-8?B?SS9WSTl1a21VSTQzQm1IQnhDR0xNVnh1MHhKTDBZNHJSY1pxaWlybUVqOWEz?=
 =?utf-8?B?TXNZb09uc1EzYmNnajYwT3l4SVFRd1VFUVM1aEhoajFBdWMwQzUrc0JzY2dt?=
 =?utf-8?B?NWpjU052SklyaS81Y3c5MkF5RE9sQzNCdFI2YnliUzNRa002alpqOTVieWlt?=
 =?utf-8?B?d2d0clJHWldoQ1NqNCt5VGV5VnBYbXVEcGNLSVN6K2ZvdDJRQlBXeTNvUk8v?=
 =?utf-8?B?c0xrUlA0NU5tSngrTDE2T24yeUgreE90T29oeEZUczg2b3FHSWY4U0hsRmpR?=
 =?utf-8?B?RWYrSjhzR3hTNk1YSUxmdHA1UjBDWnJ2MmhZSE1kUkRNVndnUGZRL3BPamFv?=
 =?utf-8?B?L2hxcTVhdWJMZ3owVHI2S0ZSVU1CSVNKQU9uczRSRXVvSTNwQWRXbVQ4WDlI?=
 =?utf-8?B?bmRRNVgxcTdUSXZZVXpmT3ZZd1YxeHFKRnRaa1FSOWM3eWNYRjlpci9BMnlQ?=
 =?utf-8?B?VHJtQkZyTFRqbHR6UktJVXlxdVlCelRPcXd6Sis1YVcwcmZuL3dHT3dNaVJE?=
 =?utf-8?B?S1VNNmEwWHJkb2Fqb3lQbm5uRVU5VW94bDIwNDlrWHhlS00yTUluaGhFLzVS?=
 =?utf-8?B?a0k3aE93NnFjeTQyMUlWUHJZczdpRDMyWGxjcFhub3Z5R04xR1hKRmJTWVZE?=
 =?utf-8?B?b3lReFZPVEF1YWticmg0K3p2c2Z2cTBjZGRBU3Z1aUszV1pWSGZMbEpzbFRW?=
 =?utf-8?B?bURPcFlhMU5TUnpydjU2eU4rQkRsc2NFVVc5RHRuWSsyWFJHTlBTSE4vMDFn?=
 =?utf-8?B?WjB4aGFIWmhlbzA0NUJuOVlqa2c3andwWkF0SWI1Q1B0ZmdiVC9HZ3hGTzht?=
 =?utf-8?B?dzgvNzQrWFBQenQvSVZpdXJTVURHVWcrM3BDYUdFdzBBcDc3YjdDMGd6SDls?=
 =?utf-8?B?Wkt6dVlBL3NnVUJhdTZaZHFNc1J4bzkrZGdGWE51ck0xZFdwZGxGUWplM3JG?=
 =?utf-8?Q?SDDq+uuLMp9cW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(10070799003)(366016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmlMUmJVajVJeTRoYUtIVTQxVWNkLzcvUkFYbXFHaWRWbUg0L3ppU1M4MWww?=
 =?utf-8?B?MWpBUThiQTd4K3k0blJxRlFhS01ST1IxTlFTWElmSFpUcmNtdlo3SzFVenVy?=
 =?utf-8?B?VE9pVlFlT2NpK3MyQnA5VGpxMTdrNXpTd1E2dmZhUTIzd2dOaEM5ZzhZV29v?=
 =?utf-8?B?VjE3UFVJa2FxV2ZsWDZkbTV3UDJ0RmhWamxXWURMSjVoeStwcTBGUS95dHg5?=
 =?utf-8?B?VjNPcFNZdXhHbUdIT1pGSEpZNlZRSjRYd0J0NmRGc2Y2RHRHVnV0d0JEeVNW?=
 =?utf-8?B?eE1VRHhUVlNoR0IxYWVJTzBWaEFWc2FFeVVDeU9RTFhPS01PTXlFTjNhczVF?=
 =?utf-8?B?TmdHcllEN1BVeUtpZXFVblpqcWlKa2xCQWRVd2pSNTBVbmJNVTlOUWV1aUpr?=
 =?utf-8?B?VEttQnNJaE9kNi9sZytjSk9GOWpPdDMzMHU3OUo5b2Q2eDV6QnBUQ0VncDIw?=
 =?utf-8?B?Rk42dzNjNEJlREpjZDBueUQ1Q0ltWUdjZEJQOE9XZnVVbUFreVN5ZldFNmFq?=
 =?utf-8?B?SHNTRHZJSVZpcUZ6TzMwVUp5Y0t1UnhzZUp6eUkzaWYrS2JkcEYyZUwrZDRZ?=
 =?utf-8?B?UHdWQ1BpVFAyZ1VWZ0dWdzkxMXhCZ05XbldyS1dZM1NPU3IvcjN0UmZ2VE16?=
 =?utf-8?B?MTI0VnNGMFQ4OXlGZ3MwN3NsWGtuMjZYMkVFMmZFcmFlTWdWbTg2NTFSckIx?=
 =?utf-8?B?alNqa0tUeGJiblZ6R3ZiMnYvS2Nib2V0ZENGa2tURzZySHJuNXM3bmpXOHBK?=
 =?utf-8?B?OUVyYXR2VTZSVlZubnZKZngrTWppdXcrVTRMYTduck5CcW9PVVZ0NUhuakpT?=
 =?utf-8?B?aWxsdFFwcHIyKzRmRXRVMUJwQ20wK0h3T2hkSzZPYUc4TFFqaFk3eC8xRGxE?=
 =?utf-8?B?OGQ5WlBRZlVERUNGNTNtb1BIdnQ1Um9TeldQZGwyd0l1VzhNbTU0RG1oWmk2?=
 =?utf-8?B?WGc4MnQ1Y045eGtYSStQdmtaOWpNdWJkSmlad29FYWFMc2l6eDJYbElrWlpZ?=
 =?utf-8?B?QWo5aVVjYUZoRk11QStWb3M5aUV3ZTYwWGt6UThmN0FENElMUHA5MFg1aUQ0?=
 =?utf-8?B?VFNwSXhEZFVaUEc5MWxIeTNRQVhwNWR5c1Y2aVVjOHQvdXFydkFpWFUzZ0V0?=
 =?utf-8?B?ZmdiV3RmV3VjL1ZPUDVWd2V3TGJRcmh2Y3p6bVNlVWYwekRNNkIxTVF5SHZ6?=
 =?utf-8?B?SEJHUS9zTzlWbVN0ekp6dnR6NFRHK2NKQ0tybHVYbUhOTlpZTkNCSDVjVTNX?=
 =?utf-8?B?dWo2TWIrM3BPOHh6Wk5BV1ZjaUVURmE2bkI3MDBwZ25DTzlhejgwRkthWTRB?=
 =?utf-8?B?L1cyNGJTTGNUaS9ucElQR3BTQmtFTU54WHdENWpDVE9jOTBmQjNYNkg4cEtZ?=
 =?utf-8?B?L3BhUHVMT01CVG1vdncyOXhZNXVEclVjZzBXb1g5bUpBUXV0bkNUcWVUYjBV?=
 =?utf-8?B?bHBVT2RKY3htbWhVcW9jVVluSjRwOEd2eXdGd2VrVFdvQnkvWmp2TmkvYjM5?=
 =?utf-8?B?TWptZnkrTkNJb1EzNU1LNWVmYUdHQVVZRnRVZUJkbmtQS2poU1hrZmpXSmdH?=
 =?utf-8?B?dkNFOXB4UGJhbmtRTjlNRlArS3k3YlVYTG5UTlhkWmFhckREZm1WS1BwSEFY?=
 =?utf-8?B?bHFud0lLN3BkczNyekFEMnJ2UmR1dHd6Z3hYMWJ3N2pUTVY5RmNzby9MZi9V?=
 =?utf-8?B?b01HUFVOOWpnOGRldEdWTElpNmxpY3YvWnJEeE5aWDF4RExoMzRaZmtZbHNP?=
 =?utf-8?B?bHVDcndRSW9WSU1mME03L2p4VkF2L3JWbXY3UTZUNFYrdXZiSFNBR1picU5L?=
 =?utf-8?B?Q0l4NzJZMUxVaXpzSU9naGRJYzRJc2ROY2Q1TWtOaVE4U1FLdUkzS0hxUDg1?=
 =?utf-8?B?OGZ2RDFyakhoVDhtN1NFVWtiT3dBV09qNXArckEzYlczV2RzYk15Q0kwUElI?=
 =?utf-8?B?WGF5c1BURXNDTkZjNStJQlR0QTc4UlFGZ3NzT2ExNHJ5L0ZpYk43d3g1TXlQ?=
 =?utf-8?B?NzdCQ1pGdGc4N1c0dDNCV3M0NVVGZmVScjR6UnJhRTc0b1E1d0tGTXR1VU5C?=
 =?utf-8?B?VGFXVjNITlk1ZnkvL2RVUWg1V1FwVS9ld0w0eE0wV1NQSVN4ZEJ6M1RzYTBC?=
 =?utf-8?B?bklJcEwvU21kRFNRWklaMW9PQXNtbUJXM2RZWnQyWko1Y3llZXI1L0grV25K?=
 =?utf-8?Q?WRqQEBfLD1G3SQ/ha+iRms8=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0c1340-e220-4434-12f6-08dd4085bc30
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 16:55:29.0395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsxLly+agrXxJSjN1jhWSTq42Sysk9uzRd/Ujc/ZZgrtqMwURv+ccgo4VoNBQQvD1tTuokjSQkFLTnneZXd64CkGHvjQMbR0OsO2PGy2x6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11010
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

On 1/29/25 5:42 PM, Marek Vasut wrote:
> On 1/29/25 3:54 PM, Quentin Schulz wrote:
>> Hi Marek,
> 
> Hi,
> 
>> On 1/18/25 12:15 PM, Marek Vasut wrote:
>>> Introduce board/renesas/common/Makefile and remove the multiple
>>> duplicate copies of obj := ../common/*.o from board Makefiles.
>>> Let the build system include the common Makefile using the
>>> HAVE_VENDOR_COMMON_LIB and build the common objects that are
>>> shared by all the boards that way. No functional change intended.
>>>
>>> Some of the remaining board files which include board specific
>>> settings have been updated to use obj-y += to avoid rewriting
>>> the board obj-y target and avoid dropping object files from the
>>> build.
>>>
>>> The board/renesas/common/Makefile is now also used when building
>>> RZG2L targets which also set CONFIG_RCAR_64 symbol and 32bit R-Car
>>> Gen2 targets, however, this common code is specific to 64bit R-Car
>>> only. Inhibit the build of this common code for RZG2L using extra
>>> ifndef CONFIG_RZG2L and do not include any code for R-Car Gen2 so
>>> far.
> 
> [...]
> 
>>> -ifdef CONFIG_XPL_BUILD
>>> -obj-y    := ../common/gen3-spl.o
>>> -else
>>> -obj-y    := ../common/gen4-common.o ../common/common.o
>>> -endif
>>
>> Was this a mistake on Falcon? It used to use the gen3-spl while being 
>> a gen4?
> 
> Falcon is V3U which is something between the two generations, but the 
> SPL is not even being built, so the whole SPL part can be removed.
> 

Indeed, could benefit from a small explanation in the commit log or a 
separate commit to remove this unused piece of code.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
