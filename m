Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8F7D358EE
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 09:41:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6D5283E52;
	Thu, 29 Jan 2026 10:39:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AtQWSpX+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C589D83E52; Thu, 29 Jan 2026 10:39:58 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE9EC83E85
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 10:39:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjLs2tEP5z8SEtZ3akS40Qn7emayWZV98skv558wGUP/db6H+2Bh29EgFk9HJyzq/HsWpf5bRg+V/NiMiiUmXNiHGJ3imQl7Kz9yJtQA1hX9P4EwjwO83mfwyQlNidHVo9YC6PHlI2LNhIDBIu6IQMS7aMXvvwSqo9eIk0wn6qBYd/o4SLg0ZaoutqokAWTnQ1sganLc3QhU6pbP56MjmHlfE/tyZSsw9B2swIdnePGZJX0i3RbAOcx8R4IzqsP7G5SzNIJdQ4ssB6FpC484P8xq4/NSd+EkYXskgco9ul2/B6Nb3Um9SnCVDtZ4RXXK/zKnd3hIvbGIXFenQ6IcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yXWZwOtEfJYfQboTeQrXqAxziF4XcH0mgMYrPjMBMg=;
 b=qZMP59buZl4yyMDkZyNjI6YFMViFU89qXlrfQMyNrFALRwEniWHbmsz7n0+Ir5FYDQhu33/lVYMmfTWiXHzE0ES7NOAGpocrIilKKBJTWH6ENECErnDaiG5IfKFihZHpPdFuM1gRWGpg1/l6IB4Vyj0jbEKpj4MQlJ+xFef0AW2wzOgHkEbE2jFiLRy1tFcE2Zxzi7qBG6s5mmoAEkzlAHAOd2ih6gbSpzP0CR8+vxXGYf42s/rVQBI3dQrTW7z04X6VewxT4sqsnF/iQMg3nzzoER9g3UXnVz49/q0ekKHWCs4hsAckcyIs4AzF6VTIWSE67Knt9pAQEmwrR3xzLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yXWZwOtEfJYfQboTeQrXqAxziF4XcH0mgMYrPjMBMg=;
 b=AtQWSpX++N+cOYZ2Q3paDXLDn1fbK+iKHmw2QWAXyK+aky5WoS558yCRyFahJY4BHwhcM3dIx6eIq1DRuh2CL4RwzR25yaYDv9Qp3a2JOC+eVN+SroZnFva65qxakIFBX4f0niz/oNQPXr8rc+NX/ifz8XGhfWFNauKSKH6jDUBS5EBs9dANMKhuvaZujX8LRutJaOsabtPX7mIkOFdb4ProGIPaJK+oLg3qGCEL90B0gcTjUNaQdaeXpU9Aet+O9XS6H1f8ZilTyEPNhDZNMEWzQcJfjiixaKFAx1G5Kuii0UdBcvAbmyQye6/VxplSvM8Oa+dSaJFel2JU7Hsmjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10384.eurprd04.prod.outlook.com (2603:10a6:150:1dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 09:39:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 09:39:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 29 Jan 2026 18:54:13 +0800
Subject: [PATCH v2 11/12] imx93_frdm: Drop DECLARE_GLOBAL_DATA_PTR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-imx-clean-v2-v2-11-1245ad2c3a01@nxp.com>
References: <20260129-imx-clean-v2-v2-0-1245ad2c3a01@nxp.com>
In-Reply-To: <20260129-imx-clean-v2-v2-0-1245ad2c3a01@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10384:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2d1c05-2e79-43ff-e45a-08de5f1a5bc7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ME03SHExZTJ6cVJyUXhDZXIxVDVFaGYra1hqd2x4dDg1dUdGZUFYcGkvN04w?=
 =?utf-8?B?QnQvWlNHQkhWQVErTkw3a1REbGhPTWlNZWszZUg1Vkp3cTNXdHdPRjdmZk0z?=
 =?utf-8?B?bUlBK1JzbEMzcDNKd1FZRTRwZjRtemFucTN2WHJlUWhjV1Z2K0toTUl1VTRQ?=
 =?utf-8?B?NWh0WVVGalRoOHpoYVR3MFFLbzhWdGZIZ3Z1Y1Rpem1CWDZxNXNTTGg0R095?=
 =?utf-8?B?aUNjSFlIQXNGL1ExOHpjREREOXBMMStHL0E0WFlvZFFab1hVdjNJWk1Ib0Nk?=
 =?utf-8?B?RDFweWZnL25Rb0sxSE5WYnBXY08xaExpWkFheVRoUndocnBGVUdwY0hFVFNZ?=
 =?utf-8?B?NWhyZFNsWmwvL0dPYWdSd1hUVzZBU2UxbUs3aitEdEZ6dUVKWEJrelliMG9P?=
 =?utf-8?B?S3FUZHRhTEtjRHFFc24yQlp3ZUN0cytTNlhNVWJrVUYrOUR4Si9vanNPeEY5?=
 =?utf-8?B?dE8wUmRzWEhqTFoydTM0YVpEQmY1UHBkdEpqYzI2UHJpWFg1ZnNCWFVxTWhu?=
 =?utf-8?B?c0VkelZTNnE4dmVMNzA4SVVWd3V0Rm1KNy9GcjF3USs5U0E2VGFsc3FUYTBT?=
 =?utf-8?B?NnhzWFNraUFsYWVidDF3OHpLODIzSS96d3U2MTZpTzYzYTBNTWM3Vmxna0ZJ?=
 =?utf-8?B?Z2piMjZvOE9saW1WZStmdUh4L0plTXROWkJaeXBoa3V1YmRNYlM5UW1rT2Zw?=
 =?utf-8?B?UG1XK0dIN1RJNmwzZkJaTGllQ0FtaDg5ZWhsdVpDYXZPdkhVU0cwaXJINGVt?=
 =?utf-8?B?NEc1RFY4T0k4TmJoWk96Yk1rZjFNbCtVUzREQS9CZFRuYW9JU3dWem1MeGRQ?=
 =?utf-8?B?UEtrSWhzV0lIL2I0bjRzTVNHT2twNVRBc1ZmeXBXaEJlM3RoU3FXdUsyNlNP?=
 =?utf-8?B?bWJIbUp1UEtNRmFBU09vdUpSWnYvRklEaGlweWJ4UVp2d043VDgwTmRBdklT?=
 =?utf-8?B?cDhxbTNnKzhBVVFpclQvN3M4NnlySkZoYllaNmZWMitKRkhXQksxZFI2S1Uy?=
 =?utf-8?B?U0VhMVVobTM4eVQyb3JKL25LbklJSExmTkVaRzB0ZVMydTRNZGIyMzlTZHhK?=
 =?utf-8?B?TmtnYkV6TndYdW1xWjdwcGFSdk5xUkNFK3JUZGJ0WFJQY3pORGxTSmtRVFht?=
 =?utf-8?B?TzF6VDRnWlY3RXZSQ2J3bnI4M2xRbUwxNXRJT1Noa1REbnBNQWE4Vld2NUJv?=
 =?utf-8?B?dkVVL0owVzFXS0krRXJpN1c3bEtPK2VHTVE1L2tXSDZScGJnbjl4TnJQSDhR?=
 =?utf-8?B?L3dCRkRMRExRQ1VoT3NUbzJZeCswVkp5RU5lNXBiZEtqeWJaZDhNdTRiMGZl?=
 =?utf-8?B?ckhRbk43QWZkRzE4VTJCVDhOWlRRU2lpMDFLMFFWOFI2bXZ0YmRaV002Q1dP?=
 =?utf-8?B?ZERZUTFYYjBHcXU2emNOYWZTazZtaGd0VGZBMmY5QnYwTDhxM2RSaG5nVzJl?=
 =?utf-8?B?RW5zVEVGdkxKNXY1QWJkVEhYcmFkSFF2dkVOVW81ZXU5aG91d0R6aEN6eFNk?=
 =?utf-8?B?TThBdEdBN0JxOUZXUE9hZ0N1NHMzenJJd3lGMmVWL3pabHkrcllRS3RwOUlx?=
 =?utf-8?B?YUplODNrcUVZMHdVWnBVM0dvUUwwdmMvenl0SmFCNDVUUWVuSkRnb3d0U2Ju?=
 =?utf-8?B?ZnRMTDE3b3VUWjIwcTZJUnNPSlNRQzVpbThUYkR4SThEVXFuMmE5UGZqTmRN?=
 =?utf-8?B?bXlRWjM5RHpYdWkyN0o2aSsvNmVhMVJsMW4yWnNBcjhtZktDaFFXWjV0K0N5?=
 =?utf-8?B?RDRWL2k2b3BQWENhSGhEckE1RGJEc005ck41dExybVM0WTFPV1ZIMDBzd2xZ?=
 =?utf-8?B?Q0w5Vkd3aWZIalFDb2tPamg0OW1RZFpvam9ydC9IcE1YVVg3ODRCYXlIQVhi?=
 =?utf-8?B?ZkZmYXd3VDc3eFFYVEN6aFRJNlFCd0NIQjFFSzJUaEhmV2IwK0dkQUxYMHVT?=
 =?utf-8?B?SU9BWFFFSjY4N2xGdjR1Q2hqbExnZnkxSDRQeGhRWFQwU0ZiZ050b0cxaC9O?=
 =?utf-8?B?YVVFanRjNHRZMnVSNjlQc3RldmpQajR6TStrZHRHZldEcUMyK3FhL2JCelY2?=
 =?utf-8?B?MTFMckFhcmNmNng0UUFFdGo1bGRDRzlWNFVGeWZpdGZ3RXJ3WDZ0Q0JWUGdL?=
 =?utf-8?B?QUREdnZFVDlCN3RLMzhyQkoyRlNodE5jYk1yS2JnVFhBdEVYbVFPK3BTSXNn?=
 =?utf-8?Q?4Vr7OJHpzz9Sja5vFNnP7j0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlNEcWFNcUQzUkpSZGI1ZjdYNDFxeHFZaGIxTTFISk1IOEFjdk5JUDF6MW5h?=
 =?utf-8?B?ajNKRWpTNEZ0ZjZzcHQ4QlVXY3JCaURGREcyN2Q0blY4Mmx0WitPaFVMbHdL?=
 =?utf-8?B?YkwxNnhBTkhzb2JLcHB4V2ZzUm01MlRvQll3UE5hd1FPSUg2QTVOb0xJMkht?=
 =?utf-8?B?V1V2MkhMTGJvNGJaTElReGZoVnN2dDYyNmhkc25jejI2SHluN1FnNTI4TjQ1?=
 =?utf-8?B?YVUrQzhjcmp3ZEFWNkJsR1E3Y2RvUEEwMk55eldkdkptWllzNDVhanJDSUxY?=
 =?utf-8?B?YkVod1d5bEV2bWVpeldwZmJiN1J0QURwZ2t6OExpVnczcWdiWXNpclJkQ0Qy?=
 =?utf-8?B?TVVuUU54VC9ENytNaHBqUENSV0hodXUyKzJIR3hSbjljNk9yMTE0L1lUTHFw?=
 =?utf-8?B?cUtOYTcyc3RsQzBna29iYXN0K3ZoS05mbUNFeWxWWVQxa2JCMVFZQ1FEMkt6?=
 =?utf-8?B?N1VtUU93ZEVsbDVLSktpT1daUStFMUg2Wi9qbEpIZnhienVMSDRYYm5oejha?=
 =?utf-8?B?bG5lTzJEbEIySEwyS3RsYUlDM1ZYRTBOZ1Y0QXMxMDBmUjdJOTVZVzBsK2VN?=
 =?utf-8?B?UHg1Y2FaOFJlZm5YOG5hRVJ2UDBsZkJoQW1QZXJCMVFGMisyVDVENGtCeUpO?=
 =?utf-8?B?N1VsNXd6T2lvNGdQUHlDZTVsSlhUQU5kbTVtQVJyZDZFYjUxd1ZUdFlVV2Fx?=
 =?utf-8?B?U1V4RGhPTWozbXJVemtZN1c1NHlHLzhqM2xIV0JwUFkvc1VOUlhIaWU0VDNF?=
 =?utf-8?B?UGEyRTBuWUEvcFg1VnZidE5qWXVKNXFuYkIrb3JIU3hCTkhsUnVXNkloSXdG?=
 =?utf-8?B?aDY5Y1B6d1AvWmRacTVhUVBoUzZNejNTdWhFNCttTHF0SVZxVzBHdjRzV1hh?=
 =?utf-8?B?K0pBNjUwYmFLWUZEWHpvU2NlQXVvN3UxT2hESEF3OURuV0lXR3hZTXkzdzNr?=
 =?utf-8?B?T0pnemFXRVFWUXpKQlM1YXhmSlQ5Z2ZaVFJKMzdMK0ZrSk9IT2p2NUE0VzBE?=
 =?utf-8?B?YWUxdThQTTRyRURFVUZId1N2M1FNWU1QaWg4QUxRMWtmWWJWYlhqL1N5dmZx?=
 =?utf-8?B?dnpWQzBFTXFnRDBEMkVIVCt0SjdJN3pFNEh0N0h5a0VZOStvVUxFMGUzenpP?=
 =?utf-8?B?eGV4QXAva05hSlYwY0lUV3FvVllMaFpGQmRsS0NYZlowUFFHQi9DaWhwSU5O?=
 =?utf-8?B?SEtReG5BN3JreFIxL28zK1hPSXdiMk5wdEpid1l1ZjhRZHFSNnVXQzZFYVJn?=
 =?utf-8?B?SHJuOGxPeUdvak1iRVBUTkROUHBsQm43MVpwcXhiN0pkRXlzTGdMM1M4bVZM?=
 =?utf-8?B?anBvM2pyaTQ4aTVISHVlVURSdzVoZldEM3NQNTN2a1d6QncxNFIvcHloN3U2?=
 =?utf-8?B?NDZOQlFyMUZCeU8rYk1MWERuMlNtUjRQQ2hrcFpFbEtyR2lhdTdQZWMxQWti?=
 =?utf-8?B?NVpaSDFaVzRXWHpXdWljQ2dHUTBtRmFwTUFrUWx1UXBoK2IwN1NjT1VLMWFM?=
 =?utf-8?B?QWFNMTUzQ3RHcjhSektLUzNjVEQ4M1ZpVHVkZmQ4SEdGNHZkSk8rMUFlVStl?=
 =?utf-8?B?UUxlY2M1ZUF3d3V6bFlEdVYxbHJXaDJiZmdkcFhDM0lpSmlPYUpzN3F2UzZN?=
 =?utf-8?B?UXUvYXV2a0x6VlhPdGVmajBtWlhXdWRzTlQxMTB3ZTVPaEJWRlZNMTZpekpZ?=
 =?utf-8?B?NEg3dVhrejI4SkFmUGtLcU4vZnNQUVI1dWlsWWp3MHJLTEp2T2ZvbUZNMFRE?=
 =?utf-8?B?SGJTdy9OM1k4RWR6WHVJUjlYT3EzSktoc0Rma2VVUzJsYVlsTGx2M0NQVitR?=
 =?utf-8?B?QTBBNFJ0NGZmcEZHUEt1TGh5dHhYR1J0VVdlcGR2TkZWWjlnT0Y2bERLL2sv?=
 =?utf-8?B?UUI3NnpybnhsOHZNRVFmd1lkbW4rbTRSdFYyeVVERzBqU2x2KzErMis2Z0Qv?=
 =?utf-8?B?Y3VERmNJWDBRclJ2OE94ZmtMV1JuVktYVXNKcjZiM28zZ3JKa01XQ3NVVzVM?=
 =?utf-8?B?eU40ampaZzBVNmJKUUViRVJ6UTY5SXdsY1hva3hLZU5jYVhYWDFjNGEwc0l1?=
 =?utf-8?B?M3l4aTYvQUZ0SVBKYlJnekl5d1RyK3NUd1ZzTmJGWlBmbEM1OXZYTTZoSFcw?=
 =?utf-8?B?dWdwRjJ5bmxyRVFScWxoTmo5WmgvbWRYUjZ3dDJNc2dIWE1sbkFwaU1Jcloy?=
 =?utf-8?B?ZFAvN0RUdGxrT1hlZDI3UThKYUwwQVRlcWIxeXI5cWJuZnZyQ2xoY0xuRGtx?=
 =?utf-8?B?UllBbnZjeFRMbkZRZmhoL3JGdEVjZmUvUkhhdllROWpwbkN6aG5iWUJ3YkVD?=
 =?utf-8?B?MHlMK216em5aZG0vU3ZuRUYvUUNZUWMwZ0M1cWlkUG5Ud2tleVpMUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2d1c05-2e79-43ff-e45a-08de5f1a5bc7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:39:54.9060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCFbkpGCE7WF30mkiwPonshzfMeVltK9Hx/RhOxrphxDhjlpKQRAobbXKl4CfHzQHlFq4Q4eavcemE2r2c0KqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10384
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

There is no user of "gd", so drop DECLARE_GLOBAL_DATA_PTR.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx93_frdm/imx93_frdm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/board/nxp/imx93_frdm/imx93_frdm.c b/board/nxp/imx93_frdm/imx93_frdm.c
index cfbcde2e1a5..d97720795d6 100644
--- a/board/nxp/imx93_frdm/imx93_frdm.c
+++ b/board/nxp/imx93_frdm/imx93_frdm.c
@@ -7,7 +7,6 @@
 #include <efi_loader.h>
 #include <i2c.h>
 #include <init.h>
-#include <asm/global_data.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch-imx9/imx93_pins.h>
 #include <asm/arch/clock.h>
@@ -15,8 +14,6 @@
 #include <dm/device.h>
 #include <dm/uclass.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 #define IMX_BOOT_IMAGE_GUID \
 	EFI_GUID(0xbc550d86, 0xda26, 0x4b70, 0xac, 0x05, \

-- 
2.51.0

