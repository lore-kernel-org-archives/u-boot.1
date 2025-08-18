Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BB0CA0EC6
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:08:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9711A801DD;
	Mon, 18 Aug 2025 12:06:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="QAV+oubU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34C9682A53; Mon, 18 Aug 2025 12:06:48 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0072980194
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:06:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPcjfMa0LfRuVovi4UAJV/C2qUkMKTdF+kOTs83qB/ol4f46X26Ja3hSWN1Q3v1bzNPnzu+jY/ffqgVQ6H9KZnspweaUFXV1ExQUcgBkW0iEbuFUVwjjVBriocof2wEXy4gmrFgJAOpuBrkJ505j+Au0jzRMVM03xwW+ZNkDqCvxNMzBuG/iw5z9i9Nv18MBrZmzZB/eywx/Wpmdqfejo/HjZgQhaO9GPYrRRKyGAW7ZmY2Xd/7yP4a47CsIrWsOA5volKhhKjr1Cg13wdJN8Lg9jtc41X/ohK8Ko5RirutOlnCxaclWVgTG9dGPFLMItbG9778caePLEPBaQ1N8uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FlDAFA2IaCouOf2suuP3Pv8DTMuyJbOBeo0I4w3QAg=;
 b=tM6dmNLUZMu8UZCyAchO4i9ys/1nSvPWKUaC6M6H3V5HCjPw3CjtSVv+LdTGykz2xSC+1qqJxVtRmkfydmA+wpSwKhZhwS+uWzqTcxeMZUdD/laeHEaCTvRK/qQC5sNPOC1vjiJC+5w/8jNZCoFVJbxA6tU8IvObsjX308KskcHVRAIvC0xId5lHKeqEMzvmUttWhSHSo2N1/PYw83u28G8fUXHAR9VQ73qWowFrdnShq+6fzRemgToewFBCIgU9M3rCBygzPq7Ws6LbTRj0b7766Bb5lqgRn/OTPmGGa9pTFRkgaXhBYQJJXS0fkTQhBtklesdXVd+6mNIl9mNIvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FlDAFA2IaCouOf2suuP3Pv8DTMuyJbOBeo0I4w3QAg=;
 b=QAV+oubUPY9OnKxQU+1ks1FNobiSP500bzuDMsmmFxxXv1Xz9hiT1MQfNmS6eYhrTIlBufIlWWI3CwKhJRsMX7IjYxCEKtPSFTXQyWLkMDjCIEM9cuS/5XWj4clvK4WXFLkZWKA5QOvJoUufGhctwg5gLinaZd03SericE03hubrXHloMkXsQ+wzfMTsASQQjj1i4Bl8cfUgmh56DPF5SUcc5wr4uQKJAxaipH15Ilo9nGqWjHcUFzIi6Wz8ess5s7Qt0zHCZfUwP9NB4LrsprG33uiSL5ctHVRKhQlq1RNpKhfZttac9rVDxzNYH8AfCk6h9BtsEeGBvbykaCGIzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9719.eurprd08.prod.outlook.com (2603:10a6:20b:615::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:06:42 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 10:06:42 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v6 12/21] mtd: spinand: Add support for setting plane select
 bits
