Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47AA5C79F99
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 05:14:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65502403F9;
	Tue,  8 Sep 2026 05:14:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RNrJgxETVcAB; Tue,  8 Sep 2026 05:14:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6857940311
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788844476;
	b=SL0tOP/BzV+/ky/Y7HZZoPUlVPrztFHqPyIA1jmJpeRFlvSowU2rwTmc4G+grIT1KoPW
	 fb/Cup3xHH7anyOmdRFJZEFKgcLpWXGYs2HgbRvM//AxBTQnrFEqyLU9FrKx2Cr2OCd0t
	 1hYsj6+A9f37TogStj0cZ5wdQsJStvQqjxonJFUJIqTvO5lIRCxSo2XmlxgK7FRCiMjoz
	 1hmNHcNnd3mhzsgRaFRX4R5WLXVl2yqW5HdEH1qcNUvL6OOHyE+x/a6o1mcF/7etr5fQz
	 tmU/EWxBqIu6eBbw2Xet55Cx2w/gP+Y92s1z/ml83pvd8YGd6a1lYzQ12X5iG2LTMPA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788844476;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wIhshE5NMMi6bmPzV9E6do6So73foZ00dvYf9evfraY=;
	b=O1gamL+MFe/3DlJkeQVDKWIJjq+iI/pUq9VHxOn5KLnBFlRW2IFHq73sWoUDAl44Fvmd
	 W+wHWuOkp3MkJKlYN4LWDye3gYClXigDG2ldza4PzIXlSubx99dA/LkqscgNR8j1NMqsG
	 cYTri4ZDvFZ0uTySdaU1/rL6t9D5le6SEM4rr4T/OnyqGaQ2Inwv4qnvgdXJPNqX2cXwB
	 oTii/DvTaMl3jY8d+eeb9v62sXDrptQVOHgPGfkE0ibb36oIJMXV1joMGooNmDVPtaPIo
	 pfhxUft8HFmsI9zqqbTlpHSevuYnFuxbxftc1j4AnMxgzGZMq2V7a7qCADSJgMammbw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788844476;
	bh=wIhshE5NMMi6bmPzV9E6do6So73foZ00dvYf9evfraY=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gP7ZEEa5KOiuAsXlSa9PTEIGami1s/IW4NhQGVRsoEj+4Oy5OJT9UfdEXEMHshyLf
	 QyeTxICHb9W/whXov8Bnzn/w9nHf2oh7NGOnlnhOZjjbok7fx+c3idcYT++cogbgCu
	 /uiBvU9HlO4vhchsPqVcuxGRZErZ1Ib+WCjmcbtq63jvtmD1OCZvNRXU/KHURdbMOr
	 YWKl9mcRtr+Z+KzBCJ64M+2w+DBYxJ3iTnN2T7sDmKmuX73DW/IwngNvDoZWI4muQJ
	 EuL1VYdtsiTMMZaUr4f4rjq/8M/ngirXm3oINHMYcDqDVKmXS8U29xFTyTGFEt3FxT
	 Elfay5yB8z56A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6857940311;
	Tue,  8 Sep 2026 05:14:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DAD3970
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 05:14:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 03D3C80815
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 05:14:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rxSA37-b45Zx for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 05:14:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A026080807
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788844474;
 b=S6JHPyEEjA3RoLyEf8rMYN228kXRU6qom097YWsIANYlpyOiZBvGQbHvDAePfNuXzX2m
 etgQAYHR6cBOnkcbzaqTGsCnh3pHp9Vx3JsAoQisixarg4TyWirq4w9NnQu3os/ufa01f
 u9kdm4z8KR9W19OWE95g8yrbzBdVjMcYXMLLifmUAys7NEygGGQ+exy0TdYcv5y5nIRlp
 4CuBfbmXfddKpO4sTyrmJaeq7boCxbu+9Ig+tzpFNrLLRWrvZc9tW8e380lBP71MDxQaN
 wpqmQeio2XoIO0zkROZI1SOoCKgrIDB7jvY7myRtj/Kq76U+TIwyCINzMHtNnqj1eXA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788844474;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=wIhshE5NMMi6bmPzV9E6do6So73foZ00dvYf9evfraY=;
 b=b2iBpr5on7bcrIL5eKPdtgpqTOt32WzyeII3qS2PnL+AMbL4vTGqJJeW30gLM/bXhkjr
 UeuBMzfAKjhdTFg9mi3/Sb4/cSJktai8oR1u5Qn8Ute5gHg/ZYeVadmoNgkg52DhFqYt5
 e2GFhXJUZ0lLFkjmFrN10MP99Ailb8itOOOxst3Hqlti9Ex+ir/cNoNJclo57Pso8gS7Z
 BwH9T/bVbIj+NRlf8ekMEg1CzZzsWPRLHt0rTv8nyVeQSuTayy1ffgi3gMgxHLteWU3hO
 WoyQd1qlP7tYgfPLigeNE+Yl4cBjaRJ2bh+DuyQ5uWjUZYtYv7bHMfX2JbU7BDW94jQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=bLQjZymt; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=gcfzXwtJ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=bLQjZymt; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=gcfzXwtJ
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A026080807
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 05:14:33 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6881sD8F329347; Tue, 8 Sep 2026 00:14:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=wIhshE5NMMi6b
 mPzV9E6do6So73foZ00dvYf9evfraY=; b=bLQjZymtOR0mse7dMlVoLg2QYW2bM
 BHjiS826Rl6BKNgjY9HfLweZCxvd9pTFpbxKjpFMAxMaRp8PL9+vaPaQn1KeqrSw
 FAYzBtYlrWW+WZrjnbpJky6oc9Xpa649+1BZeR4lIBdkZoJBjAfT7GFmlTtIGofI
 mtoH+u/WZgcXaeXmZIVjhzePJo969V4Vd2t9G2dsA+r3KAe+2I/XsSRfBsM7eFmy
 J+gT+xXXBs/WDOqIRxB2mHmiucbDfT4TXeXHBTF4FV2aSyAlmVUw5diTpzzb2Vdy
 fwqi8PdtSyvcKSnz3j1StJhTchAqHv8tmpFMDbbN8I1wRypXTjMt/U9MQ==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012018.outbound.protection.outlook.com [52.101.53.18])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gj940gsmk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 00:14:30 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDT6mgpSMAXC+4PfOjfvmnQCy9F4LY2/h7DQ1Za0xvC3sjahmqJpr+kDAAsRO+IIhSq39IhRLEp5C7AbIbu+oeuXq7bFGJAnMAK7qK6+HRftNsCaznoKPgNaYcVqab1Ph4Z4fpCcHEnLxk7XA0T1rAe8RxsNo9ANk8yzvkMsa3Uuuf52GTLxRqxUnj/+LBBaPAvuNZlP9bud01qNIo55LDr7/qcXWCJ5+zcxf1Xq/gNRquibLgY4JEEgZmSpAUuLunWNdVbd0K9ZF77wOHp6g9V77xeTAA4khPy7QzB/h9hDfUN0RlITqQKK8vTUWAAAIbq+xQBnYT9JpwVQPrTqSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIhshE5NMMi6bmPzV9E6do6So73foZ00dvYf9evfraY=;
 b=l/2Ziy+yY13ucr+W5lF4GABGB67X2tX/mt9dTHiU99ZIiHuC6dfbwncvEKEZsVlLY3CBEuEWg1AY0K+qSX0asK5XjK3s/1d7pAjHtZuDN+bVZ7ONwJqyiTrJpdLcCafilweJWE9N+5QorNNFMXnVbQKUu+mFxN+EVkdfFSUvq9Oqt7n5Gw0Ien3x+Rc63RZGBJoSit+s+CfW0P9zE0vOaFhdobUx+anPbRBGBjVy1ivJgl6TlEoBptv4khZz3vcRXXOIdA4/X8uXBsLzqv3jH9RID1J3Usks/p0zwugM3bFBGAJcxxmC/n3g1aKs90KoKgsHmYunyZPyWRbqtDtRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIhshE5NMMi6bmPzV9E6do6So73foZ00dvYf9evfraY=;
 b=gcfzXwtJnolW7/6okGJY6utD1HvteE543ccVcCokrGjORaffAfxO3dRr+Rh0Vt6qnPnjYJjS6/4zWDLty1hP5P1d2v7VOiXKWPC4BQS2rFDEHFySoov4/GcYKuBbg6pa5/fLlAaqru1e1ztRvUJvnYTCjQ2tQkywN+7BCH2hIIo=
