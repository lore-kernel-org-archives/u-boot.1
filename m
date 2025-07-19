Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486EDC83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 11:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3DF582CFA;
	Tue, 29 Jul 2025 13:19:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oWVE5i6e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71B1E82E34; Tue, 29 Jul 2025 13:19:14 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4B0582BCD
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 13:19:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBApTH65Dpnb/CFpusOIKkp+r+FS/E/FkxiM5VRZVSkGx6Wm+EEeaor/Wotw9FTv48Sy5SC79nWwmsHyGgGLroYi/g71/xglE74oE8pS3M+UOPITPZtpjNTW88XvNnOemHd7+/QvjqXQuG3Hendhac/BEdUJFK1WNApZxnz1AEF350lmtXh/eEz4IkMKD9JzKf3PHtHvDmoC1yUZDE1X9/Um4vnJiIl/OxNzDq4BQuKraEVKWqhnM7j67RIwG6pzMUaf5UMzq/7SjDhnPZ4T/e+1VMWmPyrJ8Khj+2XxZzxDrKIYCeI1fCBLYmVJtzkUBMzjBZgfpURbk/lnoHHBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4Ecme9tR7yzpr9KQ/QrUKr0PNZppAu1je7rRoaO17A=;
 b=bkpGyoEaFMJ18htTrx9aEt1yI/svuCwqCHatAMPITkGWCeXbHc+iWNnpYZeOblOwJustKVY9G0wDJlPUYDj6v68eku0/sX8BsduMq02JEdYUZqvENmZVCX74ApgkyLts/O9A88F3D0wTJqd9VnMcBz0vZinLscYKUexdkMp2AJ5WIeYErnWYsMBq/IeKeXj4DLuzrWgdTNt79mlmIczFnc9a3Ozmxh38KNVcNQLwY74zUyNbyOhkoo8VdzneF74V/wq310tWkLeSDGX06Gfg4b3HX5cNxJkc0ISk3bF21YEUmnzhpGkPzaVPByfvvq+h5+XSsK8/fjgKCS4YQI01hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4Ecme9tR7yzpr9KQ/QrUKr0PNZppAu1je7rRoaO17A=;
 b=oWVE5i6eX+IKBXkeFiGoNX7yeGgFoYOAA0CHUnGPsZ0odE7alRBGFa6gW563L5MosoPyfgY/vecut8ZXUHT9QcSfj/uuHFdRtPG3u5DLurPWVyKjk/D7klrEa59bMvPQuQzp6jH9lQzli2hurSmvt1tA+GcAVFcKbHhtT38aCzj1O4xtA7+TIXqubJhfJz//jTLGANzHD4soDLUN4fujcZ3HPuaeoDqaQYFn6f9vR5x3UoPzIWSY43NBPry1IyXN5H9H/qnt3WJ7/3Ub4gpUiEzvsJXpO+xUe58vDKKvPepksS9ZzbZUC0r5MMRwOFYfg0ptWxHjtH740y26RGgAoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB9977.eurprd04.prod.outlook.com (2603:10a6:800:1d9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Tue, 29 Jul
 2025 11:19:08 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 11:19:07 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Subject: [PATCH 0/6] imx95: support USB SDP on USB3 interface
