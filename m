Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03567CCF9E3
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 04:41:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D520B83CA4;
	Fri,  7 Nov 2025 05:40:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="He+cfmJ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E13FC83C6D; Fri,  7 Nov 2025 03:13:14 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFCD283C40
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 03:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKC1QvM0e7e7DJIPFRbl266Q+eGIrVGMsfzoB+yRY4ZgRxp5vHprVDK4IjyRf48ZyilrChBGgyzUZw97yVObCpeZIEDLC5oZbyYM2mbAN8E6JJFa4F4Z9vyA5hVkjBTG/0wQKcvKtKHrQolZYJ3PiT3DlG6f0KZk/jbtznH4xX9egEUwGEXMfedg7u5aklx/JtPJzHJKVCBEo1pQ1L2DyYlqUea10riXr2cCOFUZ+vMbkZj0eIfoFa8V+eh69LPDwPaHtjdjB4rZrOUOEuePiQmU03/dUEayFZ9LkJXHavyH5poJMgx7jiRQvf9t2cNQMMOBEm94sPKHXKVGf/Z91w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOI2aqlP7zwFRZJE87Hl0kgXA/+DJYPJtTqkURbTnms=;
 b=cMcwQ9JHJs8yt9uWfNYdbvuWVrpKEPNByAVDR3XM34yWBYj6NFdy+3nkbEr2WwJf3BCuZIvSVPH8s6mmQn/DXqKdMApyeiWTWct+f7r221Ap/tZkuLotY0JXgJKYyp28KLxfp4TUPhSsKuVUV0xZ3tsRkk5kvgkHxR/RGvlfJCorWlZaBY+XXuTkQsUjisVTGdodA5TA4rms7UICWfAY52Zmhf4gNfgW1n5BqrNIzogDGm1CXOkBtnoPNV0J8hQuUwcvZBlqahd8wMvhf3THzCZAW6FxeBO+lVEyrML59p/xxr0DH1WShgn9uX5rwJzrdV+45AVuH9fV7+TtvG0iQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOI2aqlP7zwFRZJE87Hl0kgXA/+DJYPJtTqkURbTnms=;
 b=He+cfmJ9ctfWyXV6oLfazUbL25F9i/rSC/361dr6n/6VzuO9iRh54ZNHzXKgZw3zUSc+fsFKY/WgNEStcXWXLMBSWmVIXihL23pTibbyUlNb6ORVLlQGlTH8XPE25QDE7VM7t/Fl5T49jaAG0q47rXb2xuIhpbQLHPxaxvmHTxQaCmchijEy0PgGi929zLKxLhx6eZHh8vJmWi1mSzGrKRAAa8Ks/QojI/5xuqcAwz1ylKmTinxZnHgWgHkyflInKiQCDKJlkmoiW2jW/ViWQki+2e7qpAAsG4yntcZrnt+na41TpvfjZy/5T5poe/0tWSF3IDuecBCbJinUkZ1cxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10484.eurprd04.prod.outlook.com (2603:10a6:10:564::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 02:13:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 02:13:11 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Tom Rini <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>,
 Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v2] firmware: scmi: Fix up code comments
