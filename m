Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BE1606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 02:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eJaqixQ8;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=ebiAIgvo
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8259D40566;
	Tue, 27 Oct 2026 02:09:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SSi0sv1dBFls; Tue, 27 Oct 2026 02:09:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 63FA340522
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793066959;
	b=mbXr1FWikXQEMqpfBvTWSGOvNLDVC1ZFvP+DWvhc7g/hbZm0/88b8owCFJ9qEqYOCt/h
	 mff4N2tqHmJFuPnqdb5kGlc9wVvPgsT49bbqYKSBpfM613o6kDB3TLmdkh6CiHNsDJTjv
	 7HcQO5nYO6OOB6FdQ0rqH8BK6hHnzmsUPZd+5BxGjivaYRnqa+RfHiNg+o7n6ucu9QVf+
	 6W9o8D1k9Rc9t4zqw2PHwM5L8B2Lgw5p6Nnw5E5/tV41nxr6YlsqmYC7pkg9VOqpLmFgJ
	 rvzBtPc2r2cQFfsbcX9dlSLWnA/Uius+JGwUnJm6ojDSlZrj1DG8o5Dof/aZ1TyR3Tg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793066959;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=RhqfTaDtoKvd8bs4fYV/ywB+g3NHzTzcJRK9TRiySPQ=;
	b=BW+j+1I4wtLRNARpwRGYl1bgMq911dVwVkU1K1rffIW+HvtbILP4BxotBElrBBtNGaCR
	 9Q/gDn/n8FXzUjdwMbL1n/KcV1yIhVrhvs8GfrGMLCP8S5RL0bKFfU+dhOtAxg3TQCupR
	 PeD8vOXGZL40vSs8gaxnbyBAQOy6No8Y3Jb2ZFqdkIcuAwSa1Zn+T/K6/zK5uxp09NzTR
	 VHLpiCDQDoNKQng5S+QWBveYsi7ZSoDHf+qAT/C5x24D7NIpykJrkR4Jl5U8dPbWY/H60
	 9TxbNsbuQMasJjPbVn0WWABN7XRwqYeQksQGgyMs0DHAKz3PFDnOIxFlgTecSoVyM5A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793066959;
	bh=RhqfTaDtoKvd8bs4fYV/ywB+g3NHzTzcJRK9TRiySPQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eJaqixQ8NBByUOv3WlCKl13vZzwu4/Abb7RQXqFclbAuUdIhoZGF8gNftBqteZsKc
	 stnxHJUGv6R7+Tvl21Gj6R6ssYX1OQ3xPPqRKbie8V2Vf2Rdt0GsFDgupKzPEs6gGW
	 g5j3bQ2IP8ySV2tHRfKe3hlxuTgFFEEnSSfFELdj5K0lQNC/0CcYvt4xjy1NbGVoV9
	 C6opmPHi9ZNWMkqaklJWe7+YGehq7lvSkqtdyCh7qhcT6Y/bYU7jn9i8ZA/Ri/MXJA
	 A9erHVHx2Zwq/A+QmdwvW1wnncMPxiqcvzaPE/QMdDQanKjQ/KvMdq65cWXkiYuYJu
	 k6UkymgAE2f9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63FA340522;
	Tue, 27 Oct 2026 02:09:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 09B012F5
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 02:09:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E317F80B89
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 02:09:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LUs91kLig-Zh for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 02:09:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 763BB80B7D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793066956;
 b=UYS7bIu5teRlq+6Gz4yE39vri8qs/nT9/fsSiUluKKhphDXBKnF1rsBrCtDr3xZix5GU
 Hq6ApnbcB0a3Tt4TSfSIXJvQvAQojlTO8JORLH7a1QYa9dGPxZAPRZuJIf2cK0PnUhmxs
 9PYhOkJnrbhGG/nIy9Xhm91GwQtt2BCCsWbtiJ2fVSVlmZ0vmsmsl9c220pYlczR8LNy2
 lksPRwdQ00Ip2U7Q+I5kkG6sqLX5R546JT6EAB/J+HTMRTjoJJi/COKcpjvey3TTmo0UL
 e21N0z9uEKl2tUBbEw6XKiiJ6p5Y1uJ5MWSO+q44CKsxF4EibfhCzxnrI4V5dh+ZThg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793066956;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
 X-Virus-Status;
 bh=RhqfTaDtoKvd8bs4fYV/ywB+g3NHzTzcJRK9TRiySPQ=;
 b=BH0xRh79V0p/cE5xDFK/SSTFBDvYdVzXf0t4Y+KomQ2+bgm0MZQaBCO020ZgzKHrHvZS
 jvX4OSdjJCfNrnlIVPEYKf6oUy0awlS0yw25dGXAI3nnwN92Kor4jLTd0rtF5FB0xsx8N
 7FJQ+nExAfrgFCaJ2TZUVleLC1j/MpSRnMwM/vmW3FWeFrR0Nzsf83+D9G8sLSaZMI1xi
 1OW3vCCnN7YwdXEPLl8Dh4epcZat+tefeZH/fH9sMDAoVJV5F7JG1KkxN2B6S61gjGMMg
 tRsn7TPdCauI+sl0x9H93i4UupppOpab65ikNj2Abj5UDOIZnB2h40VO511xLqoKKjA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=ebiAIgvo; 
 arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=alif.zakuan.yuslaimi@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=ebiAIgvo
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 763BB80B7D
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 02:09:13 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9172840D8; Tue, 27 Oct 2026 03:09:10 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0381D83108
 for <u-boot@lists.denx.de>; Tue, 27 Oct 2026 03:09:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8rdAFXUgQRy45SvAVkEl4uuhBCyxB4pii7FIOkNnLpOpEHxgyzhLdGrWt+fAT7mLpqNYTnirZJmGlvndXZrDMOVYteKylU7bWU6hGJpjTPjwKZ5LFT91iOUu6eRxc1b2lxVoW2Wu65Mz6FJreGHHrwDexL1jEvu/5JOx89U+DU1utkxq8mZZZV7CvHult2bSQM0Tz0vl4VUHVyvdxW1LyYD5d1q5chOylAcu8rHm2vBhIiNEp/1fApnxz6XkYl/fV6EyHqsRKH8jiKTQK12HHJbsX2ESTMbSmKpDoBdvHym9zwzufcUSnsq/2gg16KRb2bidrwhBAXURsezUDhNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhqfTaDtoKvd8bs4fYV/ywB+g3NHzTzcJRK9TRiySPQ=;
 b=pIH+TIB3bS/He33cG/QNjtnv1cUvcysR8c6+78kEY2ZaUr94WCpgPIqXJycAFIRZUeY/6m1AAaIPi/ceao9Dd270kHxFm3lSFBsApmShkMSLLvK4Ev0A/iHAkTRJk+aKogPmhhXs8AGeiWWaw3Js70BpvAajFDz1SXLOC0MSzTz2WCTyHO4cq0sut5pobRE/veJH04S1TcJuuTackZIgiIy4Yw/l5CtmC9127DLBwfwmaWCSDb2O/86HVVAChwgmZWmJEx3iZVywzrt9a6TFP7ij2PbhanrQhjWMEySdgLbgH5iOm9V+8dIve+Z7XPNRiKBcRNABNrV86XQZ5OXDbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhqfTaDtoKvd8bs4fYV/ywB+g3NHzTzcJRK9TRiySPQ=;
 b=ebiAIgvosGyd3uTzLQwkbmEZoSDwd9SaJUEMA/kZFzLZYzQVyrSPwV+gskeRjlP+PCsrGq/MyRTj6Pu6EWSOkrLSXXVIbXhUFBR6GZZnDakPuipqaFrAsKOt0WhS3wedbhA8UK+743DU+nM28LdByDjmZvywKLrJ96IBPcDAm1oHhuPCY2hoE1/coZPfyv65jgdYyZBPJYzvYn2yczdA0dSpnLnVpwCagQ+AarcLR2hHjmJ+JzOOyBgRPk9Usdf1SiIWqqWXpYH/OpNiSbxAdLCBDe4hbhD0bTzn5G1oOuJmdZMbYXLXMGOSyVEn4K5xbDjX7ROu8FSKmofaNbGkDQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA1PR03MB7029.namprd03.prod.outlook.com (2603:10b6:806:334::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 02:08:58 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0522.013; Tue, 27 Oct 2026
 02:08:58 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Bitao Dai <btdai@terasic.com.cn>, Shi Lin Teoh <shi.lin.teoh@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v2] arm: dts: socfpga: Add Terasic DE-25 Nano Board Support
