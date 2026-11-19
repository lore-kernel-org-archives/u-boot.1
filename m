Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCE6606A32F
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=clgbrWUE;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=bLBSqO7k
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7AB6F406D6;
	Thu, 19 Nov 2026 12:09:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ns1KA0c6mU_t; Thu, 19 Nov 2026 12:09:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 706DC405F9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795090184;
	b=OBnicJikH1wln39+rYMKL8tqN45C4m38pGjcUZx5qac6vFhTGcy/wY729gE+ObnET96R
	 j9e9kLcGECbpmaQ2e+/pAijvULCzhh04xdAIQfmh8PvWW+b47O/YTis70mvOVtpqQ9shR
	 YJxu3jPCR26TVe/Jt1hQogYM+3S6BKiz297VdiUfruUhmZe3bKd4M00mav3t4YbwL3CWx
	 HgkKOi3htDVL2m4uwE8bF/RcHyhHUch31E7zFtlIluJeV6Zar04bUPb0Pi2ZhVzqdr89v
	 1eytMNpDaMdp9wGik+WZst7/88mF+q5t6Ji8pgHWU75F98m9U4xAGccf5TUvYJ61u/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795090184;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zWb4fBbPAE4zmfCVyFIvU0wTZznCoMF3xCN2dNH2yBg=;
	b=Pd/Tm8ySpwQkMLgFggdUI9ACq1oMTOglAurLrbYdhtg2obvzstunetnIV7Ha324vRNm7
	 TEoRVkBDe47UKhlmJo2vCT60WSTJF2Wm6Iu/YmovV8/zf6FyNqiB/BajOSCXl1SCCP2nX
	 1yeNABl+qybAT4kv6HNAr419H1HO6l/KFv2F+8XX4bcnIGytiGZf3pJoLemfnJcBkzvrY
	 sCEjFBNvafj60UirkYYrbO8qhGsTHL1c828vaKlXNdT7DXzYxQfGOlY3xVg/qjLVqn3M1
	 Qp7YiwAVVvgypSfO6iZ1K0LN0Gcc8pGTpFWoOOQGSAbQbyKQ51GgUNEJgC76PGqRzsA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795090184;
	bh=zWb4fBbPAE4zmfCVyFIvU0wTZznCoMF3xCN2dNH2yBg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=clgbrWUE9hDgRfKUCS2UVCHDA2WavvlVHVLDfE+AyfrTK9+WuqtiSTJHfu7teDq+n
	 OvSuVW6LLLkv82goSKrd7we6SSxRx4v5nAVlJLVZzMerbEbV1gBZtedA5nj5qpvcYX
	 oM8X/g4J7uT3ECajUDkJcDnNS/9WK1ZURVhV/SDlhkHobDgc1ddwQ2SJnnqSl8y0ne
	 hUqPLS7rrYzKpj+DPLOiK/vCQNgptfJne5EElsxCOpWDkOSSKelu8imVfAVOb+M5jv
	 C/PYqitQBl4Hcos9JrTydaQAkeszccHl7XXPJTGWAqeuz0e5EUN6d8JAxuq7juTnOw
	 2ZZ0KGdBBlBTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 706DC405F9;
	Thu, 19 Nov 2026 12:09:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C1BC2FB
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 12:09:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 599D38100A
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 12:09:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tPV5403yT4XH for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 12:09:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8037A80F20
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=bLBSqO7k
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8037A80F20
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 12:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWb4fBbPAE4zmfCVyFIvU0wTZznCoMF3xCN2dNH2yBg=;
 b=bLBSqO7kZtWUnsycDVUpM9O3IZ5tQkn09Tl6xJk17q+NW9uuAxTKyWyW+bjkiTRq9JJ+/Jem9/Kb3HJ3lxgKK6zVvkD7fe1oqFynddX1ChKIoGRuNwxF5/eOG0A0DSCK6px3w7IYGslvhyfP/l3ZqmZR5hCSM1mWGT9tBEsfPh4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by MI9PR04MB849679.eurprd04.prod.outlook.com (2603:10a6:290:bb::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 12:09:36 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 12:09:35 +0000
Message-ID: <b8265298-9120-49ae-99f0-b47941e33616@cherry.de>
Date: Thu, 19 Nov 2026 13:09:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] ram: rockchip: improve sdram type configs selection
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
References: <20261116-ddr-multi-v3-0-fe9fb30a3169@gmail.com>
 <20261116-ddr-multi-v3-1-fe9fb30a3169@gmail.com>
 <469c26c9-c2cb-4007-abf9-5fdf5ea0acde@cherry.de>
 <CAC928HZGjwUzVcABE1TK+-nij_8C2f=xKWHNDAQpO=9RRu6LsA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAC928HZGjwUzVcABE1TK+-nij_8C2f=xKWHNDAQpO=9RRu6LsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VI1PR03CA0044.eurprd03.prod.outlook.com
 (2603:10a6:803:50::15) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|MI9PR04MB849679:EE_
