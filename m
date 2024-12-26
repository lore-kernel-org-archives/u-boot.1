Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1222BE77188
	for <u-boot@archiver.kernel.org>; Thu, 26 Dec 2024 03:34:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 832878036D;
	Thu, 26 Dec 2024 04:34:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4tFgvGnz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2364D80384; Thu, 26 Dec 2024 04:34:44 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B8B78036B
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 04:34:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bg3o3dbXyjmHEYNlVKKU7jBnESn6LexYvTvFbKxG7nbPVIjxQ8K7ntkQ/GX5LC/zXCo5giCPEHit+1HhahYR7V0wQXQNb7atJ/aF53awEvz93/0M8DAOf8vVmWweeSktmTIHgR/2s3KU5GcDAc0683eNnhd+BqhsQ6FjaTdR7bcCkzdxd7NFWO65kVeQ28Nevzdho9A9mBXRsq9uhV/D5G15eDT6fJv1g3hrwAMUyVJs37VBlMXSdS2IJfb0HMqRFDOEpCneaOx3EvfVJjnKp/V846vizrv/QE3JINH1OGdtreGGe6UBHYGQmDWbsKiJ2twkVBEqvR/S8D53bz8gIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtGZpRXLBoGhbHqeaCPLiozLt+pF13OG88795GBfp3Y=;
 b=evmm+GaY4lAerfSGZAtlxs8Ljv4GN2IKeEFLL38QEwK79kCJiJCf6GKAkcozbZQRx8dMqS3R1gZiiavssbmBo+2Dyqai1ctKET6+MvmUyW74TlqX5Vb32dqd6XuMKVsrIFETtrSiNW+SMB2EivHSaWqMt43MLVXtB885FUGYUCEudiG0cIsUtjiRh2Z/UVRjpH58s5mit3b6p5Hrp35AIPL56j/2NHuia3VerJbCk+9MD7aHrQPtuWa9/n9y1KqVrF8G7qmW9sFVWowUSZ5mdimS3c+hEck2wRBv1o4dVxfUEjmlIW5QGCrswPYzwrQlEg+q3FF8PNCbR24ykleSMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtGZpRXLBoGhbHqeaCPLiozLt+pF13OG88795GBfp3Y=;
 b=4tFgvGnzOZw40yNEeHVaBP/pcW4fNGbbDJINQKuQQojaxiEsQcXtm7c7sL3qaDH7GNwgit3d/95g9B2cGdRusihByKspQkaZuETlR68fOhSzGWvrthwR0FonrmEjecE0s3yy4S3+7LIMPDxjKBBoKhjtsYJyzNzoxEWd9DY5PLs=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Thu, 26 Dec
 2024 03:34:33 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%4]) with mapi id 15.20.8272.013; Thu, 26 Dec 2024
 03:34:33 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "tudor.ambarus@linaro.org"
 <tudor.ambarus@linaro.org>, "j-humphreys@ti.com" <j-humphreys@ti.com>
CC: "Simek, Michal" <michal.simek@amd.com>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>, "sjg@chromium.org"
 <sjg@chromium.org>, "william.zhang@broadcom.com"
 <william.zhang@broadcom.com>, "stefan_b@posteo.net" <stefan_b@posteo.net>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>,
 "p-mantena@ti.com" <p-mantena@ti.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v4] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
Thread-Topic: [PATCH v4] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
Thread-Index: AQHbVhnA6SaeFPNcj0aePpXMMDKww7L3cIkAgABwcvA=
Date: Thu, 26 Dec 2024 03:34:33 +0000
Message-ID: <SA1PR12MB86971E0E6A10C482A4F7568D980D2@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241224153707.2054421-1-venkatesh.abbarapu@amd.com>
 <2d8cc7c5-e389-4e18-8872-ba89783488cf@denx.de>
