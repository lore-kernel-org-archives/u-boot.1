Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E44DD49205
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 10:00:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E29089454;
	Mon, 18 Nov 2024 10:59:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="HjMXUta9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5EF889459; Mon, 18 Nov 2024 10:59:56 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF73089454
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 10:59:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJOsdu7n0wjxuKb5KZlC+F5bpD4EqKV8jrzjBc8cCJuXIJRWsQzlISTpUDYEHF2nUstIb6zSiqMsIgPLznDqVVlp3irsdwQ4rJnC8lqnY65WBQRhY/wyi4MQkoAg62exHXGKTYLjqqLe4pxN0n4uGNT7hbAuJPt8JVSL7gZ/cmBogv599q/xJIM1dXu6qBPj1kV9cKJ/9nDJbiZkQoenPvPI9kUV1EHfhyK/v/3qUuU7Q2FImEODV6aH0lFuVdX7AJkUX8jzyWOz8iNFTZ6drlk8x6yXTh1ovSzp8fT0v44lZgggKqoJi9TX8+Pb+0SiFOTpiWBcoRXUJM/Yky2xag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7e+uK82NrS4FcjcWKR23O0ZNN+cTD8lSTM3d1TbWbQ=;
 b=r1TGF1WsHUqX6QfxxFAzuUfZqBEx7VEFNx7dUU5abO8X/4JIwXbrHjlE3A5FISk++CjsBxyJjg3sWWmRIzORVoN1T4mJoR4f9UJRbOp3XePEM3Ep2o+s8oa29m36ckWhkYbHM2c3d6rP+AEvFE/12gxwaJwYVriIsu9cwphD7iUewpoQqTvdfX+OAhtyFe/0K8T6LrynSRIMo7TN2L1e3G67fW59ZX6N+Jp/Ks04ladDN2+WuRDgHv4Grq8oxpuj7udqbkZivltGDOZyYsCZn2VlgOBdMTf4uIlgD3/Cs/qx1YKpFXKL1NQhD9Y7K3OSAHTx3J/S5a0y56yyiTuGnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7e+uK82NrS4FcjcWKR23O0ZNN+cTD8lSTM3d1TbWbQ=;
 b=HjMXUta9T04R8A+Cgq8l0xWJGB0lINB6KZzaLwkR9tKABzddc6D34pP7bd616mRUC2vV0AaSbrVH+nqG0F54LNUmrp3kCigdlZFPOh3YqB2rIUPwJNt/ZjflMwg0dbF8/qYQkPDuuLT3BUygMhnTahEuN79dRDrGjXvFQUJ8cr0NhKddzK4Ys/9Wyj/bAU4ddYHFbwQfchNh9ckGP2XT85dvLQopLaNDrqkbLmNRV7Ok4CE5WUg4uwxQULPRlC1yJyyUWI4nKlA6+1lKdyhwS2s+k5StGDRJoZfLVVkf0H6Om/Gd2IKIu27kLhGsKy3S0kk2PYahBpNDcUpj5Nkg4Q==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS8PR10MB7664.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:639::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.10; Mon, 18 Nov
 2024 09:59:52 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8182.004; Mon, 18 Nov 2024
 09:59:52 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "hs@denx.de" <hs@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "ravi@prevas.dk" <ravi@prevas.dk>, "marek.vasut+renesas@mailbox.org"
 <marek.vasut+renesas@mailbox.org>, "festevam@denx.de" <festevam@denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "chanho61.park@samsung.com" <chanho61.park@samsung.com>,
 "Leto, Enrico" <enrico.leto@siemens.com>, "randolph@andestech.com"
 <randolph@andestech.com>, "igor.opaniuk@foundries.io"
 <igor.opaniuk@foundries.io>, "andrej.valek@siemens.com"
 <andrej.valek@siemens.com>, "cl634@andestech.com" <cl634@andestech.com>,
 "bastien.curutchet@bootlin.com" <bastien.curutchet@bootlin.com>, "Schweizer,
 Walter" <walter.schweizer@siemens.com>, "sr@denx.de" <sr@denx.de>,
 "ycliang@andestech.com" <ycliang@andestech.com>
