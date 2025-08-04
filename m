Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F87C87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 22:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CA9584065;
	Tue,  5 Aug 2025 00:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="x0uPhCMe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31D1B84065; Tue,  5 Aug 2025 00:13:19 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A89F84015
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 00:13:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJdT+qJ6uKPf2rqaNKTF/pPjO48g9wAZ5FDMpx8x9CH0fBZU/PDihMWip4srcuH7z2Gh+lqqW20TbQeedONOoGhuzIqBXwXglumQbyACfbNsCMG0eafaWT+ZA76TKn7vGr6LjbZMVQpVAxte6WLmRieM4+9jKALjTH0Ooqfz05R7XkWNA16DxVLuROXFMsv1PETBjU5CUa+FrDrkGoc+ZdAGBMbmLKwZ5I/LuLWGV5F1c0Fuq34TZoc4IHJdMPUvCVsq158rqlwrjxeuiUHRs49zPdjZgayQlLGmNIIYijJ+Lb0iJRGuKUQuNZILhvFKK6kwEwckaxIzo6fAYj20Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pE9cMgJl9iggn2FgomTMlodNjUNWd5IsRXR2nSFkB1M=;
 b=vOXEk6Ng8GcKj3gQHFUy7MzwaoCCTxnZAyx8JF8mZfM2fR84IhT/AUv3fRBEGq+yE8OV6g1hN4Rbq/29V8VJzOEM6eqRKjOqfCVHrXeBo+nh6uCwoelfXKswYbQFQAm6AoSFLrYqI7r1KlfwKV42qh/NyObJEkJ1qOZYlEwBb+hwDRbTwrh9KIdMmPq8WfK91B+0QfLjVMI5DjKL5nni8AZpae61PTAxTPcQNuUXGdCUo7wKkzHKJ+vjKIO4JiZYnAg/UT1BlyywJb73l64Lng6tEuoCwQ1DD5PnYS305ey6VHYmquy2rs5bbQeI1sJESccy5P5gXbp1315IfJsC5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pE9cMgJl9iggn2FgomTMlodNjUNWd5IsRXR2nSFkB1M=;
 b=x0uPhCMeNNxbqx9nolr1PhdiTC0d4X83hTno08cAKFhDMFVYS1ukNd9jhis2fnQ7pw/ttcTK1q+SxbIlIkLTXMbzgJgcK5/Hc+g4GQ+95gJKTQsuq0z/ymZ0AAYHxHHg2oME44xOqe8Vgx8G+F8dvTR7d3Qws54k5GPzBSXTW1QovcufRO6omq9fjos7P1pE0Xks12DyxqC8ung6qkgWk5SyjqiYpjeacTYCAJ6VNdGP0hMIQTiyPnjg0gv8+9/woF+ejyRMzQ98GxJ5PD3s6fNouosFkDKFFhRtKtTf5P7WdqXSzxMN0zozcqMiqLPSklegVeeraSnsXNGqgqD+Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7771.eurprd08.prod.outlook.com (2603:10a6:10:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 22:11:31 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 22:11:31 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 00/22] drivers: mtd: spi-nand: driver improvements