In-Reply-To: <2d8cc7c5-e389-4e18-8872-ba89783488cf@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|CH3PR12MB7571:EE_
x-ms-office365-filtering-correlation-id: b6f86df6-4b26-4299-11ff-08dd255e36ca
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VDBxYzRrUzJETXpZdEpReUdhcmZLUTUyVCtFVU85UGJzblNRRTZrL1plK2Jp?=
 =?utf-8?B?OVdyajQxZkMxMFFGQ0lkTGJEajlsTlkzVGswYVdkODJTUnpnTlpjYWUvZTRY?=
 =?utf-8?B?blhoTWpqVjFvQjRxVS83cDN3L3VpV0dCSFJkUnRYU0Q0VGNIWkR4OGRxM2lm?=
 =?utf-8?B?QUZxOWl4ZTdKMnJrb3o5OE45OXZpUHBCYWFhbkptWlRtbkp2N0IzUnB2aVFJ?=
 =?utf-8?B?LzU3dzJvVDNzb0dIZHUvUUlOUmVtMUpVS1Z5cWNIQm1lNWdycWkvbllCYVU4?=
 =?utf-8?B?Wm1CelpydS9FMWlZZk0rUFd2QVk2eW5kVGFaQmlQSGNMVFJaL2xNUEJYdEl0?=
 =?utf-8?B?SUgyY01ubGtud3B1c3FZQ1NhODJqR01tQ1haSi83Mk1TT25LZ2ZibEVKQmdy?=
 =?utf-8?B?ZmsrK2Uvd0FKbHRSeG1nbUg4a3lVb21VU3l4OTN4TjB4SWloNVVmQ0l1WHNt?=
 =?utf-8?B?c0NDVGpBaDNkcjEzU0YzNTBIcEE0cWFEVmh2bVdMNWF3Q3V3eWVrSHdCZ3Iz?=
 =?utf-8?B?NkVXUDBCU1kxWm5SR1lxNG9OU1pHZUJZTng2REV6OTlLWUFIdW8yNFYza3dB?=
 =?utf-8?B?eVNFbzFCejZwUzBxdDUvK0ZiR2ViMTE5Nit1UnNoQnppQmVycGJ6OEs1Z2xE?=
 =?utf-8?B?VkU2eGFRWTJ0M1JWVy9ZdDQvRFFtdVBjS3FSNEtTL3E5eitSMlJFemk1TEZC?=
 =?utf-8?B?aVNtOTVackFrM0d2UXRnbi9PTi9Zd3ZOZzNrekJBZE1wL2RnYTRkODFGa3Vu?=
 =?utf-8?B?bFUvYlc4Ym8xSnpKQTE0UkdMNWNTdFdYbDY1bzlDTFV4akhCMFl3UCsyL1Vh?=
 =?utf-8?B?a1lwSUhGbE5aRkl2Ni9Hd3BUM2xaYUZYelhzQTZMZ1E5L2FLdzFPWGhwdTVL?=
 =?utf-8?B?QzZUMUxIYWlIc1YxRHNwbmpKRkpjTW5vQjllei9idmRjRnl3ZU5yUks1Yjh1?=
 =?utf-8?B?L05FL3hqc1BGYjlsUGYvOElFNzQyTDJRbTBjWmgvV2hTY3kyV0F1K2NKckRU?=
 =?utf-8?B?VS9JUTRyRm1MZDRmbjFneDBKdVB5OHIvOWNEQXhoamxvSUxaSE94VmdhU1VU?=
 =?utf-8?B?WTM4Z0xkMGxHVFRxZTVuWXJDN3E1SUU3YUlQelBBVElCbGR0b1BOcUhjY2Mz?=
 =?utf-8?B?NnhtMGNydmRCNE5DcUt3TnVVU2pKTlVwa0xyMG5CakRVVFpSN1RRakxQMkw2?=
 =?utf-8?B?c1lvTGlCZ2x4azJCUVRjOEhVTG9oUGRpSFVHMmhHWG1COGZHRFd0NENPMllS?=
 =?utf-8?B?UFpHdGpmeW45UWNFdmV6anVYWWJuNk5YTEVYcEs1QjY5RGFuTmZHbFJYd0Ro?=
 =?utf-8?B?MjdGTkU1RlRtNHk5Rk9SR0dqMjhIYkRiallMek9tQzJHMGVHakFpUkVPWHBx?=
 =?utf-8?B?UXlwRlFyNUIzV25Fckh3Y21yOXp4Vm41MWFjajhjRlpzSlV5clc5TGM4Q0pT?=
 =?utf-8?B?U05OTFdlNzQ1emZOOUNSTEJreE5yaHFUaFZhZFoxK3R6TTNoYjEybEJSTWxT?=
 =?utf-8?B?VHhCd2FxVjBOUlJvb2V4NCtUQXlEQ3BwNTc3M01ZbXEwM2w2UkJWT3FObW5w?=
 =?utf-8?B?Ulo5Nm4zUldjWGp2bnNQOGR6SVF4VzNseFVlUEY5WXkzaWFPNXFtRnYrZjRS?=
 =?utf-8?B?cFVndGt0NllDaStoVjJVTHZaUmJoOWxIYlVpMkhlS3E2WVhEWjFzcjNBTG5M?=
 =?utf-8?B?QzZDdVpZRnZ1OHRySDhzUUNuU0s4ZzN0VnV0a0JEa21Gc1A0WEFGWmJ4RHdz?=
 =?utf-8?B?eERQRWhMUlBBVks1bXcyalhaMDN3V3NNaTdiQVJ1djZVdUNJNHhETE4wK1o1?=
 =?utf-8?B?Nzk4WVBRMUR0NWlwaU9nenY4UU1UZms2cEJpVGlxQmUzQUVnSUJKZkR0a0Mr?=
 =?utf-8?B?bmlWV2JqTGdHdVVMdm8xaWp4NzBTaS9IeithNWROZXNFSC8zSDFxdGprN1Bp?=
 =?utf-8?Q?W2JWNTNhe4CxCljoovlHtQVY5Q2Q9KT1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnRkcnM5eTMyNDhIbnV4b00xVzBYaHpFNUlhMUd5RlQ4bTVZeVM5SEZhSFpx?=
 =?utf-8?B?MmgvMHZ0alV5RytQbDFhdjdkbkRBd28yOTNnQXA2bkFrUGZ6dkJwTk95cEk4?=
 =?utf-8?B?dmJDUForc2Y0SVpXT2pFY0s4eXdkSXlOb1U0WUs3a3Z2ZXFaVVRxcHFsTlZv?=
 =?utf-8?B?bkxsU294VlpqNmhMQThpVXJwT1poZ3hDTDFsTjZ4K1QrWVFpL0RuR2twUU9W?=
 =?utf-8?B?dVFUWVdZcTRDSmlSZkFsU3BuMlRleXBoRVhpWXUyeUZHMXZDWmprMEMxZVFV?=
 =?utf-8?B?RVZrM3g5eVVDN0w5MU16RzBwU0xxbTNNaVFoSndoWExTSTVaQ2JCUFpNZHFC?=
 =?utf-8?B?Zy9KTzVOcitoOXY3dVI0UlVOaHlQRjdZUTlkcGkweFRCdVd2b0t1Ulo5U0s2?=
 =?utf-8?B?RHIxVTZSODlsZ3k0Y2g4TUJpelZlclBpd3ROZmdwVmVqRWZIT0wvQ2wvTGRz?=
 =?utf-8?B?M3BjSGtJaXRpaytrMXFYaTFwZlZ6RThVaUVaWEswRUlsdDlkMThTVzJaVmkr?=
 =?utf-8?B?eHNoN1VGTDNVaDRUeW8zcm5OYjczd3hkRWkxTWd4T21YUnBSME5YTjlLNlFv?=
 =?utf-8?B?ZjMzS2JzMFphdjl0c3pMSmhVU0hDR0tFRk9WMUsvOS9nV0Y4SzJROXJObCtM?=
 =?utf-8?B?WGRBMXlWZ2J5TnNLVFhiRkFxNFJwWTl2a2dlNTkzNlRIU2hDVFVZbTdtaGZL?=
 =?utf-8?B?WVA2Vm5tWWFLZkh5YzlyZkhIdVYwMEY0YVg3MEZUQ1lKTklQd3pZMDhCYzJu?=
 =?utf-8?B?QW1nN2VxalNrb3NWUzAyeWdYQ3ljQllsdVpuanQzTVNjNC9ZNjhIZGFaMzR2?=
 =?utf-8?B?QnJiU0NGWUdFdFFERVZFMjM4eDV2K3U5ekdzYmUzQVpSVGtieC9OYk9RUWJr?=
 =?utf-8?B?Q3RmYzZBckZKU0h1TDUva21tNkt1SHNMUFUybzJnN094VXRrVmlwdE1QN2JH?=
 =?utf-8?B?dzZGYjB0NXJSTkFJTXExU1pFbmQwTmt2bVQ3ZC80Y3BHVTlobmxjbklMSzZy?=
 =?utf-8?B?UUo5QnRpTUVyU01lR0tiaC9qNURRK3Y0NUp6ZDY5elNOZDYxRXIxS3BoUWcx?=
 =?utf-8?B?T3NGeHhvcTRhWVZCVS83RzhrYnlucFpkaFhuYVNOZW01LzA1MjBTRndGTlN4?=
 =?utf-8?B?Yi9aTXJlQXFRZmhSMTBSQzBiekdlY0ZZZG5YdlczcFBlbFk2eXNCYXpNeUZt?=
 =?utf-8?B?MVpLZGFrUjgzZ0ZySE5GODFsU3BDOGZneml1S2s2eXBqay9kNnFZRC9lS1kv?=
 =?utf-8?B?NHRzSHUrVzN3eGVDMlJBbVpGZGsvL2ZPK0hHOVVqWkpOblN5MkppQzZvRkxa?=
 =?utf-8?B?SkNoT0VEOVlibUhub3MzaXBsT0s2TVQyWXM0RzNUMm5TNFlNSi84VnlOaDNl?=
 =?utf-8?B?cTg5dSs5RDJ3bEFMK3RSaS9WZmoxalNKbUp5VFB2aW9UWmg0d2RDRG0wYXpx?=
 =?utf-8?B?d3NHUVZ6MGVlZXNsUFZ1ZGFRVjZoNHZVSDY0WWN6NEh4REJiQ2Q2OXpGM3lX?=
 =?utf-8?B?bW9XRFZ3TURoMDNnaWlCMjNld0FnZ25Vc0NTMVpTbnYxWnNNdUpmVHBJYnE2?=
 =?utf-8?B?cjdtbktxZCtmYnVvdHRDbXR1OW9tQnRCaWtEMytTU0Mvc1hyRlJoL1Zad1NF?=
 =?utf-8?B?eTBISXNkTHByamxiOGZFbGxoWmMvNFh6SlVKYlFYTE1SbDdZWHFHRkg5ZUp4?=
 =?utf-8?B?MDJtUm9TckdxR2EwRUErUi96UDFFTnM2c1JnbFd6bW93UEpXaUtrTEM2M2pt?=
 =?utf-8?B?dWlHU3YrcTUxQkhKY09aLzZuWGo3YTU0TWlMaWxleWNiYStDQUYxTVY0d01a?=
 =?utf-8?B?Wm9qeFNydFdvZVVyd2VzYzdaMnBiTjhBZUgveVNTODNEM2JhYkJXZUZuY3gx?=
 =?utf-8?B?c0JtVHFDL09lOHNrMWVFcVd4ajhodGMrbUcwdWd3MTZ3eG44VEpGbVA4YW1y?=
 =?utf-8?B?cTNOYW1vUTdnNVdoM3RVeHQ5Q3NUanJXb1pwRFFoN2M4cjdkcnRjOTRqS3Qw?=
 =?utf-8?B?SEhoWnVIWkJ5Q2ZoUlk5RjdMSjN2YmxXV0hSY1BIc1c1TmYxVXNKK1VkR1ZT?=
 =?utf-8?B?MUpiUXlSVUd6WlBIbzk1OFZxdCtoMXI0eVUremIzaGZrcld1QmI4NlFjMjdK?=
 =?utf-8?Q?ddBA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f86df6-4b26-4299-11ff-08dd255e36ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2024 03:34:33.2496 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7LqpQGbbKmN7j2G6hfRXDTi73OyoKDLzg/y+hbgFVTHknfN4tu03bLmT1OqKE4akjJxa4vaZtcTorb0YloeRSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsgVmFzdXQg
PG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAyNiwgMjAyNCAyOjE5
IEFNDQo+IFRvOiBBYmJhcmFwdSwgVmVua2F0ZXNoIDx2ZW5rYXRlc2guYWJiYXJhcHVAYW1kLmNv
bT47IHUtYm9vdEBsaXN0cy5kZW54LmRlOw0KPiB0dWRvci5hbWJhcnVzQGxpbmFyby5vcmc7IGot
aHVtcGhyZXlzQHRpLmNvbQ0KPiBDYzogU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5j
b20+OyBqYWdhbkBhbWFydWxhc29sdXRpb25zLmNvbTsNCj4gdmlnbmVzaHJAdGkuY29tOyB1LWt1
bWFyMUB0aS5jb207IHRyaW5pQGtvbnN1bGtvLmNvbTsgc2VhbmdhMkBnbWFpbC5jb207DQo+IGNh
bGViLmNvbm5vbGx5QGxpbmFyby5vcmc7IHNqZ0BjaHJvbWl1bS5vcmc7IHdpbGxpYW0uemhhbmdA
YnJvYWRjb20uY29tOw0KPiBzdGVmYW5fYkBwb3N0ZW8ubmV0OyBxdWVudGluLnNjaHVsekBjaGVy
cnkuZGU7IFRha2FoaXJvLkt1d2Fub0BpbmZpbmVvbi5jb207DQo+IHAtbWFudGVuYUB0aS5jb207
IGdpdCAoQU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0
XSBtdGQ6IHNwaS1ub3I6IEZpeCB0aGUgc3BpX25vcl9yZWFkKCkgd2hlbiBjb25maWcNCj4gU1BJ
X1NUQUNLRURfUEFSQUxMRUwgaXMgZW5hYmxlZA0KPiANCj4gT24gMTIvMjQvMjQgNDozNyBQTSwg
VmVua2F0ZXNoIFlhZGF2IEFiYmFyYXB1IHdyb3RlOg0KPiANCj4gWy4uLl0NCj4gDQo+ID4gQEAg
LTE1OTMsMTggKzE1OTYsMjIgQEAgc3RhdGljIGludCBzcGlfbm9yX3JlYWQoc3RydWN0IG10ZF9p
bmZvICptdGQsIGxvZmZfdA0KPiBmcm9tLCBzaXplX3QgbGVuLA0KPiA+ICAgCX0NCj4gPg0KPiA+
ICAgCXdoaWxlIChsZW4pIHsNCj4gPiAtCQliYW5rID0gKHUzMilmcm9tIC8gU1pfMTZNOw0KPiA+
IC0JCWlmIChub3ItPmZsYWdzICYgU05PUl9GX0hBU19QQVJBTExFTCkNCj4gPiAtCQkJYmFuayAv
PSAyOw0KPiA+ICsJCXJlYWRfbGVuID0gbGVuOw0KPiA+ICsJCW9mZnNldCA9IGZyb207DQo+ID4N
Cj4gPiAtCQlyZW1fYmFua19sZW4gPSBTWl8xNk0gKiAoYmFuayArIDEpOw0KPiA+IC0JCWlmIChu
b3ItPmZsYWdzICYgU05PUl9GX0hBU19QQVJBTExFTCkNCj4gPiAtCQkJcmVtX2JhbmtfbGVuICo9
IDI7DQo+ID4gLQkJcmVtX2JhbmtfbGVuIC09IGZyb207DQo+ID4gKwkJaWYgKENPTkZJR19JU19F
TkFCTEVEKFNQSV9GTEFTSF9CQVIpKSB7DQo+ID4gKwkJCWJhbmsgPSAodTMyKWZyb20gLyBTWl8x
Nk07DQo+ID4gKwkJCWlmIChub3ItPmZsYWdzICYgU05PUl9GX0hBU19QQVJBTExFTCkNCj4gPiAr
CQkJCWJhbmsgLz0gMjsNCj4gSXMgdGhpcyBjb2RlIHdoaWNoIG9wZXJhdGVzIG9uIChub3ItPmZs
YWdzICYgU05PUl9GX0hBU19QQVJBTExFTCkgcmVhbGx5DQo+IHN1cHBvc2VkIHRvIGJlIGVuYWJs
ZWQgaWYgKENPTkZJR19JU19FTkFCTEVEKFNQSV9GTEFTSF9CQVIpKSBpcyBTRVQgb3INCj4gaW5z
dGVhZCBpZiBTVEFDS0VEX1BBUkFMTEVMIHN5bWJvbCBpcyBTRVQgPw0KDQpUaGUgRkxBU0hfQkFS
IGFuZCBTVEFDS0VEX1BBUkFMTEVMIGNvbmZpZ3MgYXJlIGluZGVwZW5kZW50LiBUaGV5IHdvbid0
IGRlcGVuZCBvbiBlYWNoIG90aGVyLg0KDQpUaGFua3MNClZlbmthdGVzaA0K
