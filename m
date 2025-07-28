Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E74FC87FCE
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 02:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADE8583013;
	Mon, 28 Jul 2025 04:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mgtezmSo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BBC982F14; Mon, 28 Jul 2025 04:14:44 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1989C8313F
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 04:14:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lgd/kbRh+O0/j1UVT4hdBpymmQZrcl7TU9PLzkhTVFUMNg3kEIE0e8Mr5GFZDgEww/nK3NoM6LLU31FfJ5pj+105+7e9ofoyxc4UUEsOOOoJImwaJEmEnMJIQXkID17dHaTb0T1hQYyhcQIt0wY27sr3vlIRWSRUXzP7YtX5z9Dxx5wTeFZ0S/csgwOcG5gpzbDAGYbFe8MDpLo+uE8A95RhqsLymP5NXgNWgkJESbjArpSsfu5izzHmODc1hf/t4w14CD2khSo/28JYDYspPxRCkYJsVErJgqRWuE8Up1jFZW1wpbnXU1noCh8vUt5/i7rnbV8qw9/xOfW7SmwfoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2tLMmIk2FhDW56zO+U5Ug9azumrLRiZtgV6k70lxok=;
 b=KanVyoN8OUP9DRjPrXbcaX6zKbkgnUAVSnxlwAsOeWL8PXLiaU4HDFNiEvkmJjFAw80+QrTRmY3oQ6Q430XRcjRBEclY9NmvEn28eFESqLCehPhVZAujoEYJFdqK8Es4PfjYSIkqXsN+iOCOg0noyTro5C5x8thex486zya7JojKETtBvT/5mAdGkzjzc7ALdGAuv24imAH53aS4zO/DjmJML/+skif10neM/hlo3Mi0OYXewLBi57NEQtwKbFbYbvmeb/WhAOLH7+0N0dCD1/x3Ny89pEGj9hy35dWS+c3a4yHWpsdqRkj+cAqDH0NdIOqV6WO9Hy4LwGZBnYR7zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2tLMmIk2FhDW56zO+U5Ug9azumrLRiZtgV6k70lxok=;
 b=mgtezmSoiTOfbNQ/+uHLQ276Myo5g+JkxKhIDIEpEBmkkjYNN9me3dx+EGzSOITG2ZO/CeQi4Nlcmh2+g7T4YL21nPsxoYBBN6KcbupALjL5asaJ38fkCKy1SpI1qegpjo0HmrkLzM59XIA0YDcjfN5pNSOEWiekCO1wKpsi0c89fD5gROSB7HiCrR3J6qw5SFeQ9/JudY+nbnWOi7OFN8mjUWJznlO7CcZDhhsCVd71WpxKZRqEigHsb4yaSN7ASBcQgRnx0FddnOIosEvkOdMPU6AwqJA0LnuEEtqHvs5R8Lceou7HExtxhHyP5Zf/+/z1BkKmohedciz2FtpFKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8546.eurprd04.prod.outlook.com (2603:10a6:20b:421::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 02:14:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 02:14:40 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 28 Jul 2025 11:24:52 +0800
Subject: [PATCH 6/9] ddr: imx: Move reading LP CSRs outside "ddr_cfg_phy"
 function
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-ddr-imx-v1-6-73da75bb33d3@nxp.com>
References: <20250728-ddr-imx-v1-0-73da75bb33d3@nxp.com>
In-Reply-To: <20250728-ddr-imx-v1-0-73da75bb33d3@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Viorel Suman <viorel.suman@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: MW4PR04CA0277.namprd04.prod.outlook.com
 (2603:10b6:303:89::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b737bb2-87b5-45e7-3aae-08ddcd7c8247
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0lOOXFyeUV0TzRMUVFsa0ZwODIzVUZjaWxpQUlCZlNLeWFEVlFqOFdYdHRP?=
 =?utf-8?B?Wkg0N1dnU0QydHE1UU1XdUtjaXhEM3RRRUtBcGN5bjFscGhSQmhqeHRmZ1Vn?=
 =?utf-8?B?d2JIQUplcTJWZkdHbXhvZHhodmZKZ0d6SEVxRHFFdkJrdElVWUw2aGJDdFFn?=
 =?utf-8?B?MVBqQ2J4aHpNQ1RGeUdsa0NTYnVwcFBJSUNhZlRjbFE2akJLQlpuVzNLc1dj?=
 =?utf-8?B?clZwbnkrUk8rU2tQbjdvWGdZRjRkazZibG5NTURpWHdzNmRjaTBJdVN2eEtZ?=
 =?utf-8?B?YlpjZVdIT0lZZGNTUlNwK29xNE4rREp4T2lDTTJZd0ZHUG1ubWpFUDJNNDky?=
 =?utf-8?B?QkZMS2l3OGQybU9lU00vNXY2VCtZcUtHVVpaNWl1VWs5SE9Cd0t2ZzhzRWpp?=
 =?utf-8?B?bUJHczJISDZ5cVE3M1llNUc4VndNQjVLOFVxNWJVRzZQakxaOHhFTWZHSTlw?=
 =?utf-8?B?THROcStyUFRpeHkzZmZlMzBBSkVzUGk5NFN0QVRQeVhZb0pJR0xMc0FJMUJa?=
 =?utf-8?B?MWx0OStSdG52cEhBbzJCSkQxSU9mQVBNSGpBZEt4d25PWE9aRTBmc0JLay95?=
 =?utf-8?B?cEwzK0NlcWE2R1k0UzExWm5HU3FPRHoveWNRSVNwUEE3dVFsWTVKTkQyVVR4?=
 =?utf-8?B?cU55QmxHSDc5UFNUL1Nob1BHWGVHTEtLVUZFd0FESVI1bmhIL05meVZFQmV3?=
 =?utf-8?B?RDduSGJycmdSVVdyZEQ1VjVQcWRxTXpIS2NVWXNHY2hEWXpMY3RmQWp1VGIx?=
 =?utf-8?B?T25vNldtOE5UUnEzM3VrTHNLMnJPQ0ozYVRvaFAwdjdkZm1rdjg1TGkyVGN5?=
 =?utf-8?B?QXlSSWhIaW9FUGVrRGcyd1oxdUJ6YmtpU1ZCZUZFTHZnY1o1Vmc4QzB5akx1?=
 =?utf-8?B?K2kvU1Y4R1phOHhJZGNFbmtyU1htbDZVUzBiNFFtZVpFOG9BZmhJc09EV21L?=
 =?utf-8?B?OGU1dFJZOEpCckVrais0VVg0OS92NjVkbWpnYWM3OG1iSzc1ZWUvaTJYNkZF?=
 =?utf-8?B?M2NSWWhaTStXVUhEcGNDMjV0eFZ3N3J1TERETDNTZ2lUb2xNSGpQNVJkeTY4?=
 =?utf-8?B?RlVzMUxPM280dk5kaUhiUWF2TisrbFZtQlI4VUpuSDdvQjlnZ0ppSGR3M253?=
 =?utf-8?B?QTBMUXpDUWZsYVBkVE5YanlJNGRleXV2SE5OYjJ1a3VtL3l6OWVwUEM2UGJj?=
 =?utf-8?B?RzFwallsSm5tZjltbS85a2xnd2dnUDdSdHhZeURhTUZlWmZvaFdNK2RubHdS?=
 =?utf-8?B?WW5WODZ2TTVySm9ieUNKVmhNSlF3aHUwTFo3cTRtd2JGdHp1NlN1YTNXSUVK?=
 =?utf-8?B?bmtZMDRnUDloUW1DZFZ0VG55eTlJeFJrTlFUQkJIR0FKV2oxQ1g5clVITllD?=
 =?utf-8?B?REJYOXBGOEdYc1J1YWx4dWhjcXlUaHZLeFRBdkl6YkdtOWFhcjJXTGhBNlBM?=
 =?utf-8?B?MEttRVcyT0IrYkVwS3k2c1JwK1c2T3RpNmxnaUgranFSSzBsR1pqZmtMbUYv?=
 =?utf-8?B?bHFsV3g2a01EbzhWUFdORllobmE0VVZiWVJycElJWU16bWF5YWtGZEo1Rzgr?=
 =?utf-8?B?Yk9GSlIveVZqM21kQVZnRzV2ajJUMVNtM3RXamZXY0VWMGZiTFdVUXQ0aDlU?=
 =?utf-8?B?Ky84Y1NPWkg2eFpwb2hrSVREc2liODNYSjBsTXVvQU0wczJoNHZaY0szeHFi?=
 =?utf-8?B?RTVsWlprMzJCL2p3M1ZudTFXSENtaTI2ckYvWnlEUDZBaWh2dWYxa2htRXBS?=
 =?utf-8?B?NmtzbVBXNG0rclQwYXlDcTlMTGZleFowSlUvd2hqdW1KT0JiRmNwdy9hN2Y3?=
 =?utf-8?B?aGdha2c0ejIveVh1SjFwd1JhV1JSM01KVm8zZTg0VTE5aXRZZ0greVhoaDll?=
 =?utf-8?B?ck11Nzk3SE9GeXY1QlgycHo1T3Z4cTQ2ZUlwcU5WK1N2NFhvUnVONnlsOWJS?=
 =?utf-8?B?VmkrZzZuNlI5clp5UUpxNDBlTWplYzF3LzZZVFVOM1dTcVJwNVAzRXljaGRt?=
 =?utf-8?B?L28rSncvblJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXNSY1RZazhZMk9rbnVtYU9hR1hnZUgvejA3cXRBNFUvaE9NdzJXZnJYa0xY?=
 =?utf-8?B?Y1RDOW95WjUvS3ZXdHZFUXpHMENIUEZDdUlZc2RpUmsxWENKcWtidGZzQ3NE?=
 =?utf-8?B?dnNUd0VDc0hXb0JldmxLQ1p1WkhvV3JqblFRNUhFVllBejlNS3k2YnlpejVB?=
 =?utf-8?B?emZ2RmhhaEYxNlRoajZnbloyLzNrcnFFN1JEcG9BMlF6R0d1ZmFtUFBCSEZV?=
 =?utf-8?B?QWNUZ21KdnJ3b055UnZ6MVRLbENoRzFwV04wOTdjTjI2S3pNWXZOSlAvNXJt?=
 =?utf-8?B?ZVNiZVo1MWlRV2pLMlJjWUtVeElwT1FmU1VsYlNGY1hKL3ZEalRHdGNMK25n?=
 =?utf-8?B?R05Nem9CcWh3UzNML0hubURXazhtVDU2ZU5OQnRpUEtSTDEvU2hmcS9ITXZa?=
 =?utf-8?B?RmtaMy8rbW9nVmhySTVEQzhFL2Mrd1NXcGQrK0I3M0k1ZGU3azVtb0VNbEMy?=
 =?utf-8?B?RzFrZ3JLM3pMcWtyTU5QZ0VoYVJXbU5VeGxqWXBuLzhkRlFCUWdlbDQzdFQ0?=
 =?utf-8?B?Y1Q4QU4wSTM4VEEvaDljNVJIVWZYd1dtM1BKaFpybjVPSnoxeXNoeXNNVTJZ?=
 =?utf-8?B?M3YvVVF6YTh0RGtYRXdSSWRuTjZMN255djZ1M01UZ3oxSlc5SkRJNVg4V3l3?=
 =?utf-8?B?VDhScFdBSUtiUVZpMVp3cUFEcExYL0NhTE9tMWJwRHZaZEI3Q0V1ZUxOZG9k?=
 =?utf-8?B?eE5jOVJTY3NPWWZyYjNDZlA1MnRENXNlcnpQZC9XbEJ1b1hPcmtCMUxsRU5v?=
 =?utf-8?B?NXFyRllabEQvUFV0dFFjaDFpVzA5elFhZ3c0QWpDb05vUUFhbVI3SVEya1Bl?=
 =?utf-8?B?OGgrcCt0SldRZHZ5TVpTV1h5N0Ridm9vSWVFYTMzWE9QMEdJbHdoSjBaRk83?=
 =?utf-8?B?NmlMdmdOLzRRNnU3LzFhaDZBUC9QUG5wUndrd2tCcUo4cHJobmtYSlo4V3hC?=
 =?utf-8?B?RUJydm9KQzl5WmpFUDdZSnZVWFZ2Y0J0cjJOVjdsRkZNVWxtaEIyL0tjNGI0?=
 =?utf-8?B?aTNaYlAyNHIwYm95VnVCUkJ2UHFuL1hMdTZqY0UvelRRNWh5TDF1aDVNeXZD?=
 =?utf-8?B?NzNydEszSTV5WWwwSG1ySlRyYUJEeGRZdXQ2N3pPeS9rdkEycEQ4bG9SR0ZG?=
 =?utf-8?B?TWRGZTl6U25SSndIWDhsdVFJRkh2cjJrZWJtYWtjZGdxWjNZRG5WclRDdVd0?=
 =?utf-8?B?OHlPRUxpR09VZWRHOEVCL0JJaFN4WjhzQnRNZDEyMFJaam81eTRiMk1lazR5?=
 =?utf-8?B?V3d5emFIRXk2bk9XZ1E3M3R0Uk9rYW4wcFdZSDlKM05TUU9HcFFlcld0WDh4?=
 =?utf-8?B?THVZOUVTL3lIOWVqdTVUdlZFQVo3UThTeTIyS2dORmJSTXU2dmVKNVdzNzBI?=
 =?utf-8?B?VnlWamtPMnFVUHQydktHUTBUOFM0R3pjR1hYQ0MzaklvMStSREFrSG5hNGQz?=
 =?utf-8?B?NnlxaFJQellscDhtTWR3VG9UMWxSeXFRd3RvK1RncDBBa0hwTVRIdE4yMmFD?=
 =?utf-8?B?Y2hGaGEwaXRZRTU5MWdnMjJjaVdhTDBvRWt1UnVPQ0J5ZzhnY2ZmYjI3S0tL?=
 =?utf-8?B?dDdaZVZWeGp5UVhqdnRHQjhYRUc5SjBMdnhXY05FY0thNjBTUncyZ3A1SDdt?=
 =?utf-8?B?akFyUEdYNXEyRGlxT3ZxMXl0OXFNM1RWZkdMY3AzejcwVVZYTm50K1YydmpZ?=
 =?utf-8?B?Y3N3eENpbFQ4U3JnWWZJeWVUV3p4OUVyTGVnOFBpR1hmRFZ6V0ZHMXVrQVJN?=
 =?utf-8?B?TEV6QVZES0MycFVFVm1LUGZ2TnF6UFJpbmNHcXRhUldQdEc2RHpEeFg4ZVdJ?=
 =?utf-8?B?VUxyc09sOUN1R1NkNmFNN2pQMURUVm8zTG5jUWxvMFA3TkxjSUcvNjNRUG9k?=
 =?utf-8?B?aktvczByM0ZyWDJWQzUxR3FVZTNNSUMyTzVTWU9tR1FJaHoyV0FvL3c2ZUdN?=
 =?utf-8?B?eGFBMjJyVkZneGFFMlhIZ2Q4c2gwZG16ZDZESys0KzBMMFBKcWw0cDU1T0FY?=
 =?utf-8?B?Nm5rM2hWTWlLVWJVcEFQbzdXUTh1eFNhZDVDRmkyYm14ZVJNZ1ZYZWFRUDFY?=
 =?utf-8?B?UnRpamlScGZVd2F2RngzeHFJNnBQdG41VDJTdVVnOEYzc0MwcTIyUzVIM2N5?=
 =?utf-8?Q?MAruFiaHWvPnqe9mDxANLoWjW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b737bb2-87b5-45e7-3aae-08ddcd7c8247
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 02:14:40.4707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNNwi1HN1mwYmSX+tpQYqMGO2xmCuaNcNM5q7z3wXfbsuUsPjT5GKKCOxdeTy6CuoVi7gB7lWpqHvbZzNB05PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8546
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

From: Viorel Suman <viorel.suman@nxp.com>

Reading CSRs for low power use shall be done regardless
the way the PHY is configured, so move the call outside
"ddr_cfg_phy" function in order to be called for QuickBoot FW
also.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/ddr/imx/imx8m/ddr_init.c   | 4 ++++
 drivers/ddr/imx/imx9/ddr_init.c    | 4 ++++
 drivers/ddr/imx/phy/ddrphy_train.c | 4 ----
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/ddr/imx/imx8m/ddr_init.c b/drivers/ddr/imx/imx8m/ddr_init.c
index 7fdcfee1d9c982d391fe0d20e373a66d71d26e23..3b942fd3986699f76c1417c10f205dcdd7792dd0 100644
--- a/drivers/ddr/imx/imx8m/ddr_init.c
+++ b/drivers/ddr/imx/imx8m/ddr_init.c
@@ -396,6 +396,10 @@ int ddr_init(struct dram_timing_info *dram_timing)
 
 	debug("DDRINFO: ddrphy config done\n");
 
+	/* save the ddr PHY trained CSR in memory for low power use */
+	ddrphy_trained_csr_save(dram_timing->ddrphy_trained_csr,
+				dram_timing->ddrphy_trained_csr_num);
+
 	/*
 	 * step14 CalBusy.0 =1, indicates the calibrator is actively
 	 * calibrating. Wait Calibrating done.
diff --git a/drivers/ddr/imx/imx9/ddr_init.c b/drivers/ddr/imx/imx9/ddr_init.c
index 42ba493ebca4d6efc5ee047dd3f049cebb24b69d..50c2dbd40084c6a4d750f628c5c1fc76fa017596 100644
--- a/drivers/ddr/imx/imx9/ddr_init.c
+++ b/drivers/ddr/imx/imx9/ddr_init.c
@@ -385,6 +385,10 @@ int ddr_init(struct dram_timing_info *dram_timing)
 	if (ret)
 		return ret;
 
+	/* save the ddr PHY trained CSR in memory for low power use */
+	ddrphy_trained_csr_save(dram_timing->ddrphy_trained_csr,
+				dram_timing->ddrphy_trained_csr_num);
+
 	debug("DDRINFO: ddrphy config done\n");
 
 	update_umctl2_rank_space_setting(dram_timing, dram_timing->fsp_msg_num - 1);
diff --git a/drivers/ddr/imx/phy/ddrphy_train.c b/drivers/ddr/imx/phy/ddrphy_train.c
index 1a2d071d6f10f8e7482e7be8498e1c18578404ec..84a1a17734f4d2a90f3bf0a6e54b5ae4ed49bebd 100644
--- a/drivers/ddr/imx/phy/ddrphy_train.c
+++ b/drivers/ddr/imx/phy/ddrphy_train.c
@@ -89,9 +89,5 @@ int ddr_cfg_phy(struct dram_timing_info *dram_timing)
 		dram_cfg++;
 	}
 
-	/* save the ddr PHY trained CSR in memory for low power use */
-	ddrphy_trained_csr_save(dram_timing->ddrphy_trained_csr,
-				dram_timing->ddrphy_trained_csr_num);
-
 	return 0;
 }

-- 
2.35.3

