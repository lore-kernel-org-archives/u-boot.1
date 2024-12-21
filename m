Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B06E77188
	for <u-boot@archiver.kernel.org>; Sun, 22 Dec 2024 13:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D5D98056B;
	Sun, 22 Dec 2024 14:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=leeds.ac.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=leeds.ac.uk header.i=@leeds.ac.uk header.b="T2z1vE+l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4A2780562; Sat, 21 Dec 2024 22:41:30 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20728.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::728])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A2908007D
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 22:41:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=leeds.ac.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Carpenter@leeds.ac.uk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/aEkUGagQT5/q6+AtcjhuknLyj9zffVQ7JsdFJTxgtYoUhoUTiqrW/4I+8qjc0Ns5mXw2tkvZothr/hsg8ydhBuoHz1v1dQVH57YQwVQ3NdY5RdUUI5lj5sIJEVZ7shUPjCCp2qjoggg0V4h9fxX+eRa9rDO8HqTKiL88J7t6B1RGWVg52v+4dezoiCmzVJjWgaW+YpyBzIErXcDKqVTdHiJPlJ2Eyj+XeoiraIQHaSrnQOTGRcwmbyrVl3gGdv5t/8l7Qh4bWnDedNVMrUl+xmtw7SB01Tklc7zCfjVNWfp+svXmcL+KSP2kXIiHWtaf1Oca76MI82bnUXbalw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bz6rDu7wkHAGbMNvlkIjSQ73sz4JrVKhkxURNryu9Wo=;
 b=AShlAVMpLgxrYMOM4UDtUh29rDj0rG7h2K+qOcr0NY2KsBjT4JtWn2g/HzH8BFL95seX0hw1kXF9jcd91zH5la96jrp/k2jamY4y2xMjrVfg4ntEHzNAeXVap23Wi0RlPS4Kyn6zxS4ztApV7zhWP+guqvu9OvU4RYcPIbtlf8sQstVOXcgkpK2qoJrqthcrHdMtZwXorEef1fdCMZ38UeiQIjCf+QZ9fEbC8XxBfCIbA6gba2y6waMPJp10iC+0NcbYrsEIMZxknHRl6YLIdWJ7WdYrpVkwbzVk1Xt/+LT6AwHlHHDcU2m5mI/WzL2YMadhs0zm/dQ26JF1Q2vsOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leeds.ac.uk; dmarc=pass action=none header.from=leeds.ac.uk;
 dkim=pass header.d=leeds.ac.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leeds.ac.uk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bz6rDu7wkHAGbMNvlkIjSQ73sz4JrVKhkxURNryu9Wo=;
 b=T2z1vE+lRGnmaxZJmR3uRxUfSv06ykR6uVhGEXpYX333inAZ2TK8b1A18nENLqpD1GXJwO2zwxIGdO2pY114Gd7hJNgCL2bx0uGxPvQBP3bs8m5rWBZOpZwBb0hY34DsXQ7uiTVsQumo0VRmB6wFqZ6rvUeLvin16fm++JwZu7Y=
