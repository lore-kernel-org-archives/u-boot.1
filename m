Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C941DC55182
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 00:10:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 946BF606E8;
	Tue,  4 Aug 2026 00:10:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CleR9zAxxe0J; Tue,  4 Aug 2026 00:10:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA8BF606D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785802228;
	bh=IT187WMPqhbi1csNnxFl8I0uH0xdT95Tl0foBhGyXxY=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CDPhuPEF6t8oYfl2i5AzczpUWzgESSawCJmc8N/k6eSyZQSVEk6QOAi5ul3NQZz8D
	 LI0fW/qYBZESsF//DjEq186feTz1O2vpf5c84+Smp7+w9aInFHZ3U57Wq1Oslscn0L
	 oWouBVmssnQ40o3uU9AbcjM113Xk14btF3O0fIPk5QLzTV7+S6qU6VeWomNZBZJ/uG
	 skFo9lsZIjU+nx7NH+InYqe/rK8zRyPjyCkuMcONvERQef1i+/B8rRsrnIojsG5u4a
	 1v731JGBeysG220J54bJCN52xpSWAhhU+sojAMS7pm9GubMSYrewJD6Zla6cmdy0Fg
	 2ii1/IgdAIbYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA8BF606D6;
	Tue,  4 Aug 2026 00:10:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D0C5198
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4441180C2D
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qN_JygzQW1DM for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 00:10:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A91BE80BE9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A91BE80BE9
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A91BE80BE9
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:25 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 673Jj3Ac1687976;
 Mon, 3 Aug 2026 19:10:19 -0500
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011040.outbound.protection.outlook.com [52.101.57.40])
 by m0384305.ppops.net (PPS) with ESMTPS id 4ftt70dpsc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 19:10:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7Aq2z98mwWw3JG4WwoYLsJh49EgbVE+Em1Cb7rJrqMVmYHhL60nTQ+YETdOaWm5tqp+zWmfDbu84LzFf1y8gf4rcmIOZAykMpgwuHro28amOxAMBbsJ1fY0aWVAxjqVCmXm5QdJfDKGknb4/wu0qnXPTSJ5EBLAbrxC+rBcxL3PNIssALziIcdUc4JAeUmjmSGAiTDFSdYksJYSsuxQtNNkJP146GYyTPRRwT0mkmR2aAR8b3bupGwyKDgFgwsZAmTBhVds81SZihxgiEUofFWifyu8vjLkf+LuLe5jfkd5vviZYi/cn/L4PD1agd9eqpPka0WQYOJw1IXFO7uTpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IT187WMPqhbi1csNnxFl8I0uH0xdT95Tl0foBhGyXxY=;
 b=oXiTaAX7gBjgAXadxC5Ea8gvgvNFBVvUtvjwj43sc5AshvJ2cgc1t+epZTup7V62jm1jR27KivmYZl8l7kEcaJ+G1vwl0sJwrKsP/5WYa2NrvB2KlxDMBxJPj/9q13zgrVFX0ZHmv0vHsxUvIVFMwfDA3DreplHx4LumI7G98W1Lu6o2wkcKPJH2R60cALVr458pM56OZaSMgxvaBriga+q6ORh2w5PnAwzKJWZy7LuSD4w6KUOT/4RPa1f/oVKQiw/HIBfqkktObRdBN5nCk08tnBb+AZZ7d9zgCx8glqc5d2lyojVvMuW0bv/3nDkvJ85w98XDlglOliYvFosgNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
