Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF50EC79F80
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 08:37:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FE1460BB6;
	Fri,  4 Sep 2026 08:37:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eRzzTFVqU2FG; Fri,  4 Sep 2026 08:37:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 93EA060BCB
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788511054;
	b=bksPBaOrI2h8IbPM7AUQcKCOFPRPkvyrDLXMkWPl31nfEdCRGLc1JXYPGHssrhzmLRea
	 KHqKBjjJbWRsM3mUjdfKBqYRWdv34+IQmWZ9WLip6b59Gyp9df0nlnDvdQkxCCU3FZTAO
	 NYvg6noM/2+Uy2KK+KMGBBZ33frSMwMdNkKzpFy+ARk3vNDDoM75vV24shJ326SRniSrh
	 DJAtniReK8B8kcUC0AiBsxXYHBH1dc2rjN8aDQmb18hNlMxGexKxaYZLo5BhSu4ZbMrK+
	 JC252Ka2SX7AxYht5RQMPAXyO4IrjmW96jRPeBEM7k8qbpKREGVSa5IoiaIPtL4/NEA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788511054;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vPy18H+WOuI1L51Y2aYzahcda0PrMXFq6ADJUgeTC+s=;
	b=TUVnpmxYw0Y0sfe1BGeBMcGCOuKg09InqlLSXKriTvo7sRRGb8nK37FMwJiJznT7wIt0
	 2BpyglXb0YXknn112dvTlUY7h4qGnnWbQLhOgHe9iJbFDIqlDdRFfjEfAwW96zzRgzDFI
	 XKGOCQvTK0F55Tp9h+qczC8DqY6k7h0SUoSWePVP6YpvupUpsVh5CuDUM9veyxCG+Jm99
	 hkcrX/28yd+7upn9Ff2lb/3FTQhLUJ6chph5d16NNM703DUJbzh8+rry8+M/uNUeG6dcx
	 XK0rOb5wXRo+g0nAQMiacRicskfk9T8GUTcDKhUJbF8gbEAcIR2GXz0axZmq0L3HL9Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=none header.from=softathome.com;
	dkim=pass header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b="fB/byuEr";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788511054;
	bh=vPy18H+WOuI1L51Y2aYzahcda0PrMXFq6ADJUgeTC+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aZ0BqzOEq9j4sUdR758QyP5EE356L4CKcBJsRtn0AJLtRUqbvPUqjBHhdJdx5v+2N
	 whhjNzzwzH+YzVjjMSAR5pf5pbgq2/v3y5/6vAr9OgZBlhREOYQDQb5cYENPBoOmos
	 +DKzeHeZ/LyiLNCVu+Y1w1JrzgFW2eMkNzce2zRavH/gqowalhNS+gKQlNt1YnvRDm
	 yFT4CGvkDXs+4aFW2Y8qzDuFH9+o2j1HbGFPNxVxe6Dxr94gprR39LsCyKUhOgDXCE
	 AclYymPdjfO/7H7AOWL3fspDj5J9zaPjgCmOOHU24PGIJ7nu306wmhfoJWl+ZKN8ha
	 0NlWi7I1U4Q8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93EA060BCB;
	Fri,  4 Sep 2026 08:37:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DA43118
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 834696078B
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y5mPmFR5pVNN for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AB92F60626
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::4"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788511049;
 b=CuTwWpdK0POZQTOVn94ZcOswzUegLELZ2onENfvfCWJVnQpO1BIN83O2x4vxW8OfVBwC
 0Xmm0mKrWtg3Qv22aflupBC64tqQS4ugzf5QocTgTXxbaRikFMR26AqRo1YoMhkbK0Oqb
 nGQ9N+CQMu7uw4ozgGZB68D+ODcVb1xVcS5WMvlAj2nRxV/8Ny7KtLKHUj8z/7xkDj91Y
 QYKpnJaHxfiKGLczDsz32FmBwVZeczznm2ybgubkD2wuMZEsiA+I+DpnyZAQ5YU7jCh6d
 +B7RNTsHAYnmAygIYzm5BAf+FDxRz139vw8vEvQ3Xf/BXm/G6tpEy+yP3f+JBAGI4Lg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788511049;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=vPy18H+WOuI1L51Y2aYzahcda0PrMXFq6ADJUgeTC+s=;
 b=Icji+Ae2YoPEWo64mrafbN7cC3CjoH/tl6MvFaQj1KzhF+hU0tRUSNpFiNVJGDd6p7OI
 Nc7eWAE7TgCIm1x2qFUwT3f5hZuZ73NoLsNAPMYwtFuQFhfYSIqqBv+fGLadF2qfWs3Xm
 6upe3zoevtwyruRWzG8tqn/HC2j+tjLGcacBAYjFVejZYAfrfxsc54/xUjqIB8L9Fr6TL
 SRutWTVbV+8rjHjyebrwUHp8AOKdSRUaWQE9xcZ0SaQxws17YaylqA3vmplqgrLunB3Mf
 komuISuMJmG+svMIiXy4lB/uwam9+LCHInVsnyhOS7QLVoqhqKqPMLuzJElMsQxidbQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b="fB/byuEr"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::4"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::4;
 helo=pr0p264cu014.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=fB/byuEr
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AB92F60626
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQuwf2eMb6MwxNX9WjGMoqVPp6B/djvt95amrswff/VIgobcSzbEKCUANRfXX9/J0x6QI4uDO9j22gscm77X38IOe+9Hgu15daf4cxntW02vAKGRGYzbqcK5zZuG/LnAMJtsLfQzqxUmvsMOjvXsDWYAbgtrshdVqv2NJCr6MTy5+4V+PbFtQRCVfkD8IAZBmqcLhcLvZXGh1lDl/a/hzRDVgbLJ2oUNXnsaA3XpwVbRslvdz2PQ/zOUX58sMHOXXdZ9mlYVpNm6TONLSEomY4W2GVbhJPXB2wM7qgxFj+QkWtUQE3RhPzIutt7LhqnvQ8pLr6qmgZX4hXi/arcRnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPy18H+WOuI1L51Y2aYzahcda0PrMXFq6ADJUgeTC+s=;
 b=Pv4VQOCG9yg18PS3oTcZj36AVzSeNdpvarSdre/3jg9XZxCq0vLeoIkobvBzXqonWjjx/xdCKd2DE6F5I8BhdhenAUqiqEGkzF/k//F4Nx7ZoOWvah0WRfkDGQyOVUE1BJQZ+pXOI33bind6Y7xva44fS4Vv+mr5j6y07fgujDnr41mOv6mX+oKXHpkLJCfIdwauljJyZkD8FzFzju5TVFl7B96utOM/y6r9p3N4inCj10T45OQenMl7Pf+2n/Wy59bzIWNqoLOXtuoILBLo3619czC7cEZnbO9LNgDRGJgo4ymjqvPh7/I17ILFXTRKe/pr32GGUI6496Ob6PLuLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPy18H+WOuI1L51Y2aYzahcda0PrMXFq6ADJUgeTC+s=;
 b=fB/byuErCT5qLcXSNbXx9DugfRCPXE1nr58pEuugtvGnKsE9SVKQqGo+CLDEpBj3KZqbiT5J6KCiUNWyRD1kPt/mSaNoem8uis8cLcwHEjlPZUzQF/49tDejZkzhaIVEEySZgL0oVfifOSJFUGC7VXZk9ClmAamchuRYueQGcbjc/a/tN79Oik4YwbylLWqMo9EVMrjTfd6umGJ0kE9tbT/JZf2l8QHSekl6f2zQVIVC/9PzbVE8UiidzrgcJi10AitOJMTNj5n/fRDco8R4eUCPZ1UoXkTnOiaqYGq27Sp69cCniO4/jEgEKkapspxCTm26r4rAdLK+YlvvUQN9lA==