Date: Mon, 18 Aug 2025 13:06:04 +0300
Message-ID: <20250818100614.432931-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E2E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9719:EE_
X-MS-Office365-Filtering-Correlation-Id: 584b51a6-5dfd-413d-86e8-08ddde3eee43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m3pySTYf8EloIq9NX9ykTu6BrBh1FFk/HKCGbcVk35v4ckYYh/MqgCdBrsAg?=
 =?us-ascii?Q?QdgjMnK+ip5G+5BRuqX9nCkNING/b3Ap5eE08dLf/XUtRhZj5L6RZ70X3dw8?=
 =?us-ascii?Q?Z9DHyY7xfOq+I308ZFeTNRhYBBeGDkQUNhQlnaecYp33f4/DCTNnJeXhqSPJ?=
 =?us-ascii?Q?09koaxy/GS46WWgMsXAIvsQhckeykDyXA2lUTS2qkmEmP+38kcx+KjKhVcnd?=
 =?us-ascii?Q?dlDvml3rOTUJixa83nwHHWVvVl/msXmlHlxtY34/BCDcy9JHbGahrqxNmWET?=
 =?us-ascii?Q?6PHNrds86Flqv5CnaSL1wlRKHOipVsHzxuL2L2yAOreD9R7r7eCS0tLYZUoH?=
 =?us-ascii?Q?dQC1KjMUCWP9uXQ+3M86tHvK8PEQ58tE2cGygD0p0/P1iA7+3+yPBCcD9Ccy?=
 =?us-ascii?Q?9BKeK5xt+LoNdTjqGdPV6gsHmzsYXpT90wKH/iJye9gUDz4MxZp6HtIRa2kd?=
 =?us-ascii?Q?UBJ2mHtwlKQ6KXaf03l8F0RjXatz158L0e/zavpE3heET8ZVPntqMWv08Quf?=
 =?us-ascii?Q?DGUjNnFWT8Z2iQXYnaUULxx8uqjTuleOZh479mBtNt5halisEU+1gx9/uDi2?=
 =?us-ascii?Q?tZNzpvQCdQ7Mc1v3F+X0mZKx5zRDERmBEDcL9ViZZWjT3TL9CVKdDuIY3Yvj?=
 =?us-ascii?Q?2cyV1ufhwY/rbf2wvaNftcxAl9yeRmR7nUboErDRerDWCzsB4pdPSJ8bhp9U?=
 =?us-ascii?Q?E65TaYi5uEiChTQyBKXTNWlZnSUH7mGGZuDnEZdr/BCwInhvqZqUtqd0MWGc?=
 =?us-ascii?Q?h+nQMX/FsHPJ59gZgQ2eVPKx7AXkU86SvsfceuxlLq1P1j5V+M0lKdQI3fOP?=
 =?us-ascii?Q?V7yLhh+tZvbni0Ab7kUJaTN4mIgZwYsmbhhLqvjWrCXPm+zuwYmwJD0sGxVj?=
 =?us-ascii?Q?AbOsNA96HsMkJN7pG5/Qge4H7EL4HDVjpZ0wn8I2yw81beJhJ368qO6KCkMW?=
 =?us-ascii?Q?A/FTX0rNQwQGxWHOaWxSF0obiSqj59JDWjr89gPj7XQYmSac5Dm6ydENSFBt?=
 =?us-ascii?Q?1eFJ1blfhhk092U6SOgXKv7qTXFWjWFNflj+ah3xSnz0w8oa8xD17YICQGKG?=
 =?us-ascii?Q?f56sVgFYF1sup9YGjANozjnr1WEyTlxrXokVUBu0WtTWdi0is06XKdlX0LOJ?=
 =?us-ascii?Q?BxUbicE4ZW/TR4qHBAN9/DMOt5x7Yn/5V7Mni4NaKOFwxStkdSVk4kkcx+DL?=
 =?us-ascii?Q?XocIW0IbViO+ZpnXENJzXsWS8VCfiOHG7WtO7fT3AfQO4A5upI3TXmLN8sui?=
 =?us-ascii?Q?xsZKt7YsjZ2S3bbALhKzZqukhEp5ctTLhQNQHmsP2Ue4Lw8bf+w0gc7LK1hy?=
 =?us-ascii?Q?GRYnWg8eHadurvrT8cfOsuLy/rkgq6dvigZY27SETbVqNq2IRZfdIAtsKKgj?=
 =?us-ascii?Q?xWvLRSXQT9A4ktORHwYEVFTXqAV5BEhnyMimrMjAGlwSvPzq5Mgqca+N67gr?=
 =?us-ascii?Q?J3JGInGm7XzkRUYBV7o+CFXa1lbzULCyF7D/E/DdemLk79gxxCDsCc4gnykT?=
 =?us-ascii?Q?qWdhFAXPJ+VHw4M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rVmv5tfOAgvsOJHiNzKZncc4WOg8BjiXdlnKXiJj720eQXay0EurxHwmgtd6?=
 =?us-ascii?Q?bIK2qCYsHUT2Kg8eZybJZKXuqZx6ksEVfFwcJxrtXarycG9e+3gk9N8CLxK5?=
 =?us-ascii?Q?dyWiq5sJzrjk25Ea4n3iZrJRrid7UQEXE56DFIlTQBYDXw7JA3T1uHzLlCSR?=
 =?us-ascii?Q?afhp8FgQJlS4YyGmH12jc3mzl7JjCKkjLFeRSqnP8JeBQpA23p2WpV85UK/l?=
 =?us-ascii?Q?pRjWU4OLq+TwiXrHghQasX6Hhe6Wn6LctOArU4V9RLnlQtZPIgOMr9ADBGlI?=
 =?us-ascii?Q?eQhBl+yqGMkEktbypcXfl8adHi1qXbl6k2BS5p0Ntpm+mh+q2WUer4nldCfZ?=
 =?us-ascii?Q?6bU+G58gX71ZG8GeDX2zTX3Y/mnsIWk9qDIBjk26ZNY+4bDq6+4CUZR/Vmyb?=
 =?us-ascii?Q?K0f5+GeYYzMQ+LDeJtv42rMzNwgeY9ONaqtqbn9VPjl6pkQDMP8bFt7Awn6n?=
 =?us-ascii?Q?JF/vlwysP2M5QTxusKiJ3pnK+0BZG2W3P6kR9wohqb2UcaG7hQH6JVa9sJMy?=
 =?us-ascii?Q?/5+C5z/csef1DQFm7TsNspdHRqD3c0Gs7mwAfIwjLQ3lTPPOQExrsjVWK9Kn?=
 =?us-ascii?Q?mz7nT/29nRji+E8kXxZZpBjTcwbcloe9Yrpst2RBPKTmG5Rguf0K/oHpyGdN?=
 =?us-ascii?Q?4Xqdzcm9PKONkslAjniLYN2vzjwtfHS6t12jlfd8ei3+DPsA1XTnwCBIVErk?=
 =?us-ascii?Q?kI6ykNBb8LwELuuZkn0L6sOW9uGdBK+MMOFG43I6cctHPfn1Dh/VuaGupMcx?=
 =?us-ascii?Q?xcdi5KNjRUphCcWE4HXiLYEWf6NO/YddxEbBQ1cgjY/Si5OI3MhhCo2+s5So?=
 =?us-ascii?Q?lmNymVIZrPEarlPNVRw95wWHXtynCRN2ZGrMYhFrPOsoFJe8ZZOI6V03UbsA?=
 =?us-ascii?Q?Hu/tlMmUUNSmr/b1FFwV6mw8eovXLWwF0uwU55Y0vg7yf2BbDT3KJV+QFCp4?=
 =?us-ascii?Q?MJX8rjanBzSv/N8HGJ7L8yvNHPucWWguF5i4I/UmDYH4gBzpikrgrBdTCxD4?=
 =?us-ascii?Q?MSrlt3xvHexORiMbQXw8lq9QFGzk9JB02zq68QiIQ3UoypqWLvkXJbaQvAG9?=
 =?us-ascii?Q?XVA7FODMdgFaqJjuzhrWf/8QtzHnjrpejpgsWnvyVyAD60CfAMIIOHYr+Dbx?=
 =?us-ascii?Q?hkmwjk3AywMx77oeCY27HdNlhvlN9YO2ZImJzaBoQfFMKIZphDxnYVuAJNPw?=
 =?us-ascii?Q?sD+cBISPfSlSbk5siZHtTyl9HBXhjlLUWZf160widZLIKxJWX1XY+JjZAeDc?=
 =?us-ascii?Q?6tsOlgJlkcZnHELuN4nEnPNOvLWJwV4wI5OI7TjH7YuimqEgvQ0SqVu65z4q?=
 =?us-ascii?Q?jJSbCqgiiS8nbSkaX2V2YDAsMyniBg9b4IYgPNdc9Ua+MCKD2Bb+pK1jW/rF?=
 =?us-ascii?Q?0QqEjnrhmYlbjiJqTtEBJ9XwefHDHGIVNTtJAr0LqV2AjZShFWD69oTxxu14?=
 =?us-ascii?Q?3PzxHas3lPUfDbzS0nYe2C4LuDpNg31/jVStIIQwccpu/o5LTy7RPlnRAAqB?=
 =?us-ascii?Q?TNXdhZLiVqAcZa6l9UxdUT5G2enTZOkb/5PGr9ff7M6WbNWxFWDA4olEgymx?=
 =?us-ascii?Q?DBuM0XDGC2KVZcT9uRY0bj8rw/SeuO/nmXIA9hHMORdyUH+iR7UpHvdTO+EP?=
 =?us-ascii?Q?1gfAQPmlDkgZ56UxbCACxCw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 584b51a6-5dfd-413d-86e8-08ddde3eee43
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:06:42.4900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmtqiMenfJdE2o4jAJk0hbg6yOseKd6751zehKR1LALNt2Hohf1gkHSHXDSWNbQp3aOTnGu1Yfv7kDd6Ykp4/hEIBwarNkn3DoVo/URjL4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9719
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
2.50.1

