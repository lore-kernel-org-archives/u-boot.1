Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DF1CA5FA0
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 16:15:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F50B83A6A;
	Tue, 20 Jan 2026 17:15:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="RPkH/QkD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BBE783A9F; Tue, 20 Jan 2026 15:50:40 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EF9783A6A
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 15:50:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jamie.Gibbons@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sn2gK5INaRmeTaY0BoHc/R6r+FNFeI5scfo7v7OZIKOh3vrUvbOMk7hi2EVV+LLQiWkY3UmW7qHZso5JyGYa7tGJQE5dCAr/esmqJPLBR0EN5pdCBi5V5D5M7MebBOGAW/G8Y5db4tXeO23s/Edg+n7IBnHaSMbkzepfh1mtO17SL8c7JWkcZCn43TjwreUNuCUtGegTG/J19LFSaMOipA0AkxMRpwvZdcsGC/EhTSMyNlNMbDTgy0meJEpOJBNrsgzIpXQBq+JBQvy0FnFHhdhIWj0ytc2CVoePLh6z+Gwtbg2gCf/rjViv6F40BdmLHsNWk0SgBuHWJk9vPPiStg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujPH6HX4uNUa5zpjU78bfSyUEwZRo43l426GN1eBNgM=;
 b=D9e59aDWqbQJQ+fijLpVzWOQfafHW7jO6CXaCTd58OXHs1bx6MFmhTkGmbIlP6PEf+LE9SsZGduBuZ/QTElfxKoS3LNpyG3lw6h3HjcKogEMwoIgiIdhhYX0vWZDkaB8ui1zA0DC/J61ItuU3BXos+qkqB9NEmtJpqe932n7jAe0/Q+w5LTC7aCCeAvIA92EZsGZ5ZBMmpFIFgWV4ySr8P3ORRSoYcIpo2LhfkdyB30pbX+mbIVH9I7hRzuFYoM1ZQiZlVWsia9EU9/Qdm+pm9SzJvpwm0+xE0GS8PPu01CVbhPWhjShR7GS3Mp7S9i/7cpOAq7pGl/YwobsXxHpkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujPH6HX4uNUa5zpjU78bfSyUEwZRo43l426GN1eBNgM=;
 b=RPkH/QkDAcmR+onwCNv/cg074kjf2AtixkmiasraumfgBGCiKmBXPEFwQSZ8BBfSvrgYOtqsWtkkLScvsfN62QisRDnU96qphj3x+1KHMb0pmr2MuubuReyxpzWGDtQNJaHcrgWvlXKxj9E7KYRYYDq1i4k3xyvKAEWExpZIDufLNGUxn75FmvImJAOXO366G9MDhGYjgf1Nc8ZHc8JYmAoshz4ZFGeTnfXvdD11G6U1Rqo/sZaw71L0Cq3W0CdpDEcPVn5cgKMP3+ii7vXapecPfObxh9zImvFNazNRn66Zdt+WZdYUWuEcBD7RDfphOQqrEDKQGPFcJx1jFFUCLg==
Received: from DM4PR11MB6335.namprd11.prod.outlook.com (2603:10b6:8:b7::10) by
 SA2PR11MB5177.namprd11.prod.outlook.com (2603:10b6:806:11c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 14:50:34 +0000
Received: from DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::3adb:8c97:94da:80]) by DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::3adb:8c97:94da:80%3]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 14:50:34 +0000
From: <Jamie.Gibbons@microchip.com>
To: <marek.vasut@mailbox.org>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <Conor.Dooley@microchip.com>,
 <Valentina.FernandezAlanis@microchip.com>
Subject: Re: [PATCH v2] scripts/dtc: Update to upstream version
 v1.7.2-35-g52f07dcca47c
Thread-Topic: [PATCH v2] scripts/dtc: Update to upstream version
 v1.7.2-35-g52f07dcca47c
