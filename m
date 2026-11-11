Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9468D606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 17:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sjP+0w0v;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=aQXCwVK/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFF8C6080C;
	Wed, 11 Nov 2026 17:25:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0PnbfCqe9kIx; Wed, 11 Nov 2026 17:25:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F30F9606E1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794417953;
	b=qw+Lhj+axeWNtvM15byhZPnWBJzrSjWUTtyA3DWfKrbuzghrtyoPpOGkR1ocuOsEXOgu
	 iVAlBSqdhLKRxHzjtYsBwXYE49lMV6euziJgChF66s1bybX+LeoDzYN5lIORm9Tj+5HW/
	 xCXvZSgePUReAIEqPlKlp5PnmhZZH7aBS4ISakidVdPclJNvh2w87niuE8U2xBqXX8PIb
	 qxKL1bpzKzcDYRYgMErz4AmWKC18DATkROioByLwwJupLS4U7atkQzvLcM4i3UwnRJVFb
	 U50r461xiKidqYNvZRTeTnzpIrRXqnUzFZq9DgDmtr3A2uH3Q4e8UTuWLNTTdHOFcDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794417953;
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
	bh=/FGMRzLvBLERk3annng9/NJkByxPav95r3XJthb1HLc=;
	b=dpZwR8zd5KZqFvkNpDcjQg0XrU1QaBLZzQ2xT9815UCLsJzoafjmaLONlawMKO4CrWFT
	 0dsRRrct2ijeWr0xBpWyyx/A2r8GpjPmH3ZGRYb38jq/sDq2F/PLcmeW59GUibDU45I2U
	 HtoBaClFO2aB0Y+DfkShp6yeX8HszzDwKQGt04yakaxrXp+kkYOF7GGoB7ABm7idCA2qA
	 8pjx0ykta09WUJilAw5VqeBZzLDiW4rcvw50cYJb49xwejrw6ktXlkcLwXJhBWHD1Airc
	 sqMD5egDUEXd3JuLLkDnvW8uEE8gqSg869lxdGCAY/jgrwyjcFfabwphlZSgUNM/Rjg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794417953;
	bh=/FGMRzLvBLERk3annng9/NJkByxPav95r3XJthb1HLc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sjP+0w0v9W7YrYGpUWj3Q4GwdUxWIkk5G/J3sKZlVLW/b1st+4GuB3+tFmNQxZ434
	 UyuC0kKB2DJjD5phfjrUwLeNJlhOLN0bYsD7x9UZth0CdLEG+ygKSgNl3npLQPjOHo
	 k/QEG1gCWBl5EQWgzfH7Z8ERd64ib7uhOpFG4BVD59C1L/TUECHUco8eq15fIq9dSd
	 GAKOrRsyQI8YAKaEycq4GyQdE038ueB8AcSCKE7jNk+hoPpH4yZSC9SKrbMLnjDqIB
	 xt622g8wXYcDq5tMfV2XpVsewZA/cnSiHxENFtDmE4082r+AhW2x5H9HlWHes+2wRP
	 tZTsT/ZmIi0ZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F30F9606E1;
	Wed, 11 Nov 2026 17:25:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D9F93F22
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 17:25:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BFB914006F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 17:25:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GJmk1w3KCsbA for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 17:25:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5761140060
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=aQXCwVK/
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5761140060
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 17:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FGMRzLvBLERk3annng9/NJkByxPav95r3XJthb1HLc=;
 b=aQXCwVK/sRua6TsLngth829yphObmnpxZ58LIx3kq7eGQuSB0dSKnjGf5veHgkwWrSxwNiHsGet+5HYkl6itE6lerlamvy5L9a1R1Wc6X6U1naSzuOOjeWU4gwzG8ufMlEumTtO+sH22AVMVsZu1TXmtNyMdUPhetFYjQGjXwgM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by MIWPR04MB292071.eurprd04.prod.outlook.com (2603:10a6:290:92::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 17:25:43 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 17:25:43 +0000
Message-ID: <bec21a40-fba8-47e0-80f5-819195e17064@cherry.de>
Date: Wed, 11 Nov 2026 18:25:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Add support for OpenSSL Provider API
To: Eddie Kovsky <ekovsky@redhat.com>
Cc: Tom Rini <trini@konsulko.com>, Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, a.fatoum@pengutronix.de,
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Johannes Schneider <johannes.schneider@leica-geosystems.com>,
 u-boot@lists.u-boot-project.org, Bastian <bst@pengutronix.de>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Jaipaul Cheernam <jaipaul.cheernam@est.tech>
References: <20261029201348.730274-1-ekovsky@redhat.com>
 <CAFLszTg9qSuGq9CHuQWBmGRqQVxT5yMbf267p+eNXNByFy61ng@mail.gmail.com>
 <auy8yuTSE4QQDR2l@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <auy8yuTSE4QQDR2l@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0147.eurprd07.prod.outlook.com
 (2603:10a6:802:16::34) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|MIWPR04MB292071:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d9fe52-350c-4ce6-a35a-08df4018d086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|18002099003|22082099003|10067099003|4143699003|261021121427099003|11063799006|261021123027099003|5023799004|261102123227099003|261022115727099003|261022113327099003|56012099006|261022075727099003|261026140227099003|261021130227099003|261022105027099003|261028144727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: Hc057whWPNF8hXuc5yMo5JbyJ6blIvdjdxDr1tRkPpGnXHZhQikBMhzCn5lO+jAVXxvtec7AVVd0uxs24xzKafXqq+p1UQaQOsh5g+vOSk1EUPyI2O8oPdk1FeRvSv+ZcRwJD6LAALgD9iXSbnAWb1/5IlHhM/hwArpH8GouegjXCIe7eST1sV9omGxy2cV7gShxKrob3I8zuq/Mw8vOXgC2xy4wwrdvqhGaYcp+qMfiE1tT8lYdIiiHWqGawrT9FByQbuaVb5WCmd4MIbE05MuyTBEOx1tAwV4n8UmgxPuAwKSqNOObRqwHgCJ3/s1jr3bq0nrWouBmZHGIwyWpWxbKs8FQWJ07xBUjt217Wn6ZrbY0utn37R2ak2Xz5+yAnds2VTQMrD0/W5t1Q7aXWmZH5LWeaF53u8uhF0/HF913PR9r0cTIdzzIV+GbstuG74FBA38bQs+56VKS97VTmsUdYH+VDC/lFoAMGWAyNhN8JpAvEzOCJB/8mMmW+82MwlSSq6Et46Bk23SHuO+I+hNUwLYjZZp6x8FxH9/0hBbPsEby+20b+oeqzkO0QUoB6C/78nEKiJHwJHcEzg880MDgjQuAKr9qIxmEjfYuAvqfwnTJ9t780L0uzZvAjV18oj8CebMSkfeWTDa7EeISxcHAdbCfPshKg7rHqnfKv5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(261021121427099003)(11063799006)(261021123027099003)(5023799004)(261102123227099003)(261022115727099003)(261022113327099003)(56012099006)(261022075727099003)(261026140227099003)(261021130227099003)(261022105027099003)(261028144727099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTh2T1lKS1J3VDVHc1lCWFlPSTFoRXdYWUhZM3hRUHd4NzlkdWpJOWR0T2Y0?=
 =?utf-8?B?bVJYNnVYWSttWVpsQTRpQnRUT05yMHhWTnhLQ3VtK0hyYWQxeFEwb3BYVHd2?=
 =?utf-8?B?blhxaTFhVnYxRnVxYkZzaGFySHIrY0xGWE9XQUo5OXBUM1ljTkUrSEFlN2t6?=
 =?utf-8?B?ZllzMzNnaVJMa2RhTmJER3Q1UndwQ1FvMFIzUjROVkNqNjdTWGhMU1dRRE9z?=
 =?utf-8?B?S2FSZlJHaSs5MTJIZVNHR256K3d0NU5Kc0NDYzRpMTFCZHhmQzJOcDdPZWNS?=
 =?utf-8?B?L05vc1lzWGxidHN1TkFVWjdZT3JGNWQvNkpZUnh5US9lU1ZvRXlYVDJEZXdW?=
 =?utf-8?B?VXRsWmJIemVuU25PaC9IN0Y3alFDb3Irdlk3NGVkeW9TbFlNSW5RTGdmbXMv?=
 =?utf-8?B?cUZoQWZpYnJEZ3NKTHlYbmUrNXdqUS9tbmkySE1UU2RyaU42bnVQVjRrc2cw?=
 =?utf-8?B?cWF0WU5Qdkh6K1F0OVhRNndjV3lkdk5nNXN0NE1yVTdNOFdhcDZrWjNCZUZs?=
 =?utf-8?B?ZTVvdzEzSWlNVFBYdzJJNUFJNFhGbTkyVmFvamJhbFJhbis4MkRUQ01DU0s2?=
 =?utf-8?B?bmNPelBqc1FoZ2k3TmJqZC8zQlJWa2tPS3VBazRKWWQyRUJybnV2dUxrcm5U?=
 =?utf-8?B?TFpHM1gvSXNqUEdsdlF4MjNKOHN2Snl1ZG9Uamcvdi9nT3RCaXJOOCtMWldF?=
 =?utf-8?B?NEhCeXhETFMzRkNJN0ZNR1o1RTFHWkVQeGMzdjlkenFHTk83S0R0dDY4bmd5?=
 =?utf-8?B?R1R5TlNpSWVNQjNOYVoxWnpyemd0eGtVQmpuUEFxSjV6RDZqMUVKdDhXZW5S?=
 =?utf-8?B?bGtHWkVhYkl0NlRENDVmOWQ0TzQ1TjZUNHFwYXJPS3lTV1RaMEFXN0VEMkFR?=
 =?utf-8?B?UE52R0lCTFdTblBrV25aaEhKdkJCc0MybDg4UkRYdnRWa0h4YWRmYVJodWtZ?=
 =?utf-8?B?L1B3d0wzOW83eitLSld6ZkloSjRUTnFRUnlxV0lFa2tFUDAzZC9ydFRCUnFF?=
 =?utf-8?B?QlBlakdHbnNDWWRzUEFGbGZrK3RrZFpOb2psR2RiRXFvVzlKTzVIQVp2SExa?=
 =?utf-8?B?VFdsRmd0RUo5NlRvckdITWZEL1VrVzlmek5JTEsrbmRvV0tKY0s3M2pKNVgw?=
 =?utf-8?B?NXdLUUpKY2FpVWtlVnZaMFVBakV6MFFoM0Y5NDVKQnAwdmYrQVk5UmRISUdY?=
 =?utf-8?B?SVhqMEtlQlFWVVlOTXA3N3FoKy8vYndLYlEvcDg2blN3aE9WQlVCS1FwQkZo?=
 =?utf-8?B?djB0QWN3RmFEWmhzdHF0YnFTNk1GNWU2Vnd2UENQT0cxSDRCb04vSVJMMlhr?=
 =?utf-8?B?WFhNYTl5WGRZZE9McFZXbTkrVlBTRWRVYWxUWXZDRWRzTEtWZEVzOEw0NGVK?=
 =?utf-8?B?SEF4ampsbHc2ZTV5clVDNmRXQWNMeFNoSWhFSzFtaGtCUWd2RGxYSS9WeEJT?=
 =?utf-8?B?ZW5xbnVXWHl0QXpJZytxNFZwOHJmRFdRZ0VHV2lORGovMlRoOXMvQnFXOUMy?=
 =?utf-8?B?c0s0MCttNXJqaE1sMm1palFyeXZBK240Vml6MTFOcGk0QXdCcDZjOVF2VFpE?=
 =?utf-8?B?TnF3aW14Z1RyRnp2bmMwYjJUZ0x1dkNFQkQxeTNaMmhTc1czN0taNnM1dUdM?=
 =?utf-8?B?Q1NINXJHczZuN0JOYjl6cTQ3QXFncVhOUXBQWmpaaW1DOUlrNklyUWlNOTA3?=
 =?utf-8?B?azdrTERwU3ZVWW56dTIrNmk5cU5MZ1d3RW5PQktFWUNRb2ZCc3BPajNUejNz?=
 =?utf-8?B?bmJpV1B1c1VFWDlKUFBZV1NSR1VQWmN4S3FUQmNZdnhIZ2N3aHRyTGtQZzQv?=
 =?utf-8?B?T1V2eTJEckRsbFptaS9xSjNJa0dwOVdicnZpKzZMSWJEVlMvSlJzQ0EvS0I0?=
 =?utf-8?B?emFQVkJHNzQ5bnFhTUoxRTRHVWMwZW1xOHU3TGZOdlR2TXFVajlJS3FZWFJ1?=
 =?utf-8?B?VHFndHBiNXJCNjN5RmJOSm0zYkxycEdkU2kyQ0I5YXJNb2o0Smw4dXBnSjZq?=
 =?utf-8?B?b3ZPT1R6ZUNoRXprSXBCT21YbW85REhtTE9aNmVZa25KSDdPM28vT01XUFFT?=
 =?utf-8?B?NitZcTlpTVhEWTNFYnkvcnhteU1nbStsMFFiMFZjZ1B2UHkrWm80dFVmNTdx?=
 =?utf-8?B?d3g0dzZUUnEyQWpUcXo2TldRY1YxdnVVUStkUUIxSHE0ZXQ3Z3laSTc2RTlF?=
 =?utf-8?B?UEs0cVNhRFg2RnRYaTYxMFRabm96Qmd6cjdKeWhUcmVIcHJEc1JmdXg2My9R?=
 =?utf-8?B?MmNqd0dxajlGWDlrSGpWcFBuT0VmNlQ0cm1va2hTQVpLa1hjcmVEbmV3MXhh?=
 =?utf-8?B?NUhmZklRUWk3Q2RrNC9XckRwMWltNDFTbWdIUFNVZzlITWZOa21XZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d9fe52-350c-4ce6-a35a-08df4018d086
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 17:25:43.3114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvVXQnxf+Um3+Grj2gbNU+H3Zcq4HL0OVDxvERrpQmjq9jfAYONOw9GG43v74Kuq9P8qsJMahXO7mEII9b4iUW3Gy9In1a2maLFSd+IW6DE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR04MB292071
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Eddie,

On 11/5/26 6:28 PM, Eddie Kovsky wrote:
> On 10/31/26, Simon Glass wrote:
>> Hi Eddie,
>>
>> On 2026-10-29T20:13:40+11:00, Eddie Kovsky <ekovsky@redhat.com> wrote:
>>
>>> This series adds support for the OpenSSL Provider API while continuing
>>> to support the existing Engine API on distros shipping older releases of
>>> OpenSSL. Build dependencies for local development and CI are also
>>> updated, while the final patch adds support for using hardware tokens
>>> with the Provider API.
>>
>> One thing I'd like to check before this series goes in. The provider
>> path does not accept the same command line as the engine path. -k must
>> be the full 'pkcs11:' URI, the key-name-hint is ignored and -N is
>> silently dropped (see my comments on patches 1 and 3). So the same
>> mkimage command works on one host and fails on another, depending on
>> the OpenSSL version. It would be worth keeping the existing command
>> line working with the provider if you can.
>>
> 
> I have not seen this happen when testing different versions of OpenSSL.
> I've been using the test suite to run the vboot tests, which drives
> mkimage. I've also been running mkimage directly to test hardware key
> signing and not seen any problems.
> 
>>> The changes have been tested with the FIT signature verification vboot
>>> tests on Fedora 44, Debian 13, and RHEL 8 with OpenSSL 1.1.1. All 37
>>> tests pass with both the legacy Engine library installed and with the
>>> Provider API.
>>
>> Just to check, none of the vboot tests use an engine or a pkcs11
>> token? If that's right, these 30-odd tests only cover the PEM-file
>> path, and nothing uses the pkcs11-provider package that the Dockerfile
>> change adds to CI. Since you already tested with SoftHSM, please can
>> you add a test which signs with a SoftHSM token? That would give the
>> CI package a purpose and would have caught the gap between patches 1
>> and 3.
> 
> The U-Boot documentation states that an easy way to test signing and
> verification is to use the vboot tests provided in the test suite. We
> did discover late in the review process that these tests do not exercise
> hardware key signing and that the existing pkcs11 uri parsing code was
> not available when using Providers. Without an actual hardware token I
> used SoftHSM to troubleshoot that issue.
> 
> However, I'm not certain it's viable to create an automated hardware
> token test (even using software emulation). Both the keys and token
> themselves generate unique identifiers. And the setup requires some user
> interaction which we may not be able to automate. I suspect those
> challenges are why we don't already have a hardware token test.
> 

We're currently abusing binman test suite to test mkimage signing, but 
we have actually already automated all this. Including with stable keys, 
and we verify the signature of the image generated by mkimage with 
SoftHSMv2 (engines currently, but I have tests for providers too). We 
should think about stopping to abuse the binman test suite for that and 
have this a proper mkimage test, since the midterm goal for binman is to 
have it in its own repo so other projects can use it. Then, it doesn't 
make sense to test mkimage produces valid images, we just need to make 
sure we call mkimage with the expected arguments and mock the rest. This 
is for later though, and we can still abuse the test suite for now so 
that things are properly tested in CI. Did we automate it incorrectly? 
Is there something we can improve? Is there anything preventing you from 
doing the same thing we've done with OpenSSL engines, but for providers, 
with SoftHSMv2?

Cheers,
Quentin
