Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9679E7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 01:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C16B68006E;
	Sun, 15 Dec 2024 02:06:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="echftJvE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D34CA800B3; Sun, 15 Dec 2024 02:06:00 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0A058006D
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 02:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpswP4tFTnpyJ0psN2e+dlq9WFuaeojehai+nLhXTRCeEazXz1PbKuJcmtWuSOJbfyA3UvGuSka6mQCJAew2IApAvImn10k8FZciKFAFL2Gk1Z3CzRqmHqz4++rqcfsUK4O4mDsM1Bt8EY3f4EbGeLVFvz3CZEm5crTN1nkSbZQFBZgWkF75m8Pct0Fy3BQvJVKudoxNAojk9XSKw4KUXo9x7u2zwPwzb6z2EZ6In3NWSEZ45n2gRwKhNmVKZnSrejmUSCGKYvYaF7UuRbdsPl7ScA5MG/A/v3TuhV5ljijSyC74Dsx/5F55/frEOioHDm0Sw2EnvaV1iNvlYIuI1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wupC+hPtiktH61oMP5pAO6b2uxD4hJofQMrS0g256so=;
 b=TGhlb2IY83kRaJm3+DiQUmrx60FF6wu5FiMSJ7Oa9f/FjfWqEkytVVfUcmzHuGlEx+nPB2oHLiJo9OeSI4q4mxQhofR0G87sXtdglHWEER3EL0+BRhJ+QhxAkwUEptbHGh9XQ0FQh3bSd+xx0rzX7tLaSAk8l9Vwp3TgAcVgUCNhj7oTzE8KP5l+rxFED1INqyz2LbWYeMX0saUp6c66I1p6PhMjoWdkePaUQbAHukGQ7f4BecNOOtTyoXGAViZ8K6xUbZEaHfqiCmZxLvQhrr0lpt7drWcV6tIXTZjyxHjx4eOAE3NwpP1VAwuq4gAPJk2wD4fXn0x+Mrdj0Wjt5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wupC+hPtiktH61oMP5pAO6b2uxD4hJofQMrS0g256so=;
 b=echftJvEFeKCn1x6AltWhxwiv8Wk1q68HRghQHb7Gc+O5Z8+YYbJaRliyh5+Ko6IAoXzIe1NnJ9o9jYSl0l/iarpXtyvFr8fA0NbXxBDu2ew8e9dANDFUbvMPYryQX4M3f41cuwFHJdnSjzN7FcE9tdZZLDnNOKMlku9MDb58OHUDW8/nYhY1ZGewmGRFc6b5nYrK2XLu6Rzwqn/22s6iMy9gydYIymRW6e5vYpaGJBsogX5QWXegSrpoD8V1v+wYEsQUss/HQJab7qQptzWPA14am39/oalCopHOWcISCp7/BwkYLPraw6V4J5xgInLNh+4GHwuARzHT1m5DLk+uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7485.eurprd04.prod.outlook.com (2603:10a6:800:1a6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Sun, 15 Dec
 2024 01:05:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8251.015; Sun, 15 Dec 2024
 01:05:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>, heiko.thiery@gmail.com,
 thomas.schaefer@kontron.com
Subject: Re: [PATCH 0/5] board: sl28: various fixes
Date: Sun, 15 Dec 2024 10:11:05 +0800
Message-Id: <173422862034.21608.6712428560264829998.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241213102321.2166920-1-mwalle@kernel.org>
References: <20241213102321.2166920-1-mwalle@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VE1PR04MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: fa3978d6-67a6-4205-3d8e-08dd1ca4a170
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFpXbWNLdVlTUk1Sc3JUR2dYNjJneHlINXRMbmZKdmIwUzFwUCtScHdROExn?=
 =?utf-8?B?RHNOcWtZaG1palV6RSt0TkdnT25laENnSGFjbzVWdjhpVGNJZDJGbjVJREdI?=
 =?utf-8?B?a2NtcHo1bEZLcFljNmR0UXFKWW5vUytVb3V1alM0ZExYSVhhenoySWhJVWp2?=
 =?utf-8?B?emw3ekJPOW92cTJ0UFJXRis0QU0yVzBEc1ZVQTR6WlE4U1JacFowcVQ2YXdo?=
 =?utf-8?B?S0F1NlROcUJaYXd6T296MEZmdFpLYlBFbzF5OGg2bEJ0Q1I2N3dQRU50WjZW?=
 =?utf-8?B?TUpESkIwNkV6NXJySGNpYjlCbkRzRDRGaGxpd2V2Ly8zM2tBcDdiN0NvVUo5?=
 =?utf-8?B?V1VHbk04alVjQityQ1oyMjVnMlA2SysvWGxzMk1sR3dTNFhIMVlCaXJJbnJC?=
 =?utf-8?B?VCsvbHhoOXpMR0dDbXhvekRUZ2N4UDNnTURHTWtSQlJVSE9JVEFrbUVESjVF?=
 =?utf-8?B?Y0w2Rk1rOG1Qc1JHWWVDSkI5QWtXZ25GbGZNc2dTZlVmVnJGenBjUWl3Ymp5?=
 =?utf-8?B?aGZxOGVBdnNzZkJQbUdkWlNkc2cwUHBsVk83Kzh2a1A5anVKdWxUcDZEM3ZC?=
 =?utf-8?B?YXB5WU44Qks2QlpvZXhKNnRTSWNLVmtDSVhNcXRMLzN6TlZWODlDb3RXSU1N?=
 =?utf-8?B?YmlNWHVydkd5VE1UdVRJOUJNMDRiMXUwYXNJbU9zS3NuWHJ4TkRGSEthZzhQ?=
 =?utf-8?B?NTlreDBLekt6OHhIZWlTRXRIa0QyMDIrNGM4dzBTYTRqWkRDaFZ0WVJYVnM1?=
 =?utf-8?B?WnJ1TklSMUFRS1RKdG90Z2ZvWjBnbnZFOG5UK1MzM2lqVTJYeTdTNXJoV3ZJ?=
 =?utf-8?B?Wms0MjBnckxiaEFzM1RoTUdNRVMrLzhKS3VGcm5Bd3c1dEI0VmVNK1JkbXU0?=
 =?utf-8?B?bXlwekR2em9TaEt2ekV2YTFqMW5CbnI1ZHlJRWZSc0VRQU91c0E5SXpOTm42?=
 =?utf-8?B?OU1VVXZmK3c3RDZxUkdHNldacGprTUJmUlJkaXdnMzJSWThydFJMYVNhWGJx?=
 =?utf-8?B?Qis3ZGl5aXZlbkRsZExtYlNlRHdKUXhjRjVzTS9nS0I2eVd3VG1IcUtFTjZ4?=
 =?utf-8?B?ckNTcDdoL2dSVjlSWnlFTnY3U2VERVQ3L1dRQzdaaGhJTTdPdEVkT1IzSU1V?=
 =?utf-8?B?Mi9QbUVMdzdleFJSNEV0UnpkNytscXZzUkY1U29tNzl5TW40VHdXYnVLcFI2?=
 =?utf-8?B?VVQ3Vm1GSlVOUUtYYW5OZWltU3lZN0g4UHBKUTdQSE54bVhiT1IvRlJZa01y?=
 =?utf-8?B?dlE1Z1lwU2hzZVM1V1FxcUt0cklPTWZoV2o4bU9kNDVBaEcvMnhnTFJyN1Fq?=
 =?utf-8?B?RWU2OXZ4dEhxSVAzOFJvSFE1dzdqb0pMVkRSZnNrQlF5b3ZXcCtwTkhpL2tM?=
 =?utf-8?B?d2JWVmlVdHV4WXlyVzZ5aDVmUU9MV0NaUGo3bzJ6SnpEb3haTkx6ZStHMm1n?=
 =?utf-8?B?eVcwZ1ZOSzU3VnRqckNKTW5YcHAvem9vMU41R2p3aDFMVVFNakYweG52eW9v?=
 =?utf-8?B?N2phMWhZdk83ZUJRRHVNTmw3bTBkS09OR2xvbHgwOVpiSk5VcHI5bHdQMUk2?=
 =?utf-8?B?aFIzR1lGNVl1SjB1VDJIc3dHdit5c0hrdDFRN2RtY3ZrWnBZMmJET0VKUkNx?=
 =?utf-8?B?Uy9VNGRLUDVJRm1Cejc2LzZuYmJOV1o1UGJsUWV0cHVPMXFJMU1FQWUwZFRT?=
 =?utf-8?B?WEhWZzBlczc0RTJ4WGRFelJQVUhwNlRSYi84eDdKa0cvY0lnNFhWMDBqelJM?=
 =?utf-8?B?Mkw2bHczRHZTbGNxRmw1S1VWaEJoQkxZOVE0N2NyL0psc0RpVDRtWEQ3S01y?=
 =?utf-8?B?S0hXWFo5OGFWU3ZRNGNKMlljdGZOa3V0ZTVGMFFVVk9TbHlxdTI0VzNUeU9q?=
 =?utf-8?B?ZTVWTXpINHBoRWoxQlYxYWlEZlV5K3FIY1BLbmZCcmlsWkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TitQMVUzS3JRaWpxRXJlQ0V1WFNKcXZGRm0ybzgxQW5PY3RDcjNOc3Q3VFlQ?=
 =?utf-8?B?dlR2aXJ2ZUJXeVBOREIzVVE1NWJpL2FWOEV0V0E0OWRDUXlIckNFOEhoV2Va?=
 =?utf-8?B?NmlYSVR0SE9kdUFGZ2s4WG9XS2xQV0xTN1oxMDZnN1dScE5NY3VSbWpZMGx4?=
 =?utf-8?B?M2JDeUxXbXN6YzhsN3FjbGlBVE9xQWhzWlh5Mnd3M3g1bDVuckVyQWd3dE9V?=
 =?utf-8?B?OXRsYzBvdzdVT1dTdW85ZmxmSW93Mm5VT0VUOXlzL09CRjFNSjBNT2h2Q1o3?=
 =?utf-8?B?NkRISXNQbE9RVzRmN2xSc3hxWDVHV3RPU3VPOEFtdTF0bWloSTV3VEJCcUI0?=
 =?utf-8?B?MnpWTjF5SXMxWjZUVkdSNmZ3SVdVK3lhb3o2QzBxbjhsRUdCSWd3RWlxUGNC?=
 =?utf-8?B?STlaeHc4cXl0U3Fpa1dWazF2eHpvb3lLR29iYTh0TXlVMTZQWi9LRWFVMUQw?=
 =?utf-8?B?MEZHWU16SGQ2Ukt0MHViMkhvbkFPMkpmeXp2QldNYUwyNEM5N0Z4QXQ3WERl?=
 =?utf-8?B?SXdXQkdvUkxQQTIycVJ4bHZFY2Nkcms2MWM0UUpHNHlvTEdBYkhJYkc2L1hK?=
 =?utf-8?B?WHBVdi9hOVFKcVNFYXhaOGZTalBKVE1WVlZjb1EzdHA2aEZENE1GWEI3TTlx?=
 =?utf-8?B?Z0lJQXhReENxWHRqVGFTK1VYT2dDcUg4aUFlalRLYnlRMkVqdC85TnBXOXZO?=
 =?utf-8?B?UWZ6WjI1SzJrNEFVSnZFQUR2QjJCZk16RWlwOExDSDZ0UG1RRVRzY3NlSnpx?=
 =?utf-8?B?cFE2UldmWWFmdllMS0QvU3FSd2VENzJNckVhbVNtcHlUNDBpVjNaN1lJbHd6?=
 =?utf-8?B?TWpYeHUvWlpGVVRsUno3UG82WlZUKzJSWnVualpEdSszNjNDdmRMOTRVZUZB?=
 =?utf-8?B?RklRdDk2MFM3eDFpaGtjb2pMVUlQTnluTTlMS0l3NE4vMjhhaU1FeW9Vcmc5?=
 =?utf-8?B?b3Uyd25vbmRpSkwwVVpBUzRUZHM4SlhDVmF6cFJ2RWsweVlZZFROSjJFblc1?=
 =?utf-8?B?NldjTG5GV2lVYVBGSFZWWXJQd2pyZlVDblNwKzN2YURPSHZOaW82RnFzbGNR?=
 =?utf-8?B?MjBoWEd0aXNkMlRSYlhLSFB0VlB5TnVTeGlzY0xTN3I1VDlGKy84Y3RmRloy?=
 =?utf-8?B?Q3J2Yk1meVhsYWp0WW1WK0p3ekF2ZG5pd005WG9MV2NmOFhGTXk5NjlUME9x?=
 =?utf-8?B?Q2JLckJIb3IvWGsrcXdNTHphYThPTGdsSk1MbHczb2QxRXVMY0EycGMvNEVP?=
 =?utf-8?B?MlM5RW83RDZ1ZkZlRkUvMXZSOUcyTHRobE1scHJINndjUlhmMmV3ZzBmaldU?=
 =?utf-8?B?Z1RXa3JETURPMkQ2eWdvdFFFbVBsWkI3TmFhRzMvcUltUTdJUThaRDdFeDdv?=
 =?utf-8?B?SjdLTVU0cUxtNEllSDIxTUFBNitEbXBzdXRuSGNOU1BKb2xvZzdsT3JDSjVG?=
 =?utf-8?B?QzQ4Wis4OE1QVStPekk1NnJmVklsZXhpWmtiNkZRV2VtTEljMG4xbWQvRVgw?=
 =?utf-8?B?U0FUT2FMcU1RUU53eHJGV0RKWnJFTUQxcmdhZXk1bE1BMWQvTE9OeXA5YkFa?=
 =?utf-8?B?Q2VyKzd4REV5Z2Q0eDV2Ni83WGRXeTlmbFM4a0Y1cjc0SHB1NU5WMnY1WUFH?=
 =?utf-8?B?QzVWSEs0TE5YMG9abnI2eHhHT0QzUGxkKyt6L3ZPcjkrWndjeWROWU10b3JX?=
 =?utf-8?B?VG0xN0FtNHJEZjMvTCs5Vy9lUkxZMGIvZ0tqcXNKYWt0WVFob2ZzdkFrd2VP?=
 =?utf-8?B?NFN0SDdWVkUyNDA0aGNZcDZjSitiMEFEOHNFUHRnOVR1M2NxWU9HemN6Nk9J?=
 =?utf-8?B?ZmFQdmwydTFzL3R2VUduSU5GMXVKRW5uSkRwNzB0dEF4eFE5MjhSWElTdVMv?=
 =?utf-8?B?eldSelZDSUZqaUlFdDlPOFlGcm5YVlJFejVRcE8vME1qdklTd2lMcDFIT2Fr?=
 =?utf-8?B?a3M1dGpGcTF4MW03QThDTTdiOVJKdjVEclZUYnJWWkZpeUh2RDVTU0I5WWMy?=
 =?utf-8?B?THNoSFFZcFpVV1czbE90N0E1SWlIdHVHWUZFdksrSG1NWll1U1Y2Z2JqaXBV?=
 =?utf-8?B?RTNxdzJWWWROMmg2cExVN1BiaXBsaWZRUW5RR1NpTXVoYjR1OEtlS0tFUmln?=
 =?utf-8?Q?b2ekQBlJgcj1PJJqyqYYX9kE0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3978d6-67a6-4205-3d8e-08dd1ca4a170
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2024 01:05:57.0716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToIDhNSLgH1iOVIEsWJwqwraZ5Sttzxu/r8D94JPxATxbm9cGuvd5rjBjGN5Y1bq0CRUIkYTyAOWlAJpss9jUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7485
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


On Fri, 13 Dec 2024 11:23:16 +0100, Michael Walle wrote:
> Give the sl28 board some love and fix various issues. Most of them
> were due to the transition to the upstream device trees.
> 
> Michael Walle (5):
>   board: sl28: fix linking with disabled watchdog
>   board: sl28: increase SPL_SYS_MALLOC_SIZE
>   board: sl28: fix network on variant 3
>   doc: board: sl28: fix table
>   board: sl28: fix USB0
> 
> [...]

Applied, thanks!

[1/5] board: sl28: fix linking with disabled watchdog
      commit: 781a7c660cee194566d8e21f20c156e40bcea322
[2/5] board: sl28: increase SPL_SYS_MALLOC_SIZE
      commit: 6c849340b7ab5953e061885c4f7152bd93e3ba49
[3/5] board: sl28: fix network on variant 3
      commit: ad7ebf1b989baf32e8917695a1611ea051356e35
[4/5] doc: board: sl28: fix table
      commit: 079ae2734c4641b148932c1758a2524492d35772
[5/5] board: sl28: fix USB0
      commit: 56aa021f080096e8a0ac24b31c3ff40662c8b81b

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
