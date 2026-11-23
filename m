Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4111606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ffuZjNgP;
	dkim=pass (2048-bit key, unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256 header.s=selector2 header.b=OPRDX3Lg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E9F680E4D;
	Mon, 23 Nov 2026 15:56:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LQYOpLB7LmYx; Mon, 23 Nov 2026 15:56:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AC64A80D81
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795449397;
	b=b5RTmDFcfYLZUabk2udsxRFPP3R483Kf/PF8i/czgVhXrnVvqlbkR0Sm/f2lz79rJJcI
	 1cD3926cxi4p50vQS5rGD5v9qJiRLmfTuRnN+gRHXg2Uo61wg1zQWukm5ZdoySLfoftnP
	 LLBnBAH6MzB+ZChGpCn2xXB6w2OqlT9Y7O/HPhab7zDUyGy4Am7fm6/VlT+Zjb3NaTdoH
	 S10Lrw+r+QAaew4qAJ+HlcWHONUueD1pYTE1GC1A3NbHPA844bq7ZRtwj5+x6v9+sSC6J
	 P7bHVOjPR92WN1+0WdL3aZR1CGg3OIHBQHQF2CvFR7RncJI+CXXu97xzY9xsaZD9GSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795449397;
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
	bh=K33iXVQJYOBeakjhTN2Bj8x/wZVXtuMcQOVeIHH9mhk=;
	b=R2mnWRUs2nHVoH1M5ybmkFoND43nkJcBrZPWZQXYMyxL3VOqk+6ldblJyAA1VYuhvjbM
	 +adpYRE8nc10k3IuT/jRGj6ryQQUXuqeJtZXdVgZOiRxalUuScUVL0AB4T13Ue5Chu4pP
	 Fwnr0BfevDjJ/Q8g/vJJP/ULGqs+4NLTzM4aHEUtZOYBxVJFpHLbuqQ5I89YMrhZcG5cv
	 sLKTv+pYY6s8pp7OOWpxw0DtMXLdiFQJsScfikUAgSBRCVPc/xsuLEgR1YTAOAk6WMJl1
	 VGPbfVzhLNXRkmoIPOQy/S+pFa5Tjru8q2qQa4KDXeYakV2YkyXfRqa7WehAzLCg6vg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=phytec.de;
	dkim=pass header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256 header.s=selector2 header.b=OPRDX3Lg;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795449397;
	bh=K33iXVQJYOBeakjhTN2Bj8x/wZVXtuMcQOVeIHH9mhk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ffuZjNgPTsFtsmTsGALEuKANlxLjVXBP5JdpPZmArqaOYcVP/yXBbiPC7v3S/3WV0
	 f73zLdETSx/u1/g1SKdRoZ/59CTtL7Wajq21WrHELD3KZICr57VGoxLqeWa8yrfCft
	 Mt8S6iP1wAHLdU5qUj0z/wuuIp90aJQf4SXqcxhweH9PZ+HnmggUIUJKMgQ5V/j8Aq
	 nZ3KVilZ7JYDXLcYTI7PrZ4pQLml+91kATKEgquKShJcKuxVu5rwpOMofWuSkIpWOy
	 k7XAdPDkdNyRi08GvgSYa9RbUCJLx2sYqt507x6nAZ3/CmP2QDzyfDXZAkfDyCi2tB
	 6prgOBTnaxwrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC64A80D81;
	Mon, 23 Nov 2026 15:56:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0629E15D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:56:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EB93D80D81
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:56:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sI8CB8AieZ2f for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 15:56:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9831F80D80
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=b.hahn@phytec.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=OPRDX3Lg
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9831F80D80
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K33iXVQJYOBeakjhTN2Bj8x/wZVXtuMcQOVeIHH9mhk=;
 b=OPRDX3Lge/5hI9NXjsv6pjMc4qzmut7ysIcVaj88/amL0n14yf0shXCWA+cH+WO5omf61R43DlSVKHyqm25d+Bein2JlM0NNnflcj6pPhOM08rMas/ieGs21YlP7tIyiMrxkDSsXZ6miyI4ao8uDHB2Q5q8c60fleuakN0jjWx2XhHzxGTo4LTNviPT6hN8N5xuQAs4kJqvtc1SYwztUSCA+WAgzYY7KuWHURaCTH6CIgksXJbqUwUJPe8/IQYYfTd2ZdbOU1DfsK2RZVW7ZzHUbSg63ARSEMS2bny4him5pDP3P+feYMuOiNdjy3kLOaZSOaYk4OSTrxq+E9qWObA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from VI1P195MB0623.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:159::10)
 by AS4P195MB1670.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:511::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 15:56:28 +0000
