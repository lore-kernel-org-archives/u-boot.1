Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B113606A332
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GLlcHJ0B;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=FPLVBux9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21CA2813AB;
	Thu, 19 Nov 2026 16:25:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e9eq-6j__jTg; Thu, 19 Nov 2026 16:25:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 664AE813C6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795105543;
	b=ddC+zgmc6d29/zfKfasvgRRj1WSQtU3cpQT1Y81wq6SVhJbYhBfrc8o6CWhaN94SoKXC
	 1rw5oEWkGkowX6TwDIhX/sCUNjkxjJLLIR3g3/+7ADubnzfoL4RZOZpAsCKjKUz/i3CVb
	 VIQWWKuh0nf4ICr681Jq4X+1CajR+6Ys9xU5oCcmC4ghnYBKjlvmDLFbtKjhDWHKqDxBz
	 +GPNV2wFvk+GZYCeMqJWvb58FSqdGJPuTY5bgtb8mQ+nHbyJMB7tvXL9yklfiBn8mVeus
	 Ht3iyW0wuHb52XZI9Qq5lvooK/Ml5Gkr/Ah1w9dukKQLcMj4QA+bRveP3TxVvaS7ZkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795105543;
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
	bh=DyPTpmeZMtbt3igoN+kjMIw9V6IVJpEL1CyIucusrFQ=;
	b=UJLHciyEV9Tl9DM4In4+Ir+VRQ2ZW71mRVdHCNLrWRrN0pH2VjQixKjtaaRKn+Nn5HGs
	 iCRpXJn7+K3S1xkP8OHjUbb0/3eT1Bqk4x+r3fUX776SjT6SCyYSgx2OAX2Q74w3/uIm3
	 SAb8teX2mQfexobZIlX9nG9x0m/iVbCAhgLFTth7v8cbgBsHdR3I9rNc0gV1abL5DcHR/
	 lzrl2ddG1sk6tnhAQOx8Hf4fG2/QfwpsrWPaY9yHDOyUz1Za7DxpAi/8CI6usymjqU2jM
	 t2fCHJXh6anLC6/4U8EUKL/Krn9WW21NKBCmidO8yi1c6/yuyT3q5NsssVcDh8oe/Tg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795105543;
	bh=DyPTpmeZMtbt3igoN+kjMIw9V6IVJpEL1CyIucusrFQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GLlcHJ0BufWwQ8yKdJ6Y+6GoxusBxnTy27un6wPvKvZN11+orZifLVFcLTzXJnoxa
	 7Z5PFgXFHLy5Y6whQApSHslDY1maPiSdX5EQ1QTAj4PvB9kreArGQgLQIMiEGabODh
	 PtK0C8hdKiidzh9WuZdT7KJJvbU8d2t8fXrKdRWw4ZZjfGMl00psDLYx+h7X3g2yl8
	 JPhVFRAAOC34eXxA6GpNZWaCvfuOtESGy5E5LB6mX34v435q4crmlQMHwXC1sB7QCw
	 HcFM6edFwJ+bPFSjk8wRDrb4XNdsPUO0UjFgJpGF8l+8DReI5VwhJh9XxwZMYk9PxK
	 CejPFxe+iafTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 664AE813C6;
	Thu, 19 Nov 2026 16:25:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D9E0A1E7
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:25:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BFBE0401F6
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:25:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rTGLQAG8clOU for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 16:25:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D1EB4400E6
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=FPLVBux9
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D1EB4400E6
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyPTpmeZMtbt3igoN+kjMIw9V6IVJpEL1CyIucusrFQ=;
 b=FPLVBux9tkmSk0VW8f380Sce5khfRHkYVwGytwiFUwce41r5mERiiG6bFBNVyfMagMvvlZd3NIAG7y6dWbqnWykX/qOLqxPi99RNzfruCeAdYosEQJs4UsdIcpCo8mQMxHgTDRMje8VmayACNAw1uD1k7ttjcSYR5kLLr5zfRno=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS8PR04MB8883.eurprd04.prod.outlook.com (2603:10a6:20b:42e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 16:25:34 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 16:25:34 +0000
Message-ID: <6f202e6a-5ee9-45bf-9abb-7f5f80f8f5e2@cherry.de>
Date: Thu, 19 Nov 2026 17:25:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] binman: Add BINMAN_X509_KEYFILE to override the
 signing key
