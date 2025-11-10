Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1258CCCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 15:24:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D38A83A57;
	Mon, 10 Nov 2025 16:24:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Von/sTgE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55C9883A57; Mon, 10 Nov 2025 16:24:56 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44B0583A03
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 16:24:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3LS/EX7yyRINGBoQ8LTy++7zuZgKmdIf9h8kzUE/ZwVADrkyDUQTpQ/uzZs9Hc2UGYILI9eIHJFqtG7j9fUeQcuHjQHLtLlxTINyKKESsHmaPKUpQTPsEeMKxU+BC4y6f6dgYC8J04SOlsw2JU6bPAdAor99OhsGvCtMkDgb5NQJw+W6IDrmjvwpF1981TuNBISBPnk1vzVYgHpCHdmQioBAhAlRmaEnmgZ1bHR/qyjpayL8OPzmn1jkBaVBpFcqfcoWiBoPsaGFeP/GMI5aa7wyEqe1LEacSOk7bh4KxiREyG337Kcx+3wtGGFND23I+SV2Pj31+IdohFV6bWz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ociwRP3RETSZawtRwbqItk5f6tWGsj0u14ZqXN+hl3U=;
 b=G3NuGQN/1BFzrek2mD5mQ4EgVQA+RTnfWbuEtof73P7Yj1Pr+TP/9HebvDF53Pt7w1ZgbYUI5D+1o5RJhi//94q0AaZ6VyKbpkUU70nrrGk5iPrmI+Ce7z6ZV2HLzcTR26G4e3+vSM2RNG3zBR01wSxZMimsjOKgprGrRuzxiQrUk2A0K1HUI1qbJMf5LqEWVUlxyYIglS0VThi2Kp3C24pqc02fasLrTGxvxTJm0HDt1Rz7tnNUxLMDaXmi33i5xOSBOnLSp5cwHgo1i83aBB0fPB1IrSKpJSf0yN/C9PBCVSK5RriFK5f9yFUlDM7T2MD6/vkxZ1ivS/KT4Isnvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ociwRP3RETSZawtRwbqItk5f6tWGsj0u14ZqXN+hl3U=;
 b=Von/sTgEzu5Y5DamkXEBDg5ezpMQoTbfoXOD78vdzAfGshNYnKko3EawB1Za/de6K8OwfRacrlxcTAvTC8k5eiggA5joYPXKiquoHlLuDH8FMY0uWxUz+I5ybYhEkTW8Cm6T4++6Bte3QxVo1QurHl47/0nHI4V0VTE+M2IVmHA=
Received: from BN0PR02CA0018.namprd02.prod.outlook.com (2603:10b6:408:e4::23)
 by DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Mon, 10 Nov 2025 15:24:49 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:e4:cafe::c3) by BN0PR02CA0018.outlook.office365.com
 (2603:10b6:408:e4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 15:24:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Mon, 10 Nov 2025 15:24:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 10 Nov
 2025 07:24:24 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Nov
 2025 09:24:22 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 10 Nov 2025 07:24:22 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Naman Trivedi <naman.trivedimanojbhai@amd.com>, Prasad Kummari
 <prasad.kummari@amd.com>, Senthil Nathan Thangaraj
 <senthilnathan.thangaraj@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH 1/2] firmware: xilinx: Add support for enhancement SMC format
