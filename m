Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF220C77B7F
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 01:09:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D19F082B18;
	Wed, 25 Jun 2025 03:09:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="IsgY31OS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC73082C84; Wed, 25 Jun 2025 03:09:39 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96C9382977
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 03:09:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNcC9/sf9j5qKg/q9eEINd8XseVZ45Chi2/3cjnaMcwxLnT4zTEjOW0DFyyXd6GTYbhSnJE5LZXeKoEuFcPlJXOOfdt1iaZfV8BBxKnnx1xoGEOSfMe/2GfnuzmL3c3HXjpZJtAlSkQB3MOFyHYS3G9pkJCfCpPo+TZX4UV2A4j7i6b2H/t2WUwOfcRhFsJmcGwvsruVQKAQnuyawjXEvilOJ77z8gBG3llh0nkqObTj6Vbk7fNanpt6K486/Say+qQVaHi8lNjiApRZkEk+dKueKngRQFi+nUQJ4tsety04E2g2nWuWDG1qwPgaw9X9ypbGNZZS0R7/LRhB3jXUsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWpO9qsUDxfKE7nVhUzgpGlb1mFPNpS9tAlIa3obCxI=;
 b=bd+gRBc7iqmHT1mNUUzWUcjrqGeaNwMRH859JZvg4evoQ1AvnRpEwDf7aLempXgpcXiWOSkGBW4wx1P5VMfrk/Jfem6atSPtC32fHORuLo2f35swHFQ5DS0fuvReEY7T+XbUPdfCW/prDyZvF5UvN+7ZyRR8mG8AGLiDbDi7kxUD3he45LlNf4f3CBCthO2a4pWlFLRiky+8tnZEnpfIrlCsBBEQVGFbBPu3feDxpI6VmygHGEBrB7dALLxo6Z4As3DKeSqC4/+UkEczaN18U8xXU1PsroAgRynHdqUgGKdTrjBqaJyAnX+6kENaCApIe2RScG9+UwLCm75nZbY2LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWpO9qsUDxfKE7nVhUzgpGlb1mFPNpS9tAlIa3obCxI=;
 b=IsgY31OSIPYf+Lr9oOob/WMh3MhUdWfliC5baYO12jQC9hIikVaTITXAiEId+beV7qztNkYdRgIekxfW/7UjvKSg7+WNsSLuIjm0WUdlqiNRVJngPv3D2Xd0hIX8g1S6BfmGuJgo+Dxx2R91ztdGmR1RwDzrS6FZXAmRmow5H9cEN1DrZEaJg78DB4G7ZcNuxw8O4l+7ceO1zTqzIAEXnhjS1YFU1LFo1p3o26yxIRama4vOkrbJQMKqPvHLXn7zOPesoxsDeMb1JG43ETmHovXK7/ES6R++TkXbYQAQBtMeCbEgON9VjjKT4+RIXo+BOnYdjd5RL0zcFhRUEomAmg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8222.eurprd04.prod.outlook.com (2603:10a6:102:1bd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Wed, 25 Jun
 2025 01:09:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 01:09:35 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Lukasz Majewski <lukma@denx.de>, Fabio Estevam <festevam@gmail.com>
CC: Stefano Babic <sbabic@nabladev.com>, dl-uboot-imx <uboot-imx@nxp.com>, Tom
 Rini <trini@konsulko.com>, "albert.aribaud@3adev.fr"
 <albert.aribaud@3adev.fr>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH 1/2] config: nxp: bk4: Increase size of
 CONFIG_SYS_MALLOC_F_LEN (to 0x1000)
Thread-Topic: [PATCH 1/2] config: nxp: bk4: Increase size of
 CONFIG_SYS_MALLOC_F_LEN (to 0x1000)
