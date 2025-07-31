Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6A5C87FCC
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 11:43:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16DDC83824;
	Thu, 31 Jul 2025 13:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="qXsjuVRv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78A6B83858; Thu, 31 Jul 2025 13:43:33 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2072c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::72c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6155683816
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 13:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7SSKorlUvX75hwJaSeIw6ueRfOzga8PeF0yq3FtDgSQFHi3YNGYc8nyucmzpt+Wzq9+4FKZ8GaYZpS0pLF+Hvit4UoByUYKY6mBZ6KRpUP4uwZscYeM1QzQsh3F1xJdHqhekBwaiVHEaGPMh1GLneGzpIzK5tTwpcWKOvs1+wfXkiZnMvsVOMZUEJZj7Riyf5lRiUiNJak2ayKosaz1Nw9HE8gKDFGDf0gWy1aCyjk1sfNvMzXOF1jz49k/hRxQiHv6coRcCIHmkb4PvV/w68QvlU/c3UHeECO1BNNmN9hs8I9rUqbVMb+4b4XIVZw+qK7BZ7Yv3oYlY941GYa0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7G4wOx+yIbJiOaG2Rsof99x3kKcYtHxWpfsraQhELc=;
 b=dpuEebPGx2ez/i4g74AN07uY0H4iCmUR8TCVX5gPQ3+1TPjalhgjVSTpEwMRWDAT7gq33hEKIrwl5/3LDQThOrqJ3pec1fUwecr3B/cOps9/nvB6uom7z5cSqX8YdB/qG7xF7vFA+xQdAdMqOD093sXuNn49V24u049u33vH1QeJwW7/lPlvPz8vqT6bp3XotrzV4KroeFeLYmou+CzXc79O7gNOC23UyR6+wvbF3XeksvGGnPI9n2wzZmezSYuyVXGmCkSyJrSpCBA8ZtOCGwIFxsehLzqk7u/HRJ4AUog1iHuXZ4EwUMZ616oDLto54r7f2i0IwQR06l2+MUyduQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7G4wOx+yIbJiOaG2Rsof99x3kKcYtHxWpfsraQhELc=;
 b=qXsjuVRvH9SDkhN6Lvx+Tjr1sI5ouUs3Jt00/MYeXtmmtUbogr4Z8CsoOo4t5Ee84FCOI34RaascbctwDYIDs3JMEW+dI5wKGNs0CC1bUWJ/eVLUN+NYkczCeiVKebZsTh6uLXpDUnc0XA5zbtxhVStm1q5yk8MCePmMgbwbI3Qe9mrezfPwv6UAz8fpxKM2+6S7xFj2sJUIGKWO7fxgNOc8nIPig+j0R8TUAdW/poJj5AnuvxreXknSRrzzprBlf0aIomRiUU8Mz3U2y4qtEEZmTT311gaDLjbMaszIST273EFlmnpCMF1E+R1g9CuM1Yrh6zEafrgvzcFIKgxNYQ==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by PR3P195MB0649.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Thu, 31 Jul
 2025 11:43:29 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%5]) with mapi id 15.20.8964.029; Thu, 31 Jul 2025
 11:43:29 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Aristo Chen <jj251510319013@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "trini@konsulko.com" <trini@konsulko.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>,
 "al.kochet@gmail.com" <al.kochet@gmail.com>, "paul.henrys_ext@softathome.com"
 <paul.henrys_ext@softathome.com>, "bb@ti.com" <bb@ti.com>, Wadim Egorov
 <W.Egorov@phytec.de>, "francesco.dolcini@toradex.com"
 <francesco.dolcini@toradex.com>, Garrett Giordano <ggiordano@phytec.com>,
 "n-francis@ti.com" <n-francis@ti.com>, "afd@ti.com" <afd@ti.com>, Daniel
 Schultz <D.Schultz@phytec.de>, "d-gole@ti.com" <d-gole@ti.com>,
 "ravi@prevas.dk" <ravi@prevas.dk>, "carlos.lopezr4096@gmail.com"
 <carlos.lopezr4096@gmail.com>, Aristo Chen <aristo.chen@canonical.com>
