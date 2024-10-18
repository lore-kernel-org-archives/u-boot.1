Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE7DD3E195
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 23:48:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D31388E0F;
	Sat, 19 Oct 2024 01:48:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="i4uf2IGW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC59388DA0; Sat, 19 Oct 2024 01:48:55 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09B9A88E2B
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 01:48:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1ifJHG41dSloSc9T0ofwhm8UewLfHTDYg+r5GydWbAbNcSIQStyJE1x+znWvFNXKHEj/sfA1gqltJ8H+ydMfuEAmFvQOzH/I2b1APonuxAqsrAG8JLOeI1Gpeh+g0Gx//+Z6coaKpkofyq428Mq72+/1CbK0aHcfErYiBiNYW36aLdpvVc1L+pTHwONAM1E+gP2s/TQR+mqIP4HQ1skFSRiH+wdxeoGKGs5jqtD/XPx9JTo1lgfyHNKeb/uQeVUlRZaTah8Ng8AuxUZfAX7Oxy8VPMnMoxiIFaMKvAylymWX8rBMNxiddq98BjLiIfBVPzDg9HHFnwEVHeXpe474w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQ/pXKHdFnALX+FqHeYnbYLCxWHiralbEezsbrKk85o=;
 b=kxOIe9mtqPLMakEZxRMozEKIknsV8QRBfz75MXNa4fAGfHb2KvJd6uMURmz1+LOcWUl7bV2eACXhWkQgEH5/HcDovmMuF/y1apCS7DG8afz/5d4VWWtGjLdv3m85mzOzhbrhh7J7vu/2JzuiImogtUAxrrhh2klukyTcv7C6VslPLJT3R2MrpFB0WaNShSnynUj66EfSXPEAcGc5aDjmqmxWE6hKPsUWAgRf2gM8orPIvBoOfRtVjrmgmwtjysPejGy8a5BsuANaH20faxAdIq2gArpn3FgV9I2Q/nR8C5+Vx871WHFAred/dfh3S+HNNhyWbBNAcRNdI1ZnHKiuqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQ/pXKHdFnALX+FqHeYnbYLCxWHiralbEezsbrKk85o=;
 b=i4uf2IGWG4ZUKgO6FkcpOqfLL7vatM58xln4UhOsNNN4PaBAANpB7d2DeM+dRuCAY7cPlIJNK3BhSP527onWVppvu+iHWr+o+1EwgGKNPwB2o9Tq5p2CpsALdpxXgVWLkNz/OLcGUhsoVcu2i7u+MBc0m4f+7t/i9+CssTIvfu3BKaeLDO9XvWLEk9fSIvX6wPxaZP560vh+8ggMDPl4cXzI//QHFJQ/1vmfjMpSGrtcWuBEWyAFfLAE5YlNZ1MMf6/pbh8mmrOtHAMWZEK0yqqtkIGiLjgwBTmsj3VMftEuPRLDV8j7WZzZ98YacvGdmio8AptuDI9x0ckIgWNeVw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 23:48:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 23:48:52 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Fabio Estevam
 <festevam@denx.de>
