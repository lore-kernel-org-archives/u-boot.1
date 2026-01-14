Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBE2D31A2C
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 09:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA6BD835B3;
	Wed, 14 Jan 2026 10:09:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="WlbxLIQa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CF3683642; Wed, 14 Jan 2026 10:09:34 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B491830A0
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 10:09:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.remmet@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fd1SHAHsJWnbVx1+W3YSeD3R6KRdqBz0NZPZBqJ7L/AEXHwHPqtmQBtl9QAtabWjlHHVrpck0CbJDb6KP6f2JmxUX9uZTsR4/zJoR83rVcoNBMqyZmgAfpdZR13I/tAkHhqypEC+JiU/roP4WeGOjRaN5KzxemfOyt311p8zH1cnS/z5cW8g9UNxbRyhqnNZ+v8qyjSlGLPF8Maow6BoUEiC/ZDIcVkqPSx98rnK3VKCQJYRczv4d0PYMNt9nHxM8TBo0+PTQl2r9CcsU7cNRPxgeSqXlLFPEJpokh33ZE6pkxhGTyejT5C3JkPlSkXtwuz9kY4xCIULvV1dlu1koA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40P1cTiAGB174Ydh0lWU2YP1zDVZn95H0XXQOMCg/6U=;
 b=oAEMnXo2C2Pvv2pHR6kN1mzCJo/hd7WPlOn8mYK2EUZ95g6E5BEsY59D/MQRACJbIh2JmO16TFKksyDQiOo0m59/RZ5eQo3/LQ8XhRuocFYzVji9Z6+m4MvqYAi8LYZefDqouNg1ruJftVDOszslMbODHxOAVp/nLqZ3sRHsUNKtg5PhOKQhdUBfV6kaViBaQ2kf4zs0OqSUQXVD83g13X2QbDZQxoYdmg0Z9KI/NJ2P1W34ipCjdMHJJuA13Wk2GBWvwgjLJzXCaHig/QhoRio+rkV1vMUvuaekUz+4pIXGG6tGtv+n47cbNzlXNC3zitGl8gTE2Lfu+XAnbNpugg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40P1cTiAGB174Ydh0lWU2YP1zDVZn95H0XXQOMCg/6U=;
 b=WlbxLIQa/6myG18YzWWwp084zrB7kkt0hoUf/c8W5DLHSASIgH8WpqjyTWADPQ8yymcNOFrTUVLwG6dEVE+cVbRUEUTSGASupjo0TgVZJS8MI0/Wj/OkBL0v2muAcCZoyhUUdc7ED5BnW6sjnsQD5zJY3ySOxZmoxNuXc343jGW2Tv4uvbI1otspiTaFFuP8PVSUQFTdOwNLH1SqTfIQk/zpDa3RQ0D7WovGUtbugw9OZXD5veFViivnYiDCz8YeEhYzyPZP2Y8WjaS+r3M82DL1DHBkD+fuzQEXqqPr8LiXRZcWdp5N1mjZ9ydvqFoilevMLvmaHza2Z+fok5+GFA==
Received: from DB9P195MB1228.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:297::14)
 by PAWP195MB2416.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:34f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 09:09:29 +0000
Received: from DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
 ([fe80::389e:cc69:1eab:3c56]) by DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
 ([fe80::389e:cc69:1eab:3c56%4]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 09:09:29 +0000
From: Teresa Remmet <t.remmet@phytec.de>
To: Wadim Egorov <w.egorov@phytec.de>, "trini@konsulko.com"
 <trini@konsulko.com>, Garrett Giordano <ggiordano@phytec.com>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] board: phytec: Add PHYTEC mailing list to MAINTAINERS
 entries
Thread-Topic: [PATCH] board: phytec: Add PHYTEC mailing list to MAINTAINERS
 entries
