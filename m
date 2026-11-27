Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F319606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Wc6Z/eJO;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=AabVlKeB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5585C812FD;
	Fri, 27 Nov 2026 17:56:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZoTueUDJgaFp; Fri, 27 Nov 2026 17:56:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 64558812F7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795802170;
	b=NPT6NolXrDdrgL3vaxhnkSH26xR9bU4rJHg/mSVDNS8UMNnIatwt4niBNzcsmgUxkz6r
	 XeaBrp4X+JrDlQvDzhNdcSkHS0hzfDEH5fALLrYTxwedMEqtIMdHwUFxWGu0TAkUTSXiT
	 kJC1ylAqvVyJCtrM6GnAmxi0fUp939qxTyJYpF+8mld17m7iJYrLYdajCIpQGUFev8ubQ
	 d8vlzYhlaCz+kE5i3NrvSBTBTUbSN71+i530n1VRLWtojBZzEtJoFwiWizUGin5nEGHwz
	 slmeyNl7qtUujJCrqCKEH9ZS1igth+17Iewig9wpJz76bjCg6TH3agvRKszmm589eNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795802170;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=4iQu65D8xWZi2uuZjNrnvPKv0nRqCNbvKEiC1C5Nzuw=;
	b=rVuaqp+dLahVq3zUAotar4/hx9x0hAPc0QKoS+MogpFoqYrecGPZLkvWvLSgWgGolIjC
	 0ofaNMgoyxcRcm40MhidnqLxyyiNSjcfHElfGXnwYJy8kfiWS/XhUl8m3UQwHBGVRPHDS
	 zEI8L/j2CwdOFiu5NOuXNBNOujMVZn7NWvnkji1qv6RGHBqFleeOPITembXKTb4X8saVj
	 WtWn0YbsM9ejBkczTDB5fgnI7BlhE5CvmMlRApK1QU4hS/YtebYSag3umTrVufT3DePri
	 /TmppVzNX5uyO63Fw0cnjKVjobRxppdD403B0lWo+jDGyC7v/fS+TRPFQC8ANmxSChA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795802170;
	bh=4iQu65D8xWZi2uuZjNrnvPKv0nRqCNbvKEiC1C5Nzuw=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wc6Z/eJOZdPTmpw8Ry7SSEezEe61dT4r/s3LBDodSa5lUudgmka+ppjirUIWTiZTG
	 7GrMnEm9khn8lG0R1qcQmlB8pJQSaR6oZUClTzGXWRb6Mf93iWBMiS4S09bJQpD4DN
	 nh+fmbZ7cnzO6Hs18DifeUzNvpF5eEaDmJp4GLw2wfwr3SW2KC38wZOq6g+IEUD3cc
	 6cmkqQ/eEvqz/UCXcDCNvI2VjDRcDv59/g30A6UjlV8lWSfBbbM6A/vF30vtjKx7Oc
	 3Tj+PFToKviZ8+uHE7h4f8mS33SQuHt5uAc773uf+SNvtwROZEQwXWZDiUcKVeYHAP
	 CToVsgmdwlK7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64558812F7;
	Fri, 27 Nov 2026 17:56:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B7CC326D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 17:56:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9D7DD40B12
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 17:56:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yMQVPCV2VQFl for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 17:56:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 319BC40B04
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=AabVlKeB
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 319BC40B04
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 17:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iQu65D8xWZi2uuZjNrnvPKv0nRqCNbvKEiC1C5Nzuw=;
 b=AabVlKeBcW4SeUjlrs3FXNjpDJomuY6OFw/2uDu52z8u/3Sy9uHvK5SLPZjgpeTLT+Km4I3JfLGh7kLGgNj+ogP8tiB4hYUBjOit0n/qccRSQ/D0En4gObE+XiXVHFAk3Kg7xkwcC51vDDkmnuY5LNQZ4wXzNBoji9wp+LsWWR8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AMZPR04MB295117.eurprd04.prod.outlook.com (2603:10a6:20b:7c4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Fri, 27 Nov
 2026 17:56:02 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 17:56:02 +0000
Message-ID: <0f72e884-5be2-41a8-b18c-b5e2b16b7fa8@cherry.de>
Date: Fri, 27 Nov 2026 18:56:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] Dockerfile, CI: Update to the latest Ubuntu
 'Noble' build
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261125134317.2479815-1-trini@konsulko.com>
 <20261127162927.3545062-1-trini@konsulko.com>
 <20261127162927.3545062-5-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261127162927.3545062-5-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI6PEPF000001F9.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::907) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AMZPR04MB295117:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c8eada-ba20-4f7e-de16-08df4cafb3a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|11063799006|4143699003|261102123227099003|56012099006|261026140227099003|261021123027099003|261022115727099003|261026121527099003|261028144727099003|261021121427099003|261022105027099003|5023799004|261022075727099003|6133799003|18002099003|22082099003|261009223027099003|3023799007;
