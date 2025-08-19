Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004DDCA0EED
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 09:52:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 559AF82F30;
	Tue, 19 Aug 2025 11:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="fYlrkNzF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A26E0802C1; Tue, 19 Aug 2025 09:59:29 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1FA881FEE
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 09:59:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKvzyS80wrHnCM+pntDcj2ZtQVq8HPMQDXcVKcjDkm1KB5YmmxDucxIKhMw0bKa8zLqLdYYL6xSqBrNGfI9ZMsjKM4rv36zMn8re/MvhwRDHzpo3e5E9IgrO7iQZYISBunckUkQIRdRk1QdIVL/nNAlQAgo8rV7srxEa1ZA1CMjXa0J2MTdoZVVp/t/Vx13hq513+Dynd3jeohNfEewqeFqW2nT+YkVKlbM9wkCxyFYFvs5uKrDUv6JoCB3vVRECRlbmMI+onU5AKn9/O16qe0gcWsOFdsacb1gI3wfuujYwWPQwN4NlvMvLimxjdQseVYlc2zftVcboykx2HX0boA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z93sJGCD0j5gKs6PaAhV784ygxDyWdc0OC5DxyM4w7o=;
 b=ReNn7oRI+n/5nRO6APaNTWATfuKXF3kEaBVevZeGJ5JCjjdYMC/A8YpRevXE2IsWkgzFUbvuUsEGdi9iEGLfbdHWKLUh7T1p8ZgTK+JhGP3zFvb7zV36b7grXg+zRbOQtuAedPlVGo80nxFzpHfuongVNBlEe96GM0jPKoY6sTXQK3y68ftu5/ViDXwrz4utrrPwbvOvGP/nK6lwI4BE7oaLZWTI4nmPi+evsKQRmGO6Y1cioWv17ZyVMQRyqqywhRs9vADBFYzM2YQ7rOR38FMqIIO+laxrgIoNvY2fLBAi12MAk0Ucba10d5qveiOuNNgcg7YYIv5jITTB1RgbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z93sJGCD0j5gKs6PaAhV784ygxDyWdc0OC5DxyM4w7o=;
 b=fYlrkNzF9NIRu0x6a0XQ3K4ETl8nAuTgLwvoR9FfTC7xfMSPoG2tq7hVocHLINUoSetq/8e5IOoisxHG93HomMDmjPy1mY+EdsJ3vBTtDzLmv91z01jg/0WYwhM6mbWZ1xuJ0QAv/7rjp62WpP6HzOJhW4hozzodiMc4TBKeHG9JfqIZEuAilPsibseHBlFEM4lxTFroJNIIcc63971vvrSH5vYh+8GD5p6+aOLxrWlrC9P4tup2te51UlQUojq4wUPS1hPLPQ68MCArENTVSqsNP4so494IawS1dFjwsqFJyC3D6HTrMQVHYNr2lh5yJoMKR005JO6RzJycE0FMeQ==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by PA4PR09MB4542.eurprd09.prod.outlook.com (2603:10a6:102:e7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 07:59:25 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%6]) with mapi id 15.20.9031.019; Tue, 19 Aug 2025
 07:59:25 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: Yao Zi <ziyao@disroot.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 12/12] timer: p8700: Add support for reading time from
 memory-mapped mtime
Thread-Topic: [PATCH v3 12/12] timer: p8700: Add support for reading time from
 memory-mapped mtime
Thread-Index: AQHcAKVcpmvHGbIIWEa8cpsUoyOLerRLvqIAgB3+bgA=
Date: Tue, 19 Aug 2025 07:59:25 +0000
Message-ID: <31c5ceb4-9c60-4f3a-9c7c-0d0b92b9933d@htecgroup.com>
References: <20250729162035.209849-1-uros.stajic@htecgroup.com>
 <20250729162035.209849-13-uros.stajic@htecgroup.com> <aIsFunyE5mGhGhbV@pie>
