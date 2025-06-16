Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD008C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 16:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58E3482B18;
	Mon, 16 Jun 2025 18:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="gPsgU2jU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62EE982C79; Mon, 16 Jun 2025 18:29:31 +0200 (CEST)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazolkn190120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d406::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D09C82A0A
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 18:29:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPI5gvqY/Mj0nAdjb1jdm4jTYM8b5d27r7++qtJN0edXg3ExpR4f6WVu1JDoC59zNi7md7ZSSt++YB/Ivn63gl+dZmtfpF3VEBTo4M/tuBRTyP9jEkik0dqog9nJ8cKRJ12TA2s9L9kncXGYXGTtKS3NTkvzJnzZGmI3nSF8mthJ4w6xL9HvS1D3UD/qwChBpW4zhY90va4oQI+9GdUhW3+bZC3dX2QOh9otSrD7lSY16IvYHgQYhQImBZaxOsqaK8wTGmTW5zZ6I7QfNbFDdC1c7/EF9IlMaJOk1QjCyfu0VisheMZpR4tzFUrye00H8S3WdRcnKIB/+JL4yfnJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBzbc7mufveLvy3UFGRM2l/W2rL4+3fvNymScNrmAfw=;
 b=wr+pYg0SUS/TwFYlymuvEg4d9l8nV8/oLZwfIzqo2YzM5zFfEo167DNzWjFdeZeG8ivmn2MN++RuYqRRQgohSClVnrsV55CzQiHolsmDVfz6V0fw20/+OleuAq1b89ZiSKg2gE0aaa4f10XR/+qPgoUoW/SSYYhVIn51V7wTo+tExTEKsgtFiYPNNNem0XnUoyZSN7ahs0oEORQrDkHBisJ9WORNRbW+Re0alBDA+QMLGJkGm99YqpatbvoAQhL0T5HIU00voVIngbXUzzKdni9a+zzvlSyVVjbWba8uRXTLcJZYLmwEorFFdMUCd0ka7SsthfoU6TpJQclUjuWVRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBzbc7mufveLvy3UFGRM2l/W2rL4+3fvNymScNrmAfw=;
 b=gPsgU2jULWTSMKBrzdYcEOl23Baa3gdmfs1eyNVbbrbvOkZkBprngw46CX+YYjq5rYhQA7F6CXepPZrR+Zv/DW9VaOMUVrkNDwJFSkDjRpA7A5ZCG2e6M5lEEwM5WpwJoo/7CadXxjRSBOdcH8uB6tt5hwAdyx68pFfv434YF8sAH4Nfa4QpPEyDqcV73kDTVnNW+3QXCFOj8kfxdXFQVqwmlFpPzbWMu7WG0t0O4QOY9ba3fquqH5qYkPCTH8XfSriEXOqDTbTXInBYVZDIAWgeCfQoi8s/feEgxyU72AG3WBvPD0mrMINK6oli7ZXa/PDzKPWifhvmPIEisoQfIA==
Received: from SEYPR02MB5557.apcprd02.prod.outlook.com (2603:1096:101:52::6)
 by SEYPR02MB5799.apcprd02.prod.outlook.com (2603:1096:101:5f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Mon, 16 Jun
 2025 16:29:24 +0000
Received: from SEYPR02MB5557.apcprd02.prod.outlook.com
 ([fe80::cb39:3489:a58d:107f]) by SEYPR02MB5557.apcprd02.prod.outlook.com
 ([fe80::cb39:3489:a58d:107f%4]) with mapi id 15.20.8769.031; Mon, 16 Jun 2025
 16:29:23 +0000
Message-ID: <SEYPR02MB5557A07F64231E76714D25539670A@SEYPR02MB5557.apcprd02.prod.outlook.com>
Date: Tue, 17 Jun 2025 00:29:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm: armv7: fix a bug that prevents CONFIG_BLOBLIST
 and CONFIG_POSITION_INDEPENDENT to be enabled together
To: Mikko Rapeli <mikko.rapeli@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, u-boot@lists.denx.de
References: <20250531-pie_blob_fix-v1-0-7b4a37987dbc@outlook.com>
 <b80d6fe8-d477-430b-bf21-eb7662541c28@cherry.de> <aEA8uXoptzUQ03Xc@nuoska>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <aEA8uXoptzUQ03Xc@nuoska>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0154.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::19) To SEYPR02MB5557.apcprd02.prod.outlook.com
 (2603:1096:101:52::6)
