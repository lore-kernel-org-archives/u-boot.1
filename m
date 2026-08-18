Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1679CC5DF7D
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 13:06:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C252A608C2;
	Tue, 18 Aug 2026 13:06:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Anmzo1EDpwOW; Tue, 18 Aug 2026 13:06:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E6443608D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787058381;
	bh=3ChAnYq6s1dKylNSoZSI6wd4Lphwpxp+DYtJK4m9JPM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z3RqrqlJVE3A9eVCrr20IlmxjvUTHu9ISyVD9rygMlclTp8DpiJyXaagudIP+8+7T
	 29mvp8rmdDW6C2IWFScDAAhbfVsyU6ANSj/wDJG+aKJsvSUvrf5wGfcPa1dj3zzLgx
	 Emc6ZdHDNadgA0zKMBfJkdSS3XZANjtllI7i8F1BWqb1flLMsDJ4KNMyQWS9LSTb9z
	 vTWHKt5aVA0x8BSnuPWg5813xrkSeuRwW80NTxUllQV0/lAnbmouJrj2g7ZFW835RS
	 rfbIM9WE0jG86yb+ITXFDbY0V2T8xGM8DUI5Yan22gjppTsL0bQlCiIukHwAY+7lE0
	 t3zQB8PlAT5vA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6443608D1;
	Tue, 18 Aug 2026 13:06:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B2B2E333
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 10:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A434F80EAC
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 10:05:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5lfaxnus3F-r for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 10:05:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=g-praveen@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 75BC580EAB
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 75BC580EAB
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=kaO4u9Q1; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=ef1TZAJr
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 75BC580EAB
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 10:05:27 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67I8lB3Y1934928;
 Tue, 18 Aug 2026 05:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=3ChAnYq6s1dKylNSoZSI6wd4Lphwpxp+DYtJK4m9J
 PM=; b=kaO4u9Q1pfHz923BIp1d24stXRH5tN6tBLXxHjrKjona5UQ2xlJ12SdNi
 kuv8+2uRbULmFjE0DzgETz3kdXL9V3975A8Qg7SxQzk/OkZXboMSqQpTTVppOaqz
 dTAdvfO8BKEa1PVDt69FZI5AJUCFOjX786LEWucx/nDWpVqGyCahLHaITuOP2JTD
 67Ts+YPiWfOSg1XPWmbSxE7/OT4y3RJirfIxH+z8myySdigiyy4wGne3vZAGzF/h
 QQObbRurmC0G55dUuUxwMV82HclEbvGq2oqw8DTc/VkpVFugIu5o+tett9B44xyL
 ZMAkqaUKFAkoRekOO0jRasNJX5XuQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013000.outbound.protection.outlook.com
 [40.93.196.0])
 by m0384305.ppops.net (PPS) with ESMTPS id 4g40dm7dvs-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 05:05:25 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsMiAcxipp4sCIujWyX2gU/SonstVSK0Cw8Cw4PqAaEk6ChkF2aHFD8oi49sr6V+eOpqzwnfn8KjPT+ak6HnYYQa+IvdVZppdotlCVkz0MAHdWxTMW/HNzvGgn9f5NAXpoXKHkQvvLrQq9yON+foIVnfa2i+oam5QLJVLVfsmUx4RUV4buwaHD46l30eyYAWlh3e1GcTCimUMrz+9JEPQ6VQdCA89SsQZtchuHEYZgl2uZDBIianSm9tsBkhmUBO36e/e81wU8nzwLFEUFPRrUgPNW09ACagH5egBhTR0pbNmugLZ52OX7Yl0sSnY69DzroDpZKQ1U++I0G4jb4yXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ChAnYq6s1dKylNSoZSI6wd4Lphwpxp+DYtJK4m9JPM=;
 b=ZI9636ydEdXIYUxwQa/7PYT/MVyHmGZIh5bdQvdnW/Lr9L2OeDLw+lQ9GGLAVQ4jpXAItodFuU+4zT2XlVllo4QfK9tT1MQqhyIaQhKCVHL9kbyiTcyrN+AEednXXRAfPVvUxYjbDlOhEk2yeQDmWYdlfkvZQ+/qDNV5/fDP14DpdL3DBns2/ra7pSEAisqwwXr4BhN7USVD6DyjGMYidGERfbFbzIYSDo2vXY3QTEvvXDPgSYUbeNA5e9ZPqKX1ZQOW32lV+bZpKa6AnkmZibvnhTdB1v5xcBVzUilbjtuFMRdr3NnnanF8RuBTymB0gLjRWhHoKylD6puOk6jgYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ChAnYq6s1dKylNSoZSI6wd4Lphwpxp+DYtJK4m9JPM=;
 b=ef1TZAJrihzjwYRzJlxOR9gaU5xdzrpjN01TWXSG2kNaRqPpHrwIM3zWWxDBtKtiiqUk0tVAGhAeaMm13sqn6TtG8KkepfIgPiX8Rlmc/Yl71EfBpWjTzAv7Nx7IBoEAlqQYIkCmgAGOqYqYooFl6hzhYEOkGgAoGxTw9dA1N78=
