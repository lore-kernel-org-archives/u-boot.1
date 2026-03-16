Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FBEF3027F
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 00:30:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 234CC8445A;
	Mon, 16 Mar 2026 01:30:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="WKBmYo+e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B90E8445D; Mon, 16 Mar 2026 01:30:01 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8752083AC5
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 01:29:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fh38k0RJfzOLuUC5D7uW7GwjzAfJ1KiVnbS7CJpnC4Im3qIylnSGGHlmNsqcqxGUoERy7mhzGJX4aGfZdfKJCkz6kGLA3VLMm7bL67Apb6kvU/R2huU5Io+UJOKF1bcqV+n2Oh6f5oU/NSyHXXLsIBkJDqxrkZOepkETwV3AAz+cFlRRzTR2miX1wBpDKxZfJwGI6FzsfCyiF2BcwoLp1Hzjg737D55Vm0YNYaMeFmejci9yAvwSE/HdA5naAa5fmDlHmhHTqx3XFJTvex+X1nD5QlVioPJCELF4vGCB6ypcBUqePYynl8DgxkLo3CAHn/j2Zhes9KlBnS1U7sOXOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdHbUW8BVQoH6vLXqWqBt/9fu6/jPa0un4cxxy3fYVc=;
 b=WdD8+HIHaLPsJglsPxOn+hwXFok6rkg85Ts0AFmrWzFHxQJERrdzXUznbb8OQE3EupLDFnGDG7FQfkNRsfMkqoUjewQ66jtVwVGDH+vUIFlqprp1Ts/kSNPu6Nop69UcTF7fWTfUDozcYmySyR744gKmp+oT1VoqqO1wOOWBqa5vkmKVf7yJWDDAJ8878HfCBAQZX5bI5/CVZSYM5804cWpmtuCekeTIkGSTkSPmYvHl7j6PzJch44TsNSFbZwFn6kGRXWVOzLGdwq68gaag+6MsUue6+Ys3ooOlcZkceC9jut20PJkYo/lQXLQ82/tcyEUA8hrrZKem2eVoZTQjZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdHbUW8BVQoH6vLXqWqBt/9fu6/jPa0un4cxxy3fYVc=;
 b=WKBmYo+eO7tfESQl26Yz6gzAcsTqMfO8P7p/hssmlTKsSHiArBV1zUYbFFyNbf+XAWQTu0IAdi/KSMxkignxlGINxr5gOvkvq12HhcM/fURyzXQaxj+nu7hoL7YgvFNsa7Mx2/0pSbd0cDU0ojUjthLHIeq+/O4VkMNlUhtKgoTt0ZclgpXjRhNbieqUg/45qwUhfPuC+H9+24DdZPeh6t4XPO2rbhmk+Inezme1vc+M6dmGou9UOJKu7P1zjKtzXeLZc4p2ijlb+hRmVFVbuMuHhHExaxYt3SdZmm1xOF28Cnbu8pftm/a5vOYjzdYyA6WVgdFkRiyMECvbkOeuww==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AMDPR04MB11701.eurprd04.prod.outlook.com (2603:10a6:20b:71a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 00:29:38 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9700.021; Mon, 16 Mar 2026
 00:29:49 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "marex@nabladev.com" <marex@nabladev.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Fabio Estevam
 <festevam@nabladev.com>
Subject: RE: [PATCH 1/2] doc: imx95_evk: Update Arm GNU toolchain version to
 14.2
Thread-Topic: [PATCH 1/2] doc: imx95_evk: Update Arm GNU toolchain version to
 14.2
Thread-Index: AQHcsyxjDCvIZXI+sk2vewJr7/a9lrWwUUYg
Date: Mon, 16 Mar 2026 00:29:49 +0000
Message-ID: <PAXPR04MB84590B868CCC0AD8DAA9C68D8840A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260313210005.781958-1-festevam@gmail.com>
In-Reply-To: <20260313210005.781958-1-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AMDPR04MB11701:EE_
x-ms-office365-filtering-correlation-id: 096d3a66-cfd7-4c2d-cba2-08de82f32248
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|19092799006|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 2cwDi9j6m7s0gBAqGfaKex2wrZto6D5Gyw94cnK+LIZbk36s9Cl9LS7nJpGn5kMRF3R/q6Ha54NHziO3aAEtd3EylBXF2p89/2D0sQTIZg7v2hxQDw4/a6wIIPvAkGJM6BoLvEDsVoSU2RKwjreH6DezT+VK+9fuyF90gTyk9Z6zzaYUiWMQzTWFJwiqVypq5FZt/maS2cb1SMDVUy+pQN9b3H5sAU3GjuqOeVvgMZnQa97nZQr71b0AS+rL+AexB0rh64deP7L5wIGraIwNRY09d4fnauquZbDYFFfYZCI+hq6ggo3saPyou2aIkGUQSx1is9yBy841A9g7fwJ3sU+91IiFMg5x8t6tzU/FjMy1D/gLvs0Uosld8hPHFEVLVdQfigPVmpqPLPJDNA2hvGS8vdi0De7WRSX/OiV9YDiwC8NBYgn5xlH/Za9EmbWXln9A68z8gDvm4hTpLgL9UuBZdVRa+GEDAXfYzkyk3IR7O3WA2wpAPXvCcbAiLjuuvsaas1Tj8823Yxmwbu9Qd9YwXuCDJB32FQ7qobXxK3E/YlY6W/Qg1XNdy33R5QmB1aV+8jrIBDs9TGl2dix6fZHCy+1XPK0frfh9bYXY+7zWZO64G/mklJinFLxecK7IgxgPQyrNRGbSpPOMoIimLKJlkbQP/Gi1+s3vcBz1dvuxUSRJE4lR4j5UveeGM0yrj15btU3W8nIiqt0UZO6vP6Is0LnS64ntompGM8bIamv+5XCw4D9WT2QhekTBBSYE2NJ7/Tp5jJcN1d7NY+N6Ep1oG65dkbL/2+DWPWTAgVU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mk9o8MsHIq0OV1+ik6uyiaLdidKrhO/VTHwJDI87bC+0PBZkgm5XCHd8M1H1?=
 =?us-ascii?Q?Lzl6BqGpaaPwxbhLzhT1E3LTyq6yFPdsOtryRMNsBeL1tvIaat7xwRM/BPik?=
 =?us-ascii?Q?mtW5by52JMJhME2C0kTqCW8I4FlSrkE0iMrXC0h4WQY6uHkajPzj5syjlRzK?=
 =?us-ascii?Q?w6ySqkdvL1eLiLLfsuYJsVpqGPa0GlfIIYp42Hu4j6dCq37FW8UWh3vMjcgd?=
 =?us-ascii?Q?pmDt4YP50UtDKHOyP5XF5iSZDxCMEmOfREHmnEm9aiMDVmq1rohbX8XfaK77?=
 =?us-ascii?Q?hWeW4bGfAWx9+67sy1kO8do0I0bQYwC7YCJ03bOX3C4bcUJ2sGIZjF9eMEHA?=
 =?us-ascii?Q?aS40YOacM+NdQx40DSVxAZrxR5M/23P45AnZeMMQ7oxC9Ebm3OGyiMcWVPoy?=
 =?us-ascii?Q?TCRNAIXxz3Awa8uFCisxzJord1h8ged+zWyThW4eeQEcgWrVfNkLERiUvy02?=
 =?us-ascii?Q?NtGIP7f8FVAEhJbLwjeZ36+pCGEp5IaeohjqepKUUNGxpD0PpOLypQ5uTdGI?=
 =?us-ascii?Q?evDln4rrtb4z2xUejj8JHCC5OYZihxaO6J6LHMXb64IRC1nKsc5yR1Xz5WEz?=
 =?us-ascii?Q?6dWe44sdGgulFj4WQTl/u3Ni4CXLq2WBqCM66+DS9P/nQkezfnHtDa98hvZf?=
 =?us-ascii?Q?f8T8czYCQrVtQo6NXX1tSLskGwZeu5yIKnHtTQwsgALBuzC+yr9CuDn6xto+?=
 =?us-ascii?Q?x5zVf487MeQ5mADFfCibE4R7DtCI2erRcLEQBdCif38vhwGjc+mCXhPpAT22?=
 =?us-ascii?Q?vcFktIGnXMdT27UUZPj3LroGQFoO1SdIcazfwKG/BsXnoY6kePTV/u9YnSbf?=
 =?us-ascii?Q?lzTYLi8WfJAhOwxnh+mVldDZ07W24nZZpGKt9d8WAcLRx54368N2Gq2AfAjr?=
 =?us-ascii?Q?6cm6UyQF7kgluIc/2VGGdvTNe6xmphhVC58bm1Mbz76KF8mOuVgUpTRkNbzt?=
 =?us-ascii?Q?juLxXhlyY5SFDCmEyITX0XQiVf+i1g9ur8wN0SJCzA+zLwJFNwtPCsl9+dZ3?=
 =?us-ascii?Q?q0Qta4i7FPhCxEpoUPpMLg1nYKNUKO0v1YyuuGpAqxBnnJ1ucqp9CavMlwba?=
 =?us-ascii?Q?zrXWJXOcMPE7MVt+UWSu3ONXIkunyMtCMCX7UJ97yNJHgyD1KvJlCW+MYj+r?=
 =?us-ascii?Q?/NIzbnfUiOOXWCDffREI0036rVSLndfKMOV4zgVCS0XFF74DE1e7ZfT6ggiF?=
 =?us-ascii?Q?ts04z19fVXmUnh57z6m+Fr3aL8N9tA63XVu7l5h+dz0ORxFiMeS2HKAE37T9?=
 =?us-ascii?Q?F7jT/hpmwUfwDlS/utB7y+KAZBhvk3FqLb+arbenRXWEGEOTDxu0H0N1iiW8?=
 =?us-ascii?Q?bNzV8yShjDO2vbitJN/6RpAoBVET/wYSlCAgRMmzu4er1hTLduXXuqS406p6?=
 =?us-ascii?Q?pgB7NBrcFQ4W5bs90JoPPTt3b1L7RSfsdtONMctRpAOvGOQii8SOLniQGfxQ?=
 =?us-ascii?Q?VjojasK1n9sdsH68iRL3UO+WiioHXwnBuLhYkxvFgWMQ9UV7ehGBJm+JVPWa?=
 =?us-ascii?Q?6w+LYplXDNsMnSzCIeKWHzhmsABMhwa0IwhXJeBGIjvc24fboeZLlk+cHE3s?=
 =?us-ascii?Q?hhIUYDEFzTDBNoWRk5w6uqVO6wJIbWVv4UKMmLtEU/MbDhsY4TJzhI3vAj9k?=
 =?us-ascii?Q?KGjaZLigSo9DRlnQZRbIZ8/4fo1alDz/hEOJ3oz/ANejj6DmaqBm+Y1q6LVZ?=
 =?us-ascii?Q?+Qk10rGmptUCrRa2Mon2J5sI5RAB5RzcD0u5nI1bdmrYBJOt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 096d3a66-cfd7-4c2d-cba2-08de82f32248
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 00:29:49.6571 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aKCPmd7E7NCmtGkVZl7tohFcUfp2yGC9eBVY53fe/2W1Y6wPRI33HmG8MIWxUZFnQPZDK18bl5jbwm5TJzZm6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11701
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

> Subject: [PATCH 1/2] doc: imx95_evk: Update Arm GNU toolchain
> version to 14.2
>=20
> From: Fabio Estevam <festevam@nabladev.com>
>=20
> The imx-oei and imx-sm build systems defaults to:
>=20
>   TC_VERSION ?=3D 14.2.rel1
>=20
> but the documentation still instructs users to download the 13.3
> toolchain.
> This causes the build to fail because the expected directory name does
> not exist.

I am still using 12.3.1 at my local, a bit sad that 13.3 would cause issue.

But anyway it is good to have doc updated.

>=20
> Update the documentation to reference the 14.2 toolchain to match
> the build system default.
>=20
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
