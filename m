Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47774C5DF86
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 13:42:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE1E080D91;
	Wed, 19 Aug 2026 13:42:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R9DqKxigEc9Z; Wed, 19 Aug 2026 13:42:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787146923;
	bh=kSB8lQxWx4AmtJAUgO/lFLgSf1kQ2WwAOiBa+3xY6u0=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PJBGh1VfuCK+2uDjWeqiEpYrlvOBDLD0Gj1W5t54SgLAoKTcQ3KLv//OfYsilwjns
	 04wxzx6zzOtJ9iobeeEYo6YZPrtPE/QhJHITcijR0KuP6vO1Y8Y33vpTTUxxJRUoWy
	 R4bpWmNalcrzAbhXyY9Hud2LhdQQwHUWjuLXojZ8ToNk821AkrQ5WR22f1CuMeirK7
	 nWGh0zTpDb+p258o4mg003v1hvz5J4CRY+D2CsMmeulCCsmG66cdlxjSda+r8K+XKX
	 /oZIJYF9V/+OVhVbgpwqXpQlQAeH8i0urixWkuzR4cuuX3Reib45IqkKJJGntoDSSl
	 kfJOHV11KyuyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1A1980D9E;
	Wed, 19 Aug 2026 13:42:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B28C2B2
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 10:19:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E47FF40607
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 10:19:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DJXS2vujMQZ5 for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 10:19:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=g-praveen@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=qMPgcYPW; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=mmaVF6eO
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE75F405D0
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 10:19:22 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67JA66ri2020532;
 Wed, 19 Aug 2026 05:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=kSB8lQxWx4Amt
 JAUgO/lFLgSf1kQ2WwAOiBa+3xY6u0=; b=qMPgcYPWKjyjsJVDlLJoJ7ktc8f38
 TmFoRvAdvTBoaXlfVkkUZb7oMxcrWZ516WDSHR9fvbLW4ACZWIwnCmkhVIw2/o6z
 y4al5BuPV3OcpMLy/qkzV21/emJ0kcYHGjK6Dph0R4lAgYBK4KTgrC2TrNvgsQzH
 mv8o9OE5R7flQOix9ODOqoRn4AWJvD/4VeJGjlvtbdkuA6nyZWFi83/cMhBowjhY
 AvRueVua80+grcxY9/rTKIY7UN06usnYlqLo/vfslUC523HeVN9wV+Sg83tzYsSC
 XVud0/JGpr+4oySm918wpFwFSMQwrxFUcqMXMpQwvKNCJPlOL+ua9qA3w==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011012.outbound.protection.outlook.com [40.107.208.12])
 by m0380145.ppops.net (PPS) with ESMTPS id 4g4yejku9k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 05:19:21 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3Q4FWCxCk+x4NskHq2G2o9cusynmPZGDvgH9BOm7iFAhPq6tlbIH1O0JyanQ+Gw83Tu+6vnks8bQ25u+6bGf49L+B4Gk0fL4Ka/1OlcUSlF5rovy7+l5EsE40bFccIoHnxL222hV+6r3n+2IRS1P/376FFQLrxmeBmxnOc83eAK9nmRBAJECkhifTKGMMHrnqj87lc99P1edoTsbmbKHswDHuVaFfVFbzV3grMCJNKV6XpQlPpwRbkYV5Gwpuf9fUUhCDPgHQp+Kj6UcF+jUlUC7808aqyXBJTQmZGJzZwQsipqt/vcAiy+k7EvUq2Sn1tHz+rm5BSO8CX8vJ8gIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSB8lQxWx4AmtJAUgO/lFLgSf1kQ2WwAOiBa+3xY6u0=;
 b=KW7DdD5nWjz9DVFSuy3NI8vUw0CwjkdZ6LnWUVZ4JhKGXV/029MAV2UVe6T45X7OJ94JYhy7vOxIr8Y+pqVF0cPCjaW5owHkvAUYzHJdGoZIh6/SB8HRIf9LRUdk75PeNp/lZ7/c6e9uUKxdvh0h6VV2lIZvathjOs2MCDE5lDbdZQZByQU78cPRcCgr8j1r/7dqcGR9gRZm3JK2IiBpJsvMiKcKDmhWMT2fTbxKqprkyEtAvyLeVudmvapcQcDbhnb9jF9H+1zeQLNlUBmStKUP3nVi608spqn4fHMSKBf8ETVMKWmfGMIeGmjKKr2LKjgK5kHt+ZB1kwfXrc2t+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSB8lQxWx4AmtJAUgO/lFLgSf1kQ2WwAOiBa+3xY6u0=;
 b=mmaVF6eOQQwv0v9F/nZ28pgMzJR+EUW+jGaLgagXcoUelxyxhZOg1CujqG/KJLP2EfgMPtus9ODYWrJkCapEgHPI1KUiibEQw9ZboJPTxj1lLCY60VO6E2XsiTtJxzMuXo0pGaZ12Cyg4OqbnGFserHgQi6PvJ+d68WItU67RgQ=
