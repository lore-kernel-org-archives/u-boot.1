Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C494CC8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 12:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA9CA803DF;
	Fri,  4 Jul 2025 14:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cern.ch header.i=@cern.ch header.b="WfsY777i";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="WfsY777i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42DB182A8D; Fri,  4 Jul 2025 14:38:37 +0200 (CEST)
Received: from ZRAP278CU002.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c213::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C8C1800D7
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 14:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pieter.van.trappen@cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXHXO+8vU0FyWf6GKkm2XpZBUKG/DgvLL61JLyAJW+nnNJg1XJNxDVYc3FHUsEAsYfrKiQ/FsYSwIg6psYeNTJDSB5ekWs+ggbSXYjuukpCSqXySFh3ETE6VG56frX90li6zqaCdIep4YN0fGEVsrPRze+SgHNCZYGThsdPagfOXRvMcO0khBdnwMeXc4pJ6sykE8xGTozPXf6oCRzPvK/d54Jj0bGkLxShyqReEA8bxYfOss2U4LUGzvB/IGqbua8qRdXTB3PyfxNztzXGIR1hcSnacXtM5GGPWtjv5skLptkSpjGTRKnknGLUgbV9VML/JNrGQyeOYZAlUwzKDCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pq5eDbLCXFk9yhnpSFMHhqGEhcM4Q/zPKL220wPlH0M=;
 b=pUiw2dmcQw3NXiVe7yzIqltHL8n54kVXfGge5FkTdzdehVevgTpnRBzjV/wDXlsVZRAHUK7NpkQ9XLvdnVuGFvO85/JHY9Br6mA677p6obOW4D8VZPJIavDuG8FOe3rO8sPPENo5uxkHi4gpxo4fGtIGlfBeptZwCzz11SK2muZwsphr4k3HygE1K1GD3AmstMNENfLaGETVYmysDQOa4TKFTdg7TIcW24Gp7vbEHXTCYYBdpNb8cdeuyzLVIEH7lSAcWA39Z8k9XkWD/qPBIQEL+fMLsDnjwU5Zk5YIkqHbrqVYelTXbot0bzT0DZ+tAReGR7EsFrCaY+WwlaEl3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.107.16.99) smtp.rcpttodomain=amd.com smtp.mailfrom=cern.ch; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=cern.ch; dkim=pass
 (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pq5eDbLCXFk9yhnpSFMHhqGEhcM4Q/zPKL220wPlH0M=;
 b=WfsY777iICOAD2sudtuFOlcjPGcKqOj47sr2w3NGGLVPBo/wGv+FO094A6zsJvtJDufmTQ4JOxIYBokzlU4BQmmzwz6djiuCAhoiNtGXfYLE1ZJnhU2sYnciwXR3AnapFvRlnQWK4o1pUPRVVmSmgaqW6P6LHXIppR89JLk6cA0=
Received: from DU2PR04CA0302.eurprd04.prod.outlook.com (2603:10a6:10:2b5::7)
 by ZR1P278MB1303.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:6d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 4 Jul
 2025 12:38:32 +0000
Received: from DB1PEPF00039234.eurprd03.prod.outlook.com (2603:10a6:10:2b5::4)
 by DU2PR04CA0302.outlook.office365.com (2603:10a6:10:2b5::7) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21
 via Frontend Transport; Fri, 4 Jul 2025 12:38:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.107.16.99)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.107.16.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.107.16.99; helo=mx4.crn.activeguard.cloud; pr=C
Received: from mx4.crn.activeguard.cloud (51.107.16.99) by
 DB1PEPF00039234.mail.protection.outlook.com (10.167.8.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Fri, 4 Jul 2025 12:38:31 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com; dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch
 header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=WfsY777i
Received: from ZR1P278CU001.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp17012053.outbound.protection.outlook.com
 [40.93.85.53])
 by mx4.crn.activeguard.cloud (Postfix) with ESMTPS id C7A427EFF5;
 Fri, 04 Jul 2025 14:38:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pq5eDbLCXFk9yhnpSFMHhqGEhcM4Q/zPKL220wPlH0M=;
 b=WfsY777iICOAD2sudtuFOlcjPGcKqOj47sr2w3NGGLVPBo/wGv+FO094A6zsJvtJDufmTQ4JOxIYBokzlU4BQmmzwz6djiuCAhoiNtGXfYLE1ZJnhU2sYnciwXR3AnapFvRlnQWK4o1pUPRVVmSmgaqW6P6LHXIppR89JLk6cA0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4f::14)
 by ZR5P278MB2084.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 12:38:30 +0000
