Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18F2D185F1
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDCCE84255;
	Thu,  8 Jan 2026 14:33:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hR8gsdDu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CCBA84113; Thu,  8 Jan 2026 14:32:54 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29B3C8398D
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 14:32:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyBIsmIdNnMd+lXys9ju4eqnyk7XVuhfv58muxcGJG4GK5IPkxn+Kz6hnOZMpclAER8MsZ65jYQDvUuBC2i4cvkD2XhF0cSt/nCd7exj8/aacbgiC3c30BYoSgJLv+akyXC6y+X5sFhaBbZlUeZkPO1NQAs9vp7katSoH3TPaAZz3NKD2W7NpeycD4YLF+cZXNEBUCecXzktfchH7T1va4wyVm8CQC0yRc1l8uqT9zR2p5elXP5X8WdJ6IQQAS2ftYRN54Czq5SKzVQ1VOVjg5TQh8XSGLjort8rO1bJS3Twbm34vunWvQE5+qAFO5x9fZJ4Xz0as0gTe3DypfBxZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/JJ0XRP6rzjSFeLQPVleSPG8AOcBoLThcMduFE17Rc=;
 b=jp93HVowhHhZk3n7ud0/iez/bnS2kHOD+FPERsRend74fcEdrn2uvlAEXkL8aX8NItg1IeDEqo7dQLnYnfEXzUBEEJ89G3a2nCLaO69yC1QreMClnx74jbSfnHFLLquNOXZ4qxznrZ0QNuHr/u998EhyQPTUV9Fa7NqpHv+FZai/6RTBrE0PKrI/DXP2iUZZVZbkZy60Pj/p2eoCQdvM3OTGxSz9tRSShpNfdTs6HGfDYHEl+i8Ae9rqEtLio2D27yiIyBhHXhos3854cDol/JFGX3gLGh0eImpyY93XjRr9xUyDyxyeUypXOQYAtHXCkqrpQIWkosTxfIcpvNO3xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/JJ0XRP6rzjSFeLQPVleSPG8AOcBoLThcMduFE17Rc=;
 b=hR8gsdDup9XLNbY/rQp1mCMlap7ASt+eZdzz2yhAC1rYPUdpEhqAD/N6/8VAIx0sdwoDxxiaBzPfe6UEdbY2wrbDHlCTXgKWks9P0BJAdidlYeBnf8yapn1FEGlHKMDM5aTKoAPSJEkx/xXrbV25/e8KlZ7sRG8nZ2SaxJLl/DkFBh2bO9FMTZ7TL5/Ha7De+woKdzFyoHQZ+zOQJPZhXgYxGs+reRvaLoP5+YhUHgdqfWYrseWgM5gYlFFFrAt+n6239mH7C7zbQ+pntdcskZrAqHOpzk+3LHFzraCAFrtELFu0xddj1N+/B2yD9wekH2Mo3sxUI/lc98oMJf5h2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by VI0PR04MB12078.eurprd04.prod.outlook.com (2603:10a6:800:313::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:32:50 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 13:32:50 +0000
Date: Thu, 8 Jan 2026 22:45:39 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: c.stoidner@phytec.de, daniel@thingy.jp, tanmay.kathpalia@altera.com,
 u-boot@lists.denx.de
Subject: [GIT PULL] Please pull mmc-for-2026.04-rc1
Message-ID: <aV_DEzC0qGOr1fjX@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MA5PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::12) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|VI0PR04MB12078:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d24143-2fa7-4e72-7662-08de4eba6ad0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YwdPVMo8FyfBVTzSrYijKqkBhCcASBR0/cgAUMrW1E3a4Ut4BSDvBaedqdBc?=
 =?us-ascii?Q?3A1kfa8lhUWu8c2+evKyiOksJGJiv1fxods26TuiWOgPYfe50ABfaAyl6KWK?=
 =?us-ascii?Q?ofiaaz/AoAsquiajeXgLtkkh7h36WKkvJWwZ2URjYF9XvtzPABAcgZtgI+06?=
 =?us-ascii?Q?dgP9jCL3P67HUTOgt3hhn7TdoSKFAaGm1BiQW0Ioyl42iMsJex+/o0abjPE2?=
 =?us-ascii?Q?zy1tu0IRtkeWrz4doTtFXbl9/veioHJbXQG+ZDJPAYlJvdg3Zgc77OnnLXmh?=
 =?us-ascii?Q?rNv84Nk1mLzJf6fpXYCkI8XaAV0aPY3hrWKoOyQL3O+0pVNneo49vo2Ju6CX?=
 =?us-ascii?Q?5bZ7w6FwUVP2K70adn3x0uLf0ovs2jZOGbcr2dA6YEXb1RIpZKDDHXz06/YO?=
 =?us-ascii?Q?WjlcsXg46r51p6YmRo5ibL2KRpQoWQZJqr+DX6d4O8oH+5aMxC1sgg7f0DYK?=
 =?us-ascii?Q?XLovz6X7pFolBKSMmznRZtle61LAetuPcurIWyhzu/NFyZE8BYZiOFdwlhd9?=
 =?us-ascii?Q?39v5OsyoMRDWL6u0i7vGiiBcd7j+g/ehI/L28S7ccXFXB6KwEANqWJtczbG/?=
 =?us-ascii?Q?bk9xPjvuBpUhaef8YECSPMHHNB2ZX4gUINSequ77z9Pv2jUKdVbaqlxVDZ58?=
 =?us-ascii?Q?QyZr9oHUIQQa+sGth0feu6QiC3suLfOctihvTt1K0XVbNoiCOqP+iXpxI1vS?=
 =?us-ascii?Q?75SLsfpD5nb9+Uzb6wyZBkUlS1cOMc9+cNtm1jOfHj9ygCC5Yw/6lWeflqCN?=
 =?us-ascii?Q?gH8csmocew9QUwwqkfTXyL6L35z1NDhp0YSZpKXCl/LEqycHO5vy0W24kACR?=
 =?us-ascii?Q?o0khLyhqKFJqkINgoPCxXtG+K2SJUJIZfzaD8kwivSOHvncnhFq1XS633fIU?=
 =?us-ascii?Q?DtFmJXFdt9X4r2oZaiTB/S78bsyGdKrx9EnnqD1h66fVV6961OPwh3CzEyw5?=
 =?us-ascii?Q?KJE/DxE0u3g/UYYHRiafw1mgQ9S1sbu2hdW5EgaktKFWZak3W6ffDCIJJFBu?=
 =?us-ascii?Q?J2v/xv/yVzpCJp6gWUs7ucxjSDmzblIVvLnjl6NSOLHmajQt+Mg2zWB7OPJD?=
 =?us-ascii?Q?MdfBN++rkyJnrN0EOQlMmMt9RmN4Yd12mYKaY93IbtRD4Tb31AZn/877HvoU?=
 =?us-ascii?Q?ZRPxQW0uIIMC/q66xMKd/cIA6wp/2RRBWrfkwgTIc0qaxv4ZqwidRVPpGDXg?=
 =?us-ascii?Q?dQIf3KTelHjw9PpMNvkkPaXw9Jz7+da7RVBAsBKv8e0d/gSNSEUxjWxjGvCu?=
 =?us-ascii?Q?Hfco8f8kI/pSw1U6+5NEoO3uWIfUM2tkyU1uj3tLXjQdSPf8kgDtNgPV7njV?=
 =?us-ascii?Q?rDIwLVzzY//Gkjbe1rz0TvrP2CYYjr9ZrXrL8J75owmkfftXiSDBu1dIMCBe?=
 =?us-ascii?Q?cnGTNSXGG/2RCDPaWKDrDHFweFJoJCRDy4BCrL8lSCAynBUxBW+GGFIdHPHw?=
 =?us-ascii?Q?xE2jqwTh9iX1HBrjgeaKG/ITetNRcevoF3Ktbl+x5vt9nksTJDrqiA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sEauYf7dxInTh7YU92I6E58SJ1ErZF29HtrGS0h8dMkc2iqdsdTnqlWSqQn4?=
 =?us-ascii?Q?mD0uE38M2mtPnFtjPg5yMOmv5CbdmTO36pWdlS4fEeiIJ6My0qK6SV7t3dyX?=
 =?us-ascii?Q?1w45sgPAga7Z+gWvM07yroFfBOgPkXLq0DTF+PGFiIYyoj/F9GYphu3hwLPC?=
 =?us-ascii?Q?MrZ0zUsAJQq4BEdon4JnR6PMhtXaenRFeNzgWgNLeWTpLGNhPLvFscT2ZlN/?=
 =?us-ascii?Q?6UZEUHBmN4FfkXZbAsI889ncCoFOq2UJFwEWTpBEZq5mZNb6vbZBS8EFsWl0?=
 =?us-ascii?Q?MILxmm571y5n/TH75IugngL73CL9UqEmbCr6t9IQrbtskGzTt9IF2gpi2HDS?=
 =?us-ascii?Q?lrQ7dsD57ONv3R9+zalZlK5p75XrLR8uq3mHxkwjfNEX8R0F9lJPCx4ZXbwo?=
 =?us-ascii?Q?toz/LBT/wOgK/ACfUzrDGxnDO7is4fEe1wog0yJmE/kX+YvY6WlLstxu1YOh?=
 =?us-ascii?Q?UeiRbdd7NchwCDq7IgkuLQMuaw5wj7/TPG2EV+8yUord0VKeu6DpzIHdFfis?=
 =?us-ascii?Q?qbvPfH4Y7x0NUeDKGKEN4w+b+eHj7o22JxYgwbGsDGkcSoAC4KBgr/p8qGxO?=
 =?us-ascii?Q?9Ln0wcC3Q3NhUXJdtSJj6wl7HT/aFbV6psaiWjnUZI7A/+7AwWhSzAl53Qbp?=
 =?us-ascii?Q?XW3TgbNiwyHcoUF5fyf5mrRQum5Abh5xlXxhceZICkinLUD8tV0Dx/bAkkGK?=
 =?us-ascii?Q?nK5ndmc5oBndeSlKUUQz1DoW8Z902YY0G0GuiTo+K88d3mUpmYFiybDk0RA6?=
 =?us-ascii?Q?te9Z1ze1Rf9VSlCSkG7JZxssp6lxLgfRU2eFCBCMtjAISPYcNLmRHvZF/iec?=
 =?us-ascii?Q?+i7F9B3QvlS+kK8ysKl/bi1pU7YiX6QyawZyeEBCs7i9ZY5mqiBL6rVFHtMC?=
 =?us-ascii?Q?o9hZzf0NFWV/RyLA8yr/NsWjcgQrR1ax1DJan2NrVlT0crfKGWzwXUmv2Xm0?=
 =?us-ascii?Q?MWDYM1pkDwg8yZjpuO1gLdRlKbwj/gv3QoFGkWkMR6Ty5lB0rQZtZz8O+v9C?=
 =?us-ascii?Q?vr9X4yPMdphzxJ7xrQGISUUjOLKKX2JqODM+Z9kO/be8Xdtj3EN0twVf/WVQ?=
 =?us-ascii?Q?sgiKQruBo3BZD7yB6sZbTM8hFq6Q6pOChrgqHU2mD0pmKJidBWZsL4Qt5Swf?=
 =?us-ascii?Q?m5fkJG1sux71EkG1OXkKQRdo1xOttu2FX2mF/ewIaq/R2txrdCNcXXTjb2Lp?=
 =?us-ascii?Q?HIYsHzXq70DwAF+peMr4ZmiOeWPCMNurZtiFYcfFKkKgVioVupILqsLG/s1b?=
 =?us-ascii?Q?4bHSQTKy+ZQUEkdexlXOPM7Dv66J5POCRxPfk1DthY0oIdBaXEwI5LewqfsK?=
 =?us-ascii?Q?stOPtoQyhqbokV1uM/joBK3wtOTfBetBcfPdpRFRnE43fWH4LD1jTJ4ULbO+?=
 =?us-ascii?Q?mAnQShSbEMxTksN6e9kZv994rOcJxudItbeyMUdkEA+M6w0p5A/ApDdgPUuD?=
 =?us-ascii?Q?IHwIdNHKC8bopObRE8O4znJL+iPz7DzRGwSZqSDRv35jZYM6kA5uupy3zCo4?=
 =?us-ascii?Q?h11Bpkg9M7/OkCrlNxs5pO54esnvbLschvkMuClyucYpeVJwNzPFvNHrBEaA?=
 =?us-ascii?Q?BQQVuFDJwmPnDqJzU8kxSA5LQXn8bvEi0rcAJU9LEDMAZjPA8q+9OPVeWjef?=
 =?us-ascii?Q?cVDOLszRLPJl9ixVboBgGjR5FCplXFH0dsqbSjmdEDIGdJVvlW/CKAaDsP99?=
 =?us-ascii?Q?nEB8AJbguv2hVA6FsY0CziBfBv9jhen2lTXqRka8bn+EU17DVvcyskqujgaV?=
 =?us-ascii?Q?mXzNQz7UIA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d24143-2fa7-4e72-7662-08de4eba6ad0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 13:32:50.1067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdQl1/Wtb33Fdg/NG3d21HW2Xcm3TqCE7k/zBIsmzqpkctOOaUzyhys6NFEY6O9/8wOhtqzjj7xn3vHMjfhakQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12078
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:28 +0100
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