Date: Sun, 20 Jul 2025 06:13:51 +0800
Message-Id: <20250720-imx95-v1-0-759619b47b1f@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ8YfGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyMD3czcCktT3WRTwzQDCzMjA2NTCyWg2oKi1LTMCrA50bG1tQCkGHY
 VVwAAAA==
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Troy Kisky <troy.kisky@boundarydevices.com>, 
 Adrian Alonso <adrian.alonso@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, 
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB9977:EE_
X-MS-Office365-Filtering-Correlation-Id: dc48db1e-9982-445f-0e2d-08ddce91bbfc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzZpNmRtMzlGMjZYZWVNYmpkT0tzbk5YT0h0c2hwSDNHbVRlUG5wd05UWFVB?=
 =?utf-8?B?M0h3WkJxQ1pFd0dkUkY1bWdDTVRmNHlRd1lEdHF2MzlHTkpyU3REdExUSGR0?=
 =?utf-8?B?Wlh1QkNXeWRaNUlvZjlWeEdxSm5Da2laTG5qMG1UR3BFVjhnek9DU3dMSGts?=
 =?utf-8?B?RVdaNFEvSkcra3hRS094L1BiQVAyODlhZlpoamN1M2kzMy9Ycm5kQld5ejYy?=
 =?utf-8?B?UDlndnZITWdMbFRnZS9SRHRIU1dtRzN6eDJYbWdBcWRUUXVHWnJINGI3TUh4?=
 =?utf-8?B?d3QwN1pLaTdNRW95TlVpVFA2TmxINTZEa2I1MnRrM1MrZ0MrR1k5UWdmWDV5?=
 =?utf-8?B?Q1VvRUNSWXViK2JPbURUM3JQQXh2TjlxNnJHMTl1UFUxUUZGK2wzNGxEbFVG?=
 =?utf-8?B?L0NRdEdkd3p0a000bzk1ZXIvRXR0SHdDdmZncmFVMWU1c2h4YVV6ZTBLZklJ?=
 =?utf-8?B?MVR0eEdzbGZnUEpYckNRQ1A2QlJxNFAyQkNTUXZGRnZzbUo4WXUwQyt0aFp2?=
 =?utf-8?B?U2NRZ1d2MDN5dCtHSEU2L0orcWxJUUY4MGwrblJDS0g1OG1BN3AyV3FJSnli?=
 =?utf-8?B?OW1jT2VocnlwcGFXTkxqc1BieXRIT2RCdGcrazlvOG8xeHJxU1E2RlppZHJu?=
 =?utf-8?B?aStNMEluZnlzbXlQaXVIcUpRY0VMd1IwTUF0MTR0b2xmaXF3bFc4UGNPTHdi?=
 =?utf-8?B?UlN5YlhBNng1dk11UVhIeWFmZjFMRFNmeisvS1k0SzJEM055Z2JpSk9QYUtT?=
 =?utf-8?B?eUtLV284MUJ3NmxvZ2JuT1lsMjB4azFBWlNXRGhlOFA2cVFIT096RjhEbnNW?=
 =?utf-8?B?d3hRbWtIaTlyMlpybkc0dUtmNW1ZMHZ4TnlEZzNOemlhVGU0Tk1RMlJOSlY3?=
 =?utf-8?B?U0ptRStwTUU5VFV6UGJhUUZtcTYraWlxT0RtWWM2TUQ2eEVWc2YxZmpTTUZQ?=
 =?utf-8?B?b1NsdFovSFV2VXV1YlVqTDlST0tZWFFUK1gvTFZpTXhuc2t3dHVRR3BsaDFk?=
 =?utf-8?B?VkdQU3pJTk5OMktLZnFWbkNrcVBUTGVsZmNQZjlrNWJLT05jQllBVGt6cnlN?=
 =?utf-8?B?SGxYVkhFVU9SdnU5SVV5dk1Gd2w1N1ZOZVgzSDRvV0ZTaEtTYUZ0NDZMRGdR?=
 =?utf-8?B?dUUzcXd3eWhPNnpEbk9HdFNlTlBrUEczYmozR1NoTnJlNGd4OTNOMTZ3OVRr?=
 =?utf-8?B?UHlkcGp6SFpLWmdpSmRacHp6SGZ1OG0zeWhBME5XMWxDd281VXU3VXdUODFO?=
 =?utf-8?B?TkV4WEs4VThuaUVXWDdLSUh6cjR3aW1yUUxGOVlGRFV2RVdrNWZ5NjU4RUNn?=
 =?utf-8?B?bDUvL2x6WGZZUDJpODZTeG5SYzdBNnVUTi91YnNWQ3R6UVV1cjRYdTN0RUI4?=
 =?utf-8?B?cElaeUx2OENBdllFUlkzYXgzemx3MjBsc2VNZVFMbnZHZkxHYVNOTGJFOTRH?=
 =?utf-8?B?UVArRDVDMFp0d3lVWThGYkdQdm9DRDQ3dytTa0JyNGtnYUtPdldHSkZMY0VL?=
 =?utf-8?B?V2JYLzVld0FZTUJyQWNCc1REUVNJSVMyVFcySzJOV3VraTJlK0l5YWV0VXQ2?=
 =?utf-8?B?M2dDbFo1UndSZzU3dGZlVjRvaWFzVXdEY3gwa3orM0JZRWlZNGFrWHBZR2Zw?=
 =?utf-8?B?cHNzaGdIMFdIVlZyUVNvbytobG9kUXU5YzJCSXVvbEk5Rk50UUV3SXFyVUIz?=
 =?utf-8?B?T0FycjVhMHhhV0xVU3BFYUJkRk15YjJtdWFZdGVzS01LOFhjR21kazB0NGN2?=
 =?utf-8?B?KzZ3Yk5wOXgyN2VyZC9pSGpiSWdRR0J3K2w1b0VpYUlhWGhid016dzByRlRK?=
 =?utf-8?B?cWF0dFZkaUs5MHBVTXgxOS9Ia0Zab3NEa25DejJLZTZ6bnhlYmlVRnFTZnh1?=
 =?utf-8?B?bmNldmJxMmxJQ1QvWkIwejJzVkl4ZzIxSUYzOFdGOHh6Y21qYTdKLys0OTRT?=
 =?utf-8?B?bkxINVBCd2Q0cHF6REJud1oyU1pPbFBlRVp4S0xXNXJwU2YrdUQyNitycml2?=
 =?utf-8?Q?D/WVOYRKoPJmczTPIytTeryjR0roTo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eno2Tm1JR3BmWm9XMXRvbWJTZmdwdFlhU3hIN0cwK01INEpQMlRyVytlZHB6?=
 =?utf-8?B?VVptZWI2Ylh2T1B5azllVCtXWlJlVms1NS9IT2txNExDL2dkOWpRaGpOUGdj?=
 =?utf-8?B?em5EWWV5MVFRY1plTFdFbWpuUjZKTU1XNVlIdlBhS2lsbWJ4T001cFhzTzFq?=
 =?utf-8?B?dG9TMmdyVVNVVVRNcUFHVVQybnNNdXE5dS96cEd3N1RlZk9iWnYzQzhwamR5?=
 =?utf-8?B?VGcvaHpTVHlrUGpDd2I5d2Nmd3psYmRhbUpDdHBMRWREZ1dqV2pNdDI1L1kv?=
 =?utf-8?B?NHZwc1BMazFaNUU2dm5ZS2VYQVBLcG1vWVBvaVl3Yy9IVzVxNzQxWHR5RmNK?=
 =?utf-8?B?UFNtbHliL1pPMEExWkdDZHQ5SmZvVUNQdzlsSlZma2UxR3YyVzBnelY2WGNX?=
 =?utf-8?B?Mmo4N1A0c2o1N1k2MW5ZSEpDOXFheGhpMTBjbDJkcEFSeWY4MmdWRUZKZnJE?=
 =?utf-8?B?NGtIcm5vbWtjVlN2akhXZGh2a3dCdVluRTM3Q2VsUi9SdHhWWEJUV3NGMlpN?=
 =?utf-8?B?V1A1L1R6eC9WWVpxNk80aUd3ZUFQQ2tQN3B0ZGVEamlnR1dDOS85UFU1bzVE?=
 =?utf-8?B?ZVdEbXpraG44M0kvZWpBYWdIRDJGWWpnakM4WHU3S0JZSFFTR1Vsb2pzRlVI?=
 =?utf-8?B?SFJkYy9LaWVQZC9RbUdaNDBpSTVkaW51aTQxcDd2cHB2ZEpYUjRpNGxXV2FG?=
 =?utf-8?B?MkxzTHBYVDBTOEFTczU0d0RzbVJQR1JVK2svS1A3U2dTU1JsbEZBU1JQcDdQ?=
 =?utf-8?B?eWZGaitFMGFpQk8rMG0yOSs4Nkp3QytCWHNRWjNoQnE4Q2tnVllpcWg0UlVk?=
 =?utf-8?B?TUxzcXBuZ1lveWUxaVVqK0tFMXdsL2U1Z0dvSHFpMjE4OUlMUmFQN1hrZ1Ft?=
 =?utf-8?B?aEFpejdYUU13bjhxb01DeldydWI2VmFKMHVONFdiNGxpODliMnMyZFgxc2JG?=
 =?utf-8?B?N3RFR2dsV2hxaVBQZDNPSkhObGQzTGtuZUF5ZDlGaEpld1pjTkVWVTRKT3Jz?=
 =?utf-8?B?Sk9Oelk3S1ROVmpHV01BeXdVSUExWnVuNGtZb3gySTFNc09yeXhKdkpOOGZL?=
 =?utf-8?B?aDhMRjJyVi8wQjRHeFNZNEFHUDVVVHRkdndESVNmSUVudDhGN1AwQ1NsTXJ3?=
 =?utf-8?B?UFpHTTk5SGUySklGNlBvd204cXBFcVgyQm9RanVTWnR2UE1aczdNejNYR3VZ?=
 =?utf-8?B?NjVDbDhHcmhaUkMrbzMrNXp5R0N3Snc5aFY0R2hydCtRSGxSVWV3c3BUWE5L?=
 =?utf-8?B?QVlST3hMTTdjZ2dPcUdBeG83MDhtVXh2dFJDTUp1ZmcrU25MT1BKYVQrWHVS?=
 =?utf-8?B?ZmtjSzFJSHYrbktoc25aRUpwT2s4MXlUQk4rZWkyN0RGU2JEY09XbFV4UGZM?=
 =?utf-8?B?U21XOXoyVjBuR3dYWGhNY1VpNmNIeERGN3Y0TFhxZzV1ejZwYkMrZm9PME9U?=
 =?utf-8?B?dWxSRWtxdDhia1A2WG1yeGRsbVNXNytXTDdTY2Z3c0FzNkhESjhaZ3BkaVRU?=
 =?utf-8?B?WStjTXJOWnk3dGJTRTl5K2NwMXJvRzFhdjU2VUNrdzFIWlQ2WUlmUmFDSDVv?=
 =?utf-8?B?RHg5Q25DTWl0NU81WllaQkd5SEtpSVBMYkdNMC9mbTgzMGZOYU9XbHErNjlt?=
 =?utf-8?B?VzdOaHpFVTVkMWJ5cDVTZi81WXhOMzFiV2M5SGtCRzRmOFZ2a25XNFNUclUz?=
 =?utf-8?B?WFU0UHU5NTNQRFcyazU5L3Q4ZXkxVTUwcGlvc1dhcnA0R1ZaWFpTZkdnOHAz?=
 =?utf-8?B?TEpMMXY0RThMTGYydlljYUdRbDBUZGV3S3RYaTlPOWY1OVI3ayt3algzL1hX?=
 =?utf-8?B?YjhIOEIrRUVXeTEyYVZ5NjRKdzJUT0FjekFETElGUGJnbUR0SnFkTUx0OXZx?=
 =?utf-8?B?d2VkWFQ3TERZTE5zQllka1dmWDQvb2JhNVFOanJtMDJqQ2dNMVpFd3pHTFBY?=
 =?utf-8?B?anVRZUJlY0w2cWZsM28xTkY0OHBldnNFR3RYWTQvN3d3RFNSa1IxdENvc1NE?=
 =?utf-8?B?eDh0U3lJbStDaEF5QWFiZHBXK09vQnVBR3pzd29sYUErTXFHM3h5NnpPOGtu?=
 =?utf-8?B?YmlTNEdINi9RaHZOU2NsQXg1WVF2aXdNZVJEY2hKb0pJVEwxWmJnTStoNm05?=
 =?utf-8?Q?8kHcgTKQQ1khB1g2irruYQY3W?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc48db1e-9982-445f-0e2d-08ddce91bbfc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 11:19:07.8204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+BST+h/DzXm7iJrC8CCEIA3LriXC6m3KhJGOzKFTSX4KLg7U7CgvrrHvUd6BptWBazzjUdccsbM0wA1E3ojOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9977
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

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (2):
      usb: dwc3: gadget: Add delay after software writes DCTL in dwc3_gadget_run_stop()
      imx95: Add support for booting from USB SDP on USB3