Received: from ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1a96:59c:94fe:3ae8]) by ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1a96:59c:94fe:3ae8%5]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 12:38:30 +0000
Message-ID: <0a6df085-d0f6-4274-8f47-2ef291aada32@cern.ch>
Date: Fri, 4 Jul 2025 14:38:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] Improve user feedback in case of FPGA bitstream
 load failure
To: Michal Simek <michal.simek@amd.com>
References: <20250626093519.115655-1-vtpieter@gmail.com>
 <20250626093519.115655-2-vtpieter@gmail.com>
 <6e88abac-88fd-4b65-abff-bb36c2e7203c@amd.com>
Content-Language: en-US, fr
From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Cc: vtpieter@gmail.com, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <6e88abac-88fd-4b65-abff-bb36c2e7203c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0123.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::20) To ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:4f::14)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: ZR0P278MB0759:EE_|ZR5P278MB2084:EE_|DB1PEPF00039234:EE_|ZR1P278MB1303:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c8b07b-ce7f-43d6-600b-08ddbaf7af57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|19092799006|376014; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?dUYrRWFVRlVVVWhlaHliUkJQMVdpekhDVU9yUEdObHRGcG1mdHJvZVpUZDJJ?=
 =?utf-8?B?c0pzSTJ3akFiVkc4bUdxdzhJNjJQcjllS0hBc3BxS2F6NnkvNEwvaTJSTFps?=
 =?utf-8?B?MHBBdENJZWZEaWk5T1NWL1FZcEJLSUtuK2k5dlpRRlljUTZlN2QxckM2aEFv?=
 =?utf-8?B?WE1kWUNlTE5pN0NVSXlHUEs3SDE3R093N1JqVFVDcXlDRDFtUWFONEI3Nmp6?=
 =?utf-8?B?aGJzdTNkRXhtMTdSRVBFaGtKbkRDeDdQdnFhWWdZeURKQndKemFBZExaUElB?=
 =?utf-8?B?cU9jZjZWY3p5TVBnS29aNjZobzF4dWFzekM3WVN5V1g3ak8rMG1iZ1RtMWFE?=
 =?utf-8?B?TVZJOFhVSkgwL2R2MkhZaStzZ1R3K1NZMStQVHB4b1pOWG1CMjJkOE54b0F4?=
 =?utf-8?B?ZEpUNnFoZWNpb3hUOTd0Z0pQUFZUQVZhbkpxdXVwd0tReFN0OEs3RGdhSzhX?=
 =?utf-8?B?TUh6RFhYRU02ZENSOVd1dWhYc083SGJyUGYyckc2bGNjcWt4UEk2SVdsemY1?=
 =?utf-8?B?RnlGb0lmcWpLZzkxeTdWUnJ2cFVUZmk0YjFndkZKQmx3Wm5JZTVDVitPNHdv?=
 =?utf-8?B?TWh3RzF5MTVPalZ5R21WWW13STlhaUtjMjR3c2h4VkRheHhMbVErM3QzNDdO?=
 =?utf-8?B?WGpJWm9tSEwrRjNVNHN4c1p3MWZiV0YrY1hsajR6dk1xWElHVW1FS2lPcVE3?=
 =?utf-8?B?RnIzR3I3YkFONGQ3cGZNOHJGcU9Ed2hBbGtFbWdVYlpDbW53NUdUdHd6TjFX?=
 =?utf-8?B?aUptalFQVVZSS25TcmEydzIxbmp4SmRZNzJTbWxnSkZINWJSRHVoc1BtN1I0?=
 =?utf-8?B?UHZOVHFQU24rc3l5Y3A5KzlqT2cvS3dOcjh0WHdzVjVicHRjL0pzeUFqb0Ry?=
 =?utf-8?B?a1g1ZVZzU2VyZWlObGI0d21ObmlhZzV0cG1kQnRXdWJxendHUURhdVVtbFdN?=
 =?utf-8?B?cTcyZVU1cmxsWUdJeTVSZmd2Z21GMFdTRnVTbVJvWDRBNURJYjZXZS8zc2Jz?=
 =?utf-8?B?T1Q2RzB0YlJsMk5kSDVBWGZSUnh3STAwSXJpYzNBZURNUm1reDUxcmNsRnVP?=
 =?utf-8?B?U1BVSVllNys1c21CTGlQWGlDSWxlckdsRFBaL1cyT1p2U3RRckp5V2FpOE93?=
 =?utf-8?B?UFUrOFJ2OFJuS01Db0l2dFk1blFqRDVzU3MyR3FQNGJuNWxhc2ZxaHFLVFFM?=
 =?utf-8?B?QWhrdkZlMHdSUzd6SERWSmtEMklZUVdQQ3FNcmU3N0x5RGNoMGFES3EvdER6?=
 =?utf-8?B?c3ZUYVZ3OWJDam4wOFIwRzloVEpQZ2lxdmV6ZlVGYTJjbVZmRTZqSVIzT0l6?=
 =?utf-8?B?T3QyQWpQSVNTR3pvK2NlcU5Ba2tDdVNrQXFxQTdQaE1HM3FtMnpWaXNQUXEz?=
 =?utf-8?B?Vnd5bzdJblZNTm1QZENJTW1aYzF4UWFtV0Ewd3NPUTMvcUhDVmFFNjE0aWpV?=
 =?utf-8?B?UDFKbzcreEs2RjlWaFZiVHA3bmtiTDlNbW4wbk9VektCREx4OTF2Z2xPa2p1?=
 =?utf-8?B?MmdLMmtBS3J4cUw1bm9mV3pzMVBueFluUnZNTEloM2RQNTBqQVd4aTJSeDdR?=
 =?utf-8?B?UTluMENobWNDYjQ2QUVmT0xKMktsRFZ6MXE4RndKN0dtYW05YjZUNms1cjJR?=
 =?utf-8?B?aElEWVFpUWZHZEJ1RTN5dUN2dktrdGNNUHNNb05LZFlORUVlODNlNms3Mm96?=
 =?utf-8?B?cTAvUml0NkM2SFBaeUFXYVF4Yjl2VWxJc2h4UXNTM2V4aWM3MVRrYk82ejV0?=
 =?utf-8?B?UkJ5YTFmbnltakx2MElabUZ3Q2t5cjk3c09TWHNtTTBVd1lJdmt5REdPbUti?=
 =?utf-8?B?cm9zVk9tekpKQllBbFBVcjQxRlFLOERFOXlKZGRyaW5JRENzbmNuWXl0VXJ4?=
 =?utf-8?B?SWIrcDFEV1d4ME5oTEtiS1JNdVppc2V6MzdSbFI4U0pEeXVzK3c2ZkZ0VHA5?=
 =?utf-8?Q?WpZLhGvAR1k=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(10070799003)(19092799006)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR5P278MB2084
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF00039234.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e1f3fffd-82ab-489d-5617-08ddbaf7ae38
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|1800799024|36860700013|35042699022|82310400026|19092799006|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXRCVElIWldQN1pOazZGeXBrYVdybDNveEEvZXQ5c2IxR0FFdTV3cEJiaTBO?=
 =?utf-8?B?cE15SkxXanlVclR3VWw2ZU9neTJ3eW5uT01nUW1VR1B1aDAzVEFVR2R2MEZ4?=
 =?utf-8?B?ZXpzYUxFbndlRzBxUm00MWZCbTUxVjhZLzNJVzJIaEwyT1g5a2lVOUVucENT?=
 =?utf-8?B?UGUxR2RsZUM5ZFlmOE5FRjFLU1ZlNDczYjdMS05VVmxZS0oxTGlLRkY4STVT?=
 =?utf-8?B?RmFydGJHNGx0cDgyNUx1bmgzUWdpYUpJS1lib25Bd0NMSUxDQTl4c0RmUVZu?=
 =?utf-8?B?VGh2YlVDcVFVTHZPNHhsNVRJbHYrcGZueU13RmlrWkRjL0oyZS9UQmhCTDBz?=
 =?utf-8?B?NXhFREo3bEFSMUlCZS9rQWRrUjB4TzZSZEFmY0pDWTQydnRBTWZIaFJPN3hk?=
 =?utf-8?B?VS91NVptcjdJNEV3ZjdqT1puMjlsVWUrNld1VkxrRC9wNjJQdTg3ZmxYdnVu?=
 =?utf-8?B?MzNRRXg4bVFJc2dmcGRYS1dMeE15MjIxcFFxYWF2KzlXeFpRZjc5RnVzek94?=
 =?utf-8?B?RUtaU2ZzL1ppSHdOSnVZYWNwRmVrR24xNE5nNE1rOXR0YlJDWHRWaE0xQWw0?=
 =?utf-8?B?TXlBUlE4WllITFlBU09aV25QMTVvMDJFTjV0RkxkZWlEdGp6dmVVemZaUWF2?=
 =?utf-8?B?NjA1eUYxUEQ5bFZaSlRZdVMxVitwaGFhT3ZBeDlxVWpEd0pudG5TNGtwVHNC?=
 =?utf-8?B?aC91ejZVcThzdXgzNllRWmIydXN4TkJxc3NFSFJVdWY1Z3NvRGgyayswWXNZ?=
 =?utf-8?B?aFhkcGJkUE9Zd0t3OTd4N3dMalc0Z3NpMjI4b0x1WTVRVzE0dk5tcTZXeVRW?=
 =?utf-8?B?YWdVZWxYOFFJRWhSZ3Q0cTkzbjIzN2dUKy85c09lREJwWkxJUWdVWnZmdUlM?=
 =?utf-8?B?dzVlSGZuUjQ5UTRFSlljYUNGT0tQeTV5R21FcXB1cFhrOWRRaFZRTUdGR2NC?=
 =?utf-8?B?a0VOSFVmaW9CVk9MNWtXV2IrTzRwUXBtZUFlUG9DSWJwQVJIbGk0eWoxVTdJ?=
 =?utf-8?B?N295YklUZE9xU1JhUmNjb2hUamN0YVVwOXRPeG9GOTJISTJUbzEzTDk4elBj?=
 =?utf-8?B?NU8vZFpGY1JCZTdlTTBtSzBWR3pjWnNqSy9xRmtaRG5UVnR3TGVVMGQ2RXNa?=
 =?utf-8?B?cXkvUnZEM29NUXdqWUx0RnlnUmV6UUNmaXA3TWlURDdvVTVaWjZiQ1d4R29G?=
 =?utf-8?B?YW9VZ2k5N2czZnhhNUlVWWlRWWVoU3grbjdjdnZNVS9qaE1nRDZidC9RZFVJ?=
 =?utf-8?B?ZnpiRVdCdElVYTRXOWlRcmtTWWF0dEhBMzBNSEM3bkI2bTd2dlVhc1hLRkRL?=
 =?utf-8?B?bmlSSnFmN3FlaFY4RG5ORUNody91OXJxWDZ6V1YvSTBLSmlvaVBWdVFaRlR5?=
 =?utf-8?B?RlNsZndWMGFzYWN1QXFzNzdiUXdTMlNyNzEyYjdnaC9vU2hMUlNzOFZ4QzJh?=
 =?utf-8?B?dXlncm9TODk2SlpVV3ZWdFBlT2JzeS9sY0ZyVHBJN2U1RS9DMThPam9ZWkxK?=
 =?utf-8?B?eitGNHFteDVkVTFYVm42Nnh0MnAxdm1QN1pESDg5bFdzRUxtckt1SlIrY1dW?=
 =?utf-8?B?UENFZnpwbHNDc3hBWkFiazFpNkdibmc3TUdaSHMrNmp1VEF1S1ozRW0wb2tw?=
 =?utf-8?B?VFlYR0xQMCtac2RvQUl2TkRGMHFVSFFLT3VpdkNoOEFVNk1RQlpUcEJwWjVR?=
 =?utf-8?B?SzZxMmRxMUhTTEVsWWJRcTlSampvQW82dS9ucVArQlhxTmF4djhJSEhZb05w?=
 =?utf-8?B?dmxXL2ZSSVlTZGllKzBtZGNMbDhjRkMwbTl0dWlZNW4rMjFpSDlweHZJVWZZ?=
 =?utf-8?B?M3FITjVpeFkyYkpTTENRdzBMSWNGMCtrMzZRemVFMlA2dEpXS3RGb2prbUpo?=
 =?utf-8?B?ZVNTMTM3dC9xVGx1SFFuUEtUM2ZSOXFlZVMxTUUvdTR6V2EvVENOYW5GVXlu?=
 =?utf-8?B?ZDZPSWl4c3diV3FQQm9hZmRUN0RRZWVOemQraXV5Tk93cy91TzFDSzRjcTNT?=
 =?utf-8?B?NHVkNmpSVWExaG10bnJMa21HSm9raWFwYnIzamFuOTd2Ym1QYVR2dGRhTHNp?=
 =?utf-8?Q?Tmu6+H?=
