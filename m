Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F3AC531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 05:25:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D6E440A97;
	Fri, 24 Jul 2026 05:25:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OBaW6-1us_1P; Fri, 24 Jul 2026 05:25:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2931540A8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784870731;
	bh=fS1nTHZ9hNvJPHacyjiX1Grb2rZHrCPCdMGLo2iSkd4=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=j4SfjqdkOS2NpOl9pbnYkq0tUB4gGi3FOAytOmAIWOmWiNQZjVsgXwVS4ZO0p7ZkZ
	 RjEq/SdtmAgJwOhiqUay2GszAaoybf56L2cApMbhlMruxOieGR2NqUA9gbqxwO7/xV
	 /nPObDNuU797ELMY2PNq8Hbvan+MiBfnKga1MKhl+iskxKC7b7ok7t8Q6c9sjdZo2N
	 QgufThOfcdtgRpw2JFm+UQRburz7W0uMLXBZYBKBEoKe4VadfjL6tFZKsg0bw6gHld
	 +I9yA5GHpjpebFm6IUKlt5FVxMz/tgQtJ8EG/as2pL0eBBX+LfIPcxFBUtiBRsLwJB
	 WQMS0ukm/djRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2931540A8B;
	Fri, 24 Jul 2026 05:25:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EB3E707
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 05:25:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 54A3740A8B
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 05:25:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FKYqpFavsBXm for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 05:25:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::3;
 helo=bn8pr05cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5A161409FF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A161409FF
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A161409FF
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 05:25:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/aLVOS+tTe4HoDDDVEOWvzl0/kd1QZ6WpKfn+fyz9mapqUzWuzF60CUCHdU0XRBoIroOn6XsYhQGMFmqwte/7VT2eox57U38TnDyAVkIJJVTtl6s6DSRKgncBJmks6lLiO+TJq/s4Vt1DW9b9ztiaMhXdPogXNWGx7gD0A1LYnqdi2+MyOfbhkgYzZjwOZ1k8uOmM6DaULsuhZ56ctKhOM5AEEkC8nQeHafy9eX8Kpa1WUkin3tZmfUNFSrNqbOaoHsjzNoBzczTgBU1bME+cVx/Jg3J3+pMhH3BUaUj2QWu67xoQWTrCRzskDTuffs2zSZxDgbXfaDugbyjsDc9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fS1nTHZ9hNvJPHacyjiX1Grb2rZHrCPCdMGLo2iSkd4=;
 b=mNa4v9s8DV5qQwJDFG7OsS6bf75VKxvmQhs4pJVEwTowx+YNTqinOt9Lh4sY+j4LSCRkJULHjWPpNKr3nWhg6VXyLtRhLM4kYCOWELlHLucqclwt62cZw0uqgSYo65Im4W1Fh5wkB4KItvwz0jnKfcGWfMtcnDBarJ2to4x1QdvRDOzXP8rP2JICznKbqO6QX7caxlnfEbnK2JKnKsgqXvfO3SbAW1Qv7rGMytDiMQ6X/cgfXxHdvn+pOaybUVy5P9I3FAyBQJPNnYN/ZG1ba/j2877JWqBUfRW2uoKptFWIce3unn9Nhx7wVUJTioI1dB1qyUqSZi3tDAfORNeOpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from MN2PR03CA0030.namprd03.prod.outlook.com (2603:10b6:208:23a::35)
 by DS2PR12MB9821.namprd12.prod.outlook.com (2603:10b6:8:270::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 05:25:21 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:23a:cafe::3b) by MN2PR03CA0030.outlook.office365.com
 (2603:10b6:208:23a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 05:25:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 05:25:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 00:25:18 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Fri, 24 Jul 2026 00:25:18 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Bhupesh Sharma <bhupesh.linux@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Julien Stephan <jstephan@baylibre.com>, "Neha
 Malcom Francis" <n-francis@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Padmarao Begari <padmarao.begari@amd.com>,
 Pranav Sanwal <pranav.sanwal@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>, Sean Anderson <sean.anderson@linux.dev>, "Tom
 Rini" <trini@konsulko.com>
Subject: [PATCH v2] xilinx: versal2: Add PM UFS firmware interface
Date: Fri, 24 Jul 2026 07:25:13 +0200
Message-ID: <6419fe4f6f1f451aee624c7762b7aa690d50e498.1784870711.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6609; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=28Vme1OqT3pWWptZAm0/G3Cl83mTWCfO4r+x9+PJI9k=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQlfbfOLaj2sqlhvbDBb21jpXlmzDbznKkii1PtDmsWL
 DH7v8muo5SFQYyDQVZMkWU6k47Dmm/Xlootj8yHmcPKBDKEgYtTACZyfQHDP6t3s61kS2WSZD6o
 vnlxIKgmI8//buCnYpPHEUsYZqhqPGNkmHv/YK961d0lf3LM068G/2oLnLX19CP1rMsXf3lrfp2
 8mhUA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|DS2PR12MB9821:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e808b8-785c-45b1-4be0-08dee943f3ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|11063799006|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: DA2YpkFvMTEv8s32kNv7/quHcN2rx530WLEazvhaJgJJQHpzA6orwkXU7zZqG3RtNnnTychzoiiieciA5RZ2GEKfeOhvifMgBIdown1aRACWTvxCi87HhD9h2jngAnNykcJcEStfKYXkBF2DZOhRtsW5HfjLzKjmzJyPTWa8WLcEFyzEU9bPr9vLfpMVws+NnKmULtorvL+bSJU8FTb86DajjjhfGwtrewvc2lTQZzEwQBloG98mdbqdufSq9dI1HEi4PxJRkiuv3MPUyjaRu6NgCTtCo5VmMGFwSzRezqNyfKeOappewzeAELdV3fcfCWjZvIKYq0Lc3sxIL9YP5elgJwj2rElWLJ3DQigR07oJ0pG6NV2n0fxKTdCDWDDTlBFsyL7DUOJIdKzC1hNoMZxtcngKWy+M3SEG6LhOgQ4k52LGu2JxyRCsDjH+Sb0nr8FvaS5gPwdgJW+KHz4+YdreZNsG26FUc8rWJpf+quBywvPub4SvWRT0FHvGYGEf64rM/TWE/k2ggYOhIDQkQgixNynb6YLp3Eu2DYXvhEGtRKzYQ1iVRlpmpJswXWUqkvnn19f7sC5DqnVrsT8BEazYyTqD2JIYhZzl5XG3Qla8bBalm2IBj9qp9+h4b3dJFV9YmGUWz4qXZhcaBXVb791L9R8HT4Tg9lKiq/5quJoUipj/awarDSBLmkGIyGJDU4AatAOc7n3jruNSUXFCuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(11063799006)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S7kwSdN8XivMJtoHdGbXMY3O2dfQXCDUli0Cj8N7G4bM7D4gjSkLBfpuWvgXmpigi5fTxHAgxOgxd3uOqUIl0HFl1LQAzQg5Ih1pzOw826S03vPJuRCEsJ3JrSvIaowY2KIbQcPXEGDn28+XCJUOhF5LzZc3Jb/MmIM084LBXij+m/EAtDqJif0oh9o3kdesie7Jq3/Yg4FlAtM2gToU+kmClOqOElrjAJElbN2HCb468H2UJhpdfOVbF2QRtS843VMlRwSlULhBLwT0yy7dwddV3gd5Xw/mBiF4u8CqCw+OSgb1B9KLbmO+as+7TFBCnEhXrlF6+wjDOt/d+NUf17DP3afLRYRsGH/Op9sAiEEfXS/imbVnelyyjF5pPxSKCn9qIXH9FsHMEGj1mzc8W2SgSHESUJZZQgwc6ZrJIDzc9SiIBV7/siGK7k9g5nN3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 05:25:19.7171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e808b8-785c-45b1-4be0-08dee943f3ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9821
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fS1nTHZ9hNvJPHacyjiX1Grb2rZHrCPCdMGLo2iSkd4=;
 b=5RiueMC3Pj4eK79nNB9ZjidV0fK//FTdfikjzannRGzkXfl785Dd4VFFEyilRyk2Gg08Tp7jkBqpmydknu3+R/LxZ0w/GQVEk+B8iBtB54GDa5HVrwVSaRfXeHOVu1GNHEMH+zGJrScdX6W2ObMOX2LNixe+xhoqvfbBx9j1avE=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=5RiueMC3
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add firmware interface for UFS access but also keep IO interface when
firmware is not enabled.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- also move prototypes to generic header

 arch/arm/mach-versal2/cpu.c                   | 24 ++++++
 .../arm/mach-versal2/include/mach/sys_proto.h |  7 +-
 drivers/firmware/firmware-zynqmp.c            | 79 +++++++++++++++++--
 drivers/ufs/ufs-amd-versal2.c                 |  4 +-
 include/zynqmp_firmware.h                     | 13 +--
 5 files changed, 112 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-versal2/cpu.c b/arch/arm/mach-versal2/cpu.c
index 6cc6592b0fc1..01efa7b79282 100644
--- a/arch/arm/mach-versal2/cpu.c
+++ b/arch/arm/mach-versal2/cpu.c
@@ -160,6 +160,30 @@ u8 __weak versal2_get_bootmode(void)
 	return bootmode;
 }
 
