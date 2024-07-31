Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0362CC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 10:21:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A03CA88A0D;
	Wed, 31 Jul 2024 12:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="OuHBvr1o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1793F88A0C; Wed, 31 Jul 2024 12:20:38 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A78288A16
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 12:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDB89vOfIE5xu/yLNrojPls7YdL6YgRqwiWij2difBPJDMXQ9dc35/Lc2taPeOUQ/xs5uZaUWgLATqQPwtLH42+AK3SXIlr31lUlPvp6RWw9US7+J2LUUyT73Dm8tGbtVOavDiogq8vpFL5T8MzoN+c614lE86lOZKtyx9M7VI0tNp3UausANK1xZR4o8dO8cfgItjlGtNA6KFukSlEEWWxqzg6OUxX6adei+CnmmBj+422tUb7UQpKnn7FpREZU1s6GtauITdpppI58A3SpaKPilENyRJxfM7UzJ4G9xa9Jo0p2Y8cN/QDQAYOwAhiIW+QDsTM8RZ0gf//MRZM9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7mUxLs9yIKkzXiVmWcmjsY1c8jK+OtnbNkI5G0tNLY=;
 b=kTmn2EaS+uogAXIPK723wVlZkuO4uF0nhocc5Hlu5C/ku8Y4ObHarNugwp8DjSFJWKqVPr065H1NV7Q+rxDRaqZJw0mZhz/65oWasSIQd6XiVTjj04X1kOoXbhVZpMqR2SjtuminL/qf9QnIxpSa5kntsCewEhU9kVWKD9fArPbGuXbleiytCP0uAaQx9h8Bjfde2OX5FX4GlCxiSB7i+yjKfwWuzXRQVzd0ezAirEm0woWor4d11tKx6AnqmOepjE1vsVkfQG3uDgePUydCXSa/qQSsdEBW/aEBjp818jIDX77tNsxZTNFYdlcCk3Jk1gZ0DhaXVNeLYRaDzKyz1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7mUxLs9yIKkzXiVmWcmjsY1c8jK+OtnbNkI5G0tNLY=;
 b=OuHBvr1oR/0kEyNS0cDfCqkiDii2ojwlKiA1tEuF+zDP82yCRi9S7787OGUeVJLlcoAldhwDeSLQW+7w4KLmWhQYHo382x1RAj0K1fYGFwqFnf4FbT8gztKFbsAA/3/GVheFEqHnxM2mPk6MStfNAWXKGz8fgoiH758GebSS6Gxdu3XtmDaKAtGyk1kW8nEj2lcG7pyazb6xbhbDmSTJP9JhZd3tGvAboW+nAzIHGQGfNXmiEiof8i0GKFatAnPUrIiRWZ39kKWFIwT3F6LVP6PxAOc+gsbhmYYoxjHQ9JeDPwvo7CR3dox597u3E39Fsr8gUKKcZtoFD57iQdxRIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB10002.eurprd08.prod.outlook.com (2603:10a6:20b:63b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 10:20:32 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 10:20:32 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Bruce Suen <bruce_suen@163.com>, Igor Prusov <ivprusov@salutedevices.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 09/10] mtd: spinand: sync supported flashes with linux-6.10