Thread-Index: AQHb5UkxyMEsFcxQLk+hbrh/S3v1M7QTEPBA
Date: Wed, 25 Jun 2025 01:09:35 +0000
Message-ID: <PAXPR04MB8459D6C5DE9FAACA02309699887BA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250624204700.972663-1-lukma@denx.de>
In-Reply-To: <20250624204700.972663-1-lukma@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB8222:EE_
x-ms-office365-filtering-correlation-id: cf73a45c-b617-4343-8b79-08ddb384f334
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ciF8MnYn+j+GeNFZrPtAiCO/HNBoKqPweCPugLngRcQjcP9aTbkbAtGRMVhk?=
 =?us-ascii?Q?49jUkoxlkOOF9MqrbieNnpY6t9QIG+IkXFnDqhIhMTZDuFf09UQQKz1WZYB9?=
 =?us-ascii?Q?jCRGkZyoqufiHGF+IczodUBpcsmfoggyKC60Nb3kIX5f/VcQf9yeeHt6+QuS?=
 =?us-ascii?Q?uQ38Ul1WuPWhKlGmGwbIBvNdQR7+insm32fws73kb6Lf4p9e67MpBZZ0Afds?=
 =?us-ascii?Q?TMG+5Aqupz/a1BcgAFhMzyR6GJ9/dqm3mNvFakdZgPjNdmGLmvTwWsWFz0tt?=
 =?us-ascii?Q?NPn4UJ+K7xfaJdkto2qWvEP/BT0CkShmGnC97ekAnymGg5DDK1nyf8efbVQC?=
 =?us-ascii?Q?Pq4SpCKj1b/h3UY9D/UoVNiQaWxto6qM1Z8XSJB4kntD68tm/FrTU1OBR799?=
 =?us-ascii?Q?nM6P8sfu/dh6OlOAWfF+tkgjkIR3FgHGIonfUOuwLbgBgfasDcsGINYrh1No?=
 =?us-ascii?Q?aMGB/nm+jGvnc2Z4i4YWX0eZu28fBQo31KSqHjCIkbdR9wHcatQ07+rHIflA?=
 =?us-ascii?Q?6LxF9/J2MnaSq17gND0vSFjDLyEITTM0WOypkgdCvvO2QvCpLESmGlYqwFQ7?=
 =?us-ascii?Q?a1FKoVJWc0O45f89Ww3JrPXT/398YKY+uNsWFRkvdeyW878BVeI1lz6Q6rwS?=
 =?us-ascii?Q?CPUKcCb7AHDSyQopBMQQm0D5G6HJxsBXCzfFKbmXlPzute9RXU4Q0E5hE9GH?=
 =?us-ascii?Q?N033X5eGy6+jqGc6yNbyPHcKwISmouBMP3NyuRIagb7eQJgBU4izXarJaeFX?=
 =?us-ascii?Q?DweMr0ZO7TBZKtv1ow4FMXLf8ZGRPPsLjbts6pn5OmUg8heMG3MACPDou5jE?=
 =?us-ascii?Q?KZWxg+9rYquO55pujdI8TeT8kcjCEh67PX42+go1rRazy+9e/Ulw20QeadG3?=
 =?us-ascii?Q?ayVWDye64sK58faRtm7c6dB1BTngoZlXZqqQq6QdksmE2PABuvfPWNcGAFfJ?=
 =?us-ascii?Q?yQzvICNAmfS/EKAIvUNZq/jUOMmEgVMw/LM8BsJArTpIL7p+nxWIcLgarNCT?=
 =?us-ascii?Q?9Ybv2EGbbhkqOjVrSXJWVNni0dJ6/+HmGYZbRiQFJlrc2BTbXjVOmAi88eZt?=
 =?us-ascii?Q?HABw8FyNlujJEiSU2Db2wibbkPyPkOASv9uS5lTONYcXqYhfUFhSPQgnunJw?=
 =?us-ascii?Q?rulzEREJODQPNA5SZ87p4CBQtbwwHqIKLz2v/3aAIbXUAwR43aHKUr4XyyfQ?=
 =?us-ascii?Q?RUVaM8cKlon7VHXnXm4HwFvx/6RVrc3Apr2yT4AWDmDzDrD4/2C0NmE0A8/w?=
 =?us-ascii?Q?+A5hB+8eeh9cOjTKbEqjSUEvegx50NFGaL3aQ+aekcnnT8z9blWulX7S6pWC?=
 =?us-ascii?Q?JDoqvdg1wDeHg95zXcNpIgmcQeeruZY/SuJZ9V7E1269DvbNXwYvovzjOlJu?=
 =?us-ascii?Q?J3lKsCYCK9TSkz4PgLf3cWu8LMI4VNwNgW3KefLTPx/egtpOiS7amkD5FXOs?=
 =?us-ascii?Q?puGADD6m6PSCBopuJgwn9tcgTZ4QkZUKOBGfxK99YWhFM/YyLNTIjeo8dksQ?=
 =?us-ascii?Q?t5k/ct9GLLXHA5U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m2veAhhK8x9xG2L6Wl9qLh8cR91JvOH+dnJM6pg1mlvBwPIS6OW2keX/U+md?=
 =?us-ascii?Q?H5Ukkz2OcVLSM+QOFoG5eA3XBv5C+3a7fKLJmCWRwk0noX42bhS/R+hz8xF1?=
 =?us-ascii?Q?Jwj6DHdAGIgUID0kgVOXFvnrfYilKfJ3i0fUhxGbzbCLDPOORUGem+Nb7Tf7?=
 =?us-ascii?Q?UT6TWKznO6ZIjWvrwp7HGzbJ0PUKGb3sTICWAR4p25vqP1urCAaLTno6EELK?=
 =?us-ascii?Q?dkJLFdVwHp19qaOeislrtggAPA9iySXahevPRIRAf8aMvnIBW+tvxT5y9EZU?=
 =?us-ascii?Q?b/aMhsPlkeqeTvJgwz4tzvAOpIQNimOqJ3c8tVVxlden7zbcV+rUHj9E7ICw?=
 =?us-ascii?Q?LS4tBXw3gr3rQyS+zNrzq8hEBTpdUb8HprSFID0nZ4HuakdcnCdQ0PWZg5u0?=
 =?us-ascii?Q?di9eDkKVh2WxTLIc0EnRw8+U1SlCnAQMvLJbeUd46focAJC8Qm74i7ruPQr6?=
 =?us-ascii?Q?T0dHcd/n2rnbvVeG1919UULuFtxzeDX5wg32/DDmBgoYc4bmZInKxzz3XH9k?=
 =?us-ascii?Q?unt9bN55HaLjVrVoVxw63/B9EswJsok5kdbNtElJ6kZzTEIRBV3Ks719xqOh?=
 =?us-ascii?Q?G9jfPRl6QnkVS8+sb7ZMJU7DF9mwmIKbuNbrAlib4e/ZwR+76/sY+0wpSSEq?=
 =?us-ascii?Q?heGemUzoNHxa2mA2g8TFz1ZLjVz9joKWQrp4Rba3ZQ2lrJ0xAqIdbJa9oubK?=
 =?us-ascii?Q?9wzmQrqPyxERfmJAtRTZSR+IrrWfNaBS09V9S6VqpztY13JYx/Pf8Uoj8wad?=
 =?us-ascii?Q?eiNthFmtdpEgPuHABs6hKT9TXhmbWhgdML1WDPCmbnBRcqHrd7ReJp5ZfHBc?=
 =?us-ascii?Q?gyiLxFxXM48+ALtlkCpzLm7Gx0W/Jq0dwq/dLlaExoLGW5oTwh3LfDP3m9Sk?=
 =?us-ascii?Q?Pt6vNmeu4YlKUNZopwNAzJ6+jY1QZOscVoqQuicGnsH6SFmAE73KUdfu49Az?=
 =?us-ascii?Q?t5ODktH46rJTfMXz4lA2C+HzEMJBOKIDTWjEGT2FiNld7TtRv8Oqf5hGZbZN?=
 =?us-ascii?Q?Y1lsfHGSXm1tLYfMNUf4/lfv7VjuRMxzqDSYPCUt4ow1/M0l1iY1P3mS1s76?=
 =?us-ascii?Q?fKaaXnu7EBc/yA2tRAvaQWfdwt+NsgOf91S+JRcVZ2+8z0shTdq/SYZsGQgN?=
 =?us-ascii?Q?WtK0rUsI0Lp2yAmuq6mpqdzuXZdH8tNbzNTUUXmlU7RityvcRxVC+CB5rtwp?=
 =?us-ascii?Q?0eTe+fMfaFTi2A/r2PpJ4tRIzmM+MuBrK6qGd6kBCO2X8Cogr1VcDr1Q9IS2?=
 =?us-ascii?Q?pifYzDk5sQo1mahbaEkWC9pifR+ACL1JxiXNe8qXSD72yMFGdqstgx9tnbDi?=
 =?us-ascii?Q?FBb15bAQgukERFFUzL5tSRy8yAl1CevJL5qU/zP9bhIcpxfpmZMqW5zCNfQd?=
 =?us-ascii?Q?m5q4kwv5wkrTOJ1sntiSekCentQKnr1rgwZA6qDDrY7fpuW4iafsqhMlMBST?=
 =?us-ascii?Q?qh/MLP3ufDxiB8Ra/FemeBfYV9WF37bAqk7/r18pyU9WqjV4EibbgUHmsNGA?=
 =?us-ascii?Q?eEkewUg0i7AyOGnaOdZhAPjE3ZJrZ14vu47kc3KwSCsPhmlrtIVDW0ELqsIy?=
 =?us-ascii?Q?t4bAD5UhjtA+gu9IIeY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf73a45c-b617-4343-8b79-08ddb384f334
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 01:09:35.3593 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 069a3pyfTmStv6mmZEbdEed2C6RWyQW3ycljaD6bvezYdQgYqZwNNfUjcfkydUjQjbwBJWxryFGT1j7Oguvj4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8222
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

