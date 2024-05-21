Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72274C25B7A
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 13:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 521A688770;
	Tue, 21 May 2024 15:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iris-sensing.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iris-sensing.com header.i=@iris-sensing.com header.b="MIuYrzjI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91A7388709; Tue, 21 May 2024 10:16:44 +0200 (CEST)
Received: from DEU01-BE0-obe.outbound.protection.outlook.com
 (mail-be0deu01on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2622::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93C5D88477
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 10:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=iris-sensing.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Michael.Glembotzki@iris-sensing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fb7NjyzoktY0VAh9JPhb415jBbKO/Q8Rz54ut79Zlt0HOXcAq+w8xmBKYboAMAqxnz5937gjnCh9bthO+9Pyr+sn7SqaEpLAQMt9oHl6L2LujiNcMGZiVU9CWJdamsffTpPMu8GF9v6Wc2MN5YXKXui8TVVgCgJXE5aDEvIQXSfo2010mSnzzDNT69pCHUQDTAsM3uxAf6Az3qqM8pHxAarq7GdleQMldO17CgDiej5zQ8aGD5NEUhnHeYL+Zf/+4UuGm0ENDUKhsrpgV7XTbfLwSTlrEBG0g+TdVxsIaL+iG1oRQyl7vBqVza1AKcoyuEfcorFWOQL8z2FU5bFV+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGDj8QPzDpjREB9PQFsDBRhbDGW/7pVRyejYi/oI6uI=;
 b=ERuIAoy6MTHXaHpRdwQ8t0YJtpyxlrE9XTw53EJS4rcmogg2RwWi5j3/eMzL0QnKf7z2qRJ7ViE0DyAxe7pTbFVX4afStml2RUrT4wjRb93gk0comhesmkTQnEd5uBBts7+o5VdpkcAQ4bP5O6gs+1TopBoCF6KovL1x296Xq13y/t79bUKUZt/SnK74GqJRcoHlwfJcgOZ/+/DdjPxof9pwtDR7PThh+bVbLODStoYbOZ9aVqflD7NvFUrNQ3ksXHBRxkS3T8j92tUyb0tUxCi35Ad20YoJUY/DUxaCLdcOSPtMii49vHQqXMPW/DgVEQMNifGUqJTqyxNJu+eApw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iris-sensing.com; dmarc=pass action=none
 header.from=iris-sensing.com; dkim=pass header.d=iris-sensing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iris-sensing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGDj8QPzDpjREB9PQFsDBRhbDGW/7pVRyejYi/oI6uI=;
 b=MIuYrzjImuZTuCr4r9sdQaRawWuRdiwEpjrIo9fx0Py50JUATyn0T7VZbZPRTZXBp0msUViEiGv7312F7naSb6l+NNcpm6ms1Ro+xTfZ6nA+gIMl9ZH4CqVdEbGN77F4vbzfSnZe8pJP8V9JOHPBgAcM6Z8wdQbYTqAfOThR5dyhY09FYoQ/F0C3cWNJaqX549eRHJAdxNpln3yWgckt5wmNlr9UnZIfv49RQ7voFC1j2rEG7uOTw+bqRz47w0eC8KunTHyA3xr+kaXi8B3JhQxJVHzRpl74WUuvpB0iAhj+o/Puw8BLBZiUEvfUy5DilU10dK4mxTuKO13DEq75iA==
Received: from BEZP281MB2343.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:47::12)
 by BE1P281MB3333.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:48::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.17; Tue, 21 May
 2024 08:16:39 +0000
Received: from BEZP281MB2343.DEUP281.PROD.OUTLOOK.COM
 ([fe80::df8c:4a9e:93b1:490c]) by BEZP281MB2343.DEUP281.PROD.OUTLOOK.COM
 ([fe80::df8c:4a9e:93b1:490c%6]) with mapi id 15.20.7611.016; Tue, 21 May 2024
 08:16:39 +0000
From: Michael Glembotzki <Michael.Glembotzki@iris-sensing.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "joe.hershberger@ni.com"
 <joe.hershberger@ni.com>, Jasper Orschulko <jasper@fancydomain.eu>
