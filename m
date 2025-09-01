Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F14CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 23:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A10283257;
	Thu, 11 Sep 2025 01:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="l3XeZal1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EFAA8329B; Thu, 11 Sep 2025 01:53:50 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 150B283253
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 01:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YISB1cQ7/czMu89KU0Lf3VsVNSE25tOvtJq/+7hxiFsu+F7mTCK7eZ/TbBgwFT+MzEw0b0yRfnm73tH5A099i+WU36HduhW6koW0jmHjOK0+neQ0KKx7gxiF/r9qenozUKoA14yDWtSTW1a80NyfVDAkKIrLkIJHaM0FpQX+s9UoELDnhm3Of2uIHzVvr6Q07XstpUUUQXiupZJjGe+6ltCA6sylVD8zWqDMVi9NP2PpaOwfCeLmw0Z1FXfrWcsGvT9zk0s17AkBHrjvlkW1t1F/98AW66/svcDdy3fgLTwOkEsZX6XfFDP3F+pMoB3tboQBMRB1T/qdfpPXsuXDxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyFTXGwuZo9hDFFyky8tmT4x7bMZHraMVEtQW7UhiFw=;
 b=TjxcReftT1pq8ZghXWkgREuTyzas31lVv2vzbALS2mcQOzwvN7um/Cbs5qbzelEenSTkrzyNdx/tnZhsxrEa70mP6HsIEbDkJriDu2PLif/z89yOqAbq3khGCehH0tLxoTuM4d3H//jTmu7UaBCeK9AlpvJ5OsYgx8M+QwthO5PDNh81IIvsD6ohZd/RXUejy6UQngxou3OWFw2Sd7aJ3i97vNNcf6LjsuepFpGP1ROqk0TE0y81gZ3JvNBvtDlZmRf42VjEwERrFhaSu9KoLQC+zr98ydMEj934wC9Z65/r1Vp276Z+w1YZ4lOQkvBhuJk+HrinGNfP6teorN+gpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyFTXGwuZo9hDFFyky8tmT4x7bMZHraMVEtQW7UhiFw=;
 b=l3XeZal1b59z85WrtkKa7P3dTLi3T+Ht7alCRstrtvLIGu3N4YXdEcP/g/W/0ieaZ9HABUfQws8OAQghzk/ZkQFulNclmrd3a9kpM1cXYu2oTp5Vh/aWWNa4YJtQ2EHZYjfuX1n/9r9uTLJRy/tfG0I5tsdy6eWeEtvcxx+Vit1sIXXUxrssdKaIOkbHGNa/oY4G2tjhT1vpdG4rbRJosKvA2o3X+tljTuCa1fZlUlYhkgIa7W5tT4EKV4Frj/80+f3DFzEi2355sBIoy4ro2FOV2qPlw/RPF/rur1KK2uQuHsU2+3ckIuSQ0J3aDfAPku99H0iVXwMay/THD/RqsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB8850.eurprd04.prod.outlook.com (2603:10a6:20b:42d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 23:53:46 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 23:53:46 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 01 Sep 2025 18:48:00 +0800
Subject: [PATCH v1 1/8] imx9: Add i.MX94 CPU type and SoC-level Kconfig
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-imx94-v1-1-c85ae7cdd95c@oss.nxp.com>
References: <20250901-imx94-v1-0-c85ae7cdd95c@oss.nxp.com>
In-Reply-To: <20250901-imx94-v1-0-c85ae7cdd95c@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@oss.nxp.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: MAXP287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::18) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: f759fe65-3321-4ca0-a024-08ddf0c547fd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkVMS3NienRTamJSR3RsNmlYS2hkM1dGbndoMjUxWldFck9BS0hRWHhGQWIy?=
 =?utf-8?B?VHBKOG96ZGYvMjhYVFh1TTlSQ2VKRUpJTTVGZEVwME03Wk84Z29TOXdUSDc1?=
 =?utf-8?B?bzZJa0ozbEdpUkd0anhNOXFWazY5c1dSRTFZak9QVnpiTlJuZGNZSXkrWHdV?=
 =?utf-8?B?cU5aYVo3aGY4bEF0aTk1R0RLODIzQVNZSVBNOFJFVEpSbkU5dTBhU3BHbW4v?=
 =?utf-8?B?Ty8yS2ZZTWlHOTBSdXltYWMwYUZUeFRneERpSUJQQ2tLVWZGbWRBUTRxZEto?=
 =?utf-8?B?QUxROVJNcUJiSEk4OHhBNU1JalR4NlhvVURDSVhkZlRtOUYyMDA0WC9RTE8z?=
 =?utf-8?B?dzRsWCtqUUNMaTgvajFrRlE5Y1o4clJtaHNFMThqT3pML1pwNktTNkF0dWJ0?=
 =?utf-8?B?MjhVcklpNmFmT3ljd3VqZVRXc3hSNDFIKzFsS0hjejZnQTVRNlgyUVlZOU51?=
 =?utf-8?B?R3IrcFR1cnhkOTdYeS9sOTNiUXdjMUNWMVZlbEFzaEkxUmVlWWtpcUFvdXRI?=
 =?utf-8?B?eWJ4VzlQcTdnTHYwbEJRZ1hOMEpZc2E2aitTaGl4ejBkR0JtVGQwdWFycFF0?=
 =?utf-8?B?TEZaVFFoTU5IS3p5YXpLbzJzaWc2S0dqOHpldlVsb3U0OWU1L1VFQzg5K1Zv?=
 =?utf-8?B?U1UwTmovWW9vZXdhekNISGNPR3IyV1pHbjNjUU1oNXY5NWkra0VmS1ZaUWZq?=
 =?utf-8?B?Wi80Y3E4dEhQTEltZEtjeUc5ZUZGYUN2Q3dGM2wyQUgxRTBVdG5kQnk0bytO?=
 =?utf-8?B?QWxnVTd6WHQ5NGpYTUV2S1NBT0liSExEeDZLQy8rUHA5M3lCRHJsSGoyRXIw?=
 =?utf-8?B?QW1sMnpPWjNwRFluK1ZlVXlNRUVTMWYxaXhRcUpxQ3UvaytUNGZjSnMxdGFF?=
 =?utf-8?B?YlNXbXNMZFBPRVU3ZnVsUUJ5Y2hVWVNSTXVSMWpjaVByU2s5VGZUUndUZmVR?=
 =?utf-8?B?aVdZRHhlTUg3TlN2MUovcWtVdC9YS3FLb3FPQUxEV2pUOEExWElIVVNpc3hF?=
 =?utf-8?B?d0p0L2plRXlMVmhHck5hZ0pVK1VuMnlDM01RbEV5M3k4cWFzWm9HV21mMzBS?=
 =?utf-8?B?ZHFUdmdHai9YREZ6cDc4bDZRVlZjZ2pOVUI0SWNOenlqNDl5Y1kreXFwS3Jt?=
 =?utf-8?B?MldhQ2VUKzhLeElreGVpNHJGYUdteWdaMFIySUNxZnA1RlFQQUNJY3hWRVBV?=
 =?utf-8?B?M3RkdmlmVjMxMnlyckJUUlhjdkNjaGxmL1RRSm9NVTdGR2V1UUJNVGhpQ09U?=
 =?utf-8?B?ZEE0aHlhQWFBVFV2US8wOUV6bHQrUEVDcktNVEJsMDNBOGlhRFpvd0pVRE52?=
 =?utf-8?B?UlozOE9WVTJGN3hlTXpWbUdpVW1za3ptd2gvMHNtaUwrSVFIMWlaM1JDZUN6?=
 =?utf-8?B?OS9Pei8zcEdmemZGTm9EbUJ6SDVTUzRVMXpnZkN0bEl3R09PWUY2cnNFL3ls?=
 =?utf-8?B?VHkzQ0hrVysvdmNXNHZ4UmgvUURGTlIrSEpPbEttZXNxYlYzcjNrYkMzNUJa?=
 =?utf-8?B?NW9oL1FGWHdqNDVZUW9mNGpSZVRZRVpQWnFERUVjaHJDOTJEMzNvcmgwZmRk?=
 =?utf-8?B?Wm54Y09ITmZSdU5RZ0VpaUhYdWxzQ3ZzT0haRDVoRWl2S0cyNi9SNktSSzlV?=
 =?utf-8?B?RzVieEZxb0VNTUZiUk9mSW5VRjBadWpGUnZQc3JwdENJMjlEd0MvazJEb05a?=
 =?utf-8?B?R1FsZStjNTdMcjNiMlcxVk5rOStPQ0NzaWczTW1lMGZwYmRTUDZ1UDZIUXQ1?=
 =?utf-8?B?MDlnK0ljU2VHM0VkM09ZUUgrOG1DbXJ6TnRsaHJERnI4V2Y4YjR1QjNKaGRK?=
 =?utf-8?B?L1NJUnlYMWdWeHYzcENKdm16d2tkZ3NiQ1o1bFdLYmREV1pOc0pTZ0N4QWVO?=
 =?utf-8?B?Y29CRklybXNhYzUxd1Jkbjg0Zm5Bd3VZTDU0S2Z5dnR1NnhqcXJCSVRKQmVO?=
 =?utf-8?B?Znd0MVE2akV0T0NtakRQS2l3ZG1EdHBnVDVDTE5kS1BZNmtpeXdGcFZjWnNp?=
 =?utf-8?Q?vs1Ysw9yIs60wSMYsc4dElcYn9gmHQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXRLV1VCbXRueWhjbTgrSkptblBHSDhHRDZpWmEyNTBCeEJWem1FRTBRaE1C?=
 =?utf-8?B?ZWhSVmlnMkVZSHdORW1LVURnV2JDT040MDg4NlE4am4yUUVSVjBucTZCNGRZ?=
 =?utf-8?B?SnZ5YW5UUUpnQ0NMUjBiSVdZc2YwcGI4eDdxSXN3b09HZmZMMG1wRy9TVXcw?=
 =?utf-8?B?eC80OGEvdmtocTBaajhqdjMvRUV6MG82K3IxZG1QOFQvUEM4N0IvLzdkcklS?=
 =?utf-8?B?dW9lNmN4OFdsbmxJamtiVHNaS2dZSFhkbjkxQW1TbW1ubEd5bGdNdUlZam1q?=
 =?utf-8?B?VWg2eDZrRnlRNTg3cU5HWTlWVjVzb0dGK1M4bEJMdUpWaURjdHlvNVlJcTYy?=
 =?utf-8?B?Uzl6dkQ3eXFWSG1OOGJrZEtxRFo1WHJuQWZud0lFWWxWKzdyandWZzBuR2tj?=
 =?utf-8?B?RnkyOTJWTEtFSCsvQmRwT2tOMWVhdlI0Szk5NFc4QXZ2WVY3cjBHWjhQdGJu?=
 =?utf-8?B?dm1NRFJpRkFGUUVJTUlrd3NNL2JEa1FWWTZEeERaWk5oYVBSUTdySHBuZjg1?=
 =?utf-8?B?N3FubUFZOUpiU2o0cEVDNDYxcXJDdE4zTXpjSlFydC9OUkw1eCtoNGRTZENF?=
 =?utf-8?B?L2JzaVBaTFQ5akQ4Qm1vZFlFbjdQNVZIU1RvZjYxVTIrWEUzLzRCQS9ZaWZT?=
 =?utf-8?B?dk1NQkxHbDRabWdkOFZxQjh0MGlFU2krenRFTlgyZHdOYjM3MFJ3c2dqZnlt?=
 =?utf-8?B?MVpMN1Y0QVZQaWorQzRzZERKY3phZWg2NFJJcko5Zlppa2dqckNZWllxU2Rt?=
 =?utf-8?B?ZWFwU1FTT2ZjVDlkY3VXV1habUVqM0RqemRsemtnQTVUeUVqcy9uL0ZMMVd6?=
 =?utf-8?B?c2hIQURkTm1LaHluekk0V2xmNHZHZHJhMjEzMHkvTml1blhOSUtqdUNyNDRm?=
 =?utf-8?B?TGFBTSsyeDE2RUNNSDM3YXU5bGw3YjJpamNNM2lnTExpdENlMS9ac1Mrb3hD?=
 =?utf-8?B?M0JST0xLNlFJVmJuL3VkYVdaRE1HKy9Xc0piVlhjWHlQZUhGU0s0MzVxTWNW?=
 =?utf-8?B?N1Z5am1vV01HYmpaL0Q4a09nZzNVZG5KOHVGRm4xb2ZKbDJQNmdWZ3RVL28x?=
 =?utf-8?B?M090U3U1RlZPRzNvVFdHZG90dmlvM0xDTzZGQjBqclFkRUZ4S1BFNWNDOXdk?=
 =?utf-8?B?R2xqdCtjTnROMmV2eVhCMTlYdlpkdkJoODA2Nm5POW12a0ZJb253bjlvSlF4?=
 =?utf-8?B?cGw0NmwxazNLbVVONTVqVEk2UUFQb2JvYWxYcmdodlFKaDBOQlVGTmo3OE9s?=
 =?utf-8?B?ZmtRT2VCVXUvZDFsaDlEaHFFa2xJT3pCZlhxaVpkOC9Ta0xRVXh2OXpNYkZ3?=
 =?utf-8?B?bmoyQllZTjF0NlJtbEx6eU8yZkFiY1VEb2VLQStpZ0xVTXF4eGxVVWYrRUli?=
 =?utf-8?B?d3NvelR1WCs1T2RsMElTZEpDdlM2UzROK1VhVmppV3UyMWlMVklCdklreEJY?=
 =?utf-8?B?ZXFDeGQ5dUl0cjVIcGFFUUJ1NFdpZHE4U2xjWm1hVC9mczRLSmtkL0wxSy94?=
 =?utf-8?B?TkZWS3A2a1hrQXo3WVVyZUpWT3VCZi9ham50R2xqRWRza280aXNOb3Y3alhF?=
 =?utf-8?B?WTBlUWx3WEZDQUlkeWFKR1VEWkJFcHFxakliVnh6WnRib2Q2NDJESENWMkk4?=
 =?utf-8?B?aWk2VGxlaTdGcnVId2Fzbk1aUGJJQmNqTU4xNFRYdmJZM3ZrNlZ0ck5pR2lM?=
 =?utf-8?B?QnlYNFJIeThoZmF2VE11Qk0zbWFVWjlSblVqbmFnb0RoTEhFYnhBbElCcVBJ?=
 =?utf-8?B?M2JBMGg2SUQ5V1VNL2V2Yk1mYnZHMW85aHdXTzJkanRSaWUxbGZzK25mcGRq?=
 =?utf-8?B?UXNSbVVJcVJsWUllakJoS2Y3bzdVdnp3UjNVWVZYVmlsdElBWU5HYm9rbkVt?=
 =?utf-8?B?c2wxM2pPeFdyc2xNVFdDY3QvNDJPZDZhTDd1N0FSdFU1MU9YMWlFNkU3TFE0?=
 =?utf-8?B?N0RJZVRuVXdEUUpuajNvNW5hWGFyY0ltVWJRTlk3VC9SRzk5c2IzblllVVFO?=
 =?utf-8?B?NEg3a1l1NUFGbDRtdS90TnhWeG4xd1hwQm9HaWdDRXJLQVBIZVNyangwV0cv?=
 =?utf-8?B?L2x2QXlpeW5HNDA3MUdZemt0d0h3K25SVmFUM3h1YkZEZzBDZDZpQ3Y0QUN5?=
 =?utf-8?Q?YMc8GeBBjIqfKvEOBLoGWMo4L?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f759fe65-3321-4ca0-a024-08ddf0c547fd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 23:53:46.5256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UAgxrHC31G2ZzXis53pIsOdOhgeLk935Y+7ZVPkKirW1ZtDJnHHkwWDBjNIRuUIpP22BvS4WtJP4tDi5uEQmMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8850
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

