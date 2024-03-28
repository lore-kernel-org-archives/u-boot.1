Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459BBC54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 10:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9853A88151;
	Thu, 28 Mar 2024 11:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="j8/Ecy7w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24A098815C; Thu, 28 Mar 2024 11:51:14 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F09688151
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 11:51:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDg8gBjTXTHgN/1orBzPA7DYd7TyWgrsf4PX8hUhmkXD6QPc1+vqqBNn58ThUFhTDbC7z5sjKTGkAsUAUBTQ+TzBVownePoyoS+yArWNFzy6n1qIuzRv2qH0X3rjaST71N9P5lHZ/RlyaJxO1dWNzHouYh3Fs3VxOEK4o2GtIrwdwYgmXGHKJ9J0NgWlgTV6g3VaEJv0zLByuyIhlNwN2IcDEKKVTKwdWQvmn1PIA+2jHK0xOv9o7DIWHxOrqhsFAIPy+ctn1IZJnMKe0OrlS+6m+7uu06keAvkp+b04JSf9hMIaLSvMRmqPJXhFXqjemqd04LL9FIqNd9ZcB90D9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AW8xyWzuNUQWV1J70qBIMJZAD/0ax+LvEej1xH3A820=;
 b=Kphq31OjEv71F0kvapZEmKWGGSCuLmIFesfN0FyYNk4HFWY9NW2KAlNr0waYJFsSnP9X9cBJDcOKFTyRk8sdVVef+PFdONwo06Fez2NUfXsgS/bK/JiOp5NNJ+SRD4Wy50dCmgv6APrepgNsIjGIaHPHC8mgdqEev65Kf/cuUq1GQUFSP82rOa+7Wu2nx8Yk2bkrt16oprNQ7hXwQEZrU9nE+GpbN2FAy19VVW3kH5cbC45yxm1VVUPvUEQUqGVl3dNhUJsOecHELUIsS7xnRfZktaIJ04Ny9lxq0cdWwI+SLjH8giMtK0dOGOc1Mog6D+tofkbURV47bCuhaQjnpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AW8xyWzuNUQWV1J70qBIMJZAD/0ax+LvEej1xH3A820=;
 b=j8/Ecy7wg/1vRTR71dkpTWve11uhStjUerxljUFOzp8rQvpJemiGJnFFSLYzmzes/QNHBLumnsDrnljlC7aC81DXr3xv5XnUQ/WG3X0uaAhxc46oRcrC45n/xk69V2izgJhzdY2S8L9vAnAN8BoM7V30EjEw07RrOzGSejQD1rY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by PAXPR04MB8318.eurprd04.prod.outlook.com (2603:10a6:102:1c0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 10:51:11 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::3da1:cdb:7bd8:750a]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::3da1:cdb:7bd8:750a%7]) with mapi id 15.20.7362.035; Thu, 28 Mar 2024
 10:51:11 +0000
