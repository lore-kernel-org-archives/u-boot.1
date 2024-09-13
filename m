Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BF1FC6185
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 01:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91EFE88BBF;
	Sat, 14 Sep 2024 03:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="M0gX51n3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C47388D95; Fri, 13 Sep 2024 16:56:48 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B5088852A
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 16:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zE+SFVP+G9ZFCli4e6MqXrI9TBMRSBabbxslZ6QlRXk16918/eRRp6OXppaX7K80sKT1bT9WOyXbdu9g36FGZZ4YtBT4V/ScEyEwwrIp2xTmmAgKiP9hdJIu1WkDmj4Tn9cSBiUEJKcDotdB5Y2q5Wb53udJCquRbUq8F0vQEgG53+kAqxq7l4ypCR9KcVAjZP0T5kTihDS1LZP38wn/uH8hcJbwNswH/UMnlCMM5vZTUlkdsxWthxRNXYVPmu7FQK0pPllPoLLNeY6E4vzneS0VfqE7KddRp4P1TIQegpHe6+H60KxVA23IN4AOi6tlOhA9YbZk/ub4a56xl0eeQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZvgIPhQayCeZb5A2hJHuxFt/O03efszE7MXaI7ySK8=;
 b=RkIZ3Rd/lKR17xDMREgOE08R3MN2cZ70fWOY4Daum8CnF6QoX+ldx9kFC1cH9R1Ect75zCz2e7Hf0TPVpA0o1hK2M7qE+kG6FGY5aPGJ8sFrh2okB19EC7lMn2Zqv/DIlY7IyyU/7TxQ2SHEHrs+UJS7Lpx8NnIJdOXDdh4VohZAVQJU9MQRttPq0buXQxydFx/nnG3ScFfEJtlDvOzEpl6z9GNUJAF2ZWTNLsSrSkYjWmCHh89uCDb+T47zgAFjLYwKpCaw2cPmSOxS8W5Z7b8XSfs69RoaAMQI5GKbB2zo59gRijtvysOIGcp59Lzjdn8fSsFwNDx6NNYFV3FAZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZvgIPhQayCeZb5A2hJHuxFt/O03efszE7MXaI7ySK8=;
 b=M0gX51n3n5St7ZyLDQOICFeotguQozXjcoKdukKWm7rGWe6+gNOkfxeaT5LLW0ihR2qgd3Q4TpuqaQxy9WiraKce/G9mF8nInsylBkrvrhJb+uJ+W/OrAp27Gb5jvXTtvzDgRAOer89Zit+AXCpp71gPFIVJ1rzZ6DkkwYGuJ+rsndWJSnNo857lyfk+QypIjGxo16hj0zSOR0j1MBNFW2tM7kQmdqEcuP/8B/5inZs/UdpCA6Di42tIS9VRBQZGnmGAmiotVMD1X8tBlTkqRzrrSwtf5N+rVxYD59GfC2miHDoRNrmWSWV33SEION3EATfwMgQWhRLNMnN86NQdIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AM9PR04MB7522.eurprd04.prod.outlook.com (2603:10a6:20b:282::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 14:56:40 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 14:56:40 +0000
From: Ye Li <ye.li@nxp.com>
To: jagan@amarulasolutions.com,
	u-boot@lists.denx.de,
	marex@denx.de
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH v3] mtd: spi-nor: Fix chip erase timeout issue
Date: Fri, 13 Sep 2024 22:56:23 +0800
Message-Id: <1726239383-12808-1-git-send-email-ye.li@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0122.apcprd03.prod.outlook.com
 (2603:1096:4:91::26) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AM9PR04MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: a791e12e-097e-4a34-f5d9-08dcd404463f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vTO9hfWmb4/8RfOgZzUV+CzkX4qse0xNL85YL6PBrwZ8U8Cg5i3C/FfdNK6d?=
 =?us-ascii?Q?IqAdJz65NQsiLOU5oL3eBQc9ppl470g5ewJWQWc/IhaNJwUnzxDqM0va5aAd?=
 =?us-ascii?Q?Ye9sG7MtJNLHsb7xC+avUqv6xJL3YTqLjcw26Xx4PNboT7RJac0QFKX3eW38?=
 =?us-ascii?Q?5vfqMxmkdbqGEtdUWW27iwXHktUyhdYgzuAcSIY1Rl+OmqTDDqgCb1nHHfoT?=
 =?us-ascii?Q?YJFrWSGG/ZCOgjRbXRvS4a7NvUILa5tDk5NSooLsIhCbypT4uP5eqy6Z78us?=
 =?us-ascii?Q?d2iGK4vkLregWoTeZbIVBUPpxyZAzTtcWe+bEjJhmlQy3100UeXAcKgKCzLV?=
 =?us-ascii?Q?//MDG+IjaM5shH42Wo5+jlrl5/aE5UbFmLtG8+l0bllsXQ/NEMHmQFOa7rXd?=
 =?us-ascii?Q?x0XcW9EmVfnwiyVNDPKD0Yzl9XafptKXy0bIFW6t7ELPKPsEHeOKcWOpbGvg?=
 =?us-ascii?Q?RZSIBiDdV0xHkR7fkf58b4n27bqU8zvknkVoIOAVSBwZ9aWpID+zrCdA1mxn?=
 =?us-ascii?Q?ccXJDOUe1TLhwu2nVfW7G7bKxphGFPiIvMjio2YI3iCbrqhYawJDBTEQXIgX?=
 =?us-ascii?Q?slPZt8LtZlKPqET9ZAbs21PEd54GXhUBynn465YOvV7QqISpocyVMFN9XRaL?=
 =?us-ascii?Q?ead7rhnnnTxAke9S7UtfPY6aO2x8ljSH9AQOQAB2QwPwxTNMINLTWiM8/7bi?=
 =?us-ascii?Q?O6T3I2YrpGwZOFREQ1nBR1pNTrUGYd8t9aZCUXLlAAgXolxkCGJPVQ6gnUh2?=
 =?us-ascii?Q?UcDG/TksoA4yO8Pj2fjiX5LqiJ3G8w5ekL/GEj8SH2nJblGgwHWdFaeC973j?=
 =?us-ascii?Q?JuxOOQ4Px0kmlHmVzCi9petYDVNZmgB0dmQCZ2wgXcrHP1dld9MyKsqazvOC?=
 =?us-ascii?Q?WDNBctH+PDuw7Y6py4S2kVOydgMn7NxTM7e+Hly8AoYu0OV7ttlR+yOyj2tG?=
 =?us-ascii?Q?hJva86qvM1NREXsDao+5M89OGWje8ceg/unUKqs9m/K3lVyzkImB1FYsBWz4?=
 =?us-ascii?Q?iKIjz+FtXnU2E5Az7dghlmw9fCqbm3Glf69HHAQaVhsOO01IO9Lboah65a0q?=
 =?us-ascii?Q?01FygujeuBjV2tEAj8xtL3LEIzwkzQX/6lPdhzyI13X/3LAaXiWSJtp2Kl+F?=
 =?us-ascii?Q?U/wQWTxhulK+55mBj7J076KpmBAybprqHbDntvU+vgz1S2QGOM4NyvT1EzTz?=
 =?us-ascii?Q?SYPuMFybLuAU3YhcNopswA1ZcqKSDxA8xObsTM0Zc9U5MSdydB48YPJ8IfWv?=
 =?us-ascii?Q?r5pCFMWdQ0YBr4njNTqPHSlmSfEpUA0YUaQULlWVUZ1Jr1VSb60Xs4TCvxob?=
 =?us-ascii?Q?9GEPxKP2/oZkHPrtpR3QU+XSoOTVqhxJ9wC+I7K8l7JMSeu7TJr83BRPfvhu?=
 =?us-ascii?Q?IErLwJjEOlYni4pODIrxtDqS9Ack7azsNe91QLI+QvxL8t/biA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bKEGd46skBLf6o+b38ADUQ/WElzMuTUN71iIhbXk2bU0BANkY6i36FqF0Qpv?=
 =?us-ascii?Q?16gdJTWHOGMX05fIRiRpNQ7gfT3TcRS4mZcvJ5x+TRH7e2u4Umyp5J0q/Sjq?=
 =?us-ascii?Q?hgrxus92bkZ2BIN5/Cg5VQdmbho9F6rb+RpRstwFvgU3Q8LC6QUOQZpTI/6k?=
 =?us-ascii?Q?TvHngFpScP0zbItRDBgR5n+kT5mX+g9TcldBLhBD5jNN5VM9pPH/b6weE/Wl?=
 =?us-ascii?Q?91J1LoVOt3tkaWD0RDZH0mpFKyJmRpuRKk3ZX/XJTvuANHTyCHsNxgUCkaJ/?=
 =?us-ascii?Q?7OocpVLyrI6C7Kjx/HS0H7cIC1G+E9G4xqoDrWUcNRhsiwH4pN9falzyiG1a?=
 =?us-ascii?Q?jc1+RbZ9DlrFd4VSnVwKCNoKvisQ9V2nS4rKdHqNKjI4QeolItUqRj+ZIZ6h?=
 =?us-ascii?Q?VaxDW6aZ+7gvRDcet0B8Xptqd4W/SV9KPHjGdtecEIsC9qcfQVEiYFvEn3e6?=
 =?us-ascii?Q?nfo8+EnT1zCbd5qDHnejVWFcjo7YDiscUZkXxX67J5ygr/jnDf1fv7k0GUnI?=
 =?us-ascii?Q?O7kZ94CzPaTQ1jvriWI2UImMekgSbginuEgXFIFHTFsbeoRZO0haepAwaqJn?=
 =?us-ascii?Q?eCSH7K4bWXqF9IJG/jifxleeTvl4zBFNeWtwane1TYvwjuV/rErVieuoWf6P?=
 =?us-ascii?Q?IP6OygOzp6Urwy7XmOqVzNdwZm0IQd3HJs1hxuNBw4sPI2/D1Asr3/LSLddK?=
 =?us-ascii?Q?GsMALiAVnW3a8GBEpkVutaSmUiTS3RqFFzb1xoRaGjQzr3xKyWf1kjcUCHpB?=
 =?us-ascii?Q?uHpMEv7Nvn8Jjzv2+1ww3SISj5x8FTKeQg073TcnwUhdpYn/gAwRV6W+lg2B?=
 =?us-ascii?Q?73eRKc38qk7hHWRa7FQpRn8xU+3Q2SXnJvKGz3emV4Rq+BAo7MXE7bFAlrMQ?=
 =?us-ascii?Q?lP3/XVZpgQy9dyzjOIR+TCUcO3TWRJT+NTwkkaQ4VcP3a0ElByArwqLxNlRQ?=
 =?us-ascii?Q?AY9W6uv+50iq1sGjLagXQ4sIJzsSrnM5IqwZ1MrvsjFD4722h4rxDpoQ8GUK?=
 =?us-ascii?Q?5cmra22ufU3yn/yTihxdYOHQEcXOzhVdl//XQx6VNVyvtBmx/d+l7sK5SBoD?=
 =?us-ascii?Q?jFhBChQ0tk09dQPC5zY4jeHU0rs4lrPTn3lBU3/iJBD5DMebblHOu6oqYRaP?=
 =?us-ascii?Q?Wt/MHqcFOtwp1nc3FPZSQuLlLhiDLt84UrmcccDbJ+wTI/hQrx6NwgOXITli?=
 =?us-ascii?Q?vQ0a6zbFywFC2ASrcIxytyN0X9TwXtcd0+XE9rDipXQqn2ABkZ7mHI24HQ/V?=
 =?us-ascii?Q?OfW4PfGRbXWmULv8Y1jYl0nb27pTxYfsQqa0JUN6g95fm0qjDIES0U/CbZ0u?=
 =?us-ascii?Q?yOsE/N0zqwpXyGNVe7NpALcvx2i1tUOgEaOKz87ybKC7/1MN6arihHK1oBfk?=
 =?us-ascii?Q?gk5I02D/Y+jB2SmwYFjT7qbSaCex+2Tic8Z++W1mlI58W0R8EwQoOMX9N4jN?=
 =?us-ascii?Q?jAo6ZXEVrgM0Dmz+X6gi4naTf4QKmtc9zoJz3G3cSHYIl+1/ywn65l4rqXpY?=
 =?us-ascii?Q?NzWXwzvK2TO4683KN0TSFFUR+OL3tjW9BZbtB/3xllE6/Mu8Tj8sVBS0joGi?=
 =?us-ascii?Q?UQyx8U/ElktxL07EzOg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a791e12e-097e-4a34-f5d9-08dcd404463f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 14:56:40.5701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boUbJcVURcOMZFVYSgnaM+khFUkbWmPwka0yF+cHzUt3OgR8O+weSsrJsWjHAdu9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7522
