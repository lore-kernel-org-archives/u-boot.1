Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84717606A7F4
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=N68P3CDV;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=SLS6VH7T
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 574EF813B5;
	Tue, 10 Nov 2026 13:31:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uR39h1scUfOm; Tue, 10 Nov 2026 13:31:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A3EB98136F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794317470;
	b=mUJLhjIAQmjJKY4Bh7VwywOTpbz8Ov4WIyndbuSmsXDHpoFILsVKrvHG6uYxXtP/Oy6/
	 srLEiwXh3J4AicaHwSra1L2jVON6tOVlXM9ReIeqAcVH6AJLYK0k1z0d4y63R8tSAhpWf
	 bJHrewLbrq/PFPHd7tA3dqdpbTOTzvznx+H9aGvAdA841wGOLSMoERYwea3SNTXiqDMA1
	 z9JEJqnCW5jAsRWlkaVosoD+ohwOyWASg/Rj5gBVj8WHJxFrVQAOLz7ac+RI056kJ9pEs
	 N8BVMsHLU+q0cSLnVgnwz+ENnaMAjEr+QBRnM1IzFR3joCXhyhIaxfONUBVU0o5jckg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794317470;
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
	bh=KWgMP40dDGOh2EA3CxXCp0qGYXM9T7QHIy6qXZNiHAk=;
	b=qSIAdnDNe8Uo63rivZ/NODiIUdbrB3AvbNXcWWnYfAPrSO9FyeuULrXQjurBepd9oMsM
	 uAxNVLPLATfhsFY+11ZOtVubOjAufrUjq7XMZX4b+zEZMIGZn5iaP2xhP6K+9NFxSVbQJ
	 SW/imSsjVRZdM8wmTd1qe975dw5h/ED4O3qUQGFIrG8nOLNbk8q6tmJ/WKN9xi4hoP+ut
	 0PJzyulDrHzY8ZuTZLb29+h/f2xswWdHurbS2/Eha56PesAdnWRAr96gTpP0Wt96yvkYm
	 Jo/kyQuASKzSH/9AsZep1jCmJzuX9fG/FXhmBi6228VEZoEqJ1ATOlrOozSZd3woftQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794317470;
	bh=KWgMP40dDGOh2EA3CxXCp0qGYXM9T7QHIy6qXZNiHAk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N68P3CDV9D6uFHpzyQOVMoiFn9M+pRr4i98k3iq5QOEPgIPk7d611sxjofuSQLQCp
	 PjIx4F9NzxGvGT7MBtiwk3I5V0EmJ6LqGFhjfW03L9v8+GtIHI38yGu3J2gcrlJcYd
	 uN6RWmia7X9WyGTvPkNV+nvFyfFhNmcDecF5YiaiGEGiCTAwH/ivYqEuaoiPUAd2s2
	 Dy/nP0PP+e/LDrbma7fw75GzV6ddA/BxxEs2ZyiwoPYwxUVxxWe6eHnenNwEhz7UbN
	 Q2yMVPAIF7zGrMe10Hws4AZk48/V7g14C11k39bi6KoHEFI05BRTbNSXadBJfRHiHq
	 tAr5m/VIe4Cug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3EB98136F;
	Tue, 10 Nov 2026 13:31:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D6586731
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 13:31:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D3B714034A
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 13:31:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1kYtw9mCQnDg for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 13:31:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4EA9A4008E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=SLS6VH7T
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4EA9A4008E
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 13:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWgMP40dDGOh2EA3CxXCp0qGYXM9T7QHIy6qXZNiHAk=;
 b=SLS6VH7TspSZDi5F0iO4emsd0XiIjzrabf+GL6oBKG3uTqsT009nOpUSdAhl8eDvqfiiHrqdZFjzwSqVq4yaqeKavmzbqFxrlXaypc9PFB8KmERJ1HwBbMy5CeJp+Ed41M0XSK7CwQ2wV/moOjAKDGNFn152QPy6jHqrpKZ7lik=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by MI7PR04MB178702.eurprd04.prod.outlook.com (2603:10a6:290:108::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 13:31:00 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 13:31:00 +0000
Message-ID: <a714c089-680c-4698-bc8b-4cc0366f68ef@cherry.de>
Date: Tue, 10 Nov 2026 14:30:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] test: Do not set DTC environment variable
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
 <20261110-qcheck_fix-v2-3-1c76e0b68f29@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261110-qcheck_fix-v2-3-1c76e0b68f29@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI4PEPF00000163.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::872) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|MI7PR04MB178702:EE_
