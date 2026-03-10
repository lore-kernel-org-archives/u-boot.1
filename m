Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA076FD2D74
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:15:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 870FE8408D;
	Tue, 10 Mar 2026 14:12:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xeB36Gxh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D41B83FC1; Tue, 10 Mar 2026 12:44:07 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 091C283981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 12:44:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8V1mbBfa2s8HgWZx8gM3UeuJy6YGDsSN+o+V7zt8/eO6PkYNuTs9gsdbcSDMEWHf9XACLs5RFUiwZZSvg7tuaVhsTpQvSIJqyg9sdnII2rmESEVgIe1JbfDPv7yqfHHCk5B/48H7ealoX8jycVRyPH7mpYwpHMWgG6adOHPWJytqzpuCqviIT9c3bUCtPCYLLnCwqXuXGvhbLdly1Zr/GJ6b2VKJmb7gH1mtsLOR2AxSZFAm7ZNkoEsj90ovmghjine4j5xfY492aYM1Q/dvbGRbiw7YxcPRH9l3jeh8R4YhG1QCgGTmfWOmaJEC9XXulirzlyt5gCC/nLJmkOkog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGP/sqDMFxshMA6gDLAYufLtKhT4CvJqecR6KemkJcY=;
 b=rmf0juj/sz8TsMF+Ie/Ul10WwPxmvT+BfPfTApX6lvV5E/6pNage1QQ+1DfsGOuh5BlCcCwDHRGGlKc6NH3e6/ckrV9FqsaLvyqFYqdEIYs4Odt4lUdJm9qi2EFWINWTZ8SRAiel14F0u/3SNYSTCCVR8vTbbplpRJKN7I1Si/Msrjpcho2s1Uk0gzrP6+Owxh6wHWyLdjCmHkiF03IbXrMgyPAbF5Q25aaMZwde2ET72CRMeGABVy1UrUB90e71aupOyaq0RvCsBVHcj3Rie2+rUreIrsYrjZwrf7cJWPOI2QZZJENlSFr08LBmfMiy3f0fIM98WpLWebJnQYtHLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGP/sqDMFxshMA6gDLAYufLtKhT4CvJqecR6KemkJcY=;
 b=xeB36GxhaZ+MX3TSimMmW7hFlMnnVATYmEUQEES+FlV1ZT3eUMOoVYEGidzL7haduG1t60J+lNTO1evMoMZcHV4csZBIOEMn4OuW92YVAAiQmvOdmKyrDLIPQLWH1oARAsV5MdYP/wCEyiskPiHR51PdPdfM42QKe4BXEabjGVl/bJfDCajh6swLHqdT0m/PizJmACS7F/gfUnG83jHknCOMRzV36YB3hWZO+Cv6pXL9Izbj2xZ05/hmADF/z0Bo38ZfurBiMu+ReqrgtEW8Mf8SrP71cmiBJeul1hEGkOhoSpWuufvSWEPm/P0LmtiNsPk1LnsTVTCulHr4bnqR5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by MRWPR04MB11998.eurprd04.prod.outlook.com (2603:10a6:501:96::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.22; Tue, 10 Mar
 2026 11:44:00 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 11:44:00 +0000
From: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
To: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, ye.li@nxp.com, simona.toaca@nxp.com,
 viorel.suman@nxp.com, marex@nabladev.com, ravi@prevas.dk,
 fedor.ross@ifm.com, sebastien.szymanski@armadeus.com,
 joao.goncalves@toradex.com, ji.luo@nxp.com, semen.protsenko@linaro.org,
 sjg@chromium.org, tharvey@gateworks.com, ping.bai@nxp.com,
 qijian.guo@nxp.com
Subject: [PATCH 0/5] imx9{4,5}: Add Quickboot support
Date: Tue, 10 Mar 2026 13:54:19 +0200
Message-ID: <cover.1773137310.git.simona.toaca@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0002.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::7) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|MRWPR04MB11998:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ef1217-381a-4782-086a-08de7e9a51d8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|7416014; 
X-Microsoft-Antispam-Message-Info: NYibGJeTUtFekyvsNLCGiomblu61/7+zMe6sE1J8cO72j8+5KeUbDEcSOJTojQV1CBAgRSaqa9DaqrqdqCbTSSsAC590Blp990SziN8tV4IBMQt+lERNMOoAgYwbRu0s2rDnbg2mGjw9K29Fx3AZTMwv8kPN9iJblNUrYfVkNzaNQHOxmIiy7W2mThoGCW8GB1mL+JPMo8yQZn7W8tmT8Y/3OaRnx4rgvqy4dQVAdS23655IZQ0Lo9kIE0cFw6l9P7E4rts3y0nE0ncrtT3RHy7gcitjyP4YivAgKH0029i+U4lCIKafDk8PnfIaGtcMeI6wtgR8yWlKTBBZEFUrn+PLNcGXct3SvKsFu5ms5tTPp+AMVYTCQmSMeqv2+4L+4jih98yAYoFJ4BC1eUGmJ4RgkqXto4iIHoV2lTl6nt/fVECZCYQ6HtlIZaH1dOW5KefrxggRy/J32i4lU7RcIo7RDtht61b9lH3/NesojZqydSYw3uFlPQHkAXp0ekwgb3+Lsmscpy67ys+nGdBYWbV1enCZvgpD5g3VI9jugfyOmiZQqBuH8SLd0NBILXHJ2Z4bvD1D9Zg/hayIRElZDP9cXSKR8BzFcCMwQTdmG+NKuSFbvw0q2iEBTPBmFmphMsHxTRgJs6fM8qn5qXVS7zUOzUAPwbnPnLS+2zvbGR8aWyuDDb01xJNfZ5879cKF6B78ijWJCarSgn1HTRa1zDvpnp0KHK4f5MuUC/740ys=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yNczD6c6hQ2vbSu/UUxNm9Bcpx2WptMuEy1FQmiiCMcEWZilo8/OZbiTC8A4?=
 =?us-ascii?Q?0J76pDHNN2x22nFgsJ5WeLv0XyKiKvN4YmmCkms+iBd4q9UpdCNu8IHAsxT4?=
 =?us-ascii?Q?4IE120B57JCe30AoImcMRGbVsKxMNPNZabc/OVG4cJ635XGA37Nt5MSUwnY/?=
 =?us-ascii?Q?XPDQI5GtsibXuZ0TPcExQKupMhfSIcmBr24IfCUt3xhaqJLLF5LXGgVqztFD?=
 =?us-ascii?Q?j92V/znXKlTCdAz8TUbyVhJqRzQAc52Nkoehm2qu8huJ29Ix67/qxzAPDfSy?=
 =?us-ascii?Q?NajRXbvtwEAJY9Ev7bEKLEEO/yiKcw0POh6gAAQmX7GW3NTJuK7Bw6tYMGiz?=
 =?us-ascii?Q?akfYnMEIeJIbklpMmtnocsAXK/LHvszypdX78Oyzn2JUcHRgpGGmVNac/wbD?=
 =?us-ascii?Q?Ed8mrlrOIipg7gyrvio8kthuDtzu75epfKR4OdGQR5ZmkTH1A5d9uXWwTPal?=
 =?us-ascii?Q?oLqi1n5BcyFDqMLt37H6zjMm9FOCd3jmOVh7tMFCUec41u19ru+SVDk3Ffp9?=
 =?us-ascii?Q?kvf/Nli8bq5hk29cAWadGJsLiBxPq9vmyBdMNvlUw0+i+HB1piO82yAxQ7pQ?=
 =?us-ascii?Q?r8THcb9J22WsZtmZNzlozU98Gz4+tue+wzx0ignNq6foiWqR51T4VgxxbJBF?=
 =?us-ascii?Q?KXlbunyqfR673uMSwd4F8EVKTfarRnPqJ4LtyZcP+4qEx3YTbLQpVwTl8f8z?=
 =?us-ascii?Q?Sd2iDPISkycbpizwaB8rlmGTKlauPhcekvRrkdYGqFkZd4rlyMEK2AgzM8fz?=
 =?us-ascii?Q?MknBdOJMJlnoeat6Orj4MD4jS+1iArt57J3QDGHCRRCa77dRFYAADqrsFu6M?=
 =?us-ascii?Q?094CunasEARmdIUYPupSfM3dTE/8oIawxe7poY+/ahyihzgDEHQCe9Ot2a/g?=
 =?us-ascii?Q?nwAxduuXA2e+wfh4qg/y1SWdkwv50Cz6ge1eKGyd33gUIls7WnZxUyoUeEob?=
 =?us-ascii?Q?HCvvb1cXE9gIQE6Nc/XbmthdaNdEJ8fa6cqJjG0VYNQPEw1PZ+7kGxzvq6Tb?=
 =?us-ascii?Q?6IsGagvEHOzsEGMwo4j8POcGvmtA4B2GQ0hmckLr9mFwaUjCeX3Xxau+Tt8q?=
 =?us-ascii?Q?BFW+GnWpF1iw9F2YsRV//93211ch2xJnmTWi1ptIrd029H51OQ2qAOGr1LQF?=
 =?us-ascii?Q?OjLgSMI8umh6KBz6JlTpd60/cWqpNHxBIkY+T1BLDMmsvXDZMphWg4lD9iaF?=
 =?us-ascii?Q?lORnBKajVGaF/sEHQniDyRhoQCVQSbdr9U44sFr500VvtPDlF14QczgLV90J?=
 =?us-ascii?Q?I0pXjMGiBh+BsrjtNO24ndMoTNhbJRiuqUD8GKz/PAEPqfYNb9mD4v99ZtPF?=
 =?us-ascii?Q?xRwJVoBFPR2A2PRTs+KEYpupjPCPAECD/5Z7OmOe909KxzHzAQf1a/6eMRa0?=
 =?us-ascii?Q?f4ylA4mYRA+XX5xspqueWjXxq6TKwbQNJBdRvgPPyNS9210eXi4t1Z/tapII?=
 =?us-ascii?Q?sKP1qyMTTSBQPKu+Mm8V5OsPX12E4rpiRmVaezqfLtkmFq3+me1VnSDgrsNR?=
 =?us-ascii?Q?d7dD4XFXDgpykUK0pNIxo2XYW4/FZHi7cFqOc9eYCKi3eCalpvV8Vm9RBi4g?=
 =?us-ascii?Q?bXOXawVIg8F5wgFlAHP6in+AuFZPuIlPcn7ppUonCL4ht+ctPnG+H9ffC9Qe?=
 =?us-ascii?Q?UaF29ZuDHp5eIM2IZlSXNBQN+SQ90LNT5jK94wYZag5X0ZXApcKP0lhfdxCT?=
 =?us-ascii?Q?m9aaA7kP+ao6iKfc4oAdPnAzPAlInGR3mCVft/eruVh8s0Mhbv5mo/mL501P?=
 =?us-ascii?Q?PSQRCInsdQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ef1217-381a-4782-086a-08de7e9a51d8
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 11:43:59.9913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lV+ICT4UzferV12e7ZZnajCKZMeP5a0d305rcDGLqVqxny+5n4cULpHATqwZtVkAF/D0b5EsE/IxgmaQYBixww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11998
X-Mailman-Approved-At: Tue, 10 Mar 2026 14:12:35 +0100
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

