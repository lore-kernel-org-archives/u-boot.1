Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F2ECCF9EA
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 13:02:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5505683700;
	Mon, 27 Oct 2025 14:02:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ghPvPX8L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44CF6832AD; Mon, 27 Oct 2025 07:37:25 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 532B180422
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 07:37:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5OTA+qmBEAz9OxU17TfujHTkHW9JidcbQ6efaFH+8mK+UNZZ2Fk292ltR0N/97ALqp1ylOtWW2BUoSSbr61tdxSyPxEq+mLzkSwiOb/m/RBa7UxnHRuQcCWMEica6pMYwYIBJ2goIUckBoESVzRhai6YsoNN6An6SpWxtVkhoXN0be7Bu338B0YQOD2eBuw8rOb1nrFMLz1U2pxp+mJcryIe098YzUrcbDKJ/6n6Ho8dALLmb/iks31D2z7tck3vTzd5W0M7FdYTmZrqp8u3bQHLJy0OgrsLstV9Ck2hFTZtCUbLBcW9T3aN5NQYqx28xC+fbfLmWTsSfn4XJu+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ci3rUptguqtBR53AW0Xn2CwBogK0idp7kFSU4pDsmAw=;
 b=icFtnNWS9O6Vs9sW71MR10p9IMn1rWRIJOUD0IAJcNScJtwvBiBqLcn62ZivW+MBes++Wnd7uHT7I9DRKyZLsr7uWwVeuAHEK1eEvB4m87plv0IpYDsqR57hUhYSphGeCG7eRspY50szWE1JDjoo3Pk8B6r6c4KM+Qz9Ym5wbKPrwxUo3P/Z8HBRCZKT1cobM4aXEBqxNLF0ofyFK04rtpug7yWNVuKpIwUxedBMvHK/qVV/h4yRzz+VgWEMdvjLp8+10LCTwDmeyYiTncyHlp2u9aagqgBdx4Wpbrl7Xw3asW3WQoRNWO2yieTdRB46uJnglGE7VP50a4dtmPcLGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ci3rUptguqtBR53AW0Xn2CwBogK0idp7kFSU4pDsmAw=;
 b=ghPvPX8Lv3dApI250O+Q4uRVactPZortY1gZk/cIpDAOeyot5u3wYTtM6f1oEuC2auUSqEz0dMXtq9DOaDP8WzR8zx9CN28jDG9SGRkUWjZKLQoZYebWT6TpOzNt/KXLXVYFmJQbTCXvJsep20hLWwQ5Zxwy9a0ikq8NioX6g7etpWwxCtovAfFayf08CX7fQ0AJtxbwaYVteNinrVPoIfYlfmFjlErRURmKAjOyWtfhgnyI6DdfGUGTt+iaQ/MJP1FGRqm1PlQGXenBM/c/Dwo5JCxAosvMcNn2dik95sIILYL1t+liI0Ib+pUaxgiTmjGf4k3OxrCSix0FVG+Dqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by SA5PR03MB8427.namprd03.prod.outlook.com (2603:10b6:806:477::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 06:37:20 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4%7]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 06:37:19 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 u-boot@lists.denx.de, Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [PATCH v2 1/1] spi: cadence: Add driver for xSPI
