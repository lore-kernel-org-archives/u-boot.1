Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F18DC79FB3
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 18:36:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D12A783A26;
	Mon,  5 Jan 2026 19:36:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="q1xxPkuo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C6D683D17; Mon,  5 Jan 2026 19:36:48 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9376839DE
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 19:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8YJGeXwyCV7pnEJbBiJIWIli+bIJ39VUevhuP5i2A6vqdR6TR7vRL4m/Xgf4b4lzIDRRMMCIyms4+5Oy+1mic3g41I9JRbaSG6dUo0hI6UXUf1UxKOsf/rLTJwycKY+2fWccb/GvvF+A/avixenHM4ocSvZtQlJVCvJ21zn4U+XUDP7t/wJjV4lhuzz0YlZBPnl012QZatYj79CyziaSysc/SSE7VBkrb6ehtSMnt7H/NaiG0h6jPmRK//lAGg9PhNthdtTBe/Ms5orepgbovGkEpmOUpf6F1ahqFHf1S9I7KW1xsjKEXoD7Gg3+1xsT9h+P72mtsvimJBXt62pkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmEkT0ZmS8O4c+xEmHW2IwfRBmUyYz9uzVDk8PjCscg=;
 b=fAWeaXm33RnQ38sbbSNuLuZi319s1hha8UGh7NvXUcEdJC9CXxOoytaA0fUqGD5jjxkY+viG+BZhk9DCtyvNO5/p91+6OYT9ykP8dJbrRrE7o012GpZ3I/VU7i38IrlZZIUU9toq3BDLhH3p8Jg5AfDznzgWFvpyJUX6r1FdpUw/tToDP2w510pdzahCb5Dv48BmD3AuO2/R8X5Q26YgGpsytb11NsLWYUjpaLT0Fa52JyOTHGGpos8P4Jp3TQ3JpvnGVD4KRbldKYb63zE/XRQK6OEKPlS4ersoC7/+a7vyjyWE+e4Ln3WsRlsSHkAiDq5NQY7vLAyx+wLhuneXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmEkT0ZmS8O4c+xEmHW2IwfRBmUyYz9uzVDk8PjCscg=;
 b=q1xxPkuoLKxiOGY9y8FrKKCiLm1+hwr+xNmAmQsHJbpyiQpFk743nxGmwMyLUofAMvSxeBZuFxJu2EUntgsrj9DtoW3Cf1IwLTxHYBuTyFsjMRpbNZfWCqtr8lZU2HF9ftBe0VUR5x9HCukI33vF9lBP0bxvTTdQLRAzCpg/8wc=
