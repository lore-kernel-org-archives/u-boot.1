Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFDFCDD1AE
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 14:00:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB98D89123;
	Fri, 27 Sep 2024 15:59:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p4A+BUwm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B9828911E; Fri, 27 Sep 2024 15:59:50 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::608])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50A7788F32
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 15:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRdAKmN+/oBCl5w+DYHvL5cylAOOzHJhy0LzXo0fQIUfuyfsI3S+V5edcMP3ujzhBjZ3/2phhLTwOsZV8Ppjc4+dAK9CZlriSMA/NOBOT1BxtCaFTHtrtmvFGr9Jjj8niQB5VY07pjZrRTyG1YRD2W3A7CQNcrmATgTwuYgjiHtu0rk4jtzkIH/I3CAywwjd+lXF3KOMK6/zQDTwbDZEPAyvpqebD74RR6O4FSVbyKd2mCRe41qWWn8HHexztKD2DnT6a2sc9nFWCk5mui52+ulbY899sjaQXUaH7ijh/apmigtfJY/x48MjAL0lJUhHnRtCtpzMN3mS00xpshIXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/B/P0Hfb+8J2p8Qrd12bDTmpZPrrdDBAfW4bQeKSp1I=;
 b=QYif0iy6s9Z2WLh9UBGf1DpW1MqtVt69eH0s5uQjNXW0MXfARUtfY25c7NfXi8KaB3azNtOzhfXdhbFy0A8b/clSV3VXFrZa+sZqMhBRP4Y2wETwpY8DDBsiJyX2XL/qpx6j8cCTwKBBdj/FOcRxdTYIVkMsp3VWBVlGKc4+RHOGp/i1DS0AaUkfggflw8io4EpGVaKScEKwO4r/E6sQLratdEz8gXajPkDhG4c10lzrOJdO6JurUvkTaYR1InVLeHuDl7QZZ0YMUasWkksgtETlULFMbifISzWwzPnOVcsaOLRt6SpIuMehz3ARG37VylLaZdOBPGY+Lu8RfEKzfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B/P0Hfb+8J2p8Qrd12bDTmpZPrrdDBAfW4bQeKSp1I=;
 b=p4A+BUwmYSW5KvwH0TGCjOfh0o1YtU2CCM300gM/OnCwQOas7xesb46toQlublv1/fiR1EmFkjXxaGfsQOAoxdIohsQQ4wDd8qfT1yH9vlhHWumTK5tGst0uy3VwXxrxBMyURNg4YjDDeX44zNfIQSOpVGoS80ZqG9gv6Cll8Vc=
