Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B8BC53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 19:34:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1E6880F18;
	Wed, 29 Jul 2026 19:34:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HH_D_NwQe9xD; Wed, 29 Jul 2026 19:34:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B1DDF80F1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785353691;
	bh=aumTO0fdzpQGgtMmsiQgBQmZuY0sHraVxIMWhp6xK5Q=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JrR/zFKjGgrzOoWaQyUCg79so4JO/MAHKbcxDCtbRvoX2Btg+5kyPRPe+tB4XQW+0
	 uyoS37jEKWqy4W754Ez6qAijHmLFe9m52YQ6pgCXN7eIJMQNRHqfr4bB5eDZ3cJ/Kh
	 K9ZRP5d2qYS5hl84u+k7FateNVVEd3PzD1O9USNxJotMbb6698G3lJbR4iGZxG7nCd
	 K28FsnSrIdGLF4W7XHpUCMXvBwoNdRQx9drKgtttQlygN49HyUw40Olm83saAOyXhT
	 EANuugG2UDi3kvJreHzqj+Y92+Vpd471IxI2Cu6LmCYSKzMto3lwn43ro+IjlllSOK
	 FuCQ/P0+hFShg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1DDF80F1A;
	Wed, 29 Jul 2026 19:34:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4463927B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:34:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 29B49400AF
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:34:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T9qgA2Xh4XeD for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 19:34:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=rs@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 34D9B4009C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 34D9B4009C
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 34D9B4009C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:34:47 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66TJCEZ23283880;
 Wed, 29 Jul 2026 14:34:38 -0500
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013016.outbound.protection.outlook.com
 [40.93.196.16])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fqqfdr4d9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 14:34:38 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mD959DM00rpTlpaQuMbm/eiJfNJUiM7lS0QND7M5xrCZjT3F1bJTk2kbOfLjBU15MXe3uJcHw0jmRJilz7UxeTpLKluo+xGxdcRav08tZEgx5fWi2HtUXmHK9YZIQ2StwCuVt5JA1JscHMd46pqbnBzjUimxp+2kPW1t/lp5zT0nnspBQMR2ofUPCEvbza6QA2NQuCf6cW9uPUBlSHpFuXG0sKWN64nD0ye+1Hozs3Mjoc55gc6epBRjSIAQaxecvgRinMgvkyaqqsH6VUIyZo+X0SmD0M5gIjAtiMZmUWfSdHOyvzwUukknAQbCG8YDviwNZf8h3HhcCiSMeqGt0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aumTO0fdzpQGgtMmsiQgBQmZuY0sHraVxIMWhp6xK5Q=;
 b=QVfPSNzBt8R1LlXxq/2M5OUPkzJnW7X4EdaHqapnnGLJUlUNmj3VpWo4vv6qkD/zd6zL5dOUBUi6GGNIarKw8euFHdFg6tJzSLncDZeMrezUGYlJ1jfsQR+3EQ840BvCMg9T3ac+GjYq4e/vvSE34UCTD95wBulVNFbJ1HK7FX6FKWy2i5mNc562R9LdCNaBAA973Ge71otwgvbQ8cZrsrOo0zmXonPcwtHbYO8LKaaqDrhIpJnbBYI3n51OF3fsgep7RnB49X5bsBjJgVlZu1g3bV5+fUY+noX79j1zW2fJKRJuCjjC6a07bLk1qbOtyXjM4r8FVa5oH5Oqj9PUzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) by
 IA4PR10MB8659.namprd10.prod.outlook.com (2603:10b6:208:56b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.13; Wed, 29 Jul 2026 19:34:28 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:26:cafe::21) by SA9P223CA0002.outlook.office365.com
 (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.12 via Frontend Transport; Wed,
 29 Jul 2026 19:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 19:34:28 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 14:34:26 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 14:34:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 29 Jul 2026 14:34:25 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66TJYPKT1893221;
 Wed, 29 Jul 2026 14:34:25 -0500
From: <rs@ti.com>
To: Anshul Dalal <anshuld@ti.com>, <robertcnelson@gmail.com>,
 <ayush@beagleboard.org>, <Erik.Welsh@octavosystems.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.u-boot-project.org>
Subject: [PATCHv4 3/3] k3-am62-pocketbeagle2: add support for efi capsules
Date: Wed, 29 Jul 2026 14:32:10 -0500
Message-ID: <20260729193209.798946-5-rs@ti.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729193209.798946-2-rs@ti.com>
References: <20260729193209.798946-2-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|IA4PR10MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: eaae1401-e00e-4260-efc5-08deeda867e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 79K5DpHGR5HtCqqPQbvc3Swg9Vgkh4IH4pLxgAZ5ldqoNXf7PBsP9x9fhYRpbhMue9/Z5UJ0wl/XK4XgC77WGRGo3I/EV5EClNnbWNdc3e1ePUXadsdMYwy71xAo2NddpihN/hET3Y8RTZLv8/BYwq46CceoJkQejgXk1nq4qXFiLbj8IH2456q1uTNQkys/4vaipULBpbyL4P3Wk5N9vl11rsJOFdAqzCzCZWpcHrqjPAPqgAHZpcDgsQfOlCczBY/vmTmuFXe18BCSZQsjpIT3DCi9Doma0/DVB77Wth+bzL/eMXArDcb76n8+3hEJxeMVFOfddqkFJv9CXLEmPw405O5ugKM6lOBH14ODx91WkqESkzcSWYylywB1Hztokvkt6b5N4X8lKdq84nPBd3VMpV7Jyt4WH5it1lx9drndvqQXrICOFuMY/yifHfO7hT8HMYmVduXXffXKRUWaXJq1uBAT7EpFuGYHpNhTWfzQUdluqdTWQLoB5YlnyMYSyUhxWVOPeP8+rj/gHTfOK1a8tOLWPLlDl02kHDdQgFDTxY7+6an8LloMhww5iUXOgth1jKX5OOIY/438LSqawv6qEWkNblxACBcyxsgW88+3oKElDtphZyA+jhaTFejOHwW1/0/RFp9CNDsvmuEZmt3S1+ilhHl9SXmWN0bp0Klo1bdPB0cS6avN1A/aF2vnQA3z510ONChVeODsW8Zigw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ND3kcdd6e6kQfiaNEWKY7MD2sfSgQJ0LW70Wt5CwLPO2dgYBOfftciKhs3V2R2oKV2w3BpjDbvdh+yxRsOyRgcBag9zsSmuqQq3+hBtxtuv/ZHKhyl0RuPEjzFM6UiOl7Z1+0Bh5xDzioqXnTSMLlHeCeGNmlXu9bpC+Ts1bisNxrJiaO03HoyxvUOhXpYFQidbkz6hHVBm20r8JqRkYkqvwFGSAuvr3s0jUrwpZN89MpsYdUuLV9LiE1TvzgwujrSL8bqu+0TOJfoYrIs8SCk3GhtNIK/H08n2XcX+JvGyTutXgKBhlLyuO++Usi292hwhRiu88qDy08njqUf+0LT+NQLcsFanvw29bzTewmbOZMwohmWLIGKBw+1s0p13LTO3DhqN2WgzdOR6SImf4QzqHmNKfXi29BQH6W7Df2RW3zlcl7cTR6sMDBgQbkvbf
X-Exchange-RoutingPolicyChecked: TPWvVPySV9s8vhfwX4CYTms+P2YNpnTpy5hMUFp+OOW3v3BPsmQxPhQguQVTYT0s6cEmArtGuINb26rl+FtlNlerQ1wosg085sIEQrFSCsluehVXoTuNs+iZbkYU/Y5eXHoev2tjeAnycg292EUJ4ITnaPv7ATkfAxXWmwlvFlrG9h4zOjrNKy1GJ4Ys8EeH6CXwMh5QbvMEuQs3D4GueGL6c00MNMm1LQM/aduZl6YXo2Oo6QA+Bv8EM6t7whAgNQ8oXZ+KLOITJ4JwZNCJfnxBLUObcdtQhGgwRPYuKefEv72p/W0O1IGFAHtPYi/eKW7TTEhOBsz+6dDDw4U/Kw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 19:34:28.5902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaae1401-e00e-4260-efc5-08deeda867e6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8659
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE1MCBTYWx0ZWRfX3LhZvqbJm+Ju
 2tRR2ymID9HHnSQFdPEA2UQ+sEANZfbFUnSGLzgTg7slrbayGL62NZQu5srXAMY2qGPZroFPs6N
 6hVJ9ZpscxOZmXVr8KSonPOkJEUgGri6L9nMxnMNdSxpLq9RWteB/lEofYfyvccfzeDnc1ozPUN
 346aAudDLB+pbPxnnSd4SgvVo1nHCTbnTMVitl7/Yk5DAlvpsmXWoNAj3xOpgvrlNHcqi1Fh6Y5
 MjO3yWt8118XUY/tJpLk6BWQytY9xcOto88xzXsQ1ln1K6nskO9QGMDGUyp1jPqAPuheNs7lW/D
 JhjdMGfvGKi8R7NywB4KRNpsT6j1cDmh74BOZy8/gssP8bpZ349czJlTNaDAXqe74RC9ltYu4Ym
 sng1qAan9cd3/PsnTKhcw89CYr8qMAIfXUeFGpkMx50l7v1GdwX6lhBFFN8HzyF2fNcPrSTghCd
 H5/EKdSXAokXt7gSuQQ==
X-Proofpoint-ORIG-GUID: 0duktp8nNbrTI3GTQfVn0Ton8avG0no3
X-Proofpoint-GUID: 0duktp8nNbrTI3GTQfVn0Ton8avG0no3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE1MCBTYWx0ZWRfX6vGtTkYxvTw8
 fuLXZzHjGLxx7QtuYGpZHAg6PBwC3lN5msXPL6G0VZufxMI3psoIPVhE1AxhVjqIm1kQITC0Mb6
 hXaIhv0VmxxwDIVwydGB815CYKngAzs=
X-Authority-Analysis: v=2.4 cv=Yt0/gYYX c=1 sm=1 tr=0 ts=6a6a55ce cx=c_pps
 a=26rO91Bbw6QoawbNyte6AQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=fGhLjsSNAAAA:8
 a=496d86qWRiBu538VFjQA:9 a=LYKFdyShAPKLkGq8p7WX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_07,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290150
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=aumTO0fdzpQGgtMmsiQgBQmZuY0sHraVxIMWhp6xK
 5Q=; b=c/PsXHVTF5RvbxXA4e6O6uOFemF7j9xYvaXO0B1i5Sl+IReh8k/vEkZ1S
 YGlgiIQew0xLKVJR9O/J+9iX5nQ3XuQ/NJ8XWtkSCFGnweFY7jpWDt/u3/cuptd7
 n7rXQeWWmAsNLP/vWn8axATdcoKAfA4/csm3prwWXFx/9xVdnMfYcqHUjs4BSmY3
 FTNmyJdxMsIpN9EcpItuojvZpTh+FKvBY3O3xpuV4FO6wjkLi36LAM8Q25J/z2+c
 noM9AYX3UjGrbMuM36+tGM0cMr725/sZU6H6gTmNKOVVofpXsJAHlliTtoXdu2nC
 t52WrEZj6pIPQboiSiVRDOHNGhytw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aumTO0fdzpQGgtMmsiQgBQmZuY0sHraVxIMWhp6xK5Q=;
 b=eSttK7nrhpvfxfBp+adxmku8XohMwQxzMHAzEn4QG4VcJMlYzf9bvPoyt0UedKP3RYbN3ECZNKHONVqkd1wZsGKYygMzJ7BRBW0kZpXbkmwFhCs/8CaWUb8L7Ri+PYwXYWbjXztyABpoQXW9AIQrSfmk1WvD5l6p8569tgcnJWM=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=c/PsXHVT; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=eSttK7nr
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

From: Randolph Sapp <rs@ti.com>

Add support for EFI capsules for this device. One large caveat is that
the partition holding boot binaries cannot be the ESP partition due to
the following ROM limitations.

- The boot disk must be MBR
- The boot partition must be labeled 0x0c with a boot flag

A separate ESP partition should be provided for EFI capabilities.

Signed-off-by: Randolph Sapp <rs@ti.com>
---
v3:
	- Remove unnecessary dfu_alt_info_ram variable
---
 .../arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi | 29 +++++++++++++++++++
 board/beagle/pocketbeagle2/pocketbeagle2.c    | 26 +++++++++++++++++
 configs/am62_pocketbeagle2_a53_defconfig      |  1 +
 include/configs/pocketbeagle2.h               | 25 ++++++++++++++++
 4 files changed, 81 insertions(+)

diff --git a/arch/arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi b/arch/arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi
index 452161115318..283e26380e48 100644
--- a/arch/arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi
@@ -181,6 +181,17 @@
 		};
 	};
 };
