Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1298CF6499
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 02:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BD1F88E2D;
	Mon, 30 Sep 2024 04:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="yLE3Ko1Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA26088EE3; Mon, 30 Sep 2024 04:52:16 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2A0988E1C
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 04:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abK6/X/oFC1QcQUhGAo2/lN7A7s4T65Cf9Z0NmSLNInsX2kRq1X00GrqxZDJ2oiCgUxpQQFXR/+6cK7GLDCzgD32eL5YQQRNzxHQzOJ4HjPMd2lqNdPgGk62RXR17L78frZZBefW+XSW+XKaoWagXSiwFceyZXpf2sv9jwU5ilI3dqQGczWOwbDkdQsuZkHaCNq6d7WyLk3U+dDlH7fncaokfw+HpO+eKEmFLyd2MrWNxp+CEd5VQP27fmQm/5mM+AOz/iDAnAk+jhASJQs98OSavfuNZXTr7eSYcC8jpCPA2ii5xcKFox+reBSLyuE5+z2auOZSqlx8crxgMTnGNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKxduSYnonLrEAegFU+mhdUyX6uLcoDLv83GAbJ9RxE=;
 b=ADozEkF0mX1je/uOqAm4p4S8j4xqsvVSdg99akaFrD8HZVMvTRjNO7iKIFV/GVqowa/2agDwgtXtv0xxBfmrgjbCyaenWQWbrdehpiM+ZZvE7UjjqKgcbR4ntUScJbcw5Vgl+7G9uPJrvcuyFBUNfesEWtsbg1T4C8ct2qwP0d3xdTZiKQbfRTylf/YWCvYpVM/8OjD1ZRwnBM7OxBL5kimybil9dg3EPEEp0ikRaE2Qd+PIJ2gK4YVtKIhX5BAK9Wce9IYQRwGHExxWmROLbLd+PvkfFS/DYmCuZX3asClPv5ip5SDXUp6g10LMKMhDmn+0nVkd9vfLsqqilt37+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKxduSYnonLrEAegFU+mhdUyX6uLcoDLv83GAbJ9RxE=;
 b=yLE3Ko1ZnqHYRj9+PsON1RAr7YbhzQEuiv7eYLuV4w67Doc7n0B8LrmdxuQuq81E7wD2JK9itiWbct/vhnfnS/mXyCTEqK74rIHEIzbXf/4RD5q7XvQaoL3WLCVVgNyZ6et5HNqOujX4p2LVTNZ8WZjfqNGi+jKD3Q5pG/rEiAvw97TMWIMM6qIkMa6eBAuH8slGXcYJTlBL794I/in4BzAJtigmVAFTCljHzVrD5J39PjFffvfn8MQRFXY8oo3YTGZeGDvG6MKZM6xLQ+6rgIsi7Y2GFBU6eb+oDmeBP+xtHn9cFpaq+UNRDOx2fSY/XkzeHSuNgSkC9lNHHVs4hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8712.eurprd04.prod.outlook.com (2603:10a6:10:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 30 Sep
 2024 02:52:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Mon, 30 Sep 2024
 02:52:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: uboot-imx@nxp.com, Joy Zou <joy.zou@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/4] power: regulator: ADD PMIC PF9453 support
