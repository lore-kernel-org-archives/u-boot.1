Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2FECF6498
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 02:19:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B858E88DD4;
	Mon, 30 Sep 2024 04:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rN3CaScP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB98588E1C; Mon, 30 Sep 2024 04:19:22 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E55988DD4
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 04:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Isu8kWVI4qgio6JT6Zlz1kA7b/AT3rtqly/p87tLKGyoew4FutvG15i2RwwrWs+/9iaj9r9Opjm8tQ4LPqFRtp0Hkegm6ot2lEVA6xd2HL5zFpST6ecq5VxS1C4yS688twdZfQvBOaviSrWBO+gbDiICzbf/WpcnTDKQw5FYO8EvPvDmxB0DpAIl4J/giLvTMf+gT9/v+Wtm8mAu8U1S4V/AF2FAtG+cGeW7w5PhO1IMRXIlDzGOz/Q1k0rTIO7+zjXjxOJGcO8TWVHkgpNITqNPgvZjIzHHCzxIKTU5UPD6e8olP8oK3/qCN67AIKChLi59JuKCCN4hvwG+uRdxZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tkFLj3CjlKAkHb+OE+6Z9aYuGdbLEN1elSnH5VcCzk=;
 b=irrBhpH6+cHDjtzJ7Hoq+jC0aAb4J+eh9Iu/58hm7mePMmAQDkhLjQ3tGi+pAuJ8NOSnpnGWcWP5XBQJ2tARsoDGI0krNUbjc77NkqmR/najmeL98/UOkSkfGmfuSoZDxDR1cHJoFQRBi2MKD5TZrh9ofwI3GhdfOfBAc0yc1KRVb//4NWugzJvZKFNExkMNNQabH7sY8AV6CRVlE6ShnfzNcZzyBE/MJtklTQ98ov2gFyatO8P/LDM9nT3HDsDWqX8xUBJV/dSxX0RMxArM9fmHYGrcwtCe82pk5TJw2rS9IwdKXC3AiT7dpXbQmRq1ND5jkQOSTPu1lSv3n/l+xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tkFLj3CjlKAkHb+OE+6Z9aYuGdbLEN1elSnH5VcCzk=;
 b=rN3CaScPaqmAhEwb806i8bx5txSh1TweBKaFK0Ac9y3XlEQFfWxDQhswzhSYcIEYIYPm56YC2R5wbz0HqmfQ/q3fpMsNxq+2WiWkn9eALhVxRE8sw9gSGmsJLXa9d5dVBjfqCI2WEoCn+yuKgBKTum6XAIYbaGBKcgpBUHqAgFb+Wc+HKKq1VfqkrP9OcGhu31jXNOs8dosY11tiMvIFYVKgFBlbBQ8e0W736sPYG6+DiTf54wPx1BhAfwU9QDyx5Igz9aO0YHvTZnrQ8oWbFSE6cQWnsasOKD/yZ9K4FBoGMJWYPqV2zwsLGwaKIYJ5Q9BEX98lCTDEhWgO8Qjj0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8764.eurprd04.prod.outlook.com (2603:10a6:20b:40b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 30 Sep
 2024 02:19:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Mon, 30 Sep 2024
 02:19:16 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: uboot-imx@nxp.com, Joy Zou <joy.zou@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] power: pmic: Support pmic pf0900
