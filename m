Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6479EC83F1D
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 06:41:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8BB883096;
	Tue, 15 Jul 2025 08:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="d76sa4Uv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DD3782F8E; Tue, 15 Jul 2025 08:41:02 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3047C8304F
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 08:41:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waTHo/IT1wH1pdzqjapWatDOvO94ev9Ia9BbX1xn+alo9HGwDkrwF87qlpisHJZxAsvjQAB/4a99xrNSFEMDOFYcw+ezFW21XRlrWGOOZJy2VobOjqdRyGE7+uGmfNKUWZCBR1E81jRYTnxYThZxbKM8vVmG0w1f9Va35iMqjZS8Lz9NKatC65dTYa90Dr09SERYu0IuSwkgjWPbojnAmQotkzjdd+yHrJRoWnx+GMTSAuHHGOJjT27dH4rMEi+LNQsUrdU0Zp1INYLYVnAlVkJ+k+5UDeUGhpJWGj2ewxuDcpjxT7zOetQmnq2VUyzMwIcsPuMPkfDt2LR7brpiTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zZSzTxKA20AKQlDGWvAPo0uEU1OVe7Hb61vganiTSM=;
 b=nCAKBDIaH9S5NqlLlqvSLMnTv1honi2kBLHYARHe9V6jKcoDsnLqtj86Z/zUO2BoTjFy8bYKx/H+R+/UOD0iOMneHLZjHm5tMANoX7tH43ALxKE+nNxM9f+cyFXOSE8xPuQ66GtelOS2aBDjS60mnPZkh8vUPeEqidZq0nvZrwJyyW0a0TfxwGLXIJw2it2ti6UUW1pzLPaoFDEr21Nvg1RfCUvzbB7sc7eUJ0IeSM6dcO/bdLx8cuqTIElIJx+mETG0WmENaV8aXubNyMH63Bkd3gG4VOa4CzzOZNuRFDUKcAX3OsJqos1d+yJcwV/02+Q7zSTZ8vTNhQdOWZPs/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zZSzTxKA20AKQlDGWvAPo0uEU1OVe7Hb61vganiTSM=;
 b=d76sa4Uv6OehMkddL0GiWjWchc/x+uZDg46kD7H3fhDFnlnYPH9ba8MXriS8syPeKTaHaaec4abqb1WXpQ0768FYL2BOxfLisXe1gVdhOLj3VAf6+MqT5dge/lYNNkkoBXCd/sRA3yOT9k1rH7ATrUtF9fnXwdPGMjbUjGWtin40hk77S6SUGG3Y61Vcwxm1yWGzt2LuBdgdRO+PRBCFWRN3C0NaYmTzwMaG4evC52JtOtNWd14PoK4l6PgDOcNR5zKdI/+nfHMIP/mDYfXMU49wLZqPfX+6+8u123bXsUZqTUYfhA7v3+IfnzPSTwp3Y18CF+tStbmvtcRlR7/lNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB8370.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 15 Jul
 2025 06:40:58 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 06:40:58 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 08 Jul 2025 04:42:54 +0800
Subject: [PATCH v2 2/4] tools: imx8image: Add 2 new commands
 CMD_CNTR_VERSION and CMD_DUMMY_DDR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-imx95b0-v1-2-01759e9c855f@oss.nxp.com>
