Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3974CA1016
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 12:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BA6583542;
	Thu, 11 Sep 2025 14:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="JklvotfG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94AF1833D1; Thu, 11 Sep 2025 12:56:39 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F244833AD
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 12:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGHkxtrdCWuGwRxNy7PyRpiE8p3xHGt1+kM00PGpYuL3lcFxTMQJiJOovVffch3fUkxK/iWYLtV9QDdKNPt3dzzVBKRIh9z+BvFFDAyGGSRBlLyLEEn4P2NTbJk1HsUmAZsogrYmLej/hZHfvPomaEd6ESixEJUzsZwRrqktmnv4d5r8yef3NWDurtW2GIAR+BHOvgjfesBlDgSQouBOv2wRz7SjJImFuEUs0UEjRifgPt71grwmTYDmCkcoY+okJEuogmyVoubjtrIBFl/EiqYFnC7vJj2FkxDGdi2jIjbXiYFUBRTQeUKH5E3mG6f3VvuL4PCrlPd5yFF5v0zdlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhLaWJroqcywqPKcl+QK8GwYH0XfIoGt+G4+F8qxeig=;
 b=hCpvCa8UlzRaj1irETnEs1JEUxjcJJ1cpZmaKP1+8G8QjinY4vT6Cc3iAY31TX1XEDLp4awhgWE82HeFhQdyNYelmHYZfXcJx1KD6AKNIvafHUyOhtx+30dRGQYbbCeCZqhxXwsoNHv1JybPWWaVtwF2FjTAeaSoj0bAx0BO+VM4ZbwqH4jWRXdVIWHdrzSSIGxA6rTI7FuzjFpcDBcQnKtqEiuaNpoLfyUaRXF1bRhqh/CfR7aYCRYBMUxnKxC8HWl2RLeNReCUTUv2xt1mT1cnCts95O98pa8II5jaTb+b1kBr6ECceBpLZfIoM5HS77AKgRE3Ag67QetXghe6PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhLaWJroqcywqPKcl+QK8GwYH0XfIoGt+G4+F8qxeig=;
 b=JklvotfGBtHPyHgA0eTQ80lVmpFJfbhiip2/+N9TARDndYwGBkufNgignDNThMZ+OFXLXW7RQLHugfKjHx1Rco5r1iyOWlYzCwrwm4ZX1jup2JasD8Ym+rjnAZkgutbCVLrlmmXyP+xfn6YxEQFg32y7BpwzxQd4bRafzgcfGhsQbk35xLK3Gk4adDPEZfYjnfkUHfMHbRBNwyVa4bn+q5Kqsw9p49GoFcSsamspCpt1SRzLytmbxIv1JNQ5Jj34BfhrCA7CP2xN/iFaVRLTNE+YAeaKXPcUZdpffcMB0lUv7oguGuNfTaRIPmU2T4pZqYYvnsY3zjwqcjYRn1PmeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by GV4PR04MB11752.eurprd04.prod.outlook.com (2603:10a6:150:2dc::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 10:56:35 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 10:56:34 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, festevam@gmail.com, uboot-imx@nxp.com, alice.guo@nxp.com,
 ye.li@oss.nxp.com, tharvey@gateworks.com
Subject: [RESEND PATCH 0/8] Enable PCIE controller on iMX95 EVK
Date: Thu, 11 Sep 2025 18:56:03 +0800
Message-Id: <20250911105611.3664965-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|GV4PR04MB11752:EE_
X-MS-Office365-Filtering-Correlation-Id: 32e44951-2545-46e8-5656-08ddf121df3a
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|19092799006|42112799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7+216b4mO7f83N4ORkgXZTMaCE5a2N2JT2262jsUKn0Rkj986B4qY5zJKPBx?=
 =?us-ascii?Q?vLzb0N2Qwpb+bj9XSHhou7y7Bq0Bv9m3oFhlodUxGk0AxrXNJUvCzrgvI6bh?=
 =?us-ascii?Q?5iqD0UlxJD9KkXtW2IDb7jH21ZOApgrV/deYgw4YuMgIYICO552ofxgmvVx0?=
 =?us-ascii?Q?nKaU9fVHTMsHMUAhzYo3Orsvo5wBLFrf0y53sgf1SSI+q7YlNt+8suj8H4jy?=
 =?us-ascii?Q?RmuOY8xr2htc7vySPQJLRRVR5M9nSvu6BCGVXFX1/vzro/JLHP/az4b9xPKN?=
 =?us-ascii?Q?570JGLTBVv5Wi+uqG6y5cKeWxv1T/za3Sb6q3XWj1e1727MHSrgA2BUv1GDs?=
 =?us-ascii?Q?Wey6YQvg/k5f495s+xNw9xoalhD9+RltCLduzWO7OXyXDm1nvDLiGX+ntdjb?=
 =?us-ascii?Q?oGTbMHTXYNEP17LsLT7baZVOvnmclfIf/4xYzwjkCgDSeuDERZILaNsC0MJV?=
 =?us-ascii?Q?OmTiooHSq31goiKyVGqdebtuU82ClnLXzqgjoTQneHPIZABkCLDTdYXPkPHX?=
 =?us-ascii?Q?Mu8f3odl9CSs0sA0FMXp3dTHIFgjzfPcx3PEszBmr6zXMIxEzp/S3WpIWjyM?=
 =?us-ascii?Q?1dgtMObW9z93Sjg5eBDvDKPXV7BTzrsxMs02VFuK1qvsQi2jRHVznztyjBUd?=
 =?us-ascii?Q?fFDNFz7oIyhp7X+hJJVlvmAqtuJQzNoTwp0ng5fvcYC+/TkDXT3+auwiTVM1?=
 =?us-ascii?Q?xoUVqisYGxrBkqUPn2WBgGEjG5xJ/00qGmMI2ZJEAmSRVCZlN7VIQula5jDd?=
 =?us-ascii?Q?5ANoq8zc2cFIzVp+WDcgJw/zUzGfs13Jl6q2eZm7a5kPN86Ur0jVl/6zyTyx?=
 =?us-ascii?Q?dh5jPYn5VXuoYw+si91FetKE+gHrfzTlS8QYZo5QQVlqzif4V2AIWuRueD8e?=
 =?us-ascii?Q?mxVMX9jmEh1ZM6JyEQs/oPACF3T6ycURdzyzaPRIkDeEuiHU1ZRBXuLnSkTI?=
 =?us-ascii?Q?cntsfsjD35sFCOaSZqTWmg0K0xBW8W1/dj7KfS8AGAELU3hL8VNqCEVQCu+C?=
 =?us-ascii?Q?I1UIOjDcEubLRR+uHUIQPNNuwuuzKEIW9dfSt9xtXnJTVxQgusht1RJhXrPC?=
 =?us-ascii?Q?+ot2VwrtlamBEiOIKf6KgyWZod+4S9OfrPGXN2p0Il/PAE15k7sSKItRB+q1?=
 =?us-ascii?Q?AoOhge4Wpt/IUvvJPptkBcafVa0ASkL/jey35Xn3GW5xvV4wKPSm2E65T0wQ?=
 =?us-ascii?Q?/NVbHrMpxUpzs2aguvZpWNP6jsWw3zADU59URRbk6B0rgPPG8T9cCm0FelC4?=
 =?us-ascii?Q?t6Oa96xVfK4xbm/40Gl/Nz5QSs1ED/zUa9mFzBOOr0+rOhWvNhJVzuH4i2rS?=
 =?us-ascii?Q?mVraX4HvD4hwrtkAsCwXF68ogU+z9MWwst33OwEne+7RvWoCl7J1sdIwhQ4s?=
 =?us-ascii?Q?LJoDk8J+nhEaqTYJ8E9a7rNnS3Wxru9s0MAAcOHaBsq5aMwlNC3kjuaho67Z?=
 =?us-ascii?Q?ZaVS0zCda6BSFwWIifECWl8Yp/0kA+xL/UB3PbPDjM6G/qIXmOalKA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(42112799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PNg77TIIO0lj6BfXk0tq22Mr7P7GYsGC60teNSr2KEgI0BjIMvM+kgvFUre2?=
 =?us-ascii?Q?GNETMLuuaVWLfjbSzb0ogy837XWlK88/XZaJlrVP5RpVOc+iEB2S2OxJ/VK5?=
 =?us-ascii?Q?dQFrTFeKs+7sTda27Wttag8Ei0sWIPtxyYgeWl5iIGN8+rSWLt48qVl1NX/i?=
 =?us-ascii?Q?1y1naqLZRRffUo7pDwcdf8Dp+k4oV/YyfX//+9uWsddPPWm2/PhWioaBpEe/?=
 =?us-ascii?Q?Tb7iNOqPo2pk5ErG1knRqbwYh83EeBLzGx94rg6jZsAlpaXbtAClud+oWe7m?=
 =?us-ascii?Q?eRbMW3Cri1DF0UwFIieRK8Pl1CkEMEzkTGJmXEwAn8LLYCgu8XDN+WYZ2FH/?=
 =?us-ascii?Q?AYRNOosPOEDOiQXDpHixrTa78L4VcOzZWwI1SWO0DmqeKy+WEnbzjqcsqNh2?=
 =?us-ascii?Q?QEm356Tys/0Q6viFx2EMgICzIC2UvEOtnQjWcwVJUIdkc8mEatLv89Q/jwbh?=
 =?us-ascii?Q?7DUgyWJYHOlnKx3bGoybkRiDQAovFrDzgW89IRllVG30ADMbDmEwIM1nJ9uY?=
 =?us-ascii?Q?UL84zWN2OD5cg4OkbNp6JGqvwd7lqorojeNxQx2cfFKeri5qqhvkG6vM6ftK?=
 =?us-ascii?Q?Rsrflyrh24oaPkDiHUch4oV7xpHpsVtYCNPDWKcnNeZK2H5W4R3R/Vc382z2?=
 =?us-ascii?Q?/BU2ipILGIz99SSVorLytoT4vnrvMwWFcj+wC/R/4SrPRCvPT28hgoZtAXmr?=
 =?us-ascii?Q?0h2jAwy7dQUhPetH8IK6Ftt25adPYOW8lupSPAWIA7vwH1k19cplA3lyW7Af?=
 =?us-ascii?Q?Jd7iXzWrFbktWiNHihPhRaPjT5lWK6nwCdp8JXS8feQbP/hNSCi4kBlxpLil?=
 =?us-ascii?Q?Hvef2mpt7gEnbQstzNSFGgbHRCNGdww/rGaQBBhzuDhIEWfjbaJirJdaDart?=
 =?us-ascii?Q?ezT/yc/0HDVe5TgIDCUdo70eGQb/5y/GoWzC54Kn6DG+odmkXJ3SzFGecTj4?=
 =?us-ascii?Q?P3ysKYJCAaqkm8aJkwhqcpu/sQYUEhvU2MWPKUaR6tUiWzzL6dd1vYpuWqot?=
 =?us-ascii?Q?xbdx+jcvGzMb9slHE15HsA89twpAS/UZouA+OA2VBoJcuIqqsFTjW5bWiNTp?=
 =?us-ascii?Q?pbORo5FqdH/tIkaimlMpMi0vjKptOoN7hkCROLm4l4oJSRN/XsiVLBeER9O9?=
 =?us-ascii?Q?FpQNWJ/gSSkaWoSLfhFgfkubZNYhPc12xhWSST0z3s7whLuwbtQnkSKi4Oty?=
 =?us-ascii?Q?YUj0FpwMPmeeY1jrX4t3rMJCdacGaxAU5yeJcSsUIPAr4CT90IjSBqwlEke1?=
 =?us-ascii?Q?9f9CKEFjgxy8iN+0Tju+N/1Kxoj9aSkRdOKxgiHA31pUAK/XONqS+EGWnxpr?=
 =?us-ascii?Q?/HjPfYfQwIVyI1R7UjfkDSJWFEZ3QyKAyF7U3w55JiKvHM1nIMscjR6Qn+sN?=
 =?us-ascii?Q?rhFSSeB9PMFmFCEvqN4kUthdWHAWr2ZgJfuaExiKqOcAIulqd3ZNYTjcKUwI?=
 =?us-ascii?Q?ljFsflehAealussR7uHSTEIUYUmHXI75QHaXRp+eLBbyO5FYNSMRQFA80tiz?=
 =?us-ascii?Q?lH3/RS2wfGO0I13xFmZA3Utf3IxTDCl2zIfhR7kkJ1kLt2zX5bT9OB1KUrph?=
 =?us-ascii?Q?WOaRms71/VPf95Nw4yM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e44951-2545-46e8-5656-08ddf121df3a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 10:56:33.9329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lU7bwIVFzWH1UQtsbKWXLvYkTjFg2bHbTVL08xGwU4KVljIG9yG939xF13XXNEV+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11752
X-Mailman-Approved-At: Thu, 11 Sep 2025 14:15:16 +0200
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

The patch set is used to enable PCIE host controller on iMX95 EVK.
We need below driver changes:
1. Add iMX95 support to pcie_dw_imx driver.
2. Add iXM95 blkctrl clock driver which is a abstract of clock gate
   in hsio blkctrl for PCIE.
3. Add vin-supply enablement for fixed regulator, since iMX95 EVK
   uses two levels regulators in DTS.
4. Fix issue in clk-uclass when assign high clock rate.

log on iMX95 19x19 EVK:

      u-boot=> pci
      BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
      _____________________________________________________________
      00.00.00   0x1131     0xe101     Network controller      0x00
      00.01.00   0x1131     0xe001     Base system peripheral  0x07
      01.00.00   0x1131     0xee00     Base system peripheral  0x80
      01.01.00   0x1131     0xe001     Base system peripheral  0x07
      02.00.00   0x1131     0x0000     Bridge device           0x04
      03.00.00   0x1b4b     0x2b43     Network controller      0x00
      03.00.01   0x1b4b     0x2b44     Network controller      0x00
      PCIE-4: Link down



Ye Li (8):
  pci: dw: Fix wrong register used for PCI_COMMAND
  pci: pcie_dw_imx: Add iMX9 support to the driver
  clk: imx: Add imx95 blkctrl clock driver
  power: regulator: Add vin-supply for GPIO and Fixed regulators
  clk: clk-uclass: Fix clk_set_default_rates issue
  arm: dts: imx95: Assign HSIOPLL_VCO as HSIOPLL parent clock
  arm: dts: imx95-evk: set alias for enetc PCI buses
  imx95_evk: Enable PCI host controller on iMX95 19x19 EVK

 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi   |   7 +
 arch/arm/dts/imx95-u-boot.dtsi             |  16 ++
 configs/imx95_19x19_evk_defconfig          |   3 +
 drivers/clk/clk-uclass.c                   |   2 +-
 drivers/clk/imx/Kconfig                    |   9 +
 drivers/clk/imx/Makefile                   |   1 +
 drivers/clk/imx/clk-imx95-blkctrl.c        | 170 ++++++++++++
 drivers/pci/Kconfig                        |   2 +-
 drivers/pci/pcie_dw_common.c               |   3 +-
 drivers/pci/pcie_dw_imx.c                  | 420 ++++++++++++++++++++++++++---
 drivers/power/regulator/regulator_common.c |  10 +
 drivers/power/regulator/regulator_common.h |   1 +
 12 files changed, 596 insertions(+), 48 deletions(-)
 create mode 100644 drivers/clk/imx/clk-imx95-blkctrl.c

-- 
2.7.4

