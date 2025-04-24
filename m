Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DBAC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:34:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E684A80FF7;
	Thu, 24 Apr 2025 08:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Izr2v8RE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8788181E25; Thu, 24 Apr 2025 08:34:14 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B0FE806FC
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnz8bU0h41J+iG3Q8Ec4x+ZcxYTklkEIU6W2BqjvZcyGlhTx+5qeltAXzZ8gBAAbHurNmrbje6/EmAt3EPhVGJRPl10syPwySmI6jlbwQM5OJLvnoj+3UhmkJfkI/dgUcFb0C+7U9kZtlcfLJTSfy06Xa713phL+LcRPOt/tA4s8YvlpDPbLyb7JGwY0NVj9ir/Jqd6EWc4CcCeIcjlBJZb1LjFVr39R6gmuI/wZR7dFDn3+dkFOd94L97CQpRzskC6zTQ8EFomvKyiGP9NntfIrbBDYyH4eITX5QGZtiGKNKvP2nfJzjOvcMSRx8qoyztpveWLolIOJ6Wmw8BI7yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RofmbV/+ODY9aTjSQGzBm7y2iDvIF3IzdnKnA6ZPFGo=;
 b=noaKKkaDjXWT+KsikG5Me+JFZ+ySY+gn68XJR7unD+U/BnAKSnAh5uIOlxr2KjnhAHnMEYoD8lcToSicU38ceioiPMX7Z52dgX93xTqzAymQTjDtUZIbf0Cn2wiJP6mYRzV416CL2zV246hb7xbyJOCktLGYHWeAzZ2QfyFz+eNWkqavJNMcLCDq6k+p3Gz4lwJR4K5c5p3NaK/55vido/VTVK7DesXIvbFXBGI9Z+PmLRUizFmgIMHIEQyKuoEG5tjUHyQHHCn8KPhD1QCp5WPLDYWi7Vo0k8cW0YF51q0zv7WQb3mVGFWWgFvM/zxQiS8bxNpQIuPV7fPNqrUU8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RofmbV/+ODY9aTjSQGzBm7y2iDvIF3IzdnKnA6ZPFGo=;
 b=Izr2v8REKqmNZ49P3Ij81PQS2ecIJ0brLz0n10YO9q4qhSdjJjN0MIAyCiZjZalRC7TlCWjs/Gu39qaZc4wU7OGQ6KgqoxS1jCBgJ8seaFeJw273BvjHVq9TQp+4k4DdKz5fuJp14J4BYmMPXe8fWpcWjVefYRqQp8GSMGzrsO/ykwpMiBCiooB5QSTDbXRpLGd8iB0IJRAmTWtHJJhVwa9avOFfmh58wTtIutav0qtfTtd5IurbjDk6V5BENzlE5TphWZTjYtOhcyX2H6rSAGeJJ2bEMERS4iY1Tg8WBuGRQ+NEEVQ4uMxvDZzeWjWGZ37pJCNFtUTSTw/p6QxXeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU2PR04MB8965.eurprd04.prod.outlook.com (2603:10a6:10:2e0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 06:34:11 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:34:11 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Thu, 24 Apr 2025 14:33:01 +0800
Subject: [PATCH v10 05/21] scmi_protocols: add SCMI misc protocol
 protocol_id and message_id for getting the ROM passover data
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-imx95-v1-5-10a8449b1e5e@oss.nxp.com>
References: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
In-Reply-To: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU2PR04MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f7b254-bc44-479e-1e7e-08dd82fa05ce
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmdxNm0xNENCRnNVWXhKQ0VZQjVLUmk0aTZkekFxVTZ1R1hub0lqbjVQbWNB?=
 =?utf-8?B?NFlCUnpmaFErQU83QUwwbFJsSHM0N2xuaHFobFI4ZkljeVJNeHBYNDQvWXh1?=
 =?utf-8?B?Rm1udVMrdVZ2OHdBMVhUTnVjS25XWHZobTFFRXlMeURJVUZ6T0drTG53RHpr?=
 =?utf-8?B?TEhnRyswVURQVVVrbjBicUxUbW5EM2RXRkxncWtRbWlXN0Y3bnI4QUZvSno2?=
 =?utf-8?B?cWJ0YTlEcDQwdUlvZ0RsZUJCS0RVRHVVcyt4ZERRL0hmZW5MbkNGdHpTS0pq?=
 =?utf-8?B?dlVrM0RBUmtENFRHS09VMTNvQ0V2RHlsOTFWMWgxWkZHbUtwaW4vdG5tRG4r?=
 =?utf-8?B?VnpWQWNNcitwZWRvS0IxWXBpQzFPT0x1dWM4RDg3QTA4Qm1ER2FyWUJjWGxR?=
 =?utf-8?B?dGdQeElkNU8wT0ZBeUVZcXczVkxvcFVSdHBnZmdpZEY5eGxZZU5CMEdiQnNZ?=
 =?utf-8?B?cEpIelg3Y2E1V0NWR1lMdHlqdGR2OENSdXJQelo4TEhkaHhCZ08xRmgvZHIw?=
 =?utf-8?B?QnZad3pod00reXRkSllWMUZrYmpSS04yTEdRZ29hb0tJdXRXTkI3UXFJblpG?=
 =?utf-8?B?TFZmUFVFaXpTYTRYR2hGeDNwd25uSitUeXU0VTljcGJyamgxUDlpcHRaMjhQ?=
 =?utf-8?B?dmkrZlo2U0ROSzNNeS9xZDZ2NXlCa0ZNM3k2cmNpMHB3MDc5dU93VXpxVVJU?=
 =?utf-8?B?cCsvV0xvQ3BkVGk2dXFsQ2ZNRlhrWXJlQTB1WndlOXJSSE4zS3FBR3pzNDU1?=
 =?utf-8?B?OXZwWWd2T2YvVThDYkMrVW5uc3R5K2pjMDZDRXdSUHhrSnJVajMxRmRWYlZz?=
 =?utf-8?B?d1loNk9KdTFFUGRCT0VSREVFUEZnL1ZvNkRvUGtRM0ZuQjlxUkh4OWFZS0Rz?=
 =?utf-8?B?R0lkL0VHb2VaUGI1MnB2N2Fub3lHUnZFSEliMmplc2l2bFFmbnlmV3Z0TkVI?=
 =?utf-8?B?SEQ1dVFhNHpDZmdhV3V0UWhISXh2d2pSbzQ4N0ppUTQzUWxiS2lRWHFsUzFY?=
 =?utf-8?B?c2EyZm9HbGhnQWlXbUd2SVc4elJkbU96Mm9oQ1k5U2tCYlZXM3NHSGwwbDVK?=
 =?utf-8?B?TmpQdjJjb0FQT1dqYkxHVThKa0V5SHROemZ1TWVTZEZ0d3k2QkxiWTJGcVJm?=
 =?utf-8?B?MFZIR1EyU2wveXJQTkpjVFNvc0dETjNTTWRyZi9CTDlzd1N6S2JVSk1PN2VW?=
 =?utf-8?B?SVErZ1dCZGFHNDdXcUNoQ05ZOTBUNDNMUEgyYTJuL1RCSTltZUNiVHFMOERy?=
 =?utf-8?B?NGFDVXdiam5ucmtLMVN4THlTTG1hNWhKQlBoOCtkci80WWZ5d09DUWtPVDJ4?=
 =?utf-8?B?a2ZramM4S1lPZ0p4YXFQdU9lQ3p0WFJlZWg3Z2pkZy8rcnl3ZHFWdi8wVEkr?=
 =?utf-8?B?YkJmMVdKekhMTXdCS3BzSThRZjQ0UlJOY3BYSHIvdVZ4cUc5OU5KcjkyUHM0?=
 =?utf-8?B?R3p1NDhJdVVNS0FyNFBEa1dJSERpbFFFSldEZndZNVhMWXZvc1FDcVI0S281?=
 =?utf-8?B?Q0JKRE44YTVNTDk0SU9vTDNRSDNpZytUZzd2bThVQldkQjl3Mk1KWTVEM25u?=
 =?utf-8?B?bmtTd2xSVitjdUJGNDhhYlVybitZTUpCaUREMVRrUWxIeGdVbURnOTd5K0JR?=
 =?utf-8?B?VkUwcXZVckN0ZVZNZURMTE9LSHZvc0x5NEI4T3R2T0c3M0dYK05YNFR4VzVz?=
 =?utf-8?B?SjlOM09PYTJLT0VIVXp5aXRZTXBLTWpiRm80bkM1MEtQdk5DMzRveHZ2d1Ra?=
 =?utf-8?B?VlNmM2tjT1lPSTlhWTdmR1UzbHdvY1JrVmxoQUxoZGNJVy9iTTZlTk84TDh5?=
 =?utf-8?B?Y3FTZmdqMDNNMHFHdDUzWkdCMVNYb3Z0UmFPWXpod1RtSVRxR1ZncDNEWVJS?=
 =?utf-8?B?YUFsV0JtNmpoc2VGNEd2aXM5Qy9nNzRodWpTdlBGNDV6QjduZUJaTlpRMmNv?=
 =?utf-8?B?OEdCY3NHQkIwbEg0eEExaU4vcFVkUE5QckZPOU5PNWFrdFF1akVwTk1KKzU0?=
 =?utf-8?B?YmxuSlFFUlN3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGFuWmtpc0E2c3ZzMGlDdGd6ekZIQUFGcmJ0a1JXSy9nYk8zVUtzWHlUSEFD?=
 =?utf-8?B?dlRGcjNnM2c5L3dWSmpyNmJnc3B3ZUdva3FGZnF0OUJYSERmQ1I3Nm0wMGw0?=
 =?utf-8?B?dnl4d1ZvV01idnpwWlhzQjdwOWFUVUtWaGlvUXFKdXg4bVZYRjJ4N2xXMjBK?=
 =?utf-8?B?T2d0UU5MdmtGMXZUak5RZkFjNVgxYzd4a21mY1RhZHlxUDhYTHVUWXFHWkpC?=
 =?utf-8?B?Z2xoTy9wZHUyclVxc2tVYzNOaW55QnoxVUNWSlJPVnkwTzNieU9oS05UbTE3?=
 =?utf-8?B?aVRLYkhCcFM1WEJvcWt0TFZ4Rk9LM2UremN4blVJNjNwYXN2M0FudzlNOTVW?=
 =?utf-8?B?MGRiZS9vT01vM1N5SXgzTmEwSUt6Q0xlM1VBRUpoWVV2b1B5Nm5EMU55OVN4?=
 =?utf-8?B?WDRERmhlSFhtNEN1Zi9heW0rL0F4OXpiYnlobW45dFYrbGU3NkYvZERscnFt?=
 =?utf-8?B?b0JHNzJ3U1VDSFpiRjRuQVUxSm5VYkswSCtRb3pTeHB0bjlKNXh3UmVDeFk3?=
 =?utf-8?B?MW9mR0ZOU05UbExkbGJUWllNajFRc1oyN1ZlcDhYVFdhTTlGdFEyUkdCckNW?=
 =?utf-8?B?SCtsdzdNUnQyYTB1Vk5hK2szUXZKNGw4QkZSTW91OE96MXY2bTZWNytlcHJa?=
 =?utf-8?B?SERDZGlKSGZKbXlFSG4vSFV1cmlNRmlvb0xPQXU2bVRRejBqbloyUzY3eFhE?=
 =?utf-8?B?NG4vMWEreld4ajdqUDB2NFZSTzZVTFhkUzcxSkRvRkhYVWNNQ01CRzh6bVpm?=
 =?utf-8?B?ZmpJbGx2MnFRd01yUnM4N0Zoa1FrYkQwaHQ2RDhWdkVrNzNSN3ExZU91d1VE?=
 =?utf-8?B?d1NkN0FDR1Zwb0J2SnQ5ZlZRSENKZG9ZRCs5VGNYOUVoZloxaVc1VlZwcVJ6?=
 =?utf-8?B?ZVhvMTQrRlNQYnluU3V3YVlRb1YzS1l5Vm1BR2dlUTh3Tk9JdDZLSnkzWDRY?=
 =?utf-8?B?aWdTNDdXdG81L2d0MVhYT1J2Z1AzcGFnNUtma0Q2emtMQ29hbDMrc0pTRUFQ?=
 =?utf-8?B?U3puT205Y2piSG5XL3VKS3l2YzVJK2FKRVpoSWdHdVFMQTJ3MCtJVUxDTjVP?=
 =?utf-8?B?VlBHSjBTQzZkbXJLU0twNWo3ZG14WkFreXBNUzZRUEI0cW1ZNHVkeEtUUG5Z?=
 =?utf-8?B?WHUrUHVzSTNRbm1PT3lzRHNwVFU1UjBLaXJiYi9HcG1lZmFGd2l3TDJZTmsr?=
 =?utf-8?B?czBxUWxCK3RYd29neHpjSjdJcFoxcFN1cGcyUk5hYUlja2s2UDl1NGQ1V3hX?=
 =?utf-8?B?TnUvbk04UVhQUnJiWlQyUXBBaGVRNFJpVDJYQTQwRklBOTNvcWZnMEhIcElU?=
 =?utf-8?B?VU11c25ObUxSOWJmc2JjQlU3ZVZUQ3pBOUhIUkNTTzV2YWc3T0ExWkNlUWpv?=
 =?utf-8?B?MENEZVFGWmc5eTV6NlBsUGZQT0trRmFndSswRUNQaVk4LzcvbDNTZEpzK1Yr?=
 =?utf-8?B?T1pNdGpTSlZoYXZUc0lxNHY0aXA2OGdKOHFnbGtZR005RUxJYW1PZWNmdWxJ?=
 =?utf-8?B?R1RSQWVmcTJFOEpQS2tpTXdXdm5JdHNtOHJPNExPdjV3MXFOaUJoRG9sdXVZ?=
 =?utf-8?B?VHJ4anJhaWJZeEx4cndueU9NOTJzVmJsTU5xbTM3M1N6czFacGxSYlBYVmZj?=
 =?utf-8?B?WCtLb2V3RjAwSFpCa25Mem1yOHVneWVQWGhNTXhyTmNpWU0wZ29FL1RveTQy?=
 =?utf-8?B?ejlmSnV2aWl3VUpORy9BeWlKY3pnVlE4TExvekRFMVdzUWVQcjlvejY5RkxF?=
 =?utf-8?B?Tmt4ZGViTndHVTRVWmhjQklxdUdtOFNZdVpudW94WC9hVU13TzdaM3RMQXdP?=
 =?utf-8?B?eWdhY1ZOQ1RsTjIySDJTbmFaUVhaUjZhdDBuVTBSelN0eitHRHd2QmRwdld4?=
 =?utf-8?B?ZGFnRzk4Y2xCVExFQ0pFd2RtRGFVN21oWSsvQzYveG9GTHFEdlpJdnIzdHRy?=
 =?utf-8?B?ZUJobEM3ZW5wa3d2SkgrRm5BaHJISFpiSDdWRGpDZDZJRHlxblpUbDBka3Yw?=
 =?utf-8?B?R0JIcW1HOHFNRkZjbFAyRXRrSDRtOW5qc3lvWm5Jc2xUZDNKdGY0UURobm9r?=
 =?utf-8?B?YkhqK1BtNU9OeGJTZGczWWlsVUNGMG1JUEZQSXFDWDhrcHg2YjlYSjFuV0sr?=
 =?utf-8?Q?iu+2Pl5BLu3SHhuz84BrxT3M/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f7b254-bc44-479e-1e7e-08dd82fa05ce
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:34:10.9757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvPWokEcug6HapKluxt3qPf6cjfkMgvYS27bPK/PfUP9hEgZVM6BlQUcDMCnIYahQqDA3Hi11FhenMkiAMI+GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8965
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

SCMI misc protocol is intended for miscellaneous functions which are
device specific and are usually defined to access bit fields. It is i.MX
specific. This patch adds SCMI misc protocol protocol_id and message_id
for getting the ROM passover data.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 include/scmi_protocols.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 279ebbad440..06de4a601f8 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -25,6 +25,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
 	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
+	SCMI_PROTOCOL_ID_IMX_MISC = 0x84,
 };
 
 enum scmi_status_code {
@@ -50,6 +51,10 @@ enum scmi_discovery_id {
 	SCMI_PROTOCOL_MESSAGE_ATTRIBUTES = 0x2,
 };
 
+enum scmi_imx_misc_message_id {
+	SCMI_MISC_ROM_PASSOVER_GET = 0x7
+};
+
 /*
  * SCMI Base Protocol
  */

-- 
2.43.0

