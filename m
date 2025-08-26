Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B437CA0FE9
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 19:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0B868311B;
	Tue, 26 Aug 2025 21:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="JYG6tLi5";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="JYG6tLi5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE9868313B; Tue, 26 Aug 2025 21:53:48 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A067B830F6
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 21:53:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=bzZ84Wllz2+fjoLJypTRU42ls3LzI9nBSTSeePVM9dEdFEzfosXT3I1qJ7UugdIMrYy3WHzrC2pbp62sigIOjT0P8P1Kc08/QzXKPtED4yAK/I/sh+UD5jl8Ix81M63ZgkXMxPsjsHV7yh93RaMGhjIGCo7jHUBCdjhCKjq5IkeAC4w/6+3o0K91XNMcLXTHrniAEJ1OPNXmtjBU0RPciIgpiZbT6QIazv4fFRt9hogyzSEGrqwYNt2/qO5iFmVt57oiCTU/DMb4f+LELDZ1ISjGcuQylqmSGCm/SsejVdsck5f6RRTrQ7AWvewbMC0i0250Zh3qH88sRUawJoxj4w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7xDhMmQnefWo+AqDw6XTYNe5DPlykv+v86U+uD8n9U=;
 b=eO4dY315Nuj+8AzW0AgzJ5juj2sX0F2UzqDDyuiHA3wrDzjS0lu8Fk5+zq2qI5Vj8pnGOpch/JwnHuWGEDAtc7lg2l9LPHWeNXvfiFafWZT4go5ELimXJBpxOMhS6G/crThGj7KWjcQ7EG8D30CR8vAEP5pCHnxEED4iV3fe/U8gLaSQlw+vadQrY6W3Re5TfcSEx3/Tkvq2JLhZT9SOcUpvTNYwGaUV/lTgRrxUusn1IidAEBYgtUvCDJVT6Sd7eI5FJk9T6UNCJI3hW/7J01CIp9XuICx0U9a79wPPiNNqLfo0g4KTo4pmMh0+WYKTU/ITqOs+zSRoi/b2q3YsxQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.80) smtp.rcpttodomain=amd.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7xDhMmQnefWo+AqDw6XTYNe5DPlykv+v86U+uD8n9U=;
 b=JYG6tLi5JzZcpVp64r4Cy95nNyMZnEvtU7v1vp6qhIV/LSsD0GTJrCfKZH/p+Q+Mnqv2nuE4SN4g9tlnzLHO+1vblk1SXKbMPw5yVxeEsgDJyX5S0rEw3p+zCxXOvD16hWb7pQRSdDnTSXOQw2d3Z1RIeMf6qUwyuQBRYkxR/zElA2MIxzWnE7EQw1YzXxtTUA/S5oA9UgsKRtRiYxr6bTGct8hl9/ktxKeN41KPYqfxx3DPX3MlmiDxf+rN/X2iEMe0yHjGfUSCb679k9agbmGj5/JEboUf95dsjSzqQQA9MLPKEQke9niqNDJkmO/CqeCMD44sAOIJ03GcE0rAdg==
Received: from DBBPR09CA0036.eurprd09.prod.outlook.com (2603:10a6:10:d4::24)
 by AM9PR03MB7330.eurprd03.prod.outlook.com (2603:10a6:20b:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.14; Tue, 26 Aug
 2025 19:53:45 +0000
Received: from DU2PEPF00028D09.eurprd03.prod.outlook.com
 (2603:10a6:10:d4:cafe::40) by DBBPR09CA0036.outlook.office365.com
 (2603:10a6:10:d4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Tue,
 26 Aug 2025 19:53:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.80)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.80 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.80; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.80) by
 DU2PEPF00028D09.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11
 via Frontend Transport; Tue, 26 Aug 2025 19:53:44 +0000
