Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C17105F7AF
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 14:02:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16E0D8439C;
	Fri, 13 Mar 2026 15:00:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BcxP9yFt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02D288437C; Fri, 13 Mar 2026 14:59:59 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 552308436C
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBKVRhbdijyn59vD6jfD1KX3D8nMYlNPOXtTuCroH+HWiUiTea7l9UTAcXvf9oIMCnKqmXhszmstxWsi94CqCZ4EBfONPOh/YYL4y/fXZqCz7myZwk/IkUjqM4sF8otm1H0WoY0Dlmz3WHp556YTHBYgt7MDEwWnz8oVboceduO8KksosJZmi27FsQKmg95ziM5uvr7b79PmXf2v7I7Q4CvPaVqxGdVTRav7BpYZFVJP9NoxZgTZ0xmnFm3PJ9CCcxSTa9P3UeQ4qNWG6mscF1vHRGnWz0NGmu1ZtoxtWXzCE1u5F4d39AoEMR6UUPGmcDip/PSIF569l4AT1HxpYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxDlb3fhj+WuHrqLQwlnowQ78Rt8DkmCXkSS99ZqEmc=;
 b=lsd/dAgiPaJNWFKjmglMhKyuwbeMAG7ZMRdHm3ijciQCHCH7UzVvmIL9rM3pFp1z8DSLqAka+REc6yGWKUc2wL1HrbyTVPIORE7GlOFBCtjcgU/VAUq7OploMuwlgZe975aX3i8DnuAVoMfN/RPt2nlangeKNhWkYXT7a0TtWtQUkl0PlnxJEZRVFvCPFSmEP4YcWP9Ssy0Y4sOckc8rno8VZkA4XrSvNjtGxcsLQIhKfg+3rHj4vOxZmO5V9Gg7JQYMs+T3+IpaScqKIbqCQntDoSGdLiWT/NjPaQrDMHLaa2ds4BpvNJjmcX+RZu7ep87jehm05y/YXvHF5FLCyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxDlb3fhj+WuHrqLQwlnowQ78Rt8DkmCXkSS99ZqEmc=;
 b=BcxP9yFtu0drgeGHUm3lDgDwRawy6twzsleqzJo8oz0iTUV3Cn/6ebFaTHtghiWxoakmfN6qUnSsIbgqdZTprFketcUVSm26dv9JU4d5punM+vQ4wbAM7RC7XNq7q/k/TmmnXaBMxTHeHNiu9spHwYKeMcSRltOFEH7eoMQpvIg=
Received: from CH2PR04CA0007.namprd04.prod.outlook.com (2603:10b6:610:52::17)
 by SN7PR10MB6452.namprd10.prod.outlook.com (2603:10b6:806:2a3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 13:59:52 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::fc) by CH2PR04CA0007.outlook.office365.com
 (2603:10b6:610:52::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17 via Frontend Transport; Fri,
 13 Mar 2026 13:59:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 13:59:52 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:51 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:51 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 08:59:51 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [10.24.53.104])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62DDx6Jo638000;
 Fri, 13 Mar 2026 08:59:49 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <a-kumar2@ti.com>
Subject: [RFC PATCH 18/19] arm: mach-k3: j7200: Enable lpm resume flow for
 J7200 SOC
