Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA5AEEB565
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 17:36:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8AFB840E6;
	Wed, 31 Dec 2025 18:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="srH6uOd5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8A16840F6; Wed, 31 Dec 2025 18:36:40 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C8F7840DE
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 18:36:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9OcPGn2YELjGRobPgZpdi9O3o3pYDklHp8LIMyB2ItMh0wXJOgIL/c3Z0z4CpQ8GmrpJZi73EElaeTovelHD7nGppuv8sEm367PS6/p0Ce/NdWm4s9k5jdKCxMspaDkw8h+HNKA3mc64X9VdPkdOcTAQfigXb52ot6C6SSKyqOTYzmfg4KhaJqhaWNPtpmQWBETGzglsIgPOvmTLNeX+BMAcuSNE6AJ7Qqod0AXT2x8n/UznI1ZGSkplpcfb+Ke5DcgC2ookUMOz/SNYWTuNddIEovBkUfbrxU7BAv/ES6eHlnh5OFEKFUYCEFKnRmwQgb8t0HcALIz/dpbg4OidA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Boka77yTx4cqYwTJEL23gd1+ue/IrEeQf8s0Kp6rEmc=;
 b=NtWkDxRdqGLc19hUc799RkwqQsh9jVkg+dePL0srlw8A0CzihcB1mpwF/Ahl+ZDNnZ1yNmpB0PBIG6WAOYyOfXnY4Urae8LljiL2Hx7a3m0BRGZv3jYGOzgYT2/B8Jw4VjQ5W9oF5WrPbDSboRWntmECvwWKWS179Gz50xoeAJrX5H0ZPOHKCRVDX6ZUF91MdwdE2DHbhYOZKUBgUcaDKQ8icsHehhKSiXeXhWLwv1HKcwboVLcWa8UFt4h64n9rcr6L3+0sYZnyWcjcQEF3FvoyqgmwU+H6G8s7FZQFMV9aUQbQcJ1rykkHciWVPFVAPz8NkQ0AWgDS1pjhuAq+/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Boka77yTx4cqYwTJEL23gd1+ue/IrEeQf8s0Kp6rEmc=;
 b=srH6uOd5TadsJgfFSotTQToq4MrGZysHjLgi0IrTH9p3lELJbtNxsRBMzsoQSI3tpU8HUAIt2d36S26mmxThkdOeDKsLKl/odYGmUN3rnr62YMrWKJYKbbaUMYdRXO1owLNRaM5duTLJcqd9MYnLx+CV8YLrhj3Sx2KTZmq60gY=
Received: from BN9PR03CA0182.namprd03.prod.outlook.com (2603:10b6:408:f9::7)
 by MW4PR10MB6395.namprd10.prod.outlook.com (2603:10b6:303:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Wed, 31 Dec
 2025 17:36:34 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:f9:cafe::6e) by BN9PR03CA0182.outlook.office365.com
 (2603:10b6:408:f9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed,
 31 Dec 2025 17:36:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Wed, 31 Dec 2025 17:36:33 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 31 Dec
 2025 11:36:27 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 31 Dec
 2025 11:36:27 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 31 Dec 2025 11:36:27 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BVHaOqp2541396;
 Wed, 31 Dec 2025 11:36:24 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 00/11] Add support to boot TI K3 HSM M4 core
