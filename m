Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901CF606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LiXumfm0;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=USkRp5sA
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5567605EC;
	Mon, 16 Nov 2026 14:55:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1k_4NpJqt3As; Mon, 16 Nov 2026 14:55:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F232A607EE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794840904;
	b=M72dRNU1q8BWpOXgOYdHKpZXoMvU30kbG+8NYpOdHNGeAMEruzu8i51CCSPblWnOLFO9
	 G+Mmw+Nh+765TNiYCyo193ssPV0x3Fr8Ur/+pb3t45GgPQYl9qsidixsW8Ks8fK8+dtOa
	 GEVRAf01ko2qmLis7BXjTaYmZZKs2YJN3xsJQ3vt1uVbFSQyz541PGOsfllIzCnmxLRza
	 MsSYIBCOBPuCVzvnXNc8pQU1IxLe5SKpL+zH0YbXUvk0EhmDIZJFlBp81dFSqKrT554qN
	 BN2JMGz+049FcHJX12TRj9cZL4/pL+kEkicBtdzeI+OzaTkfpecDibsc7+9MzPHg87Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794840904;
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
	bh=wl2LBBjf7zUWhKPyf+mf4e1vp2xU9QWw83Z513+ugSo=;
	b=mTmHMJhe4V+4PF9iF7/rviiXxU8ft4Fd6jFox2DACSs4BfWPc3kxiyqJLjUFf7gSe1+I
	 fIgXiJKWR96fcOlbgj3i/3pAdq+uV70KGwelADvriEu0W4FC1HuhsJKd0leyQulDWQ9b1
	 S1QGFV0NNdG9LWbxvjiSbZBPWD5tfNhlLrYPRMI+G8ws3EuIhBiToidatN6aCj1cVF9fB
	 MPlr1hTkKFvutrx/ZAeC+YAvepXad8WSSM6K+CclkJ5ymzSm7YD1GDCYtEvYi53D8grkx
	 8J+SLIX7l+tI2X8L7nG0YI2DA6NeQ0MkHAmRm4ZKQcEmBwfZaU13pnKSE/Bm6rXcoeQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794840904;
	bh=wl2LBBjf7zUWhKPyf+mf4e1vp2xU9QWw83Z513+ugSo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LiXumfm0IXm/k7zDjvedUXOWJKqfoinMMq9WqrCru14EyWkWqrLO5H44m6PkF3uon
	 hBgMZhRWCzc+9bVfDwrNCfybpdKdjmHhSXm0B5r8m8YdlTzbKXQx7VaeTEGky2aQVc
	 jxgIpgCSHyD9TfX3I+QVzW9ofk3WU0+TLttXB88nH6KMVekk6H1G+U6tvig1XUBr6t
	 TuQrUVntUJNx9ce0llYDTuI2JO7wectjjiWvyk3T4z+MOPPp3DQq2DmDjcDdwtaXbU
	 ms7BYzyLvCWdqoqqx24OAuKOvprid4eZduasc0pemE5RciUP2V6WhMnvD+brtf2OAl
	 9wQh3L0wwNMXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F232A607EE;
	Mon, 16 Nov 2026 14:55:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 53F18169
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:55:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 39BDA406E8
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:55:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aux-3cTpWH91 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 14:55:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CEC4B40598
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=USkRp5sA
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CEC4B40598
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wl2LBBjf7zUWhKPyf+mf4e1vp2xU9QWw83Z513+ugSo=;
 b=USkRp5sABQm/rG6Oa2mDDD+5LPwTxbENZmYILC27Q2bkXJXkg7OTXhAozxvFHTZN+1VBB8UupBEddV81ZUi/j3gfplypuVlerUkMpc+mSOdcrVdIynKMULK+iW32MbwBfPz+Y0IcHBdTS4tOKpQWmgzvdsgB/oG+iGSph21TEhs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by BR2PR04MB569136.eurprd04.prod.outlook.com (2603:10a6:2c8:4::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 14:54:58 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 14:54:58 +0000
Message-ID: <0c1a45bc-3779-4457-b35c-e25ad3c534b6@cherry.de>
Date: Mon, 16 Nov 2026 15:54:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binman: Fix SPDX licence tag in lib/binman.c and
 include/binman.h
To: Dale Wilcox <wilcox101@gmail.com>, u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, trini@konsulko.com
References: <CAKtUr1Uu3rg9KMAYtqOnYNo=ONu=X9XpDbEvn0tcEyZFzP5=iw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAKtUr1Uu3rg9KMAYtqOnYNo=ONu=X9XpDbEvn0tcEyZFzP5=iw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI6PEPF00000209.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8d7) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|BR2PR04MB569136:EE_
X-MS-Office365-Filtering-Correlation-Id: 6821f6f8-19a4-49f5-c7be-08df43f1955e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|261009223027099003|5023799004|11063799006|56012099006|10067099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022113327099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: 0ynsMXe1n+FnrPF+EPAnrFG20/Vylua5M9he/tRIs8f0/qSeeoQwHQDUyg+efSXw4w6joKc/dZCqd3k0zfEdy5GhyLwfznT9qN4m3Altk+7o/6RSwp8aqZBbLhqXo4R9WnRTMQ/8eN8RcZLX7fD1YG7kcqNrmTbZOpVXnuQpH+BachVXB2yTF7ewBcgkyQb/ks3CHCDLmUvxOU5E6otTiay1cm2txSOy2kVaqd8OxKvPPAEhetOxcNoLcCGl7qX+19ODgONfQ7hrB+scEyv8u/FEFTTK/ebTiZ25DnbAHxYpsHPktsVzExqzq+mq2guASJpN/reZo4Pkr3tkD+bllLNUKbdRzRaHxKDzBc6h0dybQkLQVYhyU5VBaRkec72DypT9ykpotX67YoZp6j4fDrvgya5eq+3gJJCR/2r5nZ0Q2rpTwdv9E71191gBZ2as5yoTfZ12HfNFSNU2v6guc8hwG7l9n+H4Gh9/9GtYZdzqbhjdbV05mT0i6MpwDbjVf1nkPPKLt2yWyCud6VzQVIqUCIRB7wtCvSQ6BKTqdCJJVHUJJ7BhDUwdpUCgCQvPDMqxbPH/z4SRfJH+/V30NEgi1DjZj2HxY9bnnJqrsBiLkhVNBIZzyC5hK83+eaV797LMuHKTvL2lqzZnGFWNhBBt2McLs8z8mNGgJPSNYvs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(261009223027099003)(5023799004)(11063799006)(56012099006)(10067099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022113327099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWtLbmpOY1RmMkU2QmozeUl4c1VUMlRqSk1udGJtOWNrZXVZWGJXWERGZHo5?=
 =?utf-8?B?aUtEcURva3lZcVlBZlJkY0RrcUZBZ1pSWHk0RUtGVkdIRGFnNmRLL21HUHQz?=
 =?utf-8?B?dk8yZGp6dCtEYllYTFl3dDc0bS9GZ2pDSkp3VDdkckw0OUxKNmpQam1iYVpz?=
 =?utf-8?B?OWtNK29Ub1Z5dnVxaTltdGtZNlNZWGJWd1hCRGFGMGZUSHhRcTVUWWY4WVZn?=
 =?utf-8?B?Unlwc0Y3UHhhejdaeFl2b1JoUGpEdUNXTG1lV0JGMWdPZERUMkErZEtuMDd1?=
 =?utf-8?B?dlJHSFdrZU1PbzN0K3A2bXNlZEVxMVF0WnFmWU54cUFFd3pENmQ2b1BZRGty?=
 =?utf-8?B?ZlVKZ2dsV0s3bnAzWGhXRzJVTTNxMFpZWjdmU0JLVUZPTnJEWUo3U3ROb3lS?=
 =?utf-8?B?djNyekNmSisxYlNRSkxaSUFBeUE4ZWtYN2g2ZTdza1pueUk5Y2pPMUdzTWFR?=
 =?utf-8?B?M1IzclJDT1Y5RVVwWlNkZVdwWTN6eFMrVUR1dEhWUmFZdUFMWWFQeHNZWURW?=
 =?utf-8?B?bGI4OHFualY4Qk1UNjlTM2poTUhQSEdMRXNUV2pNQ1lJZ0dXLzg2R3k4ODdt?=
 =?utf-8?B?b3lmN1ZuNTFxbmRxVGQ0QSttWVdPL3pFSzAvYU9mRC8xNUdmN01HMDdqT01p?=
 =?utf-8?B?Smk1S1NrVUZZVjRnRE9jZm1GSG1aYnpGTmpEU2swLzZXWkZ4eXMvTVU3NXU1?=
 =?utf-8?B?OUZTNmIwb0ZNaGJ2VWlRMlY4ejY4MHA4ekFrZ0piMFFlS29yTmE3cjE0YUR4?=
 =?utf-8?B?RmpBQXcwU0loZTdsWnZiY3I3V3lhcXJyNS9XSXhZUEhncmZrSnFTcWFyM01l?=
 =?utf-8?B?TzZRWkQ3dzA5d0Z0UjIxOTdGQUNpN0N5bWdNOXFuSWtOWUNhdm1qdGpFaEdZ?=
 =?utf-8?B?MDVnOUFickc1OFk1UExKQWdtQm1XNUx4ampoWWd1ZFFYSk1KNlg1QUxlUldX?=
 =?utf-8?B?cDMyOXNkck84cmxqTzBzbEpSV0gxL2M4YlU4aUU5cUE4OVUrTmlyL1BuMjg0?=
 =?utf-8?B?Tm5GdnhPMkZjbWxrNFdDNFdNQWNxcG9zV2VwZ0hhWEpxdFpGeFpSbldrYTZs?=
 =?utf-8?B?bnVtZE5nQVcyOW5zaHZOdW9tKzkzOW92N05WcmtMTEhCaEs2Sk1aRHdaTXBX?=
 =?utf-8?B?MlQwNlN5WTlObVNtdU8xakhSSWZsVERuZlVjNUJSdTNYUVgrQmxXQkNLbERo?=
 =?utf-8?B?Sjl5UTdwa1RMaWVuZTc0TE5GYTJ5bzg0aWlValVjQmVZRXZpbFNsTVVnRUZv?=
 =?utf-8?B?UDBacUhQdFd2NXBvUGtHOVBYWUR0VUdGaEp3YlpMNVdLdGo4VThFVlFnYTVS?=
 =?utf-8?B?N0lhb1NpQmpEcG96S2JYbmtaaHhZcG9XVzU5cDhYNStKb0ltWG5FNTN3clAy?=
 =?utf-8?B?aFczUVpIQ1piaU5RRzllVjJ1RXFVaEI2RHpHUGRxa2pQb0Y1MkpDclI0Q01w?=
 =?utf-8?B?V1NoQkYzeThWLzZtN21PdlkzOCs3OGEzOHhoVDZrUW5GYzk4bFduM0UwdXFu?=
 =?utf-8?B?UlhnR1Y2VWNpbnJzWEtpTWE5NFpGcTc5U2RaYUQ0Rkc4aElGNDhJbHlkR2ND?=
 =?utf-8?B?WVUwTncwUVZDeTZKb1JIU1hGUnFxK3IwQmpFTHdNYUFMeVUyZ1VrTVlUZGcw?=
 =?utf-8?B?b2xtY1pyZllJMmtGUzJmcHFISFVSVER1dVVPVndTeEc5Wi90bWsyaXhpTGVa?=
 =?utf-8?B?ZnRDSlg2R1dWWVBiT0g0R1NPcHlDV0xPbE4vcGpNcDU3QlBGK0lmZ0taZzNp?=
 =?utf-8?B?TlBXenhGbG1VcEdWRTZ0d0dTRTBFNHVBdk1HemZJUHkxSUhTaWdHOXZvSlZ5?=
 =?utf-8?B?Ym5kQmY5T09IRFhRUU0yeEVNeTN6ZmVEVEhSZDVnVFYxTEJKQWFRQ1gvU2VI?=
 =?utf-8?B?T0FtVGFvTS94bWRKYVNVRDB1R1g2N244cDNzdWtxWHFQSW5DUmJjeTVsanNl?=
 =?utf-8?B?Y0llU3FROEdsRjlYVW1zQ3luWk00c29zR3hoSHFKS3JyK285blVoNTI0WG4w?=
 =?utf-8?B?UVpwNzJxRHVpMWVrRXBINGNNRzRZQ3pUbktPRUh3M3A1TGZrYjRCYlArQ0xF?=
 =?utf-8?B?djlacnJGclFwZ3BseUpDdFF6N24xLzFZWVFQdVNSTitDTlNOdmppbENpaFo1?=
 =?utf-8?B?dnNPRnhlazJrUHpVcCtOQ2swQkZKdytTZTRHdVBjZVhzdGY4RkFYYmo3ckFp?=
 =?utf-8?B?MzV6VW0vNzUzWGp1STlIMzF0bDJTR1Rick43R2hlbEZjQVk1Sk04eWNUc09V?=
 =?utf-8?B?L3VSU01UUFFDdzJ1Q1VJYlFGUEZBclpOMXFQcTB3VGNPbzMvQytUOUpUR3FN?=
 =?utf-8?B?dkFNbmJKaFBQa0pkQUMyc0hLWUlaaHQzM2ZvNzBmNGtRTS9YeStqUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6821f6f8-19a4-49f5-c7be-08df43f1955e
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 14:54:58.3994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /aP+J1wqkMfYo2us/pt9WQRX2dzxPKcEQKY70fdu2Prglfin8IjnulWRMdPCJ7tQexgIJCuQg09FiOmtp2CkXDe76ff+G0naiBcFHv+W57E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB569136
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

Hi Dale,

On 11/16/26 3:49 PM, Dale Wilcox wrote:
> You don't often get email from wilcox101@gmail.com. Learn why this is important<https://aka.ms/LearnAboutSenderIdentification>
> Both files have carried "SPDX-License-Identifier: Intel" since they were
> added (between v2020.01 and v2020.04), although their headers say
> "Copyright 2019 Google LLC, Written by Simon Glass" and the rest of binman
> is GPL-2.0+. "Intel" is not an SPDX list identifier and has no text in
> Licenses/; it looks like a copy-paste slip. Simon agreed on the list that

Source?

> the tag is a mistake and offered to ack a fix, so use GPL-2.0+, matching
> the rest of binman.
> 
> This patch was prepared with an AI assistant (Claude).
> 

Do you *REALLY* need an LLM to change two lines of comments?

> Signed-off-by: Dale Wilcox <wilcox101@gmail.com<mailto:wilcox101@gmail.com>>

This is not a proper signed-off-by, please remove the mailto: part of 
the line, you have ample examples in the git history of the project for 
how this is supposed to look like.

Cheers,
Quentin
