Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30898C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 10:08:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90AC480780;
	Mon,  3 Feb 2025 11:08:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="YLj/8owh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8454807A8; Mon,  3 Feb 2025 11:08:30 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::70c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2A36805DA
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 11:08:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytYoul+KQNQnypIirVr7GXLD/FN0/x7ULFqavkEFHoe0EfACHbTe5PP8Gsx3w5PN6+TOJpp+p3e3VUiU3kNjH2iqK0psX+dGTKn5tS6HoT9vj0NZEROMpyhkuteyaf6I71ZkuwksmgR+VquSEGMwosqeedqQ46uYVvczWRdzvFEsv/RKFBjQmq4/4fN1+kcSyaLP/q0zaF9Wp71uoTyyRr+L7dFKfl9m/qCSOWk0Vkyf2+o1OpEeE12pFI2yivWr87i1wDWNaWg47Sk2LycfsSJqEeM2eb9J52+yTfxT3OeiBbI5j6Kzts84uFYLyS3vWehElvtkGtBzkyxneU7lww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2yReu7uPaVPRgxyWydISMe5PABvVtNDITsuylsrWt4=;
 b=S1mKVctsVhPvZBKwxqyZhDJ+QfKksNcjcQTBoKAMwxdi6s7cOGOE0XhCgdj4nDOr42Rvo2JJHgSGbts59jZFlRGGEI1TY3y2lthT1yIXcmMipKbaqk3aHlMXbmiV+5GN9TceMdmAsUAQw8M0FoBR5W0V+tNjeG2hyDvkEbYbmudoUpXI8ngJJeuqQeMScbev5ZSqVK+hptNaQTP4xZwlH3PFQ7SD76tB+DA09kST08iW92X6Lb5YuPhANM/KxeLeghHexUQok30ISIzsihCia4KFM+R1d0nUHdr3Ce1Y9X06N0NpAYDtZ0zLqfZDCXynFxOvnNQh0KVNSFrZXqHd/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2yReu7uPaVPRgxyWydISMe5PABvVtNDITsuylsrWt4=;
 b=YLj/8owhY8DlvGNw05jF3eKQAdyImbIwFdX+AKkBiZ41yqNHuZcS8uy6P5sXz1cwnP+Mc5c0COseDVNW4++75rB0jo7+qcbGC4HDo463Ei36DMfv8IPFQKIZLs2KZM+9hzTSj0zeuaH0t1fsK2Qh81/TicjIZauxZ1dYVWxxNKVegVMmQbFZ2ViVKgzZRJt5TIJlivXU3FO8Mp6Ghz260B9+ZLjip7u8AGUZPcux6U4Ez7bQlr/0z1KKdzFl6RhpmBqAUJy+Mblthio8VmlcoJNqJjbAiVl4xDrGAnzlYVD6TuLV/ad5DWUhqpI8jdSv4Zhh/CHtEjEU2yUDHREejA==
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:248::6)
 by PR3P195MB1056.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 10:08:27 +0000
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981]) by VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981%6]) with mapi id 15.20.8398.017; Mon, 3 Feb 2025
 10:08:27 +0000
From: Daniel Schultz <D.Schultz@phytec.de>
To: Wadim Egorov <W.Egorov@phytec.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "upstream@lists.phytec.de" <upstream@lists.phytec.de>
CC: "trini@konsulko.com" <trini@konsulko.com>, "n-francis@ti.com"
 <n-francis@ti.com>, "nmorrisson@phytec.com" <nmorrisson@phytec.com>,
 "d-gole@ti.com" <d-gole@ti.com>, "sjg@chromium.org" <sjg@chromium.org>
Subject: Re: [PATCH 1/3] arch: arm: dts: phyboard-electra-uboot.dtsi: Add
 bootph props to i2c
Thread-Topic: [PATCH 1/3] arch: arm: dts: phyboard-electra-uboot.dtsi: Add
 bootph props to i2c