Date: Fri,  7 Nov 2025 11:25:30 +0800
Message-ID: <176248589256.804143.2598243364844907614.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028135919.8573-1-marek.vasut+renesas@mailbox.org>
References: <20251028135919.8573-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10484:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e5789cd-d90b-4da2-42ff-08de1da332e9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amhDUitCK00vdmdCeXVyZTZ1dURPdzZlclliSUpCNEJqVUdCTG96M0VQTEZl?=
 =?utf-8?B?aGpveThyRHdTS3RmL29hWEM5ekpRSWN5b3JKa1NUQml4SjJSY3ptNmRXL2NK?=
 =?utf-8?B?Wis0bTlOTXBuRjYwV08xZmJ4QkFHNTBDM1JUVktmQmU1R0s2cjkxS3BMSUxp?=
 =?utf-8?B?ODV2SlVJN1h6UUc1ZnVsODlKcmJKNlRFRG9vUzR1WDVCcUpPaGlISS96SnNO?=
 =?utf-8?B?Z2tTQ0I4WTdJMHNNdFNVWlJKaDY1L1FtWGpLQkFMcGFJN09zd1dGVURaQ2ZH?=
 =?utf-8?B?R0hVekZUT0QySU4wMFk2elY3My9RbzVwR3ZtRjF5ZUNnTUZpOThvYUVwWHQ4?=
 =?utf-8?B?YVNwd1JDUmFrQzRWMExJZzE1ZTgvdHI4YXp5cktrMitXNE0xc0NkTUk0emtD?=
 =?utf-8?B?eTI2eVZDSGs5VWhLZmZ0QnhGQStraDFoRzc3VEhUeTliYWNOQ2tRTXdXam5l?=
 =?utf-8?B?bnBTQ2Q1TVZVRUZVcXFIUGhMa1E3eWZsdC85R0dFdGd1eFlZYjZwTGVycG9m?=
 =?utf-8?B?K3dGczh6em1oUjdWT0lmUVNzRFJTWVVwbEZOczZNbEwrUlJkT0pmUUJnQ0Jm?=
 =?utf-8?B?dVhBN2NXbEN4MDRrc2tmVWsxVnl6NlJSdEdnak9vSStEVDJkMlRXaWFqeW9P?=
 =?utf-8?B?LzVKZE1oNTFJUEFhc0MzOUE3OWdTVGFyeWJDUUN0OWlEd1JmZFIxelN3eTBP?=
 =?utf-8?B?S1lCclhtaS9IOVZWM0kwL1BmS3JDdzNtRytZT1pSM0NML0E4SVNaQVZ5OXZo?=
 =?utf-8?B?TzdSb1RsbWx0TDdhTDRVcTNzczZneFJxZXJESWJPWVBKQ1l6YzRPRHY4cUcz?=
 =?utf-8?B?NXVOQnlyWFhWazB0dCtCa2lZMi9wR25qK2FNUmVhKzI3NDJXYmFnemtTZm5x?=
 =?utf-8?B?aHMyZlJHejZQYml6dGRxNm9TbzVkY2ExT2J1V2w1UFlUbVFnWjN0UnJ1Uyt6?=
 =?utf-8?B?Qm9ZUHQ4WDRiUkVtb00wcW5XakdQTXAycW44aTlBMjc5Uno5YzhpOTR4VG5S?=
 =?utf-8?B?MHdYcE5jS092VXdpL0ZOMGZ2Rmd5ZjExTzgvMHJDUmJUQ1R4QmNDOGw2SzBj?=
 =?utf-8?B?WW1Wc0dJOFp4T204aFh3dUtCUWtBaWJxbUdGeEd3ZkI3dWVvV0RabWtLb0h2?=
 =?utf-8?B?Yk8vTzlIc1N5MmFsZW5Rb1BWYlRlb3M3QjBYOHpwKzltNms5SU1Vd2VjQ0JM?=
 =?utf-8?B?K2RqNHZJNm9lWHVqL21pTG9IYkcxbXZlV2RHRjZYSzNiWUx5SVNRY1JoRkQr?=
 =?utf-8?B?RmxEL0FKNXNvUkV4b0JhOGZNWlZ3cjYrK3JHWUFlSTJaalRkL3VQOVlyQnRG?=
 =?utf-8?B?S2lxYzdzREw5VTRMMVJMS2tBTVJXcmNqNmg5djBCVlJwNVROQTdXY0s0Y1RX?=
 =?utf-8?B?c09CQmhrOWNhMG1tQ2xINkpMeDBNR1lWUGxHaXRqOW05Z29TZ3I2Z0lQZFIz?=
 =?utf-8?B?U0w0ZjB2Z1pZOFB3TzRtVmozdjQwRnVhdzcyaktMaHlFRk13M3U5aTZ2aWth?=
 =?utf-8?B?NlQ5bEJTZWU4MDNlRWVBOVl5dEFmZHpyYkNOakVmMmk1MjRTdXNUVnB3ZnVa?=
 =?utf-8?B?Ym1ja08yZTlKQldod3l2WE4xTXVzeWNoNDJlTWhvQ1lITVpGNW9MYUthRy9Y?=
 =?utf-8?B?cHFqUmtobVNGQWtMNTF3M3BRSFMwKzNEaTJNME1JWjhNRkVNTkprUkJpUEIw?=
 =?utf-8?B?RWwxZktzbFFGcTRkdytwZTdMQzZRWGN6NVNiWGtodlltV0p6WXFVZG5xUkMw?=
 =?utf-8?B?T29uR2l5SlBRVTFGOEg5L2JZN2RnY3FlZ29iOWoySXpKWi9ycXpXV2dadm50?=
 =?utf-8?B?K043VE9IR3NaaVRDTFZwVFpUVVowR2RZZS9jM1lNYm9GZWFDcXdRL1FpM2dv?=
 =?utf-8?B?c1V1b1J2cm5tNDhPZW1aQnZiaXpNVHlPdmtFcUtiLy9tMmNxV3ZmMTIwWUF1?=
 =?utf-8?B?RDkraGVwTGVxcGtnck15N2ZMUktjVCtPL1ZydDErTExrV0tHRVd2U3lNdDNC?=
 =?utf-8?B?eHB2K1UvbzhxOFBnSWNIK0h5WVNPandGSzhNWFBqS3F5VzhJeExkOWNhUGJH?=
 =?utf-8?Q?DTHLtH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjduOHB4amVBNFQrWDAybEM5Qm1ZNW1rV05rMWpMQ0VycXhIb2YzMngvZWJO?=
 =?utf-8?B?eDFKeU9jZEN6RUo1Y1lSUGd4MWpUYitrOGs3QXR4TFJ0Q0tCSTVBTDBsdFJy?=
 =?utf-8?B?VldsNjA2TzJIRlhJbG5LRzZFa2FyT3N6TlRwdFFEcVlKT1kyODdUTTRRMFRP?=
 =?utf-8?B?VER3NmpvQ2FCYWxFU3p4YStxbzVaVXFZQWlmU21TS0pLbGxrbzlFa3QwVS9q?=
 =?utf-8?B?aGdpQWY2Z3BiN244UFUvaitONWxETWNMZDd5eWg4TlFZaCtiVS8wNlF4NlBr?=
 =?utf-8?B?UW96d0t2VkhJajEwMlc5NDRXclY5R0tsWC9zUUlzV0E0U1E1Rld5b2hYQTFL?=
 =?utf-8?B?dUxGTjhEQzhUMWRWREYydlR1ZThveHZsWi9hTXdNL2xkbVE0VGxnR3NqNEpj?=
 =?utf-8?B?dUpZeUUxOU5aM3F1dno4Q2l1RGs1c0IzVU8zOEJSSGNVVEwyN3E2VnBTbm1J?=
 =?utf-8?B?WnZvbkRNRm85eVAveE5pTlJ5TTcyRjE0OTQ5Q3hNZ3hvNFBpRzkzQkNkZzFC?=
 =?utf-8?B?ZmFXUTNKWkVBS0s3WGxrVVFVZ2tCcnJzaFZ1Y2tKMjFUSituemVVb1JIQjRN?=
 =?utf-8?B?MnZtYURJUnNXMjhkUFlLdnFQRjNETlFROU4wa1F4WnV5bXlGN3hxS0k1c3FS?=
 =?utf-8?B?bWYrTHBPcVNNanJ3VS91Yit5d1BQdVgxbGdBSEFsR0pybXhoaEU4VFo3VWZD?=
 =?utf-8?B?NGljdjVwZGZJMTBhZkh5cmRjZU9sbHpVNEl1VFhjdUNnK3ZFZlBtQnIyS0RM?=
 =?utf-8?B?bnRwM2ZuaHJLVWs3aUdHaUU2eUwvM2I2UkpXSFNRdS9SNlJCNUFCc01Eeld1?=
 =?utf-8?B?UC9TQ0crOXk3bmlmbnR3VEQzYWxIQVBkaUpNajgzbk4rMjFkb2pINnVnMDBU?=
 =?utf-8?B?YXBtMk9HbDNpb0x2aE9wTktrUzFTRnRRS0dtamc4b3BGdE1pdG8yWit4YWY4?=
 =?utf-8?B?K2phNm8xUHVqTGFFMHZsQVBVa2VtT0EzZ2J5Uy9XcFFzanVTaldjbUpNZVIw?=
 =?utf-8?B?TXZ2VXY2NGMvd2tJZlh1ZTRSYTZ1QitsU2M2SjFlcjkrbUdnR2NQRk5jOXVR?=
 =?utf-8?B?aVZQU3NlZUZEamdjOU5ONU4rVDZsaHk2QXNVQndmQUozdExKSG1ocHZwUjJI?=
 =?utf-8?B?VGNqZzExOUJNelY3WGNlaWZZTzhqYzBqNnhncVE2V0U2dzdVOHpvc0VxcTlT?=
 =?utf-8?B?UGhOS0lYWTJva255WVVTaXF5Qi9CckNDNzA4UVJUSU83YjhZakNLZGtOWkFD?=
 =?utf-8?B?L0M5QkRDU2tuOUUwMWdMU1haenEzU25xTGxxL3I2MThQNWF2bDNITDV3cXNW?=
 =?utf-8?B?M3ptQVloT2lLbnludG1BSG9KeFpyT2kwa3BpL0poUm1SNC9BeUk3d1lpR1d6?=
 =?utf-8?B?NnlyQjNVTmpzdnI1T2hIampTRjIwdVlvK09VNXA4TUx3U2dkUUdOYlpHN3E5?=
 =?utf-8?B?a2I5WXdzQ0lJS0h0SzYzYWxDWk9mbURZUWVDREZObmJLdnNkVmVhbzJkSndp?=
 =?utf-8?B?Q1hxL0sydnBHZnlEOTVZZW9aRVorWlZiNlJDS1JFU0lmRWFRL0tQZnNObHFR?=
 =?utf-8?B?OVRqMVlNTStneGYwNUZBa0Q0Q2N4Nm9INy9GTHg0WFRrYk9MWXlkM1NnMmJa?=
 =?utf-8?B?RHgxUzNyWWdGUm1UbHl5UFkwcWN6eGZDaSt3T1BjajlkVG9haGNuRWwzNzh0?=
 =?utf-8?B?ZnRhOGU3UWhLVTlCMTZuN2VzZmhVU2tEUk1Rb1REWTNBeXUzZVVnV2R6dHJL?=
 =?utf-8?B?d0psRS8wWWJvQU80MC9Cc1hxZlR2TGpmOStoNUFOMVlWc0E3OWVhOHdab2dO?=
 =?utf-8?B?MlBWRHR0Mm9rcTZSSWpjbUR0ZG9zeWRrbFdzMUt4dXVMU2RMUEp0U2pTRnk5?=
 =?utf-8?B?TmZ3djRxbk9HSkxtb3dEZW1JUHJ6Nmp1bm5PNHRoRlNaTUptVSs1UzVnTFNP?=
 =?utf-8?B?NlhNR0xyMWMrQm9sTXlPNW9FcWprbmY1bmNQbU83OFhIeVVNMWVTdURxVzU0?=
 =?utf-8?B?SkdkVXpuL0VlRms1ZnpzanZRN1grMmFVellSbEF6SmV3Qlk4S3l2ZkxQWWxO?=
 =?utf-8?B?WnB2QWhHTjRGelkzUGxEWFJYZXdIbG15VEROS0dnaXRXVzFEWmZwTnNEWE5m?=
 =?utf-8?Q?Sr2GJ1PCJYEQSg44fyKiDnW2t?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5789cd-d90b-4da2-42ff-08de1da332e9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 02:13:11.0028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXHeaygtP/mX5h0n5aIk/i2T2O5Bwm+YfGdsTYgKpDRYQVX8GeLtyAvickidNIxKya55DidgVJYuQnciPHDbtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10484
X-Mailman-Approved-At: Fri, 07 Nov 2025 05:40:31 +0100
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


On Tue, 28 Oct 2025 14:58:57 +0100, Marek Vasut wrote:
> Fix multiple instances of copy-paste errors. Fill in missing
> headers for CLOCK_GET_PERMISSIONS message and response.
> 
> 

Applied to fsl-qoriq
ext, thanks!

[1/1] firmware: scmi: Fix up code comments
      commit: 0570a9d4d6341fabaa9dfc6fd17cba0cc50aeb71

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
