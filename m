Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82678EB4917
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 12:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 820DB83D6C;
	Thu, 12 Feb 2026 13:44:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="XbTj/lJY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0934983B64; Thu, 12 Feb 2026 10:08:20 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEB5483015
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 10:08:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyHLgoFswDngswPiHlMSg5YdRx0UUAcMRhPjlxMF13U2pOdJHVrF97bL9q+hArnWPlJpuVDeRgGNBxw70mAwp7Uq/3Ie+TMLqh8C+ekPcjaWE6Sj2AReYxHMM1K/GXwV6qOFangNaqLfB0gaeS+3o4p5GmF+2Mo4NjDPOmGq1QogKHTiPicWctQ8Yb4B9r37matvKtKWS+lUiEDrk4PgQOYfIg35n46ZffVoJEg7jcq8xUb4dvZPDZEkLcdhflmjNZLYrRUZpJZ0yI/P+bN8EYsrZtG9eKe365bpDaNMMk12KNApsjiWuR2U49u3Lpo4FWVKFLhbWDEflHaTh8bObQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwGY6vmnzKuBRrdqXzcIABaLQjGHMBOS631CCvlTteg=;
 b=C+oyKaXF7VWD5IAulnoUblfhMHZDinjcTYlbLTbnL0Y9pTb5bG/Gs4RI6C+I9wFopVEW1Lik0lmihEV+gqXbdfF54mzS/gK0M48DekGFkub3SLAFNEDpe3GLZQHJ1+L2vs7dLJlVSndRhKBkcq7NjWZmTmLFRUNGxHZmv3gMMcYvowSm7JIG7bpe9Hjl3AANfK241/YhwKkR5fnTb1Wc0Ya8Eu7lnggHbk5B2O7z2jiNnxFld5tZr+rXI4NhCKbsdnOHQpvyR0O26+zqI9FQBtfjqBc4RjnyZJTFVorBlnvJ56J74DGkb4L07XQkitBZAc/IYdaTwPt8AMsE1N/IIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwGY6vmnzKuBRrdqXzcIABaLQjGHMBOS631CCvlTteg=;
 b=XbTj/lJYqvrHPDbPJNE7bquUGCQWOS93PwA7Xfp3i5zn+UVPB9+r2Pyv4sPM90UOimYKg6QGau391GK4wuyPKi4lVQYrQjn0KYMYFc3UQ/F8vbl9g8ymbuKExxD7MDPD9kadMeUXBu2rr4cwSQbOHi7e0dEOG+IESoSaAr1fjMJLdGdh4dowZgGlN6QvTamWae4afAlP3CMj8LGmx44JLr/wxitZ33kL32egeK7PqfkMTkI3wO09q3IbZFcFsxa0G770mqKM2bNdgzTlfFGuRN71kYqpfqFsiDcjcegxzh0SWiqSYyCGLznaYMzbDQpJ2fHE+JWEKiL+k4L5uVkZpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by DB4PR10MB6048.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:378::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 09:08:14 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 09:08:14 +0000
Message-ID: <96d856a5-7d06-48b9-bf27-9db26c7f6c9e@kontron.de>
Date: Thu, 12 Feb 2026 10:08:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kbuild: Bump the build system to 6.1
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, "Andrew F. Davis" <afd@ti.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Michal Simek <michal.simek@amd.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Luka Kovacic <luka.kovacic@sartura.hr>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>, Simon Glass <sjg@chromium.org>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Varshini Rajendran <varshini.rajendran@microchip.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 E Shattow <e@freeshell.de>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Sam Edwards
 <cfsworks@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Greg Malysa <malysagreg@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Yao Zi <me@ziyao.cc>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Shiji Yang <yangshiji66@outlook.com>,
 Daniel Golle <daniel@makrotopia.org>, u-boot@lists.denx.de
