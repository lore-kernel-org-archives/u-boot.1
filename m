Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6689BC982FA
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 11:21:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 999E980E59;
	Wed, 23 Sep 2026 11:21:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id slpI0at5ltky; Wed, 23 Sep 2026 11:21:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 39CFD80E60
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790162506;
	b=WFKCZOUEN3DzKRMyNxTlbVHd6Y9SCCjdaN0k+SMuFI7W3NH61uKqUg8VPGtCKHyPX1To
	 tznFv/LzFruLlkFTW2c7SKTiInxuVB6hmPB/apsknNEjf2+9ZsUHIl2HOOFZv0afbQh4P
	 9thj6w5a6vZBXFMgH3Y9Gc2Kq0zNxhF8JNuniLuvAxqkqqmIMPgUi5Hn+WwBpbWkCxU0O
	 lrhWW0vHkKjsBhLsGF1U/eORibZyM7JyeJE+EeHfARVcJeSY9t4z6N6BAYCAyY/ul2qo+
	 t4gALYOCeTQRy0XQ40gmsTfzkols/1harHBAhCAN78zN1ie/g722rOi79jRaHdanGMg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790162506;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Xc3IimZ8m9d4LWtQtBqeuTTrcMzyrIKbrCzb0cesszo=;
	b=okM13SvNm+dABGFebFOQJGkZ1iawNwVjNnAFMf6VG5cx8qBxcq+BAaPBvvdMXE2Pitgg
	 onASRkJ8u2Ku5wcWtAa1H/y8Rajn5/8BcYh31PThgeqCxE0qf3YNePm49bOU31fabHTk8
	 P/wDZCI7xRrEz9J328b5BvoqLumWR/Yw8y0N0kXT9uo8lvhZ/KhIz6mxswDo/FMyicLle
	 RbYLRGAxVGLe3wBCYfznPWtYUDqijUlQDjxYDPAwyPiQxRq5ERP3rzraKIsFah+mDZo65
	 mZJ1P3Jqj0Uy/2ZTKXD0/y3Je1m9phJcRvwSlzDKMt++iAcJ5sPL6boBG/SMRq5yc8w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790162506;
	bh=Xc3IimZ8m9d4LWtQtBqeuTTrcMzyrIKbrCzb0cesszo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O7JJqbGDimE7CZNqAgT51lpnGhw8f052E6sN/9Su6hQwjY+9mm3GJ1BM03USpQ+gx
	 2lTmt6qt11JMSAYXfWaf92eQ69tt/h8tqZT7yxuoDPmG21lfJNGMuOlJCNdWBFvAUF
	 qRL6SuxbsuzyzoCU+GagO60iv9ftuW7MduZvH206zcdr7LnSvxAswXGtFK+sbD7mYw
	 qyc0iD38b3GWEFfS25aXGMczOEidTMddLZfNqwmO8Mw3pVAjPMK6foWX0T3LgAqB8Q
	 LfCIzCloeqlotzawzYFuRrF5OF3zjbBRQqofwiBft5MvP4XO9NRnm1iovJnaSIw3uE
	 0yB7S3iIMKNvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39CFD80E60;
	Wed, 23 Sep 2026 11:21:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 26A7C355
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 10:07:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0BC6D40564
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 10:07:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3cyJaoewbBvL for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 10:07:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A9BA34055E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790158074;
 b=oTTIi37oEbM1CEKC8JBJ6Cme7ZiZD9+Ibk6l6QFsrHvGORJOyBaSG68TNRJUvn2nlGHN
 KkQK3D+bvldsT7F656S6z1n58Yzx9hYRDPLMlImZL81fjvXrHRdXY7RazvGYhKhD6jYEY
 NXZR82Fbg2aMU1esgmfvSbb3ooPH7nSWxuuTe7p++QjXyeutvjy9IdFtiOJ5nFs4CVnRO
 zceb4i06d16xrp4NsDhWSevMUAokYhQCCQXhrkfJ3qptNtX7n5kRTXhBkafd2kZmS/dPR
 VBGQmSus0i3Xy0Cy+B7ncOxjqowp6n/qr84YPXiZL+IejKKN5y9SozCmdGpj1dt8uUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790158074;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=Xc3IimZ8m9d4LWtQtBqeuTTrcMzyrIKbrCzb0cesszo=;
 b=Cb71jKQ4A1OX7n6dX8vgNps8MWvd49/lzgD8OvWMLt8Zx04Vn0xwhbFoFByBsB9NMADd
 dmEANOHhswow5R4nnCmjlGpFM/eCCQyesYPzCCqXScwYnPt9WrAKSs/ZKFmlzyK6tn7iD
 Zt6hDy/CFknmiXtI/D0wAUUd2M5/K9+TFWJ4bc6gPukCmWw0Tm1PBhGXC8vjgm11b/zMR
 O35DoGg2wkRz31SdBYPKGLA1m9enjJn3uHioB8Y+LHxuYAvnZfBSLo60k+owC/9ZHdVd2
 eAFgfkpwDP2AdHv6OZmp+DBFmWbBmFnWfyATaZ7E9IyOfNSwMxdVzJVf5Z8CSpwdU3w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=VJBl+WuK; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=huuG7uGQ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=a-garg7@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=VJBl+WuK; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=huuG7uGQ
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A9BA34055E
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 10:07:53 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N8JJoK300258; Wed, 23 Sep 2026 05:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=Xc3IimZ8m9d4LWtQtBqeuTTrcMzyrIKbrCzb0cess
 zo=; b=VJBl+WuKP6nFg3lt5TGG0OevsV7PLJ7nAR8ETK4hIRW1P+rT5o0nP7ENj
 6Zb+gbw7+wJY1qAGaC4mU6lsL1JS8hYR6Hfgd1r7QqhzyTt0EcjZPPV0RXHGe8pG
 Lerq3FmYq/gOW6CrgODRiRzGlOuQgcqzxcv2SH4hC8SBm6PmZDizwck3NFTlsP8m
 A4b1js8RFxAIgNmVPeAQGJJzOg+bQuKLWj5OpfmDJSWijORbbNt/0y+yfvtoMdnb
 bEWY7PYs2YS+W2HHSGa5O7lYO7MC5lr4ah1EmFTEEY9jVO3Bp0u7qX3/PXIyr7eN
 xhDL/uw5biVK4KSWtxvBgvoRI1Wbw==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gv54tjha4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 05:07:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DaEcQX2uMSn1/LnGvmIFs50ukgEEHUOHrXqQl6zZGC+18wWZh2eAXdYAKm4MZ/JxcAJWSAyGvFEwTx0hC4j9aDW5NFV5d9UIDpywV7fq5k6m95Ef6AZ/WFQCEmOJyobi/FqUVpwwUxBmPMHPgvAmCNB7u7NCGhG3r+aenrXrsmV2+1EwEsmJBo/RWKvtD/VC7QpNQ1R+TVybz2otOEMchLLs8F5Btupe9xPiNNv8U1Bm/pDFN6JDIVrQUYjB9liFGpR6YybIXnz8uR01XlfW+N7V8/cBCbdhTSJJYzfpq/WDsq/DJdkBbVMQmwo5B3ud5faPZhNJ4hnCtcqKqHORIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xc3IimZ8m9d4LWtQtBqeuTTrcMzyrIKbrCzb0cesszo=;
 b=Z2p2tW+RRGItm2zODSnxBxH1c9tlIAlB4pUlrwTekgqPdWmz7Gdbu7plWf9TLaKLJyL1I23OGYvVEWIFgvtdHngq5GrfC/oVPiygoFkbLLXvmQpQPwrd5afee5MtHb8E1BYiFVUIkxA6vp1Jho7Ld4QGvVjbq04LttksWRJ83vA6Xc+GNpJ89kbEPin7+uavD73PjxTsYaNXoyJIi+I4rxKYsN8wh9mlnl/aWCjLuQhaOGnbXJXyT6dbW1l7hNXt9+DJNHlISeG9j4BYD7nDZ+NEb2NbiM4BxaXMj9plde2tLYZzP7n5NBuL+lFCDyX4Zhy29BWSUID0079128qNww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xc3IimZ8m9d4LWtQtBqeuTTrcMzyrIKbrCzb0cesszo=;
 b=huuG7uGQVBzLw9cn5fADdGu+oVDw+pvwHPFQMkb6t9UKK0McSEmGu2jb8Ti7f54X0lgXXEYnCDM3jDX893qhEK48/c+aEOFcECT6LDA2hCi8HTrl1S/6wsNnmvFDh/e4P9FHW3I8qeF0GgVQFBtdGPgrmbSJkXYlpboft5CnpJY=
