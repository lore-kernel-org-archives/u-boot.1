Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A345C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 12:09:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00F49881E5;
	Fri, 22 Mar 2024 13:09:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0/9pRaOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0C1A881E5; Fri, 22 Mar 2024 13:09:32 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1C50881BC
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 13:09:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9e9t7BdmIh+4TE/pxuRcViDpLDNsl4uz2f3S+tn1S+oulY/wQ9zn2F07DSvL/MB25eQuswUwbdCryw0kMYcH/j8E8x3XUmupMphFPQX3EYCy+C51DgyiIfktiD9/A9PB1zEZV/cjh+2Muk2+18NC2UDe+X9kIDekgiEBjy+wWcNOSTQLBiaPF1ciY1pyu/PDymh1q4mk35lQdQdKs1aC4KMf+EwAaGuZiKeEGQ3jwfe8Oxj9Klzmne7mgKUjYb2DT173hO1nsQQSr4jkPLZaDb8Mo1c4ZeJB1oY73SCwdEyAFnx9+qRZBBRS48WcCJiY5K195IRz3M2IF6lXZfYKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXf66vOhua5DPGKW0VsozPdnBShhYLAFRXxqmyhByjw=;
 b=V3mNyzY0stVNoUvPP1Fpp906mVm3Zm9Wx22vGasy7UdwC+Yjr8U2z79g3TMEm7BCnxTgkpRtdAaWAV7rDf3KY8noKWucT2j9+VoC3MQS7keqRfCjSC571iFiN8U33ernXlZ83BGI/ED4CxfLlj52r7RJfVeoiIV04LCiwm13q4qLVidwvktA2ESa/dRjuviIJyMRL0DHI0zafrREdD2RtIArqjsR6vqrwgyNGpO/qg2DxOjO+FWaKbk73Py28l0876ES6mgCBzlyH6E3fIJn23Mh0bMdwggtpIfHyTcvQXP/7yfpkUtdGR+aF6u7q+XrwGmDpPfg5DcJW7NA8CSvvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXf66vOhua5DPGKW0VsozPdnBShhYLAFRXxqmyhByjw=;
 b=0/9pRaOvFGBUuJxoYC2Rmoz5lIjrXMnUzT0Qz75PjprJXM7Dtdj9d+siVN8LQ4K/fVFMOPgOOb+s0AgYzh0LT92l/LlxSEHADLyuU7ZNQon2HsBVGyDlWtoKHHRMRiH7co4c/eKt4vPnoBDFpqtbOlH7glxZ3mev2PthC+EaI0A=
Received: from SJ0PR03CA0118.namprd03.prod.outlook.com (2603:10b6:a03:333::33)
 by DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 12:09:26 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::4b) by SJ0PR03CA0118.outlook.office365.com
 (2603:10b6:a03:333::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Fri, 22 Mar 2024 12:09:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 12:09:25 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 22 Mar
 2024 07:09:23 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, <ilias.apalodimas@linaro.org>
CC: Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2 1/2] arm64: zynqmp: Generate desc when
 SPL_FS_LOAD_PAYLOAD_NAME is valid
Date: Fri, 22 Mar 2024 13:09:18 +0100
Message-ID: <4cec866f5fffa742258c65796371d7bfc6068915.1711109356.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1985; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=4AvVtSt7L4KSo6xe8S3ujiaRbRG1EB3ndhJZ+DjS0mc=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtS/Je+9nq71cCxyErgexnB6/XO/3TZ7PLSiS7ueO70N8
 Q2/+q2xI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEzkoQrD/NRNp9os0/lWPemO
 9ezSMuHkie9MY1jQcKjm95ud7XZqufrbFr2925Q2k/knAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|DM4PR12MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: a47f9cdd-d99b-41e4-ad9d-08dc4a68eadf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8A3bFbEpwXxG8lZ+FoWia7Tg5BWCbVWRcX+S6VWTwrw6aucvn+IRb7Y7aLCs+/u66I1RnxJ/s9Dn3Ox9SyIINgjDpAWNhF2tyF2FJIvR7xhxg20z/yAvBeEzR79GDDwlQeRg+bbr/cHggwboHUuudyXBbRg8XbgV63lVzcrfRBs+s0r8pmaUCdvToKABufYtTQqMOA3Z/GM18JUN1bc32v/dXnMa6rAr5bsvRk0JMXo6z+8mbC2FChxUTF1Ymtod0U8hTijIVjPUv4zp7etiVhVjlGsqjsCrwxhnY5ratWExSxUJXDBb5YEb04l1CQwi97HaeUm+96gWt1715TqqLpy6Y83+oy+nZBy+aR+J9mBaABkY/03S8n1isiN7wuMOBF5/1GIkojPne4l6YSoKrT4fw9NiodY3EwrNfbQPPmNOhmxTju5WftQiQE0JpoOsqawIjZpYU3WNNsTxvwBNdw86YQOd7o0Arbyafaj6cXiqP06c6vQAs4OEvy6e2EJGN3iSKIX+ZbQWNuON/as7DlbHbcYPhTk0ajRrzeKIcOjWU74yDu1AGRr46sEoaqUug9zen1QHPRzb3vDUwA3LURQIAIOMLtXqfb5lklTmdqVe1KNFFtJibsi/wXwCuqMD+44jazp5k0YfiRUAEH2ZXUWIgUkNBgVB/d2ddLHfauMl+MGrgtKjdB0+eHJCakPQYrocIdtFmvanUFkP3B5JKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 12:09:25.5630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a47f9cdd-d99b-41e4-ad9d-08dc4a68eadf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646
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

Generate description only when CONFIG_SPL_FS_LOAD_PAYLOAD_NAME is not
empty. When name is empty there is no reason to generate description for
it because it is not aligned with dfu rules.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- New patch is series coming from discussion at
https://lore.kernel.org/all/561f9d0ee96ebb6cd674042f269f280ab68fbbac.1708705118.git.michal.simek@amd.com/

 board/xilinx/zynqmp/zynqmp.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index ba49eb7be229..3844a9c9a8ff 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -661,8 +661,11 @@ void set_dfu_alt_info(char *interface, char *devstr)
 		len += snprintf(buf + len, DFU_ALT_BUF_LEN, ".bin fat %d 1",
 			       bootseq);
 #if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
-		len += snprintf(buf + len, DFU_ALT_BUF_LEN, ";%s fat %d 1",
-			       CONFIG_SPL_FS_LOAD_PAYLOAD_NAME, bootseq);
+		if (strlen(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME))
+			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
+					";%s fat %d 1",
+					CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
+					bootseq);
 #endif
 		break;
 	case QSPI_MODE_24BIT:
@@ -671,10 +674,12 @@ void set_dfu_alt_info(char *interface, char *devstr)
 			       "sf 0:0=boot.bin raw %x 0x1500000",
 			       multiboot * SZ_32K);
 #if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME) && defined(CONFIG_SYS_SPI_U_BOOT_OFFS)
-		len += snprintf(buf + len, DFU_ALT_BUF_LEN,
-			       ";%s raw 0x%x 0x500000",
-			       CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
-			       multiboot * SZ_32K + CONFIG_SYS_SPI_U_BOOT_OFFS);
+		if (strlen(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME))
+			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
+					";%s raw 0x%x 0x500000",
+					CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
+					multiboot * SZ_32K +
+					CONFIG_SYS_SPI_U_BOOT_OFFS);
 #endif
 		break;
 	default:
-- 
2.44.0

