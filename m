Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6ABD2ECE9
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 14:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8431E83A8D;
	Tue, 20 Jan 2026 15:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="37s+UX4D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD80583A8F; Tue, 20 Jan 2026 11:45:20 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3664083A83
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 11:45:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jamie.Gibbons@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IoCzITCmYXueQQngrtUpVAl+SYPtNA05Pself1gb6Vs9LFun3eYjo8tw3rMKH2u1slI8U7PBfNu3g0sDQswhlXbSahgP+spf5E8noWCWqKv6Dov2gL6K5dTnOt/zTWZpWAsBVzEivy+POsSWS9Pi6xUAvgOjmD/v7cu80xHzt0KaCn7BHFwJ7SdERWXV/eSjDMxS7wXFWsStna/Vdt0kin+QkFD4tiQegvzSITC1aielI39pku/7W15v5Q1suH1K5B4k2gR/bqN2HTEVoPBzyINsZS1lXTll9Cdrr/8TQM4r2Tw+gJ3tqV94DKQmEOpU3da2KyDqUMlzXmDrD+dKQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7RkEXGzaUqAjTvzN6YqxYS/a1UsBgFmMwOLTFj+pvY=;
 b=aharelk2fVEzM9jzg+fYHQwkQDNRj/TOLITY6HG3PPosq7gYPpbzirUYkQNX+XTBFetU/3VhW5/sl19v0+LGIe98NuUv1WcrtRBn/xmemcDCo8+Xtgt0bMrl1IPSwdg3qeJk99VkwfjAuJc2BwsVwvhxlqvA8KU0rZ7wLzNp5X/ir1GrgGqCqxhZ9wUc1eXFYOYfiYdQ4842EeKA8iTHBJtKXurcpZ2ocAFMGe07BgkxFhpC+gWmWKA6f0L+Rlm+7D9+ddHy7ZDnozehdVKrSqWyhxHA75EGAYSWK2AI01E06io3Szf4YruCwLkHKWhl4LoOqJkjNEIRuRZY6mbEmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7RkEXGzaUqAjTvzN6YqxYS/a1UsBgFmMwOLTFj+pvY=;
 b=37s+UX4DruTpn0splnSUpPqIXovWnPolPOT49T3ojUUaebKly3E5cmJ13aboXmFratPK2EjhUSUHXJwGqw968QsaA73mSDfN0w5+0sPNIQiAKUWs48WNJvSCwj3mYoGXKflJ7OyYiWs3QuQctpkze1ZKFI/ZJGtohBsQjDnU2DxrN4ped+U2zU1J1lFvlyutTIO/10RZVBScKfquBEV1hG3a8ZBsFbA5WGZ90TkMF7PAyRRtsG9HDgmIqthw+P5JG1EwtL587w5j+2AsFh8xuxAPKyxLCchz3aaTlgHdupYNlIrRFnuIti80CAK1RTBtTk3QrL/KSBEwZAjXGYafJw==
Received: from DM4PR11MB6335.namprd11.prod.outlook.com (2603:10b6:8:b7::10) by
 PH0PR11MB5158.namprd11.prod.outlook.com (2603:10b6:510:3b::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Tue, 20 Jan 2026 10:45:14 +0000
Received: from DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::3adb:8c97:94da:80]) by DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::3adb:8c97:94da:80%3]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 10:45:14 +0000
From: <Jamie.Gibbons@microchip.com>
To: <marek.vasut@mailbox.org>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <Conor.Dooley@microchip.com>,
 <Valentina.FernandezAlanis@microchip.com>
Subject: Re: [PATCH v2] scripts/dtc: Update to upstream version
 v1.7.2-35-g52f07dcca47c
Thread-Topic: [PATCH v2] scripts/dtc: Update to upstream version
 v1.7.2-35-g52f07dcca47c
