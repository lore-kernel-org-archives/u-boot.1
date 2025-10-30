Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FA3CCF9E5
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 04:36:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7290783710;
	Thu, 30 Oct 2025 05:36:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wCxT9yz0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03394835FE; Thu, 30 Oct 2025 03:39:46 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C7BB832BC
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 03:39:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3pWb5wYjVT8XvtAG/o7nabg9yDuDa9YwAtFSsfIDkH585OpM823DmheO0AhHGDc+faSTp5EG0kppXp/BTcmOzttUi0TsCEo69fMq7x/N25CYVvmCYf0x/QS0xR64jq7MXfd4BOmxB+431IUIVr9q0cG/drGhGqeyE0Thq1VQDFieKmUkiVW95TypbhdvOiw303rW6AX1hduHeWx/ImSmawgExcVPa+UKW2qEab3jvqkTXw2+tvXTZpq/vysbVuElayx0AQbu2CQfNGSGW7O63N7xebm0wd6nj5cKpfV5D+Cnlg0HhK6OsiQdyvAtL2XCEX51YGSKePfuwLcq/Z+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8EFwHOp0pd4zo+R4KGbMb8pw5TWu3uGmhgszN/J1p8=;
 b=bUbxGVzVM7JFR++yu7tgiEfJs8Pp0vzoB/Iypp9W3185wXBw3esITjEgpSTOG0XTJ9lm4HsrRUf6eNWrJ0GN7lCO4FfAxyho8vgX4yyl/wFlhLiA33SwcIHwXfUMPBf/C/fN+jswA8nrGRXwQl+xd7Eeyet3yzc+l13g46qIdqNE873Cu/kZhe8VbPjbk4kylw4SJ5IYcFKuwHaPirSutSBBSTTD9xXkrxjTVfjdiFDnimo76KaDnxqoXYxTfOE7Dauq6ViWbI3jkRtB9VBh+IYsMXj3CfYHIWb9Mkda9oeAmndKE6G/w3/z7ZBdpiI3LH+9RLhY9fFCQRBUSDomEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8EFwHOp0pd4zo+R4KGbMb8pw5TWu3uGmhgszN/J1p8=;
 b=wCxT9yz0mFnuxw+2aXoymdBG2+KNInEuBrNkTxnNbAAfnqy+PlVp0+aeLi45G44V2vmG626hzJZ4E63L2DaloYCGtXoZBNjKl9VcpHTk0w8IM4KpLKHBzlu0TWFYWiX+hbDrZA0OmCjaKpUQuSlKn9CcdbIWLSbTGlSebTYXRJ42miFprJl771/wAlUea6GTY00dv7dB7yyblGRrXclUUxD8lxsLtgvzO/uePMoM/bVbgIcVDoiXVgSLUqFxWsCvlABH8NugxBa7EhkzoNKHSMEqtHxwztUaaZpgHPWD2mcevGvY3xzMME244jYOEh/ge0T3ZTdigbfJvqeEMG05MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8086.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 02:39:41 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 02:39:41 +0000
