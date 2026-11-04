Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5E1606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cG4j4sJk;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UhLkcVP/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 886B76070E;
	Wed,  4 Nov 2026 10:00:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vhzxuVKjj4TD; Wed,  4 Nov 2026 10:00:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4170360828
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793786450;
	b=XKQGMtX85h6BsD9JolBW4X5I4QiA+jqoYKL3wcgCvRZlkYzpNsDTl5pDMrqD5PCXBUsk
	 g0Sc9KfschiXeLsxsJOo8hgKsfKq3O8huiqTsaUO5NVmqtSS3UgratpzlHlaLnj1Kycl9
	 B+JarWReykQTLcNmHuftVfG86qnvt3IwkywY+nvblJOpqnw5UHUX+XZU4icPY6h1FF8u4
	 a+vLUHisNrYtXgiomP/xDaQl/+dfUIgz69rZh4FJuSBgBYa6zJDsx2nHOMq2qWe1eI9Lb
	 YWfL8Tq+C/MdDH3q1ZLPy2I2ltQQdRYmPGKbJtvDdHhR/ye3ZpTM/gTlI5S1HklcPtw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793786450;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=CKF16kLB5vGtwWAIJz5vY1xkGLJAOVGD7RC0tXQMx7o=;
	b=kI2uhHR7kjx7+zUdO/S2HkQuhUMrVvZshiwOZa/WMaxcFA3rAi55saaxQ3bYIC0rU6/l
	 oYyorqeIbJrXnX2tLq0hDOyAHm1WUwo9KMBlVqrlce/Vp5ZmFuGHhifvMPbAFRT/24M2U
	 M8Xu7VbkZxzHR8FYg52wFUu+T7PITHX9uroqp5Phim8umB6xm3iUw+4X/f2jnQmfCH/jt
	 h2bT6WzWtkC4HWqwJneKZlsb3sVB7ysfMz+lk6A5rlkCna6SroBw1U5JmNi4QPdYdd9Wd
	 0rCQGdlpr8OdtXJ8xyJTI1yzhSYFYVliHfPomeYdmqfECbQMqDLXuiAQRfpqbMzUK4A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793786450;
	bh=CKF16kLB5vGtwWAIJz5vY1xkGLJAOVGD7RC0tXQMx7o=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cG4j4sJkdWsPkltMiDPd3cbnFRHEVU5ormdWpMFJ4MrwqqP3CPQZpZaBxt07vcXfb
	 /TAtYHYkvYfqsX8+9arnKKpzOvSn9F+Y5hpSMEZwgXJYLmTo75+6fKI5YcjRYQ3hjV
	 mu6V0DQS+yP0YzekmJ3CNWIMxhB+rg+ekvl7iYdydNviyCRiTuTCkOQDhelLdvUG8C
	 oWjcxW1Cd1Ca33j/Be3TvISRb03Ejk2gR0nuHi6U4g11G8xn4a+TeVBBbA+ulOnZsG
	 XokP4MMBhxlc8e7AEl3jQpMN+9T7kuI6svPRI5V5IeO1FHma5zOQZgdSYoAnVxjqdI
	 pfZaW6djJow9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4170360828;
	Wed,  4 Nov 2026 10:00:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F81E2B6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:00:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4558B4004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:00:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MrBWcGlnYpMs for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 10:00:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 493E4400FF
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793786446;
 b=NfEmFclVp04npJ/8VjtjgfxoGTS8NABcoZIvqZnER7I2IZkzhPvX3prRM9TExkwYPZXf
 3CyrexG7Z3kM2aACErcI+jzQIeqh/lA8URKceDOk+jv0zaxaSAx5hnDmvYR251ucG0M5F
 /9qouS1FfBAu53D65vBPgmK/bwYL2EB5kEgLORVAujucAV5ZY6ffzm7gPUGFY1J+CJDJf
 lyUDuXfl7CAGrnIjOcwSRY8VzjuVqMMIgrAKi7R7IzrMw4nrQCBEeN7gbXY3BoHFuYzgk
 SrZjDPVRAiIDRmQHRvRwBTBu9bSujP2ELeCoA+24JfftNIh/CNtvd7/6vFHLaLPef/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793786446;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=CKF16kLB5vGtwWAIJz5vY1xkGLJAOVGD7RC0tXQMx7o=;
 b=pCip8vbPsgzy5pnDIAi27Z4VSGD6L5ujB0cgRPmjTqHcsRzWwedEnby7/FhOpiuZbS2V
 C2NtrXy7PHqGIMk9FZiHlvhHSCQkzJ/cP3sEv48B04UybkVySoQciK7AIP7VVMpjnPC+w
 BBvlt6MiQgtcGZI1w/P7OMt4l6V8V5reig/R9g0L4sSUeVSJuLjeonlrhxGgE5CYcK2E7
 t9LFPeYDL28PXor9KgOf64LYlE6MeA1y6fmrjZ+IM4WkPw/8CWBIeQ9DGV/g99y6YpSQI
 qmcTOx9mKSLQ7EfC/V/QBbUwSlWfCY2bo0Z+pnwDGNlnj+bNHtNObC43QUIbXL8pgGQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b="UhLkcVP/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c112::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::5;
 helo=cy7pr03cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=UhLkcVP/
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 493E4400FF
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:00:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ijm0rHJObqllO/CQzesXEmf974PQLRrTgphs0RVKIfsl3PptftDmaF2XiYEmlWLQtzfFSUn5cp+85ibEe98cXzuEFmfpzrrhxB9YlXG7zBqoebtW/bHPlBF2cxTRSIEJSsi5pK/qxPYA+i2v2E7EmV5J+WoS4WhTZ35sq/LEFlrGPcNzhjmi6A9dfK1+TdL5QdO2sJxymmHDyMlIu/2lZRY90VK+amLQyei+EjJ5tvRkcE2H6LwB/9mkc1hQ+QVVqHfVAH7qfFzU9Tb0BhoA9F5w3WgC4BKoUhQh8/xXLTNA7xYDcUrZYJok2FTuENB8f7D6AsKP7ZyGF9nY4szvgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKF16kLB5vGtwWAIJz5vY1xkGLJAOVGD7RC0tXQMx7o=;
 b=j9z3RrzcUOpuQM2UYTLXHd76JDP/G6iIBS0IyokReavW4hkbkLZrvCM4PFfC/vP7bK9Jt5zwMxbqQHqQ5+zud6+Db5wf48M1ht/s67bW9nRWRsJGyaz2MWjc7rwPShQ3cKUPQJCvLikd84dw/3B/Bwo9nfCcMYUV4Prd8iuCaGYbdqe/EJA5orxOZv9wa7JVSzftnaKu1Ex0YC2VFDP0BqSknGRvxWOpvNszRMmPk1qPV1dTQdJDMF2xS1GOAxxAvkEIw5/KL5T8Q9qDUoDZZqrgqkuf16dpf7fmkX9ODg/bD6Soqfo+MXRLn9dPlTJjnW0BZ6bLz5dd/y9+No7ejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKF16kLB5vGtwWAIJz5vY1xkGLJAOVGD7RC0tXQMx7o=;
 b=UhLkcVP/F+WJ0t9tMTm+E7iZrvwp1hmvewWqrSBYVjefsvtyrMZAUAlRVHVa5HMqJ83TO/AKBdpuZOvqci4nBt+HX/oRNzOWGg6THo/eJCUfNsIzWLKE8/ZCYu7zsNkexTN1lNkkRS64sxcknLVY3TlH2JMwHcz3j6q+E5HMnvc=
