Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613DCC87FCC
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 02:15:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AE4D830EA;
	Mon, 28 Jul 2025 04:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RgLm3iSt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8458F82F14; Mon, 28 Jul 2025 04:14:53 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 505BE8315B
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 04:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtIPocy7M5B/qtCfhnHlWRlQaVisDCQJ4WI+kPJpPNhPxT7zWjZrk/Ttm6ukqj1AX/XaGjQSCodpQkCNB1LxqivNawjs3Pco6IDoOpqFSh9GCH0VaXymk0pVExNkIr0MW3d9c2//NMamFfVjw0w80csLMq17jULhnIIjGYhBOV09sDkAXAQe/nU7M6qVl0no8nwmRIK9259/iALvbSZBzZjVV1pWFZ1vRSouZN1mbxaMegiyqjTQ/j8Ti7v5ENRf8ei0KD7V8Jk2DGPNP+2382XnA6+vrS3UqgSOcctOpiBybr54X5ijgwwcyHR2FOZJ3ydQLU3P0T8qPDhKL/LZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxSnCjW7RQDOgoX77nnT810Q9u8pQj14gTVfqBaaZPw=;
 b=cHmi0yyd07zpmktiqd2oojyo9FogI9f8n/U2yLdNjlkCT2mK6IWTvo2GrPpq+mJpfAWj72lRZ5Q+se/QhLYC/bWqm7xTEWnKkzFc3r/JI3soqPBXLM0Mot8wNSGc6IG8b9NHzHVIJeK39R7E7zKNLyFsTdLqzgvRF6FgvMT0pfG8B8MHgSguuHpdeFsiOYd+uM7QT4YnvSpgiPTEsj6XxJErYNjiYZ1L+TXdS6CXmV82eK/Y08ke2fr+AWkeMyW2a6hg2J9pneulxkF4lqEqSuNYNNHyIte9M2n1BZ2uYFLCcf2V/jazXf3iY2GQUn/aJImsg799dLoo0KGxyS8Qgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxSnCjW7RQDOgoX77nnT810Q9u8pQj14gTVfqBaaZPw=;
 b=RgLm3iStc6VeGul3HEQlkZIno+0+6S9wABKa3OeFkuyh9EvLC91flfg+4egJwzIl9amm0J+xU0blSZFPhwZxh/gqd3aASBA/9cKoMz2/Jd+gm2MvITp5ZG464Q2htoFxqKjBNvcMnyHFWb8u17jL60z6FK+Ver+19sk1JpeGZMn2ipG/e2znV27gmxeiP9IIvZEYS/aNfoUUK+fQqBFqRtEAD7lyA/SX+M2pdIM6vZDvXsaSYBq6jalzlgAlkEBAuUcwAMo49hX77aKZI2ceSHhkis4g8v5EkmO6XneQMG7bR3M9sLtJkDw2j4QCIKFgNQHEKZ1Z6ptm8tyfXRljUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8546.eurprd04.prod.outlook.com (2603:10a6:20b:421::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 02:14:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 02:14:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 28 Jul 2025 11:24:54 +0800
Subject: [PATCH 8/9] ddr: imx9: Implement Synopsys LPDDR PHY QuickBoot flow
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-ddr-imx-v1-8-73da75bb33d3@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5fbfb24a-65c4-4384-d267-08ddcd7c8811
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STFlNlppSU1BR0VIcmg2Tk9CNUxKVE1zNnl6SFJPaTJlZnNyQ1QvUXFwY1RM?=
 =?utf-8?B?N2M4ME5VM3BGZEx3ajJhblMxQi9UeDNVdnBhcUdtbkZEUjE0S2tnYzUzWCtH?=
 =?utf-8?B?V2lGUHBtODMwK2ZTQWxCTjIvd1BFWm1EZXNHMlJWSXdTS3pXNm1wdU5HcWxW?=
 =?utf-8?B?Vk5JRldjeDBUam0yTXVralNYVGVNaUdobzRLczJaYVdDT0RhSjVmeVdJcmZa?=
 =?utf-8?B?OHM0VGJjb01LTUJtWjczRDJnVHlDWkEvekMvUGU1ZmNlbTRNZVZKSUNTTHdV?=
 =?utf-8?B?VytHTVRYTkgwekJiM2lCMlFxSnI0VDRjY3dJTXlGQjVsdi85ZVpCVzBhcG05?=
 =?utf-8?B?bitSVXNJNHRlUlVPUXpQOE0wUEt1L0ltZEdtVTlFaDY0SDh2VVptNUR0MENQ?=
 =?utf-8?B?c0RqMXBaRjBkLytPc0k2N2Zva1c4NVh4SFF5b25mODJyNktBTUxKMzFYeUZK?=
 =?utf-8?B?YmRMVGtJaHlONGFVdmI2OWtBMW03S3J2QzBqM3ZxSzQrVkdmbTY4V2YyUjRH?=
 =?utf-8?B?Q3ZqRzl5cVkzaDlVM3FvMHJQcjN1YXZVWkdZU00yTGRqalhwVjZEYkJTVEN2?=
 =?utf-8?B?ZnBXbzJTMVFyVmpXdVN3bUNSS2RpOXRmNXFUbVMxSVFja3JNbGd3djBxT2hy?=
 =?utf-8?B?NHdDemx5T2oxZmVycHJSZ29ENkppSnpiZ3FMV1dKWXhYeFVGbDFZZjlDNjhU?=
 =?utf-8?B?cHBTWVZQTE9iZWNsNXd3OEhaWXJnL21ZK3FJZzVNd2Z3R1R5aHhGZ1ZtT0pn?=
 =?utf-8?B?bCt4QWVtRmQxQWpjSlNuQ3gxOU9ldnBQdFdFSG11cDdWU0pldzNWT01EcS9i?=
 =?utf-8?B?SFRpT2tpTmxpdURYdEFHUFN2RGlBSklWLzJYdW5SNWtFcTBKTi8zUi9ZSC9O?=
 =?utf-8?B?ZTJKTjJzdG9ScWJVNVIzdWdwUXFiWWxBVERlMXRUeGJ6UzBadXBYVlhPdUpi?=
 =?utf-8?B?UGYweDlKNzJiTEFYV2JpSkplck00M2RLUndLOUwwWGE0Y08zckZTMURqQXVs?=
 =?utf-8?B?bVo1Q1dZQlp6SE1EVXhvdUhRSDM0bnNtbFZGYzNWSWZPaExjTU1nblhONVBR?=
 =?utf-8?B?OExSZlZTOXpvMldTTFdsMEZLUkVHdm5RcFpSSUoveDVDckNkWnZ0cE5LeXZo?=
 =?utf-8?B?QmxIU2craFV3aU9yYVV5eXpEZkkzZHkzMFY5d0NIQldhMCtya1V2OGlkN3F4?=
 =?utf-8?B?ZWNtWGVZZVVjWGl1R1ZvZTdWYkpXb01IWGNLVzh4QWNXR1JxRXpoNURaTXRx?=
 =?utf-8?B?Vk91L2RCSk9zTWFpTzNPbDZ0RkNYdi9ETCszdTNwNTNsQ3Zib1E2V2hRcXRW?=
 =?utf-8?B?R1VxTzZEajF5UVdaNEVIZXFRdWlzVjdGNjJLcXE2cVgwakRFaHRkVjdXaFM1?=
 =?utf-8?B?SkFLVUlyV0J2Y2ZLR2pnb3BNeE5Jb2lGeDJZaXZpd2FvdU5uTWF5MFFZMWZQ?=
 =?utf-8?B?SlRXdHQwSVp4L2JWUXBDSWRPamh3UGUyWWxaWlFEV3dVWWZTVmVuWU9tVVVo?=
 =?utf-8?B?dkNaQzEwc0VhN2hGVXRKbHJtTHdzVzFZemsrbm9ZY0J6OEN5VUtaSzdsV2Jr?=
 =?utf-8?B?cGhtNDQ2ZU44eFYzcXNocE1NTWRWL3NOVmNlbHczSGUrK0pjaW0wSDQ2YUw3?=
 =?utf-8?B?b3A2b0tmTnhUOEI4c2Z1cDZMRzBVcWYxa0h5cVlZZk9IOGVkUXpvYXpVbSsy?=
 =?utf-8?B?Qk9kUCtqT0JwamEzMEdORTlRbXlZSHVjZ1ZXcXZjL3FKV3YxMEx3VTYxUkFJ?=
 =?utf-8?B?UFdINXNIeWN5aXU0bXRIQWlSc3psSDZ3bWJEc2RnK2t3b0tFekQ3eUMzWWVV?=
 =?utf-8?B?VGtDekJBc0Y0WWxTV0pHd0EwdDhqYmdDWlU1OFZJQ21nK0d6cDFLSEVLWnJk?=
 =?utf-8?B?QUMvK0crK3h1TW5zTSttSzR3RVRna1pLMFBFVzRCOXowVmg4c3ExNTFmZDJz?=
 =?utf-8?B?L1NxRXJPN09SY1g1K1NjOEo0ZUI1b1VJc2ZDTnd2SFRCOUU1WVRydFRPZUFR?=
 =?utf-8?B?SWtHcnZoaTJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWlxb2tpUnZpdWY1YlBGVWxEdktzaUQ3Q0lBM0dLckMwNEZjQmZvT3ZjWmhS?=
 =?utf-8?B?a295L3BJa21FY2d2L1ErY0NMRU9aaUgvYStocmQwa1VyVTFVbzdqelpxR2R2?=
 =?utf-8?B?THlldmtkeVIzOURTL0hLQ05JZHY5eG15YitaOE4wT0tud0RrU1R5RDZINHFQ?=
 =?utf-8?B?TEJSNjEwTXBmZ2V1eUt5eDRYOGozY25SZ1dtM2doUVdoQ1UxTmUzYzlPMzcx?=
 =?utf-8?B?N2hINHBGdTY4czhRK2NwbVJxUWhhdTBzeWZzSjdzak93bDVUUmFwZ1dMUW4v?=
 =?utf-8?B?UFlIc2p3clF3WGpnV1ZmaEZUOTlzaGpwOTgxSkRvcWZGNEJ6L3hCNDB0Qy9S?=
 =?utf-8?B?d0tKTTJqcndLVWdEZDNqRzhjSWxFUzZpN29NcE14eFhYWlIwMzNvOFVjUmdy?=
 =?utf-8?B?elFybEY2YjVCNmpvQ1BWWVJLZkNQS1FENUprUlRpbnJkMXhOa1d0czd4R2dZ?=
 =?utf-8?B?MGltelBZcFJtaFk3cUkrMWtvcEZReFlqcWxTM1ZoUDkvdkp1Rm9oQXh6anRv?=
 =?utf-8?B?dXNIYWZ6b1hFNHpCSmdCa0JZK2lpaDV1dDgrMG5SS1h4bGMrN1lVRXNTKzVN?=
 =?utf-8?B?dHF4dW9HQ1doTEhvdlNSd1pKMVJhZlRrcGtPcXNiRjFlaENpNW1oZ1hHUTBB?=
 =?utf-8?B?ZkNhNDBuWENORUpOclFwWWdpVHJtMkpOZzM5UEhrMGo3bm4wQ0xjWkRlMkxL?=
 =?utf-8?B?dENhd0tNQ1kvdHBGTHI5cThpUS9BRjVqSy8yZVd4RGl0WU0va0ttZnRpN0JY?=
 =?utf-8?B?TnZkVExydW9FQkM3U2psUm1KZXF5a0YxVTVObDBER0FaSGpkMG5VNGQ5T29Q?=
 =?utf-8?B?MWhIVEZTcUd4bjZSM3NwdHhSNmZxUWt5RnIwMGZNbnpmdjc0SWIwR1hrUWpM?=
 =?utf-8?B?eUFNOXFDWUNOdWtVdzlySTV1eDNwUWVleDhTc0Y2T2pTYWtQSHhvTEQ0YVBu?=
 =?utf-8?B?N3FHNVpQc2dINEZ0cHdaOGZ4L3hnOHIrVnBSdjMvWUtnbXFZM2pEdUF6R0tU?=
 =?utf-8?B?azY2REl4RzlzRnE5SUk2WktvMmhTUUtLSUloYkNDbnVFTGU3OGEyQmptT2t2?=
 =?utf-8?B?b2h6Y2lSNDc5YmhaNktJMEhaWkNVM0dMbkRqZWZoWHpEUGd5bkFJSTV1UEQy?=
 =?utf-8?B?SHM5bjFKN0s3andKRWRpN0lnM3N5Z2FQQnovNjBTY3RmZlU0R0tZNkJaTnpo?=
 =?utf-8?B?Zzd0eVlBbVVEUmQxOFc0RkFXRER0V29EemY0K3ZhYUlqajlpRFNNbk4xUnNW?=
 =?utf-8?B?Z0U0VDV5bThSZitZeHR0ejRsZHY0U3VhNGdvdFVHOFhHbEdabHdmY3o3d05L?=
 =?utf-8?B?a1B2dGkvRmZUY1Q3TUVmS2V0aE5wTlFHeGlrRnFnVlIrUWtTU05KOW9OMXgx?=
 =?utf-8?B?U2R0S0lkbUJvRW1aZkh5cGRoVkNQVFhpUlh4d3JIUHFRRlZFQVBrRTZtajlo?=
 =?utf-8?B?S1B5Yk5Zd3NLY2R5YXh4bnRqM1czNVJaRU9VRFVHUVZleFF4Q2dXai9wWTUr?=
 =?utf-8?B?c29pQURadjRqRFBsakJjeTMwNlh4TUd5NXluSGJ4NENHUjBTZnJxSXJ4dVJk?=
 =?utf-8?B?QXFmd0VnQ2xkWDFWb1RMMk9FSkVyNnJDZkxxbUdUQStDYkVoY2xCZkRITUtT?=
 =?utf-8?B?dmdqQVk2eFo5Z1BkT2tSUURhRkRETTJTV0wvY281Q0txUmEvYXAxWGlkSUEr?=
 =?utf-8?B?cEcwc1I1NFh5djFRb1VQdEt5K1I3OUQ3bDFHVFA5am9zUEllbXRBU0xnSE9t?=
 =?utf-8?B?L0M2NFRBdDlQRExvOUJhVG5lbktmbDJqTFFDTlBiN21qdVR2SkNuVHpJUXdL?=
 =?utf-8?B?TUZyWlBVV0pvcTBKaEkrK3V0Mm42Z1B0THJrNWhBWkhYN2M4aWNKQTZhbGhN?=
 =?utf-8?B?T0xqRWtZc2YvZWVJY0kwODJNbEtrald6Y2FEWGhMU29CejVOVjRacUtMMVpQ?=
 =?utf-8?B?U0pEVzB3R25NNXdhSE54NFZrTnU0SnVreWZ3c0NTQ0tQY3J6UWlhczZ2bjYw?=
 =?utf-8?B?RDRsT0NSWERGeHpObUp4M0VmZzdQUkJQQlRmazhTRkNBc1I4Umx4U1FsbXgw?=
 =?utf-8?B?Z2NnTFJmSWZ5ZGhiQ3Nyb2twcE95SmVRWWI2T0doTExpeUFLQUNLV0t0b2h1?=
 =?utf-8?Q?98x0E+vkuD77qi4FOx4fdJb6P?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbfb24a-65c4-4384-d267-08ddcd7c8811
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 02:14:49.9939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LmUna3wx5Hs5GLlnUb3IU+Hm24NDy03XuBlSE1FMOm1bb9SK2IULckJ5ygFdFfHOk/YPYpcQuvtobo2f4wDvpA==
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

Implement Synopsys LPDDR PHY QuickBoot flow.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx9/ddr.h |   7 ++-
 drivers/ddr/imx/imx9/ddr_init.c      |   9 +++-
 drivers/ddr/imx/phy/Kconfig          |   6 +++
 drivers/ddr/imx/phy/Makefile         |   1 +
 drivers/ddr/imx/phy/ddrphy_qb.c      | 100 +++++++++++++++++++++++++++++++++++
 drivers/ddr/imx/phy/helper.c         |  39 +++++++++++++-
 6 files changed, 158 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx9/ddr.h b/arch/arm/include/asm/arch-imx9/ddr.h
index 4c092509111c66c09cd006711131db107dbf17e3..6e5a3e3b6793d0171c2fbe6415821968ac1d3ba4 100644
--- a/arch/arm/include/asm/arch-imx9/ddr.h
+++ b/arch/arm/include/asm/arch-imx9/ddr.h
@@ -101,7 +101,7 @@ struct dram_timing_info {
 
 extern struct dram_timing_info dram_timing;
 
-#if defined(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN)
+#if (defined(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN) || defined(CONFIG_IMX_SNPS_DDR_PHY_QB))
 #define DDRPHY_QB_FSP_SIZE	3
 #define DDRPHY_QB_CSR_SIZE	1792
 #define DDRPHY_QB_FLAG_2D	BIT(0)	/* =1 if First boot used 2D training, =0 otherwise */
@@ -118,8 +118,13 @@ struct ddrphy_qb_state {
 
 extern struct ddrphy_qb_state qb_state;
 
+#if defined(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN)
 int ddrphy_qb_save(void);
 #endif
+#if defined(CONFIG_IMX_SNPS_DDR_PHY_QB)
+int ddr_cfg_phy_qb(struct dram_timing_info *timing_info, int fsp_id);
+#endif
+#endif
 
 void ddr_load_train_firmware(enum fw_type type);
 int ddr_init(struct dram_timing_info *timing_info);
diff --git a/drivers/ddr/imx/imx9/ddr_init.c b/drivers/ddr/imx/imx9/ddr_init.c
index 758a4049139228198a86449bdf2f9106c0773040..7d40e199ad9900c51c689c530999dd83dc983144 100644
--- a/drivers/ddr/imx/imx9/ddr_init.c
+++ b/drivers/ddr/imx/imx9/ddr_init.c
@@ -375,6 +375,12 @@ int ddr_init(struct dram_timing_info *dram_timing)
 	/* default to the frequency point 0 clock */
 	ddrphy_init_set_dfi_clk(initial_drate);
 
+#if defined(CONFIG_IMX_SNPS_DDR_PHY_QB)
+	/* Configure PHY in QuickBoot mode */
+	ret = ddr_cfg_phy_qb(dram_timing, 0);
+	if (ret)
+		return ret;
+#else
 	/*
 	 * Start PHY initialization and training by
 	 * accessing relevant PUB registers
@@ -391,6 +397,7 @@ int ddr_init(struct dram_timing_info *dram_timing)
 
 #if defined(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN)
 	ddrphy_qb_save();
+#endif
 #endif
 	/* save the ddr PHY trained CSR in memory for low power use */
 	ddrphy_trained_csr_save(dram_timing->ddrphy_trained_csr,
@@ -400,7 +407,7 @@ int ddr_init(struct dram_timing_info *dram_timing)
 
 	update_umctl2_rank_space_setting(dram_timing, dram_timing->fsp_msg_num - 1);
 
-	/* rogram the ddrc registers */
+	/* program the ddrc registers */
 	debug("DDRINFO: ddrc config start\n");
 	ddrc_config(dram_timing);
 	debug("DDRINFO: ddrc config done\n");
diff --git a/drivers/ddr/imx/phy/Kconfig b/drivers/ddr/imx/phy/Kconfig
index 28a9eca0788f96355e8459427a92832446be0e02..b0554172af3654da50d8ed929c382ef54506464b 100644
--- a/drivers/ddr/imx/phy/Kconfig
+++ b/drivers/ddr/imx/phy/Kconfig
@@ -8,3 +8,9 @@ config IMX_SNPS_DDR_PHY_QB_GEN
 	depends on IMX_SNPS_DDR_PHY
 	help
 	  Select the DDR PHY training data generation for QuickBoot support on i.MX9 SOC.
+
+config IMX_SNPS_DDR_PHY_QB
+	bool "i.MX Synopsys DDR PHY QuickBoot mode"
+	depends on IMX_SNPS_DDR_PHY && !IMX_SNPS_DDR_PHY_QB_GEN
+	help
+	  Select the DDR PHY QuickBoot mode on i.MX9 SOC.
diff --git a/drivers/ddr/imx/phy/Makefile b/drivers/ddr/imx/phy/Makefile
index d82842759e72d104aba41110b9c6e01b997d78fb..2310e69ab5c3036a2903465f4c4e95a79bf0b2c5 100644
--- a/drivers/ddr/imx/phy/Makefile
+++ b/drivers/ddr/imx/phy/Makefile
@@ -7,4 +7,5 @@
 ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_IMX_SNPS_DDR_PHY) += helper.o ddrphy_utils.o ddrphy_train.o
 obj-$(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN) += ddrphy_qb_gen.o
+obj-$(CONFIG_IMX_SNPS_DDR_PHY_QB) += ddrphy_qb.o
 endif
diff --git a/drivers/ddr/imx/phy/ddrphy_qb.c b/drivers/ddr/imx/phy/ddrphy_qb.c
new file mode 100644
index 0000000000000000000000000000000000000000..04a6520be5464ac26e30a516265b1b6993eec38c
--- /dev/null
+++ b/drivers/ddr/imx/phy/ddrphy_qb.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/arch/ddr.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+struct ddrphy_qb_state qb_state;
+
+static void ddrphy_w(u32 addr, u32 offset, u32 value)
+{
+	u32 val = dwc_ddrphy_apb_rd(addr);
+	bool hight = (offset % 2);
+
+	val &= (hight ? 0x00FF : 0xFF00);
+	val |= value << (hight ? 8 : 0);
+
+	dwc_ddrphy_apb_wr(addr, val);
+}
+
+static int ddrphy_qb_restore(struct dram_timing_info *info, int fsp_id)
+{
+	int i;
+	u32 to_addr;
+	struct dram_fsp_msg *fsp_msg;
+	struct dram_cfg_param *dram_cfg;
+
+	fsp_msg = &info->fsp_msg[fsp_id];
+	for (i = 0; i < fsp_msg->fsp_cfg_num; i++) {
+		dram_cfg = &fsp_msg->fsp_cfg[i];
+		dwc_ddrphy_apb_wr(dram_cfg->reg, dram_cfg->val);
+	}
+
+	/* enable the ddrphy apb */
+	dwc_ddrphy_apb_wr(0xd0000, 0x00);
+	dwc_ddrphy_apb_wr(0x54008, 0x01); /* SequenceCtrl = 0x1 (DevInit Only)*/
+	ddrphy_w(0x5400c, 0x19, 0x1);     /* Lp4Quickboot = 0x1 */
+
+	/* Adjust MR14_xy if pstate=0 and 2D training data collected during training phase */
+	if (fsp_id == 0 && (qb_state.flags & DDRPHY_QB_FLAG_2D)) {
+		ddrphy_w(0x5401c, 0x39, qb_state.fsp[0] >> 8);   /* TrainedVREFDQ_A0 -> MR14_A0 */
+		ddrphy_w(0x54022, 0x45, qb_state.fsp[1] & 0xFF); /* TrainedVREFDQ_A1 -> MR14_A1 */
+		ddrphy_w(0x54036, 0x6c, qb_state.fsp[2] & 0xFF); /* TrainedVREFDQ_B0 -> MR14_B0 */
+		ddrphy_w(0x5403c, 0x78, qb_state.fsp[2] >> 8);   /* TrainedVREFDQ_B1 -> MR14_B1 */
+	}
+
+	/* save CSRs to address starting with 0x54800 */
+	for (i = 0, to_addr = 0x54800; i < DDRPHY_QB_CSR_SIZE; i++, to_addr++)
+		dwc_ddrphy_apb_wr(to_addr, qb_state.csr[i]);
+
+	/* disable the ddrphy apb */
+	dwc_ddrphy_apb_wr(0xd0000, 0x01);
+
+	return 0;
+}
+
+int ddr_cfg_phy_qb(struct dram_timing_info *dram_timing, int fsp_id)
+{
+	int ret;
+
+	/* MemReset Toggle */
+	dwc_ddrphy_apb_wr(0xd0000, 0x0);
+	dwc_ddrphy_apb_wr(0x20060, 0x3);
+	dwc_ddrphy_apb_wr(0x2008F, 0x1);
+
+	/* load the dram quick boot firmware image */
+	dwc_ddrphy_apb_wr(0xd0000, 0x0);
+	ddr_load_train_firmware(FW_1D_IMAGE);
+	ddrphy_qb_restore(dram_timing, fsp_id);
+
+	/* excute the firmware */
+	dwc_ddrphy_apb_wr(0xd0000, 0x0);
+	dwc_ddrphy_apb_wr(0xc0080, 0x3);
+	dwc_ddrphy_apb_wr(0xd0031, 0x1);
+	dwc_ddrphy_apb_wr(0xd0000, 0x1);
+	dwc_ddrphy_apb_wr(0xd0099, 0x9);
+	dwc_ddrphy_apb_wr(0xd0099, 0x1);
+	dwc_ddrphy_apb_wr(0xd0099, 0x0);
+
+	/* Wait for the quick boot firmware to complete */
+	ret = wait_ddrphy_training_complete();
+	if (ret)
+		return ret;
+
+	/* Halt the microcontroller. */
+	dwc_ddrphy_apb_wr(0xd0099, 0x1);
+	dwc_ddrphy_apb_wr(0xd0000, 0x0);
+
+	get_trained_CDD(0);
+
+	/* step I Configure PHY for hardware control */
+	dwc_ddrphy_apb_wr(0xd00e7, 0x400);
+	dwc_ddrphy_apb_wr(0xc0080, 0x2);
+	dwc_ddrphy_apb_wr(0xd0000, 0x1);
+
+	return 0;
+}
diff --git a/drivers/ddr/imx/phy/helper.c b/drivers/ddr/imx/phy/helper.c
index b0dfc3a0b4f3f8cbbefc27b122b360e64d6cd6a2..877cc4fb42d72222cb889f0edb1182265b853d76 100644
--- a/drivers/ddr/imx/phy/helper.c
+++ b/drivers/ddr/imx/phy/helper.c
@@ -13,6 +13,9 @@
 #include <asm/arch/ddr.h>
 #include <asm/arch/ddr.h>
 #include <asm/sections.h>
+#if defined(CONFIG_IMX_SNPS_DDR_PHY_QB)
+#include <u-boot/crc.h>
+#endif
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -30,7 +33,12 @@ binman_sym_declare(ulong, ddr_1d_imem_fw, size);
 binman_sym_declare(ulong, ddr_1d_dmem_fw, image_pos);
 binman_sym_declare(ulong, ddr_1d_dmem_fw, size);
 
-#if !IS_ENABLED(CONFIG_IMX8M_DDR3L)
+#if IS_ENABLED(CONFIG_IMX_SNPS_DDR_PHY_QB)
+binman_sym_declare(ulong, ddr_qb_state, image_pos);
+binman_sym_declare(ulong, ddr_qb_state, size);
+#endif
+
+#if !IS_ENABLED(CONFIG_IMX8M_DDR3L) && !IS_ENABLED(CONFIG_IMX_SNPS_DDR_PHY_QB)
 binman_sym_declare(ulong, ddr_2d_imem_fw, image_pos);
 binman_sym_declare(ulong, ddr_2d_imem_fw, size);
 
@@ -42,13 +50,21 @@ binman_sym_declare(ulong, ddr_2d_dmem_fw, size);
 void ddr_load_train_firmware(enum fw_type type)
 {
 	u32 tmp32, i;
-	u32 error = 0;
 	unsigned long pr_to32, pr_from32;
 	uint32_t fw_offset = type ? IMEM_2D_OFFSET : 0;
 	unsigned long imem_start = (unsigned long)_end + fw_offset;
 	unsigned long dmem_start;
 	unsigned long imem_len = IMEM_LEN, dmem_len = DMEM_LEN;
 	static enum fw_type last_type = -1;
+#if defined(CONFIG_IMX_SNPS_DDR_PHY_QB)
+	unsigned long qbst_start;
+	unsigned long qbst_len = sizeof(struct ddrphy_qb_state);
+	int size;
+	u32 *to32 = (u32 *)&qb_state;
+	u32 crc;
+#else
+	u32 error = 0;
+#endif
 
 	/* If FW doesn't change, we can save the loading. */
 	if (last_type == type)
@@ -65,6 +81,9 @@ void ddr_load_train_firmware(enum fw_type type)
 #endif
 
 	dmem_start = imem_start + imem_len;
+#if IS_ENABLED(CONFIG_IMX_SNPS_DDR_PHY_QB)
+	qbst_start = dmem_start + dmem_len;
+#endif
 
 	if (BINMAN_SYMS_OK) {
 		switch (type) {
@@ -73,6 +92,10 @@ void ddr_load_train_firmware(enum fw_type type)
 			imem_len = binman_sym(ulong, ddr_1d_imem_fw, size);
 			dmem_start = binman_sym(ulong, ddr_1d_dmem_fw, image_pos);
 			dmem_len = binman_sym(ulong, ddr_1d_dmem_fw, size);
+#if IS_ENABLED(CONFIG_IMX_SNPS_DDR_PHY_QB)
+			qbst_start = binman_sym(ulong, ddr_qb_state, image_pos);
+			qbst_len = binman_sym(ulong, ddr_qb_state, size);
+#endif
 			break;
 		case FW_2D_IMAGE:
 #if !IS_ENABLED(CONFIG_IMX8M_DDR3L)
@@ -111,6 +134,17 @@ void ddr_load_train_firmware(enum fw_type type)
 		i += 4;
 	}
 
+#if IS_ENABLED(CONFIG_IMX_SNPS_DDR_PHY_QB)
+	size = qbst_len / sizeof(*to32);
+	pr_from32 = qbst_start;
+	for (i = 0; i < size; i += 1, pr_from32 += 4, to32 += 1)
+		(*to32) = readl(pr_from32);
+
+	crc = crc32(0, (void *)&qb_state.flags, DDRPHY_QB_STATE_SIZE);
+	if (crc != qb_state.crc)
+		log_err("DDRPHY TD CRC error FW BIN -> U-Boot: fw=0x%08x, uboot=0x%08x\n",
+			qb_state.crc, crc);
+#else
 	debug("check ddr_pmu_train_imem code\n");
 	pr_from32 = imem_start;
 	pr_to32 = IMEM_OFFSET_ADDR;
@@ -154,6 +188,7 @@ void ddr_load_train_firmware(enum fw_type type)
 		printf("check ddr_pmu_train_dmem code fail=%d", error);
 	else
 		debug("check ddr_pmu_train_dmem code pass\n");
+#endif
 }
 
 void ddrphy_trained_csr_save(struct dram_cfg_param *ddrphy_csr,

-- 
2.35.3

