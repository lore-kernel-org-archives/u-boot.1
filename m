Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDDD606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=m9rgYNxH;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=EcgCyHkn
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23ADD606A0;
	Wed, 25 Nov 2026 13:56:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 801g4PdkA_TU; Wed, 25 Nov 2026 13:56:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 748C9606F0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795614974;
	b=nVGVbblGyqSiONwMYzDwPuIN7y6djpfXFbbwyaDvZJ+i6rKZAzZA01XmDdt9tFDUHOSp
	 VJP/FJVnH9O58fb+hwQ3nThCDDMaaRVWmF4fC55fcvi17UlZbJMNvyoQ0Rnx0c98zUhXA
	 MKFHTCHXAFBVa32pY1a+IIJvPsalR2HuPKIPIgPQiReCHvwU46FpJRUhJMzZTuo8QySsJ
	 dnLScAK31fvZp2vvxQiLEar72q3sn236WwHNRR8dzzdcEOgbiFX95o9GKWYbMnmZSGEr9
	 LKUkPTjLtsMoJ6WVn4xFpXlXaQOkt4beZcVjnWAGpMq+gznqroF/x59Uh9/Z05jq0KA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795614974;
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
	bh=PAj3grjWPBbEwhr+reWHKOgtv0UMvxvByIs7ne2P8sk=;
	b=sohaDYJPoQ6TKIGSle16VAVSmMsksOjfwz0w8OVnRmWtorvoe90nLawLu7o5pGnRdgRi
	 3uQ+zSoH6/s/IxSivVfk5IV2O1TIz/pg1r6lOYnQLXBGZzr4qY9RYNKgSzZk+XqpbstBT
	 B9PBv0CNwQt/qGhGJUCql9e0STwNmi1zBzfOqjyExOs7gVyixE9qy9rdoNpGaAfdrDxwc
	 bo2iZ3x2+uv37m8IR8e4Rufn9fh9hhqESaBekIy06ow8b0vS64ZRtPKnZ9sjZ9xM2utvo
	 6IILLsKH/QmEtd+1oYOYT5AKDwddqqT/kQHtTyM0spkbP4w46mgmi5LJkmfFiqvo7Ag==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795614974;
	bh=PAj3grjWPBbEwhr+reWHKOgtv0UMvxvByIs7ne2P8sk=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m9rgYNxHb03eJoHm71FwKuQBCzVk4gT1Kt/suNoycrdTycpQkwfkr7JUT51L7nIK5
	 ZJDyMxthsPta0hJ0akVvZhhQz66DtVW1Py1m8Wq39scYPDtfdGbaTTR/12yBiFbz2d
	 5fCrQfFHxW3CUiXPB4GPQ8UpDAW4VDuTeitE9w0IK9A39zMOMArQ/Su6t+XZI+msqU
	 6CRLUlTnO0QsdoKqcPEZt0Eoknq3Yt7q96LCNOi1vROlwcsi+E5mdvOO3adwTfrKGA
	 rnyIhylXeCAEokqgSYuD7ZkEfHRE1kHDBXgItHLdjMY3N19eh2ZrO5qXjziAEUhc6u
	 0MeOxpYYOmbTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 748C9606F0;
	Wed, 25 Nov 2026 13:56:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 66DAC22B
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 13:56:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 58CB680CD9
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 13:56:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G7uKQCByL7Ye for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 13:56:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2AF6E80CE8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=EcgCyHkn
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2AF6E80CE8
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 13:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAj3grjWPBbEwhr+reWHKOgtv0UMvxvByIs7ne2P8sk=;
 b=EcgCyHknWWsehvQy2aLjK7l8WftqM5h2sOCWSqvi2MZer9jG8Rqq6K4gaN5NSxOyCoLGap2R+h7c4xzkek3tjUxEKKEtPS3LVXv1itPl0mF1shwq/67/wnLeOBFYYDso5GzdlzJ4j6jxy64hKb7u8ZbIpHsjYpoa7FQZUV6c0vE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS5PR04MB10041.eurprd04.prod.outlook.com (2603:10a6:20b:67c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 13:56:01 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 13:56:01 +0000
Message-ID: <a75c9fe7-d630-47e0-b3c7-a2f2c892b108@cherry.de>
Date: Wed, 25 Nov 2026 14:55:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Dockerfile: Make downloading toolchains more robust
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261125134317.2479815-1-trini@konsulko.com>
 <20261125134317.2479815-2-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261125134317.2479815-2-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0003.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:357::7) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS5PR04MB10041:EE_
