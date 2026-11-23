Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF0D606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xklI0mPw;
	dkim=pass (2048-bit key, unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=b9Iv+SHR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C84B340500;
	Mon, 23 Nov 2026 18:39:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i9yen_LgwMiC; Mon, 23 Nov 2026 18:39:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E701540402
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795459179;
	b=g/DqADUiQGizNGOrG8rScZbtgD6euxrSz/iU51zy/Kdum7MmN7Dvpek8ph3vkaM9wezN
	 uyOqg+vMI8KPXhHsH8oMbpeVssInvx+/pIuvLLmFaUxNZvJUpXcsfi61v3sp63pML9UOB
	 o6WHeZpdNXz7+xp+BvUpXialBxRXdhXR2x4+rivARHMG2PGl2DvzA5ChSstDWOFAAbiQF
	 /aXvAYhynn6ItaBiOjFVl49LTwT/5DMlV3OFiw+Oty44YeBEjf8hXAtCihq6mn1xntReK
	 nIy4L99ppOExw2dX9dIdXnxdsLinvTQ7wis/P5NUY+FhT5kUG6cxnQXDdgis7sb7xFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795459179;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GbxkwDlwBjk6p4g7VgAWkT6uSGSL5pyAHddd9yiGsOg=;
	b=pDmAEIFfHaxxRRyaWXJahKlq6fLOofJlFky7oL1jrPoW49bNmF+dg+JEkmP8oIdj+05L
	 nWEh7965RdXMF1cYeHoP12LQWP3F2hM2wAvGdb8oJLV+YkbOezwLX97947BDD/bOkfuDJ
	 cwOt5RwjlTziwbBgXpq+A6vAaseOouhmjg+tuisM3dGhyIrBNPJHnq0xMailwql8B2cGM
	 B6h+kMAH8Q0QBmRQtNNDd0opwW7XTQBiIOzIJMdjW4rp9/Mpi3xQARaHHb1HLGNGmRQh7
	 1SCpQP98AiH6G9WJn/6Usx/0uzwYLNiZflBbI/IEQLVUQwaU+kySLOUEnrx2P6eT5Iw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=none header.from=softathome.com;
	dkim=pass header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=b9Iv+SHR;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795459179;
	bh=GbxkwDlwBjk6p4g7VgAWkT6uSGSL5pyAHddd9yiGsOg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xklI0mPwu2n81dBjp8RfqoEOcMmcmWZAdZBOlr2Qnl6MVyedSQtCxbWfM9lS9VGrl
	 q9f+2y20lAwsmnxafRCigc4ShPRoV0xNIC0ttZp2KZP2DYp9qbhq/3BSSPemPh5V+L
	 Bw9hSZz1ET7VM/FnpVOHVLJXZQS6rvb09bSf7Ru3Rkuh4OgDTuvGMbXOodUAsK0UIf
	 CcWcsTSY+bfOIwIBAQUmXQD6+7VGTRj7H+D8eHnOnYFoA+PRmCW4+6I2oRAFfUQhYy
	 ki92I0ADXr+DX8ShRMMmOvrrChxOuM27TaR7ucxgnDaQd9+e02QQT8EWJ5dGTW09Oh
	 sGRiFiw2aa6kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E701540402;
	Mon, 23 Nov 2026 18:39:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AC4C371
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:21:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E46A740675
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:21:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S_leGEWPpJTK for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 17:21:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9C2E94066C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::2;
 helo=paup264cu001.outbound.protection.outlook.com;
 envelope-from=paul.henrys_ext@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=b9Iv+SHR
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C2E94066C
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbxkwDlwBjk6p4g7VgAWkT6uSGSL5pyAHddd9yiGsOg=;
 b=b9Iv+SHRzd3gwcUohxIDuRVWfP6x3m0Bk/tMVu1VwLc68VjaG14hDGmKvaGjRvt5jvtaQlG35biA3mHJmh1ImWY9kNvU7wSMakR1UewRWl5v2LkIGYUJU6SbYjTyB9PrSXBEw/NL+ixEhV+nSF7+0UTAAznSHR1NLztiYCYrdItLGXrPafl+KMBz3oBjJ8vrqDQHjOH1tYmEl5fG7TXeHyhLtYS0YuOaSVCLk2AHzSDHpNZ3LwYuZuRdn0E4QYPlgBCtllIAL1BajoX6DhUGnOfYJi1w+A0tV0uc6iFYaXrjiAhf5iFlTHnl1s3b6ggJ4qUXL5ygOozGzNibLP9tXg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f2::23)
 by PARP264MB6916.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:55b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 17:21:15 +0000
