Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2C2CAC5B9
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 00:22:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9B9C834E1;
	Tue, 30 Sep 2025 02:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="bKlFxUTX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6644835AA; Tue, 30 Sep 2025 02:21:33 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43B0983544
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 02:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xw6ETtUNB/T+5nSEYq8AZ5qIAAoUVXPvRkwEgnMlQPAhOdpE/+5ONGAF+XOdxoOxR3X2PYC+rgFjZQJiDf8CfxbyCjaqm89uBNyovp82oUNQq0NCx4c2EMnVg5cbY88FEGsMQGcgkgwe5Ti54+kKoNauGyvc/MpXU5rlvdpzju9mPUCA8xbnoyjmHFn/MQAPI0qTpXTYPHaW9HPqBKw6GhixhJJh556psabIesVETKoGKnzK2KmRaekzAcVARS+L9s+HC66ysdQkaBm8RLGJqx44EZr7a1d4uJ5y3F75lLOGb2fLHDlrbWdSU/Q4AWxZkxY1b3zEWYL7zi0tY3eDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+7OLkHWHAr72HKO4DHCICKgVPTdLoBXoCXGS++luOs=;
 b=JiGPC6lWb/58BiSTqs9wEQ2mZdDQE1GnfxmDOiPbjk3TerA4rKhxzTdyPPOQaF+NrBXlM4Ri6WLJKngJUdouAI4ZqufevsmFhc9lFtzTrFV/2LXc8M22xzgaddTvEABmxSShBLlgZ9uv0xg9qycQxeC79TIBli/41iXXdkvGUi2uFpZqSdGUKuqH1d53wRMH39gL5m1V/9/mW9+i1eIZy7iDOPl3oEHWNbfnjIhDDQGbU2A3VWUSixM0uKGbZSjg1Purq/7rVzJkhp0Fp9CUhzxe10cTgHPlzZFUPZSg9R7gZjAv6mPKLCOXq+GMTNzO6gjN9VWH0AZcOD2nKdPqCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+7OLkHWHAr72HKO4DHCICKgVPTdLoBXoCXGS++luOs=;
 b=bKlFxUTXZaM+WThrj9FU9dJlMsYYLMGKLw8XKSFLA3TUUrK6CrF7UwYs534QO5WzckckyO2SLLUUsuN20r9SpEud0zioQhEypid+ajwfluYtxZiVL4inUmuaWuMUBM2NbPznzL7lcgUUsfbZwm1KyL2flVIXAbk/QMpTWR3h/bpEGs6xSvi92apYUxL1BQ5IbNHNCqr2JqYLHgMQjrhd7CtpJ6msFUCzG+4sSsnNWAr7nqjMDL02LdCySLEHi10260C3R9HVRPu+J8AV8mBgP29rlz00BzHbkv5TRSvaf1WXCvvrhlAwl8PWN8UgptbEqauxBCouKBd3A7YFZP+gaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB11512.eurprd08.prod.outlook.com (2603:10a6:102:50a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 00:21:29 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 00:21:29 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v7 05/24] mtd: spinand: Extend spinand_wait() to match Linux
 kernel implementation
