Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D19C624DB
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 08:17:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC8F0810B3;
	Thu,  3 Sep 2026 08:17:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sdc7F8LIlMyw; Thu,  3 Sep 2026 08:17:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DCCA281136
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788423476;
	b=DcOq9cLXMZz9E6b53QO886GpClXTgnPSrBluz0FIbj0Xs32WMo4yH4gfDcwpZYY4x5Ct
	 J9io1ZrDG6yCXFsv4a/558TjO+HI06rpOZMq55hRn6ZRwCHdCL3KA7scTI0+NYZq/rphz
	 kXJTeFdxRjqVYZ+zczW0Cgw+1D29+rGWUtVqL+XVqhovMrlfs53diE5GpukvU/h9f8DZO
	 NBWwU9tmoZGtNMeyLjsiXTNsyUaaRT/4q5xMZhybdn64A3k8nxm6oWN9sW/53scH8rDh+
	 4AWUcl7KRMxt+yxzZRBfBCENqbNEgUH7p8HDlibZDDnlb8o7tzWkGFrfTHlcGxTwSUQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788423476;
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
	bh=g0QyAAGd1tslXVrOf/99d8Ttc2DPV++F2mLgjm/Zq24=;
	b=L0RcdgbMZ36xaNB1GTP3YZWS/9z/3xhvjiyCquSzGr3am6duDN294i+5j2527/A0YKlB
	 vIUeAKUQA8DpTWu0AafBgJM1yJigAVOA3CZHmDwA+sl7ZwQbIcvn6kT7OOJhyDzKz6qWU
	 NDgAjTtvRYoxywG4S4Fya0cEQz85SGnzqp7YVr6ZP0GEil+eDvgXDGex/O/VryY557kYG
	 U9SrSXXwj20JqIteqwJ/oE0mgElqW3hgp01K29LlDLl+PWsUGyll3se9Rfwac/1BNYOGX
	 r49Evi+0Gd7Cv2FEHIuoK8zXlLGmGgC7f+1rGzKy0gqqOmvoNkA0D2yuW2cI+CpaenQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=none header.from=softathome.com;
	dkim=pass header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=XhQmwo3k;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788423476;
	bh=g0QyAAGd1tslXVrOf/99d8Ttc2DPV++F2mLgjm/Zq24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qFV4iZhYaDCaUrMzP9A9rcJlREPpUbAQOykU5g9Ld/pMQXlIjm6654zApvZvfIusG
	 oBmbNAZXjLhMEWBKx4CsM8rM6MVd2+qnGEjGov27wvxKQyTX5UQIGOLh4GRuYNqA0n
	 g4MzPNuIKVFf2BcaLWnz7xk7w46/ReyBHGD5ZnJi45Br5ERtC+wDbMsusBjhGjnM3o
	 pzM7e52u1fw7vM6PNY53ZofbAlvAtW+2lcTxkxzkAe3cGIfpCVyw7d6Hd/+qS+sg3X
	 TM9jKVIr5evh6RmznOglE0W50LUZ9hz84KbVKZ3mk6eH/txE5pzlmrVnkGqECrS2u8
	 o5nSzFV+o8kKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCCA281136;
	Thu,  3 Sep 2026 08:17:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5EA28363
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3ACB380E1C
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DShlKB2BmCfp for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 08:17:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B0AAA8107F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788423451;
 b=Fuy1F33pg1zYioK1FLIHyOaJtCXtOiFwdUWsfT0b1OMQXBvwSJIlPXYrZYTAV9deTiKe
 wkWFWkD4fGwKW3LI/JYdqAjq4SkdWp4oYf5MCIK50T0JQveu7NinJ1Ib35uKLunGaJ3CR
 r6+o+pilH+Ddkps65AbsQLcViFVZepQbpz6eIDlWhrlqiKvI9uh8AS4oWpXne1lJ07USR
 kIEtDhXucnt4nBlWOLIC5dFMau3PvNXLuyBgw+MNABXtO9aaBhqZ74PtbpkWJR+hnSGZr
 M7+QaJ69FS/bL7ldd+1A06WvY8XTKp5sDf8OnfDNTzmr86eCfTDlygbASieD2aBclFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788423451;
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
 bh=g0QyAAGd1tslXVrOf/99d8Ttc2DPV++F2mLgjm/Zq24=;
 b=hOvxdn6IyUcQh/9UnRdyK+7wcEFZm/RV4tLwFIj//XKtk2Yc5zmTYi9x/eBZz3by8grP
 HpJ50klY1d810Vmc1u7yC1FAmRVnluI7JZ8mBRRez2yw9kuUxR0aOQaW91RIPaEdrso+f
 Jrtdi9fFdjYMOysnoArqwBI2cxSKbyAFl+yix02wVJAF76zT2lzTO27V6VwpGO3HupP47
 jdv2nvpJhHT8/OjhQs/VvnrMji5Ae+FvsYj1VyK86+8xzrqMxbi66Y6HVyGjl2TXw+7pZ
 /2a5GChitVWJzgTmEDFuwgwp9nyBcehHeM6FbmRlQEXqlEX9wK+tr855i1hItRFWSXg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=XhQmwo3k; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:c20a::;
 helo=pa5p264cu001.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=XhQmwo3k
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B0AAA8107F
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQ9SGpjLH11KYqd5nd8QYykDlB7pq2ZgbYx0F54Japg0t3JTH2zRUnpmDYnh59iK34bf9DS2UA9Q53chpylgUeudRAjgEyxAOLAHNmz/I132WUErGy6PIA/y8ynPsfS40743ugwjxvRGlAHP93jkh5vMx3k4xwCD2kH209w20yA5gz8L6pXaMMg3AQcI8ogcjJdfGV+3qG6r13iJZgaNtrMU+qE1Cjsi+Gu1K42wUos6HVRWRabIYVCKbQCrNxttO9OENUPOZVJAFFunMXeCuB8geTBn+lMDwR3do/KRLhY6JVABtTY+SMZ3hCCVr55kfHJD1oTigNHXwS0a2KFNNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0QyAAGd1tslXVrOf/99d8Ttc2DPV++F2mLgjm/Zq24=;
 b=r8ORezH9kgaNoSaSQP6qxe+7QRHR0/Lu2rLP88P2EgIUUtSZtlPvxgwt61oKfdOQW5lOsFNkYK031aWsTGfqxfjaasQexnqQhIz3+dZuJDbRBXJ1zvW57MS61tgY6m7Wfz7JJyFmcoLluTtcCWozN/ZWP6ZKHnchbt5BdJ3DsJu+Bjon4Cuwis3Q7bMlH5dIAu9nprKwo4QUc+4pb6OcFVRTEPEdaxPYJPCuveri7R4QAhW5Svv/P2TI7M+qDSUpWEvBvrdgRdnV+Xl4Cw1VRpMupWbKmQOIdeOIik35ykS7vCVpM5AiH5MEHEKLqApOS9RIFPaj+rqRuGTU4LanaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0QyAAGd1tslXVrOf/99d8Ttc2DPV++F2mLgjm/Zq24=;
 b=XhQmwo3kJXrPhkbS2WGjbSXTK8S9o+yV69QDJ705bWuwMm2jS9xD9rY7dwqaS63owVcJDApJcK/36F1Mv+vrj+MAbH7FkthJuZapScVEn8geg7VQizEr1ZfvwSqh/72D43aGJMW1omU+HCLvnsp03WCmwu6NzNhh2PsjtcBVfPhekwmM8y7ISRZDOSYl2q1o6kXaqvpERMDfVbsttMiL2fHiA6v0CfYiKTBFP7YgBlE8fAMB9tUV9TzNsKOHAaLHXgSwImUP1/S+Nmp6EaVswV3xBC1JZ1ueT15hTTpGMxyXmKDK5vaXoE8EG/L0vcmt2tqYpN7vhG1nf+Gc0qf0AA==
