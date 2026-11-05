Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FA0606A336
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 02:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nFy4xFk2;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=SfhXKCTr
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA3A060728;
	Thu,  5 Nov 2026 02:43:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xg5z8DfnXdbb; Thu,  5 Nov 2026 02:43:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E1D70606E8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793846624;
	b=ZhjLX4uzE1xXpOu27y3c88O5In1tVJXyhRLTkpXt4EcYYcT9Q/hrl3zQ8Qq1u6A055TX
	 eSzR/996lrpsNJWSK6fQDbAO2fRz98+e8Pz481tqpJO5dqm4RAfqg7tvtG/MJnaf73ciR
	 zX+tjnn/YokfkeOIxoHPrSWiciW/B6NTzaItQPzLXBSWp2GeUqUvbdZX8AJSZJNojKWRU
	 bry6NueZ0qklW/tBg0T4v9ia17cHv7FN4Jf97vf7zee2nKX0EZrQj3gttjq0q0z2yX9dv
	 /kOyWPQv1B0uoiJKtoEtsBJ4yCZVpZKOCTtBIdx4ZCdNrReAgkOGYN6IrZYsXN4hwHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793846624;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KzxSZuu2OmzWtSTlMeuquSBnUBqN5whTqGKt9CkWH98=;
	b=mvUkLXLRsYK1lelrNAxLg/7HbuHZ8FKkC23MOGQcAKQ5kzvHoqX2Yvii7N+kgEPZnmi0
	 PcmgyuJfQpo10g5wev9ZwkuagINpeSWoK+6C2Z9uaQUlfNl8oaubAlaWdsU6A2XiwstgK
	 kmgYM3mGy1iG8lzeNxrwhCFaiGOqxHYGBhlgPgt7ZhfmURP+bjiBLJ++Vi/HgV0u/b7J1
	 HqeBR3b0zfr/k04s9f0JutS/vZ0cUf1bW+PvZxuR8RrIib8a9mIWMlFMvL/qhs2z2JkrO
	 4FPgEcimc7MlQB/GmE7FvVSy+YvJouOWAoBVj4iBTuiBGCgimVYdVCbG1dZnAA4sCKw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793846624;
	bh=KzxSZuu2OmzWtSTlMeuquSBnUBqN5whTqGKt9CkWH98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nFy4xFk2JnCL2R+zhFJ6vgCHDXSAYo2yq0x9PRsNacRNqDDtdk4ZMhiDxsreVrYm+
	 Il6QTPLzhGF5LbDjsUOp7adNEE7FUUw8YW62lXdXh0AhMqR4NcvYtZKug/oo5NrzyS
	 aB/TtUkdp+drP42mObmhn7LWGYZJmDlCpHokXTohZt6jLkdvrI2PjQUZdjATXC46yW
	 OCunySJrgM+NGsggSYU/4FYzn6PbAqXbgE9+ivacJAhifvQyCQyqb5eXPk0OL5uHfx
	 KzsGRaFVAhlwTlaWK1JcJJWV8tAZkBIHbZ2oLXutQMf5MYyvXcITG/fWKjrcg9HDpw
	 u4Gh6c4KqgKWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1D70606E8;
	Thu,  5 Nov 2026 02:43:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 89E2D31F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 02:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F0B480B86
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 02:43:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LfyTWJQatKlL for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 02:43:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1B5F180B80
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=SfhXKCTr
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1B5F180B80
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 02:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzxSZuu2OmzWtSTlMeuquSBnUBqN5whTqGKt9CkWH98=;
 b=SfhXKCTr9HRPSBz1oHbCA0G7O7vdLcx9JHyaa/EBSwoB+ybzIobVGCA9FoQptw8jHFMIiKuruVwkwgmNuQ8DSQucKVX/LX1pKyG1TFIbfwVVE35M+1u6adVhOsv43px8Pbfl5ErSJ32xjEVtT/Lznne2KN55m3EhwBRG3jy4NeJ3s8/XmLCG1fUQ7xaIkb+DZDLJoCfPkba9+LuJKVoteUWpEepg4pSvzADzNFEMTeyLRqnKGLanY5ETVnrQXGoFMzvyySBCYpdEI//K4NvzUggsz+B44bFPLS1Ksmr8I1HFylvBAOI+dSVEkJGz9k8+YVlomFRr1q9Pfo5RYvxzwQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAWPR04MB9985.eurprd04.prod.outlook.com (2603:10a6:102:385::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 02:43:35 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 02:43:35 +0000
