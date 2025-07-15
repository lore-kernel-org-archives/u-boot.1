Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71140C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 01:15:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 969E182AC4;
	Tue, 15 Jul 2025 03:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="hvZyxlMD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2945282B07; Tue, 15 Jul 2025 03:15:15 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9EF58277D
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 03:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecotuJs/HdGwCOyNDtViRoRdVFD7Pm97TN9eFPr3alLOHxEjWu7g+PYdNoXHNZwTaXutmi3frElODN+CmHfGldyVaf59g0mh20px+Q8MBfgBQKyvSGoXiyNbPM9dJ2bpehEsmqnplLwnIys/rpLWGxBH1AB/b9AstkaXTOfA4km1DCDRRIZBJkPvahNkOur4Vo0E3KeZdYwzdAS3UhAnuwHwpaBZ2Y3viK3o3JX1lr+eFybdEnxgjBoO0M1K+a/y2TVs7wqHqsWGRTq3uluknr83LITgP5uuUlR5WEKOM7EnCsmPwTVp/7SVum0e+ZpOk92lotMz5k40AGxfNQyovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQSWwQC9a0wm3BptoEOsyfMFwmM43vgSt7WgUOg7mPs=;
 b=fn2m+dQgQlCfUbk+UrMBy6tK3Oknp/vVD0Fh4hMyHfJ3t2DaIOY+Cr0cXl4JDASqinRISCjRCFpG1A/ukxp3BJPz4jzj3OAq6Jo8RlaQw88vCjgrALFhe+7QZDayhQ7vTdfzNvLcmCt8J8DMg3BdwNsxecPTEHeJkdaaLY0fT1Ra2XL/gkr2a6IelImJHu9NIIdLdJ7PC+ORqJR2Orahukv+sNIVqcRGiwfVptIG6Gi2qumTCe99LQwOt4RTGG3yGEZoY9Nxuy26MQk+RYga//0MRV0P6YvuGGL9n11i4kDVp21QvDYlHqn38x4Nd48Af8kxFOfUYAvD3HHnT7mOBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQSWwQC9a0wm3BptoEOsyfMFwmM43vgSt7WgUOg7mPs=;
 b=hvZyxlMDp7LylmTFzSrLdij1BcjyoWlVSShOvRnw1eUs+8ggz2uNdByAlsOFyN5AFV8TeTZN6iotRC5DFLWcN8ZegGFpS6ArfXOe08VwGEBjJRUlQzogVRglVxUfvTBVKZQXjfKt2UemMVrWa/vfk0F5gi63FDjBmYRRaB/8dJtujgzb2zS+sSl0xIgU0lqSPEPDEGW26jUzTFeCuoO21BbIuPYxe1q7IQhem10byJDURQmQMsUmyVqI9bmEeLXTb+Aha4/JEhlZoR0xpsrau79UoSQzxST2c7qypJfIZepFDiuFpDiFujN0QtgoJMgLuCUlJT/7NHY8VonEphxwOQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8680.eurprd04.prod.outlook.com (2603:10a6:10:2df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 01:15:09 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 01:15:09 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
CC: Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <ziyao@disroot.org>,
 Chukun Pan <amadeus@jmu.edu.cn>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH v2] mmc: rockchip_sdhci: Set xx_TAP_VALUE for RK3528