X-MS-Office365-Filtering-Correlation-Id: fade1f4e-e6fa-496f-a93a-08df3f2edbcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|10067099003|11063799006|4143699003|56012099006|261021135927099003|261021121427099003|261102130727099003|261102123227099003|261026140227099003|261026121527099003|261022105027099003|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: LyfVMB3tafrHQU8q+bE/eKePfjDsLvkCZ23mWLxfpmnf635BVknpcyNnvQeCfCf4hHvG4epK5jm5oS/jk0vwv70l4eJP1tzFAEs1GBpQSj74qBN+DP+Odn/fuAdVTERcIoknVqlwVyGnnlX0mCNtE3puSLDSEpzqrYuagfQtVcjAxEP38RzgSbB5Of4GQo2HZ1U/Z/W7KLrJEzd8Gyg6Tk52Cz80gaqY09RuE/H/fmiUG7qe6wZIO3uRgFKWN70xUZqjeKWp6AVA4a5W4TBRHXmqloyIB7C65aZiUfTgrP3VVVN5GpJBSY2MzqTkp9ltskC1QG+7nzXqyfQOM6k1J6NUGKCG6tZfixSYKvwRiD9ed0KuliGEGKhROCcaKO4iPFspSvamIuEmpcqU2X6GAWCj/5SxsTWAPzAoCsbviEiVPRNUa1i79gFrX823+9BPnuUQcItLTlOW+AAabUavryQSSHca7t5FRrSotpp5InZncs+dgZ/CA+AKyNFIoUmlAXiKAMxBLlE8zJUeKVwertLEmCigVkw+qEXDmK9u4TRUyhGayXW/aMa36GFXZytwmDGGPLj5NCtF6huuswNGkgbSbLowXO4OsD0qmgfS4U+raMfKzve5W5aYJO37HUi/MK4B9oCbBU6Z7EnwFzARevUT6WGgtgbN8zpTZFtCMcU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(261021135927099003)(261021121427099003)(261102130727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MldrYk10Wjc0WS84aVlrdmlnRTc1WWdwZ0xzZjB5eUt6SE5HTlFsSVNtWnRY?=
 =?utf-8?B?cVVnNEJtR0dDeFpTMittREZGSk9uMHJwMzNXSTBLcXRWVnlndDEyc09kc3E5?=
 =?utf-8?B?ZVBJdkN5Mkl6dlRlcWZKRmljM3dJNjkrWllPOHNwYnFKWjVCNklRSmFaTklP?=
 =?utf-8?B?bmNWNUZJYVVhMlIyc20wRm9ZWExxaUFmQ3dWS1g4cng3SnJNbzVzN3FsYmZG?=
 =?utf-8?B?eUxJQitLTm5qZjRDVWFMQTF2d0s4bnFTQ1RxS29PeXdTYXB6NnpPQmgxbEh2?=
 =?utf-8?B?eEQyd0RPVUVyS2N6bGR1OXF6WWZPZkZjL210YVIyQmk1eUNmNkZHcnQrTzEx?=
 =?utf-8?B?RDZoZkd5QUQ3QStVMHZ6TEY2WDNVWDJHWG1tMmorei9paDFaZGxSeUJpWk9V?=
 =?utf-8?B?Z1NoQnc2cTV1Z3loQ0xJT3dMdXo1UnlPblhRcFJ2TDgzck5TYWx4aEFFdVNj?=
 =?utf-8?B?a2Q5akpRWFBrcFowVndNUFFEU2dyWllkWjJiYm9FeUwwVzNFa1k0ZW11NE1U?=
 =?utf-8?B?RlBIZVpHMmFHUkdtcmlmSUl6QzdnUGladUVtZ1JIMWFhUDJWOUtzVU5pOVlr?=
 =?utf-8?B?VXlpOURZS1FEV01wb2JIRUh2bE80NmVEdVI1NElLMDZiVk5nWWM5L3MrMm5v?=
 =?utf-8?B?VGt3Sk5iSmYxSEROdy96WmZmbVZRK1NWV29YdkZaWUMyaWRJc3hQb0c1ZldX?=
 =?utf-8?B?OEtOczFrM21FdTRvQUd2RzRRNFROa3Z2YmhTUHd6bmpCN1FUTG9BTGpZSDFC?=
 =?utf-8?B?Wk5naFJEK3JVY0tVczhjdHdGMmdIUUpNbzhUeXVMdzMxZkhwaFRkVVF6L2tT?=
 =?utf-8?B?c25LeUVnWG04NVF1ZHpoMlJBT3lQT2VhSkQyVGxoKzZ5S0U1MTJXMDMySDYr?=
 =?utf-8?B?eUNTeGdDSXNENHpJZU5WZ29PbU5VZjBuakNraHRISG9RcU1rbmhUcjd5U3ZQ?=
 =?utf-8?B?ck1qancvUDhmdTNCd2JTMmJHRitkb256ZUVIQ05MVC9YNlZhdjVqbkNTbW0z?=
 =?utf-8?B?dytlck9tTmlJVkRXVFZTaVNadDRGand1alNSMEhGc1ZrRE43T1d2Z0NweUNv?=
 =?utf-8?B?RVZibmNDQWlXd2sySk1idjF5QmM2Z04wTjFLY0RoOEhLU3BvRGNlWjRsRS8w?=
 =?utf-8?B?eTkrUTZrU3RxQkkraFRacEJiYmhpOTVYMm1FY3ZXZWF1cStRNG5pdTVxMm9F?=
 =?utf-8?B?aWFqc3RTeDE0ZFNDYzJzeWl3bytkMmxhVGYwNnBWdkxWcmw5Vy95UXQrcW1G?=
 =?utf-8?B?NWZicllLbUhDY0h6THhOVkdjOXRiRGIrN1d6WXN2dUtnWEZnOHJJR1dBaXgx?=
 =?utf-8?B?cHArWjE0bkI3U1hwWXl0NzlIMjFjYWxRRkJ1ZjBTSVRFTmpUWjhxTzlvendi?=
 =?utf-8?B?SWxJcDhCekU3S0tDRm9wUEhFaXJZYWViWFFVa2Fha3BuclBtb01tR2dVZjBw?=
 =?utf-8?B?ckI4ZTg3ODNCQk9UYVRZT2xobnN5YXFzbFRjTmRuUnBWY21SZkJ3bjQxSjZP?=
 =?utf-8?B?KzVHZHJZcWY4WFJ2b1dDVVRxVldSU1U5eWR4WjVmM1NOa0pCMzdhVVE0cDR2?=
 =?utf-8?B?YlRUTEhLamtmU2lqMXN3VjZnV0wwUTBaVUowRHY0aWpsS0RyU2xoZnRRTHUy?=
 =?utf-8?B?alRyUzFtZFRma0dnZFpEVWdxZEcyZjZzS2gyU3ZkWlRVZ0x0QnRLUms5OGtC?=
 =?utf-8?B?czF5alg1bExWMC92bmEyQUU2ZlpFdXFhV3NVWW9EZ0RkVGVYbkw4RExGSGwy?=
 =?utf-8?B?U1pvSXFQTlc4SWFCTGlvdVVuZFJYWHNvZ2ZKSlNRMVJUMFRvN0RDRXVxbG9V?=
 =?utf-8?B?QS9Vb2lST2VnQmMxbDhFVy9uTVJLSkIxYm80eWZmdVE5SkdTNU9sMnVCUllY?=
 =?utf-8?B?b1NhcWtNNzNJYlhVeWhPK3dwUnFSNXJnVjV5RHJXTHorTlllYjN2V3VSQXRq?=
 =?utf-8?B?TmRtSEZUZGllMkI3WnpteXlGd3ZVWmRiQzBCNEtDd2tMUk1hNjl0aHJpd3RK?=
 =?utf-8?B?RFcyM0FHa3lGYnMyc0Z4b1Btd2dEZ1A5NURlWU8zSml1VkU1Z2VtZytQWXpt?=
 =?utf-8?B?STcyS1dSL3h5aTR4dFJLanlTWFB6ZUVER20wdyt3Z1lOazhLd1lwSFpQaFgv?=
 =?utf-8?B?b3l5QUdjUkJlRExIQVpYZEttVGJUUGR0ZHhFQ2lzZlByTDhyV2c0Sno3OU45?=
 =?utf-8?B?UmZpWGxQVGp3RUFxYytTYlFHd0JLMkJUTlR3OTdPT0srVFhiZVk1S0RSdWdu?=
 =?utf-8?B?ZGhaN2tTVXd0aWtybTZwaXgrcC9oakJyMjhad3c3a08xOG12L1NraGllRHJz?=
 =?utf-8?B?UFgrUXRPamZiL2wxbjlhakhrd2t3R2ZEdEhRRCtSUnFzN1VMVjAydz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fade1f4e-e6fa-496f-a93a-08df3f2edbcf
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 13:31:00.0108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pojL5xwumtB1Q5dp5N8JPev8zEOE5j1I2d2vXyQ19Fmu3/HWdn3ZFmP07Jq6pOGnfYqXhG1KSb8dsanpIJnVVuAs2U9X94FMsrTBcTmXNbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI7PR04MB178702
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

On 11/10/26 1:24 PM, Andrew Goodbody wrote:
> The presence of the DTC environment variable breaks a binman test that
> attempts to execute dtc from a temporary directory using the value of
> DTC but that is a relative directory path based on the source tree not
> this temporary directory and so it fails.
> It also breaks a buildman test that checks the environment and asserts
> that DTC is not present.
> Remove the setting of DTC as it is not needed.
> 

What happens if you have DTC exported in your current environment before 
the tests are run? It'd be nice to mention which tests exactly fail for 
future reference.

I'm thinking this is not enough and we should also fix the binman and 
buildman tests to run with an environment where the DTC variable is 
removed/absent/set to the correct path so we don't depend on a "correct" 
external environment.

Cheers,
Quentin
