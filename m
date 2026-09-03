Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10A7C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 08:17:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DF26608C6;
	Thu,  3 Sep 2026 08:17:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ahsKy9icq-Dh; Thu,  3 Sep 2026 08:17:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8EACA608A4
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788423448;
	b=TbfXx/ocHm7G7k+Czuhx433I13tzMQCK80sjscSfzjPiTT7PtsM9ATY3zq4RYHL+2bGy
	 MZ6O528/ffKDar0Em/QToZZl779AEqIDmzY9DySmxARZZ5JOCKB8rTTXq4ATb0FzjqQ/0
	 Gs60svcBoi5jRlE/lF4w3G/zEQssS3iL9vH/vLy4x8z0VG9h5u29mdvHvxfuZ9HwpfWqd
	 aw46w/vPFPL1vZqr1wCEFbvLuBrGnT4bwpIY6eKHOzof0vEgQcMJtgY0HYDf7kVx9O97x
	 yEM0JjE/kHZggAsWGu7SOObygoBKEqJd/oMSrG2yzYPInxVNPxNAXx38C4btwXEphYQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788423448;
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
	bh=e1sHt4newV07NBuB4os4tXQZqNfM/vrpw/xyq9U/7rQ=;
	b=D+RCi19iPtDEJsjbXtWmt3pjPjb4zNeNqjlRH5rwBLSw0xwJ+VdgoQMklxg230XdJhZX
	 rhqys8E52ImVJi/4DhRPr+0a5Yh9sGBZkLPVNhJdbGQrbExoRV3ucMkEvN44mLCwZFiUN
	 Ni6gmmPZs3oPx9L/zAZPEVzwvzAZBTkEYMkKZGfoejM/aKGJm0EbpGVnW5kdApB5IdIwW
	 WuAlXnU8u7EcqIaaPfsoydBavOHwZ+esHRGkzlFmVFBpJiRoXS/Ws1+hx6wcwKx5BZfk7
	 XEr0GQClMyEtp9rd2Gy0lnAgZGOkd9YMQsT3sBK0wI/aOTuxv7KxeoKkkD/XvlP6CxA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788423448;
	bh=e1sHt4newV07NBuB4os4tXQZqNfM/vrpw/xyq9U/7rQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nWIGjEJdessqbkOIyXsgXi1lWAZpU7mTD1QhKi/Z86Gm/R8hajHBMykxRgViPvohb
	 Sf8VesWQbFPmnW2npzkJr17b6muE1PFygsKVWkIG+OMJOP25eh8iy1BuiI+wb7cyVT
	 kndyXaBvVJPOEyXTATSEdewWkwTJk/Zs4OENUMsBTYioPmXDQtheh4j3vaPtlnLFrP
	 vhC4JFBBVy3A81uh0ouUE9vCYhwDnGvhZtKyj65z68Hy2kjlsVaSeP06LCCvpai6jf
	 GajzkCPWXNsxHsjKWVMbdV33v0SpcSutnt2cdP+/ApUn/AYrgzC1dsjXqWu+FsNnaf
	 cr1raTssVomgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EACA608A4;
	Thu,  3 Sep 2026 08:17:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CF6E32100
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B19B64002B
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DF4zTdukK5_1 for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 08:17:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 71D9F40084
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788423441;
 b=B/Zj7Xw4iV+L6hRcU2FhCZYX/5TiA6xFlz1UfZvM2sC+X9ScOigcxER5KrXQOOvSV9s9
 JmTgZZM4RJ4w9lZtdrHRlolV0+aPhX5FRHUtkc4CjT0y5SEQ4jxH1GTssDosqnjN3319m
 vXU3a/eXnu2CpDNVDLRr7LIf9bDwEzAQhQraDdu9hu5KuA0y5ktIej8V/FEMzn+PSfc+4
 +tzi1lBaWlivYcXomJGbNxGJwYk21LfUK11nRCxt6BtazycXz5OJDRyqgxAIgNiJv84xP
 iLoHO9jLknLQPrK6+oN3jIoWBFxZmiGOGHmq9Zm7GP94R3SmNyTmcK/XNmFi918vLDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788423441;
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
 bh=e1sHt4newV07NBuB4os4tXQZqNfM/vrpw/xyq9U/7rQ=;
 b=NgcD5Vk63G05tfxu8+3p/H0CHpqEK1AUkNQU/W4XPRbSTG+lQLVVzYUh1M5Su116bauu
 /oA86CcYLxqzyNTbJQ4FNCAhpQBK/F/oSzzfV7OVeRokatORwMvAYVMd6bbz52+/hlbsb
 el9DkmULWMamxXcsztxaMJrj/BGAJ5BUPZSLv6CmOSgvTF0jz72n6Ie4ELLQap0Hqwc+P
 MzNbJ+UarXt8BmvTfDQIJoqCtmvARYoNk2ddU2FLoFBiyfJAejk+s6pd4fCLb68EFbIVj
 4XjpqD1lntnszIRKLWyABNOaiqjvqfce1ftTHu9MlW/IULjWiLvZIVgo5CChDrQFuHQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=dTobrTOY; 
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
 header.s=selector1-softathome1-onmicrosoft-com header.b=dTobrTOY
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 71D9F40084
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omxuxuBWRevYoKkWloDT6xsvVlq01uilYGSfL9rbTy4FKffXifAtiyvta+9PFf5o8g9T3ax02+O6PQyH4HvuGgiHdkc2GKUjQJ69a4dylXdsdTv7EzHaRYV1sYDEaqSYFbkrgqvq2TPTuGEUSrAJKO40/+PwIyi5KQR01/6ij6ZjYcIMhwor4/7XQUCX7aetwr4gPrbowU8hx6HNpufXKbjINNvhNLM8JSe6TDiDuolj6XHH1jC0wevXOqSB5lqDYgMRee1O8clDqJ2jsOvgvo2VGKonyEAwvoUl5APLIxRFcJbZghEY4HJhcj1lg8jqK++TAarSaPQ9OOFv+lIjYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1sHt4newV07NBuB4os4tXQZqNfM/vrpw/xyq9U/7rQ=;
 b=MYUhzp6qHe+5u86HvaRy7pJlAXjtN8DCCtUjAyouRrWMNOyhEw/UUCOe7tQFSMBEctkEGeZx7GKrZnTLWqSDoMR+iCPAAyF7nrtxfMp8d6cd2kOp84Mc3fuXR82VyololoBXiaiOcYKM8iXNaFapYwXhQIJNKmHbCfWurT24inkWDDbKf7Fo2NqcdlQY5qyEBiDYmzQFOOBfcC2Zh5Uf5GbArko/zylzeK4hOnjDg9DaqptjK813GwtjXM+IgOhhxunWcq0wZF95P4KZ6fD6vk0RbU/OYHE0P/qYZdsi5MJm9eJwgMwH5X8vddmMEgpAKXkS27ZfjgEZJZBUXvy1ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1sHt4newV07NBuB4os4tXQZqNfM/vrpw/xyq9U/7rQ=;
 b=dTobrTOYtTIj5r9X8atA6ODuScAwvWA/99ZWiGok2KZMg/CnqAAff9vdc0lWSAM3rQqxYbWxD5p3E0P3VYwOtI0VZHj8uc+sUi/AxUSgDKhddvwJVQv/bXyRhftP0KvLaiDxKsP4aBhKb2PjFbSkMHUwpmsXrmzfQEcWfzZwTe4EQAL9GIKBFvcjn8FrjmU49Bp3n13PDNkp3nBPEgRTh2ojJ8wYPcqzCnUBNvWNj8byZRltz6FXScs+J4wNzmn6oKEM7yYHOt41fNBUxg/vsJkeUJu/94MhC52kmDymPtG1PDAlUKljGi1/uY6fF6ftlQHdMiyVh9sb0rM+xtbgbQ==