Received: from PR3P191CA0057.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::32)
 by MRYP264MB6074.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:6d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 08:17:17 +0000
Received: from PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:55:cafe::53) by PR3P191CA0057.outlook.office365.com
 (2603:10a6:102:55::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 08:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019230.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 08:17:17 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 0CB692017B;
 Thu,  3 Sep 2026 10:17:17 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v9 10/15] tools: mkimage: pre-load: add support of ecdsa
Date: Thu,  3 Sep 2026 10:17:00 +0200
Message-ID: <20260903081705.12894-11-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903081705.12894-1-philippe.reynes@softathome.com>
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019230:EE_|MRYP264MB6074:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 50d1bfc9-1b02-44fc-217e-08df0993c48e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|6133799003|56012099006|3023799007|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6/esxWL0o8wDyajS8fFw0uMOtyXyYXS2NUXBL9pV2mj2DlD1UX0f2oKXzXQeIb1QmoUQj7UXB4I/a2kUy8U+zlBdpqlGe8iKO1x0n6q56hd9zE9twjDuf+0FGjIEKGcekvYLgkuZBpba4ARxXOcvSl6KxrKvgF2cZLokCQaAaaUyHC/B7y8IWE1RSrnPYhsY3N8HOc0nJNzFKb6YCC9okRt6EKg+oVCJiMbVU5W46GRxvAxjFnEe1G8nqBnX+imzqt6d8R9Cyvbx53vWT0zr4JI6JARBODyGO7iCXBjaao+lysYs9DFiaBHGvXxkUmBcKw8CiqL3KTA1evgT+L7tD+teMUhAuAdkbdEsRFmDh94QDUZ6Adxjn8fNlo39kFg6tAd6yyS2xZKrNsaRqU9Gi5R3hhiVBPiCxq2RFEYP3L0lxL7jCimMqDYdTV5yKvYyNAfqilSg+oHqeDV1izSiZNQ33kObz1A8d93tasHHQIrym3Eo27JIKgn5AJbMopz6ZOot9bO+X0Nv6avpRBQUA7ztdGDrsazJ7ldX4EOFqQ2/5VKPkgG86WnAMVPFj2zYbsSG2hmTm9OxaH2WK+5qc6DfwfSP/2hW9F10hYs03oo0Ke/ebW9c4+My6ib2p4Via8bUYSw3KP7Rah/NybiGoHHBL/F1m5wogyEp0o0/UrF7o1DZ7PiLX03u7v9pL2vRGN/Vc9XYC4DbgyNDt0t+Ng==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(6133799003)(56012099006)(3023799007)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kfFLsFTAmXNgFFpH9w0sAR+g0F/CM6yIxs4hpJTaVWsMdiUMHH+CKqLaabXV1U4WG0HZOfqb47wDaQlQ/rBpI3t5qVeg1KpParddUYJbpiPIL4+rR3BGzmfVGMSYywCDSZlniUiDIjOd+eDx8AyhpNuoYC5Egt2zVByTC1fOnq7LdWHpG3f/tQscEUoHKspnua6GL0b/7ZaqvAdFtg+nkukNvBNGE8LNtdGBX9sLk4WSAnwM2ZaUXvSK48o09oBvdCAmjfzJ3kzHi1xEiGX2faFEumwAGsrCuC7lyp6Gn+Pyk7h3OKqT3x08wbVcMuvc1jIkEto8wM37lAWThEqENCyhnI7NUjYCpWhpdJwp8CDTLF5gtym7ItolOrNMxsQsOTeAZ1Tv+VM/IEqcO4Q/S9zy5YRWYYLiLoe1ZiQXwI6tg8o4F/SYNjfNk1AmeXbF
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:17:17.1856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d1bfc9-1b02-44fc-217e-08df0993c48e
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRYP264MB6074
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

