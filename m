Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F55AC83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 11:44:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87283838AE;
	Tue, 22 Jul 2025 13:42:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Wz/yne4U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 091D4838BF; Tue, 22 Jul 2025 13:42:20 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 012B3838C2
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:42:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PW0y6Ne8HYkAmZyAYHU5/DfB7c+AtK9lbzGEvsOzt43u4EpBwxoW1BWJJ61P1JYan3cyXVs1lkYBJ7q00dADPsby+egB/LHJ4pVzpPd22CLk4MgIWjFDztwTm/tXfGXFm3A0u05JAiFicJGI85CL5WuLDHOUNl0qRMyUh/YxO284vECtTgxCMYmRl9CP57NXzB3OXBdVL2D3bqhjcH3Y7OLz8xIYodwJ7AYrvudQ6/jAB+C3aOQmT65dizVVMsmE6wvVTJXK1fB8FGwQMufHKPpf/8LN6SKRCZr7X44/iW1BfsRTRbsTSefKDz1gKGO8Y0t1jTOn6kGsREI1H12C4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2dpF/Lyx2rIeIcYLA0x/nJh3KjRwLiRt+V3hVKbK8Y=;
 b=Iy2it3I0TeG59hJCYCC/m3rblGd8/rx/XG1KyvvmXPaJzLyUV4eb/Jz6GxhzBqAmqaybA2vUjTpczk+p55hGdw/LpB1rDYWXvUZs6XnqchqUakSvjLO2qFQoEAwNQ6iOScw4ojSVrEn2DrmoMy5tcj1Dn1pJ+M9OekL13MTjMBkEzIBS3VEEL+uZ3SIs/8IlZG6JVTn6600suqz788wtXL0f/7Lm/7AYRdgyv0/whDc4rOwFab8FW/MH9Mwu6vxShhWi4wHEidiQowT7o5xew9aZ3vmDmU3bMMDa6lgBgXJqA3n3MFPS/I5kKjqV9BsYq2Fv/if+l6qiHgA21jxaTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2dpF/Lyx2rIeIcYLA0x/nJh3KjRwLiRt+V3hVKbK8Y=;
 b=Wz/yne4UQm6vPiyq1TcA8QVNrQOG4nQKK8cN4ofPmzkvGr7ZsdWES73NetGplqXzNRV73l5dG6C65KQAxTz4T6P6ESJzVjARI3jCLRUFL0mjmMaOot2BYTe01B4+/FbDzuo1NAfmpKe90RyfwJU4yxSpdXEtMRDYEdwtx+mhbX3lCE5CsCiNadRj8OPXPTkI4hcvapHNEl8R3DJpuJjHbEiHfG2tVGBPXLBRQmNMyEx9Sp7Ew3IrreC4zsL+HkA8V8JvaAdxFy6s2Ye0WmEApS1U8ZmoHG/iMLDU42p4hzv4IW/PqBpXhKGXwIJe++UAXqJR9mwgqic2yy+dwWweRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9908.eurprd08.prod.outlook.com (2603:10a6:20b:562::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 11:42:14 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 11:42:14 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 17/19] mtd: spinand: add OTP support
