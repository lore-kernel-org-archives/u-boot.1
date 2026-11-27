Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA7F606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=K+RwhIdH;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=Inn7tBkK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5ADA409AC;
	Fri, 27 Nov 2026 13:46:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jOOuiWJSjXKw; Fri, 27 Nov 2026 13:46:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 171E24095C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795787214;
	b=DEidNk+YmlwNee3/w24aeMFgXqAmssc48UF0mXtf5gG4z/F0jZiH9Y7QSax+yQdez25X
	 S2M/2Pnat/PojYkbnvZvvKiIGOHK1LnC74oI7xU4P0V59vLVsPlgdXpTiRBwFmZA/8SfZ
	 wOOuKkc/CSIJU4Ao5JZ2Ny+cWoEAlsE5DlJBU0hJWNeHwzWy0htkbcUYm8TBq+keBh0AW
	 fq2JDRXA6tbOnCCyiVYxUCyg5sZ1ska1S5g7vuppbz3NoJ6RXOpfoQ3dlytTCHL/45KTE
	 K0Vvf/Rdr9Ehg0dZlsouzsVSEy9FJDh0fFVUkutgrpTWYX2K+cr7LoKFVHtpS8YQ8Pw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795787214;
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
	bh=2iNG2p5GF/eGq5RkLTUcL9xF/kToBvpl8HrlYtMHx64=;
	b=NveaZXYu2jWdD9kgoo9tpeD1EPDcY4LStwejqyCNlZ4bjmJ7rBL6iHmkRXE+tIpZJZsZ
	 Z1RXkTRef21HywrhBRTDma93vqdWMr0zXTO9H/vdIb+ak565xCCymrPgWZlOOP+q3vpCy
	 DIzLuvs/XVuLE239Hp8q5wjTExH4t/HP0vhxwjlmN0E5n/1AyweK1l88K1UsbXNaZy6tT
	 gJQlArI+Nr9mDRaHwnc39mEdDYjsJf/S1EfLil2GFUTMoU+uXkvrcZDLxKYcZjGZU5iVV
	 JZb4dAQI9OFZgys8jTKGGDqlQTsXZdBEdxaeiCqw4ddqQzg/VZp1nf2mGeeWp+VJhkg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795787214;
	bh=2iNG2p5GF/eGq5RkLTUcL9xF/kToBvpl8HrlYtMHx64=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K+RwhIdH82e5a7uGTAITH622jqzV9yU18jf2LLhJ79E+Bm789fzr9n4QtYeaPO/va
	 f12JwIfBEk8+P+RaRA+pvPbimviH5P4rQUZdV/f6NTqvuhiBdIITOG+io+LD1MVqIg
	 Uc/AI8VgdqUg1k7pGfOUnEk1i8w710zAZ7bpcVuSKR5oaqz1oknAZf0rGAYY0mShS4
	 Z7TS+19CMZUU4SJLRa44pMbe3OqzhXmR3kDql8FULVH5mkJzS2LA7FeqrPHLC3HFIP
	 orufbEZ4JukuCh2dylbYlPwL5G0kwRFInn5Wf5n/C85WCkkTkVylTDCJS68YAe+VMF
	 3IKAxNQ1tHBng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 171E24095C;
	Fri, 27 Nov 2026 13:46:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 620C7311
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:46:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4859D60AB6
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:46:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HrcyLXggC8LG for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 13:46:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CB6C360AA5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Inn7tBkK
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB6C360AA5
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iNG2p5GF/eGq5RkLTUcL9xF/kToBvpl8HrlYtMHx64=;
 b=Inn7tBkKFIwpNHlt8UumNQcjsLVm+bPUWbpLycTbnFU8O6qz6PeApUWyLWsBQHN+f4VJD2NRC5D28r3b3wUUCNl+aL4nSeXl06qG0XSmg6kyiwQsk4izDDEQ//ZGkiA57CJzXrY09ZqYMhgi6e3cG6BIrq878ibYnJ/8OSxisWc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by MIWPR04MB915355.eurprd04.prod.outlook.com (2603:10a6:290:ed::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 13:46:45 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 13:46:45 +0000
Message-ID: <05416c2e-a62d-4bd2-af9f-094efbb3e7ef@cherry.de>
Date: Fri, 27 Nov 2026 14:46:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] ata: dwc_ahci: use the first PHY, ignoring
 phy-names
To: ricardo@pardini.net, u-boot@lists.u-boot-project.org,
 Kever Yang <kever.yang@rock-chips.com>, Eugen Hristev <ehristev@kernel.org>,
 Jon Lin <jon.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>
References: <20261127-rk3588-sata-fixes-v2027-01-v2-0-dbdf7770972a@pardini.net>
 <20261127-rk3588-sata-fixes-v2027-01-v2-1-dbdf7770972a@pardini.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261127-rk3588-sata-fixes-v2027-01-v2-1-dbdf7770972a@pardini.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0142.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:377::10) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|MIWPR04MB915355:EE_