Date: Thu, 30 Oct 2025 11:52:01 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Subject: [GIT PULL] please pull mmc-power-2025-10-30
Message-ID: <20251030035201.GA16948@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0127.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::31) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d734d0d-ce61-482a-ebfc-08de175d9384
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|19092799006|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5nUj9lXaib3phpxzLYYVWxeUIwvkGqvcPgu+fILL/1VmjBue2OEio+JgZ+ln?=
 =?us-ascii?Q?MXLfQdgyBsSY9B1rakFBv+3EmbjHnVRYpA4uPhs1ru816OiIP0hcnoUys6cK?=
 =?us-ascii?Q?ovEtEI7B59m+6zp8VpGl0LhvJJKrENBNe+KGqjevGZC1VjbV+U3SCu+mgkCZ?=
 =?us-ascii?Q?Oebpe2qmj/Wup1npJzfzx1MOGrZBMrxhl1Vuox2mOaJDm8gxoZt/FW5vohvG?=
 =?us-ascii?Q?nvItPpxUSlTigKhjQvTijMd4focsdXyYO6EQ8Q5Y8CBllt7PCs2TLmX5fHl1?=
 =?us-ascii?Q?JAv9to5yTTXNNTtO8Zt69w0xIQt9WSws235p9C8GFMWHkapxLCRfnC4WA97F?=
 =?us-ascii?Q?NUlfPTMd+j5L/icudm04x6ZQBaoga3y+9kLpeD9zURn8IVZDw/rBL+ivep/4?=
 =?us-ascii?Q?4SnVsrIa0cIS1CfdYheBs+n9UWeADn3tYDCU/VxI2VyudzB+Ru+P5vic9KHH?=
 =?us-ascii?Q?ZL6Qlmvs9iBuDV/l7UtUru/h98iic0tiVa20lAoCq9YcH6Cp1TfzdWDFTSG6?=
 =?us-ascii?Q?UEZC0hHeOsVmPwMuCAtKNXb+YxTCzAnH4KgazXZNywHnnMi5vqEoApwekflu?=
 =?us-ascii?Q?LT4bmQ2MHZenDerPUoE8Strvf8Dychkj6ohW1ta3LalofvsmsxfwsZLzJwUA?=
 =?us-ascii?Q?EyBtqKybM/GixW23cLPBWHJM6rMMV6Xh1JSJJ8xvmEUgXXNwnSE2d986/bwH?=
 =?us-ascii?Q?OfawHMAQpCzHufGAj5cRchBCjjlxh3SDnVBE8zLjtTiS7wlUUdw4sqgRUGQe?=
 =?us-ascii?Q?YM+B01OMsFtDvsIEcKOCDIivD63ZXvCCkIFeHSOFZbWl6+K1eFshh4aGqwa+?=
 =?us-ascii?Q?BLA8u9dgo4z48Yp7ukvU1anP/bg0uomKBvFfEnElk/dHQ4TRsAgBazBFnLBT?=
 =?us-ascii?Q?moJDIncw9GwGzKvk1QonVz3BTMAfctTA1W6HA61barCnwQfyMh0u5q9jxZjB?=
 =?us-ascii?Q?I2KsUVL0DpkvqgGii9caIjJXEMxwy8h5MMFXkQtVduDE0Fex6CqJbPRFLcFq?=
 =?us-ascii?Q?5+ERVrLKaN+sg1Fvlna2/UN115vQ5WDA0gvGuSQv4GTjHWKABHTZHwVlo7Eh?=
 =?us-ascii?Q?I36li8TX8V9pKSft8cCYZtI470QGfPMZ61QoUCanVfHTsDNcshX4yxOlW/cL?=
 =?us-ascii?Q?Irt/Ub+e0YQ5W1d5Qf6NT+r3OVYysRhujCOPGswGvMJX11iOsxw7U4Yc8AQ0?=
 =?us-ascii?Q?kdFLHSaeOxk6MCdpttqw5jiClhwiW/J0yekS8PHrznV5IINvQMeTW4qlL3OQ?=
 =?us-ascii?Q?KDjZ0kABkunsbusk0sAZxIki6RhlnyQNCcoltYp80QFQhTtUyvz3U5iL7Rbx?=
 =?us-ascii?Q?88jKnl/+3mUBhxefmxqygkccnWxWnWMuvIQc7lF62xXjgv9GHR8nvBEfGxvg?=
 =?us-ascii?Q?HtdnIhjiRh3gcOY09ap5hfC6ZM3J/fS0oGIKcmVRBOXJCGyecXm7vrWj29V/?=
 =?us-ascii?Q?Up7UkEn05H/9k1EJVySnDwYx9N1Ft9WX4ryuwN78+69peWCPrqu88rbqTDXD?=
 =?us-ascii?Q?HZvrQwsAaIMIBw/219laF9NQzHA2YMVdZpoC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(19092799006)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MPi5C4RJvKkZFSqlqHnIRTw+ngy/c7L5S9ZZ1uOQ03+00LJH2KbGmuizV/5s?=
 =?us-ascii?Q?BPfNBazIj7xlS9cNPKsbW7OIjSPBMtC9co6HNBVpGoBMZGTTEqEF//jOnfzR?=
 =?us-ascii?Q?YkBHAxQ/iU+kDvrUnUCIbkJV8y4Ae0ffXl5OcvmA8bclFoMKfX0qZjBgNY6a?=
 =?us-ascii?Q?K45xX606IBXgbYjR9w95u0/JQh8d6W5stYRSWT3ek07s8XBsyOT8vDn5plsg?=
 =?us-ascii?Q?37vhOeZyDr7cQOM692IOHm9tmttuK6eqrvyYcfhD1o3QCJAM9ZygBqXS5YHe?=
 =?us-ascii?Q?aOL5dZ5p97ewpaMdqQ9iVUNlBGSnJtkptyHMWJCNDuRjStK5mS+5tAbrL3dW?=
 =?us-ascii?Q?NOK9Rd//UBEyuJr7EJATTBEVgSZyaMmZhJjUp3kpfFwdb01Rhfe/3bSy7WE3?=
 =?us-ascii?Q?aNFD4rUGP5cjeaJrGyPVIlhl3qjSV1ZwERx/Qp0Go9QWsXEym0lKV8kdg6Sa?=
 =?us-ascii?Q?QjzgW9/m6JlNPZspadrPsKUoVFZUv9cUXIVe8lIxlWHvetMGosR+Ds2u/tTt?=
 =?us-ascii?Q?rnuL/ieE411scGUMUO5mA7WTaVPUPjy+lPvTzKXYnCeQg9dvNcNIf6BZzlQU?=
 =?us-ascii?Q?Z/a7469UqH38HsqUhGALG4olJCPgHl70IEx49fjSJehBk0krdL0pJ4qwTe20?=
 =?us-ascii?Q?Mydb4eWSwwazBusdohAlPCVtR23UtQsn1IYg5QIdCCVzj9Gp/O7Ma1xKrD1U?=
 =?us-ascii?Q?+QJoOtCLEihSjsmOobDJH8FovPtzT/YFzmzfhg7Ey5PGjrXZ8adWhgZR9iDh?=
 =?us-ascii?Q?4qP4TikyigDLX+MKsYYBR0dJBA4ZLVFDgRtfGr2fkIFnsH4J4oA6MhE0pqid?=
 =?us-ascii?Q?gN8FGCTeYu1ejP7euR2eK0E0S1RtyMMfyYU3dbhTbEhL4O+x8fuXz2fB04kZ?=
 =?us-ascii?Q?JTLxKO/j9/MMpC5pR/sPbToBGbsMe2SIbzxhgJZN3FY8LOC0xG+a2+oXpze/?=
 =?us-ascii?Q?vwhmUYwxCNE3gOO7uzSsMGjHAAZvRBzG80AXmiUl9voAQ9P5zgDXXod8eJyL?=
 =?us-ascii?Q?65lj5iZnrZFLCQU45R0xgEw32VEPDFT82fsWAXT+Cn3F91ZPnGelnkx0aMpH?=
 =?us-ascii?Q?f/VQfjYx1K8aWWrxe91Tf2QdZtGXMkGQEsW1t+X0ePgT+4vYgmChu+4LgIF4?=
 =?us-ascii?Q?utH82vQNzVLIouvn64Cjs2k1CtZ9fxEntfEiR1SRDvzDihFg+0gkY1Ef0o0h?=
 =?us-ascii?Q?9laWxnM+EicHI6j4EPW6oD9jVBR8JFFdzov5FF0UaSRHT6penLcT6cZVCkiz?=
 =?us-ascii?Q?rgZUUgLsjiGYyWphsy2U6nCSv9YbxDt+E0QSVpcc+IqZCrWQMwNqcdlpoUds?=
 =?us-ascii?Q?705PoC/Uuu+utwKGRt8KsU39cWHReNmSOoCHjPbodfL6BeOHDSCb0/fBIezv?=
 =?us-ascii?Q?Mx8iTDdocIUI63FuX92zWPXZDq/gx+jS1ofmzLnGSMp1qMUqUtKNFqXHDS32?=
 =?us-ascii?Q?hqFGbMLnMMaXtArmo3YV8Xm4ryVRji8B6sDQ8vWKwZfzhTdaybR6+4f2bEj8?=
 =?us-ascii?Q?7AxRVLa57tY3Vx74TXZ6bB6q3f/zgRhpTx1rBs5kZur/3xmieDfLRzUKA5TW?=
 =?us-ascii?Q?n3qYzd/wpx23dtz6KdW4DmthGkvVhRs2Agj2jH1i?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d734d0d-ce61-482a-ebfc-08de175d9384
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 02:39:41.2722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ku/vUF6wCfKWIQCq6Hq3DL1VP21VVy0QgNA42si4rOsG3CAZWLiyNrIOrA7xd1ZeRE3Icef5o/doPY0PsZfaRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8086
X-Mailman-Approved-At: Thu, 30 Oct 2025 05:36:51 +0100
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

