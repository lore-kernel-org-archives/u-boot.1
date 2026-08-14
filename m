Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6CEC5CFDB
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 12:46:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77F6881193;
	Fri, 14 Aug 2026 12:46:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K3_WGGj2eDXF; Fri, 14 Aug 2026 12:46:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8C2468119F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786711596;
	bh=4fuuV1ADRVgtebzuhIJfL5HOrAnU+B9OW2Rwzv3xkHw=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ckK44FDS4hRLRSVN9EQiVBaPvDfz3V7pYRfPoxNhvTat2S+J+cNDiDWtZAPm+BRv/
	 3J0FSDAUJdr2KeFgBPJypZRk3bnh+/ks3EEKSlLa/9QZBUCapKy7EXywM/nzo0O6+Y
	 Hg2PAi7bGUlngobNCHqbNYpMCJoBofYH+uXg2UQJCQAyX3Tl78P3L1x5BjqMfN+a8c
	 BwMHIt55ZuwUj/T3OFaCL+RPd/p+hM1/OcFavw+A4GjV+NzseGbDXt8KB/Qxah4UBI
	 twivDPhVUf/3C1t0fC5GLdqCI378r2RE7ck8RDC8YTzZRHoYGCRTqbaDRa+4rO6x1D
	 9uC4/GHEgR2SA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C2468119F;
	Fri, 14 Aug 2026 12:46:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0531F3A0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 10:22:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EBFBD60687
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 10:22:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3T1sNzcugn4M for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 10:22:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=g-praveen@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org EE4CB60601
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EE4CB60601
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=o1M6KHdb; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=ftPbvjns
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EE4CB60601
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 10:22:20 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67E7e2h6935370;
 Fri, 14 Aug 2026 05:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=4fuuV1ADRVgte
 bzuhIJfL5HOrAnU+B9OW2Rwzv3xkHw=; b=o1M6KHdbIxoF7T9Y8HOUBv4ZktMtK
 8W88Uuwk33jq05fME/8lh6D4bh45rcCxhpETQip80IOe2rTaLQ7+iKkY0dbBNmUB
 aJl4HMt8roChxvjcqFD0HgzoWB2bYzvm0gvlL4EcimIc1MLuh2ig3/fFiqChJVyi
 1VqoI2V5SbpJB1ZE26aPuLTYOCNODAqixopGTgOIaoafcTnTmev5tIeg2LQT5IP+
 We8OeFr+4+9LcCR1i4+Vx/eFRvUsYnpMgIe+mNw9gZmUXShHt7fIFFSipwZctsJx
 VTP304jeZ3NELVdLsztfQxDqnXA8Hp8+rjvck6g8Mn8mhUWaEIEjBQBkw==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010014.outbound.protection.outlook.com [52.101.46.14])
 by m0380145.ppops.net (PPS) with ESMTPS id 4g1xey0uwq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 05:22:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRnb82orVAtSo/4fL5Y4zHE4AYFRaCDkxeMff/LZn4970tFPQxLkZZpKPrO0dEkT0lyLyIm2olN+OYlkPAI0+E7ba98lnOA693ZBu9uNXaFlNOMt6VB+cIofxHt/lnou8UXaoKDELH1eP8QWqQK7XJRcUc14qWpWc3OO6Vo10GzmHfAUlRzzxNk3cSmKpWOSzFT9HbUWQB3JdvIwsT4faziGHkR3BgS9t2qp5kIqmLDJsTLNc2OtQzRLXidFzTF32MijmTaQHEFUfrkiM9AWgDmkTDX6PFiaHsVg08o1kkWaVm/wQ+653DniLslRWpW1WoJ2RkfFn/u46gZwybl1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fuuV1ADRVgtebzuhIJfL5HOrAnU+B9OW2Rwzv3xkHw=;
 b=Qbg0g7HWeCTkxYVLrVpoFwVnOJTF5MklE0w+IjScCnwSJzy8Ubq7eG9vDQsMQV++7BkpH8tQEcTgoW+B2pzAYNTeNKcxg5dtNtBY+mU8jXhhTYHCqMUk/HQPU6Ks5PX4MAsfqJqYqM51+Ji8ZXvwU4ms97mycftVaECeFzFKfntpd8HPqpVn65ZV04gD3K+5famhLohOq1lpFoQs7pT2CTvFgfaK6an09AYiRDGCKVlgDNfo+vjrExY6H8Slpe7jphqWCwS9/S6VZepbn0MAFlVTYDisB/c+ZGJYfjWcVtwO60yMAzpXMgu0mvKZcSmas4U5gIm5KvhQ1eZ70v+TMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fuuV1ADRVgtebzuhIJfL5HOrAnU+B9OW2Rwzv3xkHw=;
 b=ftPbvjnsJFX7QAfaWchc8TwgiUPd4VB5uoxMukkFlkSPtfU9cGCDOTgUAZkfk5rM2tI7yWioVpcbcYsg2nUjJnS/I6gxxB/p+DI2dp9xFchwMxae7bwNSE1aGkcYobLTtcgsQBaQdhU4txP1yeFdeklhni8y1bF8lM0e0C4nY6c=