Subject: Re: [PATCH v2 01/20] wdt: imx8qxp: add option to control external
 PMIC wdt via IMX8 SCU
Thread-Topic: [PATCH v2 01/20] wdt: imx8qxp: add option to control external
 PMIC wdt via IMX8 SCU
Thread-Index: AQHbOYLxE4AibW+bNUu42ep9q+0iHrK8zjGA
Date: Mon, 18 Nov 2024 09:59:52 +0000
Message-ID: <0abf70ba78de1885f3a725470e398c3c7e3134a8.camel@siemens.com>
References: <20241118062715.32989-1-hs@denx.de>
 <20241118062715.32989-2-hs@denx.de>
In-Reply-To: <20241118062715.32989-2-hs@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS8PR10MB7664:EE_
x-ms-office365-filtering-correlation-id: d3586575-0c0e-4c9b-da45-08dd07b7bf2c
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?eEgzM2doUm42QmV2ZEFwT2hxSmJCcGZRZ01jNy9VdG9lTEpYQlNPc2o0ZW1v?=
 =?utf-8?B?YUtDc1hRS2JOVEdEckptKzVvZExZS21HQjgvOW1ra05JVUcrcUFwNk1Kbk9z?=
 =?utf-8?B?bmVuR2dHUysvVTVhd0x1eXNLdm9jcldGSUFKVmljdnFBOUhMMXNmMDBmOWlZ?=
 =?utf-8?B?U3JSazdST2t5emZtM0E1K2NIWXUwR2NKb2wzOWlxOHU5cFRmQjhOYXhVb0VL?=
 =?utf-8?B?RnREZ0l2eEhSaEdVMVpyNDhtQm95WlNjam5uS3VSZFhuclZycEJ5Y3pZSHlJ?=
 =?utf-8?B?TUdNeDRDNzVsSG5sc21PUTZzWjBmMU8vY1FYeHNhTndpdGNUR216ZTBibTFB?=
 =?utf-8?B?TkVJN09MVnY0dzBRNFN1RUdzOGVObGtlWTdsMVhOdmF0emJ5M21qN2tZV0dQ?=
 =?utf-8?B?OGt4cXFXYnpDbEoyUU13YUtFY2tmOXBTNXd4bUh3SC9yN0NFYkNoNG8vMTgx?=
 =?utf-8?B?bXFZWXVjbFBuVFgrNEY3aWFrUmFMVXNtWHFKdjgwdHVBZ0RmWHljNHE0UTVO?=
 =?utf-8?B?bGE2Ky9GQW1DWDBoODhxUHhGRGh6MHVsZ0QvY3VlTWlKZTVsRUszRUxkRU5Y?=
 =?utf-8?B?a3N2NVB1Zi9KcFhIcExwTGZlNVVMRTRXTG0vMXFaR0d1QzN5MFF0YnAzbGlJ?=
 =?utf-8?B?WGQ5d28yYThRM0VqdFZOTG9UcFhnTm1ibHJoVW9UYUNrNFNLUnFnekNDUk5X?=
 =?utf-8?B?OE51OUdKemNUVjdLNmNqVkN3QmJ0VWFzb2FzK1A2SGNnNkIrZ1p5eTIyMGlw?=
 =?utf-8?B?T29pM1kyZW1kWWVqL2dsTDlVMEhxQ3FiQ2FvWnhmZXVpLzgyTzE2bnZxOU90?=
 =?utf-8?B?T1R0UGZ4azNJb2l1c2syb21hUzdSbVZ6WWYybjRwM0ZteUFyYTJxZkNTUlhF?=
 =?utf-8?B?ZHFWemF6UmNFUGxVRDhObkpMMHJzQjJ2bzRGMTlsUVBtNVNYY01zdlJ6RmVl?=
 =?utf-8?B?Z29lcGRFNG4vNUlVbDEzeGdLMkRFVjlSZ1laekljRUdpY2daTFY2bWtsK0p0?=
 =?utf-8?B?d2ZzTEdPYzBNdTNvVnNSa3FET1VwWjNjQWFzaWQ3bjB6aTJxZmgyZUhyQVpY?=
 =?utf-8?B?MW5lQ056c3hZSXAzSmlteTJmQ290VUp6V0FXS0pDT2NSVHpQOTNwSU1aMC9W?=
 =?utf-8?B?RW9kRFJ5L1VUVHB0cGI2WGFvQXJjSytFQzBpYlJPL3N4bm0rc3o0eE41eGtM?=
 =?utf-8?B?UldtbjJwcTZycXdvTlhYNS9OODRhRmx5dFg0TFVoekxzd1VMVlRIMVlmbWQv?=
 =?utf-8?B?aUJmSTliYzhkV094ZXA3YTNncldGMWplZFVkcEpTYUhCd1FXUGE0L0ExR0pq?=
 =?utf-8?B?My81dE1rcW1oTnkyYTdDQThycjlZT2did3pSekJvZVFUa2h5YkUwcFdiR0Yw?=
 =?utf-8?B?UjBWZE5vMGM4YWZNc3o5d0FZQ2ZsRzhqNnYyUkRKYlNacHhNdlpJV0g3Zmp1?=
 =?utf-8?B?WEcrTTlCRklIbGhPVWVsemRwdURQem9LVkhsNlphMWNqc2h3MGlEMTR2RnJT?=
 =?utf-8?B?WnVtaVVjaEFkdWhYSlRUcnJtT2NoQXBGQWpvSlRBaFVjQUVWK1JJMTJRNDVu?=
 =?utf-8?B?VWpDbi9nVkVRaVVmaDFRL2NSSXA2Y0lEdDRwYkJJakdxUGw1bUl3NkdKREhV?=
 =?utf-8?B?Qi94TnRHRlF6TzloUlN5NThuQWZONXdBbnU4RlJGazBHbjNxcFZJdHlxOXp2?=
 =?utf-8?B?QVN2VGs5UVNENGwxUUdGNVRPUnZIOERLcFkwcmEzQy9zdUtCSnZiMHFUSktJ?=
 =?utf-8?Q?+VmLQWJ1/0ZSw5SifMWSeifPCud7bn6sNImce0U?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFZzY2JYTkhNZnJQbm5HcWZMZVByWkxnQ1llbDVodXhGTm1iQTNwUGVWOUF0?=
 =?utf-8?B?bnpkekFDSU9DVlB1T0dSL0VkQnFxN0FzaENQUFZTc3VaK0tWcGpIZjJtMVpF?=
 =?utf-8?B?M0JBSDJRMWxHNUNDeVRMNHB1SU1hMXRUcVd4d25TYWpvMWZKRlY0QXEycWFN?=
 =?utf-8?B?akd1VGFKUFFudFJCNmtuMS94WFg3K2VBNVlrSVVqYll0TVpKUmJiNWFOeUN1?=
 =?utf-8?B?RlNSRE4xQkJJcDBYZjJGazFYNkZJT0lreEdTdElHT2NvZ1RRV0JKbENMRExX?=
 =?utf-8?B?TTBsNWJQblZiNktCNllUM2NqZXlBUkJvUnVHbXJNZU4vNzZLYzFJVmZQa3F1?=
 =?utf-8?B?cDQvMlowVUlhVHBlRDgrV3AyV2EweUZGMTM2NkxkWDVsU0J0eDNxSDNHMUxB?=
 =?utf-8?B?c3RUWmpqUE9FbitubC9EdTlIQnRlNk1rSzFZUFkyVUpMSEFhdFVtUDViQlJU?=
 =?utf-8?B?MzNPR0dPaFd5bGhOeU1yUmRxYU91Z0NJdjRZaDl4RFB5ejliYmpWQjZteFBH?=
 =?utf-8?B?alRIVzBvcmNHOHRKd3V1aDZTQUhBT0Nlcm1uN0JvMmVpaTdDRDhScnMxT3F1?=
 =?utf-8?B?a2tLQ1d2U04vb09hNEZ1U3pGWVM2K1ZGeG95dVBwSTVwTklHMU04dHlibFVu?=
 =?utf-8?B?NDVSN00xTXpzd2NHcnhjUHR0ajYrSDJvKzdtQzNjdktwZVlaclFHSFR1aThZ?=
 =?utf-8?B?TFFEUDlqaSt5ZlJ2UHhtaVJVSGFoZGh0d1I2cWN2cGZjNTJYWmdHZkMraEtG?=
 =?utf-8?B?czRPTXBVdzRsdGhPVXlYUm1ZUlg3SDgrNGk5aTRoQVY5NHQ2Rm8xeE1vTVRH?=
 =?utf-8?B?a2VxWkt2VkdQejBBa2kyS1hhMEIreFJCM1c1ZC9wdUJOdCt6dUNPZkpja3Bs?=
 =?utf-8?B?dVpZS3lFaitGUGwyc3ducm1oTW1hN2p6Nk80R0NBNVV6bHBpdnV5RnVVTDlv?=
 =?utf-8?B?ZWpWcXNVSkxsQ09tZ1VHRlk1MlFPZnk3UmF3RUdLcWMvbCtrSDhxbFQxaWNs?=
 =?utf-8?B?RWVGdTVOQ01PZm05OFhacVhCajRMZkpiNE9QTTlIZTF4SzEvSHJ3d2w0a01L?=
 =?utf-8?B?K1A1akRxUDV4cnlmYjRyMkFzQzZ4UHR6Mk9zdTJxeG5MTG9WN2pqaUZNMTZ1?=
 =?utf-8?B?Znp6UFNiU0pxblVqMGQ0ZmMyN2pMZDYwVFpWTU9Wa09LdHM2VlJwRkN1Ujk3?=
 =?utf-8?B?Z25UUGgvbXFGTHN5Ry9Cak9kcjNKQ2lmZzd6ckRJcVRMN3lYbDgrV3JVSUpv?=
 =?utf-8?B?eDg4RzFCQitBckswaDBBTTJYWXVsMFk1bFY5UmNYTDZ0czFHTEpMYUcwa3pF?=
 =?utf-8?B?MjRmRitRS1owemZCaDZUYnA1cHUrZlpJYVhwUUpPaU9reDRhbjZsdWhHWEZM?=
 =?utf-8?B?OXdPcUtBSzVHTFpab2JxSDdyRE5qa2ova1dvZ3lvVUJiN3gyOUExUzhqVmNj?=
 =?utf-8?B?ZVFyNHlhMVJ1NE1sSFdOcjNGd0szWjd5eTVWd3lUK2tpZysxT0xrVVhNU0V1?=
 =?utf-8?B?cWJ5aEd4UGpCc2taemJBdk85NCsrVms5NW9UOGxndDZ2d2JoUFJTUW5zWXNR?=
 =?utf-8?B?VG8vY0NGbExleStGT25MbndRdFZGSkdzb1VVaHdzQ21nYkZzRFVOYi9XWnBR?=
 =?utf-8?B?TUtOOE1XREtKUDhob0lqa0lvbzNvK05CWkR5V3ZIZ1YvUXhMRk50R0wySTVV?=
 =?utf-8?B?MkEvSXlIQW9NWDBHd2lwcERjLzBRZFhHL0dzK0dTSWtsUEt0L0RhZ0N6bFBj?=
 =?utf-8?B?djQyeHlxcnI4NGo3UDA4YWRjMkdzek4wbGhqVGJnTnZUN1UxK3ZGeUV1U0V1?=
 =?utf-8?B?c0ZNTXFFdHlCdWVpZXRESG9qaVlNOFZNZGZDNHRuVnlKcTdyaThNSjUxRDh4?=
 =?utf-8?B?Nkkrak8zTm1RQUNDQ1UvbkpKWjM1VW5BZkFQd0FtbHpLd2hQTHpWN3pJaks5?=
 =?utf-8?B?MW42cFB1bXEzRyt1cks5SGlmb0VpSEtNS25wYW1uRWpUWG43cmFGT0prRmli?=
 =?utf-8?B?VkErS2RmYzd0WmFKS1UrSTZVYkFsQXBuZG9PYlIrNUJFZW5RcS94bWZVZ1R4?=
 =?utf-8?B?YlU5TWFranVWTmg2TFZiUkswMUdXTDlTbVRsY21Eb0JrdDVqMklyVGpMSzNl?=
 =?utf-8?B?S2szMWxFaUlPamlaS3VPcnhvRU45S0xDWGVrWnlQK3pSWDNhY3lHTGZnVTNn?=
 =?utf-8?Q?/+CUeLF1oqZy2kTNbhRIEAc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40B38C7D4530B143A2675889AD96E868@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d3586575-0c0e-4c9b-da45-08dd07b7bf2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 09:59:52.4173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D/lxMgB2gVP3X3IqBu6/5I1ROI4lonecjwJ3QLcUDoZIezFy1Nx4szPDnG+BPZLjo6rSKQH0nv6+YA9H3z5PX4IXnldYh4otRxt5MkH/rYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7664
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

