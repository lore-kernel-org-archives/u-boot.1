Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E3B606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rzOTTbSy;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=Th+8HI2/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5F9E80D1D;
	Mon, 16 Nov 2026 16:03:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 17tMHvGdu-J5; Mon, 16 Nov 2026 16:03:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6730F80BD1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794845005;
	b=G4Dtk04jTLxq7FS/OuohnWmpqXtzN0IieyRlpqhhi5HXPgXnwSl3nT/K/ato39wRoPH8
	 eWuDolG9JOhdytJClfyF9aa6lFNrSUpzlhONQsRY2LymssHI7YMLtn9jH8QTdxoIDy3GY
	 CVFDMidIQ1rDTIZhf7nEbwKOp8w6alAa6FO5e/0fVghRXshCTpUNuXJFLgZXnWhQKl1xB
	 0SBgAeU29bAsCf//ajxErK3VMiXmn3vQrJ0zLwCWd9WD4k4JNXAd6pALd5eeFw/ycqQsv
	 JAW7tz/XsnBNXVrIaJnw0LpjA2Us95qZAFUvvqMrpSsMVKLGSlWqGY8EiP9m5LSk72Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794845005;
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
	bh=0Hy2qLn263gruyohcEQ1FCWMasTO9CdTyMTUzCadea0=;
	b=ltsYFuRscLZrjT7tqW7UDHaj+9+KbrmdPQwZZQ69fynIvbzQS3aVzNchwbjlN0brvARU
	 5iQf5nASLkEX0WZPGSMpzbHhdFzKEVahjnZOTfyXetYgIdKLer3wIrhiTEpT17LyQoSQB
	 /CdYvvdUKRGWWF05wCohKkd1eUGXedVcn2oPIkUrO6c+bYjprRODPtp8emwgfg5ZM3hIh
	 nu0kEZef9eJ8YeA3pst3WBma2Hrvao9HsZoHIrlVAfptqpqOinG1TmXPL30SWIZnyhR/g
	 abghR3yQzaS9P+Kt764lj4cVI3kpt0YEuBE6+Q4Y4vfbyy/pECDenFVoTDIqju8rZpg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b="Th+8HI2/";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794845005;
	bh=0Hy2qLn263gruyohcEQ1FCWMasTO9CdTyMTUzCadea0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rzOTTbSy/sRr7AhtgwIZjsJlqGUhoheyjn4H4WBiK8JkGxLhzaG2LTT173+AEmbYn
	 8YAX0a7BZA/W0YwXlYk+H06JhPZ7uWYjiMA/+7kuodn5tH5Xsep8WqeNAH6mpy3bBu
	 Lf08ZkoMQDOH4tSRszsb38aEFOl+QNc6Pe4IzqT8xo21ybnIQ7nb0hfJVDuDeWC7IT
	 QHL4gnEcdzBqCkpucfksZZ0mK9kxH81Czvd+/f31KhFwBk+kDn43T/QjgtDOqx5z4o
	 4vs7UmJkCO4QLYKNvK7GspKh1NKTO07DiTO2bPkzf3cCnj/EPLTovG/UZ6zyH1EcE2
	 SBZW0vYZM3P6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6730F80BD1;
	Mon, 16 Nov 2026 16:03:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EA2CB2FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CAB1380BD1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:03:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uz6qe1beQVSK for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:03:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 641C780AF3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Th+8HI2/
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 641C780AF3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Hy2qLn263gruyohcEQ1FCWMasTO9CdTyMTUzCadea0=;
 b=Th+8HI2/IshDuAAMgDEXTnpVOhrqphuPPS2EU4S4n+5Je/HJ2OD0pV4t57IOacQWY0VNg39YSIu5GxxgDzu4LjlQxBWuZgNCB5QEDEt3/uEzfOoLc8P84yIUOXrmRnrBoCOgouB9kd2PNXusYVAvNrAW7sN8LfreSeHlcNXE79s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM8PR04MB7938.eurprd04.prod.outlook.com (2603:10a6:20b:24e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Mon, 16 Nov
 2026 16:03:17 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 16:03:17 +0000
Message-ID: <1291acc0-53b6-4553-a357-29040e427df0@cherry.de>
Date: Mon, 16 Nov 2026 17:03:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Five memory-safety issues in U-Boot filesystem/partition parsing
 (coordinated disclosure)
To: Dilip <dilipchowdary21@gmail.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Cc: "trini@konsulko.com" <trini@konsulko.com>,
 "joaomarcos.costa@bootlin.com" <joaomarcos.costa@bootlin.com>,
 "richard.genoud@bootlin.com" <richard.genoud@bootlin.com>,
 "alchark@flipper.net" <alchark@flipper.net>,
 "sjg@chromium.org" <sjg@chromium.org>, "kabel@kernel.org"
 <kabel@kernel.org>, "wqu@suse.com" <wqu@suse.com>
References: <CAPmzV5kAUpHf5fGDHmQXnyDJxs=Kvgtks2ztva88pG2wj7m9qA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAPmzV5kAUpHf5fGDHmQXnyDJxs=Kvgtks2ztva88pG2wj7m9qA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0086.eurprd04.prod.outlook.com
 (2603:10a6:803:64::21) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM8PR04MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a91cd02-11b9-4eb8-46d3-08df43fb205f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|6133799003|3023799007|56012099006|11063799006|261022105027099003|261022075727099003|261022115727099003|261021123027099003|261102123227099003|261009223027099003|261021121427099003|261028144727099003|261026121527099003|261021130227099003|261022113327099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info: hh10J6lqvnOlL2jHSzZbnqFlAk6wybsk6VmvBLX7llhUURmSHuv/EKYvAR1luEeiL2tr6WdeM5xqNUuPOe2CPzCEYctIfBJ5n7KYkUC6AMr8MULpMw7qfvNr4Q1/scnz4sW2eXjElfI71xXF0TxoDpq6k1h6+wS/+k/Bxa9Ih0cGVAFTva0Rnba5KdXFwqSzc6hTfMt9kOB/lssxlMvjxJ2oh0tLxWUliKiyl2/mx0QBqtRQeGexcZa9kgTJGmlL982PXNM+0C1WYfxhQe8B7pggklNUPQHGV7/TTWEbewKSnRthEzwbdvm3u1Psq5HibrQGPg+vkLk+tQBcZGcBQqGrQYH06V74zvpr30Wi+YaZMgJYjpdUBrzrL4+BKJO5Ko+QQwx/tJrEFDnRJqbYf2hIY8vCrdM4cT6zjMoxeqTMSQ2UmzMD9aoEtqAiBELic2ub3e4EWn/OwPkN8nwh+nbsk1gVGVyCRL/4MJTIXbDzJb5RyHlHWdJ8qC3lTBrz6SV7ybaWC7e8EoXWcC2/gRIQZYBkLj7T953zRkbtoQaIDnkGSUSZtO5nVIWQgzrP8hl/x7/17+hPAJYTgZIvuhsN1uI1Rmxxt+v0wasg7jvp4N+9qqQ4oq5mRlPamtQ6CAmGIecBQTIFy0FPN4mkRtdYXUSxOgNwiv4X2ISfR+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(3023799007)(56012099006)(11063799006)(261022105027099003)(261022075727099003)(261022115727099003)(261021123027099003)(261102123227099003)(261009223027099003)(261021121427099003)(261028144727099003)(261026121527099003)(261021130227099003)(261022113327099003)(261026140227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDBleDkxN2xCMnQ5TmkwK0RSc1BLbFQxVm1TSDhWTXdUMGltVGNtM3lRTXBp?=
 =?utf-8?B?Y015SUxPdUNZUlhENHJKK2EvQnVCZDBaR01BM2c2Zk1Lb2UvbVdKWWxTbEdO?=
 =?utf-8?B?bGZzTzhsMlNMcmRNZlRZTUdWU0Myb2VpVTcxc2RLSHJxNDRzSGxlMktXa0Rq?=
 =?utf-8?B?bE9ITVpzRnZGT0NuT2hPdHZlczRzbC9tOGI0VUNKU25nYjcwc2UrSGlJYTRs?=
 =?utf-8?B?N01IZXlUeTllRXBpTFVsdXRJWjFqa3ZwRUVZSHFZVGMrTnFoSm1NNUtMY1BM?=
 =?utf-8?B?T05KK3p5NTA3c2Y5RVF4bGJtZHQ3dXFWY2hkZUpxTkpseE9DelRoNFZRYXNN?=
 =?utf-8?B?SEZLdDB5TFVuSVc0ODVGRlRCeFdaT1FtQjlYTlRYUVBqWHhSSy81dDZiL1Yy?=
 =?utf-8?B?OHl6bzdPbFR2NXVLbW9iUDdmNHJlaS9RdkxhV1lDYVYzOUQ2emlUR2JhZkdz?=
 =?utf-8?B?clpiMFR1SUFCMTNsTTltbHg3NW8yZ1hIVjU5aTJpOEhGcUNrNWx6QndTanRS?=
 =?utf-8?B?OUJQTTdmTXdrTUdnelhzZnZzY0wzUC9oeTU4RSttZGN4K09ERWgyRWZWVmcz?=
 =?utf-8?B?RG5yOURXTG1pUWZ5QlJrcXFjTmZpVUduVU56bzRZQldTaXZJeHMrOU5BSmZL?=
 =?utf-8?B?YUczK2IrbDJJQ3pzRy90VXh3U0NITGlEb3dHS0c1K2ZMdDd4VDZ0dllmSDc3?=
 =?utf-8?B?dVpBY2kzSW5kNC9pS0hwKzVIakFvQXFnMmllU3RyVytBdzdEVndFRW9oclB3?=
 =?utf-8?B?NENySUMvdXR2a0Y0WFd1V3hEd0N3ZWEvZ0FVNDJHaGxQV0xmWGZiZlZCZkRs?=
 =?utf-8?B?aVBKTDlEOXJ1Vmo4TkpRVWlibTEyejZ3bDIrZWpicEV1aUFJeWJiZU5jWlhz?=
 =?utf-8?B?ODQ0ZHQwVHVZMTZjZ2pUMjVEdVc0RmlEa1ovWUh4Zll6ditpR0FtMG5RdTN3?=
 =?utf-8?B?L0N3L2hGWVdZcWZ0Z1YzWXZMeTZaU3FabHBBNzg4Sk9rVzhXL3hGUnRaeW1q?=
 =?utf-8?B?V1cxbDVld2JNNGQ2UXdzUDZVcHRRNkh0c3NRTkUycWk0VDZKNElLOTcxTDRp?=
 =?utf-8?B?dzcvWjZWZENIZkU0V05VdHVWcGRJVWZYQzZ6YnM3QXBZRnFqT2JiNXFNN1NI?=
 =?utf-8?B?RHVqVUNLZTkwdmoydXBNVkg0VE1lTzR2QnlReldvM0hEcFkwOHhOMXBFL0t5?=
 =?utf-8?B?anFzM054VDR3bGZOMDlnZzhydzMweklhc0JyZjhidDdEVVhENlpic1RFcDRh?=
 =?utf-8?B?c2RDTThvak5DUjE3VXZtV2pkUWVHdVJZYWRRTHJvL3RLMmNNY2hyVTBVaUZU?=
 =?utf-8?B?MGo1NHlHaVFOTysvVUZqYVk0ZGdPRGt0VmgvSU5GeUY1NnZIZ2Q3NXRhRjNO?=
 =?utf-8?B?WmplelNHR0xGZ1FIZ2sxbVR0QUM3a0hlcXpVMDVsTCtNbXFKYmxaTWFpdUJr?=
 =?utf-8?B?UW9mS21xdlh6NWkzVVo3cW5qU255cDNvU2ZiMW5YRnM1cld3UXVOV3R5N0wx?=
 =?utf-8?B?RlpWcys4THQvQzZIVWs5Y2V5dmFPRWoyMUpjSmVsL0Z4WGNqdjI4VXpsdzBQ?=
 =?utf-8?B?aUZKd1prODFWaEJiNHlxc1Y4ZENvc0VFdCtNeGxsM0VrdzV4UGJXYmhndlk4?=
 =?utf-8?B?S3ZRdExpNU8yTmJ2ZGFNN2hTTG4xaU03S3AvcHMwMXhlNXduKzVRbVZ5Nngy?=
 =?utf-8?B?TTBmUlRsMlM3ZDljS2tua0J6T01GTDlXK3UrQUludlZOTjMrRmlZb08yaE1q?=
 =?utf-8?B?VGZPY3hnVmc4dy82L0VHWTFXU29tRjNldnFkN1QwbUVrWkZ5YzB2dWVlUjBk?=
 =?utf-8?B?dGVLS0pmcVZrT2JGa2R3MFgvYVVhaFZ2eVNZbTBOMGZ5bno2SG1ZVHRUSzgy?=
 =?utf-8?B?bnRYcHprZnBHQmVTc1ZjdVkyZWQ5TUl2UDJlZmtuOEIyQzYyMEtsZXNZdWxy?=
 =?utf-8?B?cEVlNUtrM0NjbEdsdG0vYlZsWDlUZ1lsc0VzbkYyMWFnckc2b1NOS1FIWG5n?=
 =?utf-8?B?UUYzSmQ4anJ4NzZPV2VSZFo4T0FncjhvVElXMGJwM0JLaGdvTzROdGJEcEpp?=
 =?utf-8?B?eGVpTFUyelF1QmJaQmVPZlJ1M2lZTWNZZGJqVFR5Zm9OVVdzaDUxeTdwd2RW?=
 =?utf-8?B?VGdzNFJvVEpNd2d2U2Q5TTQ1SCtYMEkwemQ5RjZZaHAzZ2FwYllhRXcxL1VX?=
 =?utf-8?B?TnBKUXl4eXFKL2ZlNzZWQVJTMm93ZjdyUEIxTmtZdEZvYVY5cklFSWd1Vkhj?=
 =?utf-8?B?Sko4QnVZS1VoYWcvUkRWYkRBSHhiQzVaN0xzU0hxOWYrdkZ2bnFGUGNnN0VC?=
 =?utf-8?B?UjQ0UTIwN011eDZiWEt6SlJuNXVYbXpWMGp6WHNDdllSYUVGeEpNdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a91cd02-11b9-4eb8-46d3-08df43fb205f
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 16:03:17.1165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSoqtRvZQcCU/E0RPR6nSU9EWfo/3HtAmTDHjC5M8f/lSWh3eJnW+LEwaaPvy2OaqUpSuI6W9mWLlgjU/j6yEfdCW3c3T1cm39V4Hej9qME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7938
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

Hi Dilip,

On 11/16/26 7:54 AM, Dilip wrote:
> 	
> You don't often get email from dilipchowdary21@gmail.com. Learn why this is
> important <https://aka.ms/LearnAboutSenderIdentification>
> 	
> 
> Hi U-Boot Team,
> 
> Thanks for all the work you've put into hardening U-Boot's image parsing, the
> 2026 squashfs/disk crafted-image series was great to see, and it's what prompted
> me to take a closer look in the same spirit.
> 
> I'd like to report five independent memory-safety issues, all in the same threat
> model as that series: U-Boot parsing an attacker-controlled filesystem image or
> partition table from untrusted media (USB/SD/eMMC/partition, and for some, a
> netboot-fetched image). I found them by source review of master v2027.01-rc2
> (commit ff8a9bc4), and each comes with a minimal, self-contained proof-of-concept.
> 
> Reachability for all five is an everyday operation on attached media, `ls`,
> `load`, `part list`, `cramfsls`, `btrsubvol`, or distro-boot scanning,  with no
> signature verification anywhere in the path.
> 
> Here's the short version of each:
> 
> 1. squashfs: out-of-bounds free() in symlink path resolution (CWE-590)
>      fs/squashfs/sqfs.c : sqfs_clean_base_path()
>      A symlink whose target has more ".." components than its path depth drives
>      free(base[i]) with i negative,  a wild free of heap pointers before the
>      base_tokens[] array. The `if (bc < 0)` guard only runs after the frees.
>      PoC: ASAN heap-buffer-overflow at free(base[-1]). Trigger: /s -> ../x
> 
> 2. GPT:  integer overflow in partition-entry-array allocation (CWE-190 → 125)
>      disk/part_efi.c : alloc_read_gpt_entries() / part_print_efi()
>      count = num_partition_entries * sizeof_partition_entry is computed in 32-bit
>      and wraps (even on 64-bit), under-allocating the PTE buffer, while
>      part_print_efi() iterates the full unbounded num_partition_entries,  heap OOB
>      read + partition-name info leak. PoC: ASAN, 512-byte buffer vs 33.5M-entry loop.
> 
> 3. GPT: unbounded header_size drives OOB CRC read (CWE-125)
>      disk/part_efi.c : validate_gpt_header()
>      efi_crc32(gpt_h, header_size) runs on a one-block buffer, but header_size is an
>      attacker-controlled le32 with no bound (Linux rejects header_size >
> block_size),
>    a multi-GB OOB read before the CRC check. PoC: ASAN read past the 512-byte block.
> 
> 4. cramfs:  heap overflow in symlink/data decompression (CWE-787)
>      fs/cramfs/uncompress.c : cramfs_uncompress_block() (+ cramfs_uncompress_link)
>      avail_out is a fixed 8192, unrelated to the malloc(size+1) destination sized
> from
>      the inode's declared size; a crafted block inflating beyond `size` overflows the
>      heap buffer with attacker-controlled content. Present since 2003.
>      PoC: guard-page SIGSEGV at the allocation boundary. Trigger: cramfsls over a
>      directory with a symlink.
> 
> 5. btrfs:  heap overflow in subvolume path resolution (CWE-787 / 120)
>      fs/btrfs/subvolume.c : get_path_in_subvol() / list_one_subvol()
>      strncat(path_ret, tmp, PATH_MAX) accumulates the path across the on-disk ref
>      chain with no total-length bound (strncat's size arg bounds the source, not the
>      dest) and no depth/cycle limit.  PATH_MAX buffer overflow via deep or cyclic ref
>      chains. PoC: ASAN heap-buffer-overflow WRITE once the path crosses PATH_MAX.
>      Trigger: btrsubvol on a crafted image.
> 
> I've attached a full advisory for each one with the exact root cause,
> reachability, PoC output, and a suggested minimal fix. The PoC sources are self-
> contained,  build with `gcc -fsanitize=address`. I'm also happy to send the
> fixes as `git format-patch` against master if that's easier for you.
> 
> Attachments:
>     advisory_uboot_squashfs_symlink_oob_free.md  + sqfs_poc.c, evil.sqfs
>     advisory_uboot_gpt_oob.md                     + gpt_poc.c, gpt_hdr_poc.c
>     advisory_uboot_cramfs_heap_overflow.md        + cramfs_poc.c
>     advisory_uboot_btrfs_path_overflow.md         + btrfs_poc.c
> 
> I understand U-Boot discloses on the public list by default and that the project
> doesn't enter embargoes, so I'm sending this openly. I'll request CVE IDs from
> MITRE myself (one per distinct root cause) rather than ask the project to assign
> them. I'm happy to send the fixes as a git format-patch series against master
> and to help with review, just let me know what's most useful on your end.
> 

Don't ask permissions to send patches for bug fixes, just send them. 
Unrelated patches need to be sent in separate patch series. From the 
above description, all are separate (except maybe 2+3). Please consider 
reporting on your use of LLMs for the patches (I don't think we care 
which one was used). No use of an LLM doesn't need to be specified as 
that's the assumed default (for now anyway).

Cheers,
Quentin
