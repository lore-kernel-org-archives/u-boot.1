Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBF7CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 14:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15FF060634;
	Sun, 11 Oct 2026 14:39:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9QKcaX1kDgFc; Sun, 11 Oct 2026 14:39:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2A3D5605F9
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791729566;
	b=mIiLd14959S4zDT1ZicuxlfjgCtZBnkkqCLr2pL30DIH1SatPWoenjEtvjDlt2K6RJp8
	 OakVW/ePdigNwFNeFeukGHpiwmoyYTiD/qJT4W+7U5p8BvqUDdST4nZAL48dxk8MOefFA
	 cydWjGjatIIbIFFtc2tuzZqf83fXnEcoyeJvQ2EH0hiwlvkXk1qITMd+oKDbr/oYwaCa1
	 0A6UJfajW1bFxcWzYQ8b47Nli6CNKGLIRMcf0GNwI23xhJLCsARftPolT7s9cYLAK+L8T
	 XmImnM/bU5ojMhKp3k703ejhC6l087N4kfoYQqUmY6DdGskKLd88tl/8L8J2HDaKXwA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791729566;
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
	bh=1kbyMMidgWZ8/IDVWFHqyMivrImlUPKUQ+HlO8bdsy4=;
	b=sXp1cVNmo8RRY25Zq7ehqg6tSQeRnP56iaKgseILan/50NaTbsylLx+MIrwm5oCOQgVY
	 ykkcxaE8BGJKd9qbcli0yeg5UrzU18mOc6MBoTSUxMW3bVyZ1o8KV/cV+D53ODKjcziDf
	 czqg/kxdE01PcUOcnIbb8Rojc8SizvQy1l6Cx+BJ3Ejbty/Jy/3BZD0/chp9t8tb+vsWl
	 qjQOTNGpUGF90QiYI317s435FChe/apnB1TqRN2U96W52Op7Rt8ZL+U8hYyf4RfUjSTCK
	 NrxiatyfCNCVxHGlb+Q3JRJGWfKnEmMMvYMxvJr0W9R1dNaS9Sb2Y4Dq+c5XNzFwtOw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791729566;
	bh=1kbyMMidgWZ8/IDVWFHqyMivrImlUPKUQ+HlO8bdsy4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rmYGDAe3PsHDsMJ7wMwo2m19whouiPRAzKjC31ZjsWIrOB9h7rbt6AunoV8hBBnqw
	 jNyuZmDqPOZf1Bh5yAlCaF7p65YM9mOM4hoXCbc91lHBesMT7S23H9r4XxEmpRg4x9
	 WQdKV8o9b7+ZVFI65nkb1sCPICyUNn00ZjphnQ28VUqwsRQ6AZFgtDiOvYEAUyAQ49
	 fW4DdMsm+CyP11ERm84OQW64DkoVaSVmkftTEw9t97Ls7vLBd/3nboIi1lSvSuxvBg
	 lVtKXZfayhvsAoRT8w65VCD/kdoS29lCCMHzW38SdGn3p63ExFKppuOHEszs+UWCB/
	 td8xnc1KPC4/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A3D5605F9;
	Sun, 11 Oct 2026 14:39:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 542AC9DF
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 07:06:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3929C4079D
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 07:06:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C4n6uIDOTTTt for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 07:06:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E8ACA40765
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c40f::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791702384;
 b=fAfEETwS9C5cCZ/+RPGOQofsp+sK7dYQp62PKG/RkkRZ0pE7o1rwsXGrxO01frPqn5Wr
 fENI4rEmJPiPnOAjeKrl4xjad56l1BMkbz6vP2FHInQ3DjJy+7rZhz4OGtbERKHjNw5rj
 qDbfPD/ezp2Y0WrjpUonC00tWnMAROojTyq/B1M94i1DMms7hY2ko6SkqNdSZgTCRABD/
 NfoF1/y6k0ZkpmL2CrKp/z/a7ma+BI+GLxgZaN51E6hmEoHNL8cksMcy4fQ40pQEQ/Lcq
 9ZYHzYPpZPLaEUCFQMT309hlnWuiUgXRNaiUwiSj342ETn661zVSST1KnVPPrp5W6Mg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791702384;
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
 bh=1kbyMMidgWZ8/IDVWFHqyMivrImlUPKUQ+HlO8bdsy4=;
 b=szkga9gI03OLur26uJLC1Zhv4gBVi/9VIWg0YPxShucHW+lhk2ISuGvLjjqPyxIGoECa
 +U+PVpAMpDiYOoFtSLlog0Kpqzrshg4hkpyZSTJiIZBZsSvfCY3Cc/fdUgyawHSlYEe3X
 wdjS6CGzkRQSdSU9R+UXCdsqwKW2D59KOZLj6M2W/78dhOGlB5BCimpa8qN6HmdWE9dPc
 H82K2E+aGs0NVuCZlSmNtKVTnQlRhabpNingYMRywZ2CpQY5DtTp9kfj7XAEHtBUBuuWM
 1oJab2jGq5piBKet3DPsjdkaV9xtWemicMfQJddJdLSELC3Qz7Ku6YrsBoJBwVGi1Mw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=processmission.com;
 dkim=pass header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=CZ8VD6YA; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c40f::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c40f::6;
 helo=seypr02cu001.outbound.protection.outlook.com;
 envelope-from=bin.meng@processmission.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=processmission.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=CZ8VD6YA
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40f::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E8ACA40765
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 07:06:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GiILRET9iZDpL6i5sgvPWk/IcGc0DnC9iYtrxgrIK5klVQ2lVORZGhCOubRvP0cH+jRUCoJkieZHB6XlXdkMhdug2X2UzV4Hxpk8BxqP+e9gTyQOqxAf77V3T0zywjoZ5yeQxPm4lxtHLGZeBac2dL+TaX71W/2Xd3USYQWXkEBaR01JTbn07pnRxo7HHXIEP/Rieg9DWFP9/jutA3nSAi+AjqqEWXUDPvoFaOGEpTM7s/lO840Vd3ORuIyHSMp+d6mCmW7DJTcxxccClPEEa3yXkdTi2S1XRbKyxwHPclnKyZVxvcvfAz+c46Gahksr15ev8Ao3Zy8C4JqhjJWs3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kbyMMidgWZ8/IDVWFHqyMivrImlUPKUQ+HlO8bdsy4=;
 b=wUX/y8XmJ1TKqzqLqIy4OpQWL0Idw42fF9IbvYDJ6M1gKxc5sbrSQB/ObE1yuYmtURWmL7kp0SLdhA0CJvSdfSYVeAz9BGlsTOlrJQ6+VQRr8s1mr7iPPocCe0erCM6m0OEP9PI25Vmb8ONKaDijSCa3z6JNsmqXRbzxZNjnQBptArjB/qCoMBsIluCYh2cIS/tMozP3KvJy0fd1KhapPMtZwyUb+h7PjflixIoDL0WDraAsl2Wt7D6t6iShDYu8U/uR3VR+FR9TG54M+C2DsWxsnTDl/VnSsbftMS1OvXolCWHnN+h2RT++ynyFkr4ATyMrCNa9eUvhpe5V/zjbWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kbyMMidgWZ8/IDVWFHqyMivrImlUPKUQ+HlO8bdsy4=;
 b=CZ8VD6YAVDxABCIuPkj5A8qSZFX5lpH6JjAmJL9rsK8rx7MrWQkzNWQ5u2mDWNxfD+at8cLPIi8qMrypIyzI3nhQRNmgu08CaNXkNrIWmyfs1izjHeUdPsM3gITd3gtaOnOkesT3qaAWMzzOqtRF2aKEBtsfrY9nI7fazb+dVPymXvwWxs/oidmQVlmDmpOygijrShqqN9PwOJC9+JzJ8nEcoRXAg44JmlWv2dEmwM+/MuIuYAAyeqeOH769yW05N3c9/RdcanUo/vl5qd/9GW4irBAxGQnT2yjlQqnw9yQ2ofhka8DIHmN++PObNxKY6LoBLtDK5xHSrShLr9UNzw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYZPR02MB7113.apcprd02.prod.outlook.com (2603:1096:405:2c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 07:06:17 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 07:06:16 +0000
From: Bin Meng <bin.meng@processmission.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] x86: cpu: Use native_cpuid() in cpuid_ext()
Date: Sun, 11 Oct 2026 15:05:58 +0800
Message-ID: <20261011070600.2788775-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0076.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::10) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYZPR02MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ac2739-2e55-4321-3fd5-08df2766247f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|3023799007|261009223027099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: ZvIEqNkjuQZxDOmt5V6AcXbUgOwTFp30V7jC0mEMfSmg9jNM8fKhfCjzqcHD9HzNSEbdssbOSY6WhGdjBbuHecRDG1mqgEszaJClutWXvR9NNouYiCMoKpE/ylSdrgJuFA2IOQn8/WtI01hSQUIeiqIUGZXQe+w4kmtixuMbPQ1mgBxGEisQNZvEqmOAyvgIyWckSy6jee1DSBhkbn0ElGUmI96rN6KsQWLWrO+ifDPz9fti40SNJ+UU1u+ONG5C0q0kX+1TtSSSkXWKLQFXsvpo30QajHT1hxu5/4uC1DaNDoZ17WPUGZ2Uf8eKR3FiXuJl9ocE47kKzpn46nCHziG1uHEdkaQUP3A9HLHLsZ/L4n7cD1IT5zuXiTG+ntLJL1+Ihj8cNJnQYEs4NrN4IVp29FnLzQ3z/OIuyZV8hG2aYT4obp9NlvcOOGKzfSdOXZF3M8EkAoHbDGsAlwXtNATShGjiGkr2PTk1YgJReENK1qvSew28AURNHq7I0qnlzCT7yyAHSNas4G5gQFnCsNQxC+QE/+7TEpWzVJ5fHHOOsHv6W7+/1TTpwGZObbpcHHKPULU1buiTIxfr8VF6WnH5KajSEr/rOJe5b5DZCDOoyoq/JuscTKktn3DW/V9IwW6+1ixUB69fxqGxSZ62PY454obJadmf9gHyUz/b84A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(3023799007)(261009223027099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ThUg8nKR3kzLI5KGuc0bv5DZemsx0fYGS7SGilH03CQjcAz19kg6bkIvC2RY?=
 =?us-ascii?Q?U+PsDVdRbRaqJZ2hQCKuF8GjxTIL1MwKjjX8Hq82cBS1z0TtO3cSuvxQ2x+l?=
 =?us-ascii?Q?xcOvLsjKSkk1ZRac6PFg/LlMGD5L63LjAQ8sp0+HQzfxC+DuElNEYQX5IAh4?=
 =?us-ascii?Q?BspGW0pHr8X62I5r+BH1xMccZ1P+wQjLBqRLCdhtCqSK6RvUh38Ms+K8I4cW?=
 =?us-ascii?Q?Z/y3l6OpJAs1zii/niX8ywnTYFg8cssVGxxH1JYeIPEV3AaSGbnfmT8xfveU?=
 =?us-ascii?Q?eLPMU+hMacjwy0qL+fZ/wnpfq/V65gWdFxfybHt1tVgmpYgbiw7qYbwad+Eo?=
 =?us-ascii?Q?1uLR9+O1lZ922zzfY1O4ckBTsISrqAmSC+asFhXV5JTTilNjHgqDO3Qy9J0g?=
 =?us-ascii?Q?a4UckFlbdG8WwgvfuN4MbnotuCNPDQPLFHX3giQi5UbhKHfbQkuoISqRnOe2?=
 =?us-ascii?Q?rnZBZtgSgj7Y/S2K1w31mNFYTqKbu/4XqUWzMNCSmHShs41Z5tEYHhl2A/tj?=
 =?us-ascii?Q?MZEyndH2EbUHyslKYvbjMoZP0Bsv/GKE5+rv1kXNjVmDI8nsG3//YFncpjFe?=
 =?us-ascii?Q?ATMsTqTwHtBR5EnjmMs0Ji/gqvyN4Dg9QiPwr0hC4m+FZWyerVStVIh/tZz6?=
 =?us-ascii?Q?HsYjPgyeJgJ1L79znjD8Hb8wTMJEbM9iY+u+NSAG99QRwYcCj2w1gI9sBKQb?=
 =?us-ascii?Q?gRHzGIB5/aMPKQlhM6dWWAXgQC3j/EK+OHihzNNba7sQjZFRxo8qQMrpKypl?=
 =?us-ascii?Q?CtPowYqLz91Y32vMBtaS2ifkFVjKq5u9bg0JFuIjg1m/fhDioJmPHq8FbGhb?=
 =?us-ascii?Q?aGuLWOwDHqcqvejZ8BnOBs1f5FoboAusOrSIziJTolDRSdww7zOVdyOUEQps?=
 =?us-ascii?Q?ex+TjZoi0ZUMQ9Fqb1cttmbsG08jqtHSw+dB8f6I1dD2JGo9GIBqBQo1xiy/?=
 =?us-ascii?Q?DoLbID+2P0LzJsvzz03Jb4zK/g20NddpOXMXwaa+VaAxpCBYO8K/wJ2zhXU3?=
 =?us-ascii?Q?DcuG9UbMX5gqinbJN4bQ7Ic3HMtepicz07UR9U0jWR9smhgKP9iAoDeusCBO?=
 =?us-ascii?Q?z/osC1SJd+Ua99mPiWqDFdikvTU7UdynC3dce8C/Vxq0xJChLul9wtbWDaNo?=
 =?us-ascii?Q?cvqGgGuR/BTDcaBsmzy3GsvJg/4QuS7q1I9H48qd3lQI9CAo7fu3TR/s++Gh?=
 =?us-ascii?Q?EJyijL0ezHLC4BKR5KYOgiEN/cV9yhSU7xOY/EB0urZEu533AekDzEQ0Ibci?=
 =?us-ascii?Q?nAiW7BpWeIUoaipr+SKxzCwTtMvwrTnTuJbGqMuzJfW7LGHhlQG2hqzWTX/b?=
 =?us-ascii?Q?uzSYudTLKhUEPR9CaMLKIa70mA8au0qn9ZJM/D9YaanF+cMA7TL4QVfsCO3i?=
 =?us-ascii?Q?0JbI1ijDpSDYV4cHfcmVQatuwTO+GTxr5F0DA5RJhoS+3u2A0fWFio+vMjIw?=
 =?us-ascii?Q?nxu1iU+d4s05Up1jBgHeOmKtcPzI+WSUBmaxlddjLayTRABA1yB7PTsKJRr2?=
 =?us-ascii?Q?4KZrB9+fMTmtY9tDSMH/jqMfXydFFRJ1fwVIDz4JYVT8KerHBKHx9P2Lf7Ex?=
 =?us-ascii?Q?aN9DzeajoQ54HZpzvdlaGDbLwcgZtybBH89Fo6RWTIreqoUlHRlND+7WyVpF?=
 =?us-ascii?Q?DauJj76gNiJgmE1I106gAkFrPcJPJ66AXjvg0JBmErHyas36LgOFqHu2brSx?=
 =?us-ascii?Q?A1l9X5qh5OcQvLXM3T1Vec/KbrNFeckOj9EgXe3l7H6CQB0p9qyXwqR0XnLI?=
 =?us-ascii?Q?FO8vC036ApBe47uS0Ps8NHPPD2rHgTE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ac2739-2e55-4321-3fd5-08df2766247f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 07:06:16.4340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWd8aNY5n1DmA9kMjEJcR5MpNtTKtLQNRLW28/1a3wEI7+QLCsUnxIOXtttfdWj5dZVeeop+Nv0cfBhRmzkl8fIfRMkgXy8aa4615uLRaAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7113
X-Mailman-Approved-At: Sun, 11 Oct 2026 14:39:24 +0000
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

cpuid_ext() saves and restores EBX with 32-bit moves, which clear the
upper half of RBX in long mode. The assembly does not declare RBX as
an output, so the compiler cannot account for this change.

Initialize the leaf and subleaf in cpuid_result and use native_cpuid(),
which declares all four output registers and lets the compiler preserve
RBX correctly. Keep the structure-returning interface for callers.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 arch/x86/include/asm/cpu.h | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 1217cebb9b9..a28bc75def6 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -89,26 +89,6 @@ static inline struct cpuid_result cpuid(int op)
 	return result;
 }
 
