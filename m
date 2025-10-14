Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55ADDCCD187
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 11:19:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2A2F82B20;
	Tue, 14 Oct 2025 13:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xx9m72T1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 633D182BA7; Tue, 14 Oct 2025 13:19:05 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42EFD802C1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 13:19:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWYYRf34qDNtCh3IliCRjzrcOGZsvFv9+cA2AHJnd70U9GcXsBzySz9j3R59PJvNhetHol5cU7OGcU83X6eBODNASwH5FdTDneUMbHcL2dp22/CTTDymnQdZB3zsQ3qVRH/9PsODY/TN13Ow0GWZsdFoEn/qSUfK3BgI8ItnMOghCinzamGGqRPOg6r1ILN0VvpNajH6+Tpxo8WfnBVe3XYSjs4YDzrBxC2TxIbD9N+tdNWBZBn3W/lfrrgJfBva2diNxnhC9j2yXawBipUWvqf0Gn6Niq9P4Mr74TqrV6+DsRSHY1wpLHvXmcFNiLMEDulAtjRqNQJct5GAVTib6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deXYjLtrzU9pDRul6CAf86XPwO+2ESVeCEMmYBbySx4=;
 b=Ka1jPyVBnO3vz7hlAPWAKBMsGae8LQXD71mbbSV6wMTlb2jt6f494IX50evRol2b3ypRQ8TdF0hVY8oDycGpnZdAgAPsuIdZIlEpbG4gXp8LQKBwUxlghfN0g571YqFdd3aNGLKjjW4JhhkIQHMg5/GiJ1zwFjTGgwXge7CUhADBeWJMiJGEd/eQQiz6PNH74Pux7vs/VSM+DcjY9rF4Fv2eWWd6yhzeW0k2wrVGaq7C3zEyqFX2ugOgZP1EizVk8hsftBEnTd3aSOUUj+3jssLXr8qlDc/ClFMNjzXN1AIQ0DySuxv20bzTN/BfapIvRF/G52eDdDr3+SF0xDrXxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deXYjLtrzU9pDRul6CAf86XPwO+2ESVeCEMmYBbySx4=;
 b=xx9m72T1SFAun7GATn0+POSPsvZ1JfynfGvfZpa8IyTCUrqRwfpF1dPho6CYKhfyMYe1bVef98CcD63Up0e03ka7nke/SN3ty9U6JPxYOg7/og9q7CPLa/Z9V+fhum8ivWsugKDndo+oxcDJSCJT6Dz8U/GuE8NJHXUoRA58me7b3CyXhduu1g3Igt0bGjJ7ADstAElnQ417XDIGosjF+XkL/tKd898Hml2+ta2Bevc9s0wn3U2pDiIiYMJD7mZRr9xm3a4vTDPBWU/Uj+xfrY3GeEyPLVO44gvSSfUm9OfbBZuIqjocnduBmlkwJgr+r/1KDeczXAPMKm9FCnn89w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAXPR04MB8128.eurprd04.prod.outlook.com (2603:10a6:102:1c8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 11:18:58 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 11:18:58 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de, uboot-imx@nxp.com, trini@konsulko.com,
 sbabic@nabladev.com, festevam@gmail.com, jagan@amarulasolutions.com
Cc: ye.li@nxp.com, alice.guo@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com,
 sjg@chromium.org, mkorpershoek@kernel.org, marek.vasut@mailbox.org
Subject: [PATCH v1 1/4] spi: nxp_xspi: Add new driver for NXP XSPI controller
Date: Tue, 14 Oct 2025 19:17:53 +0800
Message-ID: <20251014111756.446456-2-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014111756.446456-1-alice.guo@oss.nxp.com>
References: <20251014111756.446456-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PAXPR04MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: aff56c13-3068-4316-06d6-08de0b1377ca
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u55j12E3LcVZTZpNfDhqEcKzUY07jH/jSxVMcBOlFdqEfEQ6t4zLutLrKj/H?=
 =?us-ascii?Q?CIrwLj5Ntxx8QfwAy+mj88KLZztdoe/qk5RjmOlMUBFp88dWbHpA6fPtL5DF?=
 =?us-ascii?Q?4za+kAl1nUiXS67xAPvzNL30mq4yuiA5D8/KNoe20+cUUmdtkP0tJaz7kbNI?=
 =?us-ascii?Q?zH3YVqycmQeI0OoQEeDrsTclSKSbewO/Zz09W75zopaR5CxKwJsKL+nHD+Td?=
 =?us-ascii?Q?4djqNZvR7LVekMCxBfkpbs5WQ/oOSxys7v1drYzuSxswCc3KNiRPECoCuAkp?=
 =?us-ascii?Q?UhxQo3Lgx9+FzzhMiflRzPuh/BM525raBDpXhg1SCdqzginFx+Xm8cbALWbR?=
 =?us-ascii?Q?+3uQzZlLWCeB9AU0qFjICVSA+6lAxaCh/MU299F57VLCcIPlsyiURPix9lNv?=
 =?us-ascii?Q?WxC1Y2xkZnVFJy3QPGii58qBqGpvKVQPYlPip1eoPyk9nZFiAkmHfNOUpZAt?=
 =?us-ascii?Q?MjVPMhtm9cp9eQAqZdwM0HCsJbwxImipOL9EtAGSQWvxH4x2kgulXA80J53J?=
 =?us-ascii?Q?Qo4pD4HTGoxM5lUHieOSZP+2J1FvHq2j8YZQVexblrYu92VHXqf3gS0Qp/tB?=
 =?us-ascii?Q?lluZ0JOH8ti58pWmI71Jfsq3qZY/fwS7tPKFhvci0ZMpeqQozUa3TF+qgQ+B?=
 =?us-ascii?Q?+jSRUrBYnahBoleTgna7bMxH3gjyIFhYO7WomcbiLOzQjG1LE1ncORhBZGag?=
 =?us-ascii?Q?TsmTcS5RUVAlMTM5KHu0Byy9LCvz+68JR8+13TrWJimq5ojFMiGf+0AfUuL8?=
 =?us-ascii?Q?QOU6KhS9n5tf3XyLLiI+baVwK6c6GIBvyGflH5jRDUPTFXQ/lfs3rrvnflZd?=
 =?us-ascii?Q?BUL1+iPKwpqZnUgz24Vo1qI7uDXjTNbYiDc+fWwjmcc+lwrD6u2B6JExReqd?=
 =?us-ascii?Q?kqzAf8hxzHZrm+yHr5GvBVX9R4XDCyQKKrxSTpe1Zvv6VEkYq0j0/Gd6/tVz?=
 =?us-ascii?Q?lzY0ZkUlE2aUGm7h6cWtN9boalPT1p+1/8HxYb4c7rvBceBl+Vz2a2+WGRrH?=
 =?us-ascii?Q?PBOQyer8xxO8TvO+Gkjq1crp6YaT9ocv8VgrDgwAwacf7tPnQ9R4vwIZTLO+?=
 =?us-ascii?Q?U06nE9Aak1MBL07rLn69ARB+slTAY3QOak9DfPHtRg/GeYsfoVUDbtnroZeA?=
 =?us-ascii?Q?uDiSE0AWbxR9UQBS0sIevYQtnZlN2ozezEFRfgDgIgxSdMClmtB/dKktPGjR?=
 =?us-ascii?Q?1IX//6wZ5FQwdldVm3Bh8Gb0u/8+ZzqmZbspfbv9YGllYUWZ5dJbZT14zdd9?=
 =?us-ascii?Q?9aX1y2vs0bt2Hi9nUTK92x49OgqJ2zNlHPcZnmMH1TFiK+9pYTIm8OLNmucV?=
 =?us-ascii?Q?OsIpzLibTsLiF3Bb6PcJJ4viAV9cCEpaiYoQ0WNJibtEYb1Xv30vEEHmTjaQ?=
 =?us-ascii?Q?7PfBnhZivPiQ9cFJp9vASZmOehYbvnIRnpNCbvNCNdmtrOML9LdNu0u3W6MU?=
 =?us-ascii?Q?RIhSP/aCWwNp8dgbmd4NlVbT5CGskChusT5BnZdyEar5DAiTYWOkRH65ySjM?=
 =?us-ascii?Q?ArnnWLdFme7ibLivOz0UrNGJTarGC7Pdh5aF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?05tvSTudbYQrw7lxb8vOfasNbcgTkbg0fLqmHwBNB+T8GTjYQIL6FS4W1cgY?=
 =?us-ascii?Q?gPIizKUW8XKTTLQdH0dzoAyKWtUqIr/rZLMLkWeYQiAI0bGzXS5lq2bo2mI5?=
 =?us-ascii?Q?+NXdSvi+DRY08nfkNd9f4neXNZqwVlioYx0T0iyJ1aQj+9T3vlzgWt7MOPF8?=
 =?us-ascii?Q?Jhm6urJ5JcfFiq2OamGgBYFSQs7KBcoTGOZas7sI3KF2UZFPJYY757FqR15m?=
 =?us-ascii?Q?FW3cVkmm0LDRBjtiUOHJSbnly9d29f39lPuMdUEHayinYZNl7xZgySgP2jnH?=
 =?us-ascii?Q?mFd7Gx9nOTgK3/4yCUboBBrMZRPTKIkSyZ0UAey7i/ujeXJKTXlkZ3SsswuB?=
 =?us-ascii?Q?UGO5y8+gdtw0kK7bvp6w0El36FMy5qwxhr7LjuhM+7bMrgQRalbjhUv2ZLo1?=
 =?us-ascii?Q?Z7cIvINnMC/xK5yYQVBg/otwrRtCuKdNjxtytBmFlwhz+Mh9qlhg05+RWJj+?=
 =?us-ascii?Q?MJs0Ihlr2DOqaqiXRZDlaC3YWZjNIHWopF3uC+R3nv0sw9m24AmrkoPdsnSG?=
 =?us-ascii?Q?Q5JaVFx89AooFA/jCpY5MdQwqW7/v4k9h+4Yc5yBWYfHPV2dir4DvZRcRn5S?=
 =?us-ascii?Q?yQVJZ65J//U2CSVkYAXdlodlgHkwApHjlsYUrh5+FyGHeMa+EWySW8IlGX+d?=
 =?us-ascii?Q?+uQzx1cAeib+x0RFK2Mp8dM5wJve5xsnwQ/LZDYiSZNFEhqbkpiXTDwGLoxA?=
 =?us-ascii?Q?fZSl+8isqTsRuOMjEgbrNXBxvcaFsOeCKiTyjuHfg9m6SHF14GQAf8lEp40y?=
 =?us-ascii?Q?b5K/lqmrMkhgamWIlaFeflU7AKCkPwnQd3erXGCQwc7I0xCzJQFevKjs4Wi9?=
 =?us-ascii?Q?SwKijZB31rxCL1rUq6qSc2C2efBVvM2Z1Zwvvl4wOmfitQNkNizcVjOdbF1+?=
 =?us-ascii?Q?Pk0QdsvWgmJZefUx+YIVmNC/wD0y68AdAU0VeJ9rJxCzdUkxyZa0h8l/vo7s?=
 =?us-ascii?Q?zXvpGTUl6iZYhMFSqNF6T91+0IW2hDRCMAThV0KEY/J+Sb9FT9K55GnFExE/?=
 =?us-ascii?Q?TxemIb+8ZNfufKq1g4bWBvNfv6YPNJ/JS55MoUPKtw5gijVA1nalfVG/0ZWZ?=
 =?us-ascii?Q?EoyN2Zyof/9swYq9SksnnywzXZH8ofMIFbuDdai0U+o5ySPXeV0KfyvHtuDP?=
 =?us-ascii?Q?afi/OXXHzDjHn4h6/plbLbtPGCOC7gSSao1WOIfa7o5l/LC+sBoldby0ttnd?=
 =?us-ascii?Q?TKzrSflsft8RRTq0rjoTLdFzNoWohdnCs8Z7xcGdDXckh1Hd0g8ymgT9LF4m?=
 =?us-ascii?Q?T6UNfb+Tz++92qq6tGddCF5iKRl7zv6X/7sRzA29dgAM4NbS7r2X1CNTeuXW?=
 =?us-ascii?Q?Iu7332HWQdE99vvI/yxxb7jYsuu7OYCxrSBvWHArBK9f97E9eGIOpxkuX2fh?=
 =?us-ascii?Q?Moh69xWorZ0XfMyLEBPBILC7hlOo0cGFGnIysFHi1f7lSfF/iJIVJcxofYR5?=
 =?us-ascii?Q?tfMVuykyvOk3udwHbhtzzEf6YRT64JbJ+OdAw71B5Lea7HpoxMaK0J3by0T9?=
 =?us-ascii?Q?E8QCE8PGQKdv05wmd0h5vMMsGBNbYlJM7POYdnVZBfToNZhPXwLriTijoCjl?=
 =?us-ascii?Q?NUkTQnt0d5245/QDoLxRh6AUrmvCk5ppFq40wRoo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff56c13-3068-4316-06d6-08de0b1377ca
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 11:18:58.1728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: haQHBzSiZUPbeK5UdWZzT14VL/zjtqXpEABLE0mgOCTxlO7kGBAMUUWv+NcHklRLrXU8kbkwVqkVQvKRz26U3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8128
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

From: Alice Guo <alice.guo@nxp.com>

Add new driver to support NXP XSPI controller for NOR and NAND flash.
XSPI controller also uses a programmable sequence engine to provide
flexibility to support existing and future memory devices. It supports
single, dual, quad, octal modes of operation.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
---
 MAINTAINERS            |   1 +
 drivers/spi/Kconfig    |   7 +
 drivers/spi/Makefile   |   1 +
 drivers/spi/nxp_xspi.c | 889 +++++++++++++++++++++++++++++++++++++++++
 drivers/spi/nxp_xspi.h | 713 +++++++++++++++++++++++++++++++++
 5 files changed, 1611 insertions(+)
 create mode 100644 drivers/spi/nxp_xspi.c
 create mode 100644 drivers/spi/nxp_xspi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 671903605d1..c0d5c9c4e08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -320,6 +320,7 @@ F:	common/spl/spl_imx_container.c
 F:	doc/imx/
 F:	drivers/mailbox/imx-mailbox.c
 F:	drivers/serial/serial_mxc.c
+F:	drivers/spi/nxp_xspi.c
 F:	include/imx_container.h
 
 ARM HISILICON
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 2960822211a..c8ef3dd03be 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -391,6 +391,13 @@ config NXP_FSPI
 	  Enable the NXP FlexSPI (FSPI) driver. This driver can be used to
 	  access the SPI NOR flash on platforms embedding this NXP IP core.
 
+config NXP_XSPI
+	bool "NXP XSPI driver"
+	depends on SPI_MEM
+	help
+	  Enable the NXP External SPI (XSPI) driver. This driver can be used to
+	  access the SPI NOR/NAND flash on platforms embedding this NXP IP core.
+
 config OCTEON_SPI
 	bool "Octeon SPI driver"
 	depends on ARCH_OCTEON || ARCH_OCTEONTX || ARCH_OCTEONTX2
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 5129d649f84..7008a655829 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_MXS_SPI) += mxs_spi.o
 obj-$(CONFIG_NPCM_FIU_SPI) += npcm_fiu_spi.o
 obj-$(CONFIG_NPCM_PSPI) += npcm_pspi.o
 obj-$(CONFIG_NXP_FSPI) += nxp_fspi.o