Received: from PAYP264CA0019.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11f::6)
 by PA0P264MB7377.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:57e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 08:17:16 +0000
Received: from PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11f:cafe::8) by PAYP264CA0019.outlook.office365.com
 (2603:10a6:102:11f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu, 3
 Sep 2026 08:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B8.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 08:17:16 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 5FB21201AE;
 Thu,  3 Sep 2026 10:17:16 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v9 03/15] ecdsa: initial support of ecdsa using mbedtls
Date: Thu,  3 Sep 2026 10:16:53 +0200
Message-ID: <20260903081705.12894-4-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903081705.12894-1-philippe.reynes@softathome.com>
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B8:EE_|PA0P264MB7377:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4ed2e6ec-0955-440d-0fc9-08df0993c42a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: XSkixJLtClXrMEK3MNIHK7yqOltun9D3tqtjQHb9uNtig82SnHQuyPHNYLxYpicz8qP5YWOhnAu7o3VLEu8T94SUzvv/VtQUw3AV/2LCxx9KjQH6z4UKUVDuWonnBrio4jNb8o+GOV1qCBTJyI3dYMMGRbrvCm/GJwo8gDqIWAV5ZGsQyEaG8zGXOyIh4nd2VOsn0Lr+x1B45P6gRKTCSb3uKd0FWzzKq3blHAPbcE4RtgUX4VtPmpfF/Qg2YUZiW/dv9NdflkjdrtJREiovG9g4nYE1dQpVqQMDKFWX6TFsafVi98oPxjFDbkeDw3qHVUTBzIgiEtd5E5mQD0RN1SsMFcB3cDqaMbiiu4ycYoh6QJ/5NgcDPImWTkUHYoytCapf3sCa2gZHvDkIq9epMCBJ1SIfdQzOPsuDKCRFnM3eea/VNF9ZjpUBXXZPURCrcK6EsFhOLzVSHkTnPpTn7bkxxTTgm3uhJHWQoQjty7BM/kfq++Z9KeZyk3MrpdgirILSd5oQ8jrCgGmKHYjicKcVf0/G4NmOH8AOBNpH8KFYG9Mc4FSFDuh6Ey+8QylK3/4QWqJ9tuFw47W+FsaYKFXIOxmQ1r+SVEqKzKMX8UKlmo6szv5aeVT0MXEosfdXl3jr9/dsG565aYP0VEXU43BMG8LoruHQntySSDu8afXs7GS7JsXO1smWrCeGIDo8tt79aV9OJyFDxm6uJ99Aqg==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JHDcBu1sIpHnyjrmiUkzQODXR4H6Fwk+cM5S025k4N/OkTdpIJzQ9a00C8S7va/BV9y5CDZDrpJ6iaBtrXmTm6fZb8TvNAlkK4e6o9F9mQTWfHP2qGqJ2cmzQjbtbbHKqCXJtk+/AT7Oo/EWf0uoM80kmvXo1M40/AESeBbcUL304Vml4mdXJOQeEfX7BJCGv4uWFPJA35c4/ICz7t+utiq4n6PeefaYWxdi1MPTTcZ6qChVKUGqycr0U8y2OFGh1kK6fBpK7UVNV/u7SSeiCjY88gD0BiNqqmnNmmm+mDct6pC/GAWnXFQzV3KsRTbE9noSDF9LTDboqhNqop9GnfN0XDZFmDQZetUaFpvsTeCRHa+9FU7HKIuFiiEoC4xGOcG9vly5E3GdIZnTKiwUJifoJhTcnMAQIdgowJL7mGu2EHWBRhdpgqztdZEQtgtt
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:17:16.5351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed2e6ec-0955-440d-0fc9-08df0993c42a
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA0P264MB7377
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

