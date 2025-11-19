Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDE2CF34D5
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:22:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 948EC83FAC;
	Wed, 19 Nov 2025 16:22:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="dP+ZrA6r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5001883FC8; Wed, 19 Nov 2025 16:22:54 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77E4E83FA3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 16:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VccjWiS5JOJsSRXVjrCHl9n7OcEAuf0HnbyAgOJ4y9I0dGXcCi8cwpKg/76uyQQMjRj6NPJ8vJ4P3Vvm4/FKx1eWEMn0xYV4Orxc2+l6WHVvnvmB0LmtQAmDW7y+sIwsjKKqrLT83XCY+vImLX5DGBKTegudAjXc1tSLVYOxGeNJqEMdYZbh3Ih2iunC0rucsOBzLFG0OtxDquvMLvfZ77sqXVyt6VA1oEjAzWEYczatGIuplQpiuPpxhE3vvAfFH4I/cwfssJtcF9Lg7E3KxoukPRElWd+Y2bvIJhwqoERlbzc/h2AlvwjniDm85LVZ0TY1HLQCGj+RnkLmYbgqvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyRB0H4CiAnh5fwPiyUruqFwYY5EJyvT+ElJwkc2uYs=;
 b=Lu5Erv+Zx70GO1wC68vI3oFjb5pKtAtiuXqDliQIdYibFjy8WRWa4Dtyaox09qcH4/UY3kdW44gYEZGgjXLaRUqTnEabHkAYOj1vr/6C9Pyx4jLQttUs8bLCHOrgfXqQyXazUyUInMokxeC1pXu4Xo60YAGZya/WukqdFUIYr3nqaglc1ou24kq00LU7tNCj2B8pWKGROTMtjRXlb8az5oCnU/GxoFrKoe6X1R9uCKD/cKezJbwWVGtj2q4r2flPrJje06fy+EBzDE6DM2AFPxZ4DPD7cBSzOO4W22VP3HX4d+B3it+05trB+uyNeAcqc7DA5RKtbuL1HMH4JuDayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyRB0H4CiAnh5fwPiyUruqFwYY5EJyvT+ElJwkc2uYs=;
 b=dP+ZrA6rnnJOVfSOy7sQIgj+GiPyapsNeEKoeAGpe2S8tXi9p6Njqj1FXzqJCUh/86U2UzaV44Y2bCwCG4hFBxDs2Dbh1js0tkDmZjpxI0YV2aZ8P3jLoPrAg3+l/QzeheSWOhjASTT+NnBJyRWgOtTbJ6OxhrrWAvdx+HTCkokwLrGWcWxGtcuuRU/oSupPWvPaIRBMNxWbgH8Of1TF4Ab9RUokgwAqntcY4+JkzvhSgKhaH7iyz6VVvYVYxgE62lpplrCMcbluNHu/h/8ePZJVJkzEVk7ubomZvW3bB5E2k0J8diSJ9T42mfaUInI0Udd7xBdtzS2SqWcR0dfviw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8379.eurprd04.prod.outlook.com (2603:10a6:10:241::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:22:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9320.013; Wed, 19 Nov 2025
 15:22:51 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Fabio Estevam <festevam@gmail.com>
Subject: RE: [PATCH] mx6slevk: Stop disabling device tree relocation
Thread-Topic: [PATCH] mx6slevk: Stop disabling device tree relocation
Thread-Index: AQHcWLXBtq5fYziA4UmRJzEGte0YZbT6Hzww
Date: Wed, 19 Nov 2025 15:22:50 +0000
Message-ID: <PAXPR04MB845950AC9C983FB952CEE8AA88D7A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251118180410.591192-1-trini@konsulko.com>
In-Reply-To: <20251118180410.591192-1-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB9PR04MB8379:EE_
x-ms-office365-filtering-correlation-id: f706ced7-009a-4f70-9701-08de277f80e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?eWAdcLR8FJoOGu2V8etLcDplaou12QC+ABsxaLmSMhNIwiPexKYFnrXchNgX?=
 =?us-ascii?Q?16J+QFcSLu9GJVGKw0EwbxjZU65GSbvKzCH0sNeZJoajWqUTzCUIvF/fELG1?=
 =?us-ascii?Q?4sxS/9NKW30V3vYXPM8yayb9YYoFlVkHVw24H3Rnxvnt8sqPax+LiIbJhZer?=
 =?us-ascii?Q?a1pIJEikMvUQy7xFXNGAcIMzMbyZMqFENFeqqnUP76WX+Eg2gXRCwbV552NZ?=
 =?us-ascii?Q?thXPwFn5+ASOgvjBf6VbNLBfQH7ugTEDaHIcdYzE7D/dOMf+kq9vAw8dH4XU?=
 =?us-ascii?Q?K8SOYjk5N379X+IIpWEEyFv24ZAIu+iIhrZeWYsE3QoMgxE+29+teKJQ/THJ?=
 =?us-ascii?Q?ftR6U/hL4+EYOkNo85H+Jdi7kMBsXR5cm/Lc9xjytS19VzsgjTTI1ckKtHJP?=
 =?us-ascii?Q?zw7SukCiJaWmX9Xlb59ZdJ5jpTdWNS/99+xB4bNk2VNByAkOoT2W/+kh5yVr?=
 =?us-ascii?Q?Rv2qiMotrdwnyuqpeU6lrLq2TMutw+WA1ajp2LqJJ56+TDYzD3N/X1Lfsa8o?=
 =?us-ascii?Q?WdcYH6CEb4ffPr8pP6BNz2C2PkKR0+45mKC5amfYp0pjxToPfJt8f6MWs9P1?=
 =?us-ascii?Q?V1aBiUSZR4a7LTWF/BiPidmat0tHBQyB0uBAUe+zISUoV4ul20uCYrpUbHif?=
 =?us-ascii?Q?62rYar0H+PMMPrHh3ibrlMHtBCvkNcXpIEiGu0Ev/WAKbxEb9bI/Iz+n6ok3?=
 =?us-ascii?Q?mLVdWZ8uig4s5c2fu9CDrGDbyT6U7g9OL3eZOEq2fZVDKmVrmDXZeh9dnT/k?=
 =?us-ascii?Q?W+C2gLtre1gsqJqIf2jeiWGXppF1xCwOHeIogsX29eIabQ9ZDYlC48LOY2Vk?=
 =?us-ascii?Q?gtYkiKI8OhgBLmqyrulwk62S+94uY8eH2I8xsS9MPZwTczx7fc9l5829ChTi?=
 =?us-ascii?Q?F8tWm6DCM9fOvKzgigy0PVxHXR4ojuT4MkYzZkgrr4+hFQqfhjEAtVZX0OY+?=
 =?us-ascii?Q?HA0Yj3C8cM7cUImLQHsNuUmp2g2W752kQxwNfMGhGfR7b7Cu4cGkYcS9+UHt?=
 =?us-ascii?Q?ynY9h5vcjd3DbJPR0JlkEM3RyrPuKD8R2kq3TGvYQkNB/pxeVC7pN94d8u6W?=
 =?us-ascii?Q?hCWY1Lwt6wbNJY1itwRpJsyX0iOnP9qsj8D8RB8TECsXbS1A+md0/6KkoHUZ?=
 =?us-ascii?Q?eQK6jSMzgAB+V4ko5rh/bUSNdXgnJiHaLwz9txzoi8im9d7ZgluBnF4dYrkm?=
 =?us-ascii?Q?oiEnluGYhY5WIbf7RXcqkhgg7yzGGfS40I+B+Tvy5SeRHrTUhGvL3eNWyEul?=
 =?us-ascii?Q?nhyOaLUxXGpWofdOJLQilQMzL13gMjOWYg7zzZPijhNe6Cf0cjFVrpX+GsBi?=
 =?us-ascii?Q?WmNui801T7lq2/8StQSmiQFMDsam4pWPMBWjLgyb4FTkDCUBLas41C6oCi27?=
 =?us-ascii?Q?wKctngGd+9PZJ9/PoTUc1yWFx8qyLWeBuPRJhVGXiMbCqQV4+6+OaFYRP/MH?=
 =?us-ascii?Q?eRR9o/3qVw97cp6xgLgxJvV3SZRlyTTXJ/eMPwO4ugKc6Q8zClL36fQfpTKz?=
 =?us-ascii?Q?+NLx/nnL5NHst6XeJAcOActtVfXHY7XX+Pbr?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3n+Q4x2KG6PqsCq4dJFCJ6uQG85RuAZ+smk6lnSagRHnUEz590BSdzqfx6OV?=
 =?us-ascii?Q?b7v1YBmjfsuIByGZtk7tLqbwnD3TdOydueh56juc2oziQBLBVwzWx9awoqL0?=
 =?us-ascii?Q?xEhMNvY33+GRMxX187Ol8ivGkkHVpGsD3TSiYBBABfZU99jIUedtxBa6F/NO?=
 =?us-ascii?Q?oPnx2ejSUdFvp6WLeq8UFgunrj+YC42TJmMcNCMpxdYfTibemMveSD4xwbNt?=
 =?us-ascii?Q?Bf627h1oXfoM6vesTiT9uuDjC93NesS6Yimuf5kIGyNysEwGT12/aEIK39xZ?=
 =?us-ascii?Q?2pk44sAmF/28ZSPfuJ9DXffLAg15kqyhzs6ZQzg7DNblx5ElkikTD4WsQqdc?=
 =?us-ascii?Q?4e0J6VC9GJ/X4YnXTnHO6+c+XLH/oO1CM38hBMC8rvtUfYSlEzICTt92MIm1?=
 =?us-ascii?Q?0uXvWuyY6ewGSZjjiuwrv8PcInM5TE4+qJBASSm8UoVUIH/vExDjM3plP5Dz?=
 =?us-ascii?Q?1r4IutqVMAbA1u8aA2XIZGXDmiEDhKqF2b8KrOA+SQIAXK9Nr6E3nxHb3uoX?=
 =?us-ascii?Q?ldUBDNr4eyZzWWMu0ay9wS0KP1OP/8sl1Ld2Gcn3Dzlqq7LXyyT6cMf20NOl?=
 =?us-ascii?Q?fX6S4zykXRtnLox6tUGN71qvTN3dtVFQBN39UMsGlWJEvaAPjnuMjStBCHqG?=
 =?us-ascii?Q?CUCZMKNYk4gkMXy9kggXfVzO6d6xT6vpGZWE6WCNvC1T4TFI/01ArBi3W+hU?=
 =?us-ascii?Q?BjINScbb5wfixA4vDmpUpCCrA4rlavtBEMZjVwpcQr/YdivNdcYVofwUac+b?=
 =?us-ascii?Q?uFH4MF450JhwcKXdmnruTaHzzObwDU+b7bZ+xF3GldgpCwT2zivewoZVrtth?=
 =?us-ascii?Q?5l8xQNF1aK6tCbr/cqRRfXsTLam4YoQfMtXN/ScnbmWYhZt1tgOYpQKQjp4t?=
 =?us-ascii?Q?icM1BXLe6D8/4WlRyvXFUhwqAZxWJicnAWm9ERSSqq5lqJcXjXZA8H0ZtcVN?=
 =?us-ascii?Q?hBel2qqZ2PIJMgju9SnsYeMzxnZXQVDVdQpcD9YVGQUm5rL5NKdlhpHRrw34?=
 =?us-ascii?Q?m/mLOnyccCgv0VBDRbkALUmLn3efvFbEf5R8F+9YuP22eQbAYfO4rbMDdoEU?=
 =?us-ascii?Q?V2ZJV0rOkzWRx4QM82/bTAZGAW8w+mDA9wArS9y+zeZtS7NHXezRYnP4Bbvl?=
 =?us-ascii?Q?7XydiTuCxubbzRypo/igkiv7r/U+bchWpPzBUP7EvtuxTOiCJYVoEu5cZ7lk?=
 =?us-ascii?Q?1udVTWb4E8SBCmJoZBVdFtKXqgxZhVnJxAWFU+qRlX9goipruvLhtgrRAuZG?=
 =?us-ascii?Q?Dbg470LlkX13GJ6+NfN8jDOPitAOLEjdoUACNAkkkPSGeWahepe+WjcpfcTQ?=
 =?us-ascii?Q?83C51Xtn7suL553RTEAl3p8leRjkhv6UsVv0rKOwUKl2jzPb3UFbKN1egMil?=
 =?us-ascii?Q?xVxdMHDlbZMtr5GITEi3K4Erv/ACR9XZGtT1A0S3/VdSAMfswR3fzZ3B7HWH?=
 =?us-ascii?Q?jyv9LUbJIfskXNCPGulrmhWM9Hu7npbv1oftbBxKP+/87h18UhpoRYz8//x/?=
 =?us-ascii?Q?ttCg9kHYuDDFY6XuzQ6qd71c7GKLr5S25N//i32zF04HlLrkfypizxHTI8/v?=
 =?us-ascii?Q?xm/3t3XnbFWEXmqvKZ8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f706ced7-009a-4f70-9701-08de277f80e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 15:22:50.9611 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iy5oCLY72YQVMjOANRuNqYcBnuS8dIhFjG1wmCZSQsWj2+xwADrXdyIwWUAxx/yZyStPP309iZUtgjVI4pFbWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8379
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

> Subject: [PATCH] mx6slevk: Stop disabling device tree relocation
>=20
> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from
> correcting problems such as having an unaligned device tree and leads
> to various failure modes in the OS.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
