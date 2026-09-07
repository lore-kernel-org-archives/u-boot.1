Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC30C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 08:44:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DAA8180BF5;
	Mon,  7 Sep 2026 08:44:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jtp88Fw3BciX; Mon,  7 Sep 2026 08:44:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0DF5B80BD4
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788770667;
	b=HGAnwu8zyu3HPY7PxLLh6sSpBf2TldU4IHpAFFTAf8DoIqHaxp4eYplsc4rfm9ZY03g2
	 7DfKJ5FikoTJngJ8BmqcDwDHGaqPTgQ4GAOx1URGLvSJbXyehZgsQ2oU71fXoouf08P11
	 x7ApyrtnGXnfuJwp5brqNJp87DZcNvxO2tEhJZjAUo9Jrm61HTvhAFptINiwGBJeqJoac
	 p+7KvDRiqYX22bqx5bRaQ16ssFgDxotv5fP6VMyNY8jatESI1daJ7mOy0Lrj23eRegJkm
	 CHqtaxjTC1tV6t3yepIvKrM+YrsVtasp+cc9FME3m4b7qJ19p2qW0kH7vW4Riz+/jZw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788770667;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aOODGfsmG6aVSG0hZtj65s6nwUwLuCn1D631UUWgcOI=;
	b=pSpSfIbmRODlbRM7XV8y9IphmtTg/78sRpY56D/j0VvjmZa+/w9KZHMhISF3Q/wbuNex
	 U9dbKuUlhax6Az9LQbN6oD10EtjQYkDYoaxCphKMIHdAXXUuxVALyocHd3z22ui07PofC
	 Ru+muaoBKwxT8kRX7x09tDIbvvZn+lRYtzLTOAXnYWJFMvnlg3o1xEzJOQMA+YJnJwVZJ
	 1GcQITQN8cCtP2a0AVi4m4g4N2uLWFVpbqjbDA23odLLa/vrqECBVXMAk8etvgReJlr7u
	 zyf2DDizkLB8u0iSONWutNVsyUwwaFd5MNyNRgW+s650v1wTbZ8z71lp1ku3vWkY1wQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788770667;
	bh=aOODGfsmG6aVSG0hZtj65s6nwUwLuCn1D631UUWgcOI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lLW+ps/8Ma5+TD+GhM8pXXUfTChcfmRGCIw+pVASLS7vexlYC/26tcYV7k6ibVHWu
	 ygcNWP9xKF+kkm/raC9H/DxpvBgMbCyyTgXqYqMB2SAvoQDkZHbkUGIa1LMArpTrdO
	 ma3DfKx+7rBmZFUUSSQIPACDl1CWOtwRAHtK/b30xOKw4bJpXTL2S/4XnEBF9l0X7c
	 ee3zR3psu2347+NEY3VN9/63LWuH/CFW6D+2LV/AWQPZi/+5CplPtnCD35AZJnXCdE
	 W8fg9H4P+6OJyzWeg10xpRuzHz+YLla/8AZLZ+3vJeysCdd+a5UaY4UUqTi2F37ruh
	 8AMfRMSuTdRyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DF5B80BD4;
	Mon,  7 Sep 2026 08:44:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 42CA69CF
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:44:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 288014009D
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:44:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HOfsqXAcU3ot for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 08:44:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A8CC840068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788770664;
 b=GxQnguVc4967qqUcHdveZb9Sltdmca4yASu49GQpIynAPPpuRfJpyez9/ZKbfXBCQ3GR
 mD0jVqCO+xRK+MtIWBEx+5tmCYXaApxifIgRqyFmuR0tQ0IBjOQxk+i8wFCqMC2IPhcbR
 wMbBZSp1VIkdAaHBj1d+HD1phpII8eaSIBv6MgthYvHLtC9pdvA600CTLNcLadNC0FSTK
 VuMWk3wNSQ7aBenE0cQ5VuPNTqX7xz00QX99Wd+Oa0wozQ3XFS9HPnceK+fqzTTeLlRJA
 2qpwumH3TsBZIiFNGLusyslT6PEl7Dl8gzcdtGv9JSogUc4Q/G0WjJf7U7blL3ekS8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788770664;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=aOODGfsmG6aVSG0hZtj65s6nwUwLuCn1D631UUWgcOI=;
 b=V7Ms+RrQT0mLA/TZUZ8/os5c11dMQHoreRsEUYUDPlyJ8ZE3s7K2h/E2dUxy3OS1z/23
 O1lBd/MGvzbKKqiicJhPfL2G593ATP31Z54lLpD/hr/DqLhCLMFPblc0RH5hSYjuJMTGE
 mjW1J6n31eO0NFQPp97imzJ6mwpi1JLidRD1l7ph3d8zDMheB3P5Q6ZBmTv63yFgRrmtq
 QIdd5s1PtPO5+IkoBb+yfxNp3MC4t2S0WpzzCrJ0m3TbW/xLKaVCkBNSf5K2KcED/GCi7
 jRlkeuv2HuzLtmVogk0Iq+kbAxKelARh7MXoHKwy/0zSmlUU6sPKxirfr0QQq50k6ug==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b="mAi/ejlw"; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=uhqQQq6x; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=mAi/ejlw; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=uhqQQq6x
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A8CC840068
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:44:22 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68775raj2615426;
 Mon, 7 Sep 2026 03:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=aOODGfsmG6aVSG0hZtj65s6nwUwLuCn1D631UUWgc
 OI=; b=mAi/ejlwONtQ8wNALKw1hwlWcUIGSM79xP/3pjzjIsrFsc19mxszohH3H
 1zvftMNoETLEamwcSiKU86OfSBRj0HIr3Y4fOxNa0UOVkWhBMe7jco1X2kTCn+sb
 uv9QCpRLBXijQ1s+8AfRj6Q6XJMfeklG09B8hIrL36BW6TE22X+x73lcIwEqXut4
 G0PMIP8v+Y7yKDucDd7SPSZWScRuXSH+L/TWu5dOzJ71lQkq+LZ+A6QaRqal87mD
 qYktLVhkpT7Sa7zkQmHT5kbpasit+6pcDZHJSk4Jm/GwEfGotLLi1emhEi8N8vlL
 TfgwyGE9K2sJmszDy541tvcsSbNoQ==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gh43n4qne-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 07 Sep 2026 03:44:17 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCnKBcF2fxfTqnG5YckYuJw9f1zMXJ9BbkIGYCEJj1fr1Z66w3xd4P6SCpg8+cJV/uQKSHzq8xZIeQTG0zn/ntTR2cB/HkoKfS666dUwiXORtvPWUiawFkQFVABoDud0FFYeQ1o10qKFizExsEiEKspEhP6N9aDwB7AXcekBOtk2/pyROReRjPGjsyiaOqrCjDrtsgl/YBHmGiA3SG2XafCcGHWxx6KWTLf+8i1k1T0jHC0zXqDd6MVqzYaIC+L+uH+g59BwhrJIVVYSDgxiOX+3BVJKJl6BAlWD9CHER1mffcmTooF5iUkYH2vxevz7laNF7aF9QSeLsBez4efDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOODGfsmG6aVSG0hZtj65s6nwUwLuCn1D631UUWgcOI=;
 b=WBSlmMguPzbVybjVnEBowWq8RXUqnOqgiJhqsPrpDNbx5HjdLagE39owkAXskoUGqxwTsQSHhfcVPxJFTDA4iUu72/E5JkLqmkmVBhbHZn+mA5IBh0oOQ3ozQMFFn6T422FTdv4OCeeuF+UbwqnCEQ2q8+HbtWM7Mdozh1BxrRPfLFc3JJAL4Rpns+Ar/gjAunUV/oc85uvon7+zaHjk5m1BtcL24zm9vO2rrwyljZln6NELUEtvLFzfoDoPNEWA7DBXBuWuBstMUrLdihVoC4mpn9FDuvgbO8zYpQb601tO2FsQvfWZb+tEqMDKHXoi9e+RcnnHObTRySSFUeDL4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOODGfsmG6aVSG0hZtj65s6nwUwLuCn1D631UUWgcOI=;
 b=uhqQQq6x1u6GfxREbA7IaM/8SO/wrnvsCiz/hHsjK0uOn/gFv0UiD+p1Pa8+JC4sabsMz3uXbUInrB6Td7x6f3CnJQ1tcEly5OSX7EF+gOe3NWFIgj9T1/kpmsxEiDlU2U7LuYNJXnVauyDNkXxaDQ+HIau7I+tnlWGJivoHcN0=
