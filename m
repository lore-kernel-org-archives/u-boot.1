Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6776EC982EE
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 12:06:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 036BB80C1A;
	Mon, 21 Sep 2026 12:06:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vk2jlHrL59eh; Mon, 21 Sep 2026 12:06:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4EB8380C3F
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789992377;
	b=FZbmZ7TfYl2HhIg9AgfvxV9/an55i7cgebX9z0mDirZnV76H5UNLcSofGAnORYZWrpXk
	 lBHq1W6ldrnxn5hSBF7ZQN4Hc30AZRUS7nuT+Ni6NyaGQTGbTRcfDbYtsRPMLcesoz2YI
	 O3FKfWEZDlzSWk146WNSNTcLA2VUxVjVBLRptNRX5LNNVRZthjxhAvSm07j6q9kFkaPwp
	 1Nrrn4B6yk1DIP0kbOfgvFa4YfLfm/pibi82s0OvA/RYh1B0QRlxXn8YTQ0Asvg2Q3DS0
	 vg2jWMTbRysjBS4l85HrPo04LZN+AwJXKDqPU/Fh7BvEQvAuNZi46ilhQHk2P6WPMkw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789992377;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pRgpz/RTKo6yTvHfchciByaPlDdGxgnXyuh3xrkprOM=;
	b=Lxv/495v6uPRTxYJkfL9k4IzX4eQMMQglgYQVz1GYtHxruHLRBcJl40Nhfyofyb6jMl6
	 OORknXtH246/+Q5d4MbDcAmaviRxgOVgVmz7/mAj/RBUPN7+8LWrFKyawrnluOkOX0Rnl
	 kjVWTN++BFOALRaaHHF5euilQDBvrUCgmfvaDTGGLWB45Ph8XhcZAGKx0SX+KnkPOe5L7
	 jP5bhMAtF2rwm7IoGeRD+0jqcOiJwpW28py6YCGkZ1pcrsULW0GCmqjhfhmcQUsdPaUIp
	 c5G5FAJnzwaY3bU+KMHtXzlfOm7IpzMni7BPUTUwGdSVLOSroBaatidUhDPkOzVkobg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=BjPqhnFO;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789992377;
	bh=pRgpz/RTKo6yTvHfchciByaPlDdGxgnXyuh3xrkprOM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RzQoq/awHpQbkAc5iEpAaBmrbjWZq1Cb2u1mUfGCYpGjyzT58qqrb5fgneKBqbmQu
	 Reeq2govE4AE5G5h+k6Oz56Ip/vywO3jvFO6pSLQcEMjgIWUfmrDX/dieuyP62MhSI
	 nZno4nT3YUm1Y+GlqR9jG1qoyfMDYwa0GZ5er6TFHXchSLDCrlwZwVXJfdfAgsTjmG
	 MQhyV3cHzbnAZzDkUGEZC56PFZzxQz3Xm/ueGSTZysHKt35IybxTJxVoxHKWvwJjAB
	 mQNnBEWVUwQr7HOzsc1BvqQbbMY/SE0f0XRd6uIeACkxdYhSciEICxiw1M2WB26yw4
	 2KUx1GAGkBtvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4EB8380C3F;
	Mon, 21 Sep 2026 12:06:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 67D81237
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 12:06:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 593C080C3F
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 12:06:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nw8X_k97ys1L for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 12:06:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 79B9480C1A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789992375;
 b=jDIyAoemvwz6K0TF+XyaWNVcmJ+B77Pa5RFyomCJqdLs93u7PWSF6COeTG61JQGVdsO6
 R3Ww8tRnSrZYlAlLypBvZgGH8EfjUpDsxgPmq+OeaT/84NfA/XoJf+bRQ2MM2zJhNie+V
 8QJu9Tofwh5rAIYnWhCr1520qdMgzlU1qKCbVEBr9mbFXDf10eoWxjvLII32BFWAAB+Ca
 tDFp/YNST/KwKwd5T8BU/jX9pHds+yseSBAiAn98lXfsMYDHTpboOPBXMEjp/PAEfYSye
 rSaEzMPSgN0oX9TG6w2cQ2QqeFU4spOBvXN0w0cxBnv2D3gLtOgjD96+FYQD5vGZoiQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789992375;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
 References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
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
 bh=pRgpz/RTKo6yTvHfchciByaPlDdGxgnXyuh3xrkprOM=;
 b=A3UBDXqZ0qc+6ZGlykFVkwQOVidJsW636iDEVrJZF/vFoINJaGhZ0Xy1776MG3e5/V4q
 8l2ES6uHik3cyeH4JACC2iLRTZdjo1WQvjFW2jSj7M+qNKLGPzWYuYiIY3tvEW/YqzDb5
 eDrLMtA2sPNrU9CWMwQUuHNwo/Z0yLi/u1SGWpzRuD8Ib/g/GoGs51sJwXd2WEdedbEtA
 GnTX/GDr+GYY1MD7xTdDp32fXU2cY5UosMpSQ9HVVWetN3syhBtOXX1aIAxupXarwYqiF
 TShRtm7dUuIEm0rQm0rvVBAE694qosVZa8lFI5Eils1aULQP4JXsTYNjNBX8cU9i7qQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=BjPqhnFO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=BjPqhnFO
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 79B9480C1A
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 12:06:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Og1qmZwFn+QpQzeNDrhJ5j8F/gGJeG3hjUtVa+auqQLpqudQpKoPNANtIASzKhpaUMm4o26ReKmQB/Xc7GxHx3D/UJms4vLf7Ij0xOZ5sfUt8qqquMWR8/2+ilVfa+MNGqYbyNQBR1ZY1tbXzQ5YnglZdGmSpruSjHosu7XdmkXxx3X/GUjFtOXX1kTSM8reFq2m6+mw8iNEW1v0/D9aA+pajyLjYAZo+pg6ZJVW65k54xA/MQ0NJShg0WMS5K7YwdQSMQHzV/2Ac9BXbsBnV1vtgkBxxEDti9JGobMlB8wjCr114UoOX2btOheshlyEL4Bji6Qf14hBoXVzQMQ8ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRgpz/RTKo6yTvHfchciByaPlDdGxgnXyuh3xrkprOM=;
 b=yxt2GmiLXx6d1sjnZwY8Nm7MCSiVoic5kePDmrQNW2VEOb2jy0XbLy/gcim/utPabaXmFV+neiS3mUoHMR7SZ3oScAohEH++1F2HrghvWenCXJfPgc/L05NCBMuLBWqAyLSMko2Xpl4IrVxi2p6qKB5UQ9s14VAti473VPpV/noyRbHG4N7a4n3PHp0VTTlo7Bv2ZDXSFLt/OAjf94mxkWDh1NWdJP3oQx0/SOhwdhEnixHko7vM3AJF/xzlq71FCxSmH2JlTAuci+7ntHZs6ofhyADCpxJz7Oc43lmIZjwimZ70PzFvS5nUrFzsmxvXdgbZkokgYylOs68dhI3KaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRgpz/RTKo6yTvHfchciByaPlDdGxgnXyuh3xrkprOM=;
 b=BjPqhnFOdIFrrv4BiEylSfveM/UKPxG5d01UXcJUuy2R7YUVf9uoLX7HO2wQPnuJcSJcCzOYEOaZ7AT8miWQGM9BUv4irHknWoURPlTlytMj+xN2zN+00cmEmRVVofe7Tk6M+R8MYhMUaYGwnKyhncM1UzzpnOCWWgAg50yObwV06ENvLAJLCnyhBSgN4AdH0d91cAkb4/HSGTx8srzsCtMWlwNizgH1E3PhDCrQIXgHenUZ3XUUM6/7OvSgEPFGXINrpw7cJ/sMAfXRMCC+7HadpPSI1kD9hKLYMXNA4v8Y+Vv69e4/z36zqTr00gTtcYLktz7niXAOOkIo9jCdjg==
