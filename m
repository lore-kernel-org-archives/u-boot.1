Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A7FCD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 08:18:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C2C5836AC;
	Fri, 15 May 2026 10:18:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WDm3LSSH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D20B838BB; Fri, 15 May 2026 10:18:51 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA2068341A
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 10:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLU6cdN7l0EtNWGkFrUoqF3squWu7VGUNpfuYpgwb8OuQC4p20mcUf+yiTyvl8v1wU41NjcwbbN8UeKGQmU3jXzjutChBLwFTp8988U8SVWAw7SIk9uEl43PHehufxxrZzcT3WLP3NfVYV7khl85Eqr+XKk9cuLb1XBPBESlFYr002YHSgEs1eyXEs5YE6Z76QS08ZGR/rFY/H5cuM65RpZSq8u2LRVVOzMA/JfMKwI13OGS6Da6UP6448sHMXVRdOifYrAPXv+WslN9XBGvWQp9RGC9tk/0EJRyeve0zbxLHvOynCKMP4cju06g8MXVXclTR7ccswdwTaYu0hFW3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXKoc9Bf3mTr6DBN8A01FQkqdUwGDgLfwmsz1/idE7g=;
 b=Llpz8FfqwKvxPaJsdVcSrUBfyGA3e9zotf9twwCLA5vDSEVWKPWckOZDJofzERKTTaV8sflSxY6LqCzd01yaTG+VHZZ6shfUW9k0xuoq8f5B3P+rSZ0DAU055Sf6ITx9cb1vlXGfPdUPx90u/R7vIav2P2qJfvbs2jq8NkHjNXRafq28f00y1/nCxemBwkn1kcicy/WNTUKXhNC1OeTxq7r116Z2ZWRg38/RfFsjYqrEaFi+Noor7tbAwvKfk9TL6dlQhsQryDISdT/tSDkf3c4LfOt7bH5x+0KU61o/F/DqBH+zF+5caDmhD0/RMTyvrdtGdXFcM0Jnmui0MriKFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXKoc9Bf3mTr6DBN8A01FQkqdUwGDgLfwmsz1/idE7g=;
 b=WDm3LSSHAV1dBBaeCspe9NZu5rR++40g1T1uMzLLTTzgd9jiAJSqZcYGOy+Nj2sYrJf8V5bZfEaLROqxMVzMebPxQZ2mJZ+WYPXvYvCx5o1w8ucMt1v6u4WxPD5pUksXSs0DRA8c8RWbQpPh+qXmv8ch0G8jjtKtKkgwCOCZIvFTYgC7DQN9zyIJcU9j4/FCiYaQd1f6KpD+DkDq8+jbf+yjdJcO7OYywXr/TIsnvKnizk4sNTIOPk9gvzvxlnUUb7lP07I+wrOpKaxAbIAhbyEnCn5yE1L8BaXl7kERYEDXKX20+VCY3lHgcCWjdPqxqsK7Mt2p/SnBn1pvh//L6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by DBBPR04MB7738.eurprd04.prod.outlook.com (2603:10a6:10:1ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Fri, 15 May
 2026 08:18:46 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 08:18:46 +0000
