Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2AEE98E10
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 10:03:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 733D583E36;
	Mon, 23 Feb 2026 11:02:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JjNMGlyK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4807583BC9; Mon, 23 Feb 2026 10:15:11 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 758C68063E
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 10:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-tripathi1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APv+klX+45/n9QqipgKEhCN2yAg0/ry2GSJ3ZdrCMPkktQUwTef64HqPKGn7tSPCSu1PiSSmulRb2emKk8dqIQ78wHsP/WBcGc1Gf1xF6Umho364NM+EGihgboeuq2I2Hf1Bpn6QVmlnHwqV5UD/d9sQeXLZb9cwWpj2TqqMeBD5zcb6YMF7lVzmn5Rukcchwd9U+U3QMT0QXl1ZlK0rfYCF1J2DP48EgmyTqRfZmvlZI87mVuOPeNXPdgZAka029CMA49QlUCxgCyhtopkvO63o4pdscVQxugWic83Z5cmqwcEjtQhEWH4eUL+qKQzJK/yvwZmuctvpP1o4//JnYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTSFOd8Fc2iSK936ZkOtT+nfFHTGeN0oBntObECjfhg=;
 b=W0hPez6MUJBZUFyiiMxj0TTTCz4HRvHoxqCY9uzP8mmLGs6PomA7/n9CTiTUufpMfkK05u/P4npafoiT0bD3GGd1SqKMKw3vX/QGjuXP5UDycbR/g1YnwMF7LMHB7i/BF8ztzmQQfRscruiCYe2R8CnyJgQC5tyfTaSaZZKd6IRepYIp86Y/Z8ZgsuDL2++qqyHJ/YYDyuNYldykzdHjQmgRHXwUv4HYSumPPu79SrdrtC4sijaUuT+4QYUdtMkttbYQTQwqx8JCVhelIVuoc35pfQA2N3U+4gkXovZjkDv54TxLleAP8N1+lJDxIbv/Xdmrh6NySqFzdvZBTKzPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTSFOd8Fc2iSK936ZkOtT+nfFHTGeN0oBntObECjfhg=;
 b=JjNMGlyKw/aKJCoGdhSD1qpv19GOgrTFOlWBbJ1U+TjzY10xVHZaCpk7KH3vQd8PoS9YQkDqMgMacgREMaY8ELWXSXDM8Ymx1+xnmD+Hl/XHsYSTXY4sfNJHDJ64Q7AXAHJjTJQUOTKux3ihwuGqgQKsRc1y+nIqPTAUMnGkqtI=
