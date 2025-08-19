Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF21CA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 04:21:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68E9580422;
	Tue, 19 Aug 2025 06:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="fhT8PcWp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BB748144A; Tue, 19 Aug 2025 06:21:19 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 528FF802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 06:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYSmVOobI+JviLZR29E/P7G19Ze0TPQ3boAWJsbelZgTdaSVz3+cR6WZQPwYwMgoyroLmzuUUtJg+q/KqpcO4dW8EtBoPFlVCkM9GMUmK9uhzVRSi0qUx4L7fShtOqE+VGWLjhZk+WTMmziWBAUeU2qww7Y/siLYht612yZ+OxepqfW0bvwy4HtxjMYTWjKP+FaPiTx7zPMICM6sDL81PXh4rwN9y8eP6j4A4RuauaN3qodwy11DC9sYhtTa3ypHUqmIwjIPNknx3tG8mq6sKRCTPOynPcEho6GmFvMkNkKUSsEaGuXaXWOiwl/xfIn1YnCMpW7u5tKkV9uiPNAnKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TUcSKS28RLcoJQ4l+iujZkXtL9W05yPZOA89jYPCRM=;
 b=bep4sqPx4QYdRkYrmFHlfwIuIAgJmT54q5EzOuy8kaNNh3LmN7jgPNqAioQgb94U7Yy9KxHFWpAmWgHHO7V2QR6mIfxKzCqziI2uPRehIelYI+B7clGz7F+4NmrRxIfPmWBdPOZVSqR6zKt4gHgWQUwy37jA0W7VqUFXDjodWp57ZX7+jAV5CO1V1VewIrmbSycAN/FEtKMj3XbupW9BH8umcXwPqpgHoihqUQ91Kl67BRc5/QMTTCE9w331Nwt5jk+Oa22ycprOC+hIqgR9C3vwa0rIJEgvZLWy+Gd0YNjIirk+xVd4BOvx1GomDlEjR2GhjlKngk+epePkWloNew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TUcSKS28RLcoJQ4l+iujZkXtL9W05yPZOA89jYPCRM=;
 b=fhT8PcWp9gzvm1PDGRI7iFyQzud3+gLLs71WwXl/3yv2juWyCvCYsCpUZ6vUf5wlxLV7H19XgrU1xuMgDmZBZP4kNoVis6JrEbIEeLAOPRmdj+hM3Ig07Wqx+Pj1IQfJyJvT/78srfilRHUokezQQ6yIaAUxpZAY47xV8VTfKv8VJypujZGXb1oK+1ixPu9UcsdDslUZogDyCvjZION5hwettsGk7uOyWSVEYBRKAhZ5pbEbifAT6j4l0UaFHm+Aks/dV3+8mqDRMheWnzIajFSJ7vqb1f8buXDojHg7UJSN4r8NYKCSTrbIHZu4ZpPxx0//aRXNch/pT9NM+xRNEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by CH2PR03MB5287.namprd03.prod.outlook.com (2603:10b6:610:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 19 Aug
 2025 04:21:14 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 04:21:14 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH] mtd: spi: Add ISSI QSPI to lightweight SPI flash stack
