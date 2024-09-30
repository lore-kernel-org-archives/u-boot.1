Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62A5CF6499
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 02:52:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD59988E6E;
	Mon, 30 Sep 2024 04:52:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tXYmwdfy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9925A88DBA; Mon, 30 Sep 2024 04:52:14 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9091F88E1C
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 04:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjEG2R27zynR9F5t9C8+9kHXRtJ0+VVUcCJzLt/V3QTu6Q/A2khJPOkSl0iK/4PLgRoNRiN6Gsl22k2ifzrn5shxfMrOm49YrOFk2lRo9HGfBVEvCa/Dmmb0X/+dOS48/Jrsek/dgwqbHvlZkhA1N+a1L/3P5i/BSoAbEKhOt8lAuv9f2orBprhAGse1Ju6E/h72f073tHYgkaSEq8Rx4vvn2l6DTtORtY4NIkNh8cNjD3CkNzGRVdgfaGq4zzm6w4w3qsZhL4BsRs2dkyEsAAkZ7J0p/s+eSBIlqh95BuP9Cgz7Cvga5rilUJ7aXlWwnYuTGkzOUDOWZoiNmWt9KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upqG9JAkU004nZ3uFh2EJIvdkRVex+/urhvVgnLTYaw=;
 b=My9nLpQSfbEHiRvVjNYAs0Bm6bNKX5a5QualfkJXCLESQxfhOtE3SLn3a2sz5knDK/SH4orxPzCU2NshhYZ/vCPqJ+L3fdvOJB0/dox7NHrVR+36Rp2BypBr3gLGRAGS+pxx3og1L2iNl//PtZRnJJhuWYqNlOeixwLJuJIWrnsVFRmkw4N7IC6Pm8912invMQwABOzgiSFYxfKv3La8a1sFQRGrmOKCtShUhYoacgHVXe8BgnB7BcTZskoBmYYAXJfPGXrhqC//3/KooOrSPqHMD98kd2WchKv0oRO0JZj1MLHdGJucHLQKkhsmNMujMwzBVSg8N1+xlF0ASY5NMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upqG9JAkU004nZ3uFh2EJIvdkRVex+/urhvVgnLTYaw=;
 b=tXYmwdfybTMLYDUU9GyEii4XQVFO5nrGFwVoZPlMVlCjrKAUwFdL1Q5KAfX/vwCc2gZK1AfbVxmD4sIa0HJhMnW8Yq6cr97ts+XpzycatPxai4xRxZP6rxgxofRN8dBuQhsGDAj6FfKFXh3t+MVij+5DmxvemH9nLY1YPG79/Z/CAIMBEwbkyThElvwekorxGFI9JdJLhhLrOG6j6sMl6+mLdE2MMLYOmzrvJ7wM3ckCzw9J+/inoK4apoiFxIK6P1EKJoGKmMiQMlHhCbGGc8rRHV/aecRHBEHCPJqER/Q8OdmJhprYXzMgj59JCCZH+kvg1OfsMhNnVUzu4HImkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8712.eurprd04.prod.outlook.com (2603:10a6:10:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 30 Sep
 2024 02:52:08 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Mon, 30 Sep 2024
 02:52:08 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: uboot-imx@nxp.com, Joy Zou <joy.zou@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/4] power: pmic: ADD PMIC PF9453 support
