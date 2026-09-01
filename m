Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB06C61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 16:23:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41CF180E2C;
	Tue,  1 Sep 2026 16:23:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6DH18g3kK5zV; Tue,  1 Sep 2026 16:23:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788279817;
	bh=EDdyeA19OFrW/qMogzQuB43C/jn6rl2wfgkdC3LwRxM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OrZs5wxyxKwzrJ/myuLIbedysgvFZ0n7atOn3EjLTH+ouu7LX4WA+l0hOgXdjaW+H
	 CW2C1gqULs6W/g3/ooeG0c+6fBYGvoF1JIQYij9FrBzn5xPWa7daEcAePj/Feoe5Bo
	 cu+xWqEDv7ypgNJlPWtlUykRtIEkAxWDvc5meszZHmk7IU+B9Jag08U6tLwdjqVBGT
	 nwj6SQ9DV3vowrap1LvJH0X7De3cJ2AkGO2Fkg8okQZOs1SDuLJWmdNphC/9qlw/iA
	 vXhNJlaATNd/bkd1jCFPERb0HiuWMfw+UY+FR3TTt3AD53DeF8b3w6wv0EG5wJeV1v
	 n5tS1Xbb+PV8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2FC880E17;
	Tue,  1 Sep 2026 16:23:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A0601D9
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 16:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 569184073C
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 16:23:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wkbHyTEXF84m for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 16:23:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=PfC0DsV4; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=bywYVe/0
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5B3534074F
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 16:23:34 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681E8gtl3728985; Tue, 1 Sep 2026 11:23:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint-05-2026; bh=EDdyeA19OFrW/qM
 ogzQuB43C/jn6rl2wfgkdC3LwRxM=; b=PfC0DsV4jJ5Cc7Gw3jg7Tn0oZkRQ6J7
 NEvdccjaHhVt+D/m6AMFE21pSbw901Y7hO/Uy2vc/XWwfU7fcdQt+ANvX3gEoZE8
 KWL8mcTZdLxPy8vV/QhVSSqQBSjYwyLj4mWMW/Usy/X6Bsch9WOUPpvUeZMW+GBE
 gNovM2ksEqINfO8sLUS3o2AvcJlFHvyq0NTmgXy4Jx+hLxOCi2IrQwG+EyVZUqLU
 K+L4gprD/9nzW5skRujnRw+zy6zyzrhygiCL/fhyAJoSRDFgsH0kvBukZj8Dtezi
 OvVrJC3Tc0AFGDuITNwha8GuH1Q/i14A0aFk+CSo+iXjZ8o2xK8rXgw==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gdw6s2272-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 11:23:32 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAgEx5XKTOxLUW4Yg0mNs6+QnP719YRwrMYVG1aoUJHI4fxkbJ+LvPkukQE7yBWQ3SPooC3OrpXU7Q+Oy7Piu+kLoLfy3QX1RJV58iRnXxMJHKeZdJHvm0gfldmwpPq3+o15upE15DN5ctdQXbxiTkSMRvPtIP2TpmzJ9szIqw6hMVsCgBWvlqSUpFUY3gtSJ/F6Z95ODO2MHrGrfAKHP0RpOoCwGDpb16Q0xzo+rCj6cV9f/b8LR+IRlR76QD4pQQBmKuGDLjwTPb9DIePqSjG4zaSaE5cEbaTZbyq2QC6zzL1KMXfpaAaCi3fPTyaBjRIijbGJSX/ZLhJh4fwXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDdyeA19OFrW/qMogzQuB43C/jn6rl2wfgkdC3LwRxM=;
 b=EEx3xWrY8zIQRa6rCbz3Fqi+hfuEXgnuWTgyo6VrEleri0wuudkJ97Ng2vc3WfKLFT+WNJZgoitJTPj4VZ5QlDu6C2DJbG5msNQRwWFXlqbhlXA8oQNZRE9N2FR0AArCbcwZTWsVKxqv14CinEy5m69h+H44t4ThntI/aNm+EnfbQ7wwsKm7DQvlixknGnRTZxgYpXrW3z1gTrW6heBFRFLdPD1tWbsauQT4Jyab+TuuzRdUJy/jFT802bDXyd33pzLCdPpnMdyDsd37fB8g8lkzSyhOZQMjepcre6FYYuhAsF8YA8fA2/9bDFaY2yoMU5UK4GCLj62JgMg5+gVI8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDdyeA19OFrW/qMogzQuB43C/jn6rl2wfgkdC3LwRxM=;
 b=bywYVe/0MCq2L0hryxbkUqkDC2yxaVuTS2xKoQN1mEWeem/9eS1oiL7+2WlufqG5PrX1ODmuxnOA8CsmQLO96nLoZMTHK3vfM3vLHxz00X3qL6ae6hbP+d4HPISCUPLXO5OqLpCNGMlPhZs5a/kIJMRSzDYAfNFdLfYk2Anokmo=
