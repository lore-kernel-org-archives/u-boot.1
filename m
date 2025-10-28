Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A191CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 08:05:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84955839A8;
	Tue, 28 Oct 2025 09:05:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aixs3wrm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB5C883968; Tue, 28 Oct 2025 03:47:27 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 417B3838F8
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 03:47:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cf/FVxHt+luy6fMFglz/Yq+iNjuE+292wVh9DE/yhxfL48nFJY56qU6eIrDbElm/DsVc3JY1bCtIyMU34o9eBzf1KBWgY6er2bTBwk8DAeRFRYo/zuahSvrGFSnGcJB+ue5Py3n4jnJzrFBJCpOAc7oxKlt/go5OiG3R40RZeCwPIp1dl5Q9X8u55mCKGzhuYO531NqmSmbPvANwkIgPW7o9gRLWLzuwErSeXsRCTRfnvaN9m/Ybf6tekngg6AOhPyb0zDS4ErCRIUmO/hSvRwRPQDJ/dOcaRvGLvli8Hmz1+jFPVGBbrFJdbfybNeQ2ywiStnON4T5Ynfxj9jVLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=823M9XZWQysGe+o/1aDLC/FSIZLt5tJVf00F0tPVPaE=;
 b=uSEHSTwQfb82Xl0m6IziALzTgqCW1CUsejocP7xcJo8oeExlmJr9D69IMB7W420D0Gm8LWNnKBUPpEqcpqnKYDfCtg45j8bhbr3K8KUBZMgbHpZhhksHilZbwFE0HR2TZsRVvBrGsDEQ/0ccYLclvgKEMsAf5Ur6WUTfdByAbyDqjYQlITayTNpE0CNMZ9c7mOXlCmf9LBSweZTROAb2ZIKjdcA0aQ3HCmaOYFYYX0mqlCZp/JD9zkdvFPH6lOCZ7spYlQIZJyuMndxgKwlbnid8WRvm45xP8HU05fFXRNrWYFH6WidezNoOmyd3ElvVnev/SUxC/4sqc7yVkYSObQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=823M9XZWQysGe+o/1aDLC/FSIZLt5tJVf00F0tPVPaE=;
 b=aixs3wrmQTRcGvJ7Pk6jZj8fwXNIptuqdKyYvD8E4MT8yDPq68yTwsMSL8OBILMRtQDyHqbG7hUNfyjM/+asjvQ4pCd3yIzgkxildrjm3p9QSAHK1H2jAOxz/Umvjd0lsiG6I0XxT0v/FuBO7GEbdpXVDudovMrXMl+EJTNoSKujFV7w8y3gO7LHZUlX2IbZKBKTZ1nnUy/ydELRFEZQVsjJYndIkev/E+IekIJ0y6PmTgUK+oHWY2Ygl1/HgGEkL+IukM3PQkOdlNl3svgYQMDENUocuFxIQB6vIipEy2pgl9lxS28E1JwcnUrD6+pRBhex70RCCT3CUeAl6xUZ0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7891.eurprd04.prod.outlook.com (2603:10a6:20b:237::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 28 Oct
 2025 02:47:22 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 02:47:21 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH v4 00/10] Enable USB and ENETC on i.MX943 EVK
