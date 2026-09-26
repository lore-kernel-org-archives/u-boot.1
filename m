Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C3CC98332
	for <u-boot@archiver.kernel.org>; Sat, 26 Sep 2026 11:34:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8319340AE2;
	Sat, 26 Sep 2026 11:34:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6nIrN-JVRDRZ; Sat, 26 Sep 2026 11:34:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9212C40AD9
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790422461;
	b=SByhkM2Y0u1menfGZGamVhjpSI2yjPpxqORqlAleL9pe7aMzcGMEV1x6WV16D0fDwxM/
	 L4+uLWLGKhrF3UUV0veFJdKK2ifV/3hFLOKSnd8Hs8pGWqyh7ZpQw+DM3xXOhIX0VN0jQ
	 9dFgsaup4Xdpw/8AuxD7Yga4QZimT5xpfV+D5wO0aA5CTAffj4j+KpABQKUSgQhx24hgD
	 kvf59XIzC5JmtnhA2zW4ruSmdjZT2dHWZtOhqS+/K1PUdFwdzVWpmcjvf3QcZWQtmLI3c
	 Ke5dqelPX3bGfZTpMBVOLg3Q+UASPE2GAfhhXFoiRGeVlfaQICg9C3+qE2NyTiizEWw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790422461;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 Content-Type:Content-Disposition:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=oPRkkjE8/KKfx6B4E9cqyPbyCqn4xM8yTeH3d/S3Iuc=;
	b=tF4Cwt5pu12lg+48v7goM80LA7k8CZ77zsHEq0U9GABWpIXqVf1T7t3KuXJp1TY3T4No
	 qK7FtttMjg9aIdGbp2ylz6v/x5K2JL0sN6seJq01gLVeDnaNVtGqCjb80IcxPdm1rCiXR
	 miUHlx8nglVykp3FtUwyuWw+PRxICybcDts29sOTKsErnD+l9iRe3Vt/8cWriNrGgHw62
	 txTxkPMA2c6UxA0qdx8bMRWOrkKejRK/ZC7eNWlTfgFiU5u5RJvE9lBFXnhekkfIk6HDu
	 YiEugAqUZJ5MJhzBp6o58SV+OE/HyNrPKK+DiYYzo750WXiaaAolHzfAtyVBQG5IUiQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790422461;
	bh=oPRkkjE8/KKfx6B4E9cqyPbyCqn4xM8yTeH3d/S3Iuc=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WBKWvoAHm13benTSM7VIom9LA9a91njRR+jNKoHxR7AHPCJpn0LPCD5qc1L0I015e
	 BV3eQHiqVJm2uL1arIdyyzIPiy4NxPYdKJPCju/U7azlySyTnwcF7hAGnbBrd6B8bi
	 1bE8c/ltqMtRkhTT7XqiK9a/PT0RJiSbjmJHnkXbPY3aeTv0f8JZ6Ls5znDl7VTt3l
	 ww9Xhuw29618avAF1YOaeOtyYQOB0wcfyekc6rJRWOKgukoQqzrHq4NbWPHHnZGWsr
	 KhK544rNuJkOhWKfuNqg89dgXZ0xPKVbFmras5Vpeq03zTyqA8zs+eeHdqnxV2i5N/
	 GrmMYQ3C1p4+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9212C40AD9;
	Sat, 26 Sep 2026 11:34:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 15634194
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 11:34:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC15F4009C
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 11:34:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k63xqU6SOw1n for <u-boot@lists.u-boot-project.org>;
 Sat, 26 Sep 2026 11:34:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6CAFE40050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790422459;
 b=lFnQ47ErRctlhkum89Md2LQgweqFGK1KlzRo/iBdZYYQxCfjoITGb8gAWXSdfcckcAUf
 Z7Keusn3/0bzzlvUQr7WDvL05hUfIjA5ALZ9izi77bukCedSaciXqZCl1E3zxyuvE1QUM
 Agr+Fj1Od6O074n/MOY3QNJ1ISqj2+EsTJFKDOZdsJ7Tt0GvFwrwSsd/8Z779X/qhsnOt
 2lKGn2x6umxW9ERqEBiw5F21bvT8dYFGYTVqSb5ZFt3W63xDLR2niEK04TaD7QMFsS4yG
 rbox+0lhXYtPw9ii3RE0LUJeaF9rr6LHuCFKv32mhSP2zUdjtjWZJ0ti29k5/7nwM6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790422459;
 h=Received-SPF:DKIM-Signature:Received:Received:Date:From:To:Cc:
 Subject:Message-ID:Content-Type:Content-Disposition:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=oPRkkjE8/KKfx6B4E9cqyPbyCqn4xM8yTeH3d/S3Iuc=;
 b=qu+yI9VgS6oIMoG7VyCvL+to0Gn0W2RSkWg5CFSswXzHJ4N4/WgeGEpyH2e+c/4MG12c
 Ex+SnKLPHLWxaqpvwc2iQkFcaGIMHB+bK6Hs6EPTfg2D4t53nMViW20OF1h0XQtGthZg2
 fiUqwp29zg0tdW4pKo9Afxj3Z0a8+cjLZoiDs9iyodqoVQhQm5IJSVyFWXLbv762lN36k
 eNbKKztbiE43Xqu6TmF2kRP31TTLq+eHdrB8rYIV2VAnjI+/B0M88nViXoB1jeNujDyEn
 gBvCE0tlzTilLtmZJovWZs6Z16DMUQkcNvlWGqAURDtugj+DosAyXAUnfuBqR/UwEpA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=fail header.from=oss.nxp.com; 
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=thk740cV;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=thk740cV
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6CAFE40050
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 11:34:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=neFbsrhILi3y+6xscJ38sh6JcrCKP9rGRcCqTmLpkeETSxOXFHc1K7i4MwTICUQie4EASn/KC9nUrCxs3IACDYQxlUC1n8FiUdq4z6NS+6nrUxQydJWgn+9T4rjlg9CW09zZAxn9FarK2RtSIQ11TQtnwksbSvBfYtLUqb5Qh4v7e9JRcjEw/Xcl3bd426x0UQeROaPoM41i2Me+2s0lXtHIuEDF2GLS8IJzvll20QVLJBNNPwdw+Wf91OzkhLS+N3GU3PSAjfX9gtNgxvJcS5q+1kSPhK7s3B0MV/sLfHTmRAi8t709OXspYU+K4j5fWqDMIJ6mUoQULiRZfNYSxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPRkkjE8/KKfx6B4E9cqyPbyCqn4xM8yTeH3d/S3Iuc=;
 b=a72Ssu+Lm5+xECfdBtCXMwlzPwLQRb7qn5j1qyUzAP4CLB9fjdM2OMqjADpIdeDoyFoBamyohXnl6sH1oodBJN2Ojunz4TvgUQh1VqCw7IFD+iFqGshf55B6vquVIHv79o8j0e/9CP27EdlypjNT2yGhXu7XfpjFJR+FqAVcpr9bhDM6zvooOmZvkzu7QQBS5UAkyup802C25Izccg9j1L0RVICKEDfVEzb5LKPbY6/p+2U7LiWzrZbtV7BV+GhwyIBFs1bgKUgKLjzg+55AEge1B5pMPcuXdAJtNMu1/h8z6Y/YxxTcysAFcSBwZGvvyx0SmLSMpklQMQQjUOIt0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPRkkjE8/KKfx6B4E9cqyPbyCqn4xM8yTeH3d/S3Iuc=;
 b=thk740cVe1cZmkK70c7q+HWXL3/aH/7zFTeKGCPq3BQVJHHrRtd7bKaYlekbpVqARgenwctcoBU/7P6rQh8sh3KCwoSjITT/zGA/gNKV0y//P4qnuF3ZS1DhFs/bs5ijBoUlK4Uj61KTql9miyy3S5kpX+6ANKgSj91ZaKOAAnTMFJPl1BXTf8UwFC1yW6bDLYHQAjOgwSvk129NatuD0NuzkTYDegG3srQDve2fWhvM+GdmklYAtDUeq+amfaFm3D3KJMR99eXE/AuJlc8BN6t/Cfq+pO34cDlp6+nG/1UXYah4aZMgj53Sgx/nSZghf4F3zZmkrn6CeOwP2st2lw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DB9PR04MB9774.eurprd04.prod.outlook.com (2603:10a6:10:4c5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sat, 26 Sep
 2026 11:34:13 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.014; Sat, 26 Sep 2026
 11:34:13 +0000
