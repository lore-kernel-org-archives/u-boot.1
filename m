Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAFCC3ABB2
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 02:31:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C0E588E03;
	Tue, 17 Sep 2024 04:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="c6Xy20vy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 690D388D2C; Tue, 17 Sep 2024 04:30:56 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7207788D53
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 04:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diUv5g8+cG0urBo5XwgeIWJSBrMFBp+tpEcZUmmVkIaMQ9nHjUPppSlzIKSiakWLol8s9DXX9RGdqEPixbZDG/B6sjmxJhKs0PNSb+b11E9+8lwSTvBI3KwytiIHB11f9tab1vH7qsZ0qLhUeapT2XJ+Bm+aBhtyOtPsGaj/ZKkQTjpSXNfvmrtt7onmhG+xN3n63QzOBuKz8EXFMGQhRy4NiHv+pBaKkW6VWLqeR+j9lEnEI6q6R2Gk3M/MKOOXdSAhLoUMp7nD0lrctuEsE5eoBA/hbJjL2zI3KltoPqzjrPCVlRCiAFLFV7DUBh5ZEC34yE8NFNdcF5ypdPs8gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZoLOelCU4Xhhd772PRZwzUbzM/gaUw348o9J5A9SZg=;
 b=P3pSwxNze0hs7QrRv6c1DFSuzxa7uaJQ1MYQwwgdneMdmKpLPES3/eiSO/LTXHuRUMYvSQRPF7dEg4VqBMRea279ognLfHGh7AnC8TOIvh3KZVQxItev5WgoLMSY0DbdRG/zUhw+Iqd9znMoSxX3zqTT3pQFAMOPgx0eyrH6FQjbL7lPRIPRl60OvtwSyzHdX8i6xmQG71xNKjYxhm2x+XOPzNeCiWo4Kpzr0HTTCqWQD53n80htPYKhe5l5seZiHLOtn6L/HslbFGZlCI8Hh9aKEo4VunAwvVu0E5BRcvPAdx1htCwF/HHJGzdGTgTkLYkqGMQtV9IOIo7Uyjh2Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZoLOelCU4Xhhd772PRZwzUbzM/gaUw348o9J5A9SZg=;
 b=c6Xy20vy4Oz4NMsIoY3bwuug6q0N+w4ol5O9vEA3mSaXG9rryogLat6CaoZaiytMOypMn8t8kBwzXOUd2N5TwSkp4wXvmwz3qgqiHyLoSCpX0DQnyNp5kdwDn8RdhrVrn5jT08QvPvQL5KB7IIMHjj3OEDcIeUmnCE110RjdKHTVz5uHd9+fCKhjGGokQcEOmn5XTpBWZMSoHcMUmcftelLqBanBEWlw5AE898RYF3vegJ+PLKelmavq5yyus0VjKKWz3dvvZFyWeyDHcugytIhj24HSOVmkYtJW0h1Kx+nUda5RDXdWA+D/F7aTnxV6sU/Q2KDjr9K25sP5A5Fi3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB9739.eurprd04.prod.outlook.com (2603:10a6:800:1df::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 02:30:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 02:30:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 17 Sep 2024 11:33:58 +0800
Subject: [PATCH 06/21] imx9: soc: Change second Ethernet MAC fuse layout
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-imx9-update-v1-6-4fe8effc937e@nxp.com>
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
In-Reply-To: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: e22bf73c-2791-4f18-da3e-08dcd6c0bede
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3JMU3RnRWRsUnRSZFpMb2pYWFducXF2enJ0SzFhYnZnNi9QMGR3eDlnVmVK?=
 =?utf-8?B?eHRQSkF6NkViRy94YWtTSWxrMVVxZUpXVCtvby8wSzRtNVFvRGRySXlsRlJF?=
 =?utf-8?B?MFFQWXJoeEdocjZiM0xwUk9KSUpEVXJnWm1iY2M4ZlFhZURjVmhCcnBtekpz?=
 =?utf-8?B?QkRiTkJYNTkyWUxBcjJwbExFV01FZ2Ntd1hCU3BHZExFM2NNMGdXMjBRVlJL?=
 =?utf-8?B?T0ZiNDRSdURVU2cxMHJiaTIrSmI2TW1ocUFDU3ZrTjVUbkR5SmtGVDhKenRM?=
 =?utf-8?B?c1Z5dlhhQnl1Qm5wYldTc3h6MFBGaFBZVStibVlGRU1qVnBHUmF5cjFwekgy?=
 =?utf-8?B?ZnM0eFRPbkh6WTV6S3o1VXBNTGVhMExXaHpiajZyQzgrVmx5Ry8za2lmSE9T?=
 =?utf-8?B?eWlmeHBidWNOcjFOQVJYdW9QUGZBcXdzcitZdGtNYjBCYUFjenlCNk1oWXky?=
 =?utf-8?B?VGIwMTh5OUNHNGU3Y3dTTEFMZDM5dEJmeXYxck1pL3hEWE16SGFaSEY4Ujdq?=
 =?utf-8?B?aERtSGxTRng0NzRUSW9PeGdNWGl3eWlueUNoeE5BUUd5WnFoOCsyQ0kyQkJr?=
 =?utf-8?B?MHp3Z3pwazBOZmZteEZwQ0lCVWlYVHBIT1pzSnJNV3RwOTg5UW5QQnNiS05q?=
 =?utf-8?B?aXAyYm5mRC9sNE0vSHVyNEtCcWFMbEtMNFJTdVUrakVnQkY4WHRSODdZNTht?=
 =?utf-8?B?U1JKTTZiY2xTbGhCbmsyZkFPZ2N6bWdmTjBra1pUYXRLVXMxVTA3b0o1cXNu?=
 =?utf-8?B?TzU1dFhqWStaS0xMQVJxeHZzWjFWKzJsQ1pOT2c2c1FvZ01IY2NwRVhSTHFw?=
 =?utf-8?B?eHVyZk1FdjcweVNzbWVxbzl1dVdhd2VrTWNUYkNXSzJEN1M3SDM2dzd0dkdu?=
 =?utf-8?B?MXlDdCt5bXZ3NlljdEdQMmJjdi85c0dQYXoycGZLR0hRTXBjVXlIM1FCN0w5?=
 =?utf-8?B?TlBLMXp4ai9aclBHZFMxZ2dvbVF1VStMYlloK3owVndNR3NNaDNIcFFyVGRR?=
 =?utf-8?B?MDNjRnpxUGVYMUhWNHBSNHFIRTlKRnZWWldsUExXbnRQS1JZUkdFQmlyT3JY?=
 =?utf-8?B?c2diYzRmVC9laWhTOEVxVmhkT25pSU1mWENQS3ZBaTRmN2JRdU9IV0dEbFFG?=
 =?utf-8?B?VnorUkpFOXFzSjFwdEtVY3NzZHVYT0xac3hBWGZVMytrcmg3Q3lHbk1hZnJk?=
 =?utf-8?B?ZCswdnVoR1NzUjdDYnpmcll6NXFGeU90Qmt2OXVJQmVzbUtScUttaWJSQ0RB?=
 =?utf-8?B?aVdKQzg0WGd1WksvNlpHKzZFYUtNSjIxMXI3cVRtbUxuMHRJek04OXZWT0Z2?=
 =?utf-8?B?bGpzeFpmdjBqTVN2ekVOd3l6OC9hSXFHVHl3TTNZcTZiZFVNRmpKTkhqalpw?=
 =?utf-8?B?dm91cHlOSUZibGpac1JBNjUwUTd5NUczWUNxbmNOUCtCQTYxNnBKOHZwVjkv?=
 =?utf-8?B?TENFTSsrdTRhVVJsZzNSb3pFdEprM1JKeXJ4Q3RGYTFxSklqU0JhR2xHVmlG?=
 =?utf-8?B?TkkwZWhRcWdDeHQ3V3N1VlNrOU1SWVpRY0FKUnJHWnE5bzZFdTdBb2JOcHhQ?=
 =?utf-8?B?L2dmVVZXQWFIUDVuK09JQ3V3NlpuYW5laXV2WTFPNmpvV1dWMVBOMm9vbjY0?=
 =?utf-8?B?MWVSbXpmMEVNOWg3TXBBOCthcDZ1NmY0UjB3VlpEVWNhdElxVitldFo0RUU5?=
 =?utf-8?B?NzRtRGpOTmN2VmNNVHovTm9WQW9PejU5QUZvTk9IOGZrVnptRzhBR0lKL21r?=
 =?utf-8?B?MTkrY1p6ZU9DK1JyWXNiNEl6US8wZFByMW9TVTk3UmxGQSt2SEZvK0xtbXhB?=
 =?utf-8?B?c2JNYTFLQ2tWNDFHVVdQNU0rbjd5aGkzd3hGaUhOL1A2bHdoTDBjQnl1VW4y?=
 =?utf-8?B?d3Q4VlE0MGovRm1MZy9aSExrRS9aNUtyKy9weExqU1JxNHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUgydk5GVzRaUEc5dHV5R3NmSFkxbDdtSHNkNnhzSVZsZzBPSnFockZ2Qk56?=
 =?utf-8?B?Y3QxMzlyMXdLWTV0L1RZbVRIYXdwa09RSWJaVGl6dkdBU2s2Q3ErZG9BeUhK?=
 =?utf-8?B?VExJL1p5RU9IUVFUSlBRWTlmTXpxdVlTaENScVhNVXRqTmVxMlJqelNEREs0?=
 =?utf-8?B?Vnk5Q1piWXU1RExzbG9Md1Nad252K2tkRTRMOUVvcnp1SEVybXM3SExtOTly?=
 =?utf-8?B?eDBjeWpwRFgrcE1uSVB6MkpySTdEUGQxKy9wai9OUitJaXQwZmk2aXZKQ3dD?=
 =?utf-8?B?MUtDVzZZOUhSd0xaT25CT0pRcEV6R3hxb2UzUDgvMVd4UUg1V1NPZ3B1a3E5?=
 =?utf-8?B?bWlRT0ZOY05lbElIRFpTdzVCamozL1NmSUdrRnZHQW9tcVJYTUlXM0JWbFJ6?=
 =?utf-8?B?eENiKzNad0picUkvbTUzN0JpNWgycU1uV1Z1THYzazYwdHh0VnVPbi83Z09T?=
 =?utf-8?B?dDEwRTJmajVZcTlGeVBHOFdEZlJQNzVDRGZRYzBaUlpCU3RCOFU4Q29aL0xu?=
 =?utf-8?B?K1lOV2pSeVJkM3cwQUs3M1VhbnQ0T3FrQzBRbjdqUElBZ0k5d2Y3cE5yMVRm?=
 =?utf-8?B?N0FJNnZpTVNIa2lQelFvMzNJdS80aDFrK3lPa1NDbktTZG5XT212WG83MWg0?=
 =?utf-8?B?RE1ycHdmaDExMmlVTU9qQTFLWHI1eUtZWjhlU1l5Lzdya1VoZXBMVXVsZ0lH?=
 =?utf-8?B?TUtxQnlPNWdJaXMwYnRoZ1gyd3pVWllFSEtVK0lraytkQUpFWmFJTzVkZzZw?=
 =?utf-8?B?UUp6RDFhbURydkVXMDZ5T2MwTlNNM0VIaXJ1NWVaYXhZQUpJaEw0bm5wSTlG?=
 =?utf-8?B?QzV1WWoySUNIbkxweHZTUXJhSlloK1JQeFBoODVBNnorcjNmdElrc1JrM28w?=
 =?utf-8?B?cit5SnptMU5pNE5JS01XYUZiWXVhYnVscG1FdjJYcEwyb3duWGFLU2NQL2Z6?=
 =?utf-8?B?a3NxcWcxYTZJRmtSWkFuUWltQysxN1ExY3FXUWtDT0J5bUtuZy91dnlQSk5w?=
 =?utf-8?B?QjE4TkRLbzBQM2dBM0JMdE1EOXNNQVZPYTdWN2RmZUErN1g3UEFUaXNrWVpz?=
 =?utf-8?B?R1VxT2RlZTZYM0NUdEI4WFl3QVBtNENhdkZMWUkxSjBVNWk4M0JnemYrYnRV?=
 =?utf-8?B?elJXOFIxMlcyTjl5bkQ1RnBCcm5Ia25aWFBkVnluRVM1MzNydGhHOHZObUxE?=
 =?utf-8?B?MDZLdVlCLzRRYmZVMElkWSsrdHdsNmlsK3pZMDNtOFlEdzZQR1RRNUdxbmt3?=
 =?utf-8?B?d3dUd3Y1cUU2T0RUa3VXdDh1S3Zqa1d6OTNoUG5PZW9pc2hTSHljeVhqd2g1?=
 =?utf-8?B?MTR0Qm5adS85TTgwWFJhZ2RCWURJRGI4d3ZXSyswVDN4WkhsbXVNNEdvdjF4?=
 =?utf-8?B?MkMvZnRTUmVMMmk3ejZ6MmQzTVlYdk5DMWp6eDcrRW8xYW42bjNOL3hyclg4?=
 =?utf-8?B?L3hYK1NSYlNTRmFkUjZ6TlFwekVFOXhCc0tVSzk0ZlZSMGwwT1dUTlAzdzA1?=
 =?utf-8?B?QVRhazY3bi94dHBncEIrUDVCbmhudHNiRURzbjZ0MTNyN0Vld0tYTWdhbjlC?=
 =?utf-8?B?ZkVsYjZhcE8vK2dMK3J3Q0FpYTluODQ5RnF6cXBwZmlDeTAyT2NraW1BZkkx?=
 =?utf-8?B?MkgyZ2tzT243OWpBYjNIWWJHbmt5NlI5bW40c0NvczVNRGZybll6dmU4REYw?=
 =?utf-8?B?eTdEaUJnT2t5Q21pYU5GblY4TkwrMHFWM0R3U0V1QlZ6QkU4UHZBOThxLzBt?=
 =?utf-8?B?cytRakJVZk5BYmQwUnlBNGE1ZkJQdjU0RlBJZDBuV3FKYk8vdHIrcVl1a2Fa?=
 =?utf-8?B?cWMvdkRPb2FmL2dTcVVtZzF0RVozaFdEN2VGbjluL3N1WGRUZW1QZ3M4OUpS?=
 =?utf-8?B?ZSt4RDE1d09ob0RtQnZOSGozZG1SNFZKOVNRTGpGVkRkL3JIR3NESXA2K2ll?=
 =?utf-8?B?NHJ6NkwrK1R1cDhXWnp1S1JONzlxUm92RHVtSERhRFhDdnhNZUc3RE5QVWYz?=
 =?utf-8?B?Sk9HeGpDcjFPRHljbHhxbzFWUnArcVphRG0vVW5NL0NWTnBzQU1IOXdVZ204?=
 =?utf-8?B?VkVwaGlHTlJEaVRoRkRieTRXbDJFZC9GL3c4SzV0elZ3TlY2aWZiUVd2bFYw?=
 =?utf-8?Q?IWqGfjF9RMX6idRwbDMuhIevI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22bf73c-2791-4f18-da3e-08dcd6c0bede
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 02:30:50.6113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCWQCG4VATeHyiUMOXjLNCHEsw2dr8kr2UV8/FPVQOcE6+Q6zQosTlZO+GAhhffaPoMpRXBY9l4DGgtIyeg8sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9739
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

The second Ethernet MAC (eQOS) fuse layout is changed since i.MX93 A1
following other i.MX platforms, for example i.MX8MP.

Order for A0:
MAC1_ADDR[15:0]
MAC1_ADDR[31:16]
MAC1_ADDR[47:32]
MAC2_ADDR[47:32]
MAC2_ADDR[15:0]
MAC2_ADDR[31:16]

Order since A1:
MAC1_ADDR[15:0]
MAC1_ADDR[31:16]
MAC1_ADDR[47:32]
MAC2_ADDR[15:0]
MAC2_ADDR[31:16]
MAC2_ADDR[47:32]

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/soc.c | 54 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 42c6deedbf2..5b0fada8295 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -496,12 +496,21 @@ void imx_get_mac_from_fuse(int dev_id, unsigned char *mac)
 		if (ret)
 			goto err;
 
-		mac[0] = val[1] >> 24;
-		mac[1] = val[1] >> 16;
-		mac[2] = val[0] >> 24;
-		mac[3] = val[0] >> 16;
-		mac[4] = val[0] >> 8;
-		mac[5] = val[0];
+		if (is_imx93() && is_soc_rev(CHIP_REV_1_0)) {
+			mac[0] = val[1] >> 24;
+			mac[1] = val[1] >> 16;
+			mac[2] = val[0] >> 24;
+			mac[3] = val[0] >> 16;
+			mac[4] = val[0] >> 8;
+			mac[5] = val[0];
+		} else {
+			mac[0] = val[0] >> 24;
+			mac[1] = val[0] >> 16;
+			mac[2] = val[0] >> 8;
+			mac[3] = val[0];
+			mac[4] = val[1] >> 24;
+			mac[5] = val[1] >> 16;
+		}
 	}
 
 	debug("%s: MAC%d: %02x.%02x.%02x.%02x.%02x.%02x\n",
@@ -565,6 +574,39 @@ static int fixup_thermal_trips(void *blob, const char *name)
 	return 0;
 }
 
+void build_info(void)
+{
+	u32 fw_version, sha1, res, status;
+	int ret;
+
+	printf("\nBuildInfo:\n");
+
+	ret = ele_get_fw_status(&status, &res);
+	if (ret) {
+		printf("  - ELE firmware status failed %d, 0x%x\n", ret, res);
+	} else if ((status & 0xff) == 1) {
+		ret = ele_get_fw_version(&fw_version, &sha1, &res);
+		if (ret) {
+			printf("  - ELE firmware version failed %d, 0x%x\n", ret, res);
+		} else {
+			printf("  - ELE firmware version %u.%u.%u-%x",
+			       (fw_version & (0x00ff0000)) >> 16,
+			       (fw_version & (0x0000fff0)) >> 4,
+			       (fw_version & (0x0000000f)), sha1);
+			((fw_version & (0x80000000)) >> 31) == 1 ? puts("-dirty\n") : puts("\n");
+		}
+	} else {
+		printf("  - ELE firmware not included\n");
+	}
+	puts("\n");
+}
+
+int arch_misc_init(void)
+{
+	build_info();
+	return 0;
+}
+
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 	if (fixup_thermal_trips(blob, "cpu-thermal"))

-- 
2.35.3

