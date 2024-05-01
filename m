Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4AFC19F53
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 09:28:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F0E18861B;
	Wed,  1 May 2024 11:28:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="AKHc88s3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6BA888AAF; Wed,  1 May 2024 11:28:02 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FC6087FA0
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 11:28:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONL3UiqJ1YjNUzrl9n6j+HTgkO0GWFrTqXNw0jUY+gW+qPg9h4zNdzsng9jOXqybIjllrG3p47j7Rm2GTHcXMF+stsT/YEraHq/j279PZn9XmvMFqY7fW7y2WR/FGNZ+S1nKY7rvxQUyusBGrAnkDg5vIR2dV5C9ejlsffk1Uih+Tzw8q30yNVCAltOhkSxroj68OEO+E3eTIyiCgjUwmYXKT5A2wjUobumSYI8YTzxi3fdE+NMaH8PoJ0GIMhDOgcgI4IJ9Nw9ptEU6Gof5S0LZ5hYWDD0QgBbw91DdO39kcfdQs38Cs/S9aduGA9d9ydIRyGH8exMh6q9ZMdL+Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7q1dCshSd3h84M+iMHlYesuNaT+JLzcfv8c9VOO8sc=;
 b=OYcLU9klykKcN7LTDVUmLXjz64/LFYUaqC+xbKM2TTvtxjzsynbcgQHZbfhzeE4ZC0/7vCfGBzmXkzd2jqnJthZaTo1htIaUSn92++Y5GKIDe9JttRcKGS6tfSGCndaxaJ1bFk70aeCiWiDBclDi3WosA/ZSMgQK0qZ2PR4J0d9/t6bRGl0ciSCkQcTvhpTHjBuyY4iJiaG0yJLV9weEBQ1lSJNU9rG8jtqM27x4R/0ktnQuWROMsQZfwUZkKPkQkB8flDzfKg7jqBH3StKQmHvOmZkx5cSox3UVGJg3Qthwke+Pn2FP6w3S80jzcxg3q7jN3KCl3gdxyKUlszHuNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7q1dCshSd3h84M+iMHlYesuNaT+JLzcfv8c9VOO8sc=;
 b=AKHc88s3q/Cx0PVECmn/LhO7yZSmqrveEFoozfhM5/4QuqkCmiAdRD8lCLmprvOqv3SAtzMdH0Glg/CqGBtiOZ1KlNp1YxJJvtWW/d7h5kdffgndYWO6wiqOMsPm7wxkOGygYHm0m126s3J99txDoAlPre7VhfcSnIsOtfr18oTo1zlxcuE8zZMWgSvz1ImE+UraQNni9Ve+qT7hsgdOX4jKe1mpaF/XsmJLQKkiaUuvkIXCM5Z8JlG9J5iQfXw86VXNLZl6uzIC8SZksGO5HjLyimQsJKj9+W9SoQNYtn4n2Ta6buSRRtzUmw6gtbccl5f5yZ1o1KMtHvtgFhBAaQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS4PR10MB5693.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 09:27:58 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%5]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 09:27:58 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "nm@ti.com" <nm@ti.com>
CC: "rogerq@kernel.org" <rogerq@kernel.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "s-anna@ti.com" <s-anna@ti.com>, "dannenberg@ti.com" <dannenberg@ti.com>,
 "rfried.dev@gmail.com" <rfried.dev@gmail.com>, "s-vadapalli@ti.com"
 <s-vadapalli@ti.com>
Subject: Re: [PATCH v2] net: ti: am65-cpsw-nuss: handle missing PHY in
 am65_cpsw_phy_init() gracefully
Thread-Topic: [PATCH v2] net: ti: am65-cpsw-nuss: handle missing PHY in
 am65_cpsw_phy_init() gracefully
Thread-Index: AQHagNlEU5uGPu+kU061+DtXN0/TP7FNCTiAgAACDYCAAANOgIA1Q28A
Date: Wed, 1 May 2024 09:27:58 +0000
Message-ID: <1f2ddd43499da8ab926fb554ccbb402cf1ad007c.camel@siemens.com>
References: <20240328062914.486999-1-alexander.sverdlin@siemens.com>
 <20240328114541.pep2fszctvzc3qqt@slept>
 <b7627659d44bad98fce87d4526bb8fb105a9233c.camel@siemens.com>
 <20240328120451.tkj2e3nk35wbfsjz@isotope>
