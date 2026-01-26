Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE04D1951F
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 22:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A9CA83BFE;
	Mon, 26 Jan 2026 23:03:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="cp/Ks9X5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="dlXovc8R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83B8083EBA; Mon, 26 Jan 2026 23:03:52 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCCD683B27
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 23:03:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=rcCzqNXSHtSuX6PIP34GFjKq6E0AOhQhIW/oO34I2otqn5vpNAHB6Wvnw9qPD5JM7E5Duo6bLSOpc9o3LNr+1AGThuViHsBwasTd9fSpFl2J89UITr5666YvW2FQb9tqqMVLTBzcBAClJ0TAPEgjICPAS7H6aaTzMGsBzcg67NlGc3RMD3OaTuZASuiZZXRx1quF/qsYgb9nb6x+FhjsLzpecl5WWom5Tzlz4MXViyqULU/xGECFDN/KqLChAzk57RDha/Qm6N9NGpcks9IUFjiXmyJTg4hwHE68iWjpWCnTFS1+vwSFSdfFB7PeTvmJUuZNaOxZrgI85yNPTJT36g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0O6gYfWMLmO7fIU4Ortows2ipWaSQZjO1cBcPfEnoM=;
 b=f/+jY+Z3eNfLMPvAQgx86yIwf3sM+EzuwJEdwjMeN/hGHmNxoqMtFad0WoPZo9n49MtIodPIE/iO8kNibxFha1PXbXTVN11cRI420yVtOQnNk89pbT9jqhen36/YZoiOyTXVigvk4Cfz45PtKPRGHkL4D3FYquEEi7hc6TjCrG3An88463k4aa2gG8W7jcWXXVwodVmrHPC2Av+jK7TY9aervznDHOrv3b0yHja913zK5YYMMWnXHNRH4+h8FoT7qBM2jcvnP6vxnVLJU8qIr9yWro0iH00aJECNeGZKgK1S36H0u8pS6Gg0pLtDLih4jVASXwSV2kVrJD1l1f+4nA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.82) smtp.rcpttodomain=analog.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0O6gYfWMLmO7fIU4Ortows2ipWaSQZjO1cBcPfEnoM=;
 b=cp/Ks9X5l+pKClrGuFByNog+H09O7uvvTOM70rr6fMw8O+cBSgsxxxqVT3HmlRpOwR1BjCBMOBbMFikEuE2AjHhFIfn62kpkmUNTph3rdTfLhmEcAglonMJrOtlreCRpgU6FezLlCYtVjmV4/uZtktniQWGyZcydxVZ7QWd4Eg9qMnwNhP1ou/SWz79hmgbYn3LcsO0k0L/JXzQHPZw+UXdw8XLibL4+mEEsK4WUqzMVWwD9AT4HlIgjkoQH8GNCF72ZaoeFL76mVtGbcH+xJLnCIvuaqcJzbgAcxfpmNd2OFrCCkLufsmF+HQKFKD0f6F8+e1JUbPllRk0IlR/OAA==
Received: from CWLP265CA0420.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b6::18)
 by DB9PR03MB9808.eurprd03.prod.outlook.com (2603:10a6:10:45e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 22:03:28 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:400:1b6:cafe::19) by CWLP265CA0420.outlook.office365.com
 (2603:10a6:400:1b6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 22:03:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.82)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.82 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.82; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.82) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Mon, 26 Jan 2026 22:03:46 +0000
