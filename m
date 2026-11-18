Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9A260A3817
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jPusKJwy;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=mthw8id0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9318A40A0B;
	Wed, 18 Nov 2026 14:17:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 58ZOw213eA7C; Wed, 18 Nov 2026 14:17:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E9AF6409D2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795011426;
	b=OSg28xmW4pgraoSxEiZrRVIftNehaQS1MZz/WMV8sm/m4COn/DbD6CrSa/GyH3YJzGaO
	 S80Qc6lc0zOCtGlTy7PuTRVguNQ6xjTvPqZ4qdJbRl9gyF/yAVIpKo1X0grNjq0WRkyt2
	 BMmEgta0YJlg/+5qwpZeQRkbQJcJLrlisUZUHOfQfE92nCZHG7p8GwuagcJNrwz0zTWr1
	 nU+B5Zx9qx3N61wQzjcC+2GimhuBmUdaYUKGEQf5Ger6dA7fk2krIokpPUG/pW4C+AJU5
	 6ZfInfFezTOoCFO0r8qKBcY5QCB1YEqGuLq55x/6adCs6qWfu34tsRsc3WEv+W8maAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795011426;
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
	bh=krV54M0zs28uO6i4UA+GCGqCWFhHZytOqnmoBAMsY+Q=;
	b=Qlcz50Cxxof/IbA2Mua2IgSLPuhytnXkoQN0ngfv4mhQ1GipRFv1BQIj16ier/JbRWE/
	 mNAWQuVKNfgR43eo7cdeo2WGPCA3TDoMrQagKF/2KEY2iZsTo1f56JoV74OQFTlauLX/+
	 Wo1fUv93YS9IOLRDLHLvDsyc4ErpOI2q8k0KJT8HdlsKfDknk6Q3btilOcTJfg4m5jbt4
	 k4gDfsTCxNTjmYtWgsGpndD4LgEsLejVp7Jm3Zwt4iyqhyu7a6sRRD9sZQ5vdjQJDwHdb
	 qDwPNj/RPJPh+FU+T6yB6nnaAZWwvJk/S6Iw1ki9HuRbgO9TGd/ddvF2HYFXZbNqZmw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795011426;
	bh=krV54M0zs28uO6i4UA+GCGqCWFhHZytOqnmoBAMsY+Q=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jPusKJwypCYuoXltvuQ5umAAXID7abqNrYdjMGoh3dIRHMfdkbZeitqLWo1510KWx
	 py7tSJfCAsa2VoOwDKpBjTIhU3C3rsdWFs2rmX3FlWVejb708FhYJxzFLhT+bmTmOg
	 cRTBKRh1Yj9dJQa62FDAuT3W7nHFaKbv7GGIEteGmJAzLRKETCjQG9Bpe6RaIiIBTw
	 ctAncpgViBuasCAyjeV5AtwoLdIzqkYi4VKthnxslCG1MmL350SaI75/xsGFPncymg
	 Nsm1j+6J8hhTDlkXPqX5PJGHnG2KA08lqes2jsZ5hF55PenPiZXrITA0mPr+oD7YtC
	 8CBMk8FEa6lyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9AF6409D2;
	Wed, 18 Nov 2026 14:17:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 60F9B61
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 14:17:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5276C60A7C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 14:17:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u_VVuI79eYkN for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 14:17:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DBF436085E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=mthw8id0
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DBF436085E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 14:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krV54M0zs28uO6i4UA+GCGqCWFhHZytOqnmoBAMsY+Q=;
 b=mthw8id0SDibrO7UcOfl5+Ce0pZBwVo74hk/pXC351HA/OHsi1WuayXlNO4xTXDywHADdAMVk88rY3PSqbi4wguWL4yhbj6gNSssH69nymqclX8C8faWDJkoGKYZGy3/7cGqO4xSJ/fHNOp7p02RoSz993lMjPBUl4/9E/7YRKE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by MA6PR04MB496254.eurprd04.prod.outlook.com (2603:10a6:250:50::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 14:16:56 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 14:16:56 +0000
Message-ID: <c8a86b05-8b77-45a3-b729-69a4b7ba7034@cherry.de>
Date: Wed, 18 Nov 2026 15:16:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: Remove spring board
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 u-boot@lists.u-boot-project.org
References: <20261113172043.1235725-1-trini@konsulko.com>
 <ee124480-6356-474c-92ca-6f27de77be7f@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <ee124480-6356-474c-92ca-6f27de77be7f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0120.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34c::18) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|MA6PR04MB496254:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b604461-8166-4ceb-f1a6-08df457e9a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|4143699003|11063799006|56012099006|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZEvnMoIhQ6NEU0CHTLjZyfa16xKTTAR9SOJIfy2Z85y7AKOk8yGsV4tew2ciZVBWCC/kLJUqdKeX7P64znTVEWcaZBsELZFN04jzVM+g+KZosUNGkaTk/8H/DyKAPvp8/7LpmWQ5Jg0hNFO9hOS9tlhao085vQmfDUIwJCeInhg0VTCVJ6fNrmejSrdGuhglaZ8tZQrcZmng6zm/8b8jcN+eBs5hLdvOfch61+jH9nMWlC1Ko+cY5UNCiw/arYwqUZWGKD06HFA+92FG+zPh/B4GXUHQWp8WeeZaXiKMQX3tf2dwAVxxqa+1FgLtf/dAQSvaPGZ/XlLDjXU5vOFWGhuLzJgylgReG1TDJIDpL8HEmnRjFwQC1UTEgTI+t68Vcstfs8nppK3EQqkgwFGK6A4+sgZ1VZMZp6Bm+9soaePB7JuGhwEaJ4w3HCVz917T3EdNfO6WS2d11DRVX08I4tDmoZjfvQQ7/hlPBf9h5Muov2o2VKSePceN2Ot9N0tzDbZB0d+DlI4V0YXaPk9jNvw0RhcJmk6NQV25h0kZgsPoUdVebrWMKm8smGpS6bdcyn1ac7lupyfNK5G7MMtwX/TobKE+73Dd+tu4ybLI9pf+JkSQ22fvO7u8ZOrzFfbb6hWS3o0hx0ZErnPg0TbEOrdiaacqN16MWSZxeXhbfiI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk9BelpMdDN4dmhpZUxKMDZueWk4aW9nYmtkZ1R3MFN2VU5wSHIrdURLTEVF?=
 =?utf-8?B?ZExVaWFCblUrQUI1TThVUTEvNnhBdk5UT3dSTkhsK1ErS2d3UmJTdnF2Unc1?=
 =?utf-8?B?QXc0QzRzS1pDUGROYzlKQXE4aEg2Y09kUDJoMGcxcE5EWTBGMTR6MzhYQTN0?=
 =?utf-8?B?V0hMV0R0S1NXbmNLR1BKMUQ5SCtsTWtuNzRRYVJ4VjhPbExLTjNwdmpYZEdC?=
 =?utf-8?B?aXZVZGUva2dDSG85aHI3U2o4d2Y4K203TGpDc3BHNFVnaHNkVFNxMmcvQS9J?=
 =?utf-8?B?QkgxRmt6c0NydGljbVk0NGhsaHZ1MmhhSXh2QzF0eUFiVWxIcURWTTU0Y0Jk?=
 =?utf-8?B?NzA5UHFIYTBaamNnMDJuT0RGaUFiWUt6ZzI4Uml5RTJ2bWVod1hjdTkxZzdS?=
 =?utf-8?B?cWdHVk5DZnFSem0zRHBsY1E4NzF3dmhya2VKRlJYb3VhVVJRd3MvRGJKbTVo?=
 =?utf-8?B?NEZsVkR6aFE0bGJJcDRTNEcyaUxVZEg3YWlnWGpnSGN3Y3hMZGtJWkswK2tL?=
 =?utf-8?B?RlRwM1R4OFdnRHMvWC9mMS9NTXc2bmh0eDRLR1krYWdIcHA2cTlqSWQ2U25P?=
 =?utf-8?B?OS9kaityQnVyMWFSWE5JVG45K05vUVJlNFF4ZjhOSVQ4OWE2d1cxalg1clF1?=
 =?utf-8?B?aC9rbzBCNnFRNTFXY1pYZFZRWWR0NFloYi9mcUNhdXJuMFZ5OHRlcFFqSDdp?=
 =?utf-8?B?WkdEWXoyVTZkNGxZSU8zYnZlV2JaMjdhRDFZRkV1dHZqWVJuOW45WXFKTGJS?=
 =?utf-8?B?cUUyeER6VGtVejJHSUt3M1F6VE8yNEhEMGhyU1F0NkxkY1NQcmltYzJNNFQ5?=
 =?utf-8?B?UlpublJyZ2RCVzVPYVB2NmJtN0dDaC9BajJqU0tmYmNMdXMwY0RWZVJBbnE5?=
 =?utf-8?B?N0Z2Y2dXVmFlSTRvZmMyMWdGd3NyU2pzVlFkZFZJK2hMK29HaFBsYTR4R05x?=
 =?utf-8?B?ckpLS3RMbDQwWGdEUzJDempWNm5NU1NXZjYvMFd3em9UNU9WZ1RxZ2tzWmp4?=
 =?utf-8?B?c2dkclBxSDZsUkxNS2dVeFZSWlRBQ0Z2L1VESFh4UWsrSzZkRlozaDA3R3h1?=
 =?utf-8?B?Wk9kNi9CVGNQSG94bkVjeDZ4d2RHY1RIWjBRV09jOEo5bS9oWjVtd21rcngx?=
 =?utf-8?B?OWpRaUZCTlRRNng3YmJ5SGkzdno5TGlkOGI0eUxaWUJrYVVhZFdLMWl0SVJ3?=
 =?utf-8?B?T2xKbG5RdHh1dC9xb0QxY3dQL2x2ZEowckxwMVd0QTlJcGFNcS82MjVyMDVZ?=
 =?utf-8?B?ZHdmc3Qrb2NYRFZtWEhtSC9ZWkZyU1dXOENFYkRLYndGT1NQL0dxb2VRUjE3?=
 =?utf-8?B?ZjlXbVN2T2xDN0pnWmx1QVFPSUQrTWkwZmsxLzNRT1R4RjNXc0hlelZwRnZo?=
 =?utf-8?B?VjdlOHNPbUZQakQyNWJKRGd4RURhTnRpQ29weGhjU1A5YUJDVitnN3pPN3F3?=
 =?utf-8?B?eXlld3dKdHFrMGh1OUkzYnlmb2dpT3g2OGt4RG44MmhpaGlhT25HejJTcGY2?=
 =?utf-8?B?T0ZjQzZBc2hqcXd5aEdET3VXT2p2VngyemN0QlUrdHBrNjhYdUswRHc4T2hO?=
 =?utf-8?B?b3JJU0huZkpIcXhZNGFVdGdCTk1sWjltZDhENEVxdlVJa0owM2VHa0dma09W?=
 =?utf-8?B?QlhEMDlJaDFjTGtJNmE0Z1hkbjY2RTdTNlRVMmtMSjIwWDluazAvSS81bHdi?=
 =?utf-8?B?SEpjWXVxbG5EcFJ3UEFZdTVZdmQ2RHVPYURFZ3hRWm02enFZT0xLd0ZlSGk4?=
 =?utf-8?B?YkhoYnVmT2piQzdMMnEyelo3a25JUzE0UEh3OW81S0pIZk00RjJNamJMN3U1?=
 =?utf-8?B?akdHV3dqMkZ5a1JoaDhPUlhmQmdkNXV5OThyWktWZEtXbWpDTGJ4eE1YaTBS?=
 =?utf-8?B?NHo1N2pwY2xCVjlaVjFRbGhyTDlpRmVaU1dOdFh4eVd2Vk01d21iRVRSQUdn?=
 =?utf-8?B?WDk2V2tURVN1Z0dRWHlmdnN1TERvNWxobWZtcmxEWWtpZndmZFhtajVsRTVY?=
 =?utf-8?B?WjQ0My9FMWRUNG9CMWx1SU5kRStPSjl5eEJ6eWs2d2dweWlKT2lHeU82eUpv?=
 =?utf-8?B?c1JGUG1zaU9CSzRGdkhTQWlQeGJpREpPQVFTTFZjZTY5N2RVMGhHS3FOaGNK?=
 =?utf-8?B?cnc1S1NhWDR2QWh0QTZ3MWhicmdjQ2krcVhjSnRNSGtlWUFjaWIvaWNaWEpM?=
 =?utf-8?B?dXdicGtIKysrT3paSFUwTXNmc0dFNnMybTZQbHdZampldGxFTTNlN1JnUUVE?=
 =?utf-8?B?TlB4YmJ3bFJaUWNjbzdHOHBod05jTFBpTkVyMVFPbXBBUXdTZ0tzb05VblFR?=
 =?utf-8?B?OXRYaCtPbnRmd1p4NEZKZU41bjNNcEFHbGp5dzlVMVBLYSswc0xkdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b604461-8166-4ceb-f1a6-08df457e9a21
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 14:16:56.5377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBkw0DIfQa9/b4HteYgEwJysYD6VjlrITMi/Sb01+GeCopLcdBJeOgccr55e+ndRmfIec+JQ4AulxLgl5wqqeDVNcSjXMCklxmHM/mAtVh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA6PR04MB496254
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 11/18/26 2:45 PM, Alper Nebi Yasak wrote:
> Hi,
> 
> On 2026-11-13 20:20 +03:00, Tom Rini wrote:
>> This board no longer has an active maintainer. Furthermore, as it seems
>> unlikely there are active users of this platform, remove it now instead
>> of waiting.
>>
>> Signed-off-by: Tom Rini <trini@konsulko.com>
>> ---
>> If someone would like to pick this up instead, that's fine.
>>
>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> 
> Can we postpone removing this for a while? I recently managed to get one
> of these (HP Chromebook 11 G1) in non-working condition, though I don't
> know how broken it is, it might just need a re-flashing if I'm lucky.
> 

I think we only need someone to take over maintainership, mainly because 
unmaintained boards are not allowed in our CI. So, edit the SPRING BOARD 
entry in board/samsung/smdk5250/MAINTAINERS to replace Simon with 
yourself, send a patch and I think that's good enough for us.

Cheers,
Quentin