Received: from AS8PR03MB7094.eurprd03.prod.outlook.com (2603:10a6:20b:23d::11)
 by AS8PR03MB9143.eurprd03.prod.outlook.com (2603:10a6:20b:5b2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.18; Sat, 21 Dec
 2024 21:41:19 +0000
Received: from AS8PR03MB7094.eurprd03.prod.outlook.com
 ([fe80::e1a4:ce33:b9ec:c866]) by AS8PR03MB7094.eurprd03.prod.outlook.com
 ([fe80::e1a4:ce33:b9ec:c866%3]) with mapi id 15.20.8272.013; Sat, 21 Dec 2024
 21:41:19 +0000
From: Thomas Carpenter <T.Carpenter@leeds.ac.uk>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Correct Default SPL_SIZE_LIMIT for Cyclone/Arria V (SOCFPGA_GEN5)
Thread-Topic: Correct Default SPL_SIZE_LIMIT for Cyclone/Arria V (SOCFPGA_GEN5)
Thread-Index: AdtT8JESrRMd/jdgQaSuhw7UvidDuA==
Date: Sat, 21 Dec 2024 21:41:19 +0000
Message-ID: <AS8PR03MB709471B7AF0B370AA52AC2CDAF002@AS8PR03MB7094.eurprd03.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leeds.ac.uk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB7094:EE_|AS8PR03MB9143:EE_
x-ms-office365-filtering-correlation-id: 412602b1-ca53-48b2-a6ec-08dd2208348e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?vyb/oMG1f+SWzSMAklEDoASPKsrZzqMw+S1pGGEBN4+4T1t/Myj1Ae2D4BZx?=
 =?us-ascii?Q?8S8LJuCswrRCDVb1Wi/hfHzSY40tyewQXy23k2l9kC7FCoIHpYiWaljhzgPX?=
 =?us-ascii?Q?mNC7EcVNg3KdnYE5NKZxFa3Mf9Hf03qbS1bCx/OMBdEdYk1H4aKhLxyb0MIz?=
 =?us-ascii?Q?0VJvbLMPa+H0Mf6g0xllcKcZxXhTagAo10l4OL8AKPgsxHnvZNsiNquqrnd/?=
 =?us-ascii?Q?vK6OB6aFM18Z+uFEVuoae4SdUC9ICUqqSJDVJvlVZTLyufos1IeLGTXhzsi+?=
 =?us-ascii?Q?wKNv1WOcjAb9heGriARZKjmJarhlslvkCO9TmH6Ztr+hGufQAUuHeNgtIbnC?=
 =?us-ascii?Q?CXr+/hwcaWOi0PaJW4K99c8Pe++1gyzfYqZ06LhYx9lWBulsDZS8MhrtJHuj?=
 =?us-ascii?Q?ugNt9Wv1Q9nOwztrW3VORjUpTm3GsmpUSYnS3D1HLVmnVnJeDP3HrzYSUu6E?=
 =?us-ascii?Q?mC7BQiaxkVIbvtgCYcQ87FSFhvujsHv1z0/G2H5sd2z9QAR8iZTU0Bl5R/Ju?=
 =?us-ascii?Q?DKQ9IaNY1lj/2Tnx4N0RPCEzC2CW0BGjGFCvOiGJKTz1opzvC1DxW8TyMXYq?=
 =?us-ascii?Q?2cVIJb0JhFEwhwV/2A559H+E7nGJ39iLoY54YposhnF0A9NFxWSfAywzdwze?=
 =?us-ascii?Q?Xidk5ZznfX1Y6kyWph9zJJldp15anjoUi6fqs30Vw7iE5ksJz9V/wpLHQez5?=
 =?us-ascii?Q?CPJc/I6r4efue6pTZ/UBixe1TKxYf6K8iBJu0A4NajjEV4TrEWaMrnbX5DMT?=
 =?us-ascii?Q?lscJrwl//YAmylgj9AAVJVM66iNPcBYnvoPA515OyvVlQ0mTv2DFC1izD8mi?=
 =?us-ascii?Q?2ZueO7TcMoe2jQCgtqhOKHU+NYB4gYaN08HCQWMTqYdNCAQaG+61NnaSLdvm?=
 =?us-ascii?Q?a5X1ZNZIBen1MYk8rZC8eGWQAAWJZ5fYSVQtSHXz9YmzML/sifDn+awCgHHD?=
 =?us-ascii?Q?jNW02xG3nZCJmEemuVF2eqX4+zmpZFW7sXMnep64b7iCvQX6zCygn+mEFT0e?=
 =?us-ascii?Q?hFxz3TU46JMZvOuXwDbuUdzkAhsxZK7HeqMK0x1KDoJI52ODk34LKZfz7PSL?=
 =?us-ascii?Q?DC6s/YV5dGDe/7ne66sbUIjcluwtOz5xBf2fqcSdW3HPQspyZNnmUEHWMpa2?=
 =?us-ascii?Q?lP77bDes9WW3qdiOto1Sj/Vsw8xBQjTY97/yuFs681TJMzB08BEbHNTBZIQi?=
 =?us-ascii?Q?owD6dzGallvqfpZ4rq6duifUIMRgTYK3Xkqs8eeLRdYBzs1DfkzAgQEF54Tq?=
 =?us-ascii?Q?jy0zBfJi9oCSq9nKJ0BwUv4KjJJ/4pTk7RE2iWjzeAuEUcLG9J3vFXigr23B?=
 =?us-ascii?Q?GYYm3BNIabZC5Ap51g1Jk09lIoifZGzEr3j/ulfAs+1zrdqLspfx1T1HW5bm?=
 =?us-ascii?Q?O2K6Wj5Pzpswm2pV5DAEp2nJkW9KKPEWZUoo/Xm/mvAewdkCcPh5k4HYqOkL?=
 =?us-ascii?Q?gPHIAuiOWWpEDboWLGS+pBkENkzNp6LX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR03MB7094.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?usO/gKy0sxFYIGB6ZAboi8m/L1hWVmuHlBKR+T+dJUU6vsI86lshqMgdGM6w?=
 =?us-ascii?Q?/HynsATs8pk4RF1cQe2skggZg4yOMCF7I9Bjiv3tdPjrZjmMQU1ukdH7b90k?=
 =?us-ascii?Q?txJhNFm78PO20Q9oz9EATkw3dqqOcGVKTfsVcKJR695x5V9G7yeTsvpZy8Q2?=
 =?us-ascii?Q?KQMVwBjgbDk5EsFUUqo74CzA+fLjrU/bYaa2QbwGtHpN79LVtIVgCLp0KdUJ?=
 =?us-ascii?Q?s4pbOYneI02cqMb9UGvXGuukul2lUjVjAf0e2XlkpoEGeAV7HwTtQajTidAZ?=
 =?us-ascii?Q?zvzdWoYki8NUOm4U5QDz9Z5K0M2Dlv2PPhE2qaZnmlEvIT3q2vHiYmN92Xk+?=
 =?us-ascii?Q?w59UU8/nMvS6DN7Z3FqBJpnneWdASk0tjvQjD6tQRJaI4OhZECVBx2bWEZK9?=
 =?us-ascii?Q?BFd7t+lh80IbLjRGH+f/6xGcU1/nkcCpKHpdFh/euZQOVXFoceAxEaVzqogy?=
 =?us-ascii?Q?NTGiinFWzIyYz0qsizk0365nShHnRvGWUnhUXEC38OSaXyhwtdZcqY0ikshO?=
 =?us-ascii?Q?tmu7i9rTuoYjg3WESM8AX0JnzwxU/w2l18fUOnUJLwzjRzTJJHtAdetVFc9Q?=
 =?us-ascii?Q?eoiSXDWFzaXWB6CesxV37K/yXbTujobF4xnOeWZxfelCCDMyGyuBz5EAoHks?=
 =?us-ascii?Q?JowMJ25vsaAyPB0YTaPRggJM4ELQPjGtdfwTZRjB/Pnern7031aZ7NT+Q1WM?=
 =?us-ascii?Q?HuFVWD1oQRK4apVEizamunEPtom8pP3EwimDn8F27sfrFyqH/GwW8euv4M+f?=
 =?us-ascii?Q?WB12OYxfF+ARhby2xeCu893CCJ4pmdYnzoOAc+qbIVlDpcvW4/Hn5b/yjbZD?=
 =?us-ascii?Q?3xuQ2K5kglFkatU0uJbFCFN05juVGqfv4j4cbompyoHTtyOhk5DpU8ZewquR?=
 =?us-ascii?Q?/sv+ZujLjAEcLmTl16IjXh3x1E36g+DSkM3nc2nhTw/R1+IU81KXr4GEt3h+?=
 =?us-ascii?Q?cs4OMMaflxJ1sKkGW69gJqi2OdLO48fCM2Z3XhCKZP5BXMvwqcUWbkeouxhW?=
 =?us-ascii?Q?vD254DbeJaRZUl7oe05oIx0QMwnr6AblQuovnUzxgmsiLEbSZuCjgWFNkxMh?=
 =?us-ascii?Q?esDCCIid9nwV08PG1Q13Edl81NW1RObEP9QyS0MlJRhXRC6fGWX27R16SW/h?=
 =?us-ascii?Q?wVyNEkW+E3rF3BUqKbSGJrFybMkb8GAFGhuXg62i5YXX/0Kmf38C6uujsX04?=
 =?us-ascii?Q?mics0jBEIlDoDlh+vuuDGO2LR9f1807FVnjh12ryYrwFswQafl2LYHczWewF?=
 =?us-ascii?Q?QFku2RUrw3CT6QiOmNsRnRk6zPQVM55xsUIMtFkbT+44PCyYlk1SXn3NjHtO?=
 =?us-ascii?Q?lMAJ+bAzgmWtsgO+BLFcKw85HGEAQuKBFgB4nDLDJ0Pcizc6pV+54oD+8j0T?=
 =?us-ascii?Q?BpNh5E5/b656VKgKocxp0egNY/O1QHD4MlAlz397vuNpUEDF8aXc1tiDYlKn?=
 =?us-ascii?Q?fR4XByabTbLX1svNAvn8205sOunW3kZv1Hk9yrRbe+pDZBc+V1GYVQ/qURVM?=
 =?us-ascii?Q?O52e5gErJ7T5mbiCKFRewniiViI1ZVwnMLFLxxnxlxakVEoWO32A2Moqywpw?=
 =?us-ascii?Q?BP6BD8UNNjEqPqzSF3Q=3D?=
MIME-Version: 1.0
X-OriginatorOrg: leeds.ac.uk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7094.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412602b1-ca53-48b2-a6ec-08dd2208348e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2024 21:41:19.2776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bdeaeda8-c81d-45ce-863e-5232a535b7cb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sJHSSWsjG4zMS04nNJ+NF/v13zXoaVt3a37Qgc8Fw+lcf1/X9nfgAawAfj9QvCD8y+5vusWNFenSSfEnPJxWSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9143
X-Mailman-Approved-At: Sun, 22 Dec 2024 14:35:44 +0100
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi

Not sure how you deal with contributions. There is a bug in the "arch/arm/m=
ach-socfpga/Kconfig file.

The default SPL_SIZE_LIMIT parameter for TARGET_SOCFPGA_GEN5 should be 60kB=
 (0xF000) not 64kB (0x10000).

Referring to the Cyclone V Hard Processor System Technical Reference Manual=
 (same for Arria V), Section A-32, "Loading the Preloader Image". The upper=
 4kB of the on-chip RAM is reserved by the Boot ROM, meaning only 60kB is a=
vailable for the preloader. If the SPL image size extends into this region,=
 it causes the boot ROM to crash.


Patch for `arch/arm/mach-socfpga/Kconfig`:

@@ -23,7 +23,7 @@ config SOCFPGA_SECURE_VAB_AUTH_ALLOW_NON_FIT_IMAGE
        depends on SOCFPGA_SECURE_VAB_AUTH

config SPL_SIZE_LIMIT
-       default 0xF000 if TARGET_SOCFPGA_GEN5
+       default 0x10000 if TARGET_SOCFPGA_GEN5

config SPL_SIZE_LIMIT_PROVIDE_STACK
        default 0x200 if TARGET_SOCFPGA_GEN5



The incorrect limit has clearly existed for a while (same issue is in the a=
ltera-opensource/u-boot-socfpga fork as well), it's probably just not cause=
d an issue because the default SPL config is compact enough to not exceed t=
he actual limit by pure luck rather than by validation. In our custom confi=
guration we exceeded the 0xF000 limit (with no error from the build tools) =
- took a while to figure out why the processor would fail to boot as a resu=
lt.


Kind Regards,

Dr Thomas Carpenter
