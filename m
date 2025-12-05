Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE83D116F1
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 04:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE9A184189;
	Fri,  5 Dec 2025 05:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DMyyrPQQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30EC38418E; Fri,  5 Dec 2025 05:36:25 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E94484181
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 05:36:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgZAYqd+/O4ZtqFrrBW4Sw9b+akOXgwUBQ1u8VnYJaHr99TVI9EA6Hyrpb0zTi/TV00j6UPKdU6Mrw5J9dtt0VN5bGb4S2XJzmvE447TQ/mp0Cd2H7CRLtq1iX+qVV0SrYkJJ9Jc+RsI3dzCvHOjlJoKOh7kJv8jMZxF8zk/e4oWDCzHRHZ60+gIXUp7jIlnCgovFnpYDIGTycivrsR4TmjUHl+PHLOpceTu8Lh/RPPkCb7//FGfoUJ54EGGS/VjQznaiBpLN/Ta2G8s692qv20aJ4jPXAWhFXnOfzzaGjia4+xSJIHUBDgZOpyominE+FtpPwyumj0wvxgY+rO+5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyW+M76omEOAOg7gOh3EoIicoqH6gPPBb+CbfEh99Fk=;
 b=yDomqYthBpf4ntL3/JylMVnkA6MzdvPXo71yFIes5yP0QVbroFywDIojOIv9St802BONBFKu+xx3gSRDQA4FZXzZakl5C4BApLEbRkqCY5YNMwNl5lpxthI8Q9Q5oo1KmPkUfv32fhhKvGgdDNpjwzIFDsWX3mJl0c+ZOxEmjtndN1kgl5kuUnbe+D4QcVccgYp1GEc5k92sadad4CoIVL+8Mj8Z7RzQtXXaQiGcSjGWEYSDg+sfz6Gsv2Xovh3OW9LTOAE1qK00BG13t5c2YGOcisvO1GtZDzYQQknTSB5mcZDA/86EYEiHYmdH2DqB82vdUtsHFWmd10lyzZz1Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyW+M76omEOAOg7gOh3EoIicoqH6gPPBb+CbfEh99Fk=;
 b=DMyyrPQQnULHEhKspj1d9jCf6Zy/oaV4EVEF8SWZYDZPJpmTpOEGCXl7iszU7Q0IamMF1QD+SrdRUfMcvjjsHs9w96iJa/ecsqq39v16qYRMLozNxBf4osBRdje8zRFqX+VzMypzgcADlrl+myt54X2+mXWyXZWfCkPE3Ty6K9w=
Received: from CY5P221CA0037.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::9) by
 BL3PR10MB6092.namprd10.prod.outlook.com (2603:10b6:208:3b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 04:36:13 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::2b) by CY5P221CA0037.outlook.office365.com
 (2603:10b6:930:4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Fri,
 5 Dec 2025 04:36:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 04:36:11 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 22:36:10 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 22:36:10 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Dec 2025 22:36:10 -0600
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.198])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B54a7592697567;
 Thu, 4 Dec 2025 22:36:08 -0600
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>
CC: <nm@ti.com>, <u-boot@lists.denx.de>, <mkorpershoek@kernel.org>,
 <n-francis@ti.com>, <anshuld@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v2] doc: board: ti: Add J742S2 support
