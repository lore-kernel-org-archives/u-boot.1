Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A286BD2E9D1
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 10:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13A1689364;
	Mon, 11 Nov 2024 11:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="EHDw1/d0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71BEE89342; Mon, 11 Nov 2024 11:05:04 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79A7E89366
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 11:05:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fa/q64bPNEf+EvORuYFjOB7emLgZMsa7btqAh+mXmO6HU8hPtkMkufRh4+RxGFAK54FTSd0o60Sfp14pZtUudRZ17TdBtPFpPBTS/lIg/aAr/gfIK0ui7eHHQu1VXguqjTtLjSb47Pz/speATAW3wznE5VgBLY+1p/zaXRKRIvNQjatc9TWAI/dfsaJPneX/deZtD1bWaon9TWoSR4wSowYI3qOzEZGc9At41H7ye/7huM5ClaI+aIe6rn9r/eVO6b0KjM2YUMK7MLN3Hfb88N79E3Uqet6LD1HL8BDSf7w2+KUfYnILP3TWOMSox5Dr9QGaZvfA0DU07aoF5q29Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCL49AfSuy8e1ZffM1dEIf1lTbjV0nkB8Vdv5HvrNI0=;
 b=O/JEl5/PxQoc/F6nHxmpHCOTEjENoBgRLzE36yi3BG+r5GFOYeVJ42dZoT3LmIeoK1LKFsCycy117y9OxKl0pCJ0bP4vBWCmPacqMBVuJ3+KlcYMmdt5TPcq6MV0UOdcaYupf4ex6TSAvQSZGvKzBUrI8XCA8PVbdFAmUPpmO8LT/hyUACi5m5jDOV+9b1ywUPWYM4657O/BjUzuT90AXLE+0SUKl7Kgw+93Hv87nQn2BnWPSWkWxyv3tsqBbOuR4o0mha1erGdZQ0+DOq1+J/qqpeQg0dff9zLR3XmUxrMHuNjlgTDTXvqHg6rpcmz4e8BI5aNOx3rGGYz4FcPZ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCL49AfSuy8e1ZffM1dEIf1lTbjV0nkB8Vdv5HvrNI0=;
 b=EHDw1/d0IeZxBqn4wBFTQf3pqm1YS+Z2r+dvbO3mcojQ1+kDEXXH/dUNJUfhBP2L7Rc7vaL/+LnEPSfCiJLw7JqBxKBBI/p4SeJL9vGtm88o6md/9Vkra582lfsuGWqOuOQIZ61vZTv8efJkeZXWrpY524GfB6Zg3SIApfv3ydSLvGRGosAgxlLg5xaFAwdATMomnSVuJ2LLffajXGcHf4FiB89C1xr7ecPN9/hVepX3uFo4NC0pBoqoxI2dnaCTgdwbFChsGTln7qGOoZltIij5y+yHqHpOV2RftlfnVPRn1RFsdGW2rmGNZcwauqXMVYjDFrVhUKPnibWVElXABw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB5726.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:313::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.14; Mon, 11 Nov
 2024 10:04:56 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8158.013; Mon, 11 Nov 2024
 10:04:56 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "hs@denx.de" <hs@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "agust@denx.de" <agust@denx.de>, "quentin.schulz@cherry.de"
 <quentin.schulz@cherry.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "Schweizer, Walter"
 <walter.schweizer@siemens.com>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "Leto, Enrico" <enrico.leto@siemens.com>
Subject: Re: [PATCH v1 13/22] siemens: configs/capricorn_cxg3_defconfig:
 updates
Thread-Topic: [PATCH v1 13/22] siemens: configs/capricorn_cxg3_defconfig:
 updates
Thread-Index: AQHbMZ4ohmxxICen3UCJiOp4JP6kY7Kx3xSA
Date: Mon, 11 Nov 2024 10:04:56 +0000
Message-ID: <aeb5b86c0cc3ae4a9d9d71189cd8fec1f8b2c039.camel@siemens.com>
References: <20241108052143.26874-1-hs@denx.de>
 <20241108052143.26874-14-hs@denx.de>