Received: from outmta (unknown [192.168.82.132])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 6B378200805B5; Mon, 26 Jan 2026 22:03:46 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (unknown
 [52.101.70.133])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 5F22220081261; 
 Mon, 26 Jan 2026 22:03:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/SA7V6IopdEMBwxWyoyOTmIBwROLLQcaE1rm06lzevBF0gn7gt1rsNmnLEYmWuu/9HCKuCqXSrWrTImAsI5z0UmfTPxxvFF9a7rmfStAYagAdwXJi83PhQS5TjnvQ55Do/rPLFckUUNS0WkwLnHDd4pXC2Fn7YeSDyx9V59OIQMhGUhz0WU/LEnLlAfnxYvd9UXl2p6MebF/TEdd0GYjWIp+kJ6KLZIBqIQ4JtxbOGhMDk5EMMhapU6RsTEmeXI7eww/fGHnsvrREwJrBnkcrb0uLcksNiWW00mcTSzIu4iNhK3giU3OsehZD/Wwf51Gw07QUFlyXwEPB21SABgDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4DlPo+1ckcvpWSPbU10ltZWXJG12BV/gObthpCBe64=;
 b=RNfwSWA9EIOB56abt6F0mm4h4n+q32hZ2HPU3dgiVVLlwjN78hptqoVM7aAfM0VCpLUb9jV4+bjMtH7DmSr2MbSKOA2vtpSquVdSFOJ1iJuEWyBFpFN0Ud46CVXd2mhN+Q/L1/rwJ6gJgBVSJRvJIbJrseHVWWUzTRMHaEnL8m1M5qdITg+1VnH08LLKSUbYYj48g65x6r2+mht/5XdsETG7SlAT1FoE3uM8Pwaitj8iXUfk+CJjEHFo7axtrPr682QnhsdcDAb6QORPyCYzbKgA9Apga38k+YcKIR/YyWeMd4g+4Cev5PBkKYEE8usJGk+dNDbInC3EhkiD9yfbTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4DlPo+1ckcvpWSPbU10ltZWXJG12BV/gObthpCBe64=;
 b=dlXovc8RsFAfwO9eYltiXOUUATiwksGOgQCAT7n3yj7ytxG8z3nynGmve3qvI/XHZAvMJdn7a6afxDgjZdjm2+xS1EFSZWOxKaMdMCqktDnr9N5cPwslHe5Qy2vREaFelWOD4/COzYD2T2oQK0NcEGZZDfjiAmSYFtpA/Yo6lIp9lEYr1RYH2oNrvrdsgcsWdomGkEFZ9qtdOMM0x0QrMzO2USn0kjTc3+nOkJQV9UXAh9CF5HPVb/S9hUlcQL8R2D9NO1O3VmOghZfIwubM0KCJHmDPFgIsZ4WRvRDAP3ACgq0o2Hu95OPpnvBMbnLj6aguNWKKbyeGdS96Hmx96A==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by AS2PR03MB9956.eurprd03.prod.outlook.com (2603:10a6:20b:64e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 22:03:22 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 22:03:22 +0000
Message-ID: <785327c7-9d8a-4f5f-b792-4a1590796948@seco.com>
Date: Mon, 26 Jan 2026 17:03:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mkimage: Default to 8-byte alignment for DTBs added
 via -b argument
To: Marek Vasut <marek.vasut@mailbox.org>, Anshul Dalal <anshuld@ti.com>,
 Beleswar Prasad Padhi <b-padhi@ti.com>, Tom Rini <trini@konsulko.com>
Cc: ilias.apalodimas@linaro.org, malysagreg@gmail.com,
 sughosh.ganu@linaro.org, philip.molloy@analog.com,
 marek.vasut+renesas@mailbox.org, james.hilliard1@gmail.com, afd@ti.com,
 nm@ti.com, vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com, bb@ti.com,
 praneeth@ti.com, u-boot@lists.denx.de
References: <20260122172247.2995437-1-b-padhi@ti.com>
 <20260122174546.GB3416603@bill-the-cat>
 <c05217b3-f753-4fd1-9582-921e2cfd3a0b@mailbox.org>
 <b65ad902-2d07-4948-8a1a-64f4d5825a08@ti.com>
 <1e1f2e09-bfb7-4c7d-abd6-25a79271f256@mailbox.org>
 <DFVWL63A8IDP.23PE1QNTXTMRU@ti.com>
 <6cb4957c-7178-4a31-aea9-ad78d6627c28@mailbox.org>
 <ab3a8a36-eaa2-4030-ba18-6c75647455b6@seco.com>
 <6896afd5-76fa-4b1a-abbd-0798f19185ba@mailbox.org>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <6896afd5-76fa-4b1a-abbd-0798f19185ba@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR02CA0140.namprd02.prod.outlook.com
 (2603:10b6:208:35::45) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|AS2PR03MB9956:EE_|AMS0EPF0000019B:EE_|DB9PR03MB9808:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b22cf96-7fd1-47f9-07f9-08de5d26c742
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?U2tlekhpMHNXbzdLa1FjZ1VLbkZEY0tSUk9xcGh6aXFlQUlDVk9tQkVnbWIv?=
 =?utf-8?B?M1NZYVFEcS9vL0g0S2lLTEZhVHJGU3A4Vy9KV1RGVDlkOGhkNEE2MXV0Rzls?=
 =?utf-8?B?YWYySFg0MUdJZS9ON3A3UGFvV2R3QzhSS3FZOVVrcG4rQmNvMzQwekYxLzVI?=
 =?utf-8?B?SHI2RzlsdHJHV0FKaldUaUNUWm5iMkxlRFFweFJEbXdITWxCSmM3ald4RFJo?=
 =?utf-8?B?LzQ1ek1pZzgwNjZVY1ROcDcvd093c2lDcVBXZDZHbXVRNlFwa05VSFlkNGlO?=
 =?utf-8?B?cHFVUGZsL0haSlZHTzBFMVgvaTVWa0tYVittK0hZZ3BqdEVzRXAyNFJ6VllS?=
 =?utf-8?B?aHl1L0d0YmFmL0tvZzhWUlhvYmxGcjZxMUJud3pTMU1vK1pCNTh1KzZETm5Y?=
 =?utf-8?B?OWdMS3RMa0RQL29LamczVFVBWERuUGdnWmkyTlJaYmRoVXFQc1owOHJrVUhm?=
 =?utf-8?B?K2hmTFZBL3pkQ25Qd1FLbkhYSHNJeGF2TE14MGZ1bXpsT1RmbmRKVGR3YW9P?=
 =?utf-8?B?S1lJR29qMnRLS25LcnZZTlorQm5Wd0dIMnlLQjBRTFJDc29NVXlDZkZVK3gv?=
 =?utf-8?B?Q3dMeStDbXhETGdvcHp0MUJZVWIyU3Frc2I2NnZuQ1J6d3JZMFNqYzJUUkpm?=
 =?utf-8?B?NnA2eDJtQUVSZmxUTm5UWU9XcWVyb2pnZWI0cmdiSkQ3eTdtMDlGSjk4RVIx?=
 =?utf-8?B?a1UzaHN1d0UyeHVRVkRlWHVRaWkrSHNVdGIxQzNUTWg2WnlkZDlVYmpBT04z?=
 =?utf-8?B?UDB1Wm90eXZOaW54MkRkMGVZa01xdGgrZ05Jd3NoT2lWeFFVdWpqSmFnS0lY?=
 =?utf-8?B?eXZSWmF2RU4yQUptalVOSTg1dDVaK3lUZG5ZWUxnZUppKzd5M0d2eGU4YTRU?=
 =?utf-8?B?b2taOS8xbkdMZ0lxc242b3AwUDB0Tytpc1ZEUnc4aWdYUFJNOUFocVNBZWsv?=
 =?utf-8?B?WFRuSGxSZlFZdGJKZjcyRFdycFN3Q0c5YkxUQXc0ZFNhbHJtY3MzTmplVWV5?=
 =?utf-8?B?S2hUdVh4dk9VUUw1YzFqMWNCM2hXSHd2cU1iRXBBZzJuZnhGV0tZOTk1VnBk?=
 =?utf-8?B?d0pXTnUrOXBBeHlJUEwyRzNjaGRzQTJKMGMrQzVzb0pzSGVSbmd2QXJ6NE5F?=
 =?utf-8?B?eEExYmN5ZlFybERqVk51d3Bxd0g2Y3hObzZBQTJmdTlnQTVvalJOS3RWTkpK?=
 =?utf-8?B?ck5wVG1aR0ova0xRWE1nQUNzRXdHUHp3YnExQ0dSQTlTWVpwN2VvbW4yQ3Rh?=
 =?utf-8?B?eTFTMy9KR1RrTVBQUmNjUUtTU3VMbDhuWHRpaTBhRE9vU3pjVHRVL0lzanVJ?=
 =?utf-8?B?Sk9JOFU4K2VXWlhIMVhVd3ZLZmtvOVp2aVRFTVY5VFgrNi9EUlBNMXQ3RVNP?=
 =?utf-8?B?c0R6U21EN0h5Si85OTNCT1JtdUFoZnRJUmlCcnA3YkJ0dHBYdUxZN3IrcldH?=
 =?utf-8?B?QU1RdzVpUHBLSjV0Yi9OZ0RYRVBEcDVCQ0lwN3lUL0tSb0NrdjY4UXpMb0kv?=
 =?utf-8?B?WFN1UG9CWUhxM2E2WGt1Rmo4blEyNzRvTFNQZ0JMd0xnTEo4YXZ1NDFaSEFa?=
 =?utf-8?B?MGp5K0VIWERjOFZsOGoyRXF6TUJ5WHE3Mmt2bHlMclhsWkVCTkdDS01vajNN?=
 =?utf-8?B?eVRvYVYwcnh0R2FrQ1F1SnFJWVZHR2dLOGJxSTdoUUE2RzhsU0RIYUNGTVhn?=
 =?utf-8?B?elhZY2FHdG80TTh5dGdXT2dWZ0RyV2luSmRGU1BVZ2NyaDlUQ1FlYXdTbDZC?=
 =?utf-8?B?UEdRczBTWXUzeWw0TUljQkJ1ZTVtaXpFQWpNMS9kbUd4THNYRk5xbitMTG5h?=
 =?utf-8?B?MG9Ia1pVUTJjWWNBZnp3Rnk1WFhERkRrUlc2dWdIYm1ub3o3NlVRUSsrSm5O?=
 =?utf-8?B?M2kxUDByZ1poOFR6WlRNMytQT2JPa2FaL1NWclRQVGR3UFBMUVgvOFRINGtG?=
 =?utf-8?B?bnB5UVFFUmdyTStBcUdYa1VRUC9FUDBuZ1ltSmpteHUwTUxsRjNOcWZjTzg1?=
 =?utf-8?B?Z1kxckxXSm5RbEl2ZFdVNWFuamNQUm9VaWFlV3Ircm5kQ1o2QlNZZXdCYWlz?=
 =?utf-8?B?MzNGUmltVmVHRmU5Q3FMQldta1NvM3didC9rWnVOT3hncEVzcmFLVTFBeWFL?=
 =?utf-8?Q?zCSI=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9956
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c70cddd4-af40-4c91-108f-08de5d26b87a
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|14060799003|1800799024|35042699022|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MG8zS0E5T2FGTFA1ZUJJejlkNHhRUTNwdS95dWtlMlFUTi9VMmxYSU95Ky8z?=
 =?utf-8?B?aVRwTG0xNHg5UU50bXk5UGZxZUNwYXN6VGl2Qk1lejBXcThHNmhHeFlQN3dD?=
 =?utf-8?B?SHZGSHJQb1Y2Smp2THArbmFxMUFIMWdwcDVzTWJzcW5ldmczNURwTVUwTkor?=
 =?utf-8?B?eWZhcGk4Y3QyZVJsT3pDVFllRXUxbFhxTkpOcVNHQ2lpeTZac25Qcnd6NU1T?=
 =?utf-8?B?RFppMEtrR0VZMlU1Y1RZWHg0UGFjNVp2djFad2t0TVcvNE52RzE1U3VEOGdF?=
 =?utf-8?B?RGhzd3YvRGllMGpuNjlCV3Nuc3JIdDhrZUV6OTVxaElTK2tzTFhnTlRxU0Fy?=
 =?utf-8?B?ek94WllxMFEzSisweHNVSkVxK1hqeGNrNmlGeisreXZQc2pRRmhYN2xSOUFM?=
 =?utf-8?B?UkFGcmdyODVmZVdnSlQ3ZnZTSFhONitHaWlCVTk1N3pnbjl4cHV4K0pZV2sz?=
 =?utf-8?B?clAvYUNoK1ZJc1FGTTRNckdlMWJqTDJjS1Q5eXRudXQ5UFdxeHZqdWZ5NVMw?=
 =?utf-8?B?Sm1XZzhvcEZDbjJFMm5ZUGYzSHQzODMyS04ya3pxYXlKMmdYK0tEdi9EV0Vr?=
 =?utf-8?B?VUUwZkd2SFZHQnZBcjcwdlBXem02a2tlcEV4UnNnbUJJLzdOWllWU0o3ZCsy?=
 =?utf-8?B?OXd0ZlpZbjFySjRaWWt6dWpjRDQxOVhINkNhZWFSVnFYV0dzYmc5Tm1aWVNx?=
 =?utf-8?B?WFpFM0svS2I2N0xYdElLNGFCUXVpaTUwYXh4SlJZWFp4dlpaNVY2SDB2U3d3?=
 =?utf-8?B?YjJmbDdyQjQyV1hqSHU4RnRYUGF1MTVUeUYzQkFMNHgyK0JPRkk1RENwU1l1?=
 =?utf-8?B?Y285bjUrampLZ1pwbEtEZkIyM0tUSXY1QlJtMU43L0JTY2o1WDFQbWk1WktZ?=
 =?utf-8?B?YzAxd2twbElxTkpTajZDdUJNYmV5WGJNdllNWWg4SDhLN2JBYVR0V0RQM1lo?=
 =?utf-8?B?NkI1T211ZERUakQ5UXlYN0FYMmxtRkJlVWgrdVJMQjJ2YURlUmdhM0lYeFhD?=
 =?utf-8?B?S2lVTWhlWkx5WGoyYnM0cCtIVWdnTGd6SlB4RjhuOWZEYWkzUG1MbERMdnBL?=
 =?utf-8?B?bzJKR1hra0sxb0Y3NzFjaDFmelk4enJ0SllueVI0R3dEWlo2c3p1MUJnZWpF?=
 =?utf-8?B?UUNSbjJVWjBKN0ZneVhONkt0KzAxWXVuRDFwQzZ4V0ovQVMxMkFsdHZMZFpk?=
 =?utf-8?B?MVUwQjNmU0YvdWtRdmZjRW9iVkxsTFVUaGpXYUd1UFVGNzZVdWhwZ2k4bjRE?=
 =?utf-8?B?MEpMVXprM1RUY1pGV0hEV2NLVmtORVdjOFRINnV3NHN1emRzRTZ6S0RvdXBH?=
 =?utf-8?B?RmJBbEF6cVhuMHlMajFzWHBlbDh0NjhnMklRUndPeHhMVU9kMDZQb1cvQjFT?=
 =?utf-8?B?V2pDbXJzb2QzaG5nK1U0VkVNbjlGaWJrMHN3MnprVld5bFdSU0krUjNkQXd5?=
 =?utf-8?B?SUZPU0pic0ROUElrSzVnS0hWcExrZkQyVDcvSVBzdXBOaUtnbEZPM3lmVjh0?=
 =?utf-8?B?WU9aL0hYd2JIZDA5SDNUR0hEY1U3amFNSndRWHBEQ3dKUnVuKzA4OHhvNFlV?=
 =?utf-8?B?K1JRZWNZQkFKNEUyYUhET1BlbEp6Y0dTL1M2dUczYWlWRkFnOVBoajNiVVg3?=
 =?utf-8?B?ZjhMK25BdXEwT2ZvaG8zMU4vQUxxSEhNRE95dEpOMVZWbE5YZERvZEIvc0E1?=
 =?utf-8?B?aTJOYTNScUJucHgzRWFMbVZ5MTIycWFkd3gyUDJqeXdNWnR0bWo4dUxWNUdT?=
 =?utf-8?B?eC9oeXhnR1NFcGJSSnByd3MrdnNYVUl3OTVaU0RuckYrMGJMK0Z1eitZdnZD?=
 =?utf-8?B?b0lETk9LL1h3ZnBLQy9LY2hCeDJtcGVFWFFwWDNzWUdsUUJkR1NTcEQ0Q0pW?=
 =?utf-8?B?bURjTjdubE1od1JpYTF4RTA3WVFyeFRvNVhrR0Y5UXBkSm1pSFJITE5NNUtN?=
 =?utf-8?B?cWZ0eGo4T0xndGE5cXV1aVNUOGNNZ0x4SVpDeHlDMzYxLzlhZVdRM0plWjZa?=
 =?utf-8?B?T203Ylh5elFOUnQyc0NYejNQaFRYRlNtMDdmblN1ek51RW56OEZtNGlaL1cr?=
 =?utf-8?B?bU5pRzdFb2VpRnd3bnRLZDVZS2krZHN4RWtPZkdXL25GSVJ1TUUydHIzRnkz?=
 =?utf-8?B?L2M4WlBpNXFIbDVpeHJJZXJiUW5STjlLc2hGNHVIMStpVXRQc2RFRWg1emVG?=
 =?utf-8?B?UzlScDBKZTVDdjV3dlZtc21ZOVpjb0psdkhqcWJaSmRienhNcjBxaFB6SzA5?=
 =?utf-8?B?RVlYL21JWC9uTGk3cXI5MnZyaHN3PT0=?=
X-Forefront-Antispam-Report: CIP:20.160.56.82; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(36860700013)(14060799003)(1800799024)(35042699022)(82310400026)(7416014)(376014);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 22:03:46.5892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b22cf96-7fd1-47f9-07f9-08de5d26c742
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.82];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB9808
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