Received: from BN9PR03CA0646.namprd03.prod.outlook.com (2603:10b6:408:13b::21)
 by BY5PR10MB4163.namprd10.prod.outlook.com (2603:10b6:a03:20f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 10:07:44 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::84) by BN9PR03CA0646.outlook.office365.com
 (2603:10b6:408:13b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 10:07:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 10:07:42 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 23 Sep
 2026 05:07:03 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 23 Sep
 2026 05:07:03 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 23 Sep 2026 05:07:03 -0500
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [10.24.68.129])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68NA6tOF2700733;
 Wed, 23 Sep 2026 05:07:00 -0500
From: Aksh Garg <a-garg7@ti.com>
To: <trini@konsulko.com>, <casey.connolly@linaro.org>, <dlechner@baylibre.com>,
 <stefan.roese@mailbox.org>, <peng.fan@nxp.com>
CC: <u-boot@lists.u-boot-project.org>, <s-vadapalli@ti.com>,
 <danishanwar@ti.com>, <u-kumar1@ti.com>, <a-garg7@ti.com>
Subject: [PATCH 1/2] phy: cadence: Add optional auto-probe support
Date: Wed, 23 Sep 2026 15:36:53 +0530
Message-ID: <20260923100654.610596-2-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923100654.610596-1-a-garg7@ti.com>
References: <20260923100654.610596-1-a-garg7@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|BY5PR10MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: fbca7768-2bc0-4091-20ff-08df195a81bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gcDyr6p+rlsPCIxy+wHblFS/FxLedr3Cbk7covY23zsCOXVn0mcoHHNkAgS01YlG8trxV9Gtz2Sx9tt0BRndTP31seqvHlpsut1rooSpJoliP3KukMaAiFMUQAxCk65Cif2OzB2HtrWLiypygZ/8PZOUV3dsWBiANXcUPVDk5ZSySA9iI+SFmq0zhdhPLUkFK+P+VcNntjawQqB1gl73SnUo0BAAHEkBysKF1Op6W9xSFFMGkYyS0uTrmjJl6ZTFzEev67EcPVp4xOSsMw4VigNLMwBLP5ij9e+rMQQDJ4CTFSulvXukM1gjNS5UwNGg/X+eKJ/Kt0HtsHIAONsOWhEAhlzlc5ErfpwbJaWaw/Xy5L9QigGKiGBkm1RydEXsmb3GzsbMwVPHwgyi8+HqL+uZ2beDQ6cfTSAz+Js8yByLrAs/se/iRk7/jQyabqlnHBt+m1G7bs7IyJfMGklitUNOaXIsJSXdu1zT5ZtB2bi8AG5zYN+AgA573Jn0l4N9cN6HXR5tXEc36DdfzWUVlX0trLglbfSzXEa6R+col2WZ5Osp32FcBiZ/PryRDUlfk0uxMyMIFTRkGYMNlivHeN/FAc8T1myyGeA0/XsHqyL8YgjiiK3B1hgcj5Re5fPjOgZoI4xozlDbI+Vw3OVx0m2Rxj+7PH6lik/ODYEtmJzbNg87YGtYfKdk3cPySaKp
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7QN91LCHHInabRL2qSu3H3L2P28uzlxvdXBvsc80YVaD7og5Ft0CL6WM+Rmovur9FG9OfrttYh17Q+qGJ3/3uFZLxN1qN3kz4DBYjTUuocGKXlpIcT1WwfEZqTOECQPmQ3JT3yR9oniqdULjFXXhQ7y0eVnGZAEfAVbSdsgN/6LbvCZWeuahmOOVuTkDd0dkNDD57eyPL3n1OYS66qxBBhZXGe5hrxdl/JVtO43lT5mGhvosh1kqCMG27L+EMLgrERUIgjAZjfVLTXXiGBXJ2SnXoiUaKuFQ+J3pTL/Jqjf9kUACS4CFmTyDj+SsNlwJ/f91ncX4L+rNububVysn6yEhmiSfnIpefAF5TDQeOUm68GGbObd9gyzn0+4A9nNafbShKUs30h2BiA0M8F8Jwxil0jB7zpGUDltr3bSRIK/Fz9Tjkwghj2fp7cAjgBrb
X-Exchange-RoutingPolicyChecked: JQ8WvqSv/DqcgN73sve6+1GLcj3aLFx4NEyWaRgtKH8ynHmsTs3AzeJEFWUMxj+1gz17AzU06HyL9tReqwQbqPDywq90PkIDAoB0DubuZXmeBOsjzNV6I20tgbHklAo1deBAkA20NQKlY2qh2tI+oA3mNGOnOFwlKTv7/ZK0Vsh54mlDabrTAQlJn0zlfVkubPDKSmR1ukRsLWfiZ9mc9xOpVlSnS4JmW5AdG61AGlnPGLEDj3MpT0lmp7+Ic0dDWolKtd8gevuvIGVbemZY+h04frt3u+q0Fjiw96xM1SM+2ogSQHLS5VbvkzTj4Q+XBpxPC9m4KTU2bQHNiAEVew==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 10:07:42.3082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbca7768-2bc0-4091-20ff-08df195a81bc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4163
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0MCBTYWx0ZWRfX0W/3T/0a7n4A
 UsMXDLd08PeAQ2B1rsWqmvht37tSM0C/QBBuo3i6UuOiSlTp0bZvuM9BNPHgGM4aS36HvTekKhH
 H4cFnYmszo2t7ZpB6QACIuEgmJJSjdI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0MCBTYWx0ZWRfX6FD95u12waSl
 6/woUlINgrgCefm4rGgt+/6arSpqpo7bS474DFRB0f7UiqANC2/vAU1X0vFRAJgzCR/ekm2URWD
 PrCj36nxMhkavr4jRH/rmD2Kf0dOkFB2NqmhmRsNAhTX0Rmc+A1fOfRMHtrekTTSXOxyNwqPmSp
 fe6wY9rea70uCoRQy3hLzUyAvKCTzoWXdsEgIB4iJKvsBOvhfolhgKWpPj8fWHvP9vxZfLILgvr
 y72QgqriHhMD0PrezDkTOpXy/Wrcs9U3oeGeF3mYzgRFyyJzQpQCW6l+qkYXbd5e/H5IWudGHdV
 KBtSJ2edFDaCbA9JuTgFVn30ruiQ5MkP1inWl+akRY7KmNt4M65HXMDmX4Myw5HaP6KgWttF1mZ
 22/fgfWq8pItj7xsdTz+lZ7fLs9V6ycmJU5gCjcQNqvf+q8zf2JHanXohVOxdJtwvWEh1zgnrL5
 TcoL19+x5upzo5Pfsqg==
