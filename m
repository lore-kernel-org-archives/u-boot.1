Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC384606A323
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hVB26xte;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=Na5F+8jn
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9185F80DAC;
	Mon,  9 Nov 2026 12:55:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z9Q0mPTshnzQ; Mon,  9 Nov 2026 12:55:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B96A180DB0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794228919;
	b=aWSrQSZyeb1/QN/I5sajhKM9fRJOUBKOBsAgOPLttbFDysyDQ29RQ2wjGOyVWkKC356W
	 jZy/2LZmt9dXx2P1vHb7h1gkdXAw8mufuy/FyBxPj96mz7E5HOO1KveTLmeVuX2tiew8/
	 PTY6F7dEozr74L/KPoky5Lkn6yYZkATfrUMq5he2JInpZYwJr5NZ2v/cFNadhvNRO+1tm
	 KUjilNpahHQkHTx7teYu9P1fxBevwztk0nZUFZhBbaehaAYHfNiY4zWt2xjhhJ2rOz/sB
	 EGC1H/NLAUHapgXUQdkdpFvuiJK9+dxWjRiN4NGQdumJQuDQFfZKlNPDQn633cDx2Nw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794228919;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	bh=x4wrmNW0UaOnJ9uPjIb6hsh/dcgPVigEDXRDMh1/SEQ=;
	b=Dg1D7GhgXpXGLC9r5lw8u5/rxo8A2YGoiMBgsQlNoeAGlvxUpEEZPl0Bavux2Ye1mBKm
	 lfCcEftZ0PbjadiaRGlLF3fw8B1TqujMWQNjLw6JJpMovB94wkKVN0ioXuRoVgwB/4hFd
	 Iz9pDFwZAWYEnzmmqJILHwF2Z5+wxqv2QvV3N12gYoUvCOMMB1OuowZsbpM+oFQpMjG9E
	 cOVioRMCZu2tfR7u4TBcPSB7WnE2ym+bk8w0bMA3HctfWHxLAfIx1iuXHdgdWSg79liqM
	 aMBJQ48zyeUmuk4Q0aFX2ex9sgw+THykO9K8hOsnBeDflwxVXwEtsjzUpm/QdY7iDCA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794228919;
	bh=x4wrmNW0UaOnJ9uPjIb6hsh/dcgPVigEDXRDMh1/SEQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hVB26xtep3W5ojxsdwiovzgYOm6p9Yw+xnWX+e/Z1ufzTYTxTcZYhFGAZo7UI/tFP
	 Y+Efk8jjuQ0VJdbUMlayB7K2M/e0J0wNTXijxTBYRco9+sWpAweqgBPQttjp9hmbEn
	 x35F39Rastsqes8SLbQyA6Wxkib80FVHNqWKXJ+if0Cf07BLis6pQpzYuMQq0x6t5G
	 CjIBPTHvCuIO/B0jbqmYIpjxOIvIYMrvVa49w0HDVyey/IB5sXsMh+Cs15VqthOf82
	 ENzrjJ2RbkEenurSzb+zWp787zVTDWZcAV0LBVZvkAWBOuGrBcILGeKkDRHmtKYfCf
	 E7pG9o3sT9NSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B96A180DB0;
	Mon,  9 Nov 2026 12:55:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E506C111
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 12:55:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA86760703
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 12:55:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iuL4cHKAtdMe for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 12:55:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A3B7A60603
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=Na5F+8jn
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A3B7A60603
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 12:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4wrmNW0UaOnJ9uPjIb6hsh/dcgPVigEDXRDMh1/SEQ=;
 b=Na5F+8jniO7IboH6N/jT4wG8BJ0r8Yk8TpzGZrKTNAoegSKEXbcxgD6fpYdNePUliGXNAJ7kg4whtMSbOPTZ/HOJ0Cf6fGXLLXTYHWedLwt+C0Tn7Spzsv3xaSejHkjFlhzoGx9FiCwd4bxp+aXxtSEzC27WoLxG2CFCYBsgyLL2aZrMRngRv3tR+KQbQQBonkqe3sGlTjgQJ6NU2WnoFG6WpUkdZU8tDzIWQAaZnZ/OQWslDmRhWGnbepxaSVIQG1dUtMIk1ppd71THmEV3bH9O51vY9V4cZ+S9nasiB1EB7Jx6WJo+zZBXIp1DZ6KMqFK3BjXe7hwOZlv2igSLgQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DS0PR03MB7679.namprd03.prod.outlook.com (2603:10b6:8:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 12:55:11 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0569.011; Mon, 9 Nov 2026
 12:55:11 +0000
Message-ID: <92359754-5d7e-454b-a7b9-dcb4bf08213c@altera.com>
Date: Mon, 9 Nov 2026 18:25:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mmc: select the hardware partition after partconf
 command
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Markus Niebel
 <Markus.Niebel@ew.tq-group.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Torsten Rupp <torsten.rupp@8tronix.de>,
 Eric Chung <eric.chung@riscstar.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <20261105-upstream_partconf_fixes-v1-0-6abda284aacf@foss.st.com>
 <20261105-upstream_partconf_fixes-v1-3-6abda284aacf@foss.st.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20261105-upstream_partconf_fixes-v1-3-6abda284aacf@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ac::8) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DS0PR03MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: 301f7603-de0f-445c-01ee-08df3e60b070
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|18002099003|22082099003|10067099003|55112099003|4143699003|56012099006|11063799006|261026121527099003|261102123227099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: khsHVsoBmUf0f63nVjWjExMLfIN+Usn6IWKORye01Q9hUKFGdLWLhiUp74a6bd2YxUsjish9Eprb5ZfC3MYSson0+w5Xb0Yu9UtiElgApvwN/OxP0rUABUEBQrUH6wcCI8SwPrxwJd52dzB1l/RYGfAoKAmBC8Ayhisx+CAHb9wBcrN57h+qp6y1i+d2Pv7aNYE5j2r5lQxq/jhw/zh5uqNq3QBUNyMAShAmlQYLf2n/A8Z0W6FxjLk05fkED6WFdjHYgKeW0/J/1OcoSzB8loiOegO4TbDTA8IWw7E17rFAGwKiJsIpvOrJpTdzutNZbLoiW4SDtGSbvRoytUkkzzIuYQWmHYsC5B8xGjDtG18woRVzqPR5p11bK37fjxCt2zQLnOqSAtCkrt+zFSdTsDGcwz3tKUumwzZmlSRMk2s9SZSC4W4NEHmZMCQbtSbLpzIRH+MIou/Skpsg5YjQa4VfA4GGXUlR/nSqcKfA7QYgfVuuw4WMNYbg+EXNWMszJ/QnE9rlRIN/cjhtixlZtMYO+KlbAQPOH2n0gwADu0r4CfUaczZCjTkiFOwohYJC+SfqXS3iCNOStoD+uhhvFUdD35CMFNoOuMiqhBNW6d7aoGJh3kPUPFzrwMFo1Dpc3M2zsG7zlshq9AJWLo0o/1JFJ+fEDQehoIUZuwb43/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(55112099003)(4143699003)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGw1Q3JYd3VIQThybnZBcjdySUFkZTZ2QmEvTkc1ZDdJRW4ralcvc0RCNGZY?=
 =?utf-8?B?OElFbzBTMjlaWkNveUUyZkthbUdpdCtRZXpCTG8rUUo4SzFCbnF2M2FZQkhJ?=
 =?utf-8?B?b1IxVGtXMCt3NFBqVFZSRGN5Z2hqMnFKNXVOQmxrK21JcnRtZzJyOFZVeExq?=
 =?utf-8?B?WGhEMXpRZVFrZ3V6Zjh1NG95KzFQa1c1dmxjQ3BrV1l6ZzhNd0hHdzVIczZT?=
 =?utf-8?B?Ly9QTmM2NnJTNEVQczZoU0hydHpxQ240M2ZsMzVpTEdDdDI3T1IvTE90eVJm?=
 =?utf-8?B?cDBUMEVCMm45UVRYdEk4dmVqcVcxSE5mM0lDTVgzUzdLOEJISFJSY3hqRnRC?=
 =?utf-8?B?Qzd3Q1ozWml2TXZQNHEwNy9nOWVtY28zOVo3SHM2TFhSZ0pCbUhwOVdXaXFz?=
 =?utf-8?B?RVFJcU1QdlVrV1dKR1poSFlObVc1R2NTUUlUN2JHdERqY3JxbWk3YnVoRW9t?=
 =?utf-8?B?MlVzdHdLK0N4b2Y5MnEySWF6dTdyMEs5MThITkNUSkIwdGxLaG9yZnBEUWRZ?=
 =?utf-8?B?S0YrRmxicDcxRmJaRFFtaUU4WEN4L3FXbThWWWxzSzA1NG9VS1ZxbFpmVlFF?=
 =?utf-8?B?eXNBWWFoVTc0R2czV3lvSjRiaUhmZnlIcGZGUkoweGt6bGhuYkZIaTlTRXR4?=
 =?utf-8?B?T3pYV2Y2bGExQnFWTDdkN0ZGaVZSOTlTWXowWmNVOW9kazU1emRmR2JGMVo5?=
 =?utf-8?B?dWIzWXZiZ2lOaVg5d3UvWnJUaU1FL1orZHk1bG1aNDkwa0gxcTl1N0kySEY0?=
 =?utf-8?B?c2Z1MFZFRmVNOXNINklwM1hWN2syTGZCVUxPajFDeG9PaklONmtlTVdsUGlZ?=
 =?utf-8?B?Q1c2SVd1SGFtYnk1bm5qazBVYVQ0Nitiamh2RTMvd1J3MFk2K3J5eHY0dmVQ?=
 =?utf-8?B?VzFXc1ZGWGhKby83MnFkMXVNWWYxb1hTVERWaFVGeW40ZHg2TkJRQk1FamdM?=
 =?utf-8?B?Q1JEOHpmdm1EbkVsQVBTK3R2TzhmbkEvR08rTC9lTnI5NkduYWRrLzh1dXhw?=
 =?utf-8?B?RkIvaVdIQk9KM0Fpbkgxa0FCaVAwSkd3a0lTOSsrNnA3Umh5dFJ3NzBmYWhq?=
 =?utf-8?B?YzV0VkYxZmFvZThpODF3NmlRNXQ4dkprL2pHazBQWW1UY2JHZHIxVTFIWXIy?=
 =?utf-8?B?R2p0Vm1kQjRHOFo0TnFWL3BWb243YmVOTUF1VC8rTzRCRnBLNjMvb09HSnhz?=
 =?utf-8?B?NEFhSUhoVTQyRGtNWXVNdlhqaUNoeEZUVC96ZEhyQldaVFBLSkh2dnRSMzRO?=
 =?utf-8?B?SmpOOFF6SVpHUHZKWE9wb3ZzSml4Si9XMGhCaUp6RGJyTGQ0dHdIUElyOHpH?=
 =?utf-8?B?YXZmT1NhOUxIS3VoNTd2OUllRVpCNWlTVTBGSFAwbFZXRmh2QmFjTUVkdVFn?=
 =?utf-8?B?NEFXaXR2aWRJU3VyRWRYMUJ6MllhTmxLYUtsa1o0bkwrN0tqMm9XUE1uL1pv?=
 =?utf-8?B?M3gyVTNMN21TaFpzQWVtOHFHZURPQW1qalNRTWV0UVloTmFCK1h5QU0wVkIw?=
 =?utf-8?B?NDN1MUZYRWgvOEVnY05ZeUF4dk9EcHVrdk1Gcjg5Z21IUmFHT0FmeGxBcDlV?=
 =?utf-8?B?aHhrNWNHSWZHdmNqdGMvb1J6ZnlDU1B6V3dBZ1hoYS9pQXBQNnQxUnN3UmRW?=
 =?utf-8?B?SzR0UktqTnVHSW1vd1c0d0I1VUZob0pNay9WVEZ2V1RUTVhtSnByOFp4aXFh?=
 =?utf-8?B?TlY4Ni80QTN6UnB5Z0M0a2ZtNVJBV05VSUttWGZiL2k5ck9idHBaRUcvclpj?=
 =?utf-8?B?WEJVdnhXcUxidDFpZGM4ekhiL3pLU0krOUs2UFBFK0JjRnZ3cGhUUUgydk5N?=
 =?utf-8?B?NEZvKyt5OHBYQVB1VERlMW5tUXhKdEFZNWZFdnJ5SnhYNEhjaXlXeUgzenVU?=
 =?utf-8?B?Nm12NmJXdzk4Y29JOGcxVDI3ZnlER0QyWGhnQ1hPa2s2cGxoNW05bzhTN3hR?=
 =?utf-8?B?MlBhODlWM2xjQjYwc1JZMzRvUUs5cnJDMWhEV1I1T01KVk1VNm9XSzVTRHJH?=
 =?utf-8?B?V3ovSUlCQWd1dzFWZGpGYkp0YXpEZDVDWFN0ZTJZeDcrb1lJaEYzd3Vyb1J1?=
 =?utf-8?B?NkhxSmFhVThINGVOa2ExdGtDa3RkdHRqNk1GQmpUaXBKVXpPSWJRakt3WmZN?=
 =?utf-8?B?aUthNmEzSXRPTXNabGVhZGZ0Z1BYOWMyN0tPc1VjOHpnb2JzalBxd2ZkaTRw?=
 =?utf-8?B?Q1hPVkFtc1l2YXNmcDdtT0JKaUo0OTVlV0N3eXRZZE4rWFBNbjdSSnNoZ0Q2?=
 =?utf-8?B?U0JJYi9kK0lmNlhHbkRwOVhMeDVHaCs4d2dmK21OcDAvV2RlOGtmSmZTYXlN?=
 =?utf-8?B?OC9HKytETkxTWHJ1cjZpbTNoVThOQ2hoS3poNVhBZ0tPc0JLVVJjNnVHL3Nl?=
 =?utf-8?Q?dFRvFkm6PtCl5EoM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 301f7603-de0f-445c-01ee-08df3e60b070
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:55:10.9137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfzKTU2r5qbL195+ptqLp8m0Dnpinv3xEZb9BcryC7TSuVBlB1h9cd4M3IvxKwVSAAb0rh1e/9mF/ycW8TjjC85we9l74aGjEh1AFzknCPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7679
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 05-11-2026 14:33, Patrice Chotard wrote:
> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
>
> Select the hardware partition after partconf command as it is already
> done in mmc_select_hwpart() / mmc_switch_part().

