Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB85D0E6D5
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 09:24:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1F1888901;
	Mon, 21 Oct 2024 11:24:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="a2Hbu7Hu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D95F8841E; Mon, 21 Oct 2024 11:24:27 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0E8188D9B
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 11:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmYKaeeMGSkD6cAKJ8aK+rpJNFIJ/Xjo04KsgQjULHH+MpvXQXDcxcm7aMr6jfnQMM/veAJCN9UtozBVtduixASkBGrAunv3hQa1uxqcOjLGSULgL/1FNzutBXzVrEe9USH3thwSsOwWp6C9KSYtM6R8LM7VKkkz96e2YXtLstNQfIzVNPE1bPhvxGkegYkSY5d3p1sB9k2BRjIBw52lu2Zrbzl/Bh+XAJgNTNvPeH0yXgwDIwAmRKt0EQ76Xw31RdA8anPDxE8RcSl60lByY03oEt5YUX6Gw32remgYaOacmlNawXtiY5Di6CwNOW/IaIB0QmMQDn1nAPNSnlWaog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1+YbYJzqN3RDXrBG0e/AJd4dfaPHvF3hsh3tEgTDq4=;
 b=nEUlptPrWOCpANCmqZDrcnAdBskCi3hrIlnvw+gFpNGomN4+KM9BEpdnjRvNAi6+250V2V9uGQH0J8GiGHIXp/ofKIlUSzIiVDLAcDB82BtDeRxBjJ3KR5AUfByrQOztlznSck15OT3nT3YChEoyxmSalWgHJzPc+KHPV0oGnLoIfoP4c2MFjwJv3Fn4FPZ2FSMZj6oMpGdV3aAzqDtTMt48yPniVHADqYBja9Vj6Prw0TmQT6b9tMtKWaZz0Fh12M7D7ZFd5bfafJe/XG19kyNFrDlOFkGAqDoojJzNx73zyrrw5pKDHw6HBVh1CQjLtFByCnthQos2C3wlcUzCKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1+YbYJzqN3RDXrBG0e/AJd4dfaPHvF3hsh3tEgTDq4=;
 b=a2Hbu7HuDW6NziLs/uzyI4mYZc1NkthJH/FDlmmUAGCKtizpUypCq15/fdqOvxlRl5vJ/GWiNOv0TMuTJI+AZdisPpCOqU12cy4zUjIsQ9WX11XKJkL67CGaj/DQN1PCNgJPanQBEn1QC+lLUHVdwhI5k6cTdXXRAdV3171ZCv5/3OdbyzEw2BgvjhgwSoebPjDFEC380h7u6ytMh/a1lq0bri4H+lHwml1HMBEb7A1BDu/AmSfukWVRNBee/u5u6sstog4ZAJ5ucNZfQ953GhF6mrwi19OJKpt0El34VjR+1WgDibtBAKPmwNvRldvhNJ3JiiAvvPytvFLW5z7dww==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB8042.eurprd04.prod.outlook.com (2603:10a6:10:1e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 09:24:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8069.016; Mon, 21 Oct 2024
 09:24:17 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: dl-uboot-imx <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, Fabio Estevam
 <festevam@gmail.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Igor Opaniuk <igor.opaniuk@foundries.io>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Michael Trimarchi
 <michael@amarulasolutions.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, Tom Rini
 <trini@konsulko.com>, "u-boot@dh-electronics.com" <u-boot@dh-electronics.com>
Subject: RE: [PATCH v2 1/2] ARM: imx: soc: Select default TEXT_BASE for i.MX6
Thread-Topic: [PATCH v2 1/2] ARM: imx: soc: Select default TEXT_BASE for i.MX6
Thread-Index: AQHbIzM+DRBBI6lhREihZcrcwzDvgbKQ73cw
Date: Mon, 21 Oct 2024 09:24:17 +0000
Message-ID: <PAXPR04MB84590A140749D510CC4AC0CE88432@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241020210113.1248062-1-marex@denx.de>
In-Reply-To: <20241020210113.1248062-1-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DBBPR04MB8042:EE_
x-ms-office365-filtering-correlation-id: e0986d7a-7ede-4fee-bd14-08dcf1b222e9
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?N3cexY6Tk46TPI6hMFbR+nCCzIPGz5TO6aLJYuU/rxz9ZInqKCnXVU3kevKd?=
 =?us-ascii?Q?/v/AcsgRztc1n9r+L4Vi4OvT2uRxI85cs7TpS4oWKiCmlI94YyDILLv4OAX1?=
 =?us-ascii?Q?oP686h0GDygVLGw6q7y5/UWQrWhqcnvYKI6PWpqCGAahW+Vko4UExiD3KPe8?=
 =?us-ascii?Q?paowgACu9Jxz0dJO2ieIIISgmLBgwwhxmTuZrFrzC50QtvsCZLwL+BzE9TEG?=
 =?us-ascii?Q?ZYQBABQojWxUpiMJf3rJ2lFPLXC7SFfqZWTa0j5vNbnVxQjYY5H4nAKmw+nB?=
 =?us-ascii?Q?e57KCz0qIgGMHnOPyJAEbvQQ/Hmxn8HVcFDtWyu8hJFverlpNbFswo/FDe+g?=
 =?us-ascii?Q?YtDdkGOWNVASQG8Ke1VLi0s5yFj2z5QRk3jcRgtfRlHS0BBQedWAFPRL4XPG?=
 =?us-ascii?Q?GLEJaJRsPcP6TT5sdf52tdZPdSDq4MU83VQ+zqjOCpd9n9JHiOvTD+2X5gL7?=
 =?us-ascii?Q?iPro5SEW17Zm06FsEU/TB7uCGHew7/hF5+sfzn8qS5QHNeZSSyhU7PQrq310?=
 =?us-ascii?Q?hiTlR3wRcAjMUbkUMiBy+S9BDuLo316a1fdcQZniMN/V+LQrq6ofbbkTV01m?=
 =?us-ascii?Q?DX1IEWJZFhz+19qsm8LTaRvPO0Hw2pN2rQsS3seLOZIXdTXubWKgSSQr/5Dh?=
 =?us-ascii?Q?2tRNpFQU4EhSuCtWuH33VSgsNNqjjHTGMNJZAdafF8jt9OLAuEXp0cz2qVdf?=
 =?us-ascii?Q?C8zbuJeTyGph3ksAzjNq7J8T7/gtuvJPztKYfpO/Z3kuXKL988xakoIQ03xq?=
 =?us-ascii?Q?czO4cVI0biMHkW4lJ2VvOro5NTVQ0y72bh+IDSs+YWXeugxMG7XIf7WCQrwH?=
 =?us-ascii?Q?Kwk6xVjTLGxAvluzMFPSooeCkZMiJ2mcr4vol1t3eDAvHamVdof0Zs7SNS8i?=
 =?us-ascii?Q?reDef5EC/6lNbyOmvh5nwqfYK8f6RJUgUJFMJFUZYdtkfLz1iLNnA0jB22BP?=
 =?us-ascii?Q?S3meseqBPiPTWTtG7DWtnAtAWgxFm8znBmYm9As+L4u30JhbWbpm13q0g2Yg?=
 =?us-ascii?Q?o7t2G18bQr+EKb1dmElwv/UrRpZTNLtosr/3Z0ImdkfN2ZGQlReRitmtftMB?=
 =?us-ascii?Q?bjYVJW/cDxd3ko9+XZ5VSHowR9KLz+7r48sWyOVkAU6riHveupwpupzWXugC?=
 =?us-ascii?Q?AD5XaJZfExfvBML/FZS4mMycvayzPH0fyl8hhBmEmxSZIWNxDxQJ7+NpzmKs?=
 =?us-ascii?Q?ar74+VwPdp+qHZzPa5wWdnMRjk/UGmcQkQD9R6SxqzvRtiRcMWZn8/O76EGS?=
 =?us-ascii?Q?1ibytuK8dsX+uUeYSWzfaMLE/2xtwTy5ZgndIQafYaDq5HJu0Mol7NSX6BjV?=
 =?us-ascii?Q?5lSz0AtGKo6pf7MZ9jW84eLTAuN9qgA/R4B1Gh4tzCcMNFIhNBNwoGLao+u7?=
 =?us-ascii?Q?UVHM+g8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LFnM1N3rxy8NWRPLdqInVZERyUXVj8D7uXU9HdOInvC5KUMdOhQwafB2ezEG?=
 =?us-ascii?Q?QLMYSVBPClMNblQSBWr410TrgIQqBDk8U+u9UM4wmbJ1pfXdK9s57x8bG4FW?=
 =?us-ascii?Q?Tis9OecPlj0j7XDIDpZKaC6RCM7p6v0Vll58m/XSLgvO3EjGHeJGlmOT2Az7?=
 =?us-ascii?Q?Chk3yzKx++Mvp3l951XF4+ls0+Zi72NBk7ansNewNg1Vu4lD2OBqxZp+a+Cv?=
 =?us-ascii?Q?02oIVHQeip8F3MewcZCB5asHHHWiw0qJWu8vdj8HK5+VrrKxGCiJjPnGgJHb?=
 =?us-ascii?Q?G7Qtj4P7VOYFXBKGdWkLLzi48snO3ZywUALakL+L67mFsLQBajDbtRGnpfO6?=
 =?us-ascii?Q?0jhJue2rB92sCk2F/+XOW35ysbaY/ddjIe7SH0kN+uQfq8DewBg9KfYKxmTk?=
 =?us-ascii?Q?1uUljyeLV4cazvoGdJYYpt5FsHJDx2+r1NWwevFjI8MAZOHbke0cqryF+zWJ?=
 =?us-ascii?Q?n6X2TOyXP7S8ANrnvIdD1Qn+QkVga8WJ54eqmZZFLRdCV2gsisSqLCe45bT+?=
 =?us-ascii?Q?5NWqmGyTZPynnpXDn4L9TlyDwKUtpKoG0F7F1Kiqn8te/K/Ef6QpzusfbNtW?=
 =?us-ascii?Q?Xk+TSIgpTrsXuHxX2157e7KxBHV0FT0BuVTcRsIB/UKoaPEoNOh2sb0bInL2?=
 =?us-ascii?Q?+PaGrIKwniPkD0Q8vwBp9YurCPy4fNdkgEzN9uZIhEq2eQwYIcSReDeXYzzu?=
 =?us-ascii?Q?USIUWmQZ3keggDPCt9WMgs/Imb1IE+WY+VCoOE9Q9C6Wb7neDOVciuSVkgGO?=
 =?us-ascii?Q?dvA35Wd7D7qO4kdK3O28bx+upSDfNFbRTVVnVrltORudkCkfOZlubM/tLlVT?=
 =?us-ascii?Q?mD3XlYsdGF3fUfzUR8Yiify2tEYjlKfHtMIHy25qZ7U46paIPOkYVIHNLUDY?=
 =?us-ascii?Q?cvNBHD3z4zEqzluokR7iF21zceTi6uSZCaVcglu+p6wkNK4Yrda5J73P26FP?=
 =?us-ascii?Q?ZeBfJrHS+h8HkwFa5XTaNLHTI8dbcA+QsDm3f5rG8JLD8xQKWxV9HYFdFsCu?=
 =?us-ascii?Q?5bjxovtQytzHsOkw5uPhJsXIOaAQUaV6cTcXIMfeSOO1a/AYiOgw8MmriMEF?=
 =?us-ascii?Q?1P5UVEN9ALfqGbTPydBk4ybaFNx39Vro5U2X8S7Y4BmrcfsAyI8G3sVgmz5x?=
 =?us-ascii?Q?WPG5wGZL69+/E28SipmcP91TrpDLyBAxoCKwMrxZfDJFEyDjU68GQ2+Cx60c?=
 =?us-ascii?Q?5rtXJPDrBeItYHgoTTnc6rqPnSQFF6G3f5Y9pLIZVDzLpxLbe1eTRHgft0N3?=
 =?us-ascii?Q?dvmX39INxJFB0ZA6NygEwUT8T4HdXmWwNivPHDyLSw9aXJ6PTCAy7qwU6K+B?=
 =?us-ascii?Q?fWeCehtNAFu/k+80J7FLqTm3WDG/hwnUlTUN7JFrf46wDM4v0KHIyQO5gUfY?=
 =?us-ascii?Q?wv80zcYZUcQw5HBj3qRabjVOSGgjGfrYJOfMmQyYdx8BcUHiA3RnKDdhTzyb?=
 =?us-ascii?Q?tBQoDeYDSyfBnor3yXSrU68vAw3BYy8LeGItwYrgPFvGJxWQGbpl0SVSVvYP?=
 =?us-ascii?Q?ifjScpknrwqXteMul/9vVbL/qEM8O04lmMD7b5AZT/zduYS5nbUCxoX+xByn?=
 =?us-ascii?Q?RXT3UPIPwWBVftwlgZg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0986d7a-7ede-4fee-bd14-08dcf1b222e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 09:24:17.1888 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoGIGyMQ2ooPJiCzvAnXtQBDprtAZyqTX1fVS9xh4XEl213mmBmQme2Rv/U4mPCQN2K+HzlBJCYG1XtbfMWPtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8042
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

> Subject: [PATCH v2 1/2] ARM: imx: soc: Select default TEXT_BASE for
> i.MX6
>=20
> Select default U-Boot and SPL text base for the i.MX6 SoC. The U-Boot
> and SPL text base is picked as the one used by various i.MX6 boards.
> Update all the boards.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
