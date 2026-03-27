Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CE210ED669
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 12:53:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE7D483F14;
	Fri, 27 Mar 2026 13:53:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eTLbMbk2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33F5B83FA7; Fri, 27 Mar 2026 13:53:47 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCB0581E18
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 13:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSmf6mNa8sKi5v/oTFILi2Qae6BEgp4eo1yJUEvK5D4ke9w6UusD1HvID8vTT8OyAUnTcontmj/9IrC38CCP3ARVVuXlSpWX6B+Ox8g7F4qF6jLdsIFU52VnmGqErGWktLiPh3ITbOJb8Xag1vQw9GdSERtNv0pp+dkBrKPzAdOhPXZ3dP9zaNBguz5AgpmGLN1xwP6FrZh15GBfkN0LhevZHIreDrV2zf95teN4arJmj3y9ExKwop0IaZAKoCXpqOy7C/Qa6UAWF89Fte658HK/hWFk+dfUoAnJgy2ZpeotuPx5QXKUkNbm1giXKFaht76wrB94tUl6KryWVqmGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/B8i4BtZq80FOLKFu+gsg6MsXWsvZQtIqGtwThA1Rq0=;
 b=sjWueuSLGMrqYzb1MYIoWVTOuE4BaZphlrQlpVu6834nJT2F7q2mDVf7fhQlgC1aDUX6i2NWR+xfAZJ8uz+ddRHr8qr8GFjQyRAhoR1pgOJp7NcnEUUUK0WULFxg+PV4O+tkYWVEZaWF3lHx3IyE9JUYrMPo860BdTt7LCpnQiZI4zi6PPGrtvk6HmqTqAfHK9DxNPPGw4uwsrnXSMd02UpHBkmq5bnqROnMeNk8E1jMpX7efvT87JAWRO7ya27CP0UQcMTIxmCpEog2m2M4UoJB5ovd1F4KPfrq+VdR7RNIIfOOstvthCtNoFiwkjksInPo8H/Ky74i6NNagNeb1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B8i4BtZq80FOLKFu+gsg6MsXWsvZQtIqGtwThA1Rq0=;
 b=eTLbMbk21aU0AIr2+8LZ/4DogoUcC/4c6mshnba/C/1eeXftU/1rDRcbUSuhLfVXwdSdRGIMqu9ypyFtNzPngzT46jMvf72dj4qXGYfaWbUuEjSi5HJbPSOisg8YsTMkDxn9EfDxWGhL51onwQT+1THQxBWD6Y+uh373alVn7X0=