Received: from BN9PR03CA0712.namprd03.prod.outlook.com (2603:10b6:408:ef::27)
 by DS4PPF742908B79.namprd10.prod.outlook.com (2603:10b6:f:fc00::d2b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 10:19:17 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:ef:cafe::4d) by BN9PR03CA0712.outlook.office365.com
 (2603:10b6:408:ef::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Wed,
 19 Aug 2026 10:19:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 10:19:16 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 05:19:15 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 05:19:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 19 Aug 2026 05:19:15 -0500
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.154])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67JAJCim2149110;
 Wed, 19 Aug 2026 05:19:13 -0500
From: Gokul Praveen <g-praveen@ti.com>
To: <trini@konsulko.com>, <g-praveen@ti.com>, <n-francis@ti.com>,
 <a-nandan@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH v3 0/3] A-core no-SPL Boot Support
Date: Wed, 19 Aug 2026 15:49:07 +0530
Message-ID: <20260819101910.39192-1-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|DS4PPF742908B79:EE_
X-MS-Office365-Filtering-Correlation-Id: 63d2dfad-127f-4a80-9695-08defddb5319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|10067099003|56012099006|13003099007|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: zyIjIMDrWWnbo2N1v2+uID6lnC4OI3dvzG965nAxEDo3ikzUku4oU7j1RkOXMt8gnCOymNHsJK5CE+KicuVsAI02wPrK50NbL/K101STTA385NNJSg0HqWpUzSp7up3Ou1B2Ey8YpXkjTyd1rmQReItKf7I1a0sB1kGH08Y7AvwJMGeqdl4G/PHqol5ByZkhC5DFTpf9y+QRHL3uERn0mAMvwFentvqRVLxWtzMhkh1M9wAzz8oz6HJ1oubuMLEOJ8uOxXF6UMwp3LZhdiimsSXK5YL6CTX/KhJMwQbt1BewORa+IB4v+RfLB2R2O7ObE6NPEEL0BmeLzPwja4pM1WrRgbbgfoQjyBKubqBj8bnMrFd2zbJbT+yPBl3XV4rpC7AbJMjss6SgRdOibmp/g+JIi0mN4OxKERbfcqk0OrWnX2j9ddB2Bn254d/qC9y5Sbl0bCFCTihBg6IH14W1AcFg/WfJ3UUJsolPWtV7XXKXRX10YHfvcDibqWyxm+62Y5Pul0KGroUD+ujTC+URG56Iil7PVu+0L2yxKSBfmaMAwHc7127He/upmsIjsfpbD77FtIZ06wLZ5gG0JMjc4dbzIGEYQIknXoYt9mWyqwzAiN+SIj5ppejeFXIBjshxSWwftWsu73tpDPNsoWV6dpZU4to5TPEdjk60Yx6ebx5AoFFJWVkXwC7Q1Sm05wJZYaQWZxP9AdbuRvoyHNDowQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(10067099003)(56012099006)(13003099007)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Yn68OLqzRMfpJpwf38P1dRaGTlGxVL1upPHEuuhED/F1642UlkbBzbOqKsBlnBLlOhubSpdtrKtGocjcGK6Ese+DqSF6UFEQVwjsHzVbD75o2EhnBsbngj9sF7vRqB31frnhB/eWul6nEnMGRWszSOTkdiE5wn8YnJLiMU7r0DYskHVDFfSS8O6cwqM1Z0aW3YPfZmw9Sw/P7bTKxXYIWsNB+n3IOjYV5qTvlvd7b+t3YgKiyzXNXFUmoWLfNEGa0fksQshy/4HQvnmrn/lT5V2PBlmIeddpHGoiq/xmToaQREEYHncVPAeYRasQz3GzLdmkLeZmyihfHprLqjjlQYnd6tEHq6nyGWuf72Xy8H92jjj1tRK1BjAczt2Kbdm0EbFA9VPvNfnu6KG14N7C0a5nO6FllMrQbLhv7hhMoWPWlwLnsvjSjGxAbWB6zcJc
X-Exchange-RoutingPolicyChecked: EwGyRzLFl/hFlJy2Q8lC7w3SWMIlVhrroAnQkX+tNRXRgBbGMRv4sNTupF4IfhxSaE8zqhpUaWfQVMowjYFd46Hj3+GEOzjK2MfncmKl97PJ4Z7xgyCcv8UWAOLIHMeJVbPLkT19l2Yvnp9pwe0tBTmt5TeBZ6DWm6eoWNHoZi92nW5A1+SZo0PGGfcCL2vy6FX344vImYCGa0jsSfesN6WFOagRIZdBGJHyJxLuLYuSHuxgGKSj+PLDAURxT7vEH08LLmisdMmKPRKjOfnW7DepMRroNeS53chnvQ/hbYWi2p9UdPhHMdUFLECh0mnuwcQGoM6H0D53dEheqMy8bw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 10:19:16.5835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d2dfad-127f-4a80-9695-08defddb5319
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF742908B79
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA3OSBTYWx0ZWRfX2iR7ceKg4l4P
 7PjD6xOaIVTedQ1v+mLafeqyXVzbbdMe+VkyRyN/OBxSrYLh2LqRMWzTwGqlWQUCe0CYSvq+jF3
 gFc9qXjYZ+HVP/tFsx7GhOZIrcTlY9w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA3OSBTYWx0ZWRfXw5XqXAYdc/RI
 w8uFZSgBcVZu+Lp+pcxqvjhfaRPJov1+YqTHo/ytB4g4gkdT+ZmCmANIngN933QL1bDtSdV8rYR
 Xc+4jyyzMAenejcR5/cHUPuf/SfEVpXIB9X7U2HvDw3dwaT+kltvOVGfbzJQsname3w4KHhMKy+
 8F3/djrFTFYPMovpMfyoyvsHoTBkmOZLupr8tgTV14ROOTjWIARphIhwVN5pR3tAamW2IEDCZiO
 nH985Dnx/ENDjL5j13P0A4EyUOr6BPZMWdmAX+CaKcJ5ttzXr85pyabfc3vRgcStmMD5PQaY/iY
 Qg0zxLhdTCrEt3wXy13Vpfx1rlsk/8s2+PwNqxu1Aq59/t1fFnZBobIJOFRJdVJKeWtJST4XX4/
 VD0ZDhHzYen+UWq2wETEVgFpL4SVxwUNg2Eim0UZCPiBy4D7eaUmUJIvpGpa3+1Pc7fexALwcFJ
 Aw6trczLSZfM+Di8VPg==
