Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A72DC624DE
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 08:38:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4174E60C1D;
	Fri,  4 Sep 2026 08:38:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QRjsWQ5pkeZ1; Fri,  4 Sep 2026 08:38:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4A1B260C24
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788511075;
	b=covFLfA4cx9mk3tuUL0pap8pyve+biNDhC34pO+99raP2iT6FGKGeKgoaYDextaGbjLi
	 w+2p+DfH288Eh1bimNyKt0s4SRhpt/SArVdcYwqHzJCHQpDEiQvLx8wRUm3oo71A4Navy
	 0jqCj2/dhatlEIE+U+2XRLCRhjdNcK8MqpJIaNO+sr+Dfw582rj15L/s3gqoiCHL2K5Ta
	 f7ylKwiSgMhKOYsFbfYsJJ81KdMJz+T0v6ikz0I6KtmzjpVSDB0J6oaFZCxiL4JVAlj/L
	 c9Yirs9j/uFnULjrqD2elzqIVUOkwY+boZbHPZFLpiNHND980SZmd7VD17n0SiS991g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788511075;
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
	bh=icgNDYx2Gd5mHhrh344ZOKKY6S6hEgdWTBHqjYOdRz0=;
	b=aN402gTEMIHXggkJshN4NC51B15o1uhz0DWogmf3AKJBgtzlr/t3srf/wydxrovkT5cr
	 gVj68LsQ5VHVEAqz813sSP5Zj1d1xlon+kbWsMlH0O3KKjVgoIZGwkxjKQSIsmK0DhvMZ
	 QtoGNfeR9kT2RQ4KPzixarz5PF2kYVQ04TwuADSXAoXJ8a7ZkmqhLKH7ulxsMrkY3pYMX
	 8t81iQ4QbI4tJlogONBLce4XqGtK0URDVjpIJ0wTsfe7J6ZsxY5PIMaPXQvsnWsC++ngQ
	 h5fXyqtrD7hK4cgx2L/d8RzA1tAHfZ5ERd62rX6RkNZmCF19PCMyTKuEYTEbZsbWRpw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788511075;
	bh=icgNDYx2Gd5mHhrh344ZOKKY6S6hEgdWTBHqjYOdRz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PhPzRq/Ui2SdWhHTYFDH892cRIMaSwE7QoFyHVn2i22DpAI49rJJ682VeumdZSHZD
	 3enB+zyl36floJgusd1f3RPcjQjt1rYenfwtcFlLCJ49/SumvoBH4Uqsz8Fxn5HkuN
	 3uaOP7zyqgVj099yyLmP72keJ4ugeVqZwj4UhgtddSOpF3Rdqq0wuShY9N0s/safV4
	 upf2DXdAnp3BSBVN0ugz/KOtHOrilRbfOxzHTv2RNi2auugU17l2QrQkh3YiOo1uVr
	 2ZnGVdPNzeCoXuZ5H8evYrkDkvRahGeV0HgKUEY059BIgqGWfMDvobkH+gFR/OSMij
	 B/M2ApauLaxhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A1B260C24;
	Fri,  4 Sep 2026 08:37:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BD0C118
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0E2BF40080
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0WnnHn1BHP7K for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 940FF40388
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788511049;
 b=clYFOabmwU4DrLIjBclPuF7KH9+Hi4S6YtMZLQ4rZNjH8erxE5bLqgYMPr6sNpEAsOP4
 Nj/bGQ2GyqKwV0FcHfuoEmRsYerzfw3yaOHrxNZxIKPa+EeIiHF+5Z0GlpR51FV2xM0l6
 1AIDCJgq3RUjx79/JofynhLLwIFHXZBKMAXmbOi3+OjBqiiuoSSKuJMlxN+THEA1Xcz3F
 kIe5q76DFQZznCbEc4QtG35eQbOcvV7DCKnlDMw+fzhaWRL+cL0RjEQ6f/DkVV45VZhIB
 Qdxg9XBOoJfWwUnhEwPwItaKHAX2F2+SHL1Wdn4B8UxmxbcLZOV5js1zKudZX/EdMEw==
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
 bh=icgNDYx2Gd5mHhrh344ZOKKY6S6hEgdWTBHqjYOdRz0=;
 b=aD28Qtei/9aaVPMX4ooHPd7DrmCkoz/MNvzLrctS27IiLXY8KlBDzvfY5aL6g6i2Tqva
 K0VqArlrNTlmTRkIdYIBVSseWGQxH0SJlU6isSvHLezk/6Qw1dhko4AqKjRyzESzTLrG3
 FBOC3j7kgeZw4ozlOTvJ/gfT8DXUAyuLgOYmZTuygNrXd564gg3LwcmJ1NrXp4g+ge9Ux
 lel7qsrJcVwG5U9nn3DgvfyZdcTrQfh4pnfIkEKx2UMUXsjZog0WOvYk1LpQv6nfTUAey
 xyXWNsYlhMtYwLpmaSDBvBClKzv6ETcwP2erH+DAP5XfmWgmsKz+8NOMf/O7kv6GQ/g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=qZ88y1U+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::1;
 helo=mrzp264cu002.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=qZ88y1U+
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 940FF40388
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkHeZ+HLhdHcN4dJHzI16eU+3tZYYE0aofE3cT1pQGkbcILzmw7R4TN2Cjq+fGOZkuRWWemt+hbxTjMqb7vGtFxHBdf2FA+GHFc4CjGbVHSfIXDmpHUuJbAj1KthLbhnkO40qcs/U/nmA2lSZqPPnw662qXhEo0oxgxhMyEr2OXdVq6swoJjD7VzCH5PQV4Hf+bdyB8JuutGKW3Saxn6cV7QwXZS773vCnbW24369Yx2CYXIYU9hC7OyaiMOCJKp9LHTngwc9qU4BFIR0mF5u2gfmtp4gvJJ2rCXxiDMviDZs/PPev6ZSZ8RB9+Ma4Jdfr52n+rv11nNdQhV1/3E1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icgNDYx2Gd5mHhrh344ZOKKY6S6hEgdWTBHqjYOdRz0=;
 b=UslPOSnFKvpUfb4XiwngSU0sbxVa/KDpyrWqrCxIUqufxApta1EsEJ2zrUYulXTdBFJ7p0P4j+DIm5c46R8A2Wo6PILvakHLEwql6Qz5UepnqaOZB/VYot1wr/Ntvxi1EujjP64ZijY5m4pMgSLhZfbVXDVcG575vmyemLuvGLLjSJMLc3k8jxTeBpMrWku12Zfa38UPkYQqOMb9098PRLJuggBgHNu7WdhTIBdD5Sr7rdFrQgADlq+Wyc76MDGptdy0hXSl94vcHsdqGd/2txLgXkpzFHUQehW+S9ZA5nQaNdAMNuQ46ZINIod8rW5+00YlkgD07Zh+JBhNM1uANg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icgNDYx2Gd5mHhrh344ZOKKY6S6hEgdWTBHqjYOdRz0=;
 b=qZ88y1U+L9tzJggF5RwslH2lMAlLQ9ZNJvIxgFBIB44/Kdlwh6iEUSmRwW+QFMEb2nAYU7omYI3aB7ytgak3DWTiDD1ZzoIRDRFpF2xILk47Og6VKfJYhAvfQTFoNixCMA8w6DGrZ3HBx+lOWGd3l3MKRqjnnlp+t1bnDmRcYp4JnZ5FHoLhby86CK07f5T+sBkL9bp86ol4T2pvMQk3WsxMZfyPF3jkcjw1Du5KuFRoRhCylE66he7oRi1H0jrAbAw8VxzADkW0skhbph4stmliE2Y1KKvtnJuwR0ftPaKPF1Ceb16eRh7P/Urps79i326FoFwJkk2mIyP5vP5KUw==
