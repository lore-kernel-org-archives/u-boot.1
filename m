Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63869C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 15:02:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C76E82CD6;
	Fri,  2 May 2025 17:02:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="NUoFeFI3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D89E82162; Fri,  2 May 2025 17:02:03 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3476982D57
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 17:01:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzfqSzxac/tIdisp5+Px2MI0J5tgNm2nit784dlcvqN16bvoMdLXd/Wg1ZAogmkrIXAmFNB1YoRw3cFv5Vi3mmEvhh56EbNR8ubAYEtSKJWbm1pkef6xDPZsjxT2C9LSnu253uFLUglKxZbR9B8oM80SCymW2M9jZCFH32PBJywwxTzF0bhw0DNc3l9ma4h5vJVbIVFbWvjOpzf58JNIWd4m5HIasa3cYhDtnogHEseKH/8NilCqnt81Tf4ZH0jCy0UlnRTOJ92rGqQPci9xY8L9Pwktfa9FuKb7I93xj+zerdQn4inzrlGaEKwEy7Q/pI+a6nITkKqYO6zBOvDA8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/vsaMMnASSLk2FldTYCSh//hJnS2LJbf/o8DiLmK2Q=;
 b=llLC0qeAts+I+H2tCq9oaZJb+qhmyKB9aVvXRy1ZJhnRdhZI91ZPNlJ4SIG+Js+WJ+vrKN2Ls29t7RQA2tFcGBVOZeV2KxVytKJY4eAJtQZC/nxe1LAyVvbSdZMvw/ugnUCYan2Jg62b1Ft50o+U1FSjqYIv32W0IqS/MWzeVurj5ldEQ5IHJ79B5uL0zr5uBt9Mb7lqLhP5oxRXjbfdXFbvBCxrqVGNiqi8vbG16WfK+dgMBIzU16mzYB5SA4JfEB+e1qznlWdfA4vcs1KrgDLH+55rLyMHm5+9YZCUbouwjQ3HZcFkcloennj06Zei7FaHzTwKTZDda3cFm9HNlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/vsaMMnASSLk2FldTYCSh//hJnS2LJbf/o8DiLmK2Q=;
 b=NUoFeFI30SD+GCSqZwQulXimSUCgRO9HMfY5C5MIfBwSRwVDJelfsU2VDrwvm9+e8N9rtIaSc6CUhD2s64b8WrVy5AmKYeJwVmVFxU34TsFFQ6cQNH7CuBtw1O2GhEjEo5waA0pCjBgAhnha1PQqd7gEE5TLqTgyDFenNt1rPL//1S7Him5HrlIb/V9YMTYOm07zZJfVAV9G3HRbsej26DglR2oqWhmxtLGPi9Xot6ml0lXe+CeEvA/zxcNumrSwI3nArCEaqAsMSmSRj861j0ThTiy3rxtm9XS14zmQfqL3duTHvISkJRqO/S4vvWrvWyud8vHHGDVzhJbs8bP85g==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AM7PR10MB3286.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:dd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Fri, 2 May
 2025 15:01:54 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%5]) with mapi id 15.20.8699.021; Fri, 2 May 2025
 15:01:54 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "sjg@chromium.org" <sjg@chromium.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "trini@konsulko.com" <trini@konsulko.com>, "kever.yang@rock-chips.com"
 <kever.yang@rock-chips.com>, "mkorpershoek@baylibre.com"
 <mkorpershoek@baylibre.com>
Subject: Re: [PATCH v2 13/60] console: Support a format string for stderr
 output
Thread-Topic: [PATCH v2 13/60] console: Support a format string for stderr
 output
Thread-Index: AQHbu3Euodfx3/LrrEKyeU0aLIe0BrO/b2SA
Date: Fri, 2 May 2025 15:01:54 +0000
Message-ID: <1359d0acc7a72f44a702415490a05dfa08f7031e.camel@siemens.com>
References: <20250502144718.313633-1-sjg@chromium.org>
 <20250502144718.313633-14-sjg@chromium.org>