Hi Tom,

Please pull mmc-power-2025-10-30 for master branch

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/28083

--------------------------------------------------------------------
Add support for Samsung Exynos 7870 DW-MMC device
Add support for Samsung S2MPU05 PMIC device
Add compatible string for Exynos5250 in Exynos DW-MMC driver
Add support for handling UHS-I voltage signaling without power-cycle
Minor misc cleanup
--------------------------------------------------------------------

Thanks,
Peng

The following changes since commit e34d01d23e45e007368685ffa6dfd674b6dd7b17:

  Merge tag 'u-boot-ufs-20251029' of https://source.denx.de/u-boot/custodians/u-boot-ufs (2025-10-29 07:41:43 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mmc.git tags/mmc-power-2025-10-30

for you to fetch changes up to e16018f6b22d36f9f6b9f881175547457c06dae3:

  mmc: exynos_dw_mmc: guard execute_tuning (2025-10-30 10:11:19 +0800)

----------------------------------------------------------------
Kaustabh Chakraborty (15):
      mmc: dw_mmc: export dwmci_send_cmd() and dwmci_set_ios()
      mmc: dw_mmc: do not skip dwmci_setup_bus() for same non-zero clock frequency
      mmc: dw_mmc: properly address command completion in dwmci_control_clken()
      mmc: dw_mmc: add voltage switch command flag
      mmc: dw_mmc: return error for invalid voltage setting
      mmc: enable/disable VQMMC regulator only during MMC power cycle
      mmc: exynos_dw_mmc: add support for MMC HS200 and HS400 modes
      mmc: exynos_dw_mmc: add support for SD UHS mode
      mmc: exynos_dw_mmc: add compatible for exynos7870-dw-mshc-smu
      power: pmic: s2mps11: change the probe function to bind
      power: pmic: s2mps11: add support for allowing multiple device variants
      power: regulator: s2mps11: declaratively define LDOs and BUCKs
      power: regulator: s2mps11: declaratively get/set regulator mode
      power: regulator: s2mps11: add support for S2MPU05 PMIC
      power: pmic: s2mps11: add support for Samsung S2MPU05 PMIC

Lukas Timmermann (1):
      mmc: exynos_dw_mmc: Add compatible string for Exynos5250

Peng Fan (1):
      mmc: exynos_dw_mmc: guard execute_tuning

Tanmay Kathpalia (3):
      mmc: sd: Handle UHS-I voltage signaling without power cycle
      sdhci: Reorder interrupt flags in SDHCI_INT_DATA_MASK definition
      power: regulator: Remove duplicate include of regulator_common.h

 drivers/mmc/dw_mmc.c                        |  50 +--
 drivers/mmc/exynos_dw_mmc.c                 | 142 ++++++-
 drivers/mmc/mmc.c                           |  75 +++-
 drivers/power/pmic/s2mps11.c                |  37 +-
 drivers/power/regulator/fixed.c             |   1 -
 drivers/power/regulator/gpio-regulator.c    |   1 -
 drivers/power/regulator/regulator_common.c  |   1 -
 drivers/power/regulator/s2mps11_regulator.c | 590 +++++++++++++++++-----------
 include/dwmmc.h                             |   7 +
 include/mmc.h                               |   3 +
 include/power/s2mps11.h                     | 134 ++++++-
 include/sdhci.h                             |   2 +-
 12 files changed, 740 insertions(+), 303 deletions(-)
