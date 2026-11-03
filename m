Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9A9606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 07:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XKPz/bYV;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vzjUsnUZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33D4B6060A;
	Tue,  3 Nov 2026 07:01:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v_UG7X-DvZvS; Tue,  3 Nov 2026 07:01:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6792D60642
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793689302;
	b=hq/Exd8W4Uf9eE3VStPHnbBK4KD92tLa2qrNUh9u9VLIpjtNX6jtUwR3AnqE3ZJOZNTE
	 kJd9te0zaCZTnkuKFKulV64+2C6/AOl4x/irLQNR1IJ73Q0/jWLR7WKx9zmi30kYED42/
	 XQ7fiqgYKKLx5RzdZdTeO7rOIeImkGUZNi3atCE045aOx6Eq3c0Z2IwKPzV4uHNMNVrRF
	 mMtzzkgEWh4irHNjpNCoxm09CQo/+h/5SKdaAcjopiGOu4eYY0F9a7GaVsG7eDu8XegH5
	 pj7+NNTDPs4WewhSb+mVN/p2ts5U3AVgeLUZUJ+FZUaywLCMm+KsA9lHeffUHN8YgHg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793689302;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 From:To:Cc:References:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	bh=qOGu+ZqW2A0AaIzMKyMFrUFCmyNaIQH6QvTfIZgVPBE=;
	b=WnMQrGDCVDmEo7kQV0cXhgNPpPmIMvlsbDla82L33B23Xg7NywX+ES2s7+JkEJyoOr7P
	 8XekrMU9h4Skwfc4gPtMgoqJZHEVgcf71aDfi40wZNSq1611dLmqFwuQQQAVpf50ks10p
	 q+jJaRBT9qt/b/z6ls4WYk+Goha8Z3NDkATMdCqELKtQpZL2RNmt5T+7CuPWbWVjuNsV2
	 P8wkRlHIt6uQLjQ16/uz1JpT4WNE2A+1GAbKPaHeNajLey33jnIK3xDOvhjQHoZXtxvL6
	 oA8Tuef52seTzo5iKSURcWdKg+SmkA+q++fAAJ6j0HmB4awfe5KQbEC2lGqHjAw7kfQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793689302;
	bh=qOGu+ZqW2A0AaIzMKyMFrUFCmyNaIQH6QvTfIZgVPBE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XKPz/bYVRKLNLFWGJeMDxr5UloXbenpzpSXxIsxF2PMpK7i3SskcN3BFr2T9G6GeU
	 NKzpL2aMk4DjxIZh5d+sr2sim1bDn9bqYqpjnNy/PBUU13Pkww7B4FDahyHPiZYPE5
	 07tOnOJEvnVfYjt4UIpkjXxFAkLWJ7kuIyJYEoaZFAG6r1onQUr2AGSiuHTtysFgOp
	 M9HJRFAGbmAUpIqlOPne0PPCKw7MeMosYncpUA5jKsQvX0D5lH68eAYIuebLw2xfYQ
	 ywUf+e9cZcDTboZQwOLdpO6CmGKG+yMqxRvJ4w0zIpaJ1VLv7aEfHYlup1CbNlA7hP
	 +4xcQwCPSRdyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6792D60642;
	Tue,  3 Nov 2026 07:01:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B7945411
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A803D40249
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:01:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WdWDwl3HeKYf for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 07:01:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EBC924009D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793689301;
 b=GTF5L6XrXad6vV/QbwdjTESIEotPZe6+2019Tx8eVeouVMI5ePmdo7Zy6zgK8XN3+8cj
 Bb8S2PXg034CEPCxjWTJAWRUpc/8ej7K6mKe3/a35guMQFajozTLiEv/2m4smMinFCYLv
 1t2M1utbLcLRXic5jqvIytKz2rKard5mXwsVIo6Qgc+A35r9UBRZnMrqF6Q/my8ElZrSW
 Hp3lb6gjbR4uR1VWroOAOxw2bLx0TX/vISNOm4HcMqs+QgRO6lhli4n8+nGNVW7r2kQPr
 TaislA++EJTXzObGBktgSbHM//bSgZGx3Sjgqi5OkIB2xCYOaCuDG1cHkP66/mck/ew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793689301;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:From:To:Cc:References:Content-Language:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=qOGu+ZqW2A0AaIzMKyMFrUFCmyNaIQH6QvTfIZgVPBE=;
 b=HUhedgbtq5YWF6Gpxr9HwmEhdY8Hm/ttR948d0PkFo8h15k6MY4imTetD5aDsxEmSkka
 S9LXHE5iiCcvwZVuii4rlplGKqnE6pyEx2jg55oY1PO3eiU1RzUNUUsymKfAf4nVZrYIy
 TYcWMHjximFFil4RN5+Q3aIQvGy7jErUCJxl5rRY70yFNZBanLwWSfYscM00asW2yAAdc
 0eY21t4UNKKmINW0IU0/88OTaGvOibBd05QECkkcaYkAaR4DJuWsaCHYFNHg9a7Sbf4VI
 pQjKv209bxY2ArCDxke1DC40ieDs0NBIcXXl15+vqVXNMRJDN5d+MsN0e37F506BYcQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=vzjUsnUZ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10d::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::3;
 helo=sn4pr0501cu005.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=vzjUsnUZ
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EBC924009D
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAdhqD/iRJxqpIQSmNbmqcQxkR27ZEQvKBWMEAyLq6+mxe2yXXCqZobpzNBAuM284IXQH43L8HtT3BgYzyW5LitAjFIJ1ETSrg1NSX7YqL8J921DstYQoaxz1aw67WEpE5B0BwFH1XI+u8UAdOK/0/iVPHccpRnLQ8utlIhZT5/6AWEqylwcD00YPV/h0EVwJ5tnRpzkl+g6AuwlgkJaoYfS5PKyYX+X6aODhqwcirdHdaTWUpwMa2XDUdAanpe+h8u8EU5RbfpbUryESqbnuzsdogriK0FCrZMOGR//TKCfDvxnOE0H/drAagdsEKMwqfy2nMQqEqqsf1hZ60wq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOGu+ZqW2A0AaIzMKyMFrUFCmyNaIQH6QvTfIZgVPBE=;
 b=d9J/rs8m0A6CFBrh0541CnFDH8LJOfy4KygbxZy1JnU3DIFVJ3Kty6tT3RjWygR3Xkcq1wCgdIggkIZz74QAIpvwlJdttNZkWt43UgDEckTnT5aDi3WnIGbxKEoZiWeBHjS0SsvZh1ZJHlcXxdJexNY9e5YE7m0RsddsTZE1hJT4Vzm9X9W2nqsNxGGjVK0PHbJY5KWtnTGRc1pGkK/pFZYeYcQxPiAwiWXuhbiaVuKEFr9YJENtDUeLszQk/82/MDxQKtCnFEjLhvDMnr8i/8a64wXg633EVQHaCqhLDLhK2zah7elnq6++ar9Lqt36CFfz5c57sAZ89R3VZK4RmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOGu+ZqW2A0AaIzMKyMFrUFCmyNaIQH6QvTfIZgVPBE=;
 b=vzjUsnUZzJeFr4mN1awnXG1hq+LUxa9cQRW6ojgIH1FeVl95SZzCEEsBgnqlv9Sv474dhDPkWwPLiz46LHG/9Ws6pT7feqGDkfsLujXdPjRmp2/qE92uPMFn8PmoflAM0YaNIpEijoriBI/cPUjvRCNvDM3a5WkhAe7gCrM967w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH3PR12MB347562.namprd12.prod.outlook.com (2603:10b6:610:367::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 07:01:35 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 07:01:35 +0000
Message-ID: <d1747a48-4c70-4614-bf04-b87caf03f925@amd.com>
Date: Tue, 3 Nov 2026 08:01:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] xilinx: mbv: Various updates
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Leo Liang <leo.liang@sifive.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>,
 Tim Ouyang <tim609@andestech.com>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>