Date: Sat, 26 Sep 2026 19:31:42 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Linus Walleij <linusw@kernel.org>,
 Vincent Jardin <vjardin@free.fr>, David Lechner <dlechner@baylibre.com>,
 Carlo Caione <ccaione@baylibre.com>
Subject: [GIT PULL] Please pull mmc-next-2026-09-26
Message-ID: <aretHk7cp91PEuhY@nxa18884-linux-1.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DB9PR04MB9774:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e46bfc-e1f2-45bc-e683-08df1bc216fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|19092799006|56012099006|11063799006|10067099003|18002099003|6133799003|41080700001;
X-Microsoft-Antispam-Message-Info: TyLvfZTxxgjTyhYVO2O8czZtIFOppHxi1oCMhhHeZUvrNWdgsScAVEchUt5IJ2jHCUj6VCzgr5oCBIEOdxQnZdW+iozgFAYqUewYlRM76iEuOXP1vwx0zPYgvqQmf3QPpaxFUPxMYT5tzwN9MoAXI3mE2zsNtAHSyISpYKkaAJHxNHzf6UMUM70+XzMI51nYWawF9cv9pdI88Hpl1EjMEuyYeJrMrV0fSSXECFi/6gh5D3/PHWD9pOYBqTzC58V5brHOHidR96ijpYH3rc0v7I9w3B2cNBRG+eiXglujbdRFcnoE4eW/liTuD7Vxg8zXBZVxLoGkoFkRZgBqPvrtQ+siy7KVenqEyx8Hx6SCC0iuHhHxOYimTc/zMTIplubwMmKFSOmAVcUY9nrOAt/smhKIqmOyhmf9y/qqEQSa8/0nbdS7Ryn58yMGPXUY+7ycOJtmPfQ4jRzQcaW1srpThPLiHQReZd6AHu+yKPRs84HjB67wxuU2Lzm8jalax472M/oJtSYNE6tvDnR2bfv1B99gw24qEiPkq+/OaNKcQot4ZqjGxiICl82+Cd0uEk/+RhgiRao/KD5HikIkzQ2/R8aMHkEzJ6W32j3tPRBcD5mVP5LjsBWoWxhVA8BM3NcnkAfCUFOBATlEzS0YlRiOimthwddITXIZ2mC6KezmFpo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(19092799006)(56012099006)(11063799006)(10067099003)(18002099003)(6133799003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MN3GmuH2nkQGBdyM8vrXyXEiJ1q0ORpd3ATX2El8NTNe2ihxtrN59xovlv7Z?=
 =?us-ascii?Q?3FSWTnWvJfY5EWxl/eEKXIUaWrhVleIBCQgHV43EChd+4XfX3Nm9rTU7NDwl?=
 =?us-ascii?Q?fNedfNnTS4PBjfGKhbU665oJuze49G76mva1CdEW6FhX2eXUxnkjCT6sSTHO?=
 =?us-ascii?Q?haLXIRgUf9kdQ0u2rJIercHneHMVW9n5rBtZ6a+T2gR8yh3W504kSGMNYWw2?=
 =?us-ascii?Q?3lk8/5AKfRoaq0l8Od0rbDztynE/ZRIYb6z0kMLp9eX5raX2u9IiHgWHpiVM?=
 =?us-ascii?Q?6WNR8fU1nBU62nn/OZ/b1nLZcoziUoPNyH25RlWS5pAx3au6LaNAp89TJaX8?=
 =?us-ascii?Q?fFX3non3479aQiVfSILknDKotA9899f3ekL0h6m0wklQCLZyb0w2r2n9HOjc?=
 =?us-ascii?Q?k2BH0k0/e/HgckQmTFY45dubuc+sg2zmuqp3tPU0fG/GSKgNxoeAuF3LoGoK?=
 =?us-ascii?Q?8VYDDlY+4RPUPoqO6dbPGpCmwrB6dVaFJ63QaFjx+bLTxFeTUH28V7UkavBx?=
 =?us-ascii?Q?35kp/9cp96fOOZVVI0oVZcsSBZY8+UXQwiDS87ZerVCMHc3SGHvDp6RaQ4DC?=
 =?us-ascii?Q?e6n0fNcps7UKkwYpedd2h+Hspb8UKx4Dvi6kFIpQ/WlCP+E4OGO/Xf/euwYY?=
 =?us-ascii?Q?YMPLtIB/MQDbwYrwSYadB9D1pwsdhMR8MfE+aQJFep8MM8vCU2p0kKSjvK+Z?=
 =?us-ascii?Q?07kPJX6K/brmmezBEMsGnjyb1IqDGI7yfN78sW0GK6f2k+NvLJeb0F8A955t?=
 =?us-ascii?Q?BGreCTjxdrgYM7tuILPLwRuQN1krFJCgYfV+D7XhyNtT6W44a7raFBrgCRfs?=
 =?us-ascii?Q?skzLZGZ1xWcJhiB7N9pC9RgbZtxWeGKOeHLiT4QjiyEBEUoD5CquB5IiJPcO?=
 =?us-ascii?Q?HAs97AhbnB0vChYoW0dG1PvkXz9KFHlHG4tPiRawWGErno25dpumjiSexx/6?=
 =?us-ascii?Q?R3BJDwzv1g+5mTQo68jo7zQxVoL4u3jJQ3PRNmmankW0FXpxbfr9hr2TSOby?=
 =?us-ascii?Q?6d3dSANv+SMt3lm5TKkeO2tJFISWkfD4FtuxravUaUDiwQCjq63iGPKlPsgm?=
 =?us-ascii?Q?nD8EmoXJ3JbfJjiYmW/ijpJ/wlsZPmheXHXjHpW1O0a3JOZjIgrkabtI9pXm?=
 =?us-ascii?Q?VnGG0tmMygdNj1euiYqAgAZxL2U/lApIXSL80F8/0LxgTLG0RV953b61p/7M?=
 =?us-ascii?Q?aDGBMka6KJhSlQGrduc1YjpniCaYdfWZ74nNilbVdvlszZPiOwb28vlTjjQV?=
 =?us-ascii?Q?w12qqi6yYgMkVUXiq/2UZtAZP09kfe5NMZ/KthfdT5Ndix1daEQX4v3QEcAD?=
 =?us-ascii?Q?NojUGIkQeWVGJzk8C9UnucF/CPAjF2+NqIhwrwd0Zt07LuXS80KXQG9j3RSz?=
 =?us-ascii?Q?VxLIfOXln895StX4MkHg3bYxgaaOMa33ELAnulJpp54a12SeeT+Qq1/xDPJ8?=
 =?us-ascii?Q?UuGBojjII3h9pqwIoFon5P03y49VVgYzrGZHYGug0I73Y8xMDlhYdJkG2vVE?=
 =?us-ascii?Q?rm8KO38D87Nvm9qflUeUpZQ6BZwliJ7uz2lfhSq//R6EgyFYYv3Pj8hClBNG?=
 =?us-ascii?Q?VcT6LTIxXh33QOls1Ih9nb9+38yeTEWcTV3B9+5CEMwBGsj9cOzxrBjehIYP?=
 =?us-ascii?Q?qw+WqZ7m3qsPdiVu15s7u8hAE5P/ZsTBt2a7iNQ0EWoTYMkqTw4sBVG+eegT?=
 =?us-ascii?Q?BUwE9kToVo89jY8LM35x5OoNzed1toV/eawK7+jJ/MA4J+3TG2cmkL53ELpg?=
 =?us-ascii?Q?sb0Qh559Xn1+In7e8w64Y819dtoxSFuQP5wobFVbOYGk+21xkl5M?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e46bfc-e1f2-45bc-e683-08df1bc216fb
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 11:34:13.5511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5urQgGKpO55/y1GkCngcqmtFYz+zTROSuoNDGbji3CdPJBTUzl/aJU0iDbOE28P5We+HSoPu+niC0/h+X440aswJMTreZr+tdD8Y7zZ1KS4G1Cs3p5ttczO5/ZATgzh/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9774
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Tom,

Please pull mmc-next-2026-09-26

--------------------------------------------
- Improve arm_pl180 mmc clocks, supplies, PIO
- Power up the SRAM-isolated MT8189 domains for
  ADSP_TOP_DORMANT and EDP_TX_DORMANT
- Support board-selected raw partitions
- Use DTS address in mpq8785 regulator
--------------------------------------------

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-mmc/-/pipelines/1376

Thanks,
Peng

The following changes since commit 9e002445cd0d47d3965312f12e97a18e1ed8bd53:

  Merge tag 'u-boot-stm32-20260922' of https://git.u-boot-project.org/u-boot/custodians/u-boot-stm into next (2026-09-22 08:59:41 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-mmc.git tags/mmc-next-2026-09-26

for you to fetch changes up to 922a11194d6e85ae3acbe5d18ddb0274c8ab7942:

  pmbus: be generic for any devices (2026-09-26 09:48:47 +0800)

----------------------------------------------------------------
Carlo Caione (2):
      spl: mmc: select the boot partition after device initialization
      spl: mmc: make raw partition selection a choice

David Lechner (2):
      power: domain: mediatek: support SRAM isolation and inverted power down
      power: domain: mt8189: model the SRAM handling of two domains

Linus Walleij (8):
      mmc: arm_pl180: Configure Ux500 signal direction
      mmc: arm_pl180: Gate idle card clocks
      power: regulator: Add driver voltage clamp callback
      mmc: arm_pl180: Set initial supply voltages
      mmc: arm_pl180: Power down card supplies at OS handoff
      mmc: arm_pl180: Read FIFO in bursts
      mmc: arm_pl180: Use bulk FIFO accessors
      mmc: arm_pl180: Use variant FIFO sizes

Vincent Jardin (2):
      power: regulator: mpq8785: avoid scan, use DTS address
      pmbus: be generic for any devices

 arch/arm/mach-k3/r5/Kconfig                |   4 +-
 arch/arm/mach-stm32mp/stm32mp1/spl.c       |   4 +-
 common/spl/Kconfig                         |  13 +++
 common/spl/spl_mmc.c                       |  72 ++++++++++----
 doc/develop/pmbus.rst                      |  42 +--------
 drivers/mmc/arm_pl180_mmci.c               | 145 +++++++++++++++++++++++++----
 drivers/mmc/arm_pl180_mmci.h               |   7 +-
 drivers/power/domain/mt8189-power-domain.c |  14 +--
 drivers/power/domain/mtk-power-domain.c    |  51 ++++++++--
 drivers/power/domain/mtk-power-domain.h    |  17 ++++
 drivers/power/regulator/mpq8785.c          | 113 +++++++++++-----------
 drivers/power/regulator/pmbus_helper.h     |   5 +-
 drivers/power/regulator/regulator-uclass.c |   2 +
 include/part.h                             |   3 +-
 include/pmbus.h                            |  30 +-----
 include/power/regulator.h                  |   6 ++
 include/spl.h                              |  21 +++--
 lib/pmbus.c                                |  10 +-
 18 files changed, 367 insertions(+), 192 deletions(-)