In-Reply-To: <20241108052143.26874-14-hs@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB5726:EE_
x-ms-office365-filtering-correlation-id: e62c6859-7792-4133-3a7c-08dd02384b7e
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dDE0VStWRW5mb2NHTWxpMTBjdXZ5T2I2SUNHSTUvU09RQzMwOUpmWVNiT0c4?=
 =?utf-8?B?dm9rdmlscVFUN29zTkpycDZtMkVkVkpKQWVUQW5zcjJ2V1A5eVBCcEo2M0hh?=
 =?utf-8?B?VS9FdU1Qc3dPSDFqVFk4a00vWFYveUFvaFpwTTBCbzBrSm1KNENtdm5qUXhq?=
 =?utf-8?B?MUt3eFh3ZHlYSkl3bUw5eXJRb1hYYk02aGQ0MnhVLzh4ZzR1SG5KNjc1QUEw?=
 =?utf-8?B?cXZ2VDFHa2xBSmpMOTV4VW9Pdi94UmV2YlY0aUpLaUJFRTgzaGplWnc4cXFJ?=
 =?utf-8?B?ZjZwcGlBSE1UQXRWZ2JyUWdvM2F3ckNhTlczSDFKZnp4UnBudUZCWWZvMFlG?=
 =?utf-8?B?QndHT084THRtYnZWMUt2aGFFUUU0MWdMUVEzbTBIT29hTnpXZCtiZnNxWWdq?=
 =?utf-8?B?YzVhblk1Q3pmSjN5cHUvVFdKK0xOczcxeUZYcTBLZi9DM1FxN1MwcFowWmN3?=
 =?utf-8?B?Tk5DNjlKeWQzV2VKNk82ZlFJMlgvaUIxR2ZQYklDZ0RNMzJhaFc4T1FGS3cv?=
 =?utf-8?B?elhWK3pUZWt0eUlkK0l1Nnp4a1FoUUpEaVBqVGxjTDRKZEJIQzEwTzZBRDdM?=
 =?utf-8?B?bEZEZTJwN2VNVEpYVkxtTjh4QmNMam9FSHBuQ2hXV0ZXZmNJZnFkSE9Ycysw?=
 =?utf-8?B?QU16Mmxmb1N4Tmw2blNsVm82SWtuakpyd25RYkM4SDJFQ2Rickx0RHp2QXR5?=
 =?utf-8?B?MlBnRnpLS3hVQzVtZmhjRXcrR3ZxTkZLd1YyV25NNllRMGR3SDZORnJRUS9S?=
 =?utf-8?B?YnZOWUxKOGpCcE1GSy9BMHlrK3B2Z1N4VVo1OE4wQnpRODhzeTNhU3U3dVJL?=
 =?utf-8?B?T2ZSaHB1aVBzc29mMDFJcDdrTjU4ZDZSMW5ubGc2WUJwRHZqa1VYQ09Db3FP?=
 =?utf-8?B?b0tFZXpqOTBUR2pkQis4Sm5XYU1KNDR4emladmp1cE5FZFhCdy9rRGtNMmcx?=
 =?utf-8?B?S080MzRwdzlWM3ZSR0JueUt3V2liSDZoSVpENmVuVTJVZXFqVktneUMrOTd2?=
 =?utf-8?B?MDJ2L3FOQ3IzL3Bwem14aVloL0RCTXRBTC9sSkI4NjFMdVNZdEdpd3RuT2RR?=
 =?utf-8?B?VklBcWFMZTdja05adzlaNURBa2gzZ1lLRS9vQkc5djZYWWtEVUlxdWs0T1Zw?=
 =?utf-8?B?YWdOTFBUWWR2YWc3Y05QeFFvK0JjSHVzRFJzTGptaGdLejVTYXJ1QkMrQ0k2?=
 =?utf-8?B?R08zU2ZMeUZqN28yS1NZS0xiS2lOSDFhMnRnNG9aV2hyVSs3ZjhicVBVMUZw?=
 =?utf-8?B?R1lMTXlzYnRsWHZzaEtmUjFlMFVrMTViR25aVlc1TythM3JpR2cxVUFlS2VO?=
 =?utf-8?B?ZjkzQVBJMEpxZTlZQU1FUnN3NHAwSnExQmkvcElTejBhcm56TldIYVFxSkFm?=
 =?utf-8?B?TnZ2UVpxYUlFUkVSSUxKK1JEZ0lYeFNGNktuWVhXbHlJQWlNcm1RQ0hYNXBD?=
 =?utf-8?B?RHdWT2p2TXdPVDdiTmY1b0N3eWxPS2tvczAzQThDcDZMUGs0UGtCNS9WTHlH?=
 =?utf-8?B?UG9jOTBidkRHOXBrU01vcWlVVmZoSjhnbUExZ2I2czlMbUhkSGwrUDg2bVls?=
 =?utf-8?B?em5La0Vocys5MEdZV0JKejBlR2l4NTNHU2Vxb01QMk9rbG5yalRrWURPSXJv?=
 =?utf-8?B?WENqbWhvVXJLeFBDSHhvZEcyNG85Q2NxRzNQUmNlK1VCazR5TVpKclBVcTNQ?=
 =?utf-8?B?b1JkTForLzVIY2E5a2oyRU9zbFFPVk4wY3NxTTV1cHVIc1RlS1hCUHdsaVZo?=
 =?utf-8?Q?FxWe3JoUUlAGqV7cwg8lLkxnl9ofoEDJsfJuHIE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkFJcVVZQ3BZUzlSSExKNTZSOWsyOWhRYk1KT08zZkpFWnpyVEtKMFo0Z09U?=
 =?utf-8?B?S094Mm4yZjRQQ2E3d3ZITURiajBma0Z2cmF2emhaNVdlbGFVZTRaeVNLL0NS?=
 =?utf-8?B?eWs5a0Z6QmZscWwwN1BmYXdWZWo2TFRFWmhYUmF3ZXl0ZHFNUFVYd2pGQTV0?=
 =?utf-8?B?MGNoS2RnREkzTm1mNW43ejVmaDAxUm5HNVVqMEFLZVM1c0RzQnhDYlRsSk5N?=
 =?utf-8?B?SDVYTTV1S01kR21MREdvekxLYXkxWXRSZklQcDI1NHNlVlZ0MmxBZUdyK1hs?=
 =?utf-8?B?a2JhUFVyK09CbzJNd0VuYTVRMUpSa0h3d3Fwajc1aUZZcjNOTVFZZW96Ty9q?=
 =?utf-8?B?TXgzaEdUR1Nta0h0RG1KTG9sM3dCTkNMQ3RJWnk4VzJybjA0QlYxT1ZIWXBI?=
 =?utf-8?B?blpMdEFYbVZpTzBDaHlDOVZWZzJBTmNzUjcyWlRtZW52NjA0THgxdTQzcnhK?=
 =?utf-8?B?RWw4eDZ0anJ4dmVSNHRRTnRCbWVOTGc4WjgzbFlTMmhjSk9lNHdsRS9reVE5?=
 =?utf-8?B?d0RUMXROaUZKVG1WTCtVNDkyT0N1SENWTlFvZFZrWFI2azN5VUhPTk1HbnVY?=
 =?utf-8?B?eUMzTjFiSURoZkdpUXhWK2E4VU9iK0ZWdGNraENJVUxhWnBJUTkvMzBEUjZW?=
 =?utf-8?B?dXVXUVNuSDd1RElzSFJ1cHRaNGNoa0U1YmhZUzBPZGdhRWswV0lhSEdQL1pt?=
 =?utf-8?B?NHZjSFYzYVRZOHlsaXJNdEdJM0REVVBudkk0dkdnaFJlNlZjTGQ5WTNBZnk5?=
 =?utf-8?B?L25OTGVKVjdGSmRVSlAzck5ueTBod21XcUVpbXMybWJtS0oySldNOG13U2wx?=
 =?utf-8?B?YkI0Ly9OcEFJdFFJd2JkNm8wWnQwQW5LVCt1OGM4UW1Ic2grK0w4azE2M0FE?=
 =?utf-8?B?a3ZwTWkxazFmZGg4ZjNLVWdsb2FaeEtYdzU4bkJOM0hlcUNUL2VqbTBxaDVm?=
 =?utf-8?B?dWVaTUxxNmw4NTJpQjVkaDdWT3hYbFdBZG5iM3pYWmdVSU1mY21pZ2VnRkJK?=
 =?utf-8?B?N0FkTkxORG9kYjArT0tqK09RanJ2bEwvY09XNFBIRnFGaURhZzR3T3dWdXNh?=
 =?utf-8?B?eXlLYjFmNU52NWRpN0cwNVF1WWJBZ0s3K2F5SFJSa011UXUxTW5JRS9uQ29u?=
 =?utf-8?B?azh3aUNBYnRmL1F5VGNRbS9McTlmZzVlbFdJOURvckd6ZE1TZ3MvQTcvaTZI?=
 =?utf-8?B?QU1uMkZwSDJOY2FXdFlIVHNNQlcxdDNtdHMwbG9mRmErWjEwdkVyMnhNNEgy?=
 =?utf-8?B?MVZyTUxLQmtCbTJ3TTVhN0YrQng3b1dTclY5SmU5eXNWaVZvNjZ4QS81K1Bu?=
 =?utf-8?B?aGlXNTVsaDBWZGwvNUNPYk1PakYvYWEwQm1tUG9sVWJGL0lIa3JkRHZlRUlC?=
 =?utf-8?B?NHJpZXc4VWN3U2JRT3pKY2k0MFVUMDBlMzgySDBEQTQzaVA3dHFXNG1xSkgw?=
 =?utf-8?B?am1JRllMd0pacFhlOUxLdldtWTFDY0YwRExXWlZNSkdqTWJDQUU5b2duWnpa?=
 =?utf-8?B?K2VSZnlWREFmMmxlcFJabG1hQkI3NEZvamM3WGR1R3pxTkhERlhleGpVRjBE?=
 =?utf-8?B?N0s4OC9iOU9sc3FhREhGdm1GNnlxYmh1WTVxU21yNk05U0pXLzNmc0lGN01s?=
 =?utf-8?B?eC9FUVVwb1BYUkhNaUk5ckxQYm1nQzkrb0NONU9WUnVqRTRHYVpLT21wRTJk?=
 =?utf-8?B?dUs2aVpXVE0vdlFkRFA1bnB1dkJpZDF6bW5HY3ZpSDE5SDFVdDR4Mk5tL3pT?=
 =?utf-8?B?NEpsM1RSZEQxY2dFajdmZmpjbkd2WUVseE5tbDFENERTNjI2aXJnVDZuK0N5?=
 =?utf-8?B?Y2M4NnBjM3d6UjZIN1hHOWZnaGRwbHM1WVcrSDhyNzlDL3ExY0N4cEtvRHpF?=
 =?utf-8?B?d1FNQkVhK3F5d1c5andkZEg3b3dUUmNSMWY1ZnAxTHZGRFAxSlY3czJxMWxm?=
 =?utf-8?B?Ni96TEwrc1hBbVZjTFBNc09lYVlsRy9jamV1ZHl4WHB4Y25uR2oyYWVRbGtj?=
 =?utf-8?B?eVZ0Mldzbm42R0ZJa1pzNHFzV1hFaHIyblNBc2VaUVdid0IxTTlPYlozWW1S?=
 =?utf-8?B?VGZRaDFxTzM2SzNnaFR4NENZekYvK1BlOUwzZUlYbmh6YmdxZzVFcFJ4akpo?=
 =?utf-8?B?UHI2Q0tob3hKNlJpd215ekRsZzV5YVJsL1dxUjcrZ1o4YWU4UmM1ZkdpQjlz?=
 =?utf-8?Q?347dThtivarAOLuhdU5yBw8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <205B88E1B32AE74184C3E6DAB7E0C5C7@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e62c6859-7792-4133-3a7c-08dd02384b7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 10:04:56.4065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kuVGoKmRJovqb8XRzyMhwujRZBE42qwLPX7AGd2inj7u7WbbHQ/4cx1pr3bKC3S8oFpmIIh5Oc1G/ynmpcpy+UPLbcK+ms3+FO9Rnk2oqWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5726
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

