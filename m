Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBF9606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 05:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ObCcB7Xt;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=kD0jzRLg;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=qY/dGHjC
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8682606AE;
	Mon, 16 Nov 2026 05:51:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fXQfUtmu41ji; Mon, 16 Nov 2026 05:50:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A48CA60611
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794808259;
	b=dFBmWfIjcy5yBClymv7lm04Fbyg5z1Y+BDucxkANfK1T9g+oDwbkFREHtwbIFHUi/npH
	 pa0JblLLNyeBKipN+X0kJWVM98kbe01ZGZpiE9n2YGdPiq53wIFr/zAN7pKfI74Jx5wo+
	 PmuAmxS1z8TXfthfGBbd1L9l+ZEm+vAWgVho/tClsBp/h65xHpkRJbbk1EbRDggSzinXN
	 G/zXOPFxNK18j3BUJMNIyephoV9VGhBCD9TUTf8oMInDjSZSmpHaglVAS3cYXu+b2++VK
	 iG96CuZ5kTcpsXn1C8qE0DTjDRafxQ++lGxNsHc6yzx0WVxblDjE1+X0yEZNUp6tsWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794808259;
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
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QHK/O/5ByFQM2veO8R28fxM1o8+BI+yPZ4SWCgL6vrE=;
	b=h5oBckAH3DbfbQQ7CAT9teu1X2QK3B3HDD/Zbl8ZSipFjzChwEw5FTZsIsmZsKuTWmPA
	 BiVh11M4LI+2/bXsLNjriVF+5RoQYpVVhq6iM1SncPbS1n9hA6wtMaWi5QCUa0DK33i4+
	 VjHCALBQ1ihroFB62Lan17yGFe5HxKXumOPyezTNDKFCZCbbvZcc9a7DF1otO1C3KAeVp
	 x+HW4BVNwUAAFzeVB+Qr0b4McfLS+TzzkffgD+Z4zL4cwnuFN3y9tBEm/MecYZinU67e6
	 WDGDcwBb6Cn6JYIr2gq1i1PeCIy6VQpzo7q++tH4+NHCvgyX5WttNyT6W8CEP+A1H4g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794808259;
	bh=QHK/O/5ByFQM2veO8R28fxM1o8+BI+yPZ4SWCgL6vrE=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ObCcB7XtzTEKi+ycTo1yjUQ4XQ9NjztosXcU8ENOflR1KFwhPsJ6k1og4Vy4G47s1
	 f2MZB+EpGHLiaZ+ZczKaMTYF21KPTv+GC0CmLEwDFpcJezc0/KHPzJlIJodLSbmph0
	 7J2NUfT9TtROcx72mmKt0caw5gpnP/bSUH4hkT2bvX24XaC6oLjLuaEDgERxS119Ve
	 0l84b0N3KhtPZXKaLXQyXWWIdECQX5dhUrqOtO6+brRqruPjRuWhiHKGe5H41xDkpg
	 P051I5d4vDnxU5kUrchsLy02PVTli8bxvoaXjOLbMX9SJop9rAO9kvBHMLvGSoOWPm
	 YAZQ4fGnKB1Fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A48CA60611;
	Mon, 16 Nov 2026 05:50:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D517428C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:50:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B27E880DE8
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:50:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6F96nleYLNNX for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 05:50:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B13A780DE5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=kD0jzRLg; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=qY/dGHjC
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B13A780DE5
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:50:55 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AG4QoOh711860; Sun, 15 Nov 2026 23:50:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=QHK/O/5ByFQM2
 veO8R28fxM1o8+BI+yPZ4SWCgL6vrE=; b=kD0jzRLglhkA0wbwQOXR9H8z9tKXC
 BZpicowkR35MBqk8VXSqPtkmuRRXcoriyMqLmVmKKRvMXmijz0r0VWzbIl8fHgLg
 zrPRNVxt1Ndd2zsUEZIuTZZ8mthqBGK4M66PFXTpd1xHGGuFBFFh8tmzdbc1/824
 jVgfDB0cQfKjl8igBw7zVq8nQ3h2Afrbd9qc+28ElEkaadvTSSsS+jSXSb9TMH91
 x6iXNrDjcvWjYz7cHt47dX/5XtB8WJUgX65T5XlkCDkpf70bUJj0glRNdXtk7kfn
 ynKT0UpUo9V3jJfwzfVF6eEArJBSWt/iBHbIND9S2ZuW/juqWmMey/U6Q==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hys3u8t6k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 15 Nov 2026 23:50:53 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHK/O/5ByFQM2veO8R28fxM1o8+BI+yPZ4SWCgL6vrE=;
 b=qY/dGHjCpAv2Al44qwiX0Ly4XMsrnbt3mzZfOnLxMOgJwTWcS3X2eff6NLcyWjRqlTzZyIDmSKcAahI7DFjr2K9of1UNtcVlVS0AM7nGe4sZQUcEjLDu5du4csDo3UbZUfvyM66aFe4OYinc4xogZPuKCxzkIcj0lHi/3/kWu5E=
