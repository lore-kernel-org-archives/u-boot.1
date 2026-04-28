Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1034CFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 15:35:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81D2484656;
	Tue, 28 Apr 2026 17:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="VCL77reA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 945AF843D4; Tue, 28 Apr 2026 17:35:05 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CACE884150
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 17:35:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzngoPgsq3t88g5/X1cRvUYh25qAOKIac2wvSmVaUGLfKH50fUBgiGPuHTmDe4cYrxs+y9F39qu9+adzvVIU84OVqdL+5U832+qpyyE/XfA07+pkdqlWMKC2WPz1OK1rxaOkQxZqWtuGFIFSJenogP2wDbb8qNmQ0EIlL/KHfz2bmZhfWZ4hEbWo26R+nLO0cl7XciHNwy5R1Gm+wrRPlxgEUC9qELgRJWzihmkb154jTKLh22L6i7j8d5VeHjTbaNHrvukzcItrdbfuNlEtI9f0Plt9ahzpHg0Ywy1q9GK4l+YH0horhR/+tqYD56LGpdd2ECivdXIsh4bGQkkQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+yK2e9blT2Im6/elvs7zeNNZtdlWSpK5bsgbGrdFss=;
 b=PbdGa548KKuL8/Mrj0dDOWhIdQ3uJwLz/6FwZ/olu4UhmoKtdZ3S/85YfVVwX3/ih8sDGtULGCYdMihlWgTPPEZT8wNIMY35Gi3K4NccfQ1rVQBbEJ+GnJ3VNmjVlF1fPK3ae2oIW/CUKaO5ReV1cKwscB9JyWANn9xczvyLgnObYN9hrSTbyfB+s6yPnmbYPizr9t0XlAme5fGJixFe5PfvzvErkIgXnuUJJgUDvBbWsXWZbs8sYjR+rezN5TlKLcfGhVzfglrnExdHyDHB+eQD3MKrsg+vVGd/kq8LHQXi3GhYAObAgp7fLbT2h+08k6xtsx/nwq4qR3tH37Jh1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+yK2e9blT2Im6/elvs7zeNNZtdlWSpK5bsgbGrdFss=;
 b=VCL77reA07Kl36XKZNc3/Gu5iWqYOKq4oHqfuxLbycivbmEI+oV0JcXg4X0VORrnyM6+sJtY/+NSN/vSigewdtTDUyti4xVP0GUTrzPKB+XFhLRbJlzDMMyLz/d2SdXF5Znzl0dU2qQtSJ7+KaxHla7DHWbRwoOmCzmcK/+KhF13gHhRqwXxq3xNPVYWkSC+Ah5UMnkZ+amY6EIa3PaILeS6Burbi2FFio067SzrwW9KBO6HjcfThVxvtmn/BCygWlHMZyBIpfsdaTa7InlvXLNZZMclGXpcDUkTiB+VfG2c1DqvU4Q872JGbwADPFrDr/6QInG4TYR8Stj2tLZ2Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAXPR08MB6720.eurprd08.prod.outlook.com (2603:10a6:102:130::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 15:34:56 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 15:34:56 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>, Anis Chali <chalianis1@gmail.com>,
 u-boot@lists.denx.de, Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 David Lechner <dlechner@baylibre.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 0/6] pinctrl: add support of Airoha SoCs
