Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6318CCA1016
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 12:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1FC3833E1;
	Thu, 11 Sep 2025 14:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="b9qWTzyT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 632BF83327; Thu, 11 Sep 2025 11:59:13 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8DEC83314
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 11:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oM7AeRx5Omk6Ks4XdI1TrNH4xfqmXm1XlMEFS3pCegr3NfMaSn6BcwGD+tkR3YykNSRmnfgb/SAHWPQU+ZxmfSjYn7HsUaJ/KOu6c42uQhLHvA3kpaDQpGFJdICKAx8dyBz0TZAYrBSWpxlv5ZligKO9q1OKWTj4wu0OFwZSsJrNfGLmuk9IzN96UifNgzmq5/pbKuSjfFJx/REYySqAnKhhiWrn8N8e/orQXFKhg5OX1Xo4vk+cNaOjEdssrCyJSLnXpsnC/N1S2tqt3nfsByK42t6lFzlH6k7JyeMmfY0GO+tWMGTfDyfoalYhW8r6fR0i+50PZ4+0SH7UzzQ4pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhLaWJroqcywqPKcl+QK8GwYH0XfIoGt+G4+F8qxeig=;
 b=lly/OGPbEuSBD5rtMyHpUeX/PCurkomAvJcp6Ebu3l3fe0qk0rIew6+pzWk0QA6MAEaNs1yjs/PNK9rK26DzsmJIdgcpPy9z9pkvdNkUZqmJML8AFl8/bZJrNNKZ9PmB7wTCj57NAR6oZF75CrWRfprSRbKP3SvVIix3WAsUd7+8oBjyENQtPUaDJVcUb9CCdLx1Dggki1xzR5lJOKu5tkYvR7KEdV1GNOPcuHjn8XJ267aWUBe1SchHJRgV2yF+3SaSjbMT6tKLYbRvte1fO6aAQxs2S9LhCLKHuJ2Z1yn0qIvThnXWHC2x8HNnsnHEfoZl+fVMhY5EJHsFqn8ahg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhLaWJroqcywqPKcl+QK8GwYH0XfIoGt+G4+F8qxeig=;
 b=b9qWTzyTwqOsRGrNoscylVxr5dD0TssR3ncJjUILZEubYch102DU9/YaDEuX2pLkV4EpoA9DZIV71hzjYnu3a+6PFBEZp4jaifFmPo81dZLW8CyPPMeZFS96eo1+IaQwUQ5Pd8CFVbsiSlR4552fFPgpk/u0uyUBZWpEtz8VjFAZM6Ew2c0zigine3NLc7Fk0ym2v4WWxlWdEWnD3Bb/k6+glouaAwHptQf2NEHe/tfuujcBCCHMA9RLs7bGvPfpYuL/AMXcHfE4oU+dTmjq6GqKy00zIur7cRpYMd/R+jlFHq//5fvTqa6pcADjfXh9IYIKFYwiwK+NHIM5c/Yymg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by DBAPR04MB7464.eurprd04.prod.outlook.com (2603:10a6:10:1a8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 09:59:04 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 09:59:04 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, festevam@gmail.com, uboot-imx@nxp.com, alice.guo@nxp.com,
 ye.li@oss.nxp.com, tharvey@gateworks.com, sumit.garg@linaro.org
