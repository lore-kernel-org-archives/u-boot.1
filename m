Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245F6CD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 12:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B0C5844BF;
	Wed, 13 May 2026 14:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LR9IDpoT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D27C083E36; Wed, 13 May 2026 10:33:54 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECC478341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 10:33:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWKWrKAbVbfUEOlcIL2j0nldLwRYxVk+cWNaHVNUsgNbZlHBKxYNHXRPhSIgIcsvb2O98CmKehzQDA04ZS6TSgHybGEXNppuQqlm41OcPHBWFfn/WVErp7MwrSD0rCtg8qXzVs6HfIHuoJXCfXzhJfMKEJXE6beQhx8bndc+gc3mu4qEHROnmZJiYdEssnm3P/Pahbj72UohYavCFq9QRnVXckEwZjuwcIaH9ek2yIa4fIinFo/e/K56rFjHohdjZnDS6Bg+WxsvALzgPyN/t8ZnKRZvB8iQtmhIy1ffh47yhFnU9njdj05vBIdWwvLsuqrzFXH9H6p8rQDzXaE1Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AtJlJVGlaiz8WMvChazACygQ4WwMFFWiq3dLilfqeo=;
 b=e7rTNX+BmxKPgdULQvxGQ1oxzOvcY5g154LxrBxOlxNanbslchnGX4IU8Tr14hxKtcbi5851yEZiFos4Zm2MIPF+yUwzeI9Z5919shSQeBY7tzPAVS+FDfx96wbWW9rHkH7jen81UknvDlTbNMQu6iMu50hhDTYfK1DCOzj7KV97lBA/XKyX4zTrYn8WVS1PJO2xpbBYGnYpmRGSBvCsInrfWJC6vWPNPlm61BQJy1BsOpSAgf1NqAqlqnA/nBRXi+qQbaY6vTNeSXvC49tIZPmQSxbfrkb3FSmjULzJrzjVfZYKp1/QW5MjXGAo0bUUemIknLFsm+FukWwQOem3iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AtJlJVGlaiz8WMvChazACygQ4WwMFFWiq3dLilfqeo=;
 b=LR9IDpoTR7gzUTVYFjUz00aDczxSu87ctU2iu5rzodQrFTMN2vPtPU+oxTpxeYlbT3PLHhN/6j//fw/OeJuK7EEu1FBCZeh3g8MK0QP76WOHZQ+4+zR9oz6UvarZUDe/lvFT0zjbgwVu1ZEh6PwpdsA8sPjkVh534CE0W+3x2GMaHiWokFHTyvZpvs0faAvkX5mz6ZcHEFO2kz+dpa+D3IbBu/kCRqQVUjjUN6xqZiYgG9+t1X6BY9j1eM8sFD4VpgdtVNRAzjPvprJKK+6esq1tuz0gqP2952C7wuUKmhgYUbd6LGpVtKmWRFVWHzWiTHsnptsJrMfT/Q4SFLInNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by DU2PR04MB8806.eurprd04.prod.outlook.com (2603:10a6:10:2e1::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Wed, 13 May
 2026 08:33:50 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 08:33:49 +0000
Date: Wed, 13 May 2026 16:36:30 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joseph Guo <qijian.guo@nxp.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Francesco Valla <francesco@valla.it>, Ye Li <ye.li@nxp.com>,
 Primoz Fiser <primoz.fiser@norik.com>, Jacky Bai <ping.bai@nxp.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Brian Sune <briansune@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 Hai Pham <hai.pham.ud@renesas.com>, David Lechner <dlechner@baylibre.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Ion Agorria <ion@agorria.com>, Paul Kocialkowski <contact@paulk.fr>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>,
 =?iso-8859-1?Q?J=E9r=E9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Lukasz Majewski <lukma@denx.de>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Wadim Egorov <w.egorov@phytec.de>, Martin Schwan <m.schwan@phytec.de>,
 Tim Harvey <tharvey@gateworks.com>, Simona Toaca <simona.toaca@nxp.com>,
 Franz Schnyder <franz.schnyder@toradex.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v3 5/9] imx: soc: Get watchdog base addresses from device
 tree