Received: from VI1P195MB0623.EURP195.PROD.OUTLOOK.COM
 ([fe80::2f8:67bc:a785:6894]) by VI1P195MB0623.EURP195.PROD.OUTLOOK.COM
 ([fe80::2f8:67bc:a785:6894%7]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 15:56:27 +0000
Message-ID: <50c49fcd-5bc9-4cae-824f-a158fddaafa6@phytec.de>
Date: Mon, 23 Nov 2026 16:56:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] board: phytec: add phyFLEX-i.MX 8M Plus Libra RDK
 support
To: Yannic Moog <y.moog@phytec.de>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org,
 upstream@lists.phytec.de
Cc: Christian Hemp <C.Hemp@phytec.de>, Jan Remmet <j.remmet@phytec.de>,
 Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Adam Ford <aford173@gmail.com>,
 =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
References: <20261116-wip-y-moog-phytec-de-bspimx8m-4196-v1-0-e44000b3d3d0@phytec.de>
 <20261116-wip-y-moog-phytec-de-bspimx8m-4196-v1-1-e44000b3d3d0@phytec.de>
Content-Language: en-US
From: Benjamin Hahn <B.Hahn@phytec.de>
In-Reply-To: <20261116-wip-y-moog-phytec-de-bspimx8m-4196-v1-1-e44000b3d3d0@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0204.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::15) To VI1P195MB0623.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:159::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P195MB0623:EE_|AS4P195MB1670:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f5ac13-1fd7-4f71-f245-08df497a5533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|261026121527099003|261022075727099003|11063799006|261021135927099003|4143699003|56012099006|10067099003|261009223027099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: FxqkLH3YzEoHGIVkeC3rR3I3VO9RStShIPGydTXyq8Jhu6FfUO0kpQxjF7gQFlAhzG8d5L78RHR0WKh2woC96KTWdQ1QqR1Fk7dhmND7VlDw8dEFt6Tp9f2EMw+wHIv5LLyCe3jSS8/dygvnsC5OQ/Re6TOP+pGuyyRTqEX59uPdTV+2IHoSi4ITmVVTg1zyK1GUW88K5ha+Zu3PQNkhXcztNzVEr9Fyo67DO/pcdyqqWxv1EoIsA5IHYmaJ54pWElHg5hDzYTWF3OoqqUTcntLcesYY+dZ6v1un1njOqI006F3lwKvxeZGU3EkYTdx2AZPzyTW6G3UeBxj3r3igYiAEmtcUxMjRkwulbZuPJEPG9ge4EgQrYLk7lA0xE5a+EBuyf05bdSafPQPtQXTPrcMkWx8EXBErEaYqv8D9KOQv1187feR8Po7R58v5BR+zzQNIOJqbtJHP8IW5l+CAbsAGOvj+ukFNcsJ3toyZ5HXIxN/i908jMtNJsRkdC1TQ8/GjrR1o+Enr+THYcRKLL3bgguuSJkmtNYICV3Cw1xFZMgq2XuHDQCA2HBETrMVvprws3+0UViA8/ij7l2sWaTkmfu/ypDfRUvPfqEpcJhiz3RKkIvYSgTxSGoLpNY0n
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1P195MB0623.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(261026121527099003)(261022075727099003)(11063799006)(261021135927099003)(4143699003)(56012099006)(10067099003)(261009223027099003)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akQ5Y3UwQmVtcmx3L1NwZUM0K1F1VlJaUlpnZHpnMlQ2cXNncmtNYmtyTjRt?=
 =?utf-8?B?WTlIMm1jNGFOTUlZem5hU3V0cWwwb3ZBemM4RUg1MUZzcmgxMFBXUExQMS9Y?=
 =?utf-8?B?clZWYUtQUnFGME1FVGlXU0R3V01pWEovcnV3cHl3TmtCTTZlY3hSd1RQejY5?=
 =?utf-8?B?c0NlK1pDakVTSm56RUF2aUdjaFBucUFQb09oc2Vyb3gzM0cwUEVFaFhwZFpj?=
 =?utf-8?B?QXlpcXhWZFZBRjhEUklNZ1pUUzdGK0VTSCtaUUw0SEx3SVRwUzRPQjMxT3JX?=
 =?utf-8?B?c2x5QjJGWW00dmVLdkRQMlF3NWFqd3F3RGYxWDFuQ0FGQlByTS9YUUN0RTRJ?=
 =?utf-8?B?cFRHSHB0bGR3TlNBcjVPVWlNSi9FNXIyYnJqMUZRODgvTHlXODJYZ2VkcWtK?=
 =?utf-8?B?UHpZaVh3dHRFaGJDM3JndTVsTE41RWxSU0doaG01TVdIL0FNQ3AyQzlFMUJQ?=
 =?utf-8?B?bVFzZmYwblVQUUhjMzVQRUZqU2hOQzV0MjF2YjNucTZRRnJHOTNEYVBLUU1U?=
 =?utf-8?B?ZkQ2ak14UTlvVWxoTHhEMWpDTmhLbEhMVTFYaWhTV1JkT2gwdzYrNklnaSs4?=
 =?utf-8?B?ZG9SK1hTenU0bnJnVk1pTDd2cHFUNmljTU01akRrVU9uWmpCVVA4c2VYZmhO?=
 =?utf-8?B?NXNqSzBoaHlQYmFaVGltR2EwckVVcGYwRkZha2oxK0NrbDZwbHZmUVlodDhI?=
 =?utf-8?B?M3pRdVU3NmoxaXdPVVpaSWJzZjl5ZWl5dERXSi9GTEtSUnNUY3U4Q3N2WDJ5?=
 =?utf-8?B?UEtEQnpNQUszMGpXb0plRXRQKzNSM3J1YUYzKzFKRnJWZ3RJcXV0akFaRTIw?=
 =?utf-8?B?aE8yUFVuWXBUaVJha0gyVk4vNXQ5cCtORlBjcmd5bGpMbFB5OUxVTnArSVgx?=
 =?utf-8?B?S290bGtrT3BuTXpTVEFwVUs2em83NWJsTGlwNmt3U3B1b3lDcFZsL1VMZG42?=
 =?utf-8?B?TmZJa2UwME5LdS9QNE1DL1NOMEFueCtFVyt5WGhrb3VZTHFLUWpLb0NDZmNW?=
 =?utf-8?B?QVlmTmtBcVRJUzZkQ1JsYXlEdmM3dGZENCtnV2RsOE9UbVJkQU9GSEJ0MTlD?=
 =?utf-8?B?U3NBaWNaQWhseUc0QUE5bFNGYy9YRlRXTDRpMU9GL0sxRUY4NktxRC9rZmdS?=
 =?utf-8?B?eWZETVAydHp4K1BDUkZMbGplQXd6bk02Szh6WmRTVnBZcm9tbGNuTTVySlBZ?=
 =?utf-8?B?Z3hGNzlLaE9mUVloSXJOSkRjUnQzSzU4WVAwTXA5TzFtNkUvQ1JsWC83ZTdS?=
 =?utf-8?B?ZmpDMTl1RG44VG1IYSt4eGR1YXBtNnUzN0hjenBSNzZXMDZubTJ5bUFsVXNZ?=
 =?utf-8?B?czMwc0lVMTFiMTZwUGo0YVJRWDl2YndSQ0JUclJqdGxKQVphb1hKdDBjc2dz?=
 =?utf-8?B?SkFJdkJSYWpTcXNFVTkvbEszckVGbWY4WHBVbkpTcjV3bmxJTFZCcExpWEN4?=
 =?utf-8?B?YzE5K01VWVlKKzZjUDBQdTZVNWFMY1FDK0VlZXlqTnZxalFkS0E5Um1NbVh4?=
 =?utf-8?B?K01NSzV3MjkwYmZ6YWNza3pvdGZrYmYwQUpTRGc2b3BZajdaVU1nYmlSenIz?=
 =?utf-8?B?SEZmVVZnYlZaTTdmNnVtOUpnSzhrNTFCQXJzWWVPdjY3UC9kV1k2Ryt6ZWhn?=
 =?utf-8?B?NU42S0JaalRUNUw5UXdjOWdwcGxzM2VyTzQ3b3NvZmQxOE04OGFub09vRjhI?=
 =?utf-8?B?NnlXV2toeTZtZVZab2ZkS2l5MGJSQjNDNnRHTVNkVXRUS2swM3V4cDNrNzVN?=
 =?utf-8?B?VzRJTGpDelc4TG5LRElwd05veU5yQkIxTHk0TWJ2N2xlaC9yUU82a0dwK1Vq?=
 =?utf-8?B?YmxINVE3OG9aYXFVaC83NGpUUzBXODYremNrUkt0QnJnVkxYbXlrRWFNZTUz?=
 =?utf-8?B?NUREOFNudGF3S1AvSlNmaEdJNGw0cWNwMC84SHBiWGljTUtxT1JwZGhkemhh?=
 =?utf-8?B?VGVqRnl4WmJWdXpFTTJMc2NkUmdSKysyaVRLcS84ZENQejhEUnhPOE1XQ1p1?=
 =?utf-8?B?TTdCTm5SaDFkK2lxbTdsY0o4YmszcWpQUGtURXBJREVnTFFFdzJHNDJvWlFP?=
 =?utf-8?B?M3VRdE0raDVobGdBaExXTElLakV2TEN1c1NBN3NLZGdtZ3NVQlQxMjVTN3NE?=
 =?utf-8?B?ZXptQXJwTXdwT2paSmY4dGYrNW5mNW5jOHA5RXdXVkpLUUdwWFoxWjc4WXRT?=
 =?utf-8?B?U0ZlbDBTV29JaXF2eWQzSUdQYUFKNTRITG9LdEwrWDJnQjZITFZBZ1A4WWM5?=
 =?utf-8?B?UWVjT3VpOC90dlY2YmpUNXNmdTY5bk9GdmQySWVQNjl6ZUVXN1g1YXBZNE1V?=
 =?utf-8?Q?CkFjD51XNOGkYCzto8?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f5ac13-1fd7-4f71-f245-08df497a5533