Date: Fri, 5 Dec 2025 10:06:02 +0530
Message-ID: <20251205043602.845730-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|BL3PR10MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f55ea8-be33-4344-f66a-08de33b7d101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HlJ865x6H3azFmz+nSMXwPHyVq8Cntt7aPV3nv2DbzCxpFVa9WGvzTHRR/E0?=
 =?us-ascii?Q?u7g3KLBJ0t+hHR0UekODiS3DjD2mjNJ88zUtQxQh4a2wUwDsPdftlh0kkIPc?=
 =?us-ascii?Q?qxDtx8tCPl9WnVLU+mVV2QRMqov4zjBQYszwHbqBOaOWbZYB4kgIsQfxT9Fd?=
 =?us-ascii?Q?iFyIQn4EAyjei7oDrMYoFGfyjLyYpc+Ho7PfQtZp8OJR7f5oKltwSaA+acsG?=
 =?us-ascii?Q?nrJzg1q2Raxx4I43Ez11tYzzIhtIyYNbGiUsoLrXEKLM02gsKYHnRfde3/aE?=
 =?us-ascii?Q?xb02R9QFr1QPjUeC8+JQlu3o4h/w53GRfH4hPMtlT2R3Q9BUK+3MbvjpUPiF?=
 =?us-ascii?Q?YgHN8eYdu1R9DH9XhPnUTSQXT8IoNdgdewaJ8KwxhFrM2qbZhtJmorE0+5et?=
 =?us-ascii?Q?GxA5WXoqsB524Mc0uWak4ZjVUaEQev9h2gbvDQSTsrzuD00Ne2KMl5XxJ+5C?=
 =?us-ascii?Q?vnvg6bJPEIA2gj7G11nHkoxtiG40ZtsOzSR/3YLywyppQwbFSemJ9RJsvaUr?=
 =?us-ascii?Q?ah+m+VZVKUK/+79mT1NwQPkobc30cdWGFt4cncXtrWD2CAL4USZL3b3PMk9H?=
 =?us-ascii?Q?txyAQiTuQZRKbCeq7rm9O9IFCdNKTnUlsidjxgHl846PvhT7/IsmFGKRO1ij?=
 =?us-ascii?Q?w2+UMVJt0lMoPJ5Gp89QWaQCwF1p0O4LZNukUZ6xw1A6O0abM+P7Efzmhk0x?=
 =?us-ascii?Q?785H4nBljPI2KohsUrO54BTPJk429GTcXKrOC+x2wJxE/nZPIKTrmHTfJar9?=
 =?us-ascii?Q?Cpj3k6BmAVnopE7Sab4xzDbOTVieunMoojaM+j9CZo3RbmwiI1BQrEPNwQtI?=
 =?us-ascii?Q?tD8zH51qlFA1ZEMn9ZZEfVV5aL1CbzL+YKmj65NgywtemxpD+gSUvNNsNPb4?=
 =?us-ascii?Q?kTP1kVB2hgUar9CWWW93LRqg1zFTTZHAv64nSSbBm6/AdxU5FLQgUsY6KJoD?=
 =?us-ascii?Q?hisIHFz2pUcEpUptO/7mo429CP+iTBxBdpFgusMoixXCH6VQsXoIWYMgWhKG?=
 =?us-ascii?Q?H9nHAMB/gV7gxaWnULXKLJ12Cwbm72YXtz2G1tLN5S0r0xJeQDaa2KuX7u3D?=
 =?us-ascii?Q?NOwwZfXrehbi3j+90O9xOh52NV1tC+JcyOn5ui241ppImpVZOI23dHzBb0BU?=
 =?us-ascii?Q?lMq5r9ETYGt0rnQXL6UyiiKIezsW3Lg3Iq4ZNvz4vgFXagjoJuBhv9lkqaQy?=
 =?us-ascii?Q?pECuzKnX7m9J+WBC7j6r82jD1HLXh9ad0XXHAvtwtJ2rvH690QqU3zrbV1aV?=
 =?us-ascii?Q?jPhUo4PjrqvvIMgM9MupVa/xXBaUQ4cs0TWQRu1WQdgd1RmQH9zHNpcSUL+o?=
 =?us-ascii?Q?H5QCHfacF1+U2RnOJNtQJ6s1qK/+/LkPbtRssU0qgDMfWbZKMe9iPiO0ICLL?=
 =?us-ascii?Q?97zoEP6Gm7D7bcU0xpB6/BmeaiATL+hJgii60fjpy42ZPag2tJKwC68h0kYV?=
 =?us-ascii?Q?fqTLsbIzcWuZEBQKQ9oazjYNx5lYQ2nAzRanQdtzG5omXj2W23pS3DTJKr/L?=
 =?us-ascii?Q?6ytcGBH1i9yG9P6KUTz7/sTHYrbCRKYYsSd1?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 04:36:11.0924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f55ea8-be33-4344-f66a-08de33b7d101
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6092
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

J742S2 SOC is derivative of J784S4, most of build infra of j784s4 is used
to build u-boot for J742S2 EVM board.

Add guide users on how to build for that board.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Test logs
https://gist.github.com/uditkumarti/b2e23151728628805a680b6eab528e7c

Changelog:
Changes in v2:
- Removed extra =
- link to v1:
https://lore.kernel.org/all/20251204142451.834404-1-u-kumar1@ti.com/

 doc/board/ti/j784s4_evm.rst | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
index 22442874110..69deeee1076 100644
--- a/doc/board/ti/j784s4_evm.rst
+++ b/doc/board/ti/j784s4_evm.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
 .. sectionauthor:: Apurva Nandan <a-nandan@ti.com>
 
-J784S4 and AM69 Platforms
-=========================
+J742S2, J784S4 and AM69 Platforms
+=================================
 
 Introduction
 ------------
@@ -37,6 +37,11 @@ Platform information:
 * https://www.ti.com/tool/J784S4XEVM
 * https://www.ti.com/tool/SK-AM69
 
+J742S2 is derivative of J784S24 SOC, More info can be found in
+
+* TRM : https://www.ti.com/lit/ug/spruje3/spruje3.pdf
+* Platform Information : https://www.ti.com/tool/J742S2XH01EVM
+
 Boot Flow
 ---------
 Below is the pictorial representation of boot flow:
@@ -99,6 +104,15 @@ Set the variables corresponding to this platform:
       export UBOOT_CFG_CORTEXR=am69_sk_r5_defconfig
       export UBOOT_CFG_CORTEXA=am69_sk_a72_defconfig
 
+.. note::
+
+   For J742S2-EVM, use the following U_BOOT_CFG instead:
+
+   .. prompt:: bash
+
+      export UBOOT_CFG_CORTEXR=j742s2_evm_r5_defconfig
+      export UBOOT_CFG_CORTEXA=j742s2_evm_a72_defconfig
+
 .. j784s4_evm_rst_include_start_build_steps
 
 1. Trusted Firmware-A
@@ -146,13 +160,19 @@ variant (GP, HS-FS, HS-SE) requires a different source for these files.
  - HS-FS
 
     * tiboot3-j784s4-hs-fs-evm.bin from :ref:`step 3.1 <j784s4_evm_rst_u_boot_r5>`
+    * tiboot3-j742s2-hs-fs-evm.bin from :ref:`step 3.1 <j784s4_evm_rst_u_boot_r5>`
     * tispl.bin, u-boot.img from :ref:`step 3.2 <j784s4_evm_rst_u_boot_a72>`
 
  - HS-SE
 
     * tiboot3-j784s4-hs-evm.bin from :ref:`step 3.1 <j784s4_evm_rst_u_boot_r5>`
+    * tiboot3-j742s2-hs-evm.bin from :ref:`step 3.1 <j784s4_evm_rst_u_boot_r5>`
     * tispl.bin, u-boot.img from :ref:`step 3.2 <j784s4_evm_rst_u_boot_a72>`
 
+.. note::
+
+   For J742S2, GP variant is not available.
+
 Image formats
 -------------
 
-- 
2.34.1

