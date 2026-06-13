Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDFACD98CF
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 06:27:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B3C68056B;
	Sat, 13 Jun 2026 08:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="TYxouLC9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B23B683FEC; Sat, 13 Jun 2026 03:45:08 +0200 (CEST)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40f::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2BCA8063E
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 03:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ryan_chen@aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hfa/ds67tU8MCE5w7j8Nfu4TJizcHpI7uTwVtlWCwD0c8pZAXCf2+uZUjsF+c4vne9sMpLYl4dAArVdr68pBUfOafiqiuWfafd/YsiQrRLRptC/3lRMm/eF59ubytJjZC2VKlmhvQiNx7FGsOxQnJPqk9JFHmeVFTkz+uT1dAupWv5lSuFIAbXD/3a62pr+vFWaomAkAaLXb0iWO+LyzBLwTTrZzPfiydL7BUlZmcko6VqMmbg/LMpvOR4m6nJXCe9RhO40M60Rd9YK23dSvRTxNab1Pv2k7rIhqt9cdEQbrB9Ay446UrQ/VkRUHIre1zsqbJ8+isG9r03Mi7PrE9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHrZktO0tMjF7+h8Z1ITgOLgtQ+PAFhzdBvlLa1Ao28=;
 b=TlulePnKWE4DANOXVeaX9iXD36ccGytrvlIbNwxVvXpGwh2hBVBwPR8ulKpqQk9QBYjiLCGDITo9gcKbDMPAFHoJfpu7ZEge0isPRvSS0h8eTiDFsuY+5PYjSiY7cgO5fZ20dXKn0ytVtR2RyxyvXcXpsiQMkjPBUsTxJjkGmHdSvdUc7ucJyJD/+EtPNuirMcJwMHQFDNs5rTo66yssUJdA3yE5pPK/K3D53C91CIteSvyXHOR1eYiyciSyUyF+cgSp2u3/vN6Pf7QXcZ5WMITAMAja7Wq9hqZHnhFHUA9B4MXfh0Mrlc/zbEF2VBs02J0nqY0RsxuGwKrYu8XLiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHrZktO0tMjF7+h8Z1ITgOLgtQ+PAFhzdBvlLa1Ao28=;
 b=TYxouLC9G601btqbh3iDaE2FhMJTEg+DZmCaB9vWI0Vyst4lQwlD56RQRDj1g54D1evCoxN3kvKOUnmrzmz6CaX99NKiqW3Ef5FvUnr8qlgSP5idrPCBjh4/A/nskOdGFuCb7m/Y5oGKqKWdvuSLkqK9vn/2KfSPQJYVuvChXkEt5Rnu0M9m3/QWhTvlkRNCD0OZlMsNDAO8pZOIgAX0anR9zs7YmQZauIZKEoJN6ZXRJq6jYcS5bz5GTFyLSZkmKwuwlAwpDb3SSncksKV69IXGJtLyCUdMY7cc8lZQ5jEM4+ajjSIlOaQU3PO7LxcqkyrU9xQqWowu/L1TZSt1Dg==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TY1PPF33E28B4E6.apcprd06.prod.outlook.com (2603:1096:408::90e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Sat, 13 Jun
 2026 01:44:58 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::b696:e104:1f5e:7838]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::b696:e104:1f5e:7838%7]) with mapi id 15.21.0092.007; Sat, 13 Jun 2026
 01:44:58 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Tom Rini <trini@konsulko.com>
