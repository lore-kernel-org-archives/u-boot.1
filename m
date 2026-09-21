Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF55C982E1
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 11:26:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49F0780DB3;
	Mon, 21 Sep 2026 11:26:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FADXv1O2dxD7; Mon, 21 Sep 2026 11:26:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5853780D93
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789989994;
	b=ExyqY/WLR7GxZmW0+9gPg9arCcxhgiroTxbhbQg+jFxYTrWTy1ZeAu8vleZqRn7XP4IG
	 obifKq3ZfWAie234q9wljmYG205Chz1UOLMZ+tPul5n5UTFfeP897DBKNlTOW8oqTczH2
	 /d41Jb7CCssHGeMBlxnPUl3z61kMetSKwEWjueTFeUYDqSuBYGPJJ9U59Rcne7aLymKQU
	 H6/iAc3Y6+ilnuFrMCUGdY/9XtXo9GDYPHvWHEbSiUnmrIOsYuXERNyX1AuCxrTfQIX5M
	 cFFSvFXc4E3ygy7JuL+VLSXGHjN48yle9SaxKlyu8vdH384+Qg3l20eQxmKAS+xYJGw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789989994;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=DYBaXpMYA7FL117f2LN5LRQMuarTJ9bsCmIDnGHF4QY=;
	b=Nbe8x/jFTrrFHQYgeImvxDOQ2jSuXA+vKX6idffSrUcI34anWgQyfpdmSVpE6DasuO66
	 jDUNAK/iDs12OtXAjYaItwNBbgms86A5dKceE+feLwcn3AO5cLokn4oYYI4ZZYXHxuMu1
	 O1tB/abp+86N0PejFrjL4Rwti4QUUhky5I0gD8klQefKgvVrkAUkzGKe0qRZvITubsYFT
	 Q/IjuMvhY5xcxmyPHryMqz3OfPJfljv838fA57mznusuD+NoX6vpp6vGepPwgEE1SlPwM
	 NjKlBEiSJQylEOXBRqVB+8dpr8lvNhGO7K8GXd2SCuplOH1K2eVFecWjn+bwvEINRoA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789989994;
	bh=DYBaXpMYA7FL117f2LN5LRQMuarTJ9bsCmIDnGHF4QY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YGt6A0I6KybPe01xsrQ+ZM+S6jqYZj/ORbTM5cg09QqBW+uHk3dlpjFC7/JRCDgV8
	 4D4+yaMlcfgPRIL5NQYumtZ+oUbeFK7Vdpnt3FlIXL8IEtezqZvTsyL+ktmCrSEXKi
	 sUotpOAnVfQkVL0HeZkcsjFYLxZmjaMduh/4rFJYF4L1NmEmNbaq0C+DTuwKDUrkIw
	 JGkR7mNDKOjtGimA/c3lAZ77ptPt7hVLgLw/Jk9vdXccTj577mNpzg95bQiiPfgysi
	 Y87gx+c/7xSUOTspGYc/yTahV4X2hs1q8kz2zouAfsKmqPeJAJe5uAzPbg8eWm0ilM
	 68imuQ4lInmwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5853780D93;
	Mon, 21 Sep 2026 11:26:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BECB392
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 11:26:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5E18E40111
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 11:26:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GXlQCuqLHS76 for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 11:26:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 75EB94016D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789989989;
 b=gy7WdIelHfyW4HEzTvWnDfO+jRgCx7oV3PifOp4wxKNhK32/Fp//f38n3x+38jvjfkMK
 RzPCNOqM9HiYSMy1a8BwmRObHw3wY++mwckHFsBazk3imsDT8uuF6QLpIwfq2JL04M48V
 tke12JguTg5DsiFRae3c2AcVtgKw3uqFFFL6x/B5RraaK+r6OQVfNnGAiz3WLrjyCTtvZ
 fT5svDBrwRrUmP3sCz3lsJgoTp9E3WfOnPfqIudwOGgQyYVFHBJYdUUqcfLCSBZzgaa/w
 VNm5BkAm1w2yrhu1azWxR0qAsuBn0hiCM5ygoZvo3aXxpIVy/uhb4PEmqvlKKh4GFLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789989989;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=DYBaXpMYA7FL117f2LN5LRQMuarTJ9bsCmIDnGHF4QY=;
 b=ZU/nTSYi6gAJaCzXxpxK2HrLGi+ifqVgKF5zL3/82TggOpxAlYPjCJ3hM7XmkA5wGRPJ
 1Hl11FmL+1LLg5Fm9lr/cmMf2r4xiU0E4rHX1+KgtV+bNhnWQRJ9qBbsIT6A0cUPeQQrZ
 dmtElCrWDX93TQVu4GYZx+7gPUoYQI1ZKqK08NbudnHZA+L9YRumiHazUk0U2gBdCihTJ
 3Hgz88N1aBT5OuJ8QAWmKXI80dd3vyA/F08hi64oaiiyd9IVUIWUSCmijZdvh7DeQDjEK
 fZwlK2XGxFCwCMtnbVEY/Ujgo/rWM6PlncfFgRWQqgG5PLLklS7t2gmw+BhhSxYe9Xw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=prevas.dk; 
 dkim=pass header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=k5NQ3WF+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=k5NQ3WF+
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 75EB94016D
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 11:26:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T46A3/5saPQPEAFlCzMk+SGL4bU8maT8272D/49/iy9alNZ5dUi7egbIV6Yu7PC66n+Rx4YQ0+F4Jm481LkCSdBrCktYNcORh+feZkyRwBziOIFQf+xdygDD34rcIO3NsvMA7jR1juiUvH3JlY3vM0mshHIQj1388p+QXm79HhFEsyY9z7zCrie0Mb6zQnaZ3j4/nNL4IiL6bBd5hRbBmCRTERpOrr+c6FIxCpZBvO51+4qSg7eJ0dMxo8966bAfwxMlxAhhi4eimtiy2GyY7qK1hYjJ1JPZgtBJ5oPapUsJTQV/IR482dpyREUX1KYn18gzSosjWedpB41zgMCSEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYBaXpMYA7FL117f2LN5LRQMuarTJ9bsCmIDnGHF4QY=;
 b=pQyrJOXM2l94C0+Qq3BgR8kGC1SrJjzQXoDu5wyoH5pt7fISSdUHd/wlHIlMLHZRc0KVwWpMfCJO3dx36OX6qdmNOkmSmMEnBoyrCy5d7KaL0yf0diPt2qIsqDDYE7QGGinbaa5Ig3mdaOyjxZa1tEvx+Dk2cxjrHXgEuia/w84Y4DVQb9LMM2pO2yQPfevKr3pgkcGFC9UTpGnIK8DeKxoEso/c2q4xY/yFrxaem0SvGF2b5XSjpCO2/gq7jFY39oFTDyAnpdlY1R8xAgz0xH1twyMUp10wQjAnAI7xa99XYZ4qQcs9sWFJupFwfJsmeDfN4x2OcClttVgqfJzZHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYBaXpMYA7FL117f2LN5LRQMuarTJ9bsCmIDnGHF4QY=;
 b=k5NQ3WF+pDRCIZw5oDn/YK4kv5iSjG2WLNefbnEjqGtzULHKyIdr5fnXUJyxhZecqlDZnlZqTSa4cA8cWjKcmWxMAxEGymsOfH/JqU8d3+TQotTI8sVm3CzMDXwz2ULzUSp3lwSbDR3Q3WsmlYGWvMvZnPS8wdp9JVbqTfPt7bE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAVPR10MB6863.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:323::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:26:19 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:26:19 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v3 5/5] cmd: optee_rpmb: make it usable by scripts
