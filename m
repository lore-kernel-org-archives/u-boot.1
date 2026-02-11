Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F62E9E30D
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 13:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68C1983E16;
	Wed, 11 Feb 2026 14:54:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="YkIH4lvT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97F7A83A5A; Wed, 11 Feb 2026 14:35:51 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7404882BF2
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 14:35:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTTXWroDefrC1Rf5YmL2GlsXnIo1CIGiXTOnaKayZHjzb1ycGkkrU5hxRouq3xlWEM5l8Up1c5/seBDZexGhlJkCh6qu8nv/hlAFR0tC7rSSu0raEHVVCrt3JJ6KD4sdvSUucCl1UyhDekkR5P0X2FX4hZErR5UXYApOOjW4MOakBRedJ9uK9IIgkgJo1iKGcpI4Xbdt6UM2oskvzpM26G9ediK0EVc95cD3HcOTGsuAF2ZghT7LOrrjxtdgx0BCRsGu3x0FL9cSJveA4yzUMrTUO59z5T8ks8DAsHSAgNLQ5ejIxYB5olf6t7FdulgsoTQSlCdEwszBUC71TzKbaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44bx8fCsvOzmfw075UjZsrzdgQ+nlPo7JDGh25UFSvI=;
 b=g/1JTbHKgm+7zM3LqpCybzUk9sJBmP3V+bJ02bv5ne3ihyBH42E6J7pXSEw86VX2bGK7BIxMUK1cQSSUHke5YOhukaBmJthoyafZo+ORf+oqtrvxiFuP2qDGKGelZJ+3X6pNvmYCcgxH0uglr9oLgaHILHVAunUKVYDayq4utf7fi0adGMT52YTmhKi3fyzZAqoXd1abxdInMsdxEPNhLlP85kopTBluNV5aBeDSQYf9lSldngfGFQcAXGnCJV6TPbPSGq/kRrMhWLj1SsapDj48Hl79+Tg/0wQuy7vszX0ta77S2ECwOm0d+tiPscInT2Bjk7ZvBxRcr/3Mfvihug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44bx8fCsvOzmfw075UjZsrzdgQ+nlPo7JDGh25UFSvI=;
 b=YkIH4lvTtJV4q2f3U8nxchyZQtwOTmBT/dgvP8zzQqcNOtsffE8SRyN28jqH3PQyTRtcRI0MqSIA0fcEqX9dApGgx94fNKoEPpruJazYqGIHm3MXGqaK1Db9cGzc+mTVBPFHxaCRX4lGovl5w9pAgGUBzytnQlifYMbim7FYA7Azaj24W9nAC03PfuAHxlJ+IS8ygvC2mhMxPIyfeOABAyfP5RvZR/t1dcbnC+YsTpbmHvS82FB9YTY3PspH2dNQxPAxkE9LakK+fhyBlrFxZ6zWDyDef8tkY/AkvzQyH0GdZ1fSpssvSAr5KF1GiDOuLpU6MwPX4iVRtDw7XYP12Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by GV2PR10MB7488.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 13:35:43 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%5]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 13:35:43 +0000
