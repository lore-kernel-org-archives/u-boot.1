Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A11C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 08:15:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07A968414E;
	Tue,  5 Aug 2025 10:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="kSTzZnGZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14D9B8414E; Tue,  5 Aug 2025 10:15:31 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A3B5831E0
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 10:15:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWxiXZeZRGX09nUBqLM31AORQQQKWDRmX20l/1qgCI000Yq3YVF382AViW2INm+atS/ci1rqckDnPdhQ8XwRkwsWt6JJ/Goim3ZuANG+rU/elYMZuTPsrDuUALb69NIzufWVNcfpOxoabOmJXiCSIDHgRVrKi38SoyZYToNCVjJaC8ppjCpA2CJ7NYXK2aNE2tmeCL3nzceB41M/3l3ltWMywbxlNhmxoEZhBXFGd4MvkD0xyBECIL2yf/HdnW0jm3Dsex+Qkwhy2owp3iZ8ADLYkZJmGZ54+vgL6bskwStq3rLeQctnSJJKowsvAnTytQTyFB5skWTP9hsFEiy9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1R7/HdGxcHN9tyqmnSAnN0YngE41MJHZzqx/ObJP+5c=;
 b=iiPKOwzqzhSa8UBS2TYAwQZG+75XcJyUM5yoIcNq9dE4ExLamf/jmBpAPtngsY3C8owYyG8wwVmhask/SVg4Q8HUg0cO7oT9dzFcAxHurscFkoBe7pcCUhVMeiM/vc/ozsVMHZ5rEBnxY0KQZ3VMW430jEEHPulM/FkaSE38dESw7hN1VXLU4qunvWn6yyXryK96V/bqG70nvxfscZTZBLXnC+juHF0jZ6IMOrgopNQWZIWtVtnXPrQmVeI7Ri/BOmHXk5UpU0KVmapEPfIhPDvFCuMr9T8etBki8rpNjVO1QixCzoFcPUeKF0PVW/9KqXFIPHnlIfVW0NmsxBOXSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1R7/HdGxcHN9tyqmnSAnN0YngE41MJHZzqx/ObJP+5c=;
 b=kSTzZnGZuO68QLTd4JEuQKj2Wwz12SxeNFxOAnOIeT+/ACQbpzwiycaNhwS0Xy61tNcWiyiSXCD76YT9iKT+8bHzc7pvzdcW3F+mdeIzRrydRYewptOyy0Z7WiJyQJzelr8CBC8y8thvBe9pei7m6FkEWIuCgqMopBU0BwYk2IR64m/PD43MOP4JqE1WaSnLwAqWujxkaWJzGNhOiIRW9qda1Ue/JVETI4TyU2M9KWEl12RxN1xrpmcE13cPnTcC1+9lOUb43cRN+tG/6Gqv91H5F/zwsnum5pkccr7RlA47Ri7M3hsFraAmDepqdFLEeuEr1QazaHxsBXAqNzI+Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB11074.eurprd08.prod.outlook.com (2603:10a6:150:1ed::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 08:15:23 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:15:23 +0000
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
Subject: [PATCH v3 03/22] mtd: spinand: Add a NAND page I/O request type
Date: Tue,  5 Aug 2025 11:14:52 +0300
Message-ID: <20250805081511.1482964-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0902CA0059.eurprd09.prod.outlook.com
 (2603:10a6:7:15::48) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB11074:EE_
X-MS-Office365-Filtering-Correlation-Id: c5518b45-7fad-40a8-e95f-08ddd3f83a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8LTYG9WB4mcdsuB0V7tNTZk+7zRDQPyJ5a3UArFzvZBlipESGuNS8f/yBODG?=
 =?us-ascii?Q?HcA9t2WRXlhG61M2ODGh6MW4cAOiAwS2tvvb+Vj8hwiwgLU/HsF7zxCInuhG?=
 =?us-ascii?Q?2Y+4JQKmNGQ0PuW8p/crHsyJ0mehOWM7uF0BQ5ySgShYpi6AwermjAphy5rJ?=
 =?us-ascii?Q?8hJSDgbWxvIH0sPNmaPouVDeBIv/MtYbDGdD0j0ZGGvhNboLEkbQBlkItMj6?=
 =?us-ascii?Q?TzVyTXrRi71CvWw1tlY3UVquCCV9v7fKSkuqCyKIaf2Abk0pzHk7Vsa9eqtt?=
 =?us-ascii?Q?ZIMI5tamNecH/Uax6wTfrGTQpzboZcYKHMv/9i31QMbGhnPYuzv7pTvewJUL?=
 =?us-ascii?Q?ExYwWLsTkGHb+FXmnAaE2pcCxUUVAAR9sA0t5bS9vhHFZ2dXCn+tSeFokaYo?=
 =?us-ascii?Q?KacwRmaj+ZRdM4pvmqzdA/DDNQMO+azWeuBIXfbFyljnKZ17H5zmYU6nvPBo?=
 =?us-ascii?Q?dlgno+F6p/loYtrNu4/q6G7JGz603C0qY18XEvhKrRhUAwlz90QzAB3KPB/j?=
 =?us-ascii?Q?QeyAbGwz6l5mfko+JH4+wVdTCeAuojBIafMhafYGUUfUhnjNW96AlM9dJ1ei?=
 =?us-ascii?Q?PcP/WYYqt/J9hAdek+NIEfY1q6NH6LvsUTJe2P7MUaXrYNHQNkatIrNczvzr?=
 =?us-ascii?Q?bkoloc7G+Tj88+dHJB2mFsOhjGgybtDaJd+fIDMxwZBZZOe5SMMMIh6hmnB4?=
 =?us-ascii?Q?+ZtlBK7xtfJ9Sl1LW/OUhnX9kqtsj+TK5p+9cc0aSISEDOY77DO4FTc9TwU1?=
 =?us-ascii?Q?8Mw03m60XtP3s8sacOS6O5aBuoYH7t6Uq6ziWoe+CviQFz9So3m9PSvFsvfV?=
 =?us-ascii?Q?DSqndbjf24Zv9cuKOZJqMJnKjk919J3z+VOtgnhaA8OFjxJwypnHf1m+IpkJ?=
 =?us-ascii?Q?O2IhCIMFl/djsLfs4gjPaYyG2LTn5szumplOCRL2dN/YtjDC1+eBFgaBa9Re?=
 =?us-ascii?Q?KnlQz/SIw2HhIqXcZn8GyGMAGizlRx3WqHfENC47bYm6wYJd6EdsZYeXE4jY?=
 =?us-ascii?Q?zTkrBrjxut2ulMyMQkI5mVTS9H+OWpIZHhXBSj+e5EeIsntO1i/uqakknWpa?=
 =?us-ascii?Q?5rCzEdixJEJTIXisp4wudLNyI0SYzJLwaCFEC0P/8T3HE2ODGbMmT0hGdf5E?=
 =?us-ascii?Q?x/xMk1HE44wYw2uXE77r/2z0CU2voVrguNGvGXtaYTXlnje4RgO/rWIr0jT9?=
 =?us-ascii?Q?nx69EbZINvPqY5KPN2Paf2WLDyvtwp1fjTLY9W9KsirZ6fc8Vw8n1hZ3cnRv?=
 =?us-ascii?Q?j7XV654cKn8sgcCH/uaygClhFj3gNHB7Vc//GC6VAR+LSoT22C5stqAgUmgE?=
 =?us-ascii?Q?OMMekhMDJ9GYifNnooQRv5POCc8NnEhezh71hFTxbLdTEm+kuRYf8iND6af7?=
 =?us-ascii?Q?KB24VvLB+uvud2WLqC1UF6egqGSjpNJPHdri5aelCmj4dv5WNE3AbBDzde0K?=
 =?us-ascii?Q?ADK5NWXaLlXH7K6a7csM6PcuJoIPVpdWnmtGk4jNRk1UVV7SJ4GTymCdvkCU?=
 =?us-ascii?Q?oI2W2llDGhmiAq4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ATJpjrAq+oWoqRBngNxAAd+7HISk72oDEYBP7IGvqpmSFrpslHqROad/ThF2?=
 =?us-ascii?Q?NpnIqCE2Xf+EeXkS4iSlstBFsrWAMEhWgEYIeCFYLcVLzAXaPlsKrnvBhypg?=
 =?us-ascii?Q?9yYd6JUXWgEk1JNIKk4jB+7PbJ/gaWG0P/PMQlW/blssbnYTAfGmjKefU6kH?=
 =?us-ascii?Q?72tzDbV+ChlmgKlsVRDl/FdHWhoCdWz4xjVADZkNDmwKvx55YR1rQOa2QOmn?=
 =?us-ascii?Q?t5+Xy1rEayFwZkO9tVwGng3DKOBmSXhbnVVe+lMMJIttu58bxLbVwH0NPwVP?=
 =?us-ascii?Q?fBI3hhzLdhHhH1BIk9X4rlS6fLiDEZR+StRhIJHEa0xMsDcFCTiq5308gIad?=
 =?us-ascii?Q?OBZ+Yj6vNnr99xVfcGVSEZ6Ok1K0Fkj+RVck8xkCt1grzawvXHFnOWkuHBgb?=
 =?us-ascii?Q?s0J729MTGCivvVFtig/dumOj4TmH9uLwR2q692Hlk9TN8YscMALT1IZUq/HT?=
 =?us-ascii?Q?wE+p1r/eLYVg2YUWQU2ElNPmBKIdkTYppg/r7aez2gZ7c1GTFERm0G9u9uXV?=
 =?us-ascii?Q?yj+Zhmcaw6o7ZLrMKrotMMNFx6ErsJ7BDbv6rB4U3i37wNiO4eOhvsGY7tgh?=
 =?us-ascii?Q?udEiRlmTd6vEx4LEpN5xOpbKagWJfC5r5L868rBpgJuu0s+eWrUbI9L/f6+8?=
 =?us-ascii?Q?Zj8zRPMDR4MjhDNXtOOivF8rJaMwU4ZWTxuh5p1VORcLPuyiCHV4TTAAVr9z?=
 =?us-ascii?Q?EEzOJvwVrLaEma6/c06aFlmtj3jITWT5o1zlVx/tpyTtyVQg9p4V0hOrBXCo?=
 =?us-ascii?Q?iL7t1fVRxS1uvK55NNfMdndKxpP42EZIoNihDWWeUb7kagzJNHPKvWuPhGna?=
 =?us-ascii?Q?1kYAbwzrzppRF3TVeHBPGyabUkRTmBjA4JVoaZxGvmo7i7mzxEw0Kp9cjy3P?=
 =?us-ascii?Q?JvrwQWRROgRJxCRHMTyTVsXbJVHOLwIrXUpw03e2BhuxW9ncWPwDbOGkuRO0?=
 =?us-ascii?Q?Z2CIV/W5xjvfgmsx6Mgr9+ZJb2/Z7Ucl0NOjKo7hP2CT5RUsBWY8MYk5Bo0q?=
 =?us-ascii?Q?ixts63k03xBsErDpQlJGLDDQW6pXRSsr0mdOtQqHJ0V7MbQtPcBpCKJLYtgZ?=
 =?us-ascii?Q?y1CRhDk9fGlfG2Ox7q20leJXT1sczq4SpWVpgWcd+QHAZnD/JtaI/n5kEkyW?=
 =?us-ascii?Q?lXOb5HLkQrbqI++g051DBiWmRe7RImXctAWkuY9SqNRp0N2bGv9fzKA0iL2n?=
 =?us-ascii?Q?c9gIPwZjWdcoa6xmzPoxlrWXBxgrdmpHMgRlS3ugZ6uf+Py1bK8GovciBCvK?=
 =?us-ascii?Q?RWBKz3T3tg0NbRzJjFtPONDD5vo/HiuJG7ZrY60mCKNBNChWkQyJ+R3YjBCu?=
 =?us-ascii?Q?/ir3vm/9p61QbyCQe3U3DdtGyovhvdWIDyyt4CnPJ3JGrDmlStJASjQRqhiN?=
 =?us-ascii?Q?ogNxhKZCLRArbJxBttWuuLHCtHkbvZKN5oT30gw1hDoY8rTv8mqpFhQlitzq?=
 =?us-ascii?Q?JwhTAGwenUJlPqp3YUrP430nsFP3J7aBlXCQE7jk1kWJ1XvQcO+CWHugRec/?=
 =?us-ascii?Q?3ACa+qcx88BneV3HTPCVdkVm2Ye7t0DOCMpSzwCvtAZ5pVtVsZvG7s96bmfE?=
 =?us-ascii?Q?KCWf+L9ec+qjIF8DsCHjkKHhZD+taB5kHvQseRkSXY2tKqMjSBiJlpOvEMlV?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c5518b45-7fad-40a8-e95f-08ddd3f83a18
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:15:23.8609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbko6jQlxz+MS9tLPnkT6b4D+DRRxgnqNRFlTh4QU+bndGUT/4AlJacns/jhpySQ5wL3kEnMKnicF+xSzGUeaxjzegw4RbGjEbrwr4EKEaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11074
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
(mtd: nand: Add a NAND page I/O request type)
created by Miquel Raynal <miquel.raynal@bootlin.com>

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c |  4 ++--
 include/linux/mtd/nand.h    | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index c1b8b9627f2..d8abd03e919 100644
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
2.47.2