-/*
- * Generic Extended CPUID function
- */
-static inline struct cpuid_result cpuid_ext(int op, unsigned ecx)
-{
-	struct cpuid_result result;
-	asm volatile(
-		"mov %%ebx, %%edi;"
-		"cpuid;"
-		"mov %%ebx, %%esi;"
-		"mov %%edi, %%ebx;"
-		: "=a" (result.eax),
-		  "=S" (result.ebx),
-		  "=c" (result.ecx),
-		  "=d" (result.edx)
-		: "0" (op), "2" (ecx)
-		: "edi");
-	return result;
-}
-
 static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
 				unsigned int *ecx, unsigned int *edx)
 {
@@ -122,6 +102,21 @@ static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
 	    : "memory");
 }
 
+/*
+ * Generic Extended CPUID function
+ */
+static inline struct cpuid_result cpuid_ext(int op, unsigned int ecx)
+{
+	struct cpuid_result result = {
+		.eax = op,
+		.ecx = ecx,
+	};
+
+	native_cpuid(&result.eax, &result.ebx, &result.ecx, &result.edx);
+
+	return result;
+}
+
 #define native_cpuid_reg(reg)					\
 static inline unsigned int cpuid_##reg(unsigned int op)	\
 {								\
---
base-commit: 5e3b01c8466dbe45cd6a06299f8f4c7e8c1c2363
branch: cpuid

-- 
2.53.0

