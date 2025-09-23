Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD685CAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 05:47:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A25E6833ED;
	Tue, 23 Sep 2025 07:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XefnESX9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6218983443; Tue, 23 Sep 2025 07:47:35 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D20F583390
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 07:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jq2gqmzjcdvGaT+fIzNLTL5fug4tI5jZb2aWFc9MDrvmW8SBZ1lwEo20NscGpiEL+fWIa5+4xlHeI+rblicR7B8X1Cxqo8YJZuN2Yz/ecywDlCxbI0FYUdC06qFSCxymCO7ezXr6vTxVvEin2SBHhpOsela9Cs+bnDIGdHCSLsr3xl31nkq7RH/15FA/f9ho/7DmWc2i01OdUYk4QrU+M0zfao5rn1O93/oquXPXSvUux6j6hui8RZ5xUy4IqkK73UeDQ7X2bnwPQOQ7M9yzV+lIb59N0Krx+GnFHN/NN09eplnA4IOMGpsAq6YZ8QaaM+B4058LbJfwknELxyHe5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xZJG8lhzJA0F55Lrz/hHNB6Ib168WvkIU/JiDkBIZw=;
 b=AUmtuJzb3dYY7iGUXW9gHh+AdKPbYGUr5a9ss6b6gMEu805L9Pmdgn6QErQhBB9DXmrbD/TxYXSnV3NiCRtXHBTAnySAPEnIxAEWwreaNSxHat7cKC03LCK4EGVyvj8EtSJJQyN+zltxpTHIGXa3b3uXT0fGxLlKJxdz8zRxn5yREGVyfIjwWWIDzNzetZu2nGjfdgMdGwqRiXCXVeVHexZNEaArqA7a5XekP/GQHcctvGQEQ5gbUfIKNZ+CJTy+zOGoOFAW00w6xcZDkGaI8sscqFE+WCAjNTn+ggY8jNbMkoeLk36Fy5Zl+wOlVHlmljLuLVwyk9fCo17APC/QwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xZJG8lhzJA0F55Lrz/hHNB6Ib168WvkIU/JiDkBIZw=;
 b=XefnESX9Dao12YH6l0IS+RtAApgCZPLb6bOreLQ4zhNILrXi+vysEG+NYKtv8YaG/Zl0TkAq1w8tibD8kYC6/ZMDIaJezlxLYbKnP8B+Zz7P8ql5gqYhSZp6P5VRcSi9LRfoIG/vluIo5EjwosXslKyI7Wk4E/7nC9v5xJLTlKtAJRm6psnLLIUmcWzh5eZYOKgA0yJXHk/BJt7j7Cg8y2VDZMVTFH0FR7M/fWcosA6Gc695adpJCp3ZfpcfoD45QP0jvN4XGtznwdhj6HM+v3ByyyFfzLOerEO4yWxlvV1oSeoKMal3X7Otip8lKq+nQjP9uww6kjFqG3z3+fEeDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by PR3PR04MB7386.eurprd04.prod.outlook.com (2603:10a6:102:85::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.8; Tue, 23 Sep
 2025 05:47:31 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 05:47:31 +0000
Message-ID: <cd29c886-dcfc-4268-a475-3932765fb9b3@oss.nxp.com>
Date: Tue, 23 Sep 2025 13:47:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] spi: nxp_fspi: Support i.MX8DXL flexspi
To: Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de, jagan@amarulasolutions.com, peng.fan@nxp.com,
 uboot-imx@nxp.com, alice.guo@nxp.com