Subject: AW: [PATCH] env: Invert gd->env_valid for env_mmc_save
Thread-Topic: [PATCH] env: Invert gd->env_valid for env_mmc_save
Thread-Index: AQHaos6nvxZA3W+RXkmfkwkGCZED4bGb0OgAgAQurQCAAWO9xQ==
Date: Tue, 21 May 2024 08:16:38 +0000
Message-ID: <BEZP281MB2343D5A2FB07C223DF5624CAB9EA2@BEZP281MB2343.DEUP281.PROD.OUTLOOK.COM>
References: <20240510113834.826783-1-jasper@fancydomain.eu>
 <20240517185144.GM2568172@bill-the-cat>
 <4EDE5074-4AE2-4FFA-A713-9A9060232836@fancydomain.eu>
In-Reply-To: <4EDE5074-4AE2-4FFA-A713-9A9060232836@fancydomain.eu>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iris-sensing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2343:EE_|BE1P281MB3333:EE_
x-ms-office365-filtering-correlation-id: 4f743132-0d47-47b1-100b-08dc796e56d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VUpuc3hjaWtOVXBOcnhSRXdHZXlkaytFNW0wN2ZXeFhuQ1RCaWVMTk5UbVI1?=
 =?utf-8?B?c0I3VExER0ZmMExoRVlWYlpnMUQrVkZoOGNmOExIaTBHdDFza3lDTnhQanlh?=
 =?utf-8?B?anlTRHlLRE9LL3g5NG1LSTA3RG90TkZRKzhtQzR1dzhlYUwxNUJkSzZMUkRV?=
 =?utf-8?B?SDJTVUQwT1dzYnJNeTFLTEZacGtsdUdLUmwvQWtXcEZmd2pJT1gzYmVxRUwy?=
 =?utf-8?B?aWlDbFdaOGRwVGUrbmk3cHMxNEtIZ0FSQkQ1dXlRY2RSNXRaemhwWFc4OUxT?=
 =?utf-8?B?TkJOaDJlTGtTMzcveFBjUnlWNUVKeU45Snc0Vk1udnBCa2NWYW1jeFczM2lR?=
 =?utf-8?B?WVhDZUROY0p5VzFUL1NHNUVSSGRBTE5abGR5MHpNSVpKU0VnTmdlVlZtT2FB?=
 =?utf-8?B?ZVRUWHlSZnltRWtVR3BPNlBoUkVWOWZtZURncXFoSVNUcGM5akpxYWpCWFJK?=
 =?utf-8?B?blE5S0hjT1J1VGEvejRUcUo0QUhXMVI1M0pWVHZIWmtmN1J5N1ZrR2s0SXls?=
 =?utf-8?B?K2hzT1J4aGRoOHBDTFRuS2o5a0cvcWxiYzU0Z3B3UFFlaE43R3hKT0ZNdnh3?=
 =?utf-8?B?Vk0wWUpkdVRPSGZsZVZGaE1aOHJZTUM3NEdQVEQwOUkvMGtQaytSWnp1eUtZ?=
 =?utf-8?B?MUp3bnhmNkYvOFY4UWVSeFIzelM2K0E3N25OTFZnWW9hOWxPeXl6ZFZRdDFQ?=
 =?utf-8?B?a2wvUG84SGhMYjAyZ1BnTDB3Tm9qT3c1ejE0UjBMSkt2SThYTlJLVzdDamM3?=
 =?utf-8?B?eEQwQ0F3TDA2VDFqendTdnlsK1VVTGZUTmtieVErOG1waHNQLzBFUGcwcXl4?=
 =?utf-8?B?eFRzcC9ldmpOQXRGdjNlVjNKb1ZjVjhxNEhWejNDQ2JGZEhvZFZBNFFadE5R?=
 =?utf-8?B?dmRzd1JvVGM2WnoxeWdOSGV5cDZOOWw3KzcxZ1VZbDl6aThRYmFkcDJIc1Qr?=
 =?utf-8?B?VEdvWEFTMUx5WU10a0YxenptcHVNZ2lNWWlJR0prZnI0N3hrZzZiTExNZUxL?=
 =?utf-8?B?dVdhWDFkRGZlci9VTWh5M2ZUOGJrdjRqTVdIM2tRcFRvQzFRTUJhdmdtLzVX?=
 =?utf-8?B?eWpYaS9NeHlBMzgwdlk2MldMWkxUdFpxY1Vab09CaEQ3T1lteTJLcUJMZXFw?=
 =?utf-8?B?SlpnTjdoeC9WUEUrTUtxSy9aWXFNalo2a2NEanlrZUIyWFJGQ1dmRStwYkZ2?=
 =?utf-8?B?bDYzSjFYZERlNzZQdzNPcUJnSHNDMWx1aEVBMkxVcFFzdFQzSkZlVTA1TmZX?=
 =?utf-8?B?OWhZWG5tNmhaNkZjaGJuZXArYlJ0R3d2cWdzdW1yTHExQUZvZTJxcEhOSjFi?=
 =?utf-8?B?cEorcDFrUDdoZnZyTkwrTGpFS1VIemxBM0Rlb3MwRTRiUFk5cGh1bC95bytF?=
 =?utf-8?B?eWtNY2lIRzB0Ykg1N2dVTHFUKzllSk9BOElLWGJBaXJxd2xzZ2hyOVN6Yzgr?=
 =?utf-8?B?TmZPMS8yWjhBQ0Q2b2pMdmUxb1c0aUxkS2JHeDJ5cGplVEVSMmh6ODBDZGNy?=
 =?utf-8?B?U3JXVlVzRG54VWVYUGlyR0FrS2JGWm53a3lTZmdMQ3dKc3VUdkg4Y3VieGpp?=
 =?utf-8?B?dkczNHlaK2pyNlBiTzdFeGJMSDY4K2xBNFFaTHNUbnVKSzhhZG5jSUtEUTE0?=
 =?utf-8?B?cXNzdnBKZTB0ak5pb2FnSng2RFJnNXFoWlp2Ui82cUZtcEFoYzJRalNtKzdJ?=
 =?utf-8?B?N3FyVTNwUE11d2FSY1hCeTMrbGh0VlNRMXh5dnE5MVVnempSRU8zVFUveXR1?=
 =?utf-8?B?RnpVenhkL2w2YjdteE95N08rYWZaUmZUYUVTUVh0WGRDNzBEcW53UW9Wa3pY?=
 =?utf-8?B?MXRSZnlJRWpXRlE4ZmlLUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BEZP281MB2343.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1ZVeE4vODhaOGk5ekd4emxxSzVLZEVEbjdGeDlJZWh1MnRHdGxzdFUrZWk5?=
 =?utf-8?B?UjZpbjY5eFFPaWt4OUFVd3hrVEJ2ZnFhUGtWVFp4N2U0NE5sdTBBQUF5dlZU?=
 =?utf-8?B?TWZTbk5GcTBWcUQvYmJiU3MxQzlBbFp3aHppZ3dXcFFHQkFvL0JEOFBycWhR?=
 =?utf-8?B?Q21MWk5rU29BdUtFMnRtRjArYk5RbDJBa0ZFZTBmenZURVpRdE1Gem9mSUNZ?=
 =?utf-8?B?MEhGMXZwYXp2eGpSRkZYOTB1TGFLQXBvY25RSEhORzZvbGRIZDhwUGxBVHN5?=
 =?utf-8?B?dzhTckdsZ2E4YWlmdHJvTGRkTXZ5ckdEVzIzZWNSeDdvSFVQOWh3UHdnNG04?=
 =?utf-8?B?OVVmbUNXeUlIaGhJVGJEQVJBaUxYY21JWUNaVS95Ym8wTkcwQU5KQiszRk16?=
 =?utf-8?B?Yk1UcUNWT1l0UnJCMjdmczNOS3ZkTjNTSmkrbmtUd2d1ZC8ydE5WZ3YzWmF3?=
 =?utf-8?B?Z3ZFeXhEd0NnTVpIVFhqaysvclA0c1BlMWQ5NWpTYVJnRGdVd2VpMXZ3WmNT?=
 =?utf-8?B?Ny9qTU9qS2VtSnNoUUFhOWp5RUJPektKQ1lCc2V2ODh1U1dWWUNucE9NNG9M?=
 =?utf-8?B?TWN6bDd2aW8zRnV4cWhPWkovNS9EdHdJbmR1RHB5QjNwaE0vTHU4WVBWMld2?=
 =?utf-8?B?eXFFQ244TUZJdjlnejNDZEJoMmlXcTJsZGJBVHB6WU1WUy9uVTEvZHliY09V?=
 =?utf-8?B?UUNPeDJlTmZXbnV2RnhuTlMyTGxjZ0NTVnorYThldzdpcG4ra05zK2lpTVlL?=
 =?utf-8?B?RUsydFU3Q1FudXJvVlV0c29PWVJFR2JrMmxSeUpWTmNPTXd1U2laTlRiRXBu?=
 =?utf-8?B?T1pWQTc5Q3pMMDNNQ3MrY0ptd2hYUlBFRjd2VDJFc0tHVThFRVgyZlFMSFF3?=
 =?utf-8?B?QXN3UmVpQ0h2V1dLbVk2ZDliYmZ4cVRmNGdaVWUzbWF5RkJuSHNtR3dWQVIx?=
 =?utf-8?B?SWZvWDY2M3hGRzNmZDh1R3J0R0FvSjJ2azNXbWVjcTlubkhoLzRISE5jN3lv?=
 =?utf-8?B?NEdnMmFSTVpiV0NjR2JmMy9YaURvcVVRWnFUdVoydXFSMGU4T1pJQ2s5Z2dY?=
 =?utf-8?B?VmZaMHZzYnp3cFhlUUx2V1BhVkNIYVNwb1RnbWdMdEE2R1VKeFV6UytNU3h1?=
 =?utf-8?B?Tyt4cWZRKzlEMUxQa21VYjZFVURWdTNyMFFqUFJDVTB6S3pqSC9jbVl0QmFi?=
 =?utf-8?B?bmtiV3VNdWRvT05FTFZzcUVSS29INEhJNmE3eFJxUjdNa2JSaGF2NmNUbWZq?=
 =?utf-8?B?eFNOOWEyZjZBVlF4M3JtdUxndlF3TnRTTmRHcjQxbEs1QU1pYWZsUUhIdXl3?=
 =?utf-8?B?d2ZjU21hVUVTemI4RGkzQUN1TytjaTNuSHBtK1hSRmI2V0M0bGRSdGIrRGVs?=
 =?utf-8?B?YmVBQldBVGt4VnpuZGdSbGtGTEd3WStpekNrdk5USTY1aHpORlpQS3NxbnY2?=
 =?utf-8?B?RzZjNzErbW4zeHR4TTVOWWdFbUI3dU1lWTJXRDNOZm9jbllzN3NUOG1Hd2lR?=
 =?utf-8?B?aXczQzJhRjRyWHlLM1ZlM29sSVF2U2dkNjZuMFJRSEhkdmNlMUN3Mnc4cmZz?=
 =?utf-8?B?TnhYV1hPTXBNRVJOOXoyaWVCN0U5OHJ0akxsUzhMWGJPRkZ3MDU4MnE0QVRW?=
 =?utf-8?B?K0J1MENIajlJa0hqdG53ZFN2VytTU0V0MkJuT01QbkJTdW02c1BzYWdkeTJJ?=
 =?utf-8?B?aXJOdWd3bytQZWtoQktyRG1kUWVHZ2NseUNUTGZudk4rSEhHeFZINWNreEtC?=
 =?utf-8?B?S2VnYisxVnpWTTMydlF4RE1HQnNTanMvWHY0K2g3TkVHTG42cXc1Zjk4UVBO?=
 =?utf-8?B?TzFvMFM4d0dyUkViV0d1eWtmNU5hQW5HTFo0NDlnMTlBTjZRSFhWb2F4bnlM?=
 =?utf-8?B?OEZIYUtwdEJDL1haZlA1aDBZS25saThkL01VRWxqQi9rMklERHY2L05sVUth?=
 =?utf-8?B?ZDQ1VmJjWkdTWFRqOEc2L1FVSW9Dc1pZTzB0UHo3YklHVmNDR1lNKzFTc3ln?=
 =?utf-8?B?ZnBONWdXVjZyakFZTGpWVTlFTzk4TlV4SG5vT1EwRHEreWtiTEg5RzBsdWhK?=
 =?utf-8?B?Z3hVeVB6U1UrTXNJamN4Q0VxUTlyVEs5UGREOFdibVNudlBVY2RiK1VkaWxR?=
 =?utf-8?B?N2x1Nmh2S1EvdjBPRUFBVUlSTU1wV3VNWkVYdEEyb0xhMmNPZTB3d2xIdmdH?=
 =?utf-8?Q?7c6DoPU/KW+8u3iJoD0gOPn1UECWFegrHDpMcWpv0HwP?=
