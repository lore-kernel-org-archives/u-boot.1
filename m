Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15C4FC5927
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 10:33:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E984B83AA9;
	Thu, 26 Feb 2026 11:33:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JnplanCb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B96583C54; Thu, 26 Feb 2026 11:33:40 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8E9B83642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 11:33:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eT9qVvSeoZ/UgP2ZiUrIWTKE0KFfuLpXq2paLAdSIGX/z+0iZdxtEroVZWXSuCGLC2GYtsEn/sPI2SUMsH/TOXuF2vfkTLb1EXX/Nfks72CJtVefiYDmnjv5UBgwnYtjsrSmUyrJpZxF5R3OmGDXQ5C+Fnq91tSyny3aI2yx1TaBc9lo6dSdWpAfE2iBupF1GR1fOgsHJC7j3ALDneiujZGYJid51SdVhD7/ufrtAJzEo/wYzxwaeRQgEuJDEQkDVvXPkg0bsZgJDT2lYqwuKolChX2MdHPObKqXYura+wrLdIrrMD/LliF75Lfw+iMmYmIGF41M2DSw6N1fhqaw4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcnKnbUSYoAmUjEpJyvHw1keuqLHN2oWSCzGBCpLz9k=;
 b=Iq0vWOqKXWF9Ha6avfEBiK/njjcke39k13SLwRuXmLPpLVo1rY9Edk7AFrGXSkvGujFTW+IDaMgPImXpkZOAq3eFevwrsa+3M9z1Flabi4GFObl9i5kC+2cGOPY14EqSnos0tz69iLeZX2fjNmaNWoN9RDFZ1oQb3oJMfVeK8BaP2JhE4CnHB4tVg4KolgmKdYAIBtxm8DsU84tyjrc/fAc2ZrWY07AFbcf2xcqUgeFQYrkCm4z/d7T5oMiySbMihG5FvO5p2FVysk8XBUyqG/ZcX9NrNH6ZpwvVvXnK2STEE7UoA5P55hJ1UHQqUy3u9rtNZmyG1d30pP5QX5Ci3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcnKnbUSYoAmUjEpJyvHw1keuqLHN2oWSCzGBCpLz9k=;
 b=JnplanCbco82fAl7iFbWfv2zaSfcBdm/y/RROM5cL+OvoPasXs242WNquW/FgkEzkSojBLiYlGNmwn1lCGwhJ/spYqgERmOV8YvqRID1iz7ScHyN+vl5gQySzKis3idDPUx9EtiI7EPZJy7YV411+PO02PCXAzlCUsVits3eOGSyLqDt9bedyMWg0lmU6ShviNNXsuGpU/eaCzN23RMZjfAgqrTsZWTFDL/9qnmXq7LHmPr6xMxnn2j1C+/4GMKC/OpiG0aEgzmKrB/yDoMD+yLpJJz1Jnv9ZMWw7RUkN6qYYnvfjUMCSGDcfcECx0Wb6R3Pk5ncW+FJXOghU1vwBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7801.eurprd04.prod.outlook.com (2603:10a6:10:1eb::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 10:33:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 10:33:35 +0000
Date: Thu, 26 Feb 2026 19:48:40 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] please pull mmc-next-2026-02-26
Message-ID: <aaAzGKCyhtvxOX80@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: 48124644-8d28-45c1-872b-08de75227f00
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: dmu0kJi+yDjcZg5fil32FkMv0+PSRbzX61B8bKio9sYao0gvkSbk2L2KpWgLL/kewAR+VJuAsbdkIv13eUdJVALCnKZLF8rHiWF5Zd7KT+bawLYw7yjEMKQ5DMJ7cOQReeGkbcjSXXsLbUkcrZQa9c/PMtpbybr1qJVbUZyyt40S0cMQsOdmJ5PEjSEOHeDsNw5AwtZHQ9N5PMUMARHlkr5sSZ/XHCky+s6ke1Y5I8uxpcPyrTonFEHYM4a0rbfNlZ3hsr08Xilje28RnMmrDiyKO01IZRojz888gEjzCMT/NVuKNyyjFSaI+JASPGhPID+WxR7zigJj1SwV2KE7ak0DkhZF44BF2OpLt2P1zIh6HGHIU52jaLzezi19D+s+02IlAo4Bfx6VJ+cR3tPBMZmxn7Y+5bmGES4+AK/iqlXpk0NsVtims8RCZ55QO48KTCckH+0RRCt7+xmXTf4VtQrPJyZ50VTIycZRasL0fYTzlXa6RYOaY79tXEFLjGXfFkS+o7sEaLy7yq+Y/q5inAAoJK9Ku/JzT9OELYh9bEeDzDjAPney2c61wbt1CjCHTTv6LPRF/VmswNPQ9pCexNWvqVLVf8EgT70oevhaIywDyNsHFS3dEC6ff60eKLGLxQbIr3Jo7gvfWKWB0eocVd4cdRc3b3zw/Kfsb0+DIylx6pTgd8SObqZk7V7kefzxeuVhGUG7P7MMQX7lBE3NotTN8wjvU1Sa2U6+Ojh3/OdhL5/DXjDGIyywuTxUN7u2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IsiPYm3oL0najt+NGDMUjfFeTvNRR3ouQ0oqC0lYhg5PdKQ+PKLAujaE7mUk?=
 =?us-ascii?Q?znIAtSjHwMyuRgH1nNURSG79IpVphRHiZb1RJvbRFOrTQHC5M21cYrceox3u?=
 =?us-ascii?Q?EE8XEG4kTJr9ZVcGdrrhM8ZZHtdYqdhxc+FIwzT/F2XRuDeLK75gVKC0DSLG?=
 =?us-ascii?Q?jeMkZXXt8+TIe9oV7lFGc+8cZ6ejD3I4cLwaYaTU9/OX9uda4QoTs2NNWj8W?=
 =?us-ascii?Q?YjDrvfiyf6vMyZyJOLefITy8qamXC81mNkV2UIkVjjPIRpvklAWUaj68fTaR?=
 =?us-ascii?Q?HwBHSBMwAJlhi2ZdldDNGdiT0hQOF21eY//zeomztVx7PKHqwNHYjQMpDB9C?=
 =?us-ascii?Q?A7DsZkykHGQBeeQhYI4bs7GdBFQSgYPeSNhdAaGgPQvyDy91mpQMkzG+YD3E?=
 =?us-ascii?Q?JeefzN0t2FL3BfYTNyH/1/OX+GV82a5x/DkOAnrn4ZZyWYWfmQouuLVv+IfV?=
 =?us-ascii?Q?4nzM4HAD4euTyXP9dEdQgQ/TCV3O8jXkZ7BZNqcobV1td9bFrc5a7oMJ2VTS?=
 =?us-ascii?Q?xRwQwJqtFIiTyupaq2csn5xNwLL7G02zRJ85qECZxHFx5yaYQgbnBBpfDaIo?=
 =?us-ascii?Q?+r66arsbj+LeVhj0+21CeZH1iVEAdVPxvZ4xm56I79nb+oyAycRFAsABipjC?=
 =?us-ascii?Q?N/fjtkEBvjYwKr+NwrnM4hwCqRlXDfcHRQdGbJEcRrgJ52T1tJZqpevKzxZN?=
 =?us-ascii?Q?6szojYc30S10pwYlyFMY9L6cNfkxrmKjGKaJkvuL6y/V4zHdJNL3Vv9zXfhY?=
 =?us-ascii?Q?QXj7A2ZgfIMWmWcd+qRcB+jUkrnGuoWOrJ4Dm+wiO7Z4erjcClwgrupBZmBY?=
 =?us-ascii?Q?/l0UxMIRQQN9GxDnmLdcLzbzMFviR+HshYuFbf6J4JHCz83/t6uI2vQvaGIh?=
 =?us-ascii?Q?Ed10xCz/j5xmm9SUAo1xHTG6QS0lGJxfwecyhbMn0/xt9x7Ncuw3va3F85SV?=
 =?us-ascii?Q?y3Cx7+WWIAy6gA6S0ZL4k7y5YasWtpOoYQ9jBKoD5co29ipAWe+Gsb/A7j8R?=
 =?us-ascii?Q?Q/jWsVXS4VZFhMECpe87uIavQAUVF7sbNLcqaaw3cu+2JoNn7xPHNyekQO6B?=
 =?us-ascii?Q?R4VZ7bf3fkDpdZ3ZNlzG0athVuwaymbUAdG7jmmhL7ts8r9nZFTalzmg7DEO?=
 =?us-ascii?Q?3eNAodMUReMt8uvF5IkVAOZR94vA2GLCrT6+KIQHLyzPf2U3pEc2hT9YXySD?=
 =?us-ascii?Q?Rdfw/qEsk1Nv6FaQzfVRiw31zsj/til4WlA7/N1PD1GLnqeq226JelHGYzo0?=
 =?us-ascii?Q?IwpT8N4fX4tAgFIEHa4hUC/qteILTRpRu1RaxcnHxCX0slmuDNuK1q0CAs2f?=
 =?us-ascii?Q?xaV7ZcDbjRYy5ZYIVAs/qPABAeGQ55ndC5HNXgAIRPtKf/kTZ0i0cQl6D3S3?=
 =?us-ascii?Q?+gLp0mFMZmnC0G5ZH4oqcrk+3hCmzkIKWJtLaNDQW3mjeoLbgTq4H9J69U1q?=
 =?us-ascii?Q?QHii5XwdYQKAMn5frhy/vHLVW/W5Y8iBiveDQtjRG9xIlVSbCwCqPuWaOwPJ?=
 =?us-ascii?Q?2+LnyMDpeXX9i/5IRaUod1kDXH6Jyi/P8yozkanPIY7sTZqDrANZOWYod6IV?=
 =?us-ascii?Q?kdcmhywlUFjsBhZ6lOURU1InITHADxZG3qiyvKbqPSnVxZTmIwM6RzIHV8po?=
 =?us-ascii?Q?JYFYV26mMCDgNAcFJbYNFv3qCX71vxVnTN/O/YXp5mnrHXuSnnVkeDxXLOIU?=
 =?us-ascii?Q?zrSCO65uEgmDjVitChaR0fDC3cF8WBPYB7IDcDrNFLssKb2PD2Tg01Ke4x2T?=
 =?us-ascii?Q?0m/0V2NtyA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48124644-8d28-45c1-872b-08de75227f00
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:33:35.5594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIAAQ4pPaEZWBoaGl/F3YP2uq3hsGPBgzO52vm7h61gpj8u2LChyQ5mkykV3nHrXJsUzNOdi1E4dG6UpFiwY3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7801
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

