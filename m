Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6C5105F7A8
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 13:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DE82842CE;
	Fri, 13 Mar 2026 14:59:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YJv/8hWH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5E8F842DF; Fri, 13 Mar 2026 14:59:21 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C67B38420D
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:59:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0PkBrP4ZeohSAl1dlSDaos906ZGvTd/Xh9b+a8A4jPzWoeDxfqA649BHncVXxKX5+5S55qOL/JwEZTZehNce2Z26l9hIR73VBWtq8+0m0gRA0GquNC847oxV465VyaD7+Lkdqt2e5xAG28q3kCCzSHdLgzv/zyrOCFVBncjR70qrhWTgsccfcjiIAuPNGKO8RFxzutXUwUDZ1wC2x49HMxHq/YKOeshDmd6myloafWoROeNPiWZFgbc0AK6yhdlkSkdW+kesst4yipSw5vEypXM+JmPkThclRq4k0bvPbyN7XbBRHTfj5w+J1ORrCHaNFXWHu4aDTSPF9PYJk2alg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mf+wWLvwAGCVgQ1Z2wRaCnhhRM5/5frwqzfILC0TCdI=;
 b=mRWfPYGpq3aQgTcQfC7fz0r+IcvbIllZNVrNSjqfRzS+nj/wNYrNrvrSDGdY05xruNAuc/UVAny1YDGxLtH/ntNyrnd9waQ9AYh03n1bPyrXUcfsuWqX9vGkUAfNnsBDDaI9QTTYTC3BGjEy78iSBazseHuBRDqRRKkPR5JNPjflgJkh4RgcrBg7bLh08OK1s4RgcULZRPtf5U7wplbbOa9+c3IVPyohYCZkYQnKbwPLUAI2U1wdR40M+hy3eu39p9ryk1pJ6yD1xhOg5pas+F8uuKKSfzzUjWj/hRtpHjJehr1p48bv/sulAfgI29mGL4np2jyC1rpOuprPa1y9qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mf+wWLvwAGCVgQ1Z2wRaCnhhRM5/5frwqzfILC0TCdI=;
 b=YJv/8hWHXlIoq+F+gHSa1Pmxd7z3HIdZpdhPOJLfHad6h9fkv/ZAnibPIr82PJPFA80ElAmEqwUyA4t/B46yJZB4WSgYdwNPzDRG7VUi+6hmlm0+wduqNDTx6lHKJJ4mYnDOHDKAta1xKxXVFpXFh2lvVqd9bSFSKT8VDy5kSdY=
Received: from BL1PR13CA0384.namprd13.prod.outlook.com (2603:10b6:208:2c0::29)
 by MW6PR10MB7550.namprd10.prod.outlook.com (2603:10b6:303:240::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 13:59:16 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::a9) by BL1PR13CA0384.outlook.office365.com
 (2603:10b6:208:2c0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 13:59:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 13:59:14 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:09 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 08:59:09 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [10.24.53.104])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62DDx6JW638000;
 Fri, 13 Mar 2026 08:59:07 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <a-kumar2@ti.com>
