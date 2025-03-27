Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53776C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 08:29:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA86C81951;
	Thu, 27 Mar 2025 09:29:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="RtorC1Ft";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8675981D3B; Thu, 27 Mar 2025 09:29:39 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CF128070C
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 09:29:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Manikandan.M@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfcjrjHvePFKmrIcqs4G7V/BsF8ufvssLItedCUnjylstj/W47mbHhsvuSEJJ5ltBQJZWHeI54rqS+mZf0aMnWqiwYQngeSgSE2BhOGDCR4kYfDGBqxQb4/9MXtrE4x2v3dl4dgcq64vQlyTYrY7sfTBq5s7nBnKPlU5lhNYA6MdjnLS2tJV/M/+kUmWJulQvcdAox98Ki8DIHLZ5r3wYdyPhH+e+6Vi7UaJcp1rs3KXfRMW1+Z2upHfleoB4NDF4Qr62XB3lNe/aKCM5uLTdIwopk9pLrh7f7S/oqjdZhRCuk5IPN8Ekry20xjDokUrw1KmUTXc7SGBI5Rquw6JRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILKRsIiWrsKQzR68dLhgMyytZaIkgNiQrYpLY2bcTLI=;
 b=O5sBsr2sBtpGexsx3a462R5lG6MXplwIk4G/+1et6LvqcFb6EXxvWIT/WpSA4uf2QCEy8rpVI+lc08FL2j65OezBowmndPDlYPz/oP22Arou14KSd9iQ0Qz9C9Xlx7Hkb/kGSug73zJvZr6vAjE5lAnY1G1ZoqDoy9Ix5DZaqhhJtPYqlFnCF8dgSHQEMwWgFG9vvbMtwhpC1kjJKcNJcfqLctyxAOmjpUvBPKZ5mA6NVZnHVBAP2V92Q0ZvIU5rWT79LtbNU0ht0GySAjQnnV/rVNSOa/mt6McufiVkPd1ybjvU4OoP6Ata29R5RephasVXYLcBLWbRLUAjsBTUHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILKRsIiWrsKQzR68dLhgMyytZaIkgNiQrYpLY2bcTLI=;
 b=RtorC1FtqqnFSP34UXhkX2fS1miV1esErkrCMXTMI8AMP/N01flgWpyQlmWEJh1GuApl5dtHjNfT6BoXGeOFz4uIhwMO9ZiViameGvjl1Op7N+98vaTwha4LKFsIEfIFEELE2JoY0TS22p1QQZLdrNbTzmUAfUppn8vfOtm5w5xAoC2lS31sjs4pVfvbmd9/pWzm7sRYhuGbqeUGT2kaRuJNnTR2pSN6mIEIu3xmHnY9v4WhyPiLkSr5HkEzXbUOcd4XqP6VnP7pVeY5XpfXl2PDBUlSvfPaMZjZm6MO14e0s+TVMiFhxUrxU/TXkjln5Rzngn/a67s3kJC7GwtrIw==
Received: from PH8PR11MB6609.namprd11.prod.outlook.com (2603:10b6:510:1cc::16)
 by CH3PR11MB7915.namprd11.prod.outlook.com (2603:10b6:610:12f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 08:29:32 +0000
Received: from PH8PR11MB6609.namprd11.prod.outlook.com
 ([fe80::ebc1:5d63:a07c:60d]) by PH8PR11MB6609.namprd11.prod.outlook.com
 ([fe80::ebc1:5d63:a07c:60d%3]) with mapi id 15.20.8534.040; Thu, 27 Mar 2025
 08:29:32 +0000
From: <Manikandan.M@microchip.com>
To: <eugen.hristev@linaro.org>
CC: <lukma@denx.de>, <seanga2@gmail.com>, <sjg@chromium.org>,
 <mkorpershoek@baylibre.com>, <nathan.morrison@timesys.com>,
 <ilias.apalodimas@linaro.org>, <greg.malysa@timesys.com>,
 <caleb.connolly@linaro.org>, <Oliver.Gaskell@analog.com>,
 <robert.marko@sartura.hr>, <igor.opaniuk@gmail.com>,
 <semen.protsenko@linaro.org>, <william.zhang@broadcom.com>,
 <Nicolas.Ferre@microchip.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 6/8] ARM: dts: at91: sam9x75_curiosity: add tweaks for
 sam9x75 curiosity board
