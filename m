Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B10BCCA476
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 03:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B92ED837E4;
	Mon, 13 Oct 2025 05:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="HNNT96gO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95DC883835; Mon, 13 Oct 2025 05:41:57 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F7B5837E2
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 05:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eW2mvgkknvUElje+2n8eSm3xBB8/7Nb+5wDbYYYVaeVplZQn0hy6nBYqOQQu9xzYu0q6uTvMffAI0q6u16XheG/Fnq5RYdIE+7GjhowJPiQs1ZZtD4xriuGZnkpYv/12/e+zNi/9QPxX2VE6QKN6Xb51EogWVJSAsmLADR1x30fYOyiDlicu3Vr0bySFn1scNoKC2RLOnuxS8kzdjWDI0FZbHNjzwiladHO4FlbCul4wfk9Viqj+tkuqrHqfDzcFkfCOAekR1qJPTb8XnzoMuaPW1uSUvWJKdj6hzI8fxAg8XRCQl2elABR4nvYsWyzW1jOrRPdrV66S/7e9CSXmLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74UOSdLeaGasNX1iGTLLALDb0pb6muR6UmpcKBpUPTc=;
 b=IGu7J0j3Qj53FrrSewvLThkmF3buvHlF/f9OjpGJJII3EbIuCGzJ6KzEi0kpYjZh0WeDj+2b/Ao21E/HXjtXzLK9YkCd9ciHOZb2oixjB8t0U9jNO41rPX9qZtdfCudkRDlfFAtuJhvFx6pYYkhWsl55vazLVRNZCRIXoxynWDVE5RwpZhPBBwMwpwawXmPeYohluOXn+A/39IrFuSr7Wh8gF814OSgpGDzfcXC/fDj9WWCKBWqKeBHOldCqxtPtQr9s952LHo0KXBh+jybMIVLzTmyEDEBTEltw5dLQdyD02XOT4uKHs57J4scwxrrd14S8YzN+HC2VqV8IdIMFQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74UOSdLeaGasNX1iGTLLALDb0pb6muR6UmpcKBpUPTc=;
 b=HNNT96gO24KzB/pz6Iwm15fTTrVGr/PZrG9bxvEw9kEIEeqTAuEU7pj+GiPokuA3YGOzpNGOQfIxgYbF7v0h5TFfUDvZRRAk/lR+GqGiuPLvn327VEl95P+HQ/6g6TBD2rs0ffM08QgqGUHuWMNnwZLheIURXGCNQlQgKPbHtupvy69hlAlWK/hFiutS5Lcs8SWruQpNEvBfrIYlcYjW8n95uXmu+ju+OeOEtye9/MLXipgljAqQPW8/c+sk+nmZBjByg/298TskpOyaxZaHtMjTWgsQYeH9yqSeLof9+u5NLnCHTdKDUb4VpaZbxJCZfOATWByQSXf2QLsgQLW8WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by DBBPR04MB7786.eurprd04.prod.outlook.com (2603:10a6:10:1e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 03:41:51 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 03:41:51 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de,
	festevam@gmail.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com
Subject: [PATCH 0/3] Add i.MX95 15x15 EVK support
Date: Mon, 13 Oct 2025 11:41:25 +0800
Message-Id: <20251013034128.1752157-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|DBBPR04MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f255b5-487a-4a19-57e3-08de0a0a71bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|42112799006|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9fgBEVc/GQ1ZUKul7qfDlC8gPgCkFxflb26cgpfHoPfjTbxb0k3IMWQzsdZp?=
 =?us-ascii?Q?lay6zVl0Z/i3vfsOMcKKTxT+FJagNmgfBNYoq3aKh1qgJOkv/hMDjpt8QEMd?=
 =?us-ascii?Q?JUtTTv7uPwlaFAvm9zAQzE1WUz9qSsWCjoZBX6stOUaDJf9bmeMDvBc9HJdb?=
 =?us-ascii?Q?dobNun1F32PKJ423r9Q2QDVvAL2RGIBKsIZbBQnyEME+T1qt2QEcsYwcpMCe?=
 =?us-ascii?Q?SNGxFbP5e0K9nfwmnyVwQuulkNdguZdOQ1v9/olT0uCKmJHTUonKnjo24tBZ?=
 =?us-ascii?Q?H8pCOW4L6kbzX/R8IRmLf2gtS0Qo4k0ZAo9kRVlTBCe20lS54Xvzi1HLsJtq?=
 =?us-ascii?Q?w3DfErQmPBxVmxZPTGs7vsfqTsCyeHtRNa47XAi2dD4BJ89kTJOEfWx4E1Dr?=
 =?us-ascii?Q?hDuwzI4qlHWGpsKeQCKFRwVEI36ssKaO5/xO0MNlimsQbu67U/aPwM6ZPX6L?=
 =?us-ascii?Q?Jung2q6ud6pJ6E0pbjyFJ4vyVOlQ4HFZ4xXUmyJ8fbyY4hYxxpNybl88u8oV?=
 =?us-ascii?Q?nMqZ+ZjkbELK9BMgyPm6RjevZAuyrRjIkY+zJoSZtenbrZU+iqT7aGAqA4uh?=
 =?us-ascii?Q?EWdBhqa+6/JrbgPcy7wdT9z9BL4/TV7rPWL0t86mnlu6k6fFAvIoUaOIx97M?=
 =?us-ascii?Q?LuLt5gKN4OqxmrzxV0BXtcaEF8w2irN4K6HaBpCC0aLgeCpDJYzBJLmXLZhf?=
 =?us-ascii?Q?WMsKjr7ZflSfG/s9OIiU8ZluGEaTmmnCZhBxKQVpO9hpTEuvl+XEbOm6TVAs?=
 =?us-ascii?Q?Gq64LqLjklSwylsQmm8xqffEk8NZxOcCZPuKraO1ns/vPQo8CPbgAyq4kxmG?=
 =?us-ascii?Q?sim56TiwpbG9QG3QZNrDdEEmkTAmgKi/j5GHKktMovrqYxv/LKRSpgzl277U?=
 =?us-ascii?Q?9rJfrZd1114n//wwGzcAo/luQvyugpHRKXRZZbvLdYE+RlgoARfZkDb8acE9?=
 =?us-ascii?Q?+htP0uo9xY0KAUXfx2S+aE5RNJg8X0L9ciA3B+E4VWlHn30DxD/72xxabaON?=
 =?us-ascii?Q?o3+zOmD628WWv1M4kY/2W1XmFlS7vTTc49ErEx4l0CFIxHDEZ3M4r+hTzEZJ?=
 =?us-ascii?Q?sxNErHjaVtPMuv5ox5K3vzkaHKN8tw0M6g9O01osIEZI7xb2xHZm4vlzrUoA?=
 =?us-ascii?Q?xzA1jgJUb+5zDLEWjz0CC5i0M2nV3wv1apdb+lwLQaFbprh26fYvdZ4EFWTb?=
 =?us-ascii?Q?LfdSlg7NFj8OhGmIA4gog64tKKJf2xFBEAm9U4KJDcH0m9/uN0QW0FGJbGRE?=
 =?us-ascii?Q?vcyNToFioSmjjmu08fPgagYYw2fH3kDiI6GprXa70/M9+f2ZCjTl0jraqlKW?=
 =?us-ascii?Q?qkiM3JDyXjnhOOLIFNh4KOBNIQFnmP8YMTIsyBsSw208ZvYAVsfUM7ZTZDsH?=
 =?us-ascii?Q?MYvajCvC1FYLUHQCFxyF30XoH/SvmbPc8Rwy/rmEdioXBicb1HhDNilbaTt2?=
 =?us-ascii?Q?nfuRBXzEcAvMG3jaqXdasl39e7BVqJlFECKgdgR42fdnNK57fPtJbD8rheRK?=
 =?us-ascii?Q?ZI56qUP7t3VYINIIO+oql/WjBlS6u2z0FcVU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(42112799006)(52116014)(376014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L9pjLB20NQoXnhl8bx+agyZUylskBoYrM2oPXaAY9KFdTIjcKJm5Jrycwmj/?=
 =?us-ascii?Q?BL6QAcOs6lVrO23iOFZRWq3HWSmO9Um60zxLVvvC9egPNEW6qSjSqVLGCEGV?=
 =?us-ascii?Q?05T6LLuQ1J/fGUENXHbZFAc60HTI8gElHHScHwhhlirxqKb2OW4vxVLlm58v?=
 =?us-ascii?Q?JFPX4zkQ2UCENw+ewGbAW/YQNUVRY+1x623QH3aFZ1WSevsNlsv7baEeiqSF?=
 =?us-ascii?Q?ZDyGmE/ou2lPFeCeRNEQEvFmMi1peUhhuobY3gSzgrJbIn+cTNbBnkyYEUBU?=
 =?us-ascii?Q?JBGdBmcVcPDKVC0Qtmt+0z6zyxBQz5ii8OajPz+x/2w24RcxK6gDU7zoPQI0?=
 =?us-ascii?Q?4q2yJmOAD7+ekjSM3QX2t15SE1Wf+NSxARJd5q5wtNUt17wRPaqcSQCQArhQ?=
 =?us-ascii?Q?qnb6TeihA+4XHs+pyiMyaDo92bGCEYFk4DCUQTLZHvdpk6rmSvkYyKSSMXmS?=
 =?us-ascii?Q?ucS5gFlWEkWoa2Tymu03rC/hdy4ufcf0oHJMOlcUtNaCM4XIeK2/bAoqcBfM?=
 =?us-ascii?Q?YzCSwioGs+hxbDF7RgYRITUoU5xyqpd1JyvYGQFaBoBs+zR1wXkbd2ZVARfV?=
 =?us-ascii?Q?39izznVEddCg1Ci2bsGQRMIAD/GYnljzwY478RUKLZu3UxBl4StoOnuAiMwm?=
 =?us-ascii?Q?mEAPjjT1Lt75UC7oxHrjHutmv2NTQFgp35/iTKp+8/dW3Qy3xo7u2H2qe7Ce?=
 =?us-ascii?Q?HXAvFP8CEaAFSWZHgezG+khliwMbj3XRPkHAegI7+dj9AZTxLEkYtwJwFoFh?=
 =?us-ascii?Q?CQ71DP5864EEWjK8xdZlGHKBQOAUe4uQg6BqGDI9aAIptovR+YwX/wavc83K?=
 =?us-ascii?Q?r+SrqIadb/7eQgtPNla5VWYAliFalAzmnHZfwaTv4PYIo2WcB50m5IMIQYUK?=
 =?us-ascii?Q?93PhRtWAAznegnCQgkgLrwgQI/C4dABKiRgqaXUNIv3BxRdBREEQaNuWrnUs?=
 =?us-ascii?Q?jOe/Cjs2dnevzzOun69BTgX2I/pq+GFaD/U32GxIQorfPDotbFvnq56JIuHa?=
 =?us-ascii?Q?VH+bw0hZruJGnO1xv3O0n/7wvppeyh4ImbguDo3M22HtVAlNuzXh8YM3bc+l?=
 =?us-ascii?Q?kk+Blree8bUz16TKAbwCz8mGM9vsIIsqCCbSS4rDX3EGHQt/8YtLXXan23zM?=
 =?us-ascii?Q?phI7Ota2E8nvyeylYZ9R+fujXgD3+goGaeVM2YYZd6RLGTfPYyKlnzkt460+?=
 =?us-ascii?Q?GXwbyOrJcrvqlQrnyCQZYm2GbUGQBCVNsAJLOLo7ROsyPwcmkrVWOl9tDRdG?=
 =?us-ascii?Q?CpyE9E3yY5pNrE+bToe7JGw0JJ0QLpBxU3wWHkGVvPRUTAQ0cXVwp3uG7eH8?=
 =?us-ascii?Q?3omJ2v8kdx0/Ytg5Np968Iy5sf0CYXj0fGnEWAlxotmjtbvxA//X5+RMjVA2?=
 =?us-ascii?Q?IoAHZXI0JsmcuuhXGPlmMaLx9NZ2/+zDskG0Q+q7E+UBjJhI2kGPb24W5Y4H?=
 =?us-ascii?Q?winPUV9DzeLAxEvOyNYRH1X+V/6IGvETvh5UojXJgddOh1YlH0htL5xlCxts?=
 =?us-ascii?Q?z0n5RLBWotnBGiP1RK9z8d5m1YD9pLgSYuhb7XoHNbL0oqiqSPmtbThUJbJA?=
 =?us-ascii?Q?uHa15coohJjplHhLU3k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f255b5-487a-4a19-57e3-08de0a0a71bf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 03:41:51.0019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNOLROizUcj8gp/GInOB3wxEKRieqzOp5kJbWqTyMAojmuIF7GWbWiFO8csDtxFe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7786
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

The patch set adds basic support for i.MX95 15x15 LPDDR4X EVK. We share
same board codes with i.MX95 19x19 EVK since different DTS is used.

boot log:

U-Boot SPL 2025.10-00455-g648db5f1a0a6-dirty (Oct 13 2025 - 10:56:03 +0800)
SYS Boot reason: pmic, origin: -1, errid: -1
SYS shutdown reason: pmic, origin: -1, errid: -1
Normal Boot
Trying to boot from MMC1
Primary set selected
Load image from MMC/SD 0xc4400
NOTICE:  BL31: v2.12.0(release):android-16.0.0_1.0.0-rc2
NOTICE:  BL31: Built : 04:04:45, Sep 10 2025


U-Boot 2025.10-00455-g648db5f1a0a6-dirty (Oct 13 2025 - 10:56:03 +0800)

CPU:   NXP i.MX95 Rev2.0 A55 at 1800 MHz
Model: NXP i.MX95 15X15 board
DRAM:  7.8 GiB
Core:  280 devices, 22 uclasses, devicetree: separate
MMC:   FSL_SDHC: 0, FSL_SDHC: 1, FSL_SDHC: 2
Loading Environment from MMC... Reading from MMC(0)... *** Warning - bad CRC, using default environment

PCIE-2: Link down
In:    serial@44380000
Out:   serial@44380000
Err:   serial@44380000

BuildInfo:
  - ELE firmware version 2.0.3-5f1204b7

switch to partitions #0, OK
mmc0(part 0) is current device
Net:   WARNING: no MAC address assigned for MAC0
imx_get_mac_from_fuse: fuse read err: 0

Warning: enetc-0 (eth0) using random MAC address - f2:02:36:b0:80:06
eth0: enetc-0 [PRIME]WARNING: no MAC address assigned for MAC1
imx_get_mac_from_fuse: fuse read err: 0

Warning: enetc-1 (eth1) using random MAC address - ea:ad:db:53:30:f0
, eth1: enetc-1
Hit any key to stop autoboot: 0
u-boot=>

Ye Li (3):
  imx95_evk: Share the env file for both 19x19 EVK and 15x15 EVK
  arm: dts: imx95-15x15-evk: Add -u-boot.dtsi for SPL and binman
  imx95_evk: Add basic support for iMX95 15x15 EVK

 arch/arm/dts/imx95-15x15-evk-u-boot.dtsi      |  85 ++++++++++
 arch/arm/mach-imx/imx9/Kconfig                |   7 +
 board/freescale/imx95_evk/Kconfig             |   2 +-
 .../{imx95_19x19_evk.env => imx95_evk.env}    |   0
 configs/imx95_15x15_evk_defconfig             | 148 ++++++++++++++++++
 configs/imx95_evk.config                      |   2 +-
 doc/board/nxp/imx95_evk.rst                   |  24 ++-
 include/configs/imx95_evk.h                   |   8 +-
 8 files changed, 268 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/dts/imx95-15x15-evk-u-boot.dtsi
 rename board/freescale/imx95_evk/{imx95_19x19_evk.env => imx95_evk.env} (100%)
 create mode 100644 configs/imx95_15x15_evk_defconfig

-- 
2.37.1

