Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383ED606A323
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fzakg3uC;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=J/z76QAR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FD734074C;
	Wed, 25 Nov 2026 16:19:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Njl_-8mjZx6I; Wed, 25 Nov 2026 16:19:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DB9D6405CF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795623552;
	b=J2MKs4xIoAL59JSAWQzyDWRgvP7j3sme4hn/xsVR7CGJl658Xb3BZie+7FvZ4NuBP0LZ
	 49PvIDkXF5nrqrclByaJxg6AxlcQVxvMbnAixg7wZSHe/KwTDa+T/3Viuhxikt27zFbh6
	 /wV6rH8XdABqNdUrEJynWA9qDjOCo/WAPG8N292S6R1bOsfuVrXs8e9OLQvv6DieDro/H
	 evbrAaKKiuFTQio0c9ckIPqZOdyjgqcP+RneUKAUo00bn6PuOKrYHCN3MivDdCHR5UMTr
	 7zuREvVeiqSikdWtO1xEalP2TVcFub1VXBcNS+0d/JEz/I7Dfa/3z3VmQejc8wfOH3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795623552;
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
	bh=cY6Yhmldded0CYRDkSCs/9lEDZSo/wfsETVr137t9kk=;
	b=BZLyM+Z0fGQk6YA1+G/n4SgHC2MKPyyESavvqXEWAVGQKfuxBG+SR1XwWMG1auglLpV3
	 gT/mj3mX3FoL4c7zuj6xBjt9ImK7C89zPtp6G5QcgHb0u1xNMhtfTfKthfnDA1yiXHqck
	 lH4n0tGXZwgGf3Me//2ydFnNqldcMbPeScQinXld4hcICwUfEfUNoYZB4yb4yBqy9g9Fq
	 d09+WIPFA5SqY8T4aU0v3tzYYQDl0v1Iaed0xTefMLm0rW4sqW9ypJ7psq9ksKh4PLkBO
	 ASvi0eznAGV/nB1HWrJ5RI6SBTdzUAy3AyZ60VTQq9Lmdqok9G0Hyz5iF15FkbDaFlg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795623552;
	bh=cY6Yhmldded0CYRDkSCs/9lEDZSo/wfsETVr137t9kk=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fzakg3uCEq05fVU9grH9Px/fFL1CvMUFOYpXhn0Vk61A3ujuUTdYU/YpL5o/yQy3s
	 qZHBkazNIHYwYBfv88mxOdLqirX1wR3H7JOBpXMuqrTCYVaBya5aoLx2Ph/dGZzApr
	 RupYZpm53cjB4FUIHUskrqYiff54N8w/mbsLEQpbQJbbEiDxK7wR0BFfOqm0I1RC9Z
	 gFjNUPy2/HHd1xqFWFP0Itzieafr5P4mUNrtjd0LAQPbTlzYdSC7Tuokyx+a/auNvT
	 McwriCXgd9CQrS+c8Zrx4sb5NEUigp4JRZQYWQo4w+PWwGUQsY4f5D/I0KzirjFaJ3
	 ARIENdLbVkCyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB9D6405CF;
	Wed, 25 Nov 2026 16:19:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B6F651C9
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:19:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B3D9180C4E
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:19:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Oo4ZBZAtp2g for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 16:19:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5512C809B5
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
 header.s=selector1 header.b=J/z76QAR
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5512C809B5
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cY6Yhmldded0CYRDkSCs/9lEDZSo/wfsETVr137t9kk=;
 b=J/z76QARIfajqEHpquMlmPr1HBrr8bQLSaBwP+z+TLmFhMpeU6akCQ82VlYpj025hT8ZALNQjitZGnFBvN1l99rawH91Bjvi+RPe1PRzTNZi6mK34bEtqZR3kxS8I6zDw1nBNa42Mlnc6MGoOSxi5u8SKtXVod8XBgHIV7AIDxQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DU0PR04MB9587.eurprd04.prod.outlook.com (2603:10a6:10:317::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 16:19:00 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 16:18:59 +0000
Message-ID: <bf705f68-0541-4861-965c-e259d60eb1a2@cherry.de>
Date: Wed, 25 Nov 2026 17:18:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] Dockerfile: Be more polite in two git clones
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261125134317.2479815-1-trini@konsulko.com>
 <20261125134317.2479815-3-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261125134317.2479815-3-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI5PEPF0000091F.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::939) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DU0PR04MB9587:EE_