Date: Wed, 31 Jul 2024 14:20:00 +0400
Message-Id: <20240731102001.4030460-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731102001.4030460-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731102001.4030460-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0139.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB10002:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4c39b4-15f0-440e-ae1f-08dcb14a685f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dwLQbYsSX+uqcN7hwXeoNrTKR89YOnkajhf4iiBYN6EQlDjJj4UDwycomugj?=
 =?us-ascii?Q?hJe7AY8rxhyA1OOZvc2LjDgTQ3vskF6OqZli2Y4I4d+L98djmW/jddklW3PH?=
 =?us-ascii?Q?zwDjt8FlucE5TxlFPlD3YnM1lhKo1MOxLan0XmtCWnuuPuZpraaHx7MAujks?=
 =?us-ascii?Q?E7GXJL53Kqr1ARMCnf4B5a3QGeMTZy6W+TNx6XD5dBTOWglED8mnyMD+VzHk?=
 =?us-ascii?Q?f4uxxKXPGS69jvGLdGmrjjqT70jcgeXIIr0lB5Rgjz8ZP/gZsXqC9E5Mxmi2?=
 =?us-ascii?Q?UpYCKYUKZjX6u4PAWbkFHDO2f/IXIORGD3riic9+ktaXhjuHL4iOJ4dsPMMe?=
 =?us-ascii?Q?pCHgWUnuk4aHpDZb0T77ulDIhM8oogm+v8x3zjX15ba2pOozEH7SF35ytXXw?=
 =?us-ascii?Q?MFLHXH2YvaPIX5lqEPrmrt6u3hj5woJaGlp/y29rl7RY+zBhlqVGbP7avbm+?=
 =?us-ascii?Q?/+CyiBe/GkvoY2lpcY72YaiDJZk8PBbRr0QJGnPoD0WfnVUXKIDpdOYCs6Qh?=
 =?us-ascii?Q?wqi8oDKVjVrLdvkFS6ZNFoVo7/946Otu79jJyasUiL8kKfz/92RCqMZ7dOvn?=
 =?us-ascii?Q?d9QyPE+AiIMzpJEH/8orlMGeAYmvCvofP+bu1hzdYAl7+yfOj6MJqeuTx5fB?=
 =?us-ascii?Q?noqRwt3YsQiEkOooEj/WnGRdclH94zwgnvGk0npUf682p+k7kI6KpS/2j+bk?=
 =?us-ascii?Q?K0YN02h5Qfv67Tr2F2O/snh7WmCpAotIcnsJDvyUrHkof1EB8Atq4f2jdGBX?=
 =?us-ascii?Q?5hRCfR5iQ1qf8M9YtkahlW/1lv+4Lk5j5XfembsxiT4PBz0f7Bn/5kmDvTKD?=
 =?us-ascii?Q?3yzQKzCrTPGjh+DgJk9k6BXzehwWqc/H64j8HxWqGv+krDrOMbDvTpYU92Y/?=
 =?us-ascii?Q?RQsYACGgF3Cqw9gJ0uh2ipXEK6R6/sm+3C1NFY2iYjnkDYZ3CbFC/5xcn0fL?=
 =?us-ascii?Q?2T8IcXYEP9XcUvXsE3zSJNX6IMScIco1QkE9Xwvx9UNV6q/2vcoWJ54isv2W?=
 =?us-ascii?Q?DWqmTa4IpG5kXC/q015Kw6pFfPpuRGrB/FabsCPcw5TQ9cdm6KG+iYnRaaSM?=
 =?us-ascii?Q?Hd4Y2QiHrfCYqL7B2Q/xN5Bh3IOD/JE6IOw6SLLp34YB5pKppRLlcoxvcYyd?=
 =?us-ascii?Q?HHPztKbMGUUPjKnWLV89vbc8BbwGpI7SGPI45/PaEaStAEdmd//Z3O0Ar8W0?=
 =?us-ascii?Q?ounsaMNA6prGLMpidrRw3AezJ6G3kycBG0gfUL7Ld5wRWBG31j5SlkOF59Dv?=
 =?us-ascii?Q?lXoGtwrkTlr3hMmouNCkuKeAaOaNo9depPP027Nup/FCJVWNxhZWgwXQBOhK?=
 =?us-ascii?Q?/KYVDChHYWnS5qkH7iaeV03AGrdUhn6tcuzVyjnrnFQBOWqBhtQrP4/UZJYu?=
 =?us-ascii?Q?ZzS5jIQ1ccZcGiJ4Gvh9IcCt7/EADyLbuomphoTyefB4j87WXSALNqWrE4B9?=
 =?us-ascii?Q?N1W4pyKz8Ew=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?luCBFkSokxVTwWIcIZFIt7K8hFDHpC/i93wKUiDLj7J7xLuqQkFOl/Li8MwG?=
 =?us-ascii?Q?q/V7log2NCgdWZ2JyKGQ/+D3ss4QSDePM56lVpXWnuQMJLdixHcQ1W0yEuvw?=
 =?us-ascii?Q?I0ZhaklGnVihqTVPYWPmRDlBRhrgLmG/PknnbuuSGr+xbPa8K9xywDHTU93g?=
 =?us-ascii?Q?TYBJVjwiwlGW+ma3DCeyAY0/p6d2Y5FL8SWVUIZ8xwEL+5Hw4Ykb8ExJbNu/?=
 =?us-ascii?Q?v8GAO+oq3MWLP+aHQevnZGEDtUwsGU8VhGWrc8PYv53gzRehdYY8X2DnvlWE?=
 =?us-ascii?Q?0/ye8D9ZoJAlUs/VBn+2vGQpb8Q7MN1gVYzze+TF4Jq5+Ep+LyX0+pV0KQPu?=
 =?us-ascii?Q?xyPVGkJwRUbPwoZ4oScA7xQh0jzryyL9vFL6eaWKcSSA5gL7J1WQON9fY5uL?=
 =?us-ascii?Q?oBVhA0kvHUcH2f8Ex7/EgwoWmdhKCT/yEFjMvgCDe2gzsWXMYBDq4KQpDah0?=
 =?us-ascii?Q?zjLbVij2aSptr7eVVEseY6xCq2KxnMgBYVXf3tiSt3aeGhLIS9NHdxCLT7/G?=
 =?us-ascii?Q?pJJWIMesJR1C6thIQIG6fWAmbJePTebi7e+DDVS3JnCUEjOpsd2v40SJaULC?=
 =?us-ascii?Q?TEhD52sUeEWjO67FK+ccX5XJTjEDQBrc41XHHKs8yhvhTMGVbCMLLNu1x5qe?=
 =?us-ascii?Q?1g2oQgkmT/xvfgamsxXFD54b8jC/DkROHs8K7rtIAbndngf5aSKL2LaLV+1D?=
 =?us-ascii?Q?D0nZICwI+WjgvVKnDmpG269Ueb8oNNxIRvLYRR+ehuP+aeV5tTEFbx2q+2LA?=
 =?us-ascii?Q?8fsz5crnoVW60w4NEASTttCRL2DdaUzBvKkicMxAriqUDLomMPt9AFLnPlzq?=
 =?us-ascii?Q?KEdEfkFQuJiJNa9YfFBO68CqFOeStML8a4x1/s2IawpBMoZgJHSkBw61i5b+?=
 =?us-ascii?Q?Cojio+kGZqjK90O9uM+MNFU2K0U3YSQ2hbQ412hW8B+6c1MrSRzOl7aLwb+Z?=
 =?us-ascii?Q?Oke0QHZxZYXKXNVzJuq2QRqxDtqyWZUKxtCiFRYJNFQ7C13cmzv9+eyiY9cf?=
 =?us-ascii?Q?JCeN1LgQKx91J/sDnBpJgz+c7FKabto1FbXCaq4M2270CvfnOP2KtpkpFVdN?=
 =?us-ascii?Q?DxDIJEg3Oxi7hAx0oIvXQxSdy1nvi/gKiEh1itZBheuwMVycvvF8nq8zz3OT?=
 =?us-ascii?Q?X7eJJmBuKWsHN82+Ga/Eyp0kjme3uaerSppEbqgXPN5EB9XtHTsT0eCAz/5t?=
 =?us-ascii?Q?m9nq4IQTrIER+vX46PXB1+csu3lY8szbV3cwqeWZHV2ocU5L3oJ8vZZTnU4G?=
 =?us-ascii?Q?kGmcZ0lMMB3xjmfiaR8ML6QFjNBWxBVrML7yH0OdERN79BB3D6Ky5O+PHSQg?=
 =?us-ascii?Q?giz8WZ3pjRA2y45WCiWMKRY4f3z59hnwpmwoT2NoWyJ28e87upyuI+jICF71?=
 =?us-ascii?Q?gER+4aqMDypRiyWgP933ET0QKpFSmkdXxdudcFGjQawQTKtwQFXlNfm2svK0?=
 =?us-ascii?Q?6tJaSQ4aVUfUSxaWL2pXlbAiag7viOLWVmibm1xeafg93oWBfHE2oqbAMVC7?=
 =?us-ascii?Q?nxpREi9xNW3RSXniK4yfWSYK5aWK+/1ZQtx4Hcc3m/nFltYJquWcSAgKplDc?=
 =?us-ascii?Q?jwOfrMITtzNA/09kSen/t6jGdDyZeg7P0kCvkqDIAg3QpkfoCcOH4ThNLSNG?=
 =?us-ascii?Q?LfCe/1GkycZL0dkueqM+2j0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4c39b4-15f0-440e-ae1f-08dcb14a685f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 10:20:31.9439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jbleTsQP2MzCKLAvYlHbF5BpuQ5PCVQimkTQJ+xKiR7ygXBu9xpuKzcfGzBVMjxxmJbYpaBb0jd7AWCYhwihNRC316NDLZUNOF4jCIBRQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10002
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

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/Makefile         |   4 +-
 drivers/mtd/nand/spi/alliancememory.c | 155 ++++++++++++++++++++
 drivers/mtd/nand/spi/ato.c            |  84 +++++++++++
 drivers/mtd/nand/spi/core.c           |   5 +-
 drivers/mtd/nand/spi/esmt.c           |  16 ++-
 drivers/mtd/nand/spi/foresee.c        |  97 +++++++++++++
 drivers/mtd/nand/spi/gigadevice.c     | 194 +++++++++++++++++++++++++-
 drivers/mtd/nand/spi/macronix.c       |  25 +++-
 drivers/mtd/nand/spi/toshiba.c        |  33 +++++
 drivers/mtd/nand/spi/winbond.c        |  57 ++++++++
 include/linux/mtd/spinand.h           |   5 +-
 11 files changed, 664 insertions(+), 11 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/alliancememory.c
 create mode 100644 drivers/mtd/nand/spi/ato.c
 create mode 100644 drivers/mtd/nand/spi/foresee.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index 65b836b34ca..d438747cf37 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-spinand-objs := core.o esmt.o gigadevice.o macronix.o micron.o paragon.o
