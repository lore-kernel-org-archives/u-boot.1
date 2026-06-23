Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4D9CDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 12:56:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98E25849F7;
	Tue, 23 Jun 2026 14:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vOqOgQDw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66E2184A30; Tue, 23 Jun 2026 14:55:19 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00B8A849CE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPZFMpq9wc6bmUeaFvKv0NkVGsDtxOdMhrYhLqZn19BnXs2rElZA5YCopoiiQmtX8wqM0IZ86YXdkpvrB4tgSemxPVt0pBmzdagHSss7BG+CNbxpumXQgjQ7xbC75RH7kUwX/iyrJk3epTEWxgU+Ump1kcFVEUXP027prCvEZXhtp8oHHXmaDY4tQxCGU7b1TTV2Z1hcpzfxcU8cjbKeZAgSOLqc2ICUWnmeJO7Bv04GTPgLNQl6PEJgtk3xOuwuIXzHH9Kw7DoJdfSBZPjmtN2pg9BUvpED+VI1aYDhs7Pt4f98+XESeKTaG43mESWo7A54fMc0eFjEvatcAASujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd1Eo9Qud7Lc3jzhlSEfpfU62MttsiZC1yIBMnMKk3U=;
 b=th608wD85biJonV2d0GazfNSvNi7hGS+qn+4cAqYYZhBMuRT1uRQ6z3yYa7FlJRm5Eb3EIItbg6CdkSCmMcfTd5jzJ2JRv+lOkqyqrWNz1Yi3+eyziBaXytaZapMZ56vW5ugi2iwbEkHef3bgsGL/ENbE/jFswgx6ujR1NSqYH6xr9cH7EmlFIWzGjhZyxqHA/Ny8/Q9HiU/0VCCit6Si/OodY/EbSmYW8Rq13IW0iLkIwkvMVxyySE3p4Hy5QV9PGVn9+6abGZgZY4ShE08ry7QTiF/ecpf2TLHrqXlptppS3FBjf8Uda+X7Nn/MP9hiDJEA37UyivY6BrLG00pVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gd1Eo9Qud7Lc3jzhlSEfpfU62MttsiZC1yIBMnMKk3U=;
 b=vOqOgQDwihwJEad5tmIV4m+QC9q0KhrQIOZhpAsxicqST/u9wzcCsGKKh95RWsqo5F4j4/Vlbf5IoEUzMmkvl+872FKwmXuCx+ge9D0RQuQBrp1cJiOe+FF7d2wJNTcTWSQ97km+y3zG6MxcEXAGhXt1mw6k/9e39UPVt8LKQqM=