X-Mailman-Approved-At: Sat, 14 Sep 2024 03:04:24 +0200
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

Chip erase support was added to spi_nor_erase, but the timeout
for polling SR ready is not updated and still for sector erase.
So the timeout value is not enough for chip erase on some NOR flash.
Follow kernel implementation 09b6a377687b ("mtd: spi-nor: scale up
timeout for full-chip erase") to set new timeout for chip erase.

Fixes: b91a0822d752 ("mtd: spi-nor: Add CHIP_ERASE optimization")

Signed-off-by: Ye Li <ye.li@nxp.com>
---
Changes in v3:
 - Replace spi_nor_wait_till_ready

Changes in v2:
 - use do_div for u64
 - Keep the variables in reverse xmas-tree
 - Add kernel commit info

 drivers/mtd/spi/spi-nor-core.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index ce01d42cfe0f..1bddf7cf755f 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -45,6 +45,12 @@
 
 #define DEFAULT_READY_WAIT_JIFFIES		(40UL * HZ)
 
+/*
+ * For full-chip erase, calibrated to a 2MB flash (M25P16); should be scaled up
+ * for larger flash
+ */
+#define CHIP_ERASE_2MB_READY_WAIT_JIFFIES	(40UL * HZ)
+
 #define ROUND_UP_TO(x, y)	(((x) + (y) - 1) / (y) * (y))
 
 struct sfdp_parameter_header {
@@ -989,8 +995,10 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
  */
 static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 {
+	unsigned long timeout = DEFAULT_READY_WAIT_JIFFIES;
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
 	bool addr_known = false;
+	u64 sz = mtd->size;
 	u32 addr, len, rem;
 	int ret, err;
 
@@ -1028,6 +1036,14 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 		if (len == mtd->size &&
 		    !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
 			ret = spi_nor_erase_chip(nor);
+			/*
+			 * Scale the timeout linearly with the size of the flash, with
+			 * a minimum calibrated to an old 2MB flash. We could try to
+			 * pull these from CFI/SFDP, but these values should be good
+			 * enough for now.
+			 */
+			do_div(sz, SZ_2M);
+			timeout = CHIP_ERASE_2MB_READY_WAIT_JIFFIES * max(1ULL, sz);
 		} else {
 			ret = spi_nor_erase_sector(nor, addr);
 		}
@@ -1037,7 +1053,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 		addr += ret;
 		len -= ret;
 
-		ret = spi_nor_wait_till_ready(nor);
+		ret = spi_nor_wait_till_ready_with_timeout(nor, timeout);
 		if (ret)
 			goto erase_err;
 	}
-- 
2.7.4

