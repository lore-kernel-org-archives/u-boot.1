Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55B3C624A4
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 08:17:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03533810B4;
	Thu,  3 Sep 2026 08:17:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F6rOBVIcQNKG; Thu,  3 Sep 2026 08:17:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 270EC80F1D
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788423450;
	b=Rsf5zMHV1QpfPbaizM36bnJH+0F0WDUPmJ2wWF2VgMvcPNA+OBV1hztUAS3/fUFJpQvG
	 KniL24sc9fOFW5sCBc3NyMwIkZgOgMNH78lUi88kPvTdwrLzVxQmLn4EfySjyexzr+R7Y
	 pdtmEan7Od9xnHRiPyswiFomNUzGFkdbF89HzVSoZzWZoAKI6rGqysO1qURq1BJ/r08Ee
	 SA/eqU4+2mc3nd9vZV66zBnZJm5gEFcXfCrvPIAqVnxY9HRQuOH+LDX3GpPoEJWPLK7xG
	 qUxn0YoTexRBVTHd5LCWdxSuPulyO9UAfR1+DVipkUf4AGBp9axVTQADetBb4gzCfWw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788423450;
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
	bh=98SRe5EqxymaPmN8RcW4WzdFX2SG7NpjNwnIWVLcHYE=;
	b=pUWfj/yna6MDq5Q/YhvxNLWbm5L7xtA7xwwfyC+2Zo5juWWx1BS/zqO2j7LgiiGk8g/p
	 KcRnqubO1xXjEYFYiJVkFYOyAEqtMRDGdXi+VFag7X5bhfyRyXPWUT7M8ms3qLEhtE9Km
	 Eb64UK3km/5zMoY0TrH5Le7k/UKyHKA8RBn+kg4uXKdjy4TuZRRAGBvVafChIovl6UCbu
	 ByU7E8j2rB/J2N8KJku4/zGbbNich7rkdSk9hXpp4epWMDA98bKlsRayOI92GUQiTkuv1
	 OMUgr1bbNVd59eWKOeZrhIyVZgo18ROhucQHeigceuS8NP02vC2du1WAx4jhKySODSg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788423450;
	bh=98SRe5EqxymaPmN8RcW4WzdFX2SG7NpjNwnIWVLcHYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=omo9jVZdPTi0TFHK97Kc7J0x2fi1OyHqkxZMLdUhxnDcJ/Xd4035rjQ/OSTKIrFoW
	 18WVMRKEaTNEbBAUIpoGiwgojnOrcpDhkHQzwxUT6aNn/9o5yMRaJ3jKszKiR6pfHQ
	 dzkNylHm1WRyGUZNDMvZikCgapRS0XUsoCTLB4KAEpKEF3/zjn+tYGgqNeAx0zpvD8
	 wmX78FJP5C8pfd359nytJTQnzwRXyNoNdb2nnHyAPbnKRjwNLGGDLKnYibMa8tQBEV
	 FztXuWQ5UGXYfrgD2RFZC082Fj1+LE7zNXoChxOP2meg3zMHfwoS4/eYBse75uhGic
	 Vds/+SZXuu62A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 270EC80F1D;
	Thu,  3 Sep 2026 08:17:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DE3EB2FD
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D46844002B
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 58IQF3wB1M_3 for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 08:17:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E71B3403B7
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788423442;
 b=Hn2soFmvuxr6r6Er6r7E/t4yc5/vudqWhEhlaEUe+747gZX3ku9KSOcfbULEvVe5Qs0x
 YUMAUSgOhSSHPWMXHVpN4smshYKD7kmXnocHKT41vlMkyHVF+LVlZjPGEX1bv+j3BMc75
 9YxfzO4xbrH7rxaXu173WXByPEmm3cXfX2b69j+355PZxrgpDCJlfmXR+welH1GGeA5+b
 i3oFHbwNZEokH8zo0N+RMf9P75IKHPpOBXrljDoQVyBmZ++AZm+Xo5eMhk187iIHEyW8R
 KruWZBnfmXX2VWNJO5WwCXAwgxFKMaM/+Hd8WfguHcVW/UZL8cQQTthkmxMTUhKszBw==
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
 bh=98SRe5EqxymaPmN8RcW4WzdFX2SG7NpjNwnIWVLcHYE=;
 b=hL/26IFU1sypSqb6oAiKl1l0Eie9o1OtacqeeNF7MkbJHVb3+fi9Vwd8FIyMxFKxPBUo
 Q6mW20ToF87XQXXh0/HXYwLl23Sw+x/EDcx+1OSsAwNY2cl98sifDEeOFDUILF/mizd5v
 zkdx2zn77zR9c/WaAreuUzlfOc58M+hGFtjUABZDhETSNu+dC+rth1sK9VeSoba8xX1Kk
 X1TFh3cGAFhjPTg6feZWzC7PiBlRhqP+VLW0ZRhOce8z68ZQQT7dnWJnda6+LvPkvyxgG
 um+E0jK+ZwX0RJsPuyQNyLEWG0oLC3Uz9mxqMLnRaX2GQaYU43uqUdFFIGEPuUOGGaw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=ZacRQx29; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::2;
 helo=paup264cu001.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=ZacRQx29
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E71B3403B7
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhF4NbRmk0tg4Ox3hha34n2PBPqFWfOH06PuguVaUk8kJlsHMnzSwruZ30neWXEUvLj8nTq3I8i7LMMOoZZfs5m6dcj/TdDsuwh5DvRYdfkQy1ZesE6frpgQgotc3TmaNvgbp5AVQ/gTr2nCA2Y73ibGou4hg0Zd3DHhFn3j9jcWd2nG6wk9rEyU27kWoGqFdqcQc/4t2X7DYMCmiNoiLyQ/8J/jUODGRLO0bzZ9CEBvCjPpzyxIYXwrYsJqW1h9Cd4LNQ5hJ/RDkTDf2prdNe8i6FM1GxOuwDKIp2gIGWkF6PMGR3lKG8GQeRsK5oqxykq63j10kmMzJvuwHjbOhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98SRe5EqxymaPmN8RcW4WzdFX2SG7NpjNwnIWVLcHYE=;
 b=SLbSf95/fxyiP/nSlyokVmAqJahldrzzus0oArTLve0Bgrp+7S5Kmr5Ht7GH13bb1GMuPxx+uhB8uoCXogf/wtUQfW2l9lEau7d3jawtjaIZmD6w9vYTPkmNBiX/5jeHuQzZrPXRcD5oYZCjm9ds8jHxcgW+dfhDOAjGGsY1z7Y5vOheEPSWk8VMzbxddIExf6Zh2W+JFPV7Ua8Bbn9x2gpX4rbVHh7JLzwf6Gy34U2H4w53torj3J5+Pb5c8SIUa44P+ThDC/SkOnucNy2OfA89VS5coJSG4gRUumECuchGbFnNGvMCdmJcoOUopfSBa5nlb7M9lIyrfk/OglidHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98SRe5EqxymaPmN8RcW4WzdFX2SG7NpjNwnIWVLcHYE=;
 b=ZacRQx299N06D+tQApFV5Ko1k7uBTYZ82QFEK4Q2SWsc6Vk2VoDyXi5hMqtQ2Jcg2ODwhm5GoWuchz7S7zLKiRJjPwF+qeLWnitSOyUlJbZvAh55dQG0G0VAbPZ7qfkJhtz7wDIp5hHtg6PnULLfMxh+AhqX2gslhrlMMpqZ8K8u3Vxi3ehBYix5IT8DptgP+0cZqqEb+PXvT9GBcUxkASOoFE+zh3I9ABITRKUiVtjJY5/w5VkyIWa05g5tJGtdawe44GECpOgxZS3e0iBPbPgNSxbAKkIK9F5VgPtzpSfxgS9MaqUEz6Bn4Q+4JLkxap2NT7TKL4axtkKNSbXC4Q==
