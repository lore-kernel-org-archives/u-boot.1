Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEE5C54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 12:09:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 695A0881C2;
	Fri, 22 Mar 2024 13:09:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y0IRUBR0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 103418820D; Fri, 22 Mar 2024 13:09:35 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E28AA881C2
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 13:09:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReMCL26hsXa17iJzcHVKHY3eP3IeYeo8YLGL0ZAX2HXgIQt0rHS7cR5HPEnXVcUIkP4nnP5cca0HD4D6G9mXpyo4nIRts8BHN0xvqUlIrnGZL9hieTCI3mw4MVPK+EkM4sF1bABxYM7akpjXj0FvWO7W1MgE7+/uTGkuwe20VXr3Meh3k7DhmU7Gfzl6yW6sHRa1eU2nd8mWmz8kIdaH1Yt6cTCulb9mLXfyj57ADYUbcq+eVXZbeL3OlFk5Is3L2Pt/3ruxhNsztskRvT7qxKbOS8a6GHjIzd+Z7Dxl3lrJfUhKkvGaQkmbl/QL/iJNKLnT1n4ujLbBspI3dm+2EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujvTPHObQcLrqVIHkwvYUfN+kU8d5AbyJnBGuoHpCXA=;
 b=UzKq6x8r6HVOEsIGS8neYnNBPI1MFCoMQ2FYI27uzx/+eZflW5WxqfeeA4XZ/mfNf/NDF3OfotMTKUczN/Ti+BPvIIYSO8rgZdpohmMFkEnJ5rJvqe/QpcQaS9BbGx7MMHmV4E7sejygK/751wwlrSqFBo3XGD+3eAEbTgL+QtWDTeci35QyJD9CvyHFvT70FXAf7/3re8u8jbknxi7l24SIoKXfo6L/o0EqYWAtth4dkQ4H8qmmlr9sFJ20dAOkmC+aY0HlMZ7oPFxdqjTh8+9ahT/mw3KKt39/0gW0AvRPo79yaMUirrWG+36A13SFKZJySxIamY7y8V9S5u/prw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujvTPHObQcLrqVIHkwvYUfN+kU8d5AbyJnBGuoHpCXA=;
 b=y0IRUBR00+xu2hf12zHLlSy3DcDDDLnMwU+D+nC91aiuAtJcIbFZBLMOHKfnEPyTx6P/2a8jpi2+b6L0CQHrptgF60j8GuVxTXlpaQuz+GLLM8hpAKJv7GaevysY9IVq4LT4FR0cdqdD1EUltwgleeL4vjRgvAanTWSMlVWVzWE=
Received: from SJ0PR13CA0131.namprd13.prod.outlook.com (2603:10b6:a03:2c6::16)
 by PH8PR12MB7326.namprd12.prod.outlook.com (2603:10b6:510:216::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Fri, 22 Mar
 2024 12:09:29 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::e0) by SJ0PR13CA0131.outlook.office365.com
 (2603:10b6:a03:2c6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11 via Frontend
 Transport; Fri, 22 Mar 2024 12:09:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 12:09:29 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 22 Mar
 2024 07:09:27 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, <ilias.apalodimas@linaro.org>
CC: Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2 2/2] arm64: zynqmp: Add MTD partition handling for
 dfu_alt_info generation