Date: Fri, 15 May 2026 17:35:56 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Hiago De Franco <hfranco@baylibre.com>,
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>
Subject: [GIT PULL] Please pull mmc-next-2026-05-15
Message-ID: <agbo_Frbw1gfzQ2B@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MA5PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::15) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|DBBPR04MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c1c06c-983a-4fa2-2504-08deb25a95fc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|1800799024|376014|18002099003|56012099003|38350700014|11063799003;
X-Microsoft-Antispam-Message-Info: GXFwMy4bcnYi5LXgpFyjccaCwGjBz4Gfcg+iOx2VDMPqio7dl1wUkgts8cQCO3QuBDCkkUGZ7cEKMahzHON9zQKCiBuA5I10MHy+Wk+yxA36P9SydqHOYVF6XYauJSUnOXuE+bWvpKHnLOkIscWtdpWBLEC8qVfXE39tjFxZW3Vh04clpAYM6Ay+aF5kNVYbZUosoJHkSIN9RU5jsvI/a84Bf/ZRMbttLTV2KaWWg1IxUhG8Ln5Fq+QA0WGZYS8A5nNaf8aEhy3W3ULVtpKKh6CMSshnaqxGzDh5qy+K3/IxeaC+xSp1i2e3TYqUILyR1Kxw2sJ5lYl9PUEKw3rs09vb5fwIqaTRTrGD56lVw9nMr5UCxUbFVOOzHl6Kj+fnGzTXHaXtSZrqfK3pnNP/L39OfJYs4YRhBRbHFqe7MNnb3ceyDuT4/zLW8b/czV1l4VYNO19bLV1E4U2kQ4dKTEERJEI2qi9SLLf6GiuBhj6JvvRiPg5aXO+ElXti423bprBYVQ41DVtbf1bPEkf3SkVqJVmQjNAdkNQz0vLBcSivTNUgRBAhyRidrNQz4LS9eQVTIn+gXC+70KNA+ymfpn5lXU1pR45rWSLdFVxCbLF0aKoczts3m0VHhJqsVdby1lYIAG21nGhOl5uerLnQx4ZpHNykxFSbRWW86cXDBs168LGZL532X57OPoE78Z9NZjM4iM7IkctWrUjhfV80zQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(1800799024)(376014)(18002099003)(56012099003)(38350700014)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GW+MxHtPqxD/pRPqBPM8SDkIYWQPcfdD6nM3DrXVvxS9Uym1yiWpwjx0WzHq?=
 =?us-ascii?Q?v7n/ognWGG9mf63I8fw0wUDF375B1LCzIXzTcBW+x7tSPJC20TcXtmFM/+Wa?=
 =?us-ascii?Q?AKeDZ/QeygStVtNdhVsrolvj6dWMqBAFGgPcywhCcsJArkueBs1fVzR60jmk?=
 =?us-ascii?Q?DM6VvfRh7Bog1HuPcQPRTkq7oRuNrOyMJdayAMjVzfPVoeKjAfcggLp3zAfo?=
 =?us-ascii?Q?mYhfwg8OVZ61m14CwesGXF8BXW1WIyZkGEDJTO787V1n77fpzXWjbF7mJbgO?=
 =?us-ascii?Q?lcROVU5M7X+KNs2DJvojafs3kWp7e700j5F7A9pnUpnf7xNqej+AiHyZ+FjA?=
 =?us-ascii?Q?fD5AJo+4k/oACduLyWgJkMTFeYT1FK7XChxQsv9fWKVGQ1Bv+jz/ftt9WJh/?=
 =?us-ascii?Q?/IalAx5e8nlPGDbPw2nx/CVEnvwqBMWMK2tGiJm/T/QLqXAu9pOyyd6qdgVd?=
 =?us-ascii?Q?N6Umk+R6bmcGhByOZ/leZ8eLjFE7XykgGFxOiTtrLjCx8DctOyHB/rcE4ZuV?=
 =?us-ascii?Q?zCrntGdd16Wtji2aV2N/O7rc9PJtcXCdSi1LeMMzFpaMG5Ekw4cbcvKRRwNM?=
 =?us-ascii?Q?rRGdLgeowzb7aJmWa7zWzbjS9bHkO4ImlLlKo6e6DqMSurZsTdlY51hiSh0K?=
 =?us-ascii?Q?9PAlP2z4gcfbvtYOBr7gNgxRlY+UJc/MztayhPOkFTre5WmkC0Vynjm9E5Up?=
 =?us-ascii?Q?dzwREfhnuJ5MQUx8T5PPwWFNex7EiB8uQKPBJeWrE00hhzSL7VLmPWGcs2TD?=
 =?us-ascii?Q?Wc355Vg3zs6G7E3fFJYLrlygQzaPMdj0fHV449TMMcB8adBDBn/Nao0x6hiH?=
 =?us-ascii?Q?PdLfJ+fIzZmb2HrXwLweHTG1TNpO/2aVAg7yOrCCdxPmEW2MAw9BYPLzjUC7?=
 =?us-ascii?Q?Ti0VBycC/Fc6oJJpVnCQ+V0+0xCq+WPyGRMO6hoDv1mZCnpz8JBHy4V9HDQz?=
 =?us-ascii?Q?Y5CUuBJks6MX0q0vUlQX+8+0WUaBq3llzk17Yp/WENzyDfD7CQru62DXgoLq?=
 =?us-ascii?Q?M5/k/2MIBVs9GCRZ+xsxzE+HtWXNfS66nz+wweV1nr4ULBchJmWTTt7+B/S2?=
 =?us-ascii?Q?HVjHt48EoHw6xzlvjvzx0fh69lpZnKILdpj1ka4yMu0J+EXVtdv/lRptWYNd?=
 =?us-ascii?Q?hRubfZV9grBgP6Qvx5SmbzhL8Vt7duDEbfYZCSIhFf9Y3yJ+j0EvmiZegTr2?=
 =?us-ascii?Q?Iyq9sPWJAYoLxFNVAOpI8CQsR2hais+m/0UBqzPNck0TAuCGi7C4N2HhTpCY?=
 =?us-ascii?Q?Ab8C33avvFo0sNmA9yKq7bdmnMLWnmYCBMIrCUDtYOnHbUlDTDD+P/QrMQHP?=
 =?us-ascii?Q?PDilWG4BH9GlI319P5zpa103C6mpAWPyxljlCJkqK9dy230aZAi1+r+Rh1fB?=
 =?us-ascii?Q?2NPzYE/d/GrOE6vUgY6Nzj2cobpPOjHc4jLOlRyZLWIDg+iySpioGHcV7gLZ?=
 =?us-ascii?Q?QK2Om5wjIoUanKokNPLfGnk6ZanWimXd/yMv/7SnXEOolyZCSe2P6CpKYujM?=
 =?us-ascii?Q?1cV473EhosRJmPL/m++oggWP1nPJzk5DosAbTTw8tayslyZXt39tEDlMDqEl?=
 =?us-ascii?Q?HpxIiQbdjEQt+ncysG1rEW6hLc001k8cP6/tdaI7BL0rL80MHV+3bD76IOVZ?=
 =?us-ascii?Q?fri9zAIPOnH3ofyqsX0Tei/PKaZJPxGftkKNbnrjz8LQi68CniyZ7eACJshY?=
 =?us-ascii?Q?X1MmtY3GLyD4/3Ihyc+P45kkiG4aWgdcG8IBGoIw+NNoGv4jneJ6tCOgJMhy?=
 =?us-ascii?Q?1NWVDctPDg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c1c06c-983a-4fa2-2504-08deb25a95fc
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 08:18:46.7522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHAEDsIi1fddDSTrGTDsDqZA2CR7B+gomg7fAjXicGvdB4zSGndc5sI9Wi+y5gw9u61lZND8esyeesKaUJ/svw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7738
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