X-MS-Exchange-CrossTenant-AuthSource: VI1P195MB0623.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 15:56:27.5195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+tDWr4YGy/QpBFGXaiRZbKtHnWAB2K76Hl+LkaOWN55Z5OAtG17GwAAgI2BsC0KGWWWyhP4LigF0tFEQ4PMfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1670
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 16.11.26 um 14:53 schrieb Yannic Moog:
...
> diff --git a/arch/arm/dts/imx8mp-phyflex-libra-rdk-u-boot.dtsi b/arch/arm/dts/imx8mp-phyflex-libra-rdk-u-boot.dtsi
> new file mode 100644
> index 000000000000..383ded33508d
> --- /dev/null
> +++ b/arch/arm/dts/imx8mp-phyflex-libra-rdk-u-boot.dtsi
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 PHYTEC Messtechnik GmbH
> + */
> +
> +#include "imx8mp-u-boot.dtsi"
> +
> +/ {
> +	wdt-reboot {
> +		compatible = "wdt-reboot";
> +		wdt = <&wdog1>;
> +		bootph-pre-ram;
> +	};
> +
> +	bootstd {
> +		bootph-verify;
> +		compatible = "u-boot,boot-std";
> +
> +		filename-prefixes = "/", "/boot/";
> +		bootdev-order = "mmc2", "mmc1", "ethernet";
> +
> +		/* order of bootmeth nodes matters */
> +		rauc {
> +			compatible = "u-boot,distro-rauc";
> +		};
> +
> +		script {
> +			compatible = "u-boot,script";
> +		};
> +	};
> +};
> +
> +&spi_nor {
> +	partitions {
> +		compatible = "fixed-partitions";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		partition@0 {
> +			reg = <0x00000000 0x024a0000>;
> +			label = "u-boot";
> +			read-only;
I believe we should not specifiy this as read-only. This will make 
updating the U-Boot in SPI-NOR flash unnecessarily difficult. We also 
describe in our BSP Doc, that flashing U-Boot in SPI-NOR from U-Boot 
should be possible:

https://phytec.github.io/doc-bsp-yocto/bsp/imx8/imx8mp/pd26.1.0_nxp.html#flash-spi-nor-flash 
<https://phytec.github.io/doc-bsp-yocto/bsp/imx8/imx8mp/pd26.1.0_nxp.html#flash-spi-nor-flash>

Benjamin

> +		};
> +
> +		partition@24a0000 {
> +			reg = <0x024a0000 0x00020000>;
> +			label = "env";
> +		};
> +
> +		partition@24c0000 {
> +			reg = <0x024c0000 0x00020000>;
> +			label = "env_redund";
> +		};
> +
> +		partition@24e0000 {
> +			reg = <0x024e0000 0x01b20000>;
> +			label = "none";
> +		};
> +	};
> +};
> +
