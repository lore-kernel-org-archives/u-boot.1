Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C435C4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 18:09:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E567409B4;
	Tue, 21 Jul 2026 18:09:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y-2AiOOR_QAx; Tue, 21 Jul 2026 18:09:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4A00440983
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784657360;
	bh=h4ipBvwzuZHWqSAeFooCFUEmQQC3sztniZjrsObyqYQ=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=oU/PfuxqObHuxsYMWjIPRgu+9lP/HNOI82r0zjxFwq/x4LWR6xYtU8hjgGf2Qu+XI
	 VwqdawF0LdrFsCj6bbAQhbbGZZbsmf7dnUsMOao958Tn6jisr/Npy3IXphCnBx+1c/
	 HhNpo8O06cec2IvxhcOG3coTHpDcTzCMFRNa/6F34y2x+nnN+IsAAtcWSGEavr8/i+
	 8+Kjz/RUBMIIx9Pc9xgDLVf4nbV8Q6UumLr3ooEl2EZZdDIiQ+q8e3eYTI7bMWTHR+
	 Z+GqSaa6liB9vxuMYJMsPTDJ+wFnVyzBJSky0imbjEr/OEDEQvMAYMlniC8YmGvU+a
	 MkXTyFH7q2+vQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A00440983;
	Tue, 21 Jul 2026 18:09:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D7D29EB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD90F40589
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:16:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6MJpApoesQ-c for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 16:16:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org F154840544
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F154840544
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F154840544
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:16:14 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66LDjHbv3231727;
 Tue, 21 Jul 2026 10:30:43 -0500
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013045.outbound.protection.outlook.com
 [40.93.201.45])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fj869hcfs-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 10:30:43 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckf0+G7Mf88z98IiLB71DObepQ6mv7z31sWbwLppdteBWvtsRhhbswsbm1N1q6MJkle2r0Wz7ezc/KBRh0vawly9c8KgUbOvpojiOLNbsG032VmHP4SGqUkyEewc4aert0ATK59/D4y1nLEPAkbsvTMq2QRyCtNl1lLmS0+Rn1O8ECt8Tq1neZ0XOAX+p7hKHc/CuujBOJhFOdzNb83ojoHUZPr9zC8R9YFo+VlXHkkWtuYkatylIYmhCExALlhiTnVfiM0bNuWHY3NfXL5Mjk7kMVA/4DBvqUgA8KO9pcgcD/FefdcbjiLzWntyl8aWBi3y38qmQjThe5dEM8zW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4ipBvwzuZHWqSAeFooCFUEmQQC3sztniZjrsObyqYQ=;
 b=VhpnWUaPzM2JEOajAhpwPHxLVXqKQ848S5YQDoqUkq4wcMTSx+NI+cmIxv4fEnTKkIhHgvcy85KEJOtvP6zyBeql7wUc+KpsQ+ZgCGLTs4Ms2VGfTFv3eFe3PRRZ1jQq+vr568niJB8Gc3ZCsKfeek904sJ59qnywado6WdfGZzQHLCJ1esN55MZQSOeM7TrlcUdkG8N5VR8raallZbRv3525Yd8tB6K87SovPLIlOyeSc1wmVP+VslDliIesYrsB9M4yxWtP/milvd4+p38t1HId46kHZiPoEDGnKD9bmfVkRRTpAuZwmxTZimr0dtZ3YePBaZ2WZBrzVX69/rTUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from SJ0PR13CA0055.namprd13.prod.outlook.com (2603:10b6:a03:2c2::30)
 by BY5PR10MB4371.namprd10.prod.outlook.com (2603:10b6:a03:210::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 15:30:41 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::57) by SJ0PR13CA0055.outlook.office365.com
 (2603:10b6:a03:2c2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 15:30:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 15:30:41 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:30:22 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:30:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 21 Jul 2026 10:30:22 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66LFUMhY1655301;
 Tue, 21 Jul 2026 10:30:22 -0500
Date: Tue, 21 Jul 2026 10:30:19 -0500
Subject: [PATCH v2 04/11] boot/Kconfig: disable fit post processing for AM62L
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260721-am62lx-v2-4-33ff580c267d@ti.com>
References: <20260721-am62lx-v2-0-33ff580c267d@ti.com>
In-Reply-To: <20260721-am62lx-v2-0-33ff580c267d@ti.com>
To: <u-boot@lists.denx.de>, <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Alice Guo
 <alice.guo@nxp.com>, Anshul Dalal <anshuld@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrew Davis <afd@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, "Kory Maincent
 (TI.com)" <kory.maincent@bootlin.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Daniel Golle <daniel@makrotopia.org>, "Rasmus
 Villemoes" <rv@rasmusvillemoes.dk>, Vignesh Raghavendra <vigneshr@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Dhruva Gole <d-gole@ti.com>,
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 George McCollister <george.mccollister@konsulko.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 "Swamil Jain" <s-jain1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Shiva Tripathi <s-tripathi1@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "Aristo Chen" <aristo.chen@canonical.com>,
 Johan Jonker <jbx6244@gmail.com>, "Apurva Nandan" <a-nandan@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Hrushikesh Salunke
 <h-salunke@ti.com>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.16-dev-d5d98
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|BY5PR10MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: 010e1b89-8c17-4d88-0eb3-08dee73d0629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|1800799024|23010399003|376014|82310400026|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oLL4fKiBuBUAifySeWXA6VYl7MEnoEJ1/vvdYaTucQZZ2uICf5y7KcDL3q35TZyRLePz7UVIbZCIcFQl5aE1V6MhDcWeVKsu0pFU8kxegk4T7brbh2PErRle+pxpKijc2Y8Z9st3GFtScSpl7PI9DYPILG0q4gNbkzN+aeBqlIEXhAeWIoXnJqJfq+tUEs7mlWn5LCAP5hPZhXD0ZAi0LHC41Iurfkr1TUpGKIvGA83q65SUOgmIw/x++YSXnZNk4tavMJu2ibUWUTfWlFYJDOYfAX0hqpmZg2rfVXYslMgLcIlw4okGDokDtwfUo3vaAvhBCGWReVCJO7iEh5FShJe90NvQFYgE/4Yfbvdt+WqDDogoZQ9bwUyyoZGcPFAoEgK78qIlFZico6irRG9hZ7F7QWKy4aEPlUBBcmBKlbMVnfxE+0oKGgQhr22a7m5/Mlh1edMrEz8C0msc9RqKXZxmlrdNYPxzw0fITDUCjn+fxvYGDBi2BKVCTkmycuyLaHJU70RXjrJKjGDdGNRKh/6CtBEhPURXt3nLSi/lwgd6S3Flo2NgkTZ0C/Tg/TjFvbDZgAJmKdkWsv3SZfeEWxcn6NxZ65D84JDs91CPLawzaRMBZSD0V/9Br6AYzrVICq2rnEQ3SMZPjrHBLiBhbKvzUAlX1puK4uIw+ybPjvONGptWIRdKUnye1MUSVVnfmybrwmZHaUzxBILOk//TGA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(1800799024)(23010399003)(376014)(82310400026)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UYMutLfHg/wak+n0EDBvsEDcmhnHTeZSC+MLd5cOB1XicfAYjsL87wN7/1QPFAgHbOPqry4KPAH6mhPasBxYrrsw04P8kCI/+PHpoGuET8SjeYooEEpRH57bwKWqvFN0sCT9xIAWZQhgO0jjg4ogrbD268fXM7gvJyUQxRz9cH9RUrHcBRdirvRBWuAFKD24ZY1jZz00/3r7zBCTlFu7RLohYnemoAs/Su07FwzpkTdtHhGQUuOgr/GtWUET6lEwND0lTNKgj5CfbEYMQV4b+FhRyP//dghNfm7TsByxdPfbfOVuv4Ow3ZQyFqOKuZJ83UaXeCEitNvWs/lA0s/scLtzbUQIiOyst4E8Mps6Cxz91vHmlSYa2J+KvvOlWdk8E8BGFxghVSq1zWTp1kjE8zWgKidTmes0uTzHgUL3JI4YAziJrlxzzgFyZQvMyaf0
X-Exchange-RoutingPolicyChecked: YIzjwsHGZctAo2hSSENtHdlwN0G8dmX6UzJ3twXWxHcWs/VOunmIRv2F2i3t7DeSJFrIFeP6qG+i8mWsfj8tHA3hv0uZNZTTK8dy9q0afZ8CaPd8GXosR+6rOPlh8k14RX3J4uhMIc0fHj5C3hXX/gsqvoOE3C3TPbmkNIB6OY23ZBXEzncudBennNSR+wMRicqN1Oc+m9caqTLTU56WORm2iBYfV5Xh5clY8HzSzqlHz6gWsAoaGGWbVU9JpSz1FKdDuOu6ihMw9O6t71C4dEsq7ISVILkP8+UiXBAt/iX7Kp27dqS9tou8vdUyv24Nyn1LymfjT8LqKgkY99Sz7Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 15:30:41.4182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 010e1b89-8c17-4d88-0eb3-08dee73d0629
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4371
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE2NCBTYWx0ZWRfXxPqIZN2UZzsV
 fe0MPFrpI0PpJk3ujrJNhXP/OF6D84KvFIovwZzNs+gyJlTMZZ3Jrq2E9L1ljH8zR8rk8IxkaCl
 bPj7LXU8/0VCJQZHS9ySJ6mlQ6xY3ntwjDYdEYWirlkN1PXkDXuA79mvzkOkrilBsIB9nY14ZRc
 +MAhkfrGXNK820SSQ1THWYMQ5oafQSWcHL00fl8kNd9Oeo21JGZUyZDub+2jWatqGxpe34ZCOMZ
 /tW5SBBz4VadqLllnz0sARjFRq1n8O2z9x/iWyqGyCQ1jOHHjJay3Nnwp//fG+sg+GIc4z2r/In
 ZRRQwYI+VP2VnBVIn2mLoi8Ux93y4sW8iryI9Bd0eYMLezluu4AhedLMDxhXI+ZBUKH0jJn8AQp
 y2fhV5imHeiQgEQ8iUeYyC5TBClBktYMANqSszxPfCDfWo1hbnFyPhDO1E9spfTOxtrYz6evYXC
 /XHQKgT82/SDMX0xB1A==
X-Authority-Analysis: v=2.4 cv=WbI8rUhX c=1 sm=1 tr=0 ts=6a5f90a3 cx=c_pps
 a=vt7ZpyDplQGd1SQmd2LaWQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=22Z8trJi2V0NGen_QEsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: H7jHvhzSDOX-E6byWk7yD8SZ0skF7YE4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE2NCBTYWx0ZWRfXz/igk1PuqywA
 aWwKnG4h3SH4YSjAZtUfWnfrAnn65yndXqNdZMpq2v/8i+3v0vq3wIILmjsLeTo1Gx5fkLuvjXu
 DUswFTF6PltnXucBF5t4KMYupvOLqRM=
X-Proofpoint-GUID: H7jHvhzSDOX-E6byWk7yD8SZ0skF7YE4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210164
X-Mailman-Approved-At: Tue, 21 Jul 2026 18:09:10 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=h4ipBvwzuZHWqSAeFooCFUEmQQC3sztniZjrsObyq
 YQ=; b=Yxu6Fy8TbCWlvI6LhEXL9sKVzQ2vljZpJXmhck1SGTDKKDJ5Og0/5Fvf4
 Vm1S1QTbKHSyvJEXh5oNPL+1Ox7OagQpnHjYm+IrCofHpG14m+Eici9D3A/OTUwa
 hXNwr0+NCuV/Nku0XqfO7dxN6q2xQuDojZRzK/ozs8vtkdQiqAVJ/6cjxnbzLTea
 DKxgQNwdlMeGhJEwHksTsXAF/jhN3vNKmFxtQS7IHI/oAnBTZ0/rH/sGFgQEuOAO
 ct1iP/yAneWDjXMnHmDiQdG1NpO1JgHieNsm/CW/lrg2+uD5g0by//wgoHyB36nw
 q57xAQNBT5AsDPim6BIpQl8cX5TLw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4ipBvwzuZHWqSAeFooCFUEmQQC3sztniZjrsObyqYQ=;
 b=cQB9xoFLgY6nY3ltdBmsSoX6OLI8hxHrgqOi69eyknQ4GBshMTHfAnOqi8g6GLMyeB4NB7uWrT5Xe4tJQGhdGF1VhmiYLDwSgrKRZIm0HI3FjR/jy4QzC1ubUc6tGe+rwW/HcVojZ8GpeaEY/HiK8u+Ks+oJGkrbPsH+611SEhY=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Yxu6Fy8T; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=cQB9xoFL
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
From: Bryan Brattlof via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Bryan Brattlof <bb@ti.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The AM62L family of SoCs utilize a 2 stage ROM boot which uses x509
certificates for booting securely. There is no need for processing of a
fitImage. Disable it for the AM62L SoC family.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 boot/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 8e468c561765..585718aeeb84 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -333,7 +333,7 @@ config SPL_LOAD_FIT_FULL
 config SPL_FIT_IMAGE_POST_PROCESS
 	bool "Enable post-processing of FIT artifacts after loading by the SPL"
 	depends on SPL_LOAD_FIT
-	default y if TI_SECURE_DEVICE
+	default y if (TI_SECURE_DEVICE && !SOC_K3_AM62L3)
 	help
 	  Allows doing any sort of manipulation to blobs after they got extracted
 	  from the U-Boot FIT image like stripping off headers or modifying the

-- 
2.54.0