References: <cover.1793002418.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <cover.1793002418.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::25) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH3PR12MB347562:EE_
X-MS-Office365-Filtering-Correlation-Id: 3761e751-19a3-481d-e8ac-08df39784cb4
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|261102123227099003|11063799006|261009223027099003|261028144727099003|261026140227099003|261021123027099003|56012099006|261021121427099003|261026121527099003|261022115727099003|261022075727099003|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Kc+22LaJNE4dd/nfiap935TiQT+J4QoZTBbF2Uc5TPKRyGDsref3Iq5vSvg/uPhHzv2gTSLFhMmeuKdZuo/uVnPjCOX+RVl4o2geLXJLxnDVeO0bz1Jdt3H9BKWwq+9+Afiv2c9PFSWe11Yu6mAwpjP0WMtRYcu5HPbOiLQkxXFnHIi1Q7MS+jwOqLFCYzIut5PFgy74GMNC/b3PhsT9f/YGgOEEH6b5FhDh5CfqR2hj7nyaUq4xW7eG4MPpmzSM34rE1sSxsHlipqw0ekgJWFUjZhde6q7IMGzkOLK08fh6UgWUN5zHxjLNDYm93cnCUk2ES1qXHBsQvEnZpoqtwVlsT67xH9NmY7KX0uR6Ipvt3CJ+AfLnTYhCHnCT/UE8PpU2toVFEwuVV6J9oQ9mFcsVylxlAJZ3KZ7hZRPtc0tHWv1D0oM3cY9JQ0k91jGBkRHhbmpnTkzGlmZlgqe9dD4dvQge08jXJv0uhlv6Z0HNy7wgh0ChQaxqBuW/aTRm0yiLLA/2uTZASysR04S/wYqe4v5+sx/FMxG5fSaPlEG23+QXbprwxqZtp5PzjNZZgBfw0nLsYkoP+crKV/4YeecDwwQKJ5q09MLsEh7Vl5ewkX+DUYoin8W7qdfw+K5mck2E4r3dt4/0Mx3PCfF/Su/52Q9M6Wbs4UsOefhvbDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(261102123227099003)(11063799006)(261009223027099003)(261028144727099003)(261026140227099003)(261021123027099003)(56012099006)(261021121427099003)(261026121527099003)(261022115727099003)(261022075727099003)(261022105027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlBUOHpiZW4vbGdmSlgwVXI3d0RTL1c3UWg1MW5jNEk3enkzQldDOFhXRSsr?=
 =?utf-8?B?Ymk2MnRHNkRibmdiQnoxNUxOUmVxRUJTcnNOdFNoV3RFSi9pdnhMV2llU2lu?=
 =?utf-8?B?TjJrUWd0RjI1cmpnV3l0MzVsUW1Oa05RMkR5WXBFNWtIdml1bzdhbkNSVmJ5?=
 =?utf-8?B?VnZpRWlpdjRUTmFyM2FSSFlFTGhTTitZWG5VWGd6TUkwc1l5aENjaHVoSU1I?=
 =?utf-8?B?NkJMTXdHdnlzVmc5YS9pUXhnZFZYS05RUVFSblFkb2hqUDZMWk11d3pNTzlw?=
 =?utf-8?B?bVg4dXRYVXFnOTdxZ2ppNGdRTVExRUloQ3U0RkRwKzBvVGhZc0lVTnZkeG9Y?=
 =?utf-8?B?MWNMbHpOc2tkTi9lLzhreFQrdXJMNGJ4MDRkNCtPU0lMWk02ekxzSXpqdGtJ?=
 =?utf-8?B?bmFyU3Z6Vjd3azlVTS9QK3F0ZEZzc1RMY3pyV3dRc0psaW9YVzA4eEFyV295?=
 =?utf-8?B?dWlUblZWWFM0TTNRT2tOWkFvOFBacDNCUlE3Y0VXdm4vR25BRkxsRmJQNTZT?=
 =?utf-8?B?OWVMT2V6K1QvK1FZOHpQSnhZRUxMN243UkxhVjdYWkhyME1Hd2Rhek05K1RZ?=
 =?utf-8?B?ZFpTbm82dEw5bVVBaUhCcFFCRFBCaTU2dmRBcnNjSC9PMHZtbWhJcGdjOEpE?=
 =?utf-8?B?ditGdkFDU0g4L1ArUXZMOXZrL1F0WW54TjRCUmdTWFhxTjRtUmxBblk1end2?=
 =?utf-8?B?K3IyUWRYdmpmV3oxQVl2cFNFQUNpQ1pKSHR0V2g1Q01VdW1OZEtYV3B1ZVBJ?=
 =?utf-8?B?b0NuSU5PQTBDYmVMSWVsa3loQ2w5dEJpN0RNNHhpZW5nS0MraDN0cENiRVY2?=
 =?utf-8?B?SjBxZWZETWMyWUdWSHc4WVZIdFZINFlnMVZEcS95WExXK1dvdURSUFlUSDMy?=
 =?utf-8?B?aGpiT2pjODdodUxEamxhMG8zeWk2TEtveEliTk9UdExLamQ4VkhwRnlBQS96?=
 =?utf-8?B?akhzQUlCMy9NWlhiajVCOEdwYVA0L0xLZnJmclRVSzBZajRnS1FFUStKK21I?=
 =?utf-8?B?RkptR04vekhlelRmRVNQbldWMkdhQ3FTck5takFnOUlBSG9YRXV4WTZpdk52?=
 =?utf-8?B?UUVCQ2YwK0FQWDErY2lzZGZpNXdGaTc2OWFWaVVUV3pLVEFTdWF5QklzdFFJ?=
 =?utf-8?B?SFVXc3AzRXNML1plUE50VW9uNXFUUk1mNlZWeG85SEJEVFJ0SVlZYTdOKzZY?=
 =?utf-8?B?TTR6d2dIVjN0YzBUQ2dRelo3T01jOWtKT0hSbWUzc20xYmQyM1FzQWFSMVY1?=
 =?utf-8?B?UzBPVURsLzBTZTB6OWxhUUJLdmRrV1hsMkhaa2VvTXZWZ1ZyMGxCU3FqaTk1?=
 =?utf-8?B?ZS9mOFFkTy9QVWZhb0swS3VHZlNkaHVjNFBYcUdaWWFlSklMTEhxKzFYMERQ?=
 =?utf-8?B?Q3FDRFJpcE9TWnE2RHp6RWhycGZqZnYwU1FyQ0dsbUVvMm9YdERjS29yVjRl?=
 =?utf-8?B?eEpYYXRtL2NxVDY1amFCOC9IQy8rVFZxRUdoZU9DaklSQWZkc2pxcGd4cS9S?=
 =?utf-8?B?SE03L2hRZlhxbldjQ2FnalBGczBGL1I4TzE5SWF0b3VjMkJoeTZyR3FPR3U0?=
 =?utf-8?B?dHFmckQ2Qks2R3Nlcm53MWpSUDdzQXprMU1qRHVDZEUyTk9DaDJvMzdIV1cv?=
 =?utf-8?B?SEhpK0JUbEZ2YVdjU3pKU2xsWmc1MmpiOEw1RGxMVGxwVGZVRlJKd1JHMEZv?=
 =?utf-8?B?aUorbTA1Yy9VYW5VMHFwa3ptcDQrazFYYlNrQXkvVjNEMVV0YU1qSzJiR0JH?=
 =?utf-8?B?ejRCQk91YW5FZ0xaQXkrM3laU1ZwZzd3RE1oZkQ5d3NuNmJvQm9wY05kd0lW?=
 =?utf-8?B?aE9yY09WeVAxTXUxeVpmVE9JTnYrajc4RDNjTUQzY1hxeUYxZzBnUFBXQWc3?=
 =?utf-8?B?eEVCKzFXU1BsYUZIVGpBSDQxcndoS3ZWbkJqdThwbGxhbEdzVCtFNitLa1Z2?=
 =?utf-8?B?Lzc5c2k1WXJzWVJSblhwaXV2UndXWkJZc3JKYWZlRkhDaWJ0MjMyVThJU3lq?=
 =?utf-8?B?S1BNQUxnTjlXSnRXNkdJOEp2N0tSUGhXMnRLWndEVzN4UXZNVWhEN0txMkNa?=
 =?utf-8?B?Mkg0UDViTy9XeUEzc0JnZ0V2QUI5WFB4QUE1NnhKbXIrTDN3akQwL1lBNUh4?=
 =?utf-8?B?NkxkcU5VUDZZRFVzVHpobWZPQVBUdkRWTk1scS9Nd0VpLzRHWFppNU5xR1J5?=
 =?utf-8?B?N245YWszVkMyVk9KS09EbTVoYVR6T0ZVZ3BNbDh0REZjTi9lSGJZK0JkUjFF?=
 =?utf-8?B?Rk1peERzZFg4NXdLZHBtNWkvWCthMXdGL0RRQVpvaGRWdElpaTZpd3NjL3RU?=
 =?utf-8?B?L1ZvQ0dPTm5vNGJSTkgrM045SXZXMDBVV0FoT2FmemxZbXVURVlyZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3761e751-19a3-481d-e8ac-08df39784cb4
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 07:01:35.6442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCqQkbD8/juwi7Z9+xu2fUAh5ePnDOBKWgKmajG32SvZQ5VyVPkCVHI8Bvt/5xyD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB347562
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/26/26 09:13, Michal Simek wrote:
> Hi,
> 
> I am sending various changes which lands in downstream repository
> based on tests which were done against the latest RTL.
> 
> Thanks,
> Michal
> 
> Changes in v2:
> - change subject and enable only ethernet because upstream QEMU has no
>    riscv internal timer enabled
> 
> Michal Simek (5):
>    riscv: dts: mbv: Update bootph-all in xilinx-mbv64 DT
>    xilinx: mbv: Enable GPIO driver and command
>    xilinx: mbv: Enable CMD_EXCEPTION
>    xilinx: mbv: Add support for using bigger boot images via bootm
>    xilinx: mbv: Enable MTD command by default
> 
> Padmarao Begari (4):
>    xilinx: mbv: Enable Ethernet support
>    xilinx: mbv: Update stack, heap, and OpenSBI memory
>    xilinx: mbv: Disable SPL raw image support
>    xilinx: mbv: Add SPI-related board config
> 
> Sandeep Gundlupet Raju (2):
>    riscv: dts: mbv: Update mem size to 2GB
>    xilinx: mbv: Add sys prompt for mbv32 and mbv64
> 
>   arch/riscv/dts/xilinx-mbv64.dts      |  8 +++++---
>   configs/xilinx_mbv32_defconfig       | 24 ++++++++++++++++++++----
>   configs/xilinx_mbv32_smode_defconfig |  2 +-
>   configs/xilinx_mbv64_defconfig       |  1 +
>   configs/xilinx_mbv64_smode_defconfig |  2 +-
>   configs/xilinx_mbv_spi.config        | 14 ++++++++++++++
>   6 files changed, 42 insertions(+), 9 deletions(-)
>   create mode 100644 configs/xilinx_mbv_spi.config
> 
> ---

Applied.
M
