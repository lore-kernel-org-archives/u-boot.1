Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29590C98304
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 01:01:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8CEFD60B52;
	Thu, 24 Sep 2026 01:01:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t-ZZvhx-BCFI; Thu, 24 Sep 2026 01:01:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 613BA60B49
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790211669;
	b=K9+bmRYv/99s6Bi4HqkXUhlNiBGBupmXamhPJFYh8zBziCntSReAMpEknb7UOG5mbZG0
	 wq2MH3ZTa1oQpWJu6q8COm54pRWixGA91OW8g7TlKYrmt/cRFvDyCTwkkY9qShsnno8VV
	 INN+9YAwxwnUwkGs1puIC/m/R/MWQ1Dr25favfA8Bv4rt0+8RBuUeiRUnaFkBZDkXHawX
	 GCEW+jtc0D9i7dehjdF6vXPmXxrrMBkl65RgaTW7JIvWrNt235jGDzEfzT2VU69yFE9Pu
	 8H6h1+3SuBA2CNOOPejTtkCfOKcjne2XrsdpgQ6y+F2B4tUn5+4kspjTbWYLhNke5sg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790211669;
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
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/rS4KfyOF0ucxc3IhE4IOAY/bD0gP7aAp/s5u8K0c2s=;
	b=CHzgLn7nvy+t+dLvcv7FCTpgCrc2FKzLdSXyMO7CfE50DGTddsZDW5UiMElEVAx276/i
	 enhf7cHZGwebQVUt2LOnmEOERkR9IfNhVQLLMiuckrXPMbQ8lBPysWXgxCrt7fMiahP1A
	 LwFJGGYXonzOHo+ddqARRsX3qJdvmufdeL9iJP5CA41n40cvzHVEbd1wW4OvaM373Ys9G
	 P8Bd0y8QjjUUQgUDGjYi1fPc+8aoXTB4CIE/MakFz70m2UUVv/1alNhyMHONG6b+oyGr7
	 nTV5iz520LeufeqD0uO+e5sEgD6d4wpb9560cT3G+ss4Wl+TfWhszl/2sRthD+WjTug==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790211669;
	bh=/rS4KfyOF0ucxc3IhE4IOAY/bD0gP7aAp/s5u8K0c2s=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cQXguMEibAAyawa292stiB/zaf9SlALdY5IreTxAOZRyhU7f3733MqElWyL0utycQ
	 wWn/1ApgCOVDiKrlfpfJlEz2sV48QUtjrvXuHYLg5Nl9Z7LmnYSyR8TZYQ6VA2dx5+
	 P9o75xOdJXezJ0WZgGIirh1QV+/qBaoOxKIYn23UMw+hZF9+L3lY5tfMpjiju+eD09
	 eThJHkLwwfeImVRcK8B53iYCgykod+3guCZybo5kwSRQWIp2hnJHOsjkZQuAK20Wup
	 36WZ2dIXu6HqdqkU0mGgIwSNAzbrGHLkBfKgYLT+k2KlQw8cTFegD+8vk7Z6pGP0Op
	 8r2qbsdJ83bUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 613BA60B49;
	Thu, 24 Sep 2026 01:01:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BAE2D2F5
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 01:01:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A42EF40122
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 01:01:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5fKHTdRO5wld for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 01:01:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D76E7400AE
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790211666;
 b=Y6LGhSnL7GKuRLs1g7t9dnlHWtSKGc5cqrsSaWw87WX/jDYm17zC4wB9fnJV/4zZjS8d
 P57NX3/GYKrXbkTrbuUui/0+D1H+QJ5fleV+Dwdny4qqFbqmgwUfqX8GmMv+RLaXzhcoi
 mY+zQIDCxjdocuhJZJdqQXhPhkjjzX0ajsUGDeTazhwEs5/DL+qs2l2afELM5jbzH8S9E
 XV+Ebszr6dBeVgm3mxk00HwP/vnUXKs7C8OXXxk1exG4uGP8XtEOJM9RQIS9lRWliSfxj
 A3bxT+BveDQ2xGo8ZNWY+hPr7U3sYA+hFUNFkHtA57zcYx2GS02GuE8N3fIpx1Th4Ng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790211666;
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=/rS4KfyOF0ucxc3IhE4IOAY/bD0gP7aAp/s5u8K0c2s=;
 b=gBW/CcSalMh0nfmPBWXdOyHaSqjWopO3Rm2Mpf+tNwKwGrQF5+NWQjQp4DPKuD42dF4F
 xbvItLYuXpmiRlVSWKFdolZ4d4TXnHEgqEKesVw/8hSrcSWYcvP9fn5SRqR7r+mqTI9kc
 MXVQWcdDJRozwGWjUxohXPo9VVEL+uaJMDtbH1+nzHN23GgKSBmML7ibTzr/fVJiJyDmR
 b02H8eWC0Yg66tf+PPzNNLob/B0MwTd3uMBdv9Vtp03Akdn8zUAXLxnVna7pRMgrk634I
 I4Eg685flSVUJ6ItBX2zP+EPFyBKuuFJeyVttBR6l9/YJoKNBbGmKTENVrALxvvZZsg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=JdyGqxRY; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=K2+uMkh3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=JdyGqxRY; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=K2+uMkh3
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D76E7400AE
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 01:01:05 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68NNGYVr3276603;
 Wed, 23 Sep 2026 20:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=/rS4KfyOF0ucxc3IhE4IOAY/bD0gP7aAp/s5u8K0c
 2s=; b=JdyGqxRYrK/56BzjqmpiCLSWHo9yQUAgLMDtd7pP5Mea5ptuUvik58jYQ
 pIs4c/FzuE1C0JvB9HXH5Xcrg8qrwzaDzCoBADg9lbXmC8uoGkbyJTS9lNuofwIc
 SimLjmTS8oy6vAlWj/n/jShrC7hNXH2v1mc+zy9p+Lh6AT/HTe4rWvksVpoMrMwt
 r+Sn7Ys5jeSO2/QcHL5wp9vRJre2xdd0SQ0+bAtAFQJBMqWdf77JpEK7xQdNm+hi
 mXJQLBd6gtwAITAv3t5blV4iY5Wt4EPfzw/apB9G3bXrd/9rrMQr6e1ZGg62H0cG
 qXCOI3+UL6E6zZI+JMyjZyzS8JW1w==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gvq6s0qge-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 20:00:59 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsQNNuJk5uvRiXWLG02ROX1cRU8gdQwyme6AX7jcdrYbxegFV29jjWmFuNa56xqWcx6RUmzzYuuTmkQcqz1yhaxG1+nQ7ncGUaw0KdaoCLmeR9csb9B3/2iLptlsIOKxiK1K8NebBzMJNDL95A2NXvc9kJO90o3WAcKRbN9t9TvKcCCXlDfrkqR+BmNyz7j5zlIc4kqq42VEpQqgfYQHhZkt9D0+974UHHuRP1YtOao8P3OD3D04/HT/fh5lLnz5jig3dc6d1V74MkibzGbKRvsjjJ8qjHuvw8Tjxk3pqQ0ADu8BIzkHwHuecz316FY2TS+cnQgiPNaq8HLqxDSesA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rS4KfyOF0ucxc3IhE4IOAY/bD0gP7aAp/s5u8K0c2s=;
 b=VIhGC9qtsDCtays80O7eQzDxyVXa5/DKR6brVdgZFfYkWD/harKdrRGXjUpRfV5yJwccZ88O0k+DW6C5hNJ1fJjntbMCwaYPaq1EVXh1XSzSX6rE7jJDVxQlCDIeha9Q+AG1FLZBZyURYPTN6cCr1i/f+o3yfhtF7FMToxgBquL980IvEA2DjEWYuRoJP8/moB3i9rzYAiXlvvPsk3qsN2Jz4b40HPdTXlz+i/ymU3Jx3myL7wQ1kSeiZ9Z7RwXmkkdCxM+x7DimamgnK04Lm8MTYoqMFiK8dSRMTdTZVDAuVP9vt8fLX6h85mTv9PkIsTqTpOPPKJirQfev70VRuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rS4KfyOF0ucxc3IhE4IOAY/bD0gP7aAp/s5u8K0c2s=;
 b=K2+uMkh3Fy+QrdLTKb6j3Ig7Y9nUnLUZ3CBykyRwkwtUFVZPNJUXHKhNWNKEpFfcYsA6GbACwVJX5cJK3u6rOpYIgH1YL3RwKXqtl0H6Z3X4FgW+yHn9CcEfZ2beWUFq1dmzJB3D3Z1Cku1UAOxJ3/UtXYsZOBKgZp7DI6veLvo=