Message-ID: <0205a2e4-0ccb-4dd0-b901-cc6afae31189@kontron.de>
Date: Wed, 11 Feb 2026 14:34:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kbuild: Bump the build system to 6.1
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
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
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20251216091632.512635-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::17) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|GV2PR10MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dcf5319-cc4c-4428-e597-08de6972748b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STJiUjE1T21JeFpHQzd6RXdFRFJqM055a2lPWkt3blFNMzdaUUVBTDk1VGR6?=
 =?utf-8?B?TWJ4MGZVaWhUb1Q4Z29KNFh0VVFHcFJZNjdScnpKMUZNVlNIYmxqMFRZS2Vy?=
 =?utf-8?B?bVlwMXpkOVNCNFBkaDFJZ2c1Q2xORUtmMUZ2NThvVzN5U1UxUUwyaVZYMWFp?=
 =?utf-8?B?d2Nwa01WVUJFeFlROHNEM3dGK21nSitoa2JVWEtPZlZHMzM3aTdMMUFpenhE?=
 =?utf-8?B?Vy9qYTRaay9SZmxleUpkSlIrd3hveFFnQUtDNG01OFBtZENPZ25yRDlSTGQx?=
 =?utf-8?B?VCszODUwVUxMaUh3TEg0eEp6eXZncnZvcHh6Yk0xYnpaemNiZ21oY0Focit4?=
 =?utf-8?B?WmxmRzRnTGhxQmpoakZ5K2xJWEkyRzFtM2ltM0lBdTgxWTZPRHJucldlV3Z0?=
 =?utf-8?B?aWlQci9oa3RxT3F6czBVQkZ4cGRLcmZuSHQ1YStIL25EdzEvNkVTeHBvcy9E?=
 =?utf-8?B?dFNScW81MThmQmF6NHgzMkQwS1JlY3IyVWlNeUU1TFBobWRFQlc0T2FPa2dC?=
 =?utf-8?B?bG5DWERLcllSUTRna2E4YXlFbjJyM25aR0NuSDlVMlpWbWg5TGl0cmhIVyta?=
 =?utf-8?B?cTJpYXhPV3hoVjlqTlpiMEU1VVJMRGRhZWhWaERjb25HUVZ5dm5rTlY2UWdR?=
 =?utf-8?B?Tmx1THNVN0VWdWJCM2UzRkM4TFFrbGU5Nk1CamV6SjZtTnpmaTY5TUtRbXNY?=
 =?utf-8?B?NDRNenZpa3lUZ00rK0xnNzBhS0RnUkJ2eVNEYTRzRGxmRGl4c3hvRVdNWVJa?=
 =?utf-8?B?NGhhVlVHcWdhRys0Mm91TnpXYVpuQWdQZUJGOUc1YkluSkprT2xoYmRqQ0px?=
 =?utf-8?B?cWViWHJpSnM4LzVKa2pYOVNRSUNXZ0t4ZnV1TmlVNi90dTh0MElFMHFXWlRP?=
 =?utf-8?B?WUV0Ty9XYnRhblN0Qml6cG1DQm4waXYwZFRNZ0JXQ1pnNzlOMm5yUnAwcjR6?=
 =?utf-8?B?SVNkZ3VDRFliVm4zWDhMbGtwUDduY09YOTZHREwxVm5NTTdTOTR6T1hSbkFy?=
 =?utf-8?B?dHRqNXhZeGZheVJkM0hjOTNsZENNZDlvcUNsSmRKWk15bkRuYXA2RGpJeWYw?=
 =?utf-8?B?akdEVjM5OGpEZUNvcHZjbmFidjlEYmhmakdIOW4vckxyRDlBTE1DUGlOWHYz?=
 =?utf-8?B?U0Z1NnFIblF2TElvRGtOazJKNUtVd2F4SjdyK3JXZ21BNVBodHN1dXk1c28x?=
 =?utf-8?B?aTgzdmpvMmhqUDJFZjJvZXdiQ0dFdFp1RDhzNkZCTFJZejMzOHpqQWh6NGtJ?=
 =?utf-8?B?a0RvZ1U0VnB3K3pnQjgyakhCVGFUQzN6aGJLNTM0WHBaV2hIK1FiTnZYODE0?=
 =?utf-8?B?bmxRRVpGTVFZaG9pVzd2cnhzb1hGKzlYUmRkQjUwZkhqYjlnVE44cDdrSjNO?=
 =?utf-8?B?ZGEzb0ttdlhZdWl2Y2pEV0xMaTJwYWVkaHJBczF2Q0ZqUVJuOEdUOFFQUHdm?=
 =?utf-8?B?QytYVmNFTU9teFRjODUrMUVIdWtwNmpEKzZwUmxwRmt2NFl2dStqZ0VPQ0xH?=
 =?utf-8?B?R2NvM1VTMXVZcU8xN2tjMlZnU3UxNWRlL1E0TEg5d1dQOUFadnhmeUdPV1or?=
 =?utf-8?B?dWJYWkhJMTZpZmJxMkUxa0VXaWMwVVI1M2JIRDNQWWpReiswZ25yb0txYUl4?=
 =?utf-8?B?STVzRHYvTjAvUDl4MCs3SXpGanA2NnZoMVlVVS9tSk5CSnhSWE9DbWdlZmVG?=
 =?utf-8?B?UldqOVNHVVdQYmpjQUZiKzFoaXRPeHhNTnVkSnFnRDl1akhCQ3l0Z2tDR2hV?=
 =?utf-8?B?QU91cmhFQy9KZDhOUDVzOGZJOVFPSjZFTTVCblVNbzdrN1lwZ3F6aDZ3UXdn?=
 =?utf-8?B?TDdNSjR3eWsvS0NRUDFpelRlY1lzVVJlUG5yM2hYeUQ0VFZmMmRmZTlmRW9J?=
 =?utf-8?B?UytseWhydEtqTllHV0ZyVjNMcDFuLzVBQkNaUDFucmp5WlJLWjhSY1BVQ0lT?=
 =?utf-8?B?TDByTmFqNU8xdWwzV0E2eTRHUElOQll2R3JpcnljM1VnZThWNUhNYkw4UHRr?=
 =?utf-8?B?b05EejgvSDZDL2ZOOTlQUUM3Y0Q5VFpVTXVYcUo1YVk4cVZ1UjcydjFlYWVu?=
 =?utf-8?B?OFhibW9RYVFuYzNSSlNyOFVicFVKMUxHd0diOW1IWkVzRFRTaE9BR1ZNR2lH?=
 =?utf-8?Q?RYVk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d09BdHY3TkhEL1ZUbjBGMG4zaUtEZUFyM2dYU3A3dnlKYU5pRFJQRFdIaURR?=
 =?utf-8?B?SEJkZk80ZXM1eFE5bnFTelNESTlkTUszb2phNVpoR1R1OEp2ZEROL1hNVkJq?=
 =?utf-8?B?bkpJT3IvN21SZk9JTFovUW4zUEFhdkJSTkcxNG5Wdm5Xdm55Y1JnOFRsS25h?=
 =?utf-8?B?NlFDRFpnelVnQjJ2Z2wxM081WGpsanhyemcybFlCTW1uTTl0N0RBd2FZRlVU?=
 =?utf-8?B?ZGhOWkI5NUVucHJqU3pIdExCRTY3NkNPdVhHZ1paNER5RWZLVkNXc0VqQncz?=
 =?utf-8?B?R004MVloZ2djenV6OWlvNXdjR2FVRGo3alAwcWJ5d0hzM2U5ZElheFRxK05P?=
 =?utf-8?B?UVI5VXBIZE5pQVg0RVFmVS9aZ3cvNDZvS0IyOExBWTF6ekorWHhGbjBNNkt2?=
 =?utf-8?B?elB0T1dIa0ZpM0x6SGlzdGlnMXBFN3R6bGZ1aVdFZ0JRdWJKTGdDOHdVTm01?=
 =?utf-8?B?WFdkaC9oaGEzSEErOXBONFBtUkpMSEdTd0ZDZ29YU3lhbXV6b0VxYWhKNnlN?=
 =?utf-8?B?MnJwS21jWTJxaEk1OEZZaXp2cUgyRlV5eVlvMFNmWno4WG5xd0x6V2NuWm9T?=
 =?utf-8?B?ejA0WHdZVk1TeWhyQll4ZTBLNFNtMGRKMzk2eTFqSVB2czZRUXl2QlFCOCsv?=
 =?utf-8?B?WWVvZjYzaVRRQzluT0gxTEhUdjFveWZaeHM2c1ltUGMyZ2VEUHF5WGZxdW5X?=
 =?utf-8?B?SjFhWGQ2eEFna0s3TGFvZEtsQjRZRXNzOEk0c3F3MlJ4cDNML2JmTkZqaWdq?=
 =?utf-8?B?RDFZNkFybmo2LzdBY3hQVnNMUkIwM0Vja3RVVW1BeHZvbEl6S25QOGQ5cWhZ?=
 =?utf-8?B?MzN2ZjU2clhwNXFiZDZWRFFENy9zejhRb1dHdUlVd1pQQmpmVE5SME5tNE5D?=
 =?utf-8?B?bitHQzlTVXlJRGlmKzlUQW9xTWtibStKQ1l0ckh6N1Fzc3BJbXpCaCtnaWpE?=
 =?utf-8?B?clZDcEZYN3J2Q1phSndOMXlUUDdhK0F1NGVBYUtjNzVpd1FCa01JNkxORzl0?=
 =?utf-8?B?Vk5pbWw1TmZVbjZ2VFM1K1VGR3VpSExWL05xNUxWcGs0Q3cyQTJGbmg5VmR2?=
 =?utf-8?B?cTYrTExIcUFBTUFNUE9wUm04WldMNndlUXUwM1RSQjZONTJKZjFDRlpzQjl5?=
 =?utf-8?B?OWhPMWVpTTVhTk90U0pId3Y5Mk0wVUdXSm9oTWVKYTZMRW1tZWplMXlCZDVV?=
 =?utf-8?B?VEpjSEhvSk9BNDRaZGJWQmVocjFnWHFjQkFOY0pvb2NzaWFoN0JjY1ltSzc4?=
 =?utf-8?B?VE9qUytoeUdPNkFzZHQyV05CM0k3U1JBNFVWMHJUalZrcGczV04yQzQxV0Yv?=
 =?utf-8?B?WFFYVG4vZnAzOFE3Tld3a1hYdzdIbzdmVHhLNHRLMUxpUXFZZzFMT2NWbW9h?=
 =?utf-8?B?c1gvcGhlS1V3Mk45MlFIUzhHTmtsdXZub2UwVWtBMGJ2UTlHc0E4Wi8raEpL?=
 =?utf-8?B?T280VzU3V0dUUTNNR3VJaE02ME11V3BkcTJYZVAvMHhOaE5OaG1DdTR6MU5E?=
 =?utf-8?B?dW91VGRRb1FzTTgybjFZZ2N2UmE4ZHl1QmRzNnZkbUczamtueFNOMUNFa2Jj?=
 =?utf-8?B?bFlOZ21DSFZ5cldWZFZGeTAyT3NIb1VGNG50N3RHY0tEWnRJMGlwbldtUkE0?=
 =?utf-8?B?LzJDZitweDFaeDNrakJJZDVTNHNOdzVZQ1hDZEpqZ0tQODNOUDdCQ01hNEVq?=
 =?utf-8?B?eDRObHJWRkJRb0JDdVRlaW9xWW9zRG56MVpCMFNJc3Rxa3h2Y0diYnV4RVEw?=
 =?utf-8?B?QTVoNHp0NVZvSEQzWDk0bFZYUUxzTVNsejRtU1BNUDZsM1M5MHlDWnNBNHl4?=
 =?utf-8?B?QVBaNVFHRW0vTGpkVGlzUDV2M3BoRVFHVWdXOFZZZExOaDVaaTVGdmY2cFJR?=
 =?utf-8?B?Nll5ZndVMzg0d3hkNFpWMHFIamgzSjlsWkd1R2hyVjRpbE51Sk5tRkFHcUU1?=
 =?utf-8?B?QnFxODl2WHlJeE9sRWJGL0Y0RHM3VzFjZUd1QWFnYjgzV1hCR3V0OWN1b2lE?=
 =?utf-8?B?cVhEQWlJS0ZTN3VYU0xrVnlEN1ludWhpelJLVFhPWFFMVzZNVUdCbGRHM2F6?=
 =?utf-8?B?SmN1UGxhYTdDRjBnaGV3NWtvRHJFTlFnRVdnVjdDaFZKMURrakkwVFBnNyt3?=
 =?utf-8?B?aFFWQUpFZk93TWlIT0xmQUZyU05IUytsSC8xZnVBenQ4RnIxRExWU3FYaWpy?=
 =?utf-8?B?ZGErb2pYa0thc1pYRzNSR2FHMkdzWGhOY2JPYzhYTGJ1Tlp0WWIyczNnN0Rt?=
 =?utf-8?B?R2FnOG1LakNKak82cVoxeG83SmF3UkFKUGNRNkpWQ1d4ZXpBWWpHbW5kVStO?=
 =?utf-8?B?SVUvQzUwbkgrZUZINWZIeEZTVGtaWUxFMTN4M2c5Y3JoTjU4WnJDaCtZR2or?=
 =?utf-8?Q?axD3/O9taiaNsXdI=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dcf5319-cc4c-4428-e597-08de6972748b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 13:35:43.6942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWY7PfrutZXDOmFcNvTcNnubKHsjteXtewTcigrwoVmyNqCRlsr540TSUbaz9hSYj2yZxNoorvnrR+Mfx3IElKiwymziXYIBEKGGPd+7XhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7488
X-Mailman-Approved-At: Wed, 11 Feb 2026 14:54:02 +0100
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

On 16.12.25 10:16, Ilias Apalodimas wrote:
> From: Sughosh Ganu <sughosh.ganu@linaro.org>
> 
> Our last sync with the kernel was 5.1.
> 
> We are so out of sync now, that tracking the patches and backporting
> them one by one makes little sense and it's going to take ages.
> 
> This is an attempt to sync up Makefiles to 6.1.
> Unfortunately due to sheer amount of patches this is not easy to review,
> but that's what we decided during a community call for the bump to 5.1,
> so we are following the same guidelines here.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>a #rebased on -next

To me, it looks like this is breaking "make cross_tools" in some way. Or
am I missing something?

With v2026.04-rc2:

> make tools-only_defconfig
> make cross_tools
  UPD     include/generated/timestamp_autogenerated.h
  PYMOD   rebuild
tools/Makefile:359: *** insufficient number of arguments (1) to function
'filter'.  Stop.
make: *** [Makefile:2191: tools] Error 2

If the problem is not on my end, then I would have assumed the CI would
be able to catch it. But "make cross_tools" is not part of any test, right?

Best regards
Frieder