Date: Tue, 28 Oct 2025 10:46:21 +0800
Message-Id: <20251028-imx943-v1-0-955b8370c685@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH0uAGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyML3czcCksTY90UA3PjtFRjU6Nkc0sloOKCotS0zAqwQdFKZSZKsbW
 1AJ+B3TdcAAAA
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jindong Yue <jindong.yue@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tim Harvey <tharvey@gateworks.com>, Frank Li <Frank.Li@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <ziyao@disroot.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut@mailbox.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR06CA0222.apcprd06.prod.outlook.com
 (2603:1096:4:68::30) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: b503c14b-6ea9-476c-fee2-08de15cc5147
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0hUZW92bHBtLy93L0VlQThMQW9VdjhheWpSczRvNTNwRmdsMjFnc2FsT1RR?=
 =?utf-8?B?N2ZPalMyTFM1Rkg5ZDV3ek1ibUFWbDdFR2hXTW1tMXdDbU04UnhuTEdxaGF3?=
 =?utf-8?B?NnQvZld0UUhjUU5USVo4bEZIVUFmblpabE5XUVIwWVZLU2VBenZGV2VXSmpR?=
 =?utf-8?B?eXN4eDlBSGpDTFlSMEh4NTIxZmR0QTdZUGZuY3F1TTQyWFQvS1hsUldJenF2?=
 =?utf-8?B?TDMyU0wrd2ZhQ2dSZDJlS1plMU9KTTVPdVhlMkVQV2I4SUpoTEJReXFnT2wv?=
 =?utf-8?B?MENyQlNaRFplbVQ5M1FMNkplR1hseFNqM3hBSlZmRjZNeS92d0NDZW81Mnpk?=
 =?utf-8?B?ekpHTkRPZUtlSzlGYnlKWHluME53T3BjZ09OOFRPT3ZLZG0rYVMvVjVIZklx?=
 =?utf-8?B?UzQyb2NhRk0zY3Fyak5WeTZkY0dBM3BqVXFDMEhDQ3hVQzBVai8vSUZseGUv?=
 =?utf-8?B?Rko0T1puR1JpaWNWdDFzbHJqVUlxdHc2eFZuYnIyTTV0emtoRWhHci9MTDVj?=
 =?utf-8?B?cmQ0REduYkFrc3JWc2FYN0E3WDRwVWsrVE1iSWxERDcwR01JNDNXZ3VOTXRE?=
 =?utf-8?B?NXQ2ZmMxV0RwT3IwaGpoZ2ZBZE51Uk9DTFd0dUtvbFduTnRoNHAvTFRsRjE4?=
 =?utf-8?B?RVIxT0hHUlYxOThkK2dCUDQ2MmZISHNqclRIVEkxUTlqblplQUZBVzhObFgz?=
 =?utf-8?B?VnlneEtxNGRudWxuVkRQczVIOTFraE42cUNPYWdUM1A3L2lvY3l4OGloRFJJ?=
 =?utf-8?B?ZDhBaUZFZnBLcDlxTkNETWRNam40VmFPa3VycktsTjZRckxLUjMzZXJKa2s1?=
 =?utf-8?B?cHFwMHdpY1R4TlhYT3pFUUFSMnNwTExwQWVaeGFtbjUzbjI4SzJ0b291K2Zn?=
 =?utf-8?B?QVI2ZjJWczNQcU5vVnl2eWJKRUdRV1ljZjlWWExJU1Nhc01ibGRZZWg5cEIy?=
 =?utf-8?B?WFBnVlRGSVNkVmt6cXB5bzRjOERDZDhuZFpXdjZYSzdDUUtTVnBad2RQb3gz?=
 =?utf-8?B?dnJ5UklKUTE1S1R6OXVmWWRNWHVmQmttL0dEREpCQjR2OGFMNUlxR2FpenRI?=
 =?utf-8?B?dHBKdmtXcnZBNDV5bGVYb3dDWXpNdm00QThFQ3grSFoxd3NQaWR3THVzRnlK?=
 =?utf-8?B?Ym9RamV5cS85c0JQSm9SckxGZmxtbkFkRWVuQi9sUk95NUsvZFVYTERiWFl6?=
 =?utf-8?B?UWNPU0J0dlBZSEd1NjNzNEpCTkFBRG4wWmlRZGJCV09SbkVyS3dwQ29qem9S?=
 =?utf-8?B?RUk4dlkyRldaS1ZJYUVBMlcyNWVxU1BMTUN2NDZRcUlvOVdMayt0VDF3Uk1B?=
 =?utf-8?B?cmNFQWZ0bk1tdDdBLzNxOTRLK3BLNkFpanVaekh4bEkxN2pGeUx0VGprcWxo?=
 =?utf-8?B?aE80TnhzenFXSjJ5QjFBcjRKbXhBRFZiMklaWCtuWmZVTDdxcGlDRkpwbkJi?=
 =?utf-8?B?c2owVXkrY00xeVlQVWdCUVh1VG5Ka1pucWlVSHlCU2doV2dyVDlyMXQwSWlS?=
 =?utf-8?B?UzVQRWFTUmxjcld5OUhSWmE5eDdXNW10N1RUSDdkalgwbG9IZmFRTVJCSG96?=
 =?utf-8?B?VE9uaTNyeTgvMHZ4RCswOVNTRjEwdXdLWk9MaWUzZllYWWpOMkNSWk96Lzhj?=
 =?utf-8?B?U01rL0J3c0UwWFBQWTk3WWdyVnQxM2t6OXZyRy82RzNGZzFKY2hTSVM1alFs?=
 =?utf-8?B?NUhEUWJzNW1oMjI2aGE2ZnAyT0xZK1hBbjVMcVIrR3daVW1neHdFSXRlZUJa?=
 =?utf-8?B?cnhDM2R0MVZzWldhaXlLbHBLdUhFR0wzSkxsK25XOTZkN0pmeWxhU2IrRkhh?=
 =?utf-8?B?U25qZUZoYXc2ajN3a3k5M2hNYUJpNC9zait2dHQwNHZKaFlvcG5qcDdFTXVL?=
 =?utf-8?B?UC9QQmpnakhvWklhNUdvOWxxdDlpeHd5ejRqYitYbmJHYSt3VURYbmMzS2tR?=
 =?utf-8?B?L05EakpYWHA5Q1BobFpON1B4QVA3MTRoL3RiOU5sSTJVcWxBclBtMXF1aWRH?=
 =?utf-8?B?ako1REJrc1dxdnAzc1BLK0NTUzYxOW45VFJHMTV2MDFpa2NWazVSMUl3ekY1?=
 =?utf-8?Q?83CLAM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eER6ek01L3hkRTk2SGl5WjI4cDhVaTBMalFaN2JFSU1EWHcwVDJSQmRTeldB?=
 =?utf-8?B?ZE9seU5HM3JuTXFzajAyNEdjRjNpRXQrTVZHTlVyK2JtWkNhUElNaE9hY01H?=
 =?utf-8?B?MmhRRGR5RTIyWUdON21CK3l2OFFOczk2YlVveTh1NVN3TS92bEMzeVF1cmVI?=
 =?utf-8?B?dVZoeUM0di9LQWd1RkVVYXlyKzJoVERWRDJtUDlSdVh2MHlqekRFd2FCbU9x?=
 =?utf-8?B?SG1oamRyTEpVbmxHTVpoS012WS94SGErL1duSjZGUTQ4L0pxanp3K1l4aXkv?=
 =?utf-8?B?TnMxTE1hNjJGZlZ4aE43dU9jQno4UFNnMy9ZVVk5NTlic2dFWkVEQzA0c1hN?=
 =?utf-8?B?U0U1Y0JRSFJNSGRka3lxdHZFUGgwYW5KTWFJRlV2c1hKTG92QWUvRjZxVGNL?=
 =?utf-8?B?MHZqTStQamZVakFvT0piaHZyc3NhdDh6V2NnRGtxREFaSWZvYU1FdTRFcUFL?=
 =?utf-8?B?N2w3M1JQWWlIVXJEV3NZdjRsRzhnRXNPcC9lUjBCRE52WlR0K2RjeE1YMUlV?=
 =?utf-8?B?V1doWWl4S1FqbjMrejE1N210ZVQ0WUtkcTJBMGhTZi9yR1pMV0RITHM5ZU5Y?=
 =?utf-8?B?a242TmVYTzFhNEl6M3Z5Z3JrVlVpV0pIWUVVbU0ydE1STFM3dUhlL1RPNC9X?=
 =?utf-8?B?elFWbUt4VVJzS04zeXpsTEFqNnpVMi9XOG1wZS85ckVyblV5SWN1dFlKSmJG?=
 =?utf-8?B?czNlMytxRG45djV4K2NnNndpdS93elJJVXRha3lDK1lMdEZhT3JPWXdOYTdE?=
 =?utf-8?B?bmNjUE5TTklWa3oxd2FSL2Vvc1phZ0U3MFpVRVlodERVS1EvMjk0V0U4OTlQ?=
 =?utf-8?B?YitUL3FFK0ZMSXEzQklKaTBHN3FDK3FiYVZKZENVdDl6Uk1PTmFGd1NEYm9R?=
 =?utf-8?B?Uk9qMkMzNDU5VDZNd3dJVGcwU1h1UUJMYWVFNEEwUmc1Y3pOQ0tYYzNKZElH?=
 =?utf-8?B?RkFUVWllL2RaTG1JVERDbGN0bUNBaHhtYkc2aEwzMGdRRkVkZG1OM01jSjJr?=
 =?utf-8?B?YUZQbmNubFp5d1BzcVFuNlVUUk4rVUVncm1ZWUVJQWI5dExmaEZDTzFmZUpR?=
 =?utf-8?B?U1FXK0pvZUNDN0tLbzB0RzVVMDNkT1ZhYXJsV0ZVb1NRcm51UDQ0a2dHT1Nu?=
 =?utf-8?B?a1dtTHpUdDU3RmVpQlpUWmxSRmZoaEtKdXQ5L1ppYXlNY1pUbElUSjRKeEZE?=
 =?utf-8?B?eDJyWHlUZlBsZ2FxY1ZFMHVHc09oenpqbVdYOWJER3VhYy91eW81cmV3bU44?=
 =?utf-8?B?YTdoYVF2N0tDclY4RGVRODhBVGpBckloMTVQcHhqVjJMam5jTXY2MkpuSHZO?=
 =?utf-8?B?cEgvYkw2dUtkcFlaR3pUYk1HK09TUTVPQzdJTW1Ra2NoU2JUOEtvR2x5WHVX?=
 =?utf-8?B?b3kxZkU4YnNwMVBrMTdQdjJsZWxMb2gyaWpXbUpwWnY5TnN3R2piT3poZU15?=
 =?utf-8?B?djVkRkZBR0hlOEI0RmtnQkpjZlErUThCMnZBSkU3Wk5Ub2R2RnFVQWE0QkZj?=
 =?utf-8?B?anNncSsvMzQyakZzWDZOTnpXbVJKYS9NcjFDR1k1aFJrVGNMWUlnek8yS1hW?=
 =?utf-8?B?cUFrSDlUZ0IvLzNDMkx0TFN1d3ViOThndTZienJkWjhtY3dUV1JRbGZxaWdZ?=
 =?utf-8?B?dkxiRU5GTWZrRHpxdDlOb2UyNkhiL0pSU2NRZmpHMHFUUUgwTFh5aGFBeERw?=
 =?utf-8?B?MFVkWmhGTzdpcCtpQWhhcnlUVWMyNDhQeFc3Z3BuR1dpemVtQUlvanE2WDA3?=
 =?utf-8?B?VVB0N2h5aEZBOHByL0hFRk1lZldDR2E3MUtVYWFlb1dLcGdHcE5oSE1nUEdM?=
 =?utf-8?B?ODY5WmxDSXFkYjBIamhjWnFESG5GWnoxQjhjd1c0L2J0eW45b3FzWnFERTdK?=
 =?utf-8?B?dU55OGZLOUhLS0g0cmEzSk1SZDFXUm5Jd3JTRDcxNCt5TXB3YW1iaTkwV0pJ?=
 =?utf-8?B?U3hBNDU0T0pCLzM4dmVjdEtvUlRsYTk3RkJCemhiNko4ckJDNTJpRjZDZ3do?=
 =?utf-8?B?aWhXNWREZ2pTUkJEaWo1UElBV0JTMGVROEx2WTA3RDc2QkdteG02bmQ0R2hU?=
 =?utf-8?B?UkZ4RnFyTmV0dWJJL0pla3ZIZStPL215UGdpdU5BTytTRzJDZTY1ODRjMm5z?=
 =?utf-8?Q?vddpKb1j8q83ozsHhHgfKdBtn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b503c14b-6ea9-476c-fee2-08de15cc5147
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 02:47:21.7465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mM7ikuWV22WFsSZXSQUqgWdZzD1w1hu/G5Q7Lzk+MIyOmv6gK8Cjo0i9DU/1wIhuMr1XrPhSaJVmPJFrKsgIxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7891
X-Mailman-Approved-At: Tue, 28 Oct 2025 09:05:24 +0100
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

