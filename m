Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D14CED25D
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 03:34:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C91A088CD9;
	Tue,  8 Oct 2024 05:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="SJd+QW5M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D35D988D4F; Tue,  8 Oct 2024 05:34:33 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E48588001
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 05:34:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZKerbrwec6+bQ7a5Y2CmzDrgkbs2gcDvH/euyo3Wn5YLQOrSaufI4xld/0tp2Zx6Lf+Ekn09GJnl+AvHVo8tM0pYgzN+UHsZAeepQRZKpE1U+aY0nSSD8IS2g65/5AqhrmhJe33TiZKxtZOZHN7rq83uGhhX0sqw4CCqRJEZw69fk8c/F1jtTFMkT16SJYkw9RgsufoG5RrzowgG4Dxcxs8IPxtEPJy9BIZMVtmZ9u/LnBMYZl7OOjvGodH2zcJnIGr7uFBZNmAG/BgSDELONTHoRFCAZ3wFJoDHzWusUPoiUIRAZIQs/CsA4uuRBNunsfpGkAry8Z+DSro1+RmEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaoNEcP7YDby+qotwxcK4EDARD5TC/vLl5rMermW+TI=;
 b=g4E9SR7igoy3B/Ck5dWoXbFiQ2mfbKJ5qlKbRjTjteqHWaWtyJ6Y7nKdx5rdKko2qDzDAI+nVU2OJ1a9aCWOBF4Sr8dzSMhVn5v+ySro+Ht+IXXRQ64ELAZINT4SDfZpisotRmTA/wX91snTq9h04gO4d+RnroKjnfp/VX5aO51jM1LjZAwody03zXTfU+F95uCTGG29kT3WbP8EMSaYMijOCV+FOV2nJFfX7EbeS2yzCgayla65kJodoW7nYj+StVtBwuhDayZMsCjd6Fv07n47viH9uDaZBUWVLTIqy8177E6jhG8LmJBsgMmgOFtP+nWYksm9A5fk+KZYvafzFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaoNEcP7YDby+qotwxcK4EDARD5TC/vLl5rMermW+TI=;
 b=SJd+QW5Mkm9dMZX1Dj5l3yld8iUqed8700UTPzschbv3ccTLeRtiUEiF0DHDcxe8W+IWQlE0rI9FCWn7idP0leq30pgSD+MD7RRlCsOSBiyCORZjRVQ52juPq17jeMXY869dKCH0G4dIYWAWud3UpDxmXvy5rA+FTKqsaXx318fbn47c0pvR/2QH3rZcMXjh+S77brj+uKKQiFqXpFgW52bagzOAIPMxu/MepfeGzYolapDIjQzb10Si6PcYgpiMtfeYxzg3b4OGlzU7IfEpXBFdvOx8tRf9u4Q3DzTXsKFYR/QMfuKAIA6sA/xX7YJtbVHtYfdNqVi4TNzVhZmWzw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9665.eurprd04.prod.outlook.com (2603:10a6:102:240::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Tue, 8 Oct
 2024 03:02:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 03:02:13 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "lukma@denx.de"
 <lukma@denx.de>, "seanga2@gmail.com" <seanga2@gmail.com>, Ye Li
 <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 "etienne.carriere@foss.st.com" <etienne.carriere@foss.st.com>,
 "akashi.tkhro@gmail.com" <akashi.tkhro@gmail.com>, Ranjani Vaidyanathan
 <ranjani.vaidyanathan@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>,
 "marex@denx.de" <marex@denx.de>
Subject: RE: [PATCH 4/4] clk: scmi: Add workaround for set_rate/enable/disable
Thread-Topic: [PATCH 4/4] clk: scmi: Add workaround for set_rate/enable/disable
Thread-Index: AQHbF9OyDcW5nIgSd0+Loya6sBNf9rJ7hcwAgACm16A=
Date: Tue, 8 Oct 2024 03:02:13 +0000
Message-ID: <PAXPR04MB845968B949F7390C01400008887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241006093825.2800013-1-alice.guo@oss.nxp.com>
 <20241006093825.2800013-4-alice.guo@oss.nxp.com>
 <20241007170244.GZ4737@bill-the-cat>
In-Reply-To: <20241007170244.GZ4737@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB9665:EE_
x-ms-office365-filtering-correlation-id: 64bb752a-da66-4b13-2a07-08dce7459c1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?qBoKBJCVcPJ+U2TQ4GLY/koblczsHEcETq8SVxpnH6X5p9OVA+yMGaupqSG0?=
 =?us-ascii?Q?ZnHzceecCgj5My5AwlbJVmqpsu+hDdFWkLvmtSagIP9DpFCOU0PFS0jn6p78?=
 =?us-ascii?Q?SdxGGH7MUqcEIuElPxh7BoLY+jO62qmVAKCxPeFvERPGCGV36KAx+Wy4CzOc?=
 =?us-ascii?Q?MzOjY9PUzeNcIhSt2etaSnE/hXw9adRb45YtLZMPRO5M8kyijZk8oL1XAZ+c?=
 =?us-ascii?Q?w9qvst3JoZ0yNg4zPwYFqEomb1R5SpGjg2V0ePeoziJUnR+Ie+C6G8ml7kFT?=
 =?us-ascii?Q?OPnf7r+3uQyATI9SbuUAswNmylTMI1LRoaHedEQ82WzsTvUAQlz70+F06pXA?=
 =?us-ascii?Q?A4IGwDejKCiuzTm4nbqxavM0BYEWFs2wp03noXhg8huDgP7PCgFYU1aYkarT?=
 =?us-ascii?Q?5hzy+PKXsYrvSKwObCK/sf7uV7ZrqwqTJT+JjuXqs1RQq8QNp3nBIibT2p/+?=
 =?us-ascii?Q?UDIsEPnNkKeNd9GKCSY/i3la5b0VV7t6sLZGyBWIYGnEdClMeLqgmIEmyZ5Z?=
 =?us-ascii?Q?xqtnEsSaB4nhnXYk1lUK7PdRKXOPYCIXi1wyOqc1DOpqHuVm3mgresFodZVK?=
 =?us-ascii?Q?hkWj5aTYJHE9QOQjaFiN1Os/2T+/5q7nl5G66sR2q7Vf9KsNBV6ZQgkoYZdW?=
 =?us-ascii?Q?liwkt7EOQiNTk456alCO1XH/c93kGlVjuL8joa/240mWiaGHQmiiWSlPQBYl?=
 =?us-ascii?Q?49P3LLwDAqkM/tZVUOHJAqg/fth4hZO7D5oYZ5+zq0l/ZsVyTTvZWo6/PllH?=
 =?us-ascii?Q?0I7DMw6udFg9glA72u+ppYdwZx1uvSg7Yo1zyPaq6qj3gXQDNzZ0+jiImlyx?=
 =?us-ascii?Q?xEyea4FmnKvmHbC+pdJ96TjxH1m+BUs9wUOXaF6GrKB+oWdGD7NShM/GL5js?=
 =?us-ascii?Q?2Ekj/Rjx7iRvP6EXNgmVTOwdDDhW2IVfG8h0V4QUVwCqMcSzr6NLRQxllv9n?=
 =?us-ascii?Q?y24epNBlOcZJIs1/8nyyCwQq4snbWip3WrsGAWwR5wzX0TEX0IWqtOyqWruJ?=
 =?us-ascii?Q?jo+ZVYnv9XCojj9InkzKW9AzICNJP+MlH7rkLDsJDranWX1uHwUhq8zcmc4X?=
 =?us-ascii?Q?nDWv032bRbgUWtBz6b0bsux6PjVdqmLL2TGY0Fg4mltMdmT4FvbF/b6bFE4U?=
 =?us-ascii?Q?LB0Zs6Czmlity+NjPEOlkA4TTb6vPzlK0GVSHImPCtml5iFLZjlw3c+QWzts?=
 =?us-ascii?Q?6te3hVrX2civffpYPFugQ+PmJ14p384F3IlBEUXdjnso7K4tkAgjgdXYV2iq?=
 =?us-ascii?Q?ERHXwCAcNP8U7f+IC1AEuXX/TE4NxTDNVkUf9kuJ9SIUJP8KgBh7ewo42/Dp?=
 =?us-ascii?Q?lrs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2UMjOq29b110UG9jI0SIFi5kqu1FO/PQUFwU9FRx6tcGR2vzAsXAOlFc6U54?=
 =?us-ascii?Q?Zswboq5rcV7pgDTDxpwf+bHGk7VHbcJ9r6JxtN00a1UerrUSiVUYSYn6/RL2?=
 =?us-ascii?Q?RuKlD5BWBOAQ8aEk0a+JsvMloM6ByN2BFdzmsKXQAJGCvlFagzrA6k75YOq5?=
 =?us-ascii?Q?H7HCoM/gxKPcIA873VFe0tYMyPFuuOcTgw8tRC1biPqqTSUAE2xUG0RjRLqU?=
 =?us-ascii?Q?6Efy9Qpdwve/Qhd6CsQNJTHvZyp8JcovNWOE4/9DqpoRxdLibETxLFFHYzb7?=
 =?us-ascii?Q?cXheih+MkD4JlDuuxEsI11oACHF4BgvFgQ0+JvJ44qnaQe+xd2xZsHiZy6xC?=
 =?us-ascii?Q?sqoEqKZhj1gcvhhmDQHutbXQa0dMDF1REv5icsasyQYwMWKORJIhGT925+i0?=
 =?us-ascii?Q?AxfZCF+t9YeuzwwcMAWxNimLzCOsRAmqa9TCrDTaWmGtJV/pUF3QCBDXQYLi?=
 =?us-ascii?Q?0STnhCxWryhCFFR1YfPcpSt7Vbb6l7KU+CCZxiqS1cMDkWDcYLVdjN6bcmCb?=
 =?us-ascii?Q?ZjHj2YvXP/jVfeT+Ks5GjaUBQaK/K6Yqvv6TdDu1A+wGJXT6F/JlLXnq1EdX?=
 =?us-ascii?Q?GmGXLW1Tag0KxXfnZfHrNz4mVqNiK1c5SwSe6PPImL8R8nnXGff5MYjAoJFR?=
 =?us-ascii?Q?LTgLp+qdpqe7oGvdtfT7FmXCyYFBCMsXYEnQOZnDZT0qzBLkJes9qM4LqWZd?=
 =?us-ascii?Q?li7Rn15NGMJZoeY2UBHB26A0/meNhbHwFbqzV8a2meuhlAPLtePsmfSNJcsu?=
 =?us-ascii?Q?eQr28AhhKY65jdEC53LKrEPiPQqUnUTLg2pz3K/cBQyPwpREwqNBx2doeLoC?=
 =?us-ascii?Q?fP1FwVkSSfykBpR5/xd7sFS3RmahoPV43Gg8+2gCnKV8VY2BIvr8gvZ8TKHZ?=
 =?us-ascii?Q?L41rN4Ja5S06CTXRIlJNVNt9dLttscoOqOt8f47A7V4+fqz7mXq+cGtS9FMK?=
 =?us-ascii?Q?29lUNoi7fZWE3hat9McxH7wdcUzJILrvn5xUi7Ok3BorlfR9JRhAX9RlVoBz?=
 =?us-ascii?Q?zMXGFyn0+jftj4bcgYQ1yB38TIr1EdqfEopzsj6jIp/wWK++ZgM1yWOGN70E?=
 =?us-ascii?Q?D0qfFwB/A8rvX9xx3gA4xD6Z+TxHBuo0NzY/ZsOqGRkX1E7P2F3ukebdSf5H?=
 =?us-ascii?Q?Gf2VErXLF17LPZ3BS2FIkWgOgNHgOXrRu3dtvFUyHyBOGDKFmpGsBRw7lmYM?=
 =?us-ascii?Q?SpNQTbA0TAK6FWnBYvBekw11SYYuJPEbbln6+XB+ZOhZXpSlKkIVvUSl5qfv?=
 =?us-ascii?Q?cpENPDrBIfVVSG4M+jVXDhum+b0CsxSH+U67v056f42SVkFPRUBRAsS4P+7S?=
 =?us-ascii?Q?20DvIE8BgO4029yC/yIqliQl2XcXmyH3C1RD2MKmf4Bwb2IP/f6LhUkdmXWk?=
 =?us-ascii?Q?fmy4qIojCHQIix8u5BLrx7DrvX4/3LhfGfp9rlUkmlF89vsNne5Qvrto39F/?=
 =?us-ascii?Q?mEUCNdqzXd7jiVNg+7qHLW1WcXA+hN725KIXtje07ZUyZ7VYeKimJzXYxqna?=
 =?us-ascii?Q?KLPQ9VRwM02XedyD1NfVcReR4+/vESKam4jvue+GrvuxqULfMkENlv+SUOB0?=
 =?us-ascii?Q?EbiK//7sER+CK0zJIHE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64bb752a-da66-4b13-2a07-08dce7459c1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 03:02:13.7640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Khz9/Dr9uwqNHXE8YJq3579+DyA24Vr54sx/OHfeTJStNgOYi7MyCakUsisqWNqtRS9IBnBfZyeXfqoPJAqtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9665
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

> Subject: Re: [PATCH 4/4] clk: scmi: Add workaround for
> set_rate/enable/disable
>=20
> On Sun, Oct 06, 2024 at 05:38:25PM +0800, alice.guo@oss.nxp.com
> wrote:
> > From: Ye Li <ye.li@nxp.com>
> >
> > Add workaround to set_rate/enable/disable to bus clock that SM will
> > reply DENIED error.
> >
> > Signed-off-by: Ye Li <ye.li@nxp.com>
> > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > Reviewed-by: Peng Fan <peng.fan@nxp.com>
>=20
> In general, please include a cover letter so it will be clearer what the
> overall goal is, especially once merged.
>=20
> > ---
> >  drivers/clk/clk_scmi.c | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c index
> > a01292c479..a860a653ba 100644
> > --- a/drivers/clk/clk_scmi.c
> > +++ b/drivers/clk/clk_scmi.c
> > @@ -73,7 +73,13 @@ static int scmi_clk_gate(struct clk *clk, int
> enable)
> >  	if (ret)
> >  		return ret;
> >
> > -	return scmi_to_linux_errno(out.status);
> > +	ret =3D scmi_to_linux_errno(out.status);
> > +	if (ret =3D=3D -EACCES) {
> > +		debug("Ignore %s enable failure\n",
> clk_hw_get_name(clk));
> > +		ret =3D 0;
> > +	}
> > +
> > +	return ret;
> >  }
>=20
> This seems like a generic change being made globally and not a work-
> around for a specific problem on (some?) iMX families.

We have changed Linux upstream to this behavior, but better
in firmware/clock.c as linux,
https://elixir.bootlin.com/linux/v6.11.2/source/drivers/firmware/arm_scmi/c=
lock.c#L761

Regards,
Peng.

 Has this been
> tested on other platforms?
>=20
> --
> Tom
