Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CDFC44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 12:15:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC2A94081C;
	Wed, 22 Jul 2026 12:15:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ny69CtgtsvaO; Wed, 22 Jul 2026 12:15:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D5CB4407D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784722505;
	bh=6PWAu25/1HUogBsuDT2JiESZgEhP+F7sg/JSKYwZXVE=;
	h=To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=HpFPwKZo3O+Tsne0V96uXv0L6A9fiwbtOS0tcnLe9ySipwY4UyQE/88U/rYA5Hred
	 DDq4gB9fyhnREy0YQGSjDHA1/5C65KWXv+dBnXYOccmgvFZC9YcvK9Qw7CPyfLWIoB
	 Vx5IcEWKRuQXFNBw9N6Ic4EEs12ii0sjUuosO4zsSGE1+vUIWirbS3F1jXopaTG573
	 Iw4WIqd49EIA5GHrL/PDYt4LMbm0M8PvZhfMTnjTBPFzKJQwnX4ewpzXID4hbblJ0c
	 xbDE2j8bBiMWJedmT3qm2Q9z42Dgfke5uXPltVhVt5u60pfc92un7fBAEbw7cYyHgK
	 kYOaHnK3tZ8BQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5CB4407D8;
	Wed, 22 Jul 2026 12:15:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C84BFCE
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:15:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E4FF607C5
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:15:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4-lRCOrRh3t6 for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 12:15:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::5;
 helo=ch5pr02cu005.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F3C90607AA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F3C90607AA
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F3C90607AA
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:15:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pa8q3Bzsp8NRwkSe9vt2RMzUKN6J3xuOWt3uUeZ4zb1fswR+D8DL+lfv43t+mprgjkEBRt28bx9lEt0dtU1IjJWs9pcM8P1l82VcM5qZKNfBUAJfKqM+i2D806PZk2ePyqYdYRf+mSATQgLOfI5QjbHyeQTZVWaFvtpefsj47dlBRiwymTRaxuaO2uIKoMtWn6MRgGChopyM5g8YiMsAJDLJvXeTcbQVwDyNqQb6WIRErswTHqd8VNQZviQe5q4KMUkSI/CHFzHAh5HaXJKSBEQLZaKPa+heYDDbfWK/GrQPo3FYjuUze9zjHoG0yaptdDQY0a/63wlFl1FAa2H3xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PWAu25/1HUogBsuDT2JiESZgEhP+F7sg/JSKYwZXVE=;
 b=haE7G9YOkDiUD3tXIHdLfh8J3NF/IvwUYzoqm3+HpyDQ9lL0EGAG3YMSYiRNT76hJo/qFxFlVM66oVz/sote+tO4o8gvhRT9q8NU689fqHf47KLhrNUBGprK3WzX3QuL/S1wsa9Uwpb6v333Aos4oW/LsNFJ/rDC4fzm6088yxxc5EKLjt6K7TlryG78P9mcQHAWWXT11daTiC6FDK39XxyZQ6Z7HBPL1J4+fw3qhgES1ZX1gvw9IFXAkCyernNujoyLiJwrIrsGmAEQ+O9HS0yOqyhnpTmR5iho8yQpKMAdZG5UFmEcMHKP8d3MbCTDy1iHD7xf9Y4NmHQuTpoO1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from PH8P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::16)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 12:14:54 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::9d) by PH8P220CA0022.outlook.office365.com
 (2603:10b6:510:345::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 12:14:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 12:14:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 07:14:52 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 07:14:51 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 22 Jul 2026 07:14:50 -0500
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Padmarao Begari
 <padmarao.begari@amd.com>, Pranav Sanwal <pranav.sanwal@amd.com>, "Sean
 Anderson" <sean.anderson@linux.dev>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] xilinx: versal2: Add PM UFS firmware interface
Date: Wed, 22 Jul 2026 14:14:40 +0200
Message-ID: <799f67d15af40c77f26278890a7e504d370d4a18.1784722478.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4407; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=BCozRcmr0kVPhhlgCCqB7vpr8JYcJFvr8KfwRVu1Z84=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQlbDF5bV309KyUulbErZKWlOLS9PWesi8DE9gt57/8u
 dzc/My8jlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZhISzojw52Op3sKl509/i7c
 5JjGjnesek1sDLPszvys9YgpW5ponc3I8P/cYu0Dpj3/rGUWCLjLzgp/f9eZ17J+YYR+2KxDXjm
 lXAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|BY5PR12MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: bb4253d2-0e7e-46ed-98b4-08dee7ead646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: pWGf79X53NyQF4nCEXtFrymXQ12oiNYj7rJOUqZ5UDGAWnmUpk23O9LDCneZcqNgqdcGwEftq3IHz8UvVviVws075vOcT4Is+1dui1TpRQ7rAZOBW/qG7dG2lZ/EQwegvBAwkbJPslaUMRbNd97vYImZYIIkledlgtkv/oIqq4d9YvMKnQflnjhRs/CyLKKeAl9RnfB/sS0UsUvHvahaomgO4Y0AEbuVrnFe0T0ZMuOUNd6+Dz7MRwgf+rKMkCyoVHc0WwSR5sRPao32XbD5E0eKEPTDAGhg4L/Y65oSjznGKxoY8k1OvR3mUylOuZSz+G8uTMdrnKs/7Kxs2qc/m383Nlqd3hSCpY6iGahXsd5rZSXFtsuWsh4bfKBHRmRXcVIiuI5jCsr727gMQFgzAWE9lQjqgN22S5lyTFvis9cUBlWH5dHokeQt730ABjmyfmjo7HBgu/AMQjrhtMWGTv2SY/pUTMJ4abuZML0Y7EI4lJNr/YrFCqfx70mwewgQIoTVv+RoDHUhkb30mR9aL93yTR0FGZn1+EAl1hEer9D63QC++jJIGljJ4KeLi+Mm5lcXJIcoESm6LUf5mWT+P4sXUOMR3TplX6P6cTFGBawWxx07BnpfRP//70YO/Q3hteHP/iHSETK61uqj5a+7OMSP0DrvT7mG/9jDBsWFEXhnYJWiJXmZI+6kkCO27FBO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YgATf5RQ1r9DQs+zfKVIWyrNLr2m85LtDYWD+XTEMnGCi9mnIHubq4wlWzEnd5Mh5taJGM3kTUQES5/JtCha29UwSuodgW3QOdPj2Vo6spirD/aQdxjs+Bkr7PL+rAeae7FC2DCcdhXB26Be8F+Ves7zM+Sp+xZdOwL/Jjx5x6rfosk17JYMcE6wevYSVEHj2DiOVyKRl6HlnM5LdEf3ehVFR6Dibn617y9CrNoFqSS0UJPL6O/nGVb8GjexlwKdOzG7+oLL3AR4WIyn5HXiD/aYRQex3tCFwUfvgxUEIGJdfciYfB7DT8y43zFcFD5FrcmTDpoeBriiiL/b3uEEJtsIgS69IL/THGo0J8+w9YRr8mrqd9XYV5vPaRCoFviy7sAwBKZe5whJ7uIO0dEvEEs5I34sKsdGDym3pd2Qc8HZbaV01RjKPLjwDhYTPl5m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 12:14:53.5840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4253d2-0e7e-46ed-98b4-08dee7ead646
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PWAu25/1HUogBsuDT2JiESZgEhP+F7sg/JSKYwZXVE=;
 b=0h/vd68zJtNvt3ofcpdzAC6Nzpv+4IFBihxtbkP9nq67FnvTbBsPGcGQGQvR7oU6OZNTfq+GJQT1b1J8y2SQm1pWbGbt3CNQ6p9/MFCKolqpHB8koCY+oG68am4BZwpul6U2tFk9FnGE5HXAh6IP2j6A+IxnIiO1bv4Lx+gpeOQ=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=0h/vd68z
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
From: Michal Simek via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Michal Simek <michal.simek@amd.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add firmware interface for UFS access but also keep IO interface when
firmware is not enabled.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-versal2/cpu.c        | 24 +++++++++
 drivers/firmware/firmware-zynqmp.c | 79 +++++++++++++++++++++++++++---
 include/zynqmp_firmware.h          |  9 +++-
 3 files changed, 103 insertions(+), 9 deletions(-)

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
diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index 6052a31b5b40..ade761830dd1 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -178,26 +178,89 @@ unsigned int zynqmp_firmware_version(void)
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
 
diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
index 0e545e3db1be..89dcc95949a4 100644
--- a/include/zynqmp_firmware.h
+++ b/include/zynqmp_firmware.h
@@ -535,7 +535,14 @@ extern smc_call_handler_t __data smc_call_handler;
 
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
base-commit: 187327730cde520115bd090311760410f0020996
branch: debian-sent3

-- 
2.43.0