To: Sergio Prado <sergio.prado@e-labworks.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Cc: trini@konsulko.com, alpernebiyasak@gmail.com,
 marek.vasut+renesas@mailbox.org, ilias.apalodimas@linaro.org,
 pbrobinson@gmail.com, sughosh.ganu@arm.com, wolfgang.wallner@at.abb.com,
 xypron.glpk@gmx.de, jj251510319013@gmail.com, Wojciech.Dubowik@mt.com
References: <20260728113535.128601-1-sergio.prado@e-labworks.com>
 <20260728113535.128601-6-sergio.prado@e-labworks.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260728113535.128601-6-sergio.prado@e-labworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0042.eurprd09.prod.outlook.com
 (2603:10a6:802:1::31) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS8PR04MB8883:EE_
X-MS-Office365-Filtering-Correlation-Id: e5296653-07b8-404c-3deb-08df4659bca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|1800799024|7416014|376014|18002099003|22082099003|3023799007|5023799004|11063799006|261026140227099003|56012099006|4143699003|261026121527099003|261102123227099003|261028144727099003|261022075727099003|261022115727099003|261022105027099003|261022113327099003|261021135927099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: NMuBq/vTCUCyCMunWyL228xgqSWlEmwNJjFm/9wvBpGdM2SuQnzihmwE+hzYrDOC4QieYF7tnhcIsmlBkDwJiVTAHt/MXpssxHK/UJxrE4wtKjd86b237aYFyxCGlSVKxIKxVEVBAOofsb6mLNGmwt849IfSp057p6+FLJxij+ZbcG1h3KGn5QyiNj8i1cfJrhYX3DHi0NvoT4A2AiDXUlpcForJSkO6Avg3u4WuXIpMieBKm/oJKQGxJYbanY7wEkRDjzLpOVZvGTAVTk9F3+XAdCcgkvIqPABMrDDR7S0s0VRDI+YcaAuBBv5G/+h7yRYzIT993dZZZvQpTJiasL+YEp4huNmNEbQn/OUX6zl24PhHUhODTLBVeLMq1nIsMJe3/QNh2Gr+L0AhN+CbmbRSZHjsExKFgluHHrqnuVzWfLSC9CAdD49PuklXT+Ca5Oknju2KsJpt4ZSUnkOZq+YFUQDihHZy42NNPaOA5TmUvWDV12zwSbPNleBsTg2kAMoidTYrj+jgVOfG4j9oAVPO5jdpGmqUl+1vAFbcvbeE9btU7eufjzXt49yBsnF27XNSp7nzV2jWsorPekhbkvB0sMyfwnES79Wa/pgswGyQf/JnxWWJ0KLGyLTwbjvyArOcIVjoZA8Kzx1oy6fDs5QgNQeTVqMTtZLp/8S7j+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(3023799007)(5023799004)(11063799006)(261026140227099003)(56012099006)(4143699003)(261026121527099003)(261102123227099003)(261028144727099003)(261022075727099003)(261022115727099003)(261022105027099003)(261022113327099003)(261021135927099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0dSRUxzb2xBSWFzRWoyTGlPSEZBbVZ5bEI5azRFd0Vudm0zRW1BWmVDZGt5?=
 =?utf-8?B?cTdUTWRHRGVwT20wQ1NMSVE1OGtRTGpmQjZkanR4d3FNYnArZzBTTnJYQk83?=
 =?utf-8?B?YTBnQVV1SmxzdHNicVpreDlmRHYreW9ZWVQ5Qitla3Rvd2FZZjVnT0lKMjE1?=
 =?utf-8?B?NVdtaDBua2huNVAyVEpZQ01JVDZ5MVdpVzJXZEpCNGdPc3VsWGpqU3hlV0lX?=
 =?utf-8?B?VHNiS3E4M2N0RXlUeW5ibXNHS0huQTFPR2ZaN1hPQUVoVGJHZ25KVnNRWE42?=
 =?utf-8?B?MjZRWkJxbUh3czU0elpNRTdLWTBid2IxN05kNlZ1QVYrVnBxQm1QaGNUcFBS?=
 =?utf-8?B?NWpZV3NJUVBJVFh6Z0hGbUhJcUt0cTdEV3hpajkzK3NzYWdWTG8rU1lzaWdB?=
 =?utf-8?B?ODc3SjhRcmd2dWdYYnhLUzZMNHYzcEpPVVNLNHovTDh2eUIvckNPemhTUTJZ?=
 =?utf-8?B?cVljYU1qcFQ2S1AwbEs1LytVU1JNR2VGd2F6aHlpN1VMc2RHczVPR1lRZDNp?=
 =?utf-8?B?YTJ6M1ZoY2wxMVVPSnZvSzl6UWhDQ0hlU2RKbGYwNkJ0bUpNWS9tOWtuTnp6?=
 =?utf-8?B?NHFPRGtJQVhoWnJKSnJWWjJSNHgzek0vdU11NkgwMDdlQUFiOHZHaEJGdDA1?=
 =?utf-8?B?MUNpV0FtVjhBaUNEZTdhZmlPNGFpbHNnbGlOMGlobHZFektIRit1QmVHQS9i?=
 =?utf-8?B?eHU1WWtnUE11YzZvMExvYmZCVXQzLzJFYWQwSFBweEt1cytoTlpiRGZBSyti?=
 =?utf-8?B?RDl5VUxFa0FCRjBMTXJMZndNVWNNam5UMitOZWhXcUt1N250b1FCRDBPK1ZS?=
 =?utf-8?B?VEM3dTdyc3kwS20wQnRzclE3YWtVajB3bk9zWGRmSC83VWZNQ1Ayb3N3MWlK?=
 =?utf-8?B?ZlJaSFU5SlNrdjlLRjMxekJlRGhpc2ZWOERVRDdhT3ROcWRNTVBQRG9VQ3li?=
 =?utf-8?B?TmhYdG9NNDBjUkl1ajdGZXFZVFAxQzRVNXFIL1o1dmYxMTJlSml4Y1h0emJh?=
 =?utf-8?B?S1BLQmdZaEdpbEY0V0NOQXVrd051Ym9KMjRsd2pDNGlKbVdIaDk3OE1xRmVu?=
 =?utf-8?B?S2laemYrc0dKWS9ZVnNvV1ByeUtnTXA4YUl4aFBUektTdFJWMFZJWCtCandq?=
 =?utf-8?B?RHNCUWtkMmpTc2xpTWtsL0ZGc3ZScmxHK1FGZkttbTBVdDZxWEdnOGpOdVA2?=
 =?utf-8?B?c1ZmdUlXRkJ0NGVTZkNhdm45VXBjR0FSc1BZa2FLem1RcTZmMVgwVnhBSEc5?=
 =?utf-8?B?d0h2dE03VmliOU95LzJkNWlxeEZDK1RBRHdmUjR0MERFZ0FrNEtWaWNiN0li?=
 =?utf-8?B?cEJOVDZVZ0NiU0dhUXlWWkU1UHZsYmxDcFVoNVpsZG5CNkRHMDJBRjNURnVT?=
 =?utf-8?B?blREb0xZSEtwY3JKNS9YNTRPd1JDb1BiTlQ0S092d2UvNzVTd0VJWERMWEE4?=
 =?utf-8?B?Q3dUejd1QTZJZTdJMDVNMm1jUnZWM0t0dWl2N1NxeTM5QmZLQnB1SmtLMFc3?=
 =?utf-8?B?a0VobHJQVnFGNVB3Z1NldEZqbk0rRUcvSW4wWUZSazFVZ0kxaXB2bFVteFNs?=
 =?utf-8?B?Y2J3UGNMYnM2U0lRbGk0NGtJelZnYlN4aFdFa09nSEhLdGlsaWhkcTc3dWlE?=
 =?utf-8?B?N1pCVjFMbzRUMkYraGxGUDI2bVVZS0p0S2tVSzA4UWVndFZOcjlWQ0NTajVt?=
 =?utf-8?B?NTVhRCtEeUZNWHFsWVJPYUdrM28zOFRobW15UHd5a2RaQ2FsNVJCeCtVWUJx?=
 =?utf-8?B?aHRla01zd25RNVlTTnN1SHpNMHpvSXBwNUZLakRISUxzQ1djTHhaa0ZsWVNS?=
 =?utf-8?B?ZjZDMExoVDhYaXpDdGZXbGI0Y1ZZYjJZNlpnMWNQdjl5SzFuSHB4bDdwb2RT?=
 =?utf-8?B?VDFwUTFYZ05vdlVGYmxkYXJrZi8rTkMremkyTW1YYks4ZVREazMzd2dEMXJm?=
 =?utf-8?B?VHZad1QxUUh2MDUwZDJEaUJSU2FWaHQxYnB3OVVzeW9IRWljSDJRaDJxL0dB?=
 =?utf-8?B?cm83dWxKUllpN0VFcGVQM1FyKzlQdWtVb0x6eUhqbmlYMTh3MTBLWGkySGFJ?=
 =?utf-8?B?UXJacTVway9wWHNKbm1MUVhqQ3MvRndlTHdPa0pLY3B4cE0wU2xIMXVWLzBv?=
 =?utf-8?B?TjF3bHNMQmlXNlVQV2NnSnZlUzYxUFd1emZKNk5yNFA4RSt6WURjYi9zSEhZ?=
 =?utf-8?B?NXhwd3VBMVJpTTZqb2hSU3BZemRYcTl3aTE1QXVnUyttb0hrQ0xhL2VjMDFD?=
 =?utf-8?B?bXRFSEFmUHBReWhYYnJ0UC8rZURJV2FTd2wrMXFhOVVPem1NM2hrNDFZdEFR?=
 =?utf-8?B?WUNMbXY0bzcwZEI5UGZMN09qdkwwcWw3UjAwUEhiRFBNbmQ0a2ZyVkphcHhl?=
 =?utf-8?Q?UGLcii4JxGwt+Ty73iwzOXl/iT8/zZKFli3MHPX4nPOfx?=
X-MS-Exchange-AntiSpam-MessageData-1: i+CCBPRctWZnU2Op1mG8tu4sHxGZYVrO6os=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e5296653-07b8-404c-3deb-08df4659bca3
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:25:34.2445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mDajsH/937j8QPbwkvda0SWQQsr2FOYNsbEnWnN0cKoGRfvQG4h4ZqfwHgqigCqn1pSAsA60CEDijLU1jxfV+v8UD+NjhYtpeNq0jkTe0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8883
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Sergio,

On 7/28/26 1:35 PM, Sergio Prado wrote:
> The key used to sign an x509 certificate entry comes from the image
> description, either as a 'keyfile' property or as a 'keyfile' entry
> argument. Neither is convenient for a build which must not carry the key,
> such as one signing with an HSM.
> 
> Add a BINMAN_X509_KEYFILE make variable which, when set, passes
> '-a keyfile=<value>' to binman and so overrides the image description for
> every x509 certificate entry in the build::
> 
>      URI="pkcs11:token=mytoken;object=mykey;type=private"
>      make BINMAN_X509_KEYFILE="$URI" OPENSSL_CONF=/path/to/openssl.cnf
> 
> The variable is a plain keyfile override, so it takes a path to a PEM key
> file just as happily as a PKCS#11 URI; signing with an HSM is simply the
> case which needs it most.
> 

I'm only worried by two things:
- keyfile is too generic of a name and might be reused by other entries 
in the future and this will break them,
- it applies to all x509 entries, so a binman node with multiple entries 
will only ever be able to use one keyfile.

I don't have anything better to offer, and you could technically already 
call binman with -a keyfile, U-boot just didn't call it based on an 
environment/make variable, so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