Date: Mon, 30 Sep 2024 11:55:29 +0800
Message-Id: <20240930035531.27079-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240930035531.27079-1-peng.fan@oss.nxp.com>
References: <20240930035531.27079-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b352770-18d2-490f-d687-08dce0fae016
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ULCt8k8zKEjieVA3exn87Dv9t8xqeLYaGve+u0HxGohNh8BgayIIXEnYJQ+8?=
 =?us-ascii?Q?rRibN10aG6SuyEoQSQ+RJ3M8/HOcHbkNHBLFMJUYQ6kudkt9u4vwlLyPZugt?=
 =?us-ascii?Q?jOfzjOrd2qkfH3oUa9EZoW7U5iiV4rrht2NJUy0+1PZphpaFijNMIFGyIOr8?=
 =?us-ascii?Q?DJii0kb3TLsfU6ramC2VJCeCfQp323YX8xtfDuMWoMUvpZOSgMH6te1teOz8?=
 =?us-ascii?Q?jYrcby4wqj0d/E78I+1628oD7/3+xhWv337ESApCTzAy6IHxMGgPsluDSbgO?=
 =?us-ascii?Q?7Ry9xb6+G37XtpowtkNo9uVhzx49oyySujAbZDGqrnJ0QSN8HrqJ+Iikyy8g?=
 =?us-ascii?Q?AYM/yukU742AaMB2kp5Nm+bcpSPvbfFAjoAwJjR/3uoac5iQ217pD2SNnyoV?=
 =?us-ascii?Q?RDBydTJJ1kj3/coyRR4DXTSMJngAKCX8LyAzHUDrMYT6p5Xv0iX96q4j8MsM?=
 =?us-ascii?Q?nTPzlO5Atyi0j0CZ6hjmXVInlM/M/ZGeHJL0f19pSW0w3UAtLHB8d5LWRzGU?=
 =?us-ascii?Q?VY4RXzA7RMyjgAL/shMsl8zXsU1DETsrhvaJOBXJqFg23cpuctEJLEbWvD7p?=
 =?us-ascii?Q?jmp2octGI/ddvEb5Ax7lRCEdSxC5ecAZCKvr424+h8emv96sSsSYYE4S+l+s?=
 =?us-ascii?Q?bI4oobee8whchcaF7lSdosWsjO3zC8QpVw3Hm8vdmHnZBfwNACBxB4whmsPP?=
 =?us-ascii?Q?jAIPLEK2LyfFSj+k0d8VUM9VDys6LReQcxr7zQug+SfezBR03OVtoMUcg4ft?=
 =?us-ascii?Q?WdM2YcJIwVv4UAMwpcbkWdgkPYpt7tvkpvoMFJ/XIYsKBSeT3j3YdFFoWE5V?=
 =?us-ascii?Q?6nZictSyeOE0WbTMMeDR/9OsGdPKjPx9FFacPUQ9EIX4TKKLVrZ5MHIpZebj?=
 =?us-ascii?Q?YOIa6ATfksjcncpWng+qudfe0SxJWTh9AmasoL8RbR/wnCYthe/zDM0WuuHZ?=
 =?us-ascii?Q?z09XVe889cwgTgJI/zmnMM6VIwmzWlhIqCczs9Tah7cTweySKJMyRAKNj8y7?=
 =?us-ascii?Q?PnKP+E+E0AXjv+301l+/35quyNI8B+YlWi2ucpRIxbhCtqkf+kivMOQ5S5R1?=
 =?us-ascii?Q?KlFt2XoBgww0d5LAg21Nv9J39brQnXB7HYePOw9oO4Z4VGVwKgu0+JQuHT2A?=
 =?us-ascii?Q?0a1p+gOW1PgWVe8VkVrVmqFsWI098hE1j/PTbJGCzf6jbtENIrXavmQLrz0P?=
 =?us-ascii?Q?Oxbp5+7b+rbFAVc+21RtQfxahr6hEqRopJ6Na1OWIAsLUriRXB6AwDbfKfZZ?=
 =?us-ascii?Q?Q0CENgf4zxAhb030e/GwqxYmHrWvt2ukNLBCtHfWnCvdSMk6vhlR5n45aggp?=
 =?us-ascii?Q?iUX6NGeqEtYW54yXojxPGrb2vcJGIrQtgK1rsB8iwWnh/w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SH4aIdv1eD1kUzt+CRMd7Zqt+D7Uu1N/cwK5G8nc7hUkKVMXXIVdQgZsRIWr?=
 =?us-ascii?Q?LxAfhHzouJNPqzFUgxsDz9UmqDSdJ1l8aI0lbp6sX4I7x0hsB3ydX5JroPP+?=
 =?us-ascii?Q?AOPImwKlfrciBMo3sERzN5EekKG6F4vaaYGLEDs2CXfhJ0fKZ5ibN9Uk0Bvz?=
 =?us-ascii?Q?Ty7LGenX+M9bRwq14cxGin2dUEohIl8eDoMUc38XF2sccniYqmCx0jS9m++b?=
 =?us-ascii?Q?NKIcK2YsWYxsIx2CfbsdFvfmI0evo7ScRSumpA7Ip3MNHWzr39U52IeussnY?=
 =?us-ascii?Q?eE0r2xx1ViLd/Ewe2sLdYFnhjqOai3f6PIZCDwoT9/iR9XlxKbusqafa81uj?=
 =?us-ascii?Q?Kwo6sg3m7gac8X0sEcNusNo0bvK3rKwerzBD1VsaFmb9SlhIgM3l1Nasd283?=
 =?us-ascii?Q?bb6YihnQX2NMAuV0rwfvCW5uD+z2X2ZKljBEe4pkA4UknJRMGhTDrNBJfwlh?=
 =?us-ascii?Q?GgjHjreY5Me7cVe398UL17uIutv5EmNrhfVJe3WRJuBsbieWeb+neVfBdYYh?=
 =?us-ascii?Q?hVpB0LTMoSBeI4CQGIRVOFeuSHjGZVuE83UeYFAPLqROfn91ji3+9ptsx5oD?=
 =?us-ascii?Q?tX0lkly87I5CsAubJrg+cO04IFsF2qM3o4PUkpKIoYK32wdMVvzZlAQiokDf?=
 =?us-ascii?Q?qwV0WVSP8A/FxgZ94Fz+lLU62JmqgwY083jZXzkYjI8a3mrz4t1xsBXg5Ygj?=
 =?us-ascii?Q?NCRnW/pPaFqKvkYCAfbcHlJqvd303BbfwmsCFTLo4m4VwzwMQ6IJYf+UnhcM?=
 =?us-ascii?Q?vKxULvrD0xq4yGeGgQZshPiLEPNvH7vKCKBEkB2SsUK+OgEVwOq9mK9ZsYMd?=
 =?us-ascii?Q?YvcYTunpiz6hL2EI39PdHC7Qk1U8glNGXNvT+V1p4V48r+eT4HjI6QQY83eh?=
 =?us-ascii?Q?jMyc6hI4h1UycNEOMQMUROzLUqasenLGEvWNatn7BrcQtYTeHAE/u0gc0QNX?=
 =?us-ascii?Q?MpSUIGr15DEQWRvbeFwYiG0F9YmM92SqObKnnXPXZBVWGCat65j1nst9rbVB?=
 =?us-ascii?Q?ldVxwm1vsMN5Ul3jp6Trq3J7H9WgJUAunzG3duPReYNYZ/6wwz5WK4tO9ipQ?=
 =?us-ascii?Q?rEFTYaPIYcy/yEzV80SLB6Nb3l1c+TXI5x47X6xxTjA0qGIiIwMDoPFHWE3y?=
 =?us-ascii?Q?XKRI1QbC5UUFi0xW6faEnl/HwW0xhCMJoTZ95ak2PlabU4UEfaji2I/LtSHF?=
 =?us-ascii?Q?QsdJgKvgGN/VST0IGeCAkx9mcnip5Rq/tLZ/i6nQfg2bGKd8t25ke0tO7ZDp?=
 =?us-ascii?Q?tL3pDRkvM09GAZ8o4mKqxQTS/I7Mr+3LFXH2tzQCLUk9SOaTUOYKqOaEbckk?=
 =?us-ascii?Q?Zh6aTZAK+usAFkVJSbhTItHiZihGsCxxU0dMLaDO5X+ZujdbapjRBMqmfE6e?=
 =?us-ascii?Q?+jPxoOWbXOvQ4gR7y6PMwHA6EBmnb8JRb5Y4Xqopac7ooHJZ8r/DuYWcdgyw?=
 =?us-ascii?Q?7oeARFLgkGYULzXX6SeigmtmWZlEP329McaSNICdqaaoSeziy9O23s2qULT6?=
 =?us-ascii?Q?QiIsBAP/xdP7q0j48p6zz3naJQD6ZWhNfmECcx7eCzK3OceXldV3v0Z7UV78?=
 =?us-ascii?Q?R/zM1lv7gNNvWMwyvqYytRuyb17k5y4Rgg0XYoSO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b352770-18d2-490f-d687-08dce0fae016
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 02:52:08.7352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJ4o2ZlMAQhoNDFquokxbuWX686b29XK2gpNpFYDRp9/vtf96B4hxnAgwu/m5SU1jIyyy1VShUBgVqvqs/h7Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8712
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