Thread-Index: AQHchwFkjqXL5NuND0+6jEwP8Ex5sLVU+B6AgAAFeICABMM6AIAAKjaAgAD8CgCAAAJ4AIAAMgMAgAAJuICAAAZWAA==
Date: Tue, 20 Jan 2026 14:50:34 +0000
Message-ID: <f6e27291ecd42a2563034250ac0016c75b61d35c.camel@microchip.com>
References: <20251202193310.149861-1-marek.vasut+renesas@mailbox.org>
 <d5d2320f54090420c32207c25b35c881ea1519b4.camel@microchip.com>
 <82e5aebe-5792-4a68-b054-7f90dd82e7b3@mailbox.org>
 <bb9936a8bafa83fceed86f0805d2340914b52dca.camel@microchip.com>
 <baa48570-2114-4313-9bac-280aab0960fb@mailbox.org>
 <58101ca60af16df66be8e2707fef2597f855a8e1.camel@microchip.com>
 <712cfdc9-b3c3-4fca-8f14-763efdf5e0ae@mailbox.org>
 <856f8b6cdbc2311ac535d9b03c6e2d21a859c526.camel@microchip.com>
 <d6ea8e7c-1fc4-4f05-8a6b-805c0be12f4c@mailbox.org>
In-Reply-To: <d6ea8e7c-1fc4-4f05-8a6b-805c0be12f4c@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6335:EE_|SA2PR11MB5177:EE_
x-ms-office365-filtering-correlation-id: 6e8df31a-8dca-49f5-7b73-08de58334439
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eXlQTXpoY1BLWnFQK29NQVJveVdyeWNaNytXNzJmS01UODRYVXA4TXBQNTZo?=
 =?utf-8?B?akp6T2czRkJaeE5hVUpkSy9KUlZNY3I1bVBaU0wyNmp0bldFSWxzc0ptZ21M?=
 =?utf-8?B?SS9nSU5ySVFjazlYS1lwdVJKOEV5d1hKQWZZdWVoZXMyMHNzS2J1N1kyekNj?=
 =?utf-8?B?SWNzM1daMndNeUdNTVV6RUhLVGRGYWhVQzJDZ05IVGRnVEFka0IzckRHd3pv?=
 =?utf-8?B?M2RhTEt1ZkJUWHZkckJXWUJqOU9HTHFjeHh0SGtwRXpaTTAzeEhCdVc1YTUw?=
 =?utf-8?B?d09DYXNnbGQ1MURBbU9rYU15Ymw3RGxPcDkvZTZkQ0NjditiWmlkRVhKbzJD?=
 =?utf-8?B?ZGcycTl0cGhsU0dUOXcxYXVHL2o2clFyOWNSaDBQVnpSMFJvSUpZaktDL3dX?=
 =?utf-8?B?OE4xdjFYd0NXbElQRjB0ZVJzSjB6UXJLU3NWd3JCaHNMU2IxMlpkS2YzYXB5?=
 =?utf-8?B?TFhUaUtMeGMrcjY4ZjRMaGRMVitYeEkwTXdMU1pwZnFxRVRHV1ZkZmcvZC9x?=
 =?utf-8?B?Q0ppZWpQaWVtcERzd0swTVFZYkpLNnZBeFZwcVQxUmFWK3JBaHNuWWM4NWhy?=
 =?utf-8?B?SWpGOEJGQnJvbVExNmoybDFaendYdFlnZmxIWnBDdHl5U2RrZjJoNDRXQjVv?=
 =?utf-8?B?VjN6SmpiaWpSVjUrbzNnWFhHL01FWFYxQnRtay9xOUg4NjQ2ZmYzWDNTY1Br?=
 =?utf-8?B?T0lyWUFIa2VRV0xwb2hpU3E1d0hLbEVEaVJVK21Eamh6VEtCWXpSaWFHdDVM?=
 =?utf-8?B?MjRHaTh1MDJmcXlGWmh6OFUyUEE0MlVadnRQMHBMVk5KRnoybnJWSzBFQ0p4?=
 =?utf-8?B?WDg4RGxtUW1DTHhVcU0rcWZiUUV6Yi9PcStjWlBIVVJVd2hrbVFOSDJpN2Jy?=
 =?utf-8?B?UlZVazdJUVJpRnRiZU1lTUN1enNwUEhhTWthS3JBejhJWUNBUXBGVjJHQlM3?=
 =?utf-8?B?SWdlclZYZXFiR1hDbFp2cjkwc3hya1dINzJJLy85WDN0dkRNUXhVYTJJRlNN?=
 =?utf-8?B?QkpJQ2JaZ2VuSHdLUjVHNjFkT0pnc0c0bWo1V2VibndLdzBjdkpGalZocjNF?=
 =?utf-8?B?VmlNaDJMUUEzWTExWWRVRmh4blhXVWRTSFNoNXpvY3c0SDdQOEljM1BsSlB4?=
 =?utf-8?B?OGxLYUVrS0NqTXY4NmpvMEhaR0VXcC83d2d1TW43Y1BwcC84cmZGVlJJdWEv?=
 =?utf-8?B?VFlrUFdScGtHdE5DWmZBZDM4WGYxbUJJdStuYmQ4Rkc4MEFhTUxWUHo2T2Rs?=
 =?utf-8?B?ZFIxWGhkRDY1eXZmeGhmU09FcHNUQmIvSVRhVVE0eW1HQzdRblNWTXNUdDJ5?=
 =?utf-8?B?cnNEQzVXNDZ6TVJtMnFkRVA4QjN5R3VGc2tMSWV1UXJXb1hFV0hGbXpud1ZC?=
 =?utf-8?B?QjNxM2VDYzhZQitJaTRaTlNldGtGZ0FoTXFCNHBJN3hWelduN0RGdE1WTkJi?=
 =?utf-8?B?dTRyNm9uVkR6ejkzUFM1VDJESThzb0ZKdzFGcUlMbFowbEp1dEdUUWhOQlpP?=
 =?utf-8?B?aTF5QXF6NlRpTHQwL2lkV2Q4akQxcmUvYmVmZFBlTVp3WXJ6NmR5NkpoT1VM?=
 =?utf-8?B?b3ZzSWNFNWFEczJJRFYvN205QnBjcUxtWGdXUXo5dmlWTVo1eHlYNXFJRkNp?=
 =?utf-8?B?YTZ4OTVwdkFndjh0WDZZbG14ZjRaeUpjZE1lRkduS2ZySUhKa3I2UXZna2g2?=
 =?utf-8?B?YnFIVGtlQ3laZHMzSXp2SnVHUFBkM2dCby9HVkZ6MjQ2VG91QitVYVZmeWxS?=
 =?utf-8?B?VHhNdHVxeHQxME44UjB6a2ZCYlJwRFJWZFJ6Mk5xU1JQMHh3TGRDVndOSVha?=
 =?utf-8?B?YTRXT21ZYWFITHdQd2xjeElBS3haSStxZjJRdnE3bTUzK1Jqdk1qMllxRkRp?=
 =?utf-8?B?Mjh1Z0JyekhEREVwZDMwQzRSejQ3R1I5ckwwSFhOR0MxZXR1Y204NjJKK0F1?=
 =?utf-8?B?RWRicjJMR1MxRlg1ZWVpVDZ1VE5rVW5iOEhURU1PRG54OFp3Y0p4ZWRXbmp4?=
 =?utf-8?B?NnRiVlJSd3dEcDhTL3pvTDdDNXU3TGNxTnZSbTdVZGJTdm9QNE5wZkxUWWFR?=
 =?utf-8?B?bmVzUWVzOW5IaXdxTTF3UkNXWHlCWHMveUd2VE85NFMxSGxDR3pPajJoNmpI?=
 =?utf-8?B?SlFwcTlTSEJ6NFBEdm1aTTQrNnNRM1hYVkQzaEZrdXh6SXdEMTBzaTZsd1J5?=
 =?utf-8?Q?zxIJGf6GQWbjfo0UYXM4oE8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6335.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVVJaTdIMkovRFFNVVZUNmhQRmRVdTJwc3FNdjlxV2cxQkswQk16cFMwSksv?=
 =?utf-8?B?bW5EN21Ob08vOUVZajN2SVpJWk9UZktTSitVcnJkbHpWS0Z6V0t2NUNuemNw?=
 =?utf-8?B?MHlTRE9vSHQvWi9WY0o4VldwYVdlb2JHSlNlcHphZ25VQWNBcUpwbWRETFcy?=
 =?utf-8?B?TytpRmRZa3NuR0NsYjhVb1NaOUZJZC8xelgzSmd2ZVNVc3NEQloxcnh2cnBU?=
 =?utf-8?B?UGllcE9FM0FUTDEySjBuejlnYzhtRlFPR3k4UmMzdUlVbXdRNkxWdXNGSDRE?=
 =?utf-8?B?M0Z3cUIvdjI1QkxIcmJtbU5YYjU5VTQ4RVlNZWZqTk9rdGNVYkN4azhrZEk1?=
 =?utf-8?B?dk5FT1Y5bVpQNk5yanFxUWtpbzRsNTNSQ0lvc2xETGhlWDIyREQxNmN2dzIz?=
 =?utf-8?B?VlpxSU14UEY4WGNSMC92YUwxTTZSUWFoMUZYYngvMys0OVlQNGo5MXBJZFhP?=
 =?utf-8?B?WC9XQ2RqMW9hUU9ET3lXNGhnMVN1Q0xQYVd4VkNCaXErL29tSTlFbUtZM2c4?=
 =?utf-8?B?cUdOVWpGaUowN05sWkpTVHNlNEl6aWNOencvaFQ4T1N2MVhiYzRUdGdjUWZW?=
 =?utf-8?B?S1g5YU1UYVBCZzV1MHZ0aUpVWnlDL3h4b2lzVDB2S3JLRXpidzhkVXhSMmkr?=
 =?utf-8?B?OVZQVDV3WStHQ0V4Vk9wbHM0Q2phdDF6UllmRDJBbFNCNVVGOGY2V3Y0aFR6?=
 =?utf-8?B?WGNNNnA2VXlFbEZnZytTSHVZNVd6ckxBdld2OHh4R2hrVmVFaFMvWm5McDJw?=
 =?utf-8?B?S2IwNlg4VTM3bk5HS1pDWEVNTENjWTR3b25qb2F2RUpXTm8vRHlJdCtXWUpE?=
 =?utf-8?B?RlVra1pUS0ZEY0FFWW9ibWVzL0VOc21sZkMrVUlDMmRLeFdCcDdxbnBCRTRM?=
 =?utf-8?B?ZCtxbVErYUNkY1gwQ2cxODE4cjNTLzZwSEIvZEp5NW9nZDJwenphcllRaUhV?=
 =?utf-8?B?cGFzN3FrNGJCQUVraUc4VzIzM25panVNOWE2YzQ1aHNZNytpdmwzOGpYbGRX?=
 =?utf-8?B?L1VsOHdHS29PdDZBcW4zZVk1VGdZY1VnK2xMTWlOUFlJMFlWVnk5ZVg5TG5x?=
 =?utf-8?B?R0tOblU0NzZmTjNWcjZqZkR5MTlYaFhZR2ZoQjU2T0FnQWI2Y2hTTU91R1Vq?=
 =?utf-8?B?UWRvMjhnN2VWQmxKaExwS2Fwam1uWGd0T1VxR3ZjSC9QaTdCUVR0eStmMkpw?=
 =?utf-8?B?NTl3dnBnTjVMSEZKdlFYT3FJZHZkTFdVZ3g1elNNa01RbndDMFl5UFI2dytH?=
 =?utf-8?B?dDkvb2plUDhIUWVCbVduUkVHVThrb2o4VU05UjVtbDlveWhDOUxhSGI3OGwx?=
 =?utf-8?B?cHhqU2VlZUdqeCsvSks1bFJnWlRHdFVhQlUyazl4QlczOFYyVXhZV1VyWk9n?=
 =?utf-8?B?SlQxWm1xNlR0cDA2bVRVZnRqRVJFdnFsZmVBTnBCYVVtMmVzMVZuNUZSM2Nv?=
 =?utf-8?B?SVBZdVpmRG9NZUxEa0FLUHpWZUpyZkFEOHdNSHdDcXRCL04xTnhaeXF4Qjdq?=
 =?utf-8?B?ZjBZcGdjclFhdjBoZ0dWUTZNTGJqQkExemFmckhYYXhIaUREdDVKZU04ZDFr?=
 =?utf-8?B?aHZIRlZVSkpGVlJnWVVGRnlqUEl5amdvZ3Y1VFVZZ0ZkVnIzY1V5RTJNYm1Y?=
 =?utf-8?B?TEF4KzZ2L0EyMm9QbDFuNDR3NWxVM0s0UVhrNTB2ZzQyQWFJV0c2ejFtWkwr?=
 =?utf-8?B?YmNPUVZQa2tXdG9DNFF4RG9OUzZFc1Z6dFdVN2NCbTdKK0ZadkduL2t6eUFq?=
 =?utf-8?B?cEhLbDh6V1A2aEcxTlcwQ214dHhpQmxUL2lOOHVtTDNKa2oxamg2dTBPeWw0?=
 =?utf-8?B?UmNPVCsvR2pnRDRYYXh6QVhiWVBjSm00UnRsOVJuSmdqSzNMVDZCWnRhcGMr?=
 =?utf-8?B?V1lmUEZHWVVwRTN3UUJkOERtakNsOC9OOEk2WXphL0MxVFlWZjBYZlR1YmY4?=
 =?utf-8?B?NjRQWUZlMEsrWWxUMVN2VE45MTZYbitZejU0SlFaQzJWUWtzbEN2NW1uLzIv?=
 =?utf-8?B?aFoyY096VWtmUjZ4d3BDajZZMkZEaVVMbDdZUDNCU1hqS3MrNmVqZnNHOFVt?=
 =?utf-8?B?a3d4ZHFFYnp2UGdnTlp2ZUpPLzBOUVNpZXJiblRwRkRnZ2trVllFS3RSVlJX?=
 =?utf-8?B?TjZHVlMyQzVaYlNwNFJZUHN5cEdQWm4zMEtGdU5wWHlQNkpSbFpYSGp0bWps?=
 =?utf-8?B?WDhJNmkvMXJGQTlmL0loYXUzN3dIWEtMRFJ0WHNOMzNDKzNWUnlvZktLR0tF?=
 =?utf-8?B?SGNudTVUNzZJOUhhMXpZcE5nbi8vOURsek5uang5ZW4wZmxsbDd6SGJTcVNX?=
 =?utf-8?B?K21XS1RDaGwwNHU3WWJ6NlFqK1JIaDl2Mk02UlVEYXBiMlp2c2ZtUDlCSHlo?=
 =?utf-8?Q?hh5sje4MYATwwX+k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17726F5919032F41A7F99B0F69CF5797@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6335.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8df31a-8dca-49f5-7b73-08de58334439
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 14:50:34.4120 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stmXpB2g4Q5ybVAia+aY5+JlgV/+V41X6hipSECmFQjgp5xNnxxC26vUcGZibn6dBJcawsckZXkJeCOTop78h1iOdNS3oqSum9CJH6Ne9GM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5177
X-Mailman-Approved-At: Tue, 20 Jan 2026 17:15:29 +0100
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