References: <20250922111143.1204915-1-ye.li@nxp.com>
 <20250922111143.1204915-3-ye.li@nxp.com>
 <CAOMZO5CcvBz97mOpZ0RwAxGMJg9ry6QEnNMZCTMUpLufMnQYSA@mail.gmail.com>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <CAOMZO5CcvBz97mOpZ0RwAxGMJg9ry6QEnNMZCTMUpLufMnQYSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0026.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::13)
 To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|PR3PR04MB7386:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e6cb429-c593-4856-bdd4-08ddfa64afb3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|42112799006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2hhUUhsNmNTenpiT2tRZm41QzNVMFlsOWlOb0xnSnlIVWtDb2h0cHZIbHpu?=
 =?utf-8?B?TVZoWGNkdVY3MkRaZmJqeVBiWDFBd1hlMDJhM0VnY0lBWndQcFVwSFBXZ2Yx?=
 =?utf-8?B?WnNDTXgvZGMvbmk2Z3NhQ29HMXFtNTVxeXVIa2g3eWh5eE56dlRCeU11QTBY?=
 =?utf-8?B?NUJHdktzdEJwbWhWbXhxL1NUbzU4Qnc4OXBUQ2hDSlRTR1QyL3d2dXR6MXRs?=
 =?utf-8?B?N1lJRjNTVk55b1RxNTB5bHArNUt4dmhJTUdqUytVZzlWYkhDM21RVkIvbFZ4?=
 =?utf-8?B?N1FvS0ZWZENCcHUrNjQ2d0tFOXpkYzBPeWdEQUFFckdZN2kweVRvc3dIRnBJ?=
 =?utf-8?B?QUpyTG1YM1pHTDRJU1VVcWIvdnN0V1kvN3gxSVZqWWxFUktYbWNaay9BVDVm?=
 =?utf-8?B?cnR4Y0RYc20yN0hSMVB1a1NBaTVLQ2tjUVh4Z1BjbU5CSTBBczVWMThSUzU4?=
 =?utf-8?B?alUyZnllTWt4UWhtNUNkOVNvTkJoMTdVMllZa0dpcmg1WXNOeG5YNDVYdWRQ?=
 =?utf-8?B?Sm40RWxqODVZS1dBSnVBWTJ4QzduRmhheXBucm9xcHFGUkdYVWFEOGNSSjhh?=
 =?utf-8?B?SnZjSUJQbWYrNGtUMEFvV3dmWENBcGcvNmpQWThiTTJ2aUlVMVEwK09HQWh4?=
 =?utf-8?B?bUM4STdja2x3c3luU3d2K01GMXFvNEUrNTJ2REM3eVVyVEJsbEc3Mlp4bzR0?=
 =?utf-8?B?VFo5VjQvSC9hQzZISCtzbzdPakNHTVBXOUYwcE55VE52djdJU29iOU40RndT?=
 =?utf-8?B?TW5SQ1N3ejg2UUFES2xTaER6enpsSFV3ZzdIQjZKWWJONnZXdEVldWF5WHIw?=
 =?utf-8?B?R2JIamR3bE5hUUpVQS9OTWVncVd6VGdxdTArTE0vN05JYmhldnJYc0MwQkw0?=
 =?utf-8?B?aDR4ZXEvTTdMMXo2RlVnNjNOQXEwVWpwWklET2N1NHdLWXVaWEF0QU1GeFl0?=
 =?utf-8?B?ajNhVlJqVFd4c25OcTNpb3VRRERKcWFlQ0R2Q2pJYm9JLzkxV2c4TXJrUnFq?=
 =?utf-8?B?ck5JbXRoVU1NZ2JmemQ4cEl2ZTdGd0FNQ1hOSnM2TVFXU2tlZWcyWHgwQlZJ?=
 =?utf-8?B?S3VzVXpSUGJZd2duQkRqeXJvejY3ajJ5L1p3VjFUWTlOeGo4QUhkK2Ywb0w2?=
 =?utf-8?B?bVNEbmhiZTY2R2wvWVUzazkrT1JDeHlrQVBaaWZFOExPVE56RlZkcXZGOVFs?=
 =?utf-8?B?U0UxbzVGQmtkeml6bUxwQUJNcTNCZ0RlNE5JMWpIcWlzMWM1dE9MMTI5c2pN?=
 =?utf-8?B?WVlLTTZmSUUyZlVzaHZjZklFV1ZUaXE5UDFNN1JuYlQwTXFMM0JtdmVGMUF5?=
 =?utf-8?B?OUVBaFgwK1hlVDUrZmYrZjBURUYwSXdOMlN1d1NQSzRhTmlWSFRHay9oaFZP?=
 =?utf-8?B?dmVtUStLak14T3M5elQyUzF6S1JZeXN6RDdveTIzQzJRMnZPZGE1QTVwWDdr?=
 =?utf-8?B?TEw4S1pGYVF4TDlDdHRiN1NOTHhtTnI3aTJZMlh5SmVTT2JmbjNEbVlYNktp?=
 =?utf-8?B?VTNiNnl3WWN1RldPNmE3Q1BHSzBOR2Nnc2YyU3A5cno4RFBwQ2ZPOG5vcmF2?=
 =?utf-8?B?TVRhOWVrbDNEc3VSQkFaRkNkVlF2TzNCWFBtaEtBOElzWDlYc3FUUGlia3N4?=
 =?utf-8?B?UEQ5WlZpWjFNNFZUWmt0WlZZMWhra3lEZDRRNXFYdUpuY0lCS1prMSs0Yzdx?=
 =?utf-8?B?cGtyK1lQdGMvM0xmRTZnc3RCTTlkYkJncGZFczhMKzN0N2Z5YlBXdVJ6b0l6?=
 =?utf-8?B?RTA4UFFPbXNLTEZXYlA3SU5paU5mUmRkK0ZjeE55b2RGT3VlRGJQTmdkMlJG?=
 =?utf-8?B?NUxTWWYxZDlzSlZiL3lpeUM3RUY0SXBMWnBEV1lvN3Y0VEFMSWpmOGJaRElQ?=
 =?utf-8?B?ZzhteDExNk1SM3FRTXJEL2hFaVlVSlNBZEV5a0gzWUpBMXVLMmRtdlhqN2VP?=
 =?utf-8?Q?Y/rNh8DUB6A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(42112799006); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEE5RWxSTXZkcm1hVHQ0eEJTTG9ROTE4VFBORE1BeGplWVBlZ0hhVkFGMFM3?=
 =?utf-8?B?cGNHd1JodXI3aEpDa0txcytuU1lIeEd4QXFNeklGNWEvRUZEVXFuTkRSR1RC?=
 =?utf-8?B?emJEYVhVMWYwTTVWRm1PVjBYNnY3dUtFeWFJdHEyRTdhT1NrWEY2NnovRk5B?=
 =?utf-8?B?eWpzQkRyaE5FOXZsRlNDVmxhUjZucEY3OTFLNE00LzFTQk5FNnNwUkJsZThx?=
 =?utf-8?B?SUduWjZoQ0tnWWpQdlFjR3BEK3ZyQmhZU0ZRemNiV0ZSK1N1Wk5YeEVKcmZ3?=
 =?utf-8?B?TkM5VWk0aE5mQkJnZitBMi9CakZxWTBXTmhpbTlvQ3lreGRZQ3UzbGowcEdV?=
 =?utf-8?B?a3hCUThzQjNKVEZCU3Q3YzVkTFlaaG1qejM4SmFKSnk4cmczTUxKODJxWFZ6?=
 =?utf-8?B?bFBDQnp0MUZBUWsranEyYVhRMGZoMFJzWVlxaTEwUGpRNmFmRG5tN0p2dWhr?=
 =?utf-8?B?L09HY2Y3bFRJZHF2aUlEcjVrUCtGL3lQVzlCM0Z4ZnBIMHZrYTlTT1Q3eTlF?=
 =?utf-8?B?TmMrc1pNdXkxT1E1MWV5NjVsQlEyTHNwUjlML3V2UGVIR0VEVFQ3a052emph?=
 =?utf-8?B?aXdIeU1yZysrV1ljUFN1MHgySzJnRjQ1NGFhSzlLSm1pdHRFMWNrTXcrK3NJ?=
 =?utf-8?B?NUdFSWZQYno5aEdDaVp1Y3plRTdKN1VyeDlHMWVmR2lidjFnOStKKzlDVDh6?=
 =?utf-8?B?YWdpbi81V2tycjh5anRNbmhSS3ROZ1FJM1BIMExVT2p5d0ZqNGgzRjQzVWo1?=
 =?utf-8?B?WEVwT0FaZjV2SU14Wm5KMjN3eWJYS0tJZ2p0ajFSNHhJN1lyeVMwWjRxWkJM?=
 =?utf-8?B?L3JzMEhZUitPdDhKU09vTGdmQnhBVU9KdjF0U1NwUlBIRGdyN2lvTDdsUUV4?=
 =?utf-8?B?MUNqL2JFQ1hxTmtVNHl2bmloNkh5dmFMRkR6MWVTVkhRNnFka2R0Q0l0elk5?=
 =?utf-8?B?Znl3ZzlIc2dSa3ZkbktSWERueG9qakdTUmRoUFhBcHNrTkJqWU1JdnNiYjZF?=
 =?utf-8?B?a2wwTUFZWllVcUl3NHJndVRnNEdNWHc2YWlDaWsxd2lleU5QMmVKdHpxWStK?=
 =?utf-8?B?YUtwL0g5eS9uMSs1U28wanJhMEhCTGVxTjR1SWFyL04zTUcvYlZ5V0FWaEZX?=
 =?utf-8?B?cXc4NkVjNzM2dWJuWDdwV1hWelptZVo0c1VmeHJFQzgwR3VUa05ybmhQOTAv?=
 =?utf-8?B?OENIMDlUaEdrUnNLTFp3ZURlU044NURocUErMG5PZHlZa1hFMEFPZXR3Z3Zx?=
 =?utf-8?B?WU1mUHNuOThKR3MrdzV0QWNQclNadTZINEZnRkZ3SXZVSHBEdDlOQkZibWFM?=
 =?utf-8?B?VXp2WW9OWi8venVhb0FXYWliakZGUUJhQlloZVZTTDlwL2VkaHdYSDhQbXNG?=
 =?utf-8?B?ZjRONVF5OG04WERIZ1o2eVJlQjNtUDFhazZyaW56RlliUGxwSVV3dEswTnV0?=
 =?utf-8?B?RUx0MUlLVXZwRHJZUFR5YjBSOWJXNzBqVGJ4SGtkQk80bUhhbi9VWXZhdjNN?=
 =?utf-8?B?QVh5clA3TVRuZUNKZ1lNdTUwQWZGTGg5ZWxhWEhQQXRVRjBsamhBSUNYQzRK?=
 =?utf-8?B?Uld4M0JGMlA0eS9RdW1kUGFjQ3ZkbEFMVGQzbDVkMUl4bGFSaEd5TGN2S2Iz?=
 =?utf-8?B?MU1RRC9DdVk5MHFmYkI4bzJqZmYra2pWSmpiZmJLbFRlZVJyaWhmU1lEYXlk?=
 =?utf-8?B?R1FJRldQdEZ3Skl3NmVyWEk0YldBV0Y2OEVrQWpqYkRGYXdONFFXMmVLVTFK?=
 =?utf-8?B?TzdGYW95NE1zRlQ5a1ZWSk5wcVM5c1lWOUF5aTFuRWRaSTlTM3d6Q2J4Q2N3?=
 =?utf-8?B?NVhoWkEwQXZ2VW5kLzVsQkptcFI4UVlDSUN1N21FTS90UVFwZ2h4bFI5NGFm?=
 =?utf-8?B?WWJyTzd3V1VLVExEMFJsdURWbUZsY1BGNmZ5TlUrbWhiREZETU8xc2Z2ZHZU?=
 =?utf-8?B?andmTGFad0xYSHJEcVJnUE9NczdPRFpTNFliZmdFbytmSVV0cHA3L3QyY2Mx?=
 =?utf-8?B?anpqMFN4WnpYazlqeVdrUGZBVXNLdjBrNUhOS3BoRFR3V3ZqOWpqK1JMSXd5?=
 =?utf-8?B?V2lBMXFiVDRmamxtTVl3Vnk1dk5KdUVLS0xFVEZERzBJbXlEeHhTSWUwODJ4?=
 =?utf-8?Q?CAgdPNfr83KynSRxM0vK7oy/7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6cb429-c593-4856-bdd4-08ddfa64afb3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:47:31.2207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hzm+3vQJGTdQPKuQVMEX+Ab07sL/a0TphQtNFHHml2UUsUdKNMLOiaYSgwVCM8bp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7386
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



On 9/23/2025 10:14 AM, Fabio Estevam wrote:
> On Mon, Sep 22, 2025 at 8:12 AM Ye Li <ye.li@nxp.com> wrote:
>>
>> Due to a errata on i.MX8DXL flexspi, we can't use AHB read, only can
> 
> Is this erratum public? If so, please add a reference to it.
It is a errata ERR050601 for 8DXL A1 silicon. Latest B0 silicon has it 
fixed. The public errata doc is only for B0, so this one is not included.
I will update the commit log in v2 to add detail description.

Best regards,
Ye Li


