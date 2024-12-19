Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241B8E77188
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 01:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 116158021D;
	Thu, 19 Dec 2024 02:10:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="MqoapliE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4DFD8022B; Thu, 19 Dec 2024 02:10:19 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83C96801F5
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 02:10:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opTJt5rZci37rw8jzOw8Tm8/GWeDJrg69y/1bkAgonWda20oLl6cJ15KgvYqUPyk01ZJ6F5ZKTBAbXcFgPdwSsKK6erevRkJKEanPg7HG0YNGJszvLnKJUfMFJByLo0g4vEO2aSbgjUGA6aYPzmpDGoJT3bBF+8etQtRZY438k/ZTXQkvPNICGoS8MWl02da0E5kl1+NnWJtHaY1CTx79vvHvCYEmKaauIwCi1k4tnA8Lvw8cE2LQ7AV1c3UQLl95SxfSiZKMFyrj0ldDLmmWGHQlHaSyIzvKELLpI/CG94iTPUm0fg2QbnLiPRZjifr4rxB6LYykXT1XT6ftQMJLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZ7Ve+tPWnmM7Q3r1My4wesX0ucu3MNcPPXNqYBHDbk=;
 b=HQCdqSz8hSvdLN9ZSthQXX5JkWmuFc7vgpnfmdM5tTkRHZQ5IgUnamao6unNp8b2Cf+s34Q7Cxj9efeCz7xwV+McCzeVmCSp58TtuVk6qCjYZsStXe/xy6mcUfACQtZCvhrHo3eY5mhxeYM/FJh4Y5NVIVj4rv4XTUYJH+z2sZa6x4D9lQMDNeCV2jhy3+fLCxRLm03AUcgKx6+LB/BXTdVDhgQJ+grVJ4KxU/+fr40GGOPpSWjrsXsFT9Zn91uBtmFm8mdJftifg0wxg7/VmX4Q79kiEcZFJq/4TCSSFiHNMdktsjtaL6O6+ycMAxreKeUrlHOwh83T4Td8bk8NSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZ7Ve+tPWnmM7Q3r1My4wesX0ucu3MNcPPXNqYBHDbk=;
 b=MqoapliEFaqh99OseLwrwTyZWRR335zJU+xONTwphjXsYJ09ublJTT6yW4VBisSKrIBR7luBLtW/xmaFzDDkl7rI3k7mwARaiDj0Y/GZCvHkvJjaAJ0HCSdDZMA75Q/1KROz0RJJX7xNydAcI0VggDi6h4cuU3M+bpR5n0iPGMMl4Lc1cgDM6VBjoJEdR3zRDJphz6Vk6ZweIHrdGB+E7iHj3ILVPsOql1fEwziMOK7S1tu3aUkCKjiYTgZY7OWyRffFwfsps2cNUtySiaktPXzS3MKAfyyBbX1Cu6sdQ5cLIoUHBVWgEe26HHXew5gcrlA+R27DSpiOTgUYLWmo3A==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB9928.eurprd04.prod.outlook.com (2603:10a6:150:117::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Thu, 19 Dec
 2024 01:10:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 01:10:13 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, "trini@konsulko.com"
 <trini@konsulko.com>
CC: Sughosh Ganu <sughosh.ganu@linaro.org>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Simon
 Glass <sjg@chromium.org>, Vitor Soares <vitor.soares@toradex.com>, Paul
 Geurts <paul.geurts@prodrive-technologies.com>, Marek Vasut <marex@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH] imx: Fix usable memory ranges for imx8m SOCs