MIME-Version: 1.0
X-OriginatorOrg: iris-sensing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2343.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f743132-0d47-47b1-100b-08dc796e56d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 08:16:38.9397 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 963f3913-ffae-43fd-856b-2dfd3f6604e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e3Kj9IK77zWuNVl6LeSUyBsQuxPvnF7l1AW9ZDYMovTh1rzNsq8AcYF7ywprJ+cTaItM5n/CVTHxWDJxocYiTmVu8psVHl6FihCiuMMuxHIM4McBS3NypRShAn0IWbh+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB3333
X-Mailman-Approved-At: Tue, 21 May 2024 15:05:46 +0200
Content-Type: text/plain; charset="utf-8"
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

SGkgVG9tLA0KDQo+IOKAi0NhbiB5b3UgcGxlYXNlIGV4cGxhaW4gYSBsaXR0bGUgbW9yZSBvbiBo
b3cgeW91IGdldCB0byB0aGlzIHByb2JsZW0/IFRoZQ0KPiBzYW1lIGNvZGUgLyB0ZXN0IGV4aXN0
cyBpbiBlbnYvZmF0LmMsIGVudi9zZi5jIGFuZCBlbnYvdWJpLmMuIEluIHRoZQ0KPiBjYXNlIG9m
IGVudi9tbWMuYyBpdCdzIGJlZW4gdGhhdCB3YXkgc2luY2UgaW50cm9kdWN0aW9uIGluOg0KPiBj
b21taXQgZDE5NmJkODgwMzQ3MzczMjM3ZDczZTBkMTE1YjRkNTFjNjhjZjJhZA0KDQpTdXJlISBX
ZSBoYXZlIGxpbWl0ZWQgdGhlIHdyaXRhYmxlIHUtYm9vdCBlbnZzIHRvIGEgZmV3IChFTlZfV1JJ
VEVMSVNUKSBhbmQNCm90aGVyd2lzZSBvbmx5IHVzZSB0aGUgZGVmYXVsdCBzZXQuIFRoYXQgbWVh
bnMgb3VyIGVudl9nZXRfbG9jYXRpb24gbG9va3MNCmxpa2UgdGhpczoNCg0KZW51bSBlbnZfbG9j
YXRpb24gZW52X2dldF9sb2NhdGlvbihlbnVtIGVudl9vcGVyYXRpb24gb3AsIGludCBwcmlvKQ0K
ew0KICAgIGlmIChvcCA9PSBFTlZPUF9TQVZFKSB7DQogICAgICAgIGlmIChwcmlvID09IDApDQog
ICAgICAgICAgICByZXR1cm4gRU5WTF9NTUM7DQogICAgfSBlbHNlIHsNCiAgICAgICAgaWYgKHBy
aW8gPT0gMCkNCiAgICAgICAgICAgIHJldHVybiBFTlZMX05PV0hFUkU7DQogICAgICAgIGlmIChw
cmlvID09IDEpDQogICAgICAgICAgICByZXR1cm4gRU5WTF9NTUM7DQogICAgfQ0KICAgIHJldHVy
biBFTlZMX1VOS05PV047DQp9DQoNClRoZSBlbnYgbG9jYXRpb24gd2hlbiBzYXZpbmc6DQowLiBF
TU1DDQoNClRoZSBlbnYgbG9jYXRpb24gd2hlbiBsb2FkaW5nOg0KMC4gTk9XSEVSRSAoZGVmYXVs
dCBlbnZzKSBhbmQgaXMgYXBwZW5kZWQgYnkgdGhlIGZpbHRlcmVkIGVudnMgZnJvbSB0aGUNCjEu
IEVNTUMNCg0KV2UgYWxzbyBoYXZlIENPTkZJR19FTlZfT0ZGU0VUX1JFRFVORCBhbmQgQ09ORklH
X1NZU19SRURVTkRBTkRfRU5WSVJPTk1FTlQNCmFjdGl2ZS4NCg0KV2hlbiBib290aW5nIGZvciB0
aGUgZmlyc3QgdGltZSwgdGhlIGZvbGxvd2luZyBoYXBwZW5zIHRvIHRoZSB1LWJvb3QgZW52J3MN
CmR1cmluZyBsb2FkKCk6DQoxLiDigItlbnYvbm93aGVyZS5jOiBlbnZfbm93aGVyZV9sb2FkIHNl
dHMgZ2QtPmVudl92YWxpZCA9IEVOVl9JTlZBTElEDQoyLiBlbnYvbW1jLmM6IGVudl9tbWNfbG9h
ZCBkb250IHRvdWNoIGdkLT5lbnZfdmFsaWQgYW5kIHN0YXlzIEVOVl9JTlZBTElEDQogIGVudl9t
bWNfbG9hZCAtPiBlbnZfaW1wb3J0X3JlZHVuZCAtPiBlbnZfY2hlY2tfcmVkdW5kIC0+IHJldHVy
biAtRU5PTVNHDQoNCmdkLT5lbnZfdmFsaWQgcmVtYWlucyB1bmNoYW5nZWQgYXQgRU5WX0lOVkFM
SUQgYmVjYXVzZSB0aGVyZSBhcmUgbm8gdmFsaWQNCmVudidzIGluIGJvdGggTU1DIGFyZWFzIChi
YWQgQ1JDKSBhbmQgdGhpcyBjcmVhdGVzIGEgcHJvYmxlbSB3aXRoDQplbnZfbW1jX3NhdmUuDQoN
CmVudl9tbWNfc2F2ZSBzYXZlcyB0byBzbG90IEEgaW4gdGhlIEVOVl9JTlZBTElEIGFuZCBFTlZf
UkVEVU5EIGNhc2VzLg0KDQogICAgaWYgKGdkLT5lbnZfdmFsaWQgPT0gRU5WX1ZBTElEKQ0KICAg
ICAgICBjb3B5ID0gMTsNCiAgICBtbWNfZ2V0X2Vudl9hZGRyKG1tYywgY29weSwgJm9mZnNldCk7
DQogICAgcHJpbnRmKCJXcml0aW5nIHRvICVzTU1DKCVkKS4uLiAiLCBjb3B5ID8gInJlZHVuZGFu
dCAiIDogIiIsIGRldik7DQogICAgd3JpdGVfZW52KG1tYywgQ09ORklHX0VOVl9TSVpFLCBvZmZz
ZXQsICh1X2NoYXIgKillbnZfbmV3KTsNCg0KDQpEb2VzIGl0IHBlcmhhcHMgbWFrZSBzZW5zZSB0
byBzZXQgZ2QtPmVudl92YWxpZCA9PSBFTlZfVkFMSUQgaW4NCmVudl9ub3doZXJlX2xvYWQ/IE90
aGVyd2lzZSwgSSBoYXZlIDIgc3VnZ2VzdGlvbnMuIEVpdGhlciB3ZSB1c2UgdGhlIHBhdGNoDQpw
cm92aWRlZCwgb3IgSSB0aGluayBteSBwcmVmZXJyZWQgc29sdXRpb24gd291bGQgYmUgdG8gY2hh
bmdlOg0KDQogICAgaWYgKGdkLT5lbnZfdmFsaWQgPT0gRU5WX1ZBTElEKQ0KICAgICAgICBjb3B5
ID0gMTsNCuKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgg0KaW4NCg0KICAgIGlm
IChnZC0+ZW52X3ZhbGlkICE9IEVOVl9SRURVTkQpDQogICAgICAgIGNvcHkgPSAxOw0KDQpGb3Ig
dGhlIG90aGVyIHN0b3JhZ2UgbG9jYXRpb25zIGVudi9mYXQuYywgZW52L3NmLmMsIGVudi91Ymku
YyBhbmQNCnByb2JhYmx5IG90aGVycywgeW91IHdvdWxkIGhhdmUgdG8gc3RyYWlnaHRlbiB0aGlz
IG91dCBhY2NvcmRpbmdseS4gQnV0IEkNCmNvdWxkIGN1cnJlbnRseSBvbmx5IHRlc3QgaXQgZm9y
IE1NQy4gV2hhdCBkbyB5b3UgdGhpbms/DQoNCkFub3RoZXIgbm90ZTogT25jZSBhIHZhbGlkIHNh
dmUgaGFzIGJlZW4gbWFkZSwgdGhlIHByb2JsZW0gbm8gbG9uZ2VyDQpvY2N1cnMuIEFuZCB0aGUg
cHJvYmxlbSBkb2Vzbid0IG9jY3VyIHdpdGggdGhlIGRlZmF1bHQgZW52X2dldF9sb2NhdGlvbg0K
YmVjYXVzZSBnZC0+ZW52X3ZhbGlkIGlzIHNldCB0byBFTlZfVkFMSUQgaW4gZW52X2luaXQgKGVu
di9lbmMuYykuDQoNCkJlc3QgcmVnYXJkcw0KTWljaGFlbA0K
