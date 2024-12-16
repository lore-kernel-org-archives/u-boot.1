Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C186E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 09:30:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33D5680104;
	Mon, 16 Dec 2024 10:30:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VxWAQzXE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAE028003E; Mon, 16 Dec 2024 10:30:26 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 518F98021D
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 10:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yv0KDiQFQmvLIuWNhfrRrDT8nPbeEIDQjsUu7ezZPAqdce+R6BDNhETPIVdU66/YJHJMSL9FciDwEmRbxEDaUQwqOwJE3eIKK4Ik+A649yOgI+wNpxetVoLncpQcgFWwAhFey2KM6DSCJaEVBkwB55tvHcZl2Gxq4Ch1VQPhOufySlY9++lYkjTVK1WpFIvT2ZWA5ndSChsVLsS6TfAYnhGs5FmUhio/owgm8L0PrkEchz7U4OvCcd5jG0VHMpOkThAYVucchldYz0zPqSSToLbrPmioO13Lel7KK4oyVanrZn5aYbiotRzl6J+iaCy6DWHNAFcTayT8sPNF38N6KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoWPNzXDQ+G01fw8ezTPwMJwWgn9CNvfOFTUhpfctwo=;
 b=H4qF7MNftnZELj5POKi1c1Nrx3uw4FNnVaubLZXf6325qCLEhCa0PdQqHWrD25efrvv2Wbdpphv2gyBoJ8NiOQZ1OV7m2cZBtNQoqhuUMqTc+92CJS4L+VMfjrcKE+cBa5XLo3gQt6flXX1DzhyN4ZtiNFqSxNlPUvwefpRxjGuQzeGSmYVn2XBC5VlAP3ILddRMqh0I1ioEeEXBAhpjZPBFDT0OoCXEHdFdpDZZWvlpxbGnTAahzoNUeXh8xhTiv96N3hkJbtHME61XvRPAdIBv9D8BYnQNMvkx2R2/oxnCJ4AfWukQFNq1QHfzc5c9xbI7jSEyMR7U+x6muSqhDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoWPNzXDQ+G01fw8ezTPwMJwWgn9CNvfOFTUhpfctwo=;
 b=VxWAQzXE86zoVVMsxt0PCNNDDmb60YLUbiopQrZzr/osgxmoOzSOSsndawhZDbbjhYton0I+lzEcpsbDkYddE00sveQx+z2r9uErAbXutmdR+b+aptZ0eX7m47VL1eRw8WRbTC4thqqJar5pn77n643wG0UA3ew2eKJ3P2Pc144=