Thread-Topic: [PATCH] imx: Fix usable memory ranges for imx8m SOCs
Thread-Index: AQHbUStCRzfzqSvMv0OBUlZUclpT9rLsww6w
Date: Thu, 19 Dec 2024 01:10:13 +0000
Message-ID: <PAXPR04MB845939122E5CC289B947B44288062@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241218090007.692815-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20241218090007.692815-1-ilias.apalodimas@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GVXPR04MB9928:EE_
x-ms-office365-filtering-correlation-id: b8578d03-4134-4596-45a1-08dd1fc9e463
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?TbuX7zxWA2ssE+6ohF78eRDkBcKJhn/3YQ+suK2EXuDMNf+lyNedx7pDYgUM?=
 =?us-ascii?Q?EK/qG8vhPjuJ4yHtpspqdJEzkDeDNCLJC3x++2l92Ufpmo/F0j/XH/AhkiBa?=
 =?us-ascii?Q?tfuKjVUSTRsRiNz3UbRw6BdyfNta76kBCcdVrLQ4hcrdKvG2jCV/Izq8SyAa?=
 =?us-ascii?Q?73uF1lsgMxiHup2CkjUrHkkPY/O3BUIHyVsS8UA77FjgkAt/B/8vYx6vq7Ei?=
 =?us-ascii?Q?2OexhmAvYcWb8vPZG2jFZOMWqmo4XUVuzK+7pzOwuL+1+sYWncS5hf6xnQ88?=
 =?us-ascii?Q?VjNVWbb7mlH+AcFaY+7R/YVqzHWGvgXPL2kyhsc+fkXsVE33J63hHqkzjbJU?=
 =?us-ascii?Q?OJZSpIjCT3cWNJlhLOxf9Azex0UIzPmyuJJV9fYB0ur+1OfZH7PyXU9gUTmU?=
 =?us-ascii?Q?GngIJ8rI4hQTJQIJB+krmcJTMwD2dJCWs+c+d795F1bwhEbT1R0E8IycCG2Y?=
 =?us-ascii?Q?1sCurFDLaFzBrrLVF5mTeBXpZwh+dWSOAQ8zKXM3OV7NcT88fLaRO8w/XzNl?=
 =?us-ascii?Q?tC+g3Rq7AxFI1uHpMXrcVJTwvYQDFUL+q0lbODtEJxc1HNhAwo9DyFU9YzeA?=
 =?us-ascii?Q?QO37RGRGYZ20WE6wnVctXhnvu5o7h+DH+Q7AZIdzuARKbfgtDR+NDx0KAEGr?=
 =?us-ascii?Q?GAJ/wUx5CXf+G1++aDOfX2eLn/LMZ3gR+81GcHj2vQ8mGbHIGGHNH9nnJ1eD?=
 =?us-ascii?Q?TXi3hhSzQWV/CCd9Q3cXUCzZTQKcteWAC3n+HOC5h6ZtgJj0olmvjcoKjGzI?=
 =?us-ascii?Q?W8cPFV3smKLOeF0ba371rYjTRf5HwNjSXEa0tlTFjv5Yu98hla49XGsv3517?=
 =?us-ascii?Q?YFSdUxc1l7MGvXc3u802ulwAeeijIvL9yMCN4/zkuFQOO+Pdy7q4iKzUMUsJ?=
 =?us-ascii?Q?DFMs2jJA5K1OpCM8MqMNTVbZcr+PBahYKJumlRXqhOr/JlapwFRLDzogVAWC?=
 =?us-ascii?Q?rUlSHPOM8DfEXObmgQza+frH75NR36yTH7iU/L3h310I8B2EKK46VE+Uczid?=
 =?us-ascii?Q?M49QFQpGqmiRgvrjyzxgnl+WaMGmvuMINue0Ciq/FKUM3ZFp49SWNYKF7y5Y?=
 =?us-ascii?Q?nap1Ytqe8r7wBnX6LgFtqBdLHs8DhcKttlcx6OwCWhX0ltG59DvovNDE7y5o?=
 =?us-ascii?Q?fQmMToBdBJCeVxk2qMRHjZSGWLC6zflsx3qE1ijAUuDjPMfn2JdX1WVnA/ZZ?=
 =?us-ascii?Q?UluyKwKbAbO79GKHwZaPU4N/e/htZLsItxZcgGoKyyaDpVkjZGlmqru3Xqoc?=
 =?us-ascii?Q?11zuPFOAY41t33jNbk1drt7hz9w3K4V/5tp3xK/o9aECLGPsJPQ4AwyNaN32?=
 =?us-ascii?Q?AXhFl2gtDkuD/DLbkDhk32+MemPYuQNBoFSWyyPS5hOSjphSr5p+jGJg20o7?=
 =?us-ascii?Q?6ZFEOI9lekwJpEqn2FUovdT5/SkoMOsauE+HfbYm49ua/t2/xvHk+eenl9SU?=
 =?us-ascii?Q?EXX+UMMEW215Pf3+l1Kf56jzfGnYFdW6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TS2WXZQUh3+WWm2uqaY6m9ChA6MsaMl03gWrlCd8KjSgk4XT+79MBufmTBeP?=
 =?us-ascii?Q?7WLuL066LcRv2inMsLNSjdu5XqD32zrE9NtF6aASFWpEKMLF5qGmZNga/O0I?=
 =?us-ascii?Q?wJmwKfFcdHRK9BiLPmIarDI1UQ6EPFQea5aTdS7JUaPBkfYk2B52EfU6pXz/?=
 =?us-ascii?Q?OnYt8Kee5X27NogO/vqLhyj5uZoWG9DxbEOnERF4IkfLbc9KTa0mk3mPhHAc?=
 =?us-ascii?Q?l8ADxdhogb5k4wNXyHsymSzP6vaB7xkBPoD0uYfImuBdvEgjA81bkZ4eQHjN?=
 =?us-ascii?Q?HN9Z5sLrtstZoNMfl0KEaXpuLwk94XBjW9cOipYVSp6E8C/4JtOK3Io/SPMp?=
 =?us-ascii?Q?S9M6T2pQAbkOLrwp+XyPMZBg5C+taYumKfSumlJdEY4ZQBzkct7GeUHf68ez?=
 =?us-ascii?Q?rSTZn9nwoEXyXwNXyw/fEEsQbxiDl8AVK4QfbZu3BUTlwHXsyYfRZMh6JQzI?=
 =?us-ascii?Q?SIDMF0oKPJAK5PU0xcTWVeh5Jg4PVqqWakQT3sZyjpvKpckjUIttupoZCtL7?=
 =?us-ascii?Q?MZo8GT56AmOV2bFVaqhBjy3PxRzwcTkPadmcfdsuNWn+lqmCFrFA6V+cdPou?=
 =?us-ascii?Q?2q3UOGs45pWvTc4JiTuPH/26hwVnVwXsjXeSHPYlZztf+/fBnlGAyXHnxS1p?=
 =?us-ascii?Q?kB1EcVabJSTNDxjGc6OY0j7wNDRVTgIEsTr2mT3Jo8wsrEH0F2jRzY0f9Cds?=
 =?us-ascii?Q?NpWbiKuKVgAh21P1F/oLudQj1Sg6T559MCzuwI4kEgzS6sTi1Sx9B1651D+n?=
 =?us-ascii?Q?Cg/obvMDJEKczALt/JKPZEQOY9hZhm1LYIvFIAkhI6uA/rPri6ZgM+gvHL1V?=
 =?us-ascii?Q?Sh644GFIWS0ScOZhpJsILiwejMe8RcxMMKQCu9WnaWfUG7Hgt9kHLHZgTn40?=
 =?us-ascii?Q?qJGwyyAldxS/f/m3U65NH+dPs/+j1XXxlarA86sxLha2+7oMMng0QB4uYU3d?=
 =?us-ascii?Q?TRohCQHQt9G6W+a6MLFgL3tkJXzMYoXTFPomGV6O7X8Aj1Ho7CzuI6oHBMiQ?=
 =?us-ascii?Q?XUbWWk9xa2RelWKAnRh065Gu7NKWmoGUI5Bpv9D+QRuYPmY5C7uJv791HDC8?=
 =?us-ascii?Q?qlYwcfy7Al0ZmEGUKsaQvxW0hXzUY+YicoQARYyS6nwVwk6KArq3CcraWdwW?=
 =?us-ascii?Q?XvhzbXZG4Bb/TWnskl/y2kic1kPAv40LHPKmFUsOZyBO2d1byolGUkUD63fg?=
 =?us-ascii?Q?12mjxglJUQ7xogt+DJ19ypgTNWsvfZ/xAHZHply+D7Yrg8nM3t3s4IPIRBHN?=
 =?us-ascii?Q?V5fLBU+LCYpY6Mu5NL3nf30JMli1mEgArSKlDqbdYalzQPMAcwvXzkaQRm/3?=
 =?us-ascii?Q?+joHM5OITgAaR8KKPGgbVbnPMGt82CK+VKTC2vh5sXupXdTkBIfTAeHasQL6?=
 =?us-ascii?Q?q93HsvzEJd70O0t/7HsXx15HbFklOerOXuEKjUJ5fzEWeutBHxzOUnrnoEx3?=
 =?us-ascii?Q?oG9iVXMv7QORUnCMfqX6XbZPMPenzLHs0zQCbt7LM1cpQtuFbPFTS8oSg9aJ?=
 =?us-ascii?Q?H2ahj6qqNkjz/haDB7/u3ael1jEMm9cgj/jChLMzQWWM+GixMCp5f1sSHE3O?=
 =?us-ascii?Q?kmzi3yrZigBI5Ogw7ro=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8578d03-4134-4596-45a1-08dd1fc9e463
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 01:10:13.5785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zfNpwPr/dYrTlRaWR87XQCFSjSCQnJFVzx31iNuTKdw2rYb0cnh3Snzf90WXKQKjQQOxCQZ2PAZV8vBcf1jUog==
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

