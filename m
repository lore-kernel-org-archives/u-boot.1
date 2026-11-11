Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1776606A32D
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=blWHAwnG;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=T3fTfq3T
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B6D460677;
	Wed, 11 Nov 2026 13:30:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6YbXEjTcw7b9; Wed, 11 Nov 2026 13:30:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B373D60893
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794403856;
	b=aIgXNOG8S7ljCWITG3RFTxme2YJGJrgl+txEkMnNN6aJssv5+TBbXkldCQlswrIW0E2b
	 oPbRadcNwgriydzEKbxYohqB750XmZsIoStWPcAbCVBy5OJn0gFDhbRfUTav/WIMrziJ8
	 vFHBbZlCNrea8N/xIcRT5Eu8x7tFROepZB7tzDs5DTVvy9+ZSRSg1dh4g9PxJEWFYnyWD
	 +4ooCR8YoILD7saSctkXxDZul/UTlS0v5m6CBcGht3RRGfsgs4MIChZc3MQ6nFc0SW1MG
	 Iqsb7XkOYTE9fXP7XErDs2vulpgrUMKGBeIq2kBHDdsO21e3fkTdecoMfy5z5ONS+0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794403856;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	bh=8urStScceWSSDfW2i121rEepfUrvs2z082qrp6oZitA=;
	b=hIKnwWfU9Vo6Czrxjt9OQZ/A2H2OcsEptf9xraICWgP/kSjM+W6UD/WMXn5BUA6431v/
	 xQQdRqNn7n4B0i4dZUNGzIMxKAcxeVN+/ZLCLQSRiJri+wwh0NPOvGb9uSjU3NU/Ua/tm
	 1QV4CgxGs7Me1lP6RbOR11nesEnkrzmg5j399BSNheE8hI7lfUO1lUW/m2HMNJPuw9z1g
	 fjelPepYuj9HxbXNwrHqrJProK1UiONeZk1dg1E1sJDmMa9yBfYYW/Yne0HOGfwhShBPn
	 WN4uuaiiBSxG3BXR2TjlZdyhDvkG014cmizZwL6iuzfq959mHI0l8JFSg4RQ3oN5hiw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=T3fTfq3T;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794403856;
	bh=8urStScceWSSDfW2i121rEepfUrvs2z082qrp6oZitA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=blWHAwnGzkzzOcuoAYAODGwM19gB6f0qe5TcDIufV9MRO8qFEw0wQKYPWiXq4c3tF
	 7PMUvTjKlCab19f50kZ1X/vEy1fbzG21YkglNwfIsdZi3iSTausBjZ8opHUShbJuw9
	 aSiogBv2+Zd2ltrN3bESLvWUkh4wu/qGHIC85VWnaiHyuJA0VCXLPjq5HmjSCzOmsb
	 gXXp5alh2SXIT7RWMJ2j2k7aV2tRXr5e4NEgwhRLlQKiq4uhLHZ6Q1WYFTBJxxSuRJ
	 ev/r6kijbuFVX16J34h7aiN1RCIDvpCjRDfOng4z7OZ4sDJChQqiuJJ34oLiihwDU5
	 KFnllEmDCx9MA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B373D60893;
	Wed, 11 Nov 2026 13:30:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 489702FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:30:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3A5DA60677
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:30:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rJv9V6VdZ6EX for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 13:30:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C93B960893
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=felix.moessbauer@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=T3fTfq3T
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C93B960893
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8urStScceWSSDfW2i121rEepfUrvs2z082qrp6oZitA=;
 b=T3fTfq3TvFJ2AqWV9ZjuMghS4hgmkqWlDyxppFFTXg+O9j1GM12Tmlg9riCueanViZnCajPgNFBBm5R3OkmlMqZZJMli9MIi8yRTQ9IBPssxQOH430Nl6Iw3Xk9fjtRFbKXuwq4Jad8LJdRatw1dIqjj80CCiG3mSVqE7uj5KZIUa6QuY5ln3CxNirhdw2uJM8cBCMqqK4Z80E9Ct16+42zUVxI0iXKNyUKsnmRrAeGNxmd0aNjaKoaYRBO5hDK6g5Iuzokg9RU3TFDjO+N5ogocc5VfCXtW0ev8pB/fVy1bpG8BVNhkoFlpNANQZYCkYKCYQS4uI2rv2/TjCXt0Tg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by FRWPR10MB9356.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:187::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Wed, 11 Nov
 2026 13:30:51 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 13:30:51 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, jan.kiszka@siemens.com,
 Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH v3 1/5] timer: provide the counter end value