Please pull mmc-for-2026.04-rc1

-----------------------------------------------------------------
Revert "Use max-frequency from device tree with default handling"
Select CRC16 MMC_SPI_CRC_ON
Add 1ms delay with 1ms margin after mmc power on to follow spec
-----------------------------------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/28960

Thanks,
Peng

The following changes since commit 141be72e2a9d43aa4e3d1a6a6e0ab8f9eb8784c6:

  Merge patch series "test: env: Add test for environment storage in SPI NOR" (2026-01-07 12:31:56 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mmc.git tags/mmc-for-2026.04-rc1

for you to fetch changes up to c4f5b1d4b037beeb538cf6dee0a16cd196539273:

  Revert "mmc: mmc-uclass: Use max-frequency from device tree with default handling" (2026-01-08 22:23:48 +0800)

----------------------------------------------------------------
Christoph Stoidner (1):
      mmc: Fix missing 1 ms delay after mmc power up

Daniel Palmer (1):
      mmc: mmc_spi: Select CRC16 if CRC checking is enabled

Tanmay Kathpalia (1):
      Revert "mmc: mmc-uclass: Use max-frequency from device tree with default handling"

 drivers/mmc/Kconfig      |  1 +
 drivers/mmc/mmc-uclass.c |  9 ++-------
 drivers/mmc/mmc.c        | 13 ++++++++++---
 3 files changed, 13 insertions(+), 10 deletions(-)
