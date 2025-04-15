Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFE0C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 08:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B98E981E18;
	Tue, 15 Apr 2025 10:58:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=topic.nl header.i=@topic.nl header.b="o3QgcO0B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF11B829A1; Tue, 15 Apr 2025 10:58:39 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20725.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::725])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93D6D81E14
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 10:58:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mike.looijmans@topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLAZbJDFoBrkBiP9agateo0BjyPS/o8ahYAHoZqlDscnADh90K14ZrS0qKQootiC0k0Gy7IOrchHvTPvNMXHPh2WdR5e9wO5Iq9xNgw2BS/ORfYlAyFQIUBsQ7OOfQzZFRUj+aC/BvYSYIGLFHR/mdsSS78B9QZeUCSALDghH79bkEUZwIu0omwpTgw45W0Q2+qf1ez6PPkDzg7MF7ixAVxezoC9fr4MJPlXoavXAVDYuFGR8OHhEf8N+sOUg0/norks3Uj2upbihRuAxNhewmH3Lk5bLsEY8f8viQRSpjnazX65njPK7wcOYgUEgkxUnekTjDvWkj2g83CCl2WZ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgGJRreidWM+cpm/gsB5jwL6KBQTR+BYdlipMeWbtnM=;
 b=RCen94ewT8Up8AZ1AtwbSyYCzlVZhM+XYL1viyFUM8GxYJK0cTewL7seC4epeN14B82yUrzLRWN/fgb4ODlzNyw1AG/oDfxpp6Kvz0+53vAekaRX2izuBOm/nUGsF7yRXX7r/CbJaKhUt9MKLJY/cLqQfcmsgFZr3BgkVNW3M7Qp+S0wEseUxiLZ/6Yh13QHdd0etSoFkpvjw78sBa/sGKWdnDiB1whvPDL4A6aghvWFzhtJFdhmQ3JbiCCKe0GbOWUZ3gg9UOpCvd+hExUQ+ZCqbuORm5SiS6fKdiXUfkjA2LUrheAFd+WOmlE3zLMOuPj52rzFol9uO9/Cl6/M7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=br-automation.com smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgGJRreidWM+cpm/gsB5jwL6KBQTR+BYdlipMeWbtnM=;
 b=o3QgcO0BeZSeoIe1ks7FsmEf4rxis5ncaIx+OuZbQbBSiu0fssumkuVj5UEZ/gtI3wM+WSYO+9RQ8TIwXzp25AuBIAUM6qOWrw1E166XMAxW8bFbFKzFaeuiWmmR1Z4Jo6rsIjodOyB0iwpryVQbFhrPL3yI/ReX0bCE4ogoDHSziMAdHSQxj0w1VNRmhaaZ/Unv8yRxhOKnVHliJJvkZAp/HbHkaCBXRuTng9gcYu38f6r+jUqiQwNCltMWWGC/CGSKmUa1D8/1FORoU92M2e+DKrxXmRpYaKHBxwRrsgo9XdXWMmQ0b4sXwvMnCxnQfR1E8XZzGJPEsdJ1pxv3EQ==