Thread-Index: AQHchTS8JHWXmrn4DEuglMXBoJ4GXLVRYI8A
Date: Wed, 14 Jan 2026 09:09:29 +0000
Message-ID: <03458d9b4cae1cee180816dc17ea2be7924adb00.camel@phytec.de>
References: <20260114090351.3419641-1-w.egorov@phytec.de>
In-Reply-To: <20260114090351.3419641-1-w.egorov@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P195MB1228:EE_|PAWP195MB2416:EE_
x-ms-office365-filtering-correlation-id: 7fad8baf-76bd-4352-85d4-08de534c9fd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QzlYTnVkbzk1NTBZSUh1QUd5UjZpUDBTT21TcWRmUE9NdmNDSytCTlZtL1pV?=
 =?utf-8?B?V3N3Y2l5MmZRT0EyQmJ6US9WNDZLMjVHN3E4MGxscmx1dnNkdVdlcmFwSExK?=
 =?utf-8?B?SWk2b3d0VjVOYlFWemlqdUdwcGlDMUZtNUdZOUNPVkQvWG1hSzJYTkNjWTd5?=
 =?utf-8?B?c3F0SFYxOElpZ2U3Zy9zdWw5WWtSZmtUY3cyczlRelRQRUhzZzdRbHkzS1k4?=
 =?utf-8?B?S3hxQWF3dHJnbGc5aGtrQy9yWnU2ZURwYkZ3WVZCejIxc2N4ZEVsMVZ3L09P?=
 =?utf-8?B?WS9pMjhtWU0rR3U4RmY4MlExbVRBUXhvelNWWHZNQm5DMWo5UlRJZTNNUGRX?=
 =?utf-8?B?OFVEU0dIK0NxMzZQNEZvVFFYUHdoQlRZZGZVTStaa2xWYTlwSkJYTmpLNEs0?=
 =?utf-8?B?Y0N0S0l3QVJTYUFoVWt6bnEzZC95bUVmL0xSS3ZiWWZmMTlubW9ISU9PZTVr?=
 =?utf-8?B?dWJ6WnZEUFFBRzZqS0FxTUVDUGU5L3F0aVp2ZWFncmg5RU1wMFhVTHljV01P?=
 =?utf-8?B?aXo2RmMyUFdYaW1SRFNJN2p1N2NpV1pnMWtzRHZGQTIrZWFvZEpFVXlBQU9x?=
 =?utf-8?B?TkZheDFnS2xIQ2kva1MzUWZYaXBZSTVtaDllZDRwRDZZSk42L0pSZzlXdm5V?=
 =?utf-8?B?NFNmNXBoV0t4Q01HeWo3enFTRWRGOVZTTkFSeDNxSUZJVEdTeXhPOU5GMXpn?=
 =?utf-8?B?eU1RaWY4TXV6YjRweldHMy9EUzVVanJQL3k1RXp5aE9qNjhqRzBaajNkdkkv?=
 =?utf-8?B?Ujg0UlJkMmpXZHR4OThOaGtTaTk1QnovZE5hNEVRcHkrWHc2OCtXS1RUdEEw?=
 =?utf-8?B?a1dTdEh1eHdKQzQ1aFhtWmdVM2hUK1EyWnJXMFRaOXhkM1NvQ2FxWkRCL3d0?=
 =?utf-8?B?dFBIakRoT1B4YzUxbys3TEdzVWd2NThwVFJ5amE1b1VOUWQrTjlPeXREL0hV?=
 =?utf-8?B?RUhVOGpMcVluY0ZkK0l4ZWlPbjVBZXU4ZGZsZ0ZJc2FqaDJEdU5IY3lsd0VP?=
 =?utf-8?B?SXJPQlNRaXE5SHo1ekJsZ2dSNHkxMEQ4OWEyVE40V2FJcGJidERSMStjOGRN?=
 =?utf-8?B?T1BYZ3NDbXJkWjN1aTlxclc1S0ZsREJhK2QvZXM3SEl1RzlTaFVkakozdXZr?=
 =?utf-8?B?dnVFT3R1T3BhMTNDRzhZTW5wMWRPR29YbHlJMElYYnltc3RvMFAzSTZVYjkr?=
 =?utf-8?B?c0lOSEpzeFA4NnpEU0RneXFWWkJkcWlFZjJpMmdqN3VjSDB2NXVBSldOT2RV?=
 =?utf-8?B?RzN4d0k2Z2hFV3o3SkJLZnQ3YnlLYzVQNkJIVHJadUtJK1pURk1McU9MMEps?=
 =?utf-8?B?S2ppdmE4ci8rVHJ2TGhSS05jRlRXTDh5cCtMSFoyQXg3dXFQZGZoYmNOeG5q?=
 =?utf-8?B?UDB4YWNyNlY0N3FncmtLWThTaTZiUmtaNForZWs2VWc2NVI1STgrSWd6MjJF?=
 =?utf-8?B?ejZVTmZqb2tRMFFVcS9CbUhHZjlMTFVNdEw4YWd1aElKK1Z4OHA1cENMQmQ3?=
 =?utf-8?B?U056dU1rWmVzKy9hMk1FMWkrWFRaTEoyamgyMDBUSHcyM3hpVEF5MmVSTTZ2?=
 =?utf-8?B?YTN0LzJ3UWs4RXRsbGZoYlFZMHpFZTRWZDI2UkRJejViNm1XdXIzckFhbnFx?=
 =?utf-8?B?Um81dVVBdlFOLy9BMnNpT1BjeXJSdTNRK3h0TDlJa2hPSFUzMUNnUkY2RUE2?=
 =?utf-8?B?TU5GRVJLRXBWUjRyWllycmRxWDAzT3FpNWJjUGdMcXIrakdIb0pSYlRESDNS?=
 =?utf-8?B?Q0YyOE9DZWUrSDZYMGthWWFwNnJjTUYycFlJc2RYWEQ0OXVUdG9DZVl4TVI1?=
 =?utf-8?B?MG8rTjhhb2tEbWE5ODZTZzNkTzg1ZTdaQkM3NkhpZmZLek5MSjc0QmV1ZHpj?=
 =?utf-8?B?Q3hMSE9EaHl2TjBPd0tKYVJaZUJ5MUlUakppc3NDcjJpdUhEQWE2V2RKZytn?=
 =?utf-8?B?a0xOdTlsK1hyYnNyTXlzMGk0NHZjamVjMkpyNjNKeFBnL3cwQnJ1aDEvWkxD?=
 =?utf-8?B?TS9IWlorTVZiajc2Zk1COXJ4S04yNVNYOWIzQ2lNNm9zOEdSbi9VK01xM0ZT?=
 =?utf-8?Q?6R+KAQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9P195MB1228.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3c0WEJKd2xEVWlYTUJaN2YzdkptYmZUSFFqdndIc1hZeDR6MG9ZVk51UEFM?=
 =?utf-8?B?RVUrZjhMTzNKLzRIa1ZQaXBqWWNYRmZiZ0NWL2Q2b2NDZk0zQTB1VTlNOU1U?=
 =?utf-8?B?dWZFSnMyZXpOYWJaYW9HendueS9WQXU4MndVVkhFb3RNZURxOXlCdzZvSVNn?=
 =?utf-8?B?R214SXQ5b05xbjJQbU16blhwcnNKTWZUWHBGV3dKbEFOc1Bod3pxb0YwZURV?=
 =?utf-8?B?VFp4enVwVEZoNHcyWGJBa01LTllPU0NaR2FnbU1LZ2pDMHBuSnV1S09vMEFZ?=
 =?utf-8?B?aHIrYUEzL1BwSU1paFQ2dE5tYXJZd21jTllhUU1WNG1qOXZ3S3paOE11aExZ?=
 =?utf-8?B?dEtldUJmcGwzZDVoSTBmSkEyK3p0aDJLUk1zQVVFZm1hcVdJOVB6ZmJ3Rm5L?=
 =?utf-8?B?YkFqQTIzWXpGdnZ3NW9wZEU1QWNOR1F5TnpYRDJyNzkzaExLcURvempZeVV5?=
 =?utf-8?B?aXJtWERDQTVwNEZpMHNEMkt6VFYzSjUrY2U1dDBJRHNmYlB4K3FwQmZDNVhz?=
 =?utf-8?B?bE9HQjZNZmM5bENNNlhjWTArdXR6QVFkUHVZNjBrM2tROUlQYVU5NlVHMGcz?=
 =?utf-8?B?aXpiV1JxbEc5OWpiSUJwMDJnMjRNclR1RVh3Nk1JekUxZ1VkRlNMNllKV3g5?=
 =?utf-8?B?QlZVSUxaY2pmV1lINys2bHl1enduYk81UUdRM2c0Q0dSZTQvRWtMbHhqUER0?=
 =?utf-8?B?UldBSkc4ZWVza2tncWs2WVVBYmVPdjFNeFYxa21zZFROdTRmRit1WGRhTUZS?=
 =?utf-8?B?UmdCeTJDZmFmd3NWVzNSTG80eDl3MVVIVmFZKzNCNk1qcndjTkh3OXNrWjc2?=
 =?utf-8?B?ZnBkaUNYWUlnYlowUWx4dDdzTmVGUVNsbGQwQjBvM1BjYkJIOGpmRVhEVmlF?=
 =?utf-8?B?R0xmUGkwWE9jcXptZ29iSTRKWTEyMWQxQ1NWWTZFMCtab1dCcmZsVmFPT1hD?=
 =?utf-8?B?R3NDT09CeTJUVy94MU91UWNQNzVVV3lEQVdJUDUya3hKbWpJblR1THJOTXdF?=
 =?utf-8?B?NzhYaHJ6dUxLbDgyQXhaMkNmT0dTY3kybU5RcTlUblpOU0FJZ1dDZy9YUGVM?=
 =?utf-8?B?VFlBK0ZaTG14enc1aHhIaG0wSi9vOVFTcmVNZEZvK1p4Nm9Wank5V2NBTVBG?=
 =?utf-8?B?R1BFTGFHcTM2VFZieDd6MndRUXhXUXFyTExzTGFIL2xzQ0FGNkpFemRsWHUv?=
 =?utf-8?B?dkhVSU5FNUgyKzFjdS9LYnc4R21tVkxzZ1NWTjR1dm9YZEEwUmkxUXczYlVS?=
 =?utf-8?B?aTZmQU51ek1saFBYV09yby9rTjhhVThEOGhRUVZuK0UvYS90TXlCN0tMSFow?=
 =?utf-8?B?ZWl0RTRpd2VBWCtCOWljUUthT29raVBGaXFQSGdqNHJXakJydVBKTFZwOXlO?=
 =?utf-8?B?R1E0bW9wbC9qOWRmKzZqMUVTRTBIYUVsZmFpWG5rWVM2U2FNTkkyUFVRRGNX?=
 =?utf-8?B?ZkZtdkxrWjh5WUg4Qk51VDlTaTJaczhRNVd1ZlBQZGRHU1dHT0JXM2lLZ055?=
 =?utf-8?B?RHZJODRWbVFxVnhUQktPcWFTT1VUR2ZLT2tic3F0RURUSE5xSHNxV3FGY3hW?=
 =?utf-8?B?cGVEdmk1MWpOMXpoY0JRQzcyanY5RjVFbnE4KzBrQVN6L1R6YWdmcFBvVmJ5?=
 =?utf-8?B?dVc4NERheU5sNzVYZDFPVTdyQ3VBbDAwcUx3U3g3a3RHZ0hoSm1Kc1hzWjBY?=
 =?utf-8?B?RWQ0WENlNm5NN2UwcVdHQlBMM1BTRTJDMS9qK2hQQ0lrbSs4ZzMvd0VtMlo4?=
 =?utf-8?B?UlpkNmlCa0xpVU9iZVRSNnZEdzltaTEzbjUyQUQ1TkpjRnR6MjFpaXQvQ3lT?=
 =?utf-8?B?VkcyYUJSRXVFbnM0NkhJQUUxdnFINStWL2srNGdsOHNUWFBDRXYwTDBCRmdQ?=
 =?utf-8?B?S0Y0Z1crbVM3T0ROOEFoL2x4V2lLY2N0SXVXdFBaSW9FaTJsR0hFeTlLT00r?=
 =?utf-8?B?b01NU2Y3RDBCY0krcitjTWJkencwU1dzZCszbU5GNEIzck9Bak02cDJqWXQx?=
 =?utf-8?B?WGNuZWtsQVQ0QUR6Q2VFdThiRVRvKzZNZGZodlNTSHp4ZUpLYUc5L1lLTVRy?=
 =?utf-8?B?bnpWaDNNZ0xBVjhYSEFqK2J2V1Z2UWhROVE2QStlVGhvWGRwTEdORnF2Qktx?=
 =?utf-8?B?cXNFOHVFdzhOWnFMYmFFc3gxb2NjcW9BY1pHK3Nla3RJYWtkUXpXRlNreU5y?=
 =?utf-8?B?MTVjTndRUWtlTUpDK09oek50V3FOMytNRHMxTE8zUEErczRIbW8xeU9Eenpu?=
 =?utf-8?B?UkpCaTF5dllMOWJYUHFTSEJNdnB5eFdKUWJpS0xrTCtPZ2xFSy9RbU92RXhJ?=
 =?utf-8?B?NWdzU1h4TFdIbkwrWXc0czZybWdvVU9MaS80YjNHUWlLN1ZYR1Q4Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51212C8ECB71CD4B94B848294ED198F6@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fad8baf-76bd-4352-85d4-08de534c9fd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 09:09:29.6996 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dcUhLqKULuy+Ge2ZjQT4eVBx+d1hDhZjlyn2Lp1Podfr2UtXihYcrp4cjuOhenPTzwre+ncLuGFJbnsaIrw5Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP195MB2416
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