X-Microsoft-Original-Message-ID: <db6ab1c2-56ab-4b88-b816-c437cf956d6f@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB5557:EE_|SEYPR02MB5799:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e457fe-a949-4185-f37b-08ddacf2f3ee
X-MS-Exchange-SLBlob-MailProps: laRBL560oLQAjZyKWNgLfzHbgqV4BrVxM3cYoLBqk5bV3Kv/I3OCWUrzFPd7eAFZLE+Q+uUtCc3eLINXd2rh1f3aRXwt+q4Db8WMZJKiJ3fqnKwDwwXGmUegzvV5b3Kgmr7yUO2FOfI/ohdOE0RcAODKJiVy3B80zLrIB5AUcPupBWpYcUli7sg8yw+s4f6xftbx8r8V+3PmpOX17gOj1VDmIfHr2JsiNZNCmxxkzIlcQNVAlDx8mENCxoba0zgWWky7iO9dBFcr4WpbYk4J2bPKinOkLdFECbH9WMeAHIav/AEwrv6ghfzTUlmc7eX4QhZg4meY9j+cya+mM4cADZ7cQnj+4UnDpRLPL0OQOUWwTe/30k0RDp3878XuZ/Ep6lUeWoEc363lC3ZYta4f/6Dkcw/NQSvd9etSubaSbQAWQFITvC7xkbb/ZQHmU8e0LAQUvPDQD8gW6WLbBTQc2a3GsDHPvBh8Qx8jn0CHO8/iylieBD17gkGkQG/bq2YTqyv+2J6xBij0ISrZATHfcnK4+Jjck87VUiW+cIA6hsJnwkleNvyUKNRdXkPzOqCic2/U2Kc4M2xPXFhqkZ1DgxmE/QUTUKCp9pebGhf/aao62W65Ou6hDBx27ucQ2XM1u85i5AYczcjw8ViWJIL7Q5bhondkX+wxjXT0Nyh7siVkIpB94RrL8CR3ErKqPwSHgck2ac6VU1KfOnT7aem8hBgoaTgYL+lem1A93hX5walUSo05MKasKlr8umdxQYufgdCxRz4HN+aepSg7Gdfl9acECPlvtfqX
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799009|19110799006|5072599009|8060799009|6090799003|461199028|4302099013|3412199025|440099028|10035399007|1602099012|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnYvUTVsMUpybktsaG82V2FqM3B5dnZnb0xOejN5Z2ZXd2NjOXp2Mzkva0VN?=
 =?utf-8?B?ZXhVVUh3WmpWcmhyNmN3YzlySmR1a1g5M3YrOWJZYXpRWnAwYXVCQnR3YVFD?=
 =?utf-8?B?OElzVGhUem5odmlKYkhCNk15THhvNU5RcG9EM2hqSWFYWjArRHpFZ25CVCtD?=
 =?utf-8?B?NW5yTlVXQWVOL3o1NUgweVY5L2IrNUMyZ01DSDRkUkRMSncrNGxmUnpqRFJP?=
 =?utf-8?B?NjN3UEM5NldJT3pCK0QrL3U0MnU0UzRBV3dFL1hNUjZ1UlFHWExNYVZTK1Bw?=
 =?utf-8?B?K1orYk1pOGFZaWlGV05GRWhkSnQ1UFFVOW5aaEZDc2Z3TGhSekFKMXNHTkIz?=
 =?utf-8?B?Vy9nVWlhczY3VUZmYXRSYjdyRHFGbjdqekdydmJNbFRiNC9SSzVtVE43NGFz?=
 =?utf-8?B?VHRBdys1N3RZa25iUkNaeklveTNOYnFjT0pZcVBtZmpCclprelNWYVdNa0Nj?=
 =?utf-8?B?dUJyamRrQklHWHptUm9mM0IzTUw0dm0rdjFYYjJJa0ZuUGtzM2UvdkRERHhX?=
 =?utf-8?B?QTZoNWNqQXR2V2tUS1gwQ3pDWnYzdHN1QTU4dU9hSHB2bDFaQVNhTzhIZnVI?=
 =?utf-8?B?MllMRkxNODJ5ckw5ZWFtWEFwd21HR3BEVzEwMXY1ci9iNFF0dytEN0E3UTl4?=
 =?utf-8?B?dnFPbm15MXc5MUFzT0IxNGl1VXR5Nzh0NFdMQmxUWFRzWk1LdHdwY2tXa0dX?=
 =?utf-8?B?UTlHWmFnbHhpeWRnSHIvSHRmYnc2SlZNQnhCSkN2UExvLytPQ3VoTUhnOHNn?=
 =?utf-8?B?RzhHYXJIcXdZYkZVb2lPK05nUmVQcWwzL3ptQjFhb0JJSk91WVpnR2trejRK?=
 =?utf-8?B?NzRDWG5TOXZUN2xFV1pNVVlhL3I2K2twTWJpeTBiUENsMGZRd3dWSlNKT2Iw?=
 =?utf-8?B?QjNlYmphRXg2a1pDRzBkTzdFdlFoSXBreXhqa0l4TERwckpraEwxb2t3SHR0?=
 =?utf-8?B?R3VmaUh4RDJ4QWlLZXdLcFVoU2R1S3BaNCs0MENPTGNpeDl2SGZhV1BNZERo?=
 =?utf-8?B?aXo2N1F1QWxCUmg1NDNRK0ovZjlqK29sQmY2WmxCa1lJRnVKdmxWbHNwUnFQ?=
 =?utf-8?B?TTNyVnAybldjcFdqL1lYa2JBZXoxZkZSZU9vUGNnWmJUWHdWNE5lTHRiU2JI?=
 =?utf-8?B?K0QvN0VYR29TWE9SK1MwOThkWlBLcGtpRmRSYUh5VVlQa2UwN200aXVrbW9m?=
 =?utf-8?B?NnkzWk9TQWZhbkFHTHlvRWd1Smo1bzVnNE5KdVJoUjRna2VYZFRoZE1QcjdW?=
 =?utf-8?B?Q0cyRTRneXFmUWkrVTY5cWxrM0htT1RYSmV1cWhwT2NoTldUSHViL21rT0tT?=
 =?utf-8?B?dFpvZW04YVdQMHNhZFlCdTRDNHJzN2V1WW9ZZ1Z4dGkzVGpSR0J3RDEwYjJ0?=
 =?utf-8?B?K1hPTUQ0b0tZcnpncitNek1RVnFGMmpaTU9kcE80Y1JWNzJEWW1ldkdFdDg4?=
 =?utf-8?B?WC83czNnOHBDbjVrNm1QNUxJTHVER1FkTzdheTUwbmZsTXhGZ0xkaGt2aWo0?=
 =?utf-8?B?VVlpOXlTc0E0elVMWlZIUk5NaUtRYlpXZFZQRTl1Q0tLWTNLRUI1OVJZZ1E2?=
 =?utf-8?B?TUZkM3FyZWpRSVlnRlc0b2gzbWZtTXRBNHVZeVI5WTE1WjM4eFBHaWhiNzNl?=
 =?utf-8?B?cWJjdk1hUHVNN2pkRTA0b0JHYlhJNkhjM1Jyblg5T3AzVkU4cU5Lb0hSWWJl?=
 =?utf-8?B?dTdKYXpkWkp4eDk5dytkamFKM25pZ2pueDlhUE4wUmc0TXR6ZWZMZ3pxOTRX?=
 =?utf-8?Q?nmIqmIiHGxvp19+btE=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWJMK3kyaWRqWlllWU5GVExqeGhOMjRkNkZMeGhYS2gvc1dWZ3NDSTlPTWNy?=
 =?utf-8?B?NWtqRTFWTFJFZ3dUanNVTTFVRTVvcWdIeGtjRzJJL0pTSU42MnBGamljTjBq?=
 =?utf-8?B?NDZ6TzcvWEM5SitCSHJXMkVaWG5ueUdYVGMrOElCOUozVERqWmlEdW9Kc2hB?=
 =?utf-8?B?R1ZZYmhNbDZQd1lVWWFVZ296ZjFmMTZBQzlJbDNXYzdhZXF1K2lFaXpGd0hs?=
 =?utf-8?B?bEorWjlRQUlEUzUvaGhtenE5aWJBL1hVeklnU0ZNVk81dVpHRTNVN1BqZ0N6?=
 =?utf-8?B?ZGpKWTNST1hXMWlmR1pFTDZ5THFUeWd1LzhYSEl3ellYYXM2M0FlS3hTTlhQ?=
 =?utf-8?B?bDMwbW1QellBeVhneCtmaVBwREh6a21NZWlQd05UOGNJVGlHOFZuUUh1S1Yw?=
 =?utf-8?B?cWVLdTA1Qi9rOGYyWlhkdDg0Z2EybTZqSGlvejB5N1hFSzM0ZnBoMWFUbGJw?=
 =?utf-8?B?M3hVZ29ubjV2THdwL25rLzBHSnl0K3kxdGEwbzFUdFFLSDZMck5vQmVhYVJ3?=
 =?utf-8?B?cHE1Q3krZkV3WG5OVlJ1bUJzaUNFZldISHRyVVpjaVc2di9FaEw3SnhEVklP?=
 =?utf-8?B?WE9hcjF1K1lzMERqZDllNURqZ1pWSUhiTG93bzlkN0QzRUk2bWNKL1dWV1c4?=
 =?utf-8?B?RFJPTkRaUVdRUk9KNWoxK2xLRGtCdXNValRhUklNd1NUWDBjbFIyNXc2OVpr?=
 =?utf-8?B?YmJCN24rWjN4dE9YcGd5SkNMcFh2U09aTEJabnpoM21xamh0S0JJTjg1SG1H?=
 =?utf-8?B?VEdCbE9KNThBaXZMSUFDa3JwVkVyWjQ5UVpOVzJSVmFHZ0d6WmhxOHJVTzE4?=
 =?utf-8?B?Z2lSSTlRMUxKN2cyR0wzTXpxV0xvK0J5clYwQ3N2Mmc5RVh2RiszQzFLU1Nt?=
 =?utf-8?B?QmQ3OFlzbkVFMldDcDZDYzJHRmwxUVdqTk9WN3BwWkN3ZVVsSU5jRTRsMURZ?=
 =?utf-8?B?SlBKemxqaVpGQXB0cHBON2d1aHR4QVhwanRISUoyRk0zVnFySWNSZ2lLYzh1?=
 =?utf-8?B?NUJGZWkyUWxlcGlFaUZIcUdRdTJuZCtmN00zbTlqckozUzkzaU5uZDlRS1lk?=
 =?utf-8?B?bTBsZHdoTkV4SlpNNnZPNEZBYXRnM2VjU1c2ZUhLTzRyRTZLSnZRRC9iOUda?=
 =?utf-8?B?bVRKczgvR3ZRd0JuYVkzU3VabkdyemNzVUR5cUdGa1lleVB5N3dMQkRHSTJy?=
 =?utf-8?B?YmJoNVNBS1kxVE1WUHpCU0ltU1VtQXhIQlRmNVo0aVY1N3ZyMmQ2TzZWWVdo?=
 =?utf-8?B?Q21uZU9HZHRyeU5iWGV5QytsOXg3Ukl4b1pLUWdnQloxeFZUQW9WTUtXNldn?=
 =?utf-8?B?ZW9nMEJoS25iOVdJTW03eGVFMHQ1N0M5aTdxaU5XVzBhVmo2ZkJRWXVoVWdC?=
 =?utf-8?B?VC84UEJJVGVRY252Z0djSXlJMldqZy9UNWVwejFvbFhJTzl6ZTFYU3RFanZj?=
 =?utf-8?B?ZjUweDVqWHk5REdRN1dWWjRTalFnRnkzZnVocWErSnNubWlqR0xNY3BEQjAz?=
 =?utf-8?B?K3hEY3hhbHpkUnpNcjlJZkRlUVdxMjFBVVhuQ1FQNDg0Wm55OWVSc3VQU0o2?=
 =?utf-8?B?WWFiR2M0WmUvcmtNaWU4aUtkZzFNTnVhL0I3cy9HOGZ2QVNwNFpHclRZdzBt?=
 =?utf-8?B?TW05Zk1vMk55SVNGZzRxZmlCSzdVZFBiNE5NcU9YeTVzSFphbVZSTng3RXBn?=
 =?utf-8?Q?Kn/1/2f2w84PDyB53TDs?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e457fe-a949-4185-f37b-08ddacf2f3ee
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB5557.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 16:29:23.4282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB5799
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

