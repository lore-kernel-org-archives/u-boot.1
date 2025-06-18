Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59E9C7115B
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 07:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 474A482D06;
	Wed, 18 Jun 2025 09:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LFTubT8t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDFB582CCE; Wed, 18 Jun 2025 09:30:27 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C848D82B18
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 09:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdr/qJwtFDx/DeFSMbBVNnmPWKVdY/DmqSVpjUVg2hkxK+SKaPjkEzKEwoUS/C0k1RxpZ23Htq8w097jYKMihMHjKBp2S4kG/564YzislSoADOk+HgP9G5StR5Yd4scIwJvav97vILeKdoOUuluuNkEHdA0aDETddAb6D7GNyPqoh1E/Lv9Qsq5GtOfrtwAGcM8VfavF5F+4wohBmS3GCSylYBLsnOLbSC/cxZzxFgo/HQfuEpN4ixhz6NH0jtuzXXr9Qthdw/+eVu365aoBBWu3bWYXIujfYosnKvkgzp2vdIMfKNzKj6AwyrhsX7ED/JDsW++MVp42wAppU3tUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTw0qivLUSVZTXmZHzv/MY8fGmg74Ow7WTHfyX4otck=;
 b=g/WPZrMUBRSQFsPv3RHn5DfWLsyjs6K43JHYujHyC/mObJUyXGa2wdayxWbqx1rwMi2IPEIhGaEMCmzVd4t4KgYmZokK5My8D3ejkToxC/w5en0DQHEwbguUMP9D60IVv1M7/8LhhReMHZLtlIU7iMC+KifAq+cKbqNu9KUWlRBABmaScxm9AvrrDnZua9dkkPM+i+wNdCEBAcLm2F523RhR+mrU/LqzHrY8lpo8YYXsV2mRa9G9Gzvyz8Kjr79X65C8hm2htBio99RYPGivuEbqfZPok2oM257a7SYisL278anonQTUM9c2rN4TihJ0GruZjjwDt1VRk0ZWN9LT+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTw0qivLUSVZTXmZHzv/MY8fGmg74Ow7WTHfyX4otck=;
 b=LFTubT8tT3l7Qtzs7+3ZTF9HVZQLfIQSY1ZaCkOyDqwLGFVRomilR5NrMuk3bkfnm+YSsRU3bAiSPTgn1huZPRDBavFgBnl8fi3BIrcaIAxkIKnpZYWQRPFRsRgS69Cp48PPdxn0PgL4YRt2wRBb1ts39Bown8/PpQTsR6LxssRtL2JxEL0MfhhWTO69jD7AO8N7hEgTskRA9ZR5MLFjl3GL8xpjKSjQN9zGQ7qlkWqhk/eY+NwAisbMui8HwtEKSnrF5MBJPbOmEJjxPq4AovZz/tlVmbjkIIvhaxRPemc/01vDu4YmojVa5Aw0NIK2RXZ6VK5pftch2uXZ2oYnpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS1PR04MB9408.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 18 Jun
 2025 07:30:24 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 07:30:24 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 18 Jun 2025 15:30:14 +0800
Subject: [PATCH v1 1/8] tools: imx8image: Fix the value passed to dcd_skip
 of build_container()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-binman-v1-1-373e66c7a51f@oss.nxp.com>