CC: BMC-SW <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Lukasz Majewski
 <lukma@denx.de>, ChiaWei Wang <chiawei_wang@aspeedtech.com>, Sumit Garg
 <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Tien Fong Chee <tien.fong.chee@altera.com>, Andre
 Przywara <andre.przywara@arm.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Peng Fan <peng.fan@nxp.com>, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>, Brian Sune <briansune@gmail.com>, Johan
 Jonker <jbx6244@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, David Lechner
 <dlechner@baylibre.com>, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Janne Grunau <j@jannau.net>, Paul Kocialkowski <contact@paulk.fr>, Patrice
 Chotard <patrice.chotard@foss.st.com>, Gabriel Fernandez
 <gabriel.fernandez@foss.st.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Finley Xiao <finley.xiao@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>, Kuan-Wei
 Chiu <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, Quentin
 Schulz <quentin.schulz@cherry.de>, Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Philip Molloy
 <philip.molloy@analog.com>
Subject: RE: [PATCH v3 0/5] arm: aspeed: add initial AST2700 SoC support
Thread-Topic: [PATCH v3 0/5] arm: aspeed: add initial AST2700 SoC support
Thread-Index: AQHc7Ke8r8q9DzgzU0apsQGQASmET7Y3JRJQgAEIegCAAGY6gIAA5XIAgAJZuJA=
Date: Sat, 13 Jun 2026 01:44:58 +0000
Message-ID: <TY2PPF5CB9A1BE6CE6A6B87F22D9024C1CBF2192@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260526-ast2700_clk-v3-0-a4cd24c214d6@aspeedtech.com>
 <TY2PPF5CB9A1BE61846EEBD7BD6648BE188F21A2@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <20260610180324.GC382693@bill-the-cat>
 <TY2PPF5CB9A1BE64531124EC1A606FF63FEF21B2@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <20260611135030.GA473203@bill-the-cat>