Received: from CH0PR03CA0445.namprd03.prod.outlook.com (2603:10b6:610:10e::31)
 by IA3PR10MB8299.namprd10.prod.outlook.com (2603:10b6:208:576::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 7 Sep 2026
 08:44:12 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::8e) by CH0PR03CA0445.outlook.office365.com
 (2603:10b6:610:10e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 08:44:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 08:44:12 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:44:00 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:44:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 7 Sep 2026 03:44:00 -0500
Received: from [172.24.21.163] (lt5cg60819vj.dhcp.ti.com [172.24.21.163])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6878ht1c184965;
 Mon, 7 Sep 2026 03:43:56 -0500
Message-ID: <228430a5-ea74-4b70-8e62-bae9f7891d6c@ti.com>
Date: Mon, 7 Sep 2026 14:13:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/21] arm: mach-k3: j722s: Enable LPM resume flow
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, "Andrew F .
 Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof
 <bb@ti.com>, Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Kendall Willis
 <k-willis@ti.com>, Abhash Kumar <a-kumar2@ti.com>, Thomas Richard
 <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 <u-boot@lists.u-boot-project.org>, <u-kumar1@ti.com>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
 <20260828135730.1565643-18-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260828135730.1565643-18-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|IA3PR10MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: ce16a769-6b54-403e-28ca-08df0cbc3113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|4143699003|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: i3nWqAaLNT4l/UWfjbyy8sAGVjPv8TLnfhWJPZzpWSZl2KMI22XP/3r2gAMXMQfwYKpNFi+iaopikdlcD1nQcOwvkpBdDuF1bpdzgrqWf/8ZvjaSxZRbLA3tPVlMiVcdjwXRtYGSh2oxBob2Gru+lFe3ceH8yW1cpPp8dBcc4VbOEXYvxLWQrSeik21qHgcNp/w+f6PFK6aM9hp3a0rRapSi9TKen4iPi/THcPeK4HkOt7aUB4cErXgLsKwAD+hLV3X9WGdykhKXDidifUmdCrzj+7wqrwvCu1pLQqhJ8greZnFAofxsyC/iiqi21a5gYSYxwrVd/d3v+UD65iv++rgQIlJf2778MFdzWjftF1C4ls3z8EuOI8TokICG5Hq/vTJulOhypVluJyNTNQOgWXIzwqHCfbuppZo3dO6e6FOJ94+5xqruW7e45hqcBgJeKdQyTdREz6T8SicO6BrjDM4sKFk/psWBJ/vsJKQbyGqPw9UYu/tAuOyQ4O6+5RpaKRs9GywU5LP9DAm/quw47jLhnlXt4CrDdjVG3Hyu++kYid40MHd+KFBk7B4z4sovHbNN5j/+6R1tisxg+CUlIWFhRK3XteD4gcq2RCs6GIP4+J2a7TvNN8Y9VVvSjfIGBD6QdsYJKyy81cwAEKr8oLh0lFVxQ4AUKKUQzYP8V8iJZB87ent4XD+39WELYXxGrr7+vwt3JAFDVqzVt0Orag==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(4143699003)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FBMKt+GoMhBqigtlZZa0ltzBcPPCAyH0KsGQljOzWyOb74uKHPsIb0tohw7rz4wa/846kyUvuPyX484eM1NSM2icq5e4teE9qc47PlpIrXvdZYyOj3ppOA8z+icWHms++I9trrHHDmy8xmBi4AkTJPnl8Oel7ciQy7hXikHCn5MQAEUmkKp/zcBiS9cbAcv48hGYXcsz1UKRKXqNVp284ZFQDrRaJogn42s7wb0VseeRehqUhCrLJAzsHZRmasyGMRGVoW5D9DcA3JFRu0TZs3nltkRkT+wdz2o4GCRjWfJALa6tTI0N3meWM2C6QC8/JaD4nvBTTzSA9v2CuD4fa/66kDxcbZzI3Cvl/WgF9hYy8YsOSOpJJSINO2VyKVO3dRtS1hH7nBTNHPBeZkk/AEZOi+0gt8G5Q6U/l0rkwZ+Bg0z+e5CVUSf1bHmasrT6