On 6/4/2025 8:31 PM, Mikko Rapeli wrote:
> Hi,
>
> On Mon, Jun 02, 2025 at 12:37:10PM +0200, Quentin Schulz wrote:
>> +Cc Mikko Rapeli who's attempting to patch this in OpenEmbedded-Core
>>
>> On 5/31/25 3:10 PM, Yang Xiwen via B4 Relay wrote:
>>> [You don't often get email from devnull+forbidden405.outlook.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> This patchset also enables CONFIG_POSITION_INDEPENDENT for qemu boards
>>> to avoid similar issues to happen again in the future.
>>>
>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>> ---
>>> Yang Xiwen (2):
>>>         arm: armv7: restore section to .text after saved_args
>>>         arm: qemu: Add imply CONFIG_POSITION_INDEPENDENT
>>>
>>>    arch/arm/Kconfig           | 1 +
>>>    arch/arm/cpu/armv7/start.S | 2 ++
>>>    2 files changed, 3 insertions(+)
>>> ---
>>> base-commit: 93905ab6e7564089f5d7b703b660464d675e5ab0
>>> change-id: 20250529-pie_blob_fix-a61229c8fcc6
> I tried adding this series and similar armv8 change to u-boot master
> branch at commit fdc0dcbb2c84c4c but this does not fix the boot hang
> with qemu kvm. Patch applied was:
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 79f60eb3f349..6ff3f2750ea8 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1091,6 +1091,7 @@ config ARCH_QEMU
>          imply USB_XHCI_PCI
>          imply USB_KEYBOARD
>          imply CMD_USB
> +       imply POSITION_INDEPENDENT
>   
>   config ARCH_RENESAS
>          bool "Renesas ARM SoCs"
> diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
> index 959251957de4..833486817f84 100644
> --- a/arch/arm/cpu/armv7/start.S
> +++ b/arch/arm/cpu/armv7/start.S
> @@ -182,6 +182,8 @@ saved_args:
>          .word 0
>          .endr
>   END(saved_args)
> +
> +       .section .text
>   #endif
>   
>   #ifdef CONFIG_ARMV7_LPAE
> diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
> index 829a620faeb6..1d0b59889e78 100644
> --- a/arch/arm/cpu/armv8/start.S
> +++ b/arch/arm/cpu/armv8/start.S
> @@ -409,4 +409,6 @@ saved_args:
>          .dword 0
>          .endr
>   END(saved_args)
> +
> +       .section .text
>   #endif
>
>
> Cheers,
>
> -Mikko

Sorry for the delay. Have you tried debugging it with gdb? Try to run 
qemu with -sS, then attach gdb to it to see what's wrong there.

-- 
Regards,
Yang Xiwen

