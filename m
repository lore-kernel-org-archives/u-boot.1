Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F6FCF6499
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 02:52:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB22888DFA;
	Mon, 30 Sep 2024 04:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qgCr30eR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F63F88DBA; Mon, 30 Sep 2024 04:52:07 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39F5D88DFA
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 04:52:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozdg1l2r5iXoCIfLjly4Ki82Rt06GqKNwvWeQqygcWMrJ7Upwy2ZBIa/UzfHNI7+k0bb7XOz6I0zdU3Ei3bJboptOkKUWQ3WuAEmHuVpAwjiifKAzkYId3+SCJro8v2ECaJ4aiiIZnWAfc0btYofCHG8GAsQJ+B6BvKgKHZVoKWI1peTDHOaYCn55wfx4SPha+v0EKOQsW2vRO0NXSrEqmR2WzNlGsG8L9847Xf7Ey9dOM3cXW19bDsVfrfA3ylQuPSRSbiNd3PBBUKT+/6roOvgqQOLr4cwVHdcBtrcMKMZi44vmtLv0ldIi60mBeU96HOo2jSn4Mae0sMg6UbNnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jC9IbHX2lkTFQySXHqgw5YQZJWCM+urXOST0p2NMWx8=;
 b=Fu19DSGPdnSFoMubBpeOmH9MYxuDllPuqCHC9On5YIcdj9nKtTBk7qMkTU+68YDkSTNeFc3lzxuFv9DY/tCA9py05i7t9YZYI27gCE8wVxWbcbrCyCjXo1Rgbz824qOjENr+vvTIYstlGC2bHgV+a8yh2/vV9Xk7m0fgW47gtQD0FvWUkkqwMErC1NETlQH03fhNdvHUvK+3n3Pvoc9uIf0K/ajJBFChZlmNrSXZOp6syVjOK0zhHwagHYaPOAvit+dlz+Z0ww7UB9dhC5qWhma93Wg0VzsyNEeY7MRJnM/0DQyl0UaxcHRmAcUQD6N85+7gify0EC24SUqSw9i8ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jC9IbHX2lkTFQySXHqgw5YQZJWCM+urXOST0p2NMWx8=;
 b=qgCr30eRDLOvKRA/5i3HisvNMcnb/w92KlJ9F8wDrPVxrzfw02iwO0njft8oifRFvwFCpUphrL/03GTU90Qk23dBk2AKYW+ecIB45PDs/6YjdzjERmx2l9tVPImjrTT+hLhJ/K6t7NlP2G0LFxRrUZEPF8hSnmIYfaoJWBDfK4qMiKd0MFsMRALfci59Kpjxjr7ktQ/1Jk9RE0FhG5qrXsLFXQ1cE6akLSGNYpQ8dPE8ptf95eXJJz61iH7rCad+sLBSGkC4cgChdXPJMzwLBFQXowC72Sf5o1PVkjF0rF3IDujhYXTU3LdcqdN6N3elFgvPGWNRHmjVJdMNhdPbuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8712.eurprd04.prod.outlook.com (2603:10a6:10:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 30 Sep
 2024 02:52:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Mon, 30 Sep 2024
 02:52:00 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: uboot-imx@nxp.com, Joy Zou <joy.zou@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/4] power: pmic: Support pmic pf5300
