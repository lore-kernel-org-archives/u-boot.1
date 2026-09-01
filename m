Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BE1C61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 16:21:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC72E4074A;
	Tue,  1 Sep 2026 16:21:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Aa8ZE5_cGxA1; Tue,  1 Sep 2026 16:21:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788279708;
	bh=npp16pwE4+ENgknDxI+zu2mIC8WMIHAT+G2K8iDa0E8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vY0mgTbtnStKWYnEk8ZtswCnxtBxedhqFr16j3Uih1aA2G97w4q+nwcuovjajlJ1T
	 2/rj6ThsW8mslHXLZCRZESDq92BIY6JOBBjjQqn9BIXalyjfe0pT3OT3jff+FhIsG0
	 qKHkEk6FYIIVXTuSEgOV4gGPZqXXPCgM2ThOKxAbcVAv5vwfpWoBG6/vggbkEPYeXl
	 8Oyvgum01Nju4489to4jkCQWIYbeMbLh7MxD0XrWD3b8XOnwxr4vKgC9ZVMdsObQL5
	 gbuPqgAzKO2UsoWvKygp8JkOUoxB/il3Tz+T/r8FWKTOeYPg98K2F8Kc3WEWTGei6z
	 shsUSbYMItyFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFE0E4070C;
	Tue,  1 Sep 2026 16:21:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AD28E422
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 16:21:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 92FC8606BF
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 16:21:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ABQAUzlTdBQO for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 16:21:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=WNWIJ6Bm; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=sIEMmfg9
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5845E60661
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 16:21:45 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 681E8NRw2652010;
 Tue, 1 Sep 2026 11:21:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint-05-2026; bh=npp16pwE4+ENgkn
 DxI+zu2mIC8WMIHAT+G2K8iDa0E8=; b=WNWIJ6BmJIxF7kHg1LN7w5MoCY7JVC4
 Uezzgi5oaBBRxZk1rjCSsttdyVL7otN6O/fYAsMUljxn/0LFU9o1rkt3cX3EG/Yh
 Zv0v2nCyDPcqjuDxBMD9xXWPk/jknQe6Ybb02uk6O2bZufapArTgUifAgdrtyTxy
 9pIGnIrHLFRZK2odYwndFf/V0nHqIHiLeADuw3KpkpjX5eHrR29E9WP/cqqJzV8O
 r2q/lClUvskd168X79tNFWUvDUetsklvGEHq6loKMP6xvJQ+ODZz0Psw006+wYxA
 5Gfs1IegYrSZprR+bz9UtKJxUM0UwIHTDQ+HlWt5V01nw5f41kehQ/g==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013061.outbound.protection.outlook.com
 [40.93.196.61])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gdmp2nbu2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 11:21:43 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxOWI1s/gGsg4PeVQrn8MgRS9H2WIxTYxvXqONzxsylmAln/UWQvqFmDBFzC5R/K9pOKoNyzb6oFN4fkMOfRadGBbjuMtBoAhkCwgmW8nqfibIfHksG7W3tvtkSKbWtAxC9dqm9pA8Qkp2c5wZsHGBg70Wign2wWpict6/w9arsJLQ7EcEBJsMnvOI7p4E6+DpL22aAux/Z6mfrd5CVgcTNZZXNk28wLt61DOPuIcuu7GEBXrLTkQG4rIME/qPVT9h3TQc9xeeJu2Oq66rrlS9axreYkiOmpOGT+rEzbHVch87yVOswkN0K/qf/VJ49L9pWwalexitpzxyFquSUdKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npp16pwE4+ENgknDxI+zu2mIC8WMIHAT+G2K8iDa0E8=;
 b=M6kkKXehwTim1zxGrC6mTvVwv+ic005uGpT14boY48pzjrH3h0wKgwNFDT/ZQyiGXNuFaX/G+qbYL+IBOKjue0neR1XeZxZuHuTlVNS5BLg9yYzugOCRTcDP/FZZIEkqb1v6RttHV9nUQ7xG3jhzkhV9qkMgOotbkpjyqnxlQ+DXhKoUpAOmXb8C1oz+/Shvq3Tz0ahlN3YVugZHFN5pABoDcIUl7I3K4ksfHwO58nBxPhyMWf0KmN0N0fOGeiwwITVQ9B0odCUTUA7sTLo7HZwEhfMcKeG/CxkDACqQNFLL8TkJKgxIfkK11eWJy/saKiAZxc8xviC2D4/C4FlT2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npp16pwE4+ENgknDxI+zu2mIC8WMIHAT+G2K8iDa0E8=;
 b=sIEMmfg95LxPdh9zpThLfsNmod9RHTMz3bUvDFvMFBnMV75ztQyI5vwVTyQwIrbkzBMzZej9drHxxqvJBsV+p3WG2EO9LNpSexPjTHVGdRzH6PLmbmCOs81KFbAGgWPXDhWP/1DGGvII9yS3+NrLhvAhMgW9GeLYDLO4x3fFQAg=
