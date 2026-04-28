Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B07FF8864
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C094C84372;
	Tue, 28 Apr 2026 05:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="T+9IIuN+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C91EF84355; Tue, 28 Apr 2026 05:32:44 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6487284376
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwHRREKeBgx9jFjkY4wr9ZUNBkOJt5I7YLAVCuRy48BYMzsTa8SXHXRZT/fIu75QXgd/HvJveRrZW6RM9dxOEAkuh+ZDuUIUku/NLM+1/Vy6s7h6twJZx/qoASwXgd4o+18CDvdBvqjNdYsKHg3OEb6qg27iNM72/A5vyfd4XYjaPx/Sh381WzVqI8KBHIC0/E/39RIUZa/U56YH0cU5YLsW/LKK3/PT32OCZLK5LBedV6UH19llyqOsy7tjPyMc+b6U4P/af6ZTBINk3b9vSNgKzKTYqQgcYJ+VRWwWNI+Z5NpuVUGKghqGkznT+JNQpMoy9Va/YtzC2vQUcpRgKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9/kZ2pVuhY0DuUftIc8n7kMm7/P0jBa9h6hTQnZRrM=;
 b=Nw2XctU4qruXrPIRlLE0P5vWToBKpiRh30UhMYRNii3BUuLFPn8R8IG8Y1ed1/xgcGHzAZJGVI+0uRwjEKkF/08KbX0WdpT7IW+hBle1JKVnQoCnx4XAQ5enwyd6ZBXi6N3Jo4otdaEizbjAtkFFuNxL43qdo+iuzC7zk4wTxAPPItrP8CzQdGp1wbkBjEGeCnvGRM8w8oGBj7M1KL+e/M0kTxXRyT4Yv/Jpa2PH08S5NjJkqMIoJ9W+Gkku8fEk+17lhhaV2r+JXSEfkSjEZq/hbXqOwWBRjtSYzeS602F670ZePN3R9Pe2tUI/H09aT2qfxO/jRF8rXFRPXDYqSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9/kZ2pVuhY0DuUftIc8n7kMm7/P0jBa9h6hTQnZRrM=;
 b=T+9IIuN+LecVfuUcXE6Uqdl1x2aeaDP0aqzgHWuxpmq6uGD1SratsnaiuaC8a+XD+Wnpy1aquWyzoBXyvqPdMtuCJa4ImJPwG4BisudRpkzh/kHF4/ns7CtoiKZOvUESaKmY9gvtK20m1ApMZFjzD1ZOI/NxE87RzWrOGPsSmtHbojgXQxZvzzLLoKWNioYWLW3M8Zav2UOjy+un1nx2QPlDmR6CdHHLMJGKUALbCVz1Z3ylVChbraRuVuUbTSV+QLBQ0dotHo1uhPNAVnpr1ilMz9Felics2ZJ1EIhAj0vByGTvJnp20qnAnUsbEyEm/oNs3TsU6l14GBio0LkLwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by BN9PR03MB5996.namprd03.prod.outlook.com (2603:10b6:408:135::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.36; Tue, 28 Apr
 2026 03:32:37 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9846.021; Tue, 28 Apr 2026
 03:32:37 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Brian Sune <briansune@gmail.com>, Yao Zi <me@ziyao.cc>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v2 2/3] ddr: altera: gen5: Add DRAM size checking
