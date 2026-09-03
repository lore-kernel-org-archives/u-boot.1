Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAA9C624D4
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 08:17:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D8FC980838;
	Thu,  3 Sep 2026 08:17:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D-wiQxRSwqa1; Thu,  3 Sep 2026 08:17:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7428B8082C
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788423453;
	b=YmCl433+HHDY2A3cFXKQWrWeczrsgWXgIdsZykPsLTs1YNdUhHjMBdKR1TbDe0Y2W32k
	 o8j5dDhzmegvYCUmLfDZfM1GYIbv+0JRpsFLukM6UrLSDAGF37ywh7ogpEQX5XEkgG92D
	 F5PZsmWObrkaJkQSEZwXTLWgDOUVjmYZj8HTpvgiVKKZIS0ODmOZxRxFEv59QTbRRxerV
	 7vWW+4ZOJNHVbZ9LRMXYpPNvX7QfPzqwKUjMTVSzkBV3QdSg/M4noXQ1+u/lVApXvO3n/
	 ZOxqD3TRdqGMNMcoNBQJHdY21YvN0hKpJPUkQRNv7oBbY4bah2f2kypB7l+AmswPxWQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788423453;
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
	bh=+DEpTs6DpqQEhQg+cqJ+Ni+Y9xk+TO3BLDrZ6WNU3+4=;
	b=Pz4QcBW0CJeTnwrP0zqfREI/Qh3Xw245n16RUdNeraEZjigcC85zlcp5hgdKIVc7ntDF
	 Fp+MY1dQoi8yAY3hxh+5qJ8KnOxhabv4aqyL2BqRT/K2S6uZ1OfauvD2AvP8TQ8qI3R+6
	 BkFAdZNz8kNJvPzIWVg9z+1ZAZvRAjMCBFEvM+AHPHnfkvQFksTiFUZxTBQwp8BITPgpZ
	 1+hi2+4ZXHfJQ81+1uk7ouun8lZmbhB8/Z4z1lZ6xz+7MPvIoQpZauCDYo/kw+G7aXGqV
	 DWInpD2/cMCraP2cKriHX/wB+ZQ4OlSia/kn3eRwVzo/Exo2/C7or8vyxV/EDOvrkRw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788423453;
	bh=+DEpTs6DpqQEhQg+cqJ+Ni+Y9xk+TO3BLDrZ6WNU3+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PHH4MCwOKgE4+wDbXjfFIrITTenmfa64OpXr1KhhZD/WMjsrZA5sT2Djnje+XikRi
	 uhKjnpdhfCamOmvJD3u6/4ReRdLuqa0rrstBJddH9fL0YjXqq/5Cx7Oy+ZhAy3FA5i
	 ffD9kchhK30F9pj1GdJ737NCjFYwCOOUac587hMphv+zRI+BokINWJpxewcaWcATiH
	 cYJwdixV8qF9XvXET+WUAplZj75twkaisK5NKKb8NzHy3t7IL2k0vBIOHhRbJGGmHS
	 Rj3gb4SbkVx3Wc+DGG3O+NZjUXd874HzIhmGmsv6RVqQzQRn9vxDx39eoqP0imPusn
	 waVnqp6RoLwCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7428B8082C;
	Thu,  3 Sep 2026 08:17:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 093342FD
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DCAD540084
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jbu6IPy9hi9A for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 08:17:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A838E403A5
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::4"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788423442;
 b=WlVCxD/LHzidIz/oH6DX5UAOV+PXEqNz0H44qtD8OnJYAtznhAkcixN9rol5aaTmQi0U
 i0GAGNTTwp6iXPzUw+0AvosV9ssHkqtWLDgSQcKwc/UXcbRYc0TbHYGExuOKMGDnJd1KH
 hkXadGFOLzMH38RI6JyEp42OpmiUeuvXGxZm+l7e4yn9DsJvV6U7N5/qmO1GKYJFBAwIB
 XGzzGPaO9ggvjaOJhEbDfxiPZ3WpPmA6tmH6c1ZyW6FX3cypvCKvWhEhu9KduVx1qVr+w
 o9Q1YsYX+GISfjg6sFaUKnMV5MHN14uabocxD9sRWA3S8dycYBLqxq7uOq0x/7kH6Ig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788423442;
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
 bh=+DEpTs6DpqQEhQg+cqJ+Ni+Y9xk+TO3BLDrZ6WNU3+4=;
 b=L0e7rfMFmq/0dhWpVnPdZ2mxomZDfEWUzIXO6baf0wVpuxAMSydqwH41Dg96uK5kZkA1
 AOmhQXN+EGovfg/IwJncd/33sautG/hYHgceVLPzAszpeN046ZSJ3T0+UpFtoMJp+yvNT
 S8/UvI2T8VxHk46GR/MiU2n2EN9oPe/U38jsIJG+jeMq01qS8sEAaIARrcinV3AuJXfP7
 b1vIjG6M0aaghVyIeWJqxTBgt0ged/068Z68RlpD91Vz93mw9YyrPd5dltonuPLwJjy+l
 qSkFrJl8fu8vRhU0Csme3upq/1p9AZffr4nE0tcNy9b43dK6Xnz6LwuNqme5H31Nocg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=AgnJm0cQ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::4"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::4;
 helo=pr0p264cu014.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=AgnJm0cQ
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A838E403A5
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqFKyK+KUQVKFAct2Fttdq8qNbJ+Z/+3rb1PdoM4IpZQHv6X68yXYHGLO6OpZ9ipG+BcH9S+I1tFEkclfYZsTVl9IRRB+TRhHN15wVjkluAxx4G+UmS5UmLBQmPm6W6w5JqgMPBzFRiG/iJiIWZG8LMvjuxB+tV5poGGLv3NE8krdYcIMv1f98D2fM33FVRPEkp7blB7K/21zuJKI7161NcjsEkmFDOnm2WiiuW/ZHAWRKOcIIl8OAQmm6jWjH3O0pCVh5XMudb5ZksCUHl71aaqtMN45RhB8RFSNse3BJDO4bYPs/z1TyPRKQZZwnrIs3FTNMN76Fd1MwCeUmJIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DEpTs6DpqQEhQg+cqJ+Ni+Y9xk+TO3BLDrZ6WNU3+4=;
 b=Uc6LgMgbwoWPENf53gEWKaquc+liBM4LPfCL7r9zh1SZ7lGBH6Z15yXFxUPSz24sGC5+mBrkN3qc884w/8AzsTMRyIiiE1yh+u3AFCWqjAYmHDbkoJkciif+bRnQqlBoBGbiAvJWPudUxwkTE4LoPhqGPXTZfqh0ZF2DghmloLbdAUOXb2rdKGOc0wOAfDXfGbTLZysF3mgfyw3ID86swrFgEgrcrOCEe7yFyizPZN6hbuuc0TSOCd1ghnCb1tGmBKOJn+4/HasV/54o3yowz0hVVU8BsGcBA+3NXbiPKISpXrDAXXE8fPltnnOYnmBlFIORFYFXn8MM5/vs0NSG2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DEpTs6DpqQEhQg+cqJ+Ni+Y9xk+TO3BLDrZ6WNU3+4=;
 b=AgnJm0cQT3r6VBbYmuJNczbEpPNOPD6ubWw33Aqmq3kQQiJoFtHSteztDtuwXi9l+q1JTL9y2lxzNODqfqDPS+hdxKVfEH3fbS2v4azFsTwg/eGI9SOBvZKiBqZsqWhCdHIy7tw1y31tV4m/uhh02DxYtGCgLyShXTtQUYIuDV5P/3fhEU9sKnBh97UqVFXdzi7zpPiHXWaMEKbnlvVPbSQbV/Whfm1agPwC/cuS/41P51G6yjHfvLVgOVmoDXalcmUZBfeiFQqWoRgB5lGTSGiCh5k2THV7Z/N+6sBTdMutO/iwtvSoGSR6gWTdZfIEsH983WZoqkew1hrBJ8lZcw==