Support NXP PMIC pf9453.

Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/pmic/Kconfig  |  15 ++++
 drivers/power/pmic/Makefile |   1 +
 drivers/power/pmic/pf9453.c | 173 ++++++++++++++++++++++++++++++++++++
 include/power/pf9453.h      |  71 +++++++++++++++
 4 files changed, 260 insertions(+)
 create mode 100644 drivers/power/pmic/pf9453.c
 create mode 100644 include/power/pf9453.h

diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
index 420c4099937..42e405901de 100644
--- a/drivers/power/pmic/Kconfig
+++ b/drivers/power/pmic/Kconfig
@@ -171,6 +171,21 @@ config SPL_DM_PMIC_PCA9450
 	  This config enables implementation of driver-model pmic uclass features
 	  for PMIC PCA9450 in SPL. The driver implements read/write operations.
 
+config DM_PMIC_PF9453
+	bool "Enable Driver Model for PMIC PF9453"
+	depends on DM_I2C
+	help
+	  This config enables implementation of driver-model pmic uclass features
+	  for PMIC PF9453. The driver implements read/write operations.
+
+config SPL_DM_PMIC_PF9453
+	bool "Enable Driver Model for PMIC PF9453 in SPL"
+	depends on SPL_DM_PMIC
+	depends on SPL_DM_I2C
+	help
+	  This config enables implementation of driver-model pmic uclass features
+	  for PMIC PF9453 in SPL. The driver implements read/write operations.
+
 config DM_PMIC_PF0900
 	bool "Enable Driver Model for PMIC PF0900"
 	depends on DM_I2C
