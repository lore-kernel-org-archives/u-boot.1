Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C04CF9C5B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 02:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DE3688AFF;
	Tue, 24 Sep 2024 04:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="a0wkP58r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 661B98814D; Tue, 24 Sep 2024 04:56:52 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17562880DB
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 04:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyrYcnKJPZ3xIpNdtFIz7oRbt9ZwWfm1N1Y/6q0URwiz7inCF4kh59lYIwPBwG5LJREx4qzP6T0IBvzwR5wQKrTATN3BJZL9GK2dd4aYdGwpHcidrhuZDzYYsq66nW2Ri9nKnRlfOl5k63PVpxqDtA4KrM1Pa7wvVSqTT7Zpo9ZFe2K4gx0vDB+kPng5QoSRQBAqbzvuxRoTYQXAqbNtiH8S6YtqWO3RI2HAof4UsnATADp//nGASCgi/bTwd6Vh5LsHEOlDcAcrUyS2bw0RBx8zm48OXOk9a6NaKeNn3Rs+7/tyr2K1SobHqGKN6lJTkVtKl4NjTo990SrICrsuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TM/slX//C7tuUTHZIb7R5UJJ9TxPFKqnUKj8qtj/8GY=;
 b=ITRJJqiuDexGLjQAU75KbffcGYtrAqCZ0sdET11Q4B9obRkKys8/I475KYV4Xw45ZKQ8OGAKhcNBVo1vrFthol6q0HGdfuVx9D0zc/76urg3GS03I1o1kWtBAyTWHm3a5CfyyoUexcLFNTpTUHeWdvDek9Jn0EQEz996y53tneKwrIURebeR9fmMZ+muezMLpyHKfZPcoTMT5Wg1HEDJiP19syns3IJ6qMMfsjkkC5gx61yjNwD1RrkRKKWQDzlmQDGoNS8phXNOFG3+Mp0zpFteuUIlJBD3eBxMMkkZBIwwgNkfFSnxDM7kdLu8+w7TI8C8FEVMG0W6eVvu7BoH5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TM/slX//C7tuUTHZIb7R5UJJ9TxPFKqnUKj8qtj/8GY=;
 b=a0wkP58rIt7KXBnXvTME2AKJTWRL78jZjJ+VAni1H5gY+Hb1NJZzYmWtyKkIt1GA69Ww0PDhxw4Z02mQLurPRbeAVU2j2KuITlN5XIbeKT2gEXieoU27QfhlrFTN3eayEG6hZhmhcXV7gyIV9XjNujnUCgP+F5C8FMoqkE8pbVLDUkYCYh/4EV/LjaMckOe/ZYZLG01l1098U7A4yiHD2ZNDzIwEbWEmToUkLWHzuqcakFMyl68RC1tx/5Q/gHaIr6O4LrtzhcBcCgFvOWd9D1zZPdgoGPAw4ZBae1NTRKMr2THIFEwaL4kbHU+F+I4hbWVpKUxq9xGQsXQ0r4H5AQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8975.eurprd04.prod.outlook.com (2603:10a6:102:20e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 24 Sep
 2024 02:56:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Tue, 24 Sep 2024
 02:56:40 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Primoz Fiser <primoz.fiser@norik.com>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>, "festevam@gmail.com" <festevam@gmail.com>,
 "sbabic@denx.de" <sbabic@denx.de>, "joe.hershberger@ni.com"
 <joe.hershberger@ni.com>, "rfried.dev@gmail.com" <rfried.dev@gmail.com>, Tom
 Rini <trini@konsulko.com>
CC: dl-uboot-imx <uboot-imx@nxp.com>, Ye Li <ye.li@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH 1/2] net: fec_mxc: Fix clk_ref rate on iMX93
Thread-Topic: [PATCH 1/2] net: fec_mxc: Fix clk_ref rate on iMX93
Thread-Index: AQHbDbGz4BzVcfPZy0Kz80Sb3g9sQrJlWL2AgADmXyA=
Date: Tue, 24 Sep 2024 02:56:40 +0000
Message-ID: <PAXPR04MB84597A12EC1885A64E34E04188682@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240923131439.28572-1-peng.fan@oss.nxp.com>
 <b77e571d-e782-4e7b-a9d2-1ca92df5c512@norik.com>
