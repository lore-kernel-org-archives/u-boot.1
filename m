Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB27D5B87C
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 06:39:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD46F80107;
	Tue, 16 Dec 2025 07:39:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JMv8xIa+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 669E680433; Tue, 16 Dec 2025 07:39:52 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BEDE8003E
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 07:39:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoRXz5Ca/oOIj3I9ski0krAYHEBH3RmBDXWCBVXExU/fLPSf3nAlgMEGmAVrWBfEWLhs/Y7luBSQo4N7c3pqg1eKGjvYLpzkMBzQTfX/tSkcXFpFNnbBlQyglP0uCuPp3GOGVu934JmmbyvZ6Hwq8A5KmPCVYZm3afb/qIC7ssHC6SRH3SgDzzxWjkHUvSWNLAGEttTN3s6xW657WQQPYxYs7oYzHUbfZQhHx20xHO66ZqfLwYAkupTri54UD/pSbOBFaNbba5Bga2SSeNYVvYHQcTXEBdnDdqZpktjy+DPkZBhK5QL6s8o8Fwwaky/Fvjecqa94MlQ2kdmgTdMYsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CSViLuzc7sqMldzDGShWbmS6IGEpIgJ4ZLsKq9QIMI=;
 b=nL+BVZHKpVdsk7YFyDFkc2nVOq/VPbE0EgzlCzEky5IbPKUzMDtRoZhGAKFUstRxq1e0Qg5BXTVkndmZ79Cevp7g/m2vtOSjh6c+R+T/17H1J5Wh1T499BJ/sJQkzPjhj7lH1Y5I+9LoFgl/aLBl0FJ9yqLlEDs2213vsp4a9OpovQzNfIbb3qR1CwLZZF06TGu03OU2WNwb7YhsD4h2Y8XWhq5vyAXJ0s47oYghDqcH2XWvy6zYKNeJzuBr2MSQVUw1PttnioACzTWQeCGf5Myu7kQGJ7QcB2NmNFGqeMTzab/NGCOIHuUvsovDNnxpLNGSwc4gK7arNUtumcC7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CSViLuzc7sqMldzDGShWbmS6IGEpIgJ4ZLsKq9QIMI=;
 b=JMv8xIa+B0wm6q1uU/uu9HfPPo6EdK+xm9Uhl5sfVfFt7CCsBDXwKpp3/TybHSEVsTm1cqGODtp2AcAC2OnZbwd4o/7hXbw+MZBycA5lgzAeBnjNxuXBTxHKexAJARul5VM1hj/5U0Qjt6uJK+Oct8Q/vhAK4aamLyL/78YKW/YczkBUgwJUxZzm8Z8QN47GID5uckhGy5VJPirIxzWj71CJFxo6W1EWeqkMPkN0M0WvCKUTgcrN/QW5Y/Pioaqa+uA52WDO97bldRH1jK+Gc3XMIvQMfMMcfQJzSHAKKI/cA7m1J4Kaxqw3pAV/CZbsgFb++vZJfuM0WtD2RKfP1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA2PR04MB10514.eurprd04.prod.outlook.com (2603:10a6:102:41e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 06:39:48 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 06:39:48 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 16 Dec 2025 14:38:34 +0800
Subject: [PATCH v1 2/7] usb: ehci-mx6: Fix usb_oc_config() for
 i.MX7/8M/9/7ULP/8 and 8ULP platforms
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-imx8ulp-v1-2-504115a53020@nxp.com>
References: <20251216-imx8ulp-v1-0-504115a53020@nxp.com>
In-Reply-To: <20251216-imx8ulp-v1-0-504115a53020@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Marek Vasut <marek.vasut@mailbox.org>, Ye Li <ye.li@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@denx.de>, Sherry Sun <sherry.sun@nxp.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 George Chan <gchan9527@gmail.com>, Simon Glass <sjg@chromium.org>, 
 David Zang <davidzangcs@gmail.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA2PR04MB10514:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b3a66b7-cecc-45f0-c06b-08de3c6de88d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VkhRcnJaMDlpdzlndUQzL0I5NmNGSHBqRk8wUU16b1p0d1kvbWR3T2ZDdVdt?=
 =?utf-8?B?VnVLcFlIVjVBK0NTT20xZ0REVmx6UDBaVis3emtHNmZuWktGT0VZekdaMmpR?=
 =?utf-8?B?Uklla2F5enAyYjVldW1SOFE5a01xVXJVSFF3ZmNQK0ZJWHczc3ljSU5XRzZz?=
 =?utf-8?B?cGRpSXFWZ3M3K1dyckFFaGJwM2hzMXRmWXR2eVF6cGFOQUZ0OXZkQ1V3UWRy?=
 =?utf-8?B?aXI0a0FVWXo5T0hoWGdIeTVjbzNIeHc2UlZHaE9uVjd3THVHOUNmRkltdmND?=
 =?utf-8?B?bjJwbzY5VjFRLytJMlR1SHhLNS95ZXlnZk9SS1Fwd1hvOVh3Y0tBMzRUdGpm?=
 =?utf-8?B?UDdMY2RaYzBhZW5SQUxHZEh4ZVlBSmhGaTZPbFJLcHprSnZMS0hoR0pJRm1F?=
 =?utf-8?B?MUs1T0k0ZVgwcHVhKzBsYlZ2MEgxYTRSb0dUbzE3dXZNN1ozNUloTW55T1M4?=
 =?utf-8?B?S0xOeVY5ZWNQaFBQS2NIQXZXbWl5eUtnN2R0THhYcndQWDB2ekxaRW9jbnhI?=
 =?utf-8?B?U1V4cFFtMHJWSDJSdktKdXYwbWR1SzhsL2ZQVTlvL29UZHFPbnJzWmpVcDF3?=
 =?utf-8?B?L2c1djlRRGU2RzFEMWVuL04veVlmUFNGbWVsZitwTGMxR0JySGxKeU1tdklJ?=
 =?utf-8?B?TVZkSXJSZU16MzQwTzFrcEZBSmV0TUJJQkJKZit3OEljblBtT0dxc1RQRXZx?=
 =?utf-8?B?VktaeXZFWU9RWDhTenBTblBJbGthc0x0anUxbzNVVktmMTQ0ajFPdS92YWJ6?=
 =?utf-8?B?UEwyYi8wSm9zaFg0anMwbnh2QUwyMGRUakJGZWMyWDZISTBmMTJpWGdFQWpx?=
 =?utf-8?B?cWR2UXVkY2JsUmkrYkhZQm05a094R1lwMjFYVmg1WGQ5bk1QYVAwNTNudmkx?=
 =?utf-8?B?V2tVclJtbS9lYjVITkpSbE9wUjJUN0VGcW5aY0liSExQK0VabVJSdU5Wd05k?=
 =?utf-8?B?NllPZmkyTXlVS0tEdjhybzB4R2RUQ3Z1VWdpM2tVaUFzalJTWkhscWR1MGVv?=
 =?utf-8?B?KzRHeXBEam9DcXlMa2tmK3BYc2VjbEhoZlp1dndVYzNVNGt2UEdKaXdNWXlJ?=
 =?utf-8?B?SDVCVWVzaFVVM1lqZjBZQlZlZkFGeDliQTNGOFhzNWhwaFY2c0NRR1MxaVNv?=
 =?utf-8?B?MVFCMGs5aWhFb3FHZ1lTOFlXK0tmWFM3Wll1RlJmL3NZTzZOMkVpenIvUkdF?=
 =?utf-8?B?UTdEZUs4R2l3MjJERldZUU90VHZxOUE4eU5SNnR4S0FkQktoaEpwd3ZwOCtC?=
 =?utf-8?B?QnF2MGI1Rk53TXd1Z2lGRHYrSmZaSGF1UWdBZkcrSE9rRHp0ME5NdWhaNE1x?=
 =?utf-8?B?V2RsM3pKWDJOV3Q5MGVXSnlhZ0NKSGE3akh2TTNEcnh5SUpCWHgvLzI5ellZ?=
 =?utf-8?B?R1ZjbUJiYzFzS0lwTjdpbEJ3b1V1YWp3U2J2SEdrNVRTaTQ5dThqU0ZNZ2N5?=
 =?utf-8?B?SktYTmRRZkg5bGFKeUtIUjVYbHBnUlZ4OThkaXluYzZWbytVMVVFNnUwUmpi?=
 =?utf-8?B?WmkxZzE3NlZKOVYxSkFuaG1WZTlFK2l4SzdBU3hRU2lzbk9ycDFCdXhFUng1?=
 =?utf-8?B?S3JmMDY1RFN0VEJoeEpNSysxaE41R3A0aHB3MVpYWjE5K05OclVlNzhYOUor?=
 =?utf-8?B?V2g4VjUzVytxdjZDRUsrbXM5K2dtV1M3ZzdhSVJLaVBhcmJXcG5Cb1dnaUVQ?=
 =?utf-8?B?bmxKdjVBM2tGcUNkSjhtT3ZxbkRxdEUrOHVaYVdQU0g2YmJjdUMzM1dhT2F3?=
 =?utf-8?B?dDZmTU15T1MyMGhsakR2dG5pZ240RXhUYUpCR0cvc3gxMzZwQUhDdEpQMFh6?=
 =?utf-8?B?ckk4L2lzdktaRTZjalk1VG5LNnNsdHFNak44UXIxMXJ5V0E0RDZjK0lud2tN?=
 =?utf-8?B?UWJsL3RZQ3lyUmR5TkpURkc4WHRmcVorZnpKeVB3dGpoMFNhMThaNXhreFdL?=
 =?utf-8?B?TlRuNGpCMzRVa0dFWlJ3UjhvMVpNUTQyK2FlOFR3VTB1ZWFBdGt2U2l1ZXNQ?=
 =?utf-8?B?SGZvRTVJRHI1NEJSbERBcWpSN0tVOFdrSDVuSDNsY3IrOGkxcFFmdUhjWWFl?=
 =?utf-8?Q?rvbT+K?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFN1Zkh1ZFdvQW1FQ2FjRlR1bXVQQzlOaVFVb09VZlY1WmlMKzhTdWV0RDR6?=
 =?utf-8?B?dlAwamhZUG1aeVdsNCs2ZFFuTmFGc0htaDUzazR4QUNndUlzYjFlajZXUHRn?=
 =?utf-8?B?dDB2SGphQVl4c2RXVUk5ZFRFRy9USTc4SEM0WTVuS01HU1lTNFVUU0RlOGw2?=
 =?utf-8?B?Zy9CaVVjdmlCOC9oaG1RVnBDVDJZc1U3eEhVemIrL2FSYmE2NHJPNGZURzI4?=
 =?utf-8?B?ZVR4K1hURHIzWVBPSi9wcnJueE1LclBpTGR6SmdTZzNWZGt4VkhJZ2hFWGFH?=
 =?utf-8?B?WlZ1S1NOYjQxQUFreUpSWlFnUzM3Z0gwbDFGOG0zcTVpT3c5bEJtemk4dmI5?=
 =?utf-8?B?TnJ1OEwrQTB0Wkh6bVNqRGFidm5XVnBkU0V0YmtScTdzaFNiOTQweEhxQjgr?=
 =?utf-8?B?R2EvRWQrYVhpd3VaazhyK0NMU0pGK3E0aGE3Sk9QMnR3ZFlqRE1rWDBhYkJo?=
 =?utf-8?B?TGZNc080cldvd0VXS1YzVzRnT2xPQ1BBb1FLcjI4c05vb2dXelgwdEVqaUVo?=
 =?utf-8?B?M1c4a0dNOXpacFg1WVM1Q2J4SjMxUjFnOTF3OU9ON2I5aXJ2b0ROQStqSVYv?=
 =?utf-8?B?cGdMWWV4cGZWTjF4L20yazRQZGVmazNMYnBtRVpzVDdaYmNRNGVjdk9oaG9U?=
 =?utf-8?B?bXV4VVZsTzVtTm95OEpielZ0QzNnSm9FSC83WlZCUENXOWxMa2J0emlSKzZy?=
 =?utf-8?B?QzFFWjlTRXQxVG40RnBUZEdpSHVwOUtjZkl5L3RXZHh4Y3dNVGpwODZnTkps?=
 =?utf-8?B?K2pqRDI2MjBFd2drNGc0M0RUQkZkMnIwanR6eXJ1S081U3I2Ym82cDRtN2lw?=
 =?utf-8?B?bjJsQXVWMUprYWlVZmZqZUl6amtHcWxqWFJCeGFRdGdjVVdnTWhqdXBMaitH?=
 =?utf-8?B?ZEVRRTNJVGZ1S3RKZktSRjBUTzVhUVljNHI2RUJsMUZ1WFpKWmdhV0dUWGZ6?=
 =?utf-8?B?WGlKQ2xqYnpVaStuZGd6QjB5b2hKdVN2VnI1cm05U0VoYy96cWI5Y0VMSnhT?=
 =?utf-8?B?VnMvZU9PZkEyRHRTdnFmcmZKNWRMSWhsdk1kVnhQMFU5NzYzbWdSOEdrWGhw?=
 =?utf-8?B?aTNHZjd5YnRJU09rWjVFQjEyRTBRSFBhdGFLaUJWb1BtaHhsSHlvQnFZeVB0?=
 =?utf-8?B?bUJFazdXc1pBTjliK2J0c0hBTTZmV1JNOVVqOW5IRDVOZW1QTUdtWHdWTE5S?=
 =?utf-8?B?cVFHNlkxK0xWbmtKb1gwQ2lvRXQrdjUvdjlDRjlaS0srSXovVHlta0ZVMFNE?=
 =?utf-8?B?ZHlGMjBFSzA0bkQ2a2ZOdVZQalpqVGlhN1pGSXY1ano2ZVAvRUVaSWZRUUdM?=
 =?utf-8?B?ZytOYnAvR3lXc0F2NDBOTUJ0TXJudFcvc2o1MmVOQm5SZkZxbktJTjRPZ2dB?=
 =?utf-8?B?K3c2N0h2aDlzQnp2d1UyRzdOSzJSbDhWSjlGWGJjZnV5Y1l1b0IwbHM4SVh2?=
 =?utf-8?B?REJiUHNtZ1dYdXErOStpYmR4cnBsZ2FacEYxZ3g3OXhRcWhyT0ZBcWFTSnpp?=
 =?utf-8?B?YkJUOWk0WHM5SGFsNlRkd1h2YlBNaW0zdTY2dUZMOUh5THY4M295SU5xYXpV?=
 =?utf-8?B?c01MbnpUbDJWTk1qZUdjeUMrZkc5eTAyQWtwdFVFa1FEVTNUb3dJNWUxZEhq?=
 =?utf-8?B?NkZER3hsMC93TXZCVkxwWDYwcGUwWkFCRjN6TnZuWXhacGtqRXE3YnlNdFlN?=
 =?utf-8?B?cTJPMzlXUk9JbzVpSEpWTTJRanRINlBmcDQ4U21LSzU2NmtLUFhSVzJNWElh?=
 =?utf-8?B?eXRiUERJK25halJPWUphRVBJdDhrVFhCdnlLZlBrQVpGNFRWNmloc3E5eCtw?=
 =?utf-8?B?bU54eUY5NldGWWdpNllVOHFjN0poSW12M0xGaDNpdEE0K3JNSTgvdm9LOGZ3?=
 =?utf-8?B?VlovWC9nVDVLQW9LVUhCUVg2d3BXZzZSR01CdVlXOTZyVTBZMEtoNFJ1Vkhp?=
 =?utf-8?B?ZFR6SzJQdWNtaVJady94R2lxVTdPSnREdHlrS2p3NW14SXMvK2Q4YjU3cllJ?=
 =?utf-8?B?ei9QajdETzRyYWQvSmhubGp6NlNmdFg3L2t4L2E2T1B2a2RDaDlYQnVMUXhl?=
 =?utf-8?B?YWdqdGVOamQ0aW9OQ2RUcElSeFBFVGc1MDN6YTJNUVNyUUpSS0x1R2FNU1BT?=
 =?utf-8?Q?T6lKWSFc9BrEpX2eOsQXHX14V?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3a66b7-cecc-45f0-c06b-08de3c6de88d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 06:39:48.5346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cA20dM0So3Z9Mslgklm/5lJAMKI3N/hWbhEEZm1a9c15ShJXphlrUUXeJbhY9LVZq6qJ5QQ0EdAXFV/opfpDQ==
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

From: Alice Guo <alice.guo@nxp.com>

The usb_oc_config() function previously assumed that the overcurrent
control register index always matches the USB controller index, which is
true for i.MX6 but not for i.MX7/8M/9/7ULP/8/8ULP. On these platforms,
the overcurrent control is located in the USB OTG Control 1 register,
which is always at index 0.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/usb/host/ehci-mx6.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
index cfaf49d67f0..03ff4ce10d5 100644
--- a/drivers/usb/host/ehci-mx6.c
+++ b/drivers/usb/host/ehci-mx6.c
@@ -280,7 +280,12 @@ static void ehci_mx6_powerup_fixup(struct ehci_ctrl *ctrl, uint32_t *status_reg,
 /* Should be done in the MXS PHY driver */
 static void usb_oc_config(struct usbnc_regs *usbnc, int index)
 {
+#if defined(CONFIG_MX6)
 	void __iomem *ctrl = (void __iomem *)(&usbnc->ctrl[index]);
+#elif defined(CONFIG_USB_EHCI_MX7) || defined(CONFIG_MX7ULP) || defined(CONFIG_IMX8) || \
+      defined(CONFIG_IMX8ULP)
+	void __iomem *ctrl = (void __iomem *)(&usbnc->ctrl[0]);
+#endif
 
 	setbits_le32(ctrl, UCTRL_OVER_CUR_POL);
 

-- 
2.43.0

