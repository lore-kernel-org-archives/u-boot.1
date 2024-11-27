Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B0FD6ACC0
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 12:18:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D5D8897DA;
	Wed, 27 Nov 2024 13:18:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="qdagk+Cs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E545E897DD; Wed, 27 Nov 2024 13:18:02 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20710.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::710])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B340E897C3
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 13:18:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQEH9zuWFlkPLOclLDNtGH4qvDGh4Gv+u18EZ3tHrLZ2VURd7erxuveHFn/0/TAgFs6Tr4NhZDmFLoF7KWpMTcAnjs7Vpdo7q1iOkxbaSxBH3xepw1iTRCi7eqZOZzdK73R+Q3HEpsiz/MPnyDrZWA/YHR/q4Adrwd3i53wt4ySExCJJG4lcz6+O6cpKqkQwoRktKtVs2kkUg8UVAs8P31M+Fd6jwFvHrg9T06C1/oEeKPboSXW5seVQC/vEiMrZs5j5mhYXRpsz8O8MsFMPHTYXiwsUoPsbh72FiJRX1RI1pkPEknNIoY+5AasmhgMAWNybig+kaET+FrKjXXeoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ioxw1X0DJo8cZKL5wlJlfzjIJLf5muhJSh4nbGQeko=;
 b=qQh1Gpo+wsElDppQhm2a95fFto9lcd1F/UN+92HrDR/0wW9o5MlRAHbAtCHUvZ/W5A48T+akOljJAU/pNJ8La1M1jNWumNkkQOQX1VN30MiT3ikwv8e97+CEGuJAo0I1JcgE4JjEMRU+fgPW82x0TQ/bWzWVJdlLnXWPr+5KIFCV0L8yUkgjNdKknC4RnQ2RdfX9YsCXZOkWlTze1ke6A2SmMup4AxmSpblNeiIqOxegWoaorE2h0RRfhmO8QYASEYzUndj4rx82tMGIirR+ULb6yVOZT1biHeWUQpVUzBGkyG2Qzh0WuNuK15tPMyTdiHXjz4j87TGLpv4M1k9Eag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ioxw1X0DJo8cZKL5wlJlfzjIJLf5muhJSh4nbGQeko=;
 b=qdagk+Csom/gZ1DN+JntVtCnNs+LNvVGQvjhi9XvwHaDjldJZy9bUjhz7LJN3QgRGCerO+UESGPO43XK/upxQQ3cSIFww1r7r8ilxtySE9uNJbLSsbzcxxzR8em9U95VePqZz31Y3Q1RmHKR5xA2hksTES/r4GaA35gVo1TZbFk=
