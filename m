Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B9ECD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 12:35:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A12DE8465A;
	Wed, 13 May 2026 14:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bkhY1Cbw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B31F83E36; Wed, 13 May 2026 10:34:29 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D0518341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 10:34:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4pkWwRulyQSzP2zogG9ILBypTJc89F5ccrY74QlodyKxH2SWM0vTpU9a9BIEFhh2joM12dY5OJsCbhRyScXq4LSMIq8vol4h81bP/MAVMBm5wLnWYktuwcuGibs7R0ffDb/2okGtX4XEnr5AmHGhjuKXtr+nnNdyhZuI3Wz78Qy9rWpz0JkewtlvW1V8MM1JsRaHwVZ49LMhIpQXhY6EcbbFhofQnPuudxWC4HiMf5VTKghfqfpXR3XRAtL4zn6irxgW0cfqhugWY4pfw49rJr2SUThUODv9jXN4QNZPxgiTDKYo/2uZUT8dMyO4ejaOr4+lSdyI/PMDjMGtS6WAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMHfACQUqaLTSLTKBgfCSEJjzN3lvEJG+52su9g9e8I=;
 b=V0jlRfcfOcWYNeObsMnexgLSz5DU59N6OT3NNXjZ5Ek9iO+eXVIZ52cp4wv8mvnNJoqOqMnLay9l93ogjDhZCJ+2cnE1wCFWQ54jeTvblkVmjxZD4BFfD8vwb3Ei1VpqwD1+rgONY3B4NzHACC13/OHQDCrnReqG14bYEIZqvTc5yaCJqWfvQX47K3qNLsxXC7eVEMdGElREzXJ5ueKKUJB4zzWuzTBvSkReCxTn/3tC2iqEmA6kouREEr9NHGJdJ+LxIJ9/fRdUlhv9YsQ0G0+1qtb9NiKa6DLyro9hwAQMkuQLb/54fN1Y1BCph1cdlv/wLa9jvHkRz6h4GRbyVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMHfACQUqaLTSLTKBgfCSEJjzN3lvEJG+52su9g9e8I=;
 b=bkhY1Cbwy9a0GDQJ5ObQUC7VJ2EVjlb67VBOyBa2ZT1UqktQV2lxf2jB1eYtipIIaHfRuHqAL6cdJo6QPZlCpfbGoAp6ky5P0eNRH+z8y3vspnrXgRwWETZEazxfCXDEMfjbyQSqy/OkimyqrwSLmIjygZpngJiR471r0aYxOXH5xK07ZLh6bYxHRLxVtihsLNfg822p8FwRavuZi85wnIbHExV0OntZXp4qsphI8v4kQmjmer1+3By0ToU0ZRh4JQ7ScBXGA4IyP8WuaDpx9sN0hm6o7skhJOpyDFoSJarLd6O0AkgXaFIB9UzB+16YCt70pfTHqG+S5Dmc3F9dSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by DU4PR04MB10790.eurprd04.prod.outlook.com (2603:10a6:10:590::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 08:34:23 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 08:34:23 +0000
Date: Wed, 13 May 2026 16:37:04 +0800
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
Subject: Re: [PATCH v3 1/9] imx7ulp: Switch to OF_UPSTREAM
Message-ID: <agQ4MNlFeEfigjuE@shlinux89>
References: <20260512-wdt-v1-0-0b9e1993557b@nxp.com>
 <20260512-wdt-v1-1-0b9e1993557b@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-wdt-v1-1-0b9e1993557b@nxp.com>
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|DU4PR04MB10790:EE_
X-MS-Office365-Filtering-Correlation-Id: ff1d87d4-bb7d-498a-14a4-08deb0ca6f3c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014|56012099003|11063799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: y0T/d7h/lgUbX3l6uLbI6A5T2RJ/qkpTDB2uu6fP+lYzSOSe9OUUEAS8IvQ5Q555FPKK1Gum348efJ8XpiDxYuKuyXknMpfsAw+tcmoX0JMEWw32wU3MYvKmlP46tuaV1/A0ya7M9w/ZrPAQhLrBENGGQkDcd9IsYQeeUp4/suzh1grqktIkfdHqLoZ25dT4ZSc8/HZpTqn2aFp9oW9cO2SUyCjC0hd4lIHs3UevbzX+JcSYtbXAyAP2OFTmyXCQZYsiIlmCfzZXhvw0+u4J+M1mm40ZyNicpREp7jkSAC2UFPOQ8Imvy9v/Ks2CvulnF5A87OTgwC16UYjDDc7AbhO3BtJ/DQT20buCnPqe3jDfcokTa/E4mrbpp1ZIf1TPG/ec92Guw750pSkKR/Az3NBG04NboV2AfCV8sBG1dRVMyEsAZuicLSOuf8FdZbnjGLsTF2sAZgZZCeh96Vuvqz/6lNeuOgajMIFKRV1J37Y2XUPcxZVo/gjYud4uIzZNkGwLrkigpkBEzo87tXJWFgVGUI7CK6r+FDFim2MAfnGIHiGkRZguz1C4lA2Cl/otL5GcUrSh8DOoSYTPkhKHWX6aYqwoPOztLDhkS+RtC72fL1HEXwpYfSsDe1W4KO13L/crcfH4J1xZOdWjCyzhjCeBS8En+/Q8ov16hTDkdMBvIO9J54oueZVM/9xGTzT6f9fmw/w0tJAtVEHnDVd+5cxUAqqbsTzn0RKeIIMqtsnzkj4QhTHYVISLFOH4M5b5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(56012099003)(11063799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ovUgfY+3kIJcKqIlrri2L0iUBHCjJIkZnSXHsmx3YjtKWx227ngAN+ZFPu/m?=
 =?us-ascii?Q?oI8lAt4M00+V1mpHgfQuCTU9Hp7ZfiGs9PLFXp1SQTeQSz1pKLclGqT6skyM?=
 =?us-ascii?Q?zgUcUIRdkX/lyaayrazFCANelZXGE7KjF7EwnJAqs9fN5YdlwS3rwojbc2Nv?=
 =?us-ascii?Q?7IBnhWEtLrweAGeWfxQy6nnwLRKZeekQUroaiJFPDVZVpSh0QjOAXfELoRXM?=
 =?us-ascii?Q?Af2TcoeIb3/fWUc77ZnkpRjthS+LpMjym2JyNgYaf8Geq6kAUs/I0OIwhLBt?=
 =?us-ascii?Q?zZM1EP8+uZjvDQGm3aMxP0pYQaW/Xzzql0iioHNW/MQi02nCbxOyBUJCIEvV?=
 =?us-ascii?Q?Dh1al8nKnoQvW2EvH4jN1Izx+MbI3SVOWWS1zWYSuDd/fBccE60fiDgHtlIY?=
 =?us-ascii?Q?cBepFFgFBFpSje6rGMK25PS+6nO/WQTFDAMe9e5of6l1Nph+oWwEZEpIPY7y?=
 =?us-ascii?Q?5WmFN1t4LJEoq0PYp2Xk3G69Xgv2UYVCWzT2MAcP3maO7YssC95ixscuW5hq?=
 =?us-ascii?Q?OkrUzaEbZQbrz+oz+C3x+XWTNIRvxdOLw5rJuF7gdJ9Mzt1MxkC4ijB+G47n?=
 =?us-ascii?Q?GYh/dmDbvI74bcZyxBaw8I9qBK8KuEOXSgEyYn6jNKCl/c6fi5nNMvwZfO5c?=
 =?us-ascii?Q?Henmqr1dC8+ygAoL/zFznG61g+LKyv29gwvu91Hw75jj7/b7VvJ+1L5w8Yne?=
 =?us-ascii?Q?lpYHKPTw7Nstrr3uTQIG/iQyIDqUqsnzICPNmqUlGKqsKmV397bMcU0couPu?=
 =?us-ascii?Q?QCwwkfnr0MMl2rHiiszr84u6c4CHDJugD5ZA2pQO5xWtT7REabjLj3bw48Z9?=
 =?us-ascii?Q?zgF4XGyJAANRhEYvFFBFrav4uOSidLHLFWyLaKpxe7t78+2PsMBsyBvKMIrR?=
 =?us-ascii?Q?gcfogFrznSXNZY1qtBKE/b1EetYwjeHMlFCyrpxPYUXsZDUzkA3w3tKNR10k?=
 =?us-ascii?Q?tRavg2RBEaRicBWL8ymDyYRe6gQexNFp7eTHZ6mQh+ejY3P5hzSqOciaHKdp?=
 =?us-ascii?Q?HI8ortXggA3jB4ca8P9XZj3gGq/70GJDl//vM1n8Mj2t7NyFI5Fn6LsHsWkg?=
 =?us-ascii?Q?T+vU/+xP7csDXUSqpCZJjmuCZsTTI685oMj0Jnlnkf/iLhS0bZ8MwEWKEAyK?=
 =?us-ascii?Q?+NLccYR4VbdsiI56yeYWb//Bda+cE5K8Td+jwO+fDApNXRe34ct37prCiebC?=
 =?us-ascii?Q?2FlhxbD3b05GqFb+nXqFfXei3Qe2ZQKMaLOfeD1n/1rrl+elzSzHcPHzrllT?=
 =?us-ascii?Q?lcHQfucd5s5GscaEi7+du6eKdFcEG0SEN1KNfgp4CsytYovPZ6IebPBWYwqF?=
 =?us-ascii?Q?x61soKPnlEfvt4xNxaxTJO+ZcSJikzfKHb9eiwUKOvx03GGswmaZ+FZAyB53?=
 =?us-ascii?Q?uM87LuJr7xRqncBQgkgoHNeNi9grsNyz/cwcoab+ve6k71bCvMHfppQK44DR?=
 =?us-ascii?Q?tClKCXK8BBgRfx5JYJokc7LDyt4VBXwODAZtROCVcH98gdmxQlvaqB1qLCv5?=
 =?us-ascii?Q?+6SRyAraI/32RxAsHu0nvglmkypjycU53j83r8LuK5rxhzHF+W9INUTQO/2d?=
 =?us-ascii?Q?gB6MEkwNrBqtIO9eX40Q5NjRNswqv3kMTY0buEplEB3hwZeHmcuOAqid18Uz?=
 =?us-ascii?Q?LeakBeGxaDo6TeHATjUCUurtxYrRHVN5oYWB/0n7qb+0IEqLxGglRPmKlPj6?=
 =?us-ascii?Q?t1+fYd+tLFAIFJkzp/MibC9qeiYknLetgOks0DW0oWM6otyDe7ZxM155aCXM?=
 =?us-ascii?Q?RBibsfM/Zg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1d87d4-bb7d-498a-14a4-08deb0ca6f3c
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 08:34:23.5689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZbKpezZmbLK+wRfu0n9fcYvheH9cYvaKI/u3TBIhSlXqukdFd+tJ/7ual7iYnUWPa5OvUHqWgj/qwFYSGUzYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10790
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

On Tue, May 12, 2026 at 11:10:08AM +0800, alice.guo@oss.nxp.com wrote:
>From: Alice Guo <alice.guo@nxp.com>
>
>Migrate i.MX7ULP boards to use OF_UPSTREAM feature, which allows U-Boot
>to directly use device trees from the Linux kernel upstream.
>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>
>---
> arch/arm/dts/imx7ulp-com.dts        |  79 ------
> arch/arm/dts/imx7ulp-evk.dts        | 133 -----------
> arch/arm/dts/imx7ulp.dtsi           | 461 ------------------------------------
> arch/arm/mach-imx/mx7ulp/Kconfig    |   2 +
> configs/mx7ulp_com_defconfig        |   2 +-
> configs/mx7ulp_evk_defconfig        |   2 +-
> configs/mx7ulp_evk_plugin_defconfig |   2 +-
> 7 files changed, 5 insertions(+), 676 deletions(-)
>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
