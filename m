Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85078C98303
	for <u-boot@archiver.kernel.org>; Sat, 17 Jan 2026 03:34:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF7C383015;
	Sat, 17 Jan 2026 04:33:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KfWszEyo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E64B88367F; Sat, 17 Jan 2026 04:33:56 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E6F98003E
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 04:33:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfffQc75f1H6835wUodek9UHXfT0N+eGzKNElmROA2g20f9bt/yAkl0FVskEH8XzMrmSTWb4qU+G76Z5Nc57XPB/EfpYpOVqT83CGZhf1ujOVtcVeC8zlVHInCL/94Z0VmjOe2Ewn+Q2TnNlqMQwnWTpTZyTyu+K29EfwSz5CAZ6+yXvdZ9Lp5TEvz1g0VO9fZozJjekxumutD1QvesInOVP2uL4O9ie2equlhIq1B90E8QXDj+ySQN2rzlSVd13gvCKdM5lNhKAxfNtsRERllR/wkYhtBTfSrojMbcpOtYO6N2KfSVeu7/TYnLmsQd6MlEN4AwUPAMF2kfwn72POQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsQFP9fftgdqlvuUnkHajbHxtmVH8qy9mPcGuHyEVig=;
 b=XnU/4ycYWpUKPGPPX5Mi0TC5I2+4fsV2dahxIvhuQU6konr5WLsA9XHw4Si6A86H5aaVj+tcrmPTm0NM26DGMafYhV63mWApKKzmB8Om06N3qboMV1RUV1TgQ8XUx2vGZ7OMEeRFNaSsSzaSUI7Mv8z3PF7+sI9y1zg2+rN24eAmc0EJCKxRqD7E4T4vts/0nYMcCBvx99D0P3MP7GVQ34xhERYguOf5xgh6Oox4TjIs2CxFXknJ9y1Z7y6xKBQRwKzNHRSTnK2wi5FHMXsBqHsulZnqyfQGKCQX7kGZuuaTn+8omI1FEP8p18dENHuLQ3rcW4clRRrXgWZl0aEjtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsQFP9fftgdqlvuUnkHajbHxtmVH8qy9mPcGuHyEVig=;
 b=KfWszEyoGXdFD8aJuQC4AjS0NEc1wnAHZ6wvNCyvLDPFfthF1N9dE4VOZFT9SWNgzfKfGARCTKr++UfFTscNXxB9XMS/U/KS7HoZ7PKTFqzaBELmo1JOM413zeoOid2KhOIG/uU9gF19ARKP80aYfQpPAPh5hs5HGqXlrnyHMUo=