> Subject: [PATCH 1/2] config: nxp: bk4: Increase size of
> CONFIG_SYS_MALLOC_F_LEN (to 0x1000)
>=20
> The commit c69103218ee4 ("i2c: mxc_i2c: add DM_FLAG_PRE_RELOC
> flag") has enabled by default the i2c initialization in the pre-relocatio=
n
> phase.
> It turned out that vf610 based BK4 board had too small
> SYS_MALLOC_F_LEN pool size.
>=20
> After increasing it to 0x1000 the board boots again.
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  configs/bk4r1_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configs/bk4r1_defconfig b/configs/bk4r1_defconfig index
> 3ed587a1060..8bff1653859 100644
> --- a/configs/bk4r1_defconfig
> +++ b/configs/bk4r1_defconfig
> @@ -4,7 +4,7 @@ CONFIG_SYS_THUMB_BUILD=3Dy
> CONFIG_ARCH_VF610=3Dy
>  CONFIG_TEXT_BASE=3D0x3f401000
>  CONFIG_SYS_MALLOC_LEN=3D0x402000
> -CONFIG_SYS_MALLOC_F_LEN=3D0x800
> +CONFIG_SYS_MALLOC_F_LEN=3D0x1000
>  CONFIG_NR_DRAM_BANKS=3D1
>  CONFIG_ENV_SIZE=3D0x2000
>  CONFIG_ENV_OFFSET=3D0x200000
> --

Acked-by: Peng Fan <peng.fan@nxp.com>