In-Reply-To: <b77e571d-e782-4e7b-a9d2-1ca92df5c512@norik.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB8975:EE_
x-ms-office365-filtering-correlation-id: f675469f-c1fc-4adb-56aa-08dcdc448375
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?TVtMd/pLUvKSP2lIDXsv+cDk0X4OdT5xDJoh8bn/d21+OPtWQd8R5kXtg1pA?=
 =?us-ascii?Q?41ADOj/UYoLZ0vTJCi+XqTOXpgvwGXG5vjFzYvUo4Yjv4/gwFGSvVcyzMoi4?=
 =?us-ascii?Q?8/LE4yNkbF9BlqZqE4AEuYi3M0Yp4dajxbQVjRaGgvzACD+68SSREjQHMod9?=
 =?us-ascii?Q?1eGbZYM3kuuACAS1o6914qlzMWcRe8MpBfqK1EU74Mnr/rw7imz0DB6pPFlD?=
 =?us-ascii?Q?W2kQB1T8oRwZEyHd3w2Gbz3sposnDhYQ7ptJHnuV6lxflnLoEYXFs1friNqD?=
 =?us-ascii?Q?ZfxJ76v+dVra0feo4Wn2dincuXC+vvSEhHQ1abSFYVisak8jNjzMKR90DbCT?=
 =?us-ascii?Q?cNvV3R5S/wnZ3MaEx2zkQlleL+qJ9+wFQ7v1lL4F6ri8Db4WSFPkMoqgVCzx?=
 =?us-ascii?Q?btPN6tS/AR3crIV/gMDVx35DyGib5TJMK/4qbZ27iULAmWYHj5ACWftQVmoa?=
 =?us-ascii?Q?Z04tz+K1G1ttVPJiLiyM64LX4yhCWpFMDirzHiawFrDD67h45cyWetzd2nm/?=
 =?us-ascii?Q?73fYw+QPrxvuaGBXrL9HS62LpqY8jYUZSJPP0i1RHR1pk0J0t0r6wsqgGhWW?=
 =?us-ascii?Q?4d4G80GrpcutlapAAq9y7y9RbgUo5lP19+xA5zkjTarotGSC4nCPYczm0GQQ?=
 =?us-ascii?Q?6BRV0ZWgXBPmsb0+KLwizwEqowJDABY2BF/rWniaz9klRuHaOqmPRjKUL5Cm?=
 =?us-ascii?Q?dbJvhF/xHq4mmTmBEhv6WUY9ezRdCXi9qotwFhjIUObJxC2WOI/irCZnuxbj?=
 =?us-ascii?Q?ZhY4pazppZZxp6adtKGcfe26cF/JzuEKhV7/o1NirrIqPUo6tsuWLagQgYlI?=
 =?us-ascii?Q?6b2QnkdnK0uoW1jgl0zXNNKKWNbuvDHbcNjU4P12QRx3a4sPLvdZiUqa37H6?=
 =?us-ascii?Q?FuZ0Wu+QYOjfhJXFBTKzyEkgu38zXUM/IOvuy9Vyk87/GotZJE2GVQrzX9/x?=
 =?us-ascii?Q?LeWT+/WIxys5s1TmnB4zg/rpdgkuMy50rq8IfkJv07mH/ErFUQe2Wj/aiUgZ?=
 =?us-ascii?Q?i85+13zE5jrvVFpXJNLVUTsBI51Qu8IG/f+V4ssTZTXML2s3ZxujK2NqX+9V?=
 =?us-ascii?Q?H+z9zeDlYt5PVHk/tcYA5p7/E6lOlp46+bu9p8ThlGGUAAOTWAuk/OaVR1AY?=
 =?us-ascii?Q?ljNJRt6UkfFDoJpO6YqgB5DeClCa4OdrT99+BaXgcbpWT56xEXqWEq20Z3Ea?=
 =?us-ascii?Q?Qb200Qwlh9OT303zcr/ngj21AnkQWzxze193k5YBQNVk8/El5EpR1rMdRMM2?=
 =?us-ascii?Q?WXrUZRUxn5BVRq4SytTszuIF2DF8p8aX9PzuN7lST1zTM/Quc+MwX2kpAF0+?=
 =?us-ascii?Q?WIgyPVWfLHOoAfWVTBiDCNpUHrMBOXTqOGaulO8DaF3CnT1IQ7fbp+STFAw1?=
 =?us-ascii?Q?NPezrJM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h8+3+dkT0VaHi9uOGNtQc3RRjCGRSAkoKrZkwp2e2xuhA1QcPE4/heKuIySz?=
 =?us-ascii?Q?tBzDfpI8bmuSOghDviNiNm/9C5qf8azt+sOLINBKgWzvnsZgM2ftIjwD9nei?=
 =?us-ascii?Q?gmr4BesfZrNH6ITYjIlrKZnH8ngf5d/IbBl4jL5r/x09W8WIbVKchYIZXipC?=
 =?us-ascii?Q?bTXYLjrOf8AlHjDD3FaBesMHGd9eJCnrZXBc/ae276W6LUSYeq4otPns0r4M?=
 =?us-ascii?Q?5Kn7BXOHXv4eXKGVA0zOivnedacko+u083naE0S4Um8c9mQp9un27eLKSWI5?=
 =?us-ascii?Q?8ydP0B4VcjUObYcTxL0WWR4DgkhpGavuVlJxjdYha52xYKu9kcVaCApF8HBA?=
 =?us-ascii?Q?fcPwT4yuGQel+8F29ocrAzKeJof2TBnePK4XYP0YnvpKLUznIffAufsuXLYV?=
 =?us-ascii?Q?csI+Ek4mrSrwn/4iOPHGqAg3i/na8p5ZAyw6HqvVCqDyJ8VBsPxYhjuFWKX4?=
 =?us-ascii?Q?v8qbjCQPaqqKofkcTGAWD8ivTr46vmk0cgWbTdNuM5DWtbOplSmhPkq2zLiZ?=
 =?us-ascii?Q?QZyzWpmRmOwshprxV1ER3HK7SWQnJjW4IiWbTRCyNyytE6UCLDLPsjMdfJ23?=
 =?us-ascii?Q?mwNUCoI5/WzV3Qi4AbzZG3NrLsgRGuuPXE1ZaFZ5xQoa10ip9CuaUYWoNzz1?=
 =?us-ascii?Q?aCLgH5QKUjhYqAQS+ZBUKQv+h+rQc6Q3McO55PDB3wt2BwrE1nimSU1burV7?=
 =?us-ascii?Q?V768CMAthDNBdMA22xYUcJHHOuLUzPSME5d1eqkn6Ur5yBuQclucrAn/mkMl?=
 =?us-ascii?Q?cvOL1qqGPIMJH2BbBl/JEaQ5AjhlZrUnen8wawcssY9oE+pjPQBamj6nv/I8?=
 =?us-ascii?Q?FuWm25c691xrmVVlzI/TukYN5K2oqLr/uuPwRQElry9mzseBVQHCKVXk4RVK?=
 =?us-ascii?Q?5+b5pYTYH9owJHap09J3UG2zI/+R5Hptp4BtqLWOExTNZjmBg9B3qrnOZZMH?=
 =?us-ascii?Q?bSU8TCDsVs6QXI/5Ijt4LD3k+n/rnqatD+12wbFIY4jNtYJYqeobv3tBNtMM?=
 =?us-ascii?Q?92REKvwc22rswBoWXVEqcHThbgMIj84+04f/qyd80GDU2wnnRpd9u5vOurKG?=
 =?us-ascii?Q?bt9kK0d3LZrADREvsVz++2OVpTvF9Srsb2Um3mZG5XR8q98BV6c4M3NF8WlG?=
 =?us-ascii?Q?Xgl9vavF1oqfwf5bqr93JVYfmVTJi3IrocB+pFWctF0u9Omipwi57PvGroV+?=
 =?us-ascii?Q?JE5Lo5N5JH2QWjv6TD/CYvJLiAsAULPstwdZXfTNVBJzTYSwp18vX0pXB2bA?=
 =?us-ascii?Q?jp7TpYjhyfn442kf0rYHz9Z3e01yvVncTFaisTxeQFH/Nap6JqSqZ1AI7vhJ?=
 =?us-ascii?Q?8RDPNjHDfLLcPikKEwogbMXBPGfQPVS9Im3J8jXTNssZR4X1gRBKNwLYinDR?=
 =?us-ascii?Q?fBsuFvEljj5NyG4cecyR7xfzQAZ7eb0DcijLtoq1aj9V4konI6gxf/nprRpD?=
 =?us-ascii?Q?HJNEDgWD9TIbA/hg/8lwWDofHCAneVCPntn/Chhkgie1cCEm0GQWLvM0gzl/?=
 =?us-ascii?Q?ODANYlfeXQBJR0OLHHkkf9aQ+69z2SCdbnhvSurvsqDsSZenSJihfISuwl4Q?=
 =?us-ascii?Q?4k9uh7ClwKr4wawx9no=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f675469f-c1fc-4adb-56aa-08dcdc448375
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 02:56:40.0969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RJ14TIUfkTV3T9vJ1iByXdUw+52DJmNVJpYxHDpajaYkVPU8J0liZYFsQyfqQZEf5B3tJvch+9FXOU1AZBTABQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8975
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