Received: from PAZP264CA0123.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1ef::17)
 by MR0P264MB5448.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:61::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 08:37:22 +0000
Received: from PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef:cafe::1a) by PAZP264CA0123.outlook.office365.com
 (2603:10a6:102:1ef::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 08:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FC.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 4 Sep 2026 08:37:22 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 931D9202C1;
 Fri,  4 Sep 2026 10:37:22 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v10 09/15] tools: fit_image_setup_sig: set required_keynode to
 -1
Date: Fri,  4 Sep 2026 10:37:13 +0200
Message-ID: <20260904083719.53132-10-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904083719.53132-1-philippe.reynes@softathome.com>
References: <20260904083719.53132-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FC:EE_|MR0P264MB5448:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 22e271d4-e09a-4221-db96-08df0a5fbd7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|6133799003|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: /SbFTKTmM8jvDdH1N9vAUUTBptASvMF3Zi81FfNxX5XdZ/SbuwdWXj1W23lBO38PAiYSszjRNEOcPJT7VFLI0MVr/iwCmm5zslgAMuoOCGBvChWo4sgyYAi6LMnInGpfYoDWVMy2Eq4l6nKz4y/xHhUcKZS/M+cFWqGu7q3hTS9RQTbUu1GMkaWDewY32pLOnBTqR35oVWE4iGGGFoVUVWoP+5GU4h2Rwzl2RDigW1J9zow08s3H7Bij3GvNpnvVUZ4SGi1F3MwpQ9lRhiWcBKLU3QcjZUQqBL/nUjZeMZiBLj3QG67xg1154ueLb3hquwVENHC8gi9e+0JX5YCwzTfunoJEJEXzVOwCq/1pf/YVADaoOUnavVJMopEgTQnVihOYZo/y8BE0DWLwfzbkVD0E9Nv37OkKUAp4DWybW1Wwsunaa92BKc++bIootTybX/RXRjCBNDXGn/fCh/U675FusbEOWoBcKbgK7imRh3hTfbrbfWRRatlkYXAPd/1v7rRqOoM390c3ga0Q/qhkdWBrTYEiEQ3YlZZa4ZFSfSs4LVmerle8SquLioeQd7qnNCXIK7Yd348P1+YZIz1lq88ur+mErJlxhlcmfNCt8O1064S8+l+eIETg1dFHXqGPlBoA+Srnb0yCaVzITvrRorJ1kYCb4lABLcl753guew6vsirpiLfm4m8gg7jXnrAB3w6SsUo2KrijcKzBYCKA9g==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fBTupL4F7lkkJVUN3J0hrIaWGEemvoG/RYM7symvo/GyuRXkRTKorPj6iNsX2JRUeLFBkYU4tHU/w4pGhHyPrCBPCSqb426FziXd+YEajUQ8Lp8qb3MraQ9yCjhdl0nTehRpDGG5aBiqWlWY5mMvio98OKCo19+1vQqg8S/75sUp21Bfv37Oa4IF+ly+tMQHd+YE9M4DpuEhAs57iqbU0n42Cbwgxzvzq0qCOqYqw42iPbVxhHn6pzWgYN4tm2fvGA6E1oyB8TicwgzEcqBWYpZ1NGQYZwbRXQI3ny4xFFX99c/fCDuSnYnWaZolYvYIgrVBBc1pnc8cHStIynTy3ngKEIybRkcaAXT2ndc14AGvsnkf8FoRH6cbfOG3w7Eozd9B7nviAFMxkwdi4OQ1Golw8gibvoJcyY1qXx88YXfyfrBEsJQ+Jz1E+V4pAJhI
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 08:37:22.7261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e271d4-e09a-4221-db96-08df0a5fbd7f
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB5448
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