References: <20251216091632.512635-1-ilias.apalodimas@linaro.org>
 <0205a2e4-0ccb-4dd0-b901-cc6afae31189@kontron.de>
 <CAC_iWjJLm98Vm70xxLAY=aAvSzb7eq2hRhrqUdr1sLZNUZj0iA@mail.gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAC_iWjJLm98Vm70xxLAY=aAvSzb7eq2hRhrqUdr1sLZNUZj0iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0251.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::17) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|DB4PR10MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: 573a4623-d19e-4024-9b00-08de6a1640b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zkh6WHIvTEVqMGlYYlNJUTVsQWdla3FhQjF5WWR2N3U5UytNMHJicHd2WWpw?=
 =?utf-8?B?REFpbWQ5NHNOTEIvRFZBR1dmcjgrSzZrQ1JtRk1uTDRhT0ZZSURrKzdyb2Ev?=
 =?utf-8?B?NEZxNzFlUDQzY2pkUlQwZTRvd3JYcXFFajRydGdHVFhZR0dzMHRRQjhhKysx?=
 =?utf-8?B?WWFiYVpPREUzRU1iaVdZRmxLaER6b2dMOWc0RnZYVDBadHZ5NjhpUFcrMnZZ?=
 =?utf-8?B?aEwxaWQ4NjV2U1lWZGpGV2NoMldFTHg3TURTaVl0bmQzUW92cnJjdFJ6TkN1?=
 =?utf-8?B?cy9zUjRaT245Q0lxVUJhMkhNeFB2WDVzdFF3UDdyNUtOL0FGVk5qRG5ud0ZP?=
 =?utf-8?B?TllJTUFESWdQTlh1L29WODE2Q2IybXc5cUZHWGtaeVBJdG5oR2NFVTl5QlVW?=
 =?utf-8?B?UU9BYnFrVVprdEprbHd6dG5MYVRRc0dKVXBoaUZZM1pWaG45aXRteGZqVHVm?=
 =?utf-8?B?WjFIM0gyb0l5cERTVTBoQStHUzh1TmlZU2Fnbm5nUEZXcERlb3AyYks2Y05C?=
 =?utf-8?B?bVpLa0hFNk93ZEVEbk1qc1RscFpWSFU5bCtWUitHd1JlcUU1U3ZpamZETTB5?=
 =?utf-8?B?RmozRVQ1UENjMzdrd2VFSy9DNWljaXFMdHMzdU5FM3ZKT1o4TVhkZFNya253?=
 =?utf-8?B?eERKVEUxTG9qRkFCT2ZtL1ZOdUZlbWwyTnhoY2lvN3Y5V0NSMUlIdkhrSmIr?=
 =?utf-8?B?WHFaZWx5eWsvUk50T3VWdS9wRjV2NEV3Qk9IU1BOdmkwOHUzSldpeFVlUFU4?=
 =?utf-8?B?T05GU3c4aUNocW5LLzJWVFZwOTlzaEdXS1phYWxaQnRGU2V3cXNyeURoWEJ2?=
 =?utf-8?B?YVlMd2xJRzVqNmwydHQzMWQzblU2dWZZMi9TckI4MkVPM1h0RGdIclBOc0M3?=
 =?utf-8?B?OHRqd053YVZUU2pWOVFTL0JFUGxrWkE4bkdZbkUzV1c5NlVTZWQzeTc2L2pG?=
 =?utf-8?B?c2Mrd01MeDQ0RzhHWm14UytGZjBCcFgxRzVLczAxWHE4RG5pWHNoWklhTk9i?=
 =?utf-8?B?V2c0bXpmTGhSaDdRTWsxQXhVUDhvaXlrb0piVlVKeTJDQnNlUGZodlRsazUy?=
 =?utf-8?B?b1pXaC9HU04rWnlqWU5VR2JlM3ZXbTRoZGNUK0ZocjlvVDRBeHhyMWxzclRp?=
 =?utf-8?B?Mkw2RXlCRFlISzluajlxYkM5SWNxRHRrOFNEMzh2N2lmMjdDMFp4L2p4Vmxu?=
 =?utf-8?B?ZEhyS1dDNmdyb3piYlFtbm9SMU5Fb0NFbjR3TDZlSklSS0I5YUpyd3lDeE1s?=
 =?utf-8?B?T3lFcTlDcTJnS3FvQy9BS2hYZDlJVkFSVUo2UTg0by9LT0ZhZUNvdjBKcmRo?=
 =?utf-8?B?a3h1VFZReU1hYjBMZUEzWmRSZndtcGNsTW1sMS96V0ZSaWR4WStMenlkZXRD?=
 =?utf-8?B?N0lXL1RJRHhuRkVaNVBzbzBLT3NYOWhUemxLeVBWbkt5TlVndEtvS2pDZG9L?=
 =?utf-8?B?NndpTERkLzArN254dEgwR3F0ZE5lZnMvWHNrT1B0cU5vNk9iTFNCOE5QTXN0?=
 =?utf-8?B?VnR2dVl5NnFVUkk2QmNWYkpoMjF0NEVSUDQrTVExQnFnR1VsZjFaMi8yY21Z?=
 =?utf-8?B?NEphbGRzY3FNNzc3bkt6YTNxQVgrS2I4MVJINVdFaXhSSEVueURHTlpiVTJu?=
 =?utf-8?B?SXdYU2NvYm1qdGZpR3I4MmZCSG9DTXM4S2x5ZFN2akt2aVYyWXkxaEhyK04r?=
 =?utf-8?B?eER2NytHdG5OQjVLeTU4TXJ1NGo5MjNIUDdWTjNCVG94dWU5SG5CVis5aXNr?=
 =?utf-8?B?UHk5WTJKN1VGWVh0QjNNUUlLN1hoTmlOMkpwNnhvU1V5UlN4NDIvMVhjQzRt?=
 =?utf-8?B?MjQwYUl0OXh2NDlxMThnRWJ0Zk81TE5nZ3c2TVQ5b2orYjhTbEx3SEZWRzZO?=
 =?utf-8?B?QThuNDdVT2pDUHRac1JZdnJCRWJSeC9kVTJmQjFONW0wVVNDRHYvc3dOQTVT?=
 =?utf-8?B?NkVSRkN4SWk5T0o1MVdOMWl4NTNJSFNMVFQrL3BTS3AwVXVRWFBOaUZIeE5m?=
 =?utf-8?B?bEhPOFgwMVhNUVdzSmV4OHFsUlphVU9KMXhhK1Z0MXViSjExRXcyZWo1NTNF?=
 =?utf-8?B?c21jc3B4Uk5zUnh0YXBBcTZaYW1xbloxcVVKS1JZSGpjcXBMZGFPSGVzNXpK?=
 =?utf-8?Q?mRXw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkh2M1hhajY3a0xVUVBWTHplM09aWkFxNU5ta2xwaU9VOUpXZE8rQWR2cUV2?=
 =?utf-8?B?OGJHN1ZDd2hjOHZRQ2FYaGFmazZlU0NmdkliWXBWVU55dlFYSml1MFlEWEJP?=
 =?utf-8?B?aGZibTJQcDZQelNyMUtraUZHTG1DV2xmcGpLU0lrQVlJTHA5UGMrODZvVmx2?=
 =?utf-8?B?eER4RlJWM1grT2Q5KzVFaU9iQWphblgwWVVLZlZYMmJ4STk2TnY0NTBPKzBY?=
 =?utf-8?B?QWh5WVVnd3BUckNOakduRW1uNjF0Wk9HZWtmQld2dG83YUdHU2RTcXgvR3Ix?=
 =?utf-8?B?NWFGQ1g3ODd2aEs4a1QwcHQ2Ym1rS2lvbGxyMXR2YXJHUUk1NG11WEJnRGxU?=
 =?utf-8?B?cHFhWEhKdG5qYkxacXVNaURsZ3dpRjd2MGczZm5RRUFOMnU1U0VLbmEzOWhn?=
 =?utf-8?B?WXBaUFZYVE96dVY1T2JQSEhQeUhoR1crRkJ5TnNMKzlRa0Flc2FROTRjK2sy?=
 =?utf-8?B?V2pJS2d4dnZVSHp1SWxvM2xPUVdQWVRCV1p5NUlFbExkMFZ3WG00eUZNRXVn?=
 =?utf-8?B?T2o4cXBhOG50NW12M0k4SEtGT2FpVU11c3NMc2ZmWXR2MHZnU3RMR3VjTWl3?=
 =?utf-8?B?OElZVUYzV2ZYZlJUTFdBZGVSZTg3RE1yQ1RRL240REdBZ05oNkhZbXpuWk4v?=
 =?utf-8?B?VWtoemIxNTM5KzI3N0d4SWNhTFpVbzczNkltUXBiR0svcWJlYWxKZkd5ZC8r?=
 =?utf-8?B?cnR0MDFrUkRwNWlRa0pLQTY0aGhlMVlIaktJK3BDalpFZlVZY2lRQ1VyWTN3?=
 =?utf-8?B?VzcwdmxYTWZ3WDRGaUd3amlDc1JJMHJUY3Q1Tm0xbjN6T0IvTkJrbXU1bVU1?=
 =?utf-8?B?N2UyME5LZVhHa0FHRW04UktoekxkeDQ4R0Ixa1FhdUtJSnJjVXNiT2NZcHNa?=
 =?utf-8?B?UVNpR0ZXc2FURForOFZqbCtPcG5IS1hGUnE0SHE5Zm4vRnB4SWJqOWovOW5I?=
 =?utf-8?B?Y2hENFQ3UmdvVzIzMjNFWkoyK01nZE5BaUdaUWZVck1VVE1nS0dRTUJ3ZWYz?=
 =?utf-8?B?c3UyQ2FEZWlZZ08ySDl3S2ZqU2Vma1M3c1NxWlBGc1RSbklNb2NkZUNoaHNE?=
 =?utf-8?B?cEFUZEw2TmNBK2NUVVJvV2pXT3N0M0JXRVVVQVpsc29ud2Jib1VXNmNkUFA1?=
 =?utf-8?B?Y1hVcmJQaHFoYzVKOVBRRGdUZ0Exbm03MEtXa0lWSnlSRXJ1cytWK09MK0g4?=
 =?utf-8?B?Y2p1ZEY1ODNTditPVHlFcFNJUmFLN3RCUmF0Z2lQODRldkNqRzJ3ZkYvT1RV?=
 =?utf-8?B?cEFRMmlkNVhTVW5MOUk3QlBZR2hNcTJkeUFJTEpJc0VMU0NJMzNaSXU2Wkxw?=
 =?utf-8?B?ZlVPTi9NUm5xNFdnU3piRFJYamQzRHRJdWtvOVg0T3BteEFCbkVZK3c4OGl6?=
 =?utf-8?B?aUgybk5weVVMa1owZCtIL3ptMGh3OCtGVVB3U1k2b1pVZTVNaFhDSlExQmpp?=
 =?utf-8?B?dG0wUkxDRHJaSlFhMUZGY1pkYnFxS2x2S3JjNGh5a00yYTZrUnI1L21QTVY3?=
 =?utf-8?B?bWJqajhZMjRPZkhKRnNpdW9IYXZHckxVVFRIRzVWQi9jakRNS25XT0NTNkZT?=
 =?utf-8?B?eCtuYUdXMjhKUVpvaFVpd0I4WGh2dUdtbEdDdVJUdGpHNXZ3YWcxWHBHWGxR?=
 =?utf-8?B?VTJlUVdCTDQ1UWFWeU5TZ0N0TlJ2U3ErdXZENFdGSEVMdHBjbHJmUmcrNWhq?=
 =?utf-8?B?SFR4ZnBGOVNvT01zZS8xS3p2NU9Fam5yOFVqeTArNVhGMmwrQTZ3T1N3aDcw?=
 =?utf-8?B?R0ZlOEt1d0wyMlYyaTc4aGI5STVtZHh3czJ2SC8zd2dMdE5tZTdjMWl2V3lD?=
 =?utf-8?B?dXcwU1lROXZhMFpyMjNKU0NCZWJUWG5EMXgyb2x0WTQrMEJHUDVEMHVQdnBz?=
 =?utf-8?B?d1hicE1mZW5DNDVDYUtZNnp0azV2TlhvMnFnTzRzcFVHYzJObkxOOVlnSlA2?=
 =?utf-8?B?d3dLWU1kcnFVLzd3cTRZdXNKVmFKU2pTNXNzUVdJSy9FeE9JL21jaFNLRDdt?=
 =?utf-8?B?dzVLODlsZjFlWFNkZ1BHOC9URERlOXVkZTBMeldNQ1dka0dwc3ZQSDZycDVt?=
 =?utf-8?B?QkJmdnJyVDd0V2FMNkU3ZTFZODRsR2Q5MmY4VCtKMzh6cnN3MWdWREhCeEg3?=
 =?utf-8?B?bkR5c3JsU2VEVDJqVXJaOTE3MzFQb3IrR1FSZ09Dd2cwUEtaUnU2SUxHUTBC?=
 =?utf-8?B?a2NYSUttWHhGdTVHczVucDYvVmFDdEhXV1VnUUwrU2h3bnIxVFkrYnVGR1R1?=
 =?utf-8?B?YkN3ZUp0SjdVYnpzc29sV0FiTkxYS1BNbURoMERKbVIzOXJPZDJBcXFaNHRn?=
 =?utf-8?B?aFVkb0ZjN2ZNYWt2eUZ4YW1rSkFDaFo4QjRUT1ZnZGMwRmdxR2swdlptdGFs?=
 =?utf-8?Q?hbMQM1nKHeI6+ky8=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 573a4623-d19e-4024-9b00-08de6a1640b0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 09:08:14.2305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKj4Tt6TK17XK/v9h7om2s5hyRPauZrlhKjxGv1apmfw5oD2ZY9XFIy9cxV7Ad0C+n2iejRQDUN758deTSkOCzaq54e8smMnNilz8M7Ed2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6048
