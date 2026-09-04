Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6A1C79F80
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 08:37:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC63A81182;
	Fri,  4 Sep 2026 08:37:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mBwYvmWxaleR; Fri,  4 Sep 2026 08:37:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AD7F381170
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788511070;
	b=KYOm7BNGi2OyGalqLtY+V60H9tk582RzxwZPyuWkyi5j0gU1p3Hx+xfUxd8uLNAXYmvh
	 Dic8T47ixzi7GS3Wm+h6cENmlKyO/cCBHoyWfPyeBLqouwhNkT+SdhamHTIkCEE1AsV4X
	 Vb0waYvX6RHeQWpWq9nPhjRuVGib9IzTBKmECNoBKYel9xlJ440de4mJNp157L+blH+Gm
	 hI3oeA6AOBds5TLCBDHGXneY9U2H+Sgnu+x/X31uUFtG14NxsLS5nGzYIOf6e/hRY5Sjo
	 JbvQQpi28cUXZDLiRHiLkfMeETzS4rJI61LabjWL2jIDn+Ja/pWJTPMMWx3TOdb8rOg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788511070;
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
	bh=pzGeEFfQOnetCmyCnvqaNBRYpOX7Vsfarqwyw/m2Ono=;
	b=L9Rm4MtMQZDe8cNe0CIc1ae5Jy97yYxw6h3+ASwhpiPcD0ImWs/XYt2aEH2V4Ksq12gJ
	 4Hh9ft/4i+i0vZ7/0F8HNBCLjDne/haFbCHH8v6LwKSQZmJOGJIHNNLEf8GIj9C9tti2v
	 fnf0HLAhZzplDKC3aEz5zGxBZAGX8781aOeTzO5tjx+w9zl/rkHezn66iNMqXiu8CpHMn
	 jxpl2yaXYpgyHjswm3DAIY+YTGkIugGAVn8SRPIs2V74HvaaM1ATkq+iOCCETKaf/71GJ
	 LYXTdZdtMPFfaOpupd7pOIEafD71ENtOwOhZUyezN1zPV2E3pKa3rleBN+N87g28Xig==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788511070;
	bh=pzGeEFfQOnetCmyCnvqaNBRYpOX7Vsfarqwyw/m2Ono=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FtUb3cyDE3ndLyVXmUwK5LtAmJjhj4saSe/P2x3iFndV0epPX+dbFt5kedUUvuMP/
	 jbwSfcD2alrWLFOphnKwy5yKnM8QBvTRza1LHAme+XD/YaEGypY6js610qhkA3+Qli
	 NbkSmTqjcs01Qa0nyqPYisvwHWQz0Gfh5xMBDlE6gJCUVN2nlkhEfoNMMKzzekgzxY
	 iZidrEIq34Z9SyUrqyZNkoDYYlYNJd20OZwNAkwQTDzGpe/ZqIOZfecByV2vWq95SD
	 zhXdsrqkJpsWgyExNLWUWgGfTsQ0PSYx1Mr9Dlnr7frMJpXEQ7EsR8j1Ovp77kXhY7
	 B7sgkGMPiHo8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD7F381170;
	Fri,  4 Sep 2026 08:37:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C2C503DA
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A73AA40ACB
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PmpzsXmQVnAO for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 08:37:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8A4F840B37
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788511050;
 b=HVLpKpJU0xdGNRu9LRVqo17/PXugf2D/ZgDKJJuK3sZ08zjU9zTIDMWCvpNw+z8gh+c/
 jqkCNRwK5OPPmrG+co3ibfqP3P8o0g82iYh+mrMJKKG/1vUB6e1l3kdg/Qah1hOrRD9Ed
 p+V2xUsO+fmOcbQZ+1/P5qn724vu3T+1pLDt6jnvVFBm4GNR9WVWzyHP2toPhfDMYVk58
 7SGPDMcoQ3cvWYcqDNwHtP1m5P1OSapA7f1bz4eT9H7zS57/3sC5zuw32ClnLkzZ5pFqb
 xQNuNJz0XO78Kl1MvWOF0swhupQ1fZWkHxuOYOeP/ELvruQuPc257cxVpcKRzhsy8PA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788511050;
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
 bh=pzGeEFfQOnetCmyCnvqaNBRYpOX7Vsfarqwyw/m2Ono=;
 b=TKgamu2/yRN4iLcfEDynpo/oUBpAINVSAkYDkhPd+WJYVRy6TbbK3i6I+zwDgQQAIrm+
 80yMhTSOWHpmM55bHXMabwwX0mpsCv9cS2CfbC3UE6BfOo6P7EGb6T5jSVmQmfussFi87
 73gcWnnd1hHPsv6ANZnwf7D8+jms4kZYCcCMQKX57GBUsgmUTYlMrWd7Oeik56HrOeND3
 aQYYXpQliFN9hXTvqOXWj8QEc7iya6iROvkdGFewepBVn+xIWACgBJCFeAej7ZzrQ/rbV
 /ANAItz/XwcS+airc0QvCRhYwwWsZhddtWiUpEcBPLQUAItqR7D+AcnnH9pvThuhRWA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=QP7IAM2O; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::2;
 helo=paup264cu001.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=QP7IAM2O
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A4F840B37
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyCIPjfaqVUR3g9pHDI68Z7TEdZneXseZWRTkfMaex9eywQxuFOXVKvnQim4lKuvyliQJG6KutS/8soawd+EIkGdZbW1n5yUlgCnSIWxfPgLePbvJE+wiUfuXI6LSBo4i+JrgdlLKYkEW1XG05B6DLxrHg6x1dlGoXsVNJM9D7WyCof3c+neOI40bXljR3NmNezzR+CYMh7zPP4wY0RwiH2fU4IpGL2tdvs1faRu7BeAmFlCYSREPF2Yk6fkoKOJvU0pJgSpDYZhP2lyJxhIAHYDaPdSlDLZdwcI6NB92Y8Oi3KU8/nh1j2qzyrb8ucBhldbQWc8xlwpiuxsd3TzWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzGeEFfQOnetCmyCnvqaNBRYpOX7Vsfarqwyw/m2Ono=;
 b=jvWSK1VewBvB61aaQNnB+LEYS75inTQ/tFE8pLpjbE5Ff4Kltv6kJFEryXPmOvpMcLiBa8fqsKEAgGb+Mqq3I2Gppy4XK5pWc8ywuTekrO9L1yRjHP4dMwfzSVUzsb7chiNEv2PJl6pkIruzgd9qRMcwhrDD38Y9ZvGlj4ktDaSbYH2qM7Q7Eyw9ZK31LMx/ZN1Nay55f3ime06BjkrY+PxNPDcpzvnAOjtMU4oALyGAKXBnAFNB2f23z+T8Ugp3Z8lor41KP9Ivs0+EN65C5WtdjjqJFU9psaiwz5KI4Wnqnj7Jk20cC0uTwJPnFitPHz9c8eTR5jf0DHP9s0zYuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzGeEFfQOnetCmyCnvqaNBRYpOX7Vsfarqwyw/m2Ono=;
 b=QP7IAM2OJJ9wpmSk2g5XnvhSkHBzigUlXJI5cCrHkxZxewsaKSMLKiW2cD+JETjfX09b2FqyxSmFDti7OpFN5eLtLA96pBv4BlH1t+D0Js5pTAI0XL3kMP9Z1ViXvtNlhoaqIf1C+G0SkHPaDzkQBFS6sy3UVX0Q9OkP9qG1cMuqEuhZUl9uZDjBxMV+jwJnB1o29Xqzt7UkhNE0zLTOp7Z00oS/nfs7lnw+UrpfPxks41opCSCF/OPAU3Qz7wVtjxtxoBZRlvNBLvJxaCfCyqR9xKZeODzTGSL2PCyorzrvY81JLQBLFNBkmyzGSftAWPCXiEpMVyochCsXVFNdug==