Date: Mon, 30 Sep 2024 11:55:27 +0800
Message-Id: <20240930035531.27079-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 47739a30-5f80-4af6-27ae-08dce0fadb12
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PPb6HHiXakN08tfUrstqc7A9OKuNzH/OveKz+6NqY2t0mdxCt6Cw2z7KndKM?=
 =?us-ascii?Q?Cw4gSfR/4LEl+tZFdQJUETCDVYeKlg8qFS4MXoNuROEoK90zjdYZf31SqQI/?=
 =?us-ascii?Q?MYTD5Zs7E7cKFZmI9IgJjwYDpNHtNIlQQ8wo1Wbpyc31eDBJtDtlLax5Hhpe?=
 =?us-ascii?Q?T42QfuB7SIlarL95gVjHdXonu0lt2ylfTmA2kZh/MtFN0wVqzxyY/XUZbplI?=
 =?us-ascii?Q?jLmOm8viwg2FsSms5WTkglj0ZviXikurUh4Ko3W9jyyJ9kI1ShWWBOIcxizc?=
 =?us-ascii?Q?GTMeRFRZSGICjP+P8kRsTD3L6wGEGCFeObxaJFDsniZuwHLtLz0cTBJzKJHm?=
 =?us-ascii?Q?3yxcSV60FJZV7gT6iiMeVqJM5YcEcP1OJ/HGHGtueZFpLIwY7pr2xjlSiO4s?=
 =?us-ascii?Q?DEpu0kEO3SFQv6mCnopixbJcQc79xX7tJ9IQQustDTq9uiNCh7Nctt/+5KB2?=
 =?us-ascii?Q?bUSKv6Gw0Dy33wqlkxdXKasJg1IwmzXcf0HjVq5Wyorc2I08Y6ZPNAHjfDvD?=
 =?us-ascii?Q?0TjGiXbRWl3vKT6ZebSq4MxTfRXZK3/s5M7rXWF5XH61KlHgAD2RTvQ3CB3f?=
 =?us-ascii?Q?zd8s9EiyA7JWTtMyGn8wv1Lu43O9xuMIzovoKBhZYRhSyXId2MZenZLEeIQp?=
 =?us-ascii?Q?ZKXNhooALFFAnfNEoZr/C29CIxMQImXzKZGEmg2u84gPIzaiiugCwaBkqMRm?=
 =?us-ascii?Q?sVpU6yGPOgdRD3WNXWm0u3usrdb+hL2JbRaMWOi9lHr3K027sDxrSsDldEPH?=
 =?us-ascii?Q?ZUslLwpbmv60mZEVGOyQ/mspkkakyfHxMcbn+lIJnOpGPofIXFoXswZev+g2?=
 =?us-ascii?Q?jMk5zyWJHFHISrPzGr/VXYOZET8B9n0H1K1qmopGJ5Cx2zMZ7dhe60+BGE+w?=
 =?us-ascii?Q?qNRuPdnwgOCKPCv4dN97Bal8GCjoPRSYpgTPrybesIXS6uMv0OcLiEnuS0rW?=
 =?us-ascii?Q?OHS3x6hKiZw6K80lKji84NwiqixDVfe7605pmQM+tBCe5AJLaxSUEHEhUyY7?=
 =?us-ascii?Q?TsdaSeIfROofQW0g2Kk2TU0mbO8ofb3A3VN9ww/DKlS0NT+t1ZKMYnUOKtpI?=
 =?us-ascii?Q?CcxzXEbxe3Z1H2Fsz8zQgaGnD6phExpsDmvEdWYVA6vO4ioR9ShunIBQQxZa?=
 =?us-ascii?Q?vWBzH3ujqg6DkAzWjpKt0NHydjO6xvj1a4ZmTP1Xv4KsLV2YpSakrwTpfBiX?=
 =?us-ascii?Q?Cj23tSVzkk37Tm5XlppR5CrWU0oWVhCnrm3RmcvG5c8ttHgw7fClzjVbF+UN?=
 =?us-ascii?Q?CI7YGcAQGWW5nOspPx+Ocgcif0b/oqs481vv5GyhLJfL+ZdjwQVSo7u6bTMC?=
 =?us-ascii?Q?0cz5TB6u8Grm00fWJeTZBJESKJeJb2INXhB6Zcg0a7N8Lg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/cXNNp3iRg+OAkfWY3YUbT45epsn2nSIgRmn7hkrMFtOkSbg32QEHlEzn5xg?=
 =?us-ascii?Q?Ux/j43znYy0Xhym3J/8vRT21Rrj3Bf+IIEc/eaCj0Y4riVT7VIfdxSu+Rgmj?=
 =?us-ascii?Q?2nFkafMs4asgRPNsYIB+uA7Kw3HjZuha5TABb3TFPTDUP6p/gRtdKn9514jH?=
 =?us-ascii?Q?Y99pe8NzZbaCwmJHgco2DpHi7dA61106Gd9ALyehiQSIG7SaUxFFpbWCFwt5?=
 =?us-ascii?Q?RzN8R2RD+Vab3aOF9qKHpi2d1ZBSxJeDonm9y3jvclvkhwxZs39DvpJ6kVNt?=
 =?us-ascii?Q?VDMGo3j40yJ0AqF1JnE5KGs78J8MC+vFIeRgg3Qfvf1KXbZCMqPmd81De4YO?=
 =?us-ascii?Q?Gjj1skwJBrldtjAO21A0isJsvDTMsMtEW00ChAs84lu+OR2eEd5dsfx2gAR7?=
 =?us-ascii?Q?wtaycNFvsT55mNFb5YFli8YldGCIKRTkaLfqISX7X911cE5NfUMWLCxJa69p?=
 =?us-ascii?Q?7HKCgIihLMuv23q6gnJUnJd60ZTlBJg2lGHmZ7lAhmAq99geP2XaVlR6qu6G?=
 =?us-ascii?Q?Wea8onHcw3oGPcW9kQUcuHVrXnkNlHSpwUB+IoeVY2A6VR2WEM4d2RJPUHk5?=
 =?us-ascii?Q?5lqBN2LFW2cL+hzZV7AfspAfifjCG9QbsnCQPXl8cEVvtkf0fRLXoFsHUg9C?=
 =?us-ascii?Q?TOUnfkL24FQdEk6s8UEZ44Kf194Lzm7Uj2tlBztmB8gLyDhDsuWkZ5jBsOIW?=
 =?us-ascii?Q?rOtY0NjvJVXO1wb6gf+OwTBURxaYEQ4oaCQgnXL/YkYAH0N+6xek/1uSEkrE?=
 =?us-ascii?Q?/T20nETEBkGspPYq3qkPJyIxWAZJH/tYbDyzDsHT6gy72hqe7zjPa/N5FXO7?=
 =?us-ascii?Q?wKmIUGskfAzg27rLbHN6jJQdi6Mx54WX6qFebp6aUudNnsamLi44x1T2ZlY+?=
 =?us-ascii?Q?B/hw/NGqXiv1gB7asmgjHyt5nO0ARR81ERWm0AEGf8lDganbaqB5PUuo53/X?=
 =?us-ascii?Q?+dL8tpMi5qeQkMJTwMXD3fHLKBLsMnu33EW8zr4QzmaRBK7iPMYSy0G0ePkM?=
 =?us-ascii?Q?XI7+SJxEyqkt+2ekjMc+Lz28iqYs59Ub/VLkeirvcCA0T08xJ9b7ro19LV8E?=
 =?us-ascii?Q?2eUViliFX5TEyXsG3xdfWOm39Axm0pwqd5/y1Pa1VvdO1f5J8Yn82PeY4w5j?=
 =?us-ascii?Q?69kBESmNNwrRyt1v9u8sEC5jN/4XCBaQZFyT0Gt7nGTR+RzkfuOkUKIpPAYT?=
 =?us-ascii?Q?pimRmiGmFn3tmd/jN4b5Jq0Wiwy+/qcN4mM2KNhZAs18fsyQVjiZAUtpJgVz?=
 =?us-ascii?Q?c7u1PMBz6zR4IoPOOvirQvgThzi056gc5y2QRM84rTXRCMfu5KGs+W8QJ/Fi?=
 =?us-ascii?Q?KhUuAcBza4drXQDDUUg8xqyEcdF/nlrVp/WO17557jWEHkncSvBoesEs1cQL?=
 =?us-ascii?Q?HxNYL6U5SFC8HZ1UmzDokGeEl9+3vkFHt8u6ebYlIzAC7ek/beSBlqokmOzi?=
 =?us-ascii?Q?1rKUnaf3FAAfhp4wFWkVPc1sQhg4ewDQopnzDTfa88f5D6RLCGV8CPgLhHPA?=
 =?us-ascii?Q?vik3K53JjU1KyYITUT937K7Ns0S1tWQzy5yv8TK7N6BLcUBBQDZvK2Vf5JuF?=
 =?us-ascii?Q?/zyyAnq3zVFxk1CA4hJUvmry92LCUpHplWLVOzR8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47739a30-5f80-4af6-27ae-08dce0fadb12
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 02:52:00.4639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fj6YxmP1NO8RDzRLWJRT/lsAIRv3OYp2/maWrqF+SLG2QMkgfMeEfraASeNp7/ciXpj+KrHpyCkhnrkaMc1ytQ==
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

