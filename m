Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE12606A320
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=075aHU6H;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=QqL+yuJk
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 294EB60E1C;
	Fri, 20 Nov 2026 14:22:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L04-vq6oQAcO; Fri, 20 Nov 2026 14:22:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5774760D8E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795184540;
	b=rRFNXatFa1N1z0peV7yg7AHRddGCU4q5XdnSE1KzGEdpF3bMGnRrzxM5Lb3mk7nWr0js
	 h7hJQb/qvj+PYikplAAcFCZmaMszpTTtEpNI+xluPaeLPpErhivDsLXephXoleNz933gT
	 dbKfKETm58EufF0LoNzUO7ysuWR1RKzGUbGfnUB6nPx0rFD16CywMP1BEjpF3O2BYwwN9
	 iR7Rurrtz8IxEAyABAv2H3WJn7WD/LI8habXw+p7+kwkZncYJxQN7PEQNH8QZ+dy/KVUY
	 UjmZjVu38hNJCF2MGMDlEZjKg0I6DelamLNg0ZbGT2k++GgLHj2b3TTzX3sH5YW3T2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795184540;
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
	bh=T4iwvCKTKULeAr1X0MjIfStw9F/ap2rnA+BGxze9hZY=;
	b=Ou0rpbMI0uwhjI9A6mvyC52BiLxak5aNScApkt+4CEEbo+dF2F3mLvHaJFF/AJvwqADa
	 QAhc0z4oAtew/3iYEZdowQ45QdThvNYkqzlL87na3ovvhoC2G0ZPelniwEcmfuuC10Im1
	 IOAMHULLc+3pL5q0LURaLyKvc6wBb1hBydgyWengxZ+wr04KAG/Nz4kxgFA33lx5tNYT4
	 dZ9XqcJUTnQ2TdnuKbPi7Ob0f9/UUcWfIZlU83T0cXJFTIB0RrVhAweSSso5O9CET+Ehl
	 rilC90EH3iEQZnCO9lPFUZ0tOTNI65DXP5UAmbW1ryy31mD2bZM4YHZQsWCeenSafng==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795184540;
	bh=T4iwvCKTKULeAr1X0MjIfStw9F/ap2rnA+BGxze9hZY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=075aHU6Hqt5y2yZO2kqBdiIW6cG9FwV12Fsw8Qxg/iqgAR4O5rlKyQeOzLD8dSIAj
	 k5fSsuOBTur5OcRIOK/U1cHVOVOwCzMHLJqBYc+QSRPOmSNZm8YA7fHaL672jgTxfA
	 zD2Bc8Pw2WJineHMZfHVtPQH22EtCDg/pC8BdACwgGt16jvgH2X4jo7fO7kxT1ZxKx
	 Ij+GTVI/d+4I+GW4ebr6YP/lyQ5Gk+qzy1bXJo5RDyLFakOrFIXrWaRuneLVG9Cg5D
	 v7/m/NkCeme+nnYB6uWPhu0aP1LneEJP59G/+jYwGiyPoPUjWnhdWA42AKB+cCE1HX
	 r/0AGORVjLvHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5774760D8E;
	Fri, 20 Nov 2026 14:22:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D7EED15D
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:22:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C9AD481698
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:22:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rjWLrb1r7Tdo for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 14:22:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6378281690
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=QqL+yuJk
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6378281690
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4iwvCKTKULeAr1X0MjIfStw9F/ap2rnA+BGxze9hZY=;
 b=QqL+yuJkU9Jit6w4MXmifMU/7nwC+okEadYXqwb8C1/laL0bosZVVnOtoPq2xSQVkrgsemzGQLOGicBiULbG8RIFewXhi7Ovw+nJWPrLWHUBzY/vunHCX9wm0IWC7dYdHjZ2E0BktT/Iul6NhomrcN8yw0Apbret08NFiJWDIyY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GV2PR04MB11635.eurprd04.prod.outlook.com (2603:10a6:150:2cb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 14:22:09 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 14:22:09 +0000
Message-ID: <c59bc6eb-f0a8-4a57-bcf7-0b063caff546@cherry.de>
Date: Fri, 20 Nov 2026 15:22:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] configs: pinephone-pro-rk3399: Update defconfig
To: petr.hodina@protonmail.com, u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>, David Heidelberg <david@ixit.cz>,
 Ondrej Jirman <megi@xff.cz>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Anatolij Gustschin <ag.dev.uboot@gmail.com>
References: <20261011-b4-pinephone-pro-defconfig-v2-0-6b7be35fbee7@protonmail.com>
 <20261011-b4-pinephone-pro-defconfig-v2-8-6b7be35fbee7@protonmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261011-b4-pinephone-pro-defconfig-v2-8-6b7be35fbee7@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::18) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GV2PR04MB11635:EE_
