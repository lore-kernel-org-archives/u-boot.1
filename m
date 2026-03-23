Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5661BD58CD1
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 05:02:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BE2683FEC;
	Mon, 23 Mar 2026 06:02:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="m54i7xt2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D88D840AE; Mon, 23 Mar 2026 06:02:26 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA05283DB6
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 06:02:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7Jsh7PpJv05SN2kKpqyZBvoo1MLK/BujDMvX6dxFuSwT/Wmru9EwNNMqSPFyZgaWYhYZy2g5G7D6SXvTnkC8ZMHd7PNgsxKntgPJQbtv5oUupbilKHpen1LLpaguAsqB1uDabayhb0+fKd4Yv0/Wv+vyN4t3rpeN9gPxHG8iKnIt8HFpxdkqUnAjfk+TOSrig+b2zQMoD6FKufBp5w2HH5P/tmSl0JchYT2buqx6/86tOB+V+8CxvoFzT/vRWN5bSR89PchpVczTrCzRWbclein53abcm9LST44mCBjd2D1VD9c48cCdg7OPQSCgiLtfDIkXKn0Bg0q9bLh66FZQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnyB0yUNWi3To7mXrbbsZS+T53XfHDktHGri+MHM+gY=;
 b=JtMdbl16r4kY8C8e5KS7uSLWHy6d0D2bvlr/x72L4QOqf9J57sxVSwKhrLBlG7PekxQhgyfUTHuqt9kSMadbPbw1W//a1IfuUTsno5krz66gSay6aHSKNi/MXFoBOukDcIxhcIbbQi6MftAJo6ZtX28dUEgfisrIGIlMQRHXYk4LAf1k5VMeMG5qWmkKre8+At6o78jTGKA9Jc11ynL1NQUcSTLnsGZ2XHQhUx4GH2vtglnPWPcA639aFvErV/E13fsXGVdHMmBei5eJMtvY7YPZISaxh6uqzVwKRtuRABw32+nMeHz5oWB4TgPS30iEb9gEqWKHttszaIJxxxvRQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnyB0yUNWi3To7mXrbbsZS+T53XfHDktHGri+MHM+gY=;
 b=m54i7xt2e+eH6WTrFkReTsEZyoZsa2ZTIdg4z7LK+3BRfaS8LSCwFC9216bJW7IsKI9etEHD/V+A5ybqR1j154kcQwXDFkWKH3NG442GyH/7zSLfEno3ybUrb8cb6dRFNm9Ec6DhlFF0vV7Id3+crzRcuARAcOb0i9Fm42nmPumSyst25og9H7SDGUx98xX1X/aW2w4mwZLi1EGbt3ErRfzeU6m/k6+iYZb1+zt3Lj0oz3/wTQ4uJxvlOW8KmqMhGhY09E+xcsNkVKgcCclqz6r6XZo1QTFoQGAFVu4kl33woyUrmV53Ben/8P9oFhoZGNWGqe3GR5cB7SPgu4r3Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7543.eurprd04.prod.outlook.com (2603:10a6:20b:29b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 05:02:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 05:02:03 +0000
Date: Mon, 23 Mar 2026 14:18:03 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [GIT PULL] Please pull fsl-qoriq-next-2026-03-23
Message-ID: <acDbGwsosXBP8C3p@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MA5P287CA0030.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d681f2-bca3-4771-7a5f-08de8899526e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: eymiv/rwjFbYwlU+06Ttfx1kyf13G/HIEbbRNn/6UIGxK8o2cuv2fGM4BBiOSjE4gA1JDH9FC25x5y0vskRe5zACrgWy0/+L4IVimJQSPrW+1ljQZJtOxSBc8kzI5vv7ZePyt9WkuXGJPPF8FwKg8vCBqe8w5Yd+SS+49n9wEnXHGwToNTItQ4yGNoOZbJL4zRwOkn882JY6jVYsRO6Z7kN/5mMla6/YUhH7mn4oQPY5NQIMBf004waZp08CNdpIZdVSDS3b0l5Vchhl3vJYnAHdauAmX8C8scQlpseeK7X7o3jXGJ0bdBAf/A7mfiWt2YCTYMepvnbL26+gfSnijTgUMGrtv7ny/5CDOlznAUrD+iUwCliIiH/4g/6PS5sH8UXu8p20Lvw34O+SSsfKub+SVJV88/CDKqX3m7377RK5czsJwRkQ8TDxHY3qYogSS5lgrFTK0b7DHSm7TakZkjxhSFsJ7ITxutgf/9Rc4E7LCXhpEdlEFYLb3iOx9RoMmMDNvECP/NPCvwf1ovlFAOR1IyYfqbGLjpxsOCqYWYpS9wskIwedGxECVRbTLRJ4XWJ3MlodNwVHlgYkSyVc8Q6HsJRJFA4eelDPjaZCuJamMSzeHfLnxNHKvOqIuLDhKCDdEXh6252vbgtYyjPTeyEj4K9tAKk/sFM2LXRDjzKqv3L9vczG+tMw2iJImZMk8yWfYE3cVa6eTo3CwFrNK0IxWp3TQlxu97M7cxL7JqtCCkMmShAtwT/JQ181zD/i
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f3gOmyIRlU+obNDrQMNJDDC/Ey0EVQ19mZTqrtwesYTUZ2Mdv60kA1Q0+D2T?=
 =?us-ascii?Q?WQ4muDRzY8eAXGxBlcQjQMwRFpYVakDc0EvB2vd8/JpjSSCvZipnRbyfuO6W?=
 =?us-ascii?Q?q23H4oJOvNlmibetQZllehWdT6Ewa5ENRifdOYdNOZ+bv/Ezh1tyZUJJOsvK?=
 =?us-ascii?Q?XUm9UgJAql4tDkIfL8mpviNM50AIY/cyH8j3hbSiDco6ECZCtEe/wcf8+TPz?=
 =?us-ascii?Q?m5eetSoMlWHmbrdQEFQBZxJt3M5uY7JHrNAGT/cmmdZDEZtZkNzf17QzrvoA?=
 =?us-ascii?Q?wGbNO8+SCmXcnDEKIUP1KOe2aOoK7rADY73daax5Rxm0xSPu4VPgCjYvrzul?=
 =?us-ascii?Q?4tHRXVksNucRnemPjy2CEAUonT/1n8lDHu5qF6aET6So04YXHf2Z9ykvhHfq?=
 =?us-ascii?Q?bBg5yKsNnhfN2ToUqu1qg/0+EIEQfHdzq7iRgrv0csPtvtk/E5czy4TIgxjS?=
 =?us-ascii?Q?WD2QujKFLmFuiqLOjfIsDfbIWU2WQxSfXPr7IwPP02/57ajCJEIndYB4lIsa?=
 =?us-ascii?Q?+7eOuPnRUDKzQca3gixEXsPsIVKxAvArjalP6fGLkFmg6umGxD97ULx0f4zN?=
 =?us-ascii?Q?smmp+Hs7YUYXk1QS/mPp7fMLCV2tE88/giwlA78ovHTGitZyyMHiX+8iC/fE?=
 =?us-ascii?Q?jhSngT6oB+4Ywz9J+8blgWkxwR+z99lazdCSZWhejYBocdKMyAZPQdOnhuwL?=
 =?us-ascii?Q?zAnQTrM4oWH5rrdSyV8M8Wzr8gXoFWgysseigOPcIYMCcp1GDOZzDx3PD0sG?=
 =?us-ascii?Q?930TBqGzOiFU3TIRSVF26BaQAnOpX9MU6qWJD9veLkVhF7ooCYSK91bbT98R?=
 =?us-ascii?Q?R9RhugIsL+AdgMI0uWMrePnyLLFRidwcX97wtyn649H89caskfPvLTYOiAve?=
 =?us-ascii?Q?pliWRGJeteKXemYURetceyy/u1Br+KYIqwnu8NNWEUD/bfhQejHupbWadp1F?=
 =?us-ascii?Q?YzM7gb2iaYg7nLC50F6pe+bbOKQSgQSqxoQYdh9CmnZqqCv33R9ZVpr/DI/y?=
 =?us-ascii?Q?hcPlaQJGldSaS1wCQr0quQG0ZdxryCc1k6lG80sIcDNTTg5Uqrf8dfLV2SLt?=
 =?us-ascii?Q?n3izryiLcfiI5mIMhOexg4YlFaPpFzjgh0RJSJsEZGsWgReZcUDVY4WG0fyb?=
 =?us-ascii?Q?VaFulsi6sWaMkJvgUImjx0aIYZLJ/aWxiq7ePvpV4jAO19zC1amwdpqhKk9x?=
 =?us-ascii?Q?DXBeVJuXWQrbFoOE8oOashOqRIE/Ob12aQyOvBnkQC/rD0OtMMHaQQvSUDPo?=
 =?us-ascii?Q?FwtAZHfuLJ95paXzYDlscbBJ/kOh1Kyp+aUiKtmYTRI6Bsf5nngsf+B+qJfP?=
 =?us-ascii?Q?HQTBk8ojvSD5lamoRPxoburO9odYUU6pt0eTMEK8gf2FHfJgGVfR6dxJZ3Wj?=
 =?us-ascii?Q?w3+Es7H6yDZ23K1UR+m/qlDlokfBmU44tIRWRJJsQ7b+PfszzIR3HqOtyM0X?=
 =?us-ascii?Q?RblCROX0LA1VqPyHAJHKtdjmgkDi+C0NdataVjQGcpHEN+ygrANdhUQTCeCD?=
 =?us-ascii?Q?6E2jX++oPur9x0iY1IRgbkGBOlzK9Wt5wpytpzrBJnvVVEfv587S02f1aC5m?=
 =?us-ascii?Q?SLEvLt3v9gNp5WWycS4qheqmg9xumGdnVstKGinPWxDlub8WKryJ/gjp+ClV?=
 =?us-ascii?Q?ha563LVS5KveL8s/9UCQ6xvc5boL5YXQqt/vk2QIzi+Td3rlyQAFjwsbzbJN?=
 =?us-ascii?Q?hfTQemgH79TD2USLrLuc0ETwcvHc5VQWeUkhHryuOKWHCb2qKWWAMaeXQPgo?=
 =?us-ascii?Q?rx7bPnMqVQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d681f2-bca3-4771-7a5f-08de8899526e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 05:02:03.1672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +UxHWHO9YTruub+rmKEqxg5h8EXHgNV+4OOSr+9GAHCN09I1EeAOoaDbcauov37hirFgKmWhX7JpenKlQ8lNig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7543
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

Please pull fsl-qoriq-next-2026-03-23 for next

--------------------------------
Kconfig update for SCMI_FIRMWARE
Add SCMI pinctrl driver
--------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/29614

Thanks,
Peng

The following changes since commit eb00c710508d09b2a3b9aca75dd18280f1304703:

  Merge patch series "bootm: Clean up arch-specific, pre-OS clean-up" (2026-03-18 18:36:50 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git tags/fsl-qoriq-next-2026-03-23

for you to fetch changes up to 0cb160f1b62905c701569850d3a4d1b46b3dc100:

  scmi: pinctrl: add pinctrl driver for SCMI (2026-03-23 10:58:20 +0800)

----------------------------------------------------------------
Dan Carpenter (3):
      scmi: pinctrl: add pinctrl message IDs
      scmi: update comments for scmi_pinctrl_config_set_in()
      scmi: pinctrl: add pinctrl driver for SCMI

Tom Rini (1):
      scmi: Rework SCMI_FIRMWARE implementation

 configs/amd_versal2_virt_defconfig        |   1 +
 configs/r8a78000_ironhide_defconfig       |   1 +
 configs/sandbox_defconfig                 |   1 +
 configs/stm32mp13_defconfig               |   1 +
 configs/stm32mp15-odyssey_defconfig       |   1 +
 configs/stm32mp15_defconfig               |   1 +
 configs/stm32mp15_trusted_defconfig       |   1 +
 configs/stm32mp21_defconfig               |   1 +
 configs/stm32mp23_defconfig               |   1 +
 configs/stm32mp25_defconfig               |   1 +
 drivers/firmware/scmi/Kconfig             |   1 +
 drivers/firmware/scmi/Makefile            |   1 +
 drivers/firmware/scmi/pinctrl.c           | 365 ++++++++++++++++++++++++++++
 drivers/firmware/scmi/scmi_agent-uclass.c |   4 +-
 drivers/pinctrl/Kconfig                   |   9 +
 drivers/pinctrl/Makefile                  |   1 +
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c    |   2 +-
 drivers/pinctrl/pinctrl-scmi.c            | 365 ++++++++++++++++++++++++++++
 drivers/reset/Kconfig                     |   2 +-
 include/scmi_agent-uclass.h               |   2 +-
 include/scmi_protocols.h                  | 379 +++++++++++++++++++++++++++++-
 21 files changed, 1128 insertions(+), 13 deletions(-)
 create mode 100644 drivers/firmware/scmi/pinctrl.c
 create mode 100644 drivers/pinctrl/pinctrl-scmi.c