Received: from LV3P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::12)
 by PH7PR12MB9256.namprd12.prod.outlook.com (2603:10b6:510:2fe::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 27 Mar
 2026 12:53:39 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::8b) by LV3P220CA0011.outlook.office365.com
 (2603:10b6:408:234::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.24 via Frontend Transport; Fri,
 27 Mar 2026 12:53:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 12:53:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 07:53:38 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 05:53:37 -0700
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 27 Mar 2026 07:53:35 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Prasad Kummari
 <prasad.kummari@amd.com>, Senthil Nathan Thangaraj
 <senthilnathan.thangaraj@amd.com>, Naman Trivedi
 <naman.trivedimanojbhai@amd.com>
Subject: [PATCH 1/4] firmware: zynqmp: Add HW PCR API for Versal Gen 2
Date: Fri, 27 Mar 2026 18:22:55 +0530
Message-ID: <20260327125318.1037146-2-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260327125318.1037146-1-padmarao.begari@amd.com>
References: <20260327125318.1037146-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|PH7PR12MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: 77092c4a-e41c-42d9-504f-08de8bffddf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Ae4qOAw6EmhDzGKZtHtehYkeokWublZfwBlZlJLzvD3FXbjxIVWorhL1Od1BQ0SnhiOGQ7ft3cmD6HF+7AD+AlSidc9RU+SZEqgUzbqCHmdy26hoiySLRV8LnDguCyBgD343cMmJiokMHEm66kyQGFohHoVYHQ061ogUe1jpf48IcWsuikEeF8WLevYy3DePLL0NDJ/uBPPMSr4UejYPyz/CXwmIy49VhFlNzlOml0BF3Ze70OxqeIcFkPCU2tA0W2lDNXloloZuBgWsxsEqpOwu14VN3G0l3+xo2Q2QgsFkFyZ/d9XywKJ0ggMbKT5o3/eYYQ4iuEyiptCfIkJdBt+OHW2MdidTF1kgtnzxvGilZxQTZyiWXBo1xZ8hIQfbgodt16QGLygz50ctTIjt1glB+fVIajejQJTMQiLZgbQVrYLzXRGTIdBysiSEJtfCJ8+a4iKR8pWQJv6+vIv2yB0Y5oZL1zK4Xj9hXBcbBYvkSmImQoks1gmgz4gOWAN4z9Yytlj5fOMKQUmpoD/MffgJ4YyxrNuM5hSYc8GTh5T62PuKV1YkcFauDYb8NcUbx3yWgxYwqOcINKJUYQOjgooAr9UWyAbkxqc40nnmh/HBINbAB8RpSlag/pq002RRptoE/1AGZmeJxoVsag30f08IjNUdD3zN9FWPCg3AApIF1M35st4Cxwxm6fzRR3is0WY/Mgb8Nf8UrbadiB/nP+YiqN5LJJbudMKf7AkQE+sZSCv4pVOlG2dfri0N9bdE/1uzNdZkWfgKqB0Hd/besg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hv9nL1LUnkrzxH4zoi5oab7899yXi48ULVDJmmvzWpB+Kcg23BIrbBvHo5hvdAWU3T+/0B2uIDROJzvOncH0fwbH6yJDmH8OYR1XLyFk2xL+0OC8WMdNZg7GvbjyR/YSM+fDNT2AvCI6JPzBwOkCfnY73zncMZQihrGTHJqYfoNuDtFCSmCpJ8oE4e+p4TAZgt5FfQzzxSX5zmp29xD8P1QR/8Hq+kIBuwztxaWQkCAy72hmu91EZzarRHZ7KylVTKoyRxL+ER+G7s3TW6Vnoqj+sLHh45Nexx7mk1w6fQXScpibM3JpaxC8nrvL5FfPg/GCX+qUDN3HgwBnlKnF0JUrF/0g/7kuSP7wT8i+PBrInJJtaRyI/4cqvkjzRHy3dmGVvq5xTQ1hlSHTo4EBjYbMy2RYz7KOVE2o1L8aH8omr7gAHmdjc/i+5xCyUnng
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 12:53:38.9720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77092c4a-e41c-42d9-504f-08de8bffddf8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9256
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

Add three helper functions for PLM XilOCP PCR operations on AMD
Versal Gen 2, all routed via the existing xilinx_pm_request()
SMC PASS_THROUGH path:

  - zynqmp_pm_xilocp_is_feature_supported(): queries PLM for API
    availability using XOCP_API_FEATURES (fn 0)
  - zynqmp_pm_xilocp_extend_hwpcr(): extends a HW PCR with a 48-byte
    digest using XOCP_API_EXTEND_HWPCR (fn 1)
  - zynqmp_pm_xilocp_get_hwpcr(): reads HW PCR value(s) into a
    caller-supplied buffer using XOCP_API_GET_HWPCR (fn 2)

Also define the PLM_IPI_HDR() macro and XilOCP API ID constants in
zynqmp_firmware.h. PLM_IPI_HDR() takes an explicit module_id
parameter to encode the PLM module ID and function ID into the IPI
payload header word passed to xilinx_pm_request(), making it reusable
for other PLM modules.

The new functions are added into the existing CONFIG_ARCH_VERSAL2
guard block.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/firmware/firmware-zynqmp.c | 72 +++++++++++++++++++++++++++++-
 include/zynqmp_firmware.h          | 24 ++++++++++
 2 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index f8a9945c1da..2315d5932d1 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -3,7 +3,7 @@
  * Xilinx Zynq MPSoC Firmware driver
  *
  * Copyright (C) 2018-2019 Xilinx, Inc.
- * Copyright (C) 2022 - 2025, Advanced Micro Devices, Inc.
+ * Copyright (C) 2022 - 2026, Advanced Micro Devices, Inc.
  */
 
 #include <asm/arch/hardware.h>
@@ -197,6 +197,76 @@ int zynqmp_pm_ufs_cal_reg(u32 *value)
 	*value = readl(PMXC_EFUSE_CACHE_BASE_ADDRESS + PMXC_UFS_CAL_1_OFFSET);
 	return 0;
 }
