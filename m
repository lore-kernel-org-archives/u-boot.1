Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5CEC3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 08:46:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D972B8283E;
	Thu,  8 May 2025 10:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=topic.nl header.i=@topic.nl header.b="a/elIFb1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8C15828B3; Thu,  8 May 2025 10:46:44 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32D3B82153
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 10:46:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=topic.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mike.looijmans@topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1cmw5NUiEdQex0xS2ImUQmfUkipXzPRMjG1A/1uChpkfm6+dfrlhT/Rmyi59vepmmn8TDXvqysOsAi9pytTqsJF2aP0PJOc2mKU2H7SJY01RfqJ2m04g1Riu7/9vfJMRN+8Mtb5Yvmf9cuqUZxsodmeL+e+0LG5ClGashK3u/iAUJzlbxPFNJmmxwOB7+jTcgHSqzkljruHUt2ZzDiJXNxBUebmjb6YJPm+1Cim8JHN/VQGTqRISLw67Fmr887YRSoHx3Oq5rcfXH7lJhoAolBQo1+Doyf5LVcHwwr3NAoMfxNOHp2JxTyxj5C1VU/4OXfkJRPK7+/nqy3f3iJ13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jps2wVKUDNDe/jwMrzXDhGlWa5HAJ5foAlcySIB6Rr4=;
 b=Toe2/YwjZOpNbzh17fpy8fhCMrNt+lTDShhMXA4keEPf8zgWvPtImKwKz7zmK78p0UpeYujSU4fU2j/qp3uNx74jBfW5GWgtdR4i3wnXlkQEv1EVGlsh2cSNNA2TsMWwbLUhNU3+X4SuJkEc0cO+U+LALKkpKVDI6W0JE7qrQF4pjxk6O9rXqxxs91WG7vduJJA/ykTIJZ0keOklvU+MJ9MWd5AtoGWDMFLkQCNCEcjOB+CwXo0YgTMND/oRPlg7XWOqCjDhbFo3BFy//ewEA7t8hjNxvEfB2hZyPnsucDFMiYchcyPpwVCuDUKZUfTZaNXiDBLocI/Z0PNStBijwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=topic.nl;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=topic.nl; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jps2wVKUDNDe/jwMrzXDhGlWa5HAJ5foAlcySIB6Rr4=;
 b=a/elIFb1ZvYEryQJ1QyYEOesEMYqpULB2Br+xRN8GXr589sMnVcOCPV30P5W6/yv1WzvOV+avFo2uDCHLLQhQpSzfQ1PNKuqPKfPvE77fzrR4CIGtB+ghxBFWmjleE1kCyba6dFxwrHThQOvwtjTRUYTLcsFAWfcwhI7YvlDb9jhQqa58q7PVf7dfoxBL1A5O/142AkxhBwZYN053YxO+egyhMRZHVUBPMOryf+5yhXYt32K8HaZxnF6rw6k2Ho/xsKXfzoLC2a4GePx/EuMkL7pCNmHAFdAH54mBlPPvKiJ+HvgoNS4HDF61ScoaGeTd/O0z0ihqginNSNhDskk5w==