Thread-Index: AQHbcHI9ab76X6/DQU27c5slQxAzg7M1ZjwA
Date: Mon, 3 Feb 2025 10:08:26 +0000
Message-ID: <9ea530f8-466f-4586-ac73-86c95489aea9@phytec.de>
References: <20250127041612.985929-1-w.egorov@phytec.de>
In-Reply-To: <20250127041612.985929-1-w.egorov@phytec.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0P195MB2484:EE_|PR3P195MB1056:EE_
x-ms-office365-filtering-correlation-id: 1ad99276-30fd-4085-02f7-08dd443ab3ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?NTZoUEZDdUU2ZzdnbnpoUEtiVG5mSlErZHRGcGV2VWs3Z2RtZkVtaUVjSC9U?=
 =?utf-8?B?RTF5aERNYWpCL2pKTlZtMHUvNTQxWVBrM1d6eUZ3aUpia3N6VDdrNzRwNENT?=
 =?utf-8?B?eWpyUmZKZzF5Vi81Umk0TWJUdFVRM0JKTThJWjZOMWVjbXJmUGlsazc0QW1s?=
 =?utf-8?B?azVRTTY4NmFrOWR3c2dPWTNlQUM3elpTMGpyaGVWRzY1c0Znalh4UnpKa0Zx?=
 =?utf-8?B?SXpyQmIwOEhJbGxpV2xTSnNuQkV1bGJMT3NyU25wNnB4dHM5SDRrUy8vVERG?=
 =?utf-8?B?UEdEeWpWVWR0d2dOSVhkU01FSHVHMFY0aTR6SnkxUk15WStlc3NmWnVLNjVV?=
 =?utf-8?B?cnQvRGl6cThCWHlVOFM4cmp1RDZUelFVSzZjU3QwbGN0MXB5d1JCUUk4bzNI?=
 =?utf-8?B?ZmFaSUczUGdiekI5RmJZK1Q4dTBZdjZ5NHNsZ1g5Njgvd0VSa2dZRk83d0Fn?=
 =?utf-8?B?M0txRmE3Q0tmWlJaenhMYlpYUXRRUmFmVTB0SW5NRHdkRUs2QUIwVFJyc1Q5?=
 =?utf-8?B?M1NlS3A4VDhSS21jOXA5Rkx2dEl0M2E2NUxPRTVmTjFjWmdod3lFdkRKSjN3?=
 =?utf-8?B?WXZkaWl1bHZwWGJ4cWpWTXRqM2UrOGhkdnlQc3JqVC9VU3RMRjNEWUlmcjlG?=
 =?utf-8?B?Nkk1eGYwL0ZYelJCUE9vTFBRUjBtY0grUERMWE1QNmJZc1l5QjZ3M0FkUjNC?=
 =?utf-8?B?ZlFXM0JZVVJ5N2FBak9FMVlPeXU4YkVSWlZ5cmJncUVRdHZsZ0llVys5M20y?=
 =?utf-8?B?alcyWXcwYVpGY2xvYjNzcTNpM3l4UWEvNVBmWUl4QTcvZTVsM3k0anUybVpq?=
 =?utf-8?B?NVhnQVNxSUNZTG1lZFc4MHAzR2Naekdia3pBeFljRDYyc2hYaTdnMHFhNGl0?=
 =?utf-8?B?Z0Nhdms5QUhGNHN5WWg2eG1JZGFzbHQ0dVprSkQvOWFPcUhLNWIxL01zRVFi?=
 =?utf-8?B?NytlYWg4UTJFTkdkQlZxRTIxNFBnc1NNUlVETFgvazZiRzViZHdhQTFnSldX?=
 =?utf-8?B?RE1KOFlyNU9GYk9tZE1aZnpCU2E1YWxCekRuNy9ZWTFOYjR1dU1XKzh0bFZu?=
 =?utf-8?B?Q0h5bE5RZDZlcTRrMFpLSzFzUFlWZEljYjlhUXI4VkYwVnJ0cHZYM3dGMDc1?=
 =?utf-8?B?ajFZSlk0b296VkpRblU1bldjVVZOVDl3dGYwZnJtb3pzWGZkcURTUjZSOFFD?=
 =?utf-8?B?ZjJWOXVCV09kNFVKdHVYTW9JNmowbUs2ZXdQaWt6bE1ZcDhIbmVGY1dGNHlq?=
 =?utf-8?B?VDZkb2lVVzRsdWNxS1hjaVd3S1BRb2prOHVETEpGNzExdUNHWVJVbnljaEdZ?=
 =?utf-8?B?WHFYeDc0YkJvVzVrU2x6b2JONyt2S2ZXSGhsZ2Uwa2c4NVhaQWlvK2N1NGU4?=
 =?utf-8?B?VWw3NjFSR3VzQnZvL3RUd0NaVjJqc2xlUDdmYTd6Y2Rwc2M5Uk1zUEpuQWdF?=
 =?utf-8?B?MjQ1UmJURUVkVk9scEJrM1RXY3BGNkQzaVhqTjdpdUt1NTcvcDJrWU1aM0Ft?=
 =?utf-8?B?cXNsUDhIQjNtUU1CcGZ3MzVxM2pMSjY5aXE1Vk1yRWhRUUEwVEdRMGZ1NVlr?=
 =?utf-8?B?OEdUVkpFSk9ZQ3BvZVd4cW44NUhreVJqMGpyU1h0YnFZd3JPYlJkVXVrYzZ4?=
 =?utf-8?B?ZTlGTG0rSHpUZTluMHpVVEcwUHhyaHl5SUp0cW1xT2FSTE5hUXM2QUhXT2tx?=
 =?utf-8?B?d3pLOGdDVG9YZnJJYXhKSHhrczYxUG5sajVOSW5NRUtRZGlVMzhhbVFGSzZp?=
 =?utf-8?B?QjQ4cjMxVldKa08rMzRKS3lKN2g1a0lXSnZKK2lSQzZ4ZWZQL0dZMHhOeHU5?=
 =?utf-8?B?Y255OXllNGxBZEY2WXdHNTJaYTE1T2VZdUNNeWhwd1BNYndLWkFJNmp6R2NW?=
 =?utf-8?B?cFJoRGZERVh5ZWhETjNzMTBFODJPQloyc245OUdVS1hMcjQrT3JvZExtb1E1?=
 =?utf-8?Q?aDxrzXF/Aky/GqEhPIsG6MNGU0adWa0a?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0P195MB2484.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGx1Q1F6RFJFcW5oazRaMWxUcWozY1BMK1doZW9yMW13VkJNS3BFMDlwSVBZ?=
 =?utf-8?B?aE9vNEZyM3U5cThvUzEwVysrbGFuU1NyUndpYVViVW8xekJLc2ZuZFI4a21s?=
 =?utf-8?B?L1locVJBcUFLbURJNkh5VDdncERhRUNRMnRVcmY2VS9rQzJvT0JXRWsrUjV2?=
 =?utf-8?B?VVNIeDdMREJBaFdHQjk0WnNUaTZUUmZoem1HRHFMdWx1cVh4MFBvcFJ0cGtJ?=
 =?utf-8?B?d1Bha2UzNmtZanBRNS9iSGZjZTROQ3BNZmdZc3FXRUNENkJsZVZwMW9CTkg2?=
 =?utf-8?B?T3ZyZzg4a29TVStCUyttZHVUNERNWUI5NlQ1N0VIOWFmRWhXMjdMM2hXamdq?=
 =?utf-8?B?UG5TRklFNEhqZDNQVFdKWlNSTlI3RXc3eHV1VUJoNmdOOVpMTGZhZjhXckZm?=
 =?utf-8?B?bFl5cUFOaXJPaGJPT2ZCRnowUXRtZ1RpMDc2cHBxYjMxdHo5L29vV2xXY0xH?=
 =?utf-8?B?aXJNUlZUWkRndzVjVkxQVDlxVjBCWDkzSGtSK2U3RlJra2J2NUpid2RwWTNM?=
 =?utf-8?B?YzkxRXJWRGxXY2RRemtyR0V1VkZma1B3bFVhOUdPbForUjhxMDhmT09YSWRy?=
 =?utf-8?B?R2lDdXV4UlRoMlFoVVUvQnh0WEFydExkZFRRTjFzODRLNnQ1MjFYb2xmZ2Vv?=
 =?utf-8?B?OUNFVWNBbjBlMVBRc05ZNE52SUlrM2tkOEd1M1lQR2tMVGxTUytralNqYUxM?=
 =?utf-8?B?U3ZtdE1KTmpabjd2YkJKcytKVERaQ29RL0pYcjdHc3IvcjJ1OHRqUDcxSjEy?=
 =?utf-8?B?NlRpNkRza3IyaWV1aTVzQ0ltenVkNkplQnR4ZU5IT1lWMFgzckFZTDU5dHZK?=
 =?utf-8?B?aitqTjJ0cFpzeUZsSGxEdTdQaFVoTm9JdmxaK2pSWlp4NTRmM2JTVnljak1a?=
 =?utf-8?B?L1dwb0Zra2ZzTFV2RzNnRnczNGFRSUxnZm1GRXVJa0RBMlp0RUVKQWhrdTNo?=
 =?utf-8?B?WGsvZUNkd1FLS1d4bk92OS9FOUI0RDh5Tk9mbnl3T0M5VWFWUkhwZDBSRVJY?=
 =?utf-8?B?OUdvS2h1cVNQV2UwSzVVaGtVQzlkb21lcXdnQ2I4STJyL2ZaYkVwd1YwdU1x?=
 =?utf-8?B?Y2VIWkVpa1hJWmNnUllCT3Y1N3BMcjJyRVA1MjRCSUcyVUZKc2hPUW5KaHdD?=
 =?utf-8?B?Z2ZQQ3lFdVVQZ3kraUlUMEJMSzdpYVB4aFZuWWtKcldJYXNiVEZXbTZaWThM?=
 =?utf-8?B?UENUcVZPVzA0dDZEOVZsVDkzc3JKRHllUTBiNkpvSGwrQ1FWcnY1Nm52RlRC?=
 =?utf-8?B?cmRXcjNxbzR6ZWN2MUFraHU1dS85eXpvVW1XTkRUb2tmZWFvdk81SHI3MVNN?=
 =?utf-8?B?b0pkek9iNnFlU1FlT1Q4UGU5Yk5NbW1DdVYzNXU0azVTMFFWY3ZodS9aNnBh?=
 =?utf-8?B?bXN2cFhqQlFFQVdkSzR3REhTaVRwWFZwYmlGNDJVcTlNOVBTTGJmeDlKdm9r?=
 =?utf-8?B?eTJ5WXZvcXJmUE9UVlR2NDk0eGJkbGo4blM4R2RKc3dpWXBua05JdUZiZ05l?=
 =?utf-8?B?bmIrRDc1cFVnNXE3azJYTGpQVUhDUkFucHpHNm5aMC9VblhIblFBeHJVOWN6?=
 =?utf-8?B?R3ppVXQ3aVpqbzlFQUNnN3NSZkY1QlpUa1ZGT0p5eE5UZnZCMHdXYVhEaGcz?=
 =?utf-8?B?RjFrektBb0t5WWJFNmNxczA1TVJvWFJrNXRYRkxrWERlNGpMWWFsRWxtTXdJ?=
 =?utf-8?B?WHkrZHVwcC9FL2VQU2ZLK2ZycDBpcVNGT2tGclZEMDAySG5wbEFmdm04aXpD?=
 =?utf-8?B?c2c1VlVKZU5mUGZuMHFWOFpReWttWUVPbjJ0NlRkL3FEWDlDaWR4SnltY2Yv?=
 =?utf-8?B?UnMvekVZUzIvSjh6bWRaR0toWFlWaWM3dVFlTzlGZzhoOUdqRVpteDNsZFdY?=
 =?utf-8?B?WjdJd01VYkQrWmVYZXhiYW1EOHhkaXFpWFh0eXlaemxIQUl2dGV2K3RmMjdR?=
 =?utf-8?B?MWZzOHNKRGpuSTQ1MUlzZk1pL0M5YUVIL2ZiVVRNUldKMEJzVDkxbklTVEVt?=
 =?utf-8?B?UHlSSFBHd3lVMncyUUN2SUtFb0RXeFZDcW1yS2NnWWt1dVBRWXFOelhXL28y?=
 =?utf-8?B?elRMaldKZTZnM2tWWkRjUEtDb3dmSkN6NVpxRFgyRjFZRlZVY2cvaWFUNzEy?=
 =?utf-8?B?WExaT2xHZ2pqanVZdXk2VHlWZ3R3KzRtOHlOVlJtdzU5T2RLUmJ5dGwvZUUz?=
 =?utf-8?Q?NjK2QYM9PHrOJQ/um5giOtw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DA6C99B79BE3E42BE168CE9FB5E7639@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad99276-30fd-4085-02f7-08dd443ab3ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 10:08:26.9153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DyadeZPul/BwqTU8e5u6UH7RBJAjSTuTijkGaNtHdG8SbkWBaDMT3/NO8C7RIE5xn0wugAPUT2lNz7ixxKdEFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB1056
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