Received: from ZR2P278CA0063.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:52::7) by
 PAVPR10MB7332.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.13; Mon, 21 Sep 2026 12:06:09 +0000
Received: from ZR1PEPF0000E6B4.eurprd05.prod.outlook.com
 (2603:10a6:910:52:cafe::68) by ZR2P278CA0063.outlook.office365.com
 (2603:10a6:910:52::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 12:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 ZR1PEPF0000E6B4.mail.protection.outlook.com (10.167.241.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 12:06:08 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 21 Sep
 2026 14:11:56 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 21 Sep
 2026 14:06:07 +0200
Message-ID: <b3c8cb9a-96f7-4a43-85b7-1600f02f9b23@foss.st.com>
Date: Mon, 21 Sep 2026 14:06:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ARM: dts: Add bootph-all in ltdc node for
 stm32mp257f-dk-u-boot
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
References: <20260904-upstream_fixes_for_v2026-10-v1-0-f8b96c35004d@foss.st.com>
 <20260904-upstream_fixes_for_v2026-10-v1-1-f8b96c35004d@foss.st.com>
 <0f2b58cb-3467-4f11-9621-5fda4e5d2d5e@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <0f2b58cb-3467-4f11-9621-5fda4e5d2d5e@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6B4:EE_|PAVPR10MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: e614abff-983f-4a81-2078-08df17d8b89f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|18002099003|10067099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: konyks9vnK5tzZswOnfKFA62yBr1DNK9BR80xNMoVjq5WXCS5nYXRyLbUn/jhLsM/byabMz0F2aYKsaOv59ZdZou6/GHDc2g7SZ5NXaQxFfUuke3UvQC5yr9FvGKElofM+L60BfXw/ScmBFEOyCKo80Xm42Amh3STu0jVCUGqlycvHY2eEOrxMna/GEBZCvQVGXutNv0zf1UCrDhwUOMg/BvdR0u4Ox1JZw+8+J92HUvoXYmNVR6uelcO/hnf22FFDk6nJ3BcAv0vhbfSDnEf6KnbNaJQ+rctn1EwGuB8Xt+fAHTXCSBRlKHmYZgMBym+qR6SEryFaDlDQD7ju3962riNRiYDnSNS4lq/Bow54XEwKauOPp44EEjMkckoFNNZB4etJw5o+bWRsAX7b4/hndZzvJ8azdDR6+QiqSDEgzud1jptYF1t7sYOguxMF59u/1nxwUXuNTVCOqMDWcOgZWmS8JJiwEI3eYJi5CNIeDL3zVwOcdQfy6f8kh8rPVs8MfBKGGq/wCOdY0KlzEr2tPboynl0njVtyyhXFWm/BcRFoT5wSTZDDvb7lTAafDrev9O7SZr27xvlg63kUdO6ZExsH4EDId6+KSfHa6V+QhdOP2ZMeS0k6CbEXi2WUOgucvLcNHJEGm+mzXERdJDLLASUFgzQqkU7ttupC6Ocl2FY7d/bkOcYfPAwa0o1tXFk4YButq04KqBWI0mO4aOEw==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(18002099003)(10067099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U/VnFoj4/JKZzjsFM+lkVuFJSo94DwkNKCZ9Vqa2dVi3E9yWA6LtjT95oo1wMD600qgnUZr3ZdsX7foCtSlwchi0Z3nQst21PKOXRKrq2/V1Bgb4wayMJgXxdDTkM6oJyugCCpsxei0hYCKTTlE3dmDr5JNgzruHlu1so83Eg52tTC+LZLg0k021FJrblwcUQ6dS8vEqeZnu+MskeFHeb7w8aCW2TqBq59wEs0z6bBSyeN98ovQgsQsiCdLlaYZa21hBvKtQGBMlOJ9QtXnT6b/B1zHb8wQuSToWKQNAi7DGY1QvlUxK11Fm9701GWxilUySxzeMGkusPmXA3nc1kCmAve9ZUDXARwrktA8WGMC2H/iafcx6xu5qYR/4E0fU2YSGVK6n7497Q/BUQKohFfN131KFgluFfa3MafCdtb9PkhPLavpGLa6PEjOmNyYM
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 12:06:08.7035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e614abff-983f-4a81-2078-08df17d8b89f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6B4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7332
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



On 9/17/26 11:37, Patrick DELAUNAY wrote:
> Hi,
> 
> On 9/4/26 12:09, Patrice Chotard wrote:
>> Add bootph-all property in ltdc node to fix the following issue:
>>
>> ...
>> Video device 'display-controller@48010000' cannot allocate frame buffer memory - ensure the device is set up before relocation
>> stm32_rifsc bus@42080000: display-controller@48010000 failed to bind on bus (-28)
>> stm32_rifsc bus@42080000: Some child failed to bind (-28)
>> initcall_run_r(): initcall initr_dm() failed
>>
>> Fixes: d0a838bdc629 ("Subtree merge tag 'v7.1-dts' of dts repo [1] into dts/upstream")
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>   arch/arm/dts/stm32mp257f-dk-u-boot.dtsi | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/dts/stm32mp257f-dk-u-boot.dtsi b/arch/arm/dts/stm32mp257f-dk-u-boot.dtsi
>> index fe3fe9c5166..29039f6f860 100644
>> --- a/arch/arm/dts/stm32mp257f-dk-u-boot.dtsi
>> +++ b/arch/arm/dts/stm32mp257f-dk-u-boot.dtsi
>> @@ -11,6 +11,10 @@
>>       };
>>   };
>>   +&ltdc {
>> +    bootph-all;
>> +};
>> +
>>   &usart2 {
>>       bootph-all;
>>   };
>>
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
> 
Applied to u-boot-stm32/main

Thanks
Patrice