Date: Tue, 27 Oct 2026 10:08:43 +0800
Message-ID: <20261027020843.20406-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:a03:333::21) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA1PR03MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: e1318b19-6519-4026-7301-08df33cf42aa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|261026121527099003|11063799006|56012099006|261009220027099003|261009223027099003|261021121427099003|261009223327099003|261022105027099003|261022115727099003|261022113327099003|261009221227099003|261022075727099003|261021123027099003|10067099003|261009221727099003|55112099003|18002099003|6133799003|13003099007|261026140227099003;
X-Microsoft-Antispam-Message-Info: Lf5r/Du1x/CuSnxYO4zHTZdfT5/gtEpJweetaD3NIDxHY402FPep1+p5/S7gbJ1S4uf8A0Nfvptyh/LYQBKCz3CdT+LAUPocClh+dANCsd4NmH310OpfQyr3sP1FGqRsUfgFzwkPWzy53b4CjKv3zSz07YfYQD5uQHMvSqOxVwqmaYQyZNBaSgillvJXN095xKwZIHLzCEdjCN+T1PKq9BD0fCsFH0RofdPicnU3D9kw5xIuAGs4MNc+1rIPpi5vuy95yYkDHVsUp9QvvV35K4sdmFhDJzCh/4Dm9ruqUCQvUmd1tzf1shbfRbgakTirBX5l9ylUSkTul90B1wNJREP9l5hJoOdDRXKzCV4SOISsmByVtXnev5GVIg111huGsK0Zm0XqRngZc7B31o1peG8fl5+8HUncN0G8E0c0AdcC2c27g/VqzRru5OUeR+T8S59sHqf9PQ3iH8ZH8gx/iqC93AsUturJOYM2b0ahkgISO50ldtVxP2W7xph8cd0tB44uTv3lr91N0YQh/AkruU0kEIQC9BIGIBGLG0KVKhOnt5e+wMAvrMQx+nllQWfmHIEdP5jOMGX8ZHAEUfRAZhP1aQatHhiicFp3yCKJkVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261026121527099003)(11063799006)(56012099006)(261009220027099003)(261009223027099003)(261021121427099003)(261009223327099003)(261022105027099003)(261022115727099003)(261022113327099003)(261009221227099003)(261022075727099003)(261021123027099003)(10067099003)(261009221727099003)(55112099003)(18002099003)(6133799003)(13003099007)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bsPnsBOV1cqL09bZinpgh4XdME0iIT/uD9ibCO/0xo2x61Cbe1GZRu9obC8L?=
 =?us-ascii?Q?KvPSa+Wvb8J8tSL0Y9wLFMIbtyaDqk0QioGbj1nUQ5gscssKEFVvjITZuEAy?=
 =?us-ascii?Q?2FUF0GiQq8M3TXwettud12yCMIa77jEt3q93eGIbNBjVXG8ISC7zyhhBb0FA?=
 =?us-ascii?Q?rj7ftdJswpF6HZceyiauCsfeOpfe6zgYDIQvXENVa2ex8hpccc9Z8M+dm48w?=
 =?us-ascii?Q?Ud605zDTx3aJvBVivpTn1VosKlEjGSehqW6FQ16DM9fdTslYKLJpmPScMG2x?=
 =?us-ascii?Q?gIyNehXiHNnNTgiXTz9wGxE13BrgRKfp3mGG5qr5A6o4nKyM6uVBtIfVNEJi?=
 =?us-ascii?Q?sqFlwCThnsS5t+8ME6lLxSsFGMblqK2tN/h2cmAM510nWXlQrI7wLeaetSIj?=
 =?us-ascii?Q?J6BoIkqpxwK3aEXEodf6Gvi2AY+YACxisLZOp+KDElhrUYDCY1qEus+ukivC?=
 =?us-ascii?Q?wIMIO9paqKFXh8bWopZp8KQyroTxYF+fdjnA3L3LeJShWpT4IMyo9D520BnM?=
 =?us-ascii?Q?KyiUMNZBNb1pdH4+79Dm60d8laizWqKNYfQwreYUnb8OnKeUYBBI77xYbRBP?=
 =?us-ascii?Q?HPgqXRolImQttUYvSALlv69+17C15GDt5V1qJtrrLyfX6SAE/rvQE6FUWW6B?=
 =?us-ascii?Q?U4z7TgAp+SRPiA+F5ppBRz3mIsPJSeEcMAbFZNwFZWpOhmnNtLOmHEgYyINA?=
 =?us-ascii?Q?WIxWMCGVG7M9KAXgXh+81DKZjRleIL4q+Fzx4ii9ia81E2n2iIk/pk1pCD7N?=
 =?us-ascii?Q?ZRBVnJxI1zm1mBrrC2sFL2iBy0RYf780WXX/gzxQT/5SB2mrZlhB0WkKy8DG?=
 =?us-ascii?Q?tMw7Bwv3ZVXHC5k5YYTB6WWhiWTjQuODP8qa+SaZ1cBKBS1A7SjPlnY9qdhs?=
 =?us-ascii?Q?otswrtGMNu/FCPj8Gy+Ofr72fafyTIJzDHr/mIjlrZVeUIoOD+wODJeLL74E?=
 =?us-ascii?Q?ud6kN6IQoq1axp4/ngyRR+xUMaAeUHg9QF85CmNcgkALMXJZTJiR6bZSQ4tR?=
 =?us-ascii?Q?sOCJaEo6dHJbqSFakr6WeM5D3Xz91psCjWEcmi4swzMH7POGnzvmrCzrEG3S?=
 =?us-ascii?Q?oZq4jjNOd7TYl4XKAGyXg40Lrn/BDEZwjbZLYrKDvWYeZccmbDqFckn0PW3r?=
 =?us-ascii?Q?cObl1O44vRVYC4GxcuLjvwKTslXXPXDT5wlmTFnhiggTA3xb767LJsJbBe6R?=
 =?us-ascii?Q?zJ0mBAb9IffSIcnt8jItBL91ufaCp0Wi1UTKrdhzVjEOF7CfrVSgd3fjojeh?=
 =?us-ascii?Q?Nk525MTZ33YP5sgiWOZ+e3FhXsyrByohn5Lt1LnRNUNZvtINaxOTIFOPukBp?=
 =?us-ascii?Q?zLi8DynUZCPC0OCS0gbIWoBDPwi2MISE73hXWZfWZb0yOgvKf7A2PViIKLGN?=
 =?us-ascii?Q?VCa92qvVXdfLGMXU29FePvhkOT6hsTL2r1aNzTFs5pPq+f5ZCNymC5I0TUz4?=
 =?us-ascii?Q?JbCcXu3zl9QNdsYq3vCdarLkd2kPdqdK+MVmz+LC6vRWkFIDEHLMy+BE0tfy?=
 =?us-ascii?Q?0F1ytxGQ0/lyKI7okI1+GpCtb1k1Pve1EZdsnpRzCxeT4UFQTwg0nhGt7Mdb?=
 =?us-ascii?Q?KPuILGB/ZVhtlr+RsW27odDDFbWByjTxKr6MlJ4zaSVtI5ovnKJoIJN3aj4w?=
 =?us-ascii?Q?UL+hkle14mIZGigN0Kp+AYtd8Ee0Cj5mLeS7/P9iEXz94ypVXBa7ssBQ4FiB?=
 =?us-ascii?Q?w5IqAS7DXr170b8m/6GkROo+g5j7j8rYxAb8t/PeND07cMdaMYSI/jkibBxk?=
 =?us-ascii?Q?x+5w80ATl6/i8bQVANQ3FClkkaPM76I=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1318b19-6519-4026-7301-08df33cf42aa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 02:08:58.3742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKkknoWmZFzBdyBL5GWbF9kWloNFgSvZOFIoFmuKk5dJVkOGGLd+mTBlaihaSkxuSnd7YfvcMeByorzmzWIBscSPw6Evn3W41At9Mz23teQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7029
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Add dedicated device tree support for the Terasic DE-25 Nano board, which
is based on Agilex5.

