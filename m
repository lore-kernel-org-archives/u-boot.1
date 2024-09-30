Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B11CF6498
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 02:52:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B57B88E43;
	Mon, 30 Sep 2024 04:52:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="q2KmymYL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69EEB8641A; Mon, 30 Sep 2024 04:52:09 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49D0E889B8
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 04:52:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3HQmUMYxhaFZXmpdCtFjC4cDF10oSYEBAjYwSx4UeHXhAr2wvHeT1gxcB4oh4JzoCZIx7Snl+PZKdDTQ4pVc2lqi/1MR/Jikh+XizgchDM2sZ8jw5KihG//147mGoR3jyXq1lvcZ4NMzsZA29q3l6YJyTftR4Vv1mdS255FzRT/oMHDgPz9903al0srnYOwfJrznJ8fn+JfNeXi7o6IMoZHXCYtrkBeVMLTHyDctFaMZlMe3FJ/1zuGr4WLW5WfezWbh3tphWS0VoSNMPzFRpX600/9RD0sDwFOdrNpz1/fdDqETQsMuz+WDamBX3rAUmhR0qptk0Zx4v+DqnHYxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJHCPSeeUrbuWgrN7iHTZdZkdDu+b1BF3+NTUzxBfNs=;
 b=Jqp/Off+h+F9/uXVgqs7Pr/+dnoQyWZnLMlF4f9Wc08k6QqBya04cJ7bhwSoAOioM9xcRv8uHw37YPurEse3eWScxryF6s8DnD0UbgKWUVPEm0K5jwXGGGUCKCQqg0zfbfOy1cNRYK+8saaqHYBJ/0s4WZQKv1sYaSJlMqVkia3HCdDqVgDU/s8rm33NDyPWuiyqsVvaL2Q6wPE+3xS/gcOKrOTu8+v2Kqyf6wv47RvShmAyOxdj1xajnUSTMZDBOb17mmjBff75w2BECjJ3B+NzxaPnZ7YtzBLG31vLzX5cGjOVLRyDStTx1nyOfq99GonUl/AwUvwTy8MLZ4lsPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJHCPSeeUrbuWgrN7iHTZdZkdDu+b1BF3+NTUzxBfNs=;
 b=q2KmymYLnoi+lB9488kEYkTjvXnNY2iuol/FjtHIlgFYd4hfKYh6fZ9PSFxhkFqmL4Ba/1YWDyywJL+/VjimajKIV6CJVCRscOkDwXpzLc8CaowBDX9Qb8CUav5Ms4aQY/SWc3RkanwAmE0Z37trRcBI5/F7efFf/9gxmHFa0piKThxSm44zuA/rucgM555bqYrJaCUi+YyVqKQJLdZoDuQDSW1Y4QW8YOku3O4c+fhZyr70cNx63e9sgzcKCyDL8CzFgm4gRL/7CMSkj3rX2WnZ+cTiNSCWsZ4eieRgAPrG1+iIx0haMPXve53E3kLCHI57M5nZgzPYXd56e1dqLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8712.eurprd04.prod.outlook.com (2603:10a6:10:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 30 Sep
 2024 02:52:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Mon, 30 Sep 2024
 02:52:05 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: uboot-imx@nxp.com, Joy Zou <joy.zou@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/4] power: regulator: Support pmic pf5300