Date: Mon, 18 Aug 2025 21:21:05 -0700
Message-Id: <20250819042105.25281-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0185.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::10) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|CH2PR03MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f876807-be72-4eac-2bf1-08ddded7d58d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tbzPKNwOTrOhIHff1voguHocrc2ENTObzUiqwiUfmgmadwBb6pWFIYiA2iL3?=
 =?us-ascii?Q?3K482koFM2b2LFSuloIKPdZRvnPDEgJQuU2iMWWzMVD0SdK87lxotG5j0X10?=
 =?us-ascii?Q?a7MSM5apl6U1KAZvNdxBVhFqZHbjTEj8EUQbawvt4rxTcgqU5MqBLreU6Qyk?=
 =?us-ascii?Q?54kFsVTTau2EEbE0hG5EBuh0kIcTiGcQFfO1shTmhYbTOWa2EswO5pSGldkA?=
 =?us-ascii?Q?uCqT335y4HgHOt+IoGwuD6E9b3dkX7XKVYhFztgZgXFQoGpiSs/ifPcwIxwu?=
 =?us-ascii?Q?cHqPYkdQQ/rro6egOlxZ+XzqQ8cEcPnnFjwZzV/zr4neQ0fTQcWjunYA+e3R?=
 =?us-ascii?Q?ESzUotSTW8XnNh2BGttb+bnMMCdCyeRrT4/DxK4+KwlgCF6iOJwkxaUu7Ode?=
 =?us-ascii?Q?z8y2wS6aC+sLcULqqVpjhDnOl8wQFUN1hK+Ko7Xz6UtWtGobN/WhZu+POZtM?=
 =?us-ascii?Q?yJfFOw98gEeOwhUX56ODAPDZZcWvS8aJviY7LNtw766bumHm+BsRmcs3A5N8?=
 =?us-ascii?Q?RthfNP44hRpS0RIW/ddOs9rjGOtAgHX/vazefkG56o1C2qzzZLCKWEFnOVgx?=
 =?us-ascii?Q?9z6MnH399cONAuS6Aw79eWMf/sEa987143MXqnoXqwYwblw5VF434dAQxZuG?=
 =?us-ascii?Q?BgZWi2LzSoI21sz389W6z0EhO7NW7ffFrP6K5PeOGmfshZrxOm/pDwIk5/dK?=
 =?us-ascii?Q?kK6Jzs3zTwG0PJmi+MUZXggeeH64dQgS7Q8omLj8xLk83WpK3HRsnPln5HiP?=
 =?us-ascii?Q?7sjUwteT81ipY/iDmbj37+x/zCcnjdr9pp6tlFtB6qR4U6WcnivZmE8aFXdg?=
 =?us-ascii?Q?8ToUa179OAhFmXgyVXbX/oBlmkcmG6OQ8QeK3OKe/PVYILDCG+dLpVYYVPPJ?=
 =?us-ascii?Q?w9qhd0JR+xyGJnXdbys6AkFDi/7Zrxn0Favxl8dNOcKsjEA2+HgeH358OC0d?=
 =?us-ascii?Q?1oR6A+POxmBxxBZMxF4pxVEZgqE7JAv5tOY3nWeY/zvPU//PINwzQ5RlAVuV?=
 =?us-ascii?Q?vv4AwCKMe1vxakCWX4tBOPjALPXOFmb3T5Xd3Ia7KNhowoZQNJJnkS7DIezj?=
 =?us-ascii?Q?nVjvSt8uuXiS6XnY3+pC8GLyTaUtVUFd+SfUkFk1BqDdUK67Cm6kp926pW9X?=
 =?us-ascii?Q?BIQwcHhzGTiOjfp2kAH09njO+3SrqeOW9ABIhSe1P2oPxwf2sAx3wHn2mkSK?=
 =?us-ascii?Q?Pegl/zfSQg+MrZz96ekWAazSfXJz0loQVDZogRNcdzNOH1LpVjefIfCl9MM9?=
 =?us-ascii?Q?7beWI7Ash0XGyLWfhCZOqoyKDDsVrrIE+/FIBMEO47Pg2IM0K9gXhy93+1S7?=
 =?us-ascii?Q?r8DLXYPUHooCVK+YB9XVc2004FPR6YOxonhzEcEChVgYcrJNStROLzv9QUxm?=
 =?us-ascii?Q?MvcpEy4yF3d0C4lIQn465GabaMq60mQbby4pBo1KCC2YZsj/Fg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fpn0z9mS+cM1HhkRW/z1TnlVMjo1+NDJc8Geg/mljqmNCNwnZqyn3f9PyPEI?=
 =?us-ascii?Q?arw6tlqAh7TdCAYxuLL0PxDRw86XAIH07uwoOFFqPnSBZfD319Z6yEOZpTmx?=
 =?us-ascii?Q?nCodoe4u5KBzIY1Esuvu9Y0A041T+VsEkcNe29ry3Y1iqwv1Zv53EjRv00RO?=
 =?us-ascii?Q?aMEZrxaRk6R0nlbattDQCYqmrIQwD7s0Fb0Cw4A5Xn2Il420n3rurcr/hM23?=
 =?us-ascii?Q?Ynfp9Zw7i2aHNhVukpFOwisEAVv9qm0MymvumY3frGVVMx+6l7bQyy0LHYu0?=
 =?us-ascii?Q?u5cEjWMMgnqaYYkEpxRRY3KlWV8C9kOVRvGQXgQcRTIIRCiFpU2KHqjURRwa?=
 =?us-ascii?Q?9zEkoZWRwJq/RdQqGYwEqynrJyZX5ujVcLOcBmt+buvWFXNADhCW2PAjTwgm?=
 =?us-ascii?Q?sle4IZtBaR5SB6EfJU3FbSB3Lss4CPqONAfgi3CBxGAUJVr91tWY+Pia5+gw?=
 =?us-ascii?Q?6bCoGZKBU6j0/zDNGqMAL7kpR8tOb6e+4p8Rk4OTMUUaem69MSkZuUHnjpm+?=
 =?us-ascii?Q?B3yzW3uU6hot3jYtdB21l8+Z1NNi+s8tE+evR+NCp5IdXR8poLlYEZWrOJw5?=
 =?us-ascii?Q?t7lzL25YUwPDm3MYngGn40A+69786Iay/eZm02kkzbGN9FgMkmi0whNBlvz3?=
 =?us-ascii?Q?68ieZXGlg2gjyw/XdEbOLd4mDIj8bRwha1ueJPDDV80w5LFWZ0CMD5rkJl82?=
 =?us-ascii?Q?sjD+RFLAnZDlZOJf8P0ib6nWjjKnSIqE6EkAaGHBNIZngvWbjbxZvlVIssY5?=
 =?us-ascii?Q?u2HsG4kwMNJ2JkdyDVPeVAML5ELTShSPj8zhuuMwWHgFfMtSy0ZMBrhOyCMv?=
 =?us-ascii?Q?Lpi0ffbYXrucLNFTwpwR1ZPL8DhgI72afLlPQ7/HvMKylYHWSjXtE2tYqQYB?=
 =?us-ascii?Q?kWyVtmbPVZvkp3eX8a/87mS7NtpwP+bzMS7+AMJRO4CzrVL/U1tAr8anXiGy?=
 =?us-ascii?Q?wJEaCBrw0s1MLp0j6MiDQzwICza/s+S1Etfm14FtVBzrZQXF/wwx81O3PMwz?=
 =?us-ascii?Q?ieVSCjINMuJXHwO7zmltoUNb4E4Vg2CjySsem+XkUxoY0On8cWuD/Oic7rs3?=
 =?us-ascii?Q?9HaMoJjuBu8hTBUBwVyUnpv2oC1+MAlI4haJyjqnDUogRSB39ybuWA/1YRgy?=
 =?us-ascii?Q?5B7JgqQYU0ckY/jjEtb5Tg3AQpPbXzS4HUBOVzCjAIEPeB88nS70K20rh4uM?=
 =?us-ascii?Q?fYEyzYeuXOrcKIqast48upuvO41pCaOM3NL3kNwYFWvrdX4lJjzqZxEYUNTR?=
 =?us-ascii?Q?tRQliapmvtWk3bQiJHEhONGVTElkSREk0YX42khpsp6mVkcW9e+Rncafi5w5?=
 =?us-ascii?Q?TRcOd+R4LTLQI0qoWVwgdO0GRlCzc06ddf3ZAd6icQHERYXL/Dclxn342R+/?=
 =?us-ascii?Q?XP+IE1AHWIQW1rMvp5z1LCCfANB27dxhv7afDzvcIBczgM/q8BPkf3hjhptG?=
 =?us-ascii?Q?1cssCUAA1y2TBrdBTBLlVWegz8NxXV4JgGQbLSqiHhjU5ag5YLbYYV/zLIjG?=
 =?us-ascii?Q?8S/ClsEUHACzDjPrKFNbpG3woQGAQSuYQhba5lVCnHBbW2lT0JS9mG89AFBo?=
 =?us-ascii?Q?lyPUR+rxtyt+OgVezx3BqDYEUDi/lAjb5K/dBAJTxfDjqhk4ZIG5lPNqlDae?=
 =?us-ascii?Q?GZ1kCQVJuCg+yOW0bhg0/tc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f876807-be72-4eac-2bf1-08ddded7d58d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 04:21:13.9832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74r2VwcKgxU+ewuAMX3E8K3x0brOjqZtZk/NGatkYtl7La67fvxIMJFb2ED8UxqtCMSNdC6smzNK3n9Ja6Kl866ueWci7cHrcW2an6Ug6XYwIrzD0vUof5BIKoBkuwpZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5287
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