Received: from PR3P191CA0032.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::7) by
 MR1P264MB3058.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3b::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Thu, 3 Sep 2026 08:17:17 +0000
Received: from PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:55:cafe::6a) by PR3P191CA0032.outlook.office365.com
 (2603:10a6:102:55::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 08:17:16 +0000
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
 via Frontend Transport; Thu, 3 Sep 2026 08:17:16 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id A51B8202FE;
 Thu,  3 Sep 2026 10:17:16 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v9 06/15] test: dm: ecdsa.c: clean this test as software ecdsa
 is now implemented
Date: Thu,  3 Sep 2026 10:16:56 +0200
Message-ID: <20260903081705.12894-7-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903081705.12894-1-philippe.reynes@softathome.com>
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019230:EE_|MR1P264MB3058:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4e30f42d-120c-4ec6-fec2-08df0993c458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bSN0j6K5wcfLV0klpV+JBpUDeKznQYQnS2gKOm6zkF44mdTGFCJ1n7CNXNZSIc2Oeco3xrrxxTAvJ87j6YZvmuw0WAN6tF5HjVzJy0uhP5SStaqaBaUEKj2Zf/68S08Z4XcbMC7Hyo+tupf2aPtAt37LN54f26xFmYHlXnNZfHLGKJUsl/CIz6CqmtBDcHdVs07d0Im/Y4Cndky6JTdl1kZXJtzCE/p1+twycm6FPU/rqqcfO7GAKSm9MX0DVGAXxNZHhvc08w1x78E6IiVWnsGjci3h6b7FEGnyFe9+H0kphWQxRQpKnnO/CMgpewXYrEVIgbO2hfFt+gDlfKEITNX7/n/v89VzWmk/2ZgRnftHBABoRot3PAoHE3X0hdrUUTjbZNgWnsrmL7lgYaaZRtkLXOE9Uss83+aLvA7xv2F8/3/w4N3mRz2pLoriSrxa33fXKMCCAbOrDVowwiK+R4XpRFOYEOU7voTmk7S+wMKzdy6rmWNKakSdasQmNLkUV3WEsriaB3SWD3her3rWrJClxrwOgMu764IUoV+09FKvCP37weUjo5A+aioBz328aUe9TbB39dLpC6CSX3AlKXFtG0Eh4JKKK22U9UF6uQHVJLcTKe2lyXzI91XmermvlUr/gK2kvtwn4Ku+biTmsah8QnlGaJkLWE0xEWbyGoSj2ZR0/J7n64DBEBuc3rLSB7QpHtyIG5/cZjlul41uKw==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c7lZTCT2p7O3vVOZ9+lLV45MT1st3SLi1Aw9O6/aTwHWDWCIljMlYAz2IkhjPeuuQHsQhRiDIsBohMv9w5ksGy/fbxa92a4tDnd2Y3g7VZt8FoLvSu6YWuVGjxkfJHsnOW2ls6QBXU3yRmAecEhM5BAbL89RvC4Ux/9nZ5s98TUBhvfAdwrzK8Z+Hk6bPIHB3WlOoWT3uWn0QJSLGt1xzrBKlXutyikFbdyH2RdaHcwo0ksd5/MOMgaUwNex4bCt7rULq9iBEusa44qwh293t3jaFJQEfg1nHpkehkg8YxGS10lnMqyS39mGFMO5+r7gLnupxbIcxQB5ER2rBQ0Cl+Hd2te20V4ESwMQ4H2rFnW19ZpC9t68mjxpsTfA5408RrZYvNRhoG2wnj6U85fp4/YTRrfP9nuJBSPPtawnCs+eSepUlV3+Pngo7KxbJh1r
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:17:16.8443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e30f42d-120c-4ec6-fec2-08df0993c458
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3058
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