Date: Mon, 27 Oct 2025 14:36:54 +0800
Message-ID: <20251027063654.27188-2-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251027063654.27188-1-boon.khai.ng@altera.com>
References: <20251027063654.27188-1-boon.khai.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:217::8) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|SA5PR03MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: 229270f6-2964-42d6-6d42-08de1523470b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fQbccDBiiWVCefKkwp/wfNJgxNeM5me6I04j6n4tcUFAXwhBem/gvM9//LT0?=
 =?us-ascii?Q?4hZvp5aCKEO054uIn8dRqF9R05JTYczkmHYU2UaLxOAIyHZF5+bjmDz8OOo/?=
 =?us-ascii?Q?jTbs3/lD+sKd0u1VeoKk3EKz8E0FZd8BV3P+6ajBIEpvqIn9tvgnlTNlNeu/?=
 =?us-ascii?Q?jo93DGNkeBXo/EV7PnNIsOQWD6MGftRhnNq36CbPx716d0o/lgRTh7ctQpjL?=
 =?us-ascii?Q?6AViYbXM2g5RR2kOHyoBsSdfnj9XjEp4eJZbVkV4digp5SDq4IGrNseIFA6+?=
 =?us-ascii?Q?2ctOLWdG9J3KeaLQBVflMKghB7n4aWhQ+0s7CpzEzMz/XzxPfwYLphTCEQ1I?=
 =?us-ascii?Q?BZvNYmSwxPJLKki7Y5zope4nSK7MkA1dK5ksJZrARgS/PSXlmEEG81o413JX?=
 =?us-ascii?Q?f41760lbQ01Y666khRHxx4OhY76kvrDRLdYif5Vf2fKsUtNiC6v0gRyK1/q0?=
 =?us-ascii?Q?y3xJqnKeNI2+YKpzFSnZU1sbwOAdJ3pjQ+dwLriMUqurRWXxp7LNVSlfZvtV?=
 =?us-ascii?Q?RH+2WESnsATokkOTR+Mi0VqVyW4mAw9VcKv07SheZWn6Vi7P9zwmNjSTU5xO?=
 =?us-ascii?Q?masRBxiv7/tgHECdKKxkYcoykYfKlpYvwpOwstBVp+RQfGr2uoKl04loQ4Yk?=
 =?us-ascii?Q?xdGBs3JNMefIiZoO1KemtKHtCOaF5RUIAZ9j4N7IjFR+0Z37Dd7NlMyfl2LC?=
 =?us-ascii?Q?G++7dSk1ZUh1rNQH4Ly7pMW85O0H96SDIMwjqKRbLQbPi7MK4eiB1KJszBvo?=
 =?us-ascii?Q?QWp75zC/oo2TjC9lcNsfdk/ntfJ5rh+BFT3tzXp5PB5SyhQ2WZBnA9sOYEIa?=
 =?us-ascii?Q?Odr6UaFjLmUlrPteU5pCBuQ+lKpEUbZYTP8O9jGUv5HiLMvfFkbECYlB247s?=
 =?us-ascii?Q?p55NsEj/n9ze5/nWXUVE44bvCrUVGfP/hMgoiUbuWTlx7eZakO4CPJp6369g?=
 =?us-ascii?Q?2Z6ozPOrd6hBqUXWlbU76NNTbcWFXlNZ38yYZ2IXappsct3B1JWl2KEZAaU+?=
 =?us-ascii?Q?mj4f8q0U+wllpsnfbQu0De0MmkEU/H3w6oFr6b1fbRtgtt04LoSHEZyos01M?=
 =?us-ascii?Q?kne1zty3T74CeN0lyioXwzNRi5cQoiLoVVGCCi4aMMDMk16/H4HHfqhwmCrI?=
 =?us-ascii?Q?U3MkKP7of+it8KnQY+I+Krl3g0okxNouBiEpg4f5M1GpPpnMLWF8iwkBcLA6?=
 =?us-ascii?Q?Ad7/vPKNaqQWH067klSgZ7q5QXOHO9AJQBN6mmT/DqgHNDI02OHkorMHpnih?=
 =?us-ascii?Q?rJtk8gIvQJVdQBs0n9UbzeiD6QKtnhBRfopeJ/s9DdAnAIjhlj9vBeoorjlj?=
 =?us-ascii?Q?gpjVoEyqeSgZKOx/krCiEsCLXnRdoxD3zqLDjbCB/XJmTqJITh+ZCXFImAbB?=
 =?us-ascii?Q?H6piN/ZtK/ne1xWXUC/jhIh92g0f9taeFLR+F9haULqeTvnFxUNA/CgFMGyv?=
 =?us-ascii?Q?e6pz5WOgUo2TVDduJzTF1X4xjtnMoSKn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GroWnZeBdK7K0P1Cl654frF67LkNU0YIP02NCtCPA4GuRYrHWh3iSqWFyup+?=
 =?us-ascii?Q?e8tAO/TkqY8griFKNVjK9abVxv8CPYp8Z7Jhxd774caA9neN0AGa3Xjk7Nm1?=
 =?us-ascii?Q?WgEz5p4K6wCLIkR8WW947nWwksEvAK9EHJZfcHZgJP0yxAkJERmtz/08kuGn?=
 =?us-ascii?Q?Ia2yGpNCd2silPvAeXFJoKtCugW0CQKv60bPgLD4Sxq7ECx0KAQdffICKRmN?=
 =?us-ascii?Q?qAlOBgkxbMjnzxw4zav3HX+5klY7awbfMYyDaIQox+SjkJpIhfIYt1PqKvx+?=
 =?us-ascii?Q?+gUeiiUJK10F2XtuNcfXb99TuSOJY4u+pWpeU6kh4Bd1M2o9nL5eiFqzN7Pp?=
 =?us-ascii?Q?s8m3UMuBwHyqhh4N/+pmxIhQrVUzGj7qPb6rqD9QaI9/DfmSaH374g2fsLi0?=
 =?us-ascii?Q?+MIh5JAHSey68B71fvukPTOn/Nbxx6YJXSZDSPLRHvR78U/x+mu1keCxHB/j?=
 =?us-ascii?Q?XACwV1ymPLSYizYdF2GTe3Fl/zIff3zJ+DWEqe4Q/DxKfIhzxuKSpnVkaS5/?=
 =?us-ascii?Q?SNUMOksLRgqVLHRpyuDyTX+8mZUMKkxDyW2P61qgBb+a1RS2PVIDWeqSvff/?=
 =?us-ascii?Q?wtdlQRuc4v+1H347dsaoIVTQ6/eMqeWgu6/Pm2Y1NQKNfmBfBHUjiJ1xhb0Y?=
 =?us-ascii?Q?BX9yE2LHb92PsDkL+zIwGB0t8nPieX4ImofoDPtDngfKkS8XnThOVXhVcVw/?=
 =?us-ascii?Q?iQTu7ObTYGCt6AekoX1wP6lgO0H0d6ukuT4JFBD8/lN5B17yHYub2aV7PM9m?=
 =?us-ascii?Q?ywdrEi3eAW9IqQKMXRVYUaji5jSQ3QZTnbozL/OpMTTcueV6usUn3FX9DWMw?=
 =?us-ascii?Q?qGm68d2Qlj1l8DoHjt5kdFCP73E3lwRN6iS3Cl+s8ob3/X+99SsuRIiAy4do?=
 =?us-ascii?Q?HGryWRUlp1hueuP48uTXXhIxTW7XN8kgL5Mccc+18+dBYSkmxp/aBzampQhH?=
 =?us-ascii?Q?ooFD4AtTylk8YamPisnJqGYEo5s2X1QgyKsZ9/HnZAowafSjvT2YNDplPFEg?=
 =?us-ascii?Q?JGC4pn8csSJMYDKHfSlexrVdqn1Sik2kYTCJzcxKjnaBFVrWdXDwp5avJvyc?=
 =?us-ascii?Q?siD5/Fw3olw+uYwGP2a6XijGaOXm3MjmnI8IxZe4Kw9RxViiAhFxyxPHLRQI?=
 =?us-ascii?Q?yi8muKUXbXPjgE1zMqSz5w2jM+baY2tqeLJUibkXp4zX2DlGXzPHoArfjg9H?=
 =?us-ascii?Q?uMTcC1xZVONk/DPlfxRmdLi95MzPeJZ5LsUzI78xZmwX7hunVLok9JeLwRAy?=
 =?us-ascii?Q?mGZZJ5EIQdiqz5UBGIjQGzoQHezv1kLXGElHJJn9wL/Omx4Hm23HLxV/2i5M?=
 =?us-ascii?Q?SslLLzFqTxBigmicGO3XrL07Uscz6XjFUsMxy3A77Cw4eYP8RHKBYwjbrgxi?=
 =?us-ascii?Q?y+psG3QJBrxYYpBbUJzOXGH3yQRi8B/wVddSvAZbiYG2jdQPj3mTqX9sA01p?=
 =?us-ascii?Q?ak8ICxmbW0Ub8uv96ZjoOOLIMQpeLz+ZRbxKgn2TemUzylJGDePAGcL5O9qY?=
 =?us-ascii?Q?/6EFkTZxVnE/7niwStVEbl62jX0sIaHVzbu3z3Vxa7KDZG4ghhYozate7wgX?=
 =?us-ascii?Q?gXADjuxa8QQfbrauqvAo7c60L0kU1HrfVCo3RPy+tGfv70QjEP0VNVR0PtkL?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 229270f6-2964-42d6-6d42-08de1523470b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 06:37:19.8936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BcZJSokLEOIM7JYqojUNt/Aig+ymStkUo9gNd1gJjLKMEg3BAq4m5aJEaMg9OaidGBhdATBdmmvfeJstUNG47A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR03MB8427
