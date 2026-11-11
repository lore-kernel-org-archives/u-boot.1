Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BB7606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gar6H2xW;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=UosTkmSX
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6FE15608A0;
	Wed, 11 Nov 2026 14:04:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0lg1xt6ZKjVV; Wed, 11 Nov 2026 14:04:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4508D607CF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794405854;
	b=Zhdh6Mb0Z2vX67a+MD7Yox4WBArrh0C75m9s9kIaQZRxGO62VqTrQSH5zKWyhzjQNV04
	 F+3+xm2ao+G/NDGmbwoSzD8eMm6YeO6pMlsokjeRK3qQrG49VgpBSIIdxW6muj81KKfl3
	 CMATQFSCg3O9RH0V0C+mrk8iO8MPGBRPJcshbmpBtgjgEk0QTBYaVhOSFuFMxbGC4zrFK
	 plZKu6pREUn4j0HJzLz0t2E/g4zyPE5pNJ2aVYXCW0hnGZzJxFN+b6k5PSUK3w00aMNSF
	 vKmRsHuUQlMfI8OveIPA2c6q6p43u05URIm44nKitCjz6L1l/QoetRZFjngfo5p0TlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794405854;
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
	bh=9kvSgntGAV1gZjw0JuhyZVXxa5rm7cdfbJDOPpvcXG4=;
	b=ICw2GpedFB2UDk+WdYwG/e50+erKzjqP1K5jyzbB/cCr/x87E33QK0spm7bb3KEP2mXb
	 T9JMnogUcfLSBipM2gycuBRAzAT1vmJevKWq80KhDZivwY9OD8TCmamJmqgCSYPZXH0nd
	 PE+uEJLDbdCOIMZS4doQftoKpd3Of1M5QtkJUijWqcwW+kBfb3QvcyC7MQF5F42ks5w7r
	 UKoOJCppDAUg5PGwa3aWVLI84c4Tvgc0SwOwe3nSCPTMfsicAkb5PdE9Kbu6vrg1nGGlE
	 WGOLsGaGAomQPQla7iLk9IW+uOLLmfkkdcctWSz7306/eOa35IoKF7uCqPJih6tRP0w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794405854;
	bh=9kvSgntGAV1gZjw0JuhyZVXxa5rm7cdfbJDOPpvcXG4=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gar6H2xWDotQHcvY58BHA1rCP/79LtLL2+98XJNHJDRrOqlUMcJJJ6Xo4yAgifwCo
	 L8mLfry8vmj97hcnVkvOrjwNILrL2NnLEzxNX/z2TXoJf3cVrX9T1L2oGz5pjW+ilb
	 CjrXnKoAtIz9ZcJpP5yPuTCqqSQXQNTPH4knu06LCS7p83zQ9E2ALMwaIgqlRDoX/P
	 x3OLXLxUKsuyzv4dmgxzIMJG1SZ9YmsrN0Xn2MVSU73d6kifWRqD1Ytq42HJeDJhcY
	 D6PyO114HW3wGY9pqSpJQukU+81rbTcwf9MniRWfqTIvWLVcZMeIjnqQ2DqFcxU7Ws
	 FDQjSddOxBmIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4508D607CF;
	Wed, 11 Nov 2026 14:04:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AE2EA17CC
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9F68D40A7F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:04:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KioE9jIgVxgx for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 14:04:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8B3C04081D
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
 header.s=selector1 header.b=UosTkmSX
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8B3C04081D
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kvSgntGAV1gZjw0JuhyZVXxa5rm7cdfbJDOPpvcXG4=;
 b=UosTkmSX/gMPa6On3abHxouA5vhKyMVnLOyNwl6el0BcIIPCZ7Tgd/HiG1M2Bi3809vixPrt0jWd0TA4ehDMmIlzJtZkr05IJdSUmZjVEnjvnqwk/yL1djBeu9ATqGkGz3sfYXLIpt5uLOyuGPayNm0RgTBxQDetUQOkSLk0hy0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AMBPR04MB11719.eurprd04.prod.outlook.com (2603:10a6:20b:6f5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 14:04:02 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 14:04:02 +0000
Message-ID: <ec190198-4b76-49fa-bf1a-478219f7d56c@cherry.de>
Date: Wed, 11 Nov 2026 15:04:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Add LCKFB TaishanPi 3M
To: Xuechao Han <220110626hanxuechao@alu.hit.edu.cn>,
 u-boot@lists.u-boot-project.org
References: <20261110165202.150810-1-220110626hanxuechao@alu.hit.edu.cn>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261110165202.150810-1-220110626hanxuechao@alu.hit.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::11) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AMBPR04MB11719:EE_
X-MS-Office365-Filtering-Correlation-Id: dba98a18-72be-49b9-d077-08df3ffca3ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261022115727099003|261021121427099003|261022075727099003|261021135927099003|261022105027099003|11063799006|56012099006|10067099003|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: y1bjkQNZAlXOUhGU1XLIbFkgipoQwXhSXT9IxI1579anj5jpegVT19uqQxsiskvjpWhp16RO55jAD5xZgYQw8+5o0mvNkeX3Ka9VgOY/1JtfkfpY9K08h+NZTgPuskCYQwDbC+IUH+7tS/5gDdfxylL/0G+cjnUZGBmh22HpLYxGsrIQaWSm5+zzs+thmE+xvbdmoDtgoiehs6liez19hrV2zStEPsOi79+MgKwtfEus1VGkgchSk6zuV/1tefo4IbvOksckQqYNXRWe2uR25q5Kca6Zgx/C/zk2kPa75qhnYm2yUFGq3RbadS1oG+1IGDDUoWTq5p/81JWyHAwcm1E4aRKV4DjPsb7ASYXsEm2JPzp3TxeGklOk6rT2Tbqp0G4cxp1Bao39Fv6K1oaJphEbt50tK+hBTAI3X2N7j8Q+7Woio2OgVEWbNI2At432YLBzZAm+J0iFyYQC774tr5jlSx5MwpNe/TC5T22xeWuS3vuUnQpE0msoKDXpTvrhvN1e6FQBNmYyBNVkeyWo2P5P+jIUzU0VAGIA+fHqAwfyzbouZIhjoLI3B6V6n042c/OADmTZtijwxi8e8tWKjiwstZsauQzL85J2zZia/v0amJr98ftY/3TqobxhE09r
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022115727099003)(261021121427099003)(261022075727099003)(261021135927099003)(261022105027099003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1lkaG8ySEtYSkg5Mi93VFFOa29tek9tVmRYVHJRcWhheXZab1ozZWViVnJj?=
 =?utf-8?B?S1FhQWV2NEhudWdleUl0MWE5cHBCcHp0VWJpd1ROK09NL1FFRTdmRndSR2hu?=
 =?utf-8?B?L1RPdVMrWU8yTlJWM1MrYTlzUGRXOWw4MmtyTW1wblJRVDhLRy9LUzZHZkhT?=
 =?utf-8?B?VFlaWTB5RDR4eDNDbys0OHovRDhIRWRaQWFzVUdMTzNPK3kxY2h5YVp4N2l3?=
 =?utf-8?B?U0Vlc3R5djdnNHJqK05kVFlLWUFFOU9ZYzN0cDYxa2hGemlBSys2cWx6TFpU?=
 =?utf-8?B?am9JMEZpd3VmN0hYcm0rMHV2UGxROG1JZDJRUHo3Mi8rMk9ZbzJxZGRHUUdr?=
 =?utf-8?B?Y2NtZ3JNV1NWQWZqYzc3a0JlZm1kaE9hazR2bW9CZ1E2ZjRqb3p4eFBGaGN6?=
 =?utf-8?B?SVBFNmM5c3VEbFJENkdSUXRCakJiaFF5VmtSQzFidUNOUEdYYitzbXNQdjdo?=
 =?utf-8?B?ZlZNR0lGRWJObFRsbmhIYU1NdG9xNHlsM1plVTZBanM2NVFRdWFyVHdPUWZR?=
 =?utf-8?B?UWdrMUpvbGR6WU0xSmdlZGNCaitmZ0xXNEJ1UjljK0xwVExUUjdBblhqdVFW?=
 =?utf-8?B?cDl4ZTVmZzhsTEhIWi9lM25TNE80UWJUUFhqQW1QRDQxY3FFRjJVYTRmYzRm?=
 =?utf-8?B?VGRxbE5OSVFuaWdGaytWQnUwQnlvd2dDcU4yd0tOQyttZlBzZE1Taks0ZWs1?=
 =?utf-8?B?eHZZRW9xeGRYSURxWjJQaHNCbHZiUzNFdlkzZWYyUks1aTAwbmZSbCtjS01n?=
 =?utf-8?B?R1lsQTdEQnJ3ZUZuVFpqTE5SdkNZaGoxWGxkNnM3VE54WmdkZXRlU0d3c1pv?=
 =?utf-8?B?d0dQNFc5WGxqLzRkVmdnNGJFbVJqNTU0Rkg5THNvZEVQU0tUS2ZDVmJOdmhi?=
 =?utf-8?B?akJQS0U1SEdyZE8vemFuVHc1V3hXM3hsRUV1R2MraHhvOUl4VE9leTBDWTVW?=
 =?utf-8?B?WEE0Vk1rbW41ZWc0Yys3NmZITi9xTnhrNEJvanBoLzI2WmhjS29lNzYvTEJB?=
 =?utf-8?B?VDBTZDlHSDEweDlpVkkvN3BSWWovcTNjMTBMVWlQdkRuU01SSS9UTUpsekdB?=
 =?utf-8?B?aWxRbzk0MEdpeXBmaWFpNlJmeG90UlF2ZE1TTWIwd2liRkd2bGl4UlowakIy?=
 =?utf-8?B?WTNmV0ZJbkZOUHptVjQvcERaMWhldzhBSG45aFZhT3JsWGRGbVhuQURwZEdU?=
 =?utf-8?B?Tzk4RTRMUjM1bDBDbDFGeWtvQzJwc1doQStYcm9vTGE3SzBZMHRrVXFzbXFV?=
 =?utf-8?B?WkVVSVRVSmc2dWhMYUJleGFnc0R0UmZabXdMWVhtbEZnQXBkM0o2SEJ6MGxB?=
 =?utf-8?B?ZTY5VzF2MU5EUGFYd0pUbVNhTWx4ZFFkUTV4RFBIRWg5MkpNUkZYc2xVRmFt?=
 =?utf-8?B?OVNOQ2p1ekRuRXZGNEhwSWJzcU05V3Vwb21tVmw0OVpnWVZSQkpYY0JGQWN0?=
 =?utf-8?B?VVBpK3hJSlc4Vk84TzhrL1kxVWc2Y1JuOFB3WDMrcDZKdjZiWnh1UmJCakli?=
 =?utf-8?B?dDBNQWp5ak1tTTFXaXczWEljdndIZ1Jiek1XOGVnYXptWHB4akJtTThZYUk2?=
 =?utf-8?B?bURXQ3hvSk9YcGlRVXgxTVdhWTlRYWdkbXRaL29DSWxtUkEvWEdnaWRnTGta?=
 =?utf-8?B?eTdPZUNyUUljK2paclp2K2VLV3pJd0tNN3RDOHpLa255Ti8vWnJ3ZmtPakNr?=
 =?utf-8?B?MEw0RGVaWFlkRmpVNzlZakZDSE5aeXRRQ3FZVCt1bUUvQkg1aTNyREVTWGsx?=
 =?utf-8?B?am5FR0dlYVp6aVVxL1c5ZTI2dzVxRzRyKy9zM25WRW5FeUxhK0duK1k1N0xh?=
 =?utf-8?B?Qmt4VnYzNjI4MzdPSmNDenU0WDMxUFRBSEVKVFc1Y20zcDFCUEZUNWh6ZjVW?=
 =?utf-8?B?ckF2N0Y3NVpJek92Unk3T0hZazJVN2pQZjZQWFVUVFhzSmtJT2lrVkwzeXJI?=
 =?utf-8?B?MFZkNzg3aXA5U2owZzhlSnBQNVBQbjFZU29oZHBjZXRJYTl6TW9hd1krTmly?=
 =?utf-8?B?WkRwNUpuaEZaaEdzTnQvbTNpNVFDNmdqemVaTnVpZ0IvY0pzY3daS05UMmZW?=
 =?utf-8?B?cXhFdi9JTHY3R2hBTHlZVWo0aUtvMjAxS3lhdWpYcFhINmorOU9UMk04RDZB?=
 =?utf-8?B?Z05yVUxKai80OXFTY1dvTS80RjQ4YkIrVDVKVUdydnRzeEtWQkhqUE5VK3Zt?=
 =?utf-8?B?N1JzL0FUdEZoaFpqS05OUU9RRHhUanpyTE1LTzFVNVpScTlHQnpNN3lNbkRW?=
 =?utf-8?B?dnhiNXVYOGFFVTlZYzZheS9oRmhRR1gwNzM4VmVKbFBqak02NUI2MnVobWhY?=
 =?utf-8?B?M3lYaDRhamk3U09NdWg5S2dwbkl5dXpUZDU1Qnk3RU9ETXhST0tzQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dba98a18-72be-49b9-d077-08df3ffca3ad
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 14:04:02.2446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9C8UGtgS9RCWsijjUV/n+9dZOgUFjJFCQjTZlhVYvMopriUbAxHFBwf1+jWmO8Uil9wXpxvofjR+t/3aXOjGcU9y+kkQdXAM+t7NkPjx9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11719
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

Hi Xuechao Han,

Something went wrong when you sent the mail and all Ccs were ignored, 
please fix this for the v2.

On 11/10/26 5:52 PM, Xuechao Han wrote:
> [You don't often get email from 220110626hanxuechao@alu.hit.edu.cn. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Add support for the LCKFB TaishanPi 3M, an RK3576 based board.
> 
> The board device tree describes the microSD card detect pin as a plain
> GPIO (sdmmc0_det_l) for its cd-gpios property. dw_mmc does not use
> cd-gpios, so the pad stays in GPIO mode and switching the bus to 4-bit
> high speed fails with:
> 
>    CMD_SEND:6
>      ARG                      0x80fffff1
>      RET                      -110
>    unable to select a mode
>    mmc_init: -524
> 
> Use the sdmmc0_det pinmux in the U-Boot device tree, like other Rockchip
> boards do, so the card detect signal reaches the SDMMC controller.
> 
> Signed-off-by: Xuechao Han <220110626hanxuechao@alu.hit.edu.cn>
> 
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Quentin Schulz <u-boot@0leil.net>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/dts/rk3576-lckfb-tspi-3m-u-boot.dtsi | 28 ++++++++
>   arch/arm/mach-rockchip/rk3576/MAINTAINERS     |  6 ++
>   configs/lckfb-tspi-3m-rk3576_defconfig        | 65 +++++++++++++++++++
>   doc/board/rockchip/rockchip.rst               |  1 +
>   4 files changed, 100 insertions(+)
>   create mode 100644 arch/arm/dts/rk3576-lckfb-tspi-3m-u-boot.dtsi
>   create mode 100644 configs/lckfb-tspi-3m-rk3576_defconfig
> 
> diff --git a/arch/arm/dts/rk3576-lckfb-tspi-3m-u-boot.dtsi b/arch/arm/dts/rk3576-lckfb-tspi-3m-u-boot.dtsi
> new file mode 100644
> index 00000000000..412c92d357c
> --- /dev/null
> +++ b/arch/arm/dts/rk3576-lckfb-tspi-3m-u-boot.dtsi
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2026 FragrantOrchid <fragrantorchid@foxmail.com>
> + *
> + * U-Boot specific device tree changes for the LCKFB TaishanPi 3M (RK3576).

issue: unnecessary comment

We're in U-Boot, we know it's additions to the Device Tree for U-Boot.

> + */
> +
> +#include "rk3576-u-boot.dtsi"
> +
> +/*
> + * Use sdmmc0_det (SDMMC0_DETN) instead of sdmmc0_det_l, which the board device
> + * tree selects as a plain GPIO for its cd-gpios.  dw_mmc does not read
> + * cd-gpios, so the pad stays in GPIO mode and the switch to 4-bit high speed
> + * mode fails; both entries are GPIO0_A7 with the same pull-up and only the mux
> + * value differs:
> + *
> + *     CMD_SEND:6
> + *             ARG                      0x80fffff1
> + *             RET                      -110
> + *     unable to select a mode
> + *     mmc_init: -524
> + *
> + * 1-bit/25 MHz still works, so the slot looks alive until the first wide bus
> + * data transfer.
> + */
> +&sdmmc {
> +       pinctrl-0 = <&sdmmc0_clk &sdmmc0_cmd &sdmmc0_det &sdmmc0_bus4>;
> +};

issue: Device Tree is a representation of the HW, so hacks are not 
welcome there

We also don't want to have non-upstreamable changes in U-Boot Device 
Trees anymore.

Either upstream this in the Linux kernel (but I suspect they will reject 
it on the basis of what you're explaining above), or fix the DWMMC 
driver to control the cd-gpio wherever appropriate (preferred method).

> diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
> index baae63fc7b0..158fc1421b4 100644
> --- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
> +++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
> @@ -4,6 +4,12 @@ S:     Maintained
>   F:     arch/arm/dts/rk3576-generic*
>   F:     configs/generic-rk3576_defconfig
> 
> +LCKFB-TSPI-3M-RK3576
> +M:     Xuechao Han <220110626hanxuechao@alu.hit.edu.cn>
> +S:     Maintained
> +N:     rk3576-lckfb-tspi-3m
> +F:     configs/lckfb-tspi-3m-rk3576_defconfig
> +
>   NANOPI-M5-RK3576
>   M:     Jonas Karlman <jonas@kwiboo.se>
>   S:     Maintained
> diff --git a/configs/lckfb-tspi-3m-rk3576_defconfig b/configs/lckfb-tspi-3m-rk3576_defconfig
> new file mode 100644
> index 00000000000..3b6b045eca6
> --- /dev/null
> +++ b/configs/lckfb-tspi-3m-rk3576_defconfig
> @@ -0,0 +1,65 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SPL_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-lckfb-tspi-3m"
> +CONFIG_ROCKCHIP_RK3576=y
> +CONFIG_SYS_LOAD_ADDR=0x40c00800
> +CONFIG_DEBUG_UART_BASE=0x2AD40000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_DEBUG_UART=y
> +CONFIG_BOOTCOMMAND="setenv bootmeths script; setenv boot_targets mmc0 mmc1; bootflow scan -lb"

question: what are you trying to do/prevent here?

For the boot targets, do you really always want to try eMMC first, and 
then SD?

Maybe what you want is something similar to what I've done for the 
Theobroma boards? c.f. 
https://elixir.bootlin.com/u-boot/v2026.10/source/board/theobroma-systems/common/common.c#L11

We swap the default boot_targets based on which boot medium was used. If 
it was booted from SD, then prefer SD. If it was booted from eMMC, 
prefer eMMC.

Unsure why you want to limit the possible bootmeths? We usually prefer 
giving the user as much freedom as possible on how to boot their device, 
so restricting the possible methods seem odd to me here.

> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-lckfb-tspi-3m.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_DM_RESET=y

question: what do you need the reset subsystem for in SPL?

> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MISC=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_RNG=y
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"

nitpick: remove clock-names from CONFIG_OF_SPL_REMOVE_PROPS

> +CONFIG_BUTTON=y
> +CONFIG_BUTTON_ADC=y
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_PHY_MAXIO=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_SCSI=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SYSRESET_PSCI=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y
> +CONFIG_ERRNO_STR=y

question: why not enabling SATA?

It seems there's a SATA port on this board and it's enabled in the 
Device Tree. Have you tried with CONFIG_DWC_AHCI enabled whether you can 
communicate with it?

Cheers,
Quentin
