Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CE4C52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 10:19:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AA7A889FD;
	Wed, 14 Aug 2024 12:19:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="DoJ37e5W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE2B0889EE; Wed, 14 Aug 2024 12:19:40 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BFAC888CC
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IekaxYlN2fyMXCEiWX7VHBUAy03YYNzsVzzuKHKtLmMPGq9n+eP4KKEphaFLVdqLVSyItHoTilUa3wgSCEYFbYuWVSCugrUAIajsCAOaP7iYomPLwXoWtNP1AUu/Hxxrwn7/+xGnKVqNFUka09aRg4sW584QweQzcwgVT0h4ncuEjX7SdMdhgtf+FOWxCFkuj2KNqFNmsaIslrjzbFoDAH2LqfEchRxeaJ3nRvE8hxfNRm5C+YwUwU6Xm4rRKbSuKzixEs0lbdXhTOU0IhA4OpLmTVV8d2HEgtwyQSjD401NaLb0YqJba7lQQ0W38hAT2S99IqdUlkJ8kiQ95iZIJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/a/OwZbXGURDIViK2q1oa9sK+ZfMQzVaZ470XJvkbrE=;
 b=gYT/zjL4Z0Zjb/bI3C2l4WsffhIMFUTYPqgsTOFWvz0hSCAr/GQFuDYBhNdSpQCNY0zv+gLARundX3X/na5tziGhouyCyryqT7nJsyP/L1dT4BtLkwx8ag2cN6wKrUGqWEmjrvEn1zGvJKIKoFjb0EVhetOwIAe/J51mr8VFAyqHYQFTSqg+WKefKPl1nHaia/VpwguIZ1VwBC47DOo3kavmbocsADwNZMA2AgMO4t6I0t4YMQmVaHyIZpOtYplEBr7bwZWD7qaB0V4qzUrBPz9eUUrY4nQZ83+0K/dKvYJvoGYVCCaV4T4nVkH/VZJoEeETjnyAwkgha8fJ2Lilxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/a/OwZbXGURDIViK2q1oa9sK+ZfMQzVaZ470XJvkbrE=;
 b=DoJ37e5WpRu3JZKdfN72gZmGGyE7SYG9KitzYIJm5zPIQFk6D6BK76uINzvOEs0dCJgY0pTsFdbLiC7ZD0X9PTBZNYhFdjnTsu/yFLssc1TG05yK4buH2Xj7Ue53VY58RCjHeGbbs69CikMAMdMqi8F49QAw0+In5XAjWm3BsaCHXrWIEYj9Ur4sgGQ3ILtcxGB69W/KMeEt5osEPdLov4r8NVbh6iiuFxbHY46z3RlqAAgCqGdBRpluVDLy4a65SMUfeuE0qvTGlGet6doxBqpooICAxMCS4AzMBsc0ZJldZLy3flBe8mY8rOQw8Xjc9UgQFymP3u7UoFwVePxsOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB9524.eurprd08.prod.outlook.com (2603:10a6:20b:60c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 10:19:37 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7875.012; Wed, 14 Aug 2024
 10:19:37 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Chuanhong Guo <gch981213@gmail.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND PATCH v4 02/10] mtd: spinand: Add a NAND page I/O request type
