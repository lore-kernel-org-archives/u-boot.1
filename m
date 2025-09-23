Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBA7CAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 11:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 982378353A;
	Tue, 23 Sep 2025 13:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bhI3CHmd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C1E28357D; Tue, 23 Sep 2025 13:12:31 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 330C28353A
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 13:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGTS58BKbH3uQ1q/lzZx1aGkmqtlJCZpS0r07X4alR0SLoVxZT15aYhefjd0Xf7RpTP/M+M4lWzXWrvc2dO0Vu5LE0/7jjarsVCfajQrT4O3Nh3Xd0/A0F/w5TOKO4iHGjOt4WuoVgx8Kk0PZkwe/qSsmyb/3wLX6SHZVURZg2LjMsrSa8P43yeYXsKbGCbo3QcuMSG+xyg1wtCAQY42wsjMxclSQm4eqOEmxGtgM05ChVTz+MU9XTUe84IL8TUCR3uI9IKAmm+w6GYpHhaNeLHh3LJj0pBqBG04j7EjyyEDEvPFZbyUTWAXMQzVEDrV3kL8fbpUcnMHtQkNWMbskg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZB01zrYX9LxPUoEeAm/9Yp9e9U0vsTxpq8eLAHBIPSM=;
 b=iGFuYY7lUy2XkTob9slF28kBoxXu5VxUSsyq3R/Ld25sNJO7hNJEv6MDt/IVkN9KP1rPyuln3azVObGC7Fvq3e1zsiYzpJ2fqIIs4vAcjYJVPrsvq39nAgTh/j8vw0prWdv4Uzvsa+HeS+3XuvmgDOTm1DMiJVrqc6OG/VcJ03avProjZTlg2RRKCKz46jsv/KgBHEZtjRuocboUSnEQNCoP/juboNKfQKXXj5lQeLLHDVIrixVg7VcaVXORWFdbQTssyBxAa3oh4KmSXqljIy3O6+CS7JZvLcIYF8WKYhgNru8F93nyoDiwr4JVGbV2pOZpgWeI4e6U9kPOVkFCMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZB01zrYX9LxPUoEeAm/9Yp9e9U0vsTxpq8eLAHBIPSM=;
 b=bhI3CHmdCTRb4R08+eogZcWI5hj6Ol4k1P5LCEb2AbsPMmlh5nl6HPLbAQhnm6mVI76XE3k7yYXsKsm+Zh+d4J50p7X/u6m9pbzfp93WuGsGS42nCeSApp4WHw6lTxe4tIPXJXz+Bk/Lxug07KgzdjY7LRr8NtbY+Nap++XNpkD+v1YCk/rllb5J4wOCgiUslf2hrKiI8QJaI1dMGug2HPNFmculXDo+b0DQVp2jtuv7QrOyM+wV+DA5IWHx4uoJmQgAqIdMDyLZrY7bV3dMoqHLrDWIKimCJo93qSSpFMiW3KO+o/DNLzMfC923BM+IEuLbct8vDOsulJjxcXeOiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB7919.eurprd04.prod.outlook.com (2603:10a6:102:c1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 11:12:27 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 11:12:27 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 23 Sep 2025 19:11:49 +0800
Subject: [PATCH 05/10] usb: f_sdp: Update SDP driver to support PQC container
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-usbnetc-v1-5-507cddbe7214@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c47f13ac-d3e0-48a9-f488-08ddfa92148c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bU1IZnZZT3d3QVYxODgwbXNQTmZ4T3RlMk9jWEVudVE0NExFQmxQTWgrRnpP?=
 =?utf-8?B?SjNOeHB2RTZxeG5MQnA3SU81SGVJUFJWZEkvMlpFS0JiVHUzQTFUamFCVS9p?=
 =?utf-8?B?b0pORmhGRHE0amtCUGw3bFFXbUJpN0VtV3Rjc0lMS2RhaHQ2YVRUb0d5U2VQ?=
 =?utf-8?B?Y01taktYcGZHWDBYc2ZPQ2FlMHpKWXNQUCtRSkZhNG5EemM0ZFNnZzMvUlcz?=
 =?utf-8?B?Qnc0OXUvYXFGWHdXTHpvdVFxSlR3NFN4LzhNbDlMYWdLZzFWTGN5MVI0WktJ?=
 =?utf-8?B?ZG5zRzZrOVpVZUlzZkFld1R0NDFheFBUdVV5WDdCRnZRUEtVc3E4bi9VSU5j?=
 =?utf-8?B?djVITE1FcFpaMkF1MExmTDJmOEhrSVFwU3JWcUlQRC94UHpOZW5FVUNOWnlh?=
 =?utf-8?B?dXFaTXV0RXJNbjVFaWZETEVYVmkyNVFPS1JaaEEzRWJpb0t6MmhYM0NpVG5u?=
 =?utf-8?B?WGEwMElrN09id09vMElzRUNyRFZuclZ1UmFubEc1TEl3bTRVdUZJMzcvdDVp?=
 =?utf-8?B?cnRjbkx2Yzhmb3FGOGJ0RG41OENSeXhKS3dSdmdmY3d4UHBlY0l1VmJneHBU?=
 =?utf-8?B?ZUJpcU8zRFNURFltdFl2SXBUVCt5dlB2dG9QRzhraUM2amhoWklBaE84VEQ4?=
 =?utf-8?B?K1NuRGJjUmRLRHZ1WUM2SEVzRE9pdjlra2tFZ09Wci95dGJNOXVscW5ZbTM1?=
 =?utf-8?B?WTVWWjk3eWJwdGNpc1lOQUpZODVXVXI0RmxUdVJSQ1lCT2JQd05NUWNSNlNR?=
 =?utf-8?B?SWFrTWJCaWpCUmdhYUd2blFmUjhwTnhoRlp4Mk9RWmlVN0tRSUxxRnhuQ2VH?=
 =?utf-8?B?cmRXMG8xajNUTHpYdVV4aXFtelZjSUdTUEhSdG42cVgzRHFDelEzb3FGcU54?=
 =?utf-8?B?WTdJT0E2NWRvNGtBRTNPTi82cGdJdDA4RzZKSktIZWNaUTVISHBjWlU4S3lj?=
 =?utf-8?B?MEkxUzJyNzF4dVVqRUhXS084djYvWG5LaHFLZFlZNHYvNUVObHRmMHNTYlRm?=
 =?utf-8?B?cE9BaGFSUlBOeVZ5MmNPODJKd1JpZklkVXZ4N044TGp0UU1yWnlMVllEaGVY?=
 =?utf-8?B?TkVWd1ZlcWZCejY0UTBlY3FMQlhzTVZKcDFydUxoWDdWT0tHWFFGTVZLYjgr?=
 =?utf-8?B?MktMbWZMdHJxbHBCcGE5VTAyek5Jbm04MHlZQ0tmT1dkZ1ptcnpYVWtyUHBt?=
 =?utf-8?B?clE5Y1Joa3hzQUhLbFNtYzN4QjNiN2NSMWpUUFZpdWxOeWl3OFlEcm5nQXFQ?=
 =?utf-8?B?K2I2SUw0dzVLblIxckRMZUJsdVdFN0Y3dVNvU2pJNDRia1cyOWNibStzZDJ5?=
 =?utf-8?B?K3d1SUVtR09rWi90bitoNTNIV1RuZ0hTYitVY3lpRnNpRzF5L3ZZR0cxQ2FM?=
 =?utf-8?B?ME50dTFVTVpFc2RoT0FPK0VjcFZNOFVlWi83c1RkU1FNcjBUVjdwVWZGdklp?=
 =?utf-8?B?RHo4bUZnTnc3SGZBcHp4QzN3M1A3NTNPVzErRnprT1MvOGtKekNWbWUrMDFO?=
 =?utf-8?B?ek41SmdsTGMzYXo3TGJxeUx0MTBMNEd3RWpydndsU3ZkV0NyaWVHUW9VRHNn?=
 =?utf-8?B?Qjl4OVVCTFRPZ2o5WE5udlFiRE9IcEVaZ29JZXZBaFVoRWlMT1FJOVg1eG1l?=
 =?utf-8?B?ejRERzExSVZZakIxZ0c0V21pYVYzZWtSUE5BRlhkZ2VVbkRsbEszV1NtWklo?=
 =?utf-8?B?RFhQTGRWeWxmaHBhNHR6OEZWdjErb042cEtON0Vpb3dHRklJWWtiZncwYkRZ?=
 =?utf-8?B?V29FbVZVYmZEb3JiaWFMUXpaY0c2OEx0S2I3YVpLVWNJQW8vWUhwd2pWVFNt?=
 =?utf-8?B?Zkx3dUNRUEpJQnAvd0NHVXcxNlNCajJhYkNFTHhIUWZ2V3VwK3lSVlUzeTg4?=
 =?utf-8?B?ZDc0MkhKeElVbWVad3BFcUlzdjRRNGh4NjZDMjhhQmxaTmdtcHVlaXVOQThG?=
 =?utf-8?B?Rkd1M3BLUCtVSmcxcGNQSzVrdFFaNmIybTBwSGg4TXdlWHJveFVVOXZzcUV1?=
 =?utf-8?Q?BvbRtwT9d2vgj0MBJJu9YL+C6MVeds=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(19092799006)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW5EaTVNSzM2bzNiaFMxbkUyQUpSZzVNb1hLQ3ZtQ1ErTnp2c1I5YkNKZDQ2?=
 =?utf-8?B?T3NPZEZJeGMyaVRnYktQWWxwOER0QjhRNzFwTnRpVUZOZkFnbE1FdGxEaGM4?=
 =?utf-8?B?VVVaY01UdllPeTBTKzlnc3ZETWdyWWwwNzNSQlRqZlZjWExacUZRWmMraVJS?=
 =?utf-8?B?dENjb1BNdTQ5Tlk2WENJWE1vaEZsMTR6L1lWcXVDQkdhUEtiUXJ4bzBWMXkv?=
 =?utf-8?B?SHlJQlJ5SjBsRVZ1eTQyOVVhV1p4NTVKczBRZHIzdnpCNGFEZTR5Z05lbyta?=
 =?utf-8?B?Vk9rL0NvbElKdlNUVGJyTkFrcVpPTExPempYbVhhR1RqVDVSZFRLSmtKRjM4?=
 =?utf-8?B?VWR5T3JNQUp2SGQ1NzNkYVBKUXBOTzlLOEIrYk03eFFUYkIrSzN0cFl0UGht?=
 =?utf-8?B?Y3gwUGswaThuMS82a0pSUzJ0S2YrMDJNQ2RrOUxqMG10KzRHYXlNUkVXdWMx?=
 =?utf-8?B?NWhWN0h2WVBQZ3pWY1lzV0U4VmlFa0pkS2pJK284QjJzNURvQ1RuUFRETWx6?=
 =?utf-8?B?cFM0RGdlREJ0L2ExYkRMSC9uV0tqUG96ODdTamJRYzJCYWRvbmNOVVZZazBV?=
 =?utf-8?B?VGVjbXVQTWtQREc2NDBWZHgwdm5UTHd5d1hHbDE0UjVnYStxRUptWTdUdVFs?=
 =?utf-8?B?d21SenVqbFBMc2d1ZWgyeTRpTHF4bXpyYU91WnNNbmNOd2lWV2l6QVJuTFBy?=
 =?utf-8?B?dGhMTm80MWptUk4xUytqM0VRQ0xpalljNmdnVk1rZkxvRmh1UE5aNHEvbWtE?=
 =?utf-8?B?VjZnckd2ZHArOW9ZQXZRQXh4TFg2aEdoQzc3V2h1YUQrUmpjeDZQaFVKTkNa?=
 =?utf-8?B?U2R3WGcwa1JIY1JwOVdKbGlWNW50TWZLVzdjOFNDSStGWTFjYWc5Z3g0bUhE?=
 =?utf-8?B?YXlKcnVLeDJDVDc1MEFnR2F5V2U1L1A5TDdXOVliUHdzVE1SMVVRdjg3TTE3?=
 =?utf-8?B?d1lINmd3ZXJBM1pIYnR5RDRKZE11WWo3aUo0b2xDa1I5M2Q3bSs0OU9UKzFL?=
 =?utf-8?B?MjUvMEVMM1Bhanc4SmEzM3BIeWpEbktPOHJrbUpJYnJ4dmtjL0x6aTdRbmtD?=
 =?utf-8?B?QlZXdzRUZk1obXpaWnU2dHBsVm8wYy9BRUhPM0FFdG43ejZOSCtlajJBM0lI?=
 =?utf-8?B?Q2NlWlhxdUlvNG4weThWUklQMU5tNVhicnBFSWJpNFdzMDdRK0pWTHh0VXEx?=
 =?utf-8?B?NmgvV2dxZWRFZXdqWlVkRFlXL2RjdEJkRWZDRDd6MkRlZWRZODBkUGV1SnQ0?=
 =?utf-8?B?cGNGdmdNa2k1MXRPZzNGZnFmbjgvOTdrdmtXRlA1VGVTR1RqZlBranpFb0po?=
 =?utf-8?B?RGNwRTVuY3RuYk0xOUY0ZUN1bXI5cTRQNkhKd1A5K1FHdytkV3IrVFVVcm92?=
 =?utf-8?B?WWF0SUk1Qk5EdGVqZWkwcEphKzN5N082M3JGeG1TWmRPTG5peHo3WkIwNkZL?=
 =?utf-8?B?Zmkzd05pdkljOVliQituTWdYYzZTQ2FteVBUTDZndzRnL29FUlhyVDV3cHZ6?=
 =?utf-8?B?L1IvSkZyWFNSTkdvMVFQRGdOYmwrdjM5MzdVVk12NGdGa1c0N01OUDFiV2Vm?=
 =?utf-8?B?RXhkRjlzbzJWdVVESlB0dnUwcW0rNU9HMlM1czRlWFZTUmxVaGpXTFBlR0lS?=
 =?utf-8?B?cGZESzc1bjNYc3JwUVdkTnNla1Y1blNQTGRxU2ZZcVpKbEtNaHNPN1lURU5t?=
 =?utf-8?B?QldQQno4am9ZYlJsbzRJMmJvY0Nubk00TnlJQ01MMURFNHBPUlBhbDdrOEVv?=
 =?utf-8?B?dzlmZms4QXA4MlVxYjlmcUZIZ1BRaGlKbFdBMERPU1NXMDBvRFJTWDRHbHJo?=
 =?utf-8?B?WmhmVzBEM2hiaUgvbjgxVUl4M3oyM09na3dQaVNkNC9vUnQrMWV1TU1nbEVW?=
 =?utf-8?B?Z1BXUml2NVVXbDA1dkgvMjhUT2dkZ1RERVVoQld1K0hzNjM4UmFJcElTREZq?=
 =?utf-8?B?aE1scEY1Unh5S052NnVSTEQ1ajBiTnJ6QjNWMmV5aVIzbTBFZUl3ai9zNVVh?=
 =?utf-8?B?R3BOdzJ4eHBtNWlrbWdSRTV0akJIRk12L1FIdlJrTVBadzdEOU9sT3BWRVM4?=
 =?utf-8?B?ZVlFc0tnMTFyTjhKSDlrTUwzTk1wK2pjNHRDNzhDbHdQSHZDZFhYcmZJVCty?=
 =?utf-8?Q?LRx8f7iAYFNd/hHu82VBYTEJ2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c47f13ac-d3e0-48a9-f488-08ddfa92148c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 11:12:27.4950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rh1ymTa791w1TlCipPR8pZgYvwqCnN//arpiqsMJ0u5aHcQa4gGLE1k50Cu45GdA+XsESj6oR/bCpkY7VrwuYg==
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

Since PQC container has changed version to 0x2 in container header,
update the header's check.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
---
 drivers/usb/gadget/f_sdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index 647001d8dd0..f72e27028b7 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -765,7 +765,7 @@ static ulong search_container_header(ulong p, int size)
 
 	for (i = 0; i < size; i += 4) {
 		hdr = (u8 *)(p + i);
-		if (*(hdr + 3) == 0x87 && *hdr == 0)
+		if (*(hdr + 3) == 0x87 && (*hdr == 0 || *hdr == 2))
 			if (*(hdr + 1) != 0 || *(hdr + 2) != 0)
 				return p + i;
 	}

-- 
2.43.0

