Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1364CA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 07:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E088082B07;
	Wed, 20 Aug 2025 09:54:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="gi50NQWq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1861E80FA1; Wed, 20 Aug 2025 09:54:18 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B83BB82E05
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 09:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voGAjqyQYGz3ew3MRvdm9b5QvipXkBLfgXE0A659nXBORVJr60MAkfwhNXiPbtCwiGyCi77lTapXBprMZUeZvLt5WN7X+G+twEuEasSPifZMxfu6rVptcc0GwNUXvPcGl5ggTVjTX0eA5wAF9m2OkerZqOeDg6F6YylGO4n5znog0eRpW7aNhI+h+H661Rql2ESCkdpuTtaKQy6AXTpK3JWGFyYsCuCItp+vpyLfJGXCAcsGm9mVvhXCXXpScAiCLR23pK/UtBpVBqPXt75R9NUOUaKOGzX6Jqxn2qBW8rSBwToBDqMeFb3n+nCthYOkPDXRrLrXZFCFe97I0QqPHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bo6Gj/teSEyVStT+uePceNDOTKF1f5n+g18TWI1ohrk=;
 b=e7norWaAvJCb/+G2LtBsnsHKp29MS7yCgvVvKgm+WNuVIkNz0fvYlI1a1htE1Vx1q/QnP6469VIBy8oBFoADgE3Mgd6ERasuyAWGTOLqSBU5ROT2S+goadvssrxCUPLyM+WrgHr6UC0ahc5xV4Vr9h21NXsaDdpxurPJ9uUhy4Ltr2w5NMrPcN5NVC3hft/QMmi2y6DYf7Thk7oT7NwoblHrvLnKfWPurtaZN1Wtrcx26SlNWbOSSDvqc/xT0ywWyKlG7AWd0CVZmK+qXXVvThtR2C7z/pOV6Uv1gSyR/kI11reRRB0ii3bDv3OioXKryf03GaI7zwyWm9wyUIaiZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo6Gj/teSEyVStT+uePceNDOTKF1f5n+g18TWI1ohrk=;
 b=gi50NQWqx8GIRFQq4afD35AEwtnKesDNEL5c/stu8nI7a0Ki7vGbYVwoKWDFQPO0AoKTTeeF3joE0YX8Y79Fbhd86cIQHVlMhO0mOkAMoVFJ5h3bf8cUtezNuizdQZKMGRMshgrRZudOvMM8oOUfGj8DupiqiBFnjpNjyoMn+ONkc9hfEELCOqrvlFkVHl8BbBP7MsgZRnYtDlg0PhTE+r6Y7kq+xikCTRakqsLay2UlyAqYrZ3HYZ5kHL9OBMnnu4Xfbu3O0aopDTtljXpcwSi22VvUkgxhKAef04HyMixt6eVXECyK6yTOE8IOB/r9Uu/5j/8f8b0YJhUjiq80EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by SJ2PR03MB7330.namprd03.prod.outlook.com (2603:10b6:a03:562::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 07:54:03 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 07:54:03 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v2] misc: fs_loader: Add QSPI RAW partition loading support
