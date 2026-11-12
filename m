Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF1E606A880
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 14:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V2FXeE1i;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=PTLWTjpW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E22781540;
	Thu, 12 Nov 2026 14:38:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dndTtaDTKfz7; Thu, 12 Nov 2026 14:38:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DA7FE8132B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794494308;
	b=fpo/IpijCKTn5VT/jMJKN3fl1Wn1aOqHnVb4A5oHqyWbRVKgShWRSu95T05gWL29ZJ4i
	 m+kraDXS8pxa9XfOqgVir6jLMoX3mNqqU7ks2F2IWtcmwHIajQrs0pE5XG8bL9rVVtAU4
	 WuhaQBHCOMqdV2KrynOepIGgf4ZLVsrB75lfsEo8L48ay/K+FIWjKcau67mLA5Ut47qkv
	 2D7kdd20Fjr6MbjXWUD/gSPvaup77KPi/IIP88GATJtiWdYwpph7wr0/1vTakbXCxwLtz
	 RuUKzFWXzg02buJcyDH0+Ajnf9eF8jVvHLgPwMuE4IgvMupINsKERhs6ObRU2fK8nJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794494308;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aTE9qL4AVE7ENcn3acY296Ju+lj44RWkcDV/r+1l8f4=;
	b=d7e8IfinWGTODqfwrsfA6Bf+zboE9YqJNErlkpem67bR7kfX+vb7uF+lqSV7fBYY+jWi
	 tqA+3kaFRBMpTLAE16ZOvNwVXprek3bK7USyF12o/G2idCq8I0qONyZFg/ed5WT8rrtB5
	 ao3LCb6qOM0LYBE+Uk+5blekzfmLBTRR0Jnoq5oVu9tw/JXLZUkic6FStkxp08naF1OE6
	 H0juz+uc6eWpxJKEAWNAK7q7tPJ0r6GMy5P7i1L9QAhTjmghz+BTm5bMexT/U9lbpaLTS
	 rhtFsd5A0e2nxCScqGO+XrmiKnuq3+59D1XMllziDfnZfDxvrzrvWKrJhJskSoo4xSQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=PTLWTjpW;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794494308;
	bh=aTE9qL4AVE7ENcn3acY296Ju+lj44RWkcDV/r+1l8f4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V2FXeE1iFqyOUWzdaI9YQOt1nRGH52DG19J7+sNGQjT5qISnGTKOnb/abkylodaCo
	 7QscjTYesWw2ga7KuDSkOhC0VRpxYqVyxU/jeOhiQ0IeajcaFBDkZOyvWV9q0382ED
	 fF4snmgxZMsBIwY0iho3+dZd/31iMQv4y1QtK4KzWCLIUWaPSZk89QTAh0cEiX0qRt
	 Wape/6RgY/eAQW8qiPrXvKbTcY8cdzUZLgHLLs/2pRlP+QVldVyWTJ3buybDDwJYyp
	 2N6WH6ixTlD1KBndVGhpPDSfvSAl+zvNdZYvzLWp7nzQl3pRTWuwi92MM3swT3LvSB
	 0l2i34d88+nDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA7FE8132B;
	Thu, 12 Nov 2026 14:38:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 50FC7F46
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 14:38:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 429D58132B
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 14:38:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cP1MGUfp6-6S for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 14:38:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 467FB81255
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=PTLWTjpW
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 467FB81255
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 14:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTE9qL4AVE7ENcn3acY296Ju+lj44RWkcDV/r+1l8f4=;
 b=PTLWTjpWFjSFHQ89w+hqwD85XxpzLk6fO+fZHoa0CK1vPYjux5RMLNWRRKV47w2yhq9P1vcirHako39mAoqJSFbW/1sLpUFehRsDLY9puNsSZC4KGsSf1eWCFB6Exq3K3ULUYpfLwqlUQtiyTqDV+q8Rov1jB1sKHsrgR5cT1u0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PAWPR04MB9864.eurprd04.prod.outlook.com (2603:10a6:102:390::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 14:38:19 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 14:38:19 +0000
Message-ID: <8fd0102f-0f02-4874-9696-707f4f38ed56@cherry.de>
Date: Thu, 12 Nov 2026 15:38:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] test: Build mkeficapsule in tree used by tests
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 u-boot@lists.u-boot-project.org, Kory Maincent <kory.maincent@bootlin.com>,
 Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini
 <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Alexey Charkov <alchark@flipper.net>, Francesco Valla <francesco@valla.it>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
 <20261110-qcheck_fix-v2-8-1c76e0b68f29@linaro.org>
 <f2624c53-50ec-442b-a783-b0c669108a68@cherry.de>
 <c9813d55-f3a3-4477-b276-e6a6c9f9f192@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <c9813d55-f3a3-4477-b276-e6a6c9f9f192@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::16) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PAWPR04MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc9954b-b4ab-44fb-2a14-08df40ca980d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|1800799024|376014|4143699003|5023799004|11063799006|56012099006|18002099003|22082099003|6133799003|10067099003|261009223027099003|261028144727099003|261102123227099003|261026140227099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: 6uS2IffwsOWhTW5OU3i3LJQ3jiTMtITnp2neuB/FHTIFFv6LoaxilkycurKiwLCOEoBUsWwuqnVBpNPQbiRViFqn2vXIozULy7/UGmN5jvvn2Qb1Rc/2hYpt7A/n2SCbHw7/tOuII752+RtDbC9v7lJuT1RRuvd29aJ0M3iG6Zmrx4tnQ9zCwz0YD3GA67AMsBUfxpVVezsPwyV/qSNRrHTcmbSfGkvOhI57rSeaXuepFeEM3ESRCOPvS08p6yyh0lgSAmLlrnMxyJiJW6EfBRqwxsDyV4dC72vqwcYvimbwhZejpFy6guEOU3C9A7qdgBoUdJXl3yH657KXvRfBgB063z+yjahnAle3D2t+jv7GoiogSEsdWcqvWB8m0JU9pFy2uGk4GOIfRkzpTb6G+HkX8oom9rJN+/LjjDe9FYqfVh5gfyooeTkGYSjFbOzkhjiCiZTRsCQjbdGBULRXrurp3AXcx76Aho2+gFW1/lCHVlg8Jg3SouxbUvcGPIMD4831mln0DgfY9fcLzYhqAuNHRCvXMn+kkQ89P+UYKa4lEBM0BaTq99vI80A2vHrdBb+/i/sZdeVsvbWq7uxUXmfCezy79+Q65HSSvSK6ZeOybtoj+0ksm4Z7L6DvmXMBXkQBt+BxBtHg/DSq+ncFuWv+rOXAYgb3NuP4Ba7vwm8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(4143699003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003)(10067099003)(261009223027099003)(261028144727099003)(261102123227099003)(261026140227099003)(261022105027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzJ1aGtncGNyV3JJdzZYVmh1TlErVzZyd3p2MjN3SDBoSUJQWVBCZkhkaUxI?=
 =?utf-8?B?clRvbVZJV09Qb1A0bG5RamR4WHEvVjFLaWZIZnZlMEdiZUFiM3ZRMEF6aHA4?=
 =?utf-8?B?OWUxYVRkTmhGWTJvekkxQ2VITVpxbEtXYjgwZnlLak1aSGtzakNueVJvMThH?=
 =?utf-8?B?YmFMd1dMSzZYcGhBTFNiWHNudGJSbGpvMXh3YlJFTlIvRHNKZzdBT1R0MmRZ?=
 =?utf-8?B?VzBVaHBOdmUzcmw2elpDVys5d0lKQ1FhYmlKUVAvOEtoNUVvU0ZvVzRpZEdI?=
 =?utf-8?B?bDR6MlExQlZZY0ZlRUJ3Z2ZpQVlhckQ4UlBxNFZFTlBIZWMzc0V5Smk5NUxx?=
 =?utf-8?B?WUtaZVZKMTQ3NWYyVXM2T05rVFNzeFIwbFpLTDI3QXdEOFN5bFE0b1lQY0VM?=
 =?utf-8?B?d084c2J6dmI1UHdkbWRHbmxHTkZqdWFCc2VvSmxML3hETmZDME42RFhkeXdp?=
 =?utf-8?B?NjlHUUpjdzVWZ095aS9SY1FGMFJEZGRxdjlEQ3l6R3o2dXlmblF5QjVpYTdM?=
 =?utf-8?B?UHkvVjNHWlZlcktIbDdBclNnb1daeXgwWUpHaHFDbjJJVmlyRVZCTy9BS3ZD?=
 =?utf-8?B?Z1pESXQ5TnI3UlIwanNLOWt0M1Z3WnhkeTJJMzJiUUtUOXUvd2dibTJyMXl3?=
 =?utf-8?B?SlBvWk1xOU9oWno3RFgyTlpYWmRGcVd3N2xPdmMrRklGQUJlaHNGK0o1c3o3?=
 =?utf-8?B?NWpvNGRlRDdOeC9xSktGa2o1YjhvQ05RMTZNV1FjMmlsOEdZRUlNMHNOSjYy?=
 =?utf-8?B?UkRoT2dIVUVhU1N2Y2hRdzkvZ3RWWmh6SCtvajJlSHNTN3E1M1Y3aW1qUTBa?=
 =?utf-8?B?TkpJd1NabkZEdS9wUmtUNGc2N1ZUWHJ6NmYyb3c3NXJQazQ3TGZ6Q1orcWVL?=
 =?utf-8?B?WGFEYTFGSnZaa1o5b1Uwc1lEVVlpRkFIaDJDb1RiSGFSWHpqTDVDalV0b2xw?=
 =?utf-8?B?VWxWSGsycVBwZGNEZXFDU3hjeWtyUTVWczRvRTVIVEY2WVZwc2l1VG9rY3ZC?=
 =?utf-8?B?NmNoT1QyUGpUYjZ2K2h6WWZDT3U1WGJlZTVyUkxQMnR1MFNsZ2M4bWVxSXZn?=
 =?utf-8?B?WlVxZDQ3TEk4VGswVTMrc1RZK1dwTVBrY2Y5NHFjYTViemdkcERkWDJFbGtv?=
 =?utf-8?B?L2lEeVU0VGlxQ2dRcHNKT1d5OUE1RE1TQS9RUkxDNjI3VmlwbXp6Wk1XNDhw?=
 =?utf-8?B?ZE1kdXFKeWphMWtZdTMyZkxYdkRWcEozNFoxYlR1WnZQU2lUY1dhQXArcTEx?=
 =?utf-8?B?VWZVVE8vYzhBajhjOXMxM050Qk91d0cvVmJIMUNiMFhPVU1IcWRHSmhFZkdT?=
 =?utf-8?B?WjlXRjF4OHJKaTVtQ0YzempmU0pMK1hNb09wU1pOOWRhWE13Y1MwWjZDaGph?=
 =?utf-8?B?WkNxQUowMWMzdjJEUi9MYWNLSjhvWTdSdk84aGtZVGJmaGRpeHB6cnhOZUd1?=
 =?utf-8?B?SWNwbnpNckJqa3VoWWZrSG55ZGlEdWZtV3R6TjFnVThFWm9TZ3ljUFRDTy9w?=
 =?utf-8?B?OVhDTlNiaXpjdW5BRm1oTmYrU0lIN0dUeFVmZktMV0ZSZC95VXc2Snc2ZjhG?=
 =?utf-8?B?Y21nd1orMmV5NkE5VzQ0SFlJWndsREpmL1NRVE9IZmlGYXJPZHZlWkN5ei9a?=
 =?utf-8?B?Wlg5SFBuMFFJcUFEWDlwNlNocmR6Z2gydGo2emNCSHRSNEhxb3BqN3djYXh3?=
 =?utf-8?B?RG00WG53YWxjN1o4SEp2Z1JRRExTRlhTU3RzbW44YXpMOVp5RWttd1BLN1Bz?=
 =?utf-8?B?U2pEd0pQaEtPMVdpVXEyR0V4blpjdWVobkhoYnZITkFJNU51U1hEQWc2QVI2?=
 =?utf-8?B?YXpOZitmOC9hVUZ0RlJHTXR6aWxPYU8wNWFXemJWbytIM3dCL1doKzdqUzdJ?=
 =?utf-8?B?dENsdlFuOFJ1Z3EvSlZWdzM1TjRaSFpCd3lETXNqbGhBNWVUZFdaZHo4dmRX?=
 =?utf-8?B?bnVhNFJDZVlsd0Y1RFVVNGZVMkE0bWwrNVJUeG9EYXpPNHVwSWtOYkJldjY2?=
 =?utf-8?B?aWluTmtQNUVzU2NYMkxlZ0l1Y05qRWw5ZTM0ZHpIWHlTdHF5b1JnRDhVQWcz?=
 =?utf-8?B?eE9PbjF3WC83K3BidzBGbExRZjFsTzM3eU1CaGw5aDEzR1VTZzZnMFlXUmRL?=
 =?utf-8?B?c2ZwUjlUZUpEVml1amxTMUZrM2paZFJnMitFdlNZSEdVcFFjUkR4cUVqb255?=
 =?utf-8?B?K0E3aHMxRnc4aU5tWFJBT2Y0aHcyZ1BDUkFrd3dXeE9qTHZYRHl2ckhzdDQ5?=
 =?utf-8?B?dGg0N3JkcWMyWUF5K1EvV3Z1SDBreEVQNXZVS0UzNFdydjJCeDhqeldBTnhp?=
 =?utf-8?B?ajdIakVTZVlJU2cycUpJOVhUNlFOa1JQbXNtMmIxdHA2T0xVWGRTZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc9954b-b4ab-44fb-2a14-08df40ca980d
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:38:19.1314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7F5Q9ie2I527aquoI45Zx5GsLQ7rrysU3iszKer7J9YiMhFqLDQSgJLoXxPJDgd1PpNR0scuaSs6HJDDs8s0V4Ta3slVt47CWlbEog8xypo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9864
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andrew,

On 11/10/26 5:35 PM, Andrew Goodbody wrote:
> On 10/11/2026 14:49, Quentin Schulz wrote:
>> Hi Andrew,
>>
>> On 11/10/26 1:24 PM, Andrew Goodbody wrote:
>>> Since the commit to only build mkeficapsule when needed rather than by
>>> default, the build tree build-sandbox_spl no longer contains the built
>>> version of mkeficapsule and this can lead a test failure. Add the
>>> config line to the defconfig so that mkeficapsule is built and the tests
>>> will now work. 'make savedefconfig' was used to generate the new
>>> defconfig file.
>>>
>>
>> This sounds like this is the incorrect way to fix the issue. The 
>> proper fix is probably to gate the test on the presence of 
>> CONFIG_TOOLS_MKEFICAPSULE in the config.
>>
>> @pytest.mark.buildconfigspec('tools_mkeficapsule')
>>
>> is likely the required fix before the test?
>>
>> At the same time, we want to make sure this gets tested, so if nothing 
>> actually runs this test anymore, we should indeed add it to 
>> sandbox_spl (or any other defconfig that is used for testing), but in 
>> a separate patch, that justifies this addition not by saying we 
>> unbreak a test, but that we actually run a test.
>>
>> Cheers,
>> Quentin
> 
> The test is run from the script test/run at line 82 [1]. As this is not 
> a pytest your suggestion is not possible. I should probably have 
> mentioned it was a binman test in the commit message.
> 

Ah, I see, sorry for the noise. Expand a bit on the commit log for the 
v3 and I think we're good thanks.

Cheers,
Quentin
