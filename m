Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7316DC282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 09:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E388807D7;
	Tue, 11 Mar 2025 10:32:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=topic.nl header.i=@topic.nl header.b="me8qw53+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE963807D9; Tue, 11 Mar 2025 10:32:40 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20706.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::706])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B85F801FB
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 10:32:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mike.looijmans@topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xf5YSLCWskinT1Z0ubQ5aD7X6RdqWBEzEemqJURCGV7whzgnWMh4v84Y+FaAxopov2ALLKiWFeTwdrDgCCcdFiWdxqW7JHNvUcQZgsvgeAt+2urian5I/buyMktQj49Np54L8/mWrEj3YqcAN6k2MGagQEMVfsn9EesvQkhKCLzGvwAsF7IyQO0UaQ15vNA7cabn2QOYGs5ef9ZybP6Isxuf1UcBxSYMluHAdUpUtg69PXlW23Rl3Q8GGN3S+LVNeQclsqnSBEXrPXph3Uzq/xHE+mvp5/KjGMO9kzDQIWE7JQv8WFfJXnB+sPIm4HUV6hWHECcqCZ6yj2GFcot3cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q07qHCW4XW9SZ0VAQXHPRY1GZq32wkzA5E3CXpq/qio=;
 b=IYSdBxciU3UbhiJ/sgFkeGrvXqoZpGDB0dHnjISrOH/8D5tSzNfgHDP+Nd+GEyQZTKw/D56leF3R1Pk2f5weUNfqTaQXnPLxUyxYzETC03xuj3LKuE7MKOn4KBbtbZnLx9bu3GR4WYbCm+Bx88iC4dnajaDPjs5QFBWAtKqdTtckW5OTE0BtVmb8Fs6aoe1qN72YNMJjpzsGrPu4uBZqWFY64FHVas00L8vP4Vc69BwCQXjpMSzVPmZMA4xEbv37LbPgAYbLAdR+SpPHuueofBkSRW3iM7HkLMdb5AbiwpPBdG/WACA9ruF3BA1DKc6X1IQ5h96F4PXe8KeEO/exnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=amd.com smtp.mailfrom=topic.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=topic.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q07qHCW4XW9SZ0VAQXHPRY1GZq32wkzA5E3CXpq/qio=;
 b=me8qw53+NscgNCtQ2rOrRvXEadzsYj95vqEQM1XdvLgSTDsFQ3jdRqbMdT3pwz5IuHx7uetNeryVtcbmYodTrd4u8Sz5qkW0D7n3lnxurHav6/GHKww5+m8IuFfhQOeT6mfpzWbpT19MADwezNaKHGtTv/Oc5b/vMBWuhcYVBUEgw18kVcfTVbzevgGF2eiY7zFEB6KmIr3cOD+mw2Sbk14UMWGYkPct9CQeonk/8wLADjueXRlAhR0HqamX9r6ivcNWhq51OlGerf18olxZUFa09Utj5iWnmBVyF9jisZQL+8GUZFTnD2WD8oC17I8kRJzIdNmFKpCq8lNnV2VK9g==