Received: from CY5PR10CA0026.namprd10.prod.outlook.com (2603:10b6:930:1c::9)
 by PH0PR10MB997667.namprd10.prod.outlook.com (2603:10b6:510:382::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 10:05:21 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:930:1c:cafe::a3) by CY5PR10CA0026.outlook.office365.com
 (2603:10b6:930:1c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 10:05:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 10:05:20 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 05:05:19 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 05:05:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 05:05:18 -0500
Received: from [10.24.53.154]
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.154])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67IA5G75200208;
 Tue, 18 Aug 2026 05:05:17 -0500
Message-ID: <1a5a04d7-bc2c-4d1a-84ba-cb7418b2c307@ti.com>
Date: Tue, 18 Aug 2026 15:35:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Semi-Falcon Boot Support
To: Tom Rini <trini@konsulko.com>
CC: <n-francis@ti.com>, <u-boot@lists.u-boot-project.org>, Gokul Praveen
 <g-praveen@ti.com>
References: <20260814102153.44487-1-g-praveen@ti.com>
 <20260814145645.GJ3297518@bill-the-cat>
 <26cefba7-df22-4043-9383-b5451ce7cf95@ti.com>
 <20260817212208.GW3297518@bill-the-cat>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <20260817212208.GW3297518@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|PH0PR10MB997667:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc5694c-4eb8-4b74-4d38-08defd103682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|10067099003|56012099006|6133799003|22082099003|18002099003|4143699003|13003099007;
