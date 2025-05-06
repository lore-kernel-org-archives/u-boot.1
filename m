Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997C0C3ABBF
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 01:17:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C949D81FAB;
	Tue,  6 May 2025 03:17:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Mza2f1dH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2CAD82076; Tue,  6 May 2025 03:17:01 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D8E781F7B
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 03:16:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTcp7chHIzxMDG6lccISdI+rYrudUkwjDOXz6uzW0ew3z40h4g028S2pRzplnBA/54FMEXGBX+knrV1gtzw8gCeTxjRGh2SPxH9BdOqRi1fS/M+msNWGb7NtSqcRJ9go7nMitXStGmX1kM6s8PKQ9VlWPPHvI7bZAmqnZ4ikTWhlTW7VHp1ZCehnGCy8hFRne+7Q0zVs5rzo7IO1FCU9n3hFwdpD1WNd4Q3J0eSRQo2scUGYWxFug/oibVtpmncAB3USKWmRMfw56qgLADmg5OBgjpd94T1euOcft+IGCL4yfGHVPxaQTT5U20AWWveBXNZoKuExKDiiz4ajWuhVzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yCp4uj5HwmC+4Z6V6whgL8PItWHoN6VjeDfIBBuYo0=;
 b=JezLXsLWFOO8hYwKnOfxIDBiAjvISq8QBQ1BPDYdNlyvyS0zmIaM7HBO9m6uEiMtK6XY2jmbwIb6vPE5RYdFo2qGdU0WaZsIUPoL3kcEkfhuL821U9PwSMuHkTtmKoLpOmbNn1+3rAp9bgYysvococEIynYQvICCsWpaXqlDFO3d0VFfXm9Vuj23qd1FiTek9Cp0wEYeQW57fXJ35MjqENKZSnjsFu9rIq961zVk/5HXuf3c0m7Q07qpqTByvZw312t+ZfEe6QLeapPjDma0EMOyV+Ntt3WvE60yr0hvxvWC+x36M5wFQBclGgVAIrSvzxhNx7LQ0t7+dSgeUwRrPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yCp4uj5HwmC+4Z6V6whgL8PItWHoN6VjeDfIBBuYo0=;
 b=Mza2f1dHv4ZKzwBtVHvGtYCVt8rKEC1NJu2S4KmrazYnhYnoa1g7sKEeWk22hraC9QI/r2E6eI8TLsmg79NPRjR8P3APnp1ak9arpHaauyqyJRrZY2Pcy8kYxbme5iY7p6wryLWiUs7hc6LpAyAUpXuqzPz68SGt6H7/+p62ACw8q+gUxywf8up5PMkb+D8jAFGJ2AD6+givZbYlTTnLYz2dJpF1RcvKMUzt817QOKhcVJyuf2yy0oxmhYIgTZwOAo6X/6Hammsasnwr3QxnJ6Jnlpzqu0b/CQBzDohhS/P23TBMn85fCFdeFSNvJFIkZA+3OVErRaKHyjOUf/iuNQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8192.eurprd04.prod.outlook.com (2603:10a6:102:1cd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 6 May
 2025 01:16:56 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8699.021; Tue, 6 May 2025
 01:16:56 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Adam Ford <aford173@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "festevam@gmail.com" <festevam@gmail.com>, "aford@beaconembedded.com"
 <aford@beaconembedded.com>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson
 <seanga2@gmail.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: RE: [PATCH 2/3] arm64: imx: imx8mn-beacon: Enable BOOTAUX
Thread-Topic: [PATCH 2/3] arm64: imx: imx8mn-beacon: Enable BOOTAUX
Thread-Index: AQHbu1FBcNflNEXA70K1RrTx6Tw/HrPE0l/w
Date: Tue, 6 May 2025 01:16:55 +0000
Message-ID: <PAXPR04MB8459C7FD3E0E48A98249846088892@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250502105859.978427-1-aford173@gmail.com>
 <20250502105859.978427-2-aford173@gmail.com>
In-Reply-To: <20250502105859.978427-2-aford173@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB8192:EE_
x-ms-office365-filtering-correlation-id: 12830d26-5a61-45d6-e296-08dd8c3bb132
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mDktOiFmqBJmVTO5pK14u1PvTbXghkQ9ATV/kB+Ol1QaitH7Id9lkRyhXTzD?=
 =?us-ascii?Q?I5FEEtpiq1/ZWihuZy3n4zR7jLncblzaViBfGjCTPhCGiGpdW0givY7YGNh4?=
 =?us-ascii?Q?tiVH6Rkyl0cA4NqvRfnh0spr/GDBe39rGmbxp1s8F8Kz77fh5fjVN0BNiKFN?=
 =?us-ascii?Q?VNtvyjusuUUFUAqTYkOM5GbMYjLG0vEKwmv15aUnizvmRMj0QlJEHPDd8AOg?=
 =?us-ascii?Q?YqG9j511zhgZXzzlLHkt8xwqR/+yE0nuisJ2Bei64z/LPyI6kp/8gv2GAyMv?=
 =?us-ascii?Q?SXsKVlYpNU2jGOYz974X1ae1yQKd++yywfoNg2jcQSWuDYhxJ2ZouWP0lvYI?=
 =?us-ascii?Q?ny8s6SrvfU/wF6yp81r0jIKhtDvTyM/1EzMYHCABAnv2Es+PbgrUMeT1strY?=
 =?us-ascii?Q?kJWeOWUeWYgaNK7zqGLGK4ZtOozMTJGY9G0vbw2pMmzM/EORG3lBmV313x1X?=
 =?us-ascii?Q?4gHKwHqZFubcyDMcXTMbX3ditkYs2e41klmPvQBgYaxvZ/auzC1T20D0IbqA?=
 =?us-ascii?Q?NQTmuK7GcB37FGomeoenpLrjxbtglD9dgIMrHWWSxNzNZaQH2fgw4wsQeoUd?=
 =?us-ascii?Q?wHT5qFhFZke+UIQX4e2UNUxYm0iiijXqHoteN5F/hIOde+hnWaUj2hrMsWxy?=
 =?us-ascii?Q?Ua9dSiZJwCPbIJ8SOTS7yRysLTW1HByLJekMdXxjhYd7TuBdMn03dalXev2e?=
 =?us-ascii?Q?35Si707ZV+g3J8qY+cmwJ6RidnZquDY/lonM6tbSEzqMPrldkJ15xCzeFaeY?=
 =?us-ascii?Q?N2w5mvviJfQyonxQLL1EdZnv5Ab7Hs1AQWoYlv8LvbrJLh66GVWSZF1j/DhB?=
 =?us-ascii?Q?m2pJoE1iynvTMrs7AvVuD2/2LxkV4IJV8bD34OvOTkIK5TH1ZJ2X3BLR8NgT?=
 =?us-ascii?Q?FsEhNlqSW9hN7ekcJgtPYpcNqHDqIAx92E8O1V/73uoD9T/yKhSW9hwQbhrI?=
 =?us-ascii?Q?nHmL87FnYzv8D9MGnxNjQsyu/rufT1QgP3ySoLtK+WYuINuIqjvln3ZXZIpC?=
 =?us-ascii?Q?4xb1fXf93lEn0Vegr+YjWyWPg/5MPlHl/8Vg3VdEu3yOrlCvZot+OQ7jFfnV?=
 =?us-ascii?Q?fBtT1woTkVh6VpoaJAgXQU8fsHrX3QwZxvR7MqZYeWNyob0NRcmx0jagygpK?=
 =?us-ascii?Q?ZHAy8w5188GEl16v9OnAy2HdZEcI/tMXCrR4ahjeR30SfApYgkS6W7GMHqSZ?=
 =?us-ascii?Q?Z/vPo/Ek/yZch0wrIi6yr58R90nX5JJ0xEOo5UGes+ZMgl2V+RYbwk+M89dj?=
 =?us-ascii?Q?y7d7RlnKEkjKLFNz1rTLNIpWAHm+0Ao+j0gPUmFdYp6eN9Il665enIg23aMO?=
 =?us-ascii?Q?d0zEnNPgAnyP1zHGvcjPOdrFo3OtvHSB6a0b+ph1T9iLgVX0x/YhkrjWksK0?=
 =?us-ascii?Q?5IrHUHdrMaVyEVpq7zyVw/Yt1t33G5Pu1ZaQvxNL4xO+IUiy1fFkWZgV+PkU?=
 =?us-ascii?Q?HEuoATvOn1Lwfo7Y9H+nDOQ9no6g3ig1D0JklC2IvY0hOlB2XHRKIw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aFkDDsUkq7x2ibCqiXKQTjO5rus0sDRw9/cHfyJZ6OrzNOimKcIuc3T/Nmzl?=
 =?us-ascii?Q?r+1OAjICSH9VZMsi52tEOIbaTW11llgTqwQGlbFFnlYxD4LXoLyUJQ8jAJ9J?=
 =?us-ascii?Q?Eez0Mj4KloEOaqZSkDD3k0A5PHdlTSDWIf1xiPOzjcpugr0KJXJrWFUOmdpO?=
 =?us-ascii?Q?sFy9xhvKl/kAVo977uYvQEzH0vyMnix1DK6gDpgblYhs33RYNZH/D74kFlsj?=
 =?us-ascii?Q?PHWHejKWcfGKWayhIiXbhzvmcpTh8wnwLC4g2/Xk9nBX/lE3Y4Ukv5D9XRT2?=
 =?us-ascii?Q?UgQ92hdOfhusixP0ilaDDHQtFMQJJtJyPxpEBuR2hCUcAzYMLCqZFrTdoSoO?=
 =?us-ascii?Q?uhPSohLrw131Gm57bKOgLyLUy8l9UW+9hxOmmhvzeQCuf52+412fIsb+QW2e?=
 =?us-ascii?Q?RMBcFgC6q2n+89Q4MU171g2J+3rsbIM85LGmHtXXt1O2r6RDnQ/B3yj+g0Wp?=
 =?us-ascii?Q?eYv0s8Wx4p850lBVWyV/9BU4J71HDs5VWQPwwUa0m1er8SFy5Ze9SPGGmMjx?=
 =?us-ascii?Q?fyavmtxyw8IT7mIfSkN9d0eaPfBDAy32GNPR0IKb0E4WAQRrhvIxuk5qjN5W?=
 =?us-ascii?Q?i5aPw+0cVQnK3WQqr+QGjWR10xi66dcHG7qU5MrnHBJhA4mqdzQqaT98ifze?=
 =?us-ascii?Q?PSbeAS8EILMDcIEv4AVKUJ3wqv9f+4dLYGfoKZRxXUNQyldS7zCmL7/OiQE3?=
 =?us-ascii?Q?EXsSQtzXsffJlh8xwLw7HoFY2w96IO5JEfP/z3/jOlCJUZe9njKBekt8JhMa?=
 =?us-ascii?Q?WD1Om6oIrmX1NqBNX3qznxN9+ntYBphTUJJvZOJShrK6bRzkFEH0YCWantL/?=
 =?us-ascii?Q?g+r0yDwI3ysunmZptwqY8+28a+Zc/fFdT2Gt7sc/DugZfDeFx1OnLh6Z2uu+?=
 =?us-ascii?Q?1cWPH3EyxMK8jbFJHVqSHtIzayRbe5LGiZyTEf9CvfYQXihFNopuiRUNugjn?=
 =?us-ascii?Q?q/we0PrcyILEYqxm+fDPzcOL1QYI9JPk59DRfuX7G8aFTR/jF4xYZKhL9AgA?=
 =?us-ascii?Q?8E+q9LmqNlhhgSjGrEvbTvFDDGWYS0h7d1t9EGmi15F7Dz0MbyegZ0nygzk5?=
 =?us-ascii?Q?ilqR+oTfmLNoLPhsTsxB8nb1K9BksdYtTROUl5IhF7EGJ+u8aj6LJy0U5HVB?=
 =?us-ascii?Q?/BrgCkIa82vOeHgWkfLMQkS5paN6Hca+Z1pr5s8FgWYYTiURjNfps3b/RVw5?=
 =?us-ascii?Q?OeliKeFOjEjdJRQWhqGvpMW5E+tuOAf5pw2bJG76dn2onOaDUC5fPswtUX1a?=
 =?us-ascii?Q?0F6RwIv6JjW6im2/Hg9YSQcsKETiJebbawpsXMQ6Kl/f6E2xVSW3bwA479x6?=
 =?us-ascii?Q?Y1c84FXeFz7/OPVKOJGG2SS3yIQlwAeiIPbJNDPtr/c83WRVBgl9gTmOzdPJ?=
 =?us-ascii?Q?cXJSr+OAVBQJ7gkbifhol+3tp4JKry84hC1MOr9Uv13uppr60K3MQ2PHJcG/?=
 =?us-ascii?Q?mdOk/u3FVpQh2ArD1P1JRzXvJ2l0Lf9iDbAldU5uX8B2lFJoyw6ITh09J8vf?=
 =?us-ascii?Q?6tFfWbA2fsEOPxcFBIYyaKbpmmOujQZ3kuXCkCVvJXEz9e7/1ali1BZWU/xT?=
 =?us-ascii?Q?3j9LrZ08y8MlVaDvfhw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12830d26-5a61-45d6-e296-08dd8c3bb132
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 01:16:55.9809 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bw166D+GDsKnvXJFIUsDbLVmoU0I639Zxi3TP1KBhz1ULbYximnpf/AU1hUpWioMcHR2ZM8s4EG86sTWoyAa6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8192
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

> Subject: [PATCH 2/3] arm64: imx: imx8mn-beacon: Enable BOOTAUX
>=20
> In order to run binaries targeting the Cortex-M7, BOOTAUX is required.
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>
>=20
> diff --git a/configs/imx8mn_beacon_defconfig
> b/configs/imx8mn_beacon_defconfig index
> c605567d9a6..115288aa27f 100644
> --- a/configs/imx8mn_beacon_defconfig
> +++ b/configs/imx8mn_beacon_defconfig
> @@ -29,6 +29,7 @@ CONFIG_SPL=3Dy
>  CONFIG_SPL_IMX_ROMAPI_LOADADDR=3D0x48000000
>  CONFIG_SYS_MEMTEST_START=3D0x40000000
>  CONFIG_SYS_MEMTEST_END=3D0x44000000
> +CONFIG_IMX_BOOTAUX=3Dy
>  CONFIG_REMAKE_ELF=3Dy
>  CONFIG_FIT=3Dy
>  CONFIG_FIT_EXTERNAL_OFFSET=3D0x3000
> --

Reviewed-by: Peng Fan <peng.fan@nxp.com>
