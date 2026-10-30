Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF23606A31D
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 05:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=p7PNGdqE;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=SfxM+y2B;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=SuOfN18a
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DD2C60AA0;
	Fri, 30 Oct 2026 05:28:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h9rslqngjE11; Fri, 30 Oct 2026 05:28:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 603D860A99
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793338092;
	b=mOQSeNzAxvYlsPJ2OLgfer/cX9n1PVKMGzbV/hznespEdik+r+wc+2VmA9rfAegMTCLa
	 4gazkWohkQ8e95bkIYNlSRC5pIbri+xKIbd0V7angEXWqbg/zjJkK8UFKJNX/YqkfIUiB
	 vt8qi5HJFZrwFxODwHQghKNZrODte6KGcPqkoIbdEsn2ero++pqOK9MRnQ39JIOsr9W6P
	 VHy1Omr2rgvi0WFpykTErh4NxDWdP3UCgqRD393JDxSD77Lb807HzdpIvLEFAlERpt2dU
	 jAnhtYNdrQ+ioNuZxtPtO+m939T1GyaMonQEIraCgzL/k96O8OLtOXbe3pG0mAps4WA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793338092;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Wnp89xePFtsXvCbM7cU6ab8sfUl9xqQ6q+iAQn/JeYY=;
	b=gzlciyU5H1VxWEcgHiKQq44bzWXnTUBqbr1hsP2Zs8E484BpqpQMRKucgakD5W4W3J3G
	 ujlzy3pN7HQZwA834RcgAUy8VkHYiPSS+3QJwEIunyXgb3FGWYt8GnR0eorDvFQsgXzNN
	 ofEJiP8hmG9YYioRjTncwfVs8FkcJb7oauY9BnCAlLuxJvCeAoSaIf13YLZ4Dbx7Cd7uI
	 FGCVSuyjXsNW/KOxIEwQMvi/p09zRaEpZNMWWBP2omH0g0oT/M/B8x3JvEV4XgjEBox8h
	 peC0jR0gd7rXz0x0YQ45dKVNuym/zWSCULsjV1m67fl4wbScgyeg6s9Myo4y7+GKKFw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793338092;
	bh=Wnp89xePFtsXvCbM7cU6ab8sfUl9xqQ6q+iAQn/JeYY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p7PNGdqEuEMoHHL0hv1aDebQ0U4bn4YlciofRP5cabUvjnpF2HJHGFLEeglXukGFh
	 R6TBPVMMM+LDj+pJbVMD+x3SovkLQteaeWAIUFHWtk/WMCbWz9oxueMBnhLHvQsSM0
	 JcEwH7pD/XCFP0+iXAgE2v2EFYYyd6t+/kgKp5tOE3M+9S5B+dm2AjXZl6aWuelKSh
	 WtB5GcvLQDkGZoreobXfJ9PjO2VpLS/NlF75iXO6kzOgeYKqJ+L8y40wTn2entt4Ue
	 Bmc0N/5mmUdOJy9OVgeq8Aj9RGRtJBuiAMxO3diTx0f2A8W9VDfiCZjLIgvKX2CxFX
	 Tw3tsWmpY5tBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 603D860A99;
	Fri, 30 Oct 2026 05:28:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D6BC51DE
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:28:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BC1F8810C3
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:28:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ffc9C3OagEqz for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 05:28:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6256E81090
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793338090;
 b=qRtOKONgOgDafyxQj89UM5USW9KKCt60/WjfSuLb7cMZuDtTLCLcLLPagGyxuJfxL4cD
 EZiS4OT4L9aOqpoaJF8/aRlAk0lPVB3gg9AOGASrH47g+OGTzFKscU+uI9XMtcbN2hoN2
 k+WTR69Mn0To0sMI96uADJ0t8pScOxipNirKoYM0/3UadGUXwYfzzOPlsEi+upoTJeS1h
 +Jms5XrqR4qT1jQCbeqct6NbihiTNJGPSdFbWnpryx5sMFj/+EIIHRd6sefliVAnxyaVJ
 yzs1z1aKQm8Fje41f5SEiBvudjbqzbNqAsAxTPC325CT2QHskXCXdcTER1Q55eFbtVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793338090;
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
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Wnp89xePFtsXvCbM7cU6ab8sfUl9xqQ6q+iAQn/JeYY=;
 b=GkrdiFKSciKBipjm9IViBnW3SqMz8OH6Z8Ye6nb6wq3DicY3G7aj970S8ixPEx/4N1fP
 mnYNisscMrykWfo3RJWPPS6hxTyjSXHq9rlv2Ty4/SgtizE8duBcJLmRj9ZlL6jWf5vws
 7+G41peQD986tuP4aFizZsEAuTji0PiWlxs29rc99T5jl8IBx11Cpqv8Qen8xKWugopDi
 T2a6FgnT4b5wdQcTATKk1QNQpEgnSmCVyHSwFVIHUiJuPlrkJ3LuL58GlGbUo6QtGfFl5
 Uu/wv68MXDX3EH9dkrjwUajSjkOK5FXkiqEi7MNQzEcx09Y+BeEsqmlFd0JfpxnCATQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=SfxM+y2B; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=SuOfN18a; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=b-padhi@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=SfxM+y2B; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=SuOfN18a
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6256E81090
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:28:08 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69U5D01v2510909;
 Fri, 30 Oct 2026 00:28:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=Wnp89xePFtsXvCbM7cU6ab8sfUl9xqQ6q+iAQn/Je
 YY=; b=SfxM+y2BhlNn8gZFXpN88aVEh/b0kthPyVFGwgQO1U8ufdgfo+BKiv8Gx
 KWgHnksY2zKNyooqcfZVXVN5WiWBgX9UPns2KNmAUBvBvU2HKjeKd1ItrB6T68K4
 hfpfnITdb0a9oxZc9tzWRrvMCCycMRK/pUSjt22LRO3ViuO2Lpr8vh/7Ma3ccXLQ
 Z8JMfpVPUMfJxg1XnXD3TxqPSvRIBltrLVBUKdwdnjtdET0tPnpUGCN36q6liHdT
 Ji5z6Zh0aC/IxjCE4fqZGE+GV4yL4ednvDuABc0hyEgad6XozOdsuok3PmseSgwH
 NhqY6HjZ+CzIsqw/4x9UmO0nJvsyg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011066.outbound.protection.outlook.com
 [40.93.194.66])
 by m0384305.ppops.net (PPS) with ESMTPS id 4hme5n22rh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2026 00:28:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CutZtCYgY0dpPNdt2r6Hw8ZIHwG/UF7O5T5kXT1nGq71E5+RiaSmlf2GBPuoheywNhJwHG6imZYsIZwBdc0RKvsTXQur1WvJAwQ2r3nQnFR01I59MDUMVR5GMnyF+gmKCjrd0E0rDgG0eTd5vraR9MCYhnF34gJoLTsU9ckmlMFChFydmzSggHjK/YRmrbR7I03CZngtBiij/L8xdKYWoB3rXejL2eUcvuOAKmK1BkSmEUKRR7vB/1iX4CR8/zAtYJcK/15ECMnrVF4xK+XFTFFRotlY1h0OdrTNXUJWo/Uhdb9a1gBuZa4c3Vd7erZHfl3An2sdnCGlZWw/8B3oWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wnp89xePFtsXvCbM7cU6ab8sfUl9xqQ6q+iAQn/JeYY=;
 b=HfTA05wGPrPCFu+Keb4AMl3XAAuzmIRwykUSPawCK/0pbJ+eJqOcqbKcvlRNnIYVYjoYyMxGY75GNc46q4KWYLdzhJcmzWUYD1+6jgljgyMPBI9uQBWGpGcjDalp8e+HWfszpCv3YEOgQ4W1dRphqhh2AGIAV101bN2VH3MomSI+9OueFuhkDQhlENgs1XbwEez+U/zkJoTLtpW+Yrq7s1ekk7jtLbgg2kb/9a5V9MK6PFJjDru9w9AeiEwGBmwsvabZSNkdKcevGs/Xz8sL0VlDS3U7mTjKiSp5Ta2NkhLXtZ8uwS1DENu5TFMGouHJ2LVNLt7cwh8I9nDeY26UnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wnp89xePFtsXvCbM7cU6ab8sfUl9xqQ6q+iAQn/JeYY=;
 b=SuOfN18aZnC1wJ4JRGNiCq+wtlCjL5n0ajAcY7tQso3pENjvDIXXTD3f8E7XOaW+4xJOD7wT1CZ+YStTlfuEtFwn+sR5JErkJThc6X1AZKlnTUV1w/LXHLMm3mwT8blOXcuZKo5Y99smoPAsB3TNm5bFWP8xRvpa9hRMPb3LzjI=