In-Reply-To: <20250502144718.313633-14-sjg@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.4 (3.52.4-2.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AM7PR10MB3286:EE_
x-ms-office365-filtering-correlation-id: f076656d-1c4c-4c77-74e6-08dd898a46d2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?aUFGeFNPZ3plSmplenVjQXRaQklpT0NRNENHN3VLeldTTkloVHk0UnZiOTNR?=
 =?utf-8?B?WDVXU05xbkJUWjRXd2RmTk8xOGxGOFoza0RzOXJHejBLdTFpYXVZa28wRmVI?=
 =?utf-8?B?TW9lemU3YjluSTJaTUlwTzBweUUyaXc0bS9ZY2FML0svVVptcmZBKzhPdFlx?=
 =?utf-8?B?VEhHUW9nbHAwbWN5MVU0dm9uRzEvakJUeHFKSVlFb1g5RG8xQStRY0llb0xI?=
 =?utf-8?B?UG5LVmtqNDNxTlBmdWYyTmd5T040UGVhYmdUdnljdDhpTDhOS0NBUkFhbFpr?=
 =?utf-8?B?L0Z4VDBWU0dGcEFROXpIUHprZ2NMMWdjOXN4VGJZM1QwaXNtWEN3QWlZZWxS?=
 =?utf-8?B?S1BRUVhFR1hqSzN6R0JUbFp0WWtFSWU4WERSWHY4VUJMSkgweUJTVVVIais0?=
 =?utf-8?B?azJiOWdvUnRWQWYrb3dUQjcxRkIySmh6MTI4L1ROS085cnBwQWE0cXBtRkRK?=
 =?utf-8?B?UUNDKzZyTXU0U1NrY1h5cFdLRFRFYkNuVXhjcGNPaWNjV21UVEl3bVRNN1Bw?=
 =?utf-8?B?czA1VW1tMG5UeGFKVk14T01mb0dYeDRNZG5Oa3dRVlFlWEkzWVQwUkZ4ZlRY?=
 =?utf-8?B?RzAwK245U1RMQU5jcW91T0doYjE4bkRFREc2eGY0Z2c3T1Nha1N0NnhwNXdy?=
 =?utf-8?B?M0djelNmak5iYlovSENlMmp3R1p3TlZQQkw2NXhaRlNJMUR0VFBKa3FQR3dJ?=
 =?utf-8?B?ZzRkWmJPaGJ5Y0NWSys0Nk10L1VjQStwb0h5aW82TlZMOTlxVVl0NVJ0U0pI?=
 =?utf-8?B?bkZSZVNQdWxmektwSkdMVk5RK2FCSE93eU84UWw4WFhRc3h3OHQ1bmF4c0pX?=
 =?utf-8?B?WTZyTnhBaEtvZFRwWGNRZXNoU3kyZzBLbkZjVmZWNmh5Q3VNTDFjMXdYT0R3?=
 =?utf-8?B?N0k1RWpuWGxxRzJsV3FoUm0vdmhETUtZSFlGSDdOTEdpZkJIQ254QVBJY2FT?=
 =?utf-8?B?dzcvMnRDVTRzSlhwVGZXQzRwRTJCUjY2a21qNkw2d2RCaHJXOGhKMTIyWE0y?=
 =?utf-8?B?Zno5QUgzNVZnQWltZXdITkc0Tk5BTTkwbFMrbTVSZlJlVTA2ZHVNUlNmVlQ1?=
 =?utf-8?B?WCtQaGpXMmNRNnRBbjJNYXdQZWpteXVnOGYwTWNOUXFlZytQWmxJVmFraTlr?=
 =?utf-8?B?cTFPam44RU0zYi9OZ2ZCZ1M1clpkNXI0UmNxRGl4ck93bkZpemxzaTN3TU9Y?=
 =?utf-8?B?N3daZGdpQ0lMUjdTNFdHalJuZjRteUZkekdzUkN4ZVh2RERoa2wzYUt0L1Jp?=
 =?utf-8?B?azViTC8wdVArMkE1RjdPdHJueW9VZGVJVGc5RC9DK0dtdjMxd0N3WUxwWi9q?=
 =?utf-8?B?cDNFMW9yRjdENW5SVG1XcWdXL2dIbmtEUURzUTNqL3FjSWtWTjB0QVJhMFY0?=
 =?utf-8?B?Ujd3cmxMY3FSS1pEKzF4aXhhR1RqYTB2NjhHNnFVRjhZMUFZblljM2lLYWk2?=
 =?utf-8?B?TDJJTXFFbUsxTytYUkVPZUphSS83UHZkUm1SVXJqUkNlS1pSd016WnAzdkpH?=
 =?utf-8?B?UHM2M00vR3l4TUdpNEE4TVh0MzZlR3NMdC9DeE4wUStJMnA5T1owVklJVlNR?=
 =?utf-8?B?UmNrQWtoK1V2blpPWlp5YVFDdkxodkRmQlQ2aHZtM2Y2eWFPZWdjSmlPNXZv?=
 =?utf-8?B?R1FjRkJhY3Zuc2ZBL2ZwQ3kyS3UxNUw0Z2ZyNWh4cVpQdmZ2WVZyU1UxVEhU?=
 =?utf-8?B?clpRdDFWUnZ6MmtieitER1RuT1BCQmtkczc0OGo4cEV0S0JBemUzRHZhbDd1?=
 =?utf-8?B?SFlWdHlVZ1FibkpDUWZqbklhckRmNTY2VnBPN21vSmc1a3ZpNDFQWko4cHBF?=
 =?utf-8?B?OTRXSUZRUHJHdFhBSEZ4ZDlCZzNDbk02U1VMVG5pZTgxNlhTblNDdktmVjho?=
 =?utf-8?B?TW9vVTNhR0p0N0x2OEN5ejZ6d1g3MkpLZXhJR1lmUk40WHE4em1vT0o3WmZS?=
 =?utf-8?Q?mNDnVdfy7qU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWNFUU5wcHVNLyt4Q2hBWWkxbTZ3ci95dytTVFVEa0pLM29pa1lJZ3JjZmgv?=
 =?utf-8?B?OU12cHVTeG55aTJtMXlGc0hiY01yOFFSQlJRYllNWWdpTnpYVklKTkc3UmMz?=
 =?utf-8?B?ajd1R01SN3RtcGl1NFBHUW9uRnhLSHI0K3JzZGpuamxoMHRFTzZQNGlDUnpk?=
 =?utf-8?B?RENPQ0tQSWh1eXgvelhnRlBWZjBBc1R1dVZQOEVHNHQ5NlRsYzJFTGRVdG9Q?=
 =?utf-8?B?QnROdHZvRFYvVlZSZlptM1dUVE9aNTlMS1JXbFBkZ2wxcUhkOStjSmIxVGZE?=
 =?utf-8?B?WFYzMWE1ZUpwTEVMWnhmdmdjd0pzZGNyVzV5YkF5aHI3VGlGcUZxY1BZZCs5?=
 =?utf-8?B?bTYzZHBJK2dYVWxRVCtMNU9PbEpCVThiU3hnZU9TVExsODZrWE84cFBVUGgw?=
 =?utf-8?B?T0ZLMFljMkNoVUdEb1BVL2pxc3E1VnN0MHFiS0huZ3B4NjhNVkYzYXJhdlNK?=
 =?utf-8?B?eTk2a3hYTS8rRE5jcDFoNXRJbEFPalh0OWRtNmVBZ1FZUS9nUnQ4aDBUOWFh?=
 =?utf-8?B?dk04UEw3RVY4Q3Jmc3lUZWFFaHhpeUFoNTJjVm42dndqQW1uR0ZRTHVCOVdP?=
 =?utf-8?B?U0VjREtpY1UxUVdUbmlsdGx6bjdRQ2xTTzlZb1RhMFZaMmtzYlY4eGt1OURS?=
 =?utf-8?B?K0M5VDRZc2NjL295Nlc4V1ZEWUFTbVZkc1hFaC9LRTJpQkxYTmFMaXpoT3Yz?=
 =?utf-8?B?bWVYZWFsUFFLMXNIZGl2Qk9DY1R3alY4NG1pQnI1amMvVG1WUXJLTEhrc2l0?=
 =?utf-8?B?UktCeTU0UUI2b1RRZnNkSWN3N04yQUtMZlZ4d2tLQWZ4TmtFTEhtTklyekVq?=
 =?utf-8?B?dDlFR2JOZlk4ZGxaL0tpUWRLVjdvV2UrT1BSTzN3YU44ZXg4UVNmRTB0bExt?=
 =?utf-8?B?SGNwZklobW1INFFlTk1uUXZUSkRNd2NHSHg4MTd1UU9YdnNkWTFHbE16OG9E?=
 =?utf-8?B?RFdYeThCZDNqSkpuYXhnbzh3dEVZbjdpZTMvVGRYaGg2czc3TG5mSzErUWpo?=
 =?utf-8?B?b3J0VkRLdTNTWE85TDc1dTVrVS9ZTjBkSjJUWkwyY3BKdUxKaWlJNG1GSW53?=
 =?utf-8?B?dHpxTjBMU0FVY3dpMjI2a1ZBMC9CVXgvd3ZDWENjVmxKeTd5d0F4d2FxZGc4?=
 =?utf-8?B?Nm1EcHBmOHFHaVd1cDM4SGdLbWtzKzFtb1RvSTRMaGc1MmNNNUJDL1owWThD?=
 =?utf-8?B?Y3hoTEZXV1M3STc3Y3QwNlIvNzJ1eCswcGpLT0p1S1Fyb2lON2x0Zzd1bVly?=
 =?utf-8?B?by93VjM1WngwdVhBSGxKK2NLUnhsVFViN3A3dmE2Sy9QZjVOTFpMU0gwcHp4?=
 =?utf-8?B?K1BNVWgwK0FtWDg4SFI1bkxFOHprNmRZNlM3ZWFGdXliQkVHU21KTkxwVVA3?=
 =?utf-8?B?SHhxdVpIVXFHQWdVbGFzNk9PcjRDcCtZRkd5NFAyUVFkQWFLOGtNSmJnSm9O?=
 =?utf-8?B?bEtKZWJSZ1g1QWtPRzg4RFVCdTdBcGxoYkJwcUNmd1ZWaVlyUUIvRENjL1Fp?=
 =?utf-8?B?Ri8xNytWRUpLbXF4WXV0bHQ1aEtGUUxDV3owQWg2TGFMTDRVMjZVODZFdlVN?=
 =?utf-8?B?VXllMHkxMkMwRUROVzA2dVphWnd1VUkyakxuVlJFdTFvY2dPZDE4MEF5aStx?=
 =?utf-8?B?bUhSSDVtUnlMRlNxVFdPejBQNGtMRCtQMStNL3o3anNKTEZOTTdTT2tIdWFm?=
 =?utf-8?B?WDd4WnJFSWVGNjgwVTBCdDM0OWdFd0VJcHgwYVFhQ1hqZVBMbVZTOUxJZmhz?=
 =?utf-8?B?eVBSRkxpZCtRTnhVK1ZkYWllL0RGZTFpNkZ0TjB3YWx0ZkRCZjhyZno3U3dJ?=
 =?utf-8?B?SGdTbWtKS1VNM2xpMWY2bHlic0RyWkh0WHFwUXZaSnVCUldXeUt6VHRLQXJj?=
 =?utf-8?B?Mm5wczVQcjFPbU5tenZ1WlZzMnV3QU1CWkQ3dTdFNk1LaGFnL2w1bE1UeFp3?=
 =?utf-8?B?K1ZEbUw1STY5MTY3d0hHOFVsUDJ1SEZxa1RPekpET0NORkhUaS9hOEFibW9V?=
 =?utf-8?B?ekliOFNrNDVOWForR3QrNHkzSFRSdzlEcStubk0wYUo2UkxPdCtLU00rL3Nm?=
 =?utf-8?B?a1VLRVdMbU9YbkhBZDU4QTdRckZ0QlVkNUUycjF6eFZZeDY1dGFiM0UzUDNx?=
 =?utf-8?B?ZSs1ZkxsWFZYZE9RaHV3RVB5YVRHZ0dOZzNDOE01VStCZks2TkJxb3RiU3ZB?=
 =?utf-8?B?dVdaY3QwekZ5dWhwWEdZQVF4R3ZYNW9BUkV6WFR5NTFEOFhqWmUzMm5BQ21I?=
 =?utf-8?Q?yY1+XAr+bPpsi7yd2vclML9v5Obxs+JmH2lGE4dqj8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9C423B0049E1543B420CAF2C756FFDA@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f076656d-1c4c-4c77-74e6-08dd898a46d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 15:01:54.2998 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rBD2+m//ownAFT5vnJ4sdb+BylFLq8WK/aeuzvnvBLW2F4eHlrOT74Qd8vNHktOWG8XaCatkg/H3qSM5V2WZeSryXioJIryA9TYsSNyWX6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3286
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

SGkgU2ltb24hDQoNCk9uIEZyaSwgMjAyNS0wNS0wMiBhdCAwODo0NiAtMDYwMCwgU2ltb24gR2xh
c3Mgd3JvdGU6DQo+IEFkZCBhIGNvbnNvbGVfcHJpbnRmX3NlbGVjdF9zdGRlcnIoKSBmdW5jdGlv
biBzbyB0aGF0IGl0IGlzIG5vdA0KPiBuZWNlc3NhcnkgZm9yIHRoZSBjYWxsZXIgdG8gcHJvY2Vz
cyB0aGUgZm9ybWF0IHN0cmluZy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNpbW9uIEdsYXNzIDxz
amdAY2hyb21pdW0ub3JnPg0KDQpSZXZpZXdlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4
YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQoNCj4gLS0tDQo+IA0KPiAobm8gY2hhbmdlcyBz
aW5jZSB2MSkNCj4gDQo+IMKgY29tbW9uL2NvbnNvbGUuY8KgIHwgMTggKysrKysrKysrKysrKysr
KysrDQo+IMKgaW5jbHVkZS9jb25zb2xlLmggfCAxNSArKysrKysrKysrKysrKysNCj4gwqAyIGZp
bGVzIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKykNCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4N
ClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