The CMD6 already selects the partition on the card; this patch makes
U-Boot's bookkeeping follow it.
Suggestion: mmc: mmc_boot: keep hwpart and capacity in sync after 
changing PARTITION_ACCESS.

>
> This patch fixes a "mmc partconf" command issue.

Also please use the imperative mood.

>
> For example for the sequence on STM32MP157c-ev1 board on which we got
> mmc 0 (SDCARD) and mmc 1 (eMMC).
>
> before :
>
> STM32MP> mmc dev 1
> switch to partitions #0, OK
> mmc1(part 0) is current device
>
> STM32MP> mmc info
> Device: STM32 SD/MMC
> Manufacturer ID: 11
> OEM: 0
> Name: 004GA0
> Bus Speed: 52000000
> Mode: MMC High Speed (52MHz)
> Rd Block Len: 512
> MMC version 5.0
> High Capacity: Yes
> Capacity: 3.7 GiB
> Bus Width: 8-bit
> Erase Group Size: 512 KiB
> HC WP Group Size: 4 MiB
> User Capacity: 3.7 GiB WRREL
> Boot Capacity: 2 MiB ENH
> RPMB Capacity: 512 KiB ENH
> Boot area 0 is not write protected
> Boot area 1 is not write protected
>
> STM32MP> mmc partconf 1 1 1 1
>
> STM32MP> mmc info
> Device: STM32 SD/MMC
> Manufacturer ID: 11
> OEM: 0
> Name: 004GA0
> Bus Speed: 52000000
> Mode: MMC High Speed (52MHz)
> Rd Block Len: 512
> MMC version 5.0
> High Capacity: Yes
> Capacity: 3.7 GiB            <== incorrect size for EMMC_HWPART_BOOT1,
>                                   still EMMC_HWPART_DEFAULT's size
> Bus Width: 8-bit
> Erase Group Size: 512 KiB
> HC WP Group Size: 4 MiB
> User Capacity: 3.7 GiB WRREL
> Boot Capacity: 2 MiB ENH
> RPMB Capacity: 512 KiB ENH
> Boot area 0 is not write protected
> Boot area 1 is not write protected
>
> after :
>
> STM32MP> mmc dev 1
> switch to partitions #0, OK
> mmc1(part 0) is current device
>
> STM32MP> mmc info
> Device: STM32 SD/MMC
> Manufacturer ID: 11
> OEM: 0
> Name: 004GA0
> Bus Speed: 52000000
> Mode: MMC High Speed (52MHz)
> Rd Block Len: 512
> MMC version 5.0
> High Capacity: Yes
> Capacity: 3.7 GiB
> Bus Width: 8-bit
> Erase Group Size: 512 KiB
> HC WP Group Size: 4 MiB
> User Capacity: 3.7 GiB WRREL
> Boot Capacity: 2 MiB ENH
> RPMB Capacity: 512 KiB ENH
> Boot area 0 is not write protected
> Boot area 1 is not write protected
>
> STM32MP> mmc partconf 1 1 1 1
>
> STM32MP> mmc info
> Device: STM32 SD/MMC
> Manufacturer ID: 11
> OEM: 0
> Name: 004GA0
> Bus Speed: 52000000
> Mode: MMC High Speed (52MHz)
> Rd Block Len: 512
> MMC version 5.0
> High Capacity: Yes
> Capacity: 2 MiB              <== correct size for EMMC_HWPART_BOOT1
> Bus Width: 8-bit
> Erase Group Size: 512 KiB
> HC WP Group Size: 4 MiB
> User Capacity: 3.7 GiB WRREL
> Boot Capacity: 2 MiB ENH
> RPMB Capacity: 512 KiB ENH
> Boot area 0 is not write protected
> Boot area 1 is not write protected
>
> The previous mmc_set_part_conf() implementation set access to boot
> partition without correctly managing the internal mmc variables.
>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   drivers/mmc/mmc_boot.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/mmc_boot.c b/drivers/mmc/mmc_boot.c
> index 986e6c500b1..859aa5fd1d8 100644
> --- a/drivers/mmc/mmc_boot.c
> +++ b/drivers/mmc/mmc_boot.c
> @@ -216,6 +216,7 @@ int mmc_set_part_conf(struct mmc *mmc, u8 ack, u8 part_num, u8 access)
>   {
>   	int ret;
>   	u8 part_conf;
> +	struct blk_desc *desc = mmc_get_blk_desc(mmc);
>   
>   	part_conf = EXT_CSD_BOOT_ACK(ack) |
>   		    EXT_CSD_BOOT_PART_NUM(part_num) |
> @@ -223,10 +224,20 @@ int mmc_set_part_conf(struct mmc *mmc, u8 ack, u8 part_num, u8 access)
>   
>   	ret = mmc_switch(mmc, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_PART_CONF,
>   			 part_conf);
> -	if (!ret)
> -		mmc->part_config = part_conf;
> +	if (ret)
> +		return ret;
> +
> +	mmc->part_config = part_conf;
> +	/* Keep the block device in sync with the new PARTITION_ACCESS */
> +	if (desc && desc->hwpart != access) {
> +		ret = mmc_set_capacity(mmc, access);
> +		if (ret)
> +			return ret;
> +		desc->hwpart = access;
> +		blkcache_invalidate(desc->uclass_id, desc->devnum);
> +	}
>   
> -	return ret;
> +	return 0;
>   }
>   
>   /*
>