References: <20250618-binman-v1-0-373e66c7a51f@oss.nxp.com>
In-Reply-To: <20250618-binman-v1-0-373e66c7a51f@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de, Enric Balletbo i Serra <eballetb@redhat.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS1PR04MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae5d07b-52cc-4010-6d40-08ddae39fcc0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjlsSnFIZ0hETGN1dlNSRW11SHRjV25zZSsvdTdiZU42OE52bU1zcUZaS3hS?=
 =?utf-8?B?cWY1Rk40V1ZDUFlaMW1SSnIvcU5XR3BVMkd1cXdva1Fpclc5eHdaQ2NheE1W?=
 =?utf-8?B?Mm1tVmV6VnFsVkEyVjNic05Xc0x5N094M2RNNUF6Vkg5WHl4UHNqdXRHNGQ5?=
 =?utf-8?B?UXA5dFhPNVV2RXJTZ1VlV3JWRUNXdGFrUyswNlJCVVdHU1RoSld6K1ZTUzQz?=
 =?utf-8?B?dG5PNkg5WkgveXVqUDZEU0RBenI0eE9mZTIwWU1ZUUs1VFREeC9ic3FXdmdm?=
 =?utf-8?B?T20wQlpEUklWd2Y1Qm50TkZZZlJZblVGUTc1bmZCUFF3QmlCYjVKUHFUVmJz?=
 =?utf-8?B?OXR3dVhpWXFQbjRWaVdBdzVpb1p2Sjk2SzBJUnJiUVFlNjJoclA2UFhCcnZT?=
 =?utf-8?B?K3RCUGh4THZEOWwzd0t2OTYrbm1qUXd4YWZMN1lUaHpPNkpRcHpqbzhwVjdB?=
 =?utf-8?B?TEY4NDJsWXFpbkd0WEZoSjYzdVNrQmRxSWJqR3lWZlFVZ24zNm1ncXl1cnR2?=
 =?utf-8?B?Mk5iRDNHc3VOUjFaMWZpWjZCM3BMRWVNVEFZRDhNRitZQlA3UW5MWHVFSVpH?=
 =?utf-8?B?Wmg5bTdpa0dLdWZmdDcvNWVCa0dLSS96MStIaG4rVzRRWXR1amVMMExlRVBZ?=
 =?utf-8?B?T3dxamZUQUg3U0tPeFVlMTBsL0xEd3ZDYThzeXozUmQrYmVMRkNwaHJaQ0da?=
 =?utf-8?B?N004eUxIcjRIeGdFN1c2K1lVSVpSSWVnT0NxTm8zMlpEMUdTeWQ5VlQ2WTkx?=
 =?utf-8?B?OERCckNKTHc5ZGg1MlRFcW13cEFKdk1TcDFCNVVmeUNhbXU5UWdJa3cydnhj?=
 =?utf-8?B?ZWF2RVh6WWZXdXZkODFrVzVRb3UvYWt3M3JjU2J6R3BaUStWanhvTlpVeVZt?=
 =?utf-8?B?bmZQVGFlVDNtR3FiR1BUTkhyVTNOcUFxSlpBR2ZtR0xxTUZnVU95UWRrNklF?=
 =?utf-8?B?cmtERWNNKzF6b0tkZUk3NjdaWWFRRUNHazZVcnlBWnBZdlZTL01qa2FhN3Ew?=
 =?utf-8?B?R0twaGRWUGpndUZpVUJBZ2Q0eUZBamZ3MWVZOTdwbTFVN2h0eExKWVBFNGw5?=
 =?utf-8?B?bnY2aFRUMnAyMEppd2ZYN2ZQMmU4Uno2bHNDbGZZa2JTVFg5eHMxL3ZnQ0Rh?=
 =?utf-8?B?K2RPNExWSTVRT1NheTlEV1ErMCtIYkJSTzdMUGR2VDB6SzNrZ2YwZjZ5L1NQ?=
 =?utf-8?B?K0hwa2dTa1dQYUErNk5XQU5pZEVsY3F5UitYcGdFN01VQnFNT1RpNEtwV3ZK?=
 =?utf-8?B?R081REd0Y3pKODJwRGlOODAxazhYUzFUamhETUFKWFB2YWE2VStxaFFGQjZP?=
 =?utf-8?B?WDNSYlVQMGJTMmxSOG0zcmo2T25NSEttMFZNZEtlVjJUOGhhWHpzRHBsM0dh?=
 =?utf-8?B?OEJ0QUc4YVZ3OWk0ZkxSb2xNalVNS1Q3YlhIVGpndUNlZE1KV0traWl2MUZF?=
 =?utf-8?B?QS9GOXIzamdzdGNqVWhJaGtBY0Z2TWZsZVpRajczTFAxMVhHdkJiVXN0REp6?=
 =?utf-8?B?SU1QRk9hT1IxdG4rL2s2Z2VKOU9LaFhuRVViZ3U2bUFDZjRGdW5jZ1NuVmZB?=
 =?utf-8?B?WGRaOE5Ub3BoNlJjNmJpZllUQi9zaksvUFdtbW12S1k4WHVxemRiVkQ5eWlw?=
 =?utf-8?B?OGRyckxIekEwNjBDUWV6UHVOcWVxeW93VE1wN0FpbDlvWTIydHBHMFc0SkhM?=
 =?utf-8?B?bVorNE9XTjA3VU82ZWh4ZW5YMStTQmVLblRoWjB4ZUk5VkRnQlN0ODFYYVNS?=
 =?utf-8?B?WUVrNWhQUHkyb281dS9EYm95d3NnNUZyL1V1TStmRXc0anE5VlE3RWxnbVNT?=
 =?utf-8?B?YUFHQmFLVEJJY1lwTXEvNE5HdGhsUjVZdDZJZEFhdEdGR0s1OFZmMWVCMzRZ?=
 =?utf-8?B?YlVEb3dZZzdzS2Zub1hhb3hNYmQxUjBmNG1ScmRFeUd1M25uekFxMXRCZ3Z0?=
 =?utf-8?B?ZURQR3dONll5bUpVNkZoYlZuUDVWQWRWSWsrTFVrNmJaRFNJUTVlSSsrWnN4?=
 =?utf-8?B?NEYvRFZZWCt3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUVoZVFITVVaQkVsRkFGMlVHZ2JGT1FMUlMxR09aMU94S2R5SzREa2pjK3VT?=
 =?utf-8?B?aDN1NEtXVG9jVGhPQTJEaHVJVzBiL21pZU5ldjhZKzUyc1k4V0YzeWR0cGFk?=
 =?utf-8?B?UHE1ZkNtdmQveHdEUWMzYys0eTJ2dmVCVlJxOVN6WU9sZitBQjBSSHl2TmVX?=
 =?utf-8?B?Mm12azVTeFRaZjBraDNXQ0c5UFpNdUsyZGx1UFVsM2c5RmwwM2RQaVI3Q2M2?=
 =?utf-8?B?UmE1WDc0RjNJSEYwRXdHM3MybndNK0duRHQvWHlXcmdhcXFYbS9NTUplM0VV?=
 =?utf-8?B?ZGJ3NU9TcExTVmpmY2FvRkE2QWRZdEh3b1lIS0w1OGtiZy9TKzU3b2JJU0Zy?=
 =?utf-8?B?czJqcjVtWUxPRVlLb2hZQklxQng0TTRnQ1UrcXFadVNzZGd6VVVvYi91ZkdU?=
 =?utf-8?B?N2dSR2tTc0VJRXoycDJYZTFna0E5RjBWM3pDUTJkbjhyeGYrejZSZ3pVNkZ5?=
 =?utf-8?B?VGE3bDRFcnVRWWFPQXdaeHZ5dUttYmY3cFJvVzNwUmszN3VHYW1BNU9vbEcz?=
 =?utf-8?B?c2JRSjd5NUhKT0d2UFhvQy9ETG1MRzI3b05MWTIrWDhMVXdZNnFIWGFEbi81?=
 =?utf-8?B?TUt1ZE5SUno2cC93YU1VYjVHSDlMWnUrRG5XMEhndEF4bkZOellvSUNMVnFz?=
 =?utf-8?B?U2FEcG01TE1mc2dpVnQrLy9jdjZOM0VZL1JwMm1ReEtwVjFObGZpNHdZL0NY?=
 =?utf-8?B?eWtyeTJDY1p1U0I4SWlSZkJvR1ZrMDZMVjdCVkkzVlJ6cCszQlRHbTZacTVS?=
 =?utf-8?B?V1Y2UjFPdVlkUmFMc01DM1BxUHVqdHpHczJlV1BXc2pjQXFUb0RGVDIxK2NN?=
 =?utf-8?B?b1U2RFF6UjYvSDBBMTBUcFdDdVV5T20xNzhRRG1ER3VJblVrMWRna1pMdHdX?=
 =?utf-8?B?M3lsN0hGTFRuRFllOG5uTEFkeHp1QkpFTFVJVkttclhMSjYxV1FubVVPbTJk?=
 =?utf-8?B?ZkFweVpyWmp2b1VmZFJmZ013SEJneXk5ZllzQUg3S0Vva3lQZHBQcS9EVzRz?=
 =?utf-8?B?VHR1UUZ2ZzIwU1JDS0YyKzlNTFNDSUJabExXWFRPUHZGaEVDeWdiaTZWVG5K?=
 =?utf-8?B?VlJtS3dPNWwxdDVZSmVPYkYxUjVSbFpzQldwM2JtelRZeUFzYjB4aGxNbkxH?=
 =?utf-8?B?ZkVXOEU4QlNWTHpnaU03eGxqbWdQYTRDVDNMeEZsYTZ6M1dMTHhjanBwb3pk?=
 =?utf-8?B?WktXM01iTnl2c3ZzY3EvN3B1MzZTMERTYjkycHEvUVdvTmZNMnlNNUFQa1JX?=
 =?utf-8?B?d2VoVzg0SWkxRXJIL0Q4dVFXOG84N3pzOFRVNDlHWi93VTJhSSttamxrb2ZQ?=
 =?utf-8?B?VzBST1VaekpSQzVtNmVFYTh1OEdraE4vQnJjd3lBMFRBZmxvdG1mR1BNTFl4?=
 =?utf-8?B?UVlvcVFZdSs4eTV1Z2xjcDZhNWM5dVRzSU1aZTBsNkhOR005Q3pOdGdOVDl4?=
 =?utf-8?B?NnZNZkNHWC8rV2UrRTljUEY1Nk1lb3N5SzZoYVhxRGs0c2RUVzlCbTZoTUNY?=
 =?utf-8?B?bUNsN0hWVnI0QklaYjYyQVNWMnd0WkpIeTF5Y1dBLzRlOHpXSmp4anA3UTFK?=
 =?utf-8?B?cTlTajJSSldmcVlKNHZzam1SNDNtMkNTZ2s5Q1JNSWRjcVdVd09NUTBTSXpJ?=
 =?utf-8?B?Nmg4UVhGV28rMHA1VFlkMUFHV2ZocER5QmNIdGZnaklCaHdLaDdlS2xweXJO?=
 =?utf-8?B?czFCbHpFelNCZ09YU243S1dycTBqWUpRV1k4bmowZjdvNEJHaUFvNXVLT3BX?=
 =?utf-8?B?RkNJY1RQSXluYnFTd1BxdXFQV01IcWJyeGFWNUViNXNZcWo4ZjlWVVN6NEYw?=
 =?utf-8?B?QmdWTGEyWlJsQmRvT3J5NUorL1NpbUNHSkFDNURMQm1VV0RhNzlyK3V0VW53?=
 =?utf-8?B?NFZPMG5CaXJUempoVThPcExETE4rbmZsenpUVGlNTm9aVUpIOHVjbnFxM0F0?=
 =?utf-8?B?ajJlSnJhSFNJemV4dmh0K1lWQ2NwWGdjSlFSV0ZNTUUvaHdiMGRCbXM3KzJK?=
 =?utf-8?B?dzNWT0lxQWhFa3JIa1l1SU5zTU9lUGF2ejZXSGw4YURKRUZaZDJwR2ZBaXh4?=
 =?utf-8?B?WS90emhxK3R5S2lRWlE0UVFzVllnbUNzYUdsZ0hBN3NQL2MybVFMZFkzbG9z?=
 =?utf-8?Q?Rur3xhg9Al5oWyo0c348nJpYT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae5d07b-52cc-4010-6d40-08ddae39fcc0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 07:30:24.0208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQsVOmRFfovLZqXzC731yEVXikdGFLkf8texO7h4y5JjJvUj+CxadvSMOFScQeHlP49+yuhRhX3BGztsBBwGSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9408
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

The value passed to dcd_skip of build_container() should be obtained by
parsing .cfg file, and should not be fixed to false. For i.MX8QXP, dcd
data needs to be skipped, in which case dcd_skip should be true.

Fixes: 5f28a6599f01("tools: imx8image: add i.MX95 support")

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 tools/imx8image.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/imx8image.c b/tools/imx8image.c
index a333ded46e2..cad55fd3cf2 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -1146,7 +1146,7 @@ int imx8image_copy_image(int outfd, struct image_tool_params *mparams)
 	fprintf(stdout, "CONTAINER SW VERSION:\t0x%04x\n", sw_version);
 
 	build_container(soc, sector_size, emmc_fastboot,
-			img_sp, false, fuse_version, sw_version, outfd);
+			img_sp, dcd_skip, fuse_version, sw_version, outfd);
 
 	return 0;
 }

-- 
2.43.0