Date: Tue,  5 Aug 2025 01:11:00 +0300
Message-ID: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0144.eurprd05.prod.outlook.com
 (2603:10a6:7:28::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 871fbc82-f63c-4b0e-9704-08ddd3a3dd8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LuEg2tNlG1OlAq4zTbQ/XW95hjZ7lqPOt1r9iKO0zAlH2YIy4Pli1rfhmLb0?=
 =?us-ascii?Q?vyLjY+JcUyBOnChsHTemNz67oKIuNLE6iEiIB0ynZIKUSHJ9IGBzzbT4LZ6g?=
 =?us-ascii?Q?U7yfabLyKk5JTvHvY1z1rom5JssgKLE+eV086scSEzBmp7vkJ33Ulwei/jgj?=
 =?us-ascii?Q?xxOpZLdGIUwUu9mrgyFCUeXkxUe1Ufks3XzYCmW7wyJBFpM5kYUNCd5FGbjH?=
 =?us-ascii?Q?glWzkTZSrvyBw6C2dpX3ADfWgw1s+x+U2UpATi8SbDOMyNhN3NSBMY4gvibb?=
 =?us-ascii?Q?gMmrwtxawZ4dt69O5mE7mCSb6CMvpNmrtZQeSsj3+f7J3RvPbsZS+/8Q3Z1R?=
 =?us-ascii?Q?dDfX3JwwJIpWFoYD/7oan3ZcCOhl38YoarMWRjirt7BVgK3ZXPc05Ngnikxh?=
 =?us-ascii?Q?ulSowJIkPdKebj2ZkrEbfy3PZsVkrHo8sWAw2dEDxYd+bhzK5+AyEmRuh07w?=
 =?us-ascii?Q?eTfdjpfAvCJAqojtM5ruuP7GEk0U9GOuBqQRG/EH6gTHkysgFuoBp/No/fgV?=
 =?us-ascii?Q?0bqoKrAX4Re6Pb0jHmq5NKwo4I546QBdxdqw14WGZ8WMCNXxO/EWRKDFZha0?=
 =?us-ascii?Q?cdGYwlsHyLsSR+Nb8+hwwEUk01WPaf+3VU7rW7cY7qJQ9E/hZsRgx7kGZIDM?=
 =?us-ascii?Q?PxA66GkE7ZDXf3fc83TE/Yn1ea4pSKO/3KuJtuOz9KEtnRi2OBkD0eZkmUm8?=
 =?us-ascii?Q?Dp6sNaEgHRL8UQv+DfSxpl0696q/u4WxgDQgb8dKkr+wR2FJrEi2po0qsExr?=
 =?us-ascii?Q?iz4rm7OCD0Gfh2CRifP15kOXjVyn5nJ6L2CXLtA3+dCDKzmLkeRTHnptOg1u?=
 =?us-ascii?Q?sKIYmGlGf6OENsoy0jBMGLntj4hVNAVLGqSmJbOin2dDUDpnjvfPGi3HMnrO?=
 =?us-ascii?Q?OuT8tSMasUF6vfqikgUu2E4shtuHMgh/JjVu9wenZ+b9ckVL8tuygA/kNo93?=
 =?us-ascii?Q?vylSTVhPNTk13hQmtcth3SB2+V8Iil7rpOqTTSLUgER0/OrldyA2Pa8NOsN5?=
 =?us-ascii?Q?v44KCRo3w0SXhqQkIISnlXugNJgPEgdiSKs36Cff1SM17hyiPTFWyC89q5gA?=
 =?us-ascii?Q?B7ML4dLbtcnmd1+2Juym4K7hzeDDo4T3WM88ZhmepZ8tW508j+TnLnb0ur9n?=
 =?us-ascii?Q?KByCJhzobLCNGHgCjYDYiwlOdIkp6TWoAzUQxfXOQz2KIPH32tNkVrG0CGa5?=
 =?us-ascii?Q?NZ4FM9HlF6FGt24QHeiZbPvXtQjEDlC8YfQdUKvJvNrVlEWSnzT040dmN7mC?=
 =?us-ascii?Q?aTOr+H8leWJ9H5Vwi+IEZN2LsGeg2q1creH0sWy3lzqukvV136jF4N5r/Wn3?=
 =?us-ascii?Q?W48wndipkzCD/hS8S2TqNICgigKCWmcR+PPSs6aPFMG2IZj/1qB51iefgbYp?=
 =?us-ascii?Q?GxVJnHik4CtRu+tFOvnyayI031x2XNL+HeRBnpnSx2BO6C3rgJIYm+RrtfOZ?=
 =?us-ascii?Q?V/aUPTIMen98ozjwjwnn09F6TRBWglekQG/lUSivZJ7ssAAe3/SeFJeyu2Ko?=
 =?us-ascii?Q?XOBwOwg1hDvMGkI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?37GLYIFEeiYWA08vMfJzO2b8PtLFB5/L+ENRYfRFmIT/Nzbg1OxTpJvtTZR+?=
 =?us-ascii?Q?MZa0NVftl9jTLle93RwmSSWycZFlD4BsFeWbyeF7YortZTD3Puf4RysCT8wV?=
 =?us-ascii?Q?zOW+WpAp+3ohiQQyJfUvnfpxZSORP7u3R2uJQiNJX8nERSesS2b5YRjFX9uU?=
 =?us-ascii?Q?j10EKt+MyEO+4cXtLxA5rB/EMoqLPaA1yKukrsWoucR7AtBXAJ9BSclH8/hg?=
 =?us-ascii?Q?yRU4Br7COrP4Dpp3+a0qFedMg0odB/F4V0tNcgkWuwNRznq73dvU5UzYvrrn?=
 =?us-ascii?Q?QBlVKIF1aVjnXcd/xDs96pFBUYfGAaXuuu0FGN7bZ36JejZM6m4IO0W4Bgpe?=
 =?us-ascii?Q?Xv9O20BHR6+B9wjD2Cb0iBB5+Z6qOkZE0D7ltJKyr9MAKaMdnHlqOsA91S+0?=
 =?us-ascii?Q?ZSiwjmzuB/1pWzerFZ+JIcyFC8Tx825EkjmDYOZSmSkYZoG03ZErPNzIP98C?=
 =?us-ascii?Q?HP1t4KTsMOaL9FFdvcN4Vx1Vx8U/0UpR7RPkjf/Do9SIKHtzh3wGE6gghVE+?=
 =?us-ascii?Q?DqzFZXdlp283mev2Gr5SCQVjX51xeCaq0RhOKwacXtbPHULwggAoWN+Y7CEq?=
 =?us-ascii?Q?FGbfCNm/r543D92RO+Akc7dR05ig+TZ4CB3eB5o+Qdw1LEKmZSu8Yc0uewoM?=
 =?us-ascii?Q?xB4/F6Dcs19cWYz1Rqc0kFIcf64Svo7pvSjZzuqyjAdEshYV5xadSL7d8OXa?=
 =?us-ascii?Q?YM5TCe6wsF5cw82L+9XSUZHRfhS3hZABfNvK44Sj+gycCv6RGWUvCKx54hFK?=
 =?us-ascii?Q?92TvR7hojv4zRWnQaUeefeJ35vLBUTMulaKGp3802Aszje6CbOklh9Dqb2WZ?=
 =?us-ascii?Q?nDx6d7LPkzrYc2sccU2CmIe9zvtd7ATMVTakx1CXcdhaSstEfFlDg8hCyfsv?=
 =?us-ascii?Q?ZHgrCJben1YneLz8mnJGKSVMou2eeq3OCB/Qq20mwMvDPa30FqLgLrDOxhZR?=
 =?us-ascii?Q?fVFySZLme82avCAWdi0NoPudU3BL+/lGKZ15BGPADzTJKwxAGdG9yU23AzQh?=
 =?us-ascii?Q?AgQbYdX8W4c6rJPjfy0qhVBGSad0PklOQNT4FyZobWjUH/CxSyeyggPwa6jG?=
 =?us-ascii?Q?Guaj2AT4N8XKMXYBKG01cpmz/RpJKX1uVObFejkPv+ga+8WUrqT3I73cP/Bj?=
 =?us-ascii?Q?LKL+r4n6iqKsuJXbFuiLPksPLiTi8ujmRjYA9WDtxxDFVeTVtJOz9FJ3RfmO?=
 =?us-ascii?Q?kG6Y8QNS+znuKp4esYvDaqFqaXllYMZN+PbMHuWl8KxEvGnv3lt/n+ETBB6R?=
 =?us-ascii?Q?92t+ruB2a2Isu6wQvdTQpgvpLNLt1qos8ycPUsJpgNnLZQK/VqEl9tE6TebJ?=
 =?us-ascii?Q?lMXdENvOFjEyA8OCC2U/+RcUL1BgNNHyam3zQw0XncaroMia2bxHwT6JRAdA?=
 =?us-ascii?Q?wR6ccFTdn/8ERAxd4trdEDk/DWGaBAi+uVDFH9Q4JghlLx8tWoVXC8JZdJNC?=
 =?us-ascii?Q?S9cl1LbHWPc7GtsWwtglkhPQvGnoXkKzXcG0tBNxi+hxMcZhzDaL1P5zpwu5?=
 =?us-ascii?Q?lQGppnIK25ecbxRKD7yGfr6UkyLDNqUuKY6/x6HmOfgPQAB+G8k8tFN8ybsJ?=
 =?us-ascii?Q?f/JYHEXP+UTNBHcgU8IKJwv6yakw37gLyKl82pCNHKkMA1fdLe/DwVvEMRzY?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 871fbc82-f63c-4b0e-9704-08ddd3a3dd8d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 22:11:31.1636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhLBzwOYcYJgBKiGZvd5gjpn2N3JxHPI+3S3qbhtK7bGSv5VrFYpvQC8RQ5FvGrWagihs+UYrvDKo8IH8mKurPUWgKPzSfLMva6S1tviZdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7771
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

This patch series makes u-boot spinand driver almost the same as spinand
driver from linux-6.16-rc6. This provides the following improvements:

* it becomes easy to port changes from linux kernel
* more flash is supported
* spi drivers can accelerate flash reading/writing using spi-mem dirmap API
* continuous reading mode was supported
* OTP support was added
* add support of special data recovery reading (for some flashes)
* bugfixes
* other minor improvements

The following linux kernel driver features was not implemented

* support of different ECC engines
* per operation spi bus frequency

The patchset also includes fixes for continuous reading mode.
The similar patches were sent to upstream linux kernel.

Changes v2:
 * update patch description
 * add fixes for continuous reading mode

Mikhail Kshevetskiy (22):
  drivers: spi-mem: sync a bit with linux-6.16-rc6
  drivers: mtd: spi-nand: Use the spi-mem dirmap API
  drivers: mtd: spi-nand: Add a NAND page I/O request type
  drivers: mtd: spi-nand: add missed add missed MODULE_DEVICE_TABLE()
  drivers: mtd: spi-nand: simulate behavior of linux's function
    spinand_wait()
  drivers: mtd: spi-nand: more use of spinand_to_{something} helpers
  drivers: mtd: spi-nand: replace enable_ecc variable with disable_ecc
    and update corresponding logic
  drivers: mtd: spi-nand: minor refactoring
  drivers: mtd: spi-nand: more refactoring
  drivers: mtd: spi-nand: sync code with linux-6.10
  drivers: mtd: spi-nand: set bitflip_threshold to 75% of ECC strength
  drivers: mtd: spi-nand: Add support for setting plane select bits
  drivers: mtd: spi-nand: Remove write_enable_op() in markbad()
  drivers: mtd: spi-nand: Introduce a way to avoid raw access
  drivers: mtd: spi-nand: add support of continuous reading mode
  drivers: mtd: spi-nand: Add read retry support
  drivers: mtd: spi-nand: add OTP support
  drivers: mtd: spi-nand: Enhance the logic when picking a variant
  drivers: mtd: spi-nand: sync with linux-6.16-rc6
  drivers: mtd: spi-nand: fix direct mapping creation sizes.
  drivers: mtd: spi-nand: try a regular dirmap if creating a dirmap for
    continuous reading fails
  drivers: mtd: spi-nand: repeat reading in regular mode if continuous
    reading fails

 drivers/mtd/nand/spi/Makefile         |   5 +-
 drivers/mtd/nand/spi/alliancememory.c | 155 +++++
 drivers/mtd/nand/spi/ato.c            |  84 +++
 drivers/mtd/nand/spi/core.c           | 937 +++++++++++++++++++-------
 drivers/mtd/nand/spi/esmt.c           | 123 +++-
 drivers/mtd/nand/spi/foresee.c        | 107 +++
 drivers/mtd/nand/spi/gigadevice.c     |  66 +-
 drivers/mtd/nand/spi/macronix.c       | 289 ++++++--
 drivers/mtd/nand/spi/micron.c         | 180 ++++-
 drivers/mtd/nand/spi/otp.c            | 369 ++++++++++
 drivers/mtd/nand/spi/paragon.c        |  20 +-
 drivers/mtd/nand/spi/skyhigh.c        | 149 ++++
 drivers/mtd/nand/spi/toshiba.c        |  63 +-
 drivers/mtd/nand/spi/winbond.c        | 228 ++++++-
 drivers/mtd/nand/spi/xtx.c            |  20 +-
 drivers/spi/spi-mem.c                 |  45 +-
 include/linux/mtd/nand.h              | 157 ++++-
 include/linux/mtd/spinand.h           | 342 +++++++++-
 include/spi-mem.h                     |  93 ++-
 19 files changed, 2936 insertions(+), 496 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/alliancememory.c
 create mode 100644 drivers/mtd/nand/spi/ato.c
 create mode 100644 drivers/mtd/nand/spi/foresee.c
 create mode 100644 drivers/mtd/nand/spi/otp.c
 create mode 100644 drivers/mtd/nand/spi/skyhigh.c

-- 
2.47.2