Date: Tue, 30 Sep 2025 03:20:50 +0300
Message-ID: <20250930002109.3600886-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0317.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAWPR08MB11512:EE_
X-MS-Office365-Filtering-Correlation-Id: 85809edb-f0da-4d81-93c7-08ddffb74a0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BkioOIEtgpSOCEkP16dGyT+LCWiBG91DZkrmqPXElk4rvkiwZmbSAKHIPnN8?=
 =?us-ascii?Q?T4Ke3Ej1p5zGstzdnSxM2HL5Je4CavmM1KQR+PYaDnRcrlO4+JFZQcVXVvsp?=
 =?us-ascii?Q?YCcHve8ihJbiHUk353lq9uA/pKKWG2Nz+ICj79vQKCfzU+w6r3tV08usORyg?=
 =?us-ascii?Q?R1FChL3KaJJ1v/J38qwnuMKQO1o4ufHJXUCKXgifAT0/ITmjJpyKKgJU2G2F?=
 =?us-ascii?Q?EP22T8pzUBGo+eXJu+z2mv5KxzmVZj2s2DH6wxTiXoPhLaBu8l+x0p69v7Vl?=
 =?us-ascii?Q?JrPJsEGFrileT0CynyBZ9DjVh4ZtWT4JL0NDK9Mh3m/egx4JxMJFy3SpOy60?=
 =?us-ascii?Q?7Y9Adzn7O0lrHNspH/0HMqjMsb2Q/4sMX8wWXh9+LPYqeSoHUFJhlHidu2gH?=
 =?us-ascii?Q?yxBoRw1X1WwieG1b5XMt74p6v/CeU0/VD0nAx0/MvqrCL5jgwrKnxzMdrfYa?=
 =?us-ascii?Q?riYHmetMUkj0YcvE152QtBYtp7Vp2bQC3NMDbQS0MaVnndCSEmb46LbLDp2A?=
 =?us-ascii?Q?DZkSUV8hkKOQHB/TuQZY5PMXrX03wk6LuPJpvNPsvsikJn7Xy2paHYT+lt9j?=
 =?us-ascii?Q?GLgBboW6PEDhTxDEkNxe/04f+Lns3YTyuobLXy4Adp17ccrFfQn+WYOQYT7u?=
 =?us-ascii?Q?gCMclahrnyj4ijMYUC0mDuaaGEVO2rAZh5yTbPVY30X5sv+82VUZ15ROTuRz?=
 =?us-ascii?Q?ZlwncC62LzKYQHHO9xbwge57slO19OSrZljHxvCUOrm4vkoJaws7IKEUqzJw?=
 =?us-ascii?Q?GiZnoBuYAz4DpmBw3bQUrMj4taXBsIhSwONEG45e4GU1ExsSizOqxw2hXIVw?=
 =?us-ascii?Q?Njf5J358Jk91CnZr7RC+n4Ry0XbCnhrh3jApBWMGS13Gcc2eOV4M1fQz8/Ma?=
 =?us-ascii?Q?gpdieCOqrdyJv06FbsJcqN7AmMK27VlIngiM2iBU2e8SlKhkCz9FmO9eB3hE?=
 =?us-ascii?Q?tK1rMxebUq85JZ2/fT47KUaYtB/vD3ht8DzwMaRdzFhZhTZshHPS1mtoxdN7?=
 =?us-ascii?Q?YoOK/FGi722vyw7cYwpR/YwmSUDckisZv18yH4HcsoFcSyi86Rdbq8esSGau?=
 =?us-ascii?Q?2gSR+/CLngALlvkTwJDUOolAdYrtEsTk3Z1WJFWkKbGo83kM5b043AXWPhx0?=
 =?us-ascii?Q?bX5anW7Qy3dgEJODP2E8MS6hH9sZtS0IjYzoKOKAEgoW/6kC+N6+iYERoqy2?=
 =?us-ascii?Q?FA+jxpBTGG5MenfCQNNf8yQKk9p9aqxFgro5I+p/JaPcYbxpvOI5MKraksKg?=
 =?us-ascii?Q?vObiK+7GM/24c2fQf4hmPDilZN7PAZz8sDyUpwU/LziLKmALjXIZsawYcxie?=
 =?us-ascii?Q?xr1cZPLUks7zDG7QtExi6oun4HnKuRl1J6/i4FFLosir6MLZxNfHUkHBbUB4?=
 =?us-ascii?Q?gSuLZYXgpsOWMa8+514BzAfWbqcAYjrd3B0QzGNOhJLsWapw2d2BY2mdGXyE?=
 =?us-ascii?Q?ZgAk/E5zpVSF+gtl6JC3jdBxNVBIMUaBGezC/n7MJZQCRsqp54lhZUIHdZPJ?=
 =?us-ascii?Q?khULJpFx4eOAHqSt1V3DE3aPcxWYKNpa0Chxgu3Kne4qLsu9bQkpOCJsfQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CUEoaNVGf+eReyjsoehPHA3AX14d9Cn2SKaZOOBv9L86NcGCeUza0ZJHOc+U?=
 =?us-ascii?Q?Yd1sSARUskJXV7kHzMLmIzgl2hHrp7Ofw/lhi2rImeGsqAkESioiN7GPRB8L?=
 =?us-ascii?Q?Ynk2cONE+EJJJbkKcVrRBvbXcjKIGAXMO+nKrF1zvsG8hYTScbC4rDRceGZ5?=
 =?us-ascii?Q?e53Ta/AV+8D/8frQgYAzlUqENCb/wL+PdqXlDrD9GbBlc+P41RjXGrfmwAx5?=
 =?us-ascii?Q?gRRhpAOyXx+l0bjNDzWg3z0gCBFGevw3LfjYnS5pP7nVFbREqhfHHuE7RVR4?=
 =?us-ascii?Q?mtihC82XYdxKIpYR5vKr4i3z0WvTVpOR7BMRCIB4pWXVMKF2aykQJ8/l2rDf?=
 =?us-ascii?Q?Lih6BpHgFNvjYzF94h8nIEYcGrew6kemwRJGC1pnod70d+0ttxuMcEDOenDO?=
 =?us-ascii?Q?Z9vSqG1nGkGR863LCViCinQfbw23+gEpIJxqqxghDE4nZKAKZSFd93vIfgI3?=
 =?us-ascii?Q?jAWzsHdF/UEJhfnPjgggFe5ajFnNFk3kYOo3f8ciHVxrjZtKQ3kQ5dpgKDjx?=
 =?us-ascii?Q?FqVcPIA4G8sqSG71HlfYrZERm9spBDEPJgJ4B5vPfBjSh3bUhm+TbRuexGtC?=
 =?us-ascii?Q?z0OPngdCDpMJ5tflsfmOf2TBXdSMwxPXLeYIyQ2jrmTDsREl6bYytIS6Hx8T?=
 =?us-ascii?Q?6kSm5LCT+EfjdSikd2BML4jhbq4LguSXBFofKSc/hEzD6cXdm3AEHZ23VkyN?=
 =?us-ascii?Q?KgQ7lAWpYyZUC4acC7itIJArl+9EOD42RtShkr7w4sNAlbjVmPXFIB7slbDr?=
 =?us-ascii?Q?aJZz8AdfzZ6DJCe5rvSCQSxTzUE94uMvUYgLZaswTXDg8tNuDXv/ROCmKUib?=
 =?us-ascii?Q?+nCJbv/gmXM2dTWaUK6iDfWLNtD8wnSY08AO/Xhd+detYHnIdDuBhF/V0M6m?=
 =?us-ascii?Q?KFinqIsAk03qdqopm2vz6Jmnbp7y2dLER+clJ7lr68qjABTxyRThwscyPI7t?=
 =?us-ascii?Q?Rxz8T20wVjFWotxgff06ek2+TtuEcQUwg2PEr+gafKGXUujG9bwnICuIQ9GE?=
 =?us-ascii?Q?7+Ug5j4nL3OXkMiB0cART7kH7KSj2X85aAi5QFeqoCCXUJRm4d9KhsZO/1UD?=
 =?us-ascii?Q?mRixue9101I/BWGmzcAzgQClX8MKY2g6Khe+nbJ1QyMG4ZDCoF306Sunn1lN?=
 =?us-ascii?Q?aQ14aQlVpYBY9YExIecHndHfEjkeol47TF9SZ5MsvTM06KaIZso8mGQt5S9M?=
 =?us-ascii?Q?nvKUDMjRs2D05OWKfpvCVDrlM6sUvRfIeI+XK7h244apHvEpQjnfvPHV18E3?=
 =?us-ascii?Q?dvKbw7O8GTvV4AnMMK62hjy9MF7j0wgV4t5pN+FpF/phS2L7JcCqRbSCjBiG?=
 =?us-ascii?Q?8Fv4RMINQyWXAvNfOelZYwmvDlMv1seUlDRnxvdyB1CRliSpp4mOgEdUI6Du?=
 =?us-ascii?Q?POovgwu7xovZpAFkoFP7i0wGlD5KG+YjHLrGD6x3Wr+R4rYmqWSu0koeD6RX?=
 =?us-ascii?Q?e71IzAKmx5QJnnfIqciIrilQ2LyKgwtCnrrgek604hgzGo7LPV1Dsri/rXHB?=
 =?us-ascii?Q?YCFiEjYohyO6PDHz21XUBVK2yhgWF4YbQYsImvr4WNBNpJGHt4FQbIviEvBW?=
 =?us-ascii?Q?f50zKIU1rl/Hq+nzm3D4BFHDcaHITe6Y/FLUVs6sK2cURNwYpG66nMHbdFzO?=
 =?us-ascii?Q?sk0Xe7ydPmOBxTQ69VNKLdM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 85809edb-f0da-4d81-93c7-08ddffb74a0e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 00:21:24.4561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3RCbnAt3oknyBsuvdUw+6YkO7/DgWKr98eoHw01leJX3qoQEQGOiGv7bVujTb3dNng33yJp1zCWOQJ5it6AbelyfFT7azlahoxuSk/t4s/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11512
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

