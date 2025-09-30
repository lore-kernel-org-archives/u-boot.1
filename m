Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2258CAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 00:23:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C09F283677;
	Tue, 30 Sep 2025 02:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="sfszIjpn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D89B6836B8; Tue, 30 Sep 2025 02:21:42 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 049708365C
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 02:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clXNu+dI1scOKNRyCogQ6/MXmDMD5CiM8H/50JbimYXnrtvZE+Qs+F4cmMGBT3TO28EyOAGyNij0WYVv5MXZ1Zt6s3Y3hHemyZdXcR0eVoU8s8f6zRUZMN+JfcIwIG1hKAGOs0fm+E/D9QoEGEmk/tXsl9oFqm13H23RF9tcfqoskPsxrBiAWObxc0Ohx9COjTFKdwBrSrDQvdrzIgVJUiO3PBMpt2Pc1G9FKBOE+pq3PU4IL1FB6Ty5QJD7Wdp8GFwPJfQm9+BaPvxZWwoKaK0xa85I+5op7pa8eEbIlJqT+lRnIJLZDvRlcKhZBRBiyJZKI804p3ng9wVlPm7QqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoEMVbydULZa5Sk3AFgf6+P20WiQm9j3KRU3HNSDjrI=;
 b=Bj2DawGY7I+fBciCRLKGxxw/u/uzJmaAspyCiXS0mHONs0laBu/Bmi2YpEPgc7gnAGqnLSXTchhWzmBPHOXgedvqb9DtGbrSo0qpUP9IjczqxhzQbfxuqzQV0eaewWlgHhfUvFG5iw4/WQ2Vy0PntyN1W/rIvmh3dGM+B3a7gDLn+XUE+YDFX+6lpkJqoAKxvlkOA35cVsUEaU6kkUbQ9+4XSQn13iyjv6pgUWRIWNqKckLM01xqqgwUlGDu1b+qVEY3DPS5V39Y44br+8touDEBXgy4rscL4aX4UYc3PWhm20rS13BVHZ2M0exwXVpJbUbEuKf9XKvcdSyioc1wRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoEMVbydULZa5Sk3AFgf6+P20WiQm9j3KRU3HNSDjrI=;
 b=sfszIjpnxLzhR+RnPQX/YKR4tsi6Wzf52j4GvI9zVdkaNGgd6+2hXf9c1Kidtpv9gc87ohN52Flj18eIlgo1KxCrn+UBKDw29ai+EuX8Oe8LyR0w9FCZjYccl+m8awzMtmu1+Ih02RK9QDIrHBm0/NWQvtEAAE7dTVUc8jC9w7iB0CvDTdtK4YwQH0nIvgVBD+K7jjI4NEQTEH3ohIgUDOhXD/d/aOsEASz8lpKF/Wf0IzONnInV1SujW1/vxVhJeHaACnXU+4gBpFOCWryMK67bZsGdMx0xXxkXsy9WaA+OBq1ZBqGd36eww/7N9sxxh5Y/D1DeJydMmtfHXUT2rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB11512.eurprd08.prod.outlook.com (2603:10a6:102:50a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 00:21:37 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 00:21:37 +0000
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
Subject: [PATCH v7 12/24] mtd: spinand: Add support for setting plane select
 bits
Date: Tue, 30 Sep 2025 03:20:57 +0300
Message-ID: <20250930002109.3600886-13-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: d92b84bd-04df-4ddd-5ffa-08ddffb74f54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XLZtLJY0wwdbOLvY+KgU7wVlgmmmn96V5CIrwkoSza9nifAK+5TArYx1YcrD?=
 =?us-ascii?Q?qTEGfPJH/llgLnCICks1wkKKY7Sf+04oiTAKD6jbMFx3tt9BrOUbGzj9TxoD?=
 =?us-ascii?Q?5OcGO4w5E+fhJAaDOVwK71bTHrRbJzF17ItkqmySHVO0dIwE0a/mrYcQ3D9u?=
 =?us-ascii?Q?zfKZ9DkmPxcoqiYvVtpMVmRla8/SNJEsbIlkKy5wfC6xonJ0GWCRNPz42d6K?=
 =?us-ascii?Q?DrODAoG1rxoszuExy1iA9rATkDH8msjabFUdKoDkvi7UsUX9m1rySfgGuWaE?=
 =?us-ascii?Q?FZ7QNpbGuqxBW3wSUwyf2LEsY86O8xoSTx7IDhch6Ozydp+TLgWXLztLkfdf?=
 =?us-ascii?Q?c4+B8TAOLANQjTffOIF/2Apd3R3/GBC1XsZ3TPbN7iLVO8+5w4gyOrlbuQDD?=
 =?us-ascii?Q?29M1c8OGXs/Kgugz9MZlaO2+FRKma/DRO3od3O724kM3LxJcjV2ORw5rF49y?=
 =?us-ascii?Q?s/ojKXTb0DBADgewgLwViWzhgDMig2t3MNYYgSLZ4Q4WfGMclTwnRenIBGYx?=
 =?us-ascii?Q?+mfAPZcnSuErlJdlJzHxUoCmx1z9xwUxQX/Kn4Wmobsl6iubJE6gO9FfxBlL?=
 =?us-ascii?Q?jqqJdKFAver85iBlkszVchH1rDDwPdJM6bIVPCcVx4l6DFrzdm5Xszyrem69?=
 =?us-ascii?Q?R9xMfxQvKwg6zeFFzFdP+TjlxNHXxrgTfAK+3agV7ZB5Uncf2y7D0o7MgS2l?=
 =?us-ascii?Q?01e6tHjv72UuS9n/ht5LqRYMK21EgAIOO5GkjZkO/vY8TZTvlMF3ctWEXSbJ?=
 =?us-ascii?Q?/adIJglO9WlIOf+2yopqiOvIdJihccQKe5aj9+3MXUd+XX7IltvbSWFPXfTI?=
 =?us-ascii?Q?eYYCdbydmYZ00pkv0fI4IxO5HT0ENq2S9Pfx6/niSOI0+aGCSjJ7CWEuQbhN?=
 =?us-ascii?Q?bWqgOOCMpahK1ahkw/01LKZEpOLa0fhYz8ORlnSODsiQkzNyRYsP41QGKIwX?=
 =?us-ascii?Q?4I6Zpg/hOKQ1rZOpS8NlBkyCtI/kEFZPJfeXWeLeh2vcDtnTONOvSQ5776rp?=
 =?us-ascii?Q?HWehza4pikjXYmptP+vOMYxCA96Y22T1/jjoPMYt8ua2sTjySsZnpumO+mmy?=
 =?us-ascii?Q?oMJtv1Hli6Gl5EHfhFQgQGIdpYPrH/YAqL9HdKSxufJEyY04CSx6sFaqOz9C?=
 =?us-ascii?Q?YjEMqKNT1jefmFCWHwuzZ98M5VKcFLfM5aKN7tu37lwEOkJ3jmERxNunzJE7?=
 =?us-ascii?Q?Lt0GIyaoYrA8F/gFPSNqCJDQ8MmlHWYEu+bdX9z4w54WLeaQezyT+MPWUBhJ?=
 =?us-ascii?Q?PKKT/pqgPmg47d167uKp1VASk6zTcA144zLGRnRk9p0aYnO8nzXmuXGOI6it?=
 =?us-ascii?Q?P3aN7vUbcjFADeB5CeqUtAt/zKWwOuLyfhtAA7JSojorNp9EHrh6FS9e3ASz?=
 =?us-ascii?Q?NGbMOli/j+BpQMdOelTj6+rmun4kX84b7dP6E+r3p234YCAAMoxLstm05Wqn?=
 =?us-ascii?Q?XtRZ32Vv/k8+CQ3ksKNqzQN+Gxb73B/gynUFmqjPcO7CfF/M1Gm1kHGRBPaP?=
 =?us-ascii?Q?zJvIXIBVuuQBLKNXxWC3P5QB6AvWLtHQmHAV6HglTk0WkiaAll4BCk5NZg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ovkgajxi24M/F4kuBufrCu8Yg37MZuhiZEQ9Yp2Opki2atkVQ3kJ3odFeVdV?=
 =?us-ascii?Q?xGcUp09s7OHF7TPG+h4/3kiibTZorvR8Pqlu91F3q2bV6nPNN/YFtg9g2Ysc?=
 =?us-ascii?Q?lr17uII1uvYES3O0tHXZ0Wxc2IXSu8x/0qDJ26AmcrngxIgggi9cpjFaPoXI?=
 =?us-ascii?Q?U0i6Q0XXbtfrkaZEIHa7zm7m0QhTSdtk1lpYex6rqz23IHr+XI4nlHZF2N4E?=
 =?us-ascii?Q?hZAN+KYMcWDIeStcgEH4PltXL6Dv8PgrxNDzfVnR09ivHBoyVV8g2Cvtt/Fo?=
 =?us-ascii?Q?fJ8jQoOGHbcleLG8Zj95GXM0Mm/ej0mYG0kUrVYWhY/XYez5GZ/6924s3DUa?=
 =?us-ascii?Q?k5a+qVvXOE+j8U8yDZJ5L88yY3ufkbd8m+NAYnIe6bIfvTftOTOhtcaDbURn?=
 =?us-ascii?Q?hSLgU8ZjXn/6tU2lCXBhF728FnMg3SNgn/mhG4VDWGj0QK3oCY0cHKXSvWKt?=
 =?us-ascii?Q?T6C1q0n4McSKYVI3uD9XhKWEXhFg5znFM4ZmkjylwKwrDHz+HNKsyDLotOeL?=
 =?us-ascii?Q?fKPoCbOFhdN/h5GygudB4gJqve2OJ3JvDi7S9qkt5ue1Rs477zxWfz3Ry4hm?=
 =?us-ascii?Q?VfK95/s4MhRrCrgIOK0p0xgL6GT1lHloU6dIeBTCNx44OzrfoJ7s8VLmiWpf?=
 =?us-ascii?Q?KRM0y2kttV0Uzqxsve6Qxa5QE7NEiUoS19eikYe0+svwkxtqYN4GtJJNw5gR?=
 =?us-ascii?Q?QsK8foUMS4k97Ju6MTxnwLA/S71JRYJmM1GvhrdrgTB8sis2DZ+5Uxxxo+9G?=
 =?us-ascii?Q?aGJO7StuhBr4msSgBepz0YbyIbHz7tMIwh75v0K6+K+432Xbss40MrDWy95u?=
 =?us-ascii?Q?R3G6YL4QUFX8LVfsFr38e/bOVscLx01Cc4w0wamdANdIKIkN1CL8B+RNg/yb?=
 =?us-ascii?Q?s6lpda0V8h4UieszG911S83+7WB5HYbbqo0YtDTJvNTZlBvwasHLxJkykXu5?=
 =?us-ascii?Q?OpviAKZMJbhUJUp0/fWMmIKW/GB01KjD+bVCdVj2vYotd/svGUwZ7c93TGJH?=
 =?us-ascii?Q?wiGTQfuetIetZt1fLLgFPsNl6raYJNwnN+tc1ukyPhVUd76DX6GWEN8XJWLz?=
 =?us-ascii?Q?/yi7vzZkerbUwiU/nlQAAkAsZOjrZpAabdj4e/a+GKpiIRXv+n1XxwJH86+W?=
 =?us-ascii?Q?xH4wtCiDEnxxw1LC1/1zqUktRM+yAIKtQRYGsnfwczJNTcBChpq3lOXW3WK7?=
 =?us-ascii?Q?6YCyyKR+/yRwxEOrd1ye+syU2awhCDXRZs+PzbiNB+rccJhQHQKjeYvN4Xea?=
 =?us-ascii?Q?VuzVmpkQ8h0k4ubBBiUWSImQEyPVnyYJX5GKs9prFbr5cpzI3Q5Gw+RkO0me?=
 =?us-ascii?Q?eVkggjVrQaQV3u1GNahbPuM5ZSipnti+gAM+Ls7XE+A11dvSWlcwsBKKAp+u?=
 =?us-ascii?Q?U+FnfGbB42LgFYFtWZKBnsjsrc+l+yofYvRExTtg2cNSB402ELz6ZRB3Iyiq?=
 =?us-ascii?Q?H5HpOiQtMUm9npHwYMk1HmV3BCSkuLY4Jw3cqSj75b3Od6dMkfnh2TJcA3z1?=
 =?us-ascii?Q?Ne221diwyeUHAioLkh6SOpUi2H7KoxlK4zAyiaSAMdgGUPfUmTNR+fe2FH/B?=
 =?us-ascii?Q?FX/A8kPWmmFRJ6lA9JJd17xmfREB62P3sdmKbi4vOAmvq7JEo+h6gdCY9htK?=
 =?us-ascii?Q?TKYvMKSFult9CMZFh5F9XlQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d92b84bd-04df-4ddd-5ffa-08ddffb74f54
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 00:21:33.2978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtoHIzTm3iLRgk4wEmAQyGzyy+Yzjod5Br7LB7OI9i7xObVPeJhCA/ZT9cflg3sWiFeSZgGRZBEAQmTOQDTSd0o98U44oGnst7LW+Sg8cmo=
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

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

Add two flags for inserting the Plane Select bit into the column
address during the write_to_cache and the read_from_cache operation.

Add the SPINAND_HAS_PROG_PLANE_SELECT_BIT flag for serial NAND flash
that require inserting the Plane Select bit into the column address
during the write_to_cache operation.

Add the SPINAND_HAS_READ_PLANE_SELECT_BIT flag for serial NAND flash
that require inserting the Plane Select bit into the column address
during the read_from_cache operation.

This is a port of linux commit
ca229bdbef29 (mtd: spinand: Add support for setting plane select bits)

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20240909092643.2434479-2-linchengming884@gmail.com
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 6 ++++++
 include/linux/mtd/spinand.h | 6 ++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 2a2ab664c2c..2083e3673cc 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -382,6 +382,9 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 	else
 		rdesc = spinand->dirmaps[req->pos.plane].rdesc_ecc;
 
+	if (spinand->flags & SPINAND_HAS_READ_PLANE_SELECT_BIT)
+		column |= req->pos.plane << fls(nanddev_page_size(nand));
+
 	while (nbytes) {
 		ret = spi_mem_dirmap_read(rdesc, column, nbytes, buf);
 		if (ret < 0)
@@ -456,6 +459,9 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 	else
 		wdesc = spinand->dirmaps[req->pos.plane].wdesc_ecc;
 
+	if (spinand->flags & SPINAND_HAS_PROG_PLANE_SELECT_BIT)
+		column |= req->pos.plane << fls(nanddev_page_size(nand));
+
 	while (nbytes) {
 		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
 		if (ret < 0)
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 011861dd059..fb3a2e5d909 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -316,8 +316,10 @@ struct spinand_ecc_info {
 	const struct mtd_ooblayout_ops *ooblayout;
 };
 
-#define SPINAND_HAS_QE_BIT		BIT(0)
-#define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
+#define SPINAND_HAS_QE_BIT			BIT(0)
+#define SPINAND_HAS_CR_FEAT_BIT			BIT(1)
+#define SPINAND_HAS_PROG_PLANE_SELECT_BIT	BIT(2)
+#define SPINAND_HAS_READ_PLANE_SELECT_BIT	BIT(3)
 
 /**
  * struct spinand_info - Structure used to describe SPI NAND chips
-- 
2.51.0