Received: from BY5PR13CA0029.namprd13.prod.outlook.com (2603:10b6:a03:180::42)
 by SJ2PR12MB8927.namprd12.prod.outlook.com (2603:10b6:a03:547::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 09:30:18 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::7c) by BY5PR13CA0029.outlook.office365.com
 (2603:10b6:a03:180::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.9 via Frontend Transport; Mon,
 16 Dec 2024 09:30:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 09:30:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 03:30:15 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 16 Dec 2024 03:30:12 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <trini@konsulko.com>, <sjg@chromium.org>,
 <jens.wiklander@linaro.org>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>, <jerome.forissier@linaro.org>,
 <mkorpershoek@baylibre.com>, <akashi.tkhro@gmail.com>,
 <francis.laniel@amarulasolutions.com>, <ddrokosov@salutedevices.com>,
 <git@amd.com>
Subject: [PATCH v3 2/2] doc: man-page for optee commands
Date: Mon, 16 Dec 2024 14:59:58 +0530
Message-ID: <20241216092958.1230455-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216092958.1230455-1-venkatesh.abbarapu@amd.com>
References: <20241216092958.1230455-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|SJ2PR12MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: 256a5fc9-b2ad-4658-bc16-08dd1db440fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?68CAvQRFZthX0tegiqRXKpWf5wa3fM4wq07Y3hQTmalTLuwa0FgEAu3YNib0?=
 =?us-ascii?Q?ukOfwD3xc/X0lu6j7zXSIj1PPBCh7YrhJKVsjifp+e+pXbz/IOj1WjJzTPfl?=
 =?us-ascii?Q?wpKSc/feFF40Ufmd/uf4SToyQ47NEmmuODtrLP8Mm02NQKrHYRJg32cSjmBZ?=
 =?us-ascii?Q?6fKyzgIhEgcwqf4A8U9YEwkv5zQYrxkwOcq59elko9J+0XcJIVKoKzAUq0Z1?=
 =?us-ascii?Q?4CX3+CDZYkoBYwxDnsD9zp76LGZPcdvAq5LvbF+u7n4Smlb4DA7WPPL1siyr?=
 =?us-ascii?Q?YvAJ00UhTVdcsP/yTvGq641bIP+nxrNfLUjf75h0UMeLhetIheTyA6pED2+Z?=
 =?us-ascii?Q?4lDbyjstBbdkXLZumzwwI89sBShggBrn7INWRXuHP8YpbTOjxvFFTOsQG7zU?=
 =?us-ascii?Q?wrXA5eX0k3PHVXh4R1e+e7CPgdli7D72iF+ohBlmoYGpBavSbrPACZw/ELrG?=
 =?us-ascii?Q?Ssyv6PuwOB4Mv57h7MVCQqzBcv2fX+AuKRCbTvSAnSneFTJP+rsT3+bde+1n?=
 =?us-ascii?Q?K6vXbyGwGWl9lPJIj1/seP7TKd8Ke0uQCEzhXdTvxeMO2RUeEmFtURQKnSva?=
 =?us-ascii?Q?0ZFTDWn2rwEFN1TX97aGcRHjep2XM1rNI3+pSV7E2bxnVCyO7LCHWGjjiZwb?=
 =?us-ascii?Q?ZGJT3bnp4ZDsII0yvapQ+HrY2faoKIS3SjBcRtc+XDyK3SbOmBOOvtZKHSO5?=
 =?us-ascii?Q?NsQm75/gBEfSOzns/ivVXcbHM2a3qNrUYIEn7qN04HdmTfYNzFGX87xP9C38?=
 =?us-ascii?Q?QKYeoJvThmv82BEB5YhZKcElcVYRdkdmDh5oQ58sWHKg61IrfZAcAC1g23gZ?=
 =?us-ascii?Q?RIOc6yg7pKnZp2D5Y2tHXDdb/rjHJqio0G2Nl1p25wBJfxC0awjF/8diVr4u?=
 =?us-ascii?Q?NjmNE1Thvy9NZRrSc0c4puR1VSnG/OCWjIEwee4kr/aOCHX+VCI8ow3eYv0x?=
 =?us-ascii?Q?Zb9luPsxkdZKtSuikNYYrbdcit1SJM5OjfPOxUKVLYn0kErsmVxKDIyVXn2G?=
 =?us-ascii?Q?XzP/lVdGgAhrIiculzvv0oU0Gpl+rx/hENy6AsiMG89e8RIxpeVBKeMX6Hg9?=
 =?us-ascii?Q?Ck6VXqCiZfKw+OJN9byVE9+qhSFQZwCcwG8a+4GBwb7mif+m1/lQpLqEjRJ8?=
 =?us-ascii?Q?esBr2FlMMO0S21ERUyg5Joq0s+bwPRZ9dz0V9kdKWq0SZJR7C1R6dWjzJymh?=
 =?us-ascii?Q?840TbNCEOImuJvEA+Zv2O/64uDQ+ING8pOP7GO203dC3ahzgzefJVT6DElC1?=
 =?us-ascii?Q?7jbpx3Pdtw8yKmkd5/GvPU3t7m014IY8al7O1w5quHwY7TdzOYBbG5QgDfTP?=
 =?us-ascii?Q?6RCFTkX2BdXKD+S7smzy4to+lwsGFbWFRme5prbX/+3OgwQZFTRtr/iGnUQV?=
 =?us-ascii?Q?JBca6dWfHjb4pUrAFxzkqntMtdEcKA5lKmkBRQCbH/YwakYgtsCCIadKLFT5?=
 =?us-ascii?Q?q7c7WeLaSkI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 09:30:17.7099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 256a5fc9-b2ad-4658-bc16-08dd1db440fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8927
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

Provide a man-page for the optee command.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 doc/usage/cmd/optee.rst | 66 +++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst     |  1 +
 2 files changed, 67 insertions(+)
 create mode 100644 doc/usage/cmd/optee.rst

diff --git a/doc/usage/cmd/optee.rst b/doc/usage/cmd/optee.rst
new file mode 100644
index 00000000000..53e36853742
--- /dev/null
+++ b/doc/usage/cmd/optee.rst
@@ -0,0 +1,66 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+.. index::
+   single: optee (command)
+
+optee command
+=============
+
+Synopsis
+--------
+
+::
+
+    optee hello
+    optee hello <value>
+
+Description
+-----------
+
+This is a very simple optee hello command which is going to
+increment an integer value.
+
+value
+	value to be passed which is going to increment
+
+To enable the OP-TEE OS side HELLO WORLD example please refer
+https://optee.readthedocs.io/en/latest/building/gits/optee_examples/optee_examples.html
+
+Examples
+--------
+
+::
+
+	==> optee hello
+	The Hello World TA is going to be called
+	D/TA:  TA_CreateEntryPoint:39 has been called
+	I/TA: Hello World!
+	TA value: 0x0
+	D/TA:  inc_value:105 has been called
+	I/TA: Got value: 0 from NW
+	I/TA: Increase value to: 1
+	TA value: 0x1
+	I/TA: Goodbye!
+	D/TA:  TA_DestroyEntryPoint:50 has been called
+
+	===> optee hello 74
+	The Hello World TA is going to be called
+	D/TA:  TA_CreateEntryPoint:39 has been called
+	I/TA: Hello World!
+	TA value: 0x74
+	D/TA:  inc_value:105 has been called
+	I/TA: Got value: 116 from NW
+	I/TA: Increase value to: 117
+	TA value: 0x75
+	I/TA: Goodbye!
+	D/TA:  TA_DestroyEntryPoint:50 has been called
+
+Configuration
+-------------
+
+The optee command is enabled by CONFIG_OPTEE=y and CONFIG_CMD_OPTEE=y.
+
+Return value
+------------
+
+The return value $? is 0 (true) if the command succeeds, 1 (false) otherwise.
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index cb7a23f1170..4dd00f002cd 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -92,6 +92,7 @@ Shell commands
    cmd/msr
    cmd/mtest
    cmd/mtrr
+   cmd/optee
    cmd/panic
    cmd/part
    cmd/pause
-- 
2.34.1

