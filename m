Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3E2C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 14:23:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C2DF82A53;
	Mon, 28 Apr 2025 16:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="cXF0OY2r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D65982A96; Mon, 28 Apr 2025 16:23:24 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC9AA82A33
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 16:23:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vladimir.oltean@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqzdJBfTl7QwhhKq59/WIw1ZBXKBQ8a6vzeeNAuFrWKgHd4iJqou9iBdtlrzjA1j1bUPrfJ+YhYglbynButI7g3M9YmpilfN3ZQvChKvWJa8GyyMPwCb+yirGEl35hnvAYxNWtw0pzZlDrfdT8bT/d/L6Hc9XPwxb50+UDaGKfRO/2+r0XH0sLCTo2Wh5WeDzwqpNAdMR8B/bA0LGkv2xEl8+dYoSdSH6kzQhiVeLkrT2gk1qCap/HmMS/O/zxH/7/5k2IoTXi/gdtQIsALqZIX5QaDywI7K+9LaPhfIOklFeOifkAEeXNIbtLG7duqlzJa/e6gq834LRZ+tlLZHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqdplueAoJUVZf0Ln1CNv87grTmU/eZtMi4L9bxz6BU=;
 b=Yymg81Pqfh8wMFErWGH4FR99TLQowOcfThQfmrcl0DRw5RrR4qThcVr6XoUJCtU4jWgjtKPYddT57Rg+32mkp5qJ8waREf62pGXooKUN1Msmiwb24PfaLneq8nwx0iL76T22T929L/MidEcjhOJBpCkpwFoYRHyV7+utAOAXUB9ON4Ne4i6U1uF4/gRFBsnL9owQ5FEOIYNmC1x3oXNOdfVO+euBfjQqs4joGRsbV9F82oPLSyzs497AkhzkoonmtoBbzXKy510YNcVGQQXdIRxAOWc7WE56ux2blxTjN8jtew0YykNdBLPn2vjyKU4GJXYU2bQ9uiVo1yqledFk3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqdplueAoJUVZf0Ln1CNv87grTmU/eZtMi4L9bxz6BU=;
 b=cXF0OY2rMCKdnblnIWwDDWpDRZu8UlOvcAdlbGdVeFTqC/K8+SXtUcCZLrwgiBDHgsJxqXuNurPyJI0tN2aXDR5veJA/GNC5wI8jiEFrxXFzS1+mMs9C8EcFk64VJNIDpvMHUb76WncLq8R33LH61Fo3MCFZtyhJElgxv4HG2L5sdyg8adGw9eTWqT6MtAmiREyeeuZFT2MzNfBtMfPU2Fft/E9LPBHRIBtjUm1gcchR3av8gmQl2vNP6zAzUyDBLtncEnor5si2j7SJAi9JmXWPF/ivEjikOsOPAVT9QlwVjdWa4O4Ot+bduUMnmsASgYx5KMVAE4GjWBy8QtNmmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 14:23:20 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 14:23:19 +0000
Date: Mon, 28 Apr 2025 17:23:16 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Michael Walle <mwalle@kernel.org>, Wei Fang <wei.fang@nxp.com>
Cc: Heiko Thiery <heiko.thiery@gmail.com>, u-boot@lists.denx.de,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Ye Li <ye.li@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Thomas Schaefer <thomas.schaefer@kontron.com>
Subject: Re: [PATCH] net: fsl_enetc: fix imdio register calculation
Message-ID: <20250428142316.geminnotbfmbkpxs@skbuf>
References: <20250428095945.1432389-1-heiko.thiery@gmail.com>
 <D9I6S5PD32TJ.3AGU7UM3EUOF6@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9I6S5PD32TJ.3AGU7UM3EUOF6@kernel.org>
