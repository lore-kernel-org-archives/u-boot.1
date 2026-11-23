Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2323D606A321
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 23:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zzDF+zIt;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=hWuVYS0f;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=jaww3mFP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2F6E80BBD;
	Mon, 23 Nov 2026 23:57:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wb70LUXfHbov; Mon, 23 Nov 2026 23:57:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B278F80E31
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795478246;
	b=Q1Qdq4z5ohswqdFHeqKa1AD2nsrzMrAdqbplIoqjMJnNl/CUtpVCXi7m7sN1EJEvk/TK
	 +oJrMjKRbeacYlzBuSZ+29+CFVHJjSKr7Q1GgT+DCQcZbdgEDLZ1UsycckT1XKNGBU+2D
	 +TX8NjfZkaG/kC5HQ++Q+JaMFVIxJ6zUncC7dG4XkwDeSIxjCbH5IDHW5S8w7hJ329gmQ
	 xBM0/BVw2fTxkInQR7OxxuYuZGLFQayBGXfNwYIXjQqaWAG/9RjPIe5aeduMUzjW2cTPC
	 brI1Us+7x81vsF2hyOi1oJj5ngPY8qulrYPLUDuuzrLNRDmosk2jaHcMHZErdCGBKhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795478246;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=seMtgQ1/qKJwrjepYuN8THuly9cau05R2ZdhFB6MNJE=;
	b=CVCqb3EMvC2h2s+0/zwCY7mg6B3HGpUZb6ZhhNO+rUACkbNGKSGms6CuHMDxmphDGAq1
	 e2joHS1ch0wgZSCltk3bQxS9xJM3uhxdE6MzopEv7QBvxYsOPoiqDL5dKNwvJ1cOstXny
	 jlz9vzV7l32EkGAxwCeM52nOJhm0NTuDBAYmFmtI+XVH13xWMoC3fGdE6Eixt2ouv2Su2
	 JKEXSYkhCYlp4kKWerkJ2c+nwoobSAnBhl4v4YZf9IY+zhJW2NwGYJQSnkDbJtOEv+Acy
	 uAAs/UCnSA4MIGnxBG0GbDJ3jz3NUQrTmcr+lQ2qkEG9xi3uhSVE00MmxUFKE0I6TtA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795478246;
	bh=seMtgQ1/qKJwrjepYuN8THuly9cau05R2ZdhFB6MNJE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zzDF+zIt5WecykY5qF+BK5K1WMFiWmsWk21Kqyr76CtDaMJCCKOlP1Le2LDF9XtlA
	 tRtZ4CzqhFS9f2/qvzXni8pESwqBycwZfJsLcDZCB+GQFasexJBnIm8KAbN30b7pSS
	 6uYGUvMB1qkj2oIhBEw8bBmZ0u8he8slZeRk3weVr/2vakh7DYNH6ppqDdPrJ82wVK
	 EGu2mUIR2yg0i5xdY1U7Et7PWVPuI2lJGnFUQLenKhHBl3YytWqTCBdXx/MeIKKx/e
	 +3Nx3FIadrpdYLsUM67b/oucgF06luqSeHm2Pi90hL8S67GTngtP9CUst1GNHjw32z
	 KFkQ7/Zp9DRCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B278F80E31;
	Mon, 23 Nov 2026 23:57:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D09593A8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:57:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B63BF400B5
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:57:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K6OFc0CHNiCB for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 23:57:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 36C0140068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=afd@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=hWuVYS0f; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=jaww3mFP
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 36C0140068
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:57:21 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANNVEpU339766; Mon, 23 Nov 2026 17:57:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=seMtgQ1/qKJwrjepYuN8THuly9cau05R2ZdhFB6MN
 JE=; b=hWuVYS0fYl0CQp6dhk9EpriYEPtz4LfWz1haiht750EZ3qEdsMEbeEjDQ
 NILvwaOgy3+iz/xlVQhrRIZciF9TfDDmbFVabT+5LvYVpNEwoCVIxjHtR2ASGaXU
 Z24KvhkutFrsBX1s1PXB9ai8hPowaUnGdBtUc/WWbNqMrEZ1YB2ZqxuL3isqDwoo
 mJNRKEBJC2J4RKZAhSZ1EFIIfTEGIogMBaW3hSJY/K7E2QN/UgjUJx10QH0qevte
 3F1a6kLVosuU5yRlWCUU1+4SNa4Cjh7UhrZkr1w7YwOnhx43bHxfzEC/N8EzBMVc
 kG/bAl8rbb47lwMI/Wy6tw+PdeVnA==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4j4v8q9076-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 23 Nov 2026 17:57:19 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seMtgQ1/qKJwrjepYuN8THuly9cau05R2ZdhFB6MNJE=;
 b=jaww3mFPz++0JV97BS2nPwqGHnWrJc+FMiXEgIAa2RSa3WfPqPq92i0uT78+Cbi8KqpaHuVoR+zdNzuHK6szMZKdg8ka54BmbGnakibn6E7sV6k6YQp2XMMvDnPXgw/TmrzsqYPnoFBEoOVe4lmvIVuqp4GrZXAIa4yFwE2O2jQ=