This aligns spinand_wait() with the linux kernel. Instead of calling into
spi_mem_poll_status() which is not implemented in U-Boot, we code the
polling logic and make sure that schedule() is called periodically.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 47 +++++++++++++++++++++++++++++++------
 include/linux/mtd/spinand.h | 22 +++++++++++++++++
 2 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 34e5ac33c63..3b612bec274 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -32,6 +32,7 @@
 #include <linux/bug.h>
 #include <linux/mtd/spinand.h>
 #include <linux/printk.h>
+#include <linux/delay.h>
 #endif
 
 struct spinand_plat {
@@ -362,21 +363,41 @@ static int spinand_erase_op(struct spinand_device *spinand,
 	return spi_mem_exec_op(spinand->slave, &op);
 }
 
-static int spinand_wait(struct spinand_device *spinand, u8 *s)
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
@@ -418,7 +439,10 @@ static int spinand_reset_op(struct spinand_device *spinand)
 	if (ret)
 		return ret;
 
-	return spinand_wait(spinand, NULL);
+	return spinand_wait(spinand,
+			    SPINAND_RESET_INITIAL_DELAY_US,
+			    SPINAND_RESET_POLL_DELAY_US,
+			    NULL);
 }
 
 static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
@@ -466,7 +490,10 @@ static int spinand_read_page(struct spinand_device *spinand,
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_READ_INITIAL_DELAY_US,
+			   SPINAND_READ_POLL_DELAY_US,
+			   &status);
 	if (ret < 0)
 		return ret;
 
@@ -498,9 +525,12 @@ static int spinand_write_page(struct spinand_device *spinand,
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
@@ -702,7 +732,10 @@ static int spinand_erase(struct nand_device *nand, const struct nand_pos *pos)
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
index 163269313f6..ba6c2ba149d 100644
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
2.51.0

