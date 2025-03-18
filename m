Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732DFC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 05:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1689805D7;
	Tue, 18 Mar 2025 06:02:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="qoNh+LaU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14BCF80F70; Tue, 18 Mar 2025 04:01:45 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C853580107
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 04:01:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F73i1I60EExIiJTxBAY0cPGY/FnXHJUAyfdDieBduv3ELC/PD9aRHPlCed+/mzuKlgpLRRdnGWBMxkJvkVXciXpJcvR23JjDQ4t9wFOgxA6DI07nL69zAblG1rizvSKuP4HouxKhKx8D1wbe050SakW8ktYFTFcLlL97bS0FVBhA8WhXOQn2+GNpfuaOG3CA1+awbwGeg+ZrNwBl6xuuQd5LGFvsrjuW1xJC8/nPwAJW/tZiB1AjFNXHUMENeN4N/zbv1MhKyKu3paiRCT+aJNaKbuo8rGfeyKNS94tuWP/+Hk0KpfPWxt/d2h2oRFsbSmVRBud0Sjd5SupWxdCDGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/KridsCG40UgxHl5byUQNNh4J+wazQMWfwsSXis2Q8=;
 b=tBbMLCynnFhsS1+h9onfYk7VVJZuNNIpZZnoegs9ZcejPwzoI7AXzpjpui5p6/+OjFWd0QDNRPbKqA+6v+DyFU6mUqlYHyWG7Pkp1YUNvFG8qb6RViQnnjUCtVDBBPVljPnPrCzAUs8te+lMIK0QwaTQUPhVzpwCNfdrsPyfq9LQ5yKvbexV5L2a7klXSHEG9zpqEVPCwUP2Jdrlescs1jU7Wpob/1ahnt+4/sw3/S6AGVDmRgesMJj3EkFAD8nVVKlm2DVMwCih8CuzGka8VmkSB0zAnxnVljjVzza7104DGXqTJv05duijHwiVu8XTHOfR2GEzcYEjcp4dZGVomA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/KridsCG40UgxHl5byUQNNh4J+wazQMWfwsSXis2Q8=;
 b=qoNh+LaUdxdL0ehqeY3F6beGq6QoR9k/W9MsLdiO4MEvGWZl9pWQRULIiRffAHAq6vPbBiX8ZLorW7GUUyxRkC5dqht9H7aS4eUncCmn410XjXKxlf86dY3na5XErvrhOKmsCf26fKmv66auZcMVdoA8oGG9p01Y/OPRipiZxpx+RDJmq6+CUOte//8qy6WuR5baSmvQBXoa5g0bX4loeX11ZZtQu+pvwkliWF38og2BdXmnW0BOtaXAbTrygQ3vSU6qV/rUaIIHJeY50JlFtytegVd4m2A4i2wM34vTj9IvXOpJey2WIFNOY/JaaXOEFHkEEjQodeesBAAhg1/6ww==
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by SN7PR03MB7154.namprd03.prod.outlook.com (2603:10b6:806:321::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 03:01:38 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 03:01:38 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>, Jonas Karlman <jonas@kwiboo.se>, Sebastian
 Reichel <sebastian.reichel@collabora.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, "Ng, Boon Khai"
 <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@altera.com>, "Lim, Jit Loon"
 <jit.loon.lim@altera.com>, "Tang, Sieu Mun" <sieu.mun.tang@altera.com>
Subject: RE: [resend v2 04/13] drivers: Enabled Kconfig and Makefile for i3c
 support
Thread-Topic: [resend v2 04/13] drivers: Enabled Kconfig and Makefile for i3c
 support
Thread-Index: AQHblJbvxrGflIuLPUyNXk13CYfycrNy2eyAgAVga1A=
Date: Tue, 18 Mar 2025 03:01:38 +0000
Message-ID: <SA1PR03MB63709B84A17973FA4B776C31F7DE2@SA1PR03MB6370.namprd03.prod.outlook.com>
References: <20250314040902.43621-1-dinesh.maniyam@altera.com>
 <20250314040902.43621-5-dinesh.maniyam@altera.com>
 <20250314165303.GX2640854@bill-the-cat>
In-Reply-To: <20250314165303.GX2640854@bill-the-cat>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR03MB6370:EE_|SN7PR03MB7154:EE_
x-ms-office365-filtering-correlation-id: 746c1ff1-0d6a-496e-60bc-08dd65c93393
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?6uvaPYIFqv9dZzngWMtErEBrxpR9oTv0V2dR3QiwxXmi8V3UASd1mPZrMlQQ?=
 =?us-ascii?Q?MJAWYBIiBde4WonHAEDqTYj0TsgDjLFEHWy7oFoskyK8INQDMAeuT84a9X4m?=
 =?us-ascii?Q?t3EQyPp15+fW/GLd25SlPtdTNX0cBmm9uJ9DWSocubpllTxdbQ51Cbddfz2o?=
 =?us-ascii?Q?efrr8uXzvEP6wxHr4rv6hJhWwmTYxRaF5U66MU3Q2Nw33qAPALn3uC1Oz071?=
 =?us-ascii?Q?llnQPxopWIKdC9glV8cBsd90Yckcg85sE/iGs87cH6dFHCrHEtgmixCO413v?=
 =?us-ascii?Q?6Z42gES9lh6aGh/gdSbRsKw12SbBxRG1FeW/jdS6z5Tz6k4lFmoqMdBODpJ8?=
 =?us-ascii?Q?rmfFzjFJfQch2f9bx61BXgac8s25sFhSPVRJINnxF5/sTH2IsiO2IjYx7ZHq?=
 =?us-ascii?Q?1CG6awJk1xjJ19o2Q9zCKMVBovDZpv1Z3LU7LXS47tzRwFfEbMz9DthfdWRX?=
 =?us-ascii?Q?kNMfUXdI8InLAStLgaNp+E6GuX+37Ue/Ku2kpTBCpFJ1Qe1zPmatdBCegtjz?=
 =?us-ascii?Q?P3AzBfsozhmovx6bKdGs9H38x+yQvghrqeLSicFtGQVp1KkrlfKYd0JsUtsA?=
 =?us-ascii?Q?ujZ+1EPbCPr82zuPrOilBz3Zm9tko7CWWiu+6ivyIln3MsHKdqtB8K5J8FwC?=
 =?us-ascii?Q?lr90XOjux+MlF1U0UTWuQCAUHfMGej/KJNDdYkSqpVf1sVR8+pHgL/S7xNvS?=
 =?us-ascii?Q?DulrxZ7kwMPgIEuug7oJDOm8YRwDqBNDtQcJgSk4B55QgGDJNNOs5Kch+WAi?=
 =?us-ascii?Q?5dieXkkjbjIMGsTlaAYhgCHcXsfFCz55QX2u2HELYHSBDaHYOVEl/nmVfY6t?=
 =?us-ascii?Q?Prv+l/pEIy7BPdYftKoyre6ujHEDWKhy3Ei4wgqRpOjBMx7X9bAKl9VjXfud?=
 =?us-ascii?Q?NL2h5mci2Y330+N8sBZEvRRagNEpQFFwqXGQywez3gI7klcrk+kJopcasd2X?=
 =?us-ascii?Q?t04i8/Lu58u9Iwo0k5+POTJ7mb1heRMt4Sg4P4SRxzou+Wn2Fs2B4yzW+che?=
 =?us-ascii?Q?wI2TlCGvMMmqBQps4EqKK8bVI1lilZEOrhXpxoCeRMcKUxVo8oGIFm5FW8W8?=
 =?us-ascii?Q?Z5HUpMQVc1E4IlgcUeURRVk85df1sjZJr2iAEB9eQsecqTzepDXEm6COEAYM?=
 =?us-ascii?Q?l54DN3ef79T/WP+X1KsePxMRRqY9qpUWFq7oMJ5lsuwjNqPqeaWh+MFruevl?=
 =?us-ascii?Q?UNWljW74y6/MJfZ1eEG/5SQ9ORokRp8kTQStbAfiXhMnCmn3FFVDSVj6bc3p?=
 =?us-ascii?Q?d7NQVIcC9bJ8wqXmioFQEj7fkqInoYvv8SYjEkvMF/w5gel9SsYY5IIdLSbQ?=
 =?us-ascii?Q?zd51iF04m+oEZ4eew/x8lJg69JpGNO5SFoS7skmrqT3vqEdU9mdrmKpz21Mn?=
 =?us-ascii?Q?NS+o9AG/KlV0m9yDZmgzFeLrXO86GCHE7sQz56pVTxjHMeQCYerJ5M7OwmNr?=
 =?us-ascii?Q?S6LWqT7EzGXGPAD/VqXtC0fkp016buYz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t8TKeGOeHBnowKzGQ4AIt+Vg0auGk3mX6TTVs8zbTOU/fACHjJ0pcOkgZq6S?=
 =?us-ascii?Q?kGD74kmxM6gmMh8rg0sCI4PDiv88+REds1+2J/CBpOFvORahPrUu+/1KquvR?=
 =?us-ascii?Q?zgPuVwDOLeycYGNNx9AUOI+/A97uvQsHCBhBLWQySmav0A3JAxxac0hNg0JR?=
 =?us-ascii?Q?1PQIM86Qaqtr+toG1fuX1hmqSZv2+ahnP0sCxZTSXe5Wqo/C31nn9Mvt+G0f?=
 =?us-ascii?Q?tHVDs3xW4TE9ur/hM7copkDpuKZ1Oyj2CPipTGb1MmNNzBqyaHfHn7rrQ6Cs?=
 =?us-ascii?Q?RWQDyqZOVjUT+Yscucyk9gYpqFEmCOryOrsDoNfyk5yp3RGKXvkUfj5wEMXF?=
 =?us-ascii?Q?wk6l7IVVCnd+SdUcp3KoDFT8W8EZy7CIO1M9G1NzqX2a15X4MQ35yjQyphbv?=
 =?us-ascii?Q?G+LVJ5Jr+HX/Ljh/59EIi1H9pEuGhGcYcu1HBULlFnH3KwCp2tK0ujYW2/nC?=
 =?us-ascii?Q?vLavuEYQBy4/ARTPR7CM2wHo75DgmtKhJr+dEfyMOcWHQrriJ+zeoIXkTW5X?=
 =?us-ascii?Q?gLQnpbDNTv2xto5x/CdhFbwEyu5yZDpnOY+MXAuhKi5sxBYAjqvA9loHFVs2?=
 =?us-ascii?Q?OVWY4QAiPUv+/31zkswWd0ENCy4txcHm5qHqt0OyUTzFp+vSWKNSKSh/LngJ?=
 =?us-ascii?Q?t8gP7wYeInXsAL4ETsMzb1rsYTlTcf2xh1h5SH/g7rhnz0tZzhR0h/nqavG+?=
 =?us-ascii?Q?xi1cw22xutTH2tKE0h/0UHmRcRozJdRidZY+kqSeYyKHJtZ0zCceffMYHTyG?=
 =?us-ascii?Q?shGKhnLcBu+MLMj8q5Le8tOczGoc6ZbgC1kS0e7OkfRF/FOxn6wFMbVnoKyG?=
 =?us-ascii?Q?QA4KnvaQaea+Hd6u7GlMZAO1uetmSkdwtoz+pT8mUc2Wn/OWiYUoD+eg7Ody?=
 =?us-ascii?Q?vDZLviGTt5B8NgtpefgD5SAiE4H0ccptKyzFkkSNYw7Ftiq1gnrvx1BYio4n?=
 =?us-ascii?Q?l/e2SlboKS1mg8dRpE89AGrm6n0qer5xtjav42Ktt48oNyIq33E/eV6H/GZM?=
 =?us-ascii?Q?Ktz6e4BvzDPlaaHxycovRT3PVawJRn9q0XycZnyPY3vwYxsTz6WVbO3h3qYM?=
 =?us-ascii?Q?xkcWU0PnfjiHbbzF28xhoro8Hf9bGB6Eoc3G2d2acC0IX28sm5QRLqnHcxi7?=
 =?us-ascii?Q?zs3Q6yM+3/RCsFs8EfMSXdHH+WNJL6v+mQCF3PmKpE9KDHtI//7JMc5OUP9N?=
 =?us-ascii?Q?RxLSkHhzt0jO2wvEZbaacQEO7OAFU8TN/B2tbS+FSuy7XshtOrmOHKcLWviM?=
 =?us-ascii?Q?iOlWtnYo1D39skdwRyOGJvhz6YOhh0SVhAcDg5R/XEEYFf5i7kxSvYa5wQxn?=
 =?us-ascii?Q?trXPdOA4UXDLPPAvi9smWVHMsCr35Y3FY6ONBbgIigGWQomxsotc8Cnrq/uc?=
 =?us-ascii?Q?b/iIRzB3JDHQcZgTUY569TyZ51oFOK+UWm8zGAUIcrCaGeSWPdmBNtseMqAV?=
 =?us-ascii?Q?UX/javiUxfND8UfMPWhYq3c/AZOirsraR5xr3RPMnH3fduheASfXA/rYGTbo?=
 =?us-ascii?Q?EWxXBGIAZVBSS06ipVXSboycYo0Q6y6+IXX44b3cs5g1qqYIc7BFDNwMNnla?=
 =?us-ascii?Q?zF0YaCjlfb1t5k65/QBbUNSI7q6iJRIHizRbXrYy1QytKoI0VYtaA1vbJkIt?=
 =?us-ascii?Q?P61vQ0VSaTMnxbI8dY9g2RLlhK5jLAbD+Qo6YsP5FstS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 746c1ff1-0d6a-496e-60bc-08dd65c93393
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 03:01:38.4299 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aW2zrdnKYT6YNNcU8/JSp6JJenCit9Opb89CwgMguHmQaEja1jgcN7FnXdYXrrgG14FeYU2B7ghMUEz+tq4QLCDX5UOlz+yJSRya73U7dUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7154
X-Mailman-Approved-At: Tue, 18 Mar 2025 06:02:03 +0100
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



> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>
> Sent: Saturday, 15 March 2025 12:53 am
> To: Maniyam, Dinesh <dinesh.maniyam@altera.com>
> Cc: u-boot@lists.denx.de; Marek <marex@denx.de>; Simon
> <simon.k.r.goldschmidt@gmail.com>; Simon Glass <sjg@chromium.org>; Dario
> Binacchi <dario.binacchi@amarulasolutions.com>; Ilias Apalodimas
> <ilias.apalodimas@linaro.org>; Heinrich Schuchardt <xypron.glpk@gmx.de>;
> Jerome Forissier <jerome.forissier@linaro.org>; Mattijs Korpershoek
> <mkorpershoek@baylibre.com>; Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>;
> Michal Simek <michal.simek@amd.com>; Dmitry Rokosov
> <ddrokosov@salutedevices.com>; Jonas Karlman <jonas@kwiboo.se>; Sebastian
> Reichel <sebastian.reichel@collabora.com>; Meng, Tingting
> <tingting.meng@altera.com>; Chee, Tien Fong <tien.fong.chee@altera.com>;
> Hea, Kok Kiang <kok.kiang.hea@altera.com>; Ng, Boon Khai
> <boon.khai.ng@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@altera.com>; Lim, Jit Loon
> <jit.loon.lim@altera.com>; Tang, Sieu Mun <sieu.mun.tang@altera.com>
> Subject: Re: [resend v2 04/13] drivers: Enabled Kconfig and Makefile for =
i3c
> support
>=20
> On Fri, Mar 14, 2025 at 12:08:53PM +0800, dinesh.maniyam@altera.com wrote=
:
>=20
> > From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> >
> > Add new i3c driver to U-Boot drivers.
> >
> > Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> > ---
> >  drivers/Kconfig      |  2 ++
> >  drivers/Makefile     |  1 +
> >  drivers/i3c/Kconfig  | 16 ++++++++++++++++  drivers/i3c/Makefile |  3
> > +++
> >  4 files changed, 22 insertions(+)
> >  create mode 100755 drivers/i3c/Kconfig  create mode 100755
> > drivers/i3c/Makefile
>=20
> In this patch you should update the top-level MAINTAINERS file and list I=
3C and
> list yourself there.
>=20
> --
> Tom

Noted.
I will rework to update the MAINTAINER file.

Dinesh=20