Thread-Topic: [PATCH v5 6/8] ARM: dts: at91: sam9x75_curiosity: add tweaks for
 sam9x75 curiosity board
Thread-Index: AQHbnubhVHXO3FlbREWefg4UNmO5MbOGmZeAgAANUwA=
Date: Thu, 27 Mar 2025 08:29:32 +0000
Message-ID: <bf464589-9060-445c-807d-89b00366ee3f@microchip.com>
References: <20250327070615.334551-1-manikandan.m@microchip.com>
 <20250327070615.334551-7-manikandan.m@microchip.com>
 <90b45c65-d4e9-4822-93ba-7fe69acb1d8c@linaro.org>
In-Reply-To: <90b45c65-d4e9-4822-93ba-7fe69acb1d8c@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6609:EE_|CH3PR11MB7915:EE_
x-ms-office365-filtering-correlation-id: ee283c92-552f-4431-15d4-08dd6d097fce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Y3QvYzk5VlFIbUREdmxtN25HMHFMU3VLN1JabnBacnNLUlhkUjg3cGRseXdk?=
 =?utf-8?B?OHVKd2p5VjFmL1Vma2NLNzZhSnlEbmlNTWdhVUo4TnZpNkMyeGZQSUNSbXNr?=
 =?utf-8?B?ZENFUlBjRkVFVGxTODNydTFGWXRNMS9ET1JLUDIxN0luMStoenIyK3VOTnJx?=
 =?utf-8?B?eHp1YmoxUy84VFZRUGVWSmxOTER5ekFrc0ljWU5JT2lVQy9GZUE4VHlSTnVu?=
 =?utf-8?B?YXVZblFKNW5pSEpZQTAyMmpmcG9tbHNIbm10L216SVRvME5rUGMvY3JkWTAx?=
 =?utf-8?B?a2NFbUdwUWdRV2xiTGNINXJmOHhCNEoyWWJEWnFQYzBKc1RGenV6ajRqNVVI?=
 =?utf-8?B?WjdHWnhXeDN5aVo4TE84b1hDRkRGUUVqTzNiQ0p0bkNOY1k5dWpyMGxWR2hP?=
 =?utf-8?B?Vnp0OG5FdW1GSWdVekRTckJKZ2UydmJQOUJ2U3ZVSXdCUjhOeENMdHVyR1Nk?=
 =?utf-8?B?L3gyMWljNGE0RlhQaWVVcnppL04yOGVYMm9YcWFybmsxWmRLbFR5N0pIRnZz?=
 =?utf-8?B?VGo5eExRZ0RQV2tVMUQ2Z3cvUDB1MGxiZTJpY0FIT3JjVGdvdWhxVnhXRnVZ?=
 =?utf-8?B?UE40ZTJSQjJyY2czT1dCQS9nKzhmTTU2cEllSWJFeklpY0FYQmowMFErZmhC?=
 =?utf-8?B?UmxZNkZXdG8zdE9PZzNHcVNTcmdNTWd4VnpCaHB0RUdtTktEOHFaWWptWjdP?=
 =?utf-8?B?aFpFckN4TzB4ZURoRnFvWGVubFdhOU44MmdrYjR0OEFLSFlVb0lPaHJITmg2?=
 =?utf-8?B?a2JLSmN6V2lNbzhPTlc5Y2xTcmlaVDRwOTE3UGoxSlVybi9PekxrWmZ3eExL?=
 =?utf-8?B?QkNPa1k2RUxpVldvU0FucjlvY0lpYTd1YVdEL1o0VnFzcDdocnJrckx4UVF2?=
 =?utf-8?B?Y3ROajJKZEpyemVVM05OMm5WL1YrZi9NZGY3L2VXdVNudjJvN29zL2dJTDU3?=
 =?utf-8?B?V3V5S1UxU05zUWJxODNDUEd5OGt6MWpQNmR6YnQyaW1aejdOTk1hNGN0YmpG?=
 =?utf-8?B?UDhUb3RYUjdOcjdzZVBrczZFUkV5SFI5OVBGRVFJQmoyY1hwcWJEM0p1eW5J?=
 =?utf-8?B?aFR4cDFVd2xwdXFjSHNhRExoVUROLy9qUmNJUWVIM2s3bktUeE5GU3JXWEVm?=
 =?utf-8?B?emsrelFRcFVDRWRJdG1uM2Q0Q0NxWC9ieG56NFdHZFFiOVpGZTU1VEhOWFhU?=
 =?utf-8?B?Nkk2ZU9EaUc1VUt0TDdUcUNmNFNub2w5QUU3Z0hIYXlrNlBnSCtaeDdhZkxB?=
 =?utf-8?B?N1loWnRmc3VOSXdFc1B2L2hGQXpuVWFla2dLMEYwTG9TU3lSS01tZTFVcEpQ?=
 =?utf-8?B?elBkTENNRHBmR3ZGT2Z6NW5oVHNObzRNSDFVSlptQ0VxNkZLbVhZM2NuM21t?=
 =?utf-8?B?bEo5djhWTnJYSEZyR25ydE1BTDVDL0Y2eXl2cDhpdXJla2Z1YkRYTDFkVFJm?=
 =?utf-8?B?UzhGVWRqelBzOXp4YzcvcW5tbUZXTEh0ekJZZXA0LzhjQ2o4MXoxSStGcC9J?=
 =?utf-8?B?TlVzNDI4bEFvRWlmdyt6YWI0ZmQxZzlGS2I0M0NieUpqQnF3bGhZNWdiSlp4?=
 =?utf-8?B?MUlXYjd6TXhWOElaZk01SUxhOWUyL01lR2RnSEU2c1RISWFEQlRjckpvUUxi?=
 =?utf-8?B?WC9kYjN1d0hxS0NHRXRlSVQ5Mkd0Yk1HOVhhNGFhdDVmcXFBN0dIeWUvd0RU?=
 =?utf-8?B?czZ4QkE3SkpuT2MxbGpTUjc4OEdKM2lYamd0YmxsOEkxb2xkRXh4dFU2eVg4?=
 =?utf-8?B?NVFsNFJDZUJIWDlFM0R4YWZGUUIvcmZSM2ROVDl2ZVNzNGFNWUZwQ2FhM04r?=
 =?utf-8?B?ZVRNMWIvRVgyd3RLUi9IY1htTGhpWEdlbkdRczl5QjZCbkxTVDV6ek95LzVW?=
 =?utf-8?B?UlVFZWxEU3hxT01EbFIwcU1xVDlod0VXNis3TXJqMm5FSlNYMU1lUkRia0Ir?=
 =?utf-8?Q?JiznMKipvBjWh8DziEpIALSb/WIlAN7k?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6609.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXJaVkZ6N2dHdXhqYkFEUm1UMU9kTVdodzIycFkyV0k1dlViVjJZVXk5OW84?=
 =?utf-8?B?UVgzQm9icUFIdGFtUUU5WmFwT0lZMlh3QnNPRm9aRURKVUc4K3lmNExiSWlC?=
 =?utf-8?B?blQ2S2xjdFkrZ0RiYmdlMUpFTGlDMEE2eHNpNVJ2Z2hNMnVQOEl5Wm1Wb2hz?=
 =?utf-8?B?WktwaFhXVGt6a2V3Y3dWQ3RkNGs5Vm9nenI0bTgzeHVXQ1ZaMjZmNkd2NklZ?=
 =?utf-8?B?T0NBcGhsWGYydjEzcXF1TUgvVUloeXExZllLSlZseG9PTjliVzBWL2VJWWUw?=
 =?utf-8?B?RDE4bTNIbjBXK0RSZmVEdXBPcC9VZ2lwRnN0Zy9JSEVoTVZJaHFLemU1RHNy?=
 =?utf-8?B?YndKQUt2aitDNUdUUW1hZktvRjZZeWZpaFU5RXZXa3VVNFROQ0czWWovZG53?=
 =?utf-8?B?M1BHenloeUF1OEVYV1RIVE9oSGoyYnQ4eVBKdWtpMUdyTHU3ZS9kMm5uTEQv?=
 =?utf-8?B?VnBETG44eGdJSGc2S21FbFoxSVcxcTd2bFNweDlWakZHOWtRcjZnMWZZMHUy?=
 =?utf-8?B?cGJzLyt6Q0FPWUpjMUZUTW5vQ1E5VnlUQ3JsYVJsS2tIV29KbDAwNVpFaWxs?=
 =?utf-8?B?d0ErSTE2eTlJMSt2V0xpNE1RYUl4ajMyS0oyZHpYQjVpclJJdVlGSlZ4VWQw?=
 =?utf-8?B?VmNTUmU1MVBYSXVYZXRsYW82VUpvazgrMVI1NlFlY05MaE9Ed0FmZDJ2bFMr?=
 =?utf-8?B?cTVhM2lTTVRjL09CZmJaZlVka1BmQVZCeVZSOVV0MVQydHI1VDhiUHZwYkpZ?=
 =?utf-8?B?aHk3dDdsOFEra1p3by9hUm5WVEcyT2hkRzdPeDkrb0FxdHRuMUEwZTZITzkv?=
 =?utf-8?B?ejE5NndjZ01mekdxb2YxV3JXVGxlM3ZlQ201Tlo1TkF3aTZsZ29QczlvQ2g2?=
 =?utf-8?B?TTVKK1l5Nk5KVlJ4UzhncUdFRVRqTSsrUXFIbFlaWEFNSUtmaklUU1oyZ1dr?=
 =?utf-8?B?UzlpbjVxN3FkUGRFWUI4MXF1RHFzQ0t3dERvQVM3OU9GT1lTYlpEeUZlZVpk?=
 =?utf-8?B?OHhoL0dSUU14RTBpckVobUNnV0E0ajNLSldCT3VkM2RJYzRUQnNnUWJJSUhk?=
 =?utf-8?B?eVJSWks2bVZtRW1FR295TVNGYUlrQi9zVWRISGU2YU5PYklZNDhBcytLKzQy?=
 =?utf-8?B?THc3cmZSVUVPZlpIQm5xVjlIZm5QdjN3Nmh1RXdrdmZuYkxHVDV4V3F4YnZJ?=
 =?utf-8?B?cGsyRy9VOWd5UnRWWXh2VDBraDMvTWpUSmlSd2w4Rm9Kamt1S0o5aGlPTFNS?=
 =?utf-8?B?bCtHblA2VVBHM3lzWHdtRlRrQlhQYjliRFQvdUVSRUZnNllQank1K3JOMDJ4?=
 =?utf-8?B?MVpNVk5EUldpRDhMSmlTcTRTeTJtZDBDQnl6bFJrTzJOVlFkTHN1OGVyZHRD?=
 =?utf-8?B?b0dWWXViRzJxb0EwSGdnVGs3UlFNak4razBaN0owM0haNCtmVVllNVIrOGl5?=
 =?utf-8?B?S1JyU2UvM2FxNFh4OUhLUWJZQlA1SWpSV2xCZFpUazZXS2NaQU9NbFpJeGU3?=
 =?utf-8?B?YjBGbHpPQzNNc0VjcndXSlk2VFpXVUU1Ylp2N3lWQktjNkJHdHBlVVExbW1M?=
 =?utf-8?B?OTl2Qkw4dHdJcjdYMHQxbHBtcXpOVVoyTG54Z1ZxekU2eHZoYThIQ2RDNmJu?=
 =?utf-8?B?RmVOcVZaU3RyQjRkanpRL0ptQXJDQ0lJOGtya0RCZDRDdnU4a09yYkFIT2tl?=
 =?utf-8?B?Y3RXc2xiVGh6Ym9jNTlEMEFiOTZubXk3TkRxa3NqUDRpbDh4bFJ0SDJ2aUlo?=
 =?utf-8?B?K1ZQbzVwbjBLR2pHQXpJdk4rdkhNVmdPdDAzc0l0bm9hTHE2cGVxNFhnTEV0?=
 =?utf-8?B?Wjl1Z0NLODlNdk5IWENZaExOY1F5eW1kb2tENzZwcWtJSU9MNGN4NEdNQjZm?=
 =?utf-8?B?UG5JNGJBUFFjN1pjSEdiSUh1eDRxL3krUDJ4RGRXRTdIdWI1bVdNKzFhL2NB?=
 =?utf-8?B?all0d09LZFVGNlR0bkdNKzJLMkhvNW9rUEJrWmg5THJ0ZGw1VkhsSUkrdUpk?=
 =?utf-8?B?czdoNlNnVFhjbUtndGhWVDQwQmxaTEpmbVZWZVB6d3crVlpkYUc3eituOVJw?=
 =?utf-8?B?QWY3d25QcjVzbTBKa2N2NXEweHJNOHJyRk9ZZlY2Z1hzbHM1R040R0JpZFlO?=
 =?utf-8?Q?97KsW3XO/R2TLMITSAtuGawyW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CEF73C705D54A49B7C020570458F7E7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6609.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee283c92-552f-4431-15d4-08dd6d097fce
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 08:29:32.2524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ij72WJdB5NLU2E1x2FviahcjV0MxPfRljkHO/v8d7C1F20XfuAaGTQWYOflmN9zxJ1lqgjz2PD+opepRLKxacmIdlPAouoYMLzvMBKNa0jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7915
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

