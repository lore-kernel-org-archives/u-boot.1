Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A59CF34D5
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:19:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C672683F8F;
	Wed, 19 Nov 2025 16:19:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="HKhRfJDQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DF0383EF9; Wed, 19 Nov 2025 16:19:43 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CFF783F8F
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 16:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIzIuTmbv0Lzgjhk6SjJ4xxdiglk6GYAbsjDK7SkhrOt1cOtpCReJ1SouMkUdzZaEwdejq9w9AjH9NbntxZgh1+ajvErBQtNeO5NaBix1DnhvyrACi09DcK8jaalA3e1pwlMTf5YBc0rhZqPamct9uPTZ+jxxjQKvN5DLS8PTRwKhr41NZfe+6/7/hOLzpPLaQfdb0NNvhjHRwSrxVly97xbZQb94uN5XctNnrue0+6C5T73g/JQi6r4vScTQBx0BUk69IatR++cOsQYsVjoC0PC/kYf09HNcUdFY+LaZrE3g8iJkJaRaXSMH26xTG9mfb66cnEJ1s3Z7McD6WXFCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgfQWUQdJ5LL9G7rHUQLVYyAxFdsRR1DwfuQr7I0CbM=;
 b=mGmSLnAencvuTKLbwohao7Ob3oQWP0+vsO1VvWzkIYJKsVq/Wu+tl9AQC/dRmO7Dt8AIF6ewu6CuTIXoaOUkuHFAKB6eURhAiaYbG3DmY+rLcy0C2YShKwx05Xr1zP8mObbHPLuef4C/6RP6RVCLY0Gn6UpjkdHCcDhh5pl+35tUopvvclMitcug3QFH5zBpKo7Evg2Nm0S2+z3UbvyXjCSkHvmxeSzXsI7AI+sqIAWUCCJ6u2Nowmuhgij4s5JYSFMLro5+wxSURoyrlMISVwXHaZYhGLfJruV7HIPRDr41et7Y1I9u7V3jxrcu8PLTd4rV/S9e2MRgpvZzGON0aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgfQWUQdJ5LL9G7rHUQLVYyAxFdsRR1DwfuQr7I0CbM=;
 b=HKhRfJDQ9eUWgMrGtZTiNwo/pox6k5gkBB6iO8wbuIeO4JAnp5DJZ8hoRDjY5YXqI28w237jI7Yrx15SjNOZzgBiJr+G8N/h9Rhv0Krd3V36KzfQSGb2SW567aoX+9Zcml9waym5Y1FmAdBqa7kVvTjbyEXO73gWVrChilx+wjkrWlMWrl1V+v+lZHatlSJHLmgZ8I11VOeeqf/rYk4383kB6pLe+6n7TjRAvumJX14PgKrl40XM6FqTIxwPbRsxMgJDikHVz4aeHOm/AJCTYI9aik9BduAhCXlmCGBywijUiWS7sgaiY2sv02jQkvDRXRpsOVwcffFSLTMY1AKwNA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8619.eurprd04.prod.outlook.com (2603:10a6:20b:43a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:19:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9320.013; Wed, 19 Nov 2025
 15:19:40 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Fabio Estevam <festevam@gmail.com>
Subject: RE: [PATCH] imx8qxp_mek: Stop disabling device tree relocation
Thread-Topic: [PATCH] imx8qxp_mek: Stop disabling device tree relocation
Thread-Index: AQHcWWPd262IboXJs06BJF1IEambBbT6HQIg
Date: Wed, 19 Nov 2025 15:19:40 +0000
Message-ID: <PAXPR04MB8459570ADA7B3275FBC6D40988D7A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251119145030.842143-1-trini@konsulko.com>
In-Reply-To: <20251119145030.842143-1-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM9PR04MB8619:EE_
x-ms-office365-filtering-correlation-id: 26ecac88-4da1-4ea6-7bf3-08de277f0f1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?/BD12cCuPf/IiCSM4xAGA4vId/FWXfWl4vGePGOKs/aPrzXFyx4w5PvdgQiv?=
 =?us-ascii?Q?EJps8CAm8/RSYgJLr4WZhuEReoapNJEZ7fvAwZkOkhOplA6pre7mQwdUJBLK?=
 =?us-ascii?Q?EdBhobchhbtGWSesJ9x9M+/jkvDhjT6s+Cu0oArLe2nCC2myU6Fw7O+TNlv+?=
 =?us-ascii?Q?gTAZAxflRjx6FFUq+cWe/FavHLXqzfvppkCNgYyGxAWZh8h8n6zrwQiFiPxK?=
 =?us-ascii?Q?MedxKYHe98JrTagrndpQjebz+tDvfkQHDacDe0sAQRvyBy+IGaXDxJ1sXCmm?=
 =?us-ascii?Q?MTnFq+W43RuO7NDDBhtm/33vMLWtw+7U151eHlg3vtTR+JzWX29mE3Nty0Lt?=
 =?us-ascii?Q?Q5nyFEqwgo6Re9SoSuNhIYkqbCYKRU+oSzKUQa3pQsrKsJHMB8TPq1UiGeMA?=
 =?us-ascii?Q?W+bzWe3hWm4q2dCya1iLvKFdbl0SRRdeQBQCtfK7X70c9bcrutQUMPKJB+g2?=
 =?us-ascii?Q?ljltTfN58JbIV5d5/GUj5k0HsJKgx7GN0haHI7b/Ymw0mgO4BJIDalT9sbNN?=
 =?us-ascii?Q?S5+YForrEnWS8OTGjnEUVVMyVKemkqBxuAG44V5hQjj+VheLmu88h1i5/VUW?=
 =?us-ascii?Q?RQGOch3Pmv0Zb/1h47+vijxkohpGLHsQvMaRUkPbD5NejueIEa87q3h9afrF?=
 =?us-ascii?Q?+RjCivv7ZUeG7RflxKabz+Vg9j43iIxBHVXQJpNIqAgABVyiil0PoBHKQpIQ?=
 =?us-ascii?Q?DfrqQpHuKI4A8IDevTRYEAcYOqjYv9hqLvyQkw6XnLZsk8mjEXGlcTLju4Zp?=
 =?us-ascii?Q?F0DHD1IVfUvMjBeP8P0YVcVkf/NO5D98ufHT1x3kA3Z1xNM+4Xy5P8dksAt0?=
 =?us-ascii?Q?NXhlVFCBVvHEFKWhoERqSz6huJ7pEfP4CW5OUp6dOTHkjdg+ZoKphEOg9jZV?=
 =?us-ascii?Q?N1s41M1wX455S1nyjFXOANfpX1SpsDVBu3rkm55co0h5NKROiCmQg8WClIiO?=
 =?us-ascii?Q?StJxGMPMl6WieDIEThI0lg8TrIubKlSRa+jH8k/0FRzSe1AHOAY4PtTzsnMK?=
 =?us-ascii?Q?ZKOiiIgXMjTiyRntqlcHMjHWfGb9G9fl61LwOBqrlOVPO59+Y4RIgoNclQly?=
 =?us-ascii?Q?Ccx+JApxjlU1lwWS8jcqaI9X6LQsLV6U2x/Rbx0G4pMPxB02p9v+gW//9nOV?=
 =?us-ascii?Q?J/EhG5XyFpjs5nJPZgV/JRPk0AhgnL1K8ZMTNIgvlPgQh6FrkpTKU5L0tMza?=
 =?us-ascii?Q?0Xtjlrxw2fhhN3h9wsrzhqj6BhbLgkY/D2mW1dQzA1aey9JP+OHdjHGkP0uX?=
 =?us-ascii?Q?IqiQQCP5HJ39l41BBuRgB3KXAsZHlOsjW8jnJqNXeW7GzQnR9Rn+xOsFOF1r?=
 =?us-ascii?Q?kOHZRXq/7G4K6RX7ayyHRliHf/vYbrzwqT3z+/0UJp7c27UdQV4MBhvhRuLT?=
 =?us-ascii?Q?w0DPY7RPCUcXNYWWH1sAF0pJ6Na788Ij5MnkR3cGyfOOaI5dHB+XAreNP/m2?=
 =?us-ascii?Q?CLpFIapwLrVtxABjWEi+GwEqQTqHSzaLaftoUQ9FC8EVbhtk5itSPTrMGTZI?=
 =?us-ascii?Q?ulgOlf2ZbRjMBFqNI5hy1KOJT8xLTOB2ruRa?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8D7Gjma2NZTUEhklo/C4FGzBHTpdC/2uIh+FNNOS6vOCSXqzV1chWVYBew26?=
 =?us-ascii?Q?VulgMAb53/Qkj+q9xFQwc3/HMQAHbHr0L5GzL5VpzT2vdF9wrZ1hoycTj2kP?=
 =?us-ascii?Q?ZAA8tZPEvQEV340jFzZ5Mbz1q2pZmpT+/V3rMMHI7yYbL3ZHX90JJr4eJifd?=
 =?us-ascii?Q?zaX5viGH7b4JNYnX3LQ/hwSvb+tkZZE1BaRvX3oogXdv5Dpn4efUfcMPEsUG?=
 =?us-ascii?Q?bIz/bo69SpOX/JwpnfKjlGH9K0XpfgoZDZYpDEZNzmQCGiSxjvr8MhNlfigB?=
 =?us-ascii?Q?0X1g4hmHMXbxpeb6UjHLCkLmVXky+NwCdOaNJjbnoQeEHpfrfxKXLx+QED7u?=
 =?us-ascii?Q?0OgqxswT5ZBMAy7MZahPvtvWNAq1O8z7OTstKnZnkkX3montp4joZ/tMP/Tp?=
 =?us-ascii?Q?MyqxC/qjGgCxT3OKbmvOLL71fK/iHzt86AJ8jgfIcA5yDoCZBgEcJ9qs3HJM?=
 =?us-ascii?Q?FhrbCH98DFWL6l29YNVLr5uE6+HaLWg8lxC6i8JanUuuQjEYCPLUUa3gwSzj?=
 =?us-ascii?Q?hjojKj75NQFfeMOJo2kZhSJezqJ47DfObgxVjxOnWxPgrlfNN/7c2vnBoffF?=
 =?us-ascii?Q?B9qJP1p2vdR85DS+pcJtguRGtwhZgJL1kmNiw5vdYi2Ovy6dxK5MRvu8uijg?=
 =?us-ascii?Q?Bql0SxBHFS/Vk9O51SaK5mkmiDrC/zFSPJpLJ2gaWmbGbmCbT8aqkwK88k3q?=
 =?us-ascii?Q?nYuc2ptYwF8TKFVgZnXUUUEcbXgyUlA5h6Lk0xrdp3OiVyAau25LqwFq1c/d?=
 =?us-ascii?Q?ctZt9cnfSCHPuBA5N0lpIfra0h+snZwznnvImY6iGSXslyQujbAXjeza+JrC?=
 =?us-ascii?Q?e0HoiC/bFdvlzCZ8oAucn5gt/AZX87v1j7KS82SWlf5AbV2Dh9mlPoczHVJN?=
 =?us-ascii?Q?RP2tqVNnxxJy36sI3lJULOw449nOPzaxNFwHu6owoXACi2dNbD3ATnkm8Lc4?=
 =?us-ascii?Q?CtlWOo4qGcnrVkh0MQj0wJzNPT1a/uQNB+hNEgM/KKaAcO4rm6RdcwHoExgX?=
 =?us-ascii?Q?B4KaC9YN95IyShwuFA1pClAJ4AyTzcs7Pa2LPed9NNTmS8dsZe2o6Te9ofY/?=
 =?us-ascii?Q?hkx9dGtntv62QGQdowgoIwAtY9sCzhHaqdMno8WRO7b5L2Oh0gFtqiCy0oTl?=
 =?us-ascii?Q?saFWQDTe8HViz6QzGyG9UD1VDpvskgjJ184Dpqx+tGCQei8AV8U9H0wkkvNI?=
 =?us-ascii?Q?TxB5qy7tlNaGfI9ajhDtBB0nuB3hUX2xtV7kP035H3tEvZ9Ag7O4GVgfRFZM?=
 =?us-ascii?Q?dWf7Eig+LgJ+mzx2bYW8myfILuHs2DxjnZZc8a47RdW8TQhBn+eC/BcBgdo8?=
 =?us-ascii?Q?C2puhiIJcnswje+K2/i6IGWFY/yVHHTBHMvoVa8/1X3NVPlLEUvPfi8HO2YY?=
 =?us-ascii?Q?1ZgcpCnaAbXKXuyF1qdp7V+5rdSo+y/dHxSak6/V4dLSD8OmfashMo8TsyQl?=
 =?us-ascii?Q?wRdE+eXQZvrsQRjfw/Q5XuDLbi/KZvXAUGLoLlRBbXEB0Y8yZERhH2gdQM3w?=
 =?us-ascii?Q?3fwrmONQHUYWvvVdF6I6uGdhb6ppxqsM4R5oTl1CX5QLUZX8PFQFee5oxPfX?=
 =?us-ascii?Q?gNfUDDTYBFtk5Z5t0Hw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ecac88-4da1-4ea6-7bf3-08de277f0f1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 15:19:40.0450 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2dNH7kowEhIlKpp/v1uawChnuZ276q3N8fU/6GyCMMpleiCngkG7Usfg7mDbLS2isagmlhPrVsPA/Npvcfc35g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8619
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

> Subject: [PATCH] imx8qxp_mek: Stop disabling device tree relocation
>=20
> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from
> correcting problems such as having an unaligned device tree and leads
> to various failure modes in the OS.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