Received: from DU2PR04CA0257.eurprd04.prod.outlook.com (2603:10a6:10:28e::22)
 by GV1PR04MB10919.eurprd04.prod.outlook.com (2603:10a6:150:201::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 09:32:31 +0000
Received: from DB3PEPF0000885D.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::b1) by DU2PR04CA0257.outlook.office365.com
 (2603:10a6:10:28e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 09:32:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB3PEPF0000885D.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 09:32:30 +0000
Received: from PA4PR04CU001.outbound.protection.outlook.com (40.93.76.77) by
 westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Tue, 11 Mar 2025 09:32:29 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by GV2PR04MB11192.eurprd04.prod.outlook.com (2603:10a6:150:279::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 09:32:23 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 09:32:23 +0000
Message-ID: <5f2f81f4-7248-40ea-969c-9f37686ba8a4@topic.nl>
Date: Tue, 11 Mar 2025 10:32:23 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH 1/2] xilinx: Allow alternative boot strategies in
 zynq-common.h
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.39d305af-e006-447e-a675-c4e243ffeb48@emailsignatures365.codetwo.com>
 <20250311070124.20696-1-mike.looijmans@topic.nl>
 <84b5bf66-fb4f-4590-b6ab-fa1ee3011aa4@amd.com>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <84b5bf66-fb4f-4590-b6ab-fa1ee3011aa4@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P190CA0068.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::28) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR04MB8644:EE_|GV2PR04MB11192:EE_|DB3PEPF0000885D:EE_|GV1PR04MB10919:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b47b2f-e4e7-4be0-7bd5-08dd607fa51e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?WThRRjJPbjRITWJwVlcxa2JQK1BrNXk5ZHc2dUZTR1M1OE1Vb2J2cDVDb3I0?=
 =?utf-8?B?KzVMaUw4TUhzL09ubVBvU1JEWFhtZGtzNFVIbnVxM3pPVDVLVnc1WVlkanc4?=
 =?utf-8?B?bCtnWDYrek5lenRMUWN4akozdFJLTml1WDJJSGZxVGtXeEdmMlYvaFpWQnY0?=
 =?utf-8?B?QzAzTDFXeXl4TnNsK011RjZnK0pFY25RRHdianRRcklKOFplQnUzRVRKNkZJ?=
 =?utf-8?B?S3VoOEM5aTZHSG9lbk1wYUFrbDIxaHNEYUxZY0JyQVZHcGlxSGx5Ym43eXVx?=
 =?utf-8?B?UU9kenY3RlBNZFZVN0l6UjVncDYyZ0w0RG9GSWtFN1VmZk5oNk5pc3lpQVZB?=
 =?utf-8?B?QlJ4TkJ2TXlINlhRckllS3czYy9OUTYwQjE2RTFaK2RsdjlkU2Q0VVZIeXc0?=
 =?utf-8?B?VWFwNEg4RjRKeG5WUlVIV3l5QkFUc3FJUDZTVm1LREhrNmdTaU9ERGMvaFBR?=
 =?utf-8?B?RUc2RGh2OURYTm5rais1K3VLUk53cG1pNVJ6bXhBRTRRZ3dYelBkMXFFOUVR?=
 =?utf-8?B?R05tTnRrQTRiZzZYNXUyMUhHYzh2RExnSzRSMmNDZlA2SFdPcEZ1K0cwUGxh?=
 =?utf-8?B?clF0NmpzTGt0Z202VFhTbTM0dEwyQ3o1cWVtUnBqaHErbHFPai9aR1hOMXJB?=
 =?utf-8?B?NFdqclNXVkI3WlF2WFV2eHRwRFB1V0g1M3k2dTBTbnhnRVkwS3ZhcS9VVjlq?=
 =?utf-8?B?ZkxIcDJEbEZJY29TeVRJdVROaTRZdnJ0b3JXd1EzK2JrcktBbitZSFhvU0Fo?=
 =?utf-8?B?QTdaSm1wOXVGZEJCM0pEc0RtRnpIL2NtMGgwdzVqM3QxWk84WUJsaHBhcWJq?=
 =?utf-8?B?UEV3a1FZRFN0bG5rQlB5eURJd2FyRmkwbVoyZDR0L3p5enRUMVJ3ZEtidWFk?=
 =?utf-8?B?c0o2dHZ2WFgycHNlb2dKdDNZSi9iZ0hZK3M5WXVXUU5ZTDNMazdaVEtiZ0Nj?=
 =?utf-8?B?QmxwTzVRQ1QvSkRZSjVKUm1yYk1oTVJ4QmNnVllxNVA4TzA0Nm4yWGY2ZnFK?=
 =?utf-8?B?ZldTVDQwUzVIQi9zbURmWk5RQkpYVTJsRis0QS9wekhSZUh2UzNqOGVKUHp1?=
 =?utf-8?B?UWNzTWExYzlVemowWHNjOTdEOWhiVnVTRFE5bG1ZLzRvelpzcmR3VHhsajV2?=
 =?utf-8?B?V1VqZlFPSHg5WDUzcDZqMDhubUY2dldEa3FYMy9kdHRuS1BOdlBacVAxSmxZ?=
 =?utf-8?B?RXBQVy96U3FSR2xJUFFqWWVoVTU4d0lQUzJmSHE4a21CSUt5RmNncUdZSUNq?=
 =?utf-8?B?d0k5ak5tWXJpcG1yYk9uNjZNSGlEekl0dEREaS9XRjl1Y3FmRXVkZVB3MnF2?=
 =?utf-8?B?d3pldFo3bTFhODVzVTlteU0xeENjSmpYWDJPN2k3Slh3UGVQMzZWdnNId2xx?=
 =?utf-8?B?eDhMREdBOUI5Z0FtL3N1bnV2OHpYNG1hdW1kMytDZG9KZGxoODJSQm5qcjVl?=
 =?utf-8?B?Nzg3TGlSZXc0ZlBZQWVrV2NpVzRkTjR3T2wzL3NxZlhJNFRZYkI2Nm82aHFt?=
 =?utf-8?B?R2l0QkNVSWdvY3ZTL1Y5cnVxTlJNanBOcDRZVGcxV2JNRTVKcm5idE80dmdH?=
 =?utf-8?B?eUdWbHJCUDhmYW4zMUxDVmM1R2lScFlENnQwdkZCUTViTnVXOFdZQ1YvWi9V?=
 =?utf-8?B?Qlhtc2ZmaUZPYS9MZ3NCN1k3Ujd4clM4aDJxYSt3ZUxydTVZRzVheEcrb0cv?=
 =?utf-8?B?Z2hjZ2ZZQUVxV3VDQkZ4SHk2SGN0SU5tT0tkbWJPSGdOZEVHVzMzM1pNYitx?=
 =?utf-8?B?S09tYTUxd3JUUG9GdGEzRHdzVENkc0U2Mm1uUnpXeklHNWhmZFJPd29vM1FN?=
 =?utf-8?B?ZWxmU29QdjdTU0xRbEZOZ1grVmp6QmRGMGx6d3E3QzdiT2hJYlN0bjZ6bDEr?=
 =?utf-8?Q?fRj2cjKI/epQo?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8644.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11192
