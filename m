Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA54CCFA10
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 08:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 108AE82A9E;
	Tue,  4 Nov 2025 09:34:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Wxug10v0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D3B8836D1; Tue,  4 Nov 2025 09:34:11 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAD118144A
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 09:34:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFUAvOcptwmHD37n9IKh1/OFy9JL1drk/2TQlHRslacO4k8u7v3rUtQ2z6CzHbuEMfutzbXKDVJ2Bh8Kq0Jo3KaMt4WbfRXn1Bi0AM4y55OxEfAB7RL97Zk1hzUuqxe4ZwLq+xEF/kpw+kV1GJEh/Gg4d9o8nJ4JxoWJJDWHHL8ZyVS3e1IgDlWuZLXlCIyHQzKTk7+BsS/XX6121icl+JtZ+V3anJjibukxyDqRH0rLoKTn+rbVUst2J6z0z+1Tc0TDJTxA83RTv/IWKw0CvWqCDK2NGqadAhfFCroMn4Q0VKZX9neZz9iVAXSjynz7d2Wc1MJfSE8asEKkUwnTsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qLvzf6KdQ8psWCyyrozlKiLEs/MhQlIKKr7b3wSlhE=;
 b=QDo4478P4505wtbcsXIO/LUj5YeTjZhtYviKhfsatYMueLGDhQUU/nQiNxjuU9mEKQUGWSxjm/wSeZrymCclMInWXMJfLP284egrR+8qEu/3Y1N1xJX4uWH2xFmrqxpl1a8fio3w8P6kwN6+jBkVMA9DXtE4Rk2txubSYfhT+yk3dpTEQSqyUf0H8lJVaB5r82/OdP0GjGT1tTVWCWZPjantQnajSDbR88/B0DAswYIDrwsMETOu/JQmL18oXTfyNuEtprpOZxEI+So3YeX9Zh0vwl3ZhHBASD9ckXSgeDrKlrd3bEX6uKGZBZ4I8c9UIRLJiRSORELheTezro6teg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qLvzf6KdQ8psWCyyrozlKiLEs/MhQlIKKr7b3wSlhE=;
 b=Wxug10v0MAZHNdbjPy+Pt49esnA3J2x+3EUpp8HPLcLVqj2OnkymEUqs8qlkzZVFH+YqYAXmOXuB8g5uYXWdeKqXlAu4wc4zGeXXMbVsehwNgUyHEQnlhrNm1kOgIOIfq25D2L6ZEN2DR06LEt0BszfqlVTzSUhdZScD88zui2UCLI+EJcQQLA96uHYP1n4KvVnPr0Wq47pe5ekKvyx/4Bgb2Ps6INhoyHZB7cEMGcXXQn/dlOAjwJCQrWKx0gc7Nxtu3qketm7LbZXW47kWZyz3Pic60XlzzeNdRHHvgdi/rbSn0EtejtgyjQwUKUsrkQ7MOndUDHYDlAo5GUKskQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8813.eurprd04.prod.outlook.com (2603:10a6:102:20c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 08:34:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 08:34:07 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Christoph Stoidner <c.stoidner@phytec.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Christoph Stoidner <c.stoidner@phytec.de>, Jaehoon Chung
 <jh80.chung@samsung.com>
Subject: RE: [PATCH] mmc: Fix missing 1 ms delay after mmc power up
Thread-Topic: [PATCH] mmc: Fix missing 1 ms delay after mmc power up
Thread-Index: AQHcSnca+pX6DLYxQU2JKGBWrFetBLTiNiWg
Date: Tue, 4 Nov 2025 08:34:06 +0000
Message-ID: <PAXPR04MB84594BDB0690A1C0285F90A588C4A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251031145951.535376-1-c.stoidner@phytec.de>
In-Reply-To: <20251031145951.535376-1-c.stoidner@phytec.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB8813:EE_
x-ms-office365-filtering-correlation-id: 281b2e1f-bbc5-4091-7b67-08de1b7ceb41
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3Rt7rMK2HEJx+Ud7XCYoj95a+/xypXNUQ89KGMAOKp6AN6ivnqG9UbzP/Hrc?=
 =?us-ascii?Q?RNkrkv7beD8x3o14+wOU/CTUKxcYU4NQNR9KG0Kf4nyMHVwAf/Fzy7L/RuPl?=
 =?us-ascii?Q?8q2miewAhM4lBRX9r8ZoSU8lxU5x9zZxQGyj3pSW2iYheVWcWtQn73YPBjoP?=
 =?us-ascii?Q?Ijt9g1a6seLgtC1S3Dc6xx4aSFYWJqDO96w85w3br/XxD7XdsHN+Kf0zrLUq?=
 =?us-ascii?Q?9UbNzC452ylBcd6Tc3kK/oE8y7V6MewuDiXkDODC2gTHy/y+KTngSuIEGE+M?=
 =?us-ascii?Q?kUdTq7YOzO9zTTM6Azkarc0T+Z7HbmJN+wj2DRD7iRIWc1Jp054Jk2K/VrcA?=
 =?us-ascii?Q?UdVFQjW92OgV3jcfTBuxD5JyePf5oQOYQtg8PTNLvqs4baOOaorp7qmF7g53?=
 =?us-ascii?Q?1VaTGAv7LEmaG5mg80zG2OqtakBvxTiBDlZBkvUJdz5smw4UcFOBreQerkGu?=
 =?us-ascii?Q?N1ehtYOvOwnYrJcqn8FcnR3TAKVoulIR3bHLrZnB+m+9J+o0Z1WQbBoiz4UB?=
 =?us-ascii?Q?NDROkNV+hakp4jqzR4pnrv5QTMYd5tfxJ/jwaldHGpL0BDGN+U2L0E3gjIk9?=
 =?us-ascii?Q?e6KviFHBZKGN8e23OxrlloGQQNscoG7ut2CB2IHh5Z8BikkaDXIeenTx0enr?=
 =?us-ascii?Q?jHCtuypc6flBadO6uI38TIWBaRxcjmu7B5QmHFE5xHJPlT2k+8sG3iNMxwhf?=
 =?us-ascii?Q?fMQgxwis5Vx2JHjwWR37KtKwQPFVSL8N2G3MFaprvdULdfTNHDDOfyHkG1iv?=
 =?us-ascii?Q?uOFXVjotvG86N6WQ/PN63BswxusFHRF+2FgiISHnQo1xjRj6uG0sQtc45ij2?=
 =?us-ascii?Q?PGBCUHxDBjfzEgStCi8LKqTNt0VIibsqibLJg5D5s3/2GncIwwPoH/UrWp+V?=
 =?us-ascii?Q?UgftNCVLjaYfR9ViuqI/M4Iy5oc1LYSBV0jv/a0RO0LOCVsoqQMjWcqmAtDy?=
 =?us-ascii?Q?5TxVW0+1klrODFl2/Z/hA14DpsWXW6JuIjnH01CP1hBqLtva88kuJGXXc7dI?=
 =?us-ascii?Q?xvQSnMjaJaxbw0AI28uNx6ttPEnKMp5p4LzG8WYdrcKMG3SsAgCe/mFO35I2?=
 =?us-ascii?Q?hNgAAO8Hfy8vYrbWEvJmUDmrU7X5CHCctxUgwjW8XPdFh6hIBSBSAheSGBBS?=
 =?us-ascii?Q?h4rmuN9zE/KCSB58uJAft34gsVJfmTaU//oXXNC0M/Beb4qbRgQgxx3gv5xK?=
 =?us-ascii?Q?PyiHoTxjQkxnjRgUMn1d6pupq61XkqVIUbxEcVg5u3iyqUN0gdCq2oW/ySWn?=
 =?us-ascii?Q?mqcrPbp9o5sSEit3w2i4rK257gRwpm1g8eiXAT1qxchb6t2VwmOrYO7Wk032?=
 =?us-ascii?Q?ptYdinkwAF6DlPHk2fDhzE9fxWa0EBBZzRxoNYCqR7dNAxVpY41vQvd6E9dB?=
 =?us-ascii?Q?x6OaG+AFxT/XywnxuoLmdtcS9zibcq4TL7nQaDMuJLpQh2afG5LlF+7SMMCZ?=
 =?us-ascii?Q?s/RYbhgLFysbFP9tfCHehgiO1pVlHlzTadrDr8HKA1GH5zK9nP9XJ8o6BdJF?=
 =?us-ascii?Q?FZ42VVjCdRij5ypjAlJ1WkcFF28PJQD8XHsl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lk36Un6NQnzobl78MxOVnn1btXR3hDl6ClWnHCQA71/WoyIRQBCFmlQ6QUFN?=
 =?us-ascii?Q?mCQietj5qHsZbNU5qBlONbGnDKGe0rylgVQgVEhQE4P2T4Dh8K3S2RQbs+9B?=
 =?us-ascii?Q?aqGQRJcKu1Cjwp6poRMfrET1oq85M09PPDfDYrb8YgMIRzEX/nV7Lz2Mo+F8?=
 =?us-ascii?Q?56Y05ZuapdUGLkZzQdEh54uas7gc2nF+CJn06MjV81pCkQfnrtdOVv2C8oRt?=
 =?us-ascii?Q?BtLKlTCBSvESO9xAw2OSpiKD8wcDloT17bSTS5Gu2yeyBXn97Dk2BuffMdLK?=
 =?us-ascii?Q?8g9Bed8q9vwAdLWZV4LuAWmzU0cRbFwAu9tykzDf7nLMHgSuWMrB148WGpmb?=
 =?us-ascii?Q?ts9POCtZQg8XEqhSh5VxHyUeEeBYHEjWnuEcYpBcRD/ZoUe0XRLX5lTzsrKZ?=
 =?us-ascii?Q?NhJ5Pa48dVpsyPHKKZMpK08ELW7iaYGZCQPokfO/NwcezJO8Aj/rmkb4/SaT?=
 =?us-ascii?Q?15rGLx4TdyxaVUpmxT69KAKffzhEpjLUpxwDlx1pgkCxS50i4kWHPfJ4NFp8?=
 =?us-ascii?Q?vF3RFVnYeBl/JiYa4sQD1VFAFThvpUBnW1SiPfHs+uNQ8Ohg4hiKcOkwcLKg?=
 =?us-ascii?Q?QmApejFloQLtJYwjGbo5zhXduP4hKaYcjSZKA0bdwqPcC/m62w1KuDrqFfUe?=
 =?us-ascii?Q?3hD8lGkI2s0et5fVv5cexoZ3mkKdXlO7ax5Qgf5DZv0xG48kZmeiYjE5bog+?=
 =?us-ascii?Q?EA+0mHvBOnfUReaXfm3yBMKknf3ncr0+2K7Fl5PFa8M+9Fy/8PLmAjIJMFMc?=
 =?us-ascii?Q?dEd0YpKdggRXX/q5epOWW/f5FrucIHWE7fVwWO69y4T6P8N2Dja7wTtcDQr6?=
 =?us-ascii?Q?qVTJfcTkThZQnNsR44tpBY1rwx6EuV6RW52OdvpVTRoaKjyoRGELt77/kzbn?=
 =?us-ascii?Q?UIP+6fo4jrOSQ5G178aKi9+vtX/ZijqcjHZ1TIea38YwfgCyvidtXE1Sn6xB?=
 =?us-ascii?Q?Enfe66MDW93Gr9br9ml9YVVHfAwlJf9XdqyDlwiKDcYH3HHEOYWKVYbgIdlm?=
 =?us-ascii?Q?gbDVETd4rmrHqKgNrd80UDSJ/UwzCOPjwUb986K1dVzrRvM37vrmOUAEl4Hq?=
 =?us-ascii?Q?sRqBlIUD7PeMT0MAdJ1sjQHKrOP6ocOpAbzyeqFj6JfrZXAnLhgJin2vDokn?=
 =?us-ascii?Q?muGE1WI/3ojkh7rm/a4X8lEdrFGuGxSioRB/pFR+dSbOKmSEBkzF8ytk3A+I?=
 =?us-ascii?Q?orpSsK6gnHilllNAm2nYsVJl9gjKciWtVwS7gLJQLJR77EH7Jp+C5Rf4rJ4P?=
 =?us-ascii?Q?Tlzy09GC6yk9aqTTkYJw4R8nQIkcShzCDMCkXbkc7AhOz0k584inNYnk03tX?=
 =?us-ascii?Q?iaUmYmVSpPP04aXGKnWhIdveoj6H+NRpkhQGH6K/9EiMCZQhAA/QFQKUCcvn?=
 =?us-ascii?Q?cixo8yYTeJu58H20oJ8FXe1z/BNQQWvYSc3nlqy4CHdiFFFu80HRyoAd60Zo?=
 =?us-ascii?Q?bds1qAnVHfn1tCMHJccOn7QF7VpteBsB/yknoU0WBOfJjjjEGBeW5baTVD8v?=
 =?us-ascii?Q?kL40oOMCL8y3S+0kNeL0xneRabEaFu7dN4o9XsVL3MJWwYWDPJIleTR+/bjY?=
 =?us-ascii?Q?F9S5RJ7k005pyxjRTPU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281b2e1f-bbc5-4091-7b67-08de1b7ceb41
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 08:34:06.9649 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ednd/t/+uOn4x5L24eFTiCu9WcE2AoP1CjSFXY2K0oCxCcjuNtyQVtFMDuVwHHJGrXJHwzW7rUtoWWtVzTBsEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8813
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

Hi Christoph

Thanks for your patch.

> Subject: [PATCH] mmc: Fix missing 1 ms delay after mmc power up
...
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -2878,11 +2878,18 @@ static int mmc_power_cycle(struct mmc
> *mmc)
>  		return ret;
>=20
>  	/*
> -	 * SD spec recommends at least 1ms of delay. Let's wait for
> 2ms
> -	 * to be on the safer side.
> +	 * SD spec recommends at least 1ms of 'power on' delay.
> +	 * Let's wait for 2ms to be on the safer side.
>  	 */
>  	udelay(2000);
> -	return mmc_power_on(mmc);
> +	ret =3D mmc_power_on(mmc);
> +
> +	/*
> +	 * SD spec recommends at least 1ms of 'stable supply voltage'
> delay.
> +	 * Let's wait for 2ms to be on the safer side.
> +	 */
> +	udelay(2000);

Per spec,                                                                  =
                               =20
From Figure 6-4: Power-up Diagram of Card=20
the 1ms is voltageSupply ramp up time, so I am thinking the fix=20
should be in your regulator side, saying startup-delay-us property
in your regulator node.

Thanks,
Peng.

> +	return ret;
>  }
>=20
>  int mmc_get_op_cond(struct mmc *mmc, bool quiet)
> --
> 2.43.0