> Subject: [PATCH] imx: Fix usable memory ranges for imx8m SOCs
>=20
> commit e27bddff4b97 ("imx8m: Restrict usable memory to space
> below 4G boundary") tried to adjust the usable memory limits on a
> 4GB boundary.
>=20
> ram_top is described as 'top address of RAM used by U-Boot' and we
> want to preserve that. This is defined as a phys_addr_t and
> unfortunately its size differs across architectures. This has lead us to =
a
> weird state where 32bit boards define it 'SZ_4GB - 1' and 64bit boards
> as 'SZ_4GB' unless it was otherwise defined.
>=20
> With some recent LMB changes and specifically commit
> 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from
> same bank") the board fails to boot properly although the commit
> above is correct since it's making sure that no memory above ram_top
> is usable -- but added to our memory map so EFI can hand it over to
> the booted OS.
>=20
> The reason for that is that during the LMB init we add all usable
> memory in lmb_add_memory(). In that function any memory above
> ram_top gets added as 'reserved' for LMB. With the current values
> tha's set to 0xFFFF_FFFF for this board. Later LMB is trying to protect
> the memory area U-Boot lives in with lmb_reserve_common(). The
> latter fails though since it tries to add U-Boot top (which is
> 0xFFFF_FFFF as well) to U-Boot 'bottom'. This call will fail since 1 byte
> of that memory range is already marked as 'reserved'.
>=20
> Since we are close to the release, LMB seems to assume that the
> address is rounded up and is the 'next address' and so does parsing and
> adding memory ranges from DT files, bump the ram_top of the board
> by 1byte.
>=20
> In the long run we should change all of the above and have 32b and
> 64b platforms define ram_top identically.
>=20
> Add a Fixes tag although the commit is correct, so people can figure
> out the broken scenarios in the future.
>=20
> Suggested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Fixes: commit 1a48b0be93d4 ("lmb: prohibit allocations above
> ram_top even from same bank")
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