Date: Mon, 21 Sep 2026 13:26:07 +0200
Message-ID: <20260921112607.1562189-6-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921112607.1562189-1-ravi@prevas.dk>
References: <20260921112607.1562189-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPAP307CA0012.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::11) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAVPR10MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 54827865-dd94-4e5d-d98c-08df17d32762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: lK5whW6SPMiIFzqEQyjxvnKL5zky0QQAPGKach3B515yJXdDbFJQ0Vz5VOW8ZQlA+JDfNgHD/CHZdwSG5Vxnw7sQ8Utt3wv9sog7T97wx9mPDmRImlZjffNdoxfkJZiDd9ia02nBV0CTaX2gxomkAjjKFAB4o619d1H30+J9BWm3tA7PT0wqnVpyCjdsSrdiLoz/YCKcJK2osXkjAbOIJKv4ZfguUN2A/MeROByP4q8GeZPZ23NvyMYqK2MEh57PdA/uTMK7RlDTkh4Yj3RZWwT1Dy2W+evfBUCk7j0NhHV7OwCC6aqvuR4YRD4tYXXDakRU3Q2xoHJc9Sgc0kE1qO+cv8jSGFN87Wx3wsgf9zjrdPuocsQOpHJ6DE697uZg1YSUpbM1hQ43IhH2KJ48Qt9qJYG+q/FQ855RjNnrCpfDHO+Ofh7P1fjzMIz/nygFJXDu8b84cNk+3MO9YZFPGlJFReKLLoggBGvMFQwOsZYOdkg4m9DiFaT2gibpws9lx7jHJvKnSn64DC+RV1hv5ztwclBO5gP8lKpYqtdwWEgM1TD/XFJ4yUkbi8lxhO9+s02JsmO/RVlJze3JuHa4ipv3gYxkPWYKorZP8s0FK1Vnxeuk9ohChs/37ntftuBMO8NgZFqPUaNxj7/A6a1ILFVKg2CZQ72tG/+OfxtZqOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3q0HJw/fyBE3AJ/MRyiF11Q5Nqu34zNZ1pLwpS5mSb6J1L7iue60mi2Vyk9r?=
 =?us-ascii?Q?ZNxE6xRfR4hbh3ZS9nqALD3K2yT5oGhrdv/ve0/V1w3gvM1XB41+v5pQx3GT?=
 =?us-ascii?Q?1QoKLQlClmshhwsNB7BAxNjA4zhxJ1fYY/XT1XmUr5/w30MDyuKBlBfQEgFy?=
 =?us-ascii?Q?ejItJZDc8FiaOu4PUzAY6mEy7BM1HLhIvUQ3VfbuTnsE/so2DdbKqPFAvgqj?=
 =?us-ascii?Q?mRKhrQRg/EHU6Z8QjFE8QHAP+HoS5cNuKjGv6nokhTisPcQa978Gp+NLaMGg?=
 =?us-ascii?Q?FTIJhDF4QJMUwwT8FdjCdBt+cOZpnkUNV2qSkdMrwC6VGZackhg3HLQoicPE?=
 =?us-ascii?Q?XWAg3punrrwA1wvVIHBUXnj7Ln0HmLwlSsrquxbJfKXGE713QujNB1t6/RGB?=
 =?us-ascii?Q?IQiCRpoxarqZOVuextkBMdPt06nIUZ8mi8co13vI6J/ElrM983F6BeWYveY0?=
 =?us-ascii?Q?tyWTPQ2EEx2uIQl2vIU/kLmCoBNgHXdJtKJh/hlaYdfd6huRLhHBcS8bm+Sq?=
 =?us-ascii?Q?8MOn4S/xonJp2W3BLOYezeCBvCFIUWdr515CUZ6gTQgQWiXAVC3Z10b0SwX7?=
 =?us-ascii?Q?oYO/4Ilif4WDAoFqSr8TBSYIWLLgjlrco6JATHuAfB24fk48wFYDS/cho6MZ?=
 =?us-ascii?Q?RSuxAUrr9vqOXdtqvR741u/dqLNfh2S0b3Yn2MXPEmBTzNQBRCOGQJjekdG4?=
 =?us-ascii?Q?BM0BeTRfGazbQcJiOsdXHQdng4VqdHUzsyEuxLO/IvygBLOPaZSyQnU7IfTl?=
 =?us-ascii?Q?JUcunJMn0JPrQtDdFuAN2FCd+wiO1tUhjP5ir7Awi4pbd7s+K/UNctfPxH0y?=
 =?us-ascii?Q?THTQal6vPdAA9sJMWgQXFZAR7pY1grvvaRu0XJT+kdn2V7Hjew8vcEnSjJjB?=
 =?us-ascii?Q?JiJgSQa2QyKGq1ecMAVuBnPn5iAkqQYrO81QqzD5gN7Ckm0aCk7XmwQymgBs?=
 =?us-ascii?Q?h8Y3D0WdLd5++OyzbQuB8eSPLMRNcx3OUaw2H2DcE66iTHjLZjb6wN8Skvq1?=
 =?us-ascii?Q?NCQ/pFq1HjHaezhk8TQKcEjPYrvPd6fDwfEKLElvjN4UBQWTOR2PSTo4syE+?=
 =?us-ascii?Q?kzfu99btFTJZJ+LEjMLjDypSwi7Du51XQB6Ix+IZCDltXRtZIafUFdiHca+m?=
 =?us-ascii?Q?p27xuD3l0mghYsSBHnxs6xIMIq0Q22D/E88EguIvyCZeDP+wcFOzhcoBvUSF?=
 =?us-ascii?Q?stWq9MQYkpF1J6ynJqPC1shMMfpW+PG3csVQ4COlh0SPTGYz4sO3qPqXTrol?=
 =?us-ascii?Q?+eCrB7Ln2VgrrnmV11ZYjF+LBFXnQhAcrdJ3uRqbok9lu5u3FYpDUaXk8ON7?=
 =?us-ascii?Q?d55yflYYTEDoty8jHLFqWuJ50T5E6IXP/TSsIwC0WJ/+YWiVx7wulfTG9IzZ?=
 =?us-ascii?Q?gRIqj9yr3kkkoDH7fq5nb4nPguB+3+IHHbZoyHt2WOmCSHQZ6EQ8IsUHKZNe?=
 =?us-ascii?Q?m/26THsVOqkqqMgBdC7lWgTHQKY7fxdUr3nYJLq2lHwQz/ZGCJsIAO1unD3S?=
 =?us-ascii?Q?i3c5H73Wao9nWohiFrvnje+QdFFqg6l79gWn3OV4ypV5ur1b90l0xF1Dhj8k?=
 =?us-ascii?Q?mHO+56fAhJklM3ib0qm/TKXtXotLDIFcjGz6Y8b+hZ1/L4Qp8tlG94AgovCT?=
 =?us-ascii?Q?XVK0S97IXragvuI2LRXX0csHzjsfxG4UwSZyIKppsWaK4wInz/8ELAkIllQS?=
 =?us-ascii?Q?6Cf2gddoAWnNNB+vzpKT2kCLCJxZaBOrjUjry5dHOWQYaQjpJEEXrb5rK095?=
 =?us-ascii?Q?zt5vN/eQ3hoOle9CBV7mbLzRoRcJfdI=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 54827865-dd94-4e5d-d98c-08df17d32762
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:26:17.7534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gU2MN83Nd8u5xoJctIxftP0e+0y956jBcsGotmCTrLJogEwdYUxkzvT9ojL2Py9OwltKJs7ErvhDc8TksVhSBDJXnGxDs0jRSAtW5Iifk0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6863
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