Date: Mon, 30 Sep 2024 11:55:30 +0800
Message-Id: <20240930035531.27079-4-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 429c43bc-606a-456d-71c8-08dce0fae24b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ApbyF6QnwGRJZbl3A3SL837CJTr/P9M7GkKcdbKFkA9CboSZOPaquVOEr5+M?=
 =?us-ascii?Q?v2+++4mKHi8U/w8s1oNHIsO8Yg7jn8gMLrxxeZSfMl/ZZen715ByXZJJaf5v?=
 =?us-ascii?Q?/KSl5LX5efvQHx01kbo8u6r8jr8oXwfX5H6UcAXpcPpsMO3BCg+IqwhwIkUZ?=
 =?us-ascii?Q?T2tDbqfr8Afsp4s5VLQvFRMyVxuGUMsQ2TQPRrq7i0ynh1hYV1WGoW9VBLru?=
 =?us-ascii?Q?Hzy5KpCKRfCn+j/KegHb54ffIVKD/VOe7APmMscvqLvegkJdtThLUlp9VWr5?=
 =?us-ascii?Q?AmX78J0BT3A9Ysgh8CtsXnnAt38cPVCxEMYEH+fZv8WqIc3PFQ7z/lT3QRk+?=
 =?us-ascii?Q?O7Ntv/zRMWxFnJmyKS+AhXzy48RdJ4Q+yE2ig9TrEzFIXj5RyEO/HB7nNVvI?=
 =?us-ascii?Q?4uQKxW83KajGw3hrnR0mPTNrMLIUlJ3fUkaWc2MzSrXuBtre9QQHu6wx67kD?=
 =?us-ascii?Q?nswF2jZeOOfxSrduEPK2sKJg8ADxImkSzipV2zgQmYFRM/+eiX63zpdKPfGU?=
 =?us-ascii?Q?NhZ/NOh4ah/hf1pYACflY/p5gEMkDR4uF1uKPTpQU5IHu5Q0Gbp43smxR51H?=
 =?us-ascii?Q?fVC075dyrHubGNYqRLvuEKLoNq6M3xZxDU5OOupqMjYhKsCyWv0ZQEDhj0gI?=
 =?us-ascii?Q?gI7G19kxu0XpOwmWoP1bHJucpQcq1O9wlVLfLO8+Y981GQ43Ndod44m7woK7?=
 =?us-ascii?Q?O5fVHynmVTmAvpjcIBz64fT6LgzcUWRgDIVmewIaZe++tR0HFwOk54SNOQz6?=
 =?us-ascii?Q?VOxCMrLB0lIwVNOIpLxhDRZ2qxbJRRVpR4fnQ0XxN2E1WOhbVyrms5iK9OgV?=
 =?us-ascii?Q?WBNrrAJ1+/7a6tR8uDmaObWS4ni/2POHgrTCk8Icwk38goA34PSpEZNh1wRd?=
 =?us-ascii?Q?L+5wELx3uNqYt6WzPs62ayQ/lnMjph64kF5Qa2wUHJVJRpiYwPf3vL5pHyIX?=
 =?us-ascii?Q?9/oP5BJ9r21qWy6nE8DRnWOZwiNVrtHJ1KjKkokEJBQGGrFhs+Qd/lEDHiMw?=
 =?us-ascii?Q?AqfD2VtmbO63V+ZivG9oKlXl6X4klCq7sidbICV8vF0JK/EDvRHEzTXX2qRm?=
 =?us-ascii?Q?LYxeTIMwdPi385CyP3OPR49WEV8RvDzVkD6SQCUIQ7Pv0cibMdnQurO1WqFZ?=
 =?us-ascii?Q?FuFJHzAdm7Gqr7BQSW13NHN7r1+/NVVwwKs/hoPkKYl3mXjnxkBiHlkrnWD+?=
 =?us-ascii?Q?LiX0yMpZLRG/KDhti6wboLouo8MpBZe12AS1dPa1HcxLDbltpinE/M0PaaBu?=
 =?us-ascii?Q?K6V9fFkcLsB626D2ZHccvVxVjtiTGmVMJVSWiBoCOKAWAWAaEf9Y0zHRdbht?=
 =?us-ascii?Q?qxw/Bck8OgNVorUELtv2ZF48AW6H32PJWrm2RP+bgCTNFw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p+ybhteq15scPzHj3JKUc0dl4EGMTBLl/QyCyP3rvqkkTHNBEkR8IIXEq3Tg?=
 =?us-ascii?Q?C/HcJ5A7Ps9S7IwLI1S+Pei/hlDp2FqeWdFPn6HuLk4q+/z3YqvW/bd9KlD/?=
 =?us-ascii?Q?1x0LPhGRNgIdGvAIQlsytYqxGKcG1AsbF9kENveg25aeJ767OUDLpRH+J7s+?=
 =?us-ascii?Q?VhPJbtA8sdtHJzyStkBqSQvAwcwRXsuvZAfPhHGKP6iuCLqrzQITbOntAoCP?=
 =?us-ascii?Q?ERHZsahUfcsU5mwOIA9+ZHPeFsSIhMhn33kNVefxTTHVJWuOfjj2a9DGO3Ai?=
 =?us-ascii?Q?aBWk6y2IoYArAn7t1kb3oMf7BBmMoKbuyWicQIPebbIm2ehZpk8xhBfm9skw?=
 =?us-ascii?Q?DWfJ6kkhcMfXbwru7KXO1kXTWBGOwj0CJr/Parr6nGUsTOvUiY8tL5OGbxM3?=
 =?us-ascii?Q?yjT0NHD8+4576x8/iXWiJFaihAZHiHyeiYqZ+gHloewtOz4bghw0c7u2UcMx?=
 =?us-ascii?Q?6jOJz2s7Oz6GN8D7Z0ffZZ6m5PhULpV057VRTao8nCUBQgDCxrgFA7zVGVRP?=
 =?us-ascii?Q?prp5kHvjvOkeIwxEvtlf48k3L5ZqB//g0gm/gC5U/U9xev2ML2d2c8a8fJNq?=
 =?us-ascii?Q?pZiCbxyoQ0xixsToCb/GaVWJlogZOVrz5sMUCCErSQ1z6sXwmXn0eKvl9gjh?=
 =?us-ascii?Q?bT6xyRAVqPa5tOl6af0o/3TUu1EGcipCjAiR3TaKcDhgHOitNME86S9V1CMz?=
 =?us-ascii?Q?Ep4CDM8ohWquZhWoQZiAJj7ZQjbcnla8NXhhlHGPBcBIO9FswNRStS2/iHpk?=
 =?us-ascii?Q?Dtwte8loMOCc2apgK9soWt7lhmzWJ2vK8MMl1KmzgTpoEZBIpJK09KtfmQ/B?=
 =?us-ascii?Q?W7o66liMkNRBJBvkS+zdeAol3ZFRCd0BLCGstE0VdD1of67CZ7FPsoi2bGYN?=
 =?us-ascii?Q?4DtrVbT3bvcX0ATOQBNqoRrp8yzpE8vmGF/SG4t0cVmU13W7Bis5DLLo6jDk?=
 =?us-ascii?Q?Et5fBLQRXWuBEIHnXYwUn5zjImkRFRsgKtG0BtgWeXq72G0rp8dQS3CDyzvC?=
 =?us-ascii?Q?HofnuvfVVeInRppfyGub//84pr+Ull9W9/dc0UqXH5bGPiM6PDHh0Efbow38?=
 =?us-ascii?Q?pjbI34AjVWSdXx5e+awh7OBNkvfkZsHbt/f3XxmiCn36eo4KwZQhp5YGuDLF?=
 =?us-ascii?Q?2Gl3zVYRwFnLwPCTL7vpXuHneYqyw2Wo2K1JGPb2wNgjWzEhtUjk+2bhLUh2?=
 =?us-ascii?Q?ig180BdVi6nrjG3gd4vR8BG9QqH1aZkncKVWUTWJIH1PM8J4YpjtNrcJdXcu?=
 =?us-ascii?Q?5g0J8Re/2UI1OgiC3/7fAJcDDbX5mTVEhKt92Lj1czfaxq6xg636PlsecGju?=
 =?us-ascii?Q?eeHts0xPiNCJxZuCate56vR4d6CakRqBezHDjSdBzK0Qna9xn5ystALfBO4j?=
 =?us-ascii?Q?N+qw52TvO1sf6UV2kAN3pCSnbJwevbey6XBmFSPd+Pb4OPwieoG+uY2McgQR?=
 =?us-ascii?Q?dHwh0VdUI0Pyt+JL8RiWdSI+4kyKHCEmSGl8ZsiyHB5VEngZ0iaNgcxKWp8C?=
 =?us-ascii?Q?cd8/2y7NqGSqafrWPMsMJZ0zCuRuCsq5Lrjl7sW3dgUTdKoF4cMxv9s+K2FB?=
 =?us-ascii?Q?0OJ34zUqybYETM+Gze3fS9+P7XTOIUszATIsYACP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429c43bc-606a-456d-71c8-08dce0fae24b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 02:52:12.5814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DE05iQbLdiF++YWyOKojR093eZ4u+zTmiOn6ll+rKCbDSFiqvyWstq3Y4+i/XdgT1du9uIILmRfJIZM6pOsJrw==
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

