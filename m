Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0767BCCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 10:23:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D663F83CEE;
	Fri,  7 Nov 2025 11:22:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Of+ZG+wz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A571783C6C; Fri,  7 Nov 2025 07:03:18 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C681E83C63
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 07:03:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMjNItw8iOD0JYu21GkI2IwAvzukBn/FlNQjZPtZLHnitm//l03uVKvTRPq1WtcCoaF7LhMlcoqjYkvBcsbdJ9+sTDwqOgFhBO9++GvuVkMMA1O+WBHwoRb/8roukr8rFkWMeAMho9vG0VrLc5BqKb2+bz4Tolw9kmncWWlPv3Cd4X8ac0FxAzm4yysoosKEv+0q9ry61vmXYAloxRcz/toxdGz7VbHiJw6znCvnwuiAT1LpZQJske0e+jdq4Px0/q0O6uEZImvY3WExCw8kIdoTt6nD77gxyETW9mwN9ZOMY91CrWyuemFBcsrRfaCx0t7nkNykpgby54/7G6AZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNWIAS0S1xAqD5G0lfFZiOQl6lq2y0Hx4dcHw6irmRM=;
 b=xFpeWjldMl/tL3rj3LYW6gTVGz9K9BVUEmWGPj8HMsIP526UTZ4IQVdrFBiy9B+ion0Jtw8lRkGLHw0yl9nuTdJrOPKUlRLrdfE+C2XV8mMw3wV1ApXWAFsn7l2J5ICnP74/gdW91PtCN3a7Cxy2iZfj5ydPdj9sB7aMOhYLiATGdAVcxosMtYPne56al18GNVOidAdDNwgIdGCY35OSgz+lJHjSX73BsepxQbkOR8bctDVSDNxxz84bfNdPjSasdV4ENGNHTomtAOox6OEW0+WHZMsvZ9B/ZzIh6LlweXSrU6/LCrniVU+CmBim+a8FjudeLCo48ymtSwq48Cj7aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNWIAS0S1xAqD5G0lfFZiOQl6lq2y0Hx4dcHw6irmRM=;
 b=Of+ZG+wz8Ti9NbPalyDHU+orx4FRhl4YNQCmQeqyjCrImmoweKTqm1/+ypi7ryorRfHlbD8fW9ZCQR48FBrnewPiuUO9thYh/9/NjvN/rIrRlkx3CWHXmoBwmAo5cxrTgWvD89AG24G8yLL3o6hZVhL50ol6Q7VwnUsJOl+gxDJ8sX6mZphnrXK3vouj8cd6lIYv4HzRo4zcDf+OPiITNE7LZIn/n3G4/Iw9fBoBbY5rbWCbUkKqb1VXIZXAxrE3gnpJVn+mjKu1LwbIlVRnxYp4VM+wVC0IKKqOO7R+WkjdgH4VhOHUxQ/RrqtWwlitkisCrTHl9WXnlgtvbMMv0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8497.eurprd04.prod.outlook.com (2603:10a6:20b:340::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 06:03:15 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 06:03:14 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: Re: [PATCH v2 1/4] clk: scmi: Bulk allocate all sub-driver instance
 data
Date: Fri,  7 Nov 2025 15:15:36 +0800
Message-ID: <176249967002.807421.14699532914305127275.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107030352.475169-1-marek.vasut+renesas@mailbox.org>
References: <20251107030352.475169-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: 1268f680-6079-4e42-2a62-08de1dc35644
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTU2RDhEYjdwZS8relJmSVJCK3dCelFEZVpyVE4vZXVIdXFMU3U3VVQ0VmZk?=
 =?utf-8?B?NzRFdjk4a3hqTUtxbXF2c3lwSmJhQ2R2dThacWVFTkpaWUhJbEZUVEw2U3pz?=
 =?utf-8?B?elFqeDBabWtGTXFRb3E1VTVSU3hJZDNiVDNYeEJpemlkZ1FiVDFQeDMzc3Vn?=
 =?utf-8?B?aHYxczBKUGpRVTJSaVJ4cGxBUnVFVzdxeXExYmVpS0hmYkJKTFVFMlhQS0xE?=
 =?utf-8?B?cGh1OUlGSkh6a2M0VzQvTm9qTlZHWTZoajdYQUpLbUxNUG4vbVdtMFdjejgx?=
 =?utf-8?B?NHdPMEplRTA3WkxNSHoyZldhT0s1dmF1enBUQndWZno2MmZkSjZlQnJBeFI2?=
 =?utf-8?B?WUh1UHNlTWVSSUtsRFVEeWdFUUhsWUdYRzBkSjdaM01ZNTZ0TDFzUmRiT0RY?=
 =?utf-8?B?ME5sYmdPTGdHL2ZqU3dyTW1RbWRpWkkwQXVsaVNJaUx0SWQwUGkrdnFCVTJX?=
 =?utf-8?B?WlVMYi9WT1FGcnArQlprMm1LcnRNaktVOWhvYjhKQm1hK1RJUXdlUFh4c2Ft?=
 =?utf-8?B?am9STmZveDQ1VlFyY0FtS2VFd2NLdXVYT0RPSTUvUEkzNGxTOVc5ZXFDOVkv?=
 =?utf-8?B?dDlkejVhU3ZtWXNMVGFGVXBlU1B2L3Q4OG5ycGZsLzZFUFRLcXp5RGMwVmZv?=
 =?utf-8?B?NEJ1RmllcTd5TTB2cWpnMkF6SEJWa0lWOGg5dVBpcWtUTmNrdlpVRUxKZ21Z?=
 =?utf-8?B?dURkcDA3anJSZE9oekhhbHRHd1cwNk42Z2g2Y2liYzVjbmU3bWhOL0xpTHFk?=
 =?utf-8?B?M2JqZlFGNXZwc3pPVWI0YnhjRmhYOE5nb0JwSERxU2c0Nk9Qd0g1dExPTkIy?=
 =?utf-8?B?MTV5TCtKbXRpOTRoWW1aY01sUnRhenk3bzlVNWNXcXUybmxYdExLNURveGdm?=
 =?utf-8?B?RC9mSVpBZCtEa2FhSnMzSU5CZ1BSR0g0ZEZkdUswbG9aQUNPREhicXY0NUFE?=
 =?utf-8?B?R0FxanFtSVRsNG9UN0tCaTBmZTYxM08remt5YUFQM2VKZFFaOWpyTHN2S2pI?=
 =?utf-8?B?azgzL0VMQXdMWXZPNGhsQ1FPRW1waVRGcTcvbWgramhTc2ZKMnlwNXY1b0R0?=
 =?utf-8?B?dkVncTgyYlBuSjd4VmordHJzRVF6cXU2Vmk5d1hJaDJ4cFBhbzVZSnQ1ODg4?=
 =?utf-8?B?Rm1TbGY3cVJ0UytPc1NudkVmM3E0Wm1SN2VGY3hpZ2NSVHVGNERueVBNVjBp?=
 =?utf-8?B?eFV3aDJ3RjJQeFdLaWdQSlRnRjNDNnNiOTFuOURFT1lVRmIzdzYrMGRWVUZG?=
 =?utf-8?B?UGtLcWs2OHNaMCt0RUU4elB6cmVjMFhSNVZaWnA5YnRrcm9rRTgwN2VjbmhE?=
 =?utf-8?B?Rm9CL2toTUl6Mmhpb3BPRUxDT0ViWExiR1BpZjdheW9QaUd6ODEzS2Q2NWpr?=
 =?utf-8?B?emlmRURETE0xV3FzM01URHVKOC9SVnpmWUpocEQ0NnN1WTRXOElaZ3phYnhU?=
 =?utf-8?B?TjVCbjI1Y043dGNWWHdZMnJ0eWs5ZnVUTUdDMjdhRmIwQWMzc2dHNWRFWDlp?=
 =?utf-8?B?WG9XMWVnUmI4Y3MwMHMzNWpNZjBiMFRSbU5LejIwa3FaN1I1elBuV1NYV2Jm?=
 =?utf-8?B?NkdvRExRUjFuTEQ2ZGN6RnZ1T011c052cC9GTkZrUFVyakZYZEsxSnNzY3h0?=
 =?utf-8?B?YmRKaVdlTkxNaXB0Q0dIeXpEYnJ5T2RWQzF1RE1yeEpJNmRLUHZ4UU16MW1J?=
 =?utf-8?B?dmNiS0FmdytaeFhqVE9DdzJCeGV5K2dQcjF3RnZ3SFhiekQ1OURSMWZ5RDdz?=
 =?utf-8?B?cmphNlc4Y0pkanNNWG9HS1FnVjgzbHRrWmROeEJmbC94TENqMFhDN1FEd1ZH?=
 =?utf-8?B?bXhuQUhveGNrcTJ5V09PdkZ3K2hnSWtSSm1rVVBjYnZnUHhFTTRsVWIrZUdp?=
 =?utf-8?B?b005dFFWVitoUHNCZ2hoZEVZT0k0bW85b044dzhheWsrL2hDU1pha21wWHlq?=
 =?utf-8?B?bDNrR3loQmxoN2wxRFArZGNpVUh3cVlYUldRSmxCRWdaSmUrcTQ4YTV5cHBH?=
 =?utf-8?B?UXMvUXpmV0NZdk1yUVhJUDdKdHNpK1U3dG9VNG1hVUoyMnJ1bStqejRrUzhJ?=
 =?utf-8?Q?7GIM/O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3dsaFZMdGZrMThMaHB6cG1VOWU0WW1GVUJKaytZSExoUHFISWtrQjh6L1lu?=
 =?utf-8?B?dnVqNXRyTWdpc3V2dHR2STFjbzRUaTNIWXEzV2VSUy9FQUN2NjNHN3FGTUZG?=
 =?utf-8?B?czMxRDlxd1IxRUZpcHBJZlpnQVpzVmp2V3YxMWFLWXdVVWF5R3VrQ1JsT3pt?=
 =?utf-8?B?OHRHTFVudSsvRHJXbFlweE5wMWNyemFjeHB4RXdEZTQzb1pZM2FCV1F6K2dl?=
 =?utf-8?B?NkxKYmdSalg4bWVsaWpUNlZKbUVhckxFR3QrYy9nQlZyYlpuVWdlL1hzWkI4?=
 =?utf-8?B?b2VhUFhyTUFqQ0lsWXUwNkNlTUhQa0xYUXpqWVlRU0xCRk1ZUzlzLzR2alNE?=
 =?utf-8?B?SVFsN1RQM1NMUUhXVUFzVG03dTg5aUcxQSt4ajZWN25lc0RMdld6K2dYRlNx?=
 =?utf-8?B?c3hjU3VQU2RVU29Tc0J4b1NyU1hhRjhQczVKLzI3Z3ZVZnB0U1ZaVjR3YXR6?=
 =?utf-8?B?b2NnWXU0c0gyb1V6Zy9VbjFqRFlMUC83cXdsZXNnSmxzQmxwd0JNaDBNZ1Zj?=
 =?utf-8?B?dHQyUjJwVlFHYTdFb3NlNjh6YzZSekEvSUE2Q0l3Z3g4dEo0dVlyZTl5WG4r?=
 =?utf-8?B?aFhmdXBNbURPdCtjZS9vRnlyd3R6eFZVQWpoZVZQWUJVUkZXd3hadjNGZjBu?=
 =?utf-8?B?Z1hSUFRSaFNyUUNlWTVubkRVelRrYjk5TTRyUUJSYnNqK1lxQnNwditJZDIy?=
 =?utf-8?B?N1k2Q3VDakVpSTdYQVNyWEtHaW1rNHhYK2daemg0S2pmU2ZoTHgzSm44UFdQ?=
 =?utf-8?B?MHlXTEJQWGMwWmNSRFMrNW5oeHpYWVpvcFl3SXlMcVhoRjJnNWVNd0pnam43?=
 =?utf-8?B?VVNtUnVwNlU3enJ2TjkrNUJzNTBKdm5nV2UyYW1GVHpLK2tCVy9XeE9HS3pq?=
 =?utf-8?B?eHI1WHhuWHR3aUhRTEpBSGJxVEdXREhPQ1h3K0FkWlNNNlJPNGp3Njd5Qll0?=
 =?utf-8?B?Z1gybTlVYkpZWTQ0cXJCbWs1SmRKMUREYVFkUkxWeUtJV05GQmQvWnJBakdO?=
 =?utf-8?B?VTIwUEZxL0xheGx5Wk5xR200R2JBZ01wS0J3Um0zYnBiMXZ0MjBWSFVpZjMy?=
 =?utf-8?B?cjFrNjBlaWhMRmQzeGpCYkJoOGdFS1BVR3lUODJJMVV4UmhqTFFobUxaaVl4?=
 =?utf-8?B?T01nRTJlZTUyT3plRWF6bk11RTR2U0JUSWdDUHdEWEo5M2swemNaOXRrZmcr?=
 =?utf-8?B?Qmx3U2ZPZ1VpNDFoNWcrMVprRDhHYVdrZVRqemNMQlRkZlljS3BJMUNYaE54?=
 =?utf-8?B?dm9UWjBwS0RjUE1Ka1c2eFdFRkFiSG9FZ0krZHNWWmdJcGgyclZLdzlPZ1FV?=
 =?utf-8?B?L0lzbzByckszUEUzazlDeWNkd0N1d2U3MitFcm1GdmEya2NNeGtQcW9aMUlD?=
 =?utf-8?B?UGVwR3Q2OTJUdlJCNjU3dEdGWFhNRUM2dnl6cGU4dG5Td1BlTDRSaGEvOFJk?=
 =?utf-8?B?NnNDU0JOTW5hU2NXYUxFOGZXWEk4MmxXcEg4V1Vlbi8zSjZVVFlrR3NTMGtJ?=
 =?utf-8?B?MzU5ZGZ4c3A1YXhPQ0FueU5PN21rYkhNcDdFUVU5aTNvTWxUd1pFS0ticDRR?=
 =?utf-8?B?bTM4ZkhYaGRSQzcxeUh5Z2hQRmt5WEovc20xQzQrWmdLUGQ1Uk9KVGU1YXd2?=
 =?utf-8?B?MzZCaW1LSFE5Ky95S1hOb2dHTmswbUdNNjFnMmh5Rkp0NEp1MTdKVno1SnMv?=
 =?utf-8?B?TncrdjlVVi8wUHZMb0xzSW1ORG8zNFVRL2pzVVAxVVM1eXFEWXp5TTNCZGpy?=
 =?utf-8?B?aDhKTFdTK2ZlcDlic1kyemhXRmJNNUNnNElYOHRLRjl0Wnk4NGR4MWRabko1?=
 =?utf-8?B?UExtWGc0RlFMaU8zYkJxdU5Oc2gvN0dUQ1J5Z0Z4U0dmS294R1BxbXUzK1BR?=
 =?utf-8?B?QzB0NDViL1RWbkVJQ1R5MDJUemJkb2l0Y2gzdGRWVVAyRDRIckdabWNSK09U?=
 =?utf-8?B?NHozTVplV2lnSjVLOE5Idk1PT1JaMXRZUTlQaTdKYUY2dmZGWGhVNGVsM1Fr?=
 =?utf-8?B?bVZIMzNxZHdHbnlzMGNqMEI5TE1Md2FuR2NOaHBpL2ozNVAva3FIMWUxNHFa?=
 =?utf-8?B?RG52NXBQTUtVZnZMMElVTXVMTkZFZE5PalNVQ2tUd1RyTmhUTk1KemROdks2?=
 =?utf-8?Q?QO8iN4228q4zGHo5ChlYct+cw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1268f680-6079-4e42-2a62-08de1dc35644
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 06:03:13.9687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLd3IwcbEQPqlbA/u0HFMzwyBdumKW7DQCi1mM/OhU/6MYEIEU4kndL2wcWhue4DIxVER3OV/e/3zVhZfOaXZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8497
X-Mailman-Approved-At: Fri, 07 Nov 2025 11:22:57 +0100
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

From: Peng Fan <peng.fan@nxp.com>


On Fri, 07 Nov 2025 04:01:23 +0100, Marek Vasut wrote:
> Allocate all sub-driver instance data at once. The amount of data that
> have to be allocated is known up front, so is the size of the data, so
> there is no need to call malloc() in a loop, mallocate all data at once.
> 
> The upside is, less heap fragmentation and fewer malloc() calls overall,
> and a faster boot time.
> 
> [...]

Applied to fsl-qoriq
ext, thanks!

[1/4] clk: scmi: Bulk allocate all sub-driver instance data
      commit: e8c2051fdc8bc3f59d36b614c3d6a1da04520d9d
[2/4] clk: scmi: Factor out clock control flags resolution
      commit: 624de0d04ae479d59b3061cf93ab77cc06cb2c86
[3/4] clk: scmi: Postpone clock name resolution
      commit: 88b89eaed86d9ba23b440b8a91b69925d74fa6fc
[4/4] clk: scmi: Defer issue of SCMI_CLOCK_ATTRIBUTES
      commit: 3ea7acae0d9cf73729cb0fad0056e519d3a2267c

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