T24gTW9uLCAyMDI0LTExLTE4IGF0IDA3OjI2ICswMTAwLCBIZWlrbyBTY2hvY2hlciB3cm90ZToN
Cj4gRHJpdmVyIGZvciBhIFBNSUMgd2F0Y2hkb2cgdGltZXIgY29udHJvbGxlZCB2aWEgU2llbWVu
cyBTQ1UgZmlybXdhcmUNCj4gZXh0ZW5zaW9ucy4gT25seSB1c2VmdWwgb24gc29tZSBTaWVtZW5z
IGkuTVg4LWJhc2VkIHBsYXRmb3JtcyBhcw0KPiBzcGVjaWFsIFNDRlcgaXMgbmVlZGVkIHdoaWNo
IHByb3ZpZGVzIHRoZSBuZWVkZWQgU0NVIEFQSS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJl
aiBWYWxlayA8YW5kcmVqLnZhbGVrQHNpZW1lbnMuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBIZWlr
byBTY2hvY2hlciA8aHNAZGVueC5kZT4NCg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRlciBTdmVyZGxp
biA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KDQo+IC0tLQ0KPiANCj4gQ2hhbmdl
cyBpbiB2MjoNCj4gLSB3b3JrIG9uIGNvbW1lbnRzIGZyb20gU3RlZmFuOg0KPiDCoCAtIHJlbmFt
ZSBkcml2ZXIgZmlsZSBmcm9tIHNjdV93ZHQuYyB0byBzY3VfcG1pY193ZHQuYw0KPiDCoCAtIHJl
bmFtZSBLY29uZmlnIHN5bWJvbCBmcm9tIENPTkZJR19XRFRfSU1YX1NDVSB0byBDT05GSUdfV0RU
X1NDVV9QTUlDDQo+IMKgIC0gcmV3b3JrZWQgS2NvbmZpZyBoZWxwIHRleHQNCj4gwqAgLSBhZGQg
Y29tbWVudCB0aGF0IFRJTUVSX0ZVTkNfQ1RSTF9QTUlDX1dET0cgaXMgYSBzaWVtZW5zIHNwZWNp
ZmljDQo+IMKgwqDCoCBTQ1UgQVBJIGV4dGVuc2lvbiBpbiB0aGVpciBTQ0ZXLg0KPiDCoCAtIHJl
d29ya2VkIGNvbW1pdCBtZXNzYWdlDQo+IA0KPiDCoGRyaXZlcnMvbWlzYy9pbXg4L3NjdV9hcGku
Y8KgwqDCoMKgIHwgMjEgKysrKysrKysrKysrDQo+IMKgZHJpdmVycy93YXRjaGRvZy9LY29uZmln
wqDCoMKgwqDCoMKgwqAgfMKgIDcgKysrKw0KPiDCoGRyaXZlcnMvd2F0Y2hkb2cvTWFrZWZpbGXC
oMKgwqDCoMKgwqAgfMKgIDEgKw0KPiDCoGRyaXZlcnMvd2F0Y2hkb2cvc2N1X3BtaWNfd2R0LmMg
fCA1OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gwqBpbmNsdWRlL2Zpcm13
YXJlL2lteC9zY2kvcnBjLmjCoCB8wqAgMyArKw0KPiDCoGluY2x1ZGUvZmlybXdhcmUvaW14L3Nj
aS9zY2kuaMKgIHzCoCAxICsNCj4gwqA2IGZpbGVzIGNoYW5nZWQsIDkyIGluc2VydGlvbnMoKykN
Cj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy93YXRjaGRvZy9zY3VfcG1pY193ZHQuYw0K
DQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=