Received: from MN2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:208:234::26)
 by BY5PR10MB4244.namprd10.prod.outlook.com (2603:10b6:a03:207::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 16:21:38 +0000
Received: from BN3PEPF00022BC8.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::98) by MN2PR16CA0057.outlook.office365.com
 (2603:10b6:208:234::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 16:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF00022BC8.mail.protection.outlook.com (10.167.248.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 16:21:35 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 1 Sep
 2026 11:20:36 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 1 Sep
 2026 11:20:36 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 1 Sep 2026 11:20:36 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 681GKa6Y3115253;
 Tue, 1 Sep 2026 11:20:36 -0500
Date: Tue, 1 Sep 2026 11:20:36 -0500
From: Bryan Brattlof <bb@ti.com>
To: Gokul Praveen <g-praveen@ti.com>
CC: <trini@konsulko.com>, <n-francis@ti.com>, <a-nandan@ti.com>,
 <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH v3 3/3] doc: ti: document A Core no-SPL boot mode for
 J784S4 EVM
Message-ID: <20260901162036.6jzuqt2qn4tdxxqf@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260819101910.39192-1-g-praveen@ti.com>
 <20260819101910.39192-4-g-praveen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260819101910.39192-4-g-praveen@ti.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC8:EE_|BY5PR10MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e40a87-b3c3-4534-949b-08df084517f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|3023799007|22082099003|18002099003|13003099007|56012099006|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: mydYneu+prijxuTY4s4t+IO0KH6uYrRWCT97BytD0x+hB9X8vYC+4REwen5eR5w+aqactP6cgKpcMXTyvqu1uo8fI10XuBHAErrl7oaLYbRsODEZo6ROmRFwZpXtYFzGrHXLPndHaI462uRW8mhyBTk18SFq7AUW7Ni5g4VC2Nn0rhrgUwUJynkMm+LD9rZY/AoVINjap48US1JUxp74Mtejw9FlmPmCdZdq1zllIYy1kO0xGbeYE43ubndjwQKbBKDWyflVpQM2UwfKfmLxdlw2ZiE8gtqopQPztVwKQDDwWxesTlV9uPKIVBQZlZeSD+0gdhJfU/g2onB7gpYdbMtxJN9Iz3oZrB3fwXHyA5uNaQk/JTeIbqi5pN81f0956BStaIpmnWZPfWZsZVfLsE7PjYJdGFIiu9/hKOJ1RJU4ASNTQudH0uA7beG9DITQ76r+/fY66hI4ZhdrLDoofe47y3fEPlXgDIYlQac5Ip/EIeWiC0hsk4gfvvK3a07cJ5wQrLYJbxi//l5fr+VeGR7W/A82FVaRs1jPSfBzt7xy5Nydh2vWXD6rgySsCOtXnaLFc5u6elfJIeWj9x2LyYZaeV0mstFO1BUuj0SbRi2osOEsq/p9xXL11CA5XWHIpQEEQozdjRNaQ0NzS9EZ2oZAMQ1xfNtqfmz7O3WkahM=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(3023799007)(22082099003)(18002099003)(13003099007)(56012099006)(6133799003)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SwIH/+HEcIlA/vinSZwxPzzR8+jX45gyWSWtxFLw0Vx5e/DvH7nhlPJvRyNxBzVgZaoRdcmtNolXWMueCMs2c7EZLmF9IWNVIXCShRwsXFuSQjYpKNL0n+jS9CPJeuiB3DgfVK2q+I/cyQoB4yujHxone4OOVLNpbulZ/nqggdIyjQ/1XJTyiEo9unURTyB5ppif8+mUEu51elVNKhgJ6ox+RZpsG3BFfgMgFIfE6w4HnANoHQA/k53q8i00hEyV8fS1ObyPIiRN6AGC6Hjpm8Q3Exycm228eyH5a7hdwdA7laE05Kt3FNigVdPNOsvbSECudCrH6BVPAjjm7mjiQINVBv/ITJx3DXqnBZSDP1YQpXfT16wffmsurhwblL2MWuWe4olYKd0yxQeBqm7lnRAwMxnqBOd725ZB/wNkUSCA0Qe5QQ72tr9eKFQyWVuq
X-Exchange-RoutingPolicyChecked: 1xoqmh3LZ99QF+OuSCBbmyMd/JbGldvbzyC4JatK+I+4a7LSlp+fAYECdozfqXjNA2Fz0rH7DKx/SqI3bxH8++8ffz8U1IvEEqNA2GkGOwooNfErFoIFbXXvKJn3pY9TwUMK8TZONQFriMSWYCYI8ZS3BfWad1kqW5uLUhesuOnNJcp1+uRIKe8Z+8YW4Jr3Cp6Te48qe6VBhX6m+7TCp1b1elyeJ2jyu4gGOhXVszAY9Up+UeBY07CWTMPJNvgzAur7olCL2UGF3c2Rk41M0PNBsGHMCNysSJ/O2pfZRyWDVk78qJDwnzT7vGNW9nIqM2A+0gO84xJk3xNOoU9L5Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:21:35.6169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e40a87-b3c3-4534-949b-08df084517f1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4244
X-Proofpoint-GUID: tTkCNHg3YwBW_i-EuVzQh9SvcJ9df-91
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE0NCBTYWx0ZWRfX6EOYuyoeML8L
 XuZOJKQPRIIck0Y7ZF4LkRhB3kTnAc23HWaiEDaPFZwWb4joS0hkhm3dMobtt8hKkjxEIQ0moXj
 7+I6R58KQ+hmAObn9Ypz5FpCLuIkD0CE8Q5ru8RmBaAsfXkjlzCcXS1JLc83kV9Z0AVh0Kx60xR
 JYEbBlcpmAxJQLJHk7GY+BIbPckz+QXbfdhpczX7QG3XSN/f1HCLk6Z3qvb14XbbVmSR2tfiYse
 tqPk6N/ONn28fqqPoYzgy7fghZWoMTswX6tt/kUwcd3IMX6Y8/flV9uBIFyUeGW7zYyclSCeWGI
 X85I+UHYODlYXHunVOAfrh+N59WMUGMXrKEOGA9/wDEkCW6Sxdg0SPEEQ9IKYqQVsOTbFpbHchg
 H6ZPqJH90T/Jkb25nXzeaAiWdVu8mFazwzzRA8KtO93K20NGv4oD6NnehbDb8S3k6m/UR8taAvk
 FyMJfzcd5qNycBffSlg==
X-Proofpoint-ORIG-GUID: tTkCNHg3YwBW_i-EuVzQh9SvcJ9df-91
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE0NCBTYWx0ZWRfX89RomUgx04mW
 bClTw7KYYXDdD+Ikd/3Ur9lmFJOIzF+ZYpL6c69BfK1f4pge5QOViiu7/k+oFUjq2aujB6AVk7g
 NEK7Hw5KDknpuYb5EHa6Vhkv+23+h6A=
X-Authority-Analysis: v=2.4 cv=QuVuG1yd c=1 sm=1 tr=0 ts=6a96fb97 cx=c_pps
 a=DPCWJwWgIuHEo730oqIOaQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=1VxDqnHFAAAA:8 a=sozttTNsAAAA:8
 a=oBFUpZHQqf5tFE_YiiUA:9 a=QEXdDO2ut3YA:10 a=aZ5uHUMKh6B-zo3GvD48:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010144
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

On August 19, 2026 thus sayeth Gokul Praveen:
> This patch adds user documentation for the A Core no-SPL boot mode
> on J784S4 EVM, where R5 SPL directly loads U-Boot proper, bypassing
> the A Core SPL stage.
> 
> The documentation covers the boot flow, build steps, and usage
> instructions for this boot mode using tinospl.bin.
> 
> Signed-off-by: Gokul Praveen <g-praveen@ti.com>
> ---
>  doc/board/ti/j784s4_evm.rst | 143 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 143 insertions(+)
> 
> diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
> index ec82228ab90..cf870066291 100644
> --- a/doc/board/ti/j784s4_evm.rst
> +++ b/doc/board/ti/j784s4_evm.rst
> @@ -637,6 +637,149 @@ to the J784S4 endpoint:
>  This program copies the boot image to the PCIe endpoint's memory region and
>  writes the necessary control words to signal image transfer completion.
>  
> +A-Core No-SPL Boot Mode
> +----------------
> +
> +A-Core No-SPL Boot Mode on J784S4 platforms is a boot approach that bypasses
> +the A72 SPL while retaining U-Boot in the boot flow. This mode provides faster
> +boot times compared to normal boot while maintaining U-Boot's flexibility for
> +kernel loading and system configuration.
> +
> +**Key differences from Normal Boot:**
> +
> +* Skips A72 SPL execution
> +* U-Boot binary included in tinospl.bin alongside TFA, OP-TEE, and DM
> +* U-Boot loads at CONFIG_TEXT_BASE=0x80080000 (A72 SPL's earlier load location)
> +
> +Boot Flow
> +^^^^^^^^^
> +
> +**Normal boot flow:**
> +
> +.. code-block::
> +
> +             | tiboot3.bin |         tispl.bin          | u-boot.img |  Image  |
> +             |-------------+----------------------------+------------+---------|
> +    R5 Core  |    SPL      |                            |            |         |
> +    ---------|       \     |                            |            |         |
> +    A72 Core |        ------> TFA -> OP-TEE -> A72 SPL -->  U-Boot  --> Kernel |
> +
> +**With  A-Core no-SPL boot mode:**
> +
> +.. code-block::
> +
> +             | tiboot3.bin |        tinospl.bin          |  Image  |
> +             |-------------+-----------------------------+---------|
> +    R5 Core  |    SPL      |                             |         |
> +    ---------|       \     |                             |         |
> +    A72 Core |        ------> TFA -> OP-TEE -> DM -> U-Boot --> Kernel |

Why would DM need to run on any of the Cortex-A cores in this boot mode?

> +
> +Build Process
> +^^^^^^^^^^^^^
> +
> +Enabling A-Core no-SPL boot mode requires re-building U-Boot as follows:
> +
> +0. Setup environment variables:
> +"""""""""""""""""""""""""""""""
> +
> +Refer to the build procedure above for setting up the environment variables.
> +
> +1. U-Boot:
> +""""""""""
> +
> +* **1.1 R5:**
> +
> +.. prompt:: bash $
> +
> + # use the no-SPL config fragment for K3 platforms
> + export UBOOT_NOSPL_CFG_FRAGMENTR="k3_r5_nospl.config"
> + export UBOOT_CFG_CORTEXR="${UBOOT_CFG_CORTEXR} ${UBOOT_NOSPL_CFG_FRAGMENTR}"
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_spl_r5
> +    :end-before: .. k3_rst_include_end_build_steps_spl_r5
> +
> +* **1.2 A72:**
> +
> +.. prompt:: bash $
> +
> + # use the no-SPL config fragment for A72
> + export UBOOT_NOSPL_CFG_FRAGMENTA="k3_a72_nospl.config"
> + export UBOOT_CFG_CORTEXA="${UBOOT_CFG_CORTEXA} ${UBOOT_NOSPL_CFG_FRAGMENTA}"
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_uboot
> +    :end-before: .. k3_rst_include_end_build_steps_uboot
> +
> +.. note::
> +
> +    The ``tinospl.bin`` file is automatically generated by binman during
> +    the A72 U-Boot build process. This binary contains TFA, OP-TEE, DM, and
> +    the U-Boot binary with its device tree.
> +
> +Usage
> +^^^^^
> +
> +A-Core No-SPL Boot Mode uses a specialized binary called ``tinospl.bin`` which
> +contains all necessary components to boot directly to U-Boot without loading
> +the A72 SPL.
> +
> +**tinospl.bin structure:**
> +
> +The tinospl.bin is a FIT image containing:
> +
> +* **ATF (ARM Trusted Firmware)** - loaded at CONFIG_K3_ATF_LOAD_ADDR
> +* **OP-TEE** - loaded at CONFIG_K3_OPTEE_LOAD_ADDR
> +* **DM (Device Manager)** - loaded at 0x89000000
> +* **U-Boot** - loaded at CONFIG_TEXT_BASE (0x80080000)
> +* **DTB (Device Tree Blob)** - U-Boot device tree
> +
> +The R5 SPL requires both ``tiboot3.bin`` and ``tinospl.bin`` to be present
> +in the boot partition (first partition) of the MMC device. By default, the SD
> +card boot partition is used (``mmcdev=1``). The ``bootpart`` environment variable
> +defaults to 1:2, specifying the second partition of the SD card.
> +
> +To use eMMC instead of SD as the boot media, rebuild the R5 SPL with the
> +following diff:
> +
> +.. code-block:: diff
> +
> +    diff --git a/board/ti/j784s4/j784s4.env b/board/ti/j784s4/j784s4.env
> +    index 82b9f0741bb..73d59ac425c 100644
> +    --- a/board/ti/j784s4/j784s4.env
> +    +++ b/board/ti/j784s4/j784s4.env
> +    @@ -17,8 +17,8 @@ run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
> +
> +     boot_targets=mmc1 mmc0 usb pxe dhcp
> +     boot=mmc
> +    -mmcdev=1
> +    -bootpart=1:2
> +    +mmcdev=0
> +    +bootpart=0:2
> +     bootdir=/boot
> +     rd_spec=-
> +

Does this still work? Long ago we moved all of TI's reference boards to 
use the stdboot flow[0].

~Bryan

[0] https://git.u-boot-project.org/u-boot/u-boot/-/blob/main/configs/j784s4_evm_a72_defconfig?ref_type=heads#L34
