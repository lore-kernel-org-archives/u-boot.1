Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C2BCAC59A
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 14:47:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01CAE833C0;
	Fri, 19 Sep 2025 16:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sttls.nl header.i=@sttls.nl header.b="OXqzD5AL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E898B82C84; Fri, 19 Sep 2025 10:15:51 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DD13801DD
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 10:15:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Maarten.Brock@sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntaGvz6wsGXhswU0fAa2ZYQB9pmz9UaTmZuOG05MO+ZfEr2rpgEVtrnjYJhPbZ/of0p7+wMiA00EWsftly3zK8YQwE0VYWc7VXTXI9oCq2E5LYV3wvpM1tVsGKMEDTQBjAQIoU3josLtwpv5v2NBptPNOT3HNKw3KrLoyLFPm13fPgSSXWzk10vL944CB+6+xvzGxhkm8H21KqEg6S/iJrM5rbj19agEiDPjhJ2oJa2BNW1BihKBG2VVUTshFx8eOkmEPMtaBNdzfhJHJvIB/GQCAzXL3SoKI7YtFuVFroARlWigdTVm624my7jfr8OuLJiNrHmOKe+NJ+PVXLHlKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6Swgj1S69atAZrcUEfxfMrfQo6lCKcSkwLj6BH/vvs=;
 b=LKbY0R/qaSmN5JoQ8qQ3I3LaWvcweqY1eEQQ4Z92c35AcR8zIJZIHIqF9iQ3wtP27ZugHmY5601b6gcWKwbHksYLpP7JltYvGYqb1B3abfKtVms4FuqTYjpVfBxKKV1ZlSYG4FSuIC8y64zds+0C8N2Bzp13VMRh2gKL8mHO0l9FiPduZaq+5SbS+qlyHI1AjpLKOhzWX3jOkhBM+C4J/00Qd97J+Nw+mNQg+WMVjCrWfv0EfLrFebABXhwFiJ9m3AkH+GnQD5ZI6X10swhd7qyUnpXPqYgOEb0MmH07+BWeQi1J38M29WAsvstomi5k50dxsOV6PAT/l2HjTXyIBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=konsulko.com smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6Swgj1S69atAZrcUEfxfMrfQo6lCKcSkwLj6BH/vvs=;
 b=OXqzD5ALgykWGrC4tUJRwjUyHEUqZAOHF9Ci/vddR2mLtEPlNUGXzB65dK3/j+LHGHbtoqXlbjXwJbaT+RpdG8WP0Lyrzn9UPCQmeLsnmrVCE9mNav9ZNrWUFhX2UbyY5GTH6M9fU6Ex+A0Cncz8kdLy+8PgG6z4Dnb9CuM9PVLC1HNS/0fThJFb61EWN+s54WQxQmwxBNfpyT/d4hv2ZiJsUl9CcWv62yMym15RWmc41E2AeJhCBmukpEHM8cO2BWFo30KCj+6vnXiL7bWC+R2InK4o5rVVth7FgB23W0T7XvkTbgXvknzLuZ6Pu01VUiVy+4/SZuPF69CGPcwkZQ==
Received: from DB9PR01CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::8) by AMDPR05MB11703.eurprd05.prod.outlook.com
 (2603:10a6:20b:6cb::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 08:15:32 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:1d8:cafe::c) by DB9PR01CA0003.outlook.office365.com
 (2603:10a6:10:1d8::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Fri,
 19 Sep 2025 08:14:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 08:15:31 +0000
Received: from AS8PR07CU003.outbound.protection.outlook.com (40.93.65.55) by
 westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Fri, 19 Sep 2025 08:15:31 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com (2603:10a6:6:4a::24) by
 DBAPR05MB7048.eurprd05.prod.outlook.com (2603:10a6:10:183::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.16; Fri, 19 Sep 2025 08:15:29 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53]) by DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53%5]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 08:15:29 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "jerome.forissier@linaro.org" <jerome.forissier@linaro.org>, Kory Maincent
 <kory.maincent@bootlin.com>, "sjg@chromium.org" <sjg@chromium.org>
Subject: RE: [PATCH 1/1] board: ti: am335x: Do not call disabled PMIC functions
Thread-Topic: [PATCH 1/1] board: ti: am335x: Do not call disabled PMIC
 functions