X-MS-Office365-Filtering-Correlation-Id: b66ed42c-bc55-4a86-f53c-08df4711a946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|4143699003|11063799006|56012099006|261022075727099003|261022105027099003|261021121427099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 8HtdXxVf1KzQGTqonGHleD4Y+OTWH9ctP3+BfPr2dOX7Gbw2Rrnq0rxILc1TVMP/Bamruenke7fl+UfeGajskblsBJ4I5k7ZqrVDWAe1RoApPOX+UP3Yn/EJvX1FInpenSoAtBKDsJSHtK+8E0UrcW6RjA0eL0CdMA5uFiuf1GhqMlt7H38Za2KT7h+2f0Wi9VhN/MUjwMllIw8Nr/KvUWhdW13i+ZMzzylSeTHZJXTVbEL0H8W7o0nOMS1+EmJWCRm/OlRVBAP/R6PzUIHYuFj12sRg1yOLfqWft82UDn06UNxmFhtiLc0RHOHHfdh8d0/ESMZbbNNJKoZrOhYhpcjTN+b3CtBHetpLceXPX+wvEv5bu51NtC9IQb5t2CPWVgs4fytLRFGR96acAzWLIPNxa9BJGPRUKiT8NTIdfeIKEzIsFUdcZPFwS/pF0HjmJV3KTM3ezA6bSPoHjvImQc8QxJ8jig095ZrmvwZq3PJMTmwaK/4KmtU3+iqtmEkSGfS4H2Ywj8XBVF+fM80en/qAJ+AQSY0mJFStWv+qj2VRvFGJhOW8fa1fCcXH8TEgWgcXWVMpjY8bV3iyOGQTNP2Wz6AN0KJK6jBkiWvlynRPwjijr4U0Efk34tQiG6HO/5uYMGYQNe66Qj7oYaDjed+TbImDiedL0hCvzTf1o8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(261022075727099003)(261022105027099003)(261021121427099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0hBeEhEZ0htWVdWTU5Ra0FLdHdsUk12enA0VE4yVng5bmRJRUkzU3gwU0xu?=
 =?utf-8?B?QU4zNEhObWJ5OXFaaGEyMitjd3V1QTE5WWdZSUtnWmtHUlRETHp2dzlCUUFE?=
 =?utf-8?B?REZidCtCUmxnbmx4eXY4eVZxSW5FWFR2RGZtOEc4c2lCczFGSjB5UnI4ZzB5?=
 =?utf-8?B?L1NYZTFoWTFMbXFlRlVqYWZ3aDVlckdZVXZKUEpLOUE5WVozTGExWm9wVXZT?=
 =?utf-8?B?c1F5eThtMGtsencxcTcxYjBHZHgxT0ZzcUtOVGhYSXp0TWVlV0FOWlV1ejQx?=
 =?utf-8?B?Q3pZWlV1bVFpdUczeDNTcHB2MldCbmhiWjRWSHVZSCtLSUsyd0p5TlhDcTg0?=
 =?utf-8?B?cXdIYjRiVkN6T0N0TFZvQkk2b3pWU01OdnhSaEE2Q1ZhNDBZQkdaTldrbmpJ?=
 =?utf-8?B?UytaRFVqR1FkSDhlS0tSaHFuaXJ0U3Y2Zml3M0xCY3Q0U291aFprSzFub3F4?=
 =?utf-8?B?QVh1bUVKZTRpK3RxWWN3NGZrNmRVa0Zva0hSWWtxNHlJUTRZMlpod0hKME5O?=
 =?utf-8?B?REhpaFFNU2N5Z2NvUy9sRVVoVVAwN0FGNlRERnRxckZHbTZZM2NQTDNraHhC?=
 =?utf-8?B?UVErT1JISjl4NHRTUVNGbmtXSCtMTmdSL0NoUjZ4Z1hGRDUxc1JsclVGZGJY?=
 =?utf-8?B?UlBXZEF6d0k3UFlZRjgxdlI5d01mT2dwTFg2WjVZeGwzcGtQNEJMdzhTNTZ4?=
 =?utf-8?B?TlE5RHJTdXFvSExzeE16OU15YTF0TktTUzRqb1dhcUFuU0pVaWdmWFFFa1VZ?=
 =?utf-8?B?VGxoMWphS2RicktJLzlOYlo0ZjNsQ1RFVkFabVJJODdqU0FIZjVEVWdPTG5P?=
 =?utf-8?B?SHYyNkI0S0ttVVRHTldMMGd6NFJqcTRJaDFlSWwxZDlFaE1WL3ZuamVvRVdY?=
 =?utf-8?B?VU95Y3hvWEZxRDdzVmkyMTZFenRtczFObUtseTUxemc4Rk41Ym1SLzA3NFlu?=
 =?utf-8?B?WVppTU9Fd0cvMUdacHpzR3NxTVY4VTN5bnYwc3ZyUkdkVSs4dzFqcjladzJV?=
 =?utf-8?B?clF0ZzRiTnRQWHhmOEh0VkxYK1pUK2NLNmFuWGFCTGF3eUZVN3RjQVRsWjdO?=
 =?utf-8?B?bDQ0MmxFWFVXdm1MYnU2K2NVYWZodGN3T0lmTlFTRVFDRllCN0haNGtORUJk?=
 =?utf-8?B?emtBQkZrS3hESWt2R1daSTRvOW9sZWY0c2tPSFVvWjdzUU1Nd3J6OVpKOHEx?=
 =?utf-8?B?aFVsYWQzRjhVNzNZcTVsdzhuTkZEWTNsSUN5ek0waGUyRndEd3VLREh4TUJH?=
 =?utf-8?B?bGQ4bU5jOWVZSTY0bE42RzNmZVBCcnIweUNMWTZhS0YxUmVoVjR5ZGkzVFVQ?=
 =?utf-8?B?OWY4RldPV3Zzc2VwSkM3cWtXS2VYbXRUK05HdncxTHBZVWJPWmwwUWxhY2gw?=
 =?utf-8?B?WExsYVpRb09tQlFvYTB1S2UwRWZSc1BjWUFlUzBQVGpreGQ4OE1jMW1teVhF?=
 =?utf-8?B?bEtPUURUNm9acHNWa2pVQjdNRFdiVUxvNmRhMExtNFExS2xldmMwdUdYVzZR?=
 =?utf-8?B?K2JKSkdZRi85TW9pN3c0WlpuM3cyWEFkNEtuQldpbHpIVVlsMEE5OFRkWEor?=
 =?utf-8?B?YXBNNytQZWJoc0pjeWR3MmZJT3JxaFRLdFBqK3NZVlFqRWVaSE9OY3kvVkwv?=
 =?utf-8?B?NW5IUThRQXpjZkwxeTN4akRSY25jTXF4UlM2SzRnSERIb2NnU2Jod2lEdjZJ?=
 =?utf-8?B?ZStwUU9wa2JmRkVzM2RpQUxicDJrVi9wWC9NM0tNc3NrWWNWVDBaVm1HRUZk?=
 =?utf-8?B?V3pDMTR5ZEcrRUVKVld1dkduWldyTWZkeWhIdE82YTl3MEZRNTlUSXNWSE5F?=
 =?utf-8?B?MlJ6R1M2eG1MUmpiVjdaWFRsaWlabzl6elVTbXE2dXBFektjSElPcUNpWmRw?=
 =?utf-8?B?cEs0WGJOZG9zRmJvTzlCZUlUU2trMUphMWpjc3ROQ2pwemRTK214dGtoS0pN?=
 =?utf-8?B?WDZHdEZuR0taQ1BrYi9aWW1jSTdzUHpvaXlPdW8weUhNU0YzZFp0VUd1d1BQ?=
 =?utf-8?B?SFdZbzAzT3dEWkJGakIrZG5EUUFkT0pXTTJTdXNNeE1TYXh3SkZib3kxdy9Q?=
 =?utf-8?B?Y2hqV09sYlFjVXp1NEUxOXR0WDlrYXBHY2FVejFPZlRmQ0haYmhWZkFUYXVs?=
 =?utf-8?B?bjFJdmhlc09sRVlHUWhHZStwclp5K2R1YjhQTWFiUVd1aTlsUk9EbUpVVWs1?=
 =?utf-8?B?L0hiTm5ZQXQvM1hyZVJ0NEVmZWN4SnVtZzYyaWZWUWZEZ2lqQW9DblFGSUVp?=
 =?utf-8?B?OGRrLzAwWENKcGxGZUFnRUY4UTQ4UTFWV2QvRCtmN1d3SVpQK0JRWStsVmJZ?=
 =?utf-8?B?TVowZmE3dFJDcU9mRm9kZEtGWXFvdGJyRFE0SVlGUzdkcnd3NGtnUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b66ed42c-bc55-4a86-f53c-08df4711a946
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 14:22:09.1441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RFNDweRHS7mWS0Ec1IO95C1DuQfjA3lryGFbOVvBaETsQ+xCV6vev9teGrXxUc7vQiKYiaQ9YN8bnEiuC5HO3+B91q+YY5hMm21exvU37MQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11635
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

Hi Petr,

On 10/11/26 9:35 PM, Petr Hodina via B4 Relay wrote:
> From: Petr Hodina <petr.hodina@protonmail.com>
> 
> Enable:
> - the ADC volume keys and the keyboard glue with phone key remap
> - the USB gadget stack with DFU (SF/MMC/RAM) and mass storage
> - the watchdog
> - the clk/pause commands
> - replace the eDP display driver with the DW MIPI DSI one which the
>    Himax HX8394 panel needs
> - enable the D-PHY helpers and the video bridge uclass
> 

todo: group individual features in a single commit. I can identify at 
least the following individual commits:

- Video output,
- ADC buttons + remap-phone-keys,
- watchdog,
- DFU,
- UMS,
- cmd_clk,
- cmd_pause,
- removal of eDP,

This will help us revert/bisect things individually instead of a big block.

question: what do you use CMD_CLK for?

question: what do you use CMD_PAUSE for?

issue: missing justification for removal of eDP driver

I'm assuming this was a mistake made in the introducing commit 
5a42fd025859 ("rockchip: Add initial support for the PINE64 Pinephone 
Pro") which enabled the EDP driver while the DTS doesn't even enable. 
Likely a copy-paste issue likely when starting from PineBook Pro 
defconfig, which does enable EDP and has it enabled in DTS.

Cheers,
Quentin