Adds an initial support of ecdsa verify using mbedtls.

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- rename sw_ecdsa.c to ecdsa.c
v3:
- rename sw_ecdsa_verify to ecdsa_hash_verify
- stop on first group found
- check signature len
- use debug instead of printf
- check function returns
- fix memleaks in ecdsa_hash_verify
v4:
- move struct ecdsa_public_key from ecdsa-u-class.h to internal/ecdsa.h
- use DIV_ROUND_UP
- some code cleanup
v5:
- add kerneldoc header for ecdsa_hash_verify
- read error when setting Q.Z
v6:
- add ECDSA_VERIFY_MBEDTLS
- fix kerneldoc: doc not add a space before :
v7:
- no change
v8:
- add some useful comments
- avoid using label such as out1, out2, out3 ...
- code cleanup
v9:
- no change

 configs/sandbox_defconfig       |   1 +
 include/crypto/ecdsa-uclass.h   |  15 +---
 include/crypto/internal/ecdsa.h |  39 ++++++++
 lib/mbedtls/Kconfig             |   7 ++
 lib/mbedtls/Makefile            |   3 +
 lib/mbedtls/ecdsa.c             | 152 ++++++++++++++++++++++++++++++++
 6 files changed, 203 insertions(+), 14 deletions(-)
 create mode 100644 include/crypto/internal/ecdsa.h
 create mode 100644 lib/mbedtls/ecdsa.c

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index b9991d269d9..63682ef0e74 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -390,6 +390,7 @@ CONFIG_CMD_DHRYSTONE=y
 CONFIG_MBEDTLS_LIB=y
 CONFIG_HKDF_MBEDTLS=y
 CONFIG_ECDSA_MBEDTLS=y
+CONFIG_ECDSA_VERIFY_MBEDTLS=y
 CONFIG_ECDSA=y
 CONFIG_ECDSA_VERIFY=y
 CONFIG_RSASSA_PSS=y
