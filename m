Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD5DCA0EE9
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 07:13:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E21A809A5;
	Tue, 19 Aug 2025 09:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="RQyPaQU+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAB0080B9B; Tue, 19 Aug 2025 09:13:13 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89BB98006D
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 09:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyT7TwU7dPnG3AaA75qcuabDIcecKavEP4Wy7+XuSOMiOIHohLvB5XdQ4/hYQq5yzA6teBtQgDQxRCNUkvkjMthaVIwMmH12p3N/48XqfWMMJmEhJ0ed+zUAaTL+b2UZQ5yYt9pKG5q3KwO1OItePkHtxuRUPs3QVS7igU9ZO+W7a6V+OE8kosObbuO/qcuZh50h+0pyGxjZJcJJv/nMyecLLSonGpJAiR6WlxsA5Td3P9rF8NXlUvezbFLhVr1fjAF5uvFumZoQeyj11wP2k8n4FHgbtgP0Ob5N+1+qDq2T1qs3cSj5r00UEzgJ5uhxhiOo88lAvXbleMYMTdGPHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSQ0Oflh387uL7+lF766/+7nZtpwtMfBn0TrlKzqxOI=;
 b=TJA+kOKMS9nz/U9j1vby2yWN/PXU1reLXVtqeyvEom7aiWVWuzuleHK3XMVJEv5RWn1B4RFvFlvUh654jHuDtNTBfth9eW8BJG67xGB6yTcOWo31Z1K2WB+bW4En8ehiSJVQzNAjGC0l3IRo2TkkkNDPgretSHImHrLGlp6+yxsu8PXzzTQhJ6AIKRVJLBzatYST34+YxvoRJu9GSwDgDe8M4xRn/h50ScTOcSwdz5Ik55kWUTlDT9g/Er6UeGFx1hONM1YnPur/1YjFDd4DtU4ZP5pBlmMiunMjD1qumn8itpTxTniw0UeRVm+2EDVnie2+J3+4+BJOIKvSAP1l4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSQ0Oflh387uL7+lF766/+7nZtpwtMfBn0TrlKzqxOI=;
 b=RQyPaQU+iO6Z8jFLLqkTn+A+yp6HnUXAuKDUP91SyZFa4l2vxnMPnw1mHj4guHpUz74ZjNpRWRfEFMysrMxEZ53jgMjq/GoeegwKmXCNskhYka0xcqxMgg2EaRxP1z6254irOGiAkEdF2X4we9cMdwMEa8LpUhYL4zSYrcVCjIjAjOSG5NSlPedt47qPSD584/qIEEyoNOiG7lrx769H2j13E0U7Xck0zvhBxFEMLQ8rautmz3loU9ZWk5V1rsFykDJPQ/Jmhmgssmx6UKDXib6bYWunCpzRlDFCCu9INM+Oyv5HQ033u40IhJmzvZ7IFt56YxSKBjGYkXnEma4+qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PA1PR10MB8596.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:453::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 07:13:09 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Tue, 19 Aug 2025
 07:13:09 +0000
