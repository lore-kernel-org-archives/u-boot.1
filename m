Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F036D3E195
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 23:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8D2188E88;
	Sat, 19 Oct 2024 01:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="JmCe2DEF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A63BA88E81; Sat, 19 Oct 2024 01:49:13 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6EFD88E8C
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 01:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuoQBrHASaeZ0atqt0NwUfesfqT+otmwiv9dVLEfmmCcFjIcOGkReWJErDD/tSY414ammpAjOiMu4ZEFTtoLANu78WAU6I8hMufjh0yS+wKJxu+pUnKLyIC3nfvp6dheFCNWZjY3gyJ42zEcrOZKfgYAMqF5bylE0DE9QDYLbk5mccLlDK97+vgS2uOOkMuPonJAWGRBnDj7IwlGMuYu3KRdAmLpgKxrN299a0mz17htv6r9cirqFYWIfOFSFOAmZHXi23ZLoCa5Pfc7789mVRFZHZKq/rCB9Kpy2cbAbLOzW7A2Y7UAjzIN4PZ0dXF5BI/LL6+TC1obKDmfoqhEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIU102ReU+VtV/8eXDYbPtSVscoYwXvU60ZWXDn5TD8=;
 b=R2FOHTPcdVWmGJmGliKPi25KaL9jvaWqJ9NH2jP717wniwCwZZVN+rs/CtZU5OrHDPjRi2k9mztYQfc9YG1P11QjvAkuWQO8IGuUyFAjGfUAhHSzzxsv1/uwv5f7wpnVI0Dkk2wZwfviIoBFdh2lmSDnnNMXSiMZT6EelL7dc00CSt64wFiHOiTixZp8DTXzWwVY4bzPlJWXcobvOpXStNs86k7MK/CMd6elyz0fx9qYrbScrCnCyhJCOAD2+tyXZXOtun2La6pM7hfvszUwMNBaHx/8l/wGcdXbeG+rSYAVbxYS59Ajo713FjeiYRsySXbPJLzEKvQRaYJrPGKlfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIU102ReU+VtV/8eXDYbPtSVscoYwXvU60ZWXDn5TD8=;
 b=JmCe2DEFTUFATbEXbEsec41yX0SysgOpiHlnsXnR5CWplHmUMyP3kopyC7GtdNQxxiBksA4V+517VCrGdFan4go/sKeOyHGRKT+Oh0qsbELabSZ99uz6no2izqU7iP0B/z3l9LvAGtpiLUIow6dcdFreac8OPW+Y9O0c/5gc0F40aKW9E2V9Uk2ORiH8es4CC7HJ7pGrb8Qiq0l+M1gmftcBwEe1kS4EdRS3f2EmM1M3rMd8ZCeslB5+s1+K9j/ei7N9j7RJMz87K5GBEdL/XScAYye7Mhd1ljLa4L7ACzJ50Yoy0IPmwfGcts1hULqHjVXg43paiAFtLU46BlwDFQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 23:49:10 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 23:49:10 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Fabio Estevam
 <festevam@denx.de>
Subject: RE: [PATCH 2/2] mx6ul_14x14_evk: Convert to watchdog driver model
Thread-Topic: [PATCH 2/2] mx6ul_14x14_evk: Convert to watchdog driver model
Thread-Index: AQHbIYb/ocvAkphWOEiQL6/K8xyOILKNLYkg
Date: Fri, 18 Oct 2024 23:49:10 +0000
Message-ID: <PAXPR04MB8459A8048002D04F0C8A74AB88402@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241018175549.361096-1-festevam@gmail.com>
 <20241018175549.361096-2-festevam@gmail.com>
