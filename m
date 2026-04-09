Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B886E9DE6B
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 08:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8D00839D5;
	Thu,  9 Apr 2026 10:37:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R/iMfsV0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A749083CF5; Thu,  9 Apr 2026 10:37:24 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2334F83693
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 10:37:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9vlk8m76q2b9UDa7xJ28iCW3o9LdGlDeC9aQzNcVrdPMp+Hd3egdMNVdZkPM4krjOCKqvzR8/MRz3QX3eQQ4SDFnad3XcvyjgYiuNcD3ceyGosK/eKAaX91B/vVnLTiGoE2kUOL/PYFPrlq6PQtUZWj/jwqcmMMuxJJHwnSAoKf8X5/pmf689++DjQ3UmsL8fcvHZmVDHfe4O4Unrrf/0VKjE/hiLtKaLQTSJ+a/jzCG8ke7N2LLD10UmJddDbVtwWgD0wHCltnSnZquQc6ECbTIkeIfnCRRd2K7J5spKupkZuz2kjunNMrBSf0lldLQJTFlUYO0qIO8Ch2x934Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRJeMiyS/8EacUA3toArdeH6oUdhqKzhfdR+eU7ZYBo=;
 b=DqwLDupvsamBIKcIC3OWETsOeH8tqjYLcxpExJhxlcmbXgPy/52p8HSFda9xifU4fXUsj1If8rxXwl2Rp/BtNtZ/ksgqaPohfcejhJNCJ08b9xkry1B6PE03q7JIIjqUPiOpMV71PxLqmJt2Q11WYDPm8OXDSlZLoOWnUfJn8gjj7kR0BZBgmBbZMB40QfCtax97p6BorZlG7Kyg/LITY0BwT6fZltW5XdZcqKzk1+IlPviCKRsUfk3u+oWw41Aimmy6051cjZ8XNxnEfJzxTlhz4iB6YEGmJxsUiGSkZQZk1KpouoCDJsbCNl41B2JvQIuMQu9VXNQmdfVBUi5L4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRJeMiyS/8EacUA3toArdeH6oUdhqKzhfdR+eU7ZYBo=;
 b=R/iMfsV0CynSYk9Koc7AsxbFt2EOuddmd35kIIYhR9tiqfjh39ekLOusYnXjHcuJI3at5LPjx4hOmkyGd2/KEbeIENLlF5uMZ7jTMqJ389/gZvbAgw6r0UhjNN3Hi1zCyZGz+xdSzaS5Aif+Qlg194B7iO1B6kiVHWfCsSk0c1s9vGO2wYymW170F0YgRmBgyagwGEdWB8VHzdFqoIZ8GMyCMIXXeZP4il9s59JgA4jXHmeALqHkXyBcHwgjKaMSHdpfxRApHD+8y5dgBGa+vMIatwO0f6Y7d00IOaIB9ABSwT6n8Oy2hvduNcYgtcRQnHnAavTLc5Jv/RBn6TY+2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS4PR04MB9689.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Thu, 9 Apr
 2026 08:37:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Thu, 9 Apr 2026
 08:37:17 +0000
