Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00238606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 05:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oTQJS/V+;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=lBn+c0rr;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=PkhZ+ivZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38B2D60840;
	Wed, 18 Nov 2026 05:21:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q1kaKop7M2oU; Wed, 18 Nov 2026 05:20:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4C32D6081A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794979259;
	b=ZqgsxG7cS7KVCXzGBGPRmrC6s+sX0tNGUJ3ylTYRQHm7lMGFHuclm3KAipMa9VtPga8u
	 /lT6VsrB5DBkZEGn+Tszz/ZbE4bFuKHOOr1J3Tm16UPT6ddBhMQuBE0HhrdmeZaz5q56G
	 ZHsXAlemANLMH7UJ6x7Co5gLviKaY++TfzM3H4SAbOan8uPNBbHNajN0r/4u50eGCnKci
	 nWATow7iMLsXu8WizaLW5uEkUiXVFXYncxR+RbnCKEocAc5mU4fCevsHRCFBN6t8ZiH+a
	 ifC+6LQrDXu6yS/juI4uikQSQYlD7aEqhvg5megY9PQ75q2KRz2FZSayNVve9ZFS8WA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794979259;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:CC:
	 Subject:To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=d7Sfo2xr0bxmB2eCOB1MyHm/WOqaTQgz3fhcFOXG/tQ=;
	b=tcrd6ocRYmTA7X6Nr5zuOUYqVb/s8X+bI+DVgYe1Gx+gY34C16AKuXqB5hdxcjBH0YBa
	 03kZSC8iXkSXi2N0au/dydQovjkvw48mI9Ea377bIAJ1qgewHVZDaWzoco/EoBJ5g2pzI
	 0svN+M/oM2RlCuSmoGN6scJ5CssFGO2oC+cziJCbK4nSxiI5qe/YTHS1j2o3oE+Zg6uMZ
	 cIKadP6mpBXj0ur+bBK0w6kP6YrTTfoFJj1NClF9vqUDYGUYuFuAYuJRWTFC01AcVmL4b
	 lPZmTdqi7Ie28X1PuB+Zt35bKDAxmWB6+tN2XID3tMN4/cPjLZ+/J1qN+ljmzPXgbqw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=lBn+c0rr;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=PkhZ+ivZ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794979259;
	bh=d7Sfo2xr0bxmB2eCOB1MyHm/WOqaTQgz3fhcFOXG/tQ=;
	h=Date:CC:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oTQJS/V+Ymf+TdWR941CuLQngBiGIqIGFxazmp48c18CXj2ysfqz0MeG+CBlix05R
	 9AZWNZpzhmQC7MXW5cFVr274jMP8TVSBP7Xj91a6841nZx9y8QwcXdigLQYSNo4PUd
	 NXyRmt+TDux2A6ULBF9z+KehLBrUlu9eF5e+y1icc/StUHlCr1rsQ9dJwfqq711wJW
	 LunWnwiQ2CyHn5zlp/FYUBuUjeBxPH+FmKL4kGmOrlFOXjsCSr6hf821fw/oQiKZC7
	 heMB5yFgdIjfXYf23Ud2hqXzU+APs0kKLzx/bq1YJO8/FniuW8GzohdBwzFDejYnDz
	 O0SZhjLnHPy7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C32D6081A;
	Wed, 18 Nov 2026 05:20:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 03E1D1E7
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:20:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E96F96081A
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:20:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id avRsi7FZUV7Q for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 05:20:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0B1D260743
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=lBn+c0rr; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=PkhZ+ivZ
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0B1D260743
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:20:55 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AI2UOs21896435; Tue, 17 Nov 2026 23:20:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=d7Sfo2xr0bxmB2eCOB1MyHm/WOqaTQgz3fhcFOXG/
 tQ=; b=lBn+c0rrVqTL5oQ+nn/3k8zrkoy8zH0hxD4Vsq8kgP+afOK58sFrEMOm3
 +P5lX/8YduBGNfODAnGHIw+1ObW1LCXfpcdXvalP5i8l7iFp4yPlFWI3Y9dINdDY
 /oYOPqYCwciS9FMDQG/Yqb+Wf3IRsR7xbv/E+rZ0ITwXB8YDvhh5bWGE/k4w/Ynk
 GUEawuTef9e3E9mHh7jqlgT22i5m3uhLxozD+lq9WiBGOknPhkaoPXUE97zoZgqO
 SylWUzTsCtRducAT7xIR+35rbehqBwKeVrzTPQTI3hctzeK9xi/uJ7v0q357tdm9
 ggnsdZC90HKPv+3L/bRSPq+M21S5Q==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011068.outbound.protection.outlook.com
 [40.93.194.68])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4j0yv21wd8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 23:20:53 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7Sfo2xr0bxmB2eCOB1MyHm/WOqaTQgz3fhcFOXG/tQ=;
 b=PkhZ+ivZ6QEA7pepC469Jo6luHoko5DO64Dubx2d95REG4f7Sy0cpU/QdK4QQWq8xKC8V8XY/Ue8Tgx+GefvO3Zwda7uSFMwgQqCvBcWXhjcqRNuR6hwZzbg3OMqrU3+q7iZhzqgaPORja25MTV/ztS30JEpxfUBjzkoLurpG3M=