Received: from outmta (unknown [192.168.82.146])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 8B85D20087DDE; Tue, 26 Aug 2025 19:53:44 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (unknown
 [52.101.70.84])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id DAF80200C4FD3; 
 Tue, 26 Aug 2025 19:53:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WT38GK/e/L+/zajXB20HZ0jlMJDpNXeV52qVSf+l3cr08wECybi9Kn9F8eactXitNIRMWYLMwWqVU/IIPdjtC9xlxfpiWIyAEzKSVyAdQ7w4E738TB3ElOpmFftb75W1600ZPoV59nzrKSHnJFvrwJMn2SIWEmOSHvKkzidVWe9ov7jRq57ejlT4XjLjqZvq/j1ldyGQ3gGv92VroSEhFc5MjV6cHPqdchrnHu8e/o9Voc9s19QPz0O5amKYz2h2lO1fh2nAvLrsGPZokMavrS645WZjk1kTcIdFkX82dglz0Tdbkw6YbJq8zys4F/pVL1GOBq46tFmM/lOCefn1rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7xDhMmQnefWo+AqDw6XTYNe5DPlykv+v86U+uD8n9U=;
 b=ARY/6KmTLKnBz7sFtKc4TQtxbPwzwa4kSN3YWv3CpCYTxVNZzGzS8Z16z9Wd8zOQB355qXllGzAh7rIkxvpDJcIJlJ7HVpfEOhBOpzlQXUf+B8qQvmZDDy3S01lDSITOt05YkHzk3aJJX4bIqCLPDTOd59P2LLAAyUhUCxdZAvpUWN1rIvk0VSqzRAQNYaqtf2PYckyCd+3ef8VJjoucK2p9XXvqwgTnnXWCxH/9WRAoUr6M1+dnmp2RujQv8x4RAhXZ+kV/GOmvwLkcxFZoD3l5wlzXh4/zbDwY6Zzjv9gewyY51UqxaQ9QI1Y9PA88zHh9Vz9wuZa+Exu3ZpytLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7xDhMmQnefWo+AqDw6XTYNe5DPlykv+v86U+uD8n9U=;
 b=JYG6tLi5JzZcpVp64r4Cy95nNyMZnEvtU7v1vp6qhIV/LSsD0GTJrCfKZH/p+Q+Mnqv2nuE4SN4g9tlnzLHO+1vblk1SXKbMPw5yVxeEsgDJyX5S0rEw3p+zCxXOvD16hWb7pQRSdDnTSXOQw2d3Z1RIeMf6qUwyuQBRYkxR/zElA2MIxzWnE7EQw1YzXxtTUA/S5oA9UgsKRtRiYxr6bTGct8hl9/ktxKeN41KPYqfxx3DPX3MlmiDxf+rN/X2iEMe0yHjGfUSCb679k9agbmGj5/JEboUf95dsjSzqQQA9MLPKEQke9niqNDJkmO/CqeCMD44sAOIJ03GcE0rAdg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by FRWPR03MB11005.eurprd03.prod.outlook.com (2603:10a6:d10:174::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 19:53:41 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 19:53:40 +0000
Message-ID: <b84e2f4e-e511-4894-ae16-2ff00be0858d@seco.com>
Date: Tue, 26 Aug 2025 15:53:37 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>
From: Sean Anderson <sean.anderson@seco.com>
Subject: zynqmp: Intended use of ZYNQMP_PSU_INIT_ENABLED
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0029.namprd20.prod.outlook.com
 (2603:10b6:610:58::39) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|FRWPR03MB11005:EE_|DU2PEPF00028D09:EE_|AM9PR03MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: 83b16e2b-7c2b-476e-86ce-08dde4da43db
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?MHIybXlSRWFXWjByalgxUUw3V3UzMDJnODU5VC9uQWNzR3NJU3ljOUg2bXdN?=
 =?utf-8?B?Uk45NGRFalgyRDJSR01UVUxRODdXVDJFUGF4Z1puSFJtVG83L01hRGVzc3Zk?=
 =?utf-8?B?NHlybFpaa1g1RTk2TW5RSENFdlkxQjlrYS9YbU9qZU1vNXZmVG1VdENxWk1x?=
 =?utf-8?B?OUhWVHVDYXpnM2VhUW5XR1ltb2JMZmE5aVVlV1lxV2Q2UDZMYk0zVllNTTM4?=
 =?utf-8?B?L1NuVWdNL2FwWXg3Y0tOWFJoTmN4alFSeGpaU0IrV2srenY3QlUvRncwUUYy?=
 =?utf-8?B?ZWxlZGo2K1ByYmF5WE1oMWd5cVAyNzZyYVBYbEhpOXVjcWE5SHNtL3F4bmdl?=
 =?utf-8?B?MHM5TVNUbmpRbmFjdTVYbXk3YkNhSmx2ZE10ZnFpKzNlUjBPR2g2WnFPTnlp?=
 =?utf-8?B?WXpKMnB2UVM2ZjBsamdQaS8xdkpGSVRmSFFEVmxXNjNubnZPMTBVZlNPNnZm?=
 =?utf-8?B?cENndU5qaHczK1NFazVOa3VjOWUyeDg4bmNPajBmTG5wM1FrTlBmTHVvVFRZ?=
 =?utf-8?B?aVhlQVZFb0VBMDZuSjVyRkZmSjcrOHdoNzhsblVXWUpRQmE0d2lyaHBqSUZV?=
 =?utf-8?B?aVlpMDJpS0s3TGZ2NWVvL1l3bS9keUMzMVo3UmlJeFFoVnV2L0pZN1JxNVlM?=
 =?utf-8?B?QnBwQ0twWGRweUhON2JiQVI3S3U4RFhBeHU0bjlhUEZVMVprVitoL3pGUXdV?=
 =?utf-8?B?ZDFUQm5HWjVhSUNRSmxOcCszR1Y2Ym5Va3pLbWs5amd4Y1NVbHIrajFJeUtl?=
 =?utf-8?B?UW5aUVNvK1kwbGhBQjMxVCtvRVBsWGRZRXZTWTZKQ0pLY3VFL1kyaGdoakZj?=
 =?utf-8?B?S3BBSUN2ZTBsaGQ4TWdycW5tMkhlUENyWkV6SVRaV3EzSHliaE9zdnBYZURz?=
 =?utf-8?B?RWtoTzVBMG9oNklqdy9xTEVoWHorVmtlNTJmV2hBdlJVWU9jVGFkL0tzcStD?=
 =?utf-8?B?b2lmNU5EWkJnRXpUZ3F2UlY2SGNXQW9Za2xEd0d6L25aNnI2VU9pWGl5Rko0?=
 =?utf-8?B?dzBUTklTbE9rUjZmUk5DZTF6YjJ0bUhydjBKZDdUTFNkaGwrcFBoalNXdTBq?=
 =?utf-8?B?YkhqUlZWTVJrQ1V1b0QvQUhCTDlkdktCTzQzN2ZxUmJFVHIzVGJHTHFKRTNK?=
 =?utf-8?B?TGladzQxbmhncEVXV2l2VmpMdE9GRGZ1MG9zL1JkTVBBYXlYZU10ZzQvQmRV?=
 =?utf-8?B?bXRtbUVmUWJJdmxzSTQ4YytIY2FWNDFGWFFibHRhNU5yb1RsK1NUcW53UHpB?=
 =?utf-8?B?eGcyVXEvdGViYXJid0NhdTBLWmYyTkQ4SjBFTWU4MHZzZlhaL3ovRTg3SU50?=
 =?utf-8?B?ZDJnZCs0eU5waW5aS3FoWXluRzdYZmwwWFc3RFJ2b1l6MHh6c1lFWlM3OXVr?=
 =?utf-8?B?TVg0TmIySnlFTzFqekpxM3FiQzM2WFYvQ3BGSTJpelFyZWV1MUFIK3NDRzRJ?=
 =?utf-8?B?R0sxUElTa1BLQmc3b1JJWUhlMThDajVXbFpBVlhSM01XUHIyQnUydEJvNDV3?=
 =?utf-8?B?UDl1NFNEY2xQZENSaTlMNG1lMitxR3NEVnR1ejg2dGJiN2VOem8xdFJqeUxr?=
 =?utf-8?B?WEI3NjlLWWF5MU5aSzZLZWc4eXFicHA1d3hiYUNxRWlEc3FMWjhvNXkvZjBi?=
 =?utf-8?B?dnllZGpwVFBaK2V4YkNtSDJKdndBVGlGcVlwNThGWHlySUNtNEVwdWE5RU01?=
 =?utf-8?B?bEF2RkY4UEhHMVZRTVU1Q0pXbW0rMFp4VmkxR096V1FvNUFxekpRaDJ5WkdV?=
 =?utf-8?B?Y3J5b2ZUdGR2SS9kL3dFOWt1SjYxakZCR3FTRkp3aTlFdG9MeDlIWWFzZ2Nj?=
 =?utf-8?B?THYxa0REa1I1NVZuSzNEUkNqcWtDaUhFVWtFZUFxWnF6Yk5xUGhqRXJva0hk?=
 =?utf-8?B?aC9ORmFJSWhqL0QvL29HSW02dWVnSU9VN3BHRjI2UWVJZlE9PQ==?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR03MB11005
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c5028741-5236-44ad-fff5-08dde4da4137
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|14060799003|1800799024|82310400026|35042699022|36860700013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFBOZXJSLzdmSkpUSW43OWFXZ21nYjYvMWlRcko3U0FmdWwrQnYxS2prK0Y1?=
 =?utf-8?B?TmZvbkhZZjdxaWltRHR5UzhJblVKRWhLTU5DakhINlhJUmwrcUpaa3RaL000?=
 =?utf-8?B?QUtBSUNPMDRZOWd2VXZVTTlYV2F6Zkg4RC9zRWtCWDNkbmhUbGpsNDhZV0tM?=
 =?utf-8?B?MExUU292T0NuYzVkYXl3OGlTQk5tb0VQODVIY2duVUtaa1pjUnllRGV3ZWlN?=
 =?utf-8?B?aEFzbTVRWWloSkR5VXdmYkVYVG00WDl6V0p1d0lPaDl1eEd0QllCWEVZTXVT?=
 =?utf-8?B?dndJZjJ4RGs1cllMZGdwam9yWmp0SGwyL0pQVXdUYzdQMXVmVHpQSFd6dG5P?=
 =?utf-8?B?bi8zU0F5OTdrOEpWQ09WcDFFVFp4bkRocGdXTmM3RVFIQk1GckNUUGFPdExD?=
 =?utf-8?B?alVNZk84MG9YeHcwM0NWSzRhUElZaTVheE9RT1JYS05Oa3MyRGdGdUZxK1FW?=
 =?utf-8?B?a3VMcnd5RVA1RlJ1NXVPRDNrQzNGbjhsdHRPQjNGRmtLYWk0S1prNmtVSjVo?=
 =?utf-8?B?N3dDOVRSUkxaeHdlSnhnVXM3UGc5TjBqUjgxM0EyeDFwRWlSV0Vqbm9NeTB3?=
 =?utf-8?B?NG9NRGQvZ1FoWUI1TTBMQjV0bG1kSXY2YWZVZHNRaFkxK2NBc090b3RVcUpE?=
 =?utf-8?B?R2JRRWYra25qZytqZitzM055WEt6K1QwYXB3T2dKSEJzV3pwUkVkcCtNaGdT?=
 =?utf-8?B?WXJlb3J5NnVhYytaYy9RV2FYbDdSWEFhQXB3L1JEVFQxeXk3bWhhU1A0bkI0?=
 =?utf-8?B?eVRFMUg3dUxvbkFxV216VVlVYmU3Zkh5T1VWeHVUWEpVMXlYb3V1SElqOFh4?=
 =?utf-8?B?MEZLY29YOCszcHNIUC9rN1dYYytUMzF2WWtHa0xSRHluaW1JWmZucHQzQnMx?=
 =?utf-8?B?b293RUE1NitGVC9uM3lEYmJLSi9IdHRYbW01ekVtN09JaDlmQVFXeElrYWl6?=
 =?utf-8?B?L3BVYllJMDFGZ0ZNRVBiY3I3OHp4THpJY1lwYTdkTjRsU1FxNVRhZ0J2V2Y5?=
 =?utf-8?B?azZQM1hLV1o3bFZpM1BlZFZjMlNxNlc4NmJXemlQTzJIOTJ5RVRLd0xQN0t5?=
 =?utf-8?B?T2pFMkpzN0dwbjNDY0kzWVVmeGx5M2hQZkl2LzE2L3NSd3YydU04bmV2NFJP?=
 =?utf-8?B?VGF1TTB5N2tRUHpVK3pqb05BWlo1dVhaYmFEZWV1NHo4eWhuU3Q2NHhVRVlD?=
 =?utf-8?B?M25xUmVKeUxZNllBdUJqbXByMVRwSGNNTGpJQ2p5VlE3dGxPMnk3UnVWL0Q2?=
 =?utf-8?B?ZmU2SW4wQVl3dFFNZWgxZWQrcHphbUFzNTNQVXBOMGhjVUtES3RxUWh2UXZG?=
 =?utf-8?B?N2ZmWXI0T0hWU1VRZUR5SUQxaDhPSWZnQStkVmczdUVZQmZDOVdwcHo1Sndi?=
 =?utf-8?B?dFk3bzVvVDlvZDk0cmw4YzdNUGZWQVBIOTZodmxVa3FzekYzVEVmYkhaRHNJ?=
 =?utf-8?B?VndKVTNVOUFBemkyRVVFaTRSekJObTBLL0ZGQkw4cHBIV3ZKV2VTVU1XaXpK?=
 =?utf-8?B?dGFKZFdGdU50d1ZHaDBHeFNnT3YzRm90TVZYQVZpSWEzSzIrL3RBRUc5MHRi?=
 =?utf-8?B?QU5heGNtS3BpRUhlUEM3aVFqVlJNLzFWbU5tbjh5aFY4cVZLNnQwamNmN2lI?=
 =?utf-8?B?ZWM4Y3ZiMGUwL21DMVVsMXFwVVlsRlIzOFlyUkZGNENRbU90a3huRm9NYTZt?=
 =?utf-8?B?eElRWUkwcGdNRmVZeUcwaUtwbzI5SktEWE9tcnBvWHdEalNIZzBQcWxNY1Bs?=
 =?utf-8?B?aDhGMG1mS2VwbGZyT3VuQm0rTGQ4YWFhTmJmMlFkMDFJU2hjUm11d3RoM2JJ?=
 =?utf-8?B?T2tpbXVtc0VnZkxlQVlGNWQxTVhqMU5VamJHNHRiRWRqM0JJYjJvY2RMRnFq?=
 =?utf-8?B?ME5HUVE5L3daaTE2ZGdGMy8yOTNaRzl2QVpFTlNINUNrMlgvcU0vNUNJZ2pO?=
 =?utf-8?B?QmlDN1pHYmVwZWx3UnlVbmJYUWxIL29JeUgydytQTkNtK2RDUGk5VHF3VXhk?=
 =?utf-8?B?N0VtNFpNZHFBRktNQ25nZzRvU0ZpZGtPSUl2WFY1d2hkYzR6Q2Y1dlhMQUJr?=
 =?utf-8?Q?AkbfI1?=
X-Forefront-Antispam-Report: CIP:20.160.56.80; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(376014)(14060799003)(1800799024)(82310400026)(35042699022)(36860700013);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 19:53:44.8212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b16e2b-7c2b-476e-86ce-08dde4da43db
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.80];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7330
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

Hi Michal,

How is ZYNQMP_PSU_INIT_ENABLED supposed to work? U-Boot runs from DRAM,
and one of the things that psu_init does is initialize DRAM. This tends
not to go very well. So I am wondering how this config is supposed to
work? Note I am not talking about the SPL variant of this option.

I am wondering if we even need this config in the first place.

--Sean