X-MS-Office365-Filtering-Correlation-Id: e7908e93-726c-467b-6e33-08df4afbd6ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|11063799006|4143699003|56012099006|261021121427099003|261021130227099003|261021123027099003|261021133027099003|261021135927099003|261009223027099003|261102123227099003|261022115727099003|261022105027099003|261022113327099003|261022075727099003|261026121527099003|261026140227099003|261026130827099003|261028144727099003|261026135527099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 8Uz8jS4/MaFjpr5rebH2oFSSH+Ayb4QA6ud+u8CLz8CsHloknSEBMEzjn8w1vYIVeBmsOAVeSrSUGPUrL/S8qDjHhNIuRIf/38BzyeRq0uSt/IAQEFlDJLc1wIwomh6fIMZw9p8N+2IZxPLKw+5hY8N/tueob7h+TX7nHu8BTNBKhOYHn/d+X5eUBmYJITz5IbA7bfJr8VV89fViGPcC7WbK4yrp95ca+rQj853DDO8Y+ZUAIkVhmLm14e52GrNMEhj+k1giRgsk4b+GylsOUHfcKO6XHpfLy6OMaeHZU0eVfgu2IX06NLTDgq2jYFYmoX2BuBgkz0WHhWdMh/gfvBeWizxRjjzLzr3EAxEAvcUNyZhhYFV3pdbjkSTkbt0FYu0+2qhvbki8yz/83ZKPTtpNa/j8wM8NgBP410m4yLhyIJzwEN61t5fykiip3Uw9eTkg8MYYZkDItch1kawORaBegFD7REnLHscj7gFkRErT8PXVfNLJntKe/0HJqdo3qEUsi9XjYEpsLg0eZJIOYwTjzocIYyJWyoTf1nQgpgEqvUaCOjiifCc3WURTykiPAwL5y2+mcxQCcoF18zTGLidXY4OBUyn7t49p6ZlmLGfRozYINW74NbD8ykh0F8px9RD36pF7F50LqS7ljhh1bWX0jOkjF0YLn56eFn+ov9U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261021130227099003)(261021123027099003)(261021133027099003)(261021135927099003)(261009223027099003)(261102123227099003)(261022115727099003)(261022105027099003)(261022113327099003)(261022075727099003)(261026121527099003)(261026140227099003)(261026130827099003)(261028144727099003)(261026135527099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXFoVW84a3NOKzJhaHlKeVE0eTcvb1VxWC9UbGNDNHJBQU5HR3FOTlFyODVF?=
 =?utf-8?B?Z25jeDdEV2IrNFpaaktoTnBUZm1MUzc0QnZaNlhnYjhyb0JCZ296eGdvd2xC?=
 =?utf-8?B?SFdDOEUvaUNVYzBkb3RMUytwT1NMQzdKMmpUTXdDL3NLWm43L3Z2SXJLYjNk?=
 =?utf-8?B?V3pmNGJ0MnQzWHd2RXUzT3V3TnV3OFZ4cmFWQ3daMHkzcVZTTXFOelBaVXpX?=
 =?utf-8?B?dCt6dUxZdnhKTEM5UmNvOVFoMzVJM1ZzdmpYUFNWL2VSZFBLWVlzRDNJbjBI?=
 =?utf-8?B?SFd5WUk3WWY3QkJZQWVUTnpTYmRKNDh4RTU0NjJNMWpFL01iZmk2ejluMU85?=
 =?utf-8?B?YlpkMHlpdGt2YTdKVGpPWmQ3cEMxdy9XZ1FyRUVQU1pBc25WUXBYZTVtRE9V?=
 =?utf-8?B?SnFQRmFJYWJLdnU4YVJqQUtoLzlGTGtFbFZhZTJvTUZxVHJ1aTk5ZW9OaUlZ?=
 =?utf-8?B?TGQ3dHFITzNndUE2Z003RW9rdHRXM0lNT21jYkFKYVZhbnZPR0YvaFM5WE5z?=
 =?utf-8?B?RFNjWHVtc2tRc3lkZWJ0NzRMRStkWlJGZkN6QlBFVnh6QUxHR2x4alp2RDl3?=
 =?utf-8?B?MDZLMzlyWW4vSnRaOEo1UHNFUXdZbVliSXBPcHkwdmxIc2pBQ3JTWGdadlNt?=
 =?utf-8?B?MUNyNDBFc2hqMlZQQSttSW1oSEk5dm5UekNyTWtCSTVBbjZZbFE5bVNzbjJh?=
 =?utf-8?B?WEZ1RXFQNEt5UkJ3ZmFqZjJNazZDNWVVNFc1NnpkSEJDRUhuRWNPeTIrZk84?=
 =?utf-8?B?UEhTd2NTUldNRk5mT2svQzRUbkFic1B3KzlEZjgvUXR0cVVtWVRBNjdKckJx?=
 =?utf-8?B?NGlpcml1Qk0wQlJjSXpDTzg2eGdvcXd1QmIrWGQ2c3YyZW1LUGlsbHd6aE9T?=
 =?utf-8?B?WXQ2N0wrZXFEU2x1TzR0RHV3bXladjFIcVY0QjlUcjUwYUlibTdsSVpTZ21V?=
 =?utf-8?B?MWs2blBScWhrYVhWdGhiMkh0Y0VEOEJOTWxKYjlWZlNIdGNCTE9HYzRva0FO?=
 =?utf-8?B?NC9ZVmZzS200WjRMc2RkdlBEUGNaOWE3bnBtemRBRW9qd1JnZjZ5OGNNR0tl?=
 =?utf-8?B?MFRBSWR6eldDVlIzQ3pCRDVBMkZGWUZ3ek43WHFWQ29tYUFWY1FGSWZhb0hO?=
 =?utf-8?B?dldhTEdDRXJBb09COHJxenNUMFpLQU90QmlpdUVxdXNiRU9POFd1bU93Z2Vo?=
 =?utf-8?B?VWxRWVVkZjB3dHBSNjlPK3o3RzBEajFERm14T2VuUGlOejhiTmU0YWlpcHQ5?=
 =?utf-8?B?SmRqcE5BQXNGWkFSZS9lRHVYcVZUZjRuaVMvU1ZPY2JXKzBjZURMTlRGVG96?=
 =?utf-8?B?OUZFdHcrZGhUbXJCR2NRdXA5M0RBcjFZS0RaOFVpMi9HZFBZU2dKV2V3L1RJ?=
 =?utf-8?B?dnkyLy9ZaVRleFA5L3dVMngxbjlic3drbGRhMUQ5dkwyQlQxRkMzbWtGSUg0?=
 =?utf-8?B?Y3hEQW1EcXgyckZQVEhJdUplZTlwMDl0VEF0TWhpRUtWTkhXdnNDU2luRnlV?=
 =?utf-8?B?d1JDNTZCeVBWTHNjN2NGazB5dm9GaXVEU3JDQVZBNVIwaDN3ZEoyZ0tmdHkr?=
 =?utf-8?B?MmZ3NW9mSEYveXBRdXlQM1h0Z2ZnZmpqT2VKWmt6VkpwNTVPeitoWUVldUo3?=
 =?utf-8?B?SE40czd2SW44UFdiQloxVWliNmltcm9jQ1pJVlJnQ1p3emFHV0dSZDZrdko2?=
 =?utf-8?B?QXdrV0NRTjZibGpDbE1VcGc3Y1JoMFVCWUV1ZkdSVWY5ZUJmcVlqKzNqUU0v?=
 =?utf-8?B?eTJSV3puSVFNNjE0S0VWbWhVYXJGZ0FnTy9MRCtMNVUwVDV0THpBZW1MSHJY?=
 =?utf-8?B?alRBRHZCU1BNL29HU09TVDJYVkl5THlQNS9aNkVqR0xWQnlLbkh0ZFVmRzZu?=
 =?utf-8?B?M0MzajlhS0MrTGxaWEtLTkJFTDdmSUFhdzFERmtza1ZHS25vRkJwTzZPUUlk?=
 =?utf-8?B?aStEQWZ3ZFRPR0NRMW9ZSGo0bGYyY2pUbW1lT3Z0cXk0VWkxMDZuZ3BoYmtK?=
 =?utf-8?B?RjUycnlTOGp4S1pxRC9VWjN2Mk9JZXdOSDdBdzUwM2hXVlkvK2wzdklXQlZG?=
 =?utf-8?B?V1RDVldTREliS0czeW51emZCSUJwNVZVY1g2L0dqT1RIQkJNZ0dFb1FJMThZ?=
 =?utf-8?B?Q2pSL1RMQmVpYy9QSmRpVjJhQWlJU2FWdFU0OFNmWC90c2J6ZEhNNVJML1Bn?=
 =?utf-8?B?ZTcyaDdNSTExOGNTUGhlaWE1QXdqM3RBeC8xK0ZVdzhmVkVmTGdWQi9iWE9Z?=
 =?utf-8?B?NnFHT3JCaHNnMTFrcU9VS2hjZ2lLZTR6NWQvb3NyOWk2SEZXN091cnZWZlFk?=
 =?utf-8?B?bE9PdkxxTU84WFl1YUY0OXBBYlE4NWw2eFp1NUc1Q21FaEJIVHFFQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e7908e93-726c-467b-6e33-08df4afbd6ae
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 13:56:01.0833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dF1deGZKRyOfHJ2WMQOOSg+P4PauE1zg6mHOvEBDbcD75LL7yzHxQcYmwxNC/7ZPNZugpJfNNK+jtcK4pbnbPYOkwRxqOy8+wwsCd+V9atU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10041
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

On 11/25/26 2:39 PM, Tom Rini wrote:
> Currently, if we fail to download the toolchain our loop doesn't exit
> and we continue the container build, with an incomplete set of tools.
> Fix this by making the loop 'exit 1' specifically if there's an error,

question: Are you sure this works?

We don't have set -o pipefail so anything but the last piped command 
failing will happily return success. I'm assuming that tar will 
eventually fail on an empty or incomplete tarball so maybe that's 
enough, but that's a footgun :)

Cheers,
Quentin

> and pass --retry-connrefused to wget so that it will retry most
> failures.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>   tools/docker/Dockerfile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index e666714f0490..ab001a4d34df 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -44,7 +44,7 @@ RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then HOSTARCH=x86_64; else HOSTARC
>   	\
>   	) | while read url; do \
>   		# Read the URL and unpack it into /opt
> -		wget -O - $url | tar -C /opt -xJ; \
> +		wget --retry-connrefused -O - $url | tar -C /opt -xJ || exit 1; \
>   	done
>   
>   # Manually install other toolchains

