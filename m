Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F88DCD342C
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 02:12:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56FCF8490D;
	Thu,  7 May 2026 04:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XM/r81Ot";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C28E849BF; Thu,  7 May 2026 04:12:01 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E8E984903
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 04:11:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0/eR1B5mqVqhnJ//ERCaZk3B7mqkoE2Kec40h19szkGMS2Vq49YGmdDW3odH48lcOc4AFrzv1pBNF9TjzdlU+lESfY4c3tC+IEjNbxaJFitIIKOUfBtRmw7sqOESz3ynw5b0gXrg8eiVDmE24MB19R2cPIErIxz39UPtUUEoaBXBgoMkxvc/rRUgobL4uXKuJY8J8yItizPyyyjnLyLbmvPhCOYsX540kB7zhaVIsf52lo+qd3PgxhBMqzZaffwYIWPZaFTugoz0cy+1UhWv5wTR/xJBHTUgP0r7x23ohXpbp/9xS/jSThkk3cDSVUbrpCjyMvsbs+CVRzCOUhsWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xbUZWa59BjvBn1wBl/VQeCWmhUsdbwxg2BTLdqWhL8=;
 b=Cxslb9io83GEXgHjb+guiwdC6QdhFiXobx0hUjYPosHN7Gw78uXgMVdPLOy9sO61s1TpJy/y7yL5fu3RNQZx7dRSKJTLozK3eNV+SnLg5xzBZw5bAk3pPzFXAZgfy5yRx2KDn0gLKEXCk2jZic6CIZZ+jApphB3imvYWfML6trjjICBNZHzcT8YMwRD3VYGAbf9ohZuE54uzd8aJIaPzJ867CYVoo8/TmE+gvWScllDgDj8u+miRy8ncKI8Kde3tOIBYtSqJa2mqOEiICya+N8aStdM06D8o5wI/gTfcYJEy8jtucSoSp0GNdlSmk4Io+Oc9KnhDYzuj5h+InVBMNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xbUZWa59BjvBn1wBl/VQeCWmhUsdbwxg2BTLdqWhL8=;
 b=XM/r81OtgZalJX18kmDYN6K5+DSt+UA4/m965rxGoeRv5+GfXW/M0iny2eBanaQ6+KinnhIAsTGkQpSKvA/CMBKu4Uy7d1lnz0ryf2x/ux4e/KbhTFNstSAmxS9Ts+EAfm42fN9IEl5LrsmWbsign855TjQTLaxw0xjaMdTr6bJplXRy9dykm678exOjA6wPd7FOlISz7w0cN9hKmycWZ5w9TFjNjIEELTEpbwPx1F0AG14Wm+GP7nPR8/UZkdj3Sn5xvxhJKsvYqN4AcO3cYEU+2GvhlL/+35KiH9E+5jV72EdpCbcp8K2iCZ0cCql2MH7At/euNvReD6TMSwve7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AS8PR04MB8056.eurprd04.prod.outlook.com (2603:10a6:20b:288::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 02:11:56 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 02:11:56 +0000
Date: Thu, 7 May 2026 11:28:52 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: [GIT PULL] Please pull mmc-for-2026.07-rc2
Message-ID: <afwG9Lz_wtbOS1g9@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MA5PR01CA0212.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::11) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AS8PR04MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df7dda7-a14b-4f34-7184-08deabde0390
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|1800799024|52116014|366016|38350700014|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: IvGpM6E6CZ71q9CEzFYqAHLXJcc5xS7rkqDFobUajuBVHVLE8GrHKcNGgdk5dqMC6ubqFjUQwBziX80I6Et74MFNSKbTc2TB+djr5r6pgo8HhQ92AX/JCjqMnPlQclRk3/wmMfuRISoZFIzOu8JZjouirsZ9wQ3wtPqFOupY3LKWXGmhL5pXNiXlDejcMQWeT27ZPwVSbIJp+jriEbqrVGHL+Aq2c4IUGzpxUjM3TxMQ58kwX/Ogx2bSgBqW7TecGows7yrauMK+IS4Sv90WqMC6mqYVpGphykKAiXNuLtZBgm3dVZIZHVQXEth6T8qMvtRz6VoucsnWPCLYyK6/uLSjpUtkE6V1pS1kyLXvjP0Bs2qljrIz6FXJOBRtqa6ppCb4XtOiz0278Hv1zKPbQ2QmHDiF45sXtDB2xkzeRDYKImDO4eyNP1VfEOvYjf6P+3wQjg9JeZBWcmhKtZje6BF4snL33TgqyEAjyMndAdGzva30M3uIOcLkeZN3PheFy50sC+imrNw3Afe79zyuKKcGlOeO5yteUeKRJ1eGf3YqUbI3gVLb7tDUdtWRqom+yGiZ6wc0Oi6B/i5IE1DX4CKUcqd8vx4vyHyy7oPyodLRjMDD7wqC12TPyJK7o5re69rzqFteVhXa3Mg3c+QnTYw72hOBwdNaFMy07MdpzFeY0iJ4wuUn+XBKt97TZC0HJbr7vKh5qGCeTEuIKXoALA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(1800799024)(52116014)(366016)(38350700014)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BY0kv6JB+EwcBW2SPbB/7VSPz5ST/3cLLMYPrgbNXzjC0mJdhRCXMGkoTriz?=
 =?us-ascii?Q?U8cgWaCeEW+3VIz3xm/TzogZynxp8jjylyQCgXT9WfYOv4OYdlN6ntknpeq9?=
 =?us-ascii?Q?A5Ls9EiJ0PY5KwYkNiTVpVaW/UPEwhuekY+ttUm7kNkaDq7VSyhoPB9zCE1e?=
 =?us-ascii?Q?OXH5Jv5VxmVXLITs5wTbHTSr2MAVt+2TcZ9iptV+bQ9g+IYTBi9g6Ijbbuox?=
 =?us-ascii?Q?yO8LTF5S0gBhcN0LW1rCyGdqwHdptl+AZz6Kc8ic2mgwOjjPke6pd/zADowA?=
 =?us-ascii?Q?6Xemw3cXl4gLpgwXSA/AT7d2OZ5GbvZROcbFRHZtX/rX6wjfhqwy2I8Tgr1C?=
 =?us-ascii?Q?BD+Zf2eqEyPoxR7k2Cxs+f8iKOYKEuZkPjd7+6o3W/LVAP8Z9EMIK3XC7L2k?=
 =?us-ascii?Q?eOvJfGpyfg/HCtuRbPt5TjbO5S0hZn472d5f5m3joNBJ9Aw4Xa4HMxGYtDo9?=
 =?us-ascii?Q?cgIM9jLpr+JYNtSaR/qfdsMAknyQnGgbwvjhfVmxmAidX5w1nQ2aRA24Uc4Q?=
 =?us-ascii?Q?k+30SQ9J0zyLHWrt5Bk5RE6sNzCc7ONId2awifVLIHBb2SfgzFGh6ZgYjNDA?=
 =?us-ascii?Q?CD4FWR2JYXfIlBBLm9kkMrE8wrnqo8j5nkTmmKJv9+JmSwAZgJ8z30G066e8?=
 =?us-ascii?Q?Oqbh/b6LxfuM7uoNck4orVJRY2ODDZzHLpHJIpjz0BHDs/xFivOVPF+/uJGZ?=
 =?us-ascii?Q?/3to1jKZcD5QGC3boRO8b+8RiOk4H1y3s67Eqkz9gCfFPsM1/9nO8Z37B4D0?=
 =?us-ascii?Q?+WJ40gD63vZDFIWWoCIKSXevOU5I8HeMo3ewJV3OusQ5YskApPnLkz0Ye8ct?=
 =?us-ascii?Q?3OdI6ePZnh4qqlFhD+S7rHB551wMrh7B0lZyVD6sCfwWEm3Y63742OF6bMbD?=
 =?us-ascii?Q?9cfC1bmsctHD7Fn54aNJ9vFe+9UfPu/GIqPiPIOvL325hSALcvwhrN/cCLZ1?=
 =?us-ascii?Q?l5Oz0V7N4xF/HYCIaPamGP8tbYMcPt/MoXM1ExRSMu3GQk3OY3S4ChbRNuOE?=
 =?us-ascii?Q?gAGB9NA1FeCfrR/gPGKXXVUX8tTH0PPHBs/rhuRhRnOF2WXWyhQbr3bjLWY1?=
 =?us-ascii?Q?diDJpGRIJiNoxq+SqWKWM7Iy1sGsrwgG992UY9N82Gf+o64quDYpKV+uQnqN?=
 =?us-ascii?Q?Ujb78R8TYTO1DrELnmcdEK36vXvQW1EBTC4vIolWHmA6ayD3C/GwMMohYp+3?=
 =?us-ascii?Q?vZJWo0KfnlSzMDKq+QofbURR+DjhmGqjHBWIBgAFvQOTHnTw/EN+aa1roId4?=
 =?us-ascii?Q?68/ypRPSY95H6w3Ggr6hWX2iH241C2n9KWoyFdLx/wmmWnfhm2gl+gBpQEYY?=
 =?us-ascii?Q?mEndcMRhq5GgwtE0qJYEjy7l0FL+l8wugf9jp4jqbufr0WyRwC4cOXnqQGRD?=
 =?us-ascii?Q?QXQelqI2vzIbVtPJnKc6IJOpluhE7qYGvrcNRugIFy90JWN6+8xgNBaib04d?=
 =?us-ascii?Q?5pIEJLMuAC0Z/QS5yNXsSqzAQJ2Vy7xNVmiOBq+C7Gxy8IGLqCdmW9ynxn96?=
 =?us-ascii?Q?Hq0Bhyh1lYhaZB4+CMNRDMhzTQtIsYoPVid7gMsLlDzFuKNrgiqGrFYaQ9K2?=
 =?us-ascii?Q?SS03t8nU1G75ji4VJqac2eqrcaMRuJSA0uqBZ4HoUt7fGa48H9O00ZZeXhxH?=
 =?us-ascii?Q?EZrBQRd2GeyDCaPpOx2ljfVQF0rAMU51DHEFknmzPUVPgWfqk1E6okFe0WP3?=
 =?us-ascii?Q?bnilgf//vzMPORYelY/FMoKMQ66x+wXF7u8MqwWUuCDaH1AoSRVSvBQLyQt+?=
 =?us-ascii?Q?cWOy0LtguA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df7dda7-a14b-4f34-7184-08deabde0390
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 02:11:56.5233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYbDAC9yg724ZkpC+6BeE0BYhKwgmZ+dyeV2nUrcAvAFqCpNdAIcmmz+8yy0NcrHGZVshKp2y8X7g0ZTiHj8UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8056
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

