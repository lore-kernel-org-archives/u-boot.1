Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA4FCFA758
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 10:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E30EE88B2D;
	Fri,  4 Oct 2024 12:05:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="KGUlAVqi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 360D288B2D; Fri,  4 Oct 2024 12:05:24 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3601C88A0E
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 12:05:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xeZTsOrvoww9YpdyUvZsbC1ilDaWUr23nl/DVe0zkbDn4iBnXsVQns6IYoCvz6JHXRNXSgIXP+fYxdJZlxbsH730aMBS4xRmt1IsrQvT1Awk6WnntDDCoWN0JdbCBJEvBn18znopfkqWHyql87oBgWvuxFV4Ib1zq1PeL8cHzxGy0zEkA7dye7TI4ACeSe+oOBkW1Q/5IdevsRcV1QGLbj6VPF7QELzmRPhAsrGhAmPMLfdyjZBqM6cRi+2Rk5UAMs4resWXtWoDQg3JQddtncMeCHukDCcdOceILhUnxGtZIN9els9fFq17AtBBylS9v45DT0PUZ+4bPmQsFRc9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+cSF0x1ypZSPExV5R1BdEo039qRcE+7hGEDwAgGgsg=;
 b=oPlbReeVknHrfb++aS78SIsw5JoWVFuw6eEA4xuhRygOvH571hWHpwWIWPyzKcHMvqU0+uMRSZiMjBZO/KkS1FgxpXT+sQMbYE+jvrsXqoS4/6W4ilJL4XUcjCRzda6CYxtB+N7wY96mVZckMoKYIQ8ZezBWvEF1vVLd2TNxp7WC8Xsrx35SO5siu2isFnvLgrH3Vubcj3nqZOOlhxvpIaoIweFU6WHkcY8m6j8SeslhCIzSq3LnGluTEaH4kuhOG0sRAArcoEUw9npne+grPsfa7flR8pmhMOpaznDhZJCCa2aUUpOp9H4D6aEGKgsPBljG61cFdiNKrxULTZSa2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+cSF0x1ypZSPExV5R1BdEo039qRcE+7hGEDwAgGgsg=;
 b=KGUlAVqilkugn0aYSmvis/nvymXv+9w4803s2MRKw71vpT3Ev7Up52w184WdkiQrstBPlDfcY7PloP5mqJozQQKF1C9MUZJl91cGM9hDRZBlqhzy38+a98TYUOBvctUaKP5oFwY3JsWHOOWl2pItkFOgUEM1VAbVXoFIPJrP3G8guusmC+F6xEftdEiQagsZAJDs/6ZI+NkoyjSKIFLO39j1ZZ+ZDCZE3mYl2svLjh1fKQVFMcqiwWTCQ55O1arGFRxSlLkeKQ/1RRAsWzl7AND7a65CBqogXsRcPCUDQbiPyZ7TXnsyRa7RgqXD8exJUl8Kr42mxKoo4h6aofFCmw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 10:05:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 10:05:19 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: "sbabic@denx.de" <sbabic@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini
 <trini@konsulko.com>, dl-uboot-imx <uboot-imx@nxp.com>
Subject: RE: [PATCH V2 1/5] mmc: fsl_esdhc_imx: Enable AHB/IPG clk with clk
 bulk API
Thread-Topic: [PATCH V2 1/5] mmc: fsl_esdhc_imx: Enable AHB/IPG clk with clk
 bulk API
Thread-Index: AQHbE/oODC+YU3Gc5UyAxhiEim4XcbJ1CKaAgAFY/1A=
Date: Fri, 4 Oct 2024 10:05:19 +0000
Message-ID: <PAXPR04MB8459DE574B69898B7CD98CBE88722@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241001130758.9810-1-peng.fan@oss.nxp.com>
 <CAOMZO5B8afcDSK+APn4wVRALeT1=27RmfgXaWjKZ06RoEWOAqw@mail.gmail.com>