X-Exchange-RoutingPolicyChecked: CTmSiEX9lMDDVGIHwJMMRA+Fas3d1kXLmiUE16xRdqeUxh23TDcnzF9x5lMTC9nsNjMMk05epwi0PEbvlf4CAZ+YKT8bBaIZf0ZutrEG+4gl1jAvErUkSlAWBPRcKRyK6NuzpmoV27sukSHnemVpJKXLnRYrFOQ5YiyVtM7FAVx8uQ/L3rujJG84NxQi/BQVL2V6u2dakNhZCi3OkzUAODnCdydejhgG6jimSfvxgmZ0Ko+chlr9yvyz2woeH4+Wg6H9lUxq55nlYjUOn5zqmejkb0tMygOF/HVtpq7j5b34c69Sf2nN5qH0a+M8vO/YIQc040P42QIZdmsTwKf5Nw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:44:12.5442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce16a769-6b54-403e-28ca-08df0cbc3113
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8299
X-Proofpoint-GUID: neU6bBMvcpHnDX8_dRfPeeEngXJOua_G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA5NCBTYWx0ZWRfX5cup+pWzOEUq
 bW+fjxPa4hAD1Bfi0VLC8Ag5alKNXXa433up9eQBt7SPQTkjgw7qVx7E0eRjwGfE826dH25A3F7
 NvnIDUFCZAk4T3MVo6Q8ilt03w7rmfHRLeSrgdTBR0GuZzb3U65iOaR5xK79zVx4+NVhUeMk+Ql
 q3A8zNAnb6Jlgm/J1MNoH0gkMQQ9V6pQg+174zZzU8MtdC2iSLgmN7pOpRXQ9pWyUBbvOBGeRMb
 RApBve9cQJLB1OfbuSPOfWKOGMKEMKDOWtn6lq4gXjsKVG7TmbXrkWGEQqI3ZWEuFzGZ0L9paT7
 SEoCcFN5xaxMGMIEA4BVqUqq/1lYtOSFsahgrhmMJ0xOFdHVwVRT4upa04+5BMA+v3/RZwNnc9h
 wPT6FVQBH+7cCLX+zuwNuVUL85ksk6ORvtZG27g3WXPDxnk5yuS7FT3zw9Je0sHNiHr799KvxdW
 Kgcvu2Q3VisJHu7iRDw==
