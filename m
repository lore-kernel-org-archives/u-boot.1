Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827EDC021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 20:04:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E405380A46;
	Wed, 19 Feb 2025 21:04:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="jGZ/YvGn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 913F8801BE; Wed, 19 Feb 2025 17:28:33 +0100 (CET)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FFF48001F
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 17:28:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlWcGU1lKYsqvon/mkIYFQ01a7YlKJEMfdLZkDOfv2wUmj6UC3EgdqZTu5/ppJTG8FY15QIoUkKpDT5XSC3jlrjxLE+TYCd7b3TrrLBKcLJr6yea8N22TcqN2YiWb2wFp1zKLFYTB4LTK/sVHOo7JAZZ5NN7cZJyr8FPI1yWBeUov5JJsHuV6JUfp9tKxIZyP4pywUbQLXkljsGYDYwusSaPuM5t4QhWMd1qsteh77gmoXMgssD8Ucxc8rJwsdqBds1cPoUYXzHp2esC7/iykYVUBxEnuqpE7Zl741Dj//+1g8dIs+F1et57HsFajqqrjEeYOclwrpGBtI+55qxr3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsV8xzKQ31orkRAk3+g5kBPcOHAFq6teRE0xyGr+2V8=;
 b=qzfCOwNMTAtKQwMHO2zYNgOUCblBBg7B0fYLWwcTC/U/JnZU7dxlhwTCbFSzVEz6by4OUKV/8FJD1Qp9Qcz6qOgXdA5bwSpNhlYZqrKr5gzjdJcqSVbgoV1rLA8ACf0Hkh14anquUtw27J+76FJL8D7Q9UWQ/xgAs60UchlHmi1eVGnFOV+BMcQNr30KKhUMnf1NAL8yAr07tnfpzyfmvpP96STvDj8HRyXaqeVdiqeAzODpQuPkrLhIKliFIamnmupWZjuo3oI/n1jZa167/YTiG3xp/xJUuWgs2sdS3zWUb4fENr07/jBU+AyC51oi82+ygYzuxNycCWn6+vCbmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsV8xzKQ31orkRAk3+g5kBPcOHAFq6teRE0xyGr+2V8=;
 b=jGZ/YvGnaMDn0T9ZyqJrMw2vL137KOR9ZWRzo8HMflC4bdk2XDE10JKrr9B24TIal7HQlTL82kEb16vZtunHruvk6CQoUXaesPP44yLzpZFe1FLFjuNfJbBNLPr1XgWqBzoVReS2BlAs371Ei9teuABIiihoYfJ17J5NWlh0hfc8xzWmrTzra/fUexueSL0F2yzwBHUlVfcBrR9a+yqlFWmSRAHh4jjSV6Dq3tL6db/tv99Ftrn9OBO6FzuwTWYkOjX5o1hzeyPoVKZJ6xfiJiDabZwpOnaIN/MCEGnt8mtHYHravPmltaMzfLTZv8by+pOI7fyVyCabjF8B49fOYQ==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by AS8PR03MB8395.eurprd03.prod.outlook.com (2603:10a6:20b:527::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Wed, 19 Feb
 2025 16:28:28 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8445.019; Wed, 19 Feb 2025
 16:28:28 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: =?utf-8?B?RXRpZW5uZSBEdWJsw6k=?= <etienne.duble@imag.fr>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Lukasz Majewski <lukma@denx.de>,
 =?utf-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Marjolaine Amate
 <marjolaine.amate@odyssee-systemes.fr>, Matthias Brugger <mbrugger@suse.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peter Robinson
 <pbrobinson@gmail.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Anderson <seanga2@gmail.com>, Simon
 Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>, Tom Rini
 <trini@konsulko.com>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: Re: [RFC PATCH v1 00/20] Introduce support for Raspberry PI 5.
Thread-Topic: [RFC PATCH v1 00/20] Introduce support for Raspberry PI 5.
Thread-Index: AQHbd7boMg6OKeAhq0iRP9GJxZu6mLNO1vSAgAAQMIA=
Date: Wed, 19 Feb 2025 16:28:28 +0000
Message-ID: <43b28f61-d6a6-47fb-8bc8-c4a283f777ed@epam.com>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
 <8c47e42c-6922-45a1-97ad-de634d8075d3@imag.fr>
In-Reply-To: <8c47e42c-6922-45a1-97ad-de634d8075d3@imag.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epam.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB8946:EE_|AS8PR03MB8395:EE_
x-ms-office365-filtering-correlation-id: ebd709fe-1aeb-49b2-c6d2-08dd5102711c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?b2d4emZPZkRpcUVmQmhjQTFpYURNckpHc25mbWR1eTBvdml3bzdRVWpCRXA5?=
 =?utf-8?B?SEZQN2RZemw4RnF4bERtcVpnUUZldWNPcjBhMEZWY3MvM3VEZVNDNWNnVmsz?=
 =?utf-8?B?TUZjdnJjUEh0ZnUzWXQxamcyOWtnRnRLZDFYd2kya1VwbGlSSlZZZHV4Vk5h?=
 =?utf-8?B?dzhKZXNZWlJQTjJ5RE9oRlYraG9SRkNCdEZKcTIwN2RDOWROaXlob2h0bVVN?=
 =?utf-8?B?N2FNS2MyWHFLNjJiOFZZOTk5UkkvWnFpQ0o3SFB3U3hDUGRmOWU5ak1lWWx4?=
 =?utf-8?B?d1RRY1NNSXlHS2VKdjVEbzAxaWV2N0c2UUs3amo1U3FUZUFMTGRzeHZWSkwy?=
 =?utf-8?B?TXJXekJUV04rdW5UaHVkL1FpNXZxM25ycFoxU1A3M3d2eThLVW5PMmJSUDJm?=
 =?utf-8?B?SncyR1ZCeWdGZnAwbG1rRUFOelNtS1BnUDI0eWhKUzRGeEk2aTlKNWVnbTN5?=
 =?utf-8?B?M2VqTXA2WlpxZEdxQnhEMWtlTzZNNU5qWFZpdEVCNWxPNFJXWis5aVJxdFpU?=
 =?utf-8?B?Nnk4NjlkeVBYZTF4emZxTzEyVDVXZmsvcDMyM0l6MTNzMmxwNFdiTGpkL3B6?=
 =?utf-8?B?c2hRVjgzZEJKR1VBRGNPYnY5R1c2dHV3TDdpd2lVaTZ4NHZhbys4RlB5VTJF?=
 =?utf-8?B?eFNkU0Q3UXdBcWZTYUt4ZmtlMWxoUGVuMkdOL0lYVGhlK3ZRUmE2MDlSTG92?=
 =?utf-8?B?akh3RVZ3TDJsWmYzTEx1ZUxhYWticzJ1RTlvR0VJZ0g3dUEva2dhLzFacmhu?=
 =?utf-8?B?dFZqWnlnWmVPZkx0QUlNS1ZERkk4UURPeDFDbHlaajQ0Qmk1UGJGalNOV0ww?=
 =?utf-8?B?RkZNQXRWSzVvKy9oMDdIbkp2eXdPcDZTdlVRSWpGOGNVeTRiSmF4WCtnbkFm?=
 =?utf-8?B?ZWxxUllhVDlCeUROWjJxbEVxdzJLQzJJVzgxMm5zRkZjK0tFZTU0QUV0WFhT?=
 =?utf-8?B?OUdVVloyYzd6WHNpOEtlOUU3Si85VFdpcWRXRHhQQStyOW1Gb1k3UkJSOFVH?=
 =?utf-8?B?eVFhbWcvRVpMMUQ0cllDL3M5Y2VxcW1DSGlUMlA5dXdaVjhRTDlXMHZxa0Ji?=
 =?utf-8?B?NVlpWGJBeTczaThBZStIYUNOZHpNR0d1Q2ZqSWRnRm1vOUwzWUhqdTkzMnNX?=
 =?utf-8?B?NkFZcjBlUVUwamE3M1NFOUp5VWxLUDgwRDNzK01vSWR4U0lKaEEzQWdlSmtG?=
 =?utf-8?B?SU9NamhHWlordEd3b3dFVUZvZGhKVUZseHV5V3lIRk0vYW5wR2VqOFhaTTdi?=
 =?utf-8?B?ZCtNUEdvZ0hQWnBCN3R2ZVdTVnU2SDdybEFRNDBtOWQyaFFVZEl5dkk5Q0NW?=
 =?utf-8?B?d0RQVG94cmEvZ0w0cTE1RWwxVExFWUF0b0lmMnY2bCtpa2VMRlZRejhlK1Uw?=
 =?utf-8?B?Zlk1UDl5c0J2enR1aUp6cThYclFGcEZMYmF0d2dJeEhuNHZFaWRsaVpWajVv?=
 =?utf-8?B?TDFCM3NwMXRzUEpKa0ZJeEpIQy80VGhndnlaTzIyekF2SHdISTFhZHp0d2dq?=
 =?utf-8?B?Y3lISW9JMEkvMmxTcmV4bG9LVkx3L1lGU3BYOHh1SzBScEcrVWhnMFNMYW9H?=
 =?utf-8?B?VXFjUnhPdkdldVY1NkdLOFNORlJCbldwUStqQ01CTmxEZDhpcStJV2MxRm9i?=
 =?utf-8?B?UlU5N3RvUXJJWWJ3Z0lCVGFqcWJkVVRiODZhTkhBbHFkc09kYkxrUWxicVpN?=
 =?utf-8?B?NEZHZ1ZpT2cvdUNGMEpSb2pTZnZBZVVLK24yTmVEcUJaTGs2R3NTaEdudm1m?=
 =?utf-8?B?dUtaNnBNSUd3cCtJZVB6Qk9USFI3ODFZQUxRVUx3cWhjRmNQelMrUHFFMUpT?=
 =?utf-8?B?MlJPQnZVZVBDMnQrZHMwSnRtK0RTRFozbjBPS2NueU05enVoWk1pREp5SFh4?=
 =?utf-8?Q?a76lzpyBpXF/n?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGZkQjN3T2xRUEw1b2Z3ZmZtYVUvSjZIN3NtVWF0N0dMQllJOVdOTkxKYzhi?=
 =?utf-8?B?dTY2S2ZuOUJiYkI5ZlU5eWxudno1OWJzL0Z4bGFHeEQzVkRreTJYZlllWkMv?=
 =?utf-8?B?L2hrNEkvL2RBek4xa3l6eHAyeFdzZjVzWTdQY3NHLzhiVUpBWjJaQXRzM29y?=
 =?utf-8?B?RnBvSlBXZFJFUXY4QS9aR1FsV2tDNlBhUnNObk9sVlJIRTllZnNrU2hhVllW?=
 =?utf-8?B?R1pRRXgzazlQQjM5aFgzUVlRSFU2RnFYY1NZNmk3QmQ1dmY3Qk5CWTMzczNU?=
 =?utf-8?B?Vk1XRXBiUlhOMUZFVjNQREpSdjVkWnpKK25oVnZBTUI4MDJ3Rnk3UmNMWWxk?=
 =?utf-8?B?Vm1vdFFtVGczaUVJcEVuVk1jdkR5ZjdZUHk0NktKc0Q1VHozcXZ3aGxqY3VJ?=
 =?utf-8?B?RU16a2w4MEVKektlc0V3WHM3Zk9PMC8rdzBlaHd1UTlpVStKdE16elZ4YXI0?=
 =?utf-8?B?ZnJEbC8zM0dZWHZsYWZDbU9NTHRiOU5TUkJ1cHBVSWhuVUc4YTBWbVlmTmtB?=
 =?utf-8?B?T0Y5aVY1Y1lycE51cU1NQW9vOXl1NExOc2xPMjgrK2xtMmNQeFZNb0YzMFAv?=
 =?utf-8?B?bmFwWnQ3QUVucWtua0pzNEEvNzRGZ29wTmhrQ2tCL1ZFRkR6bTE5OWc5YlJ1?=
 =?utf-8?B?Q0hudGJ1YldteWNPdlFNMGtQMTNKcFlSUUVzWmpQeGkvVjRQV2F6MmJPVVhz?=
 =?utf-8?B?amw5cnozdnVlWFhZVHpSZ3ZkaXBiK0VGRDFrdzFqVU9iczRrcUNyRENMYlBJ?=
 =?utf-8?B?UWJqOXN1WnMzZ2dPZUZON0RXank3dlBSaE9tSE4rc1JHTWZtZmRuTUN0R282?=
 =?utf-8?B?dDRKZ3hvcGdhSUVOeHdidmNUenUxcEtVbFN3eFJSNkNkQmJBT2JiUnBaRk9E?=
 =?utf-8?B?cW5zRkUxc0g5Qlk0cDhnRzRIZ0N3OEJwZkN0c29oc0dMOXNFMncyWUZtQitl?=
 =?utf-8?B?OUh2VmZOdDh1c0swNnJUdE9oZm1abmh1dW84ZGxza1RIeU5zTzdrRC9zb1pG?=
 =?utf-8?B?bytiMy85ZUZ3ei9rR3duSFNreXcvQ3YxS2xZZHlISFlBWHd6MWYvTTRoR1g0?=
 =?utf-8?B?cjVmdlVwcFFWVFRBWjFkNTRvTGR4ZHA5cENWZVNYTmw4UWl2K1ZKUjlKcXF1?=
 =?utf-8?B?bmRPdEFvdklhQXhWZ2l6Z0pobjgyK2VPSlh2ZUptMms4Ty85c3RJdmhIZHZl?=
 =?utf-8?B?S3dMUE1NZnNzdEQ3RGVqNGxWTDNzczBFbXI0YlhMajhycys4MFozd0pWQWpo?=
 =?utf-8?B?TndtVmIyblgvZUdXV0lqWU1VYUpKelRlRE9SNGxObklKYXBicnRVQ2dMQ2J2?=
 =?utf-8?B?NEJtNTBDQ21JS0xXYWRnWnk1TlplR2pLdmk2RkFGUHF2R2pUaVZDRFNOV0xw?=
 =?utf-8?B?VU9BRXVjM2JFTnJoMWhiQXlWa05CM3lOZTR6aUpYUGxKMmlHa0RjOXhWV1dR?=
 =?utf-8?B?emcvY1dROUJ3MVJYNnlJeGdXSEVzd25mSXNqTnY3dHY5QmcwbmZRSTFJRkdx?=
 =?utf-8?B?M1FPdFYrSHZOMU9jSEI0VTN4WnZMUW5UUVUrMEhuWXhxRXoraU5Gb3VuYnNE?=
 =?utf-8?B?OVlIQXZ5c2JWYzFsVU43K3JrMGF0VWdDYy82MFhMT0QwNWVxb0FCZUo4cHdt?=
 =?utf-8?B?dlJPbnRDOFVzOGZwU2VMWHYyWlVBM25ZY3RKNUlURW05cno4VTVwQTROUnRG?=
 =?utf-8?B?T1V4Q3V2VytsRlY1MUQyYldjOVZnaHZaQThvMkVYZ01sNFFocDFGZFFMaVNy?=
 =?utf-8?B?NGJCSzlTMk5oc05zdmR3a1RSaDJpdVg5UW53QmZ5U1d0R1E4ZHQvcW1LdWtl?=
 =?utf-8?B?OURPU2ZkTU1NWGlrMXFkZ3hQMjJwWVV6b1A5MVczakw1K1R2bGdGRkp6Y0FI?=
 =?utf-8?B?QWZSS0dicklHN2czMHIwNzNaVjdkcU1BZHRPNEhqT2xDVFNSUHU0a1RYSDhh?=
 =?utf-8?B?NHNsdkwyb0pwekRSdVRSRWEza2cydi9icElyY1lENmZjNnp0dTVha2t0c3ph?=
 =?utf-8?B?dlVid3o3Tk5pSjd5Sy9SS0x4THZVbE1rV2hOK0lyRzhsYktiSWFPb0NadU14?=
 =?utf-8?B?eFgvQnZlQ2lnR0pndG9ITUE0Sk05dXVBR2NsRjdhK0VjVFJkdTgzaVZ1R2hN?=
 =?utf-8?B?K1hHK2o4YyswQlFNTW5QeEFkSUVWQnZLbkZkSm5xckNvV3V1WXBhK3ErTm40?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFAEBEEDA66CD14FB3F3D27C5601AD40@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd709fe-1aeb-49b2-c6d2-08dd5102711c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 16:28:28.5451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K/xhF1blxzXNbOeT14aNcTc75fiyIU+wz02J41xxMQpDuMJnCpB0lOgYDAZefXQ7efgsV/BsjMO7dbl5VzOA3RyUDU3Qlcmwc85+70mdkGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8395
X-Mailman-Approved-At: Wed, 19 Feb 2025 21:04:12 +0100
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

SGkgRXRpZW5uZSwNCg0KT24gMTkvMDIvMjAyNSAxNzozMCwgRXRpZW5uZSBEdWJsw6kgd3JvdGU6
DQo+IExlIDA1LzAyLzIwMjUgw6AgMTE6MTUsIE9sZWtzaWkgTW9pc2llaWV2IGEgw6ljcml0IDoN
Cj4+IFRoaXMgcGF0Y2ggc2VyaWVzIHByb3ZpZGVzIGdlbmVyaWMgc3VwcG9ydCBmb3IgUmFzcGJl
cnJ5IFBJIDUgaW4NCltzbmlwXQ0KPg0KPiBUZXN0ZWQtYnk6IEV0aWVubmUgRHVibMOpIDxldGll
bm5lLmR1YmxlQGltYWcuZnI+DQo+DQo+IEkgYXBwbGllZCB0aGUgcGF0Y2ggb24gY29tbWl0IDZl
MzE2ZTNmMzk3YjVlMDFlOThjNWRkNTZjZGJhYWI5NjFkYWVlZGYNCj4gKEFwcmlsIDE1LCAyMDI0
KSBhbmQgdXNlZCBpdCBmb3IgbmV0d29yayBib290aW5nIGEgUmFzcGJlcnJ5IFBpIDUgaW4gYQ0K
PiBXQUxUIHBsYXRmb3JtIFsxXS4NCj4gT3VyIGJvb3QgcHJvY2VkdXJlIGlzIHF1aXRlIGNvbnZv
bHV0ZWQgYW5kIGluIHRoaXMgc3BlY2lmaWMgY2FzZSBpdA0KPiBpbnZvbHZlcyB0d28gbmV0d29y
ayB0cmFuc2ZlcnMgKGEgc21hbGwgdS1ib290IHNjcmlwdCBmaXJzdCwgd2hpY2ggaXMNCj4gdGhl
biBleGVjdXRlZCBhbmQgdHJpZ2dlcnMgdGhlIGRvd25sb2FkIG9mIGEgRklUIGltYWdlKSBidXQg
SSBoYXZlIG5vdA0KPiBub3RpY2VkIGFueSBwcm9ibGVtcy4gSSBob3BlIHRoZSByZW1haW5pbmcg
cXVlc3Rpb25zIHdpbGwgYmUgcXVpY2tseQ0KPiBzb3J0ZWQgb3V0IGJ5IGxpbnV4IGtlcm5lbCBt
YWludGFpbmVycy4gR3JlYXQgd29yayBPbGVrc2lpIQ0KPg0KPiBUaGFua3MNCj4gRXRpZW5uZQ0K
Pg0KPiBbMV06DQo+IGh0dHBzOi8vd2FsdC1wcm9qZWN0LmxpZ2xhYi5mci8NCj4NCk1hbnkgdGhh
bmtzIGZvciB0ZXN0aW5nIHRoaXMgb3V0LiBJJ20gd2FpdGluZyBmb3IgdGhlIFJhc3BiZXJyeSB0
ZWFtIHRvDQpmaW5pc2ggdXBzdHJlYW1pbmcgZHQgYmluZGluZ3MgYW5kIHRoZW4gdXBkYXRlIHRo
aXMgcGF0Y2ggc2VyaWVzLg0KDQpUb29rIGEgYnJpZWYgbG9vayBvbiBXQUxUIHBsYXRmb3JtIC0g
cHJldHR5IG5lYXQgc29sdXRpb24gQlRXLg0KDQpPbGVrc2lpLg0K
