Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9F1CA5FF1
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 13:17:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EBC3240660;
	Wed,  7 Oct 2026 13:17:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SYynz1rd1IS9; Wed,  7 Oct 2026 13:17:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4A1FB4063E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791379067;
	b=KWJ96qyzaXspvDQeznrxCyXf6tQwD5ivHFmkXQWTE4GtIk/LL1aymgGxRM/R2+7z79qm
	 eNhVTAx+HQn1K9uu8so4Z7GU8aL6Mgc9uDuO0e0L0jl16bEJxkohOUMM3JA5ZKJT0VMjS
	 XpczxMJwSOw6XIt9/Oa+fGb8kVZugHpHZTsGMiEyHedSb1JSCRH7Hoz/6ZjqXQTs5Dpr3
	 zLx4RtiMfmi87dZhmW4bL0j+I6cj/Lgg6OmgaAK4XF8RYF4v+RzGF+brT2xgToH6/lYgi
	 iM2T7y8OkmTQGWdgr8KMnHTSZMaCS9pVuExFdrl2JyLcoY67GhVEqO11Uls/pwNZH2w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791379067;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=row2xK+gL+OAB22R3yzZPJ8poGVauLgAXoVPyiqtW2o=;
	b=mpE6k7uzK6Y5qCfmtdG4Gu26ZcxVt/FItgAl4Q2/Vj8+G9NQtY5zatngNBf3jeNCJ+Ag
	 TD7jX1rox14Nlf/uvwCzIGIxrLngPVblEKDx4wuWeOsl+6OKs5RJQt7BFwk2Dbm+sXzBw
	 g0r7xvoov4O6RPloCTxYSbZcG68mt7R0IPFm9OeVcAkaKxAws4n5xuhFehq7RrCYhKedp
	 on9UsDmFP+OLIsYrakpmIXQfTOMWVKzuT/9jF0FKCRKg1Zqr1r/WAx4QboGfdsD0Di144
	 Y1iIFqFnHF7tIXctP2m1WnOrgz6apx7i7YvnHpD1fcMDEy1VZ1qqNZBfFjSBgXXarjg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=processmission.com;
	dkim=pass header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=c8VYKFaz;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791379067;
	bh=row2xK+gL+OAB22R3yzZPJ8poGVauLgAXoVPyiqtW2o=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YkudhokuxsMv8/0rwA/ctbeWk2k21k0oU0G3yD22Xah9s2rpxUaxGwIiO/vLkL255
	 tLrWyrsPvFaVWAwXU2jenfHhuoA5LHAc49Uyhj0xZn0in69uuUJuKNdg6D+ygEeqLO
	 U1c+MahswwyVFvkmp8lYFTHullw4q3Cq5CMUasL0nRBGgpK7Mop6xnTgRCUqTeGCEu
	 nA7MTJS3zOKYnTK1sQJmF+84b7A1pxJLVIXn9/EQxJHYhdlaZcOK8+FkVxs5Xv2NIs
	 2EyoOyGCYwO0Yd3UmGTpbp8CuISTJigdxQLV6lslUVKxIWiBhqN7V0EZ03PYen7KRx
	 Q4E8bMS+haUBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A1FB4063E;
	Wed,  7 Oct 2026 13:17:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 79D8622B
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 11:03:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6BC37405D1
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 11:03:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1QcfhavR7Kxf for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 11:03:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2CBB64034A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c406::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791371021;
 b=GS6xbqrmhpJFAFlKRrheaJsaLzUoODqW2xfVQ4QegIrI6LsOlAxmNEZ4Dh28LCiaEylN
 jm+feUG0bYR5dZrOTFqt5B8+fv2FT7ezQCBXlXRvRBDDLgkuG4vlkiSjrZ0unzMMWX7tZ
 KW2lYQUcK7ABtorBm9CtQQq8oYGfYO2v9woa5yIPKsdvALLNAkLPv4ENP5zgR1d02soP6
 JrnZwh2YbXxioPs2HjQQd0srXXzmN7KMStNSVQg5oaQpj39Rsrlo9fXXZr9b1uyfEmMN5
 d5hlzumTgdyZA6QqipGJPhUSJZ6qHEclRXsCPXAtlYi1BKV9i1z14ZUaidj7gZoQM4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791371021;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=row2xK+gL+OAB22R3yzZPJ8poGVauLgAXoVPyiqtW2o=;
 b=Qfm9o/2rMClE/NY+im/IwRpitE2VB1joMlXw5PGMFQ0M160KRPReH/UhtzWZMWFzy5pr
 Hx4j4wboLGhrbX4xX/2b3B7qKikIavGUwMLrgR49wiIHnGwO2/Cg6v5ckkDx+CgR00imI
 NfGCAkQw6ts17tozDMabQBNPqWBhTX7MnE64AuRrX6ms2lDjhMyCdgxRBrjPFO/iCYeRN
 vTd4RoVMbACyogdB0sg1ndWl039X0XM11gLqZGLUOl70Y/1rCSydWMypO5OxbuklVWIXm
 RehPU2kSnXXCHROXY641gRoV5rpC0R3Ui2SIKJFQpjpB7Yv31CcEpp3kS8wowVMf/Jw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=processmission.com; 
 dkim=pass header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=c8VYKFaz; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c406::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c406::3;
 helo=os8pr02cu002.outbound.protection.outlook.com;
 envelope-from=bin.meng@processmission.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=processmission.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=c8VYKFaz
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c406::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2CBB64034A
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 11:03:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCH2B3HLdVJt1/cRby4Kf+HbbgcnlEwgeKxucc2XAco/McfzVhvYz56pNTufe7CYykf1uzOlVEODCJGQXnRkHOJFs31GoILKwmoDh9yIahKzZvMfmJZDpZlAjIRbPTWaNh2wTfg04TZB2jZu4rtYSRh22wnAfhsYMu5TcbrJkk31r7PnPXPtjcLE35xKMnGPsaGJaGHi3/vYK03URW6P4YaDrcN0pnNxHdjAxcdKqDwyp+CmPZYukQTfoJSQvsTmpq5pg6m6b5CjNG9SeGhnh95e8IrLuWV6l/b8aQbGVCOXDn0Ls32/GOee95v1TVL79/6dj5Ng1pQI/mPOTY1JPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=row2xK+gL+OAB22R3yzZPJ8poGVauLgAXoVPyiqtW2o=;
 b=mp/gPp5lm+zvRcnXvMvUwNIj2MWFuraawryUP32uW4r3yMRhsBO4/mW0h8TUqYhbvDadxanSbuktGbWTkL43m5dF/pk1putXIQGzuj7fmVSY8uxBkVdmZiRzdDyzLDYSzvcK871H/6Z7BFFN6BXmwBCc2cpMGgscahVny2E1cEH2FV4DSZHQGnkL60X1uhEJfLfQo8FVuHkiqyk5y6TIK1u4aIBZOVbMHBDYGyLO5ZmgYDpaLyInuzOnnJRVGLOzmib5HEj8OroDptuRah5s/ZV33PPb4an1+wm6bVGfZCn5AoQ7NofjIBT7Cl1wldlRM5ULSS9k1YS2RnIwFk5eQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=row2xK+gL+OAB22R3yzZPJ8poGVauLgAXoVPyiqtW2o=;
 b=c8VYKFazhWPYcj44yIzblJKE5PiEoY3rXI6dWytuRCY3rEDiLXB3NruiLJxnqXpMzFQypIMt9UqxgoSYF+PwD61C8AGd2afYa2moJoNhBzmoTnYqpha2ZRIUxRma9Fr+UKg3ksIgIxTcuHA+Y6u7fnLbv8Av/YYoDRttvsVkN6sjc1Wc13azI7cgWwhTuJcBE9Pk9OnvQWE2OyV7khxjhjwF68tMPevIeoEdhaFtwVkoEVS171EOzKilx7UsCcAnpeX5oG7yvROCjJVCQKFpUxJLzMKKqCVYzFUdlD2lHQAPSzn8IUfhMe8UlUp08E2+lrqHA1vnHKTwN0rYOYy+MA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYZPR02MB6996.apcprd02.prod.outlook.com (2603:1096:405:2c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 11:03:34 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 11:03:34 +0000
From: Bin Meng <bin.meng@processmission.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: imx6: Restrict SCU reads to Cortex-A9 variant detection
Date: Wed,  7 Oct 2026 19:03:15 +0800
Message-ID: <20261007110316.143181-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0239.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::17) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYZPR02MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a82b123-37ae-4fdc-fc9e-08df2462a136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: apoKWA/gLWl+z9cfS7V/G+iFSC4IB5+wkjcL1TsK9yTsUWLhJ8noliVhAgcTe23XboS4esGi+/45ypAJ1B+cHhuECji3zYCe0zAhzLQEUBKVeZVWnAbUj2xxJPSYd9IQphX31Fiq06Z2083KtcH8UzK/fCC1UG4xNXDC92MT/jKykASvPmc40Vzhd0T/hH2vHrkaxthGMFyOazyOXhr1B3m9+i1lw1ykghTxuDssHpL2RSmiK0nsmm54AoPqNm7AtNZ81LVI0PWfLSu82H5ETBh0udtazMTg2uT9DT94bVT4gzFuY4b4pffXuJhzD6QmU3XF3i+f0W9QZmmWMExlZrpNHk+mLAdGT6HjWzpdhVpClB48TkVNqTLmDiDNoEjeuFtrNoNMiem/+nWLRTfglOlcAQsZEpPjWs7ZiZDcaYdxGRugZKG5iGb9UxerQROdW+bzk3K4bejJijrEtAZlzyUHwhzQbgqhvo4g3efrjN/emjbVDV1+1eP+aAPU67vbNMZe3Yo3X+KoMA/3onimLzoMyILjO+QFTPDc96IjOoZrR0s4zTo5jw/ZMHKYCe238kw7UX8ZJTZ0m+nSk9NlIBXkaqtnfpz1U8snlUZvy/ljSEKIxq2JQAl+Ol6aHrIF1W03E/LS+OelcN3zzjTOysyvAxYmKFGuMUdfJ11q/wY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QUgr5w5pHkDbWdQunU23ocIiMwDyj4J9CJs0vJ+YFOExZwAz3RfF8Rtn/w1e?=
 =?us-ascii?Q?Y0sJUDFMEozyXoAIz7b6MXrOdFHe+RK9q5/7E+xsnrVbSyZ/NAJ6WOLkqYBM?=
 =?us-ascii?Q?4PpV5G1Saq4ttNaBS/j1xEnywKyNIGo0DYGvt6QUPQ+ZbwUzhygGV4g+D+bJ?=
 =?us-ascii?Q?ZleJp/DocZt/I2ttC2RzakABHq11Bvd3wF/DWcs7I7aQOwqXXkdy14DWv02R?=
 =?us-ascii?Q?DA/z9lq1Ci8k5J5vLMuXO8JYMTsoY9w3iQhN1U5YV2c3pKbLOW7PQOoLPcV2?=
 =?us-ascii?Q?ZDlVR6PaNo1NgwTzKKGcLIk5O8LdSJ/um+vZFLzsdaWFu64JT41QsN6+b0Gr?=
 =?us-ascii?Q?+KBCKQY46Kv3kqhENUUrGf7l5EBpBdCVy52Ribsu1l0BTb+i8qcQRTGhzsAo?=
 =?us-ascii?Q?9y05Hw1j2iZbXoW0gGZSnABfmekuZxgmXoTit50OccDtJxZBTwJkiCyXOKro?=
 =?us-ascii?Q?g+7UJYmwF63PsYHWW4vbggQV7p0NF+fF4BszPMEusFwfsMUnebqr1kqvYpZL?=
 =?us-ascii?Q?LTilomvvJBkubWfYXOdpSvedvOIZ/s8+PvPrlGtH+DqIVyc9+Z1qGZiFl4WG?=
 =?us-ascii?Q?G1Bm5AmpIfHL4+sBHR3SALyuMZzK5WCQ0OaVjHQ9cSIFbjlsRsCPtGpclCzI?=
 =?us-ascii?Q?NKOnhU13Iovx832vbH2U7FqjbPTMqd2/KrJymrZoBqx0KPA/JcRSGdD4/h0S?=
 =?us-ascii?Q?KsSw+/qSxEqJfxqDYUM6d5A+YhqPM+WDuk1zi6sr4R8JxlPsoXUJnGGr0x23?=
 =?us-ascii?Q?NhLhurBvBnZ/J0e+Cluw4/+1C26AjDqmsfyk83nXI/OfwYfQnM5DBi7svgYK?=
 =?us-ascii?Q?cnOEFGb+YX2zj+BBzSK7R4YlQsEHnYCITL4fnEQyGHT/p4bB819nBeKRVa29?=
 =?us-ascii?Q?hO33GzbQX3g+za/w/z8SoPD7thHVMb3v3d5+st0Z0MKrjr3tnEtRd1lyMpwH?=
 =?us-ascii?Q?P5fetal8IdnelZQcdnk0eoe73aseZQkZM9kQpUF5voDuBXlKTXJ/Mob8kZAB?=
 =?us-ascii?Q?OgG6Y2RU/GJijtHjvPaCIGgFqj1k+MvXmIEb+v9WMJJx6SlkiykxUlwEr6ZT?=
 =?us-ascii?Q?v5pRKr8t2b/W0RsCYbtbYiBTJ5ApVTOAUwQGAyIMLHfyiRBXOwHkkOFO0PGk?=
 =?us-ascii?Q?KETBsnrtIVjzJE3kOcKNUVAoo5L2y5M8R4+Obkckx6sm2XkDKpfubjguR89G?=
 =?us-ascii?Q?OkXMAzMHPAkpkllUCwqmoRG48CI+zygZ3AOWh64boknwQAVIg7GVJ4/whWm4?=
 =?us-ascii?Q?AjrMVFJ/7dagoOEC3cS0Rs5vrZEya4aCJmXKensHIwYnawJ6Y7b2rNGS3Q0W?=
 =?us-ascii?Q?BtCVvdQPFyyQcB+0I+ifLP54/GnZha33vDu1qv79AdzhTS6um87gBcW9XdQP?=
 =?us-ascii?Q?vvUJ2bUMDwMIEKtcxjUiVA0v1NSQxSzf0urG9Dh6btLqfx2ZFN4HTuIu3ouL?=
 =?us-ascii?Q?152OA9eGUWuxanO7jVaYAALxUH0oHtUVecRFV9zE15REv0fELB6K/Mm664Oc?=
 =?us-ascii?Q?FWtwj3/jnar2hqVEXuY+bdyBmTVHdpVJMd56ItYqOiDVD02bAFC+TjGh/lZa?=
 =?us-ascii?Q?qWDGlO0605y56a8/sU21kL92se3iL4FmMw0zvl5X2aOPvK9h040RI4UYAcRP?=
 =?us-ascii?Q?3PCPShKAY9SuZpwJWiT5tEzr+BnztZekuuIxwWaM5M9VLflRkMDpuR0JDEuv?=
 =?us-ascii?Q?9bjobVRzh3wsCJ11/vmPduk5f1eRFxomM3rU9h+U9QMgghnjU2wiKTC8WNUZ?=
 =?us-ascii?Q?7ay9R4lKqkkCCQYBPiJU01LDFvgkVdM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a82b123-37ae-4fdc-fc9e-08df2462a136
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 11:03:34.2028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwqK0HOU4vYMK8aXOuJPvk1FUkZFyA0UsogmU5QjdOWa0/G8k5tT33H6CYdqI+y1kf+Gv3ZANwgO0xWyDCxNdfyGTrGIVsNaZkB858RvO4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6996
X-Mailman-Approved-At: Wed, 07 Oct 2026 12:55:03 +0000
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

