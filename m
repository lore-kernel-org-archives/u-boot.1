Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B52BCD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 20:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16A9F847C4;
	Wed, 27 May 2026 22:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=gatech.edu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gatech.edu header.i=@gatech.edu header.b="bsSo21Zw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DD9B84837; Wed, 27 May 2026 20:56:08 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F11BD84704
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 20:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=gatech.edu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hibrian827@gatech.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrGnD8P9AvypAFE9qZ8MTxvgIn8g2MkVJbt8CJ2avQ1b67kRhLWX7HkZZBozvKXwOyfzH5dSsj518rbJS0mzgqDxiAIudGzq9CQXOZrxu3FOgsiDMJM2QcOitAaz7l0YNK5J6dY8eQqLqwPPislCVsB1gFkivuCFoNSlEtr9ZIByAb58OXlY+Ad0/2qnU0H5Nn+mggCITk+ZstI+73iijhbfiDYL1XZ3kcVGJc+z5LtYSH6ozYNMl/2cTmWEesyk4u4aTZqVLnDmuIuucLfH8G3denRjc2GWOSt0OHqDDK1OjSrU0/6stCRQRdn9SmVIon7RfSXouPN+rHp0Qo63KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJcG1UpBS2QezucewtZJ/vfNw4X3qMwlq8NcMYaEG/k=;
 b=XovlRANpCBNI92vep0e51m448xc39HnBFwHGLzzF594rYq7a/y4jlxX/v8uERIxaIYuIbHjypVaqLIYeifSi2c6aNn+D5nyqd/BcDUh27V6DHIc36Gb6xf/5+6XpezKrhgp0kuYZGmfpu57ZjdG7tRNoC8W7g9veySRExDh8C7rhdDklQ0kesdYDnN4XAdzM0PyZx+tiYdnwtlVmfgMytkmxT6EM35v/Zg8zZprSyl5Bs5Qqqt4/2BMVcTFkprbFvi4PxdBH+jrnbIW84CZT/qwsNcesowDAh7OLPCxhWQfesaeuwEWClbnAuYvInKRdJcM9WiYZEdDlKodEgmaGbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gatech.edu; dmarc=pass action=none header.from=gatech.edu;
 dkim=pass header.d=gatech.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gatech.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJcG1UpBS2QezucewtZJ/vfNw4X3qMwlq8NcMYaEG/k=;
 b=bsSo21ZwYqVKHloZsZ6qurJteTbO/6DajmPTdyuUkYTVEpeShtSBKmbJFNgpxCH5KgK6UOKC23aLXSHqFPNbcIDJ7o6Gf3wM9oIbH+M0dayQG22TNEzGwfS5gSaPUW/O0bvqLHLPiU3Pwl6w3xzaLnjiH6R3MtYpA2ZCUyHGoe4OToqbWe58eujRdL/xxD0hAMtxf5K/ttfIhu8L5xP7c759Rktzs100aqU8EKVR4kHrWgpsDgYLi4+p+Xnc76KfKlfQRUwOl5KddN/WghO8of9RZdanGuBYxnl7vLS1Y5dKVot7BO/PF791dSKue1z269mpbsMC7d4RATTnh1CXJQ==