X-Mailman-Approved-At: Thu, 12 Feb 2026 13:44:52 +0100
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

Hi Ilias,

On 11.02.26 16:25, Ilias Apalodimas wrote:
> Hi Frieder
> 
> On Wed, 11 Feb 2026 at 15:35, Frieder Schrempf
> <frieder.schrempf@kontron.de> wrote:
>>
>> On 16.12.25 10:16, Ilias Apalodimas wrote:
>>> From: Sughosh Ganu <sughosh.ganu@linaro.org>
>>>
>>> Our last sync with the kernel was 5.1.
>>>
>>> We are so out of sync now, that tracking the patches and backporting
>>> them one by one makes little sense and it's going to take ages.
>>>
>>> This is an attempt to sync up Makefiles to 6.1.
>>> Unfortunately due to sheer amount of patches this is not easy to review,
>>> but that's what we decided during a community call for the bump to 5.1,
>>> so we are following the same guidelines here.
>>>
>>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>a #rebased on -next
>>
>> To me, it looks like this is breaking "make cross_tools" in some way. Or
>> am I missing something?
>>
>> With v2026.04-rc2:
>>
>>> make tools-only_defconfig
>>> make cross_tools
>>   UPD     include/generated/timestamp_autogenerated.h
>>   PYMOD   rebuild
>> tools/Makefile:359: *** insufficient number of arguments (1) to function
>> 'filter'.  Stop.
>> make: *** [Makefile:2191: tools] Error 2
> 
> Does the below fix it ?

Yes it does!

Thanks
Frieder

> diff --git a/tools/Makefile b/tools/Makefile
> index 0ac683ac3ec7..c4308304d99a 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -356,9 +356,9 @@ override HOSTCFLAGS = $(CFLAGS)
> 
>  quiet_cmd_crosstools_strip = STRIP   $^
>        cmd_crosstools_strip = $(STRIP) $^; touch $@
> -$(obj)/.strip: $(call objectify,$(filter $(hostprogs-always-y)))
> +$(obj)/.strip: $(call objectify,$(filter $(always),$(hostprogs-y)))
>         $(call cmd,crosstools_strip)
> 
> -always-y += .strip
> +always += .strip
>  endif
>  clean-files += .strip
> 
> Thanks
> /Ilias
>>
>> If the problem is not on my end, then I would have assumed the CI would
>> be able to catch it. But "make cross_tools" is not part of any test, right?
>>
>> Best regards
>> Frieder

