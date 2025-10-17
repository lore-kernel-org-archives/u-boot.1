Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8D8CCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 12:41:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 867BD8386B;
	Fri, 17 Oct 2025 14:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EBH1O702";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F314283655; Fri, 17 Oct 2025 10:20:27 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F26D483631
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 10:20:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azYnPt+l4vQb/2bYG8xsd0rFR4U3TiOy5uaMvgzNCY5T2VY8kPs3vw+NxyLoNKkb9/RdP/F1tL/BmmFNVrHLwolKTyksMCUv6OkeBBIN1iT+cgI9t2D+R1BM+wKg1VYMw1h6+JeCBJjfdT19TVRLjJ6ZeGqagxYWqm1YEy5QL08UPh8GrDfhZLCOsmV3qcQkjTYtCa1x3HVEbEwCa9eLxPynrIKfD/ldPSS9aPooshI2DeVSwe1948MCRwR5SF5oqzXta4t5ZXiZWCX7okW++/dVaf5Eb6kgPTWNzpit47JSurI6ifwzqP47qLnv3k2I8YqXEbN4m4EGamqZwsh/UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dY6W7kJtTpG8DENLcxg7T6aEUFquX+GTXp40gUreCI8=;
 b=iRqnE3oIVNEClm5iGBOIJQYYsy8e5u2rjeupaVxN8lJXeVUKPA6hStdpHf6YZ54kI3+ig3wCm24ZuB9urrSteDFuaKE54/8l4SHdOd1NRbOqlWtBKXCfw69gu+jZsDz4U20JD490OvCA9UUw4vVI44jEZyvEsCAbNOftwJ8gvc0Mz2Cci3kAZuZ18ZoUH1aWbJIzv8H3tl2j/zle3bPX3VXwU/YY55uYfr7bY6u5GPtgF2xi6NLMRNv2RMvU2jHzah0scn90npRh5QQDw8KK2Xeyrw8igpF0rivz6CXfMKyzIRQITGDM2io0ud3UCWHbhj1TaHB0yYzhyzmfZy5cPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dY6W7kJtTpG8DENLcxg7T6aEUFquX+GTXp40gUreCI8=;
 b=EBH1O702481Z4ouEYPRP+bYbzw+LXbQrVhVIXcdHy7v226TlIYkLzSIb3fpAXLg3hUdlFVFXkakuwkpt7+xmyFnw8zrGxYHsHRDVKrGq5TEaolIJ+0RZkbEBuM8cP/CSQtxUbA4dvnDelIZxuOOw8kfFD5Wn7oPqjG7zuc9tEIEBlLFSQ3lrKUvho+uSRY+fUro6K6GPJHZzBSxoQkJSUonNPZsufGg4BLoyTP/5c5C2ASNl0dbs/DSzNSZgL/Ug0a8XCIJiXiwE/L7ChokqdEO4XuxzVXw3YUrCCXjqRQFNQm85NNF456fUHXO6D33mYKaWDbrn5M6G+4R/2QTIug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9988.eurprd04.prod.outlook.com (2603:10a6:102:38b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 08:20:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 08:20:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 17 Oct 2025 17:32:32 +0800
Subject: [PATCH 3/5] firmware: scmi: Support probe vendor ID 0x80 and 0x82
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-scmi-lmm-v1-3-9fd41e7a5ac0@nxp.com>
References: <20251017-scmi-lmm-v1-0-9fd41e7a5ac0@nxp.com>
In-Reply-To: <20251017-scmi-lmm-v1-0-9fd41e7a5ac0@nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>, 
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2P153CA0041.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::10)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9988:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4521a2-1a71-46a8-c054-08de0d56054f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V05RdStyWnZiQzNWYWkrK2Q1b1NxeFB4b09MZ2toSXBEVVA2eUJ5MU9RSno4?=
 =?utf-8?B?OGNlY0d1aGs4aldhQkRYSHk1NkZ5U3o0UzNsVE8xRlp3WnFhM0p2TjJnNHJ1?=
 =?utf-8?B?dTF1STZZTEpDbEViQkgxSW9NNGdTclFsckZ5eGh2SGo0SEEyN2tBb2hyR3lU?=
 =?utf-8?B?K2I0MzN4REc0VnQ3NEFNR3pUWUhwZW4zT3BlcVhrQktCc3lScmVEaVFsbUlh?=
 =?utf-8?B?Q3hqUVpmbnluZGZiUUtCWW5OR3Ywc0dmRm9tR1ljbDdGN2tqa0gzVWJQd2xG?=
 =?utf-8?B?dHptUDBsSnowUHpjTnlJZzdKVEprOFJvYlI5Rk9hemgwdnVOV2V2b0ZlR3dL?=
 =?utf-8?B?R1RDaEpaeDcxbm9UV2hxMElha1dyZDFTY0pNN3Q0Z3ZlVDVaeGNnRlBCR0NO?=
 =?utf-8?B?OHJzTUVuamhBSm9zZXZqU0gvdDJFa1BxRDRkaWhtWTRVMEgzQkY5TTZYd2wr?=
 =?utf-8?B?RmIvU0dXOSs1djZud1ZtRFZHbk90L2M4VGpkN0dPRVFLVWdiNXlyT2pqZUhj?=
 =?utf-8?B?a1JiS3NEMklldnVvbjd6aktlU1k4U3JZZEFCNGUxbFdXQ1Y1UlNxUjdzTmR0?=
 =?utf-8?B?WUR5cm4zN2lIMm5yZ1QxcWQvYVZnL0JhdFdsc3Ntd1VudmN1QkExSVFGUG51?=
 =?utf-8?B?MG10UjBwY3JjLzZ1L3lVSG9JQ040M2ZFQ3djZHF6Ymk0OHBJWHNGZ3krUkU1?=
 =?utf-8?B?aERYRFFmenNDWEt4bFA3bW5xc1haRkltOVhGOHBZNE5aMnJ2Qy9SbU1IUE9Y?=
 =?utf-8?B?VW1wemxLUEdlcGZWUUFLcUpPZDZDdzVmNTkrREw2cXI1NXRwVXczNFpaRFF4?=
 =?utf-8?B?VkxiSFZHemltKzBwaGpxT2k4ZXJRWHpkamppZHVmcFRkeWlrWVErQ240aTBP?=
 =?utf-8?B?YU9tUGVKSVRwbE53dVVaOHMwcTFwaEFKdHI4ZThacVF5VmgyQmNWK29oVklB?=
 =?utf-8?B?Nkp3S2tGdGVlb3BJbzVJeGppQlFyN1VYQTJHUlUrbFB1OGl1bG1tQXpsZngx?=
 =?utf-8?B?d3ozejA4dHdZN29rR3BTUm9EMnNDak42OXQrWk93azZCOFZCakFBVWZFc1Ju?=
 =?utf-8?B?ZlEwYXduL1ZXOEZkUEQ5aEd1YTJXQXZPSkpudGsrckFVcEJTNWplTTgxVlNW?=
 =?utf-8?B?TzZ3WE5hKzhJQVA0eXdEdlJONUlsTmluR2xQQjVOcjUwbTdud0ZmVmlzQ2oy?=
 =?utf-8?B?QWVwZlliT1NXbEJydE5id1VuOEhSMmM0a3ZhWjdWY0NHcGNhcnlMQkFna0RE?=
 =?utf-8?B?MVZoSy9HQXBsaFRvOWQ4bGJGU1pLUVVERDBvb2RZY252N2tSSkdQeFQxcXBD?=
 =?utf-8?B?YWwxYk44RG9kWURwMDlNTkNOU2VUbEs1VFV5bGNmdkJuWE5KYVlHT0ZLMWd6?=
 =?utf-8?B?UkhtUTNVNDVjSFIzYlNEeVlnTlQrdFo0UWRhMTI5NXBwWVhlcUorSUx5RFZT?=
 =?utf-8?B?Y3hRa1lRaFZEUisrV21acHd6Q2ROSVdrMDNiMk5YbGQxbHpkaGhXN3UxOVB6?=
 =?utf-8?B?cFM4Z3ZzZnRkZmptOTd4Y3RsL2hVK1RkWW5FdlhkWjJVMnRJdWMxQmlMd2Z1?=
 =?utf-8?B?bUErVy9MMWRvemVWRkl5UG55QTZSc1pac09KUnNOeWQyM20rN2o3OGIzVkNq?=
 =?utf-8?B?Rk1jdlBoV2tacFpXSmh0T3JEaUFVeSs2WEp5RWZ3TkZGSUVGSURUZE5IZ3JQ?=
 =?utf-8?B?WHR0YlZKWDBjOVZpUjdaSE5oQ01DREpNVVhTK3V2UnFJT1ZPSk9BMlZLNU14?=
 =?utf-8?B?TFFEdXo4ekh1djFEUFgxYVYzK05aZWw3aHhPdE1MR3h4eHRoejNYWFFuTWxR?=
 =?utf-8?B?bHpHNmozR01WMnZtS2F4UEdjdTBJbDEyRklmVXc1VGtsV1A1STF4L2d1U1JG?=
 =?utf-8?B?Z2h2cTVNdUpCaGU1MU8ybytpbnAxMnRobTZzUmw1RnJzdkZJODJvTjhzREZx?=
 =?utf-8?B?RC9zRnJnMmZRQ05tWm1SMlozVCtwaFZndnRaZjQ4RXZVaEhhVm5YaC9nbFpl?=
 =?utf-8?B?bGY3blRHbVd6bG9yZFMxd0lMaEZSeDJZV2VGRWVDZW1yamtVRi9YQWpMVnVR?=
 =?utf-8?Q?eUl7PD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXNOZGZCK2VSUHNLWUtWZG52OUd6RDMzVGpwa3NMWnVlYStrNGlSYlJsTElW?=
 =?utf-8?B?eEVmekdVeXAxWDhFQ3JETEp5YnpOTW1LaWpKUkpIOUJOczhhdW9ucGFFbE1F?=
 =?utf-8?B?LzBQZFJYb2FONmZmRW1xelJ0NmRsQ2xLMWc2ZXJWd094Q01kWVQ5bUsvM0Vq?=
 =?utf-8?B?OEdTOUozYkRNOHdIRjl0MWw5bFdMK0V6a25WcUFZQUtHOFVWK2YrbXVuNzNy?=
 =?utf-8?B?WjRNQVp3ZG5LRHM1RHFQVjZKdG9uNFNPandsOURJT3V5a1RUSHB0S2RoTVBh?=
 =?utf-8?B?RlRwMHNvNU4wUzVVVE9xWUU0N2RYWERYa3dIckZ1TmdZT1QvRzJjWTF6Rjdl?=
 =?utf-8?B?MlFROGoremFYR2xmWU1yRURpek8yRVRCcTlrcStVSkRHa1pRSlF5N1BPSVdG?=
 =?utf-8?B?aG1XWWs2ZTkzMnB1WGtwVjg0ZUFOWXAzZUN3VnRJN09xdjY0ZW44RlNBaDRw?=
 =?utf-8?B?OUp5U1gxSHRBU0Q0TC82c3FKYkVFTC8vZGI3WE83eEZkTVdQZWwxeXlsRWpN?=
 =?utf-8?B?a1R3SVhQYmxiMzhPNkJtbEN1N1lOL2xqbXJUeVQrdHk3TzNIeHA0Z254VlBN?=
 =?utf-8?B?bHlOcCtRLzFSQUlEOWNSdGtlNWRqYkNOekw0UlhOcDhFVlJBUFczaDMvbThE?=
 =?utf-8?B?MVJ4aEgvWXpITWovUU1OaHdMekdiKysvMlMwOXFwODFoUUxjU3FTaHZ0eXJW?=
 =?utf-8?B?SlA5TDg4RUxoN1luQzBqeEhuVGxtcnkxK2tyajVSQ3diNkRVNEhKakNFUDR5?=
 =?utf-8?B?ZmkwcWw0eDF6UG1NOWYvbVp0S3NMbWZ4dHJmTlpqVEZFbzFRa0lCWVdMdGFH?=
 =?utf-8?B?MmFOSEcwU0VEUlJ0QTBqS2pxTTYxS2tWQXR6ai9NTHVjcEJlQ3ZnR1lIT0gx?=
 =?utf-8?B?bXMrSDA5b095c3djMXVydFVaejZKRGdURjZhMkd4WnQ1VkpQdFYxVVB4ekxI?=
 =?utf-8?B?YTVxZmsvVUQ3czIrai9vUytxakg4R01lOWZkRElyTGJ5aGlzNVJpTjZqalV6?=
 =?utf-8?B?MGZ0Q2hLNklob3ZsRklHN1ZTNytOTFpnbDN4aFk4SnN1N0wvblR6b1lGZFFB?=
 =?utf-8?B?aWh5OFVzdHVMSEZzYmh3WUVvd1d3R3ZsbjFyM0h6ZnlGM3JlODIzZXVOZmlj?=
 =?utf-8?B?aHNmTnBKdk5obUVSY2w1SGJMbXkzMnhadnhoNlpkOFRoT2FETk43VkZaYVV4?=
 =?utf-8?B?ZG9FZ1BVUlMyd2kwcXdHS1BPVjlZZUtwWVNlSmx0a0Rhb3hHRksvejd5R3Qr?=
 =?utf-8?B?ckQyYVUzaXNsZDVOam05Y0Z5TnZ6NzN2b09EVnEwRVJPb0g4SHNiUXNQTDB5?=
 =?utf-8?B?UTVabUdKYUpSTHpya0dtZVNMdmMyWk85dzkxVWE3SVlqb2lOVWpHODdUdjJW?=
 =?utf-8?B?N2NRV3dBUXdiN0s1N3lyOHFlWmZmTy90THQ4ZEFhVnJjVmZGL1hZWHZpZXV1?=
 =?utf-8?B?dEgweUFjckVNMVBIaHJqTXJpTjFyMVRFdnlzazZzNnBESEpJNHJXcWYzM0lU?=
 =?utf-8?B?NDF3OVZTeXd2YXB1Y1l0YlhUZGdpWlFhYVYxQlppSmszcHJkVktSQmZ6TzdN?=
 =?utf-8?B?M0lSbWswY2hzS3F6c1VVY250dEFQMzJZODNXK3MzenpXZDVRWEU2Z2hLc011?=
 =?utf-8?B?QnNrbGxTRzEyM01palZ0QWlvaTA1eVZjYmVUOEE0RVVxKzR2NkJJZWM5cU1m?=
 =?utf-8?B?cGhNQ2RrazVCalF6ZUVUL1NGcDdlcTA2ODZZczhCR21Lc2RVVjNTVXB4U2NI?=
 =?utf-8?B?WEl1YVNxbDlaNkdqY29aRmx2cnJZdW5kbHMzcEltWGxUclhjbGExdHB6cGta?=
 =?utf-8?B?Mm5wbWxFRzUwNlZQKytMeUo3RG14VVhRR2d3R2NQOWVKMzF0Z1EzZ21QMXN3?=
 =?utf-8?B?Tlk0Qm1lSkVQQUZiNG5YT1F3ZXppQllHZkIxT0FMYlc3QlJuZHAwMVQzdy8v?=
 =?utf-8?B?cnA4WjdhNHBiUFZYUFJkdnR5QUJWbzlHcGUrbG5xTTdUOVdTNVFVQUU3bmxl?=
 =?utf-8?B?YWZNb3p4V1ZWOXVyVmRQck9zS1huRFBEQnQzNzcweC9Ha2NicGdONmU4SmxZ?=
 =?utf-8?B?dWhCZFI2dEhaWkdJMzFiRmR0TEx3QVRNWndsbEs3TXRZd1kyTnd3Z2tTY3FC?=
 =?utf-8?Q?YmqMjcp6NJZvO1lYNGbY1qsto?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4521a2-1a71-46a8-c054-08de0d56054f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:20:24.2165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMVpj50kj16UxBM59fiQBfmOPH7SCVPp/XsGqRvHZzpnjLH02L4ENh792Iq86xLunINJOlDLi1Ci4isEsexJFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9988
