Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F741606A334
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 10:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mY45MdK+;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jRb5v2gU
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 448DA4051A;
	Thu, 26 Nov 2026 10:29:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M69b1b2Zr2id; Thu, 26 Nov 2026 10:29:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8F48940566
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795688965;
	b=thcKD+bAa2zoewvzdDy3wsx0UUpFz97jbZMCtLzaXIhjKVM3p4uqpF1fndGjEtfyL2lR
	 ssVfd+zX5DehqYwcn/v+0xZJqSHgK11LXr/maqUV56j+drSZRKorWKZx1Kix7+6jKO97q
	 iljIk4wYW0daq9vSNeKDdug4FXckS7MR/OKjqn485CbDNvJL1V3eoDJ4ztLfprI1LPFJ/
	 nGZXlKtQsVoUCcXLPyDCc6wldVAu5phh5oYU3ycDDkIOIZ3tW/WF8dIvBnyb3E8tHXGfY
	 BjUSmzaianErD5ZfNCAws3aJk1qlSKmkbI4li4aQiI9xOHHL8f3h5VO/Bu/L8gWbI2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795688965;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vVZOBmXwke5yL4eD6vh6d5ceoUcnfrduLEVYS+eDLZg=;
	b=QMFYcI6ylJxfv2eiwKy+Nx1q3ek0o/bEzyn7gSvfZQhE9KYmV7xwSt/0LlJtKriCB3XE
	 zalsvnolzomsK9fus5Q0Xr/J99GHqu68v9k3BKWltHp1KNmcUM3ke7re2ZeXqvr7Hq3BB
	 EpUx+sWYbvbe99bhZrdiWPxNvrKYun1uTiMuPhjR6y9GrNm4tVrhq7U74by4vZq6xwIEd
	 WMEuHZhHJZ3II7dTWrzQsFFxREb51vxnuRcsXYOBZuTUd9+Hks2wNSTHKhmv/NBYf3ZWs
	 NcokFXYZF8zNBqtiK/b+sZKJZFnXFYDuevBr4purYhSF8RIO97IfT61eSvbLwiajymg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795688965;
	bh=vVZOBmXwke5yL4eD6vh6d5ceoUcnfrduLEVYS+eDLZg=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mY45MdK+JCnaXl/EB+v00d/Gq6l3uuVqHHFPb+D2eGKcRfXR8AIKBUtVLTIo7NsLx
	 ot1hgellEfF2OJoTiVYctzbQmE35Lm66XVc2QSzmXeO8lcSf6vDvh9or9/BzhAWkjt
	 3PbutewWA/VY1ysAf4fJSJB2xtUr8GvunYAClXqvRiwR1sTjLnAYNKAEyWnnU7SIZC
	 Bgucn3Qx8lNrx4ybNnQdAhL99ka9UqQL2glhEofi8jcY1h1cn/IEfz5hvDkIO0+4pw
	 wyy1V73BQeknVhhTcrhTVQPfQX4V/ff08EI1HD9CDaARWt4POKPda7/wTOvwv4QKbe
	 NjWuLDVOup1jA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F48940566;
	Thu, 26 Nov 2026 10:29:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 247FA325
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:29:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0ADB2400D7
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:29:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yc78MTcBPmry for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 10:29:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 46444400B5
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::5;
 helo=ch5pr02cu005.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=jRb5v2gU
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 46444400B5
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVZOBmXwke5yL4eD6vh6d5ceoUcnfrduLEVYS+eDLZg=;
 b=jRb5v2gUCLi2QAAz4nPYUIykRfrlzRZ+QUKm73es10Jhx0O8ODq1tLSyoHLapB5FynQakxAFdT2krrQ4nxxlwqxyNXOoqNtE9rcd4LUiB6R7NjUT4TBE34vhuU/pu3t9iqz21mq5A31CY8g494ZdNKrbDrBQvIfezG4Z1hpa6p4=