In-Reply-To: <CAOMZO5B8afcDSK+APn4wVRALeT1=27RmfgXaWjKZ06RoEWOAqw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI1PR04MB10073:EE_
x-ms-office365-filtering-correlation-id: 4ddce2aa-0467-4805-2db3-08dce45c0d9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cWpDV2praGlpRHdBL2ROUDhGSjR5QVpocGNIaGNENXgraEZGUVNEV3oxTEEw?=
 =?utf-8?B?ZmJtcElIQmpzOXZJVzl2bXpzU21sczVQTHJKR2g5aU5BWkdBbnRSV3BvVkxh?=
 =?utf-8?B?RlNiWjRhVzdoQU10eXNoV3pNa040SExDM0VFTmFxcjg3KzZhajRSc015UW1W?=
 =?utf-8?B?dGM3TjBYUEpqOW9YTCtWUFBJRlFQRXpIOTdnRjE3c2FQL0MyZ3ZYYmk0bjVM?=
 =?utf-8?B?dUErRnduVlRkbUtqZTNyTHI2dDNvMGtXaWRkTDRkNVJuT0pCKzlKSlZiYmFw?=
 =?utf-8?B?d0hpMEsrbHkzaFF3Q2l4eEJORkEzemlHWFB1dFVYNFNjMmgwMnRLK3RtWGlz?=
 =?utf-8?B?cmhLYjdWTXRYeENaTDVXOFFNZDFpK2FjZDhHRllQVFpQZFNpZlFXeFVLYnFE?=
 =?utf-8?B?N2kyMytvUlcrcVpnb2J2ZElZanMrYlNxTVM1eUdMZEM5eEhHSENnRmh3b3FM?=
 =?utf-8?B?c1h0azVUbkJ6L2FoclZZYmhOcVRiVUcvRVJPTU1US1hJb1dIZEp0Z3l5RTV0?=
 =?utf-8?B?V0JmbElpSE5IWk84bGw1ZmwwSnhBS25QUUVaY3lkaEo2bnpUZEg3YVVKWHdF?=
 =?utf-8?B?b3FrT21mOXFicENFQnpCM3I0NXY4WnlPQ3F5MEpUYk1DUXpVNFZUL1pzZG9G?=
 =?utf-8?B?b2dFN3NNT0JlOHI2TUc1NEhvbzltYjZCNUdsQjBmNmF6VXRuTGY2eHFBTyt0?=
 =?utf-8?B?Y0dFYWVCc0srWnVqNmhKZStyRytBWXZHcUtDQzZDdm1KYVhuR2h0YWNvbHk5?=
 =?utf-8?B?MmY1bzRobTJGeFZMZk1OZDVWZFFtSnkxSkhFK1FzMVA5LzlIR1pFSmJaSXlj?=
 =?utf-8?B?VGZPU3Y3eTVEVU9MZmluK2pvMU4zelVMdUNZSWpDNHRZNmEzd1hONFBEY2JS?=
 =?utf-8?B?SW13cG92RC92bVlHQnZ0RWxobWx4SGs0aUI1TDlmVlpiZlNJQTJGNjM2aG5r?=
 =?utf-8?B?eGtpRFVtcmhEV3RGOEI0bnYzb08rQllybWdDVzZ0K09EajB2dXJtZTdJWHh2?=
 =?utf-8?B?VEN6RzloU0EzMS9XN0xKQlJ2QnNSUGNtTk4zRXExV3NMalZUUWtZb0swVVpT?=
 =?utf-8?B?M3JydDFHMUJCVjgrTnVYTXpaMTJZdkZBc1dDMVRYWnYyZ20vVmhUSTVmSlRq?=
 =?utf-8?B?cXdXQ0pLT0NDOWozOVBXUlpDdHZLdGtWMjJ2Ri9zZTNmNGRtRXlSK0swVHNL?=
 =?utf-8?B?MVFjdjJFNUpWdEpXTHB0ZWw5VXh3TktBMXNwVlVVMkpSVHdWcGdFaDRVcHJ3?=
 =?utf-8?B?VGdveGdQOFNLRVo3QmdBR3pTWU11OFhpN3hoZXNOY0hFWG10bTdJWGVEL3JG?=
 =?utf-8?B?ZFBhSHJSUklhaDV2aHh1ajJNMmNyd0VoWWJYVnBIeE5sN0VhZGdUZ2xUYVNh?=
 =?utf-8?B?SzBHTlZ2RXd4dTM2TVI1UjBlNWVVVUVvSzJhZEtMYnJkVzJkbGxRTVFlZWpE?=
 =?utf-8?B?cExOMjYwcGw1alFkWUtyR2hGd0w5R1RmWGZkZTd1aU0vc3hxR0ozNklMb25O?=
 =?utf-8?B?MGtkSXVzZTFlSW80M0Z1Zm1wdnkrSUI1c3k4WGhzTDdEaWUvMjZaUWJ6d2li?=
 =?utf-8?B?eXhPU0NxWGIrRnVJZGtFWjkvb3lKN3piRk5BTCtrTHIyQTZxTjg2SkFId1A5?=
 =?utf-8?B?U0I3ZFlJS05FcG5zTk5jR3BOOFArbDMzTy9Sb0M3dEliUSttQjB3bWFHenVQ?=
 =?utf-8?B?RVljb1ZmZDhLZlFVOHZHLy9kRlJKLzlMRGZNRFVrK1FRNkR4WWpmZGVQM3h2?=
 =?utf-8?B?ZTk0a2xPZnNmejdyeHFmbHdBQ1RQK0pQSmI1RnZkOW1LMVFERFRNaTRSQXlH?=
 =?utf-8?B?RFRBVjFhcGZOaGhVejhkdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2RqNUpTWFVLbSs3MG5MSFVBcksrWjhENDl2Ykt4OFpBcGdYVG9Lbmpxb1hI?=
 =?utf-8?B?cDZLVjFWUHRMQTJnOHcwYnN0U3hwazRjRDdIRzNnbmNUc1d1eUxrZHgxUlBT?=
 =?utf-8?B?OGpDUi80cVQvdGVlcmpsYnFXYldnS25rKzA0SXBhQ1AwOG5TcElqekNuTGIv?=
 =?utf-8?B?eWtKQnVBd1NtblJwd2VMWVlEN2dZNTNpWEY5aHJQQ0lhb2xxY2x2YTVuK2NJ?=
 =?utf-8?B?ZDJRTUp6bFNaWk1mbDF6dmhYWmRzOEN1QWtFNFR4cU9wYVlucmxjeVAyWW92?=
 =?utf-8?B?K2NIK3o4UHp1elJEclJxdGlBaERhSkx1TGp5KzRuZjZHV3pDVE5FVG9zN0NF?=
 =?utf-8?B?UDVGNUJlOUZqN29XTzhRWC9yMXlaUy9kNlhXK0NzWS9lRFVxeDA3d2FoTnc5?=
 =?utf-8?B?bWViYVp4SGdZcGhvSUtNTzUwY2xMVlVGWVlEZDEvTmFZbG5rNGdhVHF1ZTQ0?=
 =?utf-8?B?dVdiUERIVmhtK2RJTUZHc0F0Y0xzN1NPenJCUjZHRHAwZ0RKWndKakVEdDJB?=
 =?utf-8?B?a0YzbEd3ZTRqc3hKVXVmcWg1UnNZdU9YT3MvUGxONW5rUmp1N0VkTDgvSXFi?=
 =?utf-8?B?Ukw4blV6T2lBUGtjeUVIamkvSmEwZ1hhdWVzSklkMWh1YUFQaXkrOGgxNmYz?=
 =?utf-8?B?ZVN6UG41RC9ERUpNOTU2ZXBVVnI2Nlo2Ym52Y0l4cTJNbUN1dUR1SkZDSXR6?=
 =?utf-8?B?WkFGcmhpcm5ZbUsxTVpKbVhsSE01ODBDVGVVMTJEdTdqY1cyMHZhUXhaQ1U2?=
 =?utf-8?B?T0M4ODZYVitYK05HcWxNUHRjSXgrZzNxNVRsNnhRZWdyL1N6RG9RTkd3K1c4?=
 =?utf-8?B?ODZZL1BwY20vZFFQdW8xQWdOcHFDcmhkN2VqZXhDNEEwUU1xOWFVTFczMEo4?=
 =?utf-8?B?ODAwZnU0d1ZQQnl5aitiT1NpcEo1M282bmMwSFcyejFoN2wvbzhYdGVOMml2?=
 =?utf-8?B?RnptTG43MjhWRDNVTE1OQUluWlN0aXlKUytjWjJneU8wWHRXcnJUVnlwSFAx?=
 =?utf-8?B?TTdpRmRKcFZrU1RLd2dldXNZYTQwQ2k1QmgvajJhdWVFcWFRWWFDRHliRlhy?=
 =?utf-8?B?eUtSWmFrNG5HejFwaDN3cGoyaHVKN2hJMGRmc2tBZ09VQlB0SWhkazIzK21x?=
 =?utf-8?B?OS9jck9YaG02STNMb1UyaEovUWE4NXUxeXZHRUJFV0QwOTlReFdXK3M2Vmk3?=
 =?utf-8?B?RnJnRE5qc1FSUndId3p3ZFF6QTAzckQwc1ZzNmN5UFY4L2xpOWVadFdralF5?=
 =?utf-8?B?R1FzV01PQ1RsaGhGaUpDelFVYkVISVhoeHBNakhHWGczQXVDbnk2ZFlsS2x6?=
 =?utf-8?B?bnp5S0hMV0UvUmc1N210TGVxZjF6aTRSdVhQZStOYitndHRtU0x3dFdVTVU5?=
 =?utf-8?B?b3BnV29pVUtKRnFhRnlHV3drUUl3QkdoTVF3dFZYeWJSSTVsZ0hSSThuSmc4?=
 =?utf-8?B?UGFYTkVrL3BINEFBRWEyMU4yY0hkZ1hIWVdncHNrdU0xSG4wNG04bHdXVzht?=
 =?utf-8?B?WCs5cUNiNmp6a2lTVURSN2dTZ09ySEZHRmpOQVhDSW5zUXFUcWZ5aUVtUll5?=
 =?utf-8?B?MUhwSXYzQi83VFRoWUVDMGY5NGYrUFo4a1JwVVNObzBFU3RxeitSb0FZOHRy?=
 =?utf-8?B?VjR6aWE3b3M1VlM0dis4QkJMc2VZWk41b2tYZGhlMjlvMm55ZEZIUktIdGhl?=
 =?utf-8?B?a1R2OExNY052cDBVb2tXNTBkMDIzV0d2YTRaSVd6S2J5VU9XNk9EUlc4M0Y1?=
 =?utf-8?B?c1pua2ZkSXNBY0JpT3N2bEpWZC9vVGowMHRNckNUSHI0WGdWNzgwU2VCejFH?=
 =?utf-8?B?MWRwRUdRaHIwSUh2T2FLRjVQclVjVEhuOHBUWDF4V0w0RDg2RkpFYlN5cnlo?=
 =?utf-8?B?Ti9vK1NHenpVeXBOOWZkc0s3aFZmWElSd2t2dEFibVNXRVgzelRoc2dlME1w?=
 =?utf-8?B?Q1ZBbEFnbHpaZ2tOQTg0RHA1eUVidmlGMGthR2p5Q2NDRGJsWmxhOTVHWW5J?=
 =?utf-8?B?UTRncCtDYWFuSTlQdS9iT2d2N004ZDJFYTJtbVRqMkxMNmd0YnY1OHVNelZK?=
 =?utf-8?B?VmhpNjlySk9adEdPanZ3eGo3aW1DRmFEeldhOVRBTlMxMUhmN2xIdGsrMURv?=
 =?utf-8?Q?L9eo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ddce2aa-0467-4805-2db3-08dce45c0d9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 10:05:19.6225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AOEyccpqp/Resxp0jNiv7zzWKXxMWqPJF9tViNcJrqy2msTAtGhaAoe0yLb3VLjB8CHDskFUf0cckbvdN0mB4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10073
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDEvNV0gbW1jOiBmc2xfZXNkaGNfaW14OiBFbmFibGUg
QUhCL0lQRyBjbGsNCj4gd2l0aCBjbGsgYnVsayBBUEkNCj4gDQo+IE9uIFR1ZSwgT2N0IDEsIDIw
MjQgYXQgOTowNOKAr0FNIFBlbmcgRmFuIChPU1MpDQo+IDxwZW5nLmZhbkBvc3MubnhwLmNvbT4g
d3JvdGU6DQo+IA0KPiA+ICAjaWYgQ09ORklHX0lTX0VOQUJMRUQoQ0xLKQ0KPiA+ICAgICAgICAg
LyogQXNzaWduZWQgY2xvY2sgYWxyZWFkeSBzZXQgY2xvY2sgKi8NCj4gPiAtICAgICAgIHJldCA9
IGNsa19nZXRfYnlfbmFtZShkZXYsICJwZXIiLCAmcHJpdi0+cGVyX2Nsayk7DQo+ID4gKyAgICAg
ICByZXQgPSBjbGtfZ2V0X2J1bGsoZGV2LCAmcHJpdi0+Y2xrX2J1bGspOw0KPiA+ICAgICAgICAg
aWYgKHJldCkgew0KPiA+IC0gICAgICAgICAgICAgICBwcmludGYoIkZhaWxlZCB0byBnZXQgcGVy
X2Nsa1xuIik7DQo+ID4gKyAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGdl
dCBjbGtzOiAlZFxuIiwgcmV0KTsNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4g
PiAgICAgICAgIH0NCj4gPiAtICAgICAgIHJldCA9IGNsa19lbmFibGUoJnByaXYtPnBlcl9jbGsp
Ow0KPiA+ICsNCj4gPiArICAgICAgIHJldCA9IGNsa19lbmFibGVfYnVsaygmcHJpdi0+Y2xrX2J1
bGspOw0KPiA+ICAgICAgICAgaWYgKHJldCkgew0KPiA+IC0gICAgICAgICAgICAgICBwcmludGYo
IkZhaWxlZCB0byBlbmFibGUgcGVyX2Nsa1xuIik7DQo+ID4gKyAgICAgICAgICAgICAgIGRldl9l
cnIoZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSBjbGtzOiAlZFxuIiwgcmV0KTsNCj4gPiArICAgICAg
ICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICBy
ZXQgPSBjbGtfZ2V0X2J5X25hbWUoZGV2LCAicGVyIiwgJnByaXYtPnBlcl9jbGspOw0KPiANCj4g
Tm93IHRoYXQgeW91IHVzZSBjbGtfZ2V0X2J1bGsoKSwgd2h5IG11c3QgdGhlICdwZXInIGNsb2Nr
IGJlIHJldHJpZXZlZA0KPiBzZXBhcmF0ZWx5Pw0KPiANCj4gSSBleHBlY3QgdGhhdCBjbGtfZ2V0
X2J1bGsoKSBnZXRzIGFsbCB0aGUgY2xvY2tzLg0KDQpZZXMsIGJ1dCB3ZSBuZWVkIHRoZSByYXRl
IG9mIHBlciBjbG9jaywgY2xrX2dldF9idWxrIGRvZXMgbm90IGtub3cNCndoaWNoIG9uZSBpcyBw
ZXIgY2xvY2suDQoNClRoYW5rcywNClBlbmcuDQoNCg==