X-Mailman-Approved-At: Fri, 17 Oct 2025 14:40:46 +0200
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

Preparing to add i.MX LMM and CPU protocol driver, support probe SCMI
vendor ID 0x80(i.MX SCMI LMM ID) and 0x82(i.MX SCMI CPU ID). And use
Kconfig option to support conditional compilation.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/scmi/Kconfig             |  6 ++++++
 drivers/firmware/scmi/scmi_agent-uclass.c | 20 ++++++++++++++++++++
 include/scmi_agent-uclass.h               |  6 ++++++
 include/scmi_protocols.h                  |  2 ++
 4 files changed, 34 insertions(+)

diff --git a/drivers/firmware/scmi/Kconfig b/drivers/firmware/scmi/Kconfig
index 8cf85f0d7a12c9e58dc249539727081ec25dd7b3..dca8fed9bd25a0555233a7bead3a326ef2f05344 100644
--- a/drivers/firmware/scmi/Kconfig
+++ b/drivers/firmware/scmi/Kconfig
@@ -41,3 +41,9 @@ config SCMI_AGENT_OPTEE
 	help
 	  Enable the SCMI communication channel based on OP-TEE transport
 	  for compatible "linaro,scmi-optee".
+
+config SCMI_ID_VENDOR_80
+	bool
+
+config SCMI_ID_VENDOR_82
+	bool
diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index f48c2fdb27b16e0693eca6316d2ef6b27bc1eedf..ad825d66da2d04255330bfd2ece5645191158b12 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -110,6 +110,16 @@ struct udevice *scmi_get_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_PINCTRL:
 		proto = priv->pinctrl_dev;
 		break;