Support NXP pmic pf5300

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/pmic/Kconfig  |  15 ++++
 drivers/power/pmic/Makefile |   1 +
 drivers/power/pmic/pf5300.c | 168 ++++++++++++++++++++++++++++++++++++
 include/power/pf5300.h      | 100 +++++++++++++++++++++
 4 files changed, 284 insertions(+)
 create mode 100644 drivers/power/pmic/pf5300.c
 create mode 100644 include/power/pf5300.h

diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
index 1a5ef279ed6..420c4099937 100644
--- a/drivers/power/pmic/Kconfig
+++ b/drivers/power/pmic/Kconfig
@@ -186,6 +186,21 @@ config SPL_DM_PMIC_PF0900
 	  This config enables implementation of driver-model pmic uclass features
 	  for PMIC PF0900 in SPL. The driver implements read/write operations.
 
+config DM_PMIC_PF5300
+	bool "Enable Driver Model for PMIC PF5300"
+	depends on DM_I2C
+	help
+	  This config enables implementation of driver-model pmic uclass features
+	  for PMIC PF5300. The driver implements read/write operations.
+
+config SPL_DM_PMIC_PF5300
+	bool "Enable Driver Model for PMIC PF5300 in SPL"
+	depends on SPL_DM_PMIC
+	depends on SPL_DM_I2C
+	help
+	  This config enables implementation of driver-model pmic uclass features
+	  for PMIC PF5300 in SPL. The driver implements read/write operations.
+
 config DM_PMIC_PFUZE100
 	bool "Enable Driver Model for PMIC PFUZE100"
 	---help---
