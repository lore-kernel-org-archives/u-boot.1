Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E46EC021AD
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 13:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 415AB80ADF;
	Tue, 18 Feb 2025 14:15:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="QBjcvuSx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E19D280BA8; Tue, 18 Feb 2025 14:15:11 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20718.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::718])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BADC809A4
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 14:15:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tojYozY1tgq1UD5eRDxcBNtYVIATPMz6hvtqQ2d8e3/lhfTVEobZHl/S9KqCMKS1DcbTkJkBRVZzlFXFEXO5c2EnSYf5D4AKlluug90AIN5HGW4k8pJUPYUVM7TeuiRlyImz1zqFzIprR0vt3Vfn+v8WotiSI3uBjCbkljs4T6k/AGA6tkXA6L9sVCXJF9RLpTF6qEvwuNXof2S2zzlqyNAvWwdMQVYpNz+0S2VNJQ9HlifTtXmMGO8VoqCPgaMX2blW05t7cLE7zh5LEHBVB/2oOqiNlbrqwIjBfcbYlCC359azayoW2hYObPPSeByvvdzsiaZQgvy3qGbGnRYFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKfieldnm0UfSls2keTpY7c/Q5wxQamtLTHwPRAiJuU=;
 b=nasUvEgtL74s/u+JvV7TmU5BDZ+YwhH8abYCY8nWtY2hQET107khxQvfv5R9jX8fQk7r1NXHzSB7XdkcpvVRPiQUgyGdGfni8dRjXrn/0zfwOffBbGDs1WTzvSXFegR+60vrVEtBgMXzhAUxxIfhRlJ/bJT77T3LHWHGRoAphnJDxr+soi3QFGT1lBGKwXZreCqRHfbn1Wki32BUfe4rZ9Mp1uj+I5vbWFzD3XE5G5EWtrkgS0CwyW1QqfaKpbYnl2DcK8kRIfcoFkZbcT8+wDjZvsWnlCdCJE8LEzIgxo5kF4IerOIVTJXnqWnHn15opO4FsjDy6r4gmdk9umdM0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKfieldnm0UfSls2keTpY7c/Q5wxQamtLTHwPRAiJuU=;
 b=QBjcvuSxA0RmmH1Pt5JI1+t8F8GVq88bdrpRJ9IlICBe6A+IzXDkDtV5riRrKpb/zhLXrG1RT5J8yYZVo9WgJ+7CLVRdoGw9ffR2cTpi5BYcZtixw9/bul46xEVSMSOrqDJ6LeQjxJZ80co6ZffgeOtxHgTbGtzZuMHRadon6ypsmN7nrk/zUU+CBCImKPP1uQ39j3vLsgaUTOTwbNMY4AyjqrFgYwRYg2PwPIdz5MYIWZ7C1PA95v7bj1VBcQhjHw9PBdbyyIkcOF7swubB3XBnjlk25TVW5jrvHQ42Qkk8CWfwS1vkTHCKGsFkwafuICqXTTazZnFRvfVMneTcPw==
Received: from AM0P195MB0386.EURP195.PROD.OUTLOOK.COM (2603:10a6:208:b4::32)
 by DU0P195MB1818.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Tue, 18 Feb
 2025 13:15:07 +0000
