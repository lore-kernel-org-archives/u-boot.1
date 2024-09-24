Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA678CF9C6B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 14:06:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E72F98852B;
	Tue, 24 Sep 2024 16:06:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="CgRy2eXR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31DD888580; Tue, 24 Sep 2024 16:06:44 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1BDC8852B
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 16:06:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSlDr5YuLZGfdiE59UGvGOgikP5FvMO/UGbMBEt9xRBF5kHcMUmDa6eoP/4itdyuuR3lU0JKMHsHQAQPDIr5D4k6hfLeW5fvf4qzRjqH6+zQQ/xkDb/7CO1D1ajvybkRdDRm6Ukn2yEXiIq6ncZ3pfYiz/le9s67GpVZjGD+gSI3EmEgXzqvd88uOXXhPrRLVdovW0Mdh3kL2/IU9bAL8KdGA5qStNGhJW68pgsaTOEcpyohxMaNm+MsDMmIvGVOUc8SvhbkifIOCcBdQFQWJXOqfFYuDxIRxEUjYCu60QbmpdVEuq5dYMJolOTssUfUTwqLa/rmD5xIkdsECr/XvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRdkKzALbVTtZPmLekqotCuEVKnleqD7cmDYuTcmyao=;
 b=ewIG5gwvuyVce7j+/id0cDfAdlEqqLX4/LWOjdqG9XCnGba6gZLebrC9GxTEQSghipdfT0Bb+T032G9rA7dIqUt/UTXXrJFCB0ew2cqa811QnXVabKZHr8v/NlqL5NUPfyf5MIFHl/A884YOYLA5Pd6XKhZLPEy3sz1EeXSYCqBCFNQPmcHmahwLwRHUXOgcUYK7WnGZLQiF+fJaPlB4O8IbfsiwR7Qhy7dX1r3rx8RXkvX7iEapqsvJdmj7l1KAb6Q7ChwUt50NIjGpgGOPqS8ECABS0v0tXyuaZDwI+dm2brNYV7ZS7ZNWY1Vytt6KCsK7QqJF24yR33hTShNtvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRdkKzALbVTtZPmLekqotCuEVKnleqD7cmDYuTcmyao=;
 b=CgRy2eXRFcZ6yZEbeevpNdpiI6xSRSuyVEJ5bedPuQKEoKpeZgTQqV/+yWil1vh7uLtiDgpHsEv2P1sBes8incRxBdK32S8hNz3/HDD5WbCYXUBnvcxT4KCNkjk5aT1CoboFimDots550/VcsT/qWzJnrixVb6YyTv8oefR7pjMQr6CebiUgPW+VGtxwRCEZxWMBch5W4OSZkyGFRzpygyb+IFCPSIRaF0VM+2Gscw8zU0BLiT9S70ewRmL7tp41Mf+pfCHevuyJ/JVZ6gtVer0WaKPAOT4zcbPWYhJvrEpCGOKSNB6/p8lnnY0Djz2v4TQthh1U/VmJ8NL+gKxRgg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB6920.eurprd04.prod.outlook.com (2603:10a6:20b:101::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 14:06:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Tue, 24 Sep 2024
 14:06:34 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: dl-uboot-imx <uboot-imx@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Stefano Babic <sbabic@denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, Tom Rini
 <trini@konsulko.com>
Subject: RE: [PATCH] arm64: dts: imx8m: Always name the generated fitImage
 u-boot.itb
Thread-Topic: [PATCH] arm64: dts: imx8m: Always name the generated fitImage
 u-boot.itb
Thread-Index: AQHbDoIGr5FcCMxyGkyGH5uNc+OA2rJm+LuA
Date: Tue, 24 Sep 2024 14:06:33 +0000
Message-ID: <PAXPR04MB8459E5AC0DB3DB3E0520759188682@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240924130218.308845-1-marex@denx.de>
In-Reply-To: <20240924130218.308845-1-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM7PR04MB6920:EE_
x-ms-office365-filtering-correlation-id: 0cfe3a6f-e24b-499e-7c30-08dcdca218f2
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?wumIGzAG4LGpxV1T+qCgM/TNhN8zgiJgLbJPJEEnFispvQYfiXKBvMjI+M9R?=
 =?us-ascii?Q?8v7DQzIMZ/EPNWTclEd2wC4e9m1xhsVmn+DIhB1Pe6/VLJUAdo++8fkJk0V9?=
 =?us-ascii?Q?my9jva7EW2iiEqsHRQDQ+tyzMuQYk0LcH6LTHFXvmzzPeuWZ5MDimq9ZdrIT?=
 =?us-ascii?Q?jnxcRmzFFPS9WQs7gtFmbytdpnqI9oNUUgSXHmDkKGN0BzrMmjynox+njZC4?=
 =?us-ascii?Q?vTHWb4Zybj/kRjuPEoAiO/ekPrsAJ1okRAzkUjfeaTYfCd1Zxm1mqa+B9IB7?=
 =?us-ascii?Q?d4q/R6xWz6hUjfsy/5YZhg1j15fpBZqK01dkWHee7ivmfbkOUpiNwpFfebX+?=
 =?us-ascii?Q?ht2yPuAKMuTRsR9edFbVk8gbJUkyMn68Iubq4QvittcKGnsOdJ7Ii9ZQYXWy?=
 =?us-ascii?Q?JyO4669uKB61X4yv7Inm4UNqJnuTi56RB6TH6v7KnWgoGlPgkJ/bOefddlg5?=
 =?us-ascii?Q?GCF9tq4tOEsKkM/fH+3JObNxADVI8FxRkk1sxGqaTq620yVjVR+5zb4Zq/5l?=
 =?us-ascii?Q?jmMpL63dRdCnGLMVn0u6AWCoaXxxmegncKFIbVNkhyF2nfmdBWckARsQv7Tz?=
 =?us-ascii?Q?ULQod7Tu61AsvKDF6ZcbFxHDzlOZ6Z7tzWP59SwlGSqdwBSqvW1XorZ8wN+9?=
 =?us-ascii?Q?uUr0wclTlgFwHbf6U2Zh4CmnnfCosYrDZp98Y1ek2cQI0Mt68GZYrZxK0wTH?=
 =?us-ascii?Q?Jsd07kpbbih6AjuOjlepMjV6BBDKIUsutOT/msDd9MXZjCIbp6P7M3lmj5tj?=
 =?us-ascii?Q?tQRaAABhQ+bG2eSvBHkuj2SEg3UaFYtNlV2XfVJtwa3XvHkwt6VPp+0mmuUG?=
 =?us-ascii?Q?Ro/01TJT9lJ+shEg+LIJMLvwWAqyiUTiP1EeqLF5hLRdLExXF0NYHK7NNH/v?=
 =?us-ascii?Q?sT0ZWqbXmHUJ9zrIcZYg3KyShpXFWsGyVHEkdIpDiXCRHJSfWgc5J0eUYdwt?=
 =?us-ascii?Q?efHk2aQnuml/pOjhKDE42jSCQ7izj+vPIKujNeG6g4/o6hm0Xl80Yb7/lbSM?=
 =?us-ascii?Q?gwcLN51Eb5/mEET6H7RB1LGQlK1MOaj0RM43OFgejzMoya4DBgo1V57pbeFE?=
 =?us-ascii?Q?obxppwzlSVqVnQ5u/y/p/+N+4i29uY3CwDP+SHmodvs+tR5u+69emqIBMSSX?=
 =?us-ascii?Q?gwaEZ/I0CAyrLUrLQCvfe25Bjv5e/RTVQwmDCCMYTbLn0oQ1fww/noP0GC/z?=
 =?us-ascii?Q?7Dox/yYZQqxI+s/wXif0G+YmHD8DVP+ZuiCaKKafEpbmoKHb91LNr99rnEyT?=
 =?us-ascii?Q?k2R+8VwBLmI62aPO1mKMIBjZpSUKySRH1DRVXab6XNQVcMl3/Z2ZV4euALTv?=
 =?us-ascii?Q?65PRTuJudvGeaLUvcHtbaeufKlNPLIkVf3SlqNdN3zapuROjp1eDtunEZovn?=
 =?us-ascii?Q?iYzHEo58qNOxDizFNMVbTP1M9Vd5q1VjvUSBl05CXkJLStCwig=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mRQo913iLsCIiXa4m5WJyrMnwE6zR++LBFiTeX8HsHdS5QG35cy+f7M1quuY?=
 =?us-ascii?Q?FlBBLcQi1norZ1gEiI6cydkvEYD3Pmh/E2BHpSIeFlWgXbeBRfkM3q/fKxm/?=
 =?us-ascii?Q?h0M0UhfMYuk3dY72n41ywss+qNKp+cymtVW0oWoYrSPcN4TUOvtNjUw46gEP?=
 =?us-ascii?Q?6G5yYkyshBAeSk+kEPf9EN3+ZlL0RZVq7FOncOKFmvE7NS+N345qW1OG3m+m?=
 =?us-ascii?Q?TCDY94gl3A2fCOB79mWoDHXhn7DpJ0tyJt5QiyUIjKEBy9Cjmael6LxDh+uV?=
 =?us-ascii?Q?xRdE1tpTqV4/JsfUrphMJW4ptiaZVNhOwy80tTC5Pd91kNNREjAr35EfIoSz?=
 =?us-ascii?Q?Q37JfiNGPIYVHIrBQJcv5CnQNNEiLmhDO7RPN1WVJ8YnsL7qzEZvGpL/7pGk?=
 =?us-ascii?Q?3AEog0Qoy7mt8B+/2TAQebg8N8+WQkARjZNf/bbWJ/ZckfC16B0WLmqkUiky?=
 =?us-ascii?Q?qRkTjgTJRtF0YV63/nbH4ECRt7ekRi6gd3sap+d7ZD79fTzH01Plyo2hIsq+?=
 =?us-ascii?Q?j3BEIJRZqCq4s9QjDA3A5bY/teY+wuA6JB2rAeuQK50yYgMR63qkmk3Yuj/N?=
 =?us-ascii?Q?3pwZBmNo56ac66zdO7o73FncIAOTm9voJGzivY8qARJiKvmLQION8Ax9Frr7?=
 =?us-ascii?Q?ZlcQBdYLmY0H4qNjPSqYxGAgj51hmiwo7J8c4npI+8k9IFQJCWNOh0x2q6GY?=
 =?us-ascii?Q?oLXIJhUpJgtY5IWQNKeULdAbqHIwIu4P0sznlnW33vtG8pA66OvywPT8H1PG?=
 =?us-ascii?Q?LTrmBtnb9ot/PytZK6APKeeyazOy4rpcJb9pE/BIrmy3/VQU92LVzP5581Pk?=
 =?us-ascii?Q?re5PekknT3oST2b7msRYOfZYuNP4NLxAjbJmv9Uzq+oJf+T2kx8xbIVSA+k4?=
 =?us-ascii?Q?AlFbxL/qLGmbE0y7Ra6p8xi7qfCt0zCslvRXLzXq9jRSnmoj+/KcEHRQ8tMF?=
 =?us-ascii?Q?pyCVqra9gClkYAmzw4gFiBBqCAZa0Q9wKpesSjoEXplscc2p3DMMQgyBbZUG?=
 =?us-ascii?Q?nsEE7Wz723MMyxqJ90DjXAY7soQjQkxu4O2RSC1liv3ybb+Qhw/iur7oPIEH?=
 =?us-ascii?Q?qjbPKKDBwj3S1rvezfXBF2uOsFrPAXzazTryoL877pp9fxB3gZswEszVBzel?=
 =?us-ascii?Q?3UZQoiHJ/d2ZE2emKZhHBQK5uDbTK6vd8xqWlnmoiqdANooTbmxByyHHouRq?=
 =?us-ascii?Q?p8JEwjfJRYiKK230mbzPAjHxZdjqF4kOUbLlKpbE+sI63UOBpgRbAp/OnWIV?=
 =?us-ascii?Q?rBcfgBHY0psFw1UOBiIqc1goDGISXNP3BQdI2x7rm3c6rxc9ohj8yDVCCZO+?=
 =?us-ascii?Q?FTuYqnIb1VQicayi+AkodHWY/nI5tD3Ls88h7zQbBC2AxfOUY41PWUFbSdxY?=
 =?us-ascii?Q?cJ+N4bToubHerK+BVR9TGXO8PJX9vXoH3NtP6i0YYTDy3N1tZnWt7hjPrxux?=
 =?us-ascii?Q?gn+3JtG3XUzk4if93AJyVb74/pwGI+Og8KmNfu+SV7BEEwvNlpGwCHaQ4Wzb?=
 =?us-ascii?Q?Nsa8zUSiG8keLNt4VWrN7nrkPuO+8CeDzmMaQs17aYrhtzj8fbeSTG72BCsk?=
 =?us-ascii?Q?1I8HByWzIyGBOxBxhIo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cfe3a6f-e24b-499e-7c30-08dcdca218f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 14:06:34.0701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zRPiGD37YVk2eQJb1Msw0t5w636df+TH5NjkUAjd7PFt9nQG6unsDHCErU5oGXK+FRGGQ+g1ps4mhrlGWxf5pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6920
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

> Subject: [PATCH] arm64: dts: imx8m: Always name the generated
> fitImage u-boot.itb
>=20
> Maintain backward compatibility with pre-binman u-boot file naming,
> the U-Boot fitImage used to be named u-boot.itb before, restore the
> file name after binman conversion.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---

Reviewed-by: Peng Fan <peng.fan@nxp.com>