Please pull mmc-next-2026-02-26

----------------------------------------
Add MediaTek MT6359P regulator driver
Add MediaTek MT6357 regulator driver
Add MediaTek PMIC Wrapper driver
Enable pmic and regulator for mt8365 evk
Minor cleanup
----------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/29376

Thanks
Peng

The following changes since commit 8fd76675efbe7af785ccc1ba1ac8b9f7e10f6715:

  board: Correct usage of fdtfile=CONFIG_DEFAULT_FDT_FILE (2026-02-23 15:30:34 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mmc.git tags/mmc-next-2026-02-26

for you to fetch changes up to b3d16267b5095746888927478a0973fa810a0826:

  mmc: mtk-sd: add mediatek,mt8189-mmc compatible (2026-02-26 11:15:44 +0800)

----------------------------------------------------------------
Bo-Chen Chen (1):
      power: regulator: mt6359: add driver for MT6359P

David Lechner (2):
      configs: mt8365_evk_defconfig: enable PMIC and regulators
      mmc: mtk-sd: add mediatek,mt8189-mmc compatible

Heinrich Schuchardt (1):
      power: regulator: Kconfig: add SPL_DM_REGULATOR_FAN53555

Julien Masson (2):
      power: regulator: add MediaTek MT6357 driver
      power: pmic: mtk-pwrap: add MediaTek PMIC Wrapper driver

Marek Vasut (1):
      cmd: mmc: Drop trailing space in Name: before newline

 MAINTAINERS                                |   3 +
 cmd/mmc.c                                  |   4 +-
 configs/mt8365_evk_defconfig               |   6 +
 drivers/mmc/mtk-sd.c                       |  11 +
 drivers/power/pmic/Kconfig                 |   8 +
 drivers/power/pmic/Makefile                |   1 +
 drivers/power/pmic/mtk-pwrap.c             | 896 +++++++++++++++++++++++++++++
 drivers/power/regulator/Kconfig            |  26 +
 drivers/power/regulator/Makefile           |   2 +
 drivers/power/regulator/mt6357_regulator.c | 512 +++++++++++++++++
 drivers/power/regulator/mt6359_regulator.c | 711 +++++++++++++++++++++++
 include/power/mt6357.h                     | 159 +++++
 include/power/mt6359.h                     | 225 ++++++++
 include/power/mt6359p.h                    | 230 ++++++++
 14 files changed, 2792 insertions(+), 2 deletions(-)
 create mode 100644 drivers/power/pmic/mtk-pwrap.c
 create mode 100644 drivers/power/regulator/mt6357_regulator.c
 create mode 100644 drivers/power/regulator/mt6359_regulator.c
 create mode 100644 include/power/mt6357.h
 create mode 100644 include/power/mt6359.h
 create mode 100644 include/power/mt6359p.h
