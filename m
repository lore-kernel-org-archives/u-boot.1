Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EB4606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UVK2u1uh;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=HgFcH1Pj
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FB8F40665;
	Mon, 23 Nov 2026 09:56:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VxZnKsfL-vwy; Mon, 23 Nov 2026 09:56:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D042E405D7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795427813;
	b=m9VHOOMRf3VPK2Qnc+nvKNlnWdeA0imtc2S8cMCL+1I2em3cUE8D/G3nFZAgfGnzB83H
	 azkYJnFD4vcwOmwz+H0jGr5nuwq3IW5HMWyKat83v5UhliLxqtIklv2/k0JQWuy+j6xqq
	 W9qRRMGS1uphoOr/+5T0tzAF6vUlZ1uUtqWehkSi7yRgSFO87AqvL9KSq2LkboHqStrFZ
	 20LaUApzyo3+rOdaW5Itkoyg1/tDQgAJHIuDGDpS3jDIMr2FhL/ieted8/qtt0XK90EJ1
	 ooqfm3SKVFPHBmpXbTxqxPqGiFI+iIUKcnzUDkdaUFRGi95mpeJ2Gfgr/y8M+iCxIOQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795427813;
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
	bh=RFGubWE9/cHyGOvGcYtl8HeDg6zPJQzpBqkfSaj1w2g=;
	b=gSNu2e3ZGANn3fSvZjiI0uB9/cMB3Mkn+A3Fg8vt73DK+0jnfNsPbSTubSEbVNxU1cwR
	 xhNPcPWDQEqkYjjSaZwjFKDL8T5Q24swLfIql0kFPQFlZfnRsYAi4b1FpKMfnpHctJml7
	 fkbOG7YYvDBkpJumxXtaxzft/dizp8chMDXuNCj9N6pXtg9C41WHVVLdbYfPFDlKFKwRG
	 2mueQsvn2cN7+rPjt1+1DafTEKk1Oxry8NxES9yb2TXzaegyjAwPc2sItrJVfGKjTaIW+
	 NqHbUwfnZYBf1phVhm5/Vc6nKvaSnDIcRwAIp1C3tP8j4ZYUMCmSY2rDR9HK7TDCE5g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795427813;
	bh=RFGubWE9/cHyGOvGcYtl8HeDg6zPJQzpBqkfSaj1w2g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UVK2u1uhPOUeuOhYIbeCv3YRK4G3w5u8YGtpNrodjFGXZZcNsTDJWnOJ7M+nEYxr6
	 l1skRaCe1h5LamgmeJoq8TZt3QNcW0bD2zAeAn91skJyM8tssQ20LWoXQlMfqkDJ3R
	 Km+UiOnVIXQPgPZC5noJapQdmXCPFV91Z8qLgky+KvkrYGYVkYgbQdgISpD6Ezxau2
	 zvQoFb9BmCiN09kowlP/Ic2awCGMAR4YgvlPPf8IVcz94MtVkBTGnLMoZMfCddADNJ
	 zecNuZK7N4Pw4RJGRc6vF7tXH6jqLeGfCEfsXVwBE0Kv5NGIIwhUofCPK1BsoA4Si+
	 i3G7SI42rpt1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D042E405D7;
	Mon, 23 Nov 2026 09:56:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 639121AB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6092280C93
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:56:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oCGu_YyFhBXx for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 09:56:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8871080C81
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=HgFcH1Pj
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8871080C81
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFGubWE9/cHyGOvGcYtl8HeDg6zPJQzpBqkfSaj1w2g=;
 b=HgFcH1Pj6CWEVxGoiyQ/A0JyIAwf4hpgZ2JuCGCARfrScUK1j6zIQelr9PGAkhJNsPJ6l2tuqt0BeInlefrTXoIJhC3nMLHmfYbF2ENCja6bYG7c0q2xmW1K/p6ouFwovaRERst9aR6iWSNwfL48UESA4hRVznGQX3SCVeZHNn8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by BR0PR04MB092698.eurprd04.prod.outlook.com (2603:10a6:2c8:58::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 09:56:44 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 09:56:44 +0000
Message-ID: <95ab24b7-5cfd-4ac6-8a63-f6fe820e1dff@cherry.de>
Date: Mon, 23 Nov 2026 10:56:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ram: rockchip: raise error when configuration is
 unsupported
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
References: <20261116-ddr-multi-v3-0-fe9fb30a3169@gmail.com>
 <20261116-ddr-multi-v3-3-fe9fb30a3169@gmail.com>
 <4b4b6b1d-9676-4b02-a10b-506d3169800f@cherry.de>
 <CAC928Haq+ic8E622GsxdoOxFyXn9BHvNKxWTkV2ZsYFvA4HC+w@mail.gmail.com>
 <a7390f3e-f6f1-4617-b7a4-df253673abe3@cherry.de>
 <CAC928HZjdBO1W7_X_+VKHh0fxoBoQahW9nRBfdf4PYMNAmompA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAC928HZjdBO1W7_X_+VKHh0fxoBoQahW9nRBfdf4PYMNAmompA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0557.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::13) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|BR0PR04MB092698:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2cb0e6-f9a1-4700-0db1-08df494813e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|6133799003|3023799007|5023799004|11063799006|56012099006|4143699003|261028144727099003|261102123227099003|261026121527099003|261022115727099003|261022075727099003|261026140227099003|261022105027099003|261021135927099003|261021121427099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: OpD1ndfyUjd9ka/iN76kTuSpBX5br830///q4ICHyZkOKvoGFjiXG8j67OEpniw2E+54gzQZJFzGN8cv0y2/WSYlkzeOZZ9ef1UfMIcuEzlBLYLUNVKGKdeczzpGbrZuN4GkQNKq8YYJ3iq6iuuZYw4eUmjF+j0OhS5I3ipG6bqG/a1YUh+Xu2lVJ2tTxj+S8AVF7eK4LocGdgoRPXnX0IeptA9O+bm3KzsmCyYJok77HNyo1TKb7RApisfPdnKYM+u1fCvBfihPzcRwS+OiptH5+iRiXFEmbi9byciAE8CbxKxOD3MBJnXLBx2vXFlI9bYsvwONIBp722KyPjcRBTl5SYiL6JXoE9kpB+It6FLpDyyPDvNF0x7JjjkEbYl5NBrZJcfBrR7S/vwOG+QnOI8f4q4IGA5aKkluSiybxkN9Xjtqoxeb5x5+jMx/HI8N+ht6DjfLeDMhuyA3ZcUXscG85JBIgNmWKdOpJc1yp2dL4GisvKBUnM5Es4TYqUoCxSlnQTFkBNielSpJzsT5GmFyhFvjxAEkuLeqJ/NxoqE/WTVwpKOqmo1rc8We2Cys2xaNAg/KNjawDGlNZYJqaBk9efXQ9ANImb9bzkyn4U0ZUO/6Dl+saYRZwGpkhoSRSDp30ye6NG4JL1vAuXVrOqWOrly+bVjYTRTbicMa3PE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(6133799003)(3023799007)(5023799004)(11063799006)(56012099006)(4143699003)(261028144727099003)(261102123227099003)(261026121527099003)(261022115727099003)(261022075727099003)(261026140227099003)(261022105027099003)(261021135927099003)(261021121427099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXVneHFzdGE3TkhYNkpoMHhBOGhySTNBYkZWSWZlZVRyMGw0ekwya2czajll?=
 =?utf-8?B?NEl5SmJxSXlqZ1NLNU1TQ3JDSGVVUFdLZ1ZwendzVVVGbU1UcGVLdkZWNlBJ?=
 =?utf-8?B?bS93VGtpWlZZZW5FZFlmNWZ1MExYM2lTd0pTSFhwVVgycnJQZlJ4bEJ4dlM1?=
 =?utf-8?B?NUhsQUhPTHhHejVINFNQSlY0WTAxR2wrR1Uxc1piVmFBcUZXVjFNZlNPYk9H?=
 =?utf-8?B?N3F4SXA5VjBrYzZZeEh3cmRNZGJjYzdSNGZBSDRCWXlIaG8vRGFIbERQK2Zu?=
 =?utf-8?B?V25ORkNnTWtEYU1TaHVEOW8yeGp3ZUg1TmhUQksxQis1czJMUjBqZnIrbXNw?=
 =?utf-8?B?dXBRR2pVWUFkVXpBMVhVLzZZWWY4Y3hlWlpPSVRhNjkwTjRTT2lzaDZZUkUw?=
 =?utf-8?B?WXBwQVBmNFhGWU9hdnFnWnZyOG9hVjlUZ0dKcFNjc0JwTWJvek1BMjg5K1ll?=
 =?utf-8?B?V2ZIZTJ0RkgxTVhFUUNhNlJmeFlHVGsvcTFVT29pcTVHRVVNb1NkU3VJZE1l?=
 =?utf-8?B?WFF5QTB6MlJtME5wb2lkRWlVaCttOTZ1L2hKUmZpaTFqS0w2VHdpQ0VJQXVz?=
 =?utf-8?B?MS9tRm1VYjJFQ1hNUlUyWjF5eWg2VG1ZMFVISDdLcWhDMTNlODBFWG51M2VT?=
 =?utf-8?B?OEkxR3lBZGFwWEM4UGFBSVAxZy9VL1ZiUGNrNWFSTmFFa3doV3NyYkVsZ1BQ?=
 =?utf-8?B?b2NwQlZHS0hYc3VWS0hKcmxTZGM4V1cxWE5zcU5jZVpXSVIxNmdOK0ovZEFi?=
 =?utf-8?B?clpxZU1wQWo2dDQ2dnhpWEtMK1BEcFFYZWlqV1pzbGMrUUVobXFUTVZrblpR?=
 =?utf-8?B?Y2xWNXRxcWtrdGg5bFhaL0lXa3VLLzdVK3JHTkJXVUlQc2dwejlzcUVQYWEv?=
 =?utf-8?B?V05aYnNic2M5LzgzdzZPSHd5R2VmQ3NHaDZDZUxSTG13Q3RxMk1MazFsbk9m?=
 =?utf-8?B?ZVYwb3JXUUZSY3JPaUhQUUp1NDNlVTcrOVpHT0JHTDV4RWpiQnN6aThvMkVL?=
 =?utf-8?B?c3lESS85Q2xQUGpiRndLM1hwRll0UHQ3Y2ljaVFQaHl3Y2dlZUE3YzJRWFJp?=
 =?utf-8?B?Wm5YR1Zwa2dWZzBPVWE0TXZvMWYrTXcyVk9FU0VEVjdrT2xqdzRrQjUwY1VX?=
 =?utf-8?B?YWI3cGFFM0xNMGJxUHlxb01oSGw3QVk1N1JhdWM5K2RXQzAwcmpkQVpWOU4r?=
 =?utf-8?B?bnZmVkRJN0ZPOG1QVDBVbFVjTnVoOS9lK1BNUlEzRlRhdjhSanlwWUpVWlQ0?=
 =?utf-8?B?dTFBNExQTGsvUG5tbXdsVFh5VndkeUZDckw2UCtsVGVhbFo2Wm12ZWxKeVpG?=
 =?utf-8?B?SEVSb0RUcUdxTmlsVDQ0ZFN1ckFVQ0wxQkFiM05makh4YzRicFA2T29mZEVE?=
 =?utf-8?B?WVp1UzRQTWpXSytEQTRJWnl6dG95cHcyQkhqZmVPcjFJRXhlMVZyaGhiSGo3?=
 =?utf-8?B?QzZNOUQ4dzZXUFMvZHUxS0hUS3Vzc0hUWWJORnZhZkwwZFA4SkNuRnc2N2tB?=
 =?utf-8?B?UzBCZkliS3BlcHJlYjc0MnFNM2lRMi9mSU1MQnl1dkFNVWlKS1o0YWNmY0Nn?=
 =?utf-8?B?VXAzUHl3eGMxVk1FYkg3QXFONE5zeWhNeGpwTTNTa3gvWU42enBteWNyZXJn?=
 =?utf-8?B?TllKeWYrMDRZUnI4TURJSVdlQXB6RkJGMlB6TlBrMG1va2dmYmt2YXNITXdw?=
 =?utf-8?B?WjhzUWtnT2R4UnhsdzhpdkJKbDlYNVFXOG9Ga00xRkpJaG5oRWttVUNZcTNX?=
 =?utf-8?B?ajQvaXY3TFhXY2lFYzRrT2RqWWFOM0dQMWg0RmFyTnJPbkltNmd2VjlwbE9s?=
 =?utf-8?B?WHIvQVVxWVZrQnRSbDc5eWJtSFovK2UyZ3pxR1hqNXNNVStiOUp0VkNRQi9z?=
 =?utf-8?B?Q2FBUGE5dFdvNHp0dHNxUEtWMEROMlViNTdYVy96Z0JEbnRNRHpGZm5iKzFU?=
 =?utf-8?B?QWV2OTJRMVEvWTBqK0Vjc0ZCdHlqTGloSk5ET3NUZzVLRzV5eXBTRXJxNWpR?=
 =?utf-8?B?a3FCM1ZoTEl5UjhDb1h4dFArNjA1bW5tQXhEUis1Vmk4WnRwakw4NzVZSklW?=
 =?utf-8?B?UVo4ampRUmpseGJRWjI1ajVOdS9jeEZ0VVdYWGl2RWVZeW4rYmYvT3ZKeHF4?=
 =?utf-8?B?cW91dW95K2R5alVlYXBEaGVWK2ozdFdzZ0tKZk5zVFFNUlpOc2FDdjM3RDV0?=
 =?utf-8?B?dHZLSU9GRE85ZjNZK0VGejJtbHFQR1Bvalo4K05BM3dJNXMzMGczcFJPZlpB?=
 =?utf-8?B?UzFFTCtGOXh5VnZpaGpmbjF5TDZQdmo1U1hzOVVFR0s1MG1qNEJhVk9iWk0x?=
 =?utf-8?B?TW1nemN3WDBOQWdCQm9IcVBJK3pZVGFITHhDbGZrbGc0NnVmYkFYQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2cb0e6-f9a1-4700-0db1-08df494813e1
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 09:56:44.0758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hva4T7PWsd65qFcmPUhJGJ/i/FvOAmswETDD5DApGT9WEVuNZz16AettEYFhCcbb1Lg5jUQIbbHYDMEqBtYGI212yC2CsubPajbqrKFFkus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB092698
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Massimo,