Received: from SA9PR13CA0024.namprd13.prod.outlook.com (2603:10b6:806:21::29)
 by MN6PR12MB8491.namprd12.prod.outlook.com (2603:10b6:208:46f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 12:55:08 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:21:cafe::4e) by SA9PR13CA0024.outlook.office365.com
 (2603:10b6:806:21::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 12:55:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 12:55:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:55:05 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:55:04 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 07:55:03 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Naman Trivedi <naman.trivedimanojbhai@amd.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Sean Anderson <sean.anderson@linux.dev>, "Senthil
 Nathan Thangaraj" <senthilnathan.thangaraj@amd.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 13/18] arm64: zynqmp: Decouple MMIO accessors from firmware
Date: Tue, 23 Jun 2026 14:53:38 +0200
Message-ID: <d532df144d2c8e34be835bad6d0de3b26befdf01.1782219202.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782219202.git.michal.simek@amd.com>
References: <cover.1782219202.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5418; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=UH7N9crndOcowFlakMbPetu2akmnfSrofHi1bgjj5fI=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRZNb7L39KmvpKlclnUSuZlLw+/1Dt3qmh99LOSjRku0
 5bHFKdodpSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEamYzMuz1O9CvuNV4a2ik
 S17vsuePN25znXHZZJv7Xs056/tK/s9h+Ge2hieU888l8c4tFh6PPFS1HxcXR7HLbEv+cOfx+dO
 WDzgA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|MN6PR12MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bff64df-3d2f-41a8-9e2e-08ded126a709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Z+M4Aegmgu10I6Rn30aPH4Iztg6fL5eYxsLpGvbd5sAOYiVZ2ybkeFtc61vRjC9J0LZrZ7Eyn4rJgTIQZ9iFtO6PGbTzhpBg6yCr9ld2ponmEtVFFt6x+eXolnY0eN//KkeByU/lPe/E3eedjew3fIr1FtvjLN+TCKBKM8RGnQZT+FPWEjsPi1Pm4T3fJ/iCwzTluXCqUMuAParSWyFOciDpS2pW4r3d/EU1aAYsyFYuygPVL88YB0+tusY3tawTC2FWkwbH4JfAYKFbYBvoDQdmulWdqXyCBuVLiFrbyDgaeSfpdsgrDtuNimgjvBFM0RyJWE8/n6fIugQ7xlSrC5PIuUGvV0BrretSgjMWXTO/bqwk6VjgPzeGu4p++A9dOi5KtOyVPpZ65VqUMmi8mL6oLfqn7qfQ2BOPr6i3+b5LsJ97vCpBbvA+4g9BY+1fhbsARYT1UGgqtg0lw736rTKUws15NTkkVhh+7tgzYzxwktVKfgJw5FG6YLOfqM6z0zC27jf7dOVWQz3Ueq3wJccWXS7nP8wKNMK/q0K4Zu+BGXQs33mVmwZy2iJbcWjRyeapoztD+/Fosiwhy6yKNnGargAX4EKQrQxwmCoWUWFYVohvVBOVvlygGFPliKqPzjH9rrV1NHIuvqmQy9W6RPkthWyKxrEVClBoNDqO1eladAhJ1a3+sVXHd2Fzwopr9KIJJPA9svPu0VBC81gR3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Duuly7IjwEqvh0mZKQUk8xsB9hFTQnb+YItVBzuONnU7KVfzWteVQpnK4Z3ioQ/1+eHs3dAVj3sYpa+MGz4PPEYhZByHnp2OTcVutlSXF1KkyynrIt1geXhLW4cqXe3XMHbisARHPCpsdie2sEOzwE/ZQKqsWNVi3AUPgqz5nTvKCdrNyj5z0OKxHsEOeQCMo/FXwzKMGbtgtnQR/Zh8oGOgGTYxHDg4Cqbqec2gA0oSyAhzF53xPxrjwKACPhDnO7b5jeeGRXqqSZScWxw9SInQirBtD6YEMpBpzXsIk+YB3C4J6P63N5Ouc367hscs/bfboG27tLQBjl8U5lqtOVkDyk0Yj/dNdjqB8qPBXUilpD7PXVf8J3FG5rDxaJfHABVfTom3KMQ+c5KFd8wyr53+pH34c1pNaWlyOKuMSmtGa28BATVqPVsDTqD+KZ8d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:55:07.3883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bff64df-3d2f-41a8-9e2e-08ded126a709
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8491
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

zynqmp_mmio_read() and zynqmp_mmio_write() selected between direct MMIO
and the firmware (PM_MMIO_READ/WRITE) interface with an in-function
IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE) / current_el() check. Generic arch
code should not carry firmware-specific ifdefs, and with SCMI the access
method changes again.

Split the accessors like the multiboot and bootmode hooks: the weak
default in arch/arm/mach-zynqmp does the direct MMIO access (used in SPL,
at EL3 and when no firmware is present), while firmware-zynqmp.c provides
a strong definition that issues the firmware call and falls back to the
direct access in SPL/EL3 where the SMC path is unavailable. The raw MMIO
primitives zynqmp_mmio_rawread() and zynqmp_mmio_rawwrite() are exported
for the shared fallback, and the read-modify-write helper now uses the
raw read instead of routing through the firmware-aware accessor.

The firmware-vs-MMIO decision is selected at link time, so adding SCMI
later only requires a third strong definition with no changes to generic
code.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-zynqmp/cpu.c                    | 49 ++++++-------------
 arch/arm/mach-zynqmp/include/mach/sys_proto.h |  3 ++
 drivers/firmware/firmware-zynqmp.c            | 31 ++++++++++++
 3 files changed, 48 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-zynqmp/cpu.c b/arch/arm/mach-zynqmp/cpu.c
index 5ab25e385eb6..f0d95b3376e0 100644
--- a/arch/arm/mach-zynqmp/cpu.c
+++ b/arch/arm/mach-zynqmp/cpu.c
@@ -172,15 +172,19 @@ unsigned int zynqmp_get_silicon_version(void)
 	return ZYNQMP_CSU_VERSION_SILICON;
 }
 