From: Ye Li <ye.li@nxp.com>
To: sbabic@denx.de, u-boot@lists.denx.de, festevam@gmail.com, peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH] arm: imx: Fix incorrect return value
Date: Thu, 28 Mar 2024 18:50:55 +0800
Message-Id: <1711623055-62295-1-git-send-email-ye.li@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|PAXPR04MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b833a24-2e90-4cd6-5da9-08dc4f14fb03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: loR+Jqo4oF1Xh2nkGILF0XQNBw3OltK2ewLgUV+uG0YGExVzEFNwjMAcuI7O/93tAdsxHK/GayJ8HuHRGzP/gINMQLIqvdWOPy2Rl/jWSQB2uUjJ+l7LsjbrR/5jdvAzvxkHJlQpDoXAFagfK0++uv5OkNpyBfpMcAa1CiU4iO4O4IwYHWthnwhdBfQ5ryEER1ni2zuCbFar/Jg1vN/J20n4sqtLu+u/l1ceh7xRXMUfppJWGXzBj1cYoa8R5O4PStAHBkxa5SW5T3uuBYe7mXpTr5bkzY8gT0zaGxUirr0enCkFu6/4JsWpqtuq9JpVDETfYqNyHn7T5rGePrWlM/uEOadBGWt02MaeMjVmWxC9FHTZH5g39X4S+/o/EkQsK1ISg7LjLZyeu0xiuYxNlfCcDxeXVYQP89MPTZumOHl3Vk+CAdl0L2HZaP63KzIC5ojEaJApLST8s62bVLyZxcd7BHALSm7qAgayN1Oy1jupXklekGQQ1KTkdCl4i3/BxTaDhfKUgLscguVqzkZbjCnE5L7TCNc/bbjSMjG1nX9lzW1nIh1DBSM1E9fLeso3014MR41TFPyAxnMYxvOYzzinFJF4Hy0XVl8OnwhD2cluH0TYbMWF05T4grqFXl0LbpZxFKvvxCXLL14mBDT76GAZhqBPWhunBYcMO1hGqhhiG5J104gNYIG9B9+2Pek3FeDakyvwfHK3GQFBYXWKp8ewi47mVtr9HgsRaRHwTWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3pSkYeif9X449ylJ5X5FSF92cp/ahSgsA5k/e4yuhDOmuIAXUeRCieKoxkUB?=
 =?us-ascii?Q?usWbzpPyZJ1lJYZ76vBmo4uqVz0hJWckJVr7P8VRrwApetgvYfifqFNYpl1C?=
 =?us-ascii?Q?s9MgvYfE6N0QwjIwgCUKQ10TyGyNICvHjUcQ7dqf86TW/4BVD2hC0TLjwtq0?=
 =?us-ascii?Q?KJJA7ZR5wVKQnWJ9cBHeZ5CnJBmd3hffqn6wNKIs4kgPSlNNtI8N63ZoXOKk?=
 =?us-ascii?Q?+5syLOGAj+E7H0isL5cFWeMGXGZXisMg7NiX9/UDDULokVHg/KIP1qGk8CpM?=
 =?us-ascii?Q?/14vV4SQd9+FaQPknIa3jSmtNWS97XxwyMxKtNOSrWgT353nYTugzV3ClBzx?=
 =?us-ascii?Q?f+KiVEfBlay81RMYMnJxkUn8tS4MRlVKB+nES6Nk2RJ/XmKOsHYN2DW10/oY?=
 =?us-ascii?Q?iXX2hTrG6cwamkgvZHhoKJZp7LHLr9bwC+H61g6xH92+qObIY2AaKudYlScU?=
 =?us-ascii?Q?oKLW5lsR1WlUqlPbzP+R3kYV3kBXTJv0Zd5iFyw2ItR4LG3T0h3UbBybv1nw?=
 =?us-ascii?Q?vMbZvRUG2lz9a+RpQjSwWDxPyedziQHpyNRw0BaAUGbSFZunQ3olG2RI4bDH?=
 =?us-ascii?Q?gmA+Rx6wWgi+/GeCWWx17csW/PB7Ro4U8J+8+7bBYrZKkGPcHArufvX9YI4v?=
 =?us-ascii?Q?Putmuy5VH+QP+/xjMplcL5c5RYXYkRgc0U3Dc7Zikuql1CfpKfbe0ksiFtTA?=
 =?us-ascii?Q?+VToHRwNI1LuzEX4T0juEo1HTaeYqEv+9quefGNSgTeu6QGntnn2LovJSf9x?=
 =?us-ascii?Q?3fT8lmv6+GtmoFGbTOJuO+qXpfsy/gkahSAdrloo/NfooOTfrbd13JTbEJqC?=
 =?us-ascii?Q?R3HLan8UYSxe+m22wCr+Rq1h3yGnQ0d8zy9vCdGRjBFUscR0cHh9aX+03xyp?=
 =?us-ascii?Q?pDXl3DpLoR49UgogCnojaGl0umTJCWXDScYh7s7zvuplrq9vAAehXAX+LxeB?=
 =?us-ascii?Q?asotzVkADirLaN1rDh/ROPD/yllx5190dOS1Ws9xAnpO+2ObU3BOc8/WohLA?=
 =?us-ascii?Q?16aSG9OpYbLgCTFATqhu3ngd+aLVk0BCeycEUjmMEwaPLkYb3Wlp8DaOfNxc?=
 =?us-ascii?Q?KrrQBKhk/JozPEsXRAODCOJqxnXTeW7dY9wILrtS6QjzpjCrv5/uYbaWS01a?=
 =?us-ascii?Q?N5B+1LRUdpHE1FXfhVkNMNEEY/cECGfzieYgUGgSo/bdhrV7+iihzNyhUaUK?=
 =?us-ascii?Q?AhwJQZiRQLDvZ/jPd8gQYQi/F10qU/gQx5nQYxbCKSc7FSoVTNYIBFYB34oP?=
 =?us-ascii?Q?lXxGX5+fvecaQHAZ6GmO1OWQC8d1t43M3Zng1oRi+/8UYLOS6+tMnRPZ5Xvx?=
 =?us-ascii?Q?JH90sXHUra4mQlXfJ6RbR5lYq1KSu8wGfBFP6HL8DyZ9vZo4bbJt9SGni1FF?=
 =?us-ascii?Q?xLXcYU/uV0bFKiI4lS0A3kZiYWufc/5Gc6HU8M3hTvjycC1yE1CNhZcQHIwB?=
 =?us-ascii?Q?aofpDDg4xMiD5uTXXMAH/b0oAAotN+aJKlxN4pV3IFyaBdUiWc5fLHE9bds8?=
 =?us-ascii?Q?ojQ29D6KZtm+9KdSy9P6nS7jRHXbgEfpEt9Wq+vqmmBGnNyOFHObRz6SsVkY?=
 =?us-ascii?Q?uCKONXk3+DUyaSM4WJyajVAWPoJAScorp6rpMtWd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b833a24-2e90-4cd6-5da9-08dc4f14fb03
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 10:51:11.2201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ak5WYtq+TAZvM8Be9yOJyhb3kuRiOfmFpO8nz/1gqzr7nnOUMZc4WSunBSgS7P0z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8318
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

The spl_spi_get_uboot_offs weak function is defined unsigned int.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/image-container.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index c9455fe..35da0ae 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -262,7 +262,7 @@ static int get_imageset_end(void *dev, int dev_type)
 }
 
 #ifdef CONFIG_SPL_SPI_LOAD
-unsigned long spl_spi_get_uboot_offs(struct spi_flash *flash)
+unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
 {
 	int end;
 
-- 
2.7.4