Received: from CH2PR07CA0063.namprd07.prod.outlook.com (2603:10b6:610:5b::37)
 by DS0PR10MB7431.namprd10.prod.outlook.com (2603:10b6:8:15a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 16:23:29 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::41) by CH2PR07CA0063.outlook.office365.com
 (2603:10b6:610:5b::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 16:23:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 16:23:26 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 1 Sep
 2026 11:23:03 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 1 Sep
 2026 11:23:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 1 Sep 2026 11:23:03 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 681GN3fO2096890;
 Tue, 1 Sep 2026 11:23:03 -0500
Date: Tue, 1 Sep 2026 11:23:03 -0500
From: Bryan Brattlof <bb@ti.com>
To: Gokul Praveen <g-praveen@ti.com>
CC: <trini@konsulko.com>, <n-francis@ti.com>, <a-nandan@ti.com>,
 <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH v3 0/3] A-core no-SPL Boot Support
Message-ID: <20260901162303.ccuk2gvcoogftjmy@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260819101910.39192-1-g-praveen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260819101910.39192-1-g-praveen@ti.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|DS0PR10MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: 7357faa0-d604-4e5f-10a4-08df08455a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|6133799003|10067099003|56012099006|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: wdqVugjDJH+SGeZZLsmqumYbC4A7akOubr+wIBzAHOOFnP3tVkh+UVm4jME5nuSuv2J7TK8qgP7nl/iOCREk8O3wwjZutW2WBvbGYlbbRaucK7av/wax9xUQzLQWTHz6gkd7hgpkBLx/zxilqNfk3dyoMsEjQMCTJh2vqSJHd7+Xu5VcNMYRJ/APpraBpSV581ICQaWtgJqHclcd+7HzEn6dOzGH2iit8DkQewDuj3rzNJ/L6pm2FCy1F3PaKzt/EBk4CCU7+UQX7LPpAjnSTvfvFlWtLQogQokcY7N4pCYdLs3JcwzW+GCY8eM3HjNCTZErJJJy0YUg3WXa9sXSk386fkUKcBQnnR8tfEsUWphuE2d7NlYRnr0eFBGbhB/3tCPyiDnIpVWlFufPEkfJ+AUfgDPAAWfNJpcp4gw5t7jqWpJH/jhT/nMNFhm8ChESd6jRV/6DqhEvR7LMZN8s+Z8yjDshuFWYXW9EZgC0OCyT0bRluS1ClhxV5YRf4BRE+ZyZ9Ot5QMWMW+R8J+kQ3k36q5iGx7M59QMvf+o0XL30Uj1CzE5y9jdo8p0j5tRQXn9DfT/9G+EAc6BfxUu+tH1kmysYuLhUdcFseouZJICCwBR5TFrQo34LmYehqqcTAcAI161uYByl4MKPUqMFvaxNM/77rkYlRhYGsefKQrwBhxOC3UXXmLM+Ot40ovgkzuoRt5+wUY9oJq/jWDFcMA==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MKf28LDPij6UJvu9ByJfMC3O1I4FVS8ZvvY/z23hriDdwakVEv0BhygI0hh6BkXSEMonb5L8hoFLg8lhrdGfJ0ZizNVlvjQyvBC41c9/7jbH9F11wsQiCQ4d1d2k6dA/88LMhG77O5ZrDR0KZ1N3qQiSGUu02dF2d82/iQnjuEksMLqiN4WqMKQVJ6vU09YKeFMufa80LEQ7GqYIIG1Jndtp5qw2UEra7sBcjBtq4CSzW8Pi4AKdcD30pDg5NEaWYBByrl0rDCuT1oHLDS/gQXg5Pbtft1Jpb19H91Ds/Lg661bgH+ghouNJ55VzPEiUdkVsrNqsIEkorqMFZU7zArMZ8uC3D2X9yeHjBuaQaGZst5Gtzld+Pqnl3X0XpQUxurT97LZh4nypyeoefK2SSFUOkh/rM5gOSQExEAdWZ3SIEZlYTsepe6VosWUtehtF
X-Exchange-RoutingPolicyChecked: PKNYJQu24RwTmM4e46VPte+1uF5BKMnuUD8+Kb7+jK9n0oNBMCgBSX3BnNAqKT6wtEDfQGWkbbHNJ/1Hvyf8XAvgLac9w3VS2mUxUhfvlelpfok0VvA+Iq0oxWfuA8Z6tnxCn1jMQrYtAGgd3X9EqKbfdOSzzo7kxAq0GBqXPYqZwQWqLentiTePrx+/S0nDD9I9nn+ZYpQvQidYHvRA67SzE0wEVmcle9qp4YJFMxP/lSn6JSJBQnSf4pOe8d45udZINavLDyFDvotb6ery2Ph08sovV2Xn/iQhuqOM/HCmxnsvLa3Is0B9TR8XRqsLLZ9dkgDMqQC5tdk0ULViBg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:23:26.9574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7357faa0-d604-4e5f-10a4-08df08455a4b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7431
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE0NCBTYWx0ZWRfXzXaQKqHgcZWh
 zVCzWwnJUbmfwDMpVpg7utRQI3pg/peejFncAbzCrISw2ZZD0cx2L2Ntf1DJkHoWmPF2mkgscCy
 dXUpvTnEVYAKOUuA7w/k9lyg9F01G7A=
