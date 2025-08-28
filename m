Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8E9CA0FF2
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 05:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3D87831D5;
	Thu, 28 Aug 2025 07:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="b2PJ3lzN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F039A83106; Thu, 28 Aug 2025 07:51:41 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9E36831BB
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 07:51:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ambn2NnTljayD4+jKHdWbP8NdRs5KE2qouSe7FNebUbizBuZiE5pTmsMk99h/wrQca7pgCcWhA7StyWIfbUdRUpxCGd29Uoa5l3g+eIuv3HCgRpQEgpmCVtqxw/UfVI4cAnIC+rJ5iTVHb++FLGC/FIoSchtwaKjNQlvPG4soU9rNjVfpaBDZam8GI4Y2MZ4ahucFJIHVBr7XeOEP7rR+9M8l1CtgKUbBOdKho7V9rkd88S//1LLql5M0HSoud04vY+t+itMP/uNPf7s8aQ4ywRljmpOAIlgDdirzEXOw9xK1AjA1iWwuydKQo7EwsQqDBip1kaLN/iRwIOQGUuTRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gReClfx6kBxfBX7bpxny/qPDmJYnLqKNyypqhJ1ZBBU=;
 b=Ic4L36+kJebm1GlLpXc+spY/6MCP1CYXmIqK6uAl8a640lSaGtbHMeiY6e3/I2awN5nuk5s/ZlKDiWNgFaK6UXUg+sRylJ5ZAKJGc7jYr4kgHzrYANoJwbQkXUj3JV0/1f0qd5Wq+QO4n2LGVQ9DcFhXZ0WNQIX88Ygdy5cixu0xw0zY7Yu4JUcrTad5wv+UdAJz5x/E6KdCNBNSAQsPn/BYd/Oxajyc6/f7Karxs8uHEJVoXD8irskXyBsn7UZ0h5cQgW/zkTj1gpZM6MWt6qXYZeoNbeApsQiHmRuXnwv9cZH/CtQuDW1VJpH4rS7y3M8N2ivZ96MZQa3WokkQaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gReClfx6kBxfBX7bpxny/qPDmJYnLqKNyypqhJ1ZBBU=;
 b=b2PJ3lzNG+eGl2IJzmy0wU7r1okjzcgG2nwVSGc/32MKNA59ofWwCX4n+J8Lev9h8rTqzsyOv0pTXQtcDrIkx0oI5pENnQ+ilANeluAbN3JwdPiC5zJL+QYD8+/WTnsuFkYZfqLW3k8fvcPrNDOjkcoU7sSzC9cl1aEBehoDmh8LoPNAcMlus7UGrgLKEqc+elZE3MmD531zwLfLmG1yH3Qqt3GTRVteSoow6eJYV+1WrfqL5wR8jn1QI8Y0RZRjBsXPr4ap73TX7STLRlN3i8uwdyxmWJCc5EVYzvDo05mM9SDjR0IOQ+EResEckiL6tGzHYJ5S3GfclZe1+NSzAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by SA3PR03MB7304.namprd03.prod.outlook.com (2603:10b6:806:2fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Thu, 28 Aug
 2025 05:51:33 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9073.014; Thu, 28 Aug 2025
 05:51:33 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v3 1/2] misc: fs_loader: Add QSPI RAW partition loading support
Date: Wed, 27 Aug 2025 22:51:18 -0700
Message-Id: <20250828055119.25815-2-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250828055119.25815-1-nareshkumar.ravulapalli@altera.com>
References: <20250828055119.25815-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::10) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|SA3PR03MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: ed8ad4f0-f83c-4d62-423b-08dde5f6f16a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pv+XrX5wdTEOUT6rXsa4TYHtd8VySdOMhSyjB7Sgu/MmEmh6JOaPOUn3kuP1?=
 =?us-ascii?Q?cSf9Sshs07ZsxYhqvtpvem7/KY6n8C/i3LmAuyXLIgM78gyIUi1DFSNaFpUs?=
 =?us-ascii?Q?UdD04Aia1FWKrv/v4lLVACQTf6VSdI/weU0fBs9M/IK6/boRTvCTNSNYmdKJ?=
 =?us-ascii?Q?MNuakJ6tzXRPtj/keItBDaQFyrjBXTHuERhxpS0Wx3OsFvyeLB8ABzmCpdZY?=
 =?us-ascii?Q?MSOK25sfUSauCgGm8A4cpX+DVeSgQZUrQDvRf2JIgjdoPKvfl8D3xI7Fqfsm?=
 =?us-ascii?Q?K0RnGMT2aIPvF/fr2XToSkXa51vhK22f5cjD/cOzrtsp1KBr4KSuICR2ZfAQ?=
 =?us-ascii?Q?qRVJuY3dpUlpV8tHBmcfAem7K8Z/9u/2q8spHlUHLlFa/UBCRRp5ILC29vC6?=
 =?us-ascii?Q?cJwoLzJ5xGZo/czoVBZFptBZwSwxgQ9oKsJfsbTROJ31BDa4iZtEqNY7GBPF?=
 =?us-ascii?Q?58ShHyOoYvtIteEkfv8oFxg4F4zzm7tP211pnNZzoAuQJ3QBSfC9sX4Y2Sdf?=
 =?us-ascii?Q?SX5u1DSxu2gq3SQC+dOjOo/S1Ku/9pANtVOxtvtDiQ2vZt/aAT0L55TxBKRX?=
 =?us-ascii?Q?uC/BIGMFgke+RaGVZJuKWn6zppR94LSniMA8b137ftJ0EQH10IVT9GtRraOe?=
 =?us-ascii?Q?sfrVVWrPNKp3+cVAKCvVf5e5l5qQHNaArWiCHxggOHl626IhvAGPI88i2tfl?=
 =?us-ascii?Q?JfKvGf0vDM6JEKKa5KGz8/WggidRH1BldUQzs20BM3aEArJbePN6H7r4kBgU?=
 =?us-ascii?Q?IrRXZ1swFK6E/+BTd1jajhy6Eas3mbrlCuVEkRAt8BNvZqzjYslAdDhbpfeB?=
 =?us-ascii?Q?r44ZojWVWeJnZWzKLhcUk3mA8D1vGONnsOi4lLUtuibpGZ995c8wUDfRRpk7?=
 =?us-ascii?Q?nBJoD9+XmyUB+Lkz+CivJFXFRTkMAfL5GEBdWEipQpCJxBE+2lI/9LkEbV+U?=
 =?us-ascii?Q?2fo6YPSysx8sYBNuCYCKxssr97g7GZSf7Li1BoQ90/RtMKJNooXjHA6y6muY?=
 =?us-ascii?Q?lNHEei7WMaM3UCLbjLElMeZ5u+4QXk6RFMCwOs6HM2ThdF+8KPWRnUaveo5u?=
 =?us-ascii?Q?Oupft/ypUR8RBOBQcyI9BN52I4XHVcjHTAIxKvVZ91R5uh4ycu92vWcdSKR/?=
 =?us-ascii?Q?zF4WBvgvzFvz+6h95ncjQfAwGn1pUJ013p5ZM4Xq8U31111bc1hYVv7jK9ps?=
 =?us-ascii?Q?f/22noC/qAnQPaRuLTQtzB09CqsrAlDPBZ5fK0TN93D3XTx7ro94hiksZkc7?=
 =?us-ascii?Q?plSJtJHh7kvjOFzSx2kHsz74MOBVdgivzffwB/wy4g40iuqmWNLIx+hD1N0t?=
 =?us-ascii?Q?Cp+O6XEPMyrD2IMXU32iChk0ByIs2ieUAJh0+GuHqe1Ji4JKl0D43ibtvLfH?=
 =?us-ascii?Q?ICoeiJ4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?icUDgzGAgbNPEmuYRRswF6fRaIL7EprHt3y5VEeFkEsQsZprdLTK1If9Cl1H?=
 =?us-ascii?Q?dyrUGKQ/GYuIUcQRyw6E2bpAgBopzSbnIUpqu3iswxdOra7rhun7yD/TjBiB?=
 =?us-ascii?Q?Kgzz77CXCsA/RX0q3WIrlQfogjSLAP92331qcVOCfTTO3+NmB/6Ogw2AblvU?=
 =?us-ascii?Q?0rR0fz/lojRrJCSjncwggUn5LGZXTArmwmjySd1an3MMgY9ruQVUNtlRmuA/?=
 =?us-ascii?Q?Y8eadI//grIp0jE3RZCbcKNd25SSbIYS01p4qIGlW9EGivS2B2Dd9LTa8x4p?=
 =?us-ascii?Q?BrFTP0/5ZDIduTaWg6Tc5QyufmKXjM2wVCiNGnuqFHtj/lWRIkqIdaPCAUxU?=
 =?us-ascii?Q?1+tCcUaoDTJUGDbBF3xZz+uFIaPS1LrcZ6n6lB4ERT0XAcJTC9w8Cd2kA+m1?=
 =?us-ascii?Q?wRyRwWYnNn0vUHJC5K1U5c6y/hVtdwHvFDoHvYLIhr+NTnKGFlox8c08UGOb?=
 =?us-ascii?Q?qEnTBMNAxLQoaeW013ib0brdMRs8vE7UMW5NppQEj+BHIYh7bMkQUU5ASUuq?=
 =?us-ascii?Q?CqHoAPV1Hei4i2+yK4Qp8F6QCkFDsSMWGfRKTfu93Z4awzXjfRfNFuW7ap2T?=
 =?us-ascii?Q?lyIwjcfFRphMVoWHrhubyxYocJzU+SlV5dPRn1CxWezjYs2X/dRq2psrnrdL?=
 =?us-ascii?Q?H9rkk5OuMNWripunBuQw5j1K1ZgTsZ93plA4Xu9/GfG08PAH736sUxql+3FW?=
 =?us-ascii?Q?A1aElOrd4HA6bHo1ErHwDpi+sF+XjEOeWXZZJHeG7ANCHTorSpS+MgbKUcVK?=
 =?us-ascii?Q?r++vKOGPoZWLnqwCMPMCPmbWLXvTcKZQbMf8JFIWOJoxwkjS7UEwwtHTfmh/?=
 =?us-ascii?Q?YnCetdr5g9krCRlrGlvYCqWZDuIMs+5SWn3H8OE03uK9qeKs2JFnwzxpOtxM?=
 =?us-ascii?Q?Ga51qA56AJKeSbCU2LDtlemT+CPNpC97qM5FBNR5s6ZinGjsSxgy08bbXFUW?=
 =?us-ascii?Q?JnX8N06zijwYy6rNw7wvfIYXefJ2PXEr7UPu7sTbqneCOp+wWJc0bDThKV8H?=
 =?us-ascii?Q?bJOnEJvC2rlwaxl33YM9y6gbO5IHpH7p1SU+MGXe/9yb0ncvx3aqqB9pvyBv?=
 =?us-ascii?Q?rND8GDInwppCvKmA4TmdaRoFE2Oc2yVa3ELSEzCa5GEEPf8Mn4asT2PZ9HN0?=
 =?us-ascii?Q?5zvAyqbcxGyKp0OXoAW31hU9ARvyiz0cHgvLHMKVB6K8Cc6kaWgr+7lzmqXK?=
 =?us-ascii?Q?pgV4am1gp/d1LSvuKqyfM+vFEXq4x+JQobGV4yh7iQW/xaRmrHj7hAxP/S7Z?=
 =?us-ascii?Q?bT53g/51TTujTupmJNUpAA/uNMKDnXWBJtCyJa7QIsTcZNBvMpr2ov2iEDb2?=
 =?us-ascii?Q?OnKdI1Qg4LAAH7j9VXO+3JAtScIc3fzLVHdfcfUJqkrt7Hu9sbU/pdKB0SfX?=
 =?us-ascii?Q?40uptZlYN0a21rP0zmhPnFzZQJZ1HiBl50nrUG8xaJdBvi7ww4rK0+O3isLS?=
 =?us-ascii?Q?lblMffvP1FHRihMug2JKGjENU33gjGMXPuJUbTFDDdhq+YY8i9AiwfvY8wws?=
 =?us-ascii?Q?i0njMqTTEnL9m3M+6nVH1Ni6HFGV7CRcx7V5yOvpiksAGmiilM5TokGNbbqS?=
 =?us-ascii?Q?4rPi5q1Q0vpIGkiJJeCy2b0cNcPs1IVAmasvs/FY1qvELlLG2ZducCV3mPjn?=
 =?us-ascii?Q?15NLoKeJ07xlLyDQsGd7tJI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8ad4f0-f83c-4d62-423b-08dde5f6f16a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 05:51:33.4275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gs8GcM3XNYk1kdOq3IXPmq+43KVGAkHXgRDDrELuvocM+X8t2q7CbBtr0T9Ou2xj5re6c4V+1nzwfZaQ2JF4CmWhosLIzi1FJOsM5AakUX675LPHlc3QlhYDRQBZnn7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7304
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
 drivers/misc/fs_loader.c | 113 ++++++++++++++++++++++++++++++---------
 include/fs_loader.h      |  36 ++++++++++++-
 2 files changed, 121 insertions(+), 28 deletions(-)

diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index 66803f4b997..12b8d370a7d 100644
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
 
@@ -250,6 +279,18 @@ static int fs_loader_of_to_plat(struct udevice *dev)
 
 		plat->ubivol = (char *)ofnode_read_string(
 				 fs_loader_node, "ubivol");
+
+		if (!ofnode_read_u32_array(fs_loader_node, "sfconfig",
+					   sfconfig, 2)) {
+			plat->data_type = DATA_RAW;
+			log_warning("%s: Chosen RAW data type DOESN'T have "
+				    "built-in data integrity support\n",
+				    __func__);
+			plat->sfconfig.bus = sfconfig[0];
+			plat->sfconfig.cs = sfconfig[1];
+		} else {
+			plat->data_type = DATA_FS;
+		}
 	}
 
 	return 0;
@@ -257,30 +298,50 @@ static int fs_loader_of_to_plat(struct udevice *dev)
 
 static int fs_loader_probe(struct udevice *dev)
 {
-#if CONFIG_IS_ENABLED(DM) && CONFIG_IS_ENABLED(BLK)
-	int ret;
+	int ret = 0;
 	struct device_plat *plat = dev_get_plat(dev);
 
-	if (plat->phandlepart.phandle) {
-		ofnode node = ofnode_get_by_phandle(plat->phandlepart.phandle);
-		struct udevice *parent_dev = NULL;
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
 
-		ret = device_get_global_by_ofnode(node, &parent_dev);
-		if (!ret) {
-			struct udevice *dev;
+		if (!plat->flash)
+			return -EINVAL;
+	}
+#endif
+
+	if (IS_ENABLED(CONFIG_DM) && IS_ENABLED(CONFIG_BLK)) {
+		if (plat->phandlepart.phandle) {
+			ofnode node = ofnode_get_by_phandle(plat->phandlepart.phandle);
+			struct udevice *parent_dev = NULL;
+
+			ret = device_get_global_by_ofnode(node, &parent_dev);
+			if (!ret) {
+				struct udevice *dev;
 
-			ret = blk_get_from_parent(parent_dev, &dev);
-			if (ret) {
-				debug("fs_loader: No block device: %d\n",
-					ret);
+				ret = blk_get_from_parent(parent_dev, &dev);
+				if (ret) {
+					debug("fs_loader: No block device: %d\n",
+					      ret);
 
-				return ret;
+					return ret;
+				}
 			}
 		}
 	}
-#endif
 
-	return 0;
+	return ret;
 };
 
 static const struct udevice_id fs_loader_ids[] = {
diff --git a/include/fs_loader.h b/include/fs_loader.h
index 5eb5b7ab4a1..69f55dfabac 100644
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
+ * DATA_RAW: Data stored as RAW; doesn't have built-in data integrity support
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

