Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90ACBFF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CFAD84676;
	Thu, 30 Apr 2026 10:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wvXLj8k3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3C7684666; Thu, 30 Apr 2026 10:23:23 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0EE584653
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:23:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjHQQ/R3JEmpO1cCqSxrUX4oDQj4HubX48Kn/y5tSWblG4s3SitJjDBg2Kl2AVPqBfgp+l6RzHlBdp6y7Mt8opudpyGZ7R1VFjEHmL8UStt8EzZb7WlKFL3Gn35H1LTz3v0gI9rEVyq13FvRGQUyuKG7uX3mTBCaFtH8rnjhuqxJ+/YQ6IpMXLrvTeKZZjhpmlOymxli978Kjtw087Efja8dpQ38JXxnY+iFLfjGCM8YJnuq5f306Ermw1ccQLJyJ0LI4DNq/nJLta91skLpWSS795xP37FoKMZYH/k2YFyA5mVaHspFJ4kiFWFZTK53rMnneRCezUGg8uYBRRFsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qm3MNfvxF7jzA1wHDFI5jFgFJmPL0omqjkCdrhId/8k=;
 b=BmWhLfNZMI43i1smgjXCXmrhDXW2h4Drq36nJCb/5kQwxZXc/zDQ5ph0flBdn6eI8QmQnGQZ4mw1mxyPfgfOYPS1upQhCVZz0YSdomGNR9v6Df/T9OrxlsA41YuvkDzcpb5j6W3zFQCPqfc5+DauvscGAveqCmo3ojWdKgXxY8sKIFWBMWVI3GVbMQoxyyeF8FTyN9ur2V6bbSzlIF0jsaYS5U02jVFi+JaTIUDXA8ts486nAWzrWjHjq7QpkVu04eoDJxzJzTlZyr9KjIdAaoEsRVX6vlETjPz/mzIQH2ecIHfRvRkfpJBdb1MQhAXEOY0obgHl7329FxVlPG3ifw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qm3MNfvxF7jzA1wHDFI5jFgFJmPL0omqjkCdrhId/8k=;
 b=wvXLj8k3r+xcSdj4+mZ/qBPsu+/fNVB0/sK9P2INHzOw+dKOcK8lYICxgQfZNFqFoez3oaV+nNmb2WxehnMY69cfaQY9fyhmBWLHHB/rml1vehWRCNVWh3gssu3lM0MTBSiyazIIPK2V3SWvCUlhjWDmZWLuyLzlnQm9WbuJaVzb6PJflli3SZka4z5Ir0/FiNa+MQeCe94Txx8XQ+3eNCHgqSSxzX7NOt40s+4++zlLcJm6sFdI4H6LsfOMzUXbuV4gugZFT0e5iaOunCzU0IhcAHLtKkPueNkE8/7zftjzWltxSsNxDjkKa7mWxAeKdIyDkUsXsJ2OliCkfu7Akg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by DB8PR04MB7036.eurprd04.prod.outlook.com (2603:10a6:10:12f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 08:23:19 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 08:23:18 +0000
From: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
To: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, ye.li@nxp.com, simona.toaca@nxp.com,
 viorel.suman@nxp.com, fedor.ross@ifm.com, marex@nabladev.com,
 joao.goncalves@toradex.com, ravi@prevas.dk, ping.bai@nxp.com,
 ji.luo@nxp.com, qijian.guo@nxp.com
Subject: [PATCH v4 4/4] doc: board: nxp: Add Quickboot documentation
Date: Thu, 30 Apr 2026 11:33:33 +0300
Message-ID: <71a675d6947a679b73b422c708231e01837e1b4c.1777536451.git.simona.toaca@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777536451.git.simona.toaca@nxp.com>
References: <cover.1777536451.git.simona.toaca@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0022.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::27) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|DB8PR04MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 7625d4a1-f390-4d2a-a89a-08dea691bbea
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: fieuPSvp+fVoKWRik5ttCk62KoMBvyOG7ZsmamBowykVbu1elAbBRoYt5NqD8igX4h/SSWiVY4vDJ5VFJRBmZzGYKCoIzLvBPO5bZguJmsavLJgGQbqgLkiUlsFV9g6Gk1SAJPe36RLZoIy4K5kw2UefPV2/tdNXXfO7ao4ia2CRPVAB2sI/Qu77DOs/sNd2a4T5XgqWj61Pbn9C3cv5cxmd6TO9NewSBXICTmPbXE4x3oeO9kSEAvvuABuEzTETOB4TI229jAyrQs8cWgMYgenebR1Bn2HFLJZ3C5+/LBZpA+tQek4eOUU9M/xOW/nH+Iz5cJKYIPWj2eEwvwFCzXtGYNrc4aeLZGabuVoxM9Y3n5l9vOe3kcAu/zl+12YSQ7TkJb2/y8WsRRXWwvUUk8rqwm3K0SYwroplqo/AgDrTKA3dJiUKmv+baYazfPOM6o5dmyLCN9VOf0Ys2I+x+ucLTKyepZwT0UHY85FwXliSi92gu6jZj/eDs4jskBrsx38VT7T/f5Nm0OTbKK17JSZ0QsNfKTjH3WGLj2hacNGQfpeRGYyYW9qM9S3O/nYMLv6IGFyXoEhoc4q5wH8oAtsQxRc9F52ZlN1zvxbSCG4QnJdaBkjPCLQwOU5v6XAsKUX2YgGR7MAtW6nUqfVUlq+qpCpI10ONEWdBJSA59m+OC2JYjDbbaW74OGRz+32pQif6Te58azZ0dOACWhoF4UVvGXKSyA7sssJunn0NdME=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nt8OEEbl7ybMN4P89uSu4zaPbBqZG5Xc7jCY5nJsL9QMxmXqpua1x4AER3Pp?=
 =?us-ascii?Q?XaFrKargh33JTRBEDraGmyPo6n0n3D5QKE/XhOOpQdnatjwoWOpW5BGHwMwD?=
 =?us-ascii?Q?FaIa5LDGOI1Hsriexp+ZotAMyVkKDwDPGCpmQlKvpearKslb3c7F2hm4gvqv?=
 =?us-ascii?Q?JCqWKrXNyXRG09iGE428HwIRHnROJWOE9iOsovftWEsi+OGUCWsuTxmlxFZR?=
 =?us-ascii?Q?0JGwhzX/KwyRjurDqLVvyxyImoheRSPFlpMGQUxVpu5xNcYQrddhTNB7vYFb?=
 =?us-ascii?Q?fFfTL3jR7axTeBHt90LP3D40NTwP+CR66C1P16olWC8uTzKG3YgHaF7QyQj4?=
 =?us-ascii?Q?feMp3pgD+KpDRA5xf0tLGCZC/LZfPC5kgCa385M7Z1AvzFNSGtsp2jT4U06q?=
 =?us-ascii?Q?0x1uGp5syX9tgBHZ57br2FCF1JDTWaZE4EOPHPz68P+k2eJEOj1JQUHDo2Ai?=
 =?us-ascii?Q?dPDXqUMZUmn6vNVzMQyuSpMLBn+5gxwLPAlEWieWmSeE3Xm8RZPKr6HQcI2S?=
 =?us-ascii?Q?BAJA9ohNIbZBaM+/aMsRUVVEcCnXVYfPGAuUwVVcm/gOVTYYZaZGiH7SoRtS?=
 =?us-ascii?Q?53eSlbeVRlRTCG7fJ4x/3SsL9nKgJckMBel9OCbtIGEoW2OENMHPJX5hiCzP?=
 =?us-ascii?Q?OoUW9vutmuUPG3VLeqZ+UsL1l7Edt4TJ5AuVJwC/1CTfHLQs9vTNqEDNfMxv?=
 =?us-ascii?Q?ggaKH+Kc+nAFWcyM8V9/+yh1NvIcudPn2tvMATpxV8ZPY+7fsURPvjAQ3ZD2?=
 =?us-ascii?Q?i/r1H/ZANdcTx2rfeimTtkhEkNVvwubpjSAqKpJg4aLi1WdzHQ0aaDcdVGKX?=
 =?us-ascii?Q?7+UNh7fOJzDRkztcHrA89NbN8KoFt0l/S5stZM+kugx7RiBhblhHCl9EpT8y?=
 =?us-ascii?Q?JLWtPg5eXJAFI6TYfJwglAUR1QY2GVpy0QuAhnnsMYEKUbequhn23oQ+QW7U?=
 =?us-ascii?Q?z7HwqLuGJTzVrcnzC4osiFg6vgR+5u8GuWozh2rQ/Vrxa1kreiki/2m37vOT?=
 =?us-ascii?Q?aBF2ztmTxiF27knGoJlng6ZkdaKotUEB4L0WXTxsQRmQdOOiwcjchjGEGV6e?=
 =?us-ascii?Q?ppyjGJMRDt/1ImmK9bDI9FKD4d3jz9gY7xIfNsnR6m7LFEGb7eGLx3WQKvAZ?=
 =?us-ascii?Q?KJQoO2xOB7rd/kFzRgo4I1OXIZlcSz+bpdc8TF3IpdwoWdpLMLaDlPAm3v5t?=
 =?us-ascii?Q?4TI3R1n+HTQ7LvQ6Ex3KOqH34Cn/qJjNcN6g/P/66PuvsYnsxdR3N3nSsFjd?=
 =?us-ascii?Q?hnMyUQK1GRiKQLSbV7cViVRA08jC6sz6SVM4Z+VUA1BjpXFuDfprvvIQj4EK?=
 =?us-ascii?Q?My1rowoeJj6Wmco4G2ZL9V3/5MlLCo3yhXHjquN65430tFhftCT1zfeq35+7?=
 =?us-ascii?Q?uFoCMwSmO2PKKVJB7YYtkTJb2CdxgZYVChEgbgKgq52GxlTbNV5s9DkAXQDk?=
 =?us-ascii?Q?NCe/LJR/2Mz/gdBQAJ91kKcm/E2y12N/65H3sqbZ33FJxlqgeovBGgEelAlC?=
 =?us-ascii?Q?lIA549dz20B8oAZxzdRjNzLbsIdSewU9nnjJdm4JE6fn8ODd1Kd5Uq5r3B1y?=
 =?us-ascii?Q?UCovt/oI0Hq3mfklA/jOiYzOd7KF65OG9HdgSVGBNToSwbKLLFH84XJAZ8iS?=
 =?us-ascii?Q?PdG7af9XT+R/6ZvgBaVVd6ErlhGNN7IpPZMP7MEUwFQc7M54xOznH2dCF9KT?=
 =?us-ascii?Q?Vv782+0nIhaGGPe7KCxg+JMcWtJ6K9yKPqRTpgypYQ/lbL3UZTLcgz3Qr2H1?=
 =?us-ascii?Q?evXa++jUZw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7625d4a1-f390-4d2a-a89a-08dea691bbea
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 08:23:18.8246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ar8RLqA6nucKpwvx/8SezJCYLs4tfxrqjGSVbnLhfC5WDnc4YyxHAeu4xf4iguM8ZsH74HtOgMXl2mAfEuTb0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7036
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