X-MS-Office365-Filtering-Correlation-Id: 36c69278-9952-4509-c57a-08df4635fa49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|10070799003|366016|1800799024|6133799003|18002099003|22082099003|4133799003|4143699003|11063799006|10067099003|56012099006|261022075727099003|261022115727099003|261022105027099003|261026130827099003|261026140227099003|261026121527099003|261022113327099003|261102123227099003|261028144727099003|261026135527099003|261021135927099003|261021133027099003|261021130227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: QlFVEfHSV0UR1kta8cyNamBJP5QUHX6/SNv2CP2ZR+599RKkuvtkACCdpwW4p9AI/mhV/yUH3hLI8itKFA4zyNQLPSa6UThmzRcoxxVQ3Pm2sKIWlqaIne3st5dZP03KPnnb8iAvEiI0SmGsXY1zQ+htbt4qn+YfFfPf9PGlqE+rYrRMuWMKm97jQ68Eln6/FG1RFcSaX90YKVaJrq9KzGz7YU4y5Rtf9bEXV9ZueKPttJcSK8YI6VpEt+RbJKRkdwarg/oOJi3jpp0J7QRUEBE/001ACbZaEcJ9JDAIKUKSZjP8+DlKAPHvnjTh3t8tFq3Qifxi/8N0alTtthNttwoP6rGjk1Nwdj1kLrzzRvGnCdQ4a0oerWa8R5T447qVsl8Dm3UhdC+cXAB4UFk1qi0qi+DJ4C4KNl1iRwhqkesaOkbi35xMcsoaJqLJNkfPKhxc0ivBKXMUq/QF+xm35gw3tse0Xvkvk35W3cFWhHbg3z5uj2bkG+m8jBMhl0gap1Kd8crtrceuRjbpRBNusfC7eUYybaxsXWOzQ4innKhJWq3h3anAyDfOD3edfOctO0ny+jiY9QlnEK8Op5a24S1HKtbaFJ+PMth118Fnalk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(10070799003)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(4133799003)(4143699003)(11063799006)(10067099003)(56012099006)(261022075727099003)(261022115727099003)(261022105027099003)(261026130827099003)(261026140227099003)(261026121527099003)(261022113327099003)(261102123227099003)(261028144727099003)(261026135527099003)(261021135927099003)(261021133027099003)(261021130227099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bSt4cmoya1B3RS9aMUh3ZkxKUjhUdkorYldjU0FjdVpuNmRseDNydkxiWEV3?=
 =?utf-8?B?dHREVGl3ajBjSzVvemZQMjlVOFJMY2YwQ0dCZ0Y2ekZoQ0ExM1ZkN1ArVHpa?=
 =?utf-8?B?YzBZeXlaN0hnSXd5SGM2c2pXMk1hVmxqa0tHUDVZV3hzb1ZtUHY2QzQyQVk3?=
 =?utf-8?B?MGdJZUdKM0l5Mk5vRDZBT1J4ZTN1QTFoVzlZcEVaeXNKc055TEpBUHh0cUtH?=
 =?utf-8?B?VlJybDRQN1JQakxRUGpGeDczKzNucmsvSnBSVG5aSHdjcmNNZnVuMUMyU0V0?=
 =?utf-8?B?WHZTcHp1eFhWMml3Q1BTYUsxaTRLamlFTVh4Snh1RW5ySCtBTlNOdnA0aEZx?=
 =?utf-8?B?ZVF1cTBxSCtoUlN1QzJmczdIb1ZPaFNaQXFTS25ISFJUMk0rM0NMVERIblY5?=
 =?utf-8?B?aUVRMUlmcVExZUNTWStLS0d5RDN2WXNUczQ0cFUvYTRxNHZ0bDMzVDA5NTdN?=
 =?utf-8?B?MkxhZTNOVnc1Ym9YUDlxR1Bud3UvRXVoTmQ0ajJyd1RDT1c4MEFoNDhGSVJu?=
 =?utf-8?B?YkhYVFQwSHFGSUVrci9jYS9OZkFmSDRGRmo2eUFhZjZZWWFIUkpOWURlY1lC?=
 =?utf-8?B?eXE2dFdLaVhkdXJMZXF0cE5PZGhGQXRYYmpGcy9EcThKdXIxNkxGbWdpVCt5?=
 =?utf-8?B?Ulpkc3VmVzVROWt0aExEMzZMYzhjeWlqUmY3a3NQZWgvMlF5eXFZWjAwSWw1?=
 =?utf-8?B?TDNRMmQ1RXZYbGhuOXpSV0xGL29qOXZHUm9CRm53K29WTEhQUlYrN29rckdy?=
 =?utf-8?B?NDdwTXJlWS90MzZaM1E2aHhXbUJ6RklhQllBZzc5QXNMWE5XbmJYTm96VVVE?=
 =?utf-8?B?VDVlTlUxeFVZbWNJU2VGQjRSdHpsTGhWV3BCUEQ5NHd3N2JQdFkzcUZFRUtE?=
 =?utf-8?B?VjdURW8xTGdINkdxdlpkNzNzeUF5V0ptTm1kSkhOSko5dG5QbEE5RXlBRVZt?=
 =?utf-8?B?djA3cEhKa2JwTFg0ZDBGVUpUNnhtQW9wZ1hvNDN3SlVjYnFzYjRaQ0MxKzNn?=
 =?utf-8?B?cXY1bmFSMVdNNmlLZFd2Vnd6cGdhN0FHMUZlZFl1aVFHRFd4bjR5Um84ZjY5?=
 =?utf-8?B?Ny9MZXZ6dy9sODluczZ1R2grLzhoMHMrN1FMTXNkK05uUEdTMmxKMnhaMHAw?=
 =?utf-8?B?am1NRkdSTUo3aGJuVXJkbFFwd25mRzdoTDBZN2NBZENzeEE4TEFqb0NibnBj?=
 =?utf-8?B?Y3FWRjNrYWlEOURERWhmajk2eDd3RThWUHpFR3RmeDJVV20yTVZRaXBzQ05Q?=
 =?utf-8?B?UTFJYVo2azMyOUdRSmhucC9XZ1RjSEhsTUtBUm9BMVcrdys3T3ROc3NQNy9F?=
 =?utf-8?B?WHhBaE85Wnk2cUVBdTAwczNqOGNVRnE3WFRSQTNqMkxoMFArK1VtRGR0TGow?=
 =?utf-8?B?SVFzRG9BdkpoMURreVU4aTQvcEFNTmxqSWpwTmxsVE1IUXF1TWtGK0c2Y0RN?=
 =?utf-8?B?bCtiSC85UXM4a0hucjltY1J0UWl3OGh0ZXBFVkJ1SGpWUlFSVG8vTnFJSjBZ?=
 =?utf-8?B?eU5Pa21zVDJ6RWtueFJIM00wd2w1dVA1RzNOWmdiWHVMTTd0eGxrUmtrTmZ2?=
 =?utf-8?B?U1E3NW96ZEdpSG9lZXQzNjM1Wmo5dmREZzNIRk5mSVl5dDFvRDRMRDBSVmcr?=
 =?utf-8?B?cjRFS280VkI5ZTVlcHFvQTY0Y3VjYXdkNERydWYvRXZNZ1NQT0hpZTBxdXMx?=
 =?utf-8?B?N01yZEZmTG1idk5kTmdTQnlERThId1BZSisxNnRoclBTSnJTOWkvZ0FObGZx?=
 =?utf-8?B?VU9zMHN2VXFYV1NWbHVGSW1xcDVWb0FZaDdSUDh2RHZCczU1OHFzSEdRbWMw?=
 =?utf-8?B?eCswek9IbnBtNVFPcFhoZEkvVURtRlltNFpKclZ4eTd0VGswbExLWW5SemIy?=
 =?utf-8?B?NnNzdnhOQnVkL0dybmhhNktsd3M0RXJ1UWZuRWt1MDVFdUFuSmFGbEFvWVgz?=
 =?utf-8?B?S29HNlRaeFkzUlhDb2F5c3ArdVlEb2ZGeG1CWFNsVmdXVGJaN2dobDVGWmNk?=
 =?utf-8?B?MEZaY0h6alRXSEhTNkR5MVlENjJ4NkFIM1VyMzBOMDRkeTV0VmZxc0RqQ0VZ?=
 =?utf-8?B?aFdLOXFWd2tsZHA1TGhISzRIdXFQYWNrOStHNHVsTUwvMGhRdmV0MTc1bFN6?=
 =?utf-8?B?dFg3TW44NGtxR2VWQVRncENYSkt0OGltSytXU2Y4VEZ4Unk2QTNsZUI5WVow?=
 =?utf-8?B?K3ZwZHNjQjBvako5dG1ENmZDNDVJUjFlZUliTFRJS3Fubzl3WjV6Q3R5MDQr?=
 =?utf-8?B?UDU3eW8xR1VKYVQrVzFzcDcvZXhid0w5bHpOVWtXK3kvY3NkYktUZFlwQURD?=
 =?utf-8?B?TjdiOXBsUkEyTWtnU2ZUMEtudFpnSEptcDQ3UVo1TWRiMmp5aVBpS0Q3Vm1m?=
 =?utf-8?Q?AM12wUAcDwE0miTQTMI3vm501D8y959MOI3vu2n+L9zTH?=
X-MS-Exchange-AntiSpam-MessageData-1: 6cc/ydZhfhbNnQLJOh1wwP9Av3bE4z46ajI=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c69278-9952-4509-c57a-08df4635fa49
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 12:09:35.7798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d48pcceAZvKelnqPUApHp34U8QKQi4CV1Q+fZmBBRgX5+WZU1EO0cY+87M1g6W7WNmIkNgFk/OaxMfM3K7F08L+cDIeoy2tTO3jdZjUzVeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB849679
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

Hi Massimo,

On 11/18/26 8:25 PM, Massimo Pegorer wrote:
> Hi Quentin,
> 
> Il giorno mar 17 nov 2026 alle ore 17:29 Quentin Schulz
> <quentin.schulz@cherry.de> ha scritto:
>>
>> Hi Massimo,
>>
>> On 11/16/26 7:39 PM, Massimo Pegorer wrote:
>>> Not all the SDRAM types configuration options named in the Kconfig
>>> are supported by each of the Rockchip SoCs: improve clarity adding
>>> SoC dependencies to the options.
>>>
>>
>> Considering what I said[1], I'm wondering if we shouldn't simply report
>> what the driver (seems to) supports even if it doesn't actually use
>> #ifdefery and the symbol state has no impact on what will make it into
>> the final binary. I haven't decided yet, so this is an open question
>> rather than a suggestion, and this applies to the "thought: " comments
>> below.
>>
>> [1]
>> https://lore.kernel.org/u-boot/9d263ab1-5880-42d0-afc8-2f2ebdae4a95@0leil.net/
> 
> Happy to discuss and share opinions: hope others will join, too!
> 
> I would start from: "What is the purpose for?"
> 
> I expect a config option value to change the final result of the build. And
> I would prefer not to see any config option that is not relevant to what I'm
> going to build, at all.
> 
> As an example, if I'm building U-Boot for RK3328, what should happen if I
> choose DDR3 or DDR4 or LPDDR3 or none or any combination of them? The compiled
> driver will be the same in all cases. Would you like to raise an error if none
> or more than one is selected? Or instead, should the ROCKCHIP_RK3328 config

If none, yes. If more than one, then no as the driver currently supports 
multiple (just configured via the Device Tree instead of detecting which 
DRAM is populated) and there's no ifdefery so no point in failing.

> option select all of them? In any case, the DRAM params will be defined by
> the Device Tree, and everything will work even if they do not match the
> selected option.
> 
> In the end, the only purpose I see here is information and documentation.
> I do not think that doing this type of documentation through config options
> is the best way.
> 
> But let me know your reasoning, please.
> 

Mostly informative right now, however we could also decide to use that 
as a way to trim down the DRAM drivers with support only for what the 
user requested. If the DTS then doesn't match what's in the driver, of 
course DRAM init won't work. There are a few if blocks we could avoid in 
drivers/ram/rockchip/sdram_common.c for example.

Cheers,
Quentin
