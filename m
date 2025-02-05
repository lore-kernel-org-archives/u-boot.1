Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FA0C02197
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 04:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07C05806C9;
	Wed,  5 Feb 2025 05:30:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="UH//FW3w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1531980087; Wed,  5 Feb 2025 05:30:28 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::724])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBACB80104
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 05:30:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEXACZM2WSCK/Tl31C+JSesWeTrXxpDNVqAVH+BcImG+2mINwetM+jYr5Ix1aNkmKppf2a0YVr8/gS676mSkUKPGxvVPLMjumjlOZ/h1EE/bwzLM4+sgHLujJME7JEqgAR6PhKrtWJOdb6jLLibaxP7v3gQmXf8lvO6IytJJGLOSbcfSYfUniRFn+TvznC7If3ZRR0KrEmOH/vegdtNzfAGeuxeP8i7F/ngSO0GGSiOUd25y6uM/Aru0Z/Y1v4wj4j8qlKOxcLDtGktZkic/TN52VFOnNxx2mnGkkAn6P7nfgZKq5S5kwCZK3hFNgPIY4sbuVbSwhy3/NykcJLy1uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEOGH9oE8KSZlEnHTybyYiaCB6S6aOxZnCiYSSK3Ea4=;
 b=O5M/R6PtE3SmKk1Mp8G77RFCHQKvwn5FqjtuC8lDtFTP9C1tcP4N7G3bX8Spa/cUZPzW3hm5eWh86Q0Iz6dkCIkTy6D9F6Poxe2ZDGjNaH3smQYdmYslOw70Qhan6h5uj/1Jom1gEbDkkmfnL/OhZWmtDR/wb9nKlLpyv3mN6Z9lx+2GldjGo5/mJTszyoF38XP8lDT+VXmiv5XLzdIzGli4zaqGId5a77N8dAtmPD4byfygmhBL+Nr6EY9lN4+oTYHYMuUdXkm9LlKr2vOnfr10d6zHAfQaCvsaSsln6p78BMDHz9eL7wy1YFpjE0NFNxvAwXRMnNor1nwhgLNPuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEOGH9oE8KSZlEnHTybyYiaCB6S6aOxZnCiYSSK3Ea4=;
 b=UH//FW3w8nEX3egMCJctZeaWCOxbncii23N9XnICi/n1LvEiXfrht4TiCW6BaID5DtxxlqNO1IMsX/2dQYkWHZ34TyX+5neyQQafg5ENFl7YqayIbdNiHOf3w+1XsCN1kD//iQfANe0wOx6JuB5JF7un1BWHqt+LnPVmxrKKFZjf54mttCrsv1FjB8X9BB6Bbi1Gwfa8mhXshsxOdbW2HM24SWoN1YfcZFbPToel6qi7F/5wIdOzIBc9P36tTSZlrLSqbW2YIwDeE906qZaXdtEBs1FTXptgolQPPxRhQR8/RYA22uu0z19bHLyKFcq3b4dO3HLaiO4E8OVJICtQ6w==
Received: from DU6P191CA0071.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::28)
 by AM9P195MB0951.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 04:30:22 +0000