+
+#include "k3-binman-capsule-r5.dtsi"
+
+// Capsule update GUIDs in string form. See pocketbeagle2.h
+#define POCKETBEAGLE2_TIBOOT3_IMAGE_GUID_STR "F0D53723-106E-5346-8A41-85EB2D07C720"
+
+&capsule_tiboot3 {
+	efi-capsule {
+		image-guid = POCKETBEAGLE2_TIBOOT3_IMAGE_GUID_STR;
+	};
+};
 #endif /* CONFIG_TARGET_AM62X_R5_POCKETBEAGLE2 */
 
 #if IS_ENABLED(CONFIG_TARGET_AM62X_A53_POCKETBEAGLE2)
@@ -304,4 +315,22 @@
 		};
 	};
 };
+
+#include "k3-binman-capsule.dtsi"
+
+// Capsule update GUIDs in string form. See pocketbeagle2.h
+#define POCKETBEAGLE2_SPL_IMAGE_GUID_STR "C73FDEA2-3964-58C8-8A25-E55102172E1D"
+#define POCKETBEAGLE2_UBOOT_IMAGE_GUID_STR "520E1012-DE6C-5992-B43A-95D53D8332F2"
+
+&capsule_tispl {
+	efi-capsule {
+		image-guid = POCKETBEAGLE2_SPL_IMAGE_GUID_STR;
+	};
+};
+
+&capsule_uboot {
+	efi-capsule {
+		image-guid = POCKETBEAGLE2_UBOOT_IMAGE_GUID_STR;
+	};
+};
 #endif /* CONFIG_TARGET_AM62X_A53_POCKETBEAGLE2 */
