Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EADCD5BD0
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 12:31:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78CCF846F8;
	Mon, 25 May 2026 14:31:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZucSC+aA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84B91844CF; Mon, 25 May 2026 08:11:09 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 238548405A
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:11:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRM+QT3KdyIEu2LAMxzqvBRFc9F/NBrKyzTQkT7Z1aibCFQ6AyKtNkoCyJ/swpfM2Vng39DYzXt3M6D7YnZEa3iqABJ8EZAy+yB9KJmHVM8ZPZZmr0ZD3eJftyZjJ0N+ztMxEjY9oH3YWF4ADMyc4VSAMMa75A7OYIWsha+qtRfUSyx754zOp6Lmrhg3LaewaABLh46kuw2ZwDvpXhuaBLOj6R6CD8ghWQpBdFWYbnOXM2M0PHGzjb1DxWOsvXMqwGJZHs9ebKmsCChmNKQMlJPXA5+diI0AWoqJUIXMeHK7ECtyeDBfMwg7r8w+6EHNWmAViO4cWJ5lVzjP/9Zwkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxGWvf9FLOSQbujxZSct/zqxY8/CqDX8rVg6a43tbxE=;
 b=YXeEyfuJCHejLtOFrLqNf4y4ApvJH0OIquBN+EvzGx61lHZSCgoZWne0su8+KPbme513S1ban/JxPFAg00hXBVRJYZCpTXkYbKy7FXK598Ul9bjfhsSnoQlatTuQuCIu4wAxjaucRQXMG6cMF3kPURh7k9abui2xXPhM6V5RJ87pn4pS91t1YOBK64d7sNVbywWCuITn77NExvXkPr026r26ONCApMbS3w7Rx2oPg9kndVmEwpFUEBxBxUfAgw5Fq3EqVmHsOB+5HNMYcvbMKOZQZpxrJhSWA1o6w7h8aOiBQPuNOJacSKl7rTvN3RSc47QvU4E8mC4dVMo3JUAkVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxGWvf9FLOSQbujxZSct/zqxY8/CqDX8rVg6a43tbxE=;
 b=ZucSC+aANDM1H6Wv41Qw+CVNaxrMM6JvSVOAMOdGB4pkPt6m+SNhfhiWOenVp4Lh9Y3zpmLLExbkeH/naA8IEoZGefzQfXzDnRMNU9KoHVzx9yKh0UeBTUoarisxR5xG0xTOTbFWgECBkO/6xd/x1hTctl7G0e1Rw6ZLQK8PMhPRrEdevDRfuXzPWMVIMru1iROn3lN7JKaLSzKLf94LLFJVC1DM/aj/vGX+LO+pV6mKkNKPwFbbXU7sE5Mz/GjAuDAvQaoBTKRToaQOdDu9OLO4rp/kuo3hxLtCigdG9YTHlWSCIL/NhuQ19qOxgy5Pod8iRTSBM9Gc0UgLx2f+pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by GV2PR04MB11797.eurprd04.prod.outlook.com (2603:10a6:150:2d0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:11:01 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:11:01 +0000
Date: Mon, 25 May 2026 14:13:47 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joseph Guo <qijian.guo@nxp.com>, Francesco Valla <francesco@valla.it>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>,
 Primoz Fiser <primoz.fiser@norik.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Johan Jonker <jbx6244@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>,
 David Lechner <dlechner@baylibre.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Janne Grunau <j@jannau.net>,
 Paul Kocialkowski <contact@paulk.fr>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Brian Sune <briansune@gmail.com>,
 =?iso-8859-1?Q?J=E9r=E9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Jacky Bai <ping.bai@nxp.com>, David Zang <davidzangcs@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Fedor Ross <fedor.ross@ifm.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Wadim Egorov <w.egorov@phytec.de>, Martin Schwan <m.schwan@phytec.de>,
 Simona Toaca <simona.toaca@nxp.com>, Anshul Dalal <anshuld@ti.com>,
 Franz Schnyder <franz.schnyder@toradex.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v4 7/8] watchdog: ulp_wdog: Use driver model for
 reset_cpu()
Message-ID: <ahPom6n2lF1mCgwe@shlinux89>
References: <20260519-wdtv4-v1-0-deef133b81cd@nxp.com>
 <20260519-wdtv4-v1-7-deef133b81cd@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-wdtv4-v1-7-deef133b81cd@nxp.com>