Received: from PH7PR17CA0058.namprd17.prod.outlook.com (2603:10b6:510:325::7)
 by SJ0PR10MB4415.namprd10.prod.outlook.com (2603:10b6:a03:2dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 23:57:15 +0000
Received: from SJ1PEPF000037A3.namprd04.prod.outlook.com
 (2603:10b6:510:325:cafe::55) by PH7PR17CA0058.outlook.office365.com
 (2603:10b6:510:325::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 23:57:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000037A3.mail.protection.outlook.com (10.167.244.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Mon, 23 Nov 2026 23:57:15 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 23 Nov
 2026 17:56:57 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 23 Nov
 2026 17:56:57 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 23 Nov 2026 17:56:57 -0600
Received: from [10.249.33.32] ([10.249.33.32])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6ANNuusF445656;
 Mon, 23 Nov 2026 17:56:56 -0600
Message-ID: <7c986149-b124-44d1-95c2-9532abcbb604@ti.com>
Date: Mon, 23 Nov 2026 17:56:56 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm: dts: k3-j722s-r5: Move DMA access configuration
 to generic dtsi
To: Francesco Valla <francesco@valla.it>, Nishanth Menon <nm@ti.com>, "Robert
 Nelson" <robertcnelson@gmail.com>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Vaishnav Achath <vaishnav.a@ti.com>, "Jayesh
 Choudhary" <j-choudhary@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Beleswar Padhi <b-padhi@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Chintan Vankar <c-vankar@ti.com>
References: <20261124-am67a-j722s-unify-v1-0-19a83f16d38a@valla.it>
 <20261124-am67a-j722s-unify-v1-2-19a83f16d38a@valla.it>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20261124-am67a-j722s-unify-v1-2-19a83f16d38a@valla.it>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A3:EE_|SJ0PR10MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: 880e79f7-d796-46dc-3014-08df49bd7fdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|261022105027099003|261026140227099003|261022075727099003|10067099003|261021123027099003|261021121427099003|261102123227099003|261028144727099003|261009223027099003|6133799003|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: 37MXHo3qzhbjAHMlt+kbUX7ONrvrdqch8EtcpeFrNreI/MAu+6LHfqXaU+YS1DPikXvZo/Dd8VmhTgyUB54taAbMHtnbWj3JqPlPKHQ9C4dbS2sdBGsyMzz3Oj3DyzNSvFVBU5hT5Ae5l7iR3gbeTKdFPQCvmmnMUgVYb+wf37BGYNLnmHBcihpEZeYYy6GGoVnM2IbgyJ6osxt6nipozYhJFStdLfzDHd8uo4I4zx2ADks7mPcXv/Rrv85i17SgTK/uX9o2pP6X1x8L+tOq/WlaQOVYgQrPEv+qz8UoV1NhsEYy94nydWwLr43DMuG4PaQ7BL/ENg7acNbSpyKT31Y54SnGO15q4a4ZB1lJJxEhGaK+shtMiv8OvtmEBcSgjjyGxRMS5jb80eD5PX15waSDsTFTfaaXiCwhfo9jW/7Bq2lcfrfia+tVwL1UFIzigX971A6aF015XJbM0SWyr0OZTbQmBniyapChLwi+LjKpx6qfg9WmvDs8rG81tgRLKGo5kdi3MA1pFt5XADZaU4GzOFP/x4v1NBra/8eXoV+58w2K+Kozuk6LQAJrU6NshvR+OCw/Ho20mpz7NgQZqwSzaXvhfBr7KCLw6E7R6H3wztrF5WTka0p/t9LTGdspgaLBNLN0WpptttwlLUWSz2Vc4QrWFYFuJyTgnCKmM0dtIwLy8f+PefnsUigB3/cvYjIHVffvqTW5z2O/vyWpGA==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(261022105027099003)(261026140227099003)(261022075727099003)(10067099003)(261021123027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261009223027099003)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /Ex2TKp+cr+fvyrKPdnMayFQiStc+o7H0d0flnS5K4wXHivLe4eP1jkpB210ANbSmr6p6BJ4s5IUL4hkHv9H5ZtMNpoeq5WiTx1VNOxWVgIDUQnVSMiF2tu7beC9BL/SGW1N+Mh0a4JlpG7g42CFy19w+8GFxDLupppPD0rSVgMJ71SATZ/Dqdtg06gTMUGzg+M6a7j7ZuSTznCj1WSfAvG4NsNL29aPXyV0BoIaiubO3pjGG/dqyjGna95QmgZ85nqkVt2fSRJGT6wn9qGO+qxxSr+qb+6MK46RyJV+GXAh++pTNZaaSwFvk8rDwQTR6Cs/15UzlIjuBNjbpmW1Nl4kL36qAnt6hPrifHYNXBvIQWj2iYj+Dh7+YRtxcoAbQrhyDdG042WKL87F9YMXmMNNplIWqHHNUDFeIjnLoPHweL4xL34I3x8LZfPwbWP2
X-Exchange-RoutingPolicyChecked: eME/JE4AfZc1Yu1vPk2cipJF9ja0xqJOaQTET0w2yYG219fcAdlsQNNKGfO3s5GG4m3iNpEmSoHdIRSYNtD4jrKoM17Gr3m1Vh0LuH/Oac8ozAsf9AFUxqj+F8BBpY5ac26QI6QbzI/AEIjzE4lWdOLxpm1dl05GkNN/EA/ATEkf1xBy5uJD4+gUUX4d6Rwe8z52vPd2hE/A7w7REV/qam/N/9T5xorslxsChx5Fj2Tcuoo7hwCzb8+ElDIBb+kBi5LDmf7a80hdkRV/yVHZZFnKSP2ERcsGTPlSyF0cY6JgaHNV8Abf2XGWhw+pd1IxuJgRAVgAGXEkwJn/AZxOuw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 23:57:15.1310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 880e79f7-d796-46dc-3014-08df49bd7fdb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4415
X-Proofpoint-ORIG-GUID: KjdoIIHGX46jsrAMCIOR04RvmY7RjRQx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA5NSBTYWx0ZWRfXx3A/RvvHAS9D
 SHvDaW0eXYLSZjOE3mhycepUg7WO1jj+Y6A6caE+K+5UG3pcGv1k2M5uZAxXn94Uwbcy4StAUmG
 wFwIJmNvX+2/4XendQjJ61ePzS00nJLfh9msIdKoxUa+0wRkYRnLAoUnxX9hzMO5hkFK4xA+W/T
 nLPWKZj95kAD9LfQjT4duxcxczBveH8y2agcHKXAgDjOtIdjDtQafFvbtXgyhPR6ejO5kFPgpqF
 EXzZvrXHomj4tuo/bh8iU4w3afUACenFwUPDPvbJv2e/nNDxyCG3P9pSxMe1wwUPtWtw8CsSzGo
 oq4B5Dy0RkK7fQecu1oauKWBsC0sITk/OCxmJNfUTcN8tYeKG0tf7gplbTmVuBzHZKk10Qu0Ndw
 9WD6GNS17jkHb9JHo5aUwp7LWEVkS5CwiRUKnitsc+YYwnwySNqvZ1333/GeCoDsLwVMNwQ5YNY
 kw3h4U4LJNEGAKSowbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA5NSBTYWx0ZWRfX+0NB0K/dakV3
 KzVDxt2UxGF2BnL93+wJ2HPBzbE8RhoZGIzAgAt1+1pUiULJxWOcvNKMxWaMnRxalXCXu1Den6O
 ryci/n2fXvz0P8qPXS28MGrTTeX036A=
X-Proofpoint-GUID: KjdoIIHGX46jsrAMCIOR04RvmY7RjRQx
X-Authority-Analysis: v=2.4 cv=CNe/zhrD c=1 sm=1 tr=0 ts=6b04d2df cx=c_pps
 a=RGUNHxVObgwraRyadLFC+w==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=xL__ugQoYb1uu8tlHisA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230095
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 5:44 PM, Francesco Valla wrote:
> In R5 SPL, the UDMA ring and channel configuration requests must
> always go through the DM2TIFS channel (dm_tifs) rather than the default
> dmsc node; this is not board-dependent, but applies at SoC level.
> 
> Move the configuration from the EVM dts to the generic dtsi; in this
> way, the BeagleY-AI (the only other user of the dtsi) can benefit as
> well.
> 
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---

Acked-by: Andrew Davis <afd@ti.com>

>   arch/arm/dts/k3-j722s-r5-evm.dts | 8 --------
>   arch/arm/dts/k3-j722s-r5.dtsi    | 8 ++++++++
>   2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-j722s-r5-evm.dts b/arch/arm/dts/k3-j722s-r5-evm.dts
> index e1ef5d181ed7..62c44d33e186 100644
> --- a/arch/arm/dts/k3-j722s-r5-evm.dts
> +++ b/arch/arm/dts/k3-j722s-r5-evm.dts
> @@ -15,11 +15,3 @@
>   &wkup_uart0 {
>   	status = "okay";
>   };
> -
> -&main_bcdma {
> -	ti,sci = <&dm_tifs>;
> -};
> -
> -&main_pktdma {
> -	ti,sci = <&dm_tifs>;
> -};
> diff --git a/arch/arm/dts/k3-j722s-r5.dtsi b/arch/arm/dts/k3-j722s-r5.dtsi
> index 9ddb951e078c..cc1efa5e20c1 100644
> --- a/arch/arm/dts/k3-j722s-r5.dtsi
> +++ b/arch/arm/dts/k3-j722s-r5.dtsi
> @@ -76,6 +76,14 @@
>   	};
>   };
>   
> +&main_bcdma {
> +	ti,sci = <&dm_tifs>;
> +};
> +
> +&main_pktdma {
> +	ti,sci = <&dm_tifs>;
> +};
> +
>   &main_timer0 {
>   	/delete-property/ clocks;
>   	/delete-property/ clocks-names;
> 