Received: from DB9PR01CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::32) by VI2PR04MB10715.eurprd04.prod.outlook.com
 (2603:10a6:800:277::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Tue, 15 Apr
 2025 08:58:33 +0000
Received: from DB1PEPF000509F2.eurprd02.prod.outlook.com
 (2603:10a6:10:1d8:cafe::a8) by DB9PR01CA0027.outlook.office365.com
 (2603:10a6:10:1d8::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Tue,
 15 Apr 2025 08:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB1PEPF000509F2.mail.protection.outlook.com (10.167.242.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 08:58:32 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (104.47.51.175)
 by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server
 (TLS12) via SMTP; Tue, 15 Apr 2025 08:58:32 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by DB9PR04MB9378.eurprd04.prod.outlook.com (2603:10a6:10:36a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 08:58:30 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 08:58:29 +0000
Message-ID: <d05d6f81-b68f-4e87-a811-811a4fffe278@topic.nl>
Date: Tue, 15 Apr 2025 10:58:27 +0200
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] mtd: spi-nor: Use CONFIG_IS_ENABLED for
 CONFIG_SPI_FLASH_BAR defines
To: Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20250404095612.126753-1-bernhard.messerklinger@br-automation.com>
 <e7103890-b243-408c-8f38-8fc63cb2d08a@topic.nl>
 <DB9PR06MB8559A0DE7DA0234FF87CD9FDD2B22@DB9PR06MB8559.eurprd06.prod.outlook.com>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <DB9PR06MB8559A0DE7DA0234FF87CD9FDD2B22@DB9PR06MB8559.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P251CA0027.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::13) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR04MB8644:EE_|DB9PR04MB9378:EE_|DB1PEPF000509F2:EE_|VI2PR04MB10715:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa21dad-5d98-4188-d564-08dd7bfbb327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?R0NMOEZjMmRDRWkyUlFFbjNWNEk5bjZIaEhuaW5LYnhYY3FJcnlZa1NER1BM?=
 =?utf-8?B?cTBWMnpZd2ZPVXh1dWZTWURnSlhHS0FpbGM5alc2T2xhaTVlVEJ5QnUwNThy?=
 =?utf-8?B?UjZOQTZmcEpJWjJ5QUYxMExYYUI4VnM5TXNzZWExSnNMU3lYenBYZHBkcDhO?=
 =?utf-8?B?MVgzalNQTmY5VUNoME5BMlJ5bjlOZ1dZUE5SWXJ2SmR4dE1PYnc0bjdUOUtK?=
 =?utf-8?B?b21QODc5dHlFNWhHcnBrcnlHUEN4K0FZSW5TZG5TMmlIRnZPMUFGMjk4MXNo?=
 =?utf-8?B?N1EzcFEvSnF4ak5udmFBaWFmVjNGNlBQRjQ2blVjdHltbEhLZExiYlFIN3Bj?=
 =?utf-8?B?UEpTOFRMR2dUSmV6alJuWWplRUxsWVVoRFd0OEVqclZCVVlRVXRBQ2JYWGsw?=
 =?utf-8?B?NjlOQlRPcUJkYkY1emdRRElzZ0NRdms3YTlaaUdEQ0h3VFhuQTdSZ0g4Wmg2?=
 =?utf-8?B?SDdZOEgzR3E4aTdOb3p6MDJqNzJReFk3c3h3dGIxQkhJVFQ4bG5RK1kzeTNu?=
 =?utf-8?B?SU0vMHZjYllUK3Z3UUFiTFdmVEpuQWhFN1ZCcUlDRGE0VzFwMFFhNnlGUENY?=
 =?utf-8?B?aUU3bTZ5a0tyYUw5aDQyc2kzNDZKYjduWXJSbVNoWG84RDBqeXY0THgvMHB4?=
 =?utf-8?B?OXcySGtmQ0VWem4waHhwQlJMOS9SYUNHNWFpUkU4NmNPZXNmMUpaRGw0dHpW?=
 =?utf-8?B?dFZxd2pOYVBIek1lNStESXFSWS9DdWNTWmMyd2JvS1A1cUhWdVp2czZ2NWFy?=
 =?utf-8?B?TndwcEZDL0tzdFo1T3pJcGhlZUtVMzdjTEQ5THQ5c0hFYzROMEVsVUVmYlEv?=
 =?utf-8?B?RkxreXMxUWNtSW1xS2U0MmMvSzhSTy8rY1FQVnJkNzJuNW5vdEJuN3EyQzgz?=
 =?utf-8?B?amkyb2xINkJzYmNXWUJPVnplTVJlSnJhNm10bmJ5RXErTnNjb091QU1vejFw?=
 =?utf-8?B?M3ZCS0hYOVNxSGxmSHcwZWYySkdDOU1VT1pMSERIR0YrU0xMMlhlZU5VeGZZ?=
 =?utf-8?B?VGcyOEs5K3hLdjR1cUNJOGg4dmhQNnBQSmM1bCtmTVVNUGc1dzU4S2RyMU5m?=
 =?utf-8?B?WjN6eWw4QVpoaFUxeXNTc3RxWXN3b3NiM284TEt3UHYzelcxVnM5WEs3UEN1?=
 =?utf-8?B?SW1QaURJTFZDTGN3Yi9SZ3c4K2MvdVFYanpnY1hHckZPTDlpTHVLMHR5cENC?=
 =?utf-8?B?eWZBc3lVZllzWDlYK0pwMm5LOGEzMGVibnU3d1VJaEFlVE1jVDdKLzZubW5p?=
 =?utf-8?B?Ym9GM0RFbnQ4NzN4aGZGdWxVbERNS1ZIVTZwYnZKQ2ZxOWltckJjVSs2UzBp?=
 =?utf-8?B?a1AyTE1wY1krVmZHeEpvT1FKc1FuVThVMlpzbmd4OXpFODlQR2R5Tk5KR3BW?=
 =?utf-8?B?aGo3RklFS2xaU1UvOW9ib3RWL1BDYzI5ZGpQM2RWU1B3ZGtFanJ6ays4OHNz?=
 =?utf-8?B?QVlBQTU4SlZaUDNTWjZVRDdJdEpYRkZlOEw5Ym9PVUpjeWZBaG9CTXI2NGdr?=
 =?utf-8?B?OExVRDg1dDFQT3FNT2hpZWtGcmlTTzVwcFcyNDZRd0lxb0hSUGE5OXNraDE1?=
 =?utf-8?B?YitCbnlDM084SlFNTnp6VlRpeGNoaFRnSFpWZUlvdk5hQlQxSE9qS01VRVVt?=
 =?utf-8?B?Z0M3MmdLMEYzckYvVnVkU2dzQ1JRNzVzSU9ZQ1lMa3lvemNYbWpQOUMrRk9N?=
 =?utf-8?B?alk0WU1Pa2lTZnQrS04vR2FNa3FnQ1RZSmwvRElKSXVkVDdCRGNoQUgyTk00?=
 =?utf-8?B?ZWljU2JuR2dEd1FraWNNVUdMdDlsNjBDUWFXT3JlQUdnUnJtUlg3TGdTTzRy?=
 =?utf-8?B?MVg0UHFqZm53NWphbnIxMmJBTk9senJKSno3MWxXOUhSb0dFa1A3VUxVRnlI?=
 =?utf-8?B?RlNnMFpubUJFanM2enI4S0Yvem03WUlKK0xpMzBBUWxLTXhiVWtDa3FybnV4?=
 =?utf-8?B?TFdaOStUOXpFbXB4dmlnMEp4RU13RmVyTE5NY014cnpMUmlTYUxsb1lFSjF5?=
 =?utf-8?B?aStENlBnOVBRPT0=?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8644.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9378
X-CodeTwo-MessageID: 1a5673cf-9300-45a4-ad18-71ed8b6af026.20250415085832@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F2.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1091c9a3-102a-44b1-e7fe-08dd7bfbb0b8
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|35042699022|14060799003|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlkxQW92MVNVY2tNMk95K1ZKZHZOd3ZQcytKNUNlbXcxenhZNXRRR0NYeHNW?=
 =?utf-8?B?REV2Y0dnL1cwbmh1dFVKTEJoSGJ3QlMxRE1YMTVRVHhhTXdScHA5QU85S3Iy?=
 =?utf-8?B?TFVPVUt0U0lBSE5MM2xsQVNNbnF4aktjTTQ1bkdEaFRRN1V2MHB1YWhzNkNm?=
 =?utf-8?B?aTRZVW95LysyS1RKOHVjWUowVnI1eUEyNlpGSDUrN3ZzY1VyNHM3WEhrU0gw?=
 =?utf-8?B?Rzcva0FHRUhYMGQwcjBydkJ1bDR1Zlc0N01Fa0hyNmgvd3VMTFZEdjdHakVm?=
 =?utf-8?B?VVRLclVnWkJ2K0xNUkhXOG9OeVBxYzhuQm10dHFNSjdKTVkwWkxyVkJwanJH?=
 =?utf-8?B?bWlvalB3M1Ruc1VOUS9IM2diK1l6SmRVNXViOEtjSVo2Z2FzNlZNdXNOUmZX?=
 =?utf-8?B?Sm1wK2pMLzg4TUxzOHRxNFVMU3BlZVNpTlVqdEZTbVJ1SWg5bFEwUXJXUE5s?=
 =?utf-8?B?eEJLY29jcE42cThiZkpqYS8zUDdnREFEOVNiMzRxb3ZRNG15WkpRc3FaSUQx?=
 =?utf-8?B?ZElvR2h0RTF6R0dDZ2hMOURSRlUvWUxHQ3ZNVFlpcWlNYnhZYThpVFVFT0xX?=
 =?utf-8?B?Vld0R24ya0ZMMC9QSnhSTG50bCsvL0pJU25SczNUT3NJL1hjbVJUUVhnUklr?=
 =?utf-8?B?Y3hKVDN5cUZ5ZkVFTXVMaHdVRXg4QUVRUjZLa1c4Sy85NXI5ZDhMM1pPZjg1?=
 =?utf-8?B?L1ZucEVOY2R5dG9Hbnl1UXpwNTc1UDRPTTRyb0lmT3NFdE9YSS91K1F6TWt6?=
 =?utf-8?B?ME5SV2pyaXAxQThGK09NOXlKUU1peFRKRnNBVmRSZkhTZjR5Q0RIN0VPbDlv?=
 =?utf-8?B?RVlGYUJOU2kzSFE1WUxKVXE2eFJ2U0x0YkY2U2FZdFBja3NlNlRhRkNLQ3BC?=
 =?utf-8?B?cDBFTXFRbWJVZ3JoTExVRDd0S1Z1clZRMHhSaEE5clBlbnRHUDV5TU9qMXgz?=
 =?utf-8?B?OE15QVRubGFwbDhtb2pVTXlrQ3Rjbkd6Z3ppQjQ4SEZvditxeUkwbGdyUmtt?=
 =?utf-8?B?RE5jY2tKdE5VMFYwUG81L01QK3VFSlZmc3NzMHU4MjVaWG5nM1FkZ3FoOVlC?=
 =?utf-8?B?WHBhQmtrL2ZNTmZrWllUSXdkdXdSNDM5bjFCUzNCTUxwVG1MeTc2Y3prQXpv?=
 =?utf-8?B?bk94OUJNOGtOeEtETlRSSm1LZDdpOWpWQy9uOTQ3aGtCa0VqZUpacFlrZ0pj?=
 =?utf-8?B?YlhYaU03bHR1NjJGaVlmeXRrZHF5SFFGVFZoOU9lNGxkWGJXb2NsQXBMK29H?=
 =?utf-8?B?aGswNjg1SVFPQVRNbWtMMlJxSDFuQmZBQmZQREZSTmQrUmNFWEcvbktjUzlj?=
 =?utf-8?B?d2hqRjYxblMyaWppMTh2RXJBM0JQMEVGYlF2R3h2ZTFFNXg5VTBUQVprRUVF?=
 =?utf-8?B?RnRsRGEzMnFBaXpXR0s4Y0l1SUtQNTN5UGFuaWpPaWJqZGkvdUJRbnZJL0o1?=
 =?utf-8?B?Z1BzRUZxYVJwUHl6YnZHdlBFbTBSY0FDT1N6UWdWeW4vSHlpZUpLcjZkUDZo?=
 =?utf-8?B?S2JWT3I1MW5jcjMrYjBMem5zanJmSHpLSUZ5Yk5WUUl2a2JiUU45K1RPZnJs?=
 =?utf-8?B?MTFIZVQ1b2JFSnNycmVLaHZnRk9JaEVjMkd6VkxaMWF1aWFpbVVWRDhLYWd4?=
 =?utf-8?B?WVNGSVJSd29GSmRoVWJHS1JVWUt3dFo4akdIa21pZmhLdkE5cEVqdHhzTy9p?=
 =?utf-8?B?K3lPcFVFTS8vbVhiTzhqNGJlcDQ1UDl1UVRENEJxRFFlc1Btd2NOK0NzUFp5?=
 =?utf-8?B?NUZ2N2dPYTAraTZBY0ZKU2RyTFFwWFNXSlMxbkU4Z1d0M1JlUFMydnBHTjd2?=
 =?utf-8?B?RmpsbjhMYXIydFMvZCtYQitkZmFEeFNKQmgvY0RMR2d5bE9IeVVad3ZDS2Rq?=
 =?utf-8?B?S01vQnIwR21Qay9nNjAxN2lTRjMrSmNxRDB0R0JuRFFWcXEvRHhSZFhvS1A4?=
 =?utf-8?B?WFpKdWpiUDVoc3dVbk1COTdOTmVwWFFCRFJXNjFkdWdjblBsaWdvVFJQNHVy?=
 =?utf-8?B?WW1HVXpyNWQ3T0NLaDltb0gvWnVBblNZcGVLZHIra21vY205TzllWGJyK3hU?=
 =?utf-8?Q?mJnIHx?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(35042699022)(14060799003)(36860700013)(82310400026)(7053199007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 08:58:32.8593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa21dad-5d98-4188-d564-08dd7bfbb327
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10715
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

On 15-04-2025 08:12, Bernhard Messerklinger wrote:
>> From:=C2=A0Mike Looijmans <mike.looijmans@topic.nl>
>> On 04-04-2025 11:56, Bernhard Messerklinger wrote:
>>> At the moment a mixture of ifdef(CONFIG_IS_ENABLED) and
>>> CONFIG_IS_ENABLED(SPI_FLASH_BAR) is used in the spi-nor framework.
>>> This leads to misbehaviour in the SPL as there is no Kconfig option
>>> CONFIG_SPL_SPI_FLASH_BAR. This commit standardizes the use of
>>> CONFIG_SPI_FLASH to get SPLs that load U-Boot proper from the
>>> SPI flash to work again.
>>>
>>> Fixes: 9bb02f7 (mtd: spi-nor: Fix the spi_nor_read() when config SPI_ST=
ACKED_PARALLEL is enabled)
>> I was hoping this would fix the issues with this commit, but apparently
>> not quite. If I add this patch, the Zynq boards still won't boot from
>> QSPI with SPL, though now it simply hangs SPL rather than causing a
>> "panic please reset the board".
>>
>> So far, only reverting commit 9bb02f7 results in a booting system.
>>
>> Mike.
>>
> This solves my problem, perhaps there are others.
> Is it possible to provide your defconfig?
> If so, I can try to find out why it is still not working for you.

The defconfig is included in mainline, it's "topic_miami_defconfig"

Regards,

Mike.


>
> Regards,
> Bernhard
>
>>> Signed-off-by: Bernhard Messerklinger <bernhard.messerklinger@br-automa=
tion.com>
>>> ---
>>>
>>>  =C2=A0=C2=A0 drivers/mtd/spi/spi-nor-core.c | 22 +++++++++++----------=
-
>>>  =C2=A0=C2=A0 include/linux/mtd/spi-nor.h=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +=
-
>>>  =C2=A0=C2=A0 2 files changed, 12 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-c=
ore.c
>>> index 6f352c5c0e2..a8865bbd37c 100644
>>> --- a/drivers/mtd/spi/spi-nor-core.c
>>> +++ b/drivers/mtd/spi/spi-nor-core.c
>>> @@ -655,7 +655,7 @@ static struct spi_nor *mtd_to_spi_nor(struct mtd_in=
fo *mtd)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return mtd->priv;
>>>  =C2=A0=C2=A0 }
>>>
>>> -#ifndef CONFIG_SPI_FLASH_BAR
>>> +#if !CONFIG_IS_ENABLED(SPI_FLASH_BAR)
>>>  =C2=A0=C2=A0 static u8 spi_nor_convert_opcode(u8 opcode, const u8 tabl=
e[][2], size_t size)
>>>  =C2=A0=C2=A0 {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t i;
>>> @@ -739,7 +739,7 @@ static void spi_nor_set_4byte_opcodes(struct spi_no=
r *nor,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nor->program_opcode =3D spi_nor_c=
onvert_3to4_program(nor->program_opcode);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nor->erase_opcode =3D spi_nor_con=
vert_3to4_erase(nor->erase_opcode);
>>>  =C2=A0=C2=A0 }
>>> -#endif /* !CONFIG_SPI_FLASH_BAR */
>>> +#endif /* !CONFIG_IS_ENABLED(SPI_FLASH_BAR) */
>>>
>>>  =C2=A0=C2=A0 /* Enable/disable 4-byte addressing mode. */
>>>  =C2=A0=C2=A0 static int set_4byte(struct spi_nor *nor, const struct fl=
ash_info *info,
>>> @@ -930,7 +930,7 @@ static int spi_nor_erase_chip_wait_till_ready(struc=
t spi_nor *nor, unsigned long
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return spi_nor_wait_till_ready_wi=
th_timeout(nor, timeout);
>>>  =C2=A0=C2=A0 }
>>>
>>> -#ifdef CONFIG_SPI_FLASH_BAR
>>> +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)
>>>  =C2=A0=C2=A0 /*
>>>  =C2=A0=C2=A0=C2=A0 * This "clean_bar" is necessary in a situation when=
 one was accessing
>>>  =C2=A0=C2=A0=C2=A0 * spi flash memory > 16 MiB by using Bank Address R=
egister's BA24 bit.
>>> @@ -1141,7 +1141,7 @@ static int spi_nor_erase(struct mtd_info *mtd, st=
ruct erase_info *instr)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 nor->spi->flags &=3D ~SPI_XFER_U_PAGE;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }
>>> -#ifdef CONFIG_SPI_FLASH_BAR
>>> +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ret =3D write_bar(nor, offset);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (ret < 0)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto erase_=
err;
>>> @@ -1175,7 +1175,7 @@ static int spi_nor_erase(struct mtd_info *mtd, st=
ruct erase_info *instr)
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr_known =3D false;
>>>  =C2=A0=C2=A0 erase_err:
>>> -#ifdef CONFIG_SPI_FLASH_BAR
>>> +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D clean_bar(nor);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ret =3D err;
>>> @@ -1630,7 +1630,7 @@ static int spi_nor_read(struct mtd_info *mtd, lof=
f_t from, size_t len,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset /=3D 2;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }
>>>
>>> -#ifdef CONFIG_SPI_FLASH_BAR
>>> +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ret =3D write_bar(nor, offset);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (ret < 0)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return log_=
ret(ret);
>>> @@ -1667,7 +1667,7 @@ static int spi_nor_read(struct mtd_info *mtd, lof=
f_t from, size_t len,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 0;
>>>
>>>  =C2=A0=C2=A0 read_err:
>>> -#ifdef CONFIG_SPI_FLASH_BAR
>>> +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D clean_bar(nor);
>>>  =C2=A0=C2=A0 #endif
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> @@ -2016,7 +2016,7 @@ static int spi_nor_write(struct mtd_info *mtd, lo=
ff_t to, size_t len,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }
>>>
>>> -#ifdef CONFIG_SPI_FLASH_BAR
>>> +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ret =3D write_bar(nor, offset);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (ret < 0)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> @@ -2090,7 +2090,7 @@ static int spi_nor_write(struct mtd_info *mtd, lo=
ff_t to, size_t len,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>>  =C2=A0=C2=A0 write_err:
>>> -#ifdef CONFIG_SPI_FLASH_BAR
>>> +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D clean_bar(nor);
>>>  =C2=A0=C2=A0 #endif
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> @@ -3791,7 +3791,7 @@ static int s25_s28_setup(struct spi_nor *nor, con=
st struct flash_info *info,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 cr;
>>>
>>> -#ifdef CONFIG_SPI_FLASH_BAR
>>> +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOTSUPP; /* Bank Address=
 Register is not supported */
>>>  =C2=A0=C2=A0 #endif
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> @@ -4577,7 +4577,7 @@ int spi_nor_scan(struct spi_nor *nor)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nor->flags & (SNOR_F_HAS_PARA=
LLEL | SNOR_F_HAS_STACKED))
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 shift =3D 1;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nor->addr_width =3D=3D 3 && (=
mtd->size >> shift) > SZ_16M) {
>>> -#ifndef CONFIG_SPI_FLASH_BAR
>>> +#if !CONFIG_IS_ENABLED(SPI_FLASH_BAR)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* enable 4-byte addressing if the device exceeds 16MiB */
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 nor->addr_width =3D 4;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (JEDEC_MFR(info) =3D=3D SNOR_MFR_SPANSION ||
>>> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
>>> index b8b207f7b5c..4eef4ab0488 100644
>>> --- a/include/linux/mtd/spi-nor.h
>>> +++ b/include/linux/mtd/spi-nor.h
>>> @@ -569,7 +569,7 @@ struct spi_nor {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 rdsr_dummy;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 rdsr_addr_nbytes;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 addr_mode_nbytes;
>>> -#ifdef CONFIG_SPI_FLASH_BAR
>>> +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bank_read_cmd;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bank_write_cmd;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bank_curr;
>>
>> --
>> Mike Looijmans
>> System Expert


--=20
Mike Looijmans


