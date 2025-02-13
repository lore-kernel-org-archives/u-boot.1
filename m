Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE22CC021A7
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 07:16:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5865180C77;
	Thu, 13 Feb 2025 08:16:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="hlfx4EVu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3E2280C7E; Thu, 13 Feb 2025 08:16:01 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20723.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::723])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EA1A807C0
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 08:15:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrR5G1/RERi8eG4NiwzhrXxAiJvdDGCjBpHHC2RQb6vm40uGzwfCJ+mMoC/5vRD2GQvQ9PYxhuaCytV9mDgfnfCdfLelHQh4Et86fW6Wqu0zMEba0lEJsAdb9jfk3ODQ5asZGNuMHh7EHEzOnnE0hZ0KaTwh9b3pQPL/EK9Eo7+I6it8rCqaUsIuUffctXfkn3eF3NYx9h6VAKiHKxhYFmIKkPAuKTqI2fYPE7L0Djb3n7TgZQDvi5foJatUSM1giH40nagWkCnh2R3E4WmqRtyXiUDK93QbcthOdnRrCb/0bcX7TcQeik4W4CoYayT9W5On3kSkUP5ECeojXw0byQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18+hCq0OpZ0Kpr99B6dXxqb16A2TZvCaSMDT5R0IKYc=;
 b=Q3fZvwoSzEr9eGppIx7PRGE70dLMf9nTdIvvhLDZo3jrTq5V3pv3g6jvQY+gRTDxwwV2RO3A9mH3cPDPFnyNlF2wpj2+hL1lH4KXW+YY7F4Qf34k+w37JQ5hR5jxoA7PzbRAwI72vsxH4/yXopuBXtibxEid16GPfRhr62+UUq7UoDLsS131eOPvXTPoC9CAGpaqX8fQ+J5Rs+84Jnm7NvjKHtryI68IAoUzgEAIYkOERiYIUbYF4szi5+nXQmmH2PiYWv1yCbrVlD18CsTNEtSBxrb95UJzUXE14YAzqd7Cft9X1RtzL8y6cMESRCt3PHFB7A84+9owXA4BVyBvkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18+hCq0OpZ0Kpr99B6dXxqb16A2TZvCaSMDT5R0IKYc=;
 b=hlfx4EVuLOXhsZ3id+PiYkpgtrUa/CgA2YKP8CiCZOAJc82LR124M8z8DQvv2XUEzeqsKfte9ry/lh4Z8KYXITfU0FGMYnVDCBnFSeavfPvijHm2EKmmv8+1jQeWB6g1siEI1kZMOWR/CA54GgH8qINshcZn0M1vB6YTewPhKsrteox1XTSi79Gh23uA7yZ0Bchy2CUgukuKcYRpTgRc8gntY86Ml+wKlt63RF9hd6LYVRgspWfBbkBtw/h6NgdPw5psQbaiV78i89zJ4HGM9rV7UaPC3MFMF+L1SNYbzqdbCX2sdp3OcHV70KRUBQihJ/u+5gPfpwFOfXYHICyVSw==
Received: from AM0P195MB0386.EURP195.PROD.OUTLOOK.COM (2603:10a6:208:b4::32)
 by PR3P195MB0667.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:27::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 07:15:58 +0000