Thread-Index: AQHcINmJWmfe7YqAm0qbuGfL+fh/urSZsiOAgACHF5A=
Date: Fri, 19 Sep 2025 08:15:28 +0000
Message-ID: <DB6PR05MB455171F726E8D6E540141BAE8311A@DB6PR05MB4551.eurprd05.prod.outlook.com>
References: <DB6PR05MB4551D31271569EC04E8EC60F830CA@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250919001117.GA974973@bill-the-cat>
In-Reply-To: <20250919001117.GA974973@bill-the-cat>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: DB6PR05MB4551:EE_|DBAPR05MB7048:EE_|DB1PEPF000509E9:EE_|AMDPR05MB11703:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a2b8f2-6c9d-47b3-86af-08ddf754b3ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?UFJKcGxLdlFGanpXUjFVOUkyOWQ5SGFwa2N6S0I5YkNZb2NtUEhXVUlWL2dy?=
 =?utf-8?B?clBBck1LRlNWekJPbzY5d0Z0U1E5MFQ1SXJINnBEMTBKN3lmR2JQL2VLbFEy?=
 =?utf-8?B?Qndob0ZZamNHaHJhY0NYMWp6dEpPb3FvcDVmY3NoelZnVHFnYzh3aWhSSHdy?=
 =?utf-8?B?Z2lwdWI1VVc0WTZrOTlNTkNBOTYreDhmVng1MkxVWXcyRkNLQW5iWkVGSFM4?=
 =?utf-8?B?N2IvVFV5dWJBbjNSZklkVU12YkoxVVhqNmRLNTZySm43cTUzbGtqcWVSS1Z3?=
 =?utf-8?B?aWhKZXNqSjdCNVVCdnhMZmVkV2xNZkxndVlqbFJsRHdjNk1VYTl1T2s0ckp2?=
 =?utf-8?B?V0Vibm45MmE5U3VtejdNNE5LTS9Nc1AvbmsraHNpRVJCQkNiWlMzQUx4empu?=
 =?utf-8?B?K2NycTNxYW9XQVpvS1lWTUc4YjlDbk9PSy9SOGNEend1YWpWWjA1aWx0T01z?=
 =?utf-8?B?NEJNa2MrNWJlVTRkMmpFYUFvTzdJNFFyS2JZZGhIMWZiRWEzbnM4WmRVN1cy?=
 =?utf-8?B?NG1IZ1ZzanpMbm9nTTZMdFRoSVdra2xHejBId3NzRFpzUU1rWHMwWWdEZ1F4?=
 =?utf-8?B?Y0RXdElDVDZtS3VJL1ErVzBXQUtqZmZ4aEc2bXVFZnU1dFRtczQ5dVQrV3Bh?=
 =?utf-8?B?ZzhNT01ZWWhEdTZwTmUvVlkzZkx5MC9Wb1RKWVN2dVh6VEpML0c5azlyUW5F?=
 =?utf-8?B?Umt1WHR2ZyttTnRwR3kyU3VTSlZBRUFQUXBGRlhJR0dVWGRxV3BaVzBuNXl6?=
 =?utf-8?B?WUpCZDJIMG5aejU1NTVrYUxXWEtlVHdKR3B3RHdqU09HZDZVdFVBVUtiZ0Nm?=
 =?utf-8?B?d2pLNERWN1gvcjVzbVdya3I5REVmRkRnbjBOek5SbTdSeStBa0pSeGI1Mmll?=
 =?utf-8?B?Ry9tTFkrdVBVTC9lVWMwT2FKQXZHNTE5UjVrZXhadEtnK3BqK2NBYnpBUGNM?=
 =?utf-8?B?czJkYnlSK1BsZG5JZWFIOEdrMEp5NCtLeVVham0vQ3RJdGpHUnUvVWJMTklU?=
 =?utf-8?B?RktZRW1RUW93UzJKQ3liT2tlUys0WENKckRFb3gyeVpJMldpL0F4Z2FzODVN?=
 =?utf-8?B?TkJmRlFwVDRNTER6MktaS0o3NXJvc2tJa2E2dFRGWlZ1SVVWQWVoU0xUUU1G?=
 =?utf-8?B?U0l1OEF6dVRGMU5waTRnblQ3bTJZWi9LSEc1MkR4RzRPRTE0Zjd1UVRkNEVP?=
 =?utf-8?B?WFBiamg4ZVlqUE5oMTZCMEp0M29QQXhCTzlKWU9KbXNqODkyYS9wOTRzclN2?=
 =?utf-8?B?ZjFHcWxXbUd5bEI3TnpTTUFDZ3QybjR1bWlSYzU5ZkJybEROSDBQTi9SQTBr?=
 =?utf-8?B?a1NsenZTeHk4SnAvQS9RM3J1KzVXNm9ZRitrYjhWY3p1S2hCbXdMVGQ0aitn?=
 =?utf-8?B?bHQ3bkU3cnhGZ3FpTTJTNmVJVUswc3lVaVcrbkxXUHcyRUtSd1ZURk4xY2Ux?=
 =?utf-8?B?dUdSNHFFMytUenF1Z05yMjZ2d1pvOWs1UDhBcFZ5Ymo5a0J4R2FkaVlPYnhI?=
 =?utf-8?B?NDRvU0dtOHpveFp6MTlyUWxtTlJJUENTL080M08zN2xzNUpSYlZYM0wwdzE2?=
 =?utf-8?B?U0pFYTY5bEhVYVRZdlI5NFVMcDNZUGUwQkpKU2YvY3BUY0dvUTBFcDZjYXFz?=
 =?utf-8?B?S0MxdXVOWk1aYmZlalBGVjJXaGVDTCtWVEtvbmdhbzF5aWgxTjE5bEMvTUlV?=
 =?utf-8?B?c2ZSWXpOR0lGajZQRlhEZndweFRCQkRmbUNENE05TVFNT3NQQXdKNUFBZ1M1?=
 =?utf-8?B?a1dMYW1YWUlvelRyQnl5ZmtFUU9vUytYVnJkTVAxZmJuVWk0RTV4b2FycGFh?=
 =?utf-8?B?eURVbjBJUUt4TWxIN0o3WS9Hb0lIZkJleFhEcEJIT1RYbGxpOERSWXRxK25F?=
 =?utf-8?B?ZkxYOGtrL1o5T3hsVzhYR29pK3VsUFFuYWRsTjlNUjhRWldJN3lOZk4ydHNX?=
 =?utf-8?B?QzZUVDNBRUZCbHY4anZLNjRxb2pYWFpxNVBzdUQzZGdVWWtvcmFjbDVRSTN5?=
 =?utf-8?B?R3VJQWN4LzBnPT0=?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB6PR05MB4551.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR05MB7048