References: <20250708-imx95b0-v1-0-01759e9c855f@oss.nxp.com>
In-Reply-To: <20250708-imx95b0-v1-0-01759e9c855f@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: MA0PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::13) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: d07ddbf8-9617-4b7e-48fb-08ddc36a8eb6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0x2VHg2YlRLMWxYa1N5TTUrNkdjUVlKWWx2QzZjdWFyRldXdC9McFNqSitq?=
 =?utf-8?B?SER5NXo5N1RkbC9rbXVHNFpoVDVpQlNQQ1RwZ21SeHR2UDY4Z1JiTEsvRmZy?=
 =?utf-8?B?R093UWk2bldnMjAvYkwyb2o4WXJOY3EwVlFUMGY1K0RCbXZUSjBsL0JLSWtH?=
 =?utf-8?B?ckhXcVFibUk5ck9kcWNZeEVrczZ4RnVQOWwzZkpTTDZSOUd5TWdHZkM1OVJ0?=
 =?utf-8?B?dWQwRjFubzdRY1BUOGRVV1pFR1VSUE1FdWhqZ05uU0pVa0ZIUGZKNUUzaHUx?=
 =?utf-8?B?djZLdlBubFY2UE9uQkJlb0lGbDJ2bUNsbW50TG52MjB6azE4NDlPMzgyZFJp?=
 =?utf-8?B?NnN6T1lqc3FTKzFyaTk2aGZha1FJWFlrVTA5TVI0ZisxN0Q0ZGRUQUlCdFBw?=
 =?utf-8?B?c0l1ME9SR3pGSlJZVjhKTDIwc09lVFlzUXo4M3IxaCtYNHZpOUE0NnZFdWJr?=
 =?utf-8?B?OHRzU09MYXJJaTVUSS9vL2JEKzdJamlUbHpRdmp3a1R3S2RBNU43L3Q0OWI4?=
 =?utf-8?B?ZkVZWDBmWTM1NWhkZnhJVFFoOVRZMEluOEQ2ekFCeVFPWjBXcUZCbUhYNG4z?=
 =?utf-8?B?SUlERXlIMnFIbkt4eXVHajVLUEVQaFZYYzVUT0xUclVOQWloeWRIbm83OWV1?=
 =?utf-8?B?aDcwN3Z6blFnLzkzVEJaL09aVjgrZytkZGNoVWF0aDNTbEJ3MC92RFB5VWl1?=
 =?utf-8?B?YUZEYUpEeHFQVFNlVUcrL0c5NHZNZDIxMm9GQ3YrWVdMaGZ1WDMzQVlnYUc0?=
 =?utf-8?B?NFNLSU9ZdWRmYTYvNDAwNlBRTnBGNFl4Vmw5aGdXeWl5eW10RkR4U2YvcFBk?=
 =?utf-8?B?Z3Z6dFMyVG1QdjZiRjFoeWllQTFLVzA3dVJoT3h0L1ZtQ0x2enIyNFpoaEJs?=
 =?utf-8?B?NVBNRzEvL2s1M20rckFWQzA4NTdDaHNRU2xISFBYRHlHenFKc3NwbWEwMDNx?=
 =?utf-8?B?VUd1Y25QOHFLRkc4Q3NNdFpqZ0tYRStRS3BMQlNKKytoQmJqcTBRNTAzamVy?=
 =?utf-8?B?dmxEN1VNQUtDeFYzTklRbERiWktYUmxXWlpEc3dySTh2bDZZTERyaGd3ejI4?=
 =?utf-8?B?UDBHUmQ5NVJTMkdPK2hGRjd3QS9oUE1zL1drTzRTc2ZiQnZQc2ZPSk9NZjhx?=
 =?utf-8?B?bURYdlVHdDlWQzJmdGVyZWtyaEpnVlBmMWRwbmVsOFZLc3hlZk9iNjdkNHFz?=
 =?utf-8?B?cERLM0dyVHZBd1RPSEJTQ0JWWUlZV3ViWm9HUW42dldlbElqQ1lnZzduN3d3?=
 =?utf-8?B?cFZPVU1qQ1dNWG1vaWpaczNhbXZyZ3hYRm56cE5zc3IyWE1ZVlJ3bDNKL0ND?=
 =?utf-8?B?MDdHdjEzVnB3T2Z6QTVGYUJPaHZCMmVhNUV0M2preERscFMyeVdRK0V1R29U?=
 =?utf-8?B?aVhsSWRuejN4YUJPUmxYL3ZqSWp2OWlMNUE0aDQ3bHVDbzFMY0FEUXZHTG52?=
 =?utf-8?B?UmxGTExOM0tEWWNwUU5SZW9QMUp2OTdVUTRpZEF0R2wxSnVHY1VvYVNWcGc3?=
 =?utf-8?B?U0oxYTlKWm9wUG5HMkliSEF3bU5HVCtoSEJUdllFMTlYR3owNkkrdmFhSDhG?=
 =?utf-8?B?dzdQQU1PQ0t1RlExa1VnZEFsdmRGYkRuR0ZHbmlVSWtJZ1Jxck9Hc1drUGll?=
 =?utf-8?B?WjBiMjJNL01iT1hNaUxNazJYRGpkTVh3VHlMa0Z4T0Rkdm0zYnNESG1DVGM4?=
 =?utf-8?B?RU0vclZpNjBnd2pRUVg0Vzh2V20rODlvdklsTFFadlZZcFByU2t4QXlyZGQ2?=
 =?utf-8?B?RldZOHhLb2FYelhFUXIwRkNrNWlGN3Q2blJDcjhSTEMyWStaOVF3TTNoek9Y?=
 =?utf-8?B?dFNmM3FLWnNVMUxrbzdyOVlKbXAwa3VCUSt0T2lyZE1kSjRabVdSVERxcUtM?=
 =?utf-8?B?NGlXRng3cmUzQW8yZFB2OHRZSVlyZStMWGU3UW50TjVkOEZLeTNsU3J1SjIv?=
 =?utf-8?B?WmsxQ3lyUHJaODNmRGFnRzZlbVJHeFVNNEpjcTJzcmZSY0xzQ2owS0l6Ymtt?=
 =?utf-8?B?NmFkUStmejZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjIrV0pXbDFnVnJlcWk4ZndXSFlteDBmMDFpK3B0YzRML1B3ckhFSXU1clNv?=
 =?utf-8?B?ZzMrbDhBL2ZDVUJoelBWZmZMY1R2aWlHbmh4SDgvZWlaZ2ZWbGoyQTZmUzhi?=
 =?utf-8?B?TXlmTkpyU1dCU2ZERkYxRVhRR0YrWWV0K2s1dmNmdGV0eEdTSFQ1K1FMREtL?=
 =?utf-8?B?aTNmRlk4bmwwc0grTTVjckNzQ0h6ZWh1MThYZ1hvSU1oZkhYZFNPclI3ak40?=
 =?utf-8?B?Zm5PM2lmajc5d1hsRWh1b1VKOE5rSUZjNXQ5RzhLVXpUb0hPcWNoR0VKdXhq?=
 =?utf-8?B?OCs4Q0VucFpnQ3htd3BhZFIxZ1VUZXFRM2RaNmNyWHA3SUJVaHUreFo4VG1E?=
 =?utf-8?B?VjRBMnArMHFHK2kweDkvcUtxK3lzM1h2eVUvNmd1V2d6RVpSelcyQ0V5NkNr?=
 =?utf-8?B?RU52R0g5NEt0aEtvMm04MlZKamk2aDVtaVN3bE1aakFzL2JFM3o1UzdiMjRO?=
 =?utf-8?B?VXlaNnUyczY3WW03MjRjSGE3QjZ0aWtwSFFDckZ1enFtTG5Sb0pxWnhoNE9S?=
 =?utf-8?B?R3VmU1dSTVVNVXBkem5oZlh0aDJrQzlDeVdaZGNQaEdoZVlZUTlSYytjWnNx?=
 =?utf-8?B?d0F1ckFCS0gxSUdkbDdIWXk1NjFKN05objVUb2Y1REZlV0xZcS9QcXNsaWFT?=
 =?utf-8?B?MGpqRCtVYlFDeUJNTVg0TUcxeWZpeUYrQjMzeUNFRkF1VDJ5UWVFblIzaHJQ?=
 =?utf-8?B?Q29KblArYzRVU2NrUkxGRFNSemNlRkJpbjJRWnJKUmZlUWJ5NkozL21ZQ2lu?=
 =?utf-8?B?VXpkci90dE5rUXBLZVcwRHlham10RGRsNzVOcFhhamV3YUNISk1MaW9IWUF3?=
 =?utf-8?B?bHQ3SkloSXpSTFZVYlpBeWNRalh3ZzdncnI2Q3dYc2NzTHlBM1pTVDBYL0RM?=
 =?utf-8?B?a1lKREgraEhTWEpXejZZTkVqdk9ZN3N3dXNvaTZvaVZTemFYV3BUS015U3RC?=
 =?utf-8?B?b0lURkowV05EZUxYMHcrTnVsR3FUK1dTN1dNcExrNDRBblVUVGRISHFhS3F6?=
 =?utf-8?B?N1dHdEJRSFU1OW1CdHVrZ0VKQ0pjVCtuVXZodDNnNWVRcjFxaEFDVk5HSHRN?=
 =?utf-8?B?cHhKdWpkc0xSU0E0clE0Vmk0bnpMMzBvSFNjSVJBOUVmMlBDQ1p5UDBabUN1?=
 =?utf-8?B?MDJ2VjlVL0YxTS9uRGdvSG1GTkdYZnJxTEJuSjdNVm1qVWp5bm5yVmlnbUFN?=
 =?utf-8?B?aFhNaGJ0WGJ2WTZRdU02S3VONTVxMHFUYWhUaE9vdGprRXVYNlRuYTN5d3Fk?=
 =?utf-8?B?UnplQ3ZuWU1ERHNrY2dIcXNZb0IrZjZuVGZSUVZkcnpUN3A4SDZkditKaWQy?=
 =?utf-8?B?RVhhTDNEM1BBeitmcDhMa3FMUFpRZ3BueFBYdElmbW1ub2svNDIzRU5nVEdI?=
 =?utf-8?B?eHF1dGNoc1doa081OHlaeVlnMlgxZC8xalBLTEZyMWQrQkV0ZzNuTmp1ZGtz?=
 =?utf-8?B?Q0VRU0dkbzh0ZUw2RmRoc3laL3VDb2NYTjFiTmlIbFhzUVVXcEtIZVJXVnFM?=
 =?utf-8?B?S2cwRGMzc2JJWkxiR0o3aStYWGZnMWZvQzkwN2RMbEQ5dWY4M0lPVEFPRlFX?=
 =?utf-8?B?a3QxdG1MdFE1b3ViOVJRVEFHVzA0aHhLbDNDcnZwUUpyTGV5M0I4WG9sTHd2?=
 =?utf-8?B?eHdQaFFuU3VSSzJEWXdpcW1HQlp5THJxN3RtTXNqNmJxSkQ0SHRPMW41R1Zh?=
 =?utf-8?B?K0FVcUo3NjRXWFhyVjNORC9IczdmVkNES3p5OE15WkRUTklNOW93M1RPdEFY?=
 =?utf-8?B?K1dxZmVzaWVOdElWYkxWMFBaVDh4OXFRZU9uejdVdEhTLzJ4eDJ5dlUzTjQr?=
 =?utf-8?B?b1huSE05aTNJdllNTkw0cWp0N1I2MzVXVGwwRXJKK0E1OUVhMGd3UkNZZ05i?=
 =?utf-8?B?VXpZdmtYYjdYZGJ6K3lBekNNakFMVlN2UW5NRWFsMWkvR0c5UFFOYXpaUStJ?=
 =?utf-8?B?a2NZcFF2R0doUnl5ejJlM1VqYm96K0J1YmZ5TFg3dFdpYUozOTlhOVExTWJC?=
 =?utf-8?B?bC9VOCtSeE50aFJES3JXQWVKTGFoVzQ3b1FuL25LRG9LWGtTUUlocWlqb0xM?=
 =?utf-8?B?VzRkWlRZbUJFWWdRaEd6RVM5bkd0bmVkdEdzNkVqSEEwVU4yQ2RNNU5ZMHJF?=
 =?utf-8?Q?84XOXjnwV7bFYtVDM3z51ba12?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07ddbf8-9617-4b7e-48fb-08ddc36a8eb6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 06:40:58.7011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wti3voBySCrgu/z4wu+vDHp4B1zRcisYfpA7yt6DHXuDV+6J0ETtR771TDe2fhSlJLQU89XvzLwZixpr4urOKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8370
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

