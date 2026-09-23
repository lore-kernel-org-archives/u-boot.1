Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8208AC982EA
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 11:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C77D60641;
	Wed, 23 Sep 2026 11:21:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2XnAWzAB94uP; Wed, 23 Sep 2026 11:21:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6C6AD60752
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790162508;
	b=FvdqdexO2fx55EnpSq2cMOUfGUAYdH2cG21kLfWgvnecZ5aOJYWD6BZS3A/uV0bSsWJH
	 JB9IxfsLJVBvMjXc4Qq7FGzjgolfuxK+vWJz3wOIfexle3Ekq32729obXu8jTG9BcYIgk
	 RUVQaYXQ/5QKJvO/8xXW29APE5EwaCZmhZL4JMTnfunfm6ACSGtadK8uFWuHlcU93D1+l
	 lHKBHWbW0+nbAWpuHt6caLlfkXN0zsCAmn9kan7c1kvwh//3S4XOKEmxxi386+ZEaUOWG
	 CbgJtMx4axMA4wv5QEF4fQ/higa/wjRpM6WLgZUDLdgeXiV1c04xglu7uyDUbI9fcCA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790162508;
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
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oxGT18N1jnkOGhMcW1SbOiUnV06w0ePV2CE1k4XNzJU=;
	b=SC/eIYwGi1qVuhR0TOGUt66qECRbD+awaqnrGpJVXhTNTz0REy6v9TQYwaCWwGfjFtVr
	 nyhtd11aZ9C7rSadOtkggG8wTLolbgQr2QBAda22IoXLx9D/RVe134UoMkF2Fvu5LCiWZ
	 9+EUOZxImahfL7kf2UI51wwPmb4yni72i897sizZjb6rcADZb7Fueyo09k+B3M+KQSzbC
	 OrEWjgYd9CyFgTs2bgs1U0zC6mVFksJ0ylVit4jO2/xbv78K9MUzO42DjLBSVUlK4cfXP
	 P9Gxux5xJDIPMN3Beop8okruZgrklB/k6j5D3tSpvv6ijLOMckESMx6SJMJFCtVPTQQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790162508;
	bh=oxGT18N1jnkOGhMcW1SbOiUnV06w0ePV2CE1k4XNzJU=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GtAbb2lm1rBwa0Cnfwrx4FWNsnFBZA1ZLJJK9lsrJsSY7mYmP8PBnkRmRYMRs7f1C
	 Sp99pNVlq4EQ/AhmvNXZF3uGWpMCWQ7GoaFHpm45+9YUkPQfPkpx/n3VR0m77SauNx
	 g5iXWfcC96hSp6vY20jHF/djo38BcIe/oMp4ZGIhFdpcqI1RxgMfv9fsdWRgf+Ts2N
	 ZVJqq4WYt8br7F7cpB9vcZGsVoPjJzjKucVe3yqeGNCo7ory6eMqd3DBo6NTbLkzzs
	 RwhAHpyic8SPppf9oIHdV4FE3nSteIHIdt/krsYrCxgI46ef1BmgqSUo6T9aYbnJ0C
	 xd+wu2KEE73zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C6AD60752;
	Wed, 23 Sep 2026 11:21:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 51676194
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 10:07:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E3E2280ACC
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 10:07:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2WW6dria_5-g for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 10:07:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 825DC809B4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790158072;
 b=Jrq4Kj+pwBgLz0v9WKNL3Z9krjumc9mgw6GCKk54xf+EYeZsCLKAWSTDbTL3PBgrk1PA
 LWUYaSZIpYWohD52jgIAP6wggAd1dOEIUXsVzKofaWNKqoo6LvnthLrO7QgFUCKLD284t
 FO/GtTu6QivZ4QfyddZiHls5Ek60pXqFEFeI4A9lulNMhPeTXtxPaLjBjHqFvCHqBzONX
 SyEIvlTD1yQ6kvtj/+3sp59+7ZoshApMjvQJZpk1hfLPy9eyDr486XtGw4ABIVXRKmH2Q
 XPP84LNB5n82pq3v4l0Z4H/eHUDN/VlahRthfc0isry6TL/UM4c3sjGbKM3Vatc8+5g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790158072;
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
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=oxGT18N1jnkOGhMcW1SbOiUnV06w0ePV2CE1k4XNzJU=;
 b=k1KoXFothI3xy8d1AGco7ZzzDUVd+JFT/9Z0c5EIrxr1zWCiPIzyfvHmdF2XCX0SBMJ8
 z3/EX36DEKWc5En8U2/xY2h/pEIQg/J2uFW9K/qZfTAdj71tgWNquVr55WyuuYc9ZdUxB
 UW7k8h5NHfmXAPs1ALOdSZuqEIkSoWIfA95HGMFNlNW5uY2EoNRSfy4QwKPjj97UiaGvH
 JJIl6s/K8QL92AfxU0R7TSXRem/4feCwo6Pk0KqjVn6nXVRtN9OadNPBwiSwcXt82OAlx
 0IdEmUWq6aQIwksztzDKsYUqfPDDcol0Bov1QT76QOyoxWgztDI4YAhvtZ3b3divRgg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=oRKvSaBk; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=VjgFf8u2; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=a-garg7@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=oRKvSaBk; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=VjgFf8u2
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 825DC809B4
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 10:07:50 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68N8JI8E461334;
 Wed, 23 Sep 2026 05:07:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=oxGT18N1jnkOG
 hMcW1SbOiUnV06w0ePV2CE1k4XNzJU=; b=oRKvSaBkG9eDBqGGo7K9HhfaQpQax
 6I1TCFEcUSp39kj3BP1Jw0pJbzQaP4g8CuDXLGOlVlSIJodwi50pBUIaHfF0Aqoz
 SoEqrm+6QFSWooM1V6ogk7jRMhCiPr0WuG7Ltsf2OKssSE/Vv4S9KgpcRs3gcJwz
 MgDInOe2Dqg2dzocCbXqg1CWoVpVEyncZoAXm2FecUUTR2XbRWBxPeezZ8ZnXyGY
 WZWkw1ReaZKd4C4FhROFjtaKt0iB6Fh8PtTE7itkEyLmpHuzrvXjaFk1905hMLPs
 MYpLHuAkLCzEinAz0e/lTTEFsjgxmtp76o4ryHsiFsgtuWuHDuO8xhLQA==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013053.outbound.protection.outlook.com
 [40.93.201.53])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gv3tsb1f3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 05:07:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEnEYhpo8EJqtvjgPHZqYcYuZy6SdwpZsit8KUpslvolFiBsv4gX1oYyTTUub02dbDsxWu2pQmzDuT8bFhHjjguZj2LKt7FbH2YWkIbwL69kh7AQ1KEBhixvIAtf03tq1/G78VsT8y5eLiqxwKc+SlebdCTWgztsk/R1VMkCRgOCmDMba6sBVumjJQ6VHJqrwj1tXWHlm60wC/AEiNhDv5IH5gOGIDIGkmIiPUJhrIkqoyD5B9oTBz6m/+TjNkuR4z4iswsHwdW3S5I3ug3XjTwXbYaMM04wdCvDRsVe4OcBLx2Q3F7rMjdDYWZYhs8+XbE9JX3MatcUj+/e6+oxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxGT18N1jnkOGhMcW1SbOiUnV06w0ePV2CE1k4XNzJU=;
 b=pt1FkB9hQwRpARt9/Rb/Q70et+Q4WwDy5AT5QmvM35Q3NWsSKDlOwRh1VNGigCir0daW0Yq09o67vNhN44xK+McIfvd1Tna7wNj2CzkjNWgZ00W0L8KroCsDG1nJ8fqawISOSmH0EwO0Uj3tYuG3VonojmSj6+dwTBfFvJeboeWs/KUOSyzkLv8woYpRJVi0s7Z/q1y2ZxKNywEo/QN0Ekc3drY5vA85cM2e081PQ+7571BONBITi0GfLq6gI/cncOV+224yAw1U73D3qL3c4dA/2v2b2tfLASA+hgYejWwB0B7rMDDizwdlxn7GzCVrgTuHUEJr0Ny7iYeonMaK4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxGT18N1jnkOGhMcW1SbOiUnV06w0ePV2CE1k4XNzJU=;
 b=VjgFf8u2rg84qCi4GbQvvenSzZBT69Ti0Ao61IeCnNV7p06b3zhkUVk/1wI6ns8ZeXY1IvSzdep0ZoBl9cp+smSqvQF/FWDyrXlW4o1upHJvvjxiqgQFiR5jVi7J5KyrNDlMuG2O7Bikp4Ct6DyXM8AymQRr7XfptldEb0piQiU=
