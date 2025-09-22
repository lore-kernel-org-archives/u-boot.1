Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287F7CAC5A7
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 11:12:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DE6183280;
	Mon, 22 Sep 2025 13:12:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="A454LzdF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A10B833E9; Mon, 22 Sep 2025 13:12:21 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD70F83211
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 13:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oidGRt30+Wc27bVGB+/1hUP1fEggkpQ9sDgqF2hPJ2NB4nq7qhdVh+G/Y8u9XO4GRU1MCL/FIOVfYpFEeQHBOyyuDs18UNSyDOndAlodRtoHls/vVSVc3c00snvR3njkzSezYw0xTA7boR9pM7FCWhVRanVjbqaiVZ0NRdAnydTc+2P8rb2MuCWVJETjGnUUiQD7UBQ+kl7gEkWirMpyFavoYhaQzPg7eYDI86dVaRbuAZQhZ/ZzS/Fvb547ij6G1joQBC6BZBpopP4EYj4ee1cRhIU2KYrxktG5XeYD6dw2aBdT8KzcvhO+LrEu9z8FunqN5xHsfCueX9UKmLbzRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75Ld6rlsaxmPwpiKvaEWqm37dynkzLT6baJMWym1LSY=;
 b=WJV8K44JEmESgsFY/2uUj4wsxVNgxqqL4pzxnzrymz8RirfIh/YSiiW+rxx+vpnC/Mxbi5hC+SZzqp0NFaTiJYaDZExoqj4g9Rrpg3a6CLeGWCxymCSkOs7Yct5BaJ9x5y+WgZimKxHVYBNLD1W9d5Rxuc5qaj/LOEky6mH8DJUvinlRJmFe/NMRrzFJOKd2FDNXxW5eP1S9dtLFQFNelRcrN9sUmW0NsBdUYDfzyMDU1VsbcEJAF58+0LJUevHgb2LUAJFD7S9UXyZZB2G3f79B7kGj2zLaDFpJxxWXVdgdkO9kSkqN7HnELkQexzJ+GmBUpq7Eo+Xsg4W4IlOyYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75Ld6rlsaxmPwpiKvaEWqm37dynkzLT6baJMWym1LSY=;
 b=A454LzdFHBapj5y+jaJXXwZtdJ1gcv+lJlU0G65RAGxcZor084fagEpOtQsSzuGXD2FVjNK29JMB/2vdDwi29N6eC3udqBY52Ls1rfIhrCgMVSr0/6pQvVwcQfRMS9ER/or5/KuZ8BwH1TgQXrPZO3m3JIW+1wN1kOz4rpvwfjHSHrROYuK+k620GRvAVKuy2owdSteLIFFSA9ieN1Sn3WzPrXu95tpjkPFyCfTJq+g0oSMvzTyx/LPnBCqA23CMfxyj75yqDXoqnDBX+VARP7U3RBAoRvD1mt8WCBPlwHDmD5hHtK8Ri4HiRhl9EWG6j5IcG8QiIieN19JwjC+asw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by VI0PR04MB10735.eurprd04.prod.outlook.com (2603:10a6:800:269::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 11:12:16 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 11:12:16 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de,
	jagan@amarulasolutions.com,
	festevam@gmail.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com
Subject: [PATCH 1/4] spi: nxp_fspi: Use second last LUT entry for AHB read
Date: Mon, 22 Sep 2025 19:11:40 +0800
Message-Id: <20250922111143.1204915-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|VI0PR04MB10735:EE_
X-MS-Office365-Filtering-Correlation-Id: 55949441-fb50-4efc-3a0b-08ddf9c8e34b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|42112799006|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZvAMnRzC1YhUE64tUe/r6yzE7nTBJGyRrNBlf6FPe3/SbOpdhor5jql5ebew?=
 =?us-ascii?Q?p8qHs85EOwKxYomwRC4zs6y9ZW1l2iX8q187ZOcShAt/TpOjldjf82Kfi0vT?=
 =?us-ascii?Q?rAjLcM5COWjCnlCPAycJBzoevSDOwlHv5DOREnehVRwhDMP7yPL/KaAoWMla?=
 =?us-ascii?Q?8Xo/7HfOV3kMwFQUzxobNgpbDq9Ckbg6Ms6Z7CRvmtWPhlVQMJrQPb5TelPm?=
 =?us-ascii?Q?Lf/6Ga82YM993cJ5+W6Pa30beHh7WC/LnwRczlGHYMPu6GDb5PX6lmEgER4r?=
 =?us-ascii?Q?sU0Hmll3GkaqhPGtk4eYav2Jw77jmGxYNpK6C9ZiXRQWduo+gL1orMpgRZMB?=
 =?us-ascii?Q?EhROMEZgDpyfl1PNPnbByxtIf24W8EUNVNBqBY40kGB79S0VsdmoXDiRjpvD?=
 =?us-ascii?Q?kb4UkQQYF3yuOBoO7nn7iPf7wAZgO6QqchkPWh8kuGg8vl4bek1MOWXyAQ8h?=
 =?us-ascii?Q?0lzcvUfx8UZFPbDsfpAFYaGmtz1+H/YbVBT5WAE7HJdRWuXtroDipjk3uLEr?=
 =?us-ascii?Q?8sTalTEfmWMF/CooB6VXWA2Q/SJS8D8qs0Es+mHMhUUghp8H5H8LD4NSeBkU?=
 =?us-ascii?Q?oQLhZSdiGH+WeXeippu+OoR2O0T/ivEl2Hsa/XCWQlutAQr5SRLRRJcZIR7Q?=
 =?us-ascii?Q?A7D+pUPBRMZYWhR3DcLz6bTkfjDoWuSWtCcfNAMWUfWfqzWsDd/b2MUyuwtk?=
 =?us-ascii?Q?J+PzEJriAqSv+cC0ps/6NfvtZLz0fydsDFSqxTsUTfSW+82v9XHhYgCrklPM?=
 =?us-ascii?Q?R8NNt66H1RqpmTnnepSTr6pqJfzDbeEf+20C0KSIClNY4ggLd6QZbKVZcyxS?=
 =?us-ascii?Q?V1dIHBs/bv/yakY/d8CXFPz6B8tFNkjxqkDYiJbnaU+T0FeyElVonv2kdWnA?=
 =?us-ascii?Q?ksBVg9zHcysd6AUms2wcu96D7ceWsmmL86doM6h6dW6SFV883wkq0yOs8Q4c?=
 =?us-ascii?Q?fwEq4CcA/pMktDP17rJMdik6IrBFJR94M7FgoFGFzQ05b/ksMiqXp7eul4U5?=
 =?us-ascii?Q?NMC6kiYOJZyV5iebkVmhs1yrx/6v1CyZcgDs6m3IuWJ7qwU4QXGRirE/snVz?=
 =?us-ascii?Q?YomCsapyKO/AFRVemdnHuYyanV+mMw+/tUhCzSNerKeL8UE40tNdDnzcFh2h?=
 =?us-ascii?Q?QtVdco37+HqyCKLQkcTmNVGO14Zh6UWaUjvyLrIFYduLCTVylX+rEIFnwa8o?=
 =?us-ascii?Q?e6GtkHGQiOCHcy/zqB8dWvcAeopkovKtM4WfzfDRaD3ww9uK49C/7I2y8LWj?=
 =?us-ascii?Q?HqrV+y4piZa8OXJRoC2WiwVLyiX3eNnq/M2wcduJU7bEKBWbjbNoq4IE4JMM?=
 =?us-ascii?Q?PR5yTnDYv7CAE00Hd4M+M/3RiAM7u9xf4Ukpaq5+ghQx7IryWpYSviPVGkaL?=
 =?us-ascii?Q?sR2WXDwA/lvstVQtBmaW1Yb0Um9oLk3I3aVX439oGoLVLjoLD26C08MvK4v8?=
 =?us-ascii?Q?Cw0ZkIE3LJDmLYgMxNOkufObZUa6cabRNF0b2CXWTkicDxYDVShQVw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(42112799006)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?92STYM2DDuUmBETNbhCkT3hGQ/0rDM2j6+9nhmXdaL05IAyMCJ7oUr4m+/dN?=
 =?us-ascii?Q?vLFlnURKM1+JnQVGgLHCyuwxdV0zYHj0tyZ24WBXQRLeEwdsn6leq/0JNGfX?=
 =?us-ascii?Q?9c9BfFV4bQBBBDnyxW8Wn4I/9Po9q2+2noWGGl9J/M1gFTNSekH3GXriecEl?=
 =?us-ascii?Q?LTUK9cb2J+3LAhtLqXgYFp8Ud/Z1GBpC9QbdqlIyfxHqL+ClBXdnzNFfrb58?=
 =?us-ascii?Q?ot/5DecfwFjH4Zc5V2N+1YVSmb/3T97dRozuC8D1iiVe9dL618WTTWumEuPc?=
 =?us-ascii?Q?NRLsA6tWk0u7z/r0pg/QfF7HBIJRfJYFuulHP67fswaDNbR17bB4mV29HejX?=
 =?us-ascii?Q?KTuMpjAFM+1QsJ4GnlKWrMFi78PZe1wAchK02N3GPzbcuJ9/i0nedPaonACy?=
 =?us-ascii?Q?EHCkYnavfCa4eGnknOS0Edc/wOHB8xgxaOq6lPzv6U3ef2eW/Aeow/3VbS+e?=
 =?us-ascii?Q?3k16lWOOlzczd3S+h2L4RczV3OG0xUnmAM+OEXWDps4nNJP4VObcDwfQQzD5?=
 =?us-ascii?Q?OZdpKsA6CxNSe812/o3pFqK8n6jZKXFo9MhwKxUjBU5yVXY7V0sEdEtLoLBw?=
 =?us-ascii?Q?UD487JADYvGqJlCQ/Su3igpYTd5wm99MBgGieNFOSThK8dnU4/x6f1HSaQ1u?=
 =?us-ascii?Q?0iPgCjNR2Q60ZOI47oGIcJ4zL5SgZUnyG/FOc3tzOuAUCEWiCJz0O64UCSl4?=
 =?us-ascii?Q?T1X2H+xIGM9JV2UWVpv7K7y7WIGvGGm3QV0ObAG0r4JvUNco6PViAGTRgEvq?=
 =?us-ascii?Q?1EsI5HpN53EcgSwNXM8B3R7LTR0y7xzGo9CJR2+Qxh2oc0Yw3fiXPj0n29gG?=
 =?us-ascii?Q?ApoTY1GBXTa47CFd8t3e0amLgYgyRBSNFJqLNQ9ac8J9d8Ctvh/lr4aP06zu?=
 =?us-ascii?Q?9ct+1ekfOz8Gr0c2dh1Uqe7HWKOkFD36akLdu8AQntpyxZ5YXfgt4tmLkz7R?=
 =?us-ascii?Q?jfxyXkIXOpJKmSZpNGAWGRbx+RdpwEkEEhR/RYL8HaQytYzZlY6m5zF+PAfs?=
 =?us-ascii?Q?TX5TPlxjzirXvZNMtVDM6hkeY5Ht6ejdEqxfVoh6S+FGw0bbFBMppBWTqUUQ?=
 =?us-ascii?Q?fQUNDtVfg3xzEJB8uXC54IfgVKTWO9CjbIts3dNWH8Q96thSwMvS2xL5T3Bm?=
 =?us-ascii?Q?jKko/knTRP7Kut5rhDj0bI3OGviRD3C69D8rFNpwo8Kny3Py0Mjqe3wHJQb8?=
 =?us-ascii?Q?7Kr9QpSwFvbWB+utJNF9yUNsQuG8wJtnUduU2bXBJ8CY+7c75OCzx/cmdL64?=
 =?us-ascii?Q?K5C09ZLBaUZpq/JtzpCe7Cy/m2UmgHEZoPfshQXX54CFrccTBuvbD8Dz8uMd?=
 =?us-ascii?Q?qQNe5IMVRCPvtxIeaa0YIefhU8/j3ZzXukjDEgBZZwT4/C25+ygOo1KS4eFF?=
 =?us-ascii?Q?tQUpnmisI+rQOcOnqWOVHg09vd+M4+cBXjxppFugvmkTxRP3P83wYo47UbOq?=
 =?us-ascii?Q?YBA8agQXPMP/IDuyKBEFgXsBesz3/ZkerbkT6lcx+tNgt8PdVii3637reQ57?=
 =?us-ascii?Q?4F6XLvLQJtx5yPB6z5Moe6wQu2O55hBnY9jgfxZXv/h9Ws92cwyBmapWgqGk?=
 =?us-ascii?Q?Cjnz53JV6KfCHEZkdmI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55949441-fb50-4efc-3a0b-08ddf9c8e34b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 11:12:16.2338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BaovV8hPOk8u8MseV0jdepKPv2rYL+3Z08j+N7tnGlzJcKHrzppM0/sSRZ+rN4ec
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10735
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

Use a dedicated LUT (second last) for AHB read command, so we can
directly read from the AHB memory-mapped address and booting M core
for XIP on Flexspi NOR.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/spi/nxp_fspi.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/nxp_fspi.c b/drivers/spi/nxp_fspi.c
index 6d97b8eefc95..2dac4da44185 100644
--- a/drivers/spi/nxp_fspi.c
+++ b/drivers/spi/nxp_fspi.c
@@ -539,6 +539,15 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
 		fspi_writel(f, lutval[i], base + target_lut_reg);
 	}
 