Subject: RE: [PATCH 1/2] mx6ul_14x14_evk: Remove unneeded USB board code
Thread-Topic: [PATCH 1/2] mx6ul_14x14_evk: Remove unneeded USB board code
Thread-Index: AQHbIYb9XGvc53gQlECHCVWnl+WLNbKNLWAw
Date: Fri, 18 Oct 2024 23:48:52 +0000
Message-ID: <PAXPR04MB84591AC0FFE5999D22722D5A88402@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241018175549.361096-1-festevam@gmail.com>
In-Reply-To: <20241018175549.361096-1-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI1PR04MB10073:EE_
x-ms-office365-filtering-correlation-id: 0743447b-f5e7-4bc0-035e-08dcefcf6b9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?4hQcZoMHK1HUa4SWRUqOw6IBuEggwF5ej5Lshi5bK+gKSinmp4v8pwnnfAVF?=
 =?us-ascii?Q?oRyAXBZKHMw/3/vimMdsQwMU/weuUazLeNi/Jtn4DAYAvOgofGi9QaZIcwI+?=
 =?us-ascii?Q?L1KXE8bHjIebwJGFCExoTjgwg5nDKXQjUukGoPVv2EPqq89hwr0uLEFsADJy?=
 =?us-ascii?Q?671xrraQcOS72MIY2tK2W/5CHli0x02pe22Zoeq6jDyl9e2FISpPvW/BPmTw?=
 =?us-ascii?Q?/elau8/F4zj0EeejkFQQ/SRO/SG+Icbgxkns+zbDVlln//1k7VKpUYV1k+IH?=
 =?us-ascii?Q?bOs2XeAw0OvM/nZ0m9MYmEpRoQxSaQ8IZlQdZlpjBut+kgEdVr0h/aobzBya?=
 =?us-ascii?Q?E6rE6j6ifBfOez69iqhzUqjfwHZFMbfQBg1spTd2/Jru0TJRHRs+p3yVom0I?=
 =?us-ascii?Q?Vw++2xOljy3z3fVeZDG1bZPDwiiJXVlgkxULgYsPVSGBVDW0LA43Ij9PLD2a?=
 =?us-ascii?Q?VONFBRA1j/6xFG9gM561Mza/0rFdxxIU0McZLj6sfPsi8ue7gk/QGlUrtSXD?=
 =?us-ascii?Q?J+hN9l1GihTBVWL8UJwEglp137RskzMvxErt6N2jrT4LK4zOEdPRbRxMTDRK?=
 =?us-ascii?Q?9gfag4SW1d8MpJ8q2MDUhASdRR3XZPAeABpMo84qY14k0bq5q4Bs4hzXuTjb?=
 =?us-ascii?Q?lhMnLqHazD5EN62PBw4b3l2lGPz/WpXxtdCgrniQAjsbYF5MvKM3X9Kv/Ak5?=
 =?us-ascii?Q?cMGmr4ZHKGQ9czRkaAyM+GhWYvy9/aPEs9NIvLKZn6EDssXQQlc+VTraL/g6?=
 =?us-ascii?Q?NHxw+EPFg/9hAFqmT2h1ZHTdYeBnLdzwAglsrIVTL25ehew3TZiK6Wl2aa3O?=
 =?us-ascii?Q?6VphjTSLB7BKUZgGUV9jLwQaCc7diQVUhvCWrGLG5FuxSAh8NIlUFGckH1BJ?=
 =?us-ascii?Q?pavKRTK/5/rQKEtfXNZrwXKyb534HmxL8T/h3zZyYAux/bRDIkxRueVQwdpq?=
 =?us-ascii?Q?6lX/ZLSZ9c3OObe/61hl2ZSQuaKvgP3jcpsfcCq4FKaRNAZ9Nak4RK3V87vR?=
 =?us-ascii?Q?KovBwTkX5us8VrkcvIlewiGYNUCGAa0SdhedF9yTPZXo5F5dFdJl0BeoMZJM?=
 =?us-ascii?Q?0f/pbAxeit16xt3pZNQpUsOoPW2C9gYTMfwBOfKLRrBByDL6iuIRnkPvB638?=
 =?us-ascii?Q?wZP+SpZuuBfipYjIVSzgMZwOWON81rY2GvKhHjMVWNhih2cJcKHLa7DRt9ox?=
 =?us-ascii?Q?TihXeidx1QstzFo1Tqk2dN4847Ts2K3AEnHP/SdR9I6iZ6c4zfriXxOQhRvf?=
 =?us-ascii?Q?k9ozTB2SEr3lHaAAiubzWibRHylujcMaBtMsOmGutNpMttqNDQiCtMgiFV9d?=
 =?us-ascii?Q?pI0QYOkT77V41DVPrzRdcBKL75tOfEICPxsLl9TKrXoSRwIEN5+KJhAsKCLN?=
 =?us-ascii?Q?3sGPVzE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KlblaDNVGjmLGFGRG75kG9Maox0oWAtxTDhwhMpJK/vba/GnaQ033j10ADSc?=
 =?us-ascii?Q?R/rCzpi9GOUdTfJsRL689UzD/JUUwhetaRSZP0fK5J6Ez4gcaz4IBHBT+HRi?=
 =?us-ascii?Q?OTqwgbZLOWVkeTbuoi032UdFapD0PtaBc2pfbH72REQPfy6s0g5jD3W9Myxw?=
 =?us-ascii?Q?Ul96cwWGu74/0VVXYpofpKjDkY4Z/f01aVv3onoc1bUiXq2yHT7ugYVZtA3M?=
 =?us-ascii?Q?VTCpxka/EOLl6l6R0VIPjLHAMlnSK27AoUt2JyxEyfPfEil1LXxw6mQLCmOW?=
 =?us-ascii?Q?wZdmeok/p+/O0MwdyjEa8OgGPcST3HE9Hyundfscf1oHUUX4ACsXs9vuVJ0m?=
 =?us-ascii?Q?rpAKalvdDmuZ4AAHPZDtjmpW0AKqelA4QDh3jdMnaU44Vn+Syyciy+i7Uwm3?=
 =?us-ascii?Q?0kl8TcOUArD1WeLQsn75oXxtSJIg9IIrfCy4Rz7KGClW11KZiMHNGQgEZn64?=
 =?us-ascii?Q?ODnWzoLmlCCP9hAlBV3Z0MpJgf46h0CeFrfOX+y9eN/AG4CeWbZfn0oL0TiV?=
 =?us-ascii?Q?pwRNrORL0eI/0yvX3AhCydaMpvZwm4gaPZiBd9sWuh5wnCYPW08sC6eyKNf7?=
 =?us-ascii?Q?C5vh6eqAvMOpg4Uu8FPy0Ta1BiOZEaTHZ/ZD/DU5AiJgKFUb+CmNcBcXBq26?=
 =?us-ascii?Q?Q4rlT5mL1MfY2g7YPpXe0ize9fM0dY7AR61xakcSIEACoHJK85x+KLj+tn8x?=
 =?us-ascii?Q?RIIPBSU4Y2f8IKTyfOx18dI5vgX9x8k469i25+dOJ94p5gn3fjp3FQ9a01N/?=
 =?us-ascii?Q?d3s6UmCEECphBd+pexbE62EwsS1qk9AHqp4HBsZB9wmB2HsASBynNi7lIdgq?=
 =?us-ascii?Q?Y57pE5ZhKgRAd+9LBGvWaXBBBWLRN4zIcp/2tivkN0g7N99j+aeU/Yw5qqmp?=
 =?us-ascii?Q?HdVIrgf8Dm5RNNau+u9fo7SqQFKiOa6XiyJqa1hzlsNHOwwT35DsMQlVWz9g?=
 =?us-ascii?Q?Afz4vh39D+j6dhAynngk9NL7QEthL/clmmwRGkruvUZhSdtEpsj27aAPl4xH?=
 =?us-ascii?Q?0mCunrKjhLp5cDB8FFRKvan4LMILPfrdYblyWv5lhdFsOSMh+znm6/5//w7G?=
 =?us-ascii?Q?/hHMLDkNwXBzM1zSAaUsyG9gbTTytkljJNkI0MY5BlGA+jFVdr7MRkHXm/K+?=
 =?us-ascii?Q?f3ptD9wP2GO0+Yc4heFdDKZZObxv2EmGtY/XQPWdx+94seLw3Sp4QlTR3y1S?=
 =?us-ascii?Q?trnO6CU7hZA2+wmLqCO/lhkFOYOOXFvMLtt+IxCRo3HW1nIMAIMn0uoj9IYl?=
 =?us-ascii?Q?br7ZVl4DXNA6Fv/IMpZyM50DAwN1jmTf5VHMYOQn5LM5eZLF3CaQ/9Vp85js?=
 =?us-ascii?Q?E9RMe/k27L43F4r4wNkw3uVWWoUSetS9hVxEbigjRM7nUmrV0KQZgU7Eta5v?=
 =?us-ascii?Q?6bBq4kiOl84S3dqTOkp7voyNk0gZICNaosaV+VElq/1teQ8wHnTtvDeri6/9?=
 =?us-ascii?Q?oJ3rg+hwiVcUPla+ySszZCXZan7gaoRzzIz2Us8A8pSIpt6f9r5LemAqN6nD?=
 =?us-ascii?Q?qnMx6PkcUU3oW5nh4ujPQ80uznPDjROp6T7otPOfWk16AnJa782MSYiOXmoW?=
 =?us-ascii?Q?s4S9j6Dy7oLZWmtniOY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0743447b-f5e7-4bc0-035e-08dcefcf6b9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 23:48:52.2107 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uV/iwpOHeOKwYFWZLl8cWjKZzm49Ge/1v027eBg+tnNOxDnZXAjuMaBbReCB16wxmTrsCzKHBzsW+zDm3zgC9g==
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

> Subject: [PATCH 1/2] mx6ul_14x14_evk: Remove unneeded USB board
> code
>=20
> From: Fabio Estevam <festevam@denx.de>
>=20
> With CONFIG_DM_USB, there is no longer the need for any USB board
> code anymore.
>=20
> Remove the unneeded USB board code.
>=20
> While at it, also remove the uneeeded
> CONFIG_USB_MAX_CONTROLLER_COUNT option.
>=20
Reviewed-by: Peng Fan <peng.fan@nxp.com>