Received: from CH2PR19CA0023.namprd19.prod.outlook.com (2603:10b6:610:4d::33)
 by IA1PR12MB6483.namprd12.prod.outlook.com (2603:10b6:208:3a8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 10:29:16 +0000
Received: from CH2PEPF000166C2.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::30) by CH2PR19CA0023.outlook.office365.com
 (2603:10b6:610:4d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 10:29:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166C2.mail.protection.outlook.com (10.167.244.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 10:29:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 04:29:13 -0600
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Thu, 26 Nov 2026 04:29:12 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>
Subject: [PATCH 0/2] riscv: dts: mbv: Add BRAM and ethernet device nodes
Date: Thu, 26 Nov 2026 15:58:30 +0530
Message-ID: <20261126102900.263559-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C2:EE_|IA1PR12MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: 02130f17-d48e-4c81-0c4a-08df4ba81ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: gEyPggNrKcaKjgqMX2MasKhRvEazh5mI58p+ge4gWxIBu5zFvALsIxsOy7WI8zNBN5zYNOZ8hP6WR05vfnIgWQfiFa2d9mT02M98XN/RlvmevKuTNRX0FNw2uWJRVRV4ncR2WQ6AyZtw4lk7NtuTm6f7ddIW2xkKPPqg+EPoRVzMU/rVaHqOOiAovc6nPL60UhItimjMPUMikN3L9MEQOZT42HZ/J5OGK04l2iZWQ7S9/QZ26s2kF/CaWwYjJD8xzZXavYDVa1ZmBaEGP0pN1AIFBx2HfqqfnCSpiITh4d8Wu4TARM6aP1Y1P+fAKi7VkVTz0RrsxdBxj7dfo3GboHQ1lc7AyxkXCRJSzVPauZzJCttHDSwOBoyHB4oestlNNmpXgEgcihadn2cBUofPNOHXpdZzTRnL/q/kRfrklSBR2MyCol/nF6Zp4W7BtZ2JPrnzwSdnvFfsujFytl0CpnDVLQL99Pcsbyd73lyu9w6Z+1MS4l6EFRLz/PK8qpg9OWivpq4QA4i55+UgNlzMVyhKMefQuxcbMuQB0xSRheLz9iYKkjLbJ5jOFdouCJvJi9f5Vq9TmyWcZsRXETjtTX6wkQsaM8Om5oaiRjg1SIPEYeSW9LONtdeyxpS8eGiiBTDJ90+j8h12FY1YHR0Q9GQMrCPgwHZ8BvM42kmE/jwVBxpEbXT7/BCwAMIHlyRzIkhqBTDwJBMyb/t6SurdWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SjcL8NZO2tuwLL5fF7PqWvaSZ/tv3b4bD4RuQATB+nj3vITXPPNaj2GYtrqEeZ8HdBFJHjOlcqAlxyYNtaAQVEbGXQ1brokgjp6+ihmwP7FL07vTsCq2RLqt7Vo2MkR1UJ3Wqc3wFwoqevg+xKk7k3JVa3x7tTd6ScZuhCcMr3SP6DVLPxhpyo1HwZEGHM1guazCvS7nEN5FTjaBnUGQYW7pa4zw02qnHSXCS0hO3bHBqd3MdMfsBa07MIPStKutRVT4duqGt4s2xDz9aN0pefsC7CZpm5ooxQcZMbqf2U6NqI2UP79wmywc5M5FyhxwF9nlpTPQGvg81M3AuCQKlnH9CmN1Rq9ulAC76kKI6vzz5l4KH570h+/gC0q2chxyR6K6o+H11yH5QffRdcf5AEOsejryaOhlualneIs7aywfU7uTHUB5YKMMLMSrJ0/m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:29:15.2347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02130f17-d48e-4c81-0c4a-08df4ba81ec4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166C2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6483
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds device tree nodes for the AMD MicroBlaze V (MB-V)
platform that are already modeled in the QEMU amd-microblaze-v-generic
machine.

Patch 1 adds the LMB BRAM region at address 0x0 (128KB) as an
mmio-sram node.

Patch 2 adds the AXI EthernetLite (0x40e00000) and the AXI Ethernet
(0x40c00000) with its AXI DMA (0x41e00000).

Both the 32-bit and 64-bit MB-V device trees are updated.

Padmarao Begari (2):
  riscv: dts: mbv: Add BRAM device node
  riscv: dts: mbv: Add device node for ethernets

 arch/riscv/dts/xilinx-mbv32.dts | 63 +++++++++++++++++++++++++++++++++
 arch/riscv/dts/xilinx-mbv64.dts | 63 +++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+)

-- 
2.34.1