get_cpu_rev() reads the Cortex-A9 SCU configuration register even on
Cortex-A7 based i.MX6UL, i.MX6ULL and i.MX6ULZ SoCs, where the address
is reserved.

Read the SCU configuration only for the raw MX6DL and MX6Q IDs, which
need the core count to distinguish Solo, DualLite, Dual, Quad and Plus
variants. Other SoCs skip the access.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

 arch/arm/mach-imx/mx6/soc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mx6/soc.c b/arch/arm/mach-imx/mx6/soc.c
index 02df86156d4..824e8ca6d8a 100644
--- a/arch/arm/mach-imx/mx6/soc.c
+++ b/arch/arm/mach-imx/mx6/soc.c
@@ -71,15 +71,17 @@ u32 get_nr_cpus(void)
 u32 get_cpu_rev(void)
 {
 	struct anatop_regs *anatop = (struct anatop_regs *)ANATOP_BASE_ADDR;
+	struct scu_regs *scu = (struct scu_regs *)SCU_BASE_ADDR;
 	u32 reg = readl(&anatop->digprog_sololite);
 	u32 type = ((reg >> 16) & 0xff);
 	u32 major, cfg = 0;
 
 	if (type != MXC_CPU_MX6SL) {
 		reg = readl(&anatop->digprog);
-		struct scu_regs *scu = (struct scu_regs *)SCU_BASE_ADDR;
-		cfg = readl(&scu->config) & 3;
 		type = ((reg >> 16) & 0xff);
+		if (type == MXC_CPU_MX6DL || type == MXC_CPU_MX6Q)
+			cfg = readl(&scu->config) & 3;
+
 		if (type == MXC_CPU_MX6DL) {
 			if (!cfg)
 				type = MXC_CPU_MX6SOLO;
---
base-commit: 8d7bc8add17bbc69a58dfe0002eea039dd2dc1bc
branch: imx6ul

-- 
2.53.0

