Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3E5606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 04:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X6g2fUPa;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=XhNl+fb3;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=a1ccbhQ3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4996440822;
	Wed, 18 Nov 2026 04:41:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wf_NmpWaE-IH; Wed, 18 Nov 2026 04:41:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8BBF340812
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794976883;
	b=QxaIxdU1Dy1z6hqwf0tvsDcHbWnvDdsYBKQC6ogtImf7yCKzlC9h97ZavLl/oXD9d8QQ
	 W3L8aNMlPcgCGReW1TakOZRJHupY6r+oQEgNvLt1ydj5R+7Tad4sEOTVQ5zdi/gkL4Ik4
	 PiijSStEbYRtJUrgOAgeOe+4NefOPXWcrNmQMVEJEviDyBSMen1258WgG6U7q6yAoTcbB
	 Xqt9/kX17w4Ur0F8nYnWjWrIpQVHvEn8U2ZCpYq8w1sRjKAO19NrXrvBdDyUNCuupo4l5
	 WRyMujOHt2/TwOlYKrocDUhsyR/A8uUkr8XTu2lTDycEIgMMexqET897RbTdzG52vkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794976883;
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
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AlibfwdDE48gKnslIwODhuqAJrMWVFU78oxh/0FKoOE=;
	b=YPEzr0ffoUjNdYV5ZxMGvxAmFx/Rk9lHm+w3q96lh959SthBHO4feeaUdApd3L4Hcqro
	 MGgSMbzrynJuux0zlFAT1/znHIL8pv8NsKQ2N/Lj2CkzA8pO7LO+bFOrdv+JLycgUAuM3
	 se+0rXdEGbbgjHpoNNTBtqnBsmRcmOd6UkZI0RMjZEkcdziFBsK4EL8oCNvRSBPS9cJLq
	 M+9dReCdzXerFViZtUlmABKy/4HZM2rQ3CGr3wqdx3syMzVIxcQEz3NsRbcbVieeM8h8n
	 8lJWK/hE3Cc1CZykuMS76yvRX89OYca1XBpevv9hK4g29trRZiT/1YHgA/8wuIcSlMA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=XhNl+fb3;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=a1ccbhQ3;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794976883;
	bh=AlibfwdDE48gKnslIwODhuqAJrMWVFU78oxh/0FKoOE=;
	h=Date:CC:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X6g2fUPaIHUWCMa0En61O/X7pjqLm/JrdPVtMw+Jz+tZAWcPE2IW4CDz+4aOxjkoe
	 VpgxuXT9wXkmqCU+6hTTsOZ1F0Aw4umjBQTECOHrR2UflUC2Ekb83rqrbquBvqMmzY
	 oVa9aw4gJHhTZLY2nTYwye5HCSpQZGZ4HE3Oxpk3IhGXwkDF/QCuZUSCpWIQAQ8tk5
	 OwNtDpWd9XHtPJf/dN2xFkbtD8htlJkOn7yPJpX5kffpD1Om3Zk8igijG/y1iTLlOx
	 uUMCxSp315IFCVMntxTuhXiglYUYV0vOZpPPqe4WDDUQ4ijQ4WP61cSrnwS3m1GTRr
	 hPi358RPk2Fcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8BBF340812;
	Wed, 18 Nov 2026 04:41:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 463DE70B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 04:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 37BE540812
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 04:41:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ytlM3EpbkdbU for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 04:41:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B8F8540811
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=XhNl+fb3; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=a1ccbhQ3
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B8F8540811
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 04:41:18 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AI2VJ4a1136258; Tue, 17 Nov 2026 22:41:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=AlibfwdDE48gKnslIwODhuqAJrMWVFU78oxh/0FKo
 OE=; b=XhNl+fb3aXnFATKsmcMsYnlECPAI+7nPc9vzOYBczJmMSk0jv2HJtEdtk
 Q3n3Bk1psbwvBoWGnJ/j5N3t9Y41PlTAGJ1yoYDQNCsnQpnyMnYOfPT3zEn1g4R8
 yr+TRVf/BSjqd7uoRBzsmZyy67KAMNJaUKeU8oqXwFWbHHp8beYUWgT72nCyCm1E
 9Rn2RQ7oqO8NrDNr6/SDlqCPQOlx+Dyzl0Ym1CcifMKkAKVV2BGkcovlWbmEXwhi
 auhu/5BgrrejvcD8mBNbkVJlW1FmY7P8vFLnKCAPr8HpZrIbQsmq7LtUhAeJIsc3
 +P9hvjK9jWQLp51f6q/AVVT+b/kUg==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011060.outbound.protection.outlook.com [52.101.57.60])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4j0yuw1rxu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 22:41:16 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlibfwdDE48gKnslIwODhuqAJrMWVFU78oxh/0FKoOE=;
 b=a1ccbhQ3C779w+alMUnTWDQo9f7Q/YMGLzCB7fYDFqoEuFxsPIIsOcKlEbayUN8XwKy5qYevC0rZYNuuOomi1X2ji7j0OfGHUTiFbgmfCNETxH/j74BpYoDfD0Pe+JTHm7ulLSl4T3PJI/YqYLBx67WhQC/AvL5wPdODOTpxJuQ=
