Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568AD60A2609
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QAxszxBi;
	dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=UsmbenXO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A94040E83;
	Fri, 20 Nov 2026 18:44:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LsWzQdJIeeH8; Fri, 20 Nov 2026 18:44:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4946B40E89
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795200295;
	b=dtj/81e1MJqKjUTRvFtAY1lzWnx/Ewwh0m4jJ4tmi2cbY64qUF3r/rxj3bMiRYAIVJeR
	 64JYXiyYKUbEogVd8lzJmF6WaysRKLMi6dIjHAot6rzHNj4Z2FUM0cJUP1Q7MUN8Rattt
	 Q6taWrUZCHGNErfq8r8NZT/4dZwAx9AoLPacbZRkFOjeC2Z1jq9GHpErDj/6FehZocK46
	 blmewgbrFcxq98XriviPkzHsCZ/cayWwGb6xXCK1mbkxymFVtjBp8Pc3isK237Ju/QiR0
	 +7iMWbv6w70+rXnuo1zRv4cdwAe8zet93JWF6pKI48DN/OE+cLMbm4uGhRQ0mue/Eaw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795200295;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Lyxy9fn/0oGO2I6h5AOeefkTn8h//ceGqqp1JB54ovg=;
	b=ki3J+PK5M0Oi8SrQ8k3rQmaXpgq80QzQoMpAMIXXwyTlaezp+lXJmkpy+mynYHhQyOT3
	 nXVNNVNv8QVl86szABDqYz/f1crE/Elz3mxuZCdjexNFVV2TXXycXRGKuynsDYU++d1mS
	 kx0P4rA/JzPSieSd1XX7xMJ6wwcdgyfR7+2jrxJR/GT071CrgYwWhyqEJLwwJT0zRloRU
	 CuERre/H3l4FZzfVJQl4KpWoJNHUAgS532qeAsns1CRDfyLPzlgD9N53JUsgbcQ9Eg30Q
	 UQnvEJvM3SQfxnbqCnPM/nncS5sC0N0H02YzyePAzPnb9ECK5f6YFUchHCXbUt2/ltA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795200295;
	bh=Lyxy9fn/0oGO2I6h5AOeefkTn8h//ceGqqp1JB54ovg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QAxszxBiFikz45U9KmO6m2Uso2WQzdNPjeIXepAlUpn+s+7okSCPICIJJz2eVObal
	 Znd2pMd4thzA1/1Vbx8fZcLWYjlHl8skIixx5u8rMGq5ma+5jMj1OBFWt/o7lK/rFl
	 HaT89eWjB5kzI4jELj0yZ4YS2f4hqwCVEoTM0pzd42lrOOWimqF8PpHgMWHyle9eYA
	 +GgvqgeV0rGLI9WfCGKw3xLKVsamFsUV6eTaPJS6xbjdPlsCBBdFxsnq9Rw3eKLWoJ
	 uWgWHk8FLyh2XTKz0ITc5c5ovxiGG9lqIu87YmyOwKlhJb+g0ApJJbnDnxrHtzxQH7
	 xCfRVsmLd7njA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4946B40E89;
	Fri, 20 Nov 2026 18:44:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F9761C9
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:00:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8558540098
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:00:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1whrS36t-zhD for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 16:00:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7826540050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::1;
 helo=mrzp264cu002.outbound.protection.outlook.com;
 envelope-from=paul.henrys_ext@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=UsmbenXO
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7826540050
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lyxy9fn/0oGO2I6h5AOeefkTn8h//ceGqqp1JB54ovg=;
 b=UsmbenXOvR7JawGJ1ZzwzOcvEikTthFCf27GRYUPJd4BYjwK/tLfc/1O+b6n3UDti/q6QpPSJASfqsJTWXFcQry+IVmOd8lyj3A4laTDh0KiSRG/9c8+EmFr2pY3c6/eL8DCu0oTkOb1JsFP3d/WaCcNMr2Rl2zkSIvzCfZMhZdU5l3w/aUO2+aR0N38i9T0+bCrLf4oAu+A4TOUwnYfRPqxjVUVPP51mFwtvC76w4akrFBlb5TAxS8yUep16cOV0pzp77vBGNH+JeSHYma+3dnRKI0MUIpi5YZ5ZyMnlHGrvhN15/80w3nmMtJhPdpY11APWWu97LpHhvo9wNtGGQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f2::23)
 by PAPP264MB7695.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:544::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 16:00:14 +0000
