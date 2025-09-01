Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC70CAC58E
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 23:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C68868334F;
	Thu, 11 Sep 2025 01:54:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QbTc5SkE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F974832F0; Thu, 11 Sep 2025 01:54:15 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D36F8331F
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 01:54:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6hRNCbqPnbxTde2EilItOZea/pBEiI/jdDPRxVqAI4LYArieUz/Ln0GXfzbO9lcBGM5/E0IAWQCnymMDvRVJKj4siw8huX6BlzMKNN4mMGpUT44dyQad5rWR7kEVF9usnliclk+/JzlPY6K8FzrKreKDEzoBDZOrc1Vvf9ehXdURkSRg7Rg6pzwX+JoiHt1G0o8KdriyLN2zQtF+yQuAqlwzL//wP89gyuNQfAUuAXPRNhwvO4j3hMkyXeuH9eDxYurL6QFK/IXAZzg/xgIa/GV26T1dWe62NtbO1pC9COMXXms2uQd0SNkBB9eopdfn5stj+3Gk7h7AE1Gil026A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cblFkktCfzXKIVW5MIHT9kz611Pu9FOMcZsfVEtsPgc=;
 b=L+FBL7VEqvekL16drIBerS23Wwk8CRQcfsmaROt5Roadd2a0Qgt6lleTMLgbOnGZBNdtEliy0EAL+GPmgOSEULf7dsh5Viw/aiNU5QnDIsRs9xGJYRxh0yC0FhjTmciFJWjr9VLxaJk+2jMX494gBV7xDAlB521HvFnapGyhDBjLVuGwoNL6V1DbrjHfFT7llQVyud0GrJJgScMPmB4jaYPvDgE2W1BG+EGyyUOcRSAERa6EswhNS1lo9IiVxpxLrpYxWdVDMfzcC9nehzwU76pmUL1KzXb2JOuTLXvFkEviFmazhmXDKg4AWQidXLvZTv9iuHV8rz65JPKfu5X0aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cblFkktCfzXKIVW5MIHT9kz611Pu9FOMcZsfVEtsPgc=;
 b=QbTc5SkEELeFaG8FmgwqftVuoLtIEGjF2XQNOluXhog6o2FpWfNsT3LsrKPRUVNnClcw2Uh3bNsQeeUlETToMWAcsbVvgSHjRlekUiy9YHYR8AWN7jOY126kiZqEdqmm1rbykWc+WWvv1etEn/aqvjZ+GuykEHM5jnBT8nTuDrEiuD/h2H439HZIb/2POhVxkRGgisnFGDsFoyl844A+xys5PHtN/dG+/B3SS9CwwRQ4mZxLQSxBJ5DMFgz+roder6HkEbF0DwBkFR+/4HAUbrNBCiEKZLO5MH+uuvg+RxkXtnljk7HmvX5g5HZ7U+D+iDOFWlXmx67r2xCYlMEJsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA2PR04MB10514.eurprd04.prod.outlook.com (2603:10a6:102:41e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 23:54:10 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 23:54:10 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 01 Sep 2025 18:48:06 +0800
Subject: [PATCH v1 7/8] imx: ele_ahab: Add i.MX94 support to
 display_life_cycle()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-imx94-v1-7-c85ae7cdd95c@oss.nxp.com>
References: <20250901-imx94-v1-0-c85ae7cdd95c@oss.nxp.com>
In-Reply-To: <20250901-imx94-v1-0-c85ae7cdd95c@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@oss.nxp.com>, 
 Ye Li <ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: MAXP287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::18) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA2PR04MB10514:EE_