Received: from BN0PR02CA0014.namprd02.prod.outlook.com (2603:10b6:408:e4::19)
 by CO1PR10MB4674.namprd10.prod.outlook.com (2603:10b6:303:9c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Thu, 24 Sep
 2026 01:00:54 +0000
Received: from BN3PEPF00022BCA.namprd03.prod.outlook.com
 (2603:10b6:408:e4:cafe::52) by BN0PR02CA0014.outlook.office365.com
 (2603:10b6:408:e4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Thu,
 24 Sep 2026 01:00:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN3PEPF00022BCA.mail.protection.outlook.com (10.167.248.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 01:00:53 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 23 Sep
 2026 20:00:24 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 23 Sep
 2026 20:00:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 23 Sep 2026 20:00:24 -0500
Received: from [10.249.135.178] ([10.249.135.178])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68O10K0B3094024;
 Wed, 23 Sep 2026 20:00:21 -0500
Message-ID: <82208a4f-b91b-4415-8173-1272189e372d@ti.com>
Date: Thu, 24 Sep 2026 06:30:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: mach-k3: am625: Wait for TIFS initialization
To: Markus Schneider-Pargmann <msp@baylibre.com>,
 <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Daniel Schultz <d.schultz@phytec.de>,
 "Richard Genoud" <richard.genoud@bootlin.com>, <u-kumar1@ti.com>
References: <20260923-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v1-1-300ddb9f5be8@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260923-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v1-1-300ddb9f5be8@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCA:EE_|CO1PR10MB4674:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a35f717-ee4f-44d4-2a7a-08df19d74869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|10067099003|56012099006|6133799003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: RKWi3LsW+qJalv0BliXPuHRoSEdIVbwrnASNhPC1tV14MjKtbiESETk4B9xgfRlxvvaqsRPTNP+LwiLiglIbNv66EDDcmUhAuUFT0t3BM2Aa9fkT8AkS1RzBrZ7iMm0I8bPmYLClqetX//NNEfwZ7cYROJJZq2H2nhOezwgaC4gZGWW90OFvlZ/9K2bcN6m7xD7cjAJsHQuXQ1o9jAWY2pOft4nN6rh0kE8PpMkH6+w0TvMS9FVZWiGaFrd4KNEvDxUjZpHrsJ9JCWryOvLOzmzP2L66rpr0BU6zfXGVQxHQum+7cQeAP7ohc8uI0EyQBaplkU87hVrdenBeAdyZ8oPtz6/yqcbk3URZ+ft8Q2cIZo3CmwxhlZkr7uXNg4hLSjCTWqCbAK/jMtWJq8oL5ydVXtf9rbE554TvkjXBHBrSBMBPj1Wi0zjSEPN4FnlIYkW7UJt4CbD92EraZsT7hdTlomnN56K6NB1Z1UZhSt6DYNJoXo5swLr9e2lzS5n9yFOahVjvvWU1I+T6ta40H3HomPeYMy5YJbPS/vROmdVf5YhbTJojLCbmb1W8lsFRHEwR7W3GeUYTtAz2yAP6IzXMDGCRtcYgJWoOIvCzKr7LvFX+jrPzO/tr0dbhC+4GenaY3jsSfFmerONYWr0aJxzRcBOxNXFyq+KLCTtuJ8ciuFU2LiS6Ua1Y2kgUd39nKj7CVqdEwlAgHBcp1h5/7w==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mcZNOtNDUH2MmfzPj4GqnV4+RLn0BNclAsxYi4E5fr5uhnYq0kz7CU3byjNAveuKX5s0ft7zf3mrZM9hxX3OD1MtXkJTZGifH1r1xYdt5B70Q0CdoViGH5eZVtNx4sXl/ZO2Tcfcl7lbKPsbkd6KbZPJamTp3EyaxtHbGrpk2BNYuIYzAx0SILVzdByoL9pZguvct24JUTb69Xj9CRfaHRA0kLf4o+X1hBjuxk+9a7sm96xabWgidW70kQeXALoTlDDHMGJFZOYn1l7sR0I1q72By5y3TEXSbLzmlQzDZIfI065RVfWyCNzGXePc2XlAe9H/fFKFg45NR3sUK5f6DAkWxuEBm6tjWu5aqc1lohZutSX7hCRofg1EtLimNzudwVtfcgSBddXgEuHk90rYFLk8EpYdVgHwMgkw0gmzYyRplbkCAJOsLt2kZUaZ49J9
X-Exchange-RoutingPolicyChecked: EfHuBYQV43NowJrNh0fCD2Ee0Z+XAfLU9O179bmFzsPexEPkvyknAW5hdbDLbPK+MnGGdBHFhtny7Yt2aHERRM4uq98OXYka/rGr0/RZzXgHkhTa1IcVAlwpDiu7ZEP1iHSni+53OE+789Am9hE5of4RPnBjAvY0hTuF3HFkHsOG+36kkcgduaOZXylk5aL3pOYCg0u+Ewd7Ex9Q7sBBoNZCouH4LarmELsxqbt90utayyna+20pea0QabICTVarCMn7ZIK4eNpHbe+MUbgW24LykrxCLL34eig8dULQe3oNIUG2q7TkaxjJh8qxZDI2tD4qY9KUqHPsyV2UVFG4qA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 01:00:53.2270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a35f717-ee4f-44d4-2a7a-08df19d74869
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BCA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4674
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAwNSBTYWx0ZWRfX1Z1noEhV6ld4
 jMlQEr/YI6DVjD2F3Yf9Ow1CW+Q6NdBrRT4DzuRlveyvbkAVMoVUsxis0w9FiwLhtEyXIXzo0TB
 50lCEkDGeMaQ0aA/2rBvkfZ9WEqStZY=
X-Authority-Analysis: v=2.4 cv=IMSXmQvG c=1 sm=1 tr=0 ts=6ab4764b cx=c_pps
 a=8jXpZF9zWVkTg+MA9bOgkg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=IpJZQVW2AAAA:8 a=ripRgEKvai3jDDPSRPMA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAwNSBTYWx0ZWRfXxHIw/dFiOv6e
 UdQU7YFJcfzeQ2eYldR2SWJnU1/5J/RS+0t3MjdfW+TqyIEpMvDBEnkg0WvlU4rNBOb5BN50S4P
 4kSq0tfB92Jv2kJeAOCZGlgGyRU9HVR/0dBmj4qqmEuBP8XQ3vpfeEACbdfXIpGj6cmc8mF8GAP
 K+2sOix7h9+4HigLs13kLkUvJII0BQeqqAPh7SmHC+6xhsnmbNb0W4RXfpCDVhZsi09zkXk0JaS
 EAToTuk53GzPiZlPqc7BHik870tzc87c8Qmz6MrvC2H/LfN+GEnhAY/gzh9Qw3Be4vPuDUNQ/lS
 Sj7FXlCVdXesZX5F6P49w4JrUCebTddWGH1b9mrfqHNbLGvYa3UQWDvYzTssTkDF03G7zbJKYTy
 ymnIMSY63dRizz5IXHM+aRJ6I6T9SXIUol/HdxFHeOnRWhBJm4L1isg9+emYrrnK+wK7tfvkd/Z
 d0LSQExDHx1ClBZoLIQ==
X-Proofpoint-GUID: j79OiWq6idfj0wmn7hxIVigYv75IdZXU
X-Proofpoint-ORIG-GUID: j79OiWq6idfj0wmn7hxIVigYv75IdZXU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_08,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240005
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

Thanks Markus,

On 9/24/2026 12:40 AM, Markus Schneider-Pargmann wrote:
> On HS-SE platforms TIFS takes longer to initialize. TIFS only removes
> the firewall on the registers at the end of initialization. On HS-SE the
> u-boot ctrl_mmr_unlock() can happen before TIFS removed the firewall
> leading to a race condition. This leads to a broken watchdog since the
> signal configuration doesn't succeed because the write doesn't take
> effect.
> 
> Add a get_ti_sci_handle() call before ctrl_mmr_unlock().
> get_ti_sci_handle() leads to fetching the TIFS version which only comes
> back after TIFS initialization is done. If a response is not received
> get_ti_sci_handle() returns after a timeout and continues as it would
> have done without this patch. get_ti_sci_handle() has to happen after
> spl_early_init() as it requires DM to be setup.
> 
> Link: https://lore.kernel.org/u-boot/20250815160240.3575140-1-d.schultz@phytec.de/
> Link: https://lore.kernel.org/u-boot/20260225051559.416445-1-u-kumar1@ti.com/

Here tom advice to include all platforms

https://lore.kernel.org/u-boot/20260226143756.GC1593142@bill-the-cat/

> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  arch/arm/mach-k3/am62x/am625_init.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> [..]