Message-ID: <fe19859b-80ac-4942-92ff-be25890225aa@kontron.de>
Date: Tue, 19 Aug 2025 09:13:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/21] mtd: spinand: core: add missing
 MODULE_DEVICE_TABLE()
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Alexander Lobakin <alobakin@pm.me>,
 Miquel Raynal <miquel.raynal@bootlin.com>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-5-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250818100614.432931-5-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::13) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PA1PR10MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: f40213c0-3797-444c-689c-08dddeefda1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnJuZUtNWXR0S3hXZnJRd3UxcFJHdCszdDJVaFlrL09TRHNVanVGd0VCazhN?=
 =?utf-8?B?UE9BeUdoUkFpbG9YMzNzcTh1SjZreC9SYW1lNldCTTBxc3ZzYm0yVlgzTk1M?=
 =?utf-8?B?L2NGNm9yVzI5K3VZdXF2K2tIQ21XekoyMVY0NDZpTjhSVHhRTkFFRlNZZXdN?=
 =?utf-8?B?eXpSUlhnbVRNUGp6MVhCMXFQQlhZTlVBVmRmbGsxbHB4aVUvQzkyQjROS2hn?=
 =?utf-8?B?NmJiYnJveDFpM2lPMTNHZEdXK0pzSFR2R0c4U3hORnlCSDlFTWZhZFJqczd3?=
 =?utf-8?B?NEFueCtwOXhzdXYyKzR4SUJ5SEFtVzY1MHlrVDRQYzFDbVRHUjZ4NnVnZWJ6?=
 =?utf-8?B?S2dET3NEQWo0V05HbWpncW5PSTlvbTYyRkVUaEJYUmhIdzlsdkduVXhRWUZB?=
 =?utf-8?B?TWpzaHNXZDg0SzVmSDd1cFg0OEd2RWJoblpPcEkwUFgrMHJWZFFVdzZxMUhQ?=
 =?utf-8?B?MVZFZ1FrUllvL2RmTGE2dWNnTmxJcTQ4YkxISEtaakwzSnVwS0gxcC94SXpQ?=
 =?utf-8?B?WUxYemtCa2p1MTRYSEdOQlNRaE04RU5CcXdrU0owTVhYcnAyRkcvWmhSR2lo?=
 =?utf-8?B?SHlDSlI3Slh3WVA5VnBTd3NzWlFNL2RpcGpZMEJNdUR2SkZLcTJoL0tpbDJB?=
 =?utf-8?B?bE5CRWY2dHdiUmc0akNkQmNQMjJYSTRMQW15WTl3YlRDb1FPejVXOXhYNHIv?=
 =?utf-8?B?bkRycDU5YllXNU1RdTdsenEza3M2RHo0VUllb01hTHhrb3dMOFB4ZkdlTlp3?=
 =?utf-8?B?K05wS05WbUdsSzFvbW1KZGdNeFZ6SVFOSUI1WWFzK0ZId1ZqRTVybUxiOVJq?=
 =?utf-8?B?VVhFa2N2RmwzQ0IwN3gwOGlKQVZnUDYrNU9EdFNxY2k0ZjdnRzJXK0UrV0k4?=
 =?utf-8?B?QXdLVTlTbDhUcDJFU3NuRWVBb0NNbTFUMlJPejVVOG4xYU10ZFdqTE52TWQ1?=
 =?utf-8?B?RlRlWkxxaERYcVE4eWxDQVNiLzVpZitnSWlWYU0zK05xM0gxbXk5UUhxWEJz?=
 =?utf-8?B?U002U0pLejJrWGFMb2lWZ2lUNUVoVUVTWFVveDFqM3RMZVdsWVVyRjFZUXBk?=
 =?utf-8?B?QXdOalNxLzk5Z3ZNZXpxeENwdDZ3Q1dvQnIzdFZRVmpvY3YwVFlmdkVHNkF5?=
 =?utf-8?B?UHhXNnNpV0lQNXpMMXh2OUpNTnlLNkc1UnlKM1lyMG5kTkFmVmFNODI2bENr?=
 =?utf-8?B?dFlQeDJrNEhTSEplUE9VOEdNbjQwb2ZHUmF4S2RoTzE4K09jZ1doMEUveGpV?=
 =?utf-8?B?RWVZU3IybmVObkVNb2t2Ti9JekJGc3pJRXNQY3BFRmkzSG05dlpzRDc5aHo0?=
 =?utf-8?B?c21ZS2dmbGdHeHEyckNGZ0RMR3hKTjRoaEorMWY2ampLK2Z3bFVEa1JuYzNI?=
 =?utf-8?B?aHp6dGRLQ3hKenliZjlXdUUwRDRibk1ySVdtRkVZVU9VL3pOR2pPS3FZT1A3?=
 =?utf-8?B?NHpmU2xhNDBlSjRwUUZvb0M4SWI1bWJ3Q0NreXpLbUVPV29JR013M1NkWllT?=
 =?utf-8?B?OUhMSnVVcmVEZ2xuYll3RGtiSUQ2eEZwbzhTNnNlOHA4TzFVbFBrVzl4MTJo?=
 =?utf-8?B?V2x4MWljYVJFSlkwdE9IWEI4dnlvT3IyY1RRWnFydDlBRmw3cWI1eXF4SWk2?=
 =?utf-8?B?QkNYY2lmZmxuZ1VkVXFsRW1BdjEvMlNEUFFnOVZUWklRUlVtYnpjQUFhZ21B?=
 =?utf-8?B?VytUV3lXelpjMXFycEIxWmhmK0pjSHBzWGE2UUJiSDFBVzZzdmFQRldjaXN0?=
 =?utf-8?B?Y05rdEdaZmVyb2hrWVAwa2N1L0R1Tlp6R1RyQUdjQ2pwM2RFa21KY1RwTFhu?=
 =?utf-8?B?MHdTWE9ORWRMV1FvSk93bW1MRm4vK3RhNkxBZnN2YUE0d0RGQzV3NWQyTzJY?=
 =?utf-8?B?UjZoUGhXQkJXSEcrZjZzN0tlR1FuVnRPeUd4UjNDcytoY3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGxEdHgvZzdKb05Gc2tMWm51RjNESkNXMzdCTDVpc3Bsd3IrL2s5S3NiZjl2?=
 =?utf-8?B?NytNc3JsbzRJMHByMDhuTGpLaUovbUtrdVNGVHJBUHloVTR5WVZlUUdZS3pT?=
 =?utf-8?B?NEVWVVdCbHJsK3lXeDhLMDZsSGR4MXkwc2hBajUxQjgwQXhRUkZhZ20wZWIy?=
 =?utf-8?B?WFVqZ2hqUjRpY2RhN1VaRWdNcUF4VmRCbWpzOFVHZ2p2UGxVZlJ2Y0Fqd1Vp?=
 =?utf-8?B?M0p1bTRvbmtveUV1NUJjYXBYb1pEM0R0OFI1cTJwTXJuUVZvSHVVbkZyVkJn?=
 =?utf-8?B?M2dCZzc2QU1maE4wUjlCSW5GNlJWamw1NHZ5YjdkL3F4Q2o1NHBIVDlOaGNI?=
 =?utf-8?B?Z3M3T2xXd1ZkakdLMzJoTmFidXJLZjZEWGdhc1RxV2xaRVpaR3JKZ2lHRE9m?=
 =?utf-8?B?R2xIUXVWOVNXMk9wRW0xZTZITXFwd0RQYXBtZkROSktTQURoL3pOc3UybVJ6?=
 =?utf-8?B?MHZEVVQxam1tQndPeGR2UXNHMmlIRkhwUlI3WCtMQldXSzdwakdORmgzUXRZ?=
 =?utf-8?B?dnpLaUd6LzVPMUlyMm84SEVUeGJHNVdGY0JENVBPUC9QdlFBd2VpUVhteFBi?=
 =?utf-8?B?dXhYV0t3T0QxcUkrcktDc0xOaTdzc0ZyTGE3SjVwYjdTVjhTaTkxczYrVDdV?=
 =?utf-8?B?Um1RR0p3T01pMklwMkFjaC9KR0lrUENUazFZWXZJZ3VlRENxWGt0NUdBRkZE?=
 =?utf-8?B?RkMxenBlU1NYMzR6M0Ura1BLMngzMnFTN2FNVnk2a1UxdEZsMVFDTE5oeUFF?=
 =?utf-8?B?d2FkWEhlUGZKeXllVVdMTE50clRJa1ZnSjdpd1hYRVFsNTRCdkR3YjE1SXdN?=
 =?utf-8?B?cWp1NncwT1duVDJJR1E3Nm05YVJXOXZsTlN2bytyNFVrQ3h5MXphQk84emVu?=
 =?utf-8?B?d0dNTlJsYWtNSGllaWFld0d4SmtIaUgvSFZIZzNCZVhxckVDbVR2S0xmbnJz?=
 =?utf-8?B?cU5TZjFSUzliVG5OUklEM1gvNnJNVTBkdko4Nk5MSmtobXBwK2dvVFFjbjIv?=
 =?utf-8?B?V3djVTU2NzUzRGQ2SzNKdndwRy9MamhsTndFbE91VlZWRFV0NnFtYUdFMSts?=
 =?utf-8?B?cUlmMTljMlhFa2p1WkJCTTZsZGRkOGF6WC9EUzl3bWhTbGx3bXozTzJTTWti?=
 =?utf-8?B?Uk4yTllXaThzRVhpVHYxRmdIY3VWVGRMY04xTThtMklsQUlmaFdaQmxtcGN5?=
 =?utf-8?B?VGg5SVh6U0JuQTFyTUZKanZic25RZDE5bUFGSU1QNXBiVXdqME4vaDZoRXNP?=
 =?utf-8?B?VXl0ZVJqVmViVkR2bFVnRjRyb0g3VFBFRi9YdTk2elRRTWNCZ3VIY3lvNjg3?=
 =?utf-8?B?bDFDNXZuNGJJeExTU0NadlpFQm9Fd2RiZldtNzVTS0pkd2J2aHQ2K09uMllN?=
 =?utf-8?B?RVBEaVVzUWh0OE9Kc05kNTBUNWJTTFFzM0F6TFVOYWdIdWVUS1N4cldhcEhr?=
 =?utf-8?B?QkQwcVg0dDhyaTd2Kzk1dEc1N3RISitPbGdyajhwRWNjUHNadFZZMHN4OWRz?=
 =?utf-8?B?VmQxMW5JNThucHltdE9JYnBJcDJZZGZiK1N6Q1pqODVxcmgvSkZWQXNHV285?=
 =?utf-8?B?bnNzcEJQdlg1cnZiSXBUQWorbkNLVFFZbE9tc2k4UjVjR2pJSngxYTFJendh?=
 =?utf-8?B?OFVuejAwazBqNGhBazBsdFpaOUc4ekE0bGlSdFY1TkdDWWVYWlZZd3paV3g5?=
 =?utf-8?B?NnN5OUF5L1Q4TEZubmJoS29LVDc1cnBGNlhqcVQ0Y0Z5MTBEZjdHdWc4ajRI?=
 =?utf-8?B?bndKMjZwRFU0Kzdvak93eG0xZUFYNURrSURYcEFEU3lLT3BzVStPU01iYStj?=
 =?utf-8?B?T09YQWQrRzRrd1ZJOVowdGJyL3JXcDVnZ3dtQWgvbXdGRzMvU2JGTWlXeXVo?=
 =?utf-8?B?K0xKbW53cmJ0Z3RhVmhRdmc3K3pnVzQvRThWVUorOCs2eWJvWHhOL0czb3E0?=
 =?utf-8?B?b0lWZ2RaRnZVTXdtam43bkttaWxlM2lFMzRtUCs4WGtrWGpSR0dtMEwvZURk?=
 =?utf-8?B?UWw1Unh4L0RGWUk0RmwzNzZMa3J0YWhPRHl5NElLQW5DMVhSRGR4YTBLcHhz?=
 =?utf-8?B?S3RPUmpUcUJYcFhUWTZVcTJMVzdVa25ld0M5ZFh0em1XZFZXOFlYV2xZczhU?=
 =?utf-8?B?WlNXZEgrSGNIbHpRYko1K1o1TWpZcjNOYVp4bEQ2dXYzRnF2dnZ4VlIyRjFE?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f40213c0-3797-444c-689c-08dddeefda1c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 07:13:09.5721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNhavKXzlnrtz/X+C2wok+CG37lq3WnWpic/a+NMnCC8C5EoRDDGY+u09dC1Bh0CKFYOi2Ju3L3MTBGSBCOc2bWQCaN0grbyUiRCQc6wgNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8596
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

Am 18.08.25 um 12:05 schrieb Mikhail Kshevetskiy:
> From: Alexander Lobakin <alobakin@pm.me>
> 
> The module misses MODULE_DEVICE_TABLE() for both SPI and OF ID tables
> and thus never autoloads on ID matches.
> Add the missing declarations.
> Present since day-0 of spinand framework introduction.
> 
> This is a port of linux commit
> 25fefc88c71f ("mtd: spinand: core: add missing MODULE_DEVICE_TABLE()")
> 
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Link: https://lore.kernel.org/linux-mtd/20210323173714.317884-1-alobakin@pm.me
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