X-Proofpoint-ORIG-GUID: -ThlZhi11vpeIjXnotHcEKHPi75hPgCP
X-Authority-Analysis: v=2.4 cv=C9rZDwP+ c=1 sm=1 tr=0 ts=6a96fc04 cx=c_pps
 a=Qv0FdJiMAyQkWbHkl99ofg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8 a=0Ie-PWlWDQCjZsF76TsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -ThlZhi11vpeIjXnotHcEKHPi75hPgCP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE0NCBTYWx0ZWRfXzsYeME7urVG5
 gD3L/PkasUTV9qn11DeiVaNySSDDdCO+2TWq5cLDMUZay6lrlQbwYZkmLIafI91Le/2m0Vx9g1O
 RcXi/YeicwDGpLEmhVuPF1jNuzWfMoDClzIOY8hsZPfwKBC92EW9AEOqP63s15Cy6tq0eqgN6AU
 Z6W1HkAdTXECkvdJ8ttcaC8HBhJBJshsKniGG1D88/BkK2Acda4qu7hZwHTI4+I15uU1uunyxH6
 T2NAlO7TK9Chi588yJ3MGPDLpyTMmOwDdDLKd9CJ+SJAPBgwud/dwvBa11pdPQUE4r4ZwjGBsOf
 kmqokgAgwXShM69p8HWmDn8R7u4nlEb9QYIwJ8eqge8+W+UpFQk3ifb9MlTrHsHQ5sNlR//Pz9A
 tLUSSpLsuEtTXsBpJx18pXWz3xzCcCsq5jLRRs8hhUgdC0i+QgRBuBxVTVPX9pHpYSYk/6sj4G/
 M+qXOn6mzl/NRdg+vWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010144
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

On August 19, 2026 thus sayeth Gokul Praveen:
> A-Core no-SPL Mode is a boot approach that bypasses
> the A Core SPL while retaining U-Boot in the boot flow.
> This mode provides faster boot times compared to normal boot
> while maintaining U-Boot's flexibility for kernel loading
> and system configuration..
> 
> v3<==> v2
> ===========
> * Updated the naming convention used from "no-spl" to "A-core no-spl" to
> * make it more specific and clear..
> * Link to v2:https://lore.kernel.org/all/20260818115322.101705-1-g-praveen@ti.com/
> 
> v2<==> v1
> ===========
> * Updated the naming convention used from "semi-falcon" to "no-spl".
> * Link to v1: https://lore.kernel.org/all/20260814102153.44487-1-g-praveen@ti.com/
> 
> Boot logs link :
> https://gist.github.com/GokulPraveen2001/fef407a482e2dad30272006de557627c
> 
> Gokul Praveen (3):
>   configs: add A-core no-SPL mode fragment for k3 devices
>   arm: k3-binman: add tinospl.bin for direct U-Boot boot
>   doc: ti: document A Core no-SPL boot mode for J784S4 EVM
> 
>  Makefile                               |   2 +-
>  arch/arm/dts/k3-binman.dtsi            |  47 ++++++++
>  arch/arm/dts/k3-j784s4-binman.dtsi     |  65 +++++++++++
>  arch/arm/dts/k3-j784s4-evm-u-boot.dtsi |  14 +++
>  configs/k3_a72_nospl.config            |   1 +
>  configs/k3_r5_nospl.config             |   1 +

Please make sure to update the board/ti/*/MAINTAINERS entries for these 
config fragments.

~Bryan