From: Simona Toaca <simona.toaca@nxp.com>

Add instructions on how to use U-Boot to save
DDR training data to NVM and explain the saving
process.

Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
---
 doc/board/nxp/index.rst     |  1 +
 doc/board/nxp/quickboot.rst | 59 +++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)
 create mode 100644 doc/board/nxp/quickboot.rst

diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index 8cd24aecf33..52c8e85fa5b 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -30,3 +30,4 @@ NXP Semiconductors
    mx6ullevk
    rproc
    psb
+   quickboot
diff --git a/doc/board/nxp/quickboot.rst b/doc/board/nxp/quickboot.rst
new file mode 100644
index 00000000000..0fd72b4e13b
--- /dev/null
+++ b/doc/board/nxp/quickboot.rst
@@ -0,0 +1,59 @@
+.. SPDX-License-Identifier: GPL-2.0+
+   Copyright 2026 NXP
+
+DDR QuickBoot flow
+------------------
+
+Some NXP SoCs (which use OEI - iMX943, iMX95, iMX952 etc.) support saving
+DDR training data (collected by OEI during Training flow) from volatile
+to non-volatile memory, which is then available to OEI at next cold reboot.
+OEI uses the saved data to run Quickboot flow and avoid training the DDR again.
+This significantly reduces the boot time.
+
+The location of the quickboot data in NVM is a space left in the bootloader by
+mkimage, with the size of 64K. The qb command searches for this space to
+save the data. Thus, the NVM should also be a boot device and contain
+the bootloader at the time of the saving.
+
+U-Boot provides no authentication for quickboot data, only its integrity
+is verified via the CRC32. The authentication is done in OEI. With
+the exception of iMX95 A0/A1, which use CRC32 as well for verifying
+the data, the rest of the SoCs use ELE to verify the MAC stored
+in the ddrphy_qb_state structure.
+
+If the quickboot data in memory is not valid (CRC32 check fails),
+U-Boot does not save it to NVM. So, if OEI runs Quickboot flow -> no
+data is written to volatile memory -> invalid data -> no saving happens
+(qb save fails during qb check).
+
+After successful saving, U-Boot clears the data in volatile memory so
+that qb check fails at next reboot and the NVM isn't accessed again.
+
+There are 2 ways to save this data, both can be enabled:
+
+1. automatically, in SPL (by enabling CONFIG_SPL_IMX_QB)
+
+- this will save the data on the current boot device (e.g. SD)
+- other configs specific to the boot device need to be enabled (CONFIG_SPL_MMC_WRITE for saving to eMMC/SD)
+- use for: automating qb save / saving quickboot data if using Falcon mode (skipping U-Boot proper)
+
+2. using qb command in U-Boot console (by enabling CONFIG_CMD_IMX_QB)
+
+- supports saving on the current boot device, or on another, specified device.
+- supports specifying the hwpartition for eMMC (for booting from boot0/boot1)
+- if flashing via uuu, the command can be added in an uuu script (boot device needs to be specified)
+- use 'qb erase' to force DDR re-training
+- use for: saving quickboot data during flashing / controlling the NVM to save to / forcing re-training
+
+::
+
+        # To save/erase on current boot device
+        # For eMMC boot1, mmc 0:2 has to be specified explicitly
+        => qb save/erase
+
+        # To save/erase on other boot device
+        => qb save/erase mmc 0   # eMMC boot0
+        => qb save/erase mmc 0:1 # eMMC boot0
+        => qb save/erase mmc 0:2 # eMMC boot1
+        => qb save/erase mmc 1   # SD
+        => qb save/erase spi     # NOR SPI
-- 
2.43.0

