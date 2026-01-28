Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BBDD3567B
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 06:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B03684241;
	Wed, 28 Jan 2026 07:14:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="n4boInSS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B5E384242; Wed, 28 Jan 2026 07:14:41 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 905A68423D
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 07:14:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpG3xzMChoTy8OLTpB44INUnGIUrpjd7wpEkrVRuqn5JeTdAZdPROdvatlH9j+rV0JSJjn3Dywr5LlyrZZ/R7RQWWOduXGR4dSG2BsBRVLpV/l/VpUlpVz5nCPElUbcGvfVi87oDmbnCjxNlburh5H/Xgbo3/Tdjgf7h05Ojb04OFpU65M8MwFrac5DWGYA47WDAbLGuD8BzRiwULblirTnQrqL+I9eXjV+zMDeKIwVuM90gzsO8SU0rrBRqEHDfRVfOM9sSYXF8YmSdVUtmnOyJ4sREb51qVlUoehV+JR1XbMfnLCZysrNrPdwkiqScxYb5rOCFNpzsIK7z0dp6qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSelQL0D/EvrOMucYdPjcno/I+as3upf7nF28qCW1b0=;
 b=bN9HdZFmRtZaZP95/N22BCT7auFTtCL1ChqM2SpNf8/6EWdSDPOGb3L5JpqBZyaofTj/R+pmblhYgDO105kvGC2TcJaYdIj+3Jxcb1OkuHxRGPE6XgmpnbwiH4VI/R7Y9m5Qtk9tmi1iJddcdmalA7Y8sE1ZRM3iat4uBZcNaoFKcsmc8Vt9M7s2MjetNap1VUgA6ghHR/42I8jHKPqqsOhwEHN83K23uZSSWp5OMtXaFBYwy2okowGLiP4uzpWvqWIvbcYDEWPfvM7EUXej5BWBZNpznpEQ2qXl4ZZmOgEPsvzINUxczz35Ai7OuHJR/uaeQIeSwmDrI3vw3K5FaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSelQL0D/EvrOMucYdPjcno/I+as3upf7nF28qCW1b0=;
 b=n4boInSSoEP+5DQRh5zcalhE1yuq4YMLZZRBPfw/0i+lw16DGmptma/CRk/BXCtmzW2UL4z9aoFNL1f1gWP9hxeqKtaJFUj/uMBFRIW+s2c7OUPud1X+9vQ++KRaRiesi/AvGVMInYkIyEaW5bzsc1cXROYtWEuFrljYFhN90NgHMXdfZuuZQDkya5rXxtbBaKc+V+kMio8XNrmBZhC1OLRk4jwtmaRjAh41cEoLgQTUSX3+l+ikCF3ECglRXBs5nidb/7TWM02K4nqkR2tYIc6kRhTLzVQZk03bgiZGnMGZrAmrAOzhtTiw5QBn1AguMiAAS1KPCtmUAz+6lko8kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8450.eurprd04.prod.outlook.com (2603:10a6:20b:346::5)
 by PA2PR04MB10445.eurprd04.prod.outlook.com (2603:10a6:102:41f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 06:14:35 +0000
Received: from AS8PR04MB8450.eurprd04.prod.outlook.com
 ([fe80::d3ed:eac:1f17:e9bd]) by AS8PR04MB8450.eurprd04.prod.outlook.com
 ([fe80::d3ed:eac:1f17:e9bd%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 06:14:35 +0000
Date: Wed, 28 Jan 2026 15:29:13 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, alice.guo@nxp.com, mateuslima.ti@gmail.com
Subject: [GIT PULL] please pull fsl-qoirq-for-2026.04-rc2
Message-ID: <aXm6yY-uf6rpXsu_@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0078.apcprd02.prod.outlook.com
 (2603:1096:4:90::18) To AS8PR04MB8450.eurprd04.prod.outlook.com
 (2603:10a6:20b:346::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8450:EE_|PA2PR04MB10445:EE_
X-MS-Office365-Filtering-Correlation-Id: c405e8db-b453-4c9f-f980-08de5e3481ec
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|19092799006|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3ad//E0Iv1I0yXoVT4HsiNNk51HJcJAapXkIBZoBR7gjCiq20raJ8mdy0vGg?=
 =?us-ascii?Q?pinkWAmiu9+K1k1csAYIHR6v/FDtT01Dh5oHWElbNmxqhtdUEQovfWtAfuPe?=
 =?us-ascii?Q?VeSLgV+HeNQ3h6ZcStqy0anc5HKB7IZ3BgjIDxy3dUQLwC1gOkJ9hYh3aWOq?=
 =?us-ascii?Q?cJIORb+zWhS7B+HhryY+BBIeOCWai9esggNTBj4yF7lyoTz1D8jiBLQAtped?=
 =?us-ascii?Q?2DNUdPHrvA3RY5UEhCtnPKCCYgMSVfX7cMcEDErka7RJfDS2zbOFUsrNKlzl?=
 =?us-ascii?Q?00ETPEgHMBl1gqsM5UJ49bXmg6acqo/wACBvcPPrP4gtVPZdMFV2o4QtAsiW?=
 =?us-ascii?Q?6c6gA9CwMGVhw0SCDQ1MpqYG6oOsrlo/ZirR8rQ+haY+AuAkOISjAMQ0SPow?=
 =?us-ascii?Q?tH2F8+l4MePU7e2SUnq6cDad+bMr+zNmZGQ8ofOGMT1+Ds5Rf81t/D4RkgEK?=
 =?us-ascii?Q?XlGaQVcPEnwBHOkq6rFHrn+SWgzPloSCt/m3zLjsauSjcdaAt1A8mIzH8+yp?=
 =?us-ascii?Q?l7s4CByoeX6PG7mRKSpJ5zW6hPvaD3m45z0tDke1hj9BsUXSjwxbKJidkz8g?=
 =?us-ascii?Q?GZ78N6Yg3ChiFmOmh2luyKlz7S9pvbAe4uDssdOKOIDkFa5mLCK3O0oPUYmN?=
 =?us-ascii?Q?cv5gNdnEdv4ZaD6WXq5dhmfN/2asnM0nYB1zoZ3Rml0+nzqsh5zuV0e35wsD?=
 =?us-ascii?Q?9DZTWV33u35YNQRFkw8EYDyGLvzcYCYE/bsXWsbzE/v9rqfBPjwcN81bXC2o?=
 =?us-ascii?Q?KXTiKHtWBPao7Yt9W3NE5pmBY/GSvjKyfH+zmCCt6M04t3LhGKH2WeEArQg2?=
 =?us-ascii?Q?mN7/1rnaU4WnRtSE1Ql7QeU3jGoskt9PMMcAXD4eeiol4L8DTT39qj9uCuyK?=
 =?us-ascii?Q?g2vO4P56csBJGsmTcSGOWTuSJ4HS8ZYZXpDT/LBm5zJYyGwwBkXf3FSInTSb?=
 =?us-ascii?Q?aq+YeYPzctTJNL+wJpEvB70xDz9CmQcHgTzrWG0QvWoWiYbI/TxMNGSmQwZ6?=
 =?us-ascii?Q?iG9+Sc7LSmofQdJISVNN0l1f3SdlHFdoFHKka8l0N9dLJjVBH426s10WY5cS?=
 =?us-ascii?Q?CXGmaptIU8ArgMu0Pvz79009aUsJKH3lau29DXAO5SnElU6xGPZlAoneM/Sz?=
 =?us-ascii?Q?PG09Y7z5VCWOg98kx0u++8zo+CFhU9j7fnkVtOAbMXdEfsrpV+rZNvzoIr/w?=
 =?us-ascii?Q?tz5GqiS0GkFglBuRDueKjkMssIfSZZRRPEVY2Rf7gfNJLFWoVTIfLvpn8Q0l?=
 =?us-ascii?Q?VeaC8ty0U58tE46J0Tzo6MQGP1Hoe/5b0clyLzPEdgGUxZZDrKXjk83mGTTz?=
 =?us-ascii?Q?qOkqxA9J04t5eaV+T96Qs/MESE9aG8DtkM11YSIXX8/Z73bmp8xP6AP1xGMy?=
 =?us-ascii?Q?ghqGAGXVgTtfX/QO7MDPyLX1/GJugcuUCrXFw3s+EBazssegO6fYgTmaNfJ5?=
 =?us-ascii?Q?9mzcY8ukTMsqQbhkBJOGUvZqDvLk+9i2ZpsIo8FSaIWwzZLr53rW5cykp5QE?=
 =?us-ascii?Q?dc+gSbVIMe+uzmA1ZCHNxRkvHrD4ASfOJShxWMFrjOSmJHkoy13nIpEOZDpZ?=
 =?us-ascii?Q?4Qe6WRg57M0U7/cUejZi/XJAzTM3EyoVCTozs8FrvARmrSps2k9eLliX2kF2?=
 =?us-ascii?Q?J7WZBtbuQYZUpNDpoQHItYPN2dUBPDW6P/1lbNlyio1Z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8450.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(19092799006)(376014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D+Lo/B7MDa1SAC5KmoIhFaeW9CNHAtXWMpWwGq+N/VemR+8apWa+EhYOoWkU?=
 =?us-ascii?Q?NT/VTVPsE30gWZNK3oJ9aWml7/gq3/COm4+qgxakc24AvAnSbBWHwZt94JMF?=
 =?us-ascii?Q?KBKSo+X5djCnaFfGyabK5y1HHBviBRmA5veJOc3Q5IR7wSfzNAIISNUEqe4Y?=
 =?us-ascii?Q?PwSWVxmazbehhvGcTzXu0Y83M7BKlP5hzDgbeGt0S969FWe46ZgDhbJlqjpf?=
 =?us-ascii?Q?E6TaZzB+ey/huHGvm4/Nsu2tlACDPd5dq/3BAALikYVoDWyb8JY3H9/QFcai?=
 =?us-ascii?Q?rL4JJ78xO1Ei+ZRC3QgKtYlzO7gJB9Bs61n/RSxUGCib2Z/ysGjLlLEYuOSo?=
 =?us-ascii?Q?SgSwBe+lvdboHTaXTB+TsfZ3xjF97odvQh1mQaKqQB8D3m5kLxrJacCcOSlW?=
 =?us-ascii?Q?lPjA+mWrPenLbrhL5g4nB9U2tJ944t9AFbWXi8ObS7CzQ8LdMdhM09vMaNnz?=
 =?us-ascii?Q?YFUnBrl25nGbG26iwohlk+8q5rdGb+cexNdI+LWS5+UyO/6yiXjNGrYR868X?=
 =?us-ascii?Q?UDhI5YBk/bJWyOOE0Do5iNv0Y2EYoNcTfEEyWSFssCDH8owWmypKHkndcRT8?=
 =?us-ascii?Q?VNU+ioNAfe5KvK0uY5U58PB2IPErQTV2yQqnZ1pgQrNYpTKp1w7G6zBh8zaf?=
 =?us-ascii?Q?PitqkbsZPpvJ3CPuZMSomjE429GEvoMv+tn1/Ev5r8W6di0ofoCtXVMZXfuW?=
 =?us-ascii?Q?z7d6K8ebLjxhCyPIbR2TXZkVZrlW4KfZFV1hXcQVj4soBpRmx6Tgvk1WwT08?=
 =?us-ascii?Q?8NfhAc97JeJxUaRVFtCIdcK77QUgB9Z08H7VzBROgNrTmr4uODSbBFnjSxk1?=
 =?us-ascii?Q?uibxkVDK6GHvOJhEr38j5GIzs4btQ0GjBNgWCLYXvKHpu860ztoYvWKXtPfe?=
 =?us-ascii?Q?EsNlYxJsmb4zBQP2UAFSkFz7Us/rzpOQTtSU7tdRt7zN8tt9eA4t+nga+J0B?=
 =?us-ascii?Q?HAN8F/LSyCLrymHsbSHjCVZUIA6xYiurXwzEXaUGl3DBp6TMrs5fThFCV57I?=
 =?us-ascii?Q?2Aar521xlnUFpeXyCrslKWnExBVMPgoblvP3GGzMbV9/6abzCSjudt8dhxHz?=
 =?us-ascii?Q?tDHeszN+JELB9F6VbBQZQwEMHu01aETD/vI6TRyDU6sOqFL8WWH9nKm3GiLh?=
 =?us-ascii?Q?Yl/C9dGDkyAEJlQgz6rqSpBDF3tUhLBUNm46c43pq1iE72l2agbrjbVMWPZ6?=
 =?us-ascii?Q?7RTJcq9pIeZzc9NYDFk+5vNZY1e1c7pTXoCzvrrU2jbwAzUDRSpHPLSrDFvq?=
 =?us-ascii?Q?VNQaV9w7wBKuNgFGQkxvwm3T/I8HSW8ZzfOD4R9HBne4Zvdcsb5GDi/VvkmF?=
 =?us-ascii?Q?7NWQZOg8YDMDIykdO1moQZ6LH9itk+8aE4wmde3jklTwX0Tg/6MU5lXLAYJH?=
 =?us-ascii?Q?pDaenwlYvODwTiSkburLRqZJuLmEoXyZHa1q6+3Get9dcdWzFlp3p4m/fkDc?=
 =?us-ascii?Q?D0mlpEceFJ5Bf3eZu+1XYLBxHQh/F+4snStaCo8ATitOFEHl5djuhg9+t4x1?=
 =?us-ascii?Q?g9GR0U4b05+QJC2jax2xv1J+A75GfgmMngq+dsAEVal6QxZhRXMvVL7SwWR8?=
 =?us-ascii?Q?/0LUiRQ0LUuthXZ7pwKfNEC/cbL+7HKCX9l7tZAIIptKBEeVL/uAxzLk8P+S?=
 =?us-ascii?Q?6JmPVQYeHVWBlBCotHdxYdZmvx/hnmH8GlgBrmRjOI+aBc9yTGhQcFr9OxDu?=
 =?us-ascii?Q?gB10NJb8VclAE7qPnvqyJcVOb0DHS2l11GeMJTA+xU7ATY+sE+lNaNhZ8Ncr?=
 =?us-ascii?Q?fWyRzrOoyA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c405e8db-b453-4c9f-f980-08de5e3481ec
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8450.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 06:14:34.9663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDIXtyomVXgO4F383RhZtpbLh3YzT4agFJGMm8vpzMVHypd7ljffQE0JyV/4UCLKMAgvPMH9e2XZhXEhyzbKRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10445
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

Please pull fsl-qoriq-for-2026.04-rc2

-------------------------------------------------
Rename freescale to nxp
Add CPLD support via IFC to the ls1021a-iot board
Use scmi_clk_state_in_v2 in sandbox
-------------------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/29107

Thanks,
Peng

The following changes since commit 431f1ce46bbffff0db8f03437a34400b11b30175:

  Revert a number of incorrect commits (2026-01-27 09:29:59 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git tags/fsl-qoriq-for-2026.04-rc2

for you to fetch changes up to 8e918cbe7a1cb87d0b18df91ed1edec9fff2f941:

  firmware: scmi: sandbox: Use scmi_clk_state_in_v2 (2026-01-28 14:28:01 +0800)

----------------------------------------------------------------
Alice Guo (1):
      board: nxp: Rename board directory from board/freescale to board/nxp

Mateus Lima Alves (1):
      armv7: Add CPLD support via IFC to the ls1021a-iot board.

Peng Fan (1):
      firmware: scmi: sandbox: Use scmi_clk_state_in_v2

 MAINTAINERS                                        |  4 +--
 arch/arm/Kconfig                                   | 34 +++++++++++-----------
 arch/arm/cpu/armv7/vf610/Kconfig                   |  2 +-
 arch/arm/mach-imx/imx8/Kconfig                     |  4 +--
 arch/arm/mach-imx/imx8m/Kconfig                    |  8 ++---
 arch/arm/mach-imx/imx8ulp/Kconfig                  |  2 +-
 arch/arm/mach-imx/imx9/Kconfig                     | 14 ++++-----
 arch/arm/mach-imx/imxrt/Kconfig                    |  6 ++--
 arch/arm/mach-imx/mx5/Kconfig                      |  4 +--
 arch/arm/mach-imx/mx6/Kconfig                      | 18 ++++++------
 arch/arm/mach-imx/mx7/Kconfig                      |  2 +-
 arch/arm/mach-imx/mx7ulp/Kconfig                   |  2 +-
 arch/arm/mach-imx/mxs/Kconfig                      |  4 +--
 arch/m68k/Kconfig                                  | 20 ++++++-------
 arch/powerpc/cpu/mpc83xx/Kconfig                   |  2 +-
 arch/powerpc/cpu/mpc85xx/Kconfig                   | 18 ++++++------
 board/CZ.NIC/turris_1x/MAINTAINERS                 |  4 +--
 board/CZ.NIC/turris_1x/Makefile                    |  4 +--
 board/CZ.NIC/turris_1x/turris_1x.c                 |  2 +-
 board/beacon/imx8mm/Makefile                       |  2 +-
 board/beacon/imx8mn/Makefile                       |  2 +-
 board/beacon/imx8mp/Kconfig                        |  2 +-
 board/beacon/imx8mp/Makefile                       |  2 +-
 board/beckhoff/mx53cx9020/imximage.cfg             |  2 +-
 board/beckhoff/mx53cx9020/mx53cx9020.c             |  2 +-
 board/beckhoff/mx53cx9020/mx53cx9020_video.c       |  2 +-
 board/boundary/nitrogen6x/README                   |  2 +-
 board/ea/mx7ulp_com/imximage.cfg                   |  2 +-
 board/ge/mx53ppd/Makefile                          |  2 +-
 board/ge/mx53ppd/imximage.cfg                      |  2 +-
 board/ge/mx53ppd/mx53ppd.c                         |  2 +-
 board/ge/mx53ppd/mx53ppd_video.c                   |  2 +-
 board/k+p/kp_imx53/Kconfig                         |  2 +-
 board/keymile/pg-wcom-ls102xa/Makefile             |  6 ++--
 board/{freescale => nxp}/common/Makefile           |  0
 board/{freescale => nxp}/common/arm_sleep.c        |  0
 board/{freescale => nxp}/common/cadmus.c           |  0
 board/{freescale => nxp}/common/cadmus.h           |  0
 board/{freescale => nxp}/common/cds_pci_ft.c       |  0
 board/{freescale => nxp}/common/cds_via.c          |  0
 .../{freescale => nxp}/common/cmd_esbc_validate.c  |  0
 board/{freescale => nxp}/common/eeprom.h           |  0
 board/{freescale => nxp}/common/emc2305.c          |  0
 board/{freescale => nxp}/common/emc2305.h          |  0
 board/{freescale => nxp}/common/fman.c             |  0
 board/{freescale => nxp}/common/fman.h             |  0
 .../{freescale => nxp}/common/fsl_chain_of_trust.c |  0
 board/{freescale => nxp}/common/fsl_validate.c     |  0
 board/{freescale => nxp}/common/i2c_common.c       |  0
 board/{freescale => nxp}/common/i2c_common.h       |  0
 board/{freescale => nxp}/common/i2c_mux.c          |  0
 board/{freescale => nxp}/common/i2c_mux.h          |  0
 board/{freescale => nxp}/common/ics307_clk.c       |  0
 board/{freescale => nxp}/common/ics307_clk.h       |  0
 .../{freescale => nxp}/common/ls102xa_stream_id.c  |  0
 board/{freescale => nxp}/common/mc34vr500.c        |  0
 board/{freescale => nxp}/common/mmc.c              |  0
 board/{freescale => nxp}/common/mpc85xx_sleep.c    |  0
 board/{freescale => nxp}/common/ngpixis.c          |  0
 board/{freescale => nxp}/common/ngpixis.h          |  0
 board/{freescale => nxp}/common/ns_access.c        |  0
 board/{freescale => nxp}/common/p_corenet/Makefile |  0
 board/{freescale => nxp}/common/p_corenet/law.c    |  0
 board/{freescale => nxp}/common/p_corenet/tlb.c    |  0
 board/{freescale => nxp}/common/pfuze.c            |  0
 board/{freescale => nxp}/common/pfuze.h            |  0
 board/{freescale => nxp}/common/qixis.c            |  0
 board/{freescale => nxp}/common/qixis.h            |  0
 board/{freescale => nxp}/common/sdhc_boot.c        |  0
 board/{freescale => nxp}/common/sgmii_riser.h      |  0
 board/{freescale => nxp}/common/sleep.h            |  0
 board/{freescale => nxp}/common/spl.h              |  0
 board/{freescale => nxp}/common/sys_eeprom.c       |  0
 board/{freescale => nxp}/common/via.h              |  0
 board/{freescale => nxp}/common/vid.c              |  0
 board/{freescale => nxp}/common/vid.h              |  0
 board/{freescale => nxp}/common/vsc3316_3308.h     |  0
 board/{freescale => nxp}/imx8mm_evk/Kconfig        |  4 +--
 board/{freescale => nxp}/imx8mm_evk/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/imx8mm_evk/Makefile       |  0
 board/{freescale => nxp}/imx8mm_evk/imx8mm_evk.c   |  0
 board/{freescale => nxp}/imx8mm_evk/imx8mm_evk.env |  0
 .../imx8mm_evk/imximage-8mm-lpddr4-fspi.cfg        |  0
 .../imx8mm_evk/imximage-8mm-lpddr4.cfg             |  0
 .../{freescale => nxp}/imx8mm_evk/lpddr4_timing.c  |  0
 board/{freescale => nxp}/imx8mm_evk/spl.c          |  0
 board/{freescale => nxp}/imx8mn_evk/Kconfig        |  4 +--
 board/{freescale => nxp}/imx8mn_evk/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/imx8mn_evk/Makefile       |  0
 board/{freescale => nxp}/imx8mn_evk/ddr4_timing.c  |  0
 .../{freescale => nxp}/imx8mn_evk/ddr4_timing_ld.c |  0
 board/{freescale => nxp}/imx8mn_evk/imx8mn_evk.c   |  0
 board/{freescale => nxp}/imx8mn_evk/imx8mn_evk.env |  0
 .../imx8mn_evk/imximage-8mn-ddr4.cfg               |  0
 .../{freescale => nxp}/imx8mn_evk/lpddr4_timing.c  |  0
 .../imx8mn_evk/lpddr4_timing_ld.c                  |  0
 board/{freescale => nxp}/imx8mn_evk/spl.c          |  0
 board/{freescale => nxp}/imx8mp_evk/Kconfig        |  4 +--
 board/{freescale => nxp}/imx8mp_evk/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/imx8mp_evk/Makefile       |  0
 board/{freescale => nxp}/imx8mp_evk/imx8mp_evk.c   |  0
 board/{freescale => nxp}/imx8mp_evk/imx8mp_evk.env |  0
 .../imx8mp_evk/imximage-8mp-lpddr4.cfg             |  0
 .../{freescale => nxp}/imx8mp_evk/lpddr4_timing.c  |  0
 board/{freescale => nxp}/imx8mp_evk/spl.c          |  0
 board/{freescale => nxp}/imx8mq_evk/Kconfig        |  2 +-
 board/{freescale => nxp}/imx8mq_evk/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/imx8mq_evk/Makefile       |  0
 board/{freescale => nxp}/imx8mq_evk/imx8mq_evk.c   |  0
 board/{freescale => nxp}/imx8mq_evk/imx8mq_evk.env |  0
 .../{freescale => nxp}/imx8mq_evk/lpddr4_timing.c  |  0
 .../imx8mq_evk/lpddr4_timing_b0.c                  |  0
 board/{freescale => nxp}/imx8mq_evk/spl.c          |  0
 board/{freescale => nxp}/imx8qm_mek/Kconfig        |  4 +--
 board/{freescale => nxp}/imx8qm_mek/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/imx8qm_mek/Makefile       |  0
 board/{freescale => nxp}/imx8qm_mek/README         |  0
 board/{freescale => nxp}/imx8qm_mek/imx8qm_mek.c   |  0
 board/{freescale => nxp}/imx8qm_mek/imximage.cfg   |  0
 board/{freescale => nxp}/imx8qm_mek/spl.c          |  0
 .../imx8qm_mek/uboot-container.cfg                 |  0
 board/{freescale => nxp}/imx8qxp_mek/Kconfig       |  4 +--
 board/{freescale => nxp}/imx8qxp_mek/MAINTAINERS   |  2 +-
 board/{freescale => nxp}/imx8qxp_mek/Makefile      |  0
 board/{freescale => nxp}/imx8qxp_mek/imx8qxp_mek.c |  0
 board/{freescale => nxp}/imx8qxp_mek/imximage.cfg  |  0
 board/{freescale => nxp}/imx8qxp_mek/spl.c         |  0
 .../imx8qxp_mek/uboot-container.cfg                |  0
 board/{freescale => nxp}/imx8ulp_evk/Kconfig       |  2 +-
 board/{freescale => nxp}/imx8ulp_evk/MAINTAINERS   |  2 +-
 board/{freescale => nxp}/imx8ulp_evk/Makefile      |  0
 board/{freescale => nxp}/imx8ulp_evk/imx8ulp_evk.c |  0
 .../{freescale => nxp}/imx8ulp_evk/imx8ulp_evk.env |  0
 .../{freescale => nxp}/imx8ulp_evk/lpddr4_timing.c |  0
 .../imx8ulp_evk/lpddr4_timing_266.c                |  0
 board/{freescale => nxp}/imx8ulp_evk/spl.c         |  0
 board/{freescale => nxp}/imx91_evk/Kconfig         |  2 +-
 board/{freescale => nxp}/imx91_evk/MAINTAINERS     |  2 +-
 board/{freescale => nxp}/imx91_evk/Makefile        |  0
 board/{freescale => nxp}/imx91_evk/imx91_evk.c     |  0
 board/{freescale => nxp}/imx91_evk/imx91_evk.env   |  0
 .../imx91_evk/lpddr4_timing_1600mts.c              |  0
 .../imx91_evk/lpddr4_timing_1600mts_ecc.c          |  0
 .../imx91_evk/lpddr4_timing_2400mts.c              |  0
 .../imx91_evk/lpddr4_timing_2400mts_ecc.c          |  0
 board/{freescale => nxp}/imx91_evk/spl.c           |  0
 board/{freescale => nxp}/imx91_frdm/Kconfig        |  2 +-
 board/{freescale => nxp}/imx91_frdm/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/imx91_frdm/Makefile       |  0
 board/{freescale => nxp}/imx91_frdm/imx91_frdm.c   |  0
 board/{freescale => nxp}/imx91_frdm/imx91_frdm.env |  0
 .../imx91_frdm/lpddr4_2400mts_1gb_timing.c         |  0
 .../imx91_frdm/lpddr4_2400mts_2gb_timing.c         |  0
 .../imx91_frdm/lpddr4_2400mts_ecc_1gb_timing.c     |  0
 .../imx91_frdm/lpddr4_2400mts_ecc_2gb_timing.c     |  0
 .../{freescale => nxp}/imx91_frdm/lpddr4_timing.h  |  0
 board/{freescale => nxp}/imx91_frdm/spl.c          |  0
 board/{freescale => nxp}/imx93_evk/Kconfig         |  2 +-
 board/{freescale => nxp}/imx93_evk/MAINTAINERS     |  2 +-
 board/{freescale => nxp}/imx93_evk/Makefile        |  0
 board/{freescale => nxp}/imx93_evk/imx93_evk.c     |  0
 board/{freescale => nxp}/imx93_evk/imx93_evk.env   |  0
 .../{freescale => nxp}/imx93_evk/lpddr4x_timing.c  |  0
 .../imx93_evk/lpddr4x_timing_1866mts.c             |  0
 board/{freescale => nxp}/imx93_evk/spl.c           |  0
 board/{freescale => nxp}/imx93_frdm/Kconfig        |  2 +-
 board/{freescale => nxp}/imx93_frdm/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/imx93_frdm/Makefile       |  0
 board/{freescale => nxp}/imx93_frdm/imx93_frdm.c   |  0
 board/{freescale => nxp}/imx93_frdm/imx93_frdm.env |  0
 .../{freescale => nxp}/imx93_frdm/lpddr4_timing.h  |  0
 .../imx93_frdm/lpddr4x_1gb_timing.c                |  0
 .../imx93_frdm/lpddr4x_2gb_timing.c                |  0
 board/{freescale => nxp}/imx93_frdm/spl.c          |  0
 board/{freescale => nxp}/imx93_qsb/Kconfig         |  2 +-
 board/{freescale => nxp}/imx93_qsb/MAINTAINERS     |  2 +-
 board/{freescale => nxp}/imx93_qsb/Makefile        |  0
 board/{freescale => nxp}/imx93_qsb/imx93_qsb.c     |  0
 board/{freescale => nxp}/imx93_qsb/imx93_qsb.env   |  0
 board/{freescale => nxp}/imx93_qsb/lpddr4_timing.c |  0
 .../imx93_qsb/lpddr4_timing_ecc.c                  |  0
 board/{freescale => nxp}/imx93_qsb/spl.c           |  0
 board/{freescale => nxp}/imx94_evk/Kconfig         |  2 +-
 board/{freescale => nxp}/imx94_evk/MAINTAINERS     |  2 +-
 board/{freescale => nxp}/imx94_evk/Makefile        |  0
 board/{freescale => nxp}/imx94_evk/imx94_evk.c     |  0
 board/{freescale => nxp}/imx94_evk/imx94_evk.env   |  0
 board/{freescale => nxp}/imx94_evk/spl.c           |  0
 board/{freescale => nxp}/imx95_evk/Kconfig         |  2 +-
 board/{freescale => nxp}/imx95_evk/MAINTAINERS     |  2 +-
 board/{freescale => nxp}/imx95_evk/Makefile        |  0
 board/{freescale => nxp}/imx95_evk/imx95_evk.c     |  0
 board/{freescale => nxp}/imx95_evk/imx95_evk.env   |  0
 board/{freescale => nxp}/imx95_evk/spl.c           |  0
 board/{freescale => nxp}/imxrt1020-evk/Kconfig     |  4 +--
 board/{freescale => nxp}/imxrt1020-evk/MAINTAINERS |  2 +-
 board/{freescale => nxp}/imxrt1020-evk/Makefile    |  0
 .../{freescale => nxp}/imxrt1020-evk/imximage.cfg  |  0
 .../imxrt1020-evk/imxrt1020-evk.c                  |  0
 board/{freescale => nxp}/imxrt1050-evk/Kconfig     |  4 +--
 board/{freescale => nxp}/imxrt1050-evk/MAINTAINERS |  2 +-
 board/{freescale => nxp}/imxrt1050-evk/Makefile    |  0
 .../imxrt1050-evk/imximage-nor.cfg                 |  0
 .../{freescale => nxp}/imxrt1050-evk/imximage.cfg  |  0
 .../imxrt1050-evk/imxrt1050-evk-nor.env            |  0
 .../imxrt1050-evk/imxrt1050-evk.c                  |  0
 .../imxrt1050-evk/imxrt1050-evk.env                |  0
 board/{freescale => nxp}/imxrt1170-evk/Kconfig     |  4 +--
 board/{freescale => nxp}/imxrt1170-evk/MAINTAINERS |  2 +-
 board/{freescale => nxp}/imxrt1170-evk/Makefile    |  0
 .../{freescale => nxp}/imxrt1170-evk/imximage.cfg  |  0
 .../imxrt1170-evk/imxrt1170-evk.c                  |  0
 board/{freescale => nxp}/ls1012afrdm/Kconfig       |  4 +--
 board/{freescale => nxp}/ls1012afrdm/MAINTAINERS   |  4 +--
 board/{freescale => nxp}/ls1012afrdm/Makefile      |  0
 board/{freescale => nxp}/ls1012afrdm/README        |  0
 board/{freescale => nxp}/ls1012afrdm/eth.c         |  0
 board/{freescale => nxp}/ls1012afrdm/ls1012afrdm.c |  0
 board/{freescale => nxp}/ls1012aqds/Kconfig        |  2 +-
 board/{freescale => nxp}/ls1012aqds/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/ls1012aqds/Makefile       |  0
 board/{freescale => nxp}/ls1012aqds/README         |  0
 board/{freescale => nxp}/ls1012aqds/eth.c          |  0
 board/{freescale => nxp}/ls1012aqds/ls1012aqds.c   |  0
 .../{freescale => nxp}/ls1012aqds/ls1012aqds_pfe.h |  0
 .../ls1012aqds/ls1012aqds_qixis.h                  |  0
 board/{freescale => nxp}/ls1012ardb/Kconfig        |  4 +--
 board/{freescale => nxp}/ls1012ardb/MAINTAINERS    |  4 +--
 board/{freescale => nxp}/ls1012ardb/Makefile       |  0
 board/{freescale => nxp}/ls1012ardb/README         |  0
 board/{freescale => nxp}/ls1012ardb/eth.c          |  0
 board/{freescale => nxp}/ls1012ardb/ls1012ardb.c   |  0
 board/{freescale => nxp}/ls1021aiot/Kconfig        |  2 +-
 board/{freescale => nxp}/ls1021aiot/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/ls1021aiot/Makefile       |  0
 board/{freescale => nxp}/ls1021aiot/README         |  0
 board/{freescale => nxp}/ls1021aiot/ls1021aiot.c   |  5 ++++
 .../{freescale => nxp}/ls1021aiot/ls102xa_pbi.cfg  |  0
 .../ls1021aiot/ls102xa_rcw_sd.cfg                  |  0
 board/{freescale => nxp}/ls1021aiot/psci.S         |  0
 board/{freescale => nxp}/ls1021aqds/Kconfig        |  2 +-
 board/{freescale => nxp}/ls1021aqds/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/ls1021aqds/Makefile       |  0
 board/{freescale => nxp}/ls1021aqds/README         |  0
 board/{freescale => nxp}/ls1021aqds/ddr.c          |  0
 board/{freescale => nxp}/ls1021aqds/ddr.h          |  0
 board/{freescale => nxp}/ls1021aqds/ls1021aqds.c   |  0
 .../ls1021aqds/ls1021aqds_qixis.h                  |  0
 .../{freescale => nxp}/ls1021aqds/ls102xa_pbi.cfg  |  0
 .../ls1021aqds/ls102xa_rcw_nand.cfg                |  0
 .../ls1021aqds/ls102xa_rcw_sd_ifc.cfg              |  0
 .../ls1021aqds/ls102xa_rcw_sd_qspi.cfg             |  0
 board/{freescale => nxp}/ls1021aqds/psci.S         |  0
 board/{freescale => nxp}/ls1021atsn/Kconfig        |  2 +-
 board/{freescale => nxp}/ls1021atsn/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/ls1021atsn/Makefile       |  0
 board/{freescale => nxp}/ls1021atsn/README.rst     |  0
 board/{freescale => nxp}/ls1021atsn/ls1021atsn.c   |  0
 .../{freescale => nxp}/ls1021atsn/ls102xa_pbi.cfg  |  0
 .../ls1021atsn/ls102xa_rcw_sd.cfg                  |  0
 board/{freescale => nxp}/ls1021atwr/Kconfig        |  2 +-
 board/{freescale => nxp}/ls1021atwr/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/ls1021atwr/Makefile       |  0
 board/{freescale => nxp}/ls1021atwr/README         |  0
 board/{freescale => nxp}/ls1021atwr/ls1021atwr.c   |  0
 .../{freescale => nxp}/ls1021atwr/ls102xa_pbi.cfg  |  0
 .../ls1021atwr/ls102xa_rcw_sd_ifc.cfg              |  0
 .../ls1021atwr/ls102xa_rcw_sd_qspi.cfg             |  0
 board/{freescale => nxp}/ls1021atwr/psci.S         |  0
 board/{freescale => nxp}/ls1028a/Kconfig           |  4 +--
 board/{freescale => nxp}/ls1028a/MAINTAINERS       |  4 +--
 board/{freescale => nxp}/ls1028a/Makefile          |  0
 board/{freescale => nxp}/ls1028a/README            |  0
 board/{freescale => nxp}/ls1028a/ddr.c             |  0
 board/{freescale => nxp}/ls1028a/ls1028a.c         |  0
 board/{freescale => nxp}/ls1043aqds/Kconfig        |  2 +-
 board/{freescale => nxp}/ls1043aqds/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/ls1043aqds/Makefile       |  0
 board/{freescale => nxp}/ls1043aqds/README         |  0
 board/{freescale => nxp}/ls1043aqds/ddr.c          |  0
 board/{freescale => nxp}/ls1043aqds/ddr.h          |  0
 board/{freescale => nxp}/ls1043aqds/eth.c          |  0
 board/{freescale => nxp}/ls1043aqds/ls1043aqds.c   |  0
 .../ls1043aqds/ls1043aqds_pbi.cfg                  |  0
 .../ls1043aqds/ls1043aqds_qixis.h                  |  0
 .../ls1043aqds/ls1043aqds_rcw_nand.cfg             |  0
 .../ls1043aqds/ls1043aqds_rcw_sd_ifc.cfg           |  0
 .../ls1043aqds/ls1043aqds_rcw_sd_qspi.cfg          |  0
 board/{freescale => nxp}/ls1043ardb/Kconfig        |  2 +-
 board/{freescale => nxp}/ls1043ardb/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/ls1043ardb/Makefile       |  0
 board/{freescale => nxp}/ls1043ardb/README         |  0
 board/{freescale => nxp}/ls1043ardb/cpld.c         |  0
 board/{freescale => nxp}/ls1043ardb/cpld.h         |  0
 board/{freescale => nxp}/ls1043ardb/ddr.c          |  0
 board/{freescale => nxp}/ls1043ardb/ddr.h          |  0
 board/{freescale => nxp}/ls1043ardb/eth.c          |  0
 board/{freescale => nxp}/ls1043ardb/ls1043ardb.c   |  0
 .../ls1043ardb/ls1043ardb_pbi.cfg                  |  0
 .../ls1043ardb/ls1043ardb_rcw_nand.cfg             |  0
 .../ls1043ardb/ls1043ardb_rcw_sd.cfg               |  0
 board/{freescale => nxp}/ls1046afrwy/Kconfig       |  2 +-
 board/{freescale => nxp}/ls1046afrwy/MAINTAINERS   |  4 +--
 board/{freescale => nxp}/ls1046afrwy/Makefile      |  0
 board/{freescale => nxp}/ls1046afrwy/README        |  0
 board/{freescale => nxp}/ls1046afrwy/ddr.c         |  0
 board/{freescale => nxp}/ls1046afrwy/eth.c         |  0
 board/{freescale => nxp}/ls1046afrwy/ls1046afrwy.c |  0
 board/{freescale => nxp}/ls1046aqds/Kconfig        |  2 +-
 board/{freescale => nxp}/ls1046aqds/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/ls1046aqds/Makefile       |  0
 board/{freescale => nxp}/ls1046aqds/README         |  0
 board/{freescale => nxp}/ls1046aqds/ddr.c          |  0
 board/{freescale => nxp}/ls1046aqds/ddr.h          |  0
 board/{freescale => nxp}/ls1046aqds/eth.c          |  0
 board/{freescale => nxp}/ls1046aqds/ls1046aqds.c   |  0
 .../ls1046aqds/ls1046aqds_pbi.cfg                  |  0
 .../ls1046aqds/ls1046aqds_qixis.h                  |  0
 .../ls1046aqds/ls1046aqds_rcw_nand.cfg             |  0
 .../ls1046aqds/ls1046aqds_rcw_sd_ifc.cfg           |  0
 .../ls1046aqds/ls1046aqds_rcw_sd_qspi.cfg          |  0
 board/{freescale => nxp}/ls1046ardb/Kconfig        |  2 +-
 board/{freescale => nxp}/ls1046ardb/MAINTAINERS    |  4 +--
 board/{freescale => nxp}/ls1046ardb/Makefile       |  0
 board/{freescale => nxp}/ls1046ardb/cpld.c         |  0
 board/{freescale => nxp}/ls1046ardb/cpld.h         |  0
 board/{freescale => nxp}/ls1046ardb/ddr.c          |  0
 board/{freescale => nxp}/ls1046ardb/ddr.h          |  0
 board/{freescale => nxp}/ls1046ardb/eth.c          |  0
 board/{freescale => nxp}/ls1046ardb/ls1046ardb.c   |  0
 .../ls1046ardb/ls1046ardb_pbi.cfg                  |  0
 .../ls1046ardb/ls1046ardb_qspi_pbi.cfg             |  0
 .../ls1046ardb/ls1046ardb_rcw_emmc.cfg             |  0
 .../ls1046ardb/ls1046ardb_rcw_qspi.cfg             |  0
 .../ls1046ardb/ls1046ardb_rcw_sd.cfg               |  0
 board/{freescale => nxp}/ls1088a/Kconfig           |  4 +--
 board/{freescale => nxp}/ls1088a/MAINTAINERS       |  4 +--
 board/{freescale => nxp}/ls1088a/Makefile          |  0
 board/{freescale => nxp}/ls1088a/README            |  0
 board/{freescale => nxp}/ls1088a/ddr.c             |  0
 board/{freescale => nxp}/ls1088a/ddr.h             |  0
 board/{freescale => nxp}/ls1088a/eth_ls1088aqds.c  |  0
 board/{freescale => nxp}/ls1088a/eth_ls1088ardb.c  |  0
 board/{freescale => nxp}/ls1088a/ls1088a.c         |  0
 board/{freescale => nxp}/ls1088a/ls1088a_qixis.h   |  0
 board/{freescale => nxp}/ls2080aqds/Kconfig        |  2 +-
 board/{freescale => nxp}/ls2080aqds/MAINTAINERS    |  4 +--
 board/{freescale => nxp}/ls2080aqds/Makefile       |  0
 board/{freescale => nxp}/ls2080aqds/README         |  0
 board/{freescale => nxp}/ls2080aqds/ddr.c          |  0
 board/{freescale => nxp}/ls2080aqds/ddr.h          |  0
 board/{freescale => nxp}/ls2080aqds/eth.c          |  0
 board/{freescale => nxp}/ls2080aqds/ls2080aqds.c   |  0
 .../ls2080aqds/ls2080aqds_qixis.h                  |  0
 board/{freescale => nxp}/ls2080ardb/Kconfig        |  2 +-
 board/{freescale => nxp}/ls2080ardb/MAINTAINERS    |  4 +--
 board/{freescale => nxp}/ls2080ardb/Makefile       |  0
 board/{freescale => nxp}/ls2080ardb/README         |  0
 board/{freescale => nxp}/ls2080ardb/ddr.c          |  0
 board/{freescale => nxp}/ls2080ardb/ddr.h          |  0
 .../{freescale => nxp}/ls2080ardb/eth_ls2080rdb.c  |  0
 board/{freescale => nxp}/ls2080ardb/ls2080ardb.c   |  0
 .../ls2080ardb/ls2080ardb_qixis.h                  |  0
 board/{freescale => nxp}/lx2160a/Kconfig           |  6 ++--
 board/{freescale => nxp}/lx2160a/MAINTAINERS       |  6 ++--
 board/{freescale => nxp}/lx2160a/Makefile          |  0
 board/{freescale => nxp}/lx2160a/README            |  0
 board/{freescale => nxp}/lx2160a/ddr.c             |  0
 board/{freescale => nxp}/lx2160a/eth_lx2160aqds.c  |  0
 board/{freescale => nxp}/lx2160a/eth_lx2160ardb.c  |  0
 board/{freescale => nxp}/lx2160a/eth_lx2162aqds.c  |  0
 board/{freescale => nxp}/lx2160a/lx2160a.c         |  0
 board/{freescale => nxp}/lx2160a/lx2160a.h         |  0
 board/{freescale => nxp}/m5208evbe/Kconfig         |  2 +-
 board/{freescale => nxp}/m5208evbe/MAINTAINERS     |  2 +-
 board/{freescale => nxp}/m5208evbe/Makefile        |  0
 board/{freescale => nxp}/m5208evbe/m5208evbe.c     |  0
 board/{freescale => nxp}/m5235evb/Kconfig          |  2 +-
 board/{freescale => nxp}/m5235evb/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/m5235evb/Makefile         |  0
 board/{freescale => nxp}/m5235evb/m5235evb.c       |  0
 board/{freescale => nxp}/m5249evb/Kconfig          |  2 +-
 board/{freescale => nxp}/m5249evb/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/m5249evb/Makefile         |  0
 board/{freescale => nxp}/m5249evb/m5249evb.c       |  0
 board/{freescale => nxp}/m5253demo/Kconfig         |  2 +-
 board/{freescale => nxp}/m5253demo/MAINTAINERS     |  2 +-
 board/{freescale => nxp}/m5253demo/Makefile        |  0
 board/{freescale => nxp}/m5253demo/flash.c         |  0
 board/{freescale => nxp}/m5253demo/m5253demo.c     |  0
 board/{freescale => nxp}/m5272c3/Kconfig           |  2 +-
 board/{freescale => nxp}/m5272c3/MAINTAINERS       |  2 +-
 board/{freescale => nxp}/m5272c3/Makefile          |  0
 board/{freescale => nxp}/m5272c3/m5272c3.c         |  0
 board/{freescale => nxp}/m5275evb/Kconfig          |  2 +-
 board/{freescale => nxp}/m5275evb/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/m5275evb/Makefile         |  0
 board/{freescale => nxp}/m5275evb/m5275evb.c       |  0
 board/{freescale => nxp}/m5282evb/Kconfig          |  2 +-
 board/{freescale => nxp}/m5282evb/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/m5282evb/Makefile         |  0
 board/{freescale => nxp}/m5282evb/m5282evb.c       |  0
 board/{freescale => nxp}/m53017evb/Kconfig         |  2 +-
 board/{freescale => nxp}/m53017evb/MAINTAINERS     |  2 +-
 board/{freescale => nxp}/m53017evb/Makefile        |  0
 board/{freescale => nxp}/m53017evb/README          | 12 ++++----
 board/{freescale => nxp}/m53017evb/m53017evb.c     |  0
 board/{freescale => nxp}/m5329evb/Kconfig          |  2 +-
 board/{freescale => nxp}/m5329evb/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/m5329evb/Makefile         |  0
 board/{freescale => nxp}/m5329evb/m5329evb.c       |  0
 board/{freescale => nxp}/m5329evb/nand.c           |  0
 board/{freescale => nxp}/m5373evb/Kconfig          |  2 +-
 board/{freescale => nxp}/m5373evb/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/m5373evb/Makefile         |  0
 board/{freescale => nxp}/m5373evb/README           | 12 ++++----
 board/{freescale => nxp}/m5373evb/m5373evb.c       |  0
 board/{freescale => nxp}/m5373evb/nand.c           |  0
 board/{freescale => nxp}/mpc837xerdb/Kconfig       |  2 +-
 board/{freescale => nxp}/mpc837xerdb/MAINTAINERS   |  2 +-
 board/{freescale => nxp}/mpc837xerdb/Makefile      |  0
 board/{freescale => nxp}/mpc837xerdb/README        |  0
 board/{freescale => nxp}/mpc837xerdb/mpc837xerdb.c |  0
 board/{freescale => nxp}/mpc8548cds/Kconfig        |  2 +-
 board/{freescale => nxp}/mpc8548cds/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/mpc8548cds/Makefile       |  0
 board/{freescale => nxp}/mpc8548cds/ddr.c          |  0
 board/{freescale => nxp}/mpc8548cds/law.c          |  0
 board/{freescale => nxp}/mpc8548cds/mpc8548cds.c   |  0
 board/{freescale => nxp}/mpc8548cds/tlb.c          |  0
 board/{freescale => nxp}/mx23evk/Kconfig           |  2 +-
 board/{freescale => nxp}/mx23evk/MAINTAINERS       |  2 +-
 board/{freescale => nxp}/mx23evk/Makefile          |  0
 board/{freescale => nxp}/mx23evk/mx23evk.c         |  0
 board/{freescale => nxp}/mx23evk/spl_boot.c        |  0
 board/{freescale => nxp}/mx28evk/Kconfig           |  2 +-
 board/{freescale => nxp}/mx28evk/MAINTAINERS       |  2 +-
 board/{freescale => nxp}/mx28evk/Makefile          |  0
 board/{freescale => nxp}/mx28evk/README            |  2 +-
 board/{freescale => nxp}/mx28evk/iomux.c           |  0
 board/{freescale => nxp}/mx28evk/mx28evk.c         |  0
 board/{freescale => nxp}/mx51evk/Kconfig           |  4 +--
 board/{freescale => nxp}/mx51evk/MAINTAINERS       |  2 +-
 board/{freescale => nxp}/mx51evk/Makefile          |  0
 board/{freescale => nxp}/mx51evk/imximage.cfg      |  0
 board/{freescale => nxp}/mx51evk/mx51evk.c         |  0
 board/{freescale => nxp}/mx53loco/Kconfig          |  4 +--
 board/{freescale => nxp}/mx53loco/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/mx53loco/Makefile         |  0
 board/{freescale => nxp}/mx53loco/imximage.cfg     |  0
 board/{freescale => nxp}/mx53loco/mx53loco.c       |  0
 board/{freescale => nxp}/mx6memcal/Kconfig         |  2 +-
 board/{freescale => nxp}/mx6memcal/MAINTAINERS     |  2 +-
 board/{freescale => nxp}/mx6memcal/Makefile        |  0
 board/{freescale => nxp}/mx6memcal/README          |  0
 board/{freescale => nxp}/mx6memcal/mx6memcal.c     |  0
 board/{freescale => nxp}/mx6memcal/spl.c           |  0
 board/{freescale => nxp}/mx6sabreauto/Kconfig      |  2 +-
 board/{freescale => nxp}/mx6sabreauto/MAINTAINERS  |  2 +-
 board/{freescale => nxp}/mx6sabreauto/Makefile     |  0
 .../{freescale => nxp}/mx6sabreauto/mx6sabreauto.c |  0
 board/{freescale => nxp}/mx6sabresd/Kconfig        |  2 +-
 board/{freescale => nxp}/mx6sabresd/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/mx6sabresd/Makefile       |  0
 board/{freescale => nxp}/mx6sabresd/mx6sabresd.c   |  0
 board/{freescale => nxp}/mx6slevk/Kconfig          |  4 +--
 board/{freescale => nxp}/mx6slevk/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/mx6slevk/Makefile         |  0
 board/{freescale => nxp}/mx6slevk/imximage.cfg     |  0
 board/{freescale => nxp}/mx6slevk/mx6slevk.c       |  0
 board/{freescale => nxp}/mx6sllevk/Kconfig         |  4 +--
 board/{freescale => nxp}/mx6sllevk/MAINTAINERS     |  2 +-
 board/{freescale => nxp}/mx6sllevk/Makefile        |  0
 board/{freescale => nxp}/mx6sllevk/imximage.cfg    |  2 +-
 board/{freescale => nxp}/mx6sllevk/mx6sllevk.c     |  0
 board/{freescale => nxp}/mx6sllevk/plugin.S        |  0
 board/{freescale => nxp}/mx6sxsabreauto/Kconfig    |  4 +--
 .../{freescale => nxp}/mx6sxsabreauto/MAINTAINERS  |  2 +-
 board/{freescale => nxp}/mx6sxsabreauto/Makefile   |  0
 .../{freescale => nxp}/mx6sxsabreauto/imximage.cfg |  0
 .../mx6sxsabreauto/mx6sxsabreauto.c                |  0
 board/{freescale => nxp}/mx6sxsabresd/Kconfig      |  4 +--
 board/{freescale => nxp}/mx6sxsabresd/MAINTAINERS  |  2 +-
 board/{freescale => nxp}/mx6sxsabresd/Makefile     |  0
 board/{freescale => nxp}/mx6sxsabresd/imximage.cfg |  0
 .../{freescale => nxp}/mx6sxsabresd/mx6sxsabresd.c |  0
 board/{freescale => nxp}/mx6ul_14x14_evk/Kconfig   |  2 +-
 .../{freescale => nxp}/mx6ul_14x14_evk/MAINTAINERS |  2 +-
 board/{freescale => nxp}/mx6ul_14x14_evk/Makefile  |  0
 .../mx6ul_14x14_evk/mx6ul_14x14_evk.c              |  0
 board/{freescale => nxp}/mx6ullevk/Kconfig         |  4 +--
 board/{freescale => nxp}/mx6ullevk/MAINTAINERS     |  2 +-
 board/{freescale => nxp}/mx6ullevk/Makefile        |  0
 board/{freescale => nxp}/mx6ullevk/imximage.cfg    |  2 +-
 board/{freescale => nxp}/mx6ullevk/mx6ullevk.c     |  0
 board/{freescale => nxp}/mx6ullevk/plugin.S        |  0
 board/{freescale => nxp}/mx7dsabresd/Kconfig       |  4 +--
 board/{freescale => nxp}/mx7dsabresd/MAINTAINERS   |  2 +-
 board/{freescale => nxp}/mx7dsabresd/Makefile      |  0
 board/{freescale => nxp}/mx7dsabresd/imximage.cfg  |  0
 board/{freescale => nxp}/mx7dsabresd/mx7dsabresd.c |  0
 board/{freescale => nxp}/mx7ulp_evk/Kconfig        |  4 +--
 board/{freescale => nxp}/mx7ulp_evk/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/mx7ulp_evk/Makefile       |  0
 board/{freescale => nxp}/mx7ulp_evk/imximage.cfg   |  2 +-
 board/{freescale => nxp}/mx7ulp_evk/mx7ulp_evk.c   |  0
 board/{freescale => nxp}/mx7ulp_evk/plugin.S       |  0
 board/{freescale => nxp}/p1010rdb/Kconfig          |  2 +-
 board/{freescale => nxp}/p1010rdb/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/p1010rdb/Makefile         |  0
 .../{freescale => nxp}/p1010rdb/README.P1010RDB-PA |  0
 .../{freescale => nxp}/p1010rdb/README.P1010RDB-PB |  0
 board/{freescale => nxp}/p1010rdb/ddr.c            |  0
 board/{freescale => nxp}/p1010rdb/law.c            |  0
 board/{freescale => nxp}/p1010rdb/p1010rdb.c       |  0
 board/{freescale => nxp}/p1010rdb/spl.c            |  0
 board/{freescale => nxp}/p1010rdb/spl_minimal.c    |  0
 board/{freescale => nxp}/p1010rdb/tlb.c            |  0
 board/{freescale => nxp}/p1_p2_rdb_pc/Kconfig      |  2 +-
 board/{freescale => nxp}/p1_p2_rdb_pc/MAINTAINERS  |  2 +-
 board/{freescale => nxp}/p1_p2_rdb_pc/Makefile     |  0
 board/{freescale => nxp}/p1_p2_rdb_pc/README       |  0
 board/{freescale => nxp}/p1_p2_rdb_pc/ddr.c        |  0
 board/{freescale => nxp}/p1_p2_rdb_pc/law.c        |  0
 .../{freescale => nxp}/p1_p2_rdb_pc/p1_p2_rdb_pc.c |  0
 board/{freescale => nxp}/p1_p2_rdb_pc/spl.c        |  0
 .../{freescale => nxp}/p1_p2_rdb_pc/spl_minimal.c  |  0
 board/{freescale => nxp}/p1_p2_rdb_pc/tlb.c        |  0
 board/{freescale => nxp}/p2041rdb/Kconfig          |  2 +-
 board/{freescale => nxp}/p2041rdb/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/p2041rdb/Makefile         |  0
 board/{freescale => nxp}/p2041rdb/README           |  0
 board/{freescale => nxp}/p2041rdb/cpld.c           |  0
 board/{freescale => nxp}/p2041rdb/cpld.h           |  0
 board/{freescale => nxp}/p2041rdb/ddr.c            |  0
 board/{freescale => nxp}/p2041rdb/eth.c            |  0
 board/{freescale => nxp}/p2041rdb/p2041rdb.c       |  0
 board/{freescale => nxp}/p2041rdb/pbi.cfg          |  0
 board/{freescale => nxp}/p2041rdb/rcw_p2041rdb.cfg |  0
 board/{freescale => nxp}/t102xrdb/Kconfig          |  2 +-
 board/{freescale => nxp}/t102xrdb/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/t102xrdb/Makefile         |  0
 board/{freescale => nxp}/t102xrdb/README           |  0
 board/{freescale => nxp}/t102xrdb/cpld.c           |  0
 board/{freescale => nxp}/t102xrdb/cpld.h           |  0
 board/{freescale => nxp}/t102xrdb/ddr.c            |  0
 board/{freescale => nxp}/t102xrdb/eth_t102xrdb.c   |  0
 board/{freescale => nxp}/t102xrdb/law.c            |  0
 board/{freescale => nxp}/t102xrdb/spl.c            |  0
 .../{freescale => nxp}/t102xrdb/t1023_nand_rcw.cfg |  0
 board/{freescale => nxp}/t102xrdb/t1023_sd_rcw.cfg |  0
 .../{freescale => nxp}/t102xrdb/t1023_spi_rcw.cfg  |  0
 .../{freescale => nxp}/t102xrdb/t1024_nand_rcw.cfg |  0
 board/{freescale => nxp}/t102xrdb/t1024_pbi.cfg    |  0
 board/{freescale => nxp}/t102xrdb/t1024_sd_rcw.cfg |  0
 .../{freescale => nxp}/t102xrdb/t1024_spi_rcw.cfg  |  0
 board/{freescale => nxp}/t102xrdb/t102xrdb.c       |  0
 board/{freescale => nxp}/t102xrdb/t102xrdb.h       |  0
 board/{freescale => nxp}/t102xrdb/tlb.c            |  0
 board/{freescale => nxp}/t104xrdb/Kconfig          |  2 +-
 board/{freescale => nxp}/t104xrdb/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/t104xrdb/Makefile         |  0
 board/{freescale => nxp}/t104xrdb/README           |  4 +--
 board/{freescale => nxp}/t104xrdb/cpld.c           |  0
 board/{freescale => nxp}/t104xrdb/cpld.h           |  0
 board/{freescale => nxp}/t104xrdb/ddr.c            |  0
 board/{freescale => nxp}/t104xrdb/ddr.h            |  0
 board/{freescale => nxp}/t104xrdb/eth.c            |  0
 board/{freescale => nxp}/t104xrdb/law.c            |  0
 board/{freescale => nxp}/t104xrdb/spl.c            |  0
 .../{freescale => nxp}/t104xrdb/t1040_nand_rcw.cfg |  0
 board/{freescale => nxp}/t104xrdb/t1040_sd_rcw.cfg |  0
 .../{freescale => nxp}/t104xrdb/t1040_spi_rcw.cfg  |  0
 .../t104xrdb/t1040d4_nand_rcw.cfg                  |  0
 .../{freescale => nxp}/t104xrdb/t1040d4_sd_rcw.cfg |  0
 .../t104xrdb/t1040d4_spi_rcw.cfg                   |  0
 .../{freescale => nxp}/t104xrdb/t1042_nand_rcw.cfg |  0
 .../t104xrdb/t1042_pi_nand_rcw.cfg                 |  0
 .../t104xrdb/t1042_pi_sd_rcw.cfg                   |  0
 .../t104xrdb/t1042_pi_spi_rcw.cfg                  |  0
 board/{freescale => nxp}/t104xrdb/t1042_sd_rcw.cfg |  0
 .../{freescale => nxp}/t104xrdb/t1042_spi_rcw.cfg  |  0
 .../t104xrdb/t1042d4_nand_rcw.cfg                  |  0
 .../{freescale => nxp}/t104xrdb/t1042d4_sd_rcw.cfg |  0
 .../t104xrdb/t1042d4_spi_rcw.cfg                   |  0
 board/{freescale => nxp}/t104xrdb/t104x_pbi.cfg    |  0
 board/{freescale => nxp}/t104xrdb/t104x_pbi_sb.cfg |  0
 board/{freescale => nxp}/t104xrdb/t104xrdb.c       |  0
 board/{freescale => nxp}/t104xrdb/t104xrdb.h       |  0
 board/{freescale => nxp}/t104xrdb/tlb.c            |  0
 board/{freescale => nxp}/t208xqds/Kconfig          |  2 +-
 board/{freescale => nxp}/t208xqds/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/t208xqds/Makefile         |  0
 board/{freescale => nxp}/t208xqds/README           |  0
 board/{freescale => nxp}/t208xqds/ddr.c            |  0
 board/{freescale => nxp}/t208xqds/ddr.h            |  0
 board/{freescale => nxp}/t208xqds/eth_t208xqds.c   |  0
 board/{freescale => nxp}/t208xqds/law.c            |  0
 board/{freescale => nxp}/t208xqds/spl.c            |  0
 .../{freescale => nxp}/t208xqds/t2080_nand_rcw.cfg |  0
 board/{freescale => nxp}/t208xqds/t2080_sd_rcw.cfg |  0
 .../{freescale => nxp}/t208xqds/t2080_spi_rcw.cfg  |  0
 .../{freescale => nxp}/t208xqds/t2081_nand_rcw.cfg |  0
 board/{freescale => nxp}/t208xqds/t2081_sd_rcw.cfg |  0
 .../{freescale => nxp}/t208xqds/t2081_spi_rcw.cfg  |  0
 board/{freescale => nxp}/t208xqds/t208x_pbi.cfg    |  0
 board/{freescale => nxp}/t208xqds/t208xqds.c       |  0
 board/{freescale => nxp}/t208xqds/t208xqds.h       |  0
 board/{freescale => nxp}/t208xqds/t208xqds_qixis.h |  0
 board/{freescale => nxp}/t208xqds/tlb.c            |  0
 board/{freescale => nxp}/t208xrdb/Kconfig          |  2 +-
 board/{freescale => nxp}/t208xrdb/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/t208xrdb/Makefile         |  0
 board/{freescale => nxp}/t208xrdb/README           |  0
 board/{freescale => nxp}/t208xrdb/cpld.c           |  0
 board/{freescale => nxp}/t208xrdb/cpld.h           |  0
 board/{freescale => nxp}/t208xrdb/ddr.c            |  0
 board/{freescale => nxp}/t208xrdb/ddr.h            |  0
 board/{freescale => nxp}/t208xrdb/eth_t208xrdb.c   |  0
 board/{freescale => nxp}/t208xrdb/law.c            |  0
 board/{freescale => nxp}/t208xrdb/spl.c            |  0
 .../{freescale => nxp}/t208xrdb/t2080_nand_rcw.cfg |  0
 board/{freescale => nxp}/t208xrdb/t2080_pbi.cfg    |  0
 board/{freescale => nxp}/t208xrdb/t2080_sd_rcw.cfg |  0
 .../{freescale => nxp}/t208xrdb/t2080_spi_rcw.cfg  |  0
 board/{freescale => nxp}/t208xrdb/t208xrdb.c       |  0
 board/{freescale => nxp}/t208xrdb/t208xrdb.h       |  0
 board/{freescale => nxp}/t208xrdb/tlb.c            |  0
 board/{freescale => nxp}/t4rdb/Kconfig             |  2 +-
 board/{freescale => nxp}/t4rdb/MAINTAINERS         |  2 +-
 board/{freescale => nxp}/t4rdb/Makefile            |  0
 board/{freescale => nxp}/t4rdb/cpld.c              |  0
 board/{freescale => nxp}/t4rdb/cpld.h              |  0
 board/{freescale => nxp}/t4rdb/ddr.c               |  0
 board/{freescale => nxp}/t4rdb/ddr.h               |  0
 board/{freescale => nxp}/t4rdb/eth.c               |  0
 board/{freescale => nxp}/t4rdb/law.c               |  0
 board/{freescale => nxp}/t4rdb/spl.c               |  0
 board/{freescale => nxp}/t4rdb/t4240rdb.c          |  0
 board/{freescale => nxp}/t4rdb/t4_pbi.cfg          |  0
 board/{freescale => nxp}/t4rdb/t4_sd_rcw.cfg       |  0
 board/{freescale => nxp}/t4rdb/t4rdb.h             |  0
 board/{freescale => nxp}/t4rdb/tlb.c               |  0
 board/{freescale => nxp}/vf610twr/Kconfig          |  4 +--
 board/{freescale => nxp}/vf610twr/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/vf610twr/Makefile         |  0
 board/{freescale => nxp}/vf610twr/imximage.cfg     |  0
 board/{freescale => nxp}/vf610twr/vf610twr.c       |  0
 .../sifive/unmatched/hifive-platform-i2c-eeprom.c  |  2 +-
 board/technexion/pico-imx6ul/pico-imx6ul.c         |  2 +-
 board/technexion/pico-imx7d/Makefile               |  2 +-
 board/technexion/pico-imx7d/pico-imx7d.c           |  2 +-
 board/warp7/warp7.c                                |  2 +-
 configs/P2041RDB_NAND_defconfig                    |  4 +--
 configs/P2041RDB_SDCARD_defconfig                  |  4 +--
 configs/P2041RDB_SPIFLASH_defconfig                |  4 +--
 configs/T1024RDB_NAND_defconfig                    |  4 +--
 configs/T1024RDB_SDCARD_defconfig                  |  4 +--
 configs/T1024RDB_SPIFLASH_defconfig                |  4 +--
 configs/T1042D4RDB_NAND_defconfig                  |  4 +--
 configs/T1042D4RDB_SDCARD_defconfig                |  4 +--
 configs/T1042D4RDB_SPIFLASH_defconfig              |  4 +--
 configs/T2080QDS_NAND_defconfig                    |  4 +--
 configs/T2080QDS_SDCARD_defconfig                  |  4 +--
 configs/T2080QDS_SPIFLASH_defconfig                |  4 +--
 configs/T2080RDB_NAND_defconfig                    |  4 +--
 configs/T2080RDB_SDCARD_defconfig                  |  4 +--
 configs/T2080RDB_SPIFLASH_defconfig                |  4 +--
 configs/T2080RDB_revD_NAND_defconfig               |  4 +--
 configs/T2080RDB_revD_SDCARD_defconfig             |  4 +--
 configs/T2080RDB_revD_SPIFLASH_defconfig           |  4 +--
 configs/T4240RDB_SDCARD_defconfig                  |  4 +--
 configs/imx8mm_beacon_fspi_defconfig               |  2 +-
 configs/imx8mm_evk_fspi_defconfig                  |  2 +-
 configs/imx8qm_mek_defconfig                       |  2 +-
 configs/imx8qxp_mek_defconfig                      |  2 +-
 configs/imxrt1050-evk_fspi_defconfig               |  2 +-
 configs/ls1021aiot_sdcard_defconfig                |  5 ++--
 configs/ls1021aqds_nand_defconfig                  |  4 +--
 configs/ls1021aqds_sdcard_ifc_defconfig            |  4 +--
 configs/ls1021aqds_sdcard_qspi_defconfig           |  4 +--
 configs/ls1021atsn_sdcard_defconfig                |  4 +--
 .../ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig    |  4 +--
 configs/ls1021atwr_sdcard_ifc_defconfig            |  4 +--
 configs/ls1021atwr_sdcard_qspi_defconfig           |  4 +--
 doc/README.pblimage                                |  2 +-
 doc/imx/mkimage/imximage.txt                       |  2 +-
 drivers/firmware/scmi/sandbox-scmi_agent.c         |  4 +--
 drivers/misc/Kconfig                               |  7 ++++-
 drivers/mmc/fsl_esdhc.c                            |  2 +-
 include/configs/ls1021aiot.h                       | 34 ++++++++++++++++++++++
 691 files changed, 401 insertions(+), 356 deletions(-)
 rename board/{freescale => nxp}/common/Makefile (100%)
 rename board/{freescale => nxp}/common/arm_sleep.c (100%)
 rename board/{freescale => nxp}/common/cadmus.c (100%)
 rename board/{freescale => nxp}/common/cadmus.h (100%)
 rename board/{freescale => nxp}/common/cds_pci_ft.c (100%)
 rename board/{freescale => nxp}/common/cds_via.c (100%)
 rename board/{freescale => nxp}/common/cmd_esbc_validate.c (100%)
 rename board/{freescale => nxp}/common/eeprom.h (100%)
 rename board/{freescale => nxp}/common/emc2305.c (100%)
 rename board/{freescale => nxp}/common/emc2305.h (100%)
 rename board/{freescale => nxp}/common/fman.c (100%)
 rename board/{freescale => nxp}/common/fman.h (100%)
 rename board/{freescale => nxp}/common/fsl_chain_of_trust.c (100%)
 rename board/{freescale => nxp}/common/fsl_validate.c (100%)
 rename board/{freescale => nxp}/common/i2c_common.c (100%)
 rename board/{freescale => nxp}/common/i2c_common.h (100%)
 rename board/{freescale => nxp}/common/i2c_mux.c (100%)
 rename board/{freescale => nxp}/common/i2c_mux.h (100%)
 rename board/{freescale => nxp}/common/ics307_clk.c (100%)
 rename board/{freescale => nxp}/common/ics307_clk.h (100%)
 rename board/{freescale => nxp}/common/ls102xa_stream_id.c (100%)
 rename board/{freescale => nxp}/common/mc34vr500.c (100%)
 rename board/{freescale => nxp}/common/mmc.c (100%)
 rename board/{freescale => nxp}/common/mpc85xx_sleep.c (100%)
 rename board/{freescale => nxp}/common/ngpixis.c (100%)
 rename board/{freescale => nxp}/common/ngpixis.h (100%)
 rename board/{freescale => nxp}/common/ns_access.c (100%)
 rename board/{freescale => nxp}/common/p_corenet/Makefile (100%)
 rename board/{freescale => nxp}/common/p_corenet/law.c (100%)
 rename board/{freescale => nxp}/common/p_corenet/tlb.c (100%)
 rename board/{freescale => nxp}/common/pfuze.c (100%)
 rename board/{freescale => nxp}/common/pfuze.h (100%)
 rename board/{freescale => nxp}/common/qixis.c (100%)
 rename board/{freescale => nxp}/common/qixis.h (100%)
 rename board/{freescale => nxp}/common/sdhc_boot.c (100%)
 rename board/{freescale => nxp}/common/sgmii_riser.h (100%)
 rename board/{freescale => nxp}/common/sleep.h (100%)
 rename board/{freescale => nxp}/common/spl.h (100%)
 rename board/{freescale => nxp}/common/sys_eeprom.c (100%)
 rename board/{freescale => nxp}/common/via.h (100%)
 rename board/{freescale => nxp}/common/vid.c (100%)
 rename board/{freescale => nxp}/common/vid.h (100%)
 rename board/{freescale => nxp}/common/vsc3316_3308.h (100%)
 rename board/{freescale => nxp}/imx8mm_evk/Kconfig (64%)
 rename board/{freescale => nxp}/imx8mm_evk/MAINTAINERS (84%)
 rename board/{freescale => nxp}/imx8mm_evk/Makefile (100%)
 rename board/{freescale => nxp}/imx8mm_evk/imx8mm_evk.c (100%)
 rename board/{freescale => nxp}/imx8mm_evk/imx8mm_evk.env (100%)
 rename board/{freescale => nxp}/imx8mm_evk/imximage-8mm-lpddr4-fspi.cfg (100%)
 rename board/{freescale => nxp}/imx8mm_evk/imximage-8mm-lpddr4.cfg (100%)
 rename board/{freescale => nxp}/imx8mm_evk/lpddr4_timing.c (100%)
 rename board/{freescale => nxp}/imx8mm_evk/spl.c (100%)
 rename board/{freescale => nxp}/imx8mn_evk/Kconfig (76%)
 rename board/{freescale => nxp}/imx8mn_evk/MAINTAINERS (84%)
 rename board/{freescale => nxp}/imx8mn_evk/Makefile (100%)
 rename board/{freescale => nxp}/imx8mn_evk/ddr4_timing.c (100%)
 rename board/{freescale => nxp}/imx8mn_evk/ddr4_timing_ld.c (100%)
 rename board/{freescale => nxp}/imx8mn_evk/imx8mn_evk.c (100%)
 rename board/{freescale => nxp}/imx8mn_evk/imx8mn_evk.env (100%)
 rename board/{freescale => nxp}/imx8mn_evk/imximage-8mn-ddr4.cfg (100%)
 rename board/{freescale => nxp}/imx8mn_evk/lpddr4_timing.c (100%)
 rename board/{freescale => nxp}/imx8mn_evk/lpddr4_timing_ld.c (100%)
 rename board/{freescale => nxp}/imx8mn_evk/spl.c (100%)
 rename board/{freescale => nxp}/imx8mp_evk/Kconfig (64%)
 rename board/{freescale => nxp}/imx8mp_evk/MAINTAINERS (84%)
 rename board/{freescale => nxp}/imx8mp_evk/Makefile (100%)
 rename board/{freescale => nxp}/imx8mp_evk/imx8mp_evk.c (100%)
 rename board/{freescale => nxp}/imx8mp_evk/imx8mp_evk.env (100%)
 rename board/{freescale => nxp}/imx8mp_evk/imximage-8mp-lpddr4.cfg (100%)
 rename board/{freescale => nxp}/imx8mp_evk/lpddr4_timing.c (100%)
 rename board/{freescale => nxp}/imx8mp_evk/spl.c (100%)
 rename board/{freescale => nxp}/imx8mq_evk/Kconfig (90%)
 rename board/{freescale => nxp}/imx8mq_evk/MAINTAINERS (84%)
 rename board/{freescale => nxp}/imx8mq_evk/Makefile (100%)
 rename board/{freescale => nxp}/imx8mq_evk/imx8mq_evk.c (100%)
 rename board/{freescale => nxp}/imx8mq_evk/imx8mq_evk.env (100%)
 rename board/{freescale => nxp}/imx8mq_evk/lpddr4_timing.c (100%)
 rename board/{freescale => nxp}/imx8mq_evk/lpddr4_timing_b0.c (100%)
 rename board/{freescale => nxp}/imx8mq_evk/spl.c (100%)
 rename board/{freescale => nxp}/imx8qm_mek/Kconfig (67%)
 rename board/{freescale => nxp}/imx8qm_mek/MAINTAINERS (80%)
 rename board/{freescale => nxp}/imx8qm_mek/Makefile (100%)
 rename board/{freescale => nxp}/imx8qm_mek/README (100%)
 rename board/{freescale => nxp}/imx8qm_mek/imx8qm_mek.c (100%)
 rename board/{freescale => nxp}/imx8qm_mek/imximage.cfg (100%)
 rename board/{freescale => nxp}/imx8qm_mek/spl.c (100%)
 rename board/{freescale => nxp}/imx8qm_mek/uboot-container.cfg (100%)
 rename board/{freescale => nxp}/imx8qxp_mek/Kconfig (67%)
 rename board/{freescale => nxp}/imx8qxp_mek/MAINTAINERS (84%)
 rename board/{freescale => nxp}/imx8qxp_mek/Makefile (100%)
 rename board/{freescale => nxp}/imx8qxp_mek/imx8qxp_mek.c (100%)
 rename board/{freescale => nxp}/imx8qxp_mek/imximage.cfg (100%)
 rename board/{freescale => nxp}/imx8qxp_mek/spl.c (100%)
 rename board/{freescale => nxp}/imx8qxp_mek/uboot-container.cfg (100%)
 rename board/{freescale => nxp}/imx8ulp_evk/Kconfig (86%)
 rename board/{freescale => nxp}/imx8ulp_evk/MAINTAINERS (80%)
 rename board/{freescale => nxp}/imx8ulp_evk/Makefile (100%)
 rename board/{freescale => nxp}/imx8ulp_evk/imx8ulp_evk.c (100%)
 rename board/{freescale => nxp}/imx8ulp_evk/imx8ulp_evk.env (100%)
 rename board/{freescale => nxp}/imx8ulp_evk/lpddr4_timing.c (100%)
 rename board/{freescale => nxp}/imx8ulp_evk/lpddr4_timing_266.c (100%)
 rename board/{freescale => nxp}/imx8ulp_evk/spl.c (100%)
 rename board/{freescale => nxp}/imx91_evk/Kconfig (93%)
 rename board/{freescale => nxp}/imx91_evk/MAINTAINERS (85%)
 rename board/{freescale => nxp}/imx91_evk/Makefile (100%)
 rename board/{freescale => nxp}/imx91_evk/imx91_evk.c (100%)
 rename board/{freescale => nxp}/imx91_evk/imx91_evk.env (100%)
 rename board/{freescale => nxp}/imx91_evk/lpddr4_timing_1600mts.c (100%)
 rename board/{freescale => nxp}/imx91_evk/lpddr4_timing_1600mts_ecc.c (100%)
 rename board/{freescale => nxp}/imx91_evk/lpddr4_timing_2400mts.c (100%)
 rename board/{freescale => nxp}/imx91_evk/lpddr4_timing_2400mts_ecc.c (100%)
 rename board/{freescale => nxp}/imx91_evk/spl.c (100%)
 rename board/{freescale => nxp}/imx91_frdm/Kconfig (86%)
 rename board/{freescale => nxp}/imx91_frdm/MAINTAINERS (85%)
 rename board/{freescale => nxp}/imx91_frdm/Makefile (100%)
 rename board/{freescale => nxp}/imx91_frdm/imx91_frdm.c (100%)
 rename board/{freescale => nxp}/imx91_frdm/imx91_frdm.env (100%)
 rename board/{freescale => nxp}/imx91_frdm/lpddr4_2400mts_1gb_timing.c (100%)
 rename board/{freescale => nxp}/imx91_frdm/lpddr4_2400mts_2gb_timing.c (100%)
 rename board/{freescale => nxp}/imx91_frdm/lpddr4_2400mts_ecc_1gb_timing.c (100%)
 rename board/{freescale => nxp}/imx91_frdm/lpddr4_2400mts_ecc_2gb_timing.c (100%)
 rename board/{freescale => nxp}/imx91_frdm/lpddr4_timing.h (100%)
 rename board/{freescale => nxp}/imx91_frdm/spl.c (100%)
 rename board/{freescale => nxp}/imx93_evk/Kconfig (93%)
 rename board/{freescale => nxp}/imx93_evk/MAINTAINERS (85%)
 rename board/{freescale => nxp}/imx93_evk/Makefile (100%)
 rename board/{freescale => nxp}/imx93_evk/imx93_evk.c (100%)
 rename board/{freescale => nxp}/imx93_evk/imx93_evk.env (100%)
 rename board/{freescale => nxp}/imx93_evk/lpddr4x_timing.c (100%)
 rename board/{freescale => nxp}/imx93_evk/lpddr4x_timing_1866mts.c (100%)
 rename board/{freescale => nxp}/imx93_evk/spl.c (100%)
 rename board/{freescale => nxp}/imx93_frdm/Kconfig (86%)
 rename board/{freescale => nxp}/imx93_frdm/MAINTAINERS (81%)
 rename board/{freescale => nxp}/imx93_frdm/Makefile (100%)
 rename board/{freescale => nxp}/imx93_frdm/imx93_frdm.c (100%)
 rename board/{freescale => nxp}/imx93_frdm/imx93_frdm.env (100%)
 rename board/{freescale => nxp}/imx93_frdm/lpddr4_timing.h (100%)
 rename board/{freescale => nxp}/imx93_frdm/lpddr4x_1gb_timing.c (100%)
 rename board/{freescale => nxp}/imx93_frdm/lpddr4x_2gb_timing.c (100%)
 rename board/{freescale => nxp}/imx93_frdm/spl.c (100%)
 rename board/{freescale => nxp}/imx93_qsb/Kconfig (86%)
 rename board/{freescale => nxp}/imx93_qsb/MAINTAINERS (85%)
 rename board/{freescale => nxp}/imx93_qsb/Makefile (100%)
 rename board/{freescale => nxp}/imx93_qsb/imx93_qsb.c (100%)
 rename board/{freescale => nxp}/imx93_qsb/imx93_qsb.env (100%)
 rename board/{freescale => nxp}/imx93_qsb/lpddr4_timing.c (100%)
 rename board/{freescale => nxp}/imx93_qsb/lpddr4_timing_ecc.c (100%)
 rename board/{freescale => nxp}/imx93_qsb/spl.c (100%)
 rename board/{freescale => nxp}/imx94_evk/Kconfig (86%)
 rename board/{freescale => nxp}/imx94_evk/MAINTAINERS (80%)
 rename board/{freescale => nxp}/imx94_evk/Makefile (100%)
 rename board/{freescale => nxp}/imx94_evk/imx94_evk.c (100%)
 rename board/{freescale => nxp}/imx94_evk/imx94_evk.env (100%)
 rename board/{freescale => nxp}/imx94_evk/spl.c (100%)
 rename board/{freescale => nxp}/imx95_evk/Kconfig (88%)
 rename board/{freescale => nxp}/imx95_evk/MAINTAINERS (87%)
 rename board/{freescale => nxp}/imx95_evk/Makefile (100%)
 rename board/{freescale => nxp}/imx95_evk/imx95_evk.c (100%)
 rename board/{freescale => nxp}/imx95_evk/imx95_evk.env (100%)
 rename board/{freescale => nxp}/imx95_evk/spl.c (100%)
 rename board/{freescale => nxp}/imxrt1020-evk/Kconfig (72%)
 rename board/{freescale => nxp}/imxrt1020-evk/MAINTAINERS (83%)
 rename board/{freescale => nxp}/imxrt1020-evk/Makefile (100%)
 rename board/{freescale => nxp}/imxrt1020-evk/imximage.cfg (100%)
 rename board/{freescale => nxp}/imxrt1020-evk/imxrt1020-evk.c (100%)
 rename board/{freescale => nxp}/imxrt1050-evk/Kconfig (72%)
 rename board/{freescale => nxp}/imxrt1050-evk/MAINTAINERS (86%)
 rename board/{freescale => nxp}/imxrt1050-evk/Makefile (100%)
 rename board/{freescale => nxp}/imxrt1050-evk/imximage-nor.cfg (100%)
 rename board/{freescale => nxp}/imxrt1050-evk/imximage.cfg (100%)
 rename board/{freescale => nxp}/imxrt1050-evk/imxrt1050-evk-nor.env (100%)
 rename board/{freescale => nxp}/imxrt1050-evk/imxrt1050-evk.c (100%)
 rename board/{freescale => nxp}/imxrt1050-evk/imxrt1050-evk.env (100%)
 rename board/{freescale => nxp}/imxrt1170-evk/Kconfig (72%)
 rename board/{freescale => nxp}/imxrt1170-evk/MAINTAINERS (86%)
 rename board/{freescale => nxp}/imxrt1170-evk/Makefile (100%)
 rename board/{freescale => nxp}/imxrt1170-evk/imximage.cfg (100%)
 rename board/{freescale => nxp}/imxrt1170-evk/imxrt1170-evk.c (100%)
 rename board/{freescale => nxp}/ls1012afrdm/Kconfig (96%)
 rename board/{freescale => nxp}/ls1012afrdm/MAINTAINERS (87%)
 rename board/{freescale => nxp}/ls1012afrdm/Makefile (100%)
 rename board/{freescale => nxp}/ls1012afrdm/README (100%)
 rename board/{freescale => nxp}/ls1012afrdm/eth.c (100%)
 rename board/{freescale => nxp}/ls1012afrdm/ls1012afrdm.c (100%)
 rename board/{freescale => nxp}/ls1012aqds/Kconfig (98%)
 rename board/{freescale => nxp}/ls1012aqds/MAINTAINERS (87%)
 rename board/{freescale => nxp}/ls1012aqds/Makefile (100%)
 rename board/{freescale => nxp}/ls1012aqds/README (100%)
 rename board/{freescale => nxp}/ls1012aqds/eth.c (100%)
 rename board/{freescale => nxp}/ls1012aqds/ls1012aqds.c (100%)
 rename board/{freescale => nxp}/ls1012aqds/ls1012aqds_pfe.h (100%)
 rename board/{freescale => nxp}/ls1012aqds/ls1012aqds_qixis.h (100%)
 rename board/{freescale => nxp}/ls1012ardb/Kconfig (97%)
 rename board/{freescale => nxp}/ls1012ardb/MAINTAINERS (87%)
 rename board/{freescale => nxp}/ls1012ardb/Makefile (100%)
 rename board/{freescale => nxp}/ls1012ardb/README (100%)
 rename board/{freescale => nxp}/ls1012ardb/eth.c (100%)
 rename board/{freescale => nxp}/ls1012ardb/ls1012ardb.c (100%)
 rename board/{freescale => nxp}/ls1021aiot/Kconfig (88%)
 rename board/{freescale => nxp}/ls1021aiot/MAINTAINERS (85%)
 rename board/{freescale => nxp}/ls1021aiot/Makefile (100%)
 rename board/{freescale => nxp}/ls1021aiot/README (100%)
 rename board/{freescale => nxp}/ls1021aiot/ls1021aiot.c (98%)
 rename board/{freescale => nxp}/ls1021aiot/ls102xa_pbi.cfg (100%)
 rename board/{freescale => nxp}/ls1021aiot/ls102xa_rcw_sd.cfg (100%)
 rename board/{freescale => nxp}/ls1021aiot/psci.S (100%)
 rename board/{freescale => nxp}/ls1021aqds/Kconfig (88%)
 rename board/{freescale => nxp}/ls1021aqds/MAINTAINERS (93%)
 rename board/{freescale => nxp}/ls1021aqds/Makefile (100%)
 rename board/{freescale => nxp}/ls1021aqds/README (100%)
 rename board/{freescale => nxp}/ls1021aqds/ddr.c (100%)
 rename board/{freescale => nxp}/ls1021aqds/ddr.h (100%)
 rename board/{freescale => nxp}/ls1021aqds/ls1021aqds.c (100%)
 rename board/{freescale => nxp}/ls1021aqds/ls1021aqds_qixis.h (100%)
 rename board/{freescale => nxp}/ls1021aqds/ls102xa_pbi.cfg (100%)
 rename board/{freescale => nxp}/ls1021aqds/ls102xa_rcw_nand.cfg (100%)
 rename board/{freescale => nxp}/ls1021aqds/ls102xa_rcw_sd_ifc.cfg (100%)
 rename board/{freescale => nxp}/ls1021aqds/ls102xa_rcw_sd_qspi.cfg (100%)
 rename board/{freescale => nxp}/ls1021aqds/psci.S (100%)
 rename board/{freescale => nxp}/ls1021atsn/Kconfig (90%)
 rename board/{freescale => nxp}/ls1021atsn/MAINTAINERS (87%)
 rename board/{freescale => nxp}/ls1021atsn/Makefile (100%)
 rename board/{freescale => nxp}/ls1021atsn/README.rst (100%)
 rename board/{freescale => nxp}/ls1021atsn/ls1021atsn.c (100%)
 rename board/{freescale => nxp}/ls1021atsn/ls102xa_pbi.cfg (100%)
 rename board/{freescale => nxp}/ls1021atsn/ls102xa_rcw_sd.cfg (100%)
 rename board/{freescale => nxp}/ls1021atwr/Kconfig (88%)
 rename board/{freescale => nxp}/ls1021atwr/MAINTAINERS (92%)
 rename board/{freescale => nxp}/ls1021atwr/Makefile (100%)
 rename board/{freescale => nxp}/ls1021atwr/README (100%)
 rename board/{freescale => nxp}/ls1021atwr/ls1021atwr.c (100%)
 rename board/{freescale => nxp}/ls1021atwr/ls102xa_pbi.cfg (100%)
 rename board/{freescale => nxp}/ls1021atwr/ls102xa_rcw_sd_ifc.cfg (100%)
 rename board/{freescale => nxp}/ls1021atwr/ls102xa_rcw_sd_qspi.cfg (100%)
 rename board/{freescale => nxp}/ls1021atwr/psci.S (100%)
 rename board/{freescale => nxp}/ls1028a/Kconfig (94%)
 rename board/{freescale => nxp}/ls1028a/MAINTAINERS (92%)
 rename board/{freescale => nxp}/ls1028a/Makefile (100%)
 rename board/{freescale => nxp}/ls1028a/README (100%)
 rename board/{freescale => nxp}/ls1028a/ddr.c (100%)
 rename board/{freescale => nxp}/ls1028a/ls1028a.c (100%)
 rename board/{freescale => nxp}/ls1043aqds/Kconfig (89%)
 rename board/{freescale => nxp}/ls1043aqds/MAINTAINERS (93%)
 rename board/{freescale => nxp}/ls1043aqds/Makefile (100%)
 rename board/{freescale => nxp}/ls1043aqds/README (100%)
 rename board/{freescale => nxp}/ls1043aqds/ddr.c (100%)
 rename board/{freescale => nxp}/ls1043aqds/ddr.h (100%)
 rename board/{freescale => nxp}/ls1043aqds/eth.c (100%)
 rename board/{freescale => nxp}/ls1043aqds/ls1043aqds.c (100%)
 rename board/{freescale => nxp}/ls1043aqds/ls1043aqds_pbi.cfg (100%)
 rename board/{freescale => nxp}/ls1043aqds/ls1043aqds_qixis.h (100%)
 rename board/{freescale => nxp}/ls1043aqds/ls1043aqds_rcw_nand.cfg (100%)
 rename board/{freescale => nxp}/ls1043aqds/ls1043aqds_rcw_sd_ifc.cfg (100%)
 rename board/{freescale => nxp}/ls1043aqds/ls1043aqds_rcw_sd_qspi.cfg (100%)
 rename board/{freescale => nxp}/ls1043ardb/Kconfig (89%)
 rename board/{freescale => nxp}/ls1043ardb/MAINTAINERS (93%)
 rename board/{freescale => nxp}/ls1043ardb/Makefile (100%)
 rename board/{freescale => nxp}/ls1043ardb/README (100%)
 rename board/{freescale => nxp}/ls1043ardb/cpld.c (100%)
 rename board/{freescale => nxp}/ls1043ardb/cpld.h (100%)
 rename board/{freescale => nxp}/ls1043ardb/ddr.c (100%)
 rename board/{freescale => nxp}/ls1043ardb/ddr.h (100%)
 rename board/{freescale => nxp}/ls1043ardb/eth.c (100%)
 rename board/{freescale => nxp}/ls1043ardb/ls1043ardb.c (100%)
 rename board/{freescale => nxp}/ls1043ardb/ls1043ardb_pbi.cfg (100%)
 rename board/{freescale => nxp}/ls1043ardb/ls1043ardb_rcw_nand.cfg (100%)
 rename board/{freescale => nxp}/ls1043ardb/ls1043ardb_rcw_sd.cfg (100%)
 rename board/{freescale => nxp}/ls1046afrwy/Kconfig (89%)
 rename board/{freescale => nxp}/ls1046afrwy/MAINTAINERS (71%)
 rename board/{freescale => nxp}/ls1046afrwy/Makefile (100%)
 rename board/{freescale => nxp}/ls1046afrwy/README (100%)
 rename board/{freescale => nxp}/ls1046afrwy/ddr.c (100%)
 rename board/{freescale => nxp}/ls1046afrwy/eth.c (100%)
 rename board/{freescale => nxp}/ls1046afrwy/ls1046afrwy.c (100%)
 rename board/{freescale => nxp}/ls1046aqds/Kconfig (89%)
 rename board/{freescale => nxp}/ls1046aqds/MAINTAINERS (93%)
 rename board/{freescale => nxp}/ls1046aqds/Makefile (100%)
 rename board/{freescale => nxp}/ls1046aqds/README (100%)
 rename board/{freescale => nxp}/ls1046aqds/ddr.c (100%)
 rename board/{freescale => nxp}/ls1046aqds/ddr.h (100%)
 rename board/{freescale => nxp}/ls1046aqds/eth.c (100%)
 rename board/{freescale => nxp}/ls1046aqds/ls1046aqds.c (100%)
 rename board/{freescale => nxp}/ls1046aqds/ls1046aqds_pbi.cfg (100%)
 rename board/{freescale => nxp}/ls1046aqds/ls1046aqds_qixis.h (100%)
 rename board/{freescale => nxp}/ls1046aqds/ls1046aqds_rcw_nand.cfg (100%)
 rename board/{freescale => nxp}/ls1046aqds/ls1046aqds_rcw_sd_ifc.cfg (100%)
 rename board/{freescale => nxp}/ls1046aqds/ls1046aqds_rcw_sd_qspi.cfg (100%)
 rename board/{freescale => nxp}/ls1046ardb/Kconfig (89%)
 rename board/{freescale => nxp}/ls1046ardb/MAINTAINERS (87%)
 rename board/{freescale => nxp}/ls1046ardb/Makefile (100%)
 rename board/{freescale => nxp}/ls1046ardb/cpld.c (100%)
 rename board/{freescale => nxp}/ls1046ardb/cpld.h (100%)
 rename board/{freescale => nxp}/ls1046ardb/ddr.c (100%)
 rename board/{freescale => nxp}/ls1046ardb/ddr.h (100%)
 rename board/{freescale => nxp}/ls1046ardb/eth.c (100%)
 rename board/{freescale => nxp}/ls1046ardb/ls1046ardb.c (100%)
 rename board/{freescale => nxp}/ls1046ardb/ls1046ardb_pbi.cfg (100%)
 rename board/{freescale => nxp}/ls1046ardb/ls1046ardb_qspi_pbi.cfg (100%)
 rename board/{freescale => nxp}/ls1046ardb/ls1046ardb_rcw_emmc.cfg (100%)
 rename board/{freescale => nxp}/ls1046ardb/ls1046ardb_rcw_qspi.cfg (100%)
 rename board/{freescale => nxp}/ls1046ardb/ls1046ardb_rcw_sd.cfg (100%)
 rename board/{freescale => nxp}/ls1088a/Kconfig (89%)
 rename board/{freescale => nxp}/ls1088a/MAINTAINERS (94%)
 rename board/{freescale => nxp}/ls1088a/Makefile (100%)
 rename board/{freescale => nxp}/ls1088a/README (100%)
 rename board/{freescale => nxp}/ls1088a/ddr.c (100%)
 rename board/{freescale => nxp}/ls1088a/ddr.h (100%)
 rename board/{freescale => nxp}/ls1088a/eth_ls1088aqds.c (100%)
 rename board/{freescale => nxp}/ls1088a/eth_ls1088ardb.c (100%)
 rename board/{freescale => nxp}/ls1088a/ls1088a.c (100%)
 rename board/{freescale => nxp}/ls1088a/ls1088a_qixis.h (100%)
 rename board/{freescale => nxp}/ls2080aqds/Kconfig (89%)
 rename board/{freescale => nxp}/ls2080aqds/MAINTAINERS (83%)
 rename board/{freescale => nxp}/ls2080aqds/Makefile (100%)
 rename board/{freescale => nxp}/ls2080aqds/README (100%)
 rename board/{freescale => nxp}/ls2080aqds/ddr.c (100%)
 rename board/{freescale => nxp}/ls2080aqds/ddr.h (100%)
 rename board/{freescale => nxp}/ls2080aqds/eth.c (100%)
 rename board/{freescale => nxp}/ls2080aqds/ls2080aqds.c (100%)
 rename board/{freescale => nxp}/ls2080aqds/ls2080aqds_qixis.h (100%)
 rename board/{freescale => nxp}/ls2080ardb/Kconfig (90%)
 rename board/{freescale => nxp}/ls2080ardb/MAINTAINERS (91%)
 rename board/{freescale => nxp}/ls2080ardb/Makefile (100%)
 rename board/{freescale => nxp}/ls2080ardb/README (100%)
 rename board/{freescale => nxp}/ls2080ardb/ddr.c (100%)
 rename board/{freescale => nxp}/ls2080ardb/ddr.h (100%)
 rename board/{freescale => nxp}/ls2080ardb/eth_ls2080rdb.c (100%)
 rename board/{freescale => nxp}/ls2080ardb/ls2080ardb.c (100%)
 rename board/{freescale => nxp}/ls2080ardb/ls2080ardb_qixis.h (100%)
 rename board/{freescale => nxp}/lx2160a/Kconfig (89%)
 rename board/{freescale => nxp}/lx2160a/MAINTAINERS (93%)
 rename board/{freescale => nxp}/lx2160a/Makefile (100%)
 rename board/{freescale => nxp}/lx2160a/README (100%)
 rename board/{freescale => nxp}/lx2160a/ddr.c (100%)
 rename board/{freescale => nxp}/lx2160a/eth_lx2160aqds.c (100%)
 rename board/{freescale => nxp}/lx2160a/eth_lx2160ardb.c (100%)
 rename board/{freescale => nxp}/lx2160a/eth_lx2162aqds.c (100%)
 rename board/{freescale => nxp}/lx2160a/lx2160a.c (100%)
 rename board/{freescale => nxp}/lx2160a/lx2160a.h (100%)
 rename board/{freescale => nxp}/m5208evbe/Kconfig (88%)
 rename board/{freescale => nxp}/m5208evbe/MAINTAINERS (82%)
 rename board/{freescale => nxp}/m5208evbe/Makefile (100%)
 rename board/{freescale => nxp}/m5208evbe/m5208evbe.c (100%)
 rename board/{freescale => nxp}/m5235evb/Kconfig (91%)
 rename board/{freescale => nxp}/m5235evb/MAINTAINERS (85%)
 rename board/{freescale => nxp}/m5235evb/Makefile (100%)
 rename board/{freescale => nxp}/m5235evb/m5235evb.c (100%)
 rename board/{freescale => nxp}/m5249evb/Kconfig (88%)
 rename board/{freescale => nxp}/m5249evb/MAINTAINERS (82%)
 rename board/{freescale => nxp}/m5249evb/Makefile (100%)
 rename board/{freescale => nxp}/m5249evb/m5249evb.c (100%)
 rename board/{freescale => nxp}/m5253demo/Kconfig (91%)
 rename board/{freescale => nxp}/m5253demo/MAINTAINERS (81%)
 rename board/{freescale => nxp}/m5253demo/Makefile (100%)
 rename board/{freescale => nxp}/m5253demo/flash.c (100%)
 rename board/{freescale => nxp}/m5253demo/m5253demo.c (100%)
 rename board/{freescale => nxp}/m5272c3/Kconfig (88%)
 rename board/{freescale => nxp}/m5272c3/MAINTAINERS (83%)
 rename board/{freescale => nxp}/m5272c3/Makefile (100%)
 rename board/{freescale => nxp}/m5272c3/m5272c3.c (100%)
 rename board/{freescale => nxp}/m5275evb/Kconfig (88%)
 rename board/{freescale => nxp}/m5275evb/MAINTAINERS (82%)
 rename board/{freescale => nxp}/m5275evb/Makefile (100%)
 rename board/{freescale => nxp}/m5275evb/m5275evb.c (100%)
 rename board/{freescale => nxp}/m5282evb/Kconfig (88%)
 rename board/{freescale => nxp}/m5282evb/MAINTAINERS (82%)
 rename board/{freescale => nxp}/m5282evb/Makefile (100%)
 rename board/{freescale => nxp}/m5282evb/m5282evb.c (100%)
 rename board/{freescale => nxp}/m53017evb/Kconfig (88%)
 rename board/{freescale => nxp}/m53017evb/MAINTAINERS (81%)
 rename board/{freescale => nxp}/m53017evb/Makefile (100%)
 rename board/{freescale => nxp}/m53017evb/README (95%)
 rename board/{freescale => nxp}/m53017evb/m53017evb.c (100%)
 rename board/{freescale => nxp}/m5329evb/Kconfig (88%)
 rename board/{freescale => nxp}/m5329evb/MAINTAINERS (84%)
 rename board/{freescale => nxp}/m5329evb/Makefile (100%)
 rename board/{freescale => nxp}/m5329evb/m5329evb.c (100%)
 rename board/{freescale => nxp}/m5329evb/nand.c (100%)
 rename board/{freescale => nxp}/m5373evb/Kconfig (88%)
 rename board/{freescale => nxp}/m5373evb/MAINTAINERS (81%)
 rename board/{freescale => nxp}/m5373evb/Makefile (100%)
 rename board/{freescale => nxp}/m5373evb/README (97%)
 rename board/{freescale => nxp}/m5373evb/m5373evb.c (100%)
 rename board/{freescale => nxp}/m5373evb/nand.c (100%)
 rename board/{freescale => nxp}/mpc837xerdb/Kconfig (88%)
 rename board/{freescale => nxp}/mpc837xerdb/MAINTAINERS (84%)
 rename board/{freescale => nxp}/mpc837xerdb/Makefile (100%)
 rename board/{freescale => nxp}/mpc837xerdb/README (100%)
 rename board/{freescale => nxp}/mpc837xerdb/mpc837xerdb.c (100%)
 rename board/{freescale => nxp}/mpc8548cds/Kconfig (93%)
 rename board/{freescale => nxp}/mpc8548cds/MAINTAINERS (87%)
 rename board/{freescale => nxp}/mpc8548cds/Makefile (100%)
 rename board/{freescale => nxp}/mpc8548cds/ddr.c (100%)
 rename board/{freescale => nxp}/mpc8548cds/law.c (100%)
 rename board/{freescale => nxp}/mpc8548cds/mpc8548cds.c (100%)
 rename board/{freescale => nxp}/mpc8548cds/tlb.c (100%)
 rename board/{freescale => nxp}/mx23evk/Kconfig (88%)
 rename board/{freescale => nxp}/mx23evk/MAINTAINERS (87%)
 rename board/{freescale => nxp}/mx23evk/Makefile (100%)
 rename board/{freescale => nxp}/mx23evk/mx23evk.c (100%)
 rename board/{freescale => nxp}/mx23evk/spl_boot.c (100%)
 rename board/{freescale => nxp}/mx28evk/Kconfig (88%)
 rename board/{freescale => nxp}/mx28evk/MAINTAINERS (84%)
 rename board/{freescale => nxp}/mx28evk/Makefile (100%)
 rename board/{freescale => nxp}/mx28evk/README (97%)
 rename board/{freescale => nxp}/mx28evk/iomux.c (100%)
 rename board/{freescale => nxp}/mx28evk/mx28evk.c (100%)
 rename board/{freescale => nxp}/mx51evk/Kconfig (71%)
 rename board/{freescale => nxp}/mx51evk/MAINTAINERS (81%)
 rename board/{freescale => nxp}/mx51evk/Makefile (100%)
 rename board/{freescale => nxp}/mx51evk/imximage.cfg (100%)
 rename board/{freescale => nxp}/mx51evk/mx51evk.c (100%)
 rename board/{freescale => nxp}/mx53loco/Kconfig (75%)
 rename board/{freescale => nxp}/mx53loco/MAINTAINERS (84%)
 rename board/{freescale => nxp}/mx53loco/Makefile (100%)
 rename board/{freescale => nxp}/mx53loco/imximage.cfg (100%)
 rename board/{freescale => nxp}/mx53loco/mx53loco.c (100%)
 rename board/{freescale => nxp}/mx6memcal/Kconfig (99%)
 rename board/{freescale => nxp}/mx6memcal/MAINTAINERS (80%)
 rename board/{freescale => nxp}/mx6memcal/Makefile (100%)
 rename board/{freescale => nxp}/mx6memcal/README (100%)
 rename board/{freescale => nxp}/mx6memcal/mx6memcal.c (100%)
 rename board/{freescale => nxp}/mx6memcal/spl.c (100%)
 rename board/{freescale => nxp}/mx6sabreauto/Kconfig (86%)
 rename board/{freescale => nxp}/mx6sabreauto/MAINTAINERS (83%)
 rename board/{freescale => nxp}/mx6sabreauto/Makefile (100%)
 rename board/{freescale => nxp}/mx6sabreauto/mx6sabreauto.c (100%)
 rename board/{freescale => nxp}/mx6sabresd/Kconfig (86%)
 rename board/{freescale => nxp}/mx6sabresd/MAINTAINERS (81%)
 rename board/{freescale => nxp}/mx6sabresd/Makefile (100%)
 rename board/{freescale => nxp}/mx6sabresd/mx6sabresd.c (100%)
 rename board/{freescale => nxp}/mx6slevk/Kconfig (67%)
 rename board/{freescale => nxp}/mx6slevk/MAINTAINERS (88%)
 rename board/{freescale => nxp}/mx6slevk/Makefile (100%)
 rename board/{freescale => nxp}/mx6slevk/imximage.cfg (100%)
 rename board/{freescale => nxp}/mx6slevk/mx6slevk.c (100%)
 rename board/{freescale => nxp}/mx6sllevk/Kconfig (67%)
 rename board/{freescale => nxp}/mx6sllevk/MAINTAINERS (84%)
 rename board/{freescale => nxp}/mx6sllevk/Makefile (100%)
 rename board/{freescale => nxp}/mx6sllevk/imximage.cfg (98%)
 rename board/{freescale => nxp}/mx6sllevk/mx6sllevk.c (100%)
 rename board/{freescale => nxp}/mx6sllevk/plugin.S (100%)
 rename board/{freescale => nxp}/mx6sxsabreauto/Kconfig (68%)
 rename board/{freescale => nxp}/mx6sxsabreauto/MAINTAINERS (79%)
 rename board/{freescale => nxp}/mx6sxsabreauto/Makefile (100%)
 rename board/{freescale => nxp}/mx6sxsabreauto/imximage.cfg (100%)
 rename board/{freescale => nxp}/mx6sxsabreauto/mx6sxsabreauto.c (100%)
 rename board/{freescale => nxp}/mx6sxsabresd/Kconfig (68%)
 rename board/{freescale => nxp}/mx6sxsabresd/MAINTAINERS (80%)
 rename board/{freescale => nxp}/mx6sxsabresd/Makefile (100%)
 rename board/{freescale => nxp}/mx6sxsabresd/imximage.cfg (100%)
 rename board/{freescale => nxp}/mx6sxsabresd/mx6sxsabresd.c (100%)
 rename board/{freescale => nxp}/mx6ul_14x14_evk/Kconfig (89%)
 rename board/{freescale => nxp}/mx6ul_14x14_evk/MAINTAINERS (82%)
 rename board/{freescale => nxp}/mx6ul_14x14_evk/Makefile (100%)
 rename board/{freescale => nxp}/mx6ul_14x14_evk/mx6ul_14x14_evk.c (100%)
 rename board/{freescale => nxp}/mx6ullevk/Kconfig (68%)
 rename board/{freescale => nxp}/mx6ullevk/MAINTAINERS (87%)
 rename board/{freescale => nxp}/mx6ullevk/Makefile (100%)
 rename board/{freescale => nxp}/mx6ullevk/imximage.cfg (98%)
 rename board/{freescale => nxp}/mx6ullevk/mx6ullevk.c (100%)
 rename board/{freescale => nxp}/mx6ullevk/plugin.S (100%)
 rename board/{freescale => nxp}/mx7dsabresd/Kconfig (67%)
 rename board/{freescale => nxp}/mx7dsabresd/MAINTAINERS (87%)
 rename board/{freescale => nxp}/mx7dsabresd/Makefile (100%)
 rename board/{freescale => nxp}/mx7dsabresd/imximage.cfg (100%)
 rename board/{freescale => nxp}/mx7dsabresd/mx7dsabresd.c (100%)
 rename board/{freescale => nxp}/mx7ulp_evk/Kconfig (67%)
 rename board/{freescale => nxp}/mx7ulp_evk/MAINTAINERS (84%)
 rename board/{freescale => nxp}/mx7ulp_evk/Makefile (100%)
 rename board/{freescale => nxp}/mx7ulp_evk/imximage.cfg (98%)
 rename board/{freescale => nxp}/mx7ulp_evk/mx7ulp_evk.c (100%)
 rename board/{freescale => nxp}/mx7ulp_evk/plugin.S (100%)
 rename board/{freescale => nxp}/p1010rdb/Kconfig (87%)
 rename board/{freescale => nxp}/p1010rdb/MAINTAINERS (96%)
 rename board/{freescale => nxp}/p1010rdb/Makefile (100%)
 rename board/{freescale => nxp}/p1010rdb/README.P1010RDB-PA (100%)
 rename board/{freescale => nxp}/p1010rdb/README.P1010RDB-PB (100%)
 rename board/{freescale => nxp}/p1010rdb/ddr.c (100%)
 rename board/{freescale => nxp}/p1010rdb/law.c (100%)
 rename board/{freescale => nxp}/p1010rdb/p1010rdb.c (100%)
 rename board/{freescale => nxp}/p1010rdb/spl.c (100%)
 rename board/{freescale => nxp}/p1010rdb/spl_minimal.c (100%)
 rename board/{freescale => nxp}/p1010rdb/tlb.c (100%)
 rename board/{freescale => nxp}/p1_p2_rdb_pc/Kconfig (89%)
 rename board/{freescale => nxp}/p1_p2_rdb_pc/MAINTAINERS (96%)
 rename board/{freescale => nxp}/p1_p2_rdb_pc/Makefile (100%)
 rename board/{freescale => nxp}/p1_p2_rdb_pc/README (100%)
 rename board/{freescale => nxp}/p1_p2_rdb_pc/ddr.c (100%)
 rename board/{freescale => nxp}/p1_p2_rdb_pc/law.c (100%)
 rename board/{freescale => nxp}/p1_p2_rdb_pc/p1_p2_rdb_pc.c (100%)
 rename board/{freescale => nxp}/p1_p2_rdb_pc/spl.c (100%)
 rename board/{freescale => nxp}/p1_p2_rdb_pc/spl_minimal.c (100%)
 rename board/{freescale => nxp}/p1_p2_rdb_pc/tlb.c (100%)
 rename board/{freescale => nxp}/p2041rdb/Kconfig (85%)
 rename board/{freescale => nxp}/p2041rdb/MAINTAINERS (91%)
 rename board/{freescale => nxp}/p2041rdb/Makefile (100%)
 rename board/{freescale => nxp}/p2041rdb/README (100%)
 rename board/{freescale => nxp}/p2041rdb/cpld.c (100%)
 rename board/{freescale => nxp}/p2041rdb/cpld.h (100%)
 rename board/{freescale => nxp}/p2041rdb/ddr.c (100%)
 rename board/{freescale => nxp}/p2041rdb/eth.c (100%)
 rename board/{freescale => nxp}/p2041rdb/p2041rdb.c (100%)
 rename board/{freescale => nxp}/p2041rdb/pbi.cfg (100%)
 rename board/{freescale => nxp}/p2041rdb/rcw_p2041rdb.cfg (100%)
 rename board/{freescale => nxp}/t102xrdb/Kconfig (87%)
 rename board/{freescale => nxp}/t102xrdb/MAINTAINERS (89%)
 rename board/{freescale => nxp}/t102xrdb/Makefile (100%)
 rename board/{freescale => nxp}/t102xrdb/README (100%)
 rename board/{freescale => nxp}/t102xrdb/cpld.c (100%)
 rename board/{freescale => nxp}/t102xrdb/cpld.h (100%)
 rename board/{freescale => nxp}/t102xrdb/ddr.c (100%)
 rename board/{freescale => nxp}/t102xrdb/eth_t102xrdb.c (100%)
 rename board/{freescale => nxp}/t102xrdb/law.c (100%)
 rename board/{freescale => nxp}/t102xrdb/spl.c (100%)
 rename board/{freescale => nxp}/t102xrdb/t1023_nand_rcw.cfg (100%)
 rename board/{freescale => nxp}/t102xrdb/t1023_sd_rcw.cfg (100%)
 rename board/{freescale => nxp}/t102xrdb/t1023_spi_rcw.cfg (100%)
 rename board/{freescale => nxp}/t102xrdb/t1024_nand_rcw.cfg (100%)
 rename board/{freescale => nxp}/t102xrdb/t1024_pbi.cfg (100%)
 rename board/{freescale => nxp}/t102xrdb/t1024_sd_rcw.cfg (100%)
 rename board/{freescale => nxp}/t102xrdb/t1024_spi_rcw.cfg (100%)
 rename board/{freescale => nxp}/t102xrdb/t102xrdb.c (100%)
 rename board/{freescale => nxp}/t102xrdb/t102xrdb.h (100%)
 rename board/{freescale => nxp}/t102xrdb/tlb.c (100%)
 rename board/{freescale => nxp}/t104xrdb/Kconfig (86%)
 rename board/{freescale => nxp}/t104xrdb/MAINTAINERS (96%)
 rename board/{freescale => nxp}/t104xrdb/Makefile (100%)
 rename board/{freescale => nxp}/t104xrdb/README (99%)
 rename board/{freescale => nxp}/t104xrdb/cpld.c (100%)
 rename board/{freescale => nxp}/t104xrdb/cpld.h (100%)
 rename board/{freescale => nxp}/t104xrdb/ddr.c (100%)
 rename board/{freescale => nxp}/t104xrdb/ddr.h (100%)
 rename board/{freescale => nxp}/t104xrdb/eth.c (100%)
 rename board/{freescale => nxp}/t104xrdb/law.c (100%)
 rename board/{freescale => nxp}/t104xrdb/spl.c (100%)
 rename board/{freescale => nxp}/t104xrdb/t1040_nand_rcw.cfg (100%)
 rename board/{freescale => nxp}/t104xrdb/t1040_sd_rcw.cfg (100%)
 rename board/{freescale => nxp}/t104xrdb/t1040_spi_rcw.cfg (100%)
 rename board/{freescale => nxp}/t104xrdb/t1040d4_nand_rcw.cfg (100%)
 rename board/{freescale => nxp}/t104xrdb/t1040d4_sd_rcw.cfg (100%)
 rename board/{freescale => nxp}/t104xrdb/t1040d4_spi_rcw.cfg (100%)
 rename board/{freescale => nxp}/t104xrdb/t1042_nand_rcw.cfg (100%)
 rename board/{freescale => nxp}/t104xrdb/t1042_pi_nand_rcw.cfg (100%)
 rename board/{freescale => nxp}/t104xrdb/t1042_pi_sd_rcw.cfg (100%)
 rename board/{freescale => nxp}/t104xrdb/t1042_pi_spi_rcw.cfg (100%)
 rename board/{freescale => nxp}/t104xrdb/t1042_sd_rcw.cfg (100%)
 rename board/{freescale => nxp}/t104xrdb/t1042_spi_rcw.cfg (100%)
 rename board/{freescale => nxp}/t104xrdb/t1042d4_nand_rcw.cfg (100%)
 rename board/{freescale => nxp}/t104xrdb/t1042d4_sd_rcw.cfg (100%)
 rename board/{freescale => nxp}/t104xrdb/t1042d4_spi_rcw.cfg (100%)
 rename board/{freescale => nxp}/t104xrdb/t104x_pbi.cfg (100%)
 rename board/{freescale => nxp}/t104xrdb/t104x_pbi_sb.cfg (100%)
 rename board/{freescale => nxp}/t104xrdb/t104xrdb.c (100%)
 rename board/{freescale => nxp}/t104xrdb/t104xrdb.h (100%)
 rename board/{freescale => nxp}/t104xrdb/tlb.c (100%)
 rename board/{freescale => nxp}/t208xqds/Kconfig (90%)
 rename board/{freescale => nxp}/t208xqds/MAINTAINERS (95%)
 rename board/{freescale => nxp}/t208xqds/Makefile (100%)
 rename board/{freescale => nxp}/t208xqds/README (100%)
 rename board/{freescale => nxp}/t208xqds/ddr.c (100%)
 rename board/{freescale => nxp}/t208xqds/ddr.h (100%)
 rename board/{freescale => nxp}/t208xqds/eth_t208xqds.c (100%)
 rename board/{freescale => nxp}/t208xqds/law.c (100%)
 rename board/{freescale => nxp}/t208xqds/spl.c (100%)
 rename board/{freescale => nxp}/t208xqds/t2080_nand_rcw.cfg (100%)
 rename board/{freescale => nxp}/t208xqds/t2080_sd_rcw.cfg (100%)
 rename board/{freescale => nxp}/t208xqds/t2080_spi_rcw.cfg (100%)
 rename board/{freescale => nxp}/t208xqds/t2081_nand_rcw.cfg (100%)
 rename board/{freescale => nxp}/t208xqds/t2081_sd_rcw.cfg (100%)
 rename board/{freescale => nxp}/t208xqds/t2081_spi_rcw.cfg (100%)
 rename board/{freescale => nxp}/t208xqds/t208x_pbi.cfg (100%)
 rename board/{freescale => nxp}/t208xqds/t208xqds.c (100%)
 rename board/{freescale => nxp}/t208xqds/t208xqds.h (100%)
 rename board/{freescale => nxp}/t208xqds/t208xqds_qixis.h (100%)
 rename board/{freescale => nxp}/t208xqds/tlb.c (100%)
 rename board/{freescale => nxp}/t208xrdb/Kconfig (90%)
 rename board/{freescale => nxp}/t208xrdb/MAINTAINERS (93%)
 rename board/{freescale => nxp}/t208xrdb/Makefile (100%)
 rename board/{freescale => nxp}/t208xrdb/README (100%)
 rename board/{freescale => nxp}/t208xrdb/cpld.c (100%)
 rename board/{freescale => nxp}/t208xrdb/cpld.h (100%)
 rename board/{freescale => nxp}/t208xrdb/ddr.c (100%)
 rename board/{freescale => nxp}/t208xrdb/ddr.h (100%)
 rename board/{freescale => nxp}/t208xrdb/eth_t208xrdb.c (100%)
 rename board/{freescale => nxp}/t208xrdb/law.c (100%)
 rename board/{freescale => nxp}/t208xrdb/spl.c (100%)
 rename board/{freescale => nxp}/t208xrdb/t2080_nand_rcw.cfg (100%)
 rename board/{freescale => nxp}/t208xrdb/t2080_pbi.cfg (100%)
 rename board/{freescale => nxp}/t208xrdb/t2080_sd_rcw.cfg (100%)
 rename board/{freescale => nxp}/t208xrdb/t2080_spi_rcw.cfg (100%)
 rename board/{freescale => nxp}/t208xrdb/t208xrdb.c (100%)
 rename board/{freescale => nxp}/t208xrdb/t208xrdb.h (100%)
 rename board/{freescale => nxp}/t208xrdb/tlb.c (100%)
 rename board/{freescale => nxp}/t4rdb/Kconfig (85%)
 rename board/{freescale => nxp}/t4rdb/MAINTAINERS (86%)
 rename board/{freescale => nxp}/t4rdb/Makefile (100%)
 rename board/{freescale => nxp}/t4rdb/cpld.c (100%)
 rename board/{freescale => nxp}/t4rdb/cpld.h (100%)
 rename board/{freescale => nxp}/t4rdb/ddr.c (100%)
 rename board/{freescale => nxp}/t4rdb/ddr.h (100%)
 rename board/{freescale => nxp}/t4rdb/eth.c (100%)
 rename board/{freescale => nxp}/t4rdb/law.c (100%)
 rename board/{freescale => nxp}/t4rdb/spl.c (100%)
 rename board/{freescale => nxp}/t4rdb/t4240rdb.c (100%)
 rename board/{freescale => nxp}/t4rdb/t4_pbi.cfg (100%)
 rename board/{freescale => nxp}/t4rdb/t4_sd_rcw.cfg (100%)
 rename board/{freescale => nxp}/t4rdb/t4rdb.h (100%)
 rename board/{freescale => nxp}/t4rdb/tlb.c (100%)
 rename board/{freescale => nxp}/vf610twr/Kconfig (67%)
 rename board/{freescale => nxp}/vf610twr/MAINTAINERS (84%)
 rename board/{freescale => nxp}/vf610twr/Makefile (100%)
 rename board/{freescale => nxp}/vf610twr/imximage.cfg (100%)
 rename board/{freescale => nxp}/vf610twr/vf610twr.c (100%)
