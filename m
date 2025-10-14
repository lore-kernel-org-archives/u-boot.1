Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBA7CCD192
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 16:06:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 578CE835C6;
	Tue, 14 Oct 2025 18:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ESmd+zns";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EC418004F; Tue, 14 Oct 2025 12:14:16 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8762F809A5
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 12:14:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmuprAH25A4Bh0WPJITGo8//D2FxiEYvjk9q3U69gtoftuUa8B+pIDS9HVZsB9LoppH/OQhYjTK+1w+XLBqIIbQLjJi01ggkwPFGMVRDfDAZ/v84PvSy6F/kxmDfE49xop+9LlW1ahj1jmnbC8UuWK6Jyzk3SvC9Ij+TMOmtC4LgnjC6A0MvAXX4lQkxGybCCzymIgqQSIBXkncGERTCbQSPYHfnRfI/k0d6rA4LHbc+Qc04rOaziaqtw7uciwbr3AAwqWXWcb9l6WWOXamj9puJY1ePJXzrFkdM9kqoPKP2uaoImLpijFUi8tkBEBt1amEkTqRvucS8xQAts0wKVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrelfU5IzkT919iip7gXYgzeC/ME0uSUFgVJQAeI94A=;
 b=OAz8f5O4w/BEeN2v7FmogDfg7kbipwUpaWT2vdGDCdIa9j8B9NDdjYZ34HZiuiG5d1+lcIm895rzTxKg5PI4nYTPJjhfgrxsaMYFEs8DUZ+cZfMaONU43D9KkoI5cxGEzQebLqeb9n7DVtc9hEvXq/A0dT35sxSkl5HCOGnhxJR8MZB4VlVW2fN4rztWQshTre+NHuao8PvTfMzU3KkHnRL6Of7niH+maq8ONXGd8PpyWaf6QoeURV3TlDnQOj9IJcvW/PX73XHf6VYE8AZoo3BFA6gDwo2nJOeuXqVyA+iPfF1kzH/rUWp4ucRTbUMrdlHjFKi3R4Ovahg+qkLbdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrelfU5IzkT919iip7gXYgzeC/ME0uSUFgVJQAeI94A=;
 b=ESmd+znsaFOraGPNM8IJNQPB+TmuETDcRTfF7jRCli8MTfFnkGnKk0Ag6hDCVl1/gA4OQi2QIrTXKKmLfIW/5lxALtk8HPozFzI7ZF1dIlAWtg6TiCJFY2T7jMBipDr3nVur9VFTqDZvi96mpQoyElrome8wP2y5GsQ/LQDi9aOHMeEKsPIvKcxs8lItEWM0zelgCpJ7Kcu11qlxzlsLgcvrJEKSK228L6cVai464roz6NJ7pJjRIY6UFEW9SRS2ygfqF8HHjjQjaDUVTaOU0W1xMf/q+sV0zQOTtMbQM8Vhg35X+0+obKs7XkcoxM724dip84EGq0fJlX07EmkZzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by MN2PR03MB5056.namprd03.prod.outlook.com (2603:10b6:208:1b2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 10:14:12 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4%7]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 10:14:12 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 u-boot@lists.denx.de, Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [PATCH v1 2/2] spi: Enable Kconfig and Makefile for xSPI