In-Reply-To: <20240328120451.tkj2e3nk35wbfsjz@isotope>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS4PR10MB5693:EE_
x-ms-office365-filtering-correlation-id: 6b6ee7dc-d466-44b8-a55a-08dc69c0fd91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VEt3aVhBSHdRdFRaOUpoYkQxYWIvTkQ0TnFiRGhGcHFlZ1Fra3hsVHJPOCtv?=
 =?utf-8?B?MEZyMjA2djVqNjVQMTM5UnhHVE1aMXR6WDhlMlJnV21zTU1nV2Jka1RqRk8w?=
 =?utf-8?B?ZHpkQVJZZWpaUWVhVCtwMXhXQjRHa0tpSU5UUHI3eFNnWVVQVXJqMDM1akhn?=
 =?utf-8?B?N1NDRmpOdGgvbFJFOXFlcGgrTnZyWnIwazIyVmk4V1RkRzcvYkkyV2k0MVJs?=
 =?utf-8?B?d3JwdEE2ZU5wV3ZhbTM4TXZkZnBORWQzT0NIQ3NLdGVLUEN5RjZTS2lQWXNE?=
 =?utf-8?B?K0hmMDFwREZRSnNJdFFCODNYV1R5NXhRZ0JsZzZlNm9LZ0EyYWs3a0pqTFlh?=
 =?utf-8?B?ZStlb1FWcXVVZXhtTHo1ZWY3emxoRWdqb0lUZnBUalgwRnNqZ0RRMDlyMTFh?=
 =?utf-8?B?ei85Uk9OTTNSbkpmQVNPU0RBQkFPdkhLd2tvQTdxVnN0MCtCeGk3OTVIbWZ1?=
 =?utf-8?B?ZTJKZU5nSFNycUlWNVd6NTZjdUNrYUljWlMxUnRwQVFoazNNN1BUR0ZGYzNO?=
 =?utf-8?B?ZmxqK05ZV3JZRXFvelF0em8zdHJKeHRkRWU0eFJtV3RVclMxbEcxTWVqdlRJ?=
 =?utf-8?B?aE93V2ZjbkpZcDBoOXhYckhnWHFlWjBHSEJOTlgwOStralh0U3lta3loRGhs?=
 =?utf-8?B?VGJqcG1zbjdqbTZUcFU2ZGJXc2xyN3c5a1hFaEx5eFcvbVNkSmxyTnlLMEZ0?=
 =?utf-8?B?cWRFNUVISVVqQmJJUjJ5SExWZjBCZXM3USs1S3k4UU9RVzlRc0RScWZ5SnFy?=
 =?utf-8?B?NktxNDlsZStuWFArQ0haeVdlWUlRSkJvQjFVbEdkbXM0ZkFkNkFNTFltUVQ5?=
 =?utf-8?B?eFZCNTYycUNwVXg2RldZeEFzSmdDVFdOVU9SODRFb09weVBPZ0d0cGd6Ym9H?=
 =?utf-8?B?VDNXdFNBVGt5c0ErYXdvaHVwMUk2UXBzVFV4dWUzWEg2Nk9wWFo1T1Zndlo1?=
 =?utf-8?B?RUMvUE1GeUljWE9WTWFYZjhyMzc4WVY5MGh0c1VyakxNWjlPZUc5eUh6QjRR?=
 =?utf-8?B?ZC9KQnV2TUxxYlpJclZ5M1N5VER5MVp4YktON1FralZ5ZThWbktRTTFsdHd1?=
 =?utf-8?B?RzhZaitRMEE0T1VKMnNESThRZ3hMZFRPdm1TTWVtTUdJaTFSaGJ4bm5UVzFk?=
 =?utf-8?B?MFVrb2JKMzNEbmlLMVU2R25oeGJwRXN2MHBMYXZ1K2QvUEozVWhDNEVERVZz?=
 =?utf-8?B?Y242ZXREL2FIM3N5dHVPMDFFL1ZHSGdHYVI5T0RtNEhVV29TNmtkTlRCWitm?=
 =?utf-8?B?ZStNR3VucnhwbDNDMWhzQkU2WThVdHZYajcxNDRPU3E1Nk9QS2hZTDdVZHlR?=
 =?utf-8?B?QTdFWTM0TC9Va3NySElKcXdYVWZmWCtlS3czT2RyVEVzYXl0K2pKZW1RbHlm?=
 =?utf-8?B?Tk9GZldobGxheVN2eFY3UzJYeGgxczhhL0xaQ000VXdMbFA0YThKRDM1Ui9q?=
 =?utf-8?B?aGpFa0VMdzE4OXcxREtDeHVNTmk0NDJjNlVaOGhtUnRGWWN1azRrQk9COU9x?=
 =?utf-8?B?Y1g4dTVNU1o0dEhxRHk3NjhLLzRRSXhwMnBoOHU2THZFM3ppVXJiSW1qaDND?=
 =?utf-8?B?MVBuSXJaVU1qSUtzMVZWOG0wSHdvWnUzQUptYk5BRzl2anBGVUgxNlVxK1p0?=
 =?utf-8?B?RDlVMXhhalVJVk9FMTYwTUZsUmw3YlFUSUlJVU1mc0hwTGFOMVFsendWOURL?=
 =?utf-8?B?RWttdi9LMlhzSEM2TGd4VVB0S090Mmh2SjVaNVFsUFBLeE9JZS92STlRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkN0TTlTSXE1Z0t5NzZYc20zSmZVeTNJREd5L2JtOFQ2TlhSN3BoMUFIMVpT?=
 =?utf-8?B?OHVzbzR2OWk5Zm9IZEN2d2Z3SWJCTGlUVnNJMWdjcXJGM1pheFBSNjl2OHJ6?=
 =?utf-8?B?RXNPblJpdENhTk9rVzRxTTgzOXdVMzlFYXByanhKVlNtTG5BQytzT1Y0Y0JJ?=
 =?utf-8?B?a3Y0NnFTM0RxUjh4RGZoT01UOGNkaU52c2FTVURaNW5NREJXNzA5Ym9DYkpS?=
 =?utf-8?B?SFNLRGUvVi8yNmUwWGtSWWkwYjNraERYUzRSVTB1a0xkL1p2eHZVRnRkYWxC?=
 =?utf-8?B?SnBOSGF5QWNjU1NURzJGOE9HZmhkY1VmRFB3aERqVWlkTEJvTktiUUJjWFlC?=
 =?utf-8?B?ZHVmWXFudFFCUEhSQ1FzNTJ5aVFDclgrcUN4dmZIUzhEc2VDaEJFZnNWZHdu?=
 =?utf-8?B?ZSt4ekIwRFJQVzhpTTVzTDR6T3JUN05HNW9WalNVSWk4bFkrRnJBR3ZobHhD?=
 =?utf-8?B?Nm1QcEsvY3dxbmxFMWNnazhVUWt4TTVESmsxOVZxT3owWDIrZFNBaWxlYUY3?=
 =?utf-8?B?TDd1cm10bVBFaW1yNTJyV0dEcFRiRFJNM094cDhkWWxScDErTlEzVDNMY0Jt?=
 =?utf-8?B?bEJPRXpMdUIwMzhRa3o5VERWWHk5L3M2ZkRKMzhuSkJJeEh6eDJ4cklJL2tX?=
 =?utf-8?B?RkRDNno0TnF6aTdWc3ZFSkFueCtwSkdSc0llV2ZLYWNmeDNiUEtqdE8vbVpK?=
 =?utf-8?B?S3hPaGUxTEpKN2I2czk3Vk5aQ3lhdm80OW94bysxWU9FQ1ZtVVc4WVFSTDJp?=
 =?utf-8?B?VHc3R09hUFNlcXNKSUYzVWIzem50d3Y2enh2WjRoalpCdldUaDBDUW9KWGN6?=
 =?utf-8?B?SnVobVdJSllIblJob3JjN2FReEhQQksyd1hSVi96N0xhNnNzbWxZN2piWHVL?=
 =?utf-8?B?TGVnSkxJTk13b2tUZDByS2F1TGIwY0RkSW1JNnVzc1JmOWlTSmVHdWZNc3JE?=
 =?utf-8?B?NnFwdk5OazgzUVQ0QTNMMTh1VXRwaGR1NkdZU2tjaFA3a2YybjVWR284TlJT?=
 =?utf-8?B?azVtckNNeEV4VmxpQmlKcW9yZll3c3dZNTFEeTVtVzVNVWEzcnRIb0d6cVRl?=
 =?utf-8?B?Vk5mK2h1ZnpjYlplK3NodXdBZXB3Tm4rd1FMNUZzVHIyNitwSktZUStyNGYx?=
 =?utf-8?B?YXZicitZSUdRNExkOVdkdlQ4VE50em9Gdit1Y09XWVdFR25Gc1FPaWd1V3hW?=
 =?utf-8?B?dGtVaDdsNC9GcUNWWTJFZXNuUkpyYXhkYWYyL3A5MC9mUkM2a25hajBhMWVY?=
 =?utf-8?B?TEduMEJ2WHpCT2ZmU3VJV3lyMXhSUFpnZTZua1daZnYvK3Z0SmZxcEFiYTVD?=
 =?utf-8?B?RjZMRW1ZaHF1K3lmSXVNazJGN29DZjlsRHJObkxqMm1RdU1JZ0VJRTZLOVhL?=
 =?utf-8?B?YUtOTDBsRCs2ajNFOXF3TXZjQnFZRTFtMzZTQXRHS2VkMDl0eGtzWkV0STVT?=
 =?utf-8?B?Q3lST3pZaGRvY0NpQmRyQkIxcS9rOUZuUDUwUEdaVkNiWklxdkpyZDYxU25j?=
 =?utf-8?B?SjZscHJBZmJ2Nm56L1lZdzJlTWk5WnRFZjBBQWhJYTRGRG95bVBRZzFmNFRI?=
 =?utf-8?B?aTR0a0dNTGhqMUpnVWJIY29nOEpmb3NYY2wyTmw3RFNuOHFXNnRDY1MxMjdz?=
 =?utf-8?B?Y09HRDQ3SkU0MHRKRE9tUlg4S1V0aEpHcGJQNWNUdHBXRTIva0FMdWhyT0tB?=
 =?utf-8?B?UXBqR1JSTStLN1J5d1ZkanVaUVlVK29McjBhYWhENEk1UDliWjBqbGxVbHRs?=
 =?utf-8?B?cDFjZEswTDF1KzF4ak8xaDZJYnBiWXFTbm1rck1rQi91R1hXSUVabmtTSVBs?=
 =?utf-8?B?TityVy8zZjFJTVh6TmlpVFB6aVlmRHZENTh5c0ltQWxJVjc5Rzd0OUF1VHps?=
 =?utf-8?B?UkpaZU00TTNnYUxIZFd5YjlEK0RzQ0x0QVZBMktYblRhQUU1VmEvN0t4dzNO?=
 =?utf-8?B?TTZoR3lOVU93Z0IxK3RzK3I3NzBmQVltOWJ4YXBOVUZlc1dCUmg5VC90VGp4?=
 =?utf-8?B?MlJqRE9NWVVwaVhtQlUzdml3YTl2VnFqS0Jod0tUUzduYlo3VkxlYmtTN3Fr?=
 =?utf-8?B?WVJ6OVpjeHBYQnlIM0ZrSHkxYjJ5QmxsbHF5eDZoZm9MdERtRVFXS0ZvNGZk?=
 =?utf-8?B?K1FWS1J3L21kc243UGpCUU85bktvM1F6aDZWaU92VnJ6Ymo2VXg1UnRCRkpW?=
 =?utf-8?B?Q1VHMytzYlphS1JWRmUyc2w3ZzFEZEl6a3c0MFhVYlM1R0RqczI4ZDU0QldN?=
 =?utf-8?Q?Y1LFcZzTwVUp97dagTpJWBHFgJKsIA0eKUt7h0jgW4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41443DAC139FC643A00A32E50758AA4D@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6ee7dc-d466-44b8-a55a-08dc69c0fd91
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2024 09:27:58.8342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sD+vQ41VU3iGFVxJjsw40Yb2sRiCR6E2CcGFeLfTSO0/SZhczpc36PGzeOdNU8dsI1Y5B6ZX4S+AhkC7oFq22GGguWfIjGJM3WTjlVxVgk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5693
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