+obj-$(CONFIG_NXP_XSPI) += nxp_xspi.o
 obj-$(CONFIG_ATCSPI200_SPI) += atcspi200_spi.o
 obj-$(CONFIG_OCTEON_SPI) += octeon_spi.o
 obj-$(CONFIG_OMAP3_SPI) += omap3_spi.o
diff --git a/drivers/spi/nxp_xspi.c b/drivers/spi/nxp_xspi.c
new file mode 100644
index 00000000000..885f5f94380
--- /dev/null
+++ b/drivers/spi/nxp_xspi.c
@@ -0,0 +1,889 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/arch/clock.h>
+#include <asm/io.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <linux/bitops.h>
+#include <linux/bug.h>
+#include <linux/err.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/sizes.h>
+#include <log.h>
+#include <malloc.h>
+#include <spi.h>
+#include <spi-mem.h>
+
+#include "nxp_xspi.h"
+
+static inline void xspi_writel(struct nxp_xspi *x, u32 val, u32 addr)
+{
+	void __iomem *_addr = (void __iomem *)(uintptr_t)addr;
+
+	if (x->devtype_data->little_endian)
+		out_le32(_addr, val);
+	else
+		out_be32(_addr, val);
+};
+
+static inline u32 xspi_readl(struct nxp_xspi *x, u32 addr)
+{
+	if (x->devtype_data->little_endian)
+		return in_le32((uintptr_t)addr);
+	else
+		return in_be32((uintptr_t)addr);
+};
+
+#define xspi_config_sfp_tg(x, env, sfar, ipcr) \
+	do { \
+		xspi_writel_offset(x, env, (sfar), SFP_TG_SFAR); \
+		xspi_writel_offset(x, env, (ipcr), SFP_TG_IPCR); \
+	} while (0)
+
+static int xspi_readl_poll_tout(struct nxp_xspi *x, int env, u32 offset,
+				u32 mask, u32 delay_us,
+				u32 timeout_us, bool c)
+{
+	u32 reg;
+	void __iomem *addr = (void __iomem *)(uintptr_t)x->iobase + (env * ENV_ADDR_SIZE) + offset;
+
+	if (!x->devtype_data->little_endian)
+		mask = (u32)cpu_to_be32(mask);
+
+	if (c)
+		return readl_poll_sleep_timeout(addr, reg, (reg & mask),
+						delay_us, timeout_us);
+	else
+		return readl_poll_sleep_timeout(addr, reg, !(reg & mask),
+						delay_us, timeout_us);
+};
+
+static struct nxp_xspi_devtype_data imx943_data = {
+	.rxfifo = SZ_512,	/* RX fifo Size*/
+	.rx_buf_size = 64 * 4, /* RBDR buffer size */
+	.txfifo = SZ_1K,
+	.ahb_buf_size = SZ_4K,
+	.quirks = 0,
+	.little_endian = true,
+};
+
+static const struct udevice_id nxp_xspi_ids[] = {
+	{ .compatible = "nxp,imx943-xspi", .data = (ulong)&imx943_data, },
+	{ }
+};
+
+static int nxp_xspi_claim_bus(struct udevice *dev)
+{
+	return 0;
+}
+
+#if CONFIG_IS_ENABLED(CLK)
+static int nxp_xspi_clk_prep_enable(struct nxp_xspi *x)
+{
+	int ret;
+
+	ret = clk_enable(&x->clk);
+	if (ret)
+		return ret;
+
+	return 0;
+};
+
+static void nxp_xspi_clk_disable_unprep(struct nxp_xspi *x)
+{
+	clk_disable(&x->clk);
+};
+#endif
+
+static int xspi_swreset(struct nxp_xspi *x)
+{
+	u32 reg;
+
+	reg = xspi_readl_offset(x, 0, MCR);
+	reg |= (XSPI_MCR_SWRSTHD_MASK | XSPI_MCR_SWRSTSD_MASK);
+	xspi_writel_offset(x, 0, reg, MCR);
+	udelay(2);
+	reg &= ~(XSPI_MCR_SWRSTHD_MASK | XSPI_MCR_SWRSTSD_MASK);
+	xspi_writel_offset(x, 0, reg, MCR);
+
+	return 0;
+};
+
+static void nxp_xspi_dll_bypass(struct nxp_xspi *x)
+{
+	u32 reg;
+	int ret;
+
+	xspi_swreset(x);
+
+	xspi_writel_offset(x, 0, 0, DLLCRA);
+
+	reg = XSPI_DLLCRA_SLV_EN_MASK;
+	xspi_writel_offset(x, 0, reg, DLLCRA);
+
+	reg = XSPI_DLLCRA_FREQEN_MASK | XSPI_DLLCRA_SLV_EN_MASK |
+		XSPI_DLLCRA_SLV_DLL_BYPASS_MASK | XSPI_DLLCRA_SLV_DLY_COARSE(7);
+	xspi_writel_offset(x, 0, reg, DLLCRA);
+
+	reg |= XSPI_DLLCRA_SLV_UPD_MASK;
+	xspi_writel_offset(x, 0, reg, DLLCRA);
+
+	ret = xspi_readl_poll_tout(x, 0, XSPI_DLLSR, XSPI_DLLSR_SLVA_LOCK_MASK, 1, POLL_TOUT, true);
+	WARN_ON(ret);
+
+	reg &= ~XSPI_DLLCRA_SLV_UPD_MASK;
+	xspi_writel_offset(x, 0, reg, DLLCRA);
+}
+
+static void nxp_xspi_dll_auto(struct nxp_xspi *x, unsigned long rate)
+{
+	u32 reg;
+	int ret;
+
+	xspi_swreset(x);
+
+	xspi_writel_offset(x, 0, 0, DLLCRA);
+
+	reg = XSPI_DLLCRA_SLV_EN_MASK;
+	xspi_writel_offset(x, 0, reg, DLLCRA);
+
+	reg = XSPI_DLLCRA_DLL_REFCNTR(2) | XSPI_DLLCRA_DLLRES(8) |
+		XSPI_DLLCRA_SLAVE_AUTO_UPDT_MASK | XSPI_DLLCRA_SLV_EN_MASK;
+	if (rate > MHZ(133))
+		reg |= XSPI_DLLCRA_FREQEN_MASK;
+
+	xspi_writel_offset(x, 0, reg, DLLCRA);
+
+	reg |= XSPI_DLLCRA_SLV_UPD_MASK;
+	xspi_writel_offset(x, 0, reg, DLLCRA);
+
+	reg |= XSPI_DLLCRA_DLLEN_MASK;
+	xspi_writel_offset(x, 0, reg, DLLCRA);
+
+	ret = xspi_readl_poll_tout(x, 0, XSPI_DLLSR,
+				   XSPI_DLLSR_DLLA_LOCK_MASK | XSPI_DLLSR_SLVA_LOCK_MASK,
+				   1, POLL_TOUT, true);
+	WARN_ON(ret);
+}
+
+static void nxp_xspi_disable_ddr(struct nxp_xspi *x)
+{
+	u32 reg;
+
+	reg = xspi_readl_offset(x, 0, MCR);
+	reg |= XSPI_MCR_MDIS_MASK;
+	xspi_writel_offset(x, 0, reg, MCR);
+
+	reg &= ~(XSPI_MCR_DQS_EN_MASK | XSPI_MCR_DDR_EN_MASK);
+	reg &= ~XSPI_MCR_DQS_FA_SEL_MASK;
+	reg |= XSPI_MCR_DQS_FA_SEL(1);
+	xspi_writel_offset(x, 0, reg, MCR);
+
+	reg = xspi_readl_offset(x, 0, FLSHCR);
+	reg &= ~XSPI_FLSHCR_TDH_MASK;
+	xspi_writel_offset(x, 0, reg, FLSHCR);
+
+	xspi_writel_offset(x, 0, XSPI_SMPR_DLLFSMPFA(7), SMPR);
+
+	reg = xspi_readl_offset(x, 0, MCR);
+	reg &= ~XSPI_MCR_MDIS_MASK;
+	xspi_writel_offset(x, 0, reg, MCR);
+
+	x->support_max_rate = MHZ(133);
+}
+
+static void nxp_xspi_enable_ddr(struct nxp_xspi *x)
+{
+	u32 reg;
+
+	reg = xspi_readl_offset(x, 0, MCR);
+	reg |= XSPI_MCR_MDIS_MASK;
+	xspi_writel_offset(x, 0, reg, MCR);
+
+	reg |= XSPI_MCR_DQS_EN_MASK | XSPI_MCR_DDR_EN_MASK;
+	reg &= ~XSPI_MCR_DQS_FA_SEL_MASK;
+	reg |= XSPI_MCR_DQS_FA_SEL(3);
+	xspi_writel_offset(x, 0, reg, MCR);
+
+	reg = xspi_readl_offset(x, 0, FLSHCR);
+	reg |= XSPI_FLSHCR_TDH(1);
+	xspi_writel_offset(x, 0, reg, FLSHCR);
+
+	xspi_writel_offset(x, 0, XSPI_SMPR_DLLFSMPFA(4), SMPR);
+
+	reg = xspi_readl_offset(x, 0, MCR);
+	reg &= ~XSPI_MCR_MDIS_MASK;
+	xspi_writel_offset(x, 0, reg, MCR);
+
+	x->support_max_rate = MHZ(200);
+}
+
+static int nxp_xspi_set_speed(struct udevice *bus, uint speed)
+{
+	printf("%s: %u\n", __func__, speed);
+#if CONFIG_IS_ENABLED(CLK)
+	struct nxp_xspi *x = dev_get_priv(bus);
+	int ret;
+
+	nxp_xspi_clk_disable_unprep(x);
+
+	ret = clk_set_rate(&x->clk, speed);
+	if (ret < 0)
+		return ret;
+
+	ret = nxp_xspi_clk_prep_enable(x);
+	if (ret)
+		return ret;
+
+	xspi_swreset(x);
+#endif
+	return 0;
+}
+
+static int nxp_xspi_set_mode(struct udevice *bus, uint mode)
+{
+	return 0;
+}
+
+static int nxp_xspi_adjust_op_size(struct spi_slave *slave,
+				   struct spi_mem_op *op)
+{
+	struct nxp_xspi *x;
+	struct udevice *bus;
+
+	bus = slave->dev->parent;
+	x = dev_get_priv(bus);
+
+	if (op->data.dir == SPI_MEM_DATA_OUT) {
+		if (op->data.nbytes > x->devtype_data->txfifo)
+			op->data.nbytes = x->devtype_data->txfifo;
+	} else {
+		if (op->data.nbytes > x->devtype_data->ahb_buf_size)
+			op->data.nbytes = x->devtype_data->ahb_buf_size;
+		else if (op->data.nbytes > x->devtype_data->rxfifo)
+			op->data.nbytes = ALIGN_DOWN(op->data.nbytes, 8);
+	}
+
+	return 0;
+}
+
+static int nxp_xspi_check_buswidth(struct nxp_xspi *x, u8 width)
+{
+	switch (width) {
+	case 1:
+	case 2:
+	case 4:
+	case 8:
+		return 0;
+	}
+
+	return -ENOTSUPP;
+}
+
+static bool nxp_xspi_supports_op(struct spi_slave *slave,
+				 const struct spi_mem_op *op)
+{
+	struct nxp_xspi *x;
+	struct udevice *bus;
+	int ret;
+
+	bus = slave->dev->parent;
+	x = dev_get_priv(bus);
+
+	ret = nxp_xspi_check_buswidth(x, op->cmd.buswidth);
+
+	if (op->addr.nbytes)
+		ret |= nxp_xspi_check_buswidth(x, op->addr.buswidth);
+
+	if (op->dummy.nbytes)
+		ret |= nxp_xspi_check_buswidth(x, op->dummy.buswidth);
+
+	if (op->data.nbytes)
+		ret |= nxp_xspi_check_buswidth(x, op->data.buswidth);
+
+	if (ret)
+		return false;
+
+	/*
+	 * The number of address bytes should be equal to or less than 4 bytes.
+	 */
+	if (op->addr.nbytes > 4)
+		return false;
+
+	/*
+	 * If requested address value is greater than controller assigned
+	 * memory mapped space, return error as it didn't fit in the range
+	 * of assigned address space.
+	 */
+	if (op->addr.val >= x->a1_size + x->a2_size)
+		return false;
+
+	/* Max 64 dummy clock cycles supported */
+	if (op->dummy.buswidth &&
+	    (op->dummy.nbytes * 8 / op->dummy.buswidth > 64))
+		return false;
+
+	/* Max data length, check controller limits and alignment */
+	if (op->data.dir == SPI_MEM_DATA_IN &&
+	    (op->data.nbytes > x->devtype_data->ahb_buf_size ||
+	     (op->data.nbytes > x->devtype_data->rxfifo &&
+	      !IS_ALIGNED(op->data.nbytes, 8))))
+		return false;
+
+	if (op->data.dir == SPI_MEM_DATA_OUT &&
+	    op->data.nbytes > x->devtype_data->txfifo)
+		return false;
+
+	if (op->cmd.dtr)
+		return spi_mem_dtr_supports_op(slave, op);
+	else
+		return spi_mem_default_supports_op(slave, op);
+}
+
+static int xspi_update_lut(struct nxp_xspi *x, u32 seq_index, const u32 *lut_base, u32 num_of_seq)
+{
+	int ret;
+
+	ret = xspi_readl_poll_tout(x, 0, XSPI_SR, XSPI_SR_BUSY_MASK, 1, POLL_TOUT, false);
+	WARN_ON(ret);
+
+	xspi_writel_offset(x, 0, XSPI_LUT_KEY_VAL, LUTKEY);
+	xspi_writel_offset(x, 0, 0x2, LCKCR);
+
+	for (int i = 0; i < num_of_seq * 5; i++)
+		xspi_writel(x, *(lut_base + i), x->iobase + XSPI_LUT + (seq_index * 5 + i) * 4);
+
+	xspi_writel_offset(x, 0, XSPI_LUT_KEY_VAL, LUTKEY);
+	xspi_writel_offset(x, 0, 0x1, LCKCR);
+
+	return 0;
+}
+
+static void nxp_xspi_prepare_lut(struct nxp_xspi *x,
+				 const struct spi_mem_op *op)
+{
+	u32 lutval[5] = {0};
+	int lutidx = 1;
+
+	/* cmd */
+	if (op->cmd.dtr) {
+		lutval[0] |= LUT_DEF(0, CMD_DDR, LUT_PAD(op->cmd.buswidth),
+				     op->cmd.opcode >> 8);
+		lutval[lutidx / 2] |= LUT_DEF(lutidx, CMD_DDR,
+					      LUT_PAD(op->cmd.buswidth),
+					      op->cmd.opcode & 0x00ff);
+		lutidx++;
+	} else {
+		lutval[0] |= LUT_DEF(0, CMD_SDR, LUT_PAD(op->cmd.buswidth),
+				     op->cmd.opcode);
+	}
+
+	/* addr bytes */
+	if (op->addr.nbytes) {
+		lutval[lutidx / 2] |= LUT_DEF(lutidx, op->addr.dtr ?  RADDR_DDR : RADDR_SDR,
+					      LUT_PAD(op->addr.buswidth),
+					      op->addr.nbytes * 8);
+		lutidx++;
+	}
+
+	/* dummy bytes, if needed */
+	if (op->dummy.nbytes) {
+		lutval[lutidx / 2] |= LUT_DEF(lutidx, DUMMY_CYCLE,
+					      LUT_PAD(op->data.buswidth),
+					      op->dummy.nbytes * 8 /
+					      op->dummy.buswidth / (op->dummy.dtr ? 2 : 1));
+		lutidx++;
+	}
+
+	/* read/write data bytes */
+	if (op->data.nbytes) {
+		lutval[lutidx / 2] |= LUT_DEF(lutidx,
+					      op->data.dir == SPI_MEM_DATA_IN ?
+					      (op->data.dtr ? READ_DDR : READ_SDR) :
+					      (op->data.dtr ? WRITE_DDR : WRITE_SDR),
+					      LUT_PAD(op->data.buswidth),
+					      0);
+		lutidx++;
+	}
+
+	/* stop condition. */
+	lutval[lutidx / 2] |= LUT_DEF(lutidx, CMD_STOP, 0, 0);
+#ifdef DEBUG
+	print_buffer(0, lutval, 4, lutidx / 2 + 1, 4);
+#endif
+	xspi_update_lut(x, CMD_LUT_FOR_IP_CMD, lutval, 1);
+
+	if (op->data.nbytes &&
+	    (op->data.dir == SPI_MEM_DATA_IN || op->data.dir == SPI_MEM_DATA_OUT) &&
+	    op->addr.nbytes)
+		xspi_update_lut(x, CMD_LUT_FOR_AHB_CMD, lutval, 1);
+}
+
+static void nxp_xspi_read_ahb(struct nxp_xspi *x, const struct spi_mem_op *op)
+{
+	u32 len = op->data.nbytes;
+
+	/* Read out the data directly from the AHB buffer. */
+	memcpy_fromio(op->data.buf.in, (void *)(uintptr_t)(x->ahb_addr + op->addr.val), len);
+}
+
+static void nxp_xspi_fill_txfifo(struct nxp_xspi *x,
+				 const struct spi_mem_op *op)
+{
+	const u8 *buf = (u8 *)op->data.buf.out;
+	int xfer_remaining_size = op->data.nbytes;
+	u32 reg, val = 0;
+	int ret;
+
+	/* clear the TX FIFO. */
+	xspi_set_reg_field(x, x->config.env, 1, MCR, CLR_TXF);
+	ret = xspi_readl_poll_tout(x, x->config.env, XSPI_MCR,
+				   XSPI_MCR_CLR_TXF_MASK, 1, POLL_TOUT, false);
+	WARN_ON(ret);
+
+	reg = XSPI_TBCT_WMRK((x->devtype_data->txfifo - ALIGN_DOWN(op->data.nbytes, 4)) / 4 + 1);
+	xspi_writel_offset(x, x->config.env, reg, TBCT);
+
+	reg = x->ahb_addr + op->addr.val;
+	xspi_writel_offset(x, x->config.env, reg, SFP_TG_SFAR);
+
+	udelay(2);
+	reg = XSPI_SFP_TG_IPCR_SEQID(CMD_LUT_FOR_IP_CMD) | XSPI_SFP_TG_IPCR_IDATSZ(op->data.nbytes);
+	u64 start = timer_get_us();
+
+	xspi_writel_offset(x, x->config.env, reg, SFP_TG_IPCR);
+
+	while (xfer_remaining_size > 0) {
+		if (xspi_get_reg_field(x, x->config.env, SR, TXFULL))
+			continue;
+
+		if (xfer_remaining_size > 4) {
+			memcpy(&val, buf, 4);
+			buf += 4;
+		} else {
+			val = 0;
+			memcpy(&val, buf, xfer_remaining_size);
+			buf += xfer_remaining_size;
+		}
+
+		xspi_writel_offset(x, x->config.env, val, TBDR);
+		xfer_remaining_size -= 4;
+
+		if (xspi_get_reg_field(x, x->config.env, FR, ILLINE))
+			break;
+	}
+
+	/* Wait for controller being ready. */
+	ret = xspi_readl_poll_tout(x, x->config.env, XSPI_SR,
+				   XSPI_SR_BUSY_MASK, 1, POLL_TOUT, false);
+	WARN_ON(ret);
+
+	u32 trctr = xspi_get_reg_field(x, x->config.env, TBSR, TRCTR);
+
+	if ((ALIGN(op->data.nbytes, 4) / 4) != trctr)
+		dev_dbg(x->dev, "Fail to write data. tx_size = %u, trctr = %u.\n",
+			op->data.nbytes, trctr * 4);
+
+	dev_dbg(x->dev, "tx data size: %u bytes, spend: %llu us\r\n",
+		op->data.nbytes, timer_get_us() - start);
+}
+
+static void nxp_xspi_read_rxfifo(struct nxp_xspi *x,
+				 const struct spi_mem_op *op)
+{
+	u32 reg;
+	int ret, i;
+	u32 val;
+
+	u8 *buf = op->data.buf.in;
+
+	reg = XSPI_RBCT_WMRK(x->devtype_data->rx_buf_size / 4 - 1);
+	xspi_writel_offset(x, x->config.env, reg, RBCT);
+
+	/* clear the TX FIFO. */
+	xspi_set_reg_field(x, x->config.env, 1, MCR, CLR_RXF);
+	ret = xspi_readl_poll_tout(x, x->config.env, XSPI_MCR,
+				   XSPI_MCR_CLR_RXF_MASK, 1, POLL_TOUT, false);
+	WARN_ON(ret);
+
+	xspi_writel_offset(x, x->config.env,  x->ahb_addr + op->addr.val, SFP_TG_SFAR);
+	reg = XSPI_SFP_TG_IPCR_SEQID(CMD_LUT_FOR_IP_CMD) | XSPI_SFP_TG_IPCR_IDATSZ(op->data.nbytes);
+	u64 start = timer_get_us();
+
+	xspi_writel_offset(x, x->config.env, reg, SFP_TG_IPCR);
+
+	ret = xspi_readl_poll_tout(x, x->config.env, XSPI_SR, XSPI_SR_BUSY_MASK, 1,
+				   POLL_TOUT, false);
+	WARN_ON(ret);
+
+	for (i = 0; i < ALIGN_DOWN(op->data.nbytes, 4); i += 4) {
+		if (i == x->devtype_data->rx_buf_size) {
+			reg = xspi_readl_offset(x, x->config.env, FR);
+			reg |= XSPI_FR_RBDF_MASK;
+			xspi_writel_offset(x, x->config.env, reg, FR);
+		}
+		val = xspi_readl(x, x->iobase + (x->config.env * ENV_ADDR_SIZE) +
+				 XSPI_RBDR + (i % x->devtype_data->rx_buf_size));
+		memcpy(buf + i, &val, 4);
+	}
+
+	if (i < op->data.nbytes) {
+		val = xspi_readl(x, x->iobase + (x->config.env * ENV_ADDR_SIZE) +
+				 XSPI_RBDR + (i % x->devtype_data->rx_buf_size));
+		memcpy(buf + i, &val, op->data.nbytes - i);
+	}
+
+	/* clear the RX FIFO. */
+	xspi_set_reg_field(x, x->config.env, 1, MCR, CLR_RXF);
+	ret = xspi_readl_poll_tout(x, x->config.env, XSPI_MCR,
+				   XSPI_MCR_CLR_RXF_MASK, 1, POLL_TOUT, false);
+	WARN_ON(ret);
+
+	dev_dbg(x->dev, "rx data size: %u bytes, spend: %llu us\r\n",
+		op->data.nbytes, timer_get_us() - start);
+}
+
+static int nxp_xspi_xfer_cmd(struct nxp_xspi *x, const struct spi_mem_op *op)
+{
+	u32 reg;
+	int ret;
+
+	xspi_writel_offset(x, x->config.env, x->ahb_addr + op->addr.val, SFP_TG_SFAR);
+	reg = XSPI_SFP_TG_IPCR_SEQID(CMD_LUT_FOR_IP_CMD) | XSPI_SFP_TG_IPCR_IDATSZ(op->data.nbytes);
+	xspi_writel_offset(x, x->config.env, reg, SFP_TG_IPCR);
+
+	/* Wait for controller being ready. */
+	ret = xspi_readl_poll_tout(x, x->config.env, XSPI_SR, XSPI_SR_BUSY_MASK, 1,
+				   POLL_TOUT, false);
+	WARN_ON(ret);
+
+	return 0;
+}
+
+static void nxp_xspi_select_mem(struct nxp_xspi *xspi, struct spi_slave *slave,
+				const struct spi_mem_op *op)
+{
+	unsigned long rate = slave->max_hz;
+
+	if (xspi->dtr == op->cmd.dtr)
+		return;
+
+	if (!op->cmd.dtr) {
+		nxp_xspi_disable_ddr(xspi);
+		rate = min(xspi->support_max_rate, rate);
+		xspi->dtr = false;
+	} else {
+		nxp_xspi_enable_ddr(xspi);
+		rate = min(xspi->support_max_rate, rate);
+		rate *= 2;
+		xspi->dtr = true;
+	}
+
+#if CONFIG_IS_ENABLED(CLK)
+	int ret;
+
+	nxp_xspi_clk_disable_unprep(xspi);
+
+	ret = clk_set_rate(&xspi->clk, rate);
+	if (ret < 0)
+		return;
+
+	ret = nxp_xspi_clk_prep_enable(xspi);
+	if (ret)
+		return;
+#endif
+
+	if (!op->cmd.dtr || rate < MHZ(60))
+		nxp_xspi_dll_bypass(xspi);
+	else
+		nxp_xspi_dll_auto(xspi, rate);
+}
+
+static int nxp_xspi_exec_op(struct spi_slave *slave,
+			    const struct spi_mem_op *op)
+{
+	struct nxp_xspi *x;
+	struct udevice *bus;
+	int err = 0;
+
+	bus = slave->dev->parent;
+	x = dev_get_priv(bus);
+
+	dev_dbg(bus, "%s:%s:%d\n", __FILE__, __func__, __LINE__);
+	dev_dbg(bus, "buswidth = %u, nbytes = %u, dtr = %u, opcode = 0x%x\n",
+		op->cmd.buswidth, op->cmd.nbytes, op->cmd.dtr, op->cmd.opcode);
+	dev_dbg(bus, "buswidth = %u, nbytes = %u, dtr = %u, val = 0x%llx\n",
+		op->addr.buswidth, op->addr.nbytes, op->addr.dtr, op->addr.val);
+	dev_dbg(bus, "buswidth = %u, nbytes = %u, dtr = %u\n",
+		op->dummy.buswidth, op->dummy.nbytes, op->dummy.dtr);
+	dev_dbg(bus, "buswidth = %u, nbytes = %u, dtr = %u, dir = %u, buf = 0x%llx\n",
+		op->data.buswidth, op->data.nbytes, op->data.dtr, op->data.dir,
+		(u64)op->data.buf.in);
+
+	nxp_xspi_select_mem(x, slave, op);
+
+	nxp_xspi_prepare_lut(x, op);
+	/*
+	 * If we have large chunks of data, we read them through the AHB bus by
+	 * accessing the mapped memory. In all other cases we use IP commands
+	 * to access the flash. Read via AHB bus may be corrupted due to
+	 * existence of an errata and therefore discard AHB read in such cases.
+	 */
+	if (op->data.nbytes > (x->config.gmid ? x->devtype_data->rxfifo : DEFAULT_XMIT_SIZE) &&
+	    op->data.dir == SPI_MEM_DATA_IN) {
+		dev_dbg(bus, "ahb read\n");
+		nxp_xspi_read_ahb(x, op);
+	} else {
+		dev_dbg(bus, "ip command\n");
+		/* Wait for controller being ready. */
+		err = xspi_readl_poll_tout(x, x->config.env, XSPI_SR, XSPI_SR_BUSY_MASK,
+					   1, POLL_TOUT, false);
+		WARN_ON(err);
+
+		xspi_writel_offset(x, x->config.env, GENMASK(31, 0), FR);
+
+		if (op->data.nbytes) {
+			if (op->data.dir == SPI_MEM_DATA_OUT)
+				nxp_xspi_fill_txfifo(x, op);
+			else if (op->data.dir == SPI_MEM_DATA_IN)
+				nxp_xspi_read_rxfifo(x, op);
+			else
+				dev_dbg(x->dev, "%d: never should happen\r\n", __LINE__);
+		} else {
+			nxp_xspi_xfer_cmd(x, op);
+		}
+	}
+
+#ifdef DEBUG
+	if (op->data.nbytes <= 10)
+		if (op->data.dir != SPI_MEM_NO_DATA)
+			print_buffer(0, op->data.buf.out, 1, op->data.nbytes, 16);
+#endif
+
+	return err;
+}
+
+static const struct spi_controller_mem_ops nxp_xspi_mem_ops = {
+	.adjust_op_size = nxp_xspi_adjust_op_size,
+	.supports_op = nxp_xspi_supports_op,
+	.exec_op = nxp_xspi_exec_op,
+};
+
+static const struct dm_spi_ops nxp_xspi_ops = {
+	.claim_bus	= nxp_xspi_claim_bus,
+	.set_speed	= nxp_xspi_set_speed,
+	.set_mode	= nxp_xspi_set_mode,
+	.mem_ops        = &nxp_xspi_mem_ops,
+};
+
+static int nxp_xspi_of_to_plat(struct udevice *bus)
+{
+	struct nxp_xspi *x = dev_get_priv(bus);
+	fdt_addr_t iobase;
+	fdt_addr_t iobase_size;
+	fdt_addr_t ahb_addr;
+	fdt_addr_t ahb_size;
+
+#if CONFIG_IS_ENABLED(CLK)
+	int ret;
+#endif
+
+	x->dev = bus;
+
+	iobase = devfdt_get_addr_size_name(bus, "xspi_base", &iobase_size);
+	if (iobase == FDT_ADDR_T_NONE) {
+		dev_err(bus, "xspi_base regs missing\n");
+		return -ENODEV;
+	}
+	x->iobase = iobase;
+
+	ahb_addr = devfdt_get_addr_size_name(bus, "xspi_mmap", &ahb_size);
+	if (ahb_addr == FDT_ADDR_T_NONE) {
+		dev_err(bus, "xspi_mmap regs missing\n");
+		return -ENODEV;
+	}
+	x->ahb_addr = ahb_addr;
+	x->a1_size = ahb_size;
+	x->a2_size = 0;
+	x->config.gmid = true;
+	x->config.env = 0;
+
+#if CONFIG_IS_ENABLED(CLK)
+	ret = clk_get_by_name(bus, "xspi", &x->clk);
+	if (ret) {
+		dev_err(bus, "failed to get xspi clock\n");
+		return ret;
+	}
+#endif
+
+	dev_dbg(bus, "iobase=<0x%x>, ahb_addr=<0x%x>, a1_size=<0x%x>, a2_size=<0x%x>, env=<0x%x>, gmid=<0x%x>\n",
+		x->iobase, x->ahb_addr, x->a1_size, x->a2_size, x->config.env, x->config.gmid);
+
+	return 0;
+}
+
+static int nxp_xspi_config_ahb_buffers(struct nxp_xspi *x)
+{
+	u32 reg;
+
+	reg = XSPI_BUF3CR_MSTRID(0xa);
+	xspi_writel_offset(x, 0, reg, BUF0CR);
+	reg = XSPI_BUF3CR_MSTRID(0x2);
+	xspi_writel_offset(x, 0, reg, BUF1CR);
+	reg = XSPI_BUF3CR_MSTRID(0xd);
+	xspi_writel_offset(x, 0, reg, BUF2CR);
+
+	reg = XSPI_BUF3CR_MSTRID(0x6) | XSPI_BUF3CR_ALLMST_MASK;
+	reg |= XSPI_BUF3CR_ADATSZ(x->devtype_data->ahb_buf_size / 8U);
+	xspi_writel_offset(x, 0, reg, BUF3CR);
+
+	/* Only the buffer3 is used */
+	xspi_writel_offset(x, 0, 0, BUF0IND);
+	xspi_writel_offset(x, 0, 0, BUF1IND);
+	xspi_writel_offset(x, 0, 0, BUF2IND);
+
+	/* Program the Sequence ID for read/write operation. */
+	reg = XSPI_BFGENCR_SEQID_WR_EN_MASK | XSPI_BFGENCR_SEQID(CMD_LUT_FOR_AHB_CMD);
+	xspi_writel_offset(x, 0, reg, BFGENCR);
+
+	/* AHB access towards flash is broken if this AHB alignment boundary is crossed */
+	/* 0-No limit 1-256B 10-512B 11b-limit */
+	xspi_set_reg_field(x, 0, 0, BFGENCR, ALIGN);
+
+	return 0;
+};
+
+static void nxp_xspi_config_mdad(struct nxp_xspi *x)
+{
+	xspi_writel_offset(x, 0, XSPI_TG2MDAD_EXT_VLD_MASK, TG0MDAD);
+	xspi_writel_offset(x, 0, XSPI_TG2MDAD_EXT_VLD_MASK, TG1MDAD);
+	xspi_writel_offset(x, 0, XSPI_TG2MDAD_EXT_VLD_MASK, TG2MDAD_EXT);
+	xspi_writel_offset(x, 0, XSPI_TG2MDAD_EXT_VLD_MASK, TG3MDAD_EXT);
+	xspi_writel_offset(x, 0, XSPI_TG2MDAD_EXT_VLD_MASK, TG4MDAD_EXT);
+}
+
+static void nxp_xspi_config_frad(struct nxp_xspi *x)
+{
+	/* Enable Read/Write Access permissions & Valid */
+	for (int i = 0; i < 8; i++) {
+		xspi_writel(x, XSPI_FRAD0_WORD2_MD0ACP_MASK | XSPI_FRAD0_WORD2_MD1ACP_MASK,
+			    x->iobase + XSPI_FRAD0_WORD2 + (i * 0x20U));
+		xspi_writel(x, XSPI_FRAD0_WORD3_VLD_MASK,
+			    x->iobase + XSPI_FRAD0_WORD3 + (i * 0x20U));
+	}
+	for (int i = 0; i < 8; i++) {
+		xspi_writel(x, XSPI_FRAD0_WORD2_MD0ACP_MASK | XSPI_FRAD0_WORD2_MD1ACP_MASK,
+			    x->iobase + XSPI_FRAD8_WORD2 + (i * 0x20U));
+		xspi_writel(x, XSPI_FRAD0_WORD3_VLD_MASK,
+			    x->iobase + XSPI_FRAD8_WORD3 + (i * 0x20U));
+	}
+}
+
+static int nxp_xspi_default_setup(struct nxp_xspi *x)
+{
+	int ret = 0;
+	u32 reg;
+
+#if CONFIG_IS_ENABLED(CLK)
+	ret = clk_set_rate(&x->clk, 20UL * 1000000UL);
+	if (ret < 0) {
+		dev_err(x->dev, "clk_set_rate fail\n");
+		return ret;
+	}
+	dev_dbg(x->dev, "clk rate = %lu\n", clk_get_rate(&x->clk));
+
+	ret = nxp_xspi_clk_prep_enable(x);
+	if (ret) {
+		dev_err(x->dev, "nxp_xspi_clk_prep_enable fail\n");
+		return ret;
+	}
+#endif
+
+	if (x->config.gmid) {
+		reg = xspi_readl_offset(x, 0, MGC);
+		reg &= ~(XSPI_MGC_GVLD_MASK | XSPI_MGC_GVLDMDAD_MASK | XSPI_MGC_GVLDFRAD_MASK);
+		xspi_writel_offset(x, 0, reg, MGC);
+
+		xspi_writel_offset(x, 0, GENMASK(31, 0), MTO);
+	}
+
+	nxp_xspi_config_mdad(x);
+	nxp_xspi_config_frad(x);
+
+	xspi_set_reg_field(x, 0, 0, MCR, MDIS);
+
+	xspi_swreset(x);
+
+	xspi_set_reg_field(x, 0, 1, MCR, MDIS);
+
+	reg = xspi_readl_offset(x, 0, MCR);
+	reg &= ~(XSPI_MCR_END_CFG_MASK | XSPI_MCR_DQS_FA_SEL_MASK |
+		 XSPI_MCR_DDR_EN_MASK | XSPI_MCR_DQS_EN_MASK | XSPI_MCR_CKN_FA_EN_MASK |
+		 XSPI_MCR_DQS_OUT_EN_MASK | XSPI_MCR_ISD2FA_MASK | XSPI_MCR_ISD3FA_MASK);
+
+	reg |= XSPI_MCR_ISD2FA_MASK;
+	reg |= XSPI_MCR_ISD3FA_MASK;
+
+	if (x->devtype_data->little_endian)
+		reg |= XSPI_MCR_END_CFG(3);
+	else
+		reg |= XSPI_MCR_END_CFG(0);
+
+	xspi_writel_offset(x, 0, reg, MCR);
+
+	reg = xspi_readl_offset(x, 0, SFACR);
+
+	reg &= ~(uint32_t)(XSPI_SFACR_CAS_MASK | XSPI_SFACR_WA_MASK |
+			   XSPI_SFACR_BYTE_SWAP_MASK | XSPI_SFACR_WA_4B_EN_MASK |
+			   XSPI_SFACR_FORCE_A10_MASK);
+
+	xspi_writel_offset(x, 0, reg, SFACR);
+
+	nxp_xspi_config_ahb_buffers(x);
+
+	reg = XSPI_FLSHCR_TCSH(3) | XSPI_FLSHCR_TCSS(3);
+	xspi_writel_offset(x, 0, reg, FLSHCR);
+
+	xspi_writel_offset(x, 0, x->ahb_addr + x->a1_size, SFA1AD);
+	xspi_writel_offset(x, 0, x->ahb_addr + x->a1_size + x->a2_size, SFA2AD);
+
+	reg = XSPI_SMPR_DLLFSMPFA(7);
+	xspi_writel_offset(x, 0, reg, SMPR);
+
+	xspi_set_reg_field(x, 0, 0, MCR, MDIS);
+
+	xspi_swreset(x);
+
+	return ret;
+};
+
+static int nxp_xspi_probe(struct udevice *bus)
+{
+	int ret;
+	struct nxp_xspi *x = dev_get_priv(bus);
+
+	x->devtype_data =
+		(struct nxp_xspi_devtype_data *)dev_get_driver_data(bus);
+
+	ret = nxp_xspi_default_setup(x);
+	if (ret)
+		dev_err(x->dev, "nxp_xspi_default_setup fail %d\n", ret);
+
+	return ret;
+};
+
+U_BOOT_DRIVER(nxp_xspi) = {
+	.name	= "nxp_xspi",
+	.id	= UCLASS_SPI,
+	.of_match = nxp_xspi_ids,
+	.ops	= &nxp_xspi_ops,
+	.of_to_plat = nxp_xspi_of_to_plat,
+	.priv_auto	= sizeof(struct nxp_xspi),
+	.probe	= nxp_xspi_probe,
+	.flags		= DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/spi/nxp_xspi.h b/drivers/spi/nxp_xspi.h
new file mode 100644
index 00000000000..78b1e71505d
--- /dev/null
+++ b/drivers/spi/nxp_xspi.h
@@ -0,0 +1,713 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef __NXP_XSPI_H
+#define __NXP_XSPI_H
+
+/* XSPI Register defination */
+
+#define XSPI_MCR 0x0
+
+#define XSPI_MCR_CKN_FA_EN_MASK BIT(26)
+#define XSPI_MCR_CKN_FA_EN_SHIFT 26
+#define XSPI_MCR_DQS_FA_SEL_MASK GENMASK(25, 24)
+#define XSPI_MCR_DQS_FA_SEL_SHIFT 24
+#define XSPI_MCR_DQS_FA_SEL(x) ((x) << 24)
+#define XSPI_MCR_ISD3FA_MASK BIT(17)
+#define XSPI_MCR_ISD3FA_SHIFT 17
+#define XSPI_MCR_ISD3FA_MASK BIT(17)
+#define XSPI_MCR_ISD3FA_SHIFT 17
+#define XSPI_MCR_ISD2FA_MASK BIT(16)
+#define XSPI_MCR_ISD2FA_SHIFT 16
+#define XSPI_MCR_DOZE_MASK BIT(15)
+#define XSPI_MCR_DOZE_SHIFT 15
+#define XSPI_MCR_MDIS_MASK BIT(14)
+#define XSPI_MCR_MDIS_SHIFT 14
+#define XSPI_MCR_DLPEN_MASK BIT(12)
+#define XSPI_MCR_DLPEN_SHIFT 12
+#define XSPI_MCR_CLR_TXF_MASK BIT(11)
+#define XSPI_MCR_CLR_TXF_SHIFT 11
+#define XSPI_MCR_CLR_RXF_MASK BIT(10)
+#define XSPI_MCR_CLR_RXF_SHIFT 10
+#define XSPI_MCR_IPS_TG_RST_MASK BIT(9)
+#define XSPI_MCR_IPS_TG_RST_SHIFT 9
+#define XSPI_MCR_VAR_LAT_EN_MASK BIT(8)
+#define XSPI_MCR_VAR_LAT_EN_SHIFT 8
+#define XSPI_MCR_DDR_EN_MASK BIT(7)
+#define XSPI_MCR_DDR_EN_SHIFT 7
+#define XSPI_MCR_DQS_EN_MASK BIT(6)
+#define XSPI_MCR_DQS_EN_SHIFT 6
+#define XSPI_MCR_DQS_LAT_EN_MASK BIT(5)
+#define XSPI_MCR_DQS_LAT_EN_SHIFT 5
+#define XSPI_MCR_DQS_OUT_EN_MASK BIT(4)
+#define XSPI_MCR_DQS_OUT_EN_SHIFT 4
+#define XSPI_MCR_END_CFG_MASK GENMASK(3, 2)
+#define XSPI_MCR_END_CFG_SHIFT 2
+#define XSPI_MCR_END_CFG(x) ((x) << 2)
+#define XSPI_MCR_SWRSTHD_MASK BIT(1)
+#define XSPI_MCR_SWRSTHD_SHIFT 1
+#define XSPI_MCR_SWRSTSD_MASK BIT(0)
+#define XSPI_MCR_SWRSTSD_SHIFT 0
+
+#define XSPI_IPCR 0x8U
+
+#define XSPI_IPCR_SEQID_MASK GENMASK(27, 24)
+#define XSPI_IPCR_SEQID_SHIFT 24
+#define XSPI_IPCR_SEQID(x) ((x) << 24)
+#define XSPI_IPCR_IDATSZ_MASK GENMASK(14, 0)
+#define XSPI_IPCR_IDATSZ_SHIFT 0
+#define XSPI_IPCR_IDATSZ(x) ((x) << 0)
+
+#define XSPI_FLSHCR 0xCU
+
+#define XSPI_FLSHCR_TDH_MASK GENMASK(17, 16)
+#define XSPI_FLSHCR_TDH_SHIFT 16
+#define XSPI_FLSHCR_TDH(x) ((x) << 16)
+#define XSPI_FLSHCR_TCSH_MASK GENMASK(11, 8)
+#define XSPI_FLSHCR_TCSH_SHIFT 8
+#define XSPI_FLSHCR_TCSH(x) ((x) << 8)
+#define XSPI_FLSHCR_TCSS_MASK GENMASK(3, 0)
+#define XSPI_FLSHCR_TCSS_SHIFT 0
+#define XSPI_FLSHCR_TCSS(x) ((x) << 0)
+
+#define XSPI_BUF0CR 0x010U
+
+#define XSPI_BUF0CR_HP_EN_MASK BIT(31)
+#define XSPI_BUF0CR_HP_EN_SHIFT 31
+#define XSPI_BUF0CR_SUB_DIV_EN_MASK BIT(30)
+#define XSPI_BUF0CR_SUB_DIV_EN_SHIFT 30
+#define XSPI_BUF0CR_SUBBUF2_DIV_MASK GENMASK(29, 27)
+#define XSPI_BUF0CR_SUBBUF2_DIV_SHIFT 27
+#define XSPI_BUF0CR_SUBBUF2_DIV(x) ((x) << 27)
+#define XSPI_BUF0CR_SUBBUF1_DIV_MASK GENMASK(26, 24)
+#define XSPI_BUF0CR_SUBBUF1_DIV_SHIFT 24
+#define XSPI_BUF0CR_SUBBUF1_DIV(x) ((x) << 24)
+#define XSPI_BUF0CR_SUBBUF0_DIV_MASK GENMASK(23, 21)
+#define XSPI_BUF0CR_SUBBUF0_DIV_SHIFT 21
+#define XSPI_BUF0CR_SUBBUF0_DIV(x) ((x) << 21)
+#define XSPI_BUF0CR_ADATSZ_MASK GENMASK(17, 8)
+#define XSPI_BUF0CR_ADATSZ_SHIFT 8
+#define XSPI_BUF0CR_ADATSZ(x) ((x) << 8)
+#define XSPI_BUF0CR_MSTRID_MASK GENMASK(3, 0)
+#define XSPI_BUF0CR_MSTRID_SHIFT 0
+#define XSPI_BUF0CR_MSTRID(x) ((x) << 0)
+
+#define XSPI_BUF1CR 0x014U
+
+#define XSPI_BUF2CR 0x018U
+
+#define XSPI_BUF3CR 0x1CU
+
+#define XSPI_BUF3CR_ALLMST_MASK BIT(31)
+#define XSPI_BUF3CR_ALLMST_SHIFT 31
+#define XSPI_BUF3CR_SUB_DIV_EN_MASK BIT(30)
+#define XSPI_BUF3CR_SUB_DIV_EN_SHIFT 30
+#define XSPI_BUF3CR_SUBBUF2_DIV_MASK GENMASK(29, 27)
+#define XSPI_BUF3CR_SUBBUF2_DIV_SHIFT 27
+#define XSPI_BUF3CR_SUBBUF2_DIV(x) ((x) << 27)
+#define XSPI_BUF3CR_SUBBUF1_DIV_MASK GENMASK(26, 24)
+#define XSPI_BUF3CR_SUBBUF1_DIV_SHIFT 24
+#define XSPI_BUF3CR_SUBBUF1_DIV(x) ((x) << 24)
+#define XSPI_BUF3CR_SUBBUF0_DIV_MASK GENMASK(23, 21)
+#define XSPI_BUF3CR_SUBBUF0_DIV_SHIFT 21
+#define XSPI_BUF3CR_SUBBUF0_DIV(x) ((x) << 21)
+#define XSPI_BUF3CR_ADATSZ_MASK GENMASK(17, 8)
+#define XSPI_BUF3CR_ADATSZ_SHIFT 8
+#define XSPI_BUF3CR_ADATSZ(x) ((x) << 8)
+#define XSPI_BUF3CR_MSTRID_MASK GENMASK(3, 0)
+#define XSPI_BUF3CR_MSTRID_SHIFT 0
+#define XSPI_BUF3CR_MSTRID(x) ((x) << 0)
+
+#define XSPI_BUF0IND 0x030U
+
+#define XSPI_BUF0IND_TPINDX_MASK GENMASK(12, 3)
+#define XSPI_BUF0IND_TPINDX_SHIFT 3
+#define XSPI_BUF0IND_TPINDX(x) ((x) << 3)
+
+#define XSPI_BUF1IND 0x034U
+
+#define XSPI_BUF2IND 0x038U
+
+#define XSPI_AWRCR 0x50
+
+#define XSPI_AWRCR_PPW_WR_DIS_MASK BIT(15)
+#define XSPI_AWRCR_PPW_WR_DIS_SHIFT 15
+#define XSPI_AWRCR_PPW_RD_DIS_MASK BIT(14)
+#define XSPI_AWRCR_PPW_RD_DIS_SHIFT 14
+
+#define XSPI_DLLCRA 0x60U
+
+#define XSPI_DLLCRA_DLLEN_MASK BIT(31)
+#define XSPI_DLLCRA_DLLEN_SHIFT 31
+#define XSPI_DLLCRA_FREQEN_MASK BIT(30)
+#define XSPI_DLLCRA_FREQEN_SHIFT 30
+#define XSPI_DLLCRA_DLL_REFCNTR_MASK GENMASK(27, 24)
+#define XSPI_DLLCRA_DLL_REFCNTR_SHIFT 24
+#define XSPI_DLLCRA_DLL_REFCNTR(x) ((x) << 24)
+#define XSPI_DLLCRA_DLLRES_MASK GENMASK(23, 20)
+#define XSPI_DLLCRA_DLLRES_SHIFT 20
+#define XSPI_DLLCRA_DLLRES(x) ((x) << 20)
+#define XSPI_DLLCRA_SLV_FINE_OFFSET_MASK GENMASK(19, 16)
+#define XSPI_DLLCRA_SLV_FINE_OFFSET_SHIFT 16
+#define XSPI_DLLCRA_SLV_FINE_OFFSET(x) ((x) << 16)
+#define XSPI_DLLCRA_SLV_DLY_OFFSET_MASK GENMASK(14, 12)
+#define XSPI_DLLCRA_SLV_DLY_OFFSET_SHIFT 12
+#define XSPI_DLLCRA_SLV_DLY_OFFSET(x) ((x) << 12)
+#define XSPI_DLLCRA_SLV_DLY_COARSE_MASK GENMASK(11, 8)
+#define XSPI_DLLCRA_SLV_DLY_COARSE_SHIFT 8
+#define XSPI_DLLCRA_SLV_DLY_COARSE(x) ((x) << 8)
+#define XSPI_DLLCRA_SLV_DLY_FINE_MASK GENMASK(7, 5)
+#define XSPI_DLLCRA_SLV_DLY_FINE_SHIFT 5
+#define XSPI_DLLCRA_SLV_DLY_FINE(x) ((x) << 5)
+#define XSPI_DLLCRA_DLL_CDL8_MASK BIT(4)
+#define XSPI_DLLCRA_DLL_CDL8_SHIFT 4
+#define XSPI_DLLCRA_SLAVE_AUTO_UPDT_MASK BIT(3)
+#define XSPI_DLLCRA_SLAVE_AUTO_UPDT_SHIFT 3
+#define XSPI_DLLCRA_SLV_EN_MASK BIT(2)
+#define XSPI_DLLCRA_SLV_EN_SHIFT 2
+#define XSPI_DLLCRA_SLV_DLL_BYPASS_MASK BIT(1)
+#define XSPI_DLLCRA_SLV_DLL_BYPASS_SHIFT 1
+#define XSPI_DLLCRA_SLV_UPD_MASK BIT(0)
+#define XSPI_DLLCRA_SLV_UPD_SHIFT 0
+
+#define XSPI_SFACR 0x104U
+
+#define XSPI_SFACR_FORCE_A10_MASK BIT(22)
+#define XSPI_SFACR_FORCE_A10_SHIFT 22
+#define XSPI_SFACR_WA_4B_EN_MASK BIT(21)
+#define XSPI_SFACR_WA_4B_EN_SHIFT 21
+#define XSPI_SFACR_CAS_INTRLVD_MASK BIT(20)
+#define XSPI_SFACR_CAS_INTRLVD_SHIFT 20
+#define XSPI_SFACR_RX_BP_EN_MASK BIT(18)
+#define XSPI_SFACR_RX_BP_EN_SHIFT 18
+#define XSPI_SFACR_BYTE_SWAP_MASK BIT(17)
+#define XSPI_SFACR_BYTE_SWAP_SHIFT 17
+#define XSPI_SFACR_WA_MASK BIT(16)
+#define XSPI_SFACR_WA_SHIFT 16
+#define XSPI_SFACR_PPWB_MASK GENMASK(12, 8)
+#define XSPI_SFACR_PPWB_SHIFT 8
+#define XSPI_SFACR_PPWB(x) ((x) << 8)
+#define XSPI_SFACR_CAS_MASK GENMASK(3, 0)
+#define XSPI_SFACR_CAS_SHIFT 0
+#define XSPI_SFACR_CAS(x) ((x) << 0)
+
+#define XSPI_SFAR 0x100U
+
+#define XSPI_SFAR_SFADR_MASK GENMASK(31, 0)
+#define XSPI_SFAR_SFADR_SHIFT 0
+#define XSPI_SFAR_SFADR(x) ((x) << 0)
+
+#define XSPI_SMPR 0x108U
+
+#define XSPI_SMPR_DLLFSMPFA_MASK GENMASK(26, 24)
+#define XSPI_SMPR_DLLFSMPFA_SHIFT 24
+#define XSPI_SMPR_DLLFSMPFA(x) ((x) << 24)
+#define XSPI_SMPR_FSDLY_MASK BIT(6)
+#define XSPI_SMPR_FSDLY_SHIFT 6
+#define XSPI_SMPR_FSPHS_MASK BIT(5)
+#define XSPI_SMPR_FSPHS_SHIFT 5
+
+#define XSPI_RBSR 0x10CU
+
+#define XSPI_RBSR_RDCTR_MASK GENMASK(31, 16)
+#define XSPI_RBSR_RDCTR_SHIFT 16
+#define XSPI_RBSR_RDCTR(x) ((x) << 16)
+#define XSPI_RBSR_RDBFL_MASK GENMASK(8, 0)
+#define XSPI_RBSR_RDBFL_SHIFT 0
+#define XSPI_RBSR_RDBFL(x) ((x) << 0)
+
+#define XSPI_RBCT 0x110U
+
+#define XSPI_RBCT_WMRK_MASK GENMASK(8, 0)
+#define XSPI_RBCT_WMRK_SHIFT 0
+#define XSPI_RBCT_WMRK(x) ((x) << 0)
+
+#define XSPI_DLLSR 0x12CU
+
+#define XSPI_DLLSR_DLLA_LOCK_MASK BIT(15)
+#define XSPI_DLLSR_DLLA_LOCK_SHIFT 15
+#define XSPI_DLLSR_SLVA_LOCK_MASK BIT(14)
+#define XSPI_DLLSR_SLVA_LOCK_SHIFT 14
+#define XSPI_DLLSR_DLLA_RANGE_ERR_MASK BIT(13)
+#define XSPI_DLLSR_DLLA_RANGE_ERR_SHIFT 13
+#define XSPI_DLLSR_DLLA_FINE_UNDERFLOW_MASK BIT(12)
+#define XSPI_DLLSR_DLLA_FINE_UNDERFLOW_SHIFT 12
+#define XSPI_DLLSR_DLLA_SLV_FINE_VAL_MASK GENMASK(7, 4)
+#define XSPI_DLLSR_DLLA_SLV_FINE_VAL_SHIFT 4
+#define XSPI_DLLSR_DLLA_SLV_FINE_VAL(x) ((x) << 4)
+#define XSPI_DLLSR_DLLA_SLV_COARSE_VAL_MASK GENMASK(3, 0)
+#define XSPI_DLLSR_DLLA_SLV_COARSE_VAL_SHIFT 0
+#define XSPI_DLLSR_DLLA_SLV_COARSE_VAL(x) ((x) << 0)
+
+#define XSPI_DLCR 0x130U
+
+#define XSPI_DLCR_DL_NONDLP_FLSH_MASK BIT(24)
+#define XSPI_DLCR_DL_NONDLP_FLSH_SHIFT 24
+#define XSPI_DLCR_DLP_SEL_FA_MASK GENMASK(15, 14)
+#define XSPI_DLCR_DLP_SEL_FA_SHIFT 14
+#define XSPI_DLCR_DLP_SEL_FA(x) ((x) << 14)
+
+#define XSPI_TBSR 0x150U
+
+#define XSPI_TBSR_TRCTR_MASK GENMASK(31, 16)
+#define XSPI_TBSR_TRCTR_SHIFT 16
+#define XSPI_TBSR_TRCTR(x) ((x) << 16)
+#define XSPI_TBSR_TRBFL_MASK GENMASK(8, 0)
+#define XSPI_TBSR_TRBFL_SHIFT 0
+#define XSPI_TBSR_TRBFL(x) ((x) << 0)
+
+#define XSPI_TBDR 0x154U
+
+#define XSPI_TBDR_TXDATA_MASK GENMASK(31, 0)
+#define XSPI_TBDR_TXDATA_SHIFT 0
+#define XSPI_TBDR_TXDATA(x) ((x) << 0)
+
+#define XSPI_TBCT 0x158U
+
+#define XSPI_TBCT_WMRK_MASK GENMASK(7, 0)
+#define XSPI_TBCT_WMRK_SHIFT 0
+#define XSPI_TBCT_WMRK(x) ((x) << 0)
+
+#define XSPI_SR 0x15CU
+
+#define XSPI_SR_TXFULL_MASK BIT(27)
+#define XSPI_SR_TXFULL_SHIFT 27
+#define XSPI_SR_TXDMA_MASK BIT(26)
+#define XSPI_SR_TXDMA_SHIFT 26
+#define XSPI_SR_TXWA_MASK BIT(25)
+#define XSPI_SR_TXWA_SHIFT 25
+#define XSPI_SR_TXNE_MASK BIT(24)
+#define XSPI_SR_TXNE_SHIFT 24
+#define XSPI_SR_RXDMA_MASK BIT(23)
+#define XSPI_SR_RXDMA_SHIFT 23
+#define XSPI_SR_ARB_STATE_MASK GENMASK(22, 20)
+#define XSPI_SR_ARB_STATE_SHIFT 20
+#define XSPI_SR_ARB_STATE(x) ((x) << 20)
+#define XSPI_SR_RXFULL_MASK BIT(19)
+#define XSPI_SR_RXFULL_SHIFT 19
+#define XSPI_SR_RXWE_MASK BIT(16)
+#define XSPI_SR_RXWE_SHIFT 16
+#define XSPI_SR_ARB_LCK_MASK BIT(15)
+#define XSPI_SR_ARB_LCK_SHIFT 15
+#define XSPI_SR_AHBnFUL_MASK GENMASK(14, 11)
+#define XSPI_SR_AHBnFUL_SHIFT 11
+#define XSPI_SR_AHBnFUL(x) ((x) << 11)
+#define XSPI_SR_AHBnNE_MASK GENMASK(10, 7)
+#define XSPI_SR_AHBnNE_SHIFT 7
+#define XSPI_SR_AHBnNE(x) ((x) << 7)
+#define XSPI_SR_AHBTRN_MASK BIT(6)
+#define XSPI_SR_AHBTRN_SHIFT 6
+#define XSPI_SR_AWRACC_MASK BIT(4)
+#define XSPI_SR_AWRACC_SHIFT 4
+#define XSPI_SR_AHB_ACC_MASK BIT(2)
+#define XSPI_SR_AHB_ACC_SHIFT 2
+#define XSPI_SR_IP_ACC_MASK BIT(1)
+#define XSPI_SR_IP_ACC_SHIFT 1
+#define XSPI_SR_BUSY_MASK BIT(0)
+#define XSPI_SR_BUSY_SHIFT 0
+
+#define XSPI_FR 0x160U
+
+#define XSPI_FR_DLPFF_MASK BIT(31)
+#define XSPI_FR_DLPFF_SHIFT 31
+#define XSPI_FR_DLLABRT_MASK BIT(28)
+#define XSPI_FR_DLLABRT_SHIFT 28
+#define XSPI_FR_TBFF_MASK BIT(27)
+#define XSPI_FR_TBFF_SHIFT 27
+#define XSPI_FR_TBUF_MASK BIT(26)
+#define XSPI_FR_TBUF_SHIFT 26
+#define XSPI_FR_DLLUNLCK_MASK BIT(24)
+#define XSPI_FR_DLLUNLCK_SHIFT 24
+#define XSPI_FR_ILLINE_MASK BIT(23)
+#define XSPI_FR_ILLINE_SHIFT 23
+#define XSPI_FR_RBOF_MASK BIT(17)
+#define XSPI_FR_RBOF_SHIFT 17
+#define XSPI_FR_RBDF_MASK BIT(16)
+#define XSPI_FR_RBDF_SHIFT 16
+#define XSPI_FR_AAEF_MASK BIT(15)
+#define XSPI_FR_AAEF_SHIFT 15
+#define XSPI_FR_AITEF_MASK BIT(14)
+#define XSPI_FR_AITEF_SHIFT 14
+#define XSPI_FR_AIBSEF_MASK BIT(13)
+#define XSPI_FR_AIBSEF_SHIFT 13
+#define XSPI_FR_ABOF_MASK BIT(12)
+#define XSPI_FR_ABOF_SHIFT 12
+#define XSPI_FR_CRCAEF_MASK BIT(10)
+#define XSPI_FR_CRCAEF_SHIFT 10
+#define XSPI_FR_PPWF_MASK BIT(8)
+#define XSPI_FR_PPWF_SHIFT 8
+#define XSPI_FR_IPIEF_MASK BIT(6)
+#define XSPI_FR_IPIEF_SHIFT 6
+#define XSPI_FR_IPEDERR_MASK BIT(5)
+#define XSPI_FR_IPEDERR_SHIFT 5
+#define XSPI_FR_PERFOVF_MASK BIT(2)
+#define XSPI_FR_PERFOVF_SHIFT 2
+#define XSPI_FR_RDADDR_MASK BIT(1)
+#define XSPI_FR_RDADDR_SHIFT 1
+#define XSPI_FR_TFF_MASK BIT(0)
+#define XSPI_FR_TFF_SHIFT 0
+
+#define XSPI_SFA1AD 0x180U
+
+#define XSPI_SFA1AD_TPAD_MASK GENMASK(31, 10)
+#define XSPI_SFA1AD_TPAD_SHIFT 10
+#define XSPI_SFA1AD_TPAD(x) ((x) << 10)
+
+#define XSPI_SFA2AD 0x184U
+
+#define XSPI_DLPR 0x190U
+
+#define XSPI_DLPR_DLPV_MASK GENMASK(31, 0)
+#define XSPI_DLPR_DLPV_SHIFT 0
+#define XSPI_DLPR_DLPV(x) ((x) << 0)
+
+#define XSPI_RBDR 0x200U
+
+#define XSPI_LUTKEY 0x300U
+
+#define XSPI_LCKCR 0x304U
+
+#define XSPI_LCKCR_UNLOCK_MASK BIT(1)
+#define XSPI_LCKCR_UNLOCK_SHIFT 1
+#define XSPI_LCKCR_LOCK_MASK BIT(0)
+#define XSPI_LCKCR_LOCK_SHIFT 0
+
+#define XSPI_LUT			0x310
+
+#define XSPI_BFGENCR 0x20
+
+#define XSPI_BFGENCR_SEQID_WR_MASK GENMASK(31, 28)
+#define XSPI_BFGENCR_SEQID_WR_SHIFT 28
+#define XSPI_BFGENCR_SEQID_WR(x) ((x) << 28)
+#define XSPI_BFGENCR_ALIGN_MASK GENMASK(23, 22)
+#define XSPI_BFGENCR_ALIGN_SHIFT 22
+#define XSPI_BFGENCR_ALIGN(x) ((x) << 22)
+#define XSPI_BFGENCR_WR_FLUSH_EN_MASK BIT(21)
+#define XSPI_BFGENCR_WR_FLUSH_EN_SHIFT 21
+#define XSPI_BFGENCR_PPWF_CLR_MASK BIT(20)
+#define XSPI_BFGENCR_PPWF_CLR_SHIFT 20
+#define XSPI_BFGENCR_SEQID_WR_EN_MASK BIT(17)
+#define XSPI_BFGENCR_SEQID_WR_EN_SHIFT 17
+#define XSPI_BFGENCR_SEQID_MASK GENMASK(15, 12)
+#define XSPI_BFGENCR_SEQID_SHIFT 12
+#define XSPI_BFGENCR_SEQID(x) ((x) << 12)
+#define XSPI_BFGENCR_AHBSSIZE_MASK GENMASK(10, 9)
+#define XSPI_BFGENCR_AHBSSIZE_SHIFT 9
+#define XSPI_BFGENCR_AHBSSIZE(x) ((x) << 9)
+#define XSPI_BFGENCR_SPLITEN_MASK BIT(8)
+#define XSPI_BFGENCR_SPLITEN_SHIFT 8
+#define XSPI_BFGENCR_SEQID_RDSR_MASK GENMASK(3, 0)
+#define XSPI_BFGENCR_SEQID_RDSR_SHIFT 0
+#define XSPI_BFGENCR_SEQID_RDSR(x) ((x) << 0)
+
+#define XSPI_FRAD0_WORD2 0x808U
+
+#define XSPI_FRAD0_WORD2_EALO_MASK GENMASK(29, 24)
+#define XSPI_FRAD0_WORD2_EALO_SHIFT 24
+#define XSPI_FRAD0_WORD2_EALO(x) ((x) << 24)
+#define XSPI_FRAD0_WORD2_MD4ACP_MASK GENMASK(14, 12)
+#define XSPI_FRAD0_WORD2_MD4ACP_SHIFT 12
+#define XSPI_FRAD0_WORD2_MD4ACP(x) ((x) << 12)
+#define XSPI_FRAD0_WORD2_MD3ACP_MASK GENMASK(11, 9)
+#define XSPI_FRAD0_WORD2_MD3ACP_SHIFT 9
+#define XSPI_FRAD0_WORD2_MD3ACP(x) ((x) << 9)
+#define XSPI_FRAD0_WORD2_MD2ACP_MASK GENMASK(8, 6)
+#define XSPI_FRAD0_WORD2_MD2ACP_SHIFT 6
+#define XSPI_FRAD0_WORD2_MD2ACP(x) ((x) << 6)
+#define XSPI_FRAD0_WORD2_MD1ACP_MASK GENMASK(5, 3)
+#define XSPI_FRAD0_WORD2_MD1ACP_SHIFT 3
+#define XSPI_FRAD0_WORD2_MD1ACP(x) ((x) << 3)
+#define XSPI_FRAD0_WORD2_MD0ACP_MASK GENMASK(2, 0)
+#define XSPI_FRAD0_WORD2_MD0ACP_SHIFT 0
+#define XSPI_FRAD0_WORD2_MD0ACP(x) ((x) << 0)
+
+#define XSPI_FRAD1_WORD2 0x828U
+
+#define XSPI_FRAD2_WORD2 0x848U
+
+#define XSPI_FRAD3_WORD2 0x868U
+
+#define XSPI_FRAD4_WORD2 0x888U
+
+#define XSPI_FRAD5_WORD2 0x8A8U
+
+#define XSPI_FRAD6_WORD2 0x8C8U
+
+#define XSPI_FRAD7_WORD2 0x8E8U
+
+#define XSPI_FRAD8_WORD2 0x988U
+
+#define XSPI_FRAD9_WORD2 0x9A8U
+
+#define XSPI_FRAD10_WORD2 0x9C8U
+
+#define XSPI_FRAD11_WORD2 0x9E8U
+
+#define XSPI_FRAD12_WORD2 0xA08U
+
+#define XSPI_FRAD13_WORD2 0xA28U
+
+#define XSPI_FRAD14_WORD2 0xA48U
+
+#define XSPI_FRAD15_WORD2 0xA68U
+
+#define XSPI_FRAD0_WORD3 0x80CU
+
+#define XSPI_FRAD0_WORD3_VLD_MASK BIT(31)
+#define XSPI_FRAD0_WORD3_VLD_SHIFT 31
+#define XSPI_FRAD0_WORD3_LOCK_MASK GENMASK(30, 29)
+#define XSPI_FRAD0_WORD3_LOCK_SHIFT 29
+#define XSPI_FRAD0_WORD3_LOCK(x) ((x) << 29)
+#define XSPI_FRAD0_WORD3_EAL_MASK GENMASK(25, 24)
+#define XSPI_FRAD0_WORD3_EAL_SHIFT 24
+#define XSPI_FRAD0_WORD3_EAL(x) ((x) << 24)
+
+#define XSPI_FRAD1_WORD3 0x82CU
+
+#define XSPI_FRAD2_WORD3 0x84CU
+
+#define XSPI_FRAD3_WORD3 0x86CU
+
+#define XSPI_FRAD4_WORD3 0x88CU
+
+#define XSPI_FRAD5_WORD3 0x8ACU
+
+#define XSPI_FRAD6_WORD3 0x8CCU
+
+#define XSPI_FRAD7_WORD3 0x8ECU
+
+#define XSPI_FRAD8_WORD3 0x98CU
+
+#define XSPI_FRAD9_WORD3 0x9ACU
+
+#define XSPI_FRAD10_WORD3 0x9CCU
+
+#define XSPI_FRAD11_WORD3 0x9ECU
+
+#define XSPI_FRAD12_WORD3 0xA0CU
+
+#define XSPI_FRAD13_WORD3 0xA2CU
+
+#define XSPI_FRAD14_WORD3 0xA4CU
+
+#define XSPI_FRAD15_WORD3 0xA6CU
+
+#define XSPI_TG0MDAD 0x900U
+
+#define XSPI_TG0MDAD_VLD_MASK BIT(31)
+#define XSPI_TG0MDAD_VLD_SHIFT 31
+#define XSPI_TG0MDAD_LCK_MASK BIT(29)
+#define XSPI_TG0MDAD_LCK_SHIFT 29
+#define XSPI_TG0MDAD_SA_MASK GENMASK(15, 14)
+#define XSPI_TG0MDAD_SA_SHIFT 14
+#define XSPI_TG0MDAD_SA(x) ((x) << 14)
+#define XSPI_TG0MDAD_MASKTYPE_MASK BIT(12)
+#define XSPI_TG0MDAD_MASKTYPE_SHIFT 12
+#define XSPI_TG0MDAD_MASK_MASK GENMASK(11, 6)
+#define XSPI_TG0MDAD_MASK_SHIFT 6
+#define XSPI_TG0MDAD_MASK(x) ((x) << 6)
+#define XSPI_TG0MDAD_MIDMATCH_MASK GENMASK(5, 0)
+#define XSPI_TG0MDAD_MIDMATCH_SHIFT 0
+#define XSPI_TG0MDAD_MIDMATCH(x) ((x) << 0)
+
+#define XSPI_TG1MDAD 0x910U
+
+#define XSPI_MGC 0x920
+
+#define XSPI_MGC_GVLD_MASK BIT(31)
+#define XSPI_MGC_GVLD_SHIFT 31
+#define XSPI_MGC_GVLDMDAD_MASK BIT(29)
+#define XSPI_MGC_GVLDMDAD_SHIFT 29
+#define XSPI_MGC_GVLDFRAD_MASK BIT(27)
+#define XSPI_MGC_GVLDFRAD_SHIFT 27
+#define XSPI_MGC_TG1_FIX_PRIO_MASK BIT(16)
+#define XSPI_MGC_TG1_FIX_PRIO_SHIFT 16
+#define XSPI_MGC_GCLCK_MASK GENMASK(11, 10)
+#define XSPI_MGC_GCLCK_SHIFT 10
+#define XSPI_MGC_GCLCK(x) ((x) << 10)
+#define XSPI_MGC_GCLCKMID_MASK GENMASK(5, 0)
+#define XSPI_MGC_GCLCKMID_SHIFT 0
+#define XSPI_MGC_GCLCKMID(x) ((x) << 0)
+
+#define XSPI_MTO 0x928
+
+#define XSPI_MTO_SFP_ACC_TO_MASK GENMASK(31, 0)
+#define XSPI_MTO_SFP_ACC_TO_SHIFT 0
+#define XSPI_MTO_SFP_ACC_TO(x) ((x) << 0)
+
+#define XSPI_TG2MDAD_EXT 0x940U
+
+#define XSPI_TG2MDAD_EXT_VLD_MASK BIT(31)
+#define XSPI_TG2MDAD_EXT_VLD_SHIFT 31
+#define XSPI_TG2MDAD_EXT_LCK_MASK BIT(29)
+#define XSPI_TG2MDAD_EXT_LCK_SHIFT 29
+#define XSPI_TG2MDAD_EXT_SA_MASK GENMASK(15, 14)
+#define XSPI_TG2MDAD_EXT_SA_SHIFT 14
+#define XSPI_TG2MDAD_EXT_SA(x) ((x) << 14)
+#define XSPI_TG2MDAD_EXT_MASKTYPE_MASK BIT(12)
+#define XSPI_TG2MDAD_EXT_MASKTYPE_SHIFT 12
+#define XSPI_TG2MDAD_EXT_MASK_MASK GENMASK(11, 6)
+#define XSPI_TG2MDAD_EXT_MASK_SHIFT 6
+#define XSPI_TG2MDAD_EXT_MASK(x) ((x) << 6)
+#define XSPI_TG2MDAD_EXT_MIDMATCH_MASK GENMASK(5, 0)
+#define XSPI_TG2MDAD_EXT_MIDMATCH_SHIFT 0
+#define XSPI_TG2MDAD_EXT_MIDMATCH(x) ((x) << 0)
+
+#define XSPI_TG3MDAD_EXT 0x944U
+
+#define XSPI_TG4MDAD_EXT 0x948U
+
+#define XSPI_SFP_TG_IPCR 0x958U
+
+#define XSPI_SFP_TG_IPCR_SEQID_MASK GENMASK(27, 24)
+#define XSPI_SFP_TG_IPCR_SEQID_SHIFT 24
+#define XSPI_SFP_TG_IPCR_SEQID(x) ((x) << 24)
+#define XSPI_SFP_TG_IPCR_ARB_UNLOCK_MASK BIT(23)
+#define XSPI_SFP_TG_IPCR_ARB_UNLOCK_SHIFT 23
+#define XSPI_SFP_TG_IPCR_ARB_LOCK_MASK BIT(22)
+#define XSPI_SFP_TG_IPCR_ARB_LOCK_SHIFT 22
+#define XSPI_SFP_TG_IPCR_IDATSZ_MASK GENMASK(15, 0)
+#define XSPI_SFP_TG_IPCR_IDATSZ_SHIFT 0
+#define XSPI_SFP_TG_IPCR_IDATSZ(x) ((x) << 0)
+
+#define XSPI_SFP_TG_SFAR 0x95CU
+
+/* XSPI Register defination end */
+
+/* xspi data structure */
+struct nxp_xspi_devtype_data {
+	unsigned int rxfifo;
+	unsigned int rx_buf_size;
+	unsigned int txfifo;
+	unsigned int ahb_buf_size;
+	unsigned int quirks;
+	bool little_endian;
+};
+
+struct nxp_xspi {
+	struct udevice *dev;
+	u32 iobase;
+	u32 ahb_addr;
+	u32 a1_size;
+	u32 a2_size;
+	struct {
+		bool gmid:1;
+		u32 env:3;
+	} config;
+	struct clk clk;
+	struct nxp_xspi_devtype_data *devtype_data;
+	unsigned long support_max_rate;
+	bool dtr;
+};
+
+/* xspi data structure end */
+
+/********* XSPI CMD definitions ***************************/
+#define CMD_SDR 0x01U
+#define CMD_DDR 0x11U
+#define RADDR_SDR 0x02U
+#define RADDR_DDR 0x0AU
+#define CADDR_SDR 0x12U
+#define CADDR_DDR 0x13U
+#define MODE2_SDR 0x05U
+#define MODE2_DDR 0x0CU
+#define MODE4_SDR 0x06U
+#define MODE4_DDR 0x0DU
+#define MODE8_SDR 0x04U
+#define MODE8_DDR 0x0BU
+#define WRITE_SDR 0x08U
+#define WRITE_DDR 0x0FU
+#define READ_SDR 0x07U
+#define READ_DDR 0x0EU
+#define DATA_LEARN 0x10U
+#define DUMMY_CYCLE 0x03U
+#define JMP_ON_CS 0x09U
+#define JMP_TO_SEQ 0x14U
+#define CMD_STOP 0U
+
+/********* XSPI PAD definitions ************/
+#define XSPI_1PAD 0U
+#define XSPI_2PAD 1U
+#define XSPI_4PAD 2U
+#define XSPI_8PAD 3U
+
+#define DEFAULT_XMIT_SIZE 0x40U
+
+#define ENV_ADDR_SIZE 0x10000
+
+#define XSPI_LUT_KEY_VAL		(0x5AF05AF0UL)
+
+#define xspi_get_reg_field(x, env, reg_name, field_name) \
+	({ \
+		u32 reg; \
+		reg = xspi_readl_offset(x, env, reg_name); \
+		reg &= XSPI_##reg_name##_##field_name##_MASK; \
+		reg = reg >> XSPI_##reg_name##_##field_name##_SHIFT; \
+		reg; \
+	})
+
+#define xspi_set_reg_field(x, env, val, reg_name, field_name) \
+	do { \
+		u32 reg; \
+		reg = xspi_readl_offset(x, env, reg_name); \
+		reg &= ~XSPI_##reg_name##_##field_name##_MASK; \
+		reg |= (val << XSPI_##reg_name##_##field_name##_SHIFT); \
+		xspi_writel_offset(x, env, reg, reg_name); \
+	} while (0)
+
+#define xspi_writel_offset(x, env, val, offset) \
+	do { \
+		if (x->devtype_data->little_endian) \
+			out_le32((void __iomem *)(uintptr_t)x->iobase + \
+				 (env * ENV_ADDR_SIZE) + XSPI_##offset, val); \
+		else    \
+			out_be32((void __iomem *)(uintptr_t)x->iobase + \
+				 (env * ENV_ADDR_SIZE) + XSPI_##offset, val); \
+	} while (0)
+
+#define xspi_readl_offset(x, env, offset) ({ \
+	u32 reg; \
+	if (x->devtype_data->little_endian) \
+		reg = in_le32((void __iomem *)(uintptr_t)x->iobase + \
+			      (env * ENV_ADDR_SIZE) + XSPI_##offset); \
+	else \
+		reg = in_be32((void __iomem *)(uintptr_t)x->iobase + \
+			      (env * ENV_ADDR_SIZE) + XSPI_##offset); \
+	reg; \
+})
+
+#define POLL_TOUT		5000
+
+#define CMD_LUT_FOR_IP_CMD 1
+#define CMD_LUT_FOR_AHB_CMD 0
+
+/*
+ * Calculate number of required PAD bits for LUT register.
+ *
+ * The pad stands for the number of IO lines [0:7].
+ * For example, the octal read needs eight IO lines,
+ * so you should use LUT_PAD(8). This macro
+ * returns 3 i.e. use eight (2^3) IP lines for read.
+ */
+#define LUT_PAD(x) (fls(x) - 1)
+
+/*
+ * Macro for constructing the LUT entries with the following
+ * register layout:
+ *
+ *  ---------------------------------------------------
+ *  | INSTR1 | PAD1 | OPRND1 | INSTR0 | PAD0 | OPRND0 |
+ *  ---------------------------------------------------
+ */
+#define PAD_SHIFT		8
+#define INSTR_SHIFT		10
+#define OPRND_SHIFT		16
+
+/* Macros for constructing the LUT register. */
+#define LUT_DEF(idx, ins, pad, opr) \
+	((((ins) << INSTR_SHIFT) | ((pad) << PAD_SHIFT) | \
+	(opr)) << (((idx) % 2) * OPRND_SHIFT))
+
+#endif
-- 
2.43.0