Right now, mkimage can only create pre-load header
using rsa. We add the support of ecdsa.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
- use pre_load_noffset (do not compute it again)
- release memory allocated with strdup
- clean code
v5:
- check checksum and algo before using them
v6:
- no change
v7:
- no change
v8:
- no change
v9:
- no change

 lib/ecdsa/ecdsa-libcrypto.c | 29 +++++++++---
 tools/image-host.c          | 92 ++++++++++++++++++++++++++++++++-----
 2 files changed, 103 insertions(+), 18 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index b3fc75fac48..5e69782424c 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -517,14 +517,9 @@ int ecdsa_verify(struct image_sign_info *info,
 	return ret;
 }
 
-static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
-		  struct image_sign_info *info)
+static int search_key_node(void *fdt, const char *key_node_name)
 {
-	int signature_node, key_node, ret, key_bits;
-	const char *curve_name;
-	const EC_GROUP *group;
-	const EC_POINT *point;
-	BIGNUM *x, *y;
+	int signature_node, key_node;
 
 	signature_node = fdt_subnode_offset(fdt, 0, FIT_SIG_NODENAME);
 	if (signature_node == -FDT_ERR_NOTFOUND) {
@@ -559,6 +554,26 @@ static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
 		return key_node;
 	}
 
+	return key_node;
+}
+
+static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
+		  struct image_sign_info *info)
+{
+	int key_node, ret, key_bits;
+	const char *curve_name;
+	const EC_GROUP *group;
+	const EC_POINT *point;
+	BIGNUM *x, *y;
+
+	if (info->required_keynode >= 0) {
+		key_node = info->required_keynode;
+	} else {
+		key_node = search_key_node(fdt, key_node_name);
+		if (key_node < 0)
+			return key_node;
+	}
+
 	group = EC_KEY_get0_group(ctx->ecdsa_key);
 	key_bits = EC_GROUP_order_bits(group);
 	curve_name = OBJ_nid2sn(EC_GROUP_get_curve_name(group));
diff --git a/tools/image-host.c b/tools/image-host.c
index 9a85a3dda2f..ed1bfe68a31 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -14,6 +14,7 @@
 #include <image.h>
 #include <hexdump.h>
 #include <version.h>
+#include <u-boot/ecdsa.h>
 
 #include <sys/stat.h>
 #include <sys/wait.h>
@@ -1681,13 +1682,74 @@ err_cert:
 	return ret;
 }
 