SGVsbG8gTmlzaGFudGghDQoNCk9uIFRodSwgMjAyNC0wMy0yOCBhdCAwNzowNCAtMDUwMCwgTmlz
aGFudGggTWVub24gd3JvdGU6DQo+IE9uIDExOjUzLTIwMjQwMzI4LCBTdmVyZGxpbiwgQWxleGFu
ZGVyIHdyb3RlOg0KPiBbLi5dDQo+ID4gPiBCdHcsIHRoaXMgbm8gbG9uZ2VyIGFwcGxpZXMgb24g
bmV4dC4gb25seSBhcHBsaWVzIG9uIG1hc3Rlci4gRGVwZW5kaW5nDQo+ID4gPiBvbiB3aGVyZSBU
b20gd291bGQgbGlrZSB0byBhcHBseSB0aGlzIGNoYW5nZSwgbWlnaHQgbmVlZCBhIHJlYmFzZS4N
Cj4gPiANCj4gPiBUaGFua3MgZm9yIHRoZSBoaW50ISBJJ3ZlIHRvdGFsbHkgbWlzc2VkIHRoaXMh
DQo+ID4gQW5kIEknbSBldmVuIG5vdCBzdXJlIHRoZSBwYXRjaCBtYWtlcyBzZW5zZSBvbiAibmV4
dCIuDQo+ID4gSSdkIG5lZWQgdG8gcmV0ZXN0IGlmIHRoZSBwcm9ibGVtIGlzIHN0aWxsIHRoZXJl
IChhbmQgaWYgdGhlcmUgd291bGQgYmUgb25lLA0KPiA+IHRoZW4gaXQncyByYXRoZXIgc3Vic3lz
dGVtIHByb2JsZW0sIG5vdCBhbTY1LWNwc3cgYW55IG1vcmUuDQo+ID4gDQo+ID4gU28gdGhlIHBh
dGNoIG9ubHkgbWFrZXMgc2Vuc2UgZm9yIHN0YWJsZSBicmFuY2hlcywgaWYgYW55Lg0KPiANCj4g
T24gbmV4dCwgSSB0aGluayBhIHZhcmlhbnQgb2YgdGhlIHBhdGNoIHdpbGwgYmUgbmVlZGVkIGFz
IHdlbGwuIEkgc2VlDQo+IHRoZSBzYW1lIGJ1ZyBvbiBsYXRlc3QgbmV4dCBhcyB3ZWxsIChhYjhk
OWNhMzA0NGEgTWVyZ2UgdGFnDQo+ICd2MjAyNC4wNC1yYzUnIGludG8gbmV4dCkNCj4gDQo+IGh0
dHBzOi8vZ2lzdC5naXRodWIuY29tL25tZW5vbi82OTFjY2QyMTBlZDdlMWFkZDRjODY1Y2E5YTY5
OGYyZQ0KDQpXaGlsZSAyMDI0LjA0LXJjNSAobmV4dCkgYWJvcnRzOg0KDQpOZXQ6ICAgYW02NV9j
cHN3X251c3NfcG9ydCBldGhlcm5ldEA4MDAwMDAwcG9ydEAxOiBwaHlfY29ubmVjdCgpIGZhaWxl
ZA0KYW02NV9jcHN3X251c3NfcG9ydCBldGhlcm5ldEA4MDAwMDAwZXRoZXJuZXRAODAwMDAwMHBv
cnRAMTogcGh5X2Nvbm5lY3QoKSBmYWlsZWQNCiJTeW5jaHJvbm91cyBBYm9ydCIgaGFuZGxlciwg
ZXNyIDB4ODYwMDAwMDQsIGZhciAweDMwMzAzMDMwMzAzMDM4NDANCi4uLg0KQ29kZTogIlN5bmNo
cm9ub3VzIEFib3J0IiBoYW5kbGVyLCBlc3IgMHg5NjAwMDAwNCwgZmFyIDB4MzAzMDMwMzAzMDMw
MzgzMA0KZWxyOiAwMDAwMDAwMDgwODAyMWQ4IGxyIDogMDAwMDAwMDA4MDgwMjFiOCAocmVsb2Mp
DQoNCjIwMjQuMDctcmMxIChtYXN0ZXIpIGhhbmRsZXMgaXQgZ3JhY2VmdWxseToNCg0KTmV0OiAg
IGFtNjVfY3Bzd19udXNzX3BvcnQgZXRoZXJuZXRAODAwMDAwMHBvcnRAMTogcGh5X2Nvbm5lY3Qo
KSBmYWlsZWQNCmFtNjVfY3Bzd19udXNzX3BvcnQgZXRoZXJuZXRAODAwMDAwMGV0aGVybmV0QDgw
MDAwMDogcGh5X2Nvbm5lY3QoKSBmYWlsZWQNCk5vIGV0aGVybmV0IGZvdW5kLg0KDQpTZWVtcyB0
aGF0IHRoZSB0b3BpYyBjYW4gYmUgY2xvc2VkIGF0IGxlYXN0IGZvciBub3cuDQpUaGFua3MgZm9y
IGxvb2tpbmcgaW50byB0aGF0IQ0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBB
Rw0Kd3d3LnNpZW1lbnMuY29tDQo=
