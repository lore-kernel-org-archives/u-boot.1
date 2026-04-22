Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E18CF9B5F6
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 09:20:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B4518352B;
	Wed, 22 Apr 2026 11:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HTpJUAGt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C0A383E76; Wed, 22 Apr 2026 11:20:17 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36AB3801A9
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 11:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-tripathi1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLG9fN37jf8aXQYAibne/NIfCbftpKop4gGVRNQmsMpOIs5LQLdiCxhIiRtBtr/3ANPqlBaYuQyCD9mvmJ9yWIsLoYv76aZ5oNO5OW1AkvjuxcpiBk88+wUlGfR8ZWgxc7JKdpmejnZulDtjv8gIBqdzpsqb3Vwsf4fvn4Is+ioljC9z2jR0+8aC8FPnkt5SSAvMYllZClh5dIPvw5iwXV3LZBKkXcSaXBvocYvfmPSAcCwvVco0XKWtwvLJU+HCpZET6cwwSGULP7y+TXkuKvFPf/2my9A89kzb1hD6RsWduA8cJP3CoX1bM1oQLOio6flBK2MeM2J759vXWrO5iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBX6q+CYX2pWBS5Y7h6HM7NFPJzwK9Xbuzci4GFCRI8=;
 b=kzqyHuJCzbzh0uSZYU0PRIHDrKlmDOyycLqfY8Ajzb/lKwkuZdH0+D9WsDYvkAsLpgM8NRFZ8w1/UtJdTuTZ/Ywp2PoqC7ZvReWhZhW9mGH10ccFcj5wd/0f/UX47GVtT0tz+iUcFOX4ryyCIsNSVwN4GHWBZ60EQhbLSVM6C+8Yy2Z+K8Pfu9oEBdOAGyitebeQ+tG8N08yNLH/WYAxQ3K6ToFZmPecl8dIUgUBmZMPECuoH7Z0BVRrckXm1Yw+yTf1TTK9vX437jPf6mwRGThI7BJ6MyfCJjGOAmElZk/5xeEoDTz8e2wekK3Sdu4G+McWvIH29fG/ZXrgENF3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBX6q+CYX2pWBS5Y7h6HM7NFPJzwK9Xbuzci4GFCRI8=;
 b=HTpJUAGtRxjySOxaN86n1n2yb19xw3lvIS0LRPb2And4fTo58uSMPjD9H06vp/kBVpllTIr5h+++07KhTRx8ULUPL8RYMsjRx5gZ6lxNMNvVHUUNX0hjs/kI3+ncm3iqvyeB4exJ0p/5nkRG1LV92/ZmAj6VNg2RccdXaT2Sz2w=