In-Reply-To: <aIsFunyE5mGhGhbV@pie>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|PA4PR09MB4542:EE_
x-ms-office365-filtering-correlation-id: 2cdac3e9-0320-425d-ffca-08dddef65088
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eThCdGh6MVRwRkM5Y1UzaE5YSmdjTlNydlRYQngyd202ODBOczRWL2duKytT?=
 =?utf-8?B?c01kcVo4VG8yenNlRkF0cXMvKzdSWVZEbmpXcTJCV1pnMXNFZW1ITDdWRG9E?=
 =?utf-8?B?VTJzTnRscGdscWVZbmN3SGZXaEtGTXNYaWVtYVhTaWpVc2RncUtjNWQ5L2E0?=
 =?utf-8?B?SmZiZUxyU3cvQWpjMDQ3Kzh6UWtTTnd0bHdLamNqcTlRNVdkY0ZWSkNhYkJX?=
 =?utf-8?B?dExIVkc3eWRyN1cwbnNBNWFHTXFHNmJSZncwWHlKbG1tbEt5eDVDL0dDMUZF?=
 =?utf-8?B?UkUxZlQ5WHArMHZFL2VYemp2NDNva3JEWnVRMHZhSHhLTUJLeWJvTnk3Z0ZS?=
 =?utf-8?B?VnczYS9kdEJJNFlaYTdwS3JQREVBcWtab2Z0aWsraWdBM2R3QWJsQUlocUFi?=
 =?utf-8?B?T1RlRVhQaFkvdzkxNnEzN1RpT0dqckkwOU5YUWZ3dnI4R1poRVN4RGV2Mll0?=
 =?utf-8?B?YmpMK2hvQ1Z4cTBYRDRxZlhKdzM3Ri9uOUtST29GTUhHNHZ1TVMwVnlmNDdH?=
 =?utf-8?B?NUs5YlphazNZM2I4S1lFRklQdEZjb09XMUVtZlBCNGlnc3hoYUdzNm13Qkk3?=
 =?utf-8?B?S3VHVVpHT20rL0dDeXNvSzh0TjhYRzhuQVRjZmFpQ0tvVVRDcVVBUjFZb2dZ?=
 =?utf-8?B?OVJ4a1pXb01NY2daSjFldUJMOUpIV3VENTc2Y3NJN1pyY1ZHb3Q0NEZjdThX?=
 =?utf-8?B?WWs4bENvMEVhTVlNRkxabW92b1AwS3oyaHpDWGtnNHRuQWlIU1doWTRCNkFq?=
 =?utf-8?B?UGpIYnREWnNRQXJPS1ZnVkU0b252Qy9DMEt2a3Brdmdva2NmTFlhN0RHZ0pz?=
 =?utf-8?B?VEJKREUzQngvRXFmcVJsUHNwRklPWkIxSnFXY3pKTXE2UXNTWkZPa0o1a1Jp?=
 =?utf-8?B?QXZTRVJxa2dUZEhSMGpXWnA2S0JrRmZmTytPbkF4QXZHaWp2ZzVZUmEwL2lZ?=
 =?utf-8?B?aEJ5cmJQaXRoMTJEK3ovNkYxVm1BbUNXRnp2dE5ab0pjd25wSFpVRmJvblJK?=
 =?utf-8?B?TnhvdzZPL3RTSExHeUloNzdVTlo2N0tTeUxGelo4N2k1Ukh2UG1ySXhnclFp?=
 =?utf-8?B?eVVYYW5EYnJocXd2OFk4TjFHa28yLzErektsV3FJaEhHREx1U2t4di9QZVZk?=
 =?utf-8?B?NjhKNHhGQWVZU0RPQ3ByZEh2VzJxR1lZMjFucFMxMm9XNlFIa2xBS2k4Z3hi?=
 =?utf-8?B?MVVhN2c2MkZlekxsdzU0ZmgvQXVkQjBidjQzV1dYeUhhMFIwM2I3ZUhXaHlz?=
 =?utf-8?B?TCs4dmVDNnVoOEZIMDNuOWRpTWZPSlF4d0IrV29aVDgzZmMxbWIvVzJFY1k1?=
 =?utf-8?B?NkVGNFdZMnRSL0MrU05HQVQwb09SUmRkS25aSFlhQ1R5Nm12Z25VUDQ2K1Nh?=
 =?utf-8?B?Wk1aaW1vdXdTakxxYmpFODl3TThGaGRFNUNUQ0NzWmRHK3VRSEJQamlYZnZP?=
 =?utf-8?B?ZzFWczc2VUYycWxFbFlpNXZGcGZjVlJySC9pUHd6VnVUaEZZSm9uand5T2xS?=
 =?utf-8?B?V1Z0bEZjQldEKy9RZXp5VVVGRXRoTElVYXdWVDBxSTVGZktKWUEwd25iZGtX?=
 =?utf-8?B?cjBBeDgydzZMZm40NytIR1hyNUpKYjFkQXhFVTgyVjJ5MFlUYnI1MnBQVjR1?=
 =?utf-8?B?RVUxUnF3QkFkU3R4Mk93alZNNGVob09XdWhmT3JidzJtRUFkOCtNVnFpSkZQ?=
 =?utf-8?B?c0luWm1HS2xUazRjeUZQLzllVWErcm5TVHpuWVdQcUEzWXQxcmNFRHZxTXY2?=
 =?utf-8?B?OGtIR1F6czRUaGsyRnVHVlNNY0NEdGFONVFkSUxJUHlHSEdXZ1FhSmE2RjdR?=
 =?utf-8?B?WEpYRXFKSjA4M01YQk5nekFIODh1T1gyeDg5c1BLaTdCMUxTU0ppVzdQeXpY?=
 =?utf-8?B?K090ZHdpaEdLMlhIRytpLzhGanNMSzRCUWJUSFRyU1RWa25ZaEYwTGZDRWJa?=
 =?utf-8?B?SGdCREpYZjY2eDBybmlLbWM1VGp0RTdzOGwvNUlVZzBtYWxwb2ROWEhJUnlN?=
 =?utf-8?B?a3ZhSURZcm5nPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGhiY0VUZko4N3J4NW8rd0F0R0VzUVQ4UGw3ZnF6Z1RuaFNjLy96dWExVC9L?=
 =?utf-8?B?K2cvQlVibGtDcDNSZkJyM0JUaWdselRhS3BZWnZsNmZCRy90T2xGUm5LaUdR?=
 =?utf-8?B?L0RZZDJaV1p4akltdDVBN3FvdGwxMUIrSEJvZGZqNWErbUNQL2krN2phUTJL?=
 =?utf-8?B?cUh3alNuRGVodk1mdXVvVFkzdkJtL0VsMkEwYXdscG9PZUpRVFF1cm5LYWhE?=
 =?utf-8?B?aE8zemh6aEgydk1hVWZqQ05jZzRFN054TEdHRGtCUGJmRDdBdzFmZCtOT0dk?=
 =?utf-8?B?V3Y5VlhQTm5Wc1FlemlvR09IUHY4blVndXlOelFmS1Uya0VmK3ZWMUpJSkZK?=
 =?utf-8?B?UWM2N0s1WVRQVHRnOEh0UVVGeFpYaGpXZG5OSGM4YmVmYktvU1BiUTRsTU9I?=
 =?utf-8?B?UVhUWUdXd1lJb2ptNlJPR3MyOGtUT1FIUVB0ZnVacEdvYXFxemo1dkdYODF4?=
 =?utf-8?B?dzdQUTF3RTlvbmRESlc3NTgzODJDNms3OXF6OE5ramdNYWhuRWlSKytTRHlp?=
 =?utf-8?B?eDROa2xoZ0pabGZ4NVlKTkRmVlBqYlUrcDVJTnZRd01kR2FTZFAyak1aWHY3?=
 =?utf-8?B?aThUSzhWT2R4ZFBxSS9KdzBpT2FjbW9OVkN2ZTFnL1NDbzExT1hhdXA0cEJE?=
 =?utf-8?B?T2N6eWxEV3VwUzZwSExWS2pnOUxoRzY5ZjZ0S3lZOXpZdGdzbC9qb3plWWQ2?=
 =?utf-8?B?dlNTWkZhMU9jT1loelFFOEloSnB2TVZBbXJONE9pYWhHOWNQRGZ2dlhRZUtN?=
 =?utf-8?B?UVhxOUVFejNHQStkZnhnTmtoUWo1YUdXTkxnOGY3a0ZEa2RYMEpjK1RjTnJ1?=
 =?utf-8?B?alc2NkkvZEVwOEVBd3c4dzRvdXMrYlE1bWZCZ0MrbzlWSVJEb0oxc20zUXZN?=
 =?utf-8?B?ZldWSEE1MmpOdFpDY2ZYN0w5OG5lVkFRZWV5emZITDZjQjVYS0w5NmNOSjNj?=
 =?utf-8?B?N09MdWVTNGc1eXNlUjZDUm1URmkwVk1pZ3pHVnhiM29DWXl2SmtWUERIdjl5?=
 =?utf-8?B?VVp6ald2bzQ4bGdhZ282ZDkvT21ZNHhWN3p1ZnZDb3ZHL042czFGa2N0R2cy?=
 =?utf-8?B?aGdmMDlUWHVOMFI5aFRqd3ZEZWxrQjczSU5YNnh1ZkRRRXFhc2RlQ1FubWFi?=
 =?utf-8?B?L3dGOFo3ckhwMy94aDB4ci9lMTZCRU1IZ2p6R0k4eXhIZ3JweGZRcVFBKzAz?=
 =?utf-8?B?RmpNNlZJQmV5aDY4VUNwMVdUV2V2c2VweFZSU25JdUlQV2hjemRCdmFVR25S?=
 =?utf-8?B?REdkWmhCOGdJYzFRdi9YTWlodkhlUUR6Tit3bjIvSkRkdlpyRzlxbi9uV3l2?=
 =?utf-8?B?bEpUNE1WMmpSWFRvRVNFWWVVUVBEYUJKelBhVlZ1NC8rdmdBL0xSdnJ0MWIz?=
 =?utf-8?B?Q1cwSko5WkhJOHF0aVVHRkgxQnN5RE56bjZmalpiNzRwQVJnbjZycWxUUnVB?=
 =?utf-8?B?VVlSTnlobWpjNnFUbXZVdFJFeGQ0WVEvZW04OXVid3VzUW02TDluN1czSm15?=
 =?utf-8?B?NXZuaWI3OUZaaTB5SEw4SWE5Qy9adDRCQWFFT1Y3SnhJUEg1dVRoZGdOSk55?=
 =?utf-8?B?MnF0dnM4cHlRSlZ0ZUYwdVdVemJnN3NGNzhjeEhDVU54c25jcVhBdEZicG5K?=
 =?utf-8?B?N3dJdm5nTTUxQm56NVlKVy9VQytrOTBBVFhFa05RV2trK3JtYjZNS3VEbzJh?=
 =?utf-8?B?SmxKb1pDeGtNbzhQaEVUbmdDQ0tQUVVnQlgxM1FLRXB2NWlUdTVqbDRYSTFG?=
 =?utf-8?B?TTJiSVlLK0JwdHdVUEVleitnZTZpQ2NCWndxT1pOem1EL3dVbDNvSkJnOVhr?=
 =?utf-8?B?Y3FXS0ZiY2pPUXd3MHk5SWcxS2h3dWlEVThOTUVZK0w5UTJZU25JZEkrUEtN?=
 =?utf-8?B?MlRXb1MyV1JiNXh0c3JrM3hra1BhblNSUEFKNnk2MWErUm1mdmREaVZQNTJN?=
 =?utf-8?B?WDFYaC9pY25vcWFQTUxrNHFVdkpDcTJ3VzBNVCtWVDlEaXhlUGVzb0dKZHVx?=
 =?utf-8?B?bEZKWTZrd20reC9GUWZEVGxnVG5SNXp6L2pJRWpTL0IrcDdpandmTXg1VFpM?=
 =?utf-8?B?b29VTzYxUEpRa3JFUVdqdDBLVGpxOXUzY1VuaDVlRWZFb2lhN1dvTFhWbXpj?=
 =?utf-8?B?aXhRMmdOS0pBaTRmTTBGQnVUVjhZSW1oMDdzTmpMaGVtTFNNSmUvUjVkMHF4?=
 =?utf-8?B?R2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B6EB57C35C71941B8A79A12907E28BD@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdac3e9-0320-425d-ffca-08dddef65088
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 07:59:25.0532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8CMxSo4WYMN3pbCMN0jl3/CkeXz1maCSvrzu3ro9Ekip6gQWFLcWcyEo13jEKAXA7YCc9mHxDfOq+Q+w9AtWBLzSK7C3zD9FuveCP80jwNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR09MB4542
X-Mailman-Approved-At: Tue, 19 Aug 2025 11:52:11 +0200
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

