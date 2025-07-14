Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04665C83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 14:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 720F482BA7;
	Mon, 14 Jul 2025 16:48:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="IIexDvNT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5242882E52; Mon, 14 Jul 2025 16:19:57 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CB5382CFA
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 16:19:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=anthony.pighin@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmhPSNLsfBH6NROKmu1cM3HvTvq54QQcgkVoGy/LHkjCgu4PrI15MPmHqXXOiecyVXVsaPfOhXKNnJaL7SpNvibF2iAkK0co8sIT9mH+A9sxNjyBeblED+ct2oqqUQUp4oFu9Jl8LeVwG4xIYMOdr5R4APtaJhgzWq4bhtM00XYMIblJRgbGW793I9NkFcL6cimELSXB2jOaYMnRDTZ2eSxt4pZE+tPnapcv/Ofm9pF/ilSblYbUO6ZlIubgNHnQFd5eyLd64cOoWewkVq5emvwBgdMfTFmvH/gPNfuICrqWmmZAm/0rVNLTS6V5LjzxcmwJjk3zVdOOK0W1g9vdcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qmm/HTc+opx88Ak38fIqwFiArQ7fqPp1gpv7gmPz43Y=;
 b=VrhciNf4Tawr4loI00rw9VZaT0WpjUspmJ1iJiF3nPkzDLaMlThGxksw4zaG3hDPG3Kkq18KcwR28tA1Uir9LG94k/CH4OAljxHleyhM797xWNZUYr5wvky3Q43bcRXNQDY6DgYf+r4nGhykKZKUwdeEcCcxd7Id/jFBn6TZIZ1I4G5mgupBfXCL4qDUeTBo1Uy7lIvQFQ6q5eGeFOKAOpaEeQq/P2NSutRLyB+/mwFF7RNlUs+xN53A6SV4QU2em02GCqLxLIMlioeJrT0VONdvHTcOVJNcDMrB4gZG12n39bRRNDTEkLmN0lYxQnnwBiC0z8Ewa7LhfoQZr3I4QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qmm/HTc+opx88Ak38fIqwFiArQ7fqPp1gpv7gmPz43Y=;
 b=IIexDvNTIkR9Z9htglDYVK22g3jhX0Hvg637eXHufU84qfZQTVqUA+6HKKTaDY3YQsGqOFYFG7Vaxm6fv0MuM2GuvGw7Gky/39I8o1ZJB3RMgPxMaHRgwSjNObk2cBxiqA5rITRmSxbgwBERV5gL2crVF1AnRR76Fa/1L/yXWzlSODWLsJf/qMrUsQ2h7s6gQxtrJiwyqMZZZC7nGpYumZbJRn0laQX8PxV4s3ZESoPfFzjvmHvKOTiDlL5EFdeSj/F29IOJ6tNqZilmaz/u25yEn2VETdIAbxfDlGjJ0cjzKM59ToHqNBqZdvjI9airt9RcJIm9mglauGXqoZxCaw==
Received: from BN0PR08MB6951.namprd08.prod.outlook.com (2603:10b6:408:128::14)
 by BN8PR08MB6291.namprd08.prod.outlook.com (2603:10b6:408:7e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 14:19:51 +0000
Received: from BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::9ea8:ab2e:4ce1:2d36]) by BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::9ea8:ab2e:4ce1:2d36%6]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 14:19:50 +0000
From: "Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "gaurav.jain@nxp.com"
 <gaurav.jain@nxp.com>
Subject: RE: u-boot corruption from EFI CAAM RNG request
Thread-Topic: u-boot corruption from EFI CAAM RNG request
Thread-Index: AdvwbwjgPSuIydQbTdSM+RLk38cMCAETwn3wAAKUpoAAACGBkA==
Date: Mon, 14 Jul 2025 14:19:50 +0000
Message-ID: <BN0PR08MB69518FF4C069DA40D9D2973B8354A@BN0PR08MB6951.namprd08.prod.outlook.com>
References: <BN0PR08MB6951B4921AD52EDFA06E885D8349A@BN0PR08MB6951.namprd08.prod.outlook.com>
 <BN0PR08MB69511CACF429DE68924BCB348354A@BN0PR08MB6951.namprd08.prod.outlook.com>
 <CAOMZO5BXVuLnCUF1CCLMm93pcqESv_+fps-8GFXPZvhcNGbugw@mail.gmail.com>