Date: Tue, 22 Jul 2025 14:41:33 +0300
Message-ID: <20250722114135.768998-18-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9908:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7cd8d3-aa40-415e-aa70-08ddc914cd3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rQxIsBQqzeTpVSEAPLohq3+igqYnGqhfZnfhUSaWxdiRpPybP9tyD5y/fv4o?=
 =?us-ascii?Q?hXTGdysUwFNM3AAABQUUH+Z8oWg7k752XGEDk42BL6I8xUdIG5jLv8wE5Ev8?=
 =?us-ascii?Q?phc3/rDDL/ZlxEAr0GRrB4aZxpspwwWXUhTtElO/cDF8FJBoMZ2dhjKM/FtG?=
 =?us-ascii?Q?19qaTHHL6aKgTwM31WvWSZwyzk4WZW861ZS6gd/8Fc2cDCPJMgneDASBp8+M?=
 =?us-ascii?Q?UCeYXu18w0arULwm1jS+38bJC+9twpzT59KXQUND42wW2gu+6ZNv0Hp1IpyS?=
 =?us-ascii?Q?KZehohvsDrGukYZWU6VZaf5IcwrTrJ9QV43NCOkTZZbDp5ozycG6FcrvcSrX?=
 =?us-ascii?Q?lJ1QBH5NomIJwvO2iJPjSWn+HDda7fKat18GsVQN/zJ0gENA9tGeyNdkUvlL?=
 =?us-ascii?Q?+aerZzCt6dpwN9dM7Oewh+k13e1wGTGIoYdvioT801uQOVc9j4nOpYuJ5nel?=
 =?us-ascii?Q?q60T+Af1ZdL75VGN6i76/Rzr+vwaaszA3sV+ZiG7jkOCC9QArTXbgza/Mg2W?=
 =?us-ascii?Q?VjP9Q24rBucahfS8zKh0bzBXFpf3SbMCFuPH3EweLvMO5Y2fz+IoB5VrxLhJ?=
 =?us-ascii?Q?CeTTxK5eh3z5yi3HZpd+scCJ1BI0VrVrpS/L8+tv+Tqfdxrg+//C9fZv4Qvp?=
 =?us-ascii?Q?ygqMBuA8jDeH4ToKn14sXcuMnfkE3AqqFLQJ/5uDMAwZKErYe9ke9mHQrckF?=
 =?us-ascii?Q?sCq+Bvi8vUbko+EjL5ijJLtkhYe0WnpVXyaFoCC5vo4x5Yc8qy8I1IfD0Kh6?=
 =?us-ascii?Q?HbhXQIdPSMpH/4PbKATrr4RC97x9fjAOzDzUmahjdjlP+HHrSsyv5M3EpX/V?=
 =?us-ascii?Q?CbR/X1GtJjpeo9EKdCtOv5gzi7IvoMNoxTe33TVcT1m0nt4820ZukR3zwm1d?=
 =?us-ascii?Q?DAR7vFneIVoiSsxcEeg/wBPOiOMqxihHrATb2vFIbywKACyZyAinfZ3D4Ny2?=
 =?us-ascii?Q?tc+9YFhzS5ycRRyUEDTsXgkBopBqlKwhJQhrzXwlAgXbn7AcUKSgSxMb2y9X?=
 =?us-ascii?Q?AnsC9K88q4qGIQKb6nTl/VxPg5Uum4fVMdgOtOfVCGWqKN9qtr0aTx/kHO6D?=
 =?us-ascii?Q?ambHlDGUBzo8qMWcs8cJ21GeNLF/q3GhM7HFwTqhtKwDiaB55xIjWVYopo5g?=
 =?us-ascii?Q?khrjmgyQi9ra7cp3ovxHnwSgXVUYfLKcv9gUWIUs4KJkNLP4HYXTuylKgTOK?=
 =?us-ascii?Q?LpZj569G7Mt3TSQplIJsyMFtuysJf+uTLUaqUxapStqJuqUnM4aeoOJFwdtQ?=
 =?us-ascii?Q?G3z9ZQ/OLSW+baxImT9zo1tMEug2e350i1JLUAcaj8SY15Ca59akQMEkSYyQ?=
 =?us-ascii?Q?Xr1RVha9/FJVAcfuvjTanBHfEBT5lLTnzwM/ipqJXirC4HNy0kVqLmJRuRBk?=
 =?us-ascii?Q?6NFxmw6mIAxv5ahcdGEs+qiYBKaZbsOs8vpEgU5G58Wpjy2i4yxSzQql35OH?=
 =?us-ascii?Q?3CDV2hiL1k2sBtu4m+/fLxvPQw8j+3ded9FImrl2bhpLeHbFDIsiSjLOLFHT?=
 =?us-ascii?Q?q/iie3UfSGjCbIE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oxDPtcmM/IFs8+XxnxeRlgX6AMJpTsvpxR/e35bseUJfRjNxhDH5K8VocBUP?=
 =?us-ascii?Q?1ZbHUZ4t3XWBPjs0Qvwd6hIEBmkyxNMIdeO0+NFTIOpabPgiy8aICybbqMBC?=
 =?us-ascii?Q?he9y78ayPFKCRg5XH1BThlXSxAbQ1KXYpvY44MT4uFapFUuATwEfXW5gN+3C?=
 =?us-ascii?Q?S4kudnOz3kNlvd7BPjs3H+rQJDQCX/r+/El1k6+ZZOOs6wpg2kW3txpusE6N?=
 =?us-ascii?Q?k3ZquzVYDGkmHEkzkL9Tsx52sWV3FcwfoyknsRZ7HLLiC7DAT59cIjcbZDc6?=
 =?us-ascii?Q?7+XlAH+XXPkAy8v+0rC3Sja5zdQ7nCkr9Y44z7dMrhO/1dAlypH3NDgF1m+8?=
 =?us-ascii?Q?2a7EhJ2/PYlLVA+IcdAKgxY+TSk7YFYaUjs20g9YJhbiGiD4/xP2wov8TCiN?=
 =?us-ascii?Q?PrTZ95U8zaH6PginbIehEwPe5ZL4cGJlek4sRAFvW7RPrLRNrAy7loH2adf+?=
 =?us-ascii?Q?y9OOTycfWI7ftry8GLsm4E7Fbppb63TMgavkVpTSG5rS/+569cjOPjJ6rWBD?=
 =?us-ascii?Q?YGDthqD6/6bHWFr2mm3GnKic9f0dRj+Dq7oSFv5+luP8DfHjEKJduO72utkE?=
 =?us-ascii?Q?AGz/HJ+xICDjp1yNLihcZocegLzmRWlsN8VjGYMZ3zyNyip0YOL6ETxH+PCY?=
 =?us-ascii?Q?OVLtblHdL/8OrCI5AJJVduWQSsJuqRYwxWteEgWe8AMuTXc6hah2FsBoYidd?=
 =?us-ascii?Q?r6ne18uExrJQzcs+p1ayRIHvuvCoprBlpBWG2kyeIpKw9QjIBQVU+OmLkUjn?=
 =?us-ascii?Q?9V6HjJ3Pu37XHbJ65/vjf1kgOLAUTth2k3E2BLYCEeWZzoyTmIH6r4NQ2GtJ?=
 =?us-ascii?Q?32Eis0WtrUJUvJXPndjbpQLUgTQ0dA5Ce3/Xg+Y6O10jNq7yglPsTf6dSTXT?=
 =?us-ascii?Q?BnhNlPigJNdTAXszHaDmFIY47KylTBhQKZZy4gGgtzSbpt/6VFO4mspaWt9C?=
 =?us-ascii?Q?5zJRerbE1zK79ToP1tmQ2i5kEBXqf7nCX3DwKtb8J8SjS93HKirzqhnUiP5I?=
 =?us-ascii?Q?SnbJiQtWPDdtr0wTdON8sjRywcuwNUSi9TSP7Fidm7d6iulJJPm1+ym/9mUy?=
 =?us-ascii?Q?q3uJxO3bCB966fxT5FtInT3Z2C+j8BxTB9AEYV9dCReVj50SlQWCyprsF38R?=
 =?us-ascii?Q?4o410g+UMTBPWFICU6xR3P3BX0iVLx+xxeJCjCQzFUnySbuQvNkHity+Zduw?=
 =?us-ascii?Q?qZ5GuAXYHEqDYVGhf8iMSxXp3R+SQ3MN622ThwAqX7iI1DpxhMyDSYJdhA5H?=
 =?us-ascii?Q?xJubNkEKY6sletIUunHSOFptiPO1W8qBZXiqY2Vg0KuH86P7Y5GPZNFa/ERP?=
 =?us-ascii?Q?+2S50RFhIRywy3Xsl7YakWHZLkBTWJyiPpPoZIlIOv2YlG9fn0VlA1p0Yohy?=
 =?us-ascii?Q?6jGHxubkZ1Jx1mcgjZ1+8JhzWSPqrDtA9ogEQ19Fxvt803ZzJ5kPrE4/JBDq?=
 =?us-ascii?Q?PYRFpA5xLqT1vHwyjvbPsH2+Qg/yytYlJuF3kEXwjigimYVlx+vsxbMNgwja?=
 =?us-ascii?Q?rQzVv+3CTlmjQO+uXlpfyAgqoOsWTZRQp1Z5opOq7MCSEz6HBOVFa6kKo+1R?=
 =?us-ascii?Q?KRmUEgpB+4+rGcvhh0DXJ+HJmpOBEm3RUcMh+je4xWg9iYCr2oNKrLyZN58F?=
 =?us-ascii?Q?ha7/DB6IvKZnJIqfjxUQd/I=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7cd8d3-aa40-415e-aa70-08ddc914cd3d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:42:14.0173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qn+u9PzAD+JyGRk6lU4nQ9qdlBa5fKpQJURN/jDVjRc30KehJyaYonRvA2gvSI/jZB0h1xtpwsVD4qke1HTckidAFHKXEGG0KM/eV4Ckqdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9908
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

