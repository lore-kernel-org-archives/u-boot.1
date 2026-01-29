Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AC2D46C01
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 03:25:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3524583B9D;
	Thu, 29 Jan 2026 04:25:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="QWdm7kiR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03DE983BDD; Thu, 29 Jan 2026 04:25:45 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2C7783B97
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 04:25:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Si5e7ddWt1MlcoL731XCTh9dZeG5JnGJTu1mjyTT94qnyJGlEEefE0Mzj8Y+Ad3F5a7L7bVEImq5oTvvUa4WhvAeQgAnuHAl1SXLExd/TWNAvx9MVQtXRpW7k4RcY3z5s1t0K0qGgbWbzx29qqtJUlnFqeO3ZqoZeyoqrU76bJREGqGNlR5c7gaWyjbvg8A0O2h7Ox1jh7NCWeXgisu5FZCfK+7EBDlctSPU1+jZqmRSgCitamoYTiaqfmy7aL0tvocKso4lWeOAYGAsDF2/WtwoUd71oxHHBtH1HH7OWxrAdGwOJv3vQ9bXVQb3IYNQeB7vzHtuIQQrGjihCDiO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O10P/LRoPcjxmTBOlS5bvjoUscRg+pAm6IgR68uz8Rc=;
 b=ZEPKZaO16oE4F5QH/XYf9/Y2WdWyaFUKBb8yS1/cUqenH1xox5Kwqjb6fRFbXxomyhJBR5iG101sAC/AWOkqtPkuumy0OJ/Q1dKNPNcVdG/Wv9Z4u0hGemok91OODtdVcXgB0LpG7II5rCIU6qPbHA/Epu1Lfde/YHntjUmK1LrH0uJ4MqAqVHG5ld0JLpANOC2v49MQ3MWdwBVOotm9flloDgsxOUggrnq1XiJaX8mXQDhWJSjFpAmOyS3hp2NJUu5u3bZg0S1ehPFc5rR3bwCXGgKsmBoEWrHNfDNr87gFxUyiIUUASZVZhyGe8D8ljTSoqEAY6bDpjy6ERzVwfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O10P/LRoPcjxmTBOlS5bvjoUscRg+pAm6IgR68uz8Rc=;
 b=QWdm7kiRWt8yFc7484e4E3BgE49lzF5g2rGG/IXbdRuF+rpzezltKmYFoXsi8hyTJTExkqkjyI3APWUWMPblU7mLgp1JjPI4JxuOjsK2Sfo1CsG7JqDx4ixkR5w1Mhrn2guKiq8OLIbxun+mZDO4G/mfxGDOrVT0ViAEJ6DLFwXSktbdlvNviUEod72Rc7uM9tJkEFX3GUpJfqdY1kr8+vZ+uVMWbFl8Wd/NCtr4dtCwCwXAXrNDZLYzfBmhOcHq4D+8qYgb4Ju1CqnQi/vhjzokTDOU6Kkv1bAOUOWj/qbqZfG6a2Yl5xH1X581ZCyKWUkbe49xsjR4J5ByfOdDUg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB9928.eurprd04.prod.outlook.com (2603:10a6:150:117::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Thu, 29 Jan
 2026 03:25:41 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 03:25:41 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Mateus Lima Alves <mateuslima.ti@gmail.com>
Subject: RE: [PATCH] misc: Keep FSL_IFC available on PowerPC as well
Thread-Topic: [PATCH] misc: Keep FSL_IFC available on PowerPC as well
Thread-Index: AQHckIv9In+X9wLO8Ue46g+NoKMwSrVofGpw
Date: Thu, 29 Jan 2026 03:25:41 +0000
Message-ID: <PAXPR04MB8459F4847B32CECD8E039101889EA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260128192617.1724570-1-trini@konsulko.com>
In-Reply-To: <20260128192617.1724570-1-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GVXPR04MB9928:EE_
x-ms-office365-filtering-correlation-id: 35e90471-ec58-48d0-4eb5-08de5ee61476
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?MaRw0Imc51ibs7mELaGI0cfGu3NV6CxVzVqrkJaj2m/mgUpwHjhmIkmFfMol?=
 =?us-ascii?Q?QZ5aPdK3CokMQdq8GvlGUbnItSDf8LnmR4CovqrrXyHcrLGuVdg37/tCLTnh?=
 =?us-ascii?Q?30PXnJVDF8NJ1S/tTxp96ldQztezdbdapS+Uc0fTQtOLK5wSMStw6VG1oOXV?=
 =?us-ascii?Q?Hxhz2eduI436QuZkEeQxPYP1279t7xu9uocwzLwymEwlaGXYgt02n0I2GnSo?=
 =?us-ascii?Q?bkW7o4N2afG4WqBXDw1JNpmrtW1jwIsWJ4QFBDEzPW5xCVeRiG21/B+ydpOj?=
 =?us-ascii?Q?/l7jIqFtuzSGsVxWz6L4AQ9tBfWg07bijpqQfaRATcRvopavCiygMoNj6PJW?=
 =?us-ascii?Q?cjzcJ8P8QpHyZFCO3bxdQgVzg3Ac7GHTeHurEKajvZiQ4asENQ9xq19lzRJ+?=
 =?us-ascii?Q?rVO5qsUacG/BAZ732PlQPA7WOTO+TJ1NnShkPBhxtDr+cQ87PzfGbn6X4k6j?=
 =?us-ascii?Q?VjhigBlPqmm4/m34X/qTKCQN1K/SlN0T1efNp2cCyx18G3moL15DAj2myVkP?=
 =?us-ascii?Q?ewAvCCzIKM2nvE9ipGKmB0X33C6aOSr3AL8/2NbKtyogsS7S09TMtZA6m/AA?=
 =?us-ascii?Q?vcvmA9KcV+F8T26IzkCRPiOm4CmOQJvH6LemnEZl4Rsgu182DRN9Pa4sj5T7?=
 =?us-ascii?Q?Pc0/Og4LyqHVfeDDOeVZ8+Y8vDSY/3FYriORd3nL3UHq8k+3mKxBtUnCQMzY?=
 =?us-ascii?Q?gvYI9zcrGRjwd6UfJxSnadUkc9wf00PbRDAuDCpugcIBFabxq3VTkn+etB17?=
 =?us-ascii?Q?YTnDy/QKhUSAhthHKMCFE52zdSgEfU2xt5PGwEp3unSrq3bWSKpHM2ZKNad8?=
 =?us-ascii?Q?Lp+vVn/njeZzSYLbFIqfUBY1PJrEIPlTnTzky19+LK6wisxS5mxI/y/0RogI?=
 =?us-ascii?Q?KHq0ugqhJaJP8WfzkDWmOOUm2GLijJd0S+fuTQMlf3/GQEaXj34Ql+N+DuYM?=
 =?us-ascii?Q?oIiMW4tf39r5LEt3cXiJUZWKMxxelYONdukg1wPgm78SzG0P+t1KgsfM2uzx?=
 =?us-ascii?Q?KG2HBaGR8LRHVTvjx3tZROyGM9sZP8h0/wOAr5tUshGMYChI+zE6gGOiuwq2?=
 =?us-ascii?Q?oE/+I0DFSQ+CfE5Iaz9n53A6UiV4EgQRif55oYu9dFo546pD2I2zUKFzKonv?=
 =?us-ascii?Q?Fw40g7SvaJaYEdB9Qa3eHSJSiwAWx3bRPMg0V/5ZPIQKxWadBz5fuXHUs594?=
 =?us-ascii?Q?pGSZVrqjFm2RAAmEIOK1OVzM45MZsnvxCAobhOfr6jpvoKOdGnBR/nKRkB68?=
 =?us-ascii?Q?CKCT6I6MX5Twa5fiRiKZtem5XNp0VbgJbFhFOSQ62qH88zscPs2W+fLLVKdz?=
 =?us-ascii?Q?6V1zHfL6gBw7zJvvWsauT+dEbiSZZiaKp347JVp2TAoRkt1I5q6OOcZ348yz?=
 =?us-ascii?Q?6QjbNm2VtqhkOfjeRYJh4u3ZIpPoz+COE25rapQKqlJYW4+PaESga+AkFoKH?=
 =?us-ascii?Q?1RBGI/D6uUVBqwMBfjyk8n/4n8l68vSzEHGxJlIcrZtBSGAYeFgN4j0QVtCO?=
 =?us-ascii?Q?18AXdvwY9tBm4HkLjn8KX5FwPoUE4uwdqymAlm7Kt4AwdvRnN19UPREIjG/f?=
 =?us-ascii?Q?wxwgxPyCtCnDldk6u4F6jbYs+ysFEtBA3/htDs9frN6u7QYqGsKQ1+fgoVY6?=
 =?us-ascii?Q?Sfrnp+4I9AToncJ+NbQUfVk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pFwQjDT8SBk8Gz03swr8CHxam9OTPTXEsP2fawnkw8shZezM28cbcJvAMsCM?=
 =?us-ascii?Q?Ohne1eIvki07Lkghr4QEX4zNoGxOCPo1dVbzznB1kx4itZjTmfV0Op9EWJWM?=
 =?us-ascii?Q?jy+Uy50pJZ9GGN9xVP/DtJGJYT7lhZvV9uizaGixwwYxZoBXj26z30HYm5Oq?=
 =?us-ascii?Q?JDMHRwG9SiY4cPTuLhECZmMX91gefUKG5zDts7z88d7I+Wxhc1ha4hFLfUxN?=
 =?us-ascii?Q?WRzmeJl5RnDZeTVt2mJAjuWmtVtbkVA0AEeuEnjtXVMg7oZypuLv9kARQsx/?=
 =?us-ascii?Q?Q5Gqh2mPPk82bAJcyvX1vn+y/FAElSZFlbtJBcyjl+i+iTj5XCDPDwg6IcxN?=
 =?us-ascii?Q?ad7TkB8qlVncCLWlLuhrh5EgE9SdOSG3MIOMhKbj9yjKgJkDUJ2qqXNv0Myk?=
 =?us-ascii?Q?Mtf5CkHFWwlyt9FgzBQ8f2fQiziJKhwAhAV592BwVSVducXk88HkbvcU1VNB?=
 =?us-ascii?Q?ar24SMNdG8gBpaX/OVxLOOqepNVLyyEW4xFMrpeZ6bwtfvF6/qLDscc5fDGq?=
 =?us-ascii?Q?QFHJDaLDKnCDdP2f5mKmej6utclLJ8Vm99A8UGgGqT8Y7l/I2bTR3X/4jvDV?=
 =?us-ascii?Q?aiqWRzZv2x1hkc5d8xSauBhfWWhTglrBxTU9P+KJTvlrZ2wixJOguFlH17C4?=
 =?us-ascii?Q?8mb3F0dgfHZg+gYcfdO3taRJEo3XXuSgRgab+XdW1+b0Kkyxcse2NVWQn58E?=
 =?us-ascii?Q?d9mwcYGeGoLygwgigGO811+8R/m0AZlnHOB+cgc6gJCy57G7shJdyo0TLFRa?=
 =?us-ascii?Q?Dzd3ZZHRtGwi2LIL0veNEN5SrNMdwB2TDV3z8N6Yp5/QZNTI9nLyB2OHmC+t?=
 =?us-ascii?Q?SmOykv6ZL2ydbu8MSmjEd5r1dGfxraxYk3W5AGKTgF5fzwgX+iHBzQ8wPdr1?=
 =?us-ascii?Q?n+TUWBX+J4UqXTWR//JEgvwC7cYvblPnOVT9sSjtxukBTRvvDcsCxHcNIppS?=
 =?us-ascii?Q?+8hVlVYAt2vIC7oCne23m9DqIsPy/WVpS/6Duoc5m0gxfxJUsDdxA1IDJdwX?=
 =?us-ascii?Q?s5cHGNEJOfDKhXIqBeEAdRC1UDukJAErSIub8hvL47bcrg98dFJ+IkrRbbCe?=
 =?us-ascii?Q?PiG8hET6+stl0riQogwxMdOM340lwhT5BwqaK/drBRXsJ8+QTnv+Gg9tToNY?=
 =?us-ascii?Q?NYT7zdiL6RTV1gCTThlfrVr34AbCwFLOiTc6QNfQkdcXRUp7/XPsEoRXNGSv?=
 =?us-ascii?Q?e78ugVFjrC6hpeWi5enfpn9t4f+nEiDpG1PKrRqABGhi1pKdgL4tIx0EQZ+Q?=
 =?us-ascii?Q?myGkxYwI8AQgQYb+zZFPxd8iYfbw+JyfUpPok9zyHzvzAkQWKJPk42hWLJ+T?=
 =?us-ascii?Q?DkV6oVSju27lz3vv8sIw+qWoUehDFWxjFNWxxScLJcP4Ufoc1TpyUnLGuvQs?=
 =?us-ascii?Q?YmG2PpfU0Ubkns9dg6te2CkAkaPDeOR4UFuOk2gZ3IzeKBh1I+Qtkib/LdV2?=
 =?us-ascii?Q?O+EVEOrZ2RN6j/OdXB29Ab/Te3npI3E1axjqTDH8J0gKtU8oePxGosMo+dJc?=
 =?us-ascii?Q?/Ut0gGrix+PPbpLGOix4d51+nqAqawnWGPDXOimjutG30mgk3hgQSKamWuRI?=
 =?us-ascii?Q?VUhlZPuz0ZyPr1xwikGZ1IAUMewYS5oAEJAF7/YBiA2UCLHuGxaUzSteuXzw?=
 =?us-ascii?Q?CKTUVlTOljJCq50/pFbxXElMP9tm+kd7P6O7pfcE7lEEAcVQpVG4S4oS/e7A?=
 =?us-ascii?Q?FA+sjKXssOS+5tdZD+YwGypH8FUxVqWyxPBWomg7YnkpjKE0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e90471-ec58-48d0-4eb5-08de5ee61476
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 03:25:41.1066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +tKulu1VFUOPr4W8R3yz+//XkGaDJU311Qy8/KucKjnLQWrr9hFVVw8vNqCWDwzcc4I24kjQM/yNNebmiD03sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9928
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

> Subject: [PATCH] misc: Keep FSL_IFC available on PowerPC as well
>=20
> This symbol is used on a number of PowerPC platforms as well, so
> make it available there again.
>=20
> Fixes: 424b324165ea ("armv7: Add CPLD support via IFC to the
> ls1021a-iot board.")
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by: Peng Fan <peng.fan@nxp.com>

Tom, I not have patches for fsl-qoirq queue. Would you
please directly pick up?

Thanks
Peng.

> ---
> Cc: Mateus Lima Alves <mateuslima.ti@gmail.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/misc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig index
> be7fdab56d14..a0aa290480eb 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -695,7 +695,7 @@ config ESM_PMIC
>=20
>  config FSL_IFC
>  	bool "Freescale Integrated Flash Controller"
> -	depends on ARM
> +	depends on ARM || PPC
>  	help
>  	  This driver is for the Integrated Flash Controller(IFC) module
>  	  available in Freescale SoCs. This controller allows to handle
> --
> 2.43.0

