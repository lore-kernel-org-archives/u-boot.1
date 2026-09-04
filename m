Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83EDC624DE
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 08:37:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70E7060BFF;
	Fri,  4 Sep 2026 08:37:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aW9FywoVq8N7; Fri,  4 Sep 2026 08:37:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 473AC60BFD
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788511062;
	b=pC37qRRnoVLBcNRFOd2xkXt8/amM2j46oRJdmvNgNMA22RU+hN8nlvI+XkIiBFloG20w
	 2AHBwlVKRQoeUA/9WFiZ9ZbesMxQmkrl1GnNI1QWANz/FUiO6+wxzmYI8tsCmxumLQp9U
	 7k+HY8MHhmWew13gGHol8Bc1ellXB1VQdgEa7C16tkWcjZzDZVm/fHwGQ+fg5fTz+EiEf
	 gRWcwql2eVuPhtccXKNT06z61gNqf/UTR7xh1859d4FMqHPuig5vBYFAUyKb5s/lBpftY
	 G3TwHBuK+6uBhNmDGzkSoEyCgGsRMog59yzUdnst5g4hdk9PO1RNZq1FLI5c+MjuLmA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788511062;
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
	bh=/IWh/HLBU3238kTnTgicc5tuKXHK+Axr6+V0qHma7f4=;
	b=kKxGhJlNMtb/nbc8fiJhoEG6J/GbMARMeOxfaqHj6QWBxdLF0qqccC9iyeiBVA77A3b7
	 ZJFaYSe1Y2c5YJjKCAzC+EO4git5UVkvqaQg2RkoVbwX/Rw8BUgHEfeD67aQ3D8P3Gxh1
	 F+XXTnn1KS0/rlVWHsWiD3GIzbvsJCR+DKllcpA+QcjYnGz7KdaxZhUrqokTvQMl8wH7B
	 jmGuSsL3H07vp/vhWAvoGSMABrmprarzAsG6gvJRVUR3ThlXpJDzGyd3ZTaaHlQfaNCEd
	 sFyg4bh8pVfDP33hzIxVvoerIWwdHsj1rPHtyoFFjXFn54rlx2hNbhaaGGhE0P94LLg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788511062;
	bh=/IWh/HLBU3238kTnTgicc5tuKXHK+Axr6+V0qHma7f4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=grKZnGCrFlaCuFaJsjW4QqzjtDeQk9dvZUh0pvWdqgo1sVI2Tnslxf+PhscB2Mf/Q
	 FqL+rri5rhh2FbRi68a9EADNm6qI6/weANHJurDQelxcjpQhM9B9aghmCxM207V0iy
	 ykUoE9KCe5R9r4rSnc0cWh1hpcmMRFTfAfw7QeBBCNooBwnTiqKapzh809v9FHW9e0
	 W46ess+4iM35YtM8YpyEikWSRR+GGJtnLL5r+PZrqg0DP3uQMyQkCTmslH04F6oLZr
	 tBV6kr9pejV+F4MGyrcD6DbXqePLitdkevvko12QMaOmgtaPjS3pu6OQntUiUz8nHE
	 aFolQQptgI5yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 473AC60BFD;
	Fri,  4 Sep 2026 08:37:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D1F773DA
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CF8468113A
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c3XmEy0ecS9S for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B102A8113B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788511049;
 b=S/VIHtlhc0aHwbQ2As24NWn01C+2KO302tXW4zdeWYxPCtdtIRfMF3+3HlMfhvoYzVDI
 vosxWt7R95Zz/1X8uekeKq84biUpAEitj5XYRQIf0kBIpPgzAkPqV81CU5HABWt6y0XUH
 okrkB11aZMiYvovDxUQ5iP+i7A9L7LmGB2GXuz28x2GW7/rYyA3KZnn4DNsqB0nA9M810
 4+gTs8OxVR6nhHMChPg4jkobnxc50HeiPewL8Cq8GVVftuMT7lQZ8PPSpfSG4FDj6b8Gs
 048lHDDrKI3V5YqjCGf3rieb1VeUThlD32Fz1/iWe1bt8FX30CtwbD12gmtbfe+DnQQ==
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
 bh=/IWh/HLBU3238kTnTgicc5tuKXHK+Axr6+V0qHma7f4=;
 b=WJBWZiR23/oXK7zTPMmKjhup9RcnoIHugS8HDcTTZWR7SmRe3W9uHHFSM9aXfa8vVUtZ
 BYuohHoZ06OqaGLoG9+EabakM45++hvgYwfm3iKfG+lHavGAXR281TjglQ8IokMcWzpKn
 trB9kr6ZS/Ny3gQ66yFJqziNluKSWnR/7F2bH5wsbAKLVBvJi9KUd2TO2ISdqQLy+Kfej
 1syRyMWwh4RMaKPAiVZFlrr92bgscK52/dKyQlVrczFIJYpLLGXo6DRXFSO/1d3nYIva4
 cHadEnsaQTNKlnY0FTs7eKmojBtVr6XeobaEeLm2P01T/AX1hXweCzwkMhDQoN/6UHQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=jvZ+2Ln1; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::2;
 helo=paup264cu001.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=jvZ+2Ln1
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B102A8113B
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+gf4h2AZlnww1EzMq05YXK18txGmtYudnOsL5WFF3pOPGIbAcDTqjZsAgHq8Qxg33n72BmnU6QNRwotnQmeftdJjAM9JgFtUFAoD7EfISneLWkP7ZbatqmMKgr437Qjbe3QUW5Ct3zNg6+MpVaAFET2t8FkzRXei/WUfYTSfJMrVWgJFGFSAzoCYGQxr4axpp1iXWeHGTujQN7mZ9pU79Z7qFQfNCGi0s/gyndf+0A7lxthZ1H9xREm0lDNkKKiHjxcKdSYlDaTdiIfvWwyOFV7iGbsMGAiLz/vHLjdoQUrmvyl1vy/b+A5UCpKhDtDwXDit46k2b83H4y1Mzgzaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IWh/HLBU3238kTnTgicc5tuKXHK+Axr6+V0qHma7f4=;
 b=Z8ihBntY6byKZaw/WP5FiQAF5vNJlLaNjeeFxgJ0nzmb6d6SN86/swoBm44daPaPIVxDJy9NhVGdxTd8HHst81VxBVyzl0sG21YwzHDtgbpy2i6P9Neo4EBcgTzzdTVZKQDo53VbSLzYCq2/v3JsssetisWfHjLkAW4F8tuVfjv8Rn5bSTRGbONLVsu5vqNk1muX4P+1fs47kTFGGiTBqS7BpGq5sxrNczShszvwdA4Y2UWnn9zkz9/kps8kWiFsyJo9wFTGUsVP58hCic7SBo+UJmvxHZc9aePbXwvQGdd4Zfs72gyE/rzME5OSZLl0AiMz4pJyI85RoyI5bvXcRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IWh/HLBU3238kTnTgicc5tuKXHK+Axr6+V0qHma7f4=;
 b=jvZ+2Ln19/DLQRkOT/tiPYOEDD8zN6NIfIbKA3LMeqN0lOJ7Jy/lpGvGmKTuJbQz7kkarxQbj4IIB/2Ul20h2hAT5C0R/I/dS77Q29sE2jhvzTqX6+F6PLVosCvJr06KMPr6DHlWipAM6gFouallzuN9jy2zoLDkiWrMnzVtfFjjVDAruFB+0JKz78x404uJ7+kEEiKksM2guTfSgngjy0ebBqecrimo1UudCxGigrgf+7mgdr/JwpzYUXJhBKIPa25P/pkL72C3us+ObrhWyDTFRTyWcE0EytFSJ/bJUQuJIUehb2FLvR7D6+Y18A8i4lMkoXgpOZoZSKwK+4XKDQ==
