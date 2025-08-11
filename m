Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEDFCA0EC4
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 16:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8710183192;
	Mon, 11 Aug 2025 18:00:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="AIMqI6HU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46BC4831BB; Mon, 11 Aug 2025 18:00:10 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0204B8318E
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 18:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VK3SZaNvjH22bzz/f3q89bn2yfLpEmKxAlnR+zAFOZpXNXX4mZJtydR3JWQVHLFhztNT+QTUarzgC6ycJg5jRQtx0geY/YQH0aESOrvxQrqdeZlxRxDfQd/yj/gmSN69lfSgKp6oMjF0WOVYp1hhBOrmxCr9H3AmEETXhzFDsv/M3bXfg6O/j+u2mymPsvbzwNxBDH6Mph46crzIw+WXqKRxCOa74f89SnfhJdNwhC04h4N4MGnarKSfYhpFDK/ylDF0C1hucrC7YJJDebAwcMoijsurH04hDV+Q7BgX4PyVsV5+mePw+j/6reXTI9nnwh8iVmbvS7IgDtkw3biP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrb1HWkR0bF8kwKCYi39KGzxqhMcdAkgZzl8WVJ6EUk=;
 b=fUu0pfc0oUh/R/cp/X45RR2oQYq5GfILYdPwadbdLlXiVRTv4zOtOabOhhozF7ELAhnN/piAZgW42CcGky2GBz0w2M16/gte2nkAR0FX8mpLYDsLmr3T2MKYB9fDe6A18WGMZ6s94bRjAFZ/MsIqKVBDGhvvHU9I3wNQrdI+YzsPvmmRSL2AlZbxN4qxV8hVhGISdkdPjhd4fmCViKh2qS8DfudfF/R2DrIE2Z4RUl7Fay2PWsUe07nRMAaHZqTEK+tWEbXCfJ8jo183/RQsHV5wNn/3MnRUi5eRCt19v4y2I/EIPTjFbBeh/RBKdRN/GnzA/fayjYVG6vxtwQESbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrb1HWkR0bF8kwKCYi39KGzxqhMcdAkgZzl8WVJ6EUk=;
 b=AIMqI6HUNyDxgt7jrwEGlLORuSlAwps1rGuV0u99yH21eiCB18Dl8VdX5rCt1MFCHJsQX2alsKi8KfxAOV0p42GVia6mpl1X5+x/EjB0cargbkNUzn56J/d1w+37yAUO7nDt4SKyluY+duaD5I6H1EipRh+1KER8NjW7ZMwxjuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB7727.eurprd04.prod.outlook.com (2603:10a6:102:e0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.12; Mon, 11 Aug
 2025 16:00:05 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.011; Mon, 11 Aug 2025
 16:00:05 +0000
Message-ID: <112df3eb-96b0-47bd-8fdf-258e25bfb390@cherry.de>
Date: Mon, 11 Aug 2025 18:00:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: How to avoid the need to run 'env default' command on modified
 env variable
To: Mircea Carausu <mcarausu@gmail.com>, u-boot@lists.denx.de
References: <CAMFYzVwEtRBndhOaog8wStZeBTZvei_gdZ8=6xM2y1=SU5R1cg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAMFYzVwEtRBndhOaog8wStZeBTZvei_gdZ8=6xM2y1=SU5R1cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 89da473a-a3ac-4658-8a44-08ddd8f02370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUJVTlpNdmYrMlpoUzVWeWZaTXh5M0xOcDdqUnlzRjM2RTI0b0tLUE92MS9t?=
 =?utf-8?B?U2g4YS9PNGVUaHdlOHgyeDh6Zm1Ea1hjbXAwY0FOQ2VZMXliY01uQXgrUUxE?=
 =?utf-8?B?dmYwZEVzNkFxQ3lKaU1SMEZNUE5LS21QaUdnSmp1TGd0TjhLZVF5aUllZTI4?=
 =?utf-8?B?dTlDM0hEakppa2IrQkcrRHRUOCswR3NLd2s5RGtyMXIwRDNCTjl2R3d0N3VZ?=
 =?utf-8?B?RFVZK2tsYzFTM2lacTZXeHdacVRnS0JNZ1BjdVlvalcxeWt6TVFKSjR1czhS?=
 =?utf-8?B?RmJFbUFtMVFZTlpvT0NIbDBuQVg5N1NYdEpISU03dk9OWTBpRExkQjUyajZw?=
 =?utf-8?B?N083MzRDalNRTDVPS3hDVm9HVURHU2ZMdmdHemVzamNFUkZaaW00VlNNR3hl?=
 =?utf-8?B?ZWt2ZngyZG9lUUNtbHBvUDNJV2RKZjhqSHdIRUs2Q2RhYTZLRFR3bE0zT1NZ?=
 =?utf-8?B?ZkpOS0VCNU52RlBJTGtOZTMvVkZuTXd4aW5IMHdoQkU2K3lmWUgrVDIxaUpD?=
 =?utf-8?B?SnR3THdBSXNoQjlLK2VFaDdhbjg3d0lNRG80UXNmWmxUSGlId3F2L2tWSEJY?=
 =?utf-8?B?SFEwL0M2Y2xndHZBdDlFZzlIaVArUVd1OUE2aFRiZW1DVWxQZDJLUGZJc2V0?=
 =?utf-8?B?N3RveFBjbHZLenBacSs0b2pBR2lJbEliWVJ0RUJzSUpIQ2xvalM3dDVYa0xP?=
 =?utf-8?B?Z0w4cHF5S1NaYnZBY3puTzh0UG1RZFR0SGkyRXM2NUtlc0tNb0RnZFdhcGp5?=
 =?utf-8?B?OUpISjN5TXVRakpnNTU1Y3p4NldZMnRNNHFWV1RPamF0RzZOTWdXb3pVRW5x?=
 =?utf-8?B?bnpDOFc1WEN4aGtMbTVsVnY4NXVrYnRKWTY4YWRvUGZPcGdxblpUNnNQeUVM?=
 =?utf-8?B?S3dyY2tUaEpQWS9FTnZ0MmxQRUo4YnhwbkdDQ3FRbmIvNDEyWEJ3cmwySnJz?=
 =?utf-8?B?K1lGdW16VXF3MzNHcUV5M1k3VUNjTWhEbTE4bkJJZ1Jmbkx5ZXNsZ2FTOFJC?=
 =?utf-8?B?b2ZGSkJGNm1SVm04SGEzemhFSmZTZGh3ZTlOWDdDVFkvek9PTEhrejFSSjNr?=
 =?utf-8?B?dTROeUhPY2t1ZWhiY1djN0l0QXZjLy80bU9WOFZNa3hza1l3akZoeVhqSitT?=
 =?utf-8?B?VVcrZTNvMGxiUE9aelNjOWVqSER0eCtQZEVmUjF1bVdrNzlHMXh2dUxvcWph?=
 =?utf-8?B?Z08zOHh3S0p2M3NCVXNzVzVQSDY2RUIxSmFDbmo4cWJZblhsTDQ1QXRmL1B2?=
 =?utf-8?B?cFJYajVuWHZVRGNFV2UrTmtaSElpQXhJU0JoWTFEamlVb2xOMkg4WHFNQm0v?=
 =?utf-8?B?eHFsa3Ztb1BNNTBXdlFuajVqQWtVczIvekoybGg1Qmgzc3ZWQ2tHWFJGanJj?=
 =?utf-8?B?c2h0dXNhTy9zNC9vT1FYRE1ET3piai9kdEJOdlYwb2hSTlJkcDUrUElFbStX?=
 =?utf-8?B?eHdITWhMaWJaYndyMEorV0xoN1QxY0tOZkxVYzg5R290dFIwNXV6WTJFR0RU?=
 =?utf-8?B?eDlqU3liVXpKeW90L2k2R3IrT2kzYXNtb0tGWGlkOFBySCsxMDR4VDhVK3pu?=
 =?utf-8?B?Z0tKdW5kYXRwZW4yQ1NSRHdab3FlUk1WR0FPRk5YSlhxKyszZnpwQ2MyZzAr?=
 =?utf-8?B?OU5XVDBwbjZKd0tRTisxN3paTHNmOHozV0lmbWFDWE5Zb1JtSXgwZXJwL29l?=
 =?utf-8?B?RC9QRG9acWZaWFQ2TXl3cDc3THM0Y2haUE9QaHd2QU5pQ01mM20yWEVSMUdK?=
 =?utf-8?B?aWkvWTY1Rk1RWTEwWTJSdHQrT2RjVUIrYi9wSm4zWjhIYTVSYXhzb25WKzc4?=
 =?utf-8?B?eW16ZUdOdmZhbDAyN3AveGh6OE9tNW81eUJLeHFpOWgybDhBQjB3N0lCS1p6?=
 =?utf-8?B?QThjdUl6eTlaU2dTWm1UdStqZENSOW5kSjdySzZpa0d2dE8rRlRVS2E4eDV1?=
 =?utf-8?Q?SOiNBLD9PTo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Njh6Zm4zaEJDOFh2QWNtbi9OMzdJeFlranNNRmgzeUdkdms2cUYwYU4yUmFT?=
 =?utf-8?B?OWpxeHRtUWlORU9HYkwwVzZ3OHRlV2l0TGQxNGxmU09xYmVlSHFyK2RoSTNo?=
 =?utf-8?B?UDhLUmhOSDBNOXNVZU9YWDhuVXUvY3kzUTJuK1VjajRjcGV6RlNvT2JPWU5s?=
 =?utf-8?B?RkliTmtueWlGN1RtYU90eVpiRVZiNEFDbWRDZW1uY2dIazdXV0RDaEpoakNH?=
 =?utf-8?B?YVFMeGlyeExSVS82clh2MElLMU50My9rUGhJYnZqYllyaDNGS2Z0QlNHQXNn?=
 =?utf-8?B?Y05wNEdRS1pIcEpqN29oOWdRakxiYXB1U1NPdU5PaEgveUdoVm04d0xsVVNj?=
 =?utf-8?B?QzI2VlNERkxLa3V1SnorOHZDQUdoaEdjQzFOZFV4eE04cWRtZ0YrblRUcUNx?=
 =?utf-8?B?ZEhsYVpkMlNEZUN0aU9XRURSSGlXRUduUjREN0crMExvNWpBT1hPaVVVbEta?=
 =?utf-8?B?bmdBWHlDb0VOUWp4UFBJS2tObzNxK1F2QlZLODd4QkxleXBnZDh0b1JMLzNp?=
 =?utf-8?B?TXV1OXZHSnUzTy9XSlBoSmt5ZnZ3VldjbkJtZUZSTktLcmVzbU9DWVRvbExJ?=
 =?utf-8?B?Sm45Yjgvd0tBMnFvc280WEJQbDFwQ25jZzhOQTRIanJIcks3dmRwVzlDWlAr?=
 =?utf-8?B?Q09uUkk4bjc5b2RhZkhnaHBFUGFEdGFscVdBNWhaNEkwSk05L281Nnh0VTNG?=
 =?utf-8?B?aWNkOXQ1S29nZTRmKzNWMktFQzE4c1ozMXA2NHVMVXcxOHBEQzE5L1pnZzRU?=
 =?utf-8?B?YWFIdk9ZUWtkTk56cTRCUHJFR2hhZWZVdU9jbHhLWmlQVVlyam5KNUI3MzU5?=
 =?utf-8?B?cWtUSXAxSnpQb2lMOXBMQWRma0xnNEQ2QUpNQVQ3aStpTzEwV0JkcXFEV1pY?=
 =?utf-8?B?VEdPdmpTZ0p2b2dsNlNxS25RU2V4dFkxNWlTN3pyQU5pNFdicUxYc3FGcjNy?=
 =?utf-8?B?MlpPL0RZOTUyWXRZSWt1bFZUbVdlRUxKV0pJWVhxMkx0YUZVOFBNTWlDeERE?=
 =?utf-8?B?WXNGd2tURkc2a3Q3Z2ZOOVBPSmdtcExLZFgxRFYvYTdVSXdoS2x4aXc1bk13?=
 =?utf-8?B?ZmZoZ2E2REk4WWpiOHJVTjdlWWpPM0xObVRLOEtMLzNZZGhWTjdKTGhraUNs?=
 =?utf-8?B?Qi85YWRlVXc4ZUhMOTI5aG5QeTVoU0Z4R3ZLdnp4VEEvdVh4cFpZaFVEM3Vr?=
 =?utf-8?B?V3h0RVpMZWhlSWw5dGM4bGdqMHcxTjhJVXgrYW9BZE5RbWVKS3RGbTE4bmox?=
 =?utf-8?B?M2hraGxMUkQ2R3kxbmQvc3JuUHZqcnVYYWc4eHd5Kzlac1R4Si9SSEQ5eUR2?=
 =?utf-8?B?Q3EvNHJDcDU0QzcvVkZSU3hmb3M3bHI0SHNzM1pSTU1nOWhIWnhNMk02bnlM?=
 =?utf-8?B?SEthZkpTTU13RUIrSm5tWEpLS1VsMXpzZFZwdTRWTk5ydGlOTnd6VVMvU0Zn?=
 =?utf-8?B?ditPbmxlS05JT1U4dnVvVE9iYW1LSEdkZTRLR3lFQTJTL0lDSjN0WmpkRm1k?=
 =?utf-8?B?cEs3WktUUmVhNU9Ja3lyN09NVDdGRmpUbmh2Skw0b050Rk1CcVVtS25jWjJW?=
 =?utf-8?B?RVZRTDVGaHpKdEhjZVduTTFaMS8raE0zelRha0k0RXBrazluUmw3SE9MS20w?=
 =?utf-8?B?YXZKeDhTbnpSd0xKa09HN0Y0NFQ4T2JZQ2NwQzRlNHd0blIvTEcvNjExaEVy?=
 =?utf-8?B?U1ZnOW1SZkgzVHIzTUwxWmJibUlVWHRwdEg2Rmp5clprazRwSVpDaEpVT3Fh?=
 =?utf-8?B?aGdyc1ZrNmlPZnZzaHZPcWhCcCt6cGJ5WFBCa0JtV0paSzJvL3BORHNHdFgv?=
 =?utf-8?B?RzJKa043WEJtbGVya05paCs4bHlhTU9OS29Wc3FRcHFCUEZ3SHFxcGtZS3JD?=
 =?utf-8?B?UXJUNlBSZkZ0U2NncVB5bUlzckFpNFdBZm9CNDRRK0RGMzVESGh6QnJYSnc2?=
 =?utf-8?B?UXdjL0JVR09VN2JpSEJxR043cnhHRjR3dXZ0ay9oM1Q2MXhkKzBHdmk5QzVG?=
 =?utf-8?B?RlhjSUtKZlJaaER2azN4Tjc3YnFVREdmaGpIb2wvbkNMckNhYmxaY3Q3a0d0?=
 =?utf-8?B?SGtsMUo0eWNMZ2NlV1JGa1FsSzhIYjU0S0g1UDdBa2k5M0IrM3huMDRCV2hE?=
 =?utf-8?B?SHJpUXVSTVdncVFONVBaNW1IZnplYy9hZUZjV1FwRUZld3RLTzV2ZE9tNjdC?=
 =?utf-8?B?YnpRNEc5TzJjV2oybFNyNVB2RWphOW4rWVFsT1dKYlVtVDl3bkZxckFNNExI?=
 =?utf-8?B?UmQxZnZoRndUakRUTW9xeUEwQXhnPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 89da473a-a3ac-4658-8a44-08ddd8f02370
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 16:00:05.6072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LlyhjiMol07i/lqfbPDvzTbjN45IwBfg6ry9+IKPcUhQBgjba+cHT7iyp58pC8sQLJ1o1UHru69dzEvhzOiVigj4wmYBeJSypN1lN73doCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7727
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

Hi Mirceam

On 8/11/25 6:30 AM, Mircea Carausu wrote:
> [You don't often get email from mcarausu@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi All,
> apologies in advance if my question is trivial:
> 
> I am changing some critical variables in the read-only / compiled-in
> section of u-boot env variables via CFG_EXTRA_ENV_SETTINGS in
> include/configs/<my_board.h>
> All I want is to have them take effect automatically (i.e. without having
> the need to stop in u-boot console and issue the env default command).
> I see the new values if I use the env default command.
> Since I am applying the new config via a RAUC bundle and some systems are
> using automated testing it is not practical to issue env default on each
> board.
> Is there a way of telling u-boot to load / use the read-only / built-in
> values instead of the ones stored in env storage?

Build U-Boot without external environment support?

E.g. with only ENV_IS_NOWHERE?

You can also entirely and permanently erase the stored environment with 
`env erase` if you have CONFIG_CMD_ERASEENV enabled.

If that's not fitting your use-case can you provide more information please?

Cheers,
Quentin