Date: Fri, 13 Mar 2026 19:28:59 +0530
Message-ID: <20260313135900.3430264-19-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313135900.3430264-1-p-mantena@ti.com>
References: <20260313135900.3430264-1-p-mantena@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|SN7PR10MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: d8b498d5-9969-4e19-6fe9-08de8108cc5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: M1ZGCrtRnRsfdpHBj8aXa1Tr5oDNqutdpcbtVScSlYYBFR7O7K4g9gUicnxI0Z9VYm5CuDm5trwq52wG5jd0EJykRPI9wC8NwNrrFaSBafVnW4DQ7aiy+z0+9rGcOaWGv0Ujd1XLuqxz3R1GgaeHToeB3ZEZ5IbCYqK+gnCfsQGgHQul0ovgq2+W/rabiyJpmxu3J0VmRcrmWO0xYIyQv6Gd+aRETbCtBo6xlKVjiVfM18HKVP4rrkGnZ0NuftMBiU3XkdObFIe5INMpDrZyReSZgVlLep+LqfKOll/6517UNm9Hh3twOF14kfGf8nXqAvfSndUGxW0x9/BDLa811sc+fd/GbTho77+e+uqu9eBbIcalaH7O17Wyip8Fuz+ZNl0S75y8YP63dEjzqQMKa9TwvVro6p4X0VK86hyVz+C1ocmrE+zVRNp32zvkK8De+ZnhhWn0BVSGgHDP4mjyUbLXYSpJ3MR5801QCq5fXKmsz0rV6H4vxGfqIdSvZZNyunfvEltuI09Sy0+yz8HH8Dgs0hAYiJ0IeQPBk2mP2np3GkKuc9CbB+TiX4LaL537zveQ2cMINC0uyc1ZdDf8XMYE9fLzQNeuPb7YqwHJ4VIV/qqdG6QCO1PbZQYX9MQT+/mBaqGldP4hfyzbyP879nFFlVPi6z1ykq3HVz1oY0TQKtJxTOM+FuDbnXAHQR5bOiiWnr7qAjHOSCA+pcchE1BVjlVhkWGZfbf00MjFTQDxvQy4cda6ycDacwAF7UtrNAfu1SpaCJSGEHCNtlabZQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lbTcYMxzYmD9AlaoMYe1KFSUfOnPhxhHoJFmTGETCZbKg1A5pLKQ61JTO/SjnJ8K4b9nDWfXAYEe7AvhJ5DHJEMb01QoAe/gatsQCU7B4NOoaDCNLOFMvaZMpEZDbhXMc2IORKFKeWGi3P8LvDju3gSwGbeI/gSQzdfyoJqrH3EPKDLycXa+7X0gcPITZaxjvq4q6Yx7hZWzv+xPYRAOhdhOZN0o1UUQc3lyS/QrQar8KNFE7SrGzEzeXFTMHxmMZcxsZXs9FgQQclPc3UoPXfDoUtf4BuqYRlPKX660JyL0PWUVhcv1h9Y+knZgRNiU6Ui70ZmEeV+6/eDkccjCrxZpcIPDoIo2/Rx3BhyfFNp2UwM/A7V8C6P2DCMfPE5IWLFn9WPV2iuy5JmF7OHZDPZrRV1X34ijsYvJ9PoKjnEK4Hw4Gi9bxxXgxPVYnJ5v
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:59:52.0464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b498d5-9969-4e19-6fe9-08de8108cc5a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6452
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

Add support for resuming from suspend in board_init_f.
The resume state of the SOC is identified and lpm resume
sequence is followed accordingly.

- Extract context address from devicetree and send to TIFS.
- Power on the rproc cluster.
- Replay the certificates attached to saved images of ATF and OPTEE.
- Resume sequence for context restore and rproc resume.
- Image entry to DM firmware.

The context address area is firewalled by TIFS to protect it from
other hosts. Same with the resume flow.

Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm/mach-k3/j721e/j721e_init.c           | 64 +++++++++++++++++++
 .../arm64/ti/k3-j7200-ti-ipc-firmware.dtsi    |  7 ++
 2 files changed, 71 insertions(+)

diff --git a/arch/arm/mach-k3/j721e/j721e_init.c b/arch/arm/mach-k3/j721e/j721e_init.c
index 220cb700ff7..2a492826e7f 100644
--- a/arch/arm/mach-k3/j721e/j721e_init.c
+++ b/arch/arm/mach-k3/j721e/j721e_init.c
@@ -243,6 +243,48 @@ static void store_boot_info_from_rom(void)
 	       sizeof(struct rom_extended_boot_data));
 }
 
