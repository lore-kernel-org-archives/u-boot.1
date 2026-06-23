Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07950CDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 12:54:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABBB384A1A;
	Tue, 23 Jun 2026 14:54:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aqaZu95h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E24084A12; Tue, 23 Jun 2026 14:54:47 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A253384A04
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:54:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAXjzWdbWs88RU6LGAuzyZaWAmUNULJWpZwdRPTYWB3F6DcL/R4lo9A8RVGf6nZaDqz5EVJ0kpBy9tyoklSqhaFi7dez+jb7VgX66jNgC0ST1M0UUYSNbqBCqNwxY1svDh+z6M8i88qyunBFiBCJFTpTcIm2ctFd3mHqNd0vJ245XNoSb09uqZe20l7Q+1PG9UdWJsRuEbaqI84SFRVyO2nyDgMaiSET1yF7olmHapZ6ZnKAQtshnBUxW4TxcEc4FziCBQlkS1bN/cu6Jrxp+hJAXvtN94emqUQSA46cJKwxWDK87EWy4av70qOEYNOqNopAmHTUJsDLDuP+63XNGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lLMWL5egkm1ynMS8T4wENH2hMFV31mnRBMn/npAGDM=;
 b=SG1NNjJjGHksrABLDPrJrRxhZo1wYrBtN7KBLAvUrOKfLK6wPgljXGfD5ZwvMno/b9t2zPtEpR7KizgeE/Kp1ZriKKjvEJhtt6+yj8/Hc1kLjEYqU7zIW8/rzYGFzl1HrumU0u/9h9RlLZr+iILmBT3Fi0j8/obnMOFwuFXUvKPGR83fFjqD4T0j5qysDuE/VYAVXDLN5/nRrpAUU98gWMn7CjmdgHVww/bDnfANySQaEDg9NLZARgMKLiH4zet75U8rMRot7u79X1WxHdOqUVnvfilTXFHUT++VCJyK0jeQ+CF5KxVLWcuwHkJcfDtyBBn4MRyqZPl7Gdgx/ohhnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lLMWL5egkm1ynMS8T4wENH2hMFV31mnRBMn/npAGDM=;
 b=aqaZu95h/ETw9ThwKl/7XDLRm2sNKieyURHAI5oe9tyj88Qun9nXis5grIKiDLMiUGlFk/fLuzTh/M4ATWs2cVBpQbNKlCGVWe+eHwuhtkbDC231erjgh/sQn+1CyOnNmJYgI+YHOoxCpFpg2v3+J3A+XSTdDmk8IUqwmOgvf1U=
Received: from SN7PR04CA0213.namprd04.prod.outlook.com (2603:10b6:806:127::8)
 by PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 12:54:37 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::73) by SN7PR04CA0213.outlook.office365.com
 (2603:10b6:806:127::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 12:54:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 12:54:36 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:54:36 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:54:35 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 07:54:35 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Naman Trivedi <naman.trivedimanojbhai@amd.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Sean Anderson <sean.anderson@linux.dev>, "Senthil
 Nathan Thangaraj" <senthilnathan.thangaraj@amd.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 04/18] arm64: versal: Decouple multiboot register access from
 firmware
Date: Tue, 23 Jun 2026 14:53:29 +0200
Message-ID: <199ef6a1411c54f154fe4a43b5fef166b9927f7a.1782219202.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782219202.git.michal.simek@amd.com>
References: <cover.1782219202.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4059; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=LlOMXH1J1VtiJbP/JuaHbn2Oac6XSbacXPWw3buCNb4=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRZNb442HFrzUffGytzLh3be/JRydLfWra2TS+u/T585
 F6Uyf0FWzpKWRjEOBhkxRRZpjPpOKz5dm2p2PLIfJg5rEwgQxi4OAVgIn+DGBkuPDC9r9f/eg2b
 xmmmrhWqEb8tG6/vr421tHHd6SSz+ssehv/lP9wuvHM4uFymNlRg/hbhEyeyt15tCbEUDVzXO2d
 TpQ4rAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|PH8PR12MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ccf556-1cb1-4531-b9b9-08ded12694ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|22082099003|18002099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: o3dDVcc3VVTzsjvWUyrsqjcT9690KbxD9jVhyNBtQ8lkGpTJ7RBeH/wimpmMg7JurOcqXu6dgyQlMVUqpYnclsoWWrarAbHwtKONJgkE/Z6zMqX50XvFfBdo44mWUOWfgd3rKiD8Z/IelQZ3RmZuriD74SQhijQwXhPKcl5hawvGlKdUEKOGZasw/rQTu1/0PGtcQ5jB+Rol4572jLUxSr9SpE0A6G1zVMWK8LPdaSHBzLv/DCGU0t0M/TvXUbeic3jiAYY8Cqfx+EbAAYnLejeeHxSAlUNmmLV/suJFIG1rt5G0JzZuFTF+VieJQ7AoK5km9ArGAEVJyeBiWOng3y5bW9iW1C2UtEtcOgDY93dC2JY7gqF3h5KI8y1VDxQojRC1dmxgmwSDxUTq97ExVDmI6PRFOYa2KDutn+coyXw4Wvo/5ByruYR2UgkKEE3ryylfuAV1D4KY+SGfz+IPd7ZMEV32LKwKbRmCc9NYm1GJHIW7uSSfcTi8QiGwnA1o2LbHCFO7xbGKlsplaD5hx9bYaCibtebblGJMObptayLzsLPm2lHaa7isoooZEE48MclPUFtwYujtLUty3mmaeSFMQZIBQyg4I0jJ0qaouY9Wi01iqNH7l+z5ZVAf9ztWopXzsiscG3a/P46zfpRDMY2bI/+AStYG8B5NZNaoYO1tItRyMorAx8s6sO+2lCt7s4txnembCqsTrllVlzCJgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FUMRyVYBQAk2Zc19KW5FkLC2uB68nnMvQ1lpeaIyV/YBhYkUFVgvwUEEviONNfP8tK/DRmm5t8duy3IHLUUCxXgSA7SG0bLU9p7pXJONMmDh4y7KOf1nbLT68a3r9YWuEG7fqdg7WrG2TUHpB8PrcXBPh5WWjFdl++HFFh8RpUTdmYuunWstsJti+d3pdALDC+HKpql0oBt80MSFsJIZPyVsvFqvnVIHZf45zq8KLrv1IMXpCMOjkrSS7dSOThg2hblXL/DZyplyz6kROSWWsVfg9tNPY3setXmeiz0M2dgnSTl56E7Z7vk0VNbezXK0MHwjGyUQiD3zdoaFN6Xrja6aq5DF7mxIkPGMdtjofT62asIlP4lHFD/cp70gdylvdOcoMh5gvgEId5/s9NzqjyPp8Bjs2izxxgh0GyOKGG7XyJTVvEsxrUr+JfQTumbE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:54:36.9953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ccf556-1cb1-4531-b9b9-08ded12694ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301
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

versal_multi_boot() in board code selected between the firmware call
zynqmp_pm_get_pmc_multi_boot_reg() and a direct readl() based on an
IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE) check. Generic board code should not
carry firmware-specific ifdefs, and this becomes harder to maintain once
SCMI introduces yet another access method.

