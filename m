Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135A9606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V8ahmFSV;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=FWx9wYyp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDFD540D07;
	Thu, 19 Nov 2026 17:16:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XelBdufcu06k; Thu, 19 Nov 2026 17:16:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2879540D09
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795108587;
	b=fQhuqqN2s5NXHChexbwivMH2gsGOk3RrjknjtZiki84U+3nSJSj/Ajx12icrUsr1Dycu
	 MpHQ6B+Ctee9SaCiMW1+sMwd5RJNWq+co0vN/F8hd/yDPVOPOa6znH0mTqXZ5DSdQIfVg
	 iTnHFtHg6HtMWrz1pTK30rDqd5cpt+QYMdlIXhC/nd813k1XO4t/XDdVYCW0gkcwMSr8t
	 kWNiIAajaoZLIez0aQY1rPoTdagcfJw/55duQNZrnJFRuKJ1EurYptPMLXMDaA3t2/tHX
	 CHNGn+lGCbCn8+WbCCNECSIXHpEFn2iw0YDoYTO902LP/J9SJWuq1a1EpdUjitSBhKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795108587;
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
	bh=2LKdWufngdD2/+INKQgJyQ1Jypwi09SAZibOnEHgrZg=;
	b=nwdMFBcXfkyrw2JEZkAK8Olc357Mx1j0RvNZId/9Dwsz7d/8OLiMAOn5A6qWXCPevLKo
	 ritkycr4rWMZy6nP5Tya9vTpg/2ZF3li+W4BHYB3cnTRkLnjBAzFeLo2V5FdW9SOOhkdC
	 GUOjjJOujgVMvMIq9wpf7wZtA0rVZfskoLt9iCHFdHF6GS/cOedqIuT8ymkhksx0yXYrx
	 CQQ429T1yiJ8w9MOwEeIR3tLnVxAgcpN+plmaz45nEWAPVu6eDV3dUSDaxe1ZSH1hNDlD
	 JN9t3QfX8ZqQ7VB64IOJArVHRXdFsX/2ZS8nyDDzXPN/FKB54mAcG84UsGv1lo68dQA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795108587;
	bh=2LKdWufngdD2/+INKQgJyQ1Jypwi09SAZibOnEHgrZg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V8ahmFSV0cA6AQ2exP3vzovAndUP2EXRQIvwkuUajwCJhPCWD0amWqGqvfQl45ubF
	 Tmg5gr4thKkvkPaKpRNOQfRSdhrYjGQ0lRxn+VXzQozMqlJ6sCjd+fBQkV8iZ8DQgq
	 07kqSf8+356DpiU9TWrWU30LnUaCjPydql3qIae8WHBqh+Inj9Q3Ws3ztapn2htj3/
	 JgDD+kT7yo2z0FPQoujFKtWZlg2m69WlznfsOUtY7RhqPttR8Yilt1rbLtXBjpV5Py
	 5KBrF9WmNmio59qebuze3InjINhCOFGMDUHpeFJrkoYYYkNBDeK+1OGVwGhcPUOPiS
	 sNrmplTgnzo+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2879540D09;
	Thu, 19 Nov 2026 17:16:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B5D453A8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:16:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A7BBE401C8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:16:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id asII_8vXaVsf for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 17:16:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DEBAD40180
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
 header.s=selector1 header.b=FWx9wYyp
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DEBAD40180
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LKdWufngdD2/+INKQgJyQ1Jypwi09SAZibOnEHgrZg=;
 b=FWx9wYypJqYauEpfOLHWxA7xQfOX4F1hJO1Sg7a+wjXqTD/fxmUJTuSF9ysXqk9W9lml7jbPbLAB7jvljmx4bfOdXDVgJ359XupDyJSeUXaqs4pjYKb7OefyRUkYTrBH8d6GggdNPed/LAdHzm93Hh6RyuJ8KLNkToSdReyvIFM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI0PR04MB12134.eurprd04.prod.outlook.com (2603:10a6:800:316::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 17:16:20 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 17:16:20 +0000
Message-ID: <26670f1d-1fe7-40a4-bac7-0b5703977d30@cherry.de>
Date: Thu, 19 Nov 2026 18:16:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] test: Build mkeficapsule in tree used by tests
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 u-boot@lists.u-boot-project.org, Kory Maincent <kory.maincent@bootlin.com>,
 Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Alexey Charkov <alchark@flipper.net>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marex@nabladev.com>