Received: from AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
 ([fe80::3f8f:9315:c279:d35f]) by AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
 ([fe80::3f8f:9315:c279:d35f%5]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 07:15:58 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: "sjg@chromium.org" <sjg@chromium.org>
CC: "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>, Benjamin Hahn
 <B.Hahn@phytec.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Yashwanth Varakala
 <Y.Varakala@phytec.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Teresa Remmet
 <T.Remmet@phytec.de>
Subject: Re: [PATCH RFC 3/6] tools: binman: ftest: fix tests that require
 non-faked ext blobs
Thread-Topic: [PATCH RFC 3/6] tools: binman: ftest: fix tests that require
 non-faked ext blobs
Thread-Index: AQHbcjjJ5bogsvfs2UShc1o4H6zEfLNAlaeAgARUJ4A=
Date: Thu, 13 Feb 2025 07:15:58 +0000
Message-ID: <d8104b8f26995b5c1156cb524820d7f914464f19.camel@phytec.de>
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
 <20250129-binman_faked_optional-v1-3-a4534bc67cbb@phytec.de>
 <CAFLszTjg9YYzwWjYccH0V9-45xzO0n_soDscfr+ie1maLMSOTg@mail.gmail.com>
In-Reply-To: <CAFLszTjg9YYzwWjYccH0V9-45xzO0n_soDscfr+ie1maLMSOTg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0P195MB0386:EE_|PR3P195MB0667:EE_
x-ms-office365-filtering-correlation-id: 2d2b074e-88fd-4f64-edaa-08dd4bfe4376
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Tml6clp2dFNURXViQVJzV1lnU3l6MDJ2bG04SnRpSkI2TEh6VTFjMk5CdGwx?=
 =?utf-8?B?dE1LWGRiTGxGTERKOTkvWFB2NnJvOU5Ydk56Z1pidGNlanRoOFRSNzNYcXRF?=
 =?utf-8?B?QzhMZGZnWTN5NzVqVDg2Z3VubThvUk0wUjlnck5OendxY2tIV3lpQjNieUk4?=
 =?utf-8?B?UURXeS8yVTZwc1RIMEt4d3NIWkVEVXJKK09jUlRSa0JhRDdTb05FMnBoN3dq?=
 =?utf-8?B?SnY0NFFOd0haZVRQL0NYcnJiRVdjYVVLbklseXdZQno1WlB5ZWwrQWxqZHho?=
 =?utf-8?B?Y0FSRm50Sm95T054bE00aHhQVFh1bkQ1UWFRRW52YXZiak9IWE91VVd0YUUv?=
 =?utf-8?B?cWxrUGdPTUZUS0hPOVdpWWFkdXIvczFlanlMNS9TVUQrRWFJR2h6UnlhWUpt?=
 =?utf-8?B?Y1N2VlB5bC9GOFBqNHlEc3I2d2hleXRRTzZiUDBCOW1LWWVNb1lRWW1lVG1Q?=
 =?utf-8?B?eVlVaFc5RXB3UWFsdkZzR0dIc2tXZkZ1Vjdqb25Kalk4UTN2WDJZNmVSZ1Zu?=
 =?utf-8?B?RG9Td1FRTzgwclJiVC9XY1djM0FBRmZoNUwwVzBoankvKzhPYVBDNlpuZzY2?=
 =?utf-8?B?UjdOcFZWNUEwS0RNcmw4N3dBaTRkaFNKZjUyQmhhdlNPTVlLRDhaOWliL2NU?=
 =?utf-8?B?OHAxZ09oZWp6dU9QTjBtWUg4cS95Q0JkSE40cE90UEJKY1pObWNvNWxQQU5D?=
 =?utf-8?B?WHBRdGRJdWErMnRZOXdVelorbmdNTjJOM2hCWkw3c3ZnU1VZaXpCTG1ZM3lY?=
 =?utf-8?B?dWVEdmVGeDFlaGlyN201dlQ4TkF4Ni9EUEEvZUxXQVByRVRJSENaam0yNjJS?=
 =?utf-8?B?aEw2UGVFaG15MDljS1NFQURMUDczMzYySVQzNUFmcGY0VEhiRFBwdkJBcnNN?=
 =?utf-8?B?Ym1oTEtIbjJWNE9zMDBrSklOWE1mL2N5bVFKdWVVWngrNHlhL0REdnBDV0tX?=
 =?utf-8?B?a3lhdUNZUGUrNXgvK0xIOGVYemx2QkhRWThxcjJyeGdaUGszOWttaE5mMFZP?=
 =?utf-8?B?UnRKd2tLemRGSTdLM1pTakczOFNWenUvU05BK1RJRmIzY3BYby9DRkVTREh0?=
 =?utf-8?B?U3RsanR3UUx3eGZ2OVFJTlQ4RWRESG1qUlpIOGp6MTFEd2lZRnBEMnA5bGRQ?=
 =?utf-8?B?UUkrMW01N3p5SGtEWXdaMGRhZUFyZHpucjRzNG9uMVpDYjRvdW5yYkpGUjFW?=
 =?utf-8?B?Q1RISEw1OHZOR3BHWURFOHozSDFkWktFZlV5U3ZiSXNxQllvMktyV01leVl6?=
 =?utf-8?B?WE5LVVVxMkRDeHJHeW9SQ0lGWGwxWFRVekdZUzN4a1N0RGFQK3I1TUM1dE9j?=
 =?utf-8?B?STRjY0dPSFpsQUJvT3B6NHB3eW0yZm1laDdIN0QxNWpYWUcrcTRCOFNOV2ZR?=
 =?utf-8?B?cnd0alpwNktnaG9rbHIvVWFxR0VRUTU2MkllUzlWSFpjdVpmc3lubmVSc2w0?=
 =?utf-8?B?Y01PczV6Ynl1M0hsRGhOeExnR3cvL0JORkdpR2pmMzVWNUxMRUx4ZkEzTTdZ?=
 =?utf-8?B?cWo3NnVnYlFhMXp1QW90OUhJbzlNYmRab05FZ3RjNXlmSEhISTFpWDl5bUVM?=
 =?utf-8?B?R25Od1NxeWVoOExUMUVURFRIMm5YRE54VjR3Qk1mdE5jS1lGbmtIZ0pqak1N?=
 =?utf-8?B?Tkk0bVY5bXBkSGdkbnlERGpKcDBITGRrcVRJRGdpaWQwQXphTkN5QmVsbTlD?=
 =?utf-8?B?K0pqR0NYYXFUMjJOQXZPdmhNOUdGcVJZSkw4a2NxYmNKYTVNdnZPZU1oNFdK?=
 =?utf-8?B?Z2pRa201Zmdkci9KOEhBMDA0M1RCeW1Wd2cwK0hVemVtOHFUbGVOMjBvcDJW?=
 =?utf-8?B?VzhSNGsvRUw2c0Z4OHp5bWxqMEFIak1MQlZQSFlVL0htd1BnN0VTcGJmMXp6?=
 =?utf-8?B?RHE2VDNzbTRqRjhUNjdJSjFkdklFVnlwNWx3Mkl2U1NGbnUwa0FxcVBWSC9q?=
 =?utf-8?Q?LYYodbk1biW4WeiJ+vwx2opy1wOBhLUT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0P195MB0386.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnpXY0ljV0huZmFlMVkxbno3enpZRW5EOVdLRDFYUzJ6SFlPVUh6c1YvcEZs?=
 =?utf-8?B?WGNaakJCRDhTZ3ZkTFhnVU1rcUZKMWlHc1N6NTNpeEdwN0d1eStvUW5Mc3ZP?=
 =?utf-8?B?bUdhMndqWjgxclhUeWkwQW9OU0xmQll1ck1QdEJBWkdscWFwSlZzNVRiSW1v?=
 =?utf-8?B?dHJRYk1wbnpsV1p4bU93QzFrNmdpRWhvcUhEMldUOXpBUlgzdDZ3QkY4enJ6?=
 =?utf-8?B?UUNVeXBLZDFON0Z1V2xCV0RmV2hWNGpQV1RGNm10MC9DRzZUMEpTbzk3U0My?=
 =?utf-8?B?Q1c2cnh4T1B5SEN2THBEU3kyeVpwNzlYQWVRc3NHMnl5OEJsZlBvdmxvT0Zj?=
 =?utf-8?B?Y0pXc0k0cnFHbFhONHAxMHpxcVNKOFlHTGNSa1ZDaUFiZmZSbHgrNWUyNjBv?=
 =?utf-8?B?Rjd4WVk2U2hKd0htZG9TU3ZpOFB1UzU3d0tyWHFieUlCbDJ0c0FYL2NOTFgy?=
 =?utf-8?B?VkdONXg1VE1BL3hBQlNHTWNqMmt3QjBPWGM2cjVITkxjS1FpdmZTcnBLejZV?=
 =?utf-8?B?SnpPN05JWmJsMDRXY1hoTFJINjZiOW5QdlowVDZ2NkxGVVBvNTBvdXJmeHJ3?=
 =?utf-8?B?TUxnampSSEdUN0xQbkE4aUx4WUFjaHhFd3RFbFVCMXVGeHlvejIwamJ6MzA0?=
 =?utf-8?B?S0Y4ZXlTZStvMDlnN0MyMG5HSGEwclVYSC96eWE5QXRTcTNEMG93d1lPOCtI?=
 =?utf-8?B?UWVHSjBINmc3QThLSFF6V1YyZzM3ejRmTVlUYXVhMWNkS0xBRHBFcEJsNFNL?=
 =?utf-8?B?ak13RHpWOG5BV0lGUlFVeHRpOVI5ME5YTmxPamxSK0RDWE5ORVVOSmJWaWJ6?=
 =?utf-8?B?RnVUTDlYSHRzRVpHdkFkZlVRU3JhR2cxRlBINUtxZmFXV0pGM1h4VWd0dE1K?=
 =?utf-8?B?TFFiVXE0UVQ3b2xwenlzMXI0QzRGb3p6cTk1QjU1aFdUR0wwMXZNSnZ3bXJ0?=
 =?utf-8?B?bGN4VlgyZnZkbkhGbnpCMC9IUEEwWFJTM2pVMWgrb0g5cFJndEtoUWg1d1R2?=
 =?utf-8?B?WU9vaVBZK1VsUExDNW5xRFJSamc2eDNYeTJ2aVNFV09KMkZNMHQ1aEU0UTVO?=
 =?utf-8?B?N0VHbHZ4YlRlSDBJL09EM0lYYkg0emswSklScWxrSEVweWFxb2dnKzc5MEJG?=
 =?utf-8?B?UEc4ZUFjUGg3SVpxUXBDVVp2QkJzbXVtVjg3NnRrL1ZzRGZqMGpjcGtGQm9R?=
 =?utf-8?B?NVc4cUVKcmw1OTBESFdTZlcyTzk5RmoyUVVkS3F6MkUyY2FtSXcxRkZnQ1JB?=
 =?utf-8?B?SFlGSXRLK3U0SmYyQktFZlE5VEF4U3doamI0WTlzMXZITVdacFJWYkN0YmN3?=
 =?utf-8?B?LzBzY2JhOEhWMUFpVjRteWNmMjlpODBUQ0sxVDJRbTFuVWFERjdWbGlydFA3?=
 =?utf-8?B?OFFHakxTVlZPMkRtUEh5cGpoZ2N1OFZyNHNzdGZseVNlNlphMFp2WWpRb21l?=
 =?utf-8?B?TW9BdlB4WDdjY2tlZXB2SVp6QituSEp6TFNQclFZUktZVGdUeVgxU3pzWDM0?=
 =?utf-8?B?Q1Y1SG5oT0VYcFMxczBUdlkxRndQUERybjdHQ0xGd3JRY2VFMjdJY1NMbXdX?=
 =?utf-8?B?SHYvSEtOSyswMUk0UTJ3OFRmRUZZb0NybzNyT0hzRWFRSmwzK0pkMG5PU3BM?=
 =?utf-8?B?RW5vNFR3elBvODhBZlcrRmptYlRnYlF2MGhQcXdNTzFVcGExazUxZGdMcjR0?=
 =?utf-8?B?OWlpOWo2NVN0cVo3RFZKY1o5UWRRbWlHVVYyRXo5Rms0U0lJSHZpTkRqTFgx?=
 =?utf-8?B?UlFtbzdOZmVoeDhqbUJ1RUJueG8rNGxPMW83azBRT3JJU1pOMlVOOXpFZjlC?=
 =?utf-8?B?ejFMeCtrcHBtd1JlTGhlbDRja3MvTExqSzZMQXlZLzk5eU5na2FqUURJMTIy?=
 =?utf-8?B?VURoMmN0bHZhK1BiSTJKT2Ureno3MjVGeTE3dVMzcldDQU81eWhWNVdING9B?=
 =?utf-8?B?TUFSaVl0cnNRQVJMTmFXNUpKSDJXQjg0R0VVZ3hXUkp0MEZ0Q0RySGQxRml5?=
 =?utf-8?B?NkVnb2RpSy9PZDNWSUNIYzl3ck9YaElGN2FGT1IvODlyeURLZkw2QVJEaWpq?=
 =?utf-8?B?anp2dHIwMWxBSldVM0VSS0lJVldDWnJIamZPREZIT1lHMVRGSmVoY2dVeWcy?=
 =?utf-8?Q?SCk8I1xwO91bzD4aNN4+jbPlC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41EF46E0E0908C42B1EC690C0C2D85B1@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2b074e-88fd-4f64-edaa-08dd4bfe4376
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 07:15:58.1927 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HjZSSN9q40xZu6BU0xpPlV++WbhxqVTKdaz3ipyRnj9KFSDN80mhZfFouflab1KMkEJkMCxBDmHzBVE/ClicbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0667
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

T24gTW9uLCAyMDI1LTAyLTEwIGF0IDA2OjA5IC0wNzAwLCBTaW1vbiBHbGFzcyB3cm90ZToNCj4g
SGksDQo+IA0KPiBPbiBXZWQsIDI5IEphbiAyMDI1IGF0IDAzOjMwLCBZYW5uaWMgTW9vZyA8eS5t
b29nQHBoeXRlYy5kZT4gd3JvdGU6DQo+ID4gDQo+ID4gQnkgZGVmYXVsdCwgZXh0ZXJuYWwgYmxv
YnMgYXJlIGZha2VkLiBTb21lIHRlc3RzIGNhcmUgb25seSBhYm91dCBtb3JlDQo+ID4gYmFzaWMg
ZnVuY3Rpb25hbGl0eS4gSW4gdGhvc2UgY2FzZXMgbm8gZXh0ZXJuYWwgYmxvYnMgc2hvdWxkIGJl
IGZha2VkLg0KPiA+IFRoYXQgd291bGQgdHJpZ2dlciBhIGRpZmZlcmVudCAoYmlubWFuKSBjYXNl
IHdoaWNoIGlzIG5vdCBpbiBzY29wZSBmb3INCj4gPiB0aG9zZSBwYXJ0aWN1bGFyIHRlc3RzLg0K
PiA+IFRodXMsIGRpc2FibGUgZmFrZWQgYmxvYnMgZm9yIHRob3NlIHRlc3QgY2FzZXMuDQo+IA0K
PiBBcyBiZWZvcmUsIHBsZWFzZSBrZWVwIHRoZSBub24tZmFrZSBjYXNlIGFzIHRoZSBwcmltYXJ5
IG9uZS4NCj4gDQo+IFNvbWV0aGluZyBlbHNlIHRvIGtlZXAgaW4gbWluZCBpcyB0aGF0IHRoZSB0
ZXN0cyBzaG91bGQgcGFzcyB3aXRoIGVhY2ggY29tbWl0Lg0KDQpPa2F5LCBnb3QgaXQuIEkgd2ls
bCBhZGp1c3QgdGhhdCBmb3IgdGhlIG5leHQgdmVyc2lvbi4NCg0KPiANCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBZYW5uaWMgTW9vZyA8eS5tb29nQHBoeXRlYy5kZT4NCj4gPiAtLS0NCj4gPiDC
oHRvb2xzL2Jpbm1hbi9mdGVzdC5weSB8IDE4ICsrKysrKysrKysrLS0tLS0tLQ0KPiA+IMKgMSBm
aWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBSZWdh
cmRzLA0KPiBTaW1vbg0KDQo=