i.MX95 B0 uses image container format v2, and `one container header
occupies 0x4000, so that CMD_CNTR_VERSION needs to be added.

The purpose of CMD_DUMMY_DDR is to create a dummy image entry in boot
container prior the DDR OEI image entry. ROM reads the address of DUMMY
DDR image entry and passes it to DDR OEI in OEI entry function as
parameter value, in order to indicate the offset of training data with
the boot container.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 include/imx8image.h |  6 ++++++
 tools/imx8image.c   | 57 +++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/include/imx8image.h b/include/imx8image.h
index e0d25c5b6c9..d0e05811ff9 100644
--- a/include/imx8image.h
+++ b/include/imx8image.h
@@ -45,6 +45,7 @@
 #define DCD_ENTRY_ADDR_IN_SCFW		0x240
 
 #define CONTAINER_ALIGNMENT		0x400
+#define CONTAINER_PQC_ALIGNMENT		0x4000
 #define CONTAINER_FLAGS_DEFAULT		0x10
 #define CONTAINER_FUSE_DEFAULT		0x0
 
@@ -160,6 +161,8 @@ enum imx8image_cmd {
 	CMD_DATA,
 	CMD_DUMMY_V2X,
 	CMD_HOLD,
+	CMD_CNTR_VERSION,
+	CMD_DUMMY_DDR,
 };
 
 enum imx8image_core_type {
@@ -216,6 +219,8 @@ typedef enum option_type {
 	OEI,
 	DUMMY_V2X,
 	HOLD,
+	CNTR_VERSION,
+	DUMMY_DDR,
 } option_type_t;
 
 typedef struct {
@@ -262,6 +267,7 @@ typedef struct {
 #define IMG_TYPE_SENTINEL 0x06	/* SENTINEL image type */
 #define IMG_TYPE_PROV    0x07   /* Provisioning image type */
 #define IMG_TYPE_DEK     0x08   /* DEK validation type */
+#define IMG_TYPE_DDR_DUMMY 0x0D /* DDR training data dummy entry */
 #define IMG_TYPE_V2X_DUMMY 0x0E /* V2X Dummy image */
 
 #define IMG_TYPE_SHIFT   0
diff --git a/tools/imx8image.c b/tools/imx8image.c
index cad55fd3cf2..5a76643c06e 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -19,6 +19,7 @@ static bool dcd_skip;
 static image_t param_stack[IMG_STACK_SIZE];
 static uint8_t fuse_version;
 static uint16_t sw_version;
+static uint8_t cntr_version;
 static uint32_t custom_partition;
 static uint32_t scfw_flags;
 
@@ -57,6 +58,8 @@ static table_entry_t imx8image_cmds[] = {
 	{CMD_DATA,              "DATA",                 "new data",           },
 	{CMD_DUMMY_V2X,         "DUMMY_V2X",            "v2x",                },
 	{CMD_HOLD,              "HOLD",                 "hold",               },
+	{CMD_CNTR_VERSION,      "CNTR_VERSION",         "cntr version",       },
+	{CMD_DUMMY_DDR,         "DUMMY_DDR",            "ddr",                },
 	{-1,                    "",                     "",	              }
 };
 
@@ -157,6 +160,10 @@ static void parse_cfg_cmd(image_t *param_stack, int32_t cmd, char *token,
 		param_stack[p_idx].option = HOLD;
 		param_stack[p_idx].entry = (uint32_t)strtoll(token, NULL, 0);
 		param_stack[p_idx++].filename = NULL;
+		break;
+	case CMD_CNTR_VERSION:
+		cntr_version = (uint8_t)(strtoll(token, NULL, 0) & 0xFF);
+		break;
 	default:
 		break;
 	}
@@ -177,6 +184,8 @@ static void parse_cfg_fld(image_t *param_stack, int32_t *cmd, char *token,
 		if (*cmd == CMD_CONTAINER) {
 			fprintf(stdout, "New Container: \t%d\n", ++container);
 			param_stack[p_idx++].option = NEW_CONTAINER;
+		} else if (*cmd == CMD_DUMMY_DDR) {
+			param_stack[p_idx++].option = DUMMY_DDR;
 		}
 		break;
 	case CFG_CORE_TYPE:
@@ -588,7 +597,8 @@ static void set_image_array_entry(flash_header_v3_t *container,
 	img->offset = offset;  /* Is re-adjusted later */
 	img->size = size;
 
-	if (type != DUMMY_V2X) {
+	/* skip hash generation here if dummy image */
+	if (type != DUMMY_V2X && type != DUMMY_DDR) {
 		set_image_hash(img, tmp_filename, IMAGE_HASH_ALGO_DEFAULT);
 	}
 
@@ -632,6 +642,15 @@ static void set_image_array_entry(flash_header_v3_t *container,
 		img->entry = entry;
 		img->meta = meta;
 		custom_partition = 0;
+
+		if (container->num_images) {
+			/* if at least 2 images in container, [0] and [1] */
+			boot_img_t *ddr_dummy = &container->img[container->num_images - 1];
+			if ((ddr_dummy->hab_flags & 0x0F) == IMG_TYPE_DDR_DUMMY) {
+				ddr_dummy->offset = img->offset + img->size;
+				set_image_hash(ddr_dummy, "/dev/null", IMAGE_HASH_ALGO_DEFAULT);
+			}
+		}
 		break;
 	case AP:
 		if (soc == QX && core == CORE_CA35) {
@@ -751,6 +770,11 @@ static void set_image_array_entry(flash_header_v3_t *container,
 		img->entry = entry;
 		img->size = 0; /* dummy image has no size */
 		break;
+	case DUMMY_DDR:
+		img->hab_flags |= IMG_TYPE_DDR_DUMMY;
+		tmp_name = "DDR Dummy";
+		img->size = 0; /* dummy image has no size */
+		break;
 	default:
 		fprintf(stderr, "unrecognized image type (%d)\n", type);
 		exit(EXIT_FAILURE);
@@ -776,22 +800,27 @@ void set_container(flash_header_v3_t *container,  uint16_t sw_version,
 static int get_container_image_start_pos(image_t *image_stack, uint32_t align, uint32_t *v2x)
 {
 	image_t *img_sp = image_stack;
-	/*8K total container header*/
-	int file_off = CONTAINER_IMAGE_ARRAY_START_OFFSET;
+	/*
+	 * 8K total container header for legacy container, for version 2
+	 * container, the total container header is 0x4000 * 3 = 0xC000.
+	 */
+	int file_off = cntr_version ? 0xC000 : CONTAINER_IMAGE_ARRAY_START_OFFSET;
+	size_t size = cntr_version ? SZ_32K : SZ_4K;
+	uint32_t cntr_header_len = cntr_version ? CONTAINER_PQC_ALIGNMENT : FIRST_CONTAINER_HEADER_LENGTH;
 	FILE *fd = NULL;
 	flash_header_v3_t *header;
 	flash_header_v3_t *header2;
 	void *p;
 	int ret;
 
-	p = calloc(1, SZ_4K);
+	p = calloc(1, size);
 	if (!p) {
-		fprintf(stderr, "Fail to alloc 4K memory\n");
+		fprintf(stderr, "Fail to alloc %lx memory\n", size);
 		exit(EXIT_FAILURE);
 	}
 
 	header = p;
-	header2 = p + FIRST_CONTAINER_HEADER_LENGTH;
+	header2 = p + cntr_header_len;
 
 	while (img_sp->option != NO_IMG) {
 		if (img_sp->option == APPEND) {
@@ -801,7 +830,7 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align, u
 				exit(EXIT_FAILURE);
 			}
 
-			ret = fread(header, SZ_4K, 1, fd);
+			ret = fread(header, size, 1, fd);
 			if (ret != 1) {
 				printf("Failure Read header %d\n", ret);
 				exit(EXIT_FAILURE);
@@ -813,11 +842,11 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align, u
 				fprintf(stderr, "header tag mismatched \n");
 				exit(EXIT_FAILURE);
 			} else {
-				if (header2->tag != IVT_HEADER_TAG_B0) {
+				if ((header2->tag != IVT_HEADER_TAG_B0) && (header2->tag != 0x82)) {
 					file_off += header->img[header->num_images - 1].size;
 					file_off = ALIGN(file_off, align);
 				} else {
-					file_off = header2->img[header2->num_images - 1].offset + FIRST_CONTAINER_HEADER_LENGTH;
+					file_off = header2->img[header2->num_images - 1].offset + cntr_header_len;
 					file_off += header2->img[header2->num_images - 1].size;
 					file_off = ALIGN(file_off, align);
 					fprintf(stderr, "Has 2nd container %x\n", file_off);
@@ -839,7 +868,7 @@ static void set_imx_hdr_v3(imx_header_v3_t *imxhdr, uint32_t cont_id)
 
 	/* Set magic number, Only >= B0 supported */
 	fhdr_v3->tag = IVT_HEADER_TAG_B0;
-	fhdr_v3->version = IVT_VERSION_B0;
+	fhdr_v3->version = cntr_version ? 0x2 : IVT_VERSION_B0;
 }
 
 static uint8_t *flatten_container_header(imx_header_v3_t *imx_header,
@@ -921,6 +950,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	char *tmp_filename = NULL;
 	uint32_t size = 0;
 	uint32_t file_padding = 0;
+	uint32_t cntr_header_len = cntr_version ? CONTAINER_PQC_ALIGNMENT : FIRST_CONTAINER_HEADER_LENGTH;
 	uint32_t v2x = false;
 	int ret;
 
@@ -978,6 +1008,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 			break;
 
 		case DUMMY_V2X:
+		case DUMMY_DDR:
 			if (container < 0) {
 				fprintf(stderr, "No container found\n");
 				exit(EXIT_FAILURE);
@@ -1023,7 +1054,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 		case NEW_CONTAINER:
 			container++;
 			set_container(&imx_header.fhdr[container], sw_version,
-				      CONTAINER_ALIGNMENT,
+				      cntr_version ? CONTAINER_PQC_ALIGNMENT : CONTAINER_ALIGNMENT,
 				      CONTAINER_FLAGS_DEFAULT,
 				      fuse_version);
 			scfw_flags = 0;
@@ -1073,9 +1104,9 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 		if (img_sp->option == APPEND) {
 			copy_file(ofd, img_sp->filename, 0, 0);
 			if (v2x)
-				file_padding += FIRST_CONTAINER_HEADER_LENGTH * 2;
+				file_padding += cntr_header_len * 2;
 			else
-				file_padding += FIRST_CONTAINER_HEADER_LENGTH;
+				file_padding += cntr_header_len;
 		}
 		img_sp++;
 	} while (img_sp->option != NO_IMG);

-- 
2.43.0