X-Mailman-Approved-At: Mon, 27 Oct 2025 14:02:31 +0100
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

This patch ports the Cadence xSPI controller driver from
the Linux kernel. The controller supports three operating modes:

1. ACMD (Auto Command) mode
   - Includes PIO and CDMA submodes.
   - CDMA mode uses linked descriptors for high-performance,
     low-overhead operation.
   - PIO mode is suitable for simple, single-command transactions.

2. STIG (Software Triggered Instruction Generator) mode
   - Issues low-level 128-bit instructions to memory.
   - Uses the Slave DMA interface for data transfers.

3. Direct mode
   - Enables direct data access through the slave interface
     without commands.

Currently, only the STIG work mode is enabled. Additional modes will be
supported in future updates.

At the same time, also enabling the kconfig option for xSPI driver.

This driver has been ported and functionally verified on the Intel Simics
platform. It is intended for evaluation and experimental use at this stage.

Link: https://lore.kernel.org/all/1632038734-23999-1-git-send-email-pthombar@cadence.com/

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 drivers/spi/Kconfig        |  15 ++
 drivers/spi/Makefile       |   1 +
 drivers/spi/cadence_xspi.c | 449 +++++++++++++++++++++++++++++++++++++
 drivers/spi/cadence_xspi.h | 226 +++++++++++++++++++
 4 files changed, 691 insertions(+)
 create mode 100644 drivers/spi/cadence_xspi.c
 create mode 100644 drivers/spi/cadence_xspi.h

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 69b184b0d9e..d99c3618f16 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -162,6 +162,21 @@ config CADENCE_OSPI_VERSAL
 	  This option is used to enable Versal OSPI DMA operations which
 	  are used for ospi flash read using cadence qspi controller.
 
+config CADENCE_XSPI
+	bool "Cadence XSPI driver (Experimental feature)"
+	help
+	  Important: this feature is experimental so far and tested only
+	  on simulated environment.
+
+	  Enable the Cadence eXpanded Serial Periheral Interface (xSPI) flash
+	  driver. This driver can be used to access the SPI NOR flash on
+	  platforms embedding this Cadence IP core up to 8 bit wide bus.
+	  xSPI flash controller IP offers three work mode, Auto Command (ACMD)
+	  work mode, Software Triggered Instruction Generator (STIG) work mode
+	  and Direct work mode. This flash controller able to coomunicate
+	  with Flash Memory Devices supporting JESD216 and JESD251 stadards
+	  by using the Auto Command work mode.
+
 config CF_SPI
         bool "ColdFire SPI driver"
         help
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 14bdb97f189..44e26927238 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -8,6 +8,7 @@ ifdef CONFIG_$(SPL_TPL_)DM_SPI
 obj-y += spi-uclass.o
 obj-$(CONFIG_CADENCE_QSPI) += cadence_qspi.o cadence_qspi_apb.o
 obj-$(CONFIG_CADENCE_OSPI_VERSAL) += cadence_ospi_versal.o
+obj-$(CONFIG_CADENCE_XSPI) += cadence_xspi.o
 obj-$(CONFIG_SANDBOX) += spi-emul-uclass.o
 obj-$(CONFIG_SOFT_SPI) += soft_spi.o
 obj-$(CONFIG_SPI_ASPEED_SMC) += spi-aspeed-smc.o
