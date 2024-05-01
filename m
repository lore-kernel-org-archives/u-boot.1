Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D45C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 11:26:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6D0988A69;
	Wed,  1 May 2024 13:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="WLrpe+ua";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFD8D88AB5; Wed,  1 May 2024 13:26:09 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C4DE88A56
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 13:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIxKJYjkUkv/ppm0WwDxf+nn1a97FmBHD473b4kxNfhRiE3Oqee3Fi5jOnOmkNRVcTTPreG0kDXCK2poO/T5z0H89s4IqFHL7/laZzCqk5XPdSAz8qZp0QrNw9x04Ze2SHQj2RpKamXJx0nRzgp8C6nqiYaqIzjw/hRBc99Dj8jQhM4xXLOwjqZUEI2BriJj6bRTU4A08fpsN0K0CW+YLf3G0i50hHln/AKfLWv9bzDlcRGAd9v36Hy8HnQQhRfosfYN771dur2H9lDuTaq1KGrS0lVvCAuFxW4//fLTHKQysdx87fIwqO3bPfRH1Nq6wUj0QQ5fyyt7Xrc3gOvbUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Agl4u6USNu+vQIQur6AGEV/FcrJgLIlvDYvuoOlrg/I=;
 b=SyN0J6FvCoXm+hAosPadFc5lFpLRZ+elQe92Ppk6bl6rHgxrayiwX8kgepbVxg8/+vNvvZuVmdofHN1o+okQ1HtAVFNGz079bjMVEgxJ9WsWdrsl8zaVzU2cIcqE7y7ufodwDwwjmsb5Z/2oQdEtnSL2UvgdViLCZmdlqdAvSoyCkX2Y3mi0PDbGxp1hYasH2wZLds6Up0HnFW9ID9P2WnpG8WcV4Czh5fjp97oePj+mFCIXJYGOPd9YE1HdGwC0UEzSev/UMXUd95p07he+m6/EG78VqtZJOxKEWivvCiQZeK7yfBiL8BjWaQprj+lE/pEdwZKQbxjUwK0zoo2Ydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Agl4u6USNu+vQIQur6AGEV/FcrJgLIlvDYvuoOlrg/I=;
 b=WLrpe+uagrgQtjm4VnbDYWDgjOlKljzgx2AtAHJTZXEuDNZpfYvHTQr8beuPc0Ebs66EHmRkDITGBsPn/4S4uEA+ynQeKYgC+tmxU60rTJr5IJ+s37mL5yiI+yWrp/VcRZjHTkKACYdoeeu8/X9HLQJ9txbPMG/P6xD3bhL65N4=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9629.eurprd04.prod.outlook.com (2603:10a6:20b:474::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 11:26:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 11:26:02 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Giulio Benetti
 <giulio.benetti@benettiengineering.com>, Jesse Taube
 <Mr.Bossman075@gmail.com>, Pramod Kumar <pramod.kumar_1@nxp.com>, Alison Wang
 <alison.wang@nxp.com>, Andy Tang <andy.tang@nxp.com>, Mingkai Hu
 <mingkai.hu@nxp.com>, Ashish Kumar <Ashish.Kumar@nxp.com>, Priyanka Jain
 <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>, Meenakshi Aggarwal
 <meenakshi.aggarwal@nxp.com>, Angelo Dureghello <angelo@kernel-space.org>,
 Tsi-Chung Liew <tsi-chung.liew@nxp.com>, Sinan Akman <sinan@writeme.com>,
 Otavio Salvador <otavio@ossystems.com.br>, Jason Liu <jason.hui.liu@nxp.com>, 
 Eric Nelson <eric@nelint.com>, Adrian Alonso <adrian.alonso@nxp.com>, Qiang
 Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <shengzhou.liu@nxp.com>
Subject: RE: [PATCH 061/149] board: freescale: Remove <common.h> and add
 needed includes
Thread-Topic: [PATCH 061/149] board: freescale: Remove <common.h> and add
 needed includes
Thread-Index: AQHam3GAQILQOpi0LUaE/UZuH6jVvbGCPbBQ
Date: Wed, 1 May 2024 11:26:02 +0000
Message-ID: <DU0PR04MB941750E5A570EF42AC8A1CDD88192@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-61-trini@konsulko.com>
In-Reply-To: <20240501024316.1767971-61-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS1PR04MB9629:EE_
x-ms-office365-filtering-correlation-id: 34a2b286-c319-478a-9857-08dc69d17b94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|7416005|366007|376005|1800799015|38070700009; 
x-microsoft-antispam-message-info: =?us-ascii?Q?VX9g6dSuTzTqBP2xbiZSq3wB1OxpSKByw2RRuM/aFnBu3gir6NaN86XHgHSq?=
 =?us-ascii?Q?/Y6TgKn3cqRczsuosztJuNdaQ393k9AJXKaVutf9Au2WOQrNhKFEg3bFwnCH?=
 =?us-ascii?Q?WyFNWguEVopjMow835ET92pn9s1Sy3qCnZ9cuhy9BtDe+houRKIciSUrXMry?=
 =?us-ascii?Q?iXMVxhrdIgqxo8qblHJAzNJCGAeQpV9zYVsTxWMvKd9N4Ja5Jzb76B35Mm2h?=
 =?us-ascii?Q?T+wBZe8RbxwjZwSCYSJAUou/bHs2qDuGTWl6awNFBnzflsbAc2w4tpsL+7lV?=
 =?us-ascii?Q?rr2EQjddORnhDeYGxXzwcRoMTbFPl8MdFtKsRyDqA/CTbyuJF0UN54ZRbteD?=
 =?us-ascii?Q?XWiQ87dF1D5CaoAx6WwTkM5hcbhOUzcAZg1+N04Sg5B3RouDK2UhZiK9j26q?=
 =?us-ascii?Q?n/lkI0nsgGBfVdpVb4+zJSvgyUGlqIhm0ojID9QPRVtJPDqY9K3kTq5s7j9s?=
 =?us-ascii?Q?lDZdyK23UNrhrjZt/zMnUdrGXE+fCYU0kGPBF0PurhvGIVQdCsUmSAqfFMd9?=
 =?us-ascii?Q?tUAen74kXf/PaqlyEhNlRQ7R5x2pK11XdrBtr8Ob9YnNmvSvpNc7b154dZzW?=
 =?us-ascii?Q?ijgF6eLkTDEGPAuzW9rArrts8YvHuU0sEabGggFw1x8u+v9znfq1W+opTjrQ?=
 =?us-ascii?Q?P/fbDdo7vsyhDuqWweGyHJvyKqqPo/Dz5+r6bStyZLfgPmEkULaRshvccSIh?=
 =?us-ascii?Q?MbGvhMN23M0k1Rncn5z4jy4ITdKZCJ7IwdYe2zu7L/azb0zzDW1TeJDKxMMy?=
 =?us-ascii?Q?GFG6phygYyqXC+1qCTPOG1x69cP52CyES1C4QznH1eHz/M5ny1EDY353lseo?=
 =?us-ascii?Q?yAlfXYErdUnHkLnsC1pYL3ilydQoHfHWgSx4UKVJmvsunvSoypbYhNWYXHt9?=
 =?us-ascii?Q?ZuSGCBR2K4pqQEjGiyKKxKsqlD+wT6C80HFI9Q6iHmfQgyGFdJ+RYWBMovT5?=
 =?us-ascii?Q?yAEC648nYaPb2nJbr/V0lYG2DsMg0YYEsyot+7zXBBP6Bq5XmWKFgmN3eRPY?=
 =?us-ascii?Q?qmmMlDZyT5V5BkaMLZH7bX88FHfuhyS0/c6fj6EVEj6E9KlaX+0eeWp+BKNj?=
 =?us-ascii?Q?7UV4ATHXAu2n9ICXbtArKmVfptnWBJ2UXNHBHbUer9eg6Jwn7aiRAOHfdkNL?=
 =?us-ascii?Q?LukZmFCgc4+jZ0rxTRRTdecmEJ7AB8qsJ8Ik9GsUStN/F2APpsUJyNNCNa7Z?=
 =?us-ascii?Q?1GVbIxgaQJvbm0tagQnOevWnI7MraMfMBhyCgiFQczt1YYbPoXWerXgrT/nJ?=
 =?us-ascii?Q?JZiPrwBu/lbBL1DUXc8SZD+MsZryNUPelcSTVxLKcrVBDJqekJaXVR5LxKGD?=
 =?us-ascii?Q?BArFViRlUqkceRLAbn0oZPWai7jqKNKKdb7Bshk2i+nH6Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(366007)(376005)(1800799015)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0o5SZW+Pz/HeBWY+rstyu3ONBGvhOQGP8Te0tJxjcLBgZ2tUFlTm0qfFdZCk?=
 =?us-ascii?Q?VreTxnNLKkwxUYJhtHT4NByj7dqLhGyMiBTDqNjIcj/TyNHF4E6ywdY1gLKW?=
 =?us-ascii?Q?ie6SrbJR2KWsxPi6YzgryBAjhwqAlUHEvhnulHRPF4IeYRCWDmj9Ab9tW07f?=
 =?us-ascii?Q?8LjRsP3yr1GNcHXHcD/Yq3Vvb8ay5jZTIivvFtLoK0FqGqf/wPOuQvcRhV1R?=
 =?us-ascii?Q?adHYKVCpQRSEEUZKocx2kSMsekKbWayVrC1UfVeygT5ijtsWyEeb4dwBEC4b?=
 =?us-ascii?Q?s0duge3zxOYLa6N7TlWXBdOGxJTgvyTtHLjM0px0Qf55RARB0q4kCZibWy1k?=
 =?us-ascii?Q?cNDeV9lsNvG3GZTcO3iu1nCDuN3tWeTQ7G2Rp9bxp7SyFaN4MDPGkEanHS8m?=
 =?us-ascii?Q?GhOG8KThZ6A0wRNEQ52aUEn6EIAZbFNk6Q/v8O/K416Pwlgq2OIQUEhVWZdd?=
 =?us-ascii?Q?fWO04/Pql2STk7A278QLkZgx0Cb5zqfoiRVTZLIOZXUYKfXnBOVjAlC6l3Tp?=
 =?us-ascii?Q?LmfPfR1IjWpaLcAA5hb8hpVcBRt+ydObZbAgcEL/aMxyOYK7wLyXwG9Olrum?=
 =?us-ascii?Q?swVS4zpDKPpxJ9GLAHIFkgPrxYHu6cjSotaPyF4wb65QiFzkSbM1H3UtOaY5?=
 =?us-ascii?Q?EEAEt71k9kFHGamZnuaC3GBWg2fklSKtyYvU8sq7XWsTPk7uaTb16OnKNEcU?=
 =?us-ascii?Q?3fsklCZsn4w+UIhFY6L4m4crH1cHPz7PMWv4/jic9suERudra9/Y+Jz9SgqK?=
 =?us-ascii?Q?SCCdcAV2FRPgBPJVbl23uiFZtyeaeCt87sKpS/IWvWaJ4NAGNmtAMRkdRwSg?=
 =?us-ascii?Q?hcZuT87fe2EOHdSNF30ek//9QoepTyykHFpDOBjcAitvfFy8kTs8d1CJ/bR/?=
 =?us-ascii?Q?IOn+1/B0rrf73+PiiKO0R44wJs5rIk2c0iElaRdRxpTp9u3qHQNejJqVvTDh?=
 =?us-ascii?Q?DS/K2NoU4Xn9MX2dU+oUPAX4F5zzRfEMaAsr2tADlWxGNedZz0B/dkI56icX?=
 =?us-ascii?Q?UthfrOOsUr0BKX+wlShij0YAQb7tOZlL48iB2HZu0+yvX/vo/vYkbO3hukwF?=
 =?us-ascii?Q?Kt9UbddoSw+6raSmest+11eoRTaHe6iJXqV/NZiO9j2hUT1CVo8UZGoyaOK1?=
 =?us-ascii?Q?dBiIZNfZhs8ytbxbGBGTlw+2DDfYvhDH2r7q6y1RzwB1UgsdmluVVCzUfcKU?=
 =?us-ascii?Q?Q450MJhMWbj0swsItEB2kzuNMU+YJGjotEsxBL19R1bJxm7+lVQOJKbQSmjB?=
 =?us-ascii?Q?NBB++NA5cn9qdvP2CWSwvEP1XdcLn0WMEbahCXC5emEPQtHWczBhw04aoL2H?=
 =?us-ascii?Q?TdngnWv78/awFkIQboOItPmhssvplFmlIqtcoZytQzsfjFTJuFfmpK6b9zvK?=
 =?us-ascii?Q?yiutzuNRuWwhdbNu7mvwshuoKi+Uw/TwFlvamU2F29RXmHnAjlawp9J7V4Qz?=
 =?us-ascii?Q?91WaLEytcynFFcq3cD1pO4QA4Xw5F7qMWs3qoF3aRnws/q9KfGS7mOKUFjZr?=
 =?us-ascii?Q?X1eIR3RqJR4tMFSuTBTLHnAr2jxSO0RqWxIclZ1q/KmOyyUTE95gDTTN/FRq?=
 =?us-ascii?Q?esSzuTxC8Dqho1xaUVU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a2b286-c319-478a-9857-08dc69d17b94
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2024 11:26:02.2080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4kdNY/Ve/BVoCm4fKSNiW0PhkM8sp4igFIMWmRnwDVJo+ziWfUui21f9LVXTAOd6IetzdVbhn03qY83eqpIuIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9629
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

> Subject: [PATCH 061/149] board: freescale: Remove <common.h> and add
> needed includes
>=20
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
> ---
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Cc: Jesse Taube <Mr.Bossman075@gmail.com>
> Cc: Pramod Kumar <pramod.kumar_1@nxp.com>
> Cc: Alison Wang <alison.wang@nxp.com>
> Cc: Tang Yuantian <andy.tang@nxp.com>
> Cc: Mingkai Hu <mingkai.hu@nxp.com>
> Cc: Ashish Kumar <Ashish.Kumar@nxp.com>
> Cc: Priyanka Jain <priyanka.jain@nxp.com>
> Cc: Wasim Khan <wasim.khan@nxp.com>
> Cc: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Cc: Angelo Dureghello <angelo@kernel-space.org>
> Cc: TsiChung Liew <Tsi-Chung.Liew@nxp.com>
> Cc: Sinan Akman <sinan@writeme.com>
> Cc: Otavio Salvador <otavio@ossystems.com.br>
> Cc: Jason Liu <jason.hui.liu@nxp.com>
> Cc: Eric Nelson <eric@nelint.com>
> Cc: Adrian Alonso <adrian.alonso@nxp.com>
> Cc: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: Shengzhou Liu <Shengzhou.Liu@nxp.com>
> ---
>  arch/arm/include/asm/arch-imx8m/ddr.h             | 2 +-
>  arch/arm/include/asm/mach-imx/gpio.h              | 2 ++
>  board/freescale/common/cadmus.c                   | 3 ++-
>  board/freescale/common/cds_pci_ft.c               | 1 -
>  board/freescale/common/cds_via.c                  | 1 -
>  board/freescale/common/cmd_esbc_validate.c        | 2 +-
>  board/freescale/common/emc2305.c                  | 1 -
>  board/freescale/common/fman.c                     | 1 -
>  board/freescale/common/fsl_chain_of_trust.c       | 2 +-
>  board/freescale/common/fsl_validate.c             | 2 +-
>  board/freescale/common/i2c_common.c               | 2 +-
>  board/freescale/common/i2c_mux.c                  | 3 ++-
>  board/freescale/common/ics307_clk.c               | 2 +-
>  board/freescale/common/ls102xa_stream_id.c        | 2 +-
>  board/freescale/common/mc34vr500.c                | 1 -
>  board/freescale/common/mmc.c                      | 2 +-
>  board/freescale/common/ngpixis.c                  | 1 -
>  board/freescale/common/ns_access.c                | 2 +-
>  board/freescale/common/p_corenet/law.c            | 2 +-
>  board/freescale/common/p_corenet/tlb.c            | 3 ++-
>  board/freescale/common/pfuze.c                    | 1 -
>  board/freescale/common/qixis.c                    | 2 +-
>  board/freescale/common/sdhc_boot.c                | 1 -
>  board/freescale/common/sys_eeprom.c               | 1 -
>  board/freescale/common/vid.c                      | 3 ++-
>  board/freescale/imx8mm_evk/imx8mm_evk.c           | 1 -
>  board/freescale/imx8mm_evk/spl.c                  | 1 -
>  board/freescale/imx8mn_evk/imx8mn_evk.c           | 1 -
>  board/freescale/imx8mn_evk/spl.c                  | 1 -
>  board/freescale/imx8mp_evk/spl.c                  | 1 -
>  board/freescale/imx8mq_evk/imx8mq_evk.c           | 1 -
>  board/freescale/imx8mq_evk/lpddr4_timing.c        | 1 -
>  board/freescale/imx8mq_evk/lpddr4_timing_b0.c     | 1 -
>  board/freescale/imx8mq_evk/spl.c                  | 2 +-
>  board/freescale/imx8qm_mek/imx8qm_mek.c           | 1 -
>  board/freescale/imx8qm_mek/spl.c                  | 1 -
>  board/freescale/imx8qxp_mek/imx8qxp_mek.c         | 1 -
>  board/freescale/imx8qxp_mek/spl.c                 | 1 -
>  board/freescale/imx8ulp_evk/imx8ulp_evk.c         | 1 -
>  board/freescale/imx8ulp_evk/spl.c                 | 1 -
>  board/freescale/imx93_evk/imx93_evk.c             | 1 -
>  board/freescale/imx93_evk/spl.c                   | 1 -
>  board/freescale/imxrt1020-evk/imxrt1020-evk.c     | 1 -
>  board/freescale/imxrt1050-evk/imxrt1050-evk.c     | 1 -
>  board/freescale/imxrt1170-evk/imxrt1170-evk.c     | 1 -
>  board/freescale/ls1012afrdm/eth.c                 | 1 -
>  board/freescale/ls1012afrdm/ls1012afrdm.c         | 2 +-
>  board/freescale/ls1012aqds/eth.c                  | 2 +-
>  board/freescale/ls1012aqds/ls1012aqds.c           | 2 +-
>  board/freescale/ls1012ardb/eth.c                  | 2 +-
>  board/freescale/ls1012ardb/ls1012ardb.c           | 2 +-
>  board/freescale/ls1021aiot/ls1021aiot.c           | 2 +-
>  board/freescale/ls1021aqds/ddr.c                  | 2 +-
>  board/freescale/ls1028a/ddr.c                     | 1 -
>  board/freescale/ls1028a/ls1028a.c                 | 2 +-
>  board/freescale/ls1043aqds/ddr.c                  | 1 -
>  board/freescale/ls1043aqds/eth.c                  | 2 +-
>  board/freescale/ls1043aqds/ls1043aqds.c           | 2 +-
>  board/freescale/ls1043ardb/cpld.c                 | 2 +-
>  board/freescale/ls1043ardb/ddr.c                  | 1 -
>  board/freescale/ls1043ardb/eth.c                  | 2 +-
>  board/freescale/ls1046afrwy/ddr.c                 | 1 -
>  board/freescale/ls1046afrwy/eth.c                 | 2 +-
>  board/freescale/ls1046afrwy/ls1046afrwy.c         | 2 +-
>  board/freescale/ls1046aqds/ddr.c                  | 1 -
>  board/freescale/ls1046aqds/eth.c                  | 2 +-
>  board/freescale/ls1046aqds/ls1046aqds.c           | 2 +-
>  board/freescale/ls1046ardb/cpld.c                 | 2 +-
>  board/freescale/ls1046ardb/ddr.c                  | 1 -
>  board/freescale/ls1046ardb/eth.c                  | 2 +-
>  board/freescale/ls1046ardb/ls1046ardb.c           | 2 +-
>  board/freescale/ls1088a/ddr.c                     | 1 -
>  board/freescale/ls1088a/ls1088a.c                 | 2 +-
>  board/freescale/ls2080aqds/ddr.c                  | 1 -
>  board/freescale/ls2080aqds/ls2080aqds.c           | 2 +-
>  board/freescale/ls2080ardb/ddr.c                  | 1 -
>  board/freescale/ls2080ardb/ls2080ardb.c           | 2 +-
>  board/freescale/lx2160a/ddr.c                     | 1 -
>  board/freescale/lx2160a/eth_lx2160ardb.c          | 1 -
>  board/freescale/lx2160a/lx2160a.c                 | 2 +-
>  board/freescale/m5208evbe/m5208evbe.c             | 1 -
>  board/freescale/m5235evb/m5235evb.c               | 1 -
>  board/freescale/m5249evb/m5249evb.c               | 2 +-
>  board/freescale/m5253demo/flash.c                 | 3 ++-
>  board/freescale/m5253demo/m5253demo.c             | 2 +-
>  board/freescale/m5272c3/m5272c3.c                 | 2 +-
>  board/freescale/m5275evb/m5275evb.c               | 2 +-
>  board/freescale/m5282evb/m5282evb.c               | 2 +-
>  board/freescale/m53017evb/m53017evb.c             | 1 -
>  board/freescale/m5329evb/m5329evb.c               | 1 -
>  board/freescale/m5329evb/nand.c                   | 1 -
>  board/freescale/m5373evb/m5373evb.c               | 1 -
>  board/freescale/m5373evb/nand.c                   | 1 -
>  board/freescale/mpc837xerdb/mpc837xerdb.c         | 2 +-
>  board/freescale/mpc8548cds/ddr.c                  | 1 -
>  board/freescale/mpc8548cds/law.c                  | 2 +-
>  board/freescale/mpc8548cds/mpc8548cds.c           | 2 +-
>  board/freescale/mpc8548cds/tlb.c                  | 3 ++-
>  board/freescale/mx23evk/mx23evk.c                 | 1 -
>  board/freescale/mx23evk/spl_boot.c                | 1 -
>  board/freescale/mx28evk/iomux.c                   | 1 -
>  board/freescale/mx28evk/mx28evk.c                 | 1 -
>  board/freescale/mx51evk/mx51evk.c                 | 2 +-
>  board/freescale/mx53loco/mx53loco.c               | 2 +-
>  board/freescale/mx6memcal/mx6memcal.c             | 1 -
>  board/freescale/mx6memcal/spl.c                   | 1 -
>  board/freescale/mx6sabreauto/mx6sabreauto.c       | 1 -
>  board/freescale/mx6slevk/mx6slevk.c               | 1 -
>  board/freescale/mx6sllevk/mx6sllevk.c             | 1 -
>  board/freescale/mx6sxsabreauto/mx6sxsabreauto.c   | 2 +-
>  board/freescale/mx6sxsabresd/mx6sxsabresd.c       | 1 -
>  board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c | 2 +-
>  board/freescale/mx6ullevk/mx6ullevk.c             | 2 +-
>  board/freescale/mx7dsabresd/mx7dsabresd.c         | 1 -
>  board/freescale/mx7ulp_evk/mx7ulp_evk.c           | 1 -
>  board/freescale/p1010rdb/ddr.c                    | 1 -
>  board/freescale/p1010rdb/law.c                    | 2 +-
>  board/freescale/p1010rdb/p1010rdb.c               | 2 +-
>  board/freescale/p1010rdb/spl.c                    | 2 +-
>  board/freescale/p1010rdb/spl_minimal.c            | 2 +-
>  board/freescale/p1010rdb/tlb.c                    | 3 ++-
>  board/freescale/p1_p2_rdb_pc/ddr.c                | 5 +++--
>  board/freescale/p1_p2_rdb_pc/law.c                | 2 +-
>  board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c       | 2 +-
>  board/freescale/p1_p2_rdb_pc/spl.c                | 2 +-
>  board/freescale/p1_p2_rdb_pc/spl_minimal.c        | 2 +-
>  board/freescale/p1_p2_rdb_pc/tlb.c                | 3 ++-
>  board/freescale/p2041rdb/cpld.c                   | 1 -
>  board/freescale/p2041rdb/ddr.c                    | 1 -
>  board/freescale/p2041rdb/eth.c                    | 2 +-
>  board/freescale/p2041rdb/p2041rdb.c               | 2 +-
>  board/freescale/t102xrdb/cpld.c                   | 2 +-
>  board/freescale/t102xrdb/ddr.c                    | 2 +-
>  board/freescale/t102xrdb/eth_t102xrdb.c           | 2 +-
>  board/freescale/t102xrdb/law.c                    | 2 +-
>  board/freescale/t102xrdb/spl.c                    | 2 +-
>  board/freescale/t102xrdb/t102xrdb.c               | 2 +-
>  board/freescale/t102xrdb/tlb.c                    | 3 ++-
>  board/freescale/t104xrdb/cpld.c                   | 2 +-
>  board/freescale/t104xrdb/ddr.c                    | 2 +-
>  board/freescale/t104xrdb/eth.c                    | 2 +-
>  board/freescale/t104xrdb/law.c                    | 2 +-
>  board/freescale/t104xrdb/spl.c                    | 2 +-
>  board/freescale/t104xrdb/t104xrdb.c               | 2 +-
>  board/freescale/t104xrdb/tlb.c                    | 3 ++-
>  board/freescale/t208xqds/ddr.c                    | 1 -
>  board/freescale/t208xqds/eth_t208xqds.c           | 2 +-
>  board/freescale/t208xqds/law.c                    | 2 +-
>  board/freescale/t208xqds/spl.c                    | 2 +-
>  board/freescale/t208xqds/t208xqds.c               | 2 +-
>  board/freescale/t208xqds/tlb.c                    | 3 ++-
>  board/freescale/t208xrdb/cpld.c                   | 3 ++-
>  board/freescale/t208xrdb/ddr.c                    | 1 -
>  board/freescale/t208xrdb/eth_t208xrdb.c           | 1 -
>  board/freescale/t208xrdb/law.c                    | 2 +-
>  board/freescale/t208xrdb/spl.c                    | 2 +-
>  board/freescale/t208xrdb/t208xrdb.c               | 2 +-
>  board/freescale/t208xrdb/tlb.c                    | 3 ++-
>  board/freescale/t4rdb/cpld.c                      | 2 +-
>  board/freescale/t4rdb/ddr.c                       | 1 -
>  board/freescale/t4rdb/eth.c                       | 2 +-
>  board/freescale/t4rdb/law.c                       | 2 +-
>  board/freescale/t4rdb/spl.c                       | 2 +-
>  board/freescale/t4rdb/t4240rdb.c                  | 2 +-
>  board/freescale/t4rdb/tlb.c                       | 3 ++-
>  board/freescale/vf610twr/vf610twr.c               | 1 -
>  166 files changed, 115 insertions(+), 166 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/arch-imx8m/ddr.h
> b/arch/arm/include/asm/arch-imx8m/ddr.h
> index c14855d177ec..1f81d91977c8 100644
> --- a/arch/arm/include/asm/arch-imx8m/ddr.h
> +++ b/arch/arm/include/asm/arch-imx8m/ddr.h
> @@ -8,7 +8,7 @@
>=20
>  #include <asm/io.h>
>  #include <asm/types.h>
> -#include <asm/arch/ddr.h>
> +#include <asm/arch/imx-regs.h>
>=20
>  #define DDRC_DDR_SS_GPR0		0x3d000000
>  #define DDRC_IPS_BASE_ADDR_0		0x3f400000
> diff --git a/arch/arm/include/asm/mach-imx/gpio.h
> b/arch/arm/include/asm/mach-imx/gpio.h
> index 1b7c9cd52499..25763526f5f6 100644
> --- a/arch/arm/include/asm/mach-imx/gpio.h
> +++ b/arch/arm/include/asm/mach-imx/gpio.h
> @@ -9,6 +9,8 @@
>  #define __ASM_ARCH_IMX_GPIO_H
>=20
>  #if !(defined(__KERNEL_STRICT_NAMES) || defined(__ASSEMBLY__))
> +#include <linux/types.h>
> +
>  /* GPIO registers */
>  struct gpio_regs {
>  	u32 gpio_dr;	/* data */
> diff --git a/board/freescale/common/cadmus.c
> b/board/freescale/common/cadmus.c
> index e7e07fff86c3..6f66ed6851d4 100644
> --- a/board/freescale/common/cadmus.c
> +++ b/board/freescale/common/cadmus.c
> @@ -4,8 +4,9 @@
>   */
>=20
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
> +#include <linux/types.h>
>=20
>  /*
>   * CADMUS Board System Registers
> diff --git a/board/freescale/common/cds_pci_ft.c
> b/board/freescale/common/cds_pci_ft.c
> index dc2d62850d19..56b01e3f51f0 100644
> --- a/board/freescale/common/cds_pci_ft.c
> +++ b/board/freescale/common/cds_pci_ft.c
> @@ -3,7 +3,6 @@
>   * Copyright 2004 Freescale Semiconductor.
>   */
>=20
> -#include <common.h>
>  #include <linux/libfdt.h>
>  #include <fdt_support.h>
>  #include "cadmus.h"
> diff --git a/board/freescale/common/cds_via.c
> b/board/freescale/common/cds_via.c
> index 6184472b1658..6fc3a21780f6 100644
> --- a/board/freescale/common/cds_via.c
> +++ b/board/freescale/common/cds_via.c
> @@ -3,7 +3,6 @@
>   * Copyright 2006 Freescale Semiconductor.
>   */
>=20
> -#include <common.h>
>  #include <pci.h>
>=20
>  /* Config the VIA chip */
> diff --git a/board/freescale/common/cmd_esbc_validate.c
> b/board/freescale/common/cmd_esbc_validate.c
> index 6c096266b484..d4192e5ab521 100644
> --- a/board/freescale/common/cmd_esbc_validate.c
> +++ b/board/freescale/common/cmd_esbc_validate.c
> @@ -3,10 +3,10 @@
>   * Copyright 2015 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <command.h>
>  #include <env.h>
>  #include <fsl_validate.h>
> +#include <vsprintf.h>
>=20
>  int do_esbc_halt(struct cmd_tbl *cmdtp, int flag, int argc,
>  		 char *const argv[])
> diff --git a/board/freescale/common/emc2305.c
> b/board/freescale/common/emc2305.c
> index 9a75c5a09dd1..50252bb5007f 100644
> --- a/board/freescale/common/emc2305.c
> +++ b/board/freescale/common/emc2305.c
> @@ -4,7 +4,6 @@
>   *
>   */
>=20
> -#include <common.h>
>  #include <command.h>
>  #include <i2c.h>
>  #include <asm/global_data.h>
> diff --git a/board/freescale/common/fman.c
> b/board/freescale/common/fman.c
> index 358303108d8d..650ecc7b4402 100644
> --- a/board/freescale/common/fman.c
> +++ b/board/freescale/common/fman.c
> @@ -3,7 +3,6 @@
>   * Copyright 2011-2015 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <linux/libfdt.h>
>  #include <linux/libfdt_env.h>
>  #include <fdt_support.h>
> diff --git a/board/freescale/common/fsl_chain_of_trust.c
> b/board/freescale/common/fsl_chain_of_trust.c
> index 87ed814d6a2a..27a33924c84d 100644
> --- a/board/freescale/common/fsl_chain_of_trust.c
> +++ b/board/freescale/common/fsl_chain_of_trust.c
> @@ -4,7 +4,7 @@
>   * Copyright 2022 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <dm.h>
>  #include <env.h>
>  #include <init.h>
> diff --git a/board/freescale/common/fsl_validate.c
> b/board/freescale/common/fsl_validate.c
> index bfe6357b0d60..e03434dcdfed 100644
> --- a/board/freescale/common/fsl_validate.c
> +++ b/board/freescale/common/fsl_validate.c
> @@ -4,7 +4,7 @@
>   * Copyright 2021-2022 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <dm.h>
>  #include <fsl_validate.h>
>  #include <fsl_secboot_err.h>
> diff --git a/board/freescale/common/i2c_common.c
> b/board/freescale/common/i2c_common.c
> index 119ed3c6171b..20705ecc8e46 100644
> --- a/board/freescale/common/i2c_common.c
> +++ b/board/freescale/common/i2c_common.c
> @@ -5,7 +5,7 @@
>   * Copyright 2021 Microsoft Corporation
>   */
>=20
> -#include <common.h>
> +#include <stdio.h>
>  #include <i2c.h>
>  #include "i2c_common.h"
>=20
> diff --git a/board/freescale/common/i2c_mux.c
> b/board/freescale/common/i2c_mux.c
> index d40b34f10397..89151ccaf060 100644
> --- a/board/freescale/common/i2c_mux.c
> +++ b/board/freescale/common/i2c_mux.c
> @@ -5,8 +5,9 @@
>   * Copyright 2021 Microsoft Corporation
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <i2c.h>
> +#include <stdio.h>
>  #include "i2c_common.h"
>  #include "i2c_mux.h"
>=20
> diff --git a/board/freescale/common/ics307_clk.c
> b/board/freescale/common/ics307_clk.c
> index 5f95571d24cc..af30faa0c5fe 100644
> --- a/board/freescale/common/ics307_clk.c
> +++ b/board/freescale/common/ics307_clk.c
> @@ -3,7 +3,7 @@
>   * Copyright 2010-2011 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <log.h>
>  #include <asm/io.h>
> diff --git a/board/freescale/common/ls102xa_stream_id.c
> b/board/freescale/common/ls102xa_stream_id.c
> index f754cf42fd38..bf76274c43ca 100644
> --- a/board/freescale/common/ls102xa_stream_id.c
> +++ b/board/freescale/common/ls102xa_stream_id.c
> @@ -3,7 +3,7 @@
>   * Copyright 2014 Freescale Semiconductor
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/io.h>
>  #include <asm/arch/ls102xa_stream_id.h>
>=20
> diff --git a/board/freescale/common/mc34vr500.c
> b/board/freescale/common/mc34vr500.c
> index d6b4c65a3c08..cf14b29a3ec1 100644
> --- a/board/freescale/common/mc34vr500.c
> +++ b/board/freescale/common/mc34vr500.c
> @@ -4,7 +4,6 @@
>   * Hou Zhiqiang <Zhiqiang.Hou@freescale.com>
>   */
>=20
> -#include <common.h>
>  #include <errno.h>
>  #include <i2c.h>
>  #include <log.h>
> diff --git a/board/freescale/common/mmc.c
> b/board/freescale/common/mmc.c
> index 8cd5079f962d..00e4f3675fe4 100644
> --- a/board/freescale/common/mmc.c
> +++ b/board/freescale/common/mmc.c
> @@ -4,8 +4,8 @@
>   * Copyright 2018-2022 NXP
>   */
>=20
> -#include <common.h>
>  #include <command.h>
> +#include <vsprintf.h>
>  #include <asm/arch/sys_proto.h>
>  #include <linux/errno.h>
>  #include <asm/io.h>
> diff --git a/board/freescale/common/ngpixis.c
> b/board/freescale/common/ngpixis.c
> index 7be1ccee6383..74c345807e64 100644
> --- a/board/freescale/common/ngpixis.c
> +++ b/board/freescale/common/ngpixis.c
> @@ -29,7 +29,6 @@
>   *    boot from the alternate bank.
>   */
>=20
> -#include <common.h>
>  #include <command.h>
>  #include <asm/io.h>
>=20
> diff --git a/board/freescale/common/ns_access.c
> b/board/freescale/common/ns_access.c
> index a95d15c1ef39..c46e87f4ccee 100644
> --- a/board/freescale/common/ns_access.c
> +++ b/board/freescale/common/ns_access.c
> @@ -3,7 +3,7 @@
>   * Copyright 2014 Freescale Semiconductor
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <log.h>
>  #include <asm/cache.h>
>  #include <asm/io.h>
> diff --git a/board/freescale/common/p_corenet/law.c
> b/board/freescale/common/p_corenet/law.c
> index 1a1e9343d23b..83818d6d8479 100644
> --- a/board/freescale/common/p_corenet/law.c
> +++ b/board/freescale/common/p_corenet/law.c
> @@ -6,7 +6,7 @@
>   * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/fsl_law.h>
>  #include <asm/mmu.h>
>=20
> diff --git a/board/freescale/common/p_corenet/tlb.c
> b/board/freescale/common/p_corenet/tlb.c
> index 1a2d9cbfc0ce..cebdedfa4a7a 100644
> --- a/board/freescale/common/p_corenet/tlb.c
> +++ b/board/freescale/common/p_corenet/tlb.c
> @@ -6,8 +6,9 @@
>   * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/mmu.h>
> +#include <asm/ppc.h>
>=20
>  struct fsl_e_tlb_entry tlb_table[] =3D {
>  	/* TLB 0 - for temp stack in cache */
> diff --git a/board/freescale/common/pfuze.c
> b/board/freescale/common/pfuze.c
> index a9288820b2eb..0d7a94fd232f 100644
> --- a/board/freescale/common/pfuze.c
> +++ b/board/freescale/common/pfuze.c
> @@ -3,7 +3,6 @@
>   * Copyright 2014 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <errno.h>
>  #include <power/pmic.h>
>  #include <power/pfuze100_pmic.h>
> diff --git a/board/freescale/common/qixis.c
> b/board/freescale/common/qixis.c
> index da2c1de078b7..6400ac052454 100644
> --- a/board/freescale/common/qixis.c
> +++ b/board/freescale/common/qixis.c
> @@ -7,7 +7,7 @@
>   * This file provides support for the QIXIS of some Freescale reference =
boards.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <command.h>
>  #include <asm/io.h>
>  #include <linux/compiler.h>
> diff --git a/board/freescale/common/sdhc_boot.c
> b/board/freescale/common/sdhc_boot.c
> index a1c7a94a90e3..5ee730cefd04 100644
> --- a/board/freescale/common/sdhc_boot.c
> +++ b/board/freescale/common/sdhc_boot.c
> @@ -3,7 +3,6 @@
>   * Copyright 2011 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <mmc.h>
>  #include <malloc.h>
>=20
> diff --git a/board/freescale/common/sys_eeprom.c
> b/board/freescale/common/sys_eeprom.c
> index 64139d4659f2..ec3c9e37222a 100644
> --- a/board/freescale/common/sys_eeprom.c
> +++ b/board/freescale/common/sys_eeprom.c
> @@ -6,7 +6,6 @@
>   * Timur Tabi (timur@freescale.com)
>   */
>=20
> -#include <common.h>
>  #include <command.h>
>  #include <env.h>
>  #include <i2c.h>
> diff --git a/board/freescale/common/vid.c b/board/freescale/common/vid.c
> index fc5d400cfe18..84cb43fad56a 100644
> --- a/board/freescale/common/vid.c
> +++ b/board/freescale/common/vid.c
> @@ -5,12 +5,13 @@
>   * Copyright 2020 Stephen Carlson <stcarlso@linux.microsoft.com>
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <command.h>
>  #include <env.h>
>  #include <i2c.h>
>  #include <irq_func.h>
>  #include <log.h>
> +#include <vsprintf.h>
>  #include <asm/io.h>
>  #ifdef CONFIG_FSL_LSCH2
>  #include <asm/arch/immap_lsch2.h>
> diff --git a/board/freescale/imx8mm_evk/imx8mm_evk.c
> b/board/freescale/imx8mm_evk/imx8mm_evk.c
> index e0975fcda705..4c4436af3b1d 100644
> --- a/board/freescale/imx8mm_evk/imx8mm_evk.c
> +++ b/board/freescale/imx8mm_evk/imx8mm_evk.c
> @@ -3,7 +3,6 @@
>   * Copyright 2018 NXP
>   */
>=20
> -#include <common.h>
>  #include <env.h>
>  #include <init.h>
>  #include <miiphy.h>
> diff --git a/board/freescale/imx8mm_evk/spl.c
> b/board/freescale/imx8mm_evk/spl.c
> index 35437811d9df..cd251d274ff6 100644
> --- a/board/freescale/imx8mm_evk/spl.c
> +++ b/board/freescale/imx8mm_evk/spl.c
> @@ -3,7 +3,6 @@
>   * Copyright 2019, 2021 NXP
>   */
>=20
> -#include <common.h>
>  #include <command.h>
>  #include <cpu_func.h>
>  #include <hang.h>
> diff --git a/board/freescale/imx8mn_evk/imx8mn_evk.c
> b/board/freescale/imx8mn_evk/imx8mn_evk.c
> index e35d505aea97..6b6fb0a7dd21 100644
> --- a/board/freescale/imx8mn_evk/imx8mn_evk.c
> +++ b/board/freescale/imx8mn_evk/imx8mn_evk.c
> @@ -3,7 +3,6 @@
>   * Copyright 2019 NXP
>   */
>=20
> -#include <common.h>
>  #include <env.h>
>  #include <init.h>
>  #include <asm/global_data.h>
> diff --git a/board/freescale/imx8mn_evk/spl.c
> b/board/freescale/imx8mn_evk/spl.c
> index dd54fa9b6085..231b9289eead 100644
> --- a/board/freescale/imx8mn_evk/spl.c
> +++ b/board/freescale/imx8mn_evk/spl.c
> @@ -4,7 +4,6 @@
>   *
>   */
>=20
> -#include <common.h>
>  #include <command.h>
>  #include <cpu_func.h>
>  #include <hang.h>
> diff --git a/board/freescale/imx8mp_evk/spl.c
> b/board/freescale/imx8mp_evk/spl.c
> index 9dd2cbc799c3..12da1b2abfbb 100644
> --- a/board/freescale/imx8mp_evk/spl.c
> +++ b/board/freescale/imx8mp_evk/spl.c
> @@ -4,7 +4,6 @@
>   *
>   */
>=20
> -#include <common.h>
>  #include <hang.h>
>  #include <init.h>
>  #include <log.h>
> diff --git a/board/freescale/imx8mq_evk/imx8mq_evk.c
> b/board/freescale/imx8mq_evk/imx8mq_evk.c
> index e577e4d9ccaa..ab920a4539cd 100644
> --- a/board/freescale/imx8mq_evk/imx8mq_evk.c
> +++ b/board/freescale/imx8mq_evk/imx8mq_evk.c
> @@ -3,7 +3,6 @@
>   * Copyright 2018 NXP
>   */
>=20
> -#include <common.h>
>  #include <env.h>
>  #include <init.h>
>  #include <malloc.h>
> diff --git a/board/freescale/imx8mq_evk/lpddr4_timing.c
> b/board/freescale/imx8mq_evk/lpddr4_timing.c
> index 46bc7f8591cb..e9559e3d843a 100644
> --- a/board/freescale/imx8mq_evk/lpddr4_timing.c
> +++ b/board/freescale/imx8mq_evk/lpddr4_timing.c
> @@ -4,7 +4,6 @@
>   */
>=20
>  #include <linux/kernel.h>
> -#include <common.h>
>  #include <asm/arch/ddr.h>
>  #include <asm/arch/lpddr4_define.h>
>=20
> diff --git a/board/freescale/imx8mq_evk/lpddr4_timing_b0.c
> b/board/freescale/imx8mq_evk/lpddr4_timing_b0.c
> index ec68edaf6905..5d8f2803be67 100644
> --- a/board/freescale/imx8mq_evk/lpddr4_timing_b0.c
> +++ b/board/freescale/imx8mq_evk/lpddr4_timing_b0.c
> @@ -4,7 +4,6 @@
>   */
>=20
>  #include <linux/kernel.h>
> -#include <common.h>
>  #include <asm/arch/ddr.h>
>  #include <asm/arch/lpddr4_define.h>
>=20
> diff --git a/board/freescale/imx8mq_evk/spl.c
> b/board/freescale/imx8mq_evk/spl.c
> index 818cdd615eb9..a346305c8633 100644
> --- a/board/freescale/imx8mq_evk/spl.c
> +++ b/board/freescale/imx8mq_evk/spl.c
> @@ -4,7 +4,7 @@
>   *
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <hang.h>
>  #include <image.h>
>  #include <init.h>
> diff --git a/board/freescale/imx8qm_mek/imx8qm_mek.c
> b/board/freescale/imx8qm_mek/imx8qm_mek.c
> index 2b209c8886f2..72527f774ca9 100644
> --- a/board/freescale/imx8qm_mek/imx8qm_mek.c
> +++ b/board/freescale/imx8qm_mek/imx8qm_mek.c
> @@ -3,7 +3,6 @@
>   * Copyright 2018 NXP
>   */
>=20
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <env.h>
>  #include <errno.h>
> diff --git a/board/freescale/imx8qm_mek/spl.c
> b/board/freescale/imx8qm_mek/spl.c
> index 17fd437116d3..ad7868333091 100644
> --- a/board/freescale/imx8qm_mek/spl.c
> +++ b/board/freescale/imx8qm_mek/spl.c
> @@ -4,7 +4,6 @@
>   *
>   */
>=20
> -#include <common.h>
>  #include <dm.h>
>  #include <image.h>
>  #include <init.h>
> diff --git a/board/freescale/imx8qxp_mek/imx8qxp_mek.c
> b/board/freescale/imx8qxp_mek/imx8qxp_mek.c
> index 833bee55462d..adb9556a021c 100644
> --- a/board/freescale/imx8qxp_mek/imx8qxp_mek.c
> +++ b/board/freescale/imx8qxp_mek/imx8qxp_mek.c
> @@ -3,7 +3,6 @@
>   * Copyright 2018 NXP
>   */
>=20
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <env.h>
>  #include <errno.h>
> diff --git a/board/freescale/imx8qxp_mek/spl.c
> b/board/freescale/imx8qxp_mek/spl.c
> index 462c43ceebc7..05e3c0a2ff26 100644
> --- a/board/freescale/imx8qxp_mek/spl.c
> +++ b/board/freescale/imx8qxp_mek/spl.c
> @@ -4,7 +4,6 @@
>   *
>   */
>=20
> -#include <common.h>
>  #include <dm.h>
>  #include <image.h>
>  #include <init.h>
> diff --git a/board/freescale/imx8ulp_evk/imx8ulp_evk.c
> b/board/freescale/imx8ulp_evk/imx8ulp_evk.c
> index dd04d5925a00..0af610672637 100644
> --- a/board/freescale/imx8ulp_evk/imx8ulp_evk.c
> +++ b/board/freescale/imx8ulp_evk/imx8ulp_evk.c
> @@ -3,7 +3,6 @@
>   * Copyright 2020 NXP
>   */
>=20
> -#include <common.h>
>  #include <miiphy.h>
>  #include <netdev.h>
>  #include <asm/arch/imx8ulp-pins.h>
> diff --git a/board/freescale/imx8ulp_evk/spl.c
> b/board/freescale/imx8ulp_evk/spl.c
> index c49b5be47620..d123b21b7225 100644
> --- a/board/freescale/imx8ulp_evk/spl.c
> +++ b/board/freescale/imx8ulp_evk/spl.c
> @@ -3,7 +3,6 @@
>   * Copyright 2021 NXP
>   */
>=20
> -#include <common.h>
>  #include <init.h>
>  #include <spl.h>
>  #include <asm/io.h>
> diff --git a/board/freescale/imx93_evk/imx93_evk.c
> b/board/freescale/imx93_evk/imx93_evk.c
> index c54dc9d05c5c..341831a7d30d 100644
> --- a/board/freescale/imx93_evk/imx93_evk.c
> +++ b/board/freescale/imx93_evk/imx93_evk.c
> @@ -3,7 +3,6 @@
>   * Copyright 2022 NXP
>   */
>=20
> -#include <common.h>
>  #include <env.h>
>  #include <init.h>
>  #include <miiphy.h>
> diff --git a/board/freescale/imx93_evk/spl.c
> b/board/freescale/imx93_evk/spl.c
> index 6d5e110b2776..e5807134bb23 100644
> --- a/board/freescale/imx93_evk/spl.c
> +++ b/board/freescale/imx93_evk/spl.c
> @@ -3,7 +3,6 @@
>   * Copyright 2022 NXP
>   */
>=20
> -#include <common.h>
>  #include <command.h>
>  #include <cpu_func.h>
>  #include <hang.h>
> diff --git a/board/freescale/imxrt1020-evk/imxrt1020-evk.c
> b/board/freescale/imxrt1020-evk/imxrt1020-evk.c
> index 785da604b964..42a0a67ae933 100644
> --- a/board/freescale/imxrt1020-evk/imxrt1020-evk.c
> +++ b/board/freescale/imxrt1020-evk/imxrt1020-evk.c
> @@ -4,7 +4,6 @@
>   * Author(s): Giulio Benetti <giulio.benetti@benettiengineering.com>
>   */
>=20
> -#include <common.h>
>  #include <dm.h>
>  #include <init.h>
>  #include <log.h>
> diff --git a/board/freescale/imxrt1050-evk/imxrt1050-evk.c
> b/board/freescale/imxrt1050-evk/imxrt1050-evk.c
> index 4cc3defc8828..46a644908e9d 100644
> --- a/board/freescale/imxrt1050-evk/imxrt1050-evk.c
> +++ b/board/freescale/imxrt1050-evk/imxrt1050-evk.c
> @@ -4,7 +4,6 @@
>   * Author(s): Giulio Benetti <giulio.benetti@benettiengineering.com>
>   */
>=20
> -#include <common.h>
>  #include <dm.h>
>  #include <init.h>
>  #include <log.h>
> diff --git a/board/freescale/imxrt1170-evk/imxrt1170-evk.c
> b/board/freescale/imxrt1170-evk/imxrt1170-evk.c
> index 4b82ee5e9ce4..e10b8830ec6a 100644
> --- a/board/freescale/imxrt1170-evk/imxrt1170-evk.c
> +++ b/board/freescale/imxrt1170-evk/imxrt1170-evk.c
> @@ -4,7 +4,6 @@
>   * Author(s): Giulio Benetti <giulio.benetti@benettiengineering.com>
>   */
>=20
> -#include <common.h>
>  #include <dm.h>
>  #include <init.h>
>  #include <log.h>
> diff --git a/board/freescale/ls1012afrdm/eth.c
> b/board/freescale/ls1012afrdm/eth.c
> index d2df9351eacc..c431e5e611bb 100644
> --- a/board/freescale/ls1012afrdm/eth.c
> +++ b/board/freescale/ls1012afrdm/eth.c
> @@ -4,7 +4,6 @@
>   * Copyright 2017 NXP
>   */
>=20
> -#include <common.h>
>  #include <dm.h>
>  #include <net.h>
>  #include <asm/io.h>
> diff --git a/board/freescale/ls1012afrdm/ls1012afrdm.c
> b/board/freescale/ls1012afrdm/ls1012afrdm.c
> index 271072bf7a1c..dae2cf097bc0 100644
> --- a/board/freescale/ls1012afrdm/ls1012afrdm.c
> +++ b/board/freescale/ls1012afrdm/ls1012afrdm.c
> @@ -3,7 +3,7 @@
>   * Copyright 2017-2018, 2021 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <fdt_support.h>
>  #include <i2c.h>
>  #include <asm/cache.h>
> diff --git a/board/freescale/ls1012aqds/eth.c
> b/board/freescale/ls1012aqds/eth.c
> index 38267acedde1..d5e87c5393b8 100644
> --- a/board/freescale/ls1012aqds/eth.c
> +++ b/board/freescale/ls1012aqds/eth.c
> @@ -4,7 +4,7 @@
>   * Copyright 2017 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <dm.h>
>  #include <asm/io.h>
>  #include <netdev.h>
> diff --git a/board/freescale/ls1012aqds/ls1012aqds.c
> b/board/freescale/ls1012aqds/ls1012aqds.c
> index a5ea8d634edc..7d56eb0117d4 100644
> --- a/board/freescale/ls1012aqds/ls1012aqds.c
> +++ b/board/freescale/ls1012aqds/ls1012aqds.c
> @@ -4,7 +4,7 @@
>   * Copyright 2021 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <i2c.h>
>  #include <fdt_support.h>
>  #include <asm/cache.h>
> diff --git a/board/freescale/ls1012ardb/eth.c
> b/board/freescale/ls1012ardb/eth.c
> index 5c661274987c..71cb2988a56d 100644
> --- a/board/freescale/ls1012ardb/eth.c
> +++ b/board/freescale/ls1012ardb/eth.c
> @@ -4,7 +4,7 @@
>   * Copyright 2017 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <dm.h>
>  #include <net.h>
>  #include <asm/io.h>
> diff --git a/board/freescale/ls1012ardb/ls1012ardb.c
> b/board/freescale/ls1012ardb/ls1012ardb.c
> index 18f92089caef..7f8001b4981f 100644
> --- a/board/freescale/ls1012ardb/ls1012ardb.c
> +++ b/board/freescale/ls1012ardb/ls1012ardb.c
> @@ -4,7 +4,7 @@
>   * Copyright 2021 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <command.h>
>  #include <fdt_support.h>
>  #include <hang.h>
> diff --git a/board/freescale/ls1021aiot/ls1021aiot.c
> b/board/freescale/ls1021aiot/ls1021aiot.c
> index d6f22bd6a2a3..7abc41269330 100644
> --- a/board/freescale/ls1021aiot/ls1021aiot.c
> +++ b/board/freescale/ls1021aiot/ls1021aiot.c
> @@ -4,7 +4,7 @@
>   * Copyright 2021 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <fdt_support.h>
>  #include <init.h>
> diff --git a/board/freescale/ls1021aqds/ddr.c
> b/board/freescale/ls1021aqds/ddr.c
> index 4e70acc5a0cc..5b0f23688f0b 100644
> --- a/board/freescale/ls1021aqds/ddr.c
> +++ b/board/freescale/ls1021aqds/ddr.c
> @@ -3,7 +3,7 @@
>   * Copyright 2014 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <fsl_ddr_sdram.h>
>  #include <fsl_ddr_dimm_params.h>
>  #include <init.h>
> diff --git a/board/freescale/ls1028a/ddr.c b/board/freescale/ls1028a/ddr.=
c
> index 3e976da6b305..c406f2436d1a 100644
> --- a/board/freescale/ls1028a/ddr.c
> +++ b/board/freescale/ls1028a/ddr.c
> @@ -3,7 +3,6 @@
>   * Copyright 2019 NXP
>   */
>=20
> -#include <common.h>
>  #include <fsl_ddr_sdram.h>
>  #include <fsl_ddr_dimm_params.h>
>  #include <asm/global_data.h>
> diff --git a/board/freescale/ls1028a/ls1028a.c
> b/board/freescale/ls1028a/ls1028a.c
> index 7f181ab3dfb7..e01b5a8c2eb0 100644
> --- a/board/freescale/ls1028a/ls1028a.c
> +++ b/board/freescale/ls1028a/ls1028a.c
> @@ -3,7 +3,7 @@
>   * Copyright 2019-2022 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <display_options.h>
>  #include <init.h>
>  #include <malloc.h>
> diff --git a/board/freescale/ls1043aqds/ddr.c
> b/board/freescale/ls1043aqds/ddr.c
> index 23947bdb84c9..2a9717df616c 100644
> --- a/board/freescale/ls1043aqds/ddr.c
> +++ b/board/freescale/ls1043aqds/ddr.c
> @@ -3,7 +3,6 @@
>   * Copyright 2015 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <fsl_ddr_sdram.h>
>  #include <fsl_ddr_dimm_params.h>
>  #ifdef CONFIG_FSL_DEEP_SLEEP
> diff --git a/board/freescale/ls1043aqds/eth.c
> b/board/freescale/ls1043aqds/eth.c
> index cd1f83e3d068..5a8ca27b3278 100644
> --- a/board/freescale/ls1043aqds/eth.c
> +++ b/board/freescale/ls1043aqds/eth.c
> @@ -4,7 +4,7 @@
>   * Copyright 2019 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <log.h>
>  #include <net.h>
>  #include <asm/io.h>
> diff --git a/board/freescale/ls1043aqds/ls1043aqds.c
> b/board/freescale/ls1043aqds/ls1043aqds.c
> index b87da41e4083..fdf011efc5bd 100644
> --- a/board/freescale/ls1043aqds/ls1043aqds.c
> +++ b/board/freescale/ls1043aqds/ls1043aqds.c
> @@ -4,7 +4,7 @@
>   * Copyright 2019-2020 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <i2c.h>
>  #include <fdt_support.h>
> diff --git a/board/freescale/ls1043ardb/cpld.c
> b/board/freescale/ls1043ardb/cpld.c
> index 9db3aa586059..bda2f3ac3a69 100644
> --- a/board/freescale/ls1043ardb/cpld.c
> +++ b/board/freescale/ls1043ardb/cpld.c
> @@ -5,7 +5,7 @@
>   * Freescale LS1043ARDB board-specific CPLD controlling supports.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <command.h>
>  #include <asm/io.h>
>  #include "cpld.h"
> diff --git a/board/freescale/ls1043ardb/ddr.c
> b/board/freescale/ls1043ardb/ddr.c
> index 4d2fce384121..187925e981a5 100644
> --- a/board/freescale/ls1043ardb/ddr.c
> +++ b/board/freescale/ls1043ardb/ddr.c
> @@ -3,7 +3,6 @@
>   * Copyright 2015 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <fsl_ddr_sdram.h>
>  #include <fsl_ddr_dimm_params.h>
>  #include <asm/global_data.h>
> diff --git a/board/freescale/ls1043ardb/eth.c
> b/board/freescale/ls1043ardb/eth.c
> index cc95214c4e3f..cacc49c0584d 100644
> --- a/board/freescale/ls1043ardb/eth.c
> +++ b/board/freescale/ls1043ardb/eth.c
> @@ -2,7 +2,7 @@
>  /*
>   * Copyright 2015 Freescale Semiconductor, Inc.
>   */
> -#include <common.h>
> +#include <config.h>
>  #include <net.h>
>  #include <asm/io.h>
>  #include <netdev.h>
> diff --git a/board/freescale/ls1046afrwy/ddr.c
> b/board/freescale/ls1046afrwy/ddr.c
> index 256397b52b65..b08caee1d97d 100644
> --- a/board/freescale/ls1046afrwy/ddr.c
> +++ b/board/freescale/ls1046afrwy/ddr.c
> @@ -3,7 +3,6 @@
>   * Copyright 2019 NXP
>   */
>=20
> -#include <common.h>
>  #include <fsl_ddr_sdram.h>
>  #include <asm/global_data.h>
>=20
> diff --git a/board/freescale/ls1046afrwy/eth.c
> b/board/freescale/ls1046afrwy/eth.c
> index d1a2bfe18855..8efc7f68424c 100644
> --- a/board/freescale/ls1046afrwy/eth.c
> +++ b/board/freescale/ls1046afrwy/eth.c
> @@ -2,7 +2,7 @@
>  /*
>   * Copyright 2019 NXP
>   */
> -#include <common.h>
> +#include <config.h>
>  #include <fdt_support.h>
>  #include <net.h>
>  #include <asm/io.h>
> diff --git a/board/freescale/ls1046afrwy/ls1046afrwy.c
> b/board/freescale/ls1046afrwy/ls1046afrwy.c
> index 899c22a367e6..8889c24f1f0c 100644
> --- a/board/freescale/ls1046afrwy/ls1046afrwy.c
> +++ b/board/freescale/ls1046afrwy/ls1046afrwy.c
> @@ -3,7 +3,7 @@
>   * Copyright 2019, 2021 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <i2c.h>
>  #include <fdt_support.h>
>  #include <init.h>
> diff --git a/board/freescale/ls1046aqds/ddr.c
> b/board/freescale/ls1046aqds/ddr.c
> index 9a96de271786..ac1b60497216 100644
> --- a/board/freescale/ls1046aqds/ddr.c
> +++ b/board/freescale/ls1046aqds/ddr.c
> @@ -3,7 +3,6 @@
>   * Copyright 2016 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <fsl_ddr_sdram.h>
>  #include <fsl_ddr_dimm_params.h>
>  #ifdef CONFIG_FSL_DEEP_SLEEP
> diff --git a/board/freescale/ls1046aqds/eth.c
> b/board/freescale/ls1046aqds/eth.c
> index bbf8b8c2bee5..cd3500c2e960 100644
> --- a/board/freescale/ls1046aqds/eth.c
> +++ b/board/freescale/ls1046aqds/eth.c
> @@ -4,7 +4,7 @@
>   * Copyright 2018-2020 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <log.h>
>  #include <net.h>
>  #include <asm/io.h>
> diff --git a/board/freescale/ls1046aqds/ls1046aqds.c
> b/board/freescale/ls1046aqds/ls1046aqds.c
> index 2faac54a0e23..a83b21706519 100644
> --- a/board/freescale/ls1046aqds/ls1046aqds.c
> +++ b/board/freescale/ls1046aqds/ls1046aqds.c
> @@ -4,7 +4,7 @@
>   * Copyright 2019-2021 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <i2c.h>
>  #include <fdt_support.h>
> diff --git a/board/freescale/ls1046ardb/cpld.c
> b/board/freescale/ls1046ardb/cpld.c
> index ee19d4ff8aab..7f8ca2e857fd 100644
> --- a/board/freescale/ls1046ardb/cpld.c
> +++ b/board/freescale/ls1046ardb/cpld.c
> @@ -5,7 +5,7 @@
>   * Freescale LS1046ARDB board-specific CPLD controlling supports.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <command.h>
>  #include <asm/io.h>
>  #include "cpld.h"
> diff --git a/board/freescale/ls1046ardb/ddr.c
> b/board/freescale/ls1046ardb/ddr.c
> index befb556bd30b..68353022e7dd 100644
> --- a/board/freescale/ls1046ardb/ddr.c
> +++ b/board/freescale/ls1046ardb/ddr.c
> @@ -3,7 +3,6 @@
>   * Copyright 2016 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <fsl_ddr_sdram.h>
>  #include <fsl_ddr_dimm_params.h>
>  #include <asm/global_data.h>
> diff --git a/board/freescale/ls1046ardb/eth.c
> b/board/freescale/ls1046ardb/eth.c
> index bbc22a3cdf4a..fee8e0e21d44 100644
> --- a/board/freescale/ls1046ardb/eth.c
> +++ b/board/freescale/ls1046ardb/eth.c
> @@ -2,7 +2,7 @@
>  /*
>   * Copyright 2016 Freescale Semiconductor, Inc.
>   */
> -#include <common.h>
> +#include <config.h>
>  #include <fdt_support.h>
>  #include <net.h>
>  #include <asm/io.h>
> diff --git a/board/freescale/ls1046ardb/ls1046ardb.c
> b/board/freescale/ls1046ardb/ls1046ardb.c
> index 26e69db55f74..0492f0a8c0ae 100644
> --- a/board/freescale/ls1046ardb/ls1046ardb.c
> +++ b/board/freescale/ls1046ardb/ls1046ardb.c
> @@ -4,7 +4,7 @@
>   * Copyright 2021 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <i2c.h>
>  #include <fdt_support.h>
>  #include <init.h>
> diff --git a/board/freescale/ls1088a/ddr.c b/board/freescale/ls1088a/ddr.=
c
> index 9e0941cc9d6e..d2e239c4d615 100644
> --- a/board/freescale/ls1088a/ddr.c
> +++ b/board/freescale/ls1088a/ddr.c
> @@ -3,7 +3,6 @@
>   * Copyright 2017 NXP
>   */
>=20
> -#include <common.h>
>  #include <fsl_ddr_sdram.h>
>  #include <fsl_ddr_dimm_params.h>
>  #include <log.h>
> diff --git a/board/freescale/ls1088a/ls1088a.c
> b/board/freescale/ls1088a/ls1088a.c
> index 98a91c48adb0..58951f2bb2aa 100644
> --- a/board/freescale/ls1088a/ls1088a.c
> +++ b/board/freescale/ls1088a/ls1088a.c
> @@ -2,7 +2,7 @@
>  /*
>   * Copyright 2017-2022 NXP
>   */
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <display_options.h>
>  #include <env.h>
> diff --git a/board/freescale/ls2080aqds/ddr.c
> b/board/freescale/ls2080aqds/ddr.c
> index 2767d058cc96..2986ffb7a820 100644
> --- a/board/freescale/ls2080aqds/ddr.c
> +++ b/board/freescale/ls2080aqds/ddr.c
> @@ -3,7 +3,6 @@
>   * Copyright 2015 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <fsl_ddr_sdram.h>
>  #include <fsl_ddr_dimm_params.h>
>  #include <log.h>
> diff --git a/board/freescale/ls2080aqds/ls2080aqds.c
> b/board/freescale/ls2080aqds/ls2080aqds.c
> index 5c94c83121b5..4c8d0706688f 100644
> --- a/board/freescale/ls2080aqds/ls2080aqds.c
> +++ b/board/freescale/ls2080aqds/ls2080aqds.c
> @@ -3,7 +3,7 @@
>   * Copyright 2015 Freescale Semiconductor
>   * Copyright 2021 NXP
>   */
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <display_options.h>
>  #include <env.h>
> diff --git a/board/freescale/ls2080ardb/ddr.c
> b/board/freescale/ls2080ardb/ddr.c
> index 07fa84733324..ec34b42e619a 100644
> --- a/board/freescale/ls2080ardb/ddr.c
> +++ b/board/freescale/ls2080ardb/ddr.c
> @@ -3,7 +3,6 @@
>   * Copyright 2015 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <fsl_ddr_sdram.h>
>  #include <fsl_ddr_dimm_params.h>
>  #include <log.h>
> diff --git a/board/freescale/ls2080ardb/ls2080ardb.c
> b/board/freescale/ls2080ardb/ls2080ardb.c
> index 5c30de83d841..6f824f57c478 100644
> --- a/board/freescale/ls2080ardb/ls2080ardb.c
> +++ b/board/freescale/ls2080ardb/ls2080ardb.c
> @@ -3,7 +3,7 @@
>   * Copyright 2015 Freescale Semiconductor
>   * Copyright 2017, 2021 NXP
>   */
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <display_options.h>
>  #include <env.h>
> diff --git a/board/freescale/lx2160a/ddr.c b/board/freescale/lx2160a/ddr.=
c
> index 7ab7a9e6ca83..637e43a22bee 100644
> --- a/board/freescale/lx2160a/ddr.c
> +++ b/board/freescale/lx2160a/ddr.c
> @@ -3,7 +3,6 @@
>   * Copyright 2018 NXP
>   */
>=20
> -#include <common.h>
>  #include <fsl_ddr_sdram.h>
>  #include <fsl_ddr_dimm_params.h>
>  #include <asm/global_data.h>
> diff --git a/board/freescale/lx2160a/eth_lx2160ardb.c
> b/board/freescale/lx2160a/eth_lx2160ardb.c
> index c5dfefe1f342..90e7c9100e12 100644
> --- a/board/freescale/lx2160a/eth_lx2160ardb.c
> +++ b/board/freescale/lx2160a/eth_lx2160ardb.c
> @@ -4,7 +4,6 @@
>   *
>   */
>=20
> -#include <common.h>
>  #include <netdev.h>
>  #include <exports.h>
>  #include <fsl-mc/fsl_mc.h>
> diff --git a/board/freescale/lx2160a/lx2160a.c
> b/board/freescale/lx2160a/lx2160a.c
> index b3187a14214a..3aa984dab8e7 100644
> --- a/board/freescale/lx2160a/lx2160a.c
> +++ b/board/freescale/lx2160a/lx2160a.c
> @@ -3,7 +3,7 @@
>   * Copyright 2018-2021 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <display_options.h>
>  #include <dm.h>
> diff --git a/board/freescale/m5208evbe/m5208evbe.c
> b/board/freescale/m5208evbe/m5208evbe.c
> index 6125c9e13aa3..b202b8094d92 100644
> --- a/board/freescale/m5208evbe/m5208evbe.c
> +++ b/board/freescale/m5208evbe/m5208evbe.c
> @@ -8,7 +8,6 @@
>   */
>=20
>  #include <config.h>
> -#include <common.h>
>  #include <init.h>
>  #include <asm/global_data.h>
>  #include <asm/immap.h>
> diff --git a/board/freescale/m5235evb/m5235evb.c
> b/board/freescale/m5235evb/m5235evb.c
> index 44161a0b0a1c..65cde56fb2d7 100644
> --- a/board/freescale/m5235evb/m5235evb.c
> +++ b/board/freescale/m5235evb/m5235evb.c
> @@ -8,7 +8,6 @@
>   */
>=20
>  #include <config.h>
> -#include <common.h>
>  #include <init.h>
>  #include <asm/global_data.h>
>  #include <asm/immap.h>
> diff --git a/board/freescale/m5249evb/m5249evb.c
> b/board/freescale/m5249evb/m5249evb.c
> index d67db24d5883..717dc087e02b 100644
> --- a/board/freescale/m5249evb/m5249evb.c
> +++ b/board/freescale/m5249evb/m5249evb.c
> @@ -4,7 +4,7 @@
>   * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <command.h>
>  #include <init.h>
>  #include <malloc.h>
> diff --git a/board/freescale/m5253demo/flash.c
> b/board/freescale/m5253demo/flash.c
> index eeb9cfd31259..334518a4bc9d 100644
> --- a/board/freescale/m5253demo/flash.c
> +++ b/board/freescale/m5253demo/flash.c
> @@ -7,10 +7,11 @@
>   * TsiChung Liew (Tsi-Chung.Liew@freescale.com)
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <flash.h>
>  #include <init.h>
>  #include <irq_func.h>
> +#include <time.h>
>=20
>  #include <asm/immap.h>
>=20
> diff --git a/board/freescale/m5253demo/m5253demo.c
> b/board/freescale/m5253demo/m5253demo.c
> index c1cff52fb3db..d0b01f81745f 100644
> --- a/board/freescale/m5253demo/m5253demo.c
> +++ b/board/freescale/m5253demo/m5253demo.c
> @@ -7,7 +7,7 @@
>   * Hayden Fraser (Hayden.Fraser@freescale.com)
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <init.h>
>  #include <net.h>
>  #include <asm/global_data.h>
> diff --git a/board/freescale/m5272c3/m5272c3.c
> b/board/freescale/m5272c3/m5272c3.c
> index 3c20a23385c5..d1286badc61c 100644
> --- a/board/freescale/m5272c3/m5272c3.c
> +++ b/board/freescale/m5272c3/m5272c3.c
> @@ -6,7 +6,7 @@
>   * Copyright (C) 2012 Freescale Semiconductor, Inc. All Rights Reserved.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <init.h>
>  #include <asm/global_data.h>
>  #include <asm/immap.h>
> diff --git a/board/freescale/m5275evb/m5275evb.c
> b/board/freescale/m5275evb/m5275evb.c
> index 00fa35ca5f71..e1d94fc9a3e2 100644
> --- a/board/freescale/m5275evb/m5275evb.c
> +++ b/board/freescale/m5275evb/m5275evb.c
> @@ -8,7 +8,7 @@
>   * Copyright (C) 2012 Freescale Semiconductor, Inc. All Rights Reserved.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <init.h>
>  #include <asm/global_data.h>
>  #include <asm/immap.h>
> diff --git a/board/freescale/m5282evb/m5282evb.c
> b/board/freescale/m5282evb/m5282evb.c
> index 53e0f202101c..81da6e2abd46 100644
> --- a/board/freescale/m5282evb/m5282evb.c
> +++ b/board/freescale/m5282evb/m5282evb.c
> @@ -4,7 +4,7 @@
>   * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <init.h>
>  #include <asm/global_data.h>
>  #include <asm/immap.h>
> diff --git a/board/freescale/m53017evb/m53017evb.c
> b/board/freescale/m53017evb/m53017evb.c
> index 76ebc0ab8dcd..196d56dc17d3 100644
> --- a/board/freescale/m53017evb/m53017evb.c
> +++ b/board/freescale/m53017evb/m53017evb.c
> @@ -8,7 +8,6 @@
>   */
>=20
>  #include <config.h>
> -#include <common.h>
>  #include <init.h>
>  #include <asm/global_data.h>
>  #include <asm/immap.h>
> diff --git a/board/freescale/m5329evb/m5329evb.c
> b/board/freescale/m5329evb/m5329evb.c
> index b278dbfb4852..26d5f3bf58ce 100644
> --- a/board/freescale/m5329evb/m5329evb.c
> +++ b/board/freescale/m5329evb/m5329evb.c
> @@ -8,7 +8,6 @@
>   */
>=20
>  #include <config.h>
> -#include <common.h>
>  #include <init.h>
>  #include <asm/global_data.h>
>  #include <asm/immap.h>
> diff --git a/board/freescale/m5329evb/nand.c
> b/board/freescale/m5329evb/nand.c
> index d921eef8b675..a250d61ef368 100644
> --- a/board/freescale/m5329evb/nand.c
> +++ b/board/freescale/m5329evb/nand.c
> @@ -8,7 +8,6 @@
>   */
>=20
>  #include <config.h>
> -#include <common.h>
>  #include <asm/io.h>
>  #include <asm/immap.h>
>=20
> diff --git a/board/freescale/m5373evb/m5373evb.c
> b/board/freescale/m5373evb/m5373evb.c
> index 0e9eec316c2f..d6fdf41bab47 100644
> --- a/board/freescale/m5373evb/m5373evb.c
> +++ b/board/freescale/m5373evb/m5373evb.c
> @@ -8,7 +8,6 @@
>   */
>=20
>  #include <config.h>
> -#include <common.h>
>  #include <init.h>
>  #include <asm/global_data.h>
>  #include <asm/immap.h>
> diff --git a/board/freescale/m5373evb/nand.c
> b/board/freescale/m5373evb/nand.c
> index 6d825a66e33f..e7c08d22e6bb 100644
> --- a/board/freescale/m5373evb/nand.c
> +++ b/board/freescale/m5373evb/nand.c
> @@ -8,7 +8,6 @@
>   */
>=20
>  #include <config.h>
> -#include <common.h>
>  #include <asm/io.h>
>  #include <asm/immap.h>
>=20
> diff --git a/board/freescale/mpc837xerdb/mpc837xerdb.c
> b/board/freescale/mpc837xerdb/mpc837xerdb.c
> index 97884a397964..55299745a3cb 100644
> --- a/board/freescale/mpc837xerdb/mpc837xerdb.c
> +++ b/board/freescale/mpc837xerdb/mpc837xerdb.c
> @@ -5,7 +5,7 @@
>   * Joe D'Abbraccio <joe.d'abbraccio@freescale.com>
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <env.h>
>  #include <hwconfig.h>
>  #include <i2c.h>
> diff --git a/board/freescale/mpc8548cds/ddr.c
> b/board/freescale/mpc8548cds/ddr.c
> index b6c1847b141b..14202cd5a788 100644
> --- a/board/freescale/mpc8548cds/ddr.c
> +++ b/board/freescale/mpc8548cds/ddr.c
> @@ -3,7 +3,6 @@
>   * Copyright 2008 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>=20
>  #include <fsl_ddr_sdram.h>
>  #include <fsl_ddr_dimm_params.h>
> diff --git a/board/freescale/mpc8548cds/law.c
> b/board/freescale/mpc8548cds/law.c
> index 7b6ef5b11c92..2334870fda08 100644
> --- a/board/freescale/mpc8548cds/law.c
> +++ b/board/freescale/mpc8548cds/law.c
> @@ -6,7 +6,7 @@
>   * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/fsl_law.h>
>  #include <asm/mmu.h>
>=20
> diff --git a/board/freescale/mpc8548cds/mpc8548cds.c
> b/board/freescale/mpc8548cds/mpc8548cds.c
> index ec6e3a2d0ab5..7810010fd042 100644
> --- a/board/freescale/mpc8548cds/mpc8548cds.c
> +++ b/board/freescale/mpc8548cds/mpc8548cds.c
> @@ -5,7 +5,7 @@
>   * (C) Copyright 2002 Scott McNutt <smcnutt@artesyncp.com>
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <display_options.h>
>  #include <init.h>
>  #include <net.h>
> diff --git a/board/freescale/mpc8548cds/tlb.c
> b/board/freescale/mpc8548cds/tlb.c
> index 994a32dd92ad..0b2afa8054d8 100644
> --- a/board/freescale/mpc8548cds/tlb.c
> +++ b/board/freescale/mpc8548cds/tlb.c
> @@ -6,8 +6,9 @@
>   * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/mmu.h>
> +#include <asm/ppc.h>
>=20
>  struct fsl_e_tlb_entry tlb_table[] =3D {
>  	/* TLB 0 - for temp stack in cache */
> diff --git a/board/freescale/mx23evk/mx23evk.c
> b/board/freescale/mx23evk/mx23evk.c
> index df4fb3912558..fbc8fbdbf593 100644
> --- a/board/freescale/mx23evk/mx23evk.c
> +++ b/board/freescale/mx23evk/mx23evk.c
> @@ -11,7 +11,6 @@
>   * on behalf of DENX Software Engineering GmbH
>   */
>=20
> -#include <common.h>
>  #include <init.h>
>  #include <asm/global_data.h>
>  #include <asm/gpio.h>
> diff --git a/board/freescale/mx23evk/spl_boot.c
> b/board/freescale/mx23evk/spl_boot.c
> index 14e9b4a8634f..a4c39a352219 100644
> --- a/board/freescale/mx23evk/spl_boot.c
> +++ b/board/freescale/mx23evk/spl_boot.c
> @@ -6,7 +6,6 @@
>   * on behalf of DENX Software Engineering GmbH
>   */
>=20
> -#include <common.h>
>  #include <config.h>
>  #include <asm/io.h>
>  #include <asm/arch/iomux-mx23.h>
> diff --git a/board/freescale/mx28evk/iomux.c
> b/board/freescale/mx28evk/iomux.c
> index cc0c85885446..b84b045bd1f5 100644
> --- a/board/freescale/mx28evk/iomux.c
> +++ b/board/freescale/mx28evk/iomux.c
> @@ -6,7 +6,6 @@
>   * on behalf of DENX Software Engineering GmbH
>   */
>=20
> -#include <common.h>
>  #include <config.h>
>  #include <asm/io.h>
>  #include <asm/arch/iomux-mx28.h>
> diff --git a/board/freescale/mx28evk/mx28evk.c
> b/board/freescale/mx28evk/mx28evk.c
> index 88c3bf36089c..ada572912dad 100644
> --- a/board/freescale/mx28evk/mx28evk.c
> +++ b/board/freescale/mx28evk/mx28evk.c
> @@ -11,7 +11,6 @@
>   * on behalf of DENX Software Engineering GmbH
>   */
>=20
> -#include <common.h>
>  #include <init.h>
>  #include <net.h>
>  #include <asm/global_data.h>
> diff --git a/board/freescale/mx51evk/mx51evk.c
> b/board/freescale/mx51evk/mx51evk.c
> index 95edb3599443..694568423026 100644
> --- a/board/freescale/mx51evk/mx51evk.c
> +++ b/board/freescale/mx51evk/mx51evk.c
> @@ -3,7 +3,7 @@
>   * (C) Copyright 2009 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <init.h>
>  #include <asm/global_data.h>
>  #include <asm/io.h>
> diff --git a/board/freescale/mx53loco/mx53loco.c
> b/board/freescale/mx53loco/mx53loco.c
> index d418cd8f4c0d..2d8f5da9906f 100644
> --- a/board/freescale/mx53loco/mx53loco.c
> +++ b/board/freescale/mx53loco/mx53loco.c
> @@ -4,7 +4,7 @@
>   * Jason Liu <r64343@freescale.com>
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <init.h>
>  #include <log.h>
>  #include <asm/global_data.h>
> diff --git a/board/freescale/mx6memcal/mx6memcal.c
> b/board/freescale/mx6memcal/mx6memcal.c
> index 0dfd7dec9efb..17095c34e926 100644
> --- a/board/freescale/mx6memcal/mx6memcal.c
> +++ b/board/freescale/mx6memcal/mx6memcal.c
> @@ -7,7 +7,6 @@
>   * Author: Eric Nelson <eric@nelint.com>
>   */
>=20
> -#include <common.h>
>  #include <init.h>
>  #include <asm/arch/sys_proto.h>
>  #include <asm/global_data.h>
> diff --git a/board/freescale/mx6memcal/spl.c
> b/board/freescale/mx6memcal/spl.c
> index 61d0ca3408f0..bc9c4259f07b 100644
> --- a/board/freescale/mx6memcal/spl.c
> +++ b/board/freescale/mx6memcal/spl.c
> @@ -4,7 +4,6 @@
>   * Author: Eric Nelson <eric@nelint.com>
>   */
>=20
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <init.h>
>  #include <asm/global_data.h>
> diff --git a/board/freescale/mx6sabreauto/mx6sabreauto.c
> b/board/freescale/mx6sabreauto/mx6sabreauto.c
> index 77e92006131a..e782543c0fae 100644
> --- a/board/freescale/mx6sabreauto/mx6sabreauto.c
> +++ b/board/freescale/mx6sabreauto/mx6sabreauto.c
> @@ -5,7 +5,6 @@
>   * Author: Fabio Estevam <fabio.estevam@freescale.com>
>   */
>=20
> -#include <common.h>
>  #include <image.h>
>  #include <init.h>
>  #include <net.h>
> diff --git a/board/freescale/mx6slevk/mx6slevk.c
> b/board/freescale/mx6slevk/mx6slevk.c
> index e9ac57118b01..d37d8a4136f6 100644
> --- a/board/freescale/mx6slevk/mx6slevk.c
> +++ b/board/freescale/mx6slevk/mx6slevk.c
> @@ -21,7 +21,6 @@
>  #include <asm/io.h>
>  #include <asm/sections.h>
>  #include <linux/sizes.h>
> -#include <common.h>
>  #include <fsl_esdhc_imx.h>
>  #include <i2c.h>
>  #include <mmc.h>
> diff --git a/board/freescale/mx6sllevk/mx6sllevk.c
> b/board/freescale/mx6sllevk/mx6sllevk.c
> index 10a00095affb..7114444fc3e6 100644
> --- a/board/freescale/mx6sllevk/mx6sllevk.c
> +++ b/board/freescale/mx6sllevk/mx6sllevk.c
> @@ -15,7 +15,6 @@
>  #include <asm/mach-imx/iomux-v3.h>
>  #include <asm/mach-imx/boot_mode.h>
>  #include <asm/io.h>
> -#include <common.h>
>  #include <linux/sizes.h>
>  #include <mmc.h>
>  #include <power/pmic.h>
> diff --git a/board/freescale/mx6sxsabreauto/mx6sxsabreauto.c
> b/board/freescale/mx6sxsabreauto/mx6sxsabreauto.c
> index 84cc51e9cac7..6176f7382389 100644
> --- a/board/freescale/mx6sxsabreauto/mx6sxsabreauto.c
> +++ b/board/freescale/mx6sxsabreauto/mx6sxsabreauto.c
> @@ -20,7 +20,7 @@
>  #include <asm/io.h>
>  #include <linux/delay.h>
>  #include <linux/sizes.h>
> -#include <common.h>
> +#include <config.h>
>  #include <fsl_esdhc_imx.h>
>  #include <miiphy.h>
>  #include <netdev.h>
> diff --git a/board/freescale/mx6sxsabresd/mx6sxsabresd.c
> b/board/freescale/mx6sxsabresd/mx6sxsabresd.c
> index e7958df40243..e3353feec688 100644
> --- a/board/freescale/mx6sxsabresd/mx6sxsabresd.c
> +++ b/board/freescale/mx6sxsabresd/mx6sxsabresd.c
> @@ -21,7 +21,6 @@
>  #include <env.h>
>  #include <linux/delay.h>
>  #include <linux/sizes.h>
> -#include <common.h>
>  #include <fsl_esdhc_imx.h>
>  #include <mmc.h>
>  #include <i2c.h>
> diff --git a/board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c
> b/board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c
> index 534b16cec7ae..6b0665a1067f 100644
> --- a/board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c
> +++ b/board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c
> @@ -19,7 +19,7 @@
>  #include <asm/mach-imx/mxc_i2c.h>
>  #include <asm/io.h>
>  #include <asm/sections.h>
> -#include <common.h>
> +#include <config.h>
>  #include <env.h>
>  #include <fsl_esdhc_imx.h>
>  #include <i2c.h>
> diff --git a/board/freescale/mx6ullevk/mx6ullevk.c
> b/board/freescale/mx6ullevk/mx6ullevk.c
> index de45f8b1d24b..189eddefea3f 100644
> --- a/board/freescale/mx6ullevk/mx6ullevk.c
> +++ b/board/freescale/mx6ullevk/mx6ullevk.c
> @@ -15,7 +15,7 @@
>  #include <asm/mach-imx/iomux-v3.h>
>  #include <asm/mach-imx/boot_mode.h>
>  #include <asm/io.h>
> -#include <common.h>
> +#include <config.h>
>  #include <env.h>
>  #include <fsl_esdhc_imx.h>
>  #include <linux/sizes.h>
> diff --git a/board/freescale/mx7dsabresd/mx7dsabresd.c
> b/board/freescale/mx7dsabresd/mx7dsabresd.c
> index 4fe23b51cd1b..3db167c0dad3 100644
> --- a/board/freescale/mx7dsabresd/mx7dsabresd.c
> +++ b/board/freescale/mx7dsabresd/mx7dsabresd.c
> @@ -15,7 +15,6 @@
>  #include <asm/io.h>
>  #include <linux/delay.h>
>  #include <linux/sizes.h>
> -#include <common.h>
>  #include <fsl_esdhc_imx.h>
>  #include <mmc.h>
>  #include <miiphy.h>
> diff --git a/board/freescale/mx7ulp_evk/mx7ulp_evk.c
> b/board/freescale/mx7ulp_evk/mx7ulp_evk.c
> index 01e32136532d..af68e57854e2 100644
> --- a/board/freescale/mx7ulp_evk/mx7ulp_evk.c
> +++ b/board/freescale/mx7ulp_evk/mx7ulp_evk.c
> @@ -3,7 +3,6 @@
>   * Copyright (C) 2016 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <fdt_support.h>
>  #include <init.h>
>  #include <asm/global_data.h>
> diff --git a/board/freescale/p1010rdb/ddr.c
> b/board/freescale/p1010rdb/ddr.c
> index b423ec8e218a..43a0936bc9af 100644
> --- a/board/freescale/p1010rdb/ddr.c
> +++ b/board/freescale/p1010rdb/ddr.c
> @@ -3,7 +3,6 @@
>   * Copyright 2010-2011 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <vsprintf.h>
>  #include <asm/global_data.h>
>  #include <asm/mmu.h>
> diff --git a/board/freescale/p1010rdb/law.c
> b/board/freescale/p1010rdb/law.c
> index 13fc2fa2e38c..a7d80f285211 100644
> --- a/board/freescale/p1010rdb/law.c
> +++ b/board/freescale/p1010rdb/law.c
> @@ -3,7 +3,7 @@
>   * Copyright 2010-2011 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/fsl_law.h>
>  #include <asm/mmu.h>
>=20
> diff --git a/board/freescale/p1010rdb/p1010rdb.c
> b/board/freescale/p1010rdb/p1010rdb.c
> index d32274b24812..ab0031440ae8 100644
> --- a/board/freescale/p1010rdb/p1010rdb.c
> +++ b/board/freescale/p1010rdb/p1010rdb.c
> @@ -4,7 +4,7 @@
>   * Copyright 2020 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <command.h>
>  #include <image.h>
>  #include <init.h>
> diff --git a/board/freescale/p1010rdb/spl.c b/board/freescale/p1010rdb/sp=
l.c
> index e450f626e0ad..fc26cef2cc8e 100644
> --- a/board/freescale/p1010rdb/spl.c
> +++ b/board/freescale/p1010rdb/spl.c
> @@ -2,7 +2,7 @@
>  /* Copyright 2013 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <console.h>
>  #include <env.h>
> diff --git a/board/freescale/p1010rdb/spl_minimal.c
> b/board/freescale/p1010rdb/spl_minimal.c
> index 8f0dec4c0ab7..8cd79c6fb5f6 100644
> --- a/board/freescale/p1010rdb/spl_minimal.c
> +++ b/board/freescale/p1010rdb/spl_minimal.c
> @@ -2,7 +2,7 @@
>  /*
>   * Copyright 2011 Freescale Semiconductor, Inc.
>   */
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <init.h>
>  #include <mpc85xx.h>
> diff --git a/board/freescale/p1010rdb/tlb.c b/board/freescale/p1010rdb/tl=
b.c
> index 265cde81a3c2..44acebaa2bbd 100644
> --- a/board/freescale/p1010rdb/tlb.c
> +++ b/board/freescale/p1010rdb/tlb.c
> @@ -3,8 +3,9 @@
>   * Copyright 2010-2011 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/mmu.h>
> +#include <asm/ppc.h>
>=20
>  struct fsl_e_tlb_entry tlb_table[] =3D {
>  	/* TLB 0 - for temp stack in cache */
> diff --git a/board/freescale/p1_p2_rdb_pc/ddr.c
> b/board/freescale/p1_p2_rdb_pc/ddr.c
> index 5f16779abaad..8622a5a610a5 100644
> --- a/board/freescale/p1_p2_rdb_pc/ddr.c
> +++ b/board/freescale/p1_p2_rdb_pc/ddr.c
> @@ -3,11 +3,12 @@
>   * Copyright 2010-2011 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <vsprintf.h>
> +#include <linux/string.h>
>  #include <asm/mmu.h>
>  #include <asm/immap_85xx.h>
> -#include <asm/processor.h>
> +#include <asm/ppc.h>
>  #include <fsl_ddr_sdram.h>
>  #include <fsl_ddr_dimm_params.h>
>  #include <asm/io.h>
> diff --git a/board/freescale/p1_p2_rdb_pc/law.c
> b/board/freescale/p1_p2_rdb_pc/law.c
> index 6085984eab43..49594070b836 100644
> --- a/board/freescale/p1_p2_rdb_pc/law.c
> +++ b/board/freescale/p1_p2_rdb_pc/law.c
> @@ -3,7 +3,7 @@
>   * Copyright 2010-2011 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/fsl_law.h>
>  #include <asm/mmu.h>
>=20
> diff --git a/board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c
> b/board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c
> index 602b7f0156ba..399ff7207229 100644
> --- a/board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c
> +++ b/board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c
> @@ -4,7 +4,7 @@
>   * Copyright 2020 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <command.h>
>  #include <env.h>
>  #include <hang.h>
> diff --git a/board/freescale/p1_p2_rdb_pc/spl.c
> b/board/freescale/p1_p2_rdb_pc/spl.c
> index 6c3f82849e3a..b07f481fbf9d 100644
> --- a/board/freescale/p1_p2_rdb_pc/spl.c
> +++ b/board/freescale/p1_p2_rdb_pc/spl.c
> @@ -3,7 +3,7 @@
>   * Copyright 2013 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <console.h>
>  #include <env.h>
> diff --git a/board/freescale/p1_p2_rdb_pc/spl_minimal.c
> b/board/freescale/p1_p2_rdb_pc/spl_minimal.c
> index f9e0b5b25ab7..511bcf5506b4 100644
> --- a/board/freescale/p1_p2_rdb_pc/spl_minimal.c
> +++ b/board/freescale/p1_p2_rdb_pc/spl_minimal.c
> @@ -3,7 +3,7 @@
>   * Copyright 2011 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <init.h>
>  #include <ns16550.h>
> diff --git a/board/freescale/p1_p2_rdb_pc/tlb.c
> b/board/freescale/p1_p2_rdb_pc/tlb.c
> index 94773969e9d8..ae0b7adbe544 100644
> --- a/board/freescale/p1_p2_rdb_pc/tlb.c
> +++ b/board/freescale/p1_p2_rdb_pc/tlb.c
> @@ -3,8 +3,9 @@
>   * Copyright 2010-2011 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/mmu.h>
> +#include <asm/ppc.h>
>=20
>  struct fsl_e_tlb_entry tlb_table[] =3D {
>  	/* TLB 0 - for temp stack in cache */
> diff --git a/board/freescale/p2041rdb/cpld.c
> b/board/freescale/p2041rdb/cpld.c
> index a1908b8a5712..915a8b994d5c 100644
> --- a/board/freescale/p2041rdb/cpld.c
> +++ b/board/freescale/p2041rdb/cpld.c
> @@ -11,7 +11,6 @@
>   * CPLD_BASE - The virtual address of the base of the CPLD register map
>   */
>=20
> -#include <common.h>
>  #include <command.h>
>  #include <asm/io.h>
>=20
> diff --git a/board/freescale/p2041rdb/ddr.c
> b/board/freescale/p2041rdb/ddr.c
> index 910058cefe16..b8b765a85ef5 100644
> --- a/board/freescale/p2041rdb/ddr.c
> +++ b/board/freescale/p2041rdb/ddr.c
> @@ -3,7 +3,6 @@
>   * Copyright 2011 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <i2c.h>
>  #include <hwconfig.h>
>  #include <init.h>
> diff --git a/board/freescale/p2041rdb/eth.c b/board/freescale/p2041rdb/et=
h.c
> index c0d05539c5c0..658508667776 100644
> --- a/board/freescale/p2041rdb/eth.c
> +++ b/board/freescale/p2041rdb/eth.c
> @@ -12,7 +12,7 @@
>   * and serdes protocol selection.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <net.h>
>  #include <netdev.h>
>  #include <asm/fsl_serdes.h>
> diff --git a/board/freescale/p2041rdb/p2041rdb.c
> b/board/freescale/p2041rdb/p2041rdb.c
> index 575259b19c03..d5b71f784303 100644
> --- a/board/freescale/p2041rdb/p2041rdb.c
> +++ b/board/freescale/p2041rdb/p2041rdb.c
> @@ -3,7 +3,7 @@
>   * Copyright 2011,2012 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <command.h>
>  #include <env.h>
> diff --git a/board/freescale/t102xrdb/cpld.c
> b/board/freescale/t102xrdb/cpld.c
> index 17a6226cafc7..cc933ccd5440 100644
> --- a/board/freescale/t102xrdb/cpld.c
> +++ b/board/freescale/t102xrdb/cpld.c
> @@ -7,7 +7,7 @@
>   * The following macros need to be defined:
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <command.h>
>  #include <asm/io.h>
>  #include "cpld.h"
> diff --git a/board/freescale/t102xrdb/ddr.c b/board/freescale/t102xrdb/dd=
r.c
> index 1b4173989925..f8d504fb3c73 100644
> --- a/board/freescale/t102xrdb/ddr.c
> +++ b/board/freescale/t102xrdb/ddr.c
> @@ -3,7 +3,7 @@
>   * Copyright 2014 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <i2c.h>
>  #include <hwconfig.h>
>  #include <init.h>
> diff --git a/board/freescale/t102xrdb/eth_t102xrdb.c
> b/board/freescale/t102xrdb/eth_t102xrdb.c
> index ad78f72f98c8..7185a0abd520 100644
> --- a/board/freescale/t102xrdb/eth_t102xrdb.c
> +++ b/board/freescale/t102xrdb/eth_t102xrdb.c
> @@ -5,7 +5,7 @@
>   * Shengzhou Liu <Shengzhou.Liu@freescale.com>
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <command.h>
>  #include <fdt_support.h>
>  #include <net.h>
> diff --git a/board/freescale/t102xrdb/law.c b/board/freescale/t102xrdb/la=
w.c
> index d636bef325f0..81caa961897a 100644
> --- a/board/freescale/t102xrdb/law.c
> +++ b/board/freescale/t102xrdb/law.c
> @@ -3,7 +3,7 @@
>   * Copyright 2014 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/fsl_law.h>
>  #include <asm/mmu.h>
>=20
> diff --git a/board/freescale/t102xrdb/spl.c b/board/freescale/t102xrdb/sp=
l.c
> index 9faf259af74d..de6cdda194e7 100644
> --- a/board/freescale/t102xrdb/spl.c
> +++ b/board/freescale/t102xrdb/spl.c
> @@ -2,7 +2,7 @@
>  /* Copyright 2014 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <console.h>
>  #include <env_internal.h>
> diff --git a/board/freescale/t102xrdb/t102xrdb.c
> b/board/freescale/t102xrdb/t102xrdb.c
> index 73f9d3ac72e7..0a29e27b42cd 100644
> --- a/board/freescale/t102xrdb/t102xrdb.c
> +++ b/board/freescale/t102xrdb/t102xrdb.c
> @@ -4,7 +4,7 @@
>   * Copyright 2020-2023 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <command.h>
>  #include <env.h>
>  #include <fdt_support.h>
> diff --git a/board/freescale/t102xrdb/tlb.c b/board/freescale/t102xrdb/tl=
b.c
> index 2519a9e4dbee..008bd6e72b7b 100644
> --- a/board/freescale/t102xrdb/tlb.c
> +++ b/board/freescale/t102xrdb/tlb.c
> @@ -3,8 +3,9 @@
>   * Copyright 2014 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/mmu.h>
> +#include <asm/ppc.h>
>=20
>  struct fsl_e_tlb_entry tlb_table[] =3D {
>  	/* TLB 0 - for temp stack in cache */
> diff --git a/board/freescale/t104xrdb/cpld.c
> b/board/freescale/t104xrdb/cpld.c
> index 9ac57bbd8300..c2d526ae15ac 100644
> --- a/board/freescale/t104xrdb/cpld.c
> +++ b/board/freescale/t104xrdb/cpld.c
> @@ -10,7 +10,7 @@
>   * CFG_SYS_CPLD_BASE-The virtual address of the base of the CPLD registe=
r
> map
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <command.h>
>  #include <asm/io.h>
>=20
> diff --git a/board/freescale/t104xrdb/ddr.c b/board/freescale/t104xrdb/dd=
r.c
> index 02ddb6614158..bab684860dad 100644
> --- a/board/freescale/t104xrdb/ddr.c
> +++ b/board/freescale/t104xrdb/ddr.c
> @@ -4,7 +4,7 @@
>   * Copyright 2021 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <i2c.h>
>  #include <hwconfig.h>
>  #include <init.h>
> diff --git a/board/freescale/t104xrdb/eth.c b/board/freescale/t104xrdb/et=
h.c
> index 5eca9386f6eb..d5c084e319d4 100644
> --- a/board/freescale/t104xrdb/eth.c
> +++ b/board/freescale/t104xrdb/eth.c
> @@ -3,7 +3,7 @@
>   * Copyright 2014 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <net.h>
>  #include <netdev.h>
>  #include <asm/fsl_serdes.h>
> diff --git a/board/freescale/t104xrdb/law.c b/board/freescale/t104xrdb/la=
w.c
> index a0d6eb5b2707..d34641c23970 100644
> --- a/board/freescale/t104xrdb/law.c
> +++ b/board/freescale/t104xrdb/law.c
> @@ -3,7 +3,7 @@
>   * Copyright 2013 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/fsl_law.h>
>  #include <asm/mmu.h>
>=20
> diff --git a/board/freescale/t104xrdb/spl.c b/board/freescale/t104xrdb/sp=
l.c
> index dd8283f3c60a..e02a1f95d4cb 100644
> --- a/board/freescale/t104xrdb/spl.c
> +++ b/board/freescale/t104xrdb/spl.c
> @@ -2,7 +2,7 @@
>  /* Copyright 2013 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <console.h>
>  #include <env_internal.h>
> diff --git a/board/freescale/t104xrdb/t104xrdb.c
> b/board/freescale/t104xrdb/t104xrdb.c
> index b30804927167..ef4dfef4965c 100644
> --- a/board/freescale/t104xrdb/t104xrdb.c
> +++ b/board/freescale/t104xrdb/t104xrdb.c
> @@ -4,7 +4,7 @@
>   * Copyright 2023 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <command.h>
>  #include <env.h>
>  #include <fdt_support.h>
> diff --git a/board/freescale/t104xrdb/tlb.c b/board/freescale/t104xrdb/tl=
b.c
> index 10be580b8136..24bc83f756bd 100644
> --- a/board/freescale/t104xrdb/tlb.c
> +++ b/board/freescale/t104xrdb/tlb.c
> @@ -3,8 +3,9 @@
>   * Copyright 2013 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/mmu.h>
> +#include <asm/ppc.h>
>=20
>  struct fsl_e_tlb_entry tlb_table[] =3D {
>  	/* TLB 0 - for temp stack in cache */
> diff --git a/board/freescale/t208xqds/ddr.c b/board/freescale/t208xqds/dd=
r.c
> index 56471b3988b9..9076fbba10af 100644
> --- a/board/freescale/t208xqds/ddr.c
> +++ b/board/freescale/t208xqds/ddr.c
> @@ -3,7 +3,6 @@
>   * Copyright 2013 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <i2c.h>
>  #include <hwconfig.h>
>  #include <init.h>
> diff --git a/board/freescale/t208xqds/eth_t208xqds.c
> b/board/freescale/t208xqds/eth_t208xqds.c
> index 569b193eab78..9f299227e295 100644
> --- a/board/freescale/t208xqds/eth_t208xqds.c
> +++ b/board/freescale/t208xqds/eth_t208xqds.c
> @@ -6,7 +6,7 @@
>   * Shengzhou Liu <Shengzhou.Liu@freescale.com>
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <command.h>
>  #include <fdt_support.h>
>  #include <log.h>
> diff --git a/board/freescale/t208xqds/law.c b/board/freescale/t208xqds/la=
w.c
> index 3cdd4937684e..287f4650e058 100644
> --- a/board/freescale/t208xqds/law.c
> +++ b/board/freescale/t208xqds/law.c
> @@ -6,7 +6,7 @@
>   * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/fsl_law.h>
>  #include <asm/mmu.h>
>=20
> diff --git a/board/freescale/t208xqds/spl.c b/board/freescale/t208xqds/sp=
l.c
> index 8866be54a661..44ad4e68d9f6 100644
> --- a/board/freescale/t208xqds/spl.c
> +++ b/board/freescale/t208xqds/spl.c
> @@ -2,7 +2,7 @@
>  /* Copyright 2013 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <console.h>
>  #include <env_internal.h>
> diff --git a/board/freescale/t208xqds/t208xqds.c
> b/board/freescale/t208xqds/t208xqds.c
> index 8be55e52e5f6..5e71da0e163f 100644
> --- a/board/freescale/t208xqds/t208xqds.c
> +++ b/board/freescale/t208xqds/t208xqds.c
> @@ -4,7 +4,7 @@
>   * Copyright 2020 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <command.h>
>  #include <env.h>
> diff --git a/board/freescale/t208xqds/tlb.c b/board/freescale/t208xqds/tl=
b.c
> index 3d220afc16e6..f99d51c8cd76 100644
> --- a/board/freescale/t208xqds/tlb.c
> +++ b/board/freescale/t208xqds/tlb.c
> @@ -6,8 +6,9 @@
>   * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/mmu.h>
> +#include <asm/ppc.h>
>=20
>  struct fsl_e_tlb_entry tlb_table[] =3D {
>  	/* TLB 0 - for temp stack in cache */
> diff --git a/board/freescale/t208xrdb/cpld.c
> b/board/freescale/t208xrdb/cpld.c
> index 933fa0decc31..d2226af62786 100644
> --- a/board/freescale/t208xrdb/cpld.c
> +++ b/board/freescale/t208xrdb/cpld.c
> @@ -5,8 +5,9 @@
>   * Freescale T2080RDB board-specific CPLD controlling supports.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <command.h>
> +#include <asm/io.h>
>  #include "cpld.h"
>=20
>  u8 cpld_read(unsigned int reg)
> diff --git a/board/freescale/t208xrdb/ddr.c b/board/freescale/t208xrdb/dd=
r.c
> index 1fbab36e1a20..fe98f62668a7 100644
> --- a/board/freescale/t208xrdb/ddr.c
> +++ b/board/freescale/t208xrdb/ddr.c
> @@ -3,7 +3,6 @@
>   * Copyright 2014 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <i2c.h>
>  #include <hwconfig.h>
>  #include <init.h>
> diff --git a/board/freescale/t208xrdb/eth_t208xrdb.c
> b/board/freescale/t208xrdb/eth_t208xrdb.c
> index e4592eac1530..5223eccb2804 100644
> --- a/board/freescale/t208xrdb/eth_t208xrdb.c
> +++ b/board/freescale/t208xrdb/eth_t208xrdb.c
> @@ -6,7 +6,6 @@
>   * Shengzhou Liu <Shengzhou.Liu@freescale.com>
>   */
>=20
> -#include <common.h>
>  #include <command.h>
>  #include <fdt_support.h>
>  #include <net.h>
> diff --git a/board/freescale/t208xrdb/law.c b/board/freescale/t208xrdb/la=
w.c
> index 53a13694506f..e1f570a89358 100644
> --- a/board/freescale/t208xrdb/law.c
> +++ b/board/freescale/t208xrdb/law.c
> @@ -6,7 +6,7 @@
>   * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/fsl_law.h>
>  #include <asm/mmu.h>
>=20
> diff --git a/board/freescale/t208xrdb/spl.c b/board/freescale/t208xrdb/sp=
l.c
> index 130cb8847c0f..df3b9c6fe405 100644
> --- a/board/freescale/t208xrdb/spl.c
> +++ b/board/freescale/t208xrdb/spl.c
> @@ -2,7 +2,7 @@
>  /* Copyright 2013 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <console.h>
>  #include <env_internal.h>
> diff --git a/board/freescale/t208xrdb/t208xrdb.c
> b/board/freescale/t208xrdb/t208xrdb.c
> index e33e5d082d80..d93edf007ad9 100644
> --- a/board/freescale/t208xrdb/t208xrdb.c
> +++ b/board/freescale/t208xrdb/t208xrdb.c
> @@ -4,7 +4,7 @@
>   * Copyright 2021-2023 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <command.h>
>  #include <env.h>
>  #include <fdt_support.h>
> diff --git a/board/freescale/t208xrdb/tlb.c b/board/freescale/t208xrdb/tl=
b.c
> index 688a208c621f..df5831541f38 100644
> --- a/board/freescale/t208xrdb/tlb.c
> +++ b/board/freescale/t208xrdb/tlb.c
> @@ -6,8 +6,9 @@
>   * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/mmu.h>
> +#include <asm/ppc.h>
>=20
>  struct fsl_e_tlb_entry tlb_table[] =3D {
>  	/* TLB 0 - for temp stack in cache */
> diff --git a/board/freescale/t4rdb/cpld.c b/board/freescale/t4rdb/cpld.c
> index 8b1012086ec7..cd14d5895f50 100644
> --- a/board/freescale/t4rdb/cpld.c
> +++ b/board/freescale/t4rdb/cpld.c
> @@ -14,7 +14,7 @@
>   *
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <command.h>
>  #include <asm/io.h>
>=20
> diff --git a/board/freescale/t4rdb/ddr.c b/board/freescale/t4rdb/ddr.c
> index 57cbde154f0e..5b60b50c672b 100644
> --- a/board/freescale/t4rdb/ddr.c
> +++ b/board/freescale/t4rdb/ddr.c
> @@ -3,7 +3,6 @@
>   * Copyright 2014 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <i2c.h>
>  #include <hwconfig.h>
>  #include <init.h>
> diff --git a/board/freescale/t4rdb/eth.c b/board/freescale/t4rdb/eth.c
> index 2e52543847bf..e7646365d7d4 100644
> --- a/board/freescale/t4rdb/eth.c
> +++ b/board/freescale/t4rdb/eth.c
> @@ -5,7 +5,7 @@
>   * Chunhe Lan <Chunhe.Lan@freescale.com>
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <command.h>
>  #include <fdt_support.h>
>  #include <net.h>
> diff --git a/board/freescale/t4rdb/law.c b/board/freescale/t4rdb/law.c
> index 43eeb884e2ff..c43ac0f30d74 100644
> --- a/board/freescale/t4rdb/law.c
> +++ b/board/freescale/t4rdb/law.c
> @@ -3,7 +3,7 @@
>   * Copyright 2014 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/fsl_law.h>
>  #include <asm/mmu.h>
>=20
> diff --git a/board/freescale/t4rdb/spl.c b/board/freescale/t4rdb/spl.c
> index 779457d29640..9d2472dec250 100644
> --- a/board/freescale/t4rdb/spl.c
> +++ b/board/freescale/t4rdb/spl.c
> @@ -5,7 +5,7 @@
>   * Author: Chunhe Lan <Chunhe.Lan@freescale.com>
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <clock_legacy.h>
>  #include <console.h>
>  #include <env_internal.h>
> diff --git a/board/freescale/t4rdb/t4240rdb.c
> b/board/freescale/t4rdb/t4240rdb.c
> index ab717769ed5c..5cacfd273803 100644
> --- a/board/freescale/t4rdb/t4240rdb.c
> +++ b/board/freescale/t4rdb/t4240rdb.c
> @@ -4,7 +4,7 @@
>   * Copyright 2023 NXP
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <command.h>
>  #include <env.h>
>  #include <fdt_support.h>
> diff --git a/board/freescale/t4rdb/tlb.c b/board/freescale/t4rdb/tlb.c
> index f5af893c2d9d..1fb9d41d52b1 100644
> --- a/board/freescale/t4rdb/tlb.c
> +++ b/board/freescale/t4rdb/tlb.c
> @@ -3,8 +3,9 @@
>   * Copyright 2014 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
> +#include <config.h>
>  #include <asm/mmu.h>
> +#include <asm/ppc.h>
>=20
>  struct fsl_e_tlb_entry tlb_table[] =3D {
>  	/* TLB 0 - for temp stack in cache */
> diff --git a/board/freescale/vf610twr/vf610twr.c
> b/board/freescale/vf610twr/vf610twr.c
> index 98cb0140ad02..80a798af9cb6 100644
> --- a/board/freescale/vf610twr/vf610twr.c
> +++ b/board/freescale/vf610twr/vf610twr.c
> @@ -3,7 +3,6 @@
>   * Copyright 2013 Freescale Semiconductor, Inc.
>   */
>=20
> -#include <common.h>
>  #include <init.h>
>  #include <asm/global_data.h>
>  #include <asm/io.h>
> --
> 2.34.1