Received: from DM6PR07MB4377.namprd07.prod.outlook.com (2603:10b6:5:bf::19) by
 SJ0PR07MB8551.namprd07.prod.outlook.com (2603:10b6:a03:370::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 18:55:58 +0000
Received: from DM6PR07MB4377.namprd07.prod.outlook.com
 ([fe80::3bd2:fc9d:167d:e059]) by DM6PR07MB4377.namprd07.prod.outlook.com
 ([fe80::3bd2:fc9d:167d:e059%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 18:55:58 +0000
From: "Lee, Brian J" <hibrian827@gatech.edu>
To: Josh Law <josh2@disroot.org>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Kim, Youngjoon" <ykim3186@gatech.edu>
Subject: Re: U-Boot TFTP OACK option parser reads past unterminated values
Thread-Topic: U-Boot TFTP OACK option parser reads past unterminated values
Thread-Index: AQHc7fPZBuT9TNeA40WBuZu80SHrt7YiHSAAgAAbhQ0=
Date: Wed, 27 May 2026 18:55:58 +0000
Message-ID: <DM6PR07MB4377F2C4B242629F7E4FE52DF6082@DM6PR07MB4377.namprd07.prod.outlook.com>
References: <DM6PR07MB43775463F18267C7C1AE8981F6082@DM6PR07MB4377.namprd07.prod.outlook.com>
 <8C6CF5D6-B9A5-4837-8D4C-86E151C7A617@disroot.org>
In-Reply-To: <8C6CF5D6-B9A5-4837-8D4C-86E151C7A617@disroot.org>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gatech.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR07MB4377:EE_|SJ0PR07MB8551:EE_
x-ms-office365-filtering-correlation-id: a0e3d5bb-ab1d-444b-1dbc-08debc2196f3
x-gt-tenant: 042d12d7-75fe-4547-b5b6-0573f80f829d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|786006|10070799003|1800799024|366016|38070700021|8096899003|13003099007|18002099003|22082099003|6133799003|56012099006|11063799006|4143699003|3023799007|4133799003;
x-microsoft-antispam-message-info: geCoNEvbZva5WTQ9BabUQ8YHB4pCcS/0fsy6pH/JkSvvJqsBojhNzFeTJyoS2H1Qa0H5b6i2IiMrmVI071pYa5vBJJ1kF6MTVrU7Xqr4QWgSZ1DnzNAGHKUXOT8RhMdfj80kmHPrL2R2cHOPimLJlXNv96GMaT8Yv8mw1jDL/ulqjVspRKGPlcVxlaH6WJEROlk44pWR496nlNMy3ZZlKQdbuzkTEA911ZH9Tp5HCFOymjcxt20ZhVH739DKVmVc26VsW/1OgUDHFJ2DKXlU+D0jiuHNP5gj5q3UZ7sVenxBs1zHEKpLysmZDQtZrfmVnlL/8nzcep9EeRCTPGfrkvMIFp/bjxS+Js0zl8XVVRrqmRu2bbUWszIE6CMwZtYNqP+ba72eUVTRY27eJr5oDmcIQgO3uqn4UpXY05lt+nolZLYJ08+d8GiOBOf+2Wo2yLF9hG6Ml2y6ZaePYn1Lap4JmHHG4F+uE/EjxsDc0DydNpyMFzw3GPZAp2Ltrhe39zFiZnco8PBelFTvwwlqhJAo6mTQrdakO3lE2I9S8+n2BpvB97enB8BjESQxfb92QlcQIu+DoC0UTeHHg2XB3nSK9+VmuxeQs+hz/UGuFWvytfKd3oZFHluFCNCclPXE3XtZipbnm2xioWiYTBptgNJstq+htUKpse1IwDY2GsUHx4/JznbJbvNGtmmA5LSqiajT6kkz6pgmnbd+KOF6GIZDNeMg4v4Djsk2DhGnMAEuy4aAuSznrR7G00+Og42C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ko; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR07MB4377.namprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(786006)(10070799003)(1800799024)(366016)(38070700021)(8096899003)(13003099007)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(4143699003)(3023799007)(4133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?ks_c_5601-1987?B?RlJEOTZOdGQzNEtLOFliWldoOWFaaVRqOTM4WGVkOGRmakYybzc5?=
 =?ks_c_5601-1987?B?K08veGpiNllra1ovbW9BenRkS1dnbGVyLzJiVHpCMjVGR1BQa1ky?=
 =?ks_c_5601-1987?B?MTZITU1tcW9ObHl4UGM2WG5NTUFDVnc3WEVGTUVVZnlOZVJhNW01?=
 =?ks_c_5601-1987?B?QjlFUkM0Vk5WTlFiUm84bXg3R09JUnc5LzBxK0dFQ2M0U1dVSWNB?=
 =?ks_c_5601-1987?B?SG1sV211blREb1hmVW1TZWJPOHl4a2dOc3pLRFBKYXhNZkh6cjli?=
 =?ks_c_5601-1987?B?VDBiUyt0clZDS2lObW0wUzhtL2tScU1odnRIcEUvVCtJYzZ1am5w?=
 =?ks_c_5601-1987?B?b21MbHB2SHY3cFMwd0g4d3FUNDFJTjdQT1RrMlNPeG0rYUJ4SDZH?=
 =?ks_c_5601-1987?B?RGJsd1Q5ZTN6VG9RUElPZWV0MWhDVG9OcjlBMnRSR1ZQeVY4RlM1?=
 =?ks_c_5601-1987?B?UjdzS1g3NUhnck5sVXY1R2N1S3pOQktlYTFlbm1GbjBoQWZRbFVP?=
 =?ks_c_5601-1987?B?V1dLZHVmd0paS1BpS3VwUVVtdURUUGdHcTVLS3krZzd5SHlZNmdZ?=
 =?ks_c_5601-1987?B?TFR0NGRZK1JqUThaSWkybW4xcmgxSkZFd0FRQlcwRG02MHY2M2FK?=
 =?ks_c_5601-1987?B?cUZFK1FjM1YwcDg4R1FvV0J0VHNsSW9USWtOWVZCQXdDQ3VuemRP?=
 =?ks_c_5601-1987?B?OTViYUNvSjNOZ2s0Nll5NmJxenMwY25Bc2FDdzlkc2MwT0txMDEw?=
 =?ks_c_5601-1987?B?c1JCckFXZ0toVG9FMm5NN0t6NmlxNEtVR1JWZkhHVUZyd0k4TWVC?=
 =?ks_c_5601-1987?B?TlpkNTZoOFZYL05NdWRYek9OTHZSQ3ZRaDJxRDd4Mm1hV09rZWpQ?=
 =?ks_c_5601-1987?B?TWp5elRIL2VWZlVTQ214MmVpeFpuSmk3ME5nTDVyQVJaYzZpMDZP?=
 =?ks_c_5601-1987?B?YTl2aS9xWXUyeGZDQUc2cmlhdVEwbkZTQmRrMTNEY2pDdWdCMzkr?=
 =?ks_c_5601-1987?B?RDF2dWdHT0ZXZlBEeHBrSkxBRWhScS80NWRncEJ0K1dGTzZDOHVu?=
 =?ks_c_5601-1987?B?eS9uaVJndFRQaWVOaXl5VnBEcCtsclJOTFBGb3JNLytCaGdCV3JI?=
 =?ks_c_5601-1987?B?bGUwTkdTTTNPSFRaTnpRSXFkaU92R1hUVnpTaWtmd3dSNFhvWVlk?=
 =?ks_c_5601-1987?B?WDBsNDVBaHp6SFdBSU1IbFcwRVFPaTV1U0JqTFpXTmxZK3lLcmt1?=
 =?ks_c_5601-1987?B?bXJqTE9HZUFhR3o2MkdCR05xWTF6Y2dHTlZMeGQvWlltaGo1M2to?=
 =?ks_c_5601-1987?B?Nm40QngwejB6aWxMNGVtM3Q3Sk5UQVdNdCsrS3RrMlBPOGI3ZWZL?=
 =?ks_c_5601-1987?B?V0ttL2gwMXFHcUI0VGNEK3hBaFdaRFhUbHZteUpVTEl4cnh4cWJu?=
 =?ks_c_5601-1987?B?MUh1N1N1RExQMElVRWRqNkRyWTJ6MkhLU2VDMDk1K3F1UStLU09J?=
 =?ks_c_5601-1987?B?TnorRFlGWU5HRk9vMW1hUnR4dG91L1RtemRUWlkrY214NmY0U2hp?=
 =?ks_c_5601-1987?B?bkpXT1d5U0d4djVlZ1BaOHRyMEExVi8zK2F2bXQxdU8wTzgxakxa?=
 =?ks_c_5601-1987?B?NndXRFVxZmVPOFBpYnJBbnpVL2d6bGtNNHNib2Fndm0rYlBaYXZ2?=
 =?ks_c_5601-1987?B?RjlrM0RlWlZHYjhzT3diL010TzVWcXYxMTBkL0NuNC83UkVWQ3NO?=
 =?ks_c_5601-1987?B?SElZbUJRTVE1cUV2OXhXUXd2aHMzaWJrVHFmNlg3QnVWMmVzL1Uw?=
 =?ks_c_5601-1987?B?M3JQY0YxbjEvOEZTVjZtcXg4N0dyTHgvUXpqSzlqVWl4M2JwVHhV?=
 =?ks_c_5601-1987?B?RTRLRWk1MEZuT0RpcGZYSmFHV1M0dTU0VGJkYWJDNXJ1dUErRzd5?=
 =?ks_c_5601-1987?B?QVFyM1dMT0lxVHJyblJhRE94MURVRkkzMkhpYkJhMGplRlkzTlVl?=
 =?ks_c_5601-1987?B?QUVETGhZeC9vMndMTnN0alVMNUxhK0hlZDZSTWoycFIxMGN0RXNV?=
 =?ks_c_5601-1987?B?Z3ZaanZFZ1JmTHhoWndvZmE0bDhKWGNDNDkrVURPb3RTSEVvU0l0?=
 =?ks_c_5601-1987?B?bis0aHM2VW9rT1pnVDNOSlZ1S1BEQWM4UXExQk9pYXp1bVRrSUQ5?=
 =?ks_c_5601-1987?B?eHJEc3NuMlZrVlNOSk0ybmNkSWNJbGgyT2JpNUx6MmMrZmVOdGhQ?=
 =?ks_c_5601-1987?B?cWxXSHp1b2JvazdyS2szU0pnaWQrZWtYT1IwQXFwaGpnSEo1Zi9w?=
 =?ks_c_5601-1987?B?bFlWU09weXI4bXBpNU9lL0VIZUN2SVJFdUdKang5QmtKNVl5bFFI?=
 =?ks_c_5601-1987?B?S1lmT1RKSGJsRG9XL2owZnRrZzlDUm0vS21JY1gzTXJjUGlNd0Rq?=
 =?ks_c_5601-1987?B?KzR0VW9nNktkdE9jVjZUclRQY3lkZVhTZWhuRmd3YjdGOTZWK3R1?=
 =?ks_c_5601-1987?B?ZzNsRDQ0OHBGdkIyd1FiMmtrZzBGQmhPV1ZuRWppSlUxZ1BzS3Fp?=
 =?ks_c_5601-1987?B?VFJmNEd5RFphUnVNYzdYVXBsWXVueXAyN2JKb0NXUCsvSVVYbkha?=
 =?ks_c_5601-1987?B?UFNYbGQyU2tnTnpnL1lPS0M4Q2ZUdHQwczNZY0ZCR1l6VU42akJY?=
 =?ks_c_5601-1987?B?OGpqSlV0cjBuY3NicVExbXNZMlJqUlQraDNETkFUa1RhZz09?=
MIME-Version: 1.0
X-OriginatorOrg: gatech.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB4377.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e3d5bb-ab1d-444b-1dbc-08debc2196f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 18:55:58.5251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 482198bb-ae7b-4b25-8b7a-6d7f32faa083
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NMGSbyTWcgAR9ZyN3FS5el2cZincddTCF/nmqic8E2zBBeC9XPEXkCSXfYvdfkDE/ERzk1rO+LojBHQa6SOsLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB8551
X-Mailman-Approved-At: Wed, 27 May 2026 22:05:00 +0200
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

VGhhbmsgeW91IGZvciB0aGUgYWNrbm93bGVkZ2VtZW50cyEgSSBhcG9sb2dpemUgcmVwcm9kdWNp
bmcgdGhlIFBvQyBoYWQgZGlmZmljdWx0aWVzIGR1ZSB0byBwb29yIHF1YWxpdHkuIEkgd2lsbCBt
YWtlIHN1cmUgdG8gaW1wcm92ZSB0aGF0LiBUaGFuayB5b3UhDQoNCkJlc3QgcmVnYXJkcywNCkJy
aWFuDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KurizvSC757b3OiBKb3NoIExh
dyA8am9zaDJAZGlzcm9vdC5vcmc+DQq6uLO9ILOvwqU6IDIwMjaz4iA1v/kgMjfAzyC89r/kwM8g
v8DIxCAxOjE2DQq53rTCILvntvc6IHUtYm9vdEBsaXN0cy5kZW54LmRlIDx1LWJvb3RAbGlzdHMu
ZGVueC5kZT47IExlZSwgQnJpYW4gSiA8aGlicmlhbjgyN0BnYXRlY2guZWR1PjsgdS1ib290QGxp
c3RzLmRlbnguZGUgPHUtYm9vdEBsaXN0cy5kZW54LmRlPg0KwvzBtjogS2ltLCBZb3VuZ2pvb24g
PHlraW0zMTg2QGdhdGVjaC5lZHU+DQrBprjxOiBSZTogVS1Cb290IFRGVFAgT0FDSyBvcHRpb24g
cGFyc2VyIHJlYWRzIHBhc3QgdW50ZXJtaW5hdGVkIHZhbHVlcw0KDQpbam9zaDJAZGlzcm9vdC5v
cmcgwPzA2iC43sDPwLsgud7B9iC+yrTCILDmv+ywoSC4ub3AtM+02S4gaHR0cHM6Ly9ha2EubXMv
TGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF2/obytIMHfv+TH0SDAzMCvIL7Lvsa6uLHi
DQoNCk9uIE1heSAyNywgMjAyNiA1OjE3OjQzIFBNIEdNVCswMTowMCwgIkxlZSwgQnJpYW4gSiIN
CjxoaWJyaWFuODI3QGdhdGVjaC5lZHU+IHdyb3RlOg0KPkhlbGxvIFUtQm9vdCBTZWN1cml0eSBU
ZWFtLA0KPg0KPk15IG5hbWUgaXMgQnJpYW4gTGVlLCBhbmQgSSBhbSBhIFBoRCBTZWN1cml0eSBS
ZXNlYXJjaGVyIGluIFNTTGFiIGF0DQo+R2VvcmdpYSBUZWNoLiBJJ2QgbGlrZSB0byBwcml2YXRl
bHkgcmVwb3J0IGEgcG90ZW50aWFsIGRlbmlhbC1vZi1zZXJ2aWNlDQo+aXNzdWUgZHVlIHRvIGlu
c3VmZmljaWVudCBzY2FuIHRlcm1pbmF0aW9uIGluIE9BQ0sgb3B0aW9uIHBhcnNlciBpbiBURlRQ
Lg0KPkEgcmVtb3RlIHVuYXV0aGVudGljYXRlZCBURlRQIHNlcnZlciBzZWxlY3RlZCBieSB0aGUg
VS1Cb290IGNsaWVudCwgb3IgYW4NCj5hdHRhY2tlciBhYmxlIHRvIHNwb29mIHRoZSBleHBlY3Rl
ZCBzZXJ2ZXIncyBmaXJzdCBPQUNLIHRvIHRoZSBjbGllbnQncw0KPlRGVFAgc291cmNlIHBvcnQs
IGNhbiBzZW5kIGEgc2luZ2xlIG1hbGZvcm1lZCBPQUNLIGR1cmluZyBhbiBvcmRpbmFyeSBURlRQ
DQo+Z2V0LCBib290LCBvciB1cGRhdGUgZmxvdy4NCj4NCj5UYXJnZXQ6DQo+DQo+ICAqDQo+UHJv
amVjdDogdS1ib290DQo+ICAqDQo+UmVwbzogaHR0cHM6Ly9uYW0xMi5zYWZlbGlua3MucHJvdGVj
dGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZ2l0aHViLmNvbSUyRnUtYm9vdCUy
RnUtYm9vdCZkYXRhPTA1JTdDMDIlN0NoaWJyaWFuODI3JTQwZ2F0ZWNoLmVkdSU3QzgwNDVkZjBj
OTE3ZTQyMTQ0NmI3MDhkZWJjMTNhOWI5JTdDNDgyMTk4YmJhZTdiNGIyNThiN2E2ZDdmMzJmYWEw
ODMlN0MxJTdDMCU3QzYzOTE1NDk4OTgwODM1NzM2NyU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhl
eUpGYlhCMGVVMWhjR2tpT25SeWRXVXNJbFlpT2lJd0xqQXVNREF3TUNJc0lsQWlPaUpYYVc0ek1p
SXNJa0ZPSWpvaVRXRnBiQ0lzSWxkVUlqb3lmUSUzRCUzRCU3QzQwMDAwJTdDJTdDJTdDJnNkYXRh
PXRZcUxjazlZdVNEdjE5OXYwNWJ1TXZ3MTF3OTlQRm9jWTJySXM2OXdEeTglM0QmcmVzZXJ2ZWQ9
MDxodHRwczovL2dpdGh1Yi5jb20vdS1ib290L3UtYm9vdD4NCj4gICoNCj5QaW5uZWQgcmVmOiAy
MTU0OTZmZWM1OWIzZmEwOTI1NmI0ZmI2MmY5MmFmNDZlMmVjN2Y5DQo+DQo+VGhyZWF0IG1vZGVs
Og0KPg0KPlUtQm9vdCBkb2N1bWVudHMgVEZUUCBib290L2Rvd25sb2FkIGNvbW1hbmRzIGFuZCBv
cHRpb25hbCBhdXRvbWF0aWMgVEZUUA0KPnVwZGF0ZTsgYSBzZWxlY3RlZCBvciBzcG9vZmVkIFRG
VFAgc2VydmVyIGNhbiBzZW5kIHRoZSBmaXJzdCBPQUNLIHdpdGhvdXQNCj5hdXRoZW50aWNhdGlv
bi4gVGhlIHJlcXVpcmVkIHBhY2tldCBpcyBhIHNpbmdsZSBtYWxmb3JtZWQgT0FDSyBkdXJpbmcg
YW4NCj5vcmRpbmFyeSBURlRQIFJSUSBmbG93LCB3aXRoIG5vIGNyZWRlbnRpYWxzIG9yIG11bHRp
LXN0ZXAgcmFjZSBiZXlvbmQNCj5iZWluZyB0aGUgc2VsZWN0ZWQvc3Bvb2ZlZCBzZXJ2ZXIgcmVz
cG9uc2UuDQo+DQo+QXR0YWNoZWQ6DQo+DQo+ICAqDQo+UkVBRE1FLm1kIDogZnVsbCB3cml0ZXVw
Lg0KPiAgKg0KPnBvYy9ydW4uc2ggOiAgYWxsb2NhdGVzIGFuIGV4YWN0LWxlbmd0aCBURlRQIHBh
Y2tldCBjb250YWluaW5nIG9wY29kZQ0KPjB4MDAwNiAoT0FDSyksIG9wdGlvbiBuYW1lIGJsa3Np
emUsIGEgTlVMIGFmdGVyIHRoZSBvcHRpb24gbmFtZSwgYW5kIG9uZQ0KPnZhbHVlIGJ5dGUgKDUp
IHdpdGhvdXQgdGhlIHJlcXVpcmVkIHZhbHVlLXRlcm1pbmF0aW5nIE5VTC4gSXQgdGhlbiBjYWxs
cw0KPnRoZSBtb2RlbGVkIHRmdHBfaGFuZGxlcigpIGFzIHRoZSBmaXJzdCBzZXJ2ZXIgcmVzcG9u
c2UgdG8gYSBjbGllbnQgUlJRLA0KPndpdGggZGVzdGluYXRpb24gcG9ydCAxMDY5IGFuZCBzb3Vy
Y2UgcG9ydCA2OSwgbWF0Y2hpbmcgdGhlIGd1YXJkIHN0YXRlDQo+dGhhdCBhY2NlcHRzIGFuIGlu
aXRpYWwgT0FDSyBiZWZvcmUgdGhlIHJlbW90ZSBwb3J0IGlzIHBpbm5lZC4NCj4gICoNCj5wb2Mv
aW5wdXRzOiB0aGUgcmVsZXZhbnQgZmlsZXMgZm9yIHJ1bm5pbmcgcG9jDQo+DQo+SSB3b3VsZCBs
aWtlIHRvIGdldCBoZWxwIGZyb20geW91ciBleHBlcnRpc2UgdG8gY2xhcmlmeSB3aGV0aGVyIHRo
aXMgaXMgYQ0KPnZhbGlkIHNlY3VyaXR5IHRocmVhdCBvciBub3QuIFRoYW5rIHlvdS4NCj4NCj5C
ZXN0IFJlZ2FyZHMsDQo+QnJpYW4gTGVlDQo+DQo+DQoNCkhleSBCcmlhbiwNCg0KVGhlc2UgYnVn
cyBsb29rIHBsYXVzaWJsZSB0byBtZS4NCg0KSWYgbWFpbnRhaW5lcnMgd2FudCBmaXhlcyB0YWdz
LA0KDQpGb3IgT0FDSzoNCkZpeGVzOiA1M2E1YzQyNGJmODYgKCJtdWx0aWNhc3QgdGZ0cDogUkZD
MjA5MCIpDQoNCg0KRm9yIHNob3J0IGFjazoNCkZpeGVzOiAxZmI3Y2Q0OThlNmEgKCJuZXQ6IHRm
dHBwdXQ6IGltcGxlbWVudCB0ZnRwIGxvZ2ljIikNCg0KSSBkb24ndCB0aGluayB0aGUgZXJyb3Ig
Y2FzZSBuZWVkcyBhIGZpeGVzIHRhZywgaXQgY2FtZSB1cCBvbiB0aGUgdmVyeQ0KZmlyc3QgY29t
bWl0Lg0KDQoNCkkgdHJpZWQgdGVzdGluZyBvbiBteSBhcm0gYm94IHVzaW5nIHlvdXIgc2NyaXB0
Og0KDQpBZGRyZXNzU2FuaXRpemVyOiBDSEVDSyBmYWlsZWQ6IHNhbml0aXplcl9hbGxvY2F0b3Jf
cHJpbWFyeTY0Lmg6MTMxDQogICIoKGtTcGFjZUJlZykpID09ICgoYWRkcmVzc19yYW5nZS5Jbml0
KFRvdGFsU3BhY2VTaXplLA0KICBQcmltYXJ5QWxsb2NhdG9yTmFtZSwga1NwYWNlQmVnKSkpIg0K
ICAoMHg1MDAwMDAwMDAwMDAsIDB4ZmZmZmZmZmZmZmZmZmZmNCkgKHRpZD0zMTg2KQ0KICAgICAg
PGVtcHR5IHN0YWNrPg0KDQoNCg0KaXQgc2VlbXMgdG8gYmUgYSAibXkgaG9zdCIgaXNzdWUNCg0K
DQoNCk5vdGU6IEkgcmVwcm9lZCB1bmRlciB2YWxncmluZDoNCg0KDQpqb3NoQGFybWJveDp+JCB2
YWxncmluZCAtLXF1aWV0IC0tZXJyb3ItZXhpdGNvZGU9OTkgL3RtcC9icmlhbi11LWJvb3QtcG9j
cy8NCiAgb2Fja192ZzsgZWNobyAiZXhpdD0kPyINCiAgPT0zMzY2PT0gSW52YWxpZCByZWFkIG9m
IHNpemUgMQ0KICA9PTMzNjY9PSAgICBhdCAweDEwOEEwODogZGVjdG91bCAoaGFybmVzcy5jOjMz
KQ0KICA9PTMzNjY9PSAgICBieSAweDEwOEI5MzogdGZ0cF9oYW5kbGVyIChoYXJuZXNzLmM6MTE5
KQ0KICA9PTMzNjY9PSAgICBieSAweDEwOEU4RjogbWFpbiAoaGFybmVzcy5jOjE4MikNCiAgPT0z
MzY2PT0gIEFkZHJlc3MgMHg0YThmMDRiIGlzIDAgYnl0ZXMgYWZ0ZXIgYSBibG9jayBvZiBzaXpl
IDExIGFsbG9jJ2QNCiAgPT0zMzY2PT0gICAgYXQgMHg0ODg1NDVDOiBtYWxsb2MgKHZnX3JlcGxh
Y2VfbWFsbG9jLmM6NDQ2KQ0KICA9PTMzNjY9PSAgICBieSAweDEwOEU0QjogbWFpbiAoaGFybmVz
cy5jOjE3NikNCg0KICA9PTMzNjY9PSBJbnZhbGlkIHJlYWQgb2Ygc2l6ZSAxDQogID09MzM2Nj09
ICAgIGF0IDB4NDg4RTdBNDogX19HSV9zdHJsZW4gKHZnX3JlcGxhY2Vfc3RybWVtLmM6NTA2KQ0K
ICA9PTMzNjY9PSAgICBieSAweDQ5MUNDODc6IHByaW50ZiAocHJpbnRmLmM6MzMpDQogID09MzM2
Nj09ICAgIGJ5IDB4MTA4QkNGOiB0ZnRwX2hhbmRsZXIgKGhhcm5lc3MuYzoxMjApDQoNCiAgQmxv
Y2tzaXplIG9hY2s6IDUsIDUNCiAgZXhpdD05OQ0KDQogIGpvc2hAYXJtYm94On4kIHZhbGdyaW5k
IC0tcXVpZXQgLS1lcnJvci1leGl0Y29kZT05OSAvdG1wL2JyaWFuLXUtYm9vdC1wb2NzLw0KICBh
Y2tfdmc7IGVjaG8gImV4aXQ9JD8iDQogID09MzM2Nz09IEludmFsaWQgcmVhZCBvZiBzaXplIDIN
CiAgPT0zMzY3PT0gICAgYXQgMHgxMDhBMUM6IHRmdHBfaGFuZGxlciAodWJvb3RfdGZ0cF9hY2tf
aGFybmVzcy5jOjY3KQ0KICA9PTMzNjc9PSAgICBieSAweDEwOEJFQjogbWFpbiAodWJvb3RfdGZ0
cF9hY2tfaGFybmVzcy5jOjExMSkNCiAgPT0zMzY3PT0gIEFkZHJlc3MgMHg0YThmMDQyIGlzIDAg
Ynl0ZXMgYWZ0ZXIgYSBibG9jayBvZiBzaXplIDIgYWxsb2MnZA0KICA9PTMzNjc9PSAgICBhdCAw
eDQ4ODU0NUM6IG1hbGxvYyAodmdfcmVwbGFjZV9tYWxsb2MuYzo0NDYpDQogID09MzM2Nz09ICAg
IGJ5IDB4MTA4QkEzOiBtYWluICh1Ym9vdF90ZnRwX2Fja19oYXJuZXNzLmM6MTA0KQ0KDQogIGV4
aXQ9OTkNCg0KICBqb3NoQGFybWJveDp+JCB2YWxncmluZCAtLXF1aWV0IC0tZXJyb3ItZXhpdGNv
ZGU9OTkgL3RtcC9icmlhbi11LWJvb3QtcG9jcy8NCiAgZXJyb3Jfdmc7IGVjaG8gImV4aXQ9JD8i
DQogID09MzM2OD09IEludmFsaWQgcmVhZCBvZiBzaXplIDINCiAgPT0zMzY4PT0gICAgYXQgMHgx
MDhBNzg6IHRmdHBfaGFuZGxlciAodWJvb3RfdGZ0cF9lcnJvcl9oYXJuZXNzLmM6NTgpDQoNCiAg
PT0zMzY4PT0gSW52YWxpZCByZWFkIG9mIHNpemUgMQ0KICA9PTMzNjg9PSAgICBhdCAweDQ4OEU3
ODg6IF9fR0lfc3RybGVuICh2Z19yZXBsYWNlX3N0cm1lbS5jOjUwNikNCiAgPT0zMzY4PT0gICAg
YnkgMHg0OTFDQzg3OiBwcmludGYgKHByaW50Zi5jOjMzKQ0KICA9PTMzNjg9PSAgICBieSAweDEw
OEE5NzogdGZ0cF9oYW5kbGVyICh1Ym9vdF90ZnRwX2Vycm9yX2hhcm5lc3MuYzo1NykNCg0KICA9
PTMzNjg9PSBJbnZhbGlkIHJlYWQgb2Ygc2l6ZSAyDQogID09MzM2OD09ICAgIGF0IDB4MTA4QTlD
OiB0ZnRwX2hhbmRsZXIgKHVib290X3RmdHBfZXJyb3JfaGFybmVzcy5jOjYwKQ0KDQogIFRGVFAg
ZXJyb3I6ICcnICgwKQ0KICBTdGFydGluZyBhZ2Fpbg0KDQogIGV4aXQ9OTkNCg0KVGhhbmtzIQ0K