In-Reply-To: <20241018175549.361096-2-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI1PR04MB10073:EE_
x-ms-office365-filtering-correlation-id: 42334018-ba65-464e-38ab-08dcefcf7671
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?rjTpvRcgjK/bDJp5Ju28GbDuDy9FQDhOtMoWBEbAEP5hlSm83h/cUIMXDcK6?=
 =?us-ascii?Q?bZsJdisMLuRuP96oKY9j5X2b/STWaMUb+oxTiy724meku0SmUo8MO45kCfVi?=
 =?us-ascii?Q?yoIp10Ge3IaQ1WztFGWvzDu4BGMDQ7xWyaFoj6yGU0hVUNtXDUumJIYmvWL3?=
 =?us-ascii?Q?J4+tSX6V1jc9aD3L+Uu9vd54+oyeg7qZUcxIIbdiU1aS/QxFsb2sWidYPPNw?=
 =?us-ascii?Q?2UBRoYO9QaX9Cj5M3ajePs8pk2gxTzXEFhYtzWaJlljpDjujMOfe9x7Y8o9X?=
 =?us-ascii?Q?PA1O15ROy/5PTSl4i/BwMZraMEf8QILSwoSljgbUsWeBml8j0vHVueugzdVq?=
 =?us-ascii?Q?S9r9rbAnwhxoTAXhX7tAISpIrclke8pk+q/PFLdbKLdjbLerDtKcH9jsozf7?=
 =?us-ascii?Q?PhvBsyuuvlpbJZ+w9yAJSEuAEiaLQ82jlebFVoTgtdWr6r0RcI8fegjXQAKh?=
 =?us-ascii?Q?4GsdBQndGnsUApVHBWeJKiXDR0ITkPCp2jZCkrFRjid488YIIgfYRuu9CtD7?=
 =?us-ascii?Q?D5BOmR0KNW3QxetO7UGnFVqblXI32qk/AiP3VqG1Wzt5Z2zNHpKQMzYmNrcU?=
 =?us-ascii?Q?YrOZvRVg0k2HXafCsJCzghXgY4jghkPhRr2zcpaqUIx6JrA0dzcFM9+rQ/x5?=
 =?us-ascii?Q?H/ZyfP6m6JeX8nRNMEic1LkJ11DpTihDAWwtowFKsvBYTMncpKLx9dwl7d8P?=
 =?us-ascii?Q?NeyJnjFXKSCyofnd1XRBVgjiUJNQz1ym+aXCBEkdxPQDYzMv4TZG3z2c8VqV?=
 =?us-ascii?Q?Z4QqwQGfb4r8nGy0XQpwpmIj/PDTYcGwQWbbeztIph92yCwJ7jKE2RJIxTnM?=
 =?us-ascii?Q?mn1rJdVABDRVNsqNFP7hdOhJh1rbRZCZspEyOm+eZP3oFCFnYp9slCmKoPty?=
 =?us-ascii?Q?zLmEjIQw6cRwVHGbJMzVfoAb+yawJQk5XYEiNhlVnATEH2G4Rh9D23TsEZGy?=
 =?us-ascii?Q?zW4A4SgBAlPDk2GcRvl68dGk0U6qTDsfenJUoZJIHn2UWgoaEsQJBK8Nd8uB?=
 =?us-ascii?Q?kqAGzisFxbHAdNE8tDrSgX7M/Fd6HGZ5wfgeA0Fl77Ye1+aiJ/QrFqwXH2EN?=
 =?us-ascii?Q?oXTm+EUPIi05Glb8avf0Z34UR36OZDo702Xf1rYpJ65v1salRnnwCrpm41EX?=
 =?us-ascii?Q?cb1mvu9+vVXyHoe9nYWMaMC3SkB6UWRUOB1cFzRXBvqOu4+r+H4UgGQVSQlp?=
 =?us-ascii?Q?GrBUl0ITpGO0Gd9fhi/wrPlMaLXBh/+ZVeIIO2Ej32mvamhexambgnjUNpiN?=
 =?us-ascii?Q?6mkunttLQoCwDSs3RodOuYTvCuN4rpSnrhRcXVDKAEByPJpi/KBMfQJ88ZI+?=
 =?us-ascii?Q?z8tKrqTw+MW/EJnZ7C3QeVEAaRnOYtXJXKpsSfQTq2Vr6xC4/5WBVzxAgg43?=
 =?us-ascii?Q?rHpP+F0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZOLjmRAjrmby+MKhGslzAFUKXc5dc09EkP/PADd4qPgFr9Cdk9Ohj1TbprUq?=
 =?us-ascii?Q?KKiUbW+j0htNIVMVMfkNP0iwL68JzD5z4L5tLWCA3fs6fXNlx4TTJQhrkzLc?=
 =?us-ascii?Q?o3VB+CtcGgMHhIcG2upLWcGRRghi3pby4ZaIBwS3HkXXFP/7I2GKXqsQlYsV?=
 =?us-ascii?Q?2sz1PEXQVPkuA8SArqEhGEaFtDs7Jymk03tK5HXQVdB6k0Z/SGOs57QweamB?=
 =?us-ascii?Q?VZ19NK7GLQHtWg9nwKXtHM9Iw95kTsXpXbFExn5DDvKK9NwR5pFzHNG5PaIH?=
 =?us-ascii?Q?30vT9jilIIIq0cMebiGH40993ljbqtDIRqR3mSqOYDCVG7kfexzJbU6OoAAo?=
 =?us-ascii?Q?YOCagolIw2Dv2zUUkdiUeP1zVAiPqKVRkSdQlFX3d2CoMMZrkmUGht9XMqyw?=
 =?us-ascii?Q?IvJ7OY/f90BhzJRLZs1TqtqgOop1N2iuVl6K/LPanjT1Hab3QZnoa68GPPVS?=
 =?us-ascii?Q?R5IZrIVG8il+D/8yR8z5QhhpB+DFURNepH1enWR0DQA8RKudNjADoUbASdgS?=
 =?us-ascii?Q?hSb+Rr1eJ/p2u/eKL6iaNG6JA+Qw7o0ln+k74rjIJG7H933JYIKl3kKqqZOq?=
 =?us-ascii?Q?/HsmJ+xbdpNh9ENHPhupdH0OMCSteBKVreCP1gK5htZdDU71/y75HLTIyiVT?=
 =?us-ascii?Q?W7hqbPyofJ4MTlG76fuEE5311jKZnfDJS4C9SFsebgdK65CsylaSoOOIfZj3?=
 =?us-ascii?Q?aOqGLjNYRvzvZsvnw0SWnozCzPOauXgG/+F6WpQdY+RS3aQXOldGKvX3qUCA?=
 =?us-ascii?Q?WJlZFYSMk/9is/qIN8Vj4eJVRTZWJqYil9XwPOK8kUX3JXSy/dvLS/m5SItI?=
 =?us-ascii?Q?M16/fFY4+Bue13fZKNjFTHx8Nnn8UeoJ0HHcX4ay/Qe3V5znjFtR4wJcygfs?=
 =?us-ascii?Q?BnqCk+QEQ1CFQBrM5AKslGmPiqdGe8fyMnIjIoTF5dX78YqieNz9JfEztns6?=
 =?us-ascii?Q?aMRCueY03op7pk8TorTB1j0K3k+AKGCJSyUa8bxDwzMp00/HsMTTxJ57HnZ9?=
 =?us-ascii?Q?2afPHVfpFD+Qfmft+JvOnqoxaJbr0w48/wrMVlFKiMwtvY/riltP/Bx48TtP?=
 =?us-ascii?Q?EIVLvBAVHgjobwEjFiWVirl57PrMhFh5f8N2Cia3AXad5IZNU3MUqCy7joPl?=
 =?us-ascii?Q?Vvimy8OGfCcAGLTbssTYk2Ig7o4x6RYf6i/39uPAZx/aWYN8dpXMXS58YtPB?=
 =?us-ascii?Q?lwHsmQ3cXvEYTnS3RD80mSwP3Ewady6F/m67cd0ar6v8UVGWY1QuwUo8nC3x?=
 =?us-ascii?Q?Z9oLF7em9A9b0HyMjlUBJTzjAy0RvObFQ21Ua3knL7vuRQJgrSw+ImHZMOsU?=
 =?us-ascii?Q?/0GuhO+9oR9drYEIY1NC3BKICOjH4sHjPOuyC0E1n1Hnje6FNy4hJ0oz+V1p?=
 =?us-ascii?Q?9+pNel1xH1efc+L0HJZgmJjy9PH9FRvZR24ZKmg+FjZEK3EiBbQXipyPG5Rc?=
 =?us-ascii?Q?8oaBJIaUzwK4Li578LaRieKbmxzzMYeQeYz7NYoGPHXlJNdOxIW6c0j1tg2b?=
 =?us-ascii?Q?75fmFbZk5jHdKo9KVNcmrM9t5T2gd2AF48lCk8FMOt9XOA+i+kzAUDCCbQ8l?=
 =?us-ascii?Q?5Z9RrF7GQtqbnQwaLa4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42334018-ba65-464e-38ab-08dcefcf7671
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 23:49:10.4142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2q0L1GK1PKSs+KB+G/ou6/LBJ27LIrvRXwWJYZOD2yHb697vepbeGK7QP+ahVfFYZgu1VA7hg/Sr5S4jySdceQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10073
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

> Subject: [PATCH 2/2] mx6ul_14x14_evk: Convert to watchdog driver
> model
>=20
> From: Fabio Estevam <festevam@denx.de>
>=20
> Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()")
> caused the 'reset' command in U-Boot to not cause a board reset.
>=20
> Fix it by switching to the watchdog driver model via sysreset, which is
> the preferred method for implementing the watchdog reset.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---

Reviewed-by: Peng Fan <peng.fan@nxp.com>