DQoNCk9uIDMxLiA3LiAyNS4gMDc6NTcsIFlhbyBaaSB3cm90ZToNCj4gQ0FVVElPTjogVGhpcyBl
bWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3Qg
Y2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUg
c2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gT24gVHVlLCBK
dWwgMjksIDIwMjUgYXQgMDQ6MjU6MTRQTSArMDAwMCwgVXJvcyBTdGFqaWMgd3JvdGU6DQo+PiBU
aGUgUDg3MDAgY29yZSBkb2VzIG5vdCBzdXBwb3J0IHJlYWRpbmcgdGhlIHRpbWUgQ1NSIGRpcmVj
dGx5IGFuZA0KPj4gcmFpc2VzIGFuIGlsbGVnYWwgaW5zdHJ1Y3Rpb24gZXhjZXB0aW9uLiBUaGlz
IHBhdGNoIGFkZHMgc3VwcG9ydCBmb3INCj4+IHJlYWRpbmcgdGhlIHRpbWVyIHZhbHVlIHZpYSBp
dHMgbWVtb3J5LW1hcHBlZCBhZGRyZXNzIGF0IDB4MTYxMDgwNTANCj4+IHdoZW4gcnVubmluZyBv
biBhIFA4NzAwIHByb2Nlc3Nvci4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBVcm9zIFN0YWppYyA8
dXJvcy5zdGFqaWNAaHRlY2dyb3VwLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL3RpbWVyL3Jp
c2N2X3RpbWVyLmMgfCA3ICsrKysrKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKQ0KPiANCj4gU29ycnkgdGhhdCBJIGRpZG4ndCByZXZpZXcgdjIgZnVydGhlciwgYnV0DQo+
IA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGltZXIvcmlzY3ZfdGltZXIuYyBiL2RyaXZlcnMv
dGltZXIvcmlzY3ZfdGltZXIuYw0KPj4gaW5kZXggMWY0OTgwY2ViMzguLjUxMzgyMzZhMDI4IDEw
MDY0NA0KPj4gLS0tIGEvZHJpdmVycy90aW1lci9yaXNjdl90aW1lci5jDQo+PiArKysgYi9kcml2
ZXJzL3RpbWVyL3Jpc2N2X3RpbWVyLmMNCj4+IEBAIC0xOCw4ICsxOCwxNSBAQA0KPj4gICAjaW5j
bHVkZSA8dGltZXIuaD4NCj4+ICAgI2luY2x1ZGUgPGFzbS9jc3IuaD4NCj4+DQo+PiArI2RlZmlu
ZSBQODcwMF9USU1FUl9BRERSIDB4MTYxMDgwNTANCj4+ICsNCj4+ICAgc3RhdGljIHU2NCBub3Ry
YWNlIHJpc2N2X3RpbWVyX2dldF9jb3VudChzdHJ1Y3QgdWRldmljZSAqZGV2KQ0KPj4gICB7DQo+
PiArICAgICBpZiAoSVNfRU5BQkxFRChDT05GSUdfUDg3MDBfUklTQ1YpKSB7DQo+PiArICAgICAg
ICAgICAgIHUzMiAqbXRpbWVfYWRkciA9ICh1MzIgKilQODcwMF9USU1FUl9BRERSOw0KPj4gKyAg
ICAgICAgICAgICByZXR1cm4gKm10aW1lX2FkZHI7DQo+PiArICAgICB9DQo+PiArDQo+IA0KPiBU
aGlzIGludHJvZHVjZXMgcGxhdGZvcm0tc3BlY2lmaWMgY29kZSB0byB0aGUgZ2VuZXJpYyBSSVND
LVYNCj4gVElNRS1DU1ItYmFzZWQgdGltZXIgZHJpdmVyLg0KPiANCj4gSWYgeW91ciBwbGF0Zm9y
bSBkb2Vzbid0IGltcGxlbWVudCBhIFRJTUUgQ1NSIGluIGhhcmR3YXJlLCBJIHN1Z2dlc3QNCj4g
dXNpbmcgcmlzY3ZfYWNsaW50X3RpbWVyLmMgaWYgdGhlIHByb3ZpZGVyIG9mIFA4NzAwX1RJTUVS
IGlzDQo+IGNvbXBhdGlibGUgd2l0aCB0aGUgUklTQy1WIEFDTElOVCBzcGVjaWZpY2F0aW9uLCBv
ciBqdXN0IGludHJvZHVjaW5nIGENCj4gbmV3IGRyaXZlciBvdGhlcndpc2UuDQo+IA0KPiBSZWdh
cmRzLA0KPiBZYW8gWmkNCj4gDQo+PiAgICAgICAgX19tYXliZV91bnVzZWQgdTMyIGhpLCBsbzsN
Cj4+DQo+PiAgICAgICAgaWYgKElTX0VOQUJMRUQoQ09ORklHXzY0QklUKSkNCj4+IC0tDQo+PiAy
LjM0LjENCg0KVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3IGFuZCBzdWdnZXN0aW9uISBJIHdhcyBh
YmxlIHRvIHJlc29sdmUgdGhlDQppc3N1ZSBieSB1c2luZyByaXNjdl9hY2xpbnRfdGltZXIsIGFu
ZCB0aGUgdXBkYXRlZCBjaGFuZ2VzIHdpbGwgYmUNCmluY2x1ZGVkIGluIHY0Lg0KDQpSZWdhcmRz
LA0KVXJvcw==