Date: Wed, 11 Nov 2026 14:30:25 +0100
Message-ID: <20261111133029.2538132-2-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111133029.2538132-1-felix.moessbauer@siemens.com>
References: <20261111133029.2538132-1-felix.moessbauer@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3956:EE_|FRWPR10MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a82695b-bb06-4897-a7a9-08df3ff800fc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|10067099003|55112099003|3023799007|261102123227099003|11063799006|261009223027099003|261021121427099003|261021123027099003|261026121527099003|56012099006;
X-Microsoft-Antispam-Message-Info: skOzt7HtqgYGqRhOHopu8nPmrWb5wYL9cdiRQe934Iw40zwWGk4b/aaGZIaj6WZ7aRMDvr6CBssINpLrRiugjUNrUcGiZ12H+OooJ0Ghs2kF6cu78ESiwr6SMkEbcEuflpyEYyna6K8BG5GHr1KDNyvwSmdTKkkmFqsZiAFu+eu/vf0IlruS2UFsRkG24dN9gGbZ3cxzTtL4vSrlktJ13aCWY2vLvjy5V3U4F5bI4n88b+tCHnxXJnnyvjQ5pQO1b0h+HwicunV5RVpLZvwbditiZuE8l7S6HgONlC/HC+RuhR3jQr6o1lRIVDTa6X6vhDaa7ukBj23N3z0KMSFMCKIrucExTbbviv7vkN+w7MGFY+bx848fIjzrPWQeTaIOoa+9qmXyrWTy9Oo1xo+4wGSZdAqph2CtDuSYZl6XFO44t4ZphOxCjrU6k93egpGQ8POYw+Dy8fQbL+IFRUQf3pSHy73pmTGsLOlA9PL5kV0JayhlpKbIX0jHT8c9a+Lrikk/U012U8WSzDAhPTBLqhpOATdpTXOLDeTi9Zy2NyI3ZigekoZ3fhivF6UujA+hMFVkpAuj1s+sRd00No5IWOgkBh6nBNXr8ix9cjo2SKfCehDIz2XOAOkdpnePWCMFSbepYklYR7cL8rGFIk9jpFNE5t94gB/si47x7V0d4rY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(55112099003)(3023799007)(261102123227099003)(11063799006)(261009223027099003)(261021121427099003)(261021123027099003)(261026121527099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mSpJgjYk28OySj/Xw9FA/Go7HB1BS7Kf62c3b/Ln07xX+RQPL9qKMmPQecBf?=
 =?us-ascii?Q?TMHenNsXvj96zeWnctxf6UJePuiREFmT7J362LkaxR2eFIQhHQCd2aPmAi7s?=
 =?us-ascii?Q?bmrLnARTNItaJORKpsSM+5ORyxW8XA39zKv0L9IRinhS2o5yTPxalS8vYya6?=
 =?us-ascii?Q?ZwEd79AEtHAJDxYBqFB7pN78mLfPolGbGQauorTwMhfKzdTkHTnfHOS7jUjw?=
 =?us-ascii?Q?ZKjcmm01vsYGTEJa9yBxNklzjYDlG5baIMWbZNpaVbk95Y6NpUZhYGjNON5z?=
 =?us-ascii?Q?48huJCrr5k4wXB1K+sHeqQ/hqHQJEYl9yBQcXdqBaY7HqFNAxk2O7aJVz7e3?=
 =?us-ascii?Q?TUipmO9udigtg7GsARqUSwMu5mTUBL6XgQ6V+mw78OOrQQgdkx5K/BP1FeLu?=
 =?us-ascii?Q?7owIyzZ7lEPTZ+A+KuG+H3BXVmy/xBF/iHstW9Yu7EWGXHQ+hhsKBw7JpbZg?=
 =?us-ascii?Q?UER1shSUHT4wFiRHcBDJiHrpUDtdjzE09MFpUEu4NjcBGCjfjpBjBBEbu4x9?=
 =?us-ascii?Q?3n9EX/Qvo+HztzhJ8XDEEP8ZRrZyNh8poIgoRnaNXT6qEtSNePbZTIzBuKt5?=
 =?us-ascii?Q?o+LhaT3izl+H4fUOvSP+J3Utcfo+OQsqKGIjMqUPEv4XhjEphYp32A/9NeDW?=
 =?us-ascii?Q?6PaphyW+1/LIraChzdqIcgIAS5jHviRDEmGKLhV7QfkNLm7Mwq5NeKwAdu40?=
 =?us-ascii?Q?HRTq4Islk6dkR2oPJsHPUH/6b6bZxDRfDYENbcxKbDDeNMPu+bQgQ3Em20PS?=
 =?us-ascii?Q?sgQI0vrRRALzx77cyYFD9bORoBI4V0TqJqaqLyYIwgl0bxVZ6eJlYfcYPC8V?=
 =?us-ascii?Q?tpxbJY2XxO4pj0VgXj33f+q+Gq+07xn9qByfkCGOwZh1HN2k+Noc/DhDPILE?=
 =?us-ascii?Q?70+rnFLI57Ph0xMIeRp8FYnk9aIvRGYvLINQ96p7DIzggKjNznimabxHshZb?=
 =?us-ascii?Q?kYfdcP15CUm4hVLKWolCzEBIsZyER9dOB9/4uYJmMP7wWlkNm2RS2n2AKw+1?=
 =?us-ascii?Q?bP41q1PreSpGdi5FNaNN5X7Q68DNsx68zzTok0iV6XzyiGJ+UlaqW0bnnOCF?=
 =?us-ascii?Q?1hAczieplKBaEL2onbKcjlen5jhf8HfHQwffg5+sVrPBmXZqyzr/KFvXiYZo?=
 =?us-ascii?Q?8QRFllY3HM8v4/H1IburlHIl8YnpNdsysxrpteXNwNbqqBrC7RhBfZ2Wn2Tu?=
 =?us-ascii?Q?NPwF0coopydV2vctydXheiNK8HBSYb4rCgVZQ48heNSoZH86nzZvkGjgBYW4?=
 =?us-ascii?Q?Y+Ab39V5cJWsNqueThOt0p0Y0gtkXL/BvNNyrm42w4K8WM/f/mlZSBPO5dNu?=
 =?us-ascii?Q?j2DWq8ewhfgeYcc+C8r1pIFCHyNOmDSlmIXqJdezZ+9RGupjF/FjJ2I5pDS1?=
 =?us-ascii?Q?tRL64SBQs4TNOErGgC6Q75ZVeA2C/PSDPCGyLh3g2VlILQBWagwYFysv9E6j?=
 =?us-ascii?Q?9mudlLR/bJI9FyekdAAEyH+o8xuRvf+w4B2zKTanrm5quNMKESAQmqzSVy2M?=
 =?us-ascii?Q?+yufUylh4bzrk5WUlCVoU08g2im6U6BVWsFI55AQ+KtN65SzlMm572OXh3FM?=
 =?us-ascii?Q?3oiJIEViJyuAF9dR55hhR8RIVhFJLosoJADPp/I3Flc4xqGIplXLH2OwYzkL?=
 =?us-ascii?Q?NvsdEfrv5jgd5S8q/5PaIER+reJauC2kPN17DSpp/5xZsmF/fKkQNKnUhaKi?=
 =?us-ascii?Q?n6n1C3HUhNxyI6KKzJ1DqrfdoNjhsiqfGjxGyZ8MGbAyzl6mPuyhaTLXqA0w?=
 =?us-ascii?Q?cnyytIsOvB+/eC+Mep0675/sXq547gg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a82695b-bb06-4897-a7a9-08df3ff800fc
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:30:51.1897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUAM3lkIPek8e810eO3H7wSFFdYMw5NKBvQq1quymf4zPAAIZau9+IbeAlRkEJcByYLJ5e6SuqQMs2QiqwQZ2/P1slzfZsnWof5cFO7BRFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9356
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The timer is usually a free-running up counter, but its width depends on
the driver. Some drivers extend the hardware counter to 64 bits, others
return the raw 32-bit (or narrower) value which wraps much earlier.

Add an end_value member to struct timer_dev_priv holding the last count
value before the counter wraps to zero. It defaults to U64_MAX and can be
overridden by drivers in their probe function. Provide the getter
timer_get_end_value() in the uclass.

Also add get_ticks_end_value() returning the end value of the counter
used by get_ticks(). Without CONFIG_TIMER the generic get_ticks() extends
the counter to 64 bits, so U64_MAX is returned. The function is weak to
allow architectures overriding get_ticks() to report their end value.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
Changes since v2:

- added this patch

 drivers/timer/timer-uclass.c | 15 +++++++++++++--
 include/time.h               |  7 +++++++
 include/timer.h              | 10 ++++++++++
 lib/time.c                   | 13 +++++++++++++
 4 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/timer/timer-uclass.c b/drivers/timer/timer-uclass.c
index 8305f06d318..e784025884e 100644
--- a/drivers/timer/timer-uclass.c
+++ b/drivers/timer/timer-uclass.c
@@ -27,7 +27,8 @@ DECLARE_GLOBAL_DATA_PTR;
  * the input clock frequency of the timer. The get_count() method is used
  * to get the current 64 bits count value. If the hardware is counting down,
  * the value should be inversed inside the method. There may be no real
- * tick, and no timer interrupt.
+ * tick, and no timer interrupt. The end_value member of struct
+ * timer_dev_priv holds the last count value before the counter wraps.
  */
 
 int notrace timer_get_count(struct udevice *dev, u64 *count)
@@ -48,10 +49,20 @@ unsigned long notrace timer_get_rate(struct udevice *dev)
 	return uc_priv->clock_rate;
 }
 