Date: Mon, 27 Apr 2026 20:32:29 -0700
Message-ID: <20260428033230.7777-3-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428033230.7777-1-alif.zakuan.yuslaimi@altera.com>
References: <20260428033230.7777-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::14) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|BN9PR03MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 14018ad9-047e-45bc-ed69-08dea4d6cb6b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|55112099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: gogHlE8uEZzBd9UriqVnrpvrxbE7QgUit6RmLJUnq3p02ESHhgg8PwuBzaYuWpNB3WLrfQtHV6vbmopFUj9quMDHWlQ1c9J7gi0wgYsseD+dzKvOhydUMYIizPpe6CpRdBMT6X/EE1DbNvw4pVbyPCpLyA6clpKdEdTVO7HU+AsTIaa/uJ1gbojz0G+/S6LJVj+uFyHLCaGrzYufr/lrRUaQ6rzkASb/BZLJrmuh34pGWih4a8Z9B9MsKlur3owpCIeZf72+JTBv8tYnSd46uGslrnK0RsnoXxddCfAxVU5z240BDli/vFO6wdnLTfSR1q9GEr0KuFnBsbEy++waopCENgvNuDykwq+6V78dkUJVSPzIrIKQimMtz3ullVscGpWnjXREuTOVAbXTor02ehoMkquNtwljzBFoTJAmYJKUYrzCKfHiXxvF2fEyKWHCXb737OasRzQ1ojQpTDcC6rPSxue+rdm0mWiLVWFZcUshwsn2hDRV5aOmPQOhzV2qHUtrBMcqdRV1ZuwLvrbWW0pnPGVu2gX7i7lqq9VcIJZ4RwWDMZVO07qQN00pu4qhvt4D6fSuNq4j6zuuPr7BKjFck6yoBBgUNEFfl5O7fPWcC6u7VZKz4/gCiDK3zZayd4F89RBjG0eLf/AJYOM90oIE2LJECIoHbbbW/Uy9Iakune4eeEAxhEnirRRgaDX8vb8bbmK963lHAsW9hzofzF9R1oYmJHg5/JVfq6EKsfs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CzeWcahH2JffsuhfA823jkEL7gJxWdW53nNGSeS89WizucYoQuKhKqGqwzCJ?=
 =?us-ascii?Q?8oZXa8V76Kd+nj35Zl8P3P7ltkIa19ZDtj/zH+jTNzoyEDnB4TRYGUPZjLc2?=
 =?us-ascii?Q?oOR7bDhryRJavixrCMndKrC/8s5Z6fRet9awQTtH4LH4k+Uf7f7pWEwkUBXI?=
 =?us-ascii?Q?eGVl/1OesQjTKD8q0RII1/RoBdNrAS2p5/OjiAadNazOrh+9TQAb9oAExwAn?=
 =?us-ascii?Q?R2tO5M+HVJOGiix1BLJBJi/nmL54l6zZBlJuYIeX4/hT8TFNuoMLgi9n3QU4?=
 =?us-ascii?Q?4oQxWNkmjZGUbipgOsL2ii/nlI9qTacd1ysvHdlICKQOEwdsc2JyKUi5InIz?=
 =?us-ascii?Q?SXmC6Ys7jtpqptMshrgLOCwgFqHD0fn82Ir31JZLuv/rp+Od8wLjwsfgzgGB?=
 =?us-ascii?Q?WTSNObwoZ4HU0L2JrVuFx/WlNhtIAW4pbAARbkE0imLQC+vH3gGGxnyq5Ws9?=
 =?us-ascii?Q?ZZ1pmJyFED5k1llcIaJIU4jqZTFfl4YMzqn1JiWfJ16ZBhTvEaH2YKyS7avA?=
 =?us-ascii?Q?dH9pE8RXna26G165Xzc53+zTAul2QWHldXF4sYqSaFrUjtTS5mDYmdP+vKd2?=
 =?us-ascii?Q?qrEJiAIO0nfCSXwX+veEYoQG5GOhWBiUc3w1Su9+adrDcLGnf5a28WejyoiO?=
 =?us-ascii?Q?QYvzs1deKgZuE30RQ9XZB6SGZTHUEcmIv039G2VphpBgvhIwdUto0m4Nhwij?=
 =?us-ascii?Q?I4hsstA0nRDnAoZ2PSjtDgVm66cgT3PRvucflY2shgG9GrAxupSlDYAH5L0H?=
 =?us-ascii?Q?9I9Amfa7aB2uksIVFqdCR3zjwKEHdPvUQxm7oqHnn/GARJkganoZOuaso0s9?=
 =?us-ascii?Q?IcQu6kFbihehLgpu9UXunxtV5kkMEq8Sjscrw2JGFhFYH+6IQuf2NKCd6e2E?=
 =?us-ascii?Q?QUTl2BI9+JNT4jlxDmreVOaxqDTmQLam4Ko2krdqBHZYln0FP68N1B2CEeXT?=
 =?us-ascii?Q?Jvw7tqFXArMdv5DKUbHyVaAK2Jhhdt4DH/wz57PtX8kFZYXdUhI1z5C+h1W4?=
 =?us-ascii?Q?NiCeFvyVXl8emiDYbyaNGcTovBlfeCsWbyy5G8xsumBVR/Y9Ew+6GWu4tBf1?=
 =?us-ascii?Q?aL1guEphtWr9JLUsxNkVqAR3OAGWgWQSD6j8zUuZjWRBIh8c5SlarQ5nkaD6?=
 =?us-ascii?Q?VIKS+NXY8VQ4D0+xca+f/tuix6eP6Zlnzxgu/aFII+Bj3+c5od4smdru4PKc?=
 =?us-ascii?Q?EtncinYNxMV+Nq7z3hVNYZo2BMZnTTWY/bBUr3oCcblTBNfvzMfeRCvmJ1Vo?=
 =?us-ascii?Q?x56fbIwfZw5xd03h4D6zQ+eq2it1XoYYTPDEf0nQ8TTFu464zMZm1DFHculx?=
 =?us-ascii?Q?bgKMQvthlqiZkt7CXyAs0EvH2436Wthm3j/MATrCK4IAFyxEUaDUpMY2fes0?=
 =?us-ascii?Q?C+LqqgE2ZYkTPkTPZ61FdAvWSbK4lyl2WTiaOLYM3Zz7yG98b5xYAeGR7wju?=
 =?us-ascii?Q?n7x7SEDouGrj904rcUg75QU4YCVyTXP05TM/r0SHKoI1/tnr+sxPfoZJmW5g?=
 =?us-ascii?Q?8VKftR2seDL0XeW9TZfAXdOBGyHeBLE87YaI0OB73fCOX3aUtxWR/ujczFJd?=
 =?us-ascii?Q?2Is10ithokP78mxnZv+WlvyFnm+mns98sJQ+ElGtnrEi4TfyKVB6ctO7UsTo?=
 =?us-ascii?Q?+qsw64+f+Kw72apYWqTBX1C4uOp/ApZgKF/vPqgWihmYoRb06HOhoGq+xgOI?=
 =?us-ascii?Q?EFGvh2eeqkCuxlLOvTlvamy6CpW/R5t4+ikCR89vNkVt/yhxYOV55qOP39nk?=
 =?us-ascii?Q?n2cEVIidXsedmLs2Ojqa1haWmVoU2+g=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14018ad9-047e-45bc-ed69-08dea4d6cb6b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 03:32:37.6831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KL2ndOF6aURjFfDlnJlPA2Oi4xdh2Lsa98N4pxPDzk8ePTEGdbI/tloUnHGPbx7T+APJFUDMtFyaSfNJ4ltjbOV7FnEvsc8ESKDBmpPG57U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB5996
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Add DRAM size checking compare between size from device tree and actual
hardware.

