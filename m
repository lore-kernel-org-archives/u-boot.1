Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A27C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 07:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 885EB80CBD;
	Mon, 24 Aug 2026 07:24:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bZ8pIWJX2QV0; Mon, 24 Aug 2026 07:24:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787556298;
	bh=ZDVOjchal2LLodDgmFOQAP5KZY6UP1y1/2sg7pgEo1A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f3ruzCTjKsbybE2e//IuQgT4nMzdeIEASVMN1IbTq3HLe6iMU9V2L3vdaUrCN+a44
	 nl5JhLAu3vnqYLI1advdHBYYCktZZeh+CyMBXhoGIQ0tJnXzU9XRQQ92S7cRZrPzzP
	 wJgLt2E71PXcMQYmNydVWiDgC76oswDDpdGUr4EZVgXmccIQnJT5PUhM+o8rfT5oLV
	 nFilIl56wkI3okKDhU73cmwEAeYrXHmKxYqtZsmKuOyCPDriTmuBox76CZzlAgc+Ts
	 DMG1el39VS5V6fjpx9vVYpiIGyhFLZEpFP2bJ6X4n7EwcWCqI5p6v2f5TE9A1iewGe
	 J5ASJZSnROZEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C00A380AEC;
	Mon, 24 Aug 2026 07:24:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D64E336
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:24:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B3DB80AEC
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:24:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xunIN3NIOz-W for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 07:24:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::1;
 helo=ch1pr05cu001.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=vxV1W6ED
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B5AFC80AE8
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:24:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7zVi0Ra720jK8L2GXhn5o5WBQBUPUIXe4NMULoN86SfxlpypINPSuWG9+DQTfPEOheV6mMb5B8LoDDc4Jwylmxg5P5phIbjBGbhjd5hu4PhmydG2XJYdffBLBSfIZ1ejor1EWm4qgTFlKpA5klQANuk80390eapenYQAg6hd+v6/WP+Og9Eq+F5JK6WJvSpqzCdV9VpbQdvMPDkvz7PU7LmftZhdE1Elas6zGRep3vALqD4xdsws8Qo369e9Yw2wBNhXZSp5aeDBo1HDjaZj7Ucs70xpr5xN+RhoIFqxs2Vl6MeF9xzSjweXFiNhBzGzXR44qAJ8B9zH/hk/aXm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDVOjchal2LLodDgmFOQAP5KZY6UP1y1/2sg7pgEo1A=;
 b=lEJsP30c9153cdTVQuzHggYWn+t3YCxTB5lKh21OOYJhPDRksxUDhLtJnkB8Vxn9dnH+lfcQ/Bwa9ywqmPdtPVreiP+pwFkkQnUoLqXlQS2HpF0bRzhADgH4xdmW4ftaXKTQbIFk3VbBCs3NFcrRBixfnwU7cjVUSB3V/Be2tdzJYDfbneQyuYP/MCtD94FTldYhsoeoCFpK9PiuGen8ggfQNXl4y1V5sfiMCpNzmMw5c916+xWLIX0dEBMIuyjLzZGRg75PFzsguHoVWLYwLFfyoSPaCV/bbo3Hw0eP9rJiRB5roHLtZh0RuVCr1roCdpiM+6Bf8Z+kyOYsVP931w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDVOjchal2LLodDgmFOQAP5KZY6UP1y1/2sg7pgEo1A=;
 b=vxV1W6EDi8hAII6gWUY5l+oAkL8e1m1wh58ULSslCTZjepBj5nv5mVGWkGn0GSSqYlB3s2PoAkdrZgmwYQVcWqEj/aW+v1XxGnSyWz9h5FOajRCvmyP2qbN9/65kkgbP4qdcmz4ruobjWkE53Vq6crwVzB89qyYw5xlAEz4arBY=
Received: from SN7P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::7)
 by PH7PR12MB9152.namprd12.prod.outlook.com (2603:10b6:510:2ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 07:24:51 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:123:cafe::26) by SN7P220CA0002.outlook.office365.com
 (2603:10b6:806:123::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 07:24:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 07:24:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 02:24:50 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 02:24:47 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Padmarao Begari <padmarao.begari@amd.com>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, Pranav Tilak <pranav.vinaytilak@amd.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 5/5] arm64: versal: Enable PCIe/NVMe support and add NVMe boot
 target