Date: Mon, 30 Sep 2024 11:22:42 +0800
Message-Id: <20240930032244.20286-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: d9cedfdf-6e14-4062-d74b-08dce0f64845
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jURS1spqVygklseiPM4a8Jb4ormCWgHbjyl7Uwnz0KCOt/ngMEqTcrVoVcP0?=
 =?us-ascii?Q?DIYNw0AJWSM06s+qUA7KiV3mgiccTc1YnT3t4nEVHYiuNql8E46kAghZzLK6?=
 =?us-ascii?Q?GoUFQxriJ/VyX9sEMTCgUp5jkedwrrwOPloq88E5RVM1jmanvd5jCQpe8poq?=
 =?us-ascii?Q?5umM6BpG6m5RcJ9zCLFLeFXPPgyqyAGRkzG7y6Gghm7n4JeJrCTmO9Wo6jpM?=
 =?us-ascii?Q?G38QNbhkDYIBEENru5RD8yqP0fv91ijch1PEndu0iEdK5I2YrG4QzbJIh5Yx?=
 =?us-ascii?Q?8MucCNep5g39HyEz7mC/o3MFF/ne/HSUWqLS+6ZLiCAN3amMGcA+bcBGQB47?=
 =?us-ascii?Q?nuyaqGZUCUzzhEcqhlN43SQ+825vy4nkgrk5odD/WLkNDzT9tMeWfF1Zm8jT?=
 =?us-ascii?Q?4jDsU5vhXEY6UCvVg5nEdPpbLuc9du1MznvZb3VtoS86B5M+mdIq+6absHtq?=
 =?us-ascii?Q?puCVvJfzm4fz/Agdw6cI2kLu5hlB8x1HK5He33a8gEv4Lbr4vrNURedPbVhD?=
 =?us-ascii?Q?8dojZlsOMQCh7hDJYTC3knLlk7z2I2mnKpWmrV2U5ic+pcuyy3Ct4oG1ATS9?=
 =?us-ascii?Q?HghRMgUgKX7jXcYKf4iNi4yRw25NK/PQ3NRcr8A8E/i5li25owvLU/dsEVjN?=
 =?us-ascii?Q?dLafAG3WoA4gcKK7Jy8bHOGyVcoldqsNTdt+P4UrJjVwgnjstO7KI4woYT6p?=
 =?us-ascii?Q?La976BRBVZF9aZ69Pn/QIFWUTCvLKWNH96F5edlWspl0x97h0inehcDJsLuv?=
 =?us-ascii?Q?BriDD5x5UE0QD8iZoQt3qxfphl8qG7SsMmdIE3QnUZV+O/WCZdYOqxhIeC2U?=
 =?us-ascii?Q?MIYr66/5B0a93emNz/t6TT9KI1yNWSM3VdVqhvCj2aehMZhcPGij0cQCl7+x?=
 =?us-ascii?Q?+81SbQPGAkskMSTUuBcjZkPHe+gszcJs6mcZGR4p/56VblTq2BF8iXiaCjMz?=
 =?us-ascii?Q?gSOd/S/oqG7qGlEija3PfPlyXCNLieqEbFXCwlnqiMaZrPQqfpNyoXJft/7N?=
 =?us-ascii?Q?/TUSBRv7WZIkvKyu/8TFU3EFe3436L+XR2EExinWZ+PfFnyjS5L7U7ua9P78?=
 =?us-ascii?Q?MefBzX54eO2O7T02Aw23tVRO+yxxrhCEoMyAF77NrTVTDfOj74BCy8P+F3C1?=
 =?us-ascii?Q?6aTtpClAbkm9pPNllZksOPzl3s0F++8SkMZtLFsSuyMzwDAPvhg7Q48xykh6?=
 =?us-ascii?Q?h1uVhqafxZoThKg5TFZWGuQmMC1j9gv4bZLb7NJ75QKQVU+Yljf8BB04U3Yj?=
 =?us-ascii?Q?F8AZ4NZeW3hkLvoD5+Rx9oi5PQMs/lwaZJO6KJKoeJCSlxOFStptaf9KghTk?=
 =?us-ascii?Q?YhPzQrs2F7Aws+Gaz59JlQrIJvBe+9HpNjBCejckF0TyIQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FSr9xNcPhfXZ9dqKZvelQKWSeNi/+AE3CoAzZl6JMXL9xpJH4GA/NKg1+pKJ?=
 =?us-ascii?Q?qYUk/yffAoeNwe73a3v/kqWrKaD8dONSd783mH9uC+OEjK26qTTN+JfYLNoN?=
 =?us-ascii?Q?30uUdn3b6XaQYWDkZS9MABLP4pDb+KXPkA5ZhF/4EngBoj5CPxRskvBenXAR?=
 =?us-ascii?Q?e+WrhEJA7/TqdBNjLROu3atw4OpPkgKZbA5liF8su2xSfYqN7wucPSBCxjEQ?=
 =?us-ascii?Q?loqFsKPY+iQrUa1dTPejx/MWSzfmb5qHZwX5oOnul3FiWXORuSmGagSjdLBI?=
 =?us-ascii?Q?Te9oAxNuxOsVJN6wY+n0ecTuEUOVOcan5K6eXjmyQ0Gd5p95wHMm223cTzLa?=
 =?us-ascii?Q?X3efGIBpkGn4keuPLKWy++VaLvKr3C5Z8lyu/DYxnZoSzORWbZf3FehpB+ud?=
 =?us-ascii?Q?BRyyfw5DquYKN2a19tlHEC6BAk06C8HkJ+HtvD5arXbF3n1dWc92IQjsg7/q?=
 =?us-ascii?Q?idkKRbVHQo/kbzxrOWWePCXY2uPSgDeJHZU7Um2As6tzVCOMm+vwxo+xhBFK?=
 =?us-ascii?Q?iXjlkcaEHgaplILnVyEitap3lz2xWYHZlepqj8o5MsHG9fTW0bBD8wcyuNNP?=
 =?us-ascii?Q?P9tpsau6aMWL2r+RyWan+96Ug17bJx23VW3aJrNhKRlHOAWP7ZV9FtSa3/dh?=
 =?us-ascii?Q?Yp/VgZAChFOQrFLLpEFBLl7LrgalKsqDsXubUpQksjFGTXncK5d//f3aG2Jq?=
 =?us-ascii?Q?3w2HyOa8lAelPnxJWF12H1g16GsIA4ZdaKDT5y7TPfVXk5X8/FwxwABX9+5h?=
 =?us-ascii?Q?stimZfT4J48xu+cTVoQp0GMFLR17/r9LFO8tFeni02CdIsr8TlxwtYGqvBSv?=
 =?us-ascii?Q?5MWLoqsfWTReFvdT5ERSv7FNdZpzktDL8d0I57zqZIeGnrYbo+tg53rfUZe0?=
 =?us-ascii?Q?X2BF0VwmoBGyfILI3TA/Emt1dJh6U9IUkLm/5oVHlKgjNlNeTlRwnO1N0yxA?=
 =?us-ascii?Q?MX6oesg7htyVj54L5a37Fp5jCk/LDDi4PspEy4bIovqZ9xEVgQZxFIS+j9Md?=
 =?us-ascii?Q?KYgEffjBrCN5nWBcINOu0AkAXWMDcb+/dcRFBbRm3XIlvBtv0F4WDarqmXUO?=
 =?us-ascii?Q?glK9srHkjjK/ATpQZIglhQmZeHoqzFNbzQrNgIJLqticI0I9mgyHv9AGi6Uq?=
 =?us-ascii?Q?8zKNNih+Z1XSpYSeW76gu8aCBXDLI9I0HJ69r0q3tf5/oW8OXn9MMpbq5cgw?=
 =?us-ascii?Q?EuLXLCjgSDRLWL7A/xmXHllptaVeu5qUPqRVWEBRFKQu+bPQv40n0IWXgQqt?=
 =?us-ascii?Q?nGzPBBjrnDU71BL4fu2w9ghrDPwTkQ3zM2WL4lQmVzAfDYsJqwm3bRaRPKat?=
 =?us-ascii?Q?J3sNZgoyxWdUBshfmp2wysQvlSVnF03TKL4Kj4jV30asSBCLLrXMq8ugrkvs?=
 =?us-ascii?Q?y0OQa/bgr1vgaDMganc8nRpP3lLEJL71vLRKTgxUmp1Em5CXQFx8PE1o+zGT?=
 =?us-ascii?Q?EjBD5tRBj9vZPmnQeckSvLGetCNtePMVW8RV1EJNPoN6tVIhW2prKr9HeWDf?=
 =?us-ascii?Q?qPSozsDxVmztgYqnzngqYibTR9XSTVyH7d8iAqItEx0J43QN2NzQseg4RvJC?=
 =?us-ascii?Q?ZNWcFxO/UIRhZMBkJcWsAp5T59KQqvzWMBa6SKS+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9cedfdf-6e14-4062-d74b-08dce0f64845
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 02:19:16.2603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRouyKXphlXqS7KHsdVAGw8rjZA98pshgm2vtsSYvVDIoH1jy6uGIUpUQdn4r6ZhsrpMC4SGf7eAmhUz7a2IjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8764
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