Received: from CH0PR03CA0429.namprd03.prod.outlook.com (2603:10b6:610:10e::13)
 by PH0PR10MB4583.namprd10.prod.outlook.com (2603:10b6:510:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 05:27:59 +0000
Received: from BN7PEPF000000AB.namprd05.prod.outlook.com
 (2603:10b6:610:10e:cafe::8d) by CH0PR03CA0429.outlook.office365.com
 (2603:10b6:610:10e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 05:27:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN7PEPF000000AB.mail.protection.outlook.com (10.167.245.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 05:27:57 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 30 Oct
 2026 00:27:49 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 30 Oct
 2026 00:27:49 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 30 Oct 2026 00:27:49 -0500
Received: from [10.24.50.162] (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69U5RlSI155116;
 Fri, 30 Oct 2026 00:27:48 -0500
Message-ID: <b548079b-8de1-4fe2-9e4e-d071b8f30b8a@ti.com>
Date: Fri, 30 Oct 2026 10:57:47 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: omap: Hardcode control_status register for
 OMAP54xx
To: Tom Rini <trini@konsulko.com>, Andrew Davis <afd@ti.com>
CC: <ilias.apalodimas@linaro.org>, <u-kumar1@ti.com>,
 <u-boot@lists.u-boot-project.org>
References: <20261029173914.3771786-1-b-padhi@ti.com>
 <20261029174912.GE3011578@bill-the-cat>
 <9d74a34f-f720-45e8-9b64-76291f3fb842@ti.com>
 <20261029181900.GH3011578@bill-the-cat>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <20261029181900.GH3011578@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000AB:EE_|PH0PR10MB4583:EE_
X-MS-Office365-Filtering-Correlation-Id: d876d519-84c5-40c7-13d4-08df36468ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|18002099003|22082099003|56012099006|4143699003|261028144727099003|261026121527099003|261026140227099003|261022115727099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 0C7NwvDXBZH1Ng9j6M4OKyUjb6xVazkDJ3iv6zAh/hZ5Z6gJFfwOGs4vp9XHskdbvXVxWX/TW35gBVIqbTTTnte1W6c2pUmWi3PJPgDNQ/TfZjah2OH7Bv3abn+WirjluTUxbw9UvPDjbskSc3VieG61zx3/uf+gspQ3Y9vGu1gbYVaF5Qa16drYGMxm/2QZdNJViAyNQhFEyQmsG/cwTohEYSWvlrE00la1T0pZX5Oz1NgAgYf7EZav2Vo6yt7D2fokcvJozR4mGws2t/fqNhWrGasn51pGjXneN9GgON1VHEBLw7oQI38EiUyqr3VUKz+WLIm/MI527/+hxhjTSTUJmnmprFAHz99+9KIC5c0cF3FJ0hB/wcE2KPvstvxdaq4ipggiWY7WTqsvMSPSKu9XsO+yGCpFbNt6vs96dCoS/YPtMkiJgY6Ubxc7Vn86lzp7R++W8i2DIj6YcNNCz7u0YaFnwqVX9YZkZeEN7Fqf6EYRNPW1/q6G8+wMyt0QkEtMCTNsLio/7xu3/s9W4824I1qR+akbfszXUnUmQr6A1RWzx3UJZFeCjnjBlpzc4HEJb8uYWMMyfVj4O0sU9U+pnJm5Q4bPzt8twLmtnbj2saEewegJQQGPjPQlTN2V/hzzig0ToJA2xZFmtXzZ05ORR1zMDnXx1x5KdvzvDgoGtysnle2zVYwI394TV7jdQfN+cyMVIRnmCO9xns+gpg==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003)(261028144727099003)(261026121527099003)(261026140227099003)(261022115727099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 61Z/LtnAmZbD6+ajW5U6KHKUSvQa+JJdcmVSGxISEsDpyVU+Co0xd8K/8xU/RvDc4wMPd6ij0J9jcw2FtNGKpgPxTaWIpV73qUTn6vIf/fDMEJ0hKThbpO0pZorkjznRY6I1mN0+gHgs245GBXocZId+Jz2onrktmVjqSORyWOLZOcYVUqJYn5QuU3RujzKwbh5Nbbo7cpZIR7veBCk8UzKjUQQmoK8AAMWiSmPDQSX2HYlP/7WNjErcHrQ8Ez96Lcpa9oNWnNYCCaq3TkA7xguPPyFmuPGazCwZtEz0natQEJpySMS5TqXkV2mBmoitsbsz7CDrIkbg16n6dbuFEiHWMTWKj1IoIY5PiYdc3krvjhSU83FhpqZqWFAzO72xRsRxgIAaSqmI/dH2xPFoHgHZmmJEQGTAKdIs1Uxgkf2FHfU9iytD9U40EwE0vhEt
X-Exchange-RoutingPolicyChecked: Gi4dpwO3emYo3HH/0gOSN5vEwmcq+KQHMM8Jz1MfMME8JcnXdEekLfBEQ5oYoLmXckS7wlV3Xd1rDD24a86nq5wL7f+CJ6jXA8SaMhg8wS4AStxuL+AlzxdFBFSMLPJfo3t+mT1+GBXjOzRG0NGwxbrDhoLgOM+CxPkMck1lKcBIam0LghgQuaT/vQGH3VG6igVJqjEXXNdF3ExuTCmCV9eqcR2thU25bXwTEJVveaGl01MnFj+nlnujZL3SiyHjDhK/x2d0d6od8658Pq0/+Z8p17mIx5/+CD65VNe/uC0sIFHq/XtVxep9kaf/nYReCH/qZU6OF00nvUtemIFHlg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 05:27:57.9407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d876d519-84c5-40c7-13d4-08df36468ec1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000AB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4583
X-Proofpoint-GUID: A68rNTkMy5kDWDbFTSvwsG1zs4_e1mfm
X-Proofpoint-ORIG-GUID: A68rNTkMy5kDWDbFTSvwsG1zs4_e1mfm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAyMSBTYWx0ZWRfXzMt9whzAqgfO
 z0POeDXgekt5Btg1Tx5UJ18YfojguAmTQ+5o3U2dnHGe0oYV1Z/quUSEVNV+IwLc7nlhJbeFpae
 ZcLW1ObBKIZP5cl/Ws0QM6MQadcJ9e8=
X-Authority-Analysis: v=2.4 cv=B5EsQ+tM c=1 sm=1 tr=0 ts=6ae42ae4 cx=c_pps
 a=1t1hxDBgkqdAqWWjFE2LMw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=IeSh8i0CTX4BRCnsua8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAyMSBTYWx0ZWRfX3xHjjdJF9GSr
 Rxkns73moELvN04QV7BQXMhOOHw22jukxXUf9a0hTh61e4RFyBMmxcuEa6NigElkrwbvEeHto8D
 zEj2PNvib2QjMfgVDYU6c4W+5Ch17bB4uiNG6wQ1x354RwGVKPsAJptuqbv9OjbQuG+heQ60ijp
 gHJfNnSVT1VmHRWweo0O7wQ09Aj7XGYdcL5LJaiT9L/Egx1DMiyUs9tI1wmHB5bWbJIAsxmDM3M
 e11a+tsX3uVuJf/ox9HM2gAsqgRLsXwgbA5oJusdueII92YDLYr8ixgIUbtLPcUoQB4ssWgTpI1
 j7Wnb7X3D3SPkZEAzaMyXUSuCPH+BZhzuTiDdJCA7XGk+KFyKD6MBW3A3ymANqic1i7L6RfVuQR
 HpM5M/MjWSlEa9t8dpzdHBrUpURA+Sinf2prs6ALqkSwpA1Apn9uPu5k3KZRinBJat0oV/vDu5t
 x8lKmlGcY5fxdpjJKeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300021
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 29/10/26 23:49, Tom Rini wrote:
> On Thu, Oct 29, 2026 at 01:07:08PM -0500, Andrew Davis wrote:
>> On 10/29/26 12:49 PM, Tom Rini wrote:
>>> On Thu, Oct 29, 2026 at 11:09:14PM +0530, Beleswar Padhi wrote:
>>>
>>>> Currently, the control status register address is obtained from the
>>>> ctrl global pointer. ctrl points to a fixed SRAM scratch slot
>>>> (OMAP_SRAM_SCRATCH_SYS_CTRL), which holds (*ctrl) pointing to the
>>>> omap5_ctrl/dra7xx_ctrl struct at DDR address 0x8086XXXX in the
>>>> pre-relocation U-Boot image.
>>>>
>>>> Since the SRAM slot is outside the U-Boot image, (*ctrl) is not updated
>>>> during relocation and becomes stale. The kernel section from the
>>>> fitImage is loaded to address 0x80008000. So, a larger kernel image
>>>> (~8.4 MB) overwrites the value at the address (0x8086XXXX) pointed by
>>>> the (*ctrl) pointer. This corrupts the (*ctrl)->control_status value
>>>> and CPU goes into a data abort when it tries to access the data at
>>>> addr=(*ctrl)->control_status
>>>>
>>>> Before relocation:
>>>>    +-------------+     +--------------+     +--------------------+
>>>>    | ctrl        | --> | *ctrl        | --> | **ctrl             |
>>>>    | .data       |     | SRAM scratch |     | .rodata            |
>>>>    | 0x8088XXXX  |     | 0x4037BC20   |     | 0x8086XXXX         |
>>>>    +-------------+     +--------------+     +--------------------+
>>>>
>>>> After relocation:
>>>>    +-------------+     +--------------+     +--------------------+
>>>>    | ctrl        | --> | *ctrl        | --> | **ctrl             |
>>>>    | .data       |     | SRAM scratch |     | old .rodata        |
>>>>    | relocated   |     | 0x4037BC20   |     | 0x8086XXXX (stale) |
>>>>    |             |     | (unchanged)  |     |                    |
>>>>    +-------------+     +--------------+     +--------------------+
>>> So this brings up a similar question as v1. It's never going to be safe
>>> for SRAM to be pointing at some pre-relocation address in DDR. That's a
>>> problem, full stop. Going to the patch:
>>>
>>> [snip]
>>>> diff --git a/arch/arm/mach-omap2/sysinfo-common.c b/arch/arm/mach-omap2/sysinfo-common.c
>>>> index 49bc3a634fb..1b7bca3ee37 100644
>>>> --- a/arch/arm/mach-omap2/sysinfo-common.c
>>>> +++ b/arch/arm/mach-omap2/sysinfo-common.c
>>>> @@ -22,6 +22,9 @@ u32 get_device_type(void)
>>>>   	 */
>>>>   	return (readl(OMAP34XX_CTRL_BASE + 0x2f0) & DEVICE_TYPE_MASK) >>
>>>>   		DEVICE_TYPE_SHIFT;
>>>> +#elif defined(CONFIG_OMAP54XX)
>>>> +	return (readl(OMAP54XX_CTRL_BASE + 0x134) & DEVICE_TYPE_MASK) >>
>>>> +		DEVICE_TYPE_SHIFT;
>>>>   #else
>>>>   	return (readl((*ctrl)->control_status) & DEVICE_TYPE_MASK) >>
>>>>   		DEVICE_TYPE_SHIFT;
>>> There's not enough context to see what chips are in that final "else"
>>> clause, but they're all likely in a fragile and breakable state, and
>>> that needs to be fixed. Is there still a reason we're shadowing that
>>> information anymore, rather than always reading it? And, while we're in
>>> here, what other fragile things do we have SRAM pointing to
>>> pre-relocation-DRAM in? Thanks!
>>>
>> I had tried to root cause this sometime previously, it starts here[0]
>> where we have different ctrl register layouts based on the device/revision
>> and we call hw_data_init() early to setup these pointers to the right
>> layout early. This part is probably fine and saves doing the lookup
>> every time we do a register access.
>>
>> The issue is then that we use this double pointer with one layer
>> being stored in an SRAM scrachpad area. My best guess (this is
>> code from ~2013 so I don't have full history) is that this was
>> done so the pointers would survive SPL->U-Boot and not need looked
>> up again. That part is the issue, the sane thing to do would be to
>> just re-fetch these tables, which AM43xx does do[2] which seems to
>> be why it doesn't seem to need this work around. And the commit
>> that adds that for AM43xx[2] seems to confirm it was done for this
>> reason.
>>
>> Best solution IMHO would be to get rid of the odd double pointers
>> and just make sure the now single pointer ctrl tables are initialized
>> at the start of both boot stages.
> Sounds like a good plan to me, Beleswar can you take care of that?


I agree with both of your assignments. I was just trying to revive
the board to boot with this patch, but we should fix the bigger
problem here. Will work on it.

Thanks,
Beleswar

> Thanks.
>