Received: from PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
 ([fe80::5c56:6063:a2be:2a32]) by PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
 ([fe80::5c56:6063:a2be:2a32%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 16:00:14 +0000
Message-ID: <9a1f82e3-e4e0-49b3-a73c-62ce34ff7f9b@softathome.com>
Date: Fri, 20 Nov 2026 17:00:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binman: pre_load: add sign-size parameter for partial
 image signing
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, alpernebiyasak@gmail.com,
 philippe.reynes@softathome.com
References: <20261120153626.51467-1-paul.henrys_ext@softathome.com>
 <20261120154058.GD3176972@bill-the-cat>
Content-Language: en-US
From: Paul HENRYS <paul.henrys_ext@softathome.com>
Autocrypt: addr=paul.henrys_ext@softathome.com; keydata=
 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
In-Reply-To: <20261120154058.GD3176972@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0015.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:21::20) To PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f2::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAZP264MB3119:EE_|PAPP264MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1c674a-5791-45ba-505f-08df471f5cb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|18002099003|22082099003|56012099006|4143699003|261026140227099003|261028144727099003|261026121527099003|261022105027099003|261022115727099003|261009223027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: cFw25kDLzmfKDgMGOmYdRhqeVkAIaXLNiaU2flVCL0SVf3kNfneV5ruyncDTPQBm6kLRUxj2g2cDCisNmye+wCKpCl/b5xvgTs3tR+uTkGOMEpQt6C1iNf8XaeXyDAdV8l5kkRrr/cG2z0r2+K+NTnCdaeyzOKwiur7FvL4Yzn+eVdeyr7qC23mRCArRUnxfIF7MUwPyMJkbwJPhujdVIhgsxabS5LtPrnR2P++cCgThpwH01KIiI3HPCOnnlZhvve8tRjgsmwvLf1Zm3Wd+slXM0lo7YwpD5fTV+wpuJIrjt09GMdfSbN8kRXhA/1zNcuuHscb5NOMGmqRXVeqYw9vih+smS+hW9AztyPEEFZaCAWpz2nO7EVpSfGiszbhv/9Nqwuu3cdMo/oJ6Yo462ZjoPGHSM2o734+IsQHAyELW29M5AwuAnSAvxbAYSgJ0ko118dc/e725gTJ4v4o7sDUwhhn6II5PvRPE8TrqeVfuP6tClEYYDqy/Vy8kVegZDDldn1osRTDHOCbPxudEUTV5B9pas0fyVS5fk8oFIWAIybd+cW2RcjX1Xmt3hXI3bSyYXRfPnJLvg+++ObAk47Pv9bzujNtzy0SzYoKvp/V1VIp+ZbiYMCfy/3ASXDp7o8LLwK3lO5536I7mAfh4UVLkISwA3PceVSCFhjGlNxg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261022115727099003)(261009223027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWFDemlLMTcrZHJJcUlSemY0QWx4d3VrR3VtcmxNYVUwOGZ2a1Y2Wmp0TkZv?=
 =?utf-8?B?TUdodzNwTDRoTFhOcVB3d0pkYVZUdHRGM054S3NuZE5vdVdVczUrK0pxSHpJ?=
 =?utf-8?B?aXJoNFBRNDZuY1FkaUJTblErRE1ISnFxUFpmY3hsc2NIb0czWmJ0YmtUdDc2?=
 =?utf-8?B?NFVubWRkVHJ0TkVtVGh0QXcydjJsOVhpR1Bna2p1OUNxQlhwL1drRkhhQmVF?=
 =?utf-8?B?MXFMbzR1RXdCMkRTL3gzT1ZkVTJSM1VWTzVtcTdjdytOVk52WGlCMFJwMTZH?=
 =?utf-8?B?Mm1hbHRReFBZWUV3dUVaZmFTK2FrUXdZejJkRlRhNThDcUowVWtxMklGS1JI?=
 =?utf-8?B?TTNNMFRoMThpSThCQmZ6bFdjd1pxNnRqYit2RzFWbW1IdmRGbWRtY1BJUENH?=
 =?utf-8?B?MzM5TmhMNXRIZ3RBUGFYcWR3ZEttSFU2YnFpcDJnMkVaWENkcGE1Mkwzd3BR?=
 =?utf-8?B?elVtNDZ4VTR4dmwrZmJoL25VZW8xL2x3R1ZqcEZZa1QyUWJ6V1pwVDVmS2pV?=
 =?utf-8?B?S3BEWTh5RnhNZVhyT2dncmw5czJ5aTNpUUtYcVhjZW5FRmk1dmNvVTBKNlRG?=
 =?utf-8?B?dVprSmtZamxvZVhVUC9ES0g4MHNjOEZJRmpXSW9SY3dhV1QwZjBSVERoZFlL?=
 =?utf-8?B?UDBFOVhnTit1NDJ4NS9hc3o3cTVKVkRLeXVpQWNSTjR4TUdkRTRsa0tMMzhl?=
 =?utf-8?B?V1hWamlHakRUMEQxQ3ZTb0U1bFQreUlrQ0RTaFhvbS9lelZKRWl0M3VCL3hG?=
 =?utf-8?B?VzJnVy9WemJzNFBBSnh5Vzd5UUpFb2hhSGZoUVZpVEdjR3R0UFFNcitxSDFn?=
 =?utf-8?B?TW0vQWtid1pzRWpmNnZPOCt2bVFMQ29KN2k1S3pGTkdhWDNoSWNaMXZqbE5w?=
 =?utf-8?B?cjhHcWRHaktBSTNoaDZDbWV2TTBYbkNldG95ZW5oM2RKSEpiSmtxaEN6ZXow?=
 =?utf-8?B?c0c0NGJVOHB0QjQzcTZmSWZtQWNYSHRUTU5QWDVwcWhKUGFWOFZVeG9SWlBY?=
 =?utf-8?B?dFY3N05GM05pVTF2azNjMVo5NjJ5eFROOVJsbDNhZkNXZTlVVmllM3NITTZW?=
 =?utf-8?B?Y2xvelRRM3dnTExSYTFkNVUzOTZSKzh5TUhLcDR0UnhTRy91SXNFakZVNCtR?=
 =?utf-8?B?UStwdCtSdFVxOE5ZNWUwVTNHTFFKck1yM29QM0M5MmR3RFdhZDBDdGl0UkVt?=
 =?utf-8?B?K2VNY3MrYWVhSzN2V2tBT3NzY1lOVjJLMEVvYWw4bytyVkhqOXB0bUlQcE5v?=
 =?utf-8?B?bCs3THNlQllvY3pZOUVORnBBUGQ0YUU3dG5hc0tTOGduNjhMZWNtSXNZaUxi?=
 =?utf-8?B?eFlLMm1iNG5xd1RqamcyVzBhcXV0NnRwSmJodk41djhCYUUveHlZM0xNVVVN?=
 =?utf-8?B?RnNwNlVzRHltY0h2Yy9kTDBRemZNQjlFUi9QYkVoVWJobUxsR0pjdWd3ZWtx?=
 =?utf-8?B?M2dDSnlSTHBrZWFtZlc4dGFvaFd1Q3BSVVJFOUU5Tk1CTmZ6YlZQV01nK3l1?=
 =?utf-8?B?NFBGK0ZsOFFIT1cxOUppRllZRkxNZ2pKZHJkWTBjOGdIK2FLbjcyN1NWcUlP?=
 =?utf-8?B?eEt6TU5jdkxoeXVjcXh1emlhMXBVUE9yOEdnNyswdDVMaTh0M0llWGl5a1F1?=
 =?utf-8?B?TllTTUxnV0M1bHo1VHVDSEc5WTJQdmRYbzV6c0dUVDJqMjRqUEs0ejBHUnJN?=
 =?utf-8?B?L1VUbDBnOXB2STlSKzRBdGN4azVNVFdwMDRyZTl2ekxTRWY5ZGwyT3B3VGRX?=
 =?utf-8?B?M0FWUkhCTWpsSnIwTjNPRTBNSWtBdHZNVWVNWDlESmdmNVNkbjlJd2lmcnpK?=
 =?utf-8?B?OHZQVFpUR3B4ZFU0MHJ5ZStqdnhnN1ZLZDFlTGNlVUNPcXhuMzVzLzRCam9W?=
 =?utf-8?B?Y0lXQnZmRlh6V1FacFVYaXcwYkZCTi96ZCtubzhMQS84ajNueXJLdlB6eXBP?=
 =?utf-8?B?VXhMTFNQZTlWUlp3VVdUdVlkSjR4bFNEeW11YVZvMDNyQzdOcEJUbHgwRjZu?=
 =?utf-8?B?empMNjJ3UzViRlY0SW9NbWwzWFFMc3pac1BlYzFWbEZ1bUtLaGFLbUZKcEo3?=
 =?utf-8?B?TWFjdEwzWnlFT2U4SXV1c0tIYThYa1UxZWhQTjFJZkZ5R0FGVVIrK0xSTmpz?=
 =?utf-8?B?a0U3K2JTQUJWZnFOVXZJZVA4bTMxSkRzeUdEbjdkdmdla0M1RnBPMmtQU2Rl?=
 =?utf-8?B?LzVGMWZkMDd6Y3ZKWEovS3R3R1dIamxxRzcxT1c4MWUxQUZCanM1WnRBUWN1?=
 =?utf-8?B?aS85UjdwUCtCV2ZTaU5ab09rWVJvN1FxWU9PWVpoVmt1YjRxamY1YysyOTVw?=
 =?utf-8?B?dmhsS3Zyb3kwSVZSOUxMdVdEajR2ZCszS1U3Y1NPTStJZTVrOEZkRkxzK3d5?=
 =?utf-8?Q?caZOkv8nt5uPepyQ=3D?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1c674a-5791-45ba-505f-08df471f5cb5
X-MS-Exchange-CrossTenant-AuthSource: PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 16:00:13.8560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3M4ziUnKhTOR8fScvyUsDy+yKNwWVfi5xSIrvrfNUuvWA++nv/KqAgRJtiwTB1VPMc0ZslDiEvnHdDadjTZ3o7uII1NxmZVft4GS8hwCzvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAPP264MB7695
X-Mailman-Approved-At: Fri, 20 Nov 2026 18:44:47 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dear Tom,

On 20/11/2026 16:40, Tom Rini wrote:
> On Fri, Nov 20, 2026 at 04:36:26PM +0100, Paul HENRYS wrote:
>> Add an optional sign-size property to the pre-load entry type, allowing
>> users to sign only a leading portion of the image rather than the whole
>> thing. When set, only the first sign-size bytes are hashed and the
>> image_size field in the pre-load header is set accordingly.
>>
>> This modification is particularly useful when signing FIT images whose
>> data are stored externally to the FIT and hashes are already
>> calculated and stored in the FIT header.
>>
>> Assisted-by: Claude Sonnet 4.6
> Our AI policy is currently "Please don't", and I do owe and have been
> half drafting a longer write-up on that.
Does it mean, don't use AI or just don't add the prefix?
I saw some other commits with AI assisted information so I just added it 
as well.
I just pushed another patch after reading your message. I will also 
correct that there.
>
>> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
>> ---
>>   tools/binman/etype/pre_load.py                | 46 ++++++++++++++++---
>>   tools/binman/ftest.py                         | 41 +++++++++++++++++
>>   .../pre_load_ecdsa_sign_size_too_large.dts    | 23 ++++++++++
>>   .../pre_load_rsa_sign_size_too_large.dts      | 23 ++++++++++
>>   .../test/security/pre_load_sign_size.dts      | 23 ++++++++++
>>   5 files changed, 150 insertions(+), 6 deletions(-)
>>   create mode 100644 tools/binman/test/security/pre_load_ecdsa_sign_size_too_large.dts
>>   create mode 100644 tools/binman/test/security/pre_load_rsa_sign_size_too_large.dts
>>   create mode 100644 tools/binman/test/security/pre_load_sign_size.dts
>>
>> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
>> index 7890c1c62a8..3612307d4ab 100644
>> --- a/tools/binman/etype/pre_load.py
>> +++ b/tools/binman/etype/pre_load.py
>> @@ -53,6 +53,11 @@ class Entry_pre_load(Entry_collection):
>>           - key-name: Filename of the private key to sign
>>           - header-size: Total size of the header
>>           - version: Version of the header
>> +        - sign-size: Number of bytes of the image to sign (default: sign the
>> +          entire image). When set, only the first sign-size bytes are hashed
>> +          and the header image_size field is set to this value. This allows
>> +          the runtime verifier to authenticate a leading portion of the image
>> +          while ignoring any trailing data.
> Why does this comment need to be almost 5x as long as all of the others
> for this function? Thanks.
Here, that is a typical abuse of the AI which is much better than me at 
writing English but more prolix...
I missed that and will sum it up. Thx.
>