X-Authority-Analysis: v=2.4 cv=PbLPQChd c=1 sm=1 tr=0 ts=6a858329 cx=c_pps
 a=OUzJ7+VCHgWt90O9wSvn8w==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8 a=bHVqjoPl5Vnn2wegQcYA:9
X-Proofpoint-GUID: Gx1z34aAoVG-tU3VKGLhR3G0lA0LFHDW
X-Proofpoint-ORIG-GUID: Gx1z34aAoVG-tU3VKGLhR3G0lA0LFHDW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190079
X-Mailman-Approved-At: Wed, 19 Aug 2026 13:42:00 +0000
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

A-Core no-SPL Mode is a boot approach that bypasses
the A Core SPL while retaining U-Boot in the boot flow.
This mode provides faster boot times compared to normal boot
while maintaining U-Boot's flexibility for kernel loading
and system configuration..

v3<==> v2
===========
* Updated the naming convention used from "no-spl" to "A-core no-spl" to
* make it more specific and clear..
* Link to v2:https://lore.kernel.org/all/20260818115322.101705-1-g-praveen@ti.com/

v2<==> v1
===========
* Updated the naming convention used from "semi-falcon" to "no-spl".
* Link to v1: https://lore.kernel.org/all/20260814102153.44487-1-g-praveen@ti.com/

Boot logs link :
https://gist.github.com/GokulPraveen2001/fef407a482e2dad30272006de557627c

Gokul Praveen (3):
  configs: add A-core no-SPL mode fragment for k3 devices
  arm: k3-binman: add tinospl.bin for direct U-Boot boot
  doc: ti: document A Core no-SPL boot mode for J784S4 EVM

 Makefile                               |   2 +-
 arch/arm/dts/k3-binman.dtsi            |  47 ++++++++
 arch/arm/dts/k3-j784s4-binman.dtsi     |  65 +++++++++++
 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi |  14 +++
 configs/k3_a72_nospl.config            |   1 +
 configs/k3_r5_nospl.config             |   1 +
 doc/board/ti/j784s4_evm.rst            | 143 +++++++++++++++++++++++++
 7 files changed, 272 insertions(+), 1 deletion(-)
 create mode 100644 configs/k3_a72_nospl.config
 create mode 100644 configs/k3_r5_nospl.config

-- 
2.34.1