Date: Tue, 28 Apr 2026 18:34:42 +0300
Message-ID: <20260428153448.980150-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::17) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAXPR08MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: 1042946a-99dc-4036-9508-08dea53bb363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|52116014|56012099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info: WZ5AxUusXl2OuZzDXbpNR73uxs3MM5+ko3MFWRz0kYBJE1UfkhAirRIj6qVJANs45olFj1NBapmKcGorUknGVQpsE0LQwq0RJUN131xVMnH8gfLLRmVWrNN4m9ODYkiCm1mBOc5aDmOUqXqbDJxhoXV5P4x53r+rV8L1Ria6YEXkqrppnLqqTuPrw4K2z5R4VTwGLoYLElfPu7gh9e0I6R85/XW9/9W2EzR6yEyrBnZjx1Ru0IpDn3rnpmFvXSkw6yyQUzTvUIS8ql1AVhslkwqJvsQMVlNsc+H1nv065XDjgnzlcl8VBZi14vTx1Kzp9WerD8fSWyg4i0lVtR2L6i4fVVjsrqxcIuJT1z/Qq4eTQ3tDgT8qVdGNOhBEOXwjuIMYBPcCNQDChQp3T5bKW9eIg3QIHkVT5J+cuqgzRx40AMbvbQf0aY7RKkXRlg2rZu7X661zjCgM8Kb9YjGI8/zR6/LIgghoOO6ppvU7en/CzKee1ULcfEbo4mQn4q3rXOh8Jfc8OJLpZSIYQvoEw2kDWMzzk+DDR1At9orjzYYVDcwC8Tz6ejGdyHtsLCxwseyEjzpuxmmmXWqWuf1n7vYvmoORFX5EAUHb9GUgeflYi/IeTzx0z3pASh1DVms102vyGQIo3FywqO00NGCSZuxqMZ9Tz5K60bpHFF0sunZItDpHgWR8Iiq7M+U1TD3JSuvbXPLZuoutsrwuwjxxuKwvAxVAMF365oytrNO9fdcTgoky0IF8eeWUTlTpo3rg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(56012099003)(18002099003)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dIVy5iW/gU56lSQyvyyhEt1uxIBzJTmtVIY2Jp32SRcWV5cNn/6sGQX7evKw?=
 =?us-ascii?Q?3Xt4vf/NwHANAshDV94SLl1HWdzB3OHdK3OgiDCgXT4Kf5DDlgGZ1Npbnh3S?=
 =?us-ascii?Q?Cwxicf6zDYoSoqgpAO9hpMVe6fBjaIOufnO8xXqpNMVh2Q06vQ8y0J3pwwGd?=
 =?us-ascii?Q?Z2sNs9KGgASLOYqVjoGIHNubftp3qEIQLv90L9Wz1oHhFS4BQ9nxgivOg/e3?=
 =?us-ascii?Q?dgEZcskiSE5Eg0aQM2M51mDUqh0RgH1jq2Vsmag1L/NbmHS0qhGgWJOggBIU?=
 =?us-ascii?Q?uG1Zv+/9vlYhWdDrKFM9AMS33/j4yUPFGoM79/4yrgMaUqnJ3oiSt/mCD6sI?=
 =?us-ascii?Q?gBp3WXvNUbJyT3s6+r4YJNVSb1Et3EL+kv9ofpjEOrUMByBHFgcXxYc9ugaz?=
 =?us-ascii?Q?3vTWy92jIy0tafeZO/eeECFFXm/4RMA3CqTb/ki3YmJpLolsRzegdr4y5IUY?=
 =?us-ascii?Q?kaRmYzeDOf3X7rR4egYUo/TC32fsKiGGXUbWxbBx0OtNQ6mogrKeq3uEQpYR?=
 =?us-ascii?Q?GUfqLxECKX/2Acjr1T8zDcCBViTi8Oe/6Yd8rG+4+QKcMGR2fZT0VDcmJCdB?=
 =?us-ascii?Q?8+PGiVpocEwLbLk9n8y3MLRiAdz+iNy1LO+jN9laD4TRJDErkr7tdfr5q1x0?=
 =?us-ascii?Q?hWOy5JwdgEoJ4ob12VljeIMZMebb5hOD7+poV8jDCeD2HyULrB9UNh9vY1J2?=
 =?us-ascii?Q?O+Kn65kUq8Cr4Pe6vzwCVCtnojmrH3+VoW7gru811DwmoDbhFaCOmJIieN9p?=
 =?us-ascii?Q?NzIJD0v2Vy/nr5j69yUDabuTCbVIhphAwgBlbdyM2waPnOLC/0VBMgVlUOeY?=
 =?us-ascii?Q?fIGNx71asgKdEsU1ZsdKBO9nvgQs3o+YYvTlQFO/4QJ2kzEubYC6rbUgGOVZ?=
 =?us-ascii?Q?Uxrh54EuUApszdg6FA6fr1SjyTxSprykDt2bXTHLVXztOSlSLrr8S3H/Tu4b?=
 =?us-ascii?Q?5y1luZLRPGLZOT4e6vDBcfxAkXO4gddzokXUwBHfYaFZVvyNBiMJew+47QXq?=
 =?us-ascii?Q?DTxnFzrOoDNvit3Uub8zg7o2vZzBY/AAff1iQx1bDN5H6WMf/om8w6kD+S+c?=
 =?us-ascii?Q?fUb7AAeMO8Y2lMUFtne33Pok6L9kt1AcEks2264aNt3I+tY2xINs3KLX3odh?=
 =?us-ascii?Q?D0rP47By5VdlWFRkAHIHagKDYDQCXN5nNllz9M+sutvrrcAIDXICnxgaEcE1?=
 =?us-ascii?Q?wqhSwplHHe9DFtS8+REG+3BHGwoU9Dcip8gbety7t4scQOxL8JXvEB5CgHwH?=
 =?us-ascii?Q?+2ruptDms7M115cUgkj9SaYsHCKresoT2RW3SBx8ebxYY0m3Abj3+XQ5aQsG?=
 =?us-ascii?Q?AP+A1FtYHNYBZ78BWqEHqk/BaTrt9wf6ZY2f/TFU4KSw0QxE2zaum/Ybc+jY?=
 =?us-ascii?Q?xzhjrluCbGyCmk5552H7TUZfJtQncPfGhUgSqAzj8W5xL2k4fsrweenvyIk+?=
 =?us-ascii?Q?N1ASCYdjhKV4p3YNh+/aBsL0lEqweVUJFHCpAF65GhrXv9FA9UVNs1gRf2bB?=
 =?us-ascii?Q?Evpl0kGsam/+b0ZpV/qRygDSNQXueqrbSlZpESHew3KcjhOCFlnA4fKERage?=
 =?us-ascii?Q?uyuK1PsKHg0JT0B8ikNvzVJTaJN7rF7c9fac94oD71SGO6+s0PZMRr7Bmlje?=
 =?us-ascii?Q?oLGuTsskQGvFA9ICn89MECApUYW3fWNEa8Vdv5VTCBMIUG2cSboGGf+J/E36?=
 =?us-ascii?Q?MEJnTMo0y+MAWobPuywUsr3EUrYxssz479iYSYCkrRj1T30zxKJGmBXvAk12?=
 =?us-ascii?Q?Dzn7PS6cPQX8JXEGlOoTrZBdLGW9iLg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1042946a-99dc-4036-9508-08dea53bb363
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 15:34:56.6279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNvWJjg3B+WAmXyPp/RdBEGRvHJG/WgP7BkwRsn8JH/345LDpXPwxdF3sAxXnSWx23UlnvTIi+FlEsWwMf4tJ5B7SnJGlMj2/olNNwPXONY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6720
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