Introduce an overridable accessor versal_pmc_multi_boot(). The weak
default lives in arch/arm/mach-versal and performs the plain MMIO read
(used at EL3 and when no firmware is present). When CONFIG_ZYNQMP_FIRMWARE
is enabled, firmware-zynqmp.c provides a strong definition that issues the
firmware call, falling back to the direct read at EL3 where the SMC path
to firmware is unavailable. The shared MMIO read is factored into
versal_multi_boot_reg() so the firmware override does not duplicate it.

versal_multi_boot() keeps the generic JTAG/QEMU workaround and simply
calls the accessor, so board code no longer references the firmware
interface for the multiboot register. The firmware-vs-MMIO decision is
selected at link time, and adding SCMI later only requires a third strong
definition with no board-code changes.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-versal/cpu.c                    | 10 ++++++++++
 arch/arm/mach-versal/include/mach/sys_proto.h |  5 +++++
 board/xilinx/versal/board.c                   |  8 +-------
 drivers/firmware/firmware-zynqmp.c            | 11 +++++++++++
 4 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-versal/cpu.c b/arch/arm/mach-versal/cpu.c
index 62f8a87ce321..1ef4e3435c22 100644
--- a/arch/arm/mach-versal/cpu.c
+++ b/arch/arm/mach-versal/cpu.c
@@ -110,6 +110,16 @@ int arm_reserve_mmu(void)
 }
 #endif
 
+u32 versal_multi_boot_reg(void)
+{
+	return readl(PMC_MULTI_BOOT_REG) & PMC_MULTI_BOOT_MASK;
+}
+
+u32 __weak versal_pmc_multi_boot(void)
+{
+	return versal_multi_boot_reg();
+}
+
 U_BOOT_DRVINFO(soc_xilinx_versal) = {
 	.name = "soc_xilinx_versal",
 };
diff --git a/arch/arm/mach-versal/include/mach/sys_proto.h b/arch/arm/mach-versal/include/mach/sys_proto.h
index b53e616e47be..d7ab25496583 100644
--- a/arch/arm/mach-versal/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal/include/mach/sys_proto.h
@@ -17,4 +17,9 @@ void initialize_tcm(enum tcm_mode mode);
 void tcm_init(enum tcm_mode mode);
 void mem_map_fill(void);
 
+/* Overridable PMC multiboot accessor: weak MMIO default, firmware override */
+u32 versal_pmc_multi_boot(void);
+/* Direct MMIO read of the multiboot register (EL3 / no-firmware path) */
+u32 versal_multi_boot_reg(void);
+
 #endif /* _ASM_ARCH_SYS_PROTO_H */
diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index 8666f2ceff4e..110490b96729 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -62,18 +62,12 @@ static u8 versal_get_bootmode(void)
 static u32 versal_multi_boot(void)
 {
 	u8 bootmode = versal_get_bootmode();
-	u32 reg = 0;
 
 	/* Mostly workaround for QEMU CI pipeline */
 	if (bootmode == JTAG_MODE)
 		return 0;
 
-	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE) && current_el() != 3)
-		reg = zynqmp_pm_get_pmc_multi_boot_reg();
-	else
-		reg = readl(PMC_MULTI_BOOT_REG);
-
-	return reg & PMC_MULTI_BOOT_MASK;
+	return versal_pmc_multi_boot();
 }
 
 int board_init(void)
diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index 70d205ff3ef9..c8943b8d23a3 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -328,6 +328,17 @@ u32 zynqmp_pm_get_pmc_multi_boot_reg(void)
 }
 #endif
 
+#if defined(CONFIG_ARCH_VERSAL)
+u32 versal_pmc_multi_boot(void)
+{
+	/* At EL3 the SMC path to firmware is unavailable, read directly */
+	if (current_el() == 3)
+		return versal_multi_boot_reg();
+
+	return zynqmp_pm_get_pmc_multi_boot_reg() & PMC_MULTI_BOOT_MASK;
+}
+#endif
+
 #if defined(CONFIG_ARCH_VERSAL2)
 u32 versal2_pmc_multi_boot(void)
 {
-- 
2.43.0