Thread-Index: AQHchwFkjqXL5NuND0+6jEwP8Ex5sLVU+B6AgAAFeICABMM6AIAAKjaAgAD8CgA=
Date: Tue, 20 Jan 2026 10:45:14 +0000
Message-ID: <58101ca60af16df66be8e2707fef2597f855a8e1.camel@microchip.com>
References: <20251202193310.149861-1-marek.vasut+renesas@mailbox.org>
 <d5d2320f54090420c32207c25b35c881ea1519b4.camel@microchip.com>
 <82e5aebe-5792-4a68-b054-7f90dd82e7b3@mailbox.org>
 <bb9936a8bafa83fceed86f0805d2340914b52dca.camel@microchip.com>
 <baa48570-2114-4313-9bac-280aab0960fb@mailbox.org>
In-Reply-To: <baa48570-2114-4313-9bac-280aab0960fb@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6335:EE_|PH0PR11MB5158:EE_
x-ms-office365-filtering-correlation-id: 7460f60e-3d48-4614-ce60-08de5810fe8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NnpjaWgrOUgxYm05Zk5DNWtvZzBsbUdISVVjZ1VNWS9XNkdEKzFKenBVZ3Ay?=
 =?utf-8?B?Rk5xVmVkZDVSN1pzc3FFWTJLaEVDUTYyNjNISjh3WTR5aWx0ZXFXOTdqSWFu?=
 =?utf-8?B?VUFsWnJnT0pnbXFkdHJqaGNHNVo2U3YyYzVUZW9zaE5TNE1WUG1lQXZwYWxU?=
 =?utf-8?B?RGxQZjRCWUtBMFVEZnc2U2dDU2ZJbFd4NUU1TURCNWVkazUzUFk0N0VNV0Qr?=
 =?utf-8?B?TWtneDAwcTAvaElXSUd2VDVWT0Y3V0p4YlhxSG8yaE5hQnhqdVBvNXVMcVlD?=
 =?utf-8?B?SXYxajhmQ3BzY1hGTWpFVkk3NENNQ2VpQytma2xMbG9tSmlHYXdFSkJiamxt?=
 =?utf-8?B?cThRaU9mdUJPQzdodmNyMDVHQWFCTjBlSHhhWHdQQU92V2RUUmc4YjhndUQ2?=
 =?utf-8?B?U2wyNGo3cC9QbXYzcnJZQVF5cnJiTXM4UUM1VDU2OHFOTFc0TE9uMjJiWGVB?=
 =?utf-8?B?YmNKeU83dSt3cUFjemg4ZUMwUEh0RC9yVDB0WU0zVFA5cHNpRkZxb05wRUFv?=
 =?utf-8?B?MjNpbmV5eVcvT2VmcXltRGg2a3hGL2grMDkrcHJDZFNUWFh3aUVqOE5BYmFX?=
 =?utf-8?B?bzFveDVKSDlKejFMODhkaE1rMnN6VW1GZDlrN1BTWTBrR0tHSXROK0ZITnF6?=
 =?utf-8?B?WmEvM0tLN1V0UEFURjc2Rjc0dXJBbDlqSFVUaTNIcDRJdGxaWnFBOXYwTVdt?=
 =?utf-8?B?aWtnQnhvdHRtSkxaT3RMK25kbWc0YllESkQrcS9sb2t2NjMxSlBSZHJwbVJU?=
 =?utf-8?B?YWlSZWo5Znp3QXViZkFlNkhlUmQ3enA5Qnh6cjZxUittVWpUZmR6Z1RCeGR0?=
 =?utf-8?B?eUgvUmtkTHErbTNnTzRqSTZyak1HYWJBUkR5ZldzdHo1Q3NncW1NZkN3bjVE?=
 =?utf-8?B?SWNyRUs5bGdKbUV0Z2ZoVHJsb1diWkNsN1J5WDByOXljQWMzMXROaVdBRVQ0?=
 =?utf-8?B?ZU0yS0FtM3JZUE9sRDRCV25oK2tmS1JJaWFtTC9YVFc0a0U3VzQ5RVU4dWVs?=
 =?utf-8?B?TmloQk05eWtIVUwrVUdwdURobDAvWHRtSWZPYUx4TEpSd3RLczE3U0dOdS9Q?=
 =?utf-8?B?ZjZPVEFhTTNsdnU4L2xHMVU4eUlTUnljdWJvWFBGNGE1SWtiQzZKN3pBa0xy?=
 =?utf-8?B?QkMxVC9wVzFZRmFSRVZvV3dsZGRkM0lQWWZlay8vZnVkbkxkd05FR3JxOE1J?=
 =?utf-8?B?REVacmpZZmtSTjdMZGVXZTJ6c3UrajZpY2xlcHI3NDYxUU1NVE5mTkdQTWM0?=
 =?utf-8?B?Z3I1dnZ4V05Bd3VmdGE5U0hPYTF0Rngwam90YmxqQlVQdmJQenJDbFJjbE1O?=
 =?utf-8?B?YjdtUXVaazZST0kxM25COUlkMGcyR2tuRm9kRFZkbHV2bWwvVGQ2dlJUcGJV?=
 =?utf-8?B?ckZWdUF3dFZDYVVYUC93Y0ZROUJhUDBocWVHalBWTnFrdWRkRlNaM1FyMGFi?=
 =?utf-8?B?TVlrSHZtZlZwc0pWYmVML0gyNnhXQVBJWTByTHVKa05TK1J4VkRjRFFhR0gw?=
 =?utf-8?B?YlorK2Y1U0tBVVEvT0wvZ0FkOFJzWHBzeVQyZGpOYWVZRHQ3bmN1Wkx0NThT?=
 =?utf-8?B?b2M0bkF5MFFrejJTclJGLy9nSTVsalljNXlsWXNkK2JYUUJBYU8yOEMwUDND?=
 =?utf-8?B?a1hzQ2JrbnNkR2xVRUFxdm10bzlGRmNCSWl1dG9laEtnbU1SbWJpZ2Y2SUhw?=
 =?utf-8?B?cXpjUGdwelcwdzIydjdIbTFtVTJ3WVJWWGFwWlVVTmJrV0RPRFJodTc0WGty?=
 =?utf-8?B?dXVoQkJNMkNBMnRnK0JKZnZjT1JabEI0ZFNtb2hKcVh5RUI2YjJnVlFWcEhq?=
 =?utf-8?B?N0d3VXJXZHlhWkZuQW1VZWhUTnNKbHk0U3E3RUU2UHB5SzBiaVJEcFc0N1Uw?=
 =?utf-8?B?WnBrR2dGQXgrdlZrOXYzeURsTVVUUXhvd2p4S3RxUXptT2J2ZklQVXFLYW5T?=
 =?utf-8?B?b0dvendnYUt0VXFqR2xZTmRGT0JZOExnODdrZVRxZHRBMVhSRmJ5SXVrMHBs?=
 =?utf-8?B?cGZudzlHN1VGL1JMaWVXMU5NVHlFb1lGMThhMlFteUJ6ejlLYzltcDhvOUdv?=
 =?utf-8?B?NnlkK0xVekZYUHN3K3A0RUZnRU9MSWdtY0RiY2E0RnZMRzhBTzhObDhtcENW?=
 =?utf-8?B?aGlBT3VaMnVMTHdPNEVsTzVGeHdSRlEzVGxrdDhWbllmWDRVY0lxV2QyQkVU?=
 =?utf-8?Q?nILKQfwFao+J/7KdoL4yxl4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6335.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmZwbTZ1Ky96K1phZjJKUVo0RWttYit6bUpaMjhTbjY4ejVmWVFBSzlBd3FQ?=
 =?utf-8?B?YVV3ekw1UHFoeVgxQ3NJRjRaWTJtaEk0TFhxS1lPZUpRaWF2dk9LU0ZnaFdj?=
 =?utf-8?B?Z2JjRWxBZHRCbmo3NFI0MHpqbktRb0dKRUducWlXWGh4OEhHRXRUdzM5bXJx?=
 =?utf-8?B?T3JYdUVmLzRST01jUmNQNDQyNHBodHE1UUVjdVR2bTJWdmkwVFBrTmZ5SEVs?=
 =?utf-8?B?SkR1WmYxckZ5V3RRZHdrVkVHVWxScktoTGdTOUZaNFRQQ05uUi9CTkFNdlVE?=
 =?utf-8?B?RVVxMjlMcmN4YldJRFRjaEYyZVpiajlFN2N0R3VhYW1WR3hyVVFGaUFwTUZU?=
 =?utf-8?B?NFFlNHJCK29vYWp4TGlYYmpBYVJGeVNsVVdGR3NsSitCaEhBQkpkdHVFT0VY?=
 =?utf-8?B?WHNvVll6WHRBZEluVTVScFZyNUhUYThVdlRiQTF1U3Z2QXpUY0FiZTVXVXVm?=
 =?utf-8?B?dGtEVEdBaWpDRW4ydUNCVUFBMDBpdnk4bzlrbmxya0VucXFPRjBFTlQ2NW40?=
 =?utf-8?B?TS9GKzFWOXY1SWljcDBwM09XcXFlY2cwOFdhUFU5VTNUWUVpdVNYS1VKcWdO?=
 =?utf-8?B?NmQ5SWtzU1B4eVJrWmRITHlNRDhBR2xJbklsaHlRbE82aFhNV0Q0ZnRQQ1I1?=
 =?utf-8?B?OXdocWZKb2cwYWVVVVowK0xxS0NDb3o2V3BOUTNrWFp4ZzJjdTY1WjBYNXh6?=
 =?utf-8?B?ejBGQ3o4aHRra1VIVEsyajQ4TDdEYUlGVWVNZ1RXMTV2ZHIrb2JHSmU3TnNU?=
 =?utf-8?B?UldHL3JMYUNIVktTbzVuUHM3eHpEbms5UWlnS3VQUFJWV3dtczBCSjRZMXI2?=
 =?utf-8?B?RENUdkovUVA5c0pySTNtSm50QklZTERKMFJxdGdwM3R1OWFJdkhoQ1FCbkxY?=
 =?utf-8?B?ZHRjcnpOVklvZVNWUUxFTTNIOEM3WnNpNWxGZ3UvQnd0clFCQ1ZiT0ZTeFdm?=
 =?utf-8?B?WTYwdjk3UkgwSUZOTnNNQmxjWXoxVTdRV0QrNHBhZi9GN1EreFRibVVaYmNq?=
 =?utf-8?B?VEJKMENJcHBETXpVQmYxbDFNaC96WklqWStOQk9RellWbHRpaG80RlhSQ2E0?=
 =?utf-8?B?Z1RvbHE0MDJwNVNFeDhETjlJN25yYWMwTXZLbHNIaVB0cVpDV1daYkZwMDhy?=
 =?utf-8?B?T04vUDFnSk9HRGR1NWNDRTVwRTRtQUNsZWM4aFZKYTB4SG4zMDdBM01RelBG?=
 =?utf-8?B?UnNEUy9kS1ZhbC9mRVdHU3dBempJWHAxYUZ2cE5Vdi9mV3RDVVczKy9pRU0z?=
 =?utf-8?B?QWNrWnZFbjJ3Y21seEJOSllwc0U2TnVLbE9xZGVldjhCMHRiZXJVbmQzTjFC?=
 =?utf-8?B?SzdlbnhraDVVL25HeGNpZ2dPRy9GbDJJMFdZT3RETjgrVzVvTEVEODR4L1ZL?=
 =?utf-8?B?aThFQ3d6V0t6emxESW00MUNNcWl6em5YNW1RTDc1TWhGdTl1eEw3Qzg5ekRJ?=
 =?utf-8?B?YmVuTysvVnNUbEl1NzNwWnhzNWhUVDFMRFdIMEx2SlF2VlRKazBhUGQ4cEdY?=
 =?utf-8?B?dmpOSXdiOGRlL0R4dFhJMHNucE9pZW5mUUxyakEvVmFZUkRmeEFSNTNuTTFV?=
 =?utf-8?B?azhBajBXcSs2ZHpPSFdNSkpSUG1jL1BuVTV0TjNWZTBmTHBuUXl5aDVlcTJp?=
 =?utf-8?B?dkZiUFRVYkd2cFpmSCt0YVVFNnFBd0RRRHVSMlNuc2lQcUN5d2UzTzVibUhm?=
 =?utf-8?B?RHJIT00wQ2dkR1didUdaREZEZ0NuWWI0R3lPQ0JRdjdFN0dia3l0SGFoRkps?=
 =?utf-8?B?c04vUUNrT0tiRU01NmNIc1BCcGY5ZHN5ZDErRGw3VGVDaGlLeWxwTlNwaGFF?=
 =?utf-8?B?aHl0NVIrUnRTaUhIbFFGQzFRKzhIWDk1T3lmVThWNmZVSFZoRE1YaHFSSkVC?=
 =?utf-8?B?eTY4emh1Q0lQR1ZYdXZDb0NTYTJCTllnZzF5WVJmNGpMVkY2bVRPanlIbjk5?=
 =?utf-8?B?RkVnR1JQK2xsQUFhVTFoYVNlcXhaWDFwTlpieUVGeXZuVmdyN1UzR2tURHlm?=
 =?utf-8?B?MGNHWENHT3kvVEJld2RmQ01VUzBmQnNtZiszSnlua3h5MWozdFVlNnQwcTFQ?=
 =?utf-8?B?cVZsc1QyY3cwMGtzZGFOaWFiaTBvOFVVdHRJYncxSTI1d2RmR3BFcmpUWXp5?=
 =?utf-8?B?MWJzTXJJcHRQR0pRV2RXRnl3aXVvbHVRQk1CNGFUQUk1UWNDVWtUQkJNNEp4?=
 =?utf-8?B?eE1ENXc0YUR0RHdXUTdpa1VIb2RWZGp1THNZQ2k0ZHE3M0FyczgrYlExbE9y?=
 =?utf-8?B?L0NqV2lhRHE2djk5OWRBbzQreEwyVGtwcW9kbVNzSGxjbXZYMnpJNkVIYTFT?=
 =?utf-8?B?S0NCWm1NektVTTcvN2RjM282Qy9ZLy9xL2QwWXFpSVFZbXIyaFRCYVg1Uk1y?=
 =?utf-8?Q?DhaRH8oTwpdO1GGk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A92616FBA3D474E84C45BEFC127DC2C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6335.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7460f60e-3d48-4614-ce60-08de5810fe8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 10:45:14.6294 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zMxaJpRlJhXYfM/yZcHmptynDwu3pjmaRGfwoxWJ80d14G9lCPTuUEFlJ1qMyEfF/h/7DagwQgJD16RrE41CFJrKxXlzWvnNtYmnXQ1qTo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5158
