Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7D1606D48E
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jwLSJFl1;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=KU5WFajA
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81EB560D6E;
	Fri, 13 Nov 2026 17:59:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V-roLgNIJezR; Fri, 13 Nov 2026 17:59:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D8A7A60DAD
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794592772;
	b=SdiEcgvysZ9VAv8b3oHjLP+R/i8r3IjZHG1Cg4/vEE6/tC+jUFl7pm0C8KITCZf9Bk1h
	 qG42+IwaQIKm0gyPgnVBxGw2RtgT92UY0qyyYDes7UNwBUz6JRik+qliSV6vSMDBqFHD4
	 FMtX2INKmxCJcrPDbW/4dwiJW7A9SnvXxQjwAoHo85FcyhYsUBMN60Z2rZtKRv8LX0tw3
	 dPKOjV8Gp/WdOa0JC3s7rGozONeT7TGZ5YzI/fJKlSmIN2xQ1EyjzaQWZpg92TuPsBiU4
	 BfjBQr48tDR/qUFHZa1Ikuf9uQOla0jw3kSk7Tb9Sq9FdRK+NJO/LBxnEfhM3pqKJiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794592772;
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
	bh=vJoQ/EHvCf19A7gIN9L87zRJPR62H7aanjxv3FQJbdA=;
	b=oV+OfOCd68Qcyv4f+2yWur3EwqcnVcbo/NMnc0fLLzEtkXe8FJGxof5FevV9G36/tufS
	 rt6JUPyChumWTGHM81hQpvxWYPITGGuDexbn55O5IyTYGsYczSi+Gp0HyP8SyV38pTe+E
	 4MHlcWJOQH0ilckO9Pa8dhW+lK157z+C8cIV9opI5lL2DQShA3XAZhvtKgdUaOykdg9vr
	 diA6QySS8ZNmFSJ7bPfAJuL8CmJXPcDJ9LW4foERMfzRwykrDCwsPwWDMt3rHmVzlD88t
	 y3rv1pyJ/TPZ5GAQNeJecDOB+N/gsGGXVI+PAzel6YisUPOZ2pylPnaWQHq4VgQjV+g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794592772;
	bh=vJoQ/EHvCf19A7gIN9L87zRJPR62H7aanjxv3FQJbdA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jwLSJFl1JugZ2cEDcmA9UyOqlq/UJmTkH6FSInQjtPxgDl7ZpglyCgI5UXNOcRa3q
	 SKWhC19VT9O5B3K5i8BVx6befrKAxQGP8KMU+NUwnpn8185grjW4mJzHSsRvQjRpOn
	 i//H6EdcTm/702v2p2d8o2CZO23/pFBZix2bCq2XsYVxDQfsE7UDFBkAa6kCErOTqu
	 8U146maQ/lbom2nJVQq8GB7X6oByzIJKipUYDjtmqQvkJI0L5UwaswM4pUT+0jFhBC
	 67A2ONB7UEI/kMVML2Op8nqbwak0Wd11SPQ6/gn5qaGoYkc8Tf9Fwfi84XePfkb0Tz
	 qu9Hppb2XF67w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8A7A60DAD;
	Fri, 13 Nov 2026 17:59:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5FB0AF46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:59:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 50F194018D
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:59:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QHYRpYY_29ZX for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:59:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9DDFA4005E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=KU5WFajA
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9DDFA4005E
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJoQ/EHvCf19A7gIN9L87zRJPR62H7aanjxv3FQJbdA=;
 b=KU5WFajALplvJb1byVlpQpjAXkGq1LJ/1UNzBhJeNJTCEduT18BifP8WwQCn6gKvnI4a1vrlk2WkiFIf3KitbISEb5+HAbxj1OMltKOCTsNdW4NmWW7HL0e4MGfCQLpiK9Jexsh21AIpanFUWu5lP0tbvvw13tc8Gge8Wh1NVkg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA6PR04MB11780.eurprd04.prod.outlook.com (2603:10a6:102:522::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 17:59:25 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 17:59:25 +0000
Message-ID: <15f4622b-5a62-49ac-b56d-88082b5950b6@cherry.de>
Date: Fri, 13 Nov 2026 18:59:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/37] clk: rockchip: rk3576: Use correct PLL rate for
 UART fractional clocks
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-26-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261011222930.1085075-26-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0150.eurprd07.prod.outlook.com
 (2603:10a6:802:16::37) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA6PR04MB11780:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d098a9d-3fcd-43c2-b87b-08df41afda93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fJssZJaUOvSGZ3AwCUP0xhH+3LtAV2aO0Jba8bszcGFXuRX6aCOtofStArBLpqA1loVNX2QVMQsaU2K/9G9lqeK+INasEakvZOTJ6n22NY+41U+rCjEjE9v1LEmsszmI6l9ql3ZZJ0t2SNZEpXhqYCaZDkvWXw9168QvYcFMqckfbmaPu32yCwUbCAnDk5tPgTys4fjzWIPfIR53qIyc6hBpdAZz5cE2MTPbhOyOqKr5OtS8Hs5F/YXdEdkAydWbNm1lUU3Cl1NJOYLTkPREuaC97yh9SIp+kbppTd3T838E8yeZ7LZtPe11+iWiV90Lqy7F22n+xPKra3+WflbZYmx/Pyu2i/88TFnxYX5QW19tziYT+MQRJ7jTadWwXMZSTIkPJp07gLY58wOtmDGwVjW1iHTd76rEb4TxQiX011/m0x5w2rP+Xxyod5eKIVXDGMp1Ljs4wM8GD/Ik2aggSkTubT01n/vkgO4IGTSQJw1DR9Ke17plmAUU8FRX3wwEmC4m3aEM26VL+V1flTzY4oPQ4GQa4dX5SdzrtzpKpbzlUGqxmm9gX9K4XQGl0lJMjNOPjzJyYtE7f1GjU/foGg35Hg3SiDP7JrZOfZie49omF/D/l7XISmiRDcegE4e5JFbE/CeQ/aS2hn3pZiVHuG5IV62k+swMX2ihpQJWQzk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SCtpa0NYL3QzK0E0N3p5RzRudHpxV1d6Q1JGOWxqcjV5NENuRURXUjBOWlZ1?=
 =?utf-8?B?SUI0US9tZEZXekZLWTNibjNYeEQ5UXl6VFdONlQ2N0s5VWlPTkNvZ2wrMTB3?=
 =?utf-8?B?K25kUWZTWjN4NmtjcklKemFaRUNsOE4zcG5paWR2MlgzSUxRQ3I2S1NwTmJw?=
 =?utf-8?B?cXBkVW9NYWtuT2NZOVRyVlN5bmZDRDRaa05ST3ZZWCtSYm1QemVsV3JacFR3?=
 =?utf-8?B?RVplUTVFZlJGVTQreWNFc0VnTjNxMEJUQS9mczVBWWMwb3VaT0h1OC9vdWUv?=
 =?utf-8?B?TnNRTnRldVJEL2lVeXUrczc1RGFYbVRkck1QUVdBaExEL2xQLytvVW11Qzk0?=
 =?utf-8?B?WGQ1SkJUSy9lT2w5b0ZOQnFtS3c5TDdiSk5qMy9hUld4WDhtTGdsL3BZNnJn?=
 =?utf-8?B?NDkyTk5sYmZJWDdlSW1YUDNMWjdnQzZiNmRkeFJBamNFVE1BZUhSQzZJOGZE?=
 =?utf-8?B?aDk4aFZBREM1VUFhVGE3d3IxUXNRdkJvdGJiTjl1c05vTS9lckpWRGIxcWRr?=
 =?utf-8?B?dVBTVWJQUzR6S3dYUEhVUjZ1SGdGdlN4VTVZczE4UFFPUFdtUDA0NjNieW9m?=
 =?utf-8?B?bDZOYlR3bnJnVzY2ZFU1dW5wdDF4VmJ3cFJnWVJNU2FzdHBkOTNHd2JUSTIw?=
 =?utf-8?B?enlOMkF3YmJyL1NNazR4VnA4QVk5enJ4OGJMQ1BtY0JBdnJaVGRjUlViVEZq?=
 =?utf-8?B?Nk5oVkNFUVlpM2g5UGtBQUdRcTVYQ3ltSTZLYmRoN1ZMMDZrRVY4MnZkWm1q?=
 =?utf-8?B?Zk1FbEVrMjlUMnRxbVFUTTFKZmxoWmdpcFQxRGJsMm1WdXRVSFZNNTcxZzFi?=
 =?utf-8?B?M1R5RzhNZC82V3lmczcwQ2V5YS9hL1VVRW1QMlhwcVhZQ1pOVGV6OFhsWUFD?=
 =?utf-8?B?MGF4Tm1lOXNVZHJLNGFXaTIxYUNjVHZQVHNBVVBlcFFKMVRkNE5kV1BXZFdP?=
 =?utf-8?B?WlJxR1dtMDlGMTJlQUwrMFMrYkxNTlc5ejVrWVhLMTJoSXprWHVUMVdkNi9i?=
 =?utf-8?B?bXlLNXc1ZFhUYkNlK3FLaDVmc2U4Y2FpR2xhUkY5TnUwZmF0cEg2K3ZVTXlI?=
 =?utf-8?B?N2xFZVYxdTVpcU5MdEZTMWx4VktOcG5UMkROemtSZXp5RVRreUxQQzZHQVdM?=
 =?utf-8?B?RXRWemRlenRzdSs4NkppL0NRZHB6anJzMTQzc3pBQm1YbnZLVlY0TkFNb2tu?=
 =?utf-8?B?VVlueTBiREw5UTVyWkNCODI4Q1VaZ2p4WEhhOVd3eURFR1pEMTdlSjZjSEpu?=
 =?utf-8?B?QWJvbVFnUkE2ekc1RkJ4Q3hKUGZDNk1EZHNvM093dnEzUHRLSGNCMi9WcUc5?=
 =?utf-8?B?eHUwcWF6UE5KUzZqQm9ZalN2V2tLdnYrWCt1WkMvNDhIYytrMlhJUklyRnpG?=
 =?utf-8?B?NVpFRXBOUERiQUdOL2twVE1yUnkvcnE3cjhjK3dJOTVCVTh0WjREMG9yWDFZ?=
 =?utf-8?B?ZjMrOVh6Q2FCSDhRVXUrTHZBVDRQM0xsNWs5T05WVTluNVhRN2prVXB6Ni9E?=
 =?utf-8?B?dllHdEdycUNVOS9mUERCUCtmWE5EL0doU3YrQ2x6dnVSRHMrK3ZWN3JCQ2lO?=
 =?utf-8?B?Qk5VbkNBWVpiTmVEcVZqOUlwRm1RWi9kNDNBdTBJMDJkeXVKMUIxc1FQQkM0?=
 =?utf-8?B?L3FSYjAyeUIyRGlkdnYyNXl1ejR2MzRKbXNoVGlMZmZIdXRXZVBlT2lOeUdM?=
 =?utf-8?B?RGppcGxoYXBEdUIwZkxZTDVkY1dydTBHMXZLbnd1L1c0NkZ2QkNNY2RtaHNs?=
 =?utf-8?B?dHIvUEFwTzNleDk5V2twb2xMWlRiUzJ5TVh0QkwxZGVTYzhRaGF1SDdNcHAx?=
 =?utf-8?B?K1VFNnRrdFdUald1bGhRMEhBTkFNa21lYTQyejB1cmprZVFJaG1rQkkrTW1U?=
 =?utf-8?B?YlBzWVRhQ0FDR0JacGtKcmx2SzF0RkZ4V3FGOGNLVnlldzIzakZic1RJbUpy?=
 =?utf-8?B?blNvSnhINGFXNFpLMkhDYVdmbVNUU0NEeGNFWE81bzFrK3VmVmpNaU9sZ3ho?=
 =?utf-8?B?bkNVbFcvVUxFdHVHczVCOHA3UWxVSGROUjZoYUpMSENBOFVHMUY4N3llUDZY?=
 =?utf-8?B?bDFyVUJWV2F3Wmd3aVBvVjc2dUNqaENhaWMyNTJ2SkZuRURtT0VzVXdvQVJG?=
 =?utf-8?B?SDdpVnhyZkJvaGo1S2pKenNCc2p6UWNzcjJSTGdMS1ZvYnZGay9TNytpMnRC?=
 =?utf-8?B?VkxxQ0g4QmN2c3crYS9oUVJqaGs5TStuS1hYUzlmSHZhYi81TU5hSTI0b3pk?=
 =?utf-8?B?L0xvRFNKNTBNOW5XSWJqaWpuTEhRa0VKSnRuMk9BQ1RJV1ZwODdCTTh1RzZY?=
 =?utf-8?B?ZUcyWjYrSGtJK0IvYjJ6R0tiUTVtRXRCS2ZnQUxNejBrbWtGVVVOZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d098a9d-3fcd-43c2-b87b-08df41afda93
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:59:25.4383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWOBIodUe7n0bKXTzdWn+pchXPY5by+dzMPorTN4GYSsSt8ErtB0cBsoHc0qe6Jxag7rJBx2yeh70K61OBCq8xspSO3O0a7oaBXuVB04Zrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11780
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

Hi Jonas,

On 10/12/26 12:29 AM, Jonas Karlman wrote:
> Use the GPLL rate instead of the CPLL rate when GPLL is selected as the
> UART fractional clock parent.
> 
> Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