From: Joy Zou <joy.zou@nxp.com>

Support NXP pmic pf0900

Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/pmic/Kconfig  |  15 ++
 drivers/power/pmic/Makefile |   1 +
 drivers/power/pmic/pf0900.c | 174 +++++++++++++++++++++++
 include/power/pf0900.h      | 269 ++++++++++++++++++++++++++++++++++++
 4 files changed, 459 insertions(+)
 create mode 100644 drivers/power/pmic/pf0900.c
 create mode 100644 include/power/pf0900.h

diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
index 562c1a3b122..1a5ef279ed6 100644
--- a/drivers/power/pmic/Kconfig
+++ b/drivers/power/pmic/Kconfig
@@ -171,6 +171,21 @@ config SPL_DM_PMIC_PCA9450
 	  This config enables implementation of driver-model pmic uclass features
 	  for PMIC PCA9450 in SPL. The driver implements read/write operations.
 
+config DM_PMIC_PF0900
+	bool "Enable Driver Model for PMIC PF0900"
+	depends on DM_I2C
+	help
+	  This config enables implementation of driver-model pmic uclass features
+	  for PMIC PF0900. The driver implements read/write operations.
+
+config SPL_DM_PMIC_PF0900
+	bool "Enable Driver Model for PMIC PF0900 in SPL"
+	depends on SPL_DM_PMIC
+	depends on SPL_DM_I2C
+	help
+	  This config enables implementation of driver-model pmic uclass features
+	  for PMIC PF0900 in SPL. The driver implements read/write operations.
+
 config DM_PMIC_PFUZE100
 	bool "Enable Driver Model for PMIC PFUZE100"
 	---help---