Received: from PA7P264CA0004.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2d3::10)
 by PR0P264MB2583.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 08:17:17 +0000
Received: from PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2d3:cafe::52) by PA7P264CA0004.outlook.office365.com
 (2603:10a6:102:2d3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu, 3
 Sep 2026 08:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BA.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 08:17:17 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 7D899202C3;
 Thu,  3 Sep 2026 10:17:17 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v9 15/15] test: py: vboot: add test for global signature with
 ecdsa
Date: Thu,  3 Sep 2026 10:17:05 +0200
Message-ID: <20260903081705.12894-16-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903081705.12894-1-philippe.reynes@softathome.com>
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BA:EE_|PR0P264MB2583:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 12b85f0c-0e2d-4e84-6cc9-08df0993c4d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vIPCnK+ojDa7P+JlljOwQU7lGuTKY6EwU40X2aK2nKQ6BqCo/7kRZWXn7zu2Qbz+ED4xwUvdetfW6Hla9UZuwnBE59HMKjabjMcaR3WWVsltBX8WJwqJLlLeZrELBDD9UfO9jDQx6RNrVXjcCfIgZtiJvCI0/WJRfLQhPstTKp1tgaCeUGbyGbIg0WltMW3/bZKcGciS80lX5RBqtIkv9n+HfNQyRQH4PgDU1SWYFcTw94125pZ/AUgfcDEVVV9b+Fmx65F0PHboFxDiVSefko4d/aIGotDrmVSAkiQFChI1y6GpsbNHepRiTFsSd+ua+V7JMQcgOnWUM9CLsyC1oeWqUMh4Ww/jrIQ3b82zaSqj3sLcYb571boUcIaYFdKwUCWjGlEi2J0o9UM50n1DwDE88tyVdhhtzndAKEimXpHgbNV0z3cmZsLP7riXbeNbeyLb8hPpKn4TsQEp2Aiw0eGPB9ZirdnYkTh6hyS0OBuorpztIKJTZp/DufS3SawfPfT+0NBxBNDxUtgBlDVzS/tm1KCKSy/S0KPKsZGSqA9/bZf177D2Z/dA9rmgR5FvDt96uMjYu9cBAqqbA3vzmfn/LcEMwUHN0RBejfQjogAAXesUYJ0bkiOg4Vhj4hRc+jZ48y+3c+OPfCkIsSebnkFA4qx/P0TRLK7Bk6aKKX1jg36MzYdvtZv9DuiCvPocushXztFEY2vrwLTYqOCvkg==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RoUTSizvMtDOE30PSv3Z0mcdab2lWeu5AwN5EoyhCkQc1dkMStsl9TfAESu4vI2vdO4VuIyrB+x7nU3C7h4p80kHZWsrzbxhJUF1fhhd8PDzgwnGxYEKii+vdwxON56P7w+wQnKV51TIj6NNmAdRqc+n1QyxWyqONnYU0ZOTOc2159DENRA/XD0LlorfnZbQdog9sVmRpDi2DaDlLMmPXTtenkMgOySkJwYbdbvj8UIshaP3q1mXrrMR2HsgmAzMydLKJYUdZmPjNkiv+ItON50Ec714AvjAx4MdzzOI0DfWiIWc7StLDkcT/xCexHXcoRHMO0oSbt04/X+3wQTuK2vo2KmX7B4ytHQLCx0c7PQ2+0Iiyln053yCPy9lwiUaPqSrPMg4xHpcS2kLKksUGeFTZRozcCzQw7k666MtW7V/GL1cEQuqvNSuu4hmVsvu
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:17:17.6389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b85f0c-0e2d-4e84-6cc9-08df0993c4d2
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2583
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