Received: from SJ0PR03CA0177.namprd03.prod.outlook.com (2603:10b6:a03:338::32)
 by PH3PPFEDB06D67A.namprd10.prod.outlook.com (2603:10b6:518:1::7d6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 05:14:26 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::80) by SJ0PR03CA0177.outlook.office365.com
 (2603:10b6:a03:338::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 05:14:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 05:14:26 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 00:14:01 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 00:14:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 8 Sep 2026 00:14:01 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6885Dwd42811953;
 Tue, 8 Sep 2026 00:13:59 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <neil.armstrong@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 0/7] Enable PCI functionality on AM654 at U-Boot proper
Date: Tue, 8 Sep 2026 10:47:25 +0530
Message-ID: <20260908051741.868824-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|PH3PPFEDB06D67A:EE_
X-MS-Office365-Filtering-Correlation-Id: b8dfc88e-bc5b-4fc5-fdbf-08df0d680d63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|10067099003|56012099006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: T4rcaMd7VlF5CBJs2HvkTLrb2Bwz2Rv1F/1gizImFnJQn/togPVucxOP6tOVvVfGInx2fJdz4Q9QU8aCqR368m1Xmm8dnofsdYocfuHaim7eLvM2/KdZiT4GCXTSj22CNMLylJTyhvBxw3TYXTg5wOsgjgJl8tV0jJIZ+wOf/EQ9tIZY4I6OmtdnjbJ89mxvoMH+T83bpbGUSP2QQx6W4Zai8dHvwuLILe0mf72kQWQRKwyvm22UfPuiPEnoSFwEuco6Taez44uNXvHodeQTaby2vyTZvQLhlLN086R8h8pz3ShYOMyW9MyMPmCB3x9uY3FljMXdDEJq0ZBIazP108u4Nz4ZcaUbmHzsQ4RaTr3faLynj5SE45y46FKavtmHQ4+EnVko0mpUKaGeQlrGtLD0+BK+ISPTD4IXW4bNU77yOosgLBRe9gRYee9ymCTunhk/yeEM1joXE7wtdiw6HVKJjKyaVJjCW25n1PgiTXE4szpw+kyhLymeMjfi8FjP5wJf+1H+JPIbsk65TK11Ernai+uAPnDWkrF+UDDZQU3yrX1f2dKq8KOi/JrnqrQ7WutEuvZZwG7TW4DEF8yLZWz16UJbEOKeqaoG/tP9qVGjF4OPt/mP27f16O/pslHoLSAQ6cEFLAggQSRubuMN6L9qJiEDZdrhfbUVGdC1a1d2BuYapnak/ZfjqJGBUQK4qFFKWW/4cc22WoFx4feklw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7xQQU+0q0mPxGHgLUsnwkxzL4C+G080ROZBCoahLVtYmH0rarZL+R5MhqHxfgNLU5IDiJgQkBorfXHDb/QjS/9ijWu515lwN0ZannJJ1CdaY6uSik3OYewG5UC/hu3rERKEgyZmTNCjpC83DRAmffZpj9WNEDkBR74FyFKePO6Ji6hN+NcB6ie1zQqhUc8mJXDyth6r6+1Q3iYoi402GyGPZKhZ7Hj81i5bZ3NwM/UM+N5IoOGF+u2omDIxivUY3Xy2em8C4D089A4NMcnhfguBqCcWVtKJcTkrnHIq0SrJcjcccDxGExE+9ztaJ3V3XyxMN60YBAkHRMCZ99XqBn8YETEqJ/Ep82jEfrI1O78lkik7CH2ZmjXFttpqmvyWxcENQx5rWp56HvnCMZrttVwhrc59twOHqqk4yW/+HxvLEgunL0RqrspOitw1lSfwg
X-Exchange-RoutingPolicyChecked: YOzteLvY76rrCoJtBBrEqXVjcbOxspx0z1gZJMqsTxMRxWChEaubdaTIzMncxBtZzAtljPk32p9idhYwxIkuutFqEYeubtgmn8YN4365so8yrOA93g+GYRK4euThdStUOga3eEppl+YZqI5mg9cNKw+djPx8Cgfi34apA30hcyT8opCX8T6ZJq9VaBrGZMLd17cbE91S7w9KAiDkk6INnbYDA3on5C9dCeQ7DCUp7PEQd7rOlBu6oBdjyo0T73XsQLYo1n4wZUoDeXV2Hk9QYvIFCpboVvFzC6QLC5VfZMP+T5cN96ejcp+JpPeGxRWGNFpYRkGZf5pSclipX/cK4w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 05:14:26.0961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8dfc88e-bc5b-4fc5-fdbf-08df0d680d63
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFEDB06D67A
X-Proofpoint-ORIG-GUID: S84ClurYv-yAW3JEfbVAJaNzNj4nWzNe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA1NSBTYWx0ZWRfX5goDbzXLVwBC
 AQwnVzWFx8DZWvCB46yI9Z1khITnsg4Z9lgoX9jFCW6Dm+y287PyPaoGbOFdSMTjZtOtJR/V49z
 mFQni5oFp5cH+mjtybCTy8w4M3tjclBEXNgtMWBIZahfn8sOj7ufm02uHGelyyrk8/6tAp/IEeu
 IhEXavPnhCXmpF1Ow06EsbUmg16hpMpgVfnvglStLaT1Bnz0qUdvJkh6hZLBy4f5tpuZkjYjefx
 R+SssOo/ptOSo+jT/5HZz0wPhLUgyUrAdC7P8kdFAhoHePDAIIHdks7VmaEHTRXOdrhh13M+0cR
 BSAKIaUvFOPWnKzRR69QG85ObLr+3GGGw8uu/nB8lXdJMY0uerBcg5WKbbzXLfjTx/hd6ZorSJj
 ltVyfoE4zCQbtmzdPsL+DqICg0yhZgjfMHXhHAse6OeeoGAkfmDtESTCxJc38AkZv/73AyEKn2w
 JVoCAte971cC0SwuOJw==