X-ClientProxiedBy: MA5PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1cf::17) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|GV2PR04MB11797:EE_
X-MS-Office365-Filtering-Correlation-Id: a5dea730-6a11-4232-b3fe-08deba24655f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|7416014|376014|52116014|1800799024|38350700014|22082099003|56012099003|18002099003|6133799003|3023799007|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: FJvz8qXV+FF7W1Lmt+Ic3DyqTO0bwa6gG9VJhOoxt7VMvweN1hVAAfalQOQUPN0lWqsRu2fyPJB3+U9fLzfdLAlJJktyuyun/UUp7KcQd7QwalrE/NLFtcNPW7eRhmT/NT8o2QROXIVXvpgEhVunzLbrDsZFjSQjfbEIcnoV9mXeLNLUe6olBIwzhWr2AW1mGLQYT1h5T8E2oEgcTKUOHj5WY7vNbXQvJgl0vpA0wrXgoiD1bSy9dJElaCnawI6wER6P4dcWxaA1D7IM36wFzROMKOkKe5OUUBBpzycRCpZTqMvEuklcrTx2TLG/jHWKW+0iZ1K+l0wgdNDdvpEBro/mrvY3RocyHYh/RUy+x1uTTRub+pIU3duS6GnLkpl3hPjmB0F2PpCLwpwZaw7snMiZDjUx1CPfZWR4V8uloK8YwBybqYDSwYU8z6Ri44QX1WojIiBJFmqsfseoI93X/Tj/+xNJEzew5rK7hXfI0bRVg1u9CAP+zyZbdpg0GObnCPKcYmkJU/LNOVO1X9KES2zCbEfrOivSfUrBFVAnItQF50+XO9Wo79CXT1Jgppvee+hXAew+8g67tDQFyogNTlt0Gvp66QB+TfAp4tyNXqHXNmuQHcCMBGzBezn2hdt4Om9jZrLVq9gtggNr2O6zA09I3a6O7ixwJboqZO9yLPLUsxwSaVubMCtqlNleBFS/tOY3dzkVsPy7T2QzE8AdXKu1dQXF3LDlzPvGDNQn457WiVupxbSdzJ8auCoU/zAG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(7416014)(376014)(52116014)(1800799024)(38350700014)(22082099003)(56012099003)(18002099003)(6133799003)(3023799007)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?43BLk58O2NzwQVaNyMYHRgB0qyrkVejzotgj/aV1/HAiMaV6A0oOi9mHuJeZ?=
 =?us-ascii?Q?44qjxo7FULVf9Z5C5itaLnGJKrqBu2uSlRsoWVlpsYoe5w5nR1H3V/Zfuq9+?=
 =?us-ascii?Q?WobRlt7Q/CWc8nUIqWruLctUuN2unE7OEfwUCDdHJ4y5QeE5Ml/RgVVAPXJF?=
 =?us-ascii?Q?MYuzLYjm3ZT967JK3oU/Yi1AS0Y68qweFTPjoqWSTWY4duC91ZXW8oruM68l?=
 =?us-ascii?Q?rduKznDJRU67qc3h+M5nhY+ng39BH/Lzf85ix2ztfmrNAy5M/cpJifF/i7+z?=
 =?us-ascii?Q?0v0G4hdGvm4+Vn/8rZhQNRbRI4lLQxV6pmlSZgMtfK74Qs09xagxiIadqeQg?=
 =?us-ascii?Q?bKRP1EHWUsl6StjKMbwbrigaZqaFnr3rHzw4stz+wcjo7z+OeDxCN19R7UJJ?=
 =?us-ascii?Q?3v7JO5CIK3HA34TYpluKCBJYTmN3JZfOXsIrkk1gVC4X9fBYeYeL17psID04?=
 =?us-ascii?Q?AZzLianuD+TKuzEnn/THdzmPbsgwNnIdmXpOSKKE4n42+HrJTbcHR5M2djjT?=
 =?us-ascii?Q?64ulYwDvBEZuFh1Xg9HgnGc+ktD4625Cd7RuLYJbN0xwZ2U1CPFaXdV/p7Ph?=
 =?us-ascii?Q?Ta+Pi6gDytg8JjA91try9CqGM803CaQRQqXcbA1HaKtYTA9pkOdNsjiDjhvo?=
 =?us-ascii?Q?ZtUqBCjM62QWd3oz/fqBthrihG6WFbtkWKs6ixFVnuWvaB4i61uIfbeBffxh?=
 =?us-ascii?Q?OTjiokf0Qsczz2/yUKYx6ZbwHIMTGmtiYFteDTBXq6AwdlSKYTSWwbl16RVc?=
 =?us-ascii?Q?84dzru70FPYxhLibRVLV0mmC6hiK2TZyeceGf/D+5yFpKc/2xceD95edubBx?=
 =?us-ascii?Q?TA5GYBttk+UQASWzifj+puUEORhkuSooZ1iYU4ULt8lZvXBl/CRq6rP6PEIQ?=
 =?us-ascii?Q?bS72ts3ESnx1qHihOa1eQT1Ww/kzCImNb5GjZQG/R79OtLb4myrBUIpbXVKz?=
 =?us-ascii?Q?rZ8kYG/xuZXCL+MEjVWOZhcCipbySE3nuSgo+7BG7mkv8O8nUn4km0LWltj0?=
 =?us-ascii?Q?JJxH0ab4pxSRnEQe4u4lC/1UnFyHwxcBAh3gVW2lA+mdMv/4QLEh5WNADffp?=
 =?us-ascii?Q?pAM4CExlbct44FLKqV1Mrmw0RhjxkRBNU1VbV5jS6CHIeg9HJI2BVJDSswgd?=
 =?us-ascii?Q?Seqj3UBR5QD1mzjlFvX7StCOAFQimtCqKtez8uCo2uFe0WKm8nDR0wC5tLOL?=
 =?us-ascii?Q?gIWLfJ80w7sbP2Yfo9UzV1eCu2S/bMFrWpXM6KUHKdCFlzuQtujNJmAkJERG?=
 =?us-ascii?Q?8VeblnU17s8ldDUab4jV8g3eZ5EM1f7dn1CtAHp/NTbNaWEwIWFjVRINDqLp?=
 =?us-ascii?Q?KFjKMDOI42hFxELL3+EU3CbJl5HUjVlzUAaZbynknLo60pngyA+SARt21Fb/?=
 =?us-ascii?Q?oBdo5dzt/vg8D6HWqZDUyK11WjYYiyHGZPxm+qGItQSd9DqGbGBBqLAV+Uj8?=
 =?us-ascii?Q?xW/CyLOAUW92vWYW8aydsKqn8NXPhe28Ee64HdZuBwqHDCOn021JyhSoFYzO?=
 =?us-ascii?Q?VHhQkU3wLI6/OyF1bq0IcGFyPNgUo3ChjtdlSzZaPEEFTBFNT+C1TwTG3FFC?=
 =?us-ascii?Q?VOXrK8SEYztfjr+fd33GafSkhPZGt7ePZRlj2BntRMxeNU6Cw30rfxOiCKC8?=
 =?us-ascii?Q?ZmL37z8WlkmiW+n3GMEP58DeBr+wckrlvv0X3HMGwk6SQNTXzRJh0ykm2ItH?=
 =?us-ascii?Q?DCym/N5rbzX6XtEkkdx6u6jAM1gOxipU+dTEY4Q01Dr+cLmCZjOpFyhXWdaD?=
 =?us-ascii?Q?kUssXwVFdQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5dea730-6a11-4232-b3fe-08deba24655f
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:11:01.6422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uf9IJ4oebruBwdyLb3Re1aEdN+weNYBU7HSXua982bTUrw/HQf0qi3C0cNH/9rbpognxLRbjTjtw9V7x4/Nyew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11797
X-Mailman-Approved-At: Mon, 25 May 2026 14:31:01 +0200
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

On Tue, May 19, 2026 at 02:22:07PM +0800, alice.guo@oss.nxp.com wrote:
>From: Alice Guo <alice.guo@nxp.com>
>
>Replace hardcoded WDOG_BASE_ADDR with driver model based dynamic address
>lookup from device tree, allowing reset_cpu() to dynamically locate
>watchdog devices from device tree.
>
>This change also enables CONFIG_WDT for relevant boards and ensures the
>watchdog nodes are available for driver model usage.
>
>- Remove hardcoded WDOG_BASE_ADDR from hw_watchdog_* functions
>- Reimplement reset_cpu() using UCLASS_WDT device iteration
>- Add ulp_wdt_expire_now() callback for standard WDT interface
>- Pass wdog register pointer to hw_watchdog_set_timeout()
>- Enable CONFIG_WDT for boards using ULP watchdog
>- Remove wdog3 status = "disabled" overrides from U-Boot device tree
>  overlays, as the watchdog device needs to be accessible for driver
>  model based reset functionality.
>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>
>Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com> # Toradex boards

Reviewed-by: Peng Fan <peng.fan@nxp.com>