As now u-boot supports pre-load header with ecdsa, we
add some tests to vboot with ecdsa pre-load header.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
- no change
v5:
- no change
v6:
- no change
v7:
- no change
v8:
- no change
v9:
- no change

 test/py/tests/test_vboot.py                   |  3 +++
 .../tests/vboot/sandbox-binman-ecdsa256.dts   | 24 +++++++++++++++++
 .../tests/vboot/sandbox-binman-ecdsa384.dts   | 24 +++++++++++++++++
 .../tests/vboot/sandbox-binman-ecdsa521.dts   | 24 +++++++++++++++++
 .../vboot/sandbox-u-boot-global-ecdsa256.dts  | 27 +++++++++++++++++++
 .../vboot/sandbox-u-boot-global-ecdsa384.dts  | 27 +++++++++++++++++++
 .../vboot/sandbox-u-boot-global-ecdsa521.dts  | 27 +++++++++++++++++++
 7 files changed, 156 insertions(+)
 create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa256.dts
 create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa384.dts
 create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa521.dts
 create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa256.dts
 create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa384.dts
 create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa521.dts

diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index e3996486ab6..ed7e6bb33d2 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -102,6 +102,9 @@ TESTDATA_IN = [
     ['algo-arg', 'algo-arg', '', '', '-o sha256,rsa2048', False, False, True, False],
     ['sha256-global-sign', 'sha256', '-rsa2048', '', '', False, False, False, True],
     ['sha256-global-sign-pss', 'sha256', '-rsa2048', '-pss', '', False, False, False, True],
+    ['sha256-global-sign-ecdsa256', 'sha256', '-ecdsa256', '', '', False, False, False, True],
+    ['sha256-global-sign-ecdsa384', 'sha256', '-ecdsa384', '', '', False, False, False, True],
+    ['sha256-global-sign-ecdsa521', 'sha256', '-ecdsa521', '', '', False, False, False, True],
 ]
 
 # Mark all but the first test as slow, so they are not run with '-k not slow'