Date: Fri, 22 Mar 2024 13:09:19 +0100
Message-ID: <db58d9f3fc142004d833bb115bfba0e26d660b66.1711109356.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <4cec866f5fffa742258c65796371d7bfc6068915.1711109356.git.michal.simek@amd.com>
References: <4cec866f5fffa742258c65796371d7bfc6068915.1711109356.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2773; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=46xLpuzfuSCuRgAxPthvYKGnD/DUQDO48WPn7PSPaA0=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtS/JR/Mai9r+Hvq9USl/F1ziGXfq2qRFJGVzX9tn4ZeP
 7F9fsXzjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCROg+G+bmTDqgsfd69rMxz
 WVlR8JobjZvOX2CY72a/fs2uLpNH97YGsTiKu9uLJU8sBQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|PH8PR12MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d746e7e-0fb3-4e49-d74f-08dc4a68ecef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mxkOo2UWSKPrlND69JoZ4GbIqB6pVLPPTnt7/WemEI/1OU1gGHAysUR9jFNm48DwgzWESbSPQo5QVn0X92gnt0wHLwKaqoZW02h4JTKKtU07E5woQqaaMtU33E2FesmJVQ1qtflv33bCJqyckbBcyXFpWlL/wI9mET8o5Zk+t+jTIc4Bx8Dd1m9QvanHkxpYMUuwgPDKMfgUUJnE4SQ4wCL1W1s0/mXYBXUaqMwXgwxAvrv66ebZKgxWR4vurKYAD0jxTzYZ6M5ViU8U6wW8Itt2p+ibwmRYAMA6fBtlyq0O1ZG9E7apg3dNn2hJWe3ELwj06vuOztO+3XMOsmb61vYYLNM9sjZhST9haJ5RIn5vnf4VpII8OvbbI7tMIMBU+logRYEwQt1QWD5874LZUqn1djA4DkMEaa/Tlw4B1FOoH+a7Oth3lxQtB3W7DzaS3MzQ6Wq+VZS8eEp1+2hoEGG0djkgHP/Qjc9i5U5JAIJRCVx9+B/b8H4cTqdDH2DmTQaVGwzSSSC8zz5eMXrzDAQXtsUJcLc646jHdaIpBAY1+VUCLHQv4WItatQ0bNPvXjZlwTAFG5hBhM42uyFndJvsmJq0eYp5zgf2SdUYdM/C/tgswv0Cm71VL/5CE3dyxQamWmR2Q6DqIuIhIZRsNjtDP+TjEpyOPNf3XvOHuyAHnEeQCatWlmGrViht/R4rm2BX4p+xy6fof3E3bNv6KupdzjDBG7tPlouaoTU0d6awwlPLpTIBdLkcOiU4ozF7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 12:09:29.0244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d746e7e-0fb3-4e49-d74f-08dc4a68ecef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7326
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

Generate dfu_alt_info generation based on information from MTD partitions.
mtd_found_part() is trying to identify MTD partition which code is running
from. If partitions are not defined and location is not found it is going
to previous behavior.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Update logic based on 1/2 patch

 board/xilinx/zynqmp/zynqmp.c | 55 ++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index 3844a9c9a8ff..2522024b4082 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -626,6 +626,31 @@ enum env_location env_get_location(enum env_operation op, int prio)
 
 #define DFU_ALT_BUF_LEN		SZ_1K
 
+static void mtd_found_part(u32 *base, u32 *size)
+{
+	struct mtd_info *part, *mtd;
+
+	mtd_probe_devices();
+
+	mtd = get_mtd_device_nm("nor0");
+	if (!IS_ERR_OR_NULL(mtd)) {
+		list_for_each_entry(part, &mtd->partitions, node) {
+			debug("0x%012llx-0x%012llx : \"%s\"\n",
+			      part->offset, part->offset + part->size,
+			      part->name);
+
+			if (*base >= part->offset &&
+			    *base < part->offset + part->size) {
+				debug("Found my partition: %d/%s\n",
+				      part->index, part->name);
+				*base = part->offset;
+				*size = part->size;
+				break;
+			}
+		}
+	}
+}
+
 void set_dfu_alt_info(char *interface, char *devstr)
 {
 	int multiboot, bootseq = 0, len = 0;
@@ -670,17 +695,29 @@ void set_dfu_alt_info(char *interface, char *devstr)
 		break;
 	case QSPI_MODE_24BIT:
 	case QSPI_MODE_32BIT:
-		len += snprintf(buf + len, DFU_ALT_BUF_LEN,
-			       "sf 0:0=boot.bin raw %x 0x1500000",
-			       multiboot * SZ_32K);
-#if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME) && defined(CONFIG_SYS_SPI_U_BOOT_OFFS)
-		if (strlen(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME))
+		{
+			u32 base = multiboot * SZ_32K;
+			u32 size = 0x1500000;
+			u32 limit = size;
+
+			mtd_found_part(&base, &limit);
+
+#if defined(CONFIG_SYS_SPI_U_BOOT_OFFS)
+			size = limit;
+			limit = CONFIG_SYS_SPI_U_BOOT_OFFS;
+#endif
+
 			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
-					";%s raw 0x%x 0x500000",
-					CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
-					multiboot * SZ_32K +
-					CONFIG_SYS_SPI_U_BOOT_OFFS);
+					"sf 0:0=boot.bin raw 0x%x 0x%x",
+					base, limit);
+#if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME) && defined(CONFIG_SYS_SPI_U_BOOT_OFFS)
+			if (strlen(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME))
+				len += snprintf(buf + len, DFU_ALT_BUF_LEN,
+						";%s raw 0x%x 0x%x",
+						CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
+						base + limit, size - limit);
 #endif
+		}
 		break;
 	default:
 		return;
-- 
2.44.0