X-Proofpoint-ORIG-GUID: neU6bBMvcpHnDX8_dRfPeeEngXJOua_G
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA5NCBTYWx0ZWRfX6Ji2aKh/RNTO
 nig67AZo4dUw71ZBV2wfltC1wN3sxow/kVDl6XGAn3i9PSPq2aw1+BCAVNbCg+PR/B8BWHiNx5g
 IbyFTYT7mV/29dH6wJaAJKpC1GVlvDU=
X-Authority-Analysis: v=2.4 cv=JdSMa0KV c=1 sm=1 tr=0 ts=6a9e7961 cx=c_pps
 a=UidE1AiM3qFEYM2TBOftzg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=P-IC7800AAAA:8
 a=odxLP61NqB8XyDw-E7kA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070094
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



On 8/28/2026 7:27 PM, Richard Genoud (TI) wrote:
> Add support for resuming from suspend in board_init_f for J722S.
> The resume state of the SOC is identified and lpm resume
> sequence is followed accordingly:
> 
> - Extract context address from devicetree and send to TIFS.
> - Power on the rproc cluster.
> - Replay the certificates attached to saved images of ATF and OPTEE.
> - Resume sequence for context restore and rproc resume.
> - Image entry to DM firmware.
> 
> The context address area is firewalled by TIFS to protect it from
> other hosts.
> 
> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> ---
>  arch/arm/mach-k3/j722s/j722s_init.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
> index 1180c75f551d..e98c9d93ac53 100644
> --- a/arch/arm/mach-k3/j722s/j722s_init.c
> +++ b/arch/arm/mach-k3/j722s/j722s_init.c
> @@ -14,6 +14,7 @@
>  
>  #include "../sysfw-loader.h"
>  #include "../common.h"
> +#include "../lpm-common.h"
>  
>  struct fwl_data cbass_main_fwls[] = {
>  	{ "FSS_DAT_REG3", 7, 8 },
> @@ -37,7 +38,7 @@ static void store_boot_info_from_rom(void)
>  	       sizeof(struct rom_extended_boot_data));
>  }
>  
> -static void ctrl_mmr_unlock(void)
> +void ctrl_mmr_unlock(void)
>  {
>  	/* Unlock all WKUP_CTRL_MMR0 module registers */
>  	mmr_unlock(WKUP_CTRL_MMR0_BASE, 0);

Apart from mmr_unlock things, rest LGTM

> @@ -186,6 +187,9 @@ void board_init_f(ulong dummy)
>  
>  	k3_spl_init();
>  	k3_mem_init();
> +	if (j7xx_board_is_resuming())
> +		do_resume(); /* no return */
> +
>  	setup_qos();
>  
>  	if (IS_ENABLED(CONFIG_ESM_K3)) {