Add support for reading data or images from ISSI QSPI flash.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/mtd/spi/spi-nor-tiny.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-tiny.c b/drivers/mtd/spi/spi-nor-tiny.c
index 23de64a1520..82c04d9810c 100644
--- a/drivers/mtd/spi/spi-nor-tiny.c
+++ b/drivers/mtd/spi/spi-nor-tiny.c
@@ -220,6 +220,7 @@ static inline int set_4byte(struct spi_nor *nor, const struct flash_info *info,
 		/* Some Micron need WREN command; all will accept it */
 		need_wren = true;
 		fallthrough;
+	case SNOR_MFR_ISSI:
 	case SNOR_MFR_MACRONIX:
 	case SNOR_MFR_WINBOND:
 		if (need_wren)
@@ -433,7 +434,7 @@ static int spi_nor_write_tiny(struct mtd_info *mtd, loff_t to, size_t len,
 	return -ENOTSUPP;
 }
 
-#ifdef CONFIG_SPI_FLASH_MACRONIX
+#if defined(CONFIG_SPI_FLASH_MACRONIX) || defined(CONFIG_SPI_FLASH_ISSI)
 /**
  * macronix_quad_enable() - set QE bit in Status Register.
  * @nor:	pointer to a 'struct spi_nor'
@@ -662,8 +663,9 @@ static int spi_nor_setup(struct spi_nor *nor, const struct flash_info *info,
 	/* Enable Quad I/O if needed. */
 	if (spi_nor_get_protocol_width(nor->read_proto) == 4) {
 		switch (JEDEC_MFR(info)) {
-#ifdef CONFIG_SPI_FLASH_MACRONIX
+#if defined(CONFIG_SPI_FLASH_MACRONIX) || defined(CONFIG_SPI_FLASH_ISSI)
 		case SNOR_MFR_MACRONIX:
+		case SNOR_MFR_ISSI:
 			err = macronix_quad_enable(nor);
 			break;
 #endif
-- 
2.35.3

