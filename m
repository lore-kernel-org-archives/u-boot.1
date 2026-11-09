Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC7B606A323
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eJmLyWZF;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vYfXCRgH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7762580DAC;
	Mon,  9 Nov 2026 12:56:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CduTk_QlkGfM; Mon,  9 Nov 2026 12:56:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C5DBF80DB1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794228969;
	b=fr3fyTd5pP6UU67as4Z6lvz/Nu1YFF/Ay6ca25ZcWBfyUuxVUntwLTfTmcaFBHwHAlx1
	 JZGrhki+MuYk/ut5b2PU0A6S4XrDsgRYnAg8H/XAwOym9mY2tZNjAUWNc3pFqZogjrhkB
	 WcrL0JkeeTsaSUwzR0yQEKLJ6SU0W8V9fn4+pl2Z9IGSIJF2rdiX1WeqeTwstubOZDqbw
	 /N21BjG660zdc275uiNgPv3aHI/SkRL1Fe97amVk+MgQsQlAvzTanUc6EXdJshzDeJGu9
	 apDaYijtzGUYeHEbMIl2RB+hSHP1r8wY4glO9TcLXVYLK5HYJUdcscJMliq2DA/cQ/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794228969;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:Content-Type:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0r5iE0afP4orozyYX8AukzWpNNP/fHCWhj2KI5TZabI=;
	b=PZRX68tBGPAMs8jueYVXj2LNZRJbGAFP1rpZu1vp9i4HZRI7Jpb29IaARFgTy4dXalsD
	 rMS2pwQwgGS3JzFgIcgPQ50in8yzGFie7+TLjKfE4aVqw9nGXxOg+M01N0rhX7fgaDZFE
	 qP1vo+3bXRAVsp3T0OgsSbxJuR0BlnUvvcEH7+mUlNODs+kbsH/PfmEQT4ZZ06TT+GvwF
	 YCgH8X7Bjm5Hm3DDrHIhdEpE9wvbKsSE6phPorT1JfABf1rRCHYKlaiN2eEyycEKRcWCQ
	 iqEw35jo8klqg5+K3AcxOE7SakM1GU8J36bbMOtILsKYWWehvoGBF/28dXaNR5lLSdg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vYfXCRgH;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794228968;
	bh=0r5iE0afP4orozyYX8AukzWpNNP/fHCWhj2KI5TZabI=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eJmLyWZF5kwflLY8xoKDPU5oSYSUR/MFiGOgIwUYb+e+PbunMwX0uKtm98kvkxcl9
	 +s42AfiXRBfEWgdUrloZkDBVz+WYr9Lamb4pmjkN3V+ZmTcEejJ6udJQBrnNdwnDj3
	 hwlzwrvmhaBcX4qazRfre/zOChybwXrexpB7mya+mLukuvOialUrCQA+UEfCxjk9x6
	 BtSzN8O1ONMCCi9OEkEkSvghCVqWogPmbL8z/pIcAiqQUctnQ1w2R03WREzcRQSj69
	 8QZjXnM/uOIwwqyirT77eWb6lcZ7kBHzgGgLrqOdhxsMW8zsGqvt4yEXYLzkDtlGC6
	 YdXUzhvoNtFYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5DBF80DB1;
	Mon,  9 Nov 2026 12:56:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DDD2111
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 12:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0324D80DB1
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 12:56:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UWBc1Ec9xIoE for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 12:56:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CFFAD80DAC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c110::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::1;
 helo=bn1pr04cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=vYfXCRgH
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CFFAD80DAC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 12:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0r5iE0afP4orozyYX8AukzWpNNP/fHCWhj2KI5TZabI=;
 b=vYfXCRgHbvjqLmh115bOcAitucTqKZ4Op41gauvCRZfEyST0X/bSItR3mmfMDnan3zquYQB7NoLHDU5JSOWs/IglcJlehZip3QnaARGAJTVi2QACScpbz+NDQMVwK+DckeYiSkYAObRIA2w6bMAwrGDGmY+7mTeJu8r4XoMGWU4=