Received: from AM6PR10CA0088.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:8c::29)
 by AS8PR04MB7654.eurprd04.prod.outlook.com (2603:10a6:20b:290::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 08:46:40 +0000
Received: from AM2PEPF0001C70D.eurprd05.prod.outlook.com
 (2603:10a6:209:8c:cafe::37) by AM6PR10CA0088.outlook.office365.com
 (2603:10a6:209:8c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Thu,
 8 May 2025 08:46:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AM2PEPF0001C70D.mail.protection.outlook.com (10.167.16.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 08:46:39 +0000
Received: from DUZPR83CU001.outbound.protection.outlook.com (40.93.64.8) by
 westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Thu, 08 May 2025 08:46:39 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AS8PR04MB7637.eurprd04.prod.outlook.com (2603:10a6:20b:29d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 08:46:37 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%6]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 08:46:36 +0000
Message-ID: <d404415b-425f-4a37-82e8-ceac98527308@topic.nl>
Date: Thu, 8 May 2025 10:46:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Adding Device Tree Overlays for MIPI-CSI2 Camera and libcamera to
 u-boot in a buildroot or Yocto Build
To: u-boot@lists.denx.de
References: <c0a6f0833fd3e4d887066dfe2ff405a5@cairnwater.com>
Content-Language: en-US, nl
From: Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
In-Reply-To: <c0a6f0833fd3e4d887066dfe2ff405a5@cairnwater.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P195CA0011.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::15) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR04MB8644:EE_|AS8PR04MB7637:EE_|AM2PEPF0001C70D:EE_|AS8PR04MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: 06ccf5fc-662b-4504-6219-08dd8e0cd9b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?eTVkbnY5K3VCRW44ZUVvZithdVl0enhSNSsyai9Cd0RZN2lhV2dqdXhMdUlK?=
 =?utf-8?B?L29uQ2xFSGk1aXNubDc3NmNwcDlvY0Q5MGl5Nnhjc3ZCajNyZkU2Vm1LT2M2?=
 =?utf-8?B?b0IxSDRDRzdTR3EvUm5IeDNPN0lLSXRUV2h0SXpvZHN3TUdhQkJvVlV4WWJN?=
 =?utf-8?B?dWNWaTNFdDJZOW42eGpkYkdaTUllWWRlcVp0UE9zeGJwc1VjUDk0QmcycU1D?=
 =?utf-8?B?Zjk0ZWZNNzdkQWZNYTNkbGNuVHRNWHNLV2lkUW8zUHVBMjhHU0lSZ0NUUnJE?=
 =?utf-8?B?WXhlcE1FMUtJdHJWTDl5dUp1S1JnTjliQUZnZ1ptMFFlLzArM2pxZ1crUWpq?=
 =?utf-8?B?bVBDS1ZsMTlxNjROdjJjeCtxVU16eFh6NGU0ZVd4cVRaTU9McVF4YVRxeXR1?=
 =?utf-8?B?aloycitpSzB3alQvVGY3U00vVzJCWTh0Y1p1SVFaMXJRTUhQK0RlVnBXb1Fn?=
 =?utf-8?B?YjlxWTM5d3FiL0NFc2szWHlnTXI1WDA2VnZsOEJUV1BTaWcyL3hES25VQm1P?=
 =?utf-8?B?aHplOHZoOS9WTGJKT1pUUkdGWDMzRk5jdmdZMjc1aXd4M2d4dGdPeXBqaTB3?=
 =?utf-8?B?ak5kbHpkSVJrQXRwNkgxdVZKNWtQcEdXbTllMjdzc0R4N0k2aUsrd1BtQk5X?=
 =?utf-8?B?Tm5oS2xjNWNLV3M3TUVNOUJuaThVZGFScnl5QUVpM0M0Z2RPUVdrc0ZReENR?=
 =?utf-8?B?VnA2RjFSS3Rjajk0YnBHQlBka2V6c1hnRXhQU0JySlkrdVBTSkUrQU1VbnFz?=
 =?utf-8?B?Q2tlcG0yMUVZSktjdEVlUFREbGVSWGpVRXJFQ3hVMjFwakdRRUtobnc4eS9a?=
 =?utf-8?B?MEJmZW9SSFYzWkJJUW9PVjYrRFZFbWJQVnIrc01rMTF1aTdhVklyOXJUVjBK?=
 =?utf-8?B?c2tHNVcwUVVWMm1FVmorTCsxYS9pQm93WEJEZTkxbWFoOTROYXpVR2VWMnF5?=
 =?utf-8?B?bFVOTEpENzhNd00zTUc3Q21JdmNLU1oyWTNsK01ybWVDYUxWMU5xTlRGQUVs?=
 =?utf-8?B?UlNXRStmRE5pTUp2RlMvRkhzZlNUQ0ZjUXJFYWRoSnh3WlNSUE45QVFMMnlp?=
 =?utf-8?B?SDdSUWhadXJIVTcrMlpaL0dYWFF2cXlwS0FrdDB2K3EraG9tZnE4YmtEOTBw?=
 =?utf-8?B?bFUzdWNBdzlxRjFRUWZCUVd4UzFTVWs0OXFQUy9tZXRDalNQbTdzejA3ZTBk?=
 =?utf-8?B?MDZhV3ZGOVJVRHdkaExaaDFPSE1lc1FuSWxtZXpuZ3E1K25BekxaWVZ6YjlT?=
 =?utf-8?B?bjdzVnpReTlGK09iZHpMWlArZkVQY1h3cnBPREF6MkVtQlFqeG5lNmg4OW4v?=
 =?utf-8?B?UjVWTGJKVHArdS9TQ29SemZRckRyNkx5eXRhNjdYczczcDR6SDQva3FTSHdJ?=
 =?utf-8?B?RCsxRlk2L2oyV085cEVuRlpQS2MrWlNHM3J0b1FKTitXZHk3ZUNGb2taNVhn?=
 =?utf-8?B?Q0lMV05zTjlaOHJYRWZaM2RTR0UydXRVWFUvWjI5T2xuWEt0QkhONXhMTzlF?=
 =?utf-8?B?MndaYkFGSHB6bGRjdWt1MFNCUDNCMTlHdEhYb1ZVR1FKc2lyeDNYQ2pjRDE1?=
 =?utf-8?B?eExZaGNYUkhvTXV2MWZBdXJjd0JHTGtzanRsYXdHZ0w0M2tOWkZVb2JFZGtB?=
 =?utf-8?B?a1hjTFJVOVVTOGh0RDNFV0FxZTVBeUlPYVVOY1QzZ1YyZWJ0eTYrMEFTeEJJ?=
 =?utf-8?B?bmRGOGtrdTR5K3FJSXdEKytJU0tHc2ZtUWtqWHE3Skh0dVlQTUNtdGRPenpq?=
 =?utf-8?B?b2RVYWtTUXhURDBTb1VqcmN0Vm9zbjNoUW1FN2NsNFVXOVdNZjVDZStPU0s5?=
 =?utf-8?B?bEJHd3ZaMkRvU3VyeHZhZTZCc0xVd3lobEVRU2hWMmZHRkFjREk0TytZWkxw?=
 =?utf-8?B?dW5EVkdYbkkzTUNqSVdsbGVoNXdPM3hJMlRJR0hKenVENjNHeXM4SEtIamhq?=
 =?utf-8?Q?FdPq/l7qhWw=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8644.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7637
X-CodeTwo-MessageID: 22ba952d-f8a8-46a0-b4b1-92d472cd7911.20250508084639@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF0001C70D.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0a19de97-2497-463e-6f02-08dd8e0cd793
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|14060799003|82310400026|1800799024|35042699022|36860700013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnMrYzcxOVJUMmxCa3lIZXR5NzBPUEZmVWpyc0ZuNENNL3c0VTJDdHY3MUd2?=
 =?utf-8?B?NHhrUEpJY3ZlRk15TU1YdGdCMnBLWkRWd2xGOThqTE8xVThjTU9iQTlmYWxN?=
 =?utf-8?B?SFZVUmtsbzBySFFkd04vMXFPdnNHVlVWeTJ5ZW5hZmVTbDhoT0dSYVVFV0RC?=
 =?utf-8?B?T3ZFMlEzTDJRZVhnTUZXblFVaXB1dWtYMEp0UDFTa2RiUFRIa2FWUTI4UGNV?=
 =?utf-8?B?UWxqSFZoRTIrdVIzdEFzdTNFSUJFOUtab0VDZUh0eDh0cmRhd1lmNEE5eTVM?=
 =?utf-8?B?Y2ZOS3RBNkFKSFNCRXNEWXZNOUdsNTVubkQxUmJBSnlIU0NXS0NaWFJPMEE1?=
 =?utf-8?B?bHFQSkVoYk9sR1ByVktMMWRVWUp5am8xZkIxTklBMk1VQWlBOS9MWldYVW84?=
 =?utf-8?B?ZExZenZZVEZsTTN3SjEwZ1J4Z1kyRWJvY0xXWGtGckdvRm1idUxQTENrUmx2?=
 =?utf-8?B?UnNuZUxkWmd2MC95VW44Qi9qbTlIYlRSWWRzQnpuN3NRTklTa0tqSERUZHJ6?=
 =?utf-8?B?RENPTnVmUlp3L2MxUU9wRU9YL0V5S2xrN2t5QkZ1cFk2c1lTa0NHbmhhS0Y0?=
 =?utf-8?B?amtVVlJObGNWbURwYXpZeHNvbVdKTktRSU9lTi9EbnpNNVFxQVp4a2JDeUc2?=
 =?utf-8?B?OVV3RHdxSmRYQ1dleUdPVHd1Z2dHWUhXemdkOXVReWZrc3NPemdYT3NtRlQ1?=
 =?utf-8?B?S2p0cmVNVFlUUEE5c0Y2YnV5K0ZybG91YmcyRDVMdVMrTmduZEZqOXU4WkJS?=
 =?utf-8?B?dStlL1djWHBRV09yNldqeUtMc1hWWFVVWis2dkwzekxNam1zazg3N2trN1Er?=
 =?utf-8?B?UlNuOVgxbnZ5WXJPN3ZlQXlvU3FHc3JtOUoxbE9jM0RyTWRTc1BzQW1ucXAv?=
 =?utf-8?B?dGNQNnF4MXg5ajBlcjZ6MEh4cUw5KzZrWDZmSnZTb1BOYnVpMmlkRlRISTBl?=
 =?utf-8?B?b2VTN204V29UK2FJcVk4OTh5Z3Nobldjc2RRNDhMUThmN1U0a0FjYUhpY1o1?=
 =?utf-8?B?N0RITkNDRWRwYzY2dEJYdERLSXRDNk5VRUhuNk10UUR5Z1dPVGx4T3BUVE0w?=
 =?utf-8?B?R2RZbW5mQnVtRDMrb1dEYWNsMDVjLytxUGVsajZzWXV5b1BLUjZJelFDQXkv?=
 =?utf-8?B?SThCenNMSi8yNk94ZnlzandoeHVJaU9iblJZMkVCWGlYS29kVmtyZVhYdXpr?=
 =?utf-8?B?TkJkZDRwTU50Y3lrVEx5R2RvbEkxVHF5UUwySHFCWFhJK0Q1MEVtN3FNZmM2?=
 =?utf-8?B?alhpOVFaTS9UeWJjVUsvbnlENXk1cmNDaGxwRys5cUpkemxYSVEzWGdrbXc3?=
 =?utf-8?B?cmtwb3llakRsMGp1dXN5Wmpmc2VzRGhpbmM0alZ5NGs4MGJJOEJMYjUzaC9v?=
 =?utf-8?B?R1pzWjBFYXUzTFZ2WkxpdUZzb2NNM1JacE1YTkhCbkpuV3ZnMGRid1ZqdXYz?=
 =?utf-8?B?Syszd1htNkxQQzlkTldiUDRyT3BncXF3MzdqVHRLem55WTVFNlkrNUNHUWZJ?=
 =?utf-8?B?L3ZEQW1vVXR4ckJ6c2RmcG1DVmVxUk0xU1NQcWtyYkVlelo3OVpGcGdvZTlh?=
 =?utf-8?B?L3NYWVVzTEVTT3c0cHk2d0ZqUGUvQ0Zaczlmck1MSE9mQWUzaWQybFFvVFZ1?=
 =?utf-8?B?RUMrWUxZSTZucE9vcXExNkJ3Vlo2dmF1MGVNT3RWWTVyRk5NV1dvMk1WTTNi?=
 =?utf-8?B?VGtPTXVldExieWtLNjBHak1uN3BRVWF3eGNadVkyR3pMdkZDaVpOS3pDN2or?=
 =?utf-8?B?dlRnR3hLTTREcnMzbUZRT0Rvbzdxb1dNclhtT2MzTlJYNEcvMU45Z0VjU0pr?=
 =?utf-8?B?SDNpS1V5Ymw3QXpWNjU3UlFZTW5QYytEaFg3eVozNDJnYVdQK0swNW9aUzYw?=
 =?utf-8?B?VjZwTUJaSm1Kakc0L0t2VU9UUjkzbkxpMW9wd29tZi9mOHJpZFhqTnBHSnF5?=
 =?utf-8?B?ZUF3Y3d3K284RytMNGw4eFhlYjllT3kxOEFBUXBFK0xQTC9TQkx5SVFrNlNX?=
 =?utf-8?B?ZjJZUk5mK3JBPT0=?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(376014)(14060799003)(82310400026)(1800799024)(35042699022)(36860700013);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 08:46:39.9330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ccf5fc-662b-4504-6219-08dd8e0cd9b0
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7654
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

On 07-05-2025 18:30, u-boot@cairnwater.com wrote:
> Hi,
>
> Does anyone have any advice on how to add DTOs needed by libcamera to=20
> a u-boot in a buildroot or Yocto build or on whether it's more=20
> appropriate to add them as part of u-boot or as another part of the=20
> build?
>
> We'd like to add Kieran's DTOs
>
> https://git.uk.ideasonboard.com/camera/dt-overlays/src/branch/main/arch/a=
rm64/boot/dts/freescale=20
>
>
> to the buildroot default configuration for Debix Model A SBC
>
> https://github.com/buildroot/buildroot/blob/master/configs/polyhex_debix_=
model_a_defconfig=20
>
>
> Ideally we'd also like to add the overlays for the Sony IMX 708 Image=20
> Sensor used in the RPi V3 camera but these aren't mainline:
>
> https://github.com/raspberrypi/linux/blob/rpi-6.12.y/arch/arm/boot/dts/ov=
erlays/imx708-overlay.dts=20
>
> https://github.com/raspberrypi/linux/blob/rpi-6.12.y/arch/arm/boot/dts/ov=
erlays/imx708.dtsi=20
>
>
> We're planning to use the Debix Model A SBC or Debix SoM A with SoM A=20
> I/O board to prototype a new open source wildlife camera for our work=20
> in conservation of tree dwelling endangered dormice
>
> https://new-homes-for-old-friends.cairnwater.com/
>
> then after field studies with the prototype design a custom board for=20
> an NXP i.MX 8M Plus SoM.
>
> The analysis for the new open source wildlife camera is here:
>
> https://github.com/William-Robert-Robertson/WildCamera
>
> Will


You can enable device-tree overlay loading in the kernel and do it all=20
there.

U-boot can also do it for you, example bootscript that detects the panel=20
to use and then loads the appropriate overlay (this runs on a RPi4 board):


fdt addr ${fdt_addr}
setenv panel fancy-display-panel

[Magic I2C stuff to detect hardware and set "panel"]

fdt resize 8192
fatload mmc 0:1 ${kernel_addr_r} /overlays/${panel}.dtbo
fdt apply ${kernel_addr_r}

[load and boot your kernel]


Example recipe to create the overlay, e.g. "device-tree-fancy.bb":


SUMMARY =3D "Devicetree overlay for FANCY board"

SRC_URI =3D "\
 =C2=A0=C2=A0=C2=A0 file://fancy-display-panel.dts \
 =C2=A0=C2=A0=C2=A0 file://fancier-display-panel.dts \
 =C2=A0=C2=A0=C2=A0 "

inherit devicetree

# Override to NOT have a devicetree subdir
FILES:${PN} =3D "/boot/overlays"

devicetree_do_install() {
 =C2=A0=C2=A0=C2=A0 for DTB_FILE in `ls *.dtb *.dtbo`; do
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 install -Dm 0644 ${B}/${DTB_FIL=
E} ${D}/boot/overlays/${DTB_FILE}
 =C2=A0=C2=A0=C2=A0 done
}

do_deploy() {
 =C2=A0=C2=A0=C2=A0 for DTB_FILE in `ls *.dtb *.dtbo`; do
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 install -Dm 0644 ${B}/${DTB_FIL=
E} ${DEPLOYDIR}/${DTB_FILE}
 =C2=A0=C2=A0=C2=A0 done
}



--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl



