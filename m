Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808A2C982EE
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 18:56:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4793660738;
	Mon, 21 Sep 2026 18:56:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KSUVWEKP7PW9; Mon, 21 Sep 2026 18:56:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2C74160736
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790016992;
	b=a/tqJw50oiW5UGfhclbU3Qr8rLZ8xUQ+JbvXAXpFkJVjSt2TAx6fN/Kbj3BpXihr+VEe
	 qui3YAs0lhDHCWZA6IxbBnfzS8R52/59NeZ/7jOxCnWj0LMt3ySLG22Z5apbzDEwjvqLh
	 JmALeqtjUNWIvX6W3XlRBCKj7/CUn+in7RfUblxuF4mwO1ons0zixFgGlA4LE1niZO8aJ
	 qFNPtMY8qhmHwICQKxPmobInoo07nM7JEDONeWKNYZEyv8l/BbwyT27mQ2khhejsyyC0c
	 Mr0EZsAaj/6z6Fh+XZFmVb18SmzOEf1jcWolIVCkUlPWibBOYOHNU8Mic2pQcGecofw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790016992;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UEYMz1kRVD9pIt2VlFEvW1aoc/E1V/7rnduA3tLLsuQ=;
	b=QF8rCu9GKwwJNK9RpWaRwYKoQuDhi7HdLt/VqTJy6e/EFSx4ov7wfmCmPFVJBSlmBED4
	 v3fIe3jqfCoVsd4wstgxplBkuD9PM5SdCDVNeX1l5Jdsi20VZqhJosPNfyUUmm5iUDJBt
	 sal/WFG7YQaC6ZN6Zr3NJjK3PnbXW0UKA8nBYNKbxJMb4LJvmePtG7jn7mdBQFyWMGk+/
	 es9abG8OGT72D51Tgj92cNhN9SBcyp0+2O4QscGol+Avz1VV/juuaF7lszuuxIkSdevvK
	 nOyA0mR6B8oTHI05y+kyTuh63NL+G5/Btbc4OgvXjnS8MsTT+efoNsRMfYKra2mxDag==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790016992;
	bh=UEYMz1kRVD9pIt2VlFEvW1aoc/E1V/7rnduA3tLLsuQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LcV+ktQic6zq4TQeNUHYJdfN5VLf+EBZ3mF7w0BzBfuSiu/lNKs41ULHwb2FfTjlH
	 c8cQDiSM7/ZJx7jc66oBu0ahcwv4rCQRbHCFvcXABCpYcMd3Lumcvg3Xzsals72gkB
	 KhUEz8H3/c+Mxmac6eABYSpwl2JZOsDRKEoKWwFmDLtm4aMcxYwVtQ0MlkpwXu2CYI
	 HnKfPDOL2oNb0CqgQ1aFkxCVt5WdFh0q7xmY7VoYd8FH1BRW23VSjHd/iCyQWeFib7
	 jW0NDLUHd0CRWwQeGHIQMxjRTZKf7ShKdVF1Xn4y+cF+Q42OXltP9CfDOViJGdOm1O
	 yljTceCmure/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C74160736;
	Mon, 21 Sep 2026 18:56:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B0E734F
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 18:56:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8144B401DF
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 18:56:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yp3cq4Yujyzc for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 18:56:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5F0A9400D2
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790016989;
 b=WEDSNuyBM7paYaUziq5TX1RaTsndmFQdgMnwqISclaEtXP7iJCQi6OaOzHADUsyx7AaG
 ogSAmPvL2JrZVs5z0U0pr9F4iyAv/Skz5wlg3mk7Qzm0z78s+3Tiv1qkSOuLtMRdROgCH
 o4KSkprAKzeHVm3ABuBkl5gLk2lAn1owwGg2zDECnQg184KJ8ljNTxjpNdMk10z5A9Fu5
 OVzKtHEQ8nt5RjgeCTxK84AG1dICQ1+a9Eg231WKkv3kC3eTD+qFge1t846hjPkqwxcoF
 +1dVKXYaXbh27+ZsiK3mT7Qcfl/I7YPzzzTJUGxTCaM6Y/l6mcgmyFQZRk1Ojt65gVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790016989;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=UEYMz1kRVD9pIt2VlFEvW1aoc/E1V/7rnduA3tLLsuQ=;
 b=aCwPqSf/Gpb6VJpInXZlJDFbLLxG3ztw4tNr0FOuPoPBYfWHsxXJEtTN4C0ZCL18iY1i
 7atmmkYOz7CPgEW9S9SqhMb7FBnzs4IHIvClMTR83C18WXhgoUgNSpeFs7dXeTmjbZhT2
 +7uKOTpCDLdmimTKs8VxuSho/pGpp6sFNCT0ULlPpNvX8VQnSaYeBs+uWFapnmhcy7rrH
 Q4+uAcs8vJV5HX2O2hsqQAKT3r7aHB525d5mX/s5jO5WtTH3OoABc9umj5o56YgTxwEDU
 vU6W+JPs5j5AmdVgQvp0ugBDPrJgonpYxLwcytXZB3bIkfmAyL+CspvjVQHjRUSwzxg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=L1FL1YFX; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10d::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=akshay.belsare@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=L1FL1YFX
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F0A9400D2
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 18:56:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjxRqsgPYTD4MWD5P/ola1460WWYmruXM1LhkCG7qnQqVs+MWB6yTSPiBFwtA3hEU9ZkUeMf+e734RlVt80CglpgUfMfPaT0PYrUIn8gANm1y9gDgtidr+wZ6SciUs9/KAqdgwN25tn6lXWaDm2+b3LuDtTRpwJhlPQTBNY37B1fE8E9ruXI9R5uj5piXXati3biWafPZR83KJlGP1/UwR3AM+qojZON2mTOBj6Lk874gdRs+5N0PSE70Gq1ccQUjR8PUNIFy2jd1AmqpkK7FKRaDmoIoFbBTFtrsUlHsjtihJBMaFM5TH5XVv8h7jdpLdYX1USTMrwA35BfO3oEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEYMz1kRVD9pIt2VlFEvW1aoc/E1V/7rnduA3tLLsuQ=;
 b=okTGyXSqKGxk0rlJpXFXeTnJCvl3pfMTbk7fDwgYgB2MZRHoCY1hLOlr/j39Z62OQhalBYq8ZE3UXhmGMq+IuOFcJ3YlCu5YJ7I/8Rt6JL3oIH8gcYE5Uaz1xLSpXEcR8IUil8M1tELpAbhfCgSQ2NcOmn/RfytryKTm19Do/4CdEjo9+ebKNKBbDp/JX5RcE53RM9tsXHR9sJQ1jNeGJibjd00hHLNDuHiFOU4LrABfmz/rKYqTJbdyWYGsI43mfEglh/gOEjTTA9Q8d5ZA+s+peNL9EMGZvgcPf4mVTMbtT4cdnEYUUFzUhkDSSK5q6pj6CzLMfXdxW9gB7Y4Hvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEYMz1kRVD9pIt2VlFEvW1aoc/E1V/7rnduA3tLLsuQ=;
 b=L1FL1YFX34hphAP3QU0pmbzGq28iveubvewhFtsqGta0hDoUFco8spx5ZPrIDXxO8c4Mb/cVmD+TnxXggYdy5r3/qN3oTKN9SuLMGMgQE080I0JJV21xvRfMLRhSQwq8kjlz8oxw3G19IswGbEC8U8kmUgvOiK6ucqaMEDzfRVE=
Received: from CH3P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::23)
 by DM6PR12MB4330.namprd12.prod.outlook.com (2603:10b6:5:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 18:56:20 +0000
Received: from DS2PEPF000061C6.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::59) by CH3P221CA0023.outlook.office365.com
 (2603:10b6:610:1e7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 18:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C6.mail.protection.outlook.com (10.167.23.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 18:56:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 13:56:14 -0500
Received: from xhdamitn40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 13:56:07 -0500
From: Akshay Belsare <akshay.belsare@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <Padmarao.Begari@amd.com>, Akshay Belsare
 <akshay.belsare@amd.com>, Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Padmarao Begari <padmarao.begari@amd.com>
Subject: [PATCH 5/6] firmware: zynqmp: add OSPI flash reset IOCTL wrapper
Date: Tue, 22 Sep 2026 00:24:14 +0530
Message-ID: <20260921185430.3491195-6-akshay.belsare@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260921185430.3491195-1-akshay.belsare@amd.com>
References: <20260921185430.3491195-1-akshay.belsare@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C6:EE_|DM6PR12MB4330:EE_
X-MS-Office365-Filtering-Correlation-Id: 659f59d9-b682-4687-ed14-08df1812067a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|11063799006|56012099006|3023799007|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pW6j+dFJdvGseJ+PCjIuc5jNWpaSWll+ahU3eq76ys4R5MFBe++Z5eJPgIhamjsytkpryAgF0ZqVUFCV6vVp9yEhRfAmDNiq6XH7F60IxcE4oyNRYoG/xSwMhBMTbHIScubBAdaJAydPoB/iE2bMvUT7O1n6RBZZQTwO+4TudjNMmZYWfVOYd12hTH8DgAc9MTHZarzifQ3rdDxJaNAmJJuclYCKE2R0grIi6lix629BvURB00IqnhwuQX5yUHZTwZ6EV/4Z/PmXlGngOrU5wqx4UX+3k3T1XKUypQo8R2kwp0t8O/z4GCm1HK6yDHyWq6Evx9v3yFTR+hCJSzquvvcJEuans8u5+A2uGKFGsC1+ZuO61zMpMCbJO+/yuGsdbEEnmuGiXFHMc4f6Z4QRIwKLnHJHR33+EGgm+f5F9Kd1F0uDMB/4qTdXrXZbF0dYC4SCKjviKHH7ju7aDjT9aV3hsohliGNldJ6Otp5Hnjcn9bCb+o8lmPpqdOEtENcCCfTpAjOmOwR7btO+TcVmkkSw759ZhaZ+LcGCuCtecNAjQVWUJrGlUwXcJpbhmICi4yNjUKMnP0ABtMBjZz9EA+74fDnwJXi+vTl/cYPsb3Go4o7JzyczVqaVWxrUmdDc3QiOzJViKaCmTVemB5i+nSO/jkOC4SDAX8dR7bXC9HY889Xqy/34+G0Xj25uERGPLUT4hLcfxU9af5XGdLoNDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(11063799006)(56012099006)(3023799007)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gT7U2tMIvw3VjuhKxDsqniQ2J4dyc7hgA2j0iZ5edQX94z6peNWNImmCmgDLZBenwfGEpM8ln4Ei+6DnPWZb7lsMCiG6SJr51TCRDhrpgPnLJbWXQTKhls1bboKDaommFlNLUGvjLQr9tRHPN4Zd1+G1es7+wGBDYmKbs13a/sawBcuMnEKoHPnRWXzAZ3gEc2bRv+i8DadQbdbIyuGE8affwjWhJzBCnuSggeSVa7cAjDJSxzrqDp8BcUcmXqsI5EEGab7ux7dTvVUP4b/4wtZ2ZYc/dSGp8/56S2wyTgbRtwKPcy/XPxR+KpRr/UxYguEbz+Gwmg1Cc8nsMKsA7A3WFzVYMZ6dESiCj08ndqCFL94jPy2ekyTjmp6MGbUVg2aEJKXSbXthS7GUAMPE57uSrYszCLj0gag85XWvR5gmLY2iPyO/XKw2O8/Ov9Qh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 18:56:20.6353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 659f59d9-b682-4687-ed14-08df1812067a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4330
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

cadence_qspi_flash_reset() currently performs the OSPI flash GPIO
reset sequence by directly accessing PLM/PSM-protected registers,
bypassing the firmware interface.

Add zynqmp_pm_ospi_flash_reset() as a firmware abstraction, backed by
zynqmp_pm_ospi_flash_reset_raw() (the same register sequence, added
here as a weak default for Versal, Versal Net and Versal Gen 2) which
the next patch switches cadence_qspi_flash_reset() to use. The
firmware-backed override falls back to the raw sequence at EL3/SPL,
where SMC is unavailable, matching zynqmp_mmio_read()/write().

CONFIG_CADENCE_OSPI_VERSAL covers Versal, Versal Net and Versal Gen 2
alike, so the wrapper needs a Gen 2 weak default too for
amd_versal2_mini_ospi_defconfig to link. Versal Gen 2's actual flash
reset still goes through cadence_device_reset() (see cadence_qspi.c's
dispatcher) and never calls this wrapper at runtime - this addition
resolves the build symbol only, with no functional Gen 2 coverage.

zynqmp_pm_ospi_flash_reset() only calls zynqmp_pm_ospi_flash_reset_raw()
or xilinx_pm_request(), neither needing CONFIG_ZYNQMP_IPI, so it lives
outside that guard, like the other wrapper functions above it.

Signed-off-by: Akshay Belsare <akshay.belsare@amd.com>
---
 arch/arm/mach-versal-net/cpu.c                | 51 +++++++++++++++++++
 .../mach-versal-net/include/mach/sys_proto.h  |  6 +++
 arch/arm/mach-versal/cpu.c                    | 51 +++++++++++++++++++
 arch/arm/mach-versal/include/mach/sys_proto.h |  6 +++
 arch/arm/mach-versal2/cpu.c                   | 51 +++++++++++++++++++
 .../arm/mach-versal2/include/mach/sys_proto.h |  6 +++
 drivers/firmware/firmware-zynqmp.c            | 14 +++++
 include/zynqmp_firmware.h                     |  2 +
 8 files changed, 187 insertions(+)

diff --git a/arch/arm/mach-versal-net/cpu.c b/arch/arm/mach-versal-net/cpu.c
index f5c8e684dda..20a41d9ed97 100644
--- a/arch/arm/mach-versal-net/cpu.c
+++ b/arch/arm/mach-versal-net/cpu.c
@@ -20,6 +20,7 @@
 #include <asm/cache.h>
 #include <dm/platdata.h>
 #include <linux/bitfield.h>
+#include <linux/delay.h>
 #include <linux/string.h>
 #include "../../../board/xilinx/common/board.h"
 
@@ -250,6 +251,56 @@ __weak int zynqmp_pm_ospi_enable_linear_mode(bool enable)
 	return 0;
 }
 
+#if !CONFIG_IS_ENABLED(DM_GPIO)
+int zynqmp_pm_ospi_flash_reset_raw(void)
+{
+	/* CRP WPROT */
+	writel(0, WPROT_CRP);
+	/* GPIO Reset */
+	writel(0, RST_GPIO);
+
+	/* disable IOU write protection */
+	writel(0, WPROT_LPD_MIO);
+
+	/* set direction as output */
+	writel((readl(BOOT_MODE_DIR) | BIT(FLASH_RESET_GPIO)),
+	       BOOT_MODE_DIR);
+
+	/* Data output enable */
+	writel((readl(BOOT_MODE_OUT) | BIT(FLASH_RESET_GPIO)),
+	       BOOT_MODE_OUT);
+
+	/* IOU SLCR write enable */
+	writel(0, WPROT_PMC_MIO);
+
+	/* set MIO as GPIO */
+	writel(0x60, MIO_PIN_12);
+
+	/* Set value 1 to pin */
+	writel((readl(BANK0_OUTPUT) | BIT(FLASH_RESET_GPIO)), BANK0_OUTPUT);
+	udelay(10);
+
+	/* Disable Tri-state */
+	writel((readl(BANK0_TRI) & ~BIT(FLASH_RESET_GPIO)), BANK0_TRI);
+	udelay(5);
+
+	/* Set value 0 to pin */
+	writel((readl(BANK0_OUTPUT) & ~BIT(FLASH_RESET_GPIO)), BANK0_OUTPUT);
+	udelay(150);
+
+	/* Set value 1 to pin */
+	writel((readl(BANK0_OUTPUT) | BIT(FLASH_RESET_GPIO)), BANK0_OUTPUT);
+	udelay(1200);
+
+	return 0;
+}
+
+__weak int zynqmp_pm_ospi_flash_reset(void)
+{
+	return zynqmp_pm_ospi_flash_reset_raw();
+}
+#endif
+
 U_BOOT_DRVINFO(soc_xilinx_versal_net) = {
 	.name = "soc_xilinx_versal_net",
 };
diff --git a/arch/arm/mach-versal-net/include/mach/sys_proto.h b/arch/arm/mach-versal-net/include/mach/sys_proto.h
index 2682b0faeea..aa680baba89 100644
--- a/arch/arm/mach-versal-net/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal-net/include/mach/sys_proto.h
@@ -15,3 +15,9 @@ u8 versal_net_get_bootmode(void);
 u32 versal_net_bootmode_reg(void);
 /* Overridable OSPI AXI-mux select: weak MMIO default, firmware override */
 int zynqmp_pm_ospi_enable_linear_mode(bool enable);
+#if !CONFIG_IS_ENABLED(DM_GPIO)
+/* Overridable OSPI flash GPIO reset sequence: weak MMIO default, firmware override */
+int zynqmp_pm_ospi_flash_reset(void);
+/* Direct GPIO reset sequence (EL3 / no-firmware path) */
+int zynqmp_pm_ospi_flash_reset_raw(void);
+#endif
diff --git a/arch/arm/mach-versal/cpu.c b/arch/arm/mach-versal/cpu.c
index 3ec51bf560e..d0f23767662 100644
--- a/arch/arm/mach-versal/cpu.c
+++ b/arch/arm/mach-versal/cpu.c
@@ -17,6 +17,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/cache.h>
 #include <dm/platdata.h>
+#include <linux/delay.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -190,6 +191,56 @@ __weak int zynqmp_pm_ospi_enable_linear_mode(bool enable)
 	return 0;
 }
 
+#if !CONFIG_IS_ENABLED(DM_GPIO)
+int zynqmp_pm_ospi_flash_reset_raw(void)
+{
+	/* CRP WPROT */
+	writel(0, WPROT_CRP);
+	/* GPIO Reset */
+	writel(0, RST_GPIO);
+
+	/* disable IOU write protection */
+	writel(0, WPROT_LPD_MIO);
+
+	/* set direction as output */
+	writel((readl(BOOT_MODE_DIR) | BIT(FLASH_RESET_GPIO)),
+	       BOOT_MODE_DIR);
+
+	/* Data output enable */
+	writel((readl(BOOT_MODE_OUT) | BIT(FLASH_RESET_GPIO)),
+	       BOOT_MODE_OUT);
+
+	/* IOU SLCR write enable */
+	writel(0, WPROT_PMC_MIO);
+
+	/* set MIO as GPIO */
+	writel(0x60, MIO_PIN_12);
+
+	/* Set value 1 to pin */
+	writel((readl(BANK0_OUTPUT) | BIT(FLASH_RESET_GPIO)), BANK0_OUTPUT);
+	udelay(10);
+
+	/* Disable Tri-state */
+	writel((readl(BANK0_TRI) & ~BIT(FLASH_RESET_GPIO)), BANK0_TRI);
+	udelay(5);
+
+	/* Set value 0 to pin */
+	writel((readl(BANK0_OUTPUT) & ~BIT(FLASH_RESET_GPIO)), BANK0_OUTPUT);
+	udelay(150);
+
+	/* Set value 1 to pin */
+	writel((readl(BANK0_OUTPUT) | BIT(FLASH_RESET_GPIO)), BANK0_OUTPUT);
+	udelay(1200);
+
+	return 0;
+}
+
+__weak int zynqmp_pm_ospi_flash_reset(void)
+{
+	return zynqmp_pm_ospi_flash_reset_raw();
+}
+#endif
+
 U_BOOT_DRVINFO(soc_xilinx_versal) = {
 	.name = "soc_xilinx_versal",
 };