Received: from CH3P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::8)
 by PH0PR10MB4421.namprd10.prod.outlook.com (2603:10b6:510:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 00:10:13 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::9b) by CH3P221CA0016.outlook.office365.com
 (2603:10b6:610:1e7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 00:10:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 00:10:11 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 19:09:50 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 19:09:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 3 Aug 2026 19:09:49 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67409nIu2655378;
 Mon, 3 Aug 2026 19:09:49 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 3 Aug 2026 19:09:30 -0500
Subject: [PATCH v3 05/11] arm: mach-k3: Add initial am62lx SoC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260803-am62lx-v3-5-b4f4302b09b4@ti.com>
References: <20260803-am62lx-v3-0-b4f4302b09b4@ti.com>
In-Reply-To: <20260803-am62lx-v3-0-b4f4302b09b4@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Anshul Dalal <anshuld@ti.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, "Bryan
 Brattlof" <bb@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Aristo Chen" <aristo.chen@canonical.com>,
 Udit Kumar <u-kumar1@ti.com>, Andrew Davis <afd@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Paresh Bhagat
 <p-bhagat@ti.com>, Swamil Jain <s-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Chintan Vankar <c-vankar@ti.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=31865; i=bb@ti.com;
 h=from:subject:message-id; bh=0bRHUxAIzIlN7C3xozDq7L7aMuFpzmc/XumZFbkmlzY=;
 b=owNCWmg5MUFZJlNZL+56kwAAbH////bv+u93bVr52667f/T32/bv77/DbX6vZinb5/t0/t2wA
 RtlI5ANANMgAANADRoDQAAPSGgGgDTEADRpkAyaBpk0aGRppgmjIGYkNoaiHqMmgGgNNAaGQ0ya
 GIAMg0aaAaMIDQGJ6hk8oGQGBANAAaNADIBiNPUZA5D0mRkwIZGgDIAMEYhoNADQAAyGjExBiBg
 I0ANGmg0aNBoYjQADJoAAcIewWwqcAVQnbiHEjifW9LRtdMRF0JHipJjrju8iPBdQM7n93wqJsv
 VtTYngBQhUWylxNbJuLZfGYCo0RrnLLRBLWfUwOfDQdycqUNerei0+LdMeKdbK5YFmitgedfNpU
 0OQIroSmQBGDShEyP5xtiqEpaQEJiWYJPEQZVnkTdSTmOa+B3Fr2YOlWlERKB7aZD5LeyNKYBJO
 sYI1QwCALM04B5c0rkevHK0AqtQZa9/nWJGDUdfEtcMXFhMg2vymqlO1TsCnuhESCi+wC7IMzjY
 Sa3RLl19N28CpfpcC1vxTVteTgJw65Zwz+3dVWqcU+w4k5NkwnGKhL8vg4X/QwX3HAFxYHqF6D4
 01/BhNhuP++pUyQDHkiLV2sEFG2nx6AD8xwHMybkSLdpTohzuulQs+6hXYvHesrLpQdgAQNkk3G
 n+LuSKcKEgX9z1JgA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|PH0PR10MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: 385690b5-d1ad-4a18-8a67-08def1bcc081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|7416014|1800799024|13003099007|6133799003|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zcyYYMxrrOK9FN0JUsL/Mg+fYG9gF50afjYBSVwKzWhdQNXquo1wWVbb9hgtL5SFyQ9KhCvCqYkNBfzECR+uJCuglXpLD2gGAvr/56aF6+teASYX5xet462Um9PlT1DnqQPr2/cgsGAe0xeBYLixFw7GyLtNwjVYUtNspC/4iTG2rWoCauTDjrLM+ceEsw/g5XTw57Vb3kjjjsxnZ/DEKEaJT937tZBxhrBqErKyozE3WwKjbJXdKxOiDGdZ2F/LyHZlntuK5E7W99MjgAJk4EXQOtsDOnoqTN5ybDunDVseiTUMMfJV1VXdumUoRnyDCNmOFzz8Ew2wxvaYQOSOkiY5/qdU29hdwUDNNX4yU83OWy8g3kDTRnYMa46SgAp/J2tJCV71QNZmo+3/9oXj9vCvMYuLRfJbaZ0RoU+Gpv/jWAhUTwRaRyXTDBZhT3a16kyPfpZjvfv374bk9+LeH0DQJg1C+nEf1+bSkHRRDYRpvBWCC1kHFKCOpSYNvVF7++/oaVfV4+BtFuIIS/lGTkyAJ10xoScsEvYu+yaoCryGOdsYnGSVRnjceku4A9I5CRM/4Qe9ob5hd7c14xY8zITFJwdbWK6ujw1GfXHgOaKmVXVKM3zSOVZlUt/9Z5WYf+G2zN89WGeQVqtbNzchiQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(7416014)(1800799024)(13003099007)(6133799003)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Wvmec0K2qGVALCiuvxZYMi5OYpbGtygL2erlJigMjcafQv88Oqdo4Ra1neD5PQByNbaYVCdYqRLCgUuXOuNgQoj98JL0xCwSkDKhMvNRuleWCAJKEds7ssT/6dgGdBzTCNxyNj7K6yfrjfFhFJEPL+cixHdnR0ikKcmVeoS7vUYqfvHyn2/R+cwYpAAvgzCor+LHvnvylIRZNX359Y5ELcgaI7jALptQoWN1hlRAM7J3ypOzBj9ZWIMetgeN4GCezRnyUsxVV9BK2xvIOPTAlR7tvS8CKsTYhsJUZiT5uu5wST7m86uL06lfuuWcGh4nY8SRUZXYooSuD4c132COKe41Fh9EHm/fWysur4TMZ/rHPrONtYplBOTvGc+bOYAMewRpyvp54qzzbAPjsay46MB5gBK/m3z/p8qyjnW1dr59jlMnMlBxpBAtflzho/Mz
X-Exchange-RoutingPolicyChecked: kqDVqW41QVVkk004UdzfJeEjbsmVyQaVM10+Dq3kZyOvY12VTWrGEXv6xm+EbvLRdrVx67ahHNMIVn6JiIGLV8/o4+7RiNnLNpQ+JmqRrmmYyvpakp4IImL4oLnXS+rjIQQUeamFVDncLBSJWkQ3w+hD3JukeoK1Y/ablvVdGCnwGLr15USoox/l0yZeTHQ9pOSKqRSmRA+BUe3TQjUXQQtREmpK16bEVhsL8KS4pJtBm3OLFYePN8DI/CQf6fqBVXl73jMd6738IStG6pqXLMPmQKgC714E8RjYc7NEFUmVDVdBYq0bfOK8twEL6mkI1c7G0AHjbIP9P3GryHnK5Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 00:10:11.8003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 385690b5-d1ad-4a18-8a67-08def1bcc081
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4421
X-Proofpoint-ORIG-GUID: GZforIOoxgIDJ41n2NjjunRugQU9C9RY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDIxMSBTYWx0ZWRfX5bhYIR+dolc2
 lSYSlxaG9MH24LBaFS5TSSlWUkaMcJP5UIgS0mImQz+8WK6algbyTSsi6JImtjHPAiTHAIbWJhc
 o2nuhwBK7Qb+0rORcUsxqG45vxjcjlaMEn1GFS0SlOxl3KuuS8dYyK/CeNuepZrQpHkhGdL79Gs
 XLr8EF6E+nx6jPg9DWhqIayzWnStOOgWY0N4LSCqgd7KJ8Bmz2nd9Ypb1XVRk7yFYBonGBRh3n9
 q60j90uP2pAEYFc59c/mn4lhnHx50I8WqVCJhb1ZX+lUA6q3Du831ASZpXfESeOKyiliQISFceQ
 Sg02J2r1OODxMdyAyVFX+uL/2StO1itNjr3D70rNhQfYyltrxRQA8zyZkUMCelx6j+UCNXmCxAU
 Yqxmt9L9Eb/lws2tbiEaD0XfYrn08lBK20caxm/bxckqhTdD5cb33srWgYMHRGuTLe80K6vfehZ
 3bIH9o6Eu7FxPjmN1yw==
X-Authority-Analysis: v=2.4 cv=MbdcfZ/f c=1 sm=1 tr=0 ts=6a712deb cx=c_pps
 a=MmUQU4Mtsiu6HzSWf2FVsg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=GtdckPxdew9VLt8R6-AA:9 a=b3e5HEXp5eT-sR4R:21 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDIxMSBTYWx0ZWRfX78PlEPmxPTdH
 jHBiTZH8LDX8DUlB1NOlYVckw6jJ+HO/dbPpAaeEX85D9kNVeKzE8n2KAx1KicFRfhsF1pXNayF
 eW3W9sVmrwvddZ6cEuQI+ixHGLGDHfc=
X-Proofpoint-GUID: GZforIOoxgIDJ41n2NjjunRugQU9C9RY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_05,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030211
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=IT187WMPqhbi1csNnxFl8I0uH0xdT95Tl0foBhGyX
 xY=; b=EWPNT7DZ8sWwbcfcTskXaqUhVi+qsGdph+qgRUG/TxV85Av9LzQf8IBD2
 fW1681BVGnvnvkx7Fj9FOsrBCp15F6KCX9cymmIcDcw2BwDvoJEc+KANKFUuo8k5
 EhDiBSvyoXFzy0OVBj1BH326bYLwoTlYveJ4lzSgjxCOPvRKs4CUPJVtchTiCAxQ
 fO9bc6DO8NLfVv0agjVphSmGo0/NbNM6W8uw+947czWLXeCy6kaekvNSvt+kSHXr
 yg1SVXb5NGK57LaCbKepyGXk4cUA0f0jvm1tq5kjPFlstcEvid3XR1/KyiZCoXCu
 G4vBRYabwwmoetFODETRbmfr2tuGQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IT187WMPqhbi1csNnxFl8I0uH0xdT95Tl0foBhGyXxY=;
 b=B2QOqRQNwYSCteWVcq/PQNBgAN9KuElfXyRxoJVWj0+GmKiRufsB5mBm2YsRxgR0e79X46c4DvJGcNDXNaesLAdAogAK0xBvBVIDGNSKY0kSTivwTeckAw6pAFEOFTZT3J84vBjuQvlv4+eoqKN+TMGTDUQ4M6hOVc74nOJgBWs=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=EWPNT7DZ; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=B2QOqRQN
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add initial mach-k3 files needed to support boards based on the AM62L
family of SoCs

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes in v3:
- Added TI Copyright
- Link to v2: https://lore.kernel.org/r/20260721-am62lx-v2-0-33ff580c267d@ti.com

Changes in v2:
- Coalesced boot parameter table Kconfig address
- Link to v1: https://lore.kernel.org/r/20260717-am62lx-v1-0-b9830633afb8@ti.com
---
 arch/arm/mach-k3/Kconfig                       |  17 +-
 arch/arm/mach-k3/Makefile                      |   2 +
 arch/arm/mach-k3/am62lx/Kconfig                |  23 ++
 arch/arm/mach-k3/am62lx/Makefile               |   7 +
 arch/arm/mach-k3/am62lx/am62l3_fdt.c           |  12 +
 arch/arm/mach-k3/am62lx/am62l3_init.c          |  58 ++++
 arch/arm/mach-k3/am62lx/boot.c                 |  83 +++++
 arch/arm/mach-k3/am62lx/schema.yaml            | 427 +++++++++++++++++++++++++
 arch/arm/mach-k3/include/mach/am62l_hardware.h |  48 +++
 arch/arm/mach-k3/include/mach/am62l_spl.h      |  41 +++
 arch/arm/mach-k3/include/mach/hardware.h       |   4 +
 arch/arm/mach-k3/include/mach/spl.h            |   4 +
 include/configs/am62l3_evm.h                   |  14 +
 13 files changed, 736 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index a32ed3a9683f..8249fc97bc93 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -10,6 +10,15 @@ config SOC_K3_AM625
 config SOC_K3_AM62A7
 	bool "TI's K3 based AM62A7 SoC Family Support"
 
+config SOC_K3_AM62L3
+	bool "TI's K3 based AM62L3 SoC Family Support"
+	select CLK_SCMI
+	select SPL_CLK_SCMI
+	select SCMI_FIRMWARE
+	select SCMI_POWER_DOMAIN
+	select SPL_SCMI_POWER_DOMAIN
+	select SYSRESET_PSCI
+
 config SOC_K3_AM62P5
 	bool "TI's K3 based AM62P5 SoC Family Support"
 
@@ -81,11 +90,9 @@ config SYS_K3_BOOT_PARAM_TABLE_INDEX
 	default 0x41cffbfc if SOC_K3_J721E || SOC_K3_J7200
 	default 0x41cfdbfc if SOC_K3_J721S2 || SOC_K3_J784S4
 	default 0x701bebfc if SOC_K3_AM642
-	default 0x43c3f290 if SOC_K3_AM625
+	default 0x43c3f290 if SOC_K3_AM625 || SOC_K3_AM62L3 || SOC_K3_AM62P5 || SOC_K3_J722S
 	default 0x43c3f290 if SOC_K3_AM62A7 && CPU_V7R
 	default 0x7000f290 if SOC_K3_AM62A7 && ARM64
-	default 0x43c4f290 if SOC_K3_AM62P5
-	default 0x43c7f290 if SOC_K3_J722S
 	help
 	  Address at which ROM stores the value which determines if SPL
 	  is booted up by primary boot media or secondary boot media.
@@ -124,7 +131,7 @@ config K3_EARLY_CONS_IDX
 
 config K3_ATF_LOAD_ADDR
 	hex "Load address of ATF image"
-	default 0x80000000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5 || SOC_K3_J722S)
+	default 0x80000000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5 || SOC_K3_J722S || SOC_K3_AM62L3)
 	default 0x70000000
 	help
 	  The load address for the ATF image. This value is used to build the