Date: Mon, 30 Sep 2024 11:55:28 +0800
Message-Id: <20240930035531.27079-2-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a6ca4f33-990e-40ed-b554-08dce0faddd6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ICYEkkimVa9WrtQe9o5XNxauFVEHmpvswsItC2RFiNj3QBRmMbmQFUdYP+2W?=
 =?us-ascii?Q?NbTq+XRR18thp6XnAP/aIt7/4v/X3GVGb/u5IY0gt/i4posFUI2UodqNRfUm?=
 =?us-ascii?Q?6bWtKG+5A818E7UQp3a8DZ9bOQex18LUr21uvyPryegowPUkDOVBRqeajUu0?=
 =?us-ascii?Q?4luRXeawiC1Abi5c+B4KyRXYTbVKrs8vT1xLa2vkkzdQXTf59m1ZK+RTOTgE?=
 =?us-ascii?Q?fw9+PMC1MuXr2/jPF4bhbWdT7DRzPet18zP92S6xnk10SN55LcSpVZFRp29s?=
 =?us-ascii?Q?+4Kplz4MANgcSCFLFM+KZ2rBRl/iJCkjFsIobST7nCQUqJjcM5xcptj8AuIP?=
 =?us-ascii?Q?Qq7alFIUz1w36ZAben+SaPkBzRxfBpIANVXVeGeJoi84W92Qgcg4Xrv2NcRX?=
 =?us-ascii?Q?F+SJ+QOtW56WtQQM6oO7FCBCpFUmjoDTMRGTOwzz+OX+EdyMMuAKn6O3AufY?=
 =?us-ascii?Q?3bEtWv/KAt0yaiuJLVO88id4K4OnEkLvr/ynlYgLqFZUYllFYC+y6QOAoMAb?=
 =?us-ascii?Q?5N5MMlPRNfhXphqoprC3BxVvWu0Mn+evV2aaD+h+TjjjCdWcPbdvyvzKTH7i?=
 =?us-ascii?Q?pJ/vuknpVUjlW5lpD3XeqRVOdSPKL1ZKVWwvq+vF1L/vGleggS7EuRXUj6Lh?=
 =?us-ascii?Q?+acSWDgQWxXjOJblOjZ0wndufrebSs4TCEReQd8FXeHAwwyyAH3U9k2on9PH?=
 =?us-ascii?Q?1k5FRZaNlhNqpGG2dbyIxVEmAdVQdF/gi/pFOlW5jYbyT725m1KZjfz1iA4f?=
 =?us-ascii?Q?kvFaghzptan915/chnPJx50H2wI+SLTAnPX7X/FqJ94FHAh9h/npG1wSmusE?=
 =?us-ascii?Q?IFAs+rWZ2jeWhDGxYdzd55GIOOIR1wc83JJb319yhv4IE6iihW7S2fLHhxIF?=
 =?us-ascii?Q?8IvRXQMuO4PCsVcGtL0bSftnEG8DAK3Bn+t2pLEJxXhFks0qxg+mpq6T/ilj?=
 =?us-ascii?Q?cAEYkrfy0XubZFV5dTintpXPBSY2ZWGNT6R9h90+izsnVbTvS9cef/hif0iR?=
 =?us-ascii?Q?z8Z9xPdCkH+MetMSzxRywD8iEirvd9HeCamVgXWxP7cDpRjJUlofhBbmdMsw?=
 =?us-ascii?Q?q3o6XbCR85gUWkS3HyIhUs/XbKcGj8Zm4SMVY4S0dkvZ5Ok18wVNADOHVywY?=
 =?us-ascii?Q?YLH4A3AtZeIBPl3H4uchJhSR9XWBDgIy63A2m6BTZneUcc6d1nh1HDpR2fgY?=
 =?us-ascii?Q?quH4m8fKFk65A7FqCDIoMRBwd1LzZ7+KjsaEAa0CZsbV0R/ty8ik0OAZ1v2d?=
 =?us-ascii?Q?VnqloTgu210yKwINt4p4MoE4MdblSp1bw6mhMCLkOr2ZSF3bun7SVMekddFF?=
 =?us-ascii?Q?sFnVX64VJFRwkm4al45kXYhhDjqCaYpolCS0dREEOySR9g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nW6d8tsGyA1xJQpJRN/zPB5oFuJMU2uwEQMrS5X8ZPrbRd2TDPVoHVKmQkNs?=
 =?us-ascii?Q?T4sxNFGDslQ96kNFprQLJpy+tXWYQTVFmPL32A9KAo/rzZYq4/jo98f3Us++?=
 =?us-ascii?Q?/SZE3BNIXeDqp2VzgSZEeXEb3l7UU/qKYVlBTWxaKspAWvpcK3v6R7jtMBar?=
 =?us-ascii?Q?Dvo7vm9B8OEyk12hUkMt17HtF14J5Sp5A9B7bAoOugKFtGf3nGsp2GW3DfP2?=
 =?us-ascii?Q?Bnm2KHfzMHogPuSHj6QmRhYM2E0f5beObHha2xNNHD0pzcWVyHyF4+/OOs2S?=
 =?us-ascii?Q?DhG05cC1CGt+JpFUmRSJREaj+59FbOY/WncxLtngxtVIUDcKzFkhA3REuTRa?=
 =?us-ascii?Q?wcBosl804GrWklXoTJahQFcWAZwIFPPCX0PE2Y19KIyaZLqN/kVWzNV1C/ao?=
 =?us-ascii?Q?DfSd81lJKsU+qEQt2k+krI5KuQaLSyQwXU2YHR1K6KLoagjuasN28BSj5Tgx?=
 =?us-ascii?Q?9mWtNFYYbdM4/9v4rS/BwCQlAe0w33Zd9gUEfH56aC8XGklCSGuaiZJ9KiXM?=
 =?us-ascii?Q?rM8meUm8Vjyk5tJC4ZaoupKWo/yD7BX8Zv/eal/MsVQOIHfqaZjXAeSZ97dw?=
 =?us-ascii?Q?Q1t/Bu/gRqlTtPM3BEbGNXy7N+mH6vrriNxT5IEwn9F+9uvaPsJiif9Uf40p?=
 =?us-ascii?Q?71awOri6AbJYSapkR1SURhhkg3OYQtlyyqMw++5pP/mbAmB+ZbXEHi7yM2Yi?=
 =?us-ascii?Q?+UcNrnez5KCdgaPinW8CL5VfnG49Hp0zg2KbEuJXyAdvsTpY11iQKGHWfM8Y?=
 =?us-ascii?Q?itzMxfU7QtTi943pBl4JYzx+47o8xQQKkr5h9gharYgdd3ti1fhC4ef5OLM7?=
 =?us-ascii?Q?0thWUNKDZajS0nxFPT8HXwJ8P3BXDbz2BVhiGasySCRbCc+JTkAzSoOB8fVR?=
 =?us-ascii?Q?q+CSZeENKToV6C3rloR3LDHxN0M7cGJbI/nagD3gq4iU/XpHaA70MCLiRo48?=
 =?us-ascii?Q?Zm6XxDQ7XZnU5vezgY9yaJAxqQ4sjFTxgQ3SJ0pujISoFA1D0l8Ww2VjUM0N?=
 =?us-ascii?Q?MMXq1keT4yVmU3KQPlR/RWGN1clALgRUCqu4vmQxhtRPYxJUdiQzt2L3BOKY?=
 =?us-ascii?Q?FtR3hIow7bG75KN26g3OMzZ0kGo/36paYaJHxTD5qDbWguJ81hlav7THMyxk?=
 =?us-ascii?Q?gv4goJyYFdOZpgB91u82qE5gbXwt81zR2IwDLjS0tDqRdVDtKO2oPKdZEl0i?=
 =?us-ascii?Q?di89i3r/398YT1X5ZKis0opf1nYL2pDJ5qa/wkHpwr4RnXjWidYEJ5KdF5Us?=
 =?us-ascii?Q?1f2K4hCj6Wo/ZdCZkuZNFWBrbfXv9YDe/iTiy1MK8KlF2GpwyUCi5HibsCGZ?=
 =?us-ascii?Q?g06HPxt23SOOMnqTU/nGHZ7Hdb5bv24W/h7+POQVGrxqzPEpwaQhFKtX+Lic?=
 =?us-ascii?Q?hXLofS/uOgkwER73twVdR4gUDo/ZiDQM0Cd5e69eB+X+nw1B3aGisXmEpaCC?=
 =?us-ascii?Q?U5JSqiMCUOSsKVat6LOchU6KpVa7ovvdLxvoQiegtSw6CDgXwBlfU4vH4ZTr?=
 =?us-ascii?Q?8m71nDWfWLA0PQRSf1JQNgPT06GaoSLiDhrrk+zLEgjct9Y0bAEnH2GqX212?=
 =?us-ascii?Q?dDs4FML5eGOEoj0ZSx3ddNM/Z7erzl2Cww8E9d1B?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ca4f33-990e-40ed-b554-08dce0faddd6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 02:52:05.0965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDIudlzs1XDS5xLRBmf++5e/a+NYa4naMx/+7y9wN5nmfFgoXtJmFjJ7VhFuL0r6eHOtzpv0a7pT2qQ4pF8rcw==
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

