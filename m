Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4954EC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 09:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD61A83B4A;
	Thu, 10 Apr 2025 11:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=topic.nl header.i=@topic.nl header.b="E7KtZkcR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2838F83B52; Thu, 10 Apr 2025 11:26:31 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC60483B32
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 11:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mike.looijmans@topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUTy6BwKsg8Ko0ww75mSv3gZn0QuGgMP0I0eN5XPLpSHzJh3L1Q6FyO5VhM85AnNdSsXkXopZ4EI7pJRdq/bvNtQ6hi1u8dy0kdHuZt/eyIJBJlMMvt72kioxuDAs1Lm7EgHMSkkLj9FW/7xUPuHhQpaZc7jogW5jfsGOKBDCW+7eT5AtAPkI6pZBl89PMk4dJ8SIcnKaVad/zosjBXGaCO80unn51Ccg89/GKdhBwyOO+XGK7yNzIiUm6/clZbYSQawJLYu04Hl/ATnJZtdHqsvTsIlfLxDXb6M4rbkfBb/M97NcdX0x1Hu8JHPIb94nnMSmOeqtgRXm22HyI7dEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ajrdAowMuegsQ2yaJ2SEMcf9HLr/atD/1lnrxCmobQ=;
 b=JL7aHTXMYPJ8Q8YT9AbkJhaSHIjKRzw9T4vX004in5IqehdiPqG6hytwDLXxD8JAtS2kVbf8cThSm/9DbYJ7krZeQRs/JzbiGHg9OeG++rPgPvFZdxfkh0pCk30pFKoy5mLdlxxRrBt8UhOiWNTbOBi32jTS8YWiSwfmedNwUn7cnUkpjtek+ATUimNYZkdYqjNFKR4HHAx80c8jZ6HhT5IZyvar37r1+6iMthPcxzOD95kH8Tvfe12y4XzDjNeKF2/t1BesmVba8TX7FfMaz/zLFqLchOdNzAmsLVmlDf05k9FFcuMI1zG4JY6tTp9pNgiX+dG53CQnncTuKs2sZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ajrdAowMuegsQ2yaJ2SEMcf9HLr/atD/1lnrxCmobQ=;
 b=E7KtZkcR1fVL4N+fKk35qH6J5d1rNexMK2EVPVqMCrL+6s3jQB4O++5xF6xV7TN+m70rx57IbUvz/eoX9m9C3zaVVqVx93KXZLxZ8NTCPNBpBlSuH0aZZ/35zlXlyAhSatLI7Ie9dfxEh5NFnh00RxOu8I1YjYwsWZi3TIwIiI/WN9eg6T4B5AHefWVhpRbahrcQ6I95hgavuuXfk16zDdFjLL8oSoYdxgRCUTZ1/u0JweOdKqa1J/iWxXkTT07KB4/gpL2o6g4NKN83x6qXwXrwc3tSRPd/q6Zgbzf6GjMF5vzxpJWZunws1SJ0ek0Lgscdf08GGuFo+QqgckhhBA==