Date: Mon, 10 Nov 2025 16:24:12 +0100
Message-ID: <16bdee56fd75113c6d531bae7a8a34900b10280d.1762788250.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2981; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=A20NjSgJa05Hf/3i05U9PpB4L0Wk9f0sR4obNCiXQME=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQKMc/Tb/jXJJ8QeFmK3cO97uhGAXnFbVr70+Q/ueg+v
 OIQ8Kmgo5SFQYyDQVZMkWU6k47Dmm/Xlootj8yHmcPKBDKEgYtTACZy04yR4TCP8BZr5jWfjfnn
 Ghlt6FdhzfVWePjhh+Ns/X8/dggzWjD8U1rco9Kfuujh9jzTAAZToYvlRgenfHgx796uyz1Be61
 t2QA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|DM4PR12MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: 449c9b5f-5a94-4d88-660a-08de206d49d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DUy/rUXYNQYpcyFpuoHneqo/G1uGDIlXbp2suIFS3M0P5BzNzJd3VK3irh8O?=
 =?us-ascii?Q?DuYt4cQIIWpL25Ffj1ag6pJFaDE0vD1Wom3BMGjud/o+2daFvhqJKPhZjwC9?=
 =?us-ascii?Q?urXjekfOXLVInXAbkVWO9SbxZG4RBJ2qk2fmDhcMhR296I7yL1EcprOSOxi/?=
 =?us-ascii?Q?carwDu+A6lgfbrg+jXNavB2dJR0U84RmivA5cV3DA/4DgN3MD1Utf2yILqT5?=
 =?us-ascii?Q?Jpd7+pnH/SIPyoBbfk1RGwrJujuZ3CuJmqmaniMQhaffTBbSfnWz6GJUFo9r?=
 =?us-ascii?Q?fcO0TDqQJeAL9Ac28tKZ0rw6SUcZaUlgYDc0wuUw8v92/rkxs3D01+SwLqF3?=
 =?us-ascii?Q?hMFu8T3ZI5/bhv66soyGGkyxRjKo8bTNTVwPQmK/T4DlYh85GZ1FemRp2l7q?=
 =?us-ascii?Q?40ZJ+YhBxdWAMw2FdSNq+DuOv+8Qc3iiVMPPZRZq9/+UfcoUfn6JgHX7xLrY?=
 =?us-ascii?Q?HeaSUYZy77IAZTzF2A2jcDc+qTiK5ZDM5sxC9oG/q9WUys1kE3XGRnrGP9ci?=
 =?us-ascii?Q?sLfy1d17qokMKx9BTd6Bul/vUsWEZ20nYM3q9lJARSIIND/4k0lqwZ1Qoo4V?=
 =?us-ascii?Q?CuozrNmTgE6G7BoKLxFsfgB24rKl1/HT/6FfFjYf+TCu8jRqXAbJyvdmCWco?=
 =?us-ascii?Q?eX7c505uLTSNETeA93ZSwm2wQgowXa9bnAieZQkrm9TTJvpsFfbEun/kh2it?=
 =?us-ascii?Q?xRf0X15BdTEhxgZrC1JbkiDPFQTxOKQ+f3FRo4sdL1xoZaBbvsIgmawrBOdP?=
 =?us-ascii?Q?tjXDazFvTU2nxC3hevRpCyfCTVI53AKO10mtSd+NwFS57gcHqcaELTLfc0vY?=
 =?us-ascii?Q?qP8hTlBXfpP+fSz4sssRiSywkmLv/ecb68OjngbeA4s0tr+1c5yeu92oioKA?=
 =?us-ascii?Q?iPQISMXeooVW8fFzNkaV3HqoLNCmP+fNS+DB8h2JMgqByP6AAhZhU/LjyBaG?=
 =?us-ascii?Q?XWYxG5VkYbfrySeCJEQqmdYcXvXqSorfc2yO9vonVgU9COMjSqNlEKlZwyLv?=
 =?us-ascii?Q?Ok6uNB+lvzycjDibP4WXEXZ6e3zOYm5KjhK14IdkOkNtU3zHVVMjukMht1Vb?=
 =?us-ascii?Q?HPMwUHr7xYyh3KC2MeVVG6NOPEHaSChkFItB0fC39YiM5WIlsUV+8S8ou526?=
 =?us-ascii?Q?ox1JbWvHB8pZzkO8jm/b3nYzGheGc7bwQAQ9UqXdSOCO3k2HrOS7db5j31dp?=
 =?us-ascii?Q?PuUg7XW92DkIuyfFUYJ02N+05fXX+x8U2PhUWzPT2CphE4izvxxdPoFMNsXP?=
 =?us-ascii?Q?i4G8Q6wE9mKS/c2qGRV+tdnKRpfmY1C+ukB6N0EjOhALNLuU6yp/Ob+iL52c?=
 =?us-ascii?Q?oNxTBntBDxgl8kL2AwrieRjMaFp7dyW0pkScLdwux5DQa/tjBA4OG+53mU3v?=
 =?us-ascii?Q?uCGpo4VRpeOBvchaNrYTy+BJneGANe4rIQL2n66xQoOrhYGVDq05NQDcR81D?=
 =?us-ascii?Q?+MMjZeVJlrHXtLSlEG5ENZJzMRMfc6tBGhLZglBeFcV6VxFTco9510pffJfi?=
 =?us-ascii?Q?V0idE2qFgDRi/7JNLDoXP+KstumFCHw+UmKA6Tshm2gBswxcEK1VDjsH0b7f?=
 =?us-ascii?Q?aCC4t7JyxKfKrDICPP4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:24:49.5076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 449c9b5f-5a94-4d88-660a-08de206d49d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6012
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