X-MS-Office365-Filtering-Correlation-Id: eb41faae-5415-4682-5496-08ddf0c55626
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|1800799024|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjBOQXhYQ1NUWWFoUEpJUXRYNUl2bFlpWExDTkU0UGR5Y0h4SUh2OUd1TkRO?=
 =?utf-8?B?MGlUVmhXLzFyNHVnV054NUo1YXdIencvZ0I4REhBMWs3V01YSFJ6c0JTRUto?=
 =?utf-8?B?VDg1VkdtNzJnZGt3cSs0U2E3NkYwMlFNQnpCQ3ZHYlVXRjJkN1QwSUlpam1z?=
 =?utf-8?B?UE93SGd2UHpuTkIvS2J6dFpEVmk0R3VzeVhFT0RkMnNyT1A1RVRReVBLRVVJ?=
 =?utf-8?B?d2V5NmJldDJEMGJNS2JuQmNBeklpcnM4RGcrRGdQY042eEtiR2RDbWZrYmFx?=
 =?utf-8?B?YzRFYnpvaHR5VDNSNi9nRnIwOGRiZzNRck5oZzMrVkduanpqV0RKS3ZkbUh6?=
 =?utf-8?B?TVVVTW1EbjBUYnhGTEVOeTNZc1J4VXVlY2lXcjQwdEdjaXFZWnA0V2tkL3ZK?=
 =?utf-8?B?cGdqS2xHdE5ob3M1STdBbTRqV1F5NFdiZWxlN3huOHhMYXpyZDQ3cjFycFV3?=
 =?utf-8?B?ek9qWS9JelJjMnB1QzM5T0hpUkQvYnJBdDM3N0FzNnVxbXZGeFRCRlQvNkdH?=
 =?utf-8?B?V2laSjNtd3VVMGh3ZlNmSk5sbFZEaHB6NUllOUNYUmg2dURXVEJMOUdvU2lY?=
 =?utf-8?B?cUpvMkZmRTJ2UldyQis3eFRYMGgxZTZRaEt6NlR5MU55TmVEczdEdUJReGh2?=
 =?utf-8?B?YzNGVjVaaWhhMVhlN2pjZmtXclg5YUdCQlpDZXVsdE1zWDVrdUJnZDJNRkt0?=
 =?utf-8?B?K0Q5dmVXZWFMSkQ1NFhXZm9RMHFqRjZFYTVPQXlndStPdDRJSzlORlV2dGNM?=
 =?utf-8?B?MmhvSU9yMkdhNTZQWVZDck11NDQxQXBuNGk3QVIxbWVmU3hDMVpFdnBaZkVy?=
 =?utf-8?B?Nkl4T08zT3JhbFNXeFZwRU94aGR4ckhCT3BaZytTQVlPVnhjNVJDV2ZzV1p3?=
 =?utf-8?B?VHg5VXdRSEV6Q1p2c0dRRG52OWsrZ25TblNLRVBMcjZreGJWYjZuT084SnVu?=
 =?utf-8?B?Tm9mQ3dsejJuVzlvUmh2YW5KSEIxVStnTUsxTk5XKzUxZC9sQi9vcGdLOXVi?=
 =?utf-8?B?UWdQZ1RSdHd5MnJPT2Yyam41dUhlZTRZSzd3MjRmQWFUcHllcDNOVURBa2tJ?=
 =?utf-8?B?SkFrSzJBSEFyc05uV0pjbzlPK3lhdU9ZQkxJYWljL2VTSlNtMW91WmVuQUFM?=
 =?utf-8?B?Rno4THY3Z253Z3hyMU54dmtFcnkzdmgxM3l0eEU2SWRSZllwSmZScWUreXNB?=
 =?utf-8?B?SS9ERW5KZVpZcU4rU0d3R1lIR1VtY0F5dDR0eXMrT09CakdaejltODd2RmJq?=
 =?utf-8?B?VXBxODZRQWlJeDQ4emp4Rndmckt2TXk5VWh6VjFDemZ2T1l1RXFtczAzNHpk?=
 =?utf-8?B?UUMzWFZHWnlzeTlLdzVBYnc1S2k1STlKNTFJL2VTc1FqdUlLMFRlZ004RjZz?=
 =?utf-8?B?OTFsRmFVWTdOMG1VWkpKS29MVzM2MVdUWUtvMFpkMzNyZDFoL3A3NURtRHFa?=
 =?utf-8?B?ZDR0RGQ4TFh4eFFJVnM2em5telZKNW15Y2RZVUlyb2tjT0prM0J0NisrVzdI?=
 =?utf-8?B?TkNzMEZMWGdLdkpPWmNhR0RUUGkrbnRiK0w0N2VxRjF3NXBqNklpMHlOWk1U?=
 =?utf-8?B?NlVUREJoTmZKbTJ3TmV1NnRucWE5Yy9IblZ5M2IwYzFpWGNPR0dSZzQyNk5o?=
 =?utf-8?B?c1dGRCtIemlDb1czOUNnWjlsWmtTMnNlWUh1NFk5a0RtM3pKWmxvMlRkZnBy?=
 =?utf-8?B?Nkl1Vlg3OFhETjQ4MDd6ekNrdVlzK1FLSjVzOGQ3MmxLSFFUOUJvL2xteXhU?=
 =?utf-8?B?RkR1d0tBdjRLQzk0QjZsTjFpK0RkZi83ZnJyYTdPT25KTVhTc2xJUFJCVkw4?=
 =?utf-8?B?WXRYbm5nSnhtQi9WY3IzMkhSamxWTlltVGl3aWt0b092RDhVR0RXcm9ROTJ2?=
 =?utf-8?B?MnE3Qy92WDlMRUNrc3dtVTFRQ1JsZWlSbncxaHBYOHRGNnI3Y3F4dVN2UzRt?=
 =?utf-8?B?bVpjRkxnWlN4UFV0YURSMkhBSDhKY0cvQUtmVkxEMVBOZEtvMStLWHNNUXhW?=
 =?utf-8?Q?X2oebIQYlbBaphRaEZY4eQChndup04=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(1800799024)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDBXcklkczJtc05CWU1kaVFJV2RkS2JEWTFaTDl1RGptRW5YRmE1V1JPYWQv?=
 =?utf-8?B?RnFnVDdlVEcveklPKytCTXY5M3BPaDl6TjBZV3FJdXBHejYxUElaRG9CWFdE?=
 =?utf-8?B?R0FDMCtOWEpYNG5BV0xHUlNiVlNnZUcxZnlLS0ptcHl4VHVXMHVzVVJUb0lN?=
 =?utf-8?B?NFdJRjJ6c3o0N283RXpodU91dTZLWURjQi9WRFh0UytVQXJ4OHJxeitOZlNU?=
 =?utf-8?B?ZWRJQ0M3RzZKSXd5bGtDVGdaMGNjVEVCTGxvcjFEdmM4UGc5dEg0dzBERThq?=
 =?utf-8?B?MUdNbjFJNER3V2w5Vm5Dd0FRVnRnOHlHN2M3MHBtWGxKaDlqWWJ4MVJpQXhJ?=
 =?utf-8?B?cVQvaG1DbGpJci9PeHNFMVdKZERUODg2U0h4RHJPTDArQUVoMWFDWjEwZ3BU?=
 =?utf-8?B?a0IxRVRsVWFJZUc0bUk1QURYQ0FYNjQ2eU9BZ0RYNnJ3RWNjZzV3YVpkNjJR?=
 =?utf-8?B?dDZiWFo1TDN2bjZpY00xOXJtTXpRdW0zTHpzcGl6cVozcDQ4WjQ2UVN0TTFN?=
 =?utf-8?B?bDV2dkJTUTIvNi9TY0hvdy9sRThubmg4eUdqUFVGWEF4YWF3TFhaUEJidXZX?=
 =?utf-8?B?QXVqVG1JaHFRSnErbHhEOEtKeVJqQkk5a1pVQVNqWDV2eW5CM3pZTW1KZVFl?=
 =?utf-8?B?MEMva1FSaCswd21nOUc4TDd1dHFnVWJQcU1WV0pIUDF0Ym9OejVSbnE4MDVh?=
 =?utf-8?B?WkxPa2w2VGFIUk0rcFBsd1pGQm1VZktqbHdRYkhEYTlja3hmNlBrbUg2bGJV?=
 =?utf-8?B?MFcyckVlNHFWWkU1cjdld2xkR3Rxa2oyNVJqSXhnQWx1UFZKbTJWazREbFd1?=
 =?utf-8?B?OXB6OWtzMGlrb1ZTcXA5ZW1zQWI3K0xGeDZtR2tGKzBQbjBZWDhqanlPVEs5?=
 =?utf-8?B?OE1LWGVtOEdNRzdLdU5qL3E5QXJQWmFqaXl2R1o5WVJqNjRkM2NQRXdqaEZu?=
 =?utf-8?B?VkluTGdpc2hFd1crRkhrYzNycXNWNnBMSTRNU29TVzRBZVJhTTdIanI2RTkz?=
 =?utf-8?B?VkpIM2wvZDVtaHNubWkrS01IckRwbSt0Tzk1ZlRZYWFtN2phTXRXU05xV0g1?=
 =?utf-8?B?d2ZxYXJYNDhaRC9DTFFlb1plazMzc1AzRWdwZXMrNFZJVU81c3Y1dllWYWN2?=
 =?utf-8?B?VEJyUGdBbkliaTY1bVI0dlFham5mcXZLK21aYTdvd3djS3FJL1U0QTBzMVRR?=
 =?utf-8?B?RVdqL25SYVdkbzREUngzVDQvSEN6M053RUl5SkFKSktIcThsT0FkSkdZa2pn?=
 =?utf-8?B?ZUtNVGF0R3psbmwvZXkvMERGVk5sdzRtRW91QmZZK1BQcVMwZ2xJU21ZWVRZ?=
 =?utf-8?B?WFN2U3ZEd29ORnNrNGlQOWpjRUhJVlJuR2pKV1o3SUdsY2lPNktLTVYrTC9M?=
 =?utf-8?B?N1BvUmdmU3FJd1pyWVhXTHBYb2lZNUtpbUV3dTl0T2M1NklJU0hCc3A3elN1?=
 =?utf-8?B?dEpkNnhQdDhkaldoQXpQNnBBUUxvSVdodFJpeEU4NGZ2SmdzSlVLcEFwU3gv?=
 =?utf-8?B?eXRmeUtqaEFna1NyNW00YmoxNWEwZUF5V2FmeU1qSEMycThZR1IrcGFQY21x?=
 =?utf-8?B?VmFib3R5aGcvMm9ORElqZ2x4TTBJWm81bUhvWmJvMUZmMWxSeVRlRHEyTzB4?=
 =?utf-8?B?aElFc20rRlB0M09qRFUvWHhVSUxERC8vY0FxZjRyWStoUDdvc21FNnpjTWw1?=
 =?utf-8?B?MGg4VVZhY2dEL2JPaUVVWWFiZE1NaDNqYUsxZEQ4YnUzOHA5ZGlvQnJDNzc2?=
 =?utf-8?B?K3lETXdMS2dkemhUL2xzMmNFZnNqdC9OdHlPR3NSTU1vN29xakkvYlAzQXo1?=
 =?utf-8?B?RnV4Qi95VWhtNUpLcGkvcEJXSEhZME54UDlQWVNXbmlQK2NwZXZLOXIwUmpX?=
 =?utf-8?B?MWxUZGN2OXBEMzFscDdjUHlPTk1mRG4wczk0YjBrTUVOWnM0TzZpZHMvRFh2?=
 =?utf-8?B?THhIeVd5R0x4ZHl4Sm9PZUNPb0xpUER6aE9GaGxBbGlTT1V3WGQ4NU5KR2M1?=
 =?utf-8?B?VHNKY2VyQzJaSk03RGJReWN2b0JsWlpqbGxFMXl3TzNJSUtGeUZ5MDVqT1pi?=
 =?utf-8?B?cXVkUENka1pkeWhTMEwrSHJNYTdRV3dUeUFtS3pBUnlhUUdLRUsxd285Tlc2?=
 =?utf-8?Q?F4tIiFuJX5TmvpT3Tb3MjNGOR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb41faae-5415-4682-5496-08ddf0c55626
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 23:54:10.2415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxmgTljaOz58FZQZZu6bcJQPt71qNC1SQl34J+q5YxENt2v4HwkTqhzzo4YTsteSX9ybHo9/WnZbs72kf6hh4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10514
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

From: Ye Li <ye.li@nxp.com>

Extend display_life_cycle() to support i.MX94.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/ele_ahab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/ele_ahab.c b/arch/arm/mach-imx/ele_ahab.c
index 39aba65d29e..38e671e3935 100644
--- a/arch/arm/mach-imx/ele_ahab.c
+++ b/arch/arm/mach-imx/ele_ahab.c
@@ -411,7 +411,7 @@ static int do_authenticate(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
-#if IS_ENABLED(CONFIG_IMX95)
+#if IS_ENABLED(CONFIG_IMX95) || IS_ENABLED(CONFIG_IMX94)
 #define FSB_LC_OFFSET 0x414
 #define LC_OEM_OPEN 0x10
 static void display_life_cycle(u32 lc)

-- 
2.43.0