X-Microsoft-Antispam-Message-Info: /nnbNW58ZzRJbJ2ujlD7bggcnz0axM1VWZaa1Zly3hXiyI3CkTdeFre5Wl/7JvlLiuKXi8J5sEFjYtisQdWrobuSyJrKuW6+Dt9qSslpxSdIFYlEZVDCjPWcBmG33RQ/suW2oLZhMwzoBAM0qiG+UOWUvBXDeKNPoQeZn+hfvq50kTNE5nNuIAaJfb72sfOU4CRHhve3bHqnxve3hoDEhg4VmQ1SdWT76CXJw+HIghSUIKeejBtyBjAj7I+Locy2xOeQGQoftZBy/wRAY1BUY4ugwjv6RmiXfOzzQiSOTOu2V9wHQ7lgw3RHazXAv72Mk1X3Zl/CN7NKEPBXqVjCaR+G94SLBSyeY23tDd4EDtBT0jiNy94AB7idrU1IQ2YeAFz3jrT8uhnaRf7elpWVd4MAI9bqvq98a5dPyj0aTYBCByICnTq1hkQUg/1pFG9SpDAhDTVrtA23RPYYktWRKihCqbt01wa7iwq7RB4F+1nRqQ2Dp755Y6+SpBbT80qNWYXCH/f9fMuhEhIZ2WU14bmf2eD41ucYbkalOUTRM2LT/xg4OZ/h58gjdHMbuHyhU88nPT5u9YywJxAJ9iT+ri+LLhOFnKy2J11NDrYYzB7UHE8z0fcjgKm8kUtF7fqK/vb6RlmgVL9IYB60nV2qhbHAELBDU0gdaLekDlWtdRTzt75AoynUIFN40fnTZi89SwEbKwhyjCSnENolOKmb0g==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5mMo/0B/BawW9JJclfJopVhQWXZjmCefqc803IQKjanEU1tWVyRj+6Lr8GTjApzW0A9KG8MF2qoHh+0eZiVH07wwA2O9kw3rRxHwUJzVYEAP1hV5lOE0G85vGK250CWCrcEmUc9mbZOxrCvG9tvvXCea/F0dkb+gA3IqbQmqAVb9ucSDvSlGaPbiT+PVyO3xqK/WXVQKdH76QfsFeXmlWAXSsYnqt3HV8H4SHT7ST89YSkUCNYVgM/SFya5WUqyU6l+xI+jzSRj7S7DSaqsRJ0j5EUSlzXQLrc9GVeFaYx5BkYJFYcnc+InBNKAh6/NKY7mXrWs3GpXew9KeOt+NPF1LAHviCzv+evsQwy71cEZa9H7X9uqL80WCwGMnaelR+/KgAnVOFu06/H6QV7P1Gabjvk9rF6QGGc7z0YO+IcCyZyX740dCp19eEZrtMqP9
X-Exchange-RoutingPolicyChecked: JQ0DmbEDNyRvzPlysnszIHCKMIgYiwHE3p5QUILR4VeDWgblKgI3w8kNipfC2IvVo9e8Dx3Bts5vlkXP7ZAtpxkYQ0/IsjvgwKcWniPcYWgL/a33gRqwumOUuUjxlOs73tRElY4YbxJhOPRDGd4zliZZL68NEb3V8KlRhZTPTrEIkcBrp3tYlbdq9//ke0Yi+DsXZDI5/ihuFqQl7LfF/ipbsw1HgFgN3+O7AkINfCmLJk05DLs7gDUrOH8miiTVTpEeWivpKd9hHWWLGR7w382fJYjPcPfRk+NHWfOM8mP4F6/dgkdgrM99nBrPEwXdAHDHtT/nzAvff+CF5C5fyg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 10:05:20.8202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc5694c-4eb8-4b74-4d38-08defd103682
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997667
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA3MyBTYWx0ZWRfXwV/z4qzBroem
 9NO+/ixCSGCEQCgc+x27IhqLiRMM73EoCgtrDFdDQudea+lubQDS9wulK0RakDRIRlIm7JsI3E1
 RGQkt3jSGU9tIRkNMUSMAD90qHDBVrIAQdAmaJrPxkz4a3z4HN0wBkQrLo8RW9YdRjrhb0mhujD
 s1XGz2UbX3WkclOyfyMaul/Ij9pGS+LwPFBZ4heJCG8abYbaSgENB9JPxUMg9jSyUH5t7RNrPWX
 XwxxT7IESbY275XdrKBV90XkbnvTlW6cwtasdV+pn0AA0Uz4TauAoDgtZltq9k5KZolEbKnB6XG
 u6ytWFUUOR5THKFlOx0DQZWBkdXR8xr/P1NP/NxpSEijlPzcqXCb2oNIiVM/Yf0MISWh/WYax15
 mB0nup1GeAV5hyJcic/bCW7oYCtgDP25wCYyVBgLjyZPS4u2tAORIR5TxNI1Q650uiLdOZPrpED
 WDITzp6i73MQr/ETeRg==
