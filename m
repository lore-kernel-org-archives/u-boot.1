Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552FDC25B75
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 12:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E036880A8;
	Tue, 21 May 2024 14:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Csksrmdh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52A108803A; Tue, 21 May 2024 14:51:08 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2935D880A8
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 14:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UF4ryyjcR05KNq8LPFJNeLssocP01NyhZKBYnXq/+OU6YM77Z01Q8v5Q1A4euokxH9Pllfqyev3JawQ8k/0u5NdUMeZrTBBFPno/zL12Y2NZKyUh5I5mDwtyfxrIjMm4z4SHwVQMzhvU40EpoH/UslchSWB0LGROH6M356sg7Q1xB5j0/Ua5fPTFhClE9n0X0iIzMra1Vfpv943uM6W+GhZBPMBpZl7nQeBnGztYUg8/2u7VI7WkbLcM6Dqa76crgsqkKKupvfvLqHiQMpkWnmNpIhWHEaN7nbdJIPhOg6XfsUPw5qZ8ku7WGTd3mj503nHJVgjC2wlztfROm9PJVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NNPop8/AN3Zr0RS+Cp/2pPEHM+IQzmB0k2FmCNClII=;
 b=Z8T+VlujEHr/zc+nDbbaQeoKIgVe+JRbg08RqFDh8bga+tSJVEFNFf06K5gOiu9PafWRC4fbnia/tYa2Ce4qdB9j4Ydip8AxYKqN+ZFlTJW5/+8EXS+23qpU7pxMP+6b5Dcy/V8+338wlKq770ApgbBJXjeSvwaZFay1kOjNFs4o9HMu4DP7GMjagqCeIShylJ/Sbu2Aw2hqrNUJzl9ag6TI5AAnGRWkpYq0UPSARPPx8575OjcCFl9sSvOdnQCCRGE55tAegKCjqIoV5v4jFFmn2v/t92w4/PYb5F4Qi4KJ/NiF+NNHhH2T3jpPGlyULW4UzAwFRG7uk4PqYl4DCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NNPop8/AN3Zr0RS+Cp/2pPEHM+IQzmB0k2FmCNClII=;
 b=CsksrmdhCMV7oYYOYuMpizKrrdfpZtZQvwQjtf6YC8546R9hNFsLc6b4z4jXqt+hYEIIaLbiYaMJH+mfXWF4SInUC4aTLI/KfX48ekUa4PKzI/9t3LgITUr5Dm2nNgcppP4Fq/ReD9eM5ldG0Htgkh/E7qLAgc0C3q+RnPRXtOE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8489.eurprd04.prod.outlook.com (2603:10a6:102:1dd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 12:51:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%6]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 12:51:04 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: dl-uboot-imx <uboot-imx@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Philippe Schenker
 <philippe.schenker@toradex.com>, Martyn Welch <martyn.welch@collabora.com>,
 Stefano Babic <sbabic@denx.de>