References: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
 <20261116-qcheck_fix-v3-10-b6cf7e96944b@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261116-qcheck_fix-v3-10-b6cf7e96944b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0015.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34e::16) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI0PR04MB12134:EE_
X-MS-Office365-Filtering-Correlation-Id: e77b0971-55fa-4bdd-a5a9-08df4660d401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|10070799003|261102123227099003|10067099003|261026121527099003|56012099006|11063799006|261021121427099003|261026140227099003|261022105027099003|261028144727099003|4143699003|261022075727099003|261009223027099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: EbjSX1ii524tUP09RMtBpe3te4ibDsYSR0UTtg+EdtoZEJ5APhHOgSkuQHzG9vrXyihYo7JMRCUp/PtvH6Y57L4RNwMFD9menS/piE0GS7F5XI0JWuybmQPBuTqnBLPQA8r8cWs+cL/q0ToWgzH9MlxIJwQSKK/Jajbm9CuL9E7P66mP5fbff3K98dy2jRkb3AAzQimNFY6/uVzTslg/U1ecR3w25ttri8v3CabNyxrn4+J7XhKARTTU7EgbfpjnmnkbNVo0AFSKh5fquwqxkcUjVBaE2CvtzjA0RyfkM1FWqsveesOVEnRht7BPJbk+Mxvu7am6i6jzHWdjJ3FX9u6Zp+SYocXxOU5Zkx8TFggHM5/aMASDXDxuFy/00Lmo82IWZofAtTlhRqfZhJoVA5rpT2Gp9oWcTBlnL2ouJt+Mz7ecYWT+05WBeQe7HE+k1VV3A6X6NPZIPvYO2qHg93Ysl+Ns1QNoFwtC3f31sZe0LZJI8Ba46KRIjVL0yWQLxnyKxt35xL8i+6jD3XgQp9COqOPpCb6kNCg/xNl+b3/RNIcQsc8+U9tSDtcJ1aV7cj2t4pesgNELHbHpAkpF+gPXVgL6vHseoBA5qdXrluqYsk21qIi2RFk2Ts4QMQB3khzyRVcMEVTLVZ5lYPFDWTMz5kHYrA512XSCBb/kQKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(10070799003)(261102123227099003)(10067099003)(261026121527099003)(56012099006)(11063799006)(261021121427099003)(261026140227099003)(261022105027099003)(261028144727099003)(4143699003)(261022075727099003)(261009223027099003)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkVOa1FnQzlSMWJUd2g0NGU4cytEaEpmelU5ZTlXUUsvUGZtT0RSeGdheVJD?=
 =?utf-8?B?TTNzbk5sdTZVUmg5aTJLcnFHNis0RmQxRzRTdGdRbU02UFVSU3cvU0JLSzRE?=
 =?utf-8?B?ZXdwMGFNU0NtSWxGdVM3NzNvbVRKeHc0TnExRklydVVLSmZkeUt3UVF1TjJa?=
 =?utf-8?B?aW0vQ0NWNEQxUzJmRVpLbm9meGNRQkVuNjlUQW9rTDVRaG15bS9LbWNXVjQy?=
 =?utf-8?B?TEp1OUtXakw2aWVFelo1Mi9vYVgvejcrWjRyenFzR1Y0NW4xbldscTR0aVdt?=
 =?utf-8?B?aVM3NWh3RXVPeHpMaXNhanc3NklRTmZKa1VHd2VIUVQ3d0k3Yk1Xd21xMUJZ?=
 =?utf-8?B?OHZteEd5Qm5ScmFQbThtbUE1a25GNmtjWXNDbUZUMjhxb2xDT3UvSXhIbGw2?=
 =?utf-8?B?REdGRFNKbzFhNlhjMVRPYmhOR3NPL0dQbEhiZ3k1LytjaUlQYXg1WGJIaWFV?=
 =?utf-8?B?V1J5MDJpNUN6YW9ZTWhFd1FIR1RBMkQ2TXJnY3ZwNUtBdHFrQ2VhUkp0YmpN?=
 =?utf-8?B?T3lPbnRFNldleG4zMTNpaUZ1YVdnVSs1bFpNOGZ1YkhlWElUN1pMd1VNTlNH?=
 =?utf-8?B?SElUQ0FTSWFoaEZHS3M4WDBuWFhLQisxL2JFa1lrSGF1bWk0c3JTQ1JxQm1M?=
 =?utf-8?B?N2RVa2Jxd2w0SFBDN1ppZ1JXQVZwek5tM1kwVWZxT3Fna244Y016dFBDS0VI?=
 =?utf-8?B?MW43WGJ3cU9FMFNENXFseldFUkZYWVZNR2ZUc293ZzBFTFZucjRWVm1aY0ZZ?=
 =?utf-8?B?M09hNWQwd093Wmd5Z0thWUo1OTh1d1ZmOTExOGhRRWpVaXpWNVBuWDZoSkRJ?=
 =?utf-8?B?QXJPYUFZd0RVWGhiTmRIYjRsazhVcTBOMkRlS2VRTWRFc3VZbWhYZmZ4a3l4?=
 =?utf-8?B?RmsxL1doZWdsV0x0MWdHOFZMTGRuSkFJcG9RRHRaZ3U2L3ZiZ2U5L0VQa3lI?=
 =?utf-8?B?OERTYUVtb1MwY2xHUFRYY09JZTQ4V0p2UzBhQWM4MTRTWW5KYUhDL3F5blVp?=
 =?utf-8?B?SGprZkxueUpvNmNjQVZUSkVnazhZT0hUQlhBcG11KzNRb3p1cEdPdmtHdVFP?=
 =?utf-8?B?d0hham5remJtaktOaDFFTitOSFZCd3VubDJzN3UzS3o0TGdHZFpWTzR5RlU4?=
 =?utf-8?B?dTVqZk0yZnczbGdydGs1MFQyZkhEWDlueUJCM0V2blhJbG05Wm5SS3BsZ3lI?=
 =?utf-8?B?STFoVHhRZGdLZEpEaFRNcFRsT2VCbm5aTVJRekwrRDdTWW1iQW5WeFJub1pK?=
 =?utf-8?B?ZGhXeDJBOXltYnZXeGhLbVJwRk9nTHRleExQQmdPV1BvdndiUXZCY3laMlVF?=
 =?utf-8?B?ekx4MGlWMjhmVC95emdmcG1kaVJiUnNSRnJheUozQ0tRM3JZZ3ZVeDJSaGNk?=
 =?utf-8?B?eG50aEt6eVJoNjBSREN4YjZKV01QenpHMmVjM3p5MEhOQ2hJRnVrZHR0bzdn?=
 =?utf-8?B?U3JLdEZyb3lvb25uSmJOWEQ1NVozM1hSc3hZUjliRDBJU2hKejVVTWpud0tW?=
 =?utf-8?B?UktFNmp4eHlETDR3SEs2UHJ4dVh5R0xudHh5Szc1eHBJNVArNlZUK2gzY3RT?=
 =?utf-8?B?enlvVmJrOCtJbnFXMUxEZVpVNzFEQ0laTmlDT1RzT21LeUp2OFFxNWxWTEtn?=
 =?utf-8?B?UFo5UVNwc3JjcUdIMVlieWE2Q3dsd3ZvcmpLZDY3ak9VMkVWb2JjUDJmejV3?=
 =?utf-8?B?YlZSNHdIdEJ3MEtpVGg2ME9LdEcrWG9WQXluY3EzMnp0VVNWbjNjaGxHeEFQ?=
 =?utf-8?B?OE5Ed1dyWWE4bHFnS2tPYUYrTmdkVkNUVGRKM2JtbGIvMlp2WnV3S0xPaTRS?=
 =?utf-8?B?aWp5MXMxckNPY1FOMVB5ZUhCTWVrcXdwMHM0dXorYmtGK3F5L1Q0M24zVnc4?=
 =?utf-8?B?RTRvSnFDV2lCUVNXRDR5aGRDSWZ4cHdwMUpSZ21paDJrQUtWRjk4UDJNL2hW?=
 =?utf-8?B?aXZUb25Uc2g5MnVSdlFxT3NsblljS1dNYWlRZzJDT0hZZ05NU3NkZ3o5Z3ZD?=
 =?utf-8?B?eEllZGNjWVlQd1dJV2F2YWhQSmNxNTFYTVpMbWRvR2lJMi9lcmF0QmVxZ0Mv?=
 =?utf-8?B?bmg3T2t1cGtNaUJ4K1hQZGllSEhTZ1BWVHpxZXhRS3g5enJVU0g0V05CYmo1?=
 =?utf-8?B?Qk1pYm41aFpVdVV6RFc4R05sRFMycWhjcHZpMVFUbkpYbENESVVnSk0yL3pT?=
 =?utf-8?B?ZGlsRnIyZzR2UEx0WmtmQTJkbkVSbUwra3VZaHBNSi9DNEhETFA4VTNuS1Na?=
 =?utf-8?B?ODhtaFJmYk1DVmRBMkExWmF2dnNHS2lUdS9hb0lXL3Y3NzJOY1RJUEdpVmxJ?=
 =?utf-8?B?Zk1RTGpLclRVN0g5amZhb0dXbEtRT0d1U2ZqU0l5RUNVU0hpNnpkLzMzcG5E?=
 =?utf-8?Q?9eMmkIK4ZP4PwjwHHzBrQMQaQfMnHlBfGaJ9VvGlclQzN?=