X-ClientProxiedBy: VI1PR06CA0095.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::24) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: a1cfa72f-3048-40d7-8a91-08dd86603961
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nlTaYgZKpYza1oQv/4jb+VEUIA/m0bNgE0gqE0IMjLTY97YTdCI0UyLMA0EG?=
 =?us-ascii?Q?loKg6XhCPXDYVHPCCu8cJsRPnt92PEgKCn/BqMIbMKEPwFQgOUKEBMXoGhaO?=
 =?us-ascii?Q?UCxeaTcPapFj5wL23wHS5Eo1F8BOurPJJ1qo68I7VdmB8RQh70V7oeMk/5bI?=
 =?us-ascii?Q?KWJqzmWn5GcfWcRWs37d46UicJ+SPmXWogq8+V1bv+th5FfLURbDuOwC9xU5?=
 =?us-ascii?Q?u0WXQoUfcmHl8X+CZpElh6IRgSKJiyLm+ko7Mbo00cUQDoe9I16IZZjcPZGm?=
 =?us-ascii?Q?3inwOXKkvo7Z3UZKVPTElBqNwsYXnOYTFqTjf83PKa5n5Aq0gJKChQnHR3iy?=
 =?us-ascii?Q?cZgpPRaij40hclXHjd1RlNJxT1+Ia9rOTnxBIaT/hCVtU0WPcPBi1Zm8fyeb?=
 =?us-ascii?Q?hMJI19M68Ry4kQqxt4K+LAVE6LUCtvam+X5NwJHCFOZsdKybVQfVdG4wyvGT?=
 =?us-ascii?Q?eIogWdbrt3/jy0eXhO/xZ+4uxOnd0PpL8/yh4idBdjgZbAD6MSo1lvSGNdhw?=
 =?us-ascii?Q?P5EfQO+GqihQOj6ecSKFnN8KUtGC96yR4uxjEF5nkWpjUcsd3A8Z+R11U4A0?=
 =?us-ascii?Q?dJz2L1FVZz/HiFN9tKGijZwXW/mVvlQj05eMmHcICiT7jy42wSVJWqjIFDKR?=
 =?us-ascii?Q?1DTGRG16a1jEEikA+9aFuOseEnSmrFrfE/8NY64jhNeFBnN2LlbJi6gtDDQH?=
 =?us-ascii?Q?184ENr/1czFKN2akRJYQ62KXjlm6uBK3khIE5pW0T+UuKSDw2QejT2j8GsHg?=
 =?us-ascii?Q?iwoyvtf+buBXxsEtVwjidvbWDF80x0l1YtrZCCDE1R/DRAU834iPCGgeqyLT?=
 =?us-ascii?Q?Q0XUs6DVOphck5aWLraKaXwnhHVBXpdnCjfUMnSyx6tC2pf6awEbh1Dupy4z?=
 =?us-ascii?Q?qE2J5jxSIsIzJHrm/U3eS/Sm+LixbbfjVZC7x5f0AW3IGXzUe6/1uqGNeJw1?=
 =?us-ascii?Q?w9ugLLKwTDacWON9Ob9EvR53+39BlHazKc+TXKB1DDNnXJWdS3pLuUDHH/y7?=
 =?us-ascii?Q?qmhyiA9AfZm/YR30+4EpYNApmSNFsjintpWlmGHmoHrX/qg4xrZMk4N25WYy?=
 =?us-ascii?Q?fet24c6OktildnbpcO7jIY0mjafWKmgPkRqQFN4EvrRBnG7jKjf9tpZYppD8?=
 =?us-ascii?Q?r7RRqjR/fx6ZCtD8V0qVdGc+mF0WQyeuqULagjSdfYFlDKF1qiyWX5wTxMOf?=
 =?us-ascii?Q?E2KNC34ZU0iFxw2COm4fC0walz1RLq51+hAQLkB3GcJsV/Bn02Wsdvt/KeSg?=
 =?us-ascii?Q?XTfvwkwLxrwDKOMSNlYtyr/pQ19InmU9h21exEJZs5gK04Nd97/TJEc57VnP?=
 =?us-ascii?Q?EQaSKkynrrolhCMpa1IFMjhTFpO+a9O29Gl+wrKAravN8AjVtGZzcB2tCBh4?=
 =?us-ascii?Q?zOvtOZOQHnX9oIvXOOmEv2COuhp4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7779.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GOFQVyiSY3g/Mccdvlf50K1YrdVf6gEkyhBM/t2PE5DcsKQ++PzXsFjOaYoX?=
 =?us-ascii?Q?XlWXcYYA401nZ7n4YigNLoVmFGjIiWMy2l3PIRLopq/LTKWI7Syf9OVKKNQf?=
 =?us-ascii?Q?MkFrGRP5DzsGIoUxijeQVz1V0DMUnh9T/Ke17+9qKLHJElHcUHzd1rsnTzwl?=
 =?us-ascii?Q?BEkpnxVt8Plir0DarSRrg7Fu6ectj/Axs1k5OpbGj6AVvr82EhuDwXIMBmUU?=
 =?us-ascii?Q?VfjinHRtTEilNyEGrhxG0j3gB3wP957lZYfdaqx3gJSCGco+uDKfaQYdedVH?=
 =?us-ascii?Q?4X+ijTxaulRGvHArL7YoWDeC/bcQrazqvhSNb/xslt4TLs4QdkM+N9VBV5ba?=
 =?us-ascii?Q?CfZDRMn4CL+KVYs9l3BCVG96WJXPY1S3FXvDzpz/KTiJf2Qyih8khks1x9M8?=
 =?us-ascii?Q?gfUIgb2mbVpL+OIXthlPpOMQzFddcZ1/wKwL7lBXE9bFGS0HnB8vTL6NMrfA?=
 =?us-ascii?Q?lOFMptPfGyqtmogEJIWB0DxOOfVKohNXP5qAQO6Q1NVF6CKCqGhWKh6eFR48?=
 =?us-ascii?Q?uM4gT//dk5KpFZZHCVBPOafZ6DgfaszSHZnvQGY3N8JczAmiGF6FbeexP4ge?=
 =?us-ascii?Q?oI2xS17M0Jj5rTS3tkx7VMJk87+o2t42I/LwmKAM4wl3Mbk67SBNRGWu8uq7?=
 =?us-ascii?Q?Wosbl3flEVnrpySUyCws/BOMAbWMAWDniiFgwuSRpq0Ojwz3tbIxsAykz+ht?=
 =?us-ascii?Q?6plgqPgecjDOFFBMkAw4vM7JC50HhYUarwOw11PRq6EvV9wHCa2PpCVXDMbj?=
 =?us-ascii?Q?gOItzGGt1UnWWmHwQ0suhc5A7CqdSuPxFlXW1vj/rQwthMdQimzWvGq8mbqq?=
 =?us-ascii?Q?T1lKV6N1To4zJaxzF1OXPNKhnQ3QbX95lJNRUaen4PqI72sOAQIN1dsbkg+9?=
 =?us-ascii?Q?cxMolLqjcVwVE5ezV36fqtj/WJ0yDFaByQ+g7yxOD0VEBDJijHmzf4bGcZjp?=
 =?us-ascii?Q?LdjD8/hbxS9k2hVA3vVNygxnWvn3aNYz+adLw6+sJ99x5AjMolgypiTkgkOS?=
 =?us-ascii?Q?0IDVvv/vDoMeDMx2vYXhgQO+FXB8yTE/iRuwvhY6krxHA0p1+n8wwPdwFeJ9?=
 =?us-ascii?Q?wtWBDFJO6zdmM3IW65pYJaFcLKx986pZ/wHXbwnEavjHaHDKTeMXEkonrq3G?=
 =?us-ascii?Q?E5rfiS1w/A4ByNO0Ws/9VZ1DMgdIT+jRXJp8gJCLgFli9lv7K110M5wpprsZ?=
 =?us-ascii?Q?aDgSLPBXZBv33tLRBG0+h0t3j7iw/Ty6l73qGPzQNvqdsCo3vB95eFXLCtpS?=
 =?us-ascii?Q?rcYAdOOlOzSK6/EPYwDfWMJOyD5vFBW9MdYCN+dhWOR8Fk4Y/e7rPXs47r3o?=
 =?us-ascii?Q?JMjltNECoJ+uoj/8+gCjxQsa12mLJEUdT4iZQ8M99SuZ5UdD4G1b7u0znp/8?=
 =?us-ascii?Q?A3W1NEG3TZluy4QiUcRMAA7O29r6WUrevKeeAj93CjCr8a4713Ki7g5kvMyj?=
 =?us-ascii?Q?lIaMysVZBDEkSSstkwzwXD5oDh3nYhAQ+GEGSmUTHhsv6OzyWjNIgMklpGmH?=
 =?us-ascii?Q?d4tOOibU9+pyzmCTVvT+wl9kernq1gO2N4Gwcd1QrKiKu5Q2Ouue7hDYU299?=
 =?us-ascii?Q?IyCCVIqx06TKIO9NDhcN1m/FzCw7yfW6tb32+cuEt/DijXR2GaoWZKZvbgnP?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cfa72f-3048-40d7-8a91-08dd86603961
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 14:23:19.8113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: irsVCcZzyesEo3XfRmaG2NmrTkgs+mgV47QHSvIVJpeWZu2Pnef00Z8bPLpHbvZAk20YSwaEV7uQ3JFUYn0nXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8897
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

