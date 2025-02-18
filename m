Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F80C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 12:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CFA480BAD;
	Tue, 18 Feb 2025 13:06:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RIogLa6p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39A1780BAD; Tue, 18 Feb 2025 13:06:36 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DC6D8043C
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 13:06:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HL98/KYK5FLuzRTYGR4SiItnHjCNtCsoZITJkhplPxMZ9xnmxM4J74y4oq2fgCJL4570Il9u7K3SUdKP8NwGB7lQqUPJLFmocy82/OqFByPfvQZwIbKNgXKLj1XQm3vZoI0M/DjdIIwElEu63k1+0VSYIMBTPg69bX4uz85stxqM3Iw/f9UpxqfOkpmNyZ9dAinMR/j06Tp3c86pQJB5YSxG/m5CHJVSALQD08zjY3vgf9d5QmupjhJ4qnaNpQzAa/QSlM0285b3/4oc7SZpPwvuD6G8T+ubbWPI4i27oNCIuvnbfBO7Zly7qGHGF+/7ThtveF5zrTVJE90uqNg8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ov4rvUyCI5hHdXO7/bDwmOTHI76JfDD4XIxofIY9+b4=;
 b=Lwxx05GT5Erdn1XWthbR1avz+50yVp6KwvdNpSkerN1FRhCpuOkcT0y0mbwAm7q+lun2aNZPmnvHlqUH7mSGAk6D0g9qfD4ctR8LU4AN91upzjdczn7aQD2yC3gBgBFYTTP1oT2x1J92juO8VVHlR2bV0N3zkUFMrmk4E4JLPxlm9toLlmWsKaOsMBmBPiNQVwdJYMO6hA7/1hxi0rhDPLYz3w+pTqKtIhkSvPyvhGUZZk/7JmIpA5OGJJNlHW8MKSnbW/TsUzC+UIM7A/64RMBk84Z2p0bSHMIpAWQTIWhu82U3Mf2/gRZFjfv3RUNUMbHwZjI49ZH65IDIdJJJRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ov4rvUyCI5hHdXO7/bDwmOTHI76JfDD4XIxofIY9+b4=;
 b=RIogLa6p/SIjqAM3UmkS6yHeNiS/0Vfw6NPnQFEWB4sxAn+eRHKIF3wDt3QhxcjZPE/bWWHRB1NV5Lkfc16CuUnYA51pslPJ97Cvm8BnP+RoKsqpGkgfeZxM3jEV3zjSbKA1N0GAXozEn+CAGrKZp3pGlA5Ysvy0cfbmGEmbFuJX9BeEJ0UYI6uH0IzWrYAxO7Z6Z12aohYZV0ByOHHGoUpgEe3SJYokgTA8yeXa0d+xOXLidTG8Po0MNJv24GZY8IFYDoE/UFph241oSLenx0R6k/dEy7po98rrqkK3OUbSZc65gyeXorohGkxjnZceL4P4VCZW+PyHjnqqHln6vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7777.eurprd04.prod.outlook.com (2603:10a6:20b:236::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 12:06:26 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 12:06:26 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: trini@konsulko.com, sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, marex@denx.de
Cc: u-boot@lists.denx.de,
	tharvey@gateworks.com
Subject: [PATCH v5 00/20] imx: add i.MX95 support
Date: Tue, 18 Feb 2025 20:05:37 +0800
Message-ID: <20250218120559.451678-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: 323a9e87-8090-4bfb-95b1-08dd5014ab40
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b8x9ZGGjxvzLa1FjomSnDs2mWlCiBYP+wYSveu18IQMwV456lG++IGV4jkx6?=
 =?us-ascii?Q?OT0q4TBZxWLpkY2cEMuLxZLB1xvVjkO2GUcV6ygQ5ZKtBsRKqIkxQNUXBBun?=
 =?us-ascii?Q?o1cCIhEcnypQByzwpB36p2M054n/B0b+dT2SNpsJ4ZKNfcaDvW1m3VeIvekm?=
 =?us-ascii?Q?PhbqI8TDPMx8v3UrhdNn9xGtdx95VtiLOZS+Ce97vhedR3j6Ax3nbGOh4tY7?=
 =?us-ascii?Q?cQZITjhseKTRcT62+RgNLGjzqaH2TMizPGMiq4w0xKK00g9EEJ9Nm9NqDrbc?=
 =?us-ascii?Q?bCBcb7T2eqAlJyiPiQaG7PFJYzz0G4tMpXqKNvzV3VRDi8bOCq8ZCDcwDPjn?=
 =?us-ascii?Q?YuvgZIgKPTnWciZO0L2uYPZzaRZkeycExuziAVgQvx5aDPDYQrLFn2Lrl1qI?=
 =?us-ascii?Q?bUuW49s4bdNaoUvZEPvwIoXLUYGJg7I/r3PRtL06vCEE8mNp+PzkX4mJx1OG?=
 =?us-ascii?Q?HhvydZWOJs9pnuIdZ+dZsIHrYRZteYUpIgKz8IV35ll0p1bpJFhzOQboxtx/?=
 =?us-ascii?Q?fM9vsidEj0pVJhehEdYsMgG7zSJNeTwTRO+FehqF1WrphmVuSxyI6ufLTqRE?=
 =?us-ascii?Q?mCqD4E2NU/l5qwpiRH1xJh7TiXLpQKuukzUzMpKTkTMUKrSchKi7C8hyi0yX?=
 =?us-ascii?Q?0EwDL1rRUQ9so0lvupFa9gr0Sz+BYS0Jx7WDMoIfzrstfzcqP7xsMzu/2gfF?=
 =?us-ascii?Q?n09yE3pLz+8wuWWoLgsH+WFtV2o3a/jL1tcmvbVCtefOYhx2iOmmWcOobBsM?=
 =?us-ascii?Q?ZNk94+etphoDFl19CLQXpGlqOCdB6UNabefn7LXhzmfjmUcqQJo8wg8TbXDH?=
 =?us-ascii?Q?evBVSx3ed3QO2yqaA2KOk+Q2/j6SAhJXd1LhQGBwBoXXlex6dEwS+j8cATbr?=
 =?us-ascii?Q?ku2ZIFND8660HpyA3Xs0SSdog5tlaUVwKz7eyWf8KGi+W+FXr6WQSunXrkF5?=
 =?us-ascii?Q?imci/jKTgTcOrExnj+J3Z2hf/wCb07x2mY+A66mNYj8x0ThXCctbodER9plx?=
 =?us-ascii?Q?OoVoLtMweGBujnm8ZOeCVlZmT1+DcOpzxMX+8IA6axsT7w9UchPQPeTR4Igi?=
 =?us-ascii?Q?UaMzJBHVO4V2fqJnK5Xy8k2QzbqLghq5vsbEkTdxTNismQa3k7hqoiiyzeqE?=
 =?us-ascii?Q?DoMlR+7Vw1A3zYkwwXc8rSEkROaTw0njxgoAG/Q65pX+z3W4ChZz4OB+NhZ/?=
 =?us-ascii?Q?RMaoZF5j9NuIyK/22M1SdS4lvyScwVDh3mjWfw90hmeeNrQXv7afASTq5tT9?=
 =?us-ascii?Q?DDemDB1wgqsnwVdwoPA2nmqfIygSXo9tY7+9zJtQ7XVrr+vRP450pvinznLK?=
 =?us-ascii?Q?Xg/WQvjjOHqIkLs9iVEO3G4aI8HNU1ihWaQGUGxk0PHGAB5XpBbEuK0G2EgR?=
 =?us-ascii?Q?r1pET8nWjbFzmlzM15u/A44nE5WX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jqy83VPsg1MIEgh90HH2GmhxNkCMCtgFBO91X5xD7JpDxiyz65epjUj/yQfa?=
 =?us-ascii?Q?IeuuQ5R12sZIXqUCwL7zAB4nFtFT9OY/e7/vN3hfOJpSYNkEdShZvQv7FJHW?=
 =?us-ascii?Q?VNiJX9Ek1R46P+UD4hGFbfw7Iupz+1sFan61RDE9ldErRA6l539EynJWweeK?=
 =?us-ascii?Q?kjJgIPg1yv/notkNba9YULr9Fkw1p8+sT9b2GyX7YlPIyQElqpcjOicMiKpz?=
 =?us-ascii?Q?5I4PE5MAlMtCrDREt3MXEn1rDhzoVysqVCP/hbO+nICKFUN1vFSPfjT6sETG?=
 =?us-ascii?Q?qAprujFwCUe8YUcSjcImpRgktlsixmMkToydVZykygivpDkHfR9K65HAU4KK?=
 =?us-ascii?Q?9dhFEpwOs3zhroKDjew42SdSYdcuIXZnI5cNltHybrjQGC24jZy/wZfcdGyK?=
 =?us-ascii?Q?4qKYIahWV+5ibIhgJqvdhgh4pPTX+GheyBUl5C2WUYNB0BweVAM7bXqFPFCt?=
 =?us-ascii?Q?Ru3TvO3HkHtaiTlzv0pxSLBVVXyKDMNk6tkIFN09npWc7wu41nBGd/8DZFMR?=
 =?us-ascii?Q?AK/lMV+gy26gpzNPIw2sn5V5kwa1/Qpr/Cee1ZMfzhigufHbxK31g0odcL3K?=
 =?us-ascii?Q?J80LwRc60TlSc1QzXm9BsGsq8CoybzAX+dLYYUY+T2dHi8nq5YPnmDTNRuCg?=
 =?us-ascii?Q?AnX5QI5KItPnTKXpRw7mVx2S3c262NRNZTn7xeYnraf3QTR7A6CCr+N3bTh9?=
 =?us-ascii?Q?f8Ij9soC8WcnaCdxXXP/LxA4hd8jkzHzyyKCoiz6KzaIIoqdSecztNfiSnTa?=
 =?us-ascii?Q?YIGNM4a/IaNMOeOM4vYpxp13agIbh/9A0nNezA8vuqbHWG/FKBcK14tIArDc?=
 =?us-ascii?Q?hGMpEndKbHcjv8fpNFmZaXuxfpbgmeg3ik9NHJcrXPu0nOUJWxZvrYx/H46J?=
 =?us-ascii?Q?Cuk5l2+ypQAZmOcwSQ0Nv55sVzmQeW7kmftbmb/w5npU3bM1UevBP43zk3UP?=
 =?us-ascii?Q?YKO/Hf9AonmUkEDMYTfIvw3Oi2b0nYncHEKXfnnOT/CCQYSqglKgRamyW7u+?=
 =?us-ascii?Q?kJ0Lh4qk0FDJhwijJLo+4TyVoIUX5CCeVar2N0GjGYdvaiKMrGPRvXuv1UiG?=
 =?us-ascii?Q?1M9UZzjQhnqy9HlXLXxSR/ikgYEE05ZnMncIY6DZwnC9J8VVqbDAECmmnWtC?=
 =?us-ascii?Q?sGB7DATbA2JkZhvtuSu76lj2zHtbErca4zqx+t7eikodudspOjOPsBnjhu9M?=
 =?us-ascii?Q?6+P0CjFDm1SbCvnKF55pK3J6jjlYgJ2W4Hby5l/dxvWlC/HQf/nI73edJdVj?=
 =?us-ascii?Q?0JSftsuYk3VUj17zHDozK+V2lkWfSF8p34g17r85uPD4Ab3OBhFOT9SG+Mgs?=
 =?us-ascii?Q?gMQlZctC2dp+8DmaM7Ygt5mGI9Byh8BtCJZSDxxbfyQdYTEJbOZ1uz7gKNMr?=
 =?us-ascii?Q?nNCj3tl/MB3Uc6eMeOJQh8mIvvR3EQM32v4LKkhG/e3b/U9PuXtyiiHb+SJO?=
 =?us-ascii?Q?4JICTBkwJ5fP2LHC+Ne/uBV6CuwCHCIn6Q6VSnFUUUBUuZ+iCA+f2Zh8xNEu?=
 =?us-ascii?Q?lbsA6ff/0I/Qg221iQ/UUGToQm1CMYX6Su12asW2yL5s6I9THOk+luq1/uDJ?=
 =?us-ascii?Q?YrpMlsqm+4PM2gvJ1axzmb86z+TtSu2Bx/C/sFm6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323a9e87-8090-4bfb-95b1-08dd5014ab40
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 12:06:26.1937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wKqwDw1jgRoqzTbn4rrRTCpkRc2JjJhHGbfhjD2eH+xllTLLxaB7TkzT7paV0Hdxy8wFQjlhilEqQdBF5Ko+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7777
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

From: Alice Guo <alice.guo@oss.nxp.com>

Changes in v5:
 - add support for the mailbox whose type is IMX_MU_V1
 - move scmi_smt_enable_intr into drivers/firmware/scmi/smt.c
 - use the imx95 pinctrl patch from https://source.denx.de/u-boot/custodians/u-boot-usb/-/commit/3191ef0497c629017da4d88bf6a14ff0ad7c0032
 - update drivers/clk/clk_scmi.c
 - delete the macro SCMI_MSG
 - sort the select lists of config IMX95
 - update the depends on of config IMX8_ROMAPI
 - delete unnecessary DECLARE_GLOBAL_DATA_PTR
 - refresh imx95_19x19_evk_defconfig
 - add mkimage-out.imx-boot.spl, mkimage-out.imx-boot.u-boot,
   mkimage.imx-boot.spl and mkimage.imx-boot.u-boot to CLEAN_FILES

Alice Guo (9):
  pinctrl: nxp: add a pin controller driver based on SCMI pin control
    protocol
  firmware: scmi: add pin control protocol support to SCMI agent
  clk: scmi: check the clock state/parent/rate control permissions
  sandbox: add SCMI clock control permissions to sandbox
  imx: Kconfig: IMX8_ROMAPI is not configured for i.MX95
  binman: add a new entry type for packing DDR PHY firmware images
  tools: imx8image: add i.MX95 support
  doc: imx: add document for i.MX95 Image Container Format
  Makefile: add some files to CLEAN_FILES

Peng Fan (5):
  mailbox: add i.MX Messaging Unit (MU) driver
  scmi_protocols: add SCMI misc protocol protocol_id and message_id for
    getting the ROM passover data
  scmi_protocols: add SCMI Performance domain management protocol
    message IDs
  clk: scmi: add the command CLOCK_PARENT_SET
  imx9: scmi: add i.MX95 SoC and clock related code

Teo Hall (1):
  imx: add V2X container support on i.MX95

Viorel Suman (1):
  firmware: scmi: smt: Interrupt communication enable

Ye Li (4):
  scmi_protocols: update struct scmi_base_discover_list_protocols_out
  spl: imx: use trampoline buffer to load images to secure region
  imx9: add i.MX95 Kconfig and Makefile
  imx95_evk: add i.MX95 19x19 EVK board basic support

 MAINTAINERS                                   |   1 +
 Makefile                                      |   3 +-
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi      |  62 ++
 arch/arm/dts/imx95-u-boot.dtsi                | 157 ++++
 arch/arm/include/asm/arch-imx/cpu.h           |   2 +
 arch/arm/include/asm/arch-imx9/clock.h        |  10 +
 arch/arm/include/asm/arch-imx9/imx-regs.h     |   5 +
 arch/arm/include/asm/arch-imx9/sys_proto.h    |   1 +
 arch/arm/include/asm/mach-imx/sys_proto.h     |  39 +
 arch/arm/mach-imx/Kconfig                     |   2 +-
 arch/arm/mach-imx/image-container.c           |  63 +-
 arch/arm/mach-imx/imx9/Kconfig                |  14 +
 arch/arm/mach-imx/imx9/Makefile               |   9 +-
 arch/arm/mach-imx/imx9/scmi/Makefile          |   6 +
 arch/arm/mach-imx/imx9/scmi/clock.c           | 105 +++
 arch/arm/mach-imx/imx9/scmi/clock_scmi.c      | 133 +++
 arch/arm/mach-imx/imx9/scmi/container.cfg     |  10 +
 arch/arm/mach-imx/imx9/scmi/imximage.cfg      |  15 +
 arch/arm/mach-imx/imx9/scmi/soc.c             | 806 ++++++++++++++++++
 arch/sandbox/include/asm/scmi_test.h          |   4 +-
 board/freescale/imx95_evk/Kconfig             |  12 +
 board/freescale/imx95_evk/MAINTAINERS         |   6 +
 board/freescale/imx95_evk/Makefile            |  11 +
 board/freescale/imx95_evk/imx95_19x19_evk.env |  90 ++
 board/freescale/imx95_evk/imx95_evk.c         |  36 +
 board/freescale/imx95_evk/spl.c               |  72 ++
 common/spl/Kconfig                            |   6 +
 common/spl/spl_imx_container.c                |  41 +-
 configs/imx95_19x19_evk_defconfig             | 160 ++++
 doc/board/nxp/imx95_evk.rst                   | 114 +++
 doc/board/nxp/index.rst                       |   1 +
 doc/imx/imx95_container.txt                   | 136 +++
 drivers/clk/clk_scmi.c                        | 190 ++++-
 drivers/firmware/scmi/Kconfig                 |   6 +
 drivers/firmware/scmi/sandbox-scmi_agent.c    |  56 +-
 drivers/firmware/scmi/scmi_agent-uclass.c     |  11 +
 drivers/firmware/scmi/smt.c                   |  13 +
 drivers/mailbox/Kconfig                       |   7 +
 drivers/mailbox/Makefile                      |   1 +
 drivers/mailbox/imx-mailbox.c                 | 430 ++++++++++
 drivers/pinctrl/nxp/Kconfig                   |  13 +
 drivers/pinctrl/nxp/Makefile                  |   1 +
 drivers/pinctrl/nxp/pinctrl-scmi.c            | 143 ++++
 include/configs/imx95_evk.h                   |  24 +
 include/imx8image.h                           |  19 +-
 include/scmi_agent-uclass.h                   |   2 +
 include/scmi_protocols.h                      | 107 ++-
 tools/binman/entries.rst                      |  10 +
 tools/binman/etype/nxp_header_ddrfw.py        |  32 +
 tools/binman/ftest.py                         |  11 +
 tools/binman/test/346_nxp_ddrfw_imx95.dts     |  24 +
 tools/imx8image.c                             | 143 +++-
 tools/imx9_image.sh                           |   8 +
 53 files changed, 3319 insertions(+), 64 deletions(-)
 create mode 100644 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx95-u-boot.dtsi
 create mode 100644 arch/arm/mach-imx/imx9/scmi/Makefile
 create mode 100644 arch/arm/mach-imx/imx9/scmi/clock.c
 create mode 100644 arch/arm/mach-imx/imx9/scmi/clock_scmi.c
 create mode 100644 arch/arm/mach-imx/imx9/scmi/container.cfg
 create mode 100644 arch/arm/mach-imx/imx9/scmi/imximage.cfg
 create mode 100644 arch/arm/mach-imx/imx9/scmi/soc.c
 create mode 100644 board/freescale/imx95_evk/Kconfig
 create mode 100644 board/freescale/imx95_evk/MAINTAINERS
 create mode 100644 board/freescale/imx95_evk/Makefile
 create mode 100644 board/freescale/imx95_evk/imx95_19x19_evk.env
 create mode 100644 board/freescale/imx95_evk/imx95_evk.c
 create mode 100644 board/freescale/imx95_evk/spl.c
 create mode 100644 configs/imx95_19x19_evk_defconfig
 create mode 100644 doc/board/nxp/imx95_evk.rst
 create mode 100644 doc/imx/imx95_container.txt
 create mode 100644 drivers/mailbox/imx-mailbox.c
 create mode 100644 drivers/pinctrl/nxp/pinctrl-scmi.c
 create mode 100644 include/configs/imx95_evk.h
 create mode 100644 tools/binman/etype/nxp_header_ddrfw.py
 create mode 100644 tools/binman/test/346_nxp_ddrfw_imx95.dts

-- 
2.43.0