+	if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_IN &&
+		op->addr.nbytes) {
+		lut_offset = (f->devtype_data->lut_num - 2) * 4 * 4;
+		for (i = 0; i < ARRAY_SIZE(lutval); i++) {
+			target_lut_reg = FSPI_LUT_BASE + lut_offset + i * 4;
+			fspi_writel(f, lutval[i], base + target_lut_reg);
+		}
+	}
+
 	dev_dbg(f->dev, "CMD[%x] lutval[0:%x \t 1:%x \t 2:%x \t 3:%x], size: 0x%08x\n",
 		op->cmd.opcode, lutval[0], lutval[1], lutval[2], lutval[3], op->data.nbytes);
 
@@ -943,9 +952,10 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 	/*
 	 * The driver only uses one single LUT entry, that is updated on
 	 * each call of exec_op(). Index 0 is preset at boot with a basic
-	 * read operation, so let's use the last entry.
+	 * read operation, last entry is used for dynamic lut, the second
+	 * last entry is used for AHB read.
 	 */
-	seqid_lut = f->devtype_data->lut_num - 1;
+	seqid_lut = f->devtype_data->lut_num - 2;
 	/* AHB Read - Set lut sequence ID for all CS. */
 	fspi_writel(f, seqid_lut, base + FSPI_FLSHA1CR2);
 	fspi_writel(f, seqid_lut, base + FSPI_FLSHA2CR2);
-- 
2.7.4