Received: from PH8P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::28)
 by SJ0PR12MB6808.namprd12.prod.outlook.com (2603:10b6:a03:47a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:55:59 +0000
Received: from CY7PEPF000000E9.namprd04.prod.outlook.com
 (2603:10b6:510:2d7:cafe::3b) by PH8P222CA0027.outlook.office365.com
 (2603:10b6:510:2d7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 12:55:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000E9.mail.protection.outlook.com (10.167.247.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 12:55:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 06:55:57 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 06:55:56 -0600
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 06:55:56 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH] board: xilinx: mbv: Disable -fpic for SPL
Date: Mon, 9 Nov 2026 13:55:43 +0100
Message-ID: <7e8bd7c06a0b5b32ad8b38b3a5c0bbd06c618321.1794228942.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=855; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=aSPpHSVKw6ny7rWPlDRW9VCn1VPFns7ZDDMsfjbWvSU=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR9PHSVPzogr/uj9lXlmH9V5fn9567fSsoIbT27zey2g
 u3t1uc1HaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjAR892MDF/kd6bodrw8sjOJ
 077hYv2/iTm38xaeSu3ckfPbd67hDUlGhmWSeU/2LVBTmHgt6epZrav2ZgJWSxM/3dzoHrr/b9p
 +VSYA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000E9:EE_|SJ0PR12MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: bec628e6-694a-4ff0-f893-08df3e60ccb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|18002099003|10067099003|11063799006|56012099006|261026121527099003|261102123227099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Je8pmA5t7egHd8H4t0ANkZtk9h9I7lWIp53U4G/ZWI2ba+TnkyM815+w4t1V5S1k3tql8kNTtqQDxAdRyNEsCu7HbH3YDguZipgGiLEx6K5xXaXnXDH8OZxWetoU1vg6TXijeiRefEy9ZFTTrgAdpc3DtGiKMH8ihBQYBV7rTzrSvrSYVJJ1M8YnSUjelqhaoiwUDM16ZjK/O3C4W8c9cQYcLkDn6QaDAn+r3oYITmrhc8MQtxQNHp9Bk9gpa83QGfFUxfDdSV6AoIbtIYg2RAwIru/xZN/pcqvQoJCbz8CM8w617QLUjLdT1a7rFwach90K+84I/3aZSquPZCSRs6g9VW5gaFg6lN6PPb4LVJqnHGQFGOCKBSRGI2tNcVGCenPYhdw4CG1hcgRwL4bkAqVdyXisuVPKdk05Tn5KXrKFhN47OId/QxTd7vKePReMTzgxMmLyDGWzng+hPIwvgGIJIu3ZTB7bnk+eJYBIOJyjK9NQrmdSD2Upv5gYW8aWgpU/O8VdGzgqFjGmpfM2Wp0DdQsALdjaTyGOkdjBn2o+dXsubvKcKnlncqfIeokK/WeDjSrxdTSQsH8yWqK0wAJXimn5AscL8YqzitbzNu+jzlcQIZd+cLkBpP+Cvu8MXfpwUamqHjOMo7TDxCS3ZiNDiU9X3EsctSth2RHV2mFJ6HM8GRqf6dPF3hqH5xC5Ehi5ZUWjXg+bDYyvhiNIJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261102123227099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WBuJqFM0tGp1nWdMi4Gb2AtybaSb6L1nygs0BE10x6WchRRtQm5tmZSypdP+t0T9uj2pxvqSLU2rbUa0tVe1rrw55ZWUxQa6/AFw0ozdfj25CZQg2W1Qoxzt+Ke+ZpjqbkGkjf/DzREzORXGR158RU2BHNIqiRYxH8wAoXwxr4P4jszC9av/d66nEAgMx8W4imipv5XrHF7wqx4vWno41Zk8F2YTYhDZqybwcoyFhTPDQ2HGhOA+/0RGyq+/34XQf76slm25/JBmxO37dJ6pPz+ZexyiXPfzUy7NyF6e3fZV0r09l2mxBmhO+OKmQbEm48Wcws+e7Ec8+F8ba+rxAIzU8uJ2hnL6gDdi+GI2JjmHM4Weq13/9sXTxPQ5P6+eIt6IpBVWDrA/1f6Dv4E0sGrkdSVJwUuZ6WFZY8p600qKZp1Llccx7psFcCZwCJqd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:55:58.1395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bec628e6-694a-4ff0-f893-08df3e60ccb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000E9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6808
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

MicroBlaze-V SPL runs from a fixed address and doesn't need position
independent code. Pass -fno-pic for SPL from the board config.mk, which
is included after the arch config.mk, so the later flag takes
precedence over -fpic while U-Boot proper keeps -fpic.

It saved more then 1kB of memory.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/mbv/config.mk | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 board/xilinx/mbv/config.mk

diff --git a/board/xilinx/mbv/config.mk b/board/xilinx/mbv/config.mk
new file mode 100644
index 000000000000..ec4d0412c27e
--- /dev/null
+++ b/board/xilinx/mbv/config.mk
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+ifdef CONFIG_XPL_BUILD
+PLATFORM_CPPFLAGS += -fno-pic
+endif
---
base-commit: 4b2c5fa37b4ce7235de2908f20ba433e79626ffb

-- 
2.43.0

