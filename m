Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5516FC5DF84
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 13:06:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C86C810B0;
	Tue, 18 Aug 2026 13:06:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jy2d1Q_X4Ta5; Tue, 18 Aug 2026 13:06:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2123981090
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787058383;
	bh=vNQpTINNiZrL+9XIHlY/AiXLDyMW4N/1yTKeG9dPHE4=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lZUamxjRqxtxcRWt0CERgNoFaFb9bNnf9LqMKf9F3dB21w7xIfNY3sf8XK23AVvZj
	 41hDXAC+VAcJZuCvaCIYvwxCOC0xrWrtS+1nLNLMEPd5UBrYe+rR+pGgt+6lPdXIhJ
	 WP7gcXU5LPsOlOp2Fy48THIvuOMU/WSx9lHQgNN3VMA6buCdJ8XEEydMRhaWSqE0AY
	 lgoTEoZK3LV2MsyIdiRWe60gBfk0yYh+Q6aErfrgtTSBC96EKrtEQCYfnLM1zpZr1P
	 2cIsiZOHOE/xpofgmIy6pNQa7EXDpB+Z0glQm9ilELBHnwlJsBogqZQNNZ14TMJ7VL
	 LTArt7XJYrCRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2123981090;
	Tue, 18 Aug 2026 13:06:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BC860333
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 11:53:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9F55040750
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 11:53:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zYRY_gwNe20W for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 11:53:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=g-praveen@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6A5234070A
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6A5234070A
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=INhxH4cu; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=j+jfU9Et
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6A5234070A
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 11:53:42 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67IA65Ya3442653;
 Tue, 18 Aug 2026 06:53:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=vNQpTINNiZrL+
 9XIHlY/AiXLDyMW4N/1yTKeG9dPHE4=; b=INhxH4cuPN+KwsVPzbwxUiYmDgo4o
 RX/2XClenybT62cinNRArvzuTYwrGTbermxHojwpHoNQDZSgH9LbWGK44peztQHO
 k8GkjQGLEoXW3Vcgpb4xd/Yfbu7zU1bqR1oJGMuAtD0b9rdehJZiGcNLI50ujxP2
 0UjANMjZ5IgfWtz+Xw9AboFtRUeVCaIFhnzeS6X59mcRiP3StyqK/RukZ5eNXOww
 lYd0H0uRk5xw/CUqQGmPpa+dF4WT0Gf37WDtzImd9/Fg9Dg3n9KynR3+lUpYstVC
 u27miF2wb5QTMzHTmdLac7jacdEebV46CPn/G6aZTyZR47w+JuWUAJwDw==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010046.outbound.protection.outlook.com
 [40.93.198.46])
 by m0380145.ppops.net (PPS) with ESMTPS id 4g4fbvt9yy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 06:53:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FaLIW4Cm0iKkVHxNLhYLlMWFPMAtp+YstD7PiNSxVQJp/HgEhafPF6sNWj9cbZwUCRgWovZWaKQ1mXQZCkez9ZdnsGSoiigU5jRp9OOxKonVLiCW8T4I8wl7X/5OfvQX8Hx2g7iP1HU0Behb0HhsVOc04axB2yCZfyTjr9gb+8mfKMExtCcXUYaFHigFqN5Tl85AEsB+4uPRhmHSN/UQjt8zavfBN7UnpHeyJ9gjY0o3VTNUG9kjSTFd71wHGJjRc4gqKlWYD+3uEZHmsFXEHS5i1t2DJTCxxGoMCAlIingYtqnUwWcI/bmiM1wH9ElxyzsNDH9QqCUlntJHgJq9Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNQpTINNiZrL+9XIHlY/AiXLDyMW4N/1yTKeG9dPHE4=;
 b=LoiZ22S8pKEdXwxR1eF7HwAPlTexrHiuL7wEk/a+koCxzh63Vm8NJjvGPQg3wR0SWB/X7k/gxFjqlTgX2yxdjlgzE9o17IYfYQ9wL3k0wnJm0DWqmV9wWf5O3kSrW0s7KhhNLy/1KCaa8iAuv/xn8J9OStIQfA7M1dDAqQ3+Jo09bt7SQFxrvl7o+TbMs2kI8rwx0WiCoDeqh0ttnpVpzgPXw/iowcJXApyKQSz+tUFWGDxEjBN2Vo4CeLzLRZLYYuACysZfiJUoZQQ7ZAAkOTiO+EQbw0GTJX1laAvbLpLiSxPDkvm2+byHIcAhggbYajAsP+efBASMBbwSLEeAfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNQpTINNiZrL+9XIHlY/AiXLDyMW4N/1yTKeG9dPHE4=;
 b=j+jfU9EtfW0O6XRrTpndV3sfOrwkJoBXxLywkM+ZEcAnUZTkL744o6rtzu7i5SOG2L1Vc5Eyd/0VNhzMFvPx0wr2pjiobWLB7SNmatYTqkDFLhDVLgXWnbNWbJa3MbJboG+N+sebx9jNQrdh/Tqxb1YRfY7cnoC9Psuqhi1pPy0=
