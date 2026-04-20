Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B312FF5581D
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 11:43:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2645584355;
	Mon, 20 Apr 2026 13:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="W1S3abWQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B8F584359; Mon, 20 Apr 2026 13:43:22 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66DB784353
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 13:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABpnjj5YhgSZOBuAwgM+FXNOX0rj2P62AQybYJLGtH+dcemm9qQ84ThoiYdMa6cyYEIvviRTvJjSa16X15pH9ypxGsSE9cZTsL74ripJc3y1FeNFnTXI0pDHCom+7uzx6CEtr7FJh34apVslAsP0JJCUgNvjmdt+A7dxguT4hPsSZy7wQbZbGQXiRHoJDVj9Ys7JkdNwI5V2Saf82QwBZj6kpnZiRGtjQYKqxilIoGigk6gTytpPqC7VXou0yUj8fnEEvCMCNoylvolJayKwTixj4GVmeMsWuk4xpw2ejj5iXJiQoR3P8sY2iAHh/uRro67U5qWpkioODMmeIqgtsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ejq/Mg3fsQ5sRzCJj1The4qG9SPCkpkBC3K0gbz7XIE=;
 b=ll7+WpQKUmcSEl6ze6TKeJVQtCLBxHWh3I3HWf/0TvfT/lUZ0hpckx1rlj8xHx98Hoem6dU2BP7ElEV8aHmGYNVOFA6oAHNYXzv2ekSxOIZ7jFKYyYVU1L2tezzuAvawlZ1JcoBiOLmqb9UMeF0k0VQ5Xjf6/TMMW0M/vA9bIvJK1qViocmvvB5eTgs31Agd66XIrE1SQB6NT28BXJoK++o/r3sSrVqfKKgfCWKtYaymIw1444i81+bGkMOyvPmrDG/koFikqEPiO4C9EpHGrLy15rvjBUleHta7ggmjB/bH+ONKXiFy+2GozSruuZzPEIDg4TvwhubPDxGgR+aIBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ejq/Mg3fsQ5sRzCJj1The4qG9SPCkpkBC3K0gbz7XIE=;
 b=W1S3abWQ1+UVd0OKfqmnb30CNrppvHFAuCSQLH+4gSA8V6RgO98jphHA+ntAhs1phmZJTdgDaJLdNUQL9EfDmy0xSN833Gfa7UNqWjfVxUWK9OKxWWSijDTypMUkla58Evy72zjFmRKNyZ59XczQkdjspO5bG2cfkWL5b+BciNwfiNdbBQ9JIoPxdLyfejSo8Ek/thRWHCpq81ZsLIbLtDs9KhSYCRjEKO79OGw5DIcephMWK/y/MQPpxfMwvfu+Vct/KvmdpJ+lHRk2LDbPM0BZmuZPSn/rdwhNZ8XhcrU7w18TDQDXIpWvK6+9+ykgl/nSouDkIPdj1zKBDOL6Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AM8PR04MB8017.eurprd04.prod.outlook.com (2603:10a6:20b:249::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 11:43:18 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 11:43:18 +0000
Date: Mon, 20 Apr 2026 20:59:52 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: peng.fan@nxp.com, u-boot@lists.denx.de, ye.li@oss.nxp.com,
 uboot-imx@nxp.com
Subject: Re: [PATCH 2/2] arm: dts: layerscape: Fix SPI flash compatible
 string issue
Message-ID: <aeYjSBnAXiWwYeul@nxa18884-linux.ap.freescale.net>
References: <20260417141637.1490695-1-ye.li@nxp.com>
 <20260417141637.1490695-2-ye.li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417141637.1490695-2-ye.li@nxp.com>
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|AM8PR04MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: 2676b2f6-4445-4f96-f615-08de9ed20459
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|19092799006|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LUf9oVGUgMj70905sXYthOK96M3CObjYSyZk2m3/45AjMEyyALMgtdRp5V3RaM0j76vqtO7exFufqrppsailvue6gluP5uDF4iU1QBoYN/f1Gx4marS81czKau9rKzF8BAZbu0mC5mz0AwfszgAJKMpYkuEmLMql1vE7xmSH3JDUxexA6iyzoTK8kDxOP2Bx7StylyH0cn2LsdDXVFpWO2Z/RPV/NB7rt4dxt/8o4JVtLbTzNMbSLH3/BFJhIlfu0oyxCQ4LhGn6GpWNOkiXodlB7bQGN6gX/AMKMip0hgTtgtjTnj5zR3AN9HvUwfv+WumeclYEU/vAVO630Pxm7ynZoBhM2EjkUZBpwcMX9kSgDp1ZOE5VOQg1foELUQsAQrOjQKUMu5tYfPfOl3WThfuVMbMESkvaE9/T7SS0dPSFxFVhI7xrHlm/wLa11xyF6FWv6G+QHQx7ESX9By9bGV9FiMN0TpiPFsMGYlEHBek0IwIMip59M1SD+T7AddK1GmvSmHr0JscdRsqrtFOt+bIbRa2IiC1iC9+hOKmCK08J+OtYY3onkM4XVhdkWGVqtfNDt4HhLxBkiz9qEMFQu0IBWB/Set1Bqu8N9ArzoZ3hurG0q6+KVrPRhgxIs7ANLFzqYKkez4WGWclbqFyfx2pIMXl8+uJxAX7w+LGba3rAAJWxNoG+eHsh4gp13VG6baEgaYh5+ys7EAgt2Ho1IoTwMYVGqm6M5Fi8ZqrEnxRMPK0LZAaTMjIY+yMlhYEkn6dM56DP0SpMn9o3IpdTJnKoXKyWCMyAutOdUdD1zY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1V23YI+FYRYtw9CyQ3DWHVR5tkPaYCi5gOxPZDhrLM0JJesH29OB6pVXy0AY?=
 =?us-ascii?Q?PnJu1I8YcTVIYwj+YlMpZWUFzxfgRfvjk3g/2DJUR5PN/Oc7C7oE6Mb4X4zp?=
 =?us-ascii?Q?Y4OXZ48VhtyyrXbQlNW5BPJGadlJPBQBc6Q9BOiOKkh7GBHLAfYyWI3Qj1Zz?=
 =?us-ascii?Q?aplusu0KUGDJRlbFaLNeOPDIrB5z+3NrlVFYc8LibYgCE3L70vyuakAI1Ajf?=
 =?us-ascii?Q?1yt1nQuEhB+WKnG1gGsdhYTQWxHGjpNPyZQDIjIs02pGRTweQpsn2u/LJJJg?=
 =?us-ascii?Q?knIvCXaIezJ9EybhrMKvRm4M7oqFF+78WyshkuoZFhXWZ1zQr1MrxPqJADx8?=
 =?us-ascii?Q?Jf3pox1mEgmXn95X/MTI/w6xOMOxKY9nsqrlbdRJrHYaiMMKPTqfYrefwrOc?=
 =?us-ascii?Q?rK1S934gAq+vfCasQkyCQGtvr7hVytk69msGZWbLECuYOfqVhG/TriEj61ri?=
 =?us-ascii?Q?wgNa3x5Qz970FCbwGJUbXAYtncey7tgm0/5BcCRxuZfAy769v32aZldwZInd?=
 =?us-ascii?Q?FsayHFhW0YrRwzMmm0kruRY/stnqFCeX2sMW4HWRNLMzgE6E60gToO64RHzF?=
 =?us-ascii?Q?QUCOERlzTRiwjfyJr17hj8Xuv9qCJJe605VIv2zpBSdtontfz8F9acbY5JnS?=
 =?us-ascii?Q?v50iqCAdlqY9yISIc4ZoJKztDabFuJ61U6PvhneF2Nr81YpvoSwldciUmBzF?=
 =?us-ascii?Q?J8ITF4aaIRf+gWpGYWgr4RnXezxzp/13t4DlIM4diVzMpyZV1fU4phlXxb40?=
 =?us-ascii?Q?tKO+bPi6iepRTdIjGKw4Auhm/4xZEuBm1VuJ0n7Jm8Mh3VW0NXDNe6tyDkCn?=
 =?us-ascii?Q?DfJpTiLeFl9Q0YXQPOjoxh6CAv6c3KnQzELWJqDG/8XfGN2qvJfxRUf2sO+u?=
 =?us-ascii?Q?mFgRetk/rCa3hYB3+WxFtsEamcrNCgD2aVo0IqnNKl93z/tB8hqxyPup3vOD?=
 =?us-ascii?Q?YZgcIn3q34biZ+hD27aE0KxPrtO3f/8O0xKVRfXgSIbYhmOe/t5RhpM9x+gq?=
 =?us-ascii?Q?QGBtBHOeDJCyRDPRJAmacsINN+EhXJROlItF2Tgra0HeEQKy1ihdy0J2J5WJ?=
 =?us-ascii?Q?B/NuwSznTn+rV8to9vPEQFfHkRfuq80XplBTzkXHZhsyyPrckaohzXiKuUVv?=
 =?us-ascii?Q?AarIpjHt8oG6ENoBg5OnKy1TCXK/Lxqxv3AE9+snPYD/o1cfpvkrRX9EhpgH?=
 =?us-ascii?Q?1JdaxCUbLg4XWhQRxBStoTmZO5WPj06vs0pD0VXczge5lUdcggGS8N+TXlOO?=
 =?us-ascii?Q?6Ii7IvXaD74grKJIsSjVaCcHZYC/wZlymFTiR4PsRuwm27RuNrZyFiSnP3+6?=
 =?us-ascii?Q?q3xuI2rj5/zLg0YvJuIJwvRDf2/69W+j9HdRnTGER8YJU5Cz4ZDgAZftRxfi?=
 =?us-ascii?Q?42yf6Tgn4MXQazd+5lH0ufwq6vtmF7LkLXxOyH3D7JtEaSWD07GmVrMlLWxE?=
 =?us-ascii?Q?4s3XdCM2pxBUVjjoRuLpuKGX9XmMjxKEeru9m4uRpCkq+HA054iVhEMFAB5w?=
 =?us-ascii?Q?DbAr4YSUUe5axPpXlscdab4LQIjE7rg2VWj5lfyGvp3GtUTixrpRk6isYUbW?=
 =?us-ascii?Q?aKjU2bxQ+2W4caVg6C5hs8cXQtCIpx51IEYo3yNrg6BwYxzDVF8fLSonhfsU?=
 =?us-ascii?Q?ZiLUciX6lDiX+EwXFIRJ/ZXaWfZcBW66KHCI0NPrKJe38yW/xBquG210lMjT?=
 =?us-ascii?Q?Kidiu+reBtJjbbJI8ohJzxZhfytYPdpWM2KYzHPtuf96DNKZgWzUMxZrbGDH?=
 =?us-ascii?Q?qNRz8ci01A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2676b2f6-4445-4f96-f615-08de9ed20459
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 11:43:18.8251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwINORFu00rGz2Zu80TEA83lZABwXhCXcUfn4FWNLNPZt8FNE2Xkc/V2zGlfI8cg4sNIoWt6l8Ko3bxt7wJJ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8017
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

On Fri, Apr 17, 2026 at 10:16:37PM +0800, Ye Li wrote:
>When CONFIG_DM_SPI_FLASH is enabled, sf command will default find
>device from DT which requires to use "jedec,spi-nor" compatible
>string not obsoleted "spi-flash". So update NXP LS DTS to use
>new compatible string
>
>Signed-off-by: Ye Li <ye.li@nxp.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