Please pull mmc-for-2026.07-rc2 for master

-------------------------------------------------
Enable FPWM bits for tps65941
Use max-frequency to get clock rate for msm_sdhci
Fix and update for pfuze100
-------------------------------------------------

CI: https://github.com/u-boot/u-boot/pull/958

Thanks,
Peng

The following changes since commit ae8987f4e690f397f507c4b1efabd68b3ed08db6:

  Merge patch series "binman: Fix preload signing with encrypted FIT" (2026-05-05 10:37:16 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mmc.git tags/mmc-for-2026.07-rc2

for you to fetch changes up to f07c15c16a1bbdf8eaa9ad79af774e31948bcba3:

  mmc: msm_sdhci: Use max-frequency to get clock rate (2026-05-06 10:20:30 +0800)

----------------------------------------------------------------
Neha Malcom Francis (1):
      power: regulator: tps65941: Enable FPWM bits

Peng Fan (4):
      power: regulator: pfuze100: Fix min_uV usage
      power: regulator: pfuze100: support high output voltage mode
      power: regulator: pfuze100: support non-independent mode
      power: regulator: Correct Kconfig for PFUZE100

Varadarajan Narayanan (1):
      mmc: msm_sdhci: Use max-frequency to get clock rate

 drivers/mmc/msm_sdhci.c                      |   3 +-
 drivers/power/regulator/Kconfig              |  10 ++
 drivers/power/regulator/Makefile             |   2 +-
 drivers/power/regulator/pfuze100.c           | 164 ++++++++++++++++++++-------
 drivers/power/regulator/tps65941_regulator.c |  15 ++-
 include/power/tps65941.h                     |   4 +-
 6 files changed, 149 insertions(+), 49 deletions(-)