Received: from PR3P189CA0010.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:52::15)
 by PASP264MB6910.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:541::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 4 Sep
 2026 08:37:22 +0000
Received: from PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:52:cafe::18) by PR3P189CA0010.outlook.office365.com
 (2603:10a6:102:52::15) with Microsoft SMTP Server (version=TLS1_3,
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
 PA2PEPF00019231.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 4 Sep 2026 08:37:22 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 35713202FE;
 Fri,  4 Sep 2026 10:37:22 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v10 05/15] drivers: crypto: add software ecdsa support
Date: Fri,  4 Sep 2026 10:37:09 +0200
Message-ID: <20260904083719.53132-6-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904083719.53132-1-philippe.reynes@softathome.com>
References: <20260904083719.53132-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019231:EE_|PASP264MB6910:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b2efb7f5-70a0-40c6-5c37-08df0a5fbd54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|30052699003|13003099007|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: s4hE2clzWomEn/i2+Ul91f9FyFL1UUglbqvLpv4kFW6mSqYEhgdVf5fhzG0AgFfuvymAepQFcIHE9n+A/6Xszi+rGck0JeX1m+or3SkL14ltsci1FArGZuJHK4EFZml9ybIqe326chW0NEUacQgEpiDSYTYvUddY8v+KUob4aoISD6a5IH0W1Uu1tEaZlgGquDCdyV+d1LaoJNtVtGMkuu8HQ5tmNb2HCZjphRwosJlaTdLyknWOi7sRvk+YqJxbqNcVigsNKmGmmQHQAYIlg8vPclQL1Bvhe+n0cDXG9V80Zgx4KwLHmyHjktl9zaQdIi+7nYr0A9CvGKwjwj+jnoa7KUEdAQDirTru/0q0z0Ef+Nd6m8ODW0TMn44uU4rDOPXW9Xs/ENfT8RrMgNKGD/z4StEuQhSZgdhgyWUiOrTyZcj4mYcdgybD6XRN+nGpSkvVzFFP5EPJubbonsiK9A4EHONV+KrYlPHRWmMyZyW8nUXxlwq8uxD0PRbCoXBc3lzO2g/yF3cOwF0KppT2KOG28IeoAlejmL/JbP4BKGzPHV87QnkpKfACxcbHRfUOWBP3M1coD8RuTgLv5YvUYgkBVm4+ERebNpun/MiHSlqB+CC86W0p1zZl2R9o+40wVtrDQ8vX8x8WfMRBLOvvYA==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(30052699003)(13003099007)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vLK0/3N27SroQiho+au8l4sjB8BHbq5cLFdCgXnpPECyz+lSroVLthq3QxIvD7ZcwUORGRFriZ3nZKSbcczf2Fdl3EyFCiRUngiYjSqxj8fIPX1XEcKDYW+YMq22hD9F/gvPcqfaYpVcbAx56z1doX399tsHwyixJE9Cd1F151ChZMd7JdC5a+EKkdJsgzrr5J0dv6nXTAFzpeSVeG9qBP2NyD/vbP3Y6X2O9Njs6XJXugp+PRqUUu1iYAcHwQvMGGRbvJI3zfatMG383PCFHyFyw7rNHPHROaVeTx+vgWU/5H6f1pH42I1GfrIn0ViixPinvzs+Y+vLXDnOxv29wL6OU9mIB5gQ1vhpG5wlbwyYFpxkit/1JFsC/GoY3/i0+C0uBqeC4vDOdh8M7n2vKxIXEhrjlRUvFfuB0eH0Hyp6ZGkubdVmnBIqrU3M/5E8
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 08:37:22.4009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2efb7f5-70a0-40c6-5c37-08df0a5fbd54
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB6910
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