X-Authority-Analysis: v=2.4 cv=UrNT8ewB c=1 sm=1 tr=0 ts=6a9f99b6 cx=c_pps
 a=eZ5Ua+8tQ3RPWrQJUiaIvA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8
 a=Elxs5dHThqak5dLQ6NsA:9
X-Proofpoint-GUID: S84ClurYv-yAW3JEfbVAJaNzNj4nWzNe
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA1NSBTYWx0ZWRfX+Bm/9rLmRDQm
 61iG6pQk2UZb6RBEZdKrhhflgLpPcjgZKqFp3e2kkdwMMdLvQb1068yCLUBwg+ctpIz8Uag1ZuZ
 MpYSA4NuJ1Fd68oyRWhjSkpfMyiPNtY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_07,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080055
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

Hello,

This series enables PCI Root-Complex functionality at U-Boot proper on
the AM654 SoC. Although this was apparently enabled in the past, it is
not functional as of now (without this series).

Series is based on commit
b4ac71db13a Prepare v2026.10-rc4
of the main branch of U-Boot.

v1 of this series is at:
https://lore.kernel.org/u-boot/20260904120604.3612484-1-s-vadapalli@ti.com/
Changes since v1:
- The polarity of the Reset GPIOs in patch 3/7 has been corrected.