Received: from MW4PR03CA0122.namprd03.prod.outlook.com (2603:10b6:303:8c::7)
 by SJ0PR10MB4765.namprd10.prod.outlook.com (2603:10b6:a03:2af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 05:20:50 +0000
Received: from MWH0EPF000DD30F.namprd05.prod.outlook.com
 (2603:10b6:303:8c:cafe::6e) by MW4PR03CA0122.outlook.office365.com
 (2603:10b6:303:8c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 05:20:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MWH0EPF000DD30F.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 05:20:49 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 23:20:11 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 23:20:11 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 17 Nov 2026 23:20:11 -0600
Received: from [10.24.68.238] (uhda0492258.dhcp.ti.com [10.24.68.238])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AI5K8Ke262549;
 Tue, 17 Nov 2026 23:20:09 -0600
Message-ID: <858beb70-8ee6-412a-8f0b-7de15e23803c@ti.com>
Date: Wed, 18 Nov 2026 10:50:08 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <ilias.apalodimas@linaro.org>, <neil.armstrong@linaro.org>,
 <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 6/7] arm: dts: k3-am654: add bootph-all to gpio@38 for
 daughtercard detection
To: Tom Rini <trini@konsulko.com>
References: <20261116055029.3493551-1-s-vadapalli@ti.com>
 <20261116055029.3493551-7-s-vadapalli@ti.com>
 <20261116161209.GA554944@bill-the-cat>
 <ce0cd06a-30d0-4ab3-9c5a-2c4f51eef7d7@ti.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <ce0cd06a-30d0-4ab3-9c5a-2c4f51eef7d7@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000DD30F:EE_|SJ0PR10MB4765:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e92589f-8481-4ba6-85d0-08df4533b513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|261102123227099003|10067099003|4143699003|56012099006|261028144727099003|261026140227099003|261021123027099003|261022105027099003|261021121427099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nAbiPgPFb/VGZXDY+j+4kDCx2fu7OUK+KgdWaIbdGVP5wiwe/FnveQB36AWxonxYz2BCF4g8DkNBEN8Dvb/n4pzW3YC5C6QKqwjiLVR0xjFYF363AkmI4NPCB6RzYK9RSMWXWhVN4z6e9RLsG66J71ajGYbeuKt0pgdETE9QAWXc43oDjWEjnMDOIVICc1hCEGbmdQp9TzMgv/nS9Y6BsFK23urp8casTXW3vWV6WITvq7vs4zbSqz6wDLQOtF+nBBOaNDzW8zvAzxDAJpy4T7e8CCCc7FkI56Elg8lmcGRQB/GtKzOO7K/p2M0nxojWj6eVsjMlSKWe7hpw+lnpkUykxV+L/f9Pf4sums6cSenqn6SOl/mH49AOMFcuyfdlFdYKkN7SRNBfKz2Ve9p3HJR9nj3X9gTXg6hZxoyd7aHfYA5lfE8pSYWhn/Bs92W8NAuBSMSMFD/+2brLU8jEauqqoslHZKHgYO+HGuRik4mXuFdx5ULAdyRvBfiTXod31zfhN8F9XwwtWI4sl6yaV0/gxqiVN51HmUsevL5a/nWWdBekzCciPiW2RSa/LtTVMfRog58ChncntIPZKBjerfQZiD8PhQzLgg3jldJ00uFbr8N/9M95iZ2BzF1pEOFH6X4WYDLcebecnzt55u8ifQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(261102123227099003)(10067099003)(4143699003)(56012099006)(261028144727099003)(261026140227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FzJnMbRD7pnYs1xw8bcq5HNnp5sTO0TsMJNrud2X9lwjC58p7SajHVppwFRMHu134l5z9j/GFlp7KbFqWJgW/4/LNHNn5ET+SDxaEF3O/zizA4a+AWFlcZ3XLkgemSIPGLZutkQ9AnzV5cjnh+dGPyI2LGmK0M4MBt5Ki6i1yOLrkxsHCCbP2csVuD7EURDEvwAvyUhHeQeo0axKQYuyO8RQZ7ET1RwtzaNHeTbOaEQiUsuauQmbLNDBytOZSoYS++auJY4fFHj36VVCbn/0Y7IiGAFuLA1BOx5xdnjPws7r/fB8yIRRoBNweou8EhlQlHFpxGhUY1TywnWMLYuPsT9VcaAciIJHfYPSPxMOBbGgM6qpyZ8XbrLeDVj8HBoWV6zpiJgQEsJjmwbKg3PVYwC52BvkBwJO8TezFU5YLI0LoHye5Q+OGImLmN/9zk7/
X-Exchange-RoutingPolicyChecked: qCly56S4UjyE4SC3RO1q6KfzlnRf/rpwW5P2piTYXlYVOGbmpttSVyZo8Z12ebt56B9ujhKJ3PGIfHRKnlzjMoMu/4NudWMgh/ydytbLx+NoF5afzGgd0vylYHRYvXkPtRSIbJASTEtowZGein9a3rMC2QIZcTlNHqfzn/fgS9LKMdXxpSia3amVt/2VnjCV+K3gbx2mymJ7zqDMAe838DC++5bhv+sQYaDCAldidBgkSJYURQozIQwsKqmOuw8bai6hnpjZ50/9/wr/J4YZtIKTIQLDyqvJMbCP94+5mvobFfARVJTARlLufn866CUmYMtLSNFBcNMhO9UtQbysTQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 05:20:49.2078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e92589f-8481-4ba6-85d0-08df4533b513
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000DD30F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4765
X-Authority-Analysis: v=2.4 cv=EuJHPicA c=1 sm=1 tr=0 ts=6afd35b5 cx=c_pps
 a=850PSMRYHTBgLER2XRwgFA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=-BjNimM4OT7RSGMTFNUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyMSBTYWx0ZWRfX7YhIRW7jfLnw
 IgdZ1JMhCbpvr9o+Jo3i/dp8fwswMEP3SoPYVOoQouE0+xhgmuv+ltEOX1XCwB3xOf6lm9XmHFV
 IJyvzGlaxp9o0X9nplN+DezkxISnd5Y=
X-Proofpoint-ORIG-GUID: 5GKJ6wP9FraFQkMGKO7TSYm8ZHNlNrC3
X-Proofpoint-GUID: 5GKJ6wP9FraFQkMGKO7TSYm8ZHNlNrC3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyMSBTYWx0ZWRfXzZAd14ooTpAs
 oKgnCgLEXbTgzvdzxCZzoxUDNvL8jk3gW6lrh38+6GNi/cFfuatgZfYkYmlVpVogLOnC8L/QLeV
 mxq5ltdUauvz6g+1H0Kx4WP+jivpfKbCUDYnAgHXH52X73eQtRgLPD4jgr5UZ+T6kWRZibxQiTH
 SPm+txQ76B9W62LGex1Rf2ZEbKfbS6m1pgVf4DJ7tKUxuVvlqhYb9RJNPiizHwta3YvICQpDgCW
 EMfgmQidh8ymFQcLn0I0BnVG3nZcfmgkWLqcSdCYlY1qVLACLCE0jz6bjahu2B80+h4Eabz97lm
 EMEFmWbu+Yc5yk9nSPvInigagPQqOo3MICIuHW59FZpwB12FC5C0DsgBiIM4FMkNXdF14NfYfwd
 v8m4MllyxFfMHQdP2cCHz9xjChj0AttPhZG02KpRy01nFeUpcgPtdxmVO6b33fRW3uE/2Dy+3XD
 1NKz70/i1ENfyfSwFfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180021
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 10:10 AM, Siddharth Vadapalli wrote:
> On 11/16/26 9:42 PM, Tom Rini wrote:
>> On Mon, Nov 16, 2026 at 11:20:06AM +0530, Siddharth Vadapalli wrote:
>>
>>> The GPIO Pin 38 accessible via WKUP I2C0 is used to detect the
>>> daughtercards mounted on the AM654 Base Board. For the daughtercards to be
>>> detected at the SPL stage, add 'bootph-all' property to gpio@38. This is
>>> required for the PCI-USB2 daughtercard to be detected at the A53 SPL
>>> stage followed by A53 SPL updating A53 U-Boot's device-tree by applying the
>>> device-tree overlay corresponding to the PCI-USB2 daughtercard.
>>>
>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>> ---
>>>   arch/arm/dts/k3-am654-base-board-u-boot.dtsi | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> What's the status of upstreaming all the bootph parts of this file?
> 
> I shall post the patch for having bootph-all added to the GPIO@38 node to 
> Linux Device-Tree mailing list shortly and will get back with the status here.

I have posted the patch to the Linux Device-Tree mailing list at:
https://lore.kernel.org/r/20261118051719.691715-1-s-vadapalli@ti.com
and will follow up to get it merged to Linux.

Regards,
Siddharth.