Currently, there is no way to programmatically fetch a persistent
value and use the result in the boot logic - the read_pvalue
subcommand always just prints the result to the console.

Since the "bytes" argument is now redundant and optional, we can
repurpose it: If given, instead of printing the result, the value is
stored in the U-Boot environment variable by that name. We do continue
to accept a numeric argument (i.e. anything beginning with a digit)
and use that as a size hint, but don't document that.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 cmd/optee_rpmb.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/cmd/optee_rpmb.c b/cmd/optee_rpmb.c
index 6f6c70ac084..06633758673 100644
--- a/cmd/optee_rpmb.c
+++ b/cmd/optee_rpmb.c
@@ -7,6 +7,7 @@
 #include <env.h>
 #include <errno.h>
 #include <image.h>
+#include <linux/ctype.h>
 #include <malloc.h>
 #include <mmc.h>
 #include <tee.h>
@@ -213,22 +214,36 @@ int do_optee_rpmb_read(struct cmd_tbl *cmdtp, int flag, int argc,
 	size_t bytes_read;
 	char *buffer = NULL;
 	size_t bytes = 64; /* Probably enough for most cases to not require two roundtrips. */
+	const char *varname = NULL;
 	char *endp;
 
-	/* Use a third argument merely as a size hint. */
 	if (argc < 2 || argc > 3)
 		return CMD_RET_USAGE;
 
 	name = argv[1];
 	if (argc >= 3) {
-		bytes = dectoul(argv[2], &endp);
-		if (*endp && *endp != '\n')
-			return CMD_RET_USAGE;
+		/*
+		 * For backward compatibility, a numerical third
+		 * argument is accepted, but merely treated as a size
+		 * hint. A non-numerical argument is the name of an
+		 * environment variable to store the value into.
+		 */
+		if (isdigit(argv[2][0])) {
+			bytes = dectoul(argv[2], &endp);
+			if (*endp && *endp != '\n')
+				return CMD_RET_USAGE;
+		} else {
+			varname = argv[2];
+		}
 	}
 
 	if (read_persistent_value(name, bytes, &buffer, &bytes_read) == 0) {
-		printf("Read %zu bytes, value = %s\n", bytes_read,
-		       (char *)buffer);
+		if (varname) {
+			env_set(varname, buffer);
+		} else {
+			printf("Read %zu bytes, value = %s\n", bytes_read,
+			       (char *)buffer);
+		}
 		free(buffer);
 		return CMD_RET_SUCCESS;
 	}
@@ -289,7 +304,7 @@ static int do_optee_rpmb(struct cmd_tbl *cmdtp, int flag, int argc,
 
 U_BOOT_CMD (
 	optee_rpmb, 29, 0, do_optee_rpmb,
-	"Provides commands for testing secure storage on RPMB on OPTEE",
-	"read_pvalue <name> <bytes> - read a persistent value <name>\n"
+	"Provides commands for accessing secure storage on RPMB on OPTEE",
+	"read_pvalue <name> [<varname>] - read a persistent value <name> [store it to env var <varname>]\n"
 	"optee_rpmb write_pvalue <name> <value> - write a persistent value <name>\n"
 	);
-- 
2.55.0