Subject: [PATCH 0/8] Enable PCIE controller on iMX95 EVK
Date: Thu, 11 Sep 2025 17:58:33 +0800
Message-Id: <20250911095841.3659022-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0123.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::27) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|DBAPR04MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 73313e4b-d61e-46e4-bf32-08ddf119d6c5
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|42112799006|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YT+YMwJtBTwyol6JR5djvh6vFhY/WlsquD1hP8i4ReqFJjr4bVSFGvd9nE/k?=
 =?us-ascii?Q?ivioW4ZBeC/IN2/rtpCNYQFmo5RL0dz8wHh8Vx+gVCxYpQxFK+IljAUktwV7?=
 =?us-ascii?Q?wvmOK13pL8v3rR+++blEG2nFCWt2ybvOWeMUn6PyTXYaqvC+xbl/cm1MDXuE?=
 =?us-ascii?Q?QfBcUCbXLmInk2p13hkFOVME691M92fLKK6iqxyv+aWsEgrM0J+JAzdnMuyK?=
 =?us-ascii?Q?2opf78hd/PesBdpTS+KSVsi8pl8MVyQtxfDlzll4G0HHJqtBKOVApeCUS+iB?=
 =?us-ascii?Q?Tz4catR7sHsfP+284Q64AllhfvPYIo15IAkGfGS97WH7c32OSLASqCyYZM6J?=
 =?us-ascii?Q?GG+BQ3hjtxbR+Olb/4mQuulfnFa2sDQ9dZaGLtRJ/HmxyBfZgBIEIaA/8WBf?=
 =?us-ascii?Q?nImT0FzJH9AnN3zPv/eAZSqrg+13mfTYUw8HxQWceCPYHLqj4RhU3w1IgjqW?=
 =?us-ascii?Q?oUAGpNu5FTnoZcDPNcAM69GXZKadkvslRIQ8tIIX1nKx6QVLUtTtF5BCuDxf?=
 =?us-ascii?Q?8BEIZ3bM+6YtWC6K5I2dVs50g9cTirCWN2SHvw+3vurcROsLS4rjwIWhL7oj?=
 =?us-ascii?Q?jn3mSGhw/MJkJbLrSvFO39Rqi9H9XjGBlNdGrdICr7Dbi1n0wvJmqZ0dPd56?=
 =?us-ascii?Q?4uzI6yGbU6A2vRzf61upxQyz9X+okU1g4fkAC6BPXx8rG819bFMc7bRpAeb9?=
 =?us-ascii?Q?qDH0lD66cvg6494ICY7/ESnbyuKflj0cuMHP4dcSopje6zxq8AiWVAEsNsaE?=
 =?us-ascii?Q?vUvj1oPw5YEs7rUgV5r3D5e8IwO/jIfAl81QrftiN9JA0JrBCR9qXEkStfXf?=
 =?us-ascii?Q?TKhybb8GCY43HrF3/9EiBWRiCqO+MLuwRg2H1eKxLnemslmhbZSD1TNr/v+s?=
 =?us-ascii?Q?yQRhZSKS0Hve++Pl3IBOieHlQ8nwVeJKYtccXbGTZV8BLdP0YvHc4NUoG7Bz?=
 =?us-ascii?Q?V8RQmHBOnawC74gRqx/I5El/Rm9TzV6zrVwq124wapisTY+g8vHRIp5wgh0N?=
 =?us-ascii?Q?57GGVg43QL86wuD4RRPxAkLOUD97Vfz+MYtNUlXGazCGBmQe5iWo9kmW/AX6?=
 =?us-ascii?Q?1u0AZOSJZQyX4k3f03kqgp3/pP4gOQAVSyAhWDQ0cHkF9aP9eOoBJK+vAdrx?=
 =?us-ascii?Q?A77m+enslzxW8mo+DYsWVsyUcR5aSEEtMJbafmdgJJSd4++SgZcRiZM3EAlu?=
 =?us-ascii?Q?o8YdzdCjuHI5MPRhWAJi5dL+mjGOZvLbXWL1XGIWp+HhOFytMtgfv6FQUrko?=
 =?us-ascii?Q?x7xDhQPCpbiME/emMn5kT5QlR9WUniFVgv42AO9kkVzLudl90aShbPFaGlrA?=
 =?us-ascii?Q?/1CcxwtJoZC0j1Qj7hYHYitqm/o6ez7QlQFB4+WPJS+JRb5U5NOQtPdZPmF7?=
 =?us-ascii?Q?MiT8OIajDivdkq3C2RviJXXbafD7HrMVp8URNHLfG5z9YWvGgT5K0mW5rZEs?=
 =?us-ascii?Q?oYUZHyXq1IhZF4Sn9tyM/x8Ok2KMFHvfJYW6cU8XpV3uxLwXv0ut+g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(42112799006)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?42cJun696Q1niLHnG/xXrB9HLH9mK2IjdSBh8z0uMc8jFzVmLuosAZAo1AE5?=
 =?us-ascii?Q?FxE3Ou8+lBSxNmlchrXe7SkGVM+tBHshEMEgtzs4PhLblbvFuVm/PlZoEqzx?=
 =?us-ascii?Q?oG145vz2JIp0ysJY5eh46sdKlJUQS/Gr8LVIAZQnjJ8ISlMjX66t/8wumZJQ?=
 =?us-ascii?Q?G3Clm9GgBh6rdqa/f6zvsB71b9Er8OL9s1gNEJP1t1bs4t7qH0KgH9MyDv6y?=
 =?us-ascii?Q?zfxmHA8VCxG14ho5Eu0ylW/V3nucy9xL4QcJPYzjF1jApP4p7+zKZ7jdRmXb?=
 =?us-ascii?Q?KB6MZLwo2gYIjeSJ2ghk1hio3CWvSjAct4vbLasFcD+u3uqrVcGEFAk3uV1d?=
 =?us-ascii?Q?govoFdywhGywueFneHeciPC51Dfynymmta3RShb4zBBvJC76qPzJm3UYYWoS?=
 =?us-ascii?Q?s7BUP4VNycBE1hA1TRouPk2Mut98UhvvquVA9h0WaVfzNXKanxqalxY1W38x?=
 =?us-ascii?Q?azdD7GWNycAsJ7fSeiJ3dP1QGtBSbzGdy4rt1uE+5zIptWu3z4HQaTdTYGSk?=
 =?us-ascii?Q?xzrtZjQBjsx7ALVlZVRomSYpMWRb1N0nc+zvtNEmmSZHGfvyLAB7xyQt/fhs?=
 =?us-ascii?Q?eZ5HAyPWPd/oIbjKeH8mJUrbrwgFm+/2LK+S4nRhxkSuJQg0Y6n4pih5TA9z?=
 =?us-ascii?Q?O5qI3mB8sRNEptEjQ8cF8er6zzAn0WG8A0WSv4SMJA2nP193W00ue+2/hj0h?=
 =?us-ascii?Q?S4X3E2IssILsfo5qqN27/jV4nMTFWVm7FbX2InUAzxALhOp94I1xKn0Qt1PD?=
 =?us-ascii?Q?xaCjy4Wa8zFP+kEFH5SX8ldjXTZLpPtnctYPJXPnB+FJr3YRzIed9hyDoVzv?=
 =?us-ascii?Q?qZZkw2op4HeT2JXtg0buk4ti4i/R5wEc6a47DkztJZyVwyNqECIF1H2DQX4s?=
 =?us-ascii?Q?TWR91KdY9ggLJUEhDAf8R02OfVZu1CQsir59eJkYMZq2WDfWFKTWk6QdKwEK?=
 =?us-ascii?Q?5t30ji4htPBQwBo6FWD0AudSSSnp/a0yjzjE0xUkiFt2nBXiTq+qh3yLwr6R?=
 =?us-ascii?Q?n8urK+RN1zMiLdFWNaY7JXs7INn6f4WMvBMkCix4LhSRPWo2NSncXhCd2elI?=
 =?us-ascii?Q?WiN3gkQ0gAaIXkHjsXfmCGhxy9gFxbc45QrYmtrUJl9s8tLQjzsE2sDzRRVY?=
 =?us-ascii?Q?qCBn1MkvrP2hzJURVZAxVx3H3I6nsgMqVzf7/zDCfkhiz6fsNzF6S5jmIt72?=
 =?us-ascii?Q?6kB3AAI+umANssDkEis+3eIzp4wpEP5zIOYcjsXgW062efDjZ52gVgjMIG/7?=
 =?us-ascii?Q?z7zpuB8mLiz3pOM4T69TvYNhi7ElzGTYK1buePoQU0YAk4pyuGkM7bI7XBz1?=
 =?us-ascii?Q?ghPbw0WbrTf5GqVCxy0LZNnE4242J/TRc+4yPhYJZdzYbYFn4thz7/X8akbl?=
 =?us-ascii?Q?dS7gYfqCblIs3qA4Lttx6wUK9JllevkrV0ugsAG/NyTUTGEuF9zJ+DCwI6Kh?=
 =?us-ascii?Q?H16KEb45/5S9upx0IW7mKc1YYVxgdJWtWIms7Qb8sLArJ40CweIfETHpxbzM?=
 =?us-ascii?Q?16DLrHrhoWoXHDiI8bK4jQd68NOJupGAeS/VTfP/5rnhXKyAmWSYxVIwHT9L?=
 =?us-ascii?Q?QwezvFN7jxey6aF6CxQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73313e4b-d61e-46e4-bf32-08ddf119d6c5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 09:59:03.9281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6kROMvWbPC/3ZfiYTDBbZ0bwwRFwJ0pk7uQ0ejznpQZS+DHdiLtHPHm1KHq6Z9U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7464
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