Add regulator support for NXP pmic pf5300.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/regulator/Kconfig  |  15 ++
 drivers/power/regulator/Makefile |   1 +
 drivers/power/regulator/pf5300.c | 247 +++++++++++++++++++++++++++++++
 3 files changed, 263 insertions(+)
 create mode 100644 drivers/power/regulator/pf5300.c

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index b2f487b050b..69dfb07df50 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -111,6 +111,21 @@ config SPL_DM_REGULATOR_PF0900
 	This config enables implementation of driver-model regulator uclass
 	features for regulators on ROHM PF0900 in SPL.
 
+config DM_REGULATOR_PF5300
+	bool "Enable Driver Model for NXP PF5300 regulators"
+	depends on DM_REGULATOR && DM_PMIC_PF5300
+	help
+	This config enables implementation of driver-model regulator uclass
+	features for regulators on NXP PF5300 PMICs. PF5300 contains 1 sw.
+	The driver implements get/set api for value and enable.
+
+config SPL_DM_REGULATOR_PF5300
+	bool "Enable Driver Model for NXP PF5300 regulators in SPL"
+	depends on DM_REGULATOR_PF0900 && SPL
+	help
+	This config enables implementation of driver-model regulator uclass
+	features for regulators on ROHM PF5300 in SPL.
+
 config DM_REGULATOR_DA9063
 	bool "Enable Driver Model for REGULATOR DA9063"
 	depends on DM_REGULATOR && DM_PMIC_DA9063
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index a49700dfd25..7a580d45b72 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_$(SPL_)DM_PMIC_PFUZE100) += pfuze100.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_BD71837) += bd71837.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_PCA9450) += pca9450.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_PF0900) += pf0900.o
+obj-$(CONFIG_$(SPL_)DM_REGULATOR_PF5300) += pf5300.o
 obj-$(CONFIG_$(SPL_)REGULATOR_PWM) += pwm_regulator.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_FAN53555) += fan53555.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_COMMON) += regulator_common.o