Thread-Topic: [PATCH v2] mmc: rockchip_sdhci: Set xx_TAP_VALUE for RK3528
Thread-Index: AQHb9P6wanFrS/58/kujUtKs6COc/bQyYaSA
Date: Tue, 15 Jul 2025 01:15:09 +0000
Message-ID: <PAXPR04MB84591B628A56777F00320BEF8857A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250714203410.1782783-1-jonas@kwiboo.se>
In-Reply-To: <20250714203410.1782783-1-jonas@kwiboo.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU2PR04MB8680:EE_
x-ms-office365-filtering-correlation-id: 10b5e71d-b8e3-4159-ec20-08ddc33d0aae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|19092799006|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?v0sl4EMPxz8hM2uK/klPLPYGOjzy+yq1jyPi/ziG69u7CPE6OncJRD4oj69z?=
 =?us-ascii?Q?U2jndAXXrG5Bp6kBolu3nAGgL5I88e5ErEVvFAxaJGEookIlvKNgBJPJsBQJ?=
 =?us-ascii?Q?vUfCAg3SehGmq3xX+wfGkOBKob3M4sHriLwXVFzRrm4F9L2UaAaQzgmO80bQ?=
 =?us-ascii?Q?24np/MYpA+yuhSZPfnu1zNUlwsgNKJ46TpDUcaW2uViUkkuQTuD2JyZFtCpR?=
 =?us-ascii?Q?k4ak9OVmTc98CndNrwrO2urgFSBnqdt8slaADRB5C1wQa+08XpVJBMqAmLEA?=
 =?us-ascii?Q?bTLrwx8C9YzRHmP+EbUdRkA5zpoK6WWm6MSReYALOwzSe+zmqAxHqvy3V5i/?=
 =?us-ascii?Q?bDMMKd57iNi82GJPA9S9KEQdB3Vftg94hg4x9vR4ZgfGdje3CezihAm2QXxZ?=
 =?us-ascii?Q?wJHcPsizTblXgT2a8RI3iQRaSil2LR3LEYOQcWjVmNWZvnYELOBgChFWOapY?=
 =?us-ascii?Q?V3tG1lZ1QSIikKVusnj49UD9hkT64ZP2KXoRFdC4cOllyoXUbV6qFen7OHLZ?=
 =?us-ascii?Q?VfJFlN+3z6G/sm/PSyvIpWPHYNTJVqolWXWYTAUqvXq8O9NlLYaFp+iR7+F/?=
 =?us-ascii?Q?UUIa00fjrduRsn6a7hTY4K6o5qp0CJdPFUuaumJk0MjMS2SKWjbcSTfda7v3?=
 =?us-ascii?Q?45ChCpJ81ykzCgUI3Fw2Ei1FZgoI+XaMeCKOgOg2GqeesXSD0Xpp36D3iPVr?=
 =?us-ascii?Q?aizJCDU56ufclYa2xADq6sFinm8fgdi6dp5KxDT5hrDChKDnlqYvh0pKCG2U?=
 =?us-ascii?Q?XvUR2Vg30Mc4aJS45z2QPLCA+dRlr6Ymld+b31S2WgHXjiC8Qp/guf369jif?=
 =?us-ascii?Q?LdrukTgkDzaGxfOg8NGcbOTWInsKlmo3NSlSt0ywsQ/fX+doDo/87aZJWWNP?=
 =?us-ascii?Q?B3CYE5W5jGl5935g6/EzMk0qKsacd4rfzZ1ban7z5Ad9AvrtX1qCk+guW2or?=
 =?us-ascii?Q?GmxcIBoF+nAYQGV0x3kwIDfnprZH13hHH2ojna1NSue9j5A3PQdhQ0B3zAPe?=
 =?us-ascii?Q?Uv/SwncJsadmE5l3LZ6fg3NtfzJpQKP/RdzXM/cS8yjAMcJQ4V8nTjZz5VUx?=
 =?us-ascii?Q?6/A9L8/M4HOVXIluzj4GyCWI3jLDWgW+/LhDjbn3XVApF1fC7bxr1aBH6O+d?=
 =?us-ascii?Q?ik22kFvNHYCyTStD8m7Xy39rF0ba7daXWDvky9VOq5aCGlF9ptw6ujNtS63t?=
 =?us-ascii?Q?PFg5yPqHg60Dda7h1MjZUagEn+ik9UzzdbsZsVcboTR+maH/n06AfwoZKBsp?=
 =?us-ascii?Q?CoVRFEuss0OcPS+hJ7o4qpYvvFL+CeuPw0NkBWa3AESa2W2EZOHSmiUlzWIF?=
 =?us-ascii?Q?yCzJKFDQD4zrirEdfkOpgcuSMo/vB6Pt1HbQJY16BRYKqP6Dt/2OlTquyPGN?=
 =?us-ascii?Q?Vxk7nrUK0h3SRyFXUAXe/mb9XAgRFQn4DNFeR67K+6fBg9NIgYEK05CgyDOY?=
 =?us-ascii?Q?aD4732YxhmjUB3Iww5NGGBzRWuI7tuYMoVldD5nuzScfe+LMD28OHQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(7416014)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cx1XjZiBCNTUm2wlMfQjAR7zveE4rI1DErcaZD8pMfevIil0VSG052HqXlA9?=
 =?us-ascii?Q?qBxXwpNO456cgrGhZ1+FUSoNfGKi83funaUBTmF8XEerU3MQuptivTR+V11h?=
 =?us-ascii?Q?3zjCA2m92Mu4f6S9Ih+5HrXUuYYJRotG5PsY6yIfcZxZWio0WjZ8taKGdcbq?=
 =?us-ascii?Q?b7vDk+hIL/ygeJAC9nWgxZVRIpJt6hfwi1Gr/rUUZe/qBxdAnr4g9AEy1oPB?=
 =?us-ascii?Q?2cEDjef+cAJxvcyPgcxBHK/d5KU4Fldir5cNqORwtr6jyx/uDe34fpqpTHJx?=
 =?us-ascii?Q?IFoveog3WXJrbKFjfElbquinjjd+TiHfadxC2/iUbBgvQ3Q4WAltTi+kblOE?=
 =?us-ascii?Q?w1rHAL2GEsziHRSW0uqT+ZinDYvXc84yUSMhnArSCQ79zldOOiTjoHYgAAPS?=
 =?us-ascii?Q?dx0PxXevNwQxrV4m0KVY39YV8brzSv1CbSp2YNOyqpS3lsML6ZwiDptOO8WF?=
 =?us-ascii?Q?qxeJu5pZXzAsdcqrAkvl/W+hMuF4vjM8oxEy1my27xHi5WmheSoQqNqBV/5B?=
 =?us-ascii?Q?kyChb5Mc1FWbe9zukUgoE6VrnRNQC6Sr8FHQAnR1ZXOTG5rQw8y6ITd9xHd3?=
 =?us-ascii?Q?GQbBLkD9b0UR9xmtYtfuJXsIDlUrLXJjLnkGFzpHTB5pEa0+374p7d4mSLnt?=
 =?us-ascii?Q?b8QCMpOB9FBxDzLwbyB7/hc8a5OgdRzQuob7aUdgEqAUQFGdv20ljUcIibgE?=
 =?us-ascii?Q?DIIvj6pKCFYelmvWae7YpwaoFuvLakbSZhR0J52pQ2ACJRS7fnPP+y1dnQBC?=
 =?us-ascii?Q?C7KZr9HVvc9DTDVWRN/BpNXMkY+qwiFG+7zLLzkfKOdlZ8gtQjNm1tNcuZp6?=
 =?us-ascii?Q?4pv1P2X58KXSAjhA7S4Czee6SVR+nBY5QCcUV7wD1Lm4FoWOW701ZQp/1p99?=
 =?us-ascii?Q?q/GP9zkFMdq2knNxiu8oIq7Jj20lIVm6/d46/Uou/pmOgMQxqbYkS6g6LPCC?=
 =?us-ascii?Q?fmNUT/f0luPJlQTDATkuxpXHMvmZNKlTUJICLjiZfMuOAN4H0hzXUoxJE7WZ?=
 =?us-ascii?Q?VcPrJ7+jf6j0vjoNlPrV0X7Rh/YOYogGCM2IQjDM/mYzEUsfTNXFnsgMwNEJ?=
 =?us-ascii?Q?wJQ/VfxGjv9CN449jz8zWGri2E9nhbm4KuL7uUOk8jZk200pNfdLcuZnvPG1?=
 =?us-ascii?Q?99cCiB0KCK0c9WIGAV0nrDdOj1QITYEzhtpSWDfgbqMezLT58VsnDhwP3Mep?=
 =?us-ascii?Q?hfmu2kpvqyC54OgFDxYnRWbikP5pJEhEi3eXZQ+jBOGr/oUjotlT7GS6ut2K?=
 =?us-ascii?Q?FmBacIwT253UPyGirXswFxd2Pxs60wTd1XfXcGL0z6AeuiKgKLGhJJIfWAHi?=
 =?us-ascii?Q?us/wWxps8PAE7wUD0wH5jF92tq5fXa6E9p/FhDsasr8azhOhrWBALHgeeRv5?=
 =?us-ascii?Q?SkJvgUgtYW/XICMwi37tLfwsPl2vw+LirY+44KYHDMZC91tHF8EW1kTmG6dh?=
 =?us-ascii?Q?CsUQjEg/bvGFcXiBCK+kGDMO8DWPLbmcz9EX6vg+SJWEnJpyc2wU8JG5c2sF?=
 =?us-ascii?Q?v8L/4FrLe8DJezz6tfU3FDZkp5KjPyvo0KBRBdxE9Q0Vp5mFi+d3x38wxXL7?=
 =?us-ascii?Q?1cO/4yHV/UFYX+xXo8M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b5e71d-b8e3-4159-ec20-08ddc33d0aae
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 01:15:09.5734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1eNac/RaA4OA+F0MecsLYLHdsebxh/ZUWPnsjLonVjo1rmOBTMy923Fl46vXxdL6D231Y21tLkUEsXNb7U7pNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8680
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