@@ -133,6 +140,7 @@ config K3_ATF_LOAD_ADDR
 config K3_ATF_RESERVED_SIZE
 	hex "Reserved memory size for ATF"
 	default 0x80000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5 || SOC_K3_J722S)
+	default 0x200000 if SOC_K3_AM62L3
 	default 0x20000
 	help
 	  The runtime memory size reserved for ATF. This value is used to fixup the
@@ -206,6 +214,7 @@ source "arch/arm/mach-k3/am65x/Kconfig"
 source "arch/arm/mach-k3/am64x/Kconfig"
 source "arch/arm/mach-k3/am62x/Kconfig"
 source "arch/arm/mach-k3/am62ax/Kconfig"
+source "arch/arm/mach-k3/am62lx/Kconfig"
 source "arch/arm/mach-k3/am62px/Kconfig"
 source "arch/arm/mach-k3/j721e/Kconfig"
 source "arch/arm/mach-k3/j7200/Kconfig"
diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
index b2fd5810b67c..66ae20143b6f 100644
--- a/arch/arm/mach-k3/Makefile
+++ b/arch/arm/mach-k3/Makefile
@@ -6,9 +6,11 @@
 obj-$(CONFIG_ARM64) += arm64/
 obj-$(CONFIG_CPU_V7R) += r5/
 obj-$(CONFIG_OF_LIBFDT) += common_fdt.o