Changes for v1:
 - Adding USB2 and USB3 device tree nodes with required PHY and
   regulator support.
 - Enabling ENETC1 and ENETC2.
 - Updating Kconfig and DTSI files to support these interfaces.

Changes for v2:
 - Resend patch series with updated To list.

Changes for v3:
 - Remove logically dead code in imx94_link_config().

Changes for v4:
 - Add i.MX94-specific conditional compilation in PATCH 4.

CI: https://github.com/u-boot/u-boot/pull/824/checks

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (6):
      usb: ehci-mx6: Extend support to i.MX91, i.MX93, i.MX94, and i.MX95
      arm: arch-imx9: Add USB2.0 and USB3.0 base address definitions
      imx943_evk: Enable USB 2.0 controller host mode
      phy: imx8mq-usb: Add SPL support for i.MX8MQ, i.MX8MP, i.MX95, and i.MX94 USB3.0 PHY
      imx943_evk: Add support for booting from USB SDP on USB3.0
      imx943_evk: Enable ENETC1 and ENETC2

Frank Li (1):
      Add serial# for SPL SDP download

Ye Li (3):
      usb: f_sdp: Update SDP driver to support PQC container
      net: fsl_enetc: Add i.MX94 support to NETC block control driver
      net: fsl_enetc_mdio: Add support for phy-supply property

 arch/arm/dts/imx943-evk-u-boot.dtsi       | 182 +++++++++++++++++
 arch/arm/dts/imx943-u-boot.dtsi           | 234 +++++++++++++++++++++
 arch/arm/include/asm/arch-imx9/imx-regs.h |   5 +
 arch/arm/mach-imx/spl.c                   |  12 ++
 configs/imx943_evk_defconfig              |  30 +++
 drivers/net/Kconfig                       |   5 +-
 drivers/net/fsl_enetc_mdio.c              |  25 +++
 drivers/net/fsl_enetc_netc_blk_ctrl.c     | 329 +++++++++++++++++++++++++++++-
 drivers/phy/Kconfig                       |  14 +-
 drivers/phy/Makefile                      |   2 +-
 drivers/usb/gadget/f_sdp.c                |   2 +-
 drivers/usb/host/Kconfig                  |   6 +-
 12 files changed, 828 insertions(+), 18 deletions(-)
---
base-commit: 23987e10905146def3ab61e55ec912c6e742efdc
change-id: 20251028-imx943-d073fe352c79

Best regards,
-- 
Alice Guo <alice.guo@nxp.com>