Subject: Re: [PATCH v1 4/5] tools: mkimage: detect overlapping load regions in
 FIT configurations
Thread-Topic: [PATCH v1 4/5] tools: mkimage: detect overlapping load regions
 in FIT configurations
Thread-Index: AQHcAIeAhTbWTG0M9UOIbWqqIoJXA7RMH5oA
Date: Thu, 31 Jul 2025 11:43:29 +0000
Message-ID: <cec9682a3821dc6d0c95ad0fbe91106e2fde4923.camel@phytec.de>
References: <20250729125022.4220-1-aristo.chen@canonical.com>
 <20250729125022.4220-5-aristo.chen@canonical.com>
In-Reply-To: <20250729125022.4220-5-aristo.chen@canonical.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|PR3P195MB0649:EE_
x-ms-office365-filtering-correlation-id: 49c657d7-f800-4423-d40d-08ddd0277815
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?UUpwWlFCZXZTRHNrUVp3ZWN6ek1CaEVYbWNwY0tScXhwNDBwaFJMS1NJN0I4?=
 =?utf-8?B?TENBbUhBSFlYdU9vak9HcjNTakNPVlNmaExqNXBVSzN3eUw1dmpYdlhUYXNE?=
 =?utf-8?B?TGlPci9FSkw3ODZtaFBDQysvYWlPOE9kUWcyWWRHVElQL3VGOFFnRTk1WDVp?=
 =?utf-8?B?dlZ1THR4UHVjZW9pOG9aa3hicm1mcE1TRmNwUzljUW0wUitOVzN3Uko0Q29y?=
 =?utf-8?B?cFBwTE1sZ1lITVlkVHVZQUpIak1Udkk5NHVXbGVSUmc2bnNFa0dqM1dBR1Nv?=
 =?utf-8?B?SXFMbnV5QzltdEhQOWs3aVVIYnJUVkRsSkcxbVpJZnJwTFo0OWFTV2VKeHZ4?=
 =?utf-8?B?YkRoSjhYd1M3K3VPNWF2WDJiTXYzTVRzZlp0WWVOa1ZMMVd5OTZZYjZSTllr?=
 =?utf-8?B?cGxIYmdmbHpqUW1XT0R3TDc0N2tTRmUvMzVua0NZOWRJT04wUXhsbi94eE1v?=
 =?utf-8?B?dlh0c1VUUllMT1dueTNSdWlLdXJBT0cwVkkrTVdKejlZRXhXRlp0M1hJMHQ0?=
 =?utf-8?B?aHZaWVdUQUo3aHZWTzhCbHc2QkJrekkrQW9BWUJ3Wi9semYzcmt2ZytPKzBE?=
 =?utf-8?B?YU0zbDhYNDNMYkVUOEVuY2UvR0dacmRrQ08rdkdwVDg3aUdlazNGblhCcG8v?=
 =?utf-8?B?R2I0OHpUV2UwSXFYa1d2amV2TWIxZ2ZQV21WQTJZYnpCZXN6MFNBVHEvQzZ6?=
 =?utf-8?B?dFVYWUdUNXBVcUhpK0pHNmhxZHdrNUc3UnJBODRoZjF4SG16eDJmcU85N1hH?=
 =?utf-8?B?Sjg2c00xVHdKWHZHOVFlODhDdllDemZmQmZ0b05VclJCaDB1UHg4clRtWlly?=
 =?utf-8?B?emlmV2lPK0hMUytGK1AyOHZoSzB6NERINFdvamlhb1U0RlNkbEpuV3g3RTdP?=
 =?utf-8?B?VHd6ZnZ6aUZ5b1hpN1UwbWtjUzR5Z2ZtSTZRNTc5SFpNNkhEUjF2R3NBK2Ez?=
 =?utf-8?B?U2tVdzgyblZlWVI2S04rYi9xQnFuWHc3SkYxcFhOMzNYQlRIdTllUnhndnUv?=
 =?utf-8?B?ZzRGelI1SDcvNXFDYnZpTzFRNUFMOGt1a1dyVlVxODZEUEwwSTQ2dlk4Q2hq?=
 =?utf-8?B?TWl4TTQrNjVXTUJpUTFQajZrNGEzdEV6VVFJZm5sdGp5ZU1nL1h4UU1qZHdL?=
 =?utf-8?B?TUFJdk5zZmJaNThaNFMxRjBaekM3SWV5OHpxeW5nNmc4R0RYSHJiVmU3ZnZu?=
 =?utf-8?B?VTRIQUowL3NSSjFLT2hRcDhNYzVDTlFHaXdjSEZuVy95Q2VJVDRKZW9DdDJh?=
 =?utf-8?B?NjhMSkVxeklnZU91T00ydEJIV2h5OE9Nc1IrdFAvcUJ1SERHSDRDUkpRU3Bh?=
 =?utf-8?B?SDV0VG1HV1F6RDJNSThoazQ1U3Z6UUJYcFowYjRWb0FoS0M2RDBjNGhsUldT?=
 =?utf-8?B?TU1oQnF0UExzMVRwN09WNWt2T3NWNmJRM1g0dDVuTWRJT0hST0V0SjdCZy9z?=
 =?utf-8?B?T2Z6Uk9DUnEyMS9ieHFjMUR1bDlYS3pvVEc0RXBTb1k3VW5GV1pmdHFCc0Vy?=
 =?utf-8?B?bkVPUklLbVBDMjFrSGtJTEMwQ0djUlIyMHAya2g1TURTSzM5ME9BMHIyMHFr?=
 =?utf-8?B?a1RETkxSaS9jMFZSUWF4dzJuakNUNlBua09NRXJJa3AyM1dXN0tzQzRFUW5m?=
 =?utf-8?B?b084enVSY2tiVGcrbmp2dDV6Umo5WTNLRlhlL21lMXRKZ1c4TUoxM3h0RmRK?=
 =?utf-8?B?d0lqTGtJTzlsMWtsak84eVc3cGtwb2hVMTgwYkY4NkdmM2pXZmZwWTdqVWEv?=
 =?utf-8?B?UGxXajdhNXRwTlBhS0ptUEx3Z0pCb2FQSExqYTFLMWtFKzRpdlEvbGYzb0xm?=
 =?utf-8?B?clZnOTRFZDFDQkZvM09QdFRxdnkrOG13MGhLRlJIdmhPSTUyeTNmeXUvKzNG?=
 =?utf-8?B?cmpPcHlDWUZtSzErbFFKdHkvNTJnOE1PMm9adjNuSlRzTjN3R2Y5TVhRK0p4?=
 =?utf-8?B?SlJWdFhLZndMdkc2SHZDSU5CcWMrazFPK05lQ0hpa2RtMFkzeGw0RkkrVWQ2?=
 =?utf-8?B?YTNEbFF0S3BRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTVCNEdUYjVYbzNoTmlZcVdPMWRMM1F4MlR4WVEyU2ovbFdRTDFwY0RNRWJR?=
 =?utf-8?B?S3dsYllsZXh4djcwT2JoYTlidDZ3U2h1R210bFdIUURJOXExRCtRNkxoc1BD?=
 =?utf-8?B?ODR0S3Z6bjNsd3JiTnNOZGhDRjh6NkVCMXphMUFGTXdVSnRrMVRsbGZOZFJz?=
 =?utf-8?B?SHlrUVF5dzN4bnV5T1VaSWVreE10NGx4dWp6dlFhUUszbkhJRDhkYVhrMWZz?=
 =?utf-8?B?Zmk1R2N5UHloam9JdUZ6Qmhadko0VmEwWDhzNEg1eXo3Mk8yb0toMExiaFM4?=
 =?utf-8?B?Y2dkN080MDNGUFBYZk1KN0pIRHVXdVhISDlqU3NrcjN4OXRTTjdBRzNrL084?=
 =?utf-8?B?b2d5WXl2T2MwZWVXVStaZGE1RkN1VFV3VWZ4OFpwc0p5Um5VSWVEUVpoOHpK?=
 =?utf-8?B?T2dyaUZodzR0R003ZmNOeVRoWUxlc3loVFpqRFdza3RTcDZBR25zTVRBNnFB?=
 =?utf-8?B?cFpXWFVTa1NtemNIT3hWem1hOWdZVnhkbFE0VldxYVRoYndzZjRjb1hvVk84?=
 =?utf-8?B?U1NtMUFDNDd0a1hnUFFkdi84aGRER1NCaGJmU3p0am1vSFJoM04yTklYN1F6?=
 =?utf-8?B?dHRpWUltMnlkSVFiS2hNdEdYNTVoYm5ydjlBKzNOUUR3MXcyZlBQcHVlVnV2?=
 =?utf-8?B?Sy9hdEJKMEFDbXJCTFFBenNoMktzeU9mMlVkZ2tDUEpvYzFjQm9Bb1lTOUNR?=
 =?utf-8?B?amt0djNKdURoYnZCYS9BbE1xZE1sV255ekN2anlXVnU1b2hQMVpLT09NdlhP?=
 =?utf-8?B?bXFlQ2hybnpHUmtVT2g0b2JjK2Z4dXBpblV5THZRMEkvV0ZnSVdrRXlObjVE?=
 =?utf-8?B?VVBRSTV1US8zZHhrc2hkWkJQZTM5YTAwM2JrZWRIem9pOTdrZkUvckVTK1FP?=
 =?utf-8?B?d1hWUENsZC9kLzltdjJlenNzbm52cjQyVXFCNFoya1NZTW5KdDdPZW82VWds?=
 =?utf-8?B?UFN6clRzdkF0c0VmSkVNNXJTb3d5b0MvKzdqc1hHbklzaEh5dWlIV25JWll3?=
 =?utf-8?B?Y2F6S0F3MHRtcFJWT2N5Zk4zNnZHN1piKzRuZXdTZjNHYUNLSkF6b0NKUGxR?=
 =?utf-8?B?b1JLcUF1alBOL0J1aFhnbG1XaVI0MHNMczU2L2p1VVkrUHRqRnVRS3N3U0dS?=
 =?utf-8?B?Vjlscmg3MTJwbEpiMnBNN2dTU1VEcHZCWnpxTVJabFVhelNYZitOQWFMODIw?=
 =?utf-8?B?bmIxRWdwQmFkOEJmQ09DMCt2SENrQmovWW9EbWhpV2FtbWlsN1JnVWNJNEN4?=
 =?utf-8?B?R3VIY1NjMTZrWkNXemw3NE4zNzY0Sk1LejNJY1lEeHBmenhSU2Z0bEcycFYx?=
 =?utf-8?B?SHIwWllqTCt4V3JaTVhVNGNLTkhCR3paQlJhbFFHREdOYWp1RTdvUlpqc1kz?=
 =?utf-8?B?MUxkc2NDR0M3dUt5UXcwSGtEeEtvdGlzWkR6NGxrbHlKWWQ2TXFlOUlRblZt?=
 =?utf-8?B?S0g4RnNPQTJQUEFzb0hqNmFaNXpFQWJyU0pyS3JtSFJUamU1MW5KVC9UdDd0?=
 =?utf-8?B?ZCt3dGRDU1hXOW94QVU0UERxcWxxcE9LNVFrYm94RzF5RkRtcnhFTjF1MWJJ?=
 =?utf-8?B?WGxFbFdkckFKc2lvTjV2ZWlwb0psR0dIblJLVUNUNUVCcFd6bHQ2VDFDWDBm?=
 =?utf-8?B?TENuNjhLTmFlRGJZMUpnay9LWFdjU3k5aGhFTEEwQ2VsRXN2MkZVT1JwV2hz?=
 =?utf-8?B?VTdIU09CajE4SmQrLy93bU5uS1ZzMjJldFRtWGM4WWxqYngvTHhkaUgvd0ZZ?=
 =?utf-8?B?WWl0QllvejY3dE41djlKYTNKU2tsR1ZKY3JhOUk4OWN0VFdoY3hnVmJjMW13?=
 =?utf-8?B?VlZFNnFDWUROYWowU1NMU2RoYXJ3SmRNSjVHNFBLN0xmY0t5SlJndDZTWGNR?=
 =?utf-8?B?eXUyNnBoZHpqSnFQUk96VHRLaUlEL0VNaEFqL2RBQTdISTRmOGh3elFNTHhj?=
 =?utf-8?B?Y1dPUTlIUVYrbWdVeFo4NUFCUUFPRFF5S0kza1JRcEV5N0RVbDNYSXR3ekw1?=
 =?utf-8?B?czlEZHNlOTc3UWlucVFmL2U2OCtUSFFBVEl2ZXcwV1VWanhkTmJyZm80dHd3?=
 =?utf-8?B?UmpGcFpMMjBBVGVycE5TYmpYS3l3emF6RklROHVvMmZraEZjcHQwVWEzd3Jy?=
 =?utf-8?Q?GNto=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFDD59587CC9EF49BCD2169E8D8E3A03@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c657d7-f800-4423-d40d-08ddd0277815
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 11:43:29.3102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5qTFllvbiGxNW7l9a9+g1wt0sdNXkWKRj1BSZb8fHc8sLPJ8nwaTcVxXcJ6XprcgU+DornWl9quJe+KIkgTddg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0649
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