Date: Tue, 14 Oct 2025 18:13:54 +0800
Message-ID: <20251014101354.11182-3-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251014101354.11182-1-boon.khai.ng@altera.com>
References: <20251014101354.11182-1-boon.khai.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::6) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|MN2PR03MB5056:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f3666c-27eb-4caf-4335-08de0b0a6c0a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JIx720M+q8QOqXa1kTxEvp9/WSJ4WGXeaq4qAdoRqUbfaEbH+R9E+5k60S/2?=
 =?us-ascii?Q?QiDuLcYT9cCJsBmdgSMr0/583R8Zeq7RFombTIHBeADIRGrXL73tWb+QMcWG?=
 =?us-ascii?Q?tBCG6y1BBUijIgSI5BPMIfF2lQfuqZcqsLzT1spOkZnjyMxiFEdFs631w0DE?=
 =?us-ascii?Q?JP/hZ+eD2HEu9WFUt8yXUyumlvNX4PPIuaflXCFQ32otFOP6RDK9X1h/a0CE?=
 =?us-ascii?Q?0GyWxpn4xo0OLq6C6EhOt9AFnLNyUMT0j5DZmS97d6Cysbveoxsx0PqrMbNq?=
 =?us-ascii?Q?NNqUky1jBzsI/LOIu5dMROpeuIcvQXxZfTNZRbNJB1uGq1JSjj6ATfn44xGR?=
 =?us-ascii?Q?jQuiVaiBs999QEVn3F12S7GTf1m5MDn4X9iqN4mJmhTw9H4+1Y6qEg+ahzkX?=
 =?us-ascii?Q?R1ITsdlpUVZYJhlntbYioDdrNHQbr/SPWyjvuf3PhzR/rNM1ceIuqCdNzcre?=
 =?us-ascii?Q?RttHeVQutzYx7aahz2RHioiVrRHaNBcnCu3k7Te5tRHJ2Fe+RrtNggU35A9q?=
 =?us-ascii?Q?S04lhkEP1VdA4K6u3KKJL1A8yc5C6ddoMTqPglNigyyO7G4N3NgOgF6U+esz?=
 =?us-ascii?Q?jru+pF0EA5WkqLiURPCinXalumTqNbTajq6Z+nGk4cF76Ffg/7fe8YH5NQpw?=
 =?us-ascii?Q?GC87lh1Zsck3bRHaNUM2dUxV2DVDGTQLig4my8tzEfrSMRpAz6/A01gfNMzF?=
 =?us-ascii?Q?pDXN/66O0HRS7yyK7Ao2Rv2w6CyzFiYFAZIB6HXP66piCqf+bNhP5tjzx+Ps?=
 =?us-ascii?Q?ZawpFjQ0zO7h1FEPwFEO8SSBINiSWvbotBtUnA5Ze3QNzJ8p8S1n6AEvVd4x?=
 =?us-ascii?Q?UDrXO8WAe7/NASQqjxrw7dRaSZWkXxfqTYmRKSv/5e6DywoEi2fX3xQcED66?=
 =?us-ascii?Q?97zC2guHtROcJ3m327dExcYurb/UwQ2nWESDEluF14i2MldWQjmVm1XR88iM?=
 =?us-ascii?Q?fsjJ6h3wOBeBFVzXoB4g6MZMa+ajemxIwUqI9Np7+wd1Akuo4oxkEAtRTdws?=
 =?us-ascii?Q?nCa9H5+VWjlLC3cfJY8Uwu+Eyo/Ew9lTScabbOhHaogFhz/izMaSi6mzezxs?=
 =?us-ascii?Q?V92dFwQ2uRG+EGMHwYHviX49CyrweZ02GfvZ3yMD6SUcsnI54+PyB+4burcS?=
 =?us-ascii?Q?MrTVBBSeGZnn6F7X2ThB9xrUY7RWnBpWvKc/Xhds670Q3au7Ozz/BK6+lBFt?=
 =?us-ascii?Q?D9cEUAEkxPUKHco0TMyWGVyMttJtIUseOvCwBPzEFE0s4FjcXjdervuaqaD6?=
 =?us-ascii?Q?4XA0srwiRRiygL0FX6Djks/JK7H9xb+Bm/gd2q3ZTzLnFM6hGj+ixaEUL4Jv?=
 =?us-ascii?Q?88z4hrPpfOWCaxQrSnUwYUhZdkcHFJ1815PxJOEEvRZstwgMqyBlGztaQEQS?=
 =?us-ascii?Q?Mt9ncQc15Mgz7hntgvsdbJG9KXqd0AaM1kUAlT6evxSYOLXb0X2kWok97x+e?=
 =?us-ascii?Q?OkkEjZQuHiZpkMPoIVShnW/Uo2UVsxho?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t24lwgRWNc/eeKEqay2cFxju/MWG04V5QBTcF8zur61o/Moq2QNnloDZDh5H?=
 =?us-ascii?Q?YkDUHIB3LCNLfKHJYx8QJiVxPr+bm0RrujfC6Eo5rRed217P/1VPrXHLvssI?=
 =?us-ascii?Q?YYoyn0NFUN8MnPfDvH4M2afkmDcEK/O5dHUdDGEVWfLE1530H6KvqbTOZ6Zm?=
 =?us-ascii?Q?fqCuPj6kbZDv4EZgcVTw+urcTSn0lWnm5Y944THeLFMtUopOWZEgYovOnwf0?=
 =?us-ascii?Q?WVCiI7MVRgzQboGwGW0VYBIr/u2GYDmYLJ74Qq3FoIOyN3akEq4MUvPM1Zfe?=
 =?us-ascii?Q?Y/SyF83ZFhj74V4Fgam0Zh3vs9bTZFlFLi9C90OURGl6OWz8fIu9XN7cx0/d?=
 =?us-ascii?Q?F9rFgCfa5uYKmOvq1OQJyVeSQ+TUwkmSp9JQSD7XNR9l+exje80qCLAz0vlV?=
 =?us-ascii?Q?RVwvtcdnMejMeEkItSF4FU3HTlAVqG0wfErWs0xq3SGF586iTqkPXnD8u6KL?=
 =?us-ascii?Q?waDBjHmsGlTLA5ZQGi3cAiByalLC1AAxqSVz016VCp7G5VbWDNd2vw6Hk2HV?=
 =?us-ascii?Q?RNekjKQ3ZxVUVjZ8PkDv6InOCZMpbQveRPU5wAlIG9wY/XoS7Ky2c1ygrDGp?=
 =?us-ascii?Q?GvV2IDRhrAQ6WxNaHKuqsEZWvRP2/HEhAiEJXmuUaMTy5L7ylHTjuZO6Z9tr?=
 =?us-ascii?Q?rAk/bhOQNhQ5aooKLN27rgaIsdz5FfxOQdGcBqWYbQJ8Awhj+vvshzprtKme?=
 =?us-ascii?Q?bTEYshs+052xP0tg4tL7mbTmzPDgJgfZNuuySZc61UTtkAa7SVG3vIbJMle4?=
 =?us-ascii?Q?5wopyIPzejIsqlSrujL3TeR6lO64IZRU2Zqhzc7Y1xImRT+mbhp4frUITx5K?=
 =?us-ascii?Q?lVCe3LsEF7n+PYIipUVdALeSdI2vPAp8v1RjZBqjSLQQcLY68+i11E19F/qY?=
 =?us-ascii?Q?oEyBzxwYrvXXeazWWIejE6WMSxD+YU2ygAtUDYJVIp0Qkg9kqdKXPmrZGXZx?=
 =?us-ascii?Q?N63LqRSNg/uCsVfGLKfzjUBf/IhbgoDoWnwM63l+17mlaDixG5q+BOazHWV5?=
 =?us-ascii?Q?Zk6J4NHpZr0pWxvI6EGctUMS6EtXVx2djS9c86M+7N5qpRqZZvaH6aRhSdrd?=
 =?us-ascii?Q?dngnySNyuxinBLo5m5LW7tnf+3ylWC3HrCB0GfU+0noDv1EXqomD2gJYrnzJ?=
 =?us-ascii?Q?9nhiLDbXMHuJsX0EEaLt0NjUDWbLJlno2yTNDdK0SOspP621PkynD3mvd8mq?=
 =?us-ascii?Q?NWyBIsSiXM91If8FgMtpQfSbkvk0pPRRFffxPC7/vZnWd28kR1DzmQm6qfg2?=
 =?us-ascii?Q?Cl3e9uJbNoegOkepXUKukULsgKVAvi7xuW7NaGPL9Wh+SfVIy4pa9CAeoTAH?=
 =?us-ascii?Q?HKIUC3WggsH3U5dNTezCS84w1qjTMy7fxwlzSby8udyYs71fJa2t1359/S61?=
 =?us-ascii?Q?KwYovC62c9MEJDvvaoxNZ5t6G+0qnQsn9vew+iXGpvcVzyLqTyExv1XaduXd?=
 =?us-ascii?Q?t9Zf6v/FXl9O6HUPVVn8i/40rNXli/CsrPYyj/XxSanC6VV21bNF86p6842k?=
 =?us-ascii?Q?alOh5QndWYrmSZINgIK2urc5Qz/KrYIgIgsnpplbRTHZuXMsbX+QIULY7U59?=
 =?us-ascii?Q?WE/bHNWbSyjqHokfrLT7pJ7GsVDwz7z3jcSp5+ReVp+XUTC3yL3ozqyD2P20?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f3666c-27eb-4caf-4335-08de0b0a6c0a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 10:14:12.6376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: re4BXfZq50pytwLFSNR/plQVwD5tDtJV6S46nLJAWU/oLU3w7Dbtf8UmNKB1adubG3edlGGpqhCvVodZszTv1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5056
X-Mailman-Approved-At: Tue, 14 Oct 2025 18:06:29 +0200
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

Enabling the kconfig option for xSPI.

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 drivers/spi/Kconfig  | 15 +++++++++++++++
 drivers/spi/Makefile |  1 +
 2 files changed, 16 insertions(+)

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
-- 
2.43.7