Received: from CH0P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::22)
 by SJ2PR12MB8111.namprd12.prod.outlook.com (2603:10b6:a03:4fe::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 10:00:38 +0000
Received: from LV8PEPF0000005B.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::3f) by CH0P221CA0022.outlook.office365.com
 (2603:10b6:610:11c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 10:00:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF0000005B.mail.protection.outlook.com (10.167.245.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 10:00:36 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 04:00:24 -0600
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 4 Nov 2026 04:00:21 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Amit Kumar Mahapatra
 <amit.kumar-mahapatra@amd.com>, Tom Rini <trini@konsulko.com>, Johan Jonker
 <jbx6244@gmail.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, "Daniel
 Golle" <daniel@makrotopia.org>
Subject: [PATCH v2 2/7] mtd: Add virtual concat support via device tree
Date: Wed, 4 Nov 2026 15:29:36 +0530
Message-ID: <20261104100005.4104985-3-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104100005.4104985-1-padmarao.begari@amd.com>
References: <20261104100005.4104985-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005B:EE_|SJ2PR12MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a99ad63-935e-4516-1d32-08df3a5a7910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|5023799004|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261022075727099003|261022105027099003|261026140227099003|261028144727099003|261026121527099003|10067099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: h/JVHwJ6761rltD42OF4eXpXKIV24ITRuYoX5sFybIqMClIB8TI+Wm9pO9J4t53r6Bm0ED6kA69NMSqdqPTsZom6DF3LI7qemlkMQDxhtMnkJ883MnZwNipQOiw4ipIxF0bRAtUbUXGtDliTAHsrfAtOL3HmxqCLbAFT8/HcCbKuuHjmALSIsxqV0MIK5zkONH+01Sd6BdDhu7hSeQQYI5YWAUj29NLkodNsd374UuSBHFiwHBZY0L8faeeT1vSFpVSDb0iGYLGw8djMXSJ60JViIR3s4m+1i6HK/Ws7f3MEsdj+I0IsHgrQJJRvuKU70OohkyvCnq4fAp2tPYoyuJVBp4GZj/pGSnsLbfcbXCmA/dVhIOKZ35lYRQOnJK5fZ9mVP5gO90sIC7DV3zM9jiQ/WKkC1IcECbBgXA2irpeWidgCprl15tUCNHmoMzdvg8ZKI5Ldawr0A6yoDs/wTRy8v6OPZlE7cyDSjNZFpnkNKPgJFmPHnpyOOBnyZAKwcH8lz0iYRbsh5MqRa4xsKA2j876qS9Avxa15qtCesN431sl+DHUVczErHbmNzgPChZjQJsJlsdI0VsUPG8JWPKoGymT44uFs3Cbs7ixNuJkCtfJ07wMA0w37HvF8UCK8cThR5mNiOC4v+578p9Yt8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(5023799004)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022075727099003)(261022105027099003)(261026140227099003)(261028144727099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tIApV0XfwjkQRx2Ul2OaB+PEih7NGrpADjiAPxL42STVTrwtSK3tJe23g0j0EP+L2fJYuQ+FVVQgjxAPQkWVUYwgLPppdBXdNrZwplxddwtLkxon/IDY9ngmMaeADv/XgLS0cOw12EoiwDtZjpNMHjx+rql/zsIAlOskDx6jLFM+1tVpNegd6TSr8qoWJvhOsfDoIeJ6yZO8+p8q+3lP02nAVRzFuX+pihYFHZUR/vQI7AZtQ4fKFrE93CVtokIkrP3Mro7XNEvMTlWH8T9rjSx7ellw34JaU7TacM1zBwyZX+787cIiHCOY9qCf2/zj/RZ4eNljUfqFks61uCM+mD0U/XsjWJkApNzIiSfGBeb+hpguK8m/vP5OXEoZiuIMMeS6fRy4wzepxFkyhQs7Qggs3ONEWlL3xxVNsQnaH9JB53hXuXLPHBYiz+UpgUxL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 10:00:36.2063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a99ad63-935e-4516-1d32-08df3a5a7910
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8111
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add CONFIG_MTD_VIRT_CONCAT to join MTD partitions into a single
concatenated MTD device, based on the "part-concat-next" device tree
property. This is useful when a filesystem spans partitions on separate
flash devices, such as QSPI/OSPI flashes on different chip selects.

The property is set on the first partition of a group and lists the
phandles of the other partitions of the group, as described in
dts/upstream/Bindings/mtd/partitions/partition.yaml. Only partitions
under a fixed-partitions node are supported, since those are the ones
which have a device tree node when they are created; partitions from
mtdparts do not. There can be several groups, each with two or more
partitions.

Each time the MTD devices are probed, the device tree is scanned for
groups which do not exist yet. While the partitions are added, those
which belong to a group are held back instead of being registered, and
so that partitions are found by their device tree node, the node is now
recorded in each partition's flash_node. Once all the devices are
probed, the partitions of each complete group are joined into one MTD
device, named by joining their labels with '-' and appending '-concat'
(e.g. "rootfs_a-rootfs_b-rootfs_c-concat"). Only the concatenated
device is registered, as the individual partitions are not normally
needed.

An invalid "part-concat-next" property only causes a warning, and the
group is ignored. If a group is incomplete, or cannot be joined, a
warning is printed and its partitions are registered individually. A
partition which is out of reach, and so has no size, makes its group
incomplete.

A concatenated device is kept when the MTD devices are probed again,
and the partitions which belong to it are not created again, so it can
be used while the other partitions of its flash devices are scanned. It
is destroyed, and the partitions it holds are freed, when a device it
uses is removed, which del_mtd_device() takes care of for every kind of
flash, or when mtdparts defines the partitions of such a device, since
they replace the device tree ones. A concatenated device which is still
in use is never destroyed: the device it uses cannot be removed, as
when one of that device's own partitions is in use, and mtdparts is not
applied to it, which is tried again each time the MTD devices are
probed.

Do not make the option depend on MTD_CONCAT, which also joins NAND and
CFI flash chips, which this feature does not need. Build the code of
mtdconcat.c for either option instead.

Also drop the reference which parse_mtdparts() holds on a device when
it does not replace that device's partitions.

This is based on the Linux MTD virtual concat driver.

Link: https://git.kernel.org/torvalds/c/43db6366fc2d
Co-developed-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
Changes in v2:
- Depend on MTD_PARTITIONS, and no longer on MTD_CONCAT, which also
  joins NAND and CFI flash chips, as this is not needed here
- Drop the IS_ENABLED() checks and rely on the stubs in concat.h
- Drop the forward declaration
- Use ofnode_find_node_with_property() from ofnode
- Warn about an invalid part-concat-next property and drop the
  unreachable -EINVAL path
- Register the partitions of an incomplete group, or of a group which
  cannot be joined, individually with a warning, instead of dropping
  them or rolling back all groups
- Do not concatenate a partition which is out of reach, or which is
  found more than once
- Use a single helper to free a group, which checks del_mtd_device() and
  keeps a concat device that is still in use
- Free the member partitions and their names, fixing a leak on rescan
- Keep a concat device when the MTD devices are probed again, instead of
  destroying it and creating it each time, and do not create its
  partitions again; destroy it only when a device it uses is removed, or
  when mtdparts replaces the partitions of that device
- Do not apply mtdparts to a device while a concat device which uses it
  is in use, and try again next time
- Destroy the concat devices which use a device from del_mtd_device(),
  so that it covers every kind of flash, instead of from
  mtd_device_unregister(), which is not built for U-Boot. Match on the
  members' parent, do not re-register the members, and carry on past a
  concat device which is in use
- Drop the reference which parse_mtdparts() holds on a device it leaves
  alone
- Record the DT node in flash_node for all partitions, and drop
  mtd_get_node() and mtd_is_part_concat()
- Refer to the merged Linux commit instead of the v17 series
- Rewrite the commit message

 MAINTAINERS                   |   7 +
 drivers/mtd/Kconfig           |  17 ++
 drivers/mtd/Makefile          |   5 +-
 drivers/mtd/mtd_uboot.c       |  48 +++-
 drivers/mtd/mtd_virt_concat.c | 457 ++++++++++++++++++++++++++++++++++
 drivers/mtd/mtdcore.c         |  12 +
 drivers/mtd/mtdpart.c         |  17 ++
 include/linux/mtd/concat.h    |  86 ++++++-
 8 files changed, 645 insertions(+), 4 deletions(-)
 create mode 100644 drivers/mtd/mtd_virt_concat.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ae3e9819d45..313f42ad939 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1318,6 +1318,13 @@ T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-mmc.git
 F:	drivers/mmc/
 N:	mmc
 
+MTD VIRTUAL CONCAT
+M:	Padmarao Begari <padmarao.begari@amd.com>
+M:	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
+S:	Maintained
+F:	drivers/mtd/mtd_virt_concat.c
+F:	include/linux/mtd/concat.h
+
 NETWORK
 M:	Jerome Forissier <jerome.forissier@arm.com>
 S:	Maintained
diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index f6bd9f6f2e9..58b5b3399f8 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -32,6 +32,23 @@ config MTD_CONCAT
 	  into a single logical device. The larger logical device can then
 	  be partitioned.
 
+config MTD_VIRT_CONCAT
+	bool "Virtual MTD concatenation via Device Tree"
+	depends on MTD_PARTITIONS && DM && OF_CONTROL
+	help
+	  Enable virtual concatenation of MTD partitions based on the
+	  "part-concat-next" device tree property.
+
+	  Partitions declared in the device tree are transparently joined
+	  into a single logical MTD device. This is useful when a
+	  filesystem spans partitions on separate flash devices, such as
+	  QSPI/OSPI flashes on different chip selects.
+
+	  This includes the concatenation support it needs, so it does not
+	  need MTD_CONCAT, which also joins NAND and CFI flash chips.
+
+	  If unsure, say N.
+
 config MTD_BLOCK
 	bool "Enable block device access to MTD devices"
 	select BLK
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index ce05e206073..15a12aec8ce 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -6,7 +6,10 @@
 mtd-$(CONFIG_MTD) += mtdcore.o mtd_uboot.o
 mtd-$(CONFIG_DM_MTD) += mtd-uclass.o
 mtd-$(CONFIG_MTD_PARTITIONS) += mtdpart.o
-mtd-$(CONFIG_MTD_CONCAT) += mtdconcat.o
+ifneq ($(CONFIG_MTD_CONCAT)$(CONFIG_MTD_VIRT_CONCAT),)
+mtd-y += mtdconcat.o
+endif
+mtd-$(CONFIG_MTD_VIRT_CONCAT) += mtd_virt_concat.o
 mtd-$(CONFIG_ALTERA_QSPI) += altera_qspi.o
 mtd-$(CONFIG_FLASH_CFI_DRIVER) += cfi_flash.o
 mtd-$(CONFIG_FLASH_CFI_MTD) += cfi_mtd.o
diff --git a/drivers/mtd/mtd_uboot.c b/drivers/mtd/mtd_uboot.c
index 69cb3b51f92..cbe7d5f4837 100644
--- a/drivers/mtd/mtd_uboot.c
+++ b/drivers/mtd/mtd_uboot.c
@@ -3,6 +3,9 @@
  * (C) Copyright 2014
  * Heiko Schocher, DENX Software Engineering, hs@denx.de.
  */
+
+#define LOG_CATEGORY UCLASS_MTD
+
 #include <env.h>
 #include <log.h>
 #include <malloc.h>
@@ -10,6 +13,7 @@
 #include <dm/uclass-internal.h>
 #include <dm/uclass.h>
 #include <linux/err.h>
+#include <linux/mtd/concat.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <asm/global_data.h>
@@ -202,6 +206,36 @@ static void mtd_del_all_parts(void)
 	} while (ret > 0);
 }
 