X-Microsoft-Antispam-Message-Info: IJpYgc5vzWcDxHD8StPC49DjvtQLdW2PS3ph1P6QK6CA++qAznTwBUYKZiNQhNdGu8TfN8riDzH9IcrABiRqPF59LsqM0l3xwUayUFU/yZbkjXwft1U5bkBJAOevyKtEZ3P5t3Zo9vNcOQ00alqteq2nhcrNxyEhL9MYWZ8sfK+P66+cQk04/M3rF49BNMif4kDJxCvm2JG98eWjW7tZYARR80jlpxRfLMeg/YiSTQwuz9BGYpuPm2RiHgZd9GUCAgUY3Ju9v/1QqgUY7z2PF6lmZUbZmdO4JPfHqJB6FnpBcFmABfCOy679Yaj58r/kFfiHKQ8wgtvvYY/vKe/fi8fvRKjvWj3lm3N6VgHlG3Im5jNa2d7hsXG2Ne8GJNoukHrQuYHf0TYLSAVC1kJ3P1+Q/n9bGPCdA9gEBLupXN0AysC6dLKtVHFCtKrwh6mTKledY+F/hvaW9OG/4DyxgmMm9Uqdo2IdrdLXeYIlnqdHRrONKe7DfIK9nGpFjYr3m+7u6Y4rb/KewhXiAeigGqYFGTGuD9EOnIrsy11Tc0vqgthZ/HjazNdpamPqSlN5j3scn0LlifkRDkO9EXIHT7ua9gNx7++N6a9MNGUV3Hi/AkXJattZeBwLBAMcNvlmg9mSn8zZjNvCgukcmW4F6xbaLw5w1A5cGUd4FBkf8aM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(11063799006)(4143699003)(261102123227099003)(56012099006)(261026140227099003)(261021123027099003)(261022115727099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022105027099003)(5023799004)(261022075727099003)(6133799003)(18002099003)(22082099003)(261009223027099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2JrOXZuZ0MzNXR4dUZXT0g5RDVNaTdRS0dYeWN2VTJQcFhUWktqSW4xd1M1?=
 =?utf-8?B?dmR0cXRkdUFxektTdk5mb0RVeitPdjI4a0E5cFZqRmtxV2UrTWFVWlptVVND?=
 =?utf-8?B?dHNRU3ZoMG1EZlF1dHdLM2d6ek1mMnpKbUNRUGhzamNIS2JMdGlwNEJEd0k2?=
 =?utf-8?B?QU05UlFtYUNKZHo4NVpTUXJKSUFkOHNocyt2ZXo4VHlWNUpUYU1laUduREwx?=
 =?utf-8?B?T2E0V0FuZVZyNTRSMEhGajMwMXhyNWFhWi81amN2L1lkZFNzSVBwRnA2Vlhv?=
 =?utf-8?B?WXJ4NmJBOEYwa0d6MHhuVHJXdDdhaEtNMHdCOUpsNTh2WWJCWmJpVTJ0Tm5p?=
 =?utf-8?B?RUQ4T0hScjNGYlU5b2tHMmpEU29kN2lYa1hSeml4cnFOandzZW8rbzBBZ05m?=
 =?utf-8?B?a0Nic1UwZEI5TG9ldE56cUtGa25wSXVrZXZKa1J6YkdWbWsyMGZsMFhKWWVi?=
 =?utf-8?B?YUliUzBPVHNzVzNZYXA2cXQ5ZzE1a1hjYnpudnNMYXN5UWVIN2ptT0VtU1V1?=
 =?utf-8?B?TmJrZ1RIZWc5ODZsTVVuY2ttWFVDL3BnS2lSNFZxSE8vRDR3b1kwN25Ma3Fi?=
 =?utf-8?B?V3RPM2ZVWDExODN4U2lIQVRSd1JOYXhObU1zcUNUc2JCSjRUd0ZCMUdSME1D?=
 =?utf-8?B?a3hObWQ4TnJXSjFWZER0bmVvVnpGZ3dQOWhMUk1RRk8rMU53Q1R4TmFwby9k?=
 =?utf-8?B?bm8wNTZoZm4ycm9SRklJZ2dkeXNpM0pKZmRKekF3M0hQY1ZSN2VBa1JMclF4?=
 =?utf-8?B?MGFvZ25vRzZ1VnFwWTJnem1COS9mUFdtK2xVNVlKOSs3a1RhOG9MZlFROGtM?=
 =?utf-8?B?OTFvWElVdEdINkE5ZUhvS2Z3MlU1Z2YwK0dpSnZuV2pVVVdvcS8vU2NUeXVK?=
 =?utf-8?B?WTlHRDI4eUVxczVNbE5qOGtsdHJ5eW5XSEN3c0xicFZRS1l3c3k5WXBTWita?=
 =?utf-8?B?RlczRWNxUk1tRCtGUWlHclloeU5YMU44dTN6TG9HOEdlZkFMaXBZdnhyajJp?=
 =?utf-8?B?emt5UGxiSkp3ZmlVUXZlOUNBa0szby90ak5nTlpiVm9BVzJDVXp4MUZUMXl5?=
 =?utf-8?B?YS9LOGRBRjVvVExvODFURjNicGlLaEpOOVpVd1h3NmlTQmdmRzN0RnIwVndU?=
 =?utf-8?B?Wk9NUkM4UmdkMnFKZldOQi8zSXJOS1VqQWNLdVhqdVZNRkhWZFhqMFNoSjZW?=
 =?utf-8?B?Z3hMdlF1ZnFERHV3NVhMYU9sNEVsNXE2bTZxWDNPZkF5MmVCYUZZWHVpRTMx?=
 =?utf-8?B?UzJuSkJVeXkrL25RZ1RrVTN5NlhuSGEwVjl0NW1IQzZWQkdENWYzSk9Jc1JE?=
 =?utf-8?B?cHVsT24wWkN4YWM1ZWRYYU50anlFT1FiL2NTTkxFd0NoV01DbThCQXNzM1Ra?=
 =?utf-8?B?YmdSWHFKak9vNjJwdDNvQjVKbDNFcVhwNmVjMjlUT0JZNTVRNURQQ1JpU2Fj?=
 =?utf-8?B?eDd2bmhhQjlLUDE3TDIyelp1dEhGRUc3UHVpLyswQit4NGhDUTNlWHIyNkhM?=
 =?utf-8?B?YTAxbmRzUk9kVUVtUloreWFtSHM3dVd5bnBkbCtPMEswb0VZVGJieWFxem05?=
 =?utf-8?B?RXgxUmZtV0l0K0puUlA5NHd6OTc5TTV4RUdnVzFQcm9pcDB3a2duamZkNnNH?=
 =?utf-8?B?ZUd4QlVURVppL3pKYnVZdGN4ZzNqQmpQcmpCcitHekNvc1MrVCtSN1BZTGZY?=
 =?utf-8?B?Q05HR1RHYS9raUNiWEJ1SlZ0QXJicVVFdjl5YUZsYmtHaFRuMXI0a2o3Ukc3?=
 =?utf-8?B?aG5pY2NzM1JLZmM3SjZxWmVzMjk1bVk2Ym5RTEhRaXlpVEExVHhBNzE5WlQy?=
 =?utf-8?B?SDc3VzJGVU5iZ3BvQjZGelhzVDB1RnpQZjB3eUtSRWdoZ0p0clpmblBwSElT?=
 =?utf-8?B?TWdJZXBjdHZlMmFaSW9ndEp5RFBGV0wvRHovbk40dFl6SWF3c3UzU3BibU44?=
 =?utf-8?B?aTJKQmF4UGF5MTZsMi9lSlVGWk9uU3NjTEVFMUx4RGNab2dBVXRrQTBUT3ky?=
 =?utf-8?B?UnQ3WkM0YS9CbTArbTFjMnh3UUR2elIzUkUwN3l3Uk43R2hJT2cwbWlTblFU?=
 =?utf-8?B?QmNMTlRzejVwNi9qVk9MWnlxNVZWV3ViTG1iUGJjWUczTUsxZThTb2VnN2xB?=
 =?utf-8?B?dVhRbVlDclMxT1NmcUdXeVRBa0dnQTRpRVloUE9Oc3FoQUlJbHZucTZRNzlY?=
 =?utf-8?B?N2F4eHZQNS9BYzF1ckRTRGZFMld0bW4vTDFXL1pib2IwTEhQMzJ0ZnZVa091?=
 =?utf-8?B?TDMrQ2w3MDhZajR1bnZJa3NCVzd2M2tQWTh5MjlKc09XNjhuaHVIZW1HVWtV?=
 =?utf-8?B?ZGl4OUtCL2FWcVBNQjVON0ZvZ3Uwa2U1alhGMnV4Vmx2QmZwSTFYdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c8eada-ba20-4f7e-de16-08df4cafb3a3
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 17:56:02.8134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4wUhQXsnjbRJDHxOldK2pgAiES9v5bUrzXJtYaIChjrZCRb+Ej38Vw0yhK7yf63IE05tMUJ7HBeLCQBkd021cs9lVALkzY/Wr3q5ONlhl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMZPR04MB295117
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

Hi Tom,

On 11/27/26 5:26 PM, Tom Rini wrote:
> This bumps us to the ubuntu:noble-20261110.1 tag and also brings in
> recent changes to our own Dockerfile.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v2:
> - None
> ---
>   .azure-pipelines.yml    | 2 +-
>   .gitlab-ci.yml          | 2 +-
>   tools/docker/Dockerfile | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index fcf7aafade6e..46509eeb7df6 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -1,7 +1,7 @@
>   variables:
>     ubuntu_vm: ubuntu-24.04
>     macos_vm: macOS-26
> -  ci_runner_image: trini/u-boot-gitlab-ci-runner:noble-20251013-23Jan2026
> +  ci_runner_image: trini/u-boot-gitlab-ci-runner:noble-20261110.1-24Nov2026

The image pushed to DockerHub will not match the one you could be 
locally (you can see the layers are different in 
https://hub.docker.com/layers/trini/u-boot-gitlab-ci-runner/noble-20261110.1-24Nov2026/images/sha256-feba8c676839085d4afd52fbd88409be3836f73a72ad16a01a5114e3e2640b63). 
Do you want to push a new tag maybe or maybe specify that you're using 
an image based on the v1 but that there should be no logical change 
between the two aside from different layers with only impacts at build 
time (the resulting image will be the same. Or maybe there is? Can you 
check what's the shell that will be used by default when running the 
container (the one you pushed and the one you may have created just now 
to validate the v2 of the Dockerfile)? I'm wondering if the SHELL 
instruction applies to the running container or not (it does say it 
applies to the ENTRYPOINT instruction).

Cheers,
Quentin