-static int zynqmp_mmio_rawwrite(const u32 address,
-		      const u32 mask,
-		      const u32 value)
+int zynqmp_mmio_rawread(const u32 address, u32 *value)
+{
+	*value = readl((ulong)address);
+	return 0;
+}
+
+int zynqmp_mmio_rawwrite(const u32 address, const u32 mask, const u32 value)
 {
 	u32 data;
 	u32 value_local = value;
 	int ret;
 
-	ret = zynqmp_mmio_read(address, &data);
+	ret = zynqmp_mmio_rawread(address, &data);
 	if (ret)
 		return ret;
 
@@ -191,48 +195,23 @@ static int zynqmp_mmio_rawwrite(const u32 address,
 	return 0;
 }
 
-static int zynqmp_mmio_rawread(const u32 address, u32 *value)
-{
-	*value = readl((ulong)address);
-	return 0;
-}
-
-int zynqmp_mmio_write(const u32 address,
-		      const u32 mask,
-		      const u32 value)
+int __weak zynqmp_mmio_write(const u32 address, const u32 mask, const u32 value)
 {
 	if (IS_ENABLED(CONFIG_XPL_BUILD) || current_el() == 3)
 		return zynqmp_mmio_rawwrite(address, mask, value);
-#if defined(CONFIG_ZYNQMP_FIRMWARE)
-	else
-		return xilinx_pm_request(PM_MMIO_WRITE, address, mask,
-					 value, 0, 0, 0, NULL);
-#endif
 
 	return -EINVAL;
 }
 
-int zynqmp_mmio_read(const u32 address, u32 *value)
+int __weak zynqmp_mmio_read(const u32 address, u32 *value)
 {
-	u32 ret = -EINVAL;
-
 	if (!value)
-		return ret;
-
-	if (IS_ENABLED(CONFIG_XPL_BUILD) || current_el() == 3) {
-		ret = zynqmp_mmio_rawread(address, value);
-	}
-#if defined(CONFIG_ZYNQMP_FIRMWARE)
-	else {
-		u32 ret_payload[PAYLOAD_ARG_CNT];
+		return -EINVAL;
 
-		ret = xilinx_pm_request(PM_MMIO_READ, address, 0, 0,
-					0, 0, 0, ret_payload);
-		*value = ret_payload[1];
-	}
-#endif
+	if (IS_ENABLED(CONFIG_XPL_BUILD) || current_el() == 3)
+		return zynqmp_mmio_rawread(address, value);
 
-	return ret;
+	return -EINVAL;
 }
 
 void zynqmp_timer_setup(void)
diff --git a/arch/arm/mach-zynqmp/include/mach/sys_proto.h b/arch/arm/mach-zynqmp/include/mach/sys_proto.h
index 723e7593cf7b..d2bb10ffcbbb 100644
--- a/arch/arm/mach-zynqmp/include/mach/sys_proto.h
+++ b/arch/arm/mach-zynqmp/include/mach/sys_proto.h
@@ -56,5 +56,8 @@ void tcm_init(enum tcm_mode mode);
 #endif
 /* EL3 clock/timer register setup, called from board_early_init_r() */
 void zynqmp_timer_setup(void);
+/* Direct MMIO accessors (EL3/SPL or no-firmware path) */
+int zynqmp_mmio_rawread(const u32 address, u32 *value);
+int zynqmp_mmio_rawwrite(const u32 address, const u32 mask, const u32 value);
 
 #endif /* _ASM_ARCH_SYS_PROTO_H */
diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index 4c4f4c19ae4b..6052a31b5b40 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -373,6 +373,37 @@ u8 versal_net_get_bootmode(void)
 }
 #endif
 
+#if defined(CONFIG_ARCH_ZYNQMP)
+int zynqmp_mmio_write(const u32 address, const u32 mask, const u32 value)
+{
+	/* At EL3 or in SPL the firmware (SMC) path is unavailable */
+	if (IS_ENABLED(CONFIG_XPL_BUILD) || current_el() == 3)
+		return zynqmp_mmio_rawwrite(address, mask, value);
+
+	return xilinx_pm_request(PM_MMIO_WRITE, address, mask, value,
+				 0, 0, 0, NULL);
+}
+
+int zynqmp_mmio_read(const u32 address, u32 *value)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!value)
+		return -EINVAL;
+
+	/* At EL3 or in SPL the firmware (SMC) path is unavailable */
+	if (IS_ENABLED(CONFIG_XPL_BUILD) || current_el() == 3)
+		return zynqmp_mmio_rawread(address, value);
+
+	ret = xilinx_pm_request(PM_MMIO_READ, address, 0, 0, 0, 0, 0,
+				ret_payload);
+	*value = ret_payload[1];
+
+	return ret;
+}
+#endif
+
 #if defined(CONFIG_ARCH_VERSAL2)
 u32 versal2_pmc_multi_boot(void)
 {
-- 
2.43.0