Received: from SJ0PR13CA0196.namprd13.prod.outlook.com (2603:10b6:a03:2c3::21)
 by IA1PR10MB6877.namprd10.prod.outlook.com (2603:10b6:208:423::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.8; Sat, 17 Jan
 2026 03:33:50 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::ba) by SJ0PR13CA0196.outlook.office365.com
 (2603:10b6:a03:2c3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.3 via Frontend Transport; Sat,
 17 Jan 2026 03:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sat, 17 Jan 2026 03:33:48 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 21:33:47 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 21:33:47 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 16 Jan 2026 21:33:47 -0600
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60H3Xko04162470;
 Fri, 16 Jan 2026 21:33:46 -0600
From: Paresh Bhagat <p-bhagat@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <khasim@ti.com>,
 <afd@ti.com>, <nm@ti.com>, <v-singh1@ti.com>, <anshuld@ti.com>
Subject: [PATCH v2] doc: board: ti: Add AM62D documentation
Date: Sat, 17 Jan 2026 09:03:28 +0530
Message-ID: <20260117033328.837487-1-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|IA1PR10MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe22a9e-a51f-4a1d-6c52-08de557939d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|34020700016|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fn6SyyqeawWyqGgpBomtAVX3euVD99Vbpe4JC3Wj04bqfyWd1w49qH5JPuhJ?=
 =?us-ascii?Q?q5aQDWQukeI8XHwcfzYCu3kGqd5iVfh1221GbrxxJ3GS3bv3Qv+/m0+Hy7Oc?=
 =?us-ascii?Q?oeXJbghNi1bIwPR1p7Ku3ZzWHVx/jNU2rz7bBft6CLfxFj18VyhV7jxHFlVo?=
 =?us-ascii?Q?5wm+Luult2LVwa3lHinVeiSzsUlYO856MP7M3czCw24s7jNbebaeKWKs1Kcd?=
 =?us-ascii?Q?5A0oz0ulQQdqKOkdLFXRCToEFli5VVHWYQ5k3n8sUmHgAd+HAxSSYytQaakD?=
 =?us-ascii?Q?t6oxPOBS7f6ggPKWZwi8OELz55NNRYu8OmVV9IMgObpKjqSc2UOMDrWyd/HT?=
 =?us-ascii?Q?9El7nSClHr8Ghd5n1w5w514glBWar915WvL+EyOK2vNto1vd8YkwNjFVwoxV?=
 =?us-ascii?Q?Agx7iL8MqExIWs/mm7lX3OPdJX1YXnXFjhKjHHflHP812vW+ou7TnXcWLEv/?=
 =?us-ascii?Q?WpgKgCAdIf9+U6FumEgUAye73+XB2ZBHTVPBMcv7mMhJ9OTq08st/j7DiNXO?=
 =?us-ascii?Q?4ZqnfohUIbyw4r93oGjjdg5o0BVWEKpyFSeyOP16qH/HcY9x8jhKh79/XcYc?=
 =?us-ascii?Q?Sm7YYPd4553J/h3aX7cHEzHZ5vanVrmcRxDh69TnYIDpSAGTGDh8e8g/fLAR?=
 =?us-ascii?Q?K8gc2hREv6prPjf+sZVaSQ8yBQETnekpZzFn9xmIT5pDfB9VkcgRuFKoM2ip?=
 =?us-ascii?Q?5KmcCmupnVxIUw9Mqmnv55rPmQwfr6tG7pEiRQJybm3jTITWnrqv4kOW67xr?=
 =?us-ascii?Q?S2rdx4jDLE0iJcwzuZ+Zb8n26qsMZ1KmWvDadYRuwLApS10U3VLWV6iu23t8?=
 =?us-ascii?Q?KuziBKUiX43q5eKgpDt5Idem88qM2FLqxs5CXeryYICLB/fVj9V7N9LDR5/5?=
 =?us-ascii?Q?Qh5mr/7/26snONSpYAZ9hxSB1Fl1Twxty2GxQ8ve+W5/AO8P1+S3/x+mQj6c?=
 =?us-ascii?Q?AhQcv3Cvazfk+DtQH+L+Uqv9jhvhw4zHr7htekdmi1+gSTGsiYhLy0J56z84?=
 =?us-ascii?Q?8PbVr3VWb0g5IneAQM/fs/zuRG6997gxirmQKOD7VqNc9N7hTTvat/79C1mu?=
 =?us-ascii?Q?YpgWk6UadxzZwXuFYk8v0fOlnLL54Zwkg2csk9gZqEBtqePyY9SKBekCyHqQ?=
 =?us-ascii?Q?7+7MQFErLYyEWhytZ/TB3CyzP/PauBBgpcQ5kxrODBGFmjEC/cfJdBzIHqIS?=
 =?us-ascii?Q?GLVpKmw5x/SiND4qIfQD/L528CBOYhIoieI2jcO9lQInMZK3jsxyPD2liYPr?=
 =?us-ascii?Q?IYDGLgZ9M0zLkg5om7IUTndj2WJhlaCjH3KD5SgLi89+uXXlRk7HOruLHjqP?=
 =?us-ascii?Q?NtxTmTYlm3RoSHBP9RNOg2aJRtOq/dXYCQC8Rdy1aKkBd4QPSbIfGhBlmHcs?=
 =?us-ascii?Q?FaPFnPDRPIQFwzZNP2lojWSSZWuNWi8HahSyMMznS5eD1D8xvNcgDTHmxea8?=
 =?us-ascii?Q?aPNBKtWdZo+qLiWY3Z/BDA2gh2D+4ONwFg9ItiHOdVyx9B9N9L4CWZ5sdC1o?=
 =?us-ascii?Q?TOcaxaK+WAZucdvaBtw2oX/wPMAtAcwPFr4aQhq5OHwKuNXa6X5zdTHX/cej?=
 =?us-ascii?Q?ApPZx9YuNcS8eUN6f1MSRHlIIjwoK8OOJjy1rM1o0DAo/vrN/4Wv4rCph0Z8?=
 =?us-ascii?Q?SuQNXesL1+FqiaWeiuNEEc8h9+yyzbvt9y1+4hO/uiovrXOifGXn+pmJGwOC?=
 =?us-ascii?Q?dv9IJQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(34020700016)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2026 03:33:48.1349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe22a9e-a51f-4a1d-6c52-08de557939d3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6877
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
Change log:
	v1->v2: Updated openocd cfg file path, usage note and TRM link.

v1:https://lore.kernel.org/all/20260105183545.4108567-1-p-bhagat@ti.com/

 doc/board/ti/am62dx_evm.rst | 256 ++++++++++++++++++++++++++++++++++++
 doc/board/ti/k3.rst         |   1 +
 2 files changed, 257 insertions(+)
 create mode 100644 doc/board/ti/am62dx_evm.rst

diff --git a/doc/board/ti/am62dx_evm.rst b/doc/board/ti/am62dx_evm.rst
new file mode 100644
index 00000000000..2d66241ce68
--- /dev/null
+++ b/doc/board/ti/am62dx_evm.rst
@@ -0,0 +1,256 @@
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
+The following table shows some common boot modes used on AM62D platform. More
+details can be found in the Technical Reference Manual:
+https://www.ti.com/lit/pdf/sprujd4 under the `Boot Mode Pins` section.
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
+  **AM62A**: OpenOCD support since August 2023 (git master)
+
+  **AM62D**: Uses AM62A configuration (compatible due to same core architecture)
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
+  openocd -f board/ti/am62a7evm.cfg
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