Date: Wed, 14 Aug 2024 14:19:10 +0400
Message-Id: <20240814101918.1347167-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814101918.1347167-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240814101918.1347167-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0401.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: e56d6411-ec76-4acd-5367-08dcbc4a99a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/b75jVkqM14pOBuXoWemuSUjdRoV/NZsJv5C8+/ufWF/L+54ENq8qhjuE9Jb?=
 =?us-ascii?Q?2EG1EKFBnI1Ov8wu1epJeTYGmbTMTXBvlm7ly2QC1MbAHkKEQivoniCAjpXF?=
 =?us-ascii?Q?jIWrmykuuSFyIYnhl0cp8t7ZKBzxYNctU5sRzN1rLx5vjSptYeNRy4dPsq6f?=
 =?us-ascii?Q?rQCxu6egO65p0QSOIYK3y+Su+10iRlabQYl1UXONCiriQARATbMMrh4ecHwx?=
 =?us-ascii?Q?owgKCrp+1oG+nwc563teRvGWbV1d/7jUv6Vo74Zxgr2ovtLD1f9NZfIUFnsG?=
 =?us-ascii?Q?tL0HAsg6vfoQGtVzAH+gHgwywmhAUCs7sdx0KzlbVJqdUcF843hRJwyW2D2n?=
 =?us-ascii?Q?YAGqMqqz7V94Y+bQUV+y5p1DatAXHw3Ho7FiY29Z3Ao+Ueqn0+5a6TqWMomQ?=
 =?us-ascii?Q?99WwfVfVXx99Sq1ajELvkKhxAPf0qv9yge6x6GmqgxzRl44O+v+OkkhzaoI9?=
 =?us-ascii?Q?80zkQnr88WDoucM7R93X480lpTxxG3CR242tv0Z8aR+t7CM6zUqLkGNEUsp0?=
 =?us-ascii?Q?3QEuJiZk+J1Lrm0KO6mOZ+sEIp1kxyhlfwNa/vGdhXXPvzxVMmZ6WMA3we8u?=
 =?us-ascii?Q?b9l+MeSDR0NkMQkGGKcc4cG7+ZZkJ8tnhFIhLFM15KfQcYcJvIU2T5fjPcmN?=
 =?us-ascii?Q?4mbTfs8iG7XnAxWlHRTfZ68uA3GbKJ9M7ylOxS1wrHNT/bzq6/nRz3Mnrcd/?=
 =?us-ascii?Q?2JferPD3oxyEqxM+uSfFa2eIQ/cYmbuhEJxvQPL2a6xq27jbx5pSMlm3ETn0?=
 =?us-ascii?Q?hGMfzuaosvhAeRmCgzYnWPycuN2Ya5EUMVkqj8UwCB39no7AX+x1QxsRpymy?=
 =?us-ascii?Q?BVlsrcDc1FSku0aGF9YX0J4DfiNt5FOEy6DCqWF2VtS7X2rRQ/cqfsBAMoEW?=
 =?us-ascii?Q?+lGJAECVR0D87hyMxnn4llcNqvlviGCOYGfGvEVzti9vyzbvir2A+bwsAPh0?=
 =?us-ascii?Q?llRHCHxUNINpsdWP5CC0cv1hOQYrVG2HcysQKlFWLIh9aDSfngFrR6u50NvU?=
 =?us-ascii?Q?SIYSYElwYEXCUnA4pCEQX3HTZTP+Icqhsg57RfiE54NXWZfuHJXpkYF4v3J8?=
 =?us-ascii?Q?KzUjtLn+lE9XJJ1wY3dLU7o0GSQhxiTnIYQD0jArDnRqqOqJTRiBTMHuzSfS?=
 =?us-ascii?Q?EQPVoSfenTvDZi+orM50ItDFvid9VAxV2K/8dKXJBg+YIjYAaHelA0Cb2r5X?=
 =?us-ascii?Q?CvaJFipsHIo3/N3kl4Ts+sqsiI8BePZmHh2QEBNVYcCc+G3gc+7rM4wUie9d?=
 =?us-ascii?Q?iUNRcc7Ht9syopRlh72+/eRy51MfAeD4BipLSN64CDPMleJArqDzJu+F5oAs?=
 =?us-ascii?Q?8MJ4ucAXJF8QPJvphVSF6s91L/LBIBVrJCVKrTF8b55rH9tD4YUKX8JPY5+c?=
 =?us-ascii?Q?n0VhbeyfNAwIJ4UDrCs2wIOEzpmWH/WKPG6Rkovs+w9gWRo8NSlk1SdhT12X?=
 =?us-ascii?Q?HOODjQue0YE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y7+z8CNXi907KV7uj0lklcZnWHd6JBNXwZg0C607xc6b2cM3WXgtb5hDA/WG?=
 =?us-ascii?Q?6tOqFoTRtF1SUuAYKH5NFo/w8CL2Mj1FgS9OniH9z4eD2s+GRIbMSJ2xsuri?=
 =?us-ascii?Q?TYL2GCknYL6LxqFdYLo2GujTK6mXhcZVz8SO8enNogmYFA/rrhSIHpqC4hWT?=
 =?us-ascii?Q?pKhKxggSnC3+yO2lf3LcoYJ2QQBlZTvvDdcQiYFINXOFl/tyFTSOJ0b9jY2B?=
 =?us-ascii?Q?QgtMls5gcMU7Q7mF9/bA5YQzROrxzw6W+DDFrHEtex9KND3hIixJWTY7NtmA?=
 =?us-ascii?Q?xnDS1KgbWeF1+kuf91qubAvT8lZ8DzUv36b828DD29r4Z6JAJDdJMD3icfHf?=
 =?us-ascii?Q?5GvnSRrzdJ5z9oPsWkOIS4fKrEtnFUfMxbl+H0IBPIVrP1GJXXhi76vSXNtJ?=
 =?us-ascii?Q?da5ZD2NktUxGMK32ypmVzLQ7XmHMZq6DuLdS+4eTCwZtwQW31rr66U/VXEcd?=
 =?us-ascii?Q?X7nG+5C11h2131z/Y9/j5s286pSrZwbSvYFSYNnBnqly3iOFByRE/B1AcXQ7?=
 =?us-ascii?Q?6fDHQJQh+8exvX2D79/b0N1hFwzSpoAsR4aaZcje0knc5wKp6sLcl5tmGodA?=
 =?us-ascii?Q?AW/r7Z+oJ7fRGGz2NFQw9PXJzBHrYIxAnqRFByxoo3RII+eilefRUgLVrKg/?=
 =?us-ascii?Q?LUihKwOMB0XWX75nWb209+HCE5knk6n6AhoTJe2X8sBFeuFlkby/wiLg0MFm?=
 =?us-ascii?Q?R13GZ9jIw1rawE3Fo9KNNvOczWbbsyWJXYV6469CkfO7PevH99ewPuTJBKIP?=
 =?us-ascii?Q?IGVw6QkXE1QrjZGqDgPcMReSWMVcgicSD1ROTPPwVoHT46ZHerUQ1h68qVE/?=
 =?us-ascii?Q?w+aIQl0vmw4kFFUVX6q8yXEQFPazp3cx+/ipbrH45kCTpyePml3RbLG0bAbc?=
 =?us-ascii?Q?IDktCVY2FIwxIym7q3brG5K90PxdP+h8Ig5RG4ADKEnM1ahNbpQJeP63uS8Z?=
 =?us-ascii?Q?xybSDXDCMy4v0C73hy1Nm2tsdk7LCeYsFfha2yusplnTGm1UREPaFj0UO3/E?=
 =?us-ascii?Q?l/Z5cA8eZlRdKRTQsPaD/gGhHh9VVfnhi30pI4hdZb+dZa5IMCtKXy0SDRFX?=
 =?us-ascii?Q?t7efJMS8RkvHhjWUabzA76+bUYJScTgS5q11uLzqimLh5mYFGXg9/0Vp1zq9?=
 =?us-ascii?Q?TiBB25qxNHK7fhD6kT765sy4eVCcVGPjjfZHUdPLTP2M6cUp3lKlOz2zZt/J?=
 =?us-ascii?Q?fintzPjtJ/jkL65FEr2BynIMaJjm4uF8EqDN/EaX2ipH1qju7IMHBc3ZZelZ?=
 =?us-ascii?Q?cnlRKYbj5nOxvLodkVtx65r8k5ICLcvHwpil/ErCVhluPmUu2lCrEt4w9s2C?=
 =?us-ascii?Q?7onYYGJ9Edzw75VCSu8YB6K3/H54yfwuCCIuUotUcnJ38SGrUki8WeVKVuR6?=
 =?us-ascii?Q?Zo6bLs53VVKlIBvQw8DiDUjtk31Hf9Gfb8BWfe0WkW+9IGTu1jbQBDZZVCA3?=
 =?us-ascii?Q?hFsHkFDB7or08m1mQZpWfFrRlfH8lIMRH9d/xpcZuGIiUd5gw+WnWU+VK/M7?=
 =?us-ascii?Q?0TEYDAgPmdJPJCODl2gQR/xO9b+NlGsHOoNKpiviSkKCXbdPzDglMzPikudp?=
 =?us-ascii?Q?18wS+pYnHw1E5YKLk+Rn7HEi1pzVw1yuGE3BH8grTc66cXIf8eTCwxxEF+x3?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e56d6411-ec76-4acd-5367-08dcbc4a99a8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:19:37.3662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdlONcyo9nhpvlJRxkY4vyishJ8gi1W0GLw2K1NJayhi/2gjivNBjyMCrjEse0bASBmfL4tsNGqI8KT9uIMGmWnHTUV7lSyqXKid+7kXVEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9524
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