On 1/26/26 16:50, Marek Vasut wrote:
> On 1/26/26 6:38 PM, Sean Anderson wrote:
>> On 1/23/26 05:51, Marek Vasut wrote:
>>> On 1/23/26 11:40 AM, Anshul Dalal wrote:
>>>> Hi Marek,
>>>>
>>>> On Fri Jan 23, 2026 at 3:57 PM IST, Marek Vasut wrote:
>>>>> On 1/23/26 4:32 AM, Beleswar Prasad Padhi wrote:
>>>>>>
>>>>>> On 23/01/26 00:33, Marek Vasut wrote:
>>>>>>> On 1/22/26 6:45 PM, Tom Rini wrote:
>>>>>>>> On Thu, Jan 22, 2026 at 10:52:47PM +0530, Beleswar Padhi wrote:
>>>>>>>>
>>>>>>>>> When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees a=
re
>>>>>>>>> packed inside the multidtb.fit FIT image. While the individual DT=
Bs
>>>>>>>>> and the FIT image start address are 8-byte aligned, the DTBs embe=
dded
>>>>>>>>> within the FIT image are not guaranteed to maintain 8-byte alignm=
ent.
>>>>>>>>>
>>>>>>>>> This misalignment causes -FDT_ERR_ALIGNMENT failure in
>>>>>>>>> setup_multi_dtb_fit() when locating the next available DTB within=
 the