diff --git a/test/py/tests/vboot/sandbox-binman-ecdsa256.dts b/test/py/tests/vboot/sandbox-binman-ecdsa256.dts
new file mode 100644
index 00000000000..0e84b81078b
--- /dev/null
+++ b/test/py/tests/vboot/sandbox-binman-ecdsa256.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		filename = "sandbox.img";
+
+		pre-load {
+			 content = <&image>;
+			 algo-name = "sha256,ecdsa256";
+			 key-name = "dev.pem";
+			 header-size = <4096>;
+			 version = <1>;
+		};
+
+		image: blob-ext {
+			 filename = "test.fit";
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sandbox-binman-ecdsa384.dts b/test/py/tests/vboot/sandbox-binman-ecdsa384.dts
new file mode 100644
index 00000000000..56faf67fe57
--- /dev/null
+++ b/test/py/tests/vboot/sandbox-binman-ecdsa384.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		filename = "sandbox.img";
+
+		pre-load {
+			 content = <&image>;
+			 algo-name = "sha256,ecdsa384";
+			 key-name = "dev.pem";
+			 header-size = <4096>;
+			 version = <1>;
+		};
+
+		image: blob-ext {
+			 filename = "test.fit";
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sandbox-binman-ecdsa521.dts b/test/py/tests/vboot/sandbox-binman-ecdsa521.dts
new file mode 100644
index 00000000000..8e2fc3de31d
--- /dev/null
+++ b/test/py/tests/vboot/sandbox-binman-ecdsa521.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		filename = "sandbox.img";
+
+		pre-load {
+			 content = <&image>;
+			 algo-name = "sha256,ecdsa521";
+			 key-name = "dev.pem";
+			 header-size = <4096>;
+			 version = <1>;
+		};
+
+		image: blob-ext {
+			 filename = "test.fit";
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sandbox-u-boot-global-ecdsa256.dts b/test/py/tests/vboot/sandbox-u-boot-global-ecdsa256.dts
new file mode 100644
index 00000000000..f15ada3987c
--- /dev/null
+++ b/test/py/tests/vboot/sandbox-u-boot-global-ecdsa256.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	model = "Sandbox Verified Boot Test";
+	compatible = "sandbox";
+
+	binman {
+	};
+
+	reset@0 {
+		compatible = "sandbox,reset";
+	};
+
+	image {
+		pre-load {
+			sig {
+				algo-name = "sha256,ecdsa256";
+				signature-size = <64>;
+				mandatory = "yes";
+
+				key-name = "dev";
+			};
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sandbox-u-boot-global-ecdsa384.dts b/test/py/tests/vboot/sandbox-u-boot-global-ecdsa384.dts
new file mode 100644
index 00000000000..24540ace249
--- /dev/null
+++ b/test/py/tests/vboot/sandbox-u-boot-global-ecdsa384.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	model = "Sandbox Verified Boot Test";
+	compatible = "sandbox";
+
+	binman {
+	};
+
+	reset@0 {
+		compatible = "sandbox,reset";
+	};
+
+	image {
+		pre-load {
+			sig {
+				algo-name = "sha256,ecdsa384";
+				signature-size = <96>;
+				mandatory = "yes";
+
+				key-name = "dev";
+			};
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sandbox-u-boot-global-ecdsa521.dts b/test/py/tests/vboot/sandbox-u-boot-global-ecdsa521.dts
new file mode 100644
index 00000000000..72fa3b2c790
--- /dev/null
+++ b/test/py/tests/vboot/sandbox-u-boot-global-ecdsa521.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	model = "Sandbox Verified Boot Test";
+	compatible = "sandbox";
+
+	binman {
+	};
+
+	reset@0 {
+		compatible = "sandbox,reset";
+	};
+
+	image {
+		pre-load {
+			sig {
+				algo-name = "sha256,ecdsa521";
+				signature-size = <132>;
+				mandatory = "yes";
+
+				key-name = "dev";
+			};
+		};
+	};
+};
-- 
2.43.0