X-CodeTwo-MessageID: 1a5099c5-1af3-4ff6-9cec-94c8fa0fe161.20250311093229@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a50e3c2a-d8ee-4656-96a5-08dd607fa10d
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|14060799003|36860700013|1800799024|35042699022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YS96ajkxUWZHOFpMM0NwOXBBaXZuTmYvblpINnNCOXJHS2dzdnFFQS9zK21p?=
 =?utf-8?B?WVd4UmJNcmk0c1dTZnpqUDZObmNYOEZ1YjJqNXY3aGluV0F2aXFQbjlXZktL?=
 =?utf-8?B?MVBocmhXRTcyQTh5cWtzUE1NaFNOVExKNU9aU0dudTloeFhQYkp4K2UzZHpO?=
 =?utf-8?B?dzYzWGNucjRIQm04ZWQyQVFSNmZMVHZQd29ZVlZpbUp4U3o1SlNjZzBCWldB?=
 =?utf-8?B?SDM2Nks4T0pFZG81T1NzZ0JhQ2tmaWZ5UlNVRTJDeDJScS9HbnNmTDNEcy9z?=
 =?utf-8?B?TUk4WmVuSjErVUVCZjdnTHpzKzczVVVZMEhtR1l3aWdGbkRXckZ3dFdOK3pX?=
 =?utf-8?B?bEp5eUkxaG9CUG5uNkdIMzJPbkdsdTg0MkVvM0FBZHJYMStiV3BadHdKREk0?=
 =?utf-8?B?dnN4SEpXcU9GYlo0Zkx0SGZ0UitoWld2TjNEYUduMDZzblRNdm1UeE9zcjBr?=
 =?utf-8?B?YkNKNnR4V09MbVhJaU5oaXZ5N2pnT0FoaCtTNWw3cGw3SkdJUkdKcGRUb0Zu?=
 =?utf-8?B?ckJ4Q1E5OXJ6YXE2SnUyK2Nua0xDQmZtVTVjdjZWMlI0eFl4N0wzK0FJR2VU?=
 =?utf-8?B?Z0JaMFAzQU1HZDl2R2hORm9oRno5cmhHMUxqUktEd1dBRFNGVU9Zcy9yNXpK?=
 =?utf-8?B?anRvWWFWSk94QXFLcnV6T2NuaGN0MmNYWHBwNmRCeGhuSlFoR21zYU5CNEkv?=
 =?utf-8?B?RjJ0aUdXT1E4RXJ2TVZHSkZ5VlpSaVg1TFZKa3A4cDhKMWRrWWp2czN5bTZh?=
 =?utf-8?B?WHowaVJwREN1bTNDdWlBMXhLWWhtWVFxZWI3Y3hFQmo4cTAvNFl1Wi9xSDhl?=
 =?utf-8?B?ZWo0RXBEOEJUaGs3U3BWRGM4VmFoSWE1MFNHT1VyNVEwb1MwUUxHdlF1QWJM?=
 =?utf-8?B?SU4yT1NqQnpWQS93YUFiUFpyZHpOTFpDZzNIaFJwWWd2UW5PU2V6WTM5RnBE?=
 =?utf-8?B?Vi9EL2sza3paSUxsNzU3NEI5ME5PUWowaVR2VWExRXpSWGZXUkdIRVUvNi9B?=
 =?utf-8?B?Q3kySHZ5aFR5VHB6c1o0ZHRoM0c3ek5VU1JmVm55R2tiN3VUQ3UzK2VPWVYy?=
 =?utf-8?B?SFIrY2owZUNiRDlSVGJqa0YvK1d2cFZHcWNlQkxOMWxIQ2xGL2l0SEMraEdP?=
 =?utf-8?B?VHBtd3QzbW1iNWFQVVpJelRPTU5rbXpWV2NsN2ZSZVgxQ3hVYmg5QTFTRnlk?=
 =?utf-8?B?ck1TS2hpQVJsOXVrR01lRHQzc1M3c2NmV3ZDdVovRElyRHJVbHFVWWtPTFJZ?=
 =?utf-8?B?SnlTN2VqSzcwNCsvbGlKQklTbDl0MEVkRW1IZnFidUlxN1U2NG1zNW1FcVZz?=
 =?utf-8?B?bEFJOTRwMHRHYjhIYTRrdzlTSmtyYldnMURuMXBEZVAxNTdrZVdIZGxTVUZs?=
 =?utf-8?B?VUZ1THFCUXdpdGNTdnA2R1dpMGQrMzhmN1FrZ29qcTQydEk1SWNxZTFsVW9R?=
 =?utf-8?B?c2lHd2JZNWo5LzF0allvQkQ4UUt3VUFUR0xFenMzQ1lqTnJ2aVc3WUNodi9v?=
 =?utf-8?B?Z0UxS2tOK2JBRlpkNjlIWFZzYTVOZXJ3VGVGcG9MNlVJU3YvdWM0cHRQWXBn?=
 =?utf-8?B?ckVIVDlSRk9UWWN0MWlWdHY0dDJrcUhNUUtQMUtkT2RqaVdqbGdoMTJQN1V5?=
 =?utf-8?B?blNRajB2Q3ZNQUYwa05TT0pvb3NFczJPQjVDNzlHWmIrUXRuYWxMZnhtYys3?=
 =?utf-8?B?T09tRHNReEtoODhMRmRMWC95NWVMdnBQaGFjS1MwejZlM0Y5bmxQZ2tDVzk1?=
 =?utf-8?B?OEt3VTAzUGZrZWpJVzMzZTF4TmFLM1BjSTdnbldaZEpPRk51a1ZWSGlWdjFF?=
 =?utf-8?B?enlEKzNON3YrWlpGdmNoQi9PUGs0SjZ6ZDVYSGhINmR0WTJtVUw1MHFSaVR3?=
 =?utf-8?B?NXJDN2VzMGtTVWxRVkZOK2YyYmR2emZ2VGRvbnRWQzA5cUU3NDB3U2J1dFJt?=
 =?utf-8?Q?3NdWa+xb34A=3D?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(14060799003)(36860700013)(1800799024)(35042699022);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 09:32:30.2892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b47b2f-e4e7-4be0-7bd5-08dd607fa51e
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10919
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