diff --git a/arch/arm/mach-versal/include/mach/sys_proto.h b/arch/arm/mach-versal/include/mach/sys_proto.h
index da357abaaee..83fc9b73b03 100644
--- a/arch/arm/mach-versal/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal/include/mach/sys_proto.h
@@ -29,5 +29,11 @@ u32 versal_bootmode_reg(void);
 void versal_timer_setup(void);
 /* Overridable OSPI AXI-mux select: weak MMIO default, firmware override */
 int zynqmp_pm_ospi_enable_linear_mode(bool enable);
+#if !CONFIG_IS_ENABLED(DM_GPIO)
+/* Overridable OSPI flash GPIO reset sequence: weak MMIO default, firmware override */
+int zynqmp_pm_ospi_flash_reset(void);
+/* Direct GPIO reset sequence (EL3 / no-firmware path) */
+int zynqmp_pm_ospi_flash_reset_raw(void);
+#endif
 
 #endif /* _ASM_ARCH_SYS_PROTO_H */
diff --git a/arch/arm/mach-versal2/cpu.c b/arch/arm/mach-versal2/cpu.c
index c2173161fd7..c1cd4aef508 100644
--- a/arch/arm/mach-versal2/cpu.c
+++ b/arch/arm/mach-versal2/cpu.c
@@ -22,6 +22,7 @@
 #include <asm/cache.h>
 #include <dm/platdata.h>
 #include <linux/bitfield.h>