> Subject: Re: [PATCH 1/2] net: fec_mxc: Fix clk_ref rate on iMX93
>=20
> Hi,
>=20
> On 23. 09. 24 15:14, Peng Fan (OSS) wrote:
> > From: Ye Li <ye.li@nxp.com>
> >
> > Because iMX93 has a internal 1/2 divider before clock input to
> network
> > controller, so have to set twice frequency rate
> >
> > Fixes: 09de565f76b ("net: fec_mxc: support i.MX93")
> > Signed-off-by: Ye Li <ye.li@nxp.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/net/fec_mxc.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c index
> > 0a0d92bc2cd..e5d7f0f3e1e 100644
> > --- a/drivers/net/fec_mxc.c
> > +++ b/drivers/net/fec_mxc.c
> > @@ -1215,6 +1215,9 @@ static int fecmxc_set_ref_clk(struct clk
> *clk_ref, phy_interface_t interface)
> >  	else
> >  		return -EINVAL;
> >
> > +	if (is_imx93())
> > +		freq =3D freq << 1;
>=20
> Humm, but how did it work so far?
>=20
> On phyboard-segin-imx93, this change breaks fec ethernet.
>=20
> I had to revert this already in NXP downstream u-boot.

Ah. If you set enet_ref_clk to 250M, then you no need
this change. Otherwise you need this change.