X-MS-Office365-Filtering-Correlation-Id: faefad09-132a-41db-0872-08df4b0fcfc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: hHBJUVfE81k0X567jRyl3ssotrqOXSs1EZ9IwSR6Y3w5xNyFqsyZHm+O9Jfv1RSbu2XGGCvKH5zkGfOIc0HX32Zo2se4WgbMpb1oKk7W4j5LQyMCRV2K3Y9ggSyq10NaCHou4guUan5cnYMKnNg3rzhDE89SQlVL1bzRGAXSKm6Xlhq8k8gOY/jcyt4txpo/Im0pUjZu351F2SVD0QA7rVhL8p6Cn5ZT7GmcJyj4CupjnK2lGf6t9ZmmlhVJXtmFIW4HC19bLHeq/0fYy9aUAkDw7c77vX1xDBYUY14wwuAmsAw2S9vxM0UtSkMfWzo/WmR1FWoeXT+nJqBy8uWKXVKTWnfLeZvb9TLJyzEpWTeEha0wohYlwYVdwX2kIt3Z0GWqFB8UsackNkku5A/fahkY9/vomLV1Z01nNN46P/bImesqX5SEvXbh3prWKbIHZC57aclZoSG1036PZSg11vqwxg2qygONo3zdVdppCQfc3Yait6S+FN3FrJSJJJTbIBsqYLQ4LNlo6XZx7GIuAx0JklpeElUj1beReVxcMJ4AQSHgWP2WzP4L57niPdT3vLOiqUKiGii1qxpHCxRKjVq6DQe2Pe2NepQ9srtsbvx11J4dVvzK/4r+bVpB2T/rYt36qBY1+zOkA1sIAWJ+u7J+UCHOaGBWPKpHM2ZEwtw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVI2cXBrc0YwbzRPNHBrcytmYlZxcFo4MFlXRmFQVVF0MUpWTWRFTXpjbXR4?=
 =?utf-8?B?QWg3bVBuMlZTRkhvTncxMWtqcDJDdTdEMmVUeCtLNDdHREZrQUZzNDl3SnUv?=
 =?utf-8?B?UTZMc09QYVV6MHJRWGVFQ3FxbmJMTUFlYWYwMlBSM0d0NFZtMVZYdGlNeWUv?=
 =?utf-8?B?RVhVYnFRKzZxVUhib2pUeGp5OStSRTdNdDhYRCtiaE01ZlQySFdmM21Va05n?=
 =?utf-8?B?Si9tRzZQUmluQlMrbkl4OGtTQnNnRUMxYXFtZmhyVEx2ZGplK2JxT090RmU0?=
 =?utf-8?B?NC9KTGdnbk5VeEhtQlM3RHgrL1h0VEFwRUNNek9kV1FLbnlnL3NsQkdYaG83?=
 =?utf-8?B?OVV6dWl4MGJGZ3VGWi94STVxYTNHdUVXc21xcldNTGJOWHMvK21UTmUyL2sw?=
 =?utf-8?B?UEpPaS9Zc3FtNC9pS3hNQzhxTDRiQURqRVpsMFhndHJxdHNoNy9JckVpTWRH?=
 =?utf-8?B?cUJ1OWkybmpyOWV3ajRrT1E1eVFzdkNVbkdYUHNQbjN3ajVSaGlGcEpJMmUz?=
 =?utf-8?B?cllQL0JFTkFCZ1lYZ01CSW9JU1VBdFVhc1NTbmtmVU9md1kzTktPeHUxRk9z?=
 =?utf-8?B?Y1VPd0V3NC81RkkyV3B4UXdJdHpQZzAwY0h5cWtGSHlRVjFGcDdCN3BTUC9m?=
 =?utf-8?B?NjVTbGpTdFJaMWI1RXhhS3JDZVZrcEFtaURtT2F1UUFKTXJ2ZHJJdE5KZWZP?=
 =?utf-8?B?dm1FeFZTRHpSalF6ODVJRFNFdWU4aWxWSHlBTkJ2MElVUUxKR2ZGWjN1cnhv?=
 =?utf-8?B?YW5TOTBWdmlRaHFabkNkSVFGTDN2SnR3ekowVjlQS3FjUTVnQllkUDl2OGRT?=
 =?utf-8?B?TUZRdzRUN01nZytSRldBeFNTd0RaRWV0ajJWeitoN1pxNE1MRWUzelJOSHRq?=
 =?utf-8?B?b2RjeE9CNDN4Y2JwR1BHZGR4Zk1IdlpvNlgzeGREc0cwSXI0QktiRngzZ3M4?=
 =?utf-8?B?RXhINjRBd1V0K1BIeSsxbUVtVXU2L1JNQlIrTnF4REF3OFR0ZDByVGNYZUJV?=
 =?utf-8?B?RVNmbTVmU1VkQURuTndDTk5VN0hJaVI3eTliYlQ2d1NaYk1vczhlNTFpUEpQ?=
 =?utf-8?B?MUlQeDFmR3lHRjRCUGw5cTFXN096SUtMQ05DU2JPU0hVMVIrbnNnUlEydVU2?=
 =?utf-8?B?aitxZGVlN1dPRHlGVWRDZmFwU3hYQUl5Zm9zQm0zNklKdCs5LzhPU0hrMzA0?=
 =?utf-8?B?OFJlQis2WlN6dkRNVDBlaVRTbE8xL2hCZlRleFJUdnU4anQwTHNURjBSMnU0?=
 =?utf-8?B?dG5yV0p1OWpNaWlnM2srajFRQkhzZ2JUYUhYOWNxQWJyekZUYStWT3ZxR25x?=
 =?utf-8?B?aFZuRVdYV1YrN0NsM2Q0THgxcm9scTcrdzZiMkJML1Rxb3pCaGxobVJGVHhm?=
 =?utf-8?B?Ly9aV0F2SFNrSkdqS0JMRGF1bENVNUJIdDZ3K2U4R2NXYTE4eG4xTVNRUThY?=
 =?utf-8?B?WTdPemhEeGYwbG1IWjNJQkk4cFMzckpuQUN0T3hXYmRReTlTSlVVN1NDMnpa?=
 =?utf-8?B?WHlvYndMdmh0ZzBlWmlXakVtZGRxeGhNYjJRazZzREc1cHJNZUVxRWdPdW45?=
 =?utf-8?B?SkF5RGRObHdsS0JadDVZN0JkSmNIVXJWVUdLMmRWc00zeVFlanBHTEZNL1dI?=
 =?utf-8?B?TEpQZ2dFOGtoL2NZaEpQVEdaS1BhUVdRcitxQm9kMXZqcEJaZFlWQzc3cVZF?=
 =?utf-8?B?ay94TTBSTndoMi9RTGpRcFV3bDNYMk9ya0FybXBpZXNwS05mRnFQVHBsNjYy?=
 =?utf-8?B?M09FSGo3cFZ1UVR2TlR4U0ZpMTRKZ1ZCZ2FhL0RmN3Npd0VBYTdIRUN4Vkkr?=
 =?utf-8?B?eDBzZjdxc1RKUmJJd2pWRWFUYmMyOFFJMWw4cE5vZjc5aTdkMGx5UFJZRHI2?=
 =?utf-8?B?dlpmSWVDdzFsd2RGTVBOZnVDOG53cFBWeGhwNjZ5UnNia3dacmJrc3Zybjhn?=
 =?utf-8?B?Q2NIUVRIaG1hcERzTllzYVl2OTFJTW1QWWhvWis4UlcxOUNET29Qck5TWC9k?=
 =?utf-8?B?UGNqTmJma1pQN3hNUkhINjNjdTVpNFgwTUhwQ2VLYVF4MEt6dVM0ZUxrdTh1?=
 =?utf-8?B?V0RTTzN4VENaMWNva1UwQUZyTG9Ud3hVZ0dkSkZvVENBazdIbkZ4ZDhzTmhB?=
 =?utf-8?B?VnFXK2V0Y254UkJEcVBsYWM3OGM1WjMzNTcrbDFPSTBtMTIvRFVvUGYwNDZ4?=
 =?utf-8?B?TDh1a2UxeS8yQjRoZjFtT09LWStnNnJpcVJUV1VWbWFwZTZrYXNYZlhyQ3FD?=
 =?utf-8?B?ZzlmQmZxTEk2djVWMkFhdkxJQ0xJcnpQcDlaUkRGZERuRU5pOHdtWGlHWGlW?=
 =?utf-8?B?OWZ4eVBBQzM3TFBQaTVsUER1MmxEKzF3eDg5OTFUVTMxenBzSTdpQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: faefad09-132a-41db-0872-08df4b0fcfc1
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:18:59.7425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7mL0CREU+mYZWtzxaJMpI/97sCCLmuyNj9rGR/0mRVu/CVnVEyal/9Er8OBS82zbf5woB7cLUbUWLFokcvpuk+QBOpWEBhew+OXZNd2++c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9587
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

Hi Tom,

On 11/25/26 2:39 PM, Tom Rini wrote:
> When cloning grub and qemu, stick to grabbing only the tag that we
> intend to build. This both saves time and their bandwidth, which in turn
> makes our build more robust.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