diff --git a/drivers/spi/cadence_xspi.c b/drivers/spi/cadence_xspi.c
new file mode 100644
index 00000000000..717f226b709
--- /dev/null
+++ b/drivers/spi/cadence_xspi.c
@@ -0,0 +1,449 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025
+ * Altera Corporation <www.altera.com>
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <fdtdec.h>
+#include <log.h>
+#include <malloc.h>
+#include <reset.h>
+#include <spi.h>
+#include <spi-mem.h>
+#include <dm/device_compat.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/ioport.h>
+#include <linux/sizes.h>
+#include <linux/time.h>
+#include "cadence_xspi.h"
+
+static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_plat *cdns_xspi)
+{
+	u32 ctrl_stat;
+
+	return readl_relaxed_poll_timeout(cdns_xspi->iobase +
+					  CDNS_XSPI_CTRL_STATUS_REG,
+					  ctrl_stat,
+					  !(ctrl_stat &
+					   CDNS_XSPI_CTRL_BUSY),
+					   1000);
+}
+
+static int cdns_xspi_wait_for_sdma_complete(struct cdns_xspi_plat *cdns_xspi)
+{
+	u32 irq_status;
+	int ret = 0;
+
+	ret =  readl_relaxed_poll_timeout(cdns_xspi->iobase +
+					  CDNS_XSPI_INTR_STATUS_REG,
+					  irq_status,
+					  (irq_status &
+					   CDNS_XSPI_SDMA_TRIGGER),
+					   1000);
+
+	if (!ret) {
+		/*
+		 * SDMA return an interrupt,  need to clear
+		 * the interrupt after read, wrtting 1 to clear the bit.
+		 */
+		setbits_le32(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG,
+			     CDNS_XSPI_SDMA_TRIGGER);
+	}
+
+	/* Check if SDMA ERROR happened */
+	if (irq_status & CDNS_XSPI_SDMA_ERROR) {
+		/*
+		 * Need to clear the SDMA_ERROR interrupt
+		 * after read, wrtting 1 to clear the bit.
+		 */
+		dev_err(cdns_xspi->dev,
+			"Slave DMA transaction error\n");
+
+		cdns_xspi->sdma_error = true;
+		setbits_le32(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG,
+			     CDNS_XSPI_SDMA_ERROR);
+
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+static int cdns_xspi_wait_for_cmd_complete(struct cdns_xspi_plat *cdns_xspi)
+{
+	u32 irq_status;
+	int ret = 0;
+
+	ret =  readl_relaxed_poll_timeout(cdns_xspi->iobase +
+					  CDNS_XSPI_INTR_STATUS_REG,
+					  irq_status,
+					  (irq_status &
+					   CDNS_XSPI_STIG_DONE),
+					   100000);
+
+	irq_status = readl(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
+
+	if (!ret) {
+		/*
+		 * Need to clear the interrupt after read,
+		 * wrtting 1 to the clear the bit.
+		 */
+		writel(irq_status & CDNS_XSPI_STIG_DONE,
+		       cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
+	}
+
+	return ret;
+}
+
+static void cdns_xspi_trigger_command(struct cdns_xspi_plat *cdns_xspi,
+				      u32 cmd_regs[6])
+{
+	writel(cmd_regs[5], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_5);
+	writel(cmd_regs[4], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_4);
+	writel(cmd_regs[3], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_3);
+	writel(cmd_regs[2], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_2);
+	writel(cmd_regs[1], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_1);
+	writel(cmd_regs[0], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_0);
+}
+
+static int cdns_xspi_check_command_status(struct cdns_xspi_plat *cdns_xspi)
+{
+	int ret = 0;
+	u32 cmd_status = readl(cdns_xspi->iobase + CDNS_XSPI_CMD_STATUS_REG);
+
+	/* Check if the command has completed */
+	if (cmd_status & CDNS_XSPI_CMD_STATUS_COMPLETED) {
+		/*Check for failure status and report each type of error */
+		if ((cmd_status & CDNS_XSPI_CMD_STATUS_FAILED) != 0) {
+			if (cmd_status & CDNS_XSPI_CMD_STATUS_DQS_ERROR)
+				dev_err(cdns_xspi->dev,
+					"Incorrect DQS pulses detected\n");
+
+			if (cmd_status & CDNS_XSPI_CMD_STATUS_CRC_ERROR)
+				dev_err(cdns_xspi->dev,
+					"CRC error received\n");
+
+			if (cmd_status & CDNS_XSPI_CMD_STATUS_BUS_ERROR)
+				dev_err(cdns_xspi->dev,
+					"Error resp on system DMA interface\n");
+
+			if (cmd_status & CDNS_XSPI_CMD_STATUS_INV_SEQ_ERROR)
+				dev_err(cdns_xspi->dev,
+					"Invalid command sequence detected\n");
+
+			ret = -EPROTO;
+		}
+	} else {
+		/* Command did not complete at all -- fatal error */
+		dev_err(cdns_xspi->dev, "Fatal err - command not completed\n");
+		ret = -EPROTO;
+	}
+
+	return ret;
+}
+
+static void cdns_xspi_set_interrupts(struct cdns_xspi_plat *cdns_xspi,
+				     bool enabled)
+{
+	u32 intr_enable;
+
+	intr_enable = readl(cdns_xspi->iobase + CDNS_XSPI_INTR_ENABLE_REG);
+	if (enabled)
+		intr_enable |= CDNS_XSPI_INTR_MASK;
+	else
+		intr_enable &= ~CDNS_XSPI_INTR_MASK;
+	writel(intr_enable, cdns_xspi->iobase + CDNS_XSPI_INTR_ENABLE_REG);
+}
+
+static int cdns_xspi_controller_init(struct cdns_xspi_plat *cdns_xspi)
+{
+	u32 ctrl_ver;
+	u32 ctrl_features;
+	u16 hw_magic_num;
+
+	ctrl_ver = readl(cdns_xspi->iobase + CDNS_XSPI_CTRL_VERSION_REG);
+	hw_magic_num = FIELD_GET(CDNS_XSPI_MAGIC_NUM, ctrl_ver);
+	if (hw_magic_num != CDNS_XSPI_MAGIC_NUM_VALUE) {
+		dev_err(cdns_xspi->dev,
+			"Incorrect XSPI magic number: %x, expected: %x\n",
+			hw_magic_num, CDNS_XSPI_MAGIC_NUM_VALUE);
+		return -ENXIO;
+	}
+
+	ctrl_features = readl(cdns_xspi->iobase + CDNS_XSPI_CTRL_FEATURES_REG);
+	cdns_xspi->hw_num_banks = FIELD_GET(CDNS_XSPI_NUM_BANKS, ctrl_features);
+	cdns_xspi->set_interrupts_handler(cdns_xspi, false);
+
+	return 0;
+}
+
+static void cdns_xspi_sdma_handle(struct cdns_xspi_plat *cdns_xspi)
+{
+	u32 sdma_size, sdma_trd_info;
+	u8 sdma_dir;
+	u8 *in_buf;
+	u8 *out_buf;
+
+	sdma_size = readl(cdns_xspi->iobase + CDNS_XSPI_SDMA_SIZE_REG);
+	sdma_trd_info = readl(cdns_xspi->iobase + CDNS_XSPI_SDMA_TRD_INFO_REG);
+	sdma_dir = FIELD_GET(CDNS_XSPI_SDMA_DIR, sdma_trd_info);
+
+	in_buf = (u8 *)cdns_xspi->in_buffer;
+	out_buf = (u8 *)cdns_xspi->out_buffer;
+
+	switch (sdma_dir) {
+	case CDNS_XSPI_SDMA_DIR_READ:
+		if (in_buf)
+			memcpy_fromio(in_buf, cdns_xspi->sdmabase, sdma_size);
+	break;
+
+	case CDNS_XSPI_SDMA_DIR_WRITE:
+		if (in_buf)
+			memcpy_toio(cdns_xspi->sdmabase, out_buf, sdma_size);
+	break;
+
+	default:
+		/* Handle unexpected direction */
+		dev_warn(cdns_xspi->dev,
+			 "Unknown SDMA direction: %u\n", sdma_dir);
+	break;
+	}
+}
+
+static int cdns_xspi_send_stig_command(struct cdns_xspi_plat *cdns_xspi,
+				       const struct spi_mem_op *op,
+				       bool data_phase)
+{
+	u32 cmd_regs[6] = {0};
+	int ret = 0;
+	int dummybytes = op->dummy.nbytes;
+
+	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi);
+	if (ret < 0)
+		return ret;
+
+	writel(FIELD_PREP(CDNS_XSPI_CTRL_WORK_MODE, CDNS_XSPI_WORK_MODE_STIG),
+	       cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
+
+	cdns_xspi->set_interrupts_handler(cdns_xspi, true);
+	cdns_xspi->sdma_error = false;
+
+	cmd_regs[1] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_1(op, data_phase);
+	cmd_regs[2] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_2(op);
+	if (dummybytes != 0) {
+		cmd_regs[3] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_3(op, 1);
+		dummybytes--;
+	} else {
+		cmd_regs[3] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_3(op, 0);
+	}
+	cmd_regs[4] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_4(op,
+						       cdns_xspi->cur_cs);
+
+	cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
+
+	if (data_phase) {
+		cmd_regs[0] = CDNS_XSPI_STIG_DONE_FLAG;
+		cmd_regs[1] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_1;
+		cmd_regs[2] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_2(op);
+		cmd_regs[3] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_3(op, dummybytes);
+		cmd_regs[4] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_4(op,
+							   cdns_xspi->cur_cs);
+
+		cdns_xspi->in_buffer = op->data.buf.in;
+		cdns_xspi->out_buffer = op->data.buf.out;
+
+		cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
+
+		cdns_xspi_wait_for_sdma_complete(cdns_xspi);
+
+		if (cdns_xspi->sdma_error) {
+			cdns_xspi->set_interrupts_handler(cdns_xspi, false);
+			return -EIO;
+		}
+		cdns_xspi_sdma_handle(cdns_xspi);
+	}
+
+	cdns_xspi_wait_for_cmd_complete(cdns_xspi);
+	ret = cdns_xspi_check_command_status(cdns_xspi);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int cdns_xspi_mem_op(struct udevice *bus,
+			    const struct spi_mem_op *op,
+			    unsigned int cs)
+{
+	struct cdns_xspi_plat *plat = dev_get_plat(bus);
+	enum spi_mem_data_dir dir = op->data.dir;
+
+	if (plat->cur_cs != cs)
+		plat->cur_cs = cs;
+
+	return cdns_xspi_send_stig_command(plat, op,
+					   (dir != SPI_MEM_NO_DATA));
+}
+
+static int cdns_xspi_mem_op_execute(struct spi_slave *spi,
+				    const struct spi_mem_op *op)
+{
+	struct udevice *bus = spi->dev->parent;
+	unsigned int cs = 0;
+	int ret = 0;
+
+	cs = spi_chip_select(spi->dev);
+
+	if (cs < 0) {
+		/*
+		 * spi_chip_select will return error number when not
+		 * able to get chip select.
+		 */
+		pr_err("%s: Unable to get chip select, ret=%d",
+		       spi->dev->name, cs);
+		return cs;
+	}
+
+	ret = cdns_xspi_mem_op(bus, op, cs);
+
+	return ret;
+}
+
+static int cdns_xspi_adjust_mem_op_size(struct spi_slave *spi,
+					struct spi_mem_op *op)
+{
+	struct udevice *bus = spi->dev->parent;
+	struct cdns_xspi_plat *plat = dev_get_plat(bus);
+
+	op->data.nbytes = clamp_val(op->data.nbytes, 0, plat->sdmasize);
+
+	return 0;
+}
+
+static const struct spi_controller_mem_ops cadence_xspi_mem_ops = {
+	.exec_op = cdns_xspi_mem_op_execute,
+	.adjust_op_size = cdns_xspi_adjust_mem_op_size,
+};
+
+static void cdns_xspi_print_phy_config(struct cdns_xspi_plat *cdns_xspi)
+{
+	struct device *dev = cdns_xspi->dev;
+
+	dev_info(dev, "PHY configuration\n");
+	dev_info(dev, "   * xspi_dll_phy_ctrl: %08x\n",
+		 readl(cdns_xspi->iobase + CDNS_XSPI_DLL_PHY_CTRL));
+	dev_info(dev, "   * phy_dq_timing: %08x\n",
+		 readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DQ_TIMING));
+	dev_info(dev, "   * phy_dqs_timing: %08x\n",
+		 readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DQS_TIMING));
+	dev_info(dev, "   * phy_gate_loopback_ctrl: %08x\n",
+		 readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_GATE_LPBCK_CTRL));
+	dev_info(dev, "   * phy_dll_slave_ctrl: %08x\n",
+		 readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL));
+}
+
+static int cdns_xspi_probe(struct udevice *bus)
+{
+	struct cdns_xspi_plat *cdns_xspi = dev_get_plat(bus);
+	struct resource res;
+	int ret = 0;
+
+	cdns_xspi->sdma_handler = &cdns_xspi_sdma_handle;
+	cdns_xspi->set_interrupts_handler = &cdns_xspi_set_interrupts;
+	cdns_xspi->cur_cs = 0;
+
+	ret = dev_read_resource_byname(bus, "io", &res);
+	if (ret)
+		return ret;
+
+	cdns_xspi->iobase = devm_ioremap(bus, res.start, resource_size(&res));
+
+	if (IS_ERR(cdns_xspi->iobase)) {
+		dev_err(bus, "Failed to remap controller base address\n");
+		return PTR_ERR(cdns_xspi->iobase);
+	}
+
+	ret = dev_read_resource_byname(bus, "sdma", &res);
+	if (ret)
+		return ret;
+
+	cdns_xspi->sdmabase = devm_ioremap(bus, res.start, resource_size(&res));
+
+	if (IS_ERR(cdns_xspi->sdmabase)) {
+		dev_err(bus, "Failed to remap SDMA address\n");
+		return PTR_ERR(cdns_xspi->sdmabase);
+	}
+	cdns_xspi->sdmasize = resource_size(&res);
+
+	ret = dev_read_resource_byname(bus, "aux", &res);
+	if (ret)
+		return ret;
+
+	cdns_xspi->auxbase = devm_ioremap(bus, res.start, resource_size(&res));
+
+	if (IS_ERR(cdns_xspi->auxbase)) {
+		dev_err(bus, "Failed to remap AUX address\n");
+		return PTR_ERR(cdns_xspi->auxbase);
+	}
+
+	cdns_xspi_print_phy_config(cdns_xspi);
+
+	ret = cdns_xspi_controller_init(cdns_xspi);
+
+	if (ret) {
+		dev_err(bus, "Failed to initialize controller\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cdns_xspi_remove(struct udevice *dev)
+{
+	struct cdns_xspi_plat *plat = dev_get_plat(dev);
+	int ret = 0;
+
+	if (plat->resets)
+		ret = reset_release_bulk(plat->resets);
+
+	return ret;
+}
+
+static int cadence_spi_set_speed(struct udevice *bus, uint hz)
+{
+	return 0;
+}
+
+static int cadence_spi_set_mode(struct udevice *bus, uint mode)
+{
+	return 0;
+}
+
+static const struct dm_spi_ops cdns_xspi_ops = {
+	.set_speed	= cadence_spi_set_speed,
+	.set_mode	= cadence_spi_set_mode,
+	.mem_ops	= &cadence_xspi_mem_ops,
+};
+
+static const struct udevice_id cdns_xspi_of_match[] = {
+	{
+		.compatible = "cdns,xspi-nor",
+	},
+	{/* end of table */}
+};
+
+U_BOOT_DRIVER(cadence_xspi) = {
+	.name = CDNS_XSPI_NAME,
+	.id = UCLASS_SPI,
+	.of_match = cdns_xspi_of_match,
+	.ops = &cdns_xspi_ops,
+	.probe = cdns_xspi_probe,
+	.remove = cdns_xspi_remove,
+	.flags = DM_FLAG_OS_PREPARE,
+};
diff --git a/drivers/spi/cadence_xspi.h b/drivers/spi/cadence_xspi.h
new file mode 100644
index 00000000000..e408d27303f
--- /dev/null
+++ b/drivers/spi/cadence_xspi.h
@@ -0,0 +1,226 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025
+ * Altera Corporation <www.altera.com>
+ */
+
+#ifndef __CADENCE_XSPI_H__
+#define __CADENCE_XSPI_H__
+
+#include <spi-mem.h>
+#include <reset.h>
+#include <linux/mtd/spi-nor.h>
+#include <linux/bitfield.h>
+#include <linux/log2.h>
+
+#define CDNS_XSPI_MAGIC_NUM_VALUE	0x6522
+#define CDNS_XSPI_MAX_BANKS		8
+#define CDNS_XSPI_NAME			"cadence_xspi"
+
+/*
+ * Note: below are additional auxiliary registers to
+ * configure XSPI controller pin-strap settings
+ */
+
+/* PHY DQ timing register */
+#define CDNS_XSPI_CCP_PHY_DQ_TIMING		0x0000
+
+/* PHY DQS timing register */
+#define CDNS_XSPI_CCP_PHY_DQS_TIMING		0x0004
+
+/* PHY gate loopback control register */
+#define CDNS_XSPI_CCP_PHY_GATE_LPBCK_CTRL	0x0008
+
+/* PHY DLL slave control register */
+#define CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL	0x0010
+
+/* DLL PHY control register */
+#define CDNS_XSPI_DLL_PHY_CTRL			0x1034
+
+/* Command registers */
+#define CDNS_XSPI_CMD_REG_0			0x0000
+#define CDNS_XSPI_CMD_REG_1			0x0004
+#define CDNS_XSPI_CMD_REG_2			0x0008
+#define CDNS_XSPI_CMD_REG_3			0x000C
+#define CDNS_XSPI_CMD_REG_4			0x0010
+#define CDNS_XSPI_CMD_REG_5			0x0014
+
+/* Command status registers */
+#define CDNS_XSPI_CMD_STATUS_REG		0x0044
+
+/* Controller status register */
+#define CDNS_XSPI_CTRL_STATUS_REG		0x0100
+#define CDNS_XSPI_INIT_COMPLETED		BIT(16)
+#define CDNS_XSPI_INIT_LEGACY			BIT(9)
+#define CDNS_XSPI_INIT_FAIL			BIT(8)
+#define CDNS_XSPI_CTRL_BUSY			BIT(7)
+
+/* Controller interrupt status register */
+#define CDNS_XSPI_INTR_STATUS_REG		0x0110
+#define CDNS_XSPI_STIG_DONE			BIT(23)
+#define CDNS_XSPI_SDMA_ERROR			BIT(22)
+#define CDNS_XSPI_SDMA_TRIGGER			BIT(21)
+#define CDNS_XSPI_CMD_IGNRD_EN			BIT(20)
+#define CDNS_XSPI_DDMA_TERR_EN			BIT(18)
+#define CDNS_XSPI_CDMA_TREE_EN			BIT(17)
+#define CDNS_XSPI_CTRL_IDLE_EN			BIT(16)
+
+#define CDNS_XSPI_TRD_COMP_INTR_STATUS		0x0120
+#define CDNS_XSPI_TRD_ERR_INTR_STATUS		0x0130
+#define CDNS_XSPI_TRD_ERR_INTR_EN		0x0134
+
+/* Controller interrupt enable register */
+#define CDNS_XSPI_INTR_ENABLE_REG		0x0114
+#define CDNS_XSPI_INTR_EN			BIT(31)
+#define CDNS_XSPI_STIG_DONE_EN			BIT(23)
+#define CDNS_XSPI_SDMA_ERROR_EN			BIT(22)
+#define CDNS_XSPI_SDMA_TRIGGER_EN		BIT(21)
+
+#define CDNS_XSPI_INTR_MASK (CDNS_XSPI_INTR_EN | \
+	CDNS_XSPI_STIG_DONE_EN  | \
+	CDNS_XSPI_SDMA_ERROR_EN | \
+	CDNS_XSPI_SDMA_TRIGGER_EN)
+
+/* Controller config register */
+#define CDNS_XSPI_CTRL_CONFIG_REG		0x0230
+#define CDNS_XSPI_CTRL_WORK_MODE		GENMASK(6, 5)
+
+#define CDNS_XSPI_WORK_MODE_DIRECT		0
+#define CDNS_XSPI_WORK_MODE_STIG		1
+#define CDNS_XSPI_WORK_MODE_ACMD		3
+
+/* SDMA trigger transaction registers */
+#define CDNS_XSPI_SDMA_SIZE_REG			0x0240
+#define CDNS_XSPI_SDMA_TRD_INFO_REG		0x0244
+#define CDNS_XSPI_SDMA_DIR			BIT(8)
+
+/* Controller features register */
+#define CDNS_XSPI_CTRL_FEATURES_REG		0x0F04
+#define CDNS_XSPI_NUM_BANKS			GENMASK(25, 24)
+#define CDNS_XSPI_DMA_DATA_WIDTH		BIT(21)
+#define CDNS_XSPI_NUM_THREADS			GENMASK(3, 0)
+
+/* Controller version register */
+#define CDNS_XSPI_CTRL_VERSION_REG		0x0F00
+#define CDNS_XSPI_MAGIC_NUM			GENMASK(31, 16)
+#define CDNS_XSPI_CTRL_REV			GENMASK(7, 0)
+
+/* STIG Profile 1.0 instruction fields (split into registers) */
+#define CDNS_XSPI_CMD_INSTR_TYPE		GENMASK(6, 0)
+#define CDNS_XSPI_CMD_P1_R1_ADDR0		GENMASK(31, 24)
+#define CDNS_XSPI_CMD_P1_R2_ADDR1		GENMASK(7, 0)
+#define CDNS_XSPI_CMD_P1_R2_ADDR2		GENMASK(15, 8)
+#define CDNS_XSPI_CMD_P1_R2_ADDR3		GENMASK(23, 16)
+#define CDNS_XSPI_CMD_P1_R2_ADDR4		GENMASK(31, 24)
+#define CDNS_XSPI_CMD_P1_R3_ADDR5		GENMASK(7, 0)
+#define CDNS_XSPI_CMD_P1_R3_CMD			GENMASK(23, 16)
+#define CDNS_XSPI_CMD_P1_R3_NUM_ADDR_BYTES	GENMASK(30, 28)
+#define CDNS_XSPI_CMD_P1_R4_ADDR_IOS		GENMASK(1, 0)
+#define CDNS_XSPI_CMD_P1_R4_CMD_IOS		GENMASK(9, 8)
+#define CDNS_XSPI_CMD_P1_R4_BANK		GENMASK(14, 12)
+
+/* STIG data sequence instruction fields (split into registers) */
+#define CDNS_XSPI_CMD_DSEQ_R2_DCNT_L		GENMASK(31, 16)
+#define CDNS_XSPI_CMD_DSEQ_R3_DCNT_H		GENMASK(15, 0)
+#define CDNS_XSPI_CMD_DSEQ_R3_NUM_OF_DUMMY	GENMASK(25, 20)
+#define CDNS_XSPI_CMD_DSEQ_R4_BANK		GENMASK(14, 12)
+#define CDNS_XSPI_CMD_DSEQ_R4_DATA_IOS		GENMASK(9, 8)
+#define CDNS_XSPI_CMD_DSEQ_R4_DIR		BIT(4)
+
+/* STIG command status fields */
+#define CDNS_XSPI_CMD_STATUS_COMPLETED		BIT(15)
+#define CDNS_XSPI_CMD_STATUS_FAILED		BIT(14)
+#define CDNS_XSPI_CMD_STATUS_DQS_ERROR		BIT(3)
+#define CDNS_XSPI_CMD_STATUS_CRC_ERROR		BIT(2)
+#define CDNS_XSPI_CMD_STATUS_BUS_ERROR		BIT(1)
+#define CDNS_XSPI_CMD_STATUS_INV_SEQ_ERROR	BIT(0)
+
+#define CDNS_XSPI_STIG_DONE_FLAG		BIT(0)
+#define CDNS_XSPI_TRD_STATUS			0x0104
+
+#define MODE_NO_OF_BYTES			GENMASK(25, 24)
+#define MODEBYTES_COUNT			1
+
+/* Helper macros for filling command registers */
+#define CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_1(op, data_phase) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_INSTR_TYPE, (data_phase) ? \
+		CDNS_XSPI_STIG_INSTR_TYPE_1 : CDNS_XSPI_STIG_INSTR_TYPE_0) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R1_ADDR0, (op)->addr.val & 0xff))
+
+#define CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_2(op) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R2_ADDR1, ((op)->addr.val >> 8)  & 0xFF) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R2_ADDR2, ((op)->addr.val >> 16) & 0xFF) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R2_ADDR3, ((op)->addr.val >> 24) & 0xFF) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R2_ADDR4, ((op)->addr.val >> 32) & 0xFF))
+
+#define CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_3(op, modebytes) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R3_ADDR5, ((op)->addr.val >> 40) & 0xFF) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R3_CMD, (op)->cmd.opcode) | \
+	FIELD_PREP(MODE_NO_OF_BYTES, modebytes) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R3_NUM_ADDR_BYTES, (op)->addr.nbytes))
+
+#define CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_4(op, chipsel) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R4_ADDR_IOS, ilog2((op)->addr.buswidth)) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R4_CMD_IOS, ilog2((op)->cmd.buswidth)) | \
+	FIELD_PREP(CDNS_XSPI_CMD_P1_R4_BANK, chipsel))
+
+#define CDNS_XSPI_CMD_FLD_DSEQ_CMD_1 \
+	FIELD_PREP(CDNS_XSPI_CMD_INSTR_TYPE, CDNS_XSPI_STIG_INSTR_TYPE_DATA_SEQ)
+
+#define CDNS_XSPI_CMD_FLD_DSEQ_CMD_2(op) \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R2_DCNT_L, (op)->data.nbytes & 0xFFFF)
+
+#define CDNS_XSPI_CMD_FLD_DSEQ_CMD_3(op, dummybytes) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R3_DCNT_H, \
+		((op)->data.nbytes >> 16) & 0xffff) | \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R3_NUM_OF_DUMMY, \
+		  (op)->dummy.buswidth != 0 ? \
+		  (((dummybytes) * 8) / (op)->dummy.buswidth) : \
+		  0))
+
+#define CDNS_XSPI_CMD_FLD_DSEQ_CMD_4(op, chipsel) ( \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R4_BANK, chipsel) | \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R4_DATA_IOS, \
+		ilog2((op)->data.buswidth)) | \
+	FIELD_PREP(CDNS_XSPI_CMD_DSEQ_R4_DIR, \
+		((op)->data.dir == SPI_MEM_DATA_IN) ? \
+		CDNS_XSPI_STIG_CMD_DIR_READ : CDNS_XSPI_STIG_CMD_DIR_WRITE))
+
+enum cdns_xspi_stig_instr_type {
+	CDNS_XSPI_STIG_INSTR_TYPE_0,
+	CDNS_XSPI_STIG_INSTR_TYPE_1,
+	CDNS_XSPI_STIG_INSTR_TYPE_DATA_SEQ = 127,
+};
+
+enum cdns_xspi_sdma_dir {
+	CDNS_XSPI_SDMA_DIR_READ,
+	CDNS_XSPI_SDMA_DIR_WRITE,
+};
+
+enum cdns_xspi_stig_cmd_dir {
+	CDNS_XSPI_STIG_CMD_DIR_READ,
+	CDNS_XSPI_STIG_CMD_DIR_WRITE,
+};
+
+struct cdns_xspi_plat {
+	struct device *dev;
+	struct reset_ctl_bulk *resets;
+
+	void __iomem *iobase;
+	void __iomem *auxbase;
+	void __iomem *sdmabase;
+
+	int cur_cs;
+	unsigned int sdmasize;
+	bool sdma_error;
+
+	void *in_buffer;
+	const void *out_buffer;
+
+	u8 hw_num_banks;
+
+	void (*sdma_handler)(struct cdns_xspi_plat *cdns_xspi);
+	void (*set_interrupts_handler)(struct cdns_xspi_plat *cdns_xspi, bool enabled);
+};
+
+#endif /* __CADENCE_XSPI_H__ */
-- 
2.43.7