The code was ported from linux-6.15

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/Makefile |   3 +-
 drivers/mtd/nand/spi/core.c   |  54 ++++-
 drivers/mtd/nand/spi/otp.c    | 369 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h   | 112 +++++++++++
 4 files changed, 528 insertions(+), 10 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/otp.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index d438747cf37..831760da1c9 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-spinand-objs := core.o alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
+spinand-objs := core.o otp.o
+spinand-objs += alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
 spinand-objs += micron.o paragon.o toshiba.o winbond.o xtx.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b3418624e3e..f16d3b0335f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -56,7 +56,7 @@ static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
 	return 0;
 }
 
-static int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val)
+int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val)
 {
 	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(reg,
 						      spinand->scratchbuf);
@@ -531,10 +531,22 @@ static int spinand_erase_op(struct spinand_device *spinand,
 	return spi_mem_exec_op(spinand->slave, &op);
 }
 
-static int spinand_wait(struct spinand_device *spinand,
-			unsigned long initial_delay_us,
-			unsigned long poll_delay_us,
-			u8 *s)
+/**
+ * spinand_wait() - Poll memory device status
+ * @spinand: the spinand device
+ * @initial_delay_us: delay in us before starting to poll
+ * @poll_delay_us: time to sleep between reads in us
+ * @s: the pointer to variable to store the value of REG_STATUS
+ *
+ * This function polls a status register (REG_STATUS) and returns when
+ * the STATUS_READY bit is 0 or when the timeout has expired.
+ *
+ * Return: 0 on success, a negative error code otherwise.
+ */
+int spinand_wait(struct spinand_device *spinand,
+		 unsigned long initial_delay_us,
+		 unsigned long poll_delay_us,
+		 u8 *s)
 {
 	unsigned long start, stop;
 	u8 status;
@@ -605,8 +617,16 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
 	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
 }
 
-static int spinand_read_page(struct spinand_device *spinand,
-			     const struct nand_page_io_req *req)
+/**
+ * spinand_read_page() - Read a page
+ * @spinand: the spinand device
+ * @req: the I/O request
+ *
+ * Return: 0 or a positive number of bitflips corrected on success.
+ * A negative error code otherwise.
+ */
+int spinand_read_page(struct spinand_device *spinand,
+		      const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 status;
@@ -636,8 +656,16 @@ static int spinand_read_page(struct spinand_device *spinand,
 	return spinand_ondie_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
 }
 
-static int spinand_write_page(struct spinand_device *spinand,
-			      const struct nand_page_io_req *req)
+/**
+ * spinand_write_page() - Write a page
+ * @spinand: the spinand device
+ * @req: the I/O request
+ *
+ * Return: 0 or a positive number of bitflips corrected on success.
+ * A negative error code otherwise.
+ */
+int spinand_write_page(struct spinand_device *spinand,
+		       const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 status;
@@ -1326,6 +1354,8 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
 		spinand->set_cont_read = table[i].set_cont_read;
+		spinand->fact_otp = &table[i].fact_otp;
+		spinand->user_otp = &table[i].user_otp;
 		spinand->read_retries = table[i].read_retries;
 		spinand->set_read_retry = table[i].set_read_retry;
 
@@ -1492,6 +1522,12 @@ static int spinand_init(struct spinand_device *spinand)
 	mtd->_block_isreserved = spinand_mtd_block_isreserved;
 	mtd->_erase = spinand_mtd_erase;
 
+	if (spinand_user_otp_size(spinand) || spinand_fact_otp_size(spinand)) {
+		ret = spinand_set_mtd_otp_ops(spinand);
+		if (ret)
+			goto err_cleanup_ecc_engine;
+	}
+
 	ret = mtd_ooblayout_count_freebytes(mtd);
 	if (ret < 0)
 		goto err_cleanup_ecc_engine;
diff --git a/drivers/mtd/nand/spi/otp.c b/drivers/mtd/nand/spi/otp.c
new file mode 100644
index 00000000000..e6ef78d9464
--- /dev/null
+++ b/drivers/mtd/nand/spi/otp.c
@@ -0,0 +1,369 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025, SaluteDevices. All Rights Reserved.
+ *
+ * Author: Martin Kurbanov <mmkurbanov@salutedevices.com>
+ */
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/spinand.h>
+#ifdef __UBOOT__
+#include <spi.h>
+#include <dm/device_compat.h>
+#endif
+
+/**
+ * spinand_otp_page_size() - Get SPI-NAND OTP page size
+ * @spinand: the spinand device
+ *
+ * Return: the OTP page size.
+ */
+size_t spinand_otp_page_size(struct spinand_device *spinand)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+
+	return nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
+}
+
+static size_t spinand_otp_size(struct spinand_device *spinand,
+			       const struct spinand_otp_layout *layout)
+{
+	return layout->npages * spinand_otp_page_size(spinand);
+}
+
+/**
+ * spinand_fact_otp_size() - Get SPI-NAND factory OTP area size
+ * @spinand: the spinand device
+ *
+ * Return: the OTP size.
+ */
+size_t spinand_fact_otp_size(struct spinand_device *spinand)
+{
+	return spinand_otp_size(spinand, &spinand->fact_otp->layout);
+}
+
+/**
+ * spinand_user_otp_size() - Get SPI-NAND user OTP area size
+ * @spinand: the spinand device
+ *
+ * Return: the OTP size.
+ */
+size_t spinand_user_otp_size(struct spinand_device *spinand)
+{
+	return spinand_otp_size(spinand, &spinand->user_otp->layout);
+}
+
+static int spinand_otp_check_bounds(struct spinand_device *spinand, loff_t ofs,
+				    size_t len,
+				    const struct spinand_otp_layout *layout)
+{
+	if (ofs < 0 || ofs + len > spinand_otp_size(spinand, layout))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int spinand_user_otp_check_bounds(struct spinand_device *spinand,
+					 loff_t ofs, size_t len)
+{
+	return spinand_otp_check_bounds(spinand, ofs, len,
+					&spinand->user_otp->layout);
+}
+
+static int spinand_otp_rw(struct spinand_device *spinand, loff_t ofs,
+			  size_t len, size_t *retlen, u8 *buf, bool is_write,
+			  const struct spinand_otp_layout *layout)
+{
+	struct nand_page_io_req req = {};
+	unsigned long long page;
+	size_t copied = 0;
+	size_t otp_pagesize = spinand_otp_page_size(spinand);
+	int ret;
+
+	if (!len)
+		return 0;
+
+	ret = spinand_otp_check_bounds(spinand, ofs, len, layout);
+	if (ret)
+		return ret;
+
+	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, CFG_OTP_ENABLE);
+	if (ret)
+		return ret;
+
+	page = ofs;
+	req.dataoffs = do_div(page, otp_pagesize);
+	req.pos.page = page + layout->start_page;
+	req.type = is_write ? NAND_PAGE_WRITE : NAND_PAGE_READ;
+	req.mode = MTD_OPS_RAW;
+	req.databuf.in = buf;
+
+	while (copied < len) {
+		req.datalen = min_t(unsigned int,
+				    otp_pagesize - req.dataoffs,
+				    len - copied);
+
+		if (is_write)
+			ret = spinand_write_page(spinand, &req);
+		else
+			ret = spinand_read_page(spinand, &req);
+
+		if (ret < 0)
+			break;
+
+		req.databuf.in += req.datalen;
+		req.pos.page++;
+		req.dataoffs = 0;
+		copied += req.datalen;
+	}
+
+	*retlen = copied;
+
+	if (spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0)) {
+		dev_warn(spinand->slave->dev,
+			 "Can not disable OTP mode\n");
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+/**
+ * spinand_fact_otp_read() - Read from OTP area
+ * @spinand: the spinand device
+ * @ofs: the offset to read
+ * @len: the number of data bytes to read
+ * @retlen: the pointer to variable to store the number of read bytes
+ * @buf: the buffer to store the read data
+ *
+ * Return: 0 on success, an error code otherwise.
+ */
+int spinand_fact_otp_read(struct spinand_device *spinand, loff_t ofs,
+			  size_t len, size_t *retlen, u8 *buf)
+{
+	return spinand_otp_rw(spinand, ofs, len, retlen, buf, false,
+			      &spinand->fact_otp->layout);
+}
+
+/**
+ * spinand_user_otp_read() - Read from OTP area
+ * @spinand: the spinand device
+ * @ofs: the offset to read
+ * @len: the number of data bytes to read
+ * @retlen: the pointer to variable to store the number of read bytes
+ * @buf: the buffer to store the read data
+ *
+ * Return: 0 on success, an error code otherwise.
+ */
+int spinand_user_otp_read(struct spinand_device *spinand, loff_t ofs,
+			  size_t len, size_t *retlen, u8 *buf)
+{
+	return spinand_otp_rw(spinand, ofs, len, retlen, buf, false,
+			      &spinand->user_otp->layout);
+}
+
+/**
+ * spinand_user_otp_write() - Write to OTP area
+ * @spinand:  the spinand device
+ * @ofs: the offset to write to
+ * @len: the number of bytes to write
+ * @retlen: the pointer to variable to store the number of written bytes
+ * @buf: the buffer with data to write
+ *
+ * Return: 0 on success, an error code otherwise.
+ */
+int spinand_user_otp_write(struct spinand_device *spinand, loff_t ofs,
+			   size_t len, size_t *retlen, const u8 *buf)
+{
+	return spinand_otp_rw(spinand, ofs, len, retlen, (u8 *)buf, true,
+			      &spinand->user_otp->layout);
+}
+
+static int spinand_mtd_otp_info(struct mtd_info *mtd, size_t len,
+				size_t *retlen, struct otp_info *buf,
+				bool is_fact)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	int ret;
+
+	*retlen = 0;
+
+	mutex_lock(&spinand->lock);
+
+	if (is_fact)
+		ret = spinand->fact_otp->ops->info(spinand, len, buf, retlen);
+	else
+		ret = spinand->user_otp->ops->info(spinand, len, buf, retlen);
+
+	mutex_unlock(&spinand->lock);
+
+	return ret;
+}
+
+static int spinand_mtd_fact_otp_info(struct mtd_info *mtd, size_t len,
+				     size_t *retlen, struct otp_info *buf)
+{
+	return spinand_mtd_otp_info(mtd, len, retlen, buf, true);
+}
+
+static int spinand_mtd_user_otp_info(struct mtd_info *mtd, size_t len,
+				     size_t *retlen, struct otp_info *buf)
+{
+	return spinand_mtd_otp_info(mtd, len, retlen, buf, false);
+}
+
+static int spinand_mtd_otp_read(struct mtd_info *mtd, loff_t ofs, size_t len,
+				size_t *retlen, u8 *buf, bool is_fact)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	int ret;
+
+	*retlen = 0;
+
+	if (!len)
+		return 0;
+
+	ret = spinand_otp_check_bounds(spinand, ofs, len,
+				       is_fact ? &spinand->fact_otp->layout :
+						 &spinand->user_otp->layout);
+	if (ret)
+		return ret;
+
+	mutex_lock(&spinand->lock);
+
+	if (is_fact)
+		ret = spinand->fact_otp->ops->read(spinand, ofs, len, retlen,
+						   buf);
+	else
+		ret = spinand->user_otp->ops->read(spinand, ofs, len, retlen,
+						   buf);
+
+	mutex_unlock(&spinand->lock);
+
+	return ret;
+}
+
+static int spinand_mtd_fact_otp_read(struct mtd_info *mtd, loff_t ofs,
+				     size_t len, size_t *retlen, u8 *buf)
+{
+	return spinand_mtd_otp_read(mtd, ofs, len, retlen, buf, true);
+}
+
+static int spinand_mtd_user_otp_read(struct mtd_info *mtd, loff_t ofs,
+				     size_t len, size_t *retlen, u8 *buf)
+{
+	return spinand_mtd_otp_read(mtd, ofs, len, retlen, buf, false);
+}
+
+static int spinand_mtd_user_otp_write(struct mtd_info *mtd, loff_t ofs,
+				      size_t len, size_t *retlen, u_char *buf)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	const struct spinand_user_otp_ops *ops = spinand->user_otp->ops;
+	int ret;
+
+	*retlen = 0;
+
+	if (!len)
+		return 0;
+
+	ret = spinand_user_otp_check_bounds(spinand, ofs, len);
+	if (ret)
+		return ret;
+
+	mutex_lock(&spinand->lock);
+	ret = ops->write(spinand, ofs, len, retlen, buf);
+	mutex_unlock(&spinand->lock);
+
+	return ret;
+}
+
+#ifndef __UBOOT__
+static int spinand_mtd_user_otp_erase(struct mtd_info *mtd, loff_t ofs,
+				      size_t len)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	const struct spinand_user_otp_ops *ops = spinand->user_otp->ops;
+	int ret;
+
+	if (!len)
+		return 0;
+
+	ret = spinand_user_otp_check_bounds(spinand, ofs, len);
+	if (ret)
+		return ret;
+
+	mutex_lock(&spinand->lock);
+	ret = ops->erase(spinand, ofs, len);
+	mutex_unlock(&spinand->lock);
+
+	return ret;
+}
+#endif
+
+static int spinand_mtd_user_otp_lock(struct mtd_info *mtd, loff_t ofs,
+				     size_t len)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	const struct spinand_user_otp_ops *ops = spinand->user_otp->ops;
+	int ret;
+
+	if (!len)
+		return 0;
+
+	ret = spinand_user_otp_check_bounds(spinand, ofs, len);
+	if (ret)
+		return ret;
+
+	mutex_lock(&spinand->lock);
+	ret = ops->lock(spinand, ofs, len);
+	mutex_unlock(&spinand->lock);
+
+	return ret;
+}
+
+/**
+ * spinand_set_mtd_otp_ops() - Setup OTP methods
+ * @spinand: the spinand device
+ *
+ * Setup OTP methods.
+ *
+ * Return: 0 on success, a negative error code otherwise.
+ */
+int spinand_set_mtd_otp_ops(struct spinand_device *spinand)
+{
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
+	const struct spinand_fact_otp_ops *fact_ops = spinand->fact_otp->ops;
+	const struct spinand_user_otp_ops *user_ops = spinand->user_otp->ops;
+
+	if (!user_ops && !fact_ops)
+		return -EINVAL;
+
+	if (user_ops) {
+		if (user_ops->info)
+			mtd->_get_user_prot_info = spinand_mtd_user_otp_info;
+
+		if (user_ops->read)
+			mtd->_read_user_prot_reg = spinand_mtd_user_otp_read;
+
+		if (user_ops->write)
+			mtd->_write_user_prot_reg = spinand_mtd_user_otp_write;
+
+		if (user_ops->lock)
+			mtd->_lock_user_prot_reg = spinand_mtd_user_otp_lock;
+#ifndef __UBOOT__
+		if (user_ops->erase)
+			mtd->_erase_user_prot_reg = spinand_mtd_user_otp_erase;
+#endif
+	}
+
+	if (fact_ops) {
+		if (fact_ops->info)
+			mtd->_get_fact_prot_info = spinand_mtd_fact_otp_info;
+
+		if (fact_ops->read)
+			mtd->_read_fact_prot_reg = spinand_mtd_fact_otp_read;
+	}
+
+	return 0;
+}
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 44c616a4acf..adfb5f3ffbc 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -322,6 +322,68 @@ struct spinand_ecc_info {
 #define SPINAND_HAS_READ_PLANE_SELECT_BIT	BIT(3)
 #define SPINAND_NO_RAW_ACCESS			BIT(4)
 
+/**
+ * struct spinand_otp_layout - structure to describe the SPI NAND OTP area
+ * @npages: number of pages in the OTP
+ * @start_page: start page of the user/factory OTP area.
+ */
+struct spinand_otp_layout {
+	unsigned int npages;
+	unsigned int start_page;
+};
+
+/**
+ * struct spinand_fact_otp_ops - SPI NAND OTP methods for factory area
+ * @info: get the OTP area information
+ * @read: read from the SPI NAND OTP area
+ */
+struct spinand_fact_otp_ops {
+	int (*info)(struct spinand_device *spinand, size_t len,
+		    struct otp_info *buf, size_t *retlen);
+	int (*read)(struct spinand_device *spinand, loff_t from, size_t len,
+		    size_t *retlen, u8 *buf);
+};
+
+/**
+ * struct spinand_user_otp_ops - SPI NAND OTP methods for user area
+ * @info: get the OTP area information
+ * @lock: lock an OTP region
+ * @erase: erase an OTP region
+ * @read: read from the SPI NAND OTP area
+ * @write: write to the SPI NAND OTP area
+ */
+struct spinand_user_otp_ops {
+	int (*info)(struct spinand_device *spinand, size_t len,
+		    struct otp_info *buf, size_t *retlen);
+	int (*lock)(struct spinand_device *spinand, loff_t from, size_t len);
+	int (*erase)(struct spinand_device *spinand, loff_t from, size_t len);
+	int (*read)(struct spinand_device *spinand, loff_t from, size_t len,
+		    size_t *retlen, u8 *buf);
+	int (*write)(struct spinand_device *spinand, loff_t from, size_t len,
+		     size_t *retlen, const u8 *buf);
+};
+
+/**
+ * struct spinand_fact_otp - SPI NAND OTP grouping structure for factory area
+ * @layout: OTP region layout
+ * @ops: OTP access ops
+ */
+struct spinand_fact_otp {
+	const struct spinand_otp_layout layout;
+	const struct spinand_fact_otp_ops *ops;
+};
+
+/**
+ * struct spinand_user_otp - SPI NAND OTP grouping structure for user area
+ * @layout: OTP region layout
+ * @ops: OTP access ops
+ */
+struct spinand_user_otp {
+	const struct spinand_otp_layout layout;
+	const struct spinand_user_otp_ops *ops;
+};
+
+
 /**
  * struct spinand_info - Structure used to describe SPI NAND chips
  * @model: model name
@@ -337,6 +399,8 @@ struct spinand_ecc_info {
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
  * @set_cont_read: enable/disable continuous cached reads
+ * @fact_otp: SPI NAND factory OTP info.
+ * @user_otp: SPI NAND user OTP info.
  * @read_retries: the number of read retry modes supported
  * @set_read_retry: enable/disable read retry for data recovery
  *
@@ -359,6 +423,8 @@ struct spinand_info {
 			     unsigned int target);
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
+	struct spinand_fact_otp fact_otp;
+	struct spinand_user_otp user_otp;
 	unsigned int read_retries;
 	int (*set_read_retry)(struct spinand_device *spinand,
 			     unsigned int read_retry);
@@ -390,6 +456,24 @@ struct spinand_info {
 #define SPINAND_CONT_READ(__set_cont_read)				\
 	.set_cont_read = __set_cont_read,
 
+#define SPINAND_FACT_OTP_INFO(__npages, __start_page, __ops)		\
+	.fact_otp = {							\
+		.layout = {						\
+			.npages = __npages,				\
+			.start_page = __start_page,			\
+		},							\
+		.ops = __ops,						\
+	}
+
+#define SPINAND_USER_OTP_INFO(__npages, __start_page, __ops)		\
+	.user_otp = {							\
+		.layout = {						\
+			.npages = __npages,				\
+			.start_page = __start_page,			\
+		},							\
+		.ops = __ops,						\
+	}
+
 #define SPINAND_READ_RETRY(__read_retries, __set_read_retry)		\
 	.read_retries = __read_retries,					\
 	.set_read_retry = __set_read_retry
@@ -444,6 +528,8 @@ struct spinand_dirmap {
  *		actually relevant to enable this feature.
  * @set_cont_read: Enable/disable the continuous read feature
  * @priv: manufacturer private data
+ * @fact_otp: SPI NAND factory OTP info.
+ * @user_otp: SPI NAND user OTP info.
  * @read_retries: the number of read retry modes supported
  * @set_read_retry: Enable/disable the read retry feature
  * @last_wait_status: status of the last wait operation that will be used in case
@@ -487,6 +573,9 @@ struct spinand_device {
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
 
+	const struct spinand_fact_otp *fact_otp;
+	const struct spinand_user_otp *user_otp;
+
 	unsigned int read_retries;
 	int (*set_read_retry)(struct spinand_device *spinand,
 			     unsigned int retry_mode);
@@ -571,6 +660,29 @@ int spinand_match_and_init(struct spinand_device *spinand,
 			   enum spinand_readid_method rdid_method);
 
 int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
+int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val);
 int spinand_select_target(struct spinand_device *spinand, unsigned int target);
 
+int spinand_wait(struct spinand_device *spinand, unsigned long initial_delay_us,
+		 unsigned long poll_delay_us, u8 *s);
+
+int spinand_read_page(struct spinand_device *spinand,
+		      const struct nand_page_io_req *req);
+
+int spinand_write_page(struct spinand_device *spinand,
+		       const struct nand_page_io_req *req);
+
+size_t spinand_otp_page_size(struct spinand_device *spinand);
+size_t spinand_fact_otp_size(struct spinand_device *spinand);
+size_t spinand_user_otp_size(struct spinand_device *spinand);
+
+int spinand_fact_otp_read(struct spinand_device *spinand, loff_t ofs,
+			  size_t len, size_t *retlen, u8 *buf);
+int spinand_user_otp_read(struct spinand_device *spinand, loff_t ofs,
+			  size_t len, size_t *retlen, u8 *buf);
+int spinand_user_otp_write(struct spinand_device *spinand, loff_t ofs,
+			   size_t len, size_t *retlen, const u8 *buf);
+
+int spinand_set_mtd_otp_ops(struct spinand_device *spinand);
+
 #endif /* __LINUX_MTD_SPINAND_H */
-- 
2.47.2