diff --git a/board/beagle/pocketbeagle2/pocketbeagle2.c b/board/beagle/pocketbeagle2/pocketbeagle2.c
index 291a1c6c3db7..acc694c253ea 100644
--- a/board/beagle/pocketbeagle2/pocketbeagle2.c
+++ b/board/beagle/pocketbeagle2/pocketbeagle2.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2025 Robert Nelson, BeagleBoard.org Foundation
  */
 
+#include <efi_loader.h>
 #include <env.h>
 #include <fdt_support.h>
 #include <spl.h>
@@ -19,6 +20,31 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+struct efi_fw_image fw_images[] = {
+	{
+		.image_type_id = POCKETBEAGLE2_TIBOOT3_IMAGE_GUID,
+		.fw_name = u"POCKETBEAGLE2_TIBOOT3",
+		.image_index = 1,
+	},
+	{
+		.image_type_id = POCKETBEAGLE2_SPL_IMAGE_GUID,
+		.fw_name = u"POCKETBEAGLE2_SPL",
+		.image_index = 2,
+	},
+	{
+		.image_type_id = POCKETBEAGLE2_UBOOT_IMAGE_GUID,
+		.fw_name = u"POCKETBEAGLE2_UBOOT",
+		.image_index = 3,
+	}
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "mmc 1=tiboot3.bin fat 1 1;"
+		      "tispl.bin fat 1 1;u-boot.img fat 1 1",
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+
 int dram_init(void)
 {
 	return fdtdec_setup_mem_size_base();
diff --git a/configs/am62_pocketbeagle2_a53_defconfig b/configs/am62_pocketbeagle2_a53_defconfig
index 8964cb3b1955..7428926a8ba6 100644
--- a/configs/am62_pocketbeagle2_a53_defconfig
+++ b/configs/am62_pocketbeagle2_a53_defconfig
@@ -122,3 +122,4 @@ CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 CONFIG_LZO=y
 
 #include <configs/am62x_a53_usbdfu.config>
+#include <configs/k3_efi_capsule.config>
diff --git a/include/configs/pocketbeagle2.h b/include/configs/pocketbeagle2.h
index dd6956aa8b90..aed60d325742 100644
--- a/include/configs/pocketbeagle2.h
+++ b/include/configs/pocketbeagle2.h
@@ -8,6 +8,31 @@
 #ifndef __CONFIG_POCKETBEAGLE2_H
 #define __CONFIG_POCKETBEAGLE2_H
 
+/**
+ * define POCKETBEAGLE2_TIBOOT3_IMAGE_GUID - firmware GUID for PocketBeagle 2
+ *                                           tiboot3.bin
+ * define POCKETBEAGLE2_SPL_IMAGE_GUID     - firmware GUID for PocketBeagle 2 SPL
+ * define POCKETBEAGLE2_UBOOT_IMAGE_GUID   - firmware GUID for PocketBeagle 2 UBOOT
+ *
+ * These GUIDs are used in capsules updates to identify the corresponding
+ * firmware object.
+ *
+ * Board developers using this as a starting reference should
+ * define their own GUIDs to ensure that firmware repositories (like
+ * LVFS) do not confuse them.
+ */
+#define POCKETBEAGLE2_TIBOOT3_IMAGE_GUID                                   \
+	EFI_GUID(0xF0D53723, 0x106E, 0x5346, 0x8A, 0x41, 0x85, 0xEB, 0x2D, \
+		 0x07, 0xC7, 0x20)
+
+#define POCKETBEAGLE2_SPL_IMAGE_GUID                                       \
+	EFI_GUID(0xC73FDEA2, 0x3964, 0x58C8, 0x8A, 0x25, 0xE5, 0x51, 0x02, \
+		 0x17, 0x2E, 0x1D)
+
+#define POCKETBEAGLE2_UBOOT_IMAGE_GUID                                     \
+	EFI_GUID(0x520E1012, 0xDE6C, 0x5992, 0xB4, 0x3A, 0x95, 0xD5, 0x3D, \
+		 0x83, 0x32, 0xF2)
+
 /* Now for the remaining common defines */
 #include <configs/ti_armv7_common.h>
 
-- 
2.55.0