Received: from PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
 ([fe80::5c56:6063:a2be:2a32]) by PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
 ([fe80::5c56:6063:a2be:2a32%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 17:21:15 +0000
Message-ID: <41c792ab-1166-4554-9cad-c790d7a766f2@softathome.com>
Date: Mon, 23 Nov 2026 18:21:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] binman: fit: skip empty data property for
 externally-provided images
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org
Cc: alpernebiyasak@gmail.com, trini@konsulko.com,
 philippe.reynes@softathome.com
References: <20261120154737.110128-1-paul.henrys_ext@softathome.com>
 <20261120154737.110128-2-paul.henrys_ext@softathome.com>
 <3881a767-5c42-451e-9518-fc769018a2b9@cherry.de>
Content-Language: en-US
From: Paul HENRYS <paul.henrys_ext@softathome.com>
Autocrypt: addr=paul.henrys_ext@softathome.com; keydata=
 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
In-Reply-To: <3881a767-5c42-451e-9518-fc769018a2b9@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAYP264CA0003.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11e::8) To PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f2::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAZP264MB3119:EE_|PARP264MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b306390-4316-4b25-2a70-08df49862da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261102123227099003|261026121527099003|261026140227099003|261022115727099003|261022075727099003|261022105027099003|261028144727099003|261021121427099003|261021123027099003|4143699003|56012099006|10067099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: DTeovyiNP1uRjRJ3jrpDENgt1UGWc5QeXVOLWsWAv+Byou+WEYVND8R8lelNRofNshO01ySI9SP0bSNTAP+zk+eUBzK93iZjWfw37jDD/8Dnq7dCihG5LixDhzjuRa3SngH24eB3gLAs1jxbB9DxCvYLG61PEmhwVFsdkkM34bICq8QjGjsdIDDVpenhQx80BA5yfJWTLegsmM+wvCliv4bikC0AY3AZjnoedtIinyw0tPZY44ODuaaahJhWspVyOCUmfSm/C9SGGEj3G2ZJ18hv7+s+arvYfzfPlBlR1u02LK/nVOtBYR0yPuqIRRQlZHzyvp6GbkDtcAWOTb2cmjEnOsVGx3FOxNkuWVxbQ3/bqhsHvCnMP20O1cDXAiR4ttcPx/CqwsXdeHH1Ws7dKPA+Q+ZcK18vPEpkqrPisbl5cvsOcTgZ2nutMYT7TPyrLeIJdyEGWO/G6NSli7/pkOtbkNtwbGjHZL2tyHGuzjFmzP0LpjlHXI++upcE3UGpRO49NlZkYjxUURyzcfzTt3BRQWBJ/A/ObUwWcrFWc3+qGyAAKvvddZKd8HTjy8X8PUIVmhVB8IB6/c3Y4AT56dap/oKWCzCjAyFawQ1IL228MGN9Txs67O/DFja555KYnJ3nipUtY+H2m9QJ889HncnCgH6CZnc4D/JCmBMV0Tc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261102123227099003)(261026121527099003)(261026140227099003)(261022115727099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021121427099003)(261021123027099003)(4143699003)(56012099006)(10067099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2tncUlYemYzdDNPSnVSQjBZd2JuRFNQWDFDV2FIVSthSm5vcm91YWpDZFlG?=
 =?utf-8?B?NFN4OEgvYVRTKzRaL0RyMGlJOWtLSEVZVDI4UzNXWU41ZGh0YjRQNytSNnp0?=
 =?utf-8?B?Mm44NDBLYVZJVHh3TWozekhVZjdNNGY5T25ZSHRjN1BBQjBaMkpZYXI0OEk5?=
 =?utf-8?B?Q1JDdXBmSlIrbDQvdjJ4RTNqdFFXY3pzamNqRUo0MSszMytzV2psMVRjdjl6?=
 =?utf-8?B?L3liR2ZjbUp6NC8rWEczdCtZODJOb3JETU5GTnM1WS9XQmU5TEUwdEVwQXEz?=
 =?utf-8?B?NkRDN01FTnB4M2VnU1Rna3kzMDk2V2lEdmFQc0ZwcWRZQXhBUVhXYm9xT0dp?=
 =?utf-8?B?R20rRWw5YmdqOXhwY2ZHNVRseDVSWFkxT1U5T0FvRFFhK21FTFU2b1JvMEVy?=
 =?utf-8?B?T3BOcVo2QWpRNUk3cW9MY09IUVcvazdOcjVBSVpDMWJENUhBKyt1TGU5Y0Yy?=
 =?utf-8?B?bFZ3RUtWWGFIZ2lJZ3J4aFA2QnA1RlZOQ2ZTUmppWmNzeWNQWGNJOGFDeDZz?=
 =?utf-8?B?d3UzbEhnM2NFM3JzaEVJUFhvMGdCcWxXaTkxWFh4Y0tlTWltVXFHclMzTjVM?=
 =?utf-8?B?N2RlcXZ3cFJSbzlYbkFoRG9kQnJHaW1USHErTks2VytLdndwalRwbjdCUWht?=
 =?utf-8?B?dWo1YkJVZlJJZWk3VDFrQ2c0cGxTUVlPT0YyZkZaZlVEN1lJUjVDRTh6YVlZ?=
 =?utf-8?B?N2kybnJZVk9PUXdJbTBUMzhxSWxlenlNM1NKaDhYMW03d3NnellNUzF2SFpj?=
 =?utf-8?B?azkzMzJYaGFsdkZVRFJucVlWd25TeDBnRnQ4TThCdzhBQ1RKTi8ycFp5Z3h0?=
 =?utf-8?B?eTJ0SDRGVmdDeUtORlhYSEJYdnNSbkx0S1NnTTdjSFdSUW9HbS9XQzBGdXlM?=
 =?utf-8?B?SlVlRk1YZTBEWXN6cDJtOUU1c0xZUHVrZGYxbk8zaktudGJUZjAwc0R0dVdR?=
 =?utf-8?B?aUUrREVZeDBwWCs5Q1ZhaE01YkdWOXVoYnlwN3F5a3BuZDNPNGJXSVdWWW9k?=
 =?utf-8?B?UGxFSGk3WTlsSUVzc2Ezc09DVVlyS080Wk03RlorZUV3ZVBPRnRBNFZJU0hK?=
 =?utf-8?B?V3BoNmUzb3AzS2NaQXVISWNtKzVuU0xSN1dBMVFpZkNxT1JJbDVDdW9qSHNG?=
 =?utf-8?B?SUNDdTUzS01DL2xVY2ExTTZFSGI0aFlIMFR0Si95dzFrZVkrL3N0UEhWT21r?=
 =?utf-8?B?NGxyZysvQys4LzNaU3hjM25VaklvODRGb1I4ejdMckVrRVZacFdJai94Y2NU?=
 =?utf-8?B?LzAxK0c2NmhybExEWXBuVUdxSk1EUG04cmdSc3VIb20zMEM0Z0RoT1F4NSty?=
 =?utf-8?B?KzVxZmgrWlQ1cWlReTVwd2VZa2RpM3R3Vm0xSXdCd2t3TEtYcUVKYVZIdWZU?=
 =?utf-8?B?d0xldGJuTmw0d2hkNyt3WWdmK0ZBbW5CeHpkc2ZQRTMzTnlyLys1eEVHM0Zj?=
 =?utf-8?B?MTVlSkNWR1RQNUliMlFINTFBbE9uaHExZDljakJpRGhNaFFrRXhrQmVvUFlD?=
 =?utf-8?B?c2IzdUhpeEt5ejJ4OTBieCs0Y044eE5OTDVrem9ZQlFZQ3FVRHdCekhFUkVX?=
 =?utf-8?B?R3d3dGt3MGpsVFk0djJPT2FxSDlhVk53M0NDWXJ1cjVneVUzRWp5TXhpMk5q?=
 =?utf-8?B?R3lwNWdYTHVCbGpZcEt6aCtGVkxZRWROY1NtRytNVFJ5ZTdwUVR6Sk1pSDZE?=
 =?utf-8?B?c2Rva0dlZkRWTU1hTmZVcWdSNUN4NkdKMHpQUWcrVzhXbEp1R0FralNyZVU1?=
 =?utf-8?B?M1Frd2I4N2dOd0t1Y3BVUFQrRGxqa3dXM1RpSjBKc2NwYzRXT3lVQ1VBdWVz?=
 =?utf-8?B?TkUrZ2orTy9kSUdzeCt6U2JsQ3RydUFuWHRFU3ZUQXFUcUptSVRaN0tOWnVi?=
 =?utf-8?B?QUtQbjN4VkU4Q1d0c005L3EySzhKVjhaZlpsaFllSnBLSGdKemd2QTF5dnFR?=
 =?utf-8?B?cVl3SGJodmdPNkxEd2JjdjZZU0ZkS2VLdVRBam1MTHpHdzc0QzIwNnoxcERW?=
 =?utf-8?B?emlXWk82K1ZZc3M2aERvVSsxbWlWNG5YUnlHSjBEZGI5ZHpteDZmMEZzN0g4?=
 =?utf-8?B?bDhJSkdZL2F5VTlkVlQ1bTBJN2ZEZERGeTJoN0dqNmpYc3V3S1N3b25aTWZl?=
 =?utf-8?B?d2Z5dXRHS3cwb3VtSy93T2tYM2RleGpzaG9ZL3ZLb3FWeWxNTWhMN3FnKzhJ?=
 =?utf-8?B?MUlDb3JERXVxaUxRRGo4emQ3aHBkVnEvOWdBOU5jY2lwR2hQNHdFV1B0UWQ0?=
 =?utf-8?B?NUl2Si9DQU1ncDF2ditTOHBMMUQ3K05Dd3BVZGgzM0JwVXVRR1UzQlQ4MjFw?=
 =?utf-8?B?SkNVZjU1S1dXSXZXcEFCVkxrQ1ZkQlVFaXphQ2VyRGtETmtnYTJVejZBR0hN?=
 =?utf-8?Q?RlclUMQ1A7G3Mkro=3D?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b306390-4316-4b25-2a70-08df49862da3
X-MS-Exchange-CrossTenant-AuthSource: PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 17:21:15.1628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRtQPsk4igBzRYI1gi+kkkKoi2bQLQlPpLIeJgQHzPo3Mhv8IuDo7XUeyO01ST2WLUVvOFvyAxE95+WFKrYrxKep9hAojyxw5qfXjUCEriU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB6916
X-Mailman-Approved-At: Mon, 23 Nov 2026 18:39:37 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

On 23/11/2026 10:41, Quentin Schulz wrote:
>
> This Mail comes from Outside of SoftAtHome: Do not answer, click links 
> or open attachments unless you recognize the sender and know the 
> content is safe.
>
> Hi Paul,
>
> On 11/20/26 4:47 PM, Paul HENRYS wrote:
>> When a FIT images node has its data provided via /incbin/ in the DTS
>> rather than through a binman sub-entry, entry.GetData() returns empty
>> bytes. Writing fsw.property('data', b'') in that case emits an empty
>> 'data;' property into the intermediate ITB. When mkimage subsequently
>> converts the FIT to external-data format (-E), it adds data-position
>> and data-size but leaves the now-empty 'data;' property in place,
>> producing an ambiguous node that carries both inline and external data
>> attributes.
>>
>> Skip the fsw.property() call when data is empty so that only nodes
>> with actual binman-managed content get an inline data property, and
>> nodes relying on /incbin/ sources end up with clean external-only
>> attributes after mkimage processing.
>>
>> Assisted-by: Claude Sonnet 4.6
>> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
>> ---
>>   tools/binman/etype/fit.py | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
>> index 4657ed1fd76..bacafc9b9b2 100644
>> --- a/tools/binman/etype/fit.py
>> +++ b/tools/binman/etype/fit.py
>> @@ -1047,7 +1047,8 @@ class Entry_fit(Entry_section):
>>                   image_name = rel_path[len('/images/'):]
>>                   entry = self._priv_entries[image_name]
>>                   data = entry.GetData()
>> -                fsw.property('data', bytes(data))
>> +                if data or 'data' not in node.props:
>
> question: why suddenly the check on 'data' property?
>
> This seems like a different kind of fix, where we don't overwrite a data
> property already present in the FIT. I'm not even sure that's correct as
> binman has support for replacing entries in an image, and I'm assuming
> it should change the content of the data property as well.

I was looking at something else and noticed an empty 'data' property was 
added to the final FIT image generated by binman when using the property 
data with "/incbin/" in the dts file passed to binman:

/dts-v1/;
/ {
     binman {
         fit {
             fit,external-offset = <0x1000>;

             images {
                 my-image {
                     data = /incbin/("myfile.bin");
                 };
             };
         };
     };
};

When generating a FIT with such a config file passed to binman, trying 
to decompile the intermediate DTB with dtc generate the following error:
$ dtc -I dtb -O dts build/fit.itb
<stdout>: ERROR (duplicate_property_names): /images/fdt:data: Duplicate 
property name
ERROR: Input tree has errors, aborting (use -f to force output)

This being said, it might be that /incbin/ together with the data 
property should not be used to generate FIT images with binman. When 
using blob entry, the FIT image does not have the empty data property 
when storing the data externally. Nonetheless, I am also not sure blob 
entry should be used directly as mentioned in tools/binman/etype/blob.py.

>
> issue: missing tests
>
> We definitely need new tests in tools/binman/ftest.py to cover this bug
> fix to show that's an expected behavior.
>
> Cheers,
> Quentin
