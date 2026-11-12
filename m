Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3D9606A32E
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FOv7ZXla;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=diEB63ht
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 756F580AFB;
	Thu, 12 Nov 2026 16:02:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YITmoDDBgvaV; Thu, 12 Nov 2026 16:02:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5DB3380BB7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794499361;
	b=ice28Uh2bxJsc0jFBmFYlUqDN6g+myYbF6Y95mogWZo36JXmtKyGs404/WYnrqRuj6oo
	 eXuozS11CWexOjNvXTcD/JZy5hMoaha+M+92Uf34VGJCi5FhaVKD2uX+Ms6q0m7DrhAea
	 r9mSLYZbW1sTOdZL4M4Y1RL8rYA+CyPZKR/xxkuMZUuRc9MR9dS9cLSFCfIiO8kVK1g1f
	 I4/VJnFcKevjGkHCsAyDCWIqKXtYKdJL4rgZJ+GdnT1GsR09lzJgM19bsNodvfdZBzbyN
	 hqSG7i4iflMCz4Z3HNP6ShFn8R1A75hsbmzXii8Lozcw4nalJpJXSWrzqN6SBotDzOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794499361;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=0AvdD9KrWyIsZHUAk1rU/q7MCkPf2IkJaNSgsJfmk9E=;
	b=krBjTfzGYnFzs2fLb7WAEI9GfxdJ6Ia60wgAiJweIqV1ccIpm9qQKMAUqGlWgHXjGfTW
	 KMIOGJbC458bwZ5117LBisGHMLxtHuBC01UOfIHXYF+qGTRyVkZQdCpZ5BqpL2sgfrTIl
	 koqVvFB5JBm7a0lRQ2bzastJ+Zo2/LRDAo7vvPiizU0kzXoTwZ5vgpsg6apWCTwAr9hGM
	 TjNNXQ7XdlOmyMqmTtUw9/x4xhoIr6jl31rCV5iBWEpam7730CzCOCIhq8LBvzCKLrLWF
	 +l+BriCgDz07eipTBzmzKn9h8q+5DitqxMll0tc0pJKRmHj+ayMCScIabN8ZPsTCK9g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794499361;
	bh=0AvdD9KrWyIsZHUAk1rU/q7MCkPf2IkJaNSgsJfmk9E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FOv7ZXlaQafrYMrleoXsYN8LWnXD12AYV3+f4ZSce8MLpI8KjfhkEwQz+gPlSRUiY
	 5BgHb0+j276PA+6R5VS+mZY6oHpXVsJLcFZTyKIvKAA3PcJjOd4XurNE9pxys0vVrc
	 Cok1F7xm/I1nVNcN/9gnbrnqbKcTz0FIQfATM9c8wtPtQ4DinV3ITrqd/WH3CpBhxK
	 iPoOBoPMmwJsITZUN2KV1lF01sqGyR8FikJXIYRiQniEfH/PwE+AqQHplkCY8cz+Ih
	 VI+NiyA1eYaljJOPxS282/1+hNR47dOqGGc7sIWJYmC0j36EKU8CoPlAgc/nxkNkLr
	 ehOGsamF72wnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DB3380BB7;
	Thu, 12 Nov 2026 16:02:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 183902FE
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 16:02:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 13454401E2
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 16:02:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C6jPS0YclICi for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 16:02:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6977F400B0
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=diEB63ht
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6977F400B0
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 16:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AvdD9KrWyIsZHUAk1rU/q7MCkPf2IkJaNSgsJfmk9E=;
 b=diEB63htUVe6O8+80hbWkbRJg3NGITYXMgBdhUR83aCgFcCEdSKK/7A6qDLqZiuo+ZNja2+eE0Ewl4juyjDsLK6bnfwMvf6rev7TyYDltQIYIrnfEMfd5v5WvqrPDeJHlKI5biJib0iLp6c+zcRUpt6hwws4tXoDZb3tKHk5Rco=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS8PR04MB7895.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 16:02:32 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 16:02:32 +0000