Received: from AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
 ([fe80::3f8f:9315:c279:d35f]) by AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
 ([fe80::3f8f:9315:c279:d35f%4]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 13:15:07 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: "sjg@chromium.org" <sjg@chromium.org>
CC: "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>, Benjamin Hahn
 <B.Hahn@phytec.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Yashwanth Varakala
 <Y.Varakala@phytec.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Teresa Remmet
 <T.Remmet@phytec.de>
Subject: Re: [PATCH RFC 6/6] binman: doc: update Optional entries
Thread-Topic: [PATCH RFC 6/6] binman: doc: update Optional entries
Thread-Index: AQHbcjjLfXNkb9lhtEeZVLV5ci3/5bNAlVuAgARWDACAAG+WgIABHk4AgABwngCABEqqgIAAYmsAgAGS0QA=
Date: Tue, 18 Feb 2025 13:15:07 +0000
Message-ID: <150cc82d61583d092aed27ce043c6316b093a13a.camel@phytec.de>
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
 <20250129-binman_faked_optional-v1-6-a4534bc67cbb@phytec.de>
 <CAFLszTgFvp_YYHZ5GzvZAfLmWeGmoTW5_vhM88ebd7RoA3Mo=g@mail.gmail.com>
 <54732a43eeea4e18829a0c1d561110d9de07e286.camel@phytec.de>
 <CAFLszTik+WRQUb8++nvZxdNPeipeOCyFwMF+WaVJZ95-peHY9Q@mail.gmail.com>
 <d3bfaf2fda01b1ace77d3335028bb5adcf536197.camel@phytec.de>
 <CAFLszTjhYPkaQdtxrNNkLnfg=YkJ6f7JRtg=jPjDR2h_DD8Wkg@mail.gmail.com>
 <8efb1beb7dc94f16919b00fa88fc8048eec80905.camel@phytec.de>
 <CAFLszTg0UXfcsy8-A9QMq5CSsAvAXHLKRBpHyzdNuwdj17VwKQ@mail.gmail.com>
In-Reply-To: <CAFLszTg0UXfcsy8-A9QMq5CSsAvAXHLKRBpHyzdNuwdj17VwKQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0P195MB0386:EE_|DU0P195MB1818:EE_
x-ms-office365-filtering-correlation-id: 88debf65-e2f1-4954-b523-08dd501e43c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VklvLzM5WDBiaUJhQjNvWDhIZXhCKzFHVmQ3WGxPeEhNdUhDa1VMdmRYSEJp?=
 =?utf-8?B?OEE2ZXZBZEU0ZjlQZVFZVzRQdTRVQmY0cXJmZmhIUVN0QU5nRlI3UXpEWGtm?=
 =?utf-8?B?Z0hldEFKbXFjbHJpTWhDeUJWRUpaVExSWld4cmc0UFBEQnhXZFZEZUdMQnJG?=
 =?utf-8?B?K3dDeXRNNzBrNEJkcVpjZXpBV2FzV0UrQSs5YUlIVTFLSzFCU2tDOVpES2d6?=
 =?utf-8?B?VEo2ZHNPUEM5dzAxUjNTR2ErODFnWWIzUnlDdjlPcjZxMm03MEs5M3ByM0hX?=
 =?utf-8?B?c3h6VmlXVVZqYXloRkV6bzdvZVpJb1M0NktkOUdxeDNqcjhLZGFMczZxK1Rr?=
 =?utf-8?B?Nzd0TzR4YUZlL3lnaFpLalphNlBpdDdvS1VxSjVSVGg0eXFUamF0cnZwVlBy?=
 =?utf-8?B?THIwRHhLMGxBK1Z0aXpueXB2ZmMvU1VVa3gyOWZzVzJxRTczUUFuUVltOWxD?=
 =?utf-8?B?aGc1anRhUHZaY2hCNG5RRS93ZDN3WHY3ZVRNaENUZDdPVW15bEg0aFV5NHFp?=
 =?utf-8?B?eXM0OHVtRzNrejE1TXQ0WVJnbE40UEU1SENXZFVLa3FuY3Z6M2Frb2tTZUNZ?=
 =?utf-8?B?VkFObDNIa0pIRkxFdVVReTdyaXd5UDFFRi9jQms3VHB5NDhOTUMxMXpuMC84?=
 =?utf-8?B?VDdHY0hZNXZVSStBblluMU4vYTluTC9VVWgvZ01JMGI0WHlHRkRLNzR4Q1Zu?=
 =?utf-8?B?NXorRWsvWnlEK3IvNTNwTGUzdDF0OEZqcG5qR1hOOFdtRC8xem1FTHZlUURP?=
 =?utf-8?B?Q3JDcTNTcytKT1pjNFJpMmVBVjJiUTNibXkrUThkOUJ1ZHhGSEU4U0F5dWdk?=
 =?utf-8?B?cjZoMXd2Q3NjQjM4QXZvWG0yeXViS1V6QSszVEVOaW9tUGxNMW1idU5Qck1F?=
 =?utf-8?B?aU5yc0RqbUcyMVE2eXpzQ0t0RG1RR29iK25TbVJ3QkdWeWdka0xYb2xscnhI?=
 =?utf-8?B?QjNtNHZUL21JMFZzeFdrZUp0ZncvQ0o5MFh5Ni9oR29razN4RXNYZFhxSkQ3?=
 =?utf-8?B?b0lkcVF2bHU4UmZGNnF5blNqZDQ5Y1dNM0ZFSUVQR2h2c05aK2lpQU1hNjVO?=
 =?utf-8?B?MUU5cnFYMjBTSkN4MHN3M2dLZlMwMWg1aDlHNyt0TklyMjhNdE5SNWtMQ2N3?=
 =?utf-8?B?ZWEyVkdwd1k5RFhWUmdXS0lRWVJlVnFYRDBVeDFkUG1HK0RldFJHL0NlSjcx?=
 =?utf-8?B?Y3d1Mk82MGR0bXRtRGpsdG9HVytNZkVjcEhsWDlicFI4bUpJL1NDdCtMTDNU?=
 =?utf-8?B?NTJHOHhXWU5HQmh0dTk3MUt6TDdNNThYSmtxZlAxa3pYSVl6TVJRQ2xOak5j?=
 =?utf-8?B?VUtwVEV6Uk5OdWxwT3h4bjQwaFhSU1pnWVd6TjY2UnZFYmZvUXpjc3M3TVBB?=
 =?utf-8?B?b3NLaTBIb2RwR1BCalRQdmZ2WHhycXdKYmp3TitsTzVEVHBuWTJPa1RieURI?=
 =?utf-8?B?eUFkWUVFd0JVdWxUOUtyZk4zbGRWblNUdS9pVldEV040eVY2b09QejJwRFlB?=
 =?utf-8?B?U2duRURiVk4yUE9hV0ZtTTFaWUIzU1FzSlFTVEFSTXJyem1PYzNod09UQUIv?=
 =?utf-8?B?Um9BY3FVcVdORVRUWkdTcjlHeG5RUVNvOHJEOWZiN2htbTNsT2N5U2RiS1lP?=
 =?utf-8?B?Y0tiYlRaajhmZmRQS3graUFVclB1aFdzb1VUcnF4TnZETFRsUS9ZTVlFRy9B?=
 =?utf-8?B?M29NSXV5NUREWWR0blJYTkE2V3NBZjA0bWsxL3FGdndSOVVIaGlPYjlwNFQv?=
 =?utf-8?B?RlpEVCt0YlBpRVBJNnhiSEpLTGxrZ2Y4NXdveFdJZXZjUm8yZ0hkTmhOZmpE?=
 =?utf-8?B?TktPWldFcGxTQTNrbWRGL1E1NS85a1JNeUVUVU9TdlJieUZ6Q3JqaVdVQ1kr?=
 =?utf-8?B?Z3gyL1lxbGJtUVhLaWxma0NVUCt3Tll3RXN3VVY3K1h5a2Q2aXpBbWVRTDNX?=
 =?utf-8?Q?YGWpBSMGTCGlc5wA/IG/m+ghUkh9G3CH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0P195MB0386.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEJiWVRuSDcvN2JnT3dkWllLSk41eDlOSFVYRjBIdk9LRVo4YnozRk9yR1RC?=
 =?utf-8?B?ZUt2b0lSY1I1clpoeHordzNCTUpkbEpJOUdHV245VlkxQy80anh3ZC9aRDZF?=
 =?utf-8?B?MFR0WTErL1dwbGJXMU1RdmxsVTFQcUk2cUFYaEV4YWwyeFVEZ3YvSzFBRExM?=
 =?utf-8?B?blNnaSsxRVk1RFBacTJXUWpUU1ViOW0ySGlNRHluWjdVVE1CYkZnenNtLzRG?=
 =?utf-8?B?WFBNeHJ5bVlPY1p3UHNpbDRvd3N6eTZ0OFVBZmN1dGRPWnpMNnRTMVB5b2Mv?=
 =?utf-8?B?eG5hcE9tMnhuQWlVaXpqaTlBLzNIZkNqKzNhNTFpa21KQnpCb0grVW93dDBi?=
 =?utf-8?B?Szh3eVlGbm9ZS1RIdVVrSkZMbERSaHdTdXRDOHRhRGYxbmQzbTI5Mm4xbGs0?=
 =?utf-8?B?NThNV3Q2bDVFN1NxQWtXS0Z6RWpPVU5tRVFMem1XZXk0ZTZZRzJlVHI0Qkp4?=
 =?utf-8?B?WHpoWTVyMkdoWUtzOUVGT2ZQc2VJZEc1NjE1UjhpK09Xb0tUTmg0eDRHcWdi?=
 =?utf-8?B?aDYwVGZaeTlEQ3FKYUlneVp0Qjdsd2tMNFhZUFpNcXB0LzFFb0JMd3RySVZv?=
 =?utf-8?B?b0NXYWhZeWhzTU5rNWxxaTc3U2VIdUh4dk5nU1d4cVU2RUFBWTlUNkxyaVpF?=
 =?utf-8?B?dU5JNE1vVVNCUEU5L1ZIdFZCNG5ZN2JnUnhNaUZ5MU9ZSUNCMkM4N2RiSWxl?=
 =?utf-8?B?bjg2Y0VzWVRaZ1FtMGRKalhYa1pIMVU2d01MQTBQdkJvSjkxR2U4TXBSZ0dM?=
 =?utf-8?B?ZjZjYTNTRGkyZW55WlUwaEoxa0NvK3FTOUhzTTk0RjBGaHBoZllFV3VzRUpo?=
 =?utf-8?B?UmpwREdmNklTaks1cmI3ZHM3K2NyQVBTTk9sWGNKUVVuUzVpbDdFTFNRYlgv?=
 =?utf-8?B?VGVVKzNrVlIrVmlUbXFCbURmWGdldnR2L3VvbUJyc0pEU1FPaEZOL0FqUkJy?=
 =?utf-8?B?emVwR2hVN2FDc2ZQcEFWRng1NHh6akdDSFRXM3BKUTJqZmlxZFNJRUlXMXRX?=
 =?utf-8?B?eXVJeTJBWGRLaWZ2RXl5ekVBd2FxUk8yY3VBeXREUGE4UFl1WmhxZW5ZbkNO?=
 =?utf-8?B?UlhZcWlvQjUxcmlwUFFQdC9hYldDU3lXV3hqaXVJTU9IK3BlWEt1RS93WEZm?=
 =?utf-8?B?c1oreVV4bVltNU5nY1pnOUIyRkZEcnJUY2o3NDBycDJtenNSYzFodE42ckpI?=
 =?utf-8?B?WUhRam9KbVB4TytKem9zS2JXR25CWWh2ZlBUWmowd20xQ093ZjA3bXJvY3kv?=
 =?utf-8?B?Uk9yMnJlbDFzU3h5cDdXZnNvSkVtTGJDdGFMVGcvUjF3d1paK3Y5YTZqanBh?=
 =?utf-8?B?Qk5KbDI1WllJK1ZYN1F0eEVTV05ubm1SVE5YalpDUXd1K2dVMjhOYlFBVklX?=
 =?utf-8?B?cnZGaE5ZaXNiTjdGY3FiV3kxSmxWbTQzSTlCcXFMRy9XMnoyczl3Q1YvcGNW?=
 =?utf-8?B?WmZ1bUpXU3RSdzc5TjVsaFRKSitFaXpyamFhNTNqRGRTeGdhZFNmTjcrVXdh?=
 =?utf-8?B?Qmd1RDMzTFpvM3JJWGdUdFFjZVdQc2E1MmVEa2ozN0sxMFYxTEk1bE8zSFhS?=
 =?utf-8?B?QStFUktFbmlpNisxcm5hVURuSzBYUC93TTNzV2NBenNpOHV6RUc3S3hOWWpu?=
 =?utf-8?B?NVBiTEs1Z0oxWnNFTlVWdEVienNLbmxHdEpIeWhxTTc1VXIxdmUxR2JzNWJ0?=
 =?utf-8?B?NnFuSnRaa0hBOHZ2YzVmMU5ITWdJaTlsWHloQ1FWWXpJbHY2ZG1ydndraDQ0?=
 =?utf-8?B?ampwVFBHaFZVL0JZc0FRbHlrYUZHWGt5WFFTZmF5RFZ4UmFtekJIQWxTWFdu?=
 =?utf-8?B?Vlc1cnpRRWYrbWcxRGI5NlZqclpVRE5LcFFkZzRiYkdLY1dhKzVKMUt5MWxI?=
 =?utf-8?B?WTdkT2pZKzNZN2h1M0JPdFdycFhaRE53SnFwNU1RRzlHOXZGU2lBNDFuSVlV?=
 =?utf-8?B?OXNkOFMzOGxsT2lsekFDYmkySHhWYVNjS0JxU0xvSUhSMW93bE5odUJwT1Fk?=
 =?utf-8?B?bmo1ZHpVZDlNcXI0MXhKYzhQeS83enB3UWxIZ2d5YkJBQVlEQXVxTnFWaDM3?=
 =?utf-8?B?cnUrbHIvWUoxVll1RSt5OG5pZ2dwYXlPdlFZZVc1WS8vWDZaVWY3czJhMEow?=
 =?utf-8?B?bWI3WkIzUlpUVWEvZ3pabUxIZzNZcXpvbWZHektsdjFXS3creDRaQk1SSWNS?=
 =?utf-8?Q?b9kZQkYxSyMwpw+I5NDbUXWEP2bXjDjUVOzhanpltE/j?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DD7D82166E6154685AFD6A19FB6AC00@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 88debf65-e2f1-4954-b523-08dd501e43c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 13:15:07.2233 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OK8lumnYaG9U50CdZxO1nx3PRcr0ObJrmAknbJ9FX2bUtzH9Td6Pt/SEbAbieTJTtNe+mTbHXPk57zfLuERcLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB1818
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

T24gTW9uLCAyMDI1LTAyLTE3IGF0IDA2OjEzIC0wNzAwLCBTaW1vbiBHbGFzcyB3cm90ZToNCj4g
SGkgWWFubmljLA0KPiANCj4gT24gTW9uLCAxNyBGZWIgMjAyNSBhdCAwMDoyMSwgWWFubmljIE1v
b2cgPFkuTW9vZ0BwaHl0ZWMuZGU+IHdyb3RlOg0KPiA+IA0KPiA+IEhpIFNpbW9uLA0KPiA+IA0K
PiA+IE9uIEZyaSwgMjAyNS0wMi0xNCBhdCAwNjo0OCAtMDcwMCwgU2ltb24gR2xhc3Mgd3JvdGU6
DQo+ID4gPiBIaSBZYW5uaWMsDQo+ID4gPiANCj4gPiA+IE9uIEZyaSwgMTQgRmViIDIwMjUgYXQg
MDA6MDUsIFlhbm5pYyBNb29nIDxZLk1vb2dAcGh5dGVjLmRlPg0KPiA+ID4gd3JvdGU6DQo+ID4g
PiA+IA0KPiA+ID4gPiBPbiBUaHUsIDIwMjUtMDItMTMgYXQgMDc6MDEgLTA3MDAsIFNpbW9uIEds
YXNzIHdyb3RlOg0KPiA+ID4gPiA+IEhpIFlhbm5pYywNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBP
biBUaHUsIDEzIEZlYiAyMDI1IGF0IDAwOjIxLCBZYW5uaWMgTW9vZyA8WS5Nb29nQHBoeXRlYy5k
ZT4NCj4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gT24gTW9uLCAy
MDI1LTAyLTEwIGF0IDA2OjA4IC0wNzAwLCBTaW1vbiBHbGFzcyB3cm90ZToNCj4gPiA+ID4gPiA+
ID4gT24gV2VkLCAyOSBKYW4gMjAyNSBhdCAwMzozMCwgWWFubmljIE1vb2cNCj4gPiA+ID4gPiA+
ID4gPHkubW9vZ0BwaHl0ZWMuZGU+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gPiA+IFRoZSBiaW5tYW4gZG9jdW1lbnRhdGlvbiBvZiBPcHRpb25hbCBlbnRyaWVzIGlzIG5v
dA0KPiA+ID4gPiA+ID4gPiA+IGFjY3VyYXRlIGluIHRoZQ0KPiA+ID4gPiA+ID4gPiA+IHNlbnNl
IHRoYXQgaXQgZG9lcyBub3QgY292ZXIgYmxvYnMgZW50cnkgdHlwZS4gQXMgdGhpcw0KPiA+ID4g
PiA+ID4gPiA+IGlzIGFsc28gdGhlIG1vc3QNCj4gPiA+ID4gPiA+ID4gPiB3aWRlbHkgdXNlZCB0
eXBlIHRvIGhhdmUgdGhlIG9wdGlvbmFsIGVudHJ5LCBkb2N1bWVudA0KPiA+ID4gPiA+ID4gPiA+
IHRoZSBpbnRlcmFjdGlvbg0KPiA+ID4gPiA+ID4gPiA+IHdpdGggZmFraW5nIGJsb2JzLg0KPiA+
ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFlhbm5pYyBNb29n
IDx5Lm1vb2dAcGh5dGVjLmRlPg0KPiA+ID4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gPiA+
IMKgdG9vbHMvYmlubWFuL2Jpbm1hbi5yc3QgfCA5ICsrKysrKysrLQ0KPiA+ID4gPiA+ID4gPiA+
IMKgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS90b29scy9iaW5tYW4vYmlu
bWFuLnJzdA0KPiA+ID4gPiA+ID4gPiA+IGIvdG9vbHMvYmlubWFuL2Jpbm1hbi5yc3QNCj4gPiA+
ID4gPiA+ID4gPiBpbmRleCA5OTBmYzI5NTc3MC4uMmJhZmE2Y2E0MDggMTAwNjQ0DQo+ID4gPiA+
ID4gPiA+ID4gLS0tIGEvdG9vbHMvYmlubWFuL2Jpbm1hbi5yc3QNCj4gPiA+ID4gPiA+ID4gPiAr
KysgYi90b29scy9iaW5tYW4vYmlubWFuLnJzdA0KPiA+ID4gPiA+ID4gPiA+IEBAIC0xMTQ1LDcg
KzExNDUsMTQgQEAgY2FsbGVkIG9uIGFsbCBlbnRyaWVzLg0KPiA+ID4gPiA+ID4gPiA+IMKgSXQg
aXMgbm90IHBvc3NpYmxlIGZvciBhbiBlbnRyeSB0byBtYXJrIGl0c2VsZiBhYnNlbnQNCj4gPiA+
ID4gPiA+ID4gPiBhdCBhbnkgb3RoZXIgcG9pbnQgaW4gdGhlDQo+ID4gPiA+ID4gPiA+ID4gwqBw
cm9jZXNzaW5nLiBJdCBtdXN0IGhhcHBlbiBpbiB0aGUgT2J0YWluQ29udGVudHMoKQ0KPiA+ID4g
PiA+ID4gPiA+IG1ldGhvZC4NCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiAtVGhl
IGVmZmVjdCBpcyBhcyBpZiB0aGUgZW50cnkgaGFkIG5ldmVyIGJlZW4gcHJlc2VudA0KPiA+ID4g
PiA+ID4gPiA+IGF0IGFsbCwgc2luY2UgdGhlIGltYWdlDQo+ID4gPiA+ID4gPiA+ID4gK1RoZSBl
ZmZlY3QgZGVwZW5kcyBvbiB0aGUgdHlwZSBvZiBlbnRyeS4NCj4gPiA+ID4gPiA+ID4gPiArDQo+
ID4gPiA+ID4gPiA+ID4gK0Jsb2JzDQo+ID4gPiA+ID4gPiA+ID4gK35+fn5+DQo+ID4gPiA+ID4g
PiA+ID4gK0ZvciBibG9icywgdGhlIGVmZmVjdCBkZXBlbmRzIG9uIHdoZXRoZXIgLS1mYWtlLWV4
dC0NCj4gPiA+ID4gPiA+ID4gPiBibG9icyBpcyBwYXNzZWQNCj4gPiA+ID4gPiA+ID4gPiArdG8g
YmlubWFuLiAoVGhpcyBpcyB0aGUgY2FzZSBieSBkZWZhdWx0KQ0KPiA+ID4gPiA+ID4gPiA+ICtJ
biBjYXNlIC0tZmFrZS1leHQtYmxvYnMgaXMgc2V0LCBhbnkgbWlzc2luZyBlbnRyaWVzDQo+ID4g
PiA+ID4gPiA+ID4gd2lsbCBiZSBmYWtlZC4NCj4gPiA+ID4gPiA+ID4gPiArSWYgbm90IHNldCwg
aXQgaXMgYXMgaWYgdGhlIGVudHJ5IGhhZCBuZXZlciBiZWVuDQo+ID4gPiA+ID4gPiA+ID4gcHJl
c2VudCBhdCBhbGwsIHNpbmNlIHRoZSBpbWFnZQ0KPiA+ID4gPiA+ID4gPiA+IMKgaXMgcGFja2Vk
IHdpdGhvdXQgaXQgYW5kIGl0IGRpc2FwcGVhcnMgZnJvbSB0aGUgbGlzdA0KPiA+ID4gPiA+ID4g
PiA+IG9mIGVudHJpZXMuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBJJ20gbm90IHF1
aXRlIGZvbGxvd2luZyB0aGlzLiBUaGUgdGV4dCBzZWVtcyBPSyBidXQgeW91cg0KPiA+ID4gPiA+
ID4gPiBoZWFkaW5nDQo+ID4gPiA+ID4gPiA+IGltcGxpZXMgdGhhdCB0aGluZ3Mgb3RoZXIgdGhh
biBibG9icyBjYW4gYmUgZmFrZWQuIEFsbCBvZg0KPiA+ID4gPiA+ID4gPiB0aGlzDQo+ID4gPiA+
ID4gPiA+IGZ1bmN0aW9uYWxpdHkgaXMgb25seSBmb3IgYmxvYnMuDQo+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+IFRoZSBoZWFkaW5nIGlzIGEgc3Vic2VjdGlvbiBvZiAiT3B0aW9uYWwgZW50cmll
cyIuIFRvIG15DQo+ID4gPiA+ID4gPiBrbm93bGVkZ2UgdGhlICJvcHRpb25hbCIgcHJvcGVydHkN
Cj4gPiA+ID4gPiA+IGlzDQo+ID4gPiA+ID4gPiBub3QNCj4gPiA+ID4gPiA+IGxpbWl0ZWQgdG8g
YmxvYnMuIEJ1dCBibG9icyBnZXQgc3BlY2lhbCB0cmVhdG1lbnQgaW4NCj4gPiA+ID4gPiA+IHJl
Z2FyZHMgdG8gIm9wdGlvbmFsIiBkdWUgdG8gdGhlIC0tDQo+ID4gPiA+ID4gPiBmYWtlLQ0KPiA+
ID4gPiA+ID4gZXh0LQ0KPiA+ID4gPiA+ID4gYmxvYnMgb3B0aW9uLiBIZW5jZSB0aGUgc3Vic2Vj
dGlvbi4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gV2hhdCB3b3VsZCB5b3UgbGlrZSBtZSB0
byBjaGFuZ2UgdG8gbWFrZSB0aGlzIGNsZWFyZXI/DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gT2gg
SSBzZWUuIEFyZSB5b3Ugc2F5aW5nIHRoYXQgb3B0aW9uYWwgZW50cmllcyBlbmQgdXAgaW4gdGhl
DQo+ID4gPiA+ID4gaW1hZ2UNCj4gPiA+ID4gPiB3aGVuIHRoZXkgYXJlIGZha2VkLCBleHRlcm5h
bCBibG9icz8gSWYgc28sIHRoYXQgc2VlbXMgbGlrZSBhDQo+ID4gPiA+ID4gYnVnIHRvDQo+ID4g
PiA+ID4gbWUuDQo+ID4gPiA+IA0KPiA+ID4gPiBUbyBjbGFyaWZ5LCBvcHRpb25hbCBpbWFnZXMg
YXJlIGZha2VkIG9ubHkgd2hlbiB0aGV5IGFyZQ0KPiA+ID4gPiBtaXNzaW5nLiBTbyBpbiBjYXNl
IHRoZSBpbWFnZSBpcw0KPiA+ID4gPiBtaXNzaW5nLCBhDQo+ID4gPiA+IGZha2VkIGltYWdlIGlz
IGluZGVlZCBwYWNrYWdlZCBpbnRvIHRoZSBpbWFnZS4NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+
IE9LLCBidXQgSSBzdGlsbCB0aGluayBpdCBpcyBhIGJ1Zy4NCj4gPiANCj4gPiBJIGRpZG4ndCBx
dWVzdGlvbiB5b3VyIGp1ZGdlbWVudCwgSSBzaW1wbHkgZG9uJ3QgaGF2ZSB0aGUgYnJvYWRlcg0K
PiA+IGdvYWwgb2YgYmlubWFuIGluIG1pbmQgdG8gYmUgYWJsZQ0KPiA+IHRvIGp1ZGdlIGlmIHRo
aXMgYmVoYXZpb3VyIGlzIHVuaW50ZW5kZWQuDQo+ID4gV2hhdCBzaG91bGQgaGFwcGVuIGluc3Rl
YWQ/IFNob3VsZCB0aGUgaW1hZ2Ugc2ltcGx5IGJlIGFic2VudCBpbg0KPiA+IHRoZSBmaW5hbCBp
bWFnZT8NCj4gPiANCj4gPiA+IFdoeSBhZGQgYW4gb3B0aW9uYWwgdGhpbmcgaW4gdGhpcyB3YXk/
DQo+ID4gDQo+ID4gQmVjYXVzZSBpdCBzZWVtcyBsaWtlIGEgc2ltcGxlLCBlbGVnYW50IHNvbHV0
aW9uLg0KPiA+IFRvIGVsYWJvcmF0ZToNCj4gPiBUaGUgZ29hbCAoaW4gY2FzZSBvZiBPUC1URUUp
IGlzIHRvIGhhdmUgdGhlIGJpbmFyeSBwYWNrYWdlZCB3aGVuDQo+ID4gaXRzIHRoZXJlIGFuZCBu
b3QgcGFja2FnZWQgd2hlbiBpdA0KPiA+IGlzIG5vdCBwcmVzZW50Lg0KPiA+IFByZWNpc2VseSBi
ZWNhdXNlIGl0IGlzIG5vdCByZXF1aXJlZCBmb3IgYSBib290YWJsZSBpbWFnZSwgYnV0IG1heQ0K
PiA+IGJlIGFkZGVkIHRvIGVuaGFuY2UgZnVuY3Rpb25hbGl0eQ0KPiA+IC4gSS5lLiBpdCBpcyBv
cHRpb25hbC4NCj4gPiBJIGZvdW5kIHRoZSBVLUJvb3QgZG9jIHRvIGV4cGxhaW4gb3B0aW9uYWwg
ZW50cmllcyBhbmQgdGhvdWdodCBpdA0KPiA+IHRvIGJlIGEgcGVyZmVjdCBmaXQuDQo+ID4gV2hh
dCBkbyB5b3UgaGF2ZSBpbiBtaW5kIHRvIGFjaGlldmUgdGhpcyBnb2FsPw0KPiANCj4gSSB0aGlu
ayB3ZSBhcmUgdGFsa2luZyBhYm91dCBzbGlnaHRseSBkaWZmZXJlbnQgdGhpbmdzLg0KPiANCj4g
SWYgYSBiaW5hcnkgaXMgb3B0aW9uYWwgdGhlbiBJIGRvbid0IHNlZSBtdWNoIHBvaW50IGluIGlu
Y2x1ZGluZyBhbg0KPiBlbXB0eSAob3IgZmFrZWQpIGJpbmFyeS4gSWYgaXQgaXMgdGhlIG9ubHkg
dGhpbmcgbWlzc2luZywgdGhlIGltYWdlDQo+IHNob3VsZCBzdGlsbCBib290IE9LIGlmIGl0IGp1
c3QgZG9lc24ndCBhcHBlYXIgaW4gdGhlIGltYWdlLg0KPiANCj4gVGhlIGlkZWEgd2l0aCBCaW5t
YW4gaXMgdG8gcHJvZHVjZSBhIGZ1bmN0aW9uYWwgaW1hZ2UsIHdoZXJlDQo+IHBvc3NpYmxlLg0K
PiBBbiBpbWFnZSB3aXRob3V0IGFuIG9wdGlvbmFsIGJsb2IgaXMgZnVuY3Rpb25hbCwgc28gd2Ug
c2hvdWxkIG5vdA0KPiBuZWVkDQo+IHRvIGFkZCBpdC4NCj4gDQo+IEknbSBub3Qgc2F5aW5nIHRo
aXMgaXMgYSBiaWcgcHJvYmxlbSwganVzdCB0aGF0IGl0IHNlZW1zIHN1cnByaXNpbmcNCj4gYW5k
IG5vdCB3aGF0IEkgaW50ZW5kZWQuDQoNCkkgYW0gd2l0aCB5b3Ugb24gdGhpcy4gSXQgd2FzIHN1
cHJpc2luZyB0byBtZSwgdG9vLiBBbmQgSSBhZ3JlZSB0aGVyZQ0KaXMgbm8gcG9pbnQgKGF0IGxl
YXN0IHRvIG1lKSBpbiBpbmNsdWRpbmcgaXQgaW4gdGhlIGZpbmFsIGltYWdlLg0KU28gd2Ugd2Vy
ZSB0YWxraW5nIGFib3V0IHRoZSBzYW1lIHRoaW5nLCBJIHNpbXBseSB3YW50IHRvIG1ha2Ugc3Vy
ZSB3ZQ0KYXJlIG9uIHRoZSBzYW1lIHBhZ2UuDQoNCj4gDQo+IFBlcmhhcHMgd2UgZG8gbmVlZCB0
byBmYWtlIHRoZSBibG9iIGluIGNhc2UgaXQgaXMgdXNlZCBieSBzb21lIG90aGVyDQo+IHRvb2wu
IEJ1dCBJIHdvbmRlciBpZiB3ZSBjYW4gc3RvcCBCaW5tYW4gYWRkaW5nIHRoZSBmYWtlZCBibG9i
IGludG8NCj4gdGhlIGltYWdlLCBpZiBpdCBpcyBvcHRpb25hbD8NCg0KRnJvbSBteSBwb2ludCBv
ZiB2aWV3LCBJdCB3b3VsZCBiZSBiZXR0ZXIgdG8gc3RvcCBiaW5tYW4gZnJvbSBhZGRpbmcNCmZh
a2VkIGJsb2JzIHRoYW4gd2hhdCBJIHByb3Bvc2VkIGluIHRoZXNlIFJGQyBwYXRjaGVzLiBJIGRp
ZG4ndCBrbm93LA0KaG93ZXZlciwgaWYgdGhlcmUgd2FzIGEgdXNlIGNhc2UgZm9yIGFkZGluZyB0
aGVtIHRvIHRoZSBpbWFnZXMgdGhhdCBJDQphbSBub3QgYXdhcmUgb2YuDQpTaW5jZSB5b3Ugbm93
IGNvbmZpcm0gdGhhdCBpdCB3YXMgbmV2ZXIgeW91ciBpbnRlbnRpb24gdG8gaGF2ZSB0aGVtDQpp
bmNsdWRlZCBpbiB0aGUgZmlyc3QgcGxhY2UgSSB0aGluayB3ZSBjYW4gZ28gYWhlYWQgaW4gcHJl
dmVudGluZw0KYmlubWFuIGZyb20gYWRkaW5nIGZha2VkIGJsb2JzIHRvIGltYWdlcy4NCkknbGwg
d29yayBvbiBpdCBmb3IgdGhlIG5leHQgdmVyc2lvbi4NCg0KWWFubmljDQoNCj4gDQo+IA0KPiA+
IA0KPiA+IFlhbm5pYw0KPiA+IA0KPiA+ID4gDQo+ID4gPiANCj4gPiA+ID4gSGVyZSBpcyB0aGUg
aW1hZ2UgbWFwIGZyb20gYW4gKHBoeWNvcmUtKWlteDhtcCBidWlsZC4NCj4gPiA+ID4gDQo+ID4g
PiA+IE1pc3NpbmcgdGVlLW9zIChmYWtlZCk6DQo+ID4gPiA+IA0KPiA+ID4gPiBJbWFnZVBvc8Kg
wqDCoCBPZmZzZXTCoMKgwqDCoMKgIFNpemXCoCBOYW1lDQo+ID4gPiA+IDAwMDAwMDAwwqAgMDAw
MDAwMDDCoCAwMDE1OWUxMMKgIGltYWdlDQo+ID4gPiA+IDAwMDAwMDAwwqDCoCAwMDAwMDAwMMKg
IDAwMTU5ZTEwwqAgc2VjdGlvbg0KPiA+ID4gPiBbLi4uXQ0KPiA+ID4gPiAwMDA1ODAwMMKgwqDC
oCAwMDA1ODAwMMKgIDAwMTAxZTEwwqAgZml0DQo+ID4gPiA+IDAwMDViMDAwwqDCoMKgwqAgMDAw
MDMwMDDCoCAwMDBlNDkxMMKgIHVib290DQo+ID4gPiA+IDAwMDViMDAwwqDCoMKgwqDCoCAwMDAw
MDAwMMKgIDAwMGU0OTEwwqAgYmxvYi1leHQNCj4gPiA+ID4gMDAxM2Y5MTDCoMKgwqDCoCAwMDBl
NzkxMMKgIDAwMDA4NDU4wqAgYXRmDQo+ID4gPiA+IDAwMTNmOTEwwqDCoMKgwqDCoCAwMDAwMDAw
MMKgIDAwMDA4NDU4wqAgYXRmLWJsb2INCj4gPiA+ID4gMDAxNDdkNjjCoMKgwqDCoCAwMDBlZmQ2
OMKgIDAwMDAwMDAwwqAgdGVlDQo+ID4gPiA+IDAwMTQ3ZDY4wqDCoMKgwqDCoCAwMDAwMDAwMMKg
IDAwMDAwMDAwwqAgdGVlLW9zDQo+ID4gPiA+IA0KPiA+ID4gPiB0ZWUtb3MgcHJlc2VudDoNCj4g
PiA+ID4gDQo+ID4gPiA+IEltYWdlUG9zwqDCoMKgIE9mZnNldMKgwqDCoMKgwqAgU2l6ZcKgIE5h
bWUNCj4gPiA+ID4gMDAwMDAwMDDCoCAwMDAwMDAwMMKgIDAwMjJiNWIwwqAgaW1hZ2UNCj4gPiA+
ID4gMDAwMDAwMDDCoMKgIDAwMDAwMDAwwqAgMDAyMmI1YjDCoCBzZWN0aW9uDQo+ID4gPiA+IFsu
Li5dDQo+ID4gPiA+IDAwMDU4MDAwwqDCoMKgIDAwMDU4MDAwwqAgMDAxZDM1YjDCoCBmaXQNCj4g
PiA+ID4gMDAwNWIwMDDCoMKgwqDCoCAwMDAwMzAwMMKgIDAwMGU0OTEwwqAgdWJvb3QNCj4gPiA+
ID4gMDAwNWIwMDDCoMKgwqDCoMKgIDAwMDAwMDAwwqAgMDAwZTQ5MTDCoCBibG9iLWV4dA0KPiA+
ID4gPiAwMDEzZjkxMMKgwqDCoMKgIDAwMGU3OTEwwqAgMDAwMDg0NTjCoCBhdGYNCj4gPiA+ID4g
MDAxM2Y5MTDCoMKgwqDCoMKgIDAwMDAwMDAwwqAgMDAwMDg0NTjCoCBhdGYtYmxvYg0KPiA+ID4g
PiAwMDE0N2Q2OMKgwqDCoMKgIDAwMGVmZDY4wqAgMDAwZDE3YTDCoCB0ZWUNCj4gPiA+ID4gMDAx
NDdkNjjCoMKgwqDCoMKgIDAwMDAwMDAwwqAgMDAwZDE3YTDCoCB0ZWUtb3MNCj4gPiA+ID4gDQo+
ID4gPiA+IFlhbm5pYw0KPiANCj4gUmVnYXJkcywNCj4gU2ltb24NCg0K