Date: Thu, 5 Nov 2026 10:40:15 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] mmc: sdhci: imply LMB_LIMIT_DMA_BELOW_RAM_TOP
Message-ID: <auvsj-bufAL-qED_@nxa18884-linux-1.ap.freescale.net>
References: <20261027-upstream-mmc_sdhci_lmb_b4-v1-1-c4724f42ac0f@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-upstream-mmc_sdhci_lmb_b4-v1-1-c4724f42ac0f@oss.qualcomm.com>
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAWPR04MB9985:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ec792e-2dfa-41bb-ddd8-08df3ae6964e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|19092799006|11063799006|56012099006|261009223027099003|261021121427099003|261022075727099003|261028144727099003|261102123227099003|261026140227099003|261022115727099003|261022105027099003|261026121527099003|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JPFFBHVFy87JniNaNFrUzan4HJv68DWjKPg+gc8DxL1z+U0xsoRlofKkOsKqhDxrAchWuKM23bwpx0RBce+WjNVZBxNKuOvAYsr2mtb3zyxCKIwv4G92rFxaDPL0udVypw5nnJUcKsJYLc8AyBrY9I/ZluQmPFaj879/ei8TXgrngjfgYYpNMI0TlpzRuBQWpvucKiODPfbtTW1nB+Q2dGYEnQcEOyfzIRbvGfhIrc7E2PQhpX/f2xp5M26+QRN2kzRxU76P0fvVanD2DgfFNumRctx3vlpe7+ZFdo+zdLFd+jln5+X7Z318p9tiZyOv3dqiQMTX81l7RR024nrmY7JvRKefj6KOD1dWJGEWctRBpXNLsWQNVW0HniSEGk1Fwckw5fA4flnh9oR3oiWnMW6+IO4V2xl03+pybui/62yromJnHLFTwUJWkZAyJXQMII9K/67Oy7FFzKCKPv/GtxZbrsHV1qznP0ZKODDMgOjDyh+s10/cByCl49PDqsIpXuSHlZgNEpWSWjvUiJX5YGsB2nkAwymgQxgC0L6i+GNoqOSbUYpdGuJsdAly5AB7EJZQ0YH+aPM2NJXyE97q3jKJuZYZa01pshMLQkVIOk+0NQ5xBUddDlu89fSQ90K8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(19092799006)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261022075727099003)(261028144727099003)(261102123227099003)(261026140227099003)(261022115727099003)(261022105027099003)(261026121527099003)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OjNWO/l5wfqTNzxSoiCL1Phe+dC2MPWFfsSs3OMwFlyVC3E+64wNjixIllRf?=
 =?us-ascii?Q?LIHs7FP4OX1KpzyuwpihATchENEki28LdeiCdV/VCmjKgKdZrS/EzrUSUZZK?=
 =?us-ascii?Q?kuvkYKfzo6BZ3D4Z2PpWJI5FFiw8Jem87tl+hU4Dnq2+Z3HDnCh8/FEzbKHT?=
 =?us-ascii?Q?Q5HTAXXN/a2aQLMcI23A+Bsojn4/A5MV+JLcuFThkQp6xauJuWuBHET5COYw?=
 =?us-ascii?Q?FaBKiu+YSQElkWdmqiY1eIVq2y0i12pfc3zFvTtFyxRyMyKB+FavhWNc22nr?=
 =?us-ascii?Q?hMJewmZ/3UaFdKOtd67bnHO2z9dYsORwJX77ORxflX0qDmDuKdjBy8aWdr5O?=
 =?us-ascii?Q?Jl0AFwQjGAwO48fKNAbJ57o6BE48ljmcPg9xr4OGmgYNIqOCMTA0LDqtryfU?=
 =?us-ascii?Q?XmGf+UWqVD+QgwEC+x6pSsae1yVbym6T09uLBLgo7i3NoMrtG8+nsXFA4gL/?=
 =?us-ascii?Q?plP2dOuFfjdlAAEOR1J+pd75ufyOp4ryYqFg1KaGfsK19C/SSn35lqE2jsuh?=
 =?us-ascii?Q?O/DOZMZ9qOXT57+v0k1QdrAXv+6S/lkCYZXjK6qWBcAw4NYtaJVJNGlLSDsr?=
 =?us-ascii?Q?VhHQA+JOGz1mM/LYT0dRPie6fgDa7U4949OGnt2WdL6J2wnwBlIt76ZT3I5Y?=
 =?us-ascii?Q?oo1yNcjdnukarlSH4ppM0sBpxWewS6U/UCW+gT2tHUVDXjY88euFHxAzH+TQ?=
 =?us-ascii?Q?PHyrB8bnwb8/lZUPMfPpbv4a2lqSdcMfLqtaIhgrMMePRgnARex98UDr6jMi?=
 =?us-ascii?Q?0nrYSEKvw/Xs4uXWzV6FeMTzbVvfhVqf1j+K/WS7LDJHe7vI4vvy85FlHpkv?=
 =?us-ascii?Q?dd58veJeWvALIBnSEqU4HRFxTW0EX1xAkwl32U8zS07kHeCDebrBuNZw8FU1?=
 =?us-ascii?Q?RJvP5pc/sYkcnFyvMZK0cfq3c7tWuoH8tNNr56TQ7dIZQ7JA9Fu1wrDc+05H?=
 =?us-ascii?Q?5PVEe62xkjUllEz7lt306kngy7EE9R3m3roRqWtpxpoEUX2/QaL0kkLwDsb+?=
 =?us-ascii?Q?2IPR5wV/kJKIZlDP5UCFBaQfj42wwk2mnqrc0jgWJd3jZXS8QqFxlkFymavf?=
 =?us-ascii?Q?uTEzoVgnEGQmdO5ccWzbM4yQL45oKSy4Al9xWbHefMXQIDsoI+fGPp4b09Vk?=
 =?us-ascii?Q?knk0XfGvnb/bOSYrhhrIfZc8lNPPCUCoDvMhwDrkYzS261L0w5nWD/HosHW1?=
 =?us-ascii?Q?CyZfKkMBRN9GNE3Iy9cbI40THp0pef9z9oG9E/+K+dYbqPxdn4tkrTAJdHDI?=
 =?us-ascii?Q?UeIrHuCXrQVsEbEO71PdGVzLfEMF+qYCZxH9mF0heqWXHPMh87WHLPQgi8KH?=
 =?us-ascii?Q?/cMNTSLhmsVrky7uVFlbEPbHc6OTW6ywZlPIAdbYxkDgn9twzkWnLdpPJmKy?=
 =?us-ascii?Q?N+ZF1DKH26dY9rpRC3i8prmE8sOugcLTiGtsMXaXBeS9OTZE94R3Eq1gPmLy?=
 =?us-ascii?Q?NLmEi39/8jyqfOSuibRAZUHxXcUsQd069sPnRrXAIZA8IRTSI1oipUJaC7FQ?=
 =?us-ascii?Q?Lu6R0cddWh5w4oTm42Zw5FuhudAbLIVsgfN3rokOkJYztzqJfLNVZ7RauO2H?=
 =?us-ascii?Q?W7qnqhScflC/xz+Q1dKTVKJQUd0+HDBbHcE9zWojxsvV5zd+NotN6g3ah24K?=
 =?us-ascii?Q?Zzv5FwVC5ncR+RKRmMMcAOhodSf9VGUGvKtjDD0wvFsLa2DFa3XswwUH7YyO?=
 =?us-ascii?Q?YauCj5rcLXDRdYtQRbfnE4EFPb+ivDISygvg4lWUGy4h+O0KL4+X1jf/eLGg?=
 =?us-ascii?Q?6W8pSAOQuwnQFJ22gwbalNvNbciS5fTcIDWJO+SX19X21qM1/9Jj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ec792e-2dfa-41bb-ddd8-08df3ae6964e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 02:43:35.1488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+35NJmsQ5F6LhgqSbMS8zpBR2ktEkyLQXUYuA2UoAjkLRAbE8rmi9jzgHIRcqGyNKaFBMoWIdH/SqHNWt3+pLG+lc/7l2/eEpwOaPrX8FoD9wYO+kcTDyOKyBV5iqqN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9985
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 06:37:49PM +0100, Igor Opaniuk wrote:
>The generic SDHCI driver transfers via 32-bit SDMA or 32-bit ADMA2
>descriptors, so on boards whose ram_top marks the DMA-addressable
>boundary, LMB must not place images above it: a later load from MMC
>into such a buffer could not be DMAed. Imply the limit like other
>drivers with the same constraint do.
>
>The option keys off ram_top, so it only takes effect where ram_top is
>at or below the boundary. A board whose RAM extends past 4 GiB has to
>clamp ram_top first; for qemu_arm64 that is the patch linked below.
>
>Link: https://lore.kernel.org/r/20261026-upstream-u-boot_qemu_arm_b4-v1-1-223dd8060db0@oss.qualcomm.com
>Suggested-by: Tom Rini <trini@konsulko.com>
>Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