Received: from DUZPR01CA0354.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::6) by DBAP195MB0859.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:1cf::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 12:17:55 +0000
Received: from DU6PEPF0000B622.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::8a) by DUZPR01CA0354.outlook.office365.com
 (2603:10a6:10:4b8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Wed,
 27 Nov 2024 12:17:55 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF0000B622.mail.protection.outlook.com (10.167.8.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Wed, 27 Nov 2024 12:17:55 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 27 Nov
 2024 13:17:54 +0100
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 27 Nov
 2024 13:17:53 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <n-francis@ti.com>, <d-gole@ti.com>, <afd@ti.com>,
 <nm@ti.com>, <d.schultz@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 3/4] board: phytec: k3: Add EFI capsule update support
Date: Wed, 27 Nov 2024 13:17:35 +0100
Message-ID: <20241127121736.1525948-4-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241127121736.1525948-1-w.egorov@phytec.de>
References: <20241127121736.1525948-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B622:EE_|DBAP195MB0859:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f75e6de-b3d2-4cea-cf06-08dd0edd85f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5BOP2iGgIKyEuEzAc4wWUSTb9s7ouRoVjGddXMe/76neSQwzmUEwwcTYgEpK?=
 =?us-ascii?Q?DkLz8HLq76SCtOSlPbE7fmlyWKGyT7yollS3kggwPzvNjU1sEKN6mSA8lTm4?=
 =?us-ascii?Q?NbXmuB4Hiyps53cIlTduLgXLoKoJ9CHNFySdOXcwad85FznPqOZSAmGBIFP7?=
 =?us-ascii?Q?VckPt+E7QJ51tp7ceGnwYM9uU1Va1iTW2nmItPD43GGhDTrChz9M5uIg4X3r?=
 =?us-ascii?Q?WCR7DoRTUizNgxbnkl6UgFMo0UkblgxdYMh8Kq7wSwoT5pokh4nFi5nr/CiS?=
 =?us-ascii?Q?zBqYpYMWxVE8VoB9Xy9921W+749xeHFMQbBi63s6eG8MjToVb8iYh6O8yt3Y?=
 =?us-ascii?Q?setsZPUCywaltFxksnst9J3AIpeK051D8zMappTSU8ZTAyU4JFGEFDlxek7w?=
 =?us-ascii?Q?tBreg93UNxGyjPmIaQI+jnljFB4hHm/QDO2mPC6eNZ71zxkdPAcFa9GxTUEn?=
 =?us-ascii?Q?dEZbHQdYubXTYcta0pM8xasNkU7ejZmfle6an/4YwdJeA0nmh7doufj6zhyr?=
 =?us-ascii?Q?Nt5FSfDQI1SZP0wZ+XpIz+vu9ojIZgSOGzs1QmuN1StJqKlPgvjQmc9VldVL?=
 =?us-ascii?Q?JDsVr9lwplAMB+X9/sOiXuMU5AqkQE+IupfsfLnCWaLT/rp644P5czUKj939?=
 =?us-ascii?Q?2ywxIKGbELNyD0yDGm5xKNlrqSdAmImphgrTQSHCfe6/tLGQIzUR8fc/g7J6?=
 =?us-ascii?Q?NOUxBgKfbv2gORM6DKP2D5GMFwc0tvs9ht77glQ6vyEJVAoZNfKjn/fzPIQY?=
 =?us-ascii?Q?3xejKqCU3EBfZDvDlULGZkbHwOiqukUwhqSUFvgRqTqZ4X8upXT9CQC848/v?=
 =?us-ascii?Q?XJY0JsF63BG98kKH137vLoBJpqKoYi0uGF8bMTqigyGiUSVezteMtab/Yvop?=
 =?us-ascii?Q?gUWuNQKLAtDhK55rmF4xk+LbfZdtIj0cF9n+wqXrlzaBnnEWAV3xW4j8w7zh?=
 =?us-ascii?Q?9MM81Rz8NkOBO51exGRoMx1gzWSBBhwB/+XlKwq/KsEfzkVCePcPzPIG9f72?=
 =?us-ascii?Q?mQj8Y1ss78+9flA3n6AQVc0CqCb3ludeE64G6XguehoH4+ZwTXfDYMF8tXMg?=
 =?us-ascii?Q?rPiN3myqzrYK9EQt39g+9bhh4Xje6xaTnSNrxJ8K8KdaQIcXs6v4UX8TF5zL?=
 =?us-ascii?Q?cMErdGtif++opzAB5dW5kPxRUj6rFKy45bqacmYiYhwS87XAPSBSXVc4zVgb?=
 =?us-ascii?Q?CyjcLi9ENl5Mi95KAlErlI5mPYkaKr++lZTAt4Hjm6JBEOrBgBrCbBVDcLMi?=
 =?us-ascii?Q?irdsJkyx4TcRUaKf9U641KOt3uimpsAizXl8Tk+jcOaWPkyJemupbEGgmQLG?=
 =?us-ascii?Q?Ew7ak29I6axIBZHuuNbXmk42l5pXXVcNGZOLqb8BAqMe1LrHo9n9XPZJpZZB?=
 =?us-ascii?Q?dK8PfsIVqFhzAtrjRyj1v7BzoNxMBK6ER5CBJFzoNQdCZaptV53Eip08bAnM?=
 =?us-ascii?Q?bpMDhApLBJEnpz6CopEE2f8DnB3aDAfH?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 12:17:55.3566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f75e6de-b3d2-4cea-cf06-08dd0edd85f0
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB0859
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

Implement EFI capsule update functionality for PHYTEC K3-based SoMs.
These SoMs feature various flash device options, including eMMC,
OSPI NOR, and uSD card at the board level.

This update provides the necessary logic to enable EFI capsule updates
across all three flash devices, ensuring flexible and robust firmware
upgrade capabilities.

The GUID is dynamically generated for the board, to get it:

  efidebug capsule esrt
  ========================================
  ESRT: fw_resource_count=3
  ESRT: fw_resource_count_max=3
  ESRT: fw_resource_version=1
  [entry 0]==============================
  ESRT: fw_class=C7D64D6D-10B2-54BC-A3BF-06A9DC3653D9
  ESRT: fw_type=unknown
  ESRT: fw_version=0
  ESRT: lowest_supported_fw_version=0
  ESRT: capsule_flags=0
  ESRT: last_attempt_version=0
  ESRT: last_attempt_status=success
  [entry 1]==============================
  ESRT: fw_class=09841C3F-F177-5D57-B1F6-754D92879205
  ESRT: fw_type=unknown
  ESRT: fw_version=0
  ESRT: lowest_supported_fw_version=0
  ESRT: capsule_flags=0
  ESRT: last_attempt_version=0
  ESRT: last_attempt_status=success
  [entry 2]==============================
  ESRT: fw_class=D11A9016-515E-503A-8872-3FF65384D0C4
  ESRT: fw_type=unknown
  ESRT: fw_version=0
  ESRT: lowest_supported_fw_version=0
  ESRT: capsule_flags=0
  ESRT: last_attempt_version=0
  ESRT: last_attempt_status=success
  ========================================

On the board (from uSD card containing capsule binaries at boot):

  load mmc 1:1 $loadaddr tiboot3-capsule.bin
  efidebug capsule update $loadaddr

  load mmc 1:1 $loadaddr tispl-capsule.bin
  efidebug capsule update $loadaddr

  load mmc 1:1 $loadaddr uboot-capsule.bin
  efidebug capsule update $loadaddr

The binaries will be flashed to the flash device you are booted from.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/common/k3/board.c  | 80 +++++++++++++++++++++++++++++++++
 include/configs/phycore_am62x.h |  4 ++
 include/configs/phycore_am64x.h |  4 ++
 3 files changed, 88 insertions(+)

diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
index 346b2b6491a..065e446e154 100644
--- a/board/phytec/common/k3/board.c
+++ b/board/phytec/common/k3/board.c
@@ -4,15 +4,92 @@
  * Author: Wadim Egorov <w.egorov@phytec.de>
  */
 
+#include <efi_loader.h>
 #include <env_internal.h>
 #include <fdt_support.h>
 #include <dm/ofnode.h>
+#include <mtd.h>
 #include <spl.h>
 #include <malloc.h>
 #include <asm/arch/hardware.h>
 
 #include "../am6_som_detection.h"
 
+#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
+struct efi_fw_image fw_images[] = {
+	{
+		.fw_name = PHYCORE_AM6XX_FW_NAME_TIBOOT3,
+		.image_index = 1,
+	},
+	{
+		.fw_name = PHYCORE_AM6XX_FW_NAME_SPL,
+		.image_index = 2,
+	},
+	{
+		.fw_name = PHYCORE_AM6XX_FW_NAME_UBOOT,
+		.image_index = 3,
+	}
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = NULL,
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+
+/**
+ * configure_capsule_updates() - Set up the DFU string for capsule updates
+ *
+ * Configures all three bootloader binaries for updates on the current
+ * booted flash device, which may be eMMC, OSPI NOR, or a uSD card. If
+ * booting from USB or Serial, capsule updates will be performed on the
+ * eMMC device.
+ *
+ * Note: Currently, eMMC hardware partitions are not differentiated; Updates
+ * are always applied to the first boot partition.
+ */
+void configure_capsule_updates(void)
+{
+	static char dfu_string[128] = { 0 };
+	const char *dfu_raw = "tiboot3.bin raw 0x0 0x400 mmcpart 1;"
+			      "tispl.bin raw 0x400 0x1000 mmcpart 1;"
+			      "u-boot.img.raw raw 0x1400 0x2000 mmcpart 1";
+	const char *dfu_fat = "tiboot3.bin fat 1 1;"
+			      "tispl.bin fat 1 1;"
+			      "u-boot.img fat 1 1";
+	const char *dfu_spi = "tiboot3.bin part 1;"
+			     "tispl.bin part 2;"
+			     "u-boot.img part 3";
+	u32 boot_device = get_boot_device();
+
+	switch (boot_device) {
+	case BOOT_DEVICE_MMC1:
+		snprintf(dfu_string, 128, "mmc 0=%s", dfu_raw);
+		break;
+	case BOOT_DEVICE_MMC2:
+		snprintf(dfu_string, 128, "mmc 1=%s", dfu_fat);
+		break;
+	case BOOT_DEVICE_SPI:
+		mtd_probe_devices();
+		snprintf(dfu_string, 128, "mtd nor0=%s", dfu_spi);
+		break;
+	default:
+		snprintf(dfu_string, 128, "mmc 0=%s", dfu_raw);
+		break;
+	};
+
+	update_info.dfu_string = dfu_string;
+}
+#endif
+
+#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
+void set_dfu_alt_info(char *interface, char *devstr)
+{
+	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
+		env_set("dfu_alt_info", update_info.dfu_string);
+}
+#endif
+
 #if IS_ENABLED(CONFIG_ENV_IS_IN_FAT) || IS_ENABLED(CONFIG_ENV_IS_IN_MMC)
 int mmc_get_env_dev(void)
 {
@@ -94,6 +171,9 @@ int board_late_init(void)
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
+		configure_capsule_updates();
+
 	return 0;
 }
 #endif
diff --git a/include/configs/phycore_am62x.h b/include/configs/phycore_am62x.h
index 10b78b6f537..2bc6e7e16f9 100644
--- a/include/configs/phycore_am62x.h
+++ b/include/configs/phycore_am62x.h
@@ -12,4 +12,8 @@
 /* DDR Configuration */
 #define CFG_SYS_SDRAM_BASE		0x80000000
 
+#define PHYCORE_AM6XX_FW_NAME_TIBOOT3	u"PHYCORE_AM62X_TIBOOT3"
+#define PHYCORE_AM6XX_FW_NAME_SPL	u"PHYCORE_AM62X_SPL"
+#define PHYCORE_AM6XX_FW_NAME_UBOOT	u"PHYCORE_AM62X_UBOOT"
+
 #endif /* __PHYCORE_AM62X_H */
diff --git a/include/configs/phycore_am64x.h b/include/configs/phycore_am64x.h
index 9377db30a91..dd3dfa94270 100644
--- a/include/configs/phycore_am64x.h
+++ b/include/configs/phycore_am64x.h
@@ -12,4 +12,8 @@
 /* DDR Configuration */
 #define CFG_SYS_SDRAM_BASE		0x80000000
 
+#define PHYCORE_AM6XX_FW_NAME_TIBOOT3	u"PHYCORE_AM64X_TIBOOT3"
+#define PHYCORE_AM6XX_FW_NAME_SPL	u"PHYCORE_AM64X_SPL"
+#define PHYCORE_AM6XX_FW_NAME_UBOOT	u"PHYCORE_AM64X_UBOOT"
+
 #endif /* __PHYCORE_AM64X_H */
-- 
2.34.1

