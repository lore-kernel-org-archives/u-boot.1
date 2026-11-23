Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58023606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cs5Y8iqw;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=AtvJxg8V
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E74D480DA8;
	Mon, 23 Nov 2026 09:41:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xUPhYGJLPNvZ; Mon, 23 Nov 2026 09:41:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3988A80B88
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795426888;
	b=GfMgSuEhOgXD//XQCcbw3lSFvLSuLeoYKixhcueMo+hOZgfe72uvVLpu+5oAWspUTD6M
	 +XDm/4cuHXMIuZkxwTkESYonXAuT3eWBkG0exf1gEHG+DlSWjW9qPnPNSaW0bIwLG7KEs
	 uSez1GyUJ8NfdAPryGPdQM/BWbzTkAw7owvMThlWHFauop9zxHbr4Uar12daMgXy2ZS5b
	 U8AK6RGeJ8CeAeo6jfMz9475Q9MtNlyf0R3EUSuhdPrLqEtEHrm1+HE1YQEC9EMyvQd/1
	 E1gP5zYM3uuHFeH1dGDEFGlRmrR4nnECrtvN+hEbikE5QIw/A+v7LFKlTPsMiXGwVlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795426888;
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
	bh=/PGoUU72D/6KtGXwLxz6ubUM4Zh7vczJ0npmqbVdw0A=;
	b=oOL9rzdWt1QUheVT/1QIDuOoNyozTL6gkOg3cUrH3hGN0ZSHcceBAGTS1v9H5tBJwEh4
	 4QVyZWg1Phu7rmXHG8hgTYbj6OkY/xImrmKDP8E02j8HfYqtN7sFZy7204or4kguuwlng
	 TY01JBvGWGrinKhopBd/+J4k6FYRcLmnCkYOv0TzG/4LDY62ymM5kBSdlyyuVr/D8fxAA
	 C/VNbRp0WzHT/rRdggNbNTpNQHTsvxiOdTYxqswzBEccR1gthn8ryM3OMY+sYnlH0LRn3
	 FbJPhyxyxDWdslBcPamqlyhcUD1PRKW0mIVVJ5qQhBjLhXDGaDcPEpzngQOyU+DS7XA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795426888;
	bh=/PGoUU72D/6KtGXwLxz6ubUM4Zh7vczJ0npmqbVdw0A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cs5Y8iqwSSYvdsylL31Qz+bkhahs2Cbuwt/jCgQ9JmyA3/40UZQ5SeXlyVtbUhpSZ
	 +aSqocDmAVmHeWo9yRsMmm4dpF/KKVbSCTo21AQEIX0bd1K1fSmMzSVUTXw4syGI9y
	 aI3gK2MJ3jpmHA77Mize6hzYtP5/5YQxeUEpXiNs12KjZTC1F1doYnm5SpV5KWxQGw
	 vImCjrjgQJ53w68E5D/6jePtbRkJBPtF3Y7500E5MPxTa8d5dAC7d9q6yxUokRH4pQ
	 A0Nt3pIGApQ8L40Zm2RIo2x1ZLIIreciULNeiQsW78u18SwvKRYz2cffmjx3PXjnlq
	 wjKo2fHGd5Qeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3988A80B88;
	Mon, 23 Nov 2026 09:41:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AC4351AB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:41:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 957E5606DB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:41:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bw53K9dLjlDd for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 09:41:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 140FC606D5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=AtvJxg8V
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 140FC606D5
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PGoUU72D/6KtGXwLxz6ubUM4Zh7vczJ0npmqbVdw0A=;
 b=AtvJxg8VklCLcTy9LLaMkzRVHhOOIlovUuSBtNf7CFtkwTj3y56vTdZABLtVPsXF9kT6+p6I3u3QNzLVAxuTZ0ti5jhAR4yfvZFPCD/H98qbwa+sQOdrFRUgOeZ6NMh/MOKcge2oxCDslC6D4RT3oVhY+IntgoQq73oOCk5x9yw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DB9PR04MB9818.eurprd04.prod.outlook.com (2603:10a6:10:4ef::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 09:41:19 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 09:41:19 +0000
Message-ID: <3881a767-5c42-451e-9518-fc769018a2b9@cherry.de>
Date: Mon, 23 Nov 2026 10:41:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] binman: fit: skip empty data property for
 externally-provided images