+
 obj-y += common.o security.o k3-ddr.o
 obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
 obj-$(CONFIG_SOC_K3_AM62P5) += am62px/
+obj-$(CONFIG_SOC_K3_AM62L3) += am62lx/
 obj-$(CONFIG_SOC_K3_AM625) += am62x/
 obj-$(CONFIG_SOC_K3_AM642) += am64x/
 obj-$(CONFIG_SOC_K3_AM654) += am65x/
diff --git a/arch/arm/mach-k3/am62lx/Kconfig b/arch/arm/mach-k3/am62lx/Kconfig
new file mode 100644
index 000000000000..d9609a91993a
--- /dev/null
+++ b/arch/arm/mach-k3/am62lx/Kconfig
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+
+if SOC_K3_AM62L3
+
+choice
+	prompt "TI K3 AM62Lx based boards"
+	optional
+
+config TARGET_AM62L3_EVM
+	bool "TI K3 based AM62L5 EVM"
+	select ARM64
+	select BINMAN
+	select OF_UPSTREAM
+	select OF_SYSTEM_SETUP
+
+endchoice
+
+source "board/ti/am62lx/Kconfig"
+
+endif
diff --git a/arch/arm/mach-k3/am62lx/Makefile b/arch/arm/mach-k3/am62lx/Makefile
new file mode 100644
index 000000000000..c97ffe27492f
--- /dev/null
+++ b/arch/arm/mach-k3/am62lx/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+obj-$(CONFIG_OF_SYSTEM_SETUP) += am62l3_fdt.o
+obj-$(CONFIG_SPL_BUILD) += am62l3_init.o
+obj-y += boot.o
diff --git a/arch/arm/mach-k3/am62lx/am62l3_fdt.c b/arch/arm/mach-k3/am62lx/am62l3_fdt.c
new file mode 100644
index 000000000000..da8c2d18ba86
--- /dev/null
+++ b/arch/arm/mach-k3/am62lx/am62l3_fdt.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <asm/arch/k3-common-fdt.h>
+#include <fdt_support.h>
+
+int ft_system_setup(void *blob, struct bd_info *bd)
+{
+	return fdt_fixup_reserved(blob);
+}
diff --git a/arch/arm/mach-k3/am62lx/am62l3_init.c b/arch/arm/mach-k3/am62lx/am62l3_init.c
new file mode 100644
index 000000000000..ee2a50f808d0
--- /dev/null
+++ b/arch/arm/mach-k3/am62lx/am62l3_init.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AM62Lx: SoC specific initialization
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <asm/arch/hardware.h>
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/uclass-internal.h>
+#include <hang.h>
+#include <spl.h>
+
+#include "../common.h"
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	ret = spl_early_init();
+	if (ret) {
+		debug("spl_early_init() failed: %d\n", ret);
+		hang();
+	}
+
+	preloader_console_init();
+	debug("am62lx_init: %s done\n", __func__);
+}
+
+u32 spl_boot_device(void)
+{
+	return get_boot_device();
+}
+
+u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
+{
+	u32 devstat = readl(CTRLMMR_MAIN_DEVSTAT);
+	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
+		MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
+	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
+		MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
+
+	switch (bootmode) {
+	case BOOT_DEVICE_EMMC:
+		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
+			return MMCSD_MODE_EMMCBOOT;
+		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
+			return MMCSD_MODE_FS;
+		return MMCSD_MODE_EMMCBOOT;
+	case BOOT_DEVICE_MMC:
+		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
+			return MMCSD_MODE_RAW;
+	default:
+		return MMCSD_MODE_FS;
+	}
+}
+
diff --git a/arch/arm/mach-k3/am62lx/boot.c b/arch/arm/mach-k3/am62lx/boot.c
new file mode 100644
index 000000000000..77ddabce856d
--- /dev/null
+++ b/arch/arm/mach-k3/am62lx/boot.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0+
+// SPDX-FileCopyrightText: Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#include <asm/io.h>
+#include <asm/arch/hardware.h>
+#include <asm/arch/am62l_spl.h>
+
+static u32 get_backup_bootmedia(u32 devstat)
+{
+	u32 bootmode = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
+				MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
+	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK) >>
+				MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
+
+	switch (bootmode) {
+	case BACKUP_BOOT_DEVICE_UART:
+		return BOOT_DEVICE_UART;
+
+	case BACKUP_BOOT_DEVICE_MMC:
+		if (bootmode_cfg)
+			return BOOT_DEVICE_MMC2;
+		return BOOT_DEVICE_MMC1;
+
+	case BACKUP_BOOT_DEVICE_SPI:
+		return BOOT_DEVICE_SPI;
+
+	case BACKUP_BOOT_DEVICE_DFU:
+		if (bootmode_cfg & MAIN_DEVSTAT_BACKUP_USB_MODE_MASK)
+			return BOOT_DEVICE_USB;
+		return BOOT_DEVICE_DFU;
+	};
+
+	return BOOT_DEVICE_RAM;
+}
+
+static u32 get_primary_bootmedia(u32 devstat)
+{
+	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
+				MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
+	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
+				MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
+
+	switch (bootmode) {
+	case BOOT_DEVICE_XSPI_FAST:
+	case BOOT_DEVICE_XSPI:
+	case BOOT_DEVICE_OSPI:
+	case BOOT_DEVICE_QSPI:
+	case BOOT_DEVICE_SPI:
+		return BOOT_DEVICE_SPI;
+
+	case BOOT_DEVICE_EMMC:
+		return BOOT_DEVICE_MMC1;
+
+	case BOOT_DEVICE_SPI_NAND:
+		return BOOT_DEVICE_SPI_NAND;
+
+	case BOOT_DEVICE_MMC:
+		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
+				MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
+			return BOOT_DEVICE_MMC2;
+		return BOOT_DEVICE_MMC1;
+
+	case BOOT_DEVICE_DFU:
+		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK) >>
+		    MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT)
+			return BOOT_DEVICE_USB;
+		return BOOT_DEVICE_DFU;
+
+	case BOOT_DEVICE_NOBOOT:
+		return BOOT_DEVICE_RAM;
+	}
+
+	return bootmode;
+}
+
+u32 get_boot_device(void)
+{
+	u32 devstat = readl(CTRLMMR_MAIN_DEVSTAT);
+	u32 bootmode = *(u32 *)(K3_BOOT_PARAM_TABLE_INDEX_OCRAM);
+
+	if (bootmode == K3_PRIMARY_BOOTMODE)
+		return get_primary_bootmedia(devstat);
+	return get_backup_bootmedia(devstat);
+}
diff --git a/arch/arm/mach-k3/am62lx/schema.yaml b/arch/arm/mach-k3/am62lx/schema.yaml
new file mode 100644
index 000000000000..c1dcd9ced403
--- /dev/null
+++ b/arch/arm/mach-k3/am62lx/schema.yaml
@@ -0,0 +1,427 @@
+# SPDX-License-Identifier: GPL-2.0-only OR MIT
+#
+# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Config schema for TI AM62L devices
+#
+
+---
+
+definitions:
+    u8:
+        type: integer
+        minimum: 0
+        maximum: 0xff
+    u16:
+        type: integer
+        minimum: 0
+        maximum: 0xffff
+    u32:
+        type: integer
+        minimum: 0
+        maximum: 0xffffffff
+
+
+
+type: object
+properties:
+    pm-cfg:
+        type: object
+        properties:
+            rev:
+                type: object
+                properties:
+                    boardcfg_abi_maj:
+                        $ref: "#/definitions/u8"
+                    boardcfg_abi_min:
+                        $ref: "#/definitions/u8"
+    board-cfg:
+        type: object
+        properties:
+            rev:
+                type: object
+                properties:
+                    boardcfg_abi_maj:
+                        $ref: "#/definitions/u8"
+                    boardcfg_abi_min:
+                        $ref: "#/definitions/u8"
+            control:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    main_isolation_enable:
+                        $ref: "#/definitions/u8"
+                    main_isolation_hostid:
+                        $ref: "#/definitions/u16"
+
+            bm_writer_cfg:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    allowed_host:
+                        $ref : "#/definitions/u8"
+
+            reserved:
+                type: array
+                minItems: 7
+                maxItems: 7
+                items:
+                    $ref: "#/definitions/u8"
+
+            debug_cfg:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    trace_dst_enables:
+                        $ref: "#/definitions/u16"
+                    trace_src_enables:
+                        $ref: "#/definitions/u16"
+
+    sec-cfg:
+        type: object
+        properties:
+            rev:
+                type: object
+                properties:
+                    boardcfg_abi_maj:
+                        $ref: "#/definitions/u8"
+                    boardcfg_abi_min:
+                        $ref: "#/definitions/u8"
+
+            processor_acl_list:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    proc_acl_entries:
+                        type: array
+                        minItems: 32
+                        maxItems: 32
+                        items:
+                            type: object
+                            properties:
+                                processor_id:
+                                    $ref: "#/definitions/u8"
+                                proc_access_master:
+                                    $ref: "#/definitions/u8"
+                                proc_access_secondary:
+                                    type: array
+                                    minItems: 3
+                                    maxItems: 3
+                                    items:
+                                        $ref: "#/definitions/u8"
+            host_hierarchy:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    host_hierarchy_entries:
+                        type: array
+                        minItems: 32
+                        maxItems: 32
+                        items:
+                            type: object
+                            properties:
+                                host_id:
+                                    $ref: "#/definitions/u8"
+                                supervisor_host_id:
+                                    $ref: "#/definitions/u8"
+
+            otp_config:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    otp_entry:
+                        type: array
+                        minItems: 32
+                        maxItems: 32
+                        items:
+                            type: object
+                            properties:
+                                host_id:
+                                    $ref: "#/definitions/u8"
+                                host_perms:
+                                    $ref: "#/definitions/u8"
+                    write_host_id:
+                        $ref: "#/definitions/u8"
+
+            dkek_config:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    allowed_hosts:
+                        type: array
+                        minItems: 4
+                        maxItems: 4
+                        items:
+                            $ref: "#/definitions/u8"
+                    allow_dkek_export_tisci:
+                        $ref: "#/definitions/u8"
+                    rsvd:
+                        type: array
+                        minItems: 3
+                        maxItems: 3
+                        items:
+                            $ref: "#/definitions/u8"
+
+            sa2ul_cfg:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    rsvd:
+                        type: array
+                        minItems: 2
+                        maxItems: 4
+                        items:
+                            $ref: "#/definitions/u8"
+                    enable_saul_psil_global_config_writes:
+                        $ref: "#/definitions/u8"
+                    auth_resource_owner:
+                        $ref: "#/definitions/u8"
+
+            sec_dbg_config:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    allow_jtag_unlock:
+                        $ref: "#/definitions/u8"
+                    allow_wildcard_unlock:
+                        $ref: "#/definitions/u8"
+                    allowed_debug_level_rsvd:
+                        $ref: "#/definitions/u8"
+                    rsvd:
+                        $ref: "#/definitions/u8"
+                    min_cert_rev:
+                        $ref: "#/definitions/u32"
+                    jtag_unlock_hosts:
+                        type: array
+                        minItems: 4
+                        maxItems: 4
+                        items:
+                            $ref: "#/definitions/u8"
+
+
+            sec_handover_cfg:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    handover_msg_sender:
+                        $ref: "#/definitions/u8"
+                    handover_to_host_id:
+                        $ref: "#/definitions/u8"
+                    rsvd:
+                        type: array
+                        minItems: 4
+                        maxItems: 4
+                        items:
+                            $ref: "#/definitions/u8"
+
+    rm-cfg:
+        type: object
+        properties:
+            rm_boardcfg:
+                type: object
+                properties:
+                    rev:
+                        type: object
+                        properties:
+                            boardcfg_abi_maj:
+                                $ref: "#/definitions/u8"
+                            boardcfg_abi_min:
+                                $ref: "#/definitions/u8"
+
+                    host_cfg:
+                        type: object
+                        properties:
+                            subhdr:
+                                type: object
+                                properties:
+                                    magic:
+                                        $ref: "#/definitions/u16"
+                                    size:
+                                        $ref: "#/definitions/u16"
+                            host_cfg_entries:
+                                type: array
+                                minItems: 0
+                                maxItems: 32
+                                items:
+                                    type: object
+                                    properties:
+                                        host_id:
+                                            $ref: "#/definitions/u8"
+                                        allowed_atype:
+                                            $ref: "#/definitions/u8"
+                                        allowed_qos:
+                                            $ref: "#/definitions/u16"
+                                        allowed_orderid:
+                                            $ref: "#/definitions/u32"
+                                        allowed_priority:
+                                            $ref: "#/definitions/u16"
+                                        allowed_sched_priority:
+                                            $ref: "#/definitions/u8"
+                    resasg:
+                        type: object
+                        properties:
+                            subhdr:
+                                type: object
+                                properties:
+                                    magic:
+                                        $ref: "#/definitions/u16"
+                                    size:
+                                        $ref: "#/definitions/u16"
+                            resasg_entries_size:
+                                        $ref: "#/definitions/u16"
+                            reserved:
+                                        $ref: "#/definitions/u16"
+
+            resasg_entries:
+                type: array
+                minItems: 0
+                maxItems: 468
+                items:
+                    type: object
+                    properties:
+                        start_resource:
+                            $ref: "#/definitions/u16"
+                        num_resource:
+                            $ref: "#/definitions/u16"
+                        type:
+                            $ref: "#/definitions/u16"
+                        host_id:
+                            $ref: "#/definitions/u8"
+                        reserved:
+                            $ref: "#/definitions/u8"
+
+    tifs-rm-cfg:
+        type: object
+        properties:
+            rm_boardcfg:
+                type: object
+                properties:
+                    rev:
+                        type: object
+                        properties:
+                            boardcfg_abi_maj:
+                                $ref: "#/definitions/u8"
+                            boardcfg_abi_min:
+                                $ref: "#/definitions/u8"
+
+                    host_cfg:
+                        type: object
+                        properties:
+                            subhdr:
+                                type: object
+                                properties:
+                                    magic:
+                                        $ref: "#/definitions/u16"
+                                    size:
+                                        $ref: "#/definitions/u16"
+                            host_cfg_entries:
+                                type: array
+                                minItems: 0
+                                maxItems: 32
+                                items:
+                                    type: object
+                                    properties:
+                                        host_id:
+                                            $ref: "#/definitions/u8"
+                                        allowed_atype:
+                                            $ref: "#/definitions/u8"
+                                        allowed_qos:
+                                            $ref: "#/definitions/u16"
+                                        allowed_orderid:
+                                            $ref: "#/definitions/u32"
+                                        allowed_priority:
+                                            $ref: "#/definitions/u16"
+                                        allowed_sched_priority:
+                                            $ref: "#/definitions/u8"
+                    resasg:
+                        type: object
+                        properties:
+                            subhdr:
+                                type: object
+                                properties:
+                                    magic:
+                                        $ref: "#/definitions/u16"
+                                    size:
+                                        $ref: "#/definitions/u16"
+                            resasg_entries_size:
+                                        $ref: "#/definitions/u16"
+                            reserved:
+                                        $ref: "#/definitions/u16"
+
+            resasg_entries:
+                type: array
+                minItems: 0
+                maxItems: 468
+                items:
+                    type: object
+                    properties:
+                        start_resource:
+                            $ref: "#/definitions/u16"
+                        num_resource:
+                            $ref: "#/definitions/u16"
+                        type:
+                            $ref: "#/definitions/u16"
+                        host_id:
+                            $ref: "#/definitions/u8"
+                        reserved:
+                            $ref: "#/definitions/u8"
diff --git a/arch/arm/mach-k3/include/mach/am62l_hardware.h b/arch/arm/mach-k3/include/mach/am62l_hardware.h
new file mode 100644
index 000000000000..7791511ff2a2
--- /dev/null
+++ b/arch/arm/mach-k3/include/mach/am62l_hardware.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * AM62Lx SoC definitions, structures etc.
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __ASM_ARCH_AM62L_HARDWARE_H
+#define __ASM_ARCH_AM62L_HARDWARE_H
+
+#include <config.h>
+#ifndef __ASSEMBLY__
+#include <linux/bitops.h>
+#endif
+
+#define CTRL_MMR0_BASE				0x00100000
+#define WKUP_CTRL_MMR0_BASE			0x43000000
+#define WKUP_CTRL_MMR1_BASE			0x43010000
+
+#define CTRLMMR_MAIN_DEVSTAT			(WKUP_CTRL_MMR1_BASE + 0x30)
+#define MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK	GENMASK(6, 3)
+#define MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT	3
+#define MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK	GENMASK(9, 7)
+#define MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT	7
+#define MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK	GENMASK(12, 10)
+#define MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT	10
+#define MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK	BIT(13)
+#define MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT	13
+
+/* Primary Bootmode MMC Config macros */
+#define MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK	BIT(2)
+#define MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT	2
+#define MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK	BIT(0)
+#define MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_SHIFT	0
+
+/* Primary Bootmode USB Config macros */
+#define MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT	1
+#define MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK	BIT(1)
+
+/* Backup Bootmode USB Config macros */
+#define MAIN_DEVSTAT_BACKUP_USB_MODE_MASK	BIT(0)
+
+/* address boot rom leaves its boot structure */
+#define K3_BOOT_PARAM_TABLE_INDEX_OCRAM		0x70816e70
+
+static const u32 put_core_ids[] = {};
+
+#endif /* __ASM_ARCH_AM62L_HARDWARE_H */
diff --git a/arch/arm/mach-k3/include/mach/am62l_spl.h b/arch/arm/mach-k3/include/mach/am62l_spl.h
new file mode 100644
index 000000000000..52d702d179c6
--- /dev/null
+++ b/arch/arm/mach-k3/include/mach/am62l_spl.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef _ASM_ARCH_AM62L_SPL_H_
+#define _ASM_ARCH_AM62L_SPL_H_
+
+/* Primary BootMode devices */
+#define BOOT_DEVICE_SPI_NAND		0x00
+#define BOOT_DEVICE_RAM			0xFF
+#define BOOT_DEVICE_OSPI		0x01
+#define BOOT_DEVICE_QSPI		0x02
+#define BOOT_DEVICE_SPI			0x03
+#define BOOT_DEVICE_UART		0x07
+#define BOOT_DEVICE_MMC			0x08
+#define BOOT_DEVICE_EMMC		0x09
+#define BOOT_DEVICE_USB			0x0A
+#define BOOT_DEVICE_DFU			0x0A
+#define BOOT_DEVICE_GPMC_NAND		0x0B
+#define BOOT_DEVICE_XSPI_FAST		0x0D
+#define BOOT_DEVICE_XSPI		0x0E
+#define BOOT_DEVICE_NOBOOT		0x0F
+
+/* U-Boot used aliases */
+#define BOOT_DEVICE_MMC2		BOOT_DEVICE_MMC
+#define BOOT_DEVICE_MMC1		BOOT_DEVICE_EMMC
+/* Invalid Choices for the AM62Lx */
+#define BOOT_DEVICE_MMC2_2		0x1F
+#define BOOT_DEVICE_ETHERNET		0x1F
+
+/* Backup BootMode devices */
+#define BACKUP_BOOT_DEVICE_USB		0x01
+#define BACKUP_BOOT_DEVICE_DFU		0x01
+#define BACKUP_BOOT_DEVICE_UART		0x03
+#define BACKUP_BOOT_DEVICE_MMC		0x05
+#define BACKUP_BOOT_DEVICE_SPI		0x06
+
+#define K3_PRIMARY_BOOTMODE		0x0
+
+#endif /* _ASM_ARCH_AM62L_SPL_H_ */
diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index 6b86f6ed12e6..cbf43deaa3fc 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -16,6 +16,10 @@
 #include "am62a_hardware.h"
 #endif
 