Received: from SJ0PR03CA0146.namprd03.prod.outlook.com (2603:10b6:a03:33c::31)
 by SJ5PPFD020A49E6.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7d0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 11:53:39 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::14) by SJ0PR03CA0146.outlook.office365.com
 (2603:10b6:a03:33c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 11:53:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 11:53:37 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 06:53:36 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 06:53:36 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 06:53:36 -0500
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.154])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67IBrY3P1372974;
 Tue, 18 Aug 2026 06:53:35 -0500
From: Gokul Praveen <g-praveen@ti.com>
To: <trini@konsulko.com>, <g-praveen@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.u-boot-project.org>
Subject: [PATCH v2 0/3] No-SPL Boot Support
Date: Tue, 18 Aug 2026 17:23:19 +0530
Message-ID: <20260818115322.101705-1-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|SJ5PPFD020A49E6:EE_
X-MS-Office365-Filtering-Correlation-Id: eefabfe6-81c0-4eaa-2bb7-08defd1f56d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|13003099007|6133799003|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: +4LAtiqo7k7BElTWlt+Fx0z7tkzrBDbQCehkpaIb/quk1mF6WFIgGPVeDH2yCYjdNnNvwzyPPB+3P+TtePpJuGu11TKI5BYgrjTaCcIdwyXk4BTtkdrXrfVgp6bU72Fo2XnQ9WUMIoGRHo6sCvbYWGVrYdNLDNgUowwfa7N9H0meHvz60rINlx8t33sXWpBDgUX4zBIATiReTIwPjgbKCrz5kfUvLNcsFkEsuTP2O/xzvxwJYD5HS/Ip+fOlL97FIvZ0+vfSx5SdycFk5VvlHzQiNTSkN2blv5sWr/Hg8/mRrdl4XljS0QBgHLNXxy+M7WjnR1pcHGz2cjDlWQx8xEP+cqH1Z8NLXySn/l5G2oIGlTchcxRzAku3HGzB2wdAvQ1lHdDcJ+M1k6qns00L+W+0G7bFaF18ToZ5LlsrHCdFS71CN59rMT/YWnBG6EUs5giw9ptPzPX4/6OanO6Dlpi1XedhqCiQKrtFKXKgnO6F2f+iKMHZhUTLrvHmMdrZywDN7J9FpIBTfUxS1vix62GKYGC/rKxqrHBaKNcBslpnpzivEwpGDKVE3a1K6Dun9DPqmj5Kh4RU9WA7V/YBcgnbLPhrhvb6eKRqmtM7a3Uxw9MBbQSu4RMIDpWAfLRJhm+2kp0/5cFlxu+vrALMuIbPIjfxe1vfeiJZnN/KVWU+r7wGCoD7ZDa4V6KJilt3vEHMXH7rywOPTk6OvpKNJw==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(13003099007)(6133799003)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HsawdcFeTQ7BxWN0j+YIufDn6kprMssdvsb1fq6eAOja9EscGOMsMooHd6lyR2oFenlvibZbviYosFPx1l2rMH+NpJUxkToD8z8Wn24LQSDBZ0MoAu8V3IcUuUmXmbTZd+vzxvl6VH6FVXBXaY5HHOG2NKC9gtDL5BhS4aKY1iXRFvs6e6Ei8W7y9D5ACh7FhlifDSdbe4TnmKQs9WDpuGS4/aTwI/3vv2o29cfxNLDSz3SY2U8ohlFvCPu32jkerzWsOxX9LQbFTmaxSVKemMxk6bsykxJ4CK7xk47XWnFTa2RwDZgWCRcX/fduULDBiJ0IQlDFcWcoEtscr9HsLJ3lHtc3mAYLV2WLM62mksWQc0dMDCfO69NwFgFJBeu8oGPOiNAtnbKagxJOHH0gYTIIYWy2Cqo3oFg7fJK/8KJemme3ACsJSaU71/PDKngx
X-Exchange-RoutingPolicyChecked: eE010Tyj4++pI9PTKcxtOT5agZsz09mC+OD6cmSybaBqhDA037aWDLsEh/feMvMH9eChw1LHPoGVTbDa+vIwuFwhtmvLVNZ/AQROuWYiSE9HM3uYVNv14MAERGQmed/AdiRPThDNzuaUqdwJ3qCub931hF6ndjxXW/F/l9cMuo5hR3c1BGo+CHhYnQj+if2fzmk3PiUE4IAUPOc7O9npx9mV+Fw5/vctz2qpfSFkHzIqbtnW7UHhYEWB+XeWKzbFzUoKEOp8yC1KlchOv9bbS8L7IF8Gf79JSAyByuyd58G1Not2c8CDzIJd4CLo5TT08seYjWydWIvEqRBiOmATcQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 11:53:37.4731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eefabfe6-81c0-4eaa-2bb7-08defd1f56d9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD020A49E6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4NyBTYWx0ZWRfX2pgG4VcbLapR
 CUpk9t1TljqxaTiZTxoG5b+iJFr6ht5SVl1Ns/fn2qKmS4+0Dc9Ouw44ZesIJivyseQFgPBp48g
 Mc5xt/t6rzt72J92sLTu8IP82QayTO0=