DQpPbiAyNy4wMS4yNSAwNToxNiwgV2FkaW0gRWdvcm92IHdyb3RlOg0KPiBBZGQgYm9vdHBoLWFs
bCBwcm9wZXJ0aWVzIHRvIEkyQzAgbm9kZXMgdG8gZW5zdXJlIHRoZSBidXMgYW5kIEVFUFJPTQ0K
PiBhcmUgYWNjZXNzaWJsZSBhY3Jvc3MgYWxsIHN0YWdlcy4gVGhpcyBlbmFibGVzIHJlYWRpbmcg
dGhlIFNvTQ0KPiBjb25maWd1cmF0aW9uIGF0IGFueSBwb2ludCBkdXJpbmcgdGhlIGJvb3QgcHJv
Y2Vzcy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogV2FkaW0gRWdvcm92IDx3LmVnb3JvdkBwaHl0ZWMu
ZGU+DQpUZXN0ZWQtYnk6IERhbmllbCBTY2h1bHR6IDxkLnNjaHVsdHpAcGh5dGVjLmRlPg0KPiAt
LS0NCj4gICBhcmNoL2FybS9kdHMvazMtYW02NDItcGh5Ym9hcmQtZWxlY3RyYS1yZGstdS1ib290
LmR0c2kgfCA4ICsrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0K
Pg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vZHRzL2szLWFtNjQyLXBoeWJvYXJkLWVsZWN0cmEt
cmRrLXUtYm9vdC5kdHNpIGIvYXJjaC9hcm0vZHRzL2szLWFtNjQyLXBoeWJvYXJkLWVsZWN0cmEt
cmRrLXUtYm9vdC5kdHNpDQo+IGluZGV4IDhmM2MzYTE4NWFlLi5jNjhhNDg2NzhhMiAxMDA2NDQN
Cj4gLS0tIGEvYXJjaC9hcm0vZHRzL2szLWFtNjQyLXBoeWJvYXJkLWVsZWN0cmEtcmRrLXUtYm9v
dC5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2R0cy9rMy1hbTY0Mi1waHlib2FyZC1lbGVjdHJhLXJk
ay11LWJvb3QuZHRzaQ0KPiBAQCAtNzIsNiArNzIsMTQgQEANCj4gICAJYm9vdHBoLWFsbDsNCj4g
ICB9Ow0KPiAgIA0KPiArJm1haW5faTJjMCB7DQo+ICsJYm9vdHBoLWFsbDsNCj4gK307DQo+ICsN
Cj4gKyZtYWluX2kyYzBfcGluc19kZWZhdWx0IHsNCj4gKwlib290cGgtYWxsOw0KPiArfTsNCj4g
Kw0KPiAgICZtYWluX21tYzFfcGluc19kZWZhdWx0IHsNCj4gICAJYm9vdHBoLWFsbDsNCj4gICB9
Ow0K