X-Mailman-Approved-At: Tue, 20 Jan 2026 15:06:23 +0100
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

SGkgTWFyZWssCgpPbiBNb24sIDIwMjYtMDEtMTkgYXQgMjA6NDggKzAxMDAsIE1hcmVrIFZhc3V0
IHdyb3RlOgo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bmxlc3MgeW91Cj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlCj4gCj4gT24gMS8x
OS8yNiA2OjEyIFBNLCBKYW1pZS5HaWJib25zQG1pY3JvY2hpcC5jb23CoHdyb3RlOgo+IAo+IEhl
bGxvIEphbWllLAo+IAo+ID4gPiA+IFRoZSBlcnJvciBpczogZmFpbGVkIG9uIGZkdF9vcGVuX2lu
dG8gZm9yIERUTywgaS5lLiBvdmVybGF5Cj4gPiA+ID4gYXBwbGljYXRpb24KPiA+ID4gPiBmZHQg
ZXJyb3IuIFRoaXMgd2FzIGludHJvZHVjZWQgYnkgMDUzNWU0NmQ1NWQgc2NyaXB0cy9kdGM6Cj4g
PiA+ID4gVXBkYXRlCj4gPiA+ID4gdG8KPiA+ID4gPiB1cHN0cmVhbSB2ZXJzaW9uIHYxLjcuMi0z
NS1nNTJmMDdkY2NhNDdjLCBpLmUuIHRoaXMgcGF0Y2guCj4gPiA+ID4gUGxlYXNlCj4gPiA+ID4g
c2VlCj4gPiA+ID4gdGhlIGF0dGFjaGVkIGxvZyB3aGljaCBpbmNsdWRlcyBhIGBwcmludGVudmAg
YXR0YWNoZWQuCj4gPiA+IERvZXMgdGhpcyBmaXggeW91ciBwcm9ibGVtID8KPiA+ID4gCj4gPiA+
IGRpZmYgLS1naXQgYS9ib290L2ltYWdlLWZpdC5jIGIvYm9vdC9pbWFnZS1maXQuYwo+ID4gPiBp
bmRleCAyZDA0MGUzOGQ5Ny4uMTE2M2U4MzdkN2UgMTAwNjQ0Cj4gPiA+IC0tLSBhL2Jvb3QvaW1h
Z2UtZml0LmMKPiA+ID4gKysrIGIvYm9vdC9pbWFnZS1maXQuYwo+ID4gPiBAQCAtMjQ5MSw3ICsy
NDkxLDcgQEAgaW50IGJvb3RfZ2V0X2ZkdF9maXQoc3RydWN0IGJvb3RtX2hlYWRlcnMKPiA+ID4g
KmltYWdlcywKPiA+ID4gdWxvbmcgYWRkciwKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBvdiA9IG1hcF9zeXNtZW0ob3Zsb2FkLCBvdmxlbik7Cj4gPiA+IAo+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG92Y29weWxlbiA9IEFMSUdOKGZkdF90
b3RhbHNpemUob3YpLCBTWl80Syk7Cj4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IG92Y29weSA9IG1hbGxvYyhvdmNvcHlsZW4pOwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBvdmNvcHkgPSBtZW1hbGlnbig4LCBvdmNvcHlsZW4pOwo+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghb3Zjb3B5KSB7Cj4gPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByaW50ZigiZmFpbGVkIHRv
IGR1cGxpY2F0ZSBEVE8gYmVmb3JlCj4gPiA+IGFwcGxpY2F0aW9uXG4iKTsKPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmR0X25vZmZzZXQg
PSAtRU5PTUVNOwo+ID4gPiAKPiA+IEFwb2xvZ2llcyBmb3IgdGhlIGRlbGF5ZWQgcmVzcG9uc2Uu
IFRoZSBhYm92ZSBwcm9wb3NlZCBzb2x1dGlvbiBkaWQKPiA+IG5vdAo+ID4gY2hhbmdlL2ZpeCB0
aGUgaXNzdWUuIEFueSBvdGhlciBzdWdnZXN0aW9ucyB3b3VsZCBiZSBncmVhdGx5Cj4gPiBhcHBy
ZWNpYXRlZC4KPiBMb29rIGF0IHRoaXMgcGllY2Ugb2YgY29kZSBpbiBib290L2ltYWdlLWZpdC5j
IDoKPiAKPiAyNDg5wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVidWcoIiVzIGxv
YWRlZCBhdCAweCUwOGx4IGxlbj0weCUwOGx4XG4iLAo+IDI0OTDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuYW1lLCBvdmxv
YWQsIG92bGVuKTsKPiAyNDkxwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3YgPSBt
YXBfc3lzbWVtKG92bG9hZCwgb3ZsZW4pOwo+IDI0OTIKPiAyNDkzwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgb3Zjb3B5bGVuID0gQUxJR04oZmR0X3RvdGFsc2l6ZShvdiksIFNaXzRL
KTsKPiAyNDk0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3Zjb3B5ID0gbWVtYWxp
Z24oOCwgb3Zjb3B5bGVuKTsKPiAyNDk1wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgKCFvdmNvcHkpIHsKPiAyNDk2wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHByaW50ZigiZmFpbGVkIHRvIGR1cGxpY2F0ZSBEVE8gYmVmb3JlCj4gYXBw
bGljYXRpb25cbiIpOwo+IDI0OTfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZmR0X25vZmZzZXQgPSAtRU5PTUVNOwo+IDI0OTjCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7Cj4gMjQ5OcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiAyNTAwCj4gMjUwMcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGVyciA9IGZkdF9vcGVuX2ludG8ob3YsIG92Y29weSwgb3Zjb3B5bGVu
KTsKPiAyNTAywqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGVyciA8IDApIHsK
PiAyNTAzwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBy
aW50ZigiZmFpbGVkIG9uIGZkdF9vcGVuX2ludG8gZm9yCj4gRFRPXG4iKTsKPiAKPiBUaGlzIGlz
IHdoZXJlIGl0IGZhaWxzLiBJcyAkb3Ygb3IgJG92Y29weSA0LWJ5dGUgYWxpZ25lZCA/IEVuYWJs
ZSB0aGUKPiBkZWJ1ZygpIHByaW50IGF0IHRoZSBiZWdpbm5pbmcgKG9yICNkZWZpbmUgREVCVUcg
YXQgdGhlIGJlZ2lubmluZyBvZgo+IHRoaXMgZmlsZSkgdG8gZmluZCBvdXQuCj4gCj4gSWYgJG92
IGlzIDQtYnl0ZSBhbGlnbmVkLCB0cnkgdG8gZ2VuZXJhdGUgeW91ciBmaXRJbWFnZSB3aXRoICJt
a2ltYWdlCj4gLi4uIC1FIC1CIDggLi4uIiAsIGRvZXMgdGhhdCBtYWtlIGFueSBkaWZmZXJlbmNl
ID8KClRoYW5rIHlvdSBmb3IgeW91ciBzdWdnZXN0aW9ucy4KCkkgZm9sbG93ZWQgeW91ciBhZHZp
Y2UgYW5kIGludmVzdGlnYXRlZCB0aGUgYWxpZ25tZW50IG9mIHRoZSBvdmVybGF5CmJ1ZmZlci4g
VGhlIGVycm9yIGNvZGUgcmV0dXJuZWQgYnkgZmR0X29wZW5faW50byB3YXMgRkRUX0VSUl9BTElH
Tk1FTlQKKC0xOSksIGNvbmZpcm1pbmcgdGhhdCB0aGUgb3ZlcmxheSB3YXMgbm90IHN1ZmZpY2ll
bnRseSBhbGlnbmVkIGZvciB0aGUKdXBkYXRlZCBsaWJmZHQuCgpJIG1vZGlmaWVkIG91ciBCdWls
ZHJvb3QgcG9zdC1pbWFnZS5zaCBzY3JpcHQgdG8gZ2VuZXJhdGUgdGhlIEZJVCBpbWFnZQp1c2lu
ZyB0aGUgc3VnZ2VzdGVkIGFyZ3VtZW50cy4gV2l0aCB0aGUgLUIgOCBvcHRpb24sIGFsbCBibG9i
cyBpbiB0aGUKRklUIGltYWdlIGFyZSBub3cgOC1ieXRlIGFsaWduZWQuIFRoaXMgcmVzb2x2ZWQg
dGhlIGFsaWdubWVudCBlcnJvciwKYW5kIGRldmljZSB0cmVlIG92ZXJsYXlzIGFyZSBub3cgYXBw
bGllZCBzdWNjZXNzZnVsbHkgaW4gVS1Cb290LgoKVGhhbmtzIGFnYWluIGZvciB5b3VyIGhlbHAu
CgpSZWdhcmRzLApKYW1pZS4KCg==