> Subject: [PATCH v2] mmc: rockchip_sdhci: Set xx_TAP_VALUE for
> RK3528
>=20
> eMMC erase and write support on RK3528 is somewhat unreliable,
> sometime e.g. mmc erase and write commands will fail with an error.
>=20
> Use the delay line lock value for half card clock cycle,
> DLL_LOCK_VALUE, to set a manual xx_TAP_VALUE to fix the unreliable
> eMMC support.
>=20
> This is only enabled for RK3528, remaining SoCs still use the automatic
> tap value, (DLL_LOCK_VALUE * 2) % 256, same value we configure
> manually for RK3528.

May I ask how linux kernel handle this issue you spotted?

Thanks,
Peng.

>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> Changes in v2:
> - Rename flag and field value to function name, TAPVALUE_FROM_SW
> - Simplify and make code more understandable with use of
> FIELD_GET/PREP,
>   should be more clear that xx_TAP_VALUE is set to DLL_LOCK_VALUE *
> 2
> ---
>  drivers/mmc/rockchip_sdhci.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/mmc/rockchip_sdhci.c
> b/drivers/mmc/rockchip_sdhci.c index 761e3619329c..cca917da68e7
> 100644
> --- a/drivers/mmc/rockchip_sdhci.c
> +++ b/drivers/mmc/rockchip_sdhci.c
> @@ -9,6 +9,7 @@
>  #include <dm.h>
>  #include <dm/ofnode.h>
>  #include <dt-structs.h>
> +#include <linux/bitfield.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/libfdt.h>
> @@ -86,6 +87,9 @@
>  #define DLL_CMDOUT_SRC_CLK_NEG		BIT(28)
>  #define DLL_CMDOUT_EN_SRC_CLK_NEG	BIT(29)
>  #define DLL_CMDOUT_BOTH_CLK_EDGE	BIT(30)
> +#define DLL_TAPVALUE_FROM_SW		BIT(25)
> +#define DLL_TAP_VALUE_PREP(x)
> 	FIELD_PREP(GENMASK(15, 8), (x))
> +#define DLL_LOCK_VALUE_GET(x)
> 	FIELD_GET(GENMASK(7, 0), (x))
>=20
>  #define DLL_LOCK_WO_TMOUT(x) \
>  	((((x) & DWCMSHC_EMMC_DLL_LOCKED) =3D=3D
> DWCMSHC_EMMC_DLL_LOCKED) && \ @@ -93,6 +97,7 @@
>  #define ROCKCHIP_MAX_CLKS		3
>=20
>  #define FLAG_INVERTER_FLAG_IN_RXCLK	BIT(0)
> +#define FLAG_TAPVALUE_FROM_SW		BIT(1)
>=20
>  struct rockchip_sdhc_plat {
>  	struct mmc_config cfg;
> @@ -317,7 +322,7 @@ static int rk3568_sdhci_config_dll(struct
> sdhci_host *host, u32 clock, bool enab
>  	struct sdhci_data *data =3D (struct sdhci_data
> *)dev_get_driver_data(priv->dev);
>  	struct mmc *mmc =3D host->mmc;
>  	int val, ret;
> -	u32 extra, txclk_tapnum;
> +	u32 extra, txclk_tapnum, dll_tap_value;
>=20
>  	if (!enable) {
>  		sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_CTRL);
> @@ -347,7 +352,15 @@ static int rk3568_sdhci_config_dll(struct
> sdhci_host *host, u32 clock, bool enab
>  		if (ret)
>  			return ret;
>=20
> -		extra =3D DWCMSHC_EMMC_DLL_DLYENA |
> DLL_RXCLK_ORI_GATE;
> +		if (data->flags & FLAG_TAPVALUE_FROM_SW)
> +			dll_tap_value =3D DLL_TAPVALUE_FROM_SW |
> +
> 	DLL_TAP_VALUE_PREP(DLL_LOCK_VALUE_GET(val) * 2);
> +		else
> +			dll_tap_value =3D 0;
> +
> +		extra =3D DWCMSHC_EMMC_DLL_DLYENA |
> +			DLL_RXCLK_ORI_GATE |
> +			dll_tap_value;
>  		if (data->flags & FLAG_INVERTER_FLAG_IN_RXCLK)
>  			extra |=3D DLL_RXCLK_NO_INVERTER;
>  		sdhci_writel(host, extra,
> DWCMSHC_EMMC_DLL_RXCLK); @@ -361,19 +374,22 @@ static int
> rk3568_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enab
>  				DLL_CMDOUT_BOTH_CLK_EDGE |
>  				DWCMSHC_EMMC_DLL_DLYENA |
>  				data->hs400_cmdout_tapnum |
> -				DLL_CMDOUT_TAPNUM_FROM_SW;
> +				DLL_CMDOUT_TAPNUM_FROM_SW
> |
> +				dll_tap_value;
>  			sdhci_writel(host, extra,
> DWCMSHC_EMMC_DLL_CMDOUT);
>  		}
>=20
>  		extra =3D DWCMSHC_EMMC_DLL_DLYENA |
>  			DLL_TXCLK_TAPNUM_FROM_SW |
>  			DLL_TXCLK_NO_INVERTER |
> -			txclk_tapnum;
> +			txclk_tapnum |
> +			dll_tap_value;
>  		sdhci_writel(host, extra,
> DWCMSHC_EMMC_DLL_TXCLK);
>=20
>  		extra =3D DWCMSHC_EMMC_DLL_DLYENA |
>  			data->hs400_strbin_tapnum |
> -			DLL_STRBIN_TAPNUM_FROM_SW;
> +			DLL_STRBIN_TAPNUM_FROM_SW |
> +			dll_tap_value;
>  		sdhci_writel(host, extra,
> DWCMSHC_EMMC_DLL_STRBIN);
>  	} else {
>  		/*
> @@ -663,6 +679,7 @@ static const struct sdhci_data rk3528_data =3D {
>  	.set_ios_post =3D rk3568_sdhci_set_ios_post,
>  	.set_clock =3D rk3568_sdhci_set_clock,
>  	.config_dll =3D rk3568_sdhci_config_dll,
> +	.flags =3D FLAG_TAPVALUE_FROM_SW,
>  	.hs200_txclk_tapnum =3D 0xc,
>  	.hs400_txclk_tapnum =3D 0x6,
>  	.hs400_cmdout_tapnum =3D 0x6,
> --
> 2.49.0

