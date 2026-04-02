Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0DFD39404
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 09:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6D1084106;
	Thu,  2 Apr 2026 11:29:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GRgTkU8o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D85384154; Thu,  2 Apr 2026 11:29:47 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 955588418A
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 11:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrZsdxOeiW5jygAprmQ9SKyA/y2RWievaz4HBnqVtGTmxiOyHTkbsUn0cN69luSaut0u8aJ4NMN/dbjKdtA3z71WKrNEpG2iC57xRbid5OHnDZcqiNF6bQMaRvyvtTtPyiusnNZ8pQ/Fh5qZHVtRRQfoG+6bgMB8W6OE+7mUc6bR4Mt1zs2TsZkzHHJoS1/wSJI47cwuhfTmflvFzsV32MIpZj8ufnafZ/gIm6SUeuKW1bZYfCV/Q27+XCLe5ImelSPYKfCSbrImWJYn0SHACyiBMIPUokXa3xNAw8GP2GJeeHFfsmv6y7HJeD1ij475Orf12bRvbbJaqaSTNRmIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/V5c6KnMRM11UFc7kOcxwmzEdMdQ24z3zwt7vcI+6Ms=;
 b=tY41xLkm+F+FQChTthh0ehI2Sof79k9oE1JcuqJNjs6O1IwB2M7Cmq2roHSog/fQQrdWe6nFhIUpxkjR+eYDvNu1Ffs3rtHc0kWY8jhfFOWaOk1cEfntOkx5jYha8p5QcwEvF4BwCEQb9taoUzZHOfXt3QmpCK9F2+8Kctmf8895uacveKATSr472MYvePXM0Ap+3GN2zyPrrJ7W6OtmefK0CHwkS7M93878RRWvSt1/p7bxkeHkV2TxYWH+ivVyjyiNFZ9AMqqePBJQzJb5g8T6VOTj/V0XQXd01L6Uaz3qpxD8ydlzFe8ZtX9ntQV56M38ODs7V3c4lwkSrERSdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/V5c6KnMRM11UFc7kOcxwmzEdMdQ24z3zwt7vcI+6Ms=;
 b=GRgTkU8osAikp5TG5btr4BNNUdBAoBJRZiorbsSVS0gai2UrP3BA7lH7/vcaQWjy3EfcfExbJgfXBkGIX8vWxZA36l5CLIXXqR4QCkcmVfcrShm/HOusrzypL/48Gj7s6398n8LEqu+gTIrUhUfYCISYRWDlXuNIwvJ5dpDUhgrXKohZOQOzSTJcl4tQsQxRbQ+6d8omHpfIsPm4i6AKu7ETQ92ckx+GVuuctfyvbd99ViHpWPWUtzfgY/kvDTAZFpNazNwZSC0t8b0wsCXv8zzMUf9DayK6vC+PUilxXnHyp8YWXY8cKW8u9OCcQiOnB36Ho2Io0vRijKNsERKLRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by AM7PR04MB7095.eurprd04.prod.outlook.com (2603:10a6:20b:11c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Thu, 2 Apr
 2026 09:29:37 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 09:29:37 +0000
From: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
To: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, viorel.suman@nxp.com, simona.toaca@nxp.com,
 ye.li@nxp.com, ping.bai@nxp.com, marex@nabladev.com,
 sebastien.szymanski@armadeus.com, ravi@prevas.dk,
 joao.goncalves@toradex.com, ji.luo@nxp.com, semen.protsenko@linaro.org,
 tharvey@gateworks.com, qijian.guo@nxp.com
Subject: [PATCH v3 5/6] doc: board: nxp: Add Quickboot documentation
Date: Thu,  2 Apr 2026 12:40:47 +0300
Message-ID: <bf216cd8652419e9ce7b9133775a2ea4509fe763.1775121078.git.simona.toaca@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775121078.git.simona.toaca@nxp.com>
References: <cover.1775121078.git.simona.toaca@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::6) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|AM7PR04MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6156a9-2fe0-4a99-0528-08de909a5b95
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Kv0koNrjqAO/Msk7JRNLNwFDgvL5CsaESZI6jdn/lZTTNmfZh20r52uFC3PzhqTtgpar1eehsPHw9vlIUx9B1Q4WRb8hs8xwRjmIHusoyV8ewlLSM1368fA9/rgtLJS/Uvof1pdaGBO3iQ6BjPq94t3EJvKUHsVQcaPl2JkfLDg1eWq6mUkwGQcITDtdmmYwKetG9/amtyYHBQDpjEd8ufX1Wy25NN0+M41j9IFdqDw6o/gx2RJGxcU/TdmIFOKpLD+ztMPQ6cVDFdpCMfrAIZCuewIStEqzdS+cd4QHw6lQCBbzXANSZKXB1djLtD3RsfwYGp8CW6prlfYUa7+wkJl5j/cTrcZS6gTpZacsGwkMK6AiIJAzq+cqfUW0fUbwQaot+gkUQK3qDu9Y0QDSoD++uCrQ8m1lqpY3m7Oxyj9frgjtPzWcEy8QsUdMgGdxdxZTa6eUQnB2nsCnCh/3Wr3JlT46Fxn/uWjJnHC8EUDv+14j/XGFpQ9Kptzlfb1yGugevpDLD9C/EkBtTbM8xd9Mh2nCaA98VliFr7Bh8qJOkJW8uQ0e+9Ms9apS6OyaNYR0za41MwnNx0eYQcVpSJbQ36JQiBaX1Tke/vQvguZHehEAGtrZDhZNwdNejrPRvJzoVwvVoY2uMKZ6Bud8UbYpPSUZtvN5ASXkGJBLKT8HmIu2AAHDHw4T0ZLe7fPo/vbX36bE4jujMoe6YqQRuOEAPzoByitLYqqTC3XLn3Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wls1E79cC6GcV1m67eChzjPj8h7pEC/4Jeonmfcot6woQBJkok8N2KiyL/Jt?=
 =?us-ascii?Q?5lOAUrIIH1l3iLL3qqAk3r7qYNSN4T4CYw1+ji6njLdfwMwVlaC1TymwhRP3?=
 =?us-ascii?Q?8x5OLnfczwMBDOE5V9zxxpjbSvz8k8doEOqIOycgcByRMiR4RMOyewCnhf6a?=
 =?us-ascii?Q?g9ITJV67/6WCbN4Vn4P1j6R5EG+7PS7DREG7IdPomswKTYUA7cQ07WeGHNxv?=
 =?us-ascii?Q?wdfUuvwuoPU0ETMznq3cEmXzVvzQm5RRHnNDg5+OUKbC6SNgKKWqAOWH86nU?=
 =?us-ascii?Q?Iz5WK+0xgdnHAu61i1tTpKZNyodq2WuVA5nah11oJIB2i6KT3FRU43HtftMY?=
 =?us-ascii?Q?G9IiXnwtuxyrJAWttlwXEfrRxEhbzVDE9Ry0MRzBPoQiE170GPk0xTb5aNxc?=
 =?us-ascii?Q?M/cGRwUUNZLZMXNhWA2FFdj1S6mkHKgub5DGHIQJzwehmUmFb2QBt6/XkEaG?=
 =?us-ascii?Q?yCWxftrawlGBhm/VtOPRKp8V5KptC2Npm8PMLvmQtVWViGW1ixkpD4faeQT9?=
 =?us-ascii?Q?bwj/7+3C+ZuXf7/uQoGvoiVkw9O2hNwtVQZcKXpsosAjfOOCXIcaHROCmVFs?=
 =?us-ascii?Q?7dMF/2hzI0E8XSCwrb60h+M5jXtskcFHUTpqbFSP5cJOIXr/oKuQ15bDxOUT?=
 =?us-ascii?Q?FfkVTOfe2LDUhxSFv942bJ9rY5c0llR+Bks/P6JQ+OC6/HKYmba490pu3Wp/?=
 =?us-ascii?Q?dOf2kV1vt6tQrxE6lKvc7yILdHqYE8HR3O+7JwGM5lzmt0dn6+VlpTvuNFCG?=
 =?us-ascii?Q?IeGZkdwBOToKJDfRSj6OJCn8srCmvjF8/6fd4i0LjkIfuPvZ6IAgtFV6htlM?=
 =?us-ascii?Q?raEoQteSrokwvgjlkFKSH1IJtvQfG+GX2V5B9c7bT3miGNjS09DhleJYMQk1?=
 =?us-ascii?Q?cysLlYIYFQXHuDe66T6fIo8ILxP882gaGYdBjiYCK+yrqgxdcl1OH8/ZPI3L?=
 =?us-ascii?Q?8FnCMe8krx4lHNK/Ed3XjmqTxF8+vKlXRcRX7kojTTIcgJLU11yP1ss11+J+?=
 =?us-ascii?Q?QD4IAsQ16XtJFWQXR9Fpvp4i8oXUP+/smPAPDs5Qlqs9eG/TeWrjxaXgmwKF?=
 =?us-ascii?Q?imqDEXn6pKQC9og3ZyTrrnfEq8EznfPT/ruj6dfyEgRVWpxnGZeZdo46tUR5?=
 =?us-ascii?Q?ZkN99uHCEaaPFb/6LiL8K8HUb8QYWlmJzZGGV81x9lhhQzQdsjCy6+fD6sZ6?=
 =?us-ascii?Q?+CsrPD5bnflw55UoOLFtgJpZDdj6hEcirU7OVvateWx10pZtmXzKDYlBBFrk?=
 =?us-ascii?Q?tBx6jUEhRA2Ok+yG0vAbZxOrcYwo2HNbr29DRIag0SHJ0qzB3f/NF51WIg5+?=
 =?us-ascii?Q?ObRpepniVj0soEhbB+SFAyvxPc9sIwpmlXlelmN/EhSnCZf97tqn0qbeVtvc?=
 =?us-ascii?Q?HUdiof7asy9xOSSesiLbOuqFeDtHhEYe7U6QNUn9cttuMUVw6cLjI5GTAI92?=
 =?us-ascii?Q?A9HqFmCoYGCea04Aix5OozP6RtLl9of/+wHP9i3BVMgunn9F5rrBi9UOGm5G?=
 =?us-ascii?Q?zBTS5JkDEBw7z0oG0I2Imqeoovl+oW2ocj3iotv6wPc5Zybs6dHqKPKkMCA4?=
 =?us-ascii?Q?imAjunBceTK1sulDU8m48Y8cBzHkGZqc+XeTjqCVNBilvb5bezFkonMowAjC?=
 =?us-ascii?Q?BXW/5CHjwAr3u0l4ZKzyGfRISjXIoWiSW4UiWANndssOUuCxS4xQpZxrvC79?=
 =?us-ascii?Q?ubEbASj5mpiAjKrlsVJK4vTUBW2ZZt+F3X2cDrkndMhVJOiD70FXj+NdGwGO?=
 =?us-ascii?Q?PubFyQGo6w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6156a9-2fe0-4a99-0528-08de909a5b95
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 09:29:37.2362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3nxcmqC4e7nEY6znbs4Xju2Ax8OiE5suRj+VRxOrqTcYac6UAJvtdRnkNFTKT0DZBPMl9aVlfmZdmrhRk6BV9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7095
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
 doc/board/nxp/index.rst |  1 +
 doc/board/nxp/qb.rst    | 54 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 doc/board/nxp/qb.rst

diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index 8cd24aecf33..53ef220d989 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -30,3 +30,4 @@ NXP Semiconductors
    mx6ullevk
    rproc
    psb
+   qb
diff --git a/doc/board/nxp/qb.rst b/doc/board/nxp/qb.rst
new file mode 100644
index 00000000000..07953a1b7e9
--- /dev/null
+++ b/doc/board/nxp/qb.rst
@@ -0,0 +1,54 @@
+.. SPDX-License-Identifier: GPL-2.0+
+   Copyright 2026 NXP
+
+DDR QuickBoot flow
+------------------
+
+Some NXP boards (which use OEI - iMX943, iMX95, iMX952 etc.) support saving
+DDR training data (collected by OEI during Training flow) from volatile
+to non-volatile memory, which is then available to OEI at next cold reboot.
+OEI uses the saved data to run Quickboot flow and avoid training the DDR again.
+This significantly reduces the boot time.
+
+The location of the qb data in NVM is a space left in the bootloader by
+mkimage, with the size of 64K. The qb command searches for this space to
+save the data. Thus, the NVM should also be a boot device.
+
+U-Boot provides no authentication for qb data, only its integrity
+is verified via the CRC32. The authentication is done in OEI. With
+the exception of iMX95 A0/A1, which use CRC32 as well for verifying
+the data, the rest of the boards use ELE to verify the MAC stored
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
+- use for: automating qb save / saving qb data if using Falcon mode (skipping U-Boot proper)
+
+2. using qb command in U-Boot console (by enabling CONFIG_CMD_IMX_QB)
+
+- supports saving on the current boot device, or on another, specified device.
+- if flashing via uuu, the command can be added in an uuu script (boot device needs to be specified)
+- use 'qb erase' to force DDR re-training
+- use for: saving qb data during flashing / controlling the NVM to save to / forcing re-training
+
+::
+
+        # To save/erase on current boot device
+        => qb save/erase
+
+        # To save/erase on other boot device
+        => qb save/erase mmc 0 # eMMC
+        => qb save/erase mmc 1 # SD
+        => qb save/erase spi   # NOR SPI
-- 
2.43.0