+int __weak zynqmp_pm_ufs_get_txrx_cfgrdy(u32 *value)
+{
+	*value = readl(PMXC_SLCR_BASE_ADDRESS + PMXC_TX_RX_CFG_RDY);
+	return 0;
+}
+
+int __weak zynqmp_pm_ufs_sram_csr_read(u32 *value)
+{
+	*value = readl(PMXC_SLCR_BASE_ADDRESS + PMXC_SRAM_CSR);
+	return 0;
+}
+
+int __weak zynqmp_pm_ufs_sram_csr_write(u32 *value)
+{
+	writel(*value, PMXC_SLCR_BASE_ADDRESS + PMXC_SRAM_CSR);
+	return 0;
+}
+
+int __weak zynqmp_pm_ufs_cal_reg(u32 *value)
+{
+	*value = readl(PMXC_EFUSE_CACHE_BASE_ADDRESS + PMXC_UFS_CAL_1_OFFSET);
+	return 0;
+}
+
 void versal2_timer_setup(void)
 {
 	u32 val;
diff --git a/arch/arm/mach-versal2/include/mach/sys_proto.h b/arch/arm/mach-versal2/include/mach/sys_proto.h
index b8d12d1dd3bb..c1dfd184d865 100644
--- a/arch/arm/mach-versal2/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal2/include/mach/sys_proto.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2021 - 2022, Xilinx, Inc.
- * Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
+ * Copyright (C) 2022 - 2026, Advanced Micro Devices, Inc.
  */
 
 #ifndef _ASM_ARCH_SYS_PROTO_H
@@ -22,4 +22,9 @@ u8 versal2_get_bootmode(void);
 /* EL3 clock/timer register setup, called from board_early_init_r() */
 void versal2_timer_setup(void);
 
+int zynqmp_pm_ufs_get_txrx_cfgrdy(u32 *value);
+int zynqmp_pm_ufs_sram_csr_read(u32 *value);
+int zynqmp_pm_ufs_sram_csr_write(u32 *value);
+int zynqmp_pm_ufs_cal_reg(u32 *value);
+
 #endif /* _ASM_ARCH_SYS_PROTO_H */
diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index 0783aa9a8ab7..2bdb1c4d9f89 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -177,26 +177,89 @@ unsigned int zynqmp_firmware_version(void)
 #if defined(CONFIG_ARCH_VERSAL2)
 int zynqmp_pm_ufs_get_txrx_cfgrdy(u32 *value)
 {
-	*value = readl(PMXC_SLCR_BASE_ADDRESS + PMXC_TX_RX_CFG_RDY);
-	return 0;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!value)
+		return -EINVAL;
+
+	ret = xilinx_pm_request(PM_IOCTL, PM_REGNODE_PMC_IOU_SLCR,
+				IOCTL_READ_REG, TXRX_CFGRDY_OFFSET, 0, 0,
+				0, ret_payload);
+	if (ret)
+		return ret;
+
+	*value = ret_payload[1];
+
+	return ret;
 }
 
 int zynqmp_pm_ufs_sram_csr_read(u32 *value)
 {
-	*value = readl(PMXC_SLCR_BASE_ADDRESS + PMXC_SRAM_CSR);
-	return 0;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!value)
+		return -EINVAL;
+
+	ret = xilinx_pm_request(PM_IOCTL, PM_REGNODE_PMC_IOU_SLCR,
+				IOCTL_READ_REG, SRAM_CSR_OFFSET, 0, 0,
+				0, ret_payload);
+	if (ret)
+		return ret;
+
+	*value = ret_payload[1];
+
+	return ret;
 }
 
 int zynqmp_pm_ufs_sram_csr_write(u32 *value)
 {
-	writel(*value, PMXC_SLCR_BASE_ADDRESS + PMXC_SRAM_CSR);
-	return 0;
+	int ret;
+
+	if (!value)
+		return -EINVAL;
+
+	ret = zynqmp_pm_is_function_supported(PM_IOCTL, IOCTL_MASK_WRITE_REG);
+	if (ret) {
+		printf("%s: IOCTL_MASK_WRITE_REG is not supported : %d\n"
+			, __func__, ret);
+		return 0;
+	}
+
+	ret = xilinx_pm_request(PM_IOCTL, PM_REGNODE_PMC_IOU_SLCR,
+				IOCTL_MASK_WRITE_REG, SRAM_CSR_OFFSET,
+				GENMASK(2, 1), *value, 0, NULL);
+	if (ret)
+		return ret;
+
+	return ret;
 }
 
 int zynqmp_pm_ufs_cal_reg(u32 *value)
 {
-	*value = readl(PMXC_EFUSE_CACHE_BASE_ADDRESS + PMXC_UFS_CAL_1_OFFSET);
-	return 0;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!value)
+		return -EINVAL;
+
+	ret = zynqmp_pm_is_function_supported(PM_IOCTL, IOCTL_READ_REG);
+	if (ret) {
+		printf("%s: IOCTL_READ_REG is not supported : %d\n"
+			, __func__, ret);
+		return 0;
+	}
+
+	ret = xilinx_pm_request(PM_IOCTL, PM_REGNODE_EFUSE_CACHE,
+				IOCTL_READ_REG, UFS_CAL_1_OFFSET, 0, 0,
+				0, ret_payload);
+	if (ret)
+		return ret;
+
+	*value = ret_payload[1];
+
+	return ret;
 }
 #endif /* CONFIG_ARCH_VERSAL2 */
 
diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
index 3369d32d924c..25af9dd63cca 100644
--- a/drivers/ufs/ufs-amd-versal2.c
+++ b/drivers/ufs/ufs-amd-versal2.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2024-2025 Advanced Micro Devices, Inc.
+ * Copyright (C) 2024-2026 Advanced Micro Devices, Inc.
  */
 
 #include <clk.h>
@@ -14,6 +14,8 @@
 #include <linux/time.h>
 #include <reset.h>
 
+#include <asm/arch/sys_proto.h>
+
 #include "ufs.h"
 #include "ufshcd-dwc.h"
 #include "ufshci-dwc.h"
diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
index 0e545e3db1be..f753a67ac276 100644
--- a/include/zynqmp_firmware.h
+++ b/include/zynqmp_firmware.h
@@ -465,10 +465,6 @@ int zynqmp_mmio_read(const u32 address, u32 *value);
 int zynqmp_mmio_write(const u32 address, const u32 mask, const u32 value);
 int zynqmp_pm_feature(const u32 api_id);
 u32 zynqmp_pm_get_bootmode_reg(void);
-int zynqmp_pm_ufs_get_txrx_cfgrdy(u32 *value);
-int zynqmp_pm_ufs_sram_csr_read(u32 *value);
-int zynqmp_pm_ufs_sram_csr_write(u32 *value);
-int zynqmp_pm_ufs_cal_reg(u32 *value);
 u32 zynqmp_pm_get_pmc_multi_boot_reg(void);
 u32 zynqmp_pm_get_pmc_global_pggs_reg(u32 reg_addr);
 
@@ -535,7 +531,14 @@ extern smc_call_handler_t __data smc_call_handler;
 
 #define PM_DEV_OSPI		(0x1822402aU)
 
-#define PM_REG_PGGS3	0x30004003
+#define PM_REGNODE_PMC_IOU_SLCR		0x30000002
+#define PM_REGNODE_EFUSE_CACHE		0x30000003
+#define PM_REG_PGGS3			0x30004003
+
+#define SRAM_CSR_OFFSET			0x104C
+#define TXRX_CFGRDY_OFFSET		0x1054
+#define UFS_CAL_1_OFFSET		0xBE8
+
 #define PMC_GLOBAL_PGGS3_REG_NODE	0x1824C005
 
 #endif /* _ZYNQMP_FIRMWARE_H_ */
---
base-commit: 3a500867bf0b8527ee7e94c325ce876562fba6c8
branch: debian-sent3

-- 
2.43.0

