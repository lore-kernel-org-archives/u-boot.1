Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2401C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 06:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73F7387976;
	Fri, 12 Jan 2024 07:11:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b0GLLLRw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB7DF8794F; Fri, 12 Jan 2024 07:11:57 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFC968796F
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 07:11:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqxYMTXGx5BZi4lDAwXRofQsLwmeJXNYcRyhjIsDcsH27cbT8F5MXqsoz6gfKOzhoYsrwKW3yrLp44KUGg7+dFyCyecpHUo8Sb5ruEwpGP8JU1oDlunDbQgm/pxOVk+75E3lAilAUNXuAKwM2BKjqMvbI+3rCWhpm8jPI59z45jwDWoDK6po6wF1TU3hKRo9G5nQgMo6Ib+hI2LEC3SvT3+6YYvrn2axolVGRjLXpHlErJ3TpRxTGoinQKhEtAYIYu5yuK7yrzgNvOzUX/VB8psLVghgXob1Ti2w6aNvbJNNEaDKb686gxFR8MmfykmHEZMpYHp5RH3Kzm+Mq7Jtwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+Zed8jGzrkJAJ2JMlrBqwnl4lbY5pSWyDDi/qIOePo=;
 b=OmVyC84SylIVrImKTWI6DWlknDLbdTbw8I4hvpcTPSmiKIPJIFzuVf6JXuZvVp0WJVahEVJrHDBaQtBnWQfjjdQuV1JA6pJkJ/VsiYnUOEe07APBtrbKbH9X6PW5ihy7kzDEXoYIW+HViJvl53Nf6isAnvUz5gJXraslMn9WVTAoiAx6GvrKktrh2gK1I4MNtSGeTPOpo4Qngv2mYWpxKdshEO33XxNrdPRqqoh+/CDfW3LoBr6VjsIJt3jd8G7IIJGZLCDt0wgwYi9gcc4D+t4aj+SNHSvuo2YhwhlHgvuo1BbkjPQq2rH0WMIZci70pm4joTnjGUwEI2oAYGfneA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+Zed8jGzrkJAJ2JMlrBqwnl4lbY5pSWyDDi/qIOePo=;
 b=b0GLLLRwyCwVAZ4EOYoKHjnBmgZjTTomicgp5CLdges9qxbtMBthfdKVAFN2oMwCLBVrXCU2D+Z27t8/KVES06WwRhL4Gd+5yAprOauzqjEBs/kA60vbCVE5ZDnb7wbcPnqUa6WFHrcvhVFl+gw+9QY0SMw55cp+x4J0H3ft5n8=
Received: from SJ0PR13CA0161.namprd13.prod.outlook.com (2603:10b6:a03:2c7::16)
 by IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Fri, 12 Jan
 2024 06:11:53 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::f6) by SJ0PR13CA0161.outlook.office365.com
 (2603:10b6:a03:2c7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.12 via Frontend
 Transport; Fri, 12 Jan 2024 06:11:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 06:11:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 12 Jan
 2024 00:11:12 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 12 Jan
 2024 00:10:27 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Fri, 12 Jan 2024 00:10:26 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH 1/2] xilinx: board: Update the kaslr-seed property
Date: Fri, 12 Jan 2024 11:40:17 +0530
Message-ID: <20240112061018.3280962-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240112061018.3280962-1-venkatesh.abbarapu@amd.com>
References: <20240112061018.3280962-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: fae1b139-eca7-4251-a39b-08dc13355e8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FeM5Tel6qEU1BUK/zpaNjnWn1B2O7yVbispzxa17qWOJoc/iGiw7q/zACaKwzTune4F1NtSJAGkfSCmQ1A1xCIg6OwZYK4XVKWiS+7MnEUt6dOuW1/bzMaBN2+qlI5B4xJZaI5y6ozRlWrX/ORMh3Pvj/C39o4khkZTLgHHmV1Qyve9w1ZTt9K44n00MbA3K4rT85bJvwreEtOZvAgx77Ln/BieiqLaGfs9begJzaMpNDWCAg7pWhKU2zkoDfXWCy6zshtP5TNlgBDXpfRB3v+czjWGpWTmvVtzOacm2G8ZxtH6B3abxKyEPZWE+CvffamEYpSzcjdEGZDVjxg+GJsE+CySMhJ5Acf3hBrFrqVzG6dPIzS3SBHhJa4PDz8CICP3ZEG5eV+z3wlmyhYW3VJ1LXf7GydhK4rFJtU3gfHwkouJ3uRz9sfSPvKuG9YIP8FrXBvhFRlra/6AZOlQM8bfFotUHldM/1k10fqXO374I6YKoNji4wk90M08CB9c27zVzrESD/46NmwdxeVW9w2gu/dViiSZsSBu4Ky7+tLcOf6ZcD9u+mtYT0CmeZouGcMuCrdqhG4GuFOS6x+WMSCv6cqQwj3tSrKL1fkhfXt+Xq2zA1MYloJIeUi0pKCRlvL2zJQg8vxtYDJw+sdWKxf6X2PMVhfZsZj1r/Qv+Sb5zCre+R8mBIjhbXjWiRXLzCuqYBh0xuMwNhIbc9iEWEDpJAUgpAu1Cfzrv09CHRfg7A9HdR9bDhJQm4aCIi0r1In/lx0n6RqortbWQFvEdFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(82740400003)(336012)(478600001)(107886003)(26005)(426003)(2616005)(1076003)(81166007)(356005)(86362001)(2906002)(36756003)(6666004)(41300700001)(70586007)(36860700001)(5660300002)(47076005)(70206006)(8936002)(8676002)(54906003)(6916009)(316002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 06:11:51.9118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fae1b139-eca7-4251-a39b-08dc13355e8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Create a ft_board_setup() api that gets called as part
of bootm/booti before jumping to kernel. In this
ft_board_setup() callback that will inspect the DTB
and insert the device tree blob with the "kaslr-seed" property.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 board/xilinx/common/board.c | 59 +++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 12a877c715..985a3825e6 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -682,3 +682,62 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 	return reg + size;
 }
 #endif
+
+#ifdef CONFIG_OF_BOARD_SETUP
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	size_t n = 0x8;
+	struct udevice *dev;
+	u64 *buf;
+	int nodeoffset;
+	int ret;
+
+	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
+		debug("No RNG device\n");
+		return 0;
+	}
+
+	buf = malloc(n);
+	if (!buf) {
+		debug("Out of memory\n");
+		return 0;
+	}
+
+	if (dm_rng_read(dev, buf, n)) {
+		debug("Reading RNG failed\n");
+		ret = 0;
+		goto end;
+	}
+
+	if (!blob) {
+		debug("No FDT memory address configured. Please configure\n"
+		      "the FDT address via \"fdt addr <address>\" command.\n"
+		      "Aborting!\n");
+		ret = 0;
+		goto end;
+	}
+
+	ret = fdt_check_header(blob);
+	if (ret < 0) {
+		printf("fdt_chosen: %s\n", fdt_strerror(ret));
+		goto end;
+	}
+
+	nodeoffset = fdt_find_or_add_subnode(blob, 0, "chosen");
+	if (nodeoffset < 0) {
+		printf("Reading chosen node failed\n");
+		ret = -EINVAL;
+		goto end;
+	}
+
+	ret = fdt_setprop(blob, nodeoffset, "kaslr-seed", buf, sizeof(buf));
+	if (ret < 0) {
+		printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
+		goto end;
+	}
+end:
+	free(buf);
+
+	return ret;
+}
+#endif
-- 
2.25.1