X-Forefront-Antispam-Report: CIP:51.107.16.99; CTRY:CH; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mx4.crn.activeguard.cloud; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(14060799003)(1800799024)(36860700013)(35042699022)(82310400026)(19092799006)(376014);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 12:38:31.6640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c8b07b-ce7f-43d6-600b-08ddbaf7af57
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19; Ip=[51.107.16.99];
 Helo=[mx4.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00039234.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1303
X-Mailman-Approved-At: Fri, 04 Jul 2025 14:52:36 +0200
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

On 02/07/2025 10:51, Michal Simek wrote:
> On 6/26/25 11:35, vtpieter@gmail.com wrote:
>> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
>>
>> In cmd/fpga.c, change some `debug` calls to `log_err` for important
>> user feedback and use CMD_RET_FAILURE in favor of CMD_RET_USAGE due to
>> its long output which hides the actual, useful return message. Change
>> the remaining `debug` calls to `log_debug`. Remove all 'fpga:' and
>> __func__ strings as `log_*` has this covered.
>>
>> For `do_fpga_loads`, move up the `do_fpga_check_params` call for more
>> consistent command output; use a constant instead of multiple '5' use.
>>
>> In drivers/fpga/zynq*.c, change 'up to' to 'above' which corrects this
>> confusing/wrong statement.
>>
>> Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
>> ---
>>   cmd/fpga.c              | 99 +++++++++++++++++++++--------------------
>>   drivers/fpga/zynqmppl.c |  4 +-
>>   drivers/fpga/zynqpl.c   |  4 +-
>>   3 files changed, 54 insertions(+), 53 deletions(-)
> 
> I would be the best if you can create also cover letter.
> But let me reply to this patch but issue is likely related to others. I 
> am also not in CC on 3/4.

Hi Michal, well there's a cover letter (v3 0/4) but it's only been sent 
to the mailing list cause for the actual patches I use the 
get_maintainer.pl script (only). Probably also the reason why the 3/4 
patch, amending the sandbox_defconfig, didn't reach you. I'll make sure 
all v4 patches are sent to you.

> Anyway CI is failing with
> $ tools/buildman/buildman -o ${UBOOT_TRAVIS_BUILD_DIR} -w -E -W -e -- 
> board ${TEST_PY_BD} ${OVERRIDE}
> Building current source for 1 boards (1 thread, 64 jobs per thread)
>     sandbox:  +   sandbox
> +drivers/fpga/fpga.c:23:13: error: ‘fpga_no_sup’ defined but not used [- 
> Werror=unused-function]
> +   23 | static void fpga_no_sup(char *fn, char *msg)
> +      |             ^~~~~~~~~~~
> +cc1: all warnings being treated as errors
> +make[3]: *** [scripts/Makefile.build:249: drivers/fpga/fpga.o] Error 1
> +make[2]: *** [scripts/Makefile.build:388: drivers/fpga] Error 2
> +make[1]: *** [Makefile:1930: drivers] Error 2
> 
> which should be fixed.

OK I can fix this. Where does this CI job run? Also do you know if there 
a reason why not all -Werror options are on by default in the Makefile 
(KBUILD_CFLAGS) while they are on for the CI?

> Second thing is that all of your subjects are missing prefixes.
> That's why please use fpga: or cmd: fpga: there to see subsystems you 
> are targetting.
 >
> Thakns,
> Michal

Indeed I missed this requirement - I'll make sure to use these for v4.

Thanks, Pieter