Use an enum to differentiate the type of I/O (reading or writing a
page). Also update the request iterator.

This is a port of linux patch 701981cab01696584a12e5f0e7c2ad931a326059
created by Miquel Raynal <miquel.raynal@bootlin.com>

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c |  4 ++--
 include/linux/mtd/nand.h    | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index ea00cd7dcf0..8f227ce81fa 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -523,7 +523,7 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	mutex_lock(&spinand->lock);
 #endif
 
-	nanddev_io_for_each_page(nand, from, ops, &iter) {
+	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
@@ -575,7 +575,7 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 	mutex_lock(&spinand->lock);
 #endif
 
-	nanddev_io_for_each_page(nand, to, ops, &iter) {
+	nanddev_io_for_each_page(nand, NAND_PAGE_WRITE, to, ops, &iter) {
 		schedule();
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 651f8706df5..0afdaed5715 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -80,8 +80,19 @@ struct nand_pos {
 	unsigned int page;
 };
 
+/**
+ * enum nand_page_io_req_type - Direction of an I/O request
+ * @NAND_PAGE_READ: from the chip, to the controller
+ * @NAND_PAGE_WRITE: from the controller, to the chip
+ */
+enum nand_page_io_req_type {
+	NAND_PAGE_READ = 0,
+	NAND_PAGE_WRITE,
+};
+
 /**
  * struct nand_page_io_req - NAND I/O request object
+ * @type: the type of page I/O: read or write
  * @pos: the position this I/O request is targeting
  * @dataoffs: the offset within the page
  * @datalen: number of data bytes to read from/write to this page
@@ -97,6 +108,7 @@ struct nand_pos {
  * specific commands/operations.
  */
 struct nand_page_io_req {
+	enum nand_page_io_req_type type;
 	struct nand_pos pos;
 	unsigned int dataoffs;
 	unsigned int datalen;
@@ -613,11 +625,13 @@ static inline void nanddev_pos_next_page(struct nand_device *nand,
  * layer.
  */
 static inline void nanddev_io_iter_init(struct nand_device *nand,
+					enum nand_page_io_req_type reqtype,
 					loff_t offs, struct mtd_oob_ops *req,
 					struct nand_io_iter *iter)
 {
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
 
+	iter->req.type = reqtype;
 	iter->req.mode = req->mode;
 	iter->req.dataoffs = nanddev_offs_to_pos(nand, offs, &iter->req.pos);
 	iter->req.ooboffs = req->ooboffs;
@@ -687,8 +701,8 @@ static inline bool nanddev_io_iter_end(struct nand_device *nand,
  *
  * Should be used for iterate over pages that are contained in an MTD request.
  */
-#define nanddev_io_for_each_page(nand, start, req, iter)		\
-	for (nanddev_io_iter_init(nand, start, req, iter);		\
+#define nanddev_io_for_each_page(nand, type, start, req, iter)		\
+	for (nanddev_io_iter_init(nand, type, start, req, iter);	\
 	     !nanddev_io_iter_end(nand, iter);				\
 	     nanddev_io_iter_next_page(nand, iter))
 
-- 
2.39.2

