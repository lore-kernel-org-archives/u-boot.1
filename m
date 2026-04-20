Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8221F588C4
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 13:41:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59600843FA;
	Mon, 20 Apr 2026 15:41:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aWBEXS7q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 616EB843FB; Mon, 20 Apr 2026 15:41:30 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D485843D1
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 15:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAJfJ1vl0r7p4pKYzMY3O1Kh3SkhpX9M5OqJ4IoJH5fWBEhscDUvNrYOnnMOP29dIMLKUuV5KTSxic7VLslpHyIyYOajd2jdfEkjyabdXZSta3sBeS1GjHVmfk8Ge+ujeRzqKdtkVTSDGvsMxL0y7hA6x40/XdJLG0ABNO8uwDBy0OwGBkZC23JIdC6IzuViXGZtMDRo5Dbhsk9XCQTP3LYRqG+yzZCilQ9zDDZJ+LkGjJpPdIpCbatqtNN6cjyXOJHmuiIW7mfSv6iJDn10eM75K/JNSqfiI0UwPsEioiqWzSu6wVt+gtcULjvlqB97esku87NEmKsLIa6GgHVfIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=outRjwd4An67QDeVHc6UdYgKJHoqFwgjQxbfqMDY8rA=;
 b=t6AIgS/n5YsvWVu9ph+3BV4qTykZ9nEJkpojcY+jpLnNbLrsUpVEYfW3kjSW3McRIzvd9rvxMUrSwLQjeihn7uPkH3TH6LBCI5R489D/TfIesC7GtpHhbH0xvccwa3JbnoE6N7HvKRmc0YNH172I98xWAyMF2mHm7zvRFONSb+tb8fiCP+soNQmAZTQ++4QnNyloFhUhJ9KRfoUZhnJnNDlZysj4H5ggnQnIahUfzDdsPF+Ji4lmciLzuqDeKyXd62UH0CvlwuNt75a2+blG/kViKxmji13mPtTGbbyx3JO8cSkJMEBICgpQ8P4e3SfP+xhfEttyCHbfPozHzIyJcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=outRjwd4An67QDeVHc6UdYgKJHoqFwgjQxbfqMDY8rA=;
 b=aWBEXS7q57Hvkxk5Sm/erTlXlV2QJzhTDB8zsRamuev6fnRLQtxEhmrS7CPIq6FL9/3T8+wDnPES8/1Ah5ds+X5YU02C9fHzfMu9T5I4EE8TpfjffOkdD2jv88wXRGHrHPcfzLfCXIfXsZWtmpV+kRJB4Q4slRGBxEFqUOuX6xtrckIUCOscihSePTeoO366W4OPxqqXFuPtuSxNdM+9iX+XZapaIB5HKX1Hn6APJlNSrSl+gKC5RNSjaRK1uRqLsT2Tpqh0WkWOTwzTCu0rgfdBuD+NFrxBHZepWrtBAMIx9kJlmj1MTWJSAzs0+EscQtvYu9EJ97GAz0UuH2FoSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by AM0PR04MB12123.eurprd04.prod.outlook.com (2603:10a6:20b:747::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Mon, 20 Apr
 2026 13:41:26 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 13:41:25 +0000
Date: Mon, 20 Apr 2026 16:52:42 +0300
From: Simona Toaca <simona.toaca@oss.nxp.com>
To: Simon Glass <sjg@chromium.org>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, 
 viorel.suman@nxp.com, simona.toaca@nxp.com, ye.li@nxp.com, ping.bai@nxp.com, 
 marex@nabladev.com, sebastien.szymanski@armadeus.com, ravi@prevas.dk, 
 joao.goncalves@toradex.com, ji.luo@nxp.com, semen.protsenko@linaro.org, 
 tharvey@gateworks.com, qijian.guo@nxp.com
Subject: Re: [PATCH v3 1/6] imx9: Add support for saving DDR training data to
 NVM
Message-ID: <bele5ekkryruhwzvnnp3irwsapcsqawt4a4fy7g6cmdoifwh4y@37ov46b26o3t>
References: <cover.1775121078.git.simona.toaca@nxp.com>
 <7edcce04b39aabc1f58e09814e7fadff226e2bb8.1775121078.git.simona.toaca@nxp.com>
 <CAFLszTgb5a3QtyviHc-MRTdDUoDUWnYksWXMeCUxagHmvfQK2g@mail.gmail.com>
 <mtfbgewm7kw4jzmxjkksdmq2ahb3mdrb6p5bi5qvpow2tydyl7@bejuojige3bw>
 <CAFLszThADHGE_8aAFExK8Kv_Ef9LG5Xcio=znkNwFH-eUESzsg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszThADHGE_8aAFExK8Kv_Ef9LG5Xcio=znkNwFH-eUESzsg@mail.gmail.com>
X-ClientProxiedBy: AS4P250CA0017.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::6) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|AM0PR04MB12123:EE_
X-MS-Office365-Filtering-Correlation-Id: cc578eba-66be-4c7a-1ae2-08de9ee28479
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|19092799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DPQeF/KuWWRrezR/0ron5XGoAqP6tTX5UYRhrAcecEnCQpo5Fq6KdVGdW08ItQA7PfAp6Ma574mCLjLZrwBIl3nr59gg/4spTdpSCxWZw7IcdHbKAOpTh011b11Jw3ojkQDDMiqRyYrkcN/STnH4iSuJ/zV/wl//JjHGdS8AYXHH6Vvm+Z/g02vnv5T6nv29tpA1VgxugJXpanrTfJShAa/cexj/ehSpdhsL4xI5T161qU3TILgcb2rTDUhTiIkO3haJshAVASSLI5IHBqGvWj8GN9/maB9WjIPgNbtDsAtaqIZfe/mNHYxvSixrGV6NHVVdyY1BfJm4ldDsc09yK96e/mLCyYpsBSeoZDn+O0qIipPItxH8Hz+jNmkDI2lYAa+1eH1wqw74GJ+uB63c/Af/lVEGMvN+FPab2OgNxDRxU8eaHdsNuM6ggrpWdz4Unv2jhULqQxXEfeo3iyB+Uu9fsUH0l+cWeR8t6CeAR1P2mkocYQGdqaMsHUrayg0J3jypnfKgwV0vvGCBe+M/Yl7MnS+N3gOoU79xeNAvfniGzYRvsrpnFnki9iP9ZXlVahQXVt2teUV/oK/5YdcXdgoov7XfzS67+ePjelbHpRbWCpKiM+n7r/ZX9ANNTLZS1G3buE7+rVLjXwOFAxmgn02h0JJ9HUrpvz4/bVBVmMcAwZC2LzJ6hAFPANW3bpMHeSseNQDJX0WA8sNanzUTAaY4HcIRyqmjhXkoTxW9I7w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(19092799006)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N41SnzIDH6t3wJ5QEMmXmYI8bn5KoCc0t5HZ+D7QC7xoyMbbVkV3FkQKYM1j?=
 =?us-ascii?Q?DgmddaDnz5FME7Hd6KMkY7gZcAZPzS2UBaHwRzmliI+VNzGFf25sKTapX7/k?=
 =?us-ascii?Q?07RA0S1bY1uvcikP9rs6142RWXURsHjwVwW+FhfkWu6v8anMZF+kr944iNRR?=
 =?us-ascii?Q?M89kTifnwUtA0FoOcP4K34EjqaTbHOoIrhD6sdvdPfShxTizW1fa0w/o7eLp?=
 =?us-ascii?Q?QDUivrv1qBYYuetPbke7lR4mtwok9crWrAmfI4InojKLWss0kVTEvy43bNp5?=
 =?us-ascii?Q?gm9KAwMtiEs5lVR5LlNLRXoR8FoPljEL2562lMnQH3DYu9u7KTHNN8aQ2P2P?=
 =?us-ascii?Q?8wA5G/r3VJDUeLwW8Yf5J60AnjMIeZwTjfev2FEVgsQ9Xwjl1R8D9I512n/h?=
 =?us-ascii?Q?kd5Ttijv3XU2U+SImCwlDdQXTe/HRXeEPqBN8F/oFIvHOojUw0UBn5zN7AT6?=
 =?us-ascii?Q?kwWnGbdCEtX+KT01GkFMNt8ul+DfpqZ9VR831xLpSUxDxpbgNPaSioUnC7va?=
 =?us-ascii?Q?3xpEc1LxZTb3P/iNAO65NC9IHByZi1FyRTQdMP2tv9sM5SmDuP2BenccOEJj?=
 =?us-ascii?Q?+ZkGyCOgttGiOmFjY/qFRpKHCQBf9x2FSsEgg5LScVi2Ns/Zyjh8YpmhL7KB?=
 =?us-ascii?Q?ZYmdvoUOwHv12MBcfwRzHQujR8S8p4P8DhfbJ1w0O/k9AGuQcd1qbixLWivw?=
 =?us-ascii?Q?j3sZyhI/eLn4vRhOkGX9x2VdnS7Ln0HZ+rubW41qhoFC0bupCVG9zb+vHhNP?=
 =?us-ascii?Q?9gjfgXd9YrO6NREMvr1YQJcLHVWgQyqT44g5RXqO3VuEkbVkyFGIh6ksq6j0?=
 =?us-ascii?Q?vAbsGGOm9RZD3pLETV3zPwG6DZ7yD92RH4p17DY8j8p4HhjzFJ+a6lOcYGjq?=
 =?us-ascii?Q?deiM0xAwSc111w8no32CG/xEYK4348BjXF2RwEmaCkRju1McLS6FaHFZ/s9m?=
 =?us-ascii?Q?c56p01u6fqo5UPMxTUnZZHkTTWPIYSiNEkm1y1TYwqAuki9+XkAyRShd9H6v?=
 =?us-ascii?Q?ORMko14D0rR+h+ZWxe7XJBx+vmGCUPtEqupB6t8YLOp7fl9Xgp2Eph6fP4HN?=
 =?us-ascii?Q?/i3ITkRg/AkrCwu+FzPCdcC6A2UzWa07bNyf0QnSahbTpfBsi42W6KkAeOmV?=
 =?us-ascii?Q?muEMfROzxg0W/LRSWRQlrZJNw307O4ED4usXdaAVsrdJn7nfLwXy0lkpsG4z?=
 =?us-ascii?Q?orx4DFJbhbmpLIpe/qGZZJ7AWrLl6qJJhO9WmosgZqGkTLu0lyNcreYCPP7i?=
 =?us-ascii?Q?axkq7h3nToqrGB4SRCr/xuwSKKMjimRe86c7LjgXdHoLxzt0NSWfhEzkhLNO?=
 =?us-ascii?Q?iw9/YzYecYjUHO3LKbDCaYb9q8uoP8dT56gI19S/kbHtjY+fd/l4aN3GCZqJ?=
 =?us-ascii?Q?7KZF1JkpRnVsHKfr253H2padAlKfKy7PmXQt0Muk+jUJuvy+e0+r5suITFOj?=
 =?us-ascii?Q?qLK/Xq6Q7NBtn9Y9xhjpgP3Dnnf2DaB4smAFohbF1w0Tx+add1nM2tbBB2O3?=
 =?us-ascii?Q?hJZf/d/B/Oe+fsdmXewyhFo3j2PH5o3T60NSKnbhQYiLgcrcWhfW468nOQW6?=
 =?us-ascii?Q?fItRTtx0Ornpw1UDlHZqRSJJfPL8UU33a+wlWDgxAd0gsltIowhRW1fyD3b6?=
 =?us-ascii?Q?PSzd83p5Ql0tsb8/0uBo4yhXiiTxONfBXZgCt5Yz2TRdXxdQTbVbbWwUHvVF?=
 =?us-ascii?Q?31SxkJdDevQaJdwdDsXHawng1Bb2r9AyfpTaTOsMapdni6AnMj/pJvopHWI/?=
 =?us-ascii?Q?x3LblX/1rA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc578eba-66be-4c7a-1ae2-08de9ee28479
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 13:41:25.7620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHkoS6cLJoL2s1tWtPW7u79PWqeTT08MoQx71bVg3H+8/WUTpLzxYo3hMWvZ5AYfLBL8ZZh44WcBHUSjZszwXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12123
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