Received: from CH2PR03CA0014.namprd03.prod.outlook.com (2603:10b6:610:59::24)
 by SA2PR10MB4764.namprd10.prod.outlook.com (2603:10b6:806:115::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 18:36:41 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::1b) by CH2PR03CA0014.outlook.office365.com
 (2603:10b6:610:59::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Mon, 5
 Jan 2026 18:36:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Mon, 5 Jan 2026 18:36:41 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 12:36:40 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 12:36:40 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 5 Jan 2026 12:36:40 -0600
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 605IadsI1612316;
 Mon, 5 Jan 2026 12:36:40 -0600
From: Paresh Bhagat <p-bhagat@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <nm@ti.com>, <bb@ti.com>,
 <khasim@ti.com>, <afd@ti.com>
Subject: [PATCH] doc: board: ti: Add AM62D documentation
Date: Tue, 6 Jan 2026 00:05:45 +0530
Message-ID: <20260105183545.4108567-1-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|SA2PR10MB4764:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d5fc617-6eb5-42fd-14c0-08de4c895e82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QK9ifqv/tux5DYNPFajho7tL71AhSToZhcP+eeu66MAfu3Do9RtB1VKtCYRH?=
 =?us-ascii?Q?tXLX2NfSr2mTwxY4hbfOmTaDfO0hSpWOcNB+KIrdmoj6cPlyCoTFxZxan6rQ?=
 =?us-ascii?Q?c3VMs4Ly53h5nL43lpr7dkbCaqL0Ct5J0y7KPsRIkBWodk2zlrY0FoJo2Ofb?=
 =?us-ascii?Q?9HiqNuHRWYxkxq7NsR1DD4LKaVSMzDSNYc4E3ASJR1d+7WvlclCIL9b/ZRRW?=
 =?us-ascii?Q?mg22H37OpGxu5auWBAborRun2lGmqfNeRs35siaveoHVPC6TjWs+BHVKNUnv?=
 =?us-ascii?Q?cdUeYXFLYJlnA/L8aq/TZDdMdcfEeY20W81JD3qTSBvmyyAN2XXe5qnDyb/o?=
 =?us-ascii?Q?+nd4z85r6l2/NkYtuO4XQJ6Bl0UTC8wybwFQdTRvYozsH5g4p8imjFA3m+y0?=
 =?us-ascii?Q?D/uIZ1Of88klSwSE0VUj8xLa93TNNbu0/ku3GhPjQDGTTwp8RP8jGJIG001Y?=
 =?us-ascii?Q?634JR/YpTztjp/69Oaqg7SKtlhfVzNvbl4M82NzU670jscsLLQl2Kp6DxYSI?=
 =?us-ascii?Q?q0O+RyxlARv3uFOT71GU7IClwdbp7KUBbstNeFa8NSGQ3LsI+kIgzlfXjz7t?=
 =?us-ascii?Q?vWBqIithoBxUijDS1YwQ9u7YJph6QilA+bw4LbZcTaCebz17zKpRNgTD6OKe?=
 =?us-ascii?Q?wrg9A/e1vwlqkZrEObDsaYWOD8ZZ9GPuey2NCkq8En3Az+FYhw6PWBDLMBtm?=
 =?us-ascii?Q?YTL2RK4vjcaTF1NGHghW7pZL3ZFU/+dnRVxCuqKZUvA6Z1jAaeh3P/q78PDE?=
 =?us-ascii?Q?qfAuEqbe0ENgoLSTnjRY6DJWLd7CSlZhK4QZHYkxJrpIIFG/6OV3kZ8Zgjfb?=
 =?us-ascii?Q?s17svUW9bVEtpkRjF+ANJxPOnCxXZB/WkET/n6i9+Ok7lrOnVGfzAzL9Gvq5?=
 =?us-ascii?Q?kBbw7ypoggDyqq2pEt3hJR7vqPQRYeUcR0nvIx7Rp90R0R+y4rObzr44EWPM?=
 =?us-ascii?Q?kvD4tPZqLrgGNiN1rPvIB/ruVEHFfRK7n+tU3kgnOdpvxmO+euKKBI88p+n2?=
 =?us-ascii?Q?DA2sKXGgkoXGLpYAYdgz64CZYmIQfL8QmQ8BO3c8UxpgjISuEsA7sh0Bk2JQ?=
 =?us-ascii?Q?HsXt4fwaY7e2FmkXcMG+ZtUJI4cPKCxDp6fWx3ZDPHW4vIeo4GK92wBV6lM8?=
 =?us-ascii?Q?i7N+thPNbuMmLe8/WXA40pnhFwLbiK25fH6ICyRpdB1gyky8xg6FWAJpjy8b?=
 =?us-ascii?Q?c8dQfZxS0xkF7jXJQNl2dq1t3+sdVSAGswOWzug57dqKjABMCNumWq1/aU6p?=
 =?us-ascii?Q?9yqvxyoXI7MwSexejjihCksmLGcSPzSJG0YQofjpenFM7reASWS0zCor4LyJ?=
 =?us-ascii?Q?1UL5l7VlicDNgwW7C9UyFKjBJBTvsCQuwaqpdjij/wLbLzwZdZIt9tYF3muy?=
 =?us-ascii?Q?IdWxAF3tsIoAe/OPn6KgX4+RsU/Mkb3oxM0DBytS1Wbab9s0kvJskSGtFYFH?=
 =?us-ascii?Q?ZLMrIpK9D7vyZ87SnUIkpZTr0jcV1b681L/pupyLX+5lELHLIg3Tzxm++vJI?=
 =?us-ascii?Q?TxPxeltpm8Tfu21mzBbFbPzgKODaGC/WnOqhL5iQ9rVV3mlNVs8Po4izB37/?=
 =?us-ascii?Q?pkv6p7tFTM0wBVqg7P/iPBl83fdzR3p7LUiBEHfs?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 18:36:41.2037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5fc617-6eb5-42fd-14c0-08de4c895e82
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4764
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

Add info of boot flow and build steps for AM62Dx EVM.

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
 doc/board/ti/am62dx_evm.rst | 254 ++++++++++++++++++++++++++++++++++++
 doc/board/ti/k3.rst         |   1 +
 2 files changed, 255 insertions(+)
 create mode 100644 doc/board/ti/am62dx_evm.rst

diff --git a/doc/board/ti/am62dx_evm.rst b/doc/board/ti/am62dx_evm.rst
new file mode 100644
index 00000000000..60442480726
--- /dev/null
+++ b/doc/board/ti/am62dx_evm.rst
@@ -0,0 +1,254 @@
+.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. sectionauthor:: Paresh Bhagat <p-bhagat@ti.com>
+
+AM62D Platforms
+===============
+
+Introduction:
+-------------
+The AM62D2 SoC belongs to the K3 Multicore SoC architecture with DSP core
+targeted for applications needing high-performance Digital Signal
+Processing. It is used in applications like automotive audio systems,
+professional sound equipment, radar and radio for aerospace, sonar in
+marine devices, and ultrasound in medical imaging. It also supports
+precise signal analysis in test and measurement tools.
+
+Some highlights of AM62D2 SoC are:
+
+* Quad-Cortex-A53s (running up to 1.4GHz) in a single cluster. Dual/Single
+  core variants are provided in the same package to allow HW compatible
+  designs.
+* One Device manager Cortex-R5F for system power and resource management,
+  and one Cortex-R5F for Functional Safety or general-purpose usage.
+* DSP with Matrix Multiplication Accelerator(MMA) (up to 2 TOPS) based on
+  single core C7x.
+* 3x Multichannel Audio Serial Ports (McASP) Up to 4/6/16 Serial Data Pins
+  which can Transmit and Receive Clocks up to 50MHz, with multi-channel I2S
+  and TDM Audio inputs and outputs.
+* Integrated Giga-bit Ethernet switch supporting up to a total of two
+  external ports with TSN capable to enable audio networking features such
+  as, Ethernet Audio Video Bridging (eAVB) and Dante.
+* 9xUARTs, 5xSPI, 6xI2C, 2xUSB2, 3xCAN-FD, 3x eMMC and SD, OSPI memory
+  controller, 1x CSI-RX-4L for Camera, eCAP/eQEP, ePWM, among other
+  peripherals.
+* Dedicated Centralized Hardware Security Module with support for secure
+  boot, debug security and crypto acceleration and trusted execution
+  environment.
+* One 32 bit DDR Subsystem that supports LPDDR4, DDR4 memory types.
+* Low power mode support: Partial IO support for CAN/GPIO/UART wakeup.
+
+This SoC is of part K3 AM62x family, which includes the AM62A and AM62P
+variants. While the AM62A and AM62D are largely similar, the AM62D is
+specifically targeted for general-purpose DSP applications, whereas the
+AM62A focuses on edge AI workloads. A key distinction is that the AM62D
+does not include multimedia components such as the video encoder/decoder,
+MJPEG encoder, Vision Processing Accelerator (VPAC) for image signal
+processing, or the display subsystem. Additionally, the AM62D has a
+different pin configuration compared to the AM62A, which impacts
+embedded software development.
+
+More details can be found in the Technical Reference Manual:
+https://www.ti.com/lit/pdf/sprujd4
+
+Platform information:
+
+* https://www.ti.com/tool/AUDIO-AM62D-EVM
+
+Boot Flow:
+----------
+Below is the pictorial representation of boot flow:
+
+.. image:: img/boot_diagram_am62.svg
+  :alt: Boot flow diagram
+
+- Here TIFS acts as master and provides all the critical services. R5/A53
+  requests TIFS to get these services done as shown in the above diagram.
+
+Sources:
+--------
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_sources
+    :end-before: .. k3_rst_include_end_boot_sources
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_firmwares
+    :end-before: .. k3_rst_include_end_tifsstub
+
+Build procedure:
+----------------
+0. Setup the environment variables:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_common_env_vars_desc
+    :end-before: .. k3_rst_include_end_common_env_vars_desc
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_board_env_vars_desc
+    :end-before: .. k3_rst_include_end_board_env_vars_desc
+
+Set the variables corresponding to this platform:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_common_env_vars_defn
+    :end-before: .. k3_rst_include_end_common_env_vars_defn
+.. prompt:: bash
+
+   export UBOOT_CFG_CORTEXR=am62dx_evm_r5_defconfig
+   export UBOOT_CFG_CORTEXA=am62dx_evm_a53_defconfig
+   export TFA_BOARD=lite
+   # we dont use any extra TFA parameters
+   unset TFA_EXTRA_ARGS
+   export OPTEE_PLATFORM=k3-am62ax
+   # we dont use any extra OPTEE parameters
+   unset OPTEE_EXTRA_ARGS
+
+1. Trusted Firmware-A:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_tfa
+    :end-before: .. k3_rst_include_end_build_steps_tfa
+
+2. OP-TEE:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_optee
+    :end-before: .. k3_rst_include_end_build_steps_optee
+
+3. U-Boot:
+
+* 3.1 R5:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_spl_r5
+    :end-before: .. k3_rst_include_end_build_steps_spl_r5
+
+* 3.2 A53:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_uboot
+    :end-before: .. k3_rst_include_end_build_steps_uboot
+
+Target Images
+--------------
+In order to boot we need tiboot3.bin, tispl.bin and u-boot.img.  Each SoC
+variant (HS-FS, HS-SE) requires a different source for these files.
+
+ - HS-FS
+
+        * tiboot3-am62ax-hs-fs-evm.bin from step 3.1
+        * tispl.bin, u-boot.img from step 3.2
+
+ - HS-SE
+
+        * tiboot3-am62ax-hs-evm.bin from step 3.1
+        * tispl.bin, u-boot.img from step 3.2
+
+Image formats:
+--------------
+
+- tiboot3.bin
+
+.. image:: img/multi_cert_tiboot3.bin.svg
+  :alt: tiboot3.bin image format
+
+- tispl.bin
+
+.. image:: img/tifsstub_dm_tispl.bin.svg
+  :alt: tispl.bin image format
+
+Switch Setting for Boot Mode
+----------------------------
+
+Boot Mode pins provide means to select the boot mode and options before the
+device is powered up. After every POR, they are the main source to populate
+the Boot Parameter Tables.
+
+The following table shows some common boot modes used on AM62 platform. More
+details can be found in the Technical Reference Manual:
+https://www.ti.com/lit/pdf/spruj16 under the `Boot Mode Pins` section.
+
+.. list-table:: Boot Modes
+   :widths: 16 16 16
+   :header-rows: 1
+
+   * - Switch Label
+     - SW2: 12345678
+     - SW3: 12345678
+
+   * - SD
+     - 01000000
+     - 11000010
+
+   * - OSPI
+     - 00000000
+     - 11001110
+
+   * - EMMC
+     - 00000000
+     - 11010010
+
+   * - UART
+     - 00000000
+     - 11011100
+
+   * - USB DFU
+     - 00000000
+     - 11001010
+
+For SW2 and SW1, the switch state in the "ON" position = 1.
+
+Falcon Mode
+-----------
+
+Falcon Mode on AM62dx platforms bypasses the A53 SPL and U-Boot with the overall
+boot flow as below:
+
+.. include:: am62x_sk.rst
+    :start-after: .. am62x_evm_falcon_start_boot_flow
+    :end-before: .. am62x_evm_falcon_end_boot_flow
+
+Build Process
+^^^^^^^^^^^^^
+
+.. include:: am62x_sk.rst
+    :start-after: .. am62x_evm_falcon_start_build_process
+    :end-before: .. am62x_evm_falcon_end_build_process
+
+Usage
+^^^^^
+
+.. include:: am62x_sk.rst
+    :start-after: .. am62x_evm_falcon_start_usage
+    :end-before: .. am62x_evm_falcon_end_usage
+
+R5 SPL Memory Map
+^^^^^^^^^^^^^^^^^
+
+.. include:: am62x_sk.rst
+    :start-after: .. am62x_evm_falcon_start_r5_memory_map
+    :end-before: .. am62x_evm_falcon_end_r5_memory_map
+
+Debugging U-Boot
+----------------
+
+See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
+detailed setup information.
+
+.. warning::
+
+  **OpenOCD support since**: August 2023 (git master)
+
+  Until the next stable release of OpenOCD is available in your development
+  environment's distribution, it might be necessary to build OpenOCD `from the
+  source <https://github.com/openocd-org/openocd>`_.
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_openocd_connect_XDS110
+    :end-before: .. k3_rst_include_end_openocd_connect_XDS110
+
+To start OpenOCD and connect to the board
+
+.. prompt:: bash
+
+  openocd -f board/ti_am62a7evm.cfg
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 913cdd7d09e..ed04a57c167 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -31,6 +31,7 @@ K3 Based SoCs
    :maxdepth: 1
 
    am62ax_sk
+   am62dx_evm
    am62x_sk
    am62px_sk
    am6254atl_sk
-- 
2.34.1