X-MS-Exchange-AntiSpam-MessageData-1: /nSTsvOWCPq76BdsDM0AMrYoszcPOzllESI=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e77b0971-55fa-4bdd-a5a9-08df4660d401
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 17:16:20.0081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdSV/PdzkiK5IBSxMHTy1esL8JiioS3siEzlArfkIKKab1xHJf6UiBp/fqcv0hb59A0TMD40NvHgoUHMoBj+s3aRJBjD2Onh312oKNSo0XE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12134
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andrew,

On 11/16/26 11:59 AM, Andrew Goodbody wrote:
> Since the commit to only build mkeficapsule when needed rather than by
> default, the build tree build-sandbox_spl no longer contains the built
> version of mkeficapsule and this can lead to a binman test failure. Add
> the config line to the defconfig so that mkeficapsule is built and the
> tests will now work. 'make savedefconfig' was used to generate the new
> defconfig file.
> Building mkeficapsule in sandbox_spl is needed because that is the tree
> used to run binman tests due to it being built for both 'make qcheck'
> and also 'make tcheck'. The sandbox tree, which already builds
> mkeficapsule, is not built for 'make tcheck' and building it would just
> add extra time to the run.
> 
> Fixes: 2f736e8e3f4b ("tools: build mkeficapsule for CONFIG_EFI_HAVE_CAPSULE_SUPPORT=y")
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   configs/sandbox_spl_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
> index 83808c94283..3ea766d05de 100644
> --- a/configs/sandbox_spl_defconfig
> +++ b/configs/sandbox_spl_defconfig
> @@ -242,3 +242,4 @@ CONFIG_UNIT_TEST=y
>   CONFIG_SPL_UNIT_TEST=y
>   CONFIG_UT_TIME=y
>   CONFIG_UT_DM=y
> +CONFIG_TOOLS_MKEFICAPSULE=y
> 

Let's see if this breaks somebody's CI because they don't have the 
necessary tools installed and do build sandbox_spl. We can worry about 
this when it happens I think :)

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