QW0gTWl0dHdvY2gsIGRlbSAxNC4wMS4yMDI2IHVtIDEwOjAzICswMTAwIHNjaHJpZWIgV2FkaW0g
RWdvcm92Og0KPiBQSFlURUMgbWFpbnRhaW5zIGFuIGFjdGl2ZWx5IG1vbml0b3JlZCBtYWlsaW5n
IGxpc3QgZm9yIHVwc3RyZWFtDQo+IGFjdGl2aXRpZXM6IHVwc3RyZWFtQGxpc3RzLnBoeXRlYy5k
ZS4gQWRkIGl0IHRvIHRoZSBNQUlOVEFJTkVSUw0KPiBlbnRyaWVzIGZvciBQSFlURUMgYm9hcmRz
IHdlIGFjdGl2ZWx5IGRldmVsb3AgYW5kIGNvbnRyaWJ1dGUgdG8uDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBXYWRpbSBFZ29yb3YgPHcuZWdvcm92QHBoeXRlYy5kZT4NCg0KQWNrZWQtYnk6IFRlcmVz
YSBSZW1tZXQgPHQucmVtbWV0QHBoeXRlYy5kZT4NCg0KPiAtLS0NCj4gwqBib2FyZC9waHl0ZWMv
aW14OG1wLWxpYnJhLWZwc2MvTUFJTlRBSU5FUlMgfCAxICsNCj4gwqBib2FyZC9waHl0ZWMvcGh5
Y29yZV9hbTYyYXgvTUFJTlRBSU5FUlPCoMKgwqAgfCAxICsNCj4gwqBib2FyZC9waHl0ZWMvcGh5
Y29yZV9hbTYyeC9NQUlOVEFJTkVSU8KgwqDCoMKgIHwgMSArDQo+IMKgYm9hcmQvcGh5dGVjL3Bo
eWNvcmVfYW02NHgvTUFJTlRBSU5FUlPCoMKgwqDCoCB8IDEgKw0KPiDCoGJvYXJkL3BoeXRlYy9w
aHljb3JlX2lteDhtbS9NQUlOVEFJTkVSU8KgwqDCoCB8IDEgKw0KPiDCoGJvYXJkL3BoeXRlYy9w
aHljb3JlX2lteDhtcC9NQUlOVEFJTkVSU8KgwqDCoCB8IDEgKw0KPiDCoGJvYXJkL3BoeXRlYy9w
aHljb3JlX2lteDkzL01BSU5UQUlORVJTwqDCoMKgwqAgfCAxICsNCj4gwqBib2FyZC9waHl0ZWMv
cGh5Y29yZV9yazMyODgvTUFJTlRBSU5FUlPCoMKgwqAgfCAxICsNCj4gwqA4IGZpbGVzIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2JvYXJkL3BoeXRlYy9pbXg4
bXAtbGlicmEtZnBzYy9NQUlOVEFJTkVSUw0KPiBiL2JvYXJkL3BoeXRlYy9pbXg4bXAtbGlicmEt
ZnBzYy9NQUlOVEFJTkVSUw0KPiBpbmRleCAxZmQ5OTg4OGEyZS4uYzJkMjRiN2MzODYgMTAwNjQ0
DQo+IC0tLSBhL2JvYXJkL3BoeXRlYy9pbXg4bXAtbGlicmEtZnBzYy9NQUlOVEFJTkVSUw0KPiAr
KysgYi9ib2FyZC9waHl0ZWMvaW14OG1wLWxpYnJhLWZwc2MvTUFJTlRBSU5FUlMNCj4gQEAgLTEs
NSArMSw2IEBADQo+IMKgTGlicmEtaS5NWCA4TSBQbHVzDQo+IMKgTToJVGVyZXNhIFJlbW1ldCA8
dC5yZW1tZXRAcGh5dGVjLmRlPg0KPiArTDoJdXBzdHJlYW1AbGlzdHMucGh5dGVjLmRlDQo+IMKg
VzoJDQo+IGh0dHBzOi8vd3d3LnBoeXRlYy5ldS9lbi9wcm9kdWt0ZS9zeXN0ZW0tb24tbW9kdWxl
cy9waHljb3JlLWlteC04bS0NCj4gcGx1cy1mcHNjLw0KPiDCoFM6CU1haW50YWluZWQNCj4gwqBG
OglhcmNoL2FybS9kdHMvaW14OG1wLWxpYnJhLXJkay1mcHNjLXUtYm9vdC5kdHNpDQo+IGRpZmYg
LS1naXQgYS9ib2FyZC9waHl0ZWMvcGh5Y29yZV9hbTYyYXgvTUFJTlRBSU5FUlMNCj4gYi9ib2Fy
ZC9waHl0ZWMvcGh5Y29yZV9hbTYyYXgvTUFJTlRBSU5FUlMNCj4gaW5kZXggZmViMWUwYjM5ZGMu
LmRlZDRhODhkMTk5IDEwMDY0NA0KPiAtLS0gYS9ib2FyZC9waHl0ZWMvcGh5Y29yZV9hbTYyYXgv
TUFJTlRBSU5FUlMNCj4gKysrIGIvYm9hcmQvcGh5dGVjL3BoeWNvcmVfYW02MmF4L01BSU5UQUlO
RVJTDQo+IEBAIC0xLDYgKzEsNyBAQA0KPiDCoHBoeUNPUkUtQU02MmF4DQo+IMKgTToJR2FycmV0
dCBHaW9yZGFubyA8Z2dpb3JkYW5vQHBoeXRlYy5jb20+DQo+IMKgTToJV2FkaW0gRWdvcm92IDx3
LmVnb3JvdkBwaHl0ZWMuZGU+DQo+ICtMOgl1cHN0cmVhbUBsaXN0cy5waHl0ZWMuZGUNCj4gwqBX
OglodHRwczovL3d3dy5waHl0ZWMuY29tL3Byb2R1Y3QvcGh5Y29yZS1hbTYyYQ0KPiDCoFM6CU1h
aW50YWluZWQNCj4gwqBGOglhcmNoL2FybS9kdHMvazMtYW02MmEtcGh5Y29yZS1zb20tYmlubWFu
LmR0c2kNCj4gZGlmZiAtLWdpdCBhL2JvYXJkL3BoeXRlYy9waHljb3JlX2FtNjJ4L01BSU5UQUlO
RVJTDQo+IGIvYm9hcmQvcGh5dGVjL3BoeWNvcmVfYW02MngvTUFJTlRBSU5FUlMNCj4gaW5kZXgg
Mjc0ZGMwY2JiODEuLjcyNzRlNmFhMzc2IDEwMDY0NA0KPiAtLS0gYS9ib2FyZC9waHl0ZWMvcGh5
Y29yZV9hbTYyeC9NQUlOVEFJTkVSUw0KPiArKysgYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9hbTYy
eC9NQUlOVEFJTkVSUw0KPiBAQCAtMSw1ICsxLDYgQEANCj4gwqBwaHlDT1JFLUFNNjJ4DQo+IMKg
TToJV2FkaW0gRWdvcm92IDx3LmVnb3JvdkBwaHl0ZWMuZGU+DQo+ICtMOgl1cHN0cmVhbUBsaXN0
cy5waHl0ZWMuZGUNCj4gwqBXOglodHRwczovL3d3dy5waHl0ZWMuY29tL3Byb2R1Y3QvcGh5Y29y
ZS1hbTYyeA0KPiDCoFM6CU1haW50YWluZWQNCj4gwqBGOglhcmNoL2FybS9kdHMvazMtYW02Mi1w
aHljb3JlLXNvbS1kZHI0LTJnYi5kdHNpDQo+IGRpZmYgLS1naXQgYS9ib2FyZC9waHl0ZWMvcGh5
Y29yZV9hbTY0eC9NQUlOVEFJTkVSUw0KPiBiL2JvYXJkL3BoeXRlYy9waHljb3JlX2FtNjR4L01B
SU5UQUlORVJTDQo+IGluZGV4IGY1Mjk0ZGI5OTE2Li4wYmE1MDM5MzRjOCAxMDA2NDQNCj4gLS0t
IGEvYm9hcmQvcGh5dGVjL3BoeWNvcmVfYW02NHgvTUFJTlRBSU5FUlMNCj4gKysrIGIvYm9hcmQv
cGh5dGVjL3BoeWNvcmVfYW02NHgvTUFJTlRBSU5FUlMNCj4gQEAgLTEsNSArMSw2IEBADQo+IMKg
cGh5Q09SRS1BTTY0eA0KPiDCoE06CVdhZGltIEVnb3JvdiA8dy5lZ29yb3ZAcGh5dGVjLmRlPg0K
PiArTDoJdXBzdHJlYW1AbGlzdHMucGh5dGVjLmRlDQo+IMKgVzoJaHR0cHM6Ly93d3cucGh5dGVj
LmNvbS9wcm9kdWN0L3BoeWNvcmUtYW02NHgNCj4gwqBTOglNYWludGFpbmVkDQo+IMKgRjoJYXJj
aC9hcm0vZHRzL2szLWFtNjQtcGh5Y29yZS1zb20tZGRyNC0yZ2IuZHRzaQ0KPiBkaWZmIC0tZ2l0
IGEvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1tL01BSU5UQUlORVJTDQo+IGIvYm9hcmQvcGh5
dGVjL3BoeWNvcmVfaW14OG1tL01BSU5UQUlORVJTDQo+IGluZGV4IDU4YzVlMmQwYWY5Li41Y2Fk
YTE1YWM0YiAxMDA2NDQNCj4gLS0tIGEvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1tL01BSU5U
QUlORVJTDQo+ICsrKyBiL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtbS9NQUlOVEFJTkVSUw0K
PiBAQCAtMSw1ICsxLDYgQEANCj4gwqBwaHlDT1JFLWkuTVg4TSBNaW5pDQo+IMKgTTrCoMKgwqDC
oMKgIFRlcmVzYSBSZW1tZXQgPHQucmVtbWV0QHBoeXRlYy5kZT4NCj4gK0w6wqDCoMKgwqDCoCB1
cHN0cmVhbUBsaXN0cy5waHl0ZWMuZGUNCj4gwqBXOsKgwqDCoMKgwqANCj4gaHR0cHM6Ly93d3cu
cGh5dGVjLmV1L3Byb2R1Y3QtZXUvc3lzdGVtLW9uLW1vZHVsZXMvcGh5Y29yZS1pbXgtOG0tbWlu
aS1uYW5vLw0KPiDCoFM6wqDCoMKgwqDCoCBNYWludGFpbmVkDQo+IMKgRjrCoMKgwqDCoMKgIGFy
Y2gvYXJtL2R0cy9pbXg4bW0tcGh5Ym9hcmQtcG9saXMtcmRrLXUtYm9vdC5kdHNpDQo+IGRpZmYg
LS1naXQgYS9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bXAvTUFJTlRBSU5FUlMNCj4gYi9ib2Fy
ZC9waHl0ZWMvcGh5Y29yZV9pbXg4bXAvTUFJTlRBSU5FUlMNCj4gaW5kZXggNjQ1NDc2YWUzMGEu
LjkzNDNlM2I1NTBkIDEwMDY0NA0KPiAtLS0gYS9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bXAv
TUFJTlRBSU5FUlMNCj4gKysrIGIvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1wL01BSU5UQUlO
RVJTDQo+IEBAIC0xLDUgKzEsNiBAQA0KPiDCoHBoeUNPUkUtaS5NWDhNIFBsdXMNCj4gwqBNOsKg
wqDCoMKgwqAgVGVyZXNhIFJlbW1ldCA8dC5yZW1tZXRAcGh5dGVjLmRlPg0KPiArTDrCoMKgwqDC
oMKgIHVwc3RyZWFtQGxpc3RzLnBoeXRlYy5kZQ0KPiDCoFc6wqDCoMKgwqDCoA0KPiBodHRwczov
L3d3dy5waHl0ZWMuZXUvcHJvZHVjdC1ldS9zeXN0ZW0tb24tbW9kdWxlcy9waHljb3JlLWlteC04
bS1wbHVzLw0KPiDCoFM6wqDCoMKgwqDCoCBNYWludGFpbmVkDQo+IMKgRjrCoMKgwqDCoMKgIGFy
Y2gvYXJtL2R0cy9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay11LWJvb3QuZHRzaQ0KPiBkaWZm
IC0tZ2l0IGEvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OTMvTUFJTlRBSU5FUlMNCj4gYi9ib2Fy
ZC9waHl0ZWMvcGh5Y29yZV9pbXg5My9NQUlOVEFJTkVSUw0KPiBpbmRleCA3MzkzMDYxNzA3ZC4u
MGIwODdiZjFlZjIgMTAwNjQ0DQo+IC0tLSBhL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDkzL01B
SU5UQUlORVJTDQo+ICsrKyBiL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDkzL01BSU5UQUlORVJT
DQo+IEBAIC0xLDYgKzEsNyBAQA0KPiDCoHBoeUNPUkUtaS5NWDkzDQo+IMKgTTrCoMKgwqDCoMKg
IE1hdGhpZXUgT3RoYWNlaGUgPG0ub3RoYWNlaGVAZ21haWwuY29tPg0KPiDCoFI6wqDCoMKgwqDC
oCBDaHJpc3RvcGggU3RvaWRuZXIgPGMuc3RvaWRuZXJAcGh5dGVjLmRlPg0KPiArTDrCoMKgwqDC
oMKgIHVwc3RyZWFtQGxpc3RzLnBoeXRlYy5kZQ0KPiDCoFc6wqDCoMKgwqDCoA0KPiBodHRwczov
L3d3dy5waHl0ZWMuZXUvZW4vcHJvZHVrdGUvc3lzdGVtLW9uLW1vZHVsZXMvcGh5Y29yZS1pbXgt
OTEtOTMvDQo+IMKgUzrCoMKgwqDCoMKgIE1haW50YWluZWQNCj4gwqBGOsKgwqDCoMKgwqAgYXJj
aC9hcm0vZHRzL2lteDkzLXBoeWJvYXJkLXNlZ2luLXUtYm9vdC5kdHNpDQo+IGRpZmYgLS1naXQg
YS9ib2FyZC9waHl0ZWMvcGh5Y29yZV9yazMyODgvTUFJTlRBSU5FUlMNCj4gYi9ib2FyZC9waHl0
ZWMvcGh5Y29yZV9yazMyODgvTUFJTlRBSU5FUlMNCj4gaW5kZXggZTNiMGFmOThlOWEuLmE3YWIw
MjNmZjMyIDEwMDY0NA0KPiAtLS0gYS9ib2FyZC9waHl0ZWMvcGh5Y29yZV9yazMyODgvTUFJTlRB
SU5FUlMNCj4gKysrIGIvYm9hcmQvcGh5dGVjL3BoeWNvcmVfcmszMjg4L01BSU5UQUlORVJTDQo+
IEBAIC0xLDUgKzEsNiBAQA0KPiDCoHBoeUNPUkUtUkszMjg4DQo+IMKgTToJV2FkaW0gRWdvcm92
IDx3LmVnb3JvdkBwaHl0ZWMuZGU+DQo+ICtMOgl1cHN0cmVhbUBsaXN0cy5waHl0ZWMuZGUNCj4g
wqBTOglNYWludGFpbmVkDQo+IMKgRjoJYXJjaC9hcm0vZHRzL3JrMzI4OC1waHljb3JlLXJkay11
LWJvb3QuZHRzaQ0KPiDCoEY6CWJvYXJkL3BoeXRlYy9waHljb3JlX3JrMzI4OA0KDQotLSANClBI
WVRFQyBNZXNzdGVjaG5payBHbWJIIHwgQmFyY2Vsb25hLUFsbGVlIDEgfCA1NTEyOSBNYWlueiwg
R2VybWFueQ0KDQpHZXNjaMOkZnRzZsO8aHJlcjogRGlwbC4tSW5nLiBNaWNoYWVsIE1pdGV6a2ks
IERpcGwuLUluZy4gQm9kbyBIdWJlciwNCkRpcGwuLUluZy4gKEZIKSBNYXJrdXMgTGlja2VzIHwg
SGFuZGVsc3JlZ2lzdGVyIE1haW56IEhSQiA0NjU2IHwNCkZpbmFuemFtdCBNYWlueiB8IFN0Lk5y
LiAyNi82NjUvMDA2MDgsIERFIDE0OTA1OTg1NQ0K