+u64 notrace timer_get_end_value(struct udevice *dev)
+{
+	struct timer_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+
+	return uc_priv->end_value;
+}
+
 static int timer_pre_probe(struct udevice *dev)
 {
+	struct timer_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+
+	uc_priv->end_value = U64_MAX;
+
 	if (CONFIG_IS_ENABLED(OF_REAL)) {
-		struct timer_dev_priv *uc_priv = dev_get_uclass_priv(dev);
 		struct clk timer_clk;
 		int err;
 		ulong ret;
diff --git a/include/time.h b/include/time.h
index f5b86bf70fe..5318346dcbd 100644
--- a/include/time.h
+++ b/include/time.h
@@ -158,4 +158,11 @@ unsigned long timer_get_us(void);
  */
 uint64_t get_ticks(void);
 
+/**
+ * get_ticks_end_value() - Get the last tick value before the counter wraps
+ *
+ * Return: last value returned by get_ticks() before it wraps to zero
+ */
+u64 get_ticks_end_value(void);
+
 #endif /* _TIME_H */
diff --git a/include/timer.h b/include/timer.h
index 091d8dfa228..e0e2e8bbf90 100644
--- a/include/timer.h
+++ b/include/timer.h
@@ -62,6 +62,14 @@ int timer_get_count(struct udevice *dev, u64 *count);
  */
 unsigned long timer_get_rate(struct udevice *dev);
 
+/**
+ * timer_get_end_value() - Get the last count value before the timer wraps
+ * @dev: The timer device
+ *
+ * Return: the last value returned by get_count() before it wraps to zero
+ */
+u64 timer_get_end_value(struct udevice *dev);
+
 /**
  * struct timer_ops - Driver model timer operations
  *
@@ -88,9 +96,11 @@ struct timer_ops {
  * struct timer_dev_priv - information about a device used by the uclass
  *
  * @clock_rate: the timer input clock frequency in Hz
+ * @end_value: the last count value before the counter wraps to zero
  */
 struct timer_dev_priv {
 	unsigned long clock_rate;
+	u64 end_value;
 };
 
 /**
diff --git a/lib/time.c b/lib/time.c
index 0e9b079f9cf..d9bce303e6d 100644
--- a/lib/time.c
+++ b/lib/time.c
@@ -111,8 +111,21 @@ uint64_t notrace get_ticks(void)
 	return count;
 }
 
+u64 notrace get_ticks_end_value(void)
+{
+	if (!gd->timer)
+		return U64_MAX;
+
+	return timer_get_end_value(gd->timer);
+}
+
 #else /* !CONFIG_TIMER */
 
+u64 __weak notrace get_ticks_end_value(void)
+{
+	return U64_MAX;
+}
+
 uint64_t __weak notrace get_ticks(void)
 {
 	unsigned long now = timer_read_counter();
-- 
2.55.0

