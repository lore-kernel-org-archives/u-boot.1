Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA96606A31C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=K6H5GX1S;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=akL/ZCZ8
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CA254082F;
	Tue, 10 Nov 2026 14:49:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EEeVL3Vxqb2v; Tue, 10 Nov 2026 14:49:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BEBAA40851
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794322197;
	b=iGQ30FpaM6T7yEAMjDb3zBRoawrcIESEvQKUcvOdByjffrgFvoQz1hFluvk/m4/SPa9/
	 wALdP2Yv1AjtTSvhGUUUIqq6HzCZC89SvJmIdwlMVQcMnQ3Ruw5CbkgFpca7JsOl6pGZN
	 eaou956nZ9/mRW5zG5Y04jh6AgYkrdLxjrAGhEBar35colKfGUuYFVoXFnW4xMrurW8zg
	 nKvhZnaVdgF5YBvar5HzfivitQgPjA5WOLDeOi/wuc5DTJzkr9IReMXnsOt6rPV7Ed0gQ
	 gc31Zh+Ma91M1OjQpG7Wp/l+eezS4hJBShqrOlZjywaEDB7z6CGC/xmZNFStQTblrOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794322197;
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
	bh=Gm8/3+Rb0a151SjFwlqEywsg+XYQC7F3JJT5MTQrEZo=;
	b=MKoKFM86RvRDN9lZ0xBRrxnnsl/Sa67OtJIvK9S07nZuZVgp4smM78834PJF7If/Axk1
	 hRSP1FPnE+etBDRqsNXwwcU5dRmI9KJQyFnoVb0VMx9yI2RuT3081KNoG2OKWSA3XceSt
	 Qb9FFqwESOR5gmZPf6grcN9HeYt7edTRfSmBfxrDGE1Js5hQXP53+SZmLCTuN4DjZjR3K
	 lNSdmwNoQwPfabgP7t/s47IF94THchyaxR+bFuyypyesUP1CiS98jTTih0A8z1cS3J7Di
	 b6dQGB6NO5qRsbAtyXIw8JLSXqoB3Xqv5DpaI70OoDIQTuhp+nOItJR+tLSNo5Goizw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794322197;
	bh=Gm8/3+Rb0a151SjFwlqEywsg+XYQC7F3JJT5MTQrEZo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K6H5GX1SNYW4RoPzOH8HeVkkM9byazTABxPeAfrFxKd2eSDftOCQFsRtDzPCO3XJb
	 Htx6QYFmvu85bQPICzcNAKvZL3D/JPooUhM5Rtl//zC74TSsD0IV8O743vB+8S+0eD
	 8A97FRBlVMBcpSKBeocsI6fwyhjEmJjtsic/DSi0JqqbmwQ2PvLeCMQ2mP/G0Bx9JL
	 HGYH5dFHE6FGlnXZTmF6a2AV56oCbqOqW0a7FZV/NQDg4wjWvHovTgzuVfbO/UIB3d
	 VCAcDGsRE0gSPdEHwq7Y5eKANmqvJ7Y5vwWznbo1KDLBk7HdUuUutMtRkLZ77e+5qQ
	 2DGo7UIzlYZ8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEBAA40851;
	Tue, 10 Nov 2026 14:49:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C894D9D1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:49:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AE2254036E
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:49:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jsI7XqWW7vq9 for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 14:49:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B9D764031C
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=akL/ZCZ8
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B9D764031C
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gm8/3+Rb0a151SjFwlqEywsg+XYQC7F3JJT5MTQrEZo=;
 b=akL/ZCZ8HxH6wY15B87nRzYrHc4RrUsRdCtqRo8mpNuoNqtZGUAdzLRqbMFCDa1IPXXdx548MacNspmyXObxs/qDnUqOEdkfooo5X7pMC9vcF2iG4/E+2bT3iZtf4VJ3K/X/UKFCDiSDnz8SeDBsbHMp00G/5aEg7/BC63kGVe0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GV1PR04MB10477.eurprd04.prod.outlook.com (2603:10a6:150:1cb::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Tue, 10 Nov
 2026 14:49:43 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 14:49:43 +0000
Message-ID: <f2624c53-50ec-442b-a783-b0c669108a68@cherry.de>
Date: Tue, 10 Nov 2026 15:49:41 +0100
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
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261110-qcheck_fix-v2-8-1c76e0b68f29@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0329.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::12) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GV1PR04MB10477:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b9d5fd-881b-4edf-b8a6-08df3f39dadb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|261028144727099003|11063799006|5023799004|4143699003|261021121427099003|261026140227099003|56012099006|261022105027099003|261102123227099003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: kPWPhQxSol5dEG8uj5wZ87zENlPnYeGgx6DXOZMlKuSuBuR6K4kUI0XEeW2oAeASY7DVDWIieIM6IJkjAXy+RKVNj8IuslL/4G3XLk+jmmTkHYIDVlXTfrNIwjqyaPOUJjY3DdddlsSnnwRsEp9g50V/he2i75C/SgRDOIc+GAcO0wopAaxhcZJ1Mq0P2/KquPGpaYOVXyghXcnflq/Anfgw+WyxbXaeeezcaRgEqVN/v8nf3f/4HY+h3mJb+xtqUNHRk99Iba6CRB0ypl7VmROH3hF0qOfTDrgHPjenhnz6SCpzyfYYqDSp15QKGtEc+5z1GYOnQJBUGAQs2vtnT0c8LxvlyUDUuS5M3d6TNIUf/aFShvM8uTaV+agjRu28RXgL87FYQMVeVs9Cl2ISAoX4J1YRHSkWN/NRBYL5l2cnwyj+kTEIfjCedG7rUUUjvc6abZaiebwlnpEOOtvTKG397IvMVKYyRmGFqgxhAGLS1nDrldIlUO+XtdqmQ21mPy/wWJIAkWlZ35qjIxJrrDjbbjUEw5+w+PChYAp0OH9yEqwiCsxAOc3Rqx6eaVTjYfO8SrB54BH+eNH8eJ4zTwChSbt1yi1PSlDNk3fNCIQxvJicN3QWW0HcNdj8QQAk3qcjCSpjkLwN8N+kqyJGwL+ISKi/x5GdPCyuXYXH1Y0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(261028144727099003)(11063799006)(5023799004)(4143699003)(261021121427099003)(261026140227099003)(56012099006)(261022105027099003)(261102123227099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjdJMHFaTUJkLzhOWitXMGluMW85TmNuWUpRMTEyQ1Q1aUJrbkZvSEFjWUY5?=
 =?utf-8?B?bDZRRFROQm52Yk5zN0MyRVdLNGxkT25POHVSR21JZUs2WEtDK1BmRUlUSDRq?=
 =?utf-8?B?dmF2TmE2L09NU2FYMlg5Ym5tMVRqeEpzWnBHd0xxMmUrNXJHMXBSN2lCZ2xY?=
 =?utf-8?B?UldnTGVMLzJwWEd1aENPQ2svTHNEcXdvaDkxSDlZNkt6aVpOWkI0U2NkS3Ji?=
 =?utf-8?B?Y29jNFkySlJ2blArWFlWZmN5OStFSzJDMnVTT1pQQTFLTGVoRW9RQ2N1eVRV?=
 =?utf-8?B?d1MyUEQxVkxsRUNTSWplTTV5Zmh6WVYvTE84YjRmZ1E4eTVwNlRnVkRPclRn?=
 =?utf-8?B?RHdIQmlaclJLNEduQ1l3MitRZk1pUnorVnRUbU5FOGRaODZrVkh4MVdRNkZ6?=
 =?utf-8?B?ZVRsK3NiZVZzVTNWcE5BcGdObEFhZXJwZklPQWtIdmkvUlhnYzl4S0dsUkJ4?=
 =?utf-8?B?amtWYTJkL2t3RzNDNnNHeUdFVE9qWGNCUlVJeUNqNnlQODdzMzdBQ0lyaFcv?=
 =?utf-8?B?RzdBNW4vNExpWk83QlZrd1pINFBxYlRjUlQyZEpUNlZlU0NkanBKRHU3eDN0?=
 =?utf-8?B?ODBqblh0UFFsTTZtclZZTkVmanZ6alExenZJM3poREVSakJyNFN1VTl5bTFY?=
 =?utf-8?B?ME9NWGR2MDNTS0RiTG5NWXZkTllNd0RmVWFiai9KTDJQd0FTdjNETmh2N04z?=
 =?utf-8?B?anByajZWRHpaRGtPNkl5VVBJYlk3SExzb3Ywd2JrVWU1TE1rV043UElKRW9W?=
 =?utf-8?B?YURUdWdUbFRZaWRUTVBKREdJcG14UXJTa3AreUoxM1Z3Um5hdG9yZnJ3dWt1?=
 =?utf-8?B?OHNiOERJZE9QdGFaaWoxU1RXRURweEovMldSM1VCQjluQ05nUzdRc2kramZS?=
 =?utf-8?B?Rzd2V3l6OGU4N2FuNnZ0clMyaTZPaXNYQVpWYWQwbzZ1ZXNTa0NmcG1ZM0gy?=
 =?utf-8?B?RWE4eUZpaDBPYlJydEpPQ2xzVHJxaFh4NktvUnNVY1c2dndNdkxacmFaTytK?=
 =?utf-8?B?NC9ZN2tuUTJ5cVlYMWwxd01jMTlMcDYxWUwvNy9PUEhrN2YvU25mTllSWmR1?=
 =?utf-8?B?NlozeWtkY2U3NkRSN1JXV2FzTEJldXkxanhwQVJmeXprVUFBVXJSbUowSVA3?=
 =?utf-8?B?aXh0OU9xMEpSb1RUMU9veWlPaEhOREVnNUhSK3hib0VreS9YMWhjRy9ZN2xh?=
 =?utf-8?B?TUltRzkvTkhyRWpndmtadCtaaEg4ak1Bek4yRXhXZll4eTBndWJzaExNMElu?=
 =?utf-8?B?ZlFPSXRQeHBxV0h2OU14alpOa1dPaXBIeWxUelhmd2NlUC9WOFJPaTJoSkl5?=
 =?utf-8?B?Y0V4czQ2eTJzSExuaFkwTkRwbUtBU2hvM2c2cWh0ZlNFNDdrSmgvYWQ1MXhv?=
 =?utf-8?B?ajZaUDFyYUVkMmlVNjVDb0V4MUVjVStSVFN5eU9XWlQ2RmJzTkVaZ1FVUVBW?=
 =?utf-8?B?Si81amFFbzB0RkM5S3JtQTIwUDc5UXQ0dnRvMmlydVh3Nk9SYTZidUNzU2RI?=
 =?utf-8?B?U3pMRVMrMVJyNDI4Mk9oWmZab2dlUHhlTkxyd0dXWmIvcTd4OHI4UHBxanRB?=
 =?utf-8?B?ay9tOEhkRDNISFh4UXF4SG15K09oZkZMNFEyTm9UNG1mMWhMUWdVQ0RpRk5J?=
 =?utf-8?B?TnJEMk94YlJBMElCZEd5QlBVeTM5R3EvVjZkekMydERRbjBzNkkxZi9rUkUy?=
 =?utf-8?B?TXBlWkNOYlVTQ3FxQ1NUSWh5THJZVkJVNHRDeU40ZFQ1UDFOQ2RYcGlLMy8z?=
 =?utf-8?B?RXNZbm52QTlKYzhrU0ZtMzR0c05ONkpJUUU5ZGNlTG1xbTFpdDR4eVBsS0FP?=
 =?utf-8?B?aFBBVHgwLytRUVRCMlFjZ2oxbGdzWWx1Wm9Pb1VVeTNQWlR6TWRZREVUVE02?=
 =?utf-8?B?UlVMTkFua1dhaGVEZCtwOXN3eXQrdWp3clhic2xlMk1pZ1F1SmZVMHZaOUZP?=
 =?utf-8?B?NDhMMGFZQjAyUFF0MjZTaURCbDhWbXc2eXpLbWNCK05ucnpvMjJGRTVLakZP?=
 =?utf-8?B?WDBEc0N3RGZWM0JQRjA5clRrUUd1U3pNai9Tc3N5TXY2Qmd5TW5qekM2ZlBI?=
 =?utf-8?B?OWEwM3FoelF6TW1jblVkc0JYOGFHWWgxTlFOeEF6M2tVd01kSnVOTjZxV0xF?=
 =?utf-8?B?Sy9kRk9PZnJETXZXZVJVN2ZBL0N0cFg3L1JvQWo2b1Y4RDFsa05Od1ppby9U?=
 =?utf-8?B?MG5hcEdUL0k4Mi8rdytHSDc1ZlVKZW1ocFlDcTRYVERKaGpva0J6RDRGTG9v?=
 =?utf-8?B?eUVaaFk0RXZsWnh3c3ZSd2RuTkdjbkVvdE9kSXc2UTE1cGZOSWhZZ2FFeUwv?=
 =?utf-8?B?RTlHZW1rREFyOGlhZFhBWEVISnRmeGlsZWFudHBJbXZkZ3ZsdVNSUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b9d5fd-881b-4edf-b8a6-08df3f39dadb
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 14:49:42.9992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /eZGa9HFR/7W0B4OXysPfZU+PV/qGKenuTkxhkKrdumwm+XBdrjHWmqvyGfna5EDq2us5EFWOcjDH+SHz1goCobM8OzvZFm2xUEz2FFen/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10477
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andrew,

On 11/10/26 1:24 PM, Andrew Goodbody wrote:
> Since the commit to only build mkeficapsule when needed rather than by
> default, the build tree build-sandbox_spl no longer contains the built
> version of mkeficapsule and this can lead a test failure. Add the
> config line to the defconfig so that mkeficapsule is built and the tests
> will now work. 'make savedefconfig' was used to generate the new
> defconfig file.
> 

This sounds like this is the incorrect way to fix the issue. The proper 
fix is probably to gate the test on the presence of 
CONFIG_TOOLS_MKEFICAPSULE in the config.

@pytest.mark.buildconfigspec('tools_mkeficapsule')

is likely the required fix before the test?

At the same time, we want to make sure this gets tested, so if nothing 
actually runs this test anymore, we should indeed add it to sandbox_spl 
(or any other defconfig that is used for testing), but in a separate 
patch, that justifies this addition not by saying we unbreak a test, but 
that we actually run a test.

Cheers,
Quentin