X-Authority-Analysis: v=2.4 cv=S8bpBosP c=1 sm=1 tr=0 ts=6a842e65 cx=c_pps
 a=9AjoWhdl+q7f6/Aw5qa/DQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=NEAV23lmAAAA:8
 a=d1X0za-6U1kMAa-URtYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA3MyBTYWx0ZWRfXx4/SfdWQt2Bc
 0fr6Oxz6OslBAT2E6VMTAN1fwGMTRAgAuEOAEkrlSs4IAi6HP41qqRVph/l7yav+PqH7+WGHza/
 fYVgrNKJrBNxocyNnhp8SLQANb/L4Ro=
X-Proofpoint-GUID: R-08Ahgv9oaeEXYrxXUZdb1NQhFbe9N7
X-Proofpoint-ORIG-GUID: R-08Ahgv9oaeEXYrxXUZdb1NQhFbe9N7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180073
X-Mailman-Approved-At: Tue, 18 Aug 2026 13:06:17 +0000
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

Hi Tom,

On 18/08/26 02:52, Tom Rini wrote:
> On Mon, Aug 17, 2026 at 01:46:10PM +0530, Gokul Praveen wrote:
>> Hi Tom,
>>
>> On 14/08/26 20:26, Tom Rini wrote:
>>> On Fri, Aug 14, 2026 at 03:51:50PM +0530, Gokul Praveen wrote:
>>>
>>>> Semi-Falcon Mode is a hybrid boot approach that bypasses
>>>> the A72 SPL while retaining U-Boot in the boot flow. This mode provides faster
>>>> boot times compared to normal boot while maintaining U-Boot's flexibility for
>>>> kernel loading and system configuration..
>>>>
>>>> Boot logs link :
>>>>
>>>> https://gist.github.com/GokulPraveen2001/fef407a482e2dad30272006de557627c
>>>>
>>>> Gokul Praveen (3):
>>>>     configs: add semi-falcon mode fragment for k3 devices
>>>>     arm: k3-binman: add tisemifalcon.bin for semi-falcon mode
>>>>     doc: ti: document semi-falcon mode for J784S4 EVM
>>> This is just doing what many other aarch64 platforms do, of skipping the
>>> SPL phase in Cortex-A because something else has already done any
>>> required initialization, unless I'm reading all of this wrong. So my
>>> feedback is:
>>> - It's not "semi-falcon", it's just "no SPL". Naming differences, if
>>>     any, should be done with that in mind.
>> Actually, there is an SPL in Cortex-R5 which is still present in the
>> semi-falcon bootflow.
> Yes. But it's not "semi-falcon", at all, as "falcon" refers to booting
> directly to Linux.
Oh, sure, I will change the naming convention then.
>> Its only the Cortex-A SPL which is avoided, which is why I did not name it
>> as "no SPL"
>>
>> *Normal K3 Bootflow*: R5 SPL + TFA + OPTEE + DM + Cortex-A SPL + UBOOT +
>> Kernel
>>
>> *Semi-Falcon* *boot flow* is : R5 SPL + TFA + OPTEE + DM + UBOOT + Kernel
> Yes, and this is similar to other platforms, where the Cortex-R or
> similar isn't exposed in the same fashion as it is for TI.
>
>>> - You should make sure to structure this so any K3 platform *could* take
>>>     advantage. I seem to recall part of the rationale for the current
>>>     approach is that some variants might only have a little SRAM (512k?
>>>     256k?) while others might have 1-2M and so easily fit U-Boot in SRAM
>>>     prior to relocation. It sounds like this specific family has a large
>>>     enough lower memory bound.
>>>
>> Yes, this is structured in a way that all K3 platforms can take advantage of
>> this approach and changes.
>>
>> Additionally, as there is an SPL running in cortex-R5 even with this
>> bootflow(semi-falcon).
>>
>> this bootflow can be used on all variants irrespective of whether they have
>> less or more memory.
> OK good. Just come up with a different way of describing this that
> doesn't say "falcon", thanks.

Sure.

Best  Regards

Gokul Praveen