+/**
+ * mtd_del_parts_for_mtdparts() - Delete the partitions mtdparts replaces
+ * @mtd: MTD device
+ *
+ * Delete the partitions of a device before mtdparts replaces them. This
+ * includes the concatenated devices made from its device tree partitions,
+ * which cannot stay. If one of them is in use, nothing is deleted.
+ *
+ * Return: 0 if OK, -EACCES if a concatenated device or a partition is in
+ * use, other -ve error from deleting the partitions
+ */
+static int mtd_del_parts_for_mtdparts(struct mtd_info *mtd)
+{
+	int ret;
+
+	if (mtd_virt_concat_used(mtd)) {
+		/* Try again next time, as for partitions in use */
+		mtd_del_all_parts_failed = true;
+		printf("\"%s\" partitions still in use by a concat device, can't delete them\n",
+		       mtd->name);
+		return -EACCES;
+	}
+
+	ret = mtd_del_parts(mtd, true);
+	if (ret < 0)
+		return ret;
+
+	return mtd_virt_concat_destroy(mtd);
+}
+
 static int parse_mtdparts(const char *mtdparts, const char *mtdids)
 {
 	const char *mtdparts_next;
@@ -277,9 +311,11 @@ static int parse_mtdparts(const char *mtdparts, const char *mtdids)
 		 * and if they are, we shouldn't create new partitions, so just
 		 * skip this MTD device and try the next one.
 		 */
-		ret = mtd_del_parts(mtd, true);
-		if (ret < 0)
+		ret = mtd_del_parts_for_mtdparts(mtd);
+		if (ret < 0) {
+			put_mtd_device(mtd);
 			continue;
+		}
 
 		/*
 		 * Parse the MTD device partitions. It will update the mtdparts
@@ -315,6 +351,7 @@ int mtd_probe_devices(void)
 	const char *mtdparts = get_mtdparts();
 	const char *mtdids = get_mtdids();
 	struct mtd_info *mtd;
+	int ret = 0;
 
 	mtd_probe_uclass_mtd_devs();
 	mtd_probe_uclass_spi_nor_devs();
@@ -357,6 +394,10 @@ int mtd_probe_devices(void)
 			printf("Failed parsing MTD partitions from mtdparts!\n");
 	}
 
+	ret = mtd_virt_concat_node_create();
+	if (ret < 0)
+		log_err("Failed scanning DT concat groups\n");
+
 	/* Fallback to OF partitions */
 	mtd_for_each_device(mtd) {
 		if (list_empty(&mtd->partitions)) {
@@ -366,6 +407,9 @@ int mtd_probe_devices(void)
 		}
 	}
 
+	if (!ret && mtd_virt_concat_create_join() < 0)
+		log_err("Failed creating concat MTD devices\n");
+
 	/*
 	 * Call mtd_dev_list_updated() to clear updates generated by our own
 	 * parts registration loop.
diff --git a/drivers/mtd/mtd_virt_concat.c b/drivers/mtd/mtd_virt_concat.c
new file mode 100644
index 00000000000..07082911520
--- /dev/null
+++ b/drivers/mtd/mtd_virt_concat.c
@@ -0,0 +1,457 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Virtual concat MTD device driver for U-Boot
+ *
+ * Copyright (C) 2018 Bernhard Frauendienst
+ * Author: Bernhard Frauendienst <kernel@nospam.obeliks.de>
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ * Author: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
+ *
+ * This driver enables transparent concatenation of MTD partitions
+ * based on the "part-concat-next" Device Tree property. It is used
+ * for QSPI/OSPI flash devices on separate chip selects, where a single
+ * filesystem spans multiple flash devices.
+ */
+
+#define LOG_CATEGORY UCLASS_MTD
+
+#include <log.h>
+
+#include <dm/ofnode.h>
+#include <linux/compat.h>
+#include <linux/errno.h>
+#include <linux/list.h>
+#include <linux/mtd/concat.h>
+#include <linux/mtd/mtd.h>
+
+#define CONCAT_PROP "part-concat-next"
+#define CONCAT_POSTFIX "concat"
+#define MIN_DEV_PER_CONCAT 2
+
+static LIST_HEAD(concat_node_list);
+
+/**
+ * struct mtd_virt_concat_node - components of a concatenation
+ * @head:       List handle
+ * @count:      Number of partitions in this concatenation group
+ * @num_subdev: Number of partitions collected so far
+ * @nodes:      DT nodes of the partitions, in concatenation order
+ * @subdev:     Collected partitions, at the same index as their DT node.
+ *              Each holds a reference taken by mtd_virt_concat_add() and
+ *              is not on its parent's partition list.
+ * @mtd:        Concatenated MTD device, once it has been registered
+ */
+struct mtd_virt_concat_node {
+	struct list_head head;
+	unsigned int count;
+	unsigned int num_subdev;
+	ofnode *nodes;
+	struct mtd_info **subdev;
+	struct mtd_info *mtd;
+};
+
+/**
+ * mtd_virt_concat_find - Find the group that contains a DT node
+ * @node: DT node of a partition
+ * @idxp: returns the index of @node in the group
+ *
+ * Return: the group, or NULL if @node is not part of any group
+ */
+static struct mtd_virt_concat_node *mtd_virt_concat_find(ofnode node,
+							 int *idxp)
+{
+	struct mtd_virt_concat_node *item;
+	int idx;
+
+	list_for_each_entry(item, &concat_node_list, head) {
+		for (idx = 0; idx < item->count; idx++) {
+			if (ofnode_equal(item->nodes[idx], node)) {
+				*idxp = idx;
+				return item;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+/**
+ * mtd_virt_concat_free_part - Free a partition held by a group
+ * @part: partition collected by mtd_virt_concat_add()
+ */
+static void mtd_virt_concat_free_part(struct mtd_info *part)
+{
+	__put_mtd_device(part);
+	kfree(part->name);
+	kfree(part);
+}
+
+/**
+ * mtd_virt_concat_free_item - Destroy a group and everything it holds
+ * @item: group to destroy
+ *
+ * Unregister and destroy the concatenated device, if there is one, then free
+ * the partitions held by the group and the group itself.
+ *
+ * Return: 0 if OK, -EBUSY if the concatenated device is still in use, in
+ * which case nothing is freed
+ */
+static int mtd_virt_concat_free_item(struct mtd_virt_concat_node *item)
+{
+	int idx, ret;
+
+	if (item->mtd) {
+		ret = del_mtd_device(item->mtd);
+		if (ret)
+			return ret;
+		kfree(item->mtd->name);
+		mtd_concat_destroy(item->mtd);
+	}
+
+	for (idx = 0; idx < item->count; idx++) {
+		if (item->subdev[idx])
+			mtd_virt_concat_free_part(item->subdev[idx]);
+	}
+
+	list_del(&item->head);
+	kfree(item->subdev);
+	kfree(item->nodes);
+	kfree(item);
+
+	return 0;
+}
+
+/**
+ * mtd_virt_concat_free_pending - Free the groups which are not concatenated
+ *
+ * Called before every DT scan. A group which has been concatenated is kept,
+ * along with its concatenated device, since the next scan would only create
+ * the same device again.
+ */
+static void mtd_virt_concat_free_pending(void)
+{
+	struct mtd_virt_concat_node *item, *tmp;
+
+	list_for_each_entry_safe(item, tmp, &concat_node_list, head) {
+		if (!item->mtd)
+			mtd_virt_concat_free_item(item);
+	}
+}
+
+/**
+ * mtd_virt_concat_uses - Check if a group has a partition of an MTD device
+ * @item: group
+ * @mtd: MTD device, which is the parent of the partitions
+ *
+ * Return: true if a partition collected by @item is a partition of @mtd
+ */
+static bool mtd_virt_concat_uses(struct mtd_virt_concat_node *item,
+				 struct mtd_info *mtd)
+{
+	int idx;
+
+	for (idx = 0; idx < item->count; idx++) {
+		if (item->subdev[idx] && item->subdev[idx]->parent == mtd)
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * mtd_virt_concat_add_parts - Register the partitions of a group individually
+ * @item: group which could not be concatenated
+ *
+ * Register each partition that the group holds as a normal partition of its
+ * parent, then free the group.
+ */
+static void mtd_virt_concat_add_parts(struct mtd_virt_concat_node *item)
+{
+	struct mtd_info *part;
+	int idx;
+
+	for (idx = 0; idx < item->count; idx++) {
+		part = item->subdev[idx];
+		if (!part)
+			continue;
+		item->subdev[idx] = NULL;
+
+		__put_mtd_device(part);
+		list_add_tail(&part->node, &part->parent->partitions);
+		add_mtd_device(part);
+	}
+
+	mtd_virt_concat_free_item(item);
+}
+
+int mtd_virt_concat_destroy(struct mtd_info *mtd)
+{
+	struct mtd_virt_concat_node *item, *tmp;
+	int ret, err = 0;
+
+	list_for_each_entry_safe(item, tmp, &concat_node_list, head) {
+		if (!mtd_virt_concat_uses(item, mtd))
+			continue;
+
+		/* Carry on, so that every group which is not in use goes */
+		ret = mtd_virt_concat_free_item(item);
+		if (ret) {
+			log_warning("%s is in use, keeping it\n",
+				    item->mtd->name);
+			if (!err)
+				err = ret;
+		}
+	}
+
+	return err;
+}
+
+bool mtd_virt_concat_used(struct mtd_info *mtd)
+{
+	struct mtd_virt_concat_node *item;
+
+	list_for_each_entry(item, &concat_node_list, head) {
+		if (!item->mtd || !mtd_virt_concat_uses(item, mtd))
+			continue;
+		if (item->mtd->usecount || mtd_partitions_used(item->mtd))
+			return true;
+	}
+
+	return false;
+}
+
+bool mtd_virt_concat_is_joined(ofnode node)
+{
+	struct mtd_virt_concat_node *item;
+	int idx;
+
+	item = mtd_virt_concat_find(node, &idx);
+
+	return item && item->mtd;
+}
+
+/**
+ * mtd_virt_concat_create_item - Create a group
+ * @parts:  DT node of the partition that has the part-concat-next property
+ * @count:  number of partitions in the group, including @parts
+ *
+ * Return: 0 if OK (including when the group is ignored because of an invalid
+ * part-concat-next entry), -ENOMEM if out of memory
+ */
+static int mtd_virt_concat_create_item(ofnode parts, unsigned int count)
+{
+	struct mtd_virt_concat_node *item;
+	int i, idx, ret = -ENOMEM;
+	ofnode node;
+
+	item = kzalloc(sizeof(*item), GFP_KERNEL);
+	if (!item)
+		return -ENOMEM;
+	item->count = count;
+	item->nodes = kcalloc(count, sizeof(*item->nodes), GFP_KERNEL);
+	item->subdev = kcalloc(count, sizeof(*item->subdev), GFP_KERNEL);
+	if (!item->nodes || !item->subdev)
+		goto err;
+
+	/* From here on, ignore the group on error rather than failing */
+	ret = 0;
+
+	/*
+	 * The partition in which "part-concat-next" property
+	 * is defined is the first device in the list of concat
+	 * devices.
+	 */
+	item->nodes[0] = parts;
+
+	for (i = 1; i < count; i++) {
+		node = ofnode_parse_phandle(parts, CONCAT_PROP, i - 1);
+		if (!ofnode_valid(node)) {
+			log_warning("%s: invalid %s entry %d, not concatenating\n",
+				    ofnode_get_name(parts), CONCAT_PROP, i - 1);
+			goto err;
+		}
+		if (mtd_virt_concat_find(node, &idx)) {
+			log_warning("%s: %s is already concatenated, not concatenating\n",
+				    ofnode_get_name(parts), ofnode_get_name(node));
+			goto err;
+		}
+		item->nodes[i] = node;
+	}
+
+	list_add_tail(&item->head, &concat_node_list);
+
+	return 0;
+
+err:
+	kfree(item->subdev);
+	kfree(item->nodes);
+	kfree(item);
+
+	return ret;
+}
+
+int mtd_virt_concat_node_create(void)
+{
+	ofnode parts = ofnode_null();
+	int count, idx, ret;
+
+	/* Discard any group which the previous scan did not complete */
+	mtd_virt_concat_free_pending();
+
+	/* List all the concatenations found in DT */
+	while (true) {
+		parts = ofnode_find_node_with_property(parts, CONCAT_PROP);
+		if (!ofnode_valid(parts))
+			break;
+
+		if (!ofnode_is_enabled(parts))
+			continue;
+
+		/* A group kept from a previous scan has the node first */
+		if (mtd_virt_concat_find(parts, &idx)) {
+			if (idx)
+				log_warning("%s is already concatenated, ignoring its %s\n",
+					    ofnode_get_name(parts), CONCAT_PROP);
+			continue;
+		}
+
+		count = ofnode_count_phandle_with_args(parts, CONCAT_PROP,
+						       NULL, 0);
+		/*
+		 * The partition in which "part-concat-next" property is
+		 * defined is also part of the concat device, so increment
+		 * count by 1.
+		 */
+		count++;
+		if (count < MIN_DEV_PER_CONCAT) {
+			log_warning("%s: invalid %s, not concatenating\n",
+				    ofnode_get_name(parts), CONCAT_PROP);
+			continue;
+		}
+
+		ret = mtd_virt_concat_create_item(parts, count);
+		if (ret) {
+			mtd_virt_concat_free_pending();
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+bool mtd_virt_concat_add(struct mtd_info *mtd)
+{
+	struct mtd_virt_concat_node *item;
+	int idx;
+
+	if (!ofnode_valid(mtd->flash_node))
+		return false;
+
+	item = mtd_virt_concat_find(mtd->flash_node, &idx);
+	if (!item)
+		return false;
+
+	/*
+	 * A partition which is out of reach has no size, so it cannot be
+	 * concatenated. Leave the group incomplete, so that the partitions
+	 * which were found are registered by themselves.
+	 */
+	if (!mtd->size || !mtd->erasesize)
+		return false;
+
+	/* Only one partition can take the place of a node in the group */
+	if (item->subdev[idx]) {
+		log_warning("%s is found more than once, ignoring the extra one\n",
+			    ofnode_get_name(mtd->flash_node));
+		return false;
+	}
+
+	if (__get_mtd_device(mtd))
+		return false;
+	item->subdev[idx] = mtd;
+	item->num_subdev++;
+
+	return true;
+}
+
+/**
+ * mtd_virt_concat_join - Create and register the concatenated device of a group
+ * @item: group with all its partitions collected
+ *
+ * Return: 0 if OK, -ve on error
+ */
+static int mtd_virt_concat_join(struct mtd_virt_concat_node *item)
+{
+	struct mtd_info *mtd;
+	int idx, offset, ret;
+	size_t name_sz;
+	char *name;
+
+	/* Calculate the length of the name of the virtual device */
+	name_sz = 0;
+	for (idx = 0; idx < item->count; idx++)
+		name_sz += strlen(item->subdev[idx]->name) + 1;
+	name_sz += strlen(CONCAT_POSTFIX);
+
+	name = kmalloc(name_sz + 1, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+	offset = 0;
+	for (idx = 0; idx < item->count; idx++)
+		offset += snprintf(name + offset, name_sz + 1 - offset,
+				   "%s-", item->subdev[idx]->name);
+	snprintf(name + offset, name_sz + 1 - offset, CONCAT_POSTFIX);
+
+	mtd = mtd_concat_create(item->subdev, item->count, name);
+	if (!mtd) {
+		kfree(name);
+		return -ENXIO;
+	}
+
+	ret = add_mtd_device(mtd);
+	if (ret) {
+		kfree(name);
+		mtd_concat_destroy(mtd);
+		return ret;
+	}
+	item->mtd = mtd;
+
+	return 0;
+}
+
+int mtd_virt_concat_create_join(void)
+{
+	struct mtd_virt_concat_node *item, *tmp;
+	int ret = 0, err;
+
+	list_for_each_entry_safe(item, tmp, &concat_node_list, head) {
+		/* Skip a group kept from a previous scan */
+		if (item->mtd)
+			continue;
+
+		/*
+		 * Everything has been probed by now, so nothing will
+		 * complete this group later
+		 */
+		if (item->num_subdev != item->count) {
+			log_warning("%s: found %u of %u partitions, not concatenating\n",
+				    ofnode_get_name(item->nodes[0]),
+				    item->num_subdev, item->count);
+			mtd_virt_concat_add_parts(item);
+			continue;
+		}
+
+		err = mtd_virt_concat_join(item);
+		if (err) {
+			log_warning("%s: failed to concatenate partitions (err=%d)\n",
+				    ofnode_get_name(item->nodes[0]), err);
+			mtd_virt_concat_add_parts(item);
+			if (!ret)
+				ret = err;
+		}
+	}
+
+	return ret;
+}
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 3d3a84df0a6..c3aaf0d58e2 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -33,6 +33,7 @@
 #endif
 
 #include <linux/log2.h>
+#include <linux/mtd/concat.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 
@@ -566,6 +567,17 @@ int del_mtd_device(struct mtd_info *mtd)
 	struct mtd_notifier *not;
 #endif
 
+	/*
+	 * Concatenated devices made of partitions of this device must go
+	 * first. If one is still in use, so is this device
+	 */
+	ret = mtd_virt_concat_destroy(mtd);
+	if (ret) {
+		debug("Failed to destroy concat MTD devices using %s (err %d)\n",
+		      mtd->name, ret);
+		return ret;
+	}
+
 	ret = del_mtd_partitions(mtd);
 	if (ret) {
 		debug("Failed to delete MTD partitions attached to %s (err %d)\n",
diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index f3b7f1ee13c..b148ab0f7fa 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -27,6 +27,7 @@
 #include <linux/compat.h>
 #include <ubi_uboot.h>
 
+#include <linux/mtd/concat.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/err.h>
@@ -908,6 +909,13 @@ int add_mtd_partitions_of(struct mtd_info *master)
 		if (!ofnode_is_enabled(child))
 			continue;
 
+		/*
+		 * A concatenated device from an earlier scan holds this
+		 * partition already
+		 */
+		if (mtd_virt_concat_is_joined(child))
+			continue;
+
 		offset = ofnode_get_addr_size_index_notrans(child, 0, &size);
 		if (offset == FDT_ADDR_T_NONE) {
 			debug("Missing partition offset on \"%s\" partition\n",
@@ -940,6 +948,15 @@ int add_mtd_partitions_of(struct mtd_info *master)
 		if (IS_ERR(slave))
 			return PTR_ERR(slave);
 
+		/*
+		 * Store the DT node so that mtd_virt_concat_add() can match
+		 * this partition against the concat groups, and let it take
+		 * the partition if it is part of one
+		 */
+		slave->flash_node = child;
+		if (mtd_virt_concat_add(slave))
+			continue;
+
 		mutex_lock(&mtd_partitions_mutex);
 		list_add_tail(&slave->node, &master->partitions);
 		mutex_unlock(&mtd_partitions_mutex);
diff --git a/include/linux/mtd/concat.h b/include/linux/mtd/concat.h
index c57e973775d..1e3bc1885a0 100644
--- a/include/linux/mtd/concat.h
+++ b/include/linux/mtd/concat.h
@@ -9,6 +9,8 @@
 #ifndef MTD_CONCAT_H
 #define MTD_CONCAT_H
 
+#include <linux/mtd/mtd.h>
+
 struct mtd_info *mtd_concat_create(
     struct mtd_info *subdev[],  /* subdevices to concatenate */
     int num_devs,               /* number of subdevices      */
@@ -20,4 +22,86 @@ struct mtd_info *mtd_concat_create(
 
 void mtd_concat_destroy(struct mtd_info *mtd);
 
-#endif
+#if IS_ENABLED(CONFIG_MTD_VIRT_CONCAT)
+
+/**
+ * mtd_virt_concat_node_create - List all concatenations found in DT
+ *
+ * Scans the device tree for nodes containing the "part-concat-next"
+ * property and creates internal tracking structures for each
+ * concatenation group which does not have one yet. A group which has been
+ * concatenated by an earlier scan is kept, along with its concatenated
+ * device, until a device it uses is removed (see mtd_virt_concat_destroy())
+ * or the partitions of that device come from mtdparts instead.
+ *
+ * Return: 0 on success, -error otherwise.
+ */
+int mtd_virt_concat_node_create(void);
+
+/**
+ * mtd_virt_concat_is_joined - Check if a partition is in a concatenated device
+ * @node: DT node of a partition
+ *
+ * Return: true if @node is in a group which has already been concatenated, so
+ * that its partition does not need to be created again.
+ */
+bool mtd_virt_concat_is_joined(ofnode node);
+
+/**
+ * mtd_virt_concat_add - Add a partition to its concatenation group
+ * @mtd: partition, with its DT node in @mtd->flash_node
+ *
+ * Checks if the partition's DT node is part of a concatenation group. If
+ * so, the group takes the partition, which must then not be registered by
+ * the caller. A partition which is out of reach, or which is not the first
+ * one found for its node, is not taken.
+ *
+ * Return: true if the partition was taken by a group, false otherwise.
+ */
+bool mtd_virt_concat_add(struct mtd_info *mtd);
+
+/**
+ * mtd_virt_concat_create_join - Create and register concatenated MTD devices
+ *
+ * For each concatenation group that has all its partitions present,
+ * creates and registers the concatenated MTD device. The partitions of a
+ * group which is incomplete, or which cannot be concatenated, are
+ * registered individually instead, with a warning.
+ *
+ * Return: 0 on success, -error otherwise.
+ */
+int mtd_virt_concat_create_join(void);
+
+/**
+ * mtd_virt_concat_destroy - Destroy concats which use an MTD device
+ * @mtd: MTD device which is being removed, or whose partitions are replaced
+ *
+ * Destroys each concatenated device with a partition on @mtd, and frees its
+ * partitions. They are found again the next time the partitions are
+ * scanned. A concatenated device which is still in use is kept, but the
+ * others are still destroyed.
+ *
+ * Return: 0 on success, -EBUSY if a concatenated device is still in use.
+ */
+int mtd_virt_concat_destroy(struct mtd_info *mtd);
+
+/**
+ * mtd_virt_concat_used - Check if a concat which uses an MTD device is in use
+ * @mtd: MTD device
+ *
+ * Return: true if a concatenated device with a partition on @mtd is in use,
+ * or any of its own partitions is.
+ */
+bool mtd_virt_concat_used(struct mtd_info *mtd);
+
+#else
+
+static inline int mtd_virt_concat_node_create(void) { return 0; }
+static inline bool mtd_virt_concat_is_joined(ofnode node) { return false; }
+static inline bool mtd_virt_concat_add(struct mtd_info *mtd) { return false; }
+static inline int mtd_virt_concat_create_join(void) { return 0; }
+static inline int mtd_virt_concat_destroy(struct mtd_info *mtd) { return 0; }
+static inline bool mtd_virt_concat_used(struct mtd_info *mtd) { return false; }
+
+#endif /* CONFIG_MTD_VIRT_CONCAT */
+#endif /* MTD_CONCAT_H */
-- 
2.34.1