On 11/20/26 8:53 PM, Massimo Pegorer wrote:
> Hi Quentin,
> 
> Il giorno gio 19 nov 2026 alle ore 16:14 Quentin Schulz ha scritto:
>> Hi Massimo,
>>
>> On 11/19/26 2:23 PM, Massimo Pegorer wrote:
>>> Hi Quentin,
>>>
>>> Il giorno mar 17 nov 2026 alle ore 17:40 Quentin Schulz
>>> <quentin.schulz@cherry.de> ha scritto:
>>>>
>>>> Hi Massimo,
>>>>
>>>> On 11/16/26 7:39 PM, Massimo Pegorer wrote:
>>>>> The PX30 and RV1126 sdram drivers support more sdram types but only
>>>>> one type at a time, really. The type to support is selected through
>>>>> RAM_ROCKCHIP_XXX configuration options: raise a compile-time error if
>>>>> more than one of these options is selected, instead of relying on a
>>>>> debatable and embedded priority order to choose the one to support
>>>>> among the selected.
>>>>>
>>>>
>>>> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>>>>
>>>> If we add ROCKCHIP_RK3399 to the depends of
>>>> RAM_ROCKCHIP_LPDDR3/RAM_ROCKCHIP_DDR3 and RAM_ROCKCHIP_LPDDR4, I think
>>>> we should add a similar check in the rk3399 driver to refuse to build if
>>>> there's LPDDR4 and either of RAM_ROCKCHIP_LPDDR3/RAM_ROCKCHIP_DDR3
>>>> enabled. What do you think?
>>>
>>> Unfortunately I did not come to a clean solution for the RK3399 sdram driver
>>> "singularity". At least, not enough clear for my taste. So I left untouched,
>>> open to discussion.
>>>
>>> Let's suppose we also have ROCKCHIP_RK3399 in the dependencies of
>>> RAM_ROCKCHIP_LPDDR3 and RAM_ROCKCHIP_DDR3, something like:
>>>
>>> config RAM_ROCKCHIP_DDR3
>>>           depends on ROCKCHIP_PX30 || ROCKCHIP_RK3399 || ROCKCHIP_RV1126
>>>
>>> config RAM_ROCKCHIP_LPDDR3
>>>           depends on ROCKCHIP_PX30 || ROCKCHIP_RK3399
>>>
>>> Some compile-time checks in the source code can easily be added to raise an
>>> error if LPDDR4 is selected but it is not the only one, or if none is selected.
>>>
>>> The point that annoys me is that, in RK3399's case, the two options
>>> RAM_ROCKCHIP_DDR3 and RAM_ROCKCHIP_LPDDR3 are the same thing, in the end.
>>> If it would be possible to have their values coordinated, I would be happy,
>>> but I do not think it is. Using the Kconfig 'select' statement will force
>>> one to be true when the other is selected. But unfortunately, this does not
>>> work when unselecting options. So, if one is selected but the other is not,
>>> what should we do in this case: raise an error, or silently ignore it since
>>> it does not affect the build?
>>>
>>
>> I think it's fine if we have DDR3/LPDDR3 selected but will use
>> LPDDR3/DDR3 based on Device Tree. We can make them really mean something
>> by gating LPDDR3-/DDR3-specific code, but I'm not sure it's that worth
>> it right now. Something worth investigating if we need to shed some
>> bytes in TPL/SPL.
>>
>>> An alternative could be to use an RK3399-specific config option, something
>>> like RAM_ROCKCHIP_DDR3_LPDDR3 but... ...it's quite disgusting.
>>>
>>
>> Nope, don't want to go this route :)
>>
>> Another option is to make the RK3399 driver capable of handling
>> LPDDR3/DDR3 AND LPDDR4 at the same time (no autodetection of the
>> populated DRAM type, still read the type from Device Tree), then it
> 
> This (driver capable of handling all types at the same time) seems to me
> the most reasonable due to the fact that, indeed, the SDRAM type and
> parameters are read from the Device Tree.
> 
>> becomes less of a headache. You can have LPDDR3/DDR3, and/or LPDDR4, and
>> it gets easier in the Kconfig symbols.
>>
>> I quickly came up with (didn't test aside building):
>>
>> """
>> diff --git a/drivers/ram/rockchip/sdram_rk3399.c
>> b/drivers/ram/rockchip/sdram_rk3399.c
>> index 6fa8f268770d..22d196f1bec7 100644
>> --- a/drivers/ram/rockchip/sdram_rk3399.c
>> +++ b/drivers/ram/rockchip/sdram_rk3399.c
>> @@ -1632,7 +1632,7 @@ static void set_ddr_stride(struct
>> rk3399_pmusgrf_regs *pmusgrf, u32 stride)
>>          rk_clrsetreg(&pmusgrf->soc_con4, 0x1f << 10, stride << 10);
>>    }
>>
>> -#if !defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
>> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR3) ||
>> defined(CONFIG_RAM_ROCKCHIP_DDR3)
>>    static int data_training_first(struct dram_info *dram, u32 channel, u8
>> rank,
>>                                 struct rk3399_sdram_params *params)
>>    {
>> @@ -1723,7 +1723,9 @@ void modify_param(const struct chan_info *chan,
>>          clrsetbits_le32(&denali_pi_params[76], 0x1 << 24, 0x1 << 24);
>>          clrsetbits_le32(&denali_pi_params[77], 0x1, 0x1);
>>    }
>> -#else
>> +#endif
>> +
>> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
>>
>>    struct rk3399_sdram_params dfs_cfgs_lpddr4[] = {
>>    #include "sdram-rk3399-lpddr4-400.inc"
>> @@ -2964,9 +2966,11 @@ static int sdram_init(struct dram_info *dram,
>>          }
>>
>>    #if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
>> -       /* LPDDR4 needs to be trained at 400MHz */
>> -       lpddr4_set_rate(dram, params, 0);
>> -       params->base.ddr_freq = dfs_cfgs_lpddr4[0].base.ddr_freq / MHz;
>> +       if (dramtype == LPDDR4) {
>> +               /* LPDDR4 needs to be trained at 400MHz */
>> +               lpddr4_set_rate(dram, params, 0);
>> +               params->base.ddr_freq = dfs_cfgs_lpddr4[0].base.ddr_freq / MHz;
>> +       }
>>    #endif
>>
>>          params->base.num_channels = 0;
>> @@ -3067,19 +3071,23 @@ static int conv_of_plat(struct udevice *dev)
>>    }
>>    #endif
>>
>> -static const struct sdram_rk3399_ops rk3399_ops = {
>> -#if !defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
>> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR3) ||
>> defined(CONFIG_RAM_ROCKCHIP_DDR3)
>> +static const struct sdram_rk3399_ops rk3399_lpddr3_ddr3_ops = {
>>          .data_training_first = data_training_first,
>>          .set_rate_index = switch_to_phy_index1,
>>          .modify_param = modify_param,
>>          .get_phy_index_params = get_phy_index_params,
>> -#else
>> +};
>> +#endif
>> +
>> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
>> +static const struct sdram_rk3399_ops rk3399_lpddr4_ops = {
>>          .data_training_first = lpddr4_mr_detect,
>>          .set_rate_index = lpddr4_set_rate,
>>          .modify_param = lpddr4_modify_param,
>>          .get_phy_index_params = lpddr4_get_phy_index_params,
>> -#endif
>>    };
>> +#endif
>>
>>    static int rk3399_dmc_init(struct udevice *dev)
>>    {
>> @@ -3098,7 +3106,21 @@ static int rk3399_dmc_init(struct udevice *dev)
>>                  return ret;
>>    #endif
>>
>> -       priv->ops = &rk3399_ops;
>> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
>> +       if (params->base.dramtype == LPDDR4)
>> +               priv->ops = &rk3399_lpddr4_ops;
>> +#endif
>> +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR3) ||
>> defined(CONFIG_RAM_ROCKCHIP_DDR3)
>> +       if (params->base.dramtype == LPDDR3 || params->base.dramtype == DDR3)
>> +               priv->ops = &rk3399_lpddr3_ddr3_ops;
>> +#endif
>> +
>> +       if (priv->ops == NULL) {
>> +               printf("no ops found for requested dramtype (%d)\n",
>> +                      params->base.dramtype);
>> +               return -EINVAL;
>> +       }
>> +
>>          priv->cic = syscon_get_first_range(ROCKCHIP_SYSCON_CIC);
>>          priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
>>          priv->pmu = syscon_get_first_range(ROCKCHIP_SYSCON_PMU);
>> """
>>
>> Of course, we need to update the existing defconfigs to reflect that
>> change as !LPDDR4 used to mean LPDDR3/DDR3 but not anymore. An
>> intermediary step could be to have DDR3/LPDDR3 default y if !LPDDR4 so
>> we avoid changing the defconfigs with the driver patch, and then remove
>> the default y in a follow-up commit by making the rk3399 defconfigs
>> enable the appropriate one (easy to find based on the Device Tree they
>> include).
>>
>> Finally, with the above diff, you can technically build the RK3399
>> driver without any of LPDDR3/DDR3/DDR4 enabled, which can be remediated
>> by an ifdef check at the top like you've done for PX30/RV1126, just that
>> we *want* to check that their sum is NOT 0, anything else would be fine.
>>
>> What do you think?
> 
> I look at the RK3399 driver code and at its repository history to provide a
> well-founded answer and... honestly, it seems to me a mess. The driver was
> born to support all SDRAM types at the same time. Then the LPDDR4 config
> option was added by commit b6cf08949d4 because "Supporting LPDDR4 code support
> in RK3399 would increases the size of SPL/TPL", and the related ifdeffery
> followed. But a lot of LPDDR4 code was already there, and has been left in the

RK3399 started with only SPL supported. Then TPL support got added but 
only for some boards, c.f. RK3399 Puma switched to TPL in commit 
2169e29c5a1b ("rockchip: puma-rk3399: migrate to TPL"), "only" four 
years ago. SO I think the size argument was reasonable for SPL as it 
probably was already quite big, even for RK3399.

> common area, instead of being reorganized properly. Seems everybody added on
> top, instead of looking to redesign the driver.
> 

That's usually what people do. Doing bigger reworks are not very fun, 
and take longer to be reviewed (and sometimes are outright rejected).

> What happens if the driver is built for LPDDR4 only and the value of dramtype
> read from Device Tree is DDR3 or LPDDR3? Or vice versa? The simplest thing I
> would expect is for the driver to print an error and stop. It doesn't. Instead,
> it goes on, without happy ending I suppose.
> 

Yeah, it likely will try to init the DRAM with completely misconfigured 
DRAM controller.

> Another example: looking here and there I came across the gstride_type variable
> in the calculate_stride() function: is it there something magic I cannot
> understand? I see a local variable initialized and then used for comparisons,
> which are all necessarily false.
> 

Yup, and downstream also has the same issue, c.f. 
https://github.com/rockchip-linux/u-boot/blob/next-dev/drivers/ram/rockchip/sdram_rk3399.c

> In the end, I wouldn't touch it. But if you prefer, I can integrate in this
> series the changes you suggested above, adding the defaults y if !LPDDR4 and
> the check for NOT 0.
> 

There's probably a lot of cleanup we can do. I'm suspecting the removal 
of gstride_type won't do anything to the size of the TPL/SPL as I would 
hope the compiler identifies those always-true and always-false 
if-blocks and removes the if check, or the block entirely. It would help 
with readability though.

Up to you, I can also simply send a series with this done myself and you 
can rebase your changes on top. What do you prefer?

Cheers,
Quentin