In-Reply-To: <CAOMZO5BXVuLnCUF1CCLMm93pcqESv_+fps-8GFXPZvhcNGbugw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR08MB6951:EE_|BN8PR08MB6291:EE_
x-ms-office365-filtering-correlation-id: 24c08326-771c-4d55-27ec-08ddc2e17ed8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TDFwMkpucGQ1V0lSYmpseStCaklIdGFBTmI0ck03T1NwZ2N3U2ZrRVN4QVV5?=
 =?utf-8?B?UDJNRG10VDljMVJuUEMrN1pVbEx0Y0c3SGFvcHgvRTNSTFYrRnpQZ3VDcTAy?=
 =?utf-8?B?WkphVGtaRHpMSEZxaWw5UW4xVmZzbkJXSklnVXRHUmkyVC9DS3BQbjV4dXVZ?=
 =?utf-8?B?M0dlYXE0ZlIwL2VYNUxGcTFYOFNIZk9HMXFJNkR0M0Q5eVgxMVdCb2lBa0Y5?=
 =?utf-8?B?Q2ZkWjZHOVVQRXVGaWZjMFVibUdqZWkzT2FOUVJLU2tMVnVvazRsSnJjMmlx?=
 =?utf-8?B?Mko2K3lwbnd5RW9xNHplSTNscys1dkNVdUNsZFVybGtXUUZYMzMrWnNXbW04?=
 =?utf-8?B?cGRDakJ4c2tmZjdveXhiTDlQRWtPaFc0eTZGc3pmTGFXaFliY2NUc0NKZUhl?=
 =?utf-8?B?aG5lMmFEU2FqU3VvS0o2TWtWMmhZVFptRzlySEpkWXdjd0o2aGxzTHBJbGRw?=
 =?utf-8?B?bkxQMlFBZjhMS3pxeEtqRWxwMVdhODhHcXorY1oxWENPbklmek5FS01aYlVk?=
 =?utf-8?B?akQ2YldTL1U5YjhwMEFjdzF6WnNUMUhVTGVqNzg0T0l3eGdtUTVKTXgvR3E3?=
 =?utf-8?B?RTNCRW1Rb3d6UkRwMTlkWVhRQ1NVNjZldThTRHJSdkx6M3hpbDkzQjB5b2pl?=
 =?utf-8?B?ZG9YYjRaU0xsN1hrVEhCOG05ays1TW1TYnY5QjBHbEJ0V0xSaDlPU3dqTzI0?=
 =?utf-8?B?bUZVL3U2RS9FZCtCdzBrUm9aamU3d1h4M3FiWE4yUlE5Mi92UXVqNTA2OE5Q?=
 =?utf-8?B?UGloT1pUYXY4M01POE9CcGt6WTFmQVNPd3Q0VjRZd0VsbzFKT0MzY0k2b21J?=
 =?utf-8?B?WEVqRGJWem82dXFMWHVObnVjejQ0cVN6YTR6aGlTbDhxeVRBTFBXSFRibk9R?=
 =?utf-8?B?OUwzWGZ5WVF1cDlmYlFQVzl6NnNrb0FoT3A5V2Jqdk9JV0FYZXp4cFpsZG1a?=
 =?utf-8?B?bUVMNk1ZUHlXTTlHYzZMYmZ0QlV6cUpuTDA2eXRnb0hzdVY3QWtuNmhVTFU2?=
 =?utf-8?B?aS92WE94K2RHTlNjL2c1K2dvSWMycU9qQTNlazNjU0FhNG53VUViM3ZIN09R?=
 =?utf-8?B?M1BUU0ErL0FoWkRGRGpzd3kwVEdvblp3bVUwME94VU1rZVZHdVp3blp1bGdQ?=
 =?utf-8?B?TjQwR21VR3Q1YXlURDhOOHlDN0hrQ1krVmxaTFF5VUVmZ3BiQlV6T2YxU25U?=
 =?utf-8?B?UlcxcjFRdmhWR3UweGovT2QwODhyakV1bDhQd1NwaUpzcjUvTThPLzYzSU9w?=
 =?utf-8?B?Qm5pY2N6WnE0WTBFak1WeVlJWllDZnRhc3JTMm5JYnRHSXFPQVVyWkYwM1lH?=
 =?utf-8?B?cGhFcS93RWFkZUQyRjV0bVN4V1hBWkt1WEtvdFVreVhhV1diOTF1WW1xNlND?=
 =?utf-8?B?dlR4NUY0dXBKK2xFVURTTnVNeGltZWhlSmxaT09HZlJWaXpyR3lNMTk0Ry9a?=
 =?utf-8?B?UjFGK1gvTUdyaFZFRnV3aVJSNytXK1I0STNzbitVOUh3YWdGRDJUZzM2eTZI?=
 =?utf-8?B?Q29TVGwvWFZjWlFsZDJpbkduN0hld0JQQnN4bWRYYzdkWXd4eERGOU03dkhC?=
 =?utf-8?B?ZjVaTHNYN01tU0dPYzRPQmNWQnZ3THpQM040T1QrNGkxWDNhZTE0T1ZFQU1G?=
 =?utf-8?B?bmU0UlZIdXU5TEJrN1hyMzRLeS9QS3ZkbGVDempUU3EzWWJNaUZXMEtvVlJK?=
 =?utf-8?B?RHVsY2RZaGwzMUNLTmVVdCtSWjA1a2srRXJLd01DbGNycmdvd1dHMTBmRUNp?=
 =?utf-8?B?dmJpTWtoKzgrajBRU3Z0OFBGNjRqd1hJSVVmZWlJNFNqdkxJNjlXUjhvS2xE?=
 =?utf-8?B?d0ZCa2ZTeXFldlE4TmVKMDgwK2RNbG8wTlJSRnBnb2R5MFZQUVNGSVJsQVc0?=
 =?utf-8?B?R2dhZ01GenNQTDMzOVI3Tk9yWkQxZHFUdjRZMENoeTRqTC9iVUtJTGFKOUtz?=
 =?utf-8?B?UGI1UzBJeUVXbW5FU1NtNzFPYkN0a3VOMGtmb1o1cE1WdDFwTThwS1A4MnZC?=
 =?utf-8?B?RW93OWxxS3VnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR08MB6951.namprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?em5SN01rcHFTVlBvUU0zNW9YUU1JNDI1TEphRks2bGd0cEh0QVBYcENwUlNC?=
 =?utf-8?B?dWp1VW1qVTRtQU91R1FtRFMvLzZJWjlybFVkZk1NNnFMUE5IWFoyZWhmMEFW?=
 =?utf-8?B?TG9PejFMYU5JTGRLZ25OVm9uUUtlajlmRzNKN3h6MHk3eUUyckZLTm5OdU4x?=
 =?utf-8?B?SkRiQUxLWitTTWFORU15RFpEdlFGa3FUQkJyckgwcGhQWWoxeUphbHplcXhN?=
 =?utf-8?B?dTB4eDNodVVveUs5VkJMbVNkdmZWeWxPM3V6VS96R0FaT1R3OGp4QnBTV1BG?=
 =?utf-8?B?SmY5VGQxMzhVcGE0ZnFUYmJpWTlqb1RUc3lBVVBTajBKTUJGMGRXOUIyRGpN?=
 =?utf-8?B?endIVjdCRmZ0R01FTld6SHJnWWJxd0NGVkVpRTBpY3dpRzRMWUx5cXMwcS9P?=
 =?utf-8?B?MldheVU2d1QrVSswZzg1d1pZK3ZXTGViNEthV09KV3YrYnZHWkMvcWxoTGVS?=
 =?utf-8?B?eTF6S0g0MktiMVhYeUxFYTZxS2hMc0ExQU5aSGhUb2dpUjhsU2ZUWFRtTXhY?=
 =?utf-8?B?YWFKNHNDMmd5b0pUY05hZm1ySEcvRXhKMXFLYXlnT0UvZzlqZFI4d2RnMjJy?=
 =?utf-8?B?RW1YVnJVSkNxNVlxOTVtRmhiR2o2VmxZYzFTRnZibmxUUFFTc0xVK3ZDRmNl?=
 =?utf-8?B?bC91MjAvWjkreHNsNlhXcWZSUGQ2aWtBWGVXY2M5VGl0WGIxNjJKUWFqTnha?=
 =?utf-8?B?aXdrTmQ0TTMxQ1NkbVZ5UmRCd3Z3U3FkMmtnTDljZUVJOVU4bi9zVmNra2M2?=
 =?utf-8?B?ZFN1U3VyM210TFpvcWxQRHk0Y1d0NXZZdGhDMTZZK2toL3BGWEdrUFVMS25V?=
 =?utf-8?B?U0ppNWwxWERUMDJEQXFHamlEUVdlK25XbXdxaWtFVlZ2UDNxNHgyczFBREt0?=
 =?utf-8?B?emswcUFBYTNxeXhSWkd5UHRpcHVwVWQ0OFFLRXkzcmZtWGZ0aysvYi9ESkxm?=
 =?utf-8?B?VjFPSWJQNTBKNEhXeDRXTzhSM2tnOGpBYkRlSWNBeTdwNFlWNTRSNldCSHlM?=
 =?utf-8?B?NDVINEZDc3p5VXBIUGJ0RjRadEd1ZlI5Zkh5SEJMT1BwbVdmWWJFSzNTdnJl?=
 =?utf-8?B?bnpwZkttNzExejhBb3BsTW0rdTREVEk2N25JNUZaanFUa2RLU0dBejlJcVVD?=
 =?utf-8?B?QjNzdlQ0Ykw0cjBKNXpTbmhHOUIvMmJVaHJhOFZhZzJCYWJSUG1RS1p1eTIv?=
 =?utf-8?B?L2hldlFHWjBQbG1pZjJ5K1pFUXZOT05zZzR4OG5QZ0NxVXFKRXI3RW5iZXRJ?=
 =?utf-8?B?aU1DTFA0ZUhYOCszQTNldmNpd3pWVmlpYUVDMXZQV21TOGs5d1BiSEU0VTh3?=
 =?utf-8?B?SHU0Wk1IWlhmK29CUEZ0eG8wY2p4dnp3ZXRtYlFMbmRyS2QzOTZYRkVJWUp6?=
 =?utf-8?B?TEhLR0QyZW5BUW1RMXY4aEZCNUFjamlTWDBrV09yY3lFK3RvK1RqYlRVUzFX?=
 =?utf-8?B?V0pWdWJDQ1ErNUxJWkJxRTNpb3BFTnNZVmExVkxNakdCVXVVUlhDUHVidk1s?=
 =?utf-8?B?SU5JdWhkRUppaEtBZUlQYU0yWi9nek1XRHU0UkNtWVg4TytHYWZ4OE9WRmdz?=
 =?utf-8?B?aU1uRzhOWkUybGt6QjlsVjNpSjhxSlZ4bG1jTzZ6NkszUjR0VGZ0bU9GMktF?=
 =?utf-8?B?d1p0eWZ3UFI3MHJSckQ2cnVnSnViQ3JxNlJyUlRnK1EzaWR1Q3JBT0xvODZa?=
 =?utf-8?B?MXJXUG9zUTBJM3Vua0RScWpPOVpLSWZiSjBsOS9RQnBWdjg1UWVicThaSWsr?=
 =?utf-8?B?U0djUURZSWhRTjFhZytEUEtaVE1Uay9OOCtSaTBQNmxWcndKcUdBQURnTGZR?=
 =?utf-8?B?RnMwRmM0MkNyYXhhOTBteVkwMU90OGFvMHBkclpCaC9YYi85cTdmSkQ0M0h5?=
 =?utf-8?B?QjhHOVZkdDhRNDRKZzdHcFdLOHZmRllTR2RYOGNpS2doYVVUY0tTeEdJRG0r?=
 =?utf-8?B?bkR6MmlKZWtCbjZkTUN4eXlOZEV5WWw0Q1pFNVVGc3JoTjdndkVLVHlpVWdw?=
 =?utf-8?B?RkY3emtGaks3V1BmcWdEc1pNelBsbGpYaGR4ZWYvTE9uS056ZzZvS2htdzFy?=
 =?utf-8?B?bDZNaXFRVjJQdldiN3VGSUhPMEFnZ2V0cE9pUlp4d2FUUFZjM2c3RmZIOXhO?=
 =?utf-8?Q?QCJ/h8voGJix85rJIu0UadpxK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR08MB6951.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c08326-771c-4d55-27ec-08ddc2e17ed8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 14:19:50.7489 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UU1zwYED9n6/3ObIGYNYiB1LTbCPqz3+0ZuKYGIWMXw2M1MxfG8sm0uXM8jMfiPslEucNUbOrdwCd/rKKlwZ84LTOjkEWZOg7yTVims2h8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR08MB6291
