Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F58CAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 11:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D80E83448;
	Tue, 23 Sep 2025 13:12:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DJy+f6nw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF444833ED; Tue, 23 Sep 2025 13:12:49 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5C5C835D0
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 13:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWmk90+6CrWhybi+A5bdc2HUAzmZNubu2+U94xFza/E7+JGXTZWlv6hOd644r5Rm8s//UocOwnRFHK84Z2URABbBWUKqvHPa+6pBOBVoGmQQq4P+yQXYRtrXAI/5N2vpgRk98ADV9KHv7mPvSQCPU1cdD4rjTS4rS8F/+Tg07DWCo0tY6XAkqX3JxnBv4Kj5da4RsqEZ/gFWBBYwtCcxNAXJbGDMFwUc3iQd1nrZLzmrgvXeBnXWdii+U33hpgOBUGjpQ7E+I5aRidSuVvmUsBUni2cA1Zf+nLK1ic/xD+lFYBxdKSmRUimI7j4y2G9/duIJsQTnpGogQdfgZ2wdwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOumPe5SjZrWxQCoNkSz1g5nlikV5njZ/DcTw7c36pQ=;
 b=Y/rUex2gqVseEZaPhkTuopCSHmm19Y56+Dv8v+zZ0bXrQglPL4aXjnAHGZdVND+VairN9PY9W9atzDbyXQEvkRYk9mvSRUdZAd17lSjqLgOGrnfLn1S+tzg6LHpVHvaLUMz8QzbITiiOd49qP3DMp6eZ5vjhYY24w3KkRaVP5hehr/sTy9m9J0FKs8OPjW1yGsZ2bzZe/6TUUQ53asHw/KZIcv3F74udiCzlsJ4XMcJboudfKk5UdeK2ShWSEu1hqEHj3Ggj3yOlOy2NqC6RnQHNjmIPkLZw7ss3qAG3bGVFYiM7ju4PBFs7jHnW+A9N9/j7k21be1ENkHKNQN4X+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOumPe5SjZrWxQCoNkSz1g5nlikV5njZ/DcTw7c36pQ=;
 b=DJy+f6nwKz5rzOKjao8ti9f5qFQC1inmlIYTtTK221DQsYmmfZPzq6TIq0cHU/LtFnQ4NwK7b5VNitiziKegsD4ZiQ1MS+ZJHwczvI45xs4lf/WqjDYudbzfZe1h/s5cIhYNwnjCld5UOlU/xnig9MRb77k7Tbte1wWNsOGqXsk+at55gQEY+BnXTfSlV8TITevFMJ88gyy+DEFPO8WZjBE7oAwTUnDQN2qsHApvqu/Iwc5Tll3Jc1/1Y9vjDAEyLYjvI54zXnS12+mCMYuXs4wXMxqeHO/+xH4A3qbzoj2sAIQ4CGeyxpvFZKnIpw3Ry+bQRalbT3Zjzjg17UOL/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB7919.eurprd04.prod.outlook.com (2603:10a6:102:c1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 11:12:45 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 11:12:45 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 23 Sep 2025 19:11:53 +0800
Subject: [PATCH 09/10] net: fsl_enetc_mdio: Add support for phy-supply property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-usbnetc-v1-9-507cddbe7214@oss.nxp.com>
References: <20250923-usbnetc-v1-0-507cddbe7214@oss.nxp.com>
In-Reply-To: <20250923-usbnetc-v1-0-507cddbe7214@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA4PR04MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: fb9f8b96-86e1-4681-d28d-08ddfa921ef1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cURyYkEzOG94MTF0aEQycllLaWlHQ3pTcWh1OTdES3NsdmMzWVlXa2hyNzJU?=
 =?utf-8?B?WmJmaTVDOWJQa04vQ3ByQ2FpOGg3YlFJSE9uTVczQzVxZGlXeDZTZGRDRDhn?=
 =?utf-8?B?bTBBUytTT1pqV0JvdGRlT0RobDVmVVR1bGZEemg0MU9ZQkk5TXRvTG9pWDNP?=
 =?utf-8?B?QjRGcHM5L2NTaUkvdHNGUk5pYW5ZZ2Nyd3ErU29aTUFFUmh2TWFHejNKSlhB?=
 =?utf-8?B?Q3d2dzh2RmwzWFVkcWZSd3ZDenpuY1RFM0ZFbXBZSTIxZlcvZVZTUkowMjIr?=
 =?utf-8?B?N2pYWEg3QW1BTU1pZ2ZWUTVWVHFRNnFpakU2dFArbmVXNHZVaXYzTU1YNE1M?=
 =?utf-8?B?RzRrTUdEbFB6ejJ4ckpMdnArSjlYaEFrNWthRzVmWHRDK1RoUENBeUVXMGlP?=
 =?utf-8?B?bjVqenc3dnN4YStrNlo0N1lHRkFlVmQ0M3l0emI2R1FrUUFQSkt2YU1YdVEv?=
 =?utf-8?B?WDhtTlhSQndCYmx2dTRqL1c0U24yMXZmMWY1a003R1k0TWtqUUtpUTJ5YkpS?=
 =?utf-8?B?ajhzdWJzZU5KRmx0bFJPWWtSeHFmdVQxcjhZM3dtSCs1MUJUVGpVUDRoYVVR?=
 =?utf-8?B?OUtRMFg1VUJHdzJmV2E1L2krTThpRytDOFcwd0QvM0VJeUJFdDZBSGl5Yjdo?=
 =?utf-8?B?Z3lDRmpMWDc5clRIa1diMjlCRTJXcEhSYkE4NGFmR01xRUNKZ0YzWGxJYzBT?=
 =?utf-8?B?aXE2RWhDVElUMnZUVHFQbDlLb1o2VkM1MkVIZUNyU2pERXpnVW82M01GZXdv?=
 =?utf-8?B?SSs2SlNZVE1ySCtXUTFxMmJNWEVBSUxzeUpHckFuY3dERCtMVkNFMU4wMFNK?=
 =?utf-8?B?MTNsOWJEbUIzeHdGK05lK0tpamNZQi9tLzFDMmZhTmx6VnhsYXMvS3VJNHgv?=
 =?utf-8?B?cVpWRi95R0FkTjJ1OTE5MFgrUW0vUkdtTWI3amdIQnpuRHkzbmlVSWdpWU4x?=
 =?utf-8?B?SWVUZm9tclNQdTBneWExSnRBdEF4UU5PWEk2T2V0SlBVWkdOdDExb3JRcHlG?=
 =?utf-8?B?RXlYWGFhVWRaNC9yZlFqaXZEUjFkMnZPQnRUcjN2ZENzY281SW84NFRDOUF1?=
 =?utf-8?B?SmNtVkFVeGZiN21iVDArWFFrZXZVMHVMMy9oVHFpaW5hSUR1eVRBa1JncTJi?=
 =?utf-8?B?SE1WUXJXMERpdjRHQm5RbU91eHIrTmQ2QUhuK1ErQW5vLy9qUmJwb1lmQWpV?=
 =?utf-8?B?alR5dHZGQS9KZkJFYk03U0s5NWRxYkdYOTY5V3l1aml4NWxBd1Z2Z2NMSTFu?=
 =?utf-8?B?WVY2OW12bzlXV0VjcDRSd1FiNnVDNm9TaDdpdjlJUE91RlpHb2tRTCtaYXVL?=
 =?utf-8?B?OG9SWHc0bXY2eXF1UGRVM1FpWUxhZWpLZEdvVlQvYXlma0ZuNEZyT3lUeHVR?=
 =?utf-8?B?TWV2TUQ5aEdhSDJTclJrWmMrUjNDT0d5VHFEUlRxWWhCb0xrVzJ0eEl4bXZ0?=
 =?utf-8?B?R2lCQ0QxUWttakhxbTNSMEZ3OHhsR055cHhRWlRVYkY3TFNUSjVtYmMvelhM?=
 =?utf-8?B?SC82bGp1VHlUWHNwQ3BMdW1kbGg3S0EwODlYTUpkZ1VOcHZBRGpZaEt5TGNr?=
 =?utf-8?B?MjlKTmhDenhOeUluRVgvNTJnL1IydmgxMmhRT2Q4MkFkT0NaZEZWazhwWlFS?=
 =?utf-8?B?RUd1SXYxK2VLMjFaS3pHSjdvTS9LNnE5eVVaZlQ2M0Vjci83UVljcWx0MjR4?=
 =?utf-8?B?Yk54Nnc3R1JxK2VSWk9sdkVRd3hvNXNIeGhpNncxdWdKWHp1RFZuRFVhRjB4?=
 =?utf-8?B?d1hCeWNwYTRmaVZ2eUZReG16RFNKK09nU3JDWkpkRW1aczRpUURaVk1OWHM3?=
 =?utf-8?B?VEk5TnN0dU52UldHbkxwUFdBMDh6WUpDSVFmZ2t2aXM5d1lRNWh5eUtpRDlZ?=
 =?utf-8?B?S25wTkZ1dzJuTWhQcEVDWVR4ZXBWcWdxYVJYdkxCeXQxelVlMTQ1dzhRTGRv?=
 =?utf-8?B?cktCejBYUzRuRVBWRXg5bWRzMVI5MmdHaWk2U3dkcWhjcTNvcERCWDdPNkZM?=
 =?utf-8?Q?ZIEiyUbWHOBE55jQjC0uY/42f2ZW98=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(19092799006)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGpqMGtacUFEZjl1dUtHMDB5K3doN1JOZjN3SWNBcC9TUnV3QWR5a2M3MXBH?=
 =?utf-8?B?YllJOGdCWXpaL0FMcm9WN2hZQXpMWWtGMWJKTFN6RTkxSnphWDlva3BtdWFR?=
 =?utf-8?B?VEF5bTNERVIyVTFsS1RqaGVCK0h0NWtnTlJaMWNBdTZMcThjNmNHUlJVMWxx?=
 =?utf-8?B?a25ndWFvSmUrZVZLdmd0bVhWRWVQdkZ0V0dLYkZMVkIxblJtU1Q0THZybFYy?=
 =?utf-8?B?MTBSQlp3aGl2OVkyUC8xWDcvQTRoWDNQcEk1c2t4R3VWQ0VEWVg1WkZkU0hy?=
 =?utf-8?B?R0tjYlJhVmRzSmY4TWxLalkzeWdRNGd1Z0tDVW9uVXhrSk43Tmpyc0UzTnZa?=
 =?utf-8?B?RzQvRTVBKzNhMXBuNWl1ei8rUERxYmN4MThjQ3RybHFIRE0xKzRYdkhtZUll?=
 =?utf-8?B?LzVKdkVnQy93V1RiUzR1K3Fnb3hHejZqZUZ6MG5kc0RTOUdKelM5M3NWNXdQ?=
 =?utf-8?B?bUNVTWg0V1hHMDUrNk5oMHVWQWRPZnluWXdJNm1aRlVMemdTd0ZHd3gxR3lC?=
 =?utf-8?B?WFhpanUzZEFpZFZGVktqckR3aThYSTYxdTR0bDRwVHhTZy95aS9PbGtSaTlX?=
 =?utf-8?B?VWNMUExxV25hSnRDVTZsRUx0dDNOTnlZS3lDbWJ4SGd6NHd6cGgxdGcwYXdG?=
 =?utf-8?B?eGxqZnpJTVdtZTdIR1J2VSsrSWcrNU5wRlZqaVQ2K2YvVm8zRWVIQVZ6cVVa?=
 =?utf-8?B?UUxJd3JYalFBeVFha0RrbVJSb3VxL1FEcWhLcVB2V2dZR2JuS1VNdjNzbkZ0?=
 =?utf-8?B?UkdaZVYrb1FLSU9MOGV4c01Hb2FXTWZOd1U4RGs0a1F2M0RpT1ZhQk1PV2E5?=
 =?utf-8?B?NzloNVd1aExwbysvdXczNFE5NTVlUWwxVUdMS204TTBBeXVoTHJyQmdRRHBQ?=
 =?utf-8?B?NVJoMEl4bmRONzRlSU1HWXkrMVN1MHRlSFBnTUM0R1ByQlg2SGNqVGpMSktL?=
 =?utf-8?B?SjlRSXlVRks2TmQwNldNV2tkZU9wQkUxNEgrcmdmOC9pbWpBZWV3VGxlNkov?=
 =?utf-8?B?WWpQdnBhbkpORXUzeGZZU282RTN6VFFWVEhkWjJzUTR2REVxK25VYTlzRGRG?=
 =?utf-8?B?bENnaWVrN1BveE0yOVFkNklmZHljRlVIN3dKUHdDZmlxOWZOQ2xPZkE0OGdY?=
 =?utf-8?B?K2tQYUY4OWpUZG5pRmtEMVpnRWhQNTBCbjhFdDFtbU0yWm91Yk44Rm10Mzll?=
 =?utf-8?B?anJmZks4Wk5FSUZtUTJiL3JrbkFWdUx6SVd3YVVNZlFiNnpOTzBnNHNSTUMr?=
 =?utf-8?B?V1pKeE1nUGlxNWtUQWpoZlZhd3l1dnFSWUczUmZHd0pLcFlpZVppZHNTT2N0?=
 =?utf-8?B?d2hKNEQvbHo2TEVHQXdxejZEUUF0cHdRRnA3YTVMaWRvM2JTNGRlU1g5Sy9U?=
 =?utf-8?B?aVhSTHZNVm43QkkwbTMvcG10NGE2NmdmOEJmaExqTVlmbVN3RFl0RWxoS3h1?=
 =?utf-8?B?RzZTMWUxZklrWlV4Ym9rZmtKcEVOdFNwQlZYTTlFRFNUY2lZUzU4L3R4K21j?=
 =?utf-8?B?WVVXaEZMeUo2TE1uTXczVXF3NW9HNkdiZTFwZHNjbWNRWnd4UG4wTStxM3Rs?=
 =?utf-8?B?QnNBYmkvTHZFeVpic0h3TjdjU0JnS0NieGllVmNERWFXZitxNS9iR1MxeGVJ?=
 =?utf-8?B?YlZqa0tJTHU2bHp3VktuZENQdk81NURYUDZ4VUp0YjVFK091OFJ6TnRHWWlY?=
 =?utf-8?B?M2xFT0NWT05nL1F5NlR5dU9HS0p0Vy95am5XUDU1TWVVNk9QRkk0WkFXaWEx?=
 =?utf-8?B?UWJQZEdEbm82NzBGWWlJbnBzaWZzMDFSYW8rSWZScEFxUUFZUit0Nkx0L2NR?=
 =?utf-8?B?NGU4Ny94NmRnVWVZWUlsSGVZQXNhZ0Z1TjRkb2VOL3pBMEhtZkJBTGZGQ3Rp?=
 =?utf-8?B?ZkZyaFczOEd4UUtLcHRON3FLOUVHdVBoNnN2S3ZTQzlkTHViRDlHZE9yWW50?=
 =?utf-8?B?WUtXOFFFdzF5QmExZ3R0eERSQTJROGRaYzFXeXMrYlZYVG1hVjFwZGxQZDRk?=
 =?utf-8?B?cjJEY1NJbTFqYkt1MUQ3bXJubDdxUGxubnI2T2F0Q3RianVld0xPV0FBamJG?=
 =?utf-8?B?dERqOUdtZkdRdmEzVVdQMlg1Qkkyb1J6ZGxVRTNTK1dCeGZVelVFOVZTU1RE?=
 =?utf-8?Q?pBN925xqxkeA4oCGhZIycoXlU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9f8b96-86e1-4681-d28d-08ddfa921ef1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 11:12:44.9784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Coc1L3f047gZFflkrKG3L+VZ9x2G9qhbdL/O9RDhbSwtnK9UHGq1gkvvhnN+BHPfF7eCd8rAIK3ohuiQCxhJpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7919
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

Add support for the optional 'phy-supply' property in the ENETC MDIO
driver. This allows the driver to enable and manage the PHY's power
supply via the regulator framework when specified in device tree.

Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/fsl_enetc_mdio.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/fsl_enetc_mdio.c b/drivers/net/fsl_enetc_mdio.c
index c1d491f2c5a..3d76d92a62a 100644
--- a/drivers/net/fsl_enetc_mdio.c
+++ b/drivers/net/fsl_enetc_mdio.c
@@ -11,6 +11,8 @@
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <miiphy.h>
+#include <linux/delay.h>
+#include <power/regulator.h>
 
 #include "fsl_enetc.h"
 
@@ -135,6 +137,8 @@ static int enetc_mdio_probe(struct udevice *dev)
 	struct pci_child_plat *pplat = dev_get_parent_plat(dev);
 	struct enetc_mdio_priv *priv = dev_get_priv(dev);
 	u16 cmd = PCI_COMMAND_MEMORY;
+	int ret;
+	struct udevice *supply = NULL;
 
 	priv->regs_base = dm_pci_map_bar(dev, PCI_BASE_ADDRESS_0, 0, 0, PCI_REGION_TYPE, 0);
 	if (!priv->regs_base) {
@@ -144,6 +148,27 @@ static int enetc_mdio_probe(struct udevice *dev)
 
 	priv->regs_base += ENETC_MDIO_BASE;
 
+	if (CONFIG_IS_ENABLED(DM_REGULATOR)) {
+		ret = device_get_supply_regulator(dev, "phy-supply",
+						  &supply);
+		if (ret && ret != -ENOENT) {
+			printf("%s: device_get_supply_regulator failed: %d\n",
+			       __func__, ret);
+			return ret;
+		}
+
+		if (supply) {
+			regulator_set_enable(supply, false);
+			mdelay(100);
+
+			ret = regulator_set_enable_if_allowed(supply, true);
+			if (ret) {
+				printf("%s: Error enabling phy supply\n", dev->name);
+				return ret;
+			}
+		}
+	}
+
 	if (pplat->vendor == PCI_VENDOR_ID_PHILIPS)	/* i.MX95 */
 		cmd |= PCI_COMMAND_MASTER;
 

-- 
2.43.0

