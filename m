Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EADD2F7DA
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 03:08:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E65788E36;
	Thu, 17 Oct 2024 05:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="XZiq8L0z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ADD588E5C; Thu, 17 Oct 2024 05:08:03 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5A4E88E2B
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 05:07:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U85Ut4v6oaV1peq1oSfFyUeYhh38b3CQyDmatzjxZqV1L6QmRXTPk1UTnVWV17R9lTG91lpJlvSvDIfx54vAzcsxyi1hfWu91UyHLAZDue9g1GRnIHmJ6pRfqoXYgcGYUZObUnPWCoWO/E3zfam/kpOcdk/KIa37ZomQBae6nxRNafrHsWdlBXq4jCD4KKbvYlKRS6CCmXtp0BNqZTzEBh+6yPb7WGxAsUvh/zA2tbN+amTFgsfolGWqtaaZvezQS81eg5JtK40fbBSH3ny8Kvt5PlL1eBFMCYPAKLXvkDkTJ95pHwVMsgHritK5IvKjRP+fjxgVJTn3uaHiOXigjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjydUR+iqLYIwiPDIF9KVsjEmbPlYSu4LI9PNkkxTYI=;
 b=kKKBzQLaLMj+jKPamZglfBRuc2UI0+C9OyOij/QKBXD+i+LfyDieULk44yiVliB4nh7lJmROzluwn7oKBlIHOl7FeWtYlH0N+mi6CPpv5682EEvXeEhzDJRUEimML/KXa10p72t/cXF39gGen9bYwc49WO6VMohtrUp5xaJybX1AsQFvguPgX8dnI/cCkrvOBw/5JCNoOOgu+/86RKYKEND9WDvO0boveHbHmj8JuuzA7WLFEStd0HGIiiFu+sanxr+GwtXagsUgOeo6J+fMFekH6hzLSjoZ8KJRgJoUzPAQb26UfERCGjMXrNJfeSAamgkUbtDpuuVji0ZWp+HXdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjydUR+iqLYIwiPDIF9KVsjEmbPlYSu4LI9PNkkxTYI=;
 b=XZiq8L0zZ9A305xyzyXocEwxnbqs7AILfnAaJ6Evdm8BNxp0BDtchxW7s6p91yuIuX9tcriTZU22550A2Jji4JsUBue/n44kXAPTbKB0n3cjvHsw/1tFp8V8x9tHRARdAWo+KWEaUDYTcaTsHqeQ1imTi9DyCKOccHSNYIriEPWpChH/aVGX+Kxv7BVqAi0m6JBQtyAhuLqkMan5BDjr6JT+IjFQH16e/kgbQJk9Pf9D5suIZZGoSdsXMKXI+d4CR1Ll9gfkn6JBINPJ50gXoYmNyeohfgeyKzby+oJv3I83Im4EQ9D2qUDj89gzMUHFlRLDXNpKkCq83tTr2OwZBw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8872.eurprd04.prod.outlook.com (2603:10a6:10:2e3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 03:07:56 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 03:07:55 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>
CC: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>, Simon Glass <sjg@chromium.org>, "sbabic@denx.de"
 <sbabic@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, dl-uboot-imx
 <uboot-imx@nxp.com>, Gilles Talis <gilles.talis@nxp.com>
Subject: RE: [PATCH] cpu: imx8_cpu: Avoid revision to corrupt device tree
Thread-Topic: [PATCH] cpu: imx8_cpu: Avoid revision to corrupt device tree
Thread-Index: AQHbG8OV2ytJDPNYZkWDYfI8Ze6VULKBxXEAgAATiACAAGYkoIAHgIyAgABqvECAACDMgIAAAFIw
Date: Thu, 17 Oct 2024 03:07:55 +0000
Message-ID: <PAXPR04MB84597B0578EFACB984BFB27188472@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241011105827.7729-1-peng.fan@oss.nxp.com>
 <20241011165616.GW14210@bill-the-cat>
 <CAOMZO5CSK74_TcubtN1W1MpVmTwTmbv_XfhaOexpdvoc5WGb=w@mail.gmail.com>
 <PAXPR04MB845979AC895A90D969E5F216887A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20241016184539.GF4959@bill-the-cat>
 <PAXPR04MB845987E412CB6526FAC7D7F188472@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20241017030503.GI4959@bill-the-cat>
In-Reply-To: <20241017030503.GI4959@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU2PR04MB8872:EE_
x-ms-office365-filtering-correlation-id: a268df88-2313-460f-aac6-08dcee58e5c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?SlCmvvGsbrJoG8KEIii0TFybHzNA0BvmWokIOki65sf6kUDOJwbr04/CVY6P?=
 =?us-ascii?Q?iK3yry+jkX8W9wOG0WLFGa+//AxNCKF/E6NDu28EO6E2mbhUC3yde+dQ/3TF?=
 =?us-ascii?Q?rLBbm82HbYbNQLcoABD+WDLSz3wUqvYddcEPdaKSiAtoQdbUa1f/j0Xd4Jdp?=
 =?us-ascii?Q?UXASo8hXFKBRX0EOhQr5aQ0Yq1jPl5gIXdKLSYHyvmAS6bzP2qrwhDweBC4D?=
 =?us-ascii?Q?7ObhkXYohn2d3UrI2uD83GIzAZP6dBzxnRM5RRMcRnIvCnLsLgbv5yuIWPWx?=
 =?us-ascii?Q?S310sY0VUrucfHEdHQDmONqMm/jAPOFmlZ5PxlbkUiSuqVBjzr1hNHaawGvg?=
 =?us-ascii?Q?mR7VoJP4sj7xWIIWCf86axMnZIfKXAq23P6DaF34ANCALLrgaXNflvKtcVRr?=
 =?us-ascii?Q?lUpRP0HAeNfaYt/hGtsb0easLFvIbuPk+DjPOu6h8pwB9Dc54CpDlgtfAhAG?=
 =?us-ascii?Q?1/wI5Pov3LfA943r9YmKKtZFJ0s0Y+hs0sJjphVik/TWGAH39MOag25uB5Ok?=
 =?us-ascii?Q?z9fZ3kAcgJs6S6/q17m8i/yIK+X8Uv0/Vrfg5Ev8NkW2hXtdSzBRh3tPOxZS?=
 =?us-ascii?Q?GQzBKXoW1AVILEPFeoNvXiRoLiwTIvYipXbtPZyU3Qu/vcBTVBLRYIAys/Dj?=
 =?us-ascii?Q?8DC4ciwymmsWOWjq4/LmpyU4i/X18g/J8mYQEchtBBs02YbPpIfRKJRdjzqv?=
 =?us-ascii?Q?rFFCYnyFfsFMkLkjY5ZajE0byyymindpaNC3NIXFJ0I0SeSp+A2TIhlqU7gs?=
 =?us-ascii?Q?RPD45+2PELJELHvasJqRX4AZBqVcxppi9jImWSfjb1gEmZWQNIin9+gGM9dJ?=
 =?us-ascii?Q?SjQx2PYkRjJ35m9vedAcxwxdkATF+UnGPeUAn7osTPXTtKcVTBB/nqXgfM0p?=
 =?us-ascii?Q?4Ont+MrRTNAY5RM0AoqirxP8lFnDFwcmpd6WLbGeai9C1YR1oAIJwC39ATOJ?=
 =?us-ascii?Q?5Mmfgj7TiXmRperOJUm1NlRkPoJtiLIqUZoVhIHI5rQDnEDuTYmiGr7X6dUo?=
 =?us-ascii?Q?FA2JUB9rpOmiVSTe2TTg11AlVwyBG8njXrtNH4jbfa3uJB6sDF9++sDqkJPz?=
 =?us-ascii?Q?mxbOQLc2dn51Jq2nr2vxRmSJR6fQNNrM8FNjMMOGoAINMCFgmsHtD6k67R3h?=
 =?us-ascii?Q?IVWhFiDVjL8Fs5bMSUTclrnR8GmZf7ykvItYhk00eLl0d6jyEnBnDLjX2cRq?=
 =?us-ascii?Q?j9OW8ow06KIExJyliMxTO10dbOYsxRXO6A4hLNql2cbALmYIT2f5J1hOnJPp?=
 =?us-ascii?Q?NZa58PlIq+bpyOjqZySlALecd4qE2IGwB+mTCchpawX6xPWQcaQeOQZPbnql?=
 =?us-ascii?Q?POGhskWdS4Vyqlo6KFWZx/SjWKjyT4ImaUDU6O8KruUEUPSwA+ALnmPrI6z0?=
 =?us-ascii?Q?g8cMAwI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1XqvRe/2xPU+oPhAzrkug8w0fTv/Dw/5PbQp+jRTjGU4N/Afm5Gk0nbb2+JQ?=
 =?us-ascii?Q?8MW6Djl4J9AgyC3J3IX+ppZoL/ShbZbqs1imD4HyHeFimJINcPYMtjdW3LAL?=
 =?us-ascii?Q?B3ym8mJ5yxge3CRTli4UFwob8O9a1eYpXAWcKdfcqFvZGgfsqQf7wh+TTh0w?=
 =?us-ascii?Q?L5C84z0LXcMBLzd8b37DDf7pFTJjLEMuVG1C2w87JqVj92uDzL1vb/efOdVp?=
 =?us-ascii?Q?uLkRUk/FnG7wqd249XrotSSqo3ijfvvr8saWX1JMQMoy3TUH+Ipk2RkoINKD?=
 =?us-ascii?Q?ttB0s6G8mzBrVyT0kyLJQvIt+k0k0ISSbTmyP/+8W8R+/YKSpIlkph3X3/SM?=
 =?us-ascii?Q?aMkUtIWgb7AgWfpFfYybvcg37PQ1z/cCXDsyKZrgCgdkpdcmbsx9l5Mp1/Uu?=
 =?us-ascii?Q?7RKjnz7h2QNMUMm3PhuUt6XyE+HUUpfovSCNvBzepyjbkRzj5QeqkiJRxJSD?=
 =?us-ascii?Q?YFkLAkiaDkiiXG8XQjPh6ukqBCRcVBcatJiZfjE2D0IsCsHkD+dCLn1sypja?=
 =?us-ascii?Q?mV7FiQmBEr8GITMzkumjik6gfBlJMMC8xy9XoykKSsTKw+8Anu1wrsqEOoiC?=
 =?us-ascii?Q?D+CxOlBeumhEBIo3cTUe9odWno46yI5+07LOMliqT9Vnlh06w7j0kwRjkkx8?=
 =?us-ascii?Q?tTwb8NLWcaH93s1S+/0bqTWeM5YVNhWBukbcHvIqafiwmpqa9kXSuBShx3bI?=
 =?us-ascii?Q?0ea9aGjJIU1REqklbSprR/xK+2HCRUXwhM9WRGTd+pEEm9Ads8a3eacO0V5L?=
 =?us-ascii?Q?SYCZnH5ZldVetrFC5YNSgfwvKT/rjXy5o8zO9HU/fA5OhqLdFEwpupzj1X9k?=
 =?us-ascii?Q?4uNY6s03YfQKPyvYHz+t/pAHiIKVy0OZJbx+7cNxfGdMK/eR/E4wr/9DFJ3p?=
 =?us-ascii?Q?RpSRK/RnGpkOwHdlo1QKKw0qKCUPXsx6pYqL9xzA1CoS66TDjrYcgcv4oRQU?=
 =?us-ascii?Q?+kCcrBjcey/7dfmQU0NgEPaAL/MRChmdIIvbKYX5AQuDcaENwAskc14HXcVW?=
 =?us-ascii?Q?ZDYqsXK4vpw49Q89juh0hNBTC+lYbUnwErpiZK9sDEgOmYPWhwMZioKc85a4?=
 =?us-ascii?Q?W2Ui2Wap+9YJeR0Kp8tbwhc4e/aw64HrqBqcgvm11E4DepFIBZi+bDsq9C9k?=
 =?us-ascii?Q?2jEgZMdy+3XYZx0BD+U1Lj49bQPZ7nPTqTg726aiPJ3e8E7N+I/8NBzsY/Zh?=
 =?us-ascii?Q?z60/b57El6G7U2M5IK4HDVwPfnaqC8Co2EdlaacY5JTJiEGFt7N3t/OBdTzO?=
 =?us-ascii?Q?RJkLNcy0q7SiEtRec0pZlnCSGFW7C9I5SEmQ93xW3u7hXobeabmbgqapPM4g?=
 =?us-ascii?Q?Ac8qgfOUQFW2sSsyJnNj1g2f6myr1hGQVQ5qCEjT1p85MgBBKN0ZjvMHJV6T?=
 =?us-ascii?Q?zHSLQ8HcVtPZkSNXQ1k9TDgl16U5LDjURC0sqhF1KiX+P/ItWngz/YnfsTjO?=
 =?us-ascii?Q?/fS/wtA/mZC3CbUleabLLsJD0eRpgqXFllw4w3yMEr4kIO5E4fdYmvCv2uqE?=
 =?us-ascii?Q?uCZ7lsSDXpGK4ky/ow77baTB3HCoxpewq3SQE1osvnwDvBlCMVzTtKfzEZ1D?=
 =?us-ascii?Q?H1FYcXDZKDH4KxXZtho=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a268df88-2313-460f-aac6-08dcee58e5c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 03:07:55.8893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4HQZ14WjPH8M5N6Xby3b74QRdcIo2qDFy7zK41rDf/Cz5A3Al25CsyxhnEEDbtl2QmxDGpgD5T8NazP5Xmz1tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8872
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

> Subject: Re: [PATCH] cpu: imx8_cpu: Avoid revision to corrupt device
> tree
>=20
> On Thu, Oct 17, 2024 at 01:10:02AM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH] cpu: imx8_cpu: Avoid revision to corrupt
> device
> > > tree
> > >
> > > On Sat, Oct 12, 2024 at 12:16:14AM +0000, Peng Fan wrote:
> > > > > Subject: Re: [PATCH] cpu: imx8_cpu: Avoid revision to corrupt
> > > device
> > > > > tree
> > > > >
> > > > > > Why isn't this padding and alignment with the BSS being
> taken
> > > care
> > > > > of
> > > > > > in either the linker script or the binman dts?
> > > >
> > > > Sorry, I am not sure what you mean.
> > >
> > > I mean, why are things placed in this position to start with? Why is
> > > the device tree not already in a place where we aren't smashing it
> > > at run time? Is this a problem of the alignment / placement of items
> in a blob?
> > > A runtime placement problem? What?
> >
> > Whether binman or not. I think u-boot.dtb is padded just end of
> > u-boot-nodtb.bin. Not alignment or else.
> >
> > This is a common issue, bss should not be written before reloc_fdt.
>=20
> It's possible I'm missing the examples in my quick grep right now but,
> yes, why are you needing to make this device tree change so early? We
> should not be using the "put this in the data section" kludge unless
> strictly necessary. Why is this necessary and cannot wait until, well,
> further along in the boot? This is supposed to be for pre-DRAM-
> initialization stuff.

You may misunderstand.
It is imx8_cpu driver probe at pre reloc stage before reloc_fdt,
so the written to bss area in imx8_cpu driver will corrupt device
tree which padded after u-boot-nodtb.bin.

Then after reloc_fdt, the new dtb is actually a broken one.

Regards,
Peng.


>=20
> --
> Tom