Trigger hang if DRAM size from device tree is greater than actual hardware.
Display warning message if DRAM size mismatch between device tree and
actual hardware.

get_ram_size() uses size from device tree. So, it has consistency with
other device families.

New Kconfig is introduced to enable this implementation only on the default
CycloneV board as this will increase the SPL size which will exceed some
Gen5 devices' SPL size limit.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/Kconfig   |  9 +++++++++
 drivers/ddr/altera/sdram_gen5.c | 27 +++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index e2fdd6bb30f..830585a72cc 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -6,6 +6,12 @@ config ERR_PTR_OFFSET
 config NR_DRAM_BANKS
 	default 1
 
+config SOCFPGA_DRAM_SIZE_CHECK
+	bool "Enable DRAM size checking for safety"
+	help
+	 Compares device tree DRAM size with actual hardware. Hangs on
+	 oversized claim.
+
 config SOCFPGA_SECURE_VAB_AUTH
 	bool "Enable boot image authentication with Secure Device Manager"
 	depends on ARCH_SOCFPGA_AGILEX || ARCH_SOCFPGA_N5X || \
@@ -111,6 +117,9 @@ config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
 config ARCH_SOCFPGA_CYCLONE5
 	bool
 	select ARCH_SOCFPGA_GEN5
+	select SOCFPGA_DRAM_SIZE_CHECK if !TARGET_SOCFPGA_TERASIC_SOCKIT \
+	  && !TARGET_SOCFPGA_EBV_SOCRATES && \
+	  !TARGET_SOCFPGA_SOFTING_VINING_FPGA
 
 config ARCH_SOCFPGA_GEN5
 	bool
diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_gen5.c
index 3c79bb11802..1c3c70ea8ae 100644
--- a/drivers/ddr/altera/sdram_gen5.c
+++ b/drivers/ddr/altera/sdram_gen5.c
@@ -5,6 +5,7 @@
 #include <dm.h>
 #include <errno.h>
 #include <div64.h>
+#include <hang.h>
 #include <init.h>
 #include <log.h>
 #include <ram.h>
@@ -15,6 +16,7 @@
 #include <asm/arch/sdram.h>
 #include <asm/arch/system_manager.h>
 #include <asm/bitops.h>
+#include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
 
@@ -22,6 +24,8 @@
 
 #ifdef CONFIG_XPL_BUILD
 
+DECLARE_GLOBAL_DATA_PTR;
+
 struct altera_gen5_sdram_priv {
 	struct ram_info info;
 };
@@ -604,8 +608,31 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
 	sdram_size = sdram_calculate_size(sdr_ctrl);
 	debug("SDRAM: %ld MiB\n", sdram_size >> 20);
 
+#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
+	/* setup the dram info within bd */
+	dram_init_banksize();
+
+	if (sdram_size != gd->bd->bi_dram[0].size) {
+		printf("DDR: Warning: DRAM size from device tree (%lu MiB)\n",
+		       (ulong)(gd->bd->bi_dram[0].size >> 20));
+		printf(" mismatch with hardware (%lu MiB).\n",
+		       (ulong)(sdram_size >> 20));
+	}
+
+	if (gd->bd->bi_dram[0].size > sdram_size) {
+		printf("DDR: Error: DRAM size from device tree is greater\n");
+		printf(" than hardware size.\n");
+		hang();
+	}
+#endif
+
 	/* Sanity check ensure correct SDRAM size specified */
+#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
+	if (get_ram_size(0, gd->bd->bi_dram[0].size) !=
+	    gd->bd->bi_dram[0].size) {
+#else
 	if (get_ram_size(0, sdram_size) != sdram_size) {
+#endif
 		puts("SDRAM size check failed!\n");
 		goto failed;
 	}
-- 
2.43.7