Add regulator support for NXP PMIC pf9453 for imx91 qsb.

Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/regulator/Kconfig  |  15 ++
 drivers/power/regulator/Makefile |   1 +
 drivers/power/regulator/pf9453.c | 256 +++++++++++++++++++++++++++++++
 3 files changed, 272 insertions(+)
 create mode 100644 drivers/power/regulator/pf9453.c

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index 69dfb07df50..4aa963e745c 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -96,6 +96,21 @@ config SPL_DM_REGULATOR_PCA9450
 	This config enables implementation of driver-model regulator uclass
 	features for regulators on ROHM PCA9450 in SPL.
 
+config DM_REGULATOR_PF9453
+	bool "Enable Driver Model for NXP PF9453 regulators"
+	depends on DM_REGULATOR && DM_PMIC_PF9453
+	help
+	This config enables implementation of driver-model regulator uclass
+	features for regulators on NXP PF9453 PMICs. PF9453 contains 6 bucks
+	and 5 LDOS. The driver implements get/set api for value and enable.
+
+config SPL_DM_REGULATOR_PF9453
+	bool "Enable Driver Model for NXP PF9453 regulators in SPL"
+	depends on DM_REGULATOR_PF9453 && SPL
+	help
+	This config enables implementation of driver-model regulator uclass
+	features for regulators on ROHM PF9453 in SPL.
+
 config DM_REGULATOR_PF0900
 	bool "Enable Driver Model for NXP PF0900 regulators"
 	depends on DM_REGULATOR && DM_PMIC_PF0900
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index 7a580d45b72..9e9a4da6217 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_DM_REGULATOR_NPCM8XX) += npcm8xx_regulator.o
 obj-$(CONFIG_$(SPL_)DM_PMIC_PFUZE100) += pfuze100.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_BD71837) += bd71837.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_PCA9450) += pca9450.o