Versal Gen 2 is using different SMC format that's why firmware and clock
drivers needs to be align with it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/firmware/firmware-zynqmp.c | 34 ++++++++++++++++++++++++++++++
 include/zynqmp_firmware.h          |  6 ++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index 3742467caee1..2ef499bf4084 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -16,6 +16,7 @@
 #include <zynqmp_firmware.h>
 #include <asm/cache.h>
 #include <asm/ptrace.h>
+#include <linux/bitfield.h>
 
 #if defined(CONFIG_ZYNQMP_IPI)
 #include <mailbox.h>
@@ -451,6 +452,38 @@ static int smc_call_legacy(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
 	return (ret_payload) ? ret_payload[0] : 0;
 }
 
+static int smc_call_enhanced(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
+			     u32 arg3, u32 arg4, u32 arg5, u32 *ret_payload)
+{
+	struct pt_regs regs;
+	u32 module_id = FIELD_GET(PLM_MODULE_ID_MASK, api_id);
+
+	if (module_id == 0)
+		module_id = PM_MODULE_ID;
+
+	regs.regs[0] = PM_SIP_SVC | PASS_THROUGH_FW_CMD_ID;
+	regs.regs[1] = ((u64)arg0 << 32U) |
+			FIELD_PREP(PLM_MODULE_ID_MASK, module_id) |
+			(api_id & API_ID_MASK);
+	regs.regs[2] = arg1 | ((u64)arg2 << 32);
+	regs.regs[3] = arg3 | ((u64)arg4 << 32);
+	regs.regs[4] = arg5;
+
+	smc_call(&regs);
+
+	if (ret_payload) {
+		ret_payload[0] = regs.regs[0];
+		ret_payload[1] = upper_32_bits(regs.regs[0]);
+		ret_payload[2] = (u32)regs.regs[1];
+		ret_payload[3] = upper_32_bits(regs.regs[1]);
+		ret_payload[4] = (u32)regs.regs[2];
+		ret_payload[5] = upper_32_bits((u32)regs.regs[2]);
+		ret_payload[6] = (u32)regs.regs[3];
+	}
+
+	return regs.regs[0];
+}
+
 int __maybe_unused xilinx_pm_request(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
 				     u32 arg3, u32 arg4, u32 arg5, u32 *ret_payload)
 {
@@ -494,6 +527,7 @@ static const struct udevice_id zynqmp_firmware_ids[] = {
 	{ .compatible = "xlnx,zynqmp-firmware", .data = (ulong)smc_call_legacy },
 	{ .compatible = "xlnx,versal-firmware", .data = (ulong)smc_call_legacy},
 	{ .compatible = "xlnx,versal-net-firmware", .data = (ulong)smc_call_legacy },
+	{ .compatible = "xlnx,versal2-firmware", .data = (ulong)smc_call_enhanced},
 	{ }
 };
 
diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
index 7f93241b1932..72f6459b91c8 100644
--- a/include/zynqmp_firmware.h
+++ b/include/zynqmp_firmware.h
@@ -521,4 +521,10 @@ typedef int (*smc_call_handler_t)(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
 
 extern smc_call_handler_t __data smc_call_handler;
 
+#define PM_MODULE_ID		2
+
+#define PASS_THROUGH_FW_CMD_ID	GENMASK(11, 0)
+#define PLM_MODULE_ID_MASK	GENMASK(15, 8)
+#define API_ID_MASK		GENMASK(7, 0)
+
 #endif /* _ZYNQMP_FIRMWARE_H_ */
-- 
2.43.0

base-commit: f109829793900e57558d98ed22caf80c1a72b232