This patch series add pin controller and gpio driver support for EN7523/
AN7581/AN7583 SoCs. The driver based on official linux airoha pinctrl and
gpio driver with Matheus Sampaio Queiroga <srherobrine20@gmail.com> changes.
The changes:
 * Separate code for each SoC and keep some of the functions in
   common between them,
 * Add pinctrl driver for EN7523 SoC.

The original Matheus Sampaio Queiroga driver can be taken from the repo:
  https://sirherobrine23.com.br/airoha_an7523/kernel/commits/branch/airoha_an7523_pinctrl

Additionally in the EN7523 case the patches removes existing gpio dts nodes
and replaces them with pinctrl node. It should not be very dangerous, because:
 * No official EN7523 gpio support present in U-Boot
 * Legacy Linux EN7523 GPIO driver is mostly abandoned
 * The same driver is planned for upstream linux/openwrt

The patches were tested on EN7523/AN7581/AN7583 boards.

Changes v2:
 * pinctrl driver was split on common and per SoC parts
 * EN7523 SoC support was added
 * EN7523/AN7581 defconfigs were updated to activate
   pinctrl/gpio support
 * Board/SoC independent pinconf/pinctrl definitions
   were moved to global includes 

Mikhail Kshevetskiy (6):
  pinctrl: add missed pinconf/pinctrl definitions
  pinctrl: airoha: add pin controller and gpio driver for AN7581 SoC
  pinctrl: airoha: add pin controller and gpio driver for AN7583 SoC
  pinctrl: airoha: add pin controller and gpio driver for EN7523 SoC
  configs: airoha: an7581: enable pinctrl/gpio support
  configs: airoha: en7523: enable pinctrl/gpio support

 arch/arm/dts/en7523-u-boot.dtsi         |   21 +
 configs/an7581_evb_defconfig            |    1 +
 configs/en7523_evb_defconfig            |    1 +
 drivers/pinctrl/Kconfig                 |    1 +
 drivers/pinctrl/Makefile                |    1 +
 drivers/pinctrl/airoha/Kconfig          |   26 +
 drivers/pinctrl/airoha/Makefile         |    7 +
 drivers/pinctrl/airoha/airoha-common.h  |  513 +++++++++++
 drivers/pinctrl/airoha/pinctrl-airoha.c |  691 +++++++++++++++
 drivers/pinctrl/airoha/pinctrl-an7581.c | 1060 +++++++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-an7583.c |  966 +++++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-en7523.c |  627 ++++++++++++++
 include/dm/pinctrl.h                    |   28 +
 include/linux/pinctrl/pinctrl.h         |   74 ++
 14 files changed, 4017 insertions(+)
 create mode 100644 drivers/pinctrl/airoha/Kconfig
 create mode 100644 drivers/pinctrl/airoha/Makefile
 create mode 100644 drivers/pinctrl/airoha/airoha-common.h
 create mode 100644 drivers/pinctrl/airoha/pinctrl-airoha.c
 create mode 100644 drivers/pinctrl/airoha/pinctrl-an7581.c
 create mode 100644 drivers/pinctrl/airoha/pinctrl-an7583.c
 create mode 100644 drivers/pinctrl/airoha/pinctrl-en7523.c
 create mode 100644 include/linux/pinctrl/pinctrl.h

-- 
2.53.0