+#include <linux/delay.h>
 #include <linux/string.h>
 #include "../../../board/xilinx/common/board.h"
 
@@ -323,6 +324,56 @@ __weak int zynqmp_pm_ospi_enable_linear_mode(bool enable)
 	return 0;
 }
 
+#if !CONFIG_IS_ENABLED(DM_GPIO)
+int zynqmp_pm_ospi_flash_reset_raw(void)
+{
+	/* CRP WPROT */
+	writel(0, WPROT_CRP);
+	/* GPIO Reset */
+	writel(0, RST_GPIO);
+
+	/* disable IOU write protection */
+	writel(0, WPROT_LPD_MIO);
+
+	/* set direction as output */
+	writel((readl(BOOT_MODE_DIR) | BIT(FLASH_RESET_GPIO)),
+	       BOOT_MODE_DIR);
+
+	/* Data output enable */
+	writel((readl(BOOT_MODE_OUT) | BIT(FLASH_RESET_GPIO)),
+	       BOOT_MODE_OUT);
+
+	/* IOU SLCR write enable */
+	writel(0, WPROT_PMC_MIO);
+
+	/* set MIO as GPIO */
+	writel(0x60, MIO_PIN_12);
+
+	/* Set value 1 to pin */
+	writel((readl(BANK0_OUTPUT) | BIT(FLASH_RESET_GPIO)), BANK0_OUTPUT);
+	udelay(10);
+
+	/* Disable Tri-state */
+	writel((readl(BANK0_TRI) & ~BIT(FLASH_RESET_GPIO)), BANK0_TRI);
+	udelay(5);
+
+	/* Set value 0 to pin */
+	writel((readl(BANK0_OUTPUT) & ~BIT(FLASH_RESET_GPIO)), BANK0_OUTPUT);
+	udelay(150);
+
+	/* Set value 1 to pin */
+	writel((readl(BANK0_OUTPUT) | BIT(FLASH_RESET_GPIO)), BANK0_OUTPUT);
+	udelay(1200);
+
+	return 0;
+}
+
+__weak int zynqmp_pm_ospi_flash_reset(void)
+{
+	return zynqmp_pm_ospi_flash_reset_raw();
+}
+#endif
+
 U_BOOT_DRVINFO(soc_amd_versal2) = {
 	.name = "soc_amd_versal2",
 };