Received: from SJ0PR13CA0236.namprd13.prod.outlook.com (2603:10b6:a03:2c1::31)
 by IA1PR10MB6219.namprd10.prod.outlook.com (2603:10b6:208:3a4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 09:15:02 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::57) by SJ0PR13CA0236.outlook.office365.com
 (2603:10b6:a03:2c1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 09:14:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 09:15:01 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 03:15:01 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 03:15:00 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Feb 2026 03:15:00 -0600
Received: from HP-Z2-Tower-G9.dhcp.ti.com (hp-z2-tower-g9.dhcp.ti.com
 [10.24.68.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61N9EvWV521319;
 Mon, 23 Feb 2026 03:14:57 -0600
From: Shiva Tripathi <s-tripathi1@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <praneeth@ti.com>,
 <kamlesh@ti.com>, <vishalm@ti.com>, <k-malarvizhi@ti.com>, <afd@ti.com>,
 <anshuld@ti.com>, <s-tripathi1@ti.com>
Subject: [PATCH] configs: am62*_evm_a53_defconfig: Enable OP-TEE fTPM support
Date: Mon, 23 Feb 2026 14:43:14 +0530
Message-ID: <20260223091314.586968-1-s-tripathi1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|IA1PR10MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: f70bf624-83eb-4b24-a367-08de72bc0655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2OkPa0ZaJyQOWd673QcYK+x5j3TD3dDdZNfmOP5Pl8KE8/OZePCjWxAMdARr?=
 =?us-ascii?Q?QK+F9Mo9J2aAAUJp6svZoi/px0ImBS2T6pPZIcfsS4aoMEXw3lkNPOsOBm2A?=
 =?us-ascii?Q?69UhxEtVfrEQJ9yHSCEZTPtjlshlULB+hmdq321d9vn3CxfDGr+EvAWgfq2e?=
 =?us-ascii?Q?vL6vee1r0iCOGe8whEIO5rXDHS6DtwMaqIjFXYxlz4t3SuldYM5mS9RMdDeY?=
 =?us-ascii?Q?ZvgsGVQgkTW9EShIinGs59t5ZHptGXgqomy/hwOIh/hZZPrN8h9wqZEX+OyL?=
 =?us-ascii?Q?1SPQ3LibBWCXwdeV6w/R3hBStUofw+xrvry84ZtuYKgzZQ0tl16b15vft51G?=
 =?us-ascii?Q?bejB0fmuOQ9zJann/MCg5aOMsyQtsv+09lydNtXnbL+m5uU6N/2OdjfEZGcO?=
 =?us-ascii?Q?1dYq0QL8ldmOCh05wn2uVreB2Yz8HxTfmqygyA4RVsS2jsf9UP18oT2nhPrq?=
 =?us-ascii?Q?x3jXcWPugvsk2M9WyFB/WJT5LNiFPDyyfrRcCyNWU/vmHR1d1S7+yJQxDPFu?=
 =?us-ascii?Q?UxRpSGcK9yG5JzJ3FiDOaZVf9gtHgWHRJFi3FYBkS42M64aDPSFERn4FX+vr?=
 =?us-ascii?Q?5p23aP10Suvs1zCNczsxBJ68WSxcOMCyy2K19T4pnkoKnrfVjiuaH2d+tjZA?=
 =?us-ascii?Q?38r2TFp9ss9NmhpcWmR6JrTFwAs8bX2ZCFpvqZA5PeUe9CUSg61Ylsmzp+Us?=
 =?us-ascii?Q?OQOxhTjNsaXk94pWQKLJsbYe62T7YsIeJ/x/Qw1JsX7DW8E4AOKWDF90QaVA?=
 =?us-ascii?Q?twC0IkWiJ28/kxDRDvYEh3oKNxLMxS4C0F4uT8lTDAWMbXrIrMuI46gunX1c?=
 =?us-ascii?Q?AW7PFrliyqq9OcyAEelp2D8gwbPBKNP3KxgmxCAx4i7OfOJsXWGUzUU3TNbZ?=
 =?us-ascii?Q?HT4sF66PZwQMjD/TWZJRY4ek2bW43lugVCGmbK9v5MsBvX5QVcQNqyePhick?=
 =?us-ascii?Q?yLr3WvBZP9tLPvLYhxN/dOd5pluMciHPP+86NrDg42bvTyUumBZY9gWrAtkb?=
 =?us-ascii?Q?IcveeVfFwI8ulspQ+4vlQT3RgMqCvs8PiNGJ9zniWpzOYwDWramSsA5DDO+8?=
 =?us-ascii?Q?4+S/yfP44E6DGdSUvOtARLi9YF+SGCRGbbq5k7CT52iQHXaKlWpC2qKSW+Kp?=
 =?us-ascii?Q?YhEqTQUwXxQOyRShfztEOgLWSRynhJCWJlbE28AFSsqi1614EB/2v16iju3r?=
 =?us-ascii?Q?1dtm1H+wov0HMRmVujD6KkloFsHEboCrf/+Ut/D6pmCWfICPKrk5M1n8wRiu?=
 =?us-ascii?Q?YpF8X8uduh4vuVcFLwM73/F669iqsp1LrIoapTIorT/Vb6PPXwsA+TlsL43M?=
 =?us-ascii?Q?yIHwfh2LL2Sej1mdOrBApicPY/fyeWMT2JGRfVYmH8eVYlUkT/xHIuP3pBqb?=
 =?us-ascii?Q?P125s8RfsSm1ajB7kEqoXesBwmQXJ1iATu4KV2zFWS8ijeNaSADrdibmJH6W?=
 =?us-ascii?Q?DkFwtbOAI7FR0HdkPwFtVeUpycz40Rl/UIczxbhjjxtXUQAJOOJZ/FY6FNVu?=
 =?us-ascii?Q?+D3JIedcqobWp8RimpgS1YZkcjqhi//dKpY8GQb7WaAxewhxNihq4Dzhz3kV?=
 =?us-ascii?Q?YY5iGLSYvkF3BugnBcbBH9iFiglEYvB9y7RZJWHrNG1ZR9oAfev8ERuvJ+Mt?=
 =?us-ascii?Q?kSsIw+RYy4Re6qYYDLPP7/qLKMBCbO8kW9vPWjyMPtMvyltw7NC9fC/GjMi5?=
 =?us-ascii?Q?Hw2Ofg=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: th6FhpIyV8Kp7s6nwUg4ucEeeJbsPtDk1vS90Cs4pQXOqjiIR5sE3cbsJfVOGLRz9uRlTTT3aYGbyE/0+6Vvv2jzPyaTH1lsueV1er/K698jpdNvLNkKOtcSsqwyzrIoI/70pEYgkK4Rd6FzOSw3KNHAMG4RwCesDxfi4rHFAFVc0yzu24aYK4ep3bWJ5G4q3WnPCqzOa9EJ8vlGxXGwjerOTedxOuG4CC0CIb8vCtfGDlmjiHgkx2jCBThyiXk4OqAjGnXMvWx6t0O9KqVufneseaNSNbPkxyaYGWlDsydq52EO9pd5t50zCEDpfYRp4VTJXlDbT0hOwBsJfbZgLabATIjpJnOLXy3jQdReK0VMSGj8GEaNffvtquglN4iKsKFfZnthYIlfUUrrtcQgeVsFysN5oSG5tEeIvv0TT+jRwN631cWGr3fJFN+KtbJX
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 09:15:01.7550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f70bf624-83eb-4b24-a367-08de72bc0655
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6219
X-Mailman-Approved-At: Mon, 23 Feb 2026 11:02:21 +0100
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

Enable firmware TPM (fTPM) support for AM62x, AM62Ax, and AM62Px SoCs
by adding OP-TEE and TPM configuration options to the A53 defconfigs.

The AM62 family SoCs do not include an integrated hardware TPM. This
patch enables the Microsoft fTPM Trusted Application running in OP-TEE's
secure world to provide TPM 2.0 functionality, with persistent storage
backed by the eMMC RPMB partition.

This enables TPM 2.0 functionality in U-Boot and provides the foundation
for measured boot and disk encryption use cases.

Signed-off-by: Shiva Tripathi <s-tripathi1@ti.com>
---
 configs/am62ax_evm_a53_defconfig | 9 +++++++++
 configs/am62px_evm_a53_defconfig | 9 +++++++++
 configs/am62x_evm_a53_defconfig  | 9 +++++++++
 3 files changed, 27 insertions(+)

diff --git a/configs/am62ax_evm_a53_defconfig b/configs/am62ax_evm_a53_defconfig
index 167ba7ff8df..b14f19968a3 100644
--- a/configs/am62ax_evm_a53_defconfig
+++ b/configs/am62ax_evm_a53_defconfig
@@ -99,5 +99,14 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_TI_SCI=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
+CONFIG_TEE=y
+CONFIG_OPTEE=y
+CONFIG_TPM=y
+CONFIG_TPM_V2=y
+CONFIG_CMD_TPM=y
+CONFIG_TPM2_FTPM_TEE=y
+CONFIG_CMD_OPTEE_RPMB=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_CMD_MMC_RPMB=y
 
 #include <configs/am62x_a53_usbdfu.config>
diff --git a/configs/am62px_evm_a53_defconfig b/configs/am62px_evm_a53_defconfig
index aa241a73c3f..2cd572cd5c7 100644
--- a/configs/am62px_evm_a53_defconfig
+++ b/configs/am62px_evm_a53_defconfig
@@ -148,6 +148,15 @@ CONFIG_SPL_USB_HOST=y
 CONFIG_SPL_USB_STORAGE=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 CONFIG_EFI_SET_TIME=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
+CONFIG_TPM=y
+CONFIG_TPM_V2=y
+CONFIG_CMD_TPM=y
+CONFIG_TPM2_FTPM_TEE=y
+CONFIG_CMD_OPTEE_RPMB=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_CMD_MMC_RPMB=y
 
 #include <configs/k3_efi_capsule.config>
 #include <configs/am62x_a53_usbdfu.config>
diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index 281fa3fea15..3221a9b8f2b 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -138,6 +138,15 @@ CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_TI_SCI=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 CONFIG_EFI_SET_TIME=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
+CONFIG_TPM=y
+CONFIG_TPM_V2=y
+CONFIG_CMD_TPM=y
+CONFIG_TPM2_FTPM_TEE=y
+CONFIG_CMD_OPTEE_RPMB=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_CMD_MMC_RPMB=y
 
 #include <configs/k3_efi_capsule.config>
 #include <configs/am62x_a53_usbdfu.config>
-- 
2.34.1