Date: Wed, 20 Aug 2025 00:53:51 -0700
Message-Id: <20250820075351.6455-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::19) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|SJ2PR03MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: d36dc585-f87f-4d89-d682-08dddfbebb09
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zHjpdsR4/RmrQ3wCVzIV/emx4MbXsHNToAKkahgDSHryO9ryzDg82etnNH3l?=
 =?us-ascii?Q?Vk0D8jTWXHEmOV4imZGdRV8ZOsedu+KD5Gs4Jqh+IFXYZuzjKjnQfYb6T8E7?=
 =?us-ascii?Q?vdBDDJDnZCQtHcTuRZuagrwiIDw+R1Fu9zdbiv/iCjVPgjLzmGcRA5AThph+?=
 =?us-ascii?Q?Wmoary1ayv6v2jw9VVE8bWxU59u4wpvH7lvcZuAbzyGICrA/8oMGr/Z8+72p?=
 =?us-ascii?Q?CnATMBdirzbDtYnUPapP9ry+0/rHJmgw/7HyEo16qeIjnkJXyTH9MC0Ga45x?=
 =?us-ascii?Q?vnq0rDlbw/vh8mrutAnvmRzT6TACnIHay8N3xFardIqwITZlONoQsPEker29?=
 =?us-ascii?Q?kz9Zh2d0i7q73HHqf+dW3272MVbHj7KN5w+bnn6Y2ko85OE6BU/ZKqKZX2kl?=
 =?us-ascii?Q?KPAiQbTHV0fRLzabATQzarlMAZX6TIJYTn8YV4itz04ib6Md/0b+mBy4GJ8/?=
 =?us-ascii?Q?h6eUr8kO1+QqoeZAlBva2v6sRFMEtQal2nNU5R7bVi/8tz/l3vXgCWp9UvL6?=
 =?us-ascii?Q?c5+3j9x0m8JxqIPH6KpJgG9G/ZkPjZm09PORbzCla8xsc/7bM1Dl4GKSB5g1?=
 =?us-ascii?Q?mscCECJj/CFbAKq1YnGMiCl/WLjXnT/+ufhh1r0n21t/VvvzB6yVbpMC/UW4?=
 =?us-ascii?Q?kSuDtZqoH3hBbiy32ws6ufAMN2scxpOYdZXfIsQR2QC5lKchmQ2/Z+TEir8e?=
 =?us-ascii?Q?YfMnhruOnE2s8qguagy3arauM+ljxvsqHaKQKbgnXlFZ98flpO1pi/sHOYKn?=
 =?us-ascii?Q?mxkh6wD4wbgT+JAMKODbYFtPVAI7RdCPApfqxP2juucxGK9HAg2h2X9DmeHg?=
 =?us-ascii?Q?9ympOCJBap60FVwPhSulMkd2O0TvoXbzHn0owwuyXCTuUOhFePqVadfSLWf+?=
 =?us-ascii?Q?wGMlQM6fujTVVfId93gJUeMJDp2QRKxOoElMTJUfyXGSLCJ3HZSp3QFFxjCf?=
 =?us-ascii?Q?EXtzD4nXz0hgRntbfRoQpv8VMAJEt6vVHGYh/FzmBj8BQDI/frZTT+uuPe/Z?=
 =?us-ascii?Q?C1xKZ37pRd38NO88BZJW6PP7LDchK0AhVhS/V0nYmbdCn5cv0fS73K4lFfvL?=
 =?us-ascii?Q?j89xxS4IGaTE+rEBEugHFNVRSliCdGSKigNvbGT9h51FUUM/oOa392enZbKL?=
 =?us-ascii?Q?uTB3OeEf8AtDSH5cXSUZpIwaH1oyz/c4bgKxamp3X1BMKhd5lGTk+rmGiWR3?=
 =?us-ascii?Q?KpJLv0ULckqKx2F6L5u9BxJdBvLz0npgMwdKi+lYDhBM8BwddeYlTmVTClD3?=
 =?us-ascii?Q?WCyVQ5DG9MKseVA2BwEyCqfwbn+jotM0F69eX+XnmYz2S+oOBFmYCREv8cix?=
 =?us-ascii?Q?vTEm3dBS9CJtjHYQmwSPwIX8q9UP5sWkLVYduLwbpF05NlOvifvHXnGo83VL?=
 =?us-ascii?Q?Vysi1fuuV9BPkUVM7Vwu3DkJcsQBFRk09jsYoa9uDMNPXfnji6D14jxhFCOh?=
 =?us-ascii?Q?mo8HgyycZ5E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PwTrkyn7/lCCv5jhPGX0Z8C06z/8ufxJYCQ2tCHjAaV7F8RTJSKGLElpWfCJ?=
 =?us-ascii?Q?copMJTKwqqliJssI1o/CiuOmIMYDrpyYSwmNfTQlNNqQJRPEG5DKzfTZt77a?=
 =?us-ascii?Q?a+8oDPKL+WN7W4QtGBAlm4he7PxkWOlh/GOAw3AJgsxJBi6abGd8Z6b7OqZd?=
 =?us-ascii?Q?FECayaJexr1pdF4/MlS51Ci+cRGrjvaFHwLMfq6uHmeSUn5xbLBIIsqnbHag?=
 =?us-ascii?Q?8+r9tFK1B6XYuhPRwkNPo9uGBKSB75lcErgpu7K1wcEOY8/uqL7DsaMkxzdM?=
 =?us-ascii?Q?swWPUG4ja/vdz/A6PWL7ckn7Fqvzh9CgJzDh89+JfS986Au/lMKLmRfbGM9b?=
 =?us-ascii?Q?QQy5d68ewplQUtup7noCnQFYEGAVBsFSTnj8dUe52Nrh0u42ZgZ6OB0IhmOV?=
 =?us-ascii?Q?u7XOpbzx/gt9nutWKBaZ4D2jmCcdNxtTS0bzV/LdA9mtTKc6M3IRNzq261LW?=
 =?us-ascii?Q?xCb3cxDTBca4nS9Q37AL8495OPLvmijv5RNC0RPRtvYFsDU4HZk+yzDYt7lu?=
 =?us-ascii?Q?iU076RjMSGyV1xawYYLxGZorV6B+00rFT3GobMY73IH9DIEgzuNygbxLorx4?=
 =?us-ascii?Q?3WMOUP6A/d9umdddDWlvmCp4mbM2oipZGSYEqGIQmuhm9T7Vyb2D9q6rgIsn?=
 =?us-ascii?Q?eOQiQ86Q6PHiys26BQ25xVX9z2sDzVZbrYYQ6n60FhTjXeSfjuZyLMcio6Ex?=
 =?us-ascii?Q?BFg5z/8aTdJMvm+w9xQDYLDcpFFTFhVbpNPo1ilaOzF1jxV3QKJ3mQNQuWrd?=
 =?us-ascii?Q?f7KLqO1MeNMhHst4AxaplVdXpEfLH6nfvDyF2Q7hBqUw8ivQoHgLm2qqWFWT?=
 =?us-ascii?Q?3itQy9hIf+FM2QknPBtSaOD91EkxuTKvaQfnZOqecKtI4JSHOtnxLrNoq984?=
 =?us-ascii?Q?8nSAcEMeGrRqwp90/v4UD5/sABMCTHztxh8JW9jPPu4uSLvM/x407BsWiPBM?=
 =?us-ascii?Q?QPjIUpOtougZ2B3NQGD3CVjdmJlTeBOlUVBawnpybCQeNTizO4tx/yXwuIq6?=
 =?us-ascii?Q?NYPidF3xVa1P+24ftS5SXE9wvrmcRPzUkc8zMt3ZsahDBA+sxxwcbr1auu6h?=
 =?us-ascii?Q?yUcCxj7biqL6i1KBCfty5J4gRo2nHlJYGbnGL5XoV6C/rk6fIZkJQBy6keuI?=
 =?us-ascii?Q?atJ3IT7gPPPvohHMUiNzNdzYK7mLDCdvCNeVnInjOwlzdP1JM+ZwTdU2+w9b?=
 =?us-ascii?Q?kQwg5eqek/3uPJSIJ2m95nLwX2uV3BEomIqfTltfsTS4N5nkehnSANGt/VcH?=
 =?us-ascii?Q?rdPtk5tYncL5GIqX4A+5UNE3FBIaDhEFJKpjuffID0ka7qER4DTQdumK05o+?=
 =?us-ascii?Q?ukv88R0DVRTmY1+XpwKP52X8382qGSHfFDYgCp14W8NXATUnSSK2okfBiWls?=
 =?us-ascii?Q?89Xs8aTWGr552K8h3MRdbcqg2ZmH2aNEW/AbR4jCaBe7DBW/9A4MsqwZekFV?=
 =?us-ascii?Q?Rm7EQ5nKjDXyQGbtm50nVOseF8+O6Kvh8RbbyXXuOVJvV7LOI3WmFqKxYFQy?=
 =?us-ascii?Q?DF+S373Ez0bfG4QL4SawZcRFCjIxszluqOJUgiBfpUOfpNbc4NmBJciVQs54?=
 =?us-ascii?Q?pfmeZdyI6jcSOpUpUUCCCn3Hes0OJLqJU16Sy6IaR+5TpqklD/YdByNDwGIQ?=
 =?us-ascii?Q?J46JFf3KPh2NoqxuxYW6YyY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36dc585-f87f-4d89-d682-08dddfbebb09
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 07:54:03.2140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Eb/HwtDsk9FoXf+p0y0LvKEK7DkuTNlvdbFpFNweUEiM6GSavLWsNksGLbLMrDD8rxc3EwL8HhQLWR013rkVUL4npnr5lY3KHd4Cet/ATJkgBiJG7JJ9YCCXxV4rQul
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7330
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

Enhanced the generic firmware loader to support QSPI RAW partition
loading. This would enable FPGA configuration bitstream loading
from QSPI RAW partition to program FPGA.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/misc/fs_loader.c | 86 +++++++++++++++++++++++++++++++++-------
 include/fs_loader.h      | 36 ++++++++++++++++-
 2 files changed, 106 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index 66803f4b997..2c1f89ddf3e 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fs_loader.c
@@ -1,7 +1,7 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0+
  /*
  * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
- *
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #define LOG_CATEGORY UCLASS_FS_FIRMWARE_LOADER
@@ -20,6 +20,7 @@
 #include <mapmem.h>
 #include <malloc.h>
 #include <spl.h>
+#include <spi_flash.h>
 
 #ifdef CONFIG_CMD_UBIFS
 #include <ubi_uboot.h>
@@ -70,6 +71,11 @@ static int mount_ubifs(char *mtdpart, char *ubivol)
 }
 #endif
 
+__weak struct blk_desc *blk_get_by_device(struct udevice *dev)
+{
+	return NULL;
+}
+
 static int select_fs_dev(struct device_plat *plat)
 {
 	int ret;
@@ -124,16 +130,26 @@ static int _request_firmware_prepare(struct udevice *dev,
 				    const char *name, void *dbuf,
 				    size_t size, u32 offset)
 {
-	if (!name || name[0] == '\0')
-		return -EINVAL;
-
 	struct firmware *firmwarep = dev_get_priv(dev);
+	struct device_plat *plat = dev_get_plat(dev);
+	char *endptr;
+	u32 fw_offset;
 
 	if (!firmwarep)
 		return -ENOMEM;
 
 	firmwarep->name = name;
-	firmwarep->offset = offset;
+
+	if (plat->data_type == DATA_RAW) {
+		fw_offset = simple_strtoul(firmwarep->name, &endptr, 16);
+		if (firmwarep->name == endptr || *endptr != '\0')
+			return -EINVAL;
+
+		firmwarep->offset = fw_offset + offset;
+	} else {
+		firmwarep->offset = offset;
+	}
+
 	firmwarep->data = dbuf;
 	firmwarep->size = size;
 
@@ -148,9 +164,10 @@ static int _request_firmware_prepare(struct udevice *dev,
  */
 static int fw_get_filesystem_firmware(struct udevice *dev)
 {
-	loff_t actread;
+	loff_t actread = 0;
 	char *storage_interface, *dev_part, *ubi_mtdpart, *ubi_volume;
-	int ret;
+	int ret = 0;
+	struct device_plat *plat = dev_get_plat(dev);
 
 	storage_interface = env_get("storage_interface");
 	dev_part = env_get("fw_dev_part");
@@ -170,7 +187,8 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 		else
 			ret = -ENODEV;
 	} else {
-		ret = select_fs_dev(dev_get_plat(dev));
+		if (plat->data_type == DATA_FS)
+			ret = select_fs_dev(dev_get_plat(dev));
 	}
 
 	if (ret)