Add a software ecdsa driver so it is
now possible to use ecdsa signature on
board without ecdsa hardware support.

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- no change
v3:
- add depends on ECDSA_VERIFY to ECDSA_SW
- change sw_ecdsa_verify to ecdsa_hash_verify
- v4
- use ECDSA_MBEDTLS to build the driver
- clean include (change order)
v5:
- use $(PHASE_) in the Makefile for the driver
v6:
- remove include u-boot/ecdsa.h from ecdsa-sw.c
v7:
- no change
v8:
- no change
v9:
- no change
v10:
- remove empty line at the end of ecdsa-sw.c

 drivers/crypto/Makefile         |  1 +
 drivers/crypto/ecdsa/Makefile   |  6 ++++++
 drivers/crypto/ecdsa/ecdsa-sw.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)
 create mode 100644 drivers/crypto/ecdsa/Makefile
 create mode 100644 drivers/crypto/ecdsa/ecdsa-sw.c

diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index e4a4482b7f3..8170e4cae9c 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -4,6 +4,7 @@
 #	http://www.samsung.com
 
 obj-$(CONFIG_EXYNOS_ACE_SHA)	+= ace_sha.o
+obj-$(CONFIG_ECDSA) += ecdsa/
 obj-y += aes/
 obj-y += rsa_mod_exp/
 obj-y += fsl/
diff --git a/drivers/crypto/ecdsa/Makefile b/drivers/crypto/ecdsa/Makefile
new file mode 100644
index 00000000000..89be50824cb
--- /dev/null
+++ b/drivers/crypto/ecdsa/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
+#
+
+obj-$(CONFIG_$(PHASE_)ECDSA_VERIFY_MBEDTLS) += ecdsa-sw.o
diff --git a/drivers/crypto/ecdsa/ecdsa-sw.c b/drivers/crypto/ecdsa/ecdsa-sw.c
new file mode 100644
index 00000000000..bf0c12a8b65
--- /dev/null
+++ b/drivers/crypto/ecdsa/ecdsa-sw.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
+ */
+#include <crypto/ecdsa-uclass.h>
+#include <crypto/internal/ecdsa.h>
+#include <dm.h>
+#include <linux/types.h>
+
+static int ops_sw_ecdsa_verify(__always_unused struct udevice *dev,
+			       const struct ecdsa_public_key *pubkey,
+			       const void *hash, size_t hash_len,
+			       const void *signature, size_t sig_len)
+{
+	return ecdsa_hash_verify(pubkey, hash, hash_len, signature, sig_len);
+}
+
+static const struct ecdsa_ops sw_ecdsa_ops = {
+	.verify = ops_sw_ecdsa_verify,
+};
+
+U_BOOT_DRIVER(sw_ecdsa) = {
+	.name	= "sw_ecdsa",
+	.id	= UCLASS_ECDSA,
+	.ops	= &sw_ecdsa_ops,
+	.flags	= DM_FLAG_PRE_RELOC,
+};
+
+U_BOOT_DRVINFO(sw_ecdsa) = {
+	.name = "sw_ecdsa",
+};
-- 
2.43.0