When initializing info about a signature, set required_keynode
to -1 instead of 0, as 0 is a valid keynode offset.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v5:
- initial version
v6:
- no change
v7:
- change info->required_keynode > 0 to info->required_keynode >= 0
  in ecdsa_verify_hash
v8:
- no change
v9:
- no change
v10:
- no change

 lib/ecdsa/ecdsa-verify.c | 2 +-
 tools/image-host.c       | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
index 494b60b4ab0..341486de2d3 100644
--- a/lib/ecdsa/ecdsa-verify.c
+++ b/lib/ecdsa/ecdsa-verify.c
@@ -117,7 +117,7 @@ static int ecdsa_verify_hash(struct udevice *dev,
 	if (!ops || !ops->verify)
 		return -ENODEV;
 
-	if (info->required_keynode > 0) {
+	if (info->required_keynode >= 0) {
 		ret = fdt_get_key(&key, info->fdt_blob, info->required_keynode);
 		if (ret < 0)
 			return ret;
diff --git a/tools/image-host.c b/tools/image-host.c
index 46036673050..9a85a3dda2f 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -202,6 +202,7 @@ static int fit_image_setup_sig(struct image_sign_info *info,
 	info->checksum = image_get_checksum_algo(algo_name);
 	info->crypto = image_get_crypto_algo(algo_name);
 	info->padding = image_get_padding_algo(padding_name);
+	info->required_keynode = -1;
 	info->require_keys = require_keys;
 	info->engine_id = engine_id;
 	if (!info->checksum || !info->crypto) {
-- 
2.43.0