Series has been validated with the PCI x2 Lane + USB2.0 daughtercard
mounted on the AM654 Base Board. Both PCI-Ethernet Adapter and PCI-WiFi
Adapter have been tested. Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/3f005c5ff6c00dbd7890aba860757551

Regards,
Siddharth.

Siddharth Vadapalli (7):
  phy: ti: phy-ti-am654: fix logic for programming clock parent
  pci: pcie_dw_ti: fetch num-lanes from the device-tree and use it
  pci: pcie_dw_ti: fetch reset-gpios from the device-tree and use it
  board: ti: am65x: evm: add support for SPL to update U-Boot
    device-tree
  arm: dts: k3-am65x-binman: package overlay for PCI-USB2 daughtercard
  arm: dts: k3-am654: add bootph-all to gpio@38 for daughtercard
    detection
  configs: am65x_evm_a53_defconfig: enable support for PCI-USB2
    daughtercard

 arch/arm/dts/k3-am654-base-board-u-boot.dtsi |  4 +-
 arch/arm/dts/k3-am65x-binman.dtsi            | 35 ++++++++-
 board/ti/am65x/evm.c                         | 76 ++++++++++++++++++--
 configs/am65x_evm_a53_defconfig              |  6 +-
 drivers/pci/pcie_dw_ti.c                     | 27 +++++++
 drivers/phy/phy-ti-am654.c                   | 12 +++-
 6 files changed, 146 insertions(+), 14 deletions(-)

-- 
2.51.1