Received: from BY3PR10CA0025.namprd10.prod.outlook.com (2603:10b6:a03:255::30)
 by DM3PPF1BD38130F.namprd10.prod.outlook.com (2603:10b6:f:fc00::c0e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.9; Wed, 23 Sep
 2026 10:07:43 +0000
Received: from SJ1PEPF000037AF.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::51) by BY3PR10CA0025.outlook.office365.com
 (2603:10b6:a03:255::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 10:07:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000037AF.mail.protection.outlook.com (10.167.244.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 10:07:41 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 23 Sep
 2026 05:06:59 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 23 Sep
 2026 05:06:59 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 23 Sep 2026 05:06:59 -0500
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [10.24.68.129])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68NA6tOE2700733;
 Wed, 23 Sep 2026 05:06:56 -0500
From: Aksh Garg <a-garg7@ti.com>
To: <trini@konsulko.com>, <casey.connolly@linaro.org>, <dlechner@baylibre.com>,
 <stefan.roese@mailbox.org>, <peng.fan@nxp.com>
CC: <u-boot@lists.u-boot-project.org>, <s-vadapalli@ti.com>,
 <danishanwar@ti.com>, <u-kumar1@ti.com>, <a-garg7@ti.com>
Subject: [PATCH 0/2] Add support to auto-probe Torrent PHY driver for J7200
Date: Wed, 23 Sep 2026 15:36:52 +0530
Message-ID: <20260923100654.610596-1-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AF:EE_|DM3PPF1BD38130F:EE_
X-MS-Office365-Filtering-Correlation-Id: 243bc421-6003-4ac3-f01c-08df195a8170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: ovq5zocl4zhyRIRP5dkGMZhhnxTbqNfmmjdefoeaBZglBhw7AETXxeRQhgAFZYgRFAmqJNfvm71SGpXhxNPsza/TfzaixxjgyzRllmIdlkpTfHrMiaHmC+kIdeCjB8tT3cCHMyJY4D4PO0cWbE941X7UaKpguaNGHKJw6xGWlziEsaY4S0T8PAUGmXG9meke2HUKrwUP3VGG/BF54fk0BHAE9q00JP+fE6UWROiEPE9yo2RZaAw6azKU4vYpNaflYqtgNqGQhBGnYgspKi/NvWenPr+jw5Xv8nMVfAfBw5NgPWYauLCPVvBdxBbELOP3IDLf0eDy2WqmJ1X3LnHsCl3q2ge9Nng0O6NSjNi7Mf7dstDHMCcEkbM1JCAZG4s+zSKo3ZtXA83GYg5334ktIw2LcNYODZNrNwt9viG77eQto/oI5Rn2Z3Gn2HSH6ez25eQzDmjMccozBIr9AVHBts5MdgyD71sFGjYUC/1w5LMs8bobZxO2jCLXq+bwsedX3KRRgdwhxn7Ql0v+aniZcCIgn5WEybC4itTOtMDJid2GkKkuZ6ZYyl522gDWzCx+M5yQ77LnEHl8B4Kv398EDyhyzGuI7CzmD84vkOrvuK8OwRvH7zqsYLnbvmk2olI/CBgwZZotr1q2t2LFiApT7ax+WRPY7dgsmWw8EKiS44IxlfjRH5EDuS1e6vo1shn3ePycKeCljeM/2jtv8/VEtw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mmFQNqozBY7oI4+ktJyUHwVouQJFXYLmJUEHxTQdLcktWmTu3Vudxx+I/CcF8f85IYjdLwGJx3cfSN2B/Yrq55WFJ2gjZtl+JOLN4CoWXmLhBPHwQLCpfWy1l1LUAJHpmph2NDQspv5IvRpOnH7Kl9nPIyPKSQkvcL/YiCPuKdlPmPEQh8QwT+UimPvJEh5Wwmkkoh6EVIWdXLPWQgo4kNyW3OPRVD04Hlgl8Rn2F+fmHokhRmIeqpF+Hs+6LgRDF5LwYBDsl3eCviuOHk+RWmpk2L/1RrxyB7wS3Qzu+VsTrNSKdIml1U6msKlNJVSaP8zu02pSSnl+quSRPhdoE2u8wAAKe5dvXwNFfO14Wl8kDBetyQil54gmkUV8wJxlw8ZQp52TJIoiEeRr8DeF9eakk8YP6HknAmMWzeYcLL+4yDsSFMKkjBfOr4keZ+vA
X-Exchange-RoutingPolicyChecked: eZdq6NsTimhW4RJARVPX0nn2eO16yQ1eBbiUbTljZH+quZ1IcZPqvLGGKbsIbU+SLalx+YUIYCPvyxMA//NJgSlZADtq3arnWOepSl1PGpW7WMHwBg2/VNPKepkZ0nJjwwXPByd6uJCUZe2n4DTKVfX+6wyZzKlLDSgjNtllrDp1boqShZPGeEsEiFT3aKm8BZIxyiZwxIX2p7vWcF1rDey9ylzfDg6SpN29rHzvh9avIMx6IxDza1X/m23zVtW0TUMsQe5J54ZhovRoPgRAYMYlHqFlVT4ETpaYV5QkNgG0DPPUPaFeJboWUhrL2jYGCoMv2cQY9ipDdr3LZQhCTw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 10:07:41.7615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 243bc421-6003-4ac3-f01c-08df195a8170
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1BD38130F
X-Authority-Analysis: v=2.4 cv=INaXmQvG c=1 sm=1 tr=0 ts=6ab3a4f3 cx=c_pps
 a=IxQEmK7OG+ZB3KQxmUR4Jg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=ahHIu24bQKgjpsI_MQcA:9
X-Proofpoint-ORIG-GUID: pEcBAiF4Ca_eCR80VJTf0MsCUSPJ-fuk
X-Proofpoint-GUID: pEcBAiF4Ca_eCR80VJTf0MsCUSPJ-fuk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0MCBTYWx0ZWRfXxou92k4mmv26
 3iTL1iXtZRQju/rU3ai84Gyet65IgpqUc/gmxTZSVlNh7phYjP+FjE3y58T5m91n/HBRUK5tcZ/
 dViTJ/oMBDdczwSzpC1waSCOnzRWe63z118lvfSxxBZQuRpuxSWo/rch4z9/rSycApNBO53S9b8
 Pl9N4Jhf2LYGtgctA900/HxbfgIvlOj5+x1WAL2ksFQPezWguk20yJC1LFDJ4UNwsTFC6DPR8eA
 GABHjj0itq2bi9ZTe/ad7J3dZLsrlKNmHQakHItAszvGEJYb7K/f0MP6GeBtJQo5wwLfLaNrzF5
 UEfSlwZagMCABdTMh9njzeqY6ptEAL6swU65vkHelM6psCZl53HPnTXpA1m9GHTGNUnYBahUJqc
 ff7N94z+TUVWCzW16D/f7s/3F8kG1UzvVtWoD5VWrH9m1ryH//Mh8m/sdv/sPAnCCPSLvyZayV6
 QCtPQengkR/Cvt/te3A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0MCBTYWx0ZWRfXyHsagAnwAcO2
 +GhoGNlmhekGVrDaZGPj7lXwCr+gH/xC8RuHduJWtMpKZsSz8cS0UE3JOvUs1IcQa9UJK50x4ev
 8tTZDXo36vxCAeHHX6IeKQbiCeVWeMY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
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

J7200 requires U-Boot to configure the PHY unconditionally after binding.
This prevents any rproc firmware to configure the PHY, preventing
multi-core race conditions.

This series adds the support to auto-probe Torrent PHY driver for J7200.

Aksh Garg (2):
  phy: cadence: Add optional auto-probe support
  configs: j7200_evm_a72_defconfig: Enable config to auto-probe the PHY

 configs/j7200_evm_a72_defconfig           |  1 +
 drivers/phy/cadence/Kconfig               |  7 +++++++
 drivers/phy/cadence/phy-cadence-torrent.c | 14 ++++++++++++++
 3 files changed, 22 insertions(+)

-- 
2.34.1