T24gRnJpLCAyMDI0LTExLTA4IGF0IDA2OjIxICswMTAwLCBIZWlrbyBTY2hvY2hlciB3cm90ZToN
Cj4gbWFrZSBzYXZlZGVmY29uZmlnIGFuZCBhZGQgU0NVX1dEVCBhbmQgZml4IGVudmlyb25tZW50
DQo+IG9mZnNldHMsIGFzIHNpbmNlIHNpbGljaXVtIGMwIHRoZSBib290IGNvbnRhaW5lciB0YWtl
cyBwbGFjZQ0KPiBhdCBvZmZzZXQgMCBhbmQgc28gdGhlIHUtYm9vdC1lbnYgbXVzdCBiZSBtb3Zl
ZCBvdXRzaWRlIG9mDQo+IHRoZSBib290IGNvbnRhaW5lciBhcmVhLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogSGVpa28gU2Nob2NoZXIgPGhzQGRlbnguZGU+DQoNClJldmlld2VkLWJ5OiBBbGV4YW5k
ZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4NCg0KPiAtLS0NCj4g
DQo+IMKgY29uZmlncy9jYXByaWNvcm5fY3hnM19kZWZjb25maWcgfCAxNiArKysrKysrKysrKy0t
LS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvY29uZmlncy9jYXByaWNvcm5fY3hnM19kZWZjb25maWcgYi9j
b25maWdzL2NhcHJpY29ybl9jeGczX2RlZmNvbmZpZw0KPiBpbmRleCBjZTgyMGUyYzU0Zi4uNGI5
MmRjMWY5NDMgMTAwNjQ0DQo+IC0tLSBhL2NvbmZpZ3MvY2Fwcmljb3JuX2N4ZzNfZGVmY29uZmln
DQo+ICsrKyBiL2NvbmZpZ3MvY2Fwcmljb3JuX2N4ZzNfZGVmY29uZmlnDQo+IEBAIC0xMCw3ICsx
MCw3IEBAIENPTkZJR19OUl9EUkFNX0JBTktTPTMNCj4gwqBDT05GSUdfSEFTX0NVU1RPTV9TWVNf
SU5JVF9TUF9BRERSPXkNCj4gwqBDT05GSUdfQ1VTVE9NX1NZU19JTklUX1NQX0FERFI9MHg4MDIw
MDAwMA0KPiDCoENPTkZJR19FTlZfU0laRT0weDIwMDANCj4gLUNPTkZJR19FTlZfT0ZGU0VUPTB4
MA0KPiArQ09ORklHX0VOVl9PRkZTRVQ9MHgyMDAwMDANCj4gwqBDT05GSUdfRE1fR1BJTz15DQo+
IMKgQ09ORklHX0RFRkFVTFRfREVWSUNFX1RSRUU9ImlteDgtY2Fwcmljb3JuLWN4ZzMiDQo+IMKg
Q09ORklHX1NQTF9URVhUX0JBU0U9MHgxMDAwMDANCj4gQEAgLTI1LDcgKzI1LDcgQEAgQ09ORklH
X1NQTF9CU1NfTUFYX1NJWkU9MHgxMDAwDQo+IMKgQ09ORklHX1NZU19CT09UTV9MRU49MHg4MDAw
MDANCj4gwqBDT05GSUdfU1lTX0xPQURfQUREUj0weDgwMjgwMDAwDQo+IMKgQ09ORklHX1NQTD15
DQo+IC1DT05GSUdfRU5WX09GRlNFVF9SRURVTkQ9MHgyMDAwDQo+ICtDT05GSUdfRU5WX09GRlNF
VF9SRURVTkQ9MHgyMDIwMDANCj4gwqBDT05GSUdfSURFTlRfU1RSSU5HPSIgIyN2MDEuMDYiDQo+
IMKgQ09ORklHX1JFTUFLRV9FTEY9eQ0KPiDCoCMgQ09ORklHX0VGSV9MT0FERVIgaXMgbm90IHNl
dA0KPiBAQCAtNTUsOSArNTUsMTAgQEAgQ09ORklHX1NQTF9TWVNfTUFMTE9DX1NJTVBMRT15DQo+
IMKgQ09ORklHX1NQTF9TWVNfTUFMTE9DPXkNCj4gwqBDT05GSUdfU1BMX0hBU19DVVNUT01fTUFM
TE9DX1NUQVJUPXkNCj4gwqBDT05GSUdfU1BMX0NVU1RPTV9TWVNfTUFMTE9DX0FERFI9MHgxMjAw
MDANCj4gLUNPTkZJR19TUExfU1lTX01BTExPQ19TSVpFPTB4MzAwMA0KPiArQ09ORklHX1NQTF9T
WVNfTUFMTE9DX1NJWkU9MHg0MDAwDQo+IMKgQ09ORklHX1NQTF9TWVNfTU1DU0RfUkFXX01PREU9
eQ0KPiAtQ09ORklHX1NZU19NTUNTRF9SQVdfTU9ERV9VX0JPT1RfU0VDVE9SPTB4ODAwDQo+ICtD
T05GSUdfU1lTX01NQ1NEX1JBV19NT0RFX1VfQk9PVF9VU0VfU0VDVE9SPXkNCj4gK0NPTkZJR19T
WVNfTU1DU0RfUkFXX01PREVfVV9CT09UX1NFQ1RPUj0weDEwNDANCj4gwqBDT05GSUdfU1BMX1BP
V0VSX0RPTUFJTj15DQo+IMKgQ09ORklHX1NQTF9XQVRDSERPRz15DQo+IMKgQ09ORklHX0hVU0hf
UEFSU0VSPXkNCj4gQEAgLTExMiwxMCArMTEzLDEzIEBAIENPTkZJR19QSFlMSUI9eQ0KPiDCoENP
TkZJR19NVjg4RTYxWFhfU1dJVENIPXkNCj4gwqBDT05GSUdfTVY4OEU2MVhYX0NQVV9QT1JUPTUN
Cj4gwqBDT05GSUdfTVY4OEU2MVhYX1BIWV9QT1JUUz0weDcNCj4gK0NPTkZJR19ETV9FVEhfUEhZ
PXkNCj4gwqBDT05GSUdfRkVDX01YQ19TSEFSRV9NRElPPXkNCj4gwqBDT05GSUdfRkVDX01YQ19N
RElPX0JBU0U9MHg1QjA1MDAwMA0KPiDCoENPTkZJR19GRUNfTVhDPXkNCj4gwqBDT05GSUdfTUlJ
PXkNCj4gK0NPTkZJR19QSFk9eQ0KPiArQ09ORklHX05PUF9QSFk9eQ0KPiDCoENPTkZJR19QSU5D
VFJMPXkNCj4gwqBDT05GSUdfU1BMX1BJTkNUUkw9eQ0KPiDCoENPTkZJR19QSU5DVFJMX0lNWDg9
eQ0KPiBAQCAtMTI5LDUgKzEzMyw3IEBAIENPTkZJR19ETV9TRVJJQUw9eQ0KPiDCoENPTkZJR19G
U0xfTFBVQVJUPXkNCj4gwqBDT05GSUdfRE1fVEhFUk1BTD15DQo+IMKgQ09ORklHX0lNWF9TQ1Vf
VEhFUk1BTD15DQo+IC0jIENPTkZJR19TUExfV0RUIGlzIG5vdCBzZXQNCj4gKyMgQ09ORklHX1dB
VENIRE9HIGlzIG5vdCBzZXQNCj4gK0NPTkZJR19XRFQ9eQ0KPiArQ09ORklHX1dEVF9JTVhfU0NV
PXkNCj4gwqBDT05GSUdfU1BMX1RJTllfTUVNU0VUPXkNCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRs
aW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