Received: from BYAPR21CA0016.namprd21.prod.outlook.com (2603:10b6:a03:114::26)
 by SJ0PR10MB4431.namprd10.prod.outlook.com (2603:10b6:a03:2dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 10:22:15 +0000
Received: from CO1PEPF00012E82.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::1b) by BYAPR21CA0016.outlook.office365.com
 (2603:10b6:a03:114::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.6 via Frontend Transport; Fri, 14
 Aug 2026 10:22:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF00012E82.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 10:22:13 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 05:21:59 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 05:21:59 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 05:21:59 -0500
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.154])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67EALueQ2569179;
 Fri, 14 Aug 2026 05:21:57 -0500
From: Gokul Praveen <g-praveen@ti.com>
To: <trini@konsulko.com>, <g-praveen@ti.com>, <n-francis@ti.com>,
 <a-nandan@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH 0/3] Semi-Falcon Boot Support
Date: Fri, 14 Aug 2026 15:51:50 +0530
Message-ID: <20260814102153.44487-1-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E82:EE_|SJ0PR10MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 88fab836-038e-45e2-6426-08def9ede8a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|56012099006|10067099003|6133799003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: m4FV0BpfEsVJ1CfEvZd7iMq8b/ulQ8kJrP9AhpNUQTFufBS4o9OTGHzZHkeDinrZo4lX+OZ+3VKGJi6I89z1gf185++2JkO18v7F5jjInsW0NwDxuJaYq4bWdZZefmmbYf6jfxWoSHyHebvL/x30nvWGTCtEVDkQq4OEnObG4ANEl3sxgGmOrz8ER9/tRuOeO3w8gcTPvpKbZvmXiiB3xsaV0BaasZeCogN57q2udlXniwi0wOA0g6mtqkX6W9++8+uvxdgjjFBrsnTS4pV17uJmoq9hHLUouNeE/zmu5a17Uw0GVL8VAPOdHlb9b5xwYb9GQiV3UloXxmbu/qOz/6Qj3zPcIXhWCIkh748FmrjT4ei5XdxHbAzg4+gWu32ON15+SwKAY80TK+6Hdc6Key9fid6NWQ3/xD06VX+/I+JnOOxftmaEHTdY8hbrLLeQ9Z4YAI1vvkFcjkiXgW55xMZ6ENtW/9WwldiU63pciO9IXlccv7zhT8+a0jcVUtPjDCSMqoXgz8oLXlHLz6h055+AESlRicHog0bsL0leBME/pHGlluYjG4DvAuO6EkPVgYT1r4Ml0dP9coc4yggAu5ikcSh1wKA9pZXFijpunu6bRCiNHHdzoFzNVY3PFlcu397moQF4F6QtnuMmt5ml4q7AGJ5LmBGe/GpqXQW7L3T5OHduDtLe3EgFZTPCq5/3duyCfNtcIihGZHvrmFOdIw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(56012099006)(10067099003)(6133799003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N2Ipb313EvASiXYCwimSr+o3uoDhSoNF32dVu+TfFGRXMDe+67nhH7tPriO9cK78tk+mJ8Ec+LKVAnZsJhGVaGKuguT43VJgRjFn8vDh+0hDF626l8gQjmR784NOwQj45vZgvkWGWDDA/ueSDRoQwsbralB+DNH7ZL1E0WV8ngUQfuNpJpc2KgInAYw/cklrU1PsU90Da5a+bEHfAYI0WvFTlYOVqVxHEXlJWxshUrzkV3FKy+z1AdFteaROQyZ0HRgKJCcQFQA1vJNKTXFddttexpS5ptup7qo83ULoD7g1RcGvlOhF9pMfn4des2Ad7abaDknr8g7TShtaN/jmSy4hWZeCKc6iJcPpaYTUNtYGD8GXEJMYtwYyckBNEfSRfXt7OF3I3f57JUt6lnxsED524b5eJBLD8qiwajk7E+B98B22EwCewdP+mj5qBPO3
X-Exchange-RoutingPolicyChecked: ErjlC/alO68R+SlmsAFY8FLHKQRuqP7eDG+7DW3z5FbJPFMpBGpOJ/c1wEfyv/vIsi5qyCIVoNb3IrjSZ8PtmQq/qHb+e5I6FmzKjW/vFA94TSXNA6YdPKeqEVcFr90cy7udXoEEQYuqOFm+YdGBJ5JTZL6VYNrsSVZqjIuw2Mfw+u4WCjk5ZGDsT+JY+DpF/3R2FFlk7yDEHE1ktQz2K680Hr3D22wRbDl7nNsLUjQohYUCxLAydOToRGuU0S4KqVBHUzBdbYmk/uOCtH01aSOAIWJCaff5gkypSAo9588rAdSisBmuPhMyAKXouMR9OOj7NLsFr01+Qo1vjK9lhQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 10:22:13.7594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88fab836-038e-45e2-6426-08def9ede8a6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E82.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4431
X-Authority-Analysis: v=2.4 cv=F9ZnsKhN c=1 sm=1 tr=0 ts=6a7eec5b cx=c_pps
 a=f5Tl6ILaYY6UHEJdjUIuFA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=NEAV23lmAAAA:8 a=KU8ykleAShvGUyBpXLEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA3OCBTYWx0ZWRfX8jLepyzz4v0n
 0ckc1Bd2/6H30Hegrt+0yWhMV+rMbwwIiFT00QZGlqBxZwP375wgT7HOD/1CpM6hJz8i54Dbvon
 jPmXB3wvC9IvtZnGK9sR0oPJYa9mAEQ=
X-Proofpoint-ORIG-GUID: uirslr9gYJAKzjkqs1Ks0io2jB9RhrqN
X-Proofpoint-GUID: uirslr9gYJAKzjkqs1Ks0io2jB9RhrqN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA3OCBTYWx0ZWRfX9nUuZf5o7HQO
 qM/x907TrRkXn7sUtDbcjY/p2guwjOpU7ETPAVBWwYFZo1YjYH/m/3+H8rVN8jNrgu+GeCkrlT7
 lc2ltPOs2+LhXwbQTV3gSAKg95awDYGSgtTHl8xnzxwgMtnUbA2JbseKtyhwpZUftcq6fkhtu3U
 HP0JkeNrY86SUJC5hv3V7nI2gTDRBwNIusvAw22hvWpMab6TJbcnD2Tn7SliwawRdiYiZuhHdiG
 AnQSxj0voAPbuhwUpk/6ThcT5qI7qdhrSdlOymBPLA6RHaayTK7CC9k8JAVKuOyT+7EGyrbXYj4
 0Rf0COeBtuCrOkyc4fB/KbKRNydaAJ4LwG7CBmc0TOtZOQQWluX6FkmAR0jiqR/BHPuiWqeo4n4
 C02RQTFiZ0QQ2MpI9KWU3FDjwkqLafLjMWxwEEXyv1yx24I9TgyPHAfH+mdPEXpgcvAFren8Tj9
 xKoA4NvMmJzSTV3BV+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140078
X-Mailman-Approved-At: Fri, 14 Aug 2026 12:46:31 +0000
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

Semi-Falcon Mode is a hybrid boot approach that bypasses
the A72 SPL while retaining U-Boot in the boot flow. This mode provides faster
boot times compared to normal boot while maintaining U-Boot's flexibility for
kernel loading and system configuration..

Boot logs link :

https://gist.github.com/GokulPraveen2001/fef407a482e2dad30272006de557627c

Gokul Praveen (3):
  configs: add semi-falcon mode fragment for k3 devices
  arm: k3-binman: add tisemifalcon.bin for semi-falcon mode
  doc: ti: document semi-falcon mode for J784S4 EVM

 Makefile                               |   2 +-
 arch/arm/dts/k3-binman.dtsi            |  47 ++++++++
 arch/arm/dts/k3-j784s4-binman.dtsi     |  65 +++++++++++
 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi |  14 +++
 configs/k3_a72_semifalcon.config       |   1 +
 configs/k3_r5_semifalcon.config        |   1 +
 doc/board/ti/j784s4_evm.rst            | 143 +++++++++++++++++++++++++
 7 files changed, 272 insertions(+), 1 deletion(-)
 create mode 100644 configs/k3_a72_semifalcon.config
 create mode 100644 configs/k3_r5_semifalcon.config

-- 
2.34.1