-spinand-objs += toshiba.o winbond.o xtx.o
+spinand-objs := core.o alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
+spinand-objs += micron.o paragon.o toshiba.o winbond.o xtx.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/alliancememory.c b/drivers/mtd/nand/spi/alliancememory.c
new file mode 100644
index 00000000000..e29e4cc77ec
--- /dev/null
+++ b/drivers/mtd/nand/spi/alliancememory.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Mario Kicherer <dev@kicherer.org>
+ */
+
+#ifndef __UBOOT__
+#include <linux/device.h>
+#include <linux/kernel.h>
+#endif
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_ALLIANCEMEMORY	0x52
+
+#define AM_STATUS_ECC_BITMASK		(3 << 4)
+
+#define AM_STATUS_ECC_NONE_DETECTED	(0 << 4)
+#define AM_STATUS_ECC_CORRECTED		(1 << 4)
+#define AM_STATUS_ECC_ERRORED		(2 << 4)
+#define AM_STATUS_ECC_MAX_CORRECTED	(3 << 4)
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+			   SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+			   SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+			   SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+			   SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+static int am_get_eccsize(struct mtd_info *mtd)
+{
+	if (mtd->oobsize == 64)
+		return 0x20;
+	else if (mtd->oobsize == 128)
+		return 0x38;
+	else if (mtd->oobsize == 256)
+		return 0x70;
+	else
+		return -EINVAL;
+}
+
+static int am_ooblayout_ecc(struct mtd_info *mtd, int section,
+			    struct mtd_oob_region *region)
+{
+	int ecc_bytes;
+
+	ecc_bytes = am_get_eccsize(mtd);
+	if (ecc_bytes < 0)
+		return ecc_bytes;
+
+	region->offset = mtd->oobsize - ecc_bytes;
+	region->length = ecc_bytes;
+
+	return 0;
+}
+
+static int am_ooblayout_free(struct mtd_info *mtd, int section,
+			     struct mtd_oob_region *region)
+{
+	int ecc_bytes;
+
+	if (section)
+		return -ERANGE;
+
+	ecc_bytes = am_get_eccsize(mtd);
+	if (ecc_bytes < 0)
+		return ecc_bytes;
+
+	/*
+	 * It is unclear how many bytes are used for the bad block marker. We
+	 * reserve the common two bytes here.
+	 *
+	 * The free area in this kind of flash is divided into chunks where the
+	 * first 4 bytes of each chunk are unprotected. The number of chunks
+	 * depends on the specific model. The models with 4096+256 bytes pages
+	 * have 8 chunks, the others 4 chunks.
+	 */
+
+	region->offset = 2;
+	region->length = mtd->oobsize - 2 - ecc_bytes;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops am_ooblayout = {
+	.ecc = am_ooblayout_ecc,
+	.rfree = am_ooblayout_free,
+};
+
+static int am_ecc_get_status(struct spinand_device *spinand, u8 status)
+{
+	switch (status & AM_STATUS_ECC_BITMASK) {
+	case AM_STATUS_ECC_NONE_DETECTED:
+		return 0;
+
+	case AM_STATUS_ECC_CORRECTED:
+		/*
+		 * use oobsize to determine the flash model and the maximum of
+		 * correctable errors and return maximum - 1 by convention
+		 */
+		if (spinand->base.mtd->oobsize == 64)
+			return 3;
+		else
+			return 7;
+
+	case AM_STATUS_ECC_ERRORED:
+		return -EBADMSG;
+
+	case AM_STATUS_ECC_MAX_CORRECTED:
+		/*
+		 * use oobsize to determine the flash model and the maximum of
+		 * correctable errors
+		 */
+		if (spinand->base.mtd->oobsize == 64)
+			return 4;
+		else
+			return 8;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static const struct spinand_info alliancememory_spinand_table[] = {
+	SPINAND_INFO("AS5F34G04SND",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x2f),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&am_ooblayout,
+				     am_ecc_get_status)),
+};
+
+static const struct spinand_manufacturer_ops alliancememory_spinand_manuf_ops = {
+};
+
+const struct spinand_manufacturer alliancememory_spinand_manufacturer = {
+	.id = SPINAND_MFR_ALLIANCEMEMORY,
+	.name = "AllianceMemory",
+	.chips = alliancememory_spinand_table,
+	.nchips = ARRAY_SIZE(alliancememory_spinand_table),
+	.ops = &alliancememory_spinand_manuf_ops,
+};
diff --git a/drivers/mtd/nand/spi/ato.c b/drivers/mtd/nand/spi/ato.c
new file mode 100644
index 00000000000..f0d4436cf45
--- /dev/null
+++ b/drivers/mtd/nand/spi/ato.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Aidan MacDonald
+ *
+ * Author: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
+ */
+
+#ifndef __UBOOT__
+#include <linux/device.h>
+#include <linux/kernel.h>
+#endif
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_ATO		0x9b
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+static int ato25d1ga_ooblayout_ecc(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = (16 * section) + 8;
+	region->length = 8;
+	return 0;
+}
+
+static int ato25d1ga_ooblayout_free(struct mtd_info *mtd, int section,
+				    struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	if (section) {
+		region->offset = (16 * section);
+		region->length = 8;
+	} else {
+		/* first byte of section 0 is reserved for the BBM */
+		region->offset = 1;
+		region->length = 7;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops ato25d1ga_ooblayout = {
+	.ecc = ato25d1ga_ooblayout_ecc,
+	.rfree = ato25d1ga_ooblayout_free,
+};
+
+static const struct spinand_info ato_spinand_table[] = {
+	SPINAND_INFO("ATO25D1GA",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x12),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&ato25d1ga_ooblayout, NULL)),
+};
+
+static const struct spinand_manufacturer_ops ato_spinand_manuf_ops = {
+};
+
+const struct spinand_manufacturer ato_spinand_manufacturer = {
+	.id = SPINAND_MFR_ATO,
+	.name = "ATO",
+	.chips = ato_spinand_table,
+	.nchips = ARRAY_SIZE(ato_spinand_table),
+	.ops = &ato_spinand_manuf_ops,
+};
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 00adc08976e..9cc094110f8 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -861,13 +861,16 @@ static const struct nand_ops spinand_ops = {
 };
 
 static const struct spinand_manufacturer *spinand_manufacturers[] = {
+	&alliancememory_spinand_manufacturer,
+	&ato_spinand_manufacturer,
+	&esmt_c8_spinand_manufacturer,
+	&foresee_spinand_manufacturer,
 	&gigadevice_spinand_manufacturer,
 	&macronix_spinand_manufacturer,
 	&micron_spinand_manufacturer,
 	&paragon_spinand_manufacturer,
 	&toshiba_spinand_manufacturer,
 	&winbond_spinand_manufacturer,
-	&esmt_c8_spinand_manufacturer,
 	&xtx_spinand_manufacturer,
 };
 
diff --git a/drivers/mtd/nand/spi/esmt.c b/drivers/mtd/nand/spi/esmt.c
index 7e07b26827a..23be098b885 100644
--- a/drivers/mtd/nand/spi/esmt.c
+++ b/drivers/mtd/nand/spi/esmt.c
@@ -106,7 +106,8 @@ static const struct mtd_ooblayout_ops f50l1g41lb_ooblayout = {
 
 static const struct spinand_info esmt_c8_spinand_table[] = {
 	SPINAND_INFO("F50L1G41LB",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x01),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x01, 0x7f,
+				0x7f, 0x7f),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -115,7 +116,8 @@ static const struct spinand_info esmt_c8_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
 	SPINAND_INFO("F50D1G41LB",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x11),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x11, 0x7f,
+				0x7f, 0x7f),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -123,6 +125,16 @@ static const struct spinand_info esmt_c8_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
+	SPINAND_INFO("F50D2G41KA",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x51, 0x7f,
+				0x7f, 0x7f),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
 };
 
 static const struct spinand_manufacturer_ops esmt_spinand_manuf_ops = {
diff --git a/drivers/mtd/nand/spi/foresee.c b/drivers/mtd/nand/spi/foresee.c
new file mode 100644
index 00000000000..7d141cdd658
--- /dev/null
+++ b/drivers/mtd/nand/spi/foresee.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2023, SberDevices. All Rights Reserved.
+ *
+ * Author: Martin Kurbanov <mmkurbanov@salutedevices.com>
+ */
+
+#ifndef __UBOOT__
+#include <linux/device.h>
+#include <linux/kernel.h>
+#endif
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_FORESEE		0xCD
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+static int f35sqa002g_ooblayout_ecc(struct mtd_info *mtd, int section,
+				    struct mtd_oob_region *region)
+{
+	return -ERANGE;
+}
+
+static int f35sqa002g_ooblayout_free(struct mtd_info *mtd, int section,
+				     struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	/* Reserve 2 bytes for the BBM. */
+	region->offset = 2;
+	region->length = 62;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops f35sqa002g_ooblayout = {
+	.ecc = f35sqa002g_ooblayout_ecc,
+	.rfree = f35sqa002g_ooblayout_free,
+};
+
+static int f35sqa002g_ecc_get_status(struct spinand_device *spinand, u8 status)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case STATUS_ECC_HAS_BITFLIPS:
+		return nand->eccreq.strength;
+
+	default:
+		break;
+	}
+
+	/* More than 1-bit error was detected in one or more sectors and
+	 * cannot be corrected.
+	 */
+	return -EBADMSG;
+}
+
+static const struct spinand_info foresee_spinand_table[] = {
+	SPINAND_INFO("F35SQA002G",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x72, 0x72),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&f35sqa002g_ooblayout,
+				     f35sqa002g_ecc_get_status)),
+};
+
+static const struct spinand_manufacturer_ops foresee_spinand_manuf_ops = {
+};
+
+const struct spinand_manufacturer foresee_spinand_manufacturer = {
+	.id = SPINAND_MFR_FORESEE,
+	.name = "FORESEE",
+	.chips = foresee_spinand_table,
+	.nchips = ARRAY_SIZE(foresee_spinand_table),
+	.ops = &foresee_spinand_manuf_ops,
+};
diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index f2ecf47f8d4..f3608a13d8e 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -43,6 +43,22 @@ static SPINAND_OP_VARIANTS(read_cache_variants_f,
 		SPINAND_PAGE_READ_FROM_CACHE_OP_3A(true, 0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_OP_3A(false, 0, 0, NULL, 0));
 
+static SPINAND_OP_VARIANTS(read_cache_variants_1gq5,
+		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(read_cache_variants_2gq5,
+		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 4, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 2, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
 		SPINAND_PROG_LOAD(true, 0, NULL, 0));
@@ -174,7 +190,7 @@ static int gd5fxgq4uexxg_ecc_get_status(struct spinand_device *spinand,
 {
 	u8 status2;
 	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(GD5FXGQXXEXXG_REG_STATUS2,
-						      &status2);
+						      spinand->scratchbuf);
 	int ret;
 
 	switch (status & STATUS_ECC_MASK) {
@@ -195,6 +211,7 @@ static int gd5fxgq4uexxg_ecc_get_status(struct spinand_device *spinand,
 		 * report the maximum of 4 in this case
 		 */
 		/* bits sorted this way (3...0): ECCS1,ECCS0,ECCSE1,ECCSE0 */
+		status2 = *(spinand->scratchbuf);
 		return ((status & STATUS_ECC_MASK) >> 2) |
 			((status2 & STATUS_ECC_MASK) >> 4);
 
@@ -216,7 +233,7 @@ static int gd5fxgq5xexxg_ecc_get_status(struct spinand_device *spinand,
 {
 	u8 status2;
 	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(GD5FXGQXXEXXG_REG_STATUS2,
-						      &status2);
+						      spinand->scratchbuf);
 	int ret;
 
 	switch (status & STATUS_ECC_MASK) {
@@ -236,6 +253,7 @@ static int gd5fxgq5xexxg_ecc_get_status(struct spinand_device *spinand,
 		 * 1 ... 4 bits are flipped (and corrected)
 		 */
 		/* bits sorted this way (1...0): ECCSE1, ECCSE0 */
+		status2 = *(spinand->scratchbuf);
 		return ((status2 & STATUS_ECC_MASK) >> 4) + 1;
 
 	case STATUS_ECC_UNCOR_ERROR:
@@ -329,6 +347,36 @@ static const struct spinand_info gigadevice_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
 				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F1GQ4RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xc1),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GQ4UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xd2),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GQ4RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xc2),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
 	SPINAND_INFO("GD5F1GQ4UFxxG",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE, 0xb1, 0x48),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
@@ -343,12 +391,152 @@ static const struct spinand_info gigadevice_spinand_table[] = {
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x51),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(4, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq5xexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F1GQ5RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x41),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq5xexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GQ5UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x52),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_2gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq5xexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GQ5RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x42),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_2gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq5xexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F4GQ6UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x55),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 2, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_2gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq5xexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F4GQ6RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x45),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 2, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_2gq5,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
 				     gd5fxgq5xexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F1GM7UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x91),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F1GM7RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x81),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GM7UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x92),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GM7RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x82),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F4GM8UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x95),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F4GM8RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x85),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GQ5xExxH",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x22),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_2gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F1GQ5RExxH",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x21),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F1GQ4RExxH",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xc9),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops gigadevice_spinand_manuf_ops = {
diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 86bffc2800b..3d4a7f0c3cb 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -23,7 +23,7 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
-		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_variants,
 		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
@@ -86,9 +86,10 @@ static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
 		 * in order to avoid forcing the wear-leveling layer to move
 		 * data around if it's not necessary.
 		 */
-		if (mx35lf1ge4ab_get_eccsr(spinand, &eccsr))
+		if (mx35lf1ge4ab_get_eccsr(spinand, spinand->scratchbuf))
 			return nand->eccreq.strength;
 
+		eccsr = *spinand->scratchbuf;
 		if (WARN_ON(eccsr > nand->eccreq.strength || !eccsr))
 			return nand->eccreq.strength;
 
@@ -300,6 +301,26 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
 
+	SPINAND_INFO("MX31LF2GE4BC",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x2e),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX3UF2GE4BC",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xae),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops macronix_spinand_manuf_ops = {
diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index b9908e79271..ad48b1c7c8a 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -269,6 +269,39 @@ static const struct spinand_info toshiba_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
+	/* 1.8V 1Gb (1st generation) */
+	SPINAND_INFO("TC58NYG0S3HBAI4",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xA1),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
+	/* 1.8V 4Gb (1st generation) */
+	SPINAND_INFO("TH58NYG2S3HBAI4",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xAC),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 1, 2, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_x4_variants,
+					      &update_cache_x4_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
+	/* 1.8V 8Gb (1st generation) */
+	SPINAND_INFO("TH58NYG3S0HBAI6",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xA3),
+		     NAND_MEMORG(1, 4096, 256, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_x4_variants,
+					      &update_cache_x4_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops toshiba_spinand_manuf_ops = {
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index dd4ed257a83..c62096dc2e6 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -18,6 +18,8 @@
 
 #define WINBOND_CFG_BUF_READ		BIT(3)
 
+#define W25N04KV_STATUS_ECC_5_8_BITFLIPS	(3 << 4)
+
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
@@ -121,6 +123,7 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 		return -EBADMSG;
 
 	case STATUS_ECC_HAS_BITFLIPS:
+	case W25N04KV_STATUS_ECC_5_8_BITFLIPS:
 		/*
 		 * Let's try to retrieve the real maximum number of bitflips
 		 * in order to avoid forcing the wear-leveling layer to move
@@ -172,6 +175,60 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W25N01JW",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xbc, 0x21),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&w25m02gv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W25N02JWZEIF",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xbf, 0x22),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 2, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W25N512GW",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x20),
+		     NAND_MEMORG(1, 2048, 64, 64, 512, 10, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W25N02KWZEIR",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x22),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W25N01GWZEIG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x21),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&w25m02gv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W25N04KV",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x23),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 40, 2, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
 };
 
 static int winbond_spinand_init(struct spinand_device *spinand)
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index b701d25f73d..81a7b0dbbb2 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -266,13 +266,16 @@ struct spinand_manufacturer {
 };
 
 /* SPI NAND manufacturers */
+extern const struct spinand_manufacturer alliancememory_spinand_manufacturer;
+extern const struct spinand_manufacturer ato_spinand_manufacturer;
+extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
+extern const struct spinand_manufacturer foresee_spinand_manufacturer;
 extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
 extern const struct spinand_manufacturer macronix_spinand_manufacturer;
 extern const struct spinand_manufacturer micron_spinand_manufacturer;
 extern const struct spinand_manufacturer paragon_spinand_manufacturer;
 extern const struct spinand_manufacturer toshiba_spinand_manufacturer;
 extern const struct spinand_manufacturer winbond_spinand_manufacturer;
-extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
 extern const struct spinand_manufacturer xtx_spinand_manufacturer;
 
 /**
-- 
2.39.2

