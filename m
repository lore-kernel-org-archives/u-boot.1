Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACFAC61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 05:13:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29D3040685;
	Thu, 27 Aug 2026 05:13:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ETN8rghUYOye; Thu, 27 Aug 2026 05:13:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787807580;
	bh=P//m40g2WAmzbFsGZREp/rh7YhMIPU9+FGQPtaFUbPU=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nLi9UF6WTWdsjK5LO/8EnLk4yed+JKYsOpKH0aNwu1aTpVOw6CPg9AYyJpm+U3neg
	 wlAyeu9dbnhE6HxTz37SGWUBWJDzsDt/ot+b4pNbboc5NgUjy6SSetsHakAJ+2Ff7T
	 BNcp07zwBVbFYQ/6pavwmj6OxJq9yhHDhaYxer5/JIVe3EZf3i2BSfKb3h28CZG4o0
	 PPS9P6AbO8ef2GyqPJFmzSoN/2WXR5hXHvMKpXOQr34ojPQF1hJkj8N/BLJp7tFOuH
	 ygZ3FbHaVhNHw3m5RIXwKJbuGK8eVkp8tqW/k2GMmfBWskQGyOX8xFve+LjIQl+OAw
	 KzHhL23THghaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F346D40633;
	Thu, 27 Aug 2026 05:12:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 02DED78B
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 05:12:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E66264013B
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 05:12:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id csumHQXlXsyE for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 05:12:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::5;
 helo=ch5pr02cu005.outbound.protection.outlook.com;
 envelope-from=pranav.vinaytilak@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=csBckKrY
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EBB634009C
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 05:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhxU0w/pq7e0mN0GW2QMuYDC4LQqkQJABg6INCcJTj8lOwEVd6DULBmMa6nTtDQ6fJ2fWC+SKzTJIWV2mponCWk5wJp51S1nBadtk1uyXgAGDsaNCiiy92N9PqEwDwqujugJK0B7TXaivosuO6jsJZw75ChZIysE04opJnn5QCyAf52I5dlOMsA8O9vRVrY8DmLFrNM48CiVoQQFhnsS0hwtr0wKoPK/L+6GSUV8TYKND5bsJmV4WBqX9n8Iib0tJC6lonQAO8hLHBmMV3QWlemqGS+4hpiY6cI5VHa7SIsHUcEcHrAIR9iIoazvxHm3BosiydgpRBczUwRF2j4XGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P//m40g2WAmzbFsGZREp/rh7YhMIPU9+FGQPtaFUbPU=;
 b=n5vRqfwI0U5UuIN+h7azE7NgDpvdDe+6B3MXK0v6kR59aLTuL29ZWbH17NHeNCIFDCa4ULVBiTOoXjK51wy70rMqbrvupZ761+tSlhEgYDPhmsyNI2wXUceAlWsG0KrinLrbeFF6l67ZeWhceKRTTFo3jG2TQKVTO5Sv1J5nV5i2HeT/bAi4fWT30vM4HGrGp/lYPKVV/Gh8THA/RClf4OSyLM0sTrou6eP1H5ae+GWdtY58jE6ATH7LeeFUMg9D81ZseuGZU4EkzBwvwapJW/3uQsfVeiMkbBvS/diEAlQ8aW4T+T6mhplFGBv4WwPXkoEA+RBvlAdN2aaMIxJq8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P//m40g2WAmzbFsGZREp/rh7YhMIPU9+FGQPtaFUbPU=;
 b=csBckKrYzkCne+TYFBb4rvm7yVWrG+ZJPd5MUNxCQPymHp44sGu1nW1s+AAC0h286IxsErmNL6L8nyCfquH5sHN4wlop6Rd5BPEiCx6pCrHXgqpfSJFUfcsIxVgW2JRKSdxXIx6PHyBljMfXt2qzjUs04NriPWEhMtgYQI6jp/M=
