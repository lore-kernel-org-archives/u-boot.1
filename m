Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F241DD21262
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 09:22:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D4BC88E36;
	Thu, 17 Oct 2024 11:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="ghtxTENa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5D3E88E1C; Thu, 17 Oct 2024 11:22:00 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E48188E36
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 11:21:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHPAALEes92hSI1I8QqwDU5xrMQbJ2Mlo2WwfJHuWtUjH7x3YHO6pAC5voN37MJmyC9vbqbHRCRt0PB1xYSwlFi38OQhnnkJqi+LdG3Pz/YwIF0rQKaQmsuhY1oTZeE2AviTMb/Rmo4yIAb1Eb5TmaikRCcpUyTAv7dv4LM8/7QdFdKQuI4wWAH7t5dYbnfXaXihUMT26ihiGCULZ/4unIw06BmbDarRGOhlAUFNbJrSzyv8azGF065n97MpWDQ/1L0sPUhVAzS04Ss46YuEpfv36YkYKzxZzFXHo6AjEG71f6EKjsFUK8muhBPrWIuHVQCcjEKBe1OG4VKPdmB+kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxeJBtyyNvQndf0oMJBAtfvcD0uh2OcaMmHQUWPYKMk=;
 b=YNRGnUcJ9yvaOgZUHI3MlNlaYEbcjUH2NrJCRYf+m3N6jQgyB61p9ODPtYRUGaWsGtOx4+PiuTJ1tGJdOo2ddAhFxI+cfa4iphWVo9ecfRQx9uXtqq8ezyYejsUL6itk7S0YJBuauuLhz+oMhUP9wbRqUQ1mpbHd6SpDU7vGBGHJK1BizZzS4zYjPqBHZcW+N8I9r81XeDXX1ls6c1GzGH8bcc4wQRNCt+y+luJcgrhDOqeCfMFeTSzqwrnxIC0/3s/HH+gJgdBrp1VzkyC1aVe+MR2yCUrt/W6PwIs/yLOQpznevO1bARGF53rgupYO/SgNqgXytLy5loMePULVew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxeJBtyyNvQndf0oMJBAtfvcD0uh2OcaMmHQUWPYKMk=;
 b=ghtxTENa1d4/0g3RdL9+2jkGRfXsS2VfVWY9l1KtgqJgi5+XK8KQESebjeFVhVlec5/jRLNmZwR9u4ddpSDwxliPT5aTgyLXkC4MfyoCTl9XSy9I1UgVDvG9d25gVzpBThQh6MJ6x026hBEppS03jJAGDEuntcqxHc2IENLW/9LG8k/opEVD7Celr4j/xIzzGGapShFKxkKpkfYQuFsOaiHCv31LVA92c8IpUzLqr0fSnbDUIkUdpDcI11KlEMCDYQvDwUiOnXEwOEnDGWsirYVQ05KLF8Fzw4MhPxxhCCCjyAxcsr9rbIj3GXQe+D1q09VtZXZIwomHKOl5LkOgug==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10367.eurprd04.prod.outlook.com (2603:10a6:102:441::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 09:21:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 09:21:54 +0000
From: Peng Fan <peng.fan@nxp.com>
To: =?iso-8859-1?Q?Lothar_Wa=DFmann?= <LW@KARO-electronics.de>, "Peng Fan
 (OSS)" <peng.fan@oss.nxp.com>
CC: "festevam@gmail.com" <festevam@gmail.com>, "sbabic@denx.de"
 <sbabic@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>, dl-uboot-imx <uboot-imx@nxp.com>
Subject: RE: [PATCH V2] cpu: imx8_cpu: Avoid revision to corrupt device tree
Thread-Topic: [PATCH V2] cpu: imx8_cpu: Avoid revision to corrupt device tree
Thread-Index: AQHbIGNnnH52cCnroUCvyoJvsosYnbKKqpcAgAAAh0A=
Date: Thu, 17 Oct 2024 09:21:54 +0000
Message-ID: <PAXPR04MB84597D20308880039DE8817088472@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241017081236.26742-1-peng.fan@oss.nxp.com>
 <20241017111936.6688fce9@karo-electronics.de>
In-Reply-To: <20241017111936.6688fce9@karo-electronics.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA1PR04MB10367:EE_
x-ms-office365-filtering-correlation-id: 31a1c552-4399-45af-313b-08dcee8d245f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?U6nfg9mwZ6qxPpB1To0wZkL5vZnzHLBDUWILnXe3netJaA2YI6GDBPF3wx?=
 =?iso-8859-1?Q?i1WMp7wXg7loocD1vUbSvk350N63iZ4c54PMm1yawreNDRuWoy2uTwcAus?=
 =?iso-8859-1?Q?jlcKRkRsoRth/wLrMqUHNmSX2TuVjb6qJvb2VbLSCz+J5OBhTJruNth6bd?=
 =?iso-8859-1?Q?TtNU96QFNfw7BtOXBOeGIUPla3/pmLasP+bQc/f35FEYwFyx8J8BAItzOS?=
 =?iso-8859-1?Q?7FPOuAXDinzhaS7U80aoHRgVvmCrEd9a7phAaLLA+YZdydAfGsBf3KsL4J?=
 =?iso-8859-1?Q?Mc8ERoQUoGKhaOieUVmL+cU2OfzecwS3k9jPXlyUt9U/L8GCRQGEMVWuRv?=
 =?iso-8859-1?Q?f+R4hp4L5d50a0O8AapBLcjWdg2H76OOraR33G0ScemxsWxf/Sx9c2RkMZ?=
 =?iso-8859-1?Q?m30JOyyOcp2l5VKgubZWP39vO+BmIYufkY+84KKWkzJNPY3OyWmue9U1P+?=
 =?iso-8859-1?Q?B9gxDCr19Pb07K8gP40kE+POffu2Zs4nS52AuQTirYlTpRXEFWj89eu29X?=
 =?iso-8859-1?Q?e+GG1SLyCpjc7zHGsrNipieXYuY6Kqj6s+ss/+kvisgA3PlF2d4TasSN5P?=
 =?iso-8859-1?Q?BQ0jvNcRXwrrOP16aObGjb53082wfkDjnJQG1Zzdn5kYqTd2/k4R2FUNP3?=
 =?iso-8859-1?Q?ratj/6bNet6Xaq2O3Pvo7chJ4pStj/ORr4V4XcV7Hw/LZSClSPEP1WCnqU?=
 =?iso-8859-1?Q?Rp9hbiCTpRGWIKhFpTmdRxHP7zVUE6G4LytCrqD7dlEOg8Q+rw91mZpQAB?=
 =?iso-8859-1?Q?mLudv8QBt0h0q7S1d1wE4k7q1UAL1efmgjUuifFhxC1mdR4ckNMCV2KfWz?=
 =?iso-8859-1?Q?HrH9TamIbdE7P0C7Qv/td/hmgSjKp9OzGb5P2EbmOk+FXrgTgHj6kpCsdd?=
 =?iso-8859-1?Q?tAmLcJhuCJldHEd05/HqJ91UuXNI/3nVfdzYjXnRe17jPoydWl7IIFLBeZ?=
 =?iso-8859-1?Q?959MjNeFv646xXF9h7b3tNbgELYDuIvHOUQR7ORrkoEBVrDlXDfAAgkpuy?=
 =?iso-8859-1?Q?TRSu1VO/fmqxXAvOfSOkmTEgSfHZeCaFwtDu9Wi2q4fg5+wXbUxVO2XljD?=
 =?iso-8859-1?Q?4UKTHM6I9/HrAyItWXV0s7hQ8h3Rdt0rFFKkpQPuhULNwPdShIM5EQpOj5?=
 =?iso-8859-1?Q?WiZiDB6mr8rg0kZ5lViFPzM+hy/9540+L41/Njo2Jb2YKIbzvXTOGED4qB?=
 =?iso-8859-1?Q?W8etRGSAaxHZyMeenWCPuBs9zWw1dGGVf7gwYM14qo3+I2L1RQ5uVOSRb5?=
 =?iso-8859-1?Q?j6Vay5rJgGZGX9AcYYWnG9ZvUk1vVb8Aatr+EegyWX55UdF4NhefjV0725?=
 =?iso-8859-1?Q?O6v8LvS20ay7KLHwzVxQEy5QhdVi6uQuQW/paW3pgPodhpqnNRpFbCA1Bx?=
 =?iso-8859-1?Q?nH3Nwg8+cN?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8oIVO7MUp9aud80Nxu9FRMQvel+p+yEN7D8LXsDXNlwIz7Tm03mRUD0lz6?=
 =?iso-8859-1?Q?KL8XIMzrIERN/NJWsIi5XgQ2E6jC5yTgJBTEl04chMWc02yoYLbPZY42dB?=
 =?iso-8859-1?Q?hgLrc72Fw55mN9BSRvnA8v8wix941N+Aof4tdLhn3AO2sfDXI1IRu6tx4Q?=
 =?iso-8859-1?Q?nqlcp2wulrS/uoJJfQbHwg0MdGy4TO9+QkrxgiV4mWYtYxUEWqvPrJJnE6?=
 =?iso-8859-1?Q?m3DekdL1x+9VRkPrfJqFnjYDQn7gbLxb7hNEAKIF9jgSOk45lyAWlcI4k6?=
 =?iso-8859-1?Q?S7cNBdUAvJOrj6NFIHYP6ZCmKrzBOvvOf65kbWKfAEh8AzOZdaa+UBd55f?=
 =?iso-8859-1?Q?+MvOITqHnI1agGgMlpGaLy2Y+/0ijkjr11Kmf/6WQYi4tcyIwNrBa3qAq4?=
 =?iso-8859-1?Q?SV1jud7LIjZlFDmlz2IDVg9sHYfnsi8RcAOv2kxrE5dgKEtEuuaNxXcMQ9?=
 =?iso-8859-1?Q?ztq7QCXYg/QE7tiLaVcWznaSox2ShFG0UmceBzg+RIf3wAae3MbfOLzyLp?=
 =?iso-8859-1?Q?xdf6DWRI+gasuuUWSQWSDlskkGZiUEZcxb2rUxAOkADIUqJwq8FgWQ40GE?=
 =?iso-8859-1?Q?vEgOL8EJfA5MvWPkvaqAFFUz54uMah35Yzkof+59ineeYXNVUiaLfbWl90?=
 =?iso-8859-1?Q?Pf6zidHymmYkEOZ/smB3o8K0US+yk6+Dsn1c/6SUbk2mtXxmspK1I0gvRv?=
 =?iso-8859-1?Q?aVK/5mmrt9oMRcf2mVnPnE6qwFcBjiGTAb0GEXZH0hflSFY7jz2TASBoE3?=
 =?iso-8859-1?Q?sYU1+nX5W5MbmZyhenirc11DYO9lmhi5wZy7S7FVJXc6WaSHWozYkaNzkr?=
 =?iso-8859-1?Q?/WQ0jhnt5mKTBmmCtz7TJcYwip44l8Yd9tofznuNHRdQU3SKTikNjceWR5?=
 =?iso-8859-1?Q?M7tZVVtkdSqt+498asksNK3q7k0jWxJpkydq+//0f0O8N2uPD6aJdXgalJ?=
 =?iso-8859-1?Q?v8YY2UP9dCh6LwuCYvA6WBInin8tC4yKrTI1MMs269w/34V8vv+R1I/VIH?=
 =?iso-8859-1?Q?WiW30h3q7qk3V+0bynI6fXwbLSx+qgif6Etbf3UQLl8wUbgKar/Z4cmshn?=
 =?iso-8859-1?Q?KsDtb38xkxbcl8X5/lKminB6Eym4gNcMW/JxKDwk8MQUtFuB+XnGgI2Nmu?=
 =?iso-8859-1?Q?zl1yBwVVideHz9mslukNpEEKjWHsCBu8xY7WUoWydTls01+X5F03RBnYn2?=
 =?iso-8859-1?Q?IjlCTM/qeM7NPABwr/IybCABzu1y9SPFst5/4DQMhctp70TumI9APqPOUv?=
 =?iso-8859-1?Q?Y0r8KN9NUd9+ZtDRmJNZkJlvJJR7EeWCBe1VwYtRddctx3QMT/FX++il/g?=
 =?iso-8859-1?Q?p4gjRcPSN0lYB0LfuNsl5oY+Cp2N2wDEJjgkkWgi6y+YJ7EWkTeyde5VMH?=
 =?iso-8859-1?Q?3P8ZVnH6AFKX/xF479mdsf6+54le/7S7ibHCZVpUWBFvrLLcAQ7g53aqQB?=
 =?iso-8859-1?Q?CK0gZ9SWr7fwqQUa53d26OHDhPwHVSIMnWirbepTCP1romo02pykjT4b4s?=
 =?iso-8859-1?Q?EzYQMXCe394ECxeibk9sRUKeqVKVd4I7MVn+tRuduwB1MB8rP+PkigXfSS?=
 =?iso-8859-1?Q?ZXwO8prOHZ6hjjBveyjZ5Xd29HYalh/ZjR1xMmCSdRX00TK34WPpue5xWC?=
 =?iso-8859-1?Q?l4V1MEiXie4Xo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a1c552-4399-45af-313b-08dcee8d245f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 09:21:54.7372 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A9Zm4CZcob4MvilvcXAJ+gDW4XKK3BLjIoSigsVgYSBlHXriHP3P3SYEwCGrsYqyRNoK2/ZrLAJ74stQSIiWtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10367
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

> Subject: Re: [PATCH V2] cpu: imx8_cpu: Avoid revision to corrupt
> device tree
>=20
> Hi,
>=20
> On Thu, 17 Oct 2024 16:12:36 +0800 Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > U-Boot device tree is padded just after U-Boot proper.
> > After the whole stuff loaded to DRAM space, the device tree area is
> > conflict with BSS region before U-Boot relocation.
> >
> > So any write to BSS area before reloc_fdt will corrupt the device
> > tree. Without the fix, there is issue that "binman_init failed:-2" on
> > i.MX8MP-EVK board.
> >
> Placing the 'revision' variable into the 'data' section would achieve the
> same goal without any further code change:
> static char revision[4] __section(".data");

This was not welcomed,
https://lore.kernel.org/all/20241017034507.GJ4959@bill-the-cat/

Regards,
Peng.
>=20
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V2:
> >  move the rev to malloc area in cpu_imx_plat  tested on i.MX8MP
> EVK
> >
> >  drivers/cpu/imx8_cpu.c | 35 ++++++++++++++++++++---------------
> >  1 file changed, 20 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c index
> > 6c0a8c0cbe4..b11f8dc0c91 100644
> > --- a/drivers/cpu/imx8_cpu.c
> > +++ b/drivers/cpu/imx8_cpu.c
> > @@ -20,10 +20,11 @@
> >
> >  DECLARE_GLOBAL_DATA_PTR;
> >
> > +#define IMX_REV_LEN	4
> >  struct cpu_imx_plat {
> >  	const char *name;
> > -	const char *rev;
> >  	const char *type;
> > +	char rev[IMX_REV_LEN];
> >  	u32 cpu_rsrc;
> >  	u32 cpurev;
> >  	u32 freq_mhz;
> > @@ -69,28 +70,32 @@ static const char *get_imx_type_str(u32
> imxtype)
> >  	}
> >  }
> >
> > -static const char *get_imx_rev_str(u32 rev)
> > +static void get_imx_rev_str(struct cpu_imx_plat *plat, u32 rev)
> >  {
> > -	static char revision[4];
> > -
> >  	if (IS_ENABLED(CONFIG_IMX8)) {
> > +		char rev;
> > +
> >  		switch (rev) {
> >  		case CHIP_REV_A:
> > -			return "A";
> > +			rev =3D 'A';
> > +			break;
> >  		case CHIP_REV_B:
> > -			return "B";
> > +			rev =3D 'B';
> > +			break;
> >  		case CHIP_REV_C:
> > -			return "C";
> > +			rev =3D 'C';
> > +			break;
> >  		default:
> > -			return "?";
> > +			rev =3D '?';
> > +			break;
> >  		}
> > +		plat->rev[0] =3D rev;
> > +		plat->rev[1] =3D '\0';
> >  	} else {
> > -		revision[0] =3D '1' + (((rev & 0xf0) - CHIP_REV_1_0) >> 4);
> > -		revision[1] =3D '.';
> > -		revision[2] =3D '0' + (rev & 0xf);
> > -		revision[3] =3D '\0';
> > -
> > -		return revision;
> > +		plat->rev[0] =3D '1' + (((rev & 0xf0) - CHIP_REV_1_0) >>
> 4);
> > +		plat->rev[1] =3D '.';
> > +		plat->rev[2] =3D '0' + (rev & 0xf);
> > +		plat->rev[3] =3D '\0';
> >  	}
> >  }
> >
> > @@ -318,7 +323,7 @@ static int imx_cpu_probe(struct udevice *dev)
> >  	set_core_data(dev);
> >  	cpurev =3D get_cpu_rev();
> >  	plat->cpurev =3D cpurev;
> > -	plat->rev =3D get_imx_rev_str(cpurev & 0xFFF);
> > +	get_imx_rev_str(plat, cpurev & 0xFFF);
> >  	plat->type =3D get_imx_type_str((cpurev & 0x1FF000) >> 12);
> >  	plat->freq_mhz =3D imx_get_cpu_rate(dev) / 1000000;
> >  	plat->mpidr =3D dev_read_addr(dev);
>=20
>=20
> Lothar Wa=DFmann
> --
> ___________________________________________________________
>=20
> Ka-Ro electronics GmbH | Pascalstra=DFe 22 | D - 52076 Aachen
> Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
> Gesch=E4ftsf=FChrer: Matthias Kaussen
> Handelsregistereintrag: Amtsgericht Aachen, HRB 4996
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2F
> www.karo-
> electronics.de%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7Ce7321
> 3a6bf874b3f204f08dcee8cd46a%7C686ea1d3bc2b4c6fa92cd99c5c30
> 1635%7C0%7C0%7C638647535847647409%7CUnknown%7CTWFpbG
> Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ
> XVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DjsnPkChbN7l4UlMJonwJhkn
> NBNwIPJD7c3t1j%2Bu%2FDiA%3D&reserved=3D0 | info@karo-
> electronics.de
> ___________________________________________________________
