Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BB1C83F25
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 08:17:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E15C832EA;
	Tue, 22 Jul 2025 10:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="i1zFvwj1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF81F830CA; Tue, 22 Jul 2025 07:10:07 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFCEF83093
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 07:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQs1REqVk8dDHqyP9XjsZFuZbajQG09hvlhmXAGI/lk2XuCxGvF0N6cOh1ITuc6hwo2lA+OCpP15CnBstac4RpdhLKdGJGsAcjKsmQh5cmWMFta6Ra65h0+tMs9P/IAePDtR7J+o+WgxYB9OtKidD+1YxNZulboZff/ZbL7xN2DdKT50HFAeilRt3wY+teLXzifctJnRGIfbeOXvN9wqGB/T0HaTxwYyPjDdQHWj5rtV6zmC/T904Uhy2zfnSf2AIiZ2LIOFupIM3nMZGZLnSWJ/y0fThBQy0/KMHPgwI8f/eiqoZmsdBBa2AgHfxuAIrSQaDHnLPUKWFC1ifSdJIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9S63rBjxGjLrVOsBcUrHwLlfCpdh0/NzRp1d4YEevAE=;
 b=YnR+9mdPsBj26ifJV66XWpaEXbNOckeo9BNthauka/xHjGwF1XlgmbZkCBeIEH+ZlvBCDaeNpyobWYgrxl/AkM4q32opx4KjatpsM0njq5wvKYDT8VYBrGRAdYWpw5FAgl4u4xSi90WlhpZ4Kv+a7ifzKrQEtNzF8QkWgk3lBgPdfqMZYQCBUslZv5sM40ahdo9Dw468wz8GQTuVXzuQS/jYYQ4yJTW2BCR2eGodQf3ntzgZd6JdD8ibKYkeWphX98UxE8QgDdgQIA5U7c+9q9RYVYqmDnJiLH9D1kMbqD6C58YRQav6vWEdKULgvj2URvXEtVjViAoJFK1KT06fwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9S63rBjxGjLrVOsBcUrHwLlfCpdh0/NzRp1d4YEevAE=;
 b=i1zFvwj19d9CvYjAGWli6wnoHE8TeJW5DlZV7jMxFLISmcFzR14vMaudsk83Z97WSFNgcfPEvqm9u2M4IgrRk1aVJk1v4f/bkpkPN6L6JaH6fbw+E6hn+nwXUfz6KNu1cwsvU1Wc79gdgGDt2jVzqa82jpdp9nTaaq+Z6jC+Mf7Hq4CwFvamoQN+fTPEbK36SwiFJbLlxgmXAwC5jCMCigDGRJowH4N11hQ4AYM2tRphzptQZJJ4oxu1S+ZaJiv8PqkB50SSL8KA1BReAGWUJqh+veMBJK/eyU6EWFM/tLJBmDw+6ftqUkCe41MCDDybrL06c3TrNqnOH8tX+ae40w==
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH7PR03MB6917.namprd03.prod.outlook.com (2603:10b6:510:12c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 05:10:00 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 05:10:00 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
To: "hs@denx.de" <hs@denx.de>, Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Frank Wunderlich
 <linux@fw-web.de>, Padmarao Begari <padmarao.begari@amd.com>, Holger Brunck
 <holger.brunck@hitachi-powergrids.com>
Subject: RE: Please pull u-boot-i2c master
Thread-Topic: Please pull u-boot-i2c master
Thread-Index: AQHb9uFosvkYZdGL30u2Ob/WcJ1ijrQ3+9iAgADfWYCAAArt0IAEuJjA
Date: Tue, 22 Jul 2025 05:10:00 +0000
Message-ID: <PH7PR03MB6942C3609388E34D6B62CD69F75CA@PH7PR03MB6942.namprd03.prod.outlook.com>
References: <06c2b16e-1e3d-7632-70be-d6df4232ff71@denx.de>
 <20250718150113.GU193579@bill-the-cat>
 <3ef949d6-9c42-0876-d5a7-a055340d52df@denx.de>
 <PH7PR03MB69424603B76A18A20C7C7994F753A@PH7PR03MB6942.namprd03.prod.outlook.com>
In-Reply-To: <PH7PR03MB69424603B76A18A20C7C7994F753A@PH7PR03MB6942.namprd03.prod.outlook.com>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB6942:EE_|PH7PR03MB6917:EE_
x-ms-office365-filtering-correlation-id: 763fe28b-e73a-4a6d-b423-08ddc8de026d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZEQxdVVLSU5HcTk4RE1uV2JPV0xOU2ViQnVRS1Q4SUJManc4eG85dytOSm9F?=
 =?utf-8?B?MzRkd1lUR0ZJNEpyNHVVU25OMiswWDhKdzFiY09kQ1paMkNpS0xXV284b3JY?=
 =?utf-8?B?NkFTbzJaSGkwb0M3Vk5STGFZcUdUYnRBZmgzU3Myanh1S3hHNnNWcGE0anFv?=
 =?utf-8?B?ZE9mYW5ZUlVkd05ucFNJNUt0U1NUQkNORThneDQzcDkvNlFSbFB1QWl1SlRq?=
 =?utf-8?B?V29OVXZMckloVVBnT1ZMQ0phMi9ndkg2WldDZTFCSlE3Z3FxU21wVk5PRmpj?=
 =?utf-8?B?VFRFbVkzUmQyZWhRa3h2V0dLMjVqdWlCSDcxR1dvM1IrQ1RONEVLd1Q0Yjg1?=
 =?utf-8?B?VktaY0t2Rm5odGZ3bGdVUWpIY1NrSWVrTDcyMWRVcXZZZHVyRlJuZkZ4SFYv?=
 =?utf-8?B?UG1YTC9LNHY2WFdCRGd4RVJOUExBYlc4WTE2SzNzN1Y5aWx1TUpBVGlodGtT?=
 =?utf-8?B?TVR4TUR6NVl1dExZN3ROOE5tQmxEaGxmbzBqZTV3NDczaHZadTZqWk9aRzNw?=
 =?utf-8?B?N3JJTUd1MmNseHE1S2U3UktYSjVLcWMxSjRSNTgvZzZDNlhNeWpYV3h6aENj?=
 =?utf-8?B?andQdTZJcjhKY1puTy9NK0Z1VmdYOWdJaGJkcC9aaFoyVU9DTVZJcVhtcElh?=
 =?utf-8?B?RUJtNFV4aXU5dzM5SHBNcDhuVjVWbnJ5UmNIUjdqNkZONGFINlN6REpVU1hl?=
 =?utf-8?B?VzhsaEV5Z2FzR0RlMzdqamZTTjBXYjZpNG1MV1pTMG5RZ2dOQnJ0d04vSVpq?=
 =?utf-8?B?VmVqbEtxcXNSVnhlc2NES3NKRmFqZVd6cFByUW5XU0hRTXUvTjhkZTVFS0pp?=
 =?utf-8?B?dWJJRUI5QzRPazVCMjRkWW1MVVVJVm1jVUw5SGVwdGNXV1FBT1k5QXBLQTI1?=
 =?utf-8?B?eGh4dlloYS9UZEpvUS9YVmZLZEFQeVBRZG9TL1BxR0I3V0FaTUxQeE8wYVAy?=
 =?utf-8?B?V05rL21NVEIwSXVIM0xmQmxzSExGYlBJMm55NDFpWU4wbm1jTEFqQS9QWWxV?=
 =?utf-8?B?S1JtZC9xV0t2aUZOd3BwTnB2MjMrbloxT2tJTEZFSm40S0dQOHlxZG5mQ2NJ?=
 =?utf-8?B?WjYweGxDSUtoVE16L2I3THg3UGwvY2MyNVpuNjBUTjFxdXk4OXJaTm13Mzcx?=
 =?utf-8?B?NFBQRjh1Y1NabW9zeWZYR0ZkVFFCL1ZVdkovTE5JZ1lWQUxuS0VPWGVDc010?=
 =?utf-8?B?Y2I4VWJWZEsyN3N0clZTbTJIeEdDdktzc2xPYmFPNlhLT1NqNktLZmxWL1Z5?=
 =?utf-8?B?TEpWOTVrUzBvQmJFdWJweC8wTXJEVStoOWFSalpCL1BSVENUbnIwazhpMFpo?=
 =?utf-8?B?b1BSbnYrakk5VkdJS25ybzF4Y3dTZFMyL1lCWFlJWnNLOGoyeFVRMWpZMkww?=
 =?utf-8?B?YzAvdURiYnZEZTNLTXBHRk1vQnJiZGVZdklNWVhtK1FsVEgyTWV1eXdwTDJL?=
 =?utf-8?B?SVA2UzFTWGYvV2FNSC9NWHJwL21hdFl0azhPc21lMkQxdG00alRhSHFwNTFJ?=
 =?utf-8?B?cThtek9wVGhoVjhsUUJ5bVFCTEYxR1VrNGg3Mm9jLzBZNnlzSnNCbWpFTkhC?=
 =?utf-8?B?bEFiWkxYTEtZZ0VCbkphOXdaUXlubmdVVS90dlRibDc1ZW9NMEoyQXg5dGw3?=
 =?utf-8?B?TWNaSjh2NjJ2dkpvVitvbmoxUVljekg0MnFLRG1PK1REMnNNM281ZDlYN0Rn?=
 =?utf-8?B?cWRLc01CM0NMN2txd25VZGpWd04yanN4dWd0L3dHcDZrN1JGVmh2Q3BSNWRr?=
 =?utf-8?B?SXZVYm94UlptaHpRcThwSmtGRFJzWjBkejduL1RpcnM0TDBYNUtsYXR0ZS9x?=
 =?utf-8?B?NjRleVhqNU9TNk5lcHBzNkdXeXBTLzE3NlR5NUZHUHYvMmxLS2F2dzJWOVJp?=
 =?utf-8?B?aGo4QUpPdmgzd1JrVm9zMnBKMmdsQnhyTTJlZHpwNU5LQzNMczUrcjlaeHhR?=
 =?utf-8?Q?xqje1qKGXSw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzRhS3lGOGdTalByNVY1WWFESGhBYVhCLzJvaFJxU2ExdEJnMk91TTN4dnFR?=
 =?utf-8?B?OGVNRkd6WUpCMXNFdjl4U0c4V2NhSHMyV000Q2U3MURUMWFCMVhuYUp2YW85?=
 =?utf-8?B?dm9JOTFCTmc3MzgyRDZxRGhGbkdYemFwYkE2WVplQlFnbU9Xc3NzWlQ2b3Bw?=
 =?utf-8?B?MHIrR3VJS2oxemg3MXUrTUpESXEzVWlqTDBaMWhDVW1OdEpJWW1RK2dkZ3BC?=
 =?utf-8?B?aUVJUkxGNHdweUlRZ1JEcGV1b3NUejJiaGRiejlib0xrMWNVKzhTVnNSQXRU?=
 =?utf-8?B?Szg0clZIR0NTSkRiUHhJVFBRVFFGalJYQlFGSk56eUVnRDlib1lzNy9SZ3J4?=
 =?utf-8?B?UUt2OWJraTdZRmJCaWhEMS9JSXNKcGFpVnN5a3AzMC93bUVGSFFRaGYxNldq?=
 =?utf-8?B?NGpTOTgwelQ0cGxvcjY4V3h1cU5kKzV2ZEhXeFZRYUJEejNtcG0xdC9rQjdI?=
 =?utf-8?B?elc1c3Npb1Y5emU1dG04Q2Nza3NUanZPOWFwWktSa1VEWTUzcTE1WUVmYStO?=
 =?utf-8?B?NDNuYXBMK3hOcnJwR0FFSlIxT2VrSUh5bC9lOUdoUWF5enY2aE04bVlBT0ZP?=
 =?utf-8?B?ckU4RTBKN1QzMStBWlpHaVNjdEZpWG1oQWtMdTFKb1RlM2R3V2V1SGZ2eEZi?=
 =?utf-8?B?UTJBaUxqaVlFL3o2ZTcvM1NxaWVFVmF6OHBiWE1LbzZiZUVaRWNUYXdzbTQ4?=
 =?utf-8?B?bm0xRDEraEE1QlI5eUdmMVA0ejRtaXBXcDAzRWh2RU1MMTdLcWF4VFVqU21M?=
 =?utf-8?B?V0pKbGRPK0lOdDF6Z1AzdHpNZ1hNZDhuNVlHL0VVSmdKeUZGMGQxbFRXcDY0?=
 =?utf-8?B?NnBQcjI3MlNCblpCRkhPK05KOE80M1J1NGlmMTNnbU1kMXBaYlB0Q2orN0ZY?=
 =?utf-8?B?alBBZXFRZUNUL0Mwd2tuTzR5ZjlRNXpyRmxMQ0huU0FzZ0ZhYUlvNDZEMXRh?=
 =?utf-8?B?cldyRGlOVFpZMVN1YnNsTGV6L05ydjZSVm41UmkxSklmWFNyeXdkK0RoazVU?=
 =?utf-8?B?NnAzK21kNm5qaVJpNUowZWFTazZra0FSR3JyTHJmL2RVTDRSTGFRNVRoUnVN?=
 =?utf-8?B?V1FzUSsrUitDTnlSS21hVTk1QWEvdGg1UDJWanpIM0NKSEk1eWk3bjVBS2ta?=
 =?utf-8?B?QXFJSHE4WnhiZXJrcjl5dDAvN0szNlNxeGF2bU0xWUNkV1NOc3lIbTM4aDF2?=
 =?utf-8?B?YWtyRWQyRnZEamJGSVZsSkU1KytQbEh2TXFtMnJCWlZzcGV0L2RvSlk4OTJN?=
 =?utf-8?B?clVYTGw2SVVMQzQwKzZ0OUh4RFFvMEcvMWRYZDJ1V0xua0tsbkl5YXgwaGVM?=
 =?utf-8?B?c0RiNm4zNHArbklyWkJvOHJkRHdJMlBDSmp3bFRsMkowT2RITjNPUnd5Ujkv?=
 =?utf-8?B?c1BCWWwzOUVjeUdpbDM0UnhDLzhRS0l0NU9QYUYzVnhQaGhrZFdnSmRpOUtD?=
 =?utf-8?B?UEVFWVJqWWNrSW1HTHhNNi9hRVVlMkJVUHZERVJBT1FiTXg1V0pTV1JRenVM?=
 =?utf-8?B?eWF2aW9heGxURFoySHZMdzY0YlJlcVJDNmJPY21zNmdHcW05Z3V4RkRZalBN?=
 =?utf-8?B?TTNaVGZCak5NWnNBZzRQdWEzZURDck1nNkdOeUk2dGU4Z0k5aG9YbXFubVVv?=
 =?utf-8?B?djE3SE9NYk5pbTJ4MW1ZUHhmcko4ZW51RE1CNVR4UnF1bDhrMjhFV0xFU0V1?=
 =?utf-8?B?TXB0R1RIRFgrU2duNExqcFd3ekNXSk4vN1hLQk9ITWJvUnFaTFN0eDEycm55?=
 =?utf-8?B?TUx3QytWY3JHd1FxM3VvZ1dIN2FuN0o1RGcwT1FRb3FBYVJoaWFhR3kxaERZ?=
 =?utf-8?B?WkJJTnAwZm0wcGM5cXVDY252dWd2NUFzam5WM01YWVV1UGlHZXgyUTJuVUx5?=
 =?utf-8?B?RDh2bDlUWkhDYWxBK01oMHFnL3NXcmN4YTJIZ1FzNjUzYXA1ZlczMTE5MElr?=
 =?utf-8?B?RFhjVkM4YnN3NVk0UHV3TnlqK29WSUQ3RTRJcXhZMEw4eHh1UGh5MFhaaER6?=
 =?utf-8?B?ZGhaQnJ3YTE0bVJ1aFNVR0JiT2RpeU1oQis1VHhvOWROTjBFeVAvZTY2enZq?=
 =?utf-8?B?SmNtZTZLdEVhYWRwOU5KSVRWTVBLSFR2aXZPK2JSbWF1YSsyZjlhOHVPWlUy?=
 =?utf-8?B?dGRnRDBTcUtXVHpDUWlNZHNPbG96aEx3ck56YXlDRGZmVU1DQUd1TVpIbXh6?=
 =?utf-8?Q?cAdsDDiYog93NX/rVQAyMGWfUipfXdDNgy7dhKVHeZ5S?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763fe28b-e73a-4a6d-b423-08ddc8de026d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 05:10:00.5068 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N1oqnBGDRN+5mVy3x16K2aFflx83+zTNAuOQa+GpbJqltxpD1pvwrc/pxsZMsbAl/0yrp8ghQFecHd9SksoVX0wrmifFGJ5JSSg+dk7No7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB6917
X-Mailman-Approved-At: Tue, 22 Jul 2025 10:17:46 +0200
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFuaXlhbSwgRGlu
ZXNoDQo+IFNlbnQ6IFNhdHVyZGF5LCAxOSBKdWx5IDIwMjUgMTowMiBwbQ0KPiBUbzogaHNAZGVu
eC5kZTsgVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT4NCj4gQ2M6IHUtYm9vdEBsaXN0cy5k
ZW54LmRlOyBGcmFuayBXdW5kZXJsaWNoIDxsaW51eEBmdy13ZWIuZGU+OyBQYWRtYXJhbw0KPiBC
ZWdhcmkgPHBhZG1hcmFvLmJlZ2FyaUBhbWQuY29tPjsgSG9sZ2VyIEJydW5jayA8aG9sZ2VyLmJy
dW5ja0BoaXRhY2hpLQ0KPiBwb3dlcmdyaWRzLmNvbT4NCj4gU3ViamVjdDogUkU6IFBsZWFzZSBw
dWxsIHUtYm9vdC1pMmMgbWFzdGVyDQo+IA0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPiBGcm9tOiBIZWlrbyBTY2hvY2hlciA8aHNAZGVueC5kZT4NCj4gPiBTZW50
OiBTYXR1cmRheSwgMTkgSnVseSAyMDI1IDEyOjIxIHBtDQo+ID4gVG86IFRvbSBSaW5pIDx0cmlu
aUBrb25zdWxrby5jb20+DQo+ID4gQ2M6IHUtYm9vdEBsaXN0cy5kZW54LmRlOyBGcmFuayBXdW5k
ZXJsaWNoIDxsaW51eEBmdy13ZWIuZGU+OyBQYWRtYXJhbw0KPiA+IEJlZ2FyaSA8cGFkbWFyYW8u
YmVnYXJpQGFtZC5jb20+OyBNYW5peWFtLCBEaW5lc2gNCj4gPiA8ZGluZXNoLm1hbml5YW1AYWx0
ZXJhLmNvbT47IEhvbGdlciBCcnVuY2sgPGhvbGdlci5icnVuY2tAaGl0YWNoaS0NCj4gPiBwb3dl
cmdyaWRzLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogUGxlYXNlIHB1bGwgdS1ib290LWkyYyBtYXN0
ZXINCj4gPg0KPiA+IFtDQVVUSU9OOiBUaGlzIGVtYWlsIGlzIGZyb20gb3V0c2lkZSB5b3VyIG9y
Z2FuaXphdGlvbi4gVW5sZXNzIHlvdQ0KPiA+IHRydXN0IHRoZSBzZW5kZXIsIGRvIG5vdCBjbGlj
ayBvbiBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIGFzIGl0IG1heQ0KPiA+IGJlIGEgZnJhdWR1
bGVudCBlbWFpbCBhdHRlbXB0aW5nIHRvIHN0ZWFsIHlvdXIgaW5mb3JtYXRpb24gYW5kL29yDQo+
ID4gY29tcHJvbWlzZSB5b3VyIGNvbXB1dGVyLl0NCj4gPg0KPiA+IEhlbGxvIFRvbSwNCj4gPg0K
PiA+IE9uIDE4LjA3LjI1IDE3OjAxLCBUb20gUmluaSB3cm90ZToNCj4gPiA+IE9uIFRodSwgSnVs
IDE3LCAyMDI1IGF0IDA4OjEwOjE3QU0gKzAyMDAsIEhlaWtvIFNjaG9jaGVyIHdyb3RlOg0KPiA+
ID4NCj4gPiA+PiBIZWxsbyBUb20sDQo+ID4gPj4NCj4gPiA+PiBUaGUgZm9sbG93aW5nIGNoYW5n
ZXMgc2luY2UgY29tbWl0DQo+ID4gNTNiZDg3NjUxZTQ1YjMyZWZhMzk4ZGQ1ZTQzM2Q4YjkzZDc4
MTQ0NToNCj4gPiA+Pg0KPiA+ID4+ICAgIGJsb2NrOiBzYW5kYm94OiBBZGQgc3VwcG9ydCBmb3Ig
U1lTXzY0QklUX0xCQSAoMjAyNS0wNy0xMQ0KPiA+ID4+IDExOjMzOjI1DQo+ID4gPj4gLTA2MDAp
DQo+ID4gPj4NCj4gPiA+PiBhcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoN
Cj4gPiA+Pg0KPiA+ID4+ICAgIGh0dHBzOi8vc291cmNlLmRlbnguZGUvdS1ib290L2N1c3RvZGlh
bnMvdS1ib290LWkyYy5naXQNCj4gPiA+PiBpMmMtZm9yLTIwMjUuMTANCj4gPiA+Pg0KPiA+ID4+
IGZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0bw0KPiA+IDVlODBjNjc1NzM3OGQwOTk1MDIz
NTA4MzUzM2U3YTdjM2FlYWUzYmU6DQo+ID4gPj4NCj4gPiA+PiAgICBjb25maWdzOiBhZ2lsZXg1
X2RlZmNvbmZpZzogRW5hYmxlIGkzYyBjb25maWdzIGZvciBhZ2lsZXg1DQo+ID4gPj4gKDIwMjUt
MDctMTYgMDk6MzM6NTQgKzAyMDApDQo+ID4gPj4NCj4gPiA+PiAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPj4gaTJj
IHVwZGF0ZXMgZm9yIHYyMDI1LjEwDQo+ID4gPj4NCj4gPiA+PiAtIGkyYyBLY29uZmlnIHVwZGF0
ZXMgZnJvbSBUb20NCj4gPiA+PiAgICAtIGFkZCBzb21lIGRyaXZlciBkZXBlbmRlbmNpZXMNCj4g
PiA+PiAgICAtIGFkZGVkIG1pc3NpbmcgaW5jbHVkZSBkZWxheS5oIGluIGlwcm9jX2kyYy5jDQo+
ID4gPj4NCj4gPiA+PiAtIGkyYzogbXV4ZXM6IEFkZCBQQ0E5NTQxIGkyYyBhcmJpdHJhdG9yIGRy
aXZlcg0KPiA+ID4+ICAgIGZyb20gUGFkbWFyYW8gQmVnYXJpDQo+ID4gPj4NCj4gPiA+PiAtIHBj
YTk1NHg6IGFkZCBwY2E5NTQ1IHN1cHBvcnQNCj4gPiA+PiAgICBmcm9tIEZyYW5rIFd1bmRlcmxp
Y2gNCj4gPiA+Pg0KPiA+ID4+IC0gY21kOiBpMmM6IGZpeCBidWlsZCB3aGVuIENGR19TWVNfSTJD
X05PUFJPQkVTIGRlZmluZWQgd2l0aCBETV9JMkMNCj4gPiA+PiAgICBGcm9tIEhvbGdlciBCcnVu
Y2sNCj4gPiA+Pg0KPiA+ID4+IC0gYWRkZWQgaTNjIHN1cHBvcnQgdG8gVS1Cb290IGFuZCBlbmFi
bGUgaXQgZm9yIGFnaWxleDUNCj4gPiA+PiAgICBib2FyZCBmcm9tIERpbmVzaCBNYW5peWFtDQo+
ID4gPg0KPiA+ID4gVW5mb3J0dW5hdGVseSB0aGUgaTNjIHN1cHBvcnQgbGVhZHMgdG8gdGhpcyBp
biBjb3JlYm9vdDoNCj4gPiA+IGh0dHBzOi8vc291cmNlLmRlbnguZGUvdS1ib290L3UtYm9vdC8t
L2pvYnMvMTIwMjk0OS9yYXcNCj4gPiA+DQo+ID4gPiBXaGljaCBsb29rcyBsaWtlIGNvcmVib290
IGp1c3QgZ2V0cyBzdHVjayBpbiBhIGxvb3A/IEFuZCBpbiB0dXJuLA0KPiA+ID4gdGhhdCBsZWFk
IG1lIHRvIGRvIHRoaXMgbG9jYWxseToNCj4gPiA+IGNvbW1pdCAwM2U5ZDVmNGM2MWNiYTVkOGUx
ZGI4MWQ3NTlmZWZkNjIyYjNhZDQ5DQo+ID4gPiBBdXRob3I6IFRvbSBSaW5pIDx0cmluaUBrb25z
dWxrby5jb20+DQo+ID4gPiBEYXRlOiAgIFRodSBKdWwgMTcgMTU6MjI6MDggMjAyNSAtMDYwMA0K
PiA+ID4NCj4gPiA+ICAgICAgaGFjayBkcm9wIGdlbmVyaWMgY2hhbmdlcw0KPiA+ID4NCj4gPiA+
ICAgICAgU2lnbmVkLW9mZi1ieTogVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT4NCj4gPiA+
DQo+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kbS9kZXZpY2UuaCBiL2luY2x1ZGUvZG0vZGV2
aWNlLmggaW5kZXgNCj4gPiA+IGM1Y2ZhMThkMDlkNi4uNjc4Y2Q4M2MyNzE2IDEwMDY0NA0KPiA+
ID4gLS0tIGEvaW5jbHVkZS9kbS9kZXZpY2UuaA0KPiA+ID4gKysrIGIvaW5jbHVkZS9kbS9kZXZp
Y2UuaA0KPiA+ID4gQEAgLTE2OSw3ICsxNjksNiBAQCBlbnVtIHsNCj4gPiA+ICAgICogQGRtYV9v
ZmZzZXQ6IE9mZnNldCBiZXR3ZWVuIHRoZSBwaHlzaWNhbCBhZGRyZXNzIHNwYWNlIChDUFUncykg
YW5kIHRoZQ0KPiA+ID4gICAgKiAgICAgICAgICBkZXZpY2UncyBidXMgYWRkcmVzcyBzcGFjZQ0K
PiA+ID4gICAgKiBAaW9tbXU6IElPTU1VIGRldmljZSBhc3NvY2lhdGVkIHdpdGggdGhpcyBkZXZp
Y2UNCj4gPiA+IC0gKiBAb2Zfbm9kZTogQXNzb2NpYXRlZCBkZXZpY2UgdHJlZSBub2RlDQo+ID4g
PiAgICAqLw0KPiA+ID4gICBzdHJ1Y3QgdWRldmljZSB7DQo+ID4gPiAgICAgICBjb25zdCBzdHJ1
Y3QgZHJpdmVyICpkcml2ZXI7DQo+ID4gPiBAQCAtMjAyLDcgKzIwMSw2IEBAIHN0cnVjdCB1ZGV2
aWNlIHsNCj4gPiA+ICAgI2lmIENPTkZJR19JU19FTkFCTEVEKElPTU1VKQ0KPiA+ID4gICAgICAg
c3RydWN0IHVkZXZpY2UgKmlvbW11Ow0KPiA+ID4gICAjZW5kaWYNCj4gPiA+IC0gICAgIHN0cnVj
dCBkZXZpY2Vfbm9kZSAgICAgICpvZl9ub2RlOw0KPiA+ID4gICB9Ow0KPiA+ID4NCj4gPiA+ICAg
c3RhdGljIGlubGluZSBpbnQgZG1fdWRldmljZV9zaXplKHZvaWQpDQo+ID4NCj4gPiBVZmYuLiB5
ZXAsIG92ZXJzZWVuIHRoaXMgY2hhbmdlLi4uDQo+ID4NCj4gPiA+IFdoaWNoIGxlYWRzIG1lIChh
KSBiZWluZyBjb25jZXJuZWQgYWJvdXQgd2hhdCBvdXIgY29yZWJvb3Qgc3VwcG9ydA0KPiA+ID4g
aXMgdXAgdG8gYW5kIChiKSB3aHkgaTNjIG5lZWRzIHRoaXMgZ2VuZXJpYyBjaGFuZ2U/IEFuZCBJ
IGRvbid0IGp1c3QNCj4gPiA+IHdhbnQgdG8gc2VlIENPTkZJR19JU19FTkFCTEVEKCknaW5nIGl0
LCB3aHkgZG8gd2UgaGF2ZSB0byBoYW5kbGUgdGhlDQo+ID4gPiBkZXZpY2UgdHJlZSB0aGF0IHdh
eSBhbmQgaXMgdGhlcmUgbm8gc3RhbmRhcmQgbWVjaGFuaXNtIHdlIGNhbiB1c2U/DQo+ID4gPg0K
PiA+DQo+ID4gQGRpbmVzaDogd2h5IGRvIHlvdSBuZWVkIHRoaXM/DQo+ID4NCj4gPiBJdCBzaG91
bGQgYmUgcG9zc2libGUgaW4gdGhlIG1hc3RlciBkcml2ZXIgdG8gZ2V0IHRoZSBvZiBwb2ludGVy
IHdpdGgNCj4gPg0KPiA+DQo+ID4gb2Zub2RlIG5vZGUgPSBkZXZfb2Zub2RlKGRldik7DQo+ID4N
Cj4gPiBhbmQgaWYgeW91IHJlYWxseSBuZWVkIGl0IGluIGRyaXZlcnMvaTNjL21hc3Rlci5jIHBh
c3MgaXQgdG8gdGhlIGZ1bmN0aW9ucyB5b3UgY2FsbC4uLg0KPiA+IGFoLCBubywgYXMgeW91IGFs
cmVhZHkgc2F2ZSB0aGUgdWRldmljZSBpbiBpM2NfbWFzdGVyX2NvbnRyb2xsZXIsIHlvdQ0KPiA+
IGNhbiBzaW1wbHkgdXNlDQo+ID4NCj4gPiBkZXZfb2Zub2RlKGRldikNCj4gPg0KPiA+IGluIGl0
IQ0KPiA+DQo+ID4gWW91IGNhbiBzaW1wbHkgZHJvcCBvZl9ub2RlIGZyb20gZ2VuZXJpYyBmaWxl
LCBhbmQgdXNlIGRldl9vZm5vZGUoZGV2KQ0KPiA+IGluIHlvdXIgZHJpdmVyL2kzYyBjb2RlIC4u
LiBtYXkgeW91IHNhdmUgdGhlIHVkZXZpY2UgaW4gcHJpdmF0ZSBkYXRhDQo+ID4gb3IgaW4geW91
ciBpM2NfZGV2X2JvYXJkaW5mbyBzdHJ1Y3QgaW5zdGVhZCBpZiByZWFsbHkgbmVlZGVkLCBzbyBw
bGVhc2UgcmV3b3JrDQo+IHRoYXQgcGFydC4NCj4gPg0KPiA+IEBUb206IEkgd2lsbCBkcm9wIGkz
YyBzdXBwb3J0IGZyb20gbXkgcHVsbCByZXF1ZXN0IGFuZCBzZW5kIGEgbmV3IG9uZQ0KPiA+DQo+
ID4gQW5kIHllcywgdGhlIHF1ZXN0aW9uIGEpIHJlbWFpbnMgLi4uDQo+ID4NCj4gPiBUaGFua3Mh
DQo+ID4NCj4gPiBieWUsDQo+ID4gSGVpa28NCj4gDQo+IFllcyBhZ3JlZWQhIEkgY2FuIHVzZSBk
ZXZfb2Zub2RlKGRldikgYW5kIHdpbGwgcXVpY2tseSByZXdvcmsgb24gdGhpcyBwYXJ0Lg0KPiAN
Cj4gVGhhbmtzDQo+IERpbmVzaA0KPiANCg0KSSBoYXZlIGRvbmUgdGhlIHJld29yaywgdHJpZWQg
dG8gcnVuIHRoZSBDSSBpbiBnaXRodWIgYmVmb3JlIHN1Ym1pdHRpbmcgdG8gZGVueC4NCmh0dHBz
Oi8vZ2l0aHViLmNvbS91LWJvb3QvdS1ib290L3B1bGwvODAyDQoNCkhvd2V2ZXIsDQoNCkZhY2lu
ZyBzb21lIGZhaWx1cmUgZHVlIHRvIDoNCkNsb25pbmcgaW50byAnL3RtcC91Ym9vdC10ZXN0LWhv
b2tzJy4uLg0KZmF0YWw6IHVuYWJsZSB0byBhY2Nlc3MgJ2h0dHBzOi8vc291cmNlLmRlbnguZGUv
dS1ib290L3UtYm9vdC10ZXN0LWhvb2tzLyc6IFRoZSByZXF1ZXN0ZWQgVVJMIHJldHVybmVkIGVy
cm9yOiA1MDINCg0Kc2VlbXMgbGlrZSBkZW54IHVwc3RyZWFtIHNlcnZlciBpc3N1ZSENCg0KUmVn
YXJkcywNCkRpbmVzaA0KDQo+ID4gLS0NCj4gPiBERU5YIFNvZnR3YXJlIEVuZ2luZWVyaW5nIEdt
YkgsIE1hbmFnaW5nIERpcmVjdG9yOiBKb2hhbm5hIERlbmssIFRhYmVhDQo+ID4gTHV0eiBIUkIg
MTY1MjM1IE11bmljaCwgT2ZmaWNlOiBLaXJjaGVuc3RyLjUsIEQtODIxOTQgR3JvZWJlbnplbGws
IEdlcm1hbnkNCj4gPiBQaG9uZTogKzQ5LTgxNDItNjY5ODktNTIgICBGYXg6ICs0OS04MTQyLTY2
OTg5LTgwICAgRW1haWw6IGhzQGRlbnguZGUNCg==