Received: from PAZP264CA0181.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:236::35)
 by MRZP264MB3162.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 08:37:22 +0000
Received: from PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:236:cafe::7a) by PAZP264CA0181.outlook.office365.com
 (2603:10a6:102:236::35) with Microsoft SMTP Server (version=TLS1_3,
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
 PA1PEPF000CC3F9.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 4 Sep 2026 08:37:22 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 4C785203AA;
 Fri,  4 Sep 2026 10:37:22 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v10 06/15] test: dm: ecdsa.c: clean this test as software
 ecdsa is now implemented
Date: Fri,  4 Sep 2026 10:37:10 +0200
Message-ID: <20260904083719.53132-7-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904083719.53132-1-philippe.reynes@softathome.com>
References: <20260904083719.53132-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3F9:EE_|MRZP264MB3162:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: abae6588-254c-4213-5ad9-08df0a5fbd5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|10067099003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: lFBA8Q7lAoZ1MTXCAB7MutwVC9O9wr0h46rtuC/FKDS4yI9IGoRVXV/+0Fh2op048W+ENFXUgg5AbbN8HnAnLR0oFGKHv/Xic5S0vqubpMvLmLkdnhePl7hk2NWjBV4lbAV78VnG18ncWr3KUIGNx5oZWOIiIX2u3AJqquplPsLCOwbDWwM8BOsxGna2larYPhcoGfC6Afk2zr4be3Iyj3B52gMSojk0HAlUAF+i7MbFIB1tEqYpZYbYuQ00cQsSwzODOkftGLM3G4DIZaWCdJNuVNf6nGsdj/I9Vw/mHQw0f5fEENusK2EeMpK7VcoVN23Xy9MBJVOby/BzO9TZx8xujRxd7OoyTyrtZAxROTtZ9+h1fN0TxciE28rQ2uTIwASSc19b+fR8nJt4jjrq1IXL4wuL2aHReA0u9+Xhv2ShoUD4sP7AxbXm1tbRgCPmkYGGhRFVE6VXFTuUiP1sHNSsslOVlZ93V+vElR3BxJO4WihfUaSi5gaR6I3KuX4pcqk81YgtCBi4hqnWw7UPsaWDeXCofyZvMJJmDMm8nf1VCLL0jyuLb3LZQfc5rop/jhzzGtWsQ2UErkDdJBJzr4dl6J1kTMZx0alCxAfybFv83iVPVshchwsziyqpCPf0KGJC4PIb1VjIWmJ956K1PCl4mRYPvK4RXfo7kO/KwXT0oglbUBqDi6jU07z0FIWk6MOD+u90l3lX4B3Ew8gAeA==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AdKV5lPt7itwgWz9/YdtQ3mIgAz5XH4C0tSAzQoHoXoyxYoqLKg1HdDBnkPX41bYhjPEcIqmL0zAQpebNMukRf2qrszES9uROV3yTqbSy1xlFyB2Hb+gND7kRoh9uyD9OGIXkLCKq2gC39g1ZSaZ69TkLnjsplhf6+YJd/fQxUPXh85zOdomCQ0IIdwOPm/NB9IwrNi9TZARMljlVsIG7FgM0LYAJNXCPFj8Z/WRiFSDiV3VyV2ot4PAZM2fJoBf+MuVVGIprmA2ZI0OCp+i6dKIpN0zITrV58MBbidKCSo5CVcN/7Klbs1DYLAWlygL1nNsBoKftcB4wdBkyVPKuVlGWVJre0aty1SB9SZVj3rEj/tXnOwNxWhBGqLA77jG2n8OXwfTjkkZ4xsl7TxYZNZzEHKncKBljgAz8BLkSjirO9PyeQxPSfRuf2E20Dgz
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 08:37:22.4413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abae6588-254c-4213-5ad9-08df0a5fbd5a
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3162
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

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
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
v10:
- add tag Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

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