+obj-$(CONFIG_$(SPL_)DM_REGULATOR_PF9453) += pf9453.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_PF0900) += pf0900.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_PF5300) += pf5300.o
 obj-$(CONFIG_$(SPL_)REGULATOR_PWM) += pwm_regulator.o
diff --git a/drivers/power/regulator/pf9453.c b/drivers/power/regulator/pf9453.c
new file mode 100644
index 00000000000..d11c69c33e6
--- /dev/null
+++ b/drivers/power/regulator/pf9453.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * NXP PF9453 regulator driver
+ * Copyright 2024 NXP
+ */
+
+#include <dm.h>
+#include <errno.h>
+#include <log.h>
+#include <linux/bitops.h>
+#include <power/pf9453.h>
+#include <power/pmic.h>
+#include <power/regulator.h>
+
+/**
+ * struct pf9453_vrange - describe linear range of voltages
+ *
+ * @min_volt:	smallest voltage in range
+ * @step:	how much voltage changes at each selector step
+ * @min_sel:	smallest selector in the range
+ * @max_sel:	maximum selector in the range
+ */
+struct pf9453_vrange {
+	unsigned int	min_volt;
+	unsigned int	step;
+	u8		min_sel;
+	u8		max_sel;
+};
+
+/**
+ * struct pf9453_plat - describe regulator control registers
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
+struct pf9453_plat {
+	const char		*name;
+	u8			enable_reg;
+	u8			enablemask;
+	u8			volt_reg;
+	u8			volt_mask;
+	struct pf9453_vrange	*ranges;
+	unsigned int		numranges;
+};
+
+#define PCA_RANGE(_min, _vstep, _sel_low, _sel_hi) \
+{ \
+	.min_volt = (_min), .step = (_vstep), \
+	.min_sel = (_sel_low), .max_sel = (_sel_hi), \
+}
+
+#define PCA_DATA(_name, enreg, enmask, vreg, vmask, _range) \
+{ \
+	.name = (_name), .enable_reg = (enreg), .enablemask = (enmask), \
+	.volt_reg = (vreg), .volt_mask = (vmask), .ranges = (_range), \
+	.numranges = ARRAY_SIZE(_range) \
+}
+
+static struct pf9453_vrange pf9453_buck134_vranges[] = {
+	PCA_RANGE(600000, 25000, 0, 0x7f),
+};
+
+static struct pf9453_vrange pf9453_buck2_vranges[] = {
+	PCA_RANGE(600000, 12500, 0, 0x7f),
+};
+
+static struct pf9453_vrange pf9453_ldo1_vranges[] = {
+	PCA_RANGE(800000, 25000, 0x0, 0x64),
+};
+
+static struct pf9453_vrange pf9453_ldo2_vranges[] = {
+	PCA_RANGE(500000, 25000, 0x0, 0x3a),
+};
+
+static struct pf9453_vrange pf9453_ldosnvs_vranges[] = {
+	PCA_RANGE(800000, 25000, 0x0, 0x58),
+};
+
+static struct pf9453_plat pf9453_reg_data[] = {
+	PCA_DATA("BUCK1", PF9453_BUCK1CTRL, PF9453_EN_MODE_MASK,
+		 PF9453_BUCK1OUT, PF9453_BUCK_RUN_MASK,
+		 pf9453_buck134_vranges),
+	PCA_DATA("BUCK2", PF9453_BUCK2CTRL, PF9453_EN_MODE_MASK,
+		 PF9453_BUCK2OUT, PF9453_BUCK_RUN_MASK,
+		 pf9453_buck2_vranges),
+	PCA_DATA("BUCK3", PF9453_BUCK3CTRL, PF9453_EN_MODE_MASK,
+		 PF9453_BUCK3OUT, PF9453_BUCK_RUN_MASK,
+		 pf9453_buck134_vranges),
+	PCA_DATA("BUCK4", PF9453_BUCK4CTRL, PF9453_EN_MODE_MASK,
+		 PF9453_BUCK4OUT, PF9453_BUCK_RUN_MASK,
+		 pf9453_buck134_vranges),
+	/* LDOs */
+	PCA_DATA("LDO1", PF9453_LDO1CFG, PF9453_EN_MODE_MASK,
+		 PF9453_LDO1OUT_H, PF9453_LDO1_MASK,
+		 pf9453_ldo1_vranges),
+	PCA_DATA("LDO2", PF9453_LDO2CFG, PF9453_EN_MODE_MASK,
+		 PF9453_LDO2OUT, PF9453_LDO2_MASK,
+		 pf9453_ldo2_vranges),
+	PCA_DATA("LDOS_NVS", PF9453_LDOSNVS_CFG2, PF9453_EN_MODE_MASK,
+		 PF9453_LDOSNVS_CFG1, PF9453_LDOSNVS_MASK,
+		 pf9453_ldosnvs_vranges),
+};
+
+static int vrange_find_value(struct pf9453_vrange *r, unsigned int sel,
+			     unsigned int *val)
+{
+	if (!val || sel < r->min_sel || sel > r->max_sel)
+		return -EINVAL;
+
+	*val = r->min_volt + r->step * (sel - r->min_sel);
+	return 0;
+}
+
+static int vrange_find_selector(struct pf9453_vrange *r, int val,
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
+static int pf9453_get_enable(struct udevice *dev)
+{
+	struct pf9453_plat *plat = dev_get_plat(dev);
+	int val;
+
+	val = pmic_reg_read(dev->parent, plat->enable_reg);
+	if (val < 0)
+		return val;
+
+	return (val & plat->enablemask);
+}
+
+static int pf9453_set_enable(struct udevice *dev, bool enable)
+{
+	int val = 0;
+	struct pf9453_plat *plat = dev_get_plat(dev);
+
+	if (enable)
+		val = plat->enablemask;
+
+	return pmic_clrsetbits(dev->parent, plat->enable_reg, plat->enablemask,
+			       val);
+}
+
+static int pf9453_get_value(struct udevice *dev)
+{
+	struct pf9453_plat *plat = dev_get_plat(dev);
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
+		struct pf9453_vrange *r = &plat->ranges[i];
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
+static int pf9453_set_value(struct udevice *dev, int uvolt)
+{
+	struct pf9453_plat *plat = dev_get_plat(dev);
+	unsigned int sel;
+	int i, found = 0;
+
+	for (i = 0; i < plat->numranges; i++) {
+		struct pf9453_vrange *r = &plat->ranges[i];
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
+	return pmic_clrsetbits(dev->parent, plat->volt_reg,
+			       plat->volt_mask, sel);
+}
+
+static int pf9453_regulator_probe(struct udevice *dev)
+{
+	struct pf9453_plat *plat = dev_get_plat(dev);
+	int i, type;
+
+	type = dev_get_driver_data(dev_get_parent(dev));
+
+	if (type != NXP_CHIP_TYPE_PF9453) {
+		debug("Unknown PMIC type\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(pf9453_reg_data); i++) {
+		if (strcmp(dev->name, pf9453_reg_data[i].name))
+			continue;
+		*plat = pf9453_reg_data[i];
+		return 0;
+	}
+
+	pr_err("Unknown regulator '%s'\n", dev->name);
+
+	return -ENOENT;
+}
+
+static const struct dm_regulator_ops pf9453_regulator_ops = {
+	.get_value	= pf9453_get_value,
+	.set_value	= pf9453_set_value,
+	.get_enable	= pf9453_get_enable,
+	.set_enable	= pf9453_set_enable,
+};
+
+U_BOOT_DRIVER(pf9453_regulator) = {
+	.name		= PF9453_REGULATOR_DRIVER,
+	.id		= UCLASS_REGULATOR,
+	.ops		= &pf9453_regulator_ops,
+	.probe		= pf9453_regulator_probe,
+	.plat_auto	= sizeof(struct pf9453_plat),
+};
-- 
2.35.3