+void lpm_process(void)
+{
+	int ret = 0;
+	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
+
+	save_certificate();
+	ret = ti_sci->ops.lpm_ops.lpm_save_addr(ti_sci, (uintptr_t)mem_addr_lpm.context_save_addr, mem_addr_lpm.size);
+	if (ret)
+		pr_err("TIFS lpm save addr fail\n");
+}
+
+int extract_lpm_region(void)
+{
+    ofnode node;
+	u32 lpm_reg_addr, lpm_reg_size;
+
+	node = ofnode_path("/reserved-memory/lpm-memory");
+	if (!ofnode_valid(node)) {
+		printf("lpm will not be functional\n");
+		return -ENODEV;
+	}
+
+	lpm_reg_addr = ofnode_get_addr(node);
+	if (lpm_reg_addr == FDT_ADDR_T_NONE) {
+		printf("Can't find a valid reserved node!\n");
+		return -ENODEV;
+    }
+
+	lpm_reg_size = ofnode_get_size(node);
+	if (lpm_reg_size == FDT_ADDR_T_NONE) {
+		printf("Can't find a valid reserved node!\n");
+		return -ENODEV;
+    }
+
+	mem_addr_lpm.context_save_addr = (u32 *)(uintptr_t)lpm_reg_addr;
+	mem_addr_lpm.atf_cert_addr =  (u32 *)((uintptr_t)mem_addr_lpm.context_save_addr + FW_IMAGE_SIZE);
+	mem_addr_lpm.optee_cert_addr = (u32 *)((uintptr_t)mem_addr_lpm.atf_cert_addr + FW_IMAGE_SIZE);
+	mem_addr_lpm.dm_save_addr = (u32 *)((uintptr_t)mem_addr_lpm.optee_cert_addr + (2*FW_IMAGE_SIZE));
+	mem_addr_lpm.size = lpm_reg_size;
+	return 0;
+}
+
 #ifdef CONFIG_SPL_OF_LIST
 void do_dt_magic(void)
 {
@@ -458,6 +500,9 @@ void board_init_f(ulong dummy)
 		panic("DRAM init failed: %d\n", ret);
 
 	if (board_is_resuming()) {
+		typedef void __noreturn (*image_entry_noargs_t)(void);
+		u32 loadaddr, size_int;
+		void *image_addr;
 		/*
 		 * The DDR resume sequence is:
 		 * - exit DDR from retention
@@ -469,6 +514,25 @@ void board_init_f(ulong dummy)
 		k3_deassert_DDR_RET();
 		k3_ddrss_lpddr4_change_freq(dev);
 		k3_ddrss_lpddr4_exit_low_power(dev, &regs);
+		ret = extract_lpm_region();
+		if (ret)
+			panic("Cannot find valid LPM address range..LPM resume failed \n");
+		image_addr = (void *)mem_addr_lpm.atf_cert_addr;
+		ret = rproc_load(1, (ulong)image_addr, 0x200);
+		if (ret)
+			panic("rproc failed to be initialized (%d)\n", ret);
+
+		image_addr = mem_addr_lpm.atf_cert_addr;
+		size_int = FW_IMAGE_SIZE;
+		ti_secure_image_replay_cert(&image_addr, &size_int);
+		image_addr = mem_addr_lpm.optee_cert_addr;
+		ti_secure_image_replay_cert(&image_addr, &size_int);
+		loadaddr = resume_to_dm_f();
+		printf("Starting ATF on ARM64 core...\n\n");
+		resume_rproc_f();
+
+		image_entry_noargs_t image_entry = (image_entry_noargs_t)loadaddr;
+		image_entry();
 	}
 #endif
 	spl_enable_cache();
diff --git a/dts/upstream/src/arm64/ti/k3-j7200-ti-ipc-firmware.dtsi b/dts/upstream/src/arm64/ti/k3-j7200-ti-ipc-firmware.dtsi
index 9477f1efbbc..c5bec876a8a 100644
--- a/dts/upstream/src/arm64/ti/k3-j7200-ti-ipc-firmware.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-j7200-ti-ipc-firmware.dtsi
@@ -47,6 +47,13 @@
 		alignment = <0x1000>;
 		no-map;
 	};
+
+	lpm_memory_region: lpm-memory@a4800000 {
+		reg = <0x00 0xa4800000 0x00 0x00300000>;
+		alignment = <0x1000>;
+		no-map;
+		bootph-all;
+	};
 };
 
 &mailbox0_cluster0 {
-- 
2.34.1