+
+/**
+ * zynqmp_pm_xilocp_is_feature_supported() - Query PLM XilOCP for API support.
+ * @api_id: XilOCP API function ID to check (e.g. XOCP_API_EXTEND_HWPCR)
+ *
+ * Sends XOCP_API_FEATURES (0) to PLM XilOCP with @api_id as the query
+ * argument.  PLM returns success if that API is compiled-in and available.
+ *
+ * Return: 0 if supported, PLM error code if not supported or call failed.
+ */
+int zynqmp_pm_xilocp_is_feature_supported(u32 api_id)
+{
+	return xilinx_pm_request(PLM_IPI_HDR(1, XILOCP_MODULE_ID, XOCP_API_FEATURES),
+				 api_id, 0, 0, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_xilocp_extend_hwpcr() - Extend a Hardware PCR via PLM XilOCP.
+ * @pcr_num:   HW PCR index (0..7)
+ * @hash_addr: Physical address of the 48-byte hash buffer
+ *             (cache-flushed by caller)
+ * @size:      Buffer size in bytes (must be 48)
+ *
+ * Calls PLM XilOCP XOCP_API_EXTEND_HWPCR over the TF-A SMC PASS_THROUGH path.
+ *
+ * Return: 0 on success, PLM error code on failure.
+ */
+int zynqmp_pm_xilocp_extend_hwpcr(u32 pcr_num, u64 hash_addr, u32 size)
+{
+	int ret;
+
+	ret = xilinx_pm_request(PLM_IPI_HDR(4, XILOCP_MODULE_ID, XOCP_API_EXTEND_HWPCR),
+				pcr_num,
+				lower_32_bits(hash_addr),
+				upper_32_bits(hash_addr),
+				size, 0, 0, NULL);
+	if (ret)
+		printf("%s: HW PCR %u extend failed: %d\n",
+		       __func__, pcr_num, ret);
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_xilocp_get_hwpcr() - Read Hardware PCR value(s) via PLM XilOCP.
+ * @pcr_mask:  Bitmask of PCRs to read; bit N selects HW PCR N.
+ * @buf_addr:  Physical address of the output buffer (invalidated by caller)
+ * @buf_size:  Buffer size in bytes (48 * number of PCRs selected)
+ *
+ * Calls PLM XilOCP XOCP_API_GET_HWPCR over the TF-A SMC PASS_THROUGH path.
+ * PLM DMA-writes the PCR value(s) to buf_addr; caller must invalidate cache
+ * after this call before reading the buffer.
+ *
+ * Return: 0 on success, PLM error code on failure.
+ */
+int zynqmp_pm_xilocp_get_hwpcr(u32 pcr_mask, u64 buf_addr, u32 buf_size)
+{
+	int ret;
+
+	ret = xilinx_pm_request(PLM_IPI_HDR(4, XILOCP_MODULE_ID, XOCP_API_GET_HWPCR),
+				pcr_mask,
+				lower_32_bits(buf_addr),
+				upper_32_bits(buf_addr),
+				buf_size, 0, 0, NULL);
+	if (ret)
+		printf("%s: HW PCR mask 0x%x read failed: %d\n",
+		       __func__, pcr_mask, ret);
+
+	return ret;
+}
 #endif
 
 int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config, u32 value)
diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
index 05df49f292a..4482517a970 100644
--- a/include/zynqmp_firmware.h
+++ b/include/zynqmp_firmware.h
@@ -529,4 +529,28 @@ extern smc_call_handler_t __data smc_call_handler;
 
 #define PM_DEV_OSPI		(0x1822402aU)
 
+/* XilOCP HW PCR API - Versal Gen 2 only */
+#define XILOCP_MODULE_ID		13U
+
+/*
+ * IPI payload header word passed as api_id to xilinx_pm_request().
+ *   bits [31:16] = payload length (number of arguments after the header)
+ *   bits [15:8]  = PLM module ID
+ *   bits [7:0]   = API function ID
+ *
+ * smc_call_enhanced() extracts module_id from bits[15:8] and fn_id from
+ * bits[7:0]; the len field is not encoded in the SMC call itself.
+ */
+#define PLM_IPI_HDR(len, module_id, api_id) \
+	(((u32)(len) << 16U) | ((u32)(module_id) << 8U) | (u32)(api_id))
+
+/* XilOCP API function IDs */
+#define XOCP_API_FEATURES		0U
+#define XOCP_API_EXTEND_HWPCR		1U
+#define XOCP_API_GET_HWPCR		2U
+
+int zynqmp_pm_xilocp_is_feature_supported(u32 api_id);
+int zynqmp_pm_xilocp_extend_hwpcr(u32 pcr_num, u64 hash_addr, u32 size);
+int zynqmp_pm_xilocp_get_hwpcr(u32 pcr_mask, u64 buf_addr, u32 buf_size);
+
 #endif /* _ZYNQMP_FIRMWARE_H_ */
-- 
2.34.1