Subject: RE: [PATCH] ARM: dts: imx8mm: Update iMX8MM Menlo board configuration
Thread-Topic: [PATCH] ARM: dts: imx8mm: Update iMX8MM Menlo board configuration
Thread-Index: AQHaq2MOO+JhosCkjEa7tH07SDZXTrGhpDDg
Date: Tue, 21 May 2024 12:51:04 +0000
Message-ID: <DU0PR04MB9417AC429F21F7AA8EA93E5688EA2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240521094108.8858-1-marex@denx.de>
In-Reply-To: <20240521094108.8858-1-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8489:EE_
x-ms-office365-filtering-correlation-id: 020dac42-79df-4e06-25b2-08dc7994ad1c
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?R4wOtZRWlJrHGgC+UU5xiJLMn/Y97Qs9pBjOHom4xR1GB1uFeRUy274RbVxv?=
 =?us-ascii?Q?s4uybDhC6ASrCGOUcZmxlm/vPUGopt1BDcr0bOY9wxIaxBLv80J5MX0jbQeX?=
 =?us-ascii?Q?lZyTtOU+SLvhVIFiTF+sAvgMOaO8aJOZtn6FIAzobsDaDjZ2n/9vsNbzpLsZ?=
 =?us-ascii?Q?VVONy25uHrzDfQDdvOsdw9CIEopIIbcoYGkHbeG2r9nPWWClO3HaTcFuUsmQ?=
 =?us-ascii?Q?tdEnljqVb0FQpgNIpGpoYrTYxRYaE6fhNoIG0z/zJTCk1UnU1wCswelMwUMK?=
 =?us-ascii?Q?4Lzp2wdUlYs9T9slg5B85hH4C+xjSHbki3AR6GuAepVYm+HmUDNTm/0rGHF9?=
 =?us-ascii?Q?m1ozMqfEVw/1ZMfqJgSxvvuJ6ehmLQ8UGzxl6vhOtDTVaS9qUryNNkqzNemV?=
 =?us-ascii?Q?PEZaMK7Y2aIM546EXHCqADuS6u+yK19Ec+58pLr03NY7rBhkObbi3Yb2/5bU?=
 =?us-ascii?Q?nSv8JfrUgMo/AkKFDA/DjjvMgWvuNWqJ47cKDvwmgcxi+HFpInmYeo3vSfDV?=
 =?us-ascii?Q?IitsOk+LEVPo7L4V2macFS94pjE8kQcN3J9i/2xX7wfBLHkKecDzId4YDO72?=
 =?us-ascii?Q?1zfohsczJJRan6bk/n0blc/wyhDZXKVOE4a9JB+mua+++CsMqlKoxKQQz3Rm?=
 =?us-ascii?Q?rdiJjL2YbJ+R3CTLHvEMdNIFCJuWQkqDHRuLxza9gC75RcY+0QcsjUOLk7w1?=
 =?us-ascii?Q?iBSARj5ajVUbdLSzKT4/KBiahdQqHTADV3LycLV4CvdNqRuFv2+fOXeFWHzI?=
 =?us-ascii?Q?vyNR0l0jGpvGdx062Hf0JJJFkIjK3bE3JRSxnWEWG2YiFV6Ak6su1VcLJj9v?=
 =?us-ascii?Q?uhI1QY11723nI9aj+S2sg0rZmSjENf97LYppvwn7NaknVA7U7uUf8BbeEtef?=
 =?us-ascii?Q?7RRB5WOm2ilyJgwyp5kIFJCsaF43OeGKFaABD/J3bXPlFaHKdtYfjktzut+m?=
 =?us-ascii?Q?uoNR3Cbz5tmVOB3oklNYGHVaBpbkMbX2xgpnmzUsAVH2JFy6V9J37E/Wyrb6?=
 =?us-ascii?Q?57rEze1khNSKNa6QuxruLS9W3U8DGOSOtO2MZz26czJmFdr77CU7fBG81LZu?=
 =?us-ascii?Q?SaYWe9B1hw6oze6q1xudjiiiFMg9ou4jX5HLv3m9GRputc7fvfnCDOJzfjby?=
 =?us-ascii?Q?deIJSCtm+LpQJC253aIQroPF6La4Qde6Eax+dNBRA4JfQw8gViGkREfTZgr3?=
 =?us-ascii?Q?TW4NDIqyY2dCmXNin5eXtNGWF2/WS0MZsNk66+Sn/QkGFYvR7ynAVArpce82?=
 =?us-ascii?Q?qZuDqSiRIyAWeOR9FzjMOGepto92zlneWxl59u7ZMxrds4w+ICjUfErxsd1q?=
 =?us-ascii?Q?IzDOuk6muKQ6Z/nKUyvbRQFJoibaq7qKbCPcFtC2SL+r7Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UlFZ20jXG9UhPQe3QmDKcWObkejc6DhvFsJCz/qFIlumPEpFcuQM65ycnD+g?=
 =?us-ascii?Q?f+09+kBTzWrGJuR8mY/kOH8pnsr/L3cotHsLHCUoe3yz4sE/V/1Dzc/n1QoD?=
 =?us-ascii?Q?NMYe5hwBpqZ7hjFHwolKSjsGvKEANxD9JtZKA7Dtd4R36OyYnZqKi3Kzuw5G?=
 =?us-ascii?Q?HVL9k6b774xRETbaS7TNi9bZsx/OvMBAZguhr1kJhpBTovjkD1cWUIEPDcSk?=
 =?us-ascii?Q?GChtVlv9Xu/gPX7GgKIAJRlKXEOTyOmw/wrRhkt8Xc3+AyaLDiGmMs5bNI9d?=
 =?us-ascii?Q?+N2+Xl0h8OtEebIOJrLWgEPsvFQ9LMfCjygZ+oRio5KNlxgNwAnas0nsXgFg?=
 =?us-ascii?Q?FRcWWNsmwtbB5Qd/oZQnX/eblHJd2ckryldo0GH393wqTirKBq4qizlheQqo?=
 =?us-ascii?Q?LBJnZnbNlRhy1skInT8uy1APhJZRFOVVx1JDaycvAVuqPfCxK9L0lvcAdY/k?=
 =?us-ascii?Q?7ojjH5xQcpnjgR0uPWty8PdDPLaZqHTLXNdiuT5FeBr+h0C0fDR/9+X1q0O3?=
 =?us-ascii?Q?vdCis1KzFtUgmSpYm3BtiCuYUWx7jFSOGutZJRSLnBIgYpyzcHBdE7/DOCWZ?=
 =?us-ascii?Q?ep3G+uNmKE+42aI7UuLDn1HtFHVeWUAcazht5zOXJnLIxUXI0/LD8XtnPZTi?=
 =?us-ascii?Q?5lwVIW5BfieHhi6gtsMPPSzPLIzf78M33MZ6YCxqBrHsmnV8sg34Etp16eAO?=
 =?us-ascii?Q?U/cRPIRg7h4brMLHtKIxZHprN4bdQQAUGTpmDOt2Og1PdL18vrxw7UV+B3m4?=
 =?us-ascii?Q?VllliX1KoaS4cW8X09JgBYBfR/IeK6GPK0z4fmbjZDUHZX6G78RHmNCvifh8?=
 =?us-ascii?Q?lPK1TDgNwrgreyAlkMF417DHnvG7EPcr5qzEYn0xRcqZ6Xn7UR9PDEAUly5u?=
 =?us-ascii?Q?wBpIsapdQ9LVEK3iNb4U7uOT+mw/um0DnStpswnuKzFO4PQT+En7noaE5VCX?=
 =?us-ascii?Q?JR/bJyCtwl4NN8Rquequf+DUwGa/fDgnE6AiSYvLlvYbRvJJJ02usPXVIhM1?=
 =?us-ascii?Q?p5L1CfcgW93zja04w+PC/SC3SvWgeIBV/fTg90y2RmkglO5w3sTZApFxqLbf?=
 =?us-ascii?Q?k97p05YQkX68oF945+Th1MfVgBKiufxDtjwlOIzRuphjIZi1DdHrF/3jHvtl?=
 =?us-ascii?Q?o7+flY1xc9K4qpFMJxPV46nasILBlsJOHawfx7V/SGJ8ccIeU8NSKJcPY2eU?=
 =?us-ascii?Q?EdXaIxUx/QYo/m2ud6zXtHyWxRtKhfXRLxWz5rsbQb4kKxfwIVVoo3qXwwa4?=
 =?us-ascii?Q?k1gNY++1EL86MKZGA206ClZwXi3YuW8bLRoy09fDlKEFEJEc+ApCFQPPmCj/?=
 =?us-ascii?Q?okSR8t/5i1wOcB8sbUcUKqdtYPeQJxzIKaaT2rTDBww+yGu2+fl5+a/4KbSO?=
 =?us-ascii?Q?mjUL5bBhSlPvPCngImL9WjGt8GYLEalgnJYUf96hGepXQZB7mQIlV7RrcqpR?=
 =?us-ascii?Q?oZuXLLNJei7nx0otfpxQVdWTvrAHpcK+Uyi37a4CBZ0WplGuUB85D0mBqGX9?=
 =?us-ascii?Q?cdwv8g6W5mLEKQBx3MiRhPuaZym1Wj9SrCN+a49h1a+MXosf/fAfGxuOjuhb?=
 =?us-ascii?Q?xSodlID9nscjgJkNnJ8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020dac42-79df-4e06-25b2-08dc7994ad1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 12:51:04.5747 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OBjRo3Kc+MRJr5vX+3kOynfsMobP3lGpC/tDJysFveKB1YCNdlgtYuSUdK0td0QMJKMwYaa8Ak5x+WtG+/onjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8489
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