In-Reply-To: <20260611135030.GA473203@bill-the-cat>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TY1PPF33E28B4E6:EE_
x-ms-office365-filtering-correlation-id: 6db07ec8-34bf-4f86-7b58-08dec8ed6075
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|38070700021|22082099003|18002099003|4143699003|56012099006;
x-microsoft-antispam-message-info: gXnXHWsqAKqx81ZTehAuqrRuiSbaTygRcjgtpOhzzEC6E0FnYWmt/H7P1MLfl5tJ20vZFNsSDPcYZUUu4s3Z+6Kglvf3gJ+B5sngN9gbYVFGIOcU+JeHbXBgke4w9vMrJC2Vy0FGSZBAoDgUvf4374lpy7/2kQkNStOqqYW6VXHE9nnRawqg6h+fXhokLbTFPITb4XAHva9FanUtYW7sBvvOURKD7Z+EcMnrgQB6S6HHZ7PODfToZgNyTXzcD7/2JaycMZHu/ElP+loiPZxWbCjs3StCLZhoTm6B/Jf2zCv1DuPN7wFRrNQ29Efd8xBcChq2IV9MrTkDbs19193IhtVXdjkwmN5zpqD/L6dNe4tA/MZYjD/ddn6YtFrA+GKd0u9tR7o9/Sw3JG6iFj5OA0vqgwjBvtOmpDHCmICzAVmYoBQp6P3uQ5yrOq8QGYUAkoRKoHKl5peypgrFRtzTldgfLtrX+te5bUsnIE6bl+dVzN4OJ6wrZsDts/M1a1In6Hem9y3S1T0j+kg7muP0whGCuBdIqcsnxxaL3E2J/beZwYnWGW+gZs/UGPSETipli0G10hwNdbEqrHxm5QKXWwqcbqUSYbI8MbLQgmOQyknqXs1ATTr2mAGDgYuYpqQnb9bDoib0Uvy1i9lz0+/hU3TPgHmp4hV10w3bzVCUi/9BK4CYOU6+cB2aAIsN2H2ZCZKJEvHfTYrEdLKLSVynE2jtoD4N8i41rMOca0Yy7rif6Yb1wmR5Lmm9LC9viCCO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(38070700021)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FS7ZNmYrHStPRtZjRdEgLXH5cySW/NRj4LXBmdZ1P6Lau2afXWi1NGJSc56o?=
 =?us-ascii?Q?V4xHfmAtroOw6f8TxCwkwYOEZskZVn3ghBHRk0B9p0SIG84k+lCgDhc2cCZf?=
 =?us-ascii?Q?g5XjFk7faAA4cCE0CC1HpdwD5UMFexBJDCClljDhsO74n4JfG+mAZQR1kdwi?=
 =?us-ascii?Q?tQthmGFxfOPXAGkiOk5MGzytFFUlfUxa+xYxGkuqFAcuF/GO1l5i4yG2TkV0?=
 =?us-ascii?Q?QU5AmI9hgInKn63PQeMZKpUD+eqPy/aowzgXdR15evHc1UaWv9JERXUGIcXr?=
 =?us-ascii?Q?RzkrvDl2shWpSUPjuEVKHH6mJ13TQymmyhKD8GX08Xg/9ptjXfjUCuZtVPzr?=
 =?us-ascii?Q?PgbEvVv/6KEFPxzX+3eyKvPBisVHXUT6/OzM9SK4GC9WN3RAcJETLNsNc20r?=
 =?us-ascii?Q?urkCNG8mrKJ9T5seJqEtRvMfTHJL8dLduu8LW5BwvcfpzL77149XzjxU3Clx?=
 =?us-ascii?Q?mEHqxfYcirivuXI5jM/S2jEVJ5P007Rkhv7Lepv4QnDY3jeKir+SXihOnRdw?=
 =?us-ascii?Q?8eAS8iQE5+yiZlhQ5EiIhuawCnoB8E4HgA+2h/cugKekIU4+F7PWqdyvXUhn?=
 =?us-ascii?Q?w0CXizmB3zlpwMNmagQsxYxiJh3H7GUr1rzhjoW/eAuhkeWEWn0ZxVtoo7Oy?=
 =?us-ascii?Q?DsII3OPyIINP0K6zSo8KHYWe/wdX9ae9rGehzgcFVeckaK/OBhiV4I1kDD/H?=
 =?us-ascii?Q?hCHes2eVJciixo/tdBjS8Alh1Rz2tFKMjG/w+Q4RRyAv2rZzKgoN0jzTzgox?=
 =?us-ascii?Q?Dm3XzNdBaTDggunVE4kEOljr3wXDjW7Dd7OJZFN2cKhmYytR6HXa8jxPsdgm?=
 =?us-ascii?Q?LPxjhXAqJ8nsuRwy6Nc2MhAO0kWiyC413EXU2usLZxC37J+4/PoUqzdUG6c4?=
 =?us-ascii?Q?RPPdwjHY0nLpzuotRiWTyRgB6ExFlhyihqE53NQzi9DTkfwiOsaIhtiAECPi?=
 =?us-ascii?Q?ZasSBX8qp2G8BZKSnUVl2bDynz4tT6hktskA8V+6z1dAeU6Jl6PuTcXEh7zo?=
 =?us-ascii?Q?E+ca9qKZOgKUYcVTyEIWWbWDqB4gvfzFt0SRGcVCSK0NYlrNiCD4v8vCHyNn?=
 =?us-ascii?Q?ItsLAooB0OdP2qQAqX3klvDmeBYOltHm8YvnNt4zCXdMs5pHCvs+zjbwKUvM?=
 =?us-ascii?Q?1A2kcHrj6urqxum1RJTdAjJZj0PxclPpVcckdioS2+2dYQ5bbEvx4PMCKJqp?=
 =?us-ascii?Q?g/6qccZron+/nyBiuMQiYf6De7lLNe3JnwlkkkcGvMRdYjLdr+c0fPkgTrxe?=
 =?us-ascii?Q?avirpVugYhEkOI20U8eNqBPzAYNUuWWmHxMvvaCf+mxyHYbMFQkwsLg45fEB?=
 =?us-ascii?Q?1bR2vHyi9NgwKMwOqYRlhJaykOMiqvKXqxvTOSpO2vmLojYPNigtXZEXaES3?=
 =?us-ascii?Q?TLCWLMUEBCSGbpaLMXoAKCFfIHp0WF7f7cBvjIGOn8h8GuyyxQ19BHxlLdSL?=
 =?us-ascii?Q?G+OhLt6WoNzy4cm5nL4Lk5lQimfwS3IhaOEtAie4TWI4XBYByBm9TxwS3jHp?=
 =?us-ascii?Q?2hPVzJ30vkwPAgZ0hWWmtXHQ8WEROQ9eufd1vDhcPooVzuPjhS1u5xx8G+Ay?=
 =?us-ascii?Q?FhKlsGUnqSX/nh7tK7KJ1WUN64wvijKDUGJlGGVF4T2aF461kxdCjr2bk/EO?=
 =?us-ascii?Q?P6AV/qeMxnk7DOufkB4TbqrrCAoYpcdlYIcJuh1bR46DEQmQLnhmsvz63YFm?=
 =?us-ascii?Q?Nn3t5vrxHB9XLhQ7koJyw4Kx8jLGJz32bhScAbzipN5k/t+fteL8dK8QvzPs?=
 =?us-ascii?Q?/rYyJsFYFA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MB75wk2V+r4JP0jvhJ7zspk45+YKSexpv0Q8nuxEmAlHOkia/7YVjAl7IFlMGeQRBlH7NOVcd/idshOhr9b8/k72k5EFB3DPhqoiWKB8vVrspXV+4UjwLAyPpq/DRvq/Pt/aZNZS4b8f1qBnW+ovV5MM2z8U0PC+EkK3Hxv/6WUqE8FDtldTmM0Rf0JAa83rQGfGr2PbGLh7N4zz+DmbR+aSViyOlcLheQN1le3NY6Our6kqXXMuekm9EZT2lPpwYp91mtqpaz6MWCtptg75rGnT2jvUGZRUWwLSCWNJVjib/c6107YmfKMR5JNr63ywoPqGaopFtQfMJ14Ze7E+Vw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db07ec8-34bf-4f86-7b58-08dec8ed6075
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2026 01:44:58.3823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gdqSvL4OMi7WxBc9dW8+4MYjz2oNgXLxlHat5L/4plSh/Wlw1BnvmF40rf5yhAqlGjUSVRfC8ppMOzeE95vg/wXXf9F8S8xxNwIPp6C8tlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF33E28B4E6
X-Mailman-Approved-At: Sat, 13 Jun 2026 08:27:32 +0200
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

