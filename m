Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4D9C55822
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 18:03:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EADF64052D;
	Mon,  3 Aug 2026 18:03:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gQihDYwChGjK; Mon,  3 Aug 2026 18:03:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4F149405E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785780223;
	bh=UMQDkXwCuWGc7ChfcMUOtvJRxnQ+JkFExHbUlANHQ/I=;
	h=Date:To:From:Subject:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yf0UAXnOcid2JIdpJia/LRUrzb3jOX+HeDBklU3jzeYwO5sEiRKiTyFJIgML5kcPJ
	 H31QX3Ot0IPNtIePXcygZkOd+A94kwPFypFoDoxbXc79t6FsCXVj4wqhvsLE4d0HmI
	 oE2s3hhq637/xOT6RSNkgbYIICWa+mEo01J12IFXn/xgq8CjfYRMXYXCL5vK6WJoVX
	 T7pNlHJEjdYWNFKuh3+V2H8kMPvfc4KjTJYCGVKY/xvl/BrMR+fvbODZD7HRd3Dfbw
	 t9H8b/+FkwpTEtemkXvwlIvKsO70WuqwGqZjN/x8h9KQ+Nu9J23MUKzQvoUsIEWMSj
	 UGVPYp2ugeznQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F149405E1;
	Mon,  3 Aug 2026 18:03:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 64E722AA
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 18:03:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5A1A4605D9
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 18:03:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tfIIbljE3X2Q for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 18:03:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=jm@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 23126605AF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 23126605AF
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 23126605AF
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 18:03:40 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 673Gxxa6233313
 for <u-boot@lists.u-boot-project.org>; Mon, 3 Aug 2026 13:03:38 -0500
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
 by m0380145.ppops.net (PPS) with ESMTPS id 4ftsxpk02g-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 13:03:38 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnFxR0925zF3KbdFD34bO1pACrVMst2DzLvq2tFFfu6nkjx/2ntrlETnqtc/KUoub842XSqHi24M06Pa3NK3dFn2kvJgmPnfl4I2CUBmS35jy7oZWJolzHCamD6jK5v7bNj+uRLILficBervSui/TXjVKj6BeTUM4OXCcKBqjiv9Lf22gYVV4jWLqgrDLjoxhmX/9pk13E7hokgzupyjOXufWnzqaKuUVlmBcUr+exVj2ZqL8MpVqxo41U9gzb4scP297k9ZlXrFTGdOvI2o/oBH0a+2uu+OmpH5cAt0pjma/tryxLFREBGZTc9shni5bhXGv820Ql7c0lo5jeOcIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMQDkXwCuWGc7ChfcMUOtvJRxnQ+JkFExHbUlANHQ/I=;
 b=cDvbXweWt6wKTtuDQgiE7wD9dhEEK5JvxIX1tsSSh5TAzF9lDc37C1Wpe3f37RzAxELEmd3Hntdbu/0JgJGFa2QkgOD2Mnjz6Y28DiHiAQ0ORJWDVDcS3+67OFY7eUVV4kX7mNAPP+bcq6tzGDNCMDK2hL8O+n308mkqna58d/nkietjrCRls7bZ5PAWbXSbXJnJi/CXfbUFIw7JvpsApZo2qbnmnfs3xl5NCdzFh/jN32THg+HJ74K6iarP/B2leXiy7gKEvTu5ejBe/NTiyBO0ObQ2W3B3GBcZNGUDOTQYvozlUfRdjxWe2DNLSarJP79KxcY0XL8lxR6GqsWsqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from SJ0PR03CA0152.namprd03.prod.outlook.com (2603:10b6:a03:338::7)
 by BN0PR10MB4872.namprd10.prod.outlook.com (2603:10b6:408:124::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 18:03:35 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::1) by SJ0PR03CA0152.outlook.office365.com
 (2603:10b6:a03:338::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 18:03:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 18:03:33 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 13:03:33 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 13:03:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 3 Aug 2026 13:03:32 -0500
Received: from [10.249.34.24] ([10.249.34.24])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 673I3W8L2951088;
 Mon, 3 Aug 2026 13:03:32 -0500
Message-ID: <ebe8b676-519b-4c89-8214-489801cedcd1@ti.com>
Date: Mon, 3 Aug 2026 13:03:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Moteen Shah <m-shah@ti.com>
From: "Mendez, Judith" <jm@ti.com>
Subject: Re: [PATCH v2] board: ti: j721e: Fix up eMMC OTAP delay for HS200 on
 SR2.0
CC: <u-boot@lists.u-boot-project.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|BN0PR10MB4872:EE_
X-MS-Office365-Filtering-Correlation-Id: 5833569d-8591-491b-a453-08def189888c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: GOb/J/OR0aDX87B56UgYyWTxX1xpgHAxvuEp17feUnvYDAi1thI9bzHR/F3YRwiN3Pc18iK3w2qFR63x+1GhwXbd8hKIykEdtX2XTVZe5M6Zv6WdIBsqBPuAE78Dy9hxMoD8EsBVmqym6SjSfiS1yQ7HKFbapL0ZLIQ0lKz2U/vGS3bia0X97IxLMUVUw23j4CHr9fKtM/cuoNtKRnIqJknxXXp9+YzxAWOzOsEggoFzWPUiSTMKeYUApWshdc6A8g1dkLWGnCAjdhFQDx4cflYwritfRXiVVY5EWn6qXY0kj40rK9RD+fJlDXMwX5u4YezfPPQEjU9WRVC+f4kdL8qGVS0IpQR/xidCsAygb5dYnLn+JXvBGKE36exLHk9Xq5ngo0mO6iPbPDwwNCPGo2Kc3C1kBvfUXTVi/Au+IDBJKgQe6QmkVEaG2o85Y41pv9SouG0lDH9Vb5vYb9tPl3CTyOUEwUIXRj0Ph767UkdGM/LG7nfM7B4UhxvYSeO9nhiq/Gfo3i4U6XeUKleu5GdT703xoT6gCvGkeuwtb2DZwHF1A22V/wjOcidkIRLls+hT/eg/jE0frIotP/StYbOYHkpiwgCI/OmtId0myJ2qSPDBNtwXCIr+Fok8Gm0/MpVp3/+c4ETjxHzJUQbDJHOrgdbFEpHlCpC22XixPylIp68ZZcrA7Ds9Ue6mizFC
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ynFe2CLI87M+LPN+WwOW4Jd0KznkVtiRd5qQB0fy7VkzfvIym26y5TXhr31/z5KYIR+XRSE+6Ahb1kJ+jggW1ZzBhmIImPDEqLwHTL/gbwfIiKAGOAcVAdrwpgBBVQMJmxQdqqa68Xwio0cScO7kNYQThK6kxmpXpD9jIfTf3NuFtmSnpjnEUshJbfwfX8jRlHcg4Z87tiIxMDvLxq9022lwtALrV9+ewLNcZGrOuAY9hNGbDKlCBba9GqBhMEwptFcdThOBPLa7qFgV0Gs+VWROcYr/Y8G9i/yRDW3ydFR72LTq6pH8PGuNppmB9vOXmFXfUJLC4gukAfJt16jDjB3ByrOtC43MQcouTH0qXuD+mWUjlZfOSrL6BFh+U0zwI3ruDAcWioKgScCynpI2a5OypQ0y1ZoEcpyN0KdVjIw0T9FUfmCZCOGG3Vt3MFie
X-Exchange-RoutingPolicyChecked: Z9kZAi4FDfzi6yeSkDfFVH/iyTVRnxW46cfN1sDGXPFf8l+sLLJu+T4YxVeoCDaGyt2waM44lS0FVlTfeUYXKwc5e+jpqSGnMOO9+l+EkPSG5m603MZYJv0WFuq3xpeGBIxkbAmiErb5Sm6Gk11mEdp/JO/THRNcgWoPpsX1WPew7EWXUofoPMGqhpPjeEs3705vM3TN5i0afYwxNrnTyHZyq+wdR2YvIa8Cy7U6fyR6+GVG3jc3GMpFzUpcVysAXIfFqBHIrz+cKxflvewdz0yMLRWrEyO6nvO0sHO3A2oQaDap0obh2HvrD1ZwUBF7JkPqrmku8HMCnkd1GG7Jng==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 18:03:33.5684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5833569d-8591-491b-a453-08def189888c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4872
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE2MCBTYWx0ZWRfX7P3I/tXGk5OM
 h0YQ6LaN/AfKas+GMB/TeFaVZLunKmiC5117CZsk4KNaZeB2654Y7gv1z/zaRsijXb3Ir5IMd09
 6oCxdqWeULMfn+1W97RwTPcRxJi5PJE2RbTNXdCDL7UEMIUe/Rqp/nLg5kfgKdBF0ihSIUwQPGX
 t/NEUfS1XdBy9GSOSPbkYY7FZIHkvD5W3lI9ckE1daT/r8FN7V14yf9VbBqCBHOxLklMjrW3Xi1
 iOYZ//Vr+XziK+/GDBgewIBBEemrF3j/BpNp8T5kzI85z8EYqUjbJdr/NyqqAbmgbBHqXvHNICW
 GUDLYxJrAZyeJUvk7T28CvbC8iomP/nx+AUJt56kML2SJpN1BP3dkWc2RSEWDqH8b6LtXqvz2x9
 ytfQITkY3AsAQwJaEZo86Jb7cWJYrbegV4ZGEILjZVrIye9Y9MmvS/PHXG4ptwIusDPgglZFBZV
 wu8ZcsQ7fIhMNVEAqBg==
X-Authority-Analysis: v=2.4 cv=YaaNIQRf c=1 sm=1 tr=0 ts=6a70d7fa cx=c_pps
 a=mSR3SZoAu6sfRwd3OpsTIw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=O7BrJ3RYQFoS-LqhnCAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: g-IEmkYFJmcUFMXRo_ReQmxRg4cKE0A0
X-Proofpoint-GUID: g-IEmkYFJmcUFMXRo_ReQmxRg4cKE0A0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE2MCBTYWx0ZWRfX3MtySrzJSfPX
 FYVlZiB4fwYRlhU4PpVADcHESIbksRw0uRzUar00fReKoZ71rsOa9v1nN7Ke6BhtlNesojpSGr2
 AaehnX4H0bGZWkdn6LsfetOx7SS7eb8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_04,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030160
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=UMQDkXwCuWGc7
 ChfcMUOtvJRxnQ+JkFExHbUlANHQ/I=; b=cUvXEw586pC7Nm4K+0ipYnpa2Z5Ei
 vpx4KcNQlTXoYNNqz8Cf5czp+l/KlXwaWCd5kb57aERuB78QVB6zIszniPOhCyDT
 9d5EM1aw2kF8c+2A5E9mOS9wVB1LLB7h9UCZu0QlQOImB3rtyVbY5zb4Z0xrB/iq
 gz1i0gOjDZwU2RJMNAwFKLEbesQ/rlB98c32CJHURZoyd6PzAUlKcvs9U1oW7twB
 nxsZC0T1rYof30uHqpKoczpm5mEVj84TFbQlwCx/42SwaxmgnCHtO9Bnh18J6mlW
 UaNReYfs9qMi5iqyAg46qa5ScWw68k0K5PBnHKjRw+8Ncfglp2w+p2q7A==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMQDkXwCuWGc7ChfcMUOtvJRxnQ+JkFExHbUlANHQ/I=;
 b=CeQd7nlXWKYZYiNp+Wj2/akgWfnNg266wxrwFMBDhkxK3ZdGiofBoLEFjgHFjXTQSVT0tmW0IQVi35yM5qBg+354h9YnfDJDEEQSZ63eYkZlkMZE9XRYqYjQIbuBSZI2dAzq/jKTlkhHPOqGsYnG4yxyr5mSey6GW2lvQ4MjdMQ=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=cUvXEw58; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=CeQd7nlX
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

The J721E SR2.0 silicon revision requires an OTAP delay of 0x8[0] for
eMMC HS200 mode instead of the 0x6 default used by earlier revisions.
Hence, detect the SoC revision at runtime and patch the devicetree
accordingly.

Why are you adding this to SoC board file instead of the MMC driver?

We support DT tap delay property parsing, compatible parsing, and
silicon revision parsing in both u-boot and Linux drivers, so this
should live in the driver instead of the SoC board file.

~ Judith

....