diff --git a/drivers/power/regulator/pf5300.c b/drivers/power/regulator/pf5300.c
new file mode 100644
index 00000000000..6df24934e09
--- /dev/null
+++ b/drivers/power/regulator/pf5300.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * NXP PF5300 regulator driver
+ * Copyright 2023 NXP
+ */
+
+#include <dm.h>
+#include <errno.h>
+#include <log.h>
+#include <linux/bitops.h>
+#include <power/pf5300.h>
+#include <power/pmic.h>
+#include <power/regulator.h>
+
+/**
+ * struct pf5300_vrange - describe linear range of voltages
+ *
+ * @min_volt:	smallest voltage in range
+ * @step:	how much voltage changes at each selector step
+ * @min_sel:	smallest selector in the range
+ * @max_sel:	maximum selector in the range
+ */
+struct pf5300_vrange {
+	unsigned int	min_volt;
+	u8		min_sel;
+	u8		max_sel;
+	unsigned int	step;
+};
+
+/**
+ * struct pf5300_plat - describe regulator control registers
+ *
+ * @name:	name of the regulator. Used for matching the dt-entry
+ * @enable_reg:	register address used to enable/disable regulator
+ * @enablemask:	register mask used to enable/disable regulator
+ * @volt_reg:	register address used to configure regulator voltage
+ * @volt_mask:	register mask used to configure regulator voltage
+ * @ranges:	pointer to ranges of regulator voltages and matching register
+ *		values
+ * @numranges:	number of voltage ranges pointed by ranges
+ */
+struct pf5300_plat {
+	const char		*name;
+	u8			enable_reg;
+	u8			enablemask;
+	u8			volt_reg;
+	u8			volt_mask;
+	struct pf5300_vrange	*ranges;
+	unsigned int		numranges;
+};
+
+#define PCA_RANGE(_min, _sel_low, _sel_hi, _vstep) \
+{ \
+	.min_volt = (_min), .min_sel = (_sel_low), \
+	.max_sel = (_sel_hi), .step = (_vstep),\
+}
+
+#define PCA_DATA(_name, enreg, enmask, vreg, vmask, _range) \
+{ \
+	.name = (_name), .enable_reg = (enreg), .enablemask = (enmask), \
+	.volt_reg = (vreg), .volt_mask = (vmask), .ranges = (_range), \
+	.numranges = ARRAY_SIZE(_range) \
+}
+
+static struct pf5300_vrange pf5300_sw1_vranges[] = {
+	PCA_RANGE(500000,  0x00, 0x8C, 5000),
+	PCA_RANGE(0,       0x8D, 0xFF, 0),
+};
+
+static struct pf5300_plat pf5301_reg_data[] = {
+	PCA_DATA("SW1_2a", PF5300_REG_SW1_CTRL1, SW_MODE_PWM,
+		 PF5300_REG_SW1_VOLT, SW1_VOLT_MASK,
+		 pf5300_sw1_vranges),
+};
+
+static struct pf5300_plat pf5302_reg_data[] = {
+	PCA_DATA("SW1_29", PF5300_REG_SW1_CTRL1, SW_MODE_PWM,
+		 PF5300_REG_SW1_VOLT, SW1_VOLT_MASK,
+		 pf5300_sw1_vranges),
+};
+
+static int vrange_find_value(struct pf5300_vrange *r, unsigned int sel,
+			     unsigned int *val)
+{
+	if (!val || sel < r->min_sel || sel > r->max_sel)
+		return -EINVAL;
+
+	*val = r->min_volt + r->step * (sel - r->min_sel);
+	return 0;
+}
+
+static int vrange_find_selector(struct pf5300_vrange *r, int val,
+				unsigned int *sel)
+{
+	int ret = -EINVAL;
+	int num_vals = r->max_sel - r->min_sel + 1;
+
+	if (val >= r->min_volt &&
+	    val <= r->min_volt + r->step * (num_vals - 1)) {
+		if (r->step) {
+			*sel = r->min_sel + ((val - r->min_volt) / r->step);
+			ret = 0;
+		} else {
+			*sel = r->min_sel;
+			ret = 0;
+		}
+	}
+	return ret;
+}
+
+static int pf5300_get_enable(struct udevice *dev)
+{
+	struct pf5300_plat *plat = dev_get_plat(dev);
+	int val;
+
+	val = pmic_reg_read(dev->parent, plat->enable_reg);
+	if (val < 0)
+		return val;
+
+	return (val & plat->enablemask);
+}
+
+static int pf5300_set_enable(struct udevice *dev, bool enable)
+{
+	int val = 0;
+	int tmp = 0;
+	struct pf5300_plat *plat = dev_get_plat(dev);
+
+	if (enable)
+		tmp = plat->enablemask;
+	val = pmic_reg_read(dev->parent, plat->enable_reg);
+	if (tmp < 0)
+		return tmp;
+	val = (tmp & plat->enablemask) | (val & (~plat->enablemask));
+
+	return pmic_reg_write(dev->parent, plat->enable_reg, val);
+}
+
+static int pf5300_get_value(struct udevice *dev)
+{
+	struct pf5300_plat *plat = dev_get_plat(dev);
+	unsigned int reg, tmp;
+	int i, ret;
+
+	ret = pmic_reg_read(dev->parent, plat->volt_reg);
+	if (ret < 0)
+		return ret;
+
+	reg = ret;
+	reg &= plat->volt_mask;
+
+	for (i = 0; i < plat->numranges; i++) {
+		struct pf5300_vrange *r = &plat->ranges[i];
+
+		if (!vrange_find_value(r, reg, &tmp))
+			return tmp;
+	}
+
+	pr_err("Unknown voltage value read from pmic\n");
+
+	return -EINVAL;
+}
+
+static int pf5300_set_value(struct udevice *dev, int uvolt)
+{
+	struct pf5300_plat *plat = dev_get_plat(dev);
+	unsigned int sel;
+	int i, val, found = 0;
+
+	for (i = 0; i < plat->numranges; i++) {
+		struct pf5300_vrange *r = &plat->ranges[i];
+
+		found = !vrange_find_selector(r, uvolt, &sel);
+		if (found) {
+			unsigned int tmp;
+
+			/*
+			 * We require exactly the requested value to be
+			 * supported - this can be changed later if needed
+			 */
+			found = !vrange_find_value(r, sel, &tmp);
+			if (found && tmp == uvolt)
+				break;
+			found = 0;
+		}
+	}
+
+	if (!found)
+		return -EINVAL;
+
+	val = pmic_reg_read(dev->parent, plat->volt_reg);
+	if (val < 0)
+		return val;
+	val = (sel & plat->volt_mask) | (val & (~plat->volt_mask));
+	return pmic_reg_write(dev->parent, plat->volt_reg, val);
+}
+
+static int pf5300_regulator_probe(struct udevice *dev)
+{
+	struct pf5300_plat *plat = dev_get_plat(dev);
+	int i, type;
+
+	type = dev_get_driver_data(dev_get_parent(dev));
+
+	if (type != PF5300_TYPE_PF5300 && type != PF5300_TYPE_PF5301 &&
+	    type != PF5300_TYPE_PF5302) {
+		debug("Unknown PMIC type\n");
+		return -EINVAL;
+	}
+
+	if (type == PF5300_TYPE_PF5301) {
+		for (i = 0; i < ARRAY_SIZE(pf5301_reg_data); i++) {
+			if (strcmp(dev->name, pf5301_reg_data[i].name))
+				continue;
+			*plat = pf5301_reg_data[i];
+
+			return 0;
+		}
+	} else if (type == PF5300_TYPE_PF5302) {
+		for (i = 0; i < ARRAY_SIZE(pf5302_reg_data); i++) {
+			if (strcmp(dev->name, pf5302_reg_data[i].name))
+				continue;
+			*plat = pf5301_reg_data[i];
+
+			return 0;
+		}
+	}
+
+	pr_err("Unknown regulator '%s'\n", dev->name);
+
+	return -ENOENT;
+}
+
+static const struct dm_regulator_ops pf5300_regulator_ops = {
+	.get_value	= pf5300_get_value,
+	.set_value	= pf5300_set_value,
+	.get_enable	= pf5300_get_enable,
+	.set_enable	= pf5300_set_enable,
+};
+
+U_BOOT_DRIVER(pf5300_regulator) = {
+	.name		= PF5300_REGULATOR_DRIVER,
+	.id		= UCLASS_REGULATOR,
+	.ops		= &pf5300_regulator_ops,
+	.probe		= pf5300_regulator_probe,
+	.plat_auto	= sizeof(struct pf5300_plat),
+};
-- 
2.35.3