X-Proofpoint-ORIG-GUID: l6LZDSIIpf_NjOARBjWJaUoLPY3PWeyC
X-Authority-Analysis: v=2.4 cv=TpFzFzXh c=1 sm=1 tr=0 ts=6ab3a4f4 cx=c_pps
 a=bYEXqv4PBJnnT5HxTb2zpg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=sozttTNsAAAA:8 a=oGYVZFyWHRKlyDzYCvoA:9
X-Proofpoint-GUID: l6LZDSIIpf_NjOARBjWJaUoLPY3PWeyC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230040
X-Mailman-Approved-At: Wed, 23 Sep 2026 11:21:43 +0000
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

Add PHY_CADENCE_TORRENT_AUTO_PROBE configuration option to support
auto-probe of the Cadence Torrent PHY driver after binding. When enabled,
it sets DM_FLAG_PROBE_AFTER_BIND to ensure the Torrent PHY is probed
immediately after binding for the boards that require U-Boot to configure
the PHY unconditionally for use by the Operating System and other runtime
entities that boots later.

Signed-off-by: Aksh Garg <a-garg7@ti.com>
---
 drivers/phy/cadence/Kconfig               |  7 +++++++
 drivers/phy/cadence/phy-cadence-torrent.c | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
index 8c0ab80fbbc7..c7d418432558 100644
--- a/drivers/phy/cadence/Kconfig
+++ b/drivers/phy/cadence/Kconfig
@@ -10,6 +10,13 @@ config PHY_CADENCE_TORRENT
 	help
 	  Enable this to support the Cadence Torrent PHY driver
 
