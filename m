Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA1DCCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 08:06:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E68082A9E;
	Tue,  4 Nov 2025 09:06:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="nLLlHabC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FA14836D1; Tue,  4 Nov 2025 09:06:01 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E21498144A
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 09:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoSZWxvAdNpRobnVFVZKbRGNY9F8WfM7iPGQqi83rmqyld2pmR3UL4s4DFRQE66FXnDY9OmD9ipAXwQSj9gfkBedARyQ/LdM1SqGhzjDCNjQnhLCLSeiguPJgX09+ueoCsHpP5XNegPvaFIrHvQJovF9bSqqRImVcYP0DgpywNSryHzcDFcD+AXKzLanhA44bfbeVuNxjpA1WAVHLixJzsGgvnljsu1LV7UDith3D6Llc+K4608pzX03772spIoulFgVerGfJmPHjlrv/C3dMnMK54+/2QY69uiYnc0QzMsSm3TGo0iwVCO5HwLNbV9noF4+PX8gtfVxD1GW2ycYAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uX1f1BD9brLkVTa1yAqhsWuvinh0HVy1b7UCU7tKVuQ=;
 b=OhYbHCT9hjjpvjJMpZElTeVmWo6PwSxxh7kTyprFqaOyD8tGtd9VNv1HcrkRXcjxRhDFEZOTVX+4o5W6dieEiDzl+CLzufZ3psefY6lQh/8SQgkqYKWoBCDxxIF72XVlGzIZTM9ZUM5mYIdVJXT0Q6n475FCAQIUrHgT82wWAJO/ONXaXkYCUimT9l1m05wpBie7avgVcY00l5E451BlTOJLlYI2tFJdukmvCK9LCoJB1lZlUgkeuePB1Rlw3gk5I/7A/imqOO5x87LSDvEV4L+rcoBt5OVdg7huOL8qpHzrBQM1/BhB6ojuxOLxF8lRH/knM8xJUiV2ehrhqQrDyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uX1f1BD9brLkVTa1yAqhsWuvinh0HVy1b7UCU7tKVuQ=;
 b=nLLlHabC+0xDiFNGqqxoHAvDKRlA86Qah9icIDEFroqaL7KGyOc3xz1wZjrgzZzZZS4XqbNO8PMq37h9HI1SIu788Q8yJUTeffPzWl6doOSIAmtlGwweOhNfSIVBnAGmcHl4Z3ocfRq8EoKJgyhzhIjsxTWHpUTZ86Isa8o8d0qh4brU8ikd3OWXKYhM3AjxNJe/7Cachev99/odYIwFd8cmCr9zF0mD6cjyjU9kPIUgS3K+ClMVjvtD/vADXoNz+Ou/R9DEN3+R2Qz6Hy0mj/D3VvbEmyMoqv0xAlgbf8vvnSm/9QsFMJQ5y2uGsIkdIaRKm6r9op3cyAtbjtnZUQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10853.eurprd04.prod.outlook.com (2603:10a6:800:26c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 08:05:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 08:05:53 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
CC: Alice Guo <alice.guo@nxp.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Sean Anderson <seanga2@gmail.com>, Tom Rini
 <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>, Vinh
 Nguyen <vinh.nguyen.xz@renesas.com>
Subject: RE: [PATCH 1/4] clk: scmi: Bulk allocate all sub-driver instance data
Thread-Topic: [PATCH 1/4] clk: scmi: Bulk allocate all sub-driver instance data
Thread-Index: AQHcR7zp4jV0iKBiu0W688MtdpysUrTiM8FA
Date: Tue, 4 Nov 2025 08:05:53 +0000
Message-ID: <PAXPR04MB84590D1D084E14A5D6B6BA7188C4A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251028034225.260469-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251028034225.260469-1-marek.vasut+renesas@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI0PR04MB10853:EE_
x-ms-office365-filtering-correlation-id: d44d5d0f-f504-4e4e-cf25-08de1b78f9b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|366016|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?yAjvLoHcv/DUoYF7gZezd6GJ/SiMUoIL0PWa4ixhYCnoU+s5Rbjb7WOWuqn2?=
 =?us-ascii?Q?AtBu5tOviwjGwroakNZUxsE1lVkRUnWBZYZFAqIweaMzOybAaxa06098L8O6?=
 =?us-ascii?Q?Nq3RLBr8e6WjBJ2HK+asUdLlXazmI0VV4ux6nGbHiuBtiTLHQa830GiY1OEf?=
 =?us-ascii?Q?xAuCI/lND5HRxsVL9e7Fmpg3H7ynMXGu30FxLbcPFDCwaDQvQCjclaPFBNBc?=
 =?us-ascii?Q?vecWedxo1k5+HA+8tuw9PgEc9zsD4DFICxVUYG86wpc/pxXYM7hhwxvNA/AN?=
 =?us-ascii?Q?2SZm7K7+TdPgKgB5a16UVgr88d7QD3Db1rRLe2xOeKUWA0OfVuK46QaNzpI+?=
 =?us-ascii?Q?bbuAnGlIWtVEK8GocxGMh2a+8CQga1ecbYzKDxBfHsLmU/uUkt2ByVBLAGJC?=
 =?us-ascii?Q?GKw2P4+QBfo4+DZgeUMEGuUj7LYOl9E7uHveGjGnYWVF0hz7gtDTcII+VGTt?=
 =?us-ascii?Q?5NPYhNyv6VVmrDZi9MaB02GzPM/QMmje35yZ2/j1U1rzeOpGN8qt5htBfn15?=
 =?us-ascii?Q?zSwb1cKrxXSZCi5A+fwPgKpmyaqZa1w4JwNbG1FvSvZQLSAymOV2dcyMUi0z?=
 =?us-ascii?Q?O5Kj+lDQVMLJRZ/ayyiZdiJG9H2JqMxKXNZby+Yd3AqduayRKeNqOQtn0Riv?=
 =?us-ascii?Q?LybCDevOFq/hvi73bzWZZxOxwWke2MwC0IlEI8P6fI5ssc32OldA3EcuklyG?=
 =?us-ascii?Q?KbjyYxMmdT0mCSd7Smtcdh5fA5mLenK1eMxAXJoFapinTSLrjp9PiutiRqWs?=
 =?us-ascii?Q?YH44txbAJ0VRhGxH6It+KwxRl7Sxn1XN9E5hyiEhAbvP0LJcJZlrBbv0pEET?=
 =?us-ascii?Q?y0B9tlDTNSKIHMExZgx/Lojs2dGnYv48S2+i7EC3UyFgFU2KABzCcy9HhmaC?=
 =?us-ascii?Q?QQb3lt0gJ4YIgNGCpnb09b09PhM6yuEVGzGkYh/E6zws/5uOwbWrMpZQk4xi?=
 =?us-ascii?Q?UiWTvLgdIeG8WubmtUf8DFvqES1U928WwRqQ5nrWkUxHrkCsx8NG4RZvBOgb?=
 =?us-ascii?Q?+NEjjLC0OUzdlqkrkHAGFyBR26sQcMaRfSi0M482LwPayD4ef0lz/xG2+umD?=
 =?us-ascii?Q?drAC9YA06aka2ATHarzND25mdvLwboGzpKevfscU2AxEuz/dVy/8DGDlSh+B?=
 =?us-ascii?Q?ZsDbg4edbhDIsPr1eIwVbCF1tFI9jeSWlAwcZI38ltl2oupumGZx1XGFB+jD?=
 =?us-ascii?Q?H77vYVpaOFHr0K6JbjEOzwIRkMXefOaVrVW+6uRzEy1fWQYYQL+2OXupEcTm?=
 =?us-ascii?Q?xslYDV8nyY6eRkzwCX0yY5Mf5LvryolYmfXxaQd9fBROKO3iuBrQbJObltM2?=
 =?us-ascii?Q?d/gaOcnHz5sWznZ5gRI4yTYunIRetJ6B7iKjQgrFFvgAjyT1W2JZE/675nwJ?=
 =?us-ascii?Q?XCqdo/nuhsq5GXGbmrXEnoaX7rf7hLR/Fd+q+VLHUsAOa+pTDB0bwgJJf5HG?=
 =?us-ascii?Q?ExQ9iTuTCCfdaF67XscW9fiyjWhywXVnGuMRs58m8qTkWV7ver9R8b9iZrim?=
 =?us-ascii?Q?VerOB1SsV6D8ShjOxvvTC/CMNpeQTfzVIHsl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c45JApaXyH8Aw6lG3kgKly41GE4s5dV++gXoe+/xLCOjssjTJpKetA6HO2LK?=
 =?us-ascii?Q?a3wFGMXuMsOuGTbsl1UgkGgoyxtyBrSMyo1swBGGqgzdXsX0OmYJBONdyDe7?=
 =?us-ascii?Q?NHDUha0pqkCmk6adao7QIV2z2f+y2a4qedq7hkr3q7Hlvx+6o2+A7CzVwvPj?=
 =?us-ascii?Q?Oiw61JRF65SkIzsrAOE/kDXuTUppVBt5DlG7d0c8LiSYOc9qt98y00/iwwh9?=
 =?us-ascii?Q?MacSO0h0/01YfP69O13fw9Y/NChHzrNuw2Xm3Sk3S+sMkjJL7WqmhgbQOXrS?=
 =?us-ascii?Q?bPUNspinFWtOE63ZCVcdBfoV/uF3LeEeKgy/FCyZaBwZlflao58dqAd+vZlI?=
 =?us-ascii?Q?8llrnkxqaj8Dl0E6FHsAR6BHIVUXLaHZZNDKrqJeMmD5DNlGsgc2vIj3Y9fI?=
 =?us-ascii?Q?+FnkPmLK4w/1RCWU3ybdl6BNL86OwqCBneojjUT3auohbyzfdh7w9ouSqpdu?=
 =?us-ascii?Q?DSn/OTB1PjUesZ8f3r3oNjg2CmbkhHiieKAPMvzHZfwYiq3uBKdk0K/P0X1Y?=
 =?us-ascii?Q?4rHRfiff4NySP9rmLm7VdGeu5w2m5tFp0CLgYehQw8J8C54Y5sD8+apnr2w7?=
 =?us-ascii?Q?LVOn4IULR7p0kBrwlOrjo9wPbYTcGCuBbuppw2+tviw5wuhuNVTWHu3bC7Hz?=
 =?us-ascii?Q?pTqHwXwcjuu8RuXzsXtfIpp7AM12yJSMlgvF65LKN6yyoBg7oZzyvN+WTz8w?=
 =?us-ascii?Q?A1BdyW6TrH00AXBKHKRem40Bg6p0DCjuAr2z94QBstjvhU6JqqA6/+gTDzUA?=
 =?us-ascii?Q?B7ScNFWCTuSEuxX+KzTGTbQaL6kDa7+w30jBltBXwbZY/SmT7bLvGStcOxve?=
 =?us-ascii?Q?ehij2AFly1Mq1MSDYXmcvdHCqIq+GqUaBeLbx74JSd/EpbPmmrtzrDBUTCXl?=
 =?us-ascii?Q?iiieVWNTwnegk7Vghf+4n2wnAXRSQOT9bcF4vGl9PcmS1udKWYc0/61iKS4w?=
 =?us-ascii?Q?C6eIf4Zs0aiVXRkwjZstXcAl3hZb1oBWdi17mMmILVcEi4u+RKZeG9ODMTFL?=
 =?us-ascii?Q?UeL1s9XJIo79UaVaPdoXyltHSuyvhGnwCBcwxebuh+1C5EDI0ormy+XWcvNn?=
 =?us-ascii?Q?Q24mRcvxKnUiGQIsR0x6avBbw/29ZPw7C089Tfxod4QL8wrdzPNXLJgLNZnt?=
 =?us-ascii?Q?dM6e8cXTnHbWsnSr5qgDijSH6xfzqSXbZ5eKlQTQk/kEOV3iuOV6MKzmz+Jz?=
 =?us-ascii?Q?2w83g4o07T+9Oho8F78dBYjztRsuxv3RHbnXT58nw9uDkmL9hoUuOg+upEDA?=
 =?us-ascii?Q?5dL9Uz0P6k/ugGcOOjl0vxwOI5vy79mvgMRQmThbgjGF4qLnpKQ3qzq91bIa?=
 =?us-ascii?Q?8CkLmq3wbh+DE3kfRWK7ICJXtR7at7a/bXqquW5kNPlSrn57PsG/7A984hoT?=
 =?us-ascii?Q?mAkQy2gEHVVXmOLa4dCeSlrPTvK0w4WoMpegD9yXg5hylDnFNbTQ6hWe2bcB?=
 =?us-ascii?Q?rLlrSk5lcuqTD29ARAU7zOxcSzcdP0IU/EnwMbVcrKkCRcvO/fxqHefJTakV?=
 =?us-ascii?Q?5O774DSk/HUQE47atl0gFm5l1jQzKnNcDbvzXE7HhR70P3liLvl0SlKN5pw0?=
 =?us-ascii?Q?hbZFQSavXV3fYFVYgnA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44d5d0f-f504-4e4e-cf25-08de1b78f9b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 08:05:53.2748 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mLSANGzD77AVGC4TAMMWwBsb6fVAHi/ZhBVJ9KY1VZlufEQtGQjY/T3BmrM98TJhI8Gc/EKMtdkdcALwhDJZVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10853
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

Hi Marek, Tom,

> Subject: [PATCH 1/4] clk: scmi: Bulk allocate all sub-driver instance
> data

I just see this patchset was delegated to me in patchwork. But
there is no scmi repo, could I use the u-boot-fsl-qoriq.git repo
for managing the scmi patches?

Thanks,
Peng.=20

>=20
> Allocate all sub-driver instance data at once. The amount of data that
> have to be allocated is known up front, so is the size of the data, so
> there is no need to call malloc() in a loop, mallocate all data at once.
>=20
> The upside is, less heap fragmentation and fewer malloc() calls overall,
> and a faster boot time.
>=20
> The downside is, if some of the clock fail to register, then the clock
> driver cannot free parts of the bulk allocated sub-driver instance data.
> Such a failure can only occur if clk_register() were to fail, and if that
> happens, the system has more significant problems. Worse, if a core
> clock driver fails to probe, the system has even bigger problem.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Alice Guo <alice.guo@nxp.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Valentin Caron <valentin.caron@foss.st.com>
> Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/clk/clk_scmi.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c index
> f9e17c38cad..0b64c73a61d 100644
> --- a/drivers/clk/clk_scmi.c
> +++ b/drivers/clk/clk_scmi.c
> @@ -283,7 +283,7 @@ static ulong scmi_clk_set_rate(struct clk *clk,
> ulong rate)
>=20
>  static int scmi_clk_probe(struct udevice *dev)  {
> -	struct clk_scmi *clk_scmi;
> +	struct clk_scmi *clk_scmi_bulk, *clk_scmi;
>  	struct scmi_clock_priv *priv =3D dev_get_priv(dev);
>  	size_t num_clocks, i;
>  	int ret;
> @@ -312,20 +312,23 @@ static int scmi_clk_probe(struct udevice
> *dev)
>  		return ret;
>  	}
>=20
> +	clk_scmi_bulk =3D kzalloc(num_clocks * sizeof(*clk_scmi),
> GFP_KERNEL);
> +	if (!clk_scmi_bulk)
> +		return -ENOMEM;
> +
>  	for (i =3D 0; i < num_clocks; i++) {
>  		char *clock_name;
>  		u32 attributes;
>=20
>  		if (!scmi_clk_get_attibute(dev, i, &clock_name,
> &attributes)) {
> -			clk_scmi =3D kzalloc(sizeof(*clk_scmi),
> GFP_KERNEL);
> -			if (!clk_scmi || !clock_name)
> +			clk_scmi =3D clk_scmi_bulk + i;
> +			if (!clock_name)
>  				ret =3D -ENOMEM;
>  			else
>  				ret =3D clk_register(&clk_scmi->clk,
> dev->driver->name,
>  						   clock_name, dev-
> >name);
>=20
>  			if (ret) {
> -				free(clk_scmi);
>  				free(clock_name);
>  				return ret;
>  			}
> --
> 2.51.0