Frank Li (1):
      Add serial# for SPL SDP download

Ye Li (3):
      Update VID/PID
      usb: f_sdp: Update SDP driver to support PQC container
      imx95: Remove ROM info USB instance workaround for B0

 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi |  8 ++++++++
 arch/arm/mach-imx/imx9/scmi/soc.c        |  2 --
 arch/arm/mach-imx/spl.c                  | 12 +++++++++++-
 configs/imx8m_data_modul.config          |  4 ++--
 configs/imx8mm_evk_defconfig             |  4 ++--
 configs/imx8mn_ddr4_evk_defconfig        |  4 ++--
 configs/imx8mp_evk_defconfig             |  4 ++--
 configs/imx95_19x19_evk_defconfig        | 13 ++++++++++++-
 configs/mx6qsabrelite_defconfig          |  4 ++--
 configs/mx6sabreauto_defconfig           |  4 ++--
 configs/mx6sabresd_defconfig             |  4 ++--
 configs/mx6ul_14x14_evk_defconfig        |  4 ++--
 configs/mx7dsabresd_defconfig            |  4 ++--
 drivers/usb/dwc3/gadget.c                |  1 +
 drivers/usb/gadget/f_sdp.c               |  2 +-
 15 files changed, 51 insertions(+), 23 deletions(-)
---
base-commit: 182cb30084516c3085d2ca5dde3f105f7625d774
change-id: 20250720-imx95-c51f08620358

Best regards,
-- 
Alice Guo <alice.guo@oss.nxp.com>