+config PHY_CADENCE_TORRENT_AUTO_PROBE
+	bool "Auto-probe Cadence Torrent PHY Driver after Binding"
+	depends on PHY_CADENCE_TORRENT
+	help
+	  Enable this to auto-probe the Cadence Torrent PHY driver
+	  after binding.
+
 config SPL_PHY_CADENCE_TORRENT
 	bool "Cadence Torrent PHY Driver"
 	depends on SPL_DM_RESET
diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 1f566d082f99..8228dad499ec 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -592,6 +592,19 @@ static int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_ph
 	return 0;
 }
 
+static int cdns_torrent_phy_bind(struct udevice *dev)
+{
+	/*
+	 * Make sure that the Cadence Torrent PHY driver gets probed
+	 * after binding, for the boards that require U-Boot to
+	 * configure the PHY unconditionally.
+	 */
+	if (IS_ENABLED(CONFIG_PHY_CADENCE_TORRENT_AUTO_PROBE))
+		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+
+	return 0;
+}
+
 static int cdns_torrent_phy_probe(struct udevice *dev)
 {
 	struct cdns_torrent_phy *cdns_phy = dev_get_priv(dev);
@@ -2491,6 +2504,7 @@ U_BOOT_DRIVER(torrent_phy_provider) = {
 	.id		= UCLASS_PHY,
 	.of_match	= cdns_torrent_id_table,
 	.probe		= cdns_torrent_phy_probe,
+	.bind		= cdns_torrent_phy_bind,
 	.remove		= cdns_torrent_phy_remove,
 	.ops		= &cdns_torrent_phy_ops,
 	.priv_auto	= sizeof(struct cdns_torrent_phy),
-- 
2.34.1