Received: from CH0PR03CA0302.namprd03.prod.outlook.com (2603:10b6:610:118::24)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 05:12:50 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::a0) by CH0PR03CA0302.outlook.office365.com
 (2603:10b6:610:118::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 05:12:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 05:12:48 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 00:12:47 -0500
Received: from xhdpvinayti50x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 27 Aug 2026 00:12:45 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>, Tom Rini <trini@konsulko.com>, Matthias Fuchs
 <matthias.fuchs@esd-electronics.com>
Subject: [PATCH] fpga: xilinx: Check bitstream length against the supplied
 buffer
Date: Thu, 27 Aug 2026 10:41:38 +0530
Message-ID: <20260827051212.2683473-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: aa462c39-efd4-415a-9499-08df03f9d666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|56012099006|10067099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: oVGe2WWRjurhSJyOXY5UoHI4YAU4nagB8/7XaSiB9twI2+RgVwvrgzsOXh9eGBUlG2CEiJ72lIPGejRcy+29PcS4EFz/5+TOMKt0YyiLJfFZX/apFrKCkAer/QMfVFCWUkmXvCtCn5DFBNrekh0bdVfmjWyyL0Y5W7G5RqgUSrTcDFe6UlcPiaWCA4IFmw2jiwLnoaNL5EhIdHLOgkQRE/5io7BHkzZgmtNy18rwAus39n0EnOkdR/6oUVs/WDQaK5xaMSLrubmN6WyFPraXY6E3FwmAJUw44ErmD45+sWKzR2l8QAOih86VlkF5aa3CeShquqk81rGjaHRGV/ePo4HJC8wznGsvDM63h3t5OtwVpcc5uLt/pLkLFH92MMJkiGCFo9HMqztmyWhd5/6+tCWbqoOcBJCG9hm3M7kiq3KAaswFOEWx8Oy/5zVbGFl0n63jglHy7uozLGwVsOvtNKiMplJF43heL4HEwmGXBCPKO8ObacztjT3IajrLMKd/ZPLg4wZ6rwuHqc+CXOQ8L+s7t9+ZO4wa6xljgiS3r8iLWI5+fLbk8RWSTg/UNe+gq1ZTt5vUiKhe/4UQN7t6ASbfkW+2vsntXNKhMUojbzJDpWwcvNA4OL1sGP9WMbIcFcDbqvXlwB1N7BaDhX4AgxJTOoUhxG1bJMcArJfOjgn6o3cyysT57n4I2m88ncXoscfyZXaG9UxEOxYAoGxP/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(56012099006)(10067099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZTmDvqIrh4nv4iHT0p2llk49GIlLS+rJVM9cYmW5+KYwH7dmVIOgFbe6VjrP+MJcP+/8DoaomrQ5aU6DEl9Z/sx05b0sm1jAQnTplElOVKtPWxPrLjITsP9xj2lQXJJelFl5pJF986pJPkRQhInFA6qWuUygUwy/Jv9vV7sGz7rZ0Y+UE67SGRmipuBlGZmYMgpV2V0JDn7qQMBurObbNAbqjDz8w3L0vq/98Vy5mvbHJOUPA48qgPu5BvkRe4tAjYdabdhIALp6KH7pV64i8YZj+PezdW171X0YiiZAPl72fn17xqLJk9V/Z/OuekwYp/AkyGxUHtMPlKN4l4DQs2PIm7gmDUHehrppd8EanGobuU2C3x4DDr0Ka1i7R96DCVpsy6qI/+tVwXJ73gSQ6vvug/tsgPjcT7L22NO8tMVr3CNTber4+HZL/OYRbH1E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 05:12:48.8130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa462c39-efd4-415a-9499-08df03f9d666
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377
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

fpga_loadbitstream() receives a size argument describing the length of
the caller's buffer but never uses it. All header offsets are read from
the bitstream, including the 32-bit data length at tag 0x65, which is
passed to fpga_load() unmodified and becomes the DMA transfer length.
A header declaring more data than the caller supplied makes the DMA
read beyond the end of the buffer.

Reject the bitstream if its header and the data it declares do not
fit within size.

Fixes: c26acc1a43b3 ("Remove bit swapping in Xilinx Spartan bitfile loading")
Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
 drivers/fpga/xilinx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/fpga/xilinx.c b/drivers/fpga/xilinx.c
index b6966c7d2cb..c0f8e61f9bf 100644
--- a/drivers/fpga/xilinx.c
+++ b/drivers/fpga/xilinx.c
@@ -44,6 +44,7 @@ int fpga_loadbitstream(int devnum, char *fpgadata, size_t size,
 	unsigned int length;
 	unsigned int swapsize;
 	unsigned char *dataptr;
+	unsigned long hdrlen;
 	unsigned int i;
 	const fpga_desc *desc;
 	xilinx_desc *xdesc;
@@ -143,6 +144,14 @@ int fpga_loadbitstream(int devnum, char *fpgadata, size_t size,
 	dataptr += 4;
 	printf("  bytes in bitstream = %d\n", swapsize);
 
+	/* Make sure the header and data fit in the caller's buffer */
+	hdrlen = (unsigned long)dataptr - (unsigned long)fpgadata;
+	if (hdrlen > size || swapsize > size - hdrlen) {
+		printf("%s: Bitstream does not fit in %lu byte buffer\n",
+		       __func__, (unsigned long)size);
+		return FPGA_FAIL;
+	}
+
 	return fpga_load(devnum, dataptr, swapsize, bstype, 0);
 }
 
-- 
2.43.0