@@ -181,8 +199,18 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 	if (!firmwarep)
 		return -ENOMEM;
 
-	ret = fs_read(firmwarep->name, (ulong)map_to_sysmem(firmwarep->data),
-			firmwarep->offset, firmwarep->size, &actread);
+	if (plat->data_type == DATA_FS)
+		ret = fs_read(firmwarep->name,
+			      (ulong)map_to_sysmem(firmwarep->data),
+			      firmwarep->offset, firmwarep->size, &actread);
+	else if (plat->data_type == DATA_RAW) {
+#ifdef CONFIG_SPI_FLASH
+		ret = spi_flash_read_dm(plat->flash, firmwarep->offset,
+					firmwarep->size,
+					(void *)firmwarep->data);
+		actread = firmwarep->size;
+#endif
+	}
 
 	if (ret) {
 		debug("Error: %d Failed to read %s from flash %lld != %zu.\n",
@@ -231,6 +259,7 @@ int request_firmware_into_buf(struct udevice *dev,
 static int fs_loader_of_to_plat(struct udevice *dev)
 {
 	u32 phandlepart[2];
+	u32 sfconfig[2];
 
 	ofnode fs_loader_node = dev_ofnode(dev);
 
@@ -250,6 +279,15 @@ static int fs_loader_of_to_plat(struct udevice *dev)
 
 		plat->ubivol = (char *)ofnode_read_string(
 				 fs_loader_node, "ubivol");
+
+		if (!ofnode_read_u32_array(fs_loader_node, "sfconfig", sfconfig,
+					   2)) {
+			plat->data_type = DATA_RAW;
+			plat->sfconfig.bus = sfconfig[0];
+			plat->sfconfig.cs = sfconfig[1];
+		} else {
+			plat->data_type = DATA_FS;
+		}
 	}
 
 	return 0;
@@ -257,10 +295,30 @@ static int fs_loader_of_to_plat(struct udevice *dev)
 
 static int fs_loader_probe(struct udevice *dev)
 {
-#if CONFIG_IS_ENABLED(DM) && CONFIG_IS_ENABLED(BLK)
-	int ret;
+	int ret = 0;
 	struct device_plat *plat = dev_get_plat(dev);
 
+#ifdef CONFIG_SPI_FLASH
+	if (!plat->flash) {
+		debug("bus = %d\ncs = %d\n",
+		      plat->sfconfig.bus, plat->sfconfig.cs);
+
+		ret = spi_flash_probe_bus_cs(plat->sfconfig.bus,
+					     plat->sfconfig.cs,
+					     &plat->flash);
+		if (ret) {
+			debug("fs_loader: Failed to initialize SPI flash at ");
+			debug("%u:%u (error %d)\n", plat->sfconfig.bus,
+			      plat->sfconfig.cs, ret);
+			return -ENODEV;
+		}
+
+		if (!plat->flash)
+			return -EINVAL;
+	}
+#endif
+
+#if CONFIG_IS_ENABLED(DM) && CONFIG_IS_ENABLED(BLK)
 	if (plat->phandlepart.phandle) {
 		ofnode node = ofnode_get_by_phandle(plat->phandlepart.phandle);
 		struct udevice *parent_dev = NULL;
@@ -280,7 +338,7 @@ static int fs_loader_probe(struct udevice *dev)
 	}
 #endif
 
-	return 0;
+	return ret;
 };
 
 static const struct udevice_id fs_loader_ids[] = {
diff --git a/include/fs_loader.h b/include/fs_loader.h
index 5eb5b7ab4a1..1b36f05415a 100644
--- a/include/fs_loader.h
+++ b/include/fs_loader.h
@@ -1,8 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2018 Intel Corporation <www.intel.com>
- *
- * SPDX-License-Identifier:    GPL-2.0
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
+
 #ifndef _FS_LOADER_H_
 #define _FS_LOADER_H_
 
@@ -22,6 +23,31 @@ struct phandle_part {
 	u32 partition;
 };
 
+/**
+ * struct sf_config - A place for storing serial flash configuration
+ *
+ * This holds information about bus, chip-select, and speed and mode of a serial
+ * flash configuration.
+ *
+ * @bus: SPI bus number.
+ * @cs: SPI chip selection.
+ */
+struct sf_config {
+	u32 bus;
+	u32 cs;
+};
+
+/**
+ * enum data_flags - Flag to indicate data as RAW or as filesystem
+ *
+ * DATA_RAW: Data stored as RAW.
+ * DATA_FS: DATA stored as filesystem.
+ */
+enum data_flags {
+	DATA_RAW, /* Stored in raw */
+	DATA_FS,  /* Stored within a file system */
+};
+
 /**
  * struct phandle_part - A place for storing all supported storage devices
  *
@@ -30,11 +56,17 @@ struct phandle_part {
  * @phandlepart: Attribute data for block device.
  * @mtdpart: MTD partition for ubi partition.
  * @ubivol: UBI volume-name for ubifsmount.
+ * @enum data_flags: Data type (RAW or filesystem).
+ * @struct sf_config: Serial flash configuration.
+ * @struct spi_flash: Information about a SPI flash.
  */
 struct device_plat {
 	struct phandle_part phandlepart;
 	char *mtdpart;
 	char *ubivol;
+	enum data_flags data_type;
+	struct sf_config sfconfig;
+	struct udevice *flash;
 };
 
 /**
-- 
2.35.3