diff --git a/drivers/power/pmic/Makefile b/drivers/power/pmic/Makefile
index 0041ab59406..74ace69daf5 100644
--- a/drivers/power/pmic/Makefile
+++ b/drivers/power/pmic/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_$(SPL_)DM_PMIC_MP5416) += mp5416.o
 obj-$(CONFIG_$(SPL_)DM_PMIC_PFUZE100) += pfuze100.o
 obj-$(CONFIG_$(SPL_)DM_PMIC_PCA9450) += pca9450.o
 obj-$(CONFIG_$(SPL_)DM_PMIC_PF0900) += pf0900.o
+obj-$(CONFIG_$(SPL_)DM_PMIC_PF5300) += pf5300.o
 obj-$(CONFIG_PMIC_S2MPS11) += s2mps11.o
 obj-$(CONFIG_DM_PMIC_SANDBOX) += sandbox.o i2c_pmic_emul.o
 obj-$(CONFIG_PMIC_AB8500) += ab8500.o
diff --git a/drivers/power/pmic/pf5300.c b/drivers/power/pmic/pf5300.c
new file mode 100644
index 00000000000..b66fa756109
--- /dev/null
+++ b/drivers/power/pmic/pf5300.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2023 NXP
+ */
+
+#include <asm/global_data.h>
+#include <asm-generic/gpio.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <i2c.h>
+#include <errno.h>
+#include <fdtdec.h>
+#include <linux/err.h>
+#include <log.h>
+#include <power/pmic.h>
+#include <power/regulator.h>
+#include <power/pf5300.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static const struct pmic_child_info pmic_children_info[] = {
+	/* sw */
+	{ .prefix = "S", .driver = PF5300_REGULATOR_DRIVER},
+	{ },
+};
+
+static int pf5300_reg_count(struct udevice *dev)
+{
+	return PF5300_MAX_REGISTER;
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
+static int pf5300_read(struct udevice *dev, uint reg, u8 *buff,
+		       int len)
+{
+	u8 crcBuf[3];
+	u8 data[2], crc;
+	int ret;
+	struct pf5300_priv *priv = dev_get_priv(dev);
+
+	if (reg < PF5300_MAX_REGISTER) {
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
+static int pf5300_write(struct udevice *dev, uint reg, const u8 *buff,
+			int len)
+{
+	u8 crcBuf[3];
+	u8 data[2];
+	int ret;
+	struct pf5300_priv *priv = dev_get_priv(dev);
+
+	if (reg < PF5300_MAX_REGISTER) {
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
+static int pf5300_bind(struct udevice *dev)
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
+static int pf5300_probe(struct udevice *dev)
+{
+	struct pf5300_priv *priv = dev_get_priv(dev);
+	unsigned int reg;
+	int ret = 0;
+
+	ret = ofnode_read_u32(dev_ofnode(dev), "reg", &reg);
+	if (ret)
+		return ret;
+	priv->addr = reg;
+
+	if (ofnode_read_bool(dev_ofnode(dev), "i2c-crc-enable"))
+		priv->crc_en = true;
+
+	return ret;
+}
+
+static struct dm_pmic_ops pf5300_ops = {
+	.reg_count = pf5300_reg_count,
+	.read = pf5300_read,
+	.write = pf5300_write,
+};
+
+static const struct udevice_id pf5300_ids[] = {
+	{ .compatible = "nxp,pf5300", .data = PF5300_TYPE_PF5300, },
+	{ .compatible = "nxp,pf5301", .data = PF5300_TYPE_PF5301, },
+	{ .compatible = "nxp,pf5302", .data = PF5300_TYPE_PF5302, },
+	{ }
+};
+
+U_BOOT_DRIVER(pmic_pf5300) = {
+	.name = "pf5300 pmic",
+	.id = UCLASS_PMIC,
+	.of_match = pf5300_ids,
+	.bind = pf5300_bind,
+	.probe = pf5300_probe,
+	.ops = &pf5300_ops,
+	.priv_auto = sizeof(struct pf5300_priv),
+};
diff --git a/include/power/pf5300.h b/include/power/pf5300.h
new file mode 100644
index 00000000000..0d2fa548a70
--- /dev/null
+++ b/include/power/pf5300.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2023 NXP
+ */
+
+#ifndef PF5300_H_
+#define PF5300_H_
+
+#define PF5300_REGULATOR_DRIVER "pf5300_regulator"
+
+struct pf5300_priv {
+	u8 addr;
+	bool crc_en;
+};
+
+enum pf5300_chip_type {
+	PF5300_TYPE_PF5300 = 0,
+	PF5300_TYPE_PF5301 = 1,
+	PF5300_TYPE_PF5302 = 2,
+	PF5300_TYPE_AMOUNT,
+};
+
+enum {
+	PF5300_SW1 = 0,
+	PF5300_REGULATOR_CNT,
+};
+
+enum {
+	PF5300_DVS_LEVEL_RUN = 0,
+	PF5300_DVS_LEVEL_STANDBY,
+	PF5300_DVS_LEVEL_MAX,
+};
+
+#define PF5300_SW1_VOLTAGE_NUM	0x100
+
+enum {
+	PF5300_REG_DEV_ID	    = 0x00,
+	PF5300_REG_REV_ID	    = 0x01,
+	PF5300_REG_EMREV	    = 0x02,
+	PF5300_REG_PROG_ID	    = 0x03,
+	PF5300_REG_CONFIG1	    = 0x04,
+	PF5300_REG_INT_STATUS1	    = 0x05,
+	PF5300_REG_INT_SENSE1	    = 0x06,
+	PF5300_REG_INT_STATUS2	    = 0x07,
+	PF5300_REG_INT_SENSE2	    = 0x08,
+	PF5300_REG_BIST_STAT1	    = 0x09,
+	PF5300_REG_BIST_CTRL	    = 0x0A,
+	PF5300_REG_STATE	    = 0x0B,
+	PF5300_REG_STATE_CTRL       = 0x0C,
+	PF5300_REG_SW1_VOLT         = 0x0D,
+	PF5300_REG_SW1_STBY_VOLT    = 0x0E,
+	PF5300_REG_SW1_CTRL1        = 0x0F,
+	PF5300_REG_SW1_CTRL2        = 0x10,
+	PF5300_REG_CLK_CTRL         = 0x11,
+	PF5300_REG_SEQ_CTRL1        = 0x12,
+	PF5300_REG_SEQ_CTRL2        = 0x13,
+	PF5300_REG_RANDOM_CHK       = 0x14,
+	PF5300_REG_RANDOM_GEN       = 0x15,
+	PF5300_REG_WD_CTRL          = 0x16,
+	PF5300_REG_WD_SEED          = 0x17,
+	PF5300_REG_WD_ANSWER        = 0x18,
+	PF5300_REG_FLT_CNT1         = 0x19,
+	PF5300_REG_FLT_CNT2         = 0x1A,
+	PF5300_MAX_REGISTER,
+};
+
+/* PF5300 SW1_CTRL1 */
+#define SW_MODE_OFF			0x00
+#define SW_MODE_PWM			0x0c
+
+#define SW1_MODE_MASK			0x0C
+#define SW1_STBY_MODE_MASK		0x30
+
+#define SW1_RAMP_MASK			0x03
+
+/* PF5300 SW1_VOLT/SW1_STBY_VOLT MASK */
+#define SW1_VOLT_MASK			0xFF
+#define SW1_STBY_VOLT_MASK		0xFF
+
+/* PF5300_REG_INT_STATUS1 bits */
+#define IRQ_SDWN			0x80
+#define IRQ_BG_ERR			0x40
+#define IRQ_CRC				0x20
+#define IRQ_SW1_DVS_DONE		0x10
+#define IRQ_SW1_ILIM			0x08
+#define IRQ_VMON_UV			0x04
+#define IRQ_VMON_OV			0x02
+#define IRQ_VIN_OVLO			0x01
+
+/* PF5300_REG_INT_STATUS2 bits */
+#define IRQ_PGOOD_STUCK_AT0		0x80
+#define IRQ_PGOOD_STUCK_AT1		0x40
+#define IRQ_DVS_ERR			0x20
+#define IRQ_FSYNC			0x10
+#define IRQ_THERM_155			0x08
+#define IRQ_THERM_140			0x04
+#define IRQ_THERM_125			0x02
+#define IRQ_THERM_110			0x01
+
+#endif
-- 
2.35.3