Received: from DB1PEPF000509E2.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::51) by DU6P191CA0071.outlook.office365.com
 (2603:10a6:10:53e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 04:30:22 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509E2.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 04:30:22 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 05:30:21 +0100
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 05:30:21 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>,
 <d.schultz@phytec.de>, <d-gole@ti.com>, <sjg@chromium.org>
Subject: [PATCH v2 2/3] board: phytec: phycore_am64x: Add support for 1 GB RAM
 variant and ECC
Date: Wed, 5 Feb 2025 05:30:12 +0100
Message-ID: <20250205043013.1404917-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250205043013.1404917-1-w.egorov@phytec.de>
References: <20250205043013.1404917-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E2:EE_|AM9P195MB0951:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8307b4-034f-4ad5-3fcb-08dd459dcdf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i2vqjDwiC6PqMzALtMXo2qsDnZb7OJVfUu1BnDOV0SaGbBbrfy+htiBRgV6R?=
 =?us-ascii?Q?Cbo1bOEHUf2FZ9hy14tFU+DN3660I8VPcb7CNZV8grU6v6nfiDufhw8EfslK?=
 =?us-ascii?Q?9Wp8CxSk8V9IMgaQPimKQu1C3T4zfK/ePKjKL1TiPkgaLWSAV5hAtSl6KKEE?=
 =?us-ascii?Q?aZvGWD4GdPlXb4bvFb5xEAzj/VFaxtPoSWhB0G3C+2MOS4wrToWf4APYNyK8?=
 =?us-ascii?Q?V06xq7lPEEbnTQAXbmqKjDnQgodu9Uq/QDRcoZniERtQ4Vou2uAV6fYsTkMB?=
 =?us-ascii?Q?8GL6iH1SQWR8Lnae1A8lP9CyLvqWpyVooOtZFDQ5zzOF7khTbfCGnGPULrl6?=
 =?us-ascii?Q?GxrvYqafAtzu2GaRIoaWCQnvtSUrj+FoC1Evfb+d5d4i6gZb5LkMi+x275v1?=
 =?us-ascii?Q?jJRnpP8bs9nImxUcGhqFKz/jw2thqdJJeShaXZs5pJxhP7R+T8QkrePMIlc0?=
 =?us-ascii?Q?01Rfk1fdOJq4eW9iWv05FhPixFRkbtuznsFankZVKRCeHSIhEJrzQ9r4acFU?=
 =?us-ascii?Q?YBHh36mF9IdPAYGobmIRC3frLhKDqqUHsYwwMf1ZToWo3IvdB4htn32uaMap?=
 =?us-ascii?Q?RQOGDrA+N6IQZ0lRoRIWIJ/GzdAvfyOnSAAkHMNw0jyxnW2Fa46na8KYVmDt?=
 =?us-ascii?Q?U8DyU1AjRDhuHTuRHFD1ZpPZsCyhpPwEh06wBIa0cnvpXL4NEveio7V/Vnik?=
 =?us-ascii?Q?51nxMk9HNe0MEj+6yYAtoTZjwOrju9o05nz0DvVI9Py7nrgTrONMArocRMhb?=
 =?us-ascii?Q?1TwEb1Tjgbtm7m6ctx+5PdJKpPsd6VT6ubVLlQBikwGqieW54SIaiq84I2vZ?=
 =?us-ascii?Q?Fvw5rFh4KdAiB4mybjybN9mn3AHjppLgu0+o/2x23IqVJCyJO4wfqz3sgfh2?=
 =?us-ascii?Q?0mngnItXkMglDqI+4mEo6HzVqfj/aa7r416OinoVEx0z8q9O4isjYqpe1f48?=
 =?us-ascii?Q?1pFZWCaE1b/P0DzGiOB1GKYG3I4uK/zrZXEmFiwM2kvtRqDa1NwUkSi2yuB/?=
 =?us-ascii?Q?dfHkeUxZ4jk7BryX5ExZC+dNUwwkWUE2jHTSmt5RunxhqhdrPB1V/lESl7sc?=
 =?us-ascii?Q?02BjNL/9Fqb0Im1yuaSwkaX0cH7KnvqP8aVhjejrGVZcUK0DyImDSfLgi3cX?=
 =?us-ascii?Q?+6Ft7B6XdWIFCnj4Qi2s5WTSgjuylARq1sXg8h8tDQtnbV5gYkveWBaw97KM?=
 =?us-ascii?Q?hsCLFhgWTKOAsesdiE9GyfHOF58VXCIVropTyqIWcCnpWuQihRE1dOydPohS?=
 =?us-ascii?Q?oksQ1np/QSjPcvXLBsXjRjM/UflQuTd6NSOUrvbcav5S7rYFWhsm6iDCc+Au?=
 =?us-ascii?Q?X8ytda5XWEWn0Aze7INMknKJYlZKrQdEpj3Y+yLxGv8rKjah2hpStA/JzuxV?=
 =?us-ascii?Q?aEaaMFQnxN70bYOeWz1SKvxVACeILEvdZw3jr1cGtaBpx21hRmJYCcO+jnx4?=
 =?us-ascii?Q?kzOY62Tw84lvHH+GfZDPRNmD42p49lGlX8szd2chkPeZ5XI6JU5eVsWAM9QT?=
 =?us-ascii?Q?veZ1vc7eoCvheI8=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 04:30:22.3018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8307b4-034f-4ad5-3fcb-08dd459dcdf1
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB0951
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

Detect RAM size via EEPROM and adjust DDR size and banks accordingly.
Include necessary fixups to handle ECC-enabled configurations.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Tested-by: Daniel Schultz <d.schultz@phytec.de>
---
v2: Add Tested-by from Daniel
---
 board/phytec/phycore_am64x/Kconfig         |  25 +++++
 board/phytec/phycore_am64x/phycore-am64x.c | 105 ++++++++++++++++++++-
 2 files changed, 128 insertions(+), 2 deletions(-)

diff --git a/board/phytec/phycore_am64x/Kconfig b/board/phytec/phycore_am64x/Kconfig
index 829526c3295..a709b71ba4d 100644
--- a/board/phytec/phycore_am64x/Kconfig
+++ b/board/phytec/phycore_am64x/Kconfig
@@ -35,3 +35,28 @@ config SYS_CONFIG_NAME
 source "board/phytec/common/Kconfig"
 
 endif
+
+config PHYCORE_AM64X_RAM_SIZE_FIX
+        bool "Set phyCORE-AM64x RAM size fix instead of detecting"
+        default false
+        help
+          RAM size is automatic being detected with the help of
+          the EEPROM introspection data. Set RAM size to a fix value
+          instead.
+
+choice
+        prompt "phyCORE-AM64x RAM size"
+        depends on PHYCORE_AM64X_RAM_SIZE_FIX
+        default PHYCORE_AM64X_RAM_SIZE_2GB
+
+config PHYCORE_AM64X_RAM_SIZE_1GB
+        bool "1GB RAM"
+        help
+          Set RAM size fix to 1GB for phyCORE-AM64x.
+
+config PHYCORE_AM64X_RAM_SIZE_2GB
+        bool "2GB RAM"
+        help
+          Set RAM size fix to 2GB for phyCORE-AM64x.
+
+endchoice
diff --git a/board/phytec/phycore_am64x/phycore-am64x.c b/board/phytec/phycore_am64x/phycore-am64x.c
index 8f3b22657c7..f14c87f5c72 100644
--- a/board/phytec/phycore_am64x/phycore-am64x.c
+++ b/board/phytec/phycore_am64x/phycore-am64x.c
@@ -11,9 +11,12 @@
 #include <env.h>
 #include <env_internal.h>
 #include <spl.h>
+#include <asm/arch/k3-ddr.h>
 #include <fdt_support.h>
 #include <asm/arch/hardware.h>
 
+#include "../common/am6_som_detection.h"
+
 DECLARE_GLOBAL_DATA_PTR;
 
 int board_init(void)
@@ -21,15 +24,113 @@ int board_init(void)
 	return 0;
 }
 