Received: from DUZPR01CA0225.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::22) by AM7PR04MB6999.eurprd04.prod.outlook.com
 (2603:10a6:20b:de::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Thu, 10 Apr
 2025 09:26:25 +0000
Received: from DB1PEPF00039230.eurprd03.prod.outlook.com
 (2603:10a6:10:4b4:cafe::9a) by DUZPR01CA0225.outlook.office365.com
 (2603:10a6:10:4b4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.23 via Frontend Transport; Thu,
 10 Apr 2025 09:26:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB1PEPF00039230.mail.protection.outlook.com (10.167.8.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 09:26:24 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (104.47.51.232)
 by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server
 (TLS12) via SMTP; Thu, 10 Apr 2025 09:26:24 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by DB8PR04MB6939.eurprd04.prod.outlook.com (2603:10a6:10:11d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Thu, 10 Apr
 2025 09:26:21 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 09:26:21 +0000
Message-ID: <09e85621-2a0c-461a-af6e-a216d64dd89e@topic.nl>
Date: Thu, 10 Apr 2025 11:26:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: zynq: Read using DATA register when direction is
 output
To: u-boot@lists.denx.de
References: <8067946288c687c323403857aff01e3074bcaeca.1744273514.git.michal.simek@amd.com>
Content-Language: nl, en-US
From: Mike Looijmans <mike.looijmans@topic.nl>
Organization: TOPIC
In-Reply-To: <8067946288c687c323403857aff01e3074bcaeca.1744273514.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR10CA0004.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::14) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR04MB8644:EE_|DB8PR04MB6939:EE_|DB1PEPF00039230:EE_|AM7PR04MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: fc2f3a7c-c4ca-4ef6-2e66-08dd7811c3af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?cTkzenlMbmJHNGNtN2tPbkY3MjAzNlcxdGh2eUdiOXRPR0dBYXQveXJpNTVY?=
 =?utf-8?B?STd6RUMrL2xuVUVvUXdZaUhoRU8vS1kwaDNweldETE1GenV6K3l0WElmd09o?=
 =?utf-8?B?QVZlMlc3a3J4a0hON2NmS3VMQURjVlpmY09RVmp6ZFc2ditKRVZ0enkvRDhp?=
 =?utf-8?B?OW81RzhUdExuc3UrZ2tLdGpHMzFtZVJUSHU2cXpnRjJTM1NSeGhhQUZsN2Ra?=
 =?utf-8?B?Q0tCZXhpazhZa3hDd05kN2lqbjdJbDZYcU9HV3VaTG5ONlU5UWw1N1kwbjdV?=
 =?utf-8?B?YUViQ2JCTGVBR0N2eU1jUnF1SWxpbmhFVEkwRm51YmF0SmF2MG53dk1ZL0hj?=
 =?utf-8?B?ZmllaTBVVCtFRFFxdS9sckgvMG1rcnV0OTJwU3BCRE83eDhrOHNHL25WWnJL?=
 =?utf-8?B?aWllQ09rbjlKN1hSTTBlMDI2L2N2WEc0aHRoWkJueURHZFFmREFKeEhKQnpB?=
 =?utf-8?B?blNCdGZyMXF1TjMrQ1RYQ2VOcTlRS3c5dG40bkhoSS9CeHdZUGJFMlloMWtI?=
 =?utf-8?B?elBBU0lHaFlxYzhCRWRmSGxXb2FhWlBoZkdhU0o0UDEya2x5aFhQYUROMDlF?=
 =?utf-8?B?TVR3YXRwdkIxNm1kbmpLUDlZNUZuQzIxeU04TEM2ZTluRnRpMnFYWEhWL3pm?=
 =?utf-8?B?dlVBeVR1TjcySGxxMGxDem5iVkJDeUtmU3d2VEVRSDVLUWExb2tjYlVVR0Zm?=
 =?utf-8?B?ZHJhVk1tSnhJSFFhKytVMVRLc2k2VWRURzB0aXdTWjdQV2hTcDJ1N01nVzRx?=
 =?utf-8?B?TEh3NDFRNjU4SlRXRlpoc0FwdW9LZk5oMEJLdnBzd0tkZzF0b2lWZi9tUDhT?=
 =?utf-8?B?cU1lNnBUOEFJL0k4Q29NUVpqck5Wa01qMDF1OFh2Q25qNzFESkRJSGJxYWcy?=
 =?utf-8?B?NHVsSld4akpRejRtZWh1SERUZWd5Nnp3K1pzR2FzTFFScnRZbE5Qb2NsMjh1?=
 =?utf-8?B?REc2MVhKSFZrQ2pOUEpkdUY0aEUram00L2FsLzJEdy80VnIxWEpTNDV2a2M1?=
 =?utf-8?B?RHVUYVFUam5IeWhtdDFHRVhHN0xmQ2VrVyt3a2tiM0N3STBrNFpJQ0s4ME5q?=
 =?utf-8?B?YUkzNk9nTzRwY21KRjV1bS9DNGhsVlA0Rmh0RnVNckxJcnFFSTRjVm41SDJQ?=
 =?utf-8?B?VzRmbDQ1b0RSaVJhWWYxMThjZTVBQVBpK2FIVDJNaUtHZitvRUFlYnJITVk5?=
 =?utf-8?B?V2pscGEyYUJvdGI2K3ZYR2VMQmZmdy8wa25BQk82OWRHZVJ6N1A1K1FCOVJQ?=
 =?utf-8?B?VUlMSzRnNDRKamNFUGpmcWJ5M09TUFdGUEhGUExLaXN6Y3VpZm5VK2Uwa2I2?=
 =?utf-8?B?MmFVa0lGM3FJbjhVN21xdGFjSS94NkgyaVJIbVZFZ0RHWE5TemtWeEJycmp6?=
 =?utf-8?B?VVZNN2FZeWJYREw4ZlQ0c3RySUdkQWRNTXZ4dE5LMkJSQjNpUFBNdldRbWln?=
 =?utf-8?B?YnZxYjl4dWJXOENVdlZaTlJ2VjJDbjVEM3MxVzU1M2NoVUtyd0ZQNU9CTnBv?=
 =?utf-8?B?RGN0eHVNekVtVGdFWmRvcDY2ZkdZS2FpSTk0Nkg5czlPYXorUXBMVXE5Ym41?=
 =?utf-8?B?Q0YxcEtlZTR0Vlg2KzArbHdCNjJBenpaV1lOSFJrNjBJMm9EWHlGaW1SaHNW?=
 =?utf-8?B?ZUJvYzBXWm95NDllL0YyNUJ0N2R3KzJsZk9Pdit0U2o5LzZQc3BOTE5ZaUhO?=
 =?utf-8?B?aGZHMm5OL0hlajdPZG8yYW93UjlnUDBJVlFhdjJkMnJFbXBCbWlpR0tmcTJq?=
 =?utf-8?B?aWJ3OE5uNkxIQTNTQ0lYTHdrQXFYUzN2UmVqY29BZ013eUp6dEdYVW91aHVh?=
 =?utf-8?B?R01sQy9LN0xWS0p1N1B1Wk1MbzFpMldmTEVtVWhTd3lrRDRDNit3ajBLVHpH?=
 =?utf-8?Q?pBN1klpXQ+mss?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8644.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6939
X-CodeTwo-MessageID: dbb1c522-1514-4df6-ae70-88335f848c5a.20250410092624@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF00039230.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: cfe3e02b-ad08-4376-6746-08dd7811c19c
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|14060799003|35042699022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEVNR3BBM2dwMmFsYmtFVG03aFkzQVdwVUV3QWhiWnpVRGIxYWVjNmE5Tk4x?=
 =?utf-8?B?UjJiQm1QVmc1QjNVcXRqeFVDYVVodDc2bVF5YTZRNGZlUGROMldPV2xtRDRE?=
 =?utf-8?B?T1JXVzNhOVFoM3h2UTJZcFkyclN3K1dtalNwOWVPdTdWaDc4blVUQ0JjbjQ2?=
 =?utf-8?B?Z29ONDlGYng5Skw5cnk2aGxBV2VhRUN1Vy9iMEMvZHJOV3l0aWRxOVZnUlhr?=
 =?utf-8?B?dzZNaksyRXA4bVJobjhFalRSZlM2eEJoT3BuQ3JXSjc3RU85ZmhDeVZ3T2lo?=
 =?utf-8?B?NkEyUmhqRXJwVWRnekpORFN1b3BHOGVlUDhXeHRqTUI0ZGJwQTB6OEJHdkVR?=
 =?utf-8?B?eTNsY3NFbklTdlFiSlI4NzV6bVJSYmpneWNSK05rN1FZZGkraTYxTFBvZXQ3?=
 =?utf-8?B?Q3Q0MytVZ1NxV3VBVEI0N1piSGxOczZMSWV6ZWtWQUVHbExBUlVQVUc4Qklm?=
 =?utf-8?B?Z2VuVzNIVUFkQjhRNGRzcHhIVWpYTDMxQjMza0d1aTB4Nng1TEJNbWYvWTdF?=
 =?utf-8?B?QWxHckpUL09VajRVcG12ZzBQeDc1bUsrQ0lGdFpiYkI5M2t3NU1nS2x2QktT?=
 =?utf-8?B?RU1BTkF5UlQzLzUxNzk1NUtMRWFJK2lGSURSdXpMTFRyU0NWMit6OEh6ckJn?=
 =?utf-8?B?MzZWcjZYckdmeFd6Nk04eTRJMkhjdWRaUDFNa0JLU3pLR1QxRWxWYVJ1Mmgz?=
 =?utf-8?B?UVRBcmdZNmZSbzJLSDlFeWx2enFsYXhSSU5lTDYyc0E2OFo2Ly85VUJoUGd0?=
 =?utf-8?B?UTl4YlNFUUJFS2FSVEpqTjdjUDRTZFRIbjVnT0VZbWtoZ0FUWU5maW5raklV?=
 =?utf-8?B?WUI1MFpOaENSVDNpZ3BpSU1VaHpXWlRtQ0FkVnE2UTdvUDZXQ3hBa0JLampV?=
 =?utf-8?B?U2s4aXpZbUxDay9CSDB1OXFsdGg3MGFzS25SY3dPMWIwSThkTnpnNUpTZVh6?=
 =?utf-8?B?NlpGY3hOWFBVdFBjb01yQUFRSWhtczhLbHJocStDWU1jN0lwbDlnNHZibVY1?=
 =?utf-8?B?Y1dVYWhMakEvVHlzakFZcnVBTm94em1rK3FhdW9DaGZOVGZVSGwxMkd0cTM0?=
 =?utf-8?B?QjJYOGJnY1hJWVNvcFZ1SGtDQWh6ODBEcDhheVc5UStab25lL05NcUlxOTYx?=
 =?utf-8?B?ckpoVERxSDdubUhpcmNqVVdQcTVWMmlRUUxjcmJERE1ycXJ1eGhTMHhIRVM2?=
 =?utf-8?B?ZEpIUGNha3pnSkM1dkhGaUxMYnFCUjNSQjdKd0RLbG13KzVheitQQUZuYWhV?=
 =?utf-8?B?UWZZb3NlYUdKSTdEMFFWc3hGNndIYlAvRllRdzVsbUZEN25JSjVKbHFBUFdJ?=
 =?utf-8?B?WUcyMHV3cWxvU3EzUnF4TWEvcVBGdXNtMVFCcEZEYVhrbHpWUzBKOG9XUU5N?=
 =?utf-8?B?TUJFMXVLY1pPWjFBWHhTYmZBajhCVlZZQzR5VmJyRjR1ZEhaTFBZUk1tS21Z?=
 =?utf-8?B?RWJoNU96c3VqTWVmM0ZzMDJNclBqVU9EM29pNEx0czUwWnlXVVoyK01EMnhM?=
 =?utf-8?B?S29JWDIyY2VzZjJGVHZ0Y0N4ZDVUeGdZazF5Rm1ZOG12ajR3YXFjWStmWTZ3?=
 =?utf-8?B?WVNvbS9iYU5CbVU3STMyTmhWTU5PK2JVSjNCSVpza2ZxdHhrUVRzRkRjY2JR?=
 =?utf-8?B?Wkh2NktoaFVNR05URW9ZZHBSdUFDTnNlWTdWZ3FMSDVMS054MUMxbnNRT3k4?=
 =?utf-8?B?RHJtTU9neDRBYldSbkVVSCtMSXF0VlJvZVBuSEdib1ZVckRCclpDS2pZQlNz?=
 =?utf-8?B?K1pEQUtpNDB1dHRZTjl5WUdXdU53NXhVdGRER1JTQWNOY0ZYSnUzZzJRV0x0?=
 =?utf-8?B?N1dMcXBHL25NSXF0UzZBL0V5REFlZWtnOFNDODBjYzAvZEtja0pUZTI0WVNT?=
 =?utf-8?B?MDVMU045RElIbndkUzVXT0R1QlluQ0hUZHhiZG4rai85blFmdWdmZHN5VTRK?=
 =?utf-8?B?dGIyVUd4RXFNbm03Q0JYRXlOcnlyNk9hc1pqdVhnTnMzUExLL0dVOGhUd3Ri?=
 =?utf-8?B?MHBRaG5WYm5oSXdaUmtscmlQN2hOVWdXZ0xYRkZ1ZTRmVFd0QnVWSkVtc0ov?=
 =?utf-8?Q?uXvsvJ?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(14060799003)(35042699022);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 09:26:24.8980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2f3a7c-c4ca-4ef6-2e66-08dd7811c3af
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00039230.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6999
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

That looks broken to me.

When reading a GPIO pin, you want to get the actual state of the pin. Even=
=20
though the output state may be driving it high, the actual pin may still be=
=20
low because it's shorted to ground.

M.

On 10-04-2025 10:25, Michal Simek wrote:
> From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>
> Gpio status command reads the DATA_RO register rather than
> DATA registers even when the direction is "output", fix this
> by reading from DATA register when direction is "output".
>
> Signed-off-by: Nam Ian <ian.nam@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>   drivers/gpio/zynq_gpio.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/zynq_gpio.c b/drivers/gpio/zynq_gpio.c
> index 7db58c70663e..4fdce39d91b6 100644
> --- a/drivers/gpio/zynq_gpio.c
> +++ b/drivers/gpio/zynq_gpio.c
> @@ -64,6 +64,7 @@
>   /* MSW Mask & Data -WO */
>   #define ZYNQ_GPIO_DATA_MSW_OFFSET(BANK)	(0x004 + (8 * BANK))
>   /* Data Register-RW */
> +#define ZYNQ_GPIO_DATA_OFFSET(BANK)	(0x040 + (4 * BANK))
>   #define ZYNQ_GPIO_DATA_RO_OFFSET(BANK)	(0x060 + (4 * BANK))
>   /* Direction mode reg-RW */
>   #define ZYNQ_GPIO_DIRM_OFFSET(BANK)	(0x204 + (0x40 * BANK))
> @@ -230,7 +231,7 @@ static int check_gpio(unsigned gpio, struct udevice *=
dev)
>  =20
>   static int zynq_gpio_get_value(struct udevice *dev, unsigned gpio)
>   {
> -	u32 data;
> +	u32 data, reg;
>   	unsigned int bank_num, bank_pin_num;
>   	struct zynq_gpio_plat *plat =3D dev_get_plat(dev);
>  =20
> @@ -239,9 +240,15 @@ static int zynq_gpio_get_value(struct udevice *dev, =
unsigned gpio)
>  =20
>   	zynq_gpio_get_bank_pin(gpio, &bank_num, &bank_pin_num, dev);
>  =20
> -	data =3D readl(plat->base +
> -			     ZYNQ_GPIO_DATA_RO_OFFSET(bank_num));
> -
> +	reg =3D readl(plat->base + ZYNQ_GPIO_DIRM_OFFSET(bank_num));
> +	reg &=3D BIT(bank_pin_num);
> +	if (reg !=3D GPIOF_INPUT) {
> +		data =3D readl(plat->base +
> +					ZYNQ_GPIO_DATA_OFFSET(bank_num));
> +	} else {
> +		data =3D readl(plat->base +
> +					ZYNQ_GPIO_DATA_RO_OFFSET(bank_num));
> +	}
>   	return (data >> bank_pin_num) & 1;
>   }
>  =20