Received: from CYZPR11CA0024.namprd11.prod.outlook.com (2603:10b6:930:8d::9)
 by MW4PR10MB6677.namprd10.prod.outlook.com (2603:10b6:303:22f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 04:41:10 +0000
Received: from MWH0EPF000D8953.namprd05.prod.outlook.com
 (2603:10b6:930:8d:cafe::ab) by CYZPR11CA0024.outlook.office365.com
 (2603:10b6:930:8d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 18
 Nov 2026 04:41:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000D8953.mail.protection.outlook.com (10.167.249.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 04:41:10 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 22:40:48 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 22:40:48 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 17 Nov 2026 22:40:48 -0600
Received: from [10.24.68.238] (uhda0492258.dhcp.ti.com [10.24.68.238])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AI4ejEm1203160;
 Tue, 17 Nov 2026 22:40:46 -0600
Message-ID: <ce0cd06a-30d0-4ab3-9c5a-2c4f51eef7d7@ti.com>
Date: Wed, 18 Nov 2026 10:10:45 +0530
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
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20261116161209.GA554944@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D8953:EE_|MW4PR10MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d420b98-3a54-4757-9c90-08df452e2afb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|18002099003|22082099003|261009223027099003|56012099006|4143699003|261102123227099003|261022105027099003|261026140227099003|261021123027099003|261021121427099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info: GfWg0JLVu6nBqV1UrJQ9JKfQgz7jc+5BdKpOf9LMpBXQLHJhP+OjTiaYwV8ifn0BWXfDz74NBZDTTI4DCMHReb9mZty/DrVRjMpE8ssTa+jT3Gzj2e8gxPYf1xgIB1IIppTk2ZEXy10AJDvzzgI9jHZeHDHBLhp5BQ93TEC9TbiVqPz4zeK4hzFodG+w6vco7+J5XWd++kqx16gU1hDCCUhB2e9yfzTeoC6QhrgBBByieV4tM6q5yo/4KLGwJNgH6z1S0vv8kOEyoc0AxvzLzcZ5HgpgHrxDhTRiCf6kC2bxvpwgJMWh18YkM06J7Dzj9NmmNFEO3xVew625m8rGRV6WrzSSwYfVfJilZ7zZKjGZL8fMbbe3vwyfru/2HJJwGKCQT0c+PxSNFce9Aaq/f5w2x0kqHVMuWhqHBUuSXCvbYoI2k50coADJ/dUWHyIbIfDs+lei7MzrQEkV1q/lpnNeBP9pljBGO2Y0bA87UZftxc+te3OIj3T9+fWRpT4Wuu4yF7p1ZrKLsJKu/NqOnnXJ8SOLKGm3Vys1mSYiESYVXhQls6pHPQeDLB3TZatGqG341/LoGlKCQ7DyVyJqdcuOCNtGzOuwI6SukkRtLSzqDjJZJSA6dayub7iJA0ju9HdDrVJ4LLwsq7vymwyP4fQw0abUrUD5nhaIUmdgb7HvB09HZuUla3//SdB2wRaZGnFtlSGVV5eIbvOxN+nTRw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(261009223027099003)(56012099006)(4143699003)(261102123227099003)(261022105027099003)(261026140227099003)(261021123027099003)(261021121427099003)(261028144727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: og+u6DgAICHB0oDyjIC0vnivuuyhC31litG4Pnfph1US+iX+6rLDm+ulRmQwthC4tK1CoKxXNpjBEswiPVmfWugbAZiKBP+Cx/JbCZkeySxEtP7GoQEEA1QWIrRDiA2Yv6hPtQ8DIybWi10tN2rjzx0+r+EnyWoh9Q/w/dBNV+lrFD6dTSZxklC1KeVJQKhJNz5SSUEeEoyqY9kb0+lxPaBIu6SXWT8JucdSzdemnuFyu6ec08xXezLdKLxQBztDwnPYl3IyGicSfPfFmoozOkZIIIkNbPW/jyi0+BnpyKE1mN5RkVkaayLbZ4cPDEQCr7Sp7wDG7KY5TTq5b/0swB8qbyssy7E3oaTpRBjUt1fyaYfC5aj238NUbYHTvQ4vvwLGuaKgl+Nd6S4fQg89dsWWzYa4UjLIcWo6pcyWlRObHWRJA2LtBl8OqUTm+puA
X-Exchange-RoutingPolicyChecked: O+6mypZbprfsooZj3K9Lj+DTC73LFZWQdtOZjbpFn5SyPdykcxo5pJr32KEkGKu0nJXq/ZZOBaC1XZVjvCnKZN6mKK3zcaEB/MF2ESVPtSegTL66Tx6zLAXqnrBJPuYpR5o+udsfwZuzvD9P9wtD1YSg5VPRJQdczpDvQ5DoR7j+46byUBwxo6ZNFEx67X/JiaWyUY2MtNHj2OCvbyC6JwFlef/7fojXYSQINvR6tR+s8PPX2LRtliIYJ2X87Y4Y6b+E5vI5SVU7xDZxwiQpfplzErwsDdF7B+uZ2x1lhaepLku8oGV/TAmDBsQZyaojJYikg5D2pm0qvTinyjqBmA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 04:41:10.0464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d420b98-3a54-4757-9c90-08df452e2afb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D8953.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6677
X-Authority-Analysis: v=2.4 cv=TJXQ2Fla c=1 sm=1 tr=0 ts=6afd2c6c cx=c_pps
 a=yyl0I9/pvHNpizRH36fpSA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=PScLLl-JCysZyvSaPU0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2HQ8s6Yn2MsEw4D7TOaRX8KXpOA9MAdp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAxOCBTYWx0ZWRfX+SVIszgwW555
 bibU7CKMZrzn9G1jmB9RtB81+QRpfVt5GoBJlZ2WamNirtAaffr/sqp/KYSn2uGpi5WrbgeSJbB
 5kXd1yFLTpEOq2tZegl3MsGJPPPV0EoPz0KlQNx7WjO+U8AXqMNniS90aPz+Q0YyGe47gUjTfAd
 hi25m7QZGYdzWKLIsNCI30/Q87b4yMNEtdLH7zFZy/Ydxn/b7rY3fl784OZ9HUY/HtidQUKv03H
 FsHWJNTq46vPHO2DyIb/8LQiK1EQUM3OYP2dL4h12H85Q6o9Zuh4ja/5YLs6Yct8oz3P+EsCjy8
 wIJYlnyiSGQmN/3Fp32kcFkSYj5AGKJqN1ZHDe2wxKPS3OcATYUA23unD/Dl8EAa38Lix7/Mnuu
 TTTQgpBHA+juW3f2FDYrGzw294JAnxgnvYIecjGBk4mrETau3Ox7uoUPexp5aleRXhAvsIEHxAv
 6/D+DLFYAcXPmfUtqiA==
X-Proofpoint-GUID: 2HQ8s6Yn2MsEw4D7TOaRX8KXpOA9MAdp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAxOCBTYWx0ZWRfXwA/be8xFQA1n
 dhcOzf5d2FyIQjW5v1/cSTAtbrkpQ9e3Hx+fVPizesGLxUvePM6en/xmBW9RBruHn5/e1RaF0WI
 GvLoFN8d5OEgedWKgmPtYAficx/L51M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180018
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

On 11/16/26 9:42 PM, Tom Rini wrote:
> On Mon, Nov 16, 2026 at 11:20:06AM +0530, Siddharth Vadapalli wrote:
> 
>> The GPIO Pin 38 accessible via WKUP I2C0 is used to detect the
>> daughtercards mounted on the AM654 Base Board. For the daughtercards to be
>> detected at the SPL stage, add 'bootph-all' property to gpio@38. This is
>> required for the PCI-USB2 daughtercard to be detected at the A53 SPL
>> stage followed by A53 SPL updating A53 U-Boot's device-tree by applying the
>> device-tree overlay corresponding to the PCI-USB2 daughtercard.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>   arch/arm/dts/k3-am654-base-board-u-boot.dtsi | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> What's the status of upstreaming all the bootph parts of this file?

I shall post the patch for having bootph-all added to the GPIO@38 node to 
Linux Device-Tree mailing list shortly and will get back with the status here.

For the remaining nodes, I will check internally and get back regarding the 
latest status.

Regards,
Siddharth.