Message-ID: <d4b06946-acb2-40a4-8e0b-eb9f2a50d484@cherry.de>
Date: Thu, 12 Nov 2026 17:02:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] doc: develop/sending_patches: add tips for series
To: Ralph Siemsen <ralph.siemsen@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, E Shattow <e@freeshell.de>
References: <20261106-doc-sending-patches-v3-1-86fa7d158cc2@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261106-doc-sending-patches-v3-1-86fa7d158cc2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VI1PR08CA0215.eurprd08.prod.outlook.com
 (2603:10a6:802:15::24) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS8PR04MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b35dbf-ba06-4b98-3241-08df40d65c31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|56012099006|261021130227099003|261022075727099003|261022105027099003|261026135527099003|261021133027099003|261022115727099003|261026121527099003|261026130827099003|261022113327099003|261026140227099003|261021135927099003|261021123027099003|261021121427099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003|4133799003;
X-Microsoft-Antispam-Message-Info: iDYUDxnXZQzXB8Xm1Cq8HKnxcjgA/FWWy5UPE6gSKnpVVdtBZ243X8IBguQiI7UkgpbhawTfO1V1QSC29qgox4iBSpd8QqieRmJG/Ym1vHSUm8xzK0LDSWZa8GvATQpMWmG1QEpQhe6fw9R4IOVCRbDVfRncrJnQk0OPBovnWFECKYQNBzE2K6iwENI/7+iVqyTCIduHHjbJkOxP6zh5nMIXW4eur0kssmZspBePW9MDPqEwdHLsTVo7mBoyKv8FuW8zwtPmE1dcuJokLDP1xZLRATOlkg+GJ1vlzBOkWWwX5naW9L8/grT/zWNja+W9QLSaKoeyFicXmILHN482qiMa6NvqGGM+DF/STVlQmx6Eav5krChrKzDdwIdtFIZ+5+h6UkfiUYo70+iYD8g7g7wMZh4sEHZqI9FdPv6OjSdVaymk7y21DhsL46mp1o/ejbNfxGRWZLZy8MrTO8Rs4SvDq9mrL/NklEoB+UugcGGQwRC/bU5KzkP3twStXhqaRSkYDz7XhPy4nWlL3j3Uv5MOfesdnTOBfiG+QhS7VghSHav/SNyJRIdcMPJ9DN1sz32iavxUkoRgJEmjIhA8ubHQRW2AE561sd+h6elNxDrtgl0Y20rIMXG4LWLvkSjh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(261021130227099003)(261022075727099003)(261022105027099003)(261026135527099003)(261021133027099003)(261022115727099003)(261026121527099003)(261026130827099003)(261022113327099003)(261026140227099003)(261021135927099003)(261021123027099003)(261021121427099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(4133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3g1NzJzYXBUTHNVdDFhRG55WEJKZFdSWm1waHczZDJ0MlZOVU53eEEwT2Mz?=
 =?utf-8?B?VHMwSEZENUJOY2w1SWJ4a1FLTzl5S1FxNHA0bEFHbzM2NmZ0SDQyQm4zam9w?=
 =?utf-8?B?VWhmbHBrQlMyMGYvMU9ja1VCUGtkMHRYdlA3cmVZZVRrZERoQXVOR3V4V0ky?=
 =?utf-8?B?Z0RNbWN0K1ZRZ0VwcFVqUFQzZlZLZGdmQ3ZJR2ZJb3dGdk5hTWtKT3AyNlFP?=
 =?utf-8?B?Y2tUcDZCMjhXTVBzYkhlbWR5NW5NalZtS2o0RkJ5VDBFWlREREdqbS9FNHMw?=
 =?utf-8?B?a3JJVTRtWnZNdmZjSWphWlhQV0tkNHZrNERZcURBUDJiUFh5NFM1ZnpCL0dH?=
 =?utf-8?B?eTA2ZzJNS2x0NndoSFllZ2swRktJUDdPSTBMRDkyWDMwd2p1ektuc0MrL3Qv?=
 =?utf-8?B?VDRlcTFma1lkZ1YvWjljZWs5SVN5OU5uREkreThvd1htTDMxanRiVWtyeHhO?=
 =?utf-8?B?SnlGZEYvQnY1dzBmanhvZXdzSm5PakYrZUFsM0FaN2lMS2Z5Z1o4bExCa3pX?=
 =?utf-8?B?bGw3a1lQcXJlclVHaTlTNVE4NzNXdElJTUtYVkJ5QmFNQU43MUZVcklNWitL?=
 =?utf-8?B?ZXpKemcxbHYwSFR6bENnRDNNdFdGUWlCSDZjRWFTMzlyS2YwV3hLd0tkTTM4?=
 =?utf-8?B?QlVRMFRkMEo0M2V6cVhNUWFvOXNMb09TY3JMaDE0bFFDSzlXY2NBQUlNY25W?=
 =?utf-8?B?S3lVQmNRNW03UTdOemQvK0plemV2K2w4dkR5R21JRmJJdFYwS3BFSzQvaXdG?=
 =?utf-8?B?VDZWMGIzWXRZSnExOTJVYnZVZmd6SXA4M2ZMVDJHRXhoVU9wOFpvbUs1S0Nj?=
 =?utf-8?B?SlFRWFpidEg2M3Q4TWJnVCtpL2c2ZkRWT1hTQVUveDJicHNKaGU5NmxuV3Ji?=
 =?utf-8?B?eXVZSEtVUFJ4bG5DMFcwS09PWGxXR21oajFXY3E4alZFUXpzZFZHNmZUVFJT?=
 =?utf-8?B?S2pueWZSdnc5VGcwNXZMVzVoczc4SG1VYkpuNXBEazU1UkFCZEdqamRTTFgz?=
 =?utf-8?B?SnJpOVU4ZFpFUDUvZHQwRW1xM2dVQ0l0ZWl4aEYyV2d0Y0pKV0IrZXppU2kr?=
 =?utf-8?B?K1NWZ2FTMWI1aG5GUzMvQ0c2Q2xzTnVFSkNSRnlERnNZRjNJVnNzZ0grQlV2?=
 =?utf-8?B?czZmb0xDUHdTbXpJMnB3cDg4UFliaXZ1TU1pQkJ1Y3ZNYUZIQWVkMU5jaUJt?=
 =?utf-8?B?SnB2K0NzM3VKdE1FZ2xKWnVlcGZ1dHhmQmJKekRnTEFsUjYxOUQ1MFJkYnVo?=
 =?utf-8?B?d0JLZEQ1cTVwbHdpbWFtRktyQTQxSDVja283S1VRcVBBcVlpZ0ZXdDY0K1kv?=
 =?utf-8?B?UUdwWE0xR1dzNGtQMWZYQTB6Y2RKNWgvT1N3T3JhRTRwaUVWQzVDVzQ2ME5z?=
 =?utf-8?B?RUtHaElseTRKVVFvanJDUktCU1VPQWVnM29WNzVpV1VNZjV5QXExalJLY2Va?=
 =?utf-8?B?NVpDbXlSTld0aVJoOUtYc0VFQ0tyVE9RelhCVlRsSDBUcXZHTmpRV2ptRDJZ?=
 =?utf-8?B?dEJ2OUhLWmlnYWFwVkFlZ1NoZUl4OFNuM2ZXeGlWVXJTbTBKcHhBaEVHMWtL?=
 =?utf-8?B?RWJRWG1TK2ZWRDN2UVk4Mzc5akFGZ1JxQ2VocWRaUHByeXRuK0xGcThaYlA2?=
 =?utf-8?B?MU0ramZSbVdpYmFJL2NKdTIrMmR0TXF2ajQzUER4SzFBQytCelRIdnlpc0dP?=
 =?utf-8?B?TUZybHdGV3pRd1lHT0VOUGtvcnhFTEF4REdlV3pKeVRFYm5EbWFlQzNiRCt2?=
 =?utf-8?B?c3NaZEdkMHNzR0dTbDBCSkE5Z3pxdzRmSEtaL1lMYWZxY1haRXAwNGwwbFhL?=
 =?utf-8?B?UytQWU5DbjFQeWVKdTI2NUplYzN3b1RBRUlDbWtzRjdOS1FIK3U3UldSWTY2?=
 =?utf-8?B?K0RMenVIY2NtWXY0YWxhSHc1Z2VpSm5tY1VPamJTZUFLVDQ2d3pvZU1qSldh?=
 =?utf-8?B?OUtoU1NJZ2I1cnhrQTgxN08vVGFycHdxWFRhVkpCNHBpcjlEVHh6bUtCMk9T?=
 =?utf-8?B?b0V6Q1UxY1ptK3JlRSt4MHIzTmdDdzhMRXlkVFNTQ1BySm8wMHk0MmowZ3ZX?=
 =?utf-8?B?V2RlVEtINDM1T3FvRFFlaXZxRGk2bUNLNFdhM3A4RUdQQVJ3NkpTMnQwKzdD?=
 =?utf-8?B?K2xISllJZHpFQ3lLaHNJZStOK1Q4VmdPZnB6NmFNZUY4Y2Y0SjZyRE4rUTVX?=
 =?utf-8?B?QzZnS2xGNUMyTnFCUzFaMVVZMUJNWUwxN0pEQllMNGVoR2h3V28xV0I1UUdI?=
 =?utf-8?B?RDhLeDl6Ull5K0F5NTBmUGxpSDNPcHVOQVNaRE9tVzJPaG4yVWZmdE9qYlVB?=
 =?utf-8?B?akNBTnNEVEkxNUJkQlJqcG96QzQweG4zbzFIUlFkdTFoaDJHbGFyZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b35dbf-ba06-4b98-3241-08df40d65c31
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 16:02:32.5651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4Tq9RdALoEzokVKsmuPZdVjH3mJgVqk8Gx3i56t6CpqjxxbRVVlIGlKwMmLaB0O6A04ZPx/KT8ZJ3QXiQiDdoiUzlFxDt27SyuwHVEPOa4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7895
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

Hi Ralph,

On 11/6/26 6:52 PM, Ralph Siemsen wrote:
> Related patches can be grouped into a "patch series". Add some tips on
> how to decide how much belongs into a "patch series".
> 
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> Reviewed-by: E Shattow <e@freeshell.de>
> --
> Changes for v3:
> - explicitly mention keeping bug fixes separate from other changes
> - focus on "keep it small" rather than the exceptions to that rule
> - Link to v2: https://patch.msgid.link/20261104-doc-sending-patches-v2-1-c0a90ff6c049@linaro.org
> 
> Changes for v2:
> - small wording changes to help non-native English speakers
> - add R-b
> 
> Link to v1:
> https://patch.msgid.link/20261028-doc-sending-patches-v1-1-66b0f1b276de@linaro.org
> 
> ---
>   doc/develop/sending_patches.rst | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
> index 99581dc0ba0..b6096cd346f 100644
> --- a/doc/develop/sending_patches.rst
> +++ b/doc/develop/sending_patches.rst
> @@ -184,6 +184,31 @@ General Patch Submission Rules
>     cases, you did something wrong if your patch exceeds this limit. Think again
>     if you should not split it into separate logical parts.
>   
> +Tips for creating patch series
> +------------------------------
> +
> +A series of related patches can be sent as a "patch series", as described
> +above. Individual patches should be small and self contained. Likewise,

question: should this be "self-contained"?

Not a native speaker, so don't know. I see we made the same choice in 
doc/CONTRIBUTE.rst so maybe it's fine how it's written here.

> +this also applies to each "patch series". Keep the following in mind:
> +
> +* large series are harder to review. Maintainers are busy and may postpone
> +  large reviews, whereas smaller reviews are more easily accommodated.
> +
> +* bug fixes should not be part of a larger series, so that the fixes can
> +  get reviewed and merged quickly.
> +
> +* tools like ``b4`` and ``patman`` send the entire patch series to all
> +  reviewers, even though individual reviews may only care about some parts.
> +  Filtering out the relevant parts takes time away from actual reviews.
> +
> +Therefore large series should be broken int smaller sub-series, for example by

typo: into

> +subsystem (clock, pinctrl, reset, etc.). This allows better targeting of only
> +the relevant reviewers for each sub-series. Finding the right granularity can
> +be difficult, but when in doubt, aim for smaller changes.
> +
> +Overall, the goal is to make changes easily understood by reviewers, as well
> +as the next person who works on the code.
> +

With the above fixed:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Is there anything we can/should add to doc/COPNTRIBUTE.rst which is 
where we expect most people to start documenting themselves on the process?

Thanks!
Quentin