QW0gRGllbnN0YWcsIGRlbSAyOS4wNy4yMDI1IHVtIDEyOjQ4ICswMDAwIHNjaHJpZWIgQXJpc3Rv
IENoZW46Cj4gVGhpcyBwYXRjaCBhZGRzIGEgdmFsaWRhdGlvbiBzdGVwIGluIG1raW1hZ2UgdG8g
ZGV0ZWN0IG1lbW9yeSByZWdpb24KPiBvdmVybGFwcyBiZXR3ZWVuIGltYWdlcyBzcGVjaWZpZWQg
aW4gdGhlIHNhbWUgY29uZmlndXJhdGlvbiBvZiBhCj4gRklUIGltYWdlLiBJZiBhbnkgb3Zlcmxh
cHMgYXJlIGZvdW5kLCB0aGUgdG9vbCBwcmludHMgYW4gZXJyb3IgYW5kCj4gYWJvcnRzIHRoZSBi
dWlsZC4KPiAKPiBUaGlzIGhlbHBzIHByZXZlbnQgcnVudGltZSBtZW1vcnkgY29ycnVwdGlvbiBj
YXVzZWQgYnkgY29uZmxpY3RpbmcKPiBsb2FkIGFkZHJlc3NlcyBiZXR3ZWVuIGltYWdlcy4KPiAK
PiBTaWduZWQtb2ZmLWJ5OiBBcmlzdG8gQ2hlbiA8YXJpc3RvLmNoZW5AY2Fub25pY2FsLmNvbT4K
PiAtLS0KPiDCoHRvb2xzL2ZpdF9pbWFnZS5jIHwgNzggKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysKPiDCoHRvb2xzL21raW1hZ2UuY8KgwqAgfMKgIDMgKy0K
PiDCoDIgZmlsZXMgY2hhbmdlZCwgODAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+
IGRpZmYgLS1naXQgYS90b29scy9maXRfaW1hZ2UuYyBiL3Rvb2xzL2ZpdF9pbWFnZS5jCj4gaW5k
ZXggMzMxYmU1YWU3MWQuLmQwMDYxYWRmMDUxIDEwMDY0NAo+IC0tLSBhL3Rvb2xzL2ZpdF9pbWFn
ZS5jCj4gKysrIGIvdG9vbHMvZml0X2ltYWdlLmMKPiBAQCAtMjIsNiArMjIsMjIgQEAKPiDCoCNp
bmNsdWRlIDx2ZXJzaW9uLmg+Cj4gwqAjaW5jbHVkZSA8dS1ib290L2NyYy5oPgo+IMKgCj4gKyNk
ZWZpbmUgTUFYX0lNQUdFU19QRVJfQ09ORklHIDE2CgpIb3cgZGlkIHlvdSBnZXQgdGhpcyBudW1i
ZXI/CgpJZiB0aGlzIGlzIGFyYml0cmFyeSwgYWRkIHRvIHRoZSBlcnJvciBtZXNzYWdlIGJlbG93
IHRoYXQgaWYgc29tZW9uZSBuZWVkcyBtb3JlCmltYWdlcywgdGhleSBjYW4gaW5jcmVhc2UgdGhl
IHNpemUuCgo+ICsKPiArc3RydWN0IGZpdF9yZWdpb24gewo+ICsJdWxvbmcgbG9hZDsKPiArCXVs
b25nIHNpemU7Cj4gKwljb25zdCBjaGFyICpuYW1lOwo+ICt9Owo+ICsKPiArc3RhdGljIGludCBy
ZWdpb25zX292ZXJsYXAoc3RydWN0IGZpdF9yZWdpb24gKmEsIHN0cnVjdCBmaXRfcmVnaW9uICpi
KQoKTml0OiBjYW4geW91IGNvbnN0aWZ5IHRoZXNlPwoKPiArewo+ICsJdWxvbmcgYV9lbmQgPSBh
LT5sb2FkICsgYS0+c2l6ZTsKPiArCXVsb25nIGJfZW5kID0gYi0+bG9hZCArIGItPnNpemU7Cj4g
Kwo+ICsJcmV0dXJuICEoYV9lbmQgPD0gYi0+bG9hZCB8fCBiX2VuZCA8PSBhLT5sb2FkKTsKPiAr
fQo+ICsKPiDCoHN0YXRpYyBzdHJ1Y3QgbGVnYWN5X2ltZ19oZHIgaGVhZGVyOwo+IMKgCj4gwqBz
dGF0aWMgaW50IGZpdF9lc3RpbWF0ZV9oYXNoX3NpZ19zaXplKHN0cnVjdCBpbWFnZV90b29sX3Bh
cmFtcyAqcGFyYW1zLCBjb25zdAo+IGNoYXIgKmZuYW1lKQo+IEBAIC03NzUsNiArNzkxLDggQEAg
c3RhdGljIGludCBmaXRfaW1wb3J0X2RhdGEoc3RydWN0IGltYWdlX3Rvb2xfcGFyYW1zCj4gKnBh
cmFtcywgY29uc3QgY2hhciAqZm5hbWUpCj4gwqAJfQo+IMKgCj4gwqAJZmR0X2Zvcl9lYWNoX3N1
Ym5vZGUobm9kZSwgZmR0LCBjb25mcykgewo+ICsJCXN0cnVjdCBmaXRfcmVnaW9uIHJlZ2lvbnNb
TUFYX0lNQUdFU19QRVJfQ09ORklHXTsKCmluaXQgdG8gezB9PwoKPiArCQlpbnQgaW1nX2NvdW50
ID0gMDsKCk5pdDogdXNlIHVuc2lnbmVkCgo+IMKgCQljb25zdCBjaGFyICpjb25mX25hbWUgPSBm
ZHRfZ2V0X25hbWUoZmR0LCBub2RlLCBOVUxMKTsKPiDCoAo+IMKgCQlmb3IgKGludCBpID0gMDsg
aSA8IEFSUkFZX1NJWkUocHJvcHMpOyBpKyspIHsKPiBAQCAtNzk4LDYgKzgxNiw2NiBAQCBzdGF0
aWMgaW50IGZpdF9pbXBvcnRfZGF0YShzdHJ1Y3QgaW1hZ2VfdG9vbF9wYXJhbXMKPiAqcGFyYW1z
LCBjb25zdCBjaGFyICpmbmFtZSkKPiDCoAkJCQkJcmV0ID0gRkRUX0VSUl9OT1RGT1VORDsKPiDC
oAkJCQkJZ290byBlcnJfbXVubWFwOwo+IMKgCQkJCX0KPiArCj4gKwkJCQl1bG9uZyBpbWdfbG9h
ZCA9IDA7Cj4gKwkJCQlpbnQgaW1nX3NpemUgPSAwOwo+ICsKPiArCQkJCWlmIChmaXRfaW1hZ2Vf
Z2V0X2xvYWQoZmR0LCBpbWcsICZpbWdfbG9hZCkpCj4gewo+ICsJCQkJCWZwcmludGYoc3RkZXJy
LAo+ICsJCQkJCQkiV2FybmluZzogbm90IGFibGUgdG8gZ2V0Cj4gYGxvYWRgIG9mIG5vZGUgJyVz
J1xuIiwKPiArCQkJCQkJaW1nX25hbWUpOwo+ICsJCQkJCS8vIFNraXAgY2hlY2tpbmcgdGhlIGNv
bXBvbmVudHMgdGhhdAo+IGRvIG5vdCBoYXZlIGEKPiArCQkJCQkvLyBkZWZpbml0aW9uIGZvciBg
bG9hZGAKPiArCQkJCQljb250aW51ZTsKPiArCQkJCX0KPiArCQkJCWNvbnN0IGNoYXIgKmltZ19k
YXRhID0gZmR0X2dldHByb3AoZmR0LCBpbWcsCj4gKwkJCQkJCQkJwqDCoAo+IEZJVF9EQVRBX1BS
T1AsCj4gKwkJCQkJCQkJwqDCoAo+ICZpbWdfc2l6ZSk7Cj4gKwo+ICsJCQkJaWYgKCFpbWdfZGF0
YSB8fCBpbWdfc2l6ZSA9PSAwKQoKYmUgY29uc2lzdGVudCwgdXNlICFpbWdfc2l6ZQoKPiArCQkJ
CQljb250aW51ZTsKPiArCj4gKwkJCQkvLyBDaGVjayBpZiB3ZSd2ZSBhbHJlYWR5IGFkZGVkIHRo
aXMgaW1hZ2UgdG8KPiBhdm9pZCBkdXBsaWNhdGVzCj4gKwkJCQlib29sIGFscmVhZHlfYWRkZWQg
PSBmYWxzZTsKPiArCj4gKwkJCQlmb3IgKGludCBrID0gMDsgayA8IGltZ19jb3VudDsgaysrKSB7
Cj4gKwkJCQkJaWYgKHN0cmNtcChyZWdpb25zW2tdLm5hbWUsIGltZ19uYW1lKQo+ID09IDApIHsK
CnNhbWUgaGVyZSwgIXN0cmNtcCBzaG91bGQgZG8sIHJpZ2h0PwoKPiArCQkJCQkJYWxyZWFkeV9h
ZGRlZCA9IHRydWU7CgpZb3UgY2FuIHNpbXBsaWZ5IGFuZCBkbyBjb250aW51ZTsgaGVyZT8KQXZv
aWRzIHRoZSBhbHJlYWR5X2FkZGVkIHZhcmlhYmxlLgoKPiArCQkJCQkJYnJlYWs7Cj4gKwkJCQkJ
fQo+ICsJCQkJfQo+ICsJCQkJaWYgKGFscmVhZHlfYWRkZWQpCj4gKwkJCQkJY29udGludWU7Cj4g
Kwo+ICsJCQkJaWYgKGltZ19jb3VudCA+PSBNQVhfSU1BR0VTX1BFUl9DT05GSUcpIHsKPiArCQkJ
CQlmcHJpbnRmKHN0ZGVyciwgIlRvbyBtYW55IGltYWdlcyBpbgo+IGNvbmZpZyAlc1xuIiwKPiAr
CQkJCQkJZmR0X2dldF9uYW1lKGZkdCwgbm9kZSwKPiBOVUxMKSk7Cj4gKwkJCQkJYnJlYWs7Cj4g
KwkJCQl9Cj4gKwo+ICsJCQkJcmVnaW9uc1tpbWdfY291bnRdLmxvYWQgPSBpbWdfbG9hZDsKPiAr
CQkJCXJlZ2lvbnNbaW1nX2NvdW50XS5zaXplID0gaW1nX3NpemU7Cj4gKwkJCQlyZWdpb25zW2lt
Z19jb3VudF0ubmFtZSA9IGltZ19uYW1lOwo+ICsJCQkJaW1nX2NvdW50Kys7Cj4gKwkJCX0KPiAr
CQl9Cj4gKwo+ICsJCS8vIENoZWNrIGZvciBvdmVybGFwIHdpdGhpbiB0aGlzIGNvbmZpZyBvbmx5
Cj4gKwkJZm9yIChpbnQgaSA9IDA7IGkgPCBpbWdfY291bnQ7IGkrKykgewo+ICsJCQlmb3IgKGlu
dCBqID0gaSArIDE7IGogPCBpbWdfY291bnQ7IGorKykgewoKTml0OiB1bnNpZ25lZCBoZXJlIGFz
IHdlbGwKCllhbm5pYwoKPiArCQkJCWlmIChyZWdpb25zX292ZXJsYXAoJnJlZ2lvbnNbaV0sCj4g
JnJlZ2lvbnNbal0pKSB7Cj4gKwkJCQkJZnByaW50ZihzdGRlcnIsCj4gKwkJCQkJCSJbQ29uZmln
OiAlc10gRXJyb3I6IE92ZXJsYXAKPiBkZXRlY3RlZDpcbiIKPiArCQkJCQkJIsKgIC0gJXM6IFsw
eCVseCAtIDB4JWx4XVxuIgo+ICsJCQkJCQkiwqAgLSAlczogWzB4JWx4IC0gMHglbHhdXG4iLAo+
ICsJCQkJCQlmZHRfZ2V0X25hbWUoZmR0LCBub2RlLAo+IE5VTEwpLAo+ICsJCQkJCQlyZWdpb25z
W2ldLm5hbWUsCj4gcmVnaW9uc1tpXS5sb2FkLAo+ICsJCQkJCQlyZWdpb25zW2ldLmxvYWQgKwo+
IHJlZ2lvbnNbaV0uc2l6ZSwKPiArCQkJCQkJcmVnaW9uc1tqXS5uYW1lLAo+IHJlZ2lvbnNbal0u
bG9hZCwKPiArCQkJCQkJcmVnaW9uc1tqXS5sb2FkICsKPiByZWdpb25zW2pdLnNpemUpOwo+ICsJ
CQkJCXJldCA9IEZEVF9FUlJfQkFEU1RSVUNUVVJFOwo+ICsJCQkJCWdvdG8gZXJyX211bm1hcDsK
PiArCQkJCX0KPiDCoAkJCX0KPiDCoAkJfQo+IMKgCX0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvbWtp
bWFnZS5jIGIvdG9vbHMvbWtpbWFnZS5jCj4gaW5kZXggMzYxNzExYzUzYjIuLjNmMjg5MThmNWNm
IDEwMDY0NAo+IC0tLSBhL3Rvb2xzL21raW1hZ2UuYwo+ICsrKyBiL3Rvb2xzL21raW1hZ2UuYwo+
IEBAIC01MjAsNyArNTIwLDggQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQo+IMKg
CQkJcmV0dmFsID0gdHBhcmFtcy0+ZmZsYWdfaGFuZGxlKCZwYXJhbXMpOwo+IMKgCj4gwqAJCWlm
IChyZXR2YWwgIT0gRVhJVF9TVUNDRVNTKSB7Cj4gLQkJCWlmIChyZXR2YWwgPT0gRkRUX0VSUl9O
T1RGT1VORCkgewo+ICsJCQlpZiAocmV0dmFsID09IEZEVF9FUlJfTk9URk9VTkQgfHwKPiArCQkJ
wqDCoMKgIHJldHZhbCA9PSBGRFRfRVJSX0JBRFNUUlVDVFVSRSkgewo+IMKgCQkJCS8vIEFscmVh
ZHkgcHJpbnRlZCBlcnJvciwgZXhpdCBjbGVhbmx5Cj4gwqAJCQkJZXhpdChFWElUX0ZBSUxVUkUp
Owo+IMKgCQkJfQo=