Introduce support for the new i.MX94 processor, including its CPU type
and SoC-level Kconfig entry.

The i.MX94 is a new member of the i.MX9 family. It uses a System Manager
to handle system-level functions such as power, clock, sensor and pin
control. The System Manager runs on a Cortex-M processor, while the
Cortex-A processor communicates with it via the ARM SCMI protocol and a
messaging unit.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
---
 arch/arm/include/asm/arch-imx/cpu.h       | 2 ++
 arch/arm/include/asm/mach-imx/sys_proto.h | 1 +
 arch/arm/mach-imx/imx9/Kconfig            | 9 +++++++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm/include/asm/arch-imx/cpu.h b/arch/arm/include/asm/arch-imx/cpu.h
index 1f669c72d00..1af9778f8ce 100644
--- a/arch/arm/include/asm/arch-imx/cpu.h
+++ b/arch/arm/include/asm/arch-imx/cpu.h
@@ -78,6 +78,8 @@
 
 #define MXC_CPU_IMX95		0x1C1 /* dummy ID */
 
+#define MXC_CPU_IMX94		0x1C2 /* dummy ID */
+
 #define MXC_SOC_MX6		0x60
 #define MXC_SOC_MX7		0x70
 #define MXC_SOC_IMX8M		0x80
diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index 0780f99b49a..46da7a1eff5 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -97,6 +97,7 @@ struct bd_info;
 #define is_imx9302() (is_cpu_type(MXC_CPU_IMX9302))
 #define is_imx9301() (is_cpu_type(MXC_CPU_IMX9301))
 
+#define is_imx94() (is_cpu_type(MXC_CPU_IMX94))
 #define is_imx95() (is_cpu_type(MXC_CPU_IMX95))
 
 #define is_imx9121() (is_cpu_type(MXC_CPU_IMX9121))
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 4e0e194690b..13f2c2de305 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -35,6 +35,15 @@ config IMX95
 	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
 	select IMX_PQC_SUPPORT
 
+config IMX94
+	bool
+	select ARMV8_SPL_EXCEPTION_VECTORS
+	select DM_MAILBOX
+	select IMX9
+	select IMX_PQC_SUPPORT
+	select SCMI_FIRMWARE
+	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
+
 config SYS_SOC
 	default "imx9"
 

-- 
2.43.0

