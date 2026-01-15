Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05326D46602
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 17:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C26E83885;
	Thu, 15 Jan 2026 18:01:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="AehPL7jQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 549BE83015; Thu, 15 Jan 2026 17:59:28 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED17F80077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 17:59:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jamie.Gibbons@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnHzlMI8bbdfj2zfCo6EVpZQApWeqr5UHJkVWZhWi+aUm+E55Zla24R096Yi7aKd0lenQv2UysOeR7ZSeH+qzuz/9fZeENZjvUKOMB87juXq5afwa90vvCTD9+EPgIri+heRxeqYQltxjAjOb1XhNa2fsXKKa7y8eDehFMS2Mfjg36M6mOHG32m1cK4tnkmlTM+i4BTOl9hGOQIZEWXxmWwnyyjdqRVceDGs1vS4TRi4qpLltfLQ4ecxI1Y9Z3LcJPTbcOYfFN5DY9gLv93RHmhKk9sWycVjc7l+LJcc5eL5QdbF/yLbZixrfp9Xi4Y1dydzvl+dcef7KjIeasFLgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqkLtKWpYyxf2AY96470o+bP+0Q2JQxNAYUWSa2Bk0E=;
 b=dk0tjg94bTjWk5dglecyNRNUohK4BfKjdOI2MWPqzvgyNCM5ieHwx/tlqzYnfzilCoebxv4hKlSqVHygXAV21r/RAmCGM9Bj3kXc+iBreoBAagtRYRU9OYeA0Qvq9u8ItHgxcWHo8dWilzylkCcQaYhppAhLtkqz+SkDQuBQVUPE+o4IEEWrJjggQiRbRK7A57sSTIcEsZ/U3rry3enfB8UUYX8qRpA+xWfc56P2V6P5pDlYFNUN0IZQ9v2VTGzogMDaPueU6XcdESCiJZyXNG43LNCTFQVIjR1mPwtuXWFOO9c4n0kvSFxXFFa9qVT5rPIoLcuIldu+/tM7gvYDFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqkLtKWpYyxf2AY96470o+bP+0Q2JQxNAYUWSa2Bk0E=;
 b=AehPL7jQHZ2oyvwv8132D91X5c1mDrPPnonY0EiLJ68HENIfozR1ogN709M0hm4cXLm+c3OmEPkBrc/aNkneG5E4mDqRlbXDvhuJUkfG7ppaadVCU3uWdKWeJWRe48/wid5xEO3zdBfr20nV7EEo8RzAMKcHmDzWjsnuloaQX+xKU4YfQxmKsYVRdF8rtId4TSxOWc9BQ/2ItDnjl+OsTrekz7616FKwY3mtZBqRfmsJ+s2cUYczHQjRJnCb082hmsNy32yZnLjXGIs+2c2qQ1nt6MTnDLsyi5CJhYz625FxYfgQ3P6Y72Lm+8NR7JSKwzzXA+bCM1kHufirbBs6GA==
Received: from DM4PR11MB6335.namprd11.prod.outlook.com (2603:10b6:8:b7::10) by
 DS4PPF8ECAFAD61.namprd11.prod.outlook.com (2603:10b6:f:fc02::3a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.12; Thu, 15 Jan
 2026 16:59:20 +0000
Received: from DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::3adb:8c97:94da:80]) by DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::3adb:8c97:94da:80%3]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 16:59:19 +0000
From: <Jamie.Gibbons@microchip.com>
To: <trini@konsulko.com>
CC: <andrew.goodbody@linaro.org>, <u-boot@lists.denx.de>,
 <michael@amarulasolutions.com>, <Conor.Dooley@microchip.com>,
 <Valentina.FernandezAlanis@microchip.com>, <fberder@outlook.fr>
Subject: Re: [PATCH v2 2/2] dm: core: Default to using DEVRES outside of xPL
Thread-Topic: [PATCH v2 2/2] dm: core: Default to using DEVRES outside of xPL
Thread-Index: AQHchWGRWanG+SXlbE+k2PlHaUCZCLVRupuAgAAHLQCAAaguAIAAC9iA
Date: Thu, 15 Jan 2026 16:59:19 +0000
Message-ID: <8b4d8980c4c16a2d0f6e1b566f85034047c24fd5.camel@microchip.com>
References: <20251219202121.4180810-1-trini@konsulko.com>
 <20251227223833.3019311-1-trini@konsulko.com>
 <20251227223833.3019311-3-trini@konsulko.com>
 <ef5c3866fa673dd814264f1a26f73c5a9fb75b6b.camel@microchip.com>
 <20260114145842.GD3416603@bill-the-cat>
 <9fd13735b55dac213d23dc13309f0c3199be481e.camel@microchip.com>
