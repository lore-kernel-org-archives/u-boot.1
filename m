Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8D7C3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6253388578;
	Thu, 27 Jun 2024 13:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ir78nJK7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 041B888571; Thu, 27 Jun 2024 13:20:19 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11B2A87FC8
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aqo/RMJFXVEGUMEvnBnboRV4L74RZlk9ZDQBXombi/Qh+AiOOrRZM72O9EK0zVEsjmKwm6Vwf1A+va81Pyi44DlsLlZPH1+Mv7jW1d+PpROR00EKF/wrOq4uS4hqnO0CNzSh2XLFb7uH+CoNlXRCgax7bjnYI4dtlh9oIDAtwLXJrjwwZrE7PoocDoACal8JYIJZQSs0nt2Mdqw15YNLqQ4VXDT0o4RdmzTH5hff0XWqjMfNG6uFhKtstK6W6Q4GfH2PFwqm3zPQmtCI74sDBhIFvMh04quknYDO0qghx2IgoaNT6d0W5c8BLXSJHGGLR5La+dzTCDqn6fa5KimXMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DquJsJZxclfeFxIAHRTcuvvuMY7RMYPK+T9PA/wUJDc=;
 b=JJSBfbZTRnT3sFSo5kTapZMfg6jLcy2lN6UrFkDIquAW/8atclyO5UVY614rwUvSR2cUpjDSUhow/Cz1jFG7ZKVhcHTHVbneSfK+8XTQfm4EIv0IiHZPbPpVERRygodHl/IG4tdgXoWF85UComTeqdUIcUOJEu961ZcSoH3Ff5Bl6HDPu/vIh6X1qwEldSdrfUpmOuDuBSZtI+JqCov1kZNDojz5unQF1hLF/5VLU4Y7V6OG3esxRCtpDG8IfwZOuA2q+F33YX+7iSy1gPzbhg61C85I3eZZdRiqFKgLhDFTUoNgAp7II18TItihJ1dmhxymYV2nkA3GR/8NikbXZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DquJsJZxclfeFxIAHRTcuvvuMY7RMYPK+T9PA/wUJDc=;
 b=ir78nJK7/TTezoboIOOIDu4Y9pxGsjPDdzlJ0voPWuj0rbEtdqLdkelD/4TcGpk8FGm6A3BUkMqIUzXBENXsaQrRFwTdVOKkl/bVq+pbpzU+4CsjBTnEfA9sNpHkf/IQOdAfW0tBAMllstC2zUhiW1EuQTQyMV8ZwOvUr/o6dCVq34MWZIGZYKgBGrpjscuujcmKmkzOwKFrmB7TcwaPXa5hgn8v5ZY3Hn/J8+7GTTPSHtoiNDSF1RJrc3DPfa79loVDmVkDbHhrNt96cV+BCo3nbAhOnyJKK4YjTWmo8IRJMH7MZ4sHcWvz+udv2iX6sAdB5CBZM3A6CWWwD5X4Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6064.eurprd08.prod.outlook.com (2603:10a6:102:e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:20:15 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:20:15 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 William Zhang <william.zhang@broadcom.com>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Chuanhong Guo <gch981213@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, u-boot@lists.denx.de
Subject: [PATCH 3/7] mtd: spinand: simulate behavior of linux's function
 spinand_wait()
Date: Thu, 27 Jun 2024 14:20:01 +0300
Message-ID: <20240627112005.99375-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627112005.99375-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240627112005.99375-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0000FA79.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:4:0:6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: d2dcb8f3-bc1b-461d-3c50-08dc969b1e52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HqC0kX26uQMarsmfmIA4PIw3oHlWmUg3LhY1hJpxQW3dPNzGTip+nod/2+fj?=
 =?us-ascii?Q?qd/Xd5WhWUmoe4DManhG5cPG5I33SXodujTKBkdpf+y6z+pAaSXG8my/h1tL?=
 =?us-ascii?Q?DT2jswQpHJyd/3AcuOWKTaJz9Bdu9+noYkQXzvxxBdTnai2S1+qhpUHCXoCg?=
 =?us-ascii?Q?yKXc8XTXretOSkWNJqzMNeqzhofd0m8qIt/A3j/YGy3xHs8Dm6nbfoJShTl+?=
 =?us-ascii?Q?vOD5v0KytuUvqPM6HqhOCFjbKX9fkE72l9MpQ68hkxD4fXj9sbW+vHT1v0OF?=
 =?us-ascii?Q?+UbyzOsdX4GFXkElIg3XGV4kN/j4xiieQlushix1Uyx+937ya/ADvzv5cNOC?=
 =?us-ascii?Q?MNVP61OCC725WPB7E31WW0b7JwLq4+CgmT1MuWm/N3eSYQQtdCeJxckjPuej?=
 =?us-ascii?Q?YGyv4kl4C17GWKMNr7h9c2eg98K15Mk2a1KjJacsxDz4dMqZn3xa9vJ2TkKt?=
 =?us-ascii?Q?VPAhboZtvXYbkAZ75qS5jJEp9+gNIS0SUjTv738MONYmn65su6yhsvE8R1ev?=
 =?us-ascii?Q?28kIWo9yU5uJTYy0Jj/co9p+lylCQBg/NUAZsViqG6N2fq7sxwPO/U9A0ZQO?=
 =?us-ascii?Q?t8B/U3XjDbiZXkA4CSMShXLSDdC57qg31pk8RiDD49LtnS3l/9aPkTyBvMqd?=
 =?us-ascii?Q?8XNvX+p6W4X7hrgDC8gn3h9xWjXqfC+qYgrfpS+FaJa3AVaG9pARErbpjVTE?=
 =?us-ascii?Q?MsN3wVuG2U9TEk6Lz+PHGRT+peL12nKLmg8Pa+A7kCNwrM56SGadeczHU1vg?=
 =?us-ascii?Q?7a8H3Q3GtYa/5qOguYj2IUOqDARvBI8OI9IPbNJkkcYGHsZ7p3CXR4f4d+Gx?=
 =?us-ascii?Q?quOtwP6UA+pw/feGBFSo+9+4vRD4WzpmLdUtDD/rChE2XB0yy8kRu8+kkrKO?=
 =?us-ascii?Q?xIpWYqGxDIuKi+nKlD43qNygi7QcZjYhSp/iosJjGO6M9nem+LXHMp/j/aif?=
 =?us-ascii?Q?5DIrwT3csaepPv/eXdEBzR4G+bCZcgAvf9Sq2oVi3muHW9yGiuUzyujAwtIq?=
 =?us-ascii?Q?WMNFawhKHtWp6LEUw483tE+THv/BVHqaWvpkI2eeNu3+NmaJ2PMyluvwuU3K?=
 =?us-ascii?Q?dIYmLRe2Z1090hZa62AkNvUrqlCvyoWRREX1cNF0oU8lw/GUef+FvAO5cKKH?=
 =?us-ascii?Q?0E0tPOFQVWSr0D3vv/d2NfJ1iMacSlpEGNxIniFw0sgh4NmgBGHJY1T+ZnMg?=
 =?us-ascii?Q?UDuA+g7s7czWiE4Ux4ddJ4NBVUX0kHbP1RtXtd97dNnCb/5nmfm69W9I+48U?=
 =?us-ascii?Q?zT4KYSdaZhhsRwd7z0P0x72YIY/zDgX3CJLz5XmcT/Ip9ilt4hoijQBgwpn7?=
 =?us-ascii?Q?AitzUJEcCIpKrSTBHmSTxXBn0kspgnH4TZtR+2pV+GcG5NxNNBUqLsW4fvEB?=
 =?us-ascii?Q?O7QgJR0Ad3Hvb188rm1zoM3V43DhpEv4na+DuTHgNG/NZSEBRueSojCEoOuB?=
 =?us-ascii?Q?oecRm4WG9pg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+JI7YYnGib/HfQe5Xf8qnym1S1jOAj9FnbRlRwBUhvsxKqzwkklX2AMsaCwH?=
 =?us-ascii?Q?NzuJaoo9kVaGjrLsggKB0kCVXBfxs4voOBs7iOHe50aVPPbMMfflLLWmg1lB?=
 =?us-ascii?Q?SSqLpHA7X1I9v4W63YCLx+U+R6dfRsCLYbzMZBRVS//cnwMVSEXPxGVJ1nId?=
 =?us-ascii?Q?AwgapS1kOFGq/uLqEIJo9rC2+xnIAjFsyExgyWDfgIwSoLavm9qc1ygD5mZ7?=
 =?us-ascii?Q?IkQsG/m1FFlRI+kt7Q8lDJpgzfTRkBwL7iGtj1vlqaUn18/j5u2zblAwmIuX?=
 =?us-ascii?Q?Fsd46JAeiw6SwTNvqLSTV6xtR+N7/y6AnMl1kft6XJSoH7VdlookKtKbsbia?=
 =?us-ascii?Q?CahDHEzB2P2w5zrG4xDiGNSgI7rP2AHtCzb06UTHj/4z58b2gHaN7Mm63WZ3?=
 =?us-ascii?Q?jMR6BBZ/Vh6ztIKjNDDrqI8iYdlXQrp8uVXT+dgc4eJFJyCalmNoyZRdi9Ct?=
 =?us-ascii?Q?eeTDozHJSZD8RXwLNUVbKjgzpLlolr3wYx5GtYTCDz8ZnxVscZaEGvTt3P8G?=
 =?us-ascii?Q?WBALWebdtk8WFMyxjA08cepz9/0rm+7IVnf8BcqVzKiJ1yl8nlBs4+nFss1n?=
 =?us-ascii?Q?Mt+vH0SwftPsmmDa04QzV14GMnWAsI6QxzSWKBv9MlVSmxBOc7Jzl8sFKL6V?=
 =?us-ascii?Q?f55m7/uOei4XNUdrOZZGkWadAD787K5uH/U+h+byT3eFD4amZkrQ2Y5YYxsd?=
 =?us-ascii?Q?pcBLCq6q3vp3PsDK0/U0KnMWP0YAUaLFWR4dJ7YoCvscprCY2tEyUz9sw4zg?=
 =?us-ascii?Q?HjvXUfY6moeNuRtzBqvnXBSRP5PemB6Os6ISREDS8GBIvLjYAnXtxolOXLRh?=
 =?us-ascii?Q?du+Lazq0agr0Vb3rR4PQ2wnbOblDEPcM01cvdKan0PF/IuKcijrarajMWtdi?=
 =?us-ascii?Q?zV0n7vpUdPae6Q7KQ254iPwUars7FAK0qk90rseb/e7gP6H7SXa/5maqTT0s?=
 =?us-ascii?Q?LpedesVI3JSFabIzIUuJuTfPwNhzmWkq05bYJvIDd6iU/14swd2A13Tt3lvq?=
 =?us-ascii?Q?tK2t7HEHRzmPJkJw9jUV7MvKVhhBMh5ySe9aWe9nPKYRYNuY2T2oYN0evS9b?=
 =?us-ascii?Q?aT3uhOrIEPScphFRR8srurm/sQwt8xk/9dgw4rmEZZ6SmwVvZJJUvKzFC5P0?=
 =?us-ascii?Q?5hKbU60laVgkcQhQsFMpuu0A2V3egg4OiP0cG5QI3CdUTUPutMZqBaq1XWuD?=
 =?us-ascii?Q?oOJV1fQuPkmn/iHpkXZZRBA9hl5KGwyoDG3dL8DhTPy9gGM9gzZzBIHWxVYy?=
 =?us-ascii?Q?OQleVy6prKlD+fV9/1WdrzSTiTmEdvnh2MAn6fRVxMfJjtyJnbxzG4V9S6+M?=
 =?us-ascii?Q?HQzLDiGg+lTeCxucivU4s1sGnRyni9XyxPJC/tZLNXbfm9sCH8xBqILGOkrF?=
 =?us-ascii?Q?X/ZFkuXJg4TAje3mfgj7gEDOR3jH0Txtfm7BbLd3yzeSpHqnguuCrj2zCkim?=
 =?us-ascii?Q?Jx4Iei4YXLd7dRmRht06uqlPP5kFe1Cdi80iwkkrM7s6eEWUDJ4ua6VfsCT6?=
 =?us-ascii?Q?av4Wv2B5m45YoRYAX7qseppbL7MzppaXbap9ooNpZNfOKaiJMzEYDbUZtYNR?=
 =?us-ascii?Q?35/KvJKfIlgHPXknoRxKBXLIt30M0eYC14TYE78DFGmjUF3wLm7mY3Ukk0vJ?=
 =?us-ascii?Q?+LxCFeYoQbOI1kuwl42DE6Y=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d2dcb8f3-bc1b-461d-3c50-08dc969b1e52
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:20:15.4056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5P3jFCcqHZoEMVF77xdSlN8AVug5dHauoUxJ4i7leWu7EsB8HH3jEA/Azq5gXFM8ivUeHthn9CC79CMQaduDU93I/+Q9VBYRThHdcy71MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6064
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

also call schedule() to allow periodic actions

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 35 ++++++++++++++++++++++++++++-------
 include/linux/mtd/spinand.h | 22 ++++++++++++++++++++++
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index f10a3dbfdff..8664e882753 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -32,6 +32,7 @@
 #include <linux/bug.h>
 #include <linux/mtd/spinand.h>
 #include <linux/printk.h>
+#include <linux/delay.h>
 #endif
 
 /* SPI NAND index visible in MTD names */
@@ -358,21 +359,29 @@ static int spinand_erase_op(struct spinand_device *spinand,
 	return spi_mem_exec_op(spinand->slave, &op);
 }
 
-static int spinand_wait(struct spinand_device *spinand, u8 *s)
+static int spinand_wait(struct spinand_device *spinand,
+			unsigned long initial_delay_us,
+			unsigned long poll_delay_us,
+			u8 *s)
 {
 	unsigned long start, stop;
 	u8 status;
 	int ret;
 
+	udelay(initial_delay_us);
 	start = get_timer(0);
-	stop = 400;
+	stop = SPINAND_WAITRDY_TIMEOUT_MS;
 	do {
+		schedule();
+
 		ret = spinand_read_status(spinand, &status);
 		if (ret)
 			return ret;
 
 		if (!(status & STATUS_BUSY))
 			goto out;
+
+		udelay(poll_delay_us);
 	} while (get_timer(start) < stop);
 
 	/*
@@ -414,7 +423,10 @@ static int spinand_reset_op(struct spinand_device *spinand)
 	if (ret)
 		return ret;
 
-	return spinand_wait(spinand, NULL);
+	return spinand_wait(spinand,
+			    SPINAND_RESET_INITIAL_DELAY_US,
+			    SPINAND_RESET_POLL_DELAY_US,
+			    NULL);
 }
 
 static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
@@ -462,7 +474,10 @@ static int spinand_read_page(struct spinand_device *spinand,
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_READ_INITIAL_DELAY_US,
+			   SPINAND_READ_POLL_DELAY_US,
+			   &status);
 	if (ret < 0)
 		return ret;
 
@@ -494,9 +509,12 @@ static int spinand_write_page(struct spinand_device *spinand,
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_WRITE_INITIAL_DELAY_US,
+			   SPINAND_WRITE_POLL_DELAY_US,
+			   &status);
 	if (!ret && (status & STATUS_PROG_FAILED))
-		ret = -EIO;
+		return -EIO;
 
 	return ret;
 }
@@ -698,7 +716,10 @@ static int spinand_erase(struct nand_device *nand, const struct nand_pos *pos)
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_ERASE_INITIAL_DELAY_US,
+			   SPINAND_ERASE_POLL_DELAY_US,
+			   &status);
 	if (!ret && (status & STATUS_ERASE_FAILED))
 		ret = -EIO;
 
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 5934b7604cc..b701d25f73d 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -176,6 +176,28 @@ struct spinand_op;
 struct spinand_device;
 
 #define SPINAND_MAX_ID_LEN	4
+/*
+ * For erase, write and read operation, we got the following timings :
+ * tBERS (erase) 1ms to 4ms
+ * tPROG 300us to 400us
+ * tREAD 25us to 100us
+ * In order to minimize latency, the min value is divided by 4 for the
+ * initial delay, and dividing by 20 for the poll delay.
+ * For reset, 5us/10us/500us if the device is respectively
+ * reading/programming/erasing when the RESET occurs. Since we always
+ * issue a RESET when the device is IDLE, 5us is selected for both initial
+ * and poll delay.
+ */
+#define SPINAND_READ_INITIAL_DELAY_US	6
+#define SPINAND_READ_POLL_DELAY_US	5
+#define SPINAND_RESET_INITIAL_DELAY_US	5
+#define SPINAND_RESET_POLL_DELAY_US	5
+#define SPINAND_WRITE_INITIAL_DELAY_US	75
+#define SPINAND_WRITE_POLL_DELAY_US	15
+#define SPINAND_ERASE_INITIAL_DELAY_US	250
+#define SPINAND_ERASE_POLL_DELAY_US	50
+
+#define SPINAND_WAITRDY_TIMEOUT_MS	400
 
 /**
  * struct spinand_id - SPI NAND id structure
-- 
2.43.0

