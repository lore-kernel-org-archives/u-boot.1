Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1136CA101F
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 02:00:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 191C5831C2;
	Thu, 11 Sep 2025 04:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="VtF20UoX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 252E08323A; Thu, 11 Sep 2025 04:00:22 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3E218319C
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 04:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfaGZuNxz1JL5X7Xkn2bOWwmKkyDm0s3uTUBa8inYfTagtnY03ZBQUWj+IHTi/nMdT2QrHS5QbNtIwSgEzsFyE1V/A+/KdKvTn+Nwxyt7A8K/3Jx/SZFhXDbBmNMRSjLesOacfqBcX8FNBH51UyZaiB4B5O6g036AwVnJH7mp6cBrq+m6NL4yY2ZaLsmBubuQJjmN4Q/ef14heWLedRe0HAJLs+FPPNQXVrgm8P4SAlj5MCBpBQxYErFX+GHMf86/Ddx9FRyrm0Q49HUXhKl3nKXBOwxg6Ifi48dKCcvuHrbN18/L2vdnESoUdAOlwxz3eHZLpyTj9U2YxZm4iclLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZz9NfjbJ9DD5FtI2kJRVv+eOQe6CpklNOQNpDdFtbM=;
 b=OpsmxVLN+17UweUUgjWGCTmdkxMNCF7+3Z8rdPChJF2goySZFG54VVk/uWSzvUbgdvOCYA3radUPkF8Q/Cla1QAWTn6fINXkuL6O4peS2CEfJoWnZ03YelOhI41kSrY2JMcdWXJwavAI7kpMDDFmm9zytEbhuavJEi0PtLMEpS6+z6BjeM+yCqotKnZdB8UQsReTjG7+7UIkSdyzjSSwRoqwvMdgnFf3RtInJwMeq2Gd6TPhq+V/w7jkd4AoKaRdM0/GqW5yVmGuypsJLWVQq8U2NhYWt+Oa1srKjG0Qo+s1KBC9t57hb/O+uRR74cevY9nYgpesQN2osEMB7gVcfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZz9NfjbJ9DD5FtI2kJRVv+eOQe6CpklNOQNpDdFtbM=;
 b=VtF20UoXrPP7f0mv7MD5UD8QEr/Lyrhs8nXjVN56zlxt782qkoKef3rE2BtI5/N5FTF2pri7y/6qsWCtW5srr/JOl6greLPwBz1xiuTpApMguAOe06iwnIDgVTGDR7N0k4hnIP1YvynQAQTpzeWEVwLx85eaR0HyWb9P7k1uMVQBZCYeZp5bLB4MsRAmbWLFlPtz4X9oEhiBgRbP/utAmcuaF9JovS7B9m20oir50quLVPNMexLLmBplBrN2Q8biQBR5+siBZYQzMWOAeeGmVsINJ1hqgFW1XdoMZzI68rV2QGh4huFFfbhO5E/IZ3Pk8/8CEwgXCTLMFlSdnf4P/w==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CH2PR03MB5176.namprd03.prod.outlook.com (2603:10b6:610:97::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Thu, 11 Sep
 2025 02:00:16 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 02:00:15 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>
Subject: RE: [PATCH v2 1/3] include: dt-bindings: clk: agilex: Add Agilex
 clock definitions header file
Thread-Topic: [PATCH v2 1/3] include: dt-bindings: clk: agilex: Add Agilex
 clock definitions header file
Thread-Index: AQHcIS9FC/fQHhaeukCNXODgs2dy0LSNPStA
Date: Thu, 11 Sep 2025 02:00:15 +0000
Message-ID: <LV8PR03MB813776306D48C76F8C2FF7CAA709A@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250909021116.12599-1-alif.zakuan.yuslaimi@altera.com>
 <20250909021116.12599-2-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20250909021116.12599-2-alif.zakuan.yuslaimi@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|CH2PR03MB5176:EE_
x-ms-office365-filtering-correlation-id: eff994a0-2e6a-4380-ab00-08ddf0d6f3ae
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?zAhYOBJJSYjytPYQT20mJO7G6CWheu09apjI7wC7ZRLjnltip14Iwp8NZS4S?=
 =?us-ascii?Q?53i8NoNlKj5L6YnG13x9OURb2zoZu+ioDO52DCV0rgIZoY0oY5wZt0Vqp4zE?=
 =?us-ascii?Q?d3p5NSZaXb0U/FRhh1gTmJziC0Rj4mI3ob8Uw1B9No/W7jGYNb7FuE31ER6C?=
 =?us-ascii?Q?t9Jc6BKSIazQSs/TeR/23Bc+LqI/zYK3V7qxciIScBTg7xaXaB7pylJ8GzMl?=
 =?us-ascii?Q?0JYejM3bmnBduE3ycOkNxiHuTQugwoT4+WN7ipMW5tUUG1us49/s6nrdSvlh?=
 =?us-ascii?Q?SiHS456nHDR6b472I2gsBvqwN9Vh4cNMZpaVw9/x/XSVIVV1evyFGG+YBJuN?=
 =?us-ascii?Q?zQpojpnGlV6UXLBa0LeY+V6RpCWI/VkY+vYRUruXftlyJFDLBcGGwG7ObJNM?=
 =?us-ascii?Q?8o/TIocNY5IMfnIUiKM2PR1WToJp+CI9M0zhW3wg8mRI7jD80By8txCg0GCS?=
 =?us-ascii?Q?wzNbxgDsRKaG/9EmTG2hlhYTfmzsZxV1GUrmPMhLYLHTYpTjdmYabcuaMk92?=
 =?us-ascii?Q?qUuurB85zOEPkjYQPZz0vRm7aQBjie668B9CLG9LlNXDHwmQ39Vhm5zIJMF8?=
 =?us-ascii?Q?+I9q7Z2z0Y0Dl6a2uUEqFOqK7FVzHpRCjrFdzyEcWqXqK0kaKQ81R4IDVI1S?=
 =?us-ascii?Q?322XAY3ho6N8zurIJqWgua1mo+e+GMJQJPPOcgy8IdQYHUMybRh7068ECAsX?=
 =?us-ascii?Q?H6v4/IG6/6cjmrtrIqW2dwhbuFarrIFsbvaurG9nyMz3D2AXppSGRMDxjP10?=
 =?us-ascii?Q?+MwQGVaQM5j3GBbXk96ktp3SnEDu7CghUCQTx633CRvpkR3dUlkX0eZlu1Vl?=
 =?us-ascii?Q?QdhPvxqgJgY68rLeDVmFXwdve+mPml+U3eCbr93x3XbucdwFdFAPzG57rGHV?=
 =?us-ascii?Q?oHMiPBW0IyO4NWtG+5uvfrNmFHhyWVQ7oqcFIzfFhq5wXQV05WtpGvqDTjXp?=
 =?us-ascii?Q?6/PEgiTKyglAYgCM6z2Ky8QSXp6K4BXdHSD+lpM7y8GLbfLg4LU2akeujefx?=
 =?us-ascii?Q?su5iU4QvLkhKQj2GeJ95xWxJAneUonX83RzKGHF+4CTIIiEk5Oyw1V81/WfF?=
 =?us-ascii?Q?zdvONkNe35L10J7xnRd7W1t130XY/3GBiLd0E0iSB0Xb9Rz6CxYkgdM9w7Nx?=
 =?us-ascii?Q?+E3qiejv9PgmUduw4PZu+5vWpzsuIbC4uQjx1vS6Qp0+JNPjEcHZEFUQIH4E?=
 =?us-ascii?Q?Bm71kVP7iA3ZCcSqYusNXz6RxcZZ67X5YXwVJqasZ0ongi/IObe/4hbqoh4t?=
 =?us-ascii?Q?OyMSAEtWBd72s3TccxRPwru8nHHvlVL0kjJfH6cWUBmPesXF4HZ9mW7MBcMz?=
 =?us-ascii?Q?opGxEyGXrv39yDv0HlVGVU7Ox0MoKCE6ECGXMtftN0A6c8ZSMFG1emZcBpk3?=
 =?us-ascii?Q?vUTELbNrhX+1mqGb+8LHikIjWrJYE3feI1AJK+ecjuMqLzBV3OCN6NiilzGi?=
 =?us-ascii?Q?/ZbeDPoRRC0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?myu0tZGam+X0EtVQBZ+hZZDIl2GulEk/lGeK+YO7WKp4AXRRsyaleYORfzP5?=
 =?us-ascii?Q?rwiDr6E8X2J5uxupb04iNL5RligATzbfwBTjQ08GM+8RuRETzYoF/oDPm3qJ?=
 =?us-ascii?Q?qG689bsTODPpCJUfLoCk978a2jkUW2H5/AhJzflVEpn7pbrHv5kLuvrBCcFQ?=
 =?us-ascii?Q?yd5NCWTrWx+33/sB7SOgNXBp+3OeNWH9seZRHPyPATSQW7VWohaMIv0E4+tI?=
 =?us-ascii?Q?Mi6b31dyBvvLn6MvnIScZb8qAfbaIWdKYHpc6wiomCmRCJHEglLXcC+mRfSA?=
 =?us-ascii?Q?VbJS/ia1N3023U49xI3W7u11kDo6G8+PRfCEFhaUbk9soKFKzUrLNAxN+94O?=
 =?us-ascii?Q?PIkOMjBKpkrjPhUNHnbAe005TmYenPw8chf5YlfkLxf3N2nG5IczEzLOWqAB?=
 =?us-ascii?Q?8kfVoWsymWx6JpkXFEjlJyJvgqq8JznEyZXtZ6SlJEZ7IKvTubxqGCmHa7x8?=
 =?us-ascii?Q?Jw8PH1rDB/+lp8SYqDcqiBMrzCKyTBs32TW4J8/nLNji6jA21m1Syo9Ol8Cl?=
 =?us-ascii?Q?drBCfo2G2lQRo7GnSgiqRyTw9nP4Q+AzMIIL7tUMuf2kT0M5w4YxLTYeWME1?=
 =?us-ascii?Q?Ic8+FJUCf3XwesCROnRLBy3Y6J3vkLAmsLMbjiO/pvgX22wnsL+rSYSOc9qK?=
 =?us-ascii?Q?MFZ39Xu5D5g7ScrTf8QjgNAI6HQJymCiuLNunsrn9VSCsbOV7z+yxjxjfsBW?=
 =?us-ascii?Q?ZjAnwDvgZPmWeG4Z0gOKyTp1UwsII3D/BdpkWYZvimzcfypgDA/n5aahGvbV?=
 =?us-ascii?Q?KXzTsDUuayaT0yLuiKDR/GBpprTsBMpTJm6n56CD29mB+q4dDG6agBD+xYQJ?=
 =?us-ascii?Q?w/xsPtF1sXFxnMqBbEEI3FDS/+6pkTzrfskHCKeEZPdQaDiKuk8yy2ViFbOb?=
 =?us-ascii?Q?xo4pcI5nqCsWZvR7f8y44XG9cdmgyloxrZlLkgJ5ThaXVpAhEX4oe+81y2gF?=
 =?us-ascii?Q?5HqrE5pSznYEyllqDOsE2bGKuzUeKoYmWTzinPQ4QD0rgGdvKrgSl0uYM/do?=
 =?us-ascii?Q?nxgxaLNLZo9vc0ICUsNutWO4VBbpqfIjvL/gmyz8PwblxN3WkSN9c7bsHGw4?=
 =?us-ascii?Q?mil33LR2hI28LyDm3h47SG/YoBixPtCVfwE4baYYWx439ynxXLkefbxEr+/J?=
 =?us-ascii?Q?13mKXi0lMSgCfNug7uWWIfswInIKDjQGl3Z7S/B9R07J6+1OBwnYzmA2/aCv?=
 =?us-ascii?Q?HYS9NJPl+dUPLMkM8tEecb3AbZ2uWFHSVRFNpRQg9oDswbIJhHEWTH+P/7K5?=
 =?us-ascii?Q?3TksakBaXiYKnayiaqcxGZcBKuh+AjT++9KcVqN4W5b2JUgubBKq4qP2WPwn?=
 =?us-ascii?Q?gyxTWP7imZv8x8JDW0tOFjQrcCK2y5vMjmyq1mmZTDYI2+tnhPBB8iK+7Hc2?=
 =?us-ascii?Q?owyRoyIkNKYx1HEcVtBoMehkDNQCndjb+ua15t8ZO04iVnOIx1CUsMZptQ6y?=
 =?us-ascii?Q?nASFmAEbPhyUrXdAi9z+XfzhHhx/cG6nMo2sYsPLdBndmRckLc9HuBDR0CSt?=
 =?us-ascii?Q?aOOJ1NOduBzjOC1hSGi4vhWJmiyu/NZZ/HSBSuZ7bNlcOsj0aBjQ1QNfhygm?=
 =?us-ascii?Q?pIX+w4VgQxvBHv88s2i2nRM26feJR4MnzmGXFvAO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff994a0-2e6a-4380-ab00-08ddf0d6f3ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 02:00:15.8324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RS72EIlYobJyLAck5NWAiXcBKsAfMlpsUG+MfRc6spJNuFXcTyOiMhMfYnMTmxIAtowlutG6sHdHdhqbe+PIXNw1FOcjc2s7tD/YHbBh9lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5176
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



> -----Original Message-----
> From: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
> Sent: Tuesday, September 9, 2025 10:11 AM
> To: u-boot@lists.denx.de
> Cc: Tom Rini <trini@konsulko.com>; Lukasz Majewski <lukma@denx.de>;
> Sean Anderson <seanga2@gmail.com>; Peng Fan <peng.fan@nxp.com>;
> Jaehoon Chung <jh80.chung@samsung.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Simon Glass <sjg@chromium.org>; Marek
> Vasut <marek.vasut+renesas@mailbox.org>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>
> Subject: [PATCH v2 1/3] include: dt-bindings: clk: agilex: Add Agilex clo=
ck
> definitions header file
>=20
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>=20
> Introduce header file to define the clock indexes for the Agilex platform=
.
>=20
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>  include/dt-bindings/clock/agilex-clock.h | 71 ++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 include/dt-bindings/clock/agilex-clock.h
>=20
> diff --git a/include/dt-bindings/clock/agilex-clock.h b/include/dt-
> bindings/clock/agilex-clock.h
> new file mode 100644
> index 00000000000..a6252180516
> --- /dev/null
> +++ b/include/dt-bindings/clock/agilex-clock.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>  */
> +
> +#ifndef __AGILEX_CLOCK_H
> +#define __AGILEX_CLOCK_H
> +
> +/* fixed rate clocks */
> +#define AGILEX_OSC1			0
> +#define AGILEX_CB_INTOSC_HS_DIV2_CLK	1
> +#define AGILEX_CB_INTOSC_LS_CLK		2
> +#define AGILEX_L4_SYS_FREE_CLK		3
> +#define AGILEX_F2S_FREE_CLK		4
> +
> +/* PLL clocks */
> +#define AGILEX_MAIN_PLL_CLK		5
> +#define AGILEX_MAIN_PLL_C0_CLK		6
> +#define AGILEX_MAIN_PLL_C1_CLK		7
> +#define AGILEX_MAIN_PLL_C2_CLK		8
> +#define AGILEX_MAIN_PLL_C3_CLK		9
> +#define AGILEX_PERIPH_PLL_CLK		10
> +#define AGILEX_PERIPH_PLL_C0_CLK	11
> +#define AGILEX_PERIPH_PLL_C1_CLK	12
> +#define AGILEX_PERIPH_PLL_C2_CLK	13
> +#define AGILEX_PERIPH_PLL_C3_CLK	14
> +#define AGILEX_MPU_FREE_CLK		15
> +#define AGILEX_MPU_CCU_CLK		16
> +#define AGILEX_BOOT_CLK			17
> +
> +/* fixed factor clocks */
> +#define AGILEX_L3_MAIN_FREE_CLK		18
> +#define AGILEX_NOC_FREE_CLK		19
> +#define AGILEX_S2F_USR0_CLK		20
> +#define AGILEX_NOC_CLK			21
> +#define AGILEX_EMAC_A_FREE_CLK		22
> +#define AGILEX_EMAC_B_FREE_CLK		23
> +#define AGILEX_EMAC_PTP_FREE_CLK	24
> +#define AGILEX_GPIO_DB_FREE_CLK		25
> +#define AGILEX_SDMMC_FREE_CLK		26
> +#define AGILEX_S2F_USER0_FREE_CLK	27
> +#define AGILEX_S2F_USER1_FREE_CLK	28
> +#define AGILEX_PSI_REF_FREE_CLK		29
> +
> +/* Gate clocks */
> +#define AGILEX_MPU_CLK			30
> +#define AGILEX_MPU_PERIPH_CLK		31
> +#define AGILEX_L4_MAIN_CLK		32
> +#define AGILEX_L4_MP_CLK		33
> +#define AGILEX_L4_SP_CLK		34
> +#define AGILEX_CS_AT_CLK		35
> +#define AGILEX_CS_TRACE_CLK		36
> +#define AGILEX_CS_PDBG_CLK		37
> +#define AGILEX_CS_TIMER_CLK		38
> +#define AGILEX_S2F_USER0_CLK		39
> +#define AGILEX_EMAC0_CLK		40
> +#define AGILEX_EMAC1_CLK		41
> +#define AGILEX_EMAC2_CLK		42
> +#define AGILEX_EMAC_PTP_CLK		43
> +#define AGILEX_GPIO_DB_CLK		44
> +#define AGILEX_NAND_CLK			45
> +#define AGILEX_PSI_REF_CLK		46
> +#define AGILEX_S2F_USER1_CLK		47
> +#define AGILEX_SDMMC_CLK		48
> +#define AGILEX_SPI_M_CLK		49
> +#define AGILEX_USB_CLK			50
> +#define AGILEX_NAND_X_CLK		51
> +#define AGILEX_NAND_ECC_CLK		52
> +#define AGILEX_NUM_CLKS			53
> +
> +#endif	/* __AGILEX_CLOCK_H */
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