X-CodeTwo-MessageID: 8f1004b9-d650-47ee-9a93-f5e3ec412311.20250919081531@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c928d071-fda7-471d-f575-08ddf754b1da
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|14060799003|376014|35042699022|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3RHTi95aFF1aHNPMlJ5bEZiay9uaElVWWp3eGFKVW9ZdXJVWiswOXk4blMx?=
 =?utf-8?B?ZFZ2SUg1L1BRaitQYTFTM0dwSWFmckJlUkIwZW8rRGRQRFZDc3hVMzVHa0xv?=
 =?utf-8?B?SWZ2RE5LeERHT1ExWjUyWHgzamtEdGVGM0R1b1h3cVBwODRHSUJRbGVBV1ZX?=
 =?utf-8?B?dThlNU9vOXFxdlhaa1c3NUthTWUrcG1JTTNsaGRMRkM1TWJWZ0JZOXdTMjFw?=
 =?utf-8?B?eGlZM3Z4OHh5ejF0ajRRSHJWa1VtZDVNWHJMWjhCajQySjRQcDNhdWwwS1VF?=
 =?utf-8?B?eTR4M0dyektkUEd3U2tHTVlISFZuSWpYYU1EM2VtQVVFbXRCdnd1UjhKUmRz?=
 =?utf-8?B?dW1wVWpKTkNGZXJHSVRTUUxCa1lBN2VEcGQzVU9pZG4vNXl3aHh1SUN4MlZp?=
 =?utf-8?B?N0tsTTlBdWRVVmtCdmw2ZEJDVXRqVVl0NkxuSGNacnVDZXJyRU93ZEE1ZDI3?=
 =?utf-8?B?Zko1Qks1OFkzTUo2cTVQREFFWEFEeE4vTjYzRXc0ZnZQR09EakVmRDVvUUZV?=
 =?utf-8?B?aDc5cER1Y1lqYnI5SVFUQWdqcVFjZ0V5RHJ2SXh5QXJOVGFOampXcFFMald0?=
 =?utf-8?B?SHNrZTYrZDZNOFNTRFcralExUFBWN2FTVm1HZ3ExYjg4YnRka3FTNkxRYXBa?=
 =?utf-8?B?WnROQWxHUmdsZ0FzdG5LdHVnWkVWbFBpNlFuSTNYZ1lGdlFJRzljWFJtb0Yw?=
 =?utf-8?B?RFpLTk5rVWxabGZGUGE0UnBjeDh0QzY3SDk0M0ErT1lvV2NjWFA2ajJjK0N1?=
 =?utf-8?B?M3ZpamJFc1JSdlZSc3p3NGFBUmsyVDBYOUFhdFVZalBNRlJTZXF6R01UQ3I0?=
 =?utf-8?B?SUFuUzJoVXpnNlgxaE1UWmE2enpHdU42VEV4RTRHUkp2TkZMc0hUMHhocUVX?=
 =?utf-8?B?MVcwS0tMRFdJS2dFM1E0dUQ0aW9LZjJyd2tBU3hDbWFKQWpOZ3lRRnFGRzBC?=
 =?utf-8?B?WWVKT0JLZDNGOE9taUMrVGRXMTR0dFpOUHNuK1piSEM4VzMvRWNzN2I3TnhB?=
 =?utf-8?B?NUVJWTB6UTMvSURmSW1iVE1VVEpuL2E5WDdCdThUZGErcHhTV3hIWFJraHlC?=
 =?utf-8?B?eXBCY0o0ZUF4SVh3Mkh5bDRnL1FjeVhaMUJUWlI3Y1dUZXBGTHdxcWE4cHdM?=
 =?utf-8?B?SklrWkpRVG0rTFBLRXFaeHZzaUE1MVBFRGhuUWZtcmU1ZWM2NFRBK2xHektY?=
 =?utf-8?B?QWluWW55MGVqaHcrWEY2K09NTDVFZ052WExUV2ZzUFdkRUFLMkdQQjlkME1k?=
 =?utf-8?B?Sno0aktuUGhzSlhKQitSbm5LMDNJVkcrekhiSmtKTi9Cbm8rOFllTFdXQlI0?=
 =?utf-8?B?cTBFUjg4aktkblhleXM3N0dpYUFsZ0dUUjZqV1I3d2M1NmkwKzdXOENJRml4?=
 =?utf-8?B?ZFpkT3MwWG9FQjc3M2daUEJRNDdhQjlYNE1SUEtGM25TaEhqaGp3MkZPUUpE?=
 =?utf-8?B?M2Q0YWxzeGx4eG1VVHlRcUJiVkNCNjJuay9GWG9ibWRWNlp4eHAzajM0blNO?=
 =?utf-8?B?eHJNY3JwaHdURUg4NjBQRjJMQWZESFhLQkREaDU3ZGZWbWdrK203NWxMR2hB?=
 =?utf-8?B?clJwMUd0T3BJS2xBd25uSHRZbG05cTFUTFIwK2xOTWRvUFgwRi92T1Q5MDhJ?=
 =?utf-8?B?N09JbGtTaFlwV0M0NFBHOFpMYjNWU2VPOUdNYisycDU3RTRML0pLd1JlOXQ2?=
 =?utf-8?B?QmlZNTFOT1JYMjF2Y2l3cVloQURPVnlHRFp2K3U2L3UrVTdiSE13bzBCZ0xt?=
 =?utf-8?B?WGxveXZQa0VwaXJPV0lJMUMrM25Kc3F4QzRXTklBS3BFbjVldDZDd1A0TVMy?=
 =?utf-8?B?d1VDdTkrZ3VjU1RDVXBudmxPQ1htaU0yeTVjN2s5Tk5BNXJJQ2dwdXN1ZEcz?=
 =?utf-8?B?WG9RaVBhTVg3VGNESEVKMGFjUmhsall1NTVTL3VOMW13TTFibjJkcnN5NW5M?=
 =?utf-8?B?SU5yb0lTcTN1NXRZeVAxNEY4OGNXaHUwZFVNZ1h5UFhMUUJHRHhYUXgwMVgv?=
 =?utf-8?B?TVFhZW9DbW9TUW1Lb1VZUXBWcTJBM1l2YzlZN3AzT3lYUEI1WlFqbVZrbllY?=
 =?utf-8?Q?bYwEEF?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(14060799003)(376014)(35042699022)(36860700013)(7053199007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 08:15:31.8658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a2b8f2-6c9d-47b3-86af-08ddf754b3ac
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR05MB11703
X-Mailman-Approved-At: Fri, 19 Sep 2025 16:47:28 +0200
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

PiBGcm9tOiBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPg0KPiBPbiBNb24sIFNlcCAwOCwg
MjAyNSBhdCAwNDowNTowNFBNICswMDAwLCBNYWFydGVuIEJyb2NrIHdyb3RlOg0KPiANCj4gPiBX
aGVuIFBNSUMgZHJpdmVycyBhcmUgZGlzYWJsZWQgdGhlaXIgZnVuY3Rpb25zIHNob3VsZCBub3Qg
YmUgY2FsbGVkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFhcnRlbiBCcm9jayA8bWFhcnRl
bi5icm9ja0BzdHRscy5ubD4NCj4gPiAtLS0NCj4gPg0KPiA+ICBib2FyZC90aS9hbTMzNXgvYm9h
cmQuYyB8IDggKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2JvYXJkL3RpL2FtMzM1eC9ib2Fy
ZC5jIGIvYm9hcmQvdGkvYW0zMzV4L2JvYXJkLmMNCj4gPiBpbmRleCAyYjdhYjY4ZTgzYy4uMjg0
YzMxY2MzMjkgMTAwNjQ0DQo+ID4gLS0tIGEvYm9hcmQvdGkvYW0zMzV4L2JvYXJkLmMNCj4gPiAr
KysgYi9ib2FyZC90aS9hbTMzNXgvYm9hcmQuYw0KPiA+IEBAIC0yODMsNyArMjgzLDcgQEAgY29u
c3Qgc3RydWN0IGRwbGxfcGFyYW1zICpnZXRfZHBsbF9kZHJfcGFyYW1zKHZvaWQpDQo+ID4NCj4g
PiAgc3RhdGljIHU4IGJvbmVfbm90X2Nvbm5lY3RlZF90b19hY19wb3dlcih2b2lkKQ0KPiA+ICB7
DQo+ID4gLQlpZiAoYm9hcmRfaXNfYm9uZSgpKSB7DQo+ID4gKwlpZiAoQ09ORklHX0lTX0VOQUJM
RUQoUE1JQ19UUFM2NTIxNykgJiYgYm9hcmRfaXNfYm9uZSgpKSB7DQo+ID4gIAkJdWNoYXIgcG1p
Y19zdGF0dXNfcmVnOw0KPiA+ICAJCWlmICh0cHM2NTIxN19yZWdfcmVhZChUUFM2NTIxN19TVEFU
VVMsDQo+ID4gIAkJCQkgICAgICAmcG1pY19zdGF0dXNfcmVnKSkNCj4gDQo+IFRoZSBwcm9ibGVt
IGlzIHRoYXQgaGVyZSBhbmQgZWxzZXdoZXJlIHdlIGRvbid0IGhhdmUgU1BMX3h4eCBzeW1ib2xz
IGFuZA0KPiBzbyB3ZSdyZSB0dXJuaW5nIG9mZiB0aGVzZSBjYWxscyBpbiBTUEwgbm93IG9uIHRo
ZSBwbGF0Zm9ybXMgd2hpY2ggd291bGQNCj4gYmUgY2FsbGluZyB0aGVtLg0KDQpUaGF0IHdvdWxk
IGJlIHJlYWxseSBvZGQuIFRoZSBmdW5jdGlvbiB0cHM2NTIxN19yZWdfcmVhZCgpIGlzIG5vdCBk
ZWZpbmVkIHdoZW4gQ09ORklHX1BNSUNfVFBTNjUyMTcgaXMgbm90IGRlZmluZWQuIFNvIGhvdyBj
b3VsZCB0aGVzZSBjYWxscyB3b3JrIHRoZW4/IEZvciBtZSBpdCBsZWFkcyB0byBhIGJ1aWxkIGZh
aWx1cmUuIE9yIGRpZCBJIHVzZSBhbiBpbmNvcnJlY3QgbWFjcm8gd2l0aCBDT05GSUdfSVNfRU5B
QkxFRCB0byBzb2x2ZSB0aGlzPw0KDQpLaW5kIFJlZ2FyZHMsDQpNYWFydGVuIEJyb2NrDQoNCg==