On 11-03-2025 09:03, Michal Simek wrote:
>
>
> On 3/11/25 08:01, Mike Looijmans wrote:
>> Allow config headers that include zynq-common.h to provide their own
>> (distro) boot strategies. This is implemented by skipping the section
>> when BOOT_ENV has already been defined.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>>
>> =C2=A0 include/configs/zynq-common.h | 6 ++++++
>> =C2=A0 1 file changed, 6 insertions(+)
>>
>> diff --git a/include/configs/zynq-common.h=20
>> b/include/configs/zynq-common.h
>> index 37c77aa1611..ad872c9d922 100644
>> --- a/include/configs/zynq-common.h
>> +++ b/include/configs/zynq-common.h
>> @@ -48,6 +48,9 @@
>> =C2=A0 #define BOOTENV
>> =C2=A0 #else
>> =C2=A0 +/* Only use this section if no BOOTENV has been configured yet *=
/
>> +#ifndef BOOTENV
>> +
>> =C2=A0 #ifdef CONFIG_CMD_MMC
>> =C2=A0 #define BOOT_TARGET_DEVICES_MMC(func) func(MMC, mmc, 0) func(MMC,=
=20
>> mmc, 1)
>> =C2=A0 #else
>> @@ -167,6 +170,9 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BOOT_TARGET_DEVICES_DHCP(func)
>> =C2=A0 =C2=A0 #include <config_distro_bootcmd.h>
>> +
>> +#endif /* BOOTENV */
>> +
>> =C2=A0 #endif /* CONFIG_XPL_BUILD */
>> =C2=A0 =C2=A0 /* Default environment */
>
> Why are you sending this again?

Sorry, forgot to mention. Sending it in a single batch shows why I want=20
this change... The first one got out because I forgot to say "-n" to=20
patman, but it was fine as it is, so I didn't recall it.



--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl



