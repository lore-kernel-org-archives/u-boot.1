Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5EACA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 04:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE53A802C1;
	Tue, 19 Aug 2025 06:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Ko0q85g/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F27080422; Tue, 19 Aug 2025 06:14:34 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1210C8006D
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 06:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qY2Cc8AJwhn76zyaebCeBRQuc/gmoharaG3gpeoeumImNADNcoRIeqZU3svzLPcuWYu6Zmrai/nWG4lXqi11NDc/Uwx9FuXjxj3oyK8MsH5yq2Jgm9kJ7C90Jea0GHY5fM29RuShhxv2mmGWZLw4xvs4MVIqXZxguOmCKmtTjIa+7sNYI88dDmy4bJGLMnCdRp/gb2go7ySotbYPbeHmQHY9Mv7DjcAXDB5Hj9JlvDCoYJ59sEvPstyzUvFQTFelzz3gZd73sZpeLO7QF38yW+SCaxgoAGUbYWz0iY5Ka81E7wuNro7ZmBXYXwVqPK8xcpJf0oMQm+WBc/gucVGEeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3tqEG+bT/IdKWdJwcP/iA6Ec/2dGMdLyfGmzgEPCeQ=;
 b=P58aQKX+4LEca3H8YWSVKgsQ4uBe1tfxvXT3QLmDamKLI+cIjmZDjpKmIIRd03DXydqB0Dj4nKqpGYdunSEa+wmvxLyM0mRKVIrLT63048JtPu7B8b7UPiASSMAyC7j0lua4cr5VyI2POFV1KCqoL/EUnQNekhbVR2wyvAXNaXYCQ3rfAKbmvxkwOWdZmUnJ7SgDMm0lYrfW/3fqbNiYNxCS8GW+LJETBb3JEUSQbJlVKkxJKhwFIB0ipgcZfV9erdTcafMIY2BdAI7lLUPHQvLzY5EpyVQNCnE1cAI6Sycs4llD+hR+wJ1pB65TjJGENPOqu7D/LqBgx3mS+WrHWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3tqEG+bT/IdKWdJwcP/iA6Ec/2dGMdLyfGmzgEPCeQ=;
 b=Ko0q85g/7KkKS+8xuErbNtZIlX3FICDkIKTdoTEKgHMW4Xb8xmA/WG8eNFf/E7ppzCtrBFOlybogq8EzGMga6RPuJ/tCjz83b5ifPd4hH5mYUS2GhwG1fa4nQrFnZqQ+QHINW3wpEvg+eYH/E0HVTuntIVMU96RMAgM6E4ZP6QxUFcpgeVL6W5B/8+qwWM/hBfhURiuwrTCA+o11Cz9dk/jPrTAalLurCoeS1dy7zMKc2Euib7bKgpTv5F1iRFhHiJhztfJOMEMlTOGTZJGb2NLHq4OLsK6vwO9oR1dA7v6vGIMeFKDi5Wnj8cPO6R/2QxBIvbL48ZtvA6vDSpwjjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by MW4PR03MB6948.namprd03.prod.outlook.com (2603:10b6:303:1bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 04:14:28 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 04:14:28 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH] misc: fs_loader: Add QSPI RAW partition loading support
Date: Mon, 18 Aug 2025 21:14:11 -0700
Message-Id: <20250819041411.21036-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0084.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::29) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|MW4PR03MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 67442755-02de-4fb0-097c-08ddded6e396
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1Ht/4yag1t13Lo8agZJxqqf7+U0k8OhzZYRqLunk2RyqbsjlEpGe5drpxJ+U?=
 =?us-ascii?Q?yae0s6kOECAm+Qxmi4cOSxpcc8qDJr7bzVbE8rgzs8Me+01i8UiYNliDfvXh?=
 =?us-ascii?Q?hCrppl1L3VrDn/10c0CBQVSx268lSIsojem11KZLNaUJQ+ddtLvXDOa3kL+y?=
 =?us-ascii?Q?WCR/QBQitWD0vlbefbzWLlkX/oqTlOWG80Vn5952oIGkJjv9lT+An9NwPOXw?=
 =?us-ascii?Q?8O+8AZQOKb7UA5k71UEIRVwZ+CujtiCTboil3Svwuq5W1phHe5Gf6LHDmj2D?=
 =?us-ascii?Q?rgIKAboHj1EkvCJBoDkwfeUeXJNctXaI49GUo6xoS0v4qm8cOb8MlAtOyPDH?=
 =?us-ascii?Q?6owF3k8MyG8Re593bEoAY2sTxvdhI2vWLmLuACPCYlNZwQ7SXr4tCFS+wL6P?=
 =?us-ascii?Q?n1dFg+LLfaZfPYHJZSFOODWnNiLumTyNurZgE9hmdnMlZp8cfmphFZdbiobQ?=
 =?us-ascii?Q?kcTRYfZHgHPNQbcH3RInwI/Rmhrt9scaQOVWfiTXvFmY1lgGfDBtObwW/RZ+?=
 =?us-ascii?Q?jjQCTfBZdHY7Dpvh3IiA9TzLwmKTfEZaAlGIwYB+ph3ikdby8g8AlvGToTjY?=
 =?us-ascii?Q?o4Ew9tvQ338SwIs0794cSOG2kRhoO7B6+2rxc532x6Rn+I1SOpjZjHBPaeV8?=
 =?us-ascii?Q?lorfGY74P9eJ13xVFCAOF2+XpWKFlLIPlKKtz41rWN63rqBkPofrUtIjC3iT?=
 =?us-ascii?Q?HOIU7xsBNpYDN6Z6uj/fNoL7A9E+X9oun27Odmf5T2JoLqjPePBPuNNTOYbi?=
 =?us-ascii?Q?PRYoehXNoQ+2oPOkiL0zC3EfGB1iraNKKsnkglOOyIv6nffsxlPZvu/GLYKG?=
 =?us-ascii?Q?rS9Cq/qYymlYZYvAetqTyC8DYBGaqHpeClPp+xfq8sMnUiFU4KYu8+qmT/Hg?=
 =?us-ascii?Q?F8QyYZLxZEcowrffzWLJg+I8D5BAppWNfQfLR8Q/s2V7+FPQxrhWkf5J7tvV?=
 =?us-ascii?Q?IJYoxu240IgLnnQjYtjPV2/6nZbkwUduiJ3/slbtwqsai5hQRebdyP/1Vt/4?=
 =?us-ascii?Q?1S2Sv0NbPMkG0exphLGmaOu4X1a2QNYTtqCsrrZu+zmyXluXJm5H2uN0KAdA?=
 =?us-ascii?Q?s/cmmJLAnSrdYsRrFweK98akxXhZgOei18BhlslrKzE4zRLzayXWfCiWH7x0?=
 =?us-ascii?Q?rXHYpYSH5LYl0dLzchbcbIbArmmUWQ2MeWJ6ZERm7jISzJSJ+tBlFxLZfbLl?=
 =?us-ascii?Q?CWcWYiMtTXct4H8ZoWhrALjiqRKoJwnFnWL0OfMxnQReBeRakd99JkXo31O2?=
 =?us-ascii?Q?MOARzVdFtRDVnTkwaau4pVSasgwigE0lLuGocVoUjy8IhjA78H6hVJDVIyHB?=
 =?us-ascii?Q?wX4he9LwgK7JTXbXpF1Q1Ox6f3NjnvFlNqJyNrJzn+uvvHi+E5PsIPrhuCGh?=
 =?us-ascii?Q?ydX3621M0M+GLiPrsDvnQ3J97CBROfjrbpRSqomQfo9cSBUwQrP/NbVyCKd3?=
 =?us-ascii?Q?LWu6kb9DjBE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VswyKTt9AosSBGO6x2hwfn1Bk7OE0AzlD9VbHfV617+J7V6GYNE3dYCv9Mzf?=
 =?us-ascii?Q?tZdzkdxy5hmnMsmlyDq8PWGpac1rWo0zajfY/R62xmwGMQtn6lDk0QR3CVR5?=
 =?us-ascii?Q?QULbt3LsVzEM7A8HDIhiBXE+cJjxua4raV3if+iPXgi1s0zubn6MWVZewNrW?=
 =?us-ascii?Q?7PAEz6Yn9Tl+JAt+4NkXlffXzS9d6oBCPT9mDQewDObdlVsLWF3VUl4f4J8U?=
 =?us-ascii?Q?z5cipwnEZrr24X5pFXgMPpt9H3hV5SJvRl5cn+SJkxCdR9hWu1C/mDG/Q0r+?=
 =?us-ascii?Q?x9CoGr9Y71pr+AIsu1Y/OQmn6kU8X8jgl5fn7EK1H8qc5JRFHuKbLofxJu1A?=
 =?us-ascii?Q?4wetp+byd74j58aIBOvMBRiXHUjtqBLK5FTIySljOROZxIRcV6QW8yWIvQE/?=
 =?us-ascii?Q?Sgm9XF0HKrors4sobVXzPR3aPOYtJWD/zhVy4mQ5RNcq3qsWPNk44BFAorEv?=
 =?us-ascii?Q?yysh+S2ZeP7U1AnwRiN2DCRCTNgFurJ7OE23Psxt2t1592A1Gc+zPOGZkji0?=
 =?us-ascii?Q?JICUC5SKkDmdftXrohh/cgSSnQDeIJvzJeRjgzTLUmfDb0Ot0e77omiUH8Vc?=
 =?us-ascii?Q?aINLiX4f18J8DpzEFc82fn9q7KQ4KwlU+U2lkkSGmrmvtFWmM9QRnL1Gl+Gg?=
 =?us-ascii?Q?H024L83FfLrOPH6b6vT6AfFuuwRUBJLPpm2vU30sV/NnXSjAihfW/tUD3gSM?=
 =?us-ascii?Q?8sRSzNb/DBjPnUyOx2sZZCr+zqdDdHQy+xM/OVxKrwZDSWc2/xD+ReUO9n5T?=
 =?us-ascii?Q?jC1hDA31fvUCJpuDPpJnAqDon5yH3FepYREs9qsCBloMVe+Hvlo3hzhr1/Dy?=
 =?us-ascii?Q?iy4FdIDxj00dLxv2Ht9Eb/aMQHngpv7A4EN7T+HJJ6LyuzdSu6CSH6pP5oMX?=
 =?us-ascii?Q?bUyQ+j6tsC2Xa9l3eAEztNO30aWPAO8UlC9FkQ168Z7zDD4+sNnniNfYzG4d?=
 =?us-ascii?Q?3z3qtzyqiQS6vSY2r4BkG/vrLFhKe1GiWkUhszGQKcVjavcdXAGh5xyPXG05?=
 =?us-ascii?Q?sL23/BjnMuBrTMi6UqoqZijHm54U2T88/pzCY2fLtGrpzqRKeQ8IUMn/7e7Y?=
 =?us-ascii?Q?Uz1aO4dH4IBN0wXoevf6psS+864ujUv7EWJ6PYhyt8+NZwFbibURcB310Xdt?=
 =?us-ascii?Q?af1N9o9lVuv8vHIG9dC/Sb/TSagR4qiBZmNYoOKGubQsQfJOKBMrYVv9GfdR?=
 =?us-ascii?Q?KJIAyS/31QbI7mbMiqQW+ljuxA1VfIKdDzapT74ETL3kOImxQXa/lSjnhI/V?=
 =?us-ascii?Q?Gir1q9OJK9csQfnQXfr03vx1Mv+RiqEPJt89/9shnG5ob7G0pZUzxznnVTM0?=
 =?us-ascii?Q?j2g0HuAiCt3fpkrpF0wKukJ2wOuaR0jXeqTdE0Vet62WGxf4DbdWekr1Or01?=
 =?us-ascii?Q?eq4zUyu4x3KroWxErrMyf/8T0sD65ExBEW3W0kx/zlbgVtoGHKnheBGjws7N?=
 =?us-ascii?Q?psPLW1/fq77XYqEqlm1UXzFm78JZaZgX6NVElhKYS+G+ySpYh6rExiXe/y1x?=
 =?us-ascii?Q?4WeL8M3nd973iPWF1Jo5qZ03Mecbd6eQ6GEXDxMWQlUwfEUxi/igXltuEACR?=
 =?us-ascii?Q?MMzedAtYZqi7PeiWMbBhR6fipBztt+YemaKvpJrZtlRnDYQCs+PfSVWBYXxD?=
 =?us-ascii?Q?TKdFuW0gdBL+MSznNe2oslU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67442755-02de-4fb0-097c-08ddded6e396
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 04:14:28.1379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /moMP0QYg8WP/fCEkLgyY8ouNM92F3EDkt3I3pWggzKnC9G8yIObDG695JbKCR2I1unpMCaO2JLDWrcqjH8J3SW0y7lvGnoDlx8ZxIt0xqQxZoRF1pi0JikFTUUoAnAJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6948
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
index 66803f4b997..931443048e5 100644
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
+					(void *)map_to_sysmem(firmwarep->data));
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
+			      sfconfig.cs, ret);
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