Date: Thu, 9 Apr 2026 17:53:30 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull fsl-qoriq-for-2026.07-rc1
Message-ID: <add3Gk_2psBrgUv8@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MA5P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::7) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS4PR04MB9689:EE_
X-MS-Office365-Filtering-Correlation-Id: e54719be-5e8c-4513-71e5-08de9613352c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|376014|52116014|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: hP2ppaFKqpFHJmn9KP8Tl3MREnXU2OSTd7AvNAAV9alJNFqj24iRx5wpzZJg0ypla7GZqaw7eNz/L2sbTWuORBDJfiSNeaWjStPtstaLhFSrjH0zJjJIw8zT39cq0o3AnWeo8us8nxCWPh4VIBD7g2XKRHqleGSKAxwjLTJV1qArwG5+/8NWJd8eicsPAP4swR5XuDgsTmjnQ1c/n6CkFe6wmEnnrGB2fO1woi5+M3XWmDh+vabFRk+/kRdfHKHhUF2ybPwNCCIze7uBV9lmBJnmrqSGMLOVyw+wfsQduH/5qidnLdL5kQnv7ih26qAfC2OCkcoVniJE3aBV07C4HdUxvK2HljxLCr0NnhuGeCVREsc/RYLKeKpaT8Z4iRDxWTZGUfAEEpmVtxpNSrDCncDI5lUG0EPRRBFoh/zqF2HWAsNr0iQTe52WyJ+5uI9Dp1C2ImOnSrBP7s2zZCz52o6/KbMMIzDTCir3IWhuz/K3IMxcItQ1ilfz3jInTmfn8fDxyEK2u9d/Vza2mlaDI2l/wt8UVu7yKI0utvy7wQb5yS/Tajeo0WxaYFoVRkj+RUueY2mbTJV6Uq+nDUj1dTtVT3x/ddOIuikBgdt+P+Tl72VpsoFKPHty+q6Yo0TodnMGjX/nfzCGji4RUrvGtJ9J6qKCDlhjaMrmf3QekY3PxrpEp1wi9crHkBd2rB+AZ/RXm3ajedZiaVoXCoWGVMXM5HEwXhsD22eYf+/Qr5c7Cfy+0+hp+S3jT3fDJmUb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(52116014)(38350700014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pBpk258j9DALvOC641PZL9svMksZU8AoCVih8034xf9vgCZVWs0oUR91Smvh?=
 =?us-ascii?Q?4e/Gx7bwpiuGhiGq/KJAZNWLX25Pd3PZt35WmFWJ6ebOFfye4enoubU54Lho?=
 =?us-ascii?Q?XPtKIEt3rXzJrSZc1KbQv+7r/z720foj4iaNGfjALZXt8lu9PL1WKz2kJYnH?=
 =?us-ascii?Q?eNLS72EphAyWwWGwMuvfawOvNyGWF0TS9jvs6ICixauYdP63k0Ehc7gfMSa4?=
 =?us-ascii?Q?OC6RykFixEuCbrwxo00URmpW8C8SIinCByhzzAQXCWJKgJb99/edy8uz2+Sw?=
 =?us-ascii?Q?yCQ0Cy3jtgt+1YtGkZxnE7juKGDkW5JZqD+RxoP/WzU5o2bOBz8yu/SRRDW8?=
 =?us-ascii?Q?OQxunXRHh/LA0MnI/Jr+1WqQTi9IfyyUFZhSl4M56/X3LpH/3g4pK3jJ+zx2?=
 =?us-ascii?Q?IQk//gmr/deOtjXqUDlpM/7ttmvX5UnfyhrretNjnSGd1RSPNY5M96hun/q2?=
 =?us-ascii?Q?q+3UWo2X10FDl1o0hACZNXTDYxe0d0/vS235rEvp2dT7njkpRyu7JsegKfHq?=
 =?us-ascii?Q?6fNexq8Xp8VCNUyUMOMqXfqb2Jp6xyLaL1M1FQZiko8gTdBdVpFj64aYvGb3?=
 =?us-ascii?Q?I9VRIx9xjLltLoaw2i5Z64smRDIF1aMtkHSwQfwxVRZV884TMP0JGv2AK518?=
 =?us-ascii?Q?SEhZm28u9/xqFhpwoA1en9wX5Goj9D1KnGhaPZlBK99IJ/aR4aCOIBN8bBJD?=
 =?us-ascii?Q?RSz8ZFigDFeTlgfyH0PSmeoaD708Wa2g/9eEgyS9N0Ha1QYBX8YjbqAhDBr7?=
 =?us-ascii?Q?t9Gd1Al6lWCJYBt8k5iM2SUWn4XHOYMrGrY6/Ncbk/yzoIFjQu8jVoCL6jbB?=
 =?us-ascii?Q?ViLSIqV7TYSUVEKWSxV82Y25zGBtsPGuCiKUOiTIkOMNFxykm1rUiiWMB8R0?=
 =?us-ascii?Q?6HMfbLVoUy7saUy02M7mgu5V4O8rPlvBOTk8vrOlDA1CaYErpdTZOn6osuin?=
 =?us-ascii?Q?cLlW/XgU2/PesXsJUV5gP3AWs4vrzMv2+XoLQPqr9g/AliJxB4DkNPcWtDIe?=
 =?us-ascii?Q?VyPh/w3m2aZZNkHDWE4rzYBBEb8bLwXiYvpRfuGG2dsIEIbFEF0BTVE+QI1R?=
 =?us-ascii?Q?EoZ+GXHdskyczN2h3xMWryFVaE3w3mLMYflXFoMlA4dameMg9Zl591E7VbKj?=
 =?us-ascii?Q?3BlAgVgFybfLoYs+DFis4zIWMJweV5Q+fQorrTGpJ+cwDQu+NOiu+NnvvIIp?=
 =?us-ascii?Q?uoInyd6iPZegvt0nDowZjfzt5/uh9gqpXxf4p86blZ6tKcmOMRHgtcc3fH3r?=
 =?us-ascii?Q?jeSBe0i/sOEhSJKaGxN9jxSB3ymeU36rhN3j0k1fZk2fpjmRj2BZ7xNckzB9?=
 =?us-ascii?Q?SbGomg/gSv3FvVqkOvPdJAZjW8CdyoHhjx39l/FqO3rzZDsjn+MyK/XJ887C?=
 =?us-ascii?Q?CRvI+tp/ha6k55kMlmtwwPQavsVVXBuLLdoFdMSclAkSN5RW3DKT0bErCLQu?=
 =?us-ascii?Q?nXZSDNZBAkN894UhHQU4/eEWUksPCMT/RvHMkgP4oVjnF3Fhbl9tIjDjWcIR?=
 =?us-ascii?Q?78Q6XzTLo37i+eC1p5Y7+8cg4dSKQWwUTYwptruoiehkZtldPlqCTl7xi+4R?=
 =?us-ascii?Q?yUTjwhxpe8CUNFoQ7HeYbQ1qis8hkJQ8kJ7mYKaALfN1U5albAoJaee77n7o?=
 =?us-ascii?Q?iB0wwhhPG6bUVvSw6NsRRK8WdSKQ+D5RJ1dwnWnFuBtqc7m0z3HeEnoZcdEt?=
 =?us-ascii?Q?hR59VyjJhWjz/HdxcY//Df424EXVydTe+yg+FEqcOrGzhvvESeUJlLhjZYp9?=
 =?us-ascii?Q?qgS3cZe5TQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e54719be-5e8c-4513-71e5-08de9613352c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 08:37:17.5351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Ja0plCDbBNyKs0zgukARD8yuQlHd6gM9y95XUbt22PR8i5rAluK2pZyaHFxyno00dJuFGP/y5JDTuS2zVi5Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9689
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

Please pull fsl-qoriq-for-2026.07-rc1 for master

------------------------------------------------------------
Add env variables to assist boot for various LS boards
Add gpio scmi driver
Fix setting the function for scmi pinctrl
Use standard device tree pin muxing format for scmi pinctrl
Fix protocol version fetch for non-CCF platforms in scmi clk
------------------------------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/29808

Thanks,
Peng

The following changes since commit a383c9689282269bb9687ec6c115de094c27fa67:

  dm: Respect dma-ranges size (2026-04-07 15:27:22 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git tags/fsl-qoriq-for-2026.07-rc1

for you to fetch changes up to 35138649383c79c7a4186833fd17b92e1be388c1:

  ls1043a: add env variables to assist boot (2026-04-09 10:25:56 +0800)

----------------------------------------------------------------
Chunguang Li (4):
      ls1028ardb: add env variables to assist boot
      ls1046a: add env variables to assist boot
      lx2160ardb: add env variables to assist boot
      ls1043a: add env variables to assist boot

Dan Carpenter (3):
      gpio: scmi: Add gpio_scmi driver
      firmware: scmi: Fix setting the function
      pinctrl: scmi: Use standard device tree pin muxing format

Ioana Ciornei (3):
      drivers: net: fsl-mc: remove unused parameter from the wait_for_mc() function
      drivers: net: fsl-mc: cleanup the fsl_mc command help text
      drivers: net: fsl-mc: add the nowait option when applying the DPL

Kamlesh Gurudasani (1):
      clk: scmi: Fix protocol version fetch for non-CCF platforms

 drivers/clk/clk_scmi.c           |  12 +-
 drivers/firmware/scmi/pinctrl.c  |   2 +
 drivers/gpio/Kconfig             |   6 +
 drivers/gpio/Makefile            |   1 +
 drivers/gpio/gpio_scmi.c         | 248 +++++++++++++++++++++++++++++++++++++++
 drivers/net/fsl-mc/mc.c          |  45 ++++---
 drivers/pinctrl/pinctrl-scmi.c   | 151 +++++++++---------------
 include/configs/ls1028ardb.h     |   4 +
 include/configs/ls1043a_common.h |   2 +-
 include/configs/ls1043aqds.h     |   5 +
 include/configs/ls1043ardb.h     |  10 ++
 include/configs/ls1046a_common.h |   2 +-
 include/configs/ls1046afrwy.h    |   6 +
 include/configs/ls1046aqds.h     |   5 +
 include/configs/ls1046ardb.h     |  10 ++
 include/configs/lx2160a_common.h |   2 +-
 include/configs/lx2160ardb.h     |   5 +
 17 files changed, 396 insertions(+), 120 deletions(-)
 create mode 100644 drivers/gpio/gpio_scmi.c