+static int fit_pre_load_data_key_rsa(const char *keydir, void *keydest,
+				     int pre_load_noffset, const void *key_name)
+{
+	unsigned char *pubkey = NULL;
+	int ret, pubkey_len;
+
+	/* Read public key */
+	ret = read_pub_key(keydir, key_name, &pubkey, &pubkey_len);
+	if (ret < 0)
+		goto out;
+
+	/* Add the public key to the device tree */
+	ret = fdt_setprop(keydest, pre_load_noffset, "public-key",
+			  pubkey, pubkey_len);
+	if (ret)
+		fprintf(stderr, "Can't set public-key in node %s (ret = %d)\n",
+			IMAGE_PRE_LOAD_PATH, ret);
+ out:
+	return ret;
+}
+
+static int fit_pre_load_data_key_ecdsa(const char *keydir, void *keydest,
+				       int pre_load_noffset, const void *key_name,
+				       const void *algo_name)
+{
+	struct image_sign_info info;
+	int node, ret = 0;
+
+	memset(&info, 0, sizeof(info));
+	info.keydir = keydir;
+	info.keyname = strdup(key_name);
+	info.name = strdup(algo_name);
+	info.checksum = image_get_checksum_algo(algo_name);
+	if (!info.checksum) {
+		fprintf(stderr, "Can't find valid checksum from %s\n",
+			(char *)algo_name);
+		ret = -EINVAL;
+		goto out;
+	}
+	info.crypto = image_get_crypto_algo(algo_name);
+	if (!info.crypto) {
+		fprintf(stderr, "Can't find valid crypto from %s\n",
+			(char *)algo_name);
+		ret = -EINVAL;
+		goto out;
+	}
+	info.required_keynode = pre_load_noffset;
+
+	node = ecdsa_add_verify_data(&info, keydest);
+	if (node < 0) {
+		fprintf(stderr, "Can't add verify data: err = %d\n", node);
+		ret = -EIO;
+	}
+
+ out:
+	free((void *)info.keyname);
+	free((void *)info.name);
+
+	return ret;
+}
+
 int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
 {
 	int pre_load_noffset;
 	const void *algo_name;
 	const void *key_name;
-	unsigned char *pubkey = NULL;
-	int ret, pubkey_len;
+	char *name;
+	int ret;
 
 	if (!keydir || !keydest || !fit)
 		return 0;
@@ -1714,17 +1776,25 @@ int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
 		goto out;
 	}
 
-	/* Read public key */
-	ret = read_pub_key(keydir, key_name, &pubkey, &pubkey_len);
-	if (ret < 0)
+	/* Is it a RSA or an ECDSA key */
+	name = strchr((const char *)algo_name, ',');
+	if (!name) {
+		fprintf(stderr, "The name of the algo is invalid: %s\n",
+			(char *)algo_name);
+		ret = -EINVAL;
 		goto out;
+	}
+	name += 1;
 
-	/* Add the public key to the device tree */
-	ret = fdt_setprop(keydest, pre_load_noffset, "public-key",
-			  pubkey, pubkey_len);
-	if (ret)
-		fprintf(stderr, "Can't set public-key in node %s (ret = %d)\n",
-			IMAGE_PRE_LOAD_PATH, ret);
+	if (!strncmp(name, "rsa", 3)) {
+		ret = fit_pre_load_data_key_rsa(keydir, keydest, pre_load_noffset, key_name);
+	} else if (!strncmp(name, "ecdsa", 5)) {
+		ret = fit_pre_load_data_key_ecdsa(keydir, keydest, pre_load_noffset,
+						  key_name, algo_name);
+	} else {
+		fprintf(stderr, "The algo %s is not supported\n", (char *)algo_name);
+		ret = -EINVAL;
+	}
 
  out:
 	return ret;
-- 
2.43.0