T24gMjcvMDMvMjUgMToxMSBwbSwgRXVnZW4gSHJpc3RldiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAzLzI3LzI1IDA5OjA2LCBNYW5pa2FuZGFu
IE11cmFsaWRoYXJhbiB3cm90ZToNCj4+IFNpbmNlIHRoZSBTb0MgYW5kIGJvYXJkIERUIGFyZSBh
bHJlYWR5IGF2YWlsYWJsZSBpbiBkdHMvdXBzdHJlYW0sDQo+PiBhZGQgdGhlIGRpZmZlcmVuY2Ug
ZnJvbSB1cHN0cmVhbSBEVFMgdG8gYXQ5MS1zYW05eDc1X2N1cmlvc2l0eS11LWJvb3QuZHRzaQ0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IE1hbmlrYW5kYW4gTXVyYWxpZGhhcmFuIDxtYW5pa2FuZGFu
Lm1AbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICAuLi4vZHRzL2F0OTEtc2FtOXg3NV9jdXJp
b3NpdHktdS1ib290LmR0c2kgICAgfCAxMDUgKysrKysrKysrKysrKysrKysrDQo+PiAgIDEgZmls
ZSBjaGFuZ2VkLCAxMDUgaW5zZXJ0aW9ucygrKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJj
aC9hcm0vZHRzL2F0OTEtc2FtOXg3NV9jdXJpb3NpdHktdS1ib290LmR0c2kNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm0vZHRzL2F0OTEtc2FtOXg3NV9jdXJpb3NpdHktdS1ib290LmR0c2kg
Yi9hcmNoL2FybS9kdHMvYXQ5MS1zYW05eDc1X2N1cmlvc2l0eS11LWJvb3QuZHRzaQ0KPj4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwLi5lMjVlMzczNGViMQ0KPj4g
LS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvYXJjaC9hcm0vZHRzL2F0OTEtc2FtOXg3NV9jdXJpb3Np
dHktdS1ib290LmR0c2kNCj4+IEBAIC0wLDAgKzEsMTA1IEBADQo+PiArLy8gU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IChHUEwtMi4wKyBPUiBNSVQpDQo+PiArLyoNCj4+ICsgKiBhdDkxLXNhbTl4
NzVfY3VyaW9zaXR5LXUtYm9vdC5kdHNpIC0gRGV2aWNlIFRyZWUgZmlsZSBmb3IgU0FNOVg3NQ0K
Pj4gKyAqIENVUklPU0lUWSBib2FyZC4NCj4+ICsgKg0KPj4gKyAqIENvcHlyaWdodCAoQykgMjAy
NSBNaWNyb2NoaXAgVGVjaG5vbG9neSBJbmMuIGFuZCBpdHMgc3Vic2lkaWFyaWVzDQo+PiArICoN
Cj4+ICsgKiBBdXRob3I6IE1hbmlrYW5kYW4gTXVyYWxpZGhhcmFuIDxtYW5pa2FuZGFuLm1AbWlj
cm9jaGlwLmNvbT4NCj4+ICsgKi8NCj4+ICsNCj4+ICsvIHsNCj4+ICsgICAgIGNwdXMgew0KPj4g
KyAgICAgICAgICAgICBjcHVAMCB7DQo+PiArICAgICAgICAgICAgICAgICAgICAgY2xvY2tzID0g
PCZwbWMgUE1DX1RZUEVfQ09SRSAyNT4sIDwmcG1jIFBNQ19UWVBFX0NPUkUgMTc+LCA8Jm1haW5f
eHRhbD47DQo+PiArICAgICAgICAgICAgICAgICAgICAgY2xvY2stbmFtZXMgPSAiY3B1IiwgIm1h
c3RlciIsICJ4dGFsIjsNCj4+ICsgICAgICAgICAgICAgfTsNCj4+ICsgICAgIH07DQo+PiArDQo+
PiArICAgICBjbG9ja3Mgew0KPj4gKyAgICAgICAgICAgICBzbG93X3JjX29zYzogc2xvd19yY19v
c2Mgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2si
Ow0KPj4gKyAgICAgICAgICAgICAgICAgICAgICNjbG9jay1jZWxscyA9IDwwPjsNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICBjbG9jay1mcmVxdWVuY3kgPSA8MTg1MDA+Ow0KPj4gKyAgICAgICAg
ICAgICB9Ow0KPj4gKw0KPj4gKyAgICAgICAgICAgICBtYWluX3JjOiBtYWluX3JjIHsNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImZpeGVkLWNsb2NrIjsNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAjY2xvY2stY2VsbHMgPSA8MD47DQo+PiArICAgICAgICAgICAgICAg
ICAgICAgY2xvY2stZnJlcXVlbmN5ID0gPDEyMDAwMDAwPjsNCj4+ICsgICAgICAgICAgICAgfTsN
Cj4gDQo+IFdoYXQgaXMgdGhlIHB1cnBvc2Ugb2YgbWFpbl9yYyA/DQo+IElmIHlvdSByZXdvcmtl
ZCB0aGUgcG1jIGRyaXZlciBhbmQgbm93IGl0J3Mgbm8gbG9uZ2VyIHJlcXVpcmVkLCBwbGVhc2UN
Cj4gcmVtb3ZlIGl0Lg0KPiANClNvcnJ5IG15IGJhZC4gSSBtaXNzZWQgaXQsIEkgd2lsbCBzZW5k
IGFub3RoZXIgdmVyc2lvbiBmb3IgaXQuDQo+PiArICAgICB9Ow0KPj4gKw0KPj4gKyAgICAgYWhi
IHsNCj4+ICsgICAgICAgICAgICAgYm9vdHBoLWFsbDsNCj4+ICsNCj4+ICsgICAgICAgICAgICAg
YXBiIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBib290cGgtYWxsOw0KPj4gKw0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgIHBpbmN0cmwgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYm9vdHBoLWFsbDsNCj4+ICsgICAgICAgICAgICAgICAgICAgICB9Ow0KPj4gKyAgICAg
ICAgICAgICB9Ow0KPj4gKyAgICAgfTsNCj4+ICsNCj4+ICsgICAgIGNob3NlbiB7DQo+PiArICAg
ICAgICAgICAgIGJvb3RwaC1hbGw7DQo+PiArICAgICB9Ow0KPj4gK307DQo+PiArDQo+PiArJmNs
azMyayB7DQo+PiArICAgICBib290cGgtYWxsOw0KPj4gKyAgICAgY2xvY2tzID0gPCZzbG93X3Jj
X29zYz4sIDwmc2xvd194dGFsPjsNCj4+ICt9Ow0KPj4gKw0KPj4gKyZkYmd1IHsNCj4+ICsgICAg
IGJvb3RwaC1hbGw7DQo+PiArfTsNCj4+ICsNCj4+ICsmZ21hYyB7DQo+PiArICAgICBjb21wYXRp
YmxlID0gIm1pY3JvY2hpcCxzYW05eDctZ2VtIiwgImNkbnMsc2FtYTdnNS1nZW0iOw0KPj4gK307
DQo+PiArDQo+PiArJm1haW5fcmMgew0KPj4gKyAgICAgYm9vdHBoLWFsbDsNCj4+ICt9Ow0KPj4g
Kw0KPj4gKyZtYWluX3h0YWwgew0KPj4gKyAgICAgYm9vdHBoLWFsbDsNCj4+ICt9Ow0KPj4gKw0K
Pj4gKyZwaW5jdHJsX2RiZ3VfZGVmYXVsdCB7DQo+PiArICAgICBib290cGgtYWxsOw0KPj4gK307
DQo+PiArDQo+PiArJnBpbmN0cmxfc2RtbWMwX2RlZmF1bHQgew0KPj4gKyAgICAgYm9vdHBoLWFs
bDsNCj4+ICt9Ow0KPj4gKw0KPj4gKyZwaW9BIHsNCj4+ICsgICAgIGJvb3RwaC1hbGw7DQo+PiAr
fTsNCj4+ICsNCj4+ICsmcGlvQiB7DQo+PiArICAgICBib290cGgtYWxsOw0KPj4gK307DQo+PiAr
DQo+PiArJnBpdDY0YjAgew0KPj4gKyAgICAgYm9vdHBoLWFsbDsNCj4+ICt9Ow0KPj4gKw0KPj4g
KyZwbWMgew0KPj4gKyAgICAgYm9vdHBoLWFsbDsNCj4+ICt9Ow0KPj4gKw0KPj4gKyZzZG1tYzAg
ew0KPj4gKyAgICAgYm9vdHBoLWFsbDsNCj4+ICt9Ow0KPj4gKw0KPj4gKyZzbG93X3h0YWwgew0K
Pj4gKyAgICAgYm9vdHBoLWFsbDsNCj4+ICt9Ow0KPj4gKw0KPj4gKyZzbG93X3JjX29zYyB7DQo+
PiArICAgICBib290cGgtYWxsOw0KPj4gK307DQo+IA0KDQotLSANClRoYW5rcyBhbmQgUmVnYXJk
cywNCk1hbmlrYW5kYW4gTS4NCg0K