On Mon, Apr 28, 2025 at 12:06:28PM +0200, Michael Walle wrote:
> [+ Vladimir]
> 
> Hi,
> 
> nice catch!
> 
> > With commit cc4e8af2c552, fsl_enetc register accessors have been split to
> 
> With 'commit cc4e8af2c552 ("net: fsl_enetc: Split register accessors")'
> 
> > handle different register offsets on different SoCs. However, for
> > internal MDIO register calculation, only ENETC_PM_IMDIO_BASE was fixed
> > without adding the SoC specific MAC register offset.
> >
> > As a result, the network support for the Kontron SMARC-sAL28 and
> > probably other boards based on the LS1028A CPU is broken.
> >
> > Add the SoC specific MAC register offset to calculation of imdio.priv to
> > fix this.
> >
> > Fixes: cc4e8af2c552 ("net: fsl_enetc: Split register accessors")
> > Signed-off-by: Thomas Schaefer <thomas.schaefer@kontron.com>
> > Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
> 
> With the nitpick above:
> 
> Reviewed-by: Michael Walle <mwalle@kernel.org>
> 
> > ---
> >
> > But the question that now arises is, does this code path work on the imx
> > SoCs as well. Now the imx specific offset 0x5000 is added here and was not
> > used before.
> 
> Maybe the imx9 doesn't use the internal MDIO controller or the board
> which was this tested on doesn't use the PCS?
> 
> -michael