diff --git a/drivers/power/pmic/Makefile b/drivers/power/pmic/Makefile
index 74ace69daf5..7cee4ee0582 100644
--- a/drivers/power/pmic/Makefile
+++ b/drivers/power/pmic/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_$(SPL_)DM_PMIC_BD71837) += bd71837.o
 obj-$(CONFIG_$(SPL_)DM_PMIC_MP5416) += mp5416.o
 obj-$(CONFIG_$(SPL_)DM_PMIC_PFUZE100) += pfuze100.o
 obj-$(CONFIG_$(SPL_)DM_PMIC_PCA9450) += pca9450.o
+obj-$(CONFIG_$(SPL_)DM_PMIC_PF9453) += pf9453.o
 obj-$(CONFIG_$(SPL_)DM_PMIC_PF0900) += pf0900.o
 obj-$(CONFIG_$(SPL_)DM_PMIC_PF5300) += pf5300.o
 obj-$(CONFIG_PMIC_S2MPS11) += s2mps11.o
diff --git a/drivers/power/pmic/pf9453.c b/drivers/power/pmic/pf9453.c
new file mode 100644
index 00000000000..893a7771d0e
--- /dev/null
+++ b/drivers/power/pmic/pf9453.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <asm/global_data.h>
+#include <asm-generic/gpio.h>
+#include <fdtdec.h>
+#include <errno.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <i2c.h>
+#include <linux/err.h>
+#include <log.h>
+#include <power/pmic.h>
+#include <power/regulator.h>
+#include <power/pf9453.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static const struct pmic_child_info pmic_children_info[] = {
+	/* buck */
+	{ .prefix = "b", .driver = PF9453_REGULATOR_DRIVER},
+	{ .prefix = "B", .driver = PF9453_REGULATOR_DRIVER},
+	/* ldo */
+	{ .prefix = "l", .driver = PF9453_REGULATOR_DRIVER},
+	{ .prefix = "L", .driver = PF9453_REGULATOR_DRIVER},
+	{ },
+};
+
+struct pf9453_priv {
+	struct gpio_desc *sd_vsel_gpio;
+};
+
+static int pf9453_reg_count(struct udevice *dev)
+{
+	return PF9453_REG_NUM;
+}
+
+static bool is_reg_protect(uint reg)
+{
+	switch (reg) {
+	case PF9453_BUCK1OUT:
+	case PF9453_BUCK2OUT:
+	case PF9453_BUCK3OUT:
+	case PF9453_BUCK4OUT:
+	case PF9453_LDO1OUT_L:
+	case PF9453_LDO1OUT_H:
+	case PF9453_LDO2OUT:
+	case PF9453_LDOSNVS_CFG1:
+	case PF9453_BUCK2OUT_MAX_LIMIT:
+	case PF9453_BUCK2OUT_MIN_LIMIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int pf9453_write(struct udevice *dev, uint reg, const uint8_t *buff,
+			 int len)
+{
+	bool is_pro;
+	u32 val = PF9453_UNLOCK_KEY;
+
+	is_pro = is_reg_protect(reg);
+	if (is_pro) {
+		if (dm_i2c_write(dev, PF9453_REG_LOCK, (uint8_t *)&val, 1)) {
+			pr_err("write error to device: %p register: %#x!\n", dev, reg);
+			return -EIO;
+		}
+
+		if (dm_i2c_write(dev, reg, buff, len)) {
+			pr_err("write error to device: %p register: %#x!\n", dev, reg);
+			return -EIO;
+		}
+
+		val = PF9453_LOCK_KEY;
+		if (dm_i2c_write(dev, PF9453_REG_LOCK, (uint8_t *)&val, 1)) {
+			pr_err("write error to device: %p register: %#x!\n", dev, reg);
+			return -EIO;
+		}
+	} else {
+
+		if (dm_i2c_write(dev, reg, buff, len)) {
+			pr_err("write error to device: %p register: %#x!\n", dev, reg);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+static int pf9453_read(struct udevice *dev, uint reg, uint8_t *buff,
+			int len)
+{
+	if (dm_i2c_read(dev, reg, buff, len)) {
+		pr_err("read error from device: %p register: %#x!\n", dev, reg);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int pf9453_bind(struct udevice *dev)
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
+	debug("%s: '%s' - found regulators subnode\n", __func__, dev->name);
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
+static int pf9453_probe(struct udevice *dev)
+{
+	struct pf9453_priv *priv = dev_get_priv(dev);
+	unsigned int reset_ctrl;
+	int ret = 0;
+
+	if (CONFIG_IS_ENABLED(DM_GPIO) && CONFIG_IS_ENABLED(DM_REGULATOR_PF9453)) {
+		priv->sd_vsel_gpio = devm_gpiod_get_optional(dev, "sd-vsel",
+							     GPIOD_IS_OUT |
+							     GPIOD_IS_OUT_ACTIVE);
+		if (IS_ERR(priv->sd_vsel_gpio)) {
+			ret = PTR_ERR(priv->sd_vsel_gpio);
+			dev_err(dev, "Failed to request SD_VSEL GPIO: %d\n", ret);
+			if (ret)
+				return ret;
+		}
+	}
+
+	if (ofnode_read_bool(dev_ofnode(dev), "nxp,wdog_b-warm-reset"))
+		reset_ctrl = PF9453_PMIC_RESET_WDOG_B_CFG_WARM;
+	else
+		reset_ctrl = PF9453_PMIC_RESET_WDOG_B_CFG_COLD;
+
+	return pmic_clrsetbits(dev, PF9453_RESET_CTRL,
+			       PF9453_PMIC_RESET_WDOG_B_CFG_MASK, reset_ctrl);
+}
+
+static struct dm_pmic_ops pf9453_ops = {
+	.reg_count = pf9453_reg_count,
+	.read = pf9453_read,
+	.write = pf9453_write,
+};
+
+static const struct udevice_id pf9453_ids[] = {
+	{ .compatible = "nxp,pf9453", .data = NXP_CHIP_TYPE_PF9453, },
+	{ }
+};
+
+U_BOOT_DRIVER(pmic_pf9453) = {
+	.name = "pf9453 pmic",
+	.id = UCLASS_PMIC,
+	.of_match = pf9453_ids,
+	.bind = pf9453_bind,
+	.probe = pf9453_probe,
+	.ops = &pf9453_ops,
+	.priv_auto = sizeof(struct pf9453_priv),
+};
diff --git a/include/power/pf9453.h b/include/power/pf9453.h
new file mode 100644
index 00000000000..fd9617edc2c
--- /dev/null
+++ b/include/power/pf9453.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef PF9453_H_
+#define PF9453_H_
+
+#define PF9453_REGULATOR_DRIVER "pf9453_regulator"
+
+enum {
+	PF9453_REG_DEV_ID          = 0x00,
+	PF9453_OTP_VER             = 0x01,
+	PF9453_INT1                = 0x02,
+	PF9453_INT1_MSK            = 0x03,
+	PF9453_INT1_STATUS         = 0x04,
+	PF9453_VRFLT1_INT          = 0x05,
+	PF9453_VRFLT1_MASK         = 0x06,
+	PF9453_PWRON_STAT          = 0x07,
+	PF9453_RESET_CTRL          = 0x08,
+	PF9453_SW_RST              = 0x09,
+	PF9453_PWR_CTRL            = 0x0a,
+	PF9453_CONFIG1             = 0x0b,
+	PF9453_CONFIG2             = 0x0c,
+	PF9453_32K_CONFIG          = 0x0d,
+	PF9453_BUCK1CTRL           = 0x10,
+	PF9453_BUCK1OUT            = 0x11,
+	PF9453_BUCK2CTRL           = 0x14,
+	PF9453_BUCK2OUT            = 0x15,
+	PF9453_BUCK2OUT_STBY       = 0x1D,
+	PF9453_BUCK2OUT_MAX_LIMIT  = 0x1F,
+	PF9453_BUCK2OUT_MIN_LIMIT  = 0x20,
+	PF9453_BUCK3CTRL           = 0x21,
+	PF9453_BUCK3OUT            = 0x22,
+	PF9453_BUCK4CTRL           = 0x2e,
+	PF9453_BUCK4OUT            = 0x2f,
+	PF9453_LDO1OUT_L          = 0x36,
+	PF9453_LDO1CFG            = 0x37,
+	PF9453_LDO1OUT_H          = 0x38,
+	PF9453_LDOSNVS_CFG1        = 0x39,
+	PF9453_LDOSNVS_CFG2        = 0x3a,
+	PF9453_LDO2CFG            = 0x3b,
+	PF9453_LDO2OUT            = 0x3c,
+	PF9453_BUCK_POK            = 0x3d,
+	PF9453_LSW_CTRL1           = 0x40,
+	PF9453_LSW_CTRL2           = 0x41,
+	PF9453_REG_LOCK            = 0x4e,
+	PF9453_REG_NUM,
+};
+
+int power_pf9453_init(unsigned char bus, unsigned char addr);
+
+enum {
+	NXP_CHIP_TYPE_PF9453 = 0,
+	NXP_CHIP_TYPE_AMOUNT
+};
+
+#define PF9453_UNLOCK_KEY		0x5c
+#define PF9453_LOCK_KEY			0x0
+
+#define PF9453_EN_MODE_MASK		0x3
+#define PF9453_BUCK_RUN_MASK		0x7f
+#define PF9453_LDO1_MASK		0x7f
+#define PF9453_LDO2_MASK		0x3f
+#define PF9453_LDOSNVS_MASK		0x7f
+
+#define PF9453_PMIC_RESET_WDOG_B_CFG_MASK		0xc0
+#define PF9453_PMIC_RESET_WDOG_B_CFG_WARM		0x40
+#define PF9453_PMIC_RESET_WDOG_B_CFG_COLD       	0x80
+
+#endif
-- 
2.35.3