The test ecdsa was done when ecdsa was only supported by hardware.
So it wasn't possible to test ecdsa on sandbox, and there is a test
to check that ecdsa is not supported on sandbox.
Now, there is a software implementation of ecdsa. So we add a test
to verify that ecdsa_verify may be used on sandbox.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- initial version
v3:
- no change
v4:
- add a test that use ecdsa_verify
v5:
- change secp256r1 to ecdsa256
- check that checksum and crypto are not null
v6:
- update commit message
- remove fdt_strerror in macro CHECK
- return ENOMEM when malloc fails
- add a define FDT_MAX_SIZE to avoid hardcoded value
v7:
- change uint8_t to u8
- set required_keynode to -1
v8:
- remove macro CHECK with a goto inside
- use lowercase for hex data
- code cleanup
v9:
- no change

 test/dm/ecdsa.c | 107 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 97 insertions(+), 10 deletions(-)

diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
index d7eac7115f7..261ca3f9f73 100644
--- a/test/dm/ecdsa.c
+++ b/test/dm/ecdsa.c
@@ -3,36 +3,123 @@
 #include <crypto/ecdsa-uclass.h>
 #include <dm.h>
 #include <dm/test.h>
+#include <malloc.h>
 #include <test/ut.h>
 #include <u-boot/ecdsa.h>
 
