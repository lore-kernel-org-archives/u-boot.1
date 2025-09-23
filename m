Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E20FCAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 02:16:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E717835D0;
	Tue, 23 Sep 2025 04:15:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WbGXirJi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A1A883623; Tue, 23 Sep 2025 04:15:45 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D706835D0
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 04:15:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJ1+F0tYQn7RiEN+e9H9dol7t14AMMjKQotmBEWOLwp14JWMUnTRULdhFV0hSnGby8ZTb/bHvUf9nlYq2W2Ed2qbSVlaMdSZl2V5scSOWRCXJWUTtkYJiBGsZhdMBc3+ptH4WZFPY58NLExyL+hwxl8ZT0HUAGIPQHpZ92oz75TrXC125iJZoRPbU4mVPQVMI6vWCkaSWg4OtZIHbcevKc2UeskYwJRJVdERLQ1PnAa6ReU44sAx8j9D6RFAox/4rHtUyffPU/LsOgupSrcKQgUvNg/tW45j1AXdJyUlzmYvVdAF/l1rj/0oNlGg4zi65/lRu0HroBmpOPeC/L/bkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1YabD1gr0VRrJTwxgZIlVWrQU/Jhw29v8m9MQjbVy0=;
 b=mmjRYEgQzxNpkf6wEnHPTU3RmxyPpLMwCSI9UHBcdOKwomvcZ13lcCX2QGkECWPJ49UfSsnJHDqLrqDIKGWcPja4q8r+vJVccu5h1BpAKoPdsEvZiEHcI0tpRSaF1MKPX4NwaAocTzoFgdtC3gb8eYDxJbpJ7diCVixA9GB9GSLxpvZNAA7bjUF/llR0cnPw0iOPdnTERmUwxs4Q/rKVi136ckfeVrcofEjWb7jelB3w1EmBORlGeySqwVxBAwh1CjF+gUPVArzDMqaR3XvOCN34nS5CrTOgj2OIKC/n6o0dlIHA2S7PfaaNdDGv7hogYRqB0othUC3JwOqKuic2nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1YabD1gr0VRrJTwxgZIlVWrQU/Jhw29v8m9MQjbVy0=;
 b=WbGXirJiOuflzMOk/MJ45xjkY3R6Jtxm3xYlxiCy+CXIyRzNHZy6tms3v8k+JUQOTKLRk8UGTDn+WJuxFy9DpajnY2inaLmTYxBUbA1bvZeLar1kJJZafuFr6EXmgUMq/vCPMi0QkTi8nkFZhrAqdPp6Rp1bDe7TaH3LSAfdh9qjqfsLYpvTNaowWkyJ1vIqhCKxZp/t/VRWwUhIHwaFeef2QFBURl0DhX89DNbSRBz7eheAEjmQIgAvPCqoma5YlQwobILNvPjbyAnlvF/k49hGk/Nm2xEvPtwobyjPseVeGscsKlWPicFV0nU1B+tT0jj8h4chyv67ozO0Mcw0mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB9835.eurprd04.prod.outlook.com (2603:10a6:800:1e1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 02:15:39 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 02:15:39 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 23 Sep 2025 10:15:01 +0800
Subject: [PATCH v3 09/12] imx: ele_ahab: Implement display_life_cycle() for
 i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-imx94-v1-9-cb3b65169048@oss.nxp.com>
References: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
In-Reply-To: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a47ab8a-2329-4014-9337-08ddfa471728
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUhSa2s3RXJXNFEwN1N4RGNjRlN4VE82dmRGdk1qM2gzWUU3VUVsQU9vYlE2?=
 =?utf-8?B?VFM2UWdsYTdySkExOVJFSks5bGxTKzhOb0Z1YVNXUlc0MVZuQUhxZldtdkJx?=
 =?utf-8?B?QnVxTkdhVkZuOEdocU0vdWNNd0FvVW1CNUlYanh1OS9mNDdsT1FkM2p2UEJW?=
 =?utf-8?B?TzVLRFh1djNyNldFdG5yZTRnRklqRDZJSXBHSEwrWnNJajhmMXJaaWl0N2Y1?=
 =?utf-8?B?RllpS1l3c0ZlMURBK3ZTL0dxb08ydWFXQkZ1R0QvTzZ2ZzEwc1BLOWNsdzRu?=
 =?utf-8?B?U3N3THB3L0p1b1RLdEUxb0NiR1lIdHhNTG5oZEZ4YzZhN1FwcUlWWnp6cU1V?=
 =?utf-8?B?ZDBoaWxNelNnUGdtS1ZnZCs5VlFVZ3ExN2JqTzY1NCtqbG9TTkgxbDhWNlZl?=
 =?utf-8?B?Wm5IQ0RWL3ZUUDNUY2hmQjVKY25EMnJhMTNSNlkzSnU1RXVnYWltNkJQdDU0?=
 =?utf-8?B?Q3NPSkZlQXdHMUI2NmdNMERBZkRQWjM2RzNMNzlYN0EzSDlvZEF4cU1Wa0ZP?=
 =?utf-8?B?UzROMEFFZDV4TVkvMXh4UDB3citrNDl6bFZsZ1EvSlIxVjZtVjU1bkZ1TTBi?=
 =?utf-8?B?eVdTZWtQZmtLdTA1L2xEOVEwN3ZBelJVQUcxRmNUdGUrcWxEa2poNW9qYUpK?=
 =?utf-8?B?REMvb1hEMUExT3g0cnVOMFFFV0xHei8rblk2Q2FXNnl2cndvWlZHRzAzbDhP?=
 =?utf-8?B?T3g0MnBEVTBBMEFocWVjNldwTzJGME9TU1htdVl1MHB6Sk9vdzNEcCtHdFVh?=
 =?utf-8?B?UmlXbS9CcER5SGxWRHp4QjBGSkVIY1loaVF4V2lieE1RU0lYcGlxdDR0bGVZ?=
 =?utf-8?B?SzVRK2NRNWt4bW1XTUZYbUlsSi9hNWdHT3lNYUhBWGdTd24zMFcvODZJZTF2?=
 =?utf-8?B?QUlUTUpMaGtqT0RZNkcxOUZsL3U2VVpXTHoycy9DWTMrNmRncmVWeVpaSDlh?=
 =?utf-8?B?alVUUEtOY1N3bGpEUUlmazFPdlFab04rRlZSdnkyaXV0N21CWTZrdjFiNGtL?=
 =?utf-8?B?WGlhaytwMEIzdTFmVFc5Z0VaVFhLSEw1Y04vZHlOYXlWbS9GOGRTS1Y1NkFD?=
 =?utf-8?B?b0NMRHBLTWtTUDFUeDBZWkF3V25qRGpFdzJTYUJXRHZoMjhGdGhsTlh6akNm?=
 =?utf-8?B?djI4NXd2ZG0vNUtJN0VKMStwa0h0Q1hlK2llRzYrWDIzMnkxZ2l5a2YvR3ly?=
 =?utf-8?B?WGFaNEI4U0I1ZWpnRzZKZVBmbE45Qmp5M2VvTm5ZWUFIWU1iZHhMLzdKNE9k?=
 =?utf-8?B?elFJazdPd0RTUFFjclh4TFgzemtEcGx2NTNWczE2dElwYU91UGdqOHdnendv?=
 =?utf-8?B?b1NzYklpZ214Z1ZVblRKaFdMRkJnTzArejJ0QXREZFYrbms0a2FXYk5jQnp3?=
 =?utf-8?B?SnZvbUViQjROSmtNMW5RbElVaXB5RVNTRnUya0VjdU1jd3Fsb1N6WVVVSGlW?=
 =?utf-8?B?NlNhbE9SSXhGSWdtdy92TXhhQlA3c21FdVFHY012Slk0U2hSOTB1ejMxemZ6?=
 =?utf-8?B?SGR3L3J0R0gzRXN5bkNHc2hHVlUwcE1jZlhKU3IrTDlDVjlIUVR3N0JUeDRU?=
 =?utf-8?B?SDdxZXFLb3BjaUY2cGVOdi9mQmpnRU5WRWQ5UDgrZHRjbGlhTXFyYmxTZTJy?=
 =?utf-8?B?Qk4ybVVob3A4cjVldEJwS0ZLUTdja0NaczBadGFpdlcvaDRhNlVSc2VLRml2?=
 =?utf-8?B?Rm1FUG91REN0MUo3Zi9BNWJzbkU1VGZBRndKVytPMFo0U2FjeTVBQU40bWZh?=
 =?utf-8?B?azBzbWNmZnVYclRtQktMd1hWTXZJdTRPSGV4THk5ZjhqTE5TbllKUmhKZ05S?=
 =?utf-8?B?YytiTWt2eVIzMnUyUXBXVDZ3U2RLVVBDZGlOWXpxRjk3V1VGc1o0eDNpZm0z?=
 =?utf-8?B?ZGticUFydDhoVFAwSVg5MGhITHhIZTNQV05FS3VFTURsUXJVa3lpdVRiMFpq?=
 =?utf-8?B?cS8xajE4YzhMWTRacWRlTVN6N2did1l1R2IrYitveHh3R3NhOEppQy9RQ09Q?=
 =?utf-8?B?OC9wL1M1WW1nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1hHS3UySmllV2dsUFZTOTMxUWUvcnZ3OEdmQUJ5Z3R0cHVXcFpHZy9jb2U1?=
 =?utf-8?B?RzYxK1gzeVlUVEh3dllZTGpmOFdyT2pVYkl6ank2dkZ6alFVVUFhYjkwNHZt?=
 =?utf-8?B?M09MNmdTYmZZTFlLS0lNUEg5VlF4MXNlQ0VkVkpzRzhhc1IwNTNQSFpsOUha?=
 =?utf-8?B?cm5kZzdaVHdXcTlrcHhnVWpLY0tEcUp2eXllOUpLdDQ3T25zYTRZZmxOZE1I?=
 =?utf-8?B?WWlBclRuSmd5cU9uN3FkU0M5bTAxVGxFUnhKdFZtNitJZ0RMaEd2dHZhdkpm?=
 =?utf-8?B?aFNTekJxOHJVOWlXSlRDelZ5Q0xlM1RESTdkdFo4MExhM3d5bWRWN1J3ZHlJ?=
 =?utf-8?B?MGxiQjJ1K3hrbzRDblovanNMeG1sZklnUWdHMkkxdlFoUDc5bDBCbWJZaktF?=
 =?utf-8?B?NGFHdWF2QlUxbkFqS2pxVnVnZys5ZkJnTk1mWU4wT2xVQ3YrSjM4QmxBb1Y5?=
 =?utf-8?B?SzAzSmdYa3VLeHdtdGg3aEJpcTFnckplbHBOVDNJQ0pGaE9KUzdta1c2SmYx?=
 =?utf-8?B?cGt4dEJtMWRTc3VOaXpOSGdoSjE3OFhVWWwveUNCZU9SYndQaGt5MU9pTDZ1?=
 =?utf-8?B?SndiTEtRazEyQTUxSmc2SThlVHl2TVpPeWxFUVBFMXdENGowbVJzeVV0dUVi?=
 =?utf-8?B?RDdiUXlXaDcyRVVuSXd3bFJ0MlNFSjRxcDlyUnJEL3h3MGpmOWZTRFlRZDRl?=
 =?utf-8?B?Y3psVElpenBWMzJQUk15eUgxcXRHUjdTYW93aHdvV01UVjhTY1hQU2NWeUVJ?=
 =?utf-8?B?TjFUVmF4T2JmbXFWVElRYThOSUdRbnpnZm9ic0VlWTluRnJHWjVoMEhBdUpU?=
 =?utf-8?B?RmpsbXJzK3VBUjQwSjN2Y1FiV0tlS1NMNjJUMnZUK0dXTi9sMTVRbjhaQXNE?=
 =?utf-8?B?ZUpvSmd5c2RpNGVpMzkwV0RVY0wrNlA1d0dwRFNMOFRhME1rb2xYYjJBdytv?=
 =?utf-8?B?aXVVUDBPTVNtamU3SVZiWXRxaEpaUVJ6alBNM3lOYzE2bU0xVE9UWkFZTnhp?=
 =?utf-8?B?VmUxbk5uSnpXNkxScnAyQUdKclF5Q0xYOFFoRVdObXNudEk0RXA3UXp1a09t?=
 =?utf-8?B?YlB5OU85WlhZMC9OOW5mdHBseEpIYXVldEI1RldwN2hrUm5ISXl1ZE1LMHJv?=
 =?utf-8?B?NU9KZ1FXTVVqTGpxRCtpcXpvYzYxOTc5bGlFNGRRdTFzQ21XU0xRWFVLVHox?=
 =?utf-8?B?eFpXRFlObldXT0hyREtyTjhjT1RSbjNReExaWmQyRy93WXVlMmY5Y1hQRFdv?=
 =?utf-8?B?Tm1rdFQzRjFrNlgvWmNFYWo3L1BGeVJXU09VSUJOOFRieTJaZTVIdEJIcS9s?=
 =?utf-8?B?Z0NXK3NFWUFDMWZDK2ZQOHFvK0xIMHBObmFXcVgwYndwa2xaMUVvREQ2aUJo?=
 =?utf-8?B?dkVhRnF0YVVzZWdwL0hVL3Z4YTErbXFudUtRQTh2UEpBM3BmUy9yY0E5WWJX?=
 =?utf-8?B?aHE2MjZ4dXVudnB3NHFyWm1CTGQrNHRmN2xHK0k2YnJ3bnhtQkY0UUlBSDZt?=
 =?utf-8?B?MDQ4enRwUGJuV3UwZDI2NzVHOUlKWXo5TCt3VGc0b3hENHJ4U3o1R2p0a2cr?=
 =?utf-8?B?VEpOOWxlMHJFMnlHTnJkZFNlL3JRdWpnWUpkZXlrSGxTUzVFRnJHU1h5VFVH?=
 =?utf-8?B?Ti9uTlUrUWlLTjQ3eDhNUEgwUGVLaFdJSERKZTd0OVNxREJSTUNoUW1aWVZ3?=
 =?utf-8?B?Z3p3MzNia3JrMFdYampqRmQ3M2RCSEhMemphY2JQNTdER2luNkgydkNaMUF1?=
 =?utf-8?B?aFhsZ3VOK3M1U0JDZVV0dHlrZW9NZi9WZkdmVlB0R1hUVHRpMzI2ZC9yanJ3?=
 =?utf-8?B?dTlzeXJKZjJ6UGI2V1pIMEJ4ckMySHFYOUx2cFBwa1A1Tk9aM295aXQ5cTk3?=
 =?utf-8?B?MGhIMzhuK0Flb0RTcGV1WnQvUWJTSFpNL2QvTWpJSG04RXJIdWkzUDFoNkZy?=
 =?utf-8?B?WHgwNDVoYVAyeFFISC9obmxLRFZmWmRiQVM2a1B6ckxienV5K21YVDdDYlBv?=
 =?utf-8?B?cHZKenNYdXNSNks2aHZCdDZvM1daWW5uU3EzSG9CSkMwTElOL2diSjBDWk9s?=
 =?utf-8?B?QXpLQlZYOGd0RWMxMlBDVjd5Q1dWbFFnZDlTU2RWRTdLV1NhQVFEQTlxcWhk?=
 =?utf-8?Q?89pki+He0EQCgCwkTdfWoQ2Qk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a47ab8a-2329-4014-9337-08ddfa471728
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 02:15:39.6379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIKcFGiRKN0Nk9zVqQ09YXEdcwJ8BXpb1JNMAwEsaUMeRS/jMd+gSq91qUjN3X0sgR9szPfqbKifqTTYx3+Piw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9835
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

The register reflects lifecycle and some lifecycle-derived state of
i.MX95 has new offset address and layout, so display_life_cycle() is
added specifically for it.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/ele_ahab.c | 55 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/ele_ahab.c b/arch/arm/mach-imx/ele_ahab.c
index 647daeb6562..39aba65d29e 100644
--- a/arch/arm/mach-imx/ele_ahab.c
+++ b/arch/arm/mach-imx/ele_ahab.c
@@ -411,6 +411,54 @@ static int do_authenticate(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
+#if IS_ENABLED(CONFIG_IMX95)
+#define FSB_LC_OFFSET 0x414
+#define LC_OEM_OPEN 0x10
+static void display_life_cycle(u32 lc)
+{
+	printf("Lifecycle: 0x%08X, ", lc);
+	switch (lc) {
+	case 0x1:
+		printf("BLANK\n\n");
+		break;
+	case 0x2:
+		printf("FAB Default\n\n");
+		break;
+	case 0x4:
+		printf("FAB\n\n");
+		break;
+	case 0x8:
+		printf("NXP Provisioned\n\n");
+		break;
+	case 0x10:
+		printf("OEM Open\n\n");
+		break;
+	case 0x20:
+		printf("OEM secure world closed\n\n");
+		break;
+	case 0x40:
+		printf("OEM closed\n\n");
+		break;
+	case 0x80:
+		printf("OEM Locked\n\n");
+		break;
+	case 0x100:
+		printf("Field Return OEM\n\n");
+		break;
+	case 0x200:
+		printf("Field Return NXP\n\n");
+		break;
+	case 0x400:
+		printf("BRICKED\n\n");
+		break;
+	default:
+		printf("Unknown\n\n");
+		break;
+	}
+}
+#else
+#define FSB_LC_OFFSET 0x41c
+#define LC_OEM_OPEN 0x8
 static void display_life_cycle(u32 lc)
 {
 	printf("Lifecycle: 0x%08X, ", lc);
@@ -447,6 +495,7 @@ static void display_life_cycle(u32 lc)
 		break;
 	}
 }
+#endif
 
 static int confirm_close(void)
 {
@@ -474,10 +523,10 @@ static int do_ahab_close(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (!confirm_close())
 		return -EACCES;
 
-	lc = readl(FSB_BASE_ADDR + 0x41c);
+	lc = readl(FSB_BASE_ADDR + FSB_LC_OFFSET);
 	lc &= 0x3ff;
 
-	if (lc != 0x8) {
+	if (lc != LC_OEM_OPEN) {
 		puts("Current lifecycle is NOT OEM open, can't move to OEM closed\n");
 		display_life_cycle(lc);
 		return -EPERM;
@@ -540,7 +589,7 @@ static int do_ahab_status(struct cmd_tbl *cmdtp, int flag, int argc, char *const
 	u32 cnt = AHAB_MAX_EVENTS;
 	int ret;
 
-	lc = readl(FSB_BASE_ADDR + 0x41c);
+	lc = readl(FSB_BASE_ADDR + FSB_LC_OFFSET);
 	lc &= 0x3ff;
 
 	display_life_cycle(lc);

-- 
2.43.0