Message-ID: <agQ4DkOO0M42nmki@shlinux89>
References: <20260512-wdt-v1-0-0b9e1993557b@nxp.com>
 <20260512-wdt-v1-5-0b9e1993557b@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-wdt-v1-5-0b9e1993557b@nxp.com>
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|DU2PR04MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: 052c8e8c-ec3a-4a48-cb6c-08deb0ca5b6a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|1800799024|376014|7416014|18002099003|22082099003|56012099003|38350700014|11063799003;
X-Microsoft-Antispam-Message-Info: 66AbXaMpyFqUU1nAEmWUxmhX1TS/A9B82kYLvuHViWV25JJi+UfD3iEPMUpkyz0Hk7B5paVZpScJtNoD6PxYOkxgcE720IlsnCrTBWJj9OCFoQVklMsF6wfCJPoQpidvTILtcYfSiqhmshqzd3yHP6IcL3F8V1fWSYnzJRAQT51zqwOQYtgrn0Bu4uAYrL0MjK098GtK9kjC5rjoaiv6ADjeH1jJnL4MHhCfM5CBXl8/AS83zpaQ3hzi6Af45GyRGzKqIfXae27gSpC9dLikbPBG2A/ghWnwMRaUXThIudw3Kwo4oBErLn8SefytScN5WzM7GQTrh0+TdiVDwicOLoLbJ4Zcs2U8gn7MBK56o4pmqm6uH7CFJLE7i5vs2nVYtoh9twb0ByAQlep4rJ3pyiUlBHXfiAo46gRhP9QtmVmlTGa5zWCR1eKDPUYFx9MwhTtP6zup+OGVD6hFtDr96lKemnDgsz3u2AwBEXYiimbDyIvfaepjDKhntMHkef0ewo+ez8UMXNG6oqaOoAI2lDpfWRUFk/wgt99HsqDlFP159wCsHnerrBy4R+WKS4y/lyyyaugFGj11Lhmh6r5p9LixIMmlQHaHo7QVhA9FZoUabtErxxI1++8dx+rrse0/3GDqWQbCelEoJh5eyN28tWEhykLePXo33xSe/a25IOo80M3BoGK1EwrVlXfSQuABnrvhJvsZ6i5BqvhNwvkYaBHqevzoPrd5EHAaSgnQmySDlXpaeSd+QWCFy3QkAK8y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003)(38350700014)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zob/oxuM/h7CYg2QECR+VdnQ0mGuG42wTXg1QWWizh5CrVYTrbnr8L4DT+mf?=
 =?us-ascii?Q?PLXCskcH+ktPwn1gZUEiG58o4vF++3tXCfHA7Lpe53DTkkAUHQUtGQyGbntJ?=
 =?us-ascii?Q?EEOq5BXx7mdi0WPzudA1ok7GmqmMWczKv3/p9yxY0gpYdzcckdRMht6lBubg?=
 =?us-ascii?Q?dOJesko5lb3+SK1e/HKG1amEAV2JJ3K0o6LFq4+TcGOycudL3pvrlW8izkOH?=
 =?us-ascii?Q?eS1cHc7gormQW4ts4quovFiMin5SdkJm9dEWOEonrbi61vLtWRm3sVceXEUu?=
 =?us-ascii?Q?geKf90NNzTXMmXhd8w1xhGNeFWyVtLxlvLkFTpdddpxW0yRdt+jWYW8V3cSr?=
 =?us-ascii?Q?ox3j5Q78szKXkgzswJ/GH3DgLRaE8Z9OvXwkYWdmecEs6bJ8i645PJjmFamj?=
 =?us-ascii?Q?BDgO8YgGdb3Ezu85/vKU17ZhBWR53d+k9AqfVKg5Kqs7ITdhl8oLdEzeR14x?=
 =?us-ascii?Q?WHRHxcj+gUg+HZGaq6xVgFy8jOdowjWVTPAripoIqFkd3IhoDjdTwqWddczI?=
 =?us-ascii?Q?WWjHVNFQMC5+PF83sRtUrmLMkivpMPa5GqclWZMOK3XxsiLyW6H14Cl3FLzr?=
 =?us-ascii?Q?5nkhiW1zMJb55+u7wi6YZYj5yIn4cDLFxd6U+XzL+XKpLwI9vNbyQ6BK1LE9?=
 =?us-ascii?Q?FBqFEXwhlVfjKdb7LD5cZo/Xuw/IReZZ1rIfCQG+ZBEBgC5eLDR3Em7snd3D?=
 =?us-ascii?Q?87vI6fY4QXATARzWjMckwLvtHx4DoLIjCCJEq/qMaVkbYJ7UPIA0VKnhmEYn?=
 =?us-ascii?Q?TSPlEAlb5Xa7iGXAit4YNOW4mV1j0PMc0Qszlfc2xdWYqXaUVP8qa3FBv0/6?=
 =?us-ascii?Q?0OgsX6j4fO4L+f8T4xwF8g/V0MYh1mu7sZcw7+XkWr1570DPzW3bUkP3cRJa?=
 =?us-ascii?Q?mBj62TXCjKkMZ2qMrCrQtBbuwRMs0aEAof0r5ZUAA73s9XUNef3LbG/SlP1Z?=
 =?us-ascii?Q?4E+vF20SqwSvcFTGFH6Wlb7xjuBQTYbKRvc+z+cCnMDUiNy5ynlV8qcwqNUK?=
 =?us-ascii?Q?1SIyzqzSuRJl8kc4KypByR9HbZ0x/ctgAIPdc41bhx4+T0DL1y6gKqiN0qGA?=
 =?us-ascii?Q?qkzCjOTLOAQfZcsaHkrNL8RgaE7iPmItBddFkU3RLZcpRnatmR38DicX8Ja8?=
 =?us-ascii?Q?A7X/dtIm3FJZYB+FZ9DvcyA3fWYHddGMZUN4AnpXVbiKV/Zimez+Bz4F2OlV?=
 =?us-ascii?Q?kuhbs8QrJuHq8eMVOtcXdTTGNsJFFiTJu0jQHc/ZFPf4gT3MVsMEj/ZspLjo?=
 =?us-ascii?Q?J0+/SXzI8FqvcLf7C+ZUBc/N2da42EKmkelUesWtLMr+Rs2KKeso9UDUyruJ?=
 =?us-ascii?Q?txSznzUCeo9SoGqSwR015ztpbgOb0PQ3Xkdv8u/VxY2seNzR84p/nt0uzjKN?=
 =?us-ascii?Q?ldS54QVZUNLsT1YFZ8RZDdqn/u0lT8pNdea2ltDc18ceW9Av2EFKuxaCKaUa?=
 =?us-ascii?Q?ncF/bSdqwykj97d+ZIGs6R7uyBbkhEq9nZHBL7ImljrHQQlH+tyYR6Ceb3a1?=
 =?us-ascii?Q?HIbEOERyuXvzlpMsZ/49ezQIU2ETOgKQgS+HpHrAUNF0TCz/+ujgEz9W34CX?=
 =?us-ascii?Q?F/6wAOEBfuUlkfJuqI7g0+gs7alMAO7zCNUfC0rg4tdqV49VCR/p02xLxwHA?=
 =?us-ascii?Q?sz7u95eXuE14Tf94zPPHTPyoBi0o83KUoBf0a8HG1pc7DZ2SBbwRiHt2hK22?=
 =?us-ascii?Q?pxjB045DH2pr80BLsNb/jQ8xY4sGmQbe5PLMr/Sp9xgwD1eEKAONqNNVQLIT?=
 =?us-ascii?Q?xUJ86LIAig=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 052c8e8c-ec3a-4a48-cb6c-08deb0ca5b6a
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 08:33:49.8625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qF+EPk+5tY/nzqbl/l3qd1pjUopxgVxUvYJA5DJliYfjllldJsKw6HFCPvmHtm7Ck5Csfspj60QhZ8efRcBHIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8806
X-Mailman-Approved-At: Wed, 13 May 2026 14:35:03 +0200
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