Received: from SJ0PR03CA0256.namprd03.prod.outlook.com (2603:10b6:a03:3a0::21)
 by CY8PR10MB6564.namprd10.prod.outlook.com (2603:10b6:930:58::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 09:20:11 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::81) by SJ0PR03CA0256.outlook.office365.com
 (2603:10b6:a03:3a0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 09:20:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 09:20:10 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Apr
 2026 04:20:09 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Apr
 2026 04:20:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Apr 2026 04:20:09 -0500
Received: from HP-Z2-Tower-G9.dhcp.ti.com (hp-z2-tower-g9.dhcp.ti.com
 [10.24.68.200])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63M9K6Pt1924121;
 Wed, 22 Apr 2026 04:20:07 -0500
From: Shiva Tripathi <s-tripathi1@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <vishalm@ti.com>, <k-malarvizhi@ti.com>,
 <kamlesh@ti.com>, <s-tripathi1@ti.com>
Subject: [PATCH] doc: board: ti: k3: Add fTPM support documentation
Date: Wed, 22 Apr 2026 14:49:49 +0530
Message-ID: <20260422091949.1684616-1-s-tripathi1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|CY8PR10MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: c58aff7e-2e27-417c-3a55-08dea0505a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 76WFLKtGgP+cCbCoNZd1Xg4PoCCpPHdid98mSaQdyn0CGo3Qlho6vnnNmh0bXs6DloPydVYaLbH1uDO6JbGC3lBtB6fVYWaJ/PGa6UKSINPU3VSFvU7Qg3BnShDngtloAW35RrCZZAdMoCUMuFD5k0R3lrITEWAYutxnpF9X4xjlEvC1Pj12Z66ZKLOggycg/HoeTYRPrZepzCGtOTYSNx2vMmsEgIAStWvXiqkWCv0//6whjCOkQ7inOQsE20QbBO2AoJyaW5KZ6avAS5z85pICZ0AbF9JQXQYjndM+GAqXqenYrSI669LLa+60D1uazy9k2UCvwy2V74HAIIIpA8H/CHNT7v2AT2YY309DuyGgsVOc1QZkntIduoOq/41H/9wSlL7kkHM6u+YeC50Zh5Vzc+fw28PKfMshCcjXYwLS/9q/KzFtDDjbmi051TWXLz4Zgxtek8bwvijfc9Yrexqy5oBT6P37boIFd74/XTNnB+F/YqMAbFGA/FBe54+BnuU7W1iwK8+fbtJWqdFvM7862H+OsqBn1zh7FumEjrEGAj/6NaW/npzOTI/5meLXHExUs89YO2V/uH3jLidsCB5r3qIZx45ju7FMN3zRPICF1mFv76bXPMNT6zEibPqfeGbt2aukEfKxF72N58pnDagP8IN2WAqx7L8di/yEIda9Q+vjLUvCbL3dNKYbVfK3UnWhGwOrv3nYHVIdSNE3UnKnSiJu6LHWFWFf0Aafp/I=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0AGs7wbq/j0Cu/b3uVDD3+1RJv5Rtzcvf2hdiiJGB4MMleOPZxWMRQOk7OJECxD9RBKkeLW+09CgjKeY6AVOFxt2AZ6aoYij8+LXrUUz/HjcAu3SBIgaNupa+Pv6ur0vVm5fwC6Zqht9dyzKQo+x+t07m+DC3hpDUJztnND9ByBYhps8uzQlK5x3l6lAwhho7/bJEQPUJqrP7bIDPSXqV78nAlBbmZ5V+Q9nJqSSZ6s9Gm8tQURwqVzZBiVPEy5QxU8K2UnK24BxeIy3+Uvgwd8xUdPkjvxWLlfWggj98TjorSLJvpddAj1H3p31xxWiLUmqrs9Hi1LaTK536nWmVLMPpj/sJKor/0LARHJRIdV/MaH/d3ho9VD+hjiL2zU4LcbcFji26Hp3dUkKtKAk9/Wo4wkP0zct4i98R2YR1jCCIpzn9bVteauWdHEY3O9V
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:20:10.9515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c58aff7e-2e27-417c-3a55-08dea0505a96
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6564
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

Add fTPM support documentation including an overview, configuration
steps for RPMB provisioning, OP-TEE TA build instructions, and
verification procedure.

Signed-off-by: Shiva Tripathi <s-tripathi1@ti.com>
---
 doc/board/ti/k3.rst | 83 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 74ece0c9acf..fa0d999affe 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -1258,3 +1258,86 @@ Currently, OpenOCD does not support tracing for K3 platforms. Tracing
 function could be beneficial if the bug in code occurs deep within
 nested function and can optionally save developers major trouble of
 stepping through a large quantity of code.
+
+Firmware TPM (fTPM) Support
+---------------------------
+
+K3 family of devices with **eMMC** are capable of supporting firmware TPM
+(fTPM) functionality through OP-TEE, providing TPM 2.0 capabilities
+without requiring discrete TPM hardware.
+The fTPM Trusted Application runs in OP-TEE secure world and uses
+eMMC Replay Protected Memory Block (RPMB) for secure persistent
+storage.
+
+The fTPM implementation consists of:
+
+* **fTPM TA**: Microsoft's fTPM Trusted Application (TA) running in OP-TEE
+* **RPMB Storage**: eMMC RPMB partition for persistent TPM NV storage
+* **U-Boot Support**: TPM commands and RPMB access via OP-TEE
+
+fTPM can be used to enable security features such as:
+
+* Measured boot
+* Secure key storage
+* Platform attestation
+
+Enabling fTPM in U-Boot
+^^^^^^^^^^^^^^^^^^^^^^^
+
+The following are the steps to enable fTPM in uboot:
+
+1. Programming Keys into eMMC RPMB
+""""""""""""""""""""""""""""""""""
+
+Since fTPM uses RPMB for persistent storage, the eMMC RPMB must be
+provisioned with an authentication key on first boot. This requires
+building optee_os with the ``CFG_RPMB_WRITE_KEY=y`` flag
+
+.. prompt:: bash $
+
+  # inside optee_os source
+  make CROSS_COMPILE=$CC32 CROSS_COMPILE64=$CC64 CFG_ARM64_core=y \
+      PLATFORM=$OPTEE_PLATFORM CFG_RPMB_WRITE_KEY=y
+
+.. warning::
+
+  Programming the RPMB key is a **one-time, irreversible operation**.
+  The key is derived from the Hardware Unique Key (HUK) and cannot
+  be changed once programmed. For further details, refer
+  `Secure Storage <https://optee.readthedocs.io/en/latest/architecture/secure_storage.html>`_
+
+On first boot with this configuration, OP-TEE will automatically program
+the RPMB authentication key. Subsequent boots should use OP-TEE built
+without this flag.
+
+2. Generate fTPM TA binary
+""""""""""""""""""""""""""
+
+To generate fTPM TA binary, follow the
+`Building the TA <https://github.com/OP-TEE/optee_ftpm#building-the-ta>`_
+steps mentioned in the OP-TEE fTPM Github repository
+
+3. Build OP-TEE with TA:
+""""""""""""""""""""""""
+
+With the TA generated from last step, build optee-os with RPMB and early
+TA enabled:
+
+.. prompt:: bash $
+
+  # inside optee_os source
+  make CROSS_COMPILE=$CC32 CROSS_COMPILE64=$CC64 CFG_ARM64_core=y \
+      PLATFORM=$OPTEE_PLATFORM CFG_RPMB_FS=y CFG_REE_FS=n \
+      CFG_EARLY_TA=y CFG_RPMB_ANNOUNCE_PROBE_CAP=n \
+      EARLY_TA_PATHS=/path/to/ftpm_ta.stripped.elf
+
+Expected Outcome
+^^^^^^^^^^^^^^^^
+
+To verify fTPM support is working, run tpm2 commands in u-boot prompt:
+
+.. code-block:: console
+
+  => tpm2 info
+  Microsoft OP-TEE fTPM
+  => tpm2 init
-- 
2.34.1