Hi,

On Tue, Apr 07, 2026 at 12:13:51PM -0600, Simon Glass wrote:
> Hi Simona,
> 
> On Mon, 6 Apr 2026 at 02:28, Simona Toaca <simona.toaca@oss.nxp.com> wrote:
> >
> > Hi Simon,
> >
> > On Sun, Apr 05, 2026 at 05:49:56AM -0600, Simon Glass wrote:
> > > Hi,
> > >
> > > On Thu, 2 Apr 2026 at 03:29, Simona Toaca (OSS)
> > > <simona.toaca@oss.nxp.com> wrote:
> > > >
> > > > From: Simona Toaca <simona.toaca@nxp.com>
> > > >
> > > > DDR training data can be saved to NVM and be available
> > > > to OEI at boot time, which will trigger QuickBoot flow.
> > > >
> > > > U-Boot only checks for data integrity (CRC32), while
> > > > OEI is in charge of authentication when it tries to
> > > > load the data from NVM.

[ ... ]

> > > Note that this feature is present on x86 boards already.
> > >
> > > I wonder if we could make this more generic? E.g. it could be a
> > > function of UCLASS_RAM ? I could do the x86 part to try it out if you
> > > like.
> > >
> >
> > Can you please point me to the implementation for x86? This Quickboot
> > feature is specific to Synopsis DDR PHYs, and the location where we
> > save this data is specific to iMX9 series (since it is needed by OEI).
> > I need a bit more details about what you mean.
> 
> Yes, if you look at mrccache_save() you will see how this works. It is
> controlled by a flash layout within the SPI-flash node:
> 
>  spi: spi {
>     #address-cells = <1>;
>     #size-cells = <0>;
>     compatible = "intel,ich9-spi";
>     spi-flash@0 {
>        #address-cells = <1>;
>        #size-cells = <1>;
>        reg = <0>;
>        m25p,fast-read;
>        compatible = "winbond,w25q64dw",
>           "jedec,spi-nor";
>        memory-map = <0xff800000 0x00800000>;
>        rw-mrc-cache {
>           label = "rw-mrc-cache";
>           reg = <0x005e0000 0x00010000>;

[ ... ]

Sorry for the late reply.

By 'UCLASS_RAM' you mean having a SoC-specific RAM driver
(e.g. 'imx9_dram') that implements 'get_info' and a set of
methods for training data check/save/erase?

mrccache does not have the checking/erasing option, but it
has mrccache_reserve/mrccache_get_region public methods that
do not have an equivalent in quickboot.

In this context, it feels like the exposed methods for dealing
with training data do not have a unified interface, so in reality
the only common ground is the 'save' method, and that would also
need parameters for specifying the boot device to save to (as this
is an option in qb, but not in mrc).

Also, because you mentioned the SPI flash node for specifying
the saving location in SPI, this wouldn't work for the i.MX quickboot
implementation. The saving location is a space in the bootloader
that depends on the other components' sizes, so it is not a fixed addres.

Best regards,
Simona