diff --git a/include/crypto/ecdsa-uclass.h b/include/crypto/ecdsa-uclass.h
index 189843820a0..047a5eda2fc 100644
--- a/include/crypto/ecdsa-uclass.h
+++ b/include/crypto/ecdsa-uclass.h
@@ -4,20 +4,7 @@
  */
 
 #include <dm/device.h>
-
-/**
- * struct ecdsa_public_key - ECDSA public key properties
- *
- * The struct has pointers to the (x, y) curve coordinates to an ECDSA public
- * key, as well as the name of the ECDSA curve. The size of the key is inferred
- * from the 'curve_name'
- */
-struct ecdsa_public_key {
-	const char *curve_name;	/* Name of curve, e.g. "prime256v1" */
-	const void *x;		/* x coordinate of public key */
-	const void *y;		/* y coordinate of public key */
-	unsigned int size_bits;	/* key size in bits, derived from curve name */
-};
+#include <crypto/internal/ecdsa.h>
 
 struct ecdsa_ops {
 	/**
diff --git a/include/crypto/internal/ecdsa.h b/include/crypto/internal/ecdsa.h
new file mode 100644
index 00000000000..244a07d1f1f
--- /dev/null
+++ b/include/crypto/internal/ecdsa.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2026, Philippe Reynes <philippe.reynes@softathome.com>
+ */
+#ifndef _ECDSA_HELPER_
+#define _ECDSA_HELPER_
+
+#include <linux/types.h>
+
+/**
+ * struct ecdsa_public_key - ECDSA public key properties
+ *
+ * The struct has pointers to the (x, y) curve coordinates to an ECDSA public
+ * key, as well as the name of the ECDSA curve. The size of the key is inferred
+ * from the 'curve_name'
+ */
+struct ecdsa_public_key {
+	const char *curve_name;	/* Name of curve, e.g. "prime256v1" */
+	const void *x;		/* x coordinate of public key */
+	const void *y;		/* y coordinate of public key */
+	unsigned int size_bits;	/* key size in bits, derived from curve name */
+};
+
+/**
+ * ecdsa_hash_verify() - Verify the ecdsa signature of a hash
+ *
+ * @pubkey: ecdsa public key
+ * @hash: Hash
+ * @hash_len: Size of the hash
+ * @signature: Signature
+ * @sig_len: Size of the signature
+ *
+ * Return: 0 if all verified ok, <0 on error
+ */
+int ecdsa_hash_verify(const struct ecdsa_public_key *pubkey,
+		      const void *hash, size_t hash_len,
+		      const void *signature, size_t sig_len);
+
+#endif
diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index e019f17d6bd..66bc16db451 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -308,6 +308,13 @@ config ECDSA_MBEDTLS
 	  This option enables support of ECDSA with the MbedTLS certificate
 	  library.
 
+config ECDSA_VERIFY_MBEDTLS
+	bool "Enable ECDSA verify"
+	depends on ECDSA_MBEDTLS && ECDSA_VERIFY
+	help
+	  This option enables support of ECDSA signature check with
+	  MbedTLS certificate library.
+
 endif # MBEDTLS_LIB_X509
 
 config MBEDTLS_LIB_TLS
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index 0c86c90d15a..b96db812afc 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -11,6 +11,9 @@ obj-$(CONFIG_$(PHASE_)SHA1_MBEDTLS) += sha1.o
 obj-$(CONFIG_$(PHASE_)SHA256_MBEDTLS) += sha256.o
 obj-$(CONFIG_$(PHASE_)SHA512_MBEDTLS) += sha512.o
 
+# shim layer for ecdsa verify
+obj-$(CONFIG_$(PHASE_)ECDSA_VERIFY_MBEDTLS) += ecdsa.o
+
 # x509 libraries
 obj-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
 	public_key.o
diff --git a/lib/mbedtls/ecdsa.c b/lib/mbedtls/ecdsa.c
new file mode 100644
index 00000000000..ca4e572e638
--- /dev/null
+++ b/lib/mbedtls/ecdsa.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
+ */
+
+#include <log.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include <crypto/internal/ecdsa.h>
+
+#include "mbedtls_options.h" /* required to access private fields */
+#include <mbedtls/ecdsa.h>
+#include <mbedtls/ecp.h>
+
+static mbedtls_ecp_group_id ecdsa_search_group_id(const char *curve_name)
+{
+	mbedtls_ecp_group_id grp_id = MBEDTLS_ECP_DP_NONE;
+	const mbedtls_ecp_curve_info *info;
+
+	if (!curve_name)
+		return MBEDTLS_ECP_DP_NONE;
+
+	/*
+	 * This curve name is read in the FIT metadata.
+	 * When this FIT metadata are filled by mkimage (or binman),
+	 * the curve name is the alias/name provided by OpenSSL.
+	 * And for secp256r1, OpenSSL uses the alias prime256v1.
+	 * So here, we have to manage this OpenSSL alias.
+	 */
+	if (!strcmp(curve_name, "prime256v1"))
+		return MBEDTLS_ECP_DP_SECP256R1;
+
+	info = mbedtls_ecp_curve_list();
+	while (info && info->name) {
+		if (!strcmp(curve_name, info->name)) {
+			grp_id = info->grp_id;
+			break;
+		}
+		info++;
+	}
+
+	return grp_id;
+}
+
+int ecdsa_hash_verify(const struct ecdsa_public_key *pubkey,
+		      const void *hash, size_t hash_len,
+		      const void *signature, size_t sig_len)
+{
+	mbedtls_ecp_group_id grp_id;
+	mbedtls_ecp_group grp;
+	mbedtls_ecp_point Q;
+	mbedtls_mpi r, s;
+	int key_len;
+	int err;
+
+	key_len = DIV_ROUND_UP(pubkey->size_bits, 8);
+
+	/* check the signature len */
+	if (sig_len != 2 * key_len) {
+		log_debug("sig len should be twice the key len (sig len = %zu, key len = %d)\n",
+			  sig_len, key_len);
+		err = -EINVAL;
+		goto out;
+	}
+
+	/* search the group */
+	grp_id = ecdsa_search_group_id(pubkey->curve_name);
+	if (grp_id == MBEDTLS_ECP_DP_NONE) {
+		log_debug("curve name %s not found\n", pubkey->curve_name);
+		err = -EINVAL;
+		goto out;
+	}
+
+	/* init and load the group */
+	mbedtls_ecp_group_init(&grp);
+	err = mbedtls_ecp_group_load(&grp, grp_id);
+	if (err) {
+		err = -EINVAL;
+		goto free_grp;
+	}
+
+	/* prepare the pubkey */
+	mbedtls_ecp_point_init(&Q);
+	err = mbedtls_mpi_read_binary(&Q.X, pubkey->x, key_len);
+	if (err) {
+		log_debug("could not read value x of the public key (err = %d)\n",
+			  err);
+		err = -EINVAL;
+		goto free_q;
+	}
+	err = mbedtls_mpi_read_binary(&Q.Y, pubkey->y, key_len);
+	if (err) {
+		log_debug("could not read value y of the public key (err = %d)\n",
+			  err);
+		err = -EINVAL;
+		goto free_q;
+	}
+	err = mbedtls_mpi_lset(&Q.Z, 1);
+	if (err) {
+		log_debug("could not set value z of the public key (err = %d)\n",
+			  err);
+		err = -EINVAL;
+		goto free_q;
+	}
+
+	/* check if the pubkey is valid */
+	err = mbedtls_ecp_check_pubkey(&grp, &Q);
+	if (err) {
+		log_debug("public key is invalid (err = %d)\n", err);
+		err = -EKEYREJECTED;
+		goto free_q;
+	}
+
+	/* compute r */
+	mbedtls_mpi_init(&r);
+	err = mbedtls_mpi_read_binary(&r, signature, key_len);
+	if (err) {
+		log_debug("could not read value r of the signature (err = %d)\n",
+			  err);
+		err = -EINVAL;
+		goto free_r;
+	}
+
+	/* compute s */
+	mbedtls_mpi_init(&s);
+	err = mbedtls_mpi_read_binary(&s, signature + key_len, key_len);
+	if (err) {
+		log_debug("could not read value s of the signature (err = %d)\n",
+			  err);
+		err = -EINVAL;
+		goto free_s;
+	}
+
+	/* check the signature */
+	err = mbedtls_ecdsa_verify(&grp, hash, hash_len, &Q, &r, &s);
+	if (err)
+		err = -EINVAL;
+
+ free_s:
+	mbedtls_mpi_free(&s);
+ free_r:
+	mbedtls_mpi_free(&r);
+ free_q:
+	mbedtls_ecp_point_free(&Q);
+ free_grp:
+	mbedtls_ecp_group_free(&grp);
+ out:
+
+	return err;
+}
-- 
2.43.0

