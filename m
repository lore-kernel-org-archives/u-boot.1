Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A86AC369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 08:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA28683F8C;
	Fri, 11 Apr 2025 10:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XHtGTvKU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9545083F8D; Fri, 11 Apr 2025 10:14:28 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 721E083F85
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 10:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n02HUwNpoeXDcYRazcFS5z0GIg2ps33LWryA/uP0b6rK9XjFU5pbGUFoDo15jRmRF3DqArs5Wq18wRUxrp7r/CSRsNRDAauhH6vFSKreO1gTIQ2ox7oSggBVaj3gDBmfYZO8ExI2VaNMvf/k4fUrW8nvGfBtjMU9bMc+W741vp0kpKZAEC0/NfdCZu+OcAL/VnYPrt4ZrUWnib60bDHN30f77mwK3k3htpZMKBxBuHQG1SiCJwXFw2eCrysaVaiHLMjyXwwjj5H2Vepa6djjKILm5TYsDqqu2exjhvcqRJJo7r9fvpF3gjAg3zEmpl/r3ty4fY+dFmW9SfDHUmYCwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAcpriVO/LEWgmPeDObTycTqJ6XRZdXCFoipL62uk7c=;
 b=bx3kbnyJig1CdEv4kW9l/i/9fx58Vg+w3naNEDD85qZoq/7Pa+3JamJpOI3lEWQeLnmcTK9QZyOXrWGqZaHugjvU2DNk3aCwAAAidExjZaHobj1efthQ6vnJgzFA41ccG6n125Kw7MiR+/C1I298DO+hTgXZ8sO8VOp7vAJjh1AAfONl5glG42NUcECizWdH6ryFnqUaW8K28ByaLtlj0sTBjnFce26EqdO+ddtPTvLMpizMr23Ulw1djdpgW10y+xgr5y2DXzuqPSSJXm0dzrLtdADjff7ZlexJsmXv86jvGsHCHxCH0ib7u1irFsmPP5xnwJLXYr3jPX+iUcUShg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAcpriVO/LEWgmPeDObTycTqJ6XRZdXCFoipL62uk7c=;
 b=XHtGTvKUZeXVP8tWywEMT9fP4saRSDpfrLeb6CWPqwgtDC42TcbbfjhHG1b8rv/0UKfESVPc8FUiIilamjwk7ybWZDtxjA3N6st9woVvW9AalVZ8dMOlz6TSJFKwARCdbW4zLv+EItIRbYnscLVo2O4ra8wLF0s5rXjw3EIIj6aVaEAcey+6H/nxA0/hmuY1QqdLntbjn+QbDREhUaB5VD16sXoTgEeplqgVV8QX1CbR9iQR6pzkZ21n6tf5BvEhR+8+CmbZoqU9UYIB0+e/M6Xu6jpLGnSv8ouEQhxchsVVnWQoWazG/WBOMg7zCh9Wpd8W9VCQ5FG9W4P7Y2JSOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB7967.eurprd04.prod.outlook.com (2603:10a6:102:b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 08:14:24 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 08:14:24 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: marex@denx.de, trini@konsulko.com, festevam@gmail.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, sbabic@denx.de,
 alpernebiyasak@gmail.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, viorel.suman@nxp.com, ye.li@nxp.com,
 ranjani.vaidyanathan@nxp.com, peng.fan@nxp.com, frank.li@nxp.com,
 ji.luo@nxp.com, jindong.yue@nxp.com, Anton.Gres@ifm.com
Subject: [PATCH v9 18/20] doc: imx: add document for i.MX95 Image Container
 Format
Date: Fri, 11 Apr 2025 16:07:01 +0800
Message-ID: <20250411080707.602371-19-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411080707.602371-1-alice.guo@oss.nxp.com>
References: <20250411080707.602371-1-alice.guo@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA4PR04MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fcc3022-f79c-4529-2f61-08dd78d0de9d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0dnWjJyQ2h5U3hFd21tWldPbGVGUnVKaWdHZnBwVGtBVCtiMElSbnZ1UFEr?=
 =?utf-8?B?K0VXckc0a2g0ZjVLbFljZ0NlemFJRHMreUJyV2hRSjlOUUJ2UUErck5xaEZH?=
 =?utf-8?B?UGpQelhkR0docjFTbnY5M3A2NDl2YWtLVjhRNkF3YkdhQU5KdWZzdFlQNUtw?=
 =?utf-8?B?SHlMai95YjNEUnM5RUs3ZGg2SzV4QzZHT3BpaHhJK0ovM1F1cVZDd3hzRDRu?=
 =?utf-8?B?RmtDZVorUGg4M21JYmFweERDbmZ1RSttMjZKalFsbndSNmhXejIwbnZZU05w?=
 =?utf-8?B?N2lURkdQTllQb2hKRjhmaWVZbE9NVDN2Z1NkZHRFbUFZUnpwZWhJbGlzamZV?=
 =?utf-8?B?Yk40OWNWMWxxMzZlbHljcE93QVVqemRWdDJVa05NY2ZhY1E1eldmRTdSUTUv?=
 =?utf-8?B?QlZPRXBwcFhtVEtuVHRUOXptc2p3RFpNVnlQT1QxaEt2ZUtqOG1uTWpjMEhP?=
 =?utf-8?B?WXBZclJ2TDFpYnZqbUowVjRDaHNMTUpXc0huM3BZc3hhT1ZHVjZua2pObkY5?=
 =?utf-8?B?aWZHT1paWHdwbitTbTA5R2ZZTVdpMWpiVWNDcGd1T1pRalBTM0ZaUG5hNUF3?=
 =?utf-8?B?VGcycGthd2pWUDRMbCtOUk9VU3VtTUVyc1dPWUVkcVRHZmg5U0V5VlFXK1ZH?=
 =?utf-8?B?S0hiTTA1QmJhcU94YVg3c1NUbW1xL3hVdVljTnM4SXBQOEFJWjYybnJmc05I?=
 =?utf-8?B?cU5Hek1UU1hRYXRubkZmeVZWTkdnSlU4QkpIMCtrNEVscW9HM3M3Z1M2YnJS?=
 =?utf-8?B?K29taC9YdWRuemFYa2FFUnZJbVUyRkhvTjNnME5MS0JURUxuejh5bG0xbHdk?=
 =?utf-8?B?aFkwTm14eUFyOGRYeDQrUWp0V0JpdnNZSFBkNlNpQmNSRGFPbjQrczlSNllJ?=
 =?utf-8?B?cnZqQnJBVU1iLzNuYmlrSjRyK2tlbVZRblBHaUxkZVQ0L05yekZQWmtCRm1K?=
 =?utf-8?B?Mjl6ZE5NcnhKMEt4aEpYMXJUdE5NZlpmMGlvTW9FWkZnbnZpbzRUeE5BZUJQ?=
 =?utf-8?B?NWRaSTY3dVR3UjM3eTlDRlgxVHV1QXVDVlhjUUFobE1YdXU5T2IvaldsQXV2?=
 =?utf-8?B?YUxPRE9iWGl6d25kbTRPekdrb2VPOUdkTG5vbmNVUDF6cnl3dVJiOGdUK1NE?=
 =?utf-8?B?WUd0N2tsS1B3SHVOMnVsdUFsaEtLSjZNejM0V0FlSHJSNFVFQUdlb3ByRHBj?=
 =?utf-8?B?bFo5eDBFcytFVWVCaUtNSFBTQ1JBZlJrZXlpeXp6d2VwZ0xxYjVSajlvQ2w1?=
 =?utf-8?B?aTJaNVB1UnZUNzhIQTFEN203UW9hT29MMERUYkFIK1d0RTVQbWFMMXhpOHZt?=
 =?utf-8?B?UEJZNlo1VlNvSkNwNHM2SUZBV1dsMm1qK2RSWm9kakVLMFN4Ni9mKzAxU1kx?=
 =?utf-8?B?VVoySFN3NC9wSzc2VFNIcnRNVnJrOWtPRkZURnJSVTVRN3Z6T01haGQ2eTFi?=
 =?utf-8?B?aVh5UEkyV3M0MUh3eHIvNE1mWGMwNllDa3NFbnU1U2xibEtudlhNUk10NENn?=
 =?utf-8?B?aHBZeE5RZzJrWUNyNW5nV1NidUlLUWVDSUxMTUpUMmxFWXZ1SVBZMlh1TnlN?=
 =?utf-8?B?Slp5Z0RMNXZwemU2dUlSN085RnNVNGwwV29XWmV5L29IQnliSW0yKy9KQVlh?=
 =?utf-8?B?dHY2am1qZGVTakhyU1BqaFZYYmlteDg4dmlIcFJKK0xIbk9YVDNtQmNVbHp6?=
 =?utf-8?B?N3NPMWRiMTRuZzBiN2txTjExUGVDczUyU0tra1ZpR1VjRkY0UHd4S3o4QWpk?=
 =?utf-8?B?TmtISUNWT0t6WXpQeVM0MDB3QWxrS3V4dEMvWnhlSytEWThFcEdQM3NNWkJ0?=
 =?utf-8?B?UlVPSVdSUWhXSWFSbXpUS0ljL3piL055Qk5DTlVYMUdJbkhGUU03WEc4REN6?=
 =?utf-8?B?NmFDaEpIVnR5SHRaSzBhdnJXdys5MjhZUHJmVGpqMi9TS3ZJN25sbnltZkli?=
 =?utf-8?B?dFliSzNZQ2xvL2JGNGtKdnV5Q2M3RkI3Y3Q4RW5hYWhtR053dmZOTGpOd0xK?=
 =?utf-8?B?L0tPRjdFMEx3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cldtZ2FHK0lzZHE4RGFjUnlZUzlKeTVZYWNBT3JVaXRpcUwwUVVyU3M0Z21y?=
 =?utf-8?B?bG02TXR3TTB3ZFRnTlhQV0FCUktSWHdhaUxDTFVKSWl1elJOWGtIdUZVMGdw?=
 =?utf-8?B?NEw3T0Z0Y0JKcXhFRVVCUkNHcjVjNXM5QUNxRmV5dEpXVWhwbko2RXBhS2d4?=
 =?utf-8?B?Zzh6bGFwNGJpRVdXdGxBS200UHo0OVpKS00wMjRnZkFETDVmc09kalNLWXQ2?=
 =?utf-8?B?RndnZ0tTTGVQdlFCRHJNTHJjSDFGbXZUTllnM1BQWWlIZkJkUmVtL3dxOWQ4?=
 =?utf-8?B?TTFCVFpWYTlrb202cm9PbXJwMG9vN3duVU5rZ284Q3dibFlFRG5aNE9IZk1L?=
 =?utf-8?B?UksrU0J5VExMNURPalFCZkpVeUhDMDJPeWlPQmY4Qzl0SUI0bUtVQk45Z1Zq?=
 =?utf-8?B?RkNMYm9rZ2RsT3ZNZFFOWHp1OUlwYUZXNUduZDZ2MHJ6M2J2aHdNY2pzeE9W?=
 =?utf-8?B?VG5SY1ZCOC9FRkFLRkt2QzJrNVNTQXo0dS9rWnM0Y3ozVmdPR081TGJrQUNC?=
 =?utf-8?B?b3c4c054c1ViYVpvWmoxUy9pNDdDWEprRVZPTWxMQTRKeG9VbERPMjU1YVRr?=
 =?utf-8?B?Q0U2RUpjSzdEdVhNT21RMVRjSHQ5K0I1VnhiSVdnMEN0TTJ4MFJMQ0dMWitI?=
 =?utf-8?B?YzlNSGZiODRRR2ZJNmVvMEdjMy9CQnF3QzZTdUw4WGR5V3k0Y0sybXNvQ2U5?=
 =?utf-8?B?VnJJYWVzQmpPeTBvS0VhSXZGN0xDZzhqdU53OFpHemtLR21yaU02Z1ZIKzV1?=
 =?utf-8?B?YWRWL01vSmFMam1jckFxVHBtZGVjeU5mK0NXSW5BUDN2WkY5VFpGZzlDM3pC?=
 =?utf-8?B?ZWhDSk5hWWo0cVlFL3JNQ0JEZ3RvSHRoK1ZMRG16a29kY1Znc2tKd2wwRGpj?=
 =?utf-8?B?Uyt2alovTUZZOG0veUNzYWdhZkJocHI2eHBOWFViTDJDRWVXcTYzdDF5Z1dF?=
 =?utf-8?B?bmtVRmFKN2NQek9BUHp3TStDd2xBbGFkSmI4aUdrRms2YmpCa0RoelVFUmhj?=
 =?utf-8?B?UXNJNGxJbk5jTzIxL0hMcThNOTdqV21FbUlWOW0ycUNsNDJNSTc0VEVBbjQ5?=
 =?utf-8?B?VjFoN1d4M0FETmJmb0VFTk9PZ281eHhoTFBwVDVLUmd6SE1xZ29HTWdEaXo0?=
 =?utf-8?B?eGlZcXF0ZEtGSXFSdkZicVdRYmFxSXpodHpkblJBcERQb2syZmxyS3F2c2tD?=
 =?utf-8?B?VWhGUUx3R1ZPZHdXZW1UNFBRYzR0K2pHWm5WTUZTVmRydGhkMndlWFd5WW1p?=
 =?utf-8?B?OUdsSXhCcEZKUU43eWFDak5id0tEakNhSEhib1g1KzFBdm9idG1URzd0RzY5?=
 =?utf-8?B?bjRSbXZFNmtUalk4QjBhV0h6SXBOUlR1MXIvL1g3ZkxtV0FFQVZ0K284WVNp?=
 =?utf-8?B?NTJYaFBXK25Oc3dRRXdjWDM3YWdTdkJoVG1uZ3ZEV0ZCa0NSQmlKTmxwZDZs?=
 =?utf-8?B?WnU5UmlGei9uVkxHVTQydXhjZGNyNjZ3bHpuZWxyY1ZKdXpwS1NvbkYzTHQ3?=
 =?utf-8?B?Sytxd3ZZTFJMSkl0WkVheS83eTl6NG5aWXhkcjZHZXZqK0JuL04yZFl1RFdn?=
 =?utf-8?B?NkZla2FtZzBFTkhJUzFRT2puL0Y3enpqczlQeDg2ZVlVNTZudk9FVjV1NUhj?=
 =?utf-8?B?dHRyMVBYZjdkZzBITUk3ckoya21EQ0o1K09zRXkwZlFRRGhnU2dQYlV3Uy9k?=
 =?utf-8?B?WFJybEx4WVB3WVhqK21uSDBNQ2c2U2RralN6UzBhNHZubCszalFaVVRyZ3Q5?=
 =?utf-8?B?aWJ1RzJNdS8zQmlPckVDcUpsRUpaalZnK0Y5b0QxMXRTSXQ1UGJmakl6ZjN4?=
 =?utf-8?B?NHBBWFZ1SmIzRURCN1VYOTBkd0VHb2ZpOGdvWDVMM1pzQjBrQktlNTRQcE13?=
 =?utf-8?B?SGZteEZQZ1QwN2xmWGdoYkxFNElPMlRxS0t5a2k0RG1heXNIOE9zbEx4V0JS?=
 =?utf-8?B?UVVZWTFvZVlDTmNBUUxUbUIwSEJVcWZSRC9xMWRJZ1FXaUIxd3NsamxkNm90?=
 =?utf-8?B?ZzZRTnhBeTRnMVl4STg3Nmk1RW5kS2syZTJXOHFuNUcra3VCR0dudDdFMksz?=
 =?utf-8?B?a2VVeHhKKzRyOVVveHN4Z1VmeEpaWGYzcGt6eWVTYzBwcXg2N1pqZTdPQ0s0?=
 =?utf-8?Q?QrnSJl44Ypf5oW2TeFx+ivsNW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fcc3022-f79c-4529-2f61-08dd78d0de9d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:14:24.2698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIIH4MC25px5+G8njw1tt+UuSizHljfYzfH64LEeZJcna0Cmj4ibm73Ggsd+Rha9l3VkGayRrPSf2s9HVmJ00A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7967
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

From: Alice Guo <alice.guo@nxp.com>

This patch add a document for i.MX95 Image Container Format.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 doc/imx/imx95_container.txt | 136 ++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100644 doc/imx/imx95_container.txt

diff --git a/doc/imx/imx95_container.txt b/doc/imx/imx95_container.txt
new file mode 100644
index 00000000000..05f223d962a
--- /dev/null
+++ b/doc/imx/imx95_container.txt
@@ -0,0 +1,136 @@
+i.MX95 Image Container Format
+-----------------------------
+
+The image container set consists of some image containers, and image container
+contains boot images. Each image container has its own container header which is
+defined in Figure 1. All container headers are placed together in a continuous
+8KB space at the beginning of the image container set - image container set header.
+
+ROM code addresses image containers in image container set one by one based on
+their headers’ order in image container set header.
+
+If ELE container exists, its container header must be the 1st one in the image
+container set header.
+
+If V2X container exists, its container header must be the 2nd one in the image
+container set header. V2X must be combined with ELE container.
+
+The information of boot images are recorded in image container header. System
+ROM code needs to retrieve the information from the image container header, like
+the offset on boot source, the target address in RAM, the length of boot image.
+The order of ROM code handling these boot images is based on the order of each
+boot image information present in image container header.
+
+Figure 1:
+------------------- +--------------+--------------+--------------+--------------+
+          ^         |Tag           |Length        |Length        |Version       |
+          |         +--------------+--------------+--------------+--------------+
+          |         |                           Flags                           |
+          |         +--------------+--------------+--------------+--------------+
+          |         |# of Images   |Fuse version  |SW version                   |
+Image     |         +--------------+--------------+--------------+--------------+
+Container |         |Reserved                     |Signature Block Offset       |
+Header    | ------- +--------------+--------------+--------------+--------------+
+          |       ^ |Image0: Offset, Size, LoadAddr, EntryPoint, Flags, Hash, IV|
+          |       | +--------------+--------------+--------------+--------------+
+          | Image | |Image1: Offset, Size, LoadAddr, EntryPoint, Flags, Hash, IV|
+          | Array | +--------------+--------------+--------------+--------------+
+          |       | |                            ...                            |
+          |       | +--------------+--------------+--------------+--------------+
+          v       v |ImageN: Offset, Size, LoadAddr, EntryPoint, Flags, Hash, IV|
+------------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+        ----------- +--------------+--------------+--------------+--------------+ <-- SignOffset
+                  ^ |Tag           |Length        |Length        |Version       |
+                  | +--------------+--------------+--------------+--------------+
+                  | |SRK table offset             |Certificate Offset           |
+                  | +--------------+--------------+--------------+--------------+
+                  | |Blob Offset                  |Signature Offset             |
+                  | +--------------+--------------+--------------+--------------+
+        Signature | |                         SRK Table                         |
+        Block     | +--------------+--------------+--------------+--------------+
+                  | |                         Signature                         |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                   Certificate (optional)                  |
+                  | +--------------+--------------+--------------+--------------+
+                  v |                      Blob (optional)                      |
+        ----------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+ <-- Image0Offset
+                    |                           Image0                          |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+ <-- ImageNOffset
+                    |                           ImageN                          |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+
+i.MX95 Low Power Boot Image Sets Layout
+---------------------------------------
+
+    Image container sets are handled by M33 ROM.
+
+    --------------- +--------------+--------------+--------------+--------------+
+                  ^ |                    1st Container Header                   |
+                  | +--------------+--------------+--------------+--------------+
+    ELE +         | |                 Padding for 1KB alignment                 |
+    OEM           | +--------------+--------------+--------------+--------------+
+    Container     | |                    2nd Container Header                   |
+    Set           | +--------------+--------------+--------------+--------------+
+    Header        | |                 Padding for 1KB alignment                 |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                    3rd Container Header                   |
+                  | +--------------+--------------+--------------+--------------+
+                  v |                 Padding for 1KB alignment                 |
+    --------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                 mx95a0-ahab-container.img                 |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+------------------- +--------------+--------------+--------------+--------------+
+                  ^ |                      oei-m33-ddr.bin                      |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                      ddrfw-header.bin                     |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                  lpddr5_imem_v202311.bin                  |
+                  | +--------------+--------------+--------------+--------------+
+m33-oei-ddrfw.bin | |                  lpddr5_dmem_v202311.bin                  |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                     ddrfw-qb-header.bin                   |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                 lpddr5_imem_qb_v202311.bin                |
+                  | +--------------+--------------+--------------+--------------+
+                  v |                 lpddr5_dmem_qb_v202311.bin                |
+------------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                      oei-m33-tcm.bin                      |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                       m33_image.bin                       |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                      u-boot-spl.bin                       |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+
+    --------------- +--------------+--------------+--------------+--------------+
+    u-boot-atf    ^ |                    1st Container Header                   |
+    Container     | +--------------+--------------+--------------+--------------+
+    Header        v |                 Padding for 1KB alignment                 |
+    --------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                          bl31.bin                         |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                         u-boot.bin                        |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
-- 
2.43.0

