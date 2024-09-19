Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5D1CDD563
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 00:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 481E789072;
	Thu, 19 Sep 2024 02:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="o0d75guG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5354E89063; Thu, 19 Sep 2024 02:15:04 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34D568904E
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 02:15:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Alct/oW3BN0JI75HFT6VpW8qV3d+3JFarMQvGaHYv9eX/0RjBd5WuHlw8AdnkGXK/LSAvn5KxLYKVGvpqvAWdAeUPjHRdKz94SB8cysz+3zKW/CvVgYuVxoIDW7edZesw1YCZzhMH+8aC8o4muKha9i/gs/7WU6eZYqxcX5oG6+rH09+jAnzyFT2Q2L9tcQH0waOULnvfHTrM6Xvi2caCjS/8ZFp3l+Q4ELLYWBf/lULocsd/5lFqdKw3KSis6KEHkR771SrdX9L5z35wUyPRigOL7zRdUYgNHLbBZDvTYX5ydT0AWu9lAOqdCteAeP0nEJcP/KR/O0jarbhxynngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtzeKUxJNUMqkajb9LCxeEeI3g3OrEEp5gG1NIFVS8g=;
 b=BQjU8cEuurP9HUlx9OJvqOubmcI/5IK5sWAsi2kzsu7lVjBtDs3LY+CVI0xEkqlTW8xbEwYaGPwQPJz3sY5hMGihVroN8TqSMrcscWF6XxO4BjfC0J8yQvACAIgtuSQhRRe8wC7oIblr0MKDQRXodZzZoZzSD3Uw8QpfPkW/oyNSwohM0VGR0I/ihMiP0QS02j8JgwOr7F1WSB90+TlZQH2+h1HiG0MW2bPUyFQ5aPkt/wEXpjTntZccr13owttsaXc646Fn/MhkcwJ0IxOSghDGiQu7rtjPuSgsYn5Mi5sDbPDZ7Ts8KxW++dks8wRYG7X90weCp5yXwkmdD4vy/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtzeKUxJNUMqkajb9LCxeEeI3g3OrEEp5gG1NIFVS8g=;
 b=o0d75guGGmlUFfFZOW9KA7hqkZAtVE4Etb049XLMXwv37BiaJNIbZnkD7cuaJaaKtO16Ks/K1kNdhAlRk+D2eF5gG09PQ8Qf0QxvH+jHCkCUQKRDP7N8mn/yyEAcsu5LH0pnUlN/6yMwsMqxzLjut+si8hP537yDhGNk9rkPQV2YDezz4pfS6tCxAgPgG5U7aWRu7CfOSiGwvGArq5t+YFxkyWPei9cDX3SFyHT58j0HrZHuXWO/LOs6wb3lnbZVrh+ck4x+j9Cj+GtfnGkTeke9KXqwE7/fwZnSREkFz9pCU2ADEh8pmOfWZdOSgWfaboWfj+3du6WjFYOSLJUavQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB9066.eurprd04.prod.outlook.com (2603:10a6:10:2f1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 00:14:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 00:14:59 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 09:18:07 +0800
Subject: [PATCH v2 08/21] imx9: soc: Add function to get target voltage
 mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v2-8-0d798d9e08ad@nxp.com>
References: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
In-Reply-To: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: 85891f64-4d67-4e04-e7bb-08dcd8401937
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blNWV3YxNkZlcnN1WnlPaVRqekFOZmJoRk9yTkJXZzBrRE5xNGMzQXc3YThK?=
 =?utf-8?B?NGdTbmR6ZG5Kb0UydFNoQXgyZmVZUWFVRGJwUDVwMGk0Rm9CUi9lUDNzd1Uv?=
 =?utf-8?B?ekFsYm9BRXhiZmV0YlhXellnSDFweHZMVCt1T1F2Y09hRE05N1FnUmdpZ1dq?=
 =?utf-8?B?Vkh5U1FSR1Z1VDA0RXd0ZVRiSkJwVVV3RTVyZzh6T3JWcldoc2tnanRzL0FV?=
 =?utf-8?B?UGNsa2NodVZvSnMwRjhzL1VjN2VCT2QxcXZnNmhUZjNOMmg2N2ZLMmduNGhF?=
 =?utf-8?B?ZVlMd2JiU09IMzlqa2YvM1Jab2J0TXpkSVIrVXZ3WUhnS2JWWGxmaTBVYVVj?=
 =?utf-8?B?Mk1QNkU0U0dNSzhPQ2QvdHp6dHh0NVBXSmhwMlNwSzFuanUyU0tQd0NtR05B?=
 =?utf-8?B?VXZIWjNCL2IwQmxnV0Y2MmNWWlVBVHAyaThmbDdLTVpyOW10TnRIdzdWWkRV?=
 =?utf-8?B?cWZQVGlQRUVkYk55WEx2Nm92VWZTYmNGaGhmRFBGYVhTeUVaMUNsaC9FL0F4?=
 =?utf-8?B?cFBiTld2Z0dkcEEzMlNKZFdFU0lrOEhrZjBPTkQ3YzlzUU5wei9ocGljN0NE?=
 =?utf-8?B?ai9NV2UyZ0tMV1Nla1ZJY0FqZk9jSFI0U3Y2TmlEb2RoRiszdUV4djhKNjJC?=
 =?utf-8?B?akNJRGVnQm0xVDRTZUg1OUJ4bk1SMDY3RzFmdUg0a3EvWVhPTEZTaGRHUTBG?=
 =?utf-8?B?anZTbTNUa3FRS3BWSWExcUxzdTUzbURVMVFnTlVXcTZtYjcvQ0sxTVJIV0Rz?=
 =?utf-8?B?b2dmOWNxV3JkZUVIUCt4RUF3TzJNWU8zMzdLamdBbmI4aXpGelNRY3YwWW53?=
 =?utf-8?B?c3ZGVnRtQzJlTkpYaEFpcHNOR0RSSTduL1V0YktrcEJOaDJpaUloeEI2VktR?=
 =?utf-8?B?dzNXbStPNFhQYTR3TXpNUXFwMHI4Q2RlWUVOd0hCMWRiTGNWK2Q2c3J5TjBk?=
 =?utf-8?B?NzFNVVJhd2R5bW1LNERUdWtqaTc1TGhqVlZjcVYxNVUrRE9JM0tJNkkzQjBp?=
 =?utf-8?B?eFpiRGdrRWpaUFBYT01yczYwZ0pqeTZsYXFyVkVNS1ZjUzY2dnR2OGc4NXl3?=
 =?utf-8?B?SXkzeGlTcVNxSjVqb2NzOWlXK3ZJM09SeFZWNEpzWU9mTDZlcmtqdG9FcmZD?=
 =?utf-8?B?R3R0QlFha0hjL1h1SHNNNHJXSTNZc2Y1MW1jSlVtRUQxQ3diQzUwV0NMS3pv?=
 =?utf-8?B?ZVpBVEE3c04xRkQyR0dzbFQ1cUhwMVlvRmNmNG4xQ0V0RjMzNjJpcHhaRFZ4?=
 =?utf-8?B?cVVxTFVva2RUZjdPZWdwZnc0WWx6Q2pBNDA2a1dySzFSQldFeUpPVno2Q0dH?=
 =?utf-8?B?NGkwV1ZZdHlkMFBWNlJGTFhsT1B3T3Q0OG9OM1BNclYrQmhxSTBMMURGOVd0?=
 =?utf-8?B?K0Fsc0pLUFI1MWI5ekkwQkU4dVhjaFdnd1h5QkJpWEgrUGNuekZlSDVieXI4?=
 =?utf-8?B?azF1VGNkQ2xIUTdoMjJXQnRYNGlsTUJQV3p1cWl6dTVyaXlTUE1laVAzeUJN?=
 =?utf-8?B?YTkvU0VGQkhLc2VvRHpTUjRNeXRYN01iZHAwck9jdFd2cDh6MmdkSHN6cTAr?=
 =?utf-8?B?Mkhaa09LTDllNlQzNlBOalFpcCt5bWFDY1puK2ZxbFpzdjFQdDhValRYQjdM?=
 =?utf-8?B?Mm5JRjRpRFp3V0I2ZlkvNjRwSnNIUGJiN2ZnMjJJQkNPVjlKTTYzSURXRnNM?=
 =?utf-8?B?TU5nSTRtMnlRTTdJM0hGOFB2N0xJYVQwYnpUdXFnY3RwODk4UTFGN3lxa3dC?=
 =?utf-8?B?UXlKNVhERUZWc0NxRXIzV2YyZWtYcjMyakZPeVpYMndJOEVBbUI4QU9ZdDBT?=
 =?utf-8?B?RE01djZTRnR0TmkvcUp0WE5oWHQ5RlEvTlpscDRvbnpKNHo1QkcwZENYbi9Q?=
 =?utf-8?B?cDNFMzgzcXN3SHpMckcxa3Nad3NKQUhkUDltek84bktJTWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzcxS1hWbGtaQWkrdDJhTXpDZzd1ZkJoMFdLbHRxWmIwRksya3lhN2JYQXNa?=
 =?utf-8?B?WnNMb1g1dTNFUUVvcDNkRm9zRHh4azdOekdNMGxERmkrelhWT050QnlnTzFV?=
 =?utf-8?B?cHgyUGUzWGlySytNWnV2VTVaMlYzRlBRcFN2L0w4QVlsQVdvM3VSWEY0LzM2?=
 =?utf-8?B?dFdpMHBzci9sa3VxSDQyQU1ZL1ZGRXZITWlsVGc1bWIrK05rRzd6aEhpei9W?=
 =?utf-8?B?TVI5dml6NXpjN2c5cFFMM2Q2S2hlUmtrbm1GWVo2ZFg0OFJNSjNIWjB4bi9y?=
 =?utf-8?B?T0Y5NndaMFZJcWpyOGNsaHJlN1BySGF2Z0NRY3pUWUlpVjJBWUNCTkY4Q1Y3?=
 =?utf-8?B?L1lzY254WEo4bmV3ejk3YVh2NkJvZDJka0MvcmVSemRoYUJmZzBscXA2Wm01?=
 =?utf-8?B?UGo5ZCtIOTdValhoZEh5WUhKc3pPbVhUcTlnNndtVWRQMDlyZ1hOam5ERTZN?=
 =?utf-8?B?MXBXaXkyK1ZQWDhESXkvMlRMMSs3ZkNVb0Z1VkQvQzZtbHQ1c00wRDlhVHBP?=
 =?utf-8?B?dEsxQnlIei9lV1hBVDZyNU9pK2ljaWtBQzMxZC8yZWJTWXlSam9FT0t2enFv?=
 =?utf-8?B?dG1WdjF0RmdONUptOXJUazlENU14SGVFbGVPdnVZYVFpVndieTNQb0F5L1Bw?=
 =?utf-8?B?azdZTjJkVUdTdlNwdkg1YzNuR0MwQ3dxdXpuQUZjbDRPc3dLNFlhRUNabUhB?=
 =?utf-8?B?UnZRamtkSDgyVlA1a3hhdHFSNGp6QXhxTDVZUnV5NlV3bWhZQkJlL01ISVph?=
 =?utf-8?B?WFpTeUY2MlZKUTdVNTlaT01URnozZE5SWVRwdHFaNXNZYllEVTljNENXUkFq?=
 =?utf-8?B?K29zUGxuNlFQQS82MG8yWXlyZTVWRWx5YUZJRVZLd1FlM3Nkc0R2UkVaQlBC?=
 =?utf-8?B?dVQ4VHVNL3NhSUZ4NS85TmJUOFM2KzhtSkw2SEw5NHNON1g3VVFacitqVjNT?=
 =?utf-8?B?aHg5N000QzN4NXBvd3ZKK25pbmZwanY3YjhJRDBvamJZTWlCMk5ab3dsZjY2?=
 =?utf-8?B?NlJrZ1VQclRJSm44WlYwQUZZcGhmczJ2UGJibUN0d2pCeHpJbjk5K2duZ0Z5?=
 =?utf-8?B?Qk82ZE1xcmlhMzhHTjhVQU51NFR4eU1HcEFkMW9VZnM4V0oxTURCNHNhelpE?=
 =?utf-8?B?YXJLTkgvVkVQNFl5WDhGMUZVVCtaSlFkamZTR1QxMDR3LzlINHFYdEdDdCtk?=
 =?utf-8?B?L0h1NE9XTFFyd3owVHRpSGpPWWhJL1M5ekFwSFZsQ2cvM0FVTktMb040Ulhx?=
 =?utf-8?B?ajJoblF1ZnoxUXFxNGJyL2QrQjFvSEI0ZEZZYjZmRkdHempDa2ZwbkdNSHRG?=
 =?utf-8?B?Yjl2MHpvRUdQaERJUXo5ak1pS2d3V3ZQM0tVbkJ6Mmg1SWtuNExXZm9Tc1l0?=
 =?utf-8?B?Rkx0UWZHSWxPeWx2SFJVUjRuYXhaNmpaMFZVSVhqaGp1QW9nL21Ob2FtMUZh?=
 =?utf-8?B?RjdJTklXNVUzaFVMWUZKbXNRcXVWSTUxSGtKcjVOWXdwTVdSMFdaNHZuckJh?=
 =?utf-8?B?STNCV3pKVE5vSlh4bWE1M2c1NTdQaVczUVRWSGg5ZkwzTjdTcUhMT2g3OTZJ?=
 =?utf-8?B?b0xNTTN2QkhYdk5jTW01SnpMazhvaHlJVE9wY01Ncm12WTQzRS9kenlGc09G?=
 =?utf-8?B?eEtDcGl3VEVuWUVTSXBhYzBqd21JUFgzN3VNenJ6eHdsSUN3TVI1V1ZrZFdp?=
 =?utf-8?B?U0thTzgxcjVOY0NSTzhXYi9OUkI1WGtkYjVYYlFuUjJORjV1T1JjUE45a3ph?=
 =?utf-8?B?SThnK29Da1RqMEZWQlpJMUg0ZitxVHhZSzhibFVlUEdXTFdtRG5MU3ZCTUtW?=
 =?utf-8?B?VmE1cmZFMC9OdTBNaGFpM251S0JsdnNWUkVHREsyak5CYlkyWjlaU05ubHF5?=
 =?utf-8?B?NGtLWnBaU2pkcURYSDhZc0FxaWlpUzRpbklwSmVtMURGdCtDditqbzZBWWJZ?=
 =?utf-8?B?YmY2YVIwOEpmRWg1Y0ljY0ViVGZ6Q1pQT2dQTGtuMnNQU1hCNnFzWUlGWXRF?=
 =?utf-8?B?aS9pL21UTVJMcFllam5yMkpvMVRNandDaGN3ZnJ5Z04yVEdnT1BTbmhTdzBq?=
 =?utf-8?B?WEVFUVliT090OERsS2ZUVWdsTENWRktxOU9FMUFyTWluM1YxY3NZRWhmRGhK?=
 =?utf-8?Q?lgx/jYVv2Sa/yXd6F2PDUKwlF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85891f64-4d67-4e04-e7bb-08dcd8401937
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 00:14:59.3304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBV0OxaW0Gd/5DYBqFxdfAHRJyC3T0DZQfuGwQDPfgqk5OWG6Rec/a9k8RsmMQ0S6vXVUEjMsXOabG4k+7RANg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9066
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

Replace the static CONFIG_IMX9_LOW_DRIVE_MODE with runtime target
voltage mode by checking the part's SPEED GRADE fuse.
SPL will configure to highest A55 speed which is indicated by the SPEED
fuse and select corresponding voltage mode.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx9/sys_proto.h |  11 +++
 arch/arm/mach-imx/imx9/clock.c             |  31 +++++++--
 arch/arm/mach-imx/imx9/soc.c               | 107 +++++++++++++++++++++++++++++
 board/freescale/imx93_evk/spl.c            |   2 +-
 4 files changed, 143 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx9/sys_proto.h b/arch/arm/include/asm/arch-imx9/sys_proto.h
index 2f7a1292758..e4bf6a63424 100644
--- a/arch/arm/include/asm/arch-imx9/sys_proto.h
+++ b/arch/arm/include/asm/arch-imx9/sys_proto.h
@@ -8,7 +8,18 @@
 
 #include <asm/mach-imx/sys_proto.h>
 
+enum imx9_soc_voltage_mode {
+	VOLT_LOW_DRIVE = 0,
+	VOLT_NOMINAL_DRIVE,
+	VOLT_OVER_DRIVE,
+};
+
 void soc_power_init(void);
 bool m33_is_rom_kicked(void);
 int m33_prepare(void);
+
+enum imx9_soc_voltage_mode soc_target_voltage_mode(void);
+
+#define is_voltage_mode(mode) (soc_target_voltage_mode() == (mode))
+
 #endif
diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.c
index 0abf4579a1e..1433e68874d 100644
--- a/arch/arm/mach-imx/imx9/clock.c
+++ b/arch/arm/mach-imx/imx9/clock.c
@@ -603,7 +603,7 @@ void init_clk_usdhc(u32 index)
 {
 	u32 div;
 
-	if (IS_ENABLED(CONFIG_IMX9_LOW_DRIVE_MODE))
+	if (is_voltage_mode(VOLT_LOW_DRIVE))
 		div = 3; /* 266.67 Mhz */
 	else
 		div = 2; /* 400 Mhz */
@@ -700,8 +700,7 @@ void set_arm_core_max_clk(void)
 
 #endif
 
-#if IS_ENABLED(CONFIG_IMX9_LOW_DRIVE_MODE)
-struct imx_clk_setting imx_clk_settings[] = {
+struct imx_clk_setting imx_clk_ld_settings[] = {
 	/* Set A55 clk to 500M */
 	{ARM_A55_CLK_ROOT, SYS_PLL_PFD0, 2},
 	/* Set A55 periphal to 200M */
@@ -728,7 +727,7 @@ struct imx_clk_setting imx_clk_settings[] = {
 	/* NIC_APB to 133M */
 	{NIC_APB_CLK_ROOT, SYS_PLL_PFD1_DIV2, 3}
 };
-#else
+
 struct imx_clk_setting imx_clk_settings[] = {
 	/*
 	 * Set A55 clk to 500M. This clock root is normally used as intermediate
@@ -762,9 +761,18 @@ struct imx_clk_setting imx_clk_settings[] = {
 	/* NIC_APB to 133M */
 	{NIC_APB_CLK_ROOT, SYS_PLL_PFD1_DIV2, 3}
 };
-#endif
 
-int clock_init(void)
+void bus_clock_init_low_drive(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(imx_clk_ld_settings); i++) {
+		ccm_clk_root_cfg(imx_clk_ld_settings[i].clk_root,
+				 imx_clk_ld_settings[i].src, imx_clk_ld_settings[i].div);
+	}
+}
+
+void bus_clock_init(void)
 {
 	int i;
 
@@ -772,9 +780,18 @@ int clock_init(void)
 		ccm_clk_root_cfg(imx_clk_settings[i].clk_root,
 				 imx_clk_settings[i].src, imx_clk_settings[i].div);
 	}
+}
 
-	if (IS_ENABLED(CONFIG_IMX9_LOW_DRIVE_MODE))
+int clock_init(void)
+{
+	int i;
+
+	if (is_voltage_mode(VOLT_LOW_DRIVE)) {
+		bus_clock_init_low_drive();
 		set_arm_clk(MHZ(900));
+	} else {
+		bus_clock_init();
+	}
 
 	/* allow for non-secure access */
 	for (i = 0; i < OSCPLL_END; i++)
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 0b791568170..331c73675ff 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -615,11 +615,99 @@ int arch_misc_init(void)
 	return 0;
 }
 
+struct low_drive_freq_entry {
+	const char *node_path;
+	u32 clk;
+	u32 new_rate;
+};
+
+static int low_drive_fdt_fix_clock(void *fdt, int node_off, u32 clk_index, u32 new_rate)
+{
+#define MAX_ASSIGNED_CLKS 8
+	int cnt, j;
+	u32 assignedclks[MAX_ASSIGNED_CLKS]; /* max 8 clocks*/
+
+	cnt = fdtdec_get_int_array_count(fdt, node_off, "assigned-clock-rates",
+					 assignedclks, MAX_ASSIGNED_CLKS);
+	if (cnt > 0) {
+		if (cnt <= clk_index)
+			return -ENOENT;
+
+		if (assignedclks[clk_index] <= new_rate)
+			return 0;
+
+		assignedclks[clk_index] = new_rate;
+		for (j = 0; j < cnt; j++)
+			assignedclks[j] = cpu_to_fdt32(assignedclks[j]);
+
+		return fdt_setprop(fdt, node_off, "assigned-clock-rates", &assignedclks,
+				   cnt * sizeof(u32));
+	}
+
+	return -ENOENT;
+}
+
+static int low_drive_freq_update(void *blob)
+{
+	int nodeoff, ret;
+	int i;
+
+	/* Update kernel dtb clocks for low drive mode */
+	struct low_drive_freq_entry table[] = {
+		{"/soc@0/bus@42800000/mmc@42850000", 0, 266666667},
+		{"/soc@0/bus@42800000/mmc@42860000", 0, 266666667},
+		{"/soc@0/bus@42800000/mmc@428b0000", 0, 266666667},
+	};
+
+	for (i = 0; i < ARRAY_SIZE(table); i++) {
+		nodeoff = fdt_path_offset(blob, table[i].node_path);
+		if (nodeoff >= 0) {
+			ret = low_drive_fdt_fix_clock(blob, nodeoff, table[i].clk,
+						      table[i].new_rate);
+			if (!ret)
+				printf("%s freq updated\n", table[i].node_path);
+		}
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_OF_BOARD_FIXUP
+#ifndef CONFIG_SPL_BUILD
+int board_fix_fdt(void *fdt)
+{
+	/* Update dtb clocks for low drive mode */
+	if (is_voltage_mode(VOLT_LOW_DRIVE)) {
+		int nodeoff;
+		int i;
+
+		struct low_drive_freq_entry table[] = {
+			{"/soc@0/bus@42800000/mmc@42850000", 0, 266666667},
+			{"/soc@0/bus@42800000/mmc@42860000", 0, 266666667},
+			{"/soc@0/bus@42800000/mmc@428b0000", 0, 266666667},
+		};
+
+		for (i = 0; i < ARRAY_SIZE(table); i++) {
+			nodeoff = fdt_path_offset(fdt, table[i].node_path);
+			if (nodeoff >= 0)
+				low_drive_fdt_fix_clock(fdt, nodeoff, table[i].clk,
+							table[i].new_rate);
+		}
+	}
+
+	return 0;
+}
+#endif
+#endif
+
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 	if (fixup_thermal_trips(blob, "cpu-thermal"))
 		printf("Failed to update cpu-thermal trip(s)");
 
+	if (is_voltage_mode(VOLT_LOW_DRIVE))
+		low_drive_freq_update(blob);
+
 	return 0;
 }
 
@@ -943,3 +1031,22 @@ int psci_sysreset_get_status(struct udevice *dev, char *buf, int size)
 
 	return 0;
 }
+
+enum imx9_soc_voltage_mode soc_target_voltage_mode(void)
+{
+	u32 speed = get_cpu_speed_grade_hz();
+	enum imx9_soc_voltage_mode voltage = VOLT_OVER_DRIVE;
+
+	if (is_imx93()) {
+		if (speed == 1700000000)
+			voltage = VOLT_OVER_DRIVE;
+		else if (speed == 1400000000)
+			voltage = VOLT_NOMINAL_DRIVE;
+		else if (speed == 900000000 || speed == 800000000)
+			voltage = VOLT_LOW_DRIVE;
+		else
+			printf("Unexpected A55 freq %u, default to OD\n", speed);
+	}
+
+	return voltage;
+}
diff --git a/board/freescale/imx93_evk/spl.c b/board/freescale/imx93_evk/spl.c
index e5807134bb2..e4999baa95f 100644
--- a/board/freescale/imx93_evk/spl.c
+++ b/board/freescale/imx93_evk/spl.c
@@ -77,7 +77,7 @@ int power_init_board(void)
 	/* enable DVS control through PMIC_STBY_REQ */
 	pmic_reg_write(dev, PCA9450_BUCK1CTRL, 0x59);
 
-	if (IS_ENABLED(CONFIG_IMX9_LOW_DRIVE_MODE)) {
+	if (is_voltage_mode(VOLT_LOW_DRIVE))
 		/* 0.75v for Low drive mode
 		 */
 		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x0c);

-- 
2.35.3