In-Reply-To: <9fd13735b55dac213d23dc13309f0c3199be481e.camel@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6335:EE_|DS4PPF8ECAFAD61:EE_
x-ms-office365-filtering-correlation-id: 256454fa-d7c6-4775-0886-08de54576ce3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?T284bjlUWHdYNktKMHliWnB2MkVibkJBUWZodFFXcS9LV0NMejJBcEh4WHQ3?=
 =?utf-8?B?bi9IM1k3ckpSeUVaNDRFbC82WGZhVWZ5dzluUE5YVnE2TG5RQlRNNUpNbWI4?=
 =?utf-8?B?bnF3VHRYN1JhRVNBdjRIWWN3NWhaY2dGREhwM1ZpbWZJS1ZTRzJ6b3BFc2lK?=
 =?utf-8?B?R3hXUzdGaHE2bjQxYlc2M3grMzM3UlBXQmFMc0lxRTcxUXlJR0xvNzBtR1ZX?=
 =?utf-8?B?Szg0cUVCMURxcXVscWNqOE8vblBpNkNOU1h2NkZuMVU2VmxtNmRwL2t2azU0?=
 =?utf-8?B?dFRCaU9mc2JsSDZZTUs5T3o1dmRoM2RwL2tGNURobWNUQncraHRhKzEzL3hZ?=
 =?utf-8?B?eFlmL2x4NnZhZFBSR2I4UXNDVTB3a2hxZi9zeXNQdTZSN0pVclg3SEdOVEg4?=
 =?utf-8?B?bUpNVjZDTXdWWFNPaXdjTFlmSEhNeGdqNm9pWDZEK1RuZ3FmbkczSEVZRUZa?=
 =?utf-8?B?ajdmemZJRUhUM25yUVVEcW42TExxdnNpTHVOanRpTjgycnMrM1NRWmMxVlha?=
 =?utf-8?B?SkVqUTV1cU1qbW0yNFkvanNFdVBtMjhTMFdDek1RYklOazhYRm5qSXhLLy90?=
 =?utf-8?B?dm1lMy9VS3BQR2xSNGVuSFd2b1FNR3J3YksvWXFPeXpWQitsSlVOaXlGNXdM?=
 =?utf-8?B?VndIcWthRHdSWTMxcVZhSHlzd05GczB3ZUE3ZE9PUDZWa1daYlJ0QmtSTXZI?=
 =?utf-8?B?Vi9tcEtPWk53Rml3YnhxbzI3b3h4ZXdRVnlHekNqb2l0bXNZMC9DYVFVdHlv?=
 =?utf-8?B?RWdNZzhSaC9nd3htUDdSQnZ6RHJJNmNEWlo3eDBXNnczZ1pGejVFWmM4RlFG?=
 =?utf-8?B?UVpuOUNYRFBiOThweEt1WDNudkwvSi9xMCtlVWhUNHNVb1dxWmFvNnFzRHR2?=
 =?utf-8?B?WHJuTVpmc3V2Z0xhV1dtUWdDS3llQThoanJWV09FUlB6cDNHZUJVU2tPV1M1?=
 =?utf-8?B?dTF1WU12RXVwYi82c29YbzBZYnJ4Vi90dFowSVlhaE8wSjNMU3dMQzdJellp?=
 =?utf-8?B?R2lpM1FQV0pvU2Q3aUtTb1lOMFlZRGN2YVJ0Vm9aUDBHbzhSVE13UitmNmFw?=
 =?utf-8?B?QW5DTThBYWFmOGxZNFg4U3huWE1MQlg5L0dqbkdHRXBQVTVWZmhZb3M5R21j?=
 =?utf-8?B?MUtxNVVITWtvRlFObFZVTzIvZ29lRHdIYVE3TnlOWjl4MEhuYkFqMVRrQmZx?=
 =?utf-8?B?VUtGemdUby9rOVhqTml5N2tBclBIdTY4b2NiVGVIR1BKN1c3OWhnY1I5T1VE?=
 =?utf-8?B?TUVLMEhrUU45N2hqNHNYTlhWWkVYSnlVRW1BOC8zT0dQRlVPZWhPZXNHQThB?=
 =?utf-8?B?OS8wRDNCQlQ1ZmxXNy9EL3ZIKzE5aE1rWU94eENtOHJCYTJqT3ZKT0VvL1NH?=
 =?utf-8?B?em9CbUlKZ1VuWDROOWJtWmVKK2VaZWNMdCtQNk84UjBBeUtrZmdjUjZySlNk?=
 =?utf-8?B?OXhYanU1TjVxeGRRR1B1TDk2QmhEMzVkNVVUYlczcmgvaHBGSWdnMThsc0Nr?=
 =?utf-8?B?dWZXckxnamgzS1g1S01nNnNqaTlBSGhQbGNVNmtwRm82Y044cFJPeWU1RGVW?=
 =?utf-8?B?WENvajJJRkl4eENWU05CZ3RGUGp2L00zSExQMFNFaFRLbjZtdjFFSFpEQlVp?=
 =?utf-8?B?NnpuSUJFc2wzbjdMVlVac0ZyMGoyVUVKTGxGeTNEdmU0allteDVDakhYM3Na?=
 =?utf-8?B?R1FTczBQc1RUWmljYWhyNkVCK0RoUWE1VjFJcitpd3AzNHlEVklwVmZSYytG?=
 =?utf-8?B?RG02QXFtc2tHaDZUSmhSMVo5OWQ2cWtFT3BidWZQc2o4UkRYRVhJN3p0TXZ1?=
 =?utf-8?B?dFllcmlGc0UvNjRtMGlLRmlUYXhJMGo5WU5ncG00SjlOZFFKeWJQa3FqN0Fn?=
 =?utf-8?B?elV4RjFTekRuektxZkk5YmljZXJUQWJnZGVxV3pLYVE0Qjd1YldrcVYwMzZ6?=
 =?utf-8?B?UkN4a0w3QklKdDl6UU5mRjNIUDFRTkt2Zyt5Y0dCdUFIUzN0dFE1LzJOQTFu?=
 =?utf-8?B?WUw3VFFZdUptdlpycHF6aVNMYWJsUG8xYjZFK0VTK2x4UGtnZ2xESnJKTkZz?=
 =?utf-8?B?bFZmZFJrRXdwY2dvZTNzNTY4MmNSa3Zna3ZVSUhRQW5zV3YzWEdWd1BoMlln?=
 =?utf-8?B?WEtSUytnT2xvY05PRlp0RXk1bnVkTm9ySnI1eDlkaUY2ZksrUWhSZzVtRlpS?=
 =?utf-8?Q?YFN8MCakqVGOK1REl5NFp50=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6335.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlozS1hEbzdOV2I2VE5wS215SXB0Y096S0Z6blltQlB3WFVuWFpCYWJacC9o?=
 =?utf-8?B?UG9DWkQvbWtiQTFVZEl2bXUvYlQvNkVYaTB1dzFzZkpxT2RqbFBBLzFsa0dT?=
 =?utf-8?B?R0xDbmF2di9xVXRseStZcHNaV05Wcmpqd1pOZWVNVEYzRHV2ck5Xdjl6TjE4?=
 =?utf-8?B?aFNCYUV4eFhRMDJuNk5IY3lGeGdVNmtuUFB3R0NhUlgvZFVlbkZsVENZQ0pJ?=
 =?utf-8?B?R3JRRU5KU0t2UzZwa1QzOC9lM1h3KzhLOXozR0FGdFFaT3NPSlpHM2I1Mm1u?=
 =?utf-8?B?dlFWUWF0WHkxYTBka01vK0dlZmJBTWNLK1VoZ0JrYWhaT3RWSWlOTThoRjNR?=
 =?utf-8?B?L1liRGdVSTQyMDhReHZZWndTNWNEaHNVT2JKMWovTmROTkxRdmxUMjhzYXNu?=
 =?utf-8?B?cDV2d2dBRHc3REFVOHNEaXpzSnU3ODFNcld6Uy8rbkVrTWVzT1hpWCtMSTVF?=
 =?utf-8?B?NGN1UWhiSjRKc2JUNEFKakpBQmRhMUJuRy9QcFlQYm4zTDJpZ1BodURZeVFV?=
 =?utf-8?B?UUx2V1FkMTFSRmhUQ0NjaHFmUXFnWExDb3hBMG9TUXFUS0F5U2RSakZnZGNH?=
 =?utf-8?B?SUpWRlJpMjM4Sk5VVUtuNW02cEJqdUhOclFuT2xPUkpwR0xxb1A4aDh2VWpl?=
 =?utf-8?B?WjlEYnB6VnNRLzFIejRSQXg3VFpUdDRueUZiclVYMUdTUGlqb1l6TC9aMEZF?=
 =?utf-8?B?bDJGNHdQbGR4RGFvM3NpUnBjSHJqTG92K2NjbGV2Z0VjMGdYaDM4NEpDSUll?=
 =?utf-8?B?dmNtcTQ4OUJPd0JzbzlNZ3lJS2l1V3FReXU0NW91Y1BCaVlTNndKaGhTYkhz?=
 =?utf-8?B?V1VDaWR0OFNuUHZGNjh0d0ZKOFpFWkI1ZFRmckdNTjg2L0grRkxhTG5tTHBu?=
 =?utf-8?B?YkNyQ2cwOEJQMFA3ZHJubVBVc2J5RkppOWhvdWJwcWJyZmkzRGlEcEFnNTlr?=
 =?utf-8?B?QmJzV204K09SNUcrbHBSUmJCUHNaWUV6Qmk3T3dET2RVcUpFRStkT0dwSDUw?=
 =?utf-8?B?M3NTSTZURU1FeGtoaHpJVFVVNlhsaXM0YkhoWENJNldsRmhJOTNBU2hlUmlZ?=
 =?utf-8?B?dUdvWEpSbWt6WmxYT1R4RldibE1VRXVLUWg3cm1iZFV1RHhqZVVQaDlQZGJ4?=
 =?utf-8?B?d05jNUtQakJjV3Y4elgwOFAwL290NDJWQklrZWNqRkgyblM2WllTTW11MjdX?=
 =?utf-8?B?VjNwdy9ZVjJxK014cXNWdXdabFN2SEV4Qk5hSHFhZjlWM0puc0plS2Y5M0FL?=
 =?utf-8?B?YkJGL2ZqdlRhNWdBcE9vRE9Qc3B0MnZyNmJQbnU5djNQR215UWZVZWRYcWFH?=
 =?utf-8?B?enpjZXBaVCtyaGZ4RXVwZ2owRU9VYlBqMmdiVURXWmJ2eVVLRjl2QTlTdStL?=
 =?utf-8?B?NElHMWZFcnNzbzMyNkxjaDdsM3NQNWU5TVgwU0IwT29NZUxBdERYcDh4cWlE?=
 =?utf-8?B?di9Dd3l5dGhoMWc2bENGQUcyVTZ4Nm5mSkc1dEhGOVVtVk9KNjBWWTNaTkNT?=
 =?utf-8?B?R0JLcEhRb2ZYL2RSZnZqMFpZckhTUE5KaHJGYUIyY01mOCt4UEpVSEIzZnNk?=
 =?utf-8?B?ZHErUTZPbGN0YW5Majg3Vm1oSzdMWmhBcjlhUTFVV1lsMmMwRWRoR3hQUVBv?=
 =?utf-8?B?VllyTGg0OXZaT0k2TFlOa0x2ek0ySTIrc1lkQml3aElLZmI0UllVTXhqTzdw?=
 =?utf-8?B?a0NDQ1MzMjczeWEvZzBkNVRaT2dRUkx2a01mZVAzVTA0NUdPYm1PdXNsRi9T?=
 =?utf-8?B?QWppZklLZTlmTDBzWjBtbS9qZjUvZS9WMTVEa0ZkYU5KTlBrZTFDdVJuenli?=
 =?utf-8?B?Zys4SSs2L3JZR0pJeks4ckRVUFdRUFFBZldsV2IwVWRJOHVJZTEzNjVBNU1p?=
 =?utf-8?B?YlFYVGxLOEx4MkxvcS9XbkVnVExWOEQzc1dGRjdjQ21oaWJkTjZOVTRNd1Rq?=
 =?utf-8?B?UmZTR0tLUmN0NTMrT215djZldDFnMEZ6aVNldzY0aGovd1MvZExLb3U5QWMr?=
 =?utf-8?B?TWFBS2k0dGl1Vk5KMWFhSHBCWFp0WFNwRVpkb2JQUFFobWNPTWIxN2Rsa3Z4?=
 =?utf-8?B?U3ZzZjIycUtUWGtGaXF2a0N1MFNYRXp2dWRNRUt1alJSaUVFc2pKMTY1eGJx?=
 =?utf-8?B?QUdXNGpVVXE3VllnMFRNVE1UOXpMUHFxTGgvR1lPNjR1UTlwVGRoNEVJYUdz?=
 =?utf-8?B?TDlNWDJJSTYrMmxvTk5vSWJpUGxnNld0cEJDV2hqczlFVXp3TWRkS0x2dytE?=
 =?utf-8?B?Y3NyYkVMOStVS1pIUTZhZGxqTXQ2QStRV291d09lUUFVdFFnMmFxeE9TU2tk?=
 =?utf-8?B?RnJkQWhmV0RiUUJaT2hSalI3L0RKZkQyZit5WW10bUdvVDFDbWt0V1JnS25k?=
 =?utf-8?Q?0nQq/dFX+rUL7de0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B728384E618B724E804AA8D7C926C740@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6335.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256454fa-d7c6-4775-0886-08de54576ce3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 16:59:19.8752 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D1g0D4i6/C8quKvR1Zw7RrB9ZPp5ntbflwgtZI1Y473UVi12XycdQx69jBdY3soRZYDT5xxYcvtgLb9fydiL9CTajTXec2/An6e5SlEySZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF8ECAFAD61