+#ifdef CONFIG_SOC_K3_AM62L3
+#include "am62l_hardware.h"
+#endif
+
 #ifdef CONFIG_SOC_K3_AM62P5
 #include "am62p_hardware.h"
 #endif
diff --git a/arch/arm/mach-k3/include/mach/spl.h b/arch/arm/mach-k3/include/mach/spl.h
index a47441ae6a59..ff0b5d41b9f1 100644
--- a/arch/arm/mach-k3/include/mach/spl.h
+++ b/arch/arm/mach-k3/include/mach/spl.h
@@ -46,4 +46,8 @@
 #include "j722s_spl.h"
 #endif
 
+#ifdef CONFIG_SOC_K3_AM62L3
+#include "am62l_spl.h"
+#endif
+
 #endif /* _ASM_ARCH_SPL_H_ */
diff --git a/include/configs/am62l3_evm.h b/include/configs/am62l3_evm.h
new file mode 100644
index 000000000000..181d450daf10
--- /dev/null
+++ b/include/configs/am62l3_evm.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Configuration header file for K3 AM62L SoC family
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#ifndef __CONFIG_AM62L3_EVM_H
+#define __CONFIG_AM62L3_EVM_H
+
+#include <configs/ti_armv7_common.h>
+
+#endif /* __CONFIG_AM62L3_EVM_H */

-- 
2.54.0