+static u8 phytec_get_am64_ddr_size_default(void)
+{
+	int ret;
+	struct phytec_eeprom_data data;
+
+	if (IS_ENABLED(CONFIG_PHYCORE_AM64X_RAM_SIZE_FIX)) {
+		if (IS_ENABLED(CONFIG_PHYCORE_AM64X_RAM_SIZE_1GB))
+			return EEPROM_RAM_SIZE_1GB;
+		else if (IS_ENABLED(CONFIG_PHYCORE_AM64X_RAM_SIZE_2GB))
+			return EEPROM_RAM_SIZE_2GB;
+	}
+
+	ret = phytec_eeprom_data_setup(&data, 0, EEPROM_ADDR);
+	if (!ret && data.valid)
+		return phytec_get_am6_ddr_size(&data);
+
+	/* Default DDR size is 2GB */
+	return EEPROM_RAM_SIZE_2GB;
+}
+
 int dram_init(void)
 {
-	return fdtdec_setup_mem_size_base();
+	u8 ram_size;
+
+	if (!IS_ENABLED(CONFIG_CPU_V7R))
+		return fdtdec_setup_mem_size_base();
+
+	ram_size = phytec_get_am64_ddr_size_default();
+
+	switch (ram_size) {
+	case EEPROM_RAM_SIZE_1GB:
+		gd->ram_size = 0x40000000;
+		break;
+	case EEPROM_RAM_SIZE_2GB:
+		gd->ram_size = 0x80000000;
+		break;
+	default:
+		gd->ram_size = 0x80000000;
+	}
+
+	return 0;
 }
 
 int dram_init_banksize(void)
 {
-	return fdtdec_setup_memory_banksize();
+	u8 ram_size;
+
+	memset(gd->bd->bi_dram, 0, sizeof(gd->bd->bi_dram[0]) * CONFIG_NR_DRAM_BANKS);
+
+	if (!IS_ENABLED(CONFIG_CPU_V7R))
+		return fdtdec_setup_memory_banksize();
+
+	ram_size = phytec_get_am64_ddr_size_default();
+	switch (ram_size) {
+	case EEPROM_RAM_SIZE_1GB:
+		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+		gd->bd->bi_dram[0].size = 0x40000000;
+		gd->ram_size = 0x40000000;
+		break;
+
+	case EEPROM_RAM_SIZE_2GB:
+		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+		gd->bd->bi_dram[0].size = 0x80000000;
+		gd->ram_size = 0x80000000;
+		break;
+
+	default:
+		/* Continue with default 2GB setup */
+		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+		gd->bd->bi_dram[0].size = 0x80000000;
+		gd->ram_size = 0x80000000;
+		printf("DDR size %d is not supported\n", ram_size);
+	}
+
+	return 0;
+}
+
+#if defined(CONFIG_K3_DDRSS)
+int do_board_detect(void)
+{
+	void *fdt = (void *)gd->fdt_blob;
+	int bank;
+
+	u64 start[CONFIG_NR_DRAM_BANKS];
+	u64 size[CONFIG_NR_DRAM_BANKS];
+
+	dram_init();
+	dram_init_banksize();
+
+	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
+		start[bank] = gd->bd->bi_dram[bank].start;
+		size[bank] = gd->bd->bi_dram[bank].size;
+	}
+
+	return fdt_fixup_memory_banks(fdt, start, size, CONFIG_NR_DRAM_BANKS);
+}
+#endif
+
+#if IS_ENABLED(CONFIG_XPL_BUILD)
+void spl_perform_fixups(struct spl_image_info *spl_image)
+{
+	if (IS_ENABLED(CONFIG_K3_DDRSS) && IS_ENABLED(CONFIG_K3_INLINE_ECC))
+		fixup_ddr_driver_for_ecc(spl_image);
+	else
+		fixup_memory_node(spl_image);
 }
+#endif
 
 #define CTRLMMR_USB0_PHY_CTRL	0x43004008
 #define CORE_VOLTAGE		0x80000000
-- 
2.34.1

