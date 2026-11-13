Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E10C606A33D
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AwjEgj0E;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=QfPwyHO0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DE4D40E28;
	Fri, 13 Nov 2026 18:51:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wue_eEN-FWd0; Fri, 13 Nov 2026 18:51:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9615640E1D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794595873;
	b=dWLWFrM/qGwPcruFU8/tYYFO90btV7XYfhS24ZzDDa2LhsGafKVyYfIJ64RkXlwrihbL
	 X+/W0ES/oRoo84sDuNxQ7Zu+TtAA8QCK9F5lINxs8ITiUKILZtit3H7ipmWuY2zqYn6kr
	 U9n7uS8XH2JLGHRfZWIIVs5vPHA8oULE3zxx+sWjVfJcR4lbLjPCLjDV3p6vSkFckqIVP
	 j/AXHgrDn+8htMRYigNSXsCIlxRmmSAejeVyOjm9fqhmU6KVziYEP/cSNYUrWYpjgcf2v
	 R3i8P1H/p+Tm0FqzplStu50tV2us3DD/BVBYsLB1odQbJPvTG3dnRnUlmfVeZMsE6FQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794595873;
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
	bh=6/ktnGnY/mRYwWJ9Ya+j+jxNM0OvCdzSIpo0DPl5eNo=;
	b=qhIJW4NNTum93lxvcuC5MjGf0adJRLReLNaDa/XGB5qVuN4mE5kg6fEG5laKlkVd+s+/
	 Wo6ainlSeJO8jGI8zt7PYXBdkzARMtPm5ybpl7P1MIqUtheILa27MTAwqHJF5h0jXYclN
	 YE9+euy5FwZ60Tm9Nfx1S5jRnGFcR40BmeGeWElp+p4oZ2UPQSELhEJmpNR2YLIa6nspD
	 Rqz7JMRa91pQL1pevkFjFuM087F0PkrpUKStdgk5oskaJD4KXT0dk5oWpfliba5uUTg7V
	 zjEN77OTCSfEYsAtiES8KqXHOo20SVQ3eekyGNeQdKVCAAJm3rMoStwvVgBz+FTqZXQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=QfPwyHO0;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794595873;
	bh=6/ktnGnY/mRYwWJ9Ya+j+jxNM0OvCdzSIpo0DPl5eNo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AwjEgj0E0powoL1yjpYTMw35OnTV/yLezkPuwmk/14nL+q1VzOAK+y5hooQVggTM4
	 XDynQ3hAHs1lt/iRQLCeXwHUwSj8xAvzYrPZS4peV3Luqy1kT5tqnbyNC2QknKynVy
	 jvHRN2w1maPi66GdIznPvH9ilfJF12NlnNVH0iKoM2RqScDuM8t/FixpSLyE9RWBfh
	 AHzfpIjaws5J5uPJ6oLeqnixqAJmomuK1nkLB6p5BGp6FndBxZfsQC+shgtZMj13TK
	 rL9q0L5bKz+6SciTnItoH9GsYC6FWHcxMmroAfvN1wKnJtAf1UsmGvupF7/5Dlj9xQ
	 UHeBgXFAxOuZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9615640E1D;
	Fri, 13 Nov 2026 18:51:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 64FE92E5
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:51:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 55A9740E1D
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:51:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ysXiLiwFKHTw for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 18:51:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4E44D40E19
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=QfPwyHO0
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4E44D40E19
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/ktnGnY/mRYwWJ9Ya+j+jxNM0OvCdzSIpo0DPl5eNo=;
 b=QfPwyHO0BmDCMaio48BeVh59TzSoQf5vtPfbsRuTdFA6cwujF7fFxPvT51fkZIqlJFjd+Y6gDds74fxd1t54aAIbhvkUAbKJ8vr2lw67kVJovjLmb08c4BOESzN+La636fonIY294/XJc6NyUnRZxsMS38cVAWVenVaNQIJIu54=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM7PR04MB6919.eurprd04.prod.outlook.com (2603:10a6:20b:10e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 18:51:06 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 18:51:06 +0000
Message-ID: <6048ee05-b6ef-4979-b4e1-23ef0f7d3ee8@cherry.de>
Date: Fri, 13 Nov 2026 19:51:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] board: stm32mp25: add splash screen with
 stmicroelectronics logo
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20261113172541.473641-1-dario.binacchi@amarulasolutions.com>
 <20261113172541.473641-3-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261113172541.473641-3-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0033.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::46) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM7PR04MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d36972-1aec-4601-f244-08df41b712b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|261102123227099003|11063799006|4143699003|56012099006|261022075727099003|261021135927099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261022105027099003|261021121427099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: W7qakrgg8j7wZvCNfMblvdPG3wN7xZY7ie8PfcLT09zLAcjhuCyAeJPAcre0wmttwawxQkwDUD2hR2gXrt1i62qgM+xLsbynGVZHHWbQhXBBpuOKMYgayP7Vl61z30wIwDZ52wTpcPZ5nUzey59tsxtTwIga0OOhDtcKUxhymK1JWY3K/l4vhhJAqxpJQJQRygzwgV/82qSGB4gXlwFk42huM/D3Ecp2ootoZAb8T+SqvbWa00RuXhTGjfUjP9ARGMwSp4d54fioJFkagHZ94y1dG0Y0V/E2QCu6hq/Hud+M/wQaj6gHiFWJrhNuIX5OBVPd5piqMKsC8n1rcyC2pKZmtRxh4H1pL6td85oKuQ/fMJ9m7mGu/gWzl8PWQB0hWf49X+HIRmec29GLjCYkdytbL036XqKZsNZ5/pc5aJb7wey/WfiXX6ssFO9bSkj9YHUNJOSXycOothQsBz90ncefoRrOctqaxcszIvA7tnCubf1HPoW+p0cro8/cydOX9AMU9ZOpH9rAfjSRX9qcAgTWf85u5TAMBKQSqMgt0QyRmchnP8BNHMmcuL67evfeOWS6ndJvfLFXRhskFZze0kuiuNxRbeARH2PeHdWWohtv0ZH9bIqynyea/30h0bniBQn2R/pGVW0vj3zuAIvdvOV53rKxpNmUi1VaOBE/IQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(261102123227099003)(11063799006)(4143699003)(56012099006)(261022075727099003)(261021135927099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODdHOWc5dUlNUGIwTXNSZ1MwVjczdDQ4S3U2RWVvNzMybDRtZnZhVUtJakdH?=
 =?utf-8?B?V1dHVHJ1ZWtmNitzdjBEUE1VbG9yK2FoWmxCbHZncDN5TDlJKzdGS0M2UXN6?=
 =?utf-8?B?VEV5UnF6UnU1VmZoK1AyZ0hxLzRXTGtBckhpVmphSlRXVmdXQ3JZcG13RnFM?=
 =?utf-8?B?My9HSS8yNHA5b0hYcEQ5dWpkM1BuMHU0L2x6dlZhblhoK2VMRzlZc3FUSmRh?=
 =?utf-8?B?Ym0rRFZxUjNmQUFiUk9MUTdFa1VkTmxkdlFzbHVRM083VVVBUHVPS0tIc3pK?=
 =?utf-8?B?c1ZpRHkyam1pNWVQaUxxUTZPNmxPQkdjY1VlL3UyUTV4bWUwK2c3WG9rNFUr?=
 =?utf-8?B?dXBLNmtwTnFEa2FvQk55R05IZzlMdC8xeWhwRDN2NmFSZkVzbUprMWNzSUhv?=
 =?utf-8?B?NzFTVWFja3hNN0Q2WHQyUlNHamF0MGVXV0xLOG83UG9sK0grVnNMY3FnOGVa?=
 =?utf-8?B?MDZ4NmQzcTN2aU80d0h4QVFQM3MwZ0JoYTl0c0pTT1FxUlpkbU5UMFh3NXRr?=
 =?utf-8?B?c0RDcG9Ha3Z1S3crUkduWGN4b2w0ZnQxdTBid3NTdjhiRGNCRUdlbEh1eVZX?=
 =?utf-8?B?N084aHFReVJkVU1COEJnWnVodXgwSUZiU3BFbGxUb0xNQlVLYzViaS9XOFRr?=
 =?utf-8?B?K0dqRnBhVzBzK2lWT1d2NERzR3dtdjVWUFFaR3Z3ZFlpNmIzcFFJdVlybkpN?=
 =?utf-8?B?bms1MlhTUnA1S2dlTWxBT1FkWU0xMWpvQW16OENwUHhCVGU4NlM3czZiVElh?=
 =?utf-8?B?RjZ0NDFBWVAyalcyMCsybVFQc25iMVdRUlE0Vm1KZEZEMDd0WEsvSTBndlZM?=
 =?utf-8?B?djVQY3M3Q2pWOGxYTW90NVBtYmtlejJsRTkwNDVGRTFHQURjOHIvZlN4UjJh?=
 =?utf-8?B?L1pxb3RuMVdIYlpHV1Avc3dmVzRoSWxpT1hpdlUwREdVWjZ2RXhxUzRZSWor?=
 =?utf-8?B?WDRkWFFqWmVoVVFQSlEvc0JESy9RU3VZT3hPRStKSGM5MmtpSXV6TVNScTF4?=
 =?utf-8?B?cmdsVzVxZndacVRCL3cyOWEvUnhzSi9IcWZ4bno2N0c3UlNWRndwUW01OTJz?=
 =?utf-8?B?Njh2emJXV29XVUtBYWZ0WDIyWVFXbGhGc2gzYzc2ZkJ5WXpmM0MvQnByeHlG?=
 =?utf-8?B?eVk3Ly8rY0dQaHpXTTVsemRPYmw1WUJJVUIrSy9aM2JYYWZPaHdjWE8vbVVR?=
 =?utf-8?B?ZkN5RkVEUUFjdUZnVlRGbmhyVWc2ak9tZUZ1K1hrL2JUdjVjUjZoeVc3S0ZI?=
 =?utf-8?B?NWlJOFBqOXAyYlc2VDJlMmM4TmM0VU9CRTZxcE1RN01HNThSQWtpTkV6MjlU?=
 =?utf-8?B?VXRrUTJiaGhBUDVhbmlMSnkyQXdWZFpxUFo2bkNIZHpISEU3QytOdTd6YkxF?=
 =?utf-8?B?WmpTUUUrc2hEWUhOeWQ3OHZwMXVYeEsyZUtya3JnZ284eVYvRmtJQzk2RFVS?=
 =?utf-8?B?TTVZdWlxeGN0Z1B3WWZVd1FweTB4enlhZUpsQmxnTE5UaXNjWXQ5M2E3S2V6?=
 =?utf-8?B?SU5jOVN6U3RDazZWemJVSU1VVjZqbDBHVlJkejZ1NlJFdkpDU1l6WWViQjJS?=
 =?utf-8?B?UjNyc1JFc1l0WG96R0xLNWRhK0pPV3gxYkFHRHhWeWFBWkpqSFZoQ0UxUGFE?=
 =?utf-8?B?Yk5RQXZkTmRGOW9rbmV6NkdQMnczWmxXUGFibURmTWw0YnY3WUVKYUxCTVlZ?=
 =?utf-8?B?WlArL3VqQXpSNVJYY0VzTVNJaWVjdG5NcGpoRU1Nb0VTMzczcmlVbmdSZDZl?=
 =?utf-8?B?RVp2TGtyUUFkVWV2OVpyU291cnVFc1hDZzhSdlNDTmJvZ293L0NQMDFDekJR?=
 =?utf-8?B?aFplbFdVWDRzOHYzVXZPckR6NklMMXUvM3NnMFYxbkVod3M0U3NzMUN2d1Vk?=
 =?utf-8?B?TkZDRGJlY2ZXMzhUTlNSRjIwM3didjYvSjdJaDdwZnVUKzkyUEtmblhPSmtQ?=
 =?utf-8?B?ZDgzZXdaS1R0R2dKc0U4dTFmWlYvdmV6MUdzaGFlUWZPVjRKdURPcVZFSGVj?=
 =?utf-8?B?T3F2S0VNcnk5RlVBVmNEL24wRlpTZ1RucjIvaXoxcXNveFRzdkpGMVJDckk1?=
 =?utf-8?B?ZkVwWVd4VFFjRmxsVmdwcEhVZi82dDRpUmxHZStXSy9PemFpRVVZSVFUYUpo?=
 =?utf-8?B?Z2ZPN1JWMGxDaEFlemVNdEhtNmVsZU9jNStYWDJ2cWZlQTNFekl2NkFFYThi?=
 =?utf-8?B?RmlnMHFJZmdMMEtHTHc5TG1TL0w2MDlIY21ZQTg4VkJUNk91ZlZteGJsNUph?=
 =?utf-8?B?Mzk4anQvcHpJdjY1MVhSN1N6alY2Q0tTd1F4MHlzVHVhcFJtREk0cU1sSUwv?=
 =?utf-8?B?Q3lrSEdYN1JOL0dnNzlPZWNJSVJqL3BMclZqaUtpTWM2L3BkRFFtUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d36972-1aec-4601-f244-08df41b712b2
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:51:06.0893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EqKO3nCNnzdz27RokGE1GKvh5Q4JagTKRNBvot/h9moUCWbCSTpSPo2FmjR9nw3/hozZx0i9sEqTXBnN7lUhnGxK53QiLLErGs44UXOt3KI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6919
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

Hi Dario,

On 11/13/26 6:25 PM, Dario Binacchi wrote:
> Display the STMicroelectronics logo with features VIDEO_LOGO and
> SPLASH_SCREEN on STM32MP25 boards.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
>   MAINTAINERS                           |   1 +
>   configs/stm32mp25_defconfig           |   7 +++++++
>   include/configs/stm32mp25_st_common.h |   4 +++-
>   tools/logos/stm32mp2.bmp              | Bin 0 -> 7802 bytes
>   4 files changed, 11 insertions(+), 1 deletion(-)
>   create mode 100644 tools/logos/stm32mp2.bmp
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3b38ffee2886..fd0ea1b8c633 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -689,6 +689,7 @@ S:	Maintained
>   F:	doc/board/st/
>   F:	drivers/rng/optee_rng.c
>   F:	tools/logos/st.bmp
> +F:	tools/logos/stm32mp2.bmp

issue: redundant

Isn't that already covered by the N: stm32 below?

./scripts/get_maintainer.pl -f tools/logos/stm32mp2.bmp
seems to be returning what I would be expecting.

Cheers,
Quentin
