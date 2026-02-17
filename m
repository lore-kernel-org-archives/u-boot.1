Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA88CE6816B
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 11:22:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A8A883C72;
	Tue, 17 Feb 2026 12:22:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AMCc55Q2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4D8083D3D; Tue, 17 Feb 2026 12:22:15 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFD7F83CB5
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 12:22:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIPBADtLXrrY42xMQff8PE/WSYMUtVZvCaZMySZAouM8Qofzfp+/b5mdFc/RUO1L80ehDnuIgUNB7nMnj+ThSKmrmLoaT01sy+2JDh2fIWb6b8GbPI6HCbuwhxAI1Y65xC/fKCB2Q+hUuep4XNV45BdfSQht5/0FoeiaEVzvYuSZXM0h9GwzhUwEs2pm6FvJXIHv+4alOSljYykUZx7bqGfEbKWXwDYpBUZ3pGqmMXhChaWefE9Xg9zpN8JHwEA6FZfMrdgy8s/vBLZrw//kCT5aGqPJ/2Oageu/N0yEhx5dliXKASLLR10/L6qt+7lTw54o7Ylgsq8jeuhK2osInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTr7/5U4LkdjsolSmSpes5fx/ioDitjINwskAyuPJvs=;
 b=TVqP36UtK7y9rL+3LL4V74qnYEjYwB1+O/3khIi3ZC4k34qMjeMRty7u2+AL2CyxdWktQVlp/PuM9fcMSZospkSXYvIMu2BHOdn25pM3oJKRr80ivA2qAEf3LGz02hK2SR41pihK4oXwfFPL/KonRepogxJ+93gc214d/i0BlvYhcn6e+30bNalZJTAcxBBMTy3EJ1KBr03Qngtx7+4KBPwaF68oLGiyJlSwATZrvEaE9Dm4amuT0wFRPn3VfseSqgkK8cADAWDZ8AlgwX/32UJVPs4nJrJvf7saT6ilpHQLgMlv0CDHaN9GIxANejguP3INWQY21nN76rfu2BXx/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTr7/5U4LkdjsolSmSpes5fx/ioDitjINwskAyuPJvs=;
 b=AMCc55Q2WWm8SsIftZTimzhboq/neTRZSNKCk88lbnz5M0fa8mCrwco9WlL6PoTE414Qm42zCjS/JVPD4vEtUpPe1Uwcj/oUq0fVd0cNZUg2EXWknyC85m1VjcRVdaNK6rY8pPYKnKE55dg04WCQ6WSRpWf+sXgYKzQIeg2mZAo=
Received: from PH0P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::6) by
 DM3PPFA927664FB.namprd10.prod.outlook.com (2603:10b6:f:fc00::c3f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 11:22:06 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::9d) by PH0P220CA0001.outlook.office365.com
 (2603:10b6:510:d3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 11:22:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 11:22:04 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 05:22:04 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 05:22:03 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 05:22:03 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.51.206] (may be
 forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61HBLutN3263329;
 Tue, 17 Feb 2026 05:22:00 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <jagan@amarulasolutions.com>, <trini@konsulko.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <boon.khai.ng@altera.com>, <a-dutta@ti.com>, <s-k6@ti.com>,
 <gehariprasath@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 1/7] common: spl: mtd: Add support for loading images from MTD
Date: Tue, 17 Feb 2026 16:51:50 +0530
Message-ID: <20260217112156.272154-2-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217112156.272154-1-a-dutta@ti.com>
References: <20260217112156.272154-1-a-dutta@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|DM3PPFA927664FB:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3fccb4-0a85-43d8-432a-08de6e16c757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mG8eRjjbaojK+9BulPSFARRhJHlq4Pva2Cv5IfptzWB7muDXs0FcUwmgKBNN?=
 =?us-ascii?Q?9RrgqRSz0KGEh1ct9g5EFzMVmHo7o5JT49d4wOnH2QaE12a5HayowIUlcFwT?=
 =?us-ascii?Q?J9DqV4eX2PAQASKrtpHATxl9rgJMBwvM9nv/qYj7CFQBsZfAOj/fVVetX9YQ?=
 =?us-ascii?Q?cu0uZ+6PMcSBUj0FBLUFslZiJ53jDPeQgh6KbpSuumE64Fd3uyAcAO/xvJ1Q?=
 =?us-ascii?Q?XHeFomqZQVlEH17cAm9YRXrz1tLdA5p30kGewauf1qMCHlAkbRDi+7u58jys?=
 =?us-ascii?Q?ielVdZ0cnIKqb2vy4kGhlg2dI81OWATMPeqQzG28C0XLdUyoo30H5hOhhfMy?=
 =?us-ascii?Q?n++Q9Xq1ldsi7a83Np+o/Umj6hrZxxaLKmOy2rUT2WiO+neu3hQD3Cv61qK0?=
 =?us-ascii?Q?x4gUWFSf/mnEMTB0G06cGRim+UgOKuDzOJkWoH5ANFdNEn3wsV2GhEG/x3mJ?=
 =?us-ascii?Q?3mrRVYMkUEhQqmGSXF8Di45efGYSnt9qUIWAvN7cF0WCyrItH1Q63jyvDKJs?=
 =?us-ascii?Q?+f2WN32hTdqM6QPKdwvNhH8Cdwmxaer911r2h7CB8RvwvaTvlSMeZ2vKBqrq?=
 =?us-ascii?Q?jOChnZl5XYt0mUX2Yy2dnqOXPIsDzjU9OlQEKlBVunqtr5iL3U0XOA2oqR4l?=
 =?us-ascii?Q?O2YMDj1qH5tfSD5IJyJPAXAGPsAmkTqNua38Ijseg3BY/s4+/ehh8R85HeEP?=
 =?us-ascii?Q?7cxmVTcPuirTocHauW681af3fevnEj7lYsYWnDeooUiZpUaZsTp0ZaWkEqIh?=
 =?us-ascii?Q?qHDyc4W7yJKd2bSlsvhzClyQ9miFJtAh5dtaXV0rk7uQwsB1uqM3LOnJRun2?=
 =?us-ascii?Q?MCzvoekx5LM9F7XuyINH7lvON2zrzQ8UxyFiQ17OmCibeKkSkLjIwZQ/Dy0V?=
 =?us-ascii?Q?0pdFL1Gc1SEFpm63xl8Squ+++jRYm2ZlQMqOzHRWradqQHJ/HfFLBTmNtYGQ?=
 =?us-ascii?Q?CPWsRdFnJ0TNRlrDMRuEkLU9+Dhy9z0pwB7xUHsXws7pea9OS28jFh3UhW8G?=
 =?us-ascii?Q?LhV5CJ2s3IJ8tz8GzrAoyy3x/ttenO4ZM40cz4swhtR9ff1iYeeHle1t3r5y?=
 =?us-ascii?Q?e0KvkoHZdNazCVajaEdV4+roa1Bn7qsv/Pes7X8PHjHydAOXrGYWq9N7jfxK?=
 =?us-ascii?Q?tx94GjKiBWpBlt79ppTT50yfAVtdDAljnHeYFPcgnBZ5LgiPmYUw3lzxukM0?=
 =?us-ascii?Q?bK84BHyyD9WW239WVb3haG21hxHDMcH+zA7qREJ1LcPNYYEHlz2Y/f9Dlj5g?=
 =?us-ascii?Q?QS1UDndnqNiXYlutUoGwB0NFo4dxXmLQEuRZbe/GHHSvjprtT0FmLdfk+zFw?=
 =?us-ascii?Q?0Sg9EHoIB5qme74mC9yTsf6TLQFgzbCgf9DePF2jaqzQSyghb0ldkNEz7NDX?=
 =?us-ascii?Q?9xPQgydEMmdQuGaBRn1H+Wm0W5m9n9A03SmNkw5zNzX3TjCBHJ4CsIe/iZ37?=
 =?us-ascii?Q?LbREwytZL+1Tr7pmwFjBfvwaUd/f5RrsPkU3gy/3VrzfIoGXSmlfLVS/1ao7?=
 =?us-ascii?Q?ancot5i7Pd9ZdLBoP/0t3bmzskU9Uupr90sX8AhRoOt6sGzi6fWn/3C+i8mk?=
 =?us-ascii?Q?3hp0PLDi0cP0AsPWx8+UKdewS/NLQ3J/v1MyNjNYDn8mS2LaF49MfIOaZ9RF?=
 =?us-ascii?Q?rA=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R2wlGLY4+fxiesWPIa3q8zSsNPdScduwawDXfWCqHrimOPeYoAafdi2tZNoHinASsxN8JQzQ/h9arCPcq9kcZVPz7OKlO3aKF7mA9AiMWqfRyYqs0xFL4rGrZrTeYcElBKk4PD1CT5e7X3aDvYTnirHO7u7nfX0xzyF4SFcEYlg9NFzBMD3kCqHoBsoT/rjDryLX3mCaqLivHy8KPPUL7dgcabzllf+SNLZK37vsnxds5wqvHQfkMSh38QBo7BrSFBopKwaK2/E++d5kSMJvozbxqDrNcqD79cZ0nrR1UK6+YZAdDdLIC5xd/Y0LJozlLIMx6GtW7j93vyN2Lmkb9BIMkq/usiKab1U4JSFp2Ug0/LBqrjyPptip4NlMAL39b6+VgXiTWBfGppTEtFoEMAixuQApe0FBPMND57Ws1vB+XAB/XOzQbnbuuv0nfMBO
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 11:22:04.5666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3fccb4-0a85-43d8-432a-08de6e16c757
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFA927664FB
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

From: Apurva Nandan <a-nandan@ti.com>

Introduce support for using MTD subsystem for loading images from
memory flashes. This will provide the support of using mtd functions
which are abstracted over the type of flash being used, to load the
boot images from the flash.

Currently, add support for only SPI NAND flashes. This can be extended
to all other flash types, when required.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 common/spl/spl_mtd.c      | 90 +++++++++++++++++++++++++++++++++++++++
 common/spl/spl_mtd_nand.c | 31 ++++++++++++++
 include/spl.h             | 18 ++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 common/spl/spl_mtd.c
 create mode 100644 common/spl/spl_mtd_nand.c

diff --git a/common/spl/spl_mtd.c b/common/spl/spl_mtd.c
new file mode 100644
index 00000000000..341e1a73392
--- /dev/null
+++ b/common/spl/spl_mtd.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * FIT image loader functions using MTD read
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - http://www.ti.com/
+ *	Apurva Nandan <a-nandan@ti.com>
+ */
+#include <config.h>
+#include <image.h>
+#include <log.h>
+#include <spl.h>
+#include <asm/io.h>
+#include <mtd.h>
+
+uint32_t __weak spl_mtd_get_uboot_offs(void)
+{
+	return CONFIG_SYS_MTD_U_BOOT_OFFS;
+}
+
+static ulong spl_mtd_fit_read(struct spl_load_info *load, ulong offs,
+			      ulong size, void *dst)
+{
+	struct mtd_info *mtd = load->priv;
+	int err;
+	size_t ret_len;
+
+	err = mtd_read(mtd, offs, size, &ret_len, dst);
+	if (!err)
+		return ret_len;
+
+	return 0;
+}
+
+struct mtd_info *spl_prepare_mtd(uint boot_device)
+{
+	struct mtd_info *mtd = NULL;
+
+	mtd_probe_devices();
+
+	switch (boot_device) {
+	case BOOT_DEVICE_SPINAND:
+		mtd = get_mtd_device_nm("spi-nand0");
+		break;
+	default:
+		puts(PHASE_PROMPT "Unsupported MTD Boot Device!\n");
+		break;
+	}
+
+	return mtd;
+}
+
+int spl_mtd_load(struct spl_image_info *spl_image,
+		 struct mtd_info *mtd, struct spl_boot_device *bootdev)
+{
+	int err;
+	struct legacy_img_hdr *header;
+	__maybe_unused struct spl_load_info load;
+	size_t ret_len;
+
+	header = spl_get_load_buffer(0, sizeof(*header));
+
+	err = mtd_read(mtd, spl_mtd_get_uboot_offs(), sizeof(*header),
+		       &ret_len, (void *)header);
+	if (err)
+		return err;
+
+	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
+	    image_get_magic(header) == FDT_MAGIC) {
+		debug("Found FIT\n");
+		load.priv = mtd;
+		load.bl_len = 1;
+		load.read = spl_mtd_fit_read;
+		return spl_load_simple_fit(spl_image, &load,
+					   spl_mtd_get_uboot_offs(), header);
+	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER)) {
+		load.priv = mtd;
+		load.bl_len = 1;
+		load.read = spl_mtd_fit_read;
+		return spl_load_imx_container(spl_image, &load,
+					      spl_mtd_get_uboot_offs());
+	} else {
+		err = spl_parse_image_header(spl_image, bootdev, header);
+		if (err)
+			return err;
+		return mtd_read(mtd, spl_mtd_get_uboot_offs(), spl_image->size,
+				&ret_len, (void *)(ulong)spl_image->load_addr);
+	}
+
+	return -EINVAL;
+}
diff --git a/common/spl/spl_mtd_nand.c b/common/spl/spl_mtd_nand.c
new file mode 100644
index 00000000000..9bc6ff86ee8
--- /dev/null
+++ b/common/spl/spl_mtd_nand.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * FIT image loader using MTD read
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - http://www.ti.com/
+ *	Anurag Dutta <a-dutta@ti.com>
+ */
+#include <config.h>
+#include <image.h>
+#include <log.h>
+#include <spl.h>
+#include <asm/io.h>
+#include <mtd.h>
+
+static int spl_mtd_load_image(struct spl_image_info *spl_image,
+			      struct spl_boot_device *bootdev)
+{
+	struct mtd_info *mtd;
+	int ret;
+
+	mtd = spl_prepare_mtd(BOOT_DEVICE_SPINAND);
+	if (IS_ERR_OR_NULL(mtd)) {
+		printf("MTD device %s not found, ret %ld\n", "spi-nand",
+		       PTR_ERR(mtd));
+		return -EINVAL;
+	}
+
+	return spl_mtd_load(spl_image, mtd, bootdev);
+}
+
+SPL_LOAD_IMAGE_METHOD("SPINAND", 0, BOOT_DEVICE_SPINAND, spl_mtd_load_image);
diff --git a/include/spl.h b/include/spl.h
index 06dc28362d3..c4442be4fdb 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -1219,4 +1219,22 @@ int spl_reloc_prepare(struct spl_image_info *image, ulong *addrp);
  */
 int spl_reloc_jump(struct spl_image_info *image, spl_jump_to_image_t func);
 
+/* SPL MTD functions */
+/**
+ * spl_prepare_mtd() - Prepares the mtd for the corresponidng boot device
+ *
+ * @boot_device: A number indicating the BOOT_DEVICE type
+ */
+struct mtd_info *spl_prepare_mtd(uint boot_device);
+
+/**
+ * spl_mtd_load() - FIT Image loader
+ *
+ * @spl_image: SPL image to jump to
+ * @mtd: MTD device descriptor with geometry, flags, and read/write/erase function pointers
+ * @bootdev: boot device used by SPL
+ */
+int spl_mtd_load(struct spl_image_info *spl_image, struct mtd_info *mtd,
+		 struct spl_boot_device *bootdev);
+
 #endif
-- 
2.34.1