Date: Mon, 24 Aug 2026 12:51:49 +0530
Message-ID: <3c87c252d97a6e5fcd2d30fad70329d6135c32f5.1787554549.git.pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1787554549.git.pranav.sanwal@amd.com>
References: <cover.1787554549.git.pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|PH7PR12MB9152:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1e50d3-29f4-499c-6d31-08df01b0c951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: e3vuBADU2XZ6qY2q5pKOLMzFcoVZVmdBaLwvP+tpaQOGQHKtrrPPGUeNGUuw2Sh8NydelB/7FENkU2j/etCljNT2+ukn5iyveZBF9RG6Rf19zOOabx9gKaM+sGUiXzHtF4Z/j7YvSqdN5QNUuiw0D6KxUy75KbusyXu2JX602ON//lktojGZO1EWw58HeTrj/vMkj+FcKEHePH+sOaJ4Mr8KhBwwItTcgbXKPWc5pJOrAOx0UpSeqaZMmwyYUr1/iHPINtqWHZ1aA8t7e5pPzsLKyHyu00yJCeUqig30Gfs4FL31GXy7XjUb5UTQQ5/dzB6QdpLeHrdbnfv6/DWUh074Q9jpvjFasguk/Cb+LroVccq2zbAGwTz0qkJHUnSyXeZJ1nvFEcNbnq71P1l/c19sHW71XkDbtzPDEk8m87wYpyViwlJX+rnDXu5U0v6gZRlUE1miuM6NLUI4yBfJF+XBv3Iy69rnhLdPw+N0XUzkhy/1OjqdZ+lgo5jorf9gDJXrjFiaHTgo6qHmqKuQ0eNJ81WnIYzr1B8zHMIiz8tP+itAoivDGaghJ7bLAFH/8Adq2jaZ9ZFLTeLmFXSngftMkWaevzlU2M51gT046D2Nv+L9YvytyI8I3DjkRxzMx3J6y4rG5NE+kf+0YYk/IpT4IcZJa6c+Ki+zlJMiJf5w0H+xnJksdemN8LGFQJYRZtK2ReSG87l3iwhWix4Irg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M4hKPxS3PivkZrIFdJY/6QllKRiDS7/rxnnFd1VjqQ3ip/syJ6pA1XArOPOdQBKfc1M7wm08knSU4P2uVmelf+YtecVJjRFBT3XFhORTAPebDy0BymbZVISKDxuBGg4rZLvgbSWry9LIvfSdYDvBw7zbNBsXjF1NOqtU9IjLns9V/bS/EraCqah0EmNKk6FFcfIfTA7gZKqL9ylUroTYgpS96AHTYX4eixJ9SZCTwpdLA9SZXjKtSsKUyaMvv1ZeUr0KvN6+fH7fQavZue0VxF8rt9qv/DjOzVPTr/e02MA59zRjL2DNfgQ3jZC0w1Orz/Xvs+fgRxDpGKxV2c4LuFIb6HJP4mVGsvkZV8SSGlbYc9C4KpWlVufHZcW2nhW07CoklnmLX4yZykkWh1V71iMjx6YTS3f0aKX8Nfd2ZYB66u4P68LJlizQeyR1Z3W5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 07:24:51.2721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1e50d3-29f4-499c-6d31-08df01b0c951
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9152
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

Enable the AMD Versal CPM/QDMA PCIe host controllers and NVMe storage
in the virtual platform defconfig.

Add BOOT_TARGET_DEVICES_NVME to xilinx_versal.h so NVMe is included
in the distro boot target list when CONFIG_NVME is enabled.

Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---
 configs/xilinx_versal_virt_defconfig | 6 ++++++
 include/configs/xilinx_versal.h      | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index a94468d9b9b..647e0455f85 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -16,6 +16,7 @@ CONFIG_SYS_LOAD_ADDR=0x8000000
 CONFIG_ENV_OFFSET_REDUND=0x7F00000
 CONFIG_CMD_FRU=y
 CONFIG_DEFINE_TCM_OCM_MMAP=y
+CONFIG_PCI=y
 CONFIG_SYS_MEMTEST_START=0x00000000
 CONFIG_SYS_MEMTEST_END=0x00001000
 CONFIG_REMAKE_ELF=y
@@ -47,9 +48,11 @@ CONFIG_CMD_CLK=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
+CONFIG_CMD_LSBLK=y
 CONFIG_CMD_MMC=y
 CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_CMD_MTD=y
+CONFIG_CMD_PCI=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_NFS=y
@@ -135,6 +138,9 @@ CONFIG_PHY_NATSEMI=y
 CONFIG_PHY_REALTEK=y
 CONFIG_PHY_TI_DP83867=y
 CONFIG_PHY_FIXED=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_AMD_CPM=y
+CONFIG_PCIE_AMD_QDMA_PL=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_ZYNQMP_POWER_DOMAIN=y
 CONFIG_RESET_ZYNQMP=y
diff --git a/include/configs/xilinx_versal.h b/include/configs/xilinx_versal.h
index 64f123424cf..cea3340cf2e 100644
--- a/include/configs/xilinx_versal.h
+++ b/include/configs/xilinx_versal.h
@@ -118,10 +118,17 @@
 #define BOOTENV_DEV_NAME_USB_THOR(devtypeu, devtypel, instance) \
 	""
 
+#if defined(CONFIG_NVME)
+# define BOOT_TARGET_DEVICES_NVME(func)	func(NVME, nvme, 0)
+#else
+# define BOOT_TARGET_DEVICES_NVME(func)
+#endif
+
 #define BOOT_TARGET_DEVICES(func) \
 	BOOT_TARGET_DEVICES_JTAG(func) \
 	BOOT_TARGET_DEVICES_MMC(func) \
 	BOOT_TARGET_DEVICES_XSPI(func) \
+	BOOT_TARGET_DEVICES_NVME(func) \
 	BOOT_TARGET_DEVICES_USB_DFU(func) \
 	BOOT_TARGET_DEVICES_USB_THOR(func) \
 	BOOT_TARGET_DEVICES_USB(func) \
-- 
2.43.7