Following Terasic's Linux device tree for DE-25 Nano configuration in which
UART and MMC mode differs from Altera SoCDK boards - enable UART1 instead
of UART0 and using SDR50 instead of SDR104 mode for MMC. The device tree
is also tweaked to enable the 16MB QSPI flash to store U-Boot image in a
single partition for QSPI boot.

New files added:
- socfpga_agilex5_de25_nano.dts: Main device tree
- socfpga_agilex5_de25_nano-u-boot.dtsi: U-Boot specific additions
- configs/socfpga_agilex5_de25_nano_defconfig: Board configurations

Build system integration:
- Add build target in Makefile for DE25 Nano device tree binary file

Signed-off-by: Bitao Dai <btdai@terasic.com.cn>
Signed-off-by: Shi Lin Teoh <shi.lin.teoh@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

---
Changes for v2:
- Commit message spelling correction, updated SOB lines
- Enable sd-uhs-sdr50 with matching Cadence PHY/ctrl timings, drop
  defconfig UHS/IO-voltage disables so SDR50 can be selected
- Align MMC sdhci-caps-mask with Agilex5 SoCDK (0x2000)
- Keep SD regulator GPIO only in -u-boot.dtsi
- Align QSPI compatible with MT25QU128 BOM (mt25qu128ab, 16 MiB)
- Drop undefined CONFIG_TARGET_SOCFPGA_AGILEX5_DE25_NANO, follow
  emmc_defconfig include pattern