Subject: [RFC PATCH 00/19] Enable Low power support for J7200 and J784S4 
Date: Fri, 13 Mar 2026 19:28:41 +0530
Message-ID: <20260313135900.3430264-1-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|MW6PR10MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee69111-f115-4a0f-793c-08de8108b624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18092099006|18002099003|56012099003|18082099003;
X-Microsoft-Antispam-Message-Info: gckKU35619Ik8Tj2acR3d0G2iwsJWOfsgicyBeDIDD5CTaeVntUwRjELNZn/aWPC9vqjpZNOlLSi5nBDaWbiiRN144Vv8iYISV0QkXMVUh8N5n+UQDJ4uIxWeEmO/hISmmdi7Eb0OGvtdya5x4LnBYUN1kfcjDHUbhn9Rq48Xo8aevWOdEu/ruXaTFN7F/Cf+y5HHHG8XTvB0ChFQelM7aXamBIl3kqpEdI/Mkj1EkgOtQmkQ25idujF617QkVv3YdbczPprAiQiOog2pAfv56t2mf9EzD2fBLqhJ3JGPmaewifm4wO8fanQHOzc+bVI+fYbZrx+4UNB96IGUR1anVly26pfud4RFxk63VHI9UKE9Xj7+1X3OPwQG7ohxff23UIoCB8p5P49Fu13H07b3MbQydQDUlU2swxTO69UaXOiKRSdDb9dA9jxOQ3/3a880m4O0SrSVWsIWevf0kWZct05ZwmEquB2kZPYe0y8kNlhzZwtHCtUSsS2sllw+uf/Ced4V/+yFx2gv+NS822sMXc6bg1HutnBKeASEgnUFR1GXA2V8HcQa6XezbKX0JiXc2JnA5xcfffWHX+5F2GyE6dzt0TEPn5hY0Zh/MZULJ2pfJJev9+dHouPbUvX3aEpPpMlvFzYb98h0x+3oaWnCZGRHWHPL/gwQJUceSVAE7RzZhrP03F5lo8ORy7QPpwGZgraenof71TU2iob4njbfmA/zGEisT/vZGLszrVyDvY=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18092099006)(18002099003)(56012099003)(18082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mJ/w5c6yb7rnutnsyQUOHI1ci3IPRzDAsWl9eYkQCIN5K9hz2fLfXsmU0NRsTHti3N30D9pyJMkJn+pyI1aRuFcYnels1W3x9GbKq2Oc7ccFmoCk5/OKoKsNRUNwEFSaZ1PYkCVIy65O6k4o7YjssruZcrPyXvQG+rJ7mHsRNMzYrfXsM0ZK5sHPRafilJ8nrz0oOSm3Hm0jk2g95ukKOSfs2akFvmX+vJ5dyl8QHzXKVk4piP049dRaqdLJ7DFngK5zObUpDyffkM6p6VjrwDPk29AhsLyeOXGRMRUhS9LL3CHoHLpv9RmoQJtmMP8A+qN8Jd1+FQMdB7K32vwDFX3nybiu6H2tastWGujTN55MMNrl8XjWhLVpKaC4tgQQ19T3b2TinuO8fTLGPw2lrodAi2ES7ZeiTY8G/dVcdtqCE17k47RnJ/iTe5M2mFu3
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:59:14.7608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee69111-f115-4a0f-793c-08de8108b624
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7550
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

This series introduces support for SOC_OFF and IO+DDR low power mode on TI K3 J7200 and J784s4 SOCs.

The system suspend starts from the host, Linux in our case starts the suspend sequence
by safely suspending the drivers through pm ops and turns off the A cores expect one and
the control transfers to ATF. ATF is encrypted in this suspend flow by TIFS, at the address
that is conveyed to TIFS at the boot time at R5 spl stage.
Then the DDR is set into retention mode at lower op frequency and pmic powers off the remaining voltage rails.

The resume flow starts by reading a flag from the PMIC, which has been magic value set at
suspend time. This identifies the system being in resume flow and corresponding resume path is followed.

Following tasks are done at the R5 spl stage in resume flow.
- restore TIFS context
- Decrypt TFA and load into its msmc region
- set TFA resume vector to its warm_entrypoint
- Turn on A72 core and cluster

J7200 EVM log: https://gist.github.com/PrasanthBabuMantena/8dcfb743a8208b810a2d95d4827d7a04
J784S4 EVM log: https://gist.github.com/PrasanthBabuMantena/593fa0a02160fd1149e779d2a5c3a418

Abhash Kumar Jha (4):
  board: ti: Update pm-boardcfg for all k3 platforms
  board: evm: Enable de-isolation of IOs at resume for j7200 and j784s4
  board: ti: evm: Store wakeup reason on scratchpad memory
  arm: mach-k3: j784s4: Enable DDR_RET exit for j742s2

Gregory CLEMENT (1):
  configs: j784s4_evm_r5: Used main_r5 reserved memory in DDR for malloc
    heap

Prasanth Babu Mantena (7):
  configs: j7200_evm_r5: Used main_r5 reserved memory in DDR for malloc
    heap
  ram: k3-ddrss: Add functionality to identify resume
  arm: dts: k3-j7200: Remove background firewall on DDR
  arm: dts: k3-j7200: Extend firewall for ATF region to TIFS
  r5: comomon.c: Add helper functions needed in LPM resume sequence
  arm: mach-k3: j7200: Enable lpm resume flow for J7200 SOC
  arm: mach-k3: j784s4: Enable lpm resume flow for J784S4

Richard Genoud (3):
  global: k3: use gd to store the resume state
  board: ti: j784s4: Add exit retention for k3-ddrss (J784s4)
  firmware: ti_sci: add low power mode operations

Thomas Richard (4):
  ram: k3-ddrss: Add exit retention support
  board: ti: j721e: Add resume detection for J7200
  board: ti: j784s4: Add resume detection for J784s4
  board: ti: j721e: Add exit retention for k3-ddrss (J7200)

 arch/arm/dts/k3-binman.dtsi                   |  18 +-
 arch/arm/dts/k3-j7200-binman.dtsi             |  26 +-
 arch/arm/dts/k3-security.h                    |   1 +
 arch/arm/include/asm/global_data.h            |  11 +
 arch/arm/mach-k3/common.h                     |  14 +
 .../arm/mach-k3/include/mach/j721e_hardware.h |  20 ++
 .../mach-k3/include/mach/j784s4_hardware.h    |  19 ++
 arch/arm/mach-k3/include/mach/k3-ddr.h        |  18 ++
 arch/arm/mach-k3/include/mach/security.h      |   2 +
 arch/arm/mach-k3/j721e/j721e_init.c           | 124 +++++++++
 arch/arm/mach-k3/j784s4/j784s4_init.c         | 128 ++++++++-
 arch/arm/mach-k3/r5/common.c                  | 116 ++++++++
 arch/arm/mach-k3/schema.yaml                  | 181 ++++++++++--
 arch/arm/mach-k3/security.c                   |  64 +++++
 board/phytec/phycore_am62ax/pm-cfg.yaml       |   7 +-
 board/ti/am62ax/pm-cfg.yaml                   |   7 +-
 board/ti/am62px/pm-cfg.yaml                   |   7 +-
 board/ti/am62x/pm-cfg.yaml                    |   7 +-
 board/ti/am64x/pm-cfg.yaml                    |   7 +-
 board/ti/am65x/pm-cfg.yaml                    |   7 +-
 board/ti/j7200/pm-cfg.yaml                    |  94 ++++++-
 board/ti/j721e/evm.c                          |  84 ++++++
 board/ti/j721e/pm-cfg.yaml                    |  94 ++++++-
 board/ti/j721s2/pm-cfg.yaml                   |   7 +-
 board/ti/j722s/pm-cfg.yaml                    |   7 +-
 board/ti/j784s4/evm.c                         |  77 +++++
 board/ti/j784s4/pm-cfg.yaml                   |  94 ++++++-
 configs/j7200_evm_r5_defconfig                |   5 +-
 configs/j784s4_evm_r5_defconfig               |   3 +-
 drivers/firmware/ti_sci.c                     | 218 +++++++++++++++
 drivers/firmware/ti_sci.h                     | 103 +++++++
 drivers/ram/k3-ddrss/k3-ddrss.c               | 263 +++++++++++++++++-
 drivers/ram/k3-ddrss/lpddr4_k3_reg.h          | 120 ++++++++
 .../arm64/ti/k3-j7200-ti-ipc-firmware.dtsi    |   7 +
 ...-j784s4-j742s2-ti-ipc-firmware-common.dtsi |   6 +
 include/linux/soc/ti/ti_sci_protocol.h        |  17 ++
 tools/binman/etype/ti_board_config.py         |   4 +-
 37 files changed, 1904 insertions(+), 83 deletions(-)
 create mode 100644 drivers/ram/k3-ddrss/lpddr4_k3_reg.h

-- 
2.34.1