On Tue, May 12, 2026 at 11:10:12AM +0800, alice.guo@oss.nxp.com wrote:
>From: Alice Guo <alice.guo@nxp.com>
>
>Replace hardcoded watchdog base addresses with dynamic address lookup
>from device tree for i.MX7ULP, i.MX8ULP, i.MX91, i.MX93, i.MX943, i.MX95
>and i.MX952.
>
>Move i.MX7ULP watchdog initialization from s_init() to
>arch_cpu_init() because ofnode_* APIs depend on FDT, which is not
>available during s_init().
>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>
>---
> arch/arm/mach-imx/imx8ulp/soc.c   | 14 +++++++++++++-
> arch/arm/mach-imx/imx9/scmi/soc.c | 15 ++++++++++++---
> arch/arm/mach-imx/imx9/soc.c      | 16 +++++++++++++---
> arch/arm/mach-imx/mx7ulp/soc.c    | 24 ++++++++++++++++++------
> 4 files changed, 56 insertions(+), 13 deletions(-)
>
>diff --git a/arch/arm/mach-imx/imx8ulp/soc.c b/arch/arm/mach-imx/imx8ulp/soc.c
>index 1ee483065e8..ec85625ea25 100644
>--- a/arch/arm/mach-imx/imx8ulp/soc.c
>+++ b/arch/arm/mach-imx/imx8ulp/soc.c
>@@ -343,7 +343,19 @@ static void disable_wdog(void __iomem *wdog_base)
> 
> void init_wdog(void)
> {
>-	disable_wdog((void __iomem *)WDG3_RBASE);
>+	ofnode node;
>+
>+	for (node = ofnode_by_compatible(ofnode_null(), "fsl,imx8ulp-wdt");
>+	     ofnode_valid(node);
>+	     node = ofnode_by_compatible(node, "fsl,imx8ulp-wdt")) {

Use ofnode_for_each_compatible_node.

>+		phys_addr_t base;
>+
>+		base = ofnode_get_addr(node);
>+		if (base == FDT_ADDR_T_NONE)
>+			continue;
>+
>+		disable_wdog((void __iomem *)base);
>+	}
> }
> 
> static struct mm_region imx8ulp_arm64_mem_map[] = {
>diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
>index fbee435786c..365891d1d1a 100644
>--- a/arch/arm/mach-imx/imx9/scmi/soc.c
>+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
>@@ -786,9 +786,18 @@ static void gpio_reset(ulong gpio_base)
> int arch_cpu_init(void)
> {
> 	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
>-		if (!IS_ENABLED(CONFIG_IMX952)) {
>-			disable_wdog((void __iomem *)WDG3_BASE_ADDR);
>-			disable_wdog((void __iomem *)WDG4_BASE_ADDR);
>+		ofnode node;
>+
>+		for (node = ofnode_by_compatible(ofnode_null(), "fsl,imx93-wdt");
>+		     ofnode_valid(node);
>+		     node = ofnode_by_compatible(node, "fsl,imx93-wdt")) {

Ditto.

And same to other changes in this patch.

Regards
Peng