>>>>>>>>> FIT blob and setting gd->fdt_blob, because of the recent libfdt
>>>>>>>>> hardening since commit 0535e46d55d7 ("scripts/dtc: Update to upst=
ream
>>>>>>>>> version v1.7.2-35-g52f07dcca47c")
>>>>>>>>>
>>>>>>>>> The mkimage tool already supports enforcing this alignment via th=
e -B
>>>>>>>>> option, but users would have to specify it explicitly. This chang=
e
>>>>>>>>> makes 8-byte alignment the default when using -b.
>>>>>>>>>
>>>>>>>>> Reported-by: Anshul Dalal <anshuld@ti.com>
>>>>>>>>> Closes: https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktim=
e/v1/query?url=3Dhttps%3a%2f%2flore.kernel.org%2fu%2dboot%2fDFJ950O0QM0D.38=
0U0N16ZO19E%40ti.com&umid=3D003810bd-b0e0-4a71-9348-75ffbe5cbae5&rct=3D1769=
167692&auth=3Dd807158c60b7d2502abde8a2fc01f40662980862-3859cf23dac8d65722a0=
a9ed4c40c98c98a297de
>>>>>>>>> Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version v1.=
7.2-35-g52f07dcca47c")
>>>>>>>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>>>>>>>
>>>>>>>> Tested-by: Tom Rini <trini@konsulko.com>
>>>>>>> Doesn't this enable 8-byte alignment for everything in case a DT is=
 specified on mkimage command line ? That doesn't seem right ?
>>>>>>>
>>>>>>> If I do mkimage -f auto -b ...dtb ... , then I only want the DTB to=
 be 8-byte aligned, all the other blobs can be 4 byte aligned just fine .
>>>>>>
>>>>>>
>>>>>> All the mkimage flags are parsed at once and populated in the params
>>>>>> data structure in one shot in the code. There is no separation of co=
de
>>>>>> specifically for generating a FIT for a DTB vs for anything else.
>>>>>
>>>>> That does not seem to be true ?
>>>>>
>>>>> $ git grep -p '\<bl_len\>' tools/
>>>>> tools/fit_image.c=3Dstatic int fit_extract_data(struct image_tool_par=
ams
>>>>> *params, const char *fname)
>>>>> tools/fit_image.c:      align_size =3D params->bl_len ? params->bl_le=
n : 4;
>>>>> ...
>>>>>
>>>>> So something like that may work ?
>>>>>
>>>>> "
>>>>> diff --git a/tools/fit_image.c b/tools/fit_image.c
>>>>> index 0306333141e..0c606ba4cc3 100644
>>>>> --- a/tools/fit_image.c
>>>>> +++ b/tools/fit_image.c
>>>>> @@ -642,9 +642,15 @@ static int fit_extract_data(struct
>>>>> image_tool_params *params, const char *fname)
>>>>>            for (node =3D fdt_first_subnode(fdt, images);
>>>>>                 node >=3D 0;
>>>>>                 node =3D fdt_next_subnode(fdt, node)) {
>>>>> -               const char *data;
>>>>> +               const char *data, *type;
>>>>>                    int len;
>>>>>
>>>>> +               if (align_size < 8) {
>>>>> +                       type =3D fdt_getprop(fdt, node, FIT_TYPE_PROP=
, &len);
>>>>> +                       if (type && !strcmp(type, "flat_dt"))
>>>>> +                               align_size =3D 8;
>>>>> +               }
>>>>> +
>>>>>                    data =3D fdt_getprop(fdt, node, FIT_DATA_PROP, &le=
n);
>>>>>                    if (!data)
>>>>>                            continue;
>>>>> "
>>>>>
>>>>
>>>> I just ran a quick test with this diff and it seems to fix the issue f=
or
>>>> us. If it's okay can we take the change as is.
>>> I think the strcmp needs to be some strncmp and check the 'len' too.
>>>
>>> Let's see what others think.
>>
>> strcmp is fine when one of the strings is a constant
>>
>> If type is shorter than "flat_dt" then there is no risk of overflow.
>
> What exact data would you be comparing here , the constant and something =
read from possibly past the user supplied "type" buffer ?
>
> Some validation of "len" has to be done before it is fed into strcmp() he=
re.

Well if you are concerned about lacking a nul-terminator then we will
read at most 8 bytes beyond the string.

The other thing that can go wrong is if we get something like
"flat_dt\0extra data" we will match.

Surprisingly the closest we have to this construct is fdt_string_eq_. I
suppose this is because most strings in U-Boot are guaranteed to be
nul-terminated.

--Sean

[Embedded World 2026, SECO SpA]<https://www.messe-ticket.de/Nuernberg_SHOP/=
embeddedworld2026/Landing?code=3Dew26561753&returnUrl=3D%2FNuernberg_SHOP%2=
Fembeddedworld2026%2FProfile>