X-MS-Office365-Filtering-Correlation-Id: b4204a26-847b-47b4-4044-08df4c8ce00f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: Ps1+M+lvfd/QqypsAsuF2mJQc71IfeTkyOmfcFIF2KLHCIXfwTNv3d3hdhFROUn94fWZs2t8MqaUcmAjekbXb10Gl265vfIBtJvpRqx/2p7MNRSF6LouCuuACvdCdnkbdusUh156PnlSp8BbcpB/a7WgntuEfWP2OAuBAVsLIw8hHB/Pm0roBEZgUj2QdYyUMJazqeHaxT1cz7V3W7MQsvXAj4nL2RVsSTNjDum/MM+EuU/HprfGIUqPDrTp+4qAMZ6GLOeb7EP4e/zTwq9cDDMV8wloODcxUajLFIZ6+Qu2sbj/QHVjqlyOI/gShK0IKR6T3qa6s9hDH2wqL0i2jjNRZn5GYXQeETvecPOLxPW7XiUM6pWbfLl9MwwF8k3gdUHletjXooJyOE4OF7+w4H3p2VQqWAd2P6Maq3p9Xa12ek19mcH+gIlAYWQGAdZuOErsqeaGsGq0SPyLrawQP72DLyQl437a8veMBSO3pjPKZN8h1EcKJ5KSngKgGgqukmDBTDas7LSXL+cb5qYNqlTcA1De8HOPwj2DU5oac05jJoG33wqRsarmlCDMBJrBkPK7/dAItT154xZ78eeP0OtSkhQHWcNERHePYdpSLk018DN+Z0MXc+1lHG1+20DdJ2G9/Vplu/kFSSrI4XhUEbaqXVx52leLt+rpW3wverY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(11063799006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUdWZFJCNWRLT0dGZjNvV1EyZmtUZkpxa09TMUtveUhJS09zQnErNVpRaUFy?=
 =?utf-8?B?SlJYMnNKK1BhVXo4cGd2bFY3ak4xbVZYdzAyZEc4dE9ZN3V4N0ZFTXAzcnV2?=
 =?utf-8?B?MHJWMW1iU2RlWklrbkFsVUxrM1dDUktTZmhuWVVxdEppWjRML2svM0dmbHVk?=
 =?utf-8?B?RkxjRXFMdHZqNEJJSSt1clJ2YXkzQTFMaEJCRHJKcEx3SFpOYmRFWmVuQlRO?=
 =?utf-8?B?MWg5Tmp5UEphTlB2SUlxNmhhNExwZW1ZbldEdjlVZlNlZkQ2SVluRFZMNXBG?=
 =?utf-8?B?MndZT3JWbEk5WERpSWkzVVVPVVd5TG50SU5uMzFiZzBWNXNBcGlFS3J4d2dM?=
 =?utf-8?B?YndhN0NYYVp2dVZzU3NaTXZNUjhrMS9kbUhKTUJ2b1F3bzIyakxham80ZmxK?=
 =?utf-8?B?MmNNcXJyamlrWUhIcWE1MVJ3ajh1QzBPQ3k4RkVjMjhqYlhrVjQyVGppNjVr?=
 =?utf-8?B?dk1OV3dhNVdQdDRtcjlNQ2ZpYmNmQlZ5c2dycjlBV1lUamJHQ3pDM1l3aFY5?=
 =?utf-8?B?L0owL0NFZG5tZHBNeTJhUmxSSE1RbGpGa0R6SGJVVktxY080di9UY3FtTzBV?=
 =?utf-8?B?Uk5rWkt3bDJuOWFkeXR6MS8vVDhVR1J5V3VRTWNrdHB4SHZpNWFOWkY1R1k2?=
 =?utf-8?B?MkVLQUhzT2hOU3cyRy9TM2d5UDg4Mlh1L0NmeUdJZlhlRGJOeUw4OUI1L3V5?=
 =?utf-8?B?UnBjZDNsUFlTREYzRWZKaVh1R1NvU3RmMnZtQnd1ZjdWT0pFb2ErZVQ2UHdv?=
 =?utf-8?B?bm1JZElsRGNqK3ZoRC9DNWtnT3lQczNjT2N1d2lhQWlMV1R2R2hIZ0hvbkRq?=
 =?utf-8?B?eDZLVWhKOGFYazAvSm5pQ2YzaXNMZzZNbEdaY2FtZE9NSnJYQjZWZjZvS0h4?=
 =?utf-8?B?cURGY1gvc1o5ZC9aaW5ndXdCWGM2ZzNxRklhMytJNUptL0pOSHlnYXIwazQw?=
 =?utf-8?B?N1hnY0NaWmVMRnBPRTFZY2NWL2F0cndiK3hmQjJsZFdOQnhSbHJkRFArUDJv?=
 =?utf-8?B?RVphUnVpZmZVUFVBNnRsRGk0RDFJdmc0alcvemU5ek5QRjgxdENpUmNGVGZa?=
 =?utf-8?B?L2xCUE4yT0doV1Q5NlpSNEFEZ01DVTMrb1ZHNCtPVzE2Nm9WdVhBeUNPRjUr?=
 =?utf-8?B?T2VRTXA1Vk9zSTAxdi90amtYeFpPTVRBQzZydVpqamt0T2t5OCs2ZGxhSU5n?=
 =?utf-8?B?UGFTUG5hVkVlYkM5Qkh2QWlzTFZYTm56YXVwYXFiS0pMM2tQRkJZbnRCR3pz?=
 =?utf-8?B?T2c0Q1BUY09yMW1MRnZOZEgydUdoTnlRTGJBZzlyOGxXcXE5ZHZjc2UyYVZZ?=
 =?utf-8?B?TkR2NzJSNjFzbnhSZCttdWN1SnhVZERudnpDS3V1NkVVNGcwRkJCbWhMRjUy?=
 =?utf-8?B?NjJpMlVBNURBanMrWlBqcVcxTzZEL3U4SzlRbG1uN2tSb0REaHNpSmx6YTl5?=
 =?utf-8?B?YVpRbW5EbzM5dkRNQWlKQnpaLzl4UDEvd1VxdE8vcEFpZU5kdy9KdzFCN1Vr?=
 =?utf-8?B?N0daRFJtOFFCNG92UUl6ODFvbW1kSjNETHF4K1QxT28yQ0lTWm5iakJNQUt6?=
 =?utf-8?B?L2gvMEtTajFIWkpsNFV5OXJnR2JPV3AyUmdnN0QyVzlUSW5oUE0zdzNUSkVh?=
 =?utf-8?B?UzB6ejdCOU43WENCaTVUOG9tZCtjcnJiS01XbVdGWnpCVGFxQVJVVWR1ZDM0?=
 =?utf-8?B?SFZjMUxLQjVoWlR5VU02K0VPOVpFK3VNS1IvSkNjbStCVWtJNzdBL0RLT0k2?=
 =?utf-8?B?QXFaWjBIYkR0dG1JcERQakFGQjdLOHZZU1ZUUGV0MytsbEhiRU9JaXoxaDZv?=
 =?utf-8?B?SFA4YjlqSTNjSVZNYkFrZzhTVnR3QnA0d0RzY3BsbGU2ZVlGNE0vVkgxVExN?=
 =?utf-8?B?MngzUytIRXExZXNnRzRLc05vMHhFYXU5Rnc5dHYzdkJ4amplYmw5aG1EazNw?=
 =?utf-8?B?RWNrOFhxamV2c1ZMOGlocDE0dTlIWXRGTmVKUktJNXBiUFVvVnRGV1laYWhk?=
 =?utf-8?B?citvVE96NjlvUWY5cm9IWW9sMkc1R1Z1K2k4SDBWNEpmRkVXck45YURjeU9Q?=
 =?utf-8?B?T2ZkYnRzRmhWR2dvNXFYZytndzVRaENJanJiTTJCWEs3ZnlibGxEMllvTWMz?=
 =?utf-8?B?dFNKMDFGMTd0STFSajZxQlFUa1ljQ2M3K0pFVXdUeCtiWG00UTEzMVM4Qit1?=
 =?utf-8?B?VVNpTmhMZjRLc24yMytUWUtBU2J2OEEvOWpDNFJuZHFsVUVCcngweXFScmVu?=
 =?utf-8?B?TUd5V01lMEJDdzk0N0luS2I2Z2JqVXFtNEpqdmMrM1RyM1l6ZktaSERiNG5v?=
 =?utf-8?B?SkphL0xybDAyZUkrWUhVVHgzK1FueFBEejRXYW9maS9IbHV5UGdaZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b4204a26-847b-47b4-4044-08df4c8ce00f
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:46:44.9671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIZXMN5SSEu95Fg+SnKQSQrJglp46kq++jgDfEB2nZhjh8X+QH3IzXeQTpCscrJq2JyViiDAtjnQcK+ipLCWUiFfH4hmnw3Twuo5DRJ0hvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR04MB915355
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

Hi Ricardo,

On 11/27/26 2:12 PM, Ricardo Pardini via B4 Relay wrote:
> [You don't often get email from devnull+ricardo.pardini.net@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Ricardo Pardini <ricardo@pardini.net>
> 
> Take the first PHY of the controller node instead of looking it up
> by the "sata-phy" name, like Linux's libahci_platform does. The
> binding allows a single PHY and phy-names is optional.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