Please pull mmc-next-2026-05-15

----------------------------------------------------
Staticize and constify driver ops patches from Marek
Check 'no-1-8-v' property in cv1800b_sdhci driver
Drop unecessary timer initialization for sdhci
----------------------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/30112

Thanks
Peng

The following changes since commit 88338f9d147397c42bb996937b1ce31bca096626:

  gpio: Correct dependencies for MCP230xx (2026-05-14 15:54:17 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mmc.git tags/mmc-next-2026-05-15

for you to fetch changes up to 77fa442ff51551dfb1bf558b6bf4a8ea2b2ff200:

  power: domain: zynqmp: Staticize and constify driver ops (2026-05-15 11:47:23 +0800)

----------------------------------------------------------------
Hiago De Franco (1):
      mmc: cv1800b_sdhci: honor 'no-1-8-v' DT property

Marek Vasut (16):
      mmc: bootstd: Staticize and constify driver ops
      power: pmic: emul: Staticize and constify driver ops
      power: domain: apple: Staticize and constify driver ops
      power: domain: bcm6328: Staticize and constify driver ops
      power: domain: imx8-legacy: Staticize and constify driver ops
      power: domain: imx8: Staticize and constify driver ops
      power: domain: imx8m: Staticize and constify driver ops
      power: domain: imx8mp-mediamix: Staticize and constify driver ops
      power: domain: meson-ee-pwrc: Staticize and constify driver ops
      power: domain: meson-gx-pwrc: Staticize and constify driver ops
      power: domain: meson-secure-pwrc: Staticize and constify driver ops
      power: domain: mtk: Staticize and constify driver ops
      power: domain: sandbox: Staticize and constify driver ops
      power: domain: scmi: Staticize and constify driver ops
      power: domain: tegra186: Staticize and constify driver ops
      power: domain: zynqmp: Staticize and constify driver ops

Tanmay Kathpalia (1):
      mmc: sdhci: Start status timeout after command issue

 drivers/mmc/cv1800b_sdhci.c                     | 3 +++
 drivers/mmc/mmc_bootdev.c                       | 2 +-
 drivers/mmc/sdhci.c                             | 2 +-
 drivers/power/domain/apple-pmgr.c               | 4 ++--
 drivers/power/domain/bcm6328-power-domain.c     | 2 +-
 drivers/power/domain/imx8-power-domain-legacy.c | 2 +-
 drivers/power/domain/imx8-power-domain.c        | 2 +-
 drivers/power/domain/imx8m-power-domain.c       | 2 +-
 drivers/power/domain/imx8mp-mediamix.c          | 2 +-
 drivers/power/domain/meson-ee-pwrc.c            | 2 +-
 drivers/power/domain/meson-gx-pwrc-vpu.c        | 2 +-
 drivers/power/domain/meson-secure-pwrc.c        | 2 +-
 drivers/power/domain/mtk-power-domain.c         | 2 +-
 drivers/power/domain/sandbox-power-domain.c     | 2 +-
 drivers/power/domain/scmi-power-domain.c        | 2 +-
 drivers/power/domain/tegra186-power-domain.c    | 2 +-
 drivers/power/domain/zynqmp-power-domain.c      | 2 +-
 drivers/power/pmic/i2c_pmic_emul.c              | 2 +-
 18 files changed, 21 insertions(+), 18 deletions(-)