Received: from CH3P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::20)
 by DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Fri, 27 Sep
 2024 13:59:40 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::5b) by CH3P221CA0025.outlook.office365.com
 (2603:10b6:610:1e7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Fri, 27 Sep 2024 13:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 13:59:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 08:59:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 08:59:37 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 08:59:35 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <git-dev@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <Prasad.Kummari@amd.com>
Subject: [PATCH 1/2] arm64: zynqmp: Print an error for split to lock mode
 switch
Date: Fri, 27 Sep 2024 19:29:25 +0530
Message-ID: <20240927135926.438450-2-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240927135926.438450-1-padmarao.begari@amd.com>
References: <20240927135926.438450-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|DS0PR12MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7109eb-9222-4845-6b6a-08dcdefca138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J51gUl/8t0dRJhNDAdUAYp0iYw/4UFzLIqEt+bNprHSofyqG9e0+OzH9pKuQ?=
 =?us-ascii?Q?3vqkClXlQh2MavE5KeQblozeP8TfjGYHWHH12CS2+em+O8JD93/MPl6+Motq?=
 =?us-ascii?Q?zSLkFf9SMCM2mka2+DU6BufGgcgOfNGwmmw63HNW+SE43NiBZRB6Yv7A90Ce?=
 =?us-ascii?Q?b6kg0SKFBYgk0O3OpNGr6bxIYk9X7RLX/Kw/A3PlsKOprgYqU8pPhs5lkA9F?=
 =?us-ascii?Q?lkGW7PNnCnBlbhTPEsWQ3FPsG6K0reJQE9NNx/xORKbAs9geiOF6w+iVq4k+?=
 =?us-ascii?Q?8MYzSPaSNnrYg7GYUvVqV4vdwYZD1OaGHg1kvLV6cw+RXVygdQJN3KSq4f6M?=
 =?us-ascii?Q?kWDA1LzQb2YhDnjrm9ZQW+JweaA6q7DGbMvyWfEoAdgvxVQIEIF+bWsSiB2I?=
 =?us-ascii?Q?ro07jqiF14g3u+DIC2dJFYjKaeTU48LLE5RhIgacIw9rnBXrPbEKEPHW5U7G?=
 =?us-ascii?Q?6MA3140//MBlOPxnbLNxGPuhT7NIcwWixwYtnWeAPXCXJi08M3g67kctk1UH?=
 =?us-ascii?Q?Utugi6UasYMiTe+ThwZzim+zFk/8m3uHn14Epc/BMsnnkl8zb6+/AhKBKUHa?=
 =?us-ascii?Q?22x8p9CxdVLCkD6DuCKV75XEfTUmGfFTa1pkNB3owu/qVpCzYac8MV0dBRkL?=
 =?us-ascii?Q?/uojlQRbwOyykZ6kuUwyNAaKjovmMOtYnfgMXB/Y/gpmDiXtIa7lfk51PsUM?=
 =?us-ascii?Q?xY4xFDmr6RxFd7kNgBoJEi09o+65ZiFaEET+hKXxdXnQV/riCB5F3q7p3wU5?=
 =?us-ascii?Q?bcxMUnHZ5h0EkvE1A2hnd/+emCXEmRPk7HvOIuGq58lHhA6bCpkk0zXdMyGZ?=
 =?us-ascii?Q?M01vhYiOyjTZOgW0e+VchIuJpEr13SV8FNsOT1NP1x9ee1PTy7rp07PBSUSs?=
 =?us-ascii?Q?u0wVp3xwbOFPyVRYpIS6YpD+ocsRzCOxiQY0qv2X0o0FUYHuVaL4xpt2Wvno?=
 =?us-ascii?Q?9ArfxvVFRLNxrN51qDJULEaeJWGKPXlbTCx7uwjMjDgSoJFxlCN7YEBmV6NS?=
 =?us-ascii?Q?FheCjkSD2Ao07gsesp/xyO5mGK1Orh3tH7GY9kpB75zF/zaKnkrnPh14crJy?=
 =?us-ascii?Q?hu1bHQ+wxeyZWWvVOnTmzvRZ5GojoqDmAyNJVpVbefzoBBH9EsfuQ3o7fH9t?=
 =?us-ascii?Q?WWUvmKKwD3t09slgykXxBlDs5Gts621rxvW2hDu32R9NAW2zo9bLo0fVpIEH?=
 =?us-ascii?Q?QONjMv1Y1Mecm6Zvnq5/RFpQbHemA8Xdlb/IUr6x62Sgi75kfZ9z671VZvI3?=
 =?us-ascii?Q?kihBGZSY6EdYKTib1Ez1m7mtrNvebq/p0kGNnzFmXoIRIc457CNx8aLY3c7X?=
 =?us-ascii?Q?PlvX2PR7E3L7+jHoWs3wK2upBmN/GALIdxisx8T2b7n3aU1rDVCf8n5opCBo?=
 =?us-ascii?Q?u1oeVuG6DIRq6OE31cr8bguEDDm6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 13:59:39.6784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7109eb-9222-4845-6b6a-08dcdefca138
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319
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

The zynqmp tcminit crashes the U-Boot when switching from
r5-mode "split" to "lockstep" instead it should throw an error.
When cpu is enabled, the check_tcm_mode() function checks
if the previous mode is "split", switch mode is "lockstep" then
it returns the error code and the initialize_tcm() function is not
updating the global control register of the RPU instead it prints
the error message. When cpu is disabled, the check_tcm_mode()
function returns the success code for switch split to lockstep mode.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 arch/arm/mach-zynqmp/cpu.c                    | 16 ++++++++++---
 arch/arm/mach-zynqmp/include/mach/sys_proto.h |  1 +
 arch/arm/mach-zynqmp/mp.c                     | 24 +++++++++++++++++++
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-zynqmp/cpu.c b/arch/arm/mach-zynqmp/cpu.c
index 07668c9468..b24c163147 100644
--- a/arch/arm/mach-zynqmp/cpu.c
+++ b/arch/arm/mach-zynqmp/cpu.c
@@ -115,9 +115,19 @@ u64 get_page_table_size(void)
 #if defined(CONFIG_SYS_MEM_RSVD_FOR_MMU) || defined(CONFIG_DEFINE_TCM_OCM_MMAP)
 void tcm_init(u8 mode)
 {
-	puts("WARNING: Initializing TCM overwrites TCM content\n");
-	initialize_tcm(mode);
-	memset((void *)ZYNQMP_TCM_BASE_ADDR, 0, ZYNQMP_TCM_SIZE);
+	int ret;
+
+	ret = check_tcm_mode(mode);
+	if (!ret) {
+		puts("WARNING: Initializing TCM overwrites TCM content\n");
+		initialize_tcm(mode);
+		memset((void *)ZYNQMP_TCM_BASE_ADDR, 0, ZYNQMP_TCM_SIZE);
+	}
+
+	if (ret == -EACCES)
+		printf("ERROR: Split to lockstep mode required reset/disable cpu\n");
+
+	/* Ignore if ret is -EAGAIN, trying to initialize same mode again */
 }
 #endif
 
diff --git a/arch/arm/mach-zynqmp/include/mach/sys_proto.h b/arch/arm/mach-zynqmp/include/mach/sys_proto.h
index 15b69e7771..b3396db28f 100644
--- a/arch/arm/mach-zynqmp/include/mach/sys_proto.h
+++ b/arch/arm/mach-zynqmp/include/mach/sys_proto.h
@@ -48,6 +48,7 @@ enum {
 
 unsigned int zynqmp_get_silicon_version(void);
 
+int check_tcm_mode(bool mode);
 void initialize_tcm(bool mode);
 void mem_map_fill(void);
 #if defined(CONFIG_SYS_MEM_RSVD_FOR_MMU) || defined(CONFIG_DEFINE_TCM_OCM_MMAP)
diff --git a/arch/arm/mach-zynqmp/mp.c b/arch/arm/mach-zynqmp/mp.c
index 9b46a25a1c..6e6da8008f 100644
--- a/arch/arm/mach-zynqmp/mp.c
+++ b/arch/arm/mach-zynqmp/mp.c
@@ -12,7 +12,9 @@
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/io.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
+#include <linux/errno.h>
 #include <linux/string.h>
 
 #define LOCK		0
@@ -264,6 +266,28 @@ void initialize_tcm(bool mode)
 	}
 }
 
+int check_tcm_mode(bool mode)
+{
+	u32 tmp, cpu_state;
+	bool mode_prev;
+
+	tmp = readl(&rpu_base->rpu_glbl_ctrl);
+	mode_prev = FIELD_GET(ZYNQMP_RPU_GLBL_CTRL_SPLIT_LOCK_MASK, tmp);
+
+	tmp = readl(&crlapb_base->rst_lpd_top);
+	cpu_state = FIELD_GET(ZYNQMP_CRLAPB_RST_LPD_R50_RST_MASK |
+			      ZYNQMP_CRLAPB_RST_LPD_R51_RST_MASK, tmp);
+	cpu_state = cpu_state ? false : true;
+
+	if ((mode_prev == SPLIT && mode == LOCK) && cpu_state)
+		return -EACCES;
+
+	if (mode_prev == mode)
+		return -EAGAIN;
+
+	return 0;
+}
+
 static void mark_r5_used(u32 nr, u8 mode)
 {
 	u32 mask = 0;
-- 
2.25.1