Regards,
Peng.

>=20
> BR,
> Primoz
>=20
>=20
> > +
> >  	ret =3D clk_set_rate(clk_ref, freq);
> >  	if (ret < 0)
> >  		return ret;
>=20
> --
> Primoz Fiser                    | phone: +386-41-390-545
> <tel:+386-41-390-545> |
> ---------------------------------------------------------|
> Norik systems d.o.o.            |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> www.norik.com%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C482
> 464a6990d46e9668808dcdbd135d9%7C686ea1d3bc2b4c6fa92cd99c
> 5c301635%7C0%7C0%7C638626938825379940%7CUnknown%7CTW
> FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> wiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DkkO%2FnCs8%2FjpZ4ez
> JYDHo5T57jmUVPdp%2Fs34CnpwrsGM%3D&reserved=3D0
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2
> Fwww.norik.com%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C48
> 2464a6990d46e9668808dcdbd135d9%7C686ea1d3bc2b4c6fa92cd99
> c5c301635%7C0%7C0%7C638626938825421127%7CUnknown%7CT
> WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D0YIItswvK9V9zEcn83I
> h0IRjyzNGvqkM7vq4bXnajRI%3D&reserved=3D0>  | Your embedded
> software partner  | email: info@norik.com <mailto:info@norik.com> |
> Slovenia, EU                    | phone: +386-41-540-545
> <tel:+386-41-540-545> |