> Subject: Re: [PATCH v3 0/5] arm: aspeed: add initial AST2700 SoC support
>=20
> On Thu, Jun 11, 2026 at 12:09:45AM +0000, Ryan Chen wrote:
> > > Subject: Re: [PATCH v3 0/5] arm: aspeed: add initial AST2700 SoC
> > > support
> > >
> > > On Wed, Jun 10, 2026 at 02:17:53AM +0000, Ryan Chen wrote:
> > > > Hello Tom,
> > > > 	Will this AST2700 SoC patch series can been merged?
> > >
> > > I expect to take v3 in to the next branch somewhat soon, thanks for
> > > your patience.
> > >
> > Thanks for the update. I appreciate your help and will wait for the v3
> > series to be taken into the next branch.
>=20
>=20
> This currently fails to build in the next branch:
> +drivers/spi/spi-aspeed-smc.c: In function 'ast2400_spi_segment_start':
> +drivers/spi/spi-aspeed-smc.c:127:24: error: cast from pointer to integer=
 of
> different size [-Werror=3Dpointer-to-int-cast]
> +  127 |                 return (u32)plat->ahb_base;
> +      |
>=20
> And many more, please look, thanks.
Thanks your review.
I push the v4 fix the issue.
https://patchwork.ozlabs.org/project/uboot/list/?series=3D508727

Ryan
