Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E97C44529
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 20:44:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B4616070C;
	Mon, 20 Jul 2026 20:44:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WHvGu1j6py1K; Mon, 20 Jul 2026 20:44:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0D5A860711
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784580258;
	bh=pfeR4YwuHOk+T9uX9gZrM6Y7WBW79WNQHdwphboexC8=;
	h=To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=tbrOC9RSnkkpQR0bBYjZqxuK+dkXcRF31gjGGQQBZgdVcKP73apmNIjPkX7BLvHnT
	 JebzzG/azVHiDvHnMIqKV5NHFcjsT+zQNp7PXPJDkmiFCvuj/xE7jl9dV9mUfKmVKM
	 7m5Jabt2mvfyk9V9GKM+RMqrH20FnBaaL6ND1RthwusyHuOkkgMRaN3PQb/zWEGsg/
	 b9O/Xqa5G4nr8z9moT3oL+S6WjegfvXi7yZZHv/RGz+UURm0D/VG7wnkQLaaucEm//
	 gCi7npVMNka29+DwR9rW/1maW48U+abCdphYyqraLl2/bHL8oFRMevqPBLcJbMPyE0
	 Ljjt/GsuPkdAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D5A860711;
	Mon, 20 Jul 2026 20:44:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 327B0786
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 20:44:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 24A1260714
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 20:44:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jAwq82gfu0zz for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 20:44:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=rs@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 085036070C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 085036070C
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 085036070C
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 20:44:14 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJQJLK2995679; Mon, 20 Jul 2026 15:17:40 -0500
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fhjnjuam2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 15:17:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsWu0QXDUEX6+TUD0P/W20H7QAmaEdqvI/YNPfO4pQHjyTMU/mvUHUSEec7xN5Q1WLYvnxDQ9MpcB2fBkQyxjtrRd2zwzTYs0tea/o+k+B/F4izEYBN/bpfCgJB5V+4bbpRyJbUzrhlEly8DAHQDZQnh45xoVQoK78I7iRHjxYxw5+A6RvYRlJYBTsM4IEX4RnQgrEXR9Mom2BB1aCifGc67Z9GusG9wZvMIXTbZTyu381JUgWu0nmVHuzx+oMRyyjFm7O+NpbMAE8QexiR7lyLZbDxeykN3Oxe7WPBQeQXQ04BgoqO0WxkUgZVAAUPamXwbhSqlKPlEDxJRxEmaVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfeR4YwuHOk+T9uX9gZrM6Y7WBW79WNQHdwphboexC8=;
 b=btfylVEdAqYCGL/v/yx33OokxENji3L1DRMaAt+4oOP8lJ9qM+/JJKH9eNQOAmSlNavY+lZmL0yQx7kx9QfsYE+uOe2/GZx19vseJnf45U4wFlX6UZWL+fJNLpBGOozSctBpoCan29qQwZvg5yqZU5rWvzBosonsA+gZ4n8EXFxrRld18qUNrcExbYFgrNsTKDBZ/D3R1m6zjk0bEcL0675I054+WTS6Yr9Fr0uQpGkh5KBkZa6jWb7CBsw925FnCyL6tCrCtM9pTxZr1gNtq7scsyPP/+CKE2P9uQ0ePjYefdA/uIh81BLgwQeTIpLRbMhZIoTSK/HlGE5jWcpZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from BN1PR13CA0025.namprd13.prod.outlook.com (2603:10b6:408:e2::30)
 by SJ0PR10MB4448.namprd10.prod.outlook.com (2603:10b6:a03:2ad::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 20:17:36 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:e2:cafe::22) by BN1PR13CA0025.outlook.office365.com
 (2603:10b6:408:e2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Mon,
 20 Jul 2026 20:17:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Mon, 20 Jul 2026 20:17:35 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 15:17:09 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 15:17:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 20 Jul 2026 15:17:09 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66KKH96G3202983;
 Mon, 20 Jul 2026 15:17:09 -0500
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.u-boot-project.org>
Subject: [PATCHv4 0/3] k3-am62-pocketbeagle2: add board and variant support
Date: Mon, 20 Jul 2026 15:16:16 -0500
Message-ID: <20260720201618.3863938-2-rs@ti.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|SJ0PR10MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: 079f85e0-dfbf-4a56-1686-08dee69befe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|56012099006|13003099007|921020|18002099003;
X-Microsoft-Antispam-Message-Info: XyXTbdopzolrbOVxqKHAuMDiWrIT3PsTf3zXQ8W0iHTC5f2VnUgLAcnUVZpCk+nt48LSRaNPR5t8M4X3rMKRtlSkQ/NVXzaStgSXcqO49ZRU52Qs0DO7XVQpx877N9OWlZ6EvoZfOaDESLVMMFTD7HCeK7oe/4QX2YoU6ZM+n5a5qwv//pE9HG/FyLf9VuIW8VTXRT6a3e/4dgIVU2EsZRjO0H/UXDPmdoV/0NiNBxsBKjDc/Y5jBuzMAQdgyVY9xphIKxKXhEVYYO6LZC7At1h5uo/HcGKndYCh5JLNW00YsK1HK4diz3Yj9Uj6Jx3CgEr3GvdVeK13bcY60HQhoWE0xKJ4HagJHQiEs1+Sqy4bEoltGpA8sdicnBny8JTfnxg2wqLP+3DD/kHC6rcpNO3MJ8OBcsE8y4hTlPHKzP/lxwDmvVlADiTuk509BHZ/A+c6fx2luNj3nxM/MwOWWRivTQpBNDCBC+oKcwr2K1oxxW1LDjBL2RzcZ1hRNn5tveso0Fv1tSqEG+kXD/r274hcE9UYs5bAeoMlFWUhSlLaLuicHSnfIWMDZFcbjd5i/V4F7QltJK6AaZpI/Lun8jH9ni+tfdDidds0cqyTKMuWJDdep09Ij1Z2tAp+TfSYj02Yi+ZzVQ6qq/LD18PlKx2WcvkZBJNL10Iovg/vuHthejQlN5zBjLEi7chAxzAmKar4iwVaUMvZo2eOUF2lj7ig2KwplGVP1o/1+mnU6UqHVoBAZa6JbehtoO6q4dmY
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(56012099006)(13003099007)(921020)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TuaNN+2fLP9m0CsmxhIUxJfWzWXNCdDV9YNAIbVKwc7Q0TiuLRm91nmtc1W5M7wmNrTHUq5wE8fzivIrfeaLOuLbjtWPfCHki2GDUDMzaUtzrfh6WC9HxlFyHDSo9/gxiINYuvMy7ReRGrb612xaT+Q6tI7J642FXfbqZ0asT5zVjg5sUN8Ho5og4u0xwdFiSdxxzf346TeMaNcZKOidsi3KuhPwrQcmprsYajZRAIq2GtWle0t1O47Nc5GmHHq9SUrfzHgr5QyztVU9x5vgnNlVmn+OEv36tWPMs4oE5UfmiE3jbWJIuuTJGFC18+TvV5vLoTEV+gP878jDWtNNBVOhCJL0WsIqM/poCPJ/MgGJRD8V2iIK0/Zym+IfI4BV2enP5Ot9PK8O7PPAepgfUH75ZeRse9zcqPJmfWWVD7dO0TX8KLYgOFZQiL5ihR/H
X-Exchange-RoutingPolicyChecked: kzagZtgIem+u2I7Snn58cnici/VblxgTjRrLplzsN0Gypz6G+qj9s9LKH0Q4+q/IzX+q5Z4czeM1T5K/zWG5KNaAL2DBspVbsWNmQu1Yu6kYu7QHV87Lr9dGOXy1D6ZVNKdPO20SJpe2lHIfRCunqqN3lvVkloHsaRYt/Wq66MJwBTwaIl4gPv5HnLLhnJIe4I6S5yYcsBIGSZR3L7jeJq6njp/ImH8i4IFW6CfPxvTaD5t+WyM7oPiMo/p5mjxylKi5oQ6AI5RrdDQBoH4vU74l5vkj4gdVkNCHZYYC4Yl9NXEUwOB8aWdr3d04w9VO8/20On7r+97MgJJpTg4GNg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 20:17:35.0982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 079f85e0-dfbf-4a56-1686-08dee69befe3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4448
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIyMSBTYWx0ZWRfX84gXxE9qwoAv
 XyoE/k/A7VMXsgntOBd32TFQJI/vrYRBu9t2JALcq4jl8d8mayrjqgUnXaAMnYsVfj68SRedAT+
 EdmasTaLBPd7qlLaJaAqrKvuiCi0gJE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIyMSBTYWx0ZWRfXxt3b03nSXWd+
 SQIMmTlx91FbPp3wi+RxoqXMgumEfXj/g6lP5tzldAjBVYvMvBASdfiF7fEY1GYvSIZ9q86LrUA
 YM62IUMWEFiJRrBYFU/TsherLLtFtpcQo6VI6MHMfZpZ5gy4wfzZwzUG9yhnkA8RINl4USE+zuK
 i16UGcQSwxLdIyZn7VgSuNcWtfq4qL63uK1wq/H98LEu7bT1fNXpC1t99Sh5gEajD4ZWldEViVP
 OQgY85QXZApfYBGl5XQDcBbPeMD6xRfdWn8z6S6IWiLiaKGVf9KRgD+02IpxdukMi1KbrsFRU//
 1oNE8U5icD30KZqzUievEK0D9scXWwCSxySnsyfwf3PHc4va7WqPMGnOBNeW4JHz0NW60it6g01
 SQvTjXO4H5nfSDjbBluCPmCYV7VNG+mFS+lGC2evhBQV5kwCkYKey77Vs18IUneM2CE9fTI/mmJ
 IbKA2FHXohqRLqaw/dQ==
X-Authority-Analysis: v=2.4 cv=N6wZ0W9B c=1 sm=1 tr=0 ts=6a5e8264 cx=c_pps
 a=EPZJxM4MYJNUcCtligPUUQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8 a=fGhLjsSNAAAA:8
 a=oX_uPFj6TbJlzFLWTcAA:9 a=LYKFdyShAPKLkGq8p7WX:22
X-Proofpoint-GUID: 6n_WS-6qRD7jN5gniYQh7lnq3LsosQOR
X-Proofpoint-ORIG-GUID: 6n_WS-6qRD7jN5gniYQh7lnq3LsosQOR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200221
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=pfeR4YwuHOk+T
 9uX9gZrM6Y7WBW79WNQHdwphboexC8=; b=F572bypIaPLXnFSPudN7Xs7D8RWQh
 9wnGhv6l1y61alfOpPrZ0kSsdx6rQ+YYQ3DdomUgpTRt01xrugicCMMGiVYCxb4F
 iD6ZsyZxYpZYzI4BsiRbTbHVdgl9bQU/YrR8j8g4SGnOOuJLLdYR3k8C111xeQ+6
 +Sn9pkenju4TBbUoRFtspwe8THOOVPpf+1fzuM36jN/Wb/t52iMUhBBoca6HSOHJ
 h9a5OIMKsqeaGyYE/BuGKH4GcnrAnQffuGZWlQhavAZi1UISHLp1ObMFzv8R3IP1
 ijyILGDITtscl7FhYIT38yRCHAHysx9+Yl6HB+B9yAGPoAbfl41TGnsUQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfeR4YwuHOk+T9uX9gZrM6Y7WBW79WNQHdwphboexC8=;
 b=WlxezlyRBzbKLAVPao0o2vVQdBKr5+KZMEEMmkprczXt48ajyPI30uVR7FlemCcAqh5xM2dMLHjMWkIHdnhx7o64G5jqwZo7dacPWE6gOHZBA32tqSnIIeixwmSl73oHr9krZU8882bem2P4kvm9JL3EsLq3pPomiFf8dxEYy6A=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=F572bypI; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=WlxezlyR
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
From: Randolph Sapp via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: rs@ti.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Randolph Sapp <rs@ti.com>

Since it's been decided internally to follow along with what Zephyr is doing and
make a completely separate device tree for the 1GB + eMMC Industrial board, I'm
resubmitting v3 with the variant support patch dropped. We will circle back to
enable the Industrial part once the dt has been accepted kernel side.

See the following link for more information regarding that decision:
https://lore.kernel.org/u-boot/DJLTHZL0ERIG.JV1UL67GFIVJ@ti.com/

Add initial board support for the PocketBeagle 2 from BeagleBoard.org. This is
based on the current official series from Robert Nelson [1] and work from Bryan
Brattlof [2].

Now that the various memory issues have been resolved we can clearly see at
runtime that there's an issue with the current device. One of our reservations
overlaps with the u-boot stack. To get around this we'll need to change the
relocation address to something we know will not collide.

[1] https://github.com/beagleboard/u-boot/tree/v2026.01-am62-pocketbeagle2
[2] https://github.com/bryanbrattlof/beagleboot/tree/b4/pb2i

Bryan Brattlof (1):
  arm: mach-k3: am62: add &main_uart6 to clock and pwr tree

Randolph Sapp (2):
  k3-am62-pocketbeagle2: add initial board support
  k3-am62-pocketbeagle2: add support for efi capsules

 arch/arm/dts/Makefile                         |   1 +
 ...> k3-am62-pocketbeagle2-ddr4-1600MTs.dtsi} |  92 ++---
 .../arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi | 336 ++++++++++++++++++
 arch/arm/dts/k3-am62-r5-pocketbeagle2.dts     |  35 ++
 arch/arm/mach-k3/am62x/Kconfig                |   1 +
 arch/arm/mach-k3/r5/am62x/clk-data.c          |  19 +-
 arch/arm/mach-k3/r5/am62x/dev-data.c          |   5 +-
 board/beagle/pocketbeagle2/Kconfig            |  60 ++++
 board/beagle/pocketbeagle2/MAINTAINERS        |  10 +
 board/beagle/pocketbeagle2/Makefile           |   9 +
 .../board-cfg.yaml                            |   0
 .../{beagleplay => pocketbeagle2}/pm-cfg.yaml |   0
 board/beagle/pocketbeagle2/pocketbeagle2.c    |  84 +++++
 .../pocketbeagle2/pocketbeagle2.env}          |  20 +-
 .../pocketbeagle2}/rm-cfg.yaml                |   4 +-
 .../sec-cfg.yaml                              |   0
 ...onfig => am62_pocketbeagle2_a53_defconfig} |  25 +-
 ...config => am62_pocketbeagle2_r5_defconfig} |  11 +-
 doc/board/beagle/am62_pocketbeagle2.rst       | 279 +++++++++++++++
 doc/board/beagle/index.rst                    |   1 +
 include/configs/pocketbeagle2.h               |  39 ++
 21 files changed, 949 insertions(+), 82 deletions(-)
 copy arch/arm/dts/{k3-am62x-sk-ddr4-1600MTs.dtsi => k3-am62-pocketbeagle2-ddr4-1600MTs.dtsi} (97%)
 create mode 100644 arch/arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-am62-r5-pocketbeagle2.dts
 create mode 100644 board/beagle/pocketbeagle2/Kconfig
 create mode 100644 board/beagle/pocketbeagle2/MAINTAINERS
 create mode 100644 board/beagle/pocketbeagle2/Makefile
 copy board/beagle/{beagleplay => pocketbeagle2}/board-cfg.yaml (100%)
 copy board/beagle/{beagleplay => pocketbeagle2}/pm-cfg.yaml (100%)
 create mode 100644 board/beagle/pocketbeagle2/pocketbeagle2.c
 copy board/{ti/am62x/am62x.env => beagle/pocketbeagle2/pocketbeagle2.env} (64%)
 copy board/{phytec/phycore_am62x => beagle/pocketbeagle2}/rm-cfg.yaml (99%)
 copy board/beagle/{beagleplay => pocketbeagle2}/sec-cfg.yaml (100%)
 copy configs/{am62x_beagleplay_a53_defconfig => am62_pocketbeagle2_a53_defconfig} (88%)
 copy configs/{am62x_beagleplay_r5_defconfig => am62_pocketbeagle2_r5_defconfig} (89%)
 create mode 100644 doc/board/beagle/am62_pocketbeagle2.rst
 create mode 100644 include/configs/pocketbeagle2.h

-- 
2.55.0

