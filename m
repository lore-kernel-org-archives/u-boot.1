Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18206D1627F
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 14:48:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 831F78914F;
	Mon, 14 Oct 2024 16:48:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.b="I66njyo9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1511890A8; Mon, 14 Oct 2024 15:59:10 +0200 (CEST)
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com
 [148.163.139.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D21EB89063
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Vasileios.Bimpikas@analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
 by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ECNOgT012279;
 Mon, 14 Oct 2024 09:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=eHXOi
 Rg+90qwGvE41NWg4U46UkL8IgHqB1xW46phdb8=; b=I66njyo9nPw93HgjqaKPO
 DWCUbhmdVkr3sH3nmvWjtwL5gkr8M4WBZDGxtX3KnqXhDc52/mmBwvsS3e1WaVk2
 qgKtroLCIfBDVY35QPJN9WVPzXpov8rqJ+M1NTOdO0OnYb7p+P+YUB5Rf8bMoUkf
 sTbStnKQjuLpB3YBs9UkAQ3e6LfUysTuPBS2HcJ3IvS/BVMgC+1NZL+D0LaxHppU
 SRRn3kR9t3zdaFCRRjh6aqg2ohaBuJL0/OhtIqE3JYMoIdMYG/BOr5WagCbiiLXx
 nCAzq3QK3C0YobIS8U6ZAu+MNGOhALHA03fqGos/QTpWyDx8dzYun2lg5q6i4TEM
 w==
Received: from sj2pr03cu002.outbound.protection.outlook.com
 (mail-westusazlp17013079.outbound.protection.outlook.com [40.93.1.79])
 by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 427jv9q3yk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 09:59:03 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxfvXRjlRc07pe+jE2v/7sJhvDBKz5UFvQn4nIBnRa1wFXM0HMhay1glqXHD7uFRUyUKoA1MryjIP2Zi71XjWXX3wfqEIyL95972hwOl3gzp0ehw2dFlpnbaOxsF7VVb3/UpnOzaikErjr1TECXEtaM3lew/zFO5IAMDCgWzs9oFVkD/ycc/st99DmcB06NsK7fLS4oNoON+NMY5naWJzt0srkcCdIXkgR/8fy4cs5W14p4+sXx+zZmCU4n8/0ts1mKqTYShp3jDZLFTSSUVQJPOF8qLEy2FR7FJfCssee40s2/45RoB+bgJsu74E8rg57/6IER3RPZmRmtK5IRKUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHXOiRg+90qwGvE41NWg4U46UkL8IgHqB1xW46phdb8=;
 b=D8vXq2iivYO2qJGGjtyvj8AcztecTpcifJLx92Q599Jfg19xgHeenVm0KOnM6h72zksOJ8eVyMr/8lV5RD2yaAc+FRbALtfk2Kb/Q/SrRGjH2JTdLXwPd0z1mSFWnD+4ObNUPRftUm2KsM7abgBZZLtUloXv2/CO7U90llRPNPcU43B+wFQxMktLWOVBjdfB0uFcAN+XJGfAOVfp3lTcq0MIHglzksRgQ1JW2Nfng6gCVoPcLjaQI4GY3UTQKpEH2qdsc1Y+merqASBzTWj0YRr2BxUWeHPV1ZPXwp+4C8nHQh2icYOUY7EthjsgThIoesE3z4a4tuAXO4k5NubVUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from BN8PR03MB5121.namprd03.prod.outlook.com (2603:10b6:408:7e::23)
 by DS1PR03MB7965.namprd03.prod.outlook.com (2603:10b6:8:21f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 13:59:00 +0000
Received: from BN8PR03MB5121.namprd03.prod.outlook.com
 ([fe80::80f3:24f6:a18e:15ce]) by BN8PR03MB5121.namprd03.prod.outlook.com
 ([fe80::80f3:24f6:a18e:15ce%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 13:59:00 +0000
From: "Bimpikas, Vasileios" <Vasileios.Bimpikas@analog.com>
To: Tom Rini <trini@konsulko.com>
CC: Nathan Barrett-Morrison <nathan.morrison@timesys.com>, Greg Malysa
 <greg.malysa@timesys.com>, Ian Roberts <ian.roberts@timesys.com>, "Agarwal,
 Utsav" <Utsav.Agarwal@analog.com>, "Artamonovs, Arturs"
 <Arturs.Artamonovs@analog.com>, Marek Vasut <marex@denx.de>, Heiko Schocher
 <hs@denx.de>, Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Stefan Roese <sr@denx.de>, Jagan Teki
 <jagan@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Linux Factory <adsp-linux@analog.com>,
 "20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com"
 <20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com>, Angelo
 Dureghello <angelo.dureghello@timesys.com>, Piotr Wojtaszczyk
 <piotr.wojtaszczyk@timesys.com>
Subject: RE: [PATCH v2 00/11] drivers: Driver support for ADI SC5xx SoCs
Thread-Topic: [PATCH v2 00/11] drivers: Driver support for ADI SC5xx SoCs
Thread-Index: AQHbD0YDnWDwn3qf6UiR6lBK8moDObKB6D6AgAR6eaA=
Date: Mon, 14 Oct 2024 13:59:00 +0000
Message-ID: <BN8PR03MB5121B87679EE1A717A8A9AD9E6442@BN8PR03MB5121.namprd03.prod.outlook.com>
References: <20240925-sc5xx-driver-series-v2-0-ad9287c25c08@analog.com>
 <20241011173125.GA526760@bill-the-cat>
In-Reply-To: <20241011173125.GA526760@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHZi?=
 =?us-ascii?Q?aW1waWthXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVl?=
 =?us-ascii?Q?ZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNzQxNzAwN2YtOGEzNC0xMWVmLWI3?=
 =?us-ascii?Q?NzQtMDg5MjA0NzU3MjUzXGFtZS10ZXN0XDc0MTcwMDgwLThhMzQtMTFlZi1i?=
 =?us-ascii?Q?Nzc0LTA4OTIwNDc1NzI1M2JvZHkudHh0IiBzej0iMzI3NCIgdD0iMTMzNzMz?=
 =?us-ascii?Q?ODc5MzgwNTgxMDg1IiBoPSJ4NGV5MjRSdjFlNy93TnpOeStUYWZaaTFaZE09?=
 =?us-ascii?Q?IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dV?=
 =?us-ascii?Q?QUFEZ0RBQURkR3VvMlFSN2JBWXd2eWJESFJrbGhqQy9Kc01kR1NXRURBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFTZ0lBQU80QUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBRUFBUUFCQUFBQWZweWNXZ0FBQUFBQUFBQUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdN?=
 =?us-ascii?Q?QWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0Js?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dC?=
 =?us-ascii?Q?bEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tB?=
 =?us-ascii?Q?WlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?us-ascii?Q?QUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJm?=
 =?us-ascii?Q?QUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBTzRB?=
 =?us-ascii?Q?QUFBQUFBQUFDQUFBQUFBQUFBQUlBQUFBQUFBQUFBZ0FBQUFBQUFBQXpnQUFB?=
 =?us-ascii?Q?QU1BQUFCT0FBQUFBQUFBQUdFQVpBQnBBRjhB?=
x-dg-rorf: true
x-dg-refone: Y3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3Qm1BR0VBYkFCekFHVUFYd0JtQUc4QWN3QnBBSFFBYVFCMkFHVUFBQUE4QUFBQUFBQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQThBQUFBQUFBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBRElBQUFBPSIvPjwvbWV0YT4=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR03MB5121:EE_|DS1PR03MB7965:EE_
x-ms-office365-filtering-correlation-id: ca4bf6ff-5d56-4cbe-eb52-08dcec585ad8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Yw/eYEZa1ZNdGL7jt5oFrisqzg7T/rsBlIhQ+W9ISQ+W3t87P5W8AR0JW0pV?=
 =?us-ascii?Q?/ZtrjJMu9mET8Z9QR+hKCgxAGUf687SSTtKoX60ZpcAjZ6IMKyvYzxtd0EFp?=
 =?us-ascii?Q?lnDz9YWE8I4vphvKA30dYt1s2KM0rsk2z8/oCbhkXUUi9dJ3joQGQdpjU99O?=
 =?us-ascii?Q?bn3BjkOO6uV2HAvFBoltJWwNYF1ydtw0bHDEnd/LVwSYvUt1fGohmPGM/eYu?=
 =?us-ascii?Q?bYIH9txLE6QqW3iQt+ONHdMBw6xNkGbNNuozj/1X54jLCjpJkNDh1CP4NUUN?=
 =?us-ascii?Q?8t8jSoWLHGi6gIylWXblMiJTUQf9CIy/3aF6EVm+FjxZqKxEYrAtkP0/6BKi?=
 =?us-ascii?Q?eqTQZAnRSMT1kO3TZyDGqxWrz8+77KA1MNPcxDrzVWP6bjT+gGa1G+p0OcuB?=
 =?us-ascii?Q?8ybybk1uh86mQH5hlcWymxTcPlXpdeT3wsOm2uYyoTbEUw+dVcA6nO2r3vOt?=
 =?us-ascii?Q?ZL/L8/O8JbEZI/lbhwy+5nGLnrM4estB9e5dSONTJaD+CM/SJC/0vvwJLPEy?=
 =?us-ascii?Q?vu6xwimKo+9LuNq4it8Skgb5xSFMHq7e52dIcogJKWhvWd3rLcdec3/RtMGO?=
 =?us-ascii?Q?+04a+XpwtrMNrEoG9KaDDG4yBEEG+yPWCbPeK5T2CwJ6pdBV7T9JWLCXY71o?=
 =?us-ascii?Q?WXZHGpILL1/8n4XU1I3i4VP/xTMoZ1pa+GeJ+jKMQP2UMmd4HH5HEglt/WXQ?=
 =?us-ascii?Q?GYT4CDrqtVFJz8cMTS6fuAg/cgk9UBWjcJQrU/BRDZBl+toQ4fmk9jSw+xlc?=
 =?us-ascii?Q?9iF0oWMvBCLUhfaK4eOWNXZog2GiljYxXlTjRLy+WwsrGO0pLoAjDqPSjrB5?=
 =?us-ascii?Q?YDlt2b37ZaVo8jMCiT0vbF0I3usVZHRgc8X4Kj0ROnohevBIOZ+OHHBKou3i?=
 =?us-ascii?Q?aHKPHiYbC4a6IXJ4yjhq4npiiezDcqPKrdxwhp5M3lzM3ClRhGjC1+h+0T/s?=
 =?us-ascii?Q?HJ87vCWN32LimSbXkKcEMvrPjJ8gXS2n0lotb1aipq0JHdqIa1YrVsw6M6xh?=
 =?us-ascii?Q?iUy1Lym0HffT2KWSvqI3EjM2o0Cnm2AEYV/BG3YH8tH/edZTMFJBxMQv3XgH?=
 =?us-ascii?Q?c7ePd/+t7uyMmqnwvKN3stnDdg92ZaAupuvzZc9IFpaahEg1MaIAGwWc4jpw?=
 =?us-ascii?Q?/7eGWjeaUV7keixmbyqnfiV63052iwLNU2E3aMwmgrD/9NaCnIBcu2mnA853?=
 =?us-ascii?Q?2wOvddJVWh+01PmYg8uzycbBEydDI8B9CQK5Z+S8VFxsmDzEdYMeI3aHA3AP?=
 =?us-ascii?Q?X/QeQbAgXtTLRySuopJMVrDwYoMPO4GAPow+sTUheQVL+9ClBJ+ffH4C5HTt?=
 =?us-ascii?Q?CHajy5ZqeDt1sqPJKEkzK+rciXHrvroid7PVsKxp62FN9Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR03MB5121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?71czLHOZucoDaViNlqbl7/QrYcF4erjJXmOV4CTADVpou3ZNTuFDCbzL+Fxv?=
 =?us-ascii?Q?OtrwTlwRN7XaFCN4CMWCs9Mn8NKGBk1IxvCUabQjZknPE4AIIbJ8GsHcV6FI?=
 =?us-ascii?Q?2YGK2p8rVqJayujAPP+Oa2vtI3YMnZOY0+EkMdMDl1Z1EGxG060iFYSAaiKd?=
 =?us-ascii?Q?CnTSWVV+OEo15TXx9UJdSlfaHTR98Lr4QenYi7K0zuKdaBHs7qZ0ZcfD9G9k?=
 =?us-ascii?Q?eMgzBKEEtqxHH6v6L5qKxrrP9aH+JlAdvtCGkP8WlLA6M9SRuAfz8bc85Du2?=
 =?us-ascii?Q?iyrfPr6nuZnn0HBLDv8OJ7Y5Xk6xV/Gi1t2LfmbO86y/D1WtKGo+6gHaNBOl?=
 =?us-ascii?Q?yeJM3HkOUxStXlTJy6gDvHqWEri08SnMWzjGViYNAYiLRon22GNI0PmMGpeM?=
 =?us-ascii?Q?iC3dH7MRTsB0Ff05OGcR7MJvVYcDfLovFLKmvhtQNetZKgWt/LEC30ePcEaC?=
 =?us-ascii?Q?reLLS5XHalum9mlW9KuRAxbi/TAEcZbWf9aTqwhPkWWpbfw6qL46FKfUpQ/k?=
 =?us-ascii?Q?HBf1siRf5QF/bvjvME6f9BlU9n4xAT2awVxUv/DnTgBF2s/lm02f6eO0y/0n?=
 =?us-ascii?Q?tuVy3x4rLRnW2rUOvT60saNVW1YiO8LuGXeFSRPmxEhVXaznCiCODJk+HhGd?=
 =?us-ascii?Q?VaBF7rBLzYKW5wvdcVxctcWppZqfc99ejL/4TdMkNg4mbaP3MN8wzGX4r833?=
 =?us-ascii?Q?z59/uZ8MglSBvUtKES9OZtbec0Z6K4qY2KWGVIaH2Wu4MzZ64Qo7Yvw+gKwQ?=
 =?us-ascii?Q?oaaVYIyLX4QeyzAcCQbTz6fUT48lynOKX2+c14b/lYUSCxFPKnTUNEDhTvBq?=
 =?us-ascii?Q?6cOBKC14UEi0mIh3p51JAGMEMv3eGH3CVM2X0j77fvZ1g6CQOmJcYxAryNMx?=
 =?us-ascii?Q?ZhSCJy1B0No/3vW/zlk98oSzOorx3kzppj1QkN7u2r6PNEF7yk1lLyQVTOPo?=
 =?us-ascii?Q?OKmFSiQfZfY/Lt+VhiGJdaMzgGFnjZ3Floab+Y5ap7iIpFDWunkEfi+jb+lU?=
 =?us-ascii?Q?ZR+rURqPPX6uNsv1YzVQzX6GToX1KjTNl4MdqQaWh4fGMIPL/rf+THhYum7/?=
 =?us-ascii?Q?QS+FfATMp6aGcvjVvEf6qkDueBgHGwz0JQvakI3ZkHYtBg7pZhB5WJ/nKTqn?=
 =?us-ascii?Q?FYpOus+3fp4gO+Z9PM/NDiDs0q1A2bm3ulHaNaFDgy9FwdzpsePxnNrnPCuR?=
 =?us-ascii?Q?5Ok4zYmJ62hRNrebiFOcpgLMKjEWbLogm4dg5EaGKetb1v38wDJy3+EhEYBE?=
 =?us-ascii?Q?1MkwZT0pMk2vnv+NXbRCdJqc4oSFzxOSr4TgEW3obFpe1BDpclkA9W5j9txI?=
 =?us-ascii?Q?AeoZuItNtAldZOBaoJ2SKLREPOWK3LTwCml0MxAxc9WNkKRISKHpywPyQUfk?=
 =?us-ascii?Q?E9zSnOebzsp+Eleyycc6xGx5tP0T2FFQBWv9ekmKrbzp/I2Vd7Mem1mMJBEN?=
 =?us-ascii?Q?u5au2b28nXu2bvO6ynB72ZgDIHb0wyZWL4Ru+nwrbpBUGJKT4047sT+U7GVG?=
 =?us-ascii?Q?PMxa1uMOw3guZCTibNGXCM1K20RJubTy8psA73fXDzECAtM1xeFKKGaz8Y8o?=
 =?us-ascii?Q?RY5iiPv6UD7lOImCzVJUUIbHHbUjRKRrmfg8V6D0DxJ5TEuphxr02sRaLrR5?=
 =?us-ascii?Q?9w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB5121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4bf6ff-5d56-4cbe-eb52-08dcec585ad8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 13:59:00.4832 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0wJ7MkRZJy9oEQj6la0Ix5Z407X36RYAbS9kLk9J1scagKLxRks3bQqLIdzq7f/QdaqQKRGwzEAYlGfDctXXMhsNmUGZ0P+XGTiGBcfilQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR03MB7965
X-Proofpoint-GUID: FUujB2H-xSH8mkk-2uSfg4yOxbI6ub8N
X-Proofpoint-ORIG-GUID: FUujB2H-xSH8mkk-2uSfg4yOxbI6ub8N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 clxscore=1011 spamscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140101
X-Mailman-Approved-At: Mon, 14 Oct 2024 16:48:14 +0200
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

> From: Tom Rini <trini@konsulko.com>
> Sent: Friday, October 11, 2024 6:31 PM
> To: zzzzGaskell, zzzzOliver <Oliver.Gaskell@analog.com>
> Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>; Greg Malysa
> <greg.malysa@timesys.com>; Ian Roberts <ian.roberts@timesys.com>;
> Bimpikas, Vasileios <Vasileios.Bimpikas@analog.com>; Agarwal, Utsav
> <Utsav.Agarwal@analog.com>; Artamonovs, Arturs
> <Arturs.Artamonovs@analog.com>; Marek Vasut <marex@denx.de>; Heiko
> Schocher <hs@denx.de>; Joe Hershberger <joe.hershberger@ni.com>; Ramon
> Fried <rfried.dev@gmail.com>; Stefan Roese <sr@denx.de>; Jagan Teki
> <jagan@amarulasolutions.com>; Peng Fan <peng.fan@nxp.com>; Jaehoon
> Chung <jh80.chung@samsung.com>; u-boot@lists.denx.de; Linux Factory
> <adsp-linux@analog.com>; 20240828-sc5xx-upstreaming-patches-v1-0-
> 44d9adfdf327@analog.com; Angelo Dureghello
> <angelo.dureghello@timesys.com>; Piotr Wojtaszczyk
> <piotr.wojtaszczyk@timesys.com>
> Subject: Re: [PATCH v2 00/11] drivers: Driver support for ADI SC5xx SoCs
>=20
> Please rebase this on top of current master, thanks. Also check that each=
 patch
> is only doing the correct MAINTAINERS change, that's where trying to appl=
y
> this by hand failed for me.
>=20
> --
> Tom

Hi Tom,

Thanks for this. I've rebased and resolved a single conflict. I could not f=
ind any
MAINTAINERS issue after rebasing & building. So just before sending my
changes, I wanted to confirm if I'm missing something regarding
your remark about MAINTAINERS.

Best regards,
Vas