---
 arch/arm/dts/Makefile                         |   1 +
 .../dts/socfpga_agilex5_de25_nano-u-boot.dtsi | 158 ++++++++++++++++
 arch/arm/dts/socfpga_agilex5_de25_nano.dts    | 175 ++++++++++++++++++
 configs/socfpga_agilex5_de25_nano_defconfig   |   7 +
 4 files changed, 341 insertions(+)
 create mode 100644 arch/arm/dts/socfpga_agilex5_de25_nano-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex5_de25_nano.dts
 create mode 100644 configs/socfpga_agilex5_de25_nano_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 099e3f082b6..b77721117b8 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -416,6 +416,7 @@ dtb-$(CONFIG_AM43XX) += am437x-gp-evm.dtb am437x-sk-evm.dtb	\
 dtb-$(CONFIG_TARGET_THUNDERX_88XX) += thunderx-88xx.dtb
 
 dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
+	socfpga_agilex5_de25_nano.dtb			\
 	socfpga_agilex5_socdk.dtb			\
 	socfpga_agilex5_socdk_emmc.dtb		\
 	socfpga_arria5_secu1.dtb			\
diff --git a/arch/arm/dts/socfpga_agilex5_de25_nano-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_de25_nano-u-boot.dtsi
new file mode 100644
index 00000000000..d6b7add6604
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5_de25_nano-u-boot.dtsi
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot additions
+ *
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#include "socfpga_agilex5-u-boot.dtsi"
+
+/{
+	aliases {
+		spi0 = &qspi;
+		freeze_br0 = &freeze_controller;
+	};
+
+	soc {
+		freeze_controller: freeze_controller@0x20000450 {
+			compatible = "altr,freeze-bridge-controller";
+			reg = <0x20000450 0x00000010>;
+			status = "disabled";
+		};
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+		u-boot,spl-boot-order = &mmc,&flash0,&nand,"/memory";
+	};
+};
+
+&flash0 {
+	compatible = "jedec,spi-nor";
+	spi-tx-bus-width = <4>;
+	spi-rx-bus-width = <4>;
+	bootph-all;
+	/delete-property/ cdns,read-delay;
+};
+
+&flash1 {
+	bootph-all;
+};
+
+&i3c0 {
+	bootph-all;
+};
+
+&i3c1 {
+	bootph-all;
+};
+
+&gpio1 {
+	portb: gpio-controller@0 {
+		bootph-all;
+	};
+};
+
+&sd_emmc_power {
+	bootph-all;
+};
+
+&sd_io_1v8_reg {
+	gpios = <&portb 3 GPIO_ACTIVE_HIGH>;
+	bootph-all;
+};
+
+&mmc {
+	status = "okay";
+	disable-wp;
+	cap-sd-highspeed;
+	sd-uhs-sdr50;
+	no-mmc;
+	vmmc-supply = <&sd_emmc_power>;
+	vqmmc-supply = <&sd_io_1v8_reg>;
+	max-frequency = <200000000>;
+	sdhci-caps = <0x00000000 0x0000c800>;
+	/* SD card default speed (DS) and UHS-I SDR12 mode timing configuration */
+	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-ds = <0x81a40040>;
+	cdns,phy-dll-slave-ctrl-sd-ds = <0x00a000fe>;
+	cdns,phy-dq-timing-delay-sd-ds = <0x28000001>;
+	/* SD card high speed and UHS-I SDR25 mode timing configuration */
+	cdns,phy-dqs-timing-delay-sd-hs = <0x780001>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-hs = <0x81a40040>;
+	cdns,phy-dq-timing-delay-sd-hs = <0x10000001>;
+	cdns,ctrl-hrs16-slave-ctrl-sd-hs = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-sd-hs = <0xA0001>;
+	/* SD card UHS-I SDR50 mode timing configuration */
+	cdns,phy-dqs-timing-delay-emmc-sdr = <0x780004>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-sdr = <0x80a40040>;
+	cdns,phy-dll-slave-ctrl-emmc-sdr = <0x4000004>;
+	cdns,phy-dq-timing-delay-emmc-sdr = <0x38000001>;
+	cdns,ctrl-hrs09-timing-delay-emmc-sdr = <0xf1c1800c>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-sdr = <0x20000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-sdr = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-sdr = <0x90005>;
+	bootph-all;
+};
+
+&qspi {
+	status = "okay";
+};
+
+&nand {
+	bootph-all;
+};
+
+&timer0 {
+	bootph-all;
+};
+
+&timer1 {
+	bootph-all;
+};
+
+&timer2 {
+	bootph-all;
+};
+
+&timer3 {
+	bootph-all;
+};
+
+&watchdog0 {
+	bootph-all;
+};
+
+&gmac0 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&emac0_phy0>;
+
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwxgmac-mdio";
+		emac0_phy0: ethernet-phy@0 {
+			reg = <1>;
+		};
+	};
+};
+
+&gmac2 {
+	status = "disabled";
+	phy-mode = "rgmii-id";
+	phy-handle = <&emac2_phy0>;
+
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwxgmac-mdio";
+		emac2_phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
diff --git a/arch/arm/dts/socfpga_agilex5_de25_nano.dts b/arch/arm/dts/socfpga_agilex5_de25_nano.dts
new file mode 100644
index 00000000000..32406f16132
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5_de25_nano.dts
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+#include "socfpga_agilex5.dtsi"
+
+/ {
+	model = "SoCFPGA Agilex5 Terasic DE25-Nano";
+
+	aliases {
+		serial0 = &uart1;
+		ethernet0 = &gmac0;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		hps0 {
+			label = "hps_led0";
+			gpios = <&portb 20 GPIO_ACTIVE_HIGH>;
+		};
+
+		hps1 {
+			label = "hps_led1";
+			gpios = <&portb 19 GPIO_ACTIVE_HIGH>;
+		};
+
+		hps2 {
+			label = "hps_led2";
+			gpios = <&portb 21 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0 0 0 0>;
+	};
+
+	soc {
+		clocks {
+			osc1 {
+				clock-frequency = <25000000>;
+			};
+		};
+	};
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&mmc {
+	status = "okay";
+	sdhci-caps-mask = <0x00002000 0x0000ff00>;
+};
+
+&uart1 {
+	status = "okay";
+	bootph-all;
+};
+
+&usbphy0 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	disable-over-current;
+};
+
+&usb31 {
+	status = "okay";
+};
+
+&watchdog0 {
+	status = "okay";
+};
+
+&watchdog1 {
+	status = "okay";
+};
+
+&watchdog2 {
+	status = "okay";
+};
+
+&watchdog3 {
+	status = "okay";
+};
+
+&watchdog4 {
+	status = "okay";
+};
+
+&timer0 {
+	status = "okay";
+};
+
+&timer1 {
+	status = "okay";
+};
+
+&timer2 {
+	status = "okay";
+};
+
+&timer3 {
+	status = "okay";
+};
+
+&qspi {
+	flash0: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "mt25qu128ab";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+
+		m25p,fast-read;
+		cdns,page-size = <256>;
+		cdns,block-size = <16>;
+		cdns,read-delay = <1>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			/* Full 16 MiB MT25QU128 device used for U-Boot */
+			qspi_boot: partition@0 {
+				label = "u-boot";
+				reg = <0x0 0x01000000>;
+			};
+		};
+	};
+};
+
+&nand {
+	status = "disabled";
+
+	flash1: flash@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "u-boot";
+			reg = <0 0x200000>;
+		};
+		partition@200000 {
+			label = "root";
+			reg = <0x200000 0x3fe00000>;
+		};
+	};
+};
diff --git a/configs/socfpga_agilex5_de25_nano_defconfig b/configs/socfpga_agilex5_de25_nano_defconfig
new file mode 100644
index 00000000000..a51b0aef909
--- /dev/null
+++ b/configs/socfpga_agilex5_de25_nano_defconfig
@@ -0,0 +1,7 @@
+#include <configs/socfpga_agilex5_defconfig>
+
+CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_de25_nano"
+CONFIG_MMC_SPEED_MODE_SET=y
+# CONFIG_ISO_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x0a00000
-- 
2.43.7