X-Mailman-Approved-At: Thu, 15 Jan 2026 18:01:19 +0100
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

SGkgVG9tLA0KDQpPbiBUaHUsIDIwMjYtMDEtMTUgYXQgMTY6MTYgKzAwMDAsIEphbWllIEdpYmJv
bnMgd3JvdGU6DQo+IEhpIFRvbSwNCj4gDQo+IE9uIFdlZCwgMjAyNi0wMS0xNCBhdCAwODo1OCAt
MDYwMCwgVG9tIFJpbmkgd3JvdGU6DQo+ID4gT24gV2VkLCBKYW4gMTQsIDIwMjYgYXQgMDI6MzM6
MDRQTSArMDAwMCwNCj4gPiBKYW1pZS5HaWJib25zQG1pY3JvY2hpcC5jb23CoHdyb3RlOg0KPiA+
ID4gSGkgYWxsLA0KPiA+ID4gDQo+ID4gPiBPbiBTYXQsIDIwMjUtMTItMjcgYXQgMTY6MzcgLTA2
MDAsIFRvbSBSaW5pIHdyb3RlOg0KPiA+ID4gPiBUaGUgZGV2bSBhbGxvYyBmdW5jdGlvbnMgdGhh
dCB3ZSBoYXZlIG1heSBmb2xsb3cgdGhlIExpbnV4DQo+ID4gPiA+IGtlcm5lbA0KPiA+ID4gPiBt
b2RlbA0KPiA+ID4gPiB3aGVyZSBhbGxvY2F0aW9ucyBhcmUgKGFsbW9zdCBhbHdheXMpIGF1dG9t
YXRpY2FsbHkgZnJlZSgpJ2QuDQo+ID4gPiA+IEhvd2V2ZXIsDQo+ID4gPiA+IHF1aXRlIG9mdGVu
IHdlIGRvbid0IGVuYWJsZSwgaW4gZnVsbCBVLUJvb3QsIHRoZSB0cmFja2luZyBhbmQNCj4gPiA+
ID4gZnJlZSgpJ2luZw0KPiA+ID4gPiBmdW5jdGlvbmFsaXR5LiBUaGlzIGluIHR1cm4gbGVhZHMg
dG8gbWVtb3J5IGxlYWtzIGJlY2F1c2UgdGhlDQo+ID4gPiA+IGRyaXZlcg0KPiA+ID4gPiBhdXRo
b3IgZXhwZWN0cyB0aGF0IHNpbmNlIHRoZSBmdW5jdGlvbnMgaGF2ZSB0aGUgc2FtZSBuYW1lIGFz
IGluDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBMaW51eCBLZXJuZWwgdGhleSBoYXZlIHRoZSBzYW1l
IGJlaGF2aW9yLiBJbiB0dXJuIHdlIHRoZW4gZ2V0DQo+ID4gPiA+IGZ1bmN0aW9uYWxseSBjb3Jy
ZWN0IGNvbW1pdHMgc3VjaCBhcyBjb21taXQgMDBlMWZlZDkzYzhjDQo+ID4gPiA+ICgiZmlybXdh
cmU6DQo+ID4gPiA+IHRpX3NjaTogRml4IG1lbW9yeSBsZWFrcyBpbiBkZXZtX3RpX3NjaV9nZXRf
b2ZfcmVzb3VyY2UiKSB0aGF0DQo+ID4gPiA+IG1hbnVhbGx5DQo+ID4gPiA+IGFkZCB0aGVzZSBj
YWxscy4gUmF0aGVyIHRoYW4gbWFudWFsbHkgdHJhY2tpbmcgYWxsb2NhdGlvbnMgYW5kDQo+ID4g
PiA+IGltcGxlbWVudGluZyBmcmVlKClzLCByZXdvcmsgdGhpbmdzIHNvIHRoYXQgd2UgZm9sbG93
DQo+ID4gPiA+IGV4cGVjdGF0aW9ucw0KPiA+ID4gPiBieQ0KPiA+ID4gPiBlbmFibGluZyB0aGUg
REVWUkVTIGZ1bmN0aW9uYWxpdHkgKG91dHNpZGUgb2YgeFBMIHBoYXNlcykuDQo+ID4gPiA+IA0K
PiA+ID4gPiBUaGlzIHR1cm5zIERFVlJFUyBmcm9tIGEgcHJvbXB0ZWQgc3ltYm9sIHRvIGEgc3lt
Ym9sIHRoYXQgbXVzdA0KPiA+ID4gPiBiZQ0KPiA+ID4gPiBzZWxlY3QnZCwgYW5kIHdlIG5vdyBy
ZW1vdmUgb3VyIG5vbi1tYW5hZ2VkIGFsbG9jL2ZyZWUgZnVuY3Rpb25zDQo+ID4gPiA+IGZyb20N
Cj4gPiA+ID4gb3V0c2lkZSBvZiB4UEwgYnVpbGRzLg0KPiA+ID4gPiANCj4gPiA+IEnigJl2ZSBl
bmNvdW50ZXJlZCBhIHJlZ3Jlc3Npb24gb24gdGhlIE1pY3JvY2hpcCBQb2xhckZpcmUgU29DDQo+
ID4gPiBJY2ljbGUNCj4gPiA+IEtpdA0KPiA+ID4gd2l0aCBtYWlubGluZSBVLUJvb3QuDQo+ID4g
PiANCj4gPiA+IEFmdGVyIGNvbW1pdCAyMTdjZjY1NmUyNDkgLSB0aGUgYXBwbGljYXRpb24gb2Yg
dGhpcyBwYXRjaCAo4oCcZG06DQo+ID4gPiBjb3JlOg0KPiA+ID4gRGVmYXVsdCB0byB1c2luZyBE
RVZSRVMgb3V0c2lkZSBvZiB4UEzigJ0pLCBVLUJvb3QgZmFpbHMgdG8gYm9vdCBvbg0KPiA+ID4g
dGhpcw0KPiA+ID4gYm9hcmQuIEFmdGVyIHRoaXMgcGF0Y2ggd2FzIGFwcGxpZWQgdGhlIEljaWNs
ZSBraXQgbm8gbG9uZ2VyIGJvb3RzDQo+ID4gPiBhbmQNCj4gPiA+IGNyYXNoZXMgaW1tZWRpYXRl
bHkgYWZ0ZXIgT3BlblNCSS4gQmV0d2VlbiB0aGlzIHBhdGNoIGFuZCBtYXN0ZXINCj4gPiA+IEhF
QUQNCj4gPiA+IHRoZSBmb2xsb3dpbmcgZXJyb3JzIGFyZSBmb3VuZCAtIHBsZWFzZSBzZWUgYXR0
YWNoZWQgbG9ncyBmb3IgbW9yZQ0KPiA+ID4gZGV0YWlsOg0KPiA+ID4gDQo+ID4gPiDCoMKgwqAg
RmFpbGVkIHRvIHJlc2VydmUgbWVtb3J5IGZvciBmZHQgYXQgMHhiZjM4NjIxMA0KPiA+ID4gwqDC
oMKgIFJlcXVpcmVkIEZEVCByZWxvY2F0aW9uIGZvciBhcHBseWluZyBEVE9zIGZhaWxlZDogMQ0K
PiA+ID4gwqDCoMKgIENvdWxkIG5vdCBmaW5kIGEgdmFsaWQgZGV2aWNlIHRyZWUNCj4gPiA+IMKg
wqDCoCBEZXZpY2UgdHJlZSBub3QgZm91bmQgb3IgbWlzc2luZyBGRFQgc3VwcG9ydA0KPiA+ID4g
wqDCoMKgICMjIyBFUlJPUiAjIyMgUGxlYXNlIFJFU0VUIHRoZSBib2FyZCAjIyMNCj4gPiA+IA0K
PiA+ID4gU29tZXRpbWVzLCBJIGFsc28gc2VlIGFuIOKAnFVuaGFuZGxlZCBleGNlcHRpb246IEls
bGVnYWwNCj4gPiA+IGluc3RydWN0aW9u4oCdDQo+ID4gPiBhbmQNCj4gPiA+IGEgcmVzZXQuDQo+
ID4gPiANCj4gPiA+IFRoZSBsYXN0IGtub3duIGdvb2QgY29tbWl0IGlzIGJlZm9yZSB0aGlzIGNv
bW1taXQuIEkgdXNlZCBgZ2l0DQo+ID4gPiBiaXNlY3RgDQo+ID4gPiB0byBjb25maXJtIHRoYXQg
MjE3Y2Y2NTZlMjQ5ICh0aGlzIHBhdGNoKSBpcyB0aGUgZmlyc3QgYmFkIGNvbW1pdC4NCj4gPiA+
IA0KPiA+ID4gU3RlcHMgdG8gcmVwcm9kdWNlOg0KPiA+ID4gLSBCdWlsZCBVLUJvb3QgZm9yIE1Q
RlMgSWNpY2xlIEtpdA0KPiA+ID4gLSBCb290IHVzaW5nIEhTUyBwYXlsb2FkIGFzIHVzdWFsIC0g
SSB1c2Ugb3VyIGJ1aWxkIHN5c3RlbQ0KPiA+ID4gQnVpbGRyb290DQo+ID4gPiBmb3INCj4gPiA+
IHRoaXMNCj4gPiA+IC0gT2JzZXJ2ZSB0aGUgYm9vdCBmYWlsdXJlIGFmdGVyIHRoZSBhYm92ZSBj
b21taXQNCj4gPiA+IA0KPiA+ID4gQW55IGFkdmlzZSBvbiB0aGUgcHJvYmxlbT8NCj4gPiANCj4g
PiBJdCdzIHJlYWxseSBzdHJhbmdlIHRoYXQgaXQgYmlzZWN0cyBkb3duIHRvIHRoaXMgY29tbWl0
LCByYXRoZXIgdGhhbg0KPiA+IHNvbWV0aGluZyBkZXZpY2UgdHJlZSByZWxhdGVkLiBEbyB5b3Ug
c3RpbGwgaGF2ZSBmZHRfaGlnaD0weGZmZmZmZmZmDQo+ID4gb3INCj4gPiBzbyBzZXQgaW4gdGhl
IGVudmlyb25tZW50PyBJdCB3YXMgaW4gYXQgbGVhc3Qgb25lIG9mIHRoZSBsb2dzLCBidXQgSQ0K
PiA+IGNhbid0IHNlZSBmb3Igc3VyZSBpZiBpdCdzIGp1c3QgdGhhdCB0aGUgb3RoZXIgbG9nIGlz
IGZyb20gYmVmb3JlDQo+ID4gdGhlDQo+ID4gY29tbWl0IHRoYXQgYWRkZWQgdGhlIHByaW50IHdh
cm5pbmcgYWJvdXQgbm90IGRvaW5nIHRoYXQsIG9yIGlmIGl0DQo+ID4gd2Fzbid0IHNldC4NCj4g
PiANCj4gQXBvbG9naWVzIGZvciB0aGUgZGFseSBpbiBteSByZXNwb25zZSwgSSB3YW50ZWQgdG8g
ZG8gc29tZSBtb3JlDQo+IGRlYnVnZ2luZyBiZWZvcmUgZ2V0dGluZyBiYWNrIHRvIHlvdS4NCj4g
DQo+IFRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24gYWJvdXQgZmR0X2hpZ2guIFdlIGhhdmUgaXQg
c2V0IGluIG91ciBib290DQo+IHNjcmlwdHMuIEkgY2hhc2VkIHRoaXMgZG93biB3aXRoIGEgYmlz
ZWN0IHRvIDkyMzVkYTk0NDZlIChib290OiBXYXJuDQo+IHVzZXJzIGFib3V0IGZkdF9oaWdoPX4w
IHVzYWdlKS4gSSBoYXZlIG5vdyBzZXQgZmR0X2hpZ2ggdG8gb3VyIG1heGltdW0NCj4gYWRkcmVz
c2FibGUgdmFsdWUgaW5zdGVhZCBvZiB+MC4gVGhpcyBkb2VzIGdldCByaWQgb2YgdGhlIHdhcm5p
bmcNCj4gYWJvdXQNCj4gZmR0X2hpZ2ggaW4gVS1Cb290LCBzbyB0aGF0IHBhcnQgaXMgcmVzb2x2
ZWQuDQo+IA0KPiBIb3dldmVyLCBpdCBkb2VzbuKAmXQgZml4IHRoZSB1bmRlcmx5aW5nIGJvb3Qg
aXNzdWUg4oCUIFUtQm9vdCBzdGlsbCBmYWlscw0KPiB0byBib290IGFsdG9nZXRoZXIuIER1cmlu
ZyBzb21lIGJpc2VjdGlvbnMgaXQgb2Z0ZW4gZmFpbHMgdG8gYXBwbHkNCj4gZGV2aWNlIHRyZWUg
b3ZlcmxheXMgYW5kIGRvZXNu4oCZdCBib290IHRoZSBrZXJuZWwgLSBJIGhhdmUgYXR0YWNoZWQg
dGhlDQo+IGxhdGVzdCBjcmFzaCBsb2cuDQo+IA0KPiBGcm9tIG15IGJpc2VjdGluZywgdGhlIG92
ZXJsYXkgYnJlYWthZ2Ugc2VlbXMgdG8gc3RhcnQgd2l0aCB0aGUNCj4gRFRDL2xpYmZkdCB1cGRh
dGUgY29tbWl0ICgwNTM1ZTQ2ZDU1ZC4uLikuIEFmdGVyIHRoYXQsIG92ZXJsYXkNCj4gYXBwbGlj
YXRpb24gY29uc2lzdGVudGx5IGZhaWxzLCByZWdhcmRsZXNzIG9mIHRoZSBmZHRfaGlnaCBzZXR0
aW5ncy4NCj4gQXMNCj4gYW4gYWRkaXRpb25hbCBwaWVjZSBvZiBpbmZvcm1hdGlvbiBkaXNhYmxp
bmcgTVVMVF9EVEJfRklUIGFsbG93cyB0aGUNCj4gYm9hcmQgdG8gYm9vdCBhcyBmYXIgYXMgZmR0
IGVycm9yLg0KPiANCj4gTGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW55IG90aGVyIGlkZWFzLg0K
PiANCj4gVGhhbmtzIQ0KDQpKdXN0IGZvciBzb21lIGZ1cnRoZXIgY2xhcml0eSwgYmVmb3JlIHRo
ZSBERVZSRVMgQ29tbWl0Og0KIC0gVS1Cb290IGJvb3RzIGZpbmUgd2l0aCBvdmVybGF5cyBkaXNh
YmxlZCBhbmQgZmR0X2hpZ2ggcmVzZXQuDQogLSBPdmVybGF5IGFwcGxpY2F0aW9uIGNhdXNlcyBG
RFQgZXJyb3JzLCBidXQgYmFzZSBib290IHdvcmtzLg0KQWZ0ZXIgdGhpcyBERVZSRVMgQ29tbWl0
IChkbTogY29yZTogRGVmYXVsdCB0byB1c2luZyBERVZSRVMgb3V0c2lkZSBvZg0KeFBMKToNCiAt
IFUtQm9vdCBkb2VzIG5vdCBib290IGF0IGFsbCDigJQgbm8gb3V0cHV0LCB0b3RhbCBjcmFzaC4N
CiAtIFRoaXMgaGFwcGVucyByZWdhcmRsZXNzIG9mIG92ZXJsYXkgdXNhZ2Ugb3IgRkRUIGVudmly
b25tZW50IHNldHRpbmdzLg0KDQpSZWdhcmRzLA0KSmFtaWUNCg0K