Date: Wed, 31 Dec 2025 23:06:10 +0530
Message-ID: <20251231173621.1069988-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|MW4PR10MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b49c7ed-03d2-4205-b507-08de4893241e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4EvBjaUH1WSjHUs9jUXa22A+9FEtnnd+uzm/5tGA0Ab66DPEVdUymRmSv+p7?=
 =?us-ascii?Q?g8U64QzlgtGCKU6Xrn1H02tpeaMWz989B1L1+uCjSjnLfR+ow7HeSDpqyuyh?=
 =?us-ascii?Q?GUiIE+V8jb9/NSg/TWxA38nUo5wFf9RAQSo1ODv0q5Gjy7+RlmDKlvGOtBQo?=
 =?us-ascii?Q?DyJeNqYjp+eDg/E5KjxNji7rBJCuvjXLwfhSLduDWhovx7FUqReyVgVcmy/F?=
 =?us-ascii?Q?OH2nawCcYKhCpY52Du3fxF8eFUWiwnrpWq38antCQrC3nmogT+nfQTjijTsU?=
 =?us-ascii?Q?2VSNotzXo8Zp9Wb+z63NB/NIxgKu8CmAWhj1Dk6qGm9IyJfevLdLG5TxuH1w?=
 =?us-ascii?Q?5ZoWo7GX9E5wsflvgxxizKQmlSjXQMifxvnzuThDg1gJyHpyigdckaDGoV4+?=
 =?us-ascii?Q?DWmzIRDcHyzRUa5etjvv5h5QwWlZcrTDKQYRhpdz699ibb97M3JcG0ky8xQ2?=
 =?us-ascii?Q?x1nJbqO0oVgADjhy9IsMWyJ01l6ofZgTcLf3B3BhkPFWfNC0yxK65Ak42wTd?=
 =?us-ascii?Q?34a/50TasBaz8joipVvWMrDmexVMiGUyzcIM+OtmXSwF8ywqFV3TvlaUsKFr?=
 =?us-ascii?Q?kfH5I0nakr+Rab0ZXtE60QL+PrQzqrprmFbr20y8bXZ7XWDzargg4pu3kaq0?=
 =?us-ascii?Q?ShKyn8/1Yq+ZP3pMm5bVAbz8M1NZeua0eCuOqbbtkfgp3jq8Fq1u1vRkQkO7?=
 =?us-ascii?Q?pOY+RkwqBOpnabPN5UiCPZAfLsZ7EXpdJ7ZxaiQ4PcGVseulnfhuKXcUJoU8?=
 =?us-ascii?Q?qlPJU4dxlJSvtRaf1G9VXNTtivPcRbOoMZUNTNlCUS973SGTq7hRXTT0LGQU?=
 =?us-ascii?Q?qgLVAFuoXr2XTrdzomfV5+8cY9z1jTfUUnQ06b3dPScQvwteUVogZOfD7u8a?=
 =?us-ascii?Q?5vcGRHA2/yFWrRMJuHjQPW7PLR35/ax2u6AzyELMtCtjud7OMXPjxdiqMCvK?=
 =?us-ascii?Q?wCtfRWXVvFCeYWllmK3EvI9CpigIhsLI6dFSJmiXjoG31aJYI7GU1MsGuugZ?=
 =?us-ascii?Q?mBdrvqzOpEawhW/+RX0NpC4RT62qpl4JrsSZ0RqUW8Tv/+qJozske7f98b6/?=
 =?us-ascii?Q?Kfqw/D3VpouXyD1F1FrMIguSWYED2wU2kwg82WOR5A/vPkwGgA1oBIfEiy3m?=
 =?us-ascii?Q?Mg1jpuEA9U5XcTwNoZuPa0J4w36U1BcuKaoZrU6tdZJX44WYGHzAtxcVnL8O?=
 =?us-ascii?Q?zxGrcHOnsHn75Bd2x+oBcZcm+O68LcklJkQyOrm/y2aSFbufWImVP1CTTXho?=
 =?us-ascii?Q?JmEpdsa77gA3m6SqI+K2PW/bA1DfiZsCD0q+PbO9YKMgkm1oLLCdeTPsewIM?=
 =?us-ascii?Q?O7kAaeyFyKaaytmsrff1nyIj6HhgdTSNuprJjhn5NQSnWR7sZda3Tj4pVSQc?=
 =?us-ascii?Q?CWCKslJFgkdo24jsCZQLy7MGQKtqzevug2Ib52Km89XBskf5tl4YjITm11Ix?=
 =?us-ascii?Q?8IsJHxC/ytrW59FNHwLWL1kwlw8i15i/TdAd/FGdX177AnYZ7twK8S+Ml5yn?=
 =?us-ascii?Q?wFiZUeZrjdGwUK6k93PU2GEwpQNvQB/VDgqWSGfr4WINGR7Nt8aFkqWdc2RJ?=
 =?us-ascii?Q?HPF1xg9VuhF/tzV8gCi8Hq8VJXGmHY+mxwuqV20i?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 17:36:33.5902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b49c7ed-03d2-4205-b507-08de4893241e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6395
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

Some TI K3 SoCs like J721S2, J784S4, and J722S have a HSM (High Security
Module) M4F core in the Wakeup Voltage Domain which could be used to
run secure services like Authentication. Boot flow for HSM M4 core is
different than the general purpose M4F cores, and is as below:

1. Request control of HSM M4F remote processor.
2. Assert Reset on the HSM M4F remote processor.
3. Request Secure Entity to Authenticate and Load HSM firmware into
   core's internal SRAM memory region. For GP device, load the firmware
   manually into core's SRAM region.
4. Deassert Reset on the HSM M4F remote processor.
5. Release control of HSM M4F remote processor.

This series adds support to boot HSM M4 core from R5 SPL stage. The HSM
firmware is packed inside the tispl.bin fit image. The firmware is
unpacked into a temporary DDR address which is then used to load HSM
core. The configs to boot HSM M4 core are disabled by default.

Note:
This series is dependent on the device-tree changes series posted to
Kernel mailing list:
https://lore.kernel.org/all/20251231165102.950644-1-b-padhi@ti.com/

v3: Changelog:
[Andrew]:
 1. Added dedicated remoteproc driver for booting HSM core.
 2. Added support for signing HSM firmware images in U-Boot. [Anshul]
General:
 1. Add support for booting HSM on J722S SoC as well.

Link to v2:
http://lore.kernel.org/all/20250506104202.16741-1-b-padhi@ti.com/

v2: Changelog:
[Andrew]:
 1. Added support in SPL to load FIT images with no 'load' property.
 2. Removed 'default = n' in CONFIG option.
 3. Used __maybe_unused to decrease preprocessing.
 4. Better error messages with error code. 
[Udit]:
 1. Added 'HSM' entries in enum at the last.
 2. Added error condition in if-elseif-else ladder.
 3. Hang System boot when HSM failed to boot properly.

Link to v1:
https://lore.kernel.org/all/20250422095430.363792-1-b-padhi@ti.com/

Testing done:
1. Tested HSM boot across GP, HS-FS, HS-SE device types for J721S2,
J784S4 and J722S SoCs.

Logs after enabling HSM boot configs:
https://gist.github.com/3V3RYONE/ad33683652c8c49e4fedab49f0493e79

Beleswar Padhi (11):
  spl: Use FIT data address as fallback when 'load' property is absent
  arm: mach-k3: Use FIT image data addr as fallback if 'load' prop is
    missing
  arm: mach-k3: Explicitly identify TIFSSTUB images when discarding
    buffers
  arm: mach-k3: Add config option for packaging HSM firmware
  arm: dts: k3-binman: Add template for packing HSM firmware
  arm: dts: k3-{j721s2/j722s/j784s4}-binman: Pack HSM firmware inside
    tispl.bin
  binman: openssl: Add boot and load extensions to x509 cert
  arm: dts: k3-{j721s2/j722s/j784s4}-r5.dtsi: Enable HSM core
  remoteproc: k3-hsm: Introduce a remoteproc driver for K3 HSM core
  arm: mach-k3: r5: common: Invoke boot of HSM M4 core
  configs: j722s_evm_r5_hsmboot: Add new defconfig to show HSM boot

 MAINTAINERS                            |   1 +
 arch/arm/dts/k3-binman.dtsi            |  20 ++
 arch/arm/dts/k3-j721s2-binman.dtsi     |  12 ++
 arch/arm/dts/k3-j721s2-r5.dtsi         |   5 +
 arch/arm/dts/k3-j722s-binman.dtsi      |  12 ++
 arch/arm/dts/k3-j722s-r5-evm.dts       |   5 +
 arch/arm/dts/k3-j784s4-binman.dtsi     |  14 ++
 arch/arm/dts/k3-j784s4-r5.dtsi         |   4 +
 arch/arm/mach-k3/Kconfig               |   7 +
 arch/arm/mach-k3/r5/common.c           |  43 ++++-
 common/spl/spl_fit.c                   |  16 +-
 configs/j722s_evm_r5_hsmboot_defconfig |  41 ++++
 drivers/remoteproc/Kconfig             |  10 +
 drivers/remoteproc/Makefile            |   1 +
 drivers/remoteproc/ti_k3_hsm_rproc.c   | 252 +++++++++++++++++++++++++
 tools/binman/btool/openssl.py          |  49 ++++-
 tools/binman/etype/ti_secure.py        |  18 ++
 tools/binman/etype/x509_cert.py        |   4 +-
 18 files changed, 505 insertions(+), 9 deletions(-)
 create mode 100644 configs/j722s_evm_r5_hsmboot_defconfig
 create mode 100644 drivers/remoteproc/ti_k3_hsm_rproc.c

-- 
2.34.1