> Subject: [PATCH] ARM: dts: imx8mm: Update iMX8MM Menlo board
> configuration
>=20
> Synchronize Toradex Verdin iMX8MM based MX8Menlo board configuration
> with Toradex Verdin iMX8MM and enable convenience commands like cat,
> hexdump, xxd.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Cc: Philippe Schenker <philippe.schenker@toradex.com>
> Cc: Martyn Welch <martyn.welch@collabora.com>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: u-boot@lists.denx.de
> ---
>  configs/imx8mm-mx8menlo_defconfig | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>=20
> diff --git a/configs/imx8mm-mx8menlo_defconfig b/configs/imx8mm-
> mx8menlo_defconfig
> index 1ed7f0a2259..2fbd25491f7 100644
> --- a/configs/imx8mm-mx8menlo_defconfig
> +++ b/configs/imx8mm-mx8menlo_defconfig
> @@ -22,15 +22,19 @@ CONFIG_SPL_STACK=3D0x920000  CONFIG_SPL=3Dy
> CONFIG_SYS_BOOTCOUNT_SINGLEWORD=3Dy
>  CONFIG_ENV_OFFSET_REDUND=3D0xFFFFDE00
> +CONFIG_IMX_BOOTAUX=3Dy
>  CONFIG_SYS_LOAD_ADDR=3D0x40480000
>  CONFIG_SYS_MEMTEST_START=3D0x40000000
>  CONFIG_SYS_MEMTEST_END=3D0x80000000
>  CONFIG_FIT=3Dy
>  CONFIG_FIT_EXTERNAL_OFFSET=3D0x3000
> +CONFIG_FIT_VERBOSE=3Dy
>  CONFIG_SPL_LOAD_FIT=3Dy
>  CONFIG_DISTRO_DEFAULTS=3Dy
> +CONFIG_BOOTDELAY=3D1
>  CONFIG_OF_SYSTEM_SETUP=3Dy
>  CONFIG_BOOTCOMMAND=3D"mmc partconf 0 distro_bootpart && load
> ${devtype} ${devnum}:${distro_bootpart} ${loadaddr} boot/fitImage &&
> source ${loadaddr}:bootscr-boot.cmd ; reset"
> +CONFIG_USE_PREBOOT=3Dy
>  CONFIG_DEFAULT_FDT_FILE=3D"imx8mm-mx8menlo.dtb"
>  CONFIG_SYS_CBSIZE=3D2048
>  CONFIG_SYS_PBSIZE=3D2081
> @@ -57,19 +61,26 @@ CONFIG_SYS_PROMPT=3D"Verdin iMX8MM # "
>  # CONFIG_BOOTM_NETBSD is not set
>  CONFIG_CMD_ASKENV=3Dy
>  # CONFIG_CMD_EXPORTENV is not set
> -# CONFIG_CMD_CRC32 is not set
> +CONFIG_CRC32_VERIFY=3Dy
> +CONFIG_CMD_MD5SUM=3Dy
> +CONFIG_MD5SUM_VERIFY=3Dy
>  CONFIG_CMD_MEMTEST=3Dy
>  CONFIG_CMD_CLK=3Dy
>  CONFIG_CMD_FUSE=3Dy
>  CONFIG_CMD_GPIO=3Dy
>  CONFIG_CMD_I2C=3Dy
>  CONFIG_CMD_MMC=3Dy
> +CONFIG_CMD_READ=3Dy
>  CONFIG_CMD_USB=3Dy
>  CONFIG_CMD_USB_SDP=3Dy
>  CONFIG_CMD_USB_MASS_STORAGE=3Dy
> +CONFIG_CMD_CAT=3Dy
> +CONFIG_CMD_XXD=3Dy
>  CONFIG_CMD_BOOTCOUNT=3Dy
>  CONFIG_CMD_CACHE=3Dy
> +CONFIG_CMD_TIME=3Dy
>  CONFIG_CMD_UUID=3Dy
> +CONFIG_CMD_PMIC=3Dy
>  CONFIG_CMD_REGULATOR=3Dy
>  CONFIG_CMD_BTRFS=3Dy
>  CONFIG_CMD_EXT4_WRITE=3Dy
> @@ -84,8 +95,9 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>  CONFIG_SYS_MMC_ENV_PART=3D1
>  CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=3Dy
>  CONFIG_USE_ETHPRIME=3Dy
> -CONFIG_ETHPRIME=3D"FEC"
> +CONFIG_ETHPRIME=3D"eth0"
>  CONFIG_VERSION_VARIABLE=3Dy
> +CONFIG_NET_RANDOM_ETHADDR=3Dy
>  CONFIG_IP_DEFRAG=3Dy
>  CONFIG_TFTP_BLOCKSIZE=3D4096
>  CONFIG_SPL_DM=3Dy
> @@ -96,16 +108,26 @@ CONFIG_CLK_COMPOSITE_CCF=3Dy
> CONFIG_SPL_CLK_IMX8MM=3Dy  CONFIG_CLK_IMX8MM=3Dy
> CONFIG_GPIO_HOG=3Dy
> +CONFIG_SPL_GPIO_HOG=3Dy
>  CONFIG_MXC_GPIO=3Dy
>  CONFIG_DM_I2C=3Dy
>  CONFIG_MISC=3Dy
>  CONFIG_I2C_EEPROM=3Dy
>  CONFIG_SUPPORT_EMMC_BOOT=3Dy
> +CONFIG_MMC_IO_VOLTAGE=3Dy
> +CONFIG_SPL_MMC_IO_VOLTAGE=3Dy
> +CONFIG_MMC_UHS_SUPPORT=3Dy
> +CONFIG_SPL_MMC_UHS_SUPPORT=3Dy
> +CONFIG_MMC_HS400_ES_SUPPORT=3Dy
> +CONFIG_MMC_HS400_SUPPORT=3Dy
> +CONFIG_SPL_MMC_HS400_SUPPORT=3Dy
>  CONFIG_FSL_USDHC=3Dy
>  CONFIG_PHYLIB=3Dy
>  CONFIG_PHY_ADDR_ENABLE=3Dy
>  CONFIG_PHY_MICREL=3Dy
>  CONFIG_PHY_MICREL_KSZ90X1=3Dy
> +CONFIG_PHY_FIXED=3Dy
> +CONFIG_DM_MDIO=3Dy
>  CONFIG_FEC_MXC=3Dy
>  CONFIG_MII=3Dy
>  CONFIG_SPL_PHY=3Dy
> @@ -128,6 +150,7 @@ CONFIG_SPL_SYSRESET=3Dy  CONFIG_SYSRESET_PSCI=3Dy
> CONFIG_SYSRESET_WATCHDOG=3Dy  CONFIG_DM_THERMAL=3Dy
> +CONFIG_IMX_TMU=3Dy
>  CONFIG_USB=3Dy
>  CONFIG_SPL_USB_HOST=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> @@ -143,3 +166,4 @@ CONFIG_SDP_LOADADDR=3D0x40400000
> CONFIG_USB_GADGET_DOWNLOAD=3Dy  CONFIG_SPL_USB_SDP_SUPPORT=3Dy
> CONFIG_IMX_WATCHDOG=3Dy
> +CONFIG_HEXDUMP=3Dy
> --
> 2.43.0