Received: from MW3PR06CA0029.namprd06.prod.outlook.com (2603:10b6:303:2a::34)
 by PH7PR10MB6529.namprd10.prod.outlook.com (2603:10b6:510:200::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 05:50:51 +0000
Received: from MW1PEPF00018891.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::48) by MW3PR06CA0029.outlook.office365.com
 (2603:10b6:303:2a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 05:50:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MW1PEPF00018891.mail.protection.outlook.com (10.167.249.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 05:50:50 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 15 Nov
 2026 23:50:33 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 15 Nov
 2026 23:50:32 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sun, 15 Nov 2026 23:50:32 -0600
Received: from toolbx.dhcp.ti.com (uhda0492258.dhcp.ti.com [10.24.68.238])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AG5oTbl091724;
 Sun, 15 Nov 2026 23:50:30 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <neil.armstrong@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 0/7] Enable PCI functionality on AM654 at U-Boot proper
Date: Mon, 16 Nov 2026 11:20:00 +0530
Message-ID: <20261116055029.3493551-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00018891:EE_|PH7PR10MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 64104362-005f-4651-f3ac-08df43a591e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|56012099006|261026140227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 3Kz1RBK7el3XfU9bBmZcX3+05u5FkKEPzCWmipQSgCeSi8zWxotl7ajLVynit26bI9sm3SOAh5vNikth8FENIfczcffwVuD0EvYVudJsNBH4b1W6nPDqCNYBePcVMeAKyd7cOvyRVxCVYfwZcXkzYhJc/+vJCwp7uYd6tJ3QP8v0husZpDwpxY6k3mvuUP8iQMcmEtJjjji8+4I9end3hXDUJaTJ6Vlu1+ViIfmE94Puk1Ofw7DhxoKn36PT2Qkot9zheTsICtcTcpy6DbwUMAp71U3WC9qqSTRtEy6yzSS4CEh/3F0fnJqfqZzDU/6sFNIXk+U+Rbb/0JUr5oxplyt38ZwRPnN59+iDt4A89aTdxepGBaqRVr2QYQB/hMvpuLswR8KujITjug/pOKdPJ67lqm4StPWKapHhT/KLqHCrLhqZRHKLh52bnYsSyI/2dF2+lPKnr4KIAsh5lYlka9vqv4HGU3z66I9FduQLKLWtuzpYviyuCctoIwyhj6hfbLmc+CXGiJIhchjFE0qWCaAo9s0FMNui2WayUhz31URO+5bgyIaT5ahPypy6bkmlggka3BpbLyCPxcJuw9rvLGlTvv1Cdg7WCQAWmAQWq8CNgrnpTqrnxx0B3EuEas+MBq0RnuwgVz9MSXPs0r3PrJqd7nmZEk7rWDiq1M336xM=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cXR0xRMRLInTnzk7IWT+C8COECSSdHSh0vq9vjyDfgadiobFIiSc+iQMk4FbbkoQLdLZH/d1lkJ7eKXYnSfh4m7JF15ww+0g04fiakv06qA3kvPro7fYyyoIfgFaYQY2FX6eVIimz6QQBuC8T+m83Sw5yxHZa8mz0WteJ0Uk1wE/zHVaOHC/ksGKBcqwrrjxXooZy7z+62oyTvvrHTjzUmEX8DlQKR9YmEcsfrK9UJfLKJPudBOjSg3C2vL2ZFU72Td+zexfYc1YE8rcAQKhVaSSRhNd0xIMhCiDVikeevMUl1OQEKW8W7GsGYvh1IRQ04TfIJ0UgwxiRP9rDQfOCTkaEFbJfvbawvYEVqK03CbbBIAXQvbHIiKG7SU/Ne1jK+urWrw8jifRxgXg4yTqnbOjdv+RBWOKXz/zpEUc/gIkPDe6eAOQwxY6Ow09fxrn
X-Exchange-RoutingPolicyChecked: GoZtOiESSuAuqUFcv0aSwWBbF8lzHWZb/0cufQd5DDuOg7YXThOU3+7xDMxEWSlarUVDP3t+ZGMEeICz+Ntzo6Jto4+3g5Kktww6DUqQ9NSWSAD4CTnK/lxgderU7gPA47ScZAjNOOwFj0Cv+hY8Uq9b7c9D2dRaBjGJV2oQGVd2h2vjT7j9KrBNU8UmWtAP9H1w7V6d+JLZ/Btq15rkWR0JOS/u1fcwSQRSQMZx9hcDdqe3qw2GZFpMEbprLuR81+BobGaHDXcA8lyXjI03riik6dNKTNMIyRn2q1rtI5mYUqajGk3S5fWDp7ZYTJGPY62iT7yKMMCVKbKBvqlAhA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 05:50:50.5151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64104362-005f-4651-f3ac-08df43a591e8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00018891.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6529
X-Authority-Analysis: v=2.4 cv=etZKXYpX c=1 sm=1 tr=0 ts=6afa99bd cx=c_pps
 a=MDD208LlbW4bdEb8q+7A1g==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=KKAkSRfTAAAA:8 a=Elxs5dHThqak5dLQ6NsA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAyMyBTYWx0ZWRfX7xAjBzJCbFRo
 YBayroCjbS05ounxGh/L7N+P6Dw+uVd5I/lp53IZWTHTrKfBC2tVp1BdNnjSiVj3UGXcD19+kPG
 VdczNneImGP4KKaQ2cy1t4JTX1Hf8JOT0F0LiCDWBJv19ILkMLWlXhD1fvzcBjBhY++qrpnj4GT
 CjUwN6D8Htxc1qxCuBpgZdHebMIS1ZYsoQhukMIr6hg5JEv50ONmg3O2rk23lD4R8ZBODI9GJCw
 zOg88ATcfqE4TJV/0eRccZnJoinEN+rx7lHYQOyvKVK+A3k343QL7uSNzWbvFyPP0nMuqwf7+QN
 sJLKSMw6y20bu4ZBG9qltxm54JOBaoxnQZV9vSdNirhiYZLx6dA4U4xzDfJi2mvZBqVg1S0lmWb
 vxJW/AbOl7ra0hOjux5R9Zgr2KVC0aOAS5bfHjw2YsVCnjgGNPs5jNZ/jlV680VxCuoiiqXLdMj
 +JCIBbY/0k1IgkGphOg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAyMyBTYWx0ZWRfX0uWdFiGJlXo5
 ApAN/GIXaozsAMOs5LTvrh4lyyyc0n1FGVqF3QUyAcO9PJ/ItRuKlXFCM7j+HgqfTSKYrGf2lA6
 CTRPCLemU7fhJqTrwg0A0MKFWYfm5ic=
X-Proofpoint-ORIG-GUID: dYLHUzRz6hx0Cl7CT9VOaZ0GVpBBwUSP
X-Proofpoint-GUID: dYLHUzRz6hx0Cl7CT9VOaZ0GVpBBwUSP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160023
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

This series enables PCI Root-Complex functionality at U-Boot proper on
the AM654 SoC. Although this was apparently enabled in the past, it is
not functional as of now (without this series).

Series is based on commit
6487c50b8a4 .gitlab-ci.yml: remove Simon's lab from CI
of the main branch of U-Boot.

Series has been validated with the PCI x2 Lane + USB2.0 daughtercard
mounted on the AM654 Base Board. The PCI-Ethernet Adapter mounted on
the PCIe-Connector has been validated (enumeration + dhcp). Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/55a4d3889e389f211bc6f3def3af94de

v2 of this series is at:
https://lore.kernel.org/u-boot/20260908051741.868824-1-s-vadapalli@ti.com/
Changes since v2:
- Collected R-b tags from Neil Armstrong <neil.armstrong@linaro.org>
- Rebased series on latest main branch

v1 of this series is at:
https://lore.kernel.org/u-boot/20260904120604.3612484-1-s-vadapalli@ti.com/
Changes since v1:
- The polarity of the Reset GPIOs in patch 3/7 has been corrected.

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
2.56.0