T24gVHVlLCAyMDI2LTAxLTIwIGF0IDE1OjMyICswMTAwLCBNYXJlayBWYXN1dCB3cm90ZToKPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQo+IAo+IE9uIDEvMjAvMjYgMjo1MyBQ
TSwgSmFtaWUuR2liYm9uc0BtaWNyb2NoaXAuY29twqB3cm90ZToKPiA+IEhpIE1hcmVrLAo+ID4g
Cj4gPiBPbiBUdWUsIDIwMjYtMDEtMjAgYXQgMTE6NTggKzAxMDAsIE1hcmVrIFZhc3V0IHdyb3Rl
Ogo+ID4gPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW5sZXNzIHlvdQo+ID4gPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUKPiA+ID4gCj4g
PiA+IE9uIDEvMjAvMjYgMTE6NDUgQU0sIEphbWllLkdpYmJvbnNAbWljcm9jaGlwLmNvbcKgd3Jv
dGU6Cj4gPiA+IAo+ID4gPiBIZWxsbyBKYW1pZSwKPiA+ID4gCj4gPiA+ID4gPiAyNDg5wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVidWcoIiVzIGxvYWRlZCBhdCAweCUwOGx4Cj4g
PiA+ID4gPiBsZW49MHglMDhseFxuIiwKPiA+ID4gPiA+IDI0OTDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuYW1lLCBvdmxv
YWQsIG92bGVuKTsKPiA+ID4gPiA+IDI0OTHCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBvdiA9IG1hcF9zeXNtZW0ob3Zsb2FkLCBvdmxlbik7Cj4gPiA+ID4gPiAyNDkyCj4gPiA+ID4g
PiAyNDkzwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3Zjb3B5bGVuID0gQUxJR04o
ZmR0X3RvdGFsc2l6ZShvdiksCj4gPiA+ID4gPiBTWl80Syk7Cj4gPiA+ID4gPiAyNDk0wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3Zjb3B5ID0gbWVtYWxpZ24oOCwgb3Zjb3B5bGVu
KTsKPiA+ID4gPiA+IDI0OTXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIW92
Y29weSkgewo+ID4gPiA+ID4gMjQ5NsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBwcmludGYoImZhaWxlZCB0byBkdXBsaWNhdGUgRFRPCj4gPiA+ID4gPiBi
ZWZvcmUKPiA+ID4gPiA+IGFwcGxpY2F0aW9uXG4iKTsKPiA+ID4gPiA+IDI0OTfCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmR0X25vZmZzZXQgPSAtRU5P
TUVNOwo+ID4gPiA+ID4gMjQ5OMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBnb3RvIG91dDsKPiA+ID4gPiA+IDI0OTnCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB9Cj4gPiA+ID4gPiAyNTAwCj4gPiA+ID4gPiAyNTAxwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZXJyID0gZmR0X29wZW5faW50byhvdiwgb3Zjb3B5LAo+ID4gPiA+
ID4gb3Zjb3B5bGVuKTsKPiA+ID4gPiA+IDI1MDLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAoZXJyIDwgMCkgewo+ID4gPiA+ID4gMjUwM8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcmludGYoImZhaWxlZCBvbiBmZHRfb3Blbl9pbnRv
Cj4gPiA+ID4gPiBmb3IKPiA+ID4gPiA+IERUT1xuIik7Cj4gPiA+ID4gPiAKPiA+ID4gPiA+IFRo
aXMgaXMgd2hlcmUgaXQgZmFpbHMuIElzICRvdiBvciAkb3Zjb3B5IDQtYnl0ZSBhbGlnbmVkID8K
PiA+ID4gPiA+IEVuYWJsZQo+ID4gPiA+ID4gdGhlCj4gPiA+ID4gPiBkZWJ1ZygpIHByaW50IGF0
IHRoZSBiZWdpbm5pbmcgKG9yICNkZWZpbmUgREVCVUcgYXQgdGhlCj4gPiA+ID4gPiBiZWdpbm5p
bmcKPiA+ID4gPiA+IG9mCj4gPiA+ID4gPiB0aGlzIGZpbGUpIHRvIGZpbmQgb3V0Lgo+ID4gPiA+
ID4gCj4gPiA+ID4gPiBJZiAkb3YgaXMgNC1ieXRlIGFsaWduZWQsIHRyeSB0byBnZW5lcmF0ZSB5
b3VyIGZpdEltYWdlIHdpdGgKPiA+ID4gPiA+ICJta2ltYWdlCj4gPiA+ID4gPiAuLi4gLUUgLUIg
OCAuLi4iICwgZG9lcyB0aGF0IG1ha2UgYW55IGRpZmZlcmVuY2UgPwo+ID4gPiA+IAo+ID4gPiA+
IFRoYW5rIHlvdSBmb3IgeW91ciBzdWdnZXN0aW9ucy4KPiA+ID4gPiAKPiA+ID4gPiBJIGZvbGxv
d2VkIHlvdXIgYWR2aWNlIGFuZCBpbnZlc3RpZ2F0ZWQgdGhlIGFsaWdubWVudCBvZiB0aGUKPiA+
ID4gPiBvdmVybGF5Cj4gPiA+ID4gYnVmZmVyLiBUaGUgZXJyb3IgY29kZSByZXR1cm5lZCBieSBm
ZHRfb3Blbl9pbnRvIHdhcwo+ID4gPiA+IEZEVF9FUlJfQUxJR05NRU5UCj4gPiA+ID4gKC0xOSks
IGNvbmZpcm1pbmcgdGhhdCB0aGUgb3ZlcmxheSB3YXMgbm90IHN1ZmZpY2llbnRseSBhbGlnbmVk
Cj4gPiA+ID4gZm9yCj4gPiA+ID4gdGhlCj4gPiA+ID4gdXBkYXRlZCBsaWJmZHQuCj4gPiA+ID4g
Cj4gPiA+ID4gSSBtb2RpZmllZCBvdXIgQnVpbGRyb290IHBvc3QtaW1hZ2Uuc2ggc2NyaXB0IHRv
IGdlbmVyYXRlIHRoZQo+ID4gPiA+IEZJVAo+ID4gPiA+IGltYWdlCj4gPiA+ID4gdXNpbmcgdGhl
IHN1Z2dlc3RlZCBhcmd1bWVudHMuIFdpdGggdGhlIC1CIDggb3B0aW9uLCBhbGwgYmxvYnMKPiA+
ID4gPiBpbgo+ID4gPiA+IHRoZQo+ID4gPiA+IEZJVCBpbWFnZSBhcmUgbm93IDgtYnl0ZSBhbGln
bmVkLiBUaGlzIHJlc29sdmVkIHRoZSBhbGlnbm1lbnQKPiA+ID4gPiBlcnJvciwKPiA+ID4gPiBh
bmQgZGV2aWNlIHRyZWUgb3ZlcmxheXMgYXJlIG5vdyBhcHBsaWVkIHN1Y2Nlc3NmdWxseSBpbiBV
LQo+ID4gPiA+IEJvb3QuCj4gPiA+IAo+ID4gPiBCdXQgdGhpcyBpcyBub3QgdGhlIGZpeC4gV2hp
Y2ggcGFyYW1ldGVyIG9mIGZkdF9vcGVuX2ludG8oKSBpcwo+ID4gPiB1bmFsaWduZWQsIHRoZSBv
diBvciBvdmNvcHkgPwo+ID4gCj4gPiBvdiBpcyB1bmFsaWduZWQKPiBEb2VzIHRoaXMgaGVscCBl
dmVuIHdpdGhvdXQgdGhlIG1raW1hZ2UgLUIgOCA/Cj4gCj4gZGlmZiAtLWdpdCBhL2Jvb3QvaW1h
Z2UtZml0LmMgYi9ib290L2ltYWdlLWZpdC5jCj4gaW5kZXggMmQwNDBlMzhkOTcuLjQ5ZmRjMWYw
NTM1IDEwMDY0NAo+IC0tLSBhL2Jvb3QvaW1hZ2UtZml0LmMKPiArKysgYi9ib290L2ltYWdlLWZp
dC5jCj4gQEAgLTI0ODEsNyArMjQ4MSw3IEBAIGludCBib290X2dldF9mZHRfZml0KHN0cnVjdCBi
b290bV9oZWFkZXJzCj4gKmltYWdlcywKPiB1bG9uZyBhZGRyLAo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhZGRyLCAmdW5hbWUsICZ1Y29uZmlnLAo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhcmNoLCBJ
SF9UWVBFX0ZMQVREVCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgQk9PVFNUQUdFX0lEX0ZJVF9GRFRfU1RBUlQsCj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEZJVF9MT0FEX0lHTk9SRUQsICZvdmxvYWQsICZv
dmxlbik7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEZJ
VF9MT0FEX09QVElPTkFMX05PTl9aRVJPLCAmb3Zsb2FkLCAmb3ZsZW4pOwo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChvdl9ub2Zmc2V0IDwgMCkgewo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcmludGYoImxvYWQgb2YgJXMg
ZmFpbGVkXG4iLCB1bmFtZSk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNvbnRpbnVlOwpUaGlzIHNvbHV0aW9uIHJlbW92ZWQgdGhpcyBtaXNhbGln
bm1lbnQgaW4gb3YgYW5kIGFsbG93ZWQgdGhlIHN5c3RlbSB0bwpib290IC0gd2l0aG91dCBhbnkg
Y2hhbmdlL2FkZGl0aW9uYWwgYXJndW1lbnRzIHRvIG1raW1hZ2UuCgpUaGFua3MsCkphbWllCg==