+#endif
+#if IS_ENABLED(CONFIG_SCMI_ID_VENDOR_80)
+	case SCMI_PROTOCOL_ID_VENDOR_80:
+		proto = priv->vendor_dev_80;
+		break;
+#endif
+#if IS_ENABLED(CONFIG_SCMI_ID_VENDOR_82)
+	case SCMI_PROTOCOL_ID_VENDOR_82:
+		proto = priv->vendor_dev_82;
+		break;
 #endif
 	default:
 		dev_err(dev, "Protocol not supported\n");
@@ -173,6 +183,16 @@ static int scmi_add_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_PINCTRL:
 		priv->pinctrl_dev = proto;
 		break;
+#endif
+#if IS_ENABLED(CONFIG_SCMI_ID_VENDOR_80)
+	case SCMI_PROTOCOL_ID_VENDOR_80:
+		priv->vendor_dev_80 = proto;
+		break;
+#endif
+#if IS_ENABLED(CONFIG_SCMI_ID_VENDOR_82)
+	case SCMI_PROTOCOL_ID_VENDOR_82:
+		priv->vendor_dev_82 = proto;
+		break;
 #endif
 	default:
 		dev_err(dev, "Protocol not supported\n");
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index ccedd42f3670c95376412f686c67d462e9740c06..9b36d3ae67bb37d58d70b41c1e7f767429fe51e6 100644
--- a/include/scmi_agent-uclass.h
+++ b/include/scmi_agent-uclass.h
@@ -55,6 +55,12 @@ struct scmi_agent_priv {
 #if IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI)
 	struct udevice *pinctrl_dev;
 #endif
+#if IS_ENABLED(CONFIG_SCMI_ID_VENDOR_80)
+	struct udevice *vendor_dev_80;
+#endif
+#if IS_ENABLED(CONFIG_SCMI_ID_VENDOR_82)
+	struct udevice *vendor_dev_82;
+#endif
 };
 
 static inline u32 scmi_version(struct udevice *dev)
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 5c9516d5595c2f39ee3223a6cffab2a91e1cd97e..bb74a57f79ae1bc22a2c673dfb5c4c768d350873 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -25,6 +25,8 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
 	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
+	SCMI_PROTOCOL_ID_VENDOR_80 = 0x80,
+	SCMI_PROTOCOL_ID_VENDOR_82 = 0x82,
 };
 
 enum scmi_status_code {

-- 
2.35.3