+#define FDT_MAX_SIZE		512
+
+static int set_fdt_ecdsa_point(char *fdt, const char *name, const char *data)
+{
+	char *value = NULL;
+	size_t len;
+	int ret = 0;
+
+	if (!fdt || !name || !data) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	len = strlen(data) / 2;
+	if (!len) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	value = malloc(len);
+	if (!value) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = hex2bin(value, data, len);
+	if (ret)
+		goto out;
+
+	ret = fdt_property(fdt, name, value, len);
+	if (ret)
+		goto out;
+
+out:
+	free(value);
+	return ret;
+}
+
+static int create_fdt_with_ecdsa_key(struct unit_test_state *uts,
+				     char *fdt, size_t size,
+				     const char *name, const char *curve,
+				     const char *x, const char *y)
+{
+	ut_assertok(fdt_create(fdt, size));
+	ut_assertok(fdt_finish_reservemap(fdt));
+	ut_assertok(fdt_begin_node(fdt, ""));
+	ut_assertok(fdt_begin_node(fdt, "signature"));
+	ut_assertok(fdt_begin_node(fdt, name));
+	ut_assertok(fdt_property_string(fdt, "algo", "sha256,ecdsa256"));
+	ut_assertok(set_fdt_ecdsa_point(fdt, "ecdsa,y-point", y));
+	ut_assertok(set_fdt_ecdsa_point(fdt, "ecdsa,x-point", x));
+	ut_assertok(fdt_property_string(fdt, "ecdsa,curve", curve));
+	ut_assertok(fdt_property_string(fdt, "key-name-hint", name));
+	ut_assertok(fdt_end_node(fdt)); /* name */
+	ut_assertok(fdt_end_node(fdt)); /* "signature" */
+	ut_assertok(fdt_end_node(fdt)); /* "" */
+	ut_assertok(fdt_finish(fdt));
+	ut_assertok(fdt_pack(fdt));
+
+	return 0;
+}
+
 /*
  * Basic test of the ECDSA uclass and ecdsa_verify()
  *
- * ECDSA implementations in u-boot are hardware-dependent. Until we have a
- * software implementation that can be compiled into the sandbox, all we can
- * test is the uclass support.
+ * ECDSA software implementation is tested in another test,
+ * so we only check that the UCLASS_ECDSA uclass may be used.
  *
- * The uclass_get() test is redundant since ecdsa_verify() would also fail. We
- * run both functions in order to isolate the cause more clearly. i.e. is
- * ecdsa_verify() failing because the UCLASS is absent/broken?
+ * The data used in this test come from RFC6979 and use the
+ * sample with curve NIST P-256, hash sha256 and text "sample".
  */
 static int dm_test_ecdsa_verify(struct unit_test_state *uts)
 {
 	struct uclass *ucp;
+	const char *full_name = "sha256,ecdsa256";
+	const char *name = "key-ecdsa-256";
+	const char *curve = "prime256v1";
+	const char *x = "60fed4ba255a9d31c961eb74c6356d68c049b8923b61fa6ce669622e60f29fb6";
+	const char *y = "7903fe1008b8bc99a41ae9e95628bc64f2f1b20c2d7e9f5177a3c294d4462299";
+	const char *r = "efd48b2aacb6a8fd1140dd9cd45e81d69d2c877b56aaf991c34d0ea84eaf3716";
+	const char *s = "f7cb1c942d657c41d436c7a1b6e29f65f3e900dbb9aff4064dc4ab2f843acda8";
+	u8 sig[64];
+	char fdt[FDT_MAX_SIZE];
 
-	struct checksum_algo algo = {
-		.checksum_len = 256,
+	struct image_region region[] = {
+		{
+			.data = "sample",
+			.size = strlen("sample"),
+		},
 	};
 
 	struct image_sign_info info = {
-		.checksum = &algo,
+		.checksum = image_get_checksum_algo(full_name),
+		.crypto = image_get_crypto_algo(full_name),
+		.required_keynode = -1,
+		.fdt_blob = fdt,
 	};
 
+	ut_assertnonnull(info.checksum);
+	ut_assertnonnull(info.crypto);
+
+	/* create a fdt with the public key */
+	ut_assertok(create_fdt_with_ecdsa_key(uts, fdt, sizeof(fdt), name, curve, x, y));
+
+	/* prepare the signature */
+	ut_assertok(hex2bin(sig + 0, r, strlen(r) / 2));
+	ut_assertok(hex2bin(sig + 32, s, strlen(s) / 2));
+
 	ut_assertok(uclass_get(UCLASS_ECDSA, &ucp));
 	ut_assertnonnull(ucp);
-	ut_asserteq(-ENODEV, ecdsa_verify(&info, NULL, 0, NULL, 0));
+	ut_assertok(ecdsa_verify(&info, region, 1, sig, sizeof(sig)));
 
 	return 0;
 }
+
 DM_TEST(dm_test_ecdsa_verify, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.43.0