To: Paul HENRYS <paul.henrys_ext@softathome.com>,
 u-boot@lists.u-boot-project.org
Cc: alpernebiyasak@gmail.com, trini@konsulko.com,
 philippe.reynes@softathome.com
References: <20261120154737.110128-1-paul.henrys_ext@softathome.com>
 <20261120154737.110128-2-paul.henrys_ext@softathome.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261120154737.110128-2-paul.henrys_ext@softathome.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0090.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35b::12) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DB9PR04MB9818:EE_
X-MS-Office365-Filtering-Correlation-Id: 5908903f-2637-4c35-bbf1-08df4945ecdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|4143699003|56012099006|11063799006|261021123027099003|261021121427099003|261022075727099003|261022115727099003|261009223027099003|261026121527099003|261102123227099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 9k0U2XetONYtKsJGMpxoXOxoMzIQ5EdYXj9hVE4KSCjl/U2oJ73Qy2sdbH0BYMYWCzbk4qYjLKSN7Ez3jjmgqWS0CJsJq0a2whx9P7vPBwMsqnKSL/BnrzJLrugMHwbhCGBe0aT2a2rcrWumcoz2wGTZeymk+plhfZk3rNHVdVbgi1ooAVD8n08y3zmZCpfiEBIKqssKp6SVegWdcP00aj+67hoIH+acoPdiIZaamcXXg5gZqAhPBG79LcWVC5hgQlafSSbML6M7/ZdBpZe2tgF7ow7I0OyGd31we+bKlRzOiLd/tx774z5Wc4I9/5Ioh3vuRHXdyRlkpqdH50VQSYzVrvwp7n06IzDY1fSuni3wMnAzxu7Rv+82Xbu8d7VG3sUuVUibCUcgBhYx8Ogapc5oVHVELbobMmmL2J5FqA+OT+GfPnUGfsKLIozQldlRt9Z1Xyn8ipJ+HlM6kbgFfb3VUG401fBvjAJhsrxcAfOKGYherRWsNsAsvqT07a2xqIdplX94y3ITbKmmUDMX3i/w1EOLEUeaqNuB9jNEOJbWdN3Qrtg8CF8E1HYQcm+gxmejweYStXQX91oXuih1QWOBVRv3BrUVIeEnTw1KT32up5jwedOKuhV+S3Ey7xLIkxB+NqWoYwJFpoE5VvYmQjwE3LdP+TvK9hwze9m2a8M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261022075727099003)(261022115727099003)(261009223027099003)(261026121527099003)(261102123227099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0xROThRYnFVRUw0dEJUV2FEUjJqSEJ3eFBFRzNtZVUyakNPaSs0V24xVjdH?=
 =?utf-8?B?MnhsTzRQUW9yRTRrOFZaSm1sZnQvOFNFdlhUc3ZmNjlIeEExSlhxbG5OUUhO?=
 =?utf-8?B?MUMwK0ZWeEduc0h3Q2FLK2pKejdUcFhzcXlHaTRidTVNM1FQVHVTTDNkVFRG?=
 =?utf-8?B?YUZUZDVtYkJqcDlQZGNzaHpEZ2tpcjVGOGxKd0FQaVA5S2h3Y1A1M1BoL1lJ?=
 =?utf-8?B?MnFMUVBIdnplS3NwRktVZFluODVOOXVMOVNlVXRoT2EreVh5YmY4ZXplTUo5?=
 =?utf-8?B?WnJvVHY0V0thQU9lNm9vbWZLc3RPWG5xclFmdHptaGRjNWxBN2ZaSXBsblNa?=
 =?utf-8?B?Q1lWT0JPTU5TZDhsWDhBdHJpb1JkM0dGaGo4STFDUFZrSkpsSlNoWkhRZlZV?=
 =?utf-8?B?cTFNUjc3bWx1b1pvNVVwbE1abHJZUS9NVXcvN1lYYUpqYnYyb0RBd1FLK1l1?=
 =?utf-8?B?cTlMZ1F0Vzg0YjA3SlNiSHcrNlpIb3JNTDZ2UmZvZG5xbkVoczE1ZGxFeEVs?=
 =?utf-8?B?Mmc5TnMzNXVlTU1xT2tFc3VsSjZpSlpCY0NMR3RxVmtmWGxWWnRRd3k3VHRH?=
 =?utf-8?B?UE1OUXVUYlVMQWxPVnlYcWwzVjVLaGdkMTYyM0xoM2tOS09heXNDYnk2UWdY?=
 =?utf-8?B?WXpDNk95YnE3bGtGZ1R0OGRaTFQ0dmJTV05zaGw2V0hEL2RscGR3SmZXTVpZ?=
 =?utf-8?B?T2I0YXptV2ROTDd4V1RtOEEzbTU1V1NLcDAvdmlFdnBYQ0dyRlFpVUp6NWwx?=
 =?utf-8?B?S0JQcVJaODRIK2F2bFdFS2p6RVkxaXY2UkZ4MXR0eHZNcGMwZXdpZkxvWGE4?=
 =?utf-8?B?Mk1qTWN1WDFMZGNrTDJubll0NTd5Q3BRaUZUQ0hhaDBsaExlV2djV1l0SWcr?=
 =?utf-8?B?bTg2VGlVcDhlbDRMRjVZVXppUllKcDNJa0dUN2xJN2ZwT1BXY1YzdkFIb1VU?=
 =?utf-8?B?bjBqSm1GMitxOExxR3BNYTkzSy85bmhoNzRzejZqM0RoY2trWU1lMVBiOFoz?=
 =?utf-8?B?YmVGRHRndXl0YXVnSFljVzlCdGdlLzR0M2RDOFRmWG9YOHl1bzNkQ1hVdWk3?=
 =?utf-8?B?ZW53aWVTZEVlQTZZa1hqb0FOTEdpVGludytnYTJjZGtLckFoWTR2NmVwS2pl?=
 =?utf-8?B?ZENkSXNPU0M3dTV0YkJEQmU5Y2MzdkdQeVllQ1Zsa3VXRTZId3l3UVQ0d1FJ?=
 =?utf-8?B?MGh1TEZWZys0L2paK0U5RGtObHdTVHVtbjhuRXZFUHhpWE9jYnFlNEk4S1No?=
 =?utf-8?B?YVFFek5GV3djeHJDeEFXSjVXRldNS1E4RVlac3hhU2NGQ0F1T0pJNWJYck5l?=
 =?utf-8?B?SE9lMGVzRnBNZXVhWTNydmNXU1FIL0F6L0RkTnZLVlhoSE5JdTlEQUhGaWRT?=
 =?utf-8?B?akF6MlUwRWZoenUyRXVuRWhFeU95OWlnS0p0YnRKU0pYd2p6T2RqUDUxdFhH?=
 =?utf-8?B?b1NlV1lWeTdyanRqd3hneE52bEp2ZlkvU0ZFVVlzRjIxNXJhTHVLVlY2ZGdD?=
 =?utf-8?B?azZoMTFacGhNWjRYZXlxSnNBcGlQZWVMTEQ1K0prSzY5WWZSMXQ3REw4KzU1?=
 =?utf-8?B?bDR3WktHcHI2ZEE4VlVJcWEyMTZkdDlsbmF4NDcvQ3AwbGV0VWhsbm83UXgv?=
 =?utf-8?B?VUFZNGhHS1R2aVlyMS9WWVE2UFFaVVlCTjdyakVoenducThyK0t0aEFQeVBC?=
 =?utf-8?B?S205WXR5SmxUKzVUVzFGL05YRzRzd3hyTGxVRjdNeDBUM2d3b3I1SE1KWFoz?=
 =?utf-8?B?R2hyR1lRWDhVYm15UzhtZ0VQYkNsMjY2dDJObkMrVVdPQllqdG53WWFQR3N3?=
 =?utf-8?B?eUZUQUpVaUxuYS9yUnM3SlNkeUplb0h6QlN1NjlCdUtROThZMUpNQjEvZnVG?=
 =?utf-8?B?T2FLWHVEVGtrY09jMEFRTTN5SHNWeXRpSUtOSE9TVHlicVpYcHVJcTNHL3dn?=
 =?utf-8?B?STlnM1FJaEx1OGVvbHREZ2JxQUxGand2VW9XSEU2dTE3Z2w4T05yYkFNbEl4?=
 =?utf-8?B?NStmRUdyaUpma014Vmc2ZkU5ZGZxNW9hbThvOVpDY24zbGtURG1rZkcvY0R2?=
 =?utf-8?B?QWdyYlBKZHZhQ3NLcktjcWtSS1ZXREhFOEhVN29aemdlaU1mMDFOTExkUVJa?=
 =?utf-8?B?K1RDQ2VWUHRIemNYemYybndRK25INFZ3UWNKTlcvTlF4VWVSd3Y5M0Y4VjBM?=
 =?utf-8?B?cWw1aVJlTU1kbG1EcHhWZnZJSVlQREhPZDQvTjlPdGFseEZSaHVycGdsSXlo?=
 =?utf-8?B?QVZ6aXFyYzlINzBwNjhWVXU2RlRVK0VjS01FU09mNWdVSXdINVk3LzJhakd2?=
 =?utf-8?B?NmR0bEtZemw4b1VNdUR2c1AxOCtmdmsvN3JJT3orM0Q4djA4Nzladz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5908903f-2637-4c35-bbf1-08df4945ecdf
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 09:41:19.1076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jf14n59Xwd3wSCZYLI7gjGhxzasVDhw1mPcS+DjxWXenTaUS3MnklG569pmsXklTOGaLxWjifY/hzu4MMd1f2p0J5yrRFRLrS0G332FIQ5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9818
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

Hi Paul,

On 11/20/26 4:47 PM, Paul HENRYS wrote:
> When a FIT images node has its data provided via /incbin/ in the DTS
> rather than through a binman sub-entry, entry.GetData() returns empty
> bytes. Writing fsw.property('data', b'') in that case emits an empty
> 'data;' property into the intermediate ITB. When mkimage subsequently
> converts the FIT to external-data format (-E), it adds data-position
> and data-size but leaves the now-empty 'data;' property in place,
> producing an ambiguous node that carries both inline and external data
> attributes.
> 
> Skip the fsw.property() call when data is empty so that only nodes
> with actual binman-managed content get an inline data property, and
> nodes relying on /incbin/ sources end up with clean external-only
> attributes after mkimage processing.
> 
> Assisted-by: Claude Sonnet 4.6
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> ---
>   tools/binman/etype/fit.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> index 4657ed1fd76..bacafc9b9b2 100644
> --- a/tools/binman/etype/fit.py
> +++ b/tools/binman/etype/fit.py
> @@ -1047,7 +1047,8 @@ class Entry_fit(Entry_section):
>                   image_name = rel_path[len('/images/'):]
>                   entry = self._priv_entries[image_name]
>                   data = entry.GetData()
> -                fsw.property('data', bytes(data))
> +                if data or 'data' not in node.props:

question: why suddenly the check on 'data' property?

This seems like a different kind of fix, where we don't overwrite a data 
property already present in the FIT. I'm not even sure that's correct as 
binman has support for replacing entries in an image, and I'm assuming 
it should change the content of the data property as well.

issue: missing tests

We definitely need new tests in tools/binman/ftest.py to cover this bug 
fix to show that's an expected behavior.

Cheers,
Quentin