X-Mailman-Approved-At: Mon, 14 Jul 2025 16:48:12 +0200
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

PiBIaSBBbnRob255LA0KPiANCj4gT24gTW9uLCBKdWwgMTQsIDIwMjUgYXQgMTA6MOKAr0FNIEFu
dGhvbnkgUGlnaGluIChOb2tpYSkNCj4gPGFudGhvbnkucGlnaGluQG5va2lhLmNvbT4gd3JvdGU6
DQo+ID4NCj4gPiA+IHUtYm9vdCBpcyBiZWluZyBjb3JydXB0ZWQgZm9sbG93aW5nIGEgTGludXgg
RUZJIGNhbGxiYWNrIHRvDQo+ID4gPiBnZXRfcm5nKCkuIE9uZSBvZiB0aGUgbWFueSBmb290cHJp
bnRzIGlzIGEgY29ycnVwdGlvbiBvZiB0aGUgRUZJIHByb3RvY29scw0KPiBsaW5rZWQgbGlzdC4N
Cj4gDQo+IFdoaWNoIFNvQyBkbyB5b3UgdXNlPw0KDQpJIGZpcnN0IG5vdGljZWQgdGhpcyBvbiBh
biBMUzEwNDZBIHBsYXRmb3JtLiBCdXQgaXQgd2lsbCBhcHBseSB0byBhbnkgcGxhdGZvcm0gd2hl
cmUgdGhlIHByb2Nlc3Nvcg0KYW5kIHRoZSBTRUMgYmxvY2sgaGF2ZSBhIGRpZmZlcmVudCBlbmRp
YW5uZXNzOyBpLmUuIHdoZXJlIGFuIGVuZGlhbiBzd2FwIG9mIHRoZSBqb2IgcmluZw0KZGVzY3Jp
cHRvciBpcyByZXF1aXJlZC4NCg0KTm90ZSB0aGF0IEkgb25seSBpbnZlc3RpZ2F0ZWQgU0VDIGpv
YiByaW5nIGRlc2NyaXB0b3JzLiBPdGhlciB1c2VzIG9mIHRoZSBqb2IgcmluZyBtaWdodCBoYXZl
DQpzaW1pbGFyIGlzc3Vlcy4NCg0KPiANCj4gPiBIZXJlIGlzIGEgcHJvcG9zZWQgZml4LiBUaGUg
Y2FhbV9ybmdfcHJvYmUoKSBpbml0IG1pZ2h0IG5vdCBldmVuIGJlDQo+IG5lZWRlZCwgYnV0IEkg
bGVmdCBpdCB0aGVyZSBqdXN0IGluIGNhc2UuDQo+IA0KPiBQbGVhc2Ugc2VuZCBhIGZvcm1hbCBw
YXRjaC4NCg==