From: Simona Toaca <simona.toaca@nxp.com>

This patch series adds support for saving DDR training
data to non-volatile memory on iMX94 and iMX95 platforms.
The purpose is running DDR Quickboot flow on next reboot.

The process is as follows:
- OEI runs Training flow for the DDRPHY
- OEI saves the data from training to volatile memory
- U-Boot can then save it to non-volatile memory (e.g. SD)
- OEI loads the data from NVM at cold reboot and runs Quickboot flow

By skipping training, a much lower boot time is achieved.

Simona Toaca (5):
  imx9: Add support for saving DDR training data to NVM
  arm: mach-imx: Add command to expose QB functionality
  imx9: Enable QB data saving for iMX9{4,5} EVK
  board: nxp: imx9{4,5}_evk: Add qb save option in SPL
  doc: board: nxp: Add Quickboot documentation

 arch/arm/include/asm/arch-imx9/ddr.h |  52 +++-
 arch/arm/include/asm/mach-imx/qb.h   |  15 +
 arch/arm/mach-imx/Kconfig            |  15 +
 arch/arm/mach-imx/Makefile           |   1 +
 arch/arm/mach-imx/cmd_qb.c           | 132 ++++++++
 arch/arm/mach-imx/imx9/Makefile      |  12 +-
 arch/arm/mach-imx/imx9/qb.c          | 439 +++++++++++++++++++++++++++
 arch/arm/mach-imx/imx9/scmi/soc.c    |   9 +
 board/nxp/imx94_evk/spl.c            |   6 +-
 board/nxp/imx95_evk/spl.c            |   6 +-
 configs/imx943_evk_defconfig         |   1 +
 configs/imx95_15x15_evk_defconfig    |   1 +
 configs/imx95_evk.config             |   1 +
 doc/board/nxp/index.rst              |   1 +
 doc/board/nxp/qb.rst                 |  33 ++
 drivers/ddr/imx/imx9/Kconfig         |   8 +
 drivers/ddr/imx/phy/Kconfig          |   7 +
 17 files changed, 734 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/include/asm/mach-imx/qb.h
 create mode 100644 arch/arm/mach-imx/cmd_qb.c
 create mode 100644 arch/arm/mach-imx/imx9/qb.c
 create mode 100644 doc/board/nxp/qb.rst

-- 
2.43.0