The imx specific offset 0x5000 should be correct.

In downstream, the ENETC_PM_IMDIO_BASE macro is used in common code, but
defined twice - there is a conditional include of either fsl_enetc.h, or
fsl_enetc4.h, depending on whether CONFIG_ARCH_IMX9 is defined. Thus,
ENETC_PM_IMDIO_BASE is replaced either with 0x8030 or 0x5030 in downstream.
https://github.com/nxp-qoriq/u-boot/blob/lf-6.12.3-1.0.0/drivers/net/fsl_enetc.c#L25
https://github.com/nxp-qoriq/u-boot/blob/lf-6.12.3-1.0.0/drivers/net/fsl_enetc.h#L76
https://github.com/nxp-qoriq/u-boot/blob/lf-6.12.3-1.0.0/drivers/net/fsl_enetc4.h#L126

I guess Marek fell into the pitfall when upstreaming.

> > Can someone please test this on an imx9 and confirm?
> >
> >  drivers/net/fsl_enetc.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
> > index 52fa820f51..97cccda451 100644
> > --- a/drivers/net/fsl_enetc.c
> > +++ b/drivers/net/fsl_enetc.c
> > @@ -473,13 +473,15 @@ static int enetc_init_sxgmii(struct udevice *dev)
> >  /* Apply protocol specific configuration to MAC, serdes as needed */
> >  static void enetc_start_pcs(struct udevice *dev)
> >  {
> > +	struct enetc_data *data = (struct enetc_data *)dev_get_driver_data(dev);
> >  	struct enetc_priv *priv = dev_get_priv(dev);
> >  
> >  	/* register internal MDIO for debug purposes */
> >  	if (enetc_read_pcapr_mdio(dev)) {
> >  		priv->imdio.read = enetc_mdio_read;
> >  		priv->imdio.write = enetc_mdio_write;
> > -		priv->imdio.priv = priv->port_regs + ENETC_PM_IMDIO_BASE;
> > +		priv->imdio.priv = priv->port_regs + data->reg_offset_mac +
> > +		                   ENETC_PM_IMDIO_BASE;
> >  		strlcpy(priv->imdio.name, dev->name, MDIO_NAME_LEN);
> >  		if (!miiphy_get_dev_by_name(priv->imdio.name))
> >  			mdio_register(&priv->imdio);
>

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com> # LS1028A

+Fang Wei to confirm/test for i.MX95.