diff --git a/drivers/power/pmic/Makefile b/drivers/power/pmic/Makefile
index a2d59deeed8..0041ab59406 100644
--- a/drivers/power/pmic/Makefile
+++ b/drivers/power/pmic/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_$(SPL_)DM_PMIC_BD71837) += bd71837.o
 obj-$(CONFIG_$(SPL_)DM_PMIC_MP5416) += mp5416.o
 obj-$(CONFIG_$(SPL_)DM_PMIC_PFUZE100) += pfuze100.o
 obj-$(CONFIG_$(SPL_)DM_PMIC_PCA9450) += pca9450.o
+obj-$(CONFIG_$(SPL_)DM_PMIC_PF0900) += pf0900.o
 obj-$(CONFIG_PMIC_S2MPS11) += s2mps11.o
 obj-$(CONFIG_DM_PMIC_SANDBOX) += sandbox.o i2c_pmic_emul.o
 obj-$(CONFIG_PMIC_AB8500) += ab8500.o
diff --git a/drivers/power/pmic/pf0900.c b/drivers/power/pmic/pf0900.c
new file mode 100644
index 00000000000..f38933ad94a
--- /dev/null
+++ b/drivers/power/pmic/pf0900.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2023 NXP
+ */
+
+#include <fdtdec.h>
+#include <errno.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <i2c.h>
+#include <linux/err.h>
+#include <log.h>
+#include <asm/global_data.h>
+#include <asm-generic/gpio.h>
+#include <power/pmic.h>
+#include <power/regulator.h>
+#include <power/pf0900.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static const struct pmic_child_info pmic_children_info[] = {
+	/* VAON */
+	{ .prefix = "V", .driver = PF0900_REGULATOR_DRIVER},
+	/* sw */
+	{ .prefix = "S", .driver = PF0900_REGULATOR_DRIVER},
+	/* ldo */
+	{ .prefix = "L", .driver = PF0900_REGULATOR_DRIVER},
+	{ },
+};
+
+static int pf0900_reg_count(struct udevice *dev)
+{
+	return PF0900_MAX_REGISTER;
+}
+
+static u8 crc8_j1850(u8 *data, u8 length)
+{
+	u8 t_crc;
+	u8 i, j;
+
+	t_crc = 0xFF;
+	for (i = 0; i < length; i++) {
+		t_crc ^= data[i];
+		for (j = 0; j < 8; j++) {
+			if ((t_crc & 0x80) != 0) {
+				t_crc <<= 1;
+				t_crc ^= 0x1D;
+			} else {
+				t_crc <<= 1;
+			}
+		}
+	}
+	return t_crc;
+}
+
+static int pf0900_read(struct udevice *dev, uint reg, u8 *buff,
+		       int len)
+{
+	u8 crcBuf[3];
+	u8 data[2], crc;
+	int ret;
+	struct pf0900_priv *priv = dev_get_priv(dev);
+
+	if (reg < PF0900_MAX_REGISTER) {
+		ret = dm_i2c_read(dev, reg, data,
+				  priv->crc_en ? 2U : 1U);
+		if (ret)
+			return ret;
+		buff[0] = data[0];
+		if (priv->crc_en) {
+			/* Get CRC */
+			crcBuf[0] = priv->addr << 1U | 0x1U;
+			crcBuf[1] = reg;
+			crcBuf[2] = data[0];
+			crc = crc8_j1850(crcBuf, 3U);
+			if (crc != data[1])
+				return -EINVAL;
+		}
+	} else {
+		return -EINVAL;
+	}
+	return ret;
+}
+
+static int pf0900_write(struct udevice *dev, uint reg, const u8 *buff,
+			int len)
+{
+	u8 crcBuf[3];
+	u8 data[2];
+	int ret;
+	struct pf0900_priv *priv = dev_get_priv(dev);
+
+	if (reg < PF0900_MAX_REGISTER) {
+		data[0] = buff[0];
+		if (priv->crc_en) {
+			/* Get CRC */
+			crcBuf[0] = priv->addr << 1U;
+			crcBuf[1] = reg;
+			crcBuf[2] = data[0];
+			data[1] = crc8_j1850(crcBuf, 3U);
+		}
+		/* Write data */
+		ret = dm_i2c_write(dev, reg, data,
+				   priv->crc_en ? 2U : 1U);
+		if (ret)
+			return ret;
+	}
+	return ret;
+}
+
+static int pf0900_bind(struct udevice *dev)
+{
+	int children;
+	ofnode regulators_node;
+
+	regulators_node = dev_read_subnode(dev, "regulators");
+	if (!ofnode_valid(regulators_node)) {
+		debug("%s: %s regulators subnode not found!", __func__,
+		      dev->name);
+		return -ENXIO;
+	}
+
+	children = pmic_bind_children(dev, regulators_node,
+				      pmic_children_info);
+	if (!children)
+		debug("%s: %s - no child found\n", __func__, dev->name);
+
+	/* Always return success for this device */
+	return 0;
+}
+
+static int pf0900_probe(struct udevice *dev)
+{
+	struct pf0900_priv *priv = dev_get_priv(dev);
+	unsigned int reg;
+	u8 dev_id;
+	int ret = 0;
+
+	ret = ofnode_read_u32(dev_ofnode(dev), "reg", &reg);
+	if (ret)
+		return ret;
+	priv->addr = reg;
+
+	if (ofnode_read_bool(dev_ofnode(dev), "i2c-crc-enable"))
+		priv->crc_en = true;
+	ret = pf0900_read(dev, PF0900_REG_DEV_ID, &dev_id, 1);
+	if (ret)
+		return ret;
+	if ((dev_id & 0x1F) == 0)
+		return ret;
+	else
+		return -EINVAL;
+}
+
+static struct dm_pmic_ops pf0900_ops = {
+	.reg_count = pf0900_reg_count,
+	.read = pf0900_read,
+	.write = pf0900_write,
+};
+
+static const struct udevice_id pf0900_ids[] = {
+	{ .compatible = "nxp,pf0900", .data = PF0900_TYPE_PF0900, },
+	{ }
+};
+
+U_BOOT_DRIVER(pmic_pf0900) = {
+	.name = "pf0900 pmic",
+	.id = UCLASS_PMIC,
+	.of_match = pf0900_ids,
+	.bind = pf0900_bind,
+	.probe = pf0900_probe,
+	.ops = &pf0900_ops,
+	.priv_auto = sizeof(struct pf0900_priv),
+};
diff --git a/include/power/pf0900.h b/include/power/pf0900.h
new file mode 100644
index 00000000000..f0d93f1c795
--- /dev/null
+++ b/include/power/pf0900.h
@@ -0,0 +1,269 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2023 NXP
+ */
+
+#ifndef PF0900_H_
+#define PF0900_H_
+
+#define PF0900_REGULATOR_DRIVER "pf0900_regulator"
+
+struct pf0900_priv {
+	u8 addr;
+	bool crc_en;
+};
+
+enum pf0900_chip_type {
+	PF0900_TYPE_PF0900 = 0,
+	PF0900_TYPE_AMOUNT,
+};
+
+enum {
+	PF0900_SW1 = 0,
+	PF0900_SW2,
+	PF0900_SW3,
+	PF0900_SW4,
+	PF0900_SW5,
+	PF0900_LDO1,
+	PF0900_LDO2,
+	PF0900_LDO3,
+	PF0900_VAON,
+	PF0900_REGULATOR_CNT,
+};
+
+enum {
+	PF0900_DVS_LEVEL_RUN = 0,
+	PF0900_DVS_LEVEL_STANDBY,
+	PF0900_DVS_LEVEL_MAX,
+};
+
+#define PF0900_VAON_VOLTAGE_NUM 0x03
+
+#define PF0900_SW1_VOLTAGE_NUM	0x100
+#define PF0900_SW2_VOLTAGE_NUM	0x100
+#define PF0900_SW3_VOLTAGE_NUM	0x100
+#define PF0900_SW4_VOLTAGE_NUM	0x100
+#define PF0900_SW5_VOLTAGE_NUM	0x100
+
+#define PF0900_LDO1_VOLTAGE_NUM	0x20
+#define PF0900_LDO2_VOLTAGE_NUM	0x20
+#define PF0900_LDO3_VOLTAGE_NUM	0x20
+
+enum {
+	PF0900_REG_DEV_ID	    = 0x00,
+	PF0900_REG_DEV_FAM	    = 0x01,
+	PF0900_REG_REV_ID	    = 0x02,
+	PF0900_REG_PROG_ID1	    = 0x03,
+	PF0900_REG_PROG_ID2	    = 0x04,
+	PF0900_REG_SYSTEM_INT	    = 0x05,
+	PF0900_REG_STATUS1_INT	    = 0x06,
+	PF0900_REG_STATUS1_MSK      = 0x07,
+	PF0900_REG_STATUS1_SNS	    = 0x08,
+	PF0900_REG_STATUS2_INT      = 0x09,
+	PF0900_REG_STATUS2_MSK      = 0x0A,
+	PF0900_REG_STATUS2_SNS	    = 0x0B,
+	PF0900_REG_STATUS3_INT      = 0x0C,
+	PF0900_REG_STATUS3_MSK      = 0x0D,
+	PF0900_REG_SW_MODE_INT      = 0x0E,
+	PF0900_REG_SW_MODE_MSK      = 0x0F,
+	PF0900_REG_SW_ILIM_INT      = 0x10,
+	PF0900_REG_SW_ILIM_MSK      = 0x11,
+	PF0900_REG_SW_ILIM_SNS      = 0x12,
+	PF0900_REG_LDO_ILIM_INT     = 0x13,
+	PF0900_REG_LDO_ILIM_MSK     = 0x14,
+	PF0900_REG_LDO_ILIM_SNS     = 0x15,
+	PF0900_REG_SW_UV_INT        = 0x16,
+	PF0900_REG_SW_UV_MSK        = 0x17,
+	PF0900_REG_SW_UV_SNS        = 0x18,
+	PF0900_REG_SW_OV_INT        = 0x19,
+	PF0900_REG_SW_OV_MSK        = 0x1A,
+	PF0900_REG_SW_OV_SNS        = 0x1B,
+	PF0900_REG_LDO_UV_INT       = 0x1C,
+	PF0900_REG_LDO_UV_MSK       = 0x1D,
+	PF0900_REG_LDO_UV_SNS       = 0x1E,
+	PF0900_REG_LDO_OV_INT       = 0x1F,
+	PF0900_REG_LDO_OV_MSK       = 0x20,
+	PF0900_REG_LDO_OV_SNS       = 0x21,
+	PF0900_REG_PWRON_INT        = 0x22,
+	PF0900_REG_IO_INT           = 0x24,
+	PF0900_REG_IO_MSK           = 0x25,
+	PF0900_REG_IO_SNS           = 0x26,
+	PF0900_REG_IOSHORT_SNS      = 0x27,
+	PF0900_REG_ABIST_OV1        = 0x28,
+	PF0900_REG_ABIST_OV2        = 0x29,
+	PF0900_REG_ABIST_UV1        = 0x2A,
+	PF0900_REG_ABIST_UV2        = 0x2B,
+	PF0900_REG_ABIST_IO         = 0x2C,
+	PF0900_REG_TEST_FLAGS       = 0x2D,
+	PF0900_REG_HFAULT_FLAGS     = 0x2E,
+	PF0900_REG_FAULT_FLAGS      = 0x2F,
+	PF0900_REG_FS0B_CFG         = 0x30,
+	PF0900_REG_FCCU_CFG         = 0x31,
+	PF0900_REG_RSTB_CFG1        = 0x32,
+	PF0900_REG_SYSTEM_CMD       = 0x33,
+	PF0900_REG_FS0B_CMD         = 0x34,
+	PF0900_REG_SECURE_WR1       = 0x35,
+	PF0900_REG_SECURE_WR2       = 0x36,
+	PF0900_REG_VMON_CFG1        = 0x37,
+	PF0900_REG_SYS_CFG1         = 0x38,
+	PF0900_REG_GPO_CFG          = 0x39,
+	PF0900_REG_GPO_CTRL         = 0x3A,
+	PF0900_REG_PWRUP_CFG        = 0x3B,
+	PF0900_REG_RSTB_PWRUP       = 0x3C,
+	PF0900_REG_GPIO1_PWRUP      = 0x3D,
+	PF0900_REG_GPIO2_PWRUP      = 0x3E,
+	PF0900_REG_GPIO3_PWRUP      = 0x3F,
+	PF0900_REG_GPIO4_PWRUP      = 0x40,
+	PF0900_REG_VMON1_PWRUP      = 0x41,
+	PF0900_REG_VMON2_PWRUP      = 0x42,
+	PF0900_REG_SW1_PWRUP        = 0x43,
+	PF0900_REG_SW2_PWRUP        = 0x44,
+	PF0900_REG_SW3_PWRUP        = 0x45,
+	PF0900_REG_SW4_PWRUP        = 0x46,
+	PF0900_REG_SW5_PWRUP        = 0x47,
+	PF0900_REG_LDO1_PWRUP       = 0x48,
+	PF0900_REG_LDO2_PWRUP       = 0x49,
+	PF0900_REG_LDO3_PWRUP       = 0x4A,
+	PF0900_REG_VAON_PWRUP       = 0x4B,
+	PF0900_REG_FREQ_CTRL        = 0x4C,
+	PF0900_REG_PWRON_CFG        = 0x4D,
+	PF0900_REG_WD_CTRL1         = 0x4E,
+	PF0900_REG_WD_CTRL2         = 0x4F,
+	PF0900_REG_WD_CFG1          = 0x50,
+	PF0900_REG_WD_CFG2          = 0x51,
+	PF0900_REG_WD_CNT1          = 0x52,
+	PF0900_REG_WD_CNT2          = 0x53,
+	PF0900_REG_FAULT_CFG        = 0x54,
+	PF0900_REG_FAULT_CNT        = 0x55,
+	PF0900_REG_DFS_CNT          = 0x56,
+	PF0900_REG_AMUX_CFG         = 0x57,
+	PF0900_REG_VMON1_RUN_CFG    = 0x58,
+	PF0900_REG_VMON1_STBY_CFG   = 0x59,
+	PF0900_REG_VMON1_CTRL       = 0x5A,
+	PF0900_REG_VMON2_RUN_CFG    = 0x5B,
+	PF0900_REG_VMON2_STBY_CFG   = 0x5C,
+	PF0900_REG_VMON2_CTRL       = 0x5D,
+	PF0900_REG_SW1_VRUN         = 0x5E,
+	PF0900_REG_SW1_VSTBY        = 0x5F,
+	PF0900_REG_SW1_MODE         = 0x60,
+	PF0900_REG_SW1_CFG1         = 0x61,
+	PF0900_REG_SW1_CFG2         = 0x62,
+	PF0900_REG_SW2_VRUN         = 0x63,
+	PF0900_REG_SW2_VSTBY        = 0x64,
+	PF0900_REG_SW2_MODE         = 0x65,
+	PF0900_REG_SW2_CFG1         = 0x66,
+	PF0900_REG_SW2_CFG2         = 0x67,
+	PF0900_REG_SW3_VRUN         = 0x68,
+	PF0900_REG_SW3_VSTBY        = 0x69,
+	PF0900_REG_SW3_MODE         = 0x6A,
+	PF0900_REG_SW3_CFG1         = 0x6B,
+	PF0900_REG_SW3_CFG2         = 0x6C,
+	PF0900_REG_SW4_VRUN         = 0x6D,
+	PF0900_REG_SW4_VSTBY        = 0x6E,
+	PF0900_REG_SW4_MODE         = 0x6F,
+	PF0900_REG_SW4_CFG1         = 0x70,
+	PF0900_REG_SW4_CFG2         = 0x71,
+	PF0900_REG_SW5_VRUN         = 0x72,
+	PF0900_REG_SW5_VSTBY        = 0x73,
+	PF0900_REG_SW5_MODE         = 0x74,
+	PF0900_REG_SW5_CFG1         = 0x75,
+	PF0900_REG_SW5_CFG2         = 0x76,
+	PF0900_REG_LDO1_RUN         = 0x77,
+	PF0900_REG_LDO1_STBY        = 0x78,
+	PF0900_REG_LDO1_CFG2        = 0x79,
+	PF0900_REG_LDO2_RUN         = 0x7A,
+	PF0900_REG_LDO2_STBY        = 0x7B,
+	PF0900_REG_LDO2_CFG2        = 0x7C,
+	PF0900_REG_LDO3_RUN         = 0x7D,
+	PF0900_REG_LDO3_STBY        = 0x7E,
+	PF0900_REG_LDO3_CFG2        = 0x7F,
+	PF0900_REG_VAON_CFG1        = 0x80,
+	PF0900_REG_VAON_CFG2        = 0x81,
+	PF0900_REG_SYS_DIAG         = 0x82,
+	PF0900_MAX_REGISTER,
+};
+
+/* PF0900 SW MODE */
+#define SW_RUN_MODE_OFF			0x00
+#define SW_RUN_MODE_PWM			0x01
+#define SW_RUN_MODE_PFM			0x02
+#define SW_STBY_MODE_OFF		0x00
+#define SW_STBY_MODE_PWM		0x04
+#define SW_STBY_MODE_PFM		0x08
+
+/* PF0900 SW MODE MASK */
+#define SW_RUN_MODE_MASK		0x03
+#define SW_STBY_MODE_MASK		0x0c
+
+/* PF0900 SW VRUN MASK */
+#define SW_VRUN_MASK			0xFF
+#define SW_STBY_MASK			0xFF
+
+/* PF0900_REG_VAON_CFG1 bits */
+#define VAON_MASK			0x03
+#define VAON_1P8V			0x01
+
+/* PF0900_REG_SWX_CFG1 MASK */
+#define SW_RAMP_MASK			0x18
+
+/* PF0900_REG_LDO1_RUN MASK */
+#define VLDO1_RUN_MASK			0x1F
+#define LDO1_RUN_EN_MASK		0x20
+#define LDO1_STBY_EN_MASK		0x20
+
+/* PF0900_REG_LDO2_RUN MASK */
+#define VLDO2_RUN_MASK			0x1F
+#define LDO2_RUN_EN_MASK		0x20
+#define LDO2_STBY_EN_MASK		0x20
+
+/* PF0900_REG_LDO3_RUN MASK */
+#define VLDO3_RUN_MASK			0x1F
+#define LDO3_RUN_EN_MASK		0x20
+#define LDO3_STBY_EN_MASK		0x20
+
+/* PF0900_REG_GPO_CTRL MASK */
+#define GPO1_RUN_MASK			0x1
+#define GPO2_RUN_MASK			0x2
+#define GPO3_RUN_MASK			0x4
+#define GPO4_RUN_MASK			0x8
+#define GPO1_STBY_MASK			0x10
+#define GPO2_STBY_MASK			0x20
+#define GPO3_STBY_MASK			0x40
+#define GPO4_STBY_MASK			0x80
+
+/* PF0900_REG_STSTEM_INT bits */
+#define IRQ_EWARN			0x80
+#define IRQ_GPIO			0x40
+#define IRQ_OV				0x20
+#define IRQ_UV				0x10
+#define IRQ_ILIM			0x08
+#define IRQ_MODE			0x04
+#define IRQ_STATUS2			0x02
+#define IRQ_STATUS1			0x01
+
+/* PF0900_REG_STATUS1_INT bits */
+#define IRQ_SDWN			0x80
+#define IRQ_FREQ_RDY			0x40
+#define IRQ_DCRC			0x20
+#define IRQ_I2C_CRC			0x10
+#define IRQ_PWRUP			0x08
+#define IRQ_PWRDN			0x04
+#define IRQ_FSYNC_FLT			0x02
+#define IRQ_VIN_OV			0x01
+
+/* PF0900_REG_STATUS2_INT bits */
+#define IRQ_VANA_OV			0x80
+#define IRQ_VDIG_OV			0x40
+#define IRQ_BGMON			0x20
+#define IRQ_CLKMON			0x10
+#define IRQ_THERM_155			0x08
+#define IRQ_THERM_140			0x04
+#define IRQ_THERM_125			0x02
+#define IRQ_THERM_110			0x01
+
+/* PF0900_REG_STATUS3_INT bits */
+#define IRQ_BAD_CMD			0x04
+#define IRQ_LBIST_DONE			0x02
+#define IRQ_SHS				0x01
+
+#endif
-- 
2.35.3