X-Authority-Analysis: v=2.4 cv=LfYMLDfi c=1 sm=1 tr=0 ts=6a8447c5 cx=c_pps
 a=HD8lxhnvDrzpkXyYnuuseQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8 a=hGj0xCVwMxOyZgMdz0kA:9
X-Proofpoint-GUID: TtuOM8JDhtWI8xvOEh3bx0wHTdWuufIF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4NyBTYWx0ZWRfXxA6mQzTTYFsI
 oWL2s7lRLYZZutUGQCWjOMDIRjrOQmTetHZnrFX/1VkFcNV7obKUTv02d2UqYsEz0HxJXWeKErI
 Tu/NlHf+Ju6h13tLf3hZgZ7NoW/lM6dpPAthChsAqTgL06tARzD/EsvtnW7RrTDyeMN4Dd92gY8
 8or7sYw6SeZrZvNc4gk708tmO1/vNFB7wkzxoE7wxcZ/W8i4Ow62dat8RyqiW1K0b0Dsff7KqfX
 /M5m+qRhze/RHiWq1SBXf6b2fES86xZbsB3oYb5JOo6CK+gqbGsw3+PGTzdJsL7VVOORSfeOe7C
 CPC2BF5r4wPqoleo8hkRM9H+sA5xcP48CxWjmNB5kDoqYM23Fd9L8NymekdDnFAmmGG1gvuG7z6
 n2WErPAfQAfQABLeGHoQKL0JdaCHXbFpzL5ZmWSBaCZTBxA+bKhvD9IcoobVKtAAtX44eDp+KZ9
 v4KW5IQN0IA+u/3RJNw==
X-Proofpoint-ORIG-GUID: TtuOM8JDhtWI8xvOEh3bx0wHTdWuufIF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180087
X-Mailman-Approved-At: Tue, 18 Aug 2026 13:06:17 +0000
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

No-SPL Mode is a boot approach that bypasses
the A72 SPL while retaining U-Boot in the boot flow. 
This mode provides faster boot times compared to normal boot 
while maintaining U-Boot's flexibility for kernel loading 
and system configuration..

v2<==> v1
===========
* Updated the naming convention used from "semi-falcon" to "no-spl".
* Link to v1: https://lore.kernel.org/all/20260814102153.44487-1-g-praveen@ti.com/

Boot logs link :
https://gist.github.com/GokulPraveen2001/fef407a482e2dad30272006de557627c

Gokul Praveen (3):
  configs: add no-SPL mode fragment for k3 devices
  arm: k3-binman: add tinospl.bin for direct U-Boot boot
  doc: ti: document no-SPL boot mode for J784S4 EVM

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