Received: from PR3P189CA0029.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:52::34)
 by MRZP264MB3193.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 08:37:23 +0000
Received: from PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:52:cafe::34) by PR3P189CA0029.outlook.office365.com
 (2603:10a6:102:52::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 08:37:23 +0000
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
 via Frontend Transport; Fri, 4 Sep 2026 08:37:23 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 2EE2A202C1;
 Fri,  4 Sep 2026 10:37:23 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v10 15/15] test: py: vboot: add test for global signature with
 ecdsa
Date: Fri,  4 Sep 2026 10:37:19 +0200
Message-ID: <20260904083719.53132-16-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904083719.53132-1-philippe.reynes@softathome.com>
References: <20260904083719.53132-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019231:EE_|MRZP264MB3193:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a6f1dfee-3ad6-489e-db63-08df0a5fbde0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: x3eUBfDcxC6M7JdGBDnxghF9hPcYtxxgue9pgF6+jmL8kmLCzxMgJx4591PrtPMAdlNm35FPmhHVpjbizn7P/aJl7vgZFZjkHfq7U3s6+f7UNBbHOFVaTxguuttrkJUCnJB13fsZsgBJVZqagXcF6WIcUhc9H9iwVKLHkKB8yvldbfmo6SbxXCZVnCrLhOJpAs4/xvHYer0R5MIIZEjFgJAQV7GIXg1T1NEciv9OFgQDTg1k3A1e494+9d/kafYC0MomBp7qfytufUsSSVc40K55w9k47+Tz2ZQt0uUMIJI9MNbkj4LsARW9UTOuNiyNO+WSjn06uy1Po1xw7RJyAOIV5Nu2DWSbDU+uhH/BsiQQFll5fhsTkQ06hIyrDPbInmIoB/O7SDAZ0X5A0ek3JRaELoD3u654kg3FgLvMUIWTD/KCwBgUKqS0oXGbuWzs/rabHf5i5CLhfi6q4eRYssbJmR9uAe8WvLr2qTnyKu/sLen1GL/uGNEG4Kh5ihvMFw+OcHU+4TNmsa4g0Ef0JuwUADO/iJFR8x3mHUbuSlNsH4MMVf3/bUcVczY+Pb3oe7b/fB5bknMfAA1UYb3UR/VuTsza/psWqF5Uft4mnllKkGnHbH+t1+B4hNeIaveQRYoOBEKqhXYBvhmz2Y+c7CfR4iC3Qx2iP0aFWQUoqqpuAQYOp/ny5/8FMPH9V9MLGMo/x9bKq/JQ03hv5ti4cQ==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8cw7CZz+NgzgV40c81p2+KKhUIDTOTecazC9avKpfMMMao/vJNVfIxfzQpAiPFsg7D8w5VSqAswXQTUbl4K1/YsK40JRIo8YejiDVb53cGqTgNdJxCBIh8MpyYihsQDGtGANyHQ0yHwm/P5M6lpkatTt5YTB05AJSP/0oHCaLpx/w8ReH2rgRarE5L1Xal27Qy6XzNkIOKNOvEdfdGAeNGFSU+ifCnqS3rVYhPFK4B2CSh9ba9NmxyrSCzvISa0gvyu8WdDxJ9iGAR4tmnn4Ml3QxipLt9WbYiczc6UVzgYcWggfcFKd0ZUk1EWvRP/XvDilBT87wOWkxTYfWwF/C7hFNGTrBDVZSND5lzeUnYW+gcT62Cc1tmQXIjyEA3r4FApzQfmPJZ3pHfy4N4JHc5JNpc8pnYmYx5Uva4nH1bgEAXeN5YtZVZZpWQaQva/c
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 08:37:23.3148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f1dfee-3ad6-489e-db63-08df0a5fbde0
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3193
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
v10:
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

