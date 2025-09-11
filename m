Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E329CA1016
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 06:25:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B893A83236;
	Thu, 11 Sep 2025 08:25:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="TRVOmk0h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B444983280; Thu, 11 Sep 2025 08:25:16 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD81F8319C
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 08:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4+AprG2glSWQ49ifi98zqYshg5Gn3tbiY2yAwowL52pN28xctL4CVLyNUQPvSonYHzHjW86B1YEBgqSpuZx1rfVI0vQd90K0L/xweuKJvrZEYHepIMbEwE91FFfCrFN732wxaz1y6eqGMN1snbBvumNxP9K5DTKgdjw7ik/nmQWe8fsKngkE1bJ1YGqZ+O0Q1jYK6Lbr0Z9HK1F2q5X/VPBsQYGZxvkzfdd96YQcfSZqquHyn4VaVqxhmIQjXGBQ4QJBDKPP19Uw69uHV5FkAdykIydX0JwkLpVgCxmy5OsLwELGpJK3vhU9MmXhcDKzMGBLBtP1gzHuW5yszZ6tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdP9pw5kYK/WJlfQk/tZpXomC2Sm7c7EkFt0sZd3jIc=;
 b=hdlTrvvXE1vKfMvx+8zqvn7TWzuPDvuonGJJv8xWoq3kYHgrjI3KZtgF4pf05izvbd3wsCkC/leTjqCbxBuxApOhGHD+vUUY/m2/m61hVliTlyqsOu3zxxbAxDnZ1t0srtT3+n0J3BAf72DXp6611IlODxQ5CVZ7QRTlZ6SSN/ns5PBfihWs0XBZwg3VEhF+c7oHEPv3RoxD3PKQr4HrQkcMek1CQ8prU3f8mJqpwmQxGGifSkZJoIWHgVLHYMjjmy8/wx+T5lpZaEk+8hMPcoBIlUQlMOH5BICZIneeUwYFMUwbcuoiNzDy21rItcM+ZG8n1gKktUT2jTJ6RzjYng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdP9pw5kYK/WJlfQk/tZpXomC2Sm7c7EkFt0sZd3jIc=;
 b=TRVOmk0h8hEmf2gkyU8JJXdu+J02o0gWYRReqHRw21Dz3+1jt74Q/J+LydMiq/AJIULMCHAnlmgB+ZflnUvO9+rxHYYJRxl2mxSTlC23PgCy+1ify5Zwgbaxlq5zk5v4P9ewA86rhax2jFhjo1Ng1PtzKm3ziBsZokx9dYA/o15fv/fgDHiamsXjAwfkB3L3SK5pCL8mLf8jbLKwr2G48TCKTfy47tG6GXNv8ToSIzQI0uNrTFYfpYF3+8Avp+5RxZx1xuIlKziJiAzxfMYD3XVYd+8iRHrl/T8kMAxiCB4fQpvbUMHwDNrFI/qZtNDhMcxVWwX01JJJRQDeBg24gA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10134.eurprd04.prod.outlook.com (2603:10a6:150:1b1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 06:25:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 06:25:13 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "alif.zakuan.yuslaimi@altera.com" <alif.zakuan.yuslaimi@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tien
 Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>
Subject: RE: [PATCH v2 3/3] mmc: socfpga_dw_mmc: Enable/disable SDMMC clock
 via API
Thread-Topic: [PATCH v2 3/3] mmc: socfpga_dw_mmc: Enable/disable SDMMC clock
 via API
Thread-Index: AQHcIS9JuLPmtxASCEa7tn7tI+GHC7SNhxkA
Date: Thu, 11 Sep 2025 06:25:13 +0000
Message-ID: <PAXPR04MB8459D3C5DFBF9616C69FA01E8809A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250909021116.12599-1-alif.zakuan.yuslaimi@altera.com>
 <20250909021116.12599-4-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20250909021116.12599-4-alif.zakuan.yuslaimi@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GVXPR04MB10134:EE_
x-ms-office365-filtering-correlation-id: b11cafa4-e7d0-4773-0166-08ddf0fbf743
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?HHso44ZweeOhBmTaHdBU0ediY1LaNVNsEphJjTVqNw/TLfxGpM84lFwPWF8G?=
 =?us-ascii?Q?Borwo2NOOigdAMrfLQIZEkHHF3wr+PZU/HGhDsmSUILpuzVzi8m5UNvZg0ls?=
 =?us-ascii?Q?mr7PL8w0i8QAMe7rhPamvp+G/GgJz9GgjF5+RcbwVXKjqxqMVLSfRkdF34Hl?=
 =?us-ascii?Q?I4OcNBDC4ZpaTi9bF5FD4Y4tHkOc015wZWEfFbHIe2Zp7sYDWpmD2PrPtYIg?=
 =?us-ascii?Q?hPtWXIO3ENP3iNT0St/GwL831xQ6pYshLaPMNUnBTX9BhD3cASbPhqkVMKyj?=
 =?us-ascii?Q?6Cg47cD+PUoEfsnsgKlNlK/3RU5shyC8KrwQrlbhvCLxlddXeNVldDLZBZXI?=
 =?us-ascii?Q?7/n5YGnM32L6n4XOqmjsZ9uGmhovpbHJFOHxGbRWC5js3njL7rxtf26j83Wa?=
 =?us-ascii?Q?u24G7UmgY+RgQm7b738CnFFmtUjbOF25y38JeoouQ4qob9hjbq0kM0M15U8i?=
 =?us-ascii?Q?+oAWNOdmNWgzfz2TEEvOFZA0v1IgQ3yNEuRR4lMWeNdD22iosER5C5JIWNYj?=
 =?us-ascii?Q?xX5lyzVn7BPMn86Gp1rBUgt+yPQAMlXm3Dy192PatOeLDO8jI5m9RhVzQ/DZ?=
 =?us-ascii?Q?1KHMECeiO+GBt17f0e6V18ZRg+nBwLI5zwdRMyxzu01i3mqFxik0JAlyYyr4?=
 =?us-ascii?Q?y+OhxXg3THWcBoC5Ul9EiGshsYXMQUmRwbMIt0SypE0wrER4g8hn9wXsKhKn?=
 =?us-ascii?Q?JEmiofdRDT53pdBBiXArsAygD2VJnGBb5vJhnDsg3iRD0Ob2/M+bx1eOhmVG?=
 =?us-ascii?Q?5vlcNMSkx15xofzH8RWWXnmopHofPaf7W65U2buuY81WPhhihnhRbEZVnxzb?=
 =?us-ascii?Q?fu3EBJgQz0ITcdanP+lYqdmlqCXzsCh7Br7zgw9cpD1LCL0YgO5fVKZx/A7b?=
 =?us-ascii?Q?3XmIv0s1NONLUH0mQGi0jpFCjMiK+U+sUP16ujz/QVG/OU8cIcSV6HAG8aw9?=
 =?us-ascii?Q?wqYxmr+jSuWEXP8wAfv/OP87XQGLSyhfiKj0fDdHVOTN42iGL/zBtsCIKGkK?=
 =?us-ascii?Q?jbIWhU2XG+YivslwxLgmPSrqdcaNlO6lxDg8OVkD6Evu9NM/QMcP23vymY16?=
 =?us-ascii?Q?ksoGYM0LAKnc+Wm9VJDQCpX+7sxVEvb7lRKKUoO+GBELU+jQQPSEshvvEO/x?=
 =?us-ascii?Q?Y7eOz9sBMsfNiNpxxArPY5tEMln6VlltB+IB9V1oGN1NaR9/uefsCN8cK9E7?=
 =?us-ascii?Q?ZceOu2QpjyRD1wyVVUUd/pEahDudgMTMMGZuBqMn4qpV5SLNnuMkqmd8LEIm?=
 =?us-ascii?Q?JKh/H1jtaP/uqr7I7EAcImkRIV2EC/VysZiJ+DBP++fd7YWxLhLpoSozHQyC?=
 =?us-ascii?Q?61cG9I+ocIOhj/U2AcSEbkHXKBMkiVyL7Ux25jlCbswIdbF4VLZH4hyqW0D5?=
 =?us-ascii?Q?QQ8GLEQaquYgR6u3aibygkjJWl0yCAVG6mNTwJElj43M1VipOCGO0Hgh7Gky?=
 =?us-ascii?Q?T7neXkbL+yI6LsK9E3ZtRmoeHBQyBwLXChzQFtL4wnE/16Av9ieh/bVWt71v?=
 =?us-ascii?Q?fkyBhHZDbqW/IMI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(19092799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZR+kLhE4UCTkr0MR2ZU9ligU+FI/zkiO9PuxFPQXcxPAO2ChnXbKzm0QxOn3?=
 =?us-ascii?Q?39TZrx51vnkWbZsqCxdV5rTL1BMfAvvMSje81LzUkZscyO0gtZa4YUP54r8B?=
 =?us-ascii?Q?0qexWym9UY/SwuRSP6NGFlz3FCQDKZsE5GopwT4ex4jWGQwe643ki1lTMCY4?=
 =?us-ascii?Q?83Yx4jY3l6r8IAVYDTLCXebAap4SrSemIljNjs7fN49vjQI6Tx653My42XNS?=
 =?us-ascii?Q?208kxARJ0gdD30EwtBQnZNdfzYH9fzBE5zy3eRfWnj7v6ARy/iqPALHRsfve?=
 =?us-ascii?Q?7HrwpeDpuNnVT+m8P1Zz4oPQYKP38TITPSza9xitCVQRkSF70041SpO0G8MV?=
 =?us-ascii?Q?Z54mwxs0Z9AC8QvHa9JzJP8JRKrJat3+Q98aw6CFQbUSFr4iZaJvR4bjz6Iq?=
 =?us-ascii?Q?bb98nJ0sejBh3IHpA8xkVMY9UbY5cxcIDwPoC/z8p+dR92/hKFnJifp1k5on?=
 =?us-ascii?Q?zqC8P6xg1TaJ0oLJwbNuxeg9qamgLIElRHqhYRWbk/YiDTDmW70+TnVel3en?=
 =?us-ascii?Q?st5Dbr6GI8o8miiICFHklKXsTL907gSY2HoHyc+58zFsP0tcQmB2wgPlXmfU?=
 =?us-ascii?Q?iUXBlfB2+WNSm7tcwCpJFfSbbVOfc2HgknKN3NqbUhR1aOdhp09X9QPGeINl?=
 =?us-ascii?Q?UriK7+yF9Pou8W71Mrtq69h9Iq9wOXRjEe28xStNqLNLzxSkgD1r3rVggdLs?=
 =?us-ascii?Q?0ilLXn0FYxytURDEMbtW4CtBHV3OCCQUIidxJM/ZQGOo+w9U07wwhksJ3HMw?=
 =?us-ascii?Q?Ku028/thN4h4JQbTDd2Mkm5ydw1euWAa236L+tIVKqvtm8C8AR4rf4SfdNPQ?=
 =?us-ascii?Q?6zKfE7bx/u2L9fg56kfEpuS4kfNjB1dfciAxqHPXhIHGAs1uRV3u2WSwDGbt?=
 =?us-ascii?Q?16QRgFopkhskET1O2+/xTrO8tA1kySydGO6h0h5HNqZUkseFs9X781PId4+j?=
 =?us-ascii?Q?P0HjJZIKyV+DNFLyuOcFCbppYLc37qb5qEArgXY/hGbMNNZNXOAS4/+BrnJ/?=
 =?us-ascii?Q?5mxTe6wwJ+UzD+MmWi1Pnodc3ehjaiLfZziYdtZXJKR1EAp+d0duX0aF6xJj?=
 =?us-ascii?Q?b5m32pZwKplLChNpVnWVMqL3J1TbF6ucwgsVjcx6ICji30YEXVOSRQXcYBAt?=
 =?us-ascii?Q?0rorI8vzKen5toqYYiqRmnMcep6JA6pMbl3MOkDPg9ra2MEYZx4OSpBblbnl?=
 =?us-ascii?Q?25NW3dN5WUmw0YWenhym1AL8btcDn9kaHerP+PyQjTrtJj1cek2/+sHc19DX?=
 =?us-ascii?Q?rrZGlToqO0r+K3DNd5oKyLyt6shaeMaElmAntcJkBWCuI4tl/IX8mkPVW4aE?=
 =?us-ascii?Q?ws8yaCziM3oK8J4P/rvFW+WeCLZ9+5gP0mhDCY1DDQFwKAqsB5dhqC/dTqG+?=
 =?us-ascii?Q?Wg4t/KXouscGuvRdikhWdeTd3J+4eNufECjbo7vGfkL5Yqt9lx3XwIU64IT0?=
 =?us-ascii?Q?VgcvdSvAmds+s8WQSZcVyC8xRmdZj+Zo/X+KGkYlv+XBP0Dyz+8LwfP75ucx?=
 =?us-ascii?Q?IAd0gLMZP/Oj2PwMh6XX0LPaZx7d0sJqCemXoUBil8hPTQZb9k6qyIJflMm0?=
 =?us-ascii?Q?qxq9SFV9qtJjwQ3LtA4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11cafa4-e7d0-4773-0166-08ddf0fbf743
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 06:25:13.1825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sdUetpdg4oLeW5HaFeZEJn1V1LpxWDsyLaOjdZtj24c9NKrdPihetlfrKCuldu2Aq1MVPJSjmGu1OrIs0IcmKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10134
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

> Subject: [PATCH v2 3/3] mmc: socfpga_dw_mmc: Enable/disable
> SDMMC clock via API
>=20
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>=20
> Update the driver to enable or disable the SDMMC clock via clock
> driver model API instead of doing it in the driver itself.
>=20
> This allows for scalability of the driver for various SoCFPGA devices.
>=20
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

LGTM: Reviewed-by: Peng Fan <peng.fan@nxp.com>