diff --git a/arch/arm/mach-versal2/include/mach/sys_proto.h b/arch/arm/mach-versal2/include/mach/sys_proto.h
index 30db724bc2c..5a903a0881a 100644
--- a/arch/arm/mach-versal2/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal2/include/mach/sys_proto.h
@@ -23,6 +23,12 @@ u8 versal2_get_bootmode(void);
 void versal2_timer_setup(void);
 /* Overridable OSPI AXI-mux select: weak MMIO default, firmware override */
 int zynqmp_pm_ospi_enable_linear_mode(bool enable);
+#if !CONFIG_IS_ENABLED(DM_GPIO)
+/* Overridable OSPI flash GPIO reset sequence: weak MMIO default, firmware override */
+int zynqmp_pm_ospi_flash_reset(void);
+/* Direct GPIO reset sequence (EL3 / no-firmware path) */
+int zynqmp_pm_ospi_flash_reset_raw(void);
+#endif
 
 int zynqmp_pm_wait_mphy_tx_rx_config_ready(u32 timeout_us);
 int zynqmp_pm_wait_sram_init_done(u32 timeout_us);
diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index d09e92de1b0..6e6724653b7 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -869,6 +869,20 @@ int zynqmp_pm_ospi_enable_linear_mode(bool enable)
 }
 #endif
 
+#if !CONFIG_IS_ENABLED(DM_GPIO) && \
+	(defined(CONFIG_ARCH_VERSAL) || defined(CONFIG_ARCH_VERSAL_NET) || \
+	 defined(CONFIG_ARCH_VERSAL2))
+int zynqmp_pm_ospi_flash_reset(void)
+{
+	/* At EL3 or in SPL the firmware (SMC) path is unavailable */
+	if (IS_ENABLED(CONFIG_XPL_BUILD) || current_el() == 3)
+		return zynqmp_pm_ospi_flash_reset_raw();
+
+	return xilinx_pm_request(PM_IOCTL, PM_DEV_OSPI, IOCTL_OSPI_FLASH_RESET,
+				 0, 0, 0, 0, NULL);
+}
+#endif
+
 static const struct udevice_id zynqmp_firmware_ids[] = {
 	{ .compatible = "xlnx,zynqmp-firmware", .data = (ulong)smc_call_legacy },
 	{ .compatible = "xlnx,versal-firmware", .data = (ulong)smc_call_legacy},
diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
index 949ef5ec121..1270e061364 100644
--- a/include/zynqmp_firmware.h
+++ b/include/zynqmp_firmware.h
@@ -412,6 +412,8 @@ enum pm_ioctl_id {
 	IOCTL_AIE_OPS = 33,
 	/* IOCTL to get default/current QoS */
 	IOCTL_GET_QOS = 34,
+	/* IOCTL for OSPI flash GPIO reset sequence */
+	IOCTL_OSPI_FLASH_RESET = 35,
 };
 
 enum pm_sd_config_type {
-- 
2.25.1

